// ------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement a testbench for combinatorial logic
// Author:      SteDun
// Version:     V1.0 2021-12-10
// ------------------------------------------

module tb_lut_1596();


// (1) DUT wiring
logic [3:0]     x;
logic           y;


// (2) DUT instance
lut_1596 dut(
    .x_i    (x),
    .y_o    (y)
);


// (3) DUT stimulation
// local variables
int error_cnt = 0;


initial begin
    $display("===========================================");
    $display("Welcome to the testbench for lut_1596");
    $display("===========================================");

    for(int i = 0; i < 16; i += 1) begin
        x = i;
        $display("-----------------------------------");
        $display("Input:  %b", x);
        $display("Output: %b", y);
        #100ns;
    end
    
    $display("-------------------------------------------");
    $display("Errors occured during testing: %d", error_cnt);
    $display("===========================================");
    $display("Testbench lut_1596 finished");
    $display("===========================================");
end


endmodule