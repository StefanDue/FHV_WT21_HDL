// ------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement combinatorial logic
// Author:      SteDun
// Version:     V1.0 2021-12-10
// ------------------------------------------

module lut_1596
(
    input   logic [3:0]     x_i,
    output  logic           y_o
);


// --- define combinatorial logic ---
always_comb begin
    y_o = 1'b0;   // default y state
    case(x_i)
        4'b0000 :   y_o = 1'b0;
        4'b0001 :   y_o = 1'b0;
        4'b0010 :   y_o = 1'b0;
        4'b0011 :   y_o = 1'b0;
        4'b0100 :   y_o = 1'b1;
        4'b0101 :   y_o = 1'b0;
        4'b0110 :   y_o = 1'b0;
        4'b0111 :   y_o = 1'b0;
        4'b1000 :   y_o = 1'b1;
        4'b1001 :   y_o = 1'b0;
        4'b1010 :   y_o = 1'b1;
        4'b1011 :   y_o = 1'b0;
        4'b1100 :   y_o = 1'b0;
        4'b1101 :   y_o = 1'b0;
        4'b1110 :   y_o = 1'b0;
        4'b1111 :   y_o = 1'b0;
    endcase
        
end

endmodule