module BusExtractor(IN, OUT);
   parameter inWidth = 16;
   parameter outStart = 0;
   parameter outWidth = 12;

   input [inWidth-1:0]      IN;
   output [outWidth-1:0] OUT;
   
   function [outWidth-1:0] fout(
      input [inWidth-1:0] fin);

      fout = fin[outStart+outWidth-1:outStart];
   endfunction // fout

   assign OUT = fout(IN);
   
endmodule // BusExtractor
