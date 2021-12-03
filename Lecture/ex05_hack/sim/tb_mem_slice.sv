//---------------------------------------------------------
// Project:     EDB HDL WS2021
// Purpose:     Testbench for memory mapped output for the HAC computer
// Author:      SteDun
// Version:     V1.0, 02/12/2021
//---------------------------------------------------------

module tb_mem_slice ();


// (1) Wiring the DUT
localparam TB_ADDRESS = 15'h7400;
localparam TB_DW = 16;
localparam TB_AW = 15;

logic                 rst_n;
logic                 clk50m;
logic [TB_AW-1:0]     addr;
logic [TB_DW-1:0]     data_in;
logic                 we;

logic [TB_DW-1:0]     data_out;



// DUT instance
mem_slice #(.AW (TB_AW), .DW (TB_DW), .ADDRESS (TB_ADDRESS)) dut(.*);



// DUT stimulation
logic run_sim = 1'b1;

initial begin
    clk50m = 1'b0;
    while(run_sim) begin
        #10ns;
        clk50m = ~clk50m;
    end
end


initial begin
    rst_n   = 1'b0;
    addr    = '0;
    data_in = '0;
    we      = 1'b0;

    #90ns;
    rst_n = 1'b1;

    #1us;
    @(negedge clk50m);
    addr    = 15'h7400;     // wrong address
    data_in = '1;
    we      = 1'b1;
    @(negedge clk50m);
    we      = 1'b0;
    @(negedge clk50m);
    assert(data_out == '1) else begin
        $error("data_out wrong for the address %h", addr);
    end


    #1us;
    @(negedge clk50m);
    addr    = 15'h7401; // correct address
    data_in = '1;
    we      = 1'b1;
    @(negedge clk50m);
    we      = 1'b0;
    @(negedge clk50m);
    assert(data_out == '1) else begin
        $error("Wrong data out for the addr = %h", addr);
    end


    #1us;
    run_sim = 1'b0;

end

endmodule