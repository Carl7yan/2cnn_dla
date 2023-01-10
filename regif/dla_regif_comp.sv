// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_regif_comp.sv
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

module dla_regif_comp
    import PKG_dla_regmap :: *;
    import PKG_dla_typedef :: *;
(
    //  global signals
    input  logic    clk,
    input  logic    rst,

    //  register interface - CONV_K_SIZE0
    input  logic        conv_k_size0_wen,
    output logic [31:0] conv_k_size0_rdata,
    //  register interface - CONV_K_SIZE1
    input  logic        conv_k_size1_wen,
    output logic [31:0] conv_k_size1_rdata,
    //  register interface - CONV_K_LOAD
    input  logic        conv_k_load_wen,
    output logic [31:0] conv_k_load_rdata,
    //  register interface - CONV_FMAP
    input  logic        conv_fmap_wen,
    output logic [31:0] conv_fmap_rdata,
    //  register interface - CONV_STRIDE
    input  logic        conv_stride_wen,
    output logic [31:0] conv_stride_rdata,
    //  register interface - CONV_PAD_SIZE
    input  logic        conv_pad_size_wen,
    output logic [31:0] conv_pad_size_rdata,
    //  register interface - CONV_PAD_NUM
    input  logic        conv_pad_num_wen,
    output logic [31:0] conv_pad_num_rdata,

    //  register interface - FC_SRC
    input  logic        fc_src_wen,
    output logic [31:0] fc_src_rdata,

    //  register interface - RESHAPE_SRC0
    input  logic        reshape_src0_wen,
    output logic [31:0] reshape_src0_rdata,
    //  register interface - RESHAPE_SRC1
    input  logic        reshape_src1_wen,
    output logic [31:0] reshape_src1_rdata,

    //  register interface - LPE_SRC0
    input  logic        lpe_src0_wen,
    output logic [31:0] lpe_src0_rdata,
    //  register interface - LPE_SRC1
    input  logic        lpe_src1_wen,
    output logic [31:0] lpe_src1_rdata,
    //  register interface - LPE_DEST0
    input  logic        lpe_dest0_wen,
    output logic [31:0] lpe_dest0_rdata,
    //  register interface - LPE_DEST1
    input  logic        lpe_dest1_wen,
    output logic [31:0] lpe_dest1_rdata,
    //  register interface - LPE_MODE
    input  logic        lpe_mode_wen,
    output logic [31:0] lpe_mode_rdata,
    //  register interface - LPE_LEAP0
    input  logic        lpe_leap0_wen,
    output logic [31:0] lpe_leap0_rdata,
    //  register interface - LPE_LEAP1
    input  logic        lpe_leap1_wen,
    output logic [31:0] lpe_leap1_rdata,
    //  register interface - LPE_LEAP2
    input  logic        lpe_leap2_wen,
    output logic [31:0] lpe_leap2_rdata,
    //  register interface - LPE_LEAP3
    input  logic        lpe_leap3_wen,
    output logic [31:0] lpe_leap3_rdata,
    //  register interface - LPE_LEAP4
    input  logic        lpe_leap4_wen,
    output logic [31:0] lpe_leap4_rdata,
    //  register interface - LPE_LEAP5
    input  logic        lpe_leap5_wen,
    output logic [31:0] lpe_leap5_rdata,
    //  register interface - LPE_LEAP6
    input  logic        lpe_leap6_wen,
    output logic [31:0] lpe_leap6_rdata,
    //  register interface - LPE_LEAP7
    input  logic        lpe_leap7_wen,
    output logic [31:0] lpe_leap7_rdata,

    //  register interface - WBLOAD_DDR_ADDR0
    input  logic        wbload_ddr_addr0_wen,
    output logic [31:0] wbload_ddr_addr0_rdata,
    //  register interface - WBLOAD_DDR_ADDR1
    input  logic        wbload_ddr_addr1_wen,
    output logic [31:0] wbload_ddr_addr1_rdata,
    //  register interface - WBLOAD_KERNEL
    input  logic        wbload_kernel_wen,
    output logic [31:0] wbload_kernel_rdata,
    //  register interface - WBLOAD_CHANNEL
    input  logic        wbload_channel_wen,
    output logic [31:0] wbload_channel_rdata,

    //  register interface - COMP_CTRL
    input  logic        comp_ctrl_wen,
    output logic [31:0] comp_ctrl_rdata,

    //  register interface - general
    input  logic [31:0] regif_wdata,

    //  subunit go signals
    output logic        go_comp_conv,//VCS coverage off
    output logic        go_comp_fc,
    output logic        go_comp_reshape,

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

    output logic        stgr_pool_mode,
    output logic        stgr_pool_enable,

    //  staging registers - FC
    output logic [10:0] stgr_fc_addr,
    output logic [10:0] stgr_fc_len,
    output logic [4:0]  stgr_fc_wait_lpe,

    //  staging registers - RESHAPE
    output logic [10:0] stgr_reshape_addr,
    output logic [10:0] stgr_reshape_len,
    output logic [5:0]  stgr_reshape_iter,
    output logic [5:0]  stgr_reshape_skip,
    output logic [4:0]  stgr_reshape_wait_lpe,

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
    output logic [3:0]  stgr_wbload_cpe_cnt//VCS coverage on
);

    REG_CONV_K_SiZE0_t      reg_conv_k_size0;
    REG_CONV_K_SIZE1_t      reg_conv_k_size1;
    REG_CONV_K_LOAD_t       reg_conv_k_load;
    REG_CONV_FMAP_t         reg_conv_fmap;
    REG_CONV_STRIDE_t       reg_conv_stride;
    REG_CONV_PAD_SIZE_t     reg_conv_pad_size;
    REG_CONV_PAD_NUM_t      reg_conv_pad_num;

    REG_FC_SRC_t            reg_fc_src;

    REG_RESHAPE_SRC0_t      reg_reshape_src0;
    REG_RESHAPE_SRC1_t      reg_reshape_src1;

    REG_LPE_SRC0_t          reg_lpe_src0;
    REG_LPE_SRC1_t          reg_lpe_src1;
    REG_LPE_DEST0_t         reg_lpe_dest0;
    REG_LPE_DEST1_t         reg_lpe_dest1;
    REG_LPE_MODE_t          reg_lpe_mode;
    REG_LPE_LEAP0_t         reg_lpe_leap0;
    REG_LPE_LEAP1_t         reg_lpe_leap1;
    REG_LPE_LEAP2_t         reg_lpe_leap2;
    REG_LPE_LEAP3_t         reg_lpe_leap3;
    REG_LPE_LEAP4_t         reg_lpe_leap4;
    REG_LPE_LEAP5_t         reg_lpe_leap5;
    REG_LPE_LEAP6_t         reg_lpe_leap6;
    REG_LPE_LEAP7_t         reg_lpe_leap7;

    REG_WBLOAD_DDR_ADDR0_t  reg_wbload_ddr_addr0;
    REG_WBLOAD_DDR_ADDR1_t  reg_wbload_ddr_addr1;
    REG_WBLOAD_KERNEL_t     reg_wbload_kernel;
    REG_WBLOAD_CHANNEL_t    reg_wbload_channel;

    REG_COMP_CTRL_t         reg_comp_ctrl;

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_conv_k_size0
        if (rst) begin
            reg_conv_k_size0.hori_delta <= 6'd0;
            reg_conv_k_size0.vert_delta <= 6'd0;
            reg_conv_k_size0.hori_len   <= 6'd0;
            reg_conv_k_size0.vert_len   <= 6'd0;
        end
        else if (conv_k_size0_wen) begin
            reg_conv_k_size0.hori_delta <= regif_wdata[29:24];
            reg_conv_k_size0.vert_delta <= regif_wdata[21:16];
            reg_conv_k_size0.hori_len   <= regif_wdata[13:8];
            reg_conv_k_size0.vert_len   <= regif_wdata[5:0];
        end
    end: b_reg_conv_k_size0

    assign conv_k_size0_rdata = {
        2'd0, reg_conv_k_size0.hori_delta,
        2'd0, reg_conv_k_size0.vert_delta,
        2'd0, reg_conv_k_size0.hori_len,
        2'd0, reg_conv_k_size0.vert_len
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_conv_k_size1
        if (rst) begin
            reg_conv_k_size1.size_len  <= 12'd0;
            reg_conv_k_size1.slice_max <= 4'd0;
        end
        else if (conv_k_size1_wen) begin
            reg_conv_k_size1.size_len  <= regif_wdata[27:16];
            reg_conv_k_size1.slice_max <= regif_wdata[3:0];
        end
    end: b_reg_conv_k_size1

    assign conv_k_size1_rdata = {
        4'd0, reg_conv_k_size1.size_len,
        12'd0, reg_conv_k_size1.slice_max
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_conv_k_load
        if (rst) begin
            reg_conv_k_load.wbload_cmd <= 2'd0;
        end
        else if (conv_k_load_wen) begin
            reg_conv_k_load.wbload_cmd <= regif_wdata[1:0];
        end
    end: b_reg_conv_k_load

    assign conv_k_load_rdata = {
        30'd0, reg_conv_k_load.wbload_cmd
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_conv_fmap
        if (rst) begin
            reg_conv_fmap.if_hori_len <= 6'd0;
            reg_conv_fmap.if_vert_len <= 6'd0;
            reg_conv_fmap.of_hori_len <= 6'd0;
            reg_conv_fmap.of_vert_len <= 6'd0;
        end
        else if (conv_fmap_wen) begin
            reg_conv_fmap.if_hori_len <= regif_wdata[29:24];
            reg_conv_fmap.if_vert_len <= regif_wdata[21:16];
            reg_conv_fmap.of_hori_len <= regif_wdata[13:8];
            reg_conv_fmap.of_vert_len <= regif_wdata[5:0];
        end
    end: b_reg_conv_fmap

    assign conv_fmap_rdata = {
        2'd0, reg_conv_fmap.if_hori_len,
        2'd0, reg_conv_fmap.if_vert_len,
        2'd0, reg_conv_fmap.of_hori_len,
        2'd0, reg_conv_fmap.of_vert_len
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_conv_stride
        if (rst) begin
            reg_conv_stride.hori_stride <= 6'd0;
            reg_conv_stride.vert_stride <= 6'd0;
        end
        else if (conv_stride_wen) begin
            reg_conv_stride.hori_stride <= regif_wdata[13:8];
            reg_conv_stride.vert_stride <= regif_wdata[5:0];
        end
    end: b_reg_conv_stride

    assign conv_stride_rdata = {
        18'd0, reg_conv_stride.hori_stride,
        2'd0, reg_conv_stride.vert_stride
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_conv_pad_size
        if (rst) begin
            reg_conv_pad_size.pad_up    <= 4'd0;
            reg_conv_pad_size.pad_down  <= 4'd0;
            reg_conv_pad_size.pad_left  <= 4'd0;
            reg_conv_pad_size.pad_right <= 4'd0;
        end
        else if (conv_pad_size_wen) begin
            reg_conv_pad_size.pad_up    <= regif_wdata[27:24];
            reg_conv_pad_size.pad_down  <= regif_wdata[19:16];
            reg_conv_pad_size.pad_left  <= regif_wdata[11:8];
            reg_conv_pad_size.pad_right <= regif_wdata[3:0];
        end
    end: b_reg_conv_pad_size

    assign conv_pad_size_rdata = {
        4'd0, reg_conv_pad_size.pad_up,
        4'd0, reg_conv_pad_size.pad_down,
        4'd0, reg_conv_pad_size.pad_left,
        4'd0, reg_conv_pad_size.pad_right
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_conv_pad_num
        if (rst) begin
            reg_conv_pad_num.pad_num <= 16'd0;
        end
        else if (conv_pad_num_wen) begin
            reg_conv_pad_num.pad_num <= regif_wdata[15:0];
        end
    end: b_reg_conv_pad_num

    assign conv_pad_num_rdata = {
        16'd0, reg_conv_pad_num.pad_num
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_fc_src
        if (rst) begin
            reg_fc_src.length <= 16'd0;
            reg_fc_src.addr   <= 16'd0;
        end
        else if (fc_src_wen) begin
            reg_fc_src.length <= regif_wdata[26:16];
            reg_fc_src.addr   <= regif_wdata[10:0];
        end
    end: b_reg_fc_src

    assign fc_src_rdata = {
        5'd0, reg_fc_src.length,
        5'd0, reg_fc_src.addr
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_reshape_src0
        if (rst) begin
            reg_reshape_src0.length <= 16'd0;
            reg_reshape_src0.addr   <= 16'd0;
        end
        else if (reshape_src0_wen) begin
            reg_reshape_src0.length <= regif_wdata[26:16];
            reg_reshape_src0.addr   <= regif_wdata[10:0];
        end
    end: b_reg_reshape_src0

    assign reshape_src0_rdata = {
        5'd0, reg_reshape_src0.length,
        5'd0, reg_reshape_src0.addr
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_reshape_src1
        if (rst) begin
            reg_reshape_src1.iter <= 6'd0;
            reg_reshape_src1.skip <= 6'd0;
        end
        else if (reshape_src1_wen) begin
            reg_reshape_src1.iter <= regif_wdata[21:16];
            reg_reshape_src1.skip <= regif_wdata[5:0];
        end
    end: b_reg_reshape_src1

    assign reshape_src1_rdata = {
        10'd0, reg_reshape_src1.iter,
        10'd0, reg_reshape_src1.skip
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_src0
        if (rst) begin
            reg_lpe_src0.length <= '0;
            reg_lpe_src0.addr   <= '0;
        end
        else if (lpe_src0_wen) begin
            reg_lpe_src0.length <= regif_wdata[28:16];
            reg_lpe_src0.addr   <= regif_wdata[12:0];
        end
    end: b_reg_lpe_src0

    assign lpe_src0_rdata = {
        3'd0, reg_lpe_src0.length,
        3'd0, reg_lpe_src0.addr
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_src1
        if (rst) begin
            reg_lpe_src1.iter <= '0;
            reg_lpe_src1.skip <= '0;
        end
        else if (lpe_src1_wen) begin
            reg_lpe_src1.iter <= regif_wdata[28:16];
            reg_lpe_src1.skip <= regif_wdata[12:0];
        end
    end: b_reg_lpe_src1

    assign lpe_src1_rdata = {
        3'd0, reg_lpe_src1.iter,
        3'd0, reg_lpe_src1.skip
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_dest0
        if (rst) begin
            reg_lpe_dest0.length <= '0;
            reg_lpe_dest0.addr   <= '0;
        end
        else if (lpe_dest0_wen) begin
            reg_lpe_dest0.length <= regif_wdata[28:16];
            reg_lpe_dest0.addr   <= regif_wdata[12:0];
        end
    end: b_reg_lpe_dest0

    assign lpe_dest0_rdata = {
        3'd0, reg_lpe_dest0.length,
        3'd0, reg_lpe_dest0.addr
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_dest1
        if (rst) begin
            reg_lpe_dest1.iter <= '0;
            reg_lpe_dest1.skip <= '0;
        end
        else if (lpe_dest1_wen) begin
            reg_lpe_dest1.iter <= regif_wdata[28:16];
            reg_lpe_dest1.skip <= regif_wdata[12:0];
        end
    end: b_reg_lpe_dest1

    assign lpe_dest1_rdata = {
        3'd0, reg_lpe_dest1.iter,
        3'd0, reg_lpe_dest1.skip
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_mode
        if (rst) begin
            reg_lpe_mode.leap_clone <= 1'b0;
            reg_lpe_mode.relu       <= 1'b0;
            reg_lpe_mode.addr_merge <= 1'b0;
            reg_lpe_mode.acc_bypass <= 1'b0;
            reg_lpe_mode.overlay    <= 7'd0;
            reg_lpe_mode.sprmps     <= 2'b0;
            reg_lpe_mode.leap       <= 13'd0;
        end
        else if (lpe_mode_wen) begin
            reg_lpe_mode.leap_clone <= regif_wdata[31];
            reg_lpe_mode.relu       <= regif_wdata[30];
            reg_lpe_mode.addr_merge <= regif_wdata[29];
            reg_lpe_mode.acc_bypass <= regif_wdata[28];
            reg_lpe_mode.overlay    <= regif_wdata[26:20];
            reg_lpe_mode.leap       <= regif_wdata[12:0];
            if (regif_wdata[17:16] != 2'd3) begin
                reg_lpe_mode.sprmps <= regif_wdata[17:16];
            end
        end
    end: b_reg_lpe_mode

    assign lpe_mode_rdata = {
        reg_lpe_mode.leap_clone,
        reg_lpe_mode.relu,
        reg_lpe_mode.addr_merge,
        reg_lpe_mode.acc_bypass,
        10'd0, reg_lpe_mode.sprmps,
        3'd0, reg_lpe_mode.leap
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_leap0
        if (rst) begin
            reg_lpe_leap0.leap1 <= 13'd0;
            reg_lpe_leap0.leap0 <= 13'd0;
        end
        else if (lpe_leap0_wen) begin
            reg_lpe_leap0.leap1 <= regif_wdata[28:16];
            reg_lpe_leap0.leap0 <= regif_wdata[12:0];
        end
    end: b_reg_lpe_leap0

    assign lpe_leap0_rdata = {
        3'd0, reg_lpe_leap0.leap1,
        3'd0, reg_lpe_leap0.leap0
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_leap1
        if (rst) begin
            reg_lpe_leap1.leap3 <= 13'd0;
            reg_lpe_leap1.leap2 <= 13'd0;
        end
        else if (lpe_leap1_wen) begin
            reg_lpe_leap1.leap3 <= regif_wdata[28:16];
            reg_lpe_leap1.leap2 <= regif_wdata[12:0];
        end
    end: b_reg_lpe_leap1

    assign lpe_leap1_rdata = {
        3'd0, reg_lpe_leap1.leap3,
        3'd0, reg_lpe_leap1.leap2
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_leap2
        if (rst) begin
            reg_lpe_leap2.leap5 <= 13'd0;
            reg_lpe_leap2.leap4 <= 13'd0;
        end
        else if (lpe_leap2_wen) begin
            reg_lpe_leap2.leap5 <= regif_wdata[28:16];
            reg_lpe_leap2.leap4 <= regif_wdata[12:0];
        end
    end: b_reg_lpe_leap2

    assign lpe_leap2_rdata = {
        3'd0, reg_lpe_leap2.leap5,
        3'd0, reg_lpe_leap2.leap4
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_leap3
        if (rst) begin
            reg_lpe_leap3.leap7 <= 13'd0;
            reg_lpe_leap3.leap6 <= 13'd0;
        end
        else if (lpe_leap3_wen) begin
            reg_lpe_leap3.leap7 <= regif_wdata[28:16];
            reg_lpe_leap3.leap6 <= regif_wdata[12:0];
        end
    end: b_reg_lpe_leap3

    assign lpe_leap3_rdata = {
        3'd0, reg_lpe_leap3.leap7,
        3'd0, reg_lpe_leap3.leap6
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_leap4
        if (rst) begin
            reg_lpe_leap4.leap9 <= 13'd0;
            reg_lpe_leap4.leap8 <= 13'd0;
        end
        else if (lpe_leap4_wen) begin
            reg_lpe_leap4.leap9 <= regif_wdata[28:16];
            reg_lpe_leap4.leap8 <= regif_wdata[12:0];
        end
    end: b_reg_lpe_leap4

    assign lpe_leap4_rdata = {
        3'd0, reg_lpe_leap4.leap9,
        3'd0, reg_lpe_leap4.leap8
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_leap5
        if (rst) begin
            reg_lpe_leap5.leap11 <= 13'd0;
            reg_lpe_leap5.leap10 <= 13'd0;
        end
        else if (lpe_leap5_wen) begin
            reg_lpe_leap5.leap11 <= regif_wdata[28:16];
            reg_lpe_leap5.leap10 <= regif_wdata[12:0];
        end
    end: b_reg_lpe_leap5

    assign lpe_leap5_rdata = {
        3'd0, reg_lpe_leap5.leap11,
        3'd0, reg_lpe_leap5.leap10
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_leap6
        if (rst) begin
            reg_lpe_leap6.leap13 <= 13'd0;
            reg_lpe_leap6.leap12 <= 13'd0;
        end
        else if (lpe_leap6_wen) begin
            reg_lpe_leap6.leap13 <= regif_wdata[28:16];
            reg_lpe_leap6.leap12 <= regif_wdata[12:0];
        end
    end: b_reg_lpe_leap6

    assign lpe_leap6_rdata = {
        3'd0, reg_lpe_leap6.leap13,
        3'd0, reg_lpe_leap6.leap12
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_lpe_leap7
        if (rst) begin
            reg_lpe_leap7.leap14 <= 13'd0;
        end
        else if (lpe_leap7_wen) begin
            reg_lpe_leap7.leap14 <= regif_wdata[12:0];
        end
    end: b_reg_lpe_leap7

    assign lpe_leap7_rdata = {
        3'd0, reg_lpe_leap7.leap14,
        16'd0
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_wbload_ddr_addr0
        if (rst) begin
            reg_wbload_ddr_addr0.addr0 <= 32'd0;
        end
        else if (wbload_ddr_addr0_wen) begin
            reg_wbload_ddr_addr0.addr0 <= regif_wdata;
        end
    end: b_reg_wbload_ddr_addr0

    assign wbload_ddr_addr0_rdata = {
        reg_wbload_ddr_addr0.addr0
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_wbload_ddr_addr1
        if (rst) begin
            reg_wbload_ddr_addr1.addr1 <= 32'd0;
        end
        else if (wbload_ddr_addr1_wen) begin
            reg_wbload_ddr_addr1.addr1 <= regif_wdata[21:0];
        end
    end: b_reg_wbload_ddr_addr1

    assign wbload_ddr_addr1_rdata = {
        10'd0, reg_wbload_ddr_addr1.addr1
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_wbload_kernel
        if (rst) begin
            reg_wbload_kernel.kpe_cnt <= 2'd0;
            reg_wbload_kernel.mask    <= 16'd0;
        end
        else if (wbload_kernel_wen) begin
            reg_wbload_kernel.kpe_cnt <= regif_wdata[29:28];
            reg_wbload_kernel.mask    <= regif_wdata[15:0];
        end
    end: b_reg_wbload_kernel

    assign wbload_kernel_rdata = {
        2'd0, reg_wbload_kernel.kpe_cnt,
        12'd0, reg_wbload_kernel.mask
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_wbload_channel
        if (rst) begin
            reg_wbload_channel.idx <= 4'd0;
            reg_wbload_channel.cnt <= 4'd0;
        end
        else if (wbload_channel_wen) begin
            reg_wbload_channel.idx <= regif_wdata[11:8];
            reg_wbload_channel.cnt <= regif_wdata[3:0];
        end
    end: b_reg_wbload_channel

    assign wbload_channel_rdata = {
        20'd0, reg_wbload_channel.idx,
        4'd0, reg_wbload_channel.cnt
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_comp_ctrl
        if (rst) begin
            reg_comp_ctrl.wbload_init <= 1'b1;
            reg_comp_ctrl.pool_mode   <= 1'd0;
        end
        else if (comp_ctrl_wen) begin
            reg_comp_ctrl.wbload_init <= regif_wdata[1];
            reg_comp_ctrl.pool_mode   <= regif_wdata[0];
        end
    end: b_reg_comp_ctrl

    assign comp_ctrl_rdata = {
        30'd0, reg_comp_ctrl.wbload_init,
        reg_comp_ctrl.pool_mode
    };

    //VCS coverage off
    assign reg_comp_ctrl.go_conv    = comp_ctrl_wen && regif_wdata[31];
    assign reg_comp_ctrl.go_fc      = comp_ctrl_wen && regif_wdata[30];
    assign reg_comp_ctrl.go_pool    = comp_ctrl_wen && regif_wdata[29];
    assign reg_comp_ctrl.go_reshape = comp_ctrl_wen && regif_wdata[28];

// =============================================================================

    logic [4:0] stgr_comp_wait_lpe;
    assign stgr_conv_wait_lpe    = stgr_comp_wait_lpe;
    assign stgr_fc_wait_lpe      = stgr_comp_wait_lpe;
    assign stgr_reshape_wait_lpe = stgr_comp_wait_lpe;

    assign go_comp_conv    = reg_comp_ctrl.go_conv | reg_comp_ctrl.go_pool;
    assign go_comp_fc      = reg_comp_ctrl.go_fc;
    assign go_comp_reshape = reg_comp_ctrl.go_reshape;

    logic   lpe_go;

    assign lpe_go = reg_comp_ctrl.go_conv
                  | reg_comp_ctrl.go_fc
                  | reg_comp_ctrl.go_pool
                  | reg_comp_ctrl.go_reshape;

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            stgr_conv_k_hori_len    <= 6'd0;
            stgr_conv_k_vert_len    <= 6'd0;
            stgr_conv_k_hori_delta  <= 6'd0;
            stgr_conv_k_vert_delta  <= 6'd0;
            stgr_conv_k_size_len    <= 11'd0;

            stgr_conv_if_hori_len   <= 6'd0;
            stgr_conv_if_vert_len   <= 6'd0;
            stgr_conv_of_hori_len   <= 6'd0;
            stgr_conv_of_vert_len   <= 6'd0;

            stgr_conv_hori_stride   <= 6'd0;
            stgr_conv_vert_stride   <= 6'd0;
            stgr_conv_slice_max     <= 4'd0;

            stgr_conv_pad_up        <= 4'd0;
            stgr_conv_pad_down      <= 4'd0;
            stgr_conv_pad_left      <= 4'd0;
            stgr_conv_pad_right     <= 4'd0;
            stgr_conv_pad_num       <= 16'd0;

            stgr_conv_wbload_cmd    <= WBLOAD_CMD_STOP;

            stgr_pool_mode          <= 1'b0;
            stgr_pool_enable        <= 1'b0;

            stgr_fc_addr            <= 11'd0;
            stgr_fc_len             <= 11'd0;

            stgr_reshape_addr       <= 11'd0;
            stgr_reshape_len        <= 11'd0;
            stgr_reshape_skip       <= 6'd0;
            stgr_reshape_iter       <= 6'd0;
        end
        else if (go_comp_conv) begin // CONV | Pooling
            stgr_conv_k_hori_len   <= reg_conv_k_size0.hori_len;
            stgr_conv_k_vert_len   <= reg_conv_k_size0.vert_len;
            stgr_conv_k_hori_delta <= reg_conv_k_size0.hori_delta;
            stgr_conv_k_vert_delta <= reg_conv_k_size0.vert_delta;
            stgr_conv_k_size_len   <= reg_conv_k_size1.size_len;

            stgr_conv_if_hori_len  <= reg_conv_fmap.if_hori_len;
            stgr_conv_if_vert_len  <= reg_conv_fmap.if_vert_len;
            stgr_conv_of_hori_len  <= reg_conv_fmap.of_hori_len;
            stgr_conv_of_vert_len  <= reg_conv_fmap.of_vert_len;

            stgr_conv_hori_stride  <= reg_conv_stride.hori_stride;
            stgr_conv_vert_stride  <= reg_conv_stride.vert_stride;
            stgr_conv_slice_max    <= reg_conv_k_size1.slice_max;

            stgr_conv_pad_up       <= reg_conv_pad_size.pad_up;
            stgr_conv_pad_down     <= reg_conv_pad_size.pad_down;
            stgr_conv_pad_left     <= reg_conv_pad_size.pad_left;
            stgr_conv_pad_right    <= reg_conv_pad_size.pad_right;
            stgr_conv_pad_num      <= reg_conv_pad_num.pad_num;

            if (reg_comp_ctrl.go_pool) begin
                stgr_pool_mode   <= regif_wdata[0];
                stgr_pool_enable <= 1'b1;
            end
            else begin
                stgr_pool_enable <= 1'b0;
                case(reg_conv_k_load.wbload_cmd)
                    2'd0: stgr_conv_wbload_cmd <= WBLOAD_CMD_STOP;
                    2'd1: stgr_conv_wbload_cmd <= WBLOAD_CMD_RESET;
                    2'd2: stgr_conv_wbload_cmd <= WBLOAD_CMD_CONTINUE;
                    default: stgr_conv_wbload_cmd <= WBLOAD_CMD_STOP;
                endcase
            end
        end
        else if (go_comp_fc) begin // FC
            stgr_fc_addr <= reg_fc_src.addr;
            stgr_fc_len  <= reg_fc_src.length;

            stgr_pool_enable <= 1'b0;
        end
        else if (go_comp_reshape) begin
            stgr_reshape_addr <= reg_reshape_src0.addr;
            stgr_reshape_len  <= reg_reshape_src0.length;
            stgr_reshape_skip <= reg_reshape_src1.skip;
            stgr_reshape_iter <= reg_reshape_src1.iter;

            stgr_pool_enable <= 1'b0;
        end
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            stgr_wbload_ddr_addr       <= 54'd0;
            stgr_wbload_wb_cnt_default <= 4'd0;
            stgr_wbload_kpe_cnt        <= 2'd0;
            stgr_wbload_kpe_mask       <= 16'd0;
            stgr_wbload_kpe_act_num    <= 7'd0;
            stgr_wbload_cpe_idx        <= 4'd0;
            stgr_wbload_cpe_cnt        <= 4'd0;
        end
        else if (reg_comp_ctrl.go_conv & regif_wdata[1] || reg_comp_ctrl.go_fc) begin
            case (reg_wbload_kernel.kpe_cnt)
                2'd0: stgr_wbload_kpe_act_num <= reg_wbload_channel.cnt + 1;
                2'd1: stgr_wbload_kpe_act_num <= (reg_wbload_channel.cnt + 1) << 1;
                2'd2: stgr_wbload_kpe_act_num <= (reg_wbload_channel.cnt + 1) * 3;
                2'd3: stgr_wbload_kpe_act_num <= (reg_wbload_channel.cnt + 1) << 2;
                default: ;
            endcase

            if (reg_conv_k_size1.size_len <= reg_conv_k_size1.slice_max) begin
                stgr_wbload_wb_cnt_default <= reg_conv_k_size1.size_len;
            end
            else begin
                stgr_wbload_wb_cnt_default <= reg_conv_k_size1.slice_max;
            end

            stgr_wbload_ddr_addr <= {reg_wbload_ddr_addr1.addr1, reg_wbload_ddr_addr0.addr0};
            stgr_wbload_kpe_cnt  <= reg_wbload_kernel.kpe_cnt;
            stgr_wbload_kpe_mask <= reg_wbload_kernel.mask;
            stgr_wbload_cpe_idx  <= reg_wbload_channel.idx;
            stgr_wbload_cpe_cnt  <= reg_wbload_channel.cnt;
        end
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            start_lpe           <= 1'b0;
            stgr_lpe_src_len    <= 6'd0;
            stgr_lpe_src_addr   <= 13'd0;
            stgr_lpe_src_iter   <= 6'd0;
            stgr_lpe_src_skip   <= 13'd0;
            stgr_lpe_dest_len   <= 6'd0;
            stgr_lpe_dest_addr  <= 13'd0;
            stgr_lpe_dest_iter  <= 6'd0;
            stgr_lpe_dest_skip  <= 13'd0;
            stgr_lpe_overlay    <= 7'd0;
            stgr_lpe_acc_bypass <= 1'b0;
            stgr_lpe_relu       <= 1'b0;
            stgr_lpe_sprmps     <= LPE_SPRMPS_IMAGE;
            stgr_lpe_leap       <= '0;
            stgr_comp_wait_lpe  <= 5'd0;
        end
        else begin
            start_lpe <= lpe_go;
            if (lpe_go) begin
                stgr_lpe_src_len  <= reg_lpe_src0.length;
                stgr_lpe_src_addr <= reg_lpe_src0.addr;
                stgr_lpe_src_iter <= reg_lpe_src1.iter;
                stgr_lpe_src_skip <= reg_lpe_src1.skip;

                stgr_lpe_acc_bypass <= reg_lpe_mode.acc_bypass;
                stgr_lpe_relu       <= reg_lpe_mode.relu;
                stgr_lpe_overlay    <= reg_lpe_mode.overlay;

                if (reg_lpe_mode.addr_merge) begin
                    stgr_lpe_dest_len  <= reg_lpe_src0.length;
                    stgr_lpe_dest_addr <= reg_lpe_src0.addr;
                    stgr_lpe_dest_iter <= reg_lpe_src1.iter;
                    stgr_lpe_dest_skip <= reg_lpe_src1.skip;
                end
                else begin
                    stgr_lpe_dest_len  <= reg_lpe_dest0.length;
                    stgr_lpe_dest_addr <= reg_lpe_dest0.addr;
                    stgr_lpe_dest_iter <= reg_lpe_dest1.iter;
                    stgr_lpe_dest_skip <= reg_lpe_dest1.skip;
                end

                case (reg_lpe_mode.sprmps)
                    2'd0:    stgr_lpe_sprmps <= LPE_SPRMPS_IMAGE;
                    2'd1:    stgr_lpe_sprmps <= LPE_SPRMPS_ALL;
                    2'd2:    stgr_lpe_sprmps <= LPE_SPRMPS_NONE;
                    default: stgr_lpe_sprmps <= LPE_SPRMPS_NONE;
                endcase

                case (reg_lpe_mode.sprmps)
                    2'd0:    stgr_comp_wait_lpe <= reg_lpe_mode.acc_bypass ? 5'd3 : 5'd7;
                    2'd1:    stgr_comp_wait_lpe <= reg_lpe_mode.acc_bypass ? 5'd0 : 5'd1;
                    2'd2:    stgr_comp_wait_lpe <= reg_lpe_mode.acc_bypass ? 5'd15 : 5'd31;
                    default: stgr_comp_wait_lpe <= reg_lpe_mode.acc_bypass ? 5'd15 : 5'd31;
                endcase

                if (reg_lpe_mode.leap_clone) begin
                    stgr_lpe_leap <= {15{reg_lpe_mode.leap}};
                end
                else begin
                    stgr_lpe_leap[0]  <= reg_lpe_leap0.leap0;
                    stgr_lpe_leap[1]  <= reg_lpe_leap0.leap1;
                    stgr_lpe_leap[2]  <= reg_lpe_leap1.leap2;
                    stgr_lpe_leap[3]  <= reg_lpe_leap1.leap3;
                    stgr_lpe_leap[4]  <= reg_lpe_leap2.leap4;
                    stgr_lpe_leap[5]  <= reg_lpe_leap2.leap5;
                    stgr_lpe_leap[6]  <= reg_lpe_leap3.leap6;
                    stgr_lpe_leap[7]  <= reg_lpe_leap3.leap7;
                    stgr_lpe_leap[8]  <= reg_lpe_leap4.leap8;
                    stgr_lpe_leap[9]  <= reg_lpe_leap4.leap9;
                    stgr_lpe_leap[10] <= reg_lpe_leap5.leap10;
                    stgr_lpe_leap[11] <= reg_lpe_leap5.leap11;
                    stgr_lpe_leap[12] <= reg_lpe_leap6.leap12;
                    stgr_lpe_leap[13] <= reg_lpe_leap6.leap13;
                    stgr_lpe_leap[14] <= reg_lpe_leap7.leap14;
                end
            end
        end
    end
    //VCS coverage on
endmodule: dla_regif_comp
