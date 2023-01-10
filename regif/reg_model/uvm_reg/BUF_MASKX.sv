`ifndef BUF_MASKX__SV
`define BUF_MASKX__SV

class BUF_MASKX extends uvm_reg;

    rand uvm_reg_field reg_maskx_clone;
    rand uvm_reg_field reg_maskx_mask;

    covergroup value_cg;
        option.per_instance = 1;
        reg_maskx_clone_cp: coverpoint reg_maskx_clone.value[0 : 0];
        reg_maskx_mask_cp: coverpoint reg_maskx_mask.value[15 : 0];
    endgroup

    virtual function void build();
        reg_maskx_clone = uvm_reg_field::type_id::create("reg_maskx_clone");
        reg_maskx_mask = uvm_reg_field::type_id::create("reg_maskx_mask");
        reg_maskx_clone.configure(this,1,31,"RW",0,1'b0,1,1,0);
        reg_maskx_mask.configure(this,16,0,"RW",0,16'b0,1,1,0);
    endfunction

    `uvm_object_utils(BUF_MASKX)

    function new(string name = "BUF_MASKX");
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