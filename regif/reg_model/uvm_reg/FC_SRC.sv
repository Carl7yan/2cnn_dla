`ifndef FC_SRC__SV
`define FC_SRC__SV

class FC_SRC extends uvm_reg;

    rand uvm_reg_field reg_fc_src_length;
    rand uvm_reg_field reg_fc_src_addr;

    covergroup value_cg;
        option.per_instance = 1;
        reg_fc_src_length_cp: coverpoint reg_fc_src_length.value[10 : 0];
        reg_fc_src_addr_cp: coverpoint reg_fc_src_addr.value[10 : 0];
    endgroup

    virtual function void build();
         reg_fc_src_length = uvm_reg_field::type_id::create("reg_fc_src_length");
         reg_fc_src_addr = uvm_reg_field::type_id::create("reg_fc_src_addr");
         reg_fc_src_length.configure(this,11,16,"RW",0,11'b0,1,1,0);
         reg_fc_src_addr.configure(this,11,0,"RW",0,11'b0,1,1,0);
    endfunction

    `uvm_object_utils(FC_SRC)

    function new(string name = "FC_SRC");
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