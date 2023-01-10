// ----------------------- dla - deep learning accelerator
// ----------------------- kpe - kernel processing element
`ifndef TRANSACTION__SV
`define TRANSACTION__SV

class transaction extends uvm_sequence_item;

    rand logic enable;                        // enable the kpe module, if 0 -> output is 0
    rand logic [15 : 0] kpe_ifmap[18];        // input feature map (18 pixel, 16 data)
    rand logic [15 : 0] kpe_weight[18];       //
    logic [15 : 0] kpe_sum[18];               // output

    rand logic ctrl_kpe_src0_enable[18];
    rand logic ctrl_kpe_src1_enable[18];
    rand logic ctrl_kpe_mul_enable[18];
    rand logic ctrl_kpe_acc_enable[18];
    rand logic ctrl_kpe_acc_rst[18];

    rand logic ctrl_kpe_bypass;               // if 0 -> output is input
    rand logic[3 : 0]       stgr_precision_kpe_shift;
    rand precision_ifmap_e  stgr_precision_ifmap;
    rand precision_weight_e stgr_precision_weight;

    function new(string name = "transaction");
        super.new(name);
    endfunction

    `uvm_object_utils_begin(transaction)
        `uvm_field_int(enable,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_sarray_int(kpe_ifmap,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_sarray_int(kpe_weight,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_sarray_int(kpe_sum,UVM_ALL_ON)
        `uvm_field_sarray_int(ctrl_kpe_src0_enable,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_sarray_int(ctrl_kpe_src1_enable,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_sarray_int(ctrl_kpe_mul_enable,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_sarray_int(ctrl_kpe_acc_enable,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_sarray_int(ctrl_kpe_acc_rst,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_int(ctrl_kpe_bypass,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_int(stgr_precision_kpe_shift,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_enum(precision_ifmap_e,stgr_precision_ifmap,UVM_ALL_ON | UVM_NOCOMPARE)
        `uvm_field_enum(precision_weight_e,stgr_precision_weight,UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_object_utils_end


    /*
    constraint c1{
        enable == 1'b1;
        kpe_ifmap[14] == 0;
        kpe_weight[14] == 0;

        kpe_ifmap[15] == 0;
        kpe_weight[15] == 0;

        kpe_ifmap[16] == 0;
        kpe_weight[16] == 0;

        kpe_ifmap[17] == 0;
        kpe_weight[17] == 0;

    }
    */

    /*
    constraint c2{
        ctrl_kpe_src0_enable == '{{14{1'b1}},{4{1'b0}}};
        ctrl_kpe_src1_enable == '{{14{1}},{4{0}}};
        ctrl_kpe_mul_enable == '{0,{14{1}},{3{0}}};
        ctrl_kpe_acc_enable == '{{3{0}},{14{1}},0};
        ctrl_kpe_acc_rst == '{0,0,0,1,default:0};
    }*/

    /*
    constraint c2{
        ctrl_kpe_src0_enable[0] == 1'b1;
        ctrl_kpe_src1_enable[0] == 1'b1;
        ctrl_kpe_mul_enable[0] == 1'b0;
        ctrl_kpe_acc_enable[0] == 1'b0;
        ctrl_kpe_acc_rst[0] == 1'b0;

        ctrl_kpe_src0_enable[1] == 1'b1;
        ctrl_kpe_src1_enable[1] == 1'b1;
        ctrl_kpe_mul_enable[1] == 1'b1;
        ctrl_kpe_acc_enable[1] == 1'b0;
        ctrl_kpe_acc_rst[1] == 1'b0;

        ctrl_kpe_src0_enable[2] == 1'b1;
        ctrl_kpe_src1_enable[2] == 1'b1;
        ctrl_kpe_mul_enable[2] == 1'b1;
        ctrl_kpe_acc_enable[2] == 1'b0;
        ctrl_kpe_acc_rst[2] == 1'b0;

        ctrl_kpe_src0_enable[3] == 1'b1;
        ctrl_kpe_src1_enable[3] == 1'b1;
        ctrl_kpe_mul_enable[3] == 1'b1;
        ctrl_kpe_acc_enable[3] == 1'b1;
        ctrl_kpe_acc_rst[3] == 1'b1;

        ctrl_kpe_src0_enable[4] == 1'b1;
        ctrl_kpe_src1_enable[4] == 1'b1;
        ctrl_kpe_mul_enable[4] == 1'b1;
        ctrl_kpe_acc_enable[4] == 1'b1;
        ctrl_kpe_acc_rst[4] == 1'b0;

        ctrl_kpe_src0_enable[5] == 1'b1;
        ctrl_kpe_src1_enable[5] == 1'b1;
        ctrl_kpe_mul_enable[5] == 1'b1;
        ctrl_kpe_acc_enable[5] == 1'b1;
        ctrl_kpe_acc_rst[5] == 1'b0;

        ctrl_kpe_src0_enable[6] == 1'b1;
        ctrl_kpe_src1_enable[6] == 1'b1;
        ctrl_kpe_mul_enable[6] == 1'b1;
        ctrl_kpe_acc_enable[6] == 1'b1;
        ctrl_kpe_acc_rst[6] == 1'b0;

        ctrl_kpe_src0_enable[7] == 1'b1;
        ctrl_kpe_src1_enable[7] == 1'b1;
        ctrl_kpe_mul_enable[7] == 1'b1;
        ctrl_kpe_acc_enable[7] == 1'b1;
        ctrl_kpe_acc_rst[7] == 1'b0;

        ctrl_kpe_src0_enable[8] == 1'b1;
        ctrl_kpe_src1_enable[8] == 1'b1;
        ctrl_kpe_mul_enable[8] == 1'b1;
        ctrl_kpe_acc_enable[8] == 1'b1;
        ctrl_kpe_acc_rst[8] == 1'b0;

        ctrl_kpe_src0_enable[9] == 1'b1;
        ctrl_kpe_src1_enable[9] == 1'b1;
        ctrl_kpe_mul_enable[9] == 1'b1;
        ctrl_kpe_acc_enable[9] == 1'b1;
        ctrl_kpe_acc_rst[9] == 1'b0;

        ctrl_kpe_src0_enable[10] == 1'b1;
        ctrl_kpe_src1_enable[10] == 1'b1;
        ctrl_kpe_mul_enable[10] == 1'b1;
        ctrl_kpe_acc_enable[10] == 1'b1;
        ctrl_kpe_acc_rst[10] == 1'b0;

        ctrl_kpe_src0_enable[11] == 1'b1;
        ctrl_kpe_src1_enable[11] == 1'b1;
        ctrl_kpe_mul_enable[11] == 1'b1;
        ctrl_kpe_acc_enable[11] == 1'b1;
        ctrl_kpe_acc_rst[11] == 1'b0;

        ctrl_kpe_src0_enable[12] == 1'b1;
        ctrl_kpe_src1_enable[12] == 1'b1;
        ctrl_kpe_mul_enable[12] == 1'b1;
        ctrl_kpe_acc_enable[12] == 1'b1;
        ctrl_kpe_acc_rst[12] == 1'b0;

        ctrl_kpe_src0_enable[13] == 1'b1;
        ctrl_kpe_src1_enable[13] == 1'b1;
        ctrl_kpe_mul_enable[13] == 1'b1;
        ctrl_kpe_acc_enable[13] == 1'b1;
        ctrl_kpe_acc_rst[13] == 1'b0;

        ctrl_kpe_src0_enable[14] == 1'b0;
        ctrl_kpe_src1_enable[14] == 1'b0;
        ctrl_kpe_mul_enable[14] == 1'b1;
        ctrl_kpe_acc_enable[14] == 1'b1;
        ctrl_kpe_acc_rst[14] == 1'b0;

        ctrl_kpe_src0_enable[15] == 1'b0;
        ctrl_kpe_src1_enable[15] == 1'b0;
        ctrl_kpe_mul_enable[15] == 1'b0;
        ctrl_kpe_acc_enable[15] == 1'b1;
        ctrl_kpe_acc_rst[15] == 1'b0;

        ctrl_kpe_src0_enable[16] == 1'b0;
        ctrl_kpe_src1_enable[16] == 1'b0;
        ctrl_kpe_mul_enable[16] == 1'b0;
        ctrl_kpe_acc_enable[16] == 1'b1;
        ctrl_kpe_acc_rst[16] == 1'b0;

        ctrl_kpe_src0_enable[17] == 1'b0;
        ctrl_kpe_src1_enable[17] == 1'b0;
        ctrl_kpe_mul_enable[17] == 1'b0;
        ctrl_kpe_acc_enable[17] == 1'b0;
        ctrl_kpe_acc_rst[17] == 1'b0;
    }



    constraint c3{
        ctrl_kpe_bypass == 1'b0;
        stgr_precision_ifmap == 1'b1;
        stgr_precision_weight == 2'b01;
    }

    constraint c4{
        if(stgr_precision_ifmap == 1'b0)
        stgr_precision_kpe_shift == 4'd12;
        if(stgr_precision_ifmap == 1'b1)
        stgr_precision_kpe_shift == 4'd8;
    }
    */



    /*constraint c5{
        foreach(kpe_ifmap[i])
        {
            if(i < 14)
            kpe_ifmap[i] <= 16'h0100;
        }
        foreach(kpe_weight[i])
        {
            if(i < 14)
            kpe_weight[i] <= 16'h0100;
        }
    }*/


    /*
    constraint c5{
        if(stgr_precision_weight == 1'b1)
        foreach(kpe_weight[i])
        {
            if(i < 14)
            {
                if(kpe_weight[i][7] == 1'b1)
                kpe_weight[i][15 : 8] == 8'hff;
                else
                kpe_weight[i] < 16'h0080;
            }
        }
    }
    */







endclass
`endif



