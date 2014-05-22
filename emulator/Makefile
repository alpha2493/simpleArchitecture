CXX = g++-mp-4.8
OBJS = ALU.o ProgramCounter.o Register.o Memory.o Decode.o Global.o JumpJudgement.o StackPointerRegister.o Enum.h Emulator.cpp

simple.out: $(OBJS)
	    $(CXX) -std=c++11 -Wall -O3 -o $@ $(OBJS)
	    rm -f *.o

.cpp.o:
	$(CXX) -c -Wall -O3 -std=c++11 $<

ALU.o: ALU.h
ProgramCounter.o: ProgramCounter.h
Register.o: Register.h
Memory.o: Memory.h
Decode.o: Decode.h
Global.o: Global.h
JumpJudgement.o: JumpJudgement.h
StackPointerRegister.o: StackPointerRegister.h

clean:
	rm -f *.o simple
