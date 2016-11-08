	.file	"fseek.c"
	.text
.globl _GO_fseek
	.def	_GO_fseek;	.scl	2;	.type	32;	.endef
_GO_fseek:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %edx
	movl	12(%ebp), %eax
	movl	16(%ebp), %ebx
	testl	%ebx, %ebx
	jne	L2
	movl	(%edx), %ecx
	addl	%eax, %ecx
	jmp	L3
L2:
	cmpl	$1, %ebx
	jne	L4
	movl	8(%edx), %ecx
	addl	%eax, %ecx
	jmp	L3
L4:
	xorl	%ecx, %ecx
	cmpl	$2, %ebx
	jne	L3
	movl	4(%edx), %ecx
	addl	%eax, %ecx
L3:
	orl	$-1, %eax
	cmpl	%ecx, (%edx)
	ja	L5
	cmpl	4(%edx), %ecx
	ja	L5
	movl	%ecx, 8(%edx)
	xorl	%eax, %eax
L5:
	popl	%ebx
	leave
	ret
