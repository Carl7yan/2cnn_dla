// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_vpsigsaxt.sv
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

module dla_vpsignsat
    import PKG_dla_typedef :: *;
#(
    parameter int GRAN = 8,
    parameter int SAT  = 1
)(
    input  logic [(GRAN+SAT)*2-1:0] a,
    output logic [GRAN*2-1:0]       y,

    input  precision_ifmap_e        mode_precision
);

    always_comb begin
        case (mode_precision)
            PRECISION_IFMAP_16: begin
                if (a[(GRAN+SAT)*2-1] ^ (& a[(GRAN+SAT)*2-2-:SAT*2])
                    || a[(GRAN+SAT)*2-1] ^ (| a[(GRAN+SAT)*2-2-:SAT*2])) begin
                    y = {a[(GRAN+SAT)*2-1], {(GRAN*2-1){~ a[(GRAN+SAT)*2-1]}}};
                end
                else begin
                    y = {a[(GRAN+SAT)*2-1], a[GRAN*2-2:0]};
                end
            end
            PRECISION_IFMAP_8: begin
                if (a[(GRAN+SAT)*2-1] ^ (& a[(GRAN+SAT)*2-2-:SAT])
                    || a[(GRAN+SAT)*2-1] ^ (| a[(GRAN+SAT)*2-2-:SAT])) begin
                    y[GRAN*2-1-:GRAN] = {a[(GRAN+SAT)*2-1], {(GRAN-1){~ a[(GRAN+SAT)*2-1]}}};
                end
                else begin
                    y[GRAN*2-1-:GRAN] = {a[(GRAN+SAT)*2-1], a[GRAN*2+SAT-2:GRAN+SAT]};
                end
                if (a[GRAN+SAT-1] ^ (& a[GRAN+SAT-2-:SAT])
                    || a[GRAN+SAT-1] ^ (| a[GRAN+SAT-2-:SAT])) begin
                    y[GRAN-1:0] = {a[GRAN+SAT-1], {(GRAN-1){~ a[GRAN+SAT-1]}}};
                end
                else begin
                    y[GRAN-1:0] = {a[GRAN+SAT-1], a[GRAN-2:0]};
                end
            end
            default: begin
                y = '0;
            end
        endcase
    end

endmodule: dla_vpsignsat
