// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_kpe.sv
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

module dla_kpe
    import PKG_dla_typedef :: *;
(
    input  logic        clk,
    input  logic        rst,
    input  logic        enable,

    input  logic [15:0] kpe_ifmap,
    input  logic [15:0] kpe_weight,
    output logic [15:0] kpe_sum,

    input  logic        ctrl_kpe_src0_enable,
    input  logic        ctrl_kpe_src1_enable,
    input  logic        ctrl_kpe_mul_enable,
    input  logic        ctrl_kpe_acc_enable,
    input  logic        ctrl_kpe_acc_rst,

    input  logic                ctrl_kpe_bypass,
    input  logic [3:0]          stgr_precision_kpe_shift,
    input  precision_ifmap_e    stgr_precision_ifmap,
    input  precision_weight_e   stgr_precision_weight
);

    //  interconnect wires
    logic [41:0]    kpe_mul_res;
    logic [23:0]    kpe_mul_shift;
    logic [23:0]    kpe_acc_a, kpe_acc_b;
    logic [23:0]    kpe_acc_res;
    logic [15:0]    kpe_acc_round_res;

    //  pipeline registers
    logic [15:0]    preg_src_f, preg_src_w;
    logic [31:0]    preg_mul;
    logic [23:0]    preg_rs;
    logic [23:0]    preg_acc;

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) preg_src_f <= '0;
        else if (ctrl_kpe_src0_enable) preg_src_f <= kpe_ifmap;
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) preg_src_w <= '0;
        else if (ctrl_kpe_src1_enable) preg_src_w <= kpe_weight;
    end

`ifdef FLOW_FPGA_GENESYS2

    dla_kpe_mul kpe_mul (
        .clk,
        .rst,

        .a      (preg_src_f),
        .b      (preg_src_w),
        .y      (kpe_mul_res),

        .ctrl_kpe_mul_enable,

        .stgr_precision_ifmap,
        .stgr_precision_weight
    );

    assign preg_mul = kpe_mul_res[31:0];

`else

    dla_kpe_mul kpe_mul (
        .a      (preg_src_f),
        .b      (preg_src_w),
        .y      (kpe_mul_res),

        .stgr_precision_ifmap,
        .stgr_precision_weight
    );

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) preg_mul <= '0;
        else if (ctrl_kpe_mul_enable) preg_mul <= kpe_mul_res;
    end

`endif

    dla_kpe_mul_round kpe_mul_rs (
        .pre_rs     (preg_mul),
        .after_rs   (kpe_mul_shift),

        .stgr_precision_kpe_shift,
        .stgr_precision_ifmap
    );

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) preg_rs <= '0;
        else preg_rs <= kpe_mul_shift;
    end

    dla_kpe_acc kpe_acc (
        .a      (kpe_acc_a),
        .b      (kpe_acc_b),
        .y      (kpe_acc_res),
        .stgr_precision_ifmap
    );

    assign kpe_acc_a = preg_rs;
    assign kpe_acc_b = ctrl_kpe_acc_rst ? 24'b0 : preg_acc;

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) preg_acc <= '0;
        else if (ctrl_kpe_acc_enable) begin
            preg_acc <= kpe_acc_res;
        end
    end

    dla_vpsignsat #(.GRAN(8), .SAT(4)) kpe_acc_r (
        .a      (preg_acc),
        .y      (kpe_acc_round_res),

        .mode_precision (stgr_precision_ifmap)
    );

    always_comb begin
        if (enable) kpe_sum = ctrl_kpe_bypass ? preg_src_f : kpe_acc_round_res;
        else        kpe_sum = 16'd0;
    end

endmodule: dla_kpe
