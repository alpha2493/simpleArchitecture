module DECODEUNITTEST;
   reg [15:0] command;
   wire [3:0] s_alu;
   wire       ar, br, in, adr, w, we, pcl, se, spc, ab, mw, inc, dec, spw, sps, mad;
   wire [2:0]  wAdr;
   wire [2:0] cond, op2;

   DecodeUnit cu (command, se, ar, br, spc, ab, mw, s_alu, sps, mad, in, we, wAdr, adr, w, pcl, int, dec, spw, cond, op2);
   

   initial begin
      $dumpfile("decodeUnitTest.vcd");
      $dumpvars(0, DECODEUNITTEST);
      $monitor("%t: %b -> alu:%b",$time, command, s_alu);

      command = 16'b11_111_101_0000_1111; //ADD 111 101 
      #10 command = 16'b11_111_101_0010_0000; //AND 111 101
      #10 command = 16'b00_111_101_00000000; //LD 111 0(101)
      #10 $finish;

   end // initial begin
endmodule // DecodeUnitTest

      
      