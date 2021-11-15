//-------------------------------------
// Project  : EDB HDL WS2021
// Purpose  : UpDown cohnter
// Author   : SteDun
// Version  : 1.0 2021-10-21
//-------------------------------------

module counter 
#(
    parameter WIDTH = 8
) 
(
    input logic                 rst_n,
    input logic                 clk50m,     // 50 MHz clock signal
    input logic                 en,         // en = 1 -->counter counts/enabled
    input logic                 up_dn_n,    // 1 --> up, 0 --> down counter
    
    output logic [WIDTH-1:0]    cnt
);

// --- local signals ---
logic [WIDTH-1:0]               cnt_new;

// --- create a ff with width=WIDTH ---
always_ff @( negedge rst_n or posedge clk50m) begin
    // (1) async reset to a *constant* number
    if(!rst_n) begin
        cnt <= '0;
    end
    else begin
        cnt <= cnt_new;
    end
end

// --- combinatorial logic ---
// Describes the behaviour of the counter
always_comb begin
    if(~en) begin
        cnt_new = cnt;
    end 
    else if (en && up_dn_n) begin
        cnt_new = cnt + 1'b1;   // increment the counter
    end   
    else begin
        cnt_new = cnt -1'b1;    // decrement the counter
    end
end


endmodule