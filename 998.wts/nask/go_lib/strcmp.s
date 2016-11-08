	.file	"strcmp.c"
	.text
.globl _GO_strcmp
	.def	_GO_strcmp;	.scl	2;	.type	32;	.endef
_GO_strcmp:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %ecx
	movl	12(%ebp), %edx
	jmp	L2
L5:
	movb	(%edx), %bl
	cmpb	%bl, %al
	je	L3
	movsbl	%al, %eax
	movsbl	%bl, %ebx
	subl	%ebx, %eax
	jmp	L4
L3:
	incl	%ecx
	incl	%edx
L2:
	movb	(%ecx), %al
	testb	%al, %al
	jne	L5
	movsbl	(%edx), %eax
	negl	%eax
L4:
	popl	%ebx
	leave
	ret
