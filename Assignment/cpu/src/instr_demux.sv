//-----------------------------------------------------------
// Project  : EDB HDL WS2021 - Fourth Assignment
// Purpose  : Implementation of a demultiplexer for a CPU
// Author   : SteDun
// Version  : V1.0 2021-11-24
//-----------------------------------------------------------

module instr_demux
    #(
    parameter DW = 16
    )
    (
    input   logic [DW-1:0]      instr,

    output  logic               instr_type,
    output  logic [DW-1:0]      instr_v,
    output  logic               cmd_a,
    output  logic               cmd_c1,
    output  logic               cmd_c2,
    output  logic               cmd_c3,
    output  logic               cmd_c4,
    output  logic               cmd_c5,
    output  logic               cmd_c6,
    output  logic               cmd_d1,
    output  logic               cmd_d2,
    output  logic               cmd_d3,
    output  logic               cmd_j1,
    output  logic               cmd_j2,
    output  logic               cmd_j3
    );



    // Behaviour description for the instruction demultiplexer
    always_comb begin : instruction_demux
        instr_type      = instr[DW-1];
        instr_v         = instr;

        if(instr_type == 1'b0) begin
            instr_v[DW-1]   = 1'b0;
            cmd_a           = 1'b0;
            cmd_c1          = 1'b0;
            cmd_c2          = 1'b0;
            cmd_c3          = 1'b0;
            cmd_c4          = 1'b0;
            cmd_c5          = 1'b0;
            cmd_c6          = 1'b0;
            cmd_d1          = 1'b0;
            cmd_d2          = 1'b0;
            cmd_d3          = 1'b0;
            cmd_j1          = 1'b0;
            cmd_j2          = 1'b0;
            cmd_j3          = 1'b0;
        end 
        else if(instr_type == 1'b1) begin
            instr_v[DW-1]   = 1'b0;
            cmd_a           = instr[DW-4];
            cmd_c1          = instr[DW-5];
            cmd_c2          = instr[DW-6];
            cmd_c3          = instr[DW-7];
            cmd_c4          = instr[DW-8];
            cmd_c5          = instr[DW-9];
            cmd_c6          = instr[DW-10];
            cmd_d1          = instr[DW-11];
            cmd_d2          = instr[DW-12];
            cmd_d3          = instr[DW-13];
            cmd_j1          = instr[DW-14];
            cmd_j2          = instr[DW-15];
            cmd_j3          = instr[DW-16];
        end
    end

endmodule