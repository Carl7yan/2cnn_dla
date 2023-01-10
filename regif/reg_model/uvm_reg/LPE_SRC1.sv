`ifndef LPE_SRC1__SV
`define LPE_SRC1__SV

class LPE_SRC1 extends uvm_reg;

    rand uvm_reg_field reg_lpe_src1_iter;
    rand uvm_reg_field reg_lpe_src1_skip;

    covergroup value_cg;
        option.per_instance = 1;
        reg_lpe_src1_iter_cp: coverpoint reg_lpe_src1_iter.value[12 : 0];
        reg_lpe_src1_skip_cp: coverpoint reg_lpe_src1_skip.value[12 : 0];
    endgroup

    virtual function void build();
        reg_lpe_src1_iter = uvm_reg_field::type_id::create("reg_lpe_src1_iter");
        reg_lpe_src1_skip = uvm_reg_field::type_id::create("reg_lpe_src1_skip");
        reg_lpe_src1_iter.configure(this,13,16,"RW",0,13'b0,1,1,0);
        reg_lpe_src1_skip.configure(this,13,0,"RW",0,13'b0,1,1,0);
    endfunction

    `uvm_object_utils(LPE_SRC1)

    function new(string name = "LPE_SRC1");
        super.new(name,32,UVM_CVR_ALL);
        set_coverage(UVM_CVR_FIELD_VALS);
        if(has_coverage(UVM_CVR_FIELD_VALS)) begin
            value_cg = new();
        end
    endfunction

    function void sample(
                         uvm_reg_data_t data,
                         uvm_reg_data_t byte_en,
                         bit            is_read,
                         uvm_reg_map    map);
        super.sample(data,byte_en,is_read,map);
        sample_values();
    endfunction

    function void sample_values();
        super.sample_values();
        if(get_coverage(UVM_CVR_FIELD_VALS)) begin
            value_cg.sample();
        end
    endfunction
endclass
`endif 
