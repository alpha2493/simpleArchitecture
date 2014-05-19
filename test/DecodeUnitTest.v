module DECODEUNITTEST;
   reg [15:0] command, before, twobefore;
   wire [3:0] s_alu;
   wire       ar, br, in, adr, w, we, pcl, se, spc, ab, mw, inc, dec, spw, sps, mad, o;
   wire [2:0]  wAdr;
   wire [2:0] cond, op2;

   DecodeUnit cu (twobefore, before, command, o, oa, ob, ta, tb, in, we, wAdr, adr, w, pcl, spw, inc, dec, cond, op2, sps, mad, ar, br, s_alu, spc, mw, ab, se);

   initial begin
      $dumpfile("decodeUnitTest.vcd");
      $dumpvars(0, DECODEUNITTEST);
      $monitor("%t: %b %b %b -> forward:%b%b%b%b",$time, command, before, twobefore, oa, ob, ta, tb);

      command = 16'b10_001_011_00001010; before = 16'b0000_0000_0000_0000; twobefore = 16'b0000_0000_0000_0000; // ADDI [3] 10
      #10 command <= 16'b01_011_000_00000010; before <= command; // ST [3] 2([0])
      //#10 command <= 16'b01_001_000_00000000; before <= command; twobefore <= before; // ST [1] 0([0])
      #10 $finish;

   end // initial begin
endmodule // DecodeUnitTest

      
      