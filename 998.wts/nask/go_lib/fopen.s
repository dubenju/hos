	.file	"fopen.c"
	.text
.globl _GO_fopen
	.def	_GO_fopen;	.scl	2;	.type	32;	.endef
_GO_fopen:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	movl	$-1, -12(%ebp)
	movl	$_GO_stdout, %eax
	movl	12(%ebp), %edx
	cmpb	$119, (%edx)
	je	L2
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_GOL_stepdir
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_GOL_open
	movl	%eax, %ebx
	cmpl	$-1, %eax
	jne	L3
	movl	$2, _GO_errno
	xorl	%eax, %eax
	jmp	L2
L3:
	movl	$16, (%esp)
	call	_GOL_sysmalloc
	movl	%ebx, 12(%eax)
	movl	4(%ebx), %edx
	movl	%edx, 8(%eax)
	movl	%edx, (%eax)
	addl	(%ebx), %edx
	movl	%edx, 4(%eax)
L2:
	addl	$36, %esp
	popl	%ebx
	leave
	ret
	.def	_GOL_stepdir;	.scl	2;	.type	32;	.endef
	.def	_GOL_open;	.scl	2;	.type	32;	.endef
	.def	_GOL_sysmalloc;	.scl	2;	.type	32;	.endef
