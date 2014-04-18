module ControlUnit(
   input 	 CLOCK,
   input 	 RESET,
   input 	 EXEC,
   input [15:0]  COMMAND,
   input [3:0] 	 SZCV,
   output 	 Reset_signal,
   output [15:0] immidiate,
   output 	 AR_MUX, BR_MUX,
   output [3:0]  S_ALU,
   output 	 INPUT_MUX,
   output [2:0]  writeAddress,
   output 	 ADR_MUX, write, PC_load
);

   reg [3:0] 	Select_ALU;
   integer 	INON = 4'b1111;

   reg 		wr, pcl, in, adr, ar, br;
   

   

   //write
   always @ (posedge CLOCK) begin
      if ((COMMAND[15:14] == 2'b11 && COMMAND[7:4] <= 4'b1100) ||
	  COMMAND[15:14] == 2'b00 ||
	  COMMAND[15:11] == 5'b10000)
	wr <= 1;
      else
	wr <=0;
   end

   //PC_load
   always @ (posedge CLOCK) begin
      if (COMMAND[15:11] == 5'b10100 || COMMAND[15:11] == 5'b10111)
	pcl <= 1;
      else
	pcl <= 0;
   end
   


   //INPUT_MUX
   always @ (posedge CLOCK) begin
      if (COMMAND[15:14] == 2'b11 && COMMAND[7:4] == 4'b1100)
	in <= 1;
      else
	in <= 0;
   end
   

   //ADR_MUX
   always @ (posedge CLOCK) begin
      if ((COMMAND[15:14] == 2'b11 && COMMAND[7:4] <= 4'b1011) ||COMMAND[15:14] == 2'b10)
	adr <= 1;
      else
	adr <= 0;
   end
   
	  
   //BR_MUX
   always @ (posedge CLOCK) begin
      if (COMMAND[15:14] != 2'b10)
	br <= 1;
      else
	br <= 0;
   end

   //AR_MUX
   always @ (posedge CLOCK) begin
      if (COMMAND[15:14] == 2'b11 && COMMAND[7:4] <= 4'b0110)
	ar <= 1;
      else
	ar <= 0;
   end

   
      

   
	  

   //各種演算命令
   always @ (posedge CLOCK) begin
      if (COMMAND[15:14] == 2'b11)
	Select_ALU = COMMAND[7:4]; //ADD, SUB, etc
      else
	Select_ALU = INON;
   end


   //主記憶・レジスタ間のデータ転送
   always @ (posedge CLOCK) begin
      case (COMMAND[15:14])
	2'b00 : ; //LD
	2'b01 :	; //ST
      endcase // case (COMMAND[15:14])
   end


   
   always @ (posedge CLOCK) begin
      if (COMMAND[15:14] == 2'b10)
	case (COMMAND[13:11])
	  3'b000 : ; //LI
	  3'b100 : ; //B
	endcase // case (COMMAND[13:11])
   end


   //ジャンプ
   always @ (posedge CLOCK) begin
      if (COMMAND[15:11] == 5'b10111)
	case (COMMAND[10:8])
	  3'b000 : ; //BE
	  3'b001 : ; //BLT
	  3'b010 : ; //BLE
	  3'b011 : ; //BNE
	endcase // case (COMMAND[10:8])
   end
   
   assign S_ALU = Select_ALU;
   assign Reset_signal = 0;
   assign AR_MUX = ar;
   assign BR_MUX = br;
   assign write = wr;
   assign PC_load = pcl;
   assign INPUT_MUX = in;
   assign ADR_MUX = adr;
   
   
   
   
endmodule // ControlUnit
