//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Third Assignment
// Purpose  : Testbench for a D register
// Author   : SteDun
// Version  : V1.0 2021-11-10
//-------------------------------------------------------

module tb_dreg
();

// (1) Wiring the DUT
localparam WTB = 16;

logic               rst_n;
logic               clk50m;
logic               load;
logic [WTB-1:0]     d;
logic [WTB-1:0]     q;


// (2) DUT instance
dreg #(.W (WTB)) dut(.*);


// (3) DUT stimulation
logic run_sim = 1'b1;
int error_cnt = 0;


// Define the clock
// The clock should be 50 MHz
// 1s / 50 MHz = 20 ns (toggle with 10 ns - half of the period)
initial begin
    clk50m = 1'b0;
    while(run_sim) begin
        #10ns;             
        clk50m = ~clk50m;
    end
end


// Function to make the testing of the register easier
function int test_dreg(int error_cnt, logic[WTB-1:0] q, logic[WTB-1:0] d, string testingMessage);
    // Function variables to handle errors
    int errorCount;
    errorCount = error_cnt;

    // Start testing the D-Register
    $display("------------------------------------------------");
    $display("%s", testingMessage);
    assert(q == d) begin
        $display("Output equals input           --> OK");
        $display("Input:  %4h", d);
        $display("Output: %4h", q);
    end    
    else begin
        $error("Output does not equal input     --> ERROR");
        $display("Input:  %4h", d);
        $display("Output: %4h", q);
        errorCount++;
    end
    $display("------------------------------------------------");
    return errorCount;
endfunction


// Stimulate the DUT and self-checking testing of the DUT
initial begin
    $display("****************************************************************");
    $display("Welcome to the testbench for a D-Register (tb_dreg)...");
    @(negedge clk50m);
    rst_n       = 1'b0; // Reset the D-FlipFlop
    load        = 1'b0;
    d           = 'x;
    #100ns;

    // Start register by put reset signal to zero (to one because rst_n is negated)
    @(negedge clk50m);
    rst_n       = 1'b1;

    // Testing for 0xffff
    #100ns;
    @(negedge clk50m);
    d           = 16'hffff;
    @(negedge clk50m);
    load        = 1'b1;
    @(negedge clk50m);
    load        = 1'b0;
    error_cnt   = test_dreg(error_cnt, q, d, "Output must be ffff\n");

    // Testing for 0x0000
    #100ns;
    @(negedge clk50m);
    d           = 16'h0000;
    @(negedge clk50m);
    load        = 1'b1;
    @(negedge clk50m);
    load        = 1'b0;
    error_cnt   = test_dreg(error_cnt, q, d, "Output must be 0000\n");

    // Testing for 0xaa55
    #100ns;
    @(negedge clk50m);
    d           = 16'haa55;
    @(negedge clk50m);
    load        = 1'b1;
    @(negedge clk50m);
    load        = 1'b0;
    error_cnt   = test_dreg(error_cnt, q, d, "Output must be aa55\n");

    // Testing for 0x55aa
    #100ns;
    @(negedge clk50m);
    d           = 16'h55aa;
    @(negedge clk50m);
    load        = 1'b1;
    @(negedge clk50m);
    load        = 1'b0;
    error_cnt   = test_dreg(error_cnt, q, d, "Output must be 55aa\n");

    // Testing the reset function of the D-Register
    #100ns;
    @(negedge clk50m);
    rst_n       = 1'b0;
    @(negedge clk50m);
    assert(q == '0) begin
        $display("Output reset worked!          --> OK\n");
        $display("Input:  %4h", d);
        $display("Output: %4h", q);
    end
    else begin
        $error("Reset have not worked!          --> ERROR\n");
        $error("Input:  %4h", d);
        $error("Output: %4h", q);
        error_cnt++;
    end
    $display("------------------------------------------------");

    // End the test
    #100ns;
    run_sim = 1'b0;
    $display("Errors occured during testing: %d", error_cnt);
    $display("------------------------------------------------");
    $display("Testbench for D-Register (tb_dreg) finished.");
    $display("****************************************************************");
end

endmodule