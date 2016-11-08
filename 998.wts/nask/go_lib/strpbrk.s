	.file	"strpbrk.c"
	.text
.globl _GO_strpbrk
	.def	_GO_strpbrk;	.scl	2;	.type	32;	.endef
_GO_strpbrk:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %esi
	jmp	L2
L4:
	cmpb	%bl, %cl
	je	L3
	incl	%edx
L5:
	movb	(%edx), %bl
	testb	%bl, %bl
	jne	L4
	incl	%eax
L2:
	movb	(%eax), %cl
	testb	%cl, %cl
	je	L6
	movl	%esi, %edx
	jmp	L5
L6:
	xorl	%eax, %eax
L3:
	popl	%ebx
	popl	%esi
	leave
	ret
