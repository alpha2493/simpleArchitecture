module DecodeUnit(
   input [15:0] COMMAND,
   output 	AR_MUX, BR_MUX,
   output [3:0] S_ALU,
   output 	INPUT_MUX, writeEnable,
   output [2:0] writeAddress,
   output 	ADR_MUX, write, PC_load, 
   output [2:0] cond, op2,
   output 	SP_write, inc, dec, SP_Sw, MAD_MUX, SPC_MUX, MW_MUX, AB_MUX, signEx
);

   reg [3:0] 	Select_ALU;
   reg [2:0] 	condition;
   reg [2:0] 	opera2;
   localparam 	IADD = 4'b0000;
   localparam 	ISUB = 4'b0001;
   localparam 	IAND = 4'b0010;
   localparam 	IOR = 4'b0011;
   localparam 	IXOR = 4'b0100;
   localparam 	ISLL = 4'b1000;
   localparam 	ISLR = 4'b1001;
   localparam 	ISRL = 4'b1010;
   localparam 	ISRA = 4'b1011;
   localparam 	IIDT = 4'b1100;
   localparam 	INON = 4'b1111;

   reg [2:0] 	wrAdr; 	
   reg 		wr, pcl, in, adr, ar, br, se, wren, spc, ab, mw, sps, mad, i, d, spw;


   //SPC_MUX
   always @ (COMMAND) begin
      if (COMMAND[15:11] == 5'b10011)
	spc <= 1'b1;
      else
	spc <= 1'b0;
   end

   //AB_MUX
   always @ (COMMAND) begin
      if (COMMAND[15:14] == 2'b01)
	ab <= 1;
      else
	ab <= 0;
   end

   //MW_MUX
   always @ (COMMAND) begin
      if (COMMAND[15:8] == 8'b10111110)
	mw <= 0;
      else
	mw <= 1;
   end

   //SP_Sw
   always @ (COMMAND) begin
      if (COMMAND[15:8] == 8'b10111111)
	sps <= 0;
      else
	sps <= 1;
   end

   //MAD_MUX
   always @ (COMMAND) begin
      if (COMMAND[15:11] == 5'b10010 || COMMAND[15:9] == 7'b1011111)
	mad <= 0;
      else
	mad <=1;
   end

   //inc
   always @ (COMMAND) begin
      if (COMMAND[15:11] == 5'b10010)
	i <= 1;
      else
	i <= 0;
   end

   //dec
   always @ (COMMAND) begin
      if (COMMAND[15:8] == 8'b10111111)
	d <= 1;
      else
	d <= 0;
   end

   //spw
   always @ (COMMAND) begin
      if (COMMAND[15:11] == 5'b10011)
	spw <= 1;
      else
	spw <= 0;
   end
   
   //wrAdr
   always @ (COMMAND) begin
     if (COMMAND[15:14] == 2'b00)
       wrAdr <= COMMAND[13:11];
     else
       wrAdr <= COMMAND[10:8];
   end
   
   //cond
   always @ (COMMAND) begin
      condition <= COMMAND[10:8];
   end

   //op2
   always @ (COMMAND) begin
      opera2 <= COMMAND[13:11];
   end
   
   //wren
   always @ (COMMAND) begin
      if (COMMAND[15:14] == 2'b01 || COMMAND[15:11] == 5'b10010 || COMMAND[15:11] == 5'b10010 ||
	  COMMAND[15:11] == 5'b10110 || COMMAND[15:8] = 8'b10111110)
	wren <= 1;
      else
	wren <= 0;
   end
     
   //signEx
   always @ (COMMAND) begin
      if (COMMAND[15:14] != 2'b11)
	se <= 1;
      else
	se <= 0;
   end   

   //write
   always @ (COMMAND) begin
      if ((COMMAND[15:14] == 2'b11 && (COMMAND[7:4] <= 4'b1100 && COMMAND[7:4] != 4'b0101)) ||
	  COMMAND[15:14] == 2'b00 ||
	  COMMAND[15:12] == 4'b1000 ||
	  COMMAND[15:11] == 5'b10101)
	wr <= 1;
      else
	wr <=0;
   end

   //PC_load
   always @ (COMMAND) begin
      if (COMMAND[15:11] == 5'b10100 || COMMAND[15:11] == 5'b10111)
	pcl <= 1;
      else
	pcl <= 0;
   end

   //INPUT_MUX
   always @ (COMMAND) begin
      if (COMMAND[15:14] == 2'b11 && COMMAND[7:4] == 4'b1100)
	in <= 1;
      else
	in <= 0;
   end

   //ADR_MUX
   always @ (COMMAND) begin
      if ((COMMAND[15:14] == 2'b11 && COMMAND[7:4] <= 4'b1011) ||COMMAND[15:14] == 2'b10)
	adr <= 1;
      else
	adr <= 0;
   end

   //BR_MUX
   always @ (COMMAND) begin
      if (COMMAND[15:14] != 2'b10 || COMMAND[13] != 1'b1)
	br <= 1;
      else
	br <= 0;
   end

   //AR_MUX
   always @ (COMMAND) begin
      if (COMMAND[15:14] == 2'b11 && COMMAND[7:4] <= 4'b0110)
	ar <= 1;
      else
	ar <= 0;
   end
   
   //各種演算命令
   always @ (COMMAND) begin
      if (COMMAND[15:14] == 2'b11)//演算命令
	case (COMMAND[7:4])
	  4'b0101 : Select_ALU <= ISUB;//CMP
	  4'b0110 : Select_ALU <= IIDT;//MOV
	  default : Select_ALU <= COMMAND[7:4];
	endcase // case (COMMAND[7:4])
      else if (COMMAND[15] == 1'b0)//LD, ST
	Select_ALU <= IADD;
      else if (COMMAND[15:11] == 5'b10000)//LI
	Select_ALU <= IIDT;
      else if (COMMAND[15:11] == 5'b10001)//ADDI
	Select_ALU <= IADD;
      else if (COMMAND[15:11] == 5'b10100)//分岐
	Select_ALU <= IADD;
      else if (COMMAND[15:11] == 5'b10111)//条件分岐
	Select_ALU <= IADD;
      else//その他
	Select_ALU <= INON;
   end

   assign op2 = opera2;
   assign writeAddress = wrAdr;
   assign S_ALU = Select_ALU;
   assign cond = condition;
   assign AR_MUX = ar;
   assign BR_MUX = br;
   assign write = wr;
   assign PC_load = pcl;
   assign INPUT_MUX = in;
   assign ADR_MUX = adr;
   assign signEx = se;
   assign writeEnable = wren;   
   assign SPC_MUX = spc;
   assign AB_MUX = ab;
   assign MW_MUX = mw;
   assign SP_Sw = sps;
   assign MAD_MUX = mad;
   assign inc = i;
   assign dec = d;
   assign SP_write = spw;
      
endmodule // DecodeUnit
