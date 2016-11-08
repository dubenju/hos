	.file	"memcpy.c"
	.text
.globl _GO_memcpy
	.def	_GO_memcpy;	.scl	2;	.type	32;	.endef
_GO_memcpy:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ebx
	movl	16(%ebp), %esi
	xorl	%edx, %edx
	jmp	L2
L3:
	movb	(%ebx,%edx), %cl
	movb	%cl, (%eax,%edx)
	incl	%edx
	decl	%esi
L2:
	testl	%esi, %esi
	jne	L3
	popl	%ebx
	popl	%esi
	leave
	ret
