;         :                             ;                   
               JMP SHORT LBL_START      ;
               NOP                      ;

;TIMES 59 DB 00
;DB 4d,53,57,49,4e,34,2e,31,00,902,08,01,00,02,00,02,81,4e,f8,08,00,3f,00,10,00,3f,00,00,00,00,00,00,00,80,00,29,fa,0d,3b,18,4e,4f,20,4e,41,4d,45,20,20,20,20,46,41,54,31,32,20,20,20
BS_OEMName     DB 'MSWIN4.1'    ;  ( 8Byte)
BPB_BytsPerSec DW 512           ;  ( 2Byte) <-
BPB_SecPerClus DB 8             ;  ( 1Byte)
BPB_RsvdSecCnt DW 1             ;  ( 2Byte)
BPB_NumFATs    DB 2             ;  ( 1Byte)
BPB_RootEntCnt DW 512           ;  ( 2Byte) <-
BPB_TotSec16   DW 0x4E81        ;  ( 2Byte)
BPB_Media      DB 0xF8          ;  ( 1Byte)
BPB_FATSz16    DW 0x0008        ;  ( 2Byte)
BPB_SecPerTrk  DW 63            ;  ( 2Byte)
BPB_NumHeads   DW 16            ;  ( 2Byte)
BPB_HiddSec    DD 63            ;  ( 4Byte)
BPB_TotSec32   DD 0             ;  ( 4Byte)
BS_DrvNum      DB 128           ;  ( 1Byte)
BS_Reserved1   DB 0             ;  ( 1Byte)
BS_BootSig     DB 29h           ;  ( 1Byte)
BS_VolID       DD 0x183B0DFA    ;  ( 4Byte)
BS_VolLab      DB 'NO NAME    ' ;  (11Byte)
BS_FileSysType DB 'FAT12   '    ;  ( 8Byte)


LBL_START :                             ; 
               XOR  CX,CX               ; CX: 0000
               MOV  SS,CX               ; SS: 0000
               MOV  SP,0X7BFC           ; SP: 7BFC
               PUSH SS                  ; 
               POP  ES                  ; ES: 0000
               MOV  BP,0X0078           ; BP: 78
               LDS  SI,[BP]             ; 
               PUSH DS                  ; 
               PUSH SI                  ; 
               PUSH SS                  ; 
               PUSH BP                  ; 
               MOV  DI,0X0522
               MOV  [BP],DI
               MOV  [BP+0X02],CX        ; 0000:0522
               MOV  CL,0X0B             ; 11byte
               CLD
               REP  MOVSB               ; DS:SI=>ES:DI
               PUSH ES                  ; 
               POP  DS                  ; DS
               MOV  BP,0X7C00           ; 
               MOV  BYTE [DI-0X02],0X0F
               CMP  [BP+0X24],CL
               JNL  IO_SYS 
               MOV  AX,CX
               CWD
               CALL WORD LBL_0X1B3
               SUB  BX,BYTE +0X3A
               MOV  EAX,[0X7C1C]        ; EAX
LBL_0X3C:
               CMP  EAX,[BX]            ; EAX
               MOV  DL,[BX-0X04]
               JNZ  LBL_0X4A
               OR   DL,0X02
               MOV  [BP+0X02],DL
LBL_0X4A:
               ADD  BL,0X10
               JNC  LBL_0X3C
IO_SYS :
               XOR  CX,CX
               INC  BYTE [0X7DD8]        ; IO.SYS
LBL_0X55:
               MOV  AL,[BP+0X10]
               CBW
               MUL  WORD [BP+0X16]
               ADD  AX,[BP+0X1C]
               ADC  DX,[BP+0X1E]
               ADD  AX,[BP+0X0E]
               ADC  DX,CX
               MOV  SI,[BP+0X11]
               PUSHAW
               MOV  [BP-0X04],AX
               MOV  [BP-0X02],DX
               MOV  AX,0X20
               MUL  SI
               MOV  BX,[BP+0X0B]
               ADD  AX,BX
               DEC  AX
               DIV  BX
               ADD  [BP-0X04],AX
               ADC  [BP-0X02],CX
               POPAW
LBL_0X85:
               MOV  DI,0X0700
               CALL WORD LBL_0X1B3
               JC   LBL_0XCB
LBL_0X8D:
               CMP  [DI],CH
               JZ   LBL_0XA8
               PUSHAW
               MOV  CL,0X0B
               MOV  SI,0X7DD8
               REPE CMPSB
               POPAW
               JZ   LBL_0XD9
               DEC  SI
               JZ   LBL_0XA8
               ADD  DI,BYTE +0X20
               CMP  DI,BX
               JC   LBL_0X8D
               JMP  SHORT LBL_0X85
LBL_0XA8:
               DEC  BYTE [0X7DD8]
               JPO  LBL_0X55
               MOV  SI,0X7D7F
LBL_0XB1:
               LODSB
               CBW
               ADD  SI,AX
DSP_MSG:
               LODSB
               CBW
               INC  AX
               JZ   LBL_0XC6
               DEC  AX
               JZ   LBL_0XD0
               MOV  AH,0X0E
               MOV  BX,0X07
               INT  0X10                ; DISPLAY
               JMP  SHORT DSP_MSG       ; 
LBL_0XC6:
               MOV  SI,0X7D82
               JMP  SHORT LBL_0XB1
LBL_0XCB:
               MOV  SI,0X7D80
               JMP  SHORT LBL_0XB1
LBL_0XD0:
               INT  0X16
               POP  SI
               POP  DS
               POP  DWORD [SI]
               INT  0X19
LBL_0XD9:
               MOV  SI,0X7D81
               MOV  DI,[DI+0X1A]
               LEA  AX,[DI-0X02]
               MOV  CL,[BP+0X0D]
               MUL  CX
               ADD  AX,[BP-0X04]
               ADC  DX,[BP-0X02]
               MOV  CL,0X4
               CALL WORD LBL_0X1B4
               JC   LBL_0XCB
               JMP  WORD 0X0070:0X0200
LBL_0X137:
               PUSH DX
               PUSH AX
               PUSH ES
               PUSH BX
               PUSH BYTE +0X01
               PUSH BYTE +0X10
               XCHG AX,CX
               MOV  AX,[BP+0X18]
               MOV  [0X526],AL
               XCHG AX,SI
               XCHG AX,DX
               XOR  DX,DX
               DIV  SI
               XCHG AX,CX
               DIV  SI
               INC  DX
               XCHG CX,DX
               DIV  WORD [BP+0X1A]
               MOV  DH,DL
               MOV  CH,AL
               ROR  AH,BYTE 0X02
               OR   CL,AH
               MOV  AX,0X0201
               CMP  BYTE [BP+0X02],0X0E
               JNZ  LBL_0X12D
;Exte n de d Re ad Se c tors From Drive
               MOV  AH,0X42             ; 
               MOV  SI,SP
LBL_0X12D:
               MOV  DL,[BP+0X24]
               INT  0X13                ; DISK IO
               POPAW
               POPAW
               JC   LBL_0X140
               INC  AX
               JNZ  LBL_0X13A
               INC  DX
LBL_0X13A:
               ADD  BX,[BP+0X0B]
               DEC  CX
               JNZ  LBL_0X1B7
LBL_0X140:
               RET
               ADD  BX,[BX+SI]
               ADD  [BX],SP

;TIMES 107 DB 00

msg1 DB 0x0D
     DB 0x0A
     DB 'Invalid system disk'
     DB 0xFF
msg2 DB 0x0D
     DB 0x0A
     DB "Disk I/O error"
     DB 0xFF
msg3 DB 0x0D
     DB 0x0A
     DB "Replace the disk, and then press any key"
     DB 0x0D
     DB 0x0A

TIMES 2 DB 00
    DB 'IO      SYS'
    DB 'MSDOS   SYS'

DB 0x7F
DB 01
DB 00


LBL_0X1B3:
               INC  CX
LBL_0X1B4:
               MOV  BX,0X0700
LBL_0X1B7:
               PUSHAW
               O32  PUSH BYTE +0X00
               JMP  WORD LBL_0X137

DB 00
DB 00

DB 0x55
DB 0xAA
