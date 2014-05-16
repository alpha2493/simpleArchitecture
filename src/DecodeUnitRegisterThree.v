module DecodeUnitRegisterThree(
   input 	CLK,
   input [2:0] 	writeAd_IN,
   input 	ADR_MUX_IN, write_IN, PC_load_IN,
   input 	SPR_w_IN, SPR_i_IN, SPR_d_IN,
   output [2:0] writeAd_OUT,
   output 	ADR_MUX_OUT, write_OUT, PC_load_OUT,
   output 	SPR_w_OUT, SPR_i_OUT, SPR_d_OUT);
   

   reg [2:0]    writeAd;
   reg          adrmux, write, pcload;
   reg 		sprw,spri,sprd;
 		

   always @ (posedge CLK) begin
      writeAd <= writeAd_IN;
      adrmux <= ADR_MUX_IN;
      write <= write_IN;
      pcload <= PC_load_IN;
      sprw <= SPR_w_IN;
      spri <= SPR_i_IN;
      sprd <= SPR_d_IN;
   end // always @ (posedge CLK)
   
   assign writeAd_OUT = writeAd;
   assign ADR_MUX_OUT = adrmux;
   assign write_OUT = write;
   assign PC_load_OUT = pcload;
   assign SPR_w_OUT = sprw;
   assign SPR_i_OUT = sprd;
   assign SPR_d_OUT = sprd;
   
endmodule // DecodeUnitRegisterThree


