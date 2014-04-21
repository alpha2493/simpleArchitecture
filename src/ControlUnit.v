module ControlUnit(
   input 	 CLOCK,
   input 	 RESET,
   input 	 EXEC,
   output  CLK,
   output  RES_SIG
);

   reg     clock_switch = 1;
   reg     chattering_switch = 1;

   always @ (posedge EXEC) begin
	    if (chattering_switch)
        begin
           clock_switch <= ~ clock_switch;
           chattering_switch <= 0;
        end
   end

   always @ (posedge CLK) begin
      chattering_switch <= 1;
   end

   assign CLK = CLOCK & clock_switch;
   assign RES_SIG = RESET;
   
endmodule
