`ifndef MY_ENV__SV
`define MY_ENV__SV

class my_env extends uvm_env;

    bus_agent bus_agt1;
    my_scoreboard scb;
    reg_model reg_model1;
    my_adapter my_adapter1;

    uvm_tlm_analysis_fifo #(reg_bus_item) drv2scb;
    uvm_tlm_analysis_fifo #(reg_bus_item) inimon2scb;

    `uvm_component_utils(my_env)

    function new(string name = "my_env", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        bus_agt1 = bus_agent::type_id::create("bus_agt1",this);
        bus_agt1.is_active = UVM_ACTIVE;
        scb = my_scoreboard::type_id::create("scb",this);
        if(!uvm_config_db#(reg_model)::get(this,"","rgm",reg_model1)) begin
            `uvm_info("my_env","no top-down rgm handle is assigned!",UVM_LOW)
            reg_model1 = reg_model::type_id::create("reg_model1");
            `uvm_info("my_env","create new rgm instance locally !",UVM_LOW)
            
        end

        reg_model1.configure(null,"top_tb.dla_regif1");//set the root hdl path
        reg_model1.build();
        reg_model1.lock_model();
        reg_model1.reset();
        //reg_model1.set_hdl_path_root("");

        my_adapter1 = my_adapter::type_id::create("my_adapter1");

        drv2scb = new("drv2scb",this);
        inimon2scb = new("inimon2scb",this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        bus_agt1.ap1.connect(drv2scb.analysis_export);
        scb.exp_port.connect(drv2scb.blocking_get_export);
        bus_agt1.ap2.connect(inimon2scb.analysis_export);
        scb.act_port.connect(inimon2scb.blocking_get_export);
        bus_agt1.sqr.reg_model3 = reg_model1;
        `uvm_info("my_env",$sformatf("reg_model default_map = %s",reg_model1.default_map.get_full_name()),UVM_LOW)
        reg_model1.default_map.set_sequencer(bus_agt1.sqr,my_adapter1);
        reg_model1.default_map.set_auto_predict(1);
    endfunction

endclass
`endif


