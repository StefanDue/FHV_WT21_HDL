//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Third Assignment
// Purpose  : Implement a program counter
// Author   : SteDun
// Version  : V1.0 2021-11-10
//-------------------------------------------------------

module pcount
#(
    parameter W = 15
)
(
    // Inputs
    input logic             rst_n,
    input logic             clk50m,
    input logic             load,
    input logic             inc,
    input logic [W-1:0]     cnt_in,

    // Outputs
    output logic [W-1:0]    cnt
);


// Local signals
logic [W-1:0]               cnt_new;


// *** Sequencial logic ***
// Create an always FF for the program counter with width = W
always_ff @( negedge rst_n or posedge clk50m ) begin
    if(!rst_n) begin
        cnt <= '0;
    end
    else begin
        cnt <= cnt_new;
    end
end

// *** Combinatorial logic ***
// Describe the behaviour of the program counter
always_comb begin 
    if(!rst_n) begin
        cnt_new = '0;
    end
    else if(load) begin
        cnt_new = cnt_in;
    end
    else if(inc) begin
        cnt_new = cnt + 1;
    end
    else begin
        cnt_new = cnt;
    end
end

endmodule