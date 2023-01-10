`ifndef OUT_AGT__SV
`define OUT_AGT__SV

class out_agt extends uvm_agent;

    kpe_mon mon;
    uvm_analysis_port #(uvm_sequence_item) ap;

    `uvm_component_utils(out_agt)
    
    function new(string name = "out_agt",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
            mon = kpe_mon::type_id::create("mon",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        ap = mon.ap;
    endfunction

endclass
`endif 
