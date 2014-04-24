module JumpJudgement(
   input       PC_load_in,
   input [2:0] cond,
   input [3:0] FLAG,
   output      PC_load_out);

   wire        S, Z, C, V;
   reg 	       pcl;

   assign {S, Z, C, V} = FLAG;
      
   always @ (PC_load_in or cond) begin
      case (cond)
	4'b000 : assign pcl = (Z && PC_load_in) ? 1'b1 : 1'b0;
	4'b001 : assign pcl = ((S ^ V) && PC_load_in) ? 1'b1 : 1'b0;
	4'b010 : assign pcl = ((Z || (S ^ V)) && PC_load_in) ? 1'b1 : 1'b0;
	4'b011 : assign pcl = (!Z && PC_load_in) ? 1'b1 : 1'b0;
	default : assign pcl = 1'b0;
      endcase // case (cond)
   end

endmodule // JumpJudgement
