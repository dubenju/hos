	.file	"strncmp.c"
	.text
.globl _GO_strncmp
	.def	_GO_strncmp;	.scl	2;	.type	32;	.endef
_GO_strncmp:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %ebx
	movl	12(%ebp), %edx
	movl	16(%ebp), %ecx
	jmp	L2
L6:
	movb	(%ebx), %al
	testb	%al, %al
	je	L3
	decl	%ecx
	cmpb	(%edx), %al
	je	L4
L3:
	movsbl	%al, %eax
	movsbl	(%edx), %edx
	subl	%edx, %eax
	jmp	L5
L4:
	incl	%ebx
	incl	%edx
L2:
	testl	%ecx, %ecx
	jne	L6
	xorl	%eax, %eax
L5:
	popl	%ebx
	leave
	ret
