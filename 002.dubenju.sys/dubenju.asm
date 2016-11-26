BOTPAK         EQU  00280000H        ;
DSKCAC         EQU  00100000H        ;
DSKCAC0        EQU  00000900H        ;

CYLS           EQU  05F0H
LEDS           EQU  05F1H
VMODE          EQU  05F2H
SCRNX          EQU  05F4H
SCRNY          EQU  05F6H
VRAM           EQU  05F8H

               ORG  0700H
;               cpu i486p
;[BITS 16]
;               section .data align=16

               MOV  AH, 00H
               MOV  AL, 13H
               INT  10H

               MOV  BYTE  [VMODE], 8
               MOV  WORD  [SCRNX], 640
               MOV  WORD  [SCRNY], 480
               MOV  DWORD [VRAM], 000A0000H
               MOV  BYTE  [CYLS], 1

;        MOV AH, 0BH
;        MOV BH, 00H
;        MOV BL, 0EH
;        INT 10H

               MOV  AH, 02H
               INT  16H
               MOV  [LEDS], AL

               MOV  AL , 0FFH
               OUT  21H, AL
               NOP
               OUT  0A1H, AL
               CLI

               IN  AL , 92H
               OR  AL , 02H     ; enable A20
               OUT 92H, AL

;[INSTRSET "i486p"]

LGDT    [GDTR0]    
        MOV        EAX,CR0
        AND        EAX,7FFFFFFFH    ; bit31を0にする（ページング禁止のため）
        OR         EAX,00000001H    ; bit0を1にする（プロテクトモード移行のため）
        MOV        CR0,EAX
        JMP        pipelineflush
pipelineflush:
        MOV        AX,1*8            ;  読み書き可能セグメント32bit
        MOV        DS,AX
        MOV        ES,AX
        MOV        FS,AX
        MOV        GS,AX
        MOV        SS,AX

        MOV        ESI,bootpack    ; 転送元
        MOV        EDI,BOTPAK        ; 転送先
        MOV        ECX,512*1024/4
        CALL    memcpy

        MOV        ESI,0700H        ; 転送元
        MOV        EDI,DSKCAC        ; 転送先
        MOV        ECX,512/4
        CALL    memcpy

        MOV        ESI,DSKCAC0+512    ; 転送元
        MOV        EDI,DSKCAC+512    ; 転送先
        MOV        ECX,0
        MOV        CL,BYTE [CYLS]
        IMUL       ECX,512*18*2/4    ; シリンダ数からバイト数/4に変換
        SUB        ECX,512/4        ; IPLの分だけ差し引く
        CALL    memcpy

        MOV        EBX,BOTPAK
        MOV        ECX,[EBX+16]
        ADD        ECX,3            ; ECX += 3;
        SHR        ECX,2            ; ECX /= 4;
        JZ        skip            ; 転送するべきものがない
        MOV        ESI,[EBX+20]    ; 転送元
        ADD        ESI,EBX
        MOV        EDI,[EBX+12]    ; 転送先
        CALL    memcpy
skip:
        MOV        ESP,[EBX+12]    ; スタック初期値
        JMP        DWORD 2*8:0x0000001b

waitkbdout:
        IN          AL,64H
        AND         AL,02H
        JNZ        waitkbdout
        RET

memcpy:
        MOV        EAX,[ESI]
        ADD        ESI,4
        MOV        [EDI],EAX
        ADD        EDI,4
        SUB        ECX,1
        JNZ        memcpy            ; 引き算した結果が0でなければmemcpyへ
        RET
; memcpyはアドレスサイズプリフィクスを入れ忘れなければ、ストリング命令でも書ける

;        ALIGNB    16
GDT0:
        DD 00000000H, 00000000H
        DD 0000FFFFH, 00CF9200H
        DD 0000FFFFH, 00479A28H

        DW        0
GDTR0:
        DW        8*3-1 ; limit 8 * n - 1
        DD        GDT0  ; base

;        ALIGNB    16
bootpack:
