`ifndef GLB_INTR__SV
`define GLB_INTR__SV

class GLB_INTR extends uvm_reg;

    rand uvm_reg_field reg_intr_reshape;
    rand uvm_reg_field reg_intr_ape;
    rand uvm_reg_field reg_intr_fc;
    rand uvm_reg_field reg_intr_conv;
    rand uvm_reg_field reg_intr_gb2lb;
    rand uvm_reg_field reg_intr_ddr2gb;

    covergroup value_cg;
        option.per_instance = 1;
        reg_intr_reshape_cp: coverpoint reg_intr_reshape.value[0 : 0];
        reg_intr_ape_cp: coverpoint reg_intr_ape.value[0 : 0];
        reg_intr_fc_cp: coverpoint reg_intr_fc.value[0 : 0];
        reg_intr_conv_cp: coverpoint reg_intr_conv.value[0 : 0];
        reg_intr_gb2lb_cp: coverpoint reg_intr_gb2lb.value[0 : 0];
        reg_intr_ddr2gb_cp: coverpoint reg_intr_ddr2gb.value[0 : 0];
    endgroup

    virtual function void build();
       reg_intr_reshape = uvm_reg_field::type_id::create("reg_intr_reshape");
       reg_intr_ape = uvm_reg_field::type_id::create("reg_intr_ape");
       reg_intr_fc = uvm_reg_field::type_id::create("reg_intr_fc");
       reg_intr_conv = uvm_reg_field::type_id::create("reg_intr_con");
       reg_intr_gb2lb = uvm_reg_field::type_id::create("reg_intr_gb2lb");
       reg_intr_ddr2gb = uvm_reg_field::type_id::create("reg_intr_ddr2gb");
       reg_intr_reshape.configure(this,1,5,"RW",0,1'b0,1,1,0);
       reg_intr_ape.configure(this,1,4,"RW",0,1'b0,1,1,0);
       reg_intr_fc.configure(this,1,3,"RW",0,1'b0,1,1,0);
       reg_intr_conv.configure(this,1,2,"RW",0,1'b0,1,1,0);
       reg_intr_gb2lb.configure(this,1,1,"RW",0,1'b0,1,1,0 );
       reg_intr_ddr2gb.configure(this,1,0,"RW",0,1'b0,1,1,0);
    endfunction

    `uvm_object_utils(GLB_INTR)

    function new(string name = "GLB_INTR");
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