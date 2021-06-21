`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2021 02:43:59
// Design Name: Full Duplex, Dual Port Ram
// Module Name: ram_dp_fp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ram_dp_fp(
    clk     , // clock input
    cs      , // chip select
    size    , // Required ram size
    a_we    , // channel A write enable
    a_oe    , // channel A output enable
    a_addr  , // channel A address
    a_data  , // channel A inout data
    b_we    , // channel B write enable
    b_oe    , // channel B output enable
    b_addr  , // channel B address
    b_data    // channel B inout data
    );
    
    //----------Memory parameters------------------
    parameter DATA_WIDTH = 32;      // 32-bit word size
    parameter ADDRESS_WIDTH = 32;   // 32-bit addresses
    parameter RAM_DEPTH = 100;      // Maximum allowed random numbers
    
    //----------Input Ports------------------------
    input clk, cs;
    input a_we, a_oe, b_we, b_oe;
    input [ADDRESS_WIDTH-1:0] a_addr, b_addr, size;
    
    //----------Bidirectional I/O ports------------
    inout [DATA_WIDTH-1:0] a_data, b_data;
    
    //----------Private memory registers-----------
    reg [DATA_WIDTH-1:0] mem [0:RAM_DEPTH-1];
    reg [DATA_WIDTH-1:0] data_a_out;
    reg [DATA_WIDTH-1:0] data_b_out;
    
    //----------Read inputs------------------------
    always@ (posedge clk) begin
        if (cs) begin
            if (a_we)
                mem[a_addr] <= a_data;
            if (b_we)
                mem[b_addr] <= b_data;
        end
    end
    
    //---------Read Outputs-------------
    // Read A
    always@ (posedge clk) begin
        if (cs && a_oe)
            data_a_out <= mem[a_addr];
        else
            data_a_out <= 0;
    end
    assign a_data = (cs && a_oe && !a_we) ? data_a_out : 32'bz;
    
    // Read B
    always@ (posedge clk) begin
        if (cs && b_oe)
            data_b_out <= mem[b_addr];
        else
            data_b_out <= 0;
    end
    assign b_data = (cs && b_oe && !b_we) ? data_b_out : 32'bz;
     
endmodule
