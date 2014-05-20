#include "Memory.h"
#include "Global.h"

void Memory::initialize(const std::string & str) {
  std::ifstream ifs(str);
  std::string s;
  if (ifs.fail()) {
    std::cerr << str + " does not exist." << std::endl;
    exit(0);
  }
  int i = 0;
  while(std::getline(ifs, s)) {
    s = deleteSpace(s);
    s = deleteComment(s);
    if (s.size() == 0) { continue; }
    memory[i] = s;
    i++;
  }
  int size = memory.size();
  for (; i < size; i++) {
    memory[i] = "0000000000000000";
  }
}
void Memory::setMemory(const int address, const std::string & operand) {
  memory[address] = operand;
}
void Memory::reset() {
  for(auto &m : memory) {
    m = "0000000000000000";
  }
}
const std::string & Memory::getMemory(const int address) {
  return memory[address];
}
void DataMemory::show() {
  int size = memory.size();
  for(int i = 0; i < size; i++) {
    std::cout << i <<":" + memory[i] << std::endl;
  }
}
void DataMemory::setData(const int address, const std::string & operand) {
  setMemory(address, operand);
}
