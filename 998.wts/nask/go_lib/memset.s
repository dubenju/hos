	.file	"memset.c"
	.text
.globl _GO_memset
	.def	_GO_memset;	.scl	2;	.type	32;	.endef
_GO_memset:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ebx
	movl	16(%ebp), %ecx
	movl	%eax, %edx
	jmp	L2
L3:
	movb	%bl, (%edx)
	incl	%edx
	decl	%ecx
L2:
	testl	%ecx, %ecx
	jne	L3
	popl	%ebx
	leave
	ret
