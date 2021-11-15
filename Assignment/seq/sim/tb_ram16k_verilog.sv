//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Third Assignment
// Purpose  : Testbench for 16kB RAM in System Verilog
// Author   : SteDun
// Version  : V1.0 2021-11-10
//-------------------------------------------------------

module tb_ram16k_verilog
();


// (1) Wiring the DUT
localparam WTB_ADDR = 14;
localparam WTB_DATA = 16;
localparam MAX_ADDR = ((2**WTB_ADDR)-1);    // maximal possible addresses to write data to the RAM

logic [WTB_ADDR-1:0]    address;
logic                   clock;
logic [WTB_DATA-1:0]    data;
logic                   wren;
logic [WTB_DATA-1:0]    q;

`define ALL_ZERO         16'h0000
`define ALL_ONE          16'hffff
`define RANDOM_ADDRESS   14'h2a39


// (2) DUT instance
ram16k_verilog dut(
    .address    (address),
    .clock      (clock),
    .data       (data),
    .wren       (wren),
    .q          (q)
);


// (3) DUT stimulation
// define local variables
logic run_sim   = 1'b1;
int error_cnt   = 0;
int error       = 0;

// Define the clock
// The clock should run with 100 MHz
// 1s / 100MHh = 10ns (toggle with 5ns - half of the period)
initial begin
    clock = 1'b0;
    while(run_sim) begin
        #5ns;
        clock = ~clock;
    end
end

// Testbench for the 16k RAM
initial begin
    $display("****************************************************************");
    $display("Welcome to the testbench for a 16k RAM (tb_ram16k_verilog)...");
    @(negedge clock);
    address = '0;
    wren    = 1'b0;
    #100ns;

    // Set the RAM at all addresses to 0
    $display("---------------------------------------------------------");

    @(negedge clock);
    data = '0;
    wren = 1'b1;
    
    // Do write zero to all RAM memory cell using the address
    for(; address < MAX_ADDR; address += 1) begin
        @(negedge clock);
    end
    #50ns;

    // Check if the writing has worked
    // Do an iteration with a for-loop and check all RAM memory cell value is 0x0000
    @(negedge clock);
    wren    = 1'b0;
    address = '0;
    for(; address < MAX_ADDR; address += 1) begin
        @(negedge clock);
        if(q != `ALL_ZERO) begin
            error++;
        end
    end

    // Jump to RAM address `randomAddres and check if memeory cell content is 0x0000
    @(negedge clock);
    address = '0;
    @(negedge clock);
    address = `RANDOM_ADDRESS;
    @(negedge clock);
    $display("RAM address:          %4h", address);
    $display("Memory cell content:  %4h", q);

    // Check if an error had occured during the test
    assert(error == 0) begin
        $display("Writing of zeros to all RAM addresses succeede      --> OK");
    end
    else begin
        $error("Writing of zero to all RAM addresses failed     --> ERROR");
        error_cnt++;
    end
    error = 0;
    $display("---------------------------------------------------------");
    #100ns;



    // Set the RAM at all addresses to 1
    $display("---------------------------------------------------------");
    $display("Writing zero to all RAM addresses");

    @(negedge clock);
    data    = '1;
    wren    = 1'b1;
    address = '0;

    // Do write 1 to all memory cells of the RAM using addresses
    for(; address < MAX_ADDR; address += 1) begin
        @(negedge clock);
    end 
    #50ns;

    // Check if the writing has worked
    // Do an iteration with a for-loop and check all RAM memory cell it the cell value is 0xffff
    @(negedge clock);
    wren    = 1'b0;
    address = '0;
    for(; address < MAX_ADDR; address += 1) begin
        @(negedge clock);
        if(q != `ALL_ONE) begin
            error++;
        end
    end

    // Jump to RAM address `randomAddress and check if memeory cell content is 0x0000
    @(negedge clock);
    address = '0;
    @(negedge clock);
    address = `RANDOM_ADDRESS;
    @(negedge clock);
    $display("RAM address:          %h", address);
    $display("Memory cell content:  %h", q);

    // Check if an error had occured during the test
    assert(error == 0) begin
        $display("Writing of zeros to all RAM addresses succeede      --> OK");
    end
    else begin
        $error("Writing of zero to all RAM addresses failed     --> ERROR");
        error_cnt++;
    end
    error = 0;
    $display("---------------------------------------------------------");
    #100ns;



    // Set the RAM at all addresses to the address value
    $display("---------------------------------------------------------");
    $display("Writing zero to all RAM addresses");

    @(negedge clock);
    address = '0;
    wren    = 1'b1;

    // Do write 1 to all memory cells of the RAM using addresses
    for(; address < MAX_ADDR; address += 1) begin
        data = address;
        @(negedge clock);
    end 
    #50ns;

    // Check if the writing has worked
    // Do an iteration with a for-loop and check all RAM memory cell it the cell value is 0xffff
    @(negedge clock);
    wren    = 1'b0;
    address = '0;
    for(; address < MAX_ADDR; address += 1) begin
        @(negedge clock);
        if(q != address) begin
            error++;
        end
    end

    // Jump to RAM address `randomAddress and check if memeory cell content is 0x0000
    @(negedge clock);
    address = '0;
    @(negedge clock);
    address = `RANDOM_ADDRESS;
    @(negedge clock);
    $display("RAM address:          %h", address);
    $display("Memory cell content:  %h", q);

    // Check if an error had occured during the test
    assert(error == 0) begin
        $display("Writing of zeros to all RAM addresses succeede      --> OK");
    end
    else begin
        $error("Writing of zero to all RAM addresses failed     --> ERROR");
        error_cnt++;
    end
    error = 0;
    $display("---------------------------------------------------------");
    #100ns;


    // End the test
    #100ns;
    run_sim = 1'b0;
    $display("Errors occured during testing: %d", error_cnt);
    $display("---------------------------------------------------------");
    $display("Testbench for 16k RAM (tb_ram16k_verilog) finished.");
    $display("****************************************************************");
end

endmodule


