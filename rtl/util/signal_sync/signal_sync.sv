// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      signal_sync.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Repository:     http://10.137.20.23/bcrc-soc/tj3.git
//  Author(s):
//                  Haozhe.Zhu (haozhe_zhu@foxmail.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

`resetall

`include "INC_global.sv"

module signal_sync
#(
    parameter integer ORDER = 2
)(
    input  logic    clk,
    input  logic    rst,
    input  logic    a,
    output logic    y
);

    logic [ORDER-1:0] t;

    always @ (posedge clk or posedge rst) begin
        if (rst) t <= '0;
        else     t <= {t[ORDER-2:0], a};
    end

    assign y = t[ORDER-1];

endmodule: signal_sync
