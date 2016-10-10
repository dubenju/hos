00000000  7F01              jg 0x3
00000002  0041BB            add [bx+di-0x45],al
00000005  0007              add [bx],al
00000007  60                pushaw
00000008  666A00            o32 push byte +0x0
0000000B  E93BFF            jmp word 0xff49
0000000E  0000              add [bx+si],al
