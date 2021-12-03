//---------------------------------------
// Project:     EDB HDL WS2021
// Purpose:     Testbench for data memory (RAM, output regs, input regs)
// Author:      SteDun
// Version:     V1.0, 03/12/2021
//---------------------------------------

`timescale 10ns/10ns
module tb_data_mem ();


// (1) DUT wiring
localparam              TB_AW = 15;
localparam              TB_DW = 16;

logic                   rst_n;
logic                   clk50m;
logic                   we;            
logic [TB_DW-1:0]       data_in;       
logic [TB_AW-1:0]       addr;          
logic [TB_DW-1:0]       data_out;      
logic [TB_DW-1:0]       reg0x7000;     
logic [TB_DW-1:0]       reg0x7001;
logic [TB_DW-1:0]       reg0x7002;
logic [TB_DW-1:0]       reg0x7400;     
logic [TB_DW-1:0]       reg0x7401;
logic [TB_DW-1:0]       reg0x7402;


// (2) DUT instance
data_mem #(.AW (TB_AW), .DW (TB_DW)) dut(.*);



// (3) DUT stimulation
logic run_sim = 1'b1;

initial begin
    clk50m = 1'b0;
    while(run_sim) begin
        #10ns;
        clk50m = ~clk50m;
    end
end


initial begin
    rst_n       = 1'b0;
    addr        = '0;
    data_in     = '0;
    we          = 1'b0;
    reg0x7400   = 16'hAFFE;
    reg0x7401   = 16'hCAFE;
    reg0x7402   = 16'hBEEF;

    #90ns;
    rst_n       = 1'b1;

    #100ns;
    // --- Write to RAM and read back ---
    @(negedge clk50m);
    addr        = 16'h7000;
    data_in     = 16'd15;
    we          = 1'b1;
    @(negedge clk50m);
    we          = 1'b0;
    #100ns;

    @(negedge clk50m);
    addr        = 16'h7001;
    data_in     = 16'd845;
    we          = 1'b1;
    @(negedge clk50m);
    we          = 1'b0;
    #100ns;

    @(negedge clk50m);
    addr        = 16'h7002;
    data_in     = 16'd8754;
    we          = 1'b1;
    @(negedge clk50m);
    we          = 1'b0;



    #100ns;
    run_sim = 1'b0;
end

endmodule