;%define _BOOT_DEBUG_

%ifdef _BOOT_DEBUG_
    org  0100h
    BaseOfStack             equ 0100h
%else
    org  7C00h
    BaseOfStack             equ 7C00h
%endif

    BaseOfLoader            equ 9000h
    OffsetOfLoader          equ 0100h
    RootDirSectors          equ 14
    SectorNoOfRootDirectory equ 19
    SectorNoOfFAT1          equ 1
    DeltaSectorNo           equ 17

    JMP short LBL_START
    NOP

    BS_OEMName      DB 'ForrestY'    ; 46 6F 72 72 65 73 74 59          ( 8Byte)
    BPB_BytsPerSec  DW 512           ; 00 02                      (200) ( 2Byte) <-
    BPB_SecPerClus  DB 1             ; 01                               ( 1Byte)
    BPB_RsvdSecCnt  DW 1             ; 01 00                            ( 2Byte)
    BPB_NumFATs     DB 2             ; 02                               ( 1Byte)
    BPB_RootEntCnt  DW 224           ; E0 00                            ( 2Byte) <-
    BPB_TotSec16    DW 2880          ; 40 0B                      (B40) ( 2Byte)
    BPB_Media       DB 0xF0          ; F0                               ( 1Byte)
    BPB_FATSz16     DW 9             ; 09 00                            ( 2Byte)
    BPB_SecPerTrk   DW 18            ; 12 00                            ( 2Byte)
    BPB_NumHeads    DW 2             ; 02 00                            ( 2Byte)
    BPB_HiddSec     DD 0             ; 00 00 00 00                      ( 4Byte)
    BPB_TotSec32    DD 0             ; 00 00 00 00                      ( 4Byte)
    BS_DrvNum       DB 0             ; 00                               ( 1Byte)
    BS_Reserved1    DB 0             ; 00                               ( 1Byte)
    BS_BootSig      DB 29h           ; 29                               ( 1Byte)
    BS_VolID        DD 0             ; 00 00 00 00                      ( 4Byte)
    BS_VolLab       DB 'Tinix0.01  ' ; 54 69 6E 69 78 30 2E 30 31 20 20 (11Byte)
    BS_FileSysType  DB 'FAT12   '    ; 46 41 54 31 32 20 20 20          ( 8Byte)

LBL_START:
    MOV AX, CS
    MOV DS, AX
    MOV ES, AX
    MOV SS, AX
    MOV SP, 7C00H
;Graph Mode
;    MOV AX, 0012H
;    INT 10H

;Clear Screen
    MOV AX, 0600H ; AH=06H; AL=00H
    MOV BX, 0700H ; BH=07H
    MOV CX, 0     ; CH=LTR; CL=LTC
    MOV DX, 184FH ; DH=RBR ; DL=RBC
    INT 10H
;Reset Disk Drives
    MOV AH, 00H ; 
    MOV DL, 00H ; A:00H,C:80H
    INT 13H

;search dubenju.sys
    mov  word [wSectorNo], SectorNoOfRootDirectory
LABEL_SEARCH_IN_ROOT_DIR_BEGIN:
    cmp  word [wRootDirSizeForLoop], 0
    jz   LABEL_NO_LOADERBIN
    dec  word [wRootDirSizeForLoop]
    mov  ax, BaseOfLoader
    mov  es, ax
    mov  bx, OffsetOfLoader
    mov  ax, [wSectorNo]
    mov  cl, 1
    call ReadSector

    mov  si, LoaderFileName
    mov  di, OffsetOfLoader
    cld
    mov  dx, 10h
LABEL_SEARCH_FOR_LOADERBIN:
    cmp  dx, 0
    jz   LABEL_GOTO_NEXT_SECTOR_IN_ROOT_DIR
    dec  dx
    mov  cx, 11
LABEL_CMP_FILENAME:
    cmp  cx, 0
    jz   LABEL_FILENAME_FOUND
    dec  cx
    lodsb
    cmp  al, byte [es:di]
    jz   LABEL_GO_ON
    jmp  LABEL_DIFFERENT
LABEL_GO_ON:
    inc  di
    jmp  LABEL_CMP_FILENAME
LABEL_DIFFERENT:
    and  di, 0FFE0h
    add  di, 20h
    mov  si, LoaderFileName
    jmp  LABEL_SEARCH_FOR_LOADERBIN

LABEL_GOTO_NEXT_SECTOR_IN_ROOT_DIR:
    add  word [wSectorNo], 1
    jmp  LABEL_SEARCH_IN_ROOT_DIR_BEGIN

LABEL_NO_LOADERBIN:
    mov  dh, 2
    call DispStr
%ifdef _BOOT_DEBUG_
    mov  ax, 4c00h
    int  21h
%else
    jmp	 $    
%endif

LABEL_FILENAME_FOUND:
    mov  ax, RootDirSectors
    and  di, 0FFE0h
    add  di, 01Ah
    mov  cx, word [es:di]
    push cx
    add  cx, ax
    add  cx, DeltaSectorNo
    mov  ax, BaseOfLoader
    mov  es, ax
    mov  bx, OffsetOfLoader
    mov  ax, cx

LABEL_GOON_LOADING_FILE:
    push ax
    push bx
    mov  ah, 0Eh
    mov  al, '.'
    mov  bl, 0Fh
    int  10h
    pop  bx
    pop  ax
    mov  cl, 1
    call ReadSector
    pop  ax
    call GetFATEntry
    cmp  ax, 0FFFh
    jz   LABEL_FILE_LOADED
    push ax
    mov  dx, RootDirSectors
    add  ax, dx
    add  ax, DeltaSectorNo
    add  bx, [BPB_BytsPerSec]
    jmp  LABEL_GOON_LOADING_FILE
LABEL_FILE_LOADED:
    mov  dh, 1
    call DispStr

;    jmp  $
    jmp  BaseOfLoader:OffsetOfLoader

wRootDirSizeForLoop dw RootDirSectors
wSectorNo           dw 0
bOdd                db 0

LoaderFileName      db "DUBENJU SYS", 0
MessageLength       equ 9
BootMessage:        db "Booting  "
Message1            db "Ready.   "
Message2            db "No Loader"

DispStr:
    mov ax, MessageLength
    mul dh
    add ax, BootMessage
    mov bp, ax
    mov ax, ds
    mov es, ax
;    mov cx, 16
    mov cx, MessageLength
    mov ax, 01301h
    mov bx, 000ch
    mov dl, 0
    int 10h
    ret


ReadSector:
    push  bp
    mov   bp, sp
    sub   esp, 2              ;
    mov   byte [bp-2], cl
    push  bx                  ;
    mov   bl, [BPB_SecPerTrk] ;
    div   bl                  ;
    inc   ah                  ; z++
    mov   cl, ah              ;
    mov   dh, al
    shr   al, 1
    mov   ch, al
    and   dh, 1
    pop   bx                  ;
    mov   dl, [BS_DrvNum]
.GoOnReading:
    mov   ah, 2
    mov   al, byte [bp-2]
    int   13h
    jc    .GoOnReading
    add   esp, 2
    pop   bp
    ret

GetFATEntry:
    push es
    push bx
    push ax
    mov  ax, BaseOfLoader
    sub  ax, 0100h
    mov  es, ax
    pop  ax
    mov  byte [bOdd], 0
    mov  bx, 3
    mul  bx
    mov  bx, 2
    div  bx
    cmp  dx, 0
    jz   LABEL_EVEN
    mov  byte [bOdd], 1
LABEL_EVEN:
    xor  dx, dx
    mov  bx, [BPB_BytsPerSec]
    div  bx
    push dx
    mov  bx, 0
    add  ax, SectorNoOfFAT1
    mov  cl, 2
    call ReadSector
    pop  dx
    add  bx, dx
    mov  ax, [es:bx]
    cmp  byte [bOdd], 1
    jnz  LABEL_EVEN_2
    shr  ax, 4
LABEL_EVEN_2:
    and  ax, 0FFFh
LABEL_GET_FAT_ENRY_OK:
    pop  bx
    pop  es
    ret


 times 510-($-$$) DB 0H
;            DB 55H
;            DB 0AAH
            DW 0AA55H 


