	.file	"makefont.c"
	.intel_syntax noprefix
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
	.align 4
LC0:
	.ascii "usage>makefont source.txt font.bin\0"
LC1:
	.ascii "rb\0"
LC2:
	.ascii "wb\0"
LC3:
	.ascii "can't open input file.\0"
LC4:
	.ascii "can't open output file.\0"
	.text
.globl _main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	push	ebp
	mov	ebp, esp
	and	esp, -16
	sub	esp, 48
	call	___main
	cmp	DWORD PTR [ebp+8], 2
	jg	L2
	mov	DWORD PTR [esp], OFFSET FLAT:LC0
	call	_puts
	mov	eax, 1
	jmp	L3
L2:
	mov	eax, DWORD PTR [ebp+12]
	add	eax, 4
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp+4], OFFSET FLAT:LC1
	mov	DWORD PTR [esp], eax
	call	_fopen
	mov	DWORD PTR [esp+44], eax
	mov	eax, DWORD PTR [ebp+12]
	add	eax, 8
	mov	eax, DWORD PTR [eax]
	mov	DWORD PTR [esp+4], OFFSET FLAT:LC2
	mov	DWORD PTR [esp], eax
	call	_fopen
	mov	DWORD PTR [esp+40], eax
	cmp	DWORD PTR [esp+44], 0
	jne	L4
	mov	DWORD PTR [esp], OFFSET FLAT:LC3
	call	_puts
	mov	eax, 2
	jmp	L3
L4:
	cmp	DWORD PTR [esp+40], 0
	jne	L5
	mov	DWORD PTR [esp], OFFSET FLAT:LC4
	call	_puts
	mov	eax, 3
	jmp	L3
L5:
	mov	eax, DWORD PTR [esp+44]
	mov	DWORD PTR [esp+8], eax
	mov	DWORD PTR [esp+4], 12
	lea	eax, [esp+24]
	mov	DWORD PTR [esp], eax
	call	_fgets
	test	eax, eax
	je	L6
	mov	al, BYTE PTR [esp+24]
	cmp	al, 32
	je	L7
	mov	al, BYTE PTR [esp+24]
	cmp	al, 42
	je	L7
	mov	al, BYTE PTR [esp+24]
	cmp	al, 46
	jne	L6
L7:
	mov	al, BYTE PTR [esp+24]
	cmp	al, 42
	jne	L8
	mov	eax, 128
	jmp	L9
L8:
	mov	eax, 0
L9:
	mov	DWORD PTR [esp+36], eax
	mov	al, BYTE PTR [esp+25]
	cmp	al, 42
	jne	L10
	mov	eax, 64
	jmp	L11
L10:
	mov	eax, 0
L11:
	or	DWORD PTR [esp+36], eax
	mov	al, BYTE PTR [esp+26]
	cmp	al, 42
	jne	L12
	mov	eax, 32
	jmp	L13
L12:
	mov	eax, 0
L13:
	or	DWORD PTR [esp+36], eax
	mov	al, BYTE PTR [esp+27]
	cmp	al, 42
	jne	L14
	mov	eax, 16
	jmp	L15
L14:
	mov	eax, 0
L15:
	or	DWORD PTR [esp+36], eax
	mov	al, BYTE PTR [esp+28]
	cmp	al, 42
	jne	L16
	mov	eax, 8
	jmp	L17
L16:
	mov	eax, 0
L17:
	or	DWORD PTR [esp+36], eax
	mov	al, BYTE PTR [esp+29]
	cmp	al, 42
	jne	L18
	mov	eax, 4
	jmp	L19
L18:
	mov	eax, 0
L19:
	or	DWORD PTR [esp+36], eax
	mov	al, BYTE PTR [esp+30]
	cmp	al, 42
	jne	L20
	mov	eax, 2
	jmp	L21
L20:
	mov	eax, 0
L21:
	or	DWORD PTR [esp+36], eax
	mov	al, BYTE PTR [esp+31]
	cmp	al, 42
	sete	al
	movzx	eax, al
	or	DWORD PTR [esp+36], eax
	mov	eax, DWORD PTR [esp+40]
	mov	DWORD PTR [esp+4], eax
	mov	eax, DWORD PTR [esp+36]
	mov	DWORD PTR [esp], eax
	call	_fputc
L6:
	mov	eax, DWORD PTR [esp+44]
	mov	eax, DWORD PTR [eax+12]
	and	eax, 16
	test	eax, eax
	je	L5
	mov	eax, DWORD PTR [esp+44]
	mov	DWORD PTR [esp], eax
	call	_fclose
	mov	eax, DWORD PTR [esp+40]
	mov	DWORD PTR [esp], eax
	call	_fclose
	mov	eax, 0
L3:
	leave
	ret
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_fgets;	.scl	2;	.type	32;	.endef
	.def	_fputc;	.scl	2;	.type	32;	.endef
	.def	_fclose;	.scl	2;	.type	32;	.endef
