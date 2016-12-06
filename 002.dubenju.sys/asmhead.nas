; haribote-os boot asm
; TAB=4

[INSTRSET "i486p"]				; 486の命令まで使いたいという記述

;VBEMODE EQU 0x101 ;  640 x  480 x 8bit Color
VBEMODE EQU 0x111
;VBEMODE EQU 0x111 ; 640 x  480 x 16bit Color
;  0x100 :  640 x  400 x 8bit Color
;  0x101 :  640 x  480 x 8bit Color
;  0x103 :  800 x  600 x 8bit Color
;  0x105 : 1024 x  768 x 8bit Color
;  0x107 : 1280 x 1024 x 8bit Color

;  0x111 :  640 x  480 x 16bit Color
;  0x114 :  800 x  600 x 16bit Color
;  0x117 : 1024 x  768 x 16bit Color
;  0x11A : 1280 x 1024 x 16bit Color

;#00083
;Values for VESA video mode:
; 00h-FFh OEM video modes (see #00010 at AH=00h)
; 100h	640x400x256
; 101h	640x480x256
; 102h	800x600x16
; 103h	800x600x256
; 104h	1024x768x16
; 105h	1024x768x256
; 106h	1280x1024x16
; 107h	1280x1024x256
; 108h	80x60 text
; 109h	132x25 text
; 10Ah	132x43 text
; 10Bh	132x50 text
; 10Ch	132x60 text
;---VBE v1.2+ ---
; 10Dh	320x200x32K
; 10Eh	320x200x64K
; 10Fh	320x200x16M
; 110h	640x480x32K
; 111h	640x480x64K
; 112h	640x480x16M
; 113h	800x600x32K
; 114h	800x600x64K
; 115h	800x600x16M
; 116h	1024x768x32K
; 117h	1024x768x64K
; 118h	1024x768x16M
; 119h	1280x1024x32K (1:5:5:5)
; 11Ah	1280x1024x64K (5:6:5)
; 11Bh	1280x1024x16M
;---VBE 2.0+ ---
; 120h	1600x1200x256
; 121h	1600x1200x32K
; 122h	1600x1200x64K
;81FFh	special full-memory access mode
;Notes:	the special mode 81FFh preserves the contents of the video memory and
;	  gives access to all of the memory; VESA recommends that the special
;	  mode be a packed-pixel mode.	For VBE 2.0+, it is required that the
;	  VBE implement the mode, but not place it in the list of available
;	  modes (mode information for this mode can be queried directly,
;	  however).
;	as of VBE 2.0, VESA will no longer define video mode numbers


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
		MOV		BYTE  [CYLS],1 

;INT 10 - VESA SuperVGA BIOS (VBE) - GET SuperVGA INFORMATION
;	AX = 4F00h
;	ES:DI -> buffer for SuperVGA information (see #00077)
;Return: AL = 4Fh if function supported
;	AH = status
;	    00h successful
;		ES:DI buffer filled
;	    01h failed
;	    ---VBE v2.0---
;	    02h function not supported by current hardware configuration
;	    03h function invalid in current video mode
;Desc:	determine whether VESA BIOS extensions are present and the capabilities
;	  supported by the display adapter
;SeeAlso: AX=4E00h,AX=4F01h,AX=7F00h"SOLLEX",AX=A00Ch
;Index:	installation check;VESA SuperVGA


;#00077
;Format of SuperVGA information:
;Offset	Size	Description	)
; 00h  4 BYTEs	(ret) signature ("VESA")
;		(call) VESA 2.0 request signature ("VBE2"), required to receive
;		  version 2.0 info
; 04h	WORD	VESA version number (one-digit minor version -- 0102h = v1.2)
; 06h	DWORD	pointer to OEM name
;		"761295520" for ATI
; 0Ah	DWORD	capabilities flags (see #00078)
; 0Eh	DWORD	pointer to list of supported VESA and OEM video modes
;		(list of words terminated with FFFFh)
; 12h	WORD	total amount of video memory in 64K blocks
;---VBE v1.x ---
; 14h 236 BYTEs	reserved
;---VBE v2.0 ---
; 14h	WORD	OEM software version (BCD, high byte = major, low byte = minor)
; 16h	DWORD	pointer to vendor name
; 1Ah	DWORD	pointer to product name
; 1Eh	DWORD	pointer to product revision string
; 22h	WORD	(if capabilities bit 3 set) VBE/AF version (BCD)
;		0100h for v1.0P
; 24h	DWORD	(if capabilities bit 3 set) pointer to list of supported
;		  accelerated video modes (list of words terminated with FFFFh)
; 28h 216 BYTEs	reserved for VBE implementation
;100h 256 BYTEs	OEM scratchpad (for OEM strings, etc.)
;Notes:	the list of supported video modes is stored in the reserved portion of
;	  the SuperVGA information record by some implementations, and it may
;	  thus be necessary to either copy the mode list or use a different
;	  buffer for all subsequent VESA calls
;	not all of the video modes in the list of mode numbers may be
;	  supported, e.g. if they require more memory than currently installed
;	  or are not supported by the attached monitor.	 Check any mode you
;	  intend to use through AX=4F01h first.
;	the 1.1 VESA document specifies 242 reserved bytes at the end, so the
;	  buffer should be 262 bytes to ensure that it is not overrun; for
;	  v2.0, the buffer should be 512 bytes
;	the S3 specific video modes will most likely follow the FFFFh
;	  terminator at the end of the standard modes.	A search must then
;	  be made to find them, FFFFh will also terminate this second list
;	in some cases, only a "stub" VBE may be present, supporting only
;	  AX=4F00h; this case may be assumed if the list of supported video
;	  modes is empty (consisting of a single word of FFFFh)


		MOV		AX,9000H
		MOV		ES,AX
		MOV		DI,0000H
;Check VESA
		MOV		AX,4F00H
		INT		10H
		CMP		AX,004FH
;		JNE		scrn320
		JNE		scrn640 ; <>

;successful

		MOV		AX,[ES:DI+04H] ; VESA version number
		CMP		AX,0200H
;		JB		scrn320
		JB		scrn640 ; < 2.00

;INT 10 - VESA SuperVGA BIOS - GET SuperVGA MODE INFORMATION
;
;	AX = 4F01h
;	CX = SuperVGA video mode (see #04082 for bitfields)
;	ES:DI -> 256-byte buffer for mode information (see #00079)
;Return: AL = 4Fh if function supported
;	AH = status
;	    00h successful
;		ES:DI buffer filled
;	    01h failed
;Desc:	determine the attributes of the specified video mode

;#04082
;Bitfields for VESA/VBE video mode number:
;Bit(s)	Description	)
; 15	preserve display memory on mode change
; 14	(VBE v2.0+) use linear (flat) frame buffer
; 13	(VBE/AF 1.0P) VBE/AF initializes accelerator hardware
; 12	reserved for VBE/AF
; 11	(VBE v3.0) user user-specified CRTC refresh rate values
; 10-9	reserved for future expansion
; 8-0	video mode number (0xxh are non-VESA modes, 1xxh are VESA-defined)

;#00079
;Format of VESA SuperVGA mode information:
;Offset	Size	Description	)
; 00h	WORD	mode attributes (see #00080)
; 02h	BYTE	window attributes, window A (see #00081)
; 03h	BYTE	window attributes, window B (see #00081)
; 04h	WORD	window granularity in KB
; 06h	WORD	window size in KB
; 08h	WORD	start segment of window A (0000h if not supported)
; 0Ah	WORD	start segment of window B (0000h if not supported)
; 0Ch	DWORD	-> FAR window positioning function (equivalent to AX=4F05h)
; 10h	WORD	bytes per scan line
;---remainder is optional for VESA modes in v1.0/1.1, needed for OEM modes---
; 12h	WORD	width in pixels (graphics) or characters (text)
; 14h	WORD	height in pixels (graphics) or characters (text)
; 16h	BYTE	width of character cell in pixels
; 17h	BYTE	height of character cell in pixels
; 18h	BYTE	number of memory planes
; 19h	BYTE	number of bits per pixel
; 1Ah	BYTE	number of banks
; 1Bh	BYTE	memory model type (see #00082)
; 1Ch	BYTE	size of bank in KB
; 1Dh	BYTE	number of image pages (less one) that will fit in video RAM
; 1Eh	BYTE	reserved (00h for VBE 1.0-2.0, 01h for VBE 3.0)
;---VBE v1.2+ ---
; 1Fh	BYTE	red mask size
; 20h	BYTE	red field position
; 21h	BYTE	green mask size
; 22h	BYTE	green field size
; 23h	BYTE	blue mask size
; 24h	BYTE	blue field size
; 25h	BYTE	reserved mask size
; 26h	BYTE	reserved mask position
; 27h	BYTE	direct color mode info
;		bit 0: color ramp is programmable
;		bit 1: bytes in reserved field may be used by application
;---VBE v2.0+ ---
; 28h	DWORD	physical address of linear video buffer
; 2Ch	DWORD	pointer to start of offscreen memory
; 30h	WORD	KB of offscreen memory
;---VBE v3.0 ---
; 32h	WORD	bytes per scan line in linear modes
; 34h	BYTE	number of images (less one) for banked video modes
; 35h	BYTE	number of images (less one) for linear video modes
; 36h	BYTE	linear modes: size of direct color red mask (in bits)
; 37h	BYTE	linear modes: bit position of red mask LSB (e.g. shift count)
; 38h	BYTE	linear modes: size of direct color green mask (in bits)
; 39h	BYTE	linear modes: bit position of green mask LSB (e.g. shift count)
; 3Ah	BYTE	linear modes: size of direct color blue mask (in bits)
; 3Bh	BYTE	linear modes: bit position of blue mask LSB (e.g. shift count)
; 3Ch	BYTE	linear modes: size of direct color reserved mask (in bits)
; 3Dh	BYTE	linear modes: bit position of reserved mask LSB
; 3Eh	DWORD	maximum pixel clock for graphics video mode, in Hz
; 42h 190 BYTEs	reserved (0)
;Note:	while VBE 1.1 and higher will zero out all unused bytes of the buffer,
;	  v1.0 did not, so applications that want to be backward compatible
;	  should clear the buffer before calling


		MOV		CX, VBEMODE
		MOV		AX, 4F01H
		INT		10H
		CMP		AX, 004FH
;		JNE		scrn320
		JNE		scrn640 ; <>

; successful

;		CMP		BYTE [ES:DI+0x19],8   ;number of bits per pixel
		CMP		BYTE [ES:DI+0x19],16
;		JNE		scrn320
		JNE		scrn640 ; <> 16 bit

;#00082
;Values for VESA SuperVGA memory model type:
; 00h	text
; 01h	CGA graphics
; 02h	HGC graphics
; 03h	16-color (EGA) graphics
; 04h	packed pixel graphics
; 05h	"sequ 256" (non-chain 4) graphics
; 06h	direct color (HiColor, 24-bit color)
; 07h	YUV (luminance-chrominance, also called YIQ)
; 08h-0Fh reserved for VESA
; 10h-FFh OEM memory models

;		CMP		BYTE [ES:DI+0x1b],04H   ; memory model type (see #00082)
		CMP		BYTE [ES:DI+0x1b],06H
;		JNE		scrn320
		JNE		scrn640 ; <> 06h

;#00080
;Bitfields for VESA SuperVGA mode attributes:
;Bit(s)	Description	)
; 0	mode supported by present hardware configuration
; 1	optional information available (must be =1 for VBE v1.2+)
; 2	BIOS output supported
; 3	set if color, clear if monochrome
; 4	set if graphics mode, clear if text mode
;---VBE v2.0+ ---
; 5	mode is not VGA-compatible
; 6	bank-switched mode not supported
; 7	linear framebuffer mode supported
; 8	double-scan mode available (e.g. 320x200 and 320x240)
;---VBE v3.0 ---
; 9	interlaced mode available
; 10	hardware supports triple buffering
; 11	hardware supports stereoscopic display
; 12	dual display start address support
; 13-15	reserved
;---VBE/AF v1.0P---
; 9	application must call EnableDirectAccess before calling bank-switching
;	  functions

		MOV		AX,[ES:DI+00H]          ; mode attributes (see #00080)
		AND		AX,0080H                ; linear framebuffer mode supported
;		JZ		scrn320
		JZ		scrn640

;		MOV		BYTE [VMODE],8
		MOV		BYTE [VMODE],16
		MOV		AX,[ES:DI+0x12]  ; width in pixels (graphics) or characters (text)
		MOV		[SCRNX],AX
;		MOV		WORD [SCRNX],640
		MOV		AX,[ES:DI+0x14]  ; height in pixels (graphics) or characters (text)
		MOV		[SCRNY],AX
;		MOV		WORD [SCRNY],480
		MOV		EAX, [ES:DI+0x28] ; physical address of linear video buffer
		MOV		[VRAM], EAX
;		MOV		DWORD [VRAM], 000A0000H


;INT 10 - VESA SuperVGA BIOS - SET SuperVGA VIDEO MODE
;
;	AX = 4F02h
;	BX = new video mode (see #04082,#00083,#00084)
;	ES:DI -> (VBE 3.0+) CRTC information block, bit mode bit 11 set
;		  (see #04083)
;Return: AL = 4Fh if function supported
;	AH = status
;	    00h successful
;	    01h failed
;Notes:	bit 13 may only be set if the video mode is present in the list of
;	  accelerated video modes returned by AX=4F00h
;	if the DAC supports both 8 bits per primary color and 6 bits, it will
;	  be reset to 6 bits after a mode set; use AX=4F08h to restore 8 bits
;SeeAlso: AX=4E03h,AX=4F00h,AX=4F01h,AX=4F03h,AX=4F08h

;#00084
;Values for S3 OEM video mode:
; 201h	640x480x256
; 202h	800x600x16
; 203h	800x600x256
; 204h	1024x768x16
; 205h	1024x768x256
; 206h	1280x960x16
; 207h	1152x864x256 (Diamond Stealth 64)
; 208h	1280x1024x16
; 209h	1152x864x32K
; 20Ah	1152x864x64K (Diamond Stealth 64)
; 20Bh	1152x864x4G
; 211h	640x480x64K (Diamond Stealth 24)
; 211h	640x400x4G  (Diamond Stealth64 Video / Stealth64 Graphics)
; 212h	640x480x16M (Diamond Stealth 24)
; 301h	640x480x32K
;Note:	these modes are only available on video cards using S3's VESA driver
;SeeAlso: #00083,#00191,#00732 at INT 1A/AX=B102h
;Index:	video modes;S3

		MOV		BX, VBEMODE; + 4000H
		MOV		AX,4F02H
		INT		10H
		CMP		AX, 004FH
;		JE		fin
		JE		scrn640

;#04083
;Format of VESA VBE CRTC Information Block:
;Offset	Size	Description	)
; 00h	WORD	total number of pixels horizontally
; 02h	WORD	horizontal sync start (in pixels)
; 04h	WORD	horizontal sync end (in pixels)
; 06h	WORD	total number of scan lines
; 08h	WORD	vertical sync start (in scan lines)
; 0Ah	WORD	vertical sync end (in scan lines)
; 0Ch	BYTE	flags (see #04084)
; 0Dh	DWORD	pixel clock, in Hz
; 11h	WORD	refresh rate, in 0.01 Hz units
;		this field MUST be set to pixel_clock / (HTotal * VTotal),
;		  even though it may not actually be used by the VBE
;		  implementation
; 13h 40 BYTEs	reserved


		JMP		keystatus
;		jmp		fin

;scrn320:
;		MOV		AL,0x13	
;		MOV		AH,0x00
;		INT		0x10
;		MOV		BYTE [VMODE],8
;		MOV		WORD [SCRNX],320
;		MOV		WORD [SCRNY],240
;		MOV		DWORD [VRAM],000A0000H
;		JMP		keystatus
;
scrn640:
; 画面モードを設定

		MOV		AH, 00H
		MOV		AL, 13H			; VGAグラフィックス、13H：640×480 256色
		INT		10H
		MOV		BYTE [VMODE],16
		MOV		WORD [SCRNX],640
		MOV		WORD [SCRNY],480
		MOV		DWORD [VRAM],000A0000H
;		JMP		keystatus
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

               IN  AL , 92H
               OR  AL , 02H     ; enable A20
               OUT 92H, AL



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

; waitkbdout:
; 		IN		 AL,64H
; 		AND		 AL,02H
; 		JNZ		waitkbdout		; ANDの結果が0でなければwaitkbdoutへ
; 		RET


memcpy:
		MOV		EAX,[ESI]
		ADD		ESI,4
		MOV		[EDI],EAX
		ADD		EDI,4
		SUB		ECX,1
		JNZ		memcpy			; 引き算した結果が0でなければmemcpyへ
		RET
; memcpyはアドレスサイズプリフィクスを入れ忘れなければ、ストリング命令でも書ける


;fin:
;		HLT
;		JMP		fin


		ALIGNB	16
GDT0:
		DD 00000000H, 00000000H
		DD 0000FFFFH, 00CF9200H
		DD 0000FFFFH, 00479A28H



		DW		0
GDTR0:
		DW		8*3-1 ; limit 8 * n - 1
		DD		GDT0  ; base

		ALIGNB	16
bootpack:
