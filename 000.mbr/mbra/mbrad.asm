00000000  33C0              xor ax,ax
00000002  8ED0              mov ss,ax
00000004  BC007C            mov sp,0x7c00
00000007  FB                sti
00000008  50                push ax
00000009  07                pop es
0000000A  50                push ax
0000000B  1F                pop ds
0000000C  FC                cld
0000000D  BE1B5C            mov si,0x5c1b
00000010  BF1B06            mov di,0x61b
00000013  50                push ax
00000014  57                push di
00000015  B9E501            mov cx,0x1e5
00000018  F3A4              rep movsb
0000001A  CB                retf
0000001B  BDBE07            mov bp,0x7be
0000001E  B104              mov cl,0x4
00000020  386E00            cmp [bp+0x0],ch
00000023  7C09              jl 0x2e
00000025  7513              jnz 0x3a
00000027  83C510            add bp,byte +0x10
0000002A  E2F4              loop 0x20
0000002C  CD18              int 0x18
0000002E  8BF5              mov si,bp
00000030  83C610            add si,byte +0x10
00000033  49                dec cx
00000034  7419              jz 0x4f
00000036  382C              cmp [si],ch
00000038  74F6              jz 0x30
0000003A  A0B507            mov al,[0x7b5]
0000003D  B407              mov ah,0x7
0000003F  8BF0              mov si,ax
00000041  AC                lodsb
00000042  3C00              cmp al,0x0
00000044  74FC              jz 0x42
00000046  BB0700            mov bx,0x7
00000049  B40E              mov ah,0xe
0000004B  CD10              int 0x10
0000004D  EBF2              jmp short 0x41
0000004F  884E10            mov [bp+0x10],cl
00000052  E84600            call word 0x9b
00000055  732A              jnc 0x81
00000057  FE4610            inc byte [bp+0x10]
0000005A  807E040B          cmp byte [bp+0x4],0xb
0000005E  740B              jz 0x6b
00000060  807E040C          cmp byte [bp+0x4],0xc
00000064  7405              jz 0x6b
00000066  A0B607            mov al,[0x7b6]
00000069  75D2              jnz 0x3d
0000006B  80460206          add byte [bp+0x2],0x6
0000006F  83460806          add word [bp+0x8],byte +0x6
00000073  83560A00          adc word [bp+0xa],byte +0x0
00000077  E82100            call word 0x9b
0000007A  7305              jnc 0x81
0000007C  A0B607            mov al,[0x7b6]
0000007F  EBBC              jmp short 0x3d
00000081  813EFE7D55AA      cmp word [0x7dfe],0xaa55
00000087  740B              jz 0x94
00000089  807E1000          cmp byte [bp+0x10],0x0
0000008D  74C8              jz 0x57
0000008F  A0B707            mov al,[0x7b7]
00000092  EBA9              jmp short 0x3d
00000094  8BFC              mov di,sp
00000096  1E                push ds
00000097  57                push di
00000098  8BF5              mov si,bp
0000009A  CB                retf
0000009B  BF0500            mov di,0x5
0000009E  8A5600            mov dl,[bp+0x0]
000000A1  B408              mov ah,0x8
000000A3  CD13              int 0x13
000000A5  7223              jc 0xca
000000A7  8AC1              mov al,cl
000000A9  243F              and al,0x3f
000000AB  98                cbw
000000AC  8ADE              mov bl,dh
000000AE  8AFC              mov bh,ah
000000B0  43                inc bx
000000B1  F7E3              mul bx
000000B3  8BD1              mov dx,cx
000000B5  86D6              xchg dl,dh
000000B7  B106              mov cl,0x6
000000B9  D2EE              shr dh,cl
000000BB  42                inc dx
000000BC  F7E2              mul dx
000000BE  39560A            cmp [bp+0xa],dx
000000C1  7723              ja 0xe6
000000C3  7205              jc 0xca
000000C5  394608            cmp [bp+0x8],ax
000000C8  731C              jnc 0xe6
000000CA  B80102            mov ax,0x201
000000CD  BB007C            mov bx,0x7c00
000000D0  8B4E02            mov cx,[bp+0x2]
000000D3  8B5600            mov dx,[bp+0x0]
000000D6  CD13              int 0x13
000000D8  731C              jnc 0xf6
000000DA  B80102            mov ax,0x201
000000DD  BB007C            mov bx,0x7c00
000000E0  56                push si
000000E1  00CD              add ch,cl
000000E3  13EB              adc bp,bx
000000E5  E48A              in al,0x8a
000000E7  56                push si
000000E8  0060BB            add [bx+si-0x45],ah
000000EB  AA                stosb
000000EC  55                push bp
000000ED  B441              mov ah,0x41
000000EF  CD13              int 0x13
000000F1  7236              jc 0x129
000000F3  81FB55AA          cmp bx,0xaa55
000000F7  7530              jnz 0x129
000000F9  F6C101            test cl,0x1
000000FC  742B              jz 0x129
000000FE  61                popaw
000000FF  60                pushaw
00000100  6A00              push byte +0x0
00000102  6A00              push byte +0x0
00000104  FF760A            push word [bp+0xa]
00000107  FF7608            push word [bp+0x8]
0000010A  6A00              push byte +0x0
0000010C  8600              xchg al,[bx+si]
0000010E  7C6A              jl 0x17a
00000110  016A10            add [bp+si+0x10],bp
00000113  B442              mov ah,0x42
00000115  8BF4              mov si,sp
00000117  CD13              int 0x13
00000119  61                popaw
0000011A  61                popaw
0000011B  730E              jnc 0x12b
0000011D  4F                dec di
0000011E  740B              jz 0x12b
00000120  32E4              xor ah,ah
00000122  8A5600            mov dl,[bp+0x0]
00000125  CD13              int 0x13
00000127  EBD6              jmp short 0xff
00000129  61                popaw
0000012A  F9                stc
0000012B  C3                ret
0000012C  49                dec cx
0000012D  6E                outsb
0000012E  7661              jna 0x191
00000130  6C                insb
00000131  6964207061        imul sp,[si+0x20],word 0x6170
00000136  7274              jc 0x1ac
00000138  6974696F6E        imul si,[si+0x69],word 0x6e6f
0000013D  207461            and [si+0x61],dh
00000140  626C65            bound bp,[si+0x65]
00000143  004572            add [di+0x72],al
00000146  726F              jc 0x1b7
00000148  7220              jc 0x16a
0000014A  6C                insb
0000014B  6F                outsw
0000014C  61                popaw
0000014D  64696E67206F      imul bp,[fs:bp+0x67],word 0x6f20
00000153  7065              jo 0x1ba
00000155  7261              jc 0x1b8
00000157  7469              jz 0x1c2
00000159  6E                outsb
0000015A  67207379          and [ebx+0x79],dh
0000015E  7374              jnc 0x1d4
00000160  656D              gs insw
00000162  004D69            add [di+0x69],cl
00000165  7373              jnc 0x1da
00000167  696E67206F        imul bp,[bp+0x67],word 0x6f20
0000016C  7065              jo 0x1d3
0000016E  7261              jc 0x1d1
00000170  7469              jz 0x1db
00000172  6E                outsb
00000173  67207379          and [ebx+0x79],dh
00000177  7374              jnc 0x1ed
00000179  656D              gs insw
0000017B  0000              add [bx+si],al
0000017D  0000              add [bx+si],al
0000017F  0000              add [bx+si],al
00000181  0000              add [bx+si],al
00000183  0000              add [bx+si],al
00000185  0000              add [bx+si],al
00000187  0000              add [bx+si],al
00000189  0000              add [bx+si],al
0000018B  0000              add [bx+si],al
0000018D  0000              add [bx+si],al
0000018F  0000              add [bx+si],al
00000191  0000              add [bx+si],al
00000193  0000              add [bx+si],al
00000195  0000              add [bx+si],al
00000197  0000              add [bx+si],al
00000199  0000              add [bx+si],al
0000019B  0000              add [bx+si],al
0000019D  0000              add [bx+si],al
0000019F  0000              add [bx+si],al
000001A1  0000              add [bx+si],al
000001A3  0000              add [bx+si],al
000001A5  0000              add [bx+si],al
000001A7  0000              add [bx+si],al
000001A9  0000              add [bx+si],al
000001AB  0000              add [bx+si],al
000001AD  0000              add [bx+si],al
000001AF  0000              add [bx+si],al
000001B1  0000              add [bx+si],al
000001B3  0000              add [bx+si],al
000001B5  2C44              sub al,0x44
000001B7  6333              arpl [bp+di],si
000001B9  B133              mov cl,0x33
000001BB  B100              mov cl,0x0
000001BD  00800101          add [bx+si+0x101],al
000001C1  0007              add [bx],al
000001C3  FE                db 0xfe
000001C4  FF                db 0xff
000001C5  7B3F              jpo 0x206
000001C7  0000              add [bx+si],al
000001C9  03DA              add bx,dx
000001CB  8DA00000          lea sp,[bx+si+0x0]
000001CF  00C1              add cl,al
000001D1  7C0F              jl 0x1e2
000001D3  FE                db 0xfe
000001D4  FF                db 0xff
000001D5  FF                db 0xff
000001D6  7CA8              jl 0x180
000001D8  DA00              fiadd dword [bx+si]
000001DA  45                inc bp
000001DB  8F                db 0x8f
000001DC  1E                push ds
000001DD  0000              add [bx+si],al
000001DF  0000              add [bx+si],al
000001E1  0000              add [bx+si],al
000001E3  0000              add [bx+si],al
000001E5  0000              add [bx+si],al
000001E7  0000              add [bx+si],al
000001E9  0000              add [bx+si],al
000001EB  0000              add [bx+si],al
000001ED  0000              add [bx+si],al
000001EF  0000              add [bx+si],al
000001F1  0000              add [bx+si],al
000001F3  0000              add [bx+si],al
000001F5  0000              add [bx+si],al
000001F7  0000              add [bx+si],al
000001F9  0000              add [bx+si],al
000001FB  0000              add [bx+si],al
000001FD  0055AA            add [di-0x56],dl
