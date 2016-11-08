	.file	"symalloc.c"
	.text
.globl _GOL_sysmalloc
	.def	_GOL_sysmalloc;	.scl	2;	.type	32;	.endef
_GOL_sysmalloc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$_GOL_sysman, (%esp)
	call	_GOL_memmanalloc
	testl	%eax, %eax
	jne	L2
	movl	$5, (%esp)
	call	_GOL_sysabort
L2:
	leave
	ret
.globl _GOL_sysfree
	.def	_GOL_sysfree;	.scl	2;	.type	32;	.endef
_GOL_sysfree:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$_GOL_sysman, (%esp)
	call	_GOL_memmanfree
	leave
	ret
	.comm	_GOL_sysman, 8, 3
	.def	_GOL_memmanalloc;	.scl	2;	.type	32;	.endef
	.def	_GOL_sysabort;	.scl	2;	.type	32;	.endef
	.def	_GOL_memmanfree;	.scl	2;	.type	32;	.endef
