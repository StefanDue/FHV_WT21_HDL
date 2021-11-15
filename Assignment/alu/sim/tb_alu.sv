//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Second Assignment
// Purpose  : Implement an ALU
// Author   : SteDun
// Version  : V1.0 2021-10-19
//-------------------------------------------------------

module tb_alu
();

// (1) Wiring for the DUT
localparam DW =         16;

logic [DW-1:0]          x;
logic [DW-1:0]          y;
logic [5:0]             c;

logic [DW-1:0]          out;
logic                   zr;
logic                   ng;

// Define ALU-operations (ALU input control bits) as parameter
`define ZERO          6'b101010
`define ONE           6'b111111
`define MINUS_ONE     6'b111010
`define X_OUT         6'b001100
`define Y_OUT         6'b110000
`define NOT_X         6'b001101
`define NOT_Y         6'b110001
`define MINUS_X       6'b001111
`define MINUS_Y       6'b110011
`define X_PLUS_ONE    6'b011111
`define Y_PLUS_ONE    6'b110111
`define X_MINUS_ONE   6'b001110
`define Y_MINUS_ONE   6'b110010
`define X_PLUS_Y      6'b000010
`define X_MINUS_Y     6'b010011
`define Y_MINUS_X     6'b000111
`define X_AND_Y       6'b000000
`define X_OR_Y        6'b010101

// (2) Instance for the DUT
alu #(.W (DW)) dut(
    .x      (x),
    .y      (y),
    .zx     (c[5]),
    .nx     (c[4]),
    .zy     (c[3]),
    .ny     (c[2]),
    .f      (c[1]),
    .no     (c[0]),

    .out    (out),
    .zr     (zr),
    .ng     (ng)
); 



// (3) Stimulate the DUT
// Define local variables for testing
int errorCounter = 0;


// Function to check the output results of the ALU
function int checkResult_twoInputs(string description, int x, int y, logic[DW-1:0] out, logic zr, logic ng, int expected, string aluOperation, int errorCounter, logic expected_zr, logic expected_ng);
    // Internal variables for error handling
    int errorCnt;
    int errorCnt_zr;
    int errorCnt_ng;
    int errorCnt_operation;
    errorCnt = errorCounter;
    errorCnt_zr = 0;
    errorCnt_ng = 0;
    errorCnt_operation = 0;

    $display("**********************************************************************");

    // General description about what ALU function should be tested with this test function
    $display("%s", description);

    // Check if the output variable is the same as expected
    // If it is not the same, the function returns an error message and increases the error counter
    // If the output is negative, the output variable should be displayed as a signed vaule
    // If the output varible is neither negative nor zero, the output variable should be displayed unsigned
    // If the output variable is zero, the 
    assert(($signed(out) == expected)) begin       
        assert((zr == 0) && (ng == 0)) begin
            $display("%4d %3s %4d = %4d\t\t\t--> OK\n", x, aluOperation, y, out);
        end
        else assert((zr == 0) && (ng == 1)) begin
            $display("%4d %3s %4d = %4d\t\t\t--> OK\n", x, aluOperation, y, $signed(out));
        end
        else assert((zr == 1) && (ng == 0)) begin
            $display("%4d %3s %4d = %4d\t\t\t--> OK\n", x, aluOperation, y, out);
        end

        // Following block checks, if the output result is positive, zero or negative
        // The result of this check is displayed in the console
        assert(zr == expected_zr) begin
            $display("zr:\t\t%1d\nexpected zr: \t%1d\t\t--> OK", zr, expected_zr);
            assert(zr == 0) begin
                $display("Output value is not 0");
            end
            else assert (zr == 1) begin
                $display("Output value is 0");
            end
            else begin
                $error ("Output value is neither 0 nor 1");
            end
        end
        else begin 
            $error("zr:\t\t%1d\nexpected zr:\t%1d\t\t--> ERROR", zr, expected_zr);
            errorCnt_zr++;
        end
        assert(ng == expected_ng) begin
            $display("ng:\t\t%1d\nexpected ng: \t%1d\t\t--> OK", ng, expected_ng);
            assert(ng == 0) begin
                $display("Positive output value");
            end
            else assert(ng == 1) begin
                $display("Negative output value");
            end
            else begin
                $error("ng-control bit is neither 0 nor 1");
            end
        end
        else begin
            $error("ng: %1d equals not %1d\t\t\t--> ERROR", ng, expected_ng);
            errorCnt_ng++;
        end
    end 
    else begin
        $error("ERROR\nALU operation went wrong.\nResult differs from expected");
        errorCnt_operation++;
    end


    $display("**********************************************************************");
    assert((errorCnt_operation != 0) || (errorCnt_zr != 0) || (errorCnt_ng != 0)) begin
        errorCnt++;
    end
    else begin
        errorCnt = errorCnt;
    end
    return errorCnt;
endfunction



// Function to check the output results of the ALU
// This function works for situation, when the input is irrelevat to the output value
function int checkResult_singleInput(string description, int in, logic[DW-1:0] out, logic zr, logic ng, int expected, string aluOperation, int errorCounter, logic expected_zr, logic expected_ng);
    // Internal variables for error handling
    int errorCnt;
    int errorCnt_zr;
    int errorCnt_ng;
    int errorCnt_operation;
    errorCnt = errorCounter;
    errorCnt_zr = 0;
    errorCnt_ng = 0;
    errorCnt_operation = 0;

    $display("**********************************************************************");

    // General description about what ALU function should be tested with this test function
    $display("%s", description);

    // Check if the output variable is the same as expected
    // If it is not the same, the function returns an error message and increases the error counter
    assert(($signed(out) == expected)) begin       
        assert((zr == 0) && (ng == 0)) begin
            $display("%s%4d = %4d\t\t\t--> OK\n", aluOperation, in, out);
        end
        else assert((zr == 0) && (ng == 1)) begin
            $display("%s%4d = %4d\t\t\t--> OK\n", aluOperation, in, $signed(out));
        end
        else assert((zr == 1) && (ng == 0)) begin
            $display("%4d\t\t\t--> OK\n", out);
        end

        assert(zr == expected_zr) begin
            $display("zr:\t\t%1d\nexpected zr: \t%1d\t\t--> OK", zr, expected_zr);
            assert(zr == 0) begin
                $display("Output value is not 0");
            end
            else assert (zr == 1) begin
                $display("Output value is 0");
            end
            else begin
                $error ("Output value is neither 0 nor 1");
            end
        end
        else begin 
            $error("zr:\t\t%1d\nexpected zr:\t%1d\t\t--> ERROR", zr, expected_zr);
            errorCnt_zr++;
        end
        assert(ng == expected_ng) begin
            $display("ng:\t\t%1d\nexpected ng: \t%1d\t\t--> OK", ng, expected_ng);
            assert(ng == 0) begin
                $display("Positive output value");
            end
            else assert(ng == 1) begin
                $display("Negative output value");
            end
            else begin
                $error("ng-control bit is neither 0 nor 1");
            end
        end
        else begin
            $error("ng: %1d equals not %1d\t\t\t--> ERROR", ng, expected_ng);
            errorCnt_ng++;
        end
    end 
    else begin
        $error("ERROR\nALU operation went wrong.\nResult differs from expected");
        errorCnt_operation++;
    end


    $display("**********************************************************************");
    assert((errorCnt_operation != 0) || (errorCnt_zr != 0) || (errorCnt_ng != 0)) begin
        errorCnt++;
    end
    else begin
        errorCnt = errorCnt;
    end
    return errorCnt;
endfunction



// Function to check the output results of the ALU
// This function outputs the variables in hex format
function int checkResult_twoInputs_hexOutput(string description, int x, int y, logic[DW-1:0] out, logic zr, logic ng, int expected, string aluOperation, int errorCounter, logic expected_zr, logic expected_ng);
    // Internal variables for error handling
    int errorCnt;
    int errorCnt_zr;
    int errorCnt_ng;
    int errorCnt_operation;
    errorCnt = errorCounter;
    errorCnt_zr = 0;
    errorCnt_ng = 0;
    errorCnt_operation = 0;

    $display("**********************************************************************");

    // General description about what ALU function should be tested with this test function
    $display("%s", description);

    // Check if the output variable is the same as expected
    // If it is not the same, the function returns an error message and increases the error counter
    // If the output is negative, the output variable should be displayed as a signed vaule
    // If the output varible is neither negative nor zero, the output variable should be displayed unsigned
    // If the output variable is zero, the 
    assert(($signed(out) == expected)) begin       
        assert((zr == 0) && (ng == 0)) begin
            $display("%4h %3s %4h = %4h\t\t\t--> OK\n", x, aluOperation, y, out);
        end
        else assert((zr == 0) && (ng == 1)) begin
            $display("%4h %3s %4h = %4h\t\t\t--> OK\n", x, aluOperation, y, $signed(out));
        end
        else assert((zr == 1) && (ng == 0)) begin
            $display("%4h %3s %4h = %4h\t\t\t--> OK\n", x, aluOperation, y, out);
        end

        assert(zr == expected_zr) begin
            $display("zr:\t\t%1d\nexpected zr: \t%1d\t\t--> OK", zr, expected_zr);
            assert(zr == 0) begin
                $display("Output value is not 0");
            end
            else assert (zr == 1) begin
                $display("Output value is 0");
            end
            else begin
                $error ("Output value is neither 0 nor 1");
            end
        end
        else begin 
            $error("zr:\t\t%1d\nexpected zr:\t%1d\t\t--> ERROR", zr, expected_zr);
            errorCnt_zr++;
        end
        assert(ng == expected_ng) begin
            $display("ng:\t\t%1d\nexpected ng: \t%1d\t\t--> OK", ng, expected_ng);
            assert(ng == 0) begin
                $display("Positive output value");
            end
            else assert(ng == 1) begin
                $display("Negative output value");
            end
            else begin
                $error("ng-control bit is neither 0 nor 1");
            end
        end
        else begin
            $error("ng: %1d equals not %1d\t\t\t--> ERROR", ng, expected_ng);
            errorCnt_ng++;
        end
    end 
    else begin
        $error("ERROR\nALU operation went wrong.\nResult differs from expected");
        errorCnt_operation++;
    end


    $display("**********************************************************************");
    assert((errorCnt_operation != 0) || (errorCnt_zr != 0) || (errorCnt_ng != 0)) begin
        errorCnt++;
    end
    else begin
        errorCnt = errorCnt;
    end
    return errorCnt;
endfunction


initial begin
    $display("-----------------------------------------");
    $display("Welcome! The program ALU is started");
    $display("----------------------------------------");

    // Check if addition of two variables work
    x = 1;
    y = 2;
    c = `X_PLUS_Y;
    #10ns;
    errorCounter = checkResult_twoInputs("Addition of two variables - x+y:", 1, 2, out, zr, ng, (x+y), "+", errorCounter, 0, 0);
    #10ns;


    // Check if subtraction of two variables with positive result works
    x = 100;
    y = 50;
    c = `X_MINUS_Y;
    #10ns;
    errorCounter = checkResult_twoInputs("Subtraction of two variables with positive result - x-y:", 100, 50, out, zr, ng, (x-y), "-", errorCounter, 0, 0);
    #10ns;


    // Check if subtraction of two variables with negative result works
    c = `Y_MINUS_X;
    #10ns;
    errorCounter = checkResult_twoInputs("Subtraction of two variables with negative result - y-x:", 100, 50, out, zr, ng, (y-x), "-", errorCounter, 0, 1);
    #10ns;


    // Check if ZERO output works
    // This test should ignore the input variables and directly put 0 to the output
    c =`ZERO;
    #10ns;
    errorCounter = checkResult_singleInput("Check if the ZERO function of the ALU works - 0:", 0, out, zr, ng, 0, "", errorCounter, 1, 0);
    #10ns;


    // Check if the AND operator works
    x = 16'hAA;
    y = 16'h55;
    c = `X_AND_Y;
    #10ns;
    errorCounter = checkResult_twoInputs_hexOutput("Check if the AND-Operator (&) works with two input variables - x&y:", 16'hAA, 16'h55, out, zr, ng, (x&y), "&", errorCounter, 1, 0);
    #10ns;


    // Check if the OR operator works
    c = `X_OR_Y;
    #10ns;
    errorCounter = checkResult_twoInputs_hexOutput("Check if the OR-Operator (|) works with two input variables - x|y:", 16'hAA, 16'h55, out, zr, ng, (x|y), "|", errorCounter, 0, 0);
    #10ns;


    // Check if -1 output works
    // This test should ignore the input variables and directly put 0 to the output
    c =`MINUS_ONE;
    #10ns;
    errorCounter = checkResult_singleInput("Check if the -1 operation of the ALU works - -1:", -1, out, zr, ng, -1, "", errorCounter, 0, 1);
    #10ns;


    // Check if NOT works
    x = 255;
    c = `NOT_X;
    #10ns;
    errorCounter = checkResult_singleInput("Check if the !input (NOT) operation of one input works - !x:", 255, out, zr, ng, ~x, "!", errorCounter, 0, 1);
    #10ns;


    // Check for negative outputs
    c = `MINUS_X;
    #10ns;
    errorCounter = checkResult_singleInput("Check if the MINUS-Input operator works - -x:", 255, out, zr, ng, -x, "", errorCounter, 0, 1);
    #10ns;




    // Display how much errors occured during runtime
    $display("Errors occured during runtime: %d\n", errorCounter);
    
    $display("-----------------------------------------");
    $display("Goodbye! ALU finished");
    $display("----------------------------------------");
end


endmodule