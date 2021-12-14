// ------------------------------------------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement a finite state machine traffic light
// Author:      SteDun
// Version:     V1.0 2021-12-13
// ------------------------------------------------------------------------------

module traffic_light 
#(
    parameter WIDTH = 16
)
(
    input   logic           rst_n,
    input   logic           clk50m,
    input   logic           start,
    input   logic           night,

    output  logic           green,
    output  logic           yellow,
    output  logic           red
);


// define local variables
logic                   t;
logic                   idle;
logic                   green_blinking;
logic                   yellow_blinking;
logic [WIDTH-1:0]       cnt_timer;
logic [WIDTH-1:0]       cnt_timer_load_value;
logic                   cnt_timer_load;
logic                   cnt_timer_zero;
logic                   red_green_wait;
logic                   yellow_wait;

enum logic [2:0]    {IDLE, RED, YELLOW_RED, GREEN, GREEN_BLINKING, YELLOW_GREEN} state, state_next;


// --- Sequential logic ---
always_ff @(negedge rst_n or posedge clk50m) begin : fsm_seq
    if(~rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= state_next;
    end
end


// --- Timer ---
always_ff @(negedge rst_n or posedge clk50m) begin : counter_timer
    if(~rst_n) begin
        cnt_timer   <= '0;
    end
    else if(cnt_timer_load) begin
        cnt_timer   <= cnt_timer_load_value;
    end
    else if(~cnt_timer_zero) begin
        cnt_timer   <= cnt_timer - 1'b1;
    end
end
assign cnt_timer_zero = (cnt_timer =='0);


// --- Combinatorial logic ---
always_comb begin
    // default value
    state_next          = state;
    idle                = 1'b0;
    green               = 1'b0;
    red                 = 1'b0;
    green_blinking      = 1'b0;
    yellow_blinking     = 1'b0;

    case(state)
        IDLE: begin
           idle             = 1'b1;
           yellow_blinking  = 1'b1;
           if(night == 1'b1) begin
               state_next   = IDLE;
           end
           else if(start == 1'b1) begin
               state_next       = RED;
           end
        end
        RED: begin
            red         = 1'b1;
            if(t == red_green_wait)
        end


    default: begin
        state_next = IDLE;
    end
    endcase
end