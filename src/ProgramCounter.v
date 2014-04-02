module ProgramCounter (
   input 	 load, reset, clk,
   input [15:0]  address,
   output [15:0] counter);

   reg [15:0] 	 count = 16'0;

   always @ (posedge clk) begin
      if (reset)
	count = 16'0;
      else if (load)
	count = address;
      else
	count = count + 1;
   end

   assign counter = count;
endmodule
