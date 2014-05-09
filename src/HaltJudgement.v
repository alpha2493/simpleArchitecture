module HaltJudgement(input [15:0] COM, output out);
   
   assign out =  (COM[15:14] == 2'b11 && COM[7:4] == 4'b1111)? 1'b1 : 1'b0;
   
endmodule // HaltJudgement

       