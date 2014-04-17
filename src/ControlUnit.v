module ControlUnit(
   input        CLOCK,
   input        RESET,
   input [15:0] EXEC,
   output [3:0] S_ALU);

   reg [3:0]    ALUselect;
   integer 	INON = 4'b1111;


   //各種演算命令
   always @ (posedge CLOCK) begin
      if (EXEC[15:14] == 2'b11)
	ALUselect = EXEC[7:4]; //ADD, SUB, etc
      else
	ALUselect = INON;      
   end


   //主記憶・レジスタ間のデータ転送
   always @ (posedge CLOCK) begin
      case (EXEC[15:14])
	2'b00 : ; //LD
	2'b01 :	; //ST
      endcase // case (EXEC[15:14])
   end
   
   always @ (posedge CLOCK) begin
      if (EXEC[15:14] == 2'b10)
	case (EXEC[13:11])
	  2'b000 : ; //LI
	  2'b100 : ; //B
	endcase // case (EXEC[13:11])
   end


   always @ (posedge CLOCK) begin
      if (EXEC[15:11] == 2'b10111)
	case (EXEC[10:8])
	  2'b000 : ; //BE
	  2'b001 : ; //BLT
	  2'b010 : ; //BLE
	  2'b011 : ; //BNE
	endcase // case (EXEC[10:8])
   end
   
   assign S_ALU = ALUselect;
   
endmodule // ControlUnit
