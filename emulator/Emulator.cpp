#include "Register.h"
#include "Memory.h"
#include "Global.h"
#include "ALU.h"
#include "JumpJudgement.h"
#include "Decode.h"
#include "ProgramCounter.h"
#include "StackPointerRegister.h"
#include "Enum.h"

int main(void) {
  GeneralPurposeRegister regi;
  Memory mem;
  DataMemory dmem;
  ALU alu;
  JumpJudgement jj;
  Decode decode;
  ProgramCounter programCounter;
  StackPointerRegister spr;
  while(true) {
    int pc = programCounter.getCounter();
    auto m = mem.getMemory(pc);
    if (m.substr(0, 2).compare("11") == 0 && m.substr(8, 4).compare("1111") == 0) {
      std::cout << "HLT!" << std::endl;
      break;
    }

    decode.setOperand(m);
    int address1 = bitStringToUInt(decode.getAddress1()), 
      address2 = bitStringToUInt(decode.getAddress2());

    auto immidiate = decode.getImmidiate();
    auto data1 = regi.getRegister(address1);
    auto data2 = regi.getRegister(address2);
    auto stack = spr.getStack();
    auto count = intToBitString(pc);
    auto selectALU = decode.getSelectALU();

    std::cout << data1 << std::endl;
    std::cout << data2 << std::endl;

    //alu.setDataA("1111111111111111");
    //alu.setDataB("0000000000000001");
    //alu.setSelectALU("0000");
    
    //alu.Calc();
    //std::string r = alu.getResult();
    //std::string f = alu.getFlags();
    //std::cout << r << std::endl;
    //std::cout << f << std::endl;
    programCounter.update();
  }

  //dmem.show();

  return 0;
}
