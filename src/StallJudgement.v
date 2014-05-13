module StallJudgement(
       input [15:0] COMMAND, BeforeCOMMAND,
       output pcNotUpdate);

   reg pnu;

   always @ (COMMAND or BeforeCOMMAND) begin
      if (BeforeCOMMAND[15:14] == 2'b00
          && (((COMMAND[15:14] == 2'b00
                || COMMAND[15:14] == 2'b11 && COMMAND[7:4] >= 4'b1000 && COMMAND[7:4] <= 4'b1011)
               && COMMAND[10:8] == BeforeCOMMAND[13:11])
	      || (COMMAND[15:14] == 2'b11 && COMMAND[7:4] == 4'b0110 && COMMAND[7:4] <= 4'b1101
	          && COMMAND[13:11] == BeforeCOMMAND[13:11])
	      || ((COMMAND[15:14] == 2'b01
                   || COMMAND[15:14] == 2'b11 && COMMAND[7:4] >= 4'b0000 && COMMAND[7:4] <= 4'b0101)
                  && (COMMAND[10:8] == BeforeCOMMAND[13:11] || COMMAND[13:11] == BeforeCOMMAND[13:11]))))
         pnu = 1'b1;
      else
         pnu = 1'b0;
   end

   assign pcNotUpdate = pnu;
endmodule