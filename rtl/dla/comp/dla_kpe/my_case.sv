`ifndef MY_CASE__SV
`define MY_CASE__SV

class virtual_sequence extends uvm_sequence;

    case0_sequence  seq0;
    case1_sequence  seq1;
    case2_sequence  seq2;
    case3_sequence  seq3;
    case4_sequence  seq4;

    `uvm_object_utils(virtual_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)

    function new(string name = "virtual_sequence");
        super.new(name);
    endfunction

    virtual task body();
      fork
          begin
            `uvm_do_on(seq0,p_sequencer.sqr1)

            `uvm_do_on(seq1,p_sequencer.sqr1)

            for(int i = 8; i >= 0; --i) begin
              `uvm_do_on_with(seq2,p_sequencer.sqr1,{seq2.kpe_shift == i;})
            end 

            for(int i = 12; i >= 0; --i ) begin
              `uvm_do_on_with(seq3,p_sequencer.sqr1,{seq3.kpe_shift == i;})
            end

            `uvm_do_on_with(seq4,p_sequencer.sqr1,{seq4.kpe_shift == 4;})          

              uvm_top.print_topology();
          end
      join
    endtask

endclass


class my_case extends base_test;

    `uvm_component_utils(my_case)

    function new(string name = "my_case",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    task main_phase(uvm_phase phase);
        virtual_sequence v_seq;
        driver_cbs_coverage dcc;

        dcc = new();
        env.i_agt.drv.dc.push_back(dcc);

        phase.raise_objection(this);
        `uvm_info("my_case","begin my_case main_phase!",UVM_LOW)
        v_seq = virtual_sequence::type_id::create("v_seq");
        fork
            v_seq.start(v_sqr);
        join
        phase.drop_objection(this);
    endtask
endclass
`endif 


