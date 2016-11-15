00000000  33C0              xor ax,ax
00000002  8ED0              mov ss,ax
00000004  BC007C            mov sp,0x7c00
00000007  FB                sti
00000008  50                push ax
00000009  07                pop es
0000000A  50                push ax
0000000B  1F                pop ds
0000000C  FC                cld
0000000D  BE1B7C            mov si,0x7c1b
00000010  BF1B06            mov di,0x61b
00000013  50                push ax
00000014  57                push di
00000015  B9E501            mov cx,0x1e5
00000018  F3A4              rep movsb
0000001A  CB                retf
0000001B  BEBE07            mov si,0x7be
0000001E  B104              mov cl,0x4
00000020  382C              cmp [si],ch
00000022  7C09              jl 0x2d
00000024  7515              jnz 0x3b
00000026  83C610            add si,byte +0x10
00000029  E2F5              loop 0x20
0000002B  CD18              int 0x18
0000002D  8B14              mov dx,[si]
0000002F  8BEE              mov bp,si
00000031  83C610            add si,byte +0x10
00000034  49                dec cx
00000035  7416              jz 0x4d
00000037  382C              cmp [si],ch
00000039  74F6              jz 0x31
0000003B  BE1007            mov si,0x710
0000003E  4E                dec si
0000003F  AC                lodsb
00000040  3C00              cmp al,0x0
00000042  74FA              jz 0x3e
00000044  BB0700            mov bx,0x7
00000047  B40E              mov ah,0xe
00000049  CD10              int 0x10
0000004B  EBF2              jmp short 0x3f
0000004D  894625            mov [bp+0x25],ax
00000050  96                xchg ax,si
00000051  8A4604            mov al,[bp+0x4]
00000054  B406              mov ah,0x6
00000056  3C0E              cmp al,0xe
00000058  7411              jz 0x6b
0000005A  B40B              mov ah,0xb
0000005C  3C0C              cmp al,0xc
0000005E  7405              jz 0x65
00000060  38E0              cmp al,ah
00000062  752B              jnz 0x8f
00000064  40                inc ax
00000065  C6462506          mov byte [bp+0x25],0x6
00000069  7524              jnz 0x8f
0000006B  BBAA55            mov bx,0x55aa
0000006E  50                push ax
0000006F  B441              mov ah,0x41
00000071  CD13              int 0x13
00000073  58                pop ax
00000074  7216              jc 0x8c
00000076  81FB55AA          cmp bx,0xaa55
0000007A  7510              jnz 0x8c
0000007C  F6C101            test cl,0x1
0000007F  740B              jz 0x8c
00000081  8AE0              mov ah,al
00000083  885624            mov [bp+0x24],dl
00000086  C706A106EB1E      mov word [0x6a1],0x1eeb
0000008C  886604            mov [bp+0x4],ah
0000008F  BF0A00            mov di,0xa
00000092  B80102            mov ax,0x201
00000095  8BDC              mov bx,sp
00000097  33C9              xor cx,cx
00000099  83FF05            cmp di,byte +0x5
0000009C  7F03              jg 0xa1
0000009E  8B4E25            mov cx,[bp+0x25]
000000A1  034E02            add cx,[bp+0x2]
000000A4  CD13              int 0x13
000000A6  7229              jc 0xd1
000000A8  BE4607            mov si,0x746
000000AB  813EFE7D55AA      cmp word [0x7dfe],0xaa55
000000B1  745A              jz 0x10d
000000B3  83EF05            sub di,byte +0x5
000000B6  7FDA              jg 0x92
000000B8  85F6              test si,si
000000BA  7583              jnz 0x3f
000000BC  BE2707            mov si,0x727
000000BF  EB8A              jmp short 0x4b
000000C1  98                cbw
000000C2  91                xchg ax,cx
000000C3  52                push dx
000000C4  99                cwd
000000C5  034608            add ax,[bp+0x8]
000000C8  13560A            adc dx,[bp+0xa]
000000CB  E81200            call word 0xe0
000000CE  5A                pop dx
000000CF  EBD5              jmp short 0xa6
000000D1  4F                dec di
000000D2  74E4              jz 0xb8
000000D4  33C0              xor ax,ax
000000D6  CD13              int 0x13
000000D8  EBB8              jmp short 0x92
000000DA  skipping 0x6 bytes
000000E0  56                push si
000000E1  33F6              xor si,si
000000E3  56                push si
000000E4  56                push si
000000E5  52                push dx
000000E6  50                push ax
000000E7  06                push es
000000E8  53                push bx
000000E9  51                push cx
000000EA  BE1000            mov si,0x10
000000ED  56                push si
000000EE  8BF4              mov si,sp
000000F0  50                push ax
000000F1  52                push dx
000000F2  B80042            mov ax,0x4200
000000F5  8A5624            mov dl,[bp+0x24]
000000F8  CD13              int 0x13
000000FA  5A                pop dx
000000FB  58                pop ax
000000FC  8D6410            lea sp,[si+0x10]
000000FF  720A              jc 0x10b
00000101  40                inc ax
00000102  7501              jnz 0x105
00000104  42                inc dx
00000105  80C702            add bh,0x2
00000108  E2F7              loop 0x101
0000010A  F8                clc
0000010B  5E                pop si
0000010C  C3                ret
0000010D  EB74              jmp short 0x183
0000010F  skipping 0x74 bytes
00000183  8BFC              mov di,sp
00000185  1E                push ds
00000186  57                push di
00000187  8BF5              mov si,bp
00000189  CB                retf
0000018A  0000              add [bx+si],al
0000018C  0000              add [bx+si],al
0000018E  0000              add [bx+si],al
00000190  0000              add [bx+si],al
00000192  0000              add [bx+si],al
00000194  0000              add [bx+si],al
00000196  0000              add [bx+si],al
00000198  0000              add [bx+si],al
0000019A  0000              add [bx+si],al
0000019C  0000              add [bx+si],al
0000019E  0000              add [bx+si],al
000001A0  0000              add [bx+si],al
000001A2  0000              add [bx+si],al
000001A4  0000              add [bx+si],al
000001A6  0000              add [bx+si],al
000001A8  0000              add [bx+si],al
000001AA  0000              add [bx+si],al
000001AC  0000              add [bx+si],al
000001AE  0000              add [bx+si],al
000001B0  0000              add [bx+si],al
000001B2  0000              add [bx+si],al
000001B4  0000              add [bx+si],al
000001B6  0000              add [bx+si],al
000001B8  0000              add [bx+si],al
000001BA  0000              add [bx+si],al
000001BC  0000              add [bx+si],al
000001BE  skipping 0x42 bytes
