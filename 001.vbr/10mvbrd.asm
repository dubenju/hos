00000000  33C9              xor cx,cx
00000002  8ED1              mov ss,cx
00000004  BCFC7B            mov sp,0x7bfc
00000007  16                push ss
00000008  07                pop es
00000009  BD7800            mov bp,0x78
0000000C  C57600            lds si,[bp+0x0]
0000000F  1E                push ds
00000010  56                push si
00000011  16                push ss
00000012  55                push bp
00000013  BF2205            mov di,0x522
00000016  897E00            mov [bp+0x0],di
00000019  894E02            mov [bp+0x2],cx
0000001C  B10B              mov cl,0xb
0000001E  FC                cld
0000001F  F3A4              rep movsb
00000021  06                push es
00000022  1F                pop ds
00000023  BD007C            mov bp,0x7c00
00000026  C645FE0F          mov byte [di-0x2],0xf
0000002A  384E24            cmp [bp+0x24],cl
0000002D  7D20              jnl 0x4f
0000002F  8BC1              mov ax,cx
00000031  99                cwd
00000032  E87E01            call word 0x1b3
00000035  83EB3A            sub bx,byte +0x3a
00000038  66A11C7C          mov eax,[0x7c1c]
0000003C  663B07            cmp eax,[bx]
0000003F  8A57FC            mov dl,[bx-0x4]
00000042  7506              jnz 0x4a
00000044  80CA02            or dl,0x2
00000047  885602            mov [bp+0x2],dl
0000004A  80C310            add bl,0x10
0000004D  73ED              jnc 0x3c
0000004F  33C9              xor cx,cx
00000051  FE06D87D          inc byte [0x7dd8]
00000055  8A4610            mov al,[bp+0x10]
00000058  98                cbw
00000059  F76616            mul word [bp+0x16]
0000005C  03461C            add ax,[bp+0x1c]
0000005F  13561E            adc dx,[bp+0x1e]
00000062  03460E            add ax,[bp+0xe]
00000065  13D1              adc dx,cx
00000067  8B7611            mov si,[bp+0x11]
0000006A  60                pushaw
0000006B  8946FC            mov [bp-0x4],ax
0000006E  8956FE            mov [bp-0x2],dx
00000071  B82000            mov ax,0x20
00000074  F7E6              mul si
00000076  8B5E0B            mov bx,[bp+0xb]
00000079  03C3              add ax,bx
0000007B  48                dec ax
0000007C  F7F3              div bx
0000007E  0146FC            add [bp-0x4],ax
00000081  114EFE            adc [bp-0x2],cx
00000084  61                popaw
00000085  BF0007            mov di,0x700
00000088  E82801            call word 0x1b3
0000008B  723E              jc 0xcb
0000008D  382D              cmp [di],ch
0000008F  7417              jz 0xa8
00000091  60                pushaw
00000092  B10B              mov cl,0xb
00000094  BED87D            mov si,0x7dd8
00000097  F3A6              repe cmpsb
00000099  61                popaw
0000009A  743D              jz 0xd9
0000009C  4E                dec si
0000009D  7409              jz 0xa8
0000009F  83C720            add di,byte +0x20
000000A2  3BFB              cmp di,bx
000000A4  72E7              jc 0x8d
000000A6  EBDD              jmp short 0x85
000000A8  FE0ED87D          dec byte [0x7dd8]
000000AC  7BA7              jpo 0x55
000000AE  BE7F7D            mov si,0x7d7f
000000B1  AC                lodsb
000000B2  98                cbw
000000B3  03F0              add si,ax
000000B5  AC                lodsb
000000B6  98                cbw
000000B7  40                inc ax
000000B8  740C              jz 0xc6
000000BA  48                dec ax
000000BB  7413              jz 0xd0
000000BD  B40E              mov ah,0xe
000000BF  BB0700            mov bx,0x7
000000C2  CD10              int 0x10
000000C4  EBEF              jmp short 0xb5
000000C6  BE827D            mov si,0x7d82
000000C9  EBE6              jmp short 0xb1
000000CB  BE807D            mov si,0x7d80
000000CE  EBE1              jmp short 0xb1
000000D0  CD16              int 0x16
000000D2  5E                pop si
000000D3  1F                pop ds
000000D4  668F04            pop dword [si]
000000D7  CD19              int 0x19
000000D9  BE817D            mov si,0x7d81
000000DC  8B7D1A            mov di,[di+0x1a]
000000DF  8D45FE            lea ax,[di-0x2]
000000E2  8A4E0D            mov cl,[bp+0xd]
000000E5  F7E1              mul cx
000000E7  0346FC            add ax,[bp-0x4]
000000EA  1356FE            adc dx,[bp-0x2]
000000ED  B104              mov cl,0x4
000000EF  E8C200            call word 0x1b4
000000F2  72D7              jc 0xcb
000000F4  EA00027000        jmp word 0x70:0x200
000000F9  52                push dx
000000FA  50                push ax
000000FB  06                push es
000000FC  53                push bx
000000FD  6A01              push byte +0x1
000000FF  6A10              push byte +0x10
00000101  91                xchg ax,cx
00000102  8B4618            mov ax,[bp+0x18]
00000105  A22605            mov [0x526],al
00000108  96                xchg ax,si
00000109  92                xchg ax,dx
0000010A  33D2              xor dx,dx
0000010C  F7F6              div si
0000010E  91                xchg ax,cx
0000010F  F7F6              div si
00000111  42                inc dx
00000112  87CA              xchg cx,dx
00000114  F7761A            div word [bp+0x1a]
00000117  8AF2              mov dh,dl
00000119  8AE8              mov ch,al
0000011B  C0CC02            ror ah,byte 0x2
0000011E  0ACC              or cl,ah
00000120  B80102            mov ax,0x201
00000123  807E020E          cmp byte [bp+0x2],0xe
00000127  7504              jnz 0x12d
00000129  B442              mov ah,0x42
0000012B  8BF4              mov si,sp
0000012D  8A5624            mov dl,[bp+0x24]
00000130  CD13              int 0x13
00000132  61                popaw
00000133  61                popaw
00000134  720A              jc 0x140
00000136  40                inc ax
00000137  7501              jnz 0x13a
00000139  42                inc dx
0000013A  035E0B            add bx,[bp+0xb]
0000013D  49                dec cx
0000013E  7577              jnz 0x1b7
00000140  C3                ret
00000141  0318              add bx,[bx+si]
00000143  0127              add [bx],sp
00000145  0D0A49            or ax,0x490a
00000148  6E                outsb
00000149  7661              jna 0x1ac
0000014B  6C                insb
0000014C  6964207379        imul sp,[si+0x20],word 0x7973
00000151  7374              jnc 0x1c7
00000153  656D              gs insw
00000155  206469            and [si+0x69],ah
00000158  736B              jnc 0x1c5
0000015A  FF0D              dec word [di]
0000015C  0A4469            or al,[si+0x69]
0000015F  736B              jnc 0x1cc
00000161  20492F            and [bx+di+0x2f],cl
00000164  4F                dec di
00000165  206572            and [di+0x72],ah
00000168  726F              jc 0x1d9
0000016A  72FF              jc 0x16b
0000016C  0D0A52            or ax,0x520a
0000016F  65706C            gs jo 0x1de
00000172  61                popaw
00000173  636520            arpl [di+0x20],sp
00000176  7468              jz 0x1e0
00000178  65206469          and [gs:si+0x69],ah
0000017C  736B              jnc 0x1e9
0000017E  2C20              sub al,0x20
00000180  61                popaw
00000181  6E                outsb
00000182  64207468          and [fs:si+0x68],dh
00000186  656E              gs outsb
00000188  207072            and [bx+si+0x72],dh
0000018B  657373            gs jnc 0x201
0000018E  20616E            and [bx+di+0x6e],ah
00000191  7920              jns 0x1b3
00000193  6B65790D          imul sp,[di+0x79],byte +0xd
00000197  0A00              or al,[bx+si]
00000199  00494F            add [bx+di+0x4f],cl
0000019C  2020              and [bx+si],ah
0000019E  2020              and [bx+si],ah
000001A0  2020              and [bx+si],ah
000001A2  53                push bx
000001A3  59                pop cx
000001A4  53                push bx
000001A5  4D                dec bp
000001A6  53                push bx
000001A7  44                inc sp
000001A8  4F                dec di
000001A9  53                push bx
000001AA  2020              and [bx+si],ah
000001AC  205359            and [bp+di+0x59],dl
000001AF  53                push bx
000001B0  7F01              jg 0x1b3
000001B2  0041BB            add [bx+di-0x45],al
000001B5  0007              add [bx],al
000001B7  60                pushaw
000001B8  666A00            o32 push byte +0x0
000001BB  E93BFF            jmp word 0xf9
000001BE  0000              add [bx+si],al
