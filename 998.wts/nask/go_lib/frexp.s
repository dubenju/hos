	.file	"frexp.c"
	.text
.globl _GO_frexp
	.def	_GO_frexp;	.scl	2;	.type	32;	.endef
_GO_frexp:
	pushl	%ebp
	movl	%esp, %ebp
	fldl	8(%ebp)
	fldz
	fucomp	%st(1)
	fnstsw	%ax
	sahf
	jbe	L21
	fchs
	fld1
	fchs
	jmp	L2
L21:
	fld1
L2:
	fldz
	fxch	%st(2)
	fucom	%st(2)
	fnstsw	%ax
	fstp	%st(2)
	sahf
	jp	L15
	je	L22
L15:
	xorl	%edx, %edx
	fld1
	fxch	%st(2)
	fucom	%st(2)
	fnstsw	%ax
	fstp	%st(2)
	sahf
	jb	L6
	flds	LC3
L18:
	incl	%edx
	fmul	%st, %st(2)
	fld1
	fxch	%st(3)
	fucom	%st(3)
	fnstsw	%ax
	fstp	%st(3)
	sahf
	jae	L18
	fstp	%st(0)
L6:
	flds	LC3
	fld	%st(0)
	fucomp	%st(3)
	fnstsw	%ax
	sahf
	jbe	L23
	fxch	%st(2)
	jmp	L17
L24:
	fxch	%st(2)
L17:
	decl	%edx
	fadd	%st(0), %st
	fxch	%st(2)
	fucom	%st(2)
	fnstsw	%ax
	sahf
	ja	L24
	fstp	%st(0)
	jmp	L4
L22:
	xorl	%edx, %edx
	jmp	L4
L23:
	fstp	%st(0)
L4:
	movl	16(%ebp), %eax
	movl	%edx, (%eax)
	fmulp	%st, %st(1)
	leave
	ret
	.section .rdata,"dr"
	.align 4
LC3:
	.long	1056964608
