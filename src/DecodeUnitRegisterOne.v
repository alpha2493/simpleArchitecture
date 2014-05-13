module DecodeUnitRegisterOne(
   input 	CLK, One_A_IN, One_B_IN, Two_A_IN, Two_B_IN, AR_IN, BR_IN,
   input [3:0] 	ALU_IN,
   input 	input_IN, wren_IN,
   input [2:0] 	writeAd_IN,
   input 	ADR_MUX_IN, write_IN, PC_load_IN,
   input [2:0]	cond_IN, op2_IN,
   output       One_A_OUT, One_B_OUT, Two_A_OUT, Two_B_OUT,
   output 	AR_OUT, BR_OUT,
   output [3:0] ALU_OUT,
   output 	input_OUT, wren_OUT,
   output [2:0] writeAd_OUT,
   output 	ADR_MUX_OUT, write_OUT, PC_load_OUT,
   output [2:0] cond_OUT, op2_OUT);

   reg          oa, ob, ta, tb;
   reg          ar, br;
   reg [3:0]    alu;
   reg          in, wren;
   reg [2:0]    writeAd;
   reg          adrmux, write, pcload;
   reg [2:0] 	cond, opera2;

   always @ (posedge CLK) begin
      oa <= One_A_IN;
      ob <= One_B_IN;
      ta <= Two_A_IN;
      tb <= Two_B_IN;
      ar <= AR_IN;
      br <= BR_IN;
      alu <= ALU_IN;
      in <= input_IN;
      wren <= wren_IN;
      writeAd <= writeAd_IN;
      adrmux <= ADR_MUX_IN;
      write <= write_IN;
      pcload <= PC_load_IN;
      cond <= cond_IN;
      opera2 <= op2_IN;
   end // always @ (posedge CLK)
   
   assign One_A_OUT = oa;
   assign One_B_OUT = ob;
   assign Two_A_OUT = ta;
   assign Two_B_OUT = tb;
   assign AR_OUT = ar;
   assign BR_OUT = br;
   assign ALU_OUT = alu;
   assign input_OUT = in;
   assign wren_OUT = wren;
   assign writeAd_OUT = writeAd;
   assign ADR_MUX_OUT = adrmux;
   assign write_OUT = write;
   assign PC_load_OUT = pcload;
   assign cond_OUT = cond;
   assign op2_OUT = opera2;
   
endmodule // DecodeUnitRegisterOne
