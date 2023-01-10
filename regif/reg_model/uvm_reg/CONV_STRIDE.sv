`ifndef CONV_STRIDE__SV
`define CONV_STRIDE__SV

class CONV_STRIDE extends uvm_reg;

    rand uvm_reg_field reg_conv_stride_hori_stride;
    rand uvm_reg_field reg_conv_stride_vert_stride;

    covergroup value_cg;
        option.per_instance = 1;
        reg_conv_stride_hori_stride_cp: coverpoint reg_conv_stride_hori_stride.value[5 : 0];
        reg_conv_stride_vert_stride_cp: coverpoint reg_conv_stride_vert_stride.value[5 : 0];
    endgroup

    virtual function void build();
        reg_conv_stride_hori_stride = uvm_reg_field::type_id::create("reg_conv_stride_hori_stride");
        reg_conv_stride_vert_stride = uvm_reg_field::type_id::create("reg_conv_stride_vert_stride");
        reg_conv_stride_hori_stride.configure(this,6,8,"RW",0,6'b0,1,1,0);
        reg_conv_stride_vert_stride.configure(this,6,0,"RW",0,6'b0,1,1,0);
    endfunction

    `uvm_object_utils(CONV_STRIDE)

    function new(string name = "CONV_STRIDE");
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