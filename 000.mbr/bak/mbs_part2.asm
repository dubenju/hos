00000000  56                push si
00000001  33F6              xor si,si
00000003  56                push si
00000004  56                push si
00000005  52                push dx
00000006  50                push ax
00000007  06                push es
00000008  53                push bx
00000009  51                push cx
0000000A  BE1000            mov si,0x10
0000000D  56                push si
0000000E  8BF4              mov si,sp
00000010  50                push ax
00000011  52                push dx
00000012  B80042            mov ax,0x4200
00000015  8A5624            mov dl,[bp+0x24]
00000018  CD13              int 0x13
0000001A  5A                pop dx
0000001B  58                pop ax
0000001C  8D6410            lea sp,[si+0x10]
0000001F  720A              jc 0x2b
00000021  40                inc ax
00000022  7501              jnz 0x25
00000024  42                inc dx
00000025  80C702            add bh,0x2
00000028  E2F7              loop 0x21
0000002A  F8                clc
0000002B  5E                pop si
0000002C  C3                ret
0000002D  EB74              jmp short 0xa3
