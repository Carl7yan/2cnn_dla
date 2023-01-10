`ifndef BUF_MASK3__SV
`define BUF_MASK3__SV

class BUF_MASK3 extends uvm_reg;

    rand uvm_reg_field reg_mask3_mask7;
    rand uvm_reg_field reg_mask3_mask6;

    covergroup value_cg;
        option.per_instance = 1;
        reg_mask3_mask7_cp: coverpoint reg_mask3_mask7.value[15 : 0];
        reg_mask3_mask6_cp: coverpoint reg_mask3_mask6.value[15 : 0];
    endgroup

    virtual function void build();
        reg_mask3_mask7 = uvm_reg_field::type_id::create("reg_mask3_mask7");
        reg_mask3_mask6 = uvm_reg_field::type_id::create("reg_mask3_mask6");
        reg_mask3_mask7.configure(this,16,16,"RW",0,16'b0,1,1,0);
        reg_mask3_mask6.configure(this,16,0,"RW",0,16'b0,1,1,0);
    endfunction

    `uvm_object_utils(BUF_MASK3)

    function new(string name = "BUF_MASK3");
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