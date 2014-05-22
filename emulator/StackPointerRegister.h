#pragma once
#include <string>

class StackPointerRegister {
 private:
  std::string stack;
 public:
 StackPointerRegister() : stack("0") { }
  const std::string & getStack();
  void setStack(const std::string & s);
  void increment();
  void decrement();
};
