	.file	"nask.c"
	.text
	.balign 2
.globl _mainCRTStartup
	.def	_mainCRTStartup;	.scl	2;	.type	32;	.endef
_mainCRTStartup:
	pushl	%ebp
	movl	%esp, %ebp
	movl	$22052888, %eax
	call	__alloca
	leal	-22052872(%ebp), %eax
	addl	$15, %eax
	andl	$-16, %eax
	movl	%eax, -22052876(%ebp)
	movl	-22052876(%ebp), %eax
	movl	%eax, _GO_stdout+8
	movl	%eax, _GO_stdout
	movl	_GO_stdout, %eax
	addl	$16384, %eax
	movl	%eax, _GO_stdout+4
	movl	$-1, _GO_stdout+12
	movl	-22052876(%ebp), %eax
	addl	$16384, %eax
	movl	%eax, _GO_stderr+8
	movl	_GO_stderr+8, %eax
	movl	%eax, _GO_stderr
	movl	_GO_stderr, %eax
	addl	$16384, %eax
	movl	%eax, _GO_stderr+4
	movl	$-1, _GO_stderr+12
	subl	$4, %esp
	movl	-22052876(%ebp), %eax
	addl	$32768, %eax
	pushl	%eax
	pushl	$1048576
	pushl	$_GOL_sysman
	call	_GOL_memmaninit
	addl	$16, %esp
	subl	$4, %esp
	movl	-22052876(%ebp), %eax
	addl	$1081344, %eax
	movl	%eax, _GOL_work0
	movl	_GOL_work0, %eax
	pushl	%eax
	pushl	$8388608
	pushl	$_GOL_memman
	call	_GOL_memmaninit
	addl	$16, %esp
	subl	$12, %esp
	leal	-22052880(%ebp), %eax
	pushl	%eax
	call	_ConvCmdLine0
	addl	$16, %esp
	movl	%eax, -22052884(%ebp)
	subl	$4, %esp
	movl	-22052876(%ebp), %eax
	addl	$9469952, %eax
	pushl	%eax
	pushl	-22052884(%ebp)
	pushl	-22052880(%ebp)
	call	_main1
	addl	$16, %esp
	movl	%eax, _GOL_retcode
	subl	$12, %esp
	pushl	$0
	call	_GOL_sysabort
	addl	$16, %esp
	leave
	ret
	.balign 2
.globl _ConvCmdLine0
	.def	_ConvCmdLine0;	.scl	2;	.type	32;	.endef
_ConvCmdLine0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$0, -4(%ebp)
	call	_GetCommandLineA@0
	movl	%eax, -12(%ebp)
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_GO_strlen
	addl	$4, %esp
	incl	%eax
	pushl	%eax
	call	_GOL_sysmalloc
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -16(%ebp)
L6:
	movl	-16(%ebp), %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movb	(%eax), %cl
	movb	%cl, (%edx)
	leal	-12(%ebp), %eax
	incl	(%eax)
	leal	-16(%ebp), %eax
	incl	(%eax)
	cmpb	$32, %cl
	ja	L6
	leal	-4(%ebp), %eax
	incl	(%eax)
	leal	-12(%ebp), %eax
	decl	(%eax)
	movl	-16(%ebp), %eax
	decl	%eax
	movb	$0, (%eax)
L9:
	movl	-12(%ebp), %eax
	cmpb	$0, (%eax)
	je	L5
	movl	-12(%ebp), %eax
	cmpb	$32, (%eax)
	jbe	L11
	jmp	L5
L11:
	leal	-12(%ebp), %eax
	incl	(%eax)
	jmp	L9
L5:
	movl	-12(%ebp), %eax
	cmpb	$0, (%eax)
	jne	L6
	subl	$12, %esp
	movl	-4(%ebp), %eax
	sall	$2, %eax
	addl	$4, %eax
	pushl	%eax
	call	_GOL_sysmalloc
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %edx
	movl	-20(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	%eax, (%edx)
	movl	$1, -8(%ebp)
L14:
	movl	-8(%ebp), %eax
	cmpl	-4(%ebp), %eax
	jl	L17
	jmp	L15
L17:
	movl	-16(%ebp), %eax
	movl	%eax, %edx
	leal	-16(%ebp), %eax
	incl	(%eax)
	cmpb	$0, (%edx)
	jne	L17
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %ecx
	movl	-24(%ebp), %edx
	movl	-16(%ebp), %eax
	movl	%eax, (%edx,%ecx)
	leal	-8(%ebp), %eax
	incl	(%eax)
	jmp	L14
L15:
	movl	-8(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	-24(%ebp), %eax
	movl	$0, (%eax,%edx)
	movl	8(%ebp), %edx
	movl	-4(%ebp), %eax
	movl	%eax, (%edx)
	movl	-24(%ebp), %eax
	leave
	ret
	.balign 2
.globl _GOLD_getsize
	.def	_GOLD_getsize;	.scl	2;	.type	32;	.endef
_GOLD_getsize:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	$-1, -8(%ebp)
	subl	$4, %esp
	pushl	$0
	pushl	$128
	pushl	$3
	pushl	$0
	pushl	$1
	pushl	$-2147483648
	pushl	8(%ebp)
	call	_CreateFileA@28
	addl	$4, %esp
	movl	%eax, -4(%ebp)
	cmpl	$-1, -4(%ebp)
	jne	L21
	jmp	L22
L21:
	subl	$8, %esp
	pushl	$0
	pushl	-4(%ebp)
	call	_GetFileSize@8
	addl	$8, %esp
	movl	%eax, -8(%ebp)
	subl	$12, %esp
	pushl	-4(%ebp)
	call	_CloseHandle@4
	addl	$12, %esp
L22:
	movl	-8(%ebp), %eax
	leave
	ret
	.balign 2
.globl _GOLD_read
	.def	_GOLD_read;	.scl	2;	.type	32;	.endef
_GOLD_read:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	subl	$4, %esp
	pushl	$0
	pushl	$128
	pushl	$3
	pushl	$0
	pushl	$1
	pushl	$-2147483648
	pushl	8(%ebp)
	call	_CreateFileA@28
	addl	$4, %esp
	movl	%eax, -4(%ebp)
	cmpl	$-1, -4(%ebp)
	jne	L24
	jmp	L25
L24:
	subl	$12, %esp
	pushl	$0
	leal	-8(%ebp), %eax
	pushl	%eax
	pushl	12(%ebp)
	pushl	16(%ebp)
	pushl	-4(%ebp)
	call	_ReadFile@20
	addl	$12, %esp
	subl	$12, %esp
	pushl	-4(%ebp)
	call	_CloseHandle@4
	addl	$12, %esp
	movl	12(%ebp), %eax
	cmpl	-8(%ebp), %eax
	je	L26
	jmp	L25
L26:
	movl	$0, -12(%ebp)
	jmp	L23
L25:
	movl	$1, -12(%ebp)
L23:
	movl	-12(%ebp), %eax
	leave
	ret
	.balign 2
.globl _GOLD_write_b
	.def	_GOLD_write_b;	.scl	2;	.type	32;	.endef
_GOLD_write_b:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$0, -8(%ebp)
	cmpl	$0, 8(%ebp)
	je	L28
	subl	$4, %esp
	pushl	$0
	pushl	$32
	pushl	$2
	pushl	$0
	pushl	$0
	pushl	$1073741824
	pushl	8(%ebp)
	call	_CreateFileA@28
	addl	$4, %esp
	movl	%eax, -4(%ebp)
	jmp	L29
L28:
	subl	$12, %esp
	pushl	$-11
	call	_GetStdHandle@4
	addl	$12, %esp
	movl	%eax, -4(%ebp)
L29:
	cmpl	$-1, -4(%ebp)
	jne	L30
	jmp	L31
L30:
	cmpl	$0, 12(%ebp)
	je	L32
	subl	$12, %esp
	pushl	$0
	leal	-8(%ebp), %eax
	pushl	%eax
	pushl	12(%ebp)
	pushl	16(%ebp)
	pushl	-4(%ebp)
	call	_WriteFile@20
	addl	$12, %esp
L32:
	cmpl	$0, 8(%ebp)
	je	L33
	subl	$12, %esp
	pushl	-4(%ebp)
	call	_CloseHandle@4
	addl	$12, %esp
L33:
	movl	-8(%ebp), %eax
	cmpl	12(%ebp), %eax
	je	L34
	jmp	L31
L34:
	movl	$0, -12(%ebp)
	jmp	L27
L31:
	movl	$1, -12(%ebp)
L27:
	movl	-12(%ebp), %eax
	leave
	ret
	.balign 2
.globl _errmsgout
	.def	_errmsgout;	.scl	2;	.type	32;	.endef
_errmsgout:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	_GO_strlen
	addl	$16, %esp
	movl	%eax, -4(%ebp)
	movb	$0, -5(%ebp)
	movl	$_GO_stderr, -12(%ebp)
	movl	-12(%ebp), %ecx
	movl	-12(%ebp), %eax
	movl	8(%eax), %edx
	movl	4(%ecx), %eax
	subl	%edx, %eax
	cmpl	%eax, -4(%ebp)
	jl	L36
	movl	-12(%ebp), %ecx
	movl	-12(%ebp), %eax
	movl	8(%eax), %edx
	movl	4(%ecx), %eax
	subl	%edx, %eax
	movl	%eax, -4(%ebp)
	leal	-5(%ebp), %eax
	incb	(%eax)
L36:
	cmpl	$0, -4(%ebp)
	jle	L37
	subl	$4, %esp
	pushl	-4(%ebp)
	pushl	8(%ebp)
	movl	-12(%ebp), %eax
	pushl	8(%eax)
	call	_GO_memcpy
	addl	$16, %esp
	movl	-12(%ebp), %ecx
	movl	-12(%ebp), %edx
	movl	-4(%ebp), %eax
	addl	8(%edx), %eax
	movl	%eax, 8(%ecx)
L37:
	cmpb	$0, -5(%ebp)
	je	L35
	subl	$12, %esp
	pushl	$3
	call	_GOL_sysabort
	addl	$16, %esp
L35:
	leave
	ret
	.data
LC0:
	.ascii "\15\12\0"
	.text
	.balign 2
.globl _errmsgout_s_NL
	.def	_errmsgout_s_NL;	.scl	2;	.type	32;	.endef
_errmsgout_s_NL:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	_errmsgout
	addl	$16, %esp
	subl	$12, %esp
	pushl	12(%ebp)
	call	_errmsgout
	addl	$16, %esp
	subl	$12, %esp
	pushl	$LC0
	call	_errmsgout
	addl	$16, %esp
	leave
	ret
.globl _nask_errors
	.data
	.balign 4
_nask_errors:
	.long	0
LC1:
	.ascii "usage : >nask source [object/binary] [list]\15\12\0"
LC2:
	.ascii "NASK : can't open \0"
LC3:
	.ascii "NASK : too large \0"
LC4:
	.ascii "NASK : can't read \0"
LC5:
	.ascii "NASK : LSTBUF is not enough\15\12\0"
LC6:
	.ascii "NASK : TMPBUF is not enough\15\12\0"
LC7:
	.ascii "NASK : BINBUF is not enough\15\12\0"
LC8:
	.ascii "NASK : list output error\15\12\0"
LC9:
	.ascii "NASK : object/binary output error\15\12\0"
LC10:
	.ascii "NASK : \0"
LC11:
	.ascii " errors.\15\12\0"
	.text
	.balign 2
.globl _main1
	.def	_main1;	.scl	2;	.type	32;	.endef
_main1:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$84, %esp
	movl	16(%ebp), %eax
	addl	$2097152, %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	addl	$4194304, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	addl	$2097152, %eax
	movl	%eax, -32(%ebp)
	cmpl	$1, 8(%ebp)
	jle	L42
	cmpl	$4, 8(%ebp)
	jg	L42
	jmp	L41
L42:
	subl	$12, %esp
	pushl	$LC1
	call	_errmsgout
	addl	$16, %esp
	movl	$16, -60(%ebp)
	jmp	L40
L41:
	subl	$12, %esp
	movl	12(%ebp), %eax
	addl	$4, %eax
	pushl	(%eax)
	call	_GOLD_getsize
	addl	$16, %esp
	movl	%eax, -40(%ebp)
	cmpl	$-1, -40(%ebp)
	jne	L43
	subl	$8, %esp
	movl	12(%ebp), %eax
	addl	$4, %eax
	pushl	(%eax)
	pushl	$LC2
	call	_errmsgout_s_NL
	addl	$16, %esp
	movl	$17, -60(%ebp)
	jmp	L40
L43:
	cmpl	$2097152, -40(%ebp)
	jle	L44
	subl	$8, %esp
	movl	12(%ebp), %eax
	addl	$4, %eax
	pushl	(%eax)
	pushl	$LC3
	call	_errmsgout_s_NL
	addl	$16, %esp
	movl	$17, -60(%ebp)
	jmp	L40
L44:
	subl	$4, %esp
	pushl	16(%ebp)
	pushl	-40(%ebp)
	movl	12(%ebp), %eax
	addl	$4, %eax
	pushl	(%eax)
	call	_GOLD_read
	addl	$16, %esp
	testl	%eax, %eax
	je	L45
	subl	$8, %esp
	movl	12(%ebp), %eax
	addl	$4, %eax
	pushl	(%eax)
	pushl	$LC4
	call	_errmsgout_s_NL
	addl	$16, %esp
	movl	$17, -60(%ebp)
	jmp	L40
L45:
	movl	-40(%ebp), %eax
	addl	16(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-32(%ebp), %eax
	addl	$4194304, %eax
	pushl	%eax
	pushl	-32(%ebp)
	pushl	-12(%ebp)
	pushl	16(%ebp)
	call	_nask
	addl	$16, %esp
	movl	%eax, -36(%ebp)
	cmpl	$0, -36(%ebp)
	jne	L46
L47:
	subl	$12, %esp
	pushl	$LC5
	call	_errmsgout
	addl	$16, %esp
	movl	$19, -60(%ebp)
	jmp	L40
L46:
	movl	-24(%ebp), %eax
	addl	$4194304, %eax
	pushl	%eax
	pushl	-24(%ebp)
	pushl	-36(%ebp)
	pushl	-32(%ebp)
	call	_LL
	addl	$16, %esp
	movl	%eax, -28(%ebp)
	cmpl	$0, -28(%ebp)
	jne	L48
L49:
	subl	$12, %esp
	pushl	$LC6
	call	_errmsgout
	addl	$16, %esp
	movl	$19, -60(%ebp)
	jmp	L40
L48:
	subl	$8, %esp
	movl	-32(%ebp), %eax
	addl	$4194302, %eax
	pushl	%eax
	pushl	-32(%ebp)
	movl	-16(%ebp), %eax
	addl	$2097152, %eax
	pushl	%eax
	pushl	-16(%ebp)
	pushl	-28(%ebp)
	pushl	-24(%ebp)
	call	_output
	addl	$32, %esp
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jne	L50
	subl	$12, %esp
	pushl	$LC7
	call	_errmsgout
	addl	$16, %esp
	movl	$19, -60(%ebp)
	jmp	L40
L50:
	cmpl	$4, 8(%ebp)
	jne	L51
	movl	-32(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-32(%ebp), %eax
	addl	$4194303, %eax
	cmpb	$0, (%eax)
	je	L52
	jmp	L47
L52:
	nop
L53:
	movl	-28(%ebp), %eax
	cmpb	$0, (%eax)
	je	L54
	movl	-32(%ebp), %eax
	addl	$4194304, %eax
	cmpl	%eax, -28(%ebp)
	jb	L55
	jmp	L54
L55:
	leal	-28(%ebp), %eax
	incl	(%eax)
	jmp	L53
L54:
	subl	$4, %esp
	pushl	-32(%ebp)
	movl	-32(%ebp), %edx
	movl	-28(%ebp), %eax
	subl	%edx, %eax
	pushl	%eax
	movl	12(%ebp), %eax
	addl	$12, %eax
	pushl	(%eax)
	call	_GOLD_write_b
	addl	$16, %esp
	testl	%eax, %eax
	je	L51
	subl	$12, %esp
	pushl	$LC8
	call	_errmsgout
	addl	$16, %esp
	movl	$20, -60(%ebp)
	jmp	L40
L51:
	cmpl	$2, 8(%ebp)
	jle	L58
	movl	-20(%ebp), %eax
	cmpl	-16(%ebp), %eax
	jae	L59
	movl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
L59:
	subl	$4, %esp
	pushl	-16(%ebp)
	movl	-16(%ebp), %edx
	movl	-20(%ebp), %eax
	subl	%edx, %eax
	pushl	%eax
	movl	12(%ebp), %eax
	addl	$8, %eax
	pushl	(%eax)
	call	_GOLD_write_b
	addl	$16, %esp
	testl	%eax, %eax
	je	L58
	subl	$12, %esp
	pushl	$LC9
	call	_errmsgout
	addl	$16, %esp
	movl	$21, -60(%ebp)
	jmp	L40
L58:
	cmpl	$0, _nask_errors
	je	L61
	movl	_nask_errors, %eax
	movl	%eax, -40(%ebp)
	subl	$12, %esp
	pushl	$LC10
	call	_errmsgout
	addl	$16, %esp
	leal	-56(%ebp), %eax
	addl	$15, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movb	$0, (%eax)
L62:
	leal	-12(%ebp), %eax
	decl	(%eax)
	movl	-12(%ebp), %ecx
	movl	-40(%ebp), %edx
	movl	%edx, %eax
	movl	$10, %ebx
	cltd
	idivl	%ebx
	leal	48(%edx), %eax
	movb	%al, (%ecx)
	movl	-40(%ebp), %ecx
	movl	$1717986919, %eax
	imull	%ecx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -40(%ebp)
	testl	%eax, %eax
	jne	L62
	subl	$12, %esp
	pushl	-12(%ebp)
	call	_errmsgout
	addl	$16, %esp
	subl	$12, %esp
	pushl	$LC11
	call	_errmsgout
	addl	$16, %esp
	movl	$1, -60(%ebp)
	jmp	L40
L61:
	movl	$0, -60(%ebp)
L40:
	movl	-60(%ebp), %eax
	movl	-4(%ebp), %ebx
	leave
	ret
	.data
LC12:
	.ascii "\0"
LC13:
	.ascii "[TERM_WORKOVER]\12\0"
LC14:
	.ascii "[TERM_OUTOVER]\12\0"
LC15:
	.ascii "[TERM_ERROVER]\12\0"
LC16:
	.ascii "[TERM_BUGTRAP]\12\0"
LC17:
	.ascii "[TERM_SYSRESOVER]\12\0"
LC18:
	.ascii "[TERM_ABORT]\12\0"
	.balign 4
_termmsg.0:
	.long	LC12
	.long	LC13
	.long	LC14
	.long	LC15
	.long	LC16
	.long	LC17
	.long	LC18
	.text
	.balign 2
.globl _GOL_sysabort
	.def	_GOL_sysabort;	.scl	2;	.type	32;	.endef
_GOL_sysabort:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movb	%al, -1(%ebp)
	subl	$-128, _GO_stderr+4
	cmpb	$6, -1(%ebp)
	ja	L67
	subl	$12, %esp
	movzbl	-1(%ebp), %eax
	pushl	_termmsg.0(,%eax,4)
	call	_errmsgout
	addl	$16, %esp
L67:
	movl	_GO_stderr+8, %eax
	cmpl	_GO_stderr, %eax
	je	L68
	subl	$4, %esp
	pushl	_GO_stderr
	movl	_GO_stderr, %eax
	movl	_GO_stderr+8, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	pushl	%eax
	pushl	$0
	call	_GOLD_write_b
	addl	$16, %esp
L68:
	subl	$12, %esp
	cmpb	$0, -1(%ebp)
	jne	L69
	movl	_GOL_retcode, %eax
	movl	%eax, -8(%ebp)
	jmp	L70
L69:
	movl	$1, -8(%ebp)
L70:
	pushl	-8(%ebp)
	call	_ExitProcess@4
.globl _GOL_retcode
	.data
	.balign 4
_GOL_retcode:
	.space 4
.globl _GOL_work0
	.data
	.balign 4
_GOL_work0:
	.space 4
	.def	_output;	.scl	2;	.type	32;	.endef
	.def	_LL;	.scl	2;	.type	32;	.endef
	.def	_nask;	.scl	2;	.type	32;	.endef
	.def	_GO_memcpy;	.scl	2;	.type	32;	.endef
	.def	_GO_strlen;	.scl	2;	.type	32;	.endef
	.def	_GOL_sysmalloc;	.scl	2;	.type	32;	.endef
	.def	_GOL_sysabort;	.scl	2;	.type	32;	.endef
	.def	_main1;	.scl	2;	.type	32;	.endef
	.def	_ConvCmdLine0;	.scl	2;	.type	32;	.endef
	.def	_GOL_memmaninit;	.scl	2;	.type	32;	.endef
