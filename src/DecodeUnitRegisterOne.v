module DecodeUnitRegisterOne(
   input  CLK, AR_IN, BR_IN, ALU_IN[3:0], input_IN, wren_IN, writeAd_IN[2:0], ADR_MUX_IN, write_IN, PC_load_IN,
   output AR_OUT, BR_OUT, ALU_OUT[3:0], input_OUT, wren_OUT, writeAd_OUT[2:0], ADR_MUX_OUT, write_OUT, PC_load_OUT);

   reg    ar, br, alu[3:0], in, wren, writeAd[2:0], adrmux, write, pcload;

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
   end
   
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

