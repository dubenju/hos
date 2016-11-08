	.file	"ldexp.c"
	.text
.globl _GO_ldexp
	.def	_GO_ldexp;	.scl	2;	.type	32;	.endef
_GO_ldexp:
	pushl	%ebp
	movl	%esp, %ebp
	fldl	8(%ebp)
	movl	16(%ebp), %eax
	cmpl	$0, %eax
	jle	L2
L6:
	fadd	%st(0), %st
	decl	%eax
	jne	L6
	jmp	L4
L2:
	je	L4
	flds	LC0
L7:
	fmul	%st, %st(1)
	incl	%eax
	jne	L7
	fstp	%st(0)
L4:
	leave
	ret
	.section .rdata,"dr"
	.align 4
LC0:
	.long	1056964608
