#include "Decode.h"
#include "Global.h"
#include "Enum.h"
#include <iostream>

void Decode::setOperand(const std::string & op) {
  operand = op;
  decode();
}
void Decode::decode() {
  std::string top = operand.substr(0, 2);
  if (top.compare("11") == 0) {
    typeCalculate();
  } else if (top.compare("00") == 0) {
    typeLoad();
  } else if (top.compare("01") == 0) {
    typeStore();
  } else {
    typeOther();
  }
  if (top.compare("11") == 0) {
    immidiate = operand.substr(12, 4);
    immidiate = notSignExtension(immidiate);
  } else {
    immidiate = operand.substr(8, 8);
    immidiate = signExtension(immidiate);
  }
  op2 = address1 = operand.substr(2, 3);
  cond = address2 = operand.substr(5, 3);
}
void Decode::typeCalculate() {
  oType = OperandType::Calculate;
  std::string salu = "";
  std::string op3 = operand.substr(8, 4);
  std::string cmp = "0101";
  std::string mov = "0110";
  std::string remove1 = "0111";
  std::string remove2 = "1110";
  if (op3.compare(cmp) == 0) {
    salu = ISUB;
  } else if (op3.compare(mov) == 0) {
    salu = IIDT;
  } else if (op3.compare(remove1) != 0 || op3.compare(remove2) != 0){
    salu = op3;
  } else {
    salu = INON;
  }
  selectALU = salu;
}
void Decode::typeLoad() {
  oType = OperandType::Load;
  selectALU = IADD;
}
void Decode::typeStore() {
  oType = OperandType::Store;
  selectALU = IADD;
}
void Decode::typeOther() {
  oType = OperandType::Other;
  std::string salu = "";
  std::string op3 = operand.substr(0, 5);
  std::string li = "10000";
  std::string addi = "10001";
  std::string b = "10100";
  std::string branch = "10111";
  if (op3.compare(li) == 0) {
    salu = IIDT;
  } else if (op3.compare(addi) == 0) {
    salu = IADD;
  } else if (op3.compare(b) == 0) {
    salu = IADD;
  } else if (op3.compare(branch) == 0) {
    salu = IADD;
  } else {
    salu = INON;
  }
  selectALU = salu;
}
const OperandType & Decode::getOperandType() {
  return oType;
}
const std::string & Decode::getSelectALU() {
  return selectALU;
}
const std::string & Decode::getAddress1() {
  return address1;
}
const std::string & Decode::getAddress2() {
  return address2;
}
const std::string & Decode::getImmidiate() {
  return immidiate;
}
const std::string & Decode::getOp2() {
  return op2;
}
const std::string & Decode::getCond() {
  return cond;
}
