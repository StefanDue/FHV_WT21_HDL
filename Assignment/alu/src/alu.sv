//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Second Assignment
// Purpose  : Implement an ALU
// Author   : SteDun
// Version  : V1.0 2021-10-19
//-------------------------------------------------------

module alu

// set parameters to make variable input/output sizeable
#(
    parameter W = 16       // the input and output should consists of 16 bits
)
(
    // 16 bit input values
    input logic [W-1:0]    x,          // input bus x
    input logic [W-1:0]    y,          // input bus y

    // input control bits
    input logic             zx,   
    input logic             nx,   
    input logic             zy,   
    input logic             ny,   
    input logic             f,    
    input logic             no,   

    // 16 bit output
    output logic [W-1:0]    out,   

    // output control flags
    output logic            zr,     
    output logic            ng      
);


// create an internal 6 bit bus for the input control bits
logic [5:0]         c;
assign c = {zx, nx, zy, ny, f, no};

logic [W-1:0]   x_temp;
logic [W-1:0]   y_temp;


    // behaviour description for the ALU out output
    always_comb begin : description_out

        x_temp      = x;
        y_temp      = y;

        // zx - pre-setting the x input
        if (zx) begin
            x_temp = '0;
        end

        // nx - pre-setting the x input
        if (nx) begin
            x_temp = ~x_temp;
        end

        // zy - pre-setting the y input
        if (zy) begin
            y_temp = '0;
        end

        // ny - pre-setting the y input
        if (ny) begin
            y_temp = ~y_temp;
        end

        // f - selection betwen computing + or &
        if (f) begin
            out = x_temp + y_temp;
        end
        else begin
            out = x_temp & y_temp;
        end

        // no - post-setting the output
        if (no) begin
            out = ~out;
        end

        // Output flag zr - Check if the output is ZERO
        if (out == 0) begin
            zr = 1'b1;
        end
        else begin
            zr = 1'b0;
        end

        // Output flag ng - Check for negative result
        if (out[W-1] == 1) begin
            ng = 1'b1;
        end
        else begin
            ng = 1'b0;
        end
    end
endmodule