// -------------------------------------------------------
// Project:     EDB HDL WT2021 - Test preparation
// Purpose:     Implement a finite state machine for a garage door
// Author:      StefanDuenser
// Version:     V1.0 2021-12-14
// -------------------------------------------------------

module fsm_door_1596
(
    input   logic          rst_n,
    input   logic          clk2m,
    input   logic          key_up,
    input   logic          key_down,
    input   logic          sense_up,
    input   logic          sense_down,

    output  logic          ml,
    output  logic          mr,
    output  logic          light_red,
    output  logic          light_green
);

enum logic [2:0]    {STOP, UP, OPEN, DOWN, CLOSED}      state, state_next;


// --- Sequential logic ---
// define rst_n and states
always_ff @(negedge rst_n or posedge clk2m) begin : fsm_door_seq
    if(~rst_n) begin
        state <= STOP;
    end
    else begin
        state <= state_next;
    end
end

// --- Combinatorial logic ---
// finite state machine
always_comb begin : fsm_comb
    // default states
    state_next  = state;
    ml          = 1'b0;
    mr          = 1'b0;
    light_red   = 1'b1;
    light_green = 1'b0;

    case(state)
        STOP: begin
            if(key_up) begin
                state_next = UP;
            end
            else if(key_down) begin
                state_next = DOWN;
            end
        end
        UP: begin
            mr  = 1'b1;
            if(sense_up) begin
                state_next = OPEN;
            end
            else if(key_down && mr && ~key_up) begin
                state_next = DOWN;
            end
        end
        OPEN: begin
            light_red = 1'b0;
            light_green = 1'b1;
            if(key_up) begin
                state_next = OPEN;
            end
            if(key_down && ~key_up) begin
                state_next  = DOWN;
            end
        end
        DOWN: begin
            ml  = 1'b1;
            if(sense_down) begin
                state_next = CLOSED;
            end
            else if((key_up && ml) || (key_up && ml && key_down)) begin        // up overwrites down --> safety feature
                state_next = UP;
            end
        end
        CLOSED: begin
            if(key_down) begin
                state_next = CLOSED;
            end
            if(key_up) begin
                state_next = UP;
            end
        end
        default: begin
            state_next = STOP;
        end
    endcase
end


endmodule