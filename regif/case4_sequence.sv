`ifndef CASE4_SEQUENCE__SV
`define CASE4_SEQUENCE__SV
class case4_sequence extends uvm_sequence#(reg_bus_item);

    `uvm_object_utils(case4_sequence)

    `uvm_declare_p_sequencer(bus_sequencer)

    uvm_status_e status;
    rand uvm_reg_data_t w_value;
    uvm_reg_data_t r_value;

    function new(string name = "case4_sequence");
        super.new(name);
    endfunction

    virtual task body();
        `uvm_info("case4_sequence","begin wrtie/read operation!",UVM_LOW)
        p_sequencer.reg_model3.SOC2GB1.SOC2GB_CONFIG1.write(status,w_value,UVM_FRONTDOOR);     //       ---
                                                                                               //         |
        p_sequencer.reg_model3.SOC2GB1.SOC2GB_CONFIG1.read(status,r_value,UVM_FRONTDOOR);      //         |
        if(r_value !== {56'h00_0000_0000_0000,3'b0,w_value[4 : 4],2'b0,w_value[1 : 0]}) begin  //         |==== > SOC2GB1
            `uvm_error("case1_sequence","reg_model3.SOC2GB1.SOC2GB_CONFIG1  error! ")          //         |
            $display("r_value is %h",r_value);                                                 //         |
        end                                                                                    //       ---

        p_sequencer.reg_model3.DDR2GB1.DDR2GB_CTRL1.write(status,w_value,UVM_FRONTDOOR);               //     ---
                                                                                                       //       |
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_CTRL1.read(status,r_value,UVM_FRONTDOOR);                //       |
        if(r_value !== {60'h000_0000_0000_0000,3'b0,w_value[0]}) begin                                 //       |
            `uvm_error("case1_sequence","reg_model3.DDR2GB1.DDR2GB_CTRL1 error! ")                     //       |
        end                                                                                            //       |
                                                                                                       //       |
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_DDR_ADDR01.write(status,w_value,UVM_FRONTDOOR);          //       |
                                                                                                       //       |
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_DDR_ADDR01.read(status,r_value,UVM_FRONTDOOR);           //       |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                          //       |
            `uvm_error("case1_sequence","reg_model3.DDR2GB1.DDR2GB_CTRL1 error! ")                     //       |
        end                                                                                            //       |===== > DDR2GB1
                                                                                                       //       |
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_DDR_ADDR11.write(status,w_value,UVM_FRONTDOOR);          //       |
                                                                                                       //       |
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_DDR_ADDR11.read(status,r_value,UVM_FRONTDOOR);           //       |
        if(r_value !== {40'h00_0000_0000,2'b0,w_value[21 : 0]}) begin                                  //       |
            `uvm_error("case1_sequence","reg_model3.DDR2GB1.DDR2GB_DDR_ADDR11 error! ")                //       |
        end                                                                                            //       |
                                                                                                       //       |
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_GB_ADDR1.write(status,w_value,UVM_FRONTDOOR);            //       |
                                                                                                       //       |
        p_sequencer.reg_model3.DDR2GB1.DDR2GB_GB_ADDR1.read(status,r_value,UVM_FRONTDOOR);             //       |
        if(r_value !== {32'h0000_0000,w_value[31 : 24],w_value[23 : 20],6'b0,w_value[13 : 0]}) begin   //       |
            `uvm_error("case1_sequence","reg_model3.DDR2GB1.DDR2GB_GB_ADDR1 error! ")                  //       |
        end                                                                                            //     ---

        p_sequencer.reg_model3.GB2LB1.GB2LB_SRC01.write(status,w_value,UVM_FRONTDOOR);                 //     ---
                                                                                                       //       |
        p_sequencer.reg_model3.GB2LB1.GB2LB_SRC01.read(status,r_value,UVM_FRONTDOOR);                  //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin               //       |
            `uvm_error("case1_sequence","reg_model3.GB2LB1.GB2LB_SRC01 error! ")                       //       |
        end                                                                                            //       |
                                                                                                       //       |
        p_sequencer.reg_model3.GB2LB1.GB2LB_SRC11.write(status,w_value,UVM_FRONTDOOR);                 //       |
                                                                                                       //       |
        p_sequencer.reg_model3.GB2LB1.GB2LB_SRC11.read(status,r_value,UVM_FRONTDOOR);                  //       |==== > GB2LB1
        if(r_value !== {40'h00_0000_0000,2'b0,w_value[21 : 16],3'b0,w_value[12 : 0]}) begin            //       |
            `uvm_error("case1_sequence","reg_model3.GB2LB1.GB2LB_SRC11 error! ")                       //       |
        end                                                                                            //       |
                                                                                                       //       |
        p_sequencer.reg_model3.GB2LB1.GB2LB_DEST1.write(status,w_value,UVM_FRONTDOOR);                 //       |
                                                                                                       //       |
        p_sequencer.reg_model3.GB2LB1.GB2LB_DEST1.read(status,r_value,UVM_FRONTDOOR);                  //       |
        if(r_value !== {40'h00_0000_0000,2'b0,w_value[21 : 16],5'b0,w_value[10 : 0]}) begin            //       |
            `uvm_error("case1_sequence","reg_model3.GB2LB1.GB2LB_DEST1 error! ")                       //       |
        end                                                                                            //     ---

        p_sequencer.reg_model3.APE1.APE_CTRL1.write(status,w_value,UVM_FRONTDOOR);                                                    //     ---
                                                                                                                                      //       |
        p_sequencer.reg_model3.APE1.APE_CTRL1.read(status,r_value,UVM_FRONTDOOR);                                                     //       |
        if(r_value !== {60'h000_0000_0000_0000,1'b0,w_value[2 : 0] > 3'd4 ? 3'd0 : w_value[2 : 0]}) begin                             //       |
            `uvm_error("case1_sequence","reg_model3.APE1.APE_CTRL1 error! ")                                                          //       |
        end                                                                                                                           //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.APE1.APE_SRC1.write(status,w_value,UVM_FRONTDOOR);                                                     //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.APE1.APE_SRC1.read(status,r_value,UVM_FRONTDOOR);                                                      //       |
        if(r_value !== {32'h0000_0000,2'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                              //       |
            `uvm_error("case1_sequence","reg_model3.APE1.APE_SRC1 error! ")                                                           //       |
        end                                                                                                                           //       |==== > APE1
                                                                                                                                      //       |
        p_sequencer.reg_model3.APE1.APE_DEST1.write(status,w_value,UVM_FRONTDOOR);                                                    //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.APE1.APE_DEST1.read(status,r_value,UVM_FRONTDOOR);                                                     //       |
        if(r_value !== {32'h0000_0000,2'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                              //       |
            `uvm_error("case1_sequence","reg_model3.APE1.APE_DEST1 error! ")                                                          //       |
        end                                                                                                                           //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.APE1.APE_IMM1.write(status,w_value,UVM_FRONTDOOR);                                                     //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.APE1.APE_IMM1.read(status,r_value,UVM_FRONTDOOR);                                                      //       |
        if(r_value !== {48'h0000_0000_0000,w_value[15 : 0]}) begin                                                                    //       |
            `uvm_error("case1_sequence","reg_model3.APE1.APE_IMM1 error! ")                                                           //       |
        end                                                                                                                           //     ---
                               
        p_sequencer.reg_model3.CONV1.CONV_K_SiZE01.write(status,w_value,UVM_FRONTDOOR);                                               //     ---
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_K_SiZE01.read(status,r_value,UVM_FRONTDOOR);                                                //       |
        if(r_value !== {32'h0000_0000,2'b0,w_value[29 : 24],2'b0,w_value[21 : 16],2'b0,w_value[13 : 8],2'b0,w_value[5 : 0]}) begin    //       |
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_K_SiZE01 error! ")                                                     //       |
        end                                                                                                                           //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_K_SIZE11.write(status,w_value,UVM_FRONTDOOR);                                               //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_K_SIZE11.read(status,r_value,UVM_FRONTDOOR);                                                //       |
        if(r_value !== {36'h0_0000_0000,w_value[27 : 16],12'b0,w_value[3 : 0]}) begin                                                 //       |
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_K_SIZE11 error! ")                                                     //       |
        end                                                                                                                           //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_K_LOAD1.write(status,w_value,UVM_FRONTDOOR);                                                //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_K_LOAD1.read(status,r_value,UVM_FRONTDOOR);                                                 //       |
        if(r_value !== {60'h000_0000_0000_0000,2'b0,w_value[1 : 0]}) begin                                                            //       |
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_K_LOAD1 error! ")                                                      //       |
        end                                                                                                                           //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_FMAP1.write(status,w_value,UVM_FRONTDOOR);                                                  //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_FMAP1.read(status,r_value,UVM_FRONTDOOR);                                                   //       |
        if(r_value !== {32'h0000_0000,2'b0,w_value[29 : 24],2'b0,w_value[21 : 16],2'b0,w_value[13 : 8],2'b0,w_value[5 : 0]}) begin    //       |==== > CONV1
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_FMAP1 error! ")                                                        //       |
        end                                                                                                                           //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_STRIDE1.write(status,w_value,UVM_FRONTDOOR);                                                //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_STRIDE1.read(status,r_value,UVM_FRONTDOOR);                                                 //       |
        if(r_value !== {48'h0000_0000_0000,2'b0,w_value[13 : 8],2'b0,w_value[5 : 0]}) begin                                           //       |
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_STRIDE1 error! ")                                                      //       |
        end                                                                                                                           //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_PAD_SIZE1.write(status,w_value,UVM_FRONTDOOR);                                              //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_PAD_SIZE1.read(status,r_value,UVM_FRONTDOOR);                                               //       |
        if(r_value !== {36'h0_0000_0000,w_value[27 : 24],4'b0,w_value[19 : 16],4'b0,w_value[11 : 8],4'b0,w_value[3 : 0]}) begin       //       |
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_PAD_SIZE1 error! ")                                                    //       |
        end                                                                                                                           //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_PAD_NUM1.write(status,w_value,UVM_FRONTDOOR);                                               //       |
                                                                                                                                      //       |
        p_sequencer.reg_model3.CONV1.CONV_PAD_NUM1.read(status,r_value,UVM_FRONTDOOR);                                                //       |
        if(r_value !== {48'h0000_0000_0000,w_value[15 : 0]}) begin                                                                    //       |
            `uvm_error("case1_sequence","reg_model3.CONV1.CONV_PAD_NUM1 error! ")                                                     //       |
        end                                                                                                                           //     ---

        p_sequencer.reg_model3.FC1.FC_SRC1.write(status,w_value,UVM_FRONTDOOR);                                    //     --- 
                                                                                                                   //       |
        p_sequencer.reg_model3.FC1.FC_SRC1.read(status,r_value,UVM_FRONTDOOR);                                     //       |==== > FC1
        if(r_value !== {36'h0_0000_0000,1'b0,w_value[26 : 16],5'b0,w_value[10 : 0]}) begin                         //       |
            `uvm_error("case1_sequence","reg_model3.FC1.FC_SRC1 error! ")                                          //       |
        end                                                                                                        //     ---
                                                                                                                   
        p_sequencer.reg_model3.RESHAPE1.RESHAPE_SRC01.write(status,w_value,UVM_FRONTDOOR);                         //     ---
                                                                                                                   //       |
        p_sequencer.reg_model3.RESHAPE1.RESHAPE_SRC01.read(status,r_value,UVM_FRONTDOOR);                          //       |
        if(r_value !== {36'h0_0000_0000,1'b0,w_value[26 : 16],5'b0,w_value[10 : 0]}) begin                         //       |
            `uvm_error("case1_sequence","reg_model3.RESHAPE1.RESHAPE_SRC01 error! ")                               //       |
        end                                                                                                        //       |
                                                                                                                   //       |==== > RESHAPE1
        p_sequencer.reg_model3.RESHAPE1.RESHAPE_SRC11.write(status,w_value,UVM_FRONTDOOR);                         //       |
                                                                                                                   //       |
        p_sequencer.reg_model3.RESHAPE1.RESHAPE_SRC11.read(status,r_value,UVM_FRONTDOOR);                          //       |
        if(r_value !== {40'h00_0000_0000,2'b0,w_value[21 : 16],10'b0,w_value[5 : 0]}) begin                        //       |
            `uvm_error("case1_sequence","reg_model3.RESHAPE1.RESHAPE_SRC11 error! ")                               //       |
        end                                                                                                        //     ---

        p_sequencer.reg_model3.LPE1.LPE_SRC01.write(status,w_value,UVM_FRONTDOOR);                                                                                                 //     ---
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_SRC01.read(status,r_value,UVM_FRONTDOOR);                                                                                                  //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_SRC01 error! ")                                                                                                       //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_SRC11.write(status,w_value,UVM_FRONTDOOR);                                                                                                 //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_SRC11.read(status,r_value,UVM_FRONTDOOR);                                                                                                  //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_SRC11 error! ")                                                                                                       //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_DEST01.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_DEST01.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_DEST01 error! ")                                                                                                      //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_DEST11.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_DEST11.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_DEST11 error! ")                                                                                                      //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_MODE1.write(status,w_value,UVM_FRONTDOOR);                                                                                                 //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_MODE1.read(status,r_value,UVM_FRONTDOOR);                                                                                                  //       |
        if(r_value !== {28'h000_0000,3'b0,w_value[31 : 28],10'b0,w_value[17 : 16] != 2'd3 ? w_value[17 : 16] : r_value[17 : 16],3'b0,w_value[12 : 0]}) begin      //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_MODE1 error! ")                                                                                                       //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP01.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP01.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_MODE1 error! ")                                                                                                       //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP11.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |==== > LPE1
        p_sequencer.reg_model3.LPE1.LPE_LEAP11.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP11 error! ")                                                                                                      //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP21.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP21.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP21 error! ")                                                                                                      //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP31.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP31.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP31 error! ")                                                                                                      //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP41.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP41.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP41 error! ")                                                                                                      //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP51.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP51.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP51 error! ")                                                                                                      //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP61.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP61.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[28 : 16],3'b0,w_value[12 : 0]}) begin                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP61 error! ")                                                                                                      //       |
        end                                                                                                                                                                        //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP71.write(status,w_value,UVM_FRONTDOOR);                                                                                                //       |
                                                                                                                                                                                   //       |
        p_sequencer.reg_model3.LPE1.LPE_LEAP71.read(status,r_value,UVM_FRONTDOOR);                                                                                                 //       |
        if(r_value !== {32'h0000_0000,3'b0,w_value[12 : 0],16'b0}) begin                                                                                                           //       |
            `uvm_error("case1_sequence","reg_model3.LPE1.LPE_LEAP71 error! ")                                                                                                      //       |
        end                                                                                                                                                                        //     ---
                                                                                                                                         
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_DDR_ADDR01.write(status,w_value,UVM_FRONTDOOR);                                               //    ---
                                                                                                                                            //      |
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_DDR_ADDR01.read(status,r_value,UVM_FRONTDOOR);                                                //      |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                                                               //      |
            `uvm_error("case1_sequence","reg_model3.WBLOAD1.WBLOAD_DDR_ADDR01 error! ")                                                     //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_DDR_ADDR11.write(status,w_value,UVM_FRONTDOOR);                                               //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_DDR_ADDR11.read(status,r_value,UVM_FRONTDOOR);                                                //      |
        if(r_value !== {40'h00_0000_0000,2'b0,w_value[21 : 0]}) begin                                                                       //      |
            `uvm_error("case1_sequence","reg_model3.WBLOAD1.WBLOAD_DDR_ADDR11 error! ")                                                     //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |==== > WBLOAD1
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_KERNEL1.write(status,w_value,UVM_FRONTDOOR);                                                  //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_KERNEL1.read(status,r_value,UVM_FRONTDOOR);                                                   //      |
        if(r_value !== {32'h0000_0000,2'b0,w_value[29 : 28],12'b0,w_value[15 : 0]}) begin                                                   //      |
            `uvm_error("case1_sequence","reg_model3.WBLOAD1.WBLOAD_KERNEL1 error! ")                                                        //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_CHANNEL1.write(status,w_value,UVM_FRONTDOOR);                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.WBLOAD1.WBLOAD_CHANNEL1.read(status,r_value,UVM_FRONTDOOR);                                                  //      |
        if(r_value !== {52'h0_0000_0000_0000,w_value[11 : 8],4'b0,w_value[3 : 0]}) begin                                                    //      |
            `uvm_error("case1_sequence","reg_model3.WBLOAD1.WBLOAD_CHANNEL1 error! ")                                                       //      |
        end                                                                                                                                 //    ---

        p_sequencer.reg_model3.COMP_CTRL_PRECISION1.COMP_CTRL1.write(status,w_value,UVM_FRONTDOOR);                                         //    ---
                                                                                                                                            //      |
        p_sequencer.reg_model3.COMP_CTRL_PRECISION1.COMP_CTRL1.read(status,r_value,UVM_FRONTDOOR);                                          //      |
        if(r_value !== {60'h000_0000_0000_0000,2'b0,w_value[1 : 0]}) begin                                                                  //      |
            `uvm_error("case1_sequence","reg_model3.COMP_CTRL_PRECISION1.COMP_CTRL1 error! ")                                               //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |==== > COMP_CTRL_PRECISION1
        p_sequencer.reg_model3.COMP_CTRL_PRECISION1.PRECISION1.write(status,w_value,UVM_FRONTDOOR);                                         //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.COMP_CTRL_PRECISION1.PRECISION1.read(status,r_value,UVM_FRONTDOOR);                                          //      |
        if(r_value !== {36'h0_0000_0000,w_value[27 : 24],4'b0,w_value[19 : 16],7'b0,w_value[8],6'b0,w_value[1 : 0]}) begin                  //      |
            `uvm_error("case1_sequence","reg_model3.COMP_CTRL_PRECISION.PRECISION1 error! ")                                                //      |
        end                                                                                                                                 //    ---

        /*p_sequencer.reg_model3.GLB1.GLB_INTR1.write(status,w_value,UVM_FRONTDOOR);

        p_sequencer.reg_model3.GLB1.GLB_INTR1.read(status,r_value,UVM_FRONTDOOR);
        if(r_value !== {56'h00_0000_0000_0000,2'b0,w_value[5 : 0]}) begin
            `uvm_error("case1_sequence","reg_model3.GLB1.GLB_INTR1 error! ")
        end *///I think interrupt mecahnism should not not verified in register model.

        p_sequencer.reg_model3.GLB1.GLB_ENABLE_ROW1.write(status,w_value,UVM_FRONTDOOR);                                                    //    ---
                                                                                                                                            //      |
        p_sequencer.reg_model3.GLB1.GLB_ENABLE_ROW1.read(status,r_value,UVM_FRONTDOOR);                                                     //      |
        if(r_value !== {48'h0000_0000_0000,w_value[15 : 0]}) begin                                                                          //      |
            `uvm_error("case1_sequence","reg_model3.GLB1.GLB_ENABLE_ROW1 error! ")                                                          //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |==== > GLB1
        p_sequencer.reg_model3.GLB1.GLB_ENABLE_COL1.write(status,w_value,UVM_FRONTDOOR);                                                    //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.GLB1.GLB_ENABLE_COL1.read(status,r_value,UVM_FRONTDOOR);                                                     //      |
        if(r_value !== {48'h0000_0000_0000,w_value[15 : 0]}) begin                                                                          //      |
            `uvm_error("case1_sequence","reg_model3.GLB1.GLB_ENABLE_COL1 error! ")                                                          //      |
        end                                                                                                                                 //    ---

        p_sequencer.reg_model3.BUF1.BUF_MASKX1.write(status,w_value,UVM_FRONTDOOR);                                                         //    ---
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASKX1.read(status,r_value,UVM_FRONTDOOR);                                                          //      |
        if(r_value !== {32'h0000_0000,w_value[31],15'b0,w_value[15 : 0]}) begin                                                             //      |
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASKX1 error! ")                                                               //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK01.write(status,w_value,UVM_FRONTDOOR);                                                         //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK01.read(status,r_value,UVM_FRONTDOOR);                                                          //      |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                                                               //      |
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK01 error! ")                                                               //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK11.write(status,w_value,UVM_FRONTDOOR);                                                         //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK11.read(status,r_value,UVM_FRONTDOOR);                                                          //      |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                                                               //      |
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK11 error! ")                                                               //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK21.write(status,w_value,UVM_FRONTDOOR);                                                         //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK21.read(status,r_value,UVM_FRONTDOOR);                                                          //      |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                                                               //      |
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK21 error! ")                                                               //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK31.write(status,w_value,UVM_FRONTDOOR);                                                         //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK31.read(status,r_value,UVM_FRONTDOOR);                                                          //      |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                                                               //      |
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK31 error! ")                                                               //      |
        end                                                                                                                                 //      |==== > BUF1
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK41.write(status,w_value,UVM_FRONTDOOR);                                                         //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK41.read(status,r_value,UVM_FRONTDOOR);                                                          //      |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                                                               //      |
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK41 error! ")                                                               //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK51.write(status,w_value,UVM_FRONTDOOR);                                                         //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK51.read(status,r_value,UVM_FRONTDOOR);                                                          //      |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                                                               //      |
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK51 error! ")                                                               //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK61.write(status,w_value,UVM_FRONTDOOR);                                                         //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK61.read(status,r_value,UVM_FRONTDOOR);                                                          //      |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                                                               //      |
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK61 error! ")                                                               //      |
        end                                                                                                                                 //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK71.write(status,w_value,UVM_FRONTDOOR);                                                         //      |
                                                                                                                                            //      |
        p_sequencer.reg_model3.BUF1.BUF_MASK71.read(status,r_value,UVM_FRONTDOOR);                                                          //      |
        if(r_value !== {32'h0000_0000,w_value[31 : 0]}) begin                                                                               //      |
            `uvm_error("case1_sequence","reg_model3.BUF1.BUF_MASK71 error! ")                                                               //      |
        end                                                                                                                                 //    ---
    endtask
endclass
`endif 