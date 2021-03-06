
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module toplevel_c5g_hex4_uart(

    //////////// CLOCK //////////
    input 	logic	          		CLOCK_125_p,
    input 	logic	          		CLOCK_50_B5B,
    input 	logic	          		CLOCK_50_B6A,
    input 	logic	          		CLOCK_50_B7A,
    input 	logic	          		CLOCK_50_B8A,

    //////////// LED //////////
    output	logic	     [7:0]		LEDG,
    output	logic	     [9:0]		LEDR,

    //////////// KEY //////////
    input 	logic	          		CPU_RESET_n,
    input 	logic	     [3:0]		KEY,

    //////////// SW //////////
    input 	logic	     [9:0]		SW,

    //////////// SEG7 //////////
    output	logic	     [6:0]		HEX0,
    output	logic	     [6:0]		HEX1,
    output	logic	     [6:0]		HEX2,
    output	logic	     [6:0]		HEX3,

    //////////// Uart to USB //////////
    input 	logic	          		UART_RX,
    output	logic	          		UART_TX
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
localparam DW = 16;
logic [DW-1:0]          reg0x7000;
logic [DW-1:0]          reg0x7001;
logic [DW-1:0]          reg0x7002;
logic [DW-1:0]          reg0x7400;
logic [DW-1:0]          reg0x7401;
logic [DW-1:0]          reg0x7402;
logic [3:0]             bin0;
logic [3:0]             bin1;
logic [3:0]             bin2;
logic [3:0]             bin3;


//=======================================================
//  Structural coding
//=======================================================

uc
#(
    .DW                         (DW),                  //data width
    .AW                         (15),                  //address width data RAM
    .PW                         (15)                   //address width instruction ROM
)
uc_u0
(
    .rst_n                      (CPU_RESET_n),        //active low reset
    .clk50m                     (CLOCK_50_B5B), 

    // memory mapped peripherals

    .reg0x7000                  (reg0x7000),      //output reg 0
    .reg0x7001                  (reg0x7001),      //output reg 1
    .reg0x7002                  (reg0x7002),      //output reg 2

    .reg0x7400                  (reg0x7400),      //input reg 0
    .reg0x7401                  (reg0x7401),      //input reg 1
    .reg0x7402                  (reg0x7402)       //input reg 2
);

// inputs
assign reg0x7400 = {8'h00, SW[7:0]};
assign reg0x7401 = {14'd0, SW[9:8]};
assign reg0x7402 = {12'd0, ~KEY};         //keys are active low - bitwise negation

assign LEDG         = reg0x7000[ 7: 0];
assign LEDR[7:0]    = reg0x7000[15: 8];
assign LEDR[9:8]    = reg0x7001[ 1: 0];
assign bin0         = reg0x7002[ 3: 0];
assign bin1         = reg0x7002[ 7: 4];
assign bin2         = reg0x7002[11: 8];
assign bin3         = reg0x7002[15:12];
assign UART_TX      = 1'b0;

sevenseg sevenseg_u0(
    .bin            (bin0),
    .hex            (),         //not used - therefore empty bracets
    .hexn           (HEX0)
);
sevenseg sevenseg_u1(
    .bin            (bin1),
    .hex            (),
    .hexn           (HEX1)
);
sevenseg sevenseg_u2(
    .bin            (bin2),
    .hex            (),
    .hexn           (HEX2)
);
sevenseg sevenseg_u3(
    .bin            (bin3),
    .hex            (),
    .hexn           (HEX3)
);

endmodule
