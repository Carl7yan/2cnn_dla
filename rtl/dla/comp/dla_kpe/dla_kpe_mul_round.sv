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

module dla_kpe_mul_round
    import PKG_dla_typedef :: *;
(
    input  logic [31:0]        pre_rs,
    output  logic [23:0]        after_rs,

    input  logic [3:0]         stgr_precision_kpe_shift,
    input  precision_ifmap_e   stgr_precision_ifmap  
);

    logic [31:0]    mid_data;
    logic [31:0]    mid_data_a;
    logic [1:0]     carry_in;

    always_comb begin
        if (stgr_precision_ifmap == PRECISION_IFMAP_16) begin
            unique case (stgr_precision_kpe_shift)
                4'd0: begin
                    mid_data_a = pre_rs;
                    carry_in = 2'b0;
                end
                4'd1: begin
                    mid_data_a = {pre_rs[31], pre_rs[31:1]};
                    carry_in = {1'b0, pre_rs[0]};
                end
                4'd2: begin
                    mid_data_a = {{2{pre_rs[31]}}, pre_rs[31:2]};
                    carry_in = {1'b0, pre_rs[1]};
                end
                4'd3: begin
                    mid_data_a = {{3{pre_rs[31]}}, pre_rs[31:3]};
                    carry_in = {1'b0, pre_rs[2]};
                end
                4'd4: begin
                    mid_data_a = {{4{pre_rs[31]}}, pre_rs[31:4]};
                    carry_in = {1'b0, pre_rs[3]};
                end
                4'd5: begin
                    mid_data_a = {{5{pre_rs[31]}}, pre_rs[31:5]};
                    carry_in = {1'b0, pre_rs[4]};
                end
                4'd6: begin
                    mid_data_a = {{6{pre_rs[31]}}, pre_rs[31:6]};
                    carry_in = {1'b0, pre_rs[5]};
                end
                4'd7: begin
                    mid_data_a = {{7{pre_rs[31]}}, pre_rs[31:7]};
                    carry_in = {1'b0, pre_rs[6]};
                end
                4'd8: begin
                    mid_data_a = {{8{pre_rs[31]}}, pre_rs[31:8]};
                    carry_in = {1'b0, pre_rs[7]};
                end
                4'd9: begin
                    mid_data_a = {{9{pre_rs[31]}}, pre_rs[31:9]};
                    carry_in = {1'b0, pre_rs[8]};
                end
                4'd10: begin
                    mid_data_a = {{10{pre_rs[31]}}, pre_rs[31:10]};
                    carry_in = {1'b0, pre_rs[9]};
                end
                4'd11: begin
                    mid_data_a = {{11{pre_rs[31]}}, pre_rs[31:11]};
                    carry_in = {1'b0, pre_rs[10]};
                end
                4'd12: begin
                    mid_data_a = {{12{pre_rs[31]}}, pre_rs[31:12]};
                    carry_in = {1'b0, pre_rs[11]};
                end
            endcase
        end
        else begin
            unique case (stgr_precision_kpe_shift)
                4'd0: begin
                    mid_data_a[31:16] = pre_rs[31:16];
                    carry_in[1] = 1'b0;
                    mid_data_a[15:0] = pre_rs[15:0];
                    carry_in[0] = 1'b0;
                end
                4'd1: begin
                    mid_data_a[31:16] = {pre_rs[31], pre_rs[31:17]};
                    carry_in[1] = pre_rs[16];
                    mid_data_a[15:0] = {pre_rs[15], pre_rs[15:1]};
                    carry_in[0] = pre_rs[0];
                end
                4'd2: begin
                    mid_data_a[31:16] = {{2{pre_rs[31]}}, pre_rs[31:18]};
                    carry_in[1] = pre_rs[17];
                    mid_data_a[15:0] = {{2{pre_rs[15]}}, pre_rs[15:2]};
                    carry_in[0] = pre_rs[1];
                end
                4'd3: begin
                    mid_data_a[31:16] = {{3{pre_rs[31]}}, pre_rs[31:19]};
                    carry_in[1] = pre_rs[18];
                    mid_data_a[15:0] = {{3{pre_rs[15]}}, pre_rs[15:3]};
                    carry_in[0] = pre_rs[2];
                end
                4'd4: begin
                    mid_data_a[31:16] = {{4{pre_rs[31]}}, pre_rs[31:20]};
                    carry_in[1] = pre_rs[19];
                    mid_data_a[15:0] = {{4{pre_rs[15]}}, pre_rs[15:4]};
                    carry_in[0] = pre_rs[3];
                end
                4'd5: begin
                    mid_data_a[31:16] = {{5{pre_rs[31]}}, pre_rs[31:21]};
                    carry_in[1] = pre_rs[20];
                    mid_data_a[15:0] = {{5{pre_rs[15]}}, pre_rs[15:5]};
                    carry_in[0] = pre_rs[4];
                end
                4'd6: begin
                    mid_data_a[31:16] = {{6{pre_rs[31]}}, pre_rs[31:22]};
                    carry_in[1] = pre_rs[21];
                    mid_data_a[15:0] = {{6{pre_rs[15]}}, pre_rs[15:6]};
                    carry_in[0] = pre_rs[5];  
                end
                4'd7: begin
                    mid_data_a[31:16] = {{7{pre_rs[31]}}, pre_rs[31:23]};
                    carry_in[1] = pre_rs[22];
                    mid_data_a[15:0] = {{7{pre_rs[15]}}, pre_rs[15:7]};
                    carry_in[0] = pre_rs[6];
                end
                4'd8: begin
                    mid_data_a[31:16] = {{8{pre_rs[31]}}, pre_rs[31:24]};
                    carry_in[1] = pre_rs[23];
                    mid_data_a[15:0] = {{8{pre_rs[15]}}, pre_rs[15:8]};
                    carry_in[0] = pre_rs[7];
                end
            endcase
        end
    end

    always_comb begin
        if ( stgr_precision_ifmap == PRECISION_IFMAP_16 ) begin
            mid_data[31:0] = mid_data_a[31:0] + carry_in[0];
        end else begin
            mid_data[31:16] = mid_data_a[31:16] + carry_in[1];
            mid_data[15:0] = mid_data_a[15:0] + carry_in[0];
        end
    end

    dla_vpsignsat #(.GRAN(12), .SAT(4)) kpe_mul_r (
        .a      (mid_data),
        .y      (after_rs),

        .mode_precision (stgr_precision_ifmap)
    );
        
endmodule: dla_kpe_mul_round