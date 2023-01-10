// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla.sv
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

module dla
    import PKG_dla_typedef :: *;
    import PKG_dla_config :: *;
(
    //  global signals
    input  logic        clk,
    input  logic        rst,

    //  SOC-HZZ slave interface
    input  logic [31:0] s2t_hzzs_mosi,
    output logic [31:0] s2t_hzzs_miso,
    output logic        s2t_hzzs_mosi_en,    // tri-state input enable
    output logic        s2t_hzzs_miso_en,    // tri-state output enable
    output logic        s2t_hzzs_miso_valid,
    input  logic        s2t_hzzs_mosi_valid,

    //  DDR-HZZ master interface
    output logic        t2d_hzzm_mosi_clk,
    input  logic        t2d_hzzm_miso_clk,
    output logic [HZZ_T2D_WIDTH-1:0] t2d_hzzm_mosi,
    input  logic [HZZ_T2D_WIDTH-1:0] t2d_hzzm_miso,
    output logic        t2d_hzzm_mosi_en,    // tri-state output enable
    output logic        t2d_hzzm_miso_en,    // tri-state input enable
    input  logic        t2d_hzzm_miso_valid,
    output logic        t2d_hzzm_mosi_valid,

    //  interrupt
    output logic        interrupt
);

    assign t2d_hzzm_mosi_clk = clk;

    // =========================================================================
    //  global buffer (GB) interface

    //  GB interface - MOV SOC2GB
    logic           bif_gb_soc2gb_ab_sel;
    logic [12:0]    bif_gb_soc2gb_addr;
    logic [15:0]    bif_gb_soc2gb_ram_sel;
    logic           bif_gb_soc2gb_wen;
    logic           bif_gb_soc2gb_ren;
    logic [255:0]   bif_gb_soc2gb_wdata;
    logic [15:0][15:0] bif_gb_soc2gb_rdata;

    //  GB interface - MOV DDR2GB
    logic           bif_gb_ddr2gb_ab_sel;
    logic [12:0]    bif_gb_ddr2gb_addr;
    logic [HZZ_T2D_WIDTH-1:0] bif_gb_ddr2gb_wdata;
    logic           bif_gb_ddr2gb_wen;
    logic [3:0]     bif_gb_ddr2gb_ram_idx;
    logic           bif_gb_ddr2gb_ren;
    logic [HZZ_T2D_WIDTH-1:0] bif_gb_ddr2gb_rdata;

    //  GB interface - MOV GB2LB
    logic           bif_gb_gb2lb_ren;
    logic [12:0]    bif_gb_gb2lb_addr;

    //  GB interface - LPE
    logic [12:0]    bif_gb_lpe_addr;
    logic           bif_gb_lpe_ren;
    logic           bif_gb_lpe_wen;

    //  GB interface - COMP APE
    logic [12:0]    bif_gb_ape_addr;
    logic           bif_gb_ape_wen;
    logic           bif_gb_ape_ren;

    // =========================================================================
    //  local buffer (LB) interface

    //  LB interface - MOV GB2LB
    logic [10:0]    bif_lb_gb2lb_addr;
    logic           bif_lb_gb2lb_wen;

    //  LB interface - COMP CONV
    logic [5:0]     bif_lb_conv_hori;
    logic [5:0]     bif_lb_conv_vert;
    logic           bif_lb_conv_ren;
    logic [15:0]    bif_lb_conv_pad_num;
    logic           bif_lb_conv_pad_enable;

    //  LB interface - COMP FC
    logic [10:0]    bif_lb_fc_addr;
    logic           bif_lb_fc_ren;

    //  LB interface - COMP RESHAPE
    logic [10:0]    bif_lb_reshape_addr;
    logic           bif_lb_reshape_ren;

    // =========================================================================
    //  weight buffer (WB) interface

    //  WB interface - WB Load
    logic [255:0]   bif_wb_wbload_wdata;
    logic [3:0]     bif_wb_wbload_waddr;
    logic [15:0]    bif_wb_wbload_wen;

    //  WB interface - COMP CONV
    logic [3:0]     bif_wb_conv_raddr;
    logic           bif_wb_conv_ren;
    logic           bif_wb_conv_switch;

    //  WB interface - COMP FC
    logic           bif_wb_fc_ren;
    logic           bif_wb_fc_switch;

    // =========================================================================
    //  other control signals

    //  CPE control signals
    logic           ctrl_pool_mode;
    logic           ctrl_conv_kpe_rst;
    logic           ctrl_conv_adt_fifo_set;
    logic           ctrl_fc_kpe_acc_rst;
    logic           ctrl_fc_adt_fifo_set;
    logic           ctrl_fc_ifmap_is_zero;
    logic           ctrl_fc_ifmap_enable;
    logic           ctrl_reshape_adt_fifo_set;

    //  APE control signals
    logic           ctrl_ape_sa_en;
    logic           ctrl_ape_ab_en;
    logic           ctrl_ape_sb_en;
    logic [1:0]     ctrl_ape_mul_en;
    logic           ctrl_ape_add_en;
    ape_mode_e      ctrl_ape_mode;
    logic [15:0]    ctrl_ape_imm;

    //  LPE control signals
    logic           ctrl_adt_fifo_set;
    logic           ctrl_adt_fifo_ren;
    logic           ctrl_lpe_relu;
    logic           ctrl_lpe_acc_bypass;
    lpe_sprmps_e    ctrl_lpe_sprmps;

    //  staging registers - GLOBAL
    logic [15:0]    stgr_enable_row;
    logic [15:0]    stgr_enable_col;
    logic [255:0]   stgr_buf_mask;
    status_e        stgr_status;
    logic           stgr_pool_enable;

    //  staging registers - PRECISION
    logic [3:0]         stgr_precision_ape_shift;
    logic [3:0]         stgr_precision_kpe_shift;
    precision_ifmap_e   stgr_precision_ifmap;
    precision_weight_e  stgr_precision_weight;

    dla_ctrl dla_ctrl (
        //  global signals
        .clk,
        .rst,

        // =====================================================================
        //  external ports

        //  SOC-HZZ slave interface
        .hzzs_mosi          (s2t_hzzs_mosi),
        .hzzs_miso          (s2t_hzzs_miso),
        .hzzs_mosi_en       (s2t_hzzs_mosi_en), // tri-state input enable
        .hzzs_miso_en       (s2t_hzzs_miso_en), // tri-state output enable
        .hzzs_miso_valid    (s2t_hzzs_miso_valid),
        .hzzs_mosi_valid    (s2t_hzzs_mosi_valid),

        //  DDR-HZZ master interface
        .hzzm_miso_clk      (t2d_hzzm_miso_clk),
        .hzzm_mosi          (t2d_hzzm_mosi),
        .hzzm_miso          (t2d_hzzm_miso),
        .hzzm_mosi_en       (t2d_hzzm_mosi_en), // tri-state output enable
        .hzzm_miso_en       (t2d_hzzm_miso_en), // tri-state input enable
        .hzzm_miso_valid    (t2d_hzzm_miso_valid),
        .hzzm_mosi_valid    (t2d_hzzm_mosi_valid),

        //  interrupt
        .interrupt,

        // =====================================================================
        //  global buffer (GB) interface

        //  GB interface - MOV SOC2GB
        .bif_gb_soc2gb_ab_sel,
        .bif_gb_soc2gb_addr,
        .bif_gb_soc2gb_wdata,
        .bif_gb_soc2gb_wen,
        .bif_gb_soc2gb_ram_sel,
        .bif_gb_soc2gb_rdata,
        .bif_gb_soc2gb_ren,

        //  GB interface - MOV DDR2GB
        .bif_gb_ddr2gb_ab_sel,
        .bif_gb_ddr2gb_addr,
        .bif_gb_ddr2gb_wdata,
        .bif_gb_ddr2gb_wen,
        .bif_gb_ddr2gb_ram_idx,
        .bif_gb_ddr2gb_ren,
        .bif_gb_ddr2gb_rdata,

        //  GB interface - MOV GB2LB
        .bif_gb_gb2lb_ren,
        .bif_gb_gb2lb_addr,

        //  GB interface - LPE
        .bif_gb_lpe_addr,
        .bif_gb_lpe_ren,
        .bif_gb_lpe_wen,

        //  GB interface - COMP APE
        .bif_gb_ape_addr,
        .bif_gb_ape_wen,
        .bif_gb_ape_ren,

        // =====================================================================
        //  local buffer (LB) interface

        //  LB interface - MOV GB2LB
        .bif_lb_gb2lb_addr,
        .bif_lb_gb2lb_wen,

        //  LB interface - COMP CONV
        .bif_lb_conv_hori,
        .bif_lb_conv_vert,
        .bif_lb_conv_ren,
        .bif_lb_conv_pad_num,
        .bif_lb_conv_pad_enable,

        //  LB interface - COMP FC
        .bif_lb_fc_addr,
        .bif_lb_fc_ren,

        //  LB interface - COMP RESHAPE
        .bif_lb_reshape_addr,
        .bif_lb_reshape_ren,

        // =====================================================================
        //  weight buffer (WB) interface

        //  WB interface - WB LOAD
        .bif_wb_wbload_wdata,
        .bif_wb_wbload_waddr,
        .bif_wb_wbload_wen,

        //  WB interface - COMP CONV
        .bif_wb_conv_raddr,
        .bif_wb_conv_ren,
        .bif_wb_conv_switch,

        //  WB interface - COMP FC
        .bif_wb_fc_ren,
        .bif_wb_fc_switch,

        // =====================================================================
        //  other control signals

        //  CPE control signals
        .ctrl_pool_mode,
        .ctrl_conv_kpe_rst,
        .ctrl_conv_adt_fifo_set,
        .ctrl_fc_kpe_acc_rst,
        .ctrl_fc_adt_fifo_set,
        .ctrl_fc_ifmap_is_zero,
        .ctrl_fc_ifmap_enable,
        .ctrl_reshape_adt_fifo_set,

        //  APE control signals
        .ctrl_ape_sa_en,
        .ctrl_ape_ab_en,
        .ctrl_ape_sb_en,
        .ctrl_ape_mul_en,
        .ctrl_ape_add_en,
        .ctrl_ape_mode,
        .ctrl_ape_imm,

        //  LPE control signals
        .ctrl_adt_fifo_set,
        .ctrl_adt_fifo_ren,
        .ctrl_lpe_relu,
        .ctrl_lpe_acc_bypass,
        .ctrl_lpe_sprmps,

        //  staging registers - GLOBAL
        .stgr_enable_row,
        .stgr_enable_col,
        .stgr_buf_mask,
        .stgr_status,
        .stgr_pool_enable,

        //  staging registers - PRECISION
        .stgr_precision_ape_shift,
        .stgr_precision_kpe_shift,
        .stgr_precision_ifmap,
        .stgr_precision_weight
    );

    dla_comp dla_comp (
        //  global signals
        .clk,
        .rst,

        // =====================================================================
        //  global buffer (GB) interface

        //  GB interface - MOV SOC2GB
        .bif_gb_soc2gb_ab_sel,
        .bif_gb_soc2gb_addr,
        .bif_gb_soc2gb_wdata,
        .bif_gb_soc2gb_wen,
        .bif_gb_soc2gb_ram_sel,
        .bif_gb_soc2gb_rdata,
        .bif_gb_soc2gb_ren,

        //  GB interface - MOV DDR2GB
        .bif_gb_ddr2gb_ab_sel,
        .bif_gb_ddr2gb_addr,
        .bif_gb_ddr2gb_wdata,
        .bif_gb_ddr2gb_wen,
        .bif_gb_ddr2gb_ram_idx,
        .bif_gb_ddr2gb_ren,
        .bif_gb_ddr2gb_rdata,

        //  GB interface - MOV GB2LB
        .bif_gb_gb2lb_ren,
        .bif_gb_gb2lb_addr,

        //  GB interface - LPE
        .bif_gb_lpe_addr,
        .bif_gb_lpe_ren,
        .bif_gb_lpe_wen,

        //  GB interface - COMP APE
        .bif_gb_ape_addr,
        .bif_gb_ape_wen,
        .bif_gb_ape_ren,

        // =========================================================================
        //  local buffer (LB) interface

        //  LB interface - MOV GB2LB
        .bif_lb_gb2lb_addr,
        .bif_lb_gb2lb_wen,

        //  LB interface - COMP CONV
        .bif_lb_conv_hori,
        .bif_lb_conv_vert,
        .bif_lb_conv_ren,
        .bif_lb_conv_pad_num,
        .bif_lb_conv_pad_enable,

        //  LB interface - COMP FC
        .bif_lb_fc_addr,
        .bif_lb_fc_ren,

        //  LB interface - COMP RESHAPE
        .bif_lb_reshape_addr,
        .bif_lb_reshape_ren,

        // =====================================================================
        //  weight buffer (WB) interface

        //  WB interface - WB LOAD
        .bif_wb_wbload_wdata,
        .bif_wb_wbload_waddr,
        .bif_wb_wbload_wen,

        //  WB interface - COMP CONV
        .bif_wb_conv_raddr,
        .bif_wb_conv_ren,
        .bif_wb_conv_switch,

        //  WB interface - COMP FC
        .bif_wb_fc_ren,
        .bif_wb_fc_switch,

        // =====================================================================
        //  other control signals

        //  CPE control signals
        .ctrl_pool_mode,
        .ctrl_conv_kpe_rst,
        .ctrl_conv_adt_fifo_set,
        .ctrl_fc_kpe_acc_rst,
        .ctrl_fc_adt_fifo_set,
        .ctrl_fc_ifmap_is_zero,
        .ctrl_fc_ifmap_enable,
        .ctrl_reshape_adt_fifo_set,

        //  APE control signals
        .ctrl_ape_sa_en,
        .ctrl_ape_ab_en,
        .ctrl_ape_sb_en,
        .ctrl_ape_mul_en,
        .ctrl_ape_add_en,
        .ctrl_ape_mode,
        .ctrl_ape_imm,

        //  LPE control signals
        .ctrl_adt_fifo_set,
        .ctrl_adt_fifo_ren,
        .ctrl_lpe_relu,
        .ctrl_lpe_acc_bypass,
        .ctrl_lpe_sprmps,

        //  staging registers - GLOBAL
        .stgr_enable_row,
        .stgr_enable_col,
        .stgr_buf_mask,
        .stgr_status,
        .stgr_pool_enable,

        //  staging registers - PRECISION
        .stgr_precision_ape_shift,
        .stgr_precision_kpe_shift,
        .stgr_precision_ifmap,
        .stgr_precision_weight
    );

endmodule: dla
