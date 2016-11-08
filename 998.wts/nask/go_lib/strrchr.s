	.file	"strrchr.c"
	.text
.globl _GO_strrchr
	.def	_GO_strrchr;	.scl	2;	.type	32;	.endef
_GO_strrchr:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %edx
	movl	12(%ebp), %ecx
	movl	%edx, %eax
	jmp	L2
L3:
	incl	%eax
L2:
	cmpb	$0, (%eax)
	jne	L3
	jmp	L7
L6:
	movsbl	(%eax), %ebx
	cmpl	%ebx, %ecx
	je	L5
	decl	%eax
L7:
	cmpl	%eax, %edx
	jbe	L6
	xorl	%eax, %eax
L5:
	popl	%ebx
	leave
	ret
