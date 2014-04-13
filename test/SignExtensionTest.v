module SIGNEXTENSIONTEST;
   reg [3:0] a, b;
   wire [15:0] out, nout;
   
   SignExtension #(4, 16) se (a, out);
   NotSignExtension #(4, 16) nse (b, nout);

   initial begin
      $dumpfile("singextensionTest.vcd");
      $dumpvars(0, SIGNEXTENSIONTEST);
      $display("SignExtension");
      $monitor ("%t: a = %b, out = %b", $time, a, out);      

      a = 4'b0011;
      #10 a = 4'b1000;
      #10 a = 4'b0101;
      #10
      $display("NotSignExtension");
      $monitor ("%t: a = %b, out = %b", $time, b, nout);      

      b = 4'b0011;
      #10 b = 4'b1100;
      #10 b = 4'b0101;
      #10 $finish;
   end
endmodule // MUXTEST
