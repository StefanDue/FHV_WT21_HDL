//---------------------------------------------------------------
// Project   EDB HDL WS 2021
// Purpose  Implement a thre input majority voter
// Author   SteDun00
// Version  V1.0 2021-10-07
//---------------------------------------------------------------

module tb_maj_vote
();

// (1) Create the wiring for the DUT    [PCB]
    logic         x2;
    logic         x1;
    logic         x0;
    logic         y;
    logic         ycase;

// (2) Create an instance of the DUT    [solder the chip onto the PCB]
    maj_vote    dut(
//     |         |
//  module name  |
//             instance name
        .x0          (x0),
        .x1          (x1),
        .x2          (x2),
        .y           (y),
        .ycase       (ycase)
//         |            |
//      in/out name     |
//                  wire name

    );
    // alternative for TBs (connect all wire with the same name)
    // maj_vote     dut( .*  );

// (3) Stimulate the DUT                [connect FGEN]
    initial begin
        $display("------------------------------------");
        $$display("Hello, tb_maj_vote is started");
        $$display("-----------------------------------");
        x2      =   1'bx;
        x1      =   1'bx;
        x0      =   1'bx;

        #100ns; // advance 100ns

/*
        x2      =   1'b0;
        x1      =   1'b1;
        x0      =   1'b1;

        #200ns;
*/
        for(int i = 0; i < 8; i += 1) begin
            x0 = i[0];
            x1 = i[1];
            x2 = i[2];
            #100ns;
        end

        $display("------------------------------------");
        $$display("tb_maj_vote finished");
        $$display("-----------------------------------");
    end

// (4) Check the output (optional)      [connect scope]


endmodule