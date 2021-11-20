//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Third Assignment
// Purpose  : Implement a D register
// Author   : SteDun
// Version  : V1.0 2021-11-10
//-------------------------------------------------------

module dreg
#(
    parameter W = 16
)
(
    // Input variables
    input logic             rst_n,
    input logic             clk50m,
    input logic             load,
    input logic [W-1:0]     d,

    // Output variable
    output logic [W-1:0]    q
);


// local signals
logic [W-1:0]               q_new;


// *** Sequencial logic ***
// Create a always ff with width = W
always_ff @( negedge rst_n or posedge clk50m) begin 
    if(!rst_n) begin
        q <= '0;
    end    
    else begin
        q <= q_new;
    end
end


// *** Combinatorial logic ***
// Describes behaviour of the D register
always_comb begin
    if(rst_n == 0) begin
        q_new = '0;
    end
    else if(load) begin
        q_new = d;
    end
    else begin
        q_new = q;
    end
end

endmodule