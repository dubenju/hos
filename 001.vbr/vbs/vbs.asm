                            ORG 7C00H

                            JMP SHORT VBR_START        ; 跳过数BPB
                            NOP
                            TIMES 59 DB 0
VBR_START:
                            CLI
                            XOR  AX,AX
                            MOV  SS,AX
                            MOV  SP,7C00H              ; 初始化堆栈
                            PUSH SS
                            POP  ES
                            MOV  BX,0078H              ; 1EH 号中断向量的地址为0000:0078H;指向磁盘驱动器参数表指针
                            LDS  SI,[SS:BX]             ; 0000:0078H
                            PUSH DS
                            PUSH SI
                            PUSH SS
                            PUSH BX
                            MOV  DI,7C3EH              ; VBR_START
                            MOV  CX,000BH              ; 11字节
                            CLD
                            REP  MOVSB                  ; DS:SI-11->ES:DI(0000:7C3E)
                            PUSH ES
                            POP  DS                    ; DS=ES
                            MOV  BYTE [DI-02H],0FH     ; 
                            MOV  CX,[7C18H]
                            MOV  [DI-07H],CL
                            MOV  [BX+02H],AX            ; (AX)=0000H,修改1EH号中断向量(段址)
                            MOV  WORD [BX],7C3EH       ; 修改1EH号中断向量(偏移),这样1EH号中断向量的内容为0000:7C3EH,指向新的磁盘参数表
                            STI
;功能00H 功能描述： 磁盘系统复位
;AH＝00H DL＝驱动器，00H~7FH：软盘；80H~0FFH：硬盘
;CF＝0——操作成功，AH＝00H，否则，AH＝状态代码，参见功能号01H中的说明
                            INT 13H                   ; 用新的磁盘参数表来复位磁盘
                            JC DSP_MSG            ; 出错则转出错处理
;------------------------------------------------------;----------------
                            XOR AX,AX
                            CMP [7C13H],AX       ; BPB_ToSec16FAT32必须等于0，FAT12/FAT16为扇区总数。 
                            JZ LBL00000084
                            MOV CX,[7C13H]
                            MOV [7C20H],CX       ; BPB_ToSec32
LBL00000084:
                            MOV AL,  [7C10H]     ; FAT表个数
                            MUL WORD [7C16H]     ; * FAT 表所占的扇区数
                            ADD AX,  [7C1CH]     ; + 隐藏的扇区数L
                            ADC DX,  [7C1EH]     ; + 隐藏的扇区数H
                            ADD AX,  [7C0EH]     ; + 保留扇区数L
                            ADC DX,BYTE +00H     ; + 保留扇区数H
                            MOV [7C50H],AX
                            MOV [7C52H],DX
                            MOV [7C49H],AX
                            MOV [7C4BH],DX
                            MOV AX,20H           ; 32字节
                            MUL WORD [7C11H]     ; 根目录中目录的个数
                            MOV BX,[7C0BH]       ; 每扇区字节数
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
                            JC DSP_MSG
;
                            MOV DI,BX
                            MOV CX,000BH
                            MOV SI,7DE6H         ; 1E6:IO      SYS
                            REPE CMPSB
                            JNZ DSP_MSG
;
                            LEA DI,[BX+20H]       ; NEXT:MSDOS   SYS
                            MOV CX,0BH
                            REPE CMPSB
                            JZ LBL00000105
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
                            MOV BX,0700H
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
                            JMP WORD 0070H:0000H

LBL00000152:
                            LODSB
                            OR AL,AL
                            JZ LBL00000180
                            MOV AH,0EH
                            MOV BX,07H
                            INT 10H
                            JMP SHORT LBL00000152

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
