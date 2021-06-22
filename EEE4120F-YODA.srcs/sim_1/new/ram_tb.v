`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2021 03:14:43
// Design Name: 
// Module Name: ram_tb
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


module ram_tb();
    // Define our controlled signals
    reg clk, cs;
    reg a_we, a_oe, b_we, b_oe;
    wire [31:0] a_data;     // this is the connection to ramcu data port
    reg [31:0] a_addr;     // this is the address for port A
    wire [31:0] b_data;     // this is the connection to ramcu data port
    reg [31:0] b_addr;     // this is the address for port A
    
    reg  [31:0] a_data_value; // need a register to store value to send on a write
    reg  [31:0] b_data_value; // need a register to store value to send on a write
    
    // Instantiate our DUT
    ram_dp_fp dut (
        clk     , // clock input
        cs      , // chip select
        a_we    , // channel A write enable
        a_oe    , // channel A output enable
        a_addr  , // channel A address
        a_data  , // channel A inout data
        b_we    , // channel B write enable
        b_oe    , // channel B output enable
        b_addr  , // channel B address
        b_data    // channel B inout data
    );

    assign a_data = !a_oe ? a_data_value : 'bz;
    assign b_data = !b_oe ? b_data_value : 'bz;  

    initial begin
    
    // set up initial conditions
    clk   = 0;
    cs    = 0;
    a_we    = 0;
    a_oe    = 0;
    a_addr  = 0;
    
    $display("clk cs a_we a_oe a_addr a_data");
    $monitor("  %d  %d    %d    %d    %03d    %03d",
             clk,cs,a_we,a_oe,a_addr,a_data);
    
    // try doing a clock change just when nothing should happen (cs=0)
    #5 clk = ~clk;
    #5 clk = ~clk;
    
    // let is do a memory write...
    // note that you need to deselect the chip before setting up data
    $display("write 99 to mem[1]");
    a_oe   = 0;
    a_we   = 1;
    cs      = 1;
    a_addr = 32'd1;
    a_data_value = 32'd99;
    #5 clk = ~clk;    // do a clock pulse
    #5 clk = ~clk;
    
    // now disconnect data_value from data line
    $display("write junk into toplevel data_value buffer");
    cs         = 0;
    a_we         = 0;
    a_oe         = 0;
    a_data_value = 32'd2;
    #5 clk = ~clk;    // do a clock pulse
    #5 clk = ~clk;
    
    // let's read the value back
    $display("check reading back data");
    a_addr = 32'd1;
    a_we   = 0;
    a_oe   = 1;         // ask module to write out data
    cs   = 1;
    #5 clk = ~clk;    // do a clock pulse (reads the data)
    #5 clk = ~clk;
    // you should now have back the value that was written to memory
	
    // disable chip select and write some more junk to local buffer
    $display("write more junk into toplevel data_value");
    cs = 0;
    a_data_value = 5'd123;    
    
	#5 clk = ~clk;  // do a clock pulse to see what happens
    #5 clk = ~clk;
    
    // OPTIONAL: here is a repeat loop to dump part of the memory
    a_addr = 0;
    #5
    $display("dump some memory:");
    repeat (5) 
      begin
        $display("mem[%d]=%d",a_addr,dut.mem[a_addr]);
        a_addr = a_addr + 1;
      end
    
    //ADDED THIS
    //let's write to B while we read from A
    cs = 1;
    a_addr = 8'd1;
    a_oe = 1;
    a_we = 0;
    
    b_addr = 0;
    b_data_value = 8'd2; 
    b_oe = 0;
    b_we = 1;
    
    // pulse the clock;
    #5 clk = ~clk; 
    #5 clk = ~clk;
    
    //display the data
    $display("clk cs a_we a_oe a_addr a_data b_we b_oe b_addr b_data");
    $display("  %d  %d    %d    %d    %03d    %03d    %d    %d    %03d    %03d", 
            clk, cs, a_we, a_oe, a_addr, a_data, b_we, b_oe, b_addr, b_data);
    
    // pulse the clock
    
    $finish;
    end
    endmodule
