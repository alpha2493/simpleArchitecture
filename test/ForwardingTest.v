module FORWARDINGTEST;
   reg [15:0] one, two;
   reg 	      one_A, one_B, two_A, two_B;
   wire [15:0] outA, outB;
   wire        forwarda, forwardb;
   
   Forwarding fw (one, two, one_A, one_B, two_A, two_B, forwarda, forwardb, outA, outB);

   initial begin
      $dumpfile("ForwadingTest.vcd");
      $dumpvars(0, FORWARDINGTEST);
      $monitor ("%t: one = %b, two = %b, one_A = %b, one_B = %b, two_A = %b, two_B = %b, outA = %b, outB = %b", $time, one, two, one_A, one_B, two_A, two_B, outA, outB);

      one = 16'b0000_0000_1111_0000; two = 16'b0000_0000_0000_1111;
      one_A = 1'b0; one_B = 1'b0; two_A = 1'b0; two_B = 1'b0;
      #10 
      one_A = 1'b0; one_B = 1'b0; two_A = 1'b0; two_B = 1'b1;
      #10 
      one_A = 1'b0; one_B = 1'b0; two_A = 1'b1; two_B = 1'b0;
      #10 
      one_A = 1'b0; one_B = 1'b0; two_A = 1'b1; two_B = 1'b1;
      #10 
      one_A = 1'b0; one_B = 1'b1; two_A = 1'b0; two_B = 1'b0;
      #10 
      one_A = 1'b0; one_B = 1'b1; two_A = 1'b0; two_B = 1'b1;
      #10 
      one_A = 1'b0; one_B = 1'b1; two_A = 1'b1; two_B = 1'b0;
      #10 
      one_A = 1'b0; one_B = 1'b1; two_A = 1'b1; two_B = 1'b1;
      #10 
      one_A = 1'b1; one_B = 1'b0; two_A = 1'b0; two_B = 1'b0;
      #10 
      one_A = 1'b1; one_B = 1'b0; two_A = 1'b0; two_B = 1'b1;
      #10 
      one_A = 1'b1; one_B = 1'b0; two_A = 1'b1; two_B = 1'b0;
      #10 
      one_A = 1'b1; one_B = 1'b0; two_A = 1'b1; two_B = 1'b1;
      #10 
      one_A = 1'b1; one_B = 1'b1; two_A = 1'b0; two_B = 1'b0;
      #10
      one_A = 1'b1; one_B = 1'b1; two_A = 1'b0; two_B = 1'b1;
      #10
      one_A = 1'b1; one_B = 1'b1; two_A = 1'b1; two_B = 1'b0;
      #10
      one_A = 1'b1; one_B = 1'b1; two_A = 1'b1; two_B = 1'b1;
      #10
      one_A = 1'b0; one_B = 1'b0; two_A = 1'b0; two_B = 1'b0;
      #10 $finish;
   end
endmodule // MUXTEST
