	.file	"mmmalloc.c"
	.text
.globl _GOL_memmanalloc
	.def	_GOL_memmanalloc;	.scl	2;	.type	32;	.endef
_GOL_memmanalloc:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	8(%ebp), %ecx
	movl	12(%ebp), %edx
	addl	$15, %edx
	andl	$-8, %edx
	jmp	L3
L7:
	movl	%eax, %ecx
L3:
	movl	4(%ecx), %eax
	testl	%eax, %eax
	je	L6
	movl	(%eax), %esi
	cmpl	%edx, %esi
	jb	L7
	movl	4(%eax), %edi
	jne	L4
	movl	%edi, 4(%ecx)
	jmp	L5
L4:
	leal	(%eax,%edx), %ebx
	movl	%edi, 4(%ebx)
	subl	%edx, %esi
	movl	%esi, (%ebx)
	movl	%ebx, 4(%ecx)
L5:
	movl	%edx, (%eax)
	addl	$8, %eax
	jmp	L2
L6:
	xorl	%eax, %eax
L2:
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
.globl _GOL_memmanfree
	.def	_GOL_memmanfree;	.scl	2;	.type	32;	.endef
_GOL_memmanfree:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	12(%ebp), %ebx
	leal	-8(%ebx), %edx
	testl	%ebx, %ebx
	je	L8
	movl	8(%ebp), %eax
	jmp	L11
L13:
	movl	%ecx, %eax
L11:
	movl	4(%eax), %ecx
	testl	%ecx, %ecx
	je	L10
	cmpl	%edx, %ecx
	jb	L13
L10:
	movl	%edx, 4(%eax)
	movl	%ecx, 4(%edx)
	movl	-8(%ebx), %esi
	movl	%esi, %edi
	andl	$-8, %edi
	leal	(%edx,%edi), %edi
	cmpl	%edi, %ecx
	jne	L12
	addl	(%ecx), %esi
	movl	%esi, -8(%ebx)
	movl	4(%ecx), %ecx
	movl	%ecx, 4(%edx)
L12:
	movl	(%eax), %ecx
	movl	%ecx, %esi
	andl	$-8, %esi
	leal	(%eax,%esi), %esi
	cmpl	%esi, %edx
	jne	L8
	cmpl	8(%ebp), %eax
	je	L8
	addl	-8(%ebx), %ecx
	movl	%ecx, (%eax)
	movl	4(%edx), %edx
	movl	%edx, 4(%eax)
L8:
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
.globl _GOL_memmaninit
	.def	_GOL_memmaninit;	.scl	2;	.type	32;	.endef
_GOL_memmaninit:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %edx
	movl	16(%ebp), %eax
	movl	$8, (%edx)
	movl	%eax, 4(%edx)
	movl	12(%ebp), %edx
	movl	%edx, (%eax)
	movl	$0, 4(%eax)
	leave
	ret
