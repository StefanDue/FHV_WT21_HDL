// --------------------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement combinatorial logic
// Author:      SteDun
// Version:     V1.0 2021-12-10
// --------------------------------------------------------

module lut_1596 
#(
    parameter WIDTH = 4
)
(
    input   logic [WIDTH-1:0]     x,
    output  logic                 y
);


always_comb begin
    // define default state for output
    y = 1'b0;
    case(x)
        4'b0100 :   y = 1'b1;
        4'b1000 :   y = 1'b1;
        4'b1010 :   y = 1'b1;
    endcase
end

endmodule