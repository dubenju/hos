00000000  EB58              jmp short 0x5a
00000002  90                nop
00000003  4D                dec bp
00000004  53                push bx
00000005  57                push di
00000006  49                dec cx
00000007  4E                dec si
00000008  342E              xor al,0x2e
0000000A  3100              xor [bx+si],ax
0000000C  0208              add cl,[bx+si]
0000000E  2000              and [bx+si],al
00000010  0200              add al,[bx+si]
00000012  0000              add [bx+si],al
00000014  00F8              add al,bh
00000016  0000              add [bx+si],al
00000018  3F                aas
00000019  0020              add [bx+si],ah
0000001B  003F              add [bx],bh
0000001D  0000              add [bx+si],al
0000001F  00A1BB12          add [bx+di+0x12bb],ah
00000023  00AE0400          add [bp+0x4],ch
00000027  0000              add [bx+si],al
00000029  0000              add [bx+si],al
0000002B  0002              add [bp+si],al
0000002D  0000              add [bx+si],al
0000002F  0001              add [bx+di],al
00000031  00060000          add [0x0],al
00000035  0000              add [bx+si],al
00000037  0000              add [bx+si],al
00000039  0000              add [bx+si],al
0000003B  0000              add [bx+si],al
0000003D  0000              add [bx+si],al
0000003F  00800029          add [bx+si+0x2900],al
00000043  F8                clc
00000044  0D5F23            or ax,0x235f
00000047  4E                dec si
00000048  4F                dec di
00000049  204E41            and [bp+0x41],cl
0000004C  4D                dec bp
0000004D  45                inc bp
0000004E  2020              and [bx+si],ah
00000050  2020              and [bx+si],ah
00000052  46                inc si
00000053  41                inc cx
00000054  54                push sp
00000055  3332              xor si,[bp+si]
00000057  2020              and [bx+si],ah
00000059  20FA              and dl,bh
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
00000182  0D0A49            or ax,0x490a
00000185  6E                outsb
00000186  7661              jna 0x1e9
00000188  6C                insb
00000189  6964207379        imul sp,[si+0x20],word 0x7973
0000018E  7374              jnc 0x204
00000190  656D              gs insw
00000192  206469            and [si+0x69],ah
00000195  736B              jnc 0x202
00000197  FF0D              dec word [di]
00000199  0A4469            or al,[si+0x69]
0000019C  736B              jnc 0x209
0000019E  20492F            and [bx+di+0x2f],cl
000001A1  4F                dec di
000001A2  206572            and [di+0x72],ah
000001A5  726F              jc 0x216
000001A7  72FF              jc 0x1a8
000001A9  0D0A52            or ax,0x520a
000001AC  65706C            gs jo 0x21b
000001AF  61                popaw
000001B0  636520            arpl [di+0x20],sp
000001B3  7468              jz 0x21d
000001B5  65206469          and [gs:si+0x69],ah
000001B9  736B              jnc 0x226
000001BB  2C20              sub al,0x20
000001BD  61                popaw
000001BE  6E                outsb
000001BF  64207468          and [fs:si+0x68],dh
000001C3  656E              gs outsb
000001C5  207072            and [bx+si+0x72],dh
000001C8  657373            gs jnc 0x23e
000001CB  20616E            and [bx+di+0x6e],ah
000001CE  7920              jns 0x1f0
000001D0  6B65790D          imul sp,[di+0x79],byte +0xd
000001D4  0A00              or al,[bx+si]
000001D6  0000              add [bx+si],al
000001D8  49                dec cx
000001D9  4F                dec di
000001DA  2020              and [bx+si],ah
000001DC  2020              and [bx+si],ah
000001DE  2020              and [bx+si],ah
000001E0  53                push bx
000001E1  59                pop cx
000001E2  53                push bx
000001E3  4D                dec bp
000001E4  53                push bx
000001E5  44                inc sp
000001E6  4F                dec di
000001E7  53                push bx
000001E8  2020              and [bx+si],ah
000001EA  205359            and [bp+di+0x59],dl
000001ED  53                push bx
000001EE  7E01              jng 0x1f1
000001F0  005749            add [bx+0x49],dl
000001F3  4E                dec si
000001F4  42                inc dx
000001F5  4F                dec di
000001F6  4F                dec di
000001F7  54                push sp
000001F8  205359            and [bp+di+0x59],dl
000001FB  53                push bx
000001FC  0000              add [bx+si],al
000001FE  55                push bp
000001FF  AA                stosb
