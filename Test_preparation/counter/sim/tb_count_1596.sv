// ------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement a testbench for a counter
// Author:      SteDun
// Version:     V1.0 2021-12-10
// ------------------------------------------

module tb_count_1596();


// (1) DUT wiring
localparam BW_TB = 10;

logic [BW_TB-1:0]   data_in;
logic [BW_TB-1:0]   cnt;
logic               rst_n;
logic               load;
logic               clk5m;
logic               en;
logic               updn;


// DUT instance
count_1596 #(.BW (BW_TB)) dut(.*);


// DUT stimulation
logic run_sim = 1'b1;

initial begin
    clk5m = 1'b0;
    while(run_sim == 1'b1) begin
        #100ns;
        clk5m = ~clk5m;
    end
end


initial begin
    // set inputs to default values
    data_in = '0;
    load    = 1'b0;
    en      = 1'b0;
    updn    = 1'b0;

    // start with reset
    rst_n = 1'b0;
    #1us;
    rst_n = 1'b1;
    #1us;

    // load value to the counter
    @(negedge clk5m);
    data_in = 10'd10;
    load    = 1'b1;    

    // test upcounting
    @(negedge clk5m);
    load    = 1'b0;
    en      = 1'b1;
    updn    = 1'b0;
    #8us;

    // deactive the enable befor next test
    @(negedge clk5m);
    en      = 1'b0;
    #1us;

    // test downcounting
    @(negedge clk5m);
    en      = 1'b1;
    updn    = 1'b1;
    #5us;    

    // load zero to the counter
    @(negedge clk5m);
    en      = 1'b0;
    data_in = 10'd0;
    load    = 1'b1;
    @(negedge clk5m);
    load    = 1'b0;

    // stop simulation
    #1us;
    run_sim = 1'b0;

end


endmodule