`ifndef LPE_LEAP2__SV
`define LPE_LEAP2__SV

class LPE_LEAP2 extends uvm_reg;

    rand uvm_reg_field reg_lpe_leap2_leap5;
    rand uvm_reg_field reg_lpe_leap2_leap4;

    covergroup value_cg;
        option.per_instance = 1;
        reg_lpe_leap2_leap5_cp: coverpoint reg_lpe_leap2_leap5.value[12 : 0];
        reg_lpe_leap2_leap4_cp: coverpoint reg_lpe_leap2_leap4.value[12 : 0];
    endgroup

    virtual function void build();
        reg_lpe_leap2_leap5 = uvm_reg_field::type_id::create("reg_lpe_leap2_leap5");
        reg_lpe_leap2_leap4 = uvm_reg_field::type_id::create("reg_lpe_leap2_leap4");
        reg_lpe_leap2_leap5.configure(this,13,16,"RW",0,13'b0,1,1,0);
        reg_lpe_leap2_leap4.configure(this,13,0,"RW",0,13'b0,1,1,0);
    endfunction

    `uvm_object_utils(LPE_LEAP2)

    function new(string name = "LPE_LEAP2");
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