module BusExtractor(input [15:0] in,
		    output [1:0] op1,
		    output [2:0] op2,
		    output [2:0] cond,
		    output [3:0] op3);

   
   function [3:0] ExOp3(
      input [15:0] fin);
      ExOp3 = fin[7:4];
   endfunction // ExOp3
   
   function [2:0] ExOp2(
      input [15:0] fin);
      ExOp2 = fin[13:11];
   endfunction // ExOp2
   
   function [2:0] ExCond(
      input [15:0] fin);
      ExCond = fin[10:8];
   endfunction // ExCond
   
   function [1:0] ExOp1(
      input [15:0] fin);
      ExOp1 = fin[15:14];
   endfunction // ExOp1
   

   assign op3 = ExOp3(in);
   assign op2 = ExOp2(in);
   assign cond = ExCond(in);
   assign op1 = ExCond(in);
   
   
endmodule // BusExtractor
