	.file	"dummy.c"
	.section .rdata,"dr"
LC0:
	.ascii "GO_exit:mikan-trap!\12\0"
	.text
.globl _GO_exit
	.def	_GO_exit;	.scl	2;	.type	32;	.endef
_GO_exit:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$_GO_stderr, 4(%esp)
	movl	$LC0, (%esp)
	call	_GO_fputs
	movl	$4, (%esp)
	call	_GOL_sysabort
	.section .rdata,"dr"
LC1:
	.ascii "GO_atexit:mikan-trap!\12\0"
	.text
.globl _GO_atexit
	.def	_GO_atexit;	.scl	2;	.type	32;	.endef
_GO_atexit:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$_GO_stderr, 4(%esp)
	movl	$LC1, (%esp)
	call	_GO_fputs
	movl	$4, (%esp)
	call	_GOL_sysabort
	.section .rdata,"dr"
LC2:
	.ascii "GO_strtod:mikan-trap!\12\0"
	.text
.globl _GO_strtod
	.def	_GO_strtod;	.scl	2;	.type	32;	.endef
_GO_strtod:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$_GO_stderr, 4(%esp)
	movl	$LC2, (%esp)
	call	_GO_fputs
	movl	$4, (%esp)
	call	_GOL_sysabort
	.section .rdata,"dr"
LC3:
	.ascii "GO_sscanf:mikan-trap!\12\0"
	.text
.globl _GO_sscanf
	.def	_GO_sscanf;	.scl	2;	.type	32;	.endef
_GO_sscanf:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$_GO_stderr, 4(%esp)
	movl	$LC3, (%esp)
	call	_GO_fputs
	movl	$4, (%esp)
	call	_GOL_sysabort
	.section .rdata,"dr"
LC4:
	.ascii "GO_fscanf:mikan-trap!\12\0"
	.text
.globl _GO_fscanf
	.def	_GO_fscanf;	.scl	2;	.type	32;	.endef
_GO_fscanf:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$_GO_stderr, 4(%esp)
	movl	$LC4, (%esp)
	call	_GO_fputs
	movl	$4, (%esp)
	call	_GOL_sysabort
.globl _GO_bsearch
	.def	_GO_bsearch;	.scl	2;	.type	32;	.endef
_GO_bsearch:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	movl	12(%ebp), %ebx
	movl	16(%ebp), %edi
	xorl	%esi, %esi
	jmp	L7
L9:
	movl	%ebx, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	*24(%ebp)
	testl	%eax, %eax
	je	L8
	addl	20(%ebp), %ebx
	incl	%esi
L7:
	cmpl	%edi, %esi
	jb	L9
	xorl	%ebx, %ebx
L8:
	movl	%ebx, %eax
	addl	$28, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
	.section .rdata,"dr"
LC5:
	.ascii "GO_system:\0"
LC6:
	.ascii "\12\0"
	.text
.globl _GO_system
	.def	_GO_system;	.scl	2;	.type	32;	.endef
_GO_system:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$_GO_stderr, 4(%esp)
	movl	$LC5, (%esp)
	call	_GO_fputs
	movl	$_GO_stderr, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_GO_fputs
	movl	$_GO_stderr, 4(%esp)
	movl	$LC6, (%esp)
	call	_GO_fputs
	movl	$4, (%esp)
	call	_GOL_sysabort
	.def	_GO_fputs;	.scl	2;	.type	32;	.endef
	.def	_GOL_sysabort;	.scl	2;	.type	32;	.endef
