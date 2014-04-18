module ALU (
   input signed [15:0]  DATA_A, DATA_B,
   input [3:0]   S_ALU,
   output [15:0] ALU_OUT,
   output [3:0]  FLAG_OUT);

   parameter IADD = 4'b0000;
   parameter ISUB = 4'b0001;
   parameter IAND = 4'b0010;
   parameter IOR  = 4'b0011;
   parameter IXOR = 4'b0100;
   parameter ISLL = 4'b1000;
   parameter ISLR = 4'b1001;
   parameter ISRL = 4'b1010;
   parameter ISRA = 4'b1011;
   parameter INON = 4'b1111;

   reg [16:0]    result;
   reg           S,Z,C,V;

   always @ (DATA_A or DATA_B or S_ALU) begin
      case (S_ALU)
         IADD : result = {1'b0, DATA_A} + {1'b0, DATA_B};
         ISUB : result = {1'b0, DATA_A} - {1'b0, DATA_B};
         IAND : result = {1'b0, DATA_A & DATA_B};
         IOR  : result = {1'b0, DATA_A | DATA_B};
         IXOR : result = {1'b0, DATA_A ^ DATA_B};
         ISLL : result = {1'b0, DATA_A} << DATA_B[3:0];
         ISLR : result = ({1'b0, DATA_A} << DATA_B[3:0]) | (DATA_A >> 16 - DATA_B[3:0]);
         ISRL : result = {DATA_B[3:0] > 0 ? DATA_A[DATA_B[3:0] - 1] : 1'b0, DATA_A >> DATA_B[3:0]};
         ISRA : result = {DATA_B[3:0] > 0 ? DATA_A[DATA_B[3:0] - 1] : 1'b0, DATA_A >>> DATA_B[3:0]};
         INON : result = 16'b0;
         default : result <= 16'b0;
      endcase // case S_ALU
      if (S_ALU != INON) begin
         Z = result[15:0] == 1'b0;
         C = result[16];
         S = result[15] == 1'b1;
         if (((S_ALU == IADD) 
              && (DATA_A[15] == DATA_B[15])
              && (DATA_A[15] != result[15]))
             || ((S_ALU == ISUB)
                 && (DATA_A[15] != DATA_B[15])
                 && (DATA_A[15] != result[15])))
            V = 1'b1;
         else
            V = 1'b0;
      end // if (S_ALU != INON)
   end // initial begin

   assign ALU_OUT = result[15:0];
   assign FLAG_OUT = {S, Z, C, V};
endmodule
