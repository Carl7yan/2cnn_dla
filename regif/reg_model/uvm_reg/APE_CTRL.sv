`ifndef APE_CTRL__SV
`define APE_CTRL__SV

class APE_CTRL extends uvm_reg;

    rand  uvm_reg_field reg_ctrl_mode;

    covergroup value_cg;
        option.per_instance = 1;
        reg_ctrl_mode_cp: coverpoint reg_ctrl_mode.value[2 : 0];
    endgroup

    virtual function void build();
        reg_ctrl_mode = uvm_reg_field::type_id::create("reg_ctrl_mode");
        reg_ctrl_mode.configure(this,3,0,"RW",0,3'b0,1,1,0);
    endfunction

    `uvm_object_utils(APE_CTRL)

    function new(string name = "APE_CTRL");
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