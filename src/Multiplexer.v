module Multiplexer(A, B, Sw, Out);
   parameter n = 16;
   
   input [n-1:0] A;
   input [n-1:0] B;
   
   input         Sw;
   
   output [n-1:0] Out;
   
   assign Out = Sw ? A : B;
   
endmodule // MUX
