// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_regif_soc2gb.sv
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

module dla_regif_soc2gb
    import PKG_dla_regmap :: *;
(
    //  global signals
    input  logic    clk,
    input  logic    rst,

    //  register interface - SOC2GB_CONFIG
    input  logic        soc2gb_config_wen,
    output logic [31:0] soc2gb_config_rdata,

    input  logic [19:0] regif_soc2gb_addr,//VCS coverage off
    input  logic        regif_soc2gb_wen,
    input  logic        regif_soc2gb_ren,
    output logic [31:0] regif_soc2gb_rdata,
    output logic        regif_soc2gb_rvalid,//VCS coverage on
    input  logic [31:0] regif_wdata,

    //  global buffer interface
    output logic            bif_gb_soc2gb_ab_sel,//VCS coverage off
    output logic [12:0]     bif_gb_soc2gb_addr,
    output logic [15:0]     bif_gb_soc2gb_ram_sel,
    output logic [255:0]    bif_gb_soc2gb_wdata,
    output logic            bif_gb_soc2gb_wen,
    output logic            bif_gb_soc2gb_ren,
    input  logic [15:0][15:0] bif_gb_soc2gb_rdata//VCS coverage on
);

    // =========================================================================
    //  configuration registers

    REG_SOC2GB_CONFIG_t reg_soc2gb_config;

    logic       stgr_soc2gb_sign_ext;
    logic [1:0] stgr_soc2gb_addr_mode;

    always_ff @ (posedge clk or posedge rst) begin: b_reg_soc2gb_config
        if (rst) begin
            reg_soc2gb_config.sign_ext  <= '0;
            reg_soc2gb_config.addr_mode <= '0;
        end
        else if (soc2gb_config_wen) begin
            reg_soc2gb_config.sign_ext  <= regif_wdata[4];
            reg_soc2gb_config.addr_mode <= regif_wdata[1:0];
        end
    end: b_reg_soc2gb_config

    assign soc2gb_config_rdata = {
        27'd0, reg_soc2gb_config.sign_ext,
        2'b0, reg_soc2gb_config.addr_mode
    };
    //VCS coverage off
    assign stgr_soc2gb_sign_ext  = reg_soc2gb_config.sign_ext;
    assign stgr_soc2gb_addr_mode = reg_soc2gb_config.addr_mode;

    // =========================================================================
    //  write channel

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) bif_gb_soc2gb_wen <= 1'b0;
        else     bif_gb_soc2gb_wen <= regif_soc2gb_wen;
    end

    logic [63:0]    regif_wdata_ext;
    always_comb begin
        regif_wdata_ext[     7-:8]  = regif_wdata[    7-:8];
        regif_wdata_ext[16  +7-:8]  = regif_wdata[8+  7-:8];
        regif_wdata_ext[16*2+7-:8]  = regif_wdata[8*2+7-:8];
        regif_wdata_ext[16*3+7-:8]  = regif_wdata[8*3+7-:8];
        regif_wdata_ext[     15-:8] = stgr_soc2gb_sign_ext ? {8{regif_wdata[7]}} : 8'd0;
        regif_wdata_ext[16  +15-:8] = stgr_soc2gb_sign_ext ? {8{regif_wdata[15]}} : 8'd0;
        regif_wdata_ext[16*2+15-:8] = stgr_soc2gb_sign_ext ? {8{regif_wdata[23]}} : 8'd0;
        regif_wdata_ext[16*3+15-:8] = stgr_soc2gb_sign_ext ? {8{regif_wdata[31]}} : 8'd0;
    end

    logic [2:0]     ram_idx;
    logic [15:0]    ram_sel;
    always_comb begin
        if (regif_soc2gb_wen) begin
            case (stgr_soc2gb_addr_mode)
                2'd0: ram_idx = regif_soc2gb_addr[2:0];
                2'd1: ram_idx = regif_soc2gb_addr[15:13];
                2'd2: ram_idx = {1'b0, regif_soc2gb_addr[1:0]};
                2'd3: ram_idx = {1'b0, regif_soc2gb_addr[14:13]};
                default: ram_idx = regif_soc2gb_addr[2:0];
            endcase
            if (stgr_soc2gb_addr_mode[1]) begin
                case(ram_idx[1:0])
                    2'd0: ram_sel = 16'h000f;
                    2'd1: ram_sel = 16'h00f0;
                    2'd2: ram_sel = 16'h0f00;
                    2'd3: ram_sel = 16'hf000;
                    default: ram_sel = 16'h000f;
                endcase
            end
            else begin
                case(ram_idx)
                    3'd0: ram_sel = 16'b0000_0000_0000_0011;
                    3'd1: ram_sel = 16'b0000_0000_0000_1100;
                    3'd2: ram_sel = 16'b0000_0000_0011_0000;
                    3'd3: ram_sel = 16'b0000_0000_1100_0000;
                    3'd4: ram_sel = 16'b0000_0011_0000_0000;
                    3'd5: ram_sel = 16'b0000_1100_0000_0000;
                    3'd6: ram_sel = 16'b0011_0000_0000_0000;
                    3'd7: ram_sel = 16'b1100_0000_0000_0000;
                    default: ram_sel = 16'b0000_0000_0000_0011;
                endcase
            end
        end
        else begin
            ram_idx = stgr_soc2gb_addr_mode[0] ? regif_soc2gb_addr[15:13] : regif_soc2gb_addr[2:0];
            case(ram_idx)
                3'd0: ram_sel = 16'b0000_0000_0000_0011;
                3'd1: ram_sel = 16'b0000_0000_0000_1100;
                3'd2: ram_sel = 16'b0000_0000_0011_0000;
                3'd3: ram_sel = 16'b0000_0000_1100_0000;
                3'd4: ram_sel = 16'b0000_0011_0000_0000;
                3'd5: ram_sel = 16'b0000_1100_0000_0000;
                3'd6: ram_sel = 16'b0011_0000_0000_0000;
                3'd7: ram_sel = 16'b1100_0000_0000_0000;
                default: ram_sel = 16'b0000_0000_0000_0011;
            endcase
        end
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            bif_gb_soc2gb_ab_sel  <= '0;
            bif_gb_soc2gb_addr    <= '0;
            bif_gb_soc2gb_ram_sel <= '0;
            bif_gb_soc2gb_wdata   <= '0;
        end
        else if (regif_soc2gb_wen) begin
            bif_gb_soc2gb_ram_sel <= ram_sel;
            case (stgr_soc2gb_addr_mode)
                2'd0: begin // 2-input-channel-cross
                    bif_gb_soc2gb_ab_sel <= regif_soc2gb_addr[16];
                    bif_gb_soc2gb_addr   <= regif_soc2gb_addr[15:3];
                    bif_gb_soc2gb_wdata  <= {8{regif_wdata}};
                end
                2'd1: begin // 2-input-channel-flat
                    bif_gb_soc2gb_ab_sel <= regif_soc2gb_addr[16];
                    bif_gb_soc2gb_addr   <= regif_soc2gb_addr[12:0];
                    bif_gb_soc2gb_wdata  <= {8{regif_wdata}};
                end
                2'd2: begin // 4-input-channel-cross
                    bif_gb_soc2gb_ab_sel <= regif_soc2gb_addr[15];
                    bif_gb_soc2gb_addr   <= regif_soc2gb_addr[14:2];
                    bif_gb_soc2gb_wdata  <= {4{regif_wdata_ext}};
                end
                2'd3: begin // 4-input-channel-flat
                    bif_gb_soc2gb_ab_sel <= regif_soc2gb_addr[15];
                    bif_gb_soc2gb_addr   <= regif_soc2gb_addr[12:0];
                    bif_gb_soc2gb_wdata  <= {4{regif_wdata_ext}};
                end
                default: begin
                    bif_gb_soc2gb_ab_sel <= regif_soc2gb_addr[16];
                    bif_gb_soc2gb_addr   <= regif_soc2gb_addr[12:0];
                    bif_gb_soc2gb_wdata  <= {8{regif_wdata}};
                end
            endcase
        end
        else if (regif_soc2gb_ren) begin
            bif_gb_soc2gb_ram_sel <= ram_sel;
            case (stgr_soc2gb_addr_mode[0])
                1'd0: begin // 2-input-channel-cross
                    bif_gb_soc2gb_ab_sel <= regif_soc2gb_addr[16];
                    bif_gb_soc2gb_addr   <= regif_soc2gb_addr[15:3];
                end
                1'd1: begin // 2-input-channel-flat
                    bif_gb_soc2gb_ab_sel <= regif_soc2gb_addr[16];
                    bif_gb_soc2gb_addr   <= regif_soc2gb_addr[12:0];
                end
            endcase
        end
    end

    // =========================================================================
    //  read channel

    logic       bif_gb_soc2gb_rvalid;
    logic [2:0] ram_idx_d1;

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) bif_gb_soc2gb_ren <= 1'b0;
        else bif_gb_soc2gb_ren <= regif_soc2gb_ren;
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) bif_gb_soc2gb_rvalid <= 1'b0;
        else bif_gb_soc2gb_rvalid <= bif_gb_soc2gb_ren;
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) regif_soc2gb_rvalid <= 1'b0;
        else regif_soc2gb_rvalid <= bif_gb_soc2gb_rvalid;
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) ram_idx_d1 <= '0;
        else ram_idx_d1 <= ram_idx;
    end

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) begin
            regif_soc2gb_rdata <= '0;
        end
        else if (bif_gb_soc2gb_rvalid) begin
            case (ram_idx_d1)
                3'd0: regif_soc2gb_rdata <= bif_gb_soc2gb_rdata[1:0];
                3'd1: regif_soc2gb_rdata <= bif_gb_soc2gb_rdata[3:2];
                3'd2: regif_soc2gb_rdata <= bif_gb_soc2gb_rdata[5:4];
                3'd3: regif_soc2gb_rdata <= bif_gb_soc2gb_rdata[7:6];
                3'd4: regif_soc2gb_rdata <= bif_gb_soc2gb_rdata[9:8];
                3'd5: regif_soc2gb_rdata <= bif_gb_soc2gb_rdata[11:10];
                3'd6: regif_soc2gb_rdata <= bif_gb_soc2gb_rdata[13:12];
                3'd7: regif_soc2gb_rdata <= bif_gb_soc2gb_rdata[15:14];
                default: regif_soc2gb_rdata <= bif_gb_soc2gb_rdata[1:0];
            endcase
        end
    end//VCS coverage on

endmodule // dla_regif_soc2gb
