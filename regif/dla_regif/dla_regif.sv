// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_regif.sv
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

module dla_regif
    import PKG_dla_typedef :: *;
(
    //  global signals
    input  logic        clk,
    input  logic        rst,

    //  off-chip HZZ bus interface
    input  logic [21:0] regif_addr,
    input  logic [31:0] regif_wdata,
    input  logic        regif_wen,
    output logic [31:0] regif_rdata,
    input  logic        regif_ren,
    output logic        regif_rvalid,

    //  staging registers - GLOBAL
    output logic [15:0] stgr_enable_row,
    output logic [15:0] stgr_enable_col,
    output logic [255:0]stgr_buf_mask,
    output status_e     stgr_status,

    //  subunit start signals
    output logic        start_mov_ddr2gb,
    output logic        start_mov_gb2lb,
    output logic        start_comp_conv,
    output logic        start_comp_fc,
    output logic        start_comp_ape,
    output logic        start_comp_reshape,

    //  subunit complete signals
    input  logic        complete_mov_ddr2gb,
    input  logic        complete_mov_gb2lb,
    input  logic        complete_comp_conv,
    input  logic        complete_comp_fc,
    input  logic        complete_comp_ape,
    input  logic        complete_comp_reshape,
    input  logic        complete_lpe,

    //  staging registers - DDR2GB
    output logic [53:0] stgr_ddr2gb_ddr_addr,
    output logic        stgr_ddr2gb_ab_sel,
    output logic [12:0] stgr_ddr2gb_gb_addr,
    output logic [3:0]  stgr_ddr2gb_gb_ramidx,
    output logic        stgr_ddr2gb_dir,
    output logic [7:0]  stgr_ddr2gb_len,

    //  staging registers - GB2LB
    output logic [12:0] stgr_gb2lb_gb_addr,
    output logic [12:0] stgr_gb2lb_gb_skip,
    output logic [10:0] stgr_gb2lb_lb_addr,
    output logic [5:0]  stgr_gb2lb_lb_skip,
    output logic [12:0] stgr_gb2lb_len,
    output logic [5:0]  stgr_gb2lb_iter,

    //  staging registers - APE
    output logic [12:0] stgr_ape_gb_addr_sa,
    output logic [12:0] stgr_ape_gb_addr_sb,
    output logic [12:0] stgr_ape_gb_addr_d,
    output logic [12:0] stgr_ape_len,
    output logic [15:0] stgr_ape_imm,
    output ape_mode_e   stgr_ape_mode,

    //  staging registers - CONV
    output logic [5:0]  stgr_conv_k_hori_len,
    output logic [5:0]  stgr_conv_k_vert_len,
    output logic [5:0]  stgr_conv_k_hori_delta,
    output logic [5:0]  stgr_conv_k_vert_delta,
    output logic [10:0] stgr_conv_k_size_len,

    output wbload_cmd_e stgr_conv_wbload_cmd,

    output logic [5:0]  stgr_conv_of_hori_len,
    output logic [5:0]  stgr_conv_of_vert_len,
    output logic [5:0]  stgr_conv_if_hori_len,
    output logic [5:0]  stgr_conv_if_vert_len,

    output logic [5:0]  stgr_conv_hori_stride,
    output logic [5:0]  stgr_conv_vert_stride,
    output logic [3:0]  stgr_conv_slice_max,

    output logic [3:0]  stgr_conv_pad_up,
    output logic [3:0]  stgr_conv_pad_down,
    output logic [3:0]  stgr_conv_pad_left,
    output logic [3:0]  stgr_conv_pad_right,
    output logic [15:0] stgr_conv_pad_num,

    output logic [4:0]  stgr_conv_wait_lpe,

    output logic        stgr_pool_enable,
    output logic        stgr_pool_mode,

    //  staging registers - COMP FC
    output logic [10:0] stgr_fc_addr,
    output logic [10:0] stgr_fc_len,
    output logic [4:0]  stgr_fc_wait_lpe,

    //  staging registers - COMP RESHAPE
    output logic [10:0] stgr_reshape_addr,
    output logic [10:0] stgr_reshape_len,
    output logic [5:0]  stgr_reshape_iter,
    output logic [5:0]  stgr_reshape_skip,
    output logic [4:0]  stgr_reshape_wait_lpe,

    output logic [3:0]  stgr_precision_ape_shift,
    output logic [3:0]  stgr_precision_kpe_shift,
    output precision_ifmap_e  stgr_precision_ifmap,
    output precision_weight_e stgr_precision_weight,

    //  staging registers - LPE
    output logic        start_lpe,
    output logic [12:0] stgr_lpe_src_addr,
    output logic [12:0] stgr_lpe_src_len,
    output logic [12:0] stgr_lpe_src_skip,
    output logic [12:0] stgr_lpe_src_iter,
    output logic [12:0] stgr_lpe_dest_addr,
    output logic [12:0] stgr_lpe_dest_len,
    output logic [12:0] stgr_lpe_dest_skip,
    output logic [12:0] stgr_lpe_dest_iter,
    output logic [6:0]  stgr_lpe_overlay,
    output logic        stgr_lpe_relu,
    output logic        stgr_lpe_acc_bypass,
    output lpe_sprmps_e stgr_lpe_sprmps,
    output logic [14:0][12:0] stgr_lpe_leap,

    //  staging registers - WB_LOAD
    output logic [53:0] stgr_wbload_ddr_addr,
    output logic [3:0]  stgr_wbload_wb_cnt_default,
    output logic [1:0]  stgr_wbload_kpe_cnt,
    output logic [15:0] stgr_wbload_kpe_mask,
    output logic [6:0]  stgr_wbload_kpe_act_num,
    output logic [3:0]  stgr_wbload_cpe_idx,
    output logic [3:0]  stgr_wbload_cpe_cnt,

    //  SOC2GB signals
    output logic            bif_gb_soc2gb_ab_sel,
    output logic [12:0]     bif_gb_soc2gb_addr,
    output logic [15:0]     bif_gb_soc2gb_ram_sel,
    output logic            bif_gb_soc2gb_wen,
    output logic            bif_gb_soc2gb_ren,
    output logic [255:0]    bif_gb_soc2gb_wdata,
    input  logic [15:0][15:0] bif_gb_soc2gb_rdata,

    //  interrupt
    output logic        interrupt
);

    //  subunit go signals
    logic           go_mov_ddr2gb;
    logic           go_mov_gb2lb;
    logic           go_comp_conv;
    logic           go_comp_fc;
    logic           go_comp_ape;
    logic           go_comp_reshape;

// =============================================================================

    //  registers - SOC2GB_CONFIG
    logic           soc2gb_config_wen;
    logic [31:0]    soc2gb_config_rdata;

// =============================================================================

    //  registers - DDR2GB_DDR_ADDR1
    logic           ddr2gb_addr1_wen;
    logic [31:0]    ddr2gb_addr1_rdata;
    //  registers - DDR2GB_DDR_ADDR0
    logic           ddr2gb_addr0_wen;
    logic [31:0]    ddr2gb_addr0_rdata;
    //  registers - DDR2GB_GB_ADDR
    logic           ddr2gb_gbaddr_wen;
    logic [31:0]    ddr2gb_gbaddr_rdata;
    //  registers - DDR2GB_CTRL
    logic           ddr2gb_ctrl_wen;
    logic [31:0]    ddr2gb_ctrl_rdata;

// =============================================================================

    //  register interface - GB2LB_SRC0
    logic           gb2lb_src0_wen;
    logic [31:0]    gb2lb_src0_rdata;
    //  register interface - GB2LB_SRC1
    logic           gb2lb_src1_wen;
    logic [31:0]    gb2lb_src1_rdata;
    //  register interface - GB2LB_DEST
    logic           gb2lb_dest_wen;
    logic [31:0]    gb2lb_dest_rdata;
    //  register interface - Ctrl
    logic           gb2lb_ctrl_wen;
    logic [31:0]    gb2lb_ctrl_rdata;

// =============================================================================

    //  register interface - APE_CTRL
    logic           ape_ctrl_wen;
    logic [31:0]    ape_ctrl_rdata;
    //  register interface - APE_SRC
    logic           ape_src_wen;
    logic [31:0]    ape_src_rdata;
    //  register interface - APE_DEST
    logic           ape_dest_wen;
    logic [31:0]    ape_dest_rdata;
    //  register interface - APE_IMM
    logic           ape_imm_wen;
    logic [31:0]    ape_imm_rdata;

// =============================================================================

    //  register interface - CONV_K_SIZE0
    logic           conv_k_size0_wen;
    logic [31:0]    conv_k_size0_rdata;
    //  register interface - CONV_K_SIZE1
    logic           conv_k_size1_wen;
    logic [31:0]    conv_k_size1_rdata;
    //  register interface - CONV_K_LOAD
    logic           conv_k_load_wen;
    logic [31:0]    conv_k_load_rdata;
    //  register interface - CONV_FMAP
    logic           conv_fmap_wen;
    logic [31:0]    conv_fmap_rdata;
    //  register interface - CONV_STRIDE
    logic           conv_stride_wen;
    logic [31:0]    conv_stride_rdata;
    //  register interface - CONV_PAD_SIZE
    logic           conv_pad_size_wen;
    logic [31:0]    conv_pad_size_rdata;
    //  register interface - CONV_PAD_NUM
    logic           conv_pad_num_wen;
    logic [31:0]    conv_pad_num_rdata;

    //  register interface - FC_SRC
    logic           fc_src_wen;
    logic [31:0]    fc_src_rdata;

    //  register interface - RESHAPE_SRC0
    logic           reshape_src0_wen;
    logic [31:0]    reshape_src0_rdata;
    //  register interface - RESHAPE_SRC1
    logic           reshape_src1_wen;
    logic [31:0]    reshape_src1_rdata;

    //  register interface - LPE_SRC0
    logic           lpe_src0_wen;
    logic [31:0]    lpe_src0_rdata;
    //  register interface - LPE_SRC1
    logic           lpe_src1_wen;
    logic [31:0]    lpe_src1_rdata;
    //  register interface - LPE_DEST0
    logic           lpe_dest0_wen;
    logic [31:0]    lpe_dest0_rdata;
    //  register interface - LPE_DEST1
    logic           lpe_dest1_wen;
    logic [31:0]    lpe_dest1_rdata;
    //  register interface - LPE_MODE
    logic           lpe_mode_wen;
    logic [31:0]    lpe_mode_rdata;
    //  register interface - LPE_LEAP0
    logic           lpe_leap0_wen;
    logic [31:0]    lpe_leap0_rdata;
    //  register interface - LPE_LEAP1
    logic           lpe_leap1_wen;
    logic [31:0]    lpe_leap1_rdata;
    //  register interface - LPE_LEAP2
    logic           lpe_leap2_wen;
    logic [31:0]    lpe_leap2_rdata;
    //  register interface - LPE_LEAP3
    logic           lpe_leap3_wen;
    logic [31:0]    lpe_leap3_rdata;
    //  register interface - LPE_LEAP4
    logic           lpe_leap4_wen;
    logic [31:0]    lpe_leap4_rdata;
    //  register interface - LPE_LEAP5
    logic           lpe_leap5_wen;
    logic [31:0]    lpe_leap5_rdata;
    //  register interface - LPE_LEAP6
    logic           lpe_leap6_wen;
    logic [31:0]    lpe_leap6_rdata;
    //  register interface - LPE_LEAP7
    logic           lpe_leap7_wen;
    logic [31:0]    lpe_leap7_rdata;

    //  register interface - WBLOAD_DDR_ADDR0
    logic           wbload_ddr_addr0_wen;
    logic [31:0]    wbload_ddr_addr0_rdata;
    //  register interface - WBLOAD_DDR_ADDR1
    logic           wbload_ddr_addr1_wen;
    logic [31:0]    wbload_ddr_addr1_rdata;
    //  register interface - WBLOAD_KERNEL
    logic           wbload_kernel_wen;
    logic [31:0]    wbload_kernel_rdata;
    //  register interface - WBLOAD_CHANNEL
    logic           wbload_channel_wen;
    logic [31:0]    wbload_channel_rdata;

    //  register interface - COMP_CTRL
    logic           comp_ctrl_wen;
    logic [31:0]    comp_ctrl_rdata;
    //  register interface - COMP_PRECISION
    logic           comp_precision_wen;
    logic [31:0]    comp_precision_rdata;

// =============================================================================

    //  register interface - GLB_Status
    // logic           glb_status_wen;
    logic [31:0]    glb_status_rdata;
    //  register interface - GLB_Intr
    logic           glb_intr_wen;
    logic [31:0]    glb_intr_rdata;
    //  register interface - GLB_ENABLE_ROW
    logic           glb_enable_row_wen;
    logic [31:0]    glb_enable_row_rdata;
    //  register interface - GLB_ENABLE_COL
    logic           glb_enable_col_wen;
    logic [31:0]    glb_enable_col_rdata;

// =============================================================================

    //  register interface - BUF_MASKX
    logic           buf_maskx_wen;
    logic [31:0]    buf_maskx_rdata;
    //  register interface - BUF_MASK0
    logic           buf_mask0_wen;
    logic [31:0]    buf_mask0_rdata;
    //  register interface - BUF_MASK1
    logic           buf_mask1_wen;
    logic [31:0]    buf_mask1_rdata;
    //  register interface - BUF_MASK2
    logic           buf_mask2_wen;
    logic [31:0]    buf_mask2_rdata;
    //  register interface - BUF_MASK3
    logic           buf_mask3_wen;
    logic [31:0]    buf_mask3_rdata;
    //  register interface - BUF_MASK4
    logic           buf_mask4_wen;
    logic [31:0]    buf_mask4_rdata;
    //  register interface - BUF_MASK5
    logic           buf_mask5_wen;
    logic [31:0]    buf_mask5_rdata;
    //  register interface - BUF_MASK6
    logic           buf_mask6_wen;
    logic [31:0]    buf_mask6_rdata;
    //  register interface - BUF_MASK7
    logic           buf_mask7_wen;
    logic [31:0]    buf_mask7_rdata;

    logic           go_buf;

    assign go_buf = go_mov_ddr2gb
                 || go_mov_gb2lb
                 || go_comp_conv
                 || go_comp_fc
                 || go_comp_ape
                 || go_comp_reshape;


    //  register interface
    logic           regif_map_wen;
    logic           regif_map_ren;
    logic [31:0]    regif_map_rdata;
    logic           regif_map_rvalid;

    logic           regif_soc2gb_wen;
    logic           regif_soc2gb_ren;
    logic [31:0]    regif_soc2gb_rdata;
    logic           regif_soc2gb_rvalid;

    always_comb begin
        regif_rvalid = regif_map_rvalid | regif_soc2gb_rvalid;
        regif_rdata = regif_soc2gb_rvalid ? regif_soc2gb_rdata : regif_map_rdata;
        if (regif_addr[21:20] == 2'd1) begin
            regif_map_wen    = 1'b0;
            regif_map_ren    = 1'b0;
            regif_soc2gb_wen = regif_wen;
            regif_soc2gb_ren = regif_ren;
        end
        else begin
            regif_map_wen    = regif_wen;
            regif_map_ren    = regif_ren;
            regif_soc2gb_wen = 1'b0;
            regif_soc2gb_ren = 1'b0;
        end
    end

    dla_regif_map regif_map (
        //  global signals
        .clk,
        .rst,

        //  off-chip HZZ bus interface
        .regif_map_addr     (regif_addr[19:0]),
        .regif_map_wen,
        .regif_map_rdata,
        .regif_map_ren,
        .regif_map_rvalid,

        //  registers - SOC2GB_CONFIG
        .soc2gb_config_wen,
        .soc2gb_config_rdata,

        //  registers - DDR2GB_CTRL
        .ddr2gb_ctrl_wen,
        .ddr2gb_ctrl_rdata,
        //  registers - DDR2GB_DDR_ADDR0
        .ddr2gb_addr0_wen,
        .ddr2gb_addr0_rdata,
        //  registers - DDR2GB_DDR_ADDR1
        .ddr2gb_addr1_wen,
        .ddr2gb_addr1_rdata,
        //  registers - DDR2GB_GB_ADDR
        .ddr2gb_gbaddr_wen,
        .ddr2gb_gbaddr_rdata,

        //  register interface - GB2LB_CTRL
        .gb2lb_ctrl_wen,
        .gb2lb_ctrl_rdata,
        //  register interface - GB2LB_SRC0
        .gb2lb_src0_wen,
        .gb2lb_src0_rdata,
        //  register interface - GB2LB_SRC1
        .gb2lb_src1_wen,
        .gb2lb_src1_rdata,
        //  register interface - GB2LB_DEST
        .gb2lb_dest_wen,
        .gb2lb_dest_rdata,

        //  register interface - APE_CTRL
        .ape_ctrl_wen,
        .ape_ctrl_rdata,
        //  register interface - APE_SRC
        .ape_src_wen,
        .ape_src_rdata,
        //  register interface - APE_DEST
        .ape_dest_wen,
        .ape_dest_rdata,
        //  register interface - APE_DEST
        .ape_imm_wen,
        .ape_imm_rdata,

        //  register interface - CONV_K_SIZE0
        .conv_k_size0_wen,
        .conv_k_size0_rdata,
        //  register interface - CONV_K_SIZE1
        .conv_k_size1_wen,
        .conv_k_size1_rdata,
        //  register interface - CONV_K_LOAD
        .conv_k_load_wen,
        .conv_k_load_rdata,
        //  register interface - CONV_FMAP
        .conv_fmap_wen,
        .conv_fmap_rdata,
        //  register interface - CONV_STRIDE
        .conv_stride_wen,
        .conv_stride_rdata,
        //  register interface - CONV_PAD_SIZE
        .conv_pad_size_wen,
        .conv_pad_size_rdata,
        //  register interface - CONV_PAD_NUM
        .conv_pad_num_wen,
        .conv_pad_num_rdata,

        //  register interface - FC_SRC
        .fc_src_wen,
        .fc_src_rdata,

        //  register interface - RESHAPE_SRC0
        .reshape_src0_wen,
        .reshape_src0_rdata,
        //  register interface - RESHAPE_SRC1
        .reshape_src1_wen,
        .reshape_src1_rdata,

        //  register interface - LPE_SRC0
        .lpe_src0_wen,
        .lpe_src0_rdata,
        //  register interface - LPE_SRC1
        .lpe_src1_wen,
        .lpe_src1_rdata,
        //  register interface - LPE_DEST0
        .lpe_dest0_wen,
        .lpe_dest0_rdata,
        //  register interface - LPE_DEST1
        .lpe_dest1_wen,
        .lpe_dest1_rdata,
        //  register interface - LPE_MODE
        .lpe_mode_wen,
        .lpe_mode_rdata,
        //  register interface - LPE_LEAP0
        .lpe_leap0_wen,
        .lpe_leap0_rdata,
        //  register interface - LPE_LEAP1
        .lpe_leap1_wen,
        .lpe_leap1_rdata,
        //  register interface - LPE_LEAP2
        .lpe_leap2_wen,
        .lpe_leap2_rdata,
        //  register interface - LPE_LEAP3
        .lpe_leap3_wen,
        .lpe_leap3_rdata,
        //  register interface - LPE_LEAP4
        .lpe_leap4_wen,
        .lpe_leap4_rdata,
        //  register interface - LPE_LEAP5
        .lpe_leap5_wen,
        .lpe_leap5_rdata,
        //  register interface - LPE_LEAP6
        .lpe_leap6_wen,
        .lpe_leap6_rdata,
        //  register interface - LPE_LEAP7
        .lpe_leap7_wen,
        .lpe_leap7_rdata,

        //  register interface - WBLOAD_DDR_ADDR0
        .wbload_ddr_addr0_wen,
        .wbload_ddr_addr0_rdata,
        //  register interface - WBLOAD_DDR_ADDR1
        .wbload_ddr_addr1_wen,
        .wbload_ddr_addr1_rdata,
        //  register interface - WBLOAD_KERNEL
        .wbload_kernel_wen,
        .wbload_kernel_rdata,
        //  register interface - WBLOAD_CHANNEL
        .wbload_channel_wen,
        .wbload_channel_rdata,

        //  register interface - COMP_CTRL
        .comp_ctrl_wen,
        .comp_ctrl_rdata,
        //  register interface - COMP_PRECISION
        .comp_precision_wen,
        .comp_precision_rdata,

        //  register interface - GLB_Status
        .glb_status_wen         (),
        .glb_status_rdata,
        //  register interface - GLB_Intr
        .glb_intr_wen,
        .glb_intr_rdata,
        //  register interface - GLB_ENABLE_ROW
        .glb_enable_row_wen,
        .glb_enable_row_rdata,
        //  register interface - GLB_ENABLE_COL
        .glb_enable_col_wen,
        .glb_enable_col_rdata,

        //  register interface - BUF_MASKX
        .buf_maskx_wen,
        .buf_maskx_rdata,
        //  register interface - BUF_MASK0
        .buf_mask0_wen,
        .buf_mask0_rdata,
        //  register interface - BUF_MASK1
        .buf_mask1_wen,
        .buf_mask1_rdata,
        //  register interface - BUF_MASK2
        .buf_mask2_wen,
        .buf_mask2_rdata,
        //  register interface - BUF_MASK3
        .buf_mask3_wen,
        .buf_mask3_rdata,
        //  register interface - BUF_MASK4
        .buf_mask4_wen,
        .buf_mask4_rdata,
        //  register interface - BUF_MASK5
        .buf_mask5_wen,
        .buf_mask5_rdata,
        //  register interface - BUF_MASK6
        .buf_mask6_wen,
        .buf_mask6_rdata,
        //  register interface - BUF_MASK7
        .buf_mask7_wen,
        .buf_mask7_rdata
    );

    dla_regif_soc2gb regif_soc2gb (
        //  global signals
        .clk,
        .rst,

        //  register interface - SOC2GB_CONFIG
        .soc2gb_config_wen,
        .soc2gb_config_rdata,

        //  register interface
        .regif_soc2gb_addr      (regif_addr[19:0]),
        .regif_soc2gb_wen,
        .regif_soc2gb_ren,
        .regif_soc2gb_rdata,
        .regif_soc2gb_rvalid,
        .regif_wdata,

        //  global buffer interface
        .bif_gb_soc2gb_ab_sel,
        .bif_gb_soc2gb_addr,
        .bif_gb_soc2gb_ram_sel,
        .bif_gb_soc2gb_wen,
        .bif_gb_soc2gb_ren,
        .bif_gb_soc2gb_wdata,
        .bif_gb_soc2gb_rdata
    );

    dla_regif_ddr2gb regif_ddr2gb(
        //  global signals
        .clk,
        .rst,

        //  register interface - DDR2GB_CTRL
        .ddr2gb_ctrl_wen,
        .ddr2gb_ctrl_rdata,

        //  register interface - DDR2GB_DDR_ADDR0
        .ddr2gb_addr0_wen,
        .ddr2gb_addr0_rdata,

        //  register interface - DDR2GB_DDR_ADDR1
        .ddr2gb_addr1_wen,
        .ddr2gb_addr1_rdata,

        //  register interface - DDR2GB_GB_ADDR
        .ddr2gb_gbaddr_wen,
        .ddr2gb_gbaddr_rdata,

        //  register interface - general
        .regif_wdata,

        //  staging registers
        .go_mov_ddr2gb,
        .stgr_ddr2gb_ddr_addr,
        .stgr_ddr2gb_ab_sel,
        .stgr_ddr2gb_gb_addr,
        .stgr_ddr2gb_gb_ramidx,
        .stgr_ddr2gb_dir,
        .stgr_ddr2gb_len
    );

    dla_regif_gb2lb regif_gb2lb (
        //  global signals
        .clk,
        .rst,

        //  register interface - GB2LB_CTRL
        .gb2lb_ctrl_wen,
        .gb2lb_ctrl_rdata,

        //  register interface - GB2LB_SRC0
        .gb2lb_src0_wen,
        .gb2lb_src0_rdata,

        //  register interface - GB2LB_SRC1
        .gb2lb_src1_wen,
        .gb2lb_src1_rdata,

        //  register interface - GB2LB_DEST
        .gb2lb_dest_wen,
        .gb2lb_dest_rdata,

        //  register interface - general
        .regif_wdata,

        //  staging registers
        .go_mov_gb2lb,
        .stgr_gb2lb_gb_addr,
        .stgr_gb2lb_gb_skip,
        .stgr_gb2lb_lb_addr,
        .stgr_gb2lb_lb_skip,
        .stgr_gb2lb_len,
        .stgr_gb2lb_iter
    );

    dla_regif_ape regif_ape (
        //  global signals
        .clk,
        .rst,

        //  register interface - APE_CTRL
        .ape_ctrl_wen,
        .ape_ctrl_rdata,

        //  register interface - APE_SRC
        .ape_src_wen,
        .ape_src_rdata,

        //  register interface - APE_DEST
        .ape_dest_wen,
        .ape_dest_rdata,

        //  register interface - APE_IMM
        .ape_imm_wen,
        .ape_imm_rdata,

        //  register interface - general
        .regif_wdata,

        //  staging registers
        .go_comp_ape,
        .stgr_ape_gb_addr_sa,
        .stgr_ape_gb_addr_sb,
        .stgr_ape_gb_addr_d,
        .stgr_ape_len,
        .stgr_ape_imm,
        .stgr_ape_mode
    );

    dla_regif_glb regif_glb (
        //  global signals
        .clk,
        .rst,

        //  control signals
        .stgr_enable_row,
        .stgr_enable_col,
        .stgr_status,

        .stgr_precision_ape_shift,
        .stgr_precision_kpe_shift,
        .stgr_precision_ifmap,
        .stgr_precision_weight,

        //  register interface - GLB_Status
        // .glb_status_wen,
        .glb_status_rdata,

        //  register interface - GLB_Intr
        .glb_intr_wen,
        .glb_intr_rdata,

        //  register interface - GLB_ENABLE_ROW
        .glb_enable_row_wen,
        .glb_enable_row_rdata,

        //  register interface - GLB_ENABLE_COL
        .glb_enable_col_wen,
        .glb_enable_col_rdata,

        //  register interface - COMP_PRECISION
        .comp_precision_wen,
        .comp_precision_rdata,

        //  register interface - general
        .regif_wdata,

        //  subunit go signals
        .go_mov_ddr2gb,
        .go_mov_gb2lb,
        .go_comp_conv,
        .go_comp_fc,
        .go_comp_ape,
        .go_comp_reshape,

        //  subunit start signals
        .start_mov_gb2lb,
        .start_mov_ddr2gb,
        .start_comp_conv,
        .start_comp_fc,
        .start_comp_ape,
        .start_comp_reshape,

        //  subunit complete signals
        .complete_mov_gb2lb,
        .complete_mov_ddr2gb,
        .complete_comp_conv,
        .complete_comp_fc,
        .complete_comp_ape,
        .complete_comp_reshape,
        .complete_lpe,

        //  interrupt
        .interrupt
    );

    dla_regif_buf regif_buf (
        //  global signals
        .clk,
        .rst,

        //  control signals
        .go             (go_buf),
        .stgr_buf_mask,
        .stgr_status,

        //  register interface - BUF_MASKX
        .buf_maskx_wen,
        .buf_maskx_rdata,

        //  register interface - BUF_MASK0
        .buf_mask0_wen,
        .buf_mask0_rdata,

        //  register interface - BUF_MASK1
        .buf_mask1_wen,
        .buf_mask1_rdata,

        //  register interface - BUF_MASK2
        .buf_mask2_wen,
        .buf_mask2_rdata,

        //  register interface - BUF_MASK3
        .buf_mask3_wen,
        .buf_mask3_rdata,

        //  register interface - BUF_MASK4
        .buf_mask4_wen,
        .buf_mask4_rdata,

        //  register interface - BUF_MASK5
        .buf_mask5_wen,
        .buf_mask5_rdata,

        //  register interface - BUF_MASK6
        .buf_mask6_wen,
        .buf_mask6_rdata,

        //  register interface - BUF_MASK7
        .buf_mask7_wen,
        .buf_mask7_rdata,

        //  register interface - general
        .regif_wdata
    );

    dla_regif_comp regif_comp (
        //  global signals
        .clk,
        .rst,

        //  register interface - CONV_K_SIZE0
        .conv_k_size0_wen,
        .conv_k_size0_rdata,
        //  register interface - CONV_K_SIZE1
        .conv_k_size1_wen,
        .conv_k_size1_rdata,
        //  register interface - CONV_K_LOAD
        .conv_k_load_wen,
        .conv_k_load_rdata,
        //  register interface - CONV_FMAP
        .conv_fmap_wen,
        .conv_fmap_rdata,
        //  register interface - CONV_STRIDE
        .conv_stride_wen,
        .conv_stride_rdata,
        //  register interface - CONV_PAD_SIZE
        .conv_pad_size_wen,
        .conv_pad_size_rdata,
        //  register interface - CONV_PAD_NUM
        .conv_pad_num_wen,
        .conv_pad_num_rdata,

        //  register interface - FC_SRC
        .fc_src_wen,
        .fc_src_rdata,

        //  register interface - RESHAPE_SRC0
        .reshape_src0_wen,
        .reshape_src0_rdata,
        //  register interface - RESHAPE_SRC1
        .reshape_src1_wen,
        .reshape_src1_rdata,

        //  register interface - LPE_SRC0
        .lpe_src0_wen,
        .lpe_src0_rdata,
        //  register interface - LPE_SRC1
        .lpe_src1_wen,
        .lpe_src1_rdata,
        //  register interface - LPE_DEST0
        .lpe_dest0_wen,
        .lpe_dest0_rdata,
        //  register interface - LPE_DEST1
        .lpe_dest1_wen,
        .lpe_dest1_rdata,
        //  register interface - LPE_MODE
        .lpe_mode_wen,
        .lpe_mode_rdata,
        //  register interface - LPE_LEAP0
        .lpe_leap0_wen,
        .lpe_leap0_rdata,
        //  register interface - LPE_LEAP1
        .lpe_leap1_wen,
        .lpe_leap1_rdata,
        //  register interface - LPE_LEAP2
        .lpe_leap2_wen,
        .lpe_leap2_rdata,
        //  register interface - LPE_LEAP3
        .lpe_leap3_wen,
        .lpe_leap3_rdata,
        //  register interface - LPE_LEAP4
        .lpe_leap4_wen,
        .lpe_leap4_rdata,
        //  register interface - LPE_LEAP5
        .lpe_leap5_wen,
        .lpe_leap5_rdata,
        //  register interface - LPE_LEAP6
        .lpe_leap6_wen,
        .lpe_leap6_rdata,
        //  register interface - LPE_LEAP7
        .lpe_leap7_wen,
        .lpe_leap7_rdata,

        //  register interface - WBLOAD_DDR_ADDR0
        .wbload_ddr_addr0_wen,
        .wbload_ddr_addr0_rdata,
        //  register interface - WBLOAD_DDR_ADDR1
        .wbload_ddr_addr1_wen,
        .wbload_ddr_addr1_rdata,
        //  register interface - WBLOAD_KERNEL
        .wbload_kernel_wen,
        .wbload_kernel_rdata,
        //  register interface - WBLOAD_CHANNEL
        .wbload_channel_wen,
        .wbload_channel_rdata,

        //  register interface - COMP_CTRL
        .comp_ctrl_wen,
        .comp_ctrl_rdata,

        //  register interface - general
        .regif_wdata,

        //  subunit go signals
        .go_comp_conv,
        .go_comp_fc,
        .go_comp_reshape,

        //  staging registers - CONV
        .stgr_conv_k_hori_len,
        .stgr_conv_k_vert_len,
        .stgr_conv_k_hori_delta,
        .stgr_conv_k_vert_delta,
        .stgr_conv_k_size_len,

        .stgr_conv_wbload_cmd,

        .stgr_conv_of_hori_len,
        .stgr_conv_of_vert_len,
        .stgr_conv_if_hori_len,
        .stgr_conv_if_vert_len,

        .stgr_conv_hori_stride,
        .stgr_conv_vert_stride,
        .stgr_conv_slice_max,

        .stgr_conv_pad_up,
        .stgr_conv_pad_down,
        .stgr_conv_pad_left,
        .stgr_conv_pad_right,
        .stgr_conv_pad_num,

        .stgr_conv_wait_lpe,

        .stgr_pool_mode,
        .stgr_pool_enable,

        //  staging registers - FC
        .stgr_fc_addr,
        .stgr_fc_len,
        .stgr_fc_wait_lpe,

        //  staging registers - RESHAPE
        .stgr_reshape_addr,
        .stgr_reshape_len,
        .stgr_reshape_iter,
        .stgr_reshape_skip,
        .stgr_reshape_wait_lpe,

        //  staging registers - LPE
        .start_lpe,
        .stgr_lpe_src_addr,
        .stgr_lpe_src_len,
        .stgr_lpe_src_skip,
        .stgr_lpe_src_iter,
        .stgr_lpe_dest_addr,
        .stgr_lpe_dest_len,
        .stgr_lpe_dest_skip,
        .stgr_lpe_dest_iter,
        .stgr_lpe_leap,
        .stgr_lpe_overlay,
        .stgr_lpe_relu,
        .stgr_lpe_acc_bypass,
        .stgr_lpe_sprmps,

        //  staging registers - WB_LOAD
        .stgr_wbload_ddr_addr,
        .stgr_wbload_wb_cnt_default,
        .stgr_wbload_kpe_cnt,
        .stgr_wbload_kpe_mask,
        .stgr_wbload_kpe_act_num,
        .stgr_wbload_cpe_idx,
        .stgr_wbload_cpe_cnt
    );

endmodule: dla_regif
