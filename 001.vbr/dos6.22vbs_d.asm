00000000  EB3C              jmp short 0x3e
00000002  90                nop
00000003  skipping 0x3B bytes
0000003E  FA                cli
0000003F  33C0              xor ax,ax
00000041  8ED0              mov ss,ax
00000043  BC007C            mov sp,0x7c00
00000046  16                push ss
00000047  07                pop es
00000048  BB7800            mov bx,0x78
0000004B  36C537            lds si,[ss:bx]
0000004E  1E                push ds
0000004F  56                push si
00000050  16                push ss
00000051  53                push bx
00000052  BF3E7C            mov di,0x7c3e
00000055  B90B00            mov cx,0xb
00000058  FC                cld
00000059  F3A4              rep movsb
0000005B  06                push es
0000005C  1F                pop ds
0000005D  C645FE0F          mov byte [di-0x2],0xf
00000061  8B0E187C          mov cx,[0x7c18]
00000065  884DF9            mov [di-0x7],cl
00000068  894702            mov [bx+0x2],ax
0000006B  C7073E7C          mov word [bx],0x7c3e
0000006F  FB                sti
00000070  CD13              int 0x13
00000072  7279              jc 0xed
00000074  33C0              xor ax,ax
00000076  3906137C          cmp [0x7c13],ax
0000007A  7408              jz 0x84
0000007C  8B0E137C          mov cx,[0x7c13]
00000080  890E207C          mov [0x7c20],cx
00000084  A0107C            mov al,[0x7c10]
00000087  F726167C          mul word [0x7c16]
0000008B  03061C7C          add ax,[0x7c1c]
0000008F  13161E7C          adc dx,[0x7c1e]
00000093  03060E7C          add ax,[0x7c0e]
00000097  83D200            adc dx,byte +0x0
0000009A  A3507C            mov [0x7c50],ax
0000009D  8916527C          mov [0x7c52],dx
000000A1  A3497C            mov [0x7c49],ax
000000A4  89164B7C          mov [0x7c4b],dx
000000A8  B82000            mov ax,0x20
000000AB  F726117C          mul word [0x7c11]
000000AF  8B1E0B7C          mov bx,[0x7c0b]
000000B3  03C3              add ax,bx
000000B5  48                dec ax
000000B6  F7F3              div bx
000000B8  0106497C          add [0x7c49],ax
000000BC  83164B7C00        adc word [0x7c4b],byte +0x0
000000C1  BB0005            mov bx,0x500
000000C4  8B16527C          mov dx,[0x7c52]
000000C8  A1507C            mov ax,[0x7c50]
000000CB  E89200            call word 0x160
000000CE  721D              jc 0xed
000000D0  B001              mov al,0x1
000000D2  E8AC00            call word 0x181
000000D5  7216              jc 0xed
000000D7  8BFB              mov di,bx
000000D9  B90B00            mov cx,0xb
000000DC  BEE67D            mov si,0x7de6
000000DF  F3A6              repe cmpsb
000000E1  750A              jnz 0xed
000000E3  8D7F20            lea di,[bx+0x20]
000000E6  B90B00            mov cx,0xb
000000E9  F3A6              repe cmpsb
000000EB  7418              jz 0x105
000000ED  BE9E7D            mov si,0x7d9e
000000F0  E85F00            call word 0x152
000000F3  33C0              xor ax,ax
000000F5  CD16              int 0x16
000000F7  5E                pop si
000000F8  1F                pop ds
000000F9  8F04              pop word [si]
000000FB  8F4402            pop word [si+0x2]
000000FE  CD19              int 0x19
00000100  58                pop ax
00000101  58                pop ax
00000102  58                pop ax
00000103  EBE8              jmp short 0xed
00000105  8B471A            mov ax,[bx+0x1a]
00000108  48                dec ax
00000109  48                dec ax
0000010A  8A1E0D7C          mov bl,[0x7c0d]
0000010E  32FF              xor bh,bh
00000110  F7E3              mul bx
00000112  0306497C          add ax,[0x7c49]
00000116  13164B7C          adc dx,[0x7c4b]
0000011A  BB0007            mov bx,0x700
0000011D  B90300            mov cx,0x3
00000120  50                push ax
00000121  52                push dx
00000122  51                push cx
00000123  E83A00            call word 0x160
00000126  72D8              jc 0x100
00000128  B001              mov al,0x1
0000012A  E85400            call word 0x181
0000012D  59                pop cx
0000012E  5A                pop dx
0000012F  58                pop ax
00000130  72BB              jc 0xed
00000132  050100            add ax,0x1
00000135  83D200            adc dx,byte +0x0
00000138  031E0B7C          add bx,[0x7c0b]
0000013C  E2E2              loop 0x120
0000013E  8A2E157C          mov ch,[0x7c15]
00000142  8A16247C          mov dl,[0x7c24]
00000146  8B1E497C          mov bx,[0x7c49]
0000014A  A14B7C            mov ax,[0x7c4b]
0000014D  EA00007000        jmp word 0x70:0x0
00000152  AC                lodsb
00000153  0AC0              or al,al
00000155  7429              jz 0x180
00000157  B40E              mov ah,0xe
00000159  BB0700            mov bx,0x7
0000015C  CD10              int 0x10
0000015E  EBF2              jmp short 0x152
00000160  3B16187C          cmp dx,[0x7c18]
00000164  7319              jnc 0x17f
00000166  F736187C          div word [0x7c18]
0000016A  FEC2              inc dl
0000016C  88164F7C          mov [0x7c4f],dl
00000170  33D2              xor dx,dx
00000172  F7361A7C          div word [0x7c1a]
00000176  8816257C          mov [0x7c25],dl
0000017A  A34D7C            mov [0x7c4d],ax
0000017D  F8                clc
0000017E  C3                ret
0000017F  F9                stc
00000180  C3                ret
00000181  B402              mov ah,0x2
00000183  8B164D7C          mov dx,[0x7c4d]
00000187  B106              mov cl,0x6
00000189  D2E6              shl dh,cl
0000018B  0A364F7C          or dh,[0x7c4f]
0000018F  8BCA              mov cx,dx
00000191  86E9              xchg ch,cl
00000193  8A16247C          mov dl,[0x7c24]
00000197  8A36257C          mov dh,[0x7c25]
0000019B  CD13              int 0x13
0000019D  C3                ret
0000019E  skipping 0x62 bytes
