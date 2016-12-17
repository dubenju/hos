	TITLE	stack06.c
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
PUBLIC	_foo
_TEXT	SEGMENT
_foo	PROC NEAR

; 2    : int foo() {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp

; 3    :     return foo();

  00003	e8 00 00 00 00	 call	 _foo

; 4    : }

  00008	5d		 pop	 ebp
  00009	c3		 ret	 0
_foo	ENDP
_TEXT	ENDS
PUBLIC	_main
_TEXT	SEGMENT
_main	PROC NEAR

; 6    : int main(int argc, char * argv[]) {

  0000a	55		 push	 ebp
  0000b	8b ec		 mov	 ebp, esp

; 7    :     foo();

  0000d	e8 00 00 00 00	 call	 _foo

; 8    :     return 0;

  00012	33 c0		 xor	 eax, eax

; 9    : }

  00014	5d		 pop	 ebp
  00015	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
