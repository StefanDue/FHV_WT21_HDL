// ------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement a testbench for a finite state machine door
// Author:      SteDun
// Version:     V1.0 2021-12-10
// ------------------------------------------

module tb_fsm_door_1596();


// (1) DUT wiring
logic       rst_n;
logic       clk2m;
logic       key_up;
logic       key_down;
logic       sense_up;
logic       sense_down;
logic       ml;
logic       mr;
logic       light_red;
logic       light_green;


// (2) DUT instance
fsm_door_1596 dut(.*);



// (3) DUT stimulation
logic run_sim = 1'b1;

// define the 2 MHz clock 
initial begin
    clk2m = 1'b0;
    while(run_sim) begin
        #250ns;             // half of the 500ms clock period
        clk2m = ~clk2m;
    end
end 

// test the dut
initial begin
    // set inputs to default value
    key_up      = 1'b0;
    key_down    = 1'b0;
    sense_up    = 1'b0;
    sense_down  = 1'b1;  

    // start with reset
    rst_n = 1'b0;
    #5us;
    rst_n = 1'b1;
    #5us;

    // close the door
    @(negedge clk2m);
    key_up      = 1'b1;
    sense_down  = 1'b0;
    @(negedge clk2m);
    key_up = 1'b0;
    #10us;

    // door is open
    @(negedge clk2m);
    sense_up    = 1'b1;
    #5us;

    // door should stay open if key up and key down are pressed at the same time
    // in this implementation, door open will overrule door close if key_up and key_down is pressed at the same time
    @(negedge clk2m);
    key_up      = 1'b1;
    key_down    = 1'b1;
    @(negedge clk2m);
    key_up      = 1'b0;
    key_down    = 1'b0;
    #5us;

    // close the door
    @(negedge clk2m);
    key_down    = 1'b1;
    sense_up    = 1'b0;
    #10us;

    // door is closed
    @(negedge clk2m);
    key_down    = 1'b0;
    sense_down  = 1'b1;
    #5us;

    // door should open
    @(negedge clk2m);
    sense_down  = 1'b0;
    key_up      = 1'b1; 
    #10us;

    //open the door again
    @(negedge clk2m);
    key_up      = 1'b0;
    sense_up    = 1'b1;
    #5us;

    // error occures
    rst_n = 1'b0;
    // error overrules everything
    @(negedge clk2m);
    key_down = 1'b1;
    #5us;
    @(negedge clk2m);
    key_down = 1'b0;

    #20us;
    run_sim = 1'b0;
end



endmodule