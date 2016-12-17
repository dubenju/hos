	TITLE	stack07.c
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
  00003	83 ec 0c	 sub	 esp, 12			; 0000000cH

; 3    :     int a;
; 4    :     int b;
; 5    :     int c;
; 6    :     
; 7    :     return 0;

  00006	33 c0		 xor	 eax, eax

; 8    : }

  00008	8b e5		 mov	 esp, ebp
  0000a	5d		 pop	 ebp
  0000b	c3		 ret	 0
_foo	ENDP
_TEXT	ENDS
PUBLIC	_main
_TEXT	SEGMENT
_main	PROC NEAR

; 10   : int main(int argc, char * argv[]) {

  0000c	55		 push	 ebp
  0000d	8b ec		 mov	 ebp, esp

; 11   :     foo();

  0000f	e8 00 00 00 00	 call	 _foo

; 12   :     return 0;

  00014	33 c0		 xor	 eax, eax

; 13   : }

  00016	5d		 pop	 ebp
  00017	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
