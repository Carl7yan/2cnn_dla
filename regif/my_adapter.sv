`ifndef MY_ADAPTER__SV
`define MY_ADAPTER__SV

class my_adapter extends uvm_reg_adapter;

    string tID = get_type_name();

    `uvm_object_utils(my_adapter)

    function new(string name = "my_adapter");
        super.new(name);
    endfunction

    function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
        reg_bus_item item2;
        item2 = new("item2");
        item2.regif_addr = rw.addr;
        item2.regif_wen = (rw.kind == UVM_WRITE) ? 1 : 0;
        item2.regif_ren = (rw.kind == UVM_READ) ? 1 : 0;
        if(item2.regif_wen == 1) 
            item2.regif_wdata = rw.data;
        else 
            item2.regif_wdata = 32'd0;

        return item2;
    endfunction

    function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
        reg_bus_item item3;
        if(!$cast(item3,bus_item)) begin
            `uvm_fatal(tID,"provided bus_item is one of the correct type. Expecting bus_transaction")
            return;
        end

        rw.kind = (item3.regif_ren == 1) ? UVM_READ : UVM_WRITE;
        rw.addr = item3.regif_addr;
        rw.byte_en = 'h3;
        rw.data = (item3.regif_ren == 1) ? item3.regif_rdata : item3.regif_wdata;
        rw.status = UVM_IS_OK;
    endfunction

endclass
`endif 