module Increment(In, Sw, Out, Carry);
   parameter width = 16;

   input              Sw;
   input  [width-1:0] In;
   output [width-1:0] Out;
   output 	      Carry;

   always @* begin
      if (Sw)
	     