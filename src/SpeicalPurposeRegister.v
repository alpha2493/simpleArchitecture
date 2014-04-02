/*
 * 専用レジスタ
 * 0:ゼロレジスタ
 * 1:アドレスレジスタ
 * 2:ベースレジスタ
 * 3:インデックスレジスタ
 * 4:スタックポインタ
 * 5:ベースポインタ
 * 6:データレジスタ
 * 7:空き
 */
module SpecialPurposeRegister (
   input read, write, reset,
   input [3:0] address,
   input [15:0] writeData,
   output [15:0] data);

   reg [15:0] register [0:7];
   integer i;
   reg [15:0] out1, out2;

   initial begin
      for (i = 0; i < 8 ; i = i + 1)
         register[i] = 8'0
   end

   always @ (read or write) begin
      if (reset)
         for (i = 0; i < 8 ; i = i + 1)
            register[i] = 8'0;

      if (write && address > 0)
         register[addres] = writeData;

      if (read)
         out1 = register[address1];
	 out2 = register[address2];
      else
         out1 = out2 = 16'0;
   end

   assign data1 = out1;
   assign data2 = out2;
endmodule
