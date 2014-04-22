#Makefile
all:ALU_test.out MUX_test.out SignExtension_test.out ControlUnit_test.out DecodeUnit_test.out

vcd: aluTest.vcd muxTest.vcd singextensionTest.vcd controlUnitTest.vcd decodeUnitTest,vcd

aluTest.vcd: ALU_test.out
	vvp ALU_test.out
muxTest.vcd: MUX_test.out
	vvp MUX_test.out
signextensionTest.vcd: SignExtension_test.out
	vvp SignExtension_test.out
controlUnitTest.vcd: ControlUnit_test.out
	vvp ControlUnit_test.out
decodeUnitTest.vcd: DecodeUnit_test.out
	vvp DecodeUnit_test.out



ALU_test.out: src/ALU.v test/ALUTest.v
	iverilog -o ALU_test.out -s ALUTEST src/ALU.v test/ALUTest.v
MUX_test.out: src/MUX.v test/MUXTest.v
	iverilog -o MUX_test.out -s MUXTEST src/MUX.v test/MUXTest.v
SignExtension_test.out: src/SignExtension.v test/SignExtensionTest.v
	iverilog -o SignExtension_test.out -s SIGNEXTENSIONTEST src/SignExtension.v test/SignExtensionTest.v
ControlUnit_test.out: src/ControlUnit.v test/ControlUnitTest.v
	iverilog -o ControlUnit_test.out -s CONTROLUNITTEST src/ControlUnit.v test/ControlUnitTest.v
DecodeUnit_test.out: src/DecodeUnit.v test/DecodeUnitTest.v
	iverilog -o DecodeUnit_test.out -s DECODEUNITTEST src/DecodeUnit.v test/DecodeUnitTest.v

clean:
	rm -f *.out *.vcd
