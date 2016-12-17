	TITLE	stack10.c
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
PUBLIC	_function
_TEXT	SEGMENT
_function PROC NEAR

; 2    : void function(int a, int b, int c) {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp
  00003	83 ec 14	 sub	 esp, 20			; 00000014H

; 3    :    char buffer1[5];
; 4    :    char buffer2[10];
; 5    : }

  00006	8b e5		 mov	 esp, ebp
  00008	5d		 pop	 ebp
  00009	c3		 ret	 0
_function ENDP
_TEXT	ENDS
PUBLIC	_main
_TEXT	SEGMENT
_main	PROC NEAR

; 6    : void main() {

  0000a	55		 push	 ebp
  0000b	8b ec		 mov	 ebp, esp

; 7    :  function(1,2,3);

  0000d	6a 03		 push	 3
  0000f	6a 02		 push	 2
  00011	6a 01		 push	 1
  00013	e8 00 00 00 00	 call	 _function
  00018	83 c4 0c	 add	 esp, 12			; 0000000cH

; 8    : }

  0001b	5d		 pop	 ebp
  0001c	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
