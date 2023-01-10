`ifndef FC__SV
`define FC__SV

class FC extends uvm_reg_block;

    rand FC_SRC FC_SRC1;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        FC_SRC1 = FC_SRC::type_id::create("FC_SRC1");
        FC_SRC1.configure(this,null,"reg_fc_src");
        FC_SRC1.build();
        default_map.add_reg(FC_SRC1,20'h0_0000,"RW");
    endfunction

    `uvm_object_utils(FC)

    function new(string name = "FC_SRC");
        super.new(name,UVM_NO_COVERAGE);
    endfunction
endclass
`endif 