`ifndef REG_MODEL__SV
`define REG_MODEL__SV

class  reg_model extends uvm_reg_block;
    rand APE APE1;
    rand BUF BUF1;
    rand COMP_CTRL_PRECISION COMP_CTRL_PRECISION1;
    rand CONV CONV1;
    rand DDR2GB DDR2GB1;
    rand FC FC1;
    rand GB2LB GB2LB1;
    rand GLB GLB1;
    rand LPE LPE1;
    rand RESHAPE RESHAPE1;
    rand SOC2GB SOC2GB1;
    rand WBLOAD WBLOAD1;

    virtual function void build();
        default_map = create_map("default_map",0,4,UVM_LITTLE_ENDIAN,0);

        APE1 = APE::type_id::create("APE1");
        APE1.configure(this,"regif_ape");
        APE1.build();
        //`uvm_info("reg_model",$sformatf("APE1 default_map = %s",APE1.default_map.get_full_name()),UVM_LOW)
        APE1.lock_model();
        //`uvm_info("reg_model",$sformatf("reg_model default_map = %s",default_map.get_full_name()),UVM_LOW)
        default_map.add_submap(APE1.default_map,20'h0_1030);

        BUF1 = BUF::type_id::create("BUF1");
        BUF1.configure(this,"regif_buf");
        BUF1.build();
        BUF1.lock_model();
        default_map.add_submap(BUF1.default_map,20'h0_0010);

        COMP_CTRL_PRECISION1 = COMP_CTRL_PRECISION::type_id::create("COMP_CTRL_PRECISION1");
        COMP_CTRL_PRECISION1.configure(this,"");
        COMP_CTRL_PRECISION1.build();
        COMP_CTRL_PRECISION1.lock_model();
        default_map.add_submap(COMP_CTRL_PRECISION1.default_map,20'h0_1100);

        CONV1 = CONV::type_id::create("CONV1");
        CONV1.configure(this,"regif_comp");
        CONV1.build();
        CONV1.lock_model();
        default_map.add_submap(CONV1.default_map,20'h0_1040);

        DDR2GB1 = DDR2GB::type_id::create("DDR2GB1");
        DDR2GB1.configure(this,"regif_ddr2gb");
        DDR2GB1.build();       
        DDR2GB1.lock_model();
        default_map.add_submap(DDR2GB1.default_map,20'h0_1000);
         `uvm_info("reg_model",$sformatf("DDR2GB1 default_map = %s",DDR2GB1.default_map.get_full_name()),UVM_LOW)

        FC1 = FC::type_id::create("FC1");
        FC1.configure(this,"regif_comp");
        FC1.build();
        FC1.lock_model();
        default_map.add_submap(FC1.default_map,20'h0_1050);

        GB2LB1 = GB2LB::type_id::create("GB2LB1");
        GB2LB1.configure(this,"regif_gb2lb");
        GB2LB1.build();
        GB2LB1.lock_model();
        default_map.add_submap(GB2LB1.default_map,20'h0_1020);

        GLB1 = GLB::type_id::create("GLB");
        GLB1.configure(this,"regif_glb");
        GLB1.build();
        GLB1.lock_model();
        default_map.add_submap(GLB1.default_map,20'h0_0000);


        LPE1 = LPE::type_id::create("LPE1");
        LPE1.configure(this,"regif_comp");
        LPE1.build();
        LPE1.lock_model();
        default_map.add_submap(LPE1.default_map,20'h0_1070);

        RESHAPE1 = RESHAPE::type_id::create("RESHAPE1");
        RESHAPE1.configure(this,"regif_comp");
        RESHAPE1.build();
        RESHAPE1.lock_model();
        default_map.add_submap(RESHAPE1.default_map,20'h0_1060);

        SOC2GB1 = SOC2GB::type_id::create("SOC2GB1");
        SOC2GB1.configure(this,"regif_soc2gb");
        SOC2GB1.build();
        SOC2GB1.lock_model();
        default_map.add_submap(SOC2GB1.default_map,20'h0_0020);

        WBLOAD1 = WBLOAD::type_id::create("WBLOAD");
        WBLOAD1.configure(this,"regif_comp");
        WBLOAD1.build();
        WBLOAD1.lock_model();
        default_map.add_submap(WBLOAD1.default_map,20'h0_1080);

    endfunction

    `uvm_object_utils(reg_model)

    function new(string name = "reg_model");
        super.new(name,UVM_NO_COVERAGE);
    endfunction

endclass
`endif 