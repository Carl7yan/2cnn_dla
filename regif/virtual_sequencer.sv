`ifndef VIRTUAL_SEQUENCER__SV
`define VIRTUAL_SEQUENCER__SV

class virtual_sequencer extends uvm_sequencer;

    bus_sequencer bus_sqr1;

    `uvm_component_utils(virtual_sequencer)

    function new(string name = "virtual_sequencer",uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass
`endif 