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
int error_cnt           = 0;
int bitwidth            = 0;
logic run_sim           = 1'b1;
logic rx_error_active   = 1'b0;
logic error             = 1'b0;


// Define the system clock for the testbench
initial begin
    clk50m = 1'b0;
    while (run_sim == 1'b1) begin
        #10ns;
        clk50m = ~clk50m;
    end
end

// Check if an rx error is currently active
always_comb begin : error_check
    if(rx_error_active == 1'b1) begin
        rx = error;
    end
    else begin
        rx = tx;
    end
end


// Function to check the UART RX
function int check_uart_rx(int error_cnt, logic [WIDTH_TB-1:0] rx_data, logic [WIDTH_TB-1:0] tx_data, logic rx_ready, logic rx_idle, logic rx_error);
    int errorCount;
    errorCount = error_cnt;
    assert(rx_data == tx_data) begin
        $display("Received UART message equals Sent UART message");
        $display("UART RX: %h", rx_data);
        $display("UART TX: %h", tx_data);
        $display("Flag ready: %b", rx_ready);
        $display("Flag error: %b", rx_error);
        $display("Flag idle:  %b", rx_idle);
    end
    else begin
        $error("Error during receiving UART message occured");
        $display("UART RX: %h", rx_data);
        $display("UART TX: %h", tx_data);
        $display("Flag ready: %b", rx_ready);
        $display("Flag error: %b", rx_error);
        $display("Flag idle:  %b", rx_idle);
        errorCount++;
    end
    return errorCount;
endfunction


// Function to check flags before receiving
function int check_uart_rx_flag(int error_cnt, logic rx_ready, logic rx_idle, logic rx_error);
    int errorCount;
    errorCount = error_cnt;
    assert((rx_ready == 1'b0) && (rx_idle == 1'b1) && (rx_error == 1'b0)) begin
        $display("UART RX flags as expected");
        $display("RX ready: %b", rx_ready);
        $display("RX idle:  %b", rx_idle);
        $display("RX error: %b", rx_error);
    end
    else begin
        $error("UART RX flags are not as expected - unexpected flag status");
        $display("RX ready: %b", rx_ready);
        $display("RX idle:  %b", rx_idle);
        $display("RX error: %b", rx_error);
        errorCount++;
    end
    return errorCount;
endfunction



initial begin
    $display("***************************************************************************");
    $display("Welcome to the testbench for an UART Reseive (tb_uart_rx)");

    $display("------------------------------------------------------");
    $display("------------------------------------------------------");
    $display("Start with a reset");
    rst_n = 1'b0;
    tx_data = '0;
    tx_start = 1'b0;
    #90ns;

    rst_n = 1'b1;
    #50us;

    // --- Send 0xA5 over UART TX to UART RX ---
    $display("------------------------------------------------------");
    $display("Check for 0xA5");
    @(negedge clk50m);
    tx_data     = 8'hA5;
    tx_start    = 1'b1;
    #100ns;
    tx_start    = 1'b0;
    //error_cnt = check_uart_rx_flag(rx_ready, rx_idle, rx_error);
    @(posedge tx_idle);
    @(negedge clk50m);
    error_cnt = check_uart_rx(error_cnt, rx_data, tx_data, rx_ready, rx_idle, rx_error);
    #10us;

    $display("------------------------------------------------------");
    $display("Check for 0x5A");
    @(negedge clk50m);
    tx_data     = 8'h5A;
    tx_start    = 1'b1;
    #100ns;
    tx_start    = 1'b0;
    //error_cnt = check_uart_rx_flag(rx_ready, rx_idle, rx_error);
    @(posedge tx_idle);
    @(negedge clk50m);
    error_cnt = check_uart_rx(error_cnt, rx_data, tx_data, rx_ready, rx_idle, rx_error);
    #10us;

    $display("------------------------------------------------------");
    $display("Check for 0x00");
    @(negedge clk50m);
    tx_data     = 8'h00;
    tx_start    = 1'b1;
    #100ns; 
    tx_start    = 1'b0;
    $display("%b %b %b", rx_ready, rx_idle, rx_error);
    //error_cnt = check_uart_rx_flag(rx_ready, rx_idle, rx_error);
    @(posedge tx_idle);
    @(negedge clk50m);
    error_cnt = check_uart_rx(error_cnt, rx_data, tx_data, rx_ready, rx_idle, rx_error);
    #10us;

    $display("------------------------------------------------------");
    $display("Check for 0xFF");
    @(negedge clk50m);
    tx_data     = 8'hFF;
    tx_start    = 1'b1;
    #100ns;
    tx_start    = 1'b0;
    //error_cnt = check_uart_rx_flag(rx_ready, rx_idle, rx_error);
    @(posedge tx_idle);
    @(negedge clk50m);
    error_cnt = check_uart_rx(error_cnt, rx_data, tx_data, rx_ready, rx_idle, rx_error);
    #10us;

    $display("------------------------------------------------------");
    $display("Check for a forced framing fault");
    @(negedge clk50m);
    tx_data     = 8'h00;
    tx_start    = 1'b1;
    #100ns;
    tx_start    = 1'b0;

    #85us;
    rx_error_active = 1'b1;
    error = 1'b0;
    #1us;
    rx_error_active = 1'b0;
    @(posedge rx_idle);


    #50us;
    run_sim = 1'b0;
    $display("------------------------------------------------------");
    $display("Errors occoured during the testing: %d", error_cnt);
    $display("------------------------------------------------------");
    $display("Testbench for the UART Receive finished (tb_uart_rx)");
    $display("***************************************************************************");    
end



endmodule