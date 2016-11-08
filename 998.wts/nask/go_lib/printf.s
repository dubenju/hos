	.file	"printf.c"
	.text
.globl _GO_printf
	.def	_GO_printf;	.scl	2;	.type	32;	.endef
_GO_printf:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$32, %esp
	movl	8(%ebp), %esi
	movl	$65536, (%esp)
	call	_GO_malloc
	movl	%eax, %ebx
	movl	%esi, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	___builtin_stdarg_start
	movl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%esi, 4(%esp)
	movl	%ebx, (%esp)
	call	_GO_vsprintf
	movl	%eax, %esi
	movl	$_GO_stdout, 4(%esp)
	movl	%ebx, (%esp)
	call	_GO_fputs
	movl	%ebx, (%esp)
	call	_GO_free
	movl	%esi, %eax
	addl	$32, %esp
	popl	%ebx
	popl	%esi
	leave
	ret
	.def	_GO_malloc;	.scl	2;	.type	32;	.endef
	.def	___builtin_stdarg_start;	.scl	2;	.type	32;	.endef
	.def	_GO_vsprintf;	.scl	2;	.type	32;	.endef
	.def	_GO_fputs;	.scl	2;	.type	32;	.endef
	.def	_GO_free;	.scl	2;	.type	32;	.endef
