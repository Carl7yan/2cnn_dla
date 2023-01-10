`ifndef DRIVER_CBS__SV
`define DRIVER_CBS__SV

virtual class driver_cbs;

  virtual task pre_tx(ref virtual ini_if  ii = null);

  endtask

  virtual task post_tx(ref virtual ini_if ii = null);

  endtask

endclass
`endif

