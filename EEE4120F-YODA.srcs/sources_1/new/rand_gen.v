`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2021 10:14:04 PM
// Design Name: 
// Module Name: rand_gen
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


module rand_gen(
    input clk,
    input reset,
    input [31:0] din,
    input enable,
    input mode,
    output reg [31:0] dataOut
    );
    
    reg [31:0] PIPO_OUT;
    wire [31:0] FIFO_OUT;
    reg wr_en, rd_en;
    
    fifo_32 FIFO0(.clk(clk), .srst(reset),.din(PIPO_OUT[0]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[0]));
    fifo_30 FIFO1(.clk(clk), .srst(reset),.din(PIPO_OUT[1]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[1]));
    fifo_32 FIFO2(.clk(clk), .srst(reset),.din(PIPO_OUT[2]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[2]));
    fifo_32 FIFO3(.clk(clk), .srst(reset),.din(PIPO_OUT[3]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[3]));
    fifo_32 FIFO4(.clk(clk), .srst(reset),.din(PIPO_OUT[4]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[4]));
    fifo_32 FIFO5(.clk(clk), .srst(reset),.din(PIPO_OUT[5]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[5]));
    fifo_31 FIFO6(.clk(clk), .srst(reset),.din(PIPO_OUT[6]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[6]));
    fifo_32 FIFO7(.clk(clk), .srst(reset),.din(PIPO_OUT[7]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[7]));
    fifo_26 FIFO8(.clk(clk), .srst(reset),.din(PIPO_OUT[8]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[8]));
    fifo_32 FIFO9(.clk(clk), .srst(reset),.din(PIPO_OUT[9]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[9]));
    fifo_32 FIFO10(.clk(clk), .srst(reset),.din(PIPO_OUT[10]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[10]));
    fifo_32 FIFO11(.clk(clk), .srst(reset),.din(PIPO_OUT[11]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[11]));
    fifo_32 FIFO12(.clk(clk), .srst(reset),.din(PIPO_OUT[12]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[12]));
    fifo_32 FIFO13(.clk(clk), .srst(reset),.din(PIPO_OUT[13]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[13]));
    fifo_21 FIFO14(.clk(clk), .srst(reset),.din(PIPO_OUT[14]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[14]));
    fifo_32 FIFO15(.clk(clk), .srst(reset),.din(PIPO_OUT[15]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[15]));
    fifo_32 FIFO16(.clk(clk), .srst(reset),.din(PIPO_OUT[16]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[16]));
    fifo_32 FIFO17(.clk(clk), .srst(reset),.din(PIPO_OUT[17]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[17]));
    fifo_32 FIFO18(.clk(clk), .srst(reset),.din(PIPO_OUT[18]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[18]));
    fifo_32 FIFO19(.clk(clk), .srst(reset),.din(PIPO_OUT[19]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[19]));
    fifo_32 FIFO20(.clk(clk), .srst(reset),.din(PIPO_OUT[20]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[20]));
    fifo_32 FIFO21(.clk(clk), .srst(reset),.din(PIPO_OUT[21]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[21]));
    fifo_32 FIFO22(.clk(clk), .srst(reset),.din(PIPO_OUT[22]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[22]));
    fifo_32 FIFO23(.clk(clk), .srst(reset),.din(PIPO_OUT[23]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[23]));
    fifo_29 FIFO24(.clk(clk), .srst(reset),.din(PIPO_OUT[24]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[24]));
    fifo_30 FIFO25(.clk(clk), .srst(reset),.din(PIPO_OUT[25]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[25]));
    fifo_32 FIFO26(.clk(clk), .srst(reset),.din(PIPO_OUT[26]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[26]));
    fifo_29 FIFO27(.clk(clk), .srst(reset),.din(PIPO_OUT[27]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[27]));
    fifo_32 FIFO28(.clk(clk), .srst(reset),.din(PIPO_OUT[28]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[28]));
    fifo_28 FIFO29(.clk(clk), .srst(reset),.din(PIPO_OUT[29]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[29]));
    fifo_32 FIFO30(.clk(clk), .srst(reset),.din(PIPO_OUT[30]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[30]));
    fifo_32 FIFO31(.clk(clk), .srst(reset),.din(PIPO_OUT[31]), .wr_en(wr_en), .rd_en(rd_en), .dataOutput(FIFO_OUT[31]));
    
    always @ (posedge clk or negedge clk)
    begin
        if(dataOut == 0)
        begin
            dataOut <= din;
        end
        
        dataOut[0] <= PIPO_OUT[6];
        dataOut[1] <= PIPO_OUT[10];
        dataOut[2] <= PIPO_OUT[26];
        dataOut[3] <= PIPO_OUT[14];
        dataOut[4] <= PIPO_OUT[2];
        dataOut[5] <= PIPO_OUT[30];
        dataOut[6] <= PIPO_OUT[0];
        dataOut[7] <= PIPO_OUT[22];
        dataOut[8] <= PIPO_OUT[24];
        dataOut[9] <= PIPO_OUT[27];
        dataOut[10] <= PIPO_OUT[29];
        dataOut[11] <= PIPO_OUT[13];
        dataOut[12] <= PIPO_OUT[8];
        dataOut[13] <= PIPO_OUT[28];
        dataOut[14] <= PIPO_OUT[7];
        dataOut[15] <= PIPO_OUT[3];
        dataOut[16] <= PIPO_OUT[23];
        dataOut[17] <= PIPO_OUT[9];
        dataOut[18] <= PIPO_OUT[21];
        dataOut[19] <= PIPO_OUT[19];
        dataOut[20] <= PIPO_OUT[20];
        dataOut[21] <= PIPO_OUT[25];
        dataOut[22] <= PIPO_OUT[18];
        dataOut[23] <= PIPO_OUT[17];
        dataOut[24] <= PIPO_OUT[31];
        dataOut[25] <= PIPO_OUT[1];
        dataOut[26] <= PIPO_OUT[4];
        dataOut[27] <= PIPO_OUT[16];
        dataOut[28] <= PIPO_OUT[12];
        dataOut[29] <= PIPO_OUT[5];
        dataOut[30] <= PIPO_OUT[11];
        dataOut[31] <= PIPO_OUT[15];
   
        if(enable)
        begin
            wr_en = enable;
            rd_en = enable; 
            
            PIPO_OUT[0] <= mode ? din[0] : 0 ^ FIFO_OUT[16] ^ FIFO_OUT[0] ^ FIFO_OUT[12] ^ FIFO_OUT[27];
            PIPO_OUT[1] <= mode ? din[1] : 0 ^ FIFO_OUT[16] ^ FIFO_OUT[12] ^ FIFO_OUT[20] ^ FIFO_OUT[24] ^ FIFO_OUT[1];
            PIPO_OUT[2] <= mode ? din[2] : 0 ^ FIFO_OUT[2] ^ FIFO_OUT[15] ^ FIFO_OUT[0] ^ FIFO_OUT[11] ^ FIFO_OUT[1];
            PIPO_OUT[3] <= mode ? din[3] : 0 ^ FIFO_OUT[3] ^ FIFO_OUT[2] ^ FIFO_OUT[4] ^ FIFO_OUT[5] ^ FIFO_OUT[25];
            PIPO_OUT[4] <= mode ? din[4] : 0 ^ FIFO_OUT[7] ^ FIFO_OUT[19] ^ FIFO_OUT[4] ^ FIFO_OUT[23] ^ FIFO_OUT[26];
            PIPO_OUT[5] <= mode ? din[5] : 0 ^ FIFO_OUT[10] ^ FIFO_OUT[3] ^ FIFO_OUT[0] ^ FIFO_OUT[5] ^ FIFO_OUT[6];
            PIPO_OUT[6] <= mode ? din[6] : 0 ^ FIFO_OUT[3] ^ FIFO_OUT[9] ^ FIFO_OUT[11] ^ FIFO_OUT[20] ^ FIFO_OUT[6];
            PIPO_OUT[7] <= mode ? din[7] : 0 ^ FIFO_OUT[7] ^ FIFO_OUT[22] ^ FIFO_OUT[24] ^ FIFO_OUT[28] ^ FIFO_OUT[14];
            PIPO_OUT[8] <= mode ? din[8] : 0 ^ FIFO_OUT[7] ^ FIFO_OUT[16] ^ FIFO_OUT[18] ^ FIFO_OUT[8];
            PIPO_OUT[9] <= mode ? din[9] : 0 ^ FIFO_OUT[9] ^ FIFO_OUT[0] ^ FIFO_OUT[18] ^ FIFO_OUT[23] ^ FIFO_OUT[13];
            PIPO_OUT[10] <= mode ? din[10] : 0 ^ FIFO_OUT[10] ^ FIFO_OUT[9] ^ FIFO_OUT[21] ^ FIFO_OUT[29] ^ FIFO_OUT[28];
            PIPO_OUT[11] <= mode ? din[11] : 0 ^ FIFO_OUT[3] ^ FIFO_OUT[15] ^ FIFO_OUT[11] ^ FIFO_OUT[6];
            PIPO_OUT[12] <= mode ? din[12] : 0 ^ FIFO_OUT[18] ^ FIFO_OUT[12] ^ FIFO_OUT[26] ^ FIFO_OUT[24] ^ FIFO_OUT[6];
            PIPO_OUT[13] <= mode ? din[13] : 0 ^ FIFO_OUT[4] ^ FIFO_OUT[31] ^ FIFO_OUT[8] ^ FIFO_OUT[13] ^ FIFO_OUT[30];
            PIPO_OUT[14] <= mode ? din[14] : 0 ^ FIFO_OUT[15] ^ FIFO_OUT[30] ^ FIFO_OUT[5] ^ FIFO_OUT[14] ^ FIFO_OUT[27];
            PIPO_OUT[15] <= mode ? din[15] : 0 ^ FIFO_OUT[15] ^ FIFO_OUT[4] ^ FIFO_OUT[22] ^ FIFO_OUT[8] ^ FIFO_OUT[26];
            PIPO_OUT[16] <= mode ? din[16] : 0 ^ FIFO_OUT[16] ^ FIFO_OUT[2] ^ FIFO_OUT[9] ^ FIFO_OUT[26] ^ FIFO_OUT[14];
            PIPO_OUT[17] <= mode ? din[17] : 0 ^ FIFO_OUT[17] ^ FIFO_OUT[19] ^ FIFO_OUT[12] ^ FIFO_OUT[31] ^ FIFO_OUT[8];
            PIPO_OUT[18] <= mode ? din[18] : 0 ^ FIFO_OUT[21] ^ FIFO_OUT[18] ^ FIFO_OUT[20] ^ FIFO_OUT[5] ^ FIFO_OUT[14];
            PIPO_OUT[19] <= mode ? din[19] : 0 ^ FIFO_OUT[19] ^ FIFO_OUT[4] ^ FIFO_OUT[25] ^ FIFO_OUT[1];
            PIPO_OUT[20] <= mode ? din[20] : 0 ^ FIFO_OUT[10] ^ FIFO_OUT[17] ^ FIFO_OUT[2] ^ FIFO_OUT[20] ^ FIFO_OUT[1];
            PIPO_OUT[21] <= mode ? din[21] : 0 ^ FIFO_OUT[17] ^ FIFO_OUT[16] ^ FIFO_OUT[21] ^ FIFO_OUT[11] ^ FIFO_OUT[25];
            PIPO_OUT[22] <= mode ? din[22] : 0 ^ FIFO_OUT[17] ^ FIFO_OUT[2] ^ FIFO_OUT[22] ^ FIFO_OUT[8] ^ FIFO_OUT[28];
            PIPO_OUT[23] <= mode ? din[23] : 0 ^ FIFO_OUT[0] ^ FIFO_OUT[21] ^ FIFO_OUT[23] ^ FIFO_OUT[29];
            PIPO_OUT[24] <= mode ? din[24] : 0 ^ FIFO_OUT[11] ^ FIFO_OUT[24] ^ FIFO_OUT[13] ^ FIFO_OUT[6] ^ FIFO_OUT[27];
            PIPO_OUT[25] <= mode ? din[25] : 0 ^ FIFO_OUT[7] ^ FIFO_OUT[22] ^ FIFO_OUT[12] ^ FIFO_OUT[30] ^ FIFO_OUT[25];
            PIPO_OUT[26] <= mode ? din[26] : 0 ^ FIFO_OUT[10] ^ FIFO_OUT[21] ^ FIFO_OUT[18] ^ FIFO_OUT[22] ^ FIFO_OUT[26];
            PIPO_OUT[27] <= mode ? din[27] : 0 ^ FIFO_OUT[17] ^ FIFO_OUT[29] ^ FIFO_OUT[13] ^ FIFO_OUT[5] ^ FIFO_OUT[27];
            PIPO_OUT[28] <= mode ? din[28] : 0 ^ FIFO_OUT[10] ^ FIFO_OUT[19] ^ FIFO_OUT[15] ^ FIFO_OUT[28] ^ FIFO_OUT[14];
            PIPO_OUT[29] <= mode ? din[29] : 0 ^ FIFO_OUT[23] ^ FIFO_OUT[31] ^ FIFO_OUT[29] ^ FIFO_OUT[20] ^ FIFO_OUT[30];
            PIPO_OUT[30] <= mode ? din[30] : 0 ^ FIFO_OUT[9] ^ FIFO_OUT[31] ^ FIFO_OUT[30] ^ FIFO_OUT[25] ^ FIFO_OUT[28];
            PIPO_OUT[31] <= mode ? din[31] : 0 ^ FIFO_OUT[31] ^ FIFO_OUT[29] ^ FIFO_OUT[24] ^ FIFO_OUT[13] ^ FIFO_OUT[1];
        end
    end 
endmodule
