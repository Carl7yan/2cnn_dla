`ifndef INI_MON__SV
`define INI_MON__SV

class ini_mon extends uvm_monitor;

    virtual ini_if ini_if2;

    uvm_analysis_port #(reg_bus_item) ap;

    `uvm_component_utils(ini_mon)

    function new(string name = "ini_mon", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual ini_if)::get(this,"","ini_if_monitor",ini_if2))
            `uvm_fatal("ini_mon","virtual interface must be set!")

        ap = new("ap",this);
    endfunction



    virtual task main_phase(uvm_phase phase);
        forever begin
        reg_bus_item it;
        it = new("it");
        collect_one_item(it);
        //ap.write(it);
        end
    endtask

    virtual task collect_one_item(ref reg_bus_item it);
        `uvm_info("ini_mon","begin to collect one!",UVM_LOW)

        forever begin

          if((ini_if2.cb.regif_rvalid == 1) && (ini_if2.cb.regif_ren == 1)) begin
              it.regif_rdata = ini_if2.cb.regif_rdata;
              it.regif_addr = ini_if2.cb.regif_addr;
              it.regif_ren = ini_if2.cb.regif_ren;
              it.regif_rvalid = ini_if2.cb.regif_rvalid;
              @(ini_if2.cb);
              break;
          end

          @(ini_if2.cb);
        end

    endtask
endclass
`endif
