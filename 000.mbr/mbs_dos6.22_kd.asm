00000000  FA                cli
00000001  33C0              xor ax,ax
00000003  8ED0              mov ss,ax
00000005  BC007C            mov sp,0x7c00
00000008  8BF4              mov si,sp
0000000A  50                push ax
0000000B  07                pop es
0000000C  50                push ax
0000000D  1F                pop ds
0000000E  FB                sti
0000000F  FC                cld
00000010  BF0006            mov di,0x600
00000013  B90001            mov cx,0x100
00000016  F2A5              repne movsw
00000018  EA1D060000        jmp word 0x0:0x61d
0000001D  BEBE07            mov si,0x7be
00000020  B304              mov bl,0x4
00000022  803C80            cmp byte [si],0x80
00000025  740E              jz 0x35
00000027  803C00            cmp byte [si],0x0
0000002A  751C              jnz 0x48
0000002C  83C610            add si,byte +0x10
0000002F  FECB              dec bl
00000031  75EF              jnz 0x22
00000033  CD18              int 0x18
00000035  8B14              mov dx,[si]
00000037  8B4C02            mov cx,[si+0x2]
0000003A  8BEE              mov bp,si
0000003C  83C610            add si,byte +0x10
0000003F  FECB              dec bl
00000041  741A              jz 0x5d
00000043  803C00            cmp byte [si],0x0
00000046  74F4              jz 0x3c
00000048  BE8B06            mov si,0x68b
0000004B  AC                lodsb
0000004C  3C00              cmp al,0x0
0000004E  740B              jz 0x5b
00000050  56                push si
00000051  BB0700            mov bx,0x7
00000054  B40E              mov ah,0xe
00000056  CD10              int 0x10
00000058  5E                pop si
00000059  EBF0              jmp short 0x4b
0000005B  EBFE              jmp short 0x5b
0000005D  BF0500            mov di,0x5
00000060  BB007C            mov bx,0x7c00
00000063  B80102            mov ax,0x201
00000066  57                push di
00000067  CD13              int 0x13
00000069  5F                pop di
0000006A  730C              jnc 0x78
0000006C  33C0              xor ax,ax
0000006E  CD13              int 0x13
00000070  4F                dec di
00000071  75ED              jnz 0x60
00000073  BEA306            mov si,0x6a3
00000076  EBD3              jmp short 0x4b
00000078  BEC206            mov si,0x6c2
0000007B  BFFE7D            mov di,0x7dfe
0000007E  813D55AA          cmp word [di],0xaa55
00000082  75C7              jnz 0x4b
00000084  8BF5              mov si,bp
00000086  EA007C0000        jmp word 0x0:0x7c00
0000008B  skipping 0x175 bytes
