//---------------------------------------------------------------
// Project   EDB HDL WS 2021
// Purpose  Implement a thre input majority voter
// Author   SteDun00
// Version  V1.0 2021-10-07
//---------------------------------------------------------------

module maj_vote 
(
    input logic         x2,
    input logic         x1,
    input logic         x0,

    output logic        y,
    output logic        ycase
);

// hand made logic :-(
assign y = (x2 & x1) | (x2 & x0) | (x1 & x0);

// create an internal 3bit bus
logic [2:0]             xbus;
assign xbus = {x2, x1, x0};
//              |   |   |
//            bit 2 |   |
//                bit 1 |
//                    bit 0

// behavorial description
// block name (description_maj_vote) is optional
always_comb begin : description_maj_vote
    // in here we can suse high level syntax
    ycase = 1'b0; // default output 
    case (xbus)
        3'b011 : ycase = 1'b1;
        3'b101 : ycase = 1'b1;
        3'b110 : ycase = 1'b1;
        3'b111 : ycase = 1'b1;
        default: ycase = 1'b0;
    endcase
    // also possible to put the default output here: ycase = 1'b0;
end


endmodule