	.file	"fread.c"
	.section .rdata,"dr"
LC0:
	.ascii "GO_fread:size != 1.\12\0"
	.text
.globl _GO_fread
	.def	_GO_fread;	.scl	2;	.type	32;	.endef
_GO_fread:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	movl	20(%ebp), %esi
	cmpl	$1, 12(%ebp)
	je	L2
	movl	$_GO_stderr, 4(%esp)
	movl	$LC0, (%esp)
	call	_GO_fputs
	call	_GO_abort
L2:
	movl	8(%esi), %edx
	movl	4(%esi), %eax
	subl	%edx, %eax
	movl	16(%ebp), %ebx
	cmpl	%eax, %ebx
	jle	L3
	movl	%eax, %ebx
L3:
	cmpl	$0, %ebx
	jl	L5
	je	L4
	movl	%ebx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_GO_memcpy
	addl	%ebx, 8(%esi)
	jmp	L4
L5:
	xorl	%ebx, %ebx
L4:
	movl	%ebx, %eax
	addl	$16, %esp
	popl	%ebx
	popl	%esi
	leave
	ret
	.def	_GO_fputs;	.scl	2;	.type	32;	.endef
	.def	_GO_abort;	.scl	2;	.type	32;	.endef
	.def	_GO_memcpy;	.scl	2;	.type	32;	.endef
