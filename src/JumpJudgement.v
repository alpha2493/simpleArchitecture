module JumpJudgement(
   input       PC_load_in,
   input [2:0] cond, op2,
   input [3:0] FLAG,
   output      PC_load_out);

   wire        S, Z, C, V;
   reg 	       pcl;

   assign {S, Z, C, V} = FLAG;
      
   always @ (PC_load_in or cond) begin
      if (op2 == 3'b111)
	case (cond)
	  4'b000 : pcl = (Z && PC_load_in) ? 1'b1 : 1'b0;
	  4'b001 : pcl = ((S ^ V) && PC_load_in) ? 1'b1 : 1'b0;
	  4'b010 : pcl = ((Z || (S ^ V)) && PC_load_in) ? 1'b1 : 1'b0;
	  4'b011 : pcl = (!Z && PC_load_in) ? 1'b1 : 1'b0;
	  default : pcl = 1'b0;
	endcase // case (cond)
      else if (op2 == 3'b100)
	pcl = 1'b1;
      else
	pcl = 1'b0;
   end // always @ (PC_load_in or cond)
   
   assign PC_load_out = pcl;
   
endmodule // JumpJudgement
