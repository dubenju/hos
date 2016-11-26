; NASM
[bits 16]
org 0x7c00
    mov ax, cs
    mov ds, ax
    mov es, ax
    call check_a20
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
 
check_a20:
    push ds
    push es
    push di
    push si
    cli
    xor ax, ax ; ax = 0
    mov es, ax
    not ax ; ax = 0xFFFF
    mov ds, ax
    mov di, 0x0500
    mov si, 0x0510
    mov al, byte [es:di]
    push ax
    mov al, byte [ds:si]
    push ax
    mov byte [es:di], 0x00
    mov byte [ds:si], 0xFF
    cmp byte [es:di], 0xFF
    pop ax
    mov byte [ds:si], al
    pop ax
    mov byte [es:di], al
    mov ax, 0
    je check_a20__exit
    mov ax, 1
check_a20__exit:
    pop si
    pop di
    pop es
    pop ds
    ret
A20On:
    db "A20 is On        "
A20Off:
    db "A20 is Off       "
times 510-($-$$) db 0
db 0x55
db 0xaa
