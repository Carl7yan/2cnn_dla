`ifndef LPE_LEAP7__SV
`define LPE_LEAP7__SV

class LPE_LEAP7 extends uvm_reg;

    rand uvm_reg_field reg_lpe_leap7_leap14;

    covergroup value_cg;
        option.per_instance = 1;
        reg_lpe_leap7_leap14_cp: coverpoint reg_lpe_leap7_leap14.value[12 : 0];
    endgroup

    virtual function void build();
        reg_lpe_leap7_leap14 = uvm_reg_field::type_id::create("reg_lpe_leap7_leap14");
        reg_lpe_leap7_leap14.configure(this,13,0,"RW",0,13'b0,1,1,0);
    endfunction

    `uvm_object_utils(LPE_LEAP7)

    function new(string name = "LPE_LEAP7");
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