module SignExtension(I, sw, O);
   input [7:0]  I;
   input         sw;
   output [15:0] O;
	
   function [15:0] signExt(
      input [7:0] data,
      input sw);

		reg [11:0] ext;
		integer i;

      begin
			i = sw ? 8 : 4;
			ext = {12{data[i - 1]}};
			if (sw)
				signExt = {ext[7:0], data};
			else 
				signExt = {ext, data[3:0]};
      end
   endfunction

   assign O = signExt(I, sw);
endmodule

module NotSignExtension(I, sw, O);
   input [7:0]  I;
   input         sw;
   output [15:0] O;
	
	wire [15:0] out1; 
	
   function [15:0] notSignExt(
      input [7:0] data,
      input sw);

		reg [11:0] ext;
		
      begin
			ext = 12'b0;
			if (sw)
				notSignExt = {ext[7:0], data};
			else 
				notSignExt = {ext, data[3:0]};
      end
   endfunction

   assign O = notSignExt(I, sw);
endmodule
