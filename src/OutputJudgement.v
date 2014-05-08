module OuputJudgement(
   input [15:0] COMMAND,
   output 	out);

   assign out = (COMMAND[15:14] == 2'b11 && COMMAND[7:4] == 4'b1101) ? 1'b1 : 1'b0;
endmodule // OuputJudgement

	
   
   
   