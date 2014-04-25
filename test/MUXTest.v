module MUXTEST;
   reg [3:0] a,b;
   reg 	      Sw;
   wire [3:0] out;
   
   Multiplexer #(4) mux (a, b, Sw, out);


   initial begin
      $dumpfile("muxTest.vcd");
      $dumpvars(0, MUXTEST);
      $monitor ("%t: a = %b, b = %b, Sw = %b, out = %b", $time, a, b, Sw, out);
      

      Sw = 1'b0; a = 4'b0011; b = 4'b1010;
      #10 a = 4'b1100; b =4'b0101;
      #10 Sw = 1'b1;
      #10 $finish;
   end
endmodule // MUXTEST
