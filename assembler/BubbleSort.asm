LI [5] 1
SLR [5] 10    // BEGIN = 400
LI [6] 1
SLR [6] 11
ADDI [6] -1   // END = 7FF

LI [0] 0      // for (i = 0; n-1回ループ) {
MOV [1] [5]   //   for (j = begin; n-1回ループ) {
MOV [2] [1]   //
ADDI [2] 1    //
LD [3] 0([1]) //     a = mem[j]
LD [4] 0([2]) //     b = mem[j+1]
CMP [3] [4]   //     if (!(a < b)) {
BLT 2         //
ST [4] 0([1]) //       mem[j+1] = a
ST [3] 0([2]) //       mem[j] = b
ADDI [1] 1    //     j++
CMP [1] [6]   //
BLT -11       //   }
ADDI [0] 1    //   i++
CMP [0] [5]   //
BLT -15       // }
HLT
