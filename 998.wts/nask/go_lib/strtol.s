	.file	"strtol.c"
	.text
.globl _GO_strtol
	.def	_GO_strtol;	.scl	2;	.type	32;	.endef
_GO_strtol:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$60, %esp
	movl	12(%ebp), %edi
	movl	8(%ebp), %edx
	jmp	L2
L3:
	incl	%eax
	movl	%eax, 8(%ebp)
L2:
	movl	8(%ebp), %eax
	movb	(%eax), %cl
	cmpb	$32, %cl
	jg	L16
	testb	%cl, %cl
	jne	L3
L16:
	xorl	%ebx, %ebx
	cmpb	$45, %cl
	jne	L18
	incl	%eax
	movl	%eax, 8(%ebp)
	movb	$1, %bl
	jmp	L18
L7:
	incl	%esi
	movl	%esi, 8(%ebp)
L18:
	movl	8(%ebp), %esi
	movb	(%esi), %al
	cmpb	$32, %al
	jg	L17
	testb	%al, %al
	jne	L7
L17:
	leal	-25(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	8(%ebp), %eax
	movl	%eax, (%esp)
	movl	%edx, -44(%ebp)
	call	_GO_strtoul0
	cmpl	%esi, 8(%ebp)
	movl	-44(%ebp), %edx
	jne	L9
	movl	%edx, 8(%ebp)
L9:
	testl	%edi, %edi
	je	L10
	movl	8(%ebp), %edx
	movl	%edx, (%edi)
L10:
	testl	%eax, %eax
	jns	L11
	movb	$1, -25(%ebp)
	cmpb	$1, %bl
	sbbl	%eax, %eax
	andl	$-2, %eax
	subl	$2147483647, %eax
L11:
	movb	-25(%ebp), %dl
	testb	%bl, %bl
	je	L12
	testb	%dl, %dl
	jne	L12
	negl	%eax
	jmp	L13
L12:
	testb	%dl, %dl
	je	L13
	movl	$34, _GO_errno
L13:
	addl	$60, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
	.def	_GO_strtoul0;	.scl	2;	.type	32;	.endef
