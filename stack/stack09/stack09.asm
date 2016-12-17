	TITLE	stack09.c
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
EXTRN	_execve:NEAR
_DATA	SEGMENT
$SG337	DB	'/bin/sh', 00H
_DATA	ENDS
_TEXT	SEGMENT
_name$ = -8
_main	PROC NEAR

; 4    : void main() {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp
  00003	83 ec 08	 sub	 esp, 8

; 5    :     char * name[2];
; 6    :     name[0] = "/bin/sh";

  00006	c7 45 f8 00 00
	00 00		 mov	 DWORD PTR _name$[ebp], OFFSET FLAT:$SG337

; 7    :     name[1] = NULL;

  0000d	c7 45 fc 00 00
	00 00		 mov	 DWORD PTR _name$[ebp+4], 0

; 8    :     execve(name[0], name, NULL);

  00014	6a 00		 push	 0
  00016	8d 45 f8	 lea	 eax, DWORD PTR _name$[ebp]
  00019	50		 push	 eax
  0001a	8b 4d f8	 mov	 ecx, DWORD PTR _name$[ebp]
  0001d	51		 push	 ecx
  0001e	e8 00 00 00 00	 call	 _execve
  00023	83 c4 0c	 add	 esp, 12			; 0000000cH

; 9    : }

  00026	8b e5		 mov	 esp, ebp
  00028	5d		 pop	 ebp
  00029	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
