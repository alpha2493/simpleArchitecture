module DecodeUnitRegisterThree(
   input        CLK,
   input [2:0]  writeAd_IN,
   input        write_IN, PC_load_IN,
   output [2:0] writeAd_OUT,
   output       ADR_MUX_OUT, write_OUT, PC_load_OUT);

   reg [2:0]    writeAd;
   reg          write, pcload;

   always @ (posedge CLK) begin
      writeAd <= writeAd_IN;
      write <= write_IN;
      pcload <= PC_load_IN;
   end // always @ (posedge CLK)
   
   assign writeAd_OUT = writeAd;
   assign write_OUT = write;
   assign PC_load_OUT = pcload;
   
   
endmodule // DecodeUnitRegisterThree


