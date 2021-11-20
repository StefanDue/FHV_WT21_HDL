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
logic               dload;
logic               mload;
logic               aload;
logic               pc_load;
logic               pc_inc;
logic               alu_zr;
logic               alu_ng;
logic               instr_type;
logic [15:0]        ad;
logic [5:0]         c;
logic [DW-1:0]      m;
logic [DW-1:0]      alu_out;
logic [DW-1:0]      a;
logic [PW-1:0]      a_pcount;
logic [DW-1:0]      d;
logic [DW-1:0]      y;

assign a_pcount  = {a[PW-1], a[PW-2], a[PW-3], a[PW-4], a[PW-5], a[PW-6], a[PW-7], a[PW-8], a[PW-9], a[PW-10], a[PW-11], a[PW-12], a[PW-13], a[PW-14], a[PW-15]};
assign a_address = {a[AW-1], a[AW-2], a[AW-3], a[AW-4], a[AW-5], a[AW-6], a[AW-7], a[AW-8], a[AW-9], a[AW-10], a[AW-11], a[AW-12], a[AW-13], a[AW-14], a[AW-15]}; 


// CPU assignments
initial begin 
    m           = inM;
    writeM      = mload;
    outM        = alu_out;
    addressM    = a_address;
    instr_type  = instr[DW-1];
end


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
    .cnt_in     (a),
    .cnt        (pc)
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
    .c          (c),
    .out        (alu_out),
    .zr         (alu_zr), 
    .ng         (alu_ng)
);

// Wiring the A-Register
dreg #(.W (DW)) areg (
    .rst_n      (rst_n),
    .clk50m     (clk50m),
    .load       (aload),
    .d          (ad),
    .q          (a)
);


// *** Combinatorial logic for the CPU ***
// Define a couple of multiplexer
always_comb begin : areg_aload
    if(instr_type == 1'b1) begin
        aload = instr_demux.cmd_d1;
    end
    else if(instr_type == 1'b0) begin
        aload = 1'b1;
    end
end

always_comb begin : areg_ad
    if(instr_type == 1'b1) begin
        ad = alu_out;
    end
    else if(instr_type == 1'b0) begin
        ad = instr_demux.instr_v;
    end
end

always_comb begin : alu_y
    if(instr_demux.cmd_a == 1'b1) begin
        y = m;
    end
    else if(instr_demux.cmd_a == 1'b0) begin
        y = a;
    end
end


endmodule