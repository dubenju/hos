00000000  FA                cli
00000001  33C9              xor cx,cx
00000003  8ED1              mov ss,cx
00000005  BCF87B            mov sp,0x7bf8
00000008  8EC1              mov es,cx
0000000A  BD7800            mov bp,0x78
0000000D  C57600            lds si,[bp+0x0]
00000010  1E                push ds
00000011  56                push si
00000012  16                push ss
00000013  55                push bp
00000014  BF2205            mov di,0x522
00000017  897E00            mov [bp+0x0],di
0000001A  894E02            mov [bp+0x2],cx
0000001D  B10B              mov cl,0xb
0000001F  FC                cld
00000020  F3A4              rep movsb
00000022  8ED9              mov ds,cx
00000024  BD007C            mov bp,0x7c00
00000027  C645FE0F          mov byte [di-0x2],0xf
0000002B  8B4618            mov ax,[bp+0x18]
0000002E  8845F9            mov [di-0x7],al
00000031  384E40            cmp [bp+0x40],cl
00000034  7D25              jnl 0x5b
00000036  8BC1              mov ax,cx
00000038  99                cwd
00000039  BB0007            mov bx,0x700
0000003C  E89700            call word 0xd6
0000003F  721A              jc 0x5b
00000041  83EB3A            sub bx,byte +0x3a
00000044  66A11C7C          mov eax,[0x7c1c]
00000048  663B07            cmp eax,[bx]
0000004B  8A57FC            mov dl,[bx-0x4]
0000004E  7506              jnz 0x56
00000050  80CA02            or dl,0x2
00000053  885602            mov [bp+0x2],dl
00000056  80C310            add bl,0x10
00000059  73ED              jnc 0x48
0000005B  BF0200            mov di,0x2
0000005E  837E1600          cmp word [bp+0x16],byte +0x0
00000062  7545              jnz 0xa9
00000064  8B461C            mov ax,[bp+0x1c]
00000067  8B561E            mov dx,[bp+0x1e]
0000006A  B90300            mov cx,0x3
0000006D  49                dec cx
0000006E  40                inc ax
0000006F  7501              jnz 0x72
00000071  42                inc dx
00000072  BB007E            mov bx,0x7e00
00000075  E85F00            call word 0xd7
00000078  7326              jnc 0xa0
0000007A  B0F8              mov al,0xf8
0000007C  4F                dec di
0000007D  741D              jz 0x9c
0000007F  8B4632            mov ax,[bp+0x32]
00000082  33D2              xor dx,dx
00000084  B90300            mov cx,0x3
00000087  3BC8              cmp cx,ax
00000089  771E              ja 0xa9
0000008B  8B760E            mov si,[bp+0xe]
0000008E  3BCE              cmp cx,si
00000090  7317              jnc 0xa9
00000092  2BF1              sub si,cx
00000094  03461C            add ax,[bp+0x1c]
00000097  13561E            adc dx,[bp+0x1e]
0000009A  EBD1              jmp short 0x6d
0000009C  730B              jnc 0xa9
0000009E  EB27              jmp short 0xc7
000000A0  837E2A00          cmp word [bp+0x2a],byte +0x0
000000A4  7703              ja 0xa9
000000A6  E9FD02            jmp word 0x3a6
000000A9  BE7E7D            mov si,0x7d7e
000000AC  AC                lodsb
000000AD  98                cbw
000000AE  03F0              add si,ax
000000B0  AC                lodsb
000000B1  84C0              test al,al
000000B3  7417              jz 0xcc
000000B5  3CFF              cmp al,0xff
000000B7  7409              jz 0xc2
000000B9  B40E              mov ah,0xe
000000BB  BB0700            mov bx,0x7
000000BE  CD10              int 0x10
000000C0  EBEE              jmp short 0xb0
000000C2  BE817D            mov si,0x7d81
000000C5  EBE5              jmp short 0xac
000000C7  BE7F7D            mov si,0x7d7f
000000CA  EBE0              jmp short 0xac
000000CC  98                cbw
000000CD  CD16              int 0x16
000000CF  5E                pop si
000000D0  1F                pop ds
000000D1  668F04            pop dword [si]
000000D4  CD19              int 0x19
000000D6  41                inc cx
000000D7  56                push si
000000D8  666A00            o32 push byte +0x0
000000DB  52                push dx
000000DC  50                push ax
000000DD  06                push es
000000DE  53                push bx
000000DF  6A01              push byte +0x1
000000E1  6A10              push byte +0x10
000000E3  8BF4              mov si,sp
000000E5  60                pushaw
000000E6  807E020E          cmp byte [bp+0x2],0xe
000000EA  7504              jnz 0xf0
000000EC  B442              mov ah,0x42
000000EE  EB1D              jmp short 0x10d
000000F0  91                xchg ax,cx
000000F1  92                xchg ax,dx
000000F2  33D2              xor dx,dx
000000F4  F77618            div word [bp+0x18]
000000F7  91                xchg ax,cx
000000F8  F77618            div word [bp+0x18]
000000FB  42                inc dx
000000FC  87CA              xchg cx,dx
000000FE  F7761A            div word [bp+0x1a]
00000101  8AF2              mov dh,dl
00000103  8AE8              mov ch,al
00000105  C0CC02            ror ah,byte 0x2
00000108  0ACC              or cl,ah
0000010A  B80102            mov ax,0x201
0000010D  8A5640            mov dl,[bp+0x40]
00000110  CD13              int 0x13
00000112  61                popaw
00000113  8D6410            lea sp,[si+0x10]
00000116  5E                pop si
00000117  720A              jc 0x123
00000119  40                inc ax
0000011A  7501              jnz 0x11d
0000011C  42                inc dx
0000011D  035E0B            add bx,[bp+0xb]
00000120  49                dec cx
00000121  75B4              jnz 0xd7
00000123  C3                ret
00000124  0318              add bx,[bx+si]
00000126  0127              add [bx],sp
00000128  0D0A49            or ax,0x490a
0000012B  6E                outsb
0000012C  7661              jna 0x18f
0000012E  6C                insb
0000012F  6964207379        imul sp,[si+0x20],word 0x7973
00000134  7374              jnc 0x1aa
00000136  656D              gs insw
00000138  206469            and [si+0x69],ah
0000013B  736B              jnc 0x1a8
0000013D  FF0D              dec word [di]
0000013F  0A4469            or al,[si+0x69]
00000142  736B              jnc 0x1af
00000144  20492F            and [bx+di+0x2f],cl
00000147  4F                dec di
00000148  206572            and [di+0x72],ah
0000014B  726F              jc 0x1bc
0000014D  72FF              jc 0x14e
0000014F  0D0A52            or ax,0x520a
00000152  65706C            gs jo 0x1c1
00000155  61                popaw
00000156  636520            arpl [di+0x20],sp
00000159  7468              jz 0x1c3
0000015B  65206469          and [gs:si+0x69],ah
0000015F  736B              jnc 0x1cc
00000161  2C20              sub al,0x20
00000163  61                popaw
00000164  6E                outsb
00000165  64207468          and [fs:si+0x68],dh
00000169  656E              gs outsb
0000016B  207072            and [bx+si+0x72],dh
0000016E  657373            gs jnc 0x1e4
00000171  20616E            and [bx+di+0x6e],ah
00000174  7920              jns 0x196
00000176  6B65790D          imul sp,[di+0x79],byte +0xd
0000017A  0A00              or al,[bx+si]
0000017C  0000              add [bx+si],al
0000017E  49                dec cx
0000017F  4F                dec di
00000180  2020              and [bx+si],ah
00000182  2020              and [bx+si],ah
00000184  2020              and [bx+si],ah
00000186  53                push bx
00000187  59                pop cx
00000188  53                push bx
00000189  4D                dec bp
0000018A  53                push bx
0000018B  44                inc sp
0000018C  4F                dec di
0000018D  53                push bx
0000018E  2020              and [bx+si],ah
00000190  205359            and [bp+di+0x59],dl
00000193  53                push bx
00000194  7E01              jng 0x197
00000196  005749            add [bx+0x49],dl
00000199  4E                dec si
0000019A  42                inc dx
0000019B  4F                dec di
0000019C  4F                dec di
0000019D  54                push sp
0000019E  205359            and [bp+di+0x59],dl
000001A1  53                push bx
000001A2  0000              add [bx+si],al
