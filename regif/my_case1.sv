`ifndef MY_CASE1__SV
`define MY_CASE1__SV

class virtual_sequence extends uvm_sequence;

    `uvm_object_utils(virtual_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)

    function new(string name = "virtual_sequence");
        super.new(name);
    endfunction

    virtual task body();
        case1_sequence case1_sequence1;
        case2_sequence case2_sequence1;
        case3_sequence case3_sequence1;
        case4_sequence case4_sequence1;
        `uvm_do_on(case1_sequence1,p_sequencer.bus_sqr1)//if case2_sequence firstly start on the p_sequencer.bus_sqr1, we should pay attention to the rst signal effect.
        `uvm_do_on(case2_sequence1,p_sequencer.bus_sqr1)
        `uvm_do_on(case3_sequence1,p_sequencer.bus_sqr1)
        repeat(10)  begin
        `uvm_do_on(case4_sequence1,p_sequencer.bus_sqr1)
        end 

        uvm_top.print_topology();
    endtask
endclass

class my_case1 extends base_test;//this case is for trying to implement the virtual sequence and virtual sequencer.

    `uvm_component_utils(my_case1)

    reg_model  reg_model4;

    function new(string name = "my_case1",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        reg_model4 = reg_model::type_id::create("reg_model3");//instantiate the register model.
        uvm_config_db#(reg_model)::set(this,"env","rgm",reg_model4);//transfer the instance of register model to the handle in my_env.
    endfunction

    virtual task main_phase(uvm_phase phase);
        virtual_sequence vseq;
        phase.raise_objection(this);
        vseq = virtual_sequence::type_id::create("vseq");//virtual sequence is instantiated.
        vseq.start(vsqr);//instance of virtual sequence start on the instance of virtual sequencer.
        phase.drop_objection(this);
    endtask
endclass
`endif 
