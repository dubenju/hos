	.file	"strdup.c"
	.text
.globl _GO_strdup
	.def	_GO_strdup;	.scl	2;	.type	32;	.endef
_GO_strdup:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	movl	8(%ebp), %esi
	movl	%esi, (%esp)
	call	_GO_strlen
	incl	%eax
	movl	%eax, (%esp)
	call	_GO_malloc
	movl	%eax, %ebx
	testl	%eax, %eax
	je	L2
	movl	%esi, 4(%esp)
	movl	%eax, (%esp)
	call	_GO_strcpy
L2:
	movl	%ebx, %eax
	addl	$16, %esp
	popl	%ebx
	popl	%esi
	leave
	ret
	.def	_GO_strlen;	.scl	2;	.type	32;	.endef
	.def	_GO_malloc;	.scl	2;	.type	32;	.endef
	.def	_GO_strcpy;	.scl	2;	.type	32;	.endef
