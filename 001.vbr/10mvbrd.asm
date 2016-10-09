00000000  EB3C              jmp short 0x3e
00000002  90                nop
00000003  4D                dec bp
00000004  53                push bx
00000005  57                push di
00000006  49                dec cx
00000007  4E                dec si
00000008  342E              xor al,0x2e
0000000A  3100              xor [bx+si],ax
0000000C  0208              add cl,[bx+si]
0000000E  0100              add [bx+si],ax
00000010  0200              add al,[bx+si]
00000012  02814EF8          add al,[bx+di-0x7b2]
00000016  0800              or [bx+si],al
00000018  3F                aas
00000019  0010              add [bx+si],dl
0000001B  003F              add [bx],bh
0000001D  0000              add [bx+si],al
0000001F  0000              add [bx+si],al
00000021  0000              add [bx+si],al
00000023  00800029          add [bx+si+0x2900],al
00000027  FA                cli
00000028  0D3B18            or ax,0x183b
0000002B  4E                dec si
0000002C  4F                dec di
0000002D  204E41            and [bp+0x41],cl
00000030  4D                dec bp
00000031  45                inc bp
00000032  2020              and [bx+si],ah
00000034  2020              and [bx+si],ah
00000036  46                inc si
00000037  41                inc cx
00000038  54                push sp
00000039  3132              xor [bp+si],si
0000003B  2020              and [bx+si],ah
0000003D  2033              and [bp+di],dh
0000003F  C9                leave
00000040  8ED1              mov ss,cx
00000042  BCFC7B            mov sp,0x7bfc
00000045  16                push ss
00000046  07                pop es
00000047  BD7800            mov bp,0x78
0000004A  C57600            lds si,[bp+0x0]
0000004D  1E                push ds
0000004E  56                push si
0000004F  16                push ss
00000050  55                push bp
00000051  BF2205            mov di,0x522
00000054  897E00            mov [bp+0x0],di
00000057  894E02            mov [bp+0x2],cx
0000005A  B10B              mov cl,0xb
0000005C  FC                cld
0000005D  F3A4              rep movsb
0000005F  06                push es
00000060  1F                pop ds
00000061  BD007C            mov bp,0x7c00
00000064  C645FE0F          mov byte [di-0x2],0xf
00000068  384E24            cmp [bp+0x24],cl
0000006B  7D20              jnl 0x8d
0000006D  8BC1              mov ax,cx
0000006F  99                cwd
00000070  E87E01            call word 0x1f1
00000073  83EB3A            sub bx,byte +0x3a
00000076  66A11C7C          mov eax,[0x7c1c]
0000007A  663B07            cmp eax,[bx]
0000007D  8A57FC            mov dl,[bx-0x4]
00000080  7506              jnz 0x88
00000082  80CA02            or dl,0x2
00000085  885602            mov [bp+0x2],dl
00000088  80C310            add bl,0x10
0000008B  73ED              jnc 0x7a
0000008D  33C9              xor cx,cx
0000008F  FE06D87D          inc byte [0x7dd8]
00000093  8A4610            mov al,[bp+0x10]
00000096  98                cbw
00000097  F76616            mul word [bp+0x16]
0000009A  03461C            add ax,[bp+0x1c]
0000009D  13561E            adc dx,[bp+0x1e]
000000A0  03460E            add ax,[bp+0xe]
000000A3  13D1              adc dx,cx
000000A5  8B7611            mov si,[bp+0x11]
000000A8  60                pushaw
000000A9  8946FC            mov [bp-0x4],ax
000000AC  8956FE            mov [bp-0x2],dx
000000AF  B82000            mov ax,0x20
000000B2  F7E6              mul si
000000B4  8B5E0B            mov bx,[bp+0xb]
000000B7  03C3              add ax,bx
000000B9  48                dec ax
000000BA  F7F3              div bx
000000BC  0146FC            add [bp-0x4],ax
000000BF  114EFE            adc [bp-0x2],cx
000000C2  61                popaw
000000C3  BF0007            mov di,0x700
000000C6  E82801            call word 0x1f1
000000C9  723E              jc 0x109
000000CB  382D              cmp [di],ch
000000CD  7417              jz 0xe6
000000CF  60                pushaw
000000D0  B10B              mov cl,0xb
000000D2  BED87D            mov si,0x7dd8
000000D5  F3A6              repe cmpsb
000000D7  61                popaw
000000D8  743D              jz 0x117
000000DA  4E                dec si
000000DB  7409              jz 0xe6
000000DD  83C720            add di,byte +0x20
000000E0  3BFB              cmp di,bx
000000E2  72E7              jc 0xcb
000000E4  EBDD              jmp short 0xc3
000000E6  FE0ED87D          dec byte [0x7dd8]
000000EA  7BA7              jpo 0x93
000000EC  BE7F7D            mov si,0x7d7f
000000EF  AC                lodsb
000000F0  98                cbw
000000F1  03F0              add si,ax
000000F3  AC                lodsb
000000F4  98                cbw
000000F5  40                inc ax
000000F6  740C              jz 0x104
000000F8  48                dec ax
000000F9  7413              jz 0x10e
000000FB  B40E              mov ah,0xe
000000FD  BB0700            mov bx,0x7
00000100  CD10              int 0x10
00000102  EBEF              jmp short 0xf3
00000104  BE827D            mov si,0x7d82
00000107  EBE6              jmp short 0xef
00000109  BE807D            mov si,0x7d80
0000010C  EBE1              jmp short 0xef
0000010E  CD16              int 0x16
00000110  5E                pop si
00000111  1F                pop ds
00000112  668F04            pop dword [si]
00000115  CD19              int 0x19
00000117  BE817D            mov si,0x7d81
0000011A  8B7D1A            mov di,[di+0x1a]
0000011D  8D45FE            lea ax,[di-0x2]
00000120  8A4E0D            mov cl,[bp+0xd]
00000123  F7E1              mul cx
00000125  0346FC            add ax,[bp-0x4]
00000128  1356FE            adc dx,[bp-0x2]
0000012B  B104              mov cl,0x4
0000012D  E8C200            call word 0x1f2
00000130  72D7              jc 0x109
00000132  EA00027000        jmp word 0x70:0x200
00000137  52                push dx
00000138  50                push ax
00000139  06                push es
0000013A  53                push bx
0000013B  6A01              push byte +0x1
0000013D  6A10              push byte +0x10
0000013F  91                xchg ax,cx
00000140  8B4618            mov ax,[bp+0x18]
00000143  A22605            mov [0x526],al
00000146  96                xchg ax,si
00000147  92                xchg ax,dx
00000148  33D2              xor dx,dx
0000014A  F7F6              div si
0000014C  91                xchg ax,cx
0000014D  F7F6              div si
0000014F  42                inc dx
00000150  87CA              xchg cx,dx
00000152  F7761A            div word [bp+0x1a]
00000155  8AF2              mov dh,dl
00000157  8AE8              mov ch,al
00000159  C0CC02            ror ah,byte 0x2
0000015C  0ACC              or cl,ah
0000015E  B80102            mov ax,0x201
00000161  807E020E          cmp byte [bp+0x2],0xe
00000165  7504              jnz 0x16b
00000167  B442              mov ah,0x42
00000169  8BF4              mov si,sp
0000016B  8A5624            mov dl,[bp+0x24]
0000016E  CD13              int 0x13
00000170  61                popaw
00000171  61                popaw
00000172  720A              jc 0x17e
00000174  40                inc ax
00000175  7501              jnz 0x178
00000177  42                inc dx
00000178  035E0B            add bx,[bp+0xb]
0000017B  49                dec cx
0000017C  7577              jnz 0x1f5
0000017E  C3                ret
0000017F  0318              add bx,[bx+si]
00000181  0127              add [bx],sp
00000183  0D0A49            or ax,0x490a
00000186  6E                outsb
00000187  7661              jna 0x1ea
00000189  6C                insb
0000018A  6964207379        imul sp,[si+0x20],word 0x7973
0000018F  7374              jnc 0x205
00000191  656D              gs insw
00000193  206469            and [si+0x69],ah
00000196  736B              jnc 0x203
00000198  FF0D              dec word [di]
0000019A  0A4469            or al,[si+0x69]
0000019D  736B              jnc 0x20a
0000019F  20492F            and [bx+di+0x2f],cl
000001A2  4F                dec di
000001A3  206572            and [di+0x72],ah
000001A6  726F              jc 0x217
000001A8  72FF              jc 0x1a9
000001AA  0D0A52            or ax,0x520a
000001AD  65706C            gs jo 0x21c
000001B0  61                popaw
000001B1  636520            arpl [di+0x20],sp
000001B4  7468              jz 0x21e
000001B6  65206469          and [gs:si+0x69],ah
000001BA  736B              jnc 0x227
000001BC  2C20              sub al,0x20
000001BE  61                popaw
000001BF  6E                outsb
000001C0  64207468          and [fs:si+0x68],dh
000001C4  656E              gs outsb
000001C6  207072            and [bx+si+0x72],dh
000001C9  657373            gs jnc 0x23f
000001CC  20616E            and [bx+di+0x6e],ah
000001CF  7920              jns 0x1f1
000001D1  6B65790D          imul sp,[di+0x79],byte +0xd
000001D5  0A00              or al,[bx+si]
000001D7  00494F            add [bx+di+0x4f],cl
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
000001EE  7F01              jg 0x1f1
000001F0  0041BB            add [bx+di-0x45],al
000001F3  0007              add [bx],al
000001F5  60                pushaw
000001F6  666A00            o32 push byte +0x0
000001F9  E93BFF            jmp word 0x137
000001FC  0000              add [bx+si],al
000001FE  55                push bp
000001FF  AA                stosb
