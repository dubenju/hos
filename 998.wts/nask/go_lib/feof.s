	.file	"feof.c"
	.text
.globl _GO_feof
	.def	_GO_feof;	.scl	2;	.type	32;	.endef
_GO_feof:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	cmpl	%edx, 8(%eax)
	setae	%al
	movzbl	%al, %eax
	leave
	ret
