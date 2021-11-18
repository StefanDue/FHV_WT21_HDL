//---------------------------------------------------------------------------------
// Project  : EDB HDL WS2021 - Fourth Assignment
// Purpose  : Implementation of a testbench for the instruction demultiplexer
// Author   : SteDun
// Version  : V1.0 2021-11-26
//---------------------------------------------------------------------------------

module tb_instr_demux
();


    // (1) Wiring the DUT
    localparam DWTB = 16;

    logic [DWTB-1:0]    instr;
    logic [DWTB-1:0]    instr_v;
    logic               instr_type;
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


    // (2) DUT instance
    instr_demux #(.DW (DWTB)) dut(.*);


    // (3) DUT stimulation
    // Create a bus for the control bits
    int error_cnt = 0;


    function int check_instr_demux(logic [DWTB-1:0] instr, logic [DWTB-1:0] expected_instr, int error_cnt);
        int errorCount;
        errorCount = error_cnt;
        assert(instr[DWTB-1] == 1'b0) begin
            assert(instr_v == expected_instr) begin
                $display("Input equals expected output");
                $display("Input:  %h", instr);
                $display("Output: %h", instr_v);
            end  
            else begin
                errorCount++;
                $error("Output does not equal the expected");
                $error("Input:  %h", instr);
                $error("Output: %h", instr_v);
            end    
        end  
        else begin
            assert(instr_v == expected_instr) begin
                $display("Input equals expected output");
                $display("Input:  %b", instr);
                $display("Output: %b", instr_v);
            end
            else begin
                errorCount++;
                $error("Output does not equal the expected");
                $error("Input:  %h", instr);
                $error("Output: %h", instr_v);
            end
        end
        $display("------------------------------------------------------");
        return errorCount;
    endfunction


    initial begin

        $display("***************************************************************************");
        $display("Welcome to the testbench for an instruction demultiplexer (instr_demux)");

        // Check the A-Instruction
        $display("------------------------------------------------------");
        $display("Check the A-instruction - constant MAX value");
        instr = 16'h7fff;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'h7fff, error_cnt);

        $display("------------------------------------------------------");
        $display("Check the A-instruction - constant MIN value");
        instr = 16'h0000;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'h0000, error_cnt);

        $display("------------------------------------------------------");
        $display("Check the A-instruction - constant random value");
        instr = 16'h5ea2;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'h5ea2, error_cnt);


        // Check the C-Instruction
        $display("------------------------------------------------------");
        $display("Check the C-instruction - D (= 1) is set for output 1");
        instr = 16'b1110111111010000;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'b1110111111010000, error_cnt);      



        $display("------------------------------------------------------");
        $display("Errors occoured during the testing: %d", error_cnt);
        $display("------------------------------------------------------");
        $display("Testbench for the instruction demultiplexer finished (instr_demux)");
        $display("***************************************************************************");
    end


endmodule