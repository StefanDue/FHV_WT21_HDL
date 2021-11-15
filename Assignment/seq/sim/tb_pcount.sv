//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Third Assignment
// Purpose  : Testbench for a program counter
// Author   : SteDun
// Version  : V1.0 2021-11-10
//-------------------------------------------------------

module tb_pcount
();


// (1) Wiring the DUT
localparam WTB = 15;

logic               rst_n;
logic               clk50m;
logic               load;
logic               inc;
logic[WTB-1:0]      cnt_in;
logic[WTB-1:0]      cnt;


// (2) DUT instance
pcount #(.W (WTB)) dut(.*);


// (3) DUT stimulation
logic run_sim = 1'b1;
int error_cnt = 0;
int cnt_before_counting = 0;
int cnt_after_counting = 0;


// Define the clock
// The clock should run with 50 MHz
// 1s / 50MHh = 20ns (toggle with 10ns - half of the period)
initial begin
    clk50m = 1'b0;
    while(run_sim) begin
        #10ns;
        clk50m = ~clk50m;
    end
end


initial begin
    $display("****************************************************************");
    $display("Welcome to the testbench for a program counter (tb_pcount)...");
    @(negedge clk50m);
    rst_n   = 1'b0;   // Reset the counter
    load    = 1'b0;
    inc     = 1'b0;
    cnt_in  = 'x;
    #100ns;

    // Put reset signal to high that the counter can start counting
    @(negedge clk50m);
    rst_n   = 1'b1;
    #100ns;


    // Testing of the loading function of the program counter
    @(negedge clk50m);
    cnt_in  = 2453;
    @(negedge clk50m);
    load    = 1'b1;
    @(negedge clk50m);
    load    = 1'b0;
    $display("---------------------------------------------------------");
    assert(cnt == cnt_in) begin
        $display("Loading of a program was successful       --> OK");
        $display("Input:  %d", cnt_in);
        $display("Output: %d", cnt);
    end
    else begin
        $error("Loading of a program number failed        --> ERROR");
        $error("Input:  %d", cnt_in);
        $error("Output: %d", cnt);
        error_cnt++;
    end 
    $display("---------------------------------------------------------");
    #100ns;


    // Testing of the reset function of the program counter
    @(negedge clk50m);
    rst_n   = 1'b0;
    @(negedge clk50m);
    $display("---------------------------------------------------------");
    assert(cnt == '0) begin
        $display("Reseting the program counter was successful       --> OK");
        $display("Input:  %d", cnt_in);
        $display("Output: %d", cnt);
    end 
    else begin
        $error("Reseting the program counter failed               --> ERROR");
        $error("Input:  %d", cnt_in);
        $error("Output: %d", cnt);
        error_cnt++;
    end
    $display("---------------------------------------------------------");


    // Test the counting function of the program counter
    @(negedge clk50m);
    rst_n   = 1'b1;
    cnt_in  = '0;
    $display("---------------------------------------------------------");
    cnt_before_counting = cnt;
    @(negedge clk50m);
    inc     = 1'b1;
    for(int i = 0; i < 500; i += 1) begin
        @(negedge clk50m);
    end
    cnt_after_counting = cnt;
    assert(cnt_before_counting >= cnt_after_counting) begin
        $error("Incrementing did not work!      --> ERROR");
        $error("Input:                      %d", cnt_in);
        $error("Output before incrementing: %d", cnt_before_counting);
        $error("Output after incrementing:  %d", cnt_after_counting);
        error_cnt++;
    end 
    else begin
        $display("Incrementing was successful!      --> OK");
        $display("Input:                            %d", cnt_in);
        $display("Output before incrementing: %d", cnt_before_counting);
        $display("Output after incrementing:  %d", cnt_after_counting);  
    end

    // Check input and output at the program counter
    $display("\nSecond test to proof the upcounting of the program counter");
    cnt_before_counting = cnt;
    $display("Output: %d", cnt);
    @(negedge clk50m);
    inc     = 1'b1;
    $display("Output: %d", cnt);
    $display("---------------------------------------------------------");


    // End the test
    #3us;
    run_sim = 1'b0;
    $display("Errors occured during testing: %d", error_cnt);
    $display("---------------------------------------------------------");
    $display("Testbench for program counter (tb_pcount) finished.");
    $display("****************************************************************");
end

endmodule