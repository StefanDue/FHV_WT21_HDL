//-------------------------------------
// Project  : EDB HDL WS2021
// Purpose  : Implement a testbench for the UART TX
// Author   : SteDun
// Version  : V 1.0 2021-11-11
//-------------------------------------

module tb_uart_tx
();

// (1) Wirint the DUT
    localparam       FCLK_TB = 50000000;
    localparam       BAUD_TB = 115200;

    logic            rst_n_i;
    logic            clk_i;
    logic [7:0]      data_i;
    logic            tx_start_i;

    logic            tx_o;
    logic            idle_o;

// (2) DUT instance
    uart_tx #(.FCLK (FCLK_TB), .BAUD (BAUD_TB)) dut(.*);

// (3) DUT stimulation       
logic run_sim = 1'b1;

initial begin
    clk_i = 1'b0;
    while (run_sim) begin
        #10ns;
        clk_i = ~clk_i;
    end
end

initial begin
    rst_n_i     = 1'b0;
    data_i      = 0;
    tx_start_i  = 1'b0;

    #95ns;
    rst_n_i     = 1'b1;

    #1us;
    @(negedge clk_i);
    data_i      = 8'hAA;
    tx_start_i  = 1'b1;

    #100ns;
    @(posedge idle_o);

    #1us;
    run_sim = 1'b0;
end

endmodule