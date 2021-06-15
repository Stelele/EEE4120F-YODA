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
    input [31:0] seed,
    input enable,
    output wire[31:0] dataOut0,
    output wire[31:0] dataOut1,
    output wire[31:0] dataOut2,
    output wire[31:0] dataOut3,
    output wire[31:0] dataOut4,
    output wire[31:0] dataOut5,
    output wire[31:0] dataOut6,
    output wire[31:0] dataOut7,
    output wire[31:0] dataOut8,
    output wire[31:0] dataOut9
    );
    
    reg modeSeeder;
    reg mode;
    reg resetTriggered;
    reg [4:0] waitPeriod;
    reg [31:0] seedingValues[0:9];
    wire [31:0] seedNumber;
    reg [31:0] initialSeed;
    reg [4:0] currentPos;
    
    // seeding module to generate seed values for rest of module implementations
    rand_gen seeder_gen(.clk(clk), .reset(reset), .din(initialSeed), .enable(enable), .mode(modeSeeder), .dataOut(seedNumber));
    
    // pararlel modl seed generators
    rand_gen serises0(.clk(clk), .reset(reset), .din(seedingValues[0]), .enable(enable), .mode(mode), .dataOut(dataOut0));
    rand_gen serises1(.clk(clk), .reset(reset), .din(seedingValues[1]), .enable(enable), .mode(mode), .dataOut(dataOut1));
    rand_gen serises2(.clk(clk), .reset(reset), .din(seedingValues[2]), .enable(enable), .mode(mode), .dataOut(dataOut2));
    rand_gen serises3(.clk(clk), .reset(reset), .din(seedingValues[3]), .enable(enable), .mode(mode), .dataOut(dataOut3));
    rand_gen serises4(.clk(clk), .reset(reset), .din(seedingValues[4]), .enable(enable), .mode(mode), .dataOut(dataOut4));
    rand_gen serises5(.clk(clk), .reset(reset), .din(seedingValues[5]), .enable(enable), .mode(mode), .dataOut(dataOut5));
    rand_gen serises6(.clk(clk), .reset(reset), .din(seedingValues[6]), .enable(enable), .mode(mode), .dataOut(dataOut6));
    rand_gen serises7(.clk(clk), .reset(reset), .din(seedingValues[7]), .enable(enable), .mode(mode), .dataOut(dataOut7));
    rand_gen serises8(.clk(clk), .reset(reset), .din(seedingValues[8]), .enable(enable), .mode(mode), .dataOut(dataOut8));
    rand_gen serises9(.clk(clk), .reset(reset), .din(seedingValues[9]), .enable(enable), .mode(mode), .dataOut(dataOut9));
    
    always @ (posedge reset)
    begin
        resetTriggered <= 1;
        modeSeeder <= 1;    
        currentPos <= 0;
        waitPeriod <= 10;
        initialSeed <= seed;
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
        end else if (waitPeriod > 0) begin
            waitPeriod <= waitPeriod - 1;
        end else if (waitPeriod <= 0) begin
            modeSeeder <= 0;
        end else begin
            mode <= 1;
        end  
    end 
endmodule
