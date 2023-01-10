`ifndef BASE_TEST__SV
`define BASE_TEST__SV

class base_test extends uvm_test;
my_env env;
virtual_sequencer vsqr;


`uvm_component_utils(base_test)

function new(string name = "base_test", uvm_component parent = null);
   super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
env = my_env::type_id::create("env",this);
vsqr = virtual_sequencer::type_id::create("vsqr",this);
endfunction

function void connect_phase(uvm_phase phase);
   vsqr.bus_sqr1 = env.bus_agt1.sqr;
endfunction

function void report_phase(uvm_phase phase);
uvm_report_server server;

int err_num;
super.report_phase(phase);
server = get_report_server();
err_num = server.get_severity_count(UVM_ERROR);

if(err_num != 0) begin
    $display("TEST CASE FAILED!");
 end else begin
   $display("TEST CASE PASSED");
 end  

endfunction 

endclass
`endif 