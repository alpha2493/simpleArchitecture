module SignExtension(I, O);
   parameter m = 4;
   parameter n = 16;

   input [m-1:0] I;
   output [n-1:0] O;

   reg[n-1:0] d;
   integer size = n - m;
   integer i;
   always @ (I) begin
      d = I;
      for (i = 0; i < size; i = i + 1)
         d[n - 1 - i] = I[m - 1];
   end
   assign O = d;
endmodule

module NotSignExtension(I, O);
   parameter m = 4;
   parameter n = 16;

   input [m-1:0] I;
   output [n-1:0] O;

   reg[n-1:0] d;
   integer size = n - m;
   integer i;
   always @ (I) begin
      d = I;
      for (i = 0; i < size; i = i + 1) 
         d[n - 1 - i] = 1'b0;
   end
   assign O = d;
endmodule

