00007C3E  33C9              xor cx,cx
00007C40  8ED1              mov ss,cx
00007C42  BCFC7B            mov sp,0x7bfc
00007C45  16                push ss
00007C46  07                pop es
00007C47  BD7800            mov bp,0x78
00007C4A  C57600            lds si,[bp+0x0]
00007C4D  1E                push ds
00007C4E  56                push si
00007C4F  16                push ss
00007C50  55                push bp
00007C51  BF2205            mov di,0x522
00007C54  897E00            mov [bp+0x0],di
00007C57  894E02            mov [bp+0x2],cx
00007C5A  B10B              mov cl,0xb
00007C5C  FC                cld
00007C5D  F3A4              rep movsb
00007C5F  06                push es
00007C60  1F                pop ds
00007C61  BD007C            mov bp,0x7c00
00007C64  C645FE0F          mov byte [di-0x2],0xf
00007C68  384E24            cmp [bp+0x24],cl
00007C6B  7D20              jnl 0x7c8d
00007C6D  8BC1              mov ax,cx
00007C6F  99                cwd
00007C70  E87E01            call word 0x7df1
00007C73  83EB3A            sub bx,byte +0x3a
00007C76  66A11C7C          mov eax,[0x7c1c]
00007C7A  663B07            cmp eax,[bx]
00007C7D  8A57FC            mov dl,[bx-0x4]
00007C80  7506              jnz 0x7c88
00007C82  80CA02            or dl,0x2
00007C85  885602            mov [bp+0x2],dl
00007C88  80C310            add bl,0x10
00007C8B  73ED              jnc 0x7c7a
00007C8D  33C9              xor cx,cx
00007C8F  FE06D87D          inc byte [0x7dd8]
00007C93  8A4610            mov al,[bp+0x10]
00007C96  98                cbw
00007C97  F76616            mul word [bp+0x16]
00007C9A  03461C            add ax,[bp+0x1c]
00007C9D  13561E            adc dx,[bp+0x1e]
00007CA0  03460E            add ax,[bp+0xe]
00007CA3  13D1              adc dx,cx
00007CA5  8B7611            mov si,[bp+0x11]
00007CA8  60                pushaw
00007CA9  8946FC            mov [bp-0x4],ax
00007CAC  8956FE            mov [bp-0x2],dx
00007CAF  B82000            mov ax,0x20
00007CB2  F7E6              mul si
00007CB4  8B5E0B            mov bx,[bp+0xb]
00007CB7  03C3              add ax,bx
00007CB9  48                dec ax
00007CBA  F7F3              div bx
00007CBC  0146FC            add [bp-0x4],ax
00007CBF  114EFE            adc [bp-0x2],cx
00007CC2  61                popaw
00007CC3  BF0007            mov di,0x700
00007CC6  E82801            call word 0x7df1
00007CC9  723E              jc 0x7d09
00007CCB  382D              cmp [di],ch
00007CCD  7417              jz 0x7ce6
00007CCF  60                pushaw
00007CD0  B10B              mov cl,0xb
00007CD2  BED87D            mov si,0x7dd8
00007CD5  F3A6              repe cmpsb
00007CD7  61                popaw
00007CD8  743D              jz 0x7d17
00007CDA  4E                dec si
00007CDB  7409              jz 0x7ce6
00007CDD  83C720            add di,byte +0x20
00007CE0  3BFB              cmp di,bx
00007CE2  72E7              jc 0x7ccb
00007CE4  EBDD              jmp short 0x7cc3
00007CE6  FE0ED87D          dec byte [0x7dd8]
00007CEA  7BA7              jpo 0x7c93
00007CEC  BE7F7D            mov si,0x7d7f
00007CEF  AC                lodsb
00007CF0  98                cbw
00007CF1  03F0              add si,ax
00007CF3  AC                lodsb
00007CF4  98                cbw
00007CF5  40                inc ax
00007CF6  740C              jz 0x7d04
00007CF8  48                dec ax
00007CF9  7413              jz 0x7d0e
00007CFB  B40E              mov ah,0xe
00007CFD  BB0700            mov bx,0x7
00007D00  CD10              int 0x10
00007D02  EBEF              jmp short 0x7cf3
00007D04  BE827D            mov si,0x7d82
00007D07  EBE6              jmp short 0x7cef
00007D09  BE807D            mov si,0x7d80
00007D0C  EBE1              jmp short 0x7cef
00007D0E  CD16              int 0x16
00007D10  5E                pop si
00007D11  1F                pop ds
00007D12  668F04            pop dword [si]
00007D15  CD19              int 0x19
00007D17  BE817D            mov si,0x7d81
00007D1A  8B7D1A            mov di,[di+0x1a]
00007D1D  8D45FE            lea ax,[di-0x2]
00007D20  8A4E0D            mov cl,[bp+0xd]
00007D23  F7E1              mul cx
00007D25  0346FC            add ax,[bp-0x4]
00007D28  1356FE            adc dx,[bp-0x2]
00007D2B  B104              mov cl,0x4
00007D2D  E8C200            call word 0x7df2
00007D30  72D7              jc 0x7d09
00007D32  EA00027000        jmp word 0x70:0x200
00007D37  52                push dx
00007D38  50                push ax
00007D39  06                push es
00007D3A  53                push bx
00007D3B  6A01              push byte +0x1
00007D3D  6A10              push byte +0x10
00007D3F  91                xchg ax,cx
00007D40  8B4618            mov ax,[bp+0x18]
00007D43  A22605            mov [0x526],al
00007D46  96                xchg ax,si
00007D47  92                xchg ax,dx
00007D48  33D2              xor dx,dx
00007D4A  F7F6              div si
00007D4C  91                xchg ax,cx
00007D4D  F7F6              div si
00007D4F  42                inc dx
00007D50  87CA              xchg cx,dx
00007D52  F7761A            div word [bp+0x1a]
00007D55  8AF2              mov dh,dl
00007D57  8AE8              mov ch,al
00007D59  C0CC02            ror ah,byte 0x2
00007D5C  0ACC              or cl,ah
00007D5E  B80102            mov ax,0x201
00007D61  807E020E          cmp byte [bp+0x2],0xe
00007D65  7504              jnz 0x7d6b
00007D67  B442              mov ah,0x42
00007D69  8BF4              mov si,sp
00007D6B  8A5624            mov dl,[bp+0x24]
00007D6E  CD13              int 0x13
00007D70  61                popaw
00007D71  61                popaw
00007D72  720A              jc 0x7d7e
00007D74  40                inc ax
00007D75  7501              jnz 0x7d78
00007D77  42                inc dx
00007D78  035E0B            add bx,[bp+0xb]
00007D7B  49                dec cx
00007D7C  7577              jnz 0x7df5
00007D7E  C3                ret
00007D7F  0318              add bx,[bx+si]
00007D81  0127              add [bx],sp
