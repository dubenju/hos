; haribote-os boot asm
; TAB=4

[INSTRSET "i486p"]				; 486の命令まで使いたいという記述

;VBEMODE EQU 0x101 ;  640 x  480 x 8bit Color
VBEMODE EQU 0x111 ; 640 x  480 x 16bit Color
;  0x100 :  640 x  400 x 8bit Color
;  0x101 :  640 x  480 x 8bit Color
;  0x103 :  800 x  600 x 8bit Color
;  0x105 : 1024 x  768 x 8bit Color
;  0x107 : 1280 x 1024 x 8bit Color

;  0x111 :  640 x  480 x 16bit Color
;  0x114 :  800 x  600 x 16bit Color
;  0x117 : 1024 x  768 x 16bit Color
;  0x11A : 1280 x 1024 x 16bit Color

BOTPAK	EQU		0x00280000		; bootpackのロード先
DSKCAC	EQU		0x00100000		; ディスクキャッシュの場所
DSKCAC0	EQU		0x00000900		; ディスクキャッシュの場所（リアルモード）

; BOOT_INFO関係
CYLS	EQU		0x05f0			; ブートセクタが設定する
LEDS	EQU		0x05f1
VMODE	EQU		0x05f2			; 色数に関する情報。何ビットカラーか？
SCRNX	EQU		0x05f4			; 解像度のX
SCRNY	EQU		0x05f6			; 解像度のY
VRAM	EQU		0x05f8			; グラフィックバッファの開始番地

		ORG		0x0700			; このプログラムがどこに読み込まれるのか

		MOV		AX,0x9000
		MOV		ES,AX
		MOV		DI,0

		MOV		BYTE  [CYLS],1 

;Check VESA
		MOV		AX,0x4f00
		INT		10H
		CMP		AX,0x004f
;		JNE		scrn320
		JNE		scrn640

		MOV		AX,[ES:DI+4]
		CMP		AX,0x0200
;		JB		scrn320
		JB		scrn640

		MOV		CX,VBEMODE
		MOV		AX,0x4f01
		INT		10H
		CMP		AX,0x004f
;		JNE		scrn320
		JNE		scrn640


;    CMP		BYTE [ES:DI+0x19],8
		CMP		BYTE [ES:DI+0x19],16
;		JNE		scrn320
		JNE		scrn640
;    CMP		BYTE [ES:DI+0x1b],4
		CMP		BYTE [ES:DI+0x1b],6
;		JNE		scrn320
		JNE		scrn640
		MOV		AX,[ES:DI+0x00]
		AND		AX,0x0080
;		JZ		scrn320
		JZ		scrn640


		MOV		BX,VBEMODE+0x4000
		MOV		AX,0x4f02
		INT		10H
;    MOV		BYTE [VMODE],8
		MOV		BYTE [VMODE],16
		MOV		AX,[ES:DI+0x12]
		MOV		[SCRNX],AX
		MOV		AX,[ES:DI+0x14]
		MOV		[SCRNY],AX
		MOV		EAX, [ES:DI+0x28]
		MOV		[VRAM], EAX
		JMP		keystatus

scrn320:
		MOV		AL,0x13	
		MOV		AH,0x00
		INT		0x10
		MOV		BYTE [VMODE],8
		MOV		WORD [SCRNX],320
		MOV		WORD [SCRNY],240
		MOV		DWORD [VRAM],000A0000H
		JMP		keystatus

scrn640:
; 画面モードを設定

		MOV		AH, 00H
		MOV		AL, 13H			; VGAグラフィックス、13H：640×480 256色
		INT		10H
		MOV		BYTE [VMODE],8
		MOV		WORD [SCRNX],640
		MOV		WORD [SCRNY],480
		MOV		DWORD [VRAM],000A0000H

keystatus:


		MOV		AH,02H
		INT		16H			; keyboard BIOS
;H->L:Ins、Caps Lock、Num Lock、Scroll Lock、Alt、Ctrl、Left Shift、Right Shift
		MOV		[LEDS],AL  ; 05f1

; PICが一切の割り込みを受け付けないようにする
;	AT互換機の仕様では、PICの初期化をするなら、
;	こいつをCLI前にやっておかないと、たまにハングアップする
;	PICの初期化はあとでやる

		MOV		AL,0xff
		OUT		0x21,AL
		NOP						; OUT命令を連続させるとうまくいかない機種があるらしいので
		OUT		0xa1,AL

		CLI						; さらにCPUレベルでも割り込み禁止

; CPUから1MB以上のメモリにアクセスできるように、A20GATEを設定

;		CALL	waitkbdout
;		MOV		AL,0D1H
;		OUT		64H,AL
;		CALL	waitkbdout
;		MOV		AL,0DFH			; enable A20
;		OUT		60H,AL
;		CALL	waitkbdout

               IN  AL , 92H
               OR  AL , 02H     ; enable A20
		OUT 92H, AL

;    call check_a20
;    test ax, ax
;    mov ax, A20On
;    jnz Print           ; Enabled
;    mov ax, A20Off
; 
;Print:
;    mov bp, ax
;    mov cx, 16
;    mov ax, 0x1301
;    mov bx, 0x000c
;    mov dl, 0
;    int 0x10
;    
;    cli                 ; Shutdown
;    hlt
; 
;check_a20:
;    push ds
;    push es
;    push di
;    push si
; 
;    cli
; 
;    xor ax, ax ; ax = 0
;    mov es, ax
; 
;    not ax ; ax = 0xFFFF
;    mov ds, ax
; 
;    mov di, 0x0500
;    mov si, 0x0510
; 
;    mov al, byte [es:di]
;    push ax
; 
;    mov al, byte [ds:si]
;    push ax
; 
;    mov byte [es:di], 0x00
;    mov byte [ds:si], 0xFF
; 
;    cmp byte [es:di], 0xFF
; 
;    pop ax
;    mov byte [ds:si], al
; 
;    pop ax
;    mov byte [es:di], al
; 
;    mov ax, 0
;    je check_a20__exit
; 
;    mov ax, 1
; 
;check_a20__exit:
;    pop si
;    pop di
;    pop es
;    pop ds
; 
;    ret
; 
;A20On:
;    db "A20 is On        "
;A20Off:
;    db "A20 is Off       "
 

; プロテクトモード移行


		LGDT	[GDTR0]			; 暫定GDTを設定
		MOV		EAX,CR0
		AND		EAX,0x7fffffff	; bit31を0にする（ページング禁止のため）
		OR		EAX,0x00000001	; bit0を1にする（プロテクトモード移行のため）
		MOV		CR0,EAX
		JMP		pipelineflush
pipelineflush:
		MOV		AX,1*8			;  読み書き可能セグメント32bit
		MOV		DS,AX
		MOV		ES,AX
		MOV		FS,AX
		MOV		GS,AX
		MOV		SS,AX

; bootpackの転送

		MOV		ESI,bootpack	; 転送元
		MOV		EDI,BOTPAK	; 転送先 0x00280000
		MOV		ECX,512*1024/4
		CALL	memcpy

; ついでにディスクデータも本来の位置へ転送

; まずはブートセクタから

		MOV		ESI,0700H	; 転送元
		MOV		EDI,DSKCAC	; 転送先 0x00100000
		MOV		ECX,512/4
		CALL	memcpy

; 残り全部

		MOV		ESI,DSKCAC0+512	; 転送元 0x00008000 0x00000900
		MOV		EDI,DSKCAC +512	; 転送先 0x00100000
		MOV		ECX,0
		MOV		CL,BYTE [CYLS]
		IMUL	ECX,512*18*2/4	; シリンダ数からバイト数/4に変換
		SUB		ECX,512/4		; IPLの分だけ差し引く
		CALL	memcpy

;		HLT

; asmheadでしなければいけないことは全部し終わったので、
;	あとはbootpackに任せる

; bootpackの起動

		MOV		EBX,BOTPAK              ; 0x00280000
		MOV		ECX,[EBX+16]
		ADD		ECX,3			; ECX += 3;
		SHR		ECX,2			; ECX /= 4;
		JZ		skip			; 転送するべきものがない
		MOV		ESI,[EBX+20]	; 転送元
		ADD		ESI,EBX
		MOV		EDI,[EBX+12]	; 転送先
		CALL	memcpy
skip:
		MOV		ESP,[EBX+12]	; スタック初期値
		JMP		DWORD 2*8:0x0000001b

waitkbdout:
		IN		 AL,64H
		AND		 AL,02H
		JNZ		waitkbdout		; ANDの結果が0でなければwaitkbdoutへ
		RET

memcpy:
		MOV		EAX,[ESI]
		ADD		ESI,4
		MOV		[EDI],EAX
		ADD		EDI,4
		SUB		ECX,1
		JNZ		memcpy			; 引き算した結果が0でなければmemcpyへ
		RET
; memcpyはアドレスサイズプリフィクスを入れ忘れなければ、ストリング命令でも書ける

		ALIGNB	16
GDT0:
;		RESB	8				; ヌルセレクタ
;		DW		0xffff,0x0000,0x9200,0x00cf	; 読み書き可能セグメント32bit
;		DW		0xffff,0x0000,0x9a28,0x0047	; 実行可能セグメント32bit（bootpack用）
		DD 00000000H, 00000000H
		DD 0000FFFFH, 00CF9200H
		DD 0000FFFFH, 00479A28H


;Base	00000000
;Limit	FFFFF
;G	1
;D	1
;X	0
;U	0
;P	1
;DPL	0
;Type	9
;A	0
;Base	00280000
;Limit	7FFFF
;G	0
;D	1
;X	0
;U	0
;P	1
;DPL	0
;Type	D
;A	0


		DW		0
GDTR0:
		DW		8*3-1 ; limit 8 * n - 1
		DD		GDT0  ; base

		ALIGNB	16
bootpack:
