`ifndef CONV_K_SIZE1__SV
`define CONV_K_SIZE1__SV

class CONV_K_SIZE1 extends uvm_reg;

    rand uvm_reg_field reg_conv_k_size1_size_len;
    rand uvm_reg_field reg_conv_k_size1_slice_max;

    covergroup value_cg;
        option.per_instance = 1;
        reg_conv_k_size1_size_len_cp: coverpoint reg_conv_k_size1_size_len.value[11 : 0];
        reg_conv_k_size1_slice_max_cp: coverpoint reg_conv_k_size1_slice_max.value[3 : 0];
    endgroup

    virtual function void build();
        reg_conv_k_size1_size_len = uvm_reg_field::type_id::create("reg_conv_k_size1_size_len");
        reg_conv_k_size1_slice_max = uvm_reg_field::type_id::create("reg_conv_k_size1_slice_max");
        reg_conv_k_size1_size_len.configure(this,12,16,"RW",0,12'b0,1,1,0);
        reg_conv_k_size1_slice_max.configure(this,4,0,"RW",0,4'b0,1,1,0);
    endfunction

    `uvm_object_utils(CONV_K_SIZE1)

    function new(string name = "CONV_K_SIZE1");
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