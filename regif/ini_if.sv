`ifndef INI_IF__SV
`define INI_IF__SV

interface ini_if(input bit clk, input bit rst);
  
//off-chip HZZ bus interface
  logic [21 : 0] regif_addr;
  logic [31 : 0] regif_wdata;
  logic          regif_wen;
  logic [31 : 0] regif_rdata;
  logic          regif_ren;
  logic          regif_rvalid;

// subunit start/complete signals
  logic start_mov_ddr2gb;
  logic start_mov_gb2lb;
  logic start_comp_conv;
  logic start_comp_fc;
  logic start_comp_ape;
  logic start_comp_reshape;

  logic start_lpe;

  logic complete_mov_ddr2gb;
  logic complete_mov_gb2lb;
  logic complete_comp_conv;
  logic complete_comp_fc;
  logic complete_comp_ape;
  logic complete_comp_reshape;
  logic complete_lpe;

clocking cb@(posedge clk);
default input #1step output #0;
  inout regif_rdata;
  input regif_rvalid;

  input start_mov_ddr2gb;
  input start_mov_gb2lb;
  input start_comp_conv;
  input start_comp_fc;
  input start_comp_ape;
  input start_comp_reshape;
  input start_lpe;

  inout   regif_addr;
  output regif_wdata;
  output regif_wen;
  inout   regif_ren;

  output complete_mov_ddr2gb;
  output complete_mov_gb2lb;
  output complete_comp_conv;
  output complete_comp_fc;
  output complete_comp_ape;
  output complete_comp_reshape;
  output complete_lpe;

endclocking

endinterface
`endif