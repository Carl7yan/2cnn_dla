// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      sync_fifo.sv
//  Project Name:   TANJI-3 Deep Learning Accelerator
//  Author(s):
//                  Haozhe.Zhu (zhutmost@outlook.com)
//  Organization:   Brain-Chip Research Center (BCRC), Fudan University
//  Description:
//      -
// -FHDR========================================================================

`resetall

`include "INC_global.sv"

module sync_fifo #(
    parameter integer DW = 32,
    parameter integer AW = 8
)(
    input  logic        clk,
    input  logic        rst,

    input  logic            wen,
    input  logic [DW-1:0]   wdata,
    output logic            werr,
    output logic            wfull,

    input  logic            ren,
    output logic [DW-1:0]   rdata,
    output logic            rerr,
    output logic            rempty,

    output logic [AW:0]     data_cnt
);

    localparam integer DEPTH = 1 << AW;

    logic [AW-1:0]  waddr;
    logic [AW-1:0]  raddr;

    logic [DW-1:0] fifo_mem [DEPTH-1:0];

    always @(posedge clk) begin: b_fifo_mem
        if (wen & (~ wfull))
            fifo_mem[waddr] <= wdata;
    end: b_fifo_mem

    always @(posedge clk or posedge rst) begin: b_fifo_rdata
        if (rst)
            rdata <= '0;
        else if (ren & (~ rempty))
            rdata <= fifo_mem[raddr];
    end: b_fifo_rdata

    //  Read address increase when read enable AND Not empty;
    always @(posedge clk or posedge rst) begin: b_fifo_raddr
        if (rst)
            raddr <= '0;
        else if (ren & (~ rempty))
            raddr <= raddr + 1'b1;
    end: b_fifo_raddr

    //  Write address increase when write enable AND Not full.
    always @(posedge clk or posedge rst) begin: b_fifo_waddr
        if (rst)
            waddr <= '0;
        else if (wen & (~ wfull))
            waddr <= waddr + 1'b1;
    end: b_fifo_waddr

    always @(posedge clk or posedge rst) begin: b_fifo_data_cnt
        if (rst)
            data_cnt <= '0;
        else if (wen & (~ wfull) & (~(ren & (~ rempty))))
            //  Valid Write Only, increase data cnt;
            data_cnt <= data_cnt + 1'b1;
        else if (ren & (~ rempty) & (~(wen & (~ wfull))))
            //  Valid Read Only, decrease data cnt;
            data_cnt <= data_cnt - 1'b1;
    end: b_fifo_data_cnt

    assign rempty = | data_cnt == 1'b0;
    assign rerr   = rempty & ren;

    assign wfull = data_cnt == {1'b1, {(AW){1'b0}}};
    assign werr  = wfull & wen;

endmodule: sync_fifo
