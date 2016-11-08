	.file	"qsort.c"
	.text
	.def	_swap;	.scl	3;	.type	32;	.endef
_swap:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$4, %esp
	movl	%eax, %esi
	xorl	%ebx, %ebx
L2:
	movb	(%edx,%ebx), %al
	movb	%al, -9(%ebp)
	movb	(%ecx,%ebx), %al
	movb	%al, (%edx,%ebx)
	movb	-9(%ebp), %al
	movb	%al, (%ecx,%ebx)
	incl	%ebx
	cmpl	%ebx, %esi
	jne	L2
	popl	%eax
	popl	%ebx
	popl	%esi
	leave
	ret
.globl _GO_qsort
	.def	_GO_qsort;	.scl	2;	.type	32;	.endef
_GO_qsort:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	movl	8(%ebp), %esi
	movl	16(%ebp), %ebx
	testl	%ebx, %ebx
	je	L4
L10:
	cmpl	$1, 12(%ebp)
	jbe	L4
	movl	12(%ebp), %ecx
	shrl	%ecx
	imull	%ebx, %ecx
	leal	(%esi,%ecx), %ecx
	movl	%esi, %edx
	movl	%ebx, %eax
	call	_swap
	leal	(%esi,%ebx), %eax
	movl	%eax, -28(%ebp)
	xorl	%edi, %edi
	movl	$1, -32(%ebp)
L7:
	movl	%esi, 4(%esp)
	movl	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	*20(%ebp)
	testl	%eax, %eax
	jns	L6
	incl	%edi
	movl	%edi, %edx
	imull	%ebx, %edx
	leal	(%esi,%edx), %edx
	movl	-28(%ebp), %ecx
	movl	%ebx, %eax
	call	_swap
L6:
	incl	-32(%ebp)
	addl	%ebx, -28(%ebp)
	movl	12(%ebp), %eax
	cmpl	%eax, -32(%ebp)
	jb	L7
	movl	%edi, %ecx
	imull	%ebx, %ecx
	leal	(%esi,%ecx), %ecx
	movl	%esi, %edx
	movl	%ebx, %eax
	call	_swap
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	%ebx, 8(%esp)
	movl	%edi, 4(%esp)
	movl	%esi, (%esp)
	call	_GO_qsort
	movl	%edi, %eax
	notl	%eax
	addl	%eax, 12(%ebp)
	incl	%edi
	imull	%ebx, %edi
	addl	%edi, %esi
	jmp	L10
L4:
	addl	$44, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
