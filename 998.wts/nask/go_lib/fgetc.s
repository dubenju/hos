	.file	"fgetc.c"
	.text
.globl _GO_fgetc
	.def	_GO_fgetc;	.scl	2;	.type	32;	.endef
_GO_fgetc:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %edx
	movl	8(%edx), %ecx
	orl	$-1, %eax
	cmpl	4(%edx), %ecx
	jae	L2
	movzbl	(%ecx), %eax
	incl	%ecx
	movl	%ecx, 8(%edx)
L2:
	leave
	ret
