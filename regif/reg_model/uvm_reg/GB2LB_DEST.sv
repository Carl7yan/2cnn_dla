`ifndef GB2LB_DEST__SDV
`define GB2LB_DEST__SD

class GB2LB_DEST extends uvm_reg;

    rand uvm_reg_field reg_dest_skip;
    rand uvm_reg_field reg_dest_addr;

    covergroup value_cg;
        option.per_instance = 1;
        reg_dest_skip_cp: coverpoint reg_dest_skip.value[5 : 0];
        reg_dest_addr_cp: coverpoint reg_dest_addr.value[10 : 0];
    endgroup
    
    virtual function void build();
        reg_dest_skip = uvm_reg_field::type_id::create("reg_dest_skip");
        reg_dest_addr = uvm_reg_field::type_id::create("reg_dest_addr");
        reg_dest_skip.configure(this,6,16,"RW",0,6'b0,1,1,0);
        reg_dest_addr.configure(this,11,0,"RW",0,11'b0,1,1,0);
    endfunction

    `uvm_object_utils(GB2LB_DEST)

    function new(string name = "GB2LB_DEST");
        super.new(name,32,UVM_CVR_ALL);
        set_coverage(UVM_CVR_FIELD_VALS);
        if(has_coverage(UVM_CVR_FIELD_VALS)) begin
            value_cg = new();
        end
    endfunction

    function void sample(
                         uvm_reg_data_t data,
                         uvm_reg_data_t byte_en,
                         bit            is_read,
                         uvm_reg_map    map);
        super.sample(data,byte_en,is_read,map);
        sample_values();
    endfunction

    function void sample_values();
        super.sample_values();
        if(get_coverage(UVM_CVR_FIELD_VALS)) begin
            value_cg.sample();
        end
    endfunction

endclass
`endif 