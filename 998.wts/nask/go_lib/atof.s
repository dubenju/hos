	.file	"atof.c"
	.text
.globl _GO_atof
	.def	_GO_atof;	.scl	2;	.type	32;	.endef
_GO_atof:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_GO_strtod
	leave
	ret
	.def	_GO_strtod;	.scl	2;	.type	32;	.endef
