module SIGNEXTENSIONTEST;
   reg [15:0] a, b;
   wire [31:0] out, nout;
   
   SignExtension #(16, 32) se (a, out);
   NotSignExtension #(16, 32) nse (b, nout);

   initial begin
      $dumpfile("singextensionTest.vcd");
      $dumpvars(0, SIGNEXTENSIONTEST);
      $display("SignExtension");
      $monitor ("%t: a = %b, out = %b", $time, a, out);      

      a = 16'b0011_0000_0000_0000;
      #10 a = 16'b1000_0000_0000_0000;
      #10 a = 16'b0101_0000_0000_0000;
      #10
      $display("NotSignExtension");
      $monitor ("%t: a = %b, out = %b", $time, b, nout);      

      b = 16'b0011_0000_0000_0000;
      #10 b = 16'b1100_0000_0000_0000;
      #10 b = 16'b0101_0000_0000_0000;
      #10 $finish;
   end
endmodule // MUXTEST
