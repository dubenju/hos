	.file	"abort.c"
	.text
.globl _GO_abort
	.def	_GO_abort;	.scl	2;	.type	32;	.endef
_GO_abort:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$6, (%esp)
	call	_GOL_sysabort
	.def	_GOL_sysabort;	.scl	2;	.type	32;	.endef
