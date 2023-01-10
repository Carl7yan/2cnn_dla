// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      ddrif.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Author(s):
//                  Haozhe.Zhu (zhutmost@outlook.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

`resetall

`include "INC_global.sv"

module ddrif #(
    parameter APP_AW = 28,
    parameter APP_DW = 512,
    parameter APP_MW = 64,
    parameter HZZ_DW = 256,
    parameter DDR_DW = 64
)(
    input  logic                hzzs_mosi_clk,
    input  logic                rst,
    input  logic                ui_clk,
    input  logic                ui_rst,

    //  HZZ slave interface
    input  logic [HZZ_DW-1:0]   hzzs_mosi,
    output logic [HZZ_DW-1:0]   hzzs_miso,
    input  logic                hzzs_mosi_valid,
    output logic                hzzs_miso_valid,
    output logic                hzzs_mosi_en,
    output logic                hzzs_miso_en,

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
    input  logic                app_rd_data_valid
);

    logic [APP_DW-1:0]  u2h_rdata;
    logic               u2h_ren;
    logic               u2h_rempty;

    logic [APP_DW-1:0]  h2u_wdata;
    logic               h2u_wen;
    logic               h2u_wfull;

    logic [APP_DW-1:0]  h2u_rdata;
    logic               h2u_ren;
    logic               h2u_rempty;

    logic [APP_DW-1:0]  u2h_wdata;
    logic               u2h_wen;
    logic               u2h_wfull;

    logic hzz_clk, hzz_rst;

    assign hzz_clk = hzzs_mosi_clk;
    assign hzz_rst = rst;

    ddrif_hzz #(
        .HZZ_DW (HZZ_DW),
        .APP_DW (APP_DW)
    ) ddrif_hzz (
        .clk    (hzz_clk),
        .rst    (hzz_rst),

        .hzzs_mosi,
        .hzzs_miso,
        .hzzs_mosi_valid,
        .hzzs_miso_valid,
        .hzzs_mosi_en,
        .hzzs_miso_en,

        //  UI2HZZ FIFO
        .u2h_rdata,
        .u2h_ren,
        .u2h_rempty,

        //  HZZ2UI FIFO
        .h2u_wdata,
        .h2u_wen,
        .h2u_wfull
    );

    ddrif_ui #(
        .APP_AW     (APP_AW),
        .APP_DW     (APP_DW),
        .APP_MW     (APP_MW),
        .HZZ_DW     (HZZ_DW),
        .DDR_DW     (DDR_DW)
    ) ddrif_ui (
        .ui_clk,
        .ui_rst,

        //  MIG UI interface
        .app_addr,
        .app_cmd,
        .app_en,
        .app_rdy,

        .app_wdf_rdy,
        .app_wdf_data,
        .app_wdf_mask,
        .app_wdf_wren,
        .app_wdf_end,

        .app_rd_data,
        .app_rd_data_valid,

        //  HZZ2UI FIFO
        .h2u_rdata,
        .h2u_ren,
        .h2u_rempty,

        //  UI2HZZ FIFO
        .u2h_wdata,
        .u2h_wen,
        .u2h_wfull
    );

    ddrif_fifo_u2h u2h_fifo (
        .wr_clk (ui_clk),
        .wr_en  (u2h_wen),
        .din    (u2h_wdata),
        .full   (u2h_wfull),

        .rd_clk (hzz_clk),
        .rd_en  (u2h_ren),
        .dout   (u2h_rdata),
        .empty  (u2h_rempty)
    );

    ddrif_fifo_h2u h2u_fifo (
        .wr_clk (hzz_clk),
        .wr_en  (h2u_wen),
        .din    (h2u_wdata),
        .full   (h2u_wfull),

        .rd_clk (ui_clk),
        .rd_en  (h2u_ren),
        .dout   (h2u_rdata),
        .empty  (h2u_rempty)
    );

    // async_fifo
    // #(
    //     .DW     (APP_DW),
    //     .AW     (8)
    // ) u2h_fifo (
    //     .wclk   (ui_clk),
    //     .wrst   (ui_rst),
    //     .wen    (u2h_wen),
    //     .wdata  (u2h_wdata),
    //     .wfull  (u2h_wfull),

    //     .rclk   (hzz_clk),
    //     .rrst   (hzz_rst),
    //     .ren    (u2h_ren),
    //     .rdata  (u2h_rdata),
    //     .rempty (u2h_rempty)
    // );

    // async_fifo
    // #(
    //     .DW     (APP_DW),
    //     .AW     (8),
    //     .FWFT   (1)
    // ) h2u_fifo (
    //     .wclk   (hzz_clk),
    //     .wrst   (hzz_rst),
    //     .wen    (h2u_wen),
    //     .wdata  (h2u_wdata),
    //     .wfull  (h2u_wfull),

    //     .rclk   (ui_clk),
    //     .rrst   (ui_rst),
    //     .ren    (h2u_ren),
    //     .rdata  (h2u_rdata),
    //     .rempty (h2u_rempty)
    // );

endmodule: ddrif
