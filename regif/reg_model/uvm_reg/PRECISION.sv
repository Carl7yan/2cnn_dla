`ifndef PRECISION__SV
`define PRECISION__SV

class PRECISION extends uvm_reg;

    rand uvm_reg_field reg_precision_ape_shift;
    rand uvm_reg_field reg_precision_kpe_shift;
    rand uvm_reg_field reg_precision_ifmap_precision;
    rand uvm_reg_field reg_precision_weight_precision;

    covergroup value_cg;
        option.per_instance = 1;
        reg_precision_ape_shift_cp: coverpoint reg_precision_ape_shift.value[3 : 0];
        reg_precision_kpe_shift_cp: coverpoint reg_precision_kpe_shift.value[3 : 0];
        reg_precision_ifmap_precision_cp: coverpoint reg_precision_ifmap_precision.value[0 : 0];
        reg_precision_weight_precision_cp: coverpoint reg_precision_weight_precision.value[1 : 0];
    endgroup

    virtual function void build();
        reg_precision_ape_shift = uvm_reg_field::type_id::create("reg_precision_ape_shift");
        reg_precision_kpe_shift = uvm_reg_field::type_id::create("reg_precision_kpe_shift");
        reg_precision_ifmap_precision = uvm_reg_field::type_id::create("reg_precision_ifmap_precision");
        reg_precision_weight_precision = uvm_reg_field::type_id::create("reg_precision_weight_precision");
        reg_precision_ape_shift.configure(this,4,24,"RW",0,4'b0,1,1,0);
        reg_precision_kpe_shift.configure(this,4,16,"RW",0,4'b0,1,1,0);
        reg_precision_ifmap_precision.configure(this,1,8,"RW",0,1'b0,1,1,0);
        reg_precision_weight_precision.configure(this,2,0,"RW",0,2'b0,1,1,0);
    endfunction

    `uvm_object_utils(PRECISION)

    function new(string name = "PRECISION");
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