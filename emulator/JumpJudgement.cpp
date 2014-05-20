#include "JumpJudgement.h"
#include "Global.h"

void JumpJudgement::setFlags(const std::string & str) {
  flags = str;
}
bool JumpJudgement::Jump(const std::string & op2, const std::string & cond) {
  int o = bitStringToUInt(op2), c = bitStringToUInt(cond);
  if (o == 4) {
    return true;
  } else if (o == 7) {
    if ((c == 0 && flags[1] == '1') 
        || (c == 1 && ((flags[0] == '1') ^ (flags[3] == '1')))
	|| (c == 2 && ((flags[1] == '1') || ((flags[0] == '1') ^ (flags[3] == '1'))))
	|| (c == 3 && flags[1] == '0')) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
}
