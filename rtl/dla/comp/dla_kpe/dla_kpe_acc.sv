// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_kpe_acc.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Repository:     http://10.137.20.23/bcrc-soc/tj3.git
//  Author(s):
//                  Zihao.Zhang (china_zzh@protonmail.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

`resetall

`include "INC_global.sv"

module dla_kpe_acc
    import PKG_dla_typedef :: *;
(
    input  logic [23:0] a,
    input  logic [23:0] b,

    output logic [23:0] y,

    input  precision_ifmap_e stgr_precision_ifmap
);

    logic [11:0]    a1, a0;
    logic [11:0]    b1, b0;

    logic [23:0]    t;
    logic           carry;

    assign {a1, a0} = a;
    assign {b1, b0} = b;

    assign {carry, t[11:0]} = a0 + b0;
    assign t[23:12] = a1 + b1 + (stgr_precision_ifmap == PRECISION_IFMAP_16 ? carry : 1'b0);

    always_comb begin
        if (stgr_precision_ifmap == PRECISION_IFMAP_16) begin
            if (t[23] ^ a[23] && a[23] == b[23]) begin
                y = {a[23], {23{~ a[23]}}};
            end
            else begin
                y = t;
            end
        end
        else begin
            if (t[23] ^ a1[11] && a1[11] == b[23]) begin
                y[23:12] =  {a1[11], {11{~ a1[11]}}};
            end
            else begin
                y[23:12] = t[23:12];
            end
            if (t[11] ^ a0[11] && a0[11] == b[11]) begin
                y[11:0] =  {a0[11], {11{~ a0[11]}}};
            end
            else begin
                y[11:0] = t[11:0];
            end
        end
    end

endmodule: dla_kpe_acc
