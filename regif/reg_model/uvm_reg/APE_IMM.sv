`ifndef  APE_IMM__SV
`define APE_IMM__SV

class APE_IMM extends uvm_reg;

    rand uvm_reg_field reg_imm_imm;

    covergroup value_cg;
        option.per_instance = 1;
        reg_imm_imm_cp: coverpoint reg_imm_imm.value[15 : 0];
    endgroup

    virtual function void build();
        reg_imm_imm = uvm_reg_field::type_id::create("reg_imm_imm");
        reg_imm_imm.configure(this,16,0,"RW",0,16'b0,1,1,0);
    endfunction

    `uvm_object_utils(APE_IMM)

    function new(string name = "APE_IMM");
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