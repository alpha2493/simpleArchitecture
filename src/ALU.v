module ALU (
   input signed [15:0]  DATA_A, DATA_B,
   input [3:0]   S_ALU,
   output [15:0] ALU_OUT,
   output [3:0]  FLAG_OUT);

   integer IADD = 4'b0000;
   integer ISUB = 4'b0001;
   integer IAND = 4'b0010;
   integer IOR  = 4'b0011;
   integer IXOR = 4'b0100;
   integer ISLL = 4'b1000;
   integer ISLR = 4'b1001;
   integer ISRL = 4'b1010;
   integer ISRA = 4'b1011;
   integer IIDT = 4'b1100;
   integer INON = 4'b1111;

   function [16:0] amux(
      input signed [15:0] A, B,
      input [3:0] Selector);

      case (Selector)
         IADD : amux = {1'b0, A} + {1'b0, B};
         ISUB : amux = {1'b0, A} - {1'b0, B};
         IAND : amux = {1'b0, A & B};
         IOR  : amux = {1'b0, A | B};
         IXOR : amux = {1'b0, A ^ B};
         ISLL : amux = {1'b0, A} << B[3:0];
         ISLR : amux = ({1'b0, A} << B[3:0]) | (A >> 16 - B[3:0]);
         ISRL : amux = {B[3:0] > 0 ? A[B[3:0] - 1] : 1'b0, A >> B[3:0]};
         ISRA : amux = {B[3:0] > 0 ? A[B[3:0] - 1] : 1'b0, A >>> B[3:0]};
         IIDT : amux = {1'b0, A};
         INON : amux = 17'b0;
      endcase 
   endfunction
  
   wire [16:0]    result;
   wire [19:0]    flags;
   wire [16:0]    izero = 17'b0;

   MakeFlag mkf (DATA_A, DATA_B, result, S_ALU, flags);

   assign result = amux(DATA_A, DATA_B, S_ALU);
   assign ALU_OUT = flags[15:0];
   assign FLAG_OUT = flags[19:16];
endmodule

module MakeFlag(
       input [15:0] DATA_A, DATA_B,
       input [16:0] result,
       input [3:0] S_ALU, 
       output [19:0] out);

   integer IADD = 4'b0000;
   integer ISUB = 4'b0001;
   integer IAND = 4'b0010;
   integer IOR  = 4'b0011;
   integer IXOR = 4'b0100;
   integer ISLL = 4'b1000;
   integer ISLR = 4'b1001;
   integer ISRL = 4'b1010;
   integer ISRA = 4'b1011;
   integer IIDT = 4'b1100;
   integer INON = 4'b1111;

   wire Z, S, V;
   
   assign S = result[15] == 1'b1 ? 1 : 0;
   assign Z = result[15:0] == 16'b0 ? 1 : 0;
   assign V = (((S_ALU == IADD) && (DATA_A[15] == DATA_B[15]) && (DATA_A[15] != result[15]))
               || ((S_ALU == ISUB) && (DATA_A[15] != DATA_B[15]) && (DATA_A[15] != result[15]))) ? 1 : 0;
   assign out = {S, Z, V, result};
endmodule
