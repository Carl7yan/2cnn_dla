`ifndef SOC2GB__SV
`define SOC2GB__SV

class SOC2GB extends uvm_reg_block;

    rand SOC2GB_CONFIG SOC2GB_CONFIG1;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        SOC2GB_CONFIG1 = SOC2GB_CONFIG::type_id::create("SOC2GB_CONFIG1");
        SOC2GB_CONFIG1.configure(this,null,"reg_soc2gb_config");
        SOC2GB_CONFIG1.build();
        //SOC2GB_CONFIG1.add_hdl_path_slice("sign_ext",4,1);
        //SOC2GB_CONFIG1.add_hdl_path_slice("addr_mode",0,2);
        default_map.add_reg(SOC2GB_CONFIG1,20'h0_0000,"RW");
    endfunction

    `uvm_object_utils(SOC2GB)

    function new(string name = "SOC2GB_CONFIG");
        super.new(name,UVM_NO_COVERAGE);
    endfunction
endclass
`endif 