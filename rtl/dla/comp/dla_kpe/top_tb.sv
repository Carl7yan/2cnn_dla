import uvm_pkg::*;
import PKG_dla_typedef::*;
`include "ini_if.sv"
`include "mon_if.sv"
import testbench_pkg::*;

module top_tb;

    bit clk,rst;
    
    ini_if ini_if2(clk,rst);
    mon_if mon_if2(clk,rst);

    initial begin
        clk = 0;
        rst = 0;
        #2 rst = 1;
        #2 rst = 0;
    end
/*
    always@(posedge clk) begin
        $display("@%0t: kpe_sum actual = %h",$time,mon_if2.kpe_sum);
        $display("@%0t: dla_kpe1.kpe_sum = %h",$time,dla_kpe1.kpe_sum);
        $display("@%0t: dla_kpe1.preg_acc = %h",$time,dla_kpe1.preg_acc);
        $display("@%0t: dla_kpe1.preg_src_f = %h",$time,dla_kpe1.preg_src_f);
        $display("@%0t: dla_kpe1.preg_mul = %h",$time,dla_kpe1.preg_mul);
        $display("@%0t: dla_kpe1.kpe_mul_shift = %h",$time,dla_kpe1.kpe_mul_shift);
        $display("@%0t: dla_kpe1.stgr_precision_kpe_shift = %h",$time,dla_kpe1.stgr_precision_kpe_shift);
    end
*/

    /*
    always@(posedge clk) begin
        $display("@%0t: dla_kpe1.preg_acc = %x\n",$time,dla_kpe1.preg_acc);
        $display("@%0t: dla_kpe1.kpe_sum = %x\n",$time,dla_kpe1.kpe_sum);
    end
    */

    always #1 clk = ~clk;

    initial begin
        uvm_config_db#(virtual ini_if)::set(null,"uvm_test_top.env.i_agt.drv","ini_if1",ini_if2);
        uvm_config_db#(virtual mon_if)::set(null,"uvm_test_top.env.o_agt.mon","mon_if1",mon_if2);
    end

    initial begin
        //$fsdbDumpfile("tb.fsdb");
        $vcdpluson;
        //$fsdbDumpvars();
        //$fsdbDumpon();
    end

    initial begin
        run_test();
    end

    dla_kpe dla_kpe1(
    .clk(clk),
    .rst(rst),
    .enable(ini_if2.enable),
    .kpe_ifmap(ini_if2.kpe_ifmap),
    .kpe_weight(ini_if2.kpe_weight),
    .kpe_sum(mon_if2.kpe_sum),
    .ctrl_kpe_src0_enable(ini_if2.ctrl_kpe_src0_enable),
    .ctrl_kpe_src1_enable(ini_if2.ctrl_kpe_src1_enable),
    .ctrl_kpe_mul_enable(ini_if2.ctrl_kpe_mul_enable),
    .ctrl_kpe_acc_enable(ini_if2.ctrl_kpe_acc_enable),
    .ctrl_kpe_acc_rst(ini_if2.ctrl_kpe_acc_rst),
    .ctrl_kpe_bypass(ini_if2.ctrl_kpe_bypass),
    .stgr_precision_kpe_shift(ini_if2.stgr_precision_kpe_shift),
    .stgr_precision_ifmap(ini_if2.stgr_precision_ifmap),
    .stgr_precision_weight(ini_if2.stgr_precision_weight)
    );
endmodule
