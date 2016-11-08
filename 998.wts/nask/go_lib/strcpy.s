	.file	"strcpy.c"
	.text
.globl _GO_strcpy
	.def	_GO_strcpy;	.scl	2;	.type	32;	.endef
_GO_strcpy:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ebx
	xorl	%edx, %edx
L2:
	movb	(%ebx,%edx), %cl
	movb	%cl, (%eax,%edx)
	incl	%edx
	testb	%cl, %cl
	jne	L2
	popl	%ebx
	leave
	ret
