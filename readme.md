# Instruction Set "4"

Originally began in September

Registers: A, B, SP, PC, FLAGS

```
MVA   : A := B
MVB   : B := A
LDA   : A := [A]
LDB   : B := [B]
LWA   : A := [A+1]:[A]
LWB   : B := [B+1]:[B]
LIA i : A := imm
LIB i : B := imm
LSA o : A := SP + offset
LSB o : B := SP + offset
LDS   : SP := A
STO   : [B] := A & 0xFF
STW   : [B+1]:[B] := A
ADD   : A := A + B + CF
SUB   : A := A - B - CF
OR    : A := A | B
AND   : A := A & B
XOR   : A := A ^ B
INC   : A := A + 1
DEC   : A := A - 1
NOT   : A := ~A
LSH   : A := A << 1
RSH   : A := A >> 1
CMP   : test A - B
JP a  : PC := addr
JPcc a: if (cc) PC := addr
JI    : PC := B
JIcc  : if (cc) PC := B
PSH   : SP := SP - 2 ; [SP] := A
POP   : A := [SP]    ; SP := SP + 2
RET   : PC := [SP]    ; SP := SP + 2
CALL a: SP := SP - 2 ; [SP] := PC; PC := addr
CALLI : SP := SP - 2 ; [SP] := PC; PC := B
CLf   : FLAGS[f] = 0
STf   : FLAGS[f] = 1
```