/*
 * 専用レジスタ
 * ゼロレジスタ
 * アドレスレジスタ
 * ベースレジスタ
 * インデックスレジスタ
 * スタックポインタ
 * ベースポインタ
 * データレジスタ
 * 入力レジスタ
 * 出力レジスタ
 */
module ZeroRegister (
   input         clock, write, reset,
   input [3:0]   address,
   input [15:0]  writeData,
   output [15:0] data);

   reg [15:0]    out = 16'b0;

   always @ (posedge clock) begin
      out = 16'b0;
   end

   assign data = out;
endmodule

module AddressRegister (
   input        clock, write, reset,
   input [3:0]  address,
   input [15:0] writeData,
   output [15:0] data);

   reg [15:0]    out = 16'b0;

   always @ (posedge clock) begin
      if (reset)
        out = 16'b0;
      else if (write)
        out = writeData;
   end

   assign data = out;
endmodule

module BaseRegister(
   input         clock, write, reset,
   input [15:0]  address,
   input [15:0]  writeData,
   output [15:0] data);

   reg [15:0]    base [0:65535];
   integer       i;

   initial begin
      for (i = 0; i < 65536; i = i + 1)
        base[i] = 16'b0;
   end
   
   always @ (posedge clock) begin
      if (reset)
        for (i = 0; i < 65536; i = i + 1)
          base[i] = 16'b0;
      else if (write)
        base[address] = writeData;
   end
   
   assign data = base[address];
endmodule

module IndexRegister(
   input         clock, write, reset,
   input [15:0]  address,
   input [15:0]  writeData,
   output [15:0] data);

   reg [15:0]    index [0:65535];
   integer       i;
   
   initial begin
      for (i = 0; i < 65536; i = i + 1)
        index[i] = 16'b0;
   end
   
   always @ (posedge clock) begin
      if (reset)
        for (i = 0; i < 65536; i = i + 1)
          index[i] = 16'b0;
      else if (write)
        index[address] = writeData;
   end

   assign data = index[address];
endmodule

module StackPointerRegister (
   input         clock, reset,
   input [1:0]   op,
   input [15:0]  writeData,
   output [15:0] data);

   reg [15:0]    stackPointer;

   always @ (posedge clock) begin
      if (reset)
        stackPointer = 16'b0;
      else
         case (op)
           2'b00 : stackPointer = stackPointer + 1;
           2'b01 : stackPointer = stackPointer - 1;
           2'b10 : stackPointer = writeData;
           2'b11 : stackPointer = stackPointer;
           default : stackPointer = stackPointer;
         endcase
   end

   assign data = stackPointer;
endmodule

module BasePointerRegister (
   input         clock, write, reset,
   input [15:0]  writeData,
   output [15:0] data);

   reg [15:0]    basePointer;

   always @ (posedge clock) begin
      if (reset)
        basePointer = 16'b0;
      else if (write)
        basePointer = writeData;
   end

   assign data = basePointer;
endmodule

module InputRegister (
   input         clock, write, reset,
   input [15:0]  writeData,
   output [15:0] data);

   reg [15:0]    out = 16'b0;

   always @ (posedge clock) begin 
      if (reset)
         out = 16'b0;
      else if (write)
         out = writeData;
   end

   assign data = out;
endmodule

module OutputRegister (
   input         clock, write, reset,
   input [15:0]  writeData,
   output [15:0] data);

   reg [15:0]    out = 16'b0;

   always @ (posedge clock) begin 
      if (reset)
         out = 16'b0;
      else if (write)
         out = writeData;
   end

   assign data = out;
endmodule
