module CONTROLUNITTEST;
   reg [15:0] command;
   reg 	      clock;
   wire [3:0] s_alu;

   ControlUnit cu (clock, 0, command, s_alu);

   initial begin
      $dumpfile("cuTest.vcd");
      $dumpvars(0, CONTROLUNITTEST);
      $monitor("%t:%b: %b -> alu:%b",$time, clock,  command, s_alu);

      clock = 0;
      command = 16'b11_111_101_0000_1111; //ADD 111 101 
      #10 clock = 1;
      #10 clock = 0; command = 16'b11_111_101_0010_0000; //AND 111 101
      #10 clock = 1;
      #10 clock = 0; command = 16'b00_111_101_00000000; //LD 111 0(101)
      #10 clock = 1;
      #10 $finish;

   end // initial begin
endmodule // ControlUnitTest

      
      