00000000  31C0              xor ax,ax
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
0000002F  89F5              mov bp,si
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
00000081  88C4              mov ah,al
00000083  885624            mov [bp+0x24],dl
00000086  C706A106EB1E      mov word [0x6a1],0x1eeb
0000008C  886604            mov [bp+0x4],ah
0000008F  BF0A00            mov di,0xa
00000092  B80102            mov ax,0x201
00000095  89E3              mov bx,sp
00000097  31C9              xor cx,cx
00000099  83FF05            cmp di,byte +0x5
0000009C  7F03              jg 0xa1
0000009E  8B4E25            mov cx,[bp+0x25]
000000A1  034E02            add cx,[bp+0x2]
000000A4  CD13              int 0x13
000000A6  722C              jc 0xd4
000000A8  BE4607            mov si,0x746
000000AB  813EFE7D55AA      cmp word [0x7dfe],0xaa55
000000B1  7503              jnz 0xb6
000000B3  E95700            jmp word 0x10d
000000B6  83EF05            sub di,byte +0x5
000000B9  7FD7              jg 0x92
000000BB  85F6              test si,si
000000BD  7580              jnz 0x3f
000000BF  BE2707            mov si,0x727
000000C2  EB87              jmp short 0x4b
000000C4  98                cbw
000000C5  91                xchg ax,cx
000000C6  52                push dx
000000C7  99                cwd
000000C8  034608            add ax,[bp+0x8]
000000CB  13560A            adc dx,[bp+0xa]
000000CE  E81200            call word 0xe3
000000D1  5A                pop dx
000000D2  EBD2              jmp short 0xa6
000000D4  4F                dec di
000000D5  74E4              jz 0xbb
000000D7  31C0              xor ax,ax
000000D9  CD13              int 0x13
000000DB  EBB5              jmp short 0x92
000000DD  0000              add [bx+si],al
000000DF  0000              add [bx+si],al
000000E1  0000              add [bx+si],al
000000E3  56                push si
000000E4  31F6              xor si,si
000000E6  56                push si
000000E7  56                push si
000000E8  52                push dx
000000E9  50                push ax
000000EA  06                push es
000000EB  53                push bx
000000EC  51                push cx
000000ED  BE1000            mov si,0x10
000000F0  56                push si
000000F1  89E6              mov si,sp
000000F3  50                push ax
000000F4  52                push dx
000000F5  B80042            mov ax,0x4200
000000F8  8A5624            mov dl,[bp+0x24]
000000FB  CD13              int 0x13
000000FD  5A                pop dx
000000FE  58                pop ax
000000FF  8D6410            lea sp,[si+0x10]
00000102  720A              jc 0x10e
00000104  40                inc ax
00000105  7501              jnz 0x108
00000107  42                inc dx
00000108  80C702            add bh,0x2
0000010B  E2F7              loop 0x104
0000010D  F8                clc
0000010E  5E                pop si
0000010F  C3                ret
00000110  EB6B              jmp short 0x17d
00000112  49                dec cx
00000113  6E                outsb
00000114  7661              jna 0x177
00000116  6C                insb
00000117  6964207061        imul sp,[si+0x20],word 0x6170
0000011C  7274              jc 0x192
0000011E  6974696F6E        imul si,[si+0x69],word 0x6e6f
00000123  207461            and [si+0x61],dh
00000126  626C65            bound bp,[si+0x65]
00000129  004572            add [di+0x72],al
0000012C  726F              jc 0x19d
0000012E  7220              jc 0x150
00000130  6C                insb
00000131  6F                outsw
00000132  61                popaw
00000133  64696E67206F      imul bp,[fs:bp+0x67],word 0x6f20
00000139  7065              jo 0x1a0
0000013B  7261              jc 0x19e
0000013D  7469              jz 0x1a8
0000013F  6E                outsb
00000140  67207379          and [ebx+0x79],dh
00000144  7374              jnc 0x1ba
00000146  656D              gs insw
00000148  004D69            add [di+0x69],cl
0000014B  7373              jnc 0x1c0
0000014D  696E67206F        imul bp,[bp+0x67],word 0x6f20
00000152  7065              jo 0x1b9
00000154  7261              jc 0x1b7
00000156  7469              jz 0x1c1
00000158  6E                outsb
00000159  67207379          and [ebx+0x79],dh
0000015D  7374              jnc 0x1d3
0000015F  656D              gs insw
00000161  00                db 0x00
