`ifndef CASE0_SEQUENCE__SV
`define CASE0_SEQUENCE__SV

class case0_sequence extends uvm_sequence;

    transaction tr2;
    

    `uvm_object_utils(case0_sequence)
    `uvm_declare_p_sequencer(kpe_sequencer)

    function new(string name = "case0_sequence");
        super.new(name);
    endfunction

    virtual task body();
                
        repeat(100) begin
            `uvm_do_with(tr2,{tr2.enable == 1'b0;})
        end
        
    endtask
endclass
`endif 
/*
enable == 1;
precision == 16;
kpe_shift 
*/
