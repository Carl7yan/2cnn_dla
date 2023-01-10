`ifndef APE__SV
`define APE__SV

class APE extends uvm_reg_block;

    rand APE_CTRL APE_CTRL1;
    rand APE_SRC APE_SRC1;
    rand APE_DEST APE_DEST1;
    rand APE_IMM APE_IMM1;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        APE_CTRL1 = APE_CTRL::type_id::create("APE_CTRL1");
        APE_SRC1 = APE_SRC::type_id::create("APE_SRC1");
        APE_DEST1 = APE_DEST::type_id::create("APE_DEST1");
        APE_IMM1 = APE_IMM::type_id::create("APE_IMM1");
        APE_CTRL1.configure(this,null,"reg_ctrl");
        APE_SRC1.configure(this,null,"reg_src");
        APE_DEST1.configure(this,null,"reg_dest");
        APE_IMM1.configure(this,null,"reg_imm");
        APE_CTRL1.build();
        APE_SRC1.build();
        APE_DEST1.build();
        APE_IMM1.build();
        default_map.add_reg(APE_CTRL1,20'h0_0000,"RW");
        default_map.add_reg(APE_SRC1,20'h0_0001,"RW");
        default_map.add_reg(APE_DEST1,20'h0_0002,"RW");
        default_map.add_reg(APE_IMM1,20'h0_0003,"RW");
    endfunction

    `uvm_object_utils(APE)

    function new(string name = "APE");
        super.new(name,UVM_NO_COVERAGE);
    endfunction
endclass
`endif  