module OnewordRegister(
   input [15:0]  IN,
   input         CLK,
   output [15:0] OUT);

   reg [15:0]    REG;

   always @ (posedge CLK) begin
      REG <= IN;
   end
   
   assign OUT = REG;
   
endmodule // OnewordRegister
