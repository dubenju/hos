	TITLE	lk01b.c
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
PUBLIC	_shared
_DATA	SEGMENT
_shared	DD	01H
_DATA	ENDS
PUBLIC	_swap
_TEXT	SEGMENT
_a$ = 8
_b$ = 12
_swap	PROC NEAR

; 3    : void swap(int * a, int * b) {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp

; 4    :     *a ^= *b ^= *a ^= *b;

  00003	8b 45 08	 mov	 eax, DWORD PTR _a$[ebp]
  00006	8b 4d 0c	 mov	 ecx, DWORD PTR _b$[ebp]
  00009	8b 10		 mov	 edx, DWORD PTR [eax]
  0000b	33 11		 xor	 edx, DWORD PTR [ecx]
  0000d	8b 45 08	 mov	 eax, DWORD PTR _a$[ebp]
  00010	89 10		 mov	 DWORD PTR [eax], edx
  00012	8b 4d 0c	 mov	 ecx, DWORD PTR _b$[ebp]
  00015	8b 55 08	 mov	 edx, DWORD PTR _a$[ebp]
  00018	8b 01		 mov	 eax, DWORD PTR [ecx]
  0001a	33 02		 xor	 eax, DWORD PTR [edx]
  0001c	8b 4d 0c	 mov	 ecx, DWORD PTR _b$[ebp]
  0001f	89 01		 mov	 DWORD PTR [ecx], eax
  00021	8b 55 08	 mov	 edx, DWORD PTR _a$[ebp]
  00024	8b 45 0c	 mov	 eax, DWORD PTR _b$[ebp]
  00027	8b 0a		 mov	 ecx, DWORD PTR [edx]
  00029	33 08		 xor	 ecx, DWORD PTR [eax]
  0002b	8b 55 08	 mov	 edx, DWORD PTR _a$[ebp]
  0002e	89 0a		 mov	 DWORD PTR [edx], ecx

; 5    : }

  00030	5d		 pop	 ebp
  00031	c3		 ret	 0
_swap	ENDP
_TEXT	ENDS
END
