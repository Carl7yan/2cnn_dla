`ifndef LPE_LEAP5__SV
`define LPE_LEAP5__SV

class LPE_LEAP5 extends uvm_reg;

    rand uvm_reg_field reg_lpe_leap5_leap11;
    rand uvm_reg_field reg_lpe_leap5_leap10;

    covergroup value_cg;
        option.per_instance = 1;
        reg_lpe_leap5_leap11_cp: coverpoint reg_lpe_leap5_leap11.value[12 : 0];
        reg_lpe_leap5_leap10_cp: coverpoint reg_lpe_leap5_leap10.value[12 : 0];
    endgroup

    virtual function void build();
        reg_lpe_leap5_leap11 = uvm_reg_field::type_id::create("reg_lpe_leap5_leap11");
        reg_lpe_leap5_leap10 = uvm_reg_field::type_id::create("reg_lpe_leap5_leap10");
        reg_lpe_leap5_leap11.configure(this,13,16,"RW",0,13'b0,1,1,0);
        reg_lpe_leap5_leap10.configure(this,13,0,"RW",0,13'b0,1,1,0);
    endfunction

    `uvm_object_utils(LPE_LEAP5)

    function new(string name = "LPE_LEAP5");
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