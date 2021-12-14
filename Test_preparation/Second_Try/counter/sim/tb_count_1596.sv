// ------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement a testbench for a counter
// Author:      SteDun
// Version:     V1.0 2021-12-10
// ------------------------------------------

module tb_count_1596 ();


// (1) DUT wiring
localparam WIDTH = 10;

logic               rst_n;
logic               clk5m;
logic               load;
logic               updn;
logic               en;
logic [WIDTH-1:0]   data_in;
logic [WIDTH-1:0]   cnt;


// (2) DUT instance
count_1596 #(.WIDTH (WIDTH)) dut(.*);


// (3) DUT stimulation
logic run_sim = 1'b1;


initial begin
     clk5m = 1'b0;
     while(run_sim == 1'b1) begin
         #100ns;
         clk5m = ~clk5m;
     end
end


initial begin
    // start with power on reset
    rst_n = 1'b0;
    #2us;
    @(negedge clk5m);
    rst_n = 1'b1;

    // set relevant inputs to zero (before reset)
    en      = 1'b0;
    load    = 1'b0;
    updn    = 1'b0;
    data_in = '0;

    // check the enable function by counting zu and later set en to zero 
    @(negedge clk5m);
    en      = 1'b1;
    updn    = 1'b0;
    #5us;
    @(negedge clk5m);
    en = 1'b0;
    #2us;

    // check load function by setting counter to zero
    @(negedge clk5m);
    en      = 1'b1;
    data_in = '0;
    load    = 1'b1;
    @(negedge clk5m);
    en      = 1'b0;
    load    = 1'b0;
    #2us;

    // check upcount function
    @(negedge clk5m);
    en      = 1'b1;
    updn    = 1'b0;
    #3us;
    //check parallel loading
    @(negedge clk5m);
    data_in     = 10'd40;
    load        = 1'b1;
    @(negedge clk5m);
    load = 1'b0;
    #5us;

    //check downcounting
    @(negedge clk5m);
    en = 1'b0;
    #5us;
    @(negedge clk5m);
    updn    = 1'b1;
    en      = 1'b1;
    #5us;
    @(negedge clk5m);
    en = 1'b0;
    #2us;

    // set counter to zero again
    @(negedge clk5m);
    en          = 1'b1;
    data_in     = '0;
    load        = 1'b1;
    @(negedge clk5m);
    load    = 1'b1;
    updn    = 1'b0;
    en      = 1'b0;
    #5us;

    run_sim = 1'b0;

end

endmodule