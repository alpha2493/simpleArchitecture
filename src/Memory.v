module Memory(
   input [15:0]  address,
   output [15:0] data);

   reg [15:0]    mem [0:65535];
   integer       i;
   reg [15:0]    r;
   
   initial begin
      for (i = 0; i < 65536; i = i + 1)
	      mem[i] = 16'b0000_0000_0000_0000;
   end
   
   always @ (address) begin
      r = mem[address];
   end
   
   assign data = r;
endmodule
