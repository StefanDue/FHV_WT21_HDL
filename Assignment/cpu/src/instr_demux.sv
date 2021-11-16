//-----------------------------------------------------------
// Project  : EDB HDL WS2021 - Fourth Assignment
// Purpose  : Implementation of a demultiplexer for a CPU
// Author   : SteDun
// Version  : V1.0 2021-11-26
//-----------------------------------------------------------

module instr_demux
    #(
    parameter DW = 16
    )
    (
    input   logic [DW-1:0]      instr;

    output  logic               instr_type;
    output  logic [DW-1:0]      instr_v;
    output  logic               cmd_a;
    output  logic               cmd_c1;
    output  logic               cmd_c2;
    output  logic               cmd_c3;
    output  logic               cmd_c4;
    output  logic               cmd_c5;
    output  logic               cmd_c6;
    output  logic               cmd_d1;
    output  logic               cmd_d2;
    output  logic               cmd_d3;
    output  logic               cmd_j1;
    output  logic               cmd_j2;
    output  logic               cmd_j3;
    );


    // Create internal buses for the outputs
    logic [5:0]     c;
    logic [2:0]     d;
    logic [2:0]     j;

    assign c = {cmd_c1, cmd_c2, cmd_c3, cmd_c4, cmd_c5, cmd_c6};
    assign d = {cmd_d1, cmd_d2, cmd_d3};
    assign j = {cmd_j1, cmd_j2, cmd_j3};

    
    


    // Behaviour description for the instruction demultiplexer
    always_comb begin : instruction_demux

    // The instr_type is set by the MSB of the instr_demux input instr
       if(instr[DW-1] == 1'b0) begin
           instr_type   = 1'b0;
           instr_v      = '
       end
       else if() begin
           instr_type   = 1'b1;
           cmd_a        = 1'b0;
           c            = '1;
           d            = 3'b010;
           j            = '0;
       end
       else if() begin
           instr_type   = 1'b1;
           cmd_a        = 1'b0;
           c            = 6'b000010;
           d            = 3'b010;
           j            = '0;
       end
       else if() begin
           instr_type   = 1'b1;
           cmd_a        = 1'b0;
           c            = 6'b110111;
           d            = 3'b001;
           j            = '0;
       end
    end

endmodule