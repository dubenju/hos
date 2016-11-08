	.file	"mmreallo.c"
	.text
.globl _GOL_memmanrealloc
	.def	_GOL_memmanrealloc;	.scl	2;	.type	32;	.endef
_GOL_memmanrealloc:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	movl	8(%ebp), %edi
	movl	12(%ebp), %ebx
	leal	-8(%ebx), %edx
	movl	16(%ebp), %eax
	addl	$15, %eax
	andl	$-8, %eax
	movl	-8(%ebx), %esi
	cmpl	%eax, %esi
	jb	L2
	jbe	L3
	leal	(%edx,%eax), %ecx
	subl	%eax, %esi
	movl	%esi, (%ecx)
	movl	%eax, (%edx)
	addl	$8, %ecx
	movl	%ecx, 4(%esp)
	movl	%edi, (%esp)
	call	_GOL_memmanfree
	jmp	L3
L2:
	subl	$8, %eax
	movl	%eax, 4(%esp)
	movl	%edi, (%esp)
	movl	%edx, -28(%ebp)
	call	_GOL_memmanalloc
	movl	%eax, %esi
	testl	%eax, %eax
	movl	-28(%ebp), %edx
	je	L4
	movl	(%edx), %eax
	subl	$8, %eax
	movl	%eax, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	%esi, (%esp)
	call	_GO_memcpy
L4:
	movl	%ebx, 4(%esp)
	movl	%edi, (%esp)
	call	_GOL_memmanfree
	movl	%esi, %ebx
L3:
	movl	%ebx, %eax
	addl	$44, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
	.def	_GOL_memmanfree;	.scl	2;	.type	32;	.endef
	.def	_GOL_memmanalloc;	.scl	2;	.type	32;	.endef
	.def	_GO_memcpy;	.scl	2;	.type	32;	.endef
