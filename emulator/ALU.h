#pragma once
#include <string>

class ALU {
 private:
  std::string dataA;
  std::string dataB;
  std::string result;
  char sign;
  char zero;
  char carry;
  char overflow;
  std::string selectALU;
  const int shiftRightLogical(const int b);
  void setResult(const std::string & str);
  void setFlags(const int a, const int b, const int s, const std::string & calcResult, const int r, const long l);
 public:
 ALU() : dataA("0"), dataB("0"), result("0"), sign('0'), zero('0'), carry('0'), overflow('0'), selectALU("0") { }
  void Calc();
  void setDataA(const std::string & a);
  void setDataB(const std::string & b);
  void setSelectALU(const std::string & salu);
  const std::string & getResult();
  const std::string getFlags();
};
