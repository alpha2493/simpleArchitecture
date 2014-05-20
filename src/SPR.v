module SPR(
   input 	 inc, dec,  clock, reset,
   output [15:0] Data);

   reg [15:0] 	 register;

	
   always @ (posedge clock or posedge reset) begin
      if (reset)
	register = 16'd0;
      else
	begin
	   if (inc)
	     register = register + 16'b1;
	   
	   if (dec)
	     register = register - 16'b1;
	end
   end
   
   assign Data = register;
endmodule // SPR
