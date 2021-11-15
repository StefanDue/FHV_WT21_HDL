//-------------------------------------
// Project  : EDB HDL WS2021
// Purpose  : UpDown cohnter
// Author   : SteDun
// Version  : 1.0 2021-10-21
//-------------------------------------

module tb_counter 
();

    // (1) Wiring the DUT
    localparam WTB = 5;

    logic               rst_n;
    logic               clk50m;
    logic               en;
    logic               up_dn_n;
    logic [WTB-1:0]     cnt;


    // (2) DUT instance
    counter #(.WIDTH (WTB)) dut (.*);


    // (3) DUT stimulation
    logic run_sim = 1'b1;
    int   error_cnt = 0;

    initial begin
        clk50m = 1'b0;          //init to zero
        while (run_sim) begin
            #10ns;
            clk50m = ~clk50m;
        end
    end

    initial begin
        $dispay("Welcome to tb_counter...");
        rst_n   = 1'b0;
        en      = 1'b0;
        up_dn_n = 1'b0;

        #90ns;
        assert(cnt == '0) else begin
            $error("Counter is not reset. cnt = %d", cnt);
            error_cnt++;
        end

        #10ns;
        $$display("POR");
        rst_n   = 1'b1;

        #1us;
        @(negedge clk50m);
        en      = 1'b1;     // enable
        up_dn_n = 1'b1;     // count up
        @(negedge clk50m);
        assert(cnt == '1) else begin
            $error("Counter did not increment. cnt = %d", cnt);
            error_cnt++;
        end

        #1us;
        run_sim = 1'b0;
        $display("tb_counter finished");
    end


endmodule