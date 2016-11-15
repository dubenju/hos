00000000  41                inc cx
00000001  BB0007            mov bx,0x700
00000004  60                pushaw
00000005  666A00            o32 push byte +0x0
00000008  E93BFF            jmp word 0xff46
0000000B  0000              add [bx+si],al
