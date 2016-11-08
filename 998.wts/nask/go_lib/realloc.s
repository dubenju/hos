	.file	"realloc.c"
	.text
.globl _GO_realloc
	.def	_GO_realloc;	.scl	2;	.type	32;	.endef
_GO_realloc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$_GOL_memman, (%esp)
	call	_GOL_memmanrealloc
	testl	%eax, %eax
	jne	L2
	movl	$1, (%esp)
	call	_GOL_sysabort
L2:
	leave
	ret
	.def	_GOL_memmanrealloc;	.scl	2;	.type	32;	.endef
	.def	_GOL_sysabort;	.scl	2;	.type	32;	.endef
