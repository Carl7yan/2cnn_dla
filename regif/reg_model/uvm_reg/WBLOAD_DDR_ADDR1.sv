`ifndef WBLOAD_DDR_ADDR1__SV
`define WBLOAD_DDR_ADDR1__SV

class WBLOAD_DDR_ADDR1 extends uvm_reg;

    rand uvm_reg_field reg_wbload_ddr_addr1_addr1;

    covergroup value_cg;
        option.per_instance = 1;
        reg_wbload_ddr_addr1_addr1_cp: coverpoint reg_wbload_ddr_addr1_addr1.value[21 : 0];
    endgroup

    virtual function void build();
        reg_wbload_ddr_addr1_addr1 = uvm_reg_field::type_id::create("reg_wbload_ddr_addr1_addr1");
        reg_wbload_ddr_addr1_addr1.configure(this,22,0,"RW",0,22'b0,1,1,0);
    endfunction

    `uvm_object_utils(WBLOAD_DDR_ADDR1)

    function new(string name = "WBLOAD_DDR_ADDR1");
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