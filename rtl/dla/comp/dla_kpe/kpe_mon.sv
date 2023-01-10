`ifndef KPE_MON__SV
`define KPE_MON__SV

class kpe_mon extends uvm_monitor;

    virtual mon_if mon_if1;
    uvm_event e1;

    uvm_analysis_port #(uvm_sequence_item) ap;

    //uvm_blocking_get_export #(transaction) gp;

    `uvm_component_utils(kpe_mon)

    function new(string name = "kpe_mon", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual mon_if)::get(this,"","mon_if1",mon_if1))
        `uvm_fatal("kpe_mon","virtual mon_if must be set!!!")

        ap = new("ap",this);
        e1 = uvm_event_pool::get_global("e1");
        //gp = new("gp",this);
    endfunction

    task main_phase(uvm_phase phase);
        transaction tr;
        
        forever begin
            tr = new("tr");
            
            collect_one_pkt(tr);
        
            ap.write(tr);
            
        end

    endtask

    virtual task collect_one_pkt(transaction tr);
        `uvm_info("kpe_mon","begin to collect a packet!!!",UVM_LOW)
        //@(negedge mon_if1.ctrl_kpe_acc_enable);
        e1.wait_trigger();
        for(int j = 0; j < 18; ++j) begin
            @(mon_if1.ck);
            
            tr.kpe_sum[j] = mon_if1.kpe_sum;
        end       
        e1.reset();        
    endtask

endclass
`endif 
        