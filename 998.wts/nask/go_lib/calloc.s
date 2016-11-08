	.file	"calloc.c"
	.text
.globl _GO_calloc
	.def	_GO_calloc;	.scl	2;	.type	32;	.endef
_GO_calloc:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	movl	12(%ebp), %ebx
	imull	8(%ebp), %ebx
	movl	%ebx, (%esp)
	call	_GO_malloc
	movl	%eax, %esi
	testl	%eax, %eax
	je	L2
	movl	%ebx, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_GO_memset
L2:
	movl	%esi, %eax
	addl	$16, %esp
	popl	%ebx
	popl	%esi
	leave
	ret
	.def	_GO_malloc;	.scl	2;	.type	32;	.endef
	.def	_GO_memset;	.scl	2;	.type	32;	.endef
