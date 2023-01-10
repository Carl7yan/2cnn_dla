`ifndef BUS_AGENT__SV
`define BUS_AGENT__SV

class bus_agent extends uvm_agent;

    ini_mon ini_mon1;
    initiator ini_drv1;
    bus_sequencer sqr;

    uvm_analysis_port  #(reg_bus_item) ap1;
    uvm_analysis_port  #(reg_bus_item) ap2;

    `uvm_component_utils(bus_agent) 

    function new(string name = "bus_agent", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ini_mon1 = ini_mon::type_id::create("ini_mon1",this);
        if(is_active == UVM_ACTIVE) begin
            ini_drv1 = initiator::type_id::create("ini_drv1",this);
            sqr = bus_sequencer::type_id::create("sqr",this);
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        if(is_active == UVM_ACTIVE) begin
        ini_drv1.seq_item_port.connect(sqr.seq_item_export);
        end 
        ap1 = ini_drv1.ap;
        ap2 = ini_mon1.ap;
    endfunction

endclass
`endif