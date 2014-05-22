#include "ProgramCounter.h"

void ProgramCounter::update() {
  counter += 1;
}
void ProgramCounter::reset() {
  counter = 0;
}
const int ProgramCounter::getCounter() {
  return counter;
}
void ProgramCounter::Jump(const int count) {
  counter = count + 1;
}
