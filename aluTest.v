module ALUTEST;
   reg [15:0] a, b;
   reg [3:0]  salu;
   wire [15:0] aout;
   wire [3:0]  fout;
   
   ALU alu (a, b, salu, aout, fout);

   initial begin
      $dumpfile("aluTest.vcd");
      $dumpvars(0, ALUTEST);
      $monitor ("%t: %b, %b -> %b :: %d, %d -> %d (%b)", $time, a, b, aout, a, b, aout, fout);

      $display(" --- IADD ---");
      salu = 4'b0000; a = 16'd0; b = 16'd0;
      #10 a = 16'd5; b = 16'd8;
      #10 a = 16'd10; b = 16'd20;
      #10 a = 16'd123; b = 16'd234;
      #10 a = 16'd1234; b = 16'd4321;
      #10 a = 16'd20000; b = 16'd20000;
      #10 a = 16'd40000; b = 16'd40000;
      #10 a = 16'd12345; b = 16'd54321;
      #10 a = 16'd30000; b = 16'd35536;
      #10 $finish;

   end
endmodule // ALUTEST
