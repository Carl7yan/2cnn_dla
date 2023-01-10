// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      async_fifo.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Author(s):
//                  Haozhe.Zhu (zhutmost@outlook.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

`resetall

`include "INC_global.sv"

module async_fifo
#(
    parameter DW = 8,
    parameter AW = 4,
    parameter FWFT = 0 // First Word Fall Through
)(
    input  logic            wclk,
    input  logic            wrst,
    input  logic            wen,
    input  logic [DW-1:0]   wdata,
    output logic            wfull,

    input  logic            rclk,
    input  logic            rrst,
    input  logic            ren,
    output logic [DW-1:0]   rdata,
    output logic            rempty
);

    localparam DEPTH = 1 << AW;

    logic [DW-1:0] mem [0:DEPTH-1];

    logic [AW-1:0]  raddr;
    logic [AW-1:0]  waddr;
    logic [AW:0]    rptr, rq1_wptr, rq2_wptr;
    logic [AW:0]    wptr, wq1_rptr, wq2_rptr;

    logic [AW:0]    rbin, rgraynext, rbinnext;
    logic [AW:0]    wbin, wgraynext, wbinnext;

    logic wfull_val;

    always_ff @ (posedge wclk or posedge wrst) begin
        if (wrst) {wq2_rptr, wq1_rptr} <= '0;
        else      {wq2_rptr, wq1_rptr} <= {wq1_rptr, rptr};
    end

    always_ff @ (posedge rclk or posedge rrst) begin
        if (rrst) {rq2_wptr, rq1_wptr} <= '0;
        else      {rq2_wptr, rq1_wptr} <= {rq1_wptr, wptr};
    end

    generate
        if (FWFT == 1) begin: gen_fifo_rdata
            assign rdata = mem[raddr];
        end
        else begin
            always_ff @ (posedge rclk or posedge rrst) begin
                if (rrst) rdata <= '0;
                else if (ren && ! rempty) rdata <= mem[raddr];
            end
        end
    endgenerate

    always_ff @ (posedge wclk) begin
        if (wen && ! wfull) mem[waddr] <= wdata;
    end

    // gray code pointer
    always_ff @ (posedge rclk or posedge rrst) begin
        if (rrst) {rbin, rptr} <= '0;
        else      {rbin, rptr} <= {rbinnext, rgraynext};
    end

    // Memory read-address pointer (okay to use binary to address memory)
    assign raddr     = rbin[AW-1:0];
    assign rbinnext  = rbin + (ren & ~ rempty);
    assign rgraynext = (rbinnext >> 1) ^ rbinnext;

    always_ff @ (posedge rclk or posedge rrst) begin
        if (rrst) rempty <= 1'b1;
        else      rempty <= rgraynext == rq2_wptr;
    end

    // gray code pointer
    always_ff @ (posedge wclk or posedge wrst) begin
        if (wrst) {wbin, wptr} <= '0;
        else      {wbin, wptr} <= {wbinnext, wgraynext};
    end

    // Memory write-address pointer (okay to use binary to address memory)
    assign waddr     = wbin[AW-1:0];
    assign wbinnext  = wbin + (wen & ~ wfull);
    assign wgraynext = (wbinnext >> 1) ^ wbinnext;

    //------------------------------------------------------------------
    // Simplified version of the three necessary full-tests:
    // assign wfull_val = ((wgnext[AW]     != wq2_rptr[AW])
    //                  && (wgnext[AW-1]   != wq2_rptr[AW-1])
    //                  && (wgnext[AW-2:0] == wq2_rptr[AW-2:0]));
    //------------------------------------------------------------------
    assign wfull_val = wgraynext == {~ wq2_rptr[AW:AW-1], wq2_rptr[AW-2:0]};

    always_ff @ (posedge wclk or posedge wrst) begin
        if (wrst) wfull <= 1'b0;
        else      wfull <= wfull_val;
    end

endmodule: async_fifo
