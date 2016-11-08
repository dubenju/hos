	.file	"fgets.c"
	.text
.globl _GO_fgets
	.def	_GO_fgets;	.scl	2;	.type	32;	.endef
_GO_fgets:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$4, %esp
	movl	8(%ebp), %edx
	movl	16(%ebp), %ecx
	xorl	%eax, %eax
	movl	4(%ecx), %ebx
	cmpl	%ebx, 8(%ecx)
	jae	L2
	movl	%edx, %eax
L2:
	movl	12(%ebp), %ebx
	leal	-1(%ebx), %edi
	testl	%edi, %edi
	jle	L7
	testl	%eax, %eax
	je	L3
L8:
	movl	8(%ecx), %esi
	movb	(%esi), %bl
	movb	%bl, (%edx)
	incl	%edx
	incl	%esi
	movl	%esi, 8(%ecx)
	cmpb	$10, %bl
	je	L4
	cmpl	4(%ecx), %esi
	jae	L4
	decl	%edi
	jne	L8
L4:
	movb	$0, (%edx)
	jmp	L3
L7:
	xorl	%eax, %eax
L3:
	popl	%edx
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
