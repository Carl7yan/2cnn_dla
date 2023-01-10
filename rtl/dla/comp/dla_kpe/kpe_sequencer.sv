`ifndef KPE_SEQUENCER__SV
`define KPE_SEQUENCER__SV

class kpe_sequencer extends uvm_sequencer#(uvm_sequence_item);

    `uvm_component_utils(kpe_sequencer)

    function new(string name = "kpe_sequencer",uvm_component parent = null);
        super.new(name,parent);
    endfunction

endclass
`endif 