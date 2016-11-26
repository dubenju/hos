	.file	"makefont.ca"
	.data
LC0:
	.ascii "usage>makefont source.txt font.bin\0"
LC1:
	.ascii "rb\0"
LC2:
	.ascii "wb\0"
LC4:
	.ascii "can't open output file.\0"
LC3:
	.ascii "can't open input file.\0"
	.text
	.balign 2
.globl _main0
	.def	_main0;	.scl	2;	.type	32;	.endef
_main0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	movl	12(%ebp), %ebx
	cmpl	$2, 8(%ebp)
	jg	L2
	pushl	$LC0
	call	_puts
	movl	$1, %eax
L1:
	leal	-8(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%ebp
	ret
L2:
	pushl	$LC1
	pushl	4(%ebx)
	call	_fopen
	pushl	$LC2
	pushl	8(%ebx)
	movl	%eax, %esi
	call	_fopen
	movl	%eax, %ebx
	addl	$16, %esp
	testl	%esi, %esi
	je	L20
	testl	%eax, %eax
	je	L21
L5:
	pushl	%esi
	leal	-24(%ebp), %eax
	pushl	$12
	pushl	%eax
	call	_fgets
	addl	$12, %esp
	testl	%eax, %eax
	je	L7
	movb	-24(%ebp), %al
	cmpb	$32, %al
	je	L9
	cmpb	$42, %al
	je	L9
	cmpb	$46, %al
	je	L9
L7:
	pushl	%esi
	call	_feof
	popl	%edx
	testl	%eax, %eax
	je	L5
	pushl	%esi
	call	_fclose
	pushl	%ebx
	call	_fclose
	xorl	%eax, %eax
	jmp	L1
L9:
	cmpb	$42, %al
	sete	%al
	movzbl	%al, %eax
	sall	$7, %eax
	cmpb	$42, -23(%ebp)
	je	L22
L12:
	cmpb	$42, -22(%ebp)
	je	L23
L13:
	cmpb	$42, -21(%ebp)
	je	L24
L14:
	cmpb	$42, -20(%ebp)
	je	L25
L15:
	cmpb	$42, -19(%ebp)
	je	L26
L16:
	cmpb	$42, -18(%ebp)
	je	L27
L17:
	cmpb	$42, -17(%ebp)
	je	L28
L18:
	pushl	%ebx
	pushl	%eax
	call	_fputc
	popl	%ecx
	popl	%eax
	jmp	L7
L28:
	orl	$1, %eax
	jmp	L18
L27:
	orl	$2, %eax
	jmp	L17
L26:
	orl	$4, %eax
	jmp	L16
L25:
	orl	$8, %eax
	jmp	L15
L24:
	orl	$16, %eax
	jmp	L14
L23:
	orl	$32, %eax
	jmp	L13
L22:
	orl	$64, %eax
	jmp	L12
L21:
	pushl	$LC4
	call	_puts
	movl	$3, %eax
	jmp	L1
L20:
	pushl	$LC3
	call	_puts
	movl	$2, %eax
	jmp	L1
	.def	_fclose;	.scl	2;	.type	32;	.endef
	.def	_feof;	.scl	2;	.type	32;	.endef
	.def	_fputc;	.scl	2;	.type	32;	.endef
	.def	_fgets;	.scl	2;	.type	32;	.endef
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
