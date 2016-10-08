	jmp short LBL_3e
	nop
                        DB "MSWIN4.1"
The standard BPB for FAT16
BytesPerSector          DW 0200
SectorsPerCluster       DB 04
ReservedSectors         DD 0001
FatCopies               DB 02
RootDirEntries          DW 0200
NumSectors              DW FFB1
MediaType               DB F8
SectorsPerFAT           DW 0040
SectorsPerTrack         DW 003F
NumberOfHeads           DW 0010
HiddenSectors           DD 0000003F
SectorsBig              DD 00000000

Extended BPB for FAT16 Volumes
Physical Drive Number   DB 80	;0x24
Reserved                DB 00
Extended_Boot_Signature DB 29
Volume_Serial_Number    DD 326C0DE6
Volume_Label            DB "NO NAME    "
File_System_Type        DB "FAT16   "

LBL_3e:
	xor cx,cx	;CX = 0
	mov ss,cx	;SS = CX
	mov sp,0x7bfc	;SP = 7BFC
	push ss
	pop es		;ES = SS
	mov bp,0x78	;BP = 0x0078
	lds si,[bp+0x00] ;SET DS,SI
	push ds
	push si
	push ss
	push bp

	mov di,0x0522
	mov [bp+0x00],di
	mov [bp+0x02],cx
	mov cl,0x0B
	cld
	rep movsb
	push es
	pop ds
	mov bp,0x7C00
	mov byte [di-0x02],0x0F
	cmp [bp+0x24],cl   	;80H
	jnl LBL_4f
	mov ax,cx
	cwd
	call word 0x1b3<X>
	sub bx,byte +0x3a
	mov eax,[0x7C1C]
LBL_3c:
	cmp eax,[bx]
	mov dl,[bx-0x04]
	jnz LBL_4a
	or dl,0x02
	mov [bp+0x02],dl
LBL_4a:
	add bl,0x10
	jnc 0x3c
LBL_4f:
	xor cx,cx		; CX = 0
	inc byte [0x7DD8]
LBL_55:
	mov al,[bp+0x10]
	cbw
	mul word [bp+0x16]
	add ax,[bp+0x1c]
	adc dx,[bp+0x1e]
	add ax,[bp+0x0e]
	adc dx,cx
	mov si,[bp+0x11]

	pushaw
	mov [bp-0x04],ax
	mov [bp-0x02],dx
	mov ax,0x20
	mul si
	mov bx,[bp+0xb]
	add ax,bx
	dec ax
	div bx
	add [bp-0x04],ax
	adc [bp-0x02],cx
	popaw

LBL_85:
	mov di,0x700
	call word 0x1b3<X>
	jc LBL_cb
LBL_8d:
	cmp [di],ch
	jz LBL_a8
	pushaw
	mov cl,0xb
	mov si,0x7dd8
	repe cmpsb
	popaw
	jz LBL_d9
	dec si
	jz LBL_a8
	add di,byte +0x20
	cmp di,bx
	jc LBL_8d
	jmp short LBL_85
LBL_a8:
	dec byte [0x7dd8]
	jpo LBL_55
	mov si,0x7d7f
LBL_b1:
	lodsb
	cbw
	add si,ax
LBL_b5:
	LOSB
	CBW
	INC AX
	JZ LBL_c6
	DEC AX
	JZ LBL_d0
;AL=Character
;BH=PageNumber
;BL=Color
	MOV AH,0x0E
	MOV BX,0x0007
	INT 0x10
	JMP short LBL_b5
LBL_c6:
	mov si,0x7d82
	jmp short LBL_b1
LBL_cb:
	mov si,0x7d80
	jmp short LBL_b1
LBL_d0:
;KeyBoard
	int 0x16
	pop si
	pop ds
	pop dword [si]
	int 0x19
LBL_d9:
	mov si,0x7d81
	mov di,[di+0x1a]
	lea ax,[di-0x02]
	mov cl,[bp+0x0d]
	mul cx
	add ax,[bp-0x04]
	adc dx,[bp-0x02]
	mov cl,0x4
	call word 0x1b4<X>
	jc LBL_cb
	jmp word 0x0070:0x0200
LBL_f9:
	push dx
	push ax
	push es
	push bx
	push byte +0x1
	push byte +0x10
	xchg ax,cx
	mov ax,[bp+0x18]
	mov [0x526],al
	xchg ax,si
	xchg ax,dx
	xor dx,dx
	div si
	xchg ax,cx
	div si
	inc dx
	xchg cx,dx
	div word [bp+0x1a]
	mov dh,dl
	mov ch,al
	ror ah,0x2
	or cl,ah
	mov ax,0x201
	cmp byte [bp+0x02],0x0e
	jnz LBL_12d
	mov ah,0x42
	mov si,sp
LBL_12d:
	mov dl,[bp+0x24]
	int 0x13
	popaw
	popaw
	jc LBL_140
	inc ax
	jnz 0x13a
	inc dx
	add bx,[bp+0xb]
	dec cx
	jnz LBL_1b7
LBL_140:
	ret
	add bx,[bx+si]
	add [bx],sp

	or ax,0x490a
	outsb
	jna 0x1ac
	insb
	imul sp,[si+0x20],word 0x7973
	jnc 0x1c7
	gs insw
	and [si+0x69],ah
	jnc 0x1c5
	dec word [di]
	or al,[si+0x69]
	jnc 0x1cc
	and [bx+di+0x2f],cl
	dec di
	and [di+0x72],ah
	jc 0x1d9
	jc 0x16b
	or ax,0x520a
	gs jo 0x1de
	popaw
	arpl [di+0x20],sp
	jz 0x1e0
	and [gs:si+0x69],ah
	jnc 0x1e9
	sub al,0x20
	popaw
	outsb
	and [fs:si+0x68],dh
LBL_1835:
msg1 db "Invalid system disk"
msg2 db "Disk I/O error"
msg3 db "Replace the disk, and then press any key"

db "IO      SYS"
db "MSDOS   SYS"

000001B0  7F01              jg 0x1b3
	add [bx+di-0x45],al
	add [bx],al
LBL_1b7:
	pushaw
	push dword 0x0
	jmp word 0xf9
	add [bx+si],al
