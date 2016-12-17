; NASM
[bits 16]
org 0x7c00
    mov ax, cs
    mov ds, ax
    mov es, ax
    call check_int13hex
    test ax, ax
    mov ax, A20On
    jnz Print           ; Enabled
    mov ax, A20Off
Print:
    mov bp, ax
    mov cx, 16
    mov ax, 0x1301
    mov bx, 0x000c
    mov dl, 0
    int 0x10
    
    cli                 ; Shutdown
    hlt
 
check_int13hex:
    push ds
    push es
    push di
    push si
    cli
    xor ax, ax ; ax = 0
    mov ah, 0x41
    mov bx, 0x55aa
    mov dl, 0x80
    int 13h
    jc none
    test bx, 0xaa55
    jnz none
    cmp cx, 0x04
    jne none
;    mov es, ax
;    not ax ; ax = 0xFFFF
;    mov ds, ax
;    mov di, 0x0500
;    mov si, 0x0510
;    mov al, byte [es:di]
;    push ax
;    mov al, byte [ds:si]
;    push ax
;    mov byte [es:di], 0x00
;    mov byte [ds:si], 0xFF
;    cmp byte [es:di], 0xFF
;    pop ax
;    mov byte [ds:si], al
;    pop ax
;    mov byte [es:di], al

    mov ax, 0
    je check_int13hex__exit
none:
    mov ax, 1
check_int13hex__exit:
    pop si
    pop di
    pop es
    pop ds
    ret
A20On:
    db "INT 13H Ex is On "
A20Off:
    db "INT 13H Ex is Off "
times 510-($-$$) db 0
db 0x55
db 0xaa
