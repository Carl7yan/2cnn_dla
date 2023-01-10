// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      PKG_dla_typedef.sv
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

package PKG_dla_typedef;

    typedef enum logic {
        PRECISION_IFMAP_16 = 1'b0,
        PRECISION_IFMAP_8  = 1'b1
    } precision_ifmap_e;

    typedef enum logic [1:0] {
        PRECISION_WEIGHT_16 = 2'd0,
        PRECISION_WEIGHT_8  = 2'd1,
        PRECISION_WEIGHT_4  = 2'd2,
        PRECISION_WEIGHT_2  = 2'd3
    } precision_weight_e;

    typedef enum logic [1:0] {
        LPE_SPRMPS_IMAGE = 2'd0,
        LPE_SPRMPS_ALL   = 2'd1,
        LPE_SPRMPS_NONE  = 2'd2
    } lpe_sprmps_e;

    typedef enum logic [2:0] {
        APE_MODE_ELEADD  = 3'd0,
        APE_MODE_ELEMUL  = 3'd1,
        APE_MODE_IMMADD  = 3'd2,
        APE_MODE_IMMMUL  = 3'd3,
        APE_MODE_ACTFUNC = 3'd4
    } ape_mode_e;

    typedef enum logic [2:0] {
        OP_MOV_SOC2GB   = 3'd0,
        OP_MOV_DDR2GB   = 3'd1,
        OP_MOV_GB2LB    = 3'd2,
        OP_COMP_CONV    = 3'd3,
        OP_COMP_FC      = 3'd4,
        OP_COMP_APE     = 3'd5,
        OP_COMP_RESHAPE = 3'd6
    } status_e;

    typedef enum logic [1:0] {
        WBLOAD_CMD_NORMAL   = 2'd0,
        WBLOAD_CMD_CONTINUE = 2'd1,
        WBLOAD_CMD_RESET    = 2'd2,
        WBLOAD_CMD_STOP     = 2'd3
    } wbload_cmd_e;

endpackage: PKG_dla_typedef
