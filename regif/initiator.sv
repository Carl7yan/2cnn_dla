`ifndef INITIATOR__SV
`define INITIATOR__SV

class initiator extends uvm_driver#(reg_bus_item);

    virtual ini_if ini_if1;
    uvm_analysis_port #(reg_bus_item) ap;

    `uvm_component_utils(initiator)

    function new(string name = "initiator", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual ini_if)::get(this,"","ini_if_initiator",ini_if1))
        `uvm_fatal("initiator","virtual ini_if must be set!!!")

        ap = new("ap",this);
    endfunction

    task main_phase(uvm_phase phase);

        reg_bus_item tmp1,tmp2;
        forever begin
            seq_item_port.get_next_item(req);
            drive_one_item(req);
            //void'($cast(tmp2,req.clone()));
            //if(req.regif_wen == 1) begin  ap.write(req); end 

            `uvm_info("initiator",$sformatf("@%0t",$time),UVM_LOW)
            
            req.print();
            tmp1 = new("tmp1");
            tmp1.set_id_info(req);
            seq_item_port.item_done(tmp1);
        end
    endtask

    virtual task drive_one_item(reg_bus_item it);
        `uvm_info("initiator","begin to drive one!",UVM_LOW)
        if((it.regif_wen == 1) && (it.regif_ren == 0)) begin
            ini_if1.regif_wen = it.regif_wen;
            ini_if1.regif_wdata = it.regif_wdata;
            ini_if1.regif_addr = it.regif_addr;
            ini_if1.regif_ren = it.regif_ren;
            @(ini_if1.cb);
        end
        else 
        if((it.regif_wen == 0) && (it.regif_ren == 1)) begin
            ini_if1.regif_ren = it.regif_ren;
            ini_if1.regif_addr = it.regif_addr;
            ini_if1.regif_wen = it.regif_wen;
            ini_if1.regif_wdata = it.regif_wdata;
            @(ini_if1.cb);
          //fork 
            forever  begin
                if((ini_if1.cb.regif_rvalid == 1) && (ini_if1.cb.regif_ren == 1)) begin 
                    it.regif_rdata = ini_if1.cb.regif_rdata;
                    it.regif_rvalid = ini_if1.cb.regif_rvalid;
                    break;
                end
                @(ini_if1.cb);
            end    
          //join_none;
            
        end
        else begin
            @(ini_if1.cb);
        end
    endtask
endclass
`endif
