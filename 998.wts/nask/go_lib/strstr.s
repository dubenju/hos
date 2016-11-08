	.file	"strstr.c"
	.text
.globl _GO_strstr
	.def	_GO_strstr;	.scl	2;	.type	32;	.endef
_GO_strstr:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	movl	8(%ebp), %eax
	movl	12(%ebp), %ecx
	jmp	L2
L5:
	cmpb	$0, 1(%eax,%edx)
	je	L3
	movb	1(%ecx,%edx), %bl
	incl	%edx
	testb	%bl, %bl
	jne	L4
	jmp	L3
L6:
	xorl	%edx, %edx
L4:
	movb	(%ecx,%edx), %bl
	cmpb	%bl, (%eax,%edx)
	je	L5
	incl	%eax
L2:
	cmpb	$0, (%eax)
	jne	L6
	xorl	%eax, %eax
L3:
	popl	%ebx
	leave
	ret
