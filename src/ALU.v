module ALU (
   input [15:0]  DATA_A, DATA_B,
   input [3:0]   S_ALU,
   output [15:0] ALU_OUT,
   output [3:0]  FLAG_OUT);
   
   integer       IADD = 4'b0000;
   integer       ISUB = 4'b0001;
   integer       IAND = 4'b0010;
   integer       IOR  = 4'b0011;
   integer       IXOR = 4'b0100;
   integer       ISLL = 4'b1000;
   integer       ISLR = 4'b1001;
   integer       ISRL = 4'b1010;
   integer       ISRA = 4'b1011;
   integer       INON = 4'b1111;
	 
   
   reg [16:0]    result;
   reg           S,Z,C,V = 0;
   
   function [16:0] ShiftLeftLogical(
      input [15:0] in,
      input [3:0]  shift);
      
      begin
	       ShiftLeftLogical = {1'b0, in};
	       ShiftLeftLogical = ShiftLeftLogical << shift;
      end
   endfunction
   
   function [16:0] ShiftLeftRotate(
      input [15:0] in,
      input [3:0]  shift);
      
      reg [15:0]   shifted;
      reg          carry;
      integer      i;
      
      begin
         carry = 0;
         if (shift > 0)
           carry = in[16 - shift];
         shifted = in << shift;
         for (i = 0; i < shift; i = i + 1)
           shifted[i] = in[16 - shift + i];
         ShiftLeftRotate = {carry, shifted};
      end
   endfunction
   
   function [16:0] ShiftRightLogical(
      input [15:0] in,
      input [3:0]  shift);
      
      reg [15:0]   shifted;
      reg          carry;
      
      begin
         carry = 0;
         if (shift > 0)
           carry = in[shift - 1];
         shifted = in >> shift;
         ShiftRightLogical = {carry, shifted};	 
      end
   endfunction
   
   function [16:0] ShiftRightArithmatic(
      input [15:0] in,
      input [3:0]  shift);
      
      reg [15:0]   shifted;
      reg          carry;
      integer      i;
      
      begin
	       carry = 0;
	       if (shift > 0)
	         carry = in[shift - 1];
	       shifted = in >> shift;
	       for (i = 0; i < shift; i = i + 1)
	         shifted[15 - i] = in[15];
	       ShiftRightArithmatic = {carry, shifted};	 
      end
   endfunction
   
   always @ (DATA_A or DATA_B or S_ALU) begin
      case (S_ALU)
	      IADD : result = {1'b0, DATA_A} + {1'b0, DATA_B};
	      ISUB : result = {1'b0, DATA_A} - {1'b0, DATA_B};
	      IAND : result = {1'b0, DATA_A & DATA_B};
	      IOR  : result = {1'b0, DATA_A | DATA_B};
	      IXOR : result = {1'b0, DATA_A ^ DATA_B};
	      ISLL : result = ShiftLeftLogical(DATA_A, DATA_B[3:0]);
	      ISLR : result = ShiftLeftRotate(DATA_A, DATA_B[3:0]);
	      ISRL : result = ShiftRightLogical(DATA_A, DATA_B[3:0]);
	      ISRA : result = ShiftRightArithmatic(DATA_A, DATA_B[3:0]);
	      INON : result = 0;
	      default : result = 0;
      endcase // case S_ALU
      if (S_ALU != INON) begin
	 Z <= result[15:0] == 0;
	 C <= result[16];
	 S <= result[15] == 1;
	 if (((S_ALU == IADD) 
              && (DATA_A[15] == DATA_B[15])
	      && (DATA_A[15] != result[15]))
	     || ((S_ALU == ISUB)
	         && (DATA_A[15] != DATA_B[15])
	         && (DATA_A[15] != result[15])))
	   V = 1;
	 else
	   V = 0;
      end // if (S_ALU != INON)
   end // initial begin

   assign ALU_OUT[15:0] = result[15:0];
   assign FLAG_OUT = {S, Z, C, V};
endmodule
