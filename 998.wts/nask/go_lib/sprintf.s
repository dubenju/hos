	.file	"sprintf.c"
	.text
.globl _GO_sprintf
	.def	_GO_sprintf;	.scl	2;	.type	32;	.endef
_GO_sprintf:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$36, %esp
	movl	12(%ebp), %ebx
	movl	%ebx, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	___builtin_stdarg_start
	movl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_GO_vsprintf
	addl	$36, %esp
	popl	%ebx
	leave
	ret
	.def	___builtin_stdarg_start;	.scl	2;	.type	32;	.endef
	.def	_GO_vsprintf;	.scl	2;	.type	32;	.endef
