`ifndef IN_AGT__SV
`define IN_AGT__SV

class in_agt extends uvm_agent;

    kpe_driver drv;
    kpe_sequencer sqr;

    uvm_analysis_port #(uvm_sequence_item) ap;

    `uvm_component_utils(in_agt)

    function new(string name = "in_agt",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(is_active == UVM_ACTIVE) begin
            drv = kpe_driver::type_id::create("drv",this);
            sqr = kpe_sequencer::type_id::create("sqr",this);
        end
    endfunction

    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(sqr.seq_item_export);
        ap = drv.ap;
    endfunction

endclass
`endif 


