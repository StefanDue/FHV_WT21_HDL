//-----------------------------------
// Project:     EDB HDL WS2021
// Purpose:     Check out the function of a microcontroller
// Author:      SteDun00
// Version:     v1.0 - 2021-12-10
//-----------------------------------

`timescale  10ns/10ns
module tb_toplevel_c5g_uart();


// (1) DUT wiring
localparam DW = 16;
localparam AW = 15;
localparam PW = 15;
logic	          		CLOCK_125_p;
logic	          		CLOCK_50_B5B;
logic	          		CLOCK_50_B6A;
logic	          		CLOCK_50_B7A;
logic	          		CLOCK_50_B8A;
logic	     [7:0]		LEDG;
logic	     [9:0]		LEDR;

logic	          		CPU_RESET_n;
logic	     [3:0]		KEY;
logic	     [9:0]		SW;
logic	     [6:0]		HEX0;
logic	     [6:0]		HEX1;
logic	     [6:0]		HEX2;
logic	     [6:0]		HEX3;
logic	          		UART_RX;
logic	          		UART_TX;

// (2) DUT instance
tb_toplevel_c5g_uart #(
    .DW         (DW),
    .AW         (AW),
    .PW         (PW)
)
dut (.*);


// (3) DUT stimulation
logic run_sim = 1'b1;

initial begin
    CLOCK_125_p = 1'b0;
    CLOCK_50_B5B = 1'b0;
    CLOCK_50_B6A = 1'b0;
    CLOCK_50_B7A = 1'b0;
    CLOCK_50_B8A = 1'b0;
    while(run_sim == 1'b1) begin
        #10ns;
        CLOCK_50_B5B = ~CLOCK_50_B5B;
    end
end



initial begin
    CPU_RESET_n = 1'b1;
    SW = '0;
    KEY = '1;
    UART_RX = 1'b0;
    #100ns;

    $readmemh("../ams/test_jmp_ledg_ledr",tb_rom32k.dut.altsyncram_component.m_default.altsyncram_inst.mem_data);
    
    $display("--- POR ---");
    @(negedge CLOCK_50_B5B);
    CPU_RESET_n = 1'b1;
    
    
    #2us;
    run_sim = 1'b0;
end

endmodule