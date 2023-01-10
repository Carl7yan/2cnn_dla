// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      ddrif_ui.sv
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

module ddrif_ui #(
    parameter APP_AW = 29,
    parameter APP_DW = 256,
    parameter APP_MW = 256,
    parameter HZZ_DW = 256,
    parameter DDR_DW = 64
)(
    input  logic    ui_clk,
    input  logic    ui_rst,

    //  MIG UI interface
    output logic [APP_AW-1:0]   app_addr,
    output logic [2:0]          app_cmd,
    output logic                app_en,
    input  logic                app_rdy,

    input  logic                app_wdf_rdy,
    output logic [APP_DW-1:0]   app_wdf_data,
    output logic [APP_MW-1:0]   app_wdf_mask,
    output logic                app_wdf_wren,
    output logic                app_wdf_end,

    input  logic [APP_DW-1:0]   app_rd_data,
    input  logic                app_rd_data_valid,

    //  HZZ2UI FIFO
    input  logic [APP_DW-1:0]   h2u_rdata,
    output logic                h2u_ren,
    input  logic                h2u_rempty,

    //  UI2HZZ FIFO
    output logic [APP_DW-1:0]   u2h_wdata,
    output logic                u2h_wen,
    input  logic                u2h_wfull
);

    assign app_wdf_mask = '0;

    localparam APP_CMD_READ  = 3'd1;
    localparam APP_CMD_WRITE = 3'd0;

    enum {
        UI_IDLE,
        UI_CMD,
        UI_WR_A,
        UI_WR_B,
        UI_RD
    } ui_s;

    logic               hzz_cmd_wr;
    logic [7:0]         hzz_cmd_len;
    logic [APP_AW-1:0]  hzz_cmd_addr;

    logic [7:0] app_bstlen, app_rvld_cnt;

    assign hzz_cmd_wr   = h2u_rdata[HZZ_DW-1];
    assign hzz_cmd_len  = h2u_rdata[HZZ_DW-3-:8] >> ($clog2(APP_DW/HZZ_DW));
    assign hzz_cmd_addr = h2u_rdata[APP_AW-1:0] << ($clog2(HZZ_DW/DDR_DW));

    always_comb begin
        if (~ h2u_rempty) begin
            h2u_ren = ui_s == UI_IDLE
                   || ui_s == UI_WR_A
                   || (ui_s == UI_WR_B && app_rdy && app_wdf_rdy && app_bstlen != 8'd0);
        end
        else h2u_ren = 1'b0;
    end

    always_ff @ (posedge ui_clk or posedge ui_rst) begin
        if (ui_rst) begin
            ui_s         <= UI_IDLE;
            app_cmd      <= APP_CMD_WRITE;
            app_addr     <= '0;
            app_en       <= 1'b0;
            app_wdf_wren <= 1'b0;
            app_wdf_data <= '0;
            app_wdf_end  <= 1'b0;
            u2h_wen      <= 1'b0;
            u2h_wdata    <= '0;
            app_bstlen   <= '0;
            app_rvld_cnt <= '0;
        end
        else begin
            case (ui_s)
                UI_IDLE: begin
                    app_en       <= 1'b0;
                    app_wdf_wren <= 1'b0;
                    app_wdf_end  <= 1'b0;
                    u2h_wen      <= 1'b0;
                    if (~ h2u_rempty) begin
                        app_addr     <= hzz_cmd_addr;
                        app_bstlen   <= hzz_cmd_len;
                        app_rvld_cnt <= hzz_cmd_len;
                        if (hzz_cmd_wr) begin
                            ui_s    <= UI_WR_A;
                            app_cmd <= APP_CMD_WRITE;
                        end
                        else begin
                            ui_s    <= UI_RD;
                            app_en  <= 1'b1;
                            app_cmd <= APP_CMD_READ;
                        end
                    end
                end
                UI_WR_A: begin
                    if (~ h2u_rempty) begin
                        ui_s         <= UI_WR_B;
                        app_en       <= 1'b1;
                        app_wdf_wren <= 1'b1;
                        app_wdf_data <= h2u_rdata;
                        app_wdf_end  <= 1'b1;
                    end
                end
                UI_WR_B: begin
                    if (app_rdy && app_wdf_rdy) begin
                        app_addr   <= app_addr + 8; // BL8 Mode
                        app_bstlen <= app_bstlen - 8'd1;
                        if (app_bstlen == 8'd0) begin
                            ui_s         <= UI_IDLE;
                            app_en       <= 1'b0;
                            app_wdf_wren <= 1'b0;
                            app_wdf_end  <= 1'b0;
                            u2h_wen      <= 1'b1;
                            u2h_wdata    <= '1;
                        end
                        else if (~ h2u_rempty) begin
                            app_en       <= 1'b1;
                            app_wdf_wren <= 1'b1;
                            app_wdf_data <= h2u_rdata;
                            app_wdf_end  <= 1'b1;
                        end
                        else begin
                            ui_s         <= UI_WR_A;
                            app_en       <= 1'b0;
                            app_wdf_wren <= 1'b0;
                            app_wdf_end  <= 1'b0;
                        end
                    end
                end
                UI_RD: begin
                    if (app_rdy) begin
                        app_addr <= app_addr + 8; // BL8 Mode
                        if (app_bstlen == 8'd0) begin
                            app_en <= 1'b0;
                        end
                        else begin
                            app_bstlen <= app_bstlen - 8'd1;
                        end
                    end
                    if (app_rd_data_valid) begin
                        u2h_wdata <= app_rd_data;
                        u2h_wen   <= 1'b1;
                        app_rvld_cnt <= app_rvld_cnt - 8'd1;
                        if (app_rvld_cnt == 8'd0) begin
                            ui_s <= UI_IDLE;
                        end
                    end
                    else begin
                        u2h_wen <= 1'b0;
                    end
                end
                default: ui_s <= UI_IDLE;
            endcase
        end
    end

endmodule: ddrif_ui
