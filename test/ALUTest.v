module ALUTEST;
   reg [15:0] a, b;
   reg [3:0]  salu;
   wire [15:0] aout;
   wire [3:0]  fout;
   wire fwrite;
   
   ALU alu (a, b, salu, aout, fout, fwrite);

   initial begin
      $dumpfile("aluTest.vcd");
      $dumpvars(0, ALUTEST);
      $monitor ("%t: %b, %b -> %b :: %d, %d -> %d (%b), %b", $time, a, b, aout, a, b, aout, fout, fwrite);

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
      
      $display(" --- ISUB ---");
      salu = 4'b0001; a = 16'd0; b = 16'd0;
      #10 a = 16'd35; b = 16'd34;
      #10 a = 16'd34; b = 16'd35;
      #10 a = 16'd234; b = 16'd123;
      #10 a = 16'd9999; b = 16'd9999;
      #10 a = 16'd40000; b = 16'd30000;
      #10 a = 16'd30000; b = 16'd40000;
      
      $display(" --- ISLL ---");
      salu = 4'b1000; a = 16'b1111111100000000; b = 16'd0;
      #10 b = 16'd1;
      #10 b = 16'd2;
      #10 b = 16'd3;
      #10 b = 16'd4;
      #10 b = 16'd5;
      #10 b = 16'd6;
      #10 b = 16'd7;
      #10 b = 16'd8;
      #10 b = 16'd9;
      #10 b = 16'd10;
      #10
      
      $display(" --- ISLR ---");
      salu = 4'b1001; a = 16'b1111111100000000; b = 16'd0;
      #10 b = 16'd1;
      #10 b = 16'd2;
      #10 b = 16'd3;
      #10 b = 16'd4;
      #10 b = 16'd5;
      #10 b = 16'd6;
      #10 b = 16'd7;
      #10 b = 16'd8;
      #10 b = 16'd9;
      #10 b = 16'd10;
      #10
      
      $display(" --- ISRL ---");
      salu = 4'b1010; a = 16'b1111111100000000; b = 16'd0;
      #10 b = 16'd1;
      #10 b = 16'd2;
      #10 b = 16'd3;
      #10 b = 16'd4;
      #10 b = 16'd5;
      #10 b = 16'd6;
      #10 b = 16'd7;
      #10 b = 16'd8;
      #10 b = 16'd9;
      #10 b = 16'd10;
      #10
      
      $display(" --- ISRA ---");
      salu = 4'b1011; a = 16'b1111111100000000; b = 16'd0;
      #10 b = 16'd1;
      #10 b = 16'd2;
      #10 b = 16'd3;
      #10 b = 16'd4;
      #10 b = 16'd5;
      #10 b = 16'd6;
      #10 b = 16'd7;
      #10 b = 16'd8;
      #10 b = 16'd9;
      #10 b = 16'd10;
      #10 a = 16'b0000000011111111; b = 16'd0;
      #10 b = 16'd1;
      #10 b = 16'd2;
      #10 b = 16'd3;
      #10 b = 16'd4;
      #10 b = 16'd5;
      #10 b = 16'd6;
      #10 b = 16'd7;
      #10 b = 16'd8;
      #10 b = 16'd9;
      #10 b = 16'd10;
      
      #10 $finish;
      
   end
endmodule // ALUTEST
