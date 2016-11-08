	.file	"strcat.c"
	.text
.globl _GO_strcat
	.def	_GO_strcat;	.scl	2;	.type	32;	.endef
_GO_strcat:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ecx
	movl	%eax, %edx
	jmp	L2
L3:
	incl	%edx
L2:
	cmpb	$0, (%edx)
	jne	L3
	jmp	L6
L5:
	movb	%bl, (%edx)
	incl	%edx
	incl	%ecx
L6:
	movb	(%ecx), %bl
	testb	%bl, %bl
	jne	L5
	movb	$0, (%edx)
	popl	%ebx
	leave
	ret
