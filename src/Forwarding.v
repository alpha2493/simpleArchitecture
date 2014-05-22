module Forwarding(
       input [15:0]  One, Two,
       input         One_A, One_B, Two_A, Two_B, MW_One, MW_Two,
       output        ForwardA, ForwardB, MW_Forward,
       output [15:0] DataA, DataB, MW_Forward_Data);

   wire [15:0] gnd, TwoAResult, TwoBResult, TwoMWResult;

   Multiplexer m1 (Two, gnd, Two_A, TwoAResult);

   Multiplexer m2 (Two, gnd, Two_B, TwoBResult);

   Multiplexer m3 (One, TwoAResult, One_A, DataA);

   Multiplexer m4 (One, TwoBResult, One_B, DataB);

   Multiplexer m5 (Two, gnd, MW_Two, TwoMWResult);

   Multiplexer m6 (One, TwoMWResult, MW_Two, MW_Forward_Data);

   assign gnd = 16'b0;
   assign ForwardA = One_A | Two_A;
   assign ForwardB = One_B | Two_B;
   assign MW_Forward = MW_One | MW_Two;
endmodule