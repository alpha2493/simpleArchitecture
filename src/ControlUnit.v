module ControlUnit(
   input        CLOCK,
   input        RESET,
   input [15:0] EXEC,
   output [3:0] S_ALU);

   reg [3:0] 	Select_ALU;
   integer 	INON = 4'b1111;


   //各種演算命令
   always @ (posedge CLOCK) begin
      if (EXEC[15:14] == 2'b11)
	Select_ALU = EXEC[7:4]; //ADD, SUB, etc
      else
	Select_ALU = INON;      
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
	  3'b000 : ; //LI
	  3'b100 : ; //B
	endcase // case (EXEC[13:11])
   end


   //ジャンプ
   always @ (posedge CLOCK) begin
      if (EXEC[15:11] == 5'b10111)
	case (EXEC[10:8])
	  3'b000 : ; //BE
	  3'b001 : ; //BLT
	  3'b010 : ; //BLE
	  3'b011 : ; //BNE
	endcase // case (EXEC[10:8])
   end
   
   assign S_ALU = Select_ALU;
   
   
endmodule // ControlUnit
