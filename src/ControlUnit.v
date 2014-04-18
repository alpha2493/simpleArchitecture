module ControlUnit(
   input 	 CLOCK,
   input 	 RESET,
   input [15:0]  COMMAND,
   input [3:0] 	 SZCV,
   input [7:0] 	 d,
   input [15:0]  ALU_Value,
   input [15:0]  Ra,
   output [3:0]  writeAddress,
   output [3:0]  S_ALU,
   output [15:0] immidiate,
   output 	 PC_load, Reset, AR_MUX, BR_MUX, INPUT_MUX, ADR_MUX, write
   );

   reg [15:0] operands[0:4];
   integer i;
   reg [15:0] op;
   reg [1:0] OP1 = EXEC[15:14];
   reg [2:0] Rs = EXEC[13:11];
   reg [2:0] Rd = EXEC[10:8];
   reg [7:0] d = EXEC[7:0];
   reg [3:0] R1 = 4'b0, R2 = 4'b0;

   reg [3:0] 	Select_ALU;
   integer 	INON = 4'b1111;

   //BR_MUX
   always @ (posedge CLOCK) begin
      if (COMMAND[15:14] != 2'b10 || COMMAND[15:11] == 5'b10000)
	assign BR_MUX = 1;
      else
	assign BR_MUX = 0;
   end

   //AR_MUX
   always @ (posedge CLOCK) begin
      if (COMMAND[15:14] == 2'b11 && COMMAND[7:4] <= 4'b0110)
	assign AR_MUX = 1;
      else
	assign AR_MUX = 0;
   end

   //
   	  
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
_	  3'b011 : ; //BNE
	endcase // case (COMMAND[10:8])
   end
   
   assign S_ALU = Select_ALU;
   
endmodule // ControlUnit
