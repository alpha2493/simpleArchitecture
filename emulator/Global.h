#pragma once
#include <array>
#include <string>

extern const std::string IADD;
extern const std::string ISUB;
extern const std::string IAND;
extern const std::string IOR;
extern const std::string IXOR;
extern const std::string ISLL;
extern const std::string ISLR;
extern const std::string ISRL;
extern const std::string ISRA;
extern const std::string IIDT;
extern const std::string INON;

template<class T, size_t size>
const bool ArrayEqual(const std::array<T, size> & a, const std::array<T, size> & b);
const std::string deleteSpace(const std::string & str);
const std::string deleteComment(const std::string & str);
const unsigned int bitStringToUInt(const std::string & str);
const int bitStringToInt(const std::string & str);
const std::string intToBitString(const int n);
const std::string uintToBitString(const unsigned int n);
const std::string signExtension(const std::string & str);
const std::string signExtension(const std::string & str, const int n);
const std::string notSignExtension(const std::string & str);
const std::string notSignExtension(const std::string & str, const int n);
