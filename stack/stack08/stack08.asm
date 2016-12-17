	TITLE	stack08.c
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
EXTRN	_gets:NEAR
EXTRN	_printf:NEAR
_DATA	SEGMENT
$SG337	DB	'Please type your name: ', 00H
$SG338	DB	'Hello, %s!', 00H
_DATA	ENDS
_TEXT	SEGMENT
_name$ = -8
_main	PROC NEAR

; 4    : int main ( ) {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp
  00003	83 ec 08	 sub	 esp, 8

; 5    :     char name[8];
; 6    :     printf("Please type your name: ");

  00006	68 00 00 00 00	 push	 OFFSET FLAT:$SG337
  0000b	e8 00 00 00 00	 call	 _printf
  00010	83 c4 04	 add	 esp, 4

; 7    :     gets(name);

  00013	8d 45 f8	 lea	 eax, DWORD PTR _name$[ebp]
  00016	50		 push	 eax
  00017	e8 00 00 00 00	 call	 _gets
  0001c	83 c4 04	 add	 esp, 4

; 8    :     printf("Hello, %s!", name);

  0001f	8d 4d f8	 lea	 ecx, DWORD PTR _name$[ebp]
  00022	51		 push	 ecx
  00023	68 00 00 00 00	 push	 OFFSET FLAT:$SG338
  00028	e8 00 00 00 00	 call	 _printf
  0002d	83 c4 08	 add	 esp, 8

; 9    :     return 0;

  00030	33 c0		 xor	 eax, eax

; 10   : }

  00032	8b e5		 mov	 esp, ebp
  00034	5d		 pop	 ebp
  00035	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
