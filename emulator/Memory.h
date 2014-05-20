#pragma once
#include <array>
#include <string>
#include <fstream>
#include <iostream>

class Memory {
 private:
  void initialize(const std::string &);
 protected:
  std::array<std::string, 2048> memory;
  void setMemory(const int address, const std::string & operand);
 public:
 Memory() : memory() { initialize("program.txt"); }
 Memory(const char str[]) : memory() { initialize(str); }
 Memory(const std::string & str) : memory() { initialize(str); }
  void reset();
  const std::string & getMemory(const int address);
};

class DataMemory : public Memory {
 public:
 DataMemory() : Memory("data.txt") { }
 DataMemory(const std::string & str) : Memory(str) { }
  void setData(const int address, const std::string & operand);
  void show();
};
