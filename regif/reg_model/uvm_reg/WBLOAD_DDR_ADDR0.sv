`ifndef WBLOAD_DDR_ADDR0__SV
`define WBLOAD_DDR_ADDR0__SV

class WBLOAD_DDR_ADDR0 extends uvm_reg;

    rand uvm_reg_field reg_wbload_ddr_addr0_addr0;

    covergroup value_cg;
        option.per_instance = 1;
        reg_wbload_ddr_addr0_addr0_cp: coverpoint reg_wbload_ddr_addr0_addr0.value[31 : 0];
    endgroup

    virtual function void build();
        reg_wbload_ddr_addr0_addr0 = uvm_reg_field::type_id::create("reg_wbload_ddr_addr0_addr0");
        reg_wbload_ddr_addr0_addr0.configure(this,32,0,"RW",0,32'b0,1,1,0);
    endfunction

    `uvm_object_utils(WBLOAD_DDR_ADDR0)

    function new(string name = "WBLOAD_DDR_ADDR0");
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