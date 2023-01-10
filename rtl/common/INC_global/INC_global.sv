// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      INC_global.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Repository:     http://10.137.20.23/bcrc-soc/tj3.git
//  Author(s):
//                  Haozhe.Zhu (zhutmost@outlook.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//          This is a global head file, and should be included in all source
//      code files.
//          In priciple, this file is the only head file for "include"
//      statement. Please use "import" instead to call global variables.
//          Modify it if and only if you are aware of the potential consequences
//      of your modification.
// -FHDR========================================================================

//`define FLOW_FPGA_GENESYS2

`timescale 1ns/1ps

// `define USE_APE_STUB
// `define USE_CPE_STUB

//  Define SIMULATION in the simulator settings.
`ifdef SIMULATION

    //  Disable the DDR controller to speed up the simulation.
    // `define DUMMY_DDR
    `ifdef DUMMY_DDR
        `define DUMMY_DDR_DEPTH 33554432//33554432 equals to 2 ^ 25.
    `endif

`endif
