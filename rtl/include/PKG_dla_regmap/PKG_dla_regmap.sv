// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      PKG_dla_regmap.sv
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

package PKG_dla_regmap;

    parameter logic [19:0]
        REGMAP_GLB_STATUS        = 20'h0_0000,
        REGMAP_GLB_INTR          = 20'h0_0001,
        REGMAP_GLB_ENABLE_ROW    = 20'h0_0002,
        REGMAP_GLB_ENABLE_COL    = 20'h0_0003,

        REGMAP_BUF_MASKX         = 20'h0_0010,
        REGMAP_BUF_MASK0         = 20'h0_0011,
        REGMAP_BUF_MASK1         = 20'h0_0012,
        REGMAP_BUF_MASK2         = 20'h0_0013,
        REGMAP_BUF_MASK3         = 20'h0_0014,
        REGMAP_BUF_MASK4         = 20'h0_0015,
        REGMAP_BUF_MASK5         = 20'h0_0016,
        REGMAP_BUF_MASK6         = 20'h0_0017,
        REGMAP_BUF_MASK7         = 20'h0_0018,

        REGMAP_SOC2GB_CONFIG     = 20'h0_0020,

        REGMAP_DDR2GB_CTRL       = 20'h0_1010,
        REGMAP_DDR2GB_DDR_ADDR0  = 20'h0_1011,
        REGMAP_DDR2GB_DDR_ADDR1  = 20'h0_1012,
        REGMAP_DDR2GB_GB_ADDR    = 20'h0_1013,

        REGMAP_GB2LB_CTRL        = 20'h0_1020,
        REGMAP_GB2LB_SRC0        = 20'h0_1021,
        REGMAP_GB2LB_SRC1        = 20'h0_1022,
        REGMAP_GB2LB_DEST        = 20'h0_1023,

        REGMAP_APE_CTRL          = 20'h0_1030,
        REGMAP_APE_SRC           = 20'h0_1031,
        REGMAP_APE_DEST          = 20'h0_1032,
        REGMAP_APE_IMM           = 20'h0_1033,

        REGMAP_CONV_K_SIZE0      = 20'h0_1040,
        REGMAP_CONV_K_SIZE1      = 20'h0_1041,
        REGMAP_CONV_K_LOAD       = 20'h0_1042,
        REGMAP_CONV_FMAP         = 20'h0_1043,
        REGMAP_CONV_STRIDE       = 20'h0_1044,
        REGMAP_CONV_PAD_SIZE     = 20'h0_1045,
        REGMAP_CONV_PAD_NUM      = 20'h0_1046,

        REGMAP_FC_SRC            = 20'h0_1050,

        REGMAP_RESHAPE_SRC0      = 20'h0_1060,
        REGMAP_RESHAPE_SRC1      = 20'h0_1061,

        REGMAP_LPE_SRC0          = 20'h0_1070,
        REGMAP_LPE_SRC1          = 20'h0_1071,
        REGMAP_LPE_DEST0         = 20'h0_1072,
        REGMAP_LPE_DEST1         = 20'h0_1073,
        REGMAP_LPE_MODE          = 20'h0_1074,
        REGMAP_LPE_LEAP0         = 20'h0_1075,
        REGMAP_LPE_LEAP1         = 20'h0_1076,
        REGMAP_LPE_LEAP2         = 20'h0_1077,
        REGMAP_LPE_LEAP3         = 20'h0_1078,
        REGMAP_LPE_LEAP4         = 20'h0_1079,
        REGMAP_LPE_LEAP5         = 20'h0_107a,
        REGMAP_LPE_LEAP6         = 20'h0_107b,
        REGMAP_LPE_LEAP7         = 20'h0_107c,

        REGMAP_WBLOAD_DDR_ADDR0  = 20'h0_1080,
        REGMAP_WBLOAD_DDR_ADDR1  = 20'h0_1081,
        REGMAP_WBLOAD_KERNEL     = 20'h0_1082,
        REGMAP_WBLOAD_CHANNEL    = 20'h0_1083,

        REGMAP_COMP_CTRL         = 20'h0_1100,
        REGMAP_COMP_PRECISION    = 20'h0_1101;

// =============================================================================
//  register definition - SOC2GB

    typedef struct packed {
        logic           sign_ext;   // w/r, 4
        logic [1:0]     addr_mode;  // w/r, 1:0
    } REG_SOC2GB_CONFIG_t;

// =============================================================================
//  register definition - DDR2GB

    typedef struct {
        logic           go;         // w, 31
        logic           dir;        // w/r, 0
    } REG_DDR2GB_CTRL_t;

    typedef struct {
        logic [21:0]    haddr;      // w/r, 21:0
    } REG_DDR2GB_DDR_ADDR1_t;

    typedef struct {
        logic [31:0]    laddr;      // w/r, 31:0
    } REG_DDR2GB_DDR_ADDR0_t;

    typedef struct {
        logic [7:0]     len;        // w/r, 31:24
        logic [3:0]     ram_idx;    // w/r, 23:20
        logic           ab_sel;     // w/r, 13
        logic [12:0]    addr;       // w/r, 12:0
    } REG_DDR2GB_GB_ADDR_t;

// =============================================================================
//  register definition - GB2LB

    typedef struct {
        logic           go;         // w, 31
    } REG_GB2LB_CTRL_t;

    typedef struct {
        logic [12:0]    len;        // w/r, 28:16
        logic [12:0]    addr;       // w/r, 12:0
    } REG_GB2LB_SRC0_t;

    typedef struct {
        logic [5:0]     iter;       // w/r, 21:16
        logic [12:0]    skip;       // w/r, 12:0
    } REG_GB2LB_SRC1_t;

    typedef struct {
        logic [5:0]     skip;       // w/r, 21:16
        logic [10:0]    addr;       // w/r, 10:0
    } REG_GB2LB_DEST_t;

// =============================================================================
//  register definition - APE

    typedef struct {
        logic           go;         // w, 31
        logic [2:0]     mode;       // w/r, 2:0
    } REG_APE_CTRL_t;

    typedef struct {
        logic [12:0]    gb_addr_sb;  // w/r, 28:16
        logic [12:0]    gb_addr_sa;  // w/r, 12:0
    } REG_APE_SRC_t;

    typedef struct {
        logic [12:0]    length;     // w/r, 28:16
        logic [12:0]    gb_addr_d;  // w/r, 12:0
    } REG_APE_DEST_t;

    typedef struct {
        logic [15:0]    imm;        // w/r, 15:0
    } REG_APE_IMM_t;

// =============================================================================
//  register definition - CONV

    typedef struct {
        logic [5:0]     hori_delta; // w/r, 29:24
        logic [5:0]     vert_delta; // w/r, 21:16
        logic [5:0]     hori_len;   // w/r, 13:8
        logic [5:0]     vert_len;   // w/r, 5:0
    } REG_CONV_K_SiZE0_t;

    typedef struct {
        logic [11:0]    size_len;   // w/r, 27:16
        logic [3:0]     slice_max;  // w/r, 3:0
    } REG_CONV_K_SIZE1_t;

    typedef struct {
        logic [1:0]     wbload_cmd; // w/r, 1:0
    } REG_CONV_K_LOAD_t;

    typedef struct {
        logic [5:0]     if_hori_len; // w/r, 29:24
        logic [5:0]     if_vert_len; // w/r, 21:16
        logic [5:0]     of_hori_len; // w/r, 13:8
        logic [5:0]     of_vert_len; // w/r, 5:0
    } REG_CONV_FMAP_t;

    typedef struct {
        logic [5:0]     hori_stride;    // w/r, 13:8
        logic [5:0]     vert_stride;    // w/r, 5:0
    } REG_CONV_STRIDE_t;

    typedef struct {
        logic [3:0]     pad_up;     // w/r, 27:24
        logic [3:0]     pad_down;   // w/r, 19:16
        logic [3:0]     pad_left;   // w/r, 11:8
        logic [3:0]     pad_right;  // w/r, 3:0
    } REG_CONV_PAD_SIZE_t;

    typedef struct {
        logic [15:0]    pad_num;    // w/r, 15:0
    } REG_CONV_PAD_NUM_t;

// =============================================================================
//  register definition - FC

    typedef struct {
        logic [10:0]    length;     // w/r, 26:16
        logic [10:0]    addr;       // w/r, 10:0
    } REG_FC_SRC_t;

// =============================================================================
//  register definition - RESHAPE

    typedef struct {
        logic [10:0]    length;     // w/r, 26:16
        logic [10:0]    addr;       // w/r, 10:0
    } REG_RESHAPE_SRC0_t;

    typedef struct {
        logic [5:0]     iter;       // w/r, 21:16
        logic [5:0]     skip;       // w/r, 5:0
    } REG_RESHAPE_SRC1_t;

// =============================================================================
//  register definition - LPE

    typedef struct {
        logic [12:0]    length;     // w/r, 28:16
        logic [12:0]    addr;       // w/r, 12:0
    } REG_LPE_SRC0_t;

    typedef struct {
        logic [12:0]    iter;       // w/r, 28:16
        logic [12:0]    skip;       // w/r, 12:0
    } REG_LPE_SRC1_t;

    typedef struct {
        logic [12:0]    length;     // w/r, 28:16
        logic [12:0]    addr;       // w/r, 12:0
    } REG_LPE_DEST0_t;

    typedef struct {
        logic [12:0]    iter;       // w/r, 28:16
        logic [12:0]    skip;       // w/r, 12:0
    } REG_LPE_DEST1_t;

    typedef struct {
        logic           leap_clone; // w/r, 31
        logic           relu;       // w/r, 30
        logic           addr_merge; // w/r, 29
        logic           acc_bypass; // w/r, 28
        logic [6:0]     overlay;    // w/r, 26:20
        logic [1:0]     sprmps;     // w/r, 17:16, 0: image, 1: all, 2: none
        logic [12:0]    leap;       // w/r, 12:0
    } REG_LPE_MODE_t;

    typedef struct {
        logic [12:0]    leap1;      // w/r, 28:16
        logic [12:0]    leap0;      // w/r, 12:0
    } REG_LPE_LEAP0_t;

    typedef struct {
        logic [12:0]    leap3;      // w/r, 28:16
        logic [12:0]    leap2;      // w/r, 12:0
    } REG_LPE_LEAP1_t;

    typedef struct {
        logic [12:0]    leap5;      // w/r, 28:16
        logic [12:0]    leap4;      // w/r, 12:0
    } REG_LPE_LEAP2_t;

    typedef struct {
        logic [12:0]    leap7;      // w/r, 28:16
        logic [12:0]    leap6;      // w/r, 12:0
    } REG_LPE_LEAP3_t;

    typedef struct {
        logic [12:0]    leap9;      // w/r, 28:16
        logic [12:0]    leap8;      // w/r, 12:0
    } REG_LPE_LEAP4_t;

    typedef struct {
        logic [12:0]    leap11;     // w/r, 28:16
        logic [12:0]    leap10;     // w/r, 12:0
    } REG_LPE_LEAP5_t;

    typedef struct {
        logic [12:0]    leap13;     // w/r, 28:16
        logic [12:0]    leap12;     // w/r, 12:0
    } REG_LPE_LEAP6_t;

    typedef struct {
        logic [12:0]    leap14;     // w/r, 12:0
    } REG_LPE_LEAP7_t;

// =============================================================================
//  register definition - WB_Load

    typedef struct {
        logic [31:0]    addr0;      // w/r, 31:0
    } REG_WBLOAD_DDR_ADDR0_t;

    typedef struct {
        logic [21:0]    addr1;      // w/r, 21:0
    } REG_WBLOAD_DDR_ADDR1_t;

    typedef struct {
        logic [1:0]     kpe_cnt;    // w/r, 29:28, (0: 0-3, 1: 0-7, 2: 0-11, 3: 0-15)
        logic [15:0]    mask;       // w/r, 15:0
    } REG_WBLOAD_KERNEL_t;

    typedef struct {
        logic [3:0]     idx;        // w/r, 11:8
        logic [3:0]     cnt;        // w/r, 3:0
    } REG_WBLOAD_CHANNEL_t;

// =============================================================================
//  register definition - Computation

    typedef struct {
        logic           go_conv;    // w, 31
        logic           go_fc;      // w, 30
        logic           go_pool;    // w, 29
        logic           go_reshape; // w, 28
        logic           wbload_init;// w/r, 1
        logic           pool_mode;  // w/r, 0
    } REG_COMP_CTRL_t;

// =============================================================================
//  register definition - Global

    typedef struct {
        logic           reshape;    // r, 5
        logic           ape;        // r, 4
        logic           fc;         // r, 3
        logic           conv;       // r, 2
        logic           gb2lb;      // r, 1
        logic           ddr2gb;     // r, 0
    } REG_GLB_STATUS_t;

    typedef struct {
        logic           reshape;    // w/r, 5
        logic           ape;        // w/r, 4
        logic           fc;         // w/r, 3
        logic           conv;       // w/r, 2
        logic           gb2lb;      // w/r, 1
        logic           ddr2gb;     // w/r, 0
    } REG_GLB_INTR_t;

    typedef struct {
        logic [15:0]    row;
    } REG_GLB_ENABLE_ROW_t;

    typedef struct {
        logic [15:0]    col;
    } REG_GLB_ENABLE_COL_t;

    typedef struct {
        logic [3:0]     ape_shift;          // w/r, 27:24
        logic [3:0]     kpe_shift;          // w/r, 19:16
        logic           ifmap_precision;    // w/r, 8
        logic [1:0]     weight_precision;   // w/r, 1:0
    } REG_PRECISION_t;

// =============================================================================
//  Buffers - BUF

    typedef struct {
        logic           clone;      // w/r, 31
        logic [15:0]    mask;       // w/r, 15:0
    } REG_BUF_MASKX_t;

    typedef struct {
        logic [15:0]    mask1;      // w/r, 31:16
        logic [15:0]    mask0;      // w/r, 15:0
    } REG_BUF_MASK0_t;

    typedef struct {
        logic [15:0]    mask3;      // w/r, 31:16
        logic [15:0]    mask2;      // w/r, 15:0
    } REG_BUF_MASK1_t;

    typedef struct {
        logic [15:0]    mask5;      // w/r, 31:16
        logic [15:0]    mask4;      // w/r, 15:0
    } REG_BUF_MASK2_t;

    typedef struct {
        logic [15:0]    mask7;      // w/r, 31:16
        logic [15:0]    mask6;      // w/r, 15:0
    } REG_BUF_MASK3_t;

    typedef struct {
        logic [15:0]    mask9;      // w/r, 31:16
        logic [15:0]    mask8;      // w/r, 15:0
    } REG_BUF_MASK4_t;

    typedef struct {
        logic [15:0]    mask11;      // w/r, 31:16
        logic [15:0]    mask10;      // w/r, 15:0
    } REG_BUF_MASK5_t;

    typedef struct {
        logic [15:0]    mask13;      // w/r, 31:16
        logic [15:0]    mask12;      // w/r, 15:0
    } REG_BUF_MASK6_t;

    typedef struct {
        logic [15:0]    mask15;      // w/r, 31:16
        logic [15:0]    mask14;      // w/r, 15:0
    } REG_BUF_MASK7_t;

endpackage: PKG_dla_regmap
