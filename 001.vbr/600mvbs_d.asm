00000000  EB58              jmp short 0x5a
00000002  90                nop
00000003  skipping 0x57 bytes
0000005A  FA                cli
0000005B  33C9              xor cx,cx
0000005D  8ED1              mov ss,cx
0000005F  BCF87B            mov sp,0x7bf8
00000062  8EC1              mov es,cx
00000064  BD7800            mov bp,0x78
00000067  C57600            lds si,[bp+0x0]
0000006A  1E                push ds
0000006B  56                push si
0000006C  16                push ss
0000006D  55                push bp
0000006E  BF2205            mov di,0x522
00000071  897E00            mov [bp+0x0],di
00000074  894E02            mov [bp+0x2],cx
00000077  B10B              mov cl,0xb
00000079  FC                cld
0000007A  F3A4              rep movsb
0000007C  8ED9              mov ds,cx
0000007E  BD007C            mov bp,0x7c00
00000081  C645FE0F          mov byte [di-0x2],0xf
00000085  8B4618            mov ax,[bp+0x18]
00000088  8845F9            mov [di-0x7],al
0000008B  384E40            cmp [bp+0x40],cl
0000008E  7D25              jnl 0xb5
00000090  8BC1              mov ax,cx
00000092  99                cwd
00000093  BB0007            mov bx,0x700
00000096  E89700            call word 0x130
00000099  721A              jc 0xb5
0000009B  83EB3A            sub bx,byte +0x3a
0000009E  66A11C7C          mov eax,[0x7c1c]
000000A2  663B07            cmp eax,[bx]
000000A5  8A57FC            mov dl,[bx-0x4]
000000A8  7506              jnz 0xb0
000000AA  80CA02            or dl,0x2
000000AD  885602            mov [bp+0x2],dl
000000B0  80C310            add bl,0x10
000000B3  73ED              jnc 0xa2
000000B5  BF0200            mov di,0x2
000000B8  837E1600          cmp word [bp+0x16],byte +0x0
000000BC  7545              jnz 0x103
000000BE  8B461C            mov ax,[bp+0x1c]
000000C1  8B561E            mov dx,[bp+0x1e]
000000C4  B90300            mov cx,0x3
000000C7  49                dec cx
000000C8  40                inc ax
000000C9  7501              jnz 0xcc
000000CB  42                inc dx
000000CC  BB007E            mov bx,0x7e00
000000CF  E85F00            call word 0x131
000000D2  7326              jnc 0xfa
000000D4  B0F8              mov al,0xf8
000000D6  4F                dec di
000000D7  741D              jz 0xf6
000000D9  8B4632            mov ax,[bp+0x32]
000000DC  33D2              xor dx,dx
000000DE  B90300            mov cx,0x3
000000E1  3BC8              cmp cx,ax
000000E3  771E              ja 0x103
000000E5  8B760E            mov si,[bp+0xe]
000000E8  3BCE              cmp cx,si
000000EA  7317              jnc 0x103
000000EC  2BF1              sub si,cx
000000EE  03461C            add ax,[bp+0x1c]
000000F1  13561E            adc dx,[bp+0x1e]
000000F4  EBD1              jmp short 0xc7
000000F6  730B              jnc 0x103
000000F8  EB27              jmp short 0x121
000000FA  837E2A00          cmp word [bp+0x2a],byte +0x0
000000FE  7703              ja 0x103
00000100  E9FD02            jmp word 0x400
00000103  BE7E7D            mov si,0x7d7e
00000106  AC                lodsb
00000107  98                cbw
00000108  03F0              add si,ax
0000010A  AC                lodsb
0000010B  84C0              test al,al
0000010D  7417              jz 0x126
0000010F  3CFF              cmp al,0xff
00000111  7409              jz 0x11c
00000113  B40E              mov ah,0xe
00000115  BB0700            mov bx,0x7
00000118  CD10              int 0x10
0000011A  EBEE              jmp short 0x10a
0000011C  BE817D            mov si,0x7d81
0000011F  EBE5              jmp short 0x106
00000121  BE7F7D            mov si,0x7d7f
00000124  EBE0              jmp short 0x106
00000126  98                cbw
00000127  CD16              int 0x16
00000129  5E                pop si
0000012A  1F                pop ds
0000012B  668F04            pop dword [si]
0000012E  CD19              int 0x19
00000130  41                inc cx
00000131  56                push si
00000132  666A00            o32 push byte +0x0
00000135  52                push dx
00000136  50                push ax
00000137  06                push es
00000138  53                push bx
00000139  6A01              push byte +0x1
0000013B  6A10              push byte +0x10
0000013D  8BF4              mov si,sp
0000013F  60                pushaw
00000140  807E020E          cmp byte [bp+0x2],0xe
00000144  7504              jnz 0x14a
00000146  B442              mov ah,0x42
00000148  EB1D              jmp short 0x167
0000014A  91                xchg ax,cx
0000014B  92                xchg ax,dx
0000014C  33D2              xor dx,dx
0000014E  F77618            div word [bp+0x18]
00000151  91                xchg ax,cx
00000152  F77618            div word [bp+0x18]
00000155  42                inc dx
00000156  87CA              xchg cx,dx
00000158  F7761A            div word [bp+0x1a]
0000015B  8AF2              mov dh,dl
0000015D  8AE8              mov ch,al
0000015F  C0CC02            ror ah,byte 0x2
00000162  0ACC              or cl,ah
00000164  B80102            mov ax,0x201
00000167  8A5640            mov dl,[bp+0x40]
0000016A  CD13              int 0x13
0000016C  61                popaw
0000016D  8D6410            lea sp,[si+0x10]
00000170  5E                pop si
00000171  720A              jc 0x17d
00000173  40                inc ax
00000174  7501              jnz 0x177
00000176  42                inc dx
00000177  035E0B            add bx,[bp+0xb]
0000017A  49                dec cx
0000017B  75B4              jnz 0x131
0000017D  C3                ret
0000017E  0318              add bx,[bx+si]
00000180  0127              add [bx],sp
00000182  skipping 0x7E bytes
