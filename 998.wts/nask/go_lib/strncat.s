	.file	"strncat.c"
	.text
.globl _GO_strncat
	.def	_GO_strncat;	.scl	2;	.type	32;	.endef
_GO_strncat:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$4, %esp
	movl	8(%ebp), %eax
	movl	12(%ebp), %esi
	movl	16(%ebp), %ecx
	movl	%eax, %edx
	jmp	L2
L3:
	incl	%edx
L2:
	cmpb	$0, (%edx)
	jne	L3
	jmp	L7
L6:
	testl	%ecx, %ecx
	je	L5
	decl	%ecx
	movb	-9(%ebp), %bl
	movb	%bl, (%edx)
	incl	%edx
	incl	%esi
L7:
	movb	(%esi), %bl
	movb	%bl, -9(%ebp)
	testb	%bl, %bl
	jne	L6
	testl	%ecx, %ecx
	je	L5
	movb	$0, (%edx)
L5:
	popl	%edx
	popl	%ebx
	popl	%esi
	leave
	ret
