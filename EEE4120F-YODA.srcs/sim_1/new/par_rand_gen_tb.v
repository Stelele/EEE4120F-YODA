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

    reg clk, reset, enable_gen, mem_read;
    reg [31:0] seed;
    wire busy, mem_write;
    wire [31:0] dataOuta;
    wire [31:0] dataOutb;
    //wire [31:0] test;
    
    par_rand_gen base_par_rand_gen(
        .clk(clk),
        .reset(reset),
        .seed(seed),
        .count(1000),
        .enable(enable_gen),
        .busy(busy),
        .mem_write(mem_write),
        .dataOuta(dataOuta),
        .dataOutb(dataOutb),
        .mem_read(mem_read)
        //.test(test)
    );
    
    initial 
    begin
        $display("START RAND-GEN at T = %0t", $time);
        enable_gen = 1;
        reset = 1;
        clk = 0;
        seed = 32'b11010010111000001100001110011010;
        mem_read = 0;
        
        repeat(10)
        begin
            #5 clk = ~clk;
        end
        
        reset = 0;
        
    end
    always @(negedge busy) $display("DONE RAND-GEN at T = 0%t", $time);
    always @(negedge mem_write) begin
        if (!busy) begin
            $display("DONE Writing to Memory at T = 0%t", $time);
            mem_read <= 1;
        end
    end
    always
        #5 clk = ~clk;
        
        
endmodule