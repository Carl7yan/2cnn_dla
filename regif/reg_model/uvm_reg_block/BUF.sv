`ifndef BUF__SV
`define BUF__SV

class BUF extends uvm_reg_block;

    rand BUF_MASKX BUF_MASKX1;
    rand BUF_MASK0 BUF_MASK01;
    rand BUF_MASK1 BUF_MASK11;
    rand BUF_MASK2 BUF_MASK21;
    rand BUF_MASK3 BUF_MASK31;
    rand BUF_MASK4 BUF_MASK41;
    rand BUF_MASK5 BUF_MASK51;
    rand BUF_MASK6 BUF_MASK61;
    rand BUF_MASK7 BUF_MASK71;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        BUF_MASKX1 = BUF_MASKX::type_id::create("BUF_MASKX1");
        BUF_MASK01 = BUF_MASK0::type_id::create("BUF_MASK01");
        BUF_MASK11 = BUF_MASK1::type_id::create("BUF_MASK11");
        BUF_MASK21 = BUF_MASK2::type_id::create("BUF_MASK21");
        BUF_MASK31 = BUF_MASK3::type_id::create("BUF_MASK31");
        BUF_MASK41 = BUF_MASK4::type_id::create("BUF_MASK41");
        BUF_MASK51 = BUF_MASK5::type_id::create("BUF_MASK51");
        BUF_MASK61 = BUF_MASK6::type_id::create("BUF_MASK61");
        BUF_MASK71 = BUF_MASK7::type_id::create("BUF_MASK71");
        BUF_MASKX1.configure(this,null,"reg_maskx");
        BUF_MASK01.configure(this,null,"reg_mask0");
        BUF_MASK11.configure(this,null,"reg_mask1");
        BUF_MASK21.configure(this,null,"reg_mask2");
        BUF_MASK31.configure(this,null,"reg_mask3");
        BUF_MASK41.configure(this,null,"reg_mask4");
        BUF_MASK51.configure(this,null,"reg_mask5");
        BUF_MASK61.configure(this,null,"reg_mask6");
        BUF_MASK71.configure(this,null,"reg_mask7");
        BUF_MASKX1.build();
        BUF_MASK01.build();
        BUF_MASK11.build();
        BUF_MASK21.build();
        BUF_MASK31.build();
        BUF_MASK41.build();
        BUF_MASK51.build();
        BUF_MASK61.build();
        BUF_MASK71.build();
        default_map.add_reg(BUF_MASKX1,20'h0_0000,"RW");
        default_map.add_reg(BUF_MASK01,20'h0_0001,"RW");
        default_map.add_reg(BUF_MASK11,20'h0_0002,"RW");
        default_map.add_reg(BUF_MASK21,20'h0_0003,"RW");
        default_map.add_reg(BUF_MASK31,20'h0_0004,"RW");
        default_map.add_reg(BUF_MASK41,20'h0_0005,"RW");
        default_map.add_reg(BUF_MASK51,20'h0_0006,"RW");
        default_map.add_reg(BUF_MASK61,20'h0_0007,"RW");
        default_map.add_reg(BUF_MASK71,20'h0_0008,"RW");
    endfunction

    `uvm_object_utils(BUF)

    function new(string name = "BUF");
        super.new(name,UVM_NO_COVERAGE);
    endfunction

endclass
`endif 