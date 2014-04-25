module Register (
   input         clock, write, reset,
   input [2:0]   address1, address2, writeAddress,
   input [15:0]  writeData,
   output [15:0] data1, data2);
   
   reg [15:0]    register [0:7];
   integer       i;
   
   initial begin
      for (i = 0; i < 8 ; i = i + 1)
        register[i] = 16'b0;
   end
   
   always @ (posedge clock) begin
      if (reset)
        for (i = 0; i < 8 ; i = i + 1)
          register[i] = 16'b0;
      
      if (write)
        register[writeAddress] = writeData;
   end
   
   assign data1 = register[address1];
   assign data2 = register[address2];
endmodule
