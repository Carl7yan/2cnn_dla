// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_regif_gb2lb.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Repository:     http://10.137.20.23/bcrc-soc/tj3.git
//  Author(s):
//                  Haozhe.Zhu (zhutmost@outlook.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================


`ifndef DLA_REGIF_GB2IB
`define DLA_REGIF_GB2LB
//`resetall




module dla_regif_gb2lb
    import PKG_dla_regmap :: *;
(
    //  global signals
    input  logic        clk,
    input  logic        rst,

    //  register interface - GB2LB_CTRL
    input  logic        gb2lb_ctrl_wen,
    output logic [31:0] gb2lb_ctrl_rdata,

    //  register interface - GB2LB_SRC0
    input  logic        gb2lb_src0_wen,
    output logic [31:0] gb2lb_src0_rdata,

    //  register interface - GB2LB_SRC1
    input  logic        gb2lb_src1_wen,
    output logic [31:0] gb2lb_src1_rdata,

    //  register interface - GB2LB_DEST
    input  logic        gb2lb_dest_wen,
    output logic [31:0] gb2lb_dest_rdata,

    //  register interface - general
    input  logic [31:0] regif_wdata,

    //  staging registers
    output logic        go_mov_gb2lb,
    output logic [12:0] stgr_gb2lb_gb_addr,
    output logic [12:0] stgr_gb2lb_gb_skip,
    output logic [10:0] stgr_gb2lb_lb_addr,
    output logic [5:0]  stgr_gb2lb_lb_skip,
    output logic [12:0] stgr_gb2lb_len,
    output logic [5:0]  stgr_gb2lb_iter
);

    REG_GB2LB_SRC0_t    reg_src0;
    REG_GB2LB_SRC1_t    reg_src1;
    REG_GB2LB_DEST_t    reg_dest;
    REG_GB2LB_CTRL_t    reg_ctrl;

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_gb2lb_src0
        if (rst) begin
            reg_src0.len  <= 13'd0;
            reg_src0.addr <= 13'd0;
        end
        else if (gb2lb_src0_wen) begin
            reg_src0.len  <= regif_wdata[28:16];
            reg_src0.addr <= regif_wdata[12:0];
        end
    end: b_reg_gb2lb_src0

    assign gb2lb_src0_rdata = {
        3'd0, reg_src0.len,
        3'd0, reg_src0.addr

    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_gb2lb_src1
        if (rst) begin
            reg_src1.iter <= 6'd0;
            reg_src1.skip <= 13'd0;
        end
        else if (gb2lb_src1_wen) begin
            reg_src1.iter <= regif_wdata[21:16];
            reg_src1.skip <= regif_wdata[12:0];
        end
    end: b_reg_gb2lb_src1

    assign gb2lb_src1_rdata = {
        10'd0, reg_src1.iter,
        3'd0, reg_src1.skip
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_gb2lb_dest
        if (rst) begin
            reg_dest.skip <= 6'd0;
            reg_dest.addr <= 11'd0;
        end
        else if (gb2lb_dest_wen) begin
            reg_dest.skip <= regif_wdata[21:16];
            reg_dest.addr <= regif_wdata[10:0];
        end
    end: b_reg_gb2lb_dest

    assign gb2lb_dest_rdata = {
        10'd0, reg_dest.skip,
        5'd0, reg_dest.addr
    };

// =============================================================================
    assign gb2lb_ctrl_rdata = 32'd0;

    assign reg_ctrl.go = gb2lb_ctrl_wen && regif_wdata[31];

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_gb2lb_stage
        if (rst) begin
            stgr_gb2lb_gb_addr <= 13'd0;
            stgr_gb2lb_gb_skip <= 13'd0;
            stgr_gb2lb_lb_addr <= 11'd0;
            stgr_gb2lb_lb_skip <= 6'd0;
            stgr_gb2lb_len     <= 13'd0;
            stgr_gb2lb_iter    <= 6'd0;
        end
        else if (reg_ctrl.go) begin
            stgr_gb2lb_gb_addr <= reg_src0.addr;
            stgr_gb2lb_gb_skip <= reg_src1.skip;
            stgr_gb2lb_lb_addr <= reg_dest.addr;
            stgr_gb2lb_lb_skip <= reg_dest.skip;
            stgr_gb2lb_len     <= reg_src0.len;
            stgr_gb2lb_iter    <= reg_src1.iter;
        end
    end: b_gb2lb_stage

    assign go_mov_gb2lb = reg_ctrl.go;

endmodule: dla_regif_gb2lb

`endif
