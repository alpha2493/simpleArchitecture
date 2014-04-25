module SIGNEXTENSIONTEST;
   reg [7:0] a, b;
   wire [15:0] out, nout;
   
   SignExtension se (a, 0, out);
   NotSignExtension nse (b, 0, nout);

   initial begin
      $dumpfile("singextensionTest.vcd");
      $dumpvars(0, SIGNEXTENSIONTEST);
      $display("SignExtension");
      $monitor ("%t: a = %b, out = %b", $time, a, out);      

      a = 8'b0011_0000;
      #10 a = 8'b1000_0000;
      #10 a = 8'b0101_0000;
      #10
      $display("NotSignExtension");
      $monitor ("%t: a = %b, out = %b", $time, b, nout);      

      b = 8'b0011_0000;
      #10 b = 8'b1100_0000;
      #10 b = 8'b0101_0000;
      #10 $finish;
   end
endmodule // MUXTEST
