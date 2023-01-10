import uvm_pkg::*;
import PKG_dla_regmap::*;
import PKG_dla_typedef::*;
import reg_model_pkg::*;
`include "ini_if.sv"
`include "rsp_if.sv"
import testbench_pkg::*;


module top_tb;

bit clk;
bit rst;

ini_if ini_if3(clk,rst);
rsp_if rsp_if2(clk,rst);

initial begin
    clk = 0;
    rst = 0;
    #2 rst = 1;
    #2 rst = 0;
end

always #1 clk = !clk;

initial begin
   $vcdpluson;
end

initial begin
    uvm_config_db#(virtual ini_if)::set(null,"uvm_test_top.env.bus_agt1.ini_drv1","ini_if_initiator",ini_if3);
    uvm_config_db#(virtual ini_if)::set(null,"uvm_test_top.env.bus_agt1.ini_mon1","ini_if_monitor",ini_if3);
    uvm_config_db#(virtual ini_if)::set(null,"uvm_test_top.vsqr.vseq.*","ini_if",ini_if3);
end

initial begin
    run_test();
end

dla_regif dla_regif1(
.clk(clk),
.rst(rst),
.regif_addr(ini_if3.regif_addr),
.regif_wdata(ini_if3.regif_wdata),
.regif_wen(ini_if3.regif_wen),
.regif_rdata(ini_if3.regif_rdata),
.regif_ren(ini_if3.regif_ren),
.regif_rvalid(ini_if3.regif_rvalid),
.stgr_enable_row(rsp_if2.stgr_enable_row),
.stgr_enable_col(rsp_if2.stgr_enable_col),
.stgr_buf_mask(rsp_if2.stgr_buf_mask),
.stgr_status(rsp_if2.stgr_status),
.start_mov_ddr2gb(ini_if3.start_mov_ddr2gb),
.start_mov_gb2lb(ini_if3.start_mov_gb2lb),
.start_comp_conv(ini_if3.start_comp_conv),
.start_comp_fc(ini_if3.start_comp_fc),
.start_comp_ape(ini_if3.start_comp_ape),
.start_comp_reshape(ini_if3.start_comp_reshape),
.complete_mov_ddr2gb(ini_if3.complete_mov_ddr2gb),
.complete_mov_gb2lb(ini_if3.complete_mov_gb2lb),
.complete_comp_conv(ini_if3.complete_comp_conv),
.complete_comp_fc(ini_if3.complete_comp_fc),
.complete_comp_ape(ini_if3.complete_comp_ape),
.complete_comp_reshape(ini_if3.complete_comp_reshape),
.complete_lpe(ini_if3.complete_lpe),
.stgr_ddr2gb_ddr_addr(rsp_if2.stgr_ddr2gb_ddr_addr),
.stgr_ddr2gb_ab_sel(rsp_if2.stgr_ddr2gb_ab_sel),
.stgr_ddr2gb_gb_addr(rsp_if2.stgr_ddr2gb_gb_addr),
.stgr_ddr2gb_gb_ramidx(rsp_if2.stgr_ddr2gb_gb_ramidx),
.stgr_ddr2gb_dir(rsp_if2.stgr_ddr2gb_dir),
.stgr_ddr2gb_len(rsp_if2.stgr_ddr2gb_len),
.stgr_gb2lb_gb_addr(rsp_if2.stgr_gb2lb_gb_addr),
.stgr_gb2lb_gb_skip(rsp_if2.stgr_gb2lb_gb_skip),
.stgr_gb2lb_lb_addr(rsp_if2.stgr_gb2lb_lb_addr),
.stgr_gb2lb_lb_skip(rsp_if2.stgr_gb2lb_lb_skip),
.stgr_gb2lb_len(rsp_if2.stgr_gb2lb_len),
.stgr_gb2lb_iter(rsp_if2.stgr_gb2lb_iter),
.stgr_ape_gb_addr_sa(rsp_if2.stgr_ape_gb_addr_sa),
.stgr_ape_gb_addr_sb(rsp_if2.stgr_ape_gb_addr_sb),
.stgr_ape_gb_addr_d(rsp_if2.stgr_ape_gb_addr_d),
.stgr_ape_len(rsp_if2.stgr_ape_len),
.stgr_ape_imm(rsp_if2.stgr_ape_imm),
.stgr_ape_mode(rsp_if2.stgr_ape_mode),
.stgr_conv_k_hori_len(rsp_if2.stgr_conv_k_hori_len),
.stgr_conv_k_vert_len(rsp_if2.stgr_conv_k_vert_len),
.stgr_conv_k_hori_delta(rsp_if2.stgr_conv_k_hori_delta),
.stgr_conv_k_vert_delta(rsp_if2.stgr_conv_k_vert_delta),
.stgr_conv_k_size_len(rsp_if2.stgr_conv_k_size_len),
.stgr_conv_wbload_cmd(rsp_if2.stgr_conv_wbload_cmd),
.stgr_conv_of_hori_len(rsp_if2.stgr_conv_of_hori_len),
.stgr_conv_of_vert_len(rsp_if2.stgr_conv_of_vert_len),
.stgr_conv_if_hori_len(rsp_if2.stgr_conv_if_hori_len),
.stgr_conv_if_vert_len(rsp_if2.stgr_conv_if_vert_len),
.stgr_conv_hori_stride(rsp_if2.stgr_conv_hori_stride),
.stgr_conv_vert_stride(rsp_if2.stgr_conv_vert_stride),
.stgr_conv_slice_max(rsp_if2.stgr_conv_slice_max),
.stgr_conv_pad_up(rsp_if2.stgr_conv_pad_up),
.stgr_conv_pad_down(rsp_if2.stgr_conv_pad_down),
.stgr_conv_pad_left(rsp_if2.stgr_conv_pad_left),
.stgr_conv_pad_right(rsp_if2.stgr_conv_pad_right),
.stgr_conv_pad_num(rsp_if2.stgr_conv_pad_num),
.stgr_conv_wait_lpe(rsp_if2.stgr_conv_wait_lpe),
.stgr_pool_enable(rsp_if2.stgr_pool_enable),
.stgr_pool_mode(rsp_if2.stgr_pool_mode),
.stgr_fc_addr(rsp_if2.stgr_fc_addr),
.stgr_fc_len(rsp_if2.stgr_fc_len),
.stgr_fc_wait_lpe(rsp_if2.stgr_fc_wait_lpe),
.stgr_reshape_addr(rsp_if2.stgr_reshape_addr),
.stgr_reshape_len(rsp_if2.stgr_reshape_len),
.stgr_reshape_iter(rsp_if2.stgr_reshape_iter),
.stgr_reshape_skip(rsp_if2.stgr_reshape_skip),
.stgr_reshape_wait_lpe(rsp_if2.stgr_reshape_wait_lpe),
.stgr_precision_ape_shift(rsp_if2.stgr_precision_ape_shift),
.stgr_precision_kpe_shift(rsp_if2.stgr_precision_kpe_shift),
.stgr_precision_ifmap(rsp_if2.stgr_precision_ifmap),
.stgr_precision_weight(rsp_if2.stgr_precision_weight),
.start_lpe(ini_if3.start_lpe),
.stgr_lpe_src_addr(rsp_if2.stgr_lpe_src_addr),
.stgr_lpe_src_len(rsp_if2.stgr_lpe_src_len),
.stgr_lpe_src_skip(rsp_if2.stgr_lpe_src_skip),
.stgr_lpe_src_iter(rsp_if2.stgr_lpe_src_iter),
.stgr_lpe_dest_addr(rsp_if2.stgr_lpe_dest_addr),
.stgr_lpe_dest_len(rsp_if2.stgr_lpe_dest_len),
.stgr_lpe_dest_skip(rsp_if2.stgr_lpe_dest_skip),
.stgr_lpe_dest_iter(rsp_if2.stgr_lpe_dest_iter),
.stgr_lpe_overlay(rsp_if2.stgr_lpe_overlay),
.stgr_lpe_relu(rsp_if2.stgr_lpe_relu),
.stgr_lpe_acc_bypass(rsp_if2.stgr_lpe_acc_bypass),
.stgr_lpe_sprmps(rsp_if2.stgr_lpe_sprmps),
.stgr_lpe_leap(rsp_if2.stgr_lpe_leap),
.stgr_wbload_ddr_addr(rsp_if2.stgr_wbload_ddr_addr),
.stgr_wbload_wb_cnt_default(rsp_if2.stgr_wbload_wb_cnt_default),
.stgr_wbload_kpe_cnt(rsp_if2.stgr_wbload_kpe_cnt),
.stgr_wbload_kpe_mask(rsp_if2.stgr_wbload_kpe_mask),
.stgr_wbload_kpe_act_num(rsp_if2.stgr_wbload_kpe_act_num),
.stgr_wbload_cpe_idx(rsp_if2.stgr_wbload_cpe_idx),
.stgr_wbload_cpe_cnt(rsp_if2.stgr_wbload_cpe_cnt),
.bif_gb_soc2gb_ab_sel(rsp_if2.bif_gb_soc2gb_ab_sel),
.bif_gb_soc2gb_addr(rsp_if2.bif_gb_soc2gb_addr),
.bif_gb_soc2gb_ram_sel(rsp_if2.bif_gb_soc2gb_ram_sel),
.bif_gb_soc2gb_wen(rsp_if2.bif_gb_soc2gb_wen),
.bif_gb_soc2gb_ren(rsp_if2.bif_gb_soc2gb_ren),
.bif_gb_soc2gb_wdata(rsp_if2.bif_gb_soc2gb_wdata),
.bif_gb_soc2gb_rdata(rsp_if2.bif_gb_soc2gb_rdata),
.interrupt(rsp_if2.interrupt)
);
endmodule
