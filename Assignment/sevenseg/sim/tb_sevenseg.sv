//-------------------------------------------------------
// Project      EDB HDL WS 2021 - First Assignment
// Purpose      Implement a seven segment display 
// Author       SteDun00
// Version      V1.0 2021-10-19
//-------------------------------------------------------

module tb_sevenseg
();

// 1.) Wiring for the DUT
    logic [3:0]      bin;

    logic [6:0]      hex;
    logic [6:0]      hexn; 


// 2.) Instance for the DUT
    sevenseg dut(.*);           // quick way to do the instance for the DUT


// 3.) Stimulate the DUT
    initial begin
    // local variables to check the segment output code (bitwise)    
    logic [6:0]      checkOutput;
    logic [6:0]      checkOutputN;

        $display("------------------------------------");
        $display("Hello, sevenseg is started");
        $display("-----------------------------------");
        $display("Decimal input    Hexadecimal input   Binary input       hex_out      hex_out check     hexn_out      hexn_out check");

        // loop to stimulate the DUT
        for(int i = 0; i < 16; i += 1) begin
            bin[0] = i[0];
            bin[1] = i[1];
            bin[2] = i[2];
            bin[3] = i[3];

            // Lookup table to check, if the hex ouput is equal to the expected. 
            case(bin)
                0   : checkOutput = 7'b0111111;
                1   : checkOutput = 7'b0000110;
                2   : checkOutput = 7'b1011011;
                3   : checkOutput = 7'b1001111;
                4   : checkOutput = 7'b1100110;
                5   : checkOutput = 7'b1101101;
                6   : checkOutput = 7'b1111101;
                7   : checkOutput = 7'b0000111;
                8   : checkOutput = 7'b1111111;
                9   : checkOutput = 7'b1101111;
                10  : checkOutput = 7'b1110111;
                11  : checkOutput = 7'b1111100;
                12  : checkOutput = 7'b0111001;
                13  : checkOutput = 7'b1011110;
                14  : checkOutput = 7'b1111001;
                15  : checkOutput = 7'b1110001;
            endcase

            // Lookup table to check, if the hexn output is equal to the expected. 
            case(bin)
                0   : checkOutputN = 7'b1000000;
                1   : checkOutputN = 7'b1111001;
                2   : checkOutputN = 7'b0100100;
                3   : checkOutputN = 7'b0110000;
                4   : checkOutputN = 7'b0011001;
                5   : checkOutputN = 7'b0010010;
                6   : checkOutputN = 7'b0000010;
                7   : checkOutputN = 7'b1111000;
                8   : checkOutputN = 7'b0000000;
                9   : checkOutputN = 7'b0010000;
                10  : checkOutputN = 7'b0001000;
                11  : checkOutputN = 7'b0000011;
                12  : checkOutputN = 7'b1000110;
                13  : checkOutputN = 7'b0100001;
                14  : checkOutputN = 7'b0000110;
                15  : checkOutputN = 7'b0001110;
            endcase

            #100ns;
            $display("     %d               %H                 %b            %b   -->   %b        %b    -->   %b", bin, bin, bin, hex, checkOutput, hexn, checkOutputN);
        end

        $display("------------------------------------");
        $display("sevenseg finished");
        $display("-----------------------------------");
    end

endmodule