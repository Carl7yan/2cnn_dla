// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_regif_glb.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Repository:     http://10.137.20.23/bcrc-soc/tj3.git
//  Author(s):
//                  Haozhe.Zhu (zhutmost@outlook.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

//`resetall

`include "INC_global.sv"

module  dla_regif_glb
    import PKG_dla_typedef :: *;
    import PKG_dla_regmap :: *;
(
    //  global signals
    input  logic    clk,
    input  logic    rst,

    //  control signals
    output logic [15:0] stgr_enable_row,
    output logic [15:0] stgr_enable_col,
    output status_e     stgr_status,

    output logic [3:0]  stgr_precision_ape_shift,
    output logic [3:0]  stgr_precision_kpe_shift,
    output precision_ifmap_e    stgr_precision_ifmap,
    output precision_weight_e   stgr_precision_weight,

    //  register interface - GLB_STATUS
    // input  logic        glb_status_wen,
    output logic [31:0] glb_status_rdata,

    //  register interface - GLB_INTR
    input  logic        glb_intr_wen,
    output logic [31:0] glb_intr_rdata,

    //  register interface - GLB_ENABLE_ROW
    input  logic        glb_enable_row_wen,
    output logic [31:0] glb_enable_row_rdata,

    //  register interface - GLB_ENABLE_COL
    input  logic        glb_enable_col_wen,
    output logic [31:0] glb_enable_col_rdata,

    //  register interface - COMP_PRECISION
    input  logic        comp_precision_wen,
    output logic [31:0] comp_precision_rdata,

    //  register interface - general
    input  logic [31:0] regif_wdata,

    //  subunit go signals
    input  logic        go_mov_ddr2gb,
    input  logic        go_mov_gb2lb,
    input  logic        go_comp_conv,
    input  logic        go_comp_fc,
    input  logic        go_comp_ape,
    input  logic        go_comp_reshape,

    //  subunit start signals
    output logic        start_mov_ddr2gb,
    output logic        start_mov_gb2lb,
    output logic        start_comp_conv,
    output logic        start_comp_fc,
    output logic        start_comp_ape,
    output logic        start_comp_reshape,

    //  subunit complete signals
    input  logic        complete_mov_ddr2gb,
    input  logic        complete_mov_gb2lb,
    input  logic        complete_comp_conv,
    input  logic        complete_comp_fc,
    input  logic        complete_comp_ape,
    input  logic        complete_comp_reshape,
    input  logic        complete_lpe,

    //  interrupt pad
    output logic        interrupt,

    //output  go_glb//in order to verify this module conveniently, fguo add this siganl to the port list.
);

    REG_GLB_STATUS_t        reg_status;
    REG_GLB_INTR_t          reg_intr;
    REG_GLB_ENABLE_ROW_t    reg_enable_row;
    REG_GLB_ENABLE_COL_t    reg_enable_col;
    REG_PRECISION_t         reg_precision;

    assign interrupt = reg_intr.ddr2gb
                    || reg_intr.gb2lb
                    || reg_intr.conv
                    || reg_intr.fc
                    || reg_intr.ape
                    || reg_intr.reshape;

// =============================================================================

    logic wait_lpe_flag;

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            stgr_status   <= OP_MOV_SOC2GB;
            wait_lpe_flag <= 1'b0;
        end
        else begin
            case (stgr_status)
                OP_MOV_SOC2GB: begin
                    wait_lpe_flag <= 1'b0;
                    if      (go_mov_ddr2gb)   stgr_status <= OP_MOV_DDR2GB;
                    else if (go_mov_gb2lb)    stgr_status <= OP_MOV_GB2LB;
                    else if (go_comp_conv)    stgr_status <= OP_COMP_CONV;
                    else if (go_comp_fc)      stgr_status <= OP_COMP_FC;
                    else if (go_comp_ape)     stgr_status <= OP_COMP_APE;
                    else if (go_comp_reshape) stgr_status <= OP_COMP_RESHAPE;
                end
                OP_MOV_DDR2GB: begin
                    if (complete_mov_ddr2gb) stgr_status <= OP_MOV_SOC2GB;
                end
                OP_MOV_GB2LB: begin
                    if (complete_mov_gb2lb) stgr_status <= OP_MOV_SOC2GB;
                end
                OP_COMP_CONV: begin
                    if (wait_lpe_flag) begin
                        if (complete_lpe) stgr_status <= OP_MOV_SOC2GB;
                    end
                    else begin
                        if (complete_comp_conv) wait_lpe_flag <= 1'b1;
                    end
                end
                OP_COMP_FC: begin
                    if (wait_lpe_flag) begin
                        if (complete_lpe) stgr_status <= OP_MOV_SOC2GB;
                    end
                    else begin
                        if (complete_comp_fc) wait_lpe_flag <= 1'b1;
                    end
                end
                OP_COMP_APE: begin
                    if (complete_comp_ape) stgr_status <= OP_MOV_SOC2GB;
                end
                OP_COMP_RESHAPE: begin
                    if (wait_lpe_flag) begin
                        if (complete_lpe) stgr_status <= OP_MOV_SOC2GB;
                    end
                    else begin
                        if (complete_comp_reshape) wait_lpe_flag <= 1'b1;
                    end
                end
                default: stgr_status <= OP_MOV_SOC2GB;
            endcase
        end
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            start_mov_ddr2gb   <= 1'b0;
            start_mov_gb2lb    <= 1'b0;
            start_comp_conv    <= 1'b0;
            start_comp_fc      <= 1'b0;
            start_comp_ape     <= 1'b0;
            start_comp_reshape <= 1'b0;
        end
        else begin
            start_mov_ddr2gb   <= go_mov_ddr2gb;
            start_mov_gb2lb    <= go_mov_gb2lb;
            start_comp_conv    <= go_comp_conv;
            start_comp_fc      <= go_comp_fc;
            start_comp_ape     <= go_comp_ape;
            start_comp_reshape <= go_comp_reshape;
        end
    end

// =============================================================================

    assign reg_status.ddr2gb  = stgr_status == OP_MOV_DDR2GB;
    assign reg_status.gb2lb   = stgr_status == OP_MOV_GB2LB;
    assign reg_status.conv    = stgr_status == OP_COMP_CONV;
    assign reg_status.fc      = stgr_status == OP_COMP_FC;
    assign reg_status.ape     = stgr_status == OP_COMP_APE;
    assign reg_status.reshape = stgr_status == OP_COMP_RESHAPE;

    assign glb_status_rdata = {
        26'd0,
        reg_status.reshape,
        reg_status.ape,
        reg_status.fc,
        reg_status.conv,
        reg_status.gb2lb,
        reg_status.ddr2gb
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_glb_intr
        if (rst) begin
            reg_intr.reshape <= 1'b0;
            reg_intr.ape     <= 1'b0;
            reg_intr.fc      <= 1'b0;
            reg_intr.conv    <= 1'd0;
            reg_intr.gb2lb   <= 1'd0;
            reg_intr.ddr2gb  <= 1'd0;
        end
        else if (glb_intr_wen) begin
            reg_intr.reshape <= regif_wdata[5] & reg_intr.reshape;
            reg_intr.ape     <= regif_wdata[4] & reg_intr.ape;
            reg_intr.fc      <= regif_wdata[3] & reg_intr.fc;
            reg_intr.conv    <= regif_wdata[2] & reg_intr.conv;
            reg_intr.gb2lb   <= regif_wdata[1] & reg_intr.gb2lb;
            reg_intr.ddr2gb  <= regif_wdata[0] & reg_intr.ddr2gb;
        end
        else begin
            if (complete_lpe & reg_status.reshape) reg_intr.reshape <= 1'b1;
            if (complete_comp_ape)                 reg_intr.ape     <= 1'b1;
            if (complete_lpe & reg_status.fc)      reg_intr.fc      <= 1'b1;
            if (complete_lpe & reg_status.conv)    reg_intr.conv    <= 1'b1;
            if (complete_mov_gb2lb)                reg_intr.gb2lb   <= 1'b1;
            if (complete_mov_ddr2gb)               reg_intr.ddr2gb  <= 1'b1;
        end
    end: b_reg_glb_intr

    assign glb_intr_rdata = {
        29'd0,
        reg_intr.reshape,
        reg_intr.ape,
        reg_intr.fc,
        reg_intr.conv,
        reg_intr.gb2lb,
        reg_intr.ddr2gb
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_glb_enable_row
        if (rst) begin
            reg_enable_row.row <= 16'hffff;
        end
        else if (glb_enable_row_wen) begin
            reg_enable_row.row <= regif_wdata[15:0];
        end
    end: b_reg_glb_enable_row

    assign glb_enable_row_rdata = {16'd0, reg_enable_row.row};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_glb_enable_col
        if (rst) begin
            reg_enable_col.col <= 16'hffff;
        end
        else if (glb_enable_col_wen) begin
            reg_enable_col.col <= regif_wdata[15:0];
        end
    end: b_reg_glb_enable_col

    assign glb_enable_col_rdata = {16'd0, reg_enable_col.col};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_precision
        if (rst) begin
            reg_precision.ape_shift        <= 4'd0;
            reg_precision.kpe_shift        <= 4'd0;
            reg_precision.ifmap_precision  <= 1'd0;
            reg_precision.weight_precision <= 2'd0;
        end
        else if (comp_precision_wen) begin
            reg_precision.ape_shift        <= regif_wdata[27:24];
            reg_precision.kpe_shift        <= regif_wdata[19:16];
            reg_precision.ifmap_precision  <= regif_wdata[8];
            reg_precision.weight_precision <= regif_wdata[1:0];
        end
    end: b_reg_precision

    assign comp_precision_rdata = {
        4'd0, reg_precision.ape_shift,
        4'd0, reg_precision.kpe_shift,
        7'd0, reg_precision.ifmap_precision,
        6'd0, reg_precision.weight_precision
    };

// =============================================================================

    logic go_glb;

    assign go_glb = go_mov_ddr2gb
                 || go_mov_gb2lb
                 || go_comp_conv
                 || go_comp_fc
                 || go_comp_ape
                 || go_comp_reshape;

    always_ff @ (posedge clk or posedge rst) begin: b_reg_glb_stgr
        if (rst) begin
            stgr_enable_row <= 16'h0;
            stgr_enable_col <= 16'h0;

            stgr_precision_ifmap     <= PRECISION_IFMAP_16;
            stgr_precision_weight    <= PRECISION_WEIGHT_16;
            stgr_precision_kpe_shift <= 4'd0;
            stgr_precision_ape_shift <= 4'd0;
        end
        else if (go_glb) begin
            stgr_enable_row <= reg_enable_row.row;
            stgr_enable_col <= reg_enable_col.col;

            case (reg_precision.ifmap_precision)
                1'b0:    stgr_precision_ifmap <= PRECISION_IFMAP_16;
                1'b1:    stgr_precision_ifmap <= PRECISION_IFMAP_8;
                default: stgr_precision_ifmap <= PRECISION_IFMAP_16;
            endcase
            case (reg_precision.weight_precision)
                2'd0:    stgr_precision_weight <= PRECISION_WEIGHT_16;
                2'd1:    stgr_precision_weight <= PRECISION_WEIGHT_8;
                2'd2:    stgr_precision_weight <= PRECISION_WEIGHT_4;
                2'd3:    stgr_precision_weight <= PRECISION_WEIGHT_2;
                default: stgr_precision_weight <= PRECISION_WEIGHT_16;
            endcase
            stgr_precision_kpe_shift <= reg_precision.kpe_shift;
            stgr_precision_ape_shift <= reg_precision.ape_shift;
        end
    end: b_reg_glb_stgr

endmodule: dla_regif_glb
