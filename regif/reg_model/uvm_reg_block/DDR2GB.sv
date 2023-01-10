`ifndef DDR2GB__SV
`define DDR2GB__SV

class DDR2GB extends uvm_reg_block;

    rand DDR2GB_CTRL DDR2GB_CTRL1;
    rand DDR2GB_DDR_ADDR0 DDR2GB_DDR_ADDR01;
    rand DDR2GB_DDR_ADDR1 DDR2GB_DDR_ADDR11;
    rand DDR2GB_GB_ADDR DDR2GB_GB_ADDR1;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);
        DDR2GB_CTRL1 = DDR2GB_CTRL::type_id::create("DDR2GB_CTRL1");
        DDR2GB_DDR_ADDR01 = DDR2GB_DDR_ADDR0::type_id::create("DDR2GB_DDR_ADDR01");
        DDR2GB_DDR_ADDR11 = DDR2GB_DDR_ADDR1::type_id::create("DDR2GB_DDR_ADDR11");
        DDR2GB_GB_ADDR1 = DDR2GB_GB_ADDR::type_id::create("DDR2GB_GB_ADDR1");
        DDR2GB_CTRL1.configure(this,null,"reg_ddr2gb_ctrl");
        DDR2GB_DDR_ADDR01.configure(this,null,"reg_ddr2gb_addr0");
        DDR2GB_DDR_ADDR11.configure(this,null,"reg_ddr2gb_addr1");
        DDR2GB_GB_ADDR1.configure(this,null,"reg_ddr2gb_gbaddr");
        DDR2GB_CTRL1.build();
        DDR2GB_DDR_ADDR01.build();
        DDR2GB_DDR_ADDR11.build();
        DDR2GB_GB_ADDR1.build();
        default_map.add_reg(DDR2GB_CTRL1,20'h0_0010,"RW");
        default_map.add_reg(DDR2GB_DDR_ADDR01,20'h0_0011,"RW");
        default_map.add_reg(DDR2GB_DDR_ADDR11,20'h0_0012,"RW");
        default_map.add_reg(DDR2GB_GB_ADDR1,20'h0_0013,"RW");
    endfunction

    `uvm_object_utils(DDR2GB)

    function new(string name = "DDR2GB");
        super.new(name,UVM_NO_COVERAGE);
    endfunction

endclass
`endif 