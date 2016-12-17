    TITLE    stack02.c
    .386P
include listing.inc

if @Version gt 510
.model FLAT
else
_TEXT   SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT   ENDS
_DATA   SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA   ENDS
CONST   SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST   ENDS
_BSS    SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS    ENDS
_TLS    SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS    ENDS
FLAT    GROUP _DATA, CONST, _BSS
    ASSUME    CS: FLAT, DS: FLAT, SS: FLAT
endif

PUBLIC    _main
_DATA    SEGMENT
$SG38    DB    '1234567890', 00H
    ORG $+1
$SG40    DB    '1234567890', 00H
_DATA    ENDS

_TEXT    SEGMENT
_a$ = -8
_c$ = -20
_p$ = -4
_main    PROC NEAR

; 2    : int main(int argc, char * argv[]) {

  00000    55             push     ebp
  00001    8b ec          mov     ebp, esp
  00003    83 ec 14       sub     esp, 20            ; 00000014H

; 3    :     char a = 1;

  00006    c6 45 f8 01    mov     BYTE PTR _a$[ebp], 1

; 4    :     char c[] = "1234567890";

  0000a    a1 00 00 00 00 mov     eax, DWORD PTR $SG38
  0000f    89 45 ec       mov     DWORD PTR _c$[ebp], eax
  00012    8b 0d 04 00 00
    00                    mov     ecx, DWORD PTR $SG38+4
  00018    89 4d f0       mov     DWORD PTR _c$[ebp+4], ecx
  0001b    66 8b 15 08 00
    00 00                 mov     dx, WORD PTR $SG38+8
  00022    66 89 55 f4    mov     WORD PTR _c$[ebp+8], dx
  00026    a0 0a 00 00 00 mov     al, BYTE PTR $SG38+10
  0002b    88 45 f6       mov     BYTE PTR _c$[ebp+10], al

; 5    :     char *p = "1234567890";

  0002e    c7 45 fc 00 00
    00 00                 mov     DWORD PTR _p$[ebp], OFFSET FLAT:$SG40

; 6    :     a = c[1];

  00035    8a 4d ed       mov     cl, BYTE PTR _c$[ebp+1]
  00038    88 4d f8       mov     BYTE PTR _a$[ebp], cl

; 7    :     a = p[1];

  0003b    8b 55 fc       mov     edx, DWORD PTR _p$[ebp]
  0003e    8a 42 01       mov     al, BYTE PTR [edx+1]
  00041    88 45 f8       mov     BYTE PTR _a$[ebp], al

; 8    :     return 0;

  00044    33 c0          xor     eax, eax

; 9    : }

  00046    8b e5          mov     esp, ebp
  00048    5d             pop     ebp
  00049    c3             ret     0
_main    ENDP
_TEXT    ENDS
END
