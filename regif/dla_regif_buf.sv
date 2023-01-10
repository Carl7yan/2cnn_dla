// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_regif_buf.sv
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

module dla_regif_buf
    import PKG_dla_regmap :: *;
    import PKG_dla_typedef :: *;
(
    //  global signals
    input  logic    clk,
    input  logic    rst,

    //  control signals
    input  logic            go,//VCS coverage off
    output logic [255:0]    stgr_buf_mask,
    input  status_e         stgr_status,//VCS coverage on

    //  register interface - BUF_MASKX
    input  logic        buf_maskx_wen,
    output logic [31:0] buf_maskx_rdata,

    //  register interface - BUF_MASK0
    input  logic        buf_mask0_wen,
    output logic [31:0] buf_mask0_rdata,

    //  register interface - BUF_MASK1
    input  logic        buf_mask1_wen,
    output logic [31:0] buf_mask1_rdata,

    //  register interface - BUF_MASK2
    input  logic        buf_mask2_wen,
    output logic [31:0] buf_mask2_rdata,

    //  register interface - BUF_MASK3
    input  logic        buf_mask3_wen,
    output logic [31:0] buf_mask3_rdata,

    //  register interface - BUF_MASK4
    input  logic        buf_mask4_wen,
    output logic [31:0] buf_mask4_rdata,

    //  register interface - BUF_MASK5
    input  logic        buf_mask5_wen,
    output logic [31:0] buf_mask5_rdata,

    //  register interface - BUF_MASK6
    input  logic        buf_mask6_wen,
    output logic [31:0] buf_mask6_rdata,

    //  register interface - BUF_MASK7
    input  logic        buf_mask7_wen,
    output logic [31:0] buf_mask7_rdata,

    //  register interface - general
    input  logic [31:0] regif_wdata
);

    REG_BUF_MASKX_t reg_maskx;
    REG_BUF_MASK0_t reg_mask0;
    REG_BUF_MASK1_t reg_mask1;
    REG_BUF_MASK2_t reg_mask2;
    REG_BUF_MASK3_t reg_mask3;
    REG_BUF_MASK4_t reg_mask4;
    REG_BUF_MASK5_t reg_mask5;
    REG_BUF_MASK6_t reg_mask6;
    REG_BUF_MASK7_t reg_mask7;

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_buf_maskx
        if (rst) begin
            reg_maskx.clone  <= 1'd0;
            reg_maskx.mask   <= 16'd0;
        end
        else if (buf_maskx_wen) begin
            reg_maskx.clone <= regif_wdata[31];
            reg_maskx.mask  <= regif_wdata[15:0];
        end
    end: b_reg_buf_maskx

    assign buf_maskx_rdata = {
        reg_maskx.clone,
        15'd0, reg_maskx.mask
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_buf_mask0
        if (rst) begin
            reg_mask0.mask1  <= 16'd0;
            reg_mask0.mask0  <= 16'd0;
        end
        else if (buf_mask0_wen) begin
            reg_mask0.mask1 <= regif_wdata[31:16];
            reg_mask0.mask0 <= regif_wdata[15:0];
        end
    end: b_reg_buf_mask0

    assign buf_mask0_rdata = {reg_mask0.mask1, reg_mask0.mask0};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_buf_mask1
        if (rst) begin
            reg_mask1.mask3  <= 16'd0;
            reg_mask1.mask2  <= 16'd0;
        end
        else if (buf_mask1_wen) begin
            reg_mask1.mask3 <= regif_wdata[31:16];
            reg_mask1.mask2 <= regif_wdata[15:0];
        end
    end: b_reg_buf_mask1

    assign buf_mask1_rdata = {reg_mask1.mask3, reg_mask1.mask2};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_buf_mask2
        if (rst) begin
            reg_mask2.mask5  <= 16'd0;
            reg_mask2.mask4  <= 16'd0;
        end
        else if (buf_mask2_wen) begin
            reg_mask2.mask5 <= regif_wdata[31:16];
            reg_mask2.mask4 <= regif_wdata[15:0];
        end
    end: b_reg_buf_mask2

    assign buf_mask2_rdata = {reg_mask2.mask5, reg_mask2.mask4};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_buf_mask3
        if (rst) begin
            reg_mask3.mask7  <= 16'd0;
            reg_mask3.mask6  <= 16'd0;
        end
        else if (buf_mask3_wen) begin
            reg_mask3.mask7 <= regif_wdata[31:16];
            reg_mask3.mask6 <= regif_wdata[15:0];
        end
    end: b_reg_buf_mask3

    assign buf_mask3_rdata = {reg_mask3.mask7, reg_mask3.mask6};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_buf_mask4
        if (rst) begin
            reg_mask4.mask9  <= 16'd0;
            reg_mask4.mask8  <= 16'd0;
        end
        else if (buf_mask4_wen) begin
            reg_mask4.mask9 <= regif_wdata[31:16];
            reg_mask4.mask8 <= regif_wdata[15:0];
        end
    end: b_reg_buf_mask4

    assign buf_mask4_rdata = {reg_mask4.mask9, reg_mask4.mask8};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_buf_mask5
        if (rst) begin
            reg_mask5.mask11 <= 16'd0;
            reg_mask5.mask10 <= 16'd0;
        end
        else if (buf_mask5_wen) begin
            reg_mask5.mask11 <= regif_wdata[31:16];
            reg_mask5.mask10 <= regif_wdata[15:0];
        end
    end: b_reg_buf_mask5

    assign buf_mask5_rdata = {reg_mask5.mask11, reg_mask5.mask10};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_buf_mask6
        if (rst) begin
            reg_mask6.mask13 <= 16'd0;
            reg_mask6.mask12 <= 16'd0;
        end
        else if (buf_mask6_wen) begin
            reg_mask6.mask13 <= regif_wdata[31:16];
            reg_mask6.mask12 <= regif_wdata[15:0];
        end
    end: b_reg_buf_mask6

    assign buf_mask6_rdata = {reg_mask6.mask13, reg_mask6.mask12};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_buf_mask7
        if (rst) begin
            reg_mask7.mask15 <= 16'd0;
            reg_mask7.mask14 <= 16'd0;
        end
        else if (buf_mask7_wen) begin
            reg_mask7.mask15 <= regif_wdata[31:16];
            reg_mask7.mask14 <= regif_wdata[15:0];
        end
    end: b_reg_buf_mask7

    assign buf_mask7_rdata = {reg_mask7.mask15, reg_mask7.mask14};

// =============================================================================

    logic [255:0]   staging_mask, unstaging_mask;

    always_comb begin
        if (reg_maskx.clone) begin
            unstaging_mask = {16{reg_maskx.mask}};
        end
        else begin
            unstaging_mask = {
                reg_mask7.mask15, reg_mask7.mask14,
                reg_mask6.mask13, reg_mask6.mask12,
                reg_mask5.mask11, reg_mask5.mask10,
                reg_mask4.mask9, reg_mask4.mask8,
                reg_mask3.mask7, reg_mask3.mask6,
                reg_mask2.mask5, reg_mask2.mask4,
                reg_mask1.mask3, reg_mask1.mask2,
                reg_mask0.mask1, reg_mask0.mask0
            };
        end
    end

    always_ff @ (posedge clk or posedge rst) begin//VCS coverage off
        if (rst) begin
            staging_mask <= 256'd0;
        end
        else if (go) begin
            staging_mask <= unstaging_mask;
        end
    end

    assign stgr_buf_mask = stgr_status == OP_MOV_SOC2GB ? unstaging_mask : staging_mask;
    //VCS coverage on
endmodule: dla_regif_buf
