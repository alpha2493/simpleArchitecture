module DECODEUNITTEST;
   reg [15:0] command, before, twobefore;
   wire [3:0] s_alu;
   wire       ar, br, in, adr, w, we, pcl, se, oa, ob, ta, tb;
   wire [2:0]  wAdr;
   wire [2:0] cond, op2;   
	       

   DecodeUnit cu (command, before, twobefore, se, oa, ob, ta, tb, ar, br, s_alu, in, we, wAdr, adr, w, pcl, cond, op2);
   

   initial begin
      $dumpfile("decodeUnitTest.vcd");
      $dumpvars(0, DECODEUNITTEST);
      $monitor("%t: %b %b %b -> forward:%b%b%b%b",$time, command, before, twobefore, oa, ob, ta, tb);

      command = 16'b11_111_101_0000_1111; before = 16'b0000_0000_0000_0000; twobefore = 16'b0000_0000_0000_0000; // ADD 101 111
      #10 command <= 16'b11_101_111_0010_0000; before <= command; // AND 111 101
      #10 command <= 16'b00_111_101_00000000; before <= command; twobefore <= before; //LD 111 0(101)
      #10 command <= 16'b11_000_001_00000000; before <= command; twobefore <= before; //ADD 001 000
      #10 $finish;

   end // initial begin
endmodule // DecodeUnitTest

      
      