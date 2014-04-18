module Inverter(I, O);
   parameter n = 4;

   input [n-1:0] I;
   output [n-1:0] O;

   assign O = ~I;
endmodule
		