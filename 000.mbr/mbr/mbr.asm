              org 0600H
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
               MOV SI,0X07BE            ; SI: 07BE
               MOV CL,0X04              ; CX: 0004
CHK_PTE   :                             ;
               CMP [SI],CH              ;
               JL SCH_PTE               ; [SI] 80 =>
               JNZ INVALIDPT            ; [SI] NOT 00
               ADD SI,BYTE +0X10        ; [SI] 00
               LOOP CHK_PTE             ; NEXT PARTITION TABLE ENTRY
               INT 0X18                 ; ROM-BASIC 
SCH_PTE   :                             ;
               MOV DX,[SI]              ; DX: 0080
               MOV BP,SI                ; BP: 07BE
NEXT_PTE  :                             ;
               ADD SI,BYTE +0X10        ; SI: 07FE
               DEC CX                   ;
               JZ CHK_SYSID             ; =>
               CMP [SI],CH              ; CH: 00 NEED 80 00 00 00
               JZ NEXT_PTE              ;
INVALIDPT :                             ;
               MOV SI,MSG1 + 1          ; SI: 0710
NEXT_CH   :                             ;
               DEC SI                   ;
DSP_MSG:                                ; DISPLAY MESSAGE
               LODSB                    ; DS:SI -> AL
               CMP AL,0X00              ;
               JZ NEXT_CH               ;
               MOV BX,0X0007            ;
               MOV AH,0X0E              ;
               INT 0X10                 ;
DSP_ERRMSG:                             ; DISPLAY MESSAGE
               JMP SHORT DSP_MSG        ; DISPLAY MESSAGE
;---------------------------------------;-------------------
CHK_SYSID :                             ; ??
               MOV [BP+0X25],AX         ; BP: 07BE AX=?0000?
               XCHG AX,SI               ; SI: 07FE=>07BE
               MOV AL,[BP+0X04]         ; SYSTEM ID
               MOV AH,0X06              ; AH: 06
               CMP AL,0X0E              ; 
               JZ TST13HEX              ; FAT16(0E)
               MOV AH,0X0B              ; 
               CMP AL,0X0C              ; 
               JZ SET_FOR_0C            ; FAT32(0C)
               CMP AL,AH                ; 
               JNZ SET_CNT              ; OTHERWISE TO READ
               INC AX                   ; FAT32(06)
SET_FOR_0C:                             ;
               MOV BYTE [BP+0X25],0X06  ; 06
               JNZ SET_CNT              ; TO READ
TST13HEX  :                             ; 
               MOV BX,0X55AA            ; 
               PUSH AX                  ; SAVE AX
               MOV AH,0X41              ; 
               INT 0X13                 ; 
               POP AX                   ; RESTORE AX
               JC LBL_0000008C          ; CF=1 NG
               CMP BX,0XAA55            ;
               JNZ LBL_0000008C         ; BX!=AA55 NG
               TEST CL,0X01             ; CL=01 first
               JZ LBL_0000008C          ;
               MOV AH,AL                ;
               MOV [BP+0X24],DL         ;
               MOV WORD [0X06A1],0X1EEB ;
LBL_0000008C:
               MOV [BP+0X04],AH
SET_CNT   :
               MOV DI,0X000A            ; DI: 0A
READ_VBR  :
;AH:Read Sectors From Drive, AL:Sectors To Read Count
;CH:Cylinder, CL:Sector
;DH:Head, DL:Drive
;ES:BX:Buffer Address Pointer
               MOV AX,0X0201            ; AX: 0201
               MOV BX,SP                ; BX: 7C00, ES: 0000
               XOR CX,CX                ; CX: 0000
               CMP DI,BYTE +0X05        ; 
               JG READ_DISK             ; 
               MOV CX,[BP+0X25]         ; CX: 0006
READ_DISK :                             ; 
               ADD CX,[BP+0X02]         ; SEC, CYL
               INT 0X13                 ; 
_LBL000000A6:
               JC RESET_DISK            ; CF=1ERROR
               MOV SI,MSG3              ; MISS OS
               CMP WORD [0X7DFE],0XAA55 ; 
               JZ PRE_RUNVBR            ; RUN
               SUB DI,BYTE +0X05        ; 
               JG READ_VBR              ; RETRY
PRINT_MSG :
;MOV SI, 0X00
               TEST SI,SI               ; SI == 0
               JNZ DSP_MSG              ; DISPLAY MESSAGE
               MOV SI,MSG2              ; ERROR LOAD OS
               JMP SHORT DSP_ERRMSG     ; DISPLAY MESSAGE

               CBW
               XCHG AX,CX
               PUSH DX
               CWD
               ADD AX,[BP+0X08]         ; 
               ADC DX,[BP+0X0A]         ; 
               CALL WORD _LBL_0XE0
               POP DX
               JMP SHORT _LBL000000A6
RESET_DISK:
               DEC DI                   ;
               JZ PRINT_MSG             ;
               XOR AX,AX                ; Reset Disk Drives
               INT 0X13                 ;
               JMP SHORT READ_VBR       ;

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
               PUSH CX                  ; CX =>IP?
               MOV SI,0X10
               PUSH SI                  ; SAVE SI
               MOV SI,SP
               PUSH AX                  ; SAVE AX
               PUSH DX                  ; SAVE DX
               MOV AX,0X4200            ; DL=DRV,DS:DI=
               MOV DL,[BP+0X24]         ; DRIVE INDEX
               INT 0X13                 ; CF=0OK,CF=1NG
               POP DX                   ; RESTORE DX
               POP AX                   ; RESTORE AX
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
               POP SI                   ; RESTORE SI
               RET                      ; IP=, ___CS
;-----------------------------------------------------------


PRE_RUNVBR:
               JMP SHORT RUN_VBR

MSG1     DB 'Invalid partition table', 0
MSG2     DB 'Error loading operating system', 0
MSG3     DB 'Missing operating system', 0

TIMES 36 DB 0

RUN_VBR   :                             ;
               MOV DI,SP                ;
               PUSH DS                  ; CS: DS
               PUSH DI                  ; IP: DI
               MOV SI,BP                ; SI: BP
               RETF                     ; IP: 061B CS:0000
