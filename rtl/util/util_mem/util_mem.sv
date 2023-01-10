// +FHDR========================================================================
//  License:
//      Copyright (c) 2017 Authors and BCRC. All rights reserved.
// =============================================================================
//  File Name:      util_mem.sv
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

module sram_sp_16wx8192d (
    input  logic            clk,
    input  logic [12:0]     addr,
    input  logic            wen,
    input  logic [15:0]     wdata,
    input  logic [15:0]     wmask,
    input  logic            ren,
    output logic [15:0]     rdata
);

    localparam integer MEM_DEPTH  = 8192;
    localparam integer ADDR_WIDTH = 13;

    logic [15:0]    mem [0:MEM_DEPTH-1];

    always_ff @ (posedge clk) begin
        if (ren) rdata <= mem[addr[ADDR_WIDTH-1:0]];
    end

    always_ff @ (posedge clk) begin
        if (wen) mem[addr[ADDR_WIDTH-1:0]] <= wdata;
    end

endmodule: sram_sp_16wx8192d

module sram_sp_16wx1296d (
    input  logic            clk,
    input  logic [10:0]     addr,
    input  logic            wen,
    input  logic [15:0]     wdata,
    input  logic [15:0]     wmask,
    input  logic            ren,
    output logic [15:0]     rdata
);

    localparam integer MEM_DEPTH  = 1296;
    localparam integer ADDR_WIDTH = 11;

    logic [15:0]    mem [0:MEM_DEPTH-1];

    always_ff @ (posedge clk) begin
        if (ren) rdata <= mem[addr[ADDR_WIDTH-1:0]];
    end

    always_ff @ (posedge clk) begin
        if (wen) mem[addr[ADDR_WIDTH-1:0]] <= wdata;
    end

endmodule: sram_sp_16wx1296d

module sram_sp_256wx16d (
    input  logic            clk,
    input  logic [3:0]      addr,
    input  logic            wen,
    input  logic [255:0]    wdata,
    input  logic [255:0]    wmask,
    input  logic            ren,
    output logic [255:0]    rdata
);

    localparam integer MEM_DEPTH  = 16;
    localparam integer ADDR_WIDTH = 4;

    logic [255:0]   mem [0:MEM_DEPTH-1];

    always_ff @ (posedge clk) begin
        if (ren) rdata <= mem[addr[ADDR_WIDTH-1:0]];
    end

    always_ff @ (posedge clk) begin
        if (wen) mem[addr[ADDR_WIDTH-1:0]] <= wdata;
    end

endmodule: sram_sp_256wx16d

module sram_sp_16wx16d (
    input  logic            clk,
    input  logic [3:0]      addr,
    input  logic            wen,
    input  logic [15:0]     wdata,
    input  logic [15:0]     wmask,
    input  logic            ren,
    output logic [15:0]     rdata
);

    localparam integer MEM_DEPTH  = 16;
    localparam integer ADDR_WIDTH = 4;

    logic [15:0]    mem [0:MEM_DEPTH-1];

    always_ff @ (posedge clk) begin
        if (ren) rdata <= mem[addr[ADDR_WIDTH-1:0]];
    end

    always_ff @ (posedge clk) begin
        if (wen) mem[addr[ADDR_WIDTH-1:0]] <= wdata;
    end

endmodule: sram_sp_16wx16d
