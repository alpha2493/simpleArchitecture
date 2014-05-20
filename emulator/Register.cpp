#include "Register.h"

void GeneralPurposeRegister::reset() {
  for(auto &r : generalPurposeRegisters) {
    r = "0000000000000000";
  }
}

void GeneralPurposeRegister::write(const int address, const std::string & operand) {
  generalPurposeRegisters[address] = operand;
}

const std::string & GeneralPurposeRegister::getRegister(const int address) {
  return generalPurposeRegisters[address];
}

