	XOR AX,AX	;AX=0x0000
	MOV SS, AX	;SS=0x0000
	MOV SP, 0x7C00	;SS:SP=0000:7C00
	STI
	PUSH AX
	POP  ES		;ES=0x0000
	PUSH AX
	POP  DS		;DS=0x0000
	CLD
	MOV SI, 0x7C1B	;SRC
	MOV DI, 0x061B	;DEC
	PUSH AX		;IP=0x0000
	PUSH DI		;CS=0x061B
	MOV CX, 0x01E5
	REP MOVSB
	RETF		;SIZE=1A
			; POP IP
			; POP CS

	MOV SI, 0x07BE	;0x07BE-0x061B=0x01BE
	MOV CL, 0x04
LBL_20:
	CMP [SI], CH
	JL  LBL_2d	;>=80H,Boot
	JNZ LBL_3b	;<>00H,Error
	ADD SI,  0x0010	;=00H,Next Item
	LOOP LBL_20
	INT 0x18	;Execute BASIC
;Ready to read boot
LBL_2d:
	MOV DX, [SI]
	MOV BP, SI
LBL_31:
	ADD SI, 0x0010	;CHECK NEXT ITEM
	DEC CX
	JZ  LBL_4d	;ÅúCHECK OK
	CMP [SI], CH
	JZ LBL_31	;MUST BE ZERO
LBL_3b:
	MOV SI, 0x0710
LBL_3e:
	DEC SI
DISPLAY_CHAR:
	LODSB
	CMP AL, 0x00
	JZ LBL_3e
	MOV BX, 0x0007  ;BH=00, BL=07
	MOV AH, 0x0E
	INT 0x10
LBL_4b:
	JMP short DISPLAY_CHAR

LBL_4d:

	MOV [BP + 0x25], AX
	XCHG AX, SI
	MOV AL, [BP + 0x04]
	MOV AH, 0x06
	CMP AL, 0x0E
	JZ LBL_6b	;Å°
	MOV AH,0x0B
	CMP AL,0x0C
	JZ LBL_65
	CMP AL,AH
	JNZ LBL_8f
	INC AX
LBL_65:
	MOV BYTE [BP+0x25],0x06 ;Track?Sector?
	JNZ LBL_8f
LBL_6b:
;INT 13h AH=41h: Check Extensions Present
;AH=41h = function number for extensions check
;DL=drive index (e.g. 1st HDD = 80h)
;BX=55AAh

;CF=Set On Not Present, Clear If Present
;AH=Error Code or Major Version Number
;BX=AA55h
;CX=Interface support bitmask:
;1 - Device Access using the packet structure
;2 - Drive Locking and Ejecting
;4 - Enhanced Disk Drive Support (EDD) 
	MOV BX,0x55AA
	PUSH AX
	MOV AH,0x41
	INT 0x13	;DISK SERVICES

	POP AX
	JC LBL_8c
	CMP BX,0xAA55
	JNZ LBL_8c
	TEST CL,0x01
	JZ LBL_8c
	MOV AH,AL
	MOV [BP+0x24],DL	;DL=Track?Sector?
	MOV WORD [0x06A1],0x1EEB
LBL_8c:
	MOV [BP+0x04],AH
LBL_8f:
	MOV DI,0x0A
LBL_92:
;INT 13h AH=02h: Read Sectors From Drive
;AH=02h
;AL=Sectors To Read Count(1)
;CH=Track
;CL=Sector
;DH=Head
;DL=Drive
;ES:BX=Buffer Address Pointer

;CF=Set On Error, Clear If No Error
;AH=Return Code
;AL=Actual Sectors Read Count

	MOV AX,0x0201
			;ES=0x0000
	MOV BX,SP	;BX=0x7C00
	XOR CX,CX	; CX = 0
	CMP DI,BYTE +0x05
	JG LBL_a1
	MOV CX,[BP+0x25] ;Track:Sector
LBL_a1:
	ADD CX,[BP+0x02]
	INT 0x13
	JC LBL_d1
LBL_a6:
	MOV SI,0x0746
	CMP WORD [0x7DFE],0xAA55
	JZ LBL_10d	;Åö
	SUB DI,BYTE +0x05
	JG LBL_92
LBL_b8:
	TEST SI,SI
	JNZ DISPLAY_CHAR
	MOV SI,0x0727
	JMP SHORT LBL_4b

	CBW
	XCHG AX,CX
	PUSH DX
	CWD
	ADD AX,[BP+0x08]
	ADC DX,[BP+0x0A]
	CALL WORD LBL_E0
	POP DX
	JMP SHORT LBL_a6 ;Åö
LBL_d1:
	DEC DI
	JZ LBL_b8
	XOR AX,AX
	INT 0x13
	JMP SHORT LBL_92
 times 6 DB 00
;	0x0000 ;ADD [BX+SI],AL
;	0x0000 ;ADD [BX+SI],AL
;	0x0000 ;ADD [BX+SI],AL
LBL_E0:
	PUSH SI
	XOR SI,SI
	PUSH SI
	PUSH SI
	PUSH DX
	PUSH AX
	PUSH ES
	PUSH BX
	PUSH CX
	MOV SI,0x10
	PUSH SI
	MOV SI,SP
	PUSH AX
	PUSH DX
	MOV AX,0x4200
	MOV DL,[BP+0x24]
	INT 0x13
	POP DX
	POP AX
	LEA SP,[SI+0x10]
	JC LBL_10b
LBL_101:
	INC AX
	JNZ LBL_105
	INC DX
LBL_105:
	ADD BH,0X02
	LOOP LBL_101
	CLC
LBL_10b:
	POP SI
	RET
LBL_10d:
	JMP SHORT LBL_183	;Åö
LBL_10f:
msg1 db "Invalid partition table "
msg2 db "Error loading operating system "
msg3 db "Missing operating system"
times 37 DB 00
LBL_183:
	MOV DI, SP	;0x7C00
	PUSH DS		;0x0000
	PUSH DI
	MOV SI, BP
	RETF		; GOTO Booting
			; POP IP
			; POP CS
times 46 db 0x00
times 6 db 0x00
db 0x80
db 0x01
db 0x01
db 0x00
db 0x0E
db 0x0F
db 0x3F
db 0x40
db 0x3F
db 0x00
db 0x00
db 0x00
db 0xB1
db 0xFF
db 0x00
db 0x00
times 16 db 0x00
times 16 db 0x00
times 16 db 0x00

dw 0xAA55
