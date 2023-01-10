`ifndef REG_BLOCK_PKG__SV
`define REG_BLOCK_PKG__SV

package reg_block_pkg;
    import uvm_pkg::*;
    import reg_field_pkg::*;
    
    `include "APE.sv"
    `include "BUF.sv"
    `include "COMP_CTRL_PRECISION.sv"
    `include "CONV.sv"
    `include "ddr2gb.sv"
    `include "FC.sv"
    `include "GB2LB.sv"
    `include "GLB.sv"
    `include "LPE.sv"
    `include "RESHAPE.sv"
    `include "SOC2GB.sv"
    `include "WBLOAD.sv"
endpackage
`endif
//all files above is in the directory which path is /home/fguo/Documents/tj3-develop-rtl/test_reg_model/reg_model/uvm_reg_block. 