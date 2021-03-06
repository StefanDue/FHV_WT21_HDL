//---------------------------------------------------------------------------------
// Project  : EDB HDL WS2021 - Fourth Assignment
// Purpose  : Implementation of a testbench for the instruction demultiplexer
// Author   : SteDun
// Version  : V1.0 2021-11-24
//---------------------------------------------------------------------------------

module tb_cpu 
();


// (1) DUT wiring
localparam DWTB = 16;
localparam AWTB = 15;
localparam PWTB = 14;

logic               rst_n;
logic               clk50m;
logic               writeM;
logic [DWTB-1:0]    instr;
logic [DWTB-1:0]    inM;
logic [DWTB-1:0]    outM;
logic [AWTB-1:0]    addressM;
logic [PWTB-1:0]    pc;



// (2) DUT instance
cpu #(.DW (DWTB), .AW (AWTB), .PW (PWTB)) dut (.*);


// (3) DUT stimulation
// Define the testing values
`define MAX_CONST               16'h7FFF    // 0111_1111_1111_1111
`define MIN_CONST               16'h0000    // 0000_0000_0000_0000
`define D_EQUALS_ONE            16'hEFD0    // 111_0_111111_010_000
`define D_AND_A_STORE_D         16'hE090    // 111_0_000010_010_000
`define INC_A_STORE_M           16'hEDC8    // 111_0_110111_001_000
`define CLOCK_PERIOD_HALF       10ns


int error_cnt = 0;
logic run_sim = 1'b1;


// Function to check the writeM enable flag
function int check_writeM (logic writeM, logic expected_writeM, int error_cnt);
    int errorCount;
    errorCount = error_cnt;
    assert(writeM == expected_writeM) begin
        $display("Output writeM equals expected");
        $display("Expected writeM: %b", expected_writeM);
        $display("writeM:          %b", writeM);
    end
    else begin
        $error("Output writeM does not equal the expected");
        $display("Expected writeM: %b", expected_writeM);
        $display("writeM:          %b", writeM);
        errorCount++;
    end
    return errorCount;
endfunction


// Function to check the outM output
function int check_outM (logic [DWTB-1:0] outM, logic [DWTB-1:0] expected_outM, int error_cnt);
    int errorCount;
    errorCount = error_cnt;
    assert(outM == expected_outM) begin
        $display("Output outM equals the expected");
        $display("Expected outM: %h = %b", expected_outM, expected_outM);
        $display("outM:          %h = %b", outM, outM);
    end
    else begin
        $error("Output outM does not equal the expected");
        $display("Expected outM: %h = %b", expected_outM, expected_outM);
        $display("outM:          %h = %b", outM, outM);
        errorCount++;
    end
    return errorCount;
endfunction


// Function to check the addressM output
function int check_addressM (logic [AWTB-1:0] addressM, logic [AWTB-1:0] expected_addressM, int error_cnt);
    int errorCount;
    errorCount = error_cnt;
    assert(addressM == expected_addressM) begin
        $display("Output addressM equals the expected");
        $display("Expected addressM: %h = %b", expected_addressM, expected_addressM);
        $display("addressM:          %h = %b", addressM, addressM);
    end
    else begin
        $error("Output addressM does not equal the expected");
        $display("Expected addressM: %h = %b", expected_addressM, expected_addressM);
        $display("addressM:          %h = %b", addressM, addressM);
        errorCount++;
    end
    return errorCount;
endfunction



// Define the system clock
initial begin
    clk50m = 1'b0;
    while(run_sim == 1'b1) begin
        #`CLOCK_PERIOD_HALF;
        clk50m = ~clk50m;
    end
end


initial begin
    // Initialize the registers
    rst_n = 1'b0;
    #100ns;
    @(negedge clk50m);
    rst_n = 1'b1;

    $display("***************************************************************************");
    $display("Welcome to the testbench for a CPU (tb_cpu)");

    $display("------------------------------------------------------");
    $display("------------------------------------------------------");
    $display("+++ Check the A-instruction +++");
    $display("------------------------------------------------------");
    $display("Check for the MAX-CONSTANT - @32767");
    @(negedge clk50m);
    instr   = `MAX_CONST;
    @(negedge clk50m);
    error_cnt = check_writeM(writeM, 1'b0, error_cnt);
    $display("A-instructions do not affect the ALU and so outM has to be 0x0000");
    error_cnt = check_outM(outM, 16'h0000,error_cnt);
    error_cnt = check_addressM(addressM, 15'b111111111111111, error_cnt);
  

    $display("------------------------------------------------------");
    $display("Check for the constant ZERO - @0");
    @(negedge clk50m);
    instr   = `MIN_CONST;
    @(negedge clk50m);
    error_cnt = check_writeM(writeM, 1'b0, error_cnt);
    $display("A-instructions do not affect the ALU and so outM has to be 0x0000");
    error_cnt = check_outM(outM, 16'h0000,error_cnt);
    error_cnt = check_addressM(addressM, 15'b000000000000000, error_cnt);
   

    $display("------------------------------------------------------");
    $display("------------------------------------------------------");
    $display("+++ Check the C-instruction +++");
    $display("------------------------------------------------------");
    $display("Checkt the function D = 1");
    @(negedge clk50m);
    instr   = `D_EQUALS_ONE;
    @(negedge clk50m);
    error_cnt = check_writeM(writeM, 1'b0, error_cnt);
    error_cnt = check_outM(outM, 16'h0001,error_cnt);
    $display("C-instructions do not affect the A-register and so addressM must be 0x0000");
    error_cnt = check_addressM(addressM, 15'b000000000000000, error_cnt);
   

    $display("------------------------------------------------------");
    $display("Checkt the function D = D + A");
    @(negedge clk50m);
    instr   = `D_AND_A_STORE_D;
    @(negedge clk50m);
    error_cnt = check_writeM(writeM, 1'b0, error_cnt);
    error_cnt = check_outM(outM, 16'h0001,error_cnt);
    $display("C-instructions do not affect the A-register and so addressM must be 0x0000");
    error_cnt = check_addressM(addressM, 15'b000000000000000, error_cnt);
    

    $display("------------------------------------------------------");
    $display("Checkt the function M = A + 1");
    @(negedge clk50m);
    instr   = `INC_A_STORE_M;
    @(negedge clk50m);
    error_cnt = check_writeM(writeM, 1'b1, error_cnt);
    error_cnt = check_outM(outM, 16'h0001,error_cnt);
    $display("C-instructions do not affect the A-register and so addressM must be 0x0000");
    error_cnt = check_addressM(addressM, 15'b000000000000000, error_cnt);


    run_sim = 1'b0;
    $display("------------------------------------------------------");
    $display("Errors occoured during the testing: %d", error_cnt);
    $display("------------------------------------------------------");
    $display("Testbench for the CPU finished (tb_cpu)");
    $display("***************************************************************************");
end


endmodule