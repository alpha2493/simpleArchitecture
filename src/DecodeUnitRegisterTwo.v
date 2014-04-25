module DecodeUnitRegisterTwo(
   input 	CLK,
   input 	input_IN, wren_IN,
   input [2:0] 	writeAd_IN,
   input 	ADR_MUX_IN, write_IN, PC_load_IN,
   input [2:0] 	cond_IN, op2_IN,
   output 	input_OUT, wren_OUT,
   output [2:0] writeAd_OUT,
   output 	ADR_MUX_OUT, write_OUT, PC_load_OUT,
   output [2:0] cond_OUT, op2_OUT);

   reg          in, wren;
   reg [2:0]    writeAd;
   reg          adrmux, write, pcload;
   reg [2:0] 	cond, opera2;
   

   always @ (posedge CLK) begin
      in <= input_IN;
      wren <= wren_IN;
      writeAd <= writeAd_IN;
      adrmux <= ADR_MUX_IN;
      write <= write_IN;
      pcload <= PC_load_IN;
      cond <= cond_IN;
      opera2 <= op2_IN;
   end // always @ (posedge CLK)
   
   assign input_OUT = in;
   assign wren_OUT = wren;
   assign writeAd_OUT = writeAd;
   assign ADR_MUX_OUT = adrmux;
   assign write_OUT = write;
   assign PC_load_OUT = pcload;
   assign cond_OUT = cond;
   assign op2_OUT = opera2;
endmodule // DecodeUnitRegisterTwo

