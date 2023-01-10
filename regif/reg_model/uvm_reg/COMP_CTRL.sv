`ifndef COMP_CTRL__SV
`define COMP_CTRL__SV

class COMP_CTRL extends uvm_reg;

    rand uvm_reg_field reg_comp_ctrl_wbload_init;
    rand uvm_reg_field reg_comp_ctrl_pool_mode;

    covergroup value_cg;
        option.per_instance = 1;
        reg_comp_ctrl_wbload_init_cp: coverpoint reg_comp_ctrl_wbload_init.value[0 : 0];
        reg_comp_ctrl_pool_mode_cp: coverpoint reg_comp_ctrl_pool_mode.value[0 : 0];
    endgroup

    virtual function void build();
        reg_comp_ctrl_wbload_init = uvm_reg_field::type_id::create("reg_comp_ctrl_wbload_init");
        reg_comp_ctrl_pool_mode = uvm_reg_field::type_id::create("reg_comp_ctrl_pool_mode");
        reg_comp_ctrl_wbload_init.configure(this,1,1,"RW",0,1'b1,1,1,0);
        reg_comp_ctrl_pool_mode.configure(this,1,0,"RW",0,1'b0,1,1,0);
    endfunction

    `uvm_object_utils(COMP_CTRL)

    function new(string name = "COMP_CTRL");
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