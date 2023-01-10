`ifndef BUF_MASK1__SV
`define BUF_MASK1__SV

class BUF_MASK1 extends uvm_reg;

    rand uvm_reg_field reg_mask1_mask3;
    rand uvm_reg_field reg_mask1_mask2;

    covergroup value_cg;
        option.per_instance = 1;
        reg_mask1_mask3_cp: coverpoint reg_mask1_mask3.value[15 : 0];
        reg_mask1_mask2_cp: coverpoint reg_mask1_mask2.value[15 : 0];
    endgroup

    virtual function void build();
        reg_mask1_mask3 = uvm_reg_field::type_id::create("reg_mask1_mask3");
        reg_mask1_mask2 = uvm_reg_field::type_id::create("reg_mask1_mask2");
        reg_mask1_mask3.configure(this,16,16,"RW",0,16'b0,1,1,0);
        reg_mask1_mask2.configure(this,16,0,"RW",0,16'b0,1,1,0);
    endfunction

    `uvm_object_utils(BUF_MASK1)

    function new(string name = "BUF_MASK1");
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