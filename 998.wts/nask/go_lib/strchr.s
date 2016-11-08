	.file	"strchr.c"
	.text
.globl _GO_strchr
	.def	_GO_strchr;	.scl	2;	.type	32;	.endef
_GO_strchr:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ecx
	jmp	L2
L4:
	testb	%dl, %dl
	je	L5
	incl	%eax
L2:
	movb	(%eax), %dl
	movsbl	%dl, %ebx
	cmpl	%ebx, %ecx
	jne	L4
	jmp	L3
L5:
	xorl	%eax, %eax
L3:
	popl	%ebx
	leave
	ret
