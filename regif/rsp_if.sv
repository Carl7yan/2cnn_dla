`ifndef RSP_IF__SV
`define RSP_IF__SV

interface rsp_if(input bit clk, input bit rst);

//staging registers - GLOBAL
  logic [15 : 0]   stgr_enable_row;
  logic [15 : 0]   stgr_enable_col;
  logic [255 : 0]  stgr_buf_mask;
  status_e         stgr_status;

//staging registers - DDR2GB
  logic [53 : 0]   stgr_ddr2gb_ddr_addr;
  logic            stgr_ddr2gb_ab_sel;
  logic [12 : 0]   stgr_ddr2gb_gb_addr;
  logic [3 : 0]    stgr_ddr2gb_gb_ramidx;
  logic            stgr_ddr2gb_dir;
  logic [7 : 0]           stgr_ddr2gb_len;

//staging registers - GB2LB
  logic [12 : 0]   stgr_gb2lb_gb_addr;
  logic [12 : 0]   stgr_gb2lb_gb_skip;
  logic [10 : 0]   stgr_gb2lb_lb_addr;
  logic [5 : 0]    stgr_gb2lb_lb_skip;
  logic [12 : 0]   stgr_gb2lb_len;
  logic [5 : 0]    stgr_gb2lb_iter;

//staging registers - APE
  logic [12 : 0]   stgr_ape_gb_addr_sa;
  logic [12 : 0]   stgr_ape_gb_addr_sb;
  logic [12 : 0]   stgr_ape_gb_addr_d;
  logic [12 : 0]   stgr_ape_len;
  logic [15 : 0]   stgr_ape_imm;
  ape_mode_e       stgr_ape_mode;

//staging registers - CONV
  logic [5 : 0]   stgr_conv_k_hori_len;
  logic [5 : 0]   stgr_conv_k_vert_len;
  logic [5 : 0]   stgr_conv_k_hori_delta;
  logic [5 : 0]   stgr_conv_k_vert_delta;
  logic [10 : 0]  stgr_conv_k_size_len;
  
  wbload_cmd_e    stgr_conv_wbload_cmd;

  logic [5 : 0]   stgr_conv_of_hori_len;
  logic [5 : 0]   stgr_conv_of_vert_len;
  logic [5 : 0]   stgr_conv_if_hori_len;
  logic [5 : 0]   stgr_conv_if_vert_len;

  logic [5 : 0]   stgr_conv_hori_stride;
  logic [5 : 0]   stgr_conv_vert_stride;
  logic [3 : 0]   stgr_conv_slice_max;

  logic [3 : 0]   stgr_conv_pad_up;
  logic [3 : 0]   stgr_conv_pad_down;
  logic [3 : 0]   stgr_conv_pad_left;
  logic [3 : 0]   stgr_conv_pad_right;
  logic [15 : 0]  stgr_conv_pad_num;

  logic [4 : 0]   stgr_conv_wait_lpe;
  logic           stgr_pool_enable;
  logic           stgr_pool_mode;

// staging registers - COMP FC
  logic [10 : 0]   stgr_fc_addr;
  logic [10 : 0]   stgr_fc_len;
  logic [4 : 0]   stgr_fc_wait_lpe;

// staging registers - COMP RESHAPE 
  logic [10 : 0]   stgr_reshape_addr;
  logic [10 : 0]   stgr_reshape_len;
  logic [5 : 0]    stgr_reshape_iter;
  logic [5 : 0]    stgr_reshape_skip;
  logic [4 : 0]    stgr_reshape_wait_lpe;


// staging registers - PRECISION
  logic [3 : 0]    stgr_precision_ape_shift;
  logic [3 : 0]    stgr_precision_kpe_shift;
  precision_ifmap_e   stgr_precision_ifmap;
  precision_weight_e  stgr_precision_weight;

// staging registers - LPE
  logic [12 : 0]   stgr_lpe_src_addr;
  logic [12 : 0]   stgr_lpe_src_len;
  logic [12 : 0]   stgr_lpe_src_skip;
  logic [12 : 0]   stgr_lpe_src_iter;
  logic [12 : 0]   stgr_lpe_dest_addr;
  logic [12 : 0]   stgr_lpe_dest_len;
  logic [12 : 0]   stgr_lpe_dest_skip;
  logic [12 : 0]   stgr_lpe_dest_iter;
  logic [6 : 0]    stgr_lpe_overlay;
  logic            stgr_lpe_relu;
  logic            stgr_lpe_acc_bypass;
  lpe_sprmps_e     stgr_lpe_sprmps;
  logic [14 : 0][12 : 0]  stgr_lpe_leap;

// staging registers - WB_LOAD
  logic [53 : 0 ]  stgr_wbload_ddr_addr;
  logic [3 : 0]    stgr_wbload_wb_cnt_default;
  logic [1 : 0]    stgr_wbload_kpe_cnt;
  logic [15 : 0]   stgr_wbload_kpe_mask;
  logic [6 : 0]    stgr_wbload_kpe_act_num;
  logic [3 : 0]    stgr_wbload_cpe_idx;
  logic [3 : 0]    stgr_wbload_cpe_cnt;

// SOC2GB signals
  logic bif_gb_soc2gb_ab_sel;
  logic [12 : 0] bif_gb_soc2gb_addr;
  logic [15 : 0] bif_gb_soc2gb_ram_sel;
  logic          bif_gb_soc2gb_wen;
  logic          bif_gb_soc2gb_ren;
  logic [255 : 0] bif_gb_soc2gb_wdata;
  logic [15 : 0][15 : 0] bif_gb_soc2gb_rdata; 

// interrupt
  logic interrupt;

clocking ck@(posedge clk);
default input #1step output #0;
input   stgr_enable_row;
input   stgr_enable_col;
input   stgr_buf_mask;
input   stgr_status;

input   stgr_ddr2gb_ddr_addr;
input   stgr_ddr2gb_ab_sel;
input   stgr_ddr2gb_gb_addr;
input   stgr_ddr2gb_gb_ramidx;
input   stgr_ddr2gb_dir;
input   stgr_ddr2gb_len;

input   stgr_gb2lb_gb_addr;
input   stgr_gb2lb_gb_skip;
input   stgr_gb2lb_lb_addr;
input   stgr_gb2lb_lb_skip;
input   stgr_gb2lb_len;
input   stgr_gb2lb_iter;

input   stgr_ape_gb_addr_sa;
input   stgr_ape_gb_addr_sb;
input   stgr_ape_gb_addr_d;
input   stgr_ape_len;
input   stgr_ape_imm;
input   stgr_ape_mode;

input   stgr_conv_k_hori_len;
input   stgr_conv_k_vert_len;
input   stgr_conv_k_hori_delta;
input   stgr_conv_k_vert_delta;
input   stgr_conv_k_size_len;
input   stgr_conv_wbload_cmd;
input   stgr_conv_of_hori_len;
input   stgr_conv_of_vert_len;
input   stgr_conv_if_hori_len;
input   stgr_conv_if_vert_len;
input   stgr_conv_hori_stride;
input   stgr_conv_vert_stride;
input   stgr_conv_slice_max;
input   stgr_conv_pad_up;
input   stgr_conv_pad_down;
input   stgr_conv_pad_left;
input   stgr_conv_pad_right;
input   stgr_conv_pad_num;
input   stgr_conv_wait_lpe;

input   stgr_pool_enable;
input   stgr_pool_mode;

input   stgr_fc_addr;
input   stgr_fc_len;
input   stgr_fc_wait_lpe;

input   stgr_reshape_addr;
input   stgr_reshape_len;
input   stgr_reshape_iter;
input   stgr_reshape_skip;
input   stgr_reshape_wait_lpe;

input   stgr_precision_ape_shift;
input   stgr_precision_kpe_shift;
input   stgr_precision_ifmap;
input   stgr_precision_weight;

input   stgr_lpe_src_addr;
input   stgr_lpe_src_len;
input   stgr_lpe_src_skip;
input   stgr_lpe_src_iter;
input   stgr_lpe_dest_addr;
input   stgr_lpe_dest_len;
input   stgr_lpe_dest_skip;
input   stgr_lpe_dest_iter;
input   stgr_lpe_overlay;
input   stgr_lpe_relu;
input   stgr_lpe_acc_bypass;
input   stgr_lpe_sprmps;
input   stgr_lpe_leap;

input   stgr_wbload_ddr_addr;
input   stgr_wbload_wb_cnt_default;
input   stgr_wbload_kpe_cnt;
input   stgr_wbload_kpe_mask;
input   stgr_wbload_kpe_act_num;
input   stgr_wbload_cpe_idx;
input   stgr_wbload_cpe_cnt;

input   bif_gb_soc2gb_ab_sel;
input   bif_gb_soc2gb_addr;
input   bif_gb_soc2gb_ram_sel;
input   bif_gb_soc2gb_wen;
input   bif_gb_soc2gb_ren;
input   bif_gb_soc2gb_wdata;

input   interrupt;

output  bif_gb_soc2gb_rdata;
endclocking

endinterface
`endif





































