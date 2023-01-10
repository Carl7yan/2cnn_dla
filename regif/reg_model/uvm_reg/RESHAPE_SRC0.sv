`ifndef RESHAPE_SRC0__SV
`define RESHAPE_SRC0__SV

class RESHAPE_SRC0 extends uvm_reg;

    rand uvm_reg_field reg_reshape_src0_length;
    rand uvm_reg_field reg_reshape_src0_addr;

    covergroup value_cg;
        option.per_instance = 1;
        reg_reshape_src0_length_cp: coverpoint reg_reshape_src0_length.value[10 : 0];
        reg_reshape_src0_addr_cp: coverpoint reg_reshape_src0_addr.value[10 : 0];
    endgroup

    virtual function void build();
        reg_reshape_src0_length = uvm_reg_field::type_id::create("reg_reshape_src0_length");
        reg_reshape_src0_addr = uvm_reg_field::type_id::create("reg_reshape_src0_addr");
        reg_reshape_src0_length.configure(this,11,16,"RW",0,11'b0,1,1,0);
        reg_reshape_src0_addr.configure(this,11,0,"RW",0,11'b0,1,1,0);
    endfunction

    `uvm_object_utils(RESHAPE_SRC0)

    function new(string name = "RESHAPE_SRC0");
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