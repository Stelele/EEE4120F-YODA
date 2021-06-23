`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2021 03:34:04 AM
// Design Name: 
// Module Name: rand_gen_tb
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


module rand_gen_tb();
    reg clk, reset, enable, mode;
    reg [31:0] din;
    wire [31:0] dataOut;

    rand_gen base_rand(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .mode(mode),
        .din(din),
        .dataOut(dataOut)
    );
    
    initial
    begin
        // initialize module and set seed values
        clk = 0;
        reset = 1;
        enable = 1;
        
        #5 clk = ~clk;    
        #5 clk = ~clk;
        
        reset = 0;
        din = 32'b11010010111000001100001110011010;
        mode = 1;
        
        // toggle a few times to ensure loading occured
        repeat(10)
        begin
            #5 clk = ~clk;
        end
        
        // start generating random numbers
        #5 mode = 0;
        
        repeat(900)
        begin
            #5 clk = ~clk;
        end
        
    end
endmodule
