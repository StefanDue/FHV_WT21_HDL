//----------------------------------
// Project: EDB HDL WS2021
// Purpose: Show integer arithmetics unsigned
// Author:  SteDun
// Verion:  1.0 2021-10-21
//----------------------------------

module tb_adder_unsigned
();


// 1.) DUT wiring
localparam WTB = 10;            //localparam --> parameter that is not visible from the outside
localparam IMAX = 2**WTB-1;

logic [WTB-1:0]                 x1;
logic [WTB-1:0]                 x2;
logic [WTB-1:0]                 sum;


// 2.)s DUT instance
adder_unsigned #(.WIDTH (WTB)) dut(.*);


// 3.) DUT stimulation
initial begin
    for (x1 = 0; x1 < IMAX; x1++) begin
        #100ns;
        for (x2 = 0; x2 < IMAX; x2++) begin
            #100ns;
        end
    end
end
 
endmodule