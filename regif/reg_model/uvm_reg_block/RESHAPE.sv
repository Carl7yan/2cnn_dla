`ifndef RESHAPE__SV
`define RESHAPE__SV

class RESHAPE extends uvm_reg_block;

    rand RESHAPE_SRC0 RESHAPE_SRC01;
    rand RESHAPE_SRC1 RESHAPE_SRC11;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        RESHAPE_SRC01 = RESHAPE_SRC0::type_id::create("RESHAPE_SRC01");
        RESHAPE_SRC11 = RESHAPE_SRC1::type_id::create("RESHAPE_SRC11");
        RESHAPE_SRC01.configure(this,null,"reg_reshape_src0");
        RESHAPE_SRC11.configure(this,null,"reg_reshape_src1");
        RESHAPE_SRC01.build();
        RESHAPE_SRC11.build();
        default_map.add_reg(RESHAPE_SRC01,20'h0_0000,"RW");
        default_map.add_reg(RESHAPE_SRC11,20'h0_0001,"RW");
    endfunction

    `uvm_object_utils(RESHAPE)

    function new(string name = "RESHASPE");
        super.new(name,UVM_NO_COVERAGE);
    endfunction
endclass
`endif 