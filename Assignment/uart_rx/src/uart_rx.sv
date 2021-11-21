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


// --- local signals ---
logic                           widthcnt_zero;
logic                           widthcnt_load;
logic [WIDTHCNT_WIDTH-1:0]      widthcnt;
logic                           bitcnt_inc;
logic                           bitcnt_init;
logic [2:0]                     bitcnt;
logic                           rx_posedge;
logic                           widthcnt_sample;


// --- FSM ---
enum logic [1:0] {IDLE, START, SMPL, DATA, STOP}    state, state_next;


always_ff @(negedge rst_n or posedge clk50m) begin : fsm_seq
    if(~rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= state_next;
    end
end


always_comb begin : fsm_comb

   case(state)
        IDLE: begin
            if(rx_posedge) begin
                state_next = START;  
            end
        end
        START: begin
            if(widthcnt_zero) begin
                state_next = SMPL;
            end
        end
        SMPL: begin
            if(widthcnt_sample) begin
                state_next = DATA;
            end
        end
        DATA: begin
            if((widthcnt_zero) && (bitcnt < 3'd7)) begin
                state_next = SMPL;
            end  
            else if((widthcnt_zero) && (bitcnt >= 3'd7)) begin
                state_next = STOP;
            end
        end
        STOP: begin
           if(widthcnt_zero) begin
               state_next = IDLE;
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



endmodule