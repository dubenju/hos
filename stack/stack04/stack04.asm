	TITLE	stack04.c
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
PUBLIC	_a
_DATA	SEGMENT
_a	DD	0cH
_DATA	ENDS
PUBLIC	_main
_TEXT	SEGMENT
_main	PROC NEAR

; 3    : int main(int argc, char * argv[]) {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp

; 4    :     return 0;

  00003	33 c0		 xor	 eax, eax

; 5    : }

  00005	5d		 pop	 ebp
  00006	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
