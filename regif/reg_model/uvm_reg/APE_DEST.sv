`ifndef APE_DEST__SV
`define APE_DEST__SV

class APE_DEST extends uvm_reg;

    rand uvm_reg_field reg_dest_length;
    rand uvm_reg_field reg_dest_gb_addr_d;

    covergroup value_cg;
        option.per_instance = 1;
        reg_dest_length_cp: coverpoint reg_dest_length.value[12 : 0];
        reg_dest_gb_addr_d_cp: coverpoint reg_dest_gb_addr_d.value[12 : 0];
    endgroup

    virtual function void build();
        reg_dest_length = uvm_reg_field::type_id::create("reg_dest_length");
        reg_dest_gb_addr_d = uvm_reg_field::type_id::create("reg_dest_gb_addr_d");
        reg_dest_length.configure(this,13,16,"RW",0,13'b0,1,1,0);
        reg_dest_gb_addr_d.configure(this,13,0,"RW",0,13'b0,1,1,0);
    endfunction

    `uvm_object_utils(APE_DEST)

    function new(string name = "APE_DEST");
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