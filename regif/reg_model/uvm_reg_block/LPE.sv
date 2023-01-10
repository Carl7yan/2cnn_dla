`ifndef LPE__SV
`define LPE__SV

class LPE extends uvm_reg_block;

    rand LPE_SRC0 LPE_SRC01;
    rand LPE_SRC1 LPE_SRC11;
    rand LPE_DEST0 LPE_DEST01;
    rand LPE_DEST1 LPE_DEST11;
    rand LPE_MODE LPE_MODE1;
    rand LPE_LEAP0 LPE_LEAP01;
    rand LPE_LEAP1 LPE_LEAP11;
    rand LPE_LEAP2 LPE_LEAP21;
    rand LPE_LEAP3 LPE_LEAP31;
    rand LPE_LEAP4 LPE_LEAP41;
    rand LPE_LEAP5 LPE_LEAP51;
    rand LPE_LEAP6 LPE_LEAP61;
    rand LPE_LEAP7 LPE_LEAP71;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        LPE_SRC01 = LPE_SRC0::type_id::create("LPE_SRC01");
        LPE_SRC11 = LPE_SRC1::type_id::create("LPE_SRC11");
        LPE_DEST01 = LPE_DEST0::type_id::create("LPE_DEST01");
        LPE_DEST11 = LPE_DEST1::type_id::create("LPE_DEST11");
        LPE_MODE1= LPE_MODE::type_id::create("LPE_MODE1");
        LPE_LEAP01 = LPE_LEAP0::type_id::create("LPE_LEAP01");
        LPE_LEAP11 = LPE_LEAP1::type_id::create("LPE_LEAP11");
        LPE_LEAP21 = LPE_LEAP2::type_id::create("LPE_LEAP21");
        LPE_LEAP31 = LPE_LEAP3::type_id::create("LPE_LEAP31");
        LPE_LEAP41 = LPE_LEAP4::type_id::create("LPE_LEAP41");
        LPE_LEAP51 = LPE_LEAP5::type_id::create("LPE_LEAP51");
        LPE_LEAP61 = LPE_LEAP6::type_id::create("LPE_LEAP61");
        LPE_LEAP71 = LPE_LEAP7::type_id::create("LPE_LEAP71");
        
        LPE_SRC01.configure(this,null,"reg_lpe_src0");
        LPE_SRC11.configure(this,null,"reg_lpe_src1");
        LPE_DEST01.configure(this,null,"reg_lpe_dest0");
        LPE_DEST11.configure(this,null,"reg_lpe_dest1");
        LPE_MODE1.configure(this,null,"reg_lpe_mode");
        LPE_LEAP01.configure(this,null,"reg_lpe_leap0");
        LPE_LEAP11.configure(this,null,"reg_lpe_leap1");
        LPE_LEAP21.configure(this,null,"reg_lpe_leap2");
        LPE_LEAP31.configure(this,null,"reg_lpe_leap3");
        LPE_LEAP41.configure(this,null,"reg_lpe_leap4");
        LPE_LEAP51.configure(this,null,"reg_lpe_leap5");
        LPE_LEAP61.configure(this,null,"reg_lpe_leap6");
        LPE_LEAP71.configure(this,null,"reg_lpe_leap7");
        LPE_SRC01.build();
        LPE_SRC11.build();
        LPE_DEST01.build();
        LPE_DEST11.build();
        LPE_MODE1.build();
        LPE_LEAP01.build();
        LPE_LEAP11.build();
        LPE_LEAP21.build();
        LPE_LEAP31.build();
        LPE_LEAP41.build();
        LPE_LEAP51.build();
        LPE_LEAP61.build();
        LPE_LEAP71.build();
        default_map.add_reg(LPE_SRC01,20'h0_0000,"RW");
        default_map.add_reg(LPE_SRC11,20'h0_0001,"RW");
        default_map.add_reg(LPE_DEST01,20'h0_0002,"RW");
        default_map.add_reg(LPE_DEST11,20'h0_0003,"RW");
        default_map.add_reg(LPE_MODE1,20'h0_0004,"RW");
        default_map.add_reg(LPE_LEAP01,20'h0_0005,"RW");
        default_map.add_reg(LPE_LEAP11,20'h0_0006,"RW");
        default_map.add_reg(LPE_LEAP21,20'h0_0007,"RW");
        default_map.add_reg(LPE_LEAP31,20'h0_0008,"RW");
        default_map.add_reg(LPE_LEAP41,20'h0_0009,"RW");
        default_map.add_reg(LPE_LEAP51,20'h0_000a,"RW");
        default_map.add_reg(LPE_LEAP61,20'h0_000b,"RW");
        default_map.add_reg(LPE_LEAP71,20'h0_000c,"RW");
    endfunction
    
    `uvm_object_utils(LPE)

    function new(string name = "LPE");
        super.new(name,UVM_NO_COVERAGE);
    endfunction

endclass
`endif 