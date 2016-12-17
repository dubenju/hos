%ifndef LBA_2_CHS_INC
%define LBA_3_CHS_INC

;*******************************************************
; LBA_to_CHS() - LBA Converting CHS for floppy diskette
;
; description:
; input:
;        ax - LBA sector
;
; output:
;        ch - cylinder
;        cl - sector ( 1 - 63)
;        dh - head
;*******************************************************
LBA_to_CHS:
%define SPT        18
%define HPC        2
        mov cl, SPT
        div cl                           ; al = LBA / SPT, ah = LBA % SPT
; cylinder = LBA / SPT / HPC
        mov ch, al
        shr ch, (HPC / 2)                ; ch = cylinder               
; head = (LBA / SPT) % HPC
        mov dh, al
        and dh, 1                        ; dh = head
; sector = LBA % SPT + 1
        mov cl, al
        inc cl                           ; cl = sector
        ret
%endif
