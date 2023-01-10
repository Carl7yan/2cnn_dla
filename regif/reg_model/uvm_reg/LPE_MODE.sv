`ifndef LPE_MODE__SV
`define LPE_MODE__SV

class LPE_MODE extends uvm_reg;

    rand uvm_reg_field reg_lpe_mode_leap_clone;
    rand uvm_reg_field reg_lpe_mode_relu;
    rand uvm_reg_field reg_lpe_mode_addr_merge;
    rand uvm_reg_field reg_lpe_mode_acc_bypass;
    rand uvm_reg_field reg_lpe_mode_overlay;
    rand uvm_reg_field reg_lpe_mode_sprmps;
    rand uvm_reg_field reg_lpe_mode_leap;

    covergroup value_cg;
        option.per_instance = 1;
        reg_lpe_mode_leap_clone_cp: coverpoint reg_lpe_mode_leap_clone.value[0 : 0];
        reg_lpe_mode_relu_cp: coverpoint reg_lpe_mode_relu.value[0 : 0];
        reg_lpe_mode_addr_merge_cp: coverpoint reg_lpe_mode_addr_merge.value[0 : 0];
        reg_lpe_mode_acc_bypass_cp: coverpoint reg_lpe_mode_acc_bypass.value[0 : 0];
        reg_lpe_mode_overlay_cp: coverpoint reg_lpe_mode_overlay.value[6 : 0];
        reg_lpe_mode_sprmps_cp: coverpoint reg_lpe_mode_sprmps.value[1 : 0];
        reg_lpe_mode_leap_cp: coverpoint reg_lpe_mode_leap.value[12 : 0];
    endgroup
        

    virtual function void build();
        reg_lpe_mode_leap_clone = uvm_reg_field::type_id::create("reg_lpe_mode_leap_clone");
        reg_lpe_mode_relu = uvm_reg_field::type_id::create("reg_lpe_mode_relu");
        reg_lpe_mode_addr_merge = uvm_reg_field::type_id::create("reg_lpe_mode_addr_merge");
        reg_lpe_mode_acc_bypass = uvm_reg_field::type_id::create("reg_lpe_mode_acc_bypass");
        reg_lpe_mode_overlay = uvm_reg_field::type_id::create("reg_lpe_mode_overlay");
        reg_lpe_mode_sprmps = uvm_reg_field::type_id::create("reg_lpe_mode_sprmps");
        reg_lpe_mode_leap = uvm_reg_field::type_id::create("reg_lpe_mode_leap");
        reg_lpe_mode_leap_clone.configure(this,1,31,"RW",0,1'b0,1,1,0);
        reg_lpe_mode_relu.configure(this,1,30,"RW",0,1'b0,1,1,0);
        reg_lpe_mode_addr_merge.configure(this,1,29,"RW",0,1'b0,1,1,0);
        reg_lpe_mode_acc_bypass.configure(this,1,28,"RW",0,1'b0,1,1,0);
        reg_lpe_mode_overlay.configure(this,7,20,"RW",0,7'b0,1,1,0);
        reg_lpe_mode_sprmps.configure(this,2,16,"RW",0,2'b0,1,1,0);
        reg_lpe_mode_leap.configure(this,13,0,"RW",0,13'b0,1,1,0);
    endfunction

    `uvm_object_utils(LPE_MODE)
    
    function new(string name = "LPE_MODE");
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