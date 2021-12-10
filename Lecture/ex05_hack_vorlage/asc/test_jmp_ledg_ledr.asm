(START)
@29696      //A=0x7400 (IREG0)
D=M         //Load IREG0 to D
@GREEN
D;JGT       //Jumpt to (GREEN) if D > 0
// --- else turn on the red LED ---
@RED
0;JMP
// --- if SW > 0 turn on the green LED
(GREEN)
@1
D=A
@28672
M=D
@START
0;JMP
(RED)
@256
D=A
@28672
M=D
@START
0;JMP