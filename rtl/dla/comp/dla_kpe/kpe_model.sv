`ifndef KPE_MODEL__SV
`define KPE_MODEL__SV

import "DPI-C" function void kpe_algorithm(output logic [15 : 0] kpe_sum,
                                           input logic [15 : 0] kpe_ifmap[14],
                                           input logic [15 : 0] kpe_weight[14],
                                           input logic[3 : 0]  stgr_precision_kpe_shift,
                                           input logic stgr_precision_ifmap,
                                           input logic[1 : 0] stgr_precision_weight);


class kpe_model extends uvm_component;

    uvm_blocking_get_port #(uvm_sequence_item) gp;
    uvm_analysis_port #(uvm_sequence_item) ap;
    uvm_sequence_item usi;

    `uvm_component_utils(kpe_model)

    function new(string name = "kpe_model",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        gp = new("gp",this);
        ap = new("ap",this);
    endfunction

    task main_phase(uvm_phase phase);
        transaction tr;
        
        logic [15 : 0] kpe_ifmap[14];
        logic [15 : 0] kpe_weight[14];
        forever begin
            
            gp.get(usi);//get uvm_sequence_item from drv2mdl-FIFO(defined in the kpe_env)

            if($cast(tr,usi)) begin
                //there is nothing to do
            end else begin
                `uvm_error("","the item from kpe_driver is neither transaction type or simple_transaction type!")
            end  //these clause to ganrantee the uvm_sequence_item from kpe_driver is correct!


            `uvm_info("kpe_model","kpe_model have got one transaction from driver!!!",UVM_LOW)
            for(int i = 0; i < 14; ++i) begin
                kpe_ifmap[i] = tr.kpe_ifmap[i];
                kpe_weight[i] = tr.kpe_weight[i];
            end

            if(tr.enable == 1) begin 
                if(tr.ctrl_kpe_bypass == 1) begin
                    `uvm_info("kpe_model","ctrl_kpe_bypass is 1 in item!",UVM_LOW)
                    
                    for(int i = 0; i < 18; ++i) begin
                        if(i < 14) begin
                            tr.kpe_sum[i] = tr.kpe_ifmap[i];
                        end else begin
                            tr.kpe_sum[i] = tr.kpe_ifmap[13];
                        end
                    end 
                    
                end else begin
                    kpe_algorithm(tr.kpe_sum[17], kpe_ifmap, kpe_weight, tr.stgr_precision_kpe_shift, tr.stgr_precision_ifmap, tr.stgr_precision_weight);
                end
            end else begin
                foreach(tr.kpe_sum[i])
                    tr.kpe_sum[i] = 0;
            end 

            ap.write(usi);
            `uvm_info("kpe_model","kpe_model have sent one transaction to scoreboard!!!",UVM_LOW) 
        end
    endtask
endclass
`endif 