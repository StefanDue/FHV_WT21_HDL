//-----------------------------------------------------------
// Project  : EDB HDL WS2021 - Fourth Assignment
// Purpose  : Implementation of a jump controller for a CPU
// Author   : SteDun
// Version  : V1.0 2021-11-26
//-----------------------------------------------------------

module jump_ctrl
(
    input logic cmd_j1,
    input logic cmd_j2,
    input logic cmd_j3, 
    input logic zr,
    input logic ng,

    output logic pc_load,
    output logic pc_inc
);

    // Define internal jump command bus
    logic [2:0]     jBus;
    assign jBus = {cmd_j1, cmd_j2, cmd_j3};


    // Implement a combinatorial logic for the jump controller
    always_comb begin : jump_control
        // Default condition will be the incrementation of the programm counter
        // Use default statements - no else statement needed inside the cases
        pc_load = 1'b0;
        pc_inc  = 1'b1;

        case (jBus) 
            // NULL - do not jump
            3'b000 : begin
                // Use the default definition
            end
            // Jump Greater Than (>0)  -->  ALU-output is not zero and not negative
            3'b001 : begin
                if(~zr & ~ng) begin
                    pc_load = 1'b1;
                    pc_inc  = 1'b0;
                end
            end
            // Jump EQual (=0)  -->  ALU-output is zero 
            3'b010 : begin
                if(zr) begin
                    pc_load = 1'b1;
                    pc_inc  = 1'b0;
                end
            end
            // Jump Greater Equal (>=0)  -->  ALU-output is zero or greater and not null
            3'b011 : begin
                if(~ng) begin
                    pc_load = 1'b1;
                    pc_inc  = 1'b0;
                end
            end
            // Jump Lower Than (<0)  --> ALU-output is lower than zero and negative
            3'b100 : begin
                if(~zr & ng) begin
                    pc_load = 1'b1;
                    pc_inc  = 1'b0;
                end
            end
            // Jump Not Equal (!=0)  -->  ALU-output is not zero and could be negative
            3'b101 :  begin
                if(~zr) begin
                    pc_load = 1'b1;
                    pc_inc  = 1'b0;
                end
            end
            // Jump Lower Equal (<=0)  -->  ALU-output can be zero and is negative
            3'b110 : begin
                if(zr | ng) begin
                    pc_load = 1'b1;
                    pc_inc  = 1'b0;
                end
            end
            // Jump  -->  always jump
            3'b111 : begin
                pc_load = 1'b1;
                pc_inc  = 1'b0;
            end
            default : begin
                // Default is set before the case
            end
        endcase
    end

endmodule