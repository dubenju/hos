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
        AND        EAX,7FFFFFFFH    ; bit31��0�ɂ���i�y�[�W���O�֎~�̂��߁j
        OR         EAX,00000001H    ; bit0��1�ɂ���i�v���e�N�g���[�h�ڍs�̂��߁j
        MOV        CR0,EAX
        JMP        pipelineflush
pipelineflush:
        MOV        AX,1*8            ;  �ǂݏ����\�Z�O�����g32bit
        MOV        DS,AX
        MOV        ES,AX
        MOV        FS,AX
        MOV        GS,AX
        MOV        SS,AX

        MOV        ESI,bootpack    ; �]����
        MOV        EDI,BOTPAK        ; �]����
        MOV        ECX,512*1024/4
        CALL    memcpy

        MOV        ESI,0700H        ; �]����
        MOV        EDI,DSKCAC        ; �]����
        MOV        ECX,512/4
        CALL    memcpy

        MOV        ESI,DSKCAC0+512    ; �]����
        MOV        EDI,DSKCAC+512    ; �]����
        MOV        ECX,0
        MOV        CL,BYTE [CYLS]
        IMUL       ECX,512*18*2/4    ; �V�����_������o�C�g��/4�ɕϊ�
        SUB        ECX,512/4        ; IPL�̕�������������
        CALL    memcpy

        MOV        EBX,BOTPAK
        MOV        ECX,[EBX+16]
        ADD        ECX,3            ; ECX += 3;
        SHR        ECX,2            ; ECX /= 4;
        JZ        skip            ; �]������ׂ����̂��Ȃ�
        MOV        ESI,[EBX+20]    ; �]����
        ADD        ESI,EBX
        MOV        EDI,[EBX+12]    ; �]����
        CALL    memcpy
skip:
        MOV        ESP,[EBX+12]    ; �X�^�b�N�����l
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
        JNZ        memcpy            ; �����Z�������ʂ�0�łȂ����memcpy��
        RET
; memcpy�̓A�h���X�T�C�Y�v���t�B�N�X�����Y��Ȃ���΁A�X�g�����O���߂ł�������

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
