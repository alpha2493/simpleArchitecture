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

   wire [16:0]    result;
   wire [19:0]    flags;
   wire [16:0]    iadd, isub, iand, ior, ixor, isll, islr, isrl, isra, iidt, inon;
   wire [16:0]    izero = 17'b0;

   ALU_MUX alum (iadd, isub, iand, ior, ixor, izero, izero, izero, isll, islr, isrl, isra, iidt, izero, izero, inon, S_ALU, result);
   MakeFlag mkf (DATA_A, DATA_B, S_ALU, result, flags);

   assign iadd = {1'b0, DATA_A} + {1'b0, DATA_B};
   assign isub = {1'b0, DATA_A} - {1'b0, DATA_B};
   assign iand = {1'b0, DATA_A & DATA_B};
   assign ior = {1'b0, DATA_A | DATA_B};
   assign ixor = {1'b0, DATA_A ^ DATA_B};
   assign isll = {1'b0, DATA_A} << DATA_B[3:0];
   assign islr = ({1'b0, DATA_A} << DATA_B[3:0]) | (DATA_A >> 16 - DATA_B[3:0]);
   assign isrl = {DATA_B[3:0] > 0 ? DATA_A[DATA_B[3:0] - 1] : 1'b0, DATA_A >> DATA_B[3:0]};
   assign isra = {DATA_B[3:0] > 0 ? DATA_A[DATA_B[3:0] - 1] : 1'b0, DATA_A >>> DATA_B[3:0]};
   assign iidt = {1'b0, DATA_A};
   assign inon = 17'b0;

   assign ALU_OUT = result[15:0];
   assign FLAG_OUT = flags[19:16];
endmodule

module ALU_MUX(
       input [16:0] data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15,
       input [3:0] selector,
       output [16:0] data);

   function [16:0] amux(
      input [16:0] data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15,
      input [3:0] Selector);

      case (Selector)
         4'b0000 : amux = data0;
         4'b0001 : amux = data1;
         4'b0010 : amux = data2;
         4'b0011 : amux = data3;
         4'b0100 : amux = data4;
         4'b0101 : amux = data5;
         4'b0110 : amux = data6;
         4'b0111 : amux = data7;
         4'b1000 : amux = data8;
         4'b1001 : amux = data9;
         4'b1010 : amux = data10;
         4'b1011 : amux = data11;
         4'b1100 : amux = data12;
         4'b1101 : amux = data13;
         4'b1110 : amux = data14;
         4'b1111 : amux = data15;
    	 default : amux = 17'b0;
      endcase 
   endfunction

   assign data = amux(data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, selector);
endmodule

module MakeFlag(
       input [15:0] DATA_A, DATA_B,
       input [3:0] S_ALU,
       input [16:0] result,
       output [19:0] flag);

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
   
   wire S, Z, V;   
   
   assign S = result[15] == 1'b1 ? 1 : 0;
   assign Z = result[15:0] == 16'b0 ? 1 : 0;
   assign V = (((S_ALU == IADD) && (DATA_A[15] == DATA_B[15]) && (DATA_A[15] != result[15]))
               || ((S_ALU == ISUB) && (DATA_A[15] != DATA_B[15]) && (DATA_A[15] != result[15]))) ? 1 : 0;
   assign flag = {S, Z, result[16], V, result[15:0]};
endmodule
