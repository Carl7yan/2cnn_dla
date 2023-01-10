`ifndef APE_SRC__SV
`define APE_SRC__SV

class APE_SRC extends uvm_reg;

    rand uvm_reg_field reg_src_gb_addr_sb;
    rand uvm_reg_field reg_src_gb_addr_sa;

    covergroup value_cg;
        option.per_instance = 1;
        reg_src_gb_addr_sb_cp: coverpoint reg_src_gb_addr_sb.value[12 : 0];
        reg_src_gb_addr_sa_cp: coverpoint reg_src_gb_addr_sa.value[12 : 0];
    endgroup

    virtual function void build();
        reg_src_gb_addr_sb = uvm_reg_field::type_id::create("reg_src_gb_addr_sb");
        reg_src_gb_addr_sa = uvm_reg_field::type_id::create("reg_src_gb_addr_sa");
        reg_src_gb_addr_sb.configure(this,13,16,"RW",0,13'b0,1,1,0);
        reg_src_gb_addr_sa.configure(this,13,0,"RW",0,13'b0,1,1,0);
    endfunction

    `uvm_object_utils(APE_SRC)

    function new(string name = "APE_SRC");
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