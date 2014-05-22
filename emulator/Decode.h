#pragma once
#include <array>
enum class OperandType;

class Decode {
 private:
  std::string operand;
  OperandType oType;
  std::string selectALU;
  std::string address1;
  std::string address2;
  std::string immidiate;
  std::string op2;
  std::string cond;
  //void setSelectALU();
  //void setAddresses();
  void decode();
  void typeCalculate();
  void typeLoad();
  void typeStore();
  void typeOther();
 public:
 Decode() : operand("0"), selectALU("0"), address1("0"), address2("0")
    , immidiate("0"), op2("0"), cond("0")  { }
  void setOperand(const std::string & op);
  const OperandType & getOperandType();
  const std::string & getSelectALU();
  const std::string & getAddress1();
  const std::string & getAddress2();
  const std::string & getImmidiate();
  const std::string & getOp2();
  const std::string & getCond();
};
