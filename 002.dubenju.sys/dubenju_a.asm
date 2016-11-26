               org 0700H
               cpu 8086
[BITS 16]
              section .data align=16
               MOV  AL, 13H
               MOV AH, 00H
               INT 10H
FIN:
               HLT
               JMP FIN
