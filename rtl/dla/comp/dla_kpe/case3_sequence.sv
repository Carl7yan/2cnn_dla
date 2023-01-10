`ifndef CASE3_SEQUENCE__SV
`define CASE3_SEQUENCE__SV

class case3_sequence extends uvm_sequence;

    transaction tr2;

    rand logic [3 : 0] kpe_shift;
    

    `uvm_object_utils(case3_sequence)
    `uvm_declare_p_sequencer(kpe_sequencer)

    function new(string name = "case3_sequence");
        super.new(name);
    endfunction

    virtual task body();
        repeat(10000) begin//enable == 0; precision == 16; kpe_shift == 12;
            `uvm_do_with(tr2,{tr2.enable == 1'b1;
                             tr2.kpe_ifmap[14] == 0;
                             tr2.kpe_weight[14] == 0;
                     
                             tr2.kpe_ifmap[15] == 0;
                             tr2.kpe_weight[15] == 0;
                     
                             tr2.kpe_ifmap[16] == 0;
                             tr2.kpe_weight[16] == 0;
                     
                             tr2.kpe_ifmap[17] == 0;
                             tr2.kpe_weight[17] == 0;
                             tr2.ctrl_kpe_bypass == 1'b0;
                             
                             tr2.stgr_precision_ifmap == 1'b0;
                             tr2.stgr_precision_weight == 2'b00;

                             ctrl_kpe_src0_enable[0] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[0] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[0] == 1'b0;
                             tr2.ctrl_kpe_acc_enable[0] == 1'b0;
                             tr2.ctrl_kpe_acc_rst[0] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[1] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[1] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[1] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[1] == 1'b0;
                             tr2.ctrl_kpe_acc_rst[1] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[2] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[2] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[2] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[2] == 1'b0;
                             tr2.ctrl_kpe_acc_rst[2] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[3] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[3] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[3] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[3] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[3] == 1'b1;
                     
                             tr2.ctrl_kpe_src0_enable[4] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[4] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[4] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[4] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[4] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[5] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[5] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[5] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[5] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[5] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[6] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[6] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[6] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[6] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[6] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[7] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[7] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[7] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[7] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[7] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[8] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[8] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[8] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[8] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[8] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[9] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[9] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[9] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[9] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[9] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[10] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[10] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[10] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[10] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[10] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[11] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[11] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[11] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[11] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[11] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[12] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[12] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[12] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[12] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[12] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[13] == 1'b1;
                             tr2.ctrl_kpe_src1_enable[13] == 1'b1;
                             tr2.ctrl_kpe_mul_enable[13] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[13] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[13] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[14] == 1'b0;
                             tr2.ctrl_kpe_src1_enable[14] == 1'b0;
                             tr2.ctrl_kpe_mul_enable[14] == 1'b1;
                             tr2.ctrl_kpe_acc_enable[14] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[14] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[15] == 1'b0;
                             tr2.ctrl_kpe_src1_enable[15] == 1'b0;
                             tr2.ctrl_kpe_mul_enable[15] == 1'b0;
                             tr2.ctrl_kpe_acc_enable[15] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[15] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[16] == 1'b0;
                             tr2.ctrl_kpe_src1_enable[16] == 1'b0;
                             tr2.ctrl_kpe_mul_enable[16] == 1'b0;
                             tr2.ctrl_kpe_acc_enable[16] == 1'b1;
                             tr2.ctrl_kpe_acc_rst[16] == 1'b0;
                     
                             tr2.ctrl_kpe_src0_enable[17] == 1'b0;
                             tr2.ctrl_kpe_src1_enable[17] == 1'b0;
                             tr2.ctrl_kpe_mul_enable[17] == 1'b0;
                             tr2.ctrl_kpe_acc_enable[17] == 1'b0;
                             tr2.ctrl_kpe_acc_rst[17] == 1'b0;
                     
                             tr2.stgr_precision_kpe_shift == kpe_shift;
                             

                             if(tr2.stgr_precision_weight == 1'b1)
                                foreach(tr2.kpe_weight[i])
                                {
                                    if(i < 14)
                                    {
                                        if(tr2.kpe_weight[i][7] == 1'b1)
                                        tr2.kpe_weight[i][15 : 8] == 8'hff;            
                                        else             
                                        tr2.kpe_weight[i] < 16'h0080;
                                    }
                                }
                             
                             })
        end

        

    endtask
endclass


`endif
