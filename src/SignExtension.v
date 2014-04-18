module SignExtension(I, O);
   parameter m = 4;
   parameter n = 16;

   input [m-1:0] I;
   output [n-1:0] O;

   function [n-1:0] signExt(
      input [m-1:0] data,
      input integer size);

      integer i;

      begin
         signExt = data;
         for (i = 0; i < size; i = i + 1)
            signExt[n - 1 - i] = data[m - 1];
      end
   endfunction

   assign O = signExt(I, n - m);
endmodule

module NotSignExtension(I, O);
   parameter m = 4;
   parameter n = 16;

   input [m-1:0] I;
   output [n-1:0] O;

   function [n-1:0] notSignExt(
      input [m-1:0] data,
      input integer size);

      integer i;

      begin
         notSignExt = data;
         for (i = 0; i < size; i = i + 1)
            notSignExt[n - 1 - i] = 1'b0;
      end
   endfunction

   assign O = notSignExt(I, n - m);
endmodule

