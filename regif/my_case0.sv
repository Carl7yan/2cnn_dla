`ifndef MY_CASE0__SV
`define MY_CASE0__SV

class case0_sequence extends uvm_sequence#(reg_bus_item);

    reg_bus_item item0;
    uvm_status_e status;
    uvm_reg_data_t value;
    uvm_reg_data_t value1;
    uvm_reg_data_t value2;

    `uvm_object_utils(case0_sequence)
    `uvm_declare_p_sequencer(bus_sequencer)

    function new(string name = "case0_sequence");
        super.new(name);
    endfunction

    virtual task body();
        repeat(0) begin
            `uvm_do(item0)
        end
        repeat(1) begin
        //@(negedge top_tb.rst);
        value = 32'h0100_0012;
        p_sequencer.reg_model3.SOC2GB1.SOC2GB_CONFIG1.write(status,value,UVM_FRONTDOOR);
        p_sequencer.reg_model3.SOC2GB1.SOC2GB_CONFIG1.read(status,value2,UVM_BACKDOOR);
        `uvm_info("case0_sequence",$sformatf("the value of reg_model3.SOC2GB1.SOC2GB_CONFIG1 is %d ",value2),UVM_LOW)
        p_sequencer.reg_model3.SOC2GB1.SOC2GB_CONFIG1.read(status,value1,UVM_FRONTDOOR);
        `uvm_info("case0_sequence",$sformatf("value1 = %b",value1),UVM_LOW)
        end 
    endtask

endclass

class my_case0 extends base_test;//this case is first created compared my_case1. It not use the virtual sequence and virtual sequencer.

    reg_model reg_model2;

    `uvm_component_utils(my_case0)

    function new(string name = "my_case0", uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        reg_model2 = reg_model::type_id::create("reg_model2");//instantiate the register model.
        uvm_config_db#(reg_model)::set(this,"env","rgm",reg_model2);//pass the object to the handle in the my_env.
    endfunction

    virtual task main_phase(uvm_phase phase);
        case0_sequence seq1;
        phase.raise_objection(this);
        seq1 = case0_sequence::type_id::create("case0_sequence");//instance of the case0_sequence that is used to verify the register about SOC2GB.
        seq1.start(env.bus_agt1.sqr);//instance of case0_cequence start on the instance of bus_sequencer.
        phase.drop_objection(this);
    endtask
endclass
`endif  