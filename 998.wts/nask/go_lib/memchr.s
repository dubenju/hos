	.file	"memchr.c"
	.text
.globl _GO_memchr
	.def	_GO_memchr;	.scl	2;	.type	32;	.endef
_GO_memchr:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	12(%ebp), %ecx
	movl	16(%ebp), %edx
	movl	8(%ebp), %eax
	jmp	L2
L4:
	decl	%edx
	movsbl	(%eax), %ebx
	cmpl	%ebx, %ecx
	je	L3
	incl	%eax
L2:
	testl	%edx, %edx
	jne	L4
	xorl	%eax, %eax
L3:
	popl	%ebx
	leave
	ret
