	.file	"strtoul0.c"
	.text
	.def	_prefix;	.scl	3;	.type	32;	.endef
_prefix:
	pushl	%ebp
	movl	%esp, %ebp
	leal	-97(%eax), %edx
	cmpl	$25, %edx
	ja	L2
	subl	$32, %eax
L2:
	movb	$2, %dl
	cmpl	$66, %eax
	je	L4
	movb	$10, %dl
	cmpl	$68, %eax
	je	L4
	movb	$8, %dl
	cmpl	$79, %eax
	je	L4
	cmpl	$88, %eax
	setne	%dl
	decl	%edx
	andl	$16, %edx
L4:
	movsbl	%dl, %eax
	leave
	ret
.globl _GO_strtoul0
	.def	_GO_strtoul0;	.scl	2;	.type	32;	.endef
_GO_strtoul0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$8, %esp
	movl	12(%ebp), %esi
	movl	8(%ebp), %eax
	movl	(%eax), %ebx
	testl	%esi, %esi
	jne	L10
	movw	$10, %si
	cmpb	$48, (%ebx)
	jne	L10
	movzbl	1(%ebx), %eax
	call	_prefix
	movl	%eax, %esi
	testl	%eax, %eax
	jne	L10
	movw	$8, %si
L10:
	cmpb	$48, (%ebx)
	jne	L11
	movzbl	1(%ebx), %eax
	call	_prefix
	cmpl	%eax, %esi
	jne	L11
	addl	$2, %ebx
L11:
	orl	$-1, %eax
	xorl	%edx, %edx
	divl	%esi
	movl	%eax, -16(%ebp)
	movl	16(%ebp), %edx
	movb	$0, (%edx)
	xorl	%eax, %eax
	movl	%ebx, -20(%ebp)
L19:
	movl	-20(%ebp), %ebx
	movb	(%ebx), %cl
	leal	-48(%ecx), %edi
	movl	$99, %edx
	movl	%edi, %ebx
	cmpb	$9, %bl
	ja	L12
	movzbl	%cl, %edx
	subl	$48, %edx
L12:
	leal	-65(%ecx), %edi
	movl	%edi, %ebx
	cmpb	$25, %bl
	ja	L13
	movzbl	%cl, %edx
	subl	$55, %edx
L13:
	leal	-97(%ecx), %edi
	movl	%edi, %ebx
	cmpb	$25, %bl
	ja	L14
	movzbl	%cl, %edx
	subl	$87, %edx
L14:
	cmpl	%esi, %edx
	jge	L15
	cmpl	-16(%ebp), %eax
	ja	L16
	imull	%esi, %eax
	movl	%eax, %ecx
	notl	%ecx
	leal	(%edx,%eax), %eax
	cmpl	%edx, %ecx
	jae	L18
L16:
	movl	16(%ebp), %eax
	movb	$1, (%eax)
	orl	$-1, %eax
L18:
	incl	-20(%ebp)
	jmp	L19
L15:
	movl	-20(%ebp), %ebx
	movl	8(%ebp), %edx
	movl	%ebx, (%edx)
	popl	%edx
	popl	%ecx
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
