    TITLE    stack07.c
    .386P
include listing.inc
if @Version gt 510
.model FLAT
else
_TEXT    SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT    ENDS
_DATA    SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA    ENDS
CONST    SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST    ENDS
_BSS    SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS    ENDS
_TLS    SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS    ENDS
FLAT    GROUP _DATA, CONST, _BSS
    ASSUME    CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC    _foo
_TEXT    SEGMENT
_a$ = -4
_b$ = -8
_c$ = -12
_foo    PROC NEAR

; 2    : int foo() {

  00000    55         push     ebp
  00001    8b ec         mov     ebp, esp
  00003    83 ec 0c     sub     esp, 12            ; 0000000cH

; 3    :     int a;
; 4    :     int b;
; 5    :     int c;
; 6    :     
; 7    :     a = 2;

  00006    c7 45 fc 02 00
    00 00         mov     DWORD PTR _a$[ebp], 2

; 8    :     b = 3;

  0000d    c7 45 f8 03 00
    00 00         mov     DWORD PTR _b$[ebp], 3

; 9    :     c = 4;

  00014    c7 45 f4 04 00
    00 00         mov     DWORD PTR _c$[ebp], 4

; 10   : 
; 11   :     return 0;

  0001b    33 c0         xor     eax, eax

; 12   : }

  0001d    8b e5         mov     esp, ebp
  0001f    5d         pop     ebp
  00020    c3         ret     0
_foo    ENDP
_TEXT    ENDS
PUBLIC    _main
_TEXT    SEGMENT
_main    PROC NEAR

; 14   : int main(int argc, char * argv[]) {

  00021    55         push     ebp
  00022    8b ec         mov     ebp, esp

; 15   :     foo();

  00024    e8 00 00 00 00     call     _foo

; 16   :     return 0;

  00029    33 c0         xor     eax, eax

; 17   : }

  0002b    5d         pop     ebp
  0002c    c3         ret     0
_main    ENDP
_TEXT    ENDS
END
