`ifndef INI_IF__SV
`define INI_IF__SV

interface ini_if(input bit clk, input bit rst);

     logic enable;
     logic [15 : 0] kpe_ifmap;
     logic [15 : 0] kpe_weight;
     //logic [15 : 0] kpe_sum;

     logic ctrl_kpe_src0_enable;
     logic ctrl_kpe_src1_enable;
     logic ctrl_kpe_mul_enable;
     logic ctrl_kpe_acc_enable;
     logic ctrl_kpe_acc_rst;

     logic ctrl_kpe_bypass;
     logic[3 : 0] stgr_precision_kpe_shift;
     precision_ifmap_e stgr_precision_ifmap;
     precision_weight_e stgr_precision_weight;

     clocking cb @(posedge clk);
        output enable;
        output kpe_ifmap;
        output kpe_weight;
        output ctrl_kpe_src0_enable;
        output ctrl_kpe_src1_enable;
        output ctrl_kpe_mul_enable;
        output ctrl_kpe_acc_enable;
        output ctrl_kpe_acc_rst;
        output ctrl_kpe_bypass;
        output stgr_precision_kpe_shift;
        output stgr_precision_ifmap;
        output stgr_precision_weight;
        //input  kpe_sum;
     endclocking
endinterface
`endif 

