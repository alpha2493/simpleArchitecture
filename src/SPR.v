module SPR(
   input [15:0]  writeData,
   input 	 inc, dec, write, clock, reset,
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
	
			if (write)
		register = writeData;
		end
   end

   assign Data = register;
endmodule // SPR
