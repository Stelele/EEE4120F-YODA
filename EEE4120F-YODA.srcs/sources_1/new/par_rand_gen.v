`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date: 06/15/2021 06:30:32 PM
// Design Name: Parallel LUT-SR Random Generator
// Module Name: par_rand_gen
// Project Name: PRNG - Parallel Random Number Generator
// Target Devices: Nexys-A7-100T
// Description: Digital Accelelrator that generates multiple numbers in Parrallel
//              and writes to memory sequentially using LUT-SR RNG algorithm 
//
// Dependencies: rand_gen.v rand_dp_fp.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module par_rand_gen(
    input clk                   , // clock signal
    input reset                 , // reset signal
    input mem_read              , // read from memory signal
    input [31:0] seed           , // starting seed value
    input [31:0] count          , // quantity of random numbers to generate
    input enable                , // enable module signal
    output reg busy             , // "busy" signal output
    output reg mem_write        , // writing to memory signal output
    output reg[31:0] dataOuta   , // channel A output with random number
    output reg[31:0] dataOutb     // channel B outptut with random number
    //output reg[31:0] test
    );
    
    // --------------------------------------------------------------------------
    // Random generator parameters
    //---------------------------------------------------------------------------
    reg modeSeeder; // change from load and generate mode for seeder generator
    reg mode;   // change from load and generate mode for parallel generators
    reg resetTriggered; // check to see if reset signal was triggered
    reg [4:0] waitPeriod; // wait period to allow propagation of XOR signals
    reg [31:0] seedingValues[0:9]; // seeding values for parallel generators
    wire [31:0] seedNumber; // temporary generated number from seeder generator
    reg [31:0] initialSeed; // store given starting seed value
    reg [4:0] currentPos;  // indicator of which position to load generated seed value in seedingValues
    reg [31:0] width; // store quantity of random generators to generate
    parameter [31:0] max_width = 15000; // maximum quantity of numbers that can be generated
    wire [31:0] d_out [0:9]; // wires that would have parallel generated random numbers
    reg [31:0] mem_out [0:max_width-1]; // temp array to store generated random numbers
    reg [31:0] i = 0; // Array position incrementer
    reg [31:0] j = 0; // memory position
    reg [3:0] k = 0;  // helps skip 3 clock cycles
    reg [31:0] half_width;
     
    // ---------------------------------------------------------------------------
    // MEMORY PARAMETERS
    //----------------------------------------------------------------------------
    reg cs; // Define our controlled signals
    reg a_we, a_oe, b_we, b_oe;
    reg [31:0] size;
    wire [31:0] a_data;     // this is the connection to ramcu data port
    reg [31:0] a_addr;     // this is the address for port A
    wire [31:0] b_data;     // this is the connection to ramcu data port
    reg [31:0] b_addr;     // this is the address for port A
    
    reg  [31:0] a_data_value; // need a register to store value to send on a write
    reg  [31:0] b_data_value; // need a register to store value to send on a write
    
    // ---------------------------------------------------------------------------
    // Initialise random generator
    //----------------------------------------------------------------------------
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
    
    // ---------------------------------------------------------------------------
    // Initialise Memory
    //----------------------------------------------------------------------------
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
    
    
    // ---------------------------------------------------------------------------
    // Start Generation
    //----------------------------------------------------------------------------
    always @ (posedge reset)
    begin
        width <= count;
        half_width <= count>>1;
        resetTriggered <= 1;
        modeSeeder <= 1;    
        currentPos <= 0;
        waitPeriod <= 10;
        initialSeed <= seed;
        mem_write <= 0;
        busy <= 1;
        
        // Memory paramters
        cs      <= 0;
        a_we    <= 0;
        a_oe    <= 0;
        a_addr  <= 0;
        b_we    <= 0;
        b_oe    <= 0;
        b_addr  <= count>>1;
        
    end

    // ---------------------------------------------------------------------------
    // Initialize Seeds for random generators
    //----------------------------------------------------------------------------  
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

    // ---------------------------------------------------------------------------
    // Load random numbers into temporary array
    //----------------------------------------------------------------------------
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
                cs      <= 1;
                a_oe   <= 0;
                a_we   <= 1;
                b_oe    <= 0;
                b_we    <= 1;
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
    
    // ---------------------------------------------------------------------------
    // Write to memory
    //----------------------------------------------------------------------------
    // write to a
    always @(posedge clk)
    begin
        if (mem_write && a_addr < half_width) begin
            a_data_value <= mem_out[a_addr];
            a_addr <= a_addr + 1;
        end
    end
    
    // write to b
    always @(posedge clk)
    begin
        if (mem_write && b_addr < count) begin
            b_data_value <= mem_out[b_addr];
            b_addr <= b_addr + 1;
            //dataOutb <= b_addr;
        end else if (b_addr >= count && !mem_read) begin
            mem_write <= 0;
            a_oe   <= 1;
            a_we   <= 0;
            b_oe    <= 1;
            b_we    <= 0;
            a_addr <= 0;
            b_addr <= half_width;
        end
    end
    // ---------------------------------------------------------------------------
    // Read Array for simulation
    //----------------------------------------------------------------------------
    // Read array
//    always @(posedge clk)
//    begin
//        if (mem_read && j < count) begin
//            dataOuta <= mem_out[j];
//            j <= j + 1;
//        end else if (j >= count) begin
//            mem_write <= 0;
//        end
//    end
    // Read from a
    always @(posedge clk)
    begin
        if (mem_read && a_addr < half_width) begin
            dataOuta <= a_data;
            a_addr <= a_addr + 1;
        end
    end
    
    // Read from b
    always @(posedge clk)
    begin
        if (mem_read && b_addr < count) begin
            dataOutb <= b_data;
            b_addr <= b_addr + 1;
        end
    end
    
    
    
endmodule
