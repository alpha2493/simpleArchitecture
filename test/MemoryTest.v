module MEMORYTEST;

   reg [15:0] a;
   wire [15:0] out;

   Memory m (a, out);

   initial begin
      $dumpfile("Memory.vcd");
      $dumpvars(0, MEMORYTEST);
      $monitor("%t: a = %b, out = %b", $time, a, out);

      a = 54;
      #10 a = 37;
      #10 a = 625;
//     #10 a = -34; b = 23; s = 1;
//      #10 a = -34; b = 23; s = 1;
//      #10 a = -34; b = 23; s = 1;
//      #10 a = -34; b = 23; s = 1;
//      #10 a = -34; b = 23; s = 1;
//      #10 a = -34; b = 23; s = 1;
//      #10 a = -34; b = 23; s = 1;
//      #10 a = -34; b = 23; s = 1;
//      #10 a = -34; b = 23; s = 1;
//      #10 a = -34; b = 23; s = 1;
        #10 $finish;
   end

endmodule
