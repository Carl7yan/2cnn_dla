`ifndef KPE_SCOREBOARD__SV
`define KPE_SCOREBOARD__SV

class kpe_scoreboard extends uvm_scoreboard;

    transaction expectq[$];

    uvm_blocking_get_port #(uvm_sequence_item) exp_p;
    uvm_blocking_get_port #(uvm_sequence_item) act_p;

    `uvm_component_utils(kpe_scoreboard)

    function new(string name = "kpe_scoreboard",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        exp_p = new("exp_p",this);
        act_p = new("act_p",this);
    endfunction

    task main_phase(uvm_phase phase);
        uvm_sequence_item exp1,act1;
        transaction exp,act,tmp;
        bit result;

        super.main_phase(phase);
        fork
            forever begin
                exp_p.get(exp1);

                if($cast(exp,exp1)) begin
                    expectq.push_back(exp);
                end else begin
                    `uvm_info("kpe_scoreboard","the process of $cast(exp,exp1) have error! ",UVM_LOW)
                end
                
            end//receive items from kpe_model.

            forever begin
                act_p.get(act1);

                if($cast(act,act1)) begin
                    //nothing to do
                end else begin
                    `uvm_info("kpe_scoreboard","the process of $cast(act,act1) have error",UVM_LOW)
                end//receive items from kpe_mon.

                if(expectq.size() > 0) begin
                    tmp = expectq.pop_front();
                    if(act.ctrl_kpe_bypass == 1) begin
                        result = tmp.compare(act);
                    end else begin
                        result = act.kpe_sum[17] == tmp.kpe_sum[17];
                    end
                    if(result == 1) begin
                        `uvm_info("kpe_scoreboard","compare successfully!",UVM_LOW)
                    end
                    else begin
                        `uvm_error("kpe_scoreboard","compare failed!")
                        $display("the expect pkt is:");
                        tmp.print();
                        $display("the actual pkt is");
                        act.print();
                    end
                end
                else begin
                    `uvm_error("kpe_scoreboard","Received  from DUT, while expect queue is empty!")
                    $display("the actual pkt is:");
                    act.print();
                end
            end
        join
    endtask

endclass
`endif 
