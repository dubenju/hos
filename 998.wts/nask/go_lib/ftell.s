	.file	"ftell.c"
	.text
.globl _GO_ftell
	.def	_GO_ftell;	.scl	2;	.type	32;	.endef
_GO_ftell:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %ecx
	movl	(%ecx), %ebx
	movl	8(%ecx), %edx
	orl	$-1, %eax
	cmpl	%edx, %ebx
	ja	L2
	cmpl	4(%ecx), %edx
	ja	L2
	movl	%edx, %eax
	subl	%ebx, %eax
L2:
	popl	%ebx
	leave
	ret
