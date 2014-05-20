#include "ALU.h"
#include <sstream>
#include "Global.h"
#include <iostream>

const int ALU::shiftRightLogical(const int b) {
  std::string str = "";
  int size = dataA.size();
  for(int i = 0; i < size; i++) {
    if (i < b) {
      str = str + '0';
    } else {
      str = str + dataA[i - b];
    }
  }

  str = notSignExtension(str);
  return bitStringToUInt(str);
}
void ALU::setResult(const std::string & str) {
  std::string r = "";
  int size = str.size();
  if (size < 16) {
    r = str;
    int s = bitStringToUInt(selectALU);
    for (int i = 0; i < 16 - size; i++) {
      r = (s == 10 ? '0' : str[0]) + r;
    }
  } else {
    r = str.substr(size - 16, 16);
  }

  result = r;
}
void ALU::setFlags(const int a, const int b, const int s, const std::string & calcResult, const int r, const long l) {
  if (s >= 0 && s <= 1 && r != l) {
    carry = '1';
  } else if (s >= 8 && s <= 11) {
      std::string nse = notSignExtension(dataA, 17);
    if (s == 8 || s == 9) {
      carry = nse[nse.size() - 17 + b];
    } else {
      if (b == 0) {
	carry = '0';
      } else {
	carry = nse[nse.size() - b];
      }
    }
  } else {
    carry = '0';
  }
  zero = (r == 0) ? '1' : '0';
  sign = (r < 0) ? '1' : '0';
  if (s == 0 && (a / std::abs(a)) * (b / std::abs(b)) >= 0 && (a / std::abs(a)) * (r / std::abs(r)) < 0) {
    overflow = '1';
  } else if (s == 1 && (a / std::abs(a)) * (b / std::abs(b)) < 0 && (a / std::abs(a)) * (r / std::abs(r)) < 0) {
    overflow = '1';
  } else {
    overflow = '0';
  }
}
void ALU::setDataA(const std::string & a){
  dataA = a;
}
void ALU::setDataB(const std::string & b){
  dataB = b;
}
void ALU::setSelectALU(const std::string & salu){
  selectALU = salu;
}
const std::string & ALU::getResult(){
  return result;
}
const std::string ALU::getFlags(){
  char flags[5] = "";
  flags[0] = sign;
  flags[1] = zero;
  flags[2] = carry;
  flags[3] = overflow;
  flags[4] = '\0';
  std::string f = flags;
  return f;
}
void ALU::Calc(){
  int a = bitStringToInt(dataA), 
      b = bitStringToInt(dataB),
      s = bitStringToUInt(selectALU);

  unsigned int ua = static_cast<unsigned int>(a);
  long la = static_cast<long>(ua),
    lb = static_cast<long>(b);

  int r;
  long l = 0;
  switch(s) {
  case 0: r = a + b; l = la + lb; break;
  case 1: r = a - b; l = la - lb; break;
  case 2: r = a & b; break;
  case 3: r = a | b; break;
  case 4: r = a ^ b; break;
  case 8: r = (a << b); break;
  case 9: r = (a << b) | shiftRightLogical(16 - b); break;
  case 10: r = shiftRightLogical(b); break;
  case 11: r = a >> b; break;
  case 12: r = b; break;
  case 15: r = 0; break;
  default: r = 0; break;
  }
  
  std::string calcresult = intToBitString(r);
  setResult(calcresult);
  setFlags(a, b, s, calcresult, r, l);
}
