	.file	"strlen.c"
	.text
.globl _GO_strlen
	.def	_GO_strlen;	.scl	2;	.type	32;	.endef
_GO_strlen:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %edx
	movl	%edx, %eax
	jmp	L2
L3:
	incl	%eax
L2:
	cmpb	$0, (%eax)
	jne	L3
	subl	%edx, %eax
	leave
	ret
