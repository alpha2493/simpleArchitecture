module StackPointerRegister(
   input [15:0]  writeData,
   input 	 inc, dec, write, clock,
   output [15:0] Data);

   reg [15:0] 	 register;


   always @ (posedge clock) begin
      if (inc)
	register = register + 16'b1;

      if (dec)
	register = register - 16'b1;

      if (write)
	register = writeData;
   end

   assign Data = register;
endmodule; // StackPointerRegister
