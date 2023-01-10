`ifndef GLB__SV
`define GLB__SV

class GLB extends uvm_reg_block;

    rand GLB_INTR GLB_INTR1;
    rand GLB_ENABLE_ROW GLB_ENABLE_ROW1;
    rand GLB_ENABLE_COL GLB_ENABLE_COL1;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        GLB_INTR1 = GLB_INTR::type_id::create("GLB_INTR1");
        GLB_ENABLE_ROW1 = GLB_ENABLE_ROW::type_id::create("GLB_ENABLE_ROW1");
        GLB_ENABLE_COL1 = GLB_ENABLE_COL::type_id::create("GLB_ENABLE_COL1");
        GLB_INTR1.configure(this,null,"reg_intr");
        GLB_ENABLE_ROW1.configure(this,null,"reg_enable_row");
        GLB_ENABLE_COL1.configure(this,null,"reg_enable_col");
        GLB_INTR1.build();
        GLB_ENABLE_ROW1.build();
        GLB_ENABLE_COL1.build();
        default_map.add_reg(GLB_INTR1,20'h0_0001,"RW");    
        default_map.add_reg(GLB_ENABLE_ROW1,20'h0_0002,"RW");
        default_map.add_reg(GLB_ENABLE_COL1,20'h0_0003,"RW");
    endfunction

    `uvm_object_utils(GLB)

    function new(string name = "CLB");
        super.new(name,UVM_NO_COVERAGE);
    endfunction

endclass
`endif 