`ifndef CONV__SV
`define CONV__SV

class CONV extends uvm_reg_block;

    rand CONV_K_SiZE0 CONV_K_SiZE01;
    rand CONV_K_SIZE1 CONV_K_SIZE11;
    rand CONV_K_LOAD CONV_K_LOAD1;
    rand CONV_FMAP CONV_FMAP1;
    rand CONV_STRIDE CONV_STRIDE1;
    rand CONV_PAD_SIZE CONV_PAD_SIZE1;
    rand CONV_PAD_NUM CONV_PAD_NUM1;
    
    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        CONV_K_SiZE01 = CONV_K_SiZE0::type_id::create("CONV_K_SiZE01");
        CONV_K_SIZE11 = CONV_K_SIZE1::type_id::create("CONV_K_SIZE11");
        CONV_K_LOAD1 = CONV_K_LOAD::type_id::create("CONV_K_LOAD1");
        CONV_FMAP1 = CONV_FMAP::type_id::create("CONV_FMAP1");
        CONV_STRIDE1 = CONV_STRIDE::type_id::create("CONV_STRIDE1");
        CONV_PAD_SIZE1 = CONV_PAD_SIZE::type_id::create("CONV_PAD_SIZE1");
        CONV_PAD_NUM1 = CONV_PAD_NUM::type_id::create("CONV_PAD_NUM1");
        CONV_K_SiZE01.configure(this,null,"reg_conv_k_size0");
        CONV_K_SIZE11.configure(this,null,"reg_conv_k_size1");
        CONV_K_LOAD1.configure(this,null,"reg_conv_k_load");
        CONV_FMAP1.configure(this,null,"reg_conv_fmap");
        CONV_STRIDE1.configure(this,null,"reg_conv_stride");
        CONV_PAD_SIZE1.configure(this,null,"reg_conv_pad_size");
        CONV_PAD_NUM1.configure(this,null,"reg_conv_pad_num");
        CONV_K_SiZE01.build();
        CONV_K_SIZE11.build();
        CONV_K_LOAD1.build();
        CONV_FMAP1.build();
        CONV_STRIDE1.build();
        CONV_PAD_SIZE1.build();
        CONV_PAD_NUM1.build();
        default_map.add_reg(CONV_K_SiZE01,20'h0_0000,"RW");
        default_map.add_reg(CONV_K_SIZE11,20'h0_0001,"RW");
        default_map.add_reg(CONV_K_LOAD1,20'h0_0002,"RW");
        default_map.add_reg(CONV_FMAP1,20'h0_0003,"RW");
        default_map.add_reg(CONV_STRIDE1,20'h0_0004,"RW");
        default_map.add_reg(CONV_PAD_SIZE1,20'h0_0005,"RW");
        default_map.add_reg(CONV_PAD_NUM1,20'h0_0006,"RW");
    endfunction

    `uvm_object_utils(CONV)

    function new(string name = "CONV");
        super.new(name,UVM_NO_COVERAGE);
    endfunction

endclass
`endif 
