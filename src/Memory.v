module Memory(
   input [15:0]  address,
   output [15:0] data);

	`define MAX 4096

   reg [15:0]    mem [0:65535];
   integer       i;
	integer       j;
   reg [15:0]    r;
   
   initial begin
		for (j = 0; j < 16; j = j + 1)
			for (i = 0; i < `MAX; i = i + 1)
				mem[i + `MAX * j] = 16'b0;
		mem[0] = 16'b0000_0000_1111_1111;
   end
   
   always @ (address) begin
      r = mem[address];
   end
   
   assign data = r;
endmodule
