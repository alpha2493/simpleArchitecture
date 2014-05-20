#include "Global.h"
#include <cmath>
#include <algorithm>
#include <iostream>

const std::string IADD = "0000";
const std::string ISUB = "0001";
const std::string IAND = "0010";
const std::string IOR  = "0011";
const std::string IXOR = "0100";
const std::string ISLL = "1000";
const std::string ISLR = "1001";
const std::string ISRL = "1010";
const std::string ISRA = "1011";
const std::string IIDT = "1100";
const std::string INON = "1111";

template<class T, size_t size>
const bool ArrayEqual(const std::array<T, size> & a, const std::array<T, size> & b) {
  for (int i = 0; i < a.size(); i++) {
    if (a[i] != b[i]) return false;
  }
  
  return true;
}

const std::string deleteSpace(const std::string & str) {
  std::string newstr = "";

  int size = str.size();
  for(int i = 0; i < size; i++) {
    if (str[i] == ' ' || str[i] == '\t') { continue; }
    else { newstr = newstr + str[i]; }
  }

  return newstr;
}

const std::string deleteComment(const std::string & str) {
  std::string newstr = "";

  bool slash = false;
  int size = str.size();
  for(int i = 0; i < size; i++) {
    if (str[i] == '/') {
      if (slash) { break; }
      else { slash = true; }
    } else {
      if (slash) { newstr = newstr +  '/'; }
      slash = false;
      newstr = newstr + str[i];
    }
  }

  return newstr;
}

const int bitStringToInt(const std::string & str) {
  int a = 0, size = str.size();
  for (int i = 1; i < size ; i++) {
    a = a * 2 + str[i] - '0';
  }
  a -= (str[0] - '0') * std::pow(2, size - 1);
  
  return a;
}

const unsigned int bitStringToUInt(const std::string & str) {
  unsigned int a = 0;
  int size = str.size();
  for (int i = 0; i < size ; i++) {
    a = a * 2 + str[i] - '0';
  }
  
  return a;
}

const std::string intToBitString(const int n) {
  std::string str = "";
  if (n == 0) {
    str = "00000000000000000";
  } else {
    bool minus = (n < 0);
    int number = std::abs(n);
    while(number > 0) {
      str = (number % 2 == 0 ? '0' : '1') + str;
      number /= 2;
    }
    if (minus) {
      int size = str.size();
      for (int i = 0; i < size ; i++) {
	if (str[i] == '1') str[i] = '0';
	else { str[i] = '1'; }
      }
      for (int i = size - 1; i >= 0 ; i--) {
	if (str[i] == '1') str[i] = '0';
	else { str[i] = '1'; break; }
      }
      str = '1' + str;
    } 
    if (minus) {
      str = signExtension(str, 17);
    } else {
      str = notSignExtension(str, 17);
    }
  }

  return str;
}

const std::string uintToBitString(const unsigned int n) {
  std::string str = "";
  if (n == 0) {
    str = "0";
  } else {
    int number = n;
    while(number != 0) {
      str = (number % 2 == 0 ? '0' : '1') + str;
      number /= 2;
    }
  }

  str = notSignExtension(str, 17);

  return str;
}

const std::string signExtension(const std::string & str) {
  return signExtension(str, 16);
}

const std::string signExtension(const std::string & str, const int n) {
  std::string se = str;
  int size = str.size();
  for(int i = size; i < n; i++) {
    se = str[0] + se;
  }

  return se;
}

const std::string notSignExtension(const std::string & str) {
  return notSignExtension(str, 16);
}

const std::string notSignExtension(const std::string & str, const int n) {
  std::string nse = str;
  int size = str.size();
  for(int i = size; i < n; i++) {
    nse = '0' + nse;
  }

  return nse;
}
