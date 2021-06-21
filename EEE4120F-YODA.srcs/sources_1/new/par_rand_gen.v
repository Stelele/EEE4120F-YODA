`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2021 06:30:32 PM
// Design Name: 
// Module Name: par_rand_gen
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


module par_rand_gen(
    input clk,
    input reset,
    input [31:0] seed, count,
    input enable,
    output reg busy, mem_write,
    output reg[31:0] dataOut
    //output reg[31:0] test
    );
    
    
    reg modeSeeder;
    reg mode;
    reg resetTriggered;
    reg [4:0] waitPeriod;
    reg [31:0] seedingValues[0:9];
    wire [31:0] seedNumber;
    reg [31:0] initialSeed;
    reg [4:0] currentPos;
    reg [31:0] width;
    parameter [31:0] max_width = 10000;
    wire [31:0] d_out [0:9];
    reg [31:0] mem_out [0:max_width-1];
    reg [31:0] i = 0; // Array position incrementer
    reg [31:0] j = 0;
    reg [3:0] k = 0;
    
    
    
    // Helper registers to read from the mules
    
    
    // seeding module to generate seed values for rest of module implementations
    rand_gen seeder_gen(.clk(clk), .reset(reset), .din(initialSeed), .enable(enable), .mode(modeSeeder), .dataOut(seedNumber));
    
    // pararlel modl seed generators
    rand_gen serises0(.clk(clk), .reset(reset), .din(seedingValues[0]), .enable(enable), .mode(mode), .dataOut(d_out[0]));
    rand_gen serises1(.clk(clk), .reset(reset), .din(seedingValues[1]), .enable(enable), .mode(mode), .dataOut(d_out[1]));
    rand_gen serises2(.clk(clk), .reset(reset), .din(seedingValues[2]), .enable(enable), .mode(mode), .dataOut(d_out[2]));
    rand_gen serises3(.clk(clk), .reset(reset), .din(seedingValues[3]), .enable(enable), .mode(mode), .dataOut(d_out[3]));
    rand_gen serises4(.clk(clk), .reset(reset), .din(seedingValues[4]), .enable(enable), .mode(mode), .dataOut(d_out[4]));
    rand_gen serises5(.clk(clk), .reset(reset), .din(seedingValues[5]), .enable(enable), .mode(mode), .dataOut(d_out[5]));
    rand_gen serises6(.clk(clk), .reset(reset), .din(seedingValues[6]), .enable(enable), .mode(mode), .dataOut(d_out[6]));
    rand_gen serises7(.clk(clk), .reset(reset), .din(seedingValues[7]), .enable(enable), .mode(mode), .dataOut(d_out[7]));
    rand_gen serises8(.clk(clk), .reset(reset), .din(seedingValues[8]), .enable(enable), .mode(mode), .dataOut(d_out[8]));
    rand_gen serises9(.clk(clk), .reset(reset), .din(seedingValues[9]), .enable(enable), .mode(mode), .dataOut(d_out[9]));
       
    always @ (posedge reset)
    begin
        width <= count;
        resetTriggered <= 1;
        modeSeeder <= 1;    
        currentPos <= 0;
        waitPeriod <= 10;
        initialSeed <= seed;
        mem_write <= 0;
        busy <= 1;
    end
    
    always @ (seedNumber)
    begin
        if(resetTriggered && seedNumber != 0)
        begin
            if(currentPos < 10 && waitPeriod <= 0) begin
                seedingValues[currentPos] <= seedNumber;
                currentPos <= currentPos + 1;
            end else if(currentPos >= 10) begin
                resetTriggered <= 0;
                mode <= 1;
                waitPeriod <= 10;
            end 
        end
    end 
    
    always @ (posedge clk or negedge clk)
    begin
        if(resetTriggered == 0 && waitPeriod <= 0)
        begin
            mode <= 0;
            // wait for 4 clk cycles
            if (k < 6 && i < count) begin
                //test <= d_out0;
                mem_out[0+i] <= d_out[0];
                mem_out[1+i] <= d_out[1];
                mem_out[2+i] <= d_out[2];
                mem_out[3+i] <= d_out[3];
                mem_out[4+i] <= d_out[4];
                mem_out[5+i] <= d_out[5];
                mem_out[6+i] <= d_out[6];
                mem_out[7+i] <= d_out[7];
                mem_out[8+i] <= d_out[8];
                mem_out[9+i] <= d_out[9];
                k <= k + 1;
             end else if (i >= count && busy) begin
                mem_write <= 1;
                busy <= 0;
             end else begin
                k <= 0;
                i <= i + 10;
             end    
        end else if (waitPeriod > 0) begin
            waitPeriod <= waitPeriod - 1;
        end else if (waitPeriod <= 0) begin
            modeSeeder <= 0;
//            

            //i <= i + 10
        end else begin
            mode <= 0;
           
        end
    end
    
    // Read array
    always @(posedge clk)
    begin
        if (mem_write && j < count) begin
            dataOut <= mem_out[j];
            j <= j + 1;
        end else if (j >= count) begin
            mem_write <= 0;
        end
    end
    
endmodule
