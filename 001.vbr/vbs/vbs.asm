                            ORG 7C00H

                            JMP SHORT VBR_START        ; 跳过数BPB
                            NOP
;                            TIMES 59 DB 0
bsOEM_NAME            DB      'MSDOS5.0'      ; 8 bytes
bsBYTES_PER_SECTOR    DW      00h             ; 2
bsSECTORS_PER_CLUSTER DB      00h             ; 1
bsRESERVED_SECTORS    DW      00h             ; 2
bsFAT_COPIES          DB      00h             ; 1
bsROOT_DIR_ENTRIES    DW      00h             ; 2
bsTOTAL_DISK_SECTORS  DW      00h             ; 2
bsMEDIA_DESCRIPTOR    DB      00h             ; 1
bsSECTORS_PER_FAT     DW      00h             ; 2
bsSECTORS_PER_TRACK   DW      00h             ; 2
bsSIDES               DW      00h             ; 2
bsHIDDEN_SECTORS_HIGH DW      00h             ; 2
bsHIDDEN_SECTORS_LOW  DW      00h             ; 2
bsTOTAL_NUM_SECTORS   DD      00h             ; 4
bsPHYS_DRIVE_NUMBER_1 DB      00h             ; 1
bsPHYS_DRIVE_NUMBER_2 DB      00h             ; 1
bsBOOT_RECORD_SIG     DB      29h             ; 1
bsVOL_SERIAL_NUM      DD      1F61A800h       ; 4
bsVOLUME_LABEL        DB      'NO NAME    '   ; 11 bytes
bsFILE_SYSTEM_ID      DB      'FAT16   '      ;  8 bytes
;[========================================================================]
;    Disk Parameter Block
;
;     The DPB is located in the ROM BIOS at the address pointed to by 0078h.
;     The 11 bytes starting from START are overwritten at COPY_DPB with the
;     DPB (7C3E-7C48).  This is what the area looks like *after* the copy
;     at COPY_DPB:
;[========================================================================]
;dpbCONTROL_TIMERS     DW      00h ; 2
;dpbMOTOR_OFF_DELAY    DB      00h ; 1
;dpbBYTES_PER_SECTOR   DB      00h ; 1
;dpbSECTORS_PER_TRACK  DB      00h ; 1
;dpbGAP_LENGTH         DB      00h ; 1
;dpbDATA_LENGTH        DB      00h ; 1
;dpbFORMAT_GAP_LENGTH  DB      00h ; 1
;dpbFORMAT_FILLER_BYTE DB      00h ; 1
;dpbHEAD_SETTLE_TIME   DB      00h ; 1
;dpbMOTOR_START_TIME   DB      00h ; 1
;[========================================================================]
;     Following the copy of the DPB, more information is copied over
;     previously existing code:
;[========================================================================]
;cpbsHIDDEN_SECTORS_HIGH DW      00h
;cpbsHIDDEN_SECTORS_LOW  DW      00h
;
;                        DB      00h
;                        DB      00h
;                        DB      00h
;
;cpbsHIDDEN_SECTORS_HIGH DW      00h
;cpbsHIDDEN_SECTORS_LOW  DW      00h
;[========================================================================]
;     Here is the start of the boot sector code.  Note that the first 11
;     bytes will be destroyed later on as described above.
;[========================================================================]
VBR_START:
                            CLI                        ; Disable interrupts
                            XOR  AX,AX                 ; AX=0000
                            MOV  SS,AX                 ; SS=0000
                            MOV  SP,7C00H              ; 初始化堆栈; SP grows in decrements
                            PUSH SS
                            POP  ES                    ; ES=0000
                            MOV  BX,0078H              ; 1EH 号中断向量的地址为0000:0078H;指向磁盘驱动器参数表指针
                                                       ; The address of the ROM BIOS disk table is 78h. (INT 18h).  ROM routine copies this address during cold boot initialization.
                            LDS  SI,[SS:BX]            ; 0000:0078H SI points to ROMBIOS table The source for the copy
                            PUSH DS
                            PUSH SI
                            PUSH SS
                            PUSH BX
                            MOV  DI,VBR_START          ; VBR_START ; Address of destination
                            MOV  CX,000BH              ; 11字节 ; Size of area to copy (Disk parameters) Set direction flag to inc Move 11 bytes from the disk parameter area to overlap with the start  of the code at 7D3E (save space?)
                            CLD
                            REP  MOVSB                 ; DS:SI-11->ES:DI(0000:7C3E)
                            PUSH ES
                            POP  DS                    ; DS=ES ; DS=0000
                            MOV  BYTE [DI-02H],0FH     ; At this point, DI points  to 7C49, one byte after  the last thing copied.  Destination operand is  dpbHEAD_SETTLE_TIME.
                            MOV  CX,[bsSECTORS_PER_TRACK]
                            MOV  [DI-07H],CL           ; Destination operand is dpbSECTORS_PER_TRACK.
                            MOV  [BX+02H],AX           ; (AX)=0000H,修改1EH号中断向量(段址) ; Destination operand is  dpbMOTOR_OFF_DELAY.
                            MOV  WORD [BX],VBR_START   ; 修改1EH号中断向量(偏移),这样1EH号中断向量的内容为0000:7C3EH,指向新的磁盘参数表
                                                       ; The code at 7C6B installs the new Int 1E into the interrupt table at 0000:0078. At 7C68, AX is 0. START is the offset for the new INT 1E.
                            STI
;功能00H 功能描述： 磁盘系统复位
;AH＝00H DL＝驱动器，00H~7FH：软盘；80H~0FFH：硬盘
;CF＝0——操作成功，AH＝00H，否则，AH＝状态代码，参见功能号01H中的说明
                            INT 13H                    ; 用新的磁盘参数表来复位磁盘; Reset drives (AX=0000)
                            JC DSP_MSG                 ; 出错则转出错处理
;------------------------------------------------------;----------------
                            XOR AX,AX
                            CMP [bsTOTAL_DISK_SECTORS],AX ; BPB_ToSec16FAT32必须等于0，FAT12/FAT16为扇区总数。 
                            JZ LBL00000084
                            MOV CX,[bsTOTAL_DISK_SECTORS]
                            MOV [bsTOTAL_NUM_SECTORS],CX             ; BPB_ToSec32
LBL00000084:
                            MOV AL,  [bsFAT_COPIES]     ; FAT表个数
                            MUL WORD [bsSECTORS_PER_FAT]     ; * FAT 表所占的扇区数
                            ADD AX,  [bsHIDDEN_SECTORS_HIGH]    ; + 隐藏的扇区数L
                            ADC DX,  [bsHIDDEN_SECTORS_LOW]   ; + 隐藏的扇区数H
                            ADD AX,  [bsRESERVED_SECTORS]    ; + 保留扇区数L
                            ADC DX,BYTE +00H     ; + 保留扇区数H
                            MOV [7C50H],AX
                            MOV [7C52H],DX
                            MOV [7C49H],AX
                            MOV [7C4BH],DX
                            MOV AX,20H           ; 32字节
                            MUL WORD [bsROOT_DIR_ENTRIES]     ; 根目录中目录的个数
                            MOV BX,[bsBYTES_PER_SECTOR]       ; 每扇区字节数
                            ADD AX,BX             ; 
                            DEC AX                ; ( 32 * n + 511 ) / 512
                            DIV BX                ; 根目录所占扇区数
                            ADD [7C49H],AX              ;
                            ADC WORD [7C4BH],BYTE + 00H ;
                            MOV BX,500H
                            MOV DX,[7C52H]
                            MOV AX,[7C50H]
                            CALL WORD LBL00000160
                            JC DSP_MSG
;
                            MOV AL,01H
                            CALL WORD LBL00000181
                            JC DSP_MSG ; Error?  Print message and reboot.
;
                            MOV DI,BX
                            MOV CX,000BH ; 11 characters in DOS filename.
                            MOV SI,7DE6H         ; 1E6:IO      SYS
                            REPE CMPSB
                            JNZ DSP_MSG ; First file in root dir is not IO.SYS?  Print error.
;
                            LEA DI,[BX+20H]       ; NEXT:MSDOS   SYS
                            MOV CX,0BH ; 11 characters in DOS filename.
                            REPE CMPSB ; Is second file in root MSDOS.SYS?
                            JZ LBL00000105; Yes?  Then continue on.
DSP_MSG:
                            MOV SI,MSG1           ; MSG
                            CALL WORD LBL00000152
                            XOR AX,AX
                            INT 16H
                            POP SI
                            POP DS
                            POP WORD [SI]
                            POP WORD [SI+02H]
                            INT 19H
LBL00000100:
                            POP AX
                            POP AX
                            POP AX
                            JMP SHORT DSP_MSG

LBL00000105:
                            MOV AX,[BX+1AH]
                            DEC AX
                            DEC AX
                            MOV BL,[7C0DH]
                            XOR BH,BH
                            MUL BX
                            ADD AX,[7C49H]
                            ADC DX,[7C4BH]
                            MOV BX,0700H; DOS loading buffer
                            MOV CX,0003H
LBL00000120:
                            PUSH AX
                            PUSH DX
                            PUSH CX
                            CALL WORD LBL00000160
                            JC LBL00000100

                            MOV AL,01H
                            CALL WORD LBL00000181
                            POP CX
                            POP DX
                            POP AX
                            JC DSP_MSG

                            ADD AX, 0001H
                            ADC DX,BYTE + 00H
                            ADD BX,[7C0BH]
                            LOOP LBL00000120
                            MOV CH,[7C15H]
                            MOV DL,[7C24H]
                            MOV BX,[7C49H]
                            MOV AX,[7C4BH]
                            JMP WORD 0070H:0000H ; Transfer to ROM BIOS

;[========================================================================]
;     Procedure     WRITE_STRING
;[========================================================================]
;     Parameters:
;                   SI:  Address of string to write

LBL00000152:
                            LODSB
                            OR AL,AL
                            JZ LBL00000180
                            MOV AH,0EH
                            MOV BX,07H
                            INT 10H
                            JMP SHORT LBL00000152

;[========================================================================]
;     Procedure     CALCULATE
;
;     This procedure probably translates the sector numbers into physical
;     addresses for the low level BIOS functions.
;[========================================================================]
LBL00000160:
;将逻辑扇区号转换为物理扇区号的子程序
                            CMP DX,[7C18H]       ; 每磁道扇区数
                            JNC LBL0000017F
                            DIV WORD [7C18H]
                            INC DL
                            MOV [7C4FH],DL
                            XOR DX,DX
                            DIV WORD [7C1AH]     ; 磁头数
                            MOV [7C25H],DL
                            MOV [7C4DH],AX
                            CLC                   ; OK
                            RET
LBL0000017F:
                            STC                   ; NG
LBL00000180:
                            RET

;[========================================================================]
;     Procedure     READ_SECTOR
;[========================================================================]
LBL00000181:
;读一个扇区的子程序
; AH 02
                            MOV  AH,02H           ;(AL)=要读的扇区数
                            MOV  DX,[07C4DH]       
                            MOV  CL,06H
                            SHL  DH,CL             
                            OR   DH,[7C4FH]       
                            MOV  CX,DX             ;(CH)=磁道号
                            XCHG CH,CL            ;(CL)=扇区号(第6,7位为磁道号的高2位)
                            MOV  DL,[7C24H]       ;(DL)=驱动器号
                            MOV  DH,[7C25H]       ;(DH)=面号 
                            INT  13H              ;(ES:BX)=缓冲区首址
                            RET
;
;                            times 96 DB 0

MSG1     DB 0DH,0AH,'Non-System disk or disk error'
         DB 0DH,0AH,'Replace and press any key when ready'
         DB 0DH,0AH,00H

FILE1 DB 'DUBENJU SYSMSDOS   SYS'

                            times 2 DB 0

DB 55H
DB 0AAH
