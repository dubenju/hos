	.file	"malloc.c"
	.text
.globl _GO_malloc
	.def	_GO_malloc;	.scl	2;	.type	32;	.endef
_GO_malloc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$_GOL_memman, (%esp)
	call	_GOL_memmanalloc
	testl	%eax, %eax
	jne	L2
	movl	$1, (%esp)
	call	_GOL_sysabort
L2:
	leave
	ret
.globl _GO_free
	.def	_GO_free;	.scl	2;	.type	32;	.endef
_GO_free:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$_GOL_memman, (%esp)
	call	_GOL_memmanfree
	leave
	ret
	.comm	_GOL_memman, 8, 3
	.def	_GOL_memmanalloc;	.scl	2;	.type	32;	.endef
	.def	_GOL_sysabort;	.scl	2;	.type	32;	.endef
	.def	_GOL_memmanfree;	.scl	2;	.type	32;	.endef
