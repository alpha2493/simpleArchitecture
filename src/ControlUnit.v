module ControlUnit(
   input        CLOCK,
   input        RESET,
   input [15:0] EXEC,
   output [3:0] S_ALU);

   reg [3:0]    ALUselect;

   always @ (posedge CLOCK) begin
      case (EXEC[15:14])
	      2'b11 : ALUselect = EXEC[7:4]; //op3
	      //op1
	      2'b00 : ;
	      2'b01 : ;
	      //op2
	      2'b10 :
	        case (EXEC[13:11])
	          3'b000 : ;
	          3'b100 : ;
	          //cond
	          3'b111 :
	            case (EXEC[10:8])
		            3'b000 : ;
		            3'b001 : ;
		            3'b010 : ;
		            3'b011 : ;
		            default : ;
	            endcase // case (EXEC[10:8])
	        endcase // case (EXEC[13:11])
      endcase // case (EXEC[15:14])
   end // always @ (posedge CLOCK)


   always @ (posedge CLOCK) begin
      case (EXEC[15:14])
	2'b11 : ALUselect = EXEC[7:4];
      endcase // case (EXEC[15:14])
   end
   
   
endmodule // ControlUnit
