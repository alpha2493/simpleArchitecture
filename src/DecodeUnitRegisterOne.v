module DecodeUnitRegisterOne(
   input  CLK, AR_IN, BR_IN, [3:0] ALU_IN, input_IN, wren_IN, [2:0] writeAd_IN, ADR_MUX_IN, write_IN, PC_load_IN,
   output AR_OUT, BR_OUT, [3:0] ALU_OUT, input_OUT, wren_OUT, [2:0] writeAd_OUT, ADR_MUX_OUT, write_OUT, PC_load_OUT);

   reg    ar, br, [3:0] alu, in, wren, [2:0] writeAd, adrmux, write, pcload;

   always @ (posedge CLK) begin
      ar <= AR_IN;
      br <= BR_IN;
      alu <= ALU_IN;
      in <= input_IN;
      wren <= wren_IN;
      writeAd <= writeAd_IN;
      adrmux <= ADR_MUX_IN;
      write <= write_IN;
      pcload <= PC_load_IN;
   end // always @ (posedge CLK)
   
   assign AR_OUT = ar;
   assign BR_OUT = br;
   assign ALU_OUT = alu;
   assign input_OUT = in;
   assign wren_OUT = wren;
   assign writeAd_OUT = writeAd;
   assign ADR_MUX_OUT = adrmux;
   assign write_OUT = write;
   assign PC_load_OUT = pcload;
   
endmodule // DecodeUnitRegisterOne
