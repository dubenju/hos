	.file	"abs.c"
	.text
.globl _GO_abs
	.def	_GO_abs;	.scl	2;	.type	32;	.endef
_GO_abs:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	cltd
	xorl	%edx, %eax
	subl	%edx, %eax
	leave
	ret
