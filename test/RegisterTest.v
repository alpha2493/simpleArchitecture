module REGISTERTEST;
   reg clock, write, reset;
   reg [2:0] address1, address2, writeAddress;
   reg [15:0] writeData;
   wire [15:0] data1, data2;

   parameter STEP = 2;
   
   Register r (clock, write, reset, address1, address2, writeAddress, writeData, data1, data2);

   always begin
      clock = 0; #(STEP / 2);
      clock = 1; #(STEP / 2);
   end

   initial begin
      $dumpfile("registerTest.vcd");
      $dumpvars(0, REGISTERTEST);
      $monitor ("%t: clock = %b, write = %b, reset = %b, address1 = %b, writeAddress = %b, writeData = %b, data1 = %b", $time, clock, write, reset, address1, writeAddress, writeData, data1);

      $display(" --- write ---");
      write = 1'b1; writeAddress = 3'b000; writeData = 16'b0000_0000_0000_0001;
      #STEP writeAddress = 3'b001; writeData = 16'b0000_0000_0000_0010;
      #STEP writeAddress = 3'b010; writeData = 16'b0000_0000_0000_0100;
      #STEP writeAddress = 3'b011; writeData = 16'b0000_0000_0000_1000;
      #STEP writeAddress = 3'b100; writeData = 16'b0000_0000_0001_0000;
      #STEP writeAddress = 3'b101; writeData = 16'b0000_0000_0010_0000;
      #STEP writeAddress = 3'b110; writeData = 16'b0000_0000_0100_0000;
      #STEP writeAddress = 3'b111; writeData = 16'b0000_0000_1000_0000;
      #STEP writeAddress = 3'b000;

      $display(" --- load ---");
      write = 1'b0; address1 = 3'b000;
      #STEP address1 = 3'b001;
      #STEP address1 = 3'b010;
      #STEP address1 = 3'b011;
      #STEP address1 = 3'b100;
      #STEP address1 = 3'b101;
      #STEP address1 = 3'b110;
      #STEP address1 = 3'b111;
      #STEP address1 = 3'b000;
      
      $display(" --- reset ---");
      reset = 1'b1; 
      #STEP address1 = 3'b001;
      #STEP address1 = 3'b010;
      #STEP address1 = 3'b011;
      #STEP address1 = 3'b100;
      #STEP address1 = 3'b101;
      #STEP address1 = 3'b110;
      #STEP address1 = 3'b111;
      #STEP address1 = 3'b000;
      #STEP $finish;
      
   end
endmodule // ALUTEST
