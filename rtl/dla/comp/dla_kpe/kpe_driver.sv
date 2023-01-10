`ifndef KPE_DRIVER__SV
`define KPE_DRIVER__SV

class kpe_driver extends uvm_driver#(uvm_sequence_item);

    virtual ini_if ini_if1;
    uvm_event e1;
    driver_cbs dc[$];

    uvm_analysis_port #(uvm_sequence_item) ap;

    transaction tr0;
    

    `uvm_component_utils(kpe_driver)

    function new(string name = "kpe_driver",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual ini_if)::get(this,"","ini_if1",ini_if1))
        `uvm_fatal("kpe_driver","virtual ini_if must be set!!!")

        ap = new("ap",this);
        e1 = uvm_event_pool::get_global("e1");
                
    endfunction

    task main_phase(uvm_phase phase);
        @(negedge ini_if1.rst);
        forever begin
            seq_item_port.get_next_item(req);
            if($cast(tr0,req)) begin
                
            end
            else  begin
                `uvm_error("kpe_driver","req to tr0 or tr1 is failed ")
            end//type checking
           // tr0.print();

           
           
           drive_one_pkt(tr0);
            ap.write(req);
            
            seq_item_port.item_done();
        end
    endtask

    task drive_one_pkt(transaction tr);
        `uvm_info("kpe_driver","enter the driver main_phase!",UVM_LOW)
        for(int i = 0; i < 18; i++) begin
            @(ini_if1.cb);
            
            if(i == 0) begin
                e1.trigger();//inform the kpe_mon to collect the output of kpe.
            end
            
            ini_if1.enable = tr.enable;
            ini_if1.kpe_ifmap = tr.kpe_ifmap[i];
            ini_if1.kpe_weight = tr.kpe_weight[i];
            ini_if1.ctrl_kpe_src0_enable = tr.ctrl_kpe_src0_enable[i];
            ini_if1.ctrl_kpe_src1_enable = tr.ctrl_kpe_src1_enable[i];
            ini_if1.ctrl_kpe_mul_enable = tr.ctrl_kpe_mul_enable[i];
            ini_if1.ctrl_kpe_acc_enable = tr.ctrl_kpe_acc_enable[i];
            ini_if1.ctrl_kpe_acc_rst = tr.ctrl_kpe_acc_rst[i];
            ini_if1.ctrl_kpe_bypass = tr.ctrl_kpe_bypass;
            ini_if1.stgr_precision_kpe_shift = tr.stgr_precision_kpe_shift;
            ini_if1.stgr_precision_ifmap = tr.stgr_precision_ifmap;
            ini_if1.stgr_precision_weight = tr.stgr_precision_weight;

            foreach(dc[i])
                dc[i].pre_tx(ini_if1);//utilize the callbacks to collect coverage.
        end
        
    endtask
endclass
`endif 