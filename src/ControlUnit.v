module ControlUnit(
   input 	 CLOCK,
   input 	 RESET,
   input 	 EXEC,
   output  CLK,
   output  RES_SIG
);

   reg     clock_switch = 1;
   reg [1:0] chattering_switch = 2;

   always @ (posedge EXEC or posedge CLOCK) begin
      if (EXEC) chattering_switch <= 1;
      else if (chattering_switch > 1) chattering_switch <= chattering_switch - 1;
      else if (chattering_switch == 1)
        begin
           clock_switch = ~clock_switch;
           chattering_switch <= 0;
        end           
   end
   
   assign CLK = CLOCK & clock_switch;
   assign RES_SIG = RESET;
   
endmodule
