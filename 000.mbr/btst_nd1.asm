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
00000022  0F8C0700          jl word 0x2d
00000026  0F851100          jnz word 0x3b
0000002A  83C600            add si,byte +0x0
0000002D  E2F1              loop 0x20
0000002F  CD18              int 0x18
00000031  8B14              mov dx,[si]
00000033  89F5              mov bp,si
00000035  83C600            add si,byte +0x0
00000038  49                dec cx
00000039  0F841000          jz word 0x4d
0000003D  382C              cmp [si],ch
0000003F  0F84EEFF          jz word 0x31
00000043  BE1007            mov si,0x710
00000046  4E                dec si
00000047  AC                lodsb
00000048  3C00              cmp al,0x0
0000004A  0F84F0FF          jz word 0x3e
0000004E  BB0700            mov bx,0x7
00000051  B40E              mov ah,0xe
00000053  CD10              int 0x10
00000055  EBE8              jmp short 0x3f
00000057  894625            mov [bp+0x25],ax
0000005A  96                xchg ax,si
0000005B  8A4604            mov al,[bp+0x4]
0000005E  B406              mov ah,0x6
00000060  3C0E              cmp al,0xe
00000062  0F840500          jz word 0x6b
00000066  B40B              mov ah,0xb
00000068  3C0C              cmp al,0xc
0000006A  0F84F7FF          jz word 0x65
0000006E  38E0              cmp al,ah
00000070  0F851B00          jnz word 0x8f
00000074  40                inc ax
00000075  C6462506          mov byte [bp+0x25],0x6
00000079  0F851200          jnz word 0x8f
0000007D  BBAA55            mov bx,0x55aa
00000080  50                push ax
00000081  B441              mov ah,0x41
00000083  CD13              int 0x13
00000085  58                pop ax
00000086  0F820200          jc word 0x8c
0000008A  81FB55AA          cmp bx,0xaa55
0000008E  0F85FAFF          jnz word 0x8c
00000092  F6C101            test cl,0x1
00000095  0F84F3FF          jz word 0x8c
00000099  88C4              mov ah,al
0000009B  885624            mov [bp+0x24],dl
0000009E  C706A106EB1E      mov word [0x6a1],0x1eeb
000000A4  886604            mov [bp+0x4],ah
000000A7  BF0A00            mov di,0xa
000000AA  B80102            mov ax,0x201
000000AD  89E3              mov bx,sp
000000AF  31C9              xor cx,cx
000000B1  83FF00            cmp di,byte +0x0
000000B4  0F8FE9FF          jg word 0xa1
000000B8  8B4E25            mov cx,[bp+0x25]
000000BB  034E02            add cx,[bp+0x2]
000000BE  CD13              int 0x13
000000C0  0F820D00          jc word 0xd1
000000C4  BE4607            mov si,0x746
000000C7  813EFE7D55AA      cmp word [0x7dfe],0xaa55
000000CD  0F843C00          jz word 0x10d
000000D1  83EF00            sub di,byte +0x0
000000D4  0F8FBAFF          jg word 0x92
000000D8  85F6              test si,si
000000DA  0F8561FF          jnz word 0x3f
000000DE  BE2707            mov si,0x727
000000E1  EB68              jmp short 0x14b
000000E3  98                cbw
000000E4  91                xchg ax,cx
000000E5  52                push dx
000000E6  99                cwd
000000E7  034608            add ax,[bp+0x8]
000000EA  13560A            adc dx,[bp+0xa]
000000ED  E8F0FF            call word 0xe0
000000F0  5A                pop dx
000000F1  EBB3              jmp short 0xa6
000000F3  4F                dec di
000000F4  0F84C0FF          jz word 0xb8
000000F8  31C0              xor ax,ax
000000FA  CD13              int 0x13
000000FC  EB94              jmp short 0x92
000000FE  56                push si
000000FF  31F6              xor si,si
00000101  56                push si
00000102  56                push si
00000103  52                push dx
00000104  50                push ax
00000105  06                push es
00000106  53                push bx
00000107  51                push cx
00000108  BE1000            mov si,0x10
0000010B  56                push si
0000010C  89E6              mov si,sp
0000010E  50                push ax
0000010F  52                push dx
00000110  B80042            mov ax,0x4200
00000113  8A5624            mov dl,[bp+0x24]
00000116  CD13              int 0x13
00000118  5A                pop dx
00000119  58                pop ax
0000011A  8D6410            lea sp,[si+0x10]
0000011D  0F82E4FF          jc word 0x105
00000121  40                inc ax
00000122  0F85D9FF          jnz word 0xff
00000126  42                inc dx
00000127  80C702            add bh,0x2
0000012A  E2CF              loop 0xfb
0000012C  F8                clc
0000012D  5E                pop si
0000012E  C3                ret
0000012F  EB4C              jmp short 0x17d
