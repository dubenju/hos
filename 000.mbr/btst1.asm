cpu 8086
[BITS 16]
          section .data align=16
;label    :    instruction operands     ; comment
               XOR AX,AX                ; AX: 0000
               MOV SS,AX                ; SS: 0000
               MOV SP,0X7C00            ; SP: 7C00
               STI                      ; 
               PUSH AX                  ;
               POP ES                   ; ES: 0000
               PUSH AX                  ;
               POP DS                   ; DS: 0000
               CLD                      ;
               MOV SI,0X7C1B            ; SI: 7C1B
               MOV DI,0X061B            ; DI: 061B
               PUSH AX                  ;
               PUSH DI                  ;
               MOV CX,0X01E5            ; CX: 01E5
               REP MOVSB                ; CX: 0000
               RETF                     ; IP: 061B CS:0000
               MOV SI,0X07BE
               MOV CL,0X04
CHK_PTE   :
               CMP [SI],CH
               JL SCH_PTE   
               JNZ _DSP_ERROR_MSG
               ADD SI,BYTE +0X10
               LOOP CHK_PTE
               INT 0X18
SCH_PTE   :
               MOV DX,[SI]
               MOV BP,SI
_MOVE_TO_NEXT_ENTRY:
               ADD SI,BYTE +0X10
               DEC CX
               JZ _CHK_SYSTEM_ID_FOR_FAT
               CMP [SI],CH
               JZ _MOVE_TO_NEXT_ENTRY
_DSP_ERROR_MSG:
               MOV SI,0X710
_DSP_NEXT_CHAR:
               DEC SI
_LBL_0000003F:
               LODSB
               CMP AL,0X0
               JZ _DSP_NEXT_CHAR
               MOV BX,0X7
               MOV AH,0XE
               INT 0X10
_LBL_0000004B:
               JMP SHORT _LBL_0000003F
_CHK_SYSTEM_ID_FOR_FAT:
               MOV [BP+0X25],AX
               XCHG AX,SI
               MOV AL,[BP+0X4]
               MOV AH,0X6
               CMP AL,0XE
               JZ _LBL_0000006B
               MOV AH,0XB
               CMP AL,0XC
               JZ _LBL_00000065
               CMP AL,AH
               JNZ _LBL_0000008F
               INC AX
_LBL_00000065:
               MOV BYTE [BP+0X25],0X6
               JNZ _LBL_0000008F
_LBL_0000006B:
               MOV BX,0X55AA
               PUSH AX
               MOV AH,0X41
               INT 0X13
               POP AX
               JC LBL_0000008C
               CMP BX,0XAA55
               JNZ LBL_0000008C
               TEST CL,0X1
               JZ LBL_0000008C
               MOV AH,AL
               MOV [BP+0X24],DL
               MOV WORD [0X6A1],0X1EEB
LBL_0000008C:
               MOV [BP+0X4],AH
_LBL_0000008F:
               MOV DI,0XA
_LBL_00000092:
               MOV AX,0X201
               MOV BX,SP
               XOR CX,CX
               CMP DI,BYTE +0X5
               JG LBL_000000A1
               MOV CX,[BP+0X25]
LBL_000000A1:
               ADD CX,[BP+0X2]
               INT 0X13
_LBL000000A6:
               JC LBL_000000D1
               MOV SI,0X746
               CMP WORD [0X7DFE],0XAA55
                              JZ 0X10D
               SUB DI,BYTE +0X5
               JG _LBL_00000092
_LBL_000000B8:
               TEST SI,SI
               JNZ _LBL_0000003F
               MOV SI,0X727
               JMP SHORT _LBL_0000004B
               CBW
               XCHG AX,CX
               PUSH DX
               CWD
               ADD AX,[BP+0X8]
               ADC DX,[BP+0XA]
               CALL WORD _LBL_0XE0
               POP DX
               JMP SHORT _LBL000000A6
LBL_000000D1:
               DEC DI
               JZ _LBL_000000B8
               XOR AX,AX
               INT 0X13
               JMP SHORT _LBL_00000092

;DB 0, 0, 0, 0, 0, 0
TIMES 6 DB 0

_LBL_0XE0:
               PUSH SI
               XOR SI,SI
               PUSH SI
               PUSH SI
               PUSH DX
               PUSH AX
               PUSH ES
               PUSH BX
               PUSH CX
               MOV SI,0X10
               PUSH SI
               MOV SI,SP
               PUSH AX
               PUSH DX
               MOV AX,0X4200
               MOV DL,[BP+0X24]
               INT 0X13
               POP DX
               POP AX
               LEA SP,[SI+0X10]
               JC _LBL_00000105
_LBL_0XFB:
               INC AX
               JNZ _LBL_000000FF
               INC DX
_LBL_000000FF:
               ADD BH,0X2
               LOOP _LBL_0XFB
               CLC
_LBL_00000105:
               POP SI
               RET
                              JMP SHORT 0X17D

MSG1 DB 'Invalid partition table', 0
MSG2 DB 'Error loading operating system', 0
MSG3 DB 'Missing operating system', 0
