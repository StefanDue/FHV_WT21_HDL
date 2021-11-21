//-----------------------------------------------------------
// Project  : EDB HDL WS2021 - Fourth Assignment
// Purpose  : Implementation of a demultiplexer for a CPU
// Author   : SteDun
// Version  : V1.0 2021-11-26
//-----------------------------------------------------------

module cpu 
#(
    parameter DW = 16,
    parameter PW = 15, 
    parameter AW = 15
)
(
    input logic                 rst_n,
    input logic                 clk50m,
    input logic [DW-1:0]        instr,
    input logic [DW-1:0]        inM,

    output logic                writeM,
    output logic [DW-1:0]       outM,
    output logic [AW-1:0]       addressM, 
    output logic [PW-1:0]       pc
);

// Defining local variables
// Define variables for the instruction demultiplexer - outputs
logic               instr_type;
logic [DW-1:0]      instr_v;
logic               cmd_a;
logic               cmd_c1;
logic               cmd_c2;
logic               cmd_c3;
logic               cmd_c4;
logic               cmd_c5;
logic               cmd_c6;
logic               cmd_d1;
logic               cmd_d2;
logic               cmd_d3;    
logic               cmd_j1;
logic               cmd_j2;
logic               cmd_j3;
logic               dload;
logic               mload;

// Defining variables for the ALU - outputs
logic [DW-1:0]      alu_out;
logic               alu_zr;
logic               alu_ng;

// Define variables for the jump controller - outputs
logic               pc_load;
logic               pc_inc;

//Define the variables for the D-Register - outputs
logic [DW-1:0]      d;

// Define variables for the A-Register - outputs
logic [DW-1:0]      a;

// Define internal used input variables for the CPU components - inputs
logic [AW-1:0]      a_address;
logic [PW-1:0]      a_pcount;
logic [DW-1:0]      y;
logic [DW-1:0]      m;
logic [15:0]        ad;
logic               aload;


// CPU assignments
assign writeM       = mload;
assign outM         = alu_out;
assign addressM     = a;
assign m            = inM;
assign instr_type   = instr[DW-1];
assign a_pcount  = {a[PW-1], a[PW-2], a[PW-3], a[PW-4], a[PW-5], a[PW-6], a[PW-7], a[PW-8], a[PW-9], a[PW-10], a[PW-11], a[PW-12], a[PW-13], a[PW-14], a[PW-15]};
assign a_address = {a[AW-1], a[AW-2], a[AW-3], a[AW-4], a[AW-5], a[AW-6], a[AW-7], a[AW-8], a[AW-9], a[AW-10], a[AW-11], a[AW-12], a[AW-13], a[AW-14], a[AW-15]}; 



// *** Wiring the components all together to get a CPU ***
// Wiring the instruction demultiplexer
instr_demux #(.DW (DW)) instr_demux(
    .cmd_d2     (dload),
    .cmd_d3     (mload),
    .*
);


// Wiring the program counter
pcount #(.W (PW)) pcount (
    .rst_n      (rst_n),
    .clk50m     (clk50m),
    .load       (pc_load),
    .inc        (pc_inc),
    .cnt_in     (a_pcount),
    .cnt        (pc)
); 

// Wiring the A-Register
dreg #(.W (DW)) areg (
    .rst_n      (rst_n),
    .clk50m     (clk50m),
    .load       (aload),
    .d          (ad),
    .q          (a)
);

// Wiring the D-Register
dreg #(.W (DW)) dreg (
    .rst_n      (rst_n),
    .clk50m     (clk50m),
    .load       (dload),
    .d          (alu_out),
    .q          (d)
);

// Wiring the jump control
jump_ctrl jump_ctrl (
    .zr         (alu_zr),
    .ng         (alu_ng),
    .*
);

// Wiring the ALU
alu #(.W (DW)) alu (
    .x          (d),
    .y          (y),
    .zx         (cmd_c1),
    .nx         (cmd_c2),
    .zy         (cmd_c3),
    .ny         (cmd_c4),
    .f          (cmd_c5),
    .no         (cmd_c6),
    .out        (alu_out),
    .zr         (alu_zr), 
    .ng         (alu_ng)
);



// *** Combinatorial logic for the CPU ***
// Define a couple of multiplexer
always_comb begin : areg_aload
    if(instr_type == 1'b1) begin
        aload   = cmd_d1;
    end
    else if(instr_type == 1'b0) begin
        aload   = 1'b1;
    end
end

always_comb begin : areg_ad
    if(instr_type == 1'b1) begin
        ad = alu_out;
    end
    else if(instr_type == 1'b0) begin
        ad = instr_v;
    end
end

always_comb begin : alu_y
    if(cmd_a == 1'b1) begin
        y = m;
    end
    else if(cmd_a == 1'b0) begin
        y = a;
    end
end


endmodule