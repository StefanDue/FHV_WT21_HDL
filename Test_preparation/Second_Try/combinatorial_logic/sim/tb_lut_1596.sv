// --------------------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement a testbench for combinatorial logic
// Author:      SteDun
// Version:     V1.0 2021-12-10
// --------------------------------------------------------

module tb_lut_1596 ();


// (1) DUT wiring
localparam WIDTH_TB = 4;

logic [WIDTH_TB-1:0]    x_i;
logic                   y_o;
logic                   y_test;
logic                   y_error;


// (2) DUT instance
lut_1596 #(.WIDTH (WIDTH_TB)) dut(
    .x      (x_i),
    .y      (y_o)
);


// (3) DUT stimulation
int error_cnt = 0;

initial begin
    // set default 
    y_o = '0;
    $display("###############################################");
    $display("Welcome to the testbench for the lut_1596");
    $display("###############################################");
    for(int i = 0; i < 16; i++) begin
        x_i = i;
        #1ns;
        if((x_i == 4'b0100) || (x_i == 4'b1000) || (x_i == 4'b1010)) begin
            if(y_o == 1'b1) begin
                y_test = 1'b1;
            end
            else if(y_o == 1'b0) begin
                y_error = 1'b1;
            end
        end

        assert(((~y_error) && (y_test == 1'b1)) || y_o == 1'b0) begin
            $display("---------------------------");
            $display("Input:  %b", x_i);
            $display("Output: %b", y_o);
            $display("PASS");
        end
        else begin
            $display("---------------------------");
            $display("Input:  %b", x_i);
            $display("Output: %b", y_o);
            $error("FAIL");
            error_cnt++;
        end
        #100ns;
    end 
    $display("-------------------------------------");
    $display("Errors occured during testing: %d", error_cnt);
    $display("-------------------------------------");
    $display("###############################################");
    $display("Testbench for lut_1596 finished");
    $display("###############################################");
end

endmodule