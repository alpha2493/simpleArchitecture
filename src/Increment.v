module Increment(In, Sw, Out, Carry);
   parameter width = 16;

   input              Sw;
   input  [width-1:0] In;
   output [width-1:0] Out;
   output 	      Carry;

   reg [width:0]      result;
      
   always @* begin
      if (Sw)
	result = {1'b0, In} + 1;
      else
	result = {1'b0, In};
   end

   assign Carry = result[width];
   assign Out = result[width-1:0];

endmodule // Increment

   