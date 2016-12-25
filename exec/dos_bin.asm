00000000  0E                push cs
00000001  1F                pop ds
00000002  BA0E00            mov dx,0xe
00000005  B409              mov ah,0x9
00000007  CD21              int 0x21
00000009  B8014C            mov ax,0x4c01
0000000C  CD21              int 0x21
0000000E  skipping 0x26 bytes
00000034  2E0D0D0A          cs or ax,0xa0d
00000038  2400              and al,0x0
0000003A  0000              add [bx+si],al
0000003C  0000              add [bx+si],al
0000003E  0000              add [bx+si],al
