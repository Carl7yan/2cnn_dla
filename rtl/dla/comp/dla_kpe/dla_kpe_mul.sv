// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_kpe_mul.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Repository:     http://10.137.20.23/bcrc-soc/tj3.git
//  Author(s):
//                  Haozhe.Zhu (zhutmost@outlook.com)
//                  Zihao.Zhang (china_zzh@protonmail.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

`resetall


`include "INC_global.sv"

`ifdef FLOW_FPGA_GENESYS2

module dla_kpe_mul
    import PKG_dla_typedef :: *;
(
    input  logic clk,
    input  logic rst,

    input  logic [15:0]    a,    // ifmap
    input  logic [15:0]    b,    // weight
    output logic [41:0]    y,    // product

    input  logic ctrl_kpe_mul_enable,

    input  precision_ifmap_e    stgr_precision_ifmap,
    input  precision_weight_e   stgr_precision_weight
);

    logic [24:0] dsp_a;
    logic [24:0] dsp_d;
    logic [15:0] dsp_b;
    logic [31:0] dsp_c;
    logic [41:0] dsp_p;

    assign y = dsp_p;

    always_comb begin
        if (stgr_precision_ifmap == PRECISION_IFMAP_16) begin
            dsp_a = {{9{a[15]}}, a};
            dsp_d = 25'd0;
        end else begin
            dsp_a = {a[15], a[15:8], 16'b0};
            dsp_d = {{17{a[7]}}, a[7:0]};
        end
    end

    always_comb begin
        if (stgr_precision_weight == PRECISION_WEIGHT_16) begin
            dsp_b = b;
            dsp_c = '0;
        end
        else begin
            dsp_b = {{8{b[7]}}, b[7:0]};
            dsp_c = (a[7] ^ b[7]) ? 32'h00010000 : 32'h00000000;
        end
    end

    dsp48_kpe_mul kpe_dsp (
        .CLK    (clk),
        .CE     (ctrl_kpe_mul_enable),
        .SCLR   (rst),
        .A      (dsp_a),
        .B      (dsp_b),
        .C      (dsp_c),
        .D      (dsp_d),
        .P      (dsp_p)
    );

endmodule: dla_kpe_mul

`else

module dla_kpe_mul
    import PKG_dla_typedef :: *;
(
    input  logic [15:0]    a,    //ifmap
    input  logic [15:0]    b,    //weight
    output logic [41:0]    y,    //product

    input  precision_ifmap_e    stgr_precision_ifmap,
    input  precision_weight_e   stgr_precision_weight
);

    logic signed [24:0] dsp_a;
    logic signed [24:0] dsp_d;
    logic signed [15:0] dsp_b;
    logic signed [31:0] dsp_c;
    logic signed [41:0] dsp_p;

    assign y = dsp_p;

    always_comb begin
        if ( stgr_precision_ifmap == PRECISION_IFMAP_16 ) begin
            dsp_a = {{9{a[15]}}, a};
            dsp_d = '0;
        end else begin
            dsp_a = {a[15], a[15:8], 16'b0};
            dsp_d = {{17{a[7]}}, a[7:0]};
        end
    end

    always_comb begin
        if ( stgr_precision_weight == PRECISION_WEIGHT_16 ) begin
            dsp_b = b;
            dsp_c = '0;
        end else begin
            dsp_b = {{8{b[7]}}, b[7:0]};
            dsp_c = (a[7] ^~ b[7]) ? 32'h00000000 :
                     ((((b == 0) && (a[7] == 1)) || ((b[7] == 1) && (a[7 : 0] == 0))) ? 
                     32'h0000_0000 : 32'h00010000);
        end
    end

   always_comb begin
       dsp_p = (dsp_a + dsp_d) * dsp_b + dsp_c;
   end

endmodule: dla_kpe_mul

`endif
