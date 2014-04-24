module DecodeUnitRegisterTwo(
   input  input_IN, wren_IN, CLK,
   output input_OUT, wren_OUT);

   reg    in, wren;

   always @ (posedge CLK) begin
      in <= input_IN;
      wren <= wren_IN;
   end
   
   assign input_OUT = in;
   assign wren_OUT = wren;
   
endmodule // DecodeUnitRegisterTwo

