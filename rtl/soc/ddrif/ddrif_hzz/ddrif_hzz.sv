// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      ddrif_hzz.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Repository:     http://10.137.20.23/bcrc-soc/tj3.git
//  Author(s):
//                  Bruce.Wang (ywangpvg@fudan.edu.cn)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

`resetall

`include "INC_global.sv"

module ddrif_hzz #(
    parameter HZZ_DW = 256,
    parameter APP_DW = 512
)(
    input  logic        clk,
    input  logic        rst,

    input  logic [HZZ_DW-1:0]   hzzs_mosi,
    output logic [HZZ_DW-1:0]   hzzs_miso,
    input  logic                hzzs_mosi_valid,
    output logic                hzzs_miso_valid,
    output logic                hzzs_mosi_en,
    output logic                hzzs_miso_en,

    //  UI2HZZ FIFO
    input  logic [APP_DW-1:0]   u2h_rdata,
    output logic                u2h_ren,
    input  logic                u2h_rempty,

    //  HZZ2UI FIFO
    output logic [APP_DW-1:0]   h2u_wdata,
    output logic                h2u_wen,
    input  logic                h2u_wfull
);

    //  For example, when APP_DW = 512 and HZZ_DW = 256, HZZ2APP_CNT_DW = 1.
    localparam HZZ2APP_CNT_DW = $clog2(APP_DW/HZZ_DW);

    logic [HZZ2APP_CNT_DW-1:0] hzz2app_cnt;

    enum logic [2:0] {
        HZZS_IDLE   = 3'b001,
        HZZS_RD_FCH = 3'b011, // read - fetch data
        HZZS_RD_ISS = 3'b010, // read - issue
        HZZS_WR_RCV = 3'b101, // write - recive
        HZZS_WR_ACK = 3'b100  // write - acknowledge
    } hzzs_s;

    logic [HZZ_DW-1:0]  mosi_r;
    logic               mosi_vld_r;

    logic miso_wack_vld;

    logic [7:0]     hzzs_len, mosi_cmd_len;
    logic           mosi_cmd_wr;
    logic [53:0]    mosi_cmd_addr;

    assign mosi_cmd_wr   = mosi_r[HZZ_DW-1];
    assign mosi_cmd_len  = mosi_r[HZZ_DW-3-:8];
    assign mosi_cmd_addr = mosi_r[53:0];

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            mosi_r <= '0;
            mosi_vld_r <= '0;
        end
        else begin
            mosi_r <= hzzs_mosi;
            mosi_vld_r <= hzzs_mosi_valid;
        end
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            hzzs_s      <= HZZS_IDLE;
            hzzs_len    <= '0;
            h2u_wen     <= '0;
            h2u_wdata   <= '0;
            hzz2app_cnt <= '0;
            miso_wack_vld <= 1'b0;
        end
        else begin
            case (hzzs_s)
                HZZS_IDLE: begin
                    miso_wack_vld <= 1'b0;
                    if (mosi_vld_r) begin
                        hzzs_s   <= mosi_cmd_wr ? HZZS_WR_RCV : HZZS_RD_FCH;
                        hzzs_len <= mosi_cmd_len;
                        h2u_wen  <= 1'b1;
                        h2u_wdata[HZZ_DW-1:0] <= mosi_r;
                        hzz2app_cnt <= '0;
                    end
                end
                HZZS_WR_RCV: begin
                    if (mosi_vld_r) begin
                        if (hzzs_len == 8'd0) begin
                            hzzs_s <= HZZS_WR_ACK;
                        end
                        else begin
                            hzzs_len <= hzzs_len - 8'd1;
                        end
                        hzz2app_cnt <= hzz2app_cnt + 1;
                        h2u_wen     <= & hzz2app_cnt;
                        if (APP_DW != HZZ_DW)
                            h2u_wdata <= {mosi_r, h2u_wdata[APP_DW-1:HZZ_DW]};
                        else
                            h2u_wdata <= mosi_r;
                    end
                    else begin
                        h2u_wen <= 1'b0;
                    end
                end
                HZZS_WR_ACK: begin
                    h2u_wen <= 1'b0;
                    if (~ u2h_rempty) begin
                        hzzs_s <= HZZS_IDLE;
                        miso_wack_vld <= 1'b1;
                    end
                end
                HZZS_RD_FCH: begin
                    h2u_wen <= 1'b0;
                    if (~ u2h_rempty) begin
                        hzzs_len <= hzzs_len - 8'd1;
                        hzz2app_cnt <= 1;
                        if (APP_DW == HZZ_DW) begin
                            hzzs_s <= hzzs_len == 8'd0 ? HZZS_IDLE : HZZS_RD_FCH;
                        end
                        else begin
                            hzzs_s <= HZZS_RD_ISS;
                        end

                    end
                end
                HZZS_RD_ISS: begin
                    hzz2app_cnt <= hzz2app_cnt + 1;
                    hzzs_len <= hzzs_len - 8'd1;
                    if (& hzz2app_cnt) begin
                        hzzs_s <= hzzs_len == 8'd0 ? HZZS_IDLE : HZZS_RD_FCH;
                    end
                end
                default: hzzs_s <= HZZS_IDLE;
            endcase
        end
    end

    logic [APP_DW-1:0] miso_rdata;
    logic u2h_rvld, miso_rdata_vld;

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            u2h_rvld   <= 1'b0;
            miso_rdata <= '0;
            miso_rdata_vld <= 1'b0;
        end
        else begin
            u2h_rvld <= u2h_ren;
            miso_rdata_vld <= u2h_ren || hzzs_s == HZZS_RD_ISS;
            if (miso_rdata_vld) begin
                if (u2h_rvld) begin
                    miso_rdata <= u2h_rdata;
                end
                else begin
                    miso_rdata <= miso_rdata >> HZZ_DW;
                end
            end
        end
    end

    assign hzzs_miso = miso_rdata[HZZ_DW-1:0];

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) hzzs_miso_valid <= '0;
        else     hzzs_miso_valid <= miso_rdata_vld | miso_wack_vld;
    end

    assign u2h_ren = ~ u2h_rempty && (hzzs_s inside {HZZS_WR_ACK, HZZS_RD_FCH});

endmodule: ddrif_hzz
