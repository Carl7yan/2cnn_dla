// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_regif_ape.sv
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

module dla_regif_ape
    import PKG_dla_regmap :: *;
    import PKG_dla_typedef :: *;
(
    //  global signals
    input  logic    clk,
    input  logic    rst,

    //  register interface - APE_CTRL
    input  logic        ape_ctrl_wen,
    output logic [31:0] ape_ctrl_rdata,

    //  register interface - APE_SRC
    input  logic        ape_src_wen,
    output logic [31:0] ape_src_rdata,

    //  register interface - APE_DEST
    input  logic        ape_dest_wen,
    output logic [31:0] ape_dest_rdata,

    //  register interface - APE_DEST
    input  logic        ape_imm_wen,
    output logic [31:0] ape_imm_rdata,

    //  register interface - general
    input  logic [31:0] regif_wdata,

    //  staging registers
    output logic        go_comp_ape,
    output logic [12:0] stgr_ape_gb_addr_sa,
    output logic [12:0] stgr_ape_gb_addr_sb,
    output logic [12:0] stgr_ape_gb_addr_d,
    output logic [12:0] stgr_ape_len,
    output logic [15:0] stgr_ape_imm,
    output ape_mode_e   stgr_ape_mode
);

    REG_APE_SRC_t   reg_src;
    REG_APE_DEST_t  reg_dest;
    REG_APE_CTRL_t  reg_ctrl;
    REG_APE_IMM_t   reg_imm;

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_ape_src
        if (rst) begin
            reg_src.gb_addr_sb <= 13'd0;
            reg_src.gb_addr_sa <= 13'd0;
        end
        else if (ape_src_wen) begin
            reg_src.gb_addr_sb <= regif_wdata[28:16];
            reg_src.gb_addr_sa <= regif_wdata[12:0];
        end
    end: b_reg_ape_src

    assign ape_src_rdata = {
        3'd0, reg_src.gb_addr_sb,
        3'd0, reg_src.gb_addr_sa
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_ape_dest
        if (rst) begin
            reg_dest.length    <= 16'd0;
            reg_dest.gb_addr_d <= 13'd0;
        end
        else if (ape_dest_wen) begin
            reg_dest.length    <= regif_wdata[28:16];
            reg_dest.gb_addr_d <= regif_wdata[12:0];
        end
    end: b_reg_ape_dest

    assign ape_dest_rdata = {
        3'd0, reg_dest.length,
        3'd0, reg_dest.gb_addr_d
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_ape_ctrl
        if (rst) begin
            reg_ctrl.mode   <= 3'b0;
        end
        else if (ape_ctrl_wen) begin
            reg_ctrl.mode <= regif_wdata[2:0] > 3'd4 ? 3'd0 : regif_wdata[2:0];
        end
    end: b_reg_ape_ctrl

    assign ape_ctrl_rdata = {
        31'd0, reg_ctrl.mode
    };

    assign reg_ctrl.go = ape_ctrl_wen & regif_wdata[31];

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_ape_imm
        if (rst) begin
            reg_imm.imm <= 16'd0;
        end
        else if (ape_imm_wen) begin
            reg_imm.imm <= regif_wdata[15:0];
        end
    end: b_reg_ape_imm

    assign ape_imm_rdata = {
        16'd0, reg_imm.imm
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_ape_stage
        if (rst) begin
            stgr_ape_gb_addr_sa <= '0;
            stgr_ape_gb_addr_sb <= '0;
            stgr_ape_gb_addr_d  <= '0;
            stgr_ape_len        <= '0;
            stgr_ape_imm        <= '0;
            stgr_ape_mode       <= APE_MODE_IMMADD;
        end
        else if (reg_ctrl.go) begin
            stgr_ape_gb_addr_sa <= reg_src.gb_addr_sa;
            stgr_ape_gb_addr_sb <= reg_src.gb_addr_sb;
            stgr_ape_gb_addr_d  <= reg_dest.gb_addr_d;
            stgr_ape_len        <= reg_dest.length;
            stgr_ape_imm        <= reg_imm.imm;
            case (regif_wdata[2:0])
                3'd0: stgr_ape_mode <= APE_MODE_ELEADD;
                3'd1: stgr_ape_mode <= APE_MODE_ELEMUL;
                3'd2: stgr_ape_mode <= APE_MODE_IMMADD;
                3'd3: stgr_ape_mode <= APE_MODE_IMMMUL;
                3'd4: stgr_ape_mode <= APE_MODE_ACTFUNC;
                default: stgr_ape_mode <= APE_MODE_ACTFUNC;
            endcase
        end
    end: b_ape_stage

    assign go_comp_ape = reg_ctrl.go;

endmodule: dla_regif_ape
