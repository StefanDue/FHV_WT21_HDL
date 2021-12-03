//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Fifth Assignment
// Purpose  : Implement an UART receive (uart_rx)
// Author   : SteDun
// Version  : V1.0 2021-12-10
//-------------------------------------------------------

module uart_rx
#(
    parameter WIDTH = 8,
    parameter FCLK  = 50000000,    // 50 MHz clock
    parameter FBAUD = 115200
)
(
    input logic                 rst_n,
    input logic                 clk50m,
    input logic                 rx,

    output logic [WIDTH-1:0]    rx_data,
    output logic                rx_ready,
    output logic                rx_idle,
    output logic                rx_error
);


// --- localparameters ---
localparam WIDTHCNT_INIT    = ((FCLK / FBAUD) -1);
localparam WIDTHCNT_WIDTH   = $clog2(WIDTHCNT_INIT);
localparam SAMPLECNT_INIT   = WIDTHCNT_INIT / 2;


// --- local signals ---
logic                           widthcnt_zero;
logic                           widthcnt_load;
logic [WIDTHCNT_WIDTH-1:0]      widthcnt;
logic                           bitcnt_inc;
logic                           bitcnt_init;
logic [2:0]                     bitcnt;
logic                           widthcnt_sample;
logic [SAMPLECNT_WIDTH-1:0]     samplecnt;

logic                           receive_ready;
logic                           receive_error;


// --- FSM ---
enum logic [2:0] {IDLE, START, SMPL, DATA, STOP}    state, state_next;
assign widthcnt_sample = (withcnt == SAMPLECNT_INIT);


always_ff @(negedge rst_n or posedge clk50m) begin : fsm_seq
    if(~rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= state_next;
    end
end


always_comb begin : fsm_comb
    // Default values
    state_next      = state;
    rx_idle         = 1'b0;     // Flag is just one if idel state is present
    widthcnt_load   = 1'b0;
    withcnt_init    = 1'b0;
    bitcnt_init     = 1'b0;
   case(state)
        IDLE: begin
            rx_idle = 1'b1;
            if(posedge rx) begin
                state_next = START;
                widthcnt_load = 1'b1;  
            end
        end
        START: begin
            receive_error    = 1'b0;     // Cleared as soon as a new frame startes
            receive_ready    = 1'b0;     // Cleared as soon as a new frame startes
            if(widthcnt_zero) begin
                state_next      = SMPL;
                widthcnt_load   = 1'b1;
                bitcnt_init     = 1'b1;
            end
        end
        SMPL: begin
            if(widthcnt_sample) begin
                state_next = DATA;
                rx_data[bitcnt] = rx;
            end
        end
        DATA: begin
            if((widthcnt_zero) && (bitcnt < 3'd7)) begin
                state_next      = SMPL;
                widthcnt_load   = 1'b1;
                bitcnt_inc      = 1'b1;
            end  
            else if((widthcnt_zero) && (bitcnt >= 3'd7)) begin
                state_next      = STOP;
                widthcnt_load   = 1'b1;
            end
            else if (widthcnt_sample == SAMPLECNT_INIT) begin
                state_next      = SMPL;
            end
        end
        STOP: begin
            if((rx == 1'b0) && ()) begin
                receive_error   = 1'b1;
            end
           if(widthcnt_zero) begin
               state_next       = IDLE;
               receive_ready    = 1'b1;
           end
        end
        default: begin
            state_next = IDLE;
        end
   endcase 
end


// --- WIDTHCNT counter ---
always_ff @(negedge rst_n or posedge clk50m) begin : widthcnt_counter
    if(~rst_n) begin
        widthcnt <= '0;
    end
    else if(widthcnt_load) begin
        widthcnt <= WIDTHCNT_INIT;
    end
    else if(~widthcnt_zero) begin
        widthcnt <= widthcnt - 1'b1;
    end
end
assign widthcnt_zero = (widthcnt == '0);


// --- BITCNT counter ---
always_ff @(negedge rst_n or posedge clk50m) begin : bitcnt_counter
    if(~rst_n) begin
        bitcnt <= '0;
    end
    else if(bitcnt_init) begin
        bitcnt <= '0;
    end
    else if(bitcnt_inc) begin
        bitcnt <= bitcnt + 1'b1;
    end
end


// --- FF to save flag rx_ready ---
always_ff @(negedge rst_n or posedge clk50m) begin : rx_ready_flag
    if(~rst_n || ~receive_ready) begin
        rx_ready <= 1'b0;
    end
    else if(receive_ready) begin
        rx_ready <= 1'b1;
    end
    else begin
        rx_ready <= rx_ready;
    end
end


// --- FF to save flag rx_error ---
always_ff @(negedge rst_n or posedge clk50m) begin : rx_error_flag
    if(~rst_n || ~receive_error) begin
        rx_error <= 1'b0;
    end
    else if(receive_error) begin
        rx_error <= 1'b1;
    end
    else begin
        rx_error <= rx_error;
    end
end


endmodule