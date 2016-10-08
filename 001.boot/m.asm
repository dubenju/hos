C:\prj\001.boot>ndisasm m.bin
                            ;ORG 600
00000000  33C0              xor ax,ax     ; ax = 0
00000002  8ED0              mov ss,ax     ; ss = ax = 0
00000004  BC007C            mov sp,0x7c00 ; sp = 0x7c00
00000007  FB                sti
00000008  50                push ax
00000009  07                pop es        ; es = ax = 0;
0000000A  50                push ax
0000000B  1F                pop ds        ; ds = ax = 0;
0000000C  FC                cld
0000000D  BE1B7C            mov si,0x7c1b ; si = 0x7c1b
00000010  BF1B06            mov di,0x61b  ; di = 0x061b
00000013  50                push ax
00000014  57                push di
00000015  B9E501            mov cx,0x1e5  ; cx = 0x01e5 rep times
00000018  F3A4              rep movsb     ; es:di = ds:si
0000001A  CB                retf          ; pop ip, pop cs ip = di = 0x061b, cs = ax = 0

0000001B  BEBE07            mov si,0x7be
0000001E  B104              mov cl,0x4
lbl_20:   382C              cmp [si],ch
00000022  7C09              jl lbl_2d
00000024  7515              jnz lbl_3b
00000026  83C610            add si,byte +0x10
00000029  E2F5              loop lbl_20

0000002B  CD18              int 0x18

lbl_2d:   8B14              mov dx,[si]
0000002F  8BEE              mov bp,si
lbl_31:   83C610            add si,byte +0x10
00000034  49                dec cx
00000035  7416              jz lbl_4d
00000037  382C              cmp [si],ch
00000039  74F6              jz lbl_31
lbl_3b:   BE1007            mov si,0x710 ; ERROR
lbl_3E:   4E                dec si
lbl_3f:   AC                lodsb        ;al = [si]
00000040  3C00              cmp al,0x0
00000042  74FA              jz lbl_3e
00000044  BB0700            mov bx,0x7
00000047  B40E              mov ah,0xe
00000049  CD10              int 0x10
lbl_4b:   EBF2              jmp short lbl_3f

lbl_4D:   894625            mov [bp+0x25],ax
00000050  96                xchg ax,si
00000051  8A4604            mov al,[bp+0x4]
00000054  B406              mov ah,0x6
00000056  3C0E              cmp al,0xe
00000058  7411              jz lbl_6b
0000005A  B40B              mov ah,0xb
0000005C  3C0C              cmp al,0xc
0000005E  7405              jz lbl_65
00000060  3AC4              cmp al,ah
00000062  752B              jnz lbl_8f
00000064  40                inc ax
lbl_65:   C6462506          mov byte [bp+0x25],0x6
00000069  7524              jnz lbl_8f
lbl_6B:   BBAA55            mov bx,0x55aa
0000006E  50                push ax
0000006F  B441              mov ah,0x41
00000071  CD13              int 0x13
00000073  58                pop ax
00000074  7216              jc lbl_8c
00000076  81FB55AA          cmp bx,0xaa55
0000007A  7510              jnz lbl_8c
0000007C  F6C101            test cl,0x1
0000007F  740B              jz lbl_8c
00000081  8AE0              mov ah,al
00000083  885624            mov [bp+0x24],dl
00000086  C706A106EB1E      mov word [0x6a1],0x1eeb
lbl_8C:   886604            mov [bp+0x4],ah
lbl_8F:   BF0A00            mov di,0xa
lbl_92:   B80102            mov ax,0x201
00000095  8BDC              mov bx,sp
00000097  33C9              xor cx,cx
00000099  83FF05            cmp di,byte +0x5
0000009C  7F03              jg lbl_a1
0000009E  8B4E25            mov cx,[bp+0x25]
lbl_A1:   034E02            add cx,[bp+0x2]
000000A4  CD13              int 0x13
lbl_A6:   7229              jc lbl_d1
000000A8  BE4607            mov si,0x746
000000AB  813EFE7D55AA      cmp word [0x7dfe],0xaa55
000000B1  745A              jz lbl_10d
000000B3  83EF05            sub di,byte +0x5
000000B6  7FDA              jg lbl_92
lbl_B8:   85F6              test si,si
000000BA  7583              jnz lbl_3f
000000BC  BE2707            mov si,0x727
000000BF  EB8A              jmp short lbl_4b

000000C1  98                cbw
000000C2  91                xchg ax,cx
000000C3  52                push dx
000000C4  99                cwd
000000C5  034608            add ax,[bp+0x8]
000000C8  13560A            adc dx,[bp+0xa]
000000CB  E81200            call word sub_e0
000000CE  5A                pop dx
000000CF  EBD5              jmp short lbl_a6
lbl_D1:   4F                dec di
000000D2  74E4              jz lbl_b8
000000D4  33C0              xor ax,ax
000000D6  CD13              int 0x13
000000D8  EBB8              jmp short lbl_92

000000DA  0000              add [bx+si],al
000000DC  0000              add [bx+si],al
000000DE  0000              add [bx+si],al

sub_E0:   56                push si
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
000000FF  720A              jc lbl_10b
lbl_101:  40                inc ax
00000102  7501              jnz lbl_105
00000104  42                inc dx
lbl_105:  80C702            add bh,0x2
00000108  E2F7              loop lbl_101
0000010A  F8                clc
lbl_10B:  5E                pop si
0000010C  C3                ret

lbl_10D:  EB74              jmp short 0x183

Invalid partition table
Error loading operating system

0000010F  49                dec cx
00000110  6E                outsb
00000111  7661              jna 0x174
00000113  6C                insb
00000114  6964207061        imul sp,[si+0x20],word 0x6170
00000119  7274              jc 0x18f
0000011B  6974696F6E        imul si,[si+0x69],word 0x6e6f
00000120  207461            and [si+0x61],dh
00000123  626C65            bound bp,[si+0x65]
00000126  004572            add [di+0x72],al
00000129  726F              jc 0x19a
0000012B  7220              jc 0x14d
0000012D  6C                insb
0000012E  6F                outsw
0000012F  61                popaw
00000130  64696E67206F      imul bp,[fs:bp+0x67],word 0x6f20
00000136  7065              jo 0x19d
00000138  7261              jc 0x19b
0000013A  7469              jz 0x1a5
0000013C  6E                outsb
0000013D  67207379          and [ebx+0x79],dh
00000141  7374              jnc 0x1b7
00000143  656D              gs insw
00000145  004D69            add [di+0x69],cl
00000148  7373              jnc 0x1bd
0000014A  696E67206F        imul bp,[bp+0x67],word 0x6f20
0000014F  7065              jo 0x1b6
00000151  7261              jc 0x1b4
00000153  7469              jz 0x1be
00000155  6E                outsb
00000156  67207379          and [ebx+0x79],dh
0000015A  7374              jnc 0x1d0
0000015C  656D              gs insw

C:\prj\001.boot>