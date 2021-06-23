`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2021 12:30:05 AM
// Design Name: 
// Module Name: fifo_29
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: a 29-bit deep FIFO
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo_29(
    input clk,
    input srst,
    input  din,
    input wr_en,
    input rd_en,
    output reg dataOutput,
    output reg full,
    output empty
    );
    
    parameter [4:0] MAXDEPTH = 29;
    
    wire dout;
    wire [4:0] data_count;
    
    fifo_generator_0 fifo_generator_32 (
      .clk(clk),                // input wire clk
      .srst(srst),              // input wire srst
      .din(din),                // input wire [31 : 0] din
      .wr_en(wr_en),            // input wire wr_en
      .rd_en(rd_en),            // input wire rd_en
      .dout(dout),              // output wire [31 : 0] dout
      .empty(empty),            // output wire empty
      .data_count(data_count)  // output wire [4 : 0] data_count
    );
    
    always @(posedge clk)
    begin
        if(data_count <= MAXDEPTH)
        begin
            dataOutput <= dout;       
        end else  begin
            full <= 1'b1;         
        end
    end
endmodule
