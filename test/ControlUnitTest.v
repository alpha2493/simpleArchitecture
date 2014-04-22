module CONTROLUNITTEST;

   initial begin
      $dumpfile("controlUnitTest.vcd");
      $dumpvars(0, CONTROLUNITTEST);
      $monitor("%t",$time);

      #10 $finish;
      
   end
   
endmodule // ControlUnitTest
