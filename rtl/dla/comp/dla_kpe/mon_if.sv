`ifndef MON_IF__SV
`define MON_IF__SV

interface  mon_if(input bit clk,input bit rst);

    
    logic [15:0] kpe_sum;

    clocking ck @(posedge clk);
        input kpe_sum;
    endclocking 

endinterface
`endif 