module SZCVRegister(
   input [3:0] 	SZCV_in,
   input 	FLAG_write, CLOCK,
   output [3:0] SZCV_out);

   reg [3:0] 	SZCV;
   
   
   always @ (posedge CLOCK) begin
      if (FLAG_write == 1'b1)
	SZCV <= SZCV_in;
   end
   
   assign SZCV_out = SZCV;
   
endmodule // SZCVRegister



