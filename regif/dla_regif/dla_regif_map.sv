// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      dla_regif_map.sv
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

module dla_regif_map
    import PKG_dla_regmap :: *;
(
    //  global signals
    input  logic        clk,
    input  logic        rst,

    //  off-chip HZZ bus interface
    input  logic [19:0] regif_map_addr,
    input  logic        regif_map_wen,
    output logic [31:0] regif_map_rdata,
    input  logic        regif_map_ren,
    output logic        regif_map_rvalid,

    //  registers - SOC2GB_CONFIG
    output logic        soc2gb_config_wen,
    input  logic [31:0] soc2gb_config_rdata,

    //  registers - DDR2GB_CTRL
    output logic        ddr2gb_ctrl_wen,
    input  logic [31:0] ddr2gb_ctrl_rdata,
    //  registers - DDR2GB_DDR_ADDR0
    output logic        ddr2gb_addr0_wen,
    input  logic [31:0] ddr2gb_addr0_rdata,
    //  registers - DDR2GB_DDR_ADDR1
    output logic        ddr2gb_addr1_wen,
    input  logic [31:0] ddr2gb_addr1_rdata,
    //  registers - DDR2GB_GB_ADDR
    output logic        ddr2gb_gbaddr_wen,
    input  logic [31:0] ddr2gb_gbaddr_rdata,

    //  register interface - GB2LB_CTRL
    output logic        gb2lb_ctrl_wen,
    input  logic [31:0] gb2lb_ctrl_rdata,
    //  register interface - GB2LB_SRC0
    output logic        gb2lb_src0_wen,
    input  logic [31:0] gb2lb_src0_rdata,
    //  register interface - GB2LB_SRC1
    output logic        gb2lb_src1_wen,
    input  logic [31:0] gb2lb_src1_rdata,
    //  register interface - GB2LB_DEST
    output logic        gb2lb_dest_wen,
    input  logic [31:0] gb2lb_dest_rdata,

    //  register interface - APE_CTRL
    output logic        ape_ctrl_wen,
    input  logic [31:0] ape_ctrl_rdata,
    //  register interface - APE_SRC
    output logic        ape_src_wen,
    input  logic [31:0] ape_src_rdata,
    //  register interface - APE_DEST
    output logic        ape_dest_wen,
    input  logic [31:0] ape_dest_rdata,
    //  register interface - APE_DEST
    output logic        ape_imm_wen,
    input  logic [31:0] ape_imm_rdata,

    //  register interface - CONV_K_SIZE0
    output logic        conv_k_size0_wen,
    input  logic [31:0] conv_k_size0_rdata,
    //  register interface - CONV_K_SIZE1
    output logic        conv_k_size1_wen,
    input  logic [31:0] conv_k_size1_rdata,
    //  register interface - CONV_K_LOAD
    output logic        conv_k_load_wen,
    input  logic [31:0] conv_k_load_rdata,
    //  register interface - CONV_FMAP
    output logic        conv_fmap_wen,
    input  logic [31:0] conv_fmap_rdata,
    //  register interface - CONV_STRIDE
    output logic        conv_stride_wen,
    input  logic [31:0] conv_stride_rdata,
    //  register interface - CONV_PAD_SIZE
    output logic        conv_pad_size_wen,
    input  logic [31:0] conv_pad_size_rdata,
    //  register interface - CONV_PAD_NUM
    output logic        conv_pad_num_wen,
    input  logic [31:0] conv_pad_num_rdata,

    //  register interface - FC_SRC
    output logic        fc_src_wen,
    input  logic [31:0] fc_src_rdata,

    //  register interface - RESHAPE_SRC0
    output logic        reshape_src0_wen,
    input  logic [31:0] reshape_src0_rdata,
    //  register interface - RESHAPE_SRC1
    output logic        reshape_src1_wen,
    input  logic [31:0] reshape_src1_rdata,

    //  register interface - LPE_SRC0
    output logic        lpe_src0_wen,
    input  logic [31:0] lpe_src0_rdata,
    //  register interface - LPE_SRC1
    output logic        lpe_src1_wen,
    input  logic [31:0] lpe_src1_rdata,
    //  register interface - LPE_DEST0
    output logic        lpe_dest0_wen,
    input  logic [31:0] lpe_dest0_rdata,
    //  register interface - LPE_DEST1
    output logic        lpe_dest1_wen,
    input  logic [31:0] lpe_dest1_rdata,
    //  register interface - LPE_MODE
    output logic        lpe_mode_wen,
    input  logic [31:0] lpe_mode_rdata,
    //  register interface - LPE_LEAP0
    output logic        lpe_leap0_wen,
    input  logic [31:0] lpe_leap0_rdata,
    //  register interface - LPE_LEAP1
    output logic        lpe_leap1_wen,
    input  logic [31:0] lpe_leap1_rdata,
    //  register interface - LPE_LEAP2
    output logic        lpe_leap2_wen,
    input  logic [31:0] lpe_leap2_rdata,
    //  register interface - LPE_LEAP3
    output logic        lpe_leap3_wen,
    input  logic [31:0] lpe_leap3_rdata,
    //  register interface - LPE_LEAP4
    output logic        lpe_leap4_wen,
    input  logic [31:0] lpe_leap4_rdata,
    //  register interface - LPE_LEAP5
    output logic        lpe_leap5_wen,
    input  logic [31:0] lpe_leap5_rdata,
    //  register interface - LPE_LEAP6
    output logic        lpe_leap6_wen,
    input  logic [31:0] lpe_leap6_rdata,
    //  register interface - LPE_LEAP7
    output logic        lpe_leap7_wen,
    input  logic [31:0] lpe_leap7_rdata,

    //  register interface - WBLOAD_DDR_ADDR0
    output logic        wbload_ddr_addr0_wen,
    input  logic [31:0] wbload_ddr_addr0_rdata,
    //  register interface - WBLOAD_DDR_ADDR1
    output logic        wbload_ddr_addr1_wen,
    input  logic [31:0] wbload_ddr_addr1_rdata,
    //  register interface - WBLOAD_KERNEL
    output logic        wbload_kernel_wen,
    input  logic [31:0] wbload_kernel_rdata,
    //  register interface - WBLOAD_CHANNEL
    output logic        wbload_channel_wen,
    input  logic [31:0] wbload_channel_rdata,

    //  register interface - COMP_CTRL
    output logic        comp_ctrl_wen,
    input  logic [31:0] comp_ctrl_rdata,
    //  register interface - COMP_PRECISION
    output logic        comp_precision_wen,
    input  logic [31:0] comp_precision_rdata,

    //  register interface - GLB_STATUS
    output logic        glb_status_wen,
    input  logic [31:0] glb_status_rdata,
    //  register interface - GLB_INTR
    output logic        glb_intr_wen,
    input  logic [31:0] glb_intr_rdata,
    //  register interface - GLB_ENABLE_ROW
    output logic        glb_enable_row_wen,
    input  logic [31:0] glb_enable_row_rdata,
    //  register interface - GLB_ENABLE_COL
    output logic        glb_enable_col_wen,
    input  logic [31:0] glb_enable_col_rdata,

    //  register interface - BUF_MASKX
    output logic        buf_maskx_wen,
    input  logic [31:0] buf_maskx_rdata,
    //  register interface - BUF_MASK0
    output logic        buf_mask0_wen,
    input  logic [31:0] buf_mask0_rdata,
    //  register interface - BUF_MASK1
    output logic        buf_mask1_wen,
    input  logic [31:0] buf_mask1_rdata,
    //  register interface - BUF_MASK2
    output logic        buf_mask2_wen,
    input  logic [31:0] buf_mask2_rdata,
    //  register interface - BUF_MASK3
    output logic        buf_mask3_wen,
    input  logic [31:0] buf_mask3_rdata,
    //  register interface - BUF_MASK4
    output logic        buf_mask4_wen,
    input  logic [31:0] buf_mask4_rdata,
    //  register interface - BUF_MASK5
    output logic        buf_mask5_wen,
    input  logic [31:0] buf_mask5_rdata,
    //  register interface - BUF_MASK6
    output logic        buf_mask6_wen,
    input  logic [31:0] buf_mask6_rdata,
    //  register interface - BUF_MASK7
    output logic        buf_mask7_wen,
    input  logic [31:0] buf_mask7_rdata
);

    logic [31:0]    unknown_reg_rdata;

    always_comb begin
        soc2gb_config_wen = 1'b0;

        ddr2gb_addr1_wen  = 1'b0;
        ddr2gb_addr0_wen  = 1'b0;
        ddr2gb_gbaddr_wen = 1'b0;
        ddr2gb_ctrl_wen   = 1'b0;

        gb2lb_ctrl_wen = 1'b0;
        gb2lb_src0_wen = 1'b0;
        gb2lb_src1_wen = 1'b0;
        gb2lb_dest_wen = 1'b0;

        conv_k_size0_wen  = 1'b0;
        conv_k_size1_wen  = 1'b0;
        conv_k_load_wen   = 1'b0;
        conv_fmap_wen     = 1'b0;
        conv_stride_wen   = 1'b0;
        conv_pad_size_wen = 1'b0;
        conv_pad_num_wen  = 1'b0;

        fc_src_wen = 1'b0;

        reshape_src0_wen = 1'b0;
        reshape_src1_wen = 1'b0;

        lpe_src0_wen  = 1'b0;
        lpe_src1_wen  = 1'b0;
        lpe_dest0_wen = 1'b0;
        lpe_dest1_wen = 1'b0;
        lpe_mode_wen  = 1'b0;
        lpe_leap0_wen = 1'b0;
        lpe_leap1_wen = 1'b0;
        lpe_leap2_wen = 1'b0;
        lpe_leap3_wen = 1'b0;
        lpe_leap4_wen = 1'b0;
        lpe_leap5_wen = 1'b0;
        lpe_leap6_wen = 1'b0;
        lpe_leap7_wen = 1'b0;

        wbload_ddr_addr0_wen = 1'b0;
        wbload_ddr_addr1_wen = 1'b0;
        wbload_kernel_wen    = 1'b0;
        wbload_channel_wen   = 1'b0;

        comp_ctrl_wen      = 1'b0;
        comp_precision_wen = 1'b0;

        ape_ctrl_wen = 1'b0;
        ape_src_wen  = 1'b0;
        ape_dest_wen = 1'b0;
        ape_imm_wen  = 1'b0;

        glb_status_wen     = 1'b0;
        glb_intr_wen       = 1'b0;
        glb_enable_row_wen = 1'b0;
        glb_enable_col_wen = 1'b0;

        buf_maskx_wen = 1'b0;
        buf_mask0_wen = 1'b0;
        buf_mask1_wen = 1'b0;
        buf_mask2_wen = 1'b0;
        buf_mask3_wen = 1'b0;
        buf_mask4_wen = 1'b0;
        buf_mask5_wen = 1'b0;
        buf_mask6_wen = 1'b0;
        buf_mask7_wen = 1'b0;

        case (regif_map_addr)
            REGMAP_SOC2GB_CONFIG: begin
                soc2gb_config_wen = regif_map_wen;
                regif_map_rdata   = soc2gb_config_rdata;
            end

            REGMAP_DDR2GB_CTRL: begin
                ddr2gb_ctrl_wen = regif_map_wen;
                regif_map_rdata = ddr2gb_ctrl_rdata;
            end
            REGMAP_DDR2GB_DDR_ADDR0: begin
                ddr2gb_addr0_wen = regif_map_wen;
                regif_map_rdata  = ddr2gb_addr0_rdata;
            end
            REGMAP_DDR2GB_DDR_ADDR1: begin
                ddr2gb_addr1_wen = regif_map_wen;
                regif_map_rdata  = ddr2gb_addr1_rdata;
            end
            REGMAP_DDR2GB_GB_ADDR: begin
                ddr2gb_gbaddr_wen = regif_map_wen;
                regif_map_rdata   = ddr2gb_gbaddr_rdata;
            end

            REGMAP_GB2LB_SRC0: begin
                gb2lb_src0_wen  = regif_map_wen;
                regif_map_rdata = gb2lb_src0_rdata;
            end
            REGMAP_GB2LB_SRC1: begin
                gb2lb_src1_wen  = regif_map_wen;
                regif_map_rdata = gb2lb_src1_rdata;
            end
            REGMAP_GB2LB_DEST: begin
                gb2lb_dest_wen  = regif_map_wen;
                regif_map_rdata = gb2lb_dest_rdata;
            end
            REGMAP_GB2LB_CTRL: begin
                gb2lb_ctrl_wen  = regif_map_wen;
                regif_map_rdata = gb2lb_ctrl_rdata;
            end

            REGMAP_APE_CTRL: begin
                ape_ctrl_wen    = regif_map_wen;
                regif_map_rdata = ape_ctrl_rdata;
            end
            REGMAP_APE_SRC: begin
                ape_src_wen     = regif_map_wen;
                regif_map_rdata = ape_src_rdata;
            end
            REGMAP_APE_DEST: begin
                ape_dest_wen    = regif_map_wen;
                regif_map_rdata = ape_dest_rdata;
            end
            REGMAP_APE_IMM: begin
                ape_imm_wen     = regif_map_wen;
                regif_map_rdata = ape_imm_rdata;
            end

            REGMAP_CONV_K_SIZE0: begin
                conv_k_size0_wen = regif_map_wen;
                regif_map_rdata  = conv_k_size0_rdata;
            end
            REGMAP_CONV_K_SIZE1: begin
                conv_k_size1_wen = regif_map_wen;
                regif_map_rdata  = conv_k_size1_rdata;
            end
            REGMAP_CONV_K_LOAD: begin
                conv_k_load_wen = regif_map_wen;
                regif_map_rdata = conv_k_load_rdata;
            end
            REGMAP_CONV_FMAP: begin
                conv_fmap_wen   = regif_map_wen;
                regif_map_rdata = conv_fmap_rdata;
            end
            REGMAP_CONV_STRIDE: begin
                conv_stride_wen = regif_map_wen;
                regif_map_rdata = conv_stride_rdata;
            end
            REGMAP_CONV_PAD_SIZE: begin
                conv_pad_size_wen = regif_map_wen;
                regif_map_rdata   = conv_pad_size_rdata;
            end
            REGMAP_CONV_PAD_NUM: begin
                conv_pad_num_wen = regif_map_wen;
                regif_map_rdata  = conv_pad_num_rdata;
            end

            REGMAP_FC_SRC: begin
                fc_src_wen      = regif_map_wen;
                regif_map_rdata = fc_src_rdata;
            end

            REGMAP_RESHAPE_SRC0: begin
                reshape_src0_wen = regif_map_wen;
                regif_map_rdata  = reshape_src0_rdata;
            end
            REGMAP_RESHAPE_SRC1: begin
                reshape_src1_wen = regif_map_wen;
                regif_map_rdata  = reshape_src1_rdata;
            end

            REGMAP_LPE_SRC0: begin
                lpe_src0_wen    = regif_map_wen;
                regif_map_rdata = lpe_src0_rdata;
            end
            REGMAP_LPE_SRC1: begin
                lpe_src1_wen    = regif_map_wen;
                regif_map_rdata = lpe_src1_rdata;
            end
            REGMAP_LPE_DEST0: begin
                lpe_dest0_wen   = regif_map_wen;
                regif_map_rdata = lpe_dest0_rdata;
            end
            REGMAP_LPE_DEST1: begin
                lpe_dest1_wen   = regif_map_wen;
                regif_map_rdata = lpe_dest1_rdata;
            end
            REGMAP_LPE_MODE: begin
                lpe_mode_wen    = regif_map_wen;
                regif_map_rdata = lpe_mode_rdata;
            end
            REGMAP_LPE_LEAP0: begin
                lpe_leap0_wen   = regif_map_wen;
                regif_map_rdata = lpe_leap0_rdata;
            end
            REGMAP_LPE_LEAP1: begin
                lpe_leap1_wen   = regif_map_wen;
                regif_map_rdata = lpe_leap1_rdata;
            end
            REGMAP_LPE_LEAP2: begin
                lpe_leap2_wen   = regif_map_wen;
                regif_map_rdata = lpe_leap2_rdata;
            end
            REGMAP_LPE_LEAP3: begin
                lpe_leap3_wen   = regif_map_wen;
                regif_map_rdata = lpe_leap3_rdata;
            end
            REGMAP_LPE_LEAP4: begin
                lpe_leap4_wen   = regif_map_wen;
                regif_map_rdata = lpe_leap4_rdata;
            end
            REGMAP_LPE_LEAP5: begin
                lpe_leap5_wen   = regif_map_wen;
                regif_map_rdata = lpe_leap5_rdata;
            end
            REGMAP_LPE_LEAP6: begin
                lpe_leap6_wen   = regif_map_wen;
                regif_map_rdata = lpe_leap6_rdata;
            end
            REGMAP_LPE_LEAP7: begin
                lpe_leap7_wen   = regif_map_wen;
                regif_map_rdata = lpe_leap7_rdata;
            end

            REGMAP_WBLOAD_DDR_ADDR0: begin
                wbload_ddr_addr0_wen = regif_map_wen;
                regif_map_rdata      = wbload_ddr_addr0_rdata;
            end
            REGMAP_WBLOAD_DDR_ADDR1: begin
                wbload_ddr_addr1_wen = regif_map_wen;
                regif_map_rdata      = wbload_ddr_addr1_rdata;
            end
            REGMAP_WBLOAD_KERNEL: begin
                wbload_kernel_wen = regif_map_wen;
                regif_map_rdata   = wbload_kernel_rdata;
            end
            REGMAP_WBLOAD_CHANNEL: begin
                wbload_channel_wen = regif_map_wen;
                regif_map_rdata    = wbload_channel_rdata;
            end

            REGMAP_COMP_CTRL: begin
                comp_ctrl_wen   = regif_map_wen;
                regif_map_rdata = comp_ctrl_rdata;
            end
            REGMAP_COMP_PRECISION: begin
                comp_precision_wen = regif_map_wen;
                regif_map_rdata    = comp_precision_rdata;
            end

            REGMAP_GLB_STATUS: begin
                glb_status_wen  = regif_map_wen;
                regif_map_rdata = glb_status_rdata;
            end
            REGMAP_GLB_INTR: begin
                glb_intr_wen    = regif_map_wen;
                regif_map_rdata = glb_intr_rdata;
            end
            REGMAP_GLB_ENABLE_ROW: begin
                glb_enable_row_wen = regif_map_wen;
                regif_map_rdata    = glb_enable_row_rdata;
            end
            REGMAP_GLB_ENABLE_COL: begin
                glb_enable_col_wen = regif_map_wen;
                regif_map_rdata    = glb_enable_col_rdata;
            end

            REGMAP_BUF_MASKX: begin
                buf_maskx_wen   = regif_map_wen;
                regif_map_rdata = buf_maskx_rdata;
            end
            REGMAP_BUF_MASK0: begin
                buf_mask0_wen   = regif_map_wen;
                regif_map_rdata = buf_mask0_rdata;
            end
            REGMAP_BUF_MASK1: begin
                buf_mask1_wen   = regif_map_wen;
                regif_map_rdata = buf_mask1_rdata;
            end
            REGMAP_BUF_MASK2: begin
                buf_mask2_wen   = regif_map_wen;
                regif_map_rdata = buf_mask2_rdata;
            end
            REGMAP_BUF_MASK3: begin
                buf_mask3_wen   = regif_map_wen;
                regif_map_rdata = buf_mask3_rdata;
            end
            REGMAP_BUF_MASK4: begin
                buf_mask4_wen   = regif_map_wen;
                regif_map_rdata = buf_mask4_rdata;
            end
            REGMAP_BUF_MASK5: begin
                buf_mask5_wen   = regif_map_wen;
                regif_map_rdata = buf_mask5_rdata;
            end
            REGMAP_BUF_MASK6: begin
                buf_mask6_wen   = regif_map_wen;
                regif_map_rdata = buf_mask6_rdata;
            end
            REGMAP_BUF_MASK7: begin
                buf_mask7_wen   = regif_map_wen;
                regif_map_rdata = buf_mask7_rdata;
            end

            default: begin
                regif_map_rdata = unknown_reg_rdata;

                soc2gb_config_wen = 1'b0;

                ddr2gb_ctrl_wen   = 1'b0;
                ddr2gb_addr0_wen  = 1'b0;
                ddr2gb_addr1_wen  = 1'b0;
                ddr2gb_gbaddr_wen = 1'b0;

                gb2lb_src0_wen = 1'b0;
                gb2lb_src1_wen = 1'b0;
                gb2lb_dest_wen = 1'b0;
                gb2lb_ctrl_wen = 1'b0;

                ape_src_wen  = 1'b0;
                ape_dest_wen = 1'b0;
                ape_ctrl_wen = 1'b0;
                ape_imm_wen  = 1'b0;

                conv_k_size0_wen  = 1'b0;
                conv_k_size1_wen  = 1'b0;
                conv_k_load_wen   = 1'b0;
                conv_fmap_wen     = 1'b0;
                conv_stride_wen   = 1'b0;
                conv_pad_size_wen = 1'b0;
                conv_pad_num_wen  = 1'b0;

                fc_src_wen = 1'b0;

                reshape_src0_wen = 1'b0;
                reshape_src1_wen = 1'b0;

                lpe_src0_wen  = 1'b0;
                lpe_src1_wen  = 1'b0;
                lpe_dest0_wen = 1'b0;
                lpe_dest1_wen = 1'b0;
                lpe_mode_wen  = 1'b0;
                lpe_leap0_wen = 1'b0;
                lpe_leap1_wen = 1'b0;
                lpe_leap2_wen = 1'b0;
                lpe_leap3_wen = 1'b0;
                lpe_leap4_wen = 1'b0;
                lpe_leap5_wen = 1'b0;
                lpe_leap6_wen = 1'b0;
                lpe_leap7_wen = 1'b0;

                wbload_ddr_addr0_wen = 1'b0;
                wbload_ddr_addr1_wen = 1'b0;
                wbload_kernel_wen    = 1'b0;
                wbload_channel_wen   = 1'b0;

                comp_ctrl_wen      = 1'b0;
                comp_precision_wen = 1'b0;

                glb_status_wen     = 1'b0;
                glb_intr_wen       = 1'b0;
                glb_enable_row_wen = 1'b0;
                glb_enable_col_wen = 1'b0;

                buf_maskx_wen = 1'b0;
                buf_mask0_wen = 1'b0;
                buf_mask1_wen = 1'b0;
                buf_mask2_wen = 1'b0;
                buf_mask3_wen = 1'b0;
                buf_mask4_wen = 1'b0;
                buf_mask5_wen = 1'b0;
                buf_mask6_wen = 1'b0;
                buf_mask7_wen = 1'b0;
            end // case (regif_map_addr) -> default:
        endcase // case (regif_map_addr)
    end

    assign unknown_reg_rdata = 32'h3f1b_00e5;

    always_ff @ (posedge clk or posedge rst) begin
        if (rst) regif_map_rvalid <= 1'b0;
        else     regif_map_rvalid <= regif_map_ren;
    end

endmodule: dla_regif_map
