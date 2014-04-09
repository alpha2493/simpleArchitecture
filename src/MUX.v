module MUX(A, B, Sw, Out);
   parameter n = 0;

   input [n-1:0] A;
   input [n-1:0] B;

   input 	 Sw;

   output [n-1:0] Out;

   assign Out = Sw ? A : B;

endmodule // MUX
