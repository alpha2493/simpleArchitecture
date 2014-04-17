module CONTROLUNITTEST;
   reg [15:0] command;
   reg 	      clock;
   wire [3:0] s_alu;

   ControlUnit cu (clock, 0, command, s_alu);

   initial begin
      $dumpfile("cuTest.vcd");
      $dumpvars(0, CONTROLUNITTEST);
      $monitor("%t", command, s_alu);

      clock = 0;
      command = 16'b1111110100001111;
      #10 clock = 1;
      #10 clock = 0; command = 16'b0011110100000000;
      #10 clock = 1;
      #10 $finish;

   end // initial begin
endmodule // ControlUnitTest

      
      