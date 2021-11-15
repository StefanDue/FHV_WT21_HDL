//----------------------------------
// Project: EDB HDL WS2021
// Purpose: Show integer arithmetics unsigned
// Author:  SteDun
// Verion:  1.0 2021-10-21
//----------------------------------

module adder_unsigned

// set parameters to make variable input/output sizes
#(
    parameter WIDTH = 3    // 3 is the default and can be overridden. 
)
(
    input logic [WIDTH-1:0]       x1,
    input logic [WIDTH-1:0]       x2,
    
    output logic [WIDTH-1:0]      sum
);

// We need signals that are one bit wider
logic [WIDTH:0]                   x1_temp;
logic [WIDTH:0]                   x2_temp;

logic [WIDTH:0]                   sum_temp;

assign x1_temp = {1'b0,x1};
assign x2_temp = {1'b0,x2};


//One line is just enough to implement the adder
assign sum_temp = x1_temp + x2_temp;


// Overflow detection
assign sum = sum_temp[WIDTH] ? '1: sum_temp[WIDTH-1:0];
//                |             |           |
//         check the MSB    all ones    use the LSBs


endmodule