// ------------------------------------------------------
// Project: EDB HDL WT2021 - Test preparation
// Purpose: Implement a testbench for combinatorial logic
// Author:  StefanDuenser
// Version: V1.0 2021-12-14
// ------------------------------------------------------

module tb_fsm_door_1596 ();

// (1) DUT wiring
logic          rst_n;
logic          clk2m;
logic          key_up;
logic          key_down;
logic          sense_up;
logic          sense_down;
logic          ml;
logic          mr;
logic          light_red;
logic          light_green;


// (2) DUT instance
fsm_door_1596 dut(.*);


// (3) DUT stimulation
// local variables
logic run_sim = 1'b1;

// define clock speed
initial begin
    clk2m = 1'b0;
    while(run_sim) begin
        #250ns;
        clk2m = ~clk2m;
    end
end


// test the DUT
initial begin
    // power on reset
    rst_n       = 1'b0;
    key_up      = 1'b0;
    key_down    = 1'b0;
    sense_up    = 1'b0;
    sense_down  = 1'b0;
    ml          = 1'b0;
    mr          = 1'b0;
    light_red   = 1'b0;
    light_green = 1'b0;
    #3100ns;            // asynchronous reset - no check on clock edge
    rst_n = 1'b1;
    #3us;

    // door moves up
    @(negedge clk2m);
    key_up  = 1'b1;
    @(negedge clk2m);
    key_up = 1'b0;
    #5us;

    // door is open
    @(negedge clk2m);
    sense_up = 1'b1;
    #5us;

    // close the door
    @(negedge clk2m);
    key_down = 1'b1;
    @(negedge clk2m);
    sense_up = 1'b0;
    key_down = 1'b0;
    #5us;

    // door is closed
    @(negedge clk2m);
    sense_down = 1'b1;
    #5us;

    // open door 
    @(negedge clk2m);
    key_up = 1'b1;
    @(negedge clk2m);
    sense_down = 1'b0;
    key_up = 1'b0;
    #5us;

    // door is open again
    @(negedge clk2m);
    sense_up = 1'b1;
    #5us;

    // close door again
    @(negedge clk2m);
    key_down = 1'b1;
    @(negedge clk2m);
    sense_up = 1'b0;
    key_down = 1'b0;
    #3us;

    // open door while door moves down
    @(negedge clk2m);
    key_up = 1'b1;
    @(negedge clk2m);
    key_up = 1'b0;
    #2us;

    // close door while door moves up
    @(negedge clk2m);
    key_down = 1'b1;
    @(negedge clk2m);
    key_down = 1'b0;
    #2us;

    // check overruling condition - if both keys pressed, door should move upwards in safety zone
    @(negedge clk2m);
    key_up = 1'b1;
    key_down = 1'b1;
    #3us;
    @(negedge clk2m);
    key_up = 1'b0;
    key_down = 1'b0;
    #3us;
    
    // door keeps in open state
    @(negedge clk2m);
    sense_up = 1'b1;
    #10us;

    run_sim = 1'b0;
end

endmodule