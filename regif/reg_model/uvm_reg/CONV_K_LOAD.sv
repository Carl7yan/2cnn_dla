`ifndef CONV_K_LOAD__SV
`define CONV_K_LOAD__SV

class CONV_K_LOAD extends uvm_reg;

    rand uvm_reg_field reg_conv_k_load_wbload_cmd;

    covergroup value_cg;
        option.per_instance = 1;
        reg_conv_k_load_wbload_cmd_cp: coverpoint reg_conv_k_load_wbload_cmd.value[1 : 0];
    endgroup

    virtual function void build();
        reg_conv_k_load_wbload_cmd = uvm_reg_field::type_id::create("reg_conv_k_load_wbload_cmd");
        reg_conv_k_load_wbload_cmd.configure(this,2,0,"RW",0,2'b0,1,1,0);
    endfunction

    `uvm_object_utils(CONV_K_LOAD)

    function new(string name = "CONV_K_LOAD");
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