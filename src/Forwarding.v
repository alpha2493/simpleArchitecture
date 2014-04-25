module Forwarding(
       input [15:0] OneA, OneB, TwoA, TwoB, 
       input One_A, One_B, Two_A, Two_B,
       output [15:0] DataA, DataB);

   wire [15:0] gnd, TwoAResult, TwoBResult;

   Multiplexer m1 (TwoA, gnd, Two_A, TwoAResult);

   Multiplexer m2 (TwoB, gnd, Two_B, TwoBResult);

   Multiplexer m3 (OneA, TwoAResult, One_A, DataA);

   Multiplexer m4 (OneB, TwoBResult, One_B, DataB);

   assign gnd = 16'b0;
endmodule