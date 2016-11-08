	.file	"fputc.c"
	.text
.globl _GO_fputc
	.def	_GO_fputc;	.scl	2;	.type	32;	.endef
_GO_fputc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	movl	8(%edx), %ecx
	cmpl	4(%edx), %ecx
	jb	L2
	call	_GO_abort
L2:
	movb	%al, (%ecx)
	incl	%ecx
	movl	%ecx, 8(%edx)
	movzbl	%al, %eax
	leave
	ret
	.def	_GO_abort;	.scl	2;	.type	32;	.endef
