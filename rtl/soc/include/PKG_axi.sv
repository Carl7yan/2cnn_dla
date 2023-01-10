// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      PKG_axi.sv
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

package PKG_axi;

    //  maximum numbers of bytes in each data transfer, or beat, in a burst
    typedef enum logic [2:0] {
        AXI_AxSIZE_1   = 3'b000,
        AXI_AxSIZE_2   = 3'b001,
        AXI_AxSIZE_4   = 3'b010,
        AXI_AxSIZE_8   = 3'b011,
        AXI_AxSIZE_16  = 3'b100,
        AXI_AxSIZE_32  = 3'b101,
        AXI_AxSIZE_64  = 3'b110,
        AXI_AxSIZE_128 = 3'b111
    } axi_axsize_e; // ARSIZE, AWSIZE

    typedef enum logic [1:0] {
        AXI_AxBURST_FIXED    = 2'b00,
        AXI_AxBURST_INCR     = 2'b01,
        AXI_AxBURST_WRAP     = 2'b10,
        AXI_AxBURST_reserved = 2'b11
    } axi_axburst_e; // ARBURST, AWBURST

    typedef enum logic [1:0] {
        AXI_RWRESP_OKAY   = 2'b00,
        AXI_RWRESP_EXOKAY = 2'b01,
        AXI_RWRESP_SLVERR = 2'b10,
        AXI_RWRESP_DECERR = 2'b11
    } axi_rwresp_e; // RRESP, RWRESP

    //  AXI4 removes the support for locked transactions.
    typedef enum logic {
        AXI_AxLOCK_NORMAL    = 1'b0,
        AXI_AxLOCK_EXCLUSIVE = 1'b1
    } axi_axlock_e;

endpackage: PKG_axi
