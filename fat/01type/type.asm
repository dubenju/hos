	TITLE	type.c
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
EXTRN	_printf:NEAR
_DATA	SEGMENT
$SG339	DB	'sizeof(char)  =%d', 0dH, 0aH, 00H
$SG341	DB	'sizeof(short) =%d', 0dH, 0aH, 00H
$SG343	DB	'sizeof(int)   =%d', 0dH, 0aH, 00H
$SG345	DB	'sizeof(long)  =%d', 0dH, 0aH, 00H
$SG347	DB	'sizeof(float) =%d', 0dH, 0aH, 00H
$SG349	DB	'sizeof(double)=%d', 0dH, 0aH, 00H
$SG351	DB	'sizeof(long double)=%d', 0dH, 0aH, 00H
	ORG $+3
$SG353	DB	'sizeof(char*)  =%d', 0dH, 0aH, 00H
	ORG $+3
$SG355	DB	'sizeof(short*) =%d', 0dH, 0aH, 00H
	ORG $+3
$SG357	DB	'sizeof(int*)   =%d', 0dH, 0aH, 00H
	ORG $+3
$SG359	DB	'sizeof(long*)  =%d', 0dH, 0aH, 00H
	ORG $+3
$SG361	DB	'sizeof(float*) =%d', 0dH, 0aH, 00H
	ORG $+3
$SG363	DB	'sizeof(double*)=%d', 0dH, 0aH, 00H
	ORG $+3
$SG365	DB	'sizeof(long double*)=%d', 0dH, 0aH, 00H
	ORG $+2
$SG366	DB	'%d %d %u %u', 0aH, 00H
	ORG $+3
$SG367	DB	'%d %d %u %u', 0aH, 00H
	ORG $+3
$SG368	DB	'%d %d %u %u', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_c$ = -4
_uc$ = -8
_main	PROC NEAR
; File type.c
; Line 9
	push	ebp
	mov	ebp, esp
	sub	esp, 8
; Line 14
	push	1
	push	OFFSET FLAT:$SG339
	call	_printf
	add	esp, 8
; Line 15
	push	2
	push	OFFSET FLAT:$SG341
	call	_printf
	add	esp, 8
; Line 16
	push	4
	push	OFFSET FLAT:$SG343
	call	_printf
	add	esp, 8
; Line 17
	push	4
	push	OFFSET FLAT:$SG345
	call	_printf
	add	esp, 8
; Line 23
	push	4
	push	OFFSET FLAT:$SG347
	call	_printf
	add	esp, 8
; Line 24
	push	8
	push	OFFSET FLAT:$SG349
	call	_printf
	add	esp, 8
; Line 25
	push	8
	push	OFFSET FLAT:$SG351
	call	_printf
	add	esp, 8
; Line 27
	push	4
	push	OFFSET FLAT:$SG353
	call	_printf
	add	esp, 8
; Line 28
	push	4
	push	OFFSET FLAT:$SG355
	call	_printf
	add	esp, 8
; Line 29
	push	4
	push	OFFSET FLAT:$SG357
	call	_printf
	add	esp, 8
; Line 30
	push	4
	push	OFFSET FLAT:$SG359
	call	_printf
	add	esp, 8
; Line 31
	push	4
	push	OFFSET FLAT:$SG361
	call	_printf
	add	esp, 8
; Line 32
	push	4
	push	OFFSET FLAT:$SG363
	call	_printf
	add	esp, 8
; Line 33
	push	4
	push	OFFSET FLAT:$SG365
	call	_printf
	add	esp, 8
; Line 35
	mov	BYTE PTR _c$[ebp], -128			; ffffff80H
; Line 36
	mov	BYTE PTR _uc$[ebp], 128			; 00000080H
; Line 37
	mov	eax, DWORD PTR _uc$[ebp]
	and	eax, 255				; 000000ffH
	push	eax
	mov	ecx, DWORD PTR _uc$[ebp]
	and	ecx, 255				; 000000ffH
	push	ecx
	movsx	edx, BYTE PTR _c$[ebp]
	push	edx
	movsx	eax, BYTE PTR _c$[ebp]
	push	eax
	push	OFFSET FLAT:$SG366
	call	_printf
	add	esp, 20					; 00000014H
; Line 38
	mov	BYTE PTR _c$[ebp], -1
; Line 39
	mov	BYTE PTR _uc$[ebp], 255			; 000000ffH
; Line 40
	mov	ecx, DWORD PTR _uc$[ebp]
	and	ecx, 255				; 000000ffH
	push	ecx
	mov	edx, DWORD PTR _uc$[ebp]
	and	edx, 255				; 000000ffH
	push	edx
	movsx	eax, BYTE PTR _c$[ebp]
	push	eax
	movsx	ecx, BYTE PTR _c$[ebp]
	push	ecx
	push	OFFSET FLAT:$SG367
	call	_printf
	add	esp, 20					; 00000014H
; Line 42
	mov	BYTE PTR _c$[ebp], 0
; Line 43
	mov	BYTE PTR _uc$[ebp], 1
; Line 44
	mov	edx, DWORD PTR _uc$[ebp]
	and	edx, 255				; 000000ffH
	push	edx
	mov	eax, DWORD PTR _uc$[ebp]
	and	eax, 255				; 000000ffH
	push	eax
	movsx	ecx, BYTE PTR _c$[ebp]
	push	ecx
	movsx	edx, BYTE PTR _c$[ebp]
	push	edx
	push	OFFSET FLAT:$SG368
	call	_printf
	add	esp, 20					; 00000014H
; Line 46
	xor	eax, eax
; Line 47
	mov	esp, ebp
	pop	ebp
	ret	0
_main	ENDP
_TEXT	ENDS
END
