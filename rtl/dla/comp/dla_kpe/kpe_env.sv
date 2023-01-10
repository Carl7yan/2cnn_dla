`ifndef KPE_ENV__SV
`define KPE_ENV__SV

class kpe_env extends uvm_env;

    in_agt i_agt;
    out_agt o_agt;

    kpe_model mdl;
    kpe_scoreboard scb;

    uvm_tlm_analysis_fifo #(uvm_sequence_item) drv2mdl;
    uvm_tlm_analysis_fifo #(uvm_sequence_item) mdl2scb;
    uvm_tlm_analysis_fifo #(uvm_sequence_item) mon2scb;

    `uvm_component_utils(kpe_env)

    function new(string name = "kpe_env",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i_agt = in_agt::type_id::create("i_agt",this);
        i_agt.is_active = UVM_ACTIVE;
        o_agt = out_agt::type_id::create("o_agt",this);
        mdl = kpe_model::type_id::create("mdl",this);
        scb = kpe_scoreboard::type_id::create("scb",this);

        drv2mdl = new("drv2mdl",this);
        mdl2scb = new("mdl2scb",this);
        mon2scb = new("mon2scb",this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        i_agt.ap.connect(drv2mdl.analysis_export);
        mdl.gp.connect(drv2mdl.blocking_get_export);
        mdl.ap.connect(mdl2scb.analysis_export);
        scb.exp_p.connect(mdl2scb.blocking_get_export);
        o_agt.ap.connect(mon2scb.analysis_export);
        scb.act_p.connect(mon2scb.blocking_get_export);
    endfunction

endclass
`endif
