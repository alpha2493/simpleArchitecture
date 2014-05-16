module Forwarding(
       input [15:0] One, Two,
       input One_A, One_B, Two_A, Two_B,
       output [15:0] DataA, DataB);

   wire [15:0] gnd, TwoAResult, TwoBResult;

   Multiplexer m1 (Two, gnd, Two_A, TwoAResult);

   Multiplexer m2 (Two, gnd, Two_B, TwoBResult);

   Multiplexer m3 (One, TwoAResult, One_A, DataA);

   Multiplexer m4 (One, TwoBResult, One_B, DataB);

   assign gnd = 16'b0;
endmodule