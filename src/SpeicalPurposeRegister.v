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
module ZeroRegister (
   input read, write, reset,
   input [3:0] address,
   input [15:0] writeData,
   output[15:0] data);

   reg[15:0] out = 16'b0;

   always @ (read or write or reset) begin
      if (read)
        out = 16'b0;
   end

   assign data = out;
endmodule

module AddressRegister (
   input read, write, reset,
   input [3:0] address,
   input [15:0] writeData,
   output[15:0] data);

   reg[15:0] out = 16'b0;
   integer i;
   reg[15:0] d = 16'b0;

   always @ (read or write or reset) begin
      if (reset)
        for (i = 0; i < 8 ; i = i + 1)
          d = 8'b0;

      if (write)
        d = writeData;

      if (read)
        out = d;
      else
        out = 16'b0;
   end

   assign data = out;
endmodule

module BaseRegister(
   input read, write, reset,
   input [15:0]  address,
   input [15:0] writeData,
   output [15:0] data);

   reg [15:0]    base [0:65535];
   integer       i;
   reg [15:0]    r;
   
   initial begin
      for (i = 0; i < 65536; i = i + 1)
         base[i] = 16'b0;
   end
   
   always @ (read or write or reset) begin
      if (reset)
         for (i = 0; i < 65536; i = i + 1)
            base[i] = 16'b0;

      if (write)
         base[address] = writeData;

      if (read)
         r = base[address];
      else
         r = 16'b0;
   end
   
   assign data = r;
endmodule

module IndexRegister(
   input read, write, reset,
   input [15:0]  address,
   input [15:0] writeData,
   output [15:0] data);

   reg [15:0]    index [0:65535];
   integer       i;
   reg [15:0]    r;
   
   initial begin
      for (i = 0; i < 65536; i = i + 1)
         index[i] = 16'b0;
   end
   
   always @ (read or write or reset) begin
      if (reset)
         for (i = 0; i < 65536; i = i + 1)
            index[i] = 16'b0;

      if (write)
         index[address] = writeData;

      if (read)
         r = index[address];
      else
         r = 16'b0;
   end
   
   assign data = r;
endmodule

module StackPointerRegister (
   input add, sub, write, reset,
   input [15:0] writeData,
   output [15:0] data);

   reg [15:0] stackPointer;

   always @ (add or sub or write or reset) begin
      if (reset)
         stackPointer = 16'b0;

      if (write)
         stackPointer = writeData;

      if (add)
         stackPointer = stackPointer + 1;
      else if (sub)
         stackPointer = stackPointer - 1;
   end

   assign data = stackPointer;
endmodule

module BasePointerRegister (
   input read, write, reset,
   input [15:0] writeData,
   output [15:0] data);

   reg [15:0] basePointer;
   reg [15:0] r;

   always @ (read or write or reset) begin
      if (reset)
         basePointer = 16'b0;

      if (write)
         basePointer = writeData;

      if (read)
         r = basePointer;
      else
         r = 16'b0;
   end

   assign data = r;
endmodule

module SpecialPurposeRegister (
   input         read, write, reset,
   input [3:0]   address,
   input [15:0]  writeData,
   output [15:0] data);
   
   reg [15:0]    register [0:7];
   integer       i;
   reg [15:0]    out;
   
   initial begin
      for (i = 0; i < 8 ; i = i + 1)
        register[i] = 8'b0;
   end
   
   always @ (read or write or reset) begin
      if (reset)
        for (i = 0; i < 8 ; i = i + 1)
          register[i] = 8'b0;
      
      if (write && address > 0)
        register[address] = writeData;
      
      if (read)
        out = register[address];
      else
        out = 16'b0;
   end
   
   assign data = out;
endmodule
