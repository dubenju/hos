	.file	"ungetc.c"
	.section .rdata,"dr"
LC0:
	.ascii "GO_ungetc:error!\12\0"
	.text
.globl _GO_ungetc
	.def	_GO_ungetc;	.scl	2;	.type	32;	.endef
_GO_ungetc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	12(%ebp), %edx
	movl	8(%edx), %eax
	cmpl	%eax, (%edx)
	jae	L2
	leal	-1(%eax), %ecx
	movzbl	-1(%eax), %eax
	cmpl	8(%ebp), %eax
	jne	L2
	movl	%ecx, 8(%edx)
	leave
	ret
L2:
	movl	$_GO_stderr, 4(%esp)
	movl	$LC0, (%esp)
	call	_GO_fputs
	call	_GO_abort
	.def	_GO_fputs;	.scl	2;	.type	32;	.endef
	.def	_GO_abort;	.scl	2;	.type	32;	.endef
