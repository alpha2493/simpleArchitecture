#pragma once

class ProgramCounter {
 private:
  int counter;
  const int MAX;
 public:
 ProgramCounter() : counter(0), MAX(2048) { }
  void update();
  void reset();
  const int getCounter();
  void Jump(const int count);
};
