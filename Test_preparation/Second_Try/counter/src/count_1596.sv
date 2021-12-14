// ------------------------------------------
// Project:     EDB HDL WT2021
// Purpose:     Implement a counter
// Author:      SteDun
// Version:     V1.0 2021-12-10
// ------------------------------------------

module count_1596
#(
    parameter WIDTH = 10
)
(
    input   logic               rst_n,
    input   logic               clk5m,
    input   logic               load,
    input   logic               updn,
    input   logic               en,
    input   logic [WIDTH-1:0]   data_in,

    output  logic [WIDTH-1:0]   cnt
);


// local variables
logic [WIDTH-1:0]       cnt_new;


// --- Sequential logic ---
always_ff @(negedge rst_n or posedge clk5m) begin
    if(~rst_n) begin
        cnt <= '0;
    end
    else if(en && load) begin
        cnt <= data_in;
    end
    else begin
        cnt <= cnt_new;
    end
end

// --- Combinatorial logic ---
always_comb begin 
    if(~en) begin
        cnt_new = cnt;
    end
    else if(~updn && en) begin
        cnt_new = cnt + 1'b1;
    end
    else if(updn && en) begin
        cnt_new = cnt - 1'b1;
    end
end

endmodule 