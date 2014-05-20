#pragma once
#include <string>

class JumpJudgement {
 private:
  std::string flags;
 public:
 JumpJudgement() : flags("") { }
  void setFlags(const std::string & str);
  bool Jump(const std::string & op2, const std::string & cond);
};
