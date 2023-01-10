`ifndef COMP_CTRL_PRECISION__SV
`define COMP_CTRL_PRECISION__SV

class COMP_CTRL_PRECISION extends uvm_reg_block;

    rand COMP_CTRL COMP_CTRL1;
    rand PRECISION PRECISION1;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        COMP_CTRL1 = COMP_CTRL::type_id::create("COMP_CTRL1"); 
        PRECISION1 = PRECISION::type_id::create("PRECISION1");
        COMP_CTRL1.configure(this,null,"regif_comp.reg_comp_ctrl");
        PRECISION1.configure(this,null,"regif_glb.reg_precision");
        COMP_CTRL1.build();
        PRECISION1.build();
        default_map.add_reg(COMP_CTRL1,20'h0_0000,"RW");
        default_map.add_reg(PRECISION1,20'h0_0001,"RW");
    endfunction

    `uvm_object_utils(COMP_CTRL_PRECISION)

    function new(string name = "COMP_CTRL_PRECISION");
        super.new(name,UVM_NO_COVERAGE);
    endfunction
endclass
`endif 