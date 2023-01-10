`ifndef CONV_PAD_NUM__SV
`define CONV_PAD_NUM__SV

class CONV_PAD_NUM extends uvm_reg;

    rand uvm_reg_field reg_conv_pad_num_pad_num;

    covergroup value_cg;
        option.per_instance = 1;
        reg_conv_pad_num_pad_num_cp: coverpoint reg_conv_pad_num_pad_num.value[15 : 0];
    endgroup

    virtual function void build();
        reg_conv_pad_num_pad_num = uvm_reg_field::type_id::create("reg_conv_pad_num_pad_num");
        reg_conv_pad_num_pad_num.configure(this,16,0,"RW",0,16'b0,1,1,0);
    endfunction

    `uvm_object_utils(CONV_PAD_NUM)

    function new(string name = "CONV_PAD_NUM");
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