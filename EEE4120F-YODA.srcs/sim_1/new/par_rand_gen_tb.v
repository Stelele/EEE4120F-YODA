`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2021 07:42:20 PM
// Design Name: 
// Module Name: par_rand_gen_tb
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


module par_rand_gen_tb();

    reg clk, reset, enable_gen;
    reg [31:0] seed;
    wire [31:0] dataOut[0:9];
    
    par_rand_gen base_par_rand_gen(
        .clk(clk),
        .reset(reset),
        .seed(seed),
        .enable(enable_gen),
        .dataOut0(dataOut[0]),
        .dataOut1(dataOut[1]),
        .dataOut2(dataOut[2]),
        .dataOut3(dataOut[3]),
        .dataOut4(dataOut[4]),
        .dataOut5(dataOut[5]),
        .dataOut6(dataOut[6]),
        .dataOut7(dataOut[7]),
        .dataOut8(dataOut[8]),
        .dataOut9(dataOut[9])
    );
    
    initial 
    begin
        enable_gen = 1;
        reset = 1;
        clk = 0;
        seed = 32'b11010010111000001100001110011010;
        
        repeat(10)
        begin
            #5 clk = ~clk;
        end
        
        reset = 0;
        
    end
    
    always
        #5 clk = ~clk;
        
endmodule
