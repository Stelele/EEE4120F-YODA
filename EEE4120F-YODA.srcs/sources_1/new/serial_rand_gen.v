`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2021 06:34:49
// Design Name: 
// Module Name: serial_rand_gen
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


module serial_rand_gen(
    input clk, reset,
    input [31:0] seed,
    input [31:0] start_addr,
    input [31:0] count,
    input active,
    output busy,
    output [31:0] dout
    );
    
    reg mode;
    
    rand_gen gen(.clk(clk), .reset(reset), .din(initialSeed), .enable(enable), .mode(modeSeeder), .dataOut(seedNumber));
    
endmodule
