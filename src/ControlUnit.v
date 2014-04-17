module ControlUnit(
   input        CLOCK,
   input        RESET,
   input [15:0] EXEC,
   output [3:0] S_ALU,
   output [2:0] registerAddress1, registerAddress2
   );

   reg [15:0] operands[0:4];
   integer i;
   reg [15:0] op;
   reg [3:0]    ALUselect;
   reg [1:0] OP1 = EXEC[15:14];
   reg [2:0] Rs = EXEC[13:11];
   reg [2:0] Rd = EXEC[10:8];
   reg [7:0] d = EXEC[7:0];
   reg [3:0] R1 = 4'b0, R2 = 4'b0;

   always @ (posedge CLOCK) begin
      operands[0] = EXEC;
      for (i = 4; i >= 0; i = i - 1)
         op = operands[i];
         if (i == 0)
         else if (i == 1)
         else if (i == 2)
         else if (i == 3)
         else if (i == 4)
         OP1 = op[15:14];
         Rs = op[13:11];
         Rd = op[10:8];
         d = op[7:0];
         case (OP1)
            2'b11 : ALUselect = d[7:4]; R1 = Rs; R2 = Rd;//op3 
            2'b00 : ;
            2'b01 : ;
            //op2
            2'b10 : ;
              case (Rs)
                3'b000 : ;
                3'b100 : ;
                //cond
                3'b111 :
                  case (Rd)
                     3'b000 : ;
                     3'b001 : ;
                     3'b010 : ;
                     3'b011 : ;
                     default : ;
                  endcase // case (Rd)
              endcase // case(Rs)
         endcase // case (OP1)
         if (i < 4)
            operands[i + 1] = operands[i];
   end // always @ (posedge CLOCK)

   assign S_ALU = ALUselect;
   assign registerAddress1 = R1; registerAddress2 = R2;
endmodule // ControlUnit
