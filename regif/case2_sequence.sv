`ifndef CASE2_SEQUENCE__SV
`define CASE2_SEQUENCE__SV

class case2_sequence extends uvm_sequence#(reg_bus_item);

    `uvm_object_utils(case2_sequence)
    `uvm_declare_p_sequencer(bus_sequencer)

    uvm_status_e status;
    uvm_reg_data_t value = 64'h0000_0000_ffff_ffff;

    function new(string name = "case2_sequence");
        super.new(name);
    endfunction

    virtual task body();//this body is used to continuously write data into registers.
        p_sequencer.reg_model3.SOC2GB1.SOC2GB_CONFIG1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_CTRL1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_DDR_ADDR01.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_DDR_ADDR11.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_GB_ADDR1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.GB2LB1.GB2LB_SRC01.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.GB2LB1.GB2LB_SRC11.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.GB2LB1.GB2LB_DEST1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.APE1.APE_CTRL1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.APE1.APE_SRC1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.APE1.APE_DEST1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.APE1.APE_IMM1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.CONV1.CONV_K_SiZE01.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.CONV1.CONV_K_SIZE11.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.CONV1.CONV_K_LOAD1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.CONV1.CONV_FMAP1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.CONV1.CONV_STRIDE1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.CONV1.CONV_PAD_SIZE1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.CONV1.CONV_PAD_NUM1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.FC1.FC_SRC1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.RESHAPE1.RESHAPE_SRC01.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.RESHAPE1.RESHAPE_SRC11.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_SRC01.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_SRC11.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_DEST01.write(status,value,UVM_FRONTDOOR);

        p_sequencer.reg_model3.LPE1.LPE_DEST11.write(status,value,UVM_FRONTDOOR);

        p_sequencer.reg_model3.LPE1.LPE_MODE1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_LEAP01.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_LEAP11.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_LEAP21.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_LEAP31.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_LEAP41.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_LEAP51.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_LEAP61.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.LPE1.LPE_LEAP71.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_DDR_ADDR01.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_DDR_ADDR11.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_KERNEL1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_CHANNEL1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.COMP_CTRL_PRECISION1.COMP_CTRL1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.COMP_CTRL_PRECISION1.PRECISION1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.GLB1.GLB_INTR1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.GLB1.GLB_ENABLE_ROW1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.GLB1.GLB_ENABLE_COL1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.BUF1.BUF_MASKX1.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.BUF1.BUF_MASK01.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.BUF1.BUF_MASK11.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.BUF1.BUF_MASK21.write(status,value,UVM_FRONTDOOR);

        p_sequencer.reg_model3.BUF1.BUF_MASK31.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.BUF1.BUF_MASK41.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.BUF1.BUF_MASK51.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.BUF1.BUF_MASK61.write(status,value,UVM_FRONTDOOR);
    
        p_sequencer.reg_model3.BUF1.BUF_MASK71.write(status,value,UVM_FRONTDOOR);
    endtask
endclass
`endif 

