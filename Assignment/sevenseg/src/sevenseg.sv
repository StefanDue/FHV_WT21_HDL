//-------------------------------------------------------
// Project      EDB HDL WS 2021 - First Assignment
// Purpose      Implement a seven segment display 
// Author       SteDun00
// Version      V1.0 2021-10-19
//-------------------------------------------------------

module sevenseg
(
    input logic [3:0]       bin,

    output logic [6:0]  	hex,
    output logic [6:0]      hexn
);

// hexn is the negated output of hex --> use bitwise negation (~) to invert the hex output
assign hexn = ~hex;


// behavior description for the hex output
always_comb begin : description_sevenseg_hex
    hex = 7'b0000000;                 // default behaviour of the output when no input is set
    case(bin)                         // dez      hex
        4'b0000 : hex = 7'b0111111;   //  0        0    
        4'b0001 : hex = 7'b0000110;   //  1        1
        4'b0010 : hex = 7'b1011011;   //  2        2
        4'b0011 : hex = 7'b1001111;   //  3        3
        4'b0100 : hex = 7'b1100110;   //  4        4
        4'b0101 : hex = 7'b1101101;   //  5        5
        4'b0110 : hex = 7'b1111101;   //  6        6
        4'b0111 : hex = 7'b0000111;   //  7        7
        4'b1000 : hex = 7'b1111111;   //  8        8
        4'b1001 : hex = 7'b1101111;   //  9        9
        4'b1010 : hex = 7'b1110111;   //  10       A
        4'b1011 : hex = 7'b1111100;   //  11       B
        4'b1100 : hex = 7'b0111001;   //  12       C
        4'b1101 : hex = 7'b1011110;   //  13       D
        4'b1110 : hex = 7'b1111001;   //  14       E
        4'b1111 : hex = 7'b1110001;   //  15       F
    endcase     
end

endmodule