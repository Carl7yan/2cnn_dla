`ifndef MY_SCOREBOARD__SV
`define MY_SCOREBOARD__SV

class my_scoreboard extends uvm_scoreboard;

`uvm_component_utils(my_scoreboard)

uvm_blocking_get_port #(reg_bus_item) exp_port;
uvm_blocking_get_port #(reg_bus_item) act_port;

reg_bus_item exp_queue[$];

function new(string name = "my_scoreboard", uvm_component parent = null);
super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
exp_port = new("exp_port",this);
act_port = new("act_port",this);
endfunction

virtual task main_phase(uvm_phase phase);
  reg_bus_item  exp, act, tmp;
  bit result;
  super.main_phase(phase);
  `uvm_info("my_scoreboard","begin !!!",UVM_LOW)
  fork
    while(1) begin
        exp_port.get(exp);
        `uvm_info("my_scoreboard","have get one expect transaction!",UVM_LOW)
        exp_queue.push_back(exp);
    end
    while(1)  begin
        act_port.get(act);
        if(exp_queue.size() > 0) begin
            tmp = exp_queue.pop_front();
            result = act.compare(tmp);
            if(result) begin
                `uvm_info("my_scoreboard","compare successfully!!!",UVM_LOW)
            end else begin
                `uvm_error("my_scoreboard","compare failed!")
                $display("the expect pkt is");
                tmp.print();
                $display("the actual pkt is");
                act.print();
            end
        end else begin
            `uvm_error("my_scoreboard","receive from DUT, while expect queue is empty")
            $display("the unexpected pkt is");
            act.print();
        end
    end
  join
endtask
endclass
`endif 