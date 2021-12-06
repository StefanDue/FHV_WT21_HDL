//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Fifth Assignment
// Purpose  : Implement a testbench for an UART receive (uart_rx)
// Author   : SteDun
// Version  : V1.0 2021-12-10
//-------------------------------------------------------

module tb_uart_rx 
();

// (1) DUT wiring
localparam WIDTH_TB     = 8;
localparam FCLK_TB      = 50000000;
localparam FBAUD_TB     = 115200;


// Input and output parameters for the UART RX
logic                   rst_n;
logic                   clk50m;
logic                   rx;
logic [WIDTH_TB-1:0]    rx_data;
logic                   rx_ready;
logic                   rx_idle;
logic                   rx_error;

// Input and output parameters for the UART TX - just additional parameters
logic [WIDTH_TB-1:0]    tx_data;
logic                   tx_start;
logic                   tx;
logic                   tx_idle;



// (2) DUT instance
uart_rx #(.WIDTH (WIDTH_TB), .FCLK (FCLK_TB), .FBAUD (FBAUD_TB)) uart_rx (.*);

uart_tx #(.WIDTH (WIDTH_TB), .FCLK (FCLK_TB), .BAUD (FBAUD_TB)) uart_tx (
    .rst_n_i    (rst_n),
    .clk_i      (clk50m),
    .data_i     (tx_data),
    .tx_start_i (tx_start),
    .tx_o       (tx),
    .idle_o     (tx_idle)
);



// (3) DUT stimulation
// --- local paramter ---
int error_cnt = 0;
logic run_sim = 1'b1;

// Define the system clock for the testbench
initial begin
    clk50m = 1'b0;
    while (run_sim == 1'b1) begin
        #10ns;
        clk50m = ~clk50m;
    end
end



initial begin
    $display("***************************************************************************");
    $display("Welcome to the testbench for an UART Reseive (tb_uart_rx)");
    rst_n = 1'b0;
    tx_data = '0;
    tx_start = 1'b0;
    #90ns;

    rst_n = 1'b1;


    #100ns;
    run_sim = 1'b0;
    $display("------------------------------------------------------");
    $display("Errors occoured during the testing: %d", error_cnt);
    $display("------------------------------------------------------");
    $display("Testbench for the UART Receive finished (tb_uart_rx)");
    $display("***************************************************************************");    
end



endmodule