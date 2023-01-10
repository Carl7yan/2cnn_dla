// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      axi_hzz_bridge.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Repository:     http://10.137.20.23/bcrc-soc/tj3.git
//  Author(s):
//                  Haozhe.Zhu (zhutmost@outlook.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

`resetall

`include "INC_global.sv"

module axi_hzz_bridge
    import PKG_axi :: *;
#(
    parameter integer   AXI_DW   = 32,
    parameter integer   AXI_AW   = 32,
    parameter integer   AXI_IW   = 1,
    parameter integer   AXI_SW   = AXI_DW >> 3
    // parameter integer   AXI_AWUW = 0,
    // parameter integer   AXI_ARUW = 0,
    // parameter integer   AXI_WUW  = 0,
    // parameter integer   AXI_RUW  = 0,
    // parameter integer   AXI_BUW  = 0
)(
// =============================================================================
//                              AXI ports

    //  global signals
    input  wire  S_AXI_ACLK,
    input  wire  S_AXI_ARESETN,

    //  write address channel
    input  wire  [AXI_IW-1:0]   S_AXI_AWID,     // write address id
    input  wire  [AXI_AW-1:0]   S_AXI_AWADDR,   // write address
    input  wire  [7:0]          S_AXI_AWLEN,    // burst length
    input  wire  [2:0]          S_AXI_AWSIZE,   // burst size
    input  wire  [1:0]          S_AXI_AWBURST,  // burst type
    input  wire                 S_AXI_AWLOCK,   // lock type, NC
    input  wire  [3:0]          S_AXI_AWCACHE,  // memory type, NC
    input  wire  [2:0]          S_AXI_AWPROT,   // protection type, NC
    input  wire  [3:0]          S_AXI_AWQOS,    // quality of service, NC
    input  wire  [3:0]          S_AXI_AWREGION, // Region identifier, NC
    // input  wire  [AXI_AWUW-1:0] S_AXI_AWUSER,   // optional user-defined signal, NC
    input  wire                 S_AXI_AWVALID,  // write address valid
    output wire                 S_AXI_AWREADY,  // write address ready

    //  write data channel
    input  wire  [AXI_DW-1:0]   S_AXI_WDATA,    // write data
    input  wire  [AXI_SW-1:0]   S_AXI_WSTRB,    // write strobes
    input  wire                 S_AXI_WLAST,    // write last
    // input  wire  [AXI_WUW-1:0]  S_AXI_WUSER,    // optional user-defined signal, NC
    input  wire                 S_AXI_WVALID,   // write valid
    output wire                 S_AXI_WREADY,   // write ready

    //  buffered write response channel
    output wire  [AXI_IW-1:0]   S_AXI_BID,      // response id tag
    output wire  [1:0]          S_AXI_BRESP,    // write response
    // output wire  [AXI_BUW-1:0]  S_AXI_BUSER,    // optional user-defined signal
    output wire                 S_AXI_BVALID,   // write response valid
    input  wire                 S_AXI_BREADY,   // response ready

    //  read address channel
    input  wire  [AXI_IW-1:0]   S_AXI_ARID,     // read address id
    input  wire  [AXI_AW-1:0]   S_AXI_ARADDR,   // read address
    input  wire  [7:0]          S_AXI_ARLEN,    // burst length
    input  wire  [2:0]          S_AXI_ARSIZE,   // burst size
    input  wire  [1:0]          S_AXI_ARBURST,  // burst type
    input  wire                 S_AXI_ARLOCK,   // lock type, NC
    input  wire  [3:0]          S_AXI_ARCACHE,  // memory type, NC
    input  wire  [2:0]          S_AXI_ARPROT,   // protection type, NC
    input  wire  [3:0]          S_AXI_ARQOS,    // quality of service, NC
    input  wire  [3:0]          S_AXI_ARREGION, // region identifier, NC
    // input  wire  [AXI_ARUW-1:0] S_AXI_ARUSER,   // optional user-defined signal, NC
    input  wire                 S_AXI_ARVALID,  // write address valid
    output wire                 S_AXI_ARREADY,  // read address ready

    //  read data channel
    output wire  [AXI_IW-1:0]   S_AXI_RID,      // read id tag
    output wire  [AXI_DW-1:0]   S_AXI_RDATA,    // read data
    output wire  [1:0]          S_AXI_RRESP,    // read response
    output wire                 S_AXI_RLAST,    // read last
    // output wire  [AXI_RUW-1:0]  S_AXI_RUSER,    // optional user-defined signal
    output wire                 S_AXI_RVALID,   // read valid
    input  wire                 S_AXI_RREADY,   // read ready

// =============================================================================
//                                  HZZ ports

    output logic                hzzm_mosi_clk,
    input  logic                hzzm_miso_clk,
    output logic                hzzm_mosi_valid,
    input  logic                hzzm_miso_valid,
    output logic [AXI_DW-1:0]   hzzm_mosi,
    input  logic [AXI_DW-1:0]   hzzm_miso,
    output logic                hzzm_mosi_en
);

// =============================================================================
//                              signal declaration

    // AXI4FULL signals
    logic [AXI_AW-1:0]  axi_awaddr;
    logic               axi_awready;
    logic               axi_wready;
    logic [1:0]         axi_bresp;
    // logic [AXI_BUW-1:0] axi_buser;
    logic               axi_bvalid;
    logic [AXI_AW-1:0]  axi_araddr;
    logic               axi_arready;
    logic [AXI_DW-1:0]  axi_rdata;
    logic [1:0]         axi_rresp;
    logic               axi_rlast;
    // logic [AXI_RUW-1:0] axi_ruser;
    logic               axi_rvalid;
    logic               aw_wrap_en; // wrap boundary and enables wrapping
    logic               ar_wrap_en; // wrap boundary and enables wrapping

    // aw_wrap_size is the size of the write transfer, the write address wraps
    // to a lower address if upper address limit is reached

    logic [31:0]        aw_wrap_size ;
    // ar_wrap_size is the size of the read transfer, the read address wraps
    // to a lower address if upper address limit is reached
    logic [31:0]        ar_wrap_size ;

    logic           axi_awv_awr_flag; // the presence of write address valid
    logic           axi_arv_arr_flag; // the presence of read address valid

    logic [7:0]     axi_awlen_cntr;
    logic [7:0]     axi_arlen_cntr;
    axi_axburst_e   axi_arburst, axi_arburst_int;
    axi_axburst_e   axi_awburst, axi_awburst_int;
    logic [7:0]     axi_arlen;
    logic [7:0]     axi_awlen;

    assign axi_awburst_int = S_AXI_AWBURST == 2'b00 ? AXI_AxBURST_FIXED :
                            (S_AXI_AWBURST == 2'b01 ? AXI_AxBURST_INCR :
                             AXI_AxBURST_WRAP);
    assign axi_arburst_int = S_AXI_ARBURST == 2'b00 ? AXI_AxBURST_FIXED :
                            (S_AXI_ARBURST == 2'b01 ? AXI_AxBURST_INCR :
                             AXI_AxBURST_WRAP);

    //local parameter for addressing 32 bit / 64 bit AXI_DW
    //ADDR_LSB is used for addressing 32/64 bit registers/memories
    //ADDR_LSB = 2 for 32 bits (n downto 2)
    //ADDR_LSB = 3 for 42 bits (n downto 3)
    localparam integer ADDR_LSB = (AXI_DW/32)+ 1;
    localparam integer OPT_MEM_ADDR_BITS = 8;

    logic [OPT_MEM_ADDR_BITS-1:0]   mem_address;
    reg   [AXI_DW-1:0]              mem_data_out;

    logic [AXI_DW-1:0]  rdbuf_rdata;
    logic               rdbuf_rempty;
    logic               rdbuf_ren;

// =============================================================================
//                              AXI protocol logic

    //  AXI I/O Connections assignments
    assign S_AXI_AWREADY = axi_awready;
    assign S_AXI_WREADY  = axi_wready;
    assign S_AXI_BRESP   = axi_bresp;
    // assign S_AXI_BUSER   = axi_buser;
    assign S_AXI_BVALID  = axi_bvalid;
    assign S_AXI_ARREADY = axi_arready;
    assign S_AXI_RDATA   = axi_rdata;
    assign S_AXI_RRESP   = axi_rresp;
    assign S_AXI_RLAST   = axi_rlast;
    // assign S_AXI_RUSER   = axi_ruser;
    assign S_AXI_RVALID  = axi_rvalid;
    assign S_AXI_BID     = S_AXI_AWID;
    assign S_AXI_RID     = S_AXI_ARID;
    assign aw_wrap_size  = (AXI_DW/8 * (axi_awlen));
    assign ar_wrap_size  = (AXI_DW/8 * (axi_arlen));
    assign aw_wrap_en    = ((axi_awaddr & aw_wrap_size) == aw_wrap_size)? 1'b1: 1'b0;
    assign ar_wrap_en    = ((axi_araddr & ar_wrap_size) == ar_wrap_size)? 1'b1: 1'b0;

    // axi_awready is asserted for one S_AXI_ACLK clock cycle when both
    // S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
    // de-asserted when reset is low.
    always_ff @(posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin: b_awready_gen
        if (~ S_AXI_ARESETN) begin
            axi_awready <= 1'b0;
            axi_awv_awr_flag <= 1'b0;
        end
        else begin
            if (~ axi_awready && S_AXI_AWVALID && ~ axi_awv_awr_flag && ~ axi_arv_arr_flag) begin
                // slave is ready to accept an address and associated control signals
                axi_awready <= 1'b1;
                axi_awv_awr_flag  <= 1'b1; // used for generation of bresp and bvalid
            end
            else if (S_AXI_WLAST && axi_wready) begin
            // preparing to accept next address after current write burst tx completion
              axi_awv_awr_flag  <= 1'b0;
            end
            else begin
              axi_awready <= 1'b0;
            end
        end
    end: b_awready_gen

    // This process is used to latch the address when both
    // S_AXI_AWVALID and S_AXI_WVALID are valid.
    always_ff @ (posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin: b_awaddr_latch
        if (~ S_AXI_ARESETN) begin
            axi_awaddr     <= '0;
            axi_awlen_cntr <= '0;
            axi_awburst    <= AXI_AxBURST_FIXED;
            axi_awlen      <= '0;
        end
        else begin
            if (~ axi_awready && S_AXI_AWVALID && ~ axi_awv_awr_flag) begin
                // address latching
                axi_awaddr <= S_AXI_AWADDR[AXI_AW - 1:0];
                axi_awburst <= axi_awburst_int;
                axi_awlen <= S_AXI_AWLEN;
                // start address of transfer
                axi_awlen_cntr <= 0;
            end
            else if((axi_awlen_cntr <= axi_awlen) && axi_wready && S_AXI_WVALID) begin
                axi_awlen_cntr <= axi_awlen_cntr + 1;
                case (axi_awburst)
                    AXI_AxBURST_FIXED: begin // fixed burst
                        // The write address for all the beats in the transaction are fixed
                        axi_awaddr <= axi_awaddr;
                        //for awsize = 4 bytes (010)
                    end
                    AXI_AxBURST_INCR: begin // incremental burst
                        // The write address for all the beats in the transaction are increments by awsize
                        axi_awaddr[AXI_AW - 1:ADDR_LSB] <= axi_awaddr[AXI_AW - 1:ADDR_LSB] + 1;
                        //awaddr aligned to 4 byte boundary
                        axi_awaddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}};
                        //for awsize = 4 bytes (010)
                    end
                    AXI_AxBURST_WRAP: begin // wrapping burst
                        // The write address wraps when the address reaches wrap boundary
                        if (aw_wrap_en) begin
                            axi_awaddr <= (axi_awaddr - aw_wrap_size);
                        end
                        else begin
                            axi_awaddr[AXI_AW-1:ADDR_LSB] <= axi_awaddr[AXI_AW-1:ADDR_LSB] + 1;
                            axi_awaddr[ADDR_LSB-1:0]  <= {ADDR_LSB{1'b0}};
                        end
                    end
                    default: begin //reserved (incremental burst for example)
                        axi_awaddr <= axi_awaddr[AXI_AW - 1:ADDR_LSB] + 1;
                        //for awsize = 4 bytes (010)
                    end
                endcase
            end
        end
    end: b_awaddr_latch

    // axi_wready is asserted for one S_AXI_ACLK clock cycle when both
    // S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is
    // de-asserted when reset is low.
    always @( posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin: b_wready_gen
        if (~ S_AXI_ARESETN) begin
            axi_wready <= 1'b0;
        end
        else begin
            if ( ~axi_wready && S_AXI_WVALID && axi_awv_awr_flag) begin
                // slave can accept the write data
                axi_wready <= 1'b1;
            end
            //else if (~axi_awv_awr_flag)
            else if (S_AXI_WLAST && axi_wready) begin
                axi_wready <= 1'b0;
            end
        end
    end: b_wready_gen

    // The write response and response valid signals are asserted by the slave
    // when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.
    // This marks the acceptance of address and indicates the status of
    // write transaction.
    always @( posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin: b_wresp_gen
        if (~ S_AXI_ARESETN) begin
          axi_bvalid <= 0;
          axi_bresp <= 2'b0;
          // axi_buser <= 0;
        end
        else begin
            if (axi_awv_awr_flag && axi_wready && S_AXI_WVALID && ~axi_bvalid && S_AXI_WLAST) begin
                axi_bvalid <= 1'b1;
                axi_bresp  <= 2'b0;
                // 'OKAY' response
            end
            else begin
                if (S_AXI_BREADY && axi_bvalid) begin
                    //check if bready is asserted while bvalid is high)
                    //(there is a possibility that bready is always asserted high)
                    axi_bvalid <= 1'b0;
                end
            end
        end
     end: b_wresp_gen

    // axi_arready is asserted for one S_AXI_ACLK clock cycle when S_AXI_ARVALID
    // is asserted. axi_awready is de-asserted when reset (active low) is
    // asserted. The read address is also latched when S_AXI_ARVALID is
    // asserted. axi_araddr is reset to zero on reset assertion.
    always @ (posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin: b_arready_gen
        if (~ S_AXI_ARESETN) begin
          axi_arready <= 1'b0;
          axi_arv_arr_flag <= 1'b0;
        end
        else begin
            if (~ axi_arready && S_AXI_ARVALID && ~ axi_awv_awr_flag && ~ axi_arv_arr_flag) begin
                axi_arready <= 1'b1;
                axi_arv_arr_flag <= 1'b1;
            end
            else if (axi_rvalid && S_AXI_RREADY && axi_arlen_cntr == axi_arlen) begin
                // preparing to accept next address after current read completion
                axi_arv_arr_flag  <= 1'b0;
            end
            else begin
                axi_arready <= 1'b0;
            end
        end
    end: b_arready_gen

    //  This process is used to latch the address when both S_AXI_ARVALID
    // and S_AXI_RVALID are valid.
    always @ (posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin: b_araddr_latch
        if (~ S_AXI_ARESETN) begin
            axi_araddr     <= '0;
            axi_arlen_cntr <= '0;
            axi_arburst    <= AXI_AxBURST_FIXED;
            axi_arlen      <= '0;
            // axi_rlast      <= 1'b0;
            // axi_ruser      <= '0;
        end
        else begin
            if (~ axi_arready && S_AXI_ARVALID && ~ axi_arv_arr_flag) begin
                // address latching
                axi_araddr     <= S_AXI_ARADDR[AXI_AW-1:0]; // start address of transfer
                axi_arburst    <= axi_arburst_int;
                axi_arlen      <= S_AXI_ARLEN;
                axi_arlen_cntr <= '0;
                // axi_rlast      <= 1'b0;
            end
            else if ((axi_arlen_cntr <= axi_arlen) && axi_rvalid && S_AXI_RREADY) begin
                axi_arlen_cntr <= axi_arlen_cntr + 1;
                // axi_rlast <= 1'b0;

                case (axi_arburst)
                    AXI_AxBURST_FIXED: begin
                        // The read address for all the beats in the transaction are fixed
                        axi_araddr <= axi_araddr;
                        //for arsize = 4 bytes (010)
                    end
                    AXI_AxBURST_INCR: begin
                        // The read address for all the beats in the transaction are increments by awsize
                        axi_araddr[AXI_AW-1:ADDR_LSB] <= axi_araddr[AXI_AW-1:ADDR_LSB] + 1;
                        //araddr aligned to 4 byte boundary
                        axi_araddr[ADDR_LSB-1:0] <= '0;
                        //for awsize = 4 bytes (010)
                    end
                    AXI_AxBURST_WRAP: begin
                        // The read address wraps when the address reaches wrap boundary
                        if (ar_wrap_en) begin
                            axi_araddr <= (axi_araddr - ar_wrap_size);
                        end
                        else begin
                            axi_araddr[AXI_AW-1:ADDR_LSB] <= axi_araddr[AXI_AW-1:ADDR_LSB] + 1;
                            //araddr aligned to 4 byte boundary
                            axi_araddr[ADDR_LSB-1:0] <= '0;
                        end
                    end
                    default: begin //reserved (incremental burst for example)
                        axi_araddr <= axi_araddr[AXI_AW-1:ADDR_LSB] + 1;
                        //for arsize = 4 bytes (010)
                    end
                endcase
            end
            // else if((axi_arlen_cntr == axi_arlen) && ~ axi_rlast && axi_arv_arr_flag) begin
            //     axi_rlast <= 1'b1;
            // end
            // else if (S_AXI_RREADY) begin
            //     axi_rlast <= 1'b0;
            // end
        end
    end: b_araddr_latch

    // axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both
    // S_AXI_ARVALID and axi_arready are asserted. The slave registers data are
    // available on the axi_rdata bus at this instance. The assertion of
    // axi_rvalid marks the validity of read data on the bus and axi_rresp
    // indicates the status of read transaction.axi_rvalid is deasserted on
    // reset (active low). axi_rresp and axi_rdata are cleared to zero on reset
    // (active low).
    // always @( posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin: b_rvalid_gen
    //     if (~ S_AXI_ARESETN) begin
    //         axi_rvalid <= 0;
    //         axi_rresp  <= 0;
    //     end
    //     else begin
    //         if (axi_arv_arr_flag && ~ axi_rvalid) begin
    //             axi_rvalid <= 1'b1;
    //             axi_rresp  <= 2'b0; // 'OKAY' response
    //         end
    //         else if (axi_rvalid && S_AXI_RREADY) begin
    //             axi_rvalid <= 1'b0;
    //         end
    //     end
    // end: b_rvalid_gen

// =============================================================================
//                              HZZ master

    always @ (posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin: b_hzzm_mosi
        if (~ S_AXI_ARESETN) begin
            hzzm_mosi       <= '0;
            hzzm_mosi_valid <= 1'b0;
        end
        else begin
            if (axi_awready & S_AXI_AWVALID) begin // control phase
                if (axi_awburst == AXI_AxBURST_INCR) begin
                    hzzm_mosi[AXI_DW-1-:10] <= {2'b10, axi_awlen};
                end
                else begin
                    hzzm_mosi[AXI_DW-1-:10] <= {2'b11, axi_awlen};
                end
                hzzm_mosi[AXI_DW-11:0]  <= axi_awaddr[AXI_AW-1:2];
                hzzm_mosi_valid         <= 1'b1;
            end
            else if (axi_arready & S_AXI_ARVALID) begin
                if (axi_arburst == AXI_AxBURST_INCR) begin
                    hzzm_mosi[AXI_DW-1-:10] <= {2'b00, axi_arlen};
                end
                else begin
                    hzzm_mosi[AXI_DW-1-:10] <= {2'b01, axi_arlen};
                end
                hzzm_mosi[AXI_DW-11:0]  <= axi_araddr[AXI_AW-1:2];
                hzzm_mosi_valid         <= 1'b1;
            end
            else if (axi_wready && S_AXI_WVALID) begin
                hzzm_mosi       <= S_AXI_WDATA;
                hzzm_mosi_valid <= 1'b1;
            end
            else begin
                hzzm_mosi       <= '0;
                hzzm_mosi_valid <= 1'b0;
            end
        end
    end: b_hzzm_mosi

    async_fifo #(
        .DW     (32),
        .AW     (5)
    ) hzzm_read_buf (
        .wclk   (hzzm_miso_clk),
        .wrst   (~ S_AXI_ARESETN),
        .wen    (hzzm_miso_valid),
        .wdata  (hzzm_miso),
        .wfull  (),

        .rclk   (S_AXI_ACLK),
        .rrst   (~ S_AXI_ARESETN),
        .ren    (rdbuf_ren),
        .rdata  (rdbuf_rdata),
        .rempty (rdbuf_rempty)
    );

    assign rdbuf_ren = (axi_rvalid && S_AXI_RREADY && ~ rdbuf_rempty)
                    || (~ axi_rvalid && ~ rdbuf_rempty);

    always @ (posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin: b_rvalid
        if (~ S_AXI_ARESETN) begin
            axi_rvalid <= 1'b0;
            axi_rresp  <= 2'b0;
        end
        else begin
            if (~ axi_rvalid && ~ rdbuf_rempty) begin
                axi_rvalid <= 1'b1;
                axi_rresp  <= 2'b0; // OKAY response
            end
            else if (axi_rvalid && S_AXI_RREADY && ~ rdbuf_rempty) begin
                axi_rvalid <= 1'b1;
                axi_rresp  <= 2'b0; // OKAY response
            end
            else if (axi_rvalid && S_AXI_RREADY && rdbuf_rempty) begin
                axi_rvalid <= 1'b0;
            end
        end
    end: b_rvalid

    assign axi_rlast = axi_arlen_cntr == axi_arlen && axi_rvalid && axi_arv_arr_flag;

    assign axi_rdata = axi_rvalid ? rdbuf_rdata : '0;

    logic axi_arv_arr_flag_d1, axi_arv_arr_flag_d2;

    always @ (posedge S_AXI_ACLK or negedge S_AXI_ARESETN) begin
        if (~ S_AXI_ARESETN) begin
            axi_arv_arr_flag_d1 <= 1'b0;
            axi_arv_arr_flag_d2 <= 1'b0;
        end
        else begin
            axi_arv_arr_flag_d1 <= axi_arv_arr_flag;
            axi_arv_arr_flag_d2 <= axi_arv_arr_flag_d1;
        end
    end

    assign hzzm_mosi_en = ~ axi_arv_arr_flag_d2;
    assign hzzm_mosi_clk = S_AXI_ACLK;

endmodule: axi_hzz_bridge
