#pragma once
#include <array>
#include <string>

class GeneralPurposeRegister {
 private:
  std::array<std::string, 8> generalPurposeRegisters;
 public:
 GeneralPurposeRegister() : generalPurposeRegisters() { reset(); }
  void reset();
  void write(const int address, const std::string & operand);
  const std::string & getRegister(const int address);
};
