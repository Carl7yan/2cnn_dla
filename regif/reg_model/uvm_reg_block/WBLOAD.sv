`ifndef WBLOAD__SV
`define WBLOAD__SV

class WBLOAD extends uvm_reg_block;

    rand WBLOAD_DDR_ADDR0 WBLOAD_DDR_ADDR01;
    rand WBLOAD_DDR_ADDR1 WBLOAD_DDR_ADDR11;
    rand WBLOAD_KERNEL WBLOAD_KERNEL1;
    rand WBLOAD_CHANNEL WBLOAD_CHANNEL1;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        WBLOAD_DDR_ADDR01 = WBLOAD_DDR_ADDR0::type_id::create("WBLOAD_DDR_ADDR01");
        WBLOAD_DDR_ADDR11 = WBLOAD_DDR_ADDR1::type_id::create("WBLOAD_DDR_ADDR11");
        WBLOAD_KERNEL1 = WBLOAD_KERNEL::type_id::create("WBLOAD_KERNEL1");
        WBLOAD_CHANNEL1 = WBLOAD_CHANNEL::type_id::create("WBLOAD_CHANNEL1");
        WBLOAD_DDR_ADDR01.configure(this,null,"reg_wbload_ddr_addr0");
        WBLOAD_DDR_ADDR11.configure(this,null,"reg_wbload_ddr_addr1");
        WBLOAD_KERNEL1.configure(this,null,"reg_wbload_kernel");
        WBLOAD_CHANNEL1.configure(this,null,"reg_wbload_channel");
        WBLOAD_DDR_ADDR01.build();
        WBLOAD_DDR_ADDR11.build();
        WBLOAD_KERNEL1.build();
        WBLOAD_CHANNEL1.build();
        default_map.add_reg(WBLOAD_DDR_ADDR01,20'h0_0000,"RW");
        default_map.add_reg(WBLOAD_DDR_ADDR11,20'h0_0001,"RW");
        default_map.add_reg(WBLOAD_KERNEL1,20'h0_0002,"RW");
        default_map.add_reg(WBLOAD_CHANNEL1,20'h0_0003,"RW");
    endfunction

    `uvm_object_utils(WBLOAD)

    function new(string name = "WBLOAD");
        super.new(name,UVM_NO_COVERAGE);
    endfunction

endclass
`endif 