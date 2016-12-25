	TITLE	lk01.c
	.386P
include listing.inc
if @Version gt 510
.model FLAT
else
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
_BSS	SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS	ENDS
_TLS	SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_main
EXTRN	_swap:NEAR
EXTRN	_shared:DWORD
_TEXT	SEGMENT
_a$ = -4
_main	PROC NEAR

; 5    : int main() {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp
  00003	51		 push	 ecx

; 6    :     int a = 100;

  00004	c7 45 fc 64 00
	00 00		 mov	 DWORD PTR _a$[ebp], 100	; 00000064H

; 7    :     swap(&a, &shared);

  0000b	68 00 00 00 00	 push	 OFFSET FLAT:_shared
  00010	8d 45 fc	 lea	 eax, DWORD PTR _a$[ebp]
  00013	50		 push	 eax
  00014	e8 00 00 00 00	 call	 _swap
  00019	83 c4 08	 add	 esp, 8

; 8    : }

  0001c	8b e5		 mov	 esp, ebp
  0001e	5d		 pop	 ebp
  0001f	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
