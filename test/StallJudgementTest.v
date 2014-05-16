module STALLJUDGEMENTTEST;
   reg [15:0] command, before;
   wire       pnu;
	       

   StallJudgement sj (command, before, pnu);
   

   initial begin
      $dumpfile("stallJudgementTest.vcd");
      $dumpvars(0, STALLJUDGEMENTTEST);
      $monitor("%t: %b %b -> pnu:%b",$time, command, before, pnu);

      command = 16'b11_111_101_0000_1111; before = 16'b0000_0000_0000_0000;
      #10 command <= 16'b11_101_111_0010_0000; before <= command; // AND 111 101
      #10 command <= 16'b00_111_101_00000000; before <= command; //LD 111 0(101)
      #10 command <= 16'b11_111_001_00000000; before <= command; //ADD 001 111
      #10 command <= 16'b11_111_001_00000000; before <= command; //ADD 001 111
      #10 $finish;

   end // initial begin
endmodule // DecodeUnitTest

      
      