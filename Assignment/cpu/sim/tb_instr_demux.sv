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
    // Define internal varaibles for internal bus and stimulation
    int error_cnt = 0;
    logic [5:0]     c;
    logic [2:0]     d;
    logic [2:0]     j;

    // Create a bus for the control bits
    assign c = {cmd_c1, cmd_c2, cmd_c3, cmd_c4, cmd_c5, cmd_c6};
    assign d = {cmd_d1, cmd_d2, cmd_d3};
    assign j = {cmd_j1, cmd_j2, cmd_j3};


    // Implement a function to check the the function of the instruction demultiplexer
    function int check_instr_demux(logic [DWTB-1:0] instr, logic [DWTB-1:0] expected_instr, int error_cnt, logic instr_type, logic cmd_a, logic [5:0] c, logic [2:0] d, logic [2:0] j);
        int errorCount;
        errorCount = error_cnt;
        assert(instr[DWTB-1] == 1'b0) begin
            assert(instr_v == expected_instr) begin
                $display("Input equals expected output");
                $display("Input:        %h = %b", instr, instr);
                $display("Output:       %h = %b", instr_v, instr_v);
                $display("instr_type:   %b", instr_type);
            end  
            else begin
                errorCount++;
                $error("Output does not equal the expected");
                $display("Input:        %h = %b", instr, instr);
                $display("Output:       %h = %b", instr_v, instr_v);
                $display("instr_type:   %b", instr_type);
            end    
        end  
        else if(instr[DWTB-1] == 1'b1) begin
            assert(instr_v == expected_instr) begin
                $display("Input equals expected output");
                $display("Input:        %h = %b", instr, instr);
                $display("Output:       %h = %b", instr_v, instr_v);
                $display("instr_type:   %b", instr_type);
                $display("cmd_a:        %b", cmd_a);
                $display("c:            %b", c);
                $display("d:            %b", d);
                $display("j:            %b", j);
            end
            else begin
                errorCount++;
                $error("Output does not equal the expected");
                $display("Input:        %h = %b", instr, instr);
                $display("Output:       %h = %b", instr_v, instr_v);
                $display("instr_type:   %b", instr_type);
                $display("cmd_a:        %b", cmd_a);
                $display("c:            %b", c);
                $display("d:            %b", d);
                $display("j:            %b", j);
            end
        end
        $display("------------------------------------------------------");
        return errorCount;
    endfunction


    // Check, if the instruction demultiplexer works
    initial begin

        $display("***************************************************************************");
        $display("Welcome to the testbench for an instruction demultiplexer (instr_demux)");

        // Check the A-Instruction
        $display("------------------------------------------------------");
        $display("Check the A-instruction - constant MAX value");
        instr = 16'h7fff;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'h7fff, error_cnt, instr_type, cmd_a, c, d, j);

        $display("------------------------------------------------------");
        $display("Check the A-instruction - constant MIN value");
        instr = 16'h0000;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'h0000, error_cnt, instr_type, cmd_a, c, d, j);

        $display("------------------------------------------------------");
        $display("Check the A-instruction - constant random value");
        instr = 16'h5ea2;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'h5ea2, error_cnt, instr_type, cmd_a, c, d, j);


        // Check the C-Instruction
        $display("------------------------------------------------------");
        $display("Check the C-instruction ->  D (=1) is set for output 1");
        instr = 16'b1110111111010000;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'b1110111111010000, error_cnt, instr_type, cmd_a, c, d, j);

        $display("------------------------------------------------------");
        $display("Check the C-instruction ->  D = D + A");
        instr = 16'b1110000010010000;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'b1110000010010000, error_cnt, instr_type, cmd_a, c, d, j);       

        $display("------------------------------------------------------");
        $display("Check the C-instruction ->  M = A + 1");
        instr = 16'b1110110111001000;
        #100ns;
        error_cnt = check_instr_demux(instr, 16'b1110110111001000, error_cnt, instr_type, cmd_a, c, d, j); 


        $display("------------------------------------------------------");
        $display("Errors occoured during the testing: %d", error_cnt);
        $display("------------------------------------------------------");
        $display("Testbench for the instruction demultiplexer finished (instr_demux)");
        $display("***************************************************************************");
    end


endmodule