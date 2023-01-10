// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dummy_ddrif.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Repository:     http://10.137.20.23/bcrc-soc/tj3.git
//  Author(s):
//                  Haozhe.Zhu (zhutmost@outlook.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

`resetall

`include "INC_global.sv"

module dummy_ddrif
    import PKG_dla_config :: *;
(
    //  global signals
    input  logic    clk,
    input  logic    rst,
    //  HZZ interface
    input  logic [HZZ_T2D_WIDTH-1:0] hzzs_mosi,
    output logic [HZZ_T2D_WIDTH-1:0] hzzs_miso,
    output logic    hzzs_mosi_en,    // tri-state input enable
    output logic    hzzs_miso_en,    // tri-state output enable
    input  logic    hzzs_mosi_valid,
    output logic    hzzs_miso_valid
);

    enum logic [3:0] {
        HZZS_IDLE      = 4'b0001,
        HZZS_MOSI      = 4'b0010,
        HZZS_MISO      = 4'b0100,
        HZZS_MOSI_RESP = 4'b1000
    } hzzs_s;

    logic [7:0]     hzzs_ctrl_len;
    logic [53:0]    hzzs_ctrl_addr;

    assign hzzs_ctrl_len  = hzzs_mosi[HZZ_T2D_WIDTH-3-:8];
    assign hzzs_ctrl_addr = hzzs_mosi[53:0];

    logic [7:0]     burst_cnt, rvalid_cnt;

    logic           ram_ren, ram_wen, ram_rvalid;
    logic [53:0]    ram_addr;
    logic [HZZ_T2D_WIDTH-1:0] ram_wdata, ram_rdata;

`ifdef DUMMY_DDR_DEPTH
    logic [63:0]    ram_data [0:`DUMMY_DDR_DEPTH-1];
`else
    logic [63:0]    ram_data [0:1024-1];
`endif

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            hzzs_s          <= HZZS_IDLE;
            hzzs_mosi_en    <= 1'b1; // input enable
            hzzs_miso_en    <= 1'b0;
            hzzs_miso_valid <= 1'b0;
            hzzs_miso       <= '0;
            burst_cnt       <= '0;
            rvalid_cnt      <= '0;
            ram_addr        <= '0;
            ram_wen         <= 1'b0;
            ram_ren         <= 1'b0;
            ram_wdata       <= '0;
        end
        else begin
            case (hzzs_s)
                HZZS_IDLE: begin
                    hzzs_mosi_en    <= 1'b1; // input enable
                    hzzs_miso_en    <= 1'b0;
                    hzzs_miso_valid <= 1'b0;
                    ram_wen         <= 1'b0;
                    if (hzzs_mosi_valid) begin
                        burst_cnt  <= hzzs_ctrl_len;
                        rvalid_cnt <= hzzs_ctrl_len;
                        ram_addr   <= hzzs_ctrl_addr;
                        addr_check: assert (hzzs_ctrl_addr[1:0] == 2'b0) else $error("Invalid DDR2GB address");
                        len_check:  assert (hzzs_ctrl_len[1:0] == 2'b11) else $error("Invalid DDR2GB length");
                        if (hzzs_mosi[HZZ_T2D_WIDTH-1]) begin
                            hzzs_s <= HZZS_MOSI;
                        end
                        else if (hzzs_mosi[HZZ_T2D_WIDTH-2]) begin
                            hzzs_s  <= HZZS_MISO;
                            ram_ren <= 1'b1;
                        end
                    end
                end
                HZZS_MISO: begin
                    hzzs_mosi_en <= 1'b0;
                    hzzs_miso_en <= 1'b1;
                    if (burst_cnt == 8'd0) begin
                        ram_ren <= 1'b0;
                    end
                    else begin
                        burst_cnt <= burst_cnt - 8'd1;
                        ram_addr  <= ram_addr + 54'd1;
                    end
                    hzzs_miso_valid <= ram_rvalid;
                    if (ram_rvalid) begin
                        hzzs_miso <= ram_rdata;
                        if (rvalid_cnt == 8'd0) begin
                            hzzs_s <= HZZS_IDLE;
                        end
                        else begin
                            rvalid_cnt <= rvalid_cnt - 8'd1;
                        end
                    end
                end
                HZZS_MOSI: begin
                    ram_wen <= hzzs_mosi_valid;
                    if (hzzs_mosi_valid) begin
                        ram_wdata <= hzzs_mosi;
                        if (burst_cnt == 8'd0) begin
                            hzzs_s <= HZZS_MOSI_RESP;
                        end
                        else begin
                            burst_cnt <= burst_cnt - 8'd1;
                        end
                    end
                    if (ram_wen) begin
                        ram_addr <= ram_addr + 54'd1;
                    end
                end
                HZZS_MOSI_RESP: begin
                    hzzs_s  <= HZZS_IDLE;
                    ram_wen <= 1'b0;
                    hzzs_miso_valid <= 1'b1;
                end
                default: begin
                    hzzs_s <= HZZS_IDLE;
                end
            endcase // case (hzzs_s)
        end
    end

    generate
        if (HZZ_T2D_WIDTH == 64) begin: gen_dummy_ddr_ram
            always_ff @ (posedge clk or posedge rst) begin
                if (rst) begin
                    ram_rvalid <= 1'b0;
                    ram_rdata  <= '0;
                end
                else begin
                    ram_rvalid <= ram_ren;
                    if (ram_ren) ram_rdata <= ram_data[ram_addr];
                    if (ram_wen) ram_data[ram_addr] <= ram_wdata;
                end
            end
        end
        else begin // if (HZZ_T2D_WIDTH == 256)
            always_ff @ (posedge clk or posedge rst) begin
                if (rst) begin
                    ram_rvalid <= 1'b0;
                    ram_rdata  <= '0;
                end
                else begin
                    ram_rvalid <= ram_ren;
                    if (ram_ren) begin
                        ram_rdata[63:0]    <= ram_data[{ram_addr, 2'd0}];
                        ram_rdata[127-:64] <= ram_data[{ram_addr, 2'd1}];
                        ram_rdata[191-:64] <= ram_data[{ram_addr, 2'd2}];
                        ram_rdata[255-:64] <= ram_data[{ram_addr, 2'd3}];
                    end
                    if (ram_wen) begin
                        ram_data[{ram_addr, 2'd0}] <= ram_wdata[63:0];
                        ram_data[{ram_addr, 2'd1}] <= ram_wdata[127-:64];
                        ram_data[{ram_addr, 2'd2}] <= ram_wdata[191-:64];
                        ram_data[{ram_addr, 2'd3}] <= ram_wdata[255-:64];
                    end
                end
            end
        end
    endgenerate

endmodule: dummy_ddrif
