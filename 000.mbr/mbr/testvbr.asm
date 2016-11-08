               org 0600H
               cpu 8086
[BITS 16]
              section .data align=16
               JMP LBL_START
TIMES 59 DB 0
LBL_START:
               CLI
               XOR AX,AX
               MOV SS,AX
               MOV SP,0X7C00
               STI
               PUSH AX
               POP  ES
               PUSH AX
               POP DS
               CLD
;
               MOV SI, 0X7C00
               MOV CX, 512
LBL_DSP:
               LODSB 
               MOV AH,0X0E
               MOV BX,0X0007
;               MOV CX,0
;               MOV DX, 0
;               MOV BP,0X7C00
               INT 10H
               DEC CX
               JNZ  SHORT LBL_DSP
LBL_HANGU:
           jmp LBL_HANGU

TIMES 512 - 96 DB 0

DB 0X55
DB 0XAA
