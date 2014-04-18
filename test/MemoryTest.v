module MEMORYTEST;

   reg [15:0] w, a, d;
   wire [15:0] out;

   Memory m (w, a, d, out);

   initial begin
      $dumpfile("Memory.vcd");
      $dumpvars(0, MEMORYTEST);
      $monitor("%t: write:%d, address:%d, data:%d, out = %d",
               $time, w, a, d, out);

      w = 1; a = 0; d = 5;
      #10 w = 1; a = 4; d = 6;
      #10 w = 1; a = 3; d = 7;
      #10 w = 1; a = 8; d = 8;

      #10 w = 0; a = 0; d = 0;
      #10 w = 0; a = 1; d = 0;
      #10 w = 0; a = 2; d = 0;
      #10 w = 0; a = 3; d = 0;
      #10 w = 0; a = 4; d = 0;
      #10 w = 0; a = 5; d = 0;
      #10 w = 0; a = 6; d = 0;
      #10 w = 0; a = 7; d = 0;
      #10 w = 0; a = 8; d = 0;
      #10 w = 0; a = 9; d = 0;

      #10 w = 1; a = 4; d = 9;
      #10 w = 1; a = 5; d = 9;

      #10 w = 0; a = 0; d = 0;
      #10 w = 0; a = 1; d = 0;
      #10 w = 0; a = 2; d = 0;
      #10 w = 0; a = 3; d = 0;
      #10 w = 0; a = 4; d = 0;
      #10 w = 0; a = 5; d = 0;
      #10 w = 0; a = 6; d = 0;
      #10 w = 0; a = 7; d = 0;
      #10 w = 0; a = 8; d = 0;
      #10 w = 0; a = 9; d = 0;

      #10 $finish;
   end

endmodule
