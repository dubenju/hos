	.file	"fclose.c"
	.text
.globl _GO_fclose
	.def	_GO_fclose;	.scl	2;	.type	32;	.endef
_GO_fclose:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	8(%ebp), %ebx
	orl	$-1, %eax
	testl	%ebx, %ebx
	je	L2
	movl	12(%ebx), %eax
	cmpl	$-1, %eax
	je	L3
	movl	%eax, (%esp)
	call	_GOL_close
	movl	%ebx, (%esp)
	call	_GOL_sysfree
	xorl	%eax, %eax
	jmp	L2
L3:
	xorl	%eax, %eax
	cmpl	$_GO_stdout, %ebx
	je	L2
	xorl	%eax, %eax
	cmpl	$_GO_stderr, %ebx
	sete	%al
	decl	%eax
L2:
	addl	$20, %esp
	popl	%ebx
	leave
	ret
	.def	_GOL_close;	.scl	2;	.type	32;	.endef
	.def	_GOL_sysfree;	.scl	2;	.type	32;	.endef
