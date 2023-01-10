`ifndef TESTBENCH_PKG__SV
`define TESTBENCH_PKG__SV

package testbench_pkg;   

    import uvm_pkg::*;
    import reg_model_pkg::*;
    `include "reg_bus_item.sv"    
    `include "initiator.sv"
    `include "ini_mon.sv"
    `include "bus_sequencer.sv"
    `include "bus_agent.sv"
    `include "my_scoreboard.sv"
    `include "my_adapter.sv"
    `include "my_env.sv"
    `include "virtual_sequencer.sv"    
    `include "base_test.sv"
    `include "case1_sequence.sv"
    `include "case2_sequence.sv"
    `include "case3_sequence.sv"
    `include "case4_sequence.sv"
    `include "my_case0.sv"
    `include "my_case1.sv"
    
endpackage
`endif 