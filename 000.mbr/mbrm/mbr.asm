.MODEL TINY
.CODE
; MBR的引导程序
              org 0600H
START:
;label    :    instruction operands     ; comment
               XOR  AX,AX               ; AX = 0000
               MOV  SS,AX               ; SS = 0000
               MOV  SP,7C00H            ; SP = 7C00
               STI                      ; 开中断
               PUSH AX                  ; 
               POP  ES                  ; ES = 0000
               PUSH AX                  ;
               POP  DS                  ; DS = 0000
               CLD                      ; FLAGS.DF = 0
; 把7C1B处开始的485字节复制到061B处，   ;
; 并从061B处开始执行                    ; 
               MOV  SI,7C1BH            ; SI = 7C1B
               MOV  DI,061BH            ; DI = 061B
               PUSH AX                  ; CS
               PUSH DI                  ; IP
               MOV  CX,01E5H            ; CX = 01E5(485字节)
               REP  MOVSB               ; CX: 0000
               RETF                     ; IP: 061B CS:0000
;---------------------------------------;-------------------
; 这里才是1B处开始的代码                ; 
               MOV  SI,07BEH            ; SI: 07BE 实际是1BE
               MOV  CL,04H              ; CX: 0004
CHK_PTE   :                             ;
               CMP  [SI],CH             ; cmp 分区状态 0
               JL   SCH_PTE             ; [SI] 80 =>
               JNZ  INVALIDPT           ; [SI] NOT 00
               ADD  SI, 10H             ; [SI] = 00 下一个分区
               LOOP CHK_PTE             ; 下一个分区
               INT  18H                 ; ROM-BASIC 
SCH_PTE   :                             ;
               MOV  DX,[SI]             ; DX: 0080
               MOV  BP,SI               ; BP: 07BE
NEXT_PTE  :                             ; 只有一个80
               ADD  SI, 10H             ; SI: 07FE
               DEC  CX                  ;
               JZ   CHK_SYSID           ; =>
               CMP  [SI],CH             ; CH: 00 NEED 80 00 00 00
               JZ   NEXT_PTE            ;
INVALIDPT :                             ;
               MOV  SI,OFFSET MSG1 + 01H; SI: 0710
NEXT_CH   :                             ;
               DEC  SI                  ;
DSP_MSG:                                ; DISPLAY MESSAGE
               LODSB                    ; DS:SI -> AL
               CMP  AL,00H              ;
               JZ   NEXT_CH             ;
               MOV  BX,0007H            ;
               MOV  AH,0EH              ; AL=字符，BH=页码，BL=颜色（只适用于图形模式）
               INT  10H                 ;
DSP_ERRMSG:                             ; DISPLAY MESSAGE
               JMP  SHORT DSP_MSG       ; DISPLAY MESSAGE
;---------------------------------------;-------------------
CHK_SYSID :                             ; ??
               MOV  [BP+25H],AX         ; BP: 07BE AX=?0000? SS:0000,[BP+0X25]:CX
               XCHG AX,SI               ; SI: 07FE=>07BE
               MOV  AL,[BP+04H]         ; SYSTEM ID
               MOV  AH,06H              ; AH: 06
               CMP  AL,0EH              ; 
               JZ   TST13HEX            ; FAT16(0E)
               MOV  AH,0BH              ; 
               CMP  AL,0CH              ; 
               JZ   SET_FOR_0C          ; FAT32(0C)
               CMP  AL,AH               ; AH:0B(FAT32)
               JNZ  SET_CNT             ; OTHERWISE TO READ
               INC  AX                  ; FAT32(06)
SET_FOR_0C:                             ;
               MOV BYTE PTR [BP+25H],06H; 06=>CX
               JNZ  SET_CNT             ; TO READ
TST13HEX  :                             ; 
               MOV  BX,55AAH            ; 
               PUSH AX                  ; SAVE AX
;INT 13h AH=41h:Check Extensions Present;
;AH:41h = function number for extensions check
;DL:drive index (e.g. 1st HDD = 80h)
;BX:55AAh
;
;CF:Set On Not Present, Clear If Present
;AH:Error Code or Major Version Number
;BX:AA55h
;CX:Interface support bitmask:
;   1 - Device Access using the packet structure
;   2 - Drive Locking and Ejecting
;   4 - Enhanced Disk Drive Support (EDD)
               MOV  AH,41H              ; 
               INT  13H                 ; 
               POP  AX                  ; RESTORE AX
               JC   NO_PRESENT          ; CF=1 NG
               CMP  BX,0AA55H           ;
               JNZ  NO_PRESENT          ; BX!=AA55 NG
               TEST CL,01H              ; CL=01 first
               JZ   NO_PRESENT          ;
               MOV  AH,AL               ;
               MOV  [BP+24H],DL         ;
               MOV WORD PTR DS:[06A1H],1EEBH ; 7915
NO_PRESENT:
               MOV  [BP+04H],AH
SET_CNT   :                             ;
               MOV  DI,000AH            ; DI: 0A
READ_VBR  :                             ;
;INT 13h AH=02h: Read Sectors From Drive;
;AL:Sectors To Read Count               ;
;CF:Set On Error, Clear If No Error
;AH:Return Code
;AL:Actual Sectors Read Count
                                        ; AH:Read Sectors From Drive, AL:Sectors To Read Count
                                        ; CH:Cylinder, CL:Sector
                                        ; DH:Head,     DL:Drive
                                        ; ES:BX:Buffer Address Pointer
               MOV  AX,0201H            ; AX: 0201
               MOV  BX,SP               ; BX: 7C00, ES: 0000
               XOR  CX,CX               ; CX: 0000
               CMP  DI, 05H             ; 
               JG   READ_DISK           ; DI > 5
               MOV  CX,[BP+25H]         ; CX: 0006
READ_DISK :                             ; 
               ADD  CX,[BP+02H]         ; SEC, CYL
               INT  13H                 ; 
_LBL000000A6:
               JC   RESET_DISK          ; CF=1ERROR
               MOV  SI, offset MSG3     ; MISS OS
               CMP  WORD PTR DS:[7DFEH],0AA55H ; 
               JZ   PRE_RUNVBR          ; RUN
               SUB  DI, 05H             ; DI - 5 > 0
               JG   READ_VBR            ; RETRY
PRINT_MSG :
               TEST SI,SI               ; SI == 0
               JNZ  DSP_MSG             ; DISPLAY MESSAGE
               MOV  SI,offset MSG2      ; ERROR LOAD OS
               JMP  SHORT DSP_ERRMSG    ; DISPLAY MESSAGE

               CBW
               XCHG AX,CX
               PUSH DX
               CWD
               ADD  AX,[BP+08H]         ; 
               ADC  DX,[BP+0AH]         ; 
               CALL  _LBL_0XE0
               POP  DX
               JMP  SHORT _LBL000000A6
RESET_DISK:
               DEC  DI                  ;
               JZ   PRINT_MSG           ;
               XOR  AX,AX               ; Reset Disk Drives
               INT  13H                 ;
               JMP  SHORT READ_VBR      ;

DB 6 DUP(?)

_LBL_0XE0:
               PUSH SI
               XOR  SI,SI
               PUSH SI
               PUSH SI
               PUSH DX
               PUSH AX
               PUSH ES
               PUSH BX
               PUSH CX                  ; CX =>IP?
               MOV  SI,10H
               PUSH SI                  ; SAVE SI
               MOV  SI,SP
               PUSH AX                  ; SAVE AX
               PUSH DX                  ; SAVE DX
               MOV  AX,4200H            ; DL=DRV,DS:DI=
               MOV  DL,[BP+24H]         ; DRIVE INDEX
               INT  13H                 ; CF=0OK,CF=1NG
               POP  DX                  ; RESTORE DX
               POP  AX                  ; RESTORE AX
               LEA  SP,[SI+10H]
               JC   _LBL_00000105
_LBL_0XFB:
               INC  AX
               JNZ _LBL_000000FF
               INC DX
_LBL_000000FF:
               ADD  BH,02H
               LOOP _LBL_0XFB
               CLC
_LBL_00000105:
               POP  SI                  ; RESTORE SI
               RET                      ; IP=, ___CS
;-----------------------------------------------------------


PRE_RUNVBR:
               JMP  SHORT RUN_VBR

MSG1     DB 'Invalid partition table', 0
MSG2     DB 'Error loading operating system', 0
MSG3     DB 'Missing Operating system', 0

DB 36 DUP(?)

RUN_VBR   :                             ;
               MOV  DI,SP               ;
               PUSH DS                  ; CS: DS
               PUSH DI                  ; IP: DI
               MOV  SI,BP               ; SI: BP
               RETF                     ; IP: 061B CS:0000

DB 116 DUP(?)

DB 55H
DB 0AAH

END START
