	.file	"makefont.c"
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
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$48, %esp
	call	___main
	cmpl	$2, 8(%ebp)
	jg	L2
	movl	$LC0, (%esp)
	call	_puts
	movl	$1, %eax
	jmp	L3
L2:
	movl	12(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	$LC1, 4(%esp)
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, 44(%esp)
	movl	12(%ebp), %eax
	addl	$8, %eax
	movl	(%eax), %eax
	movl	$LC2, 4(%esp)
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, 40(%esp)
	cmpl	$0, 44(%esp)
	jne	L4
	movl	$LC3, (%esp)
	call	_puts
	movl	$2, %eax
	jmp	L3
L4:
	cmpl	$0, 40(%esp)
	jne	L5
	movl	$LC4, (%esp)
	call	_puts
	movl	$3, %eax
	jmp	L3
L5:
	movl	44(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$12, 4(%esp)
	leal	24(%esp), %eax
	movl	%eax, (%esp)
	call	_fgets
	testl	%eax, %eax
	je	L6
	movb	24(%esp), %al
	cmpb	$32, %al
	je	L7
	movb	24(%esp), %al
	cmpb	$42, %al
	je	L7
	movb	24(%esp), %al
	cmpb	$46, %al
	jne	L6
L7:
	movb	24(%esp), %al
	cmpb	$42, %al
	jne	L8
	movl	$128, %eax
	jmp	L9
L8:
	movl	$0, %eax
L9:
	movl	%eax, 36(%esp)
	movb	25(%esp), %al
	cmpb	$42, %al
	jne	L10
	movl	$64, %eax
	jmp	L11
L10:
	movl	$0, %eax
L11:
	orl	%eax, 36(%esp)
	movb	26(%esp), %al
	cmpb	$42, %al
	jne	L12
	movl	$32, %eax
	jmp	L13
L12:
	movl	$0, %eax
L13:
	orl	%eax, 36(%esp)
	movb	27(%esp), %al
	cmpb	$42, %al
	jne	L14
	movl	$16, %eax
	jmp	L15
L14:
	movl	$0, %eax
L15:
	orl	%eax, 36(%esp)
	movb	28(%esp), %al
	cmpb	$42, %al
	jne	L16
	movl	$8, %eax
	jmp	L17
L16:
	movl	$0, %eax
L17:
	orl	%eax, 36(%esp)
	movb	29(%esp), %al
	cmpb	$42, %al
	jne	L18
	movl	$4, %eax
	jmp	L19
L18:
	movl	$0, %eax
L19:
	orl	%eax, 36(%esp)
	movb	30(%esp), %al
	cmpb	$42, %al
	jne	L20
	movl	$2, %eax
	jmp	L21
L20:
	movl	$0, %eax
L21:
	orl	%eax, 36(%esp)
	movb	31(%esp), %al
	cmpb	$42, %al
	sete	%al
	movzbl	%al, %eax
	orl	%eax, 36(%esp)
	movl	40(%esp), %eax
	movl	%eax, 4(%esp)
	movl	36(%esp), %eax
	movl	%eax, (%esp)
	call	_fputc
L6:
	movl	44(%esp), %eax
	movl	12(%eax), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L5
	movl	44(%esp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	40(%esp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$0, %eax
L3:
	leave
	ret
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_fgets;	.scl	2;	.type	32;	.endef
	.def	_fputc;	.scl	2;	.type	32;	.endef
	.def	_fclose;	.scl	2;	.type	32;	.endef
