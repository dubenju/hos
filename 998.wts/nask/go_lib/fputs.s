	.file	"fputs.c"
	.text
.globl _GO_fputs
	.def	_GO_fputs;	.scl	2;	.type	32;	.endef
_GO_fputs:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	movl	8(%ebp), %esi
	movl	%esi, (%esp)
	call	_GO_strlen
	movl	%eax, %ebx
	movl	12(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	%ebx, 8(%esp)
	movl	$1, 4(%esp)
	movl	%esi, (%esp)
	call	_GO_fwrite
	movl	%ebx, %eax
	addl	$16, %esp
	popl	%ebx
	popl	%esi
	leave
	ret
	.def	_GO_strlen;	.scl	2;	.type	32;	.endef
	.def	_GO_fwrite;	.scl	2;	.type	32;	.endef
