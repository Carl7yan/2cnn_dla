`ifndef CASE1_SEQUENCE__SV
`define CASE1_SEQUENCE__SV

class case1_sequence extends uvm_sequence#(reg_bus_item);

    `uvm_object_utils(case1_sequence)
    `uvm_declare_p_sequencer(bus_sequencer)

    uvm_reg_data_t value;
    uvm_status_e status;
    virtual ini_if ini_if4;

    function new(string name = "case1_sequence");
        super.new(name);
    endfunction

    virtual task pre_body();

    endtask/*the function of pre_body is utilizing the config_gb mechanism to get a instance of ini_if. There is no used.
             Maybe when the case1_sequence is first created, this is planed to do something, but later no use.*/


    virtual task body();//this body is used to continuously read the register in the dla_regif.
        if(!uvm_config_db#(virtual ini_if)::get(null,get_full_name(),"ini_if",ini_if4)) begin
                `uvm_info("case1_sequence","virtual interface must be set!!",UVM_LOW)
            end
            `uvm_info("case1_sequence",$sformatf("%s",get_full_name()),UVM_LOW)

        @(negedge ini_if4.rst);//wait the reset signal becoming ineffect then to read the registers value and check it.
        p_sequencer.reg_model3.SOC2GB1.SOC2GB_CONFIG1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.SOC2GB1.SOC2GB_CONFIG1  error! ")
        end

        p_sequencer.reg_model3.DDR2GB1.DDR2GB_CTRL1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.DDR2GB1.DDR2GB_CTRL1 error! ")
        end

        p_sequencer.reg_model3.DDR2GB1.DDR2GB_DDR_ADDR01.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.DDR2GB1.DDR2GB_CTRL1 error! ")
        end

        p_sequencer.reg_model3.DDR2GB1.DDR2GB_DDR_ADDR11.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.DDR2GB1.DDR2GB_DDR_ADDR11 error! ")
        end

        p_sequencer.reg_model3.DDR2GB1.DDR2GB_GB_ADDR1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.DDR2GB1.DDR2GB_GB_ADDR1 error! ")
        end

        p_sequencer.reg_model3.GB2LB1.GB2LB_SRC01.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.GB2LB1.GB2LB_SRC01 error! ")
        end

        p_sequencer.reg_model3.GB2LB1.GB2LB_SRC11.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.GB2LB1.GB2LB_SRC11 error! ")
        end

        p_sequencer.reg_model3.GB2LB1.GB2LB_DEST1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.GB2LB1.GB2LB_DEST1 error! ")
        end

        p_sequencer.reg_model3.APE1.APE_CTRL1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.APE1.APE_CTRL1 error! ")
        end

        p_sequencer.reg_model3.APE1.APE_SRC1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.APE1.APE_SRC1 error! ")
        end

        p_sequencer.reg_model3.APE1.APE_DEST1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.APE1.APE_DEST1 error! ")
        end

        p_sequencer.reg_model3.APE1.APE_IMM1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.APE1.APE_IMM1 error! ")
        end

        p_sequencer.reg_model3.CONV1.CONV_K_SiZE01.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_K_SiZE01 error! ")
        end

        p_sequencer.reg_model3.CONV1.CONV_K_SIZE11.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_K_SIZE11 error! ")
        end

        p_sequencer.reg_model3.CONV1.CONV_K_LOAD1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_K_LOAD1 error! ")
        end

        p_sequencer.reg_model3.CONV1.CONV_FMAP1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_FMAP1 error! ")
        end

        p_sequencer.reg_model3.CONV1.CONV_STRIDE1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_STRIDE1 error! ")
        end

        p_sequencer.reg_model3.CONV1.CONV_PAD_SIZE1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_PAD_SIZE1 error! ")
        end

        p_sequencer.reg_model3.CONV1.CONV_PAD_NUM1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_PAD_NUM1 error! ")
        end

        p_sequencer.reg_model3.FC1.FC_SRC1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.FC1.FC_SRC1 error! ")
        end

        p_sequencer.reg_model3.RESHAPE1.RESHAPE_SRC01.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.RESHAPE1.RESHAPE_SRC01 error! ")
        end

        p_sequencer.reg_model3.RESHAPE1.RESHAPE_SRC11.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.RESHAPE1.RESHAPE_SRC11 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_SRC01.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_SRC01 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_SRC11.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_SRC11 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_DEST01.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_DEST01 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_DEST11.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_DEST11 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_MODE1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_MODE1 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_LEAP01.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_MODE1 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_LEAP11.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP11 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_LEAP21.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP21 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_LEAP31.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP31 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_LEAP41.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP41 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_LEAP51.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP51 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_LEAP61.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP61 error! ")
        end

        p_sequencer.reg_model3.LPE1.LPE_LEAP71.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP71 error! ")
        end

        p_sequencer.reg_model3.WBLOAD1.WBLOAD_DDR_ADDR01.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.WBLOAD1.WBLOAD_DDR_ADDR01 error! ")
        end

        p_sequencer.reg_model3.WBLOAD1.WBLOAD_DDR_ADDR11.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.WBLOAD1.WBLOAD_DDR_ADDR11 error! ")
        end

        p_sequencer.reg_model3.WBLOAD1.WBLOAD_KERNEL1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.WBLOAD1.WBLOAD_KERNEL1 error! ")
        end

        p_sequencer.reg_model3.WBLOAD1.WBLOAD_CHANNEL1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.WBLOAD1.WBLOAD_CHANNEL1 error! ")
        end

        p_sequencer.reg_model3.COMP_CTRL_PRECISION1.COMP_CTRL1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd2) begin
            `uvm_error("case1_sequence","reg_model3.COMP_CTRL_PRECISION1.COMP_CTRL1 error! ")
        end

        p_sequencer.reg_model3.COMP_CTRL_PRECISION1.PRECISION1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.COMP_CTRL_PRECISION.PRECISION1 error! ")
        end

        p_sequencer.reg_model3.GLB1.GLB_INTR1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.GLB1.GLB_INTR1 error! ")
        end

        p_sequencer.reg_model3.GLB1.GLB_ENABLE_ROW1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'h0000_0000_0000_ffff) begin
            `uvm_error("case1_sequence","reg_model3.GLB1.GLB_ENABLE_ROW1 error! ")
        end

        p_sequencer.reg_model3.GLB1.GLB_ENABLE_COL1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'h0000_0000_0000_ffff) begin
            `uvm_error("case1_sequence","reg_model3.GLB1.GLB_ENABLE_COL1 error! ")
        end

        p_sequencer.reg_model3.BUF1.BUF_MASKX1.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASKX1 error! ")
        end

        p_sequencer.reg_model3.BUF1.BUF_MASK01.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK01 error! ")
        end

        p_sequencer.reg_model3.BUF1.BUF_MASK11.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK11 error! ")
        end

        p_sequencer.reg_model3.BUF1.BUF_MASK21.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK21 error! ")
        end

        p_sequencer.reg_model3.BUF1.BUF_MASK31.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK31 error! ")
        end

        p_sequencer.reg_model3.BUF1.BUF_MASK41.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK41 error! ")
        end

        p_sequencer.reg_model3.BUF1.BUF_MASK51.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK51 error! ")
        end

        p_sequencer.reg_model3.BUF1.BUF_MASK61.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK61 error! ")
        end

        p_sequencer.reg_model3.BUF1.BUF_MASK71.read(status,value,UVM_FRONTDOOR);
        if(value !== 64'd0) begin
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK71 error! ")
        end


    endtask

endclass
`endif
