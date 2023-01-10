`ifndef SOC2GB_CONFIG__SV
`define SOC2GB_CONFIG__SV

class SOC2GB_CONFIG extends uvm_reg;

    rand uvm_reg_field reg_soc2gb_config_sign_ext;
    rand uvm_reg_field reg_soc2gb_config_addr_mode;

    covergroup value_cg;
        option.per_instance = 1;
        reg_soc2gb_config_sign_ext_cp: coverpoint reg_soc2gb_config_sign_ext.value[0 : 0];
        reg_soc2gb_config_addr_mode_cp: coverpoint reg_soc2gb_config_addr_mode.value[1 : 0];
    endgroup

    virtual function void build();
        reg_soc2gb_config_sign_ext = uvm_reg_field::type_id::create("reg_soc2gb_config_sign_ext");
        reg_soc2gb_config_addr_mode = uvm_reg_field::type_id::create("reg_soc2gb_config_addr_mode");
        reg_soc2gb_config_sign_ext.configure(this,1,4,"RW",0,1'b0,1,1,0);
        reg_soc2gb_config_addr_mode.configure(this,2,0,"RW",0,2'b0,1,1,0);
    endfunction

    `uvm_object_utils(SOC2GB_CONFIG)

    function new(string name = "SOC2GB_CONFIG");
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