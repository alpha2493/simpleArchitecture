module ProgramCounter (
   input         load, reset, notUpdate, clk,
   input [15:0]  address,
   output [15:0] counter);
   
   reg [15:0]    count = 16'b0;
   
   always @ (posedge clk) begin
      if (reset)
	count = 16'b0;
      else if (load)
	count = address + 1;
      else if (!notUpdate)
        count = count + 1;
   end
   
   assign counter = count;
endmodule
