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