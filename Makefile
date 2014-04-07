#Makefile
all:ALU_test.out Memory_test.out

vcd: aluTest.vcd Memory.vcd

aluTest.vcd: ALU_test.out
	vvp ALU_test.out
Memory.vcd: Memory_test.out
	vvp Memory_test.out

ALU_test.out: src/ALU.v test/ALUTest.v
	iverilog -o ALU_test.out -s ALUTEST src/ALU.v test/ALUTest.v
Memory_test.out: src/Memory.v test/MemoryTest.v
	iverilog -o Memory_test.out -s MEMORYTEST src/Memory.v test/MemoryTest.v



clean:
	rm -f *.out *.vcd
