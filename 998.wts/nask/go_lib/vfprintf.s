	.file	"vfprintf.c"
	.text
.globl _GO_vfprintf
	.def	_GO_vfprintf;	.scl	2;	.type	32;	.endef
_GO_vfprintf:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	movl	$65536, (%esp)
	call	_GO_malloc
	movl	%eax, %ebx
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%ebx, (%esp)
	call	_GO_vsprintf
	movl	%eax, %esi
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%ebx, (%esp)
	call	_GO_fputs
	movl	%ebx, (%esp)
	call	_GO_free
	movl	%esi, %eax
	addl	$16, %esp
	popl	%ebx
	popl	%esi
	leave
	ret
	.def	_GO_malloc;	.scl	2;	.type	32;	.endef
	.def	_GO_vsprintf;	.scl	2;	.type	32;	.endef
	.def	_GO_fputs;	.scl	2;	.type	32;	.endef
	.def	_GO_free;	.scl	2;	.type	32;	.endef
