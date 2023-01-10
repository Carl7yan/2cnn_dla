`ifndef GB2LB__SV
`define GB2LB__SV

class GB2LB extends uvm_reg_block;

    rand GB2LB_SRC0 GB2LB_SRC01;
    rand GB2LB_SRC1 GB2LB_SRC11;
    rand GB2LB_DEST GB2LB_DEST1;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        GB2LB_SRC01 = GB2LB_SRC0::type_id::create("GB2LB_SRC01");
        GB2LB_SRC11 = GB2LB_SRC1::type_id::create("GB2LB_SRC11");
        GB2LB_DEST1 = GB2LB_DEST::type_id::create("GB2LB_DEST1");
        GB2LB_SRC01.configure(this,null,"reg_src0");
        GB2LB_SRC11.configure(this,null,"reg_src1");
        GB2LB_DEST1.configure(this,null,"reg_dest");
        GB2LB_SRC01.build();
        GB2LB_SRC11.build();
        GB2LB_DEST1.build();
        default_map.add_reg(GB2LB_SRC01,20'h0_0001,"RW");
        default_map.add_reg(GB2LB_SRC11,20'h0_0002,"RW");
        default_map.add_reg(GB2LB_DEST1,20'h0_0003,"RW");
    endfunction

    `uvm_object_utils(GB2LB)

    function new(string name = "GB2LB");
        super.new(name,UVM_NO_COVERAGE);
    endfunction

endclass
`endif 