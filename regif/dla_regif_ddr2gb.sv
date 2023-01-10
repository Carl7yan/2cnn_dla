// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_regif_ddr2gb.sv
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

module dla_regif_ddr2gb
    import PKG_dla_regmap :: *;
(
    //  global signals
    input  logic        clk,
    input  logic        rst,

    //  register interface - DDR2GB_CTRL
    input  logic        ddr2gb_ctrl_wen,
    output logic [31:0] ddr2gb_ctrl_rdata,

    //  register interface - DDR2GB_DDR_ADDR0
    input  logic        ddr2gb_addr0_wen,
    output logic [31:0] ddr2gb_addr0_rdata,

    //  register interface - DDR2GB_DDR_ADDR1
    input  logic        ddr2gb_addr1_wen,
    output logic [31:0] ddr2gb_addr1_rdata,

    //  register interface - DDR2GB_GB_ADDR
    input  logic        ddr2gb_gbaddr_wen,
    output logic [31:0] ddr2gb_gbaddr_rdata,

    //  register interface - general
    input  logic [31:0] regif_wdata,

    //  DDR <-> GB control signals
    output logic        go_mov_ddr2gb,//VCS coverage off
    output logic [53:0] stgr_ddr2gb_ddr_addr,
    output logic        stgr_ddr2gb_ab_sel,
    output logic [12:0] stgr_ddr2gb_gb_addr,
    output logic [3:0]  stgr_ddr2gb_gb_ramidx,
    output logic        stgr_ddr2gb_dir,
    output logic [7:0]  stgr_ddr2gb_len//VCS coverage on
);

    REG_DDR2GB_DDR_ADDR1_t  reg_ddr2gb_addr1;
    REG_DDR2GB_DDR_ADDR0_t  reg_ddr2gb_addr0;
    REG_DDR2GB_GB_ADDR_t    reg_ddr2gb_gbaddr;
    REG_DDR2GB_CTRL_t       reg_ddr2gb_ctrl;

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_ddr2gb_addr0
        if (rst) begin
            reg_ddr2gb_addr0.laddr <= 32'd0;
        end
        else if (ddr2gb_addr0_wen) begin
            reg_ddr2gb_addr0.laddr <= regif_wdata;
        end
    end: b_reg_ddr2gb_addr0

    assign ddr2gb_addr0_rdata = {reg_ddr2gb_addr0.laddr};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_ddr2gb_addr1
        if (rst) begin
            reg_ddr2gb_addr1.haddr <= 22'd0;
        end
        else if (ddr2gb_addr1_wen) begin
            reg_ddr2gb_addr1.haddr <= regif_wdata[21:0];
        end
    end: b_reg_ddr2gb_addr1

    assign ddr2gb_addr1_rdata = {10'd0, reg_ddr2gb_addr1.haddr};

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_ddr2gb_gbaddr
        if (rst) begin
            reg_ddr2gb_gbaddr.len     <= '0;
            reg_ddr2gb_gbaddr.ram_idx <= '0;
            reg_ddr2gb_gbaddr.ab_sel  <= '0;
            reg_ddr2gb_gbaddr.addr    <= '0;
        end
        else if (ddr2gb_gbaddr_wen) begin
            reg_ddr2gb_gbaddr.len     <= regif_wdata[31:24];
            reg_ddr2gb_gbaddr.ram_idx <= regif_wdata[23:20];
            reg_ddr2gb_gbaddr.ab_sel  <= regif_wdata[13];
            reg_ddr2gb_gbaddr.addr    <= regif_wdata[12:0];
        end
    end: b_reg_ddr2gb_gbaddr

    assign ddr2gb_gbaddr_rdata = {
        reg_ddr2gb_gbaddr.len,
        reg_ddr2gb_gbaddr.ram_idx,
        6'd0, reg_ddr2gb_gbaddr.ab_sel,
        reg_ddr2gb_gbaddr.addr
    };

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin: b_reg_ddr2gb_ctrl
        if (rst) begin
            reg_ddr2gb_ctrl.dir <= 1'b0;
        end
        else if (ddr2gb_ctrl_wen) begin
            reg_ddr2gb_ctrl.dir <= regif_wdata[0];
        end
    end: b_reg_ddr2gb_ctrl

    assign ddr2gb_ctrl_rdata = {
        31'd0, reg_ddr2gb_ctrl.dir
    };

    assign reg_ddr2gb_ctrl.go = ddr2gb_ctrl_wen & regif_wdata[31];//VCS coverage off

// =============================================================================

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            stgr_ddr2gb_ddr_addr  <= 54'd0;
            stgr_ddr2gb_ab_sel    <= 1'b0;
            stgr_ddr2gb_gb_addr   <= 13'd0;
            stgr_ddr2gb_len       <= 8'd0;
            stgr_ddr2gb_gb_ramidx <= 4'd0;
            stgr_ddr2gb_dir       <= 1'b0;
        end
        else if (reg_ddr2gb_ctrl.go) begin
            stgr_ddr2gb_ddr_addr  <= {reg_ddr2gb_addr1.haddr, reg_ddr2gb_addr0.laddr};
            stgr_ddr2gb_ab_sel    <= reg_ddr2gb_gbaddr.ab_sel;
            stgr_ddr2gb_gb_addr   <= reg_ddr2gb_gbaddr.addr;
            stgr_ddr2gb_len       <= reg_ddr2gb_gbaddr.len;
            stgr_ddr2gb_gb_ramidx <= reg_ddr2gb_gbaddr.ram_idx;
            stgr_ddr2gb_dir       <= regif_wdata[0];
        end
    end

    assign go_mov_ddr2gb = reg_ddr2gb_ctrl.go;
    //VCS coverage on
endmodule: dla_regif_ddr2gb
