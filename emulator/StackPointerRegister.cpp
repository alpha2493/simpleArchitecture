#include "StackPointerRegister.h"

const std::string & StackPointerRegister::getStack() {
  return stack;
}

void StackPointerRegister::setStack(const std::string& s) {
  stack = s;
}

void StackPointerRegister::increment() {
  for(int i = stack.size() - 1; i >= 0; i++) {
    if (stack[i] == '0') { stack[i] = '1'; break; }
    else { stack[i] = '0'; }
  }
}

void StackPointerRegister::decrement() {
  for(int i = stack.size() - 1; i >= 0; i++) {
    if (stack[i] == '1') { stack[i] = '0'; break; }
    else { stack[i] = '1'; }
  }
}
