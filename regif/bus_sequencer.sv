`ifndef BUS_SEQUENCER__SV
`define BUS_SEQUENCER__SV

class bus_sequencer extends uvm_sequencer#(reg_bus_item);
    reg_model reg_model3;
    `uvm_component_utils(bus_sequencer)

    function new(string name = "bus_sequencer", uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass
`endif

