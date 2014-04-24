module OnewordRegister(
   input  AR_IN, BR_IN, ALU_IN, input_IN, wren_IN, CLK,
   output AR_OUT, BR_OUT, ALU_OUT, input_OUT, wren_OUT);

   reg    ar, br, alu, in, wren;

   always @ (posedge CLK) begin
      ar <= AR_IN;
      br <= BR_IN;
      alu <= ALU_IN;
      in <= input_IN;
      wren <= wren_IN;
   end
   
   assign AR_OUT = ar;
   assign BR_OUT = br;
   assign ALU_OUT = alu;
   assign input_OUT = in;
   assign wren_OUT = wren;
   
endmodule // OnewordRegister
