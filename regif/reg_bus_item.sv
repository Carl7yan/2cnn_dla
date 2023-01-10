`ifndef REG_BUS_ITEM__SV
`define REG_BUS_ITEM__SV

class reg_bus_item extends uvm_sequence_item;

  rand logic [21 : 0] regif_addr;
  rand logic [31 : 0] regif_wdata;
  rand logic          regif_wen;
       logic [31 : 0] regif_rdata;
  rand logic          regif_ren;
       logic          regif_rvalid;

  function new(string name = "reg_bus_item");
    super.new(name);
  endfunction

  constraint c1{
      if(regif_wen == 1)
      (regif_ren == 0);
       else
      (regif_ren == 1);
  }

    constraint c2{
    if(regif_wen == 0)
        regif_wdata == 32'd0;
    }






    `uvm_object_utils_begin(reg_bus_item)
      `uvm_field_int(regif_addr,UVM_ALL_ON)
      `uvm_field_int(regif_wdata,UVM_ALL_ON)
      `uvm_field_int(regif_wen,UVM_ALL_ON)
      `uvm_field_int(regif_ren,UVM_ALL_ON)
      `uvm_field_int(regif_rvalid,UVM_ALL_ON)
      `uvm_field_int(regif_rdata,UVM_ALL_ON)
    `uvm_object_utils_end

endclass

`endif
