`ifndef CONV_K_SiZE0__SV
`define CONV_K_SiZE0__SV

class CONV_K_SiZE0 extends uvm_reg;

    rand uvm_reg_field reg_conv_k_size0_hori_delta;
    rand uvm_reg_field reg_conv_k_size0_vert_delta;
    rand uvm_reg_field reg_conv_k_size0_hori_len;
    rand uvm_reg_field reg_conv_k_size0_vert_len;

    covergroup value_cg;
        option.per_instance = 1;
        reg_conv_k_size0_hori_delta_cp: coverpoint reg_conv_k_size0_hori_delta.value[5 : 0];
        reg_conv_k_size0_vert_delta_cp: coverpoint reg_conv_k_size0_vert_delta.value[5 : 0];
        reg_conv_k_size0_hori_len_cp: coverpoint reg_conv_k_size0_hori_len.value[5 : 0];
        reg_conv_k_size0_vert_len_cp: coverpoint reg_conv_k_size0_vert_len.value[5 : 0];
    endgroup

    virtual function void build();
        reg_conv_k_size0_hori_delta = uvm_reg_field::type_id::create("reg_conv_k_size0_hori_delta");
        reg_conv_k_size0_vert_delta = uvm_reg_field::type_id::create("reg_conv_k_size0_vert_delta");
        reg_conv_k_size0_hori_len = uvm_reg_field::type_id::create("reg_conv_k_size0_hori_len");
        reg_conv_k_size0_vert_len = uvm_reg_field::type_id::create("reg_conv_k_size0_vert_len");
        reg_conv_k_size0_hori_delta.configure(this,6,24,"RW",0,6'b0,1,1,0);
        reg_conv_k_size0_vert_delta.configure(this,6,16,"RW",0,6'b0,1,1,0);
        reg_conv_k_size0_hori_len.configure(this,6,8,"RW",0,6'b0,1,1,0);
        reg_conv_k_size0_vert_len.configure(this,6,0,"RW",0,6'b0,1,1,0);
    endfunction

    `uvm_object_utils(CONV_K_SiZE0)

    function new(string name = "CONV_K_SiZE0");
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