//-------------------------------------------------------
// Project  : EDB HDL WS2021 - Third Assignment
// Purpose  : Implement a 16kB RAM in System Verilog
// Author   : SteDun
// Version  : V1.0 2021-11-10
//-------------------------------------------------------

module ram16k_verilog
(
    input logic             aclr,
    input logic [13:0]      address,
    input logic             clock,
    input logic [15:0]      data,
    input logic             wren,

    output logic [15:0]     q
);

// Local variables
logic [15:0]    mem [0:(1<<14)-1];

always_ff @(posedge clock) begin
    if(wren) begin   
        mem[address] <= data; 
    end
end

assign q = mem[address];

endmodule