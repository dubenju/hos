	.file	"atoi.c"
	.text
.globl _GO_atoi
	.def	_GO_atoi;	.scl	2;	.type	32;	.endef
_GO_atoi:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$10, 8(%esp)
	movl	$0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_GO_strtol
	leave
	ret
	.def	_GO_strtol;	.scl	2;	.type	32;	.endef
