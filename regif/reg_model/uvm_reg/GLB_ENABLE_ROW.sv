`ifndef GLB_ENABLE_ROW__SV
`define GLB_ENABLE_ROW__SV

class GLB_ENABLE_ROW extends uvm_reg;

    rand uvm_reg_field reg_enable_row_row;

    covergroup value_cg;
        option.per_instance = 1;
        reg_enable_row_row_cp: coverpoint reg_enable_row_row.value[15 : 0];
    endgroup    

    virtual function void build();
        reg_enable_row_row = uvm_reg_field::type_id::create("reg_enable_row_row");
        reg_enable_row_row.configure(this,16,0,"RW",0,16'hffff,1,1,0);        
    endfunction

    `uvm_object_utils(GLB_ENABLE_ROW)

    function new(string name = "GLB_ENABLE_ROW");
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