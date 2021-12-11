// ------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement a finite state machine
// Author:      SteDun
// Version:     V1.0 2021-12-10
// ------------------------------------------

module fsm_door_1596
(
    input   logic       rst_n,
    input   logic       clk2m,
    input   logic       key_up,
    input   logic       key_down,
    input   logic       sense_up,
    input   logic       sense_down,

    output  logic       ml,
    output  logic       mr,
    output  logic       light_red,
    output  logic       light_green
);

enum logic [2:0]    {IDLE, UP, OPEN, DOWN, CLOSED} state, state_next;


// --- Sequential logic ---
always_ff @(negedge rst_n or posedge clk2m) begin
    if(~rst_n) begin
        state <= IDLE;
    end
    else begin
        state <= state_next;
    end
end


// --- Combinatorial logic ---
always_comb begin
    // default states
    state_next  = state;
    ml          = 1'b0;
    mr          = 1'b0;
    light_red   = 1'b0;
    light_green = 1'b0;

    case(state)
        IDLE: begin
            light_red = 1'b1;
            if(key_up == 1'b1) begin
                state_next = UP;
            end
        end
        UP: begin
            light_red   = 1'b1;
            mr          = 1'b1;
            if(sense_up == 1'b1) begin
                light_red   = 1'b0;
                mr          = 1'b0;
                state_next  = OPEN;
            end
        end 
        OPEN: begin
            light_green = 1'b1;
            if(key_up == 1'b1) begin
                state_next = OPEN;
            end
            else if(key_down == 1'b1) begin
                state_next      = DOWN;
                light_green     = 1'b0;
            end
        end
        DOWN: begin
            light_red   = 1'b1;
            ml          = 1'b1;
            // open overrules close
            if((key_up == 1'b1) && (key_down == 1'b1)) begin
                ml          = 1'b0;
                state_next  = OPEN;
            end 
            else if(sense_down == 1'b1) begin
                ml          = 1'b0;
                state_next  = CLOSED;
            end
        end
        CLOSED: begin
            light_red   = 1'b1;
            if(key_down == 1'b1) begin
                state_next  = CLOSED;
            end
            else if(key_up == 1'b1) begin
                state_next = UP;
            end
        end
        default: begin
            state_next = IDLE;
        end
    endcase
end


endmodule