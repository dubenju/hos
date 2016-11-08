	.file	"memmove.c"
	.text
.globl _GO_memmove
	.def	_GO_memmove;	.scl	2;	.type	32;	.endef
_GO_memmove:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %edi
	movl	16(%ebp), %edx
	cmpl	%edi, %eax
	ja	L2
	xorl	%ecx, %ecx
	jmp	L3
L2:
	leal	(%eax,%edx), %esi
	addl	%edx, %edi
	xorl	%ecx, %ecx
	jmp	L4
L5:
	movb	(%edi,%ecx), %bl
	movb	%bl, (%esi,%ecx)
	decl	%edx
L4:
	decl	%ecx
	testl	%edx, %edx
	jne	L5
	jmp	L6
L7:
	movb	(%edi,%ecx), %bl
	movb	%bl, (%eax,%ecx)
	incl	%ecx
	decl	%edx
L3:
	testl	%edx, %edx
	jne	L7
L6:
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
