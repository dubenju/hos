	.file	"nask.c"
.globl _nask_LABELBUFSIZ
	.data
	.align 4
_nask_LABELBUFSIZ:
	.long	262144
.globl _nask_L_LABEL0
	.align 4
_nask_L_LABEL0:
	.long	16384
.globl _nask_maxlabels
	.align 4
_nask_maxlabels:
	.long	65536
	.text
	.def	_cmalloc;	.scl	3;	.type	32;	.endef
_cmalloc:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -16(%ebp)
	movl	$0, -12(%ebp)
	jmp	L2
L3:
	movl	-12(%ebp), %eax
	addl	-16(%ebp), %eax
	movb	$0, (%eax)
	incl	-12(%ebp)
L2:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	jl	L3
	movl	-16(%ebp), %eax
	leave
	ret
	.data
	.align 32
_table_prms:
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	2
	.byte	1
	.byte	2
	.byte	9
	.byte	9
	.byte	1
	.byte	1
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	9
	.byte	2
	.byte	2
	.byte	3
	.byte	9
	.byte	1
	.byte	2
	.byte	2
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	9
	.byte	9
	.byte	1
	.byte	9
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	1
	.byte	1
.lcomm _labelbuf0,4,4
.lcomm _labelbuf,4,4
.lcomm _locallabelbuf0,4,4
.lcomm _locallabelbuf,4,4
.lcomm _nextlabelid,4,4
	.text
.globl _skipspace
	.def	_skipspace;	.scl	2;	.type	32;	.endef
_skipspace:
	pushl	%ebp
	movl	%esp, %ebp
	jmp	L5
L7:
	incl	8(%ebp)
L5:
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	L6
	movl	8(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L6
	movl	8(%ebp), %eax
	movb	(%eax), %al
	cmpb	$32, %al
	jbe	L7
L6:
	movl	8(%ebp), %eax
	leave
	ret
.globl _putimm
	.def	_putimm;	.scl	2;	.type	32;	.endef
_putimm:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movb	$6, -1(%ebp)
	cmpl	$0, 8(%ebp)
	js	L9
	cmpl	$255, 8(%ebp)
	jg	L10
	movb	$0, -1(%ebp)
	jmp	L11
L10:
	cmpl	$65535, 8(%ebp)
	jg	L12
	movb	$2, -1(%ebp)
	jmp	L11
L12:
	cmpl	$16777215, 8(%ebp)
	jg	L11
	movb	$4, -1(%ebp)
	jmp	L11
L9:
	cmpl	$-256, 8(%ebp)
	jl	L13
	movb	$1, -1(%ebp)
	jmp	L11
L13:
	cmpl	$-65536, 8(%ebp)
	jl	L14
	movb	$3, -1(%ebp)
	jmp	L11
L14:
	cmpl	$-16777216, 8(%ebp)
	jl	L11
	movb	$5, -1(%ebp)
L11:
	movl	12(%ebp), %eax
	movb	-1(%ebp), %dl
	movb	%dl, (%eax)
	movl	12(%ebp), %eax
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	movb	%al, (%edx)
	shrb	-1(%ebp)
	addl	$2, 12(%ebp)
	jmp	L15
L16:
	sarl	$8, 8(%ebp)
	decb	-1(%ebp)
	movl	8(%ebp), %eax
	movb	%al, %dl
	movl	12(%ebp), %eax
	movb	%dl, (%eax)
	incl	12(%ebp)
L15:
	cmpb	$0, -1(%ebp)
	jne	L16
	movl	12(%ebp), %eax
	leave
	ret
.globl _nask
	.def	_nask;	.scl	2;	.type	32;	.endef
_nask:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	addl	$-128, %esp
	movl	16(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	_nask_L_LABEL0, %eax
	movl	%eax, _nextlabelid
	movl	$76, (%esp)
	call	_malloc
	movl	%eax, -52(%ebp)
	movl	$80, (%esp)
	call	_malloc
	movl	%eax, -56(%ebp)
	movl	$120, (%esp)
	call	_malloc
	movl	%eax, -60(%ebp)
	movl	$8000, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	-52(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	$8000, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	-52(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	$352, (%esp)
	call	_cmalloc
	movl	%eax, -64(%ebp)
	movl	$256, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-60(%ebp), %eax
	movl	4(%eax), %eax
	leal	256(%eax), %edx
	movl	-60(%ebp), %eax
	movl	%edx, 8(%eax)
	movl	_nask_LABELBUFSIZ, %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, _labelbuf0
	movl	_labelbuf0, %eax
	movl	%eax, _labelbuf
	movl	$256, (%esp)
	call	_malloc
	movl	%eax, _locallabelbuf0
	movl	_locallabelbuf0, %eax
	movl	%eax, _locallabelbuf
	movl	$0, -72(%ebp)
	jmp	L18
L19:
	movl	-72(%ebp), %ebx
	movl	$2048, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	-60(%ebp), %eax
	leal	16(%ebx), %ecx
	movl	%edx, 8(%eax,%ecx,4)
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L18:
	movl	-72(%ebp), %eax
	cmpl	$8, %eax
	jle	L19
	movl	_nask_maxlabels, %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -68(%ebp)
	movl	$0, -72(%ebp)
	jmp	L20
L21:
	movl	-72(%ebp), %eax
	addl	-68(%ebp), %eax
	movb	$0, (%eax)
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L20:
	movl	-72(%ebp), %edx
	movl	_nask_maxlabels, %eax
	cmpl	%eax, %edx
	jl	L21
	movl	$0, -72(%ebp)
	jmp	L22
L23:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	$-1, 42(%eax)
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	$1, 43(%eax)
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movl	$-1, 8(%eax)
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L22:
	movl	-72(%ebp), %eax
	cmpl	$7, %eax
	jle	L23
	movl	-64(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	-56(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	%edx, 72(%eax)
	movl	-44(%ebp), %eax
	movb	$46, 24(%eax)
	movl	-44(%ebp), %eax
	movb	$46, 25(%eax)
	movl	-44(%ebp), %eax
	movb	$0, 26(%eax)
	movl	-44(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, 20(%eax)
	movl	-52(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, (%eax)
	movl	-52(%ebp), %eax
	movl	$1, 16(%eax)
	movl	-52(%ebp), %eax
	movl	16(%eax), %edx
	movl	-52(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-52(%ebp), %eax
	movb	$16, 12(%eax)
	movl	-52(%ebp), %eax
	movb	$0, 13(%eax)
	movl	-52(%ebp), %eax
	movb	$0, 14(%eax)
	movl	-52(%ebp), %eax
	movb	$0, 15(%eax)
	movl	-52(%ebp), %eax
	movb	$0, 33(%eax)
	movl	-52(%ebp), %eax
	movl	$0, 8(%eax)
	movl	16(%ebp), %eax
	addl	$5, %eax
	cmpl	20(%ebp), %eax
	jbe	L24
	movl	$0, 16(%ebp)
L24:
	cmpl	$0, 16(%ebp)
	je	L516
L25:
	movl	16(%ebp), %eax
	movb	$-15, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	addl	$2, %eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	addl	$3, %eax
	movb	$104, (%eax)
	movl	16(%ebp), %eax
	addl	$4, %eax
	movb	$0, (%eax)
	addl	$5, 16(%ebp)
	movl	-52(%ebp), %eax
	movl	$-1, 44(%eax)
	jmp	L27
L485:
	movl	-52(%ebp), %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	jne	L28
	movl	_nextlabelid, %eax
	movl	%eax, %ecx
	movl	-52(%ebp), %edx
	movl	%ecx, 44(%edx)
	incl	%eax
	movl	%eax, _nextlabelid
	movl	-52(%ebp), %eax
	movl	44(%eax), %edx
	movl	-52(%ebp), %eax
	movl	%edx, 40(%eax)
L28:
	movl	-52(%ebp), %eax
	movl	40(%eax), %edx
	movl	-52(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	-52(%ebp), %eax
	movl	$-1, 40(%eax)
	leal	-88(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-60(%ebp), %eax
	movb	$0, 20(%eax)
	movl	-56(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	_decoder
	movl	%eax, -32(%ebp)
	movl	16(%ebp), %eax
	addl	$15, %eax
	cmpl	20(%ebp), %eax
	jbe	L29
	movl	$0, 16(%ebp)
L29:
	cmpl	$0, 16(%ebp)
	je	L517
L30:
	movl	16(%ebp), %eax
	movb	$-9, (%eax)
	movl	16(%ebp), %eax
	leal	1(%eax), %edx
	movl	-32(%ebp), %ecx
	movl	8(%ebp), %eax
	movl	%ecx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	16(%ebp), %eax
	leal	5(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	addl	$9, 16(%ebp)
	movl	-60(%ebp), %eax
	movl	4(%eax), %edx
	movl	-60(%ebp), %eax
	movl	%edx, (%eax)
	movl	-52(%ebp), %eax
	movl	36(%eax), %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	cmpl	$-1, %eax
	je	L31
	movl	-72(%ebp), %eax
	addl	-68(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L31
	movl	16(%ebp), %eax
	movb	$14, (%eax)
	movl	-72(%ebp), %eax
	addl	-68(%ebp), %eax
	movb	$1, (%eax)
	movl	16(%ebp), %eax
	leal	1(%eax), %edx
	movl	-72(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_putimm
	movl	%eax, 16(%ebp)
L31:
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	L32
	movl	-28(%ebp), %eax
	movb	$14, (%eax)
	movl	-56(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	je	L33
	movl	-56(%ebp), %eax
	movl	8(%eax), %eax
	movb	12(%eax), %al
	cmpb	$63, %al
	jne	L33
	movl	-28(%ebp), %eax
	movb	$45, (%eax)
L33:
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -92(%ebp)
L39:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -33(%ebp)
	cmpb	$32, -33(%ebp)
	jbe	L518
L34:
	cmpb	$58, -33(%ebp)
	je	L519
L36:
	cmpb	$59, -33(%ebp)
	je	L520
L37:
	cmpb	$44, -33(%ebp)
	je	L521
L38:
	movl	-92(%ebp), %eax
	incl	%eax
	movl	%eax, -92(%ebp)
	movl	-92(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L39
	jmp	L35
L518:
	nop
	jmp	L35
L519:
	nop
	jmp	L35
L520:
	nop
	jmp	L35
L521:
	nop
L35:
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	movl	-92(%ebp), %edx
	movl	%edx, %ecx
	movl	-56(%ebp), %edx
	movl	(%edx), %edx
	movl	%ecx, %ebx
	subl	%edx, %ebx
	movl	%ebx, %edx
	movl	$0, 8(%esp)
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_label2id
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	addl	-68(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	je	L40
	movl	-28(%ebp), %eax
	movb	$-25, (%eax)
	incl	-28(%ebp)
	movb	$0, -33(%ebp)
	jmp	L41
L40:
	movl	-72(%ebp), %eax
	addl	-68(%ebp), %eax
	movb	$1, (%eax)
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -33(%ebp)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-72(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_putimm
	movl	%eax, -28(%ebp)
	cmpb	$14, -33(%ebp)
	jne	L42
	movl	-28(%ebp), %edx
	leal	-88(%ebp), %eax
	subl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-88(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_flush_bp
	movl	%eax, 16(%ebp)
	cmpl	$0, 16(%ebp)
	je	L522
L43:
	leal	-88(%ebp), %eax
	movl	%eax, -28(%ebp)
L42:
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	movb	(%eax), %al
	cmpb	$46, %al
	je	L32
	movl	-56(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	je	L44
	movl	-56(%ebp), %eax
	movl	8(%eax), %eax
	movb	12(%eax), %al
	cmpb	$63, %al
	je	L32
L44:
	movl	-92(%ebp), %eax
	movl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -72(%ebp)
	movl	_locallabelbuf0, %eax
	movl	%eax, _locallabelbuf
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -92(%ebp)
	jmp	L45
L46:
	movl	-72(%ebp), %eax
	decl	%eax
	movl	%eax, -72(%ebp)
	movl	_locallabelbuf, %edx
	movl	-92(%ebp), %eax
	movb	(%eax), %cl
	movb	%cl, (%edx)
	incl	%edx
	movl	%edx, _locallabelbuf
	incl	%eax
	movl	%eax, -92(%ebp)
L45:
	movl	-72(%ebp), %eax
	testl	%eax, %eax
	jne	L46
	jmp	L32
L727:
	nop
L32:
	movl	-56(%ebp), %eax
	movb	76(%eax), %al
	testb	%al, %al
	je	L47
	jmp	L48
L572:
	nop
	jmp	L48
L654:
	nop
L48:
	movl	-56(%ebp), %eax
	movb	76(%eax), %al
	orl	$-32, %eax
	movb	%al, -88(%ebp)
	leal	-88(%ebp), %eax
	incl	%eax
	movl	%eax, -28(%ebp)
	movb	$0, -33(%ebp)
	jmp	L41
L47:
	movb	$0, -33(%ebp)
	movl	-52(%ebp), %eax
	movb	12(%eax), %al
	movsbl	%al, %eax
	movl	%eax, -20(%ebp)
	movl	-56(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -40(%ebp)
	cmpl	$0, -40(%ebp)
	je	L41
	movl	-40(%ebp), %eax
	movb	12(%eax), %al
	movzbl	%al, %eax
	cmpl	$231, %eax
	ja	L41
	movl	L84(,%eax,4), %eax
	jmp	*%eax
	.section .rdata,"dr"
	.align 4
L84:
	.long	L41
	.long	L41
	.long	L49
	.long	L50
	.long	L51
	.long	L52
	.long	L53
	.long	L54
	.long	L55
	.long	L56
	.long	L57
	.long	L58
	.long	L59
	.long	L60
	.long	L61
	.long	L62
	.long	L63
	.long	L64
	.long	L65
	.long	L66
	.long	L67
	.long	L68
	.long	L69
	.long	L70
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L71
	.long	L72
	.long	L73
	.long	L74
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L75
	.long	L76
	.long	L77
	.long	L78
	.long	L41
	.long	L41
	.long	L41
	.long	L79
	.long	L41
	.long	L41
	.long	L80
	.long	L81
	.long	L82
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L41
	.long	L523
	.text
L49:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L85
	movl	-56(%ebp), %eax
	movl	36(%eax), %eax
	movl	%eax, %edx
	orl	$268435456, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
L85:
	movl	-12(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	L86
	movl	-56(%ebp), %eax
	movl	36(%eax), %eax
	movl	%eax, %edx
	orl	$536870912, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
L86:
	movl	-12(%ebp), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	L87
	orl	$1, -20(%ebp)
L87:
	movl	$0, -72(%ebp)
	jmp	L88
L89:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-72(%ebp), %eax
	leal	2(%eax), %ecx
	movl	-40(%ebp), %eax
	movb	12(%eax,%ecx), %al
	movb	%al, (%edx)
	addl	$2, -28(%ebp)
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L88:
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	andl	$15, %edx
	movl	-72(%ebp), %eax
	cmpl	%eax, %edx
	jg	L89
	jmp	L41
L616:
	nop
	jmp	L52
L683:
	nop
L52:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L524
L90:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-72(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L92
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L525
L92:
	movl	-72(%ebp), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	movl	%eax, %edx
	sall	$5, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-72(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -72(%ebp)
	jmp	L93
L50:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L526
L94:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L95
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L527
L95:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$496, %eax
	testl	%eax, %eax
	jne	L528
L96:
	movl	-56(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$23, %eax
	jg	L529
L97:
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-12(%ebp), %eax
	andl	$15, %eax
	cmpl	$15, %eax
	jne	L98
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	testb	%al, %al
	jns	L98
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	andl	$-16, %edx
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$15, %eax
	orl	%edx, %eax
	movl	%eax, -12(%ebp)
L98:
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 40(%eax)
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	jmp	L99
L51:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$496, %eax
	testl	%eax, %eax
	jne	L530
L100:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L531
L101:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L532
L102:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L103
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-56(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$23, %eax
	jg	L533
L103:
	movl	-12(%ebp), %eax
	andl	$15, %eax
	cmpl	$15, %eax
	jne	L104
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	testb	%al, %al
	jns	L104
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	andl	$-16, %edx
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	orl	%edx, %eax
	movl	%eax, -12(%ebp)
L104:
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 44(%eax)
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	jmp	L99
L607:
	nop
	jmp	L99
L608:
	nop
L99:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	shrb	$4, %al
	movzbl	%al, %eax
	movl	%eax, -16(%ebp)
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	movl	%eax, -72(%ebp)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -16(%ebp)
	je	L534
L105:
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L106
	movl	-72(%ebp), %eax
	cmpl	-12(%ebp), %eax
	je	L535
L106:
	cmpl	$4, -12(%ebp)
	jle	L107
	jmp	L108
L536:
	nop
	jmp	L108
L539:
	nop
	jmp	L108
L540:
	nop
	jmp	L108
L544:
	nop
	jmp	L108
L545:
	nop
	jmp	L108
L547:
	nop
	jmp	L108
L552:
	nop
	jmp	L108
L557:
	nop
	jmp	L108
L561:
	nop
	jmp	L108
L566:
	nop
	jmp	L108
L569:
	nop
	jmp	L108
L570:
	nop
	jmp	L108
L575:
	nop
	jmp	L108
L576:
	nop
	jmp	L108
L585:
	nop
	jmp	L108
L589:
	nop
	jmp	L108
L590:
	nop
	jmp	L108
L591:
	nop
	jmp	L108
L606:
	nop
	jmp	L108
L610:
	nop
	jmp	L108
L621:
	nop
	jmp	L108
L628:
	nop
	jmp	L108
L630:
	nop
	jmp	L108
L638:
	nop
	jmp	L108
L639:
	nop
	jmp	L108
L640:
	nop
	jmp	L108
L653:
	nop
	jmp	L108
L660:
	nop
	jmp	L108
L661:
	nop
	jmp	L108
L664:
	nop
	jmp	L108
L665:
	nop
	jmp	L108
L671:
	nop
	jmp	L108
L672:
	nop
	jmp	L108
L700:
	nop
	jmp	L108
L714:
	nop
L108:
	movl	-56(%ebp), %eax
	movb	$3, 76(%eax)
	jmp	L48
L107:
	movl	-12(%ebp), %eax
	movl	-16(%ebp), %edx
	andl	%edx, %eax
	testl	%eax, %eax
	je	L536
	jmp	L93
L534:
	nop
	jmp	L93
L535:
	nop
L93:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	andl	$15, %eax
	movl	%eax, -16(%ebp)
	cmpl	$0, -16(%ebp)
	je	L537
L109:
	movl	-16(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L111
	movl	-72(%ebp), %eax
	cmpl	$15, %eax
	je	L538
L111:
	movl	-72(%ebp), %eax
	cmpl	$4, %eax
	jg	L539
L112:
	movl	-72(%ebp), %eax
	andl	-16(%ebp), %eax
	testl	%eax, %eax
	je	L540
	jmp	L110
L537:
	nop
	jmp	L110
L538:
	nop
L110:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	movzbl	%al, %eax
	andl	$1, %eax
	movl	%eax, -12(%ebp)
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movzbl	%al, %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	L113
	cmpl	$0, -12(%ebp)
	je	L113
	jmp	L91
L524:
	nop
	jmp	L91
L525:
	nop
	jmp	L91
L526:
	nop
	jmp	L91
L527:
	nop
	jmp	L91
L528:
	nop
	jmp	L91
L529:
	nop
	jmp	L91
L530:
	nop
	jmp	L91
L531:
	nop
	jmp	L91
L532:
	nop
	jmp	L91
L533:
	nop
	jmp	L91
L541:
	nop
	jmp	L91
L542:
	nop
	jmp	L91
L543:
	nop
	jmp	L91
L546:
	nop
	jmp	L91
L573:
	nop
	jmp	L91
L574:
	nop
	jmp	L91
L578:
	nop
	jmp	L91
L582:
	nop
	jmp	L91
L583:
	nop
	jmp	L91
L584:
	nop
	jmp	L91
L587:
	nop
	jmp	L91
L588:
	nop
	jmp	L91
L592:
	nop
	jmp	L91
L593:
	nop
	jmp	L91
L597:
	nop
	jmp	L91
L598:
	nop
	jmp	L91
L599:
	nop
	jmp	L91
L600:
	nop
	jmp	L91
L602:
	nop
	jmp	L91
L603:
	nop
	jmp	L91
L604:
	nop
	jmp	L91
L605:
	nop
	jmp	L91
L617:
	nop
	jmp	L91
L618:
	nop
	jmp	L91
L619:
	nop
	jmp	L91
L620:
	nop
	jmp	L91
L622:
	nop
	jmp	L91
L624:
	nop
	jmp	L91
L625:
	nop
	jmp	L91
L626:
	nop
	jmp	L91
L627:
	nop
	jmp	L91
L631:
	nop
	jmp	L91
L632:
	nop
	jmp	L91
L633:
	nop
	jmp	L91
L634:
	nop
	jmp	L91
L635:
	nop
	jmp	L91
L636:
	nop
	jmp	L91
L637:
	nop
	jmp	L91
L641:
	nop
	jmp	L91
L645:
	nop
	jmp	L91
L646:
	nop
	jmp	L91
L647:
	nop
	jmp	L91
L648:
	nop
	jmp	L91
L649:
	nop
	jmp	L91
L651:
	nop
	jmp	L91
L652:
	nop
	jmp	L91
L655:
	nop
	jmp	L91
L656:
	nop
	jmp	L91
L657:
	nop
	jmp	L91
L658:
	nop
	jmp	L91
L662:
	nop
	jmp	L91
L663:
	nop
	jmp	L91
L670:
	nop
	jmp	L91
L675:
	nop
	jmp	L91
L676:
	nop
	jmp	L91
L679:
	nop
	jmp	L91
L681:
	nop
	jmp	L91
L682:
	nop
	jmp	L91
L685:
	nop
	jmp	L91
L691:
	nop
	jmp	L91
L692:
	nop
	jmp	L91
L694:
	nop
	jmp	L91
L696:
	nop
	jmp	L91
L701:
	nop
	jmp	L91
L702:
	nop
	jmp	L91
L704:
	nop
	jmp	L91
L705:
	nop
	jmp	L91
L707:
	nop
	jmp	L91
L709:
	nop
	jmp	L91
L710:
	nop
	jmp	L91
L712:
	nop
	jmp	L91
L728:
	nop
L91:
	movl	-56(%ebp), %eax
	movb	$4, 76(%eax)
	jmp	L48
L113:
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	testb	%al, %al
	jns	L114
	cmpl	$0, -12(%ebp)
	je	L541
L114:
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movzbl	%al, %eax
	andl	$7, %eax
	movl	%eax, -12(%ebp)
	movl	$0, -72(%ebp)
	jmp	L115
L116:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-72(%ebp), %eax
	leal	3(%eax), %ecx
	movl	-40(%ebp), %eax
	movb	12(%eax,%ecx), %al
	movb	%al, (%edx)
	addl	$2, -28(%ebp)
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L115:
	movl	-72(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jl	L116
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movzbl	%al, %eax
	andl	$48, %eax
	cmpl	$32, %eax
	je	L117
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	movl	%eax, -72(%ebp)
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movzbl	%al, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L118
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	movl	%eax, -72(%ebp)
L118:
	movl	-72(%ebp), %eax
	andl	$15, %eax
	movl	%eax, -72(%ebp)
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movzbl	%al, %eax
	andl	$32, %eax
	testl	%eax, %eax
	jne	L119
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-72(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
L119:
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movzbl	%al, %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L117
	movl	-72(%ebp), %eax
	cmpl	$1, %eax
	je	L117
	movl	-28(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-28(%ebp), %eax
	decl	%eax
	movb	(%eax), %al
	orl	$1, %eax
	movb	%al, (%edx)
L117:
	movl	-52(%ebp), %eax
	movb	13(%eax), %al
	testb	%al, %al
	jle	L120
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	cmpb	$-115, %al
	jne	L120
	movl	-56(%ebp), %eax
	movl	36(%eax), %eax
	movl	%eax, %edx
	andl	$-2017, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
L120:
	movl	-28(%ebp), %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$122, (%eax)
	addl	$3, -28(%ebp)
L121:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	xorl	$3, %eax
	movb	%al, -33(%ebp)
	jmp	L41
L53:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L542
L122:
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 64(%eax)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	movl	%eax, %edx
	sall	$9, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L123
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L543
L123:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	testl	%eax, %eax
	je	L544
L124:
	movl	-72(%ebp), %eax
	cmpl	$4, %eax
	jg	L545
L125:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-72(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	$0, -12(%ebp)
	movl	-72(%ebp), %eax
	cmpl	$1, %eax
	je	L126
	incl	-12(%ebp)
L126:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	cmpl	$8705, %eax
	jne	L127
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-12(%ebp), %eax
	orl	$-46, %eax
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$122, (%eax)
	jmp	L128
L127:
	movl	-12(%ebp), %eax
	orb	$-64, %al
	movl	%eax, _mcode.1857+8
	movl	-12(%ebp), %eax
	orb	$-48, %al
	movl	%eax, _mcode.1857+28
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L546
L129:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$15, %eax
	cmpl	$15, %eax
	jne	L130
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$_mcode.1857, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode94
	testl	%eax, %eax
	je	L131
	jmp	L132
L130:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$15, %eax
	cmpl	$1, %eax
	jne	L547
	movl	-60(%ebp), %eax
	movb	$1, 16(%eax)
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	orb	$-64, %dl
	movl	-60(%ebp), %eax
	movl	%edx, 40(%eax)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$0, 12(%esp)
	movl	$5, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L548
L131:
	movl	-28(%ebp), %eax
	movb	$124, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$122, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$125, (%eax)
L128:
	addl	$5, -28(%ebp)
	jmp	L121
L54:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	testb	%al, %al
	jne	L134
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	orl	$1, %eax
	movb	%al, (%edx)
	addl	$2, -28(%ebp)
	jmp	L41
L134:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$1, %al
	ja	L549
L135:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L550
L136:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	cmpl	$2, %eax
	je	L551
L137:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	cmpl	$15, %eax
	jne	L552
L139:
	movl	-52(%ebp), %eax
	movb	13(%eax), %al
	testb	%al, %al
	jne	L140
	jmp	L138
L551:
	nop
L138:
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$2, 12(%esp)
	movl	$5, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L553
L141:
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, (%edx)
	addl	$2, -28(%ebp)
	jmp	L142
L140:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	movl	%eax, _mcode.1861+8
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	orl	$1, %eax
	movzbl	%al, %eax
	movl	%eax, _mcode.1861+28
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$_mcode.1861, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode94
	testl	%eax, %eax
	jne	L554
L143:
	movl	-28(%ebp), %eax
	movb	$124, (%eax)
	incl	-28(%ebp)
L142:
	movl	-28(%ebp), %eax
	movb	$125, (%eax)
	incl	-28(%ebp)
	jmp	L41
L55:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	testb	%al, %al
	jne	L144
	movl	-60(%ebp), %eax
	movb	$1, 16(%eax)
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movzbl	%al, %edx
	movl	-60(%ebp), %eax
	movl	%edx, 40(%eax)
	jmp	L145
L144:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$1, %al
	jne	L555
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L556
L147:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	cmpl	$1, %eax
	je	L148
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	cmpl	$15, %eax
	jne	L557
L148:
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L558
L145:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$124, (%eax)
	addl	$3, -28(%ebp)
	jmp	L41
L56:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L559
L149:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	cmpl	$1, %eax
	je	L560
L150:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	cmpl	$15, %eax
	jne	L561
L152:
	movl	-52(%ebp), %eax
	movb	13(%eax), %al
	testb	%al, %al
	jne	L153
	jmp	L151
L560:
	nop
L151:
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$0, 12(%esp)
	movl	$5, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L562
L154:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-51, (%eax)
	addl	$2, -28(%ebp)
	jmp	L155
L153:
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$_mcode.1865, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode94
	testl	%eax, %eax
	jne	L563
L156:
	movl	-28(%ebp), %eax
	movb	$124, (%eax)
	incl	-28(%ebp)
L155:
	movl	-28(%ebp), %eax
	movb	$125, (%eax)
	incl	-28(%ebp)
	jmp	L41
L57:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$192, %eax
	testl	%eax, %eax
	jne	L564
L157:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	andl	$7, %eax
	movl	%eax, %edx
	sall	$9, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$48, %eax
	cmpl	$16, %eax
	je	L160
	cmpl	$32, %eax
	je	L161
	testl	%eax, %eax
	jne	L565
L159:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$15, %eax
	jg	L162
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movb	%al, %cl
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	andl	$7, %eax
	orl	%ecx, %eax
	movb	%al, (%edx)
	addl	$2, -28(%ebp)
	jmp	L41
L162:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L163
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	L566
L164:
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	movb	%al, (%edx)
	movb	$2, -33(%ebp)
L165:
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$122, (%eax)
	addl	$5, -28(%ebp)
	jmp	L41
L163:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L567
L166:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$27, %eax
	jg	L167
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	16(%eax), %al
	movb	%al, %cl
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	andl	$3, %eax
	sall	$3, %eax
	orl	%ecx, %eax
	movb	%al, (%edx)
	addl	$2, -28(%ebp)
	jmp	L41
L167:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$29, %eax
	jg	L568
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$15, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	3(%eax), %edx
	movl	-40(%ebp), %eax
	movb	17(%eax), %al
	movb	%al, %cl
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	andl	$3, %eax
	sall	$3, %eax
	orl	%ecx, %eax
	movb	%al, (%edx)
	addl	$4, -28(%ebp)
	jmp	L41
L160:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	movb	%al, -33(%ebp)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L169
	cmpb	$1, -33(%ebp)
	je	L569
L170:
	cmpb	$15, -33(%ebp)
	jne	L171
	movb	$1, -33(%ebp)
	jmp	L171
L169:
	cmpb	$15, -33(%ebp)
	je	L570
L172:
	cmpb	$1, -33(%ebp)
	je	L171
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$1, (%eax)
L171:
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-28(%ebp), %eax
	incl	%eax
	movb	(%eax), %cl
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	orl	%ecx, %eax
	movb	%al, (%edx)
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movzbl	-33(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movb	$3, -33(%ebp)
	jmp	L165
L161:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L571
L173:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	movb	%al, -33(%ebp)
	movl	$84, _mcode.1871
	cmpb	$4, -33(%ebp)
	ja	L174
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movzbl	-33(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
L174:
	cmpb	$4, -33(%ebp)
	je	L175
	cmpb	$15, -33(%ebp)
	jne	L176
	movl	-20(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	L176
L175:
	movl	$92, _mcode.1871
L176:
	movb	-33(%ebp), %al
	movsbl	%al, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$_mcode.1871, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode90
	movb	%al, %dl
	movl	-56(%ebp), %eax
	movb	%dl, 76(%eax)
	movl	-56(%ebp), %eax
	movb	76(%eax), %al
	testb	%al, %al
	jne	L572
L177:
	movl	-28(%ebp), %eax
	movb	$125, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$124, (%eax)
	addl	$2, -28(%ebp)
	movb	$0, -33(%ebp)
	jmp	L41
L58:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$192, %eax
	testl	%eax, %eax
	jne	L573
L178:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$192, %eax
	testl	%eax, %eax
	jne	L574
L179:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$48, %eax
	cmpl	$32, %eax
	jne	L180
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	movb	%al, %dl
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	%edx, %eax
	andl	$15, %eax
	movb	%al, -33(%ebp)
	cmpb	$0, -33(%ebp)
	je	L575
L181:
	cmpb	$15, -33(%ebp)
	je	L576
L182:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movzbl	-33(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movzbl	-33(%ebp), %eax
	decl	%eax
	movb	_typecode.1873(%eax), %al
	movzbl	%al, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L577
L183:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$48, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	L184
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L578
L185:
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	andl	$7, %eax
	orl	$-80, %eax
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$124, (%eax)
	cmpb	$1, -33(%ebp)
	je	L186
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-28(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	orl	$8, %eax
	movb	%al, (%edx)
L186:
	addl	$3, -28(%ebp)
	movb	$0, -33(%ebp)
	jmp	L41
L184:
	cmpl	$16, -12(%ebp)
	jne	L579
L187:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-58, (%eax)
	movl	-56(%ebp), %eax
	movl	$0, 68(%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$122, (%eax)
	movl	-28(%ebp), %eax
	addl	$5, %eax
	movb	$124, (%eax)
	cmpb	$1, -33(%ebp)
	je	L188
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-28(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	orl	$1, %eax
	movb	%al, (%edx)
L188:
	addl	$6, -28(%ebp)
	movb	$3, -33(%ebp)
	jmp	L41
L180:
	movl	$0, -72(%ebp)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$48, %eax
	cmpl	$16, %eax
	je	L580
L189:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$48, %eax
	testl	%eax, %eax
	jne	L191
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jle	L191
	jmp	L190
L580:
	nop
L190:
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L191:
	movl	$0, -24(%ebp)
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-72(%ebp), %edx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	8(%eax,%edx,4), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	andl	$48, %eax
	cmpl	$16, %eax
	jne	L192
	movl	-56(%ebp), %eax
	leal	36(%eax), %edx
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	_testmem0
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	je	L581
L193:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	jmp	L195
L192:
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	andl	$48, %eax
	testl	%eax, %eax
	jne	L582
L196:
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	sarl	$9, %eax
	cmpl	$23, %eax
	jg	L583
L195:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	xorl	$1, %edx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	8(%eax,%edx,4), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	andl	$15, %eax
	movb	%al, -33(%ebp)
	movl	-12(%ebp), %eax
	andl	$48, %eax
	testl	%eax, %eax
	jne	L584
L197:
	movl	-12(%ebp), %eax
	sarl	$9, %eax
	cmpl	$23, %eax
	jle	L198
	movl	-12(%ebp), %eax
	sarl	$9, %eax
	cmpl	$29, %eax
	jg	L198
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	testb	%al, %al
	je	L198
	cmpb	$1, -33(%ebp)
	jne	L200
	jmp	L108
L198:
	cmpb	$15, -33(%ebp)
	je	L200
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	andl	$15, %edx
	movzbl	-33(%ebp), %eax
	cmpl	%eax, %edx
	jne	L585
L200:
	movl	-72(%ebp), %edx
	movl	-72(%ebp), %ecx
	movl	-56(%ebp), %eax
	addl	$8, %ecx
	movl	8(%eax,%ecx,4), %eax
	movl	%eax, %ecx
	andl	$-16, %ecx
	movl	-12(%ebp), %eax
	andl	$15, %eax
	orl	%eax, %ecx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	%ecx, 8(%eax,%edx,4)
	cmpl	$4, -12(%ebp)
	je	L201
	cmpl	$4098, -12(%ebp)
	je	L201
	cmpl	$8193, -12(%ebp)
	jne	L202
L201:
	movl	-24(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L202
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-12(%ebp), %eax
	andl	$15, %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	-72(%ebp), %eax
	xorl	$1, %eax
	sall	%eax
	orl	$-96, %eax
	movb	%al, -33(%ebp)
	cmpl	$8193, -12(%ebp)
	je	L203
	orb	$1, -33(%ebp)
L203:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movb	-33(%ebp), %al
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$122, (%eax)
	addl	$3, -28(%ebp)
	jmp	L121
L202:
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	sarl	$9, %eax
	movl	%eax, -12(%ebp)
	cmpl	$23, -12(%ebp)
	jg	L204
	movl	-40(%ebp), %eax
	movb	$17, 14(%eax)
	movl	-72(%ebp), %eax
	sall	%eax
	orl	$-120, %eax
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 15(%eax)
	jmp	L110
L204:
	cmpl	$29, -12(%ebp)
	jg	L205
	movl	-72(%ebp), %eax
	testl	%eax, %eax
	jne	L206
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	testb	%al, %al
	je	L206
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movzbl	-33(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
L206:
	movl	-40(%ebp), %eax
	movb	$33, 14(%eax)
	movl	-72(%ebp), %eax
	sall	%eax
	orl	$-116, %eax
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 15(%eax)
	jmp	L110
L205:
	cmpl	$39, -12(%ebp)
	jle	L586
L207:
	cmpl	$63, -12(%ebp)
	jg	L132
	movl	-12(%ebp), %eax
	subl	$40, %eax
	sarl	$3, %eax
	movb	%al, -33(%ebp)
	cmpb	$2, -33(%ebp)
	jne	L208
	movb	$4, -33(%ebp)
L208:
	orb	$32, -33(%ebp)
	movl	-40(%ebp), %eax
	movb	$-94, 14(%eax)
	movl	-40(%ebp), %eax
	movb	$15, 15(%eax)
	movl	-72(%ebp), %eax
	sall	%eax
	movb	%al, %dl
	movb	-33(%ebp), %al
	orl	%edx, %eax
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 16(%eax)
	jmp	L110
L548:
	nop
	jmp	L132
L549:
	nop
	jmp	L132
L550:
	nop
	jmp	L132
L553:
	nop
	jmp	L132
L554:
	nop
	jmp	L132
L555:
	nop
	jmp	L132
L556:
	nop
	jmp	L132
L558:
	nop
	jmp	L132
L559:
	nop
	jmp	L132
L562:
	nop
	jmp	L132
L563:
	nop
	jmp	L132
L564:
	nop
	jmp	L132
L565:
	nop
	jmp	L132
L567:
	nop
	jmp	L132
L568:
	nop
	jmp	L132
L571:
	nop
	jmp	L132
L577:
	nop
	jmp	L132
L579:
	nop
	jmp	L132
L586:
	nop
	jmp	L132
L594:
	nop
	jmp	L132
L595:
	nop
	jmp	L132
L596:
	nop
	jmp	L132
L609:
	nop
	jmp	L132
L611:
	nop
	jmp	L132
L612:
	nop
	jmp	L132
L613:
	nop
	jmp	L132
L614:
	nop
	jmp	L132
L615:
	nop
	jmp	L132
L623:
	nop
	jmp	L132
L629:
	nop
	jmp	L132
L642:
	nop
	jmp	L132
L643:
	nop
	jmp	L132
L644:
	nop
	jmp	L132
L650:
	nop
	jmp	L132
L659:
	nop
	jmp	L132
L666:
	nop
	jmp	L132
L668:
	nop
	jmp	L132
L669:
	nop
	jmp	L132
L673:
	nop
	jmp	L132
L674:
	nop
	jmp	L132
L677:
	nop
	jmp	L132
L678:
	nop
	jmp	L132
L680:
	nop
	jmp	L132
L689:
	nop
	jmp	L132
L690:
	nop
	jmp	L132
L695:
	nop
	jmp	L132
L699:
	nop
	jmp	L132
L703:
	nop
	jmp	L132
L706:
	nop
	jmp	L132
L708:
	nop
	jmp	L132
L711:
	nop
	jmp	L132
L713:
	nop
	jmp	L132
L715:
	nop
	jmp	L132
L717:
	nop
	jmp	L132
L718:
	nop
	jmp	L132
L719:
	nop
	jmp	L132
L720:
	nop
	jmp	L132
L726:
	nop
	jmp	L132
L736:
	nop
	jmp	L132
L737:
	nop
	jmp	L132
L743:
	nop
L132:
	movl	-56(%ebp), %eax
	movb	$2, 76(%eax)
	jmp	L48
L59:
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	movb	%al, %dl
	andl	$56, %edx
	movl	-40(%ebp), %eax
	movb	%dl, 15(%eax)
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$192, %eax
	testl	%eax, %eax
	jne	L587
L209:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$192, %eax
	testl	%eax, %eax
	jne	L588
L210:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$48, %eax
	cmpl	$32, %eax
	jne	L211
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	movb	%al, -33(%ebp)
	cmpb	$15, -33(%ebp)
	je	L589
L212:
	cmpb	$4, -33(%ebp)
	ja	L590
L213:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$15, %eax
	cmpl	$15, %eax
	je	L214
	movzbl	-33(%ebp), %edx
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$15, %eax
	cmpl	%eax, %edx
	jl	L591
L214:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movzbl	-33(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	jne	L592
L215:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L216
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L593
L217:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	andl	$7, %eax
	testl	%eax, %eax
	jne	L216
	cmpb	$2, -33(%ebp)
	ja	L218
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	orl	$4, %eax
	movb	%al, (%edx)
	cmpb	$2, -33(%ebp)
	jne	L219
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-28(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	orl	$1, %eax
	movb	%al, (%edx)
L219:
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$124, (%eax)
	addl	$3, -28(%ebp)
	movb	-33(%ebp), %dl
	movb	%dl, %al
	sall	%eax
	addl	%edx, %eax
	negl	%eax
	addl	$9, %eax
	movzbl	%al, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L594
L220:
	movb	$0, -33(%ebp)
	jmp	L41
L218:
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	orl	$5, %eax
	movzbl	%al, %eax
	movl	%eax, _mcode.1877+8
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	orl	$-64, %eax
	movzbl	%al, %eax
	movl	%eax, _mcode.1877+32
	movl	-28(%ebp), %eax
	movb	$125, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$126, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$124, (%eax)
	addl	$3, -28(%ebp)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, %edx
	andl	$15, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$_mcode.1877, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode91
	testl	%eax, %eax
	jne	L595
L221:
	movb	$0, -33(%ebp)
	jmp	L41
L216:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	movzbl	%al, %eax
	movl	%eax, %edx
	sall	$6, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	cmpb	$1, -33(%ebp)
	jne	L222
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-128, (%eax)
	addl	$2, -28(%ebp)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$6, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	je	L223
	jmp	L132
L222:
	movl	$84, _mcode.1878
	cmpb	$4, -33(%ebp)
	jne	L224
	movl	$92, _mcode.1878
L224:
	movl	-28(%ebp), %eax
	movb	$125, (%eax)
	incl	-28(%ebp)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, %edx
	andl	$15, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$_mcode.1878, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode90
	testl	%eax, %eax
	jne	L596
L223:
	movl	-28(%ebp), %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$122, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$124, (%eax)
	addl	$4, -28(%ebp)
	jmp	L121
L211:
	movl	$0, -72(%ebp)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$48, %eax
	cmpl	$16, %eax
	jne	L225
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L225:
	movl	-72(%ebp), %edx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	8(%eax,%edx,4), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	jne	L597
L226:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L227
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-72(%ebp), %edx
	movl	-56(%ebp), %eax
	addl	$12, %edx
	movl	4(%eax,%edx,4), %eax
	cmpl	$23, %eax
	jg	L598
L227:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	xorl	$1, %edx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	8(%eax,%edx,4), %eax
	andl	$48, %eax
	testl	%eax, %eax
	jne	L599
L228:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	xorl	$1, %edx
	movl	-56(%ebp), %eax
	addl	$12, %edx
	movl	4(%eax,%edx,4), %eax
	cmpl	$23, %eax
	jg	L600
L229:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	xorl	$1, %edx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	8(%eax,%edx,4), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-12(%ebp), %eax
	andl	$15, %eax
	cmpl	$15, %eax
	jne	L230
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	andl	$-16, %edx
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	andl	$15, %eax
	orl	%edx, %eax
	movl	%eax, -12(%ebp)
L230:
	movl	-72(%ebp), %eax
	movl	-56(%ebp), %edx
	leal	8(%eax), %ecx
	movl	-12(%ebp), %ebx
	movl	%ebx, 8(%edx,%ecx,4)
	movl	-56(%ebp), %edx
	addl	$8, %eax
	movl	8(%edx,%eax,4), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	movb	%al, %dl
	andl	$-3, %edx
	movl	-72(%ebp), %eax
	sall	%eax
	orl	%edx, %eax
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 15(%eax)
	jmp	L99
L60:
	movl	$0, -72(%ebp)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$48, %eax
	cmpl	$16, %eax
	je	L601
L231:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	cmpl	$4, %eax
	je	L232
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	cmpl	$4098, %eax
	jne	L233
	jmp	L232
L601:
	nop
L232:
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L233:
	movl	-72(%ebp), %edx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	8(%eax,%edx,4), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L602
L234:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L235
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-72(%ebp), %edx
	movl	-56(%ebp), %eax
	addl	$12, %edx
	movl	4(%eax,%edx,4), %eax
	cmpl	$23, %eax
	jg	L603
L235:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	xorl	$1, %edx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	8(%eax,%edx,4), %eax
	andl	$496, %eax
	testl	%eax, %eax
	jne	L604
L236:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	xorl	$1, %edx
	movl	-56(%ebp), %eax
	addl	$12, %edx
	movl	4(%eax,%edx,4), %eax
	cmpl	$23, %eax
	jg	L605
L237:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	xorl	$1, %edx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	8(%eax,%edx,4), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-12(%ebp), %eax
	andl	$15, %eax
	cmpl	$15, %eax
	jne	L238
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	andl	$-16, %edx
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	andl	$15, %eax
	orl	%edx, %eax
	movl	%eax, -12(%ebp)
L238:
	movl	-72(%ebp), %eax
	movl	-56(%ebp), %edx
	leal	8(%eax), %ecx
	movl	-12(%ebp), %ebx
	movl	%ebx, 8(%edx,%ecx,4)
	movl	-56(%ebp), %edx
	addl	$8, %eax
	movl	8(%edx,%eax,4), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-56(%ebp), %eax
	movl	68(%eax), %edx
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	xorl	%edx, %eax
	andl	$15, %eax
	testl	%eax, %eax
	jne	L606
L239:
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	cmpl	$4, %eax
	je	L240
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	cmpl	$4098, %eax
	jne	L607
L240:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	testb	%al, %al
	je	L608
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	sarl	$9, %eax
	andl	$7, %eax
	orl	$-112, %eax
	movb	%al, (%edx)
	addl	$2, -28(%ebp)
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	andl	$15, %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	jmp	L41
L61:
	movl	$0, -12(%ebp)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, -33(%ebp)
	cmpb	$-26, -33(%ebp)
	jne	L242
	incl	-12(%ebp)
L242:
	movl	$268435456, -72(%ebp)
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %edx
	addl	$8, %edx
	movl	8(%eax,%edx,4), %eax
	cmpl	$4, %eax
	je	L243
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %edx
	addl	$8, %edx
	movl	8(%eax,%edx,4), %eax
	cmpl	$4098, %eax
	jne	L244
L243:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %ecx
	addl	$8, %ecx
	movl	8(%eax,%ecx,4), %eax
	andl	$15, %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	incb	-33(%ebp)
	jmp	L245
L244:
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %edx
	addl	$8, %edx
	movl	8(%eax,%edx,4), %eax
	cmpl	$8193, %eax
	jne	L609
L245:
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	xorl	$1, %edx
	movl	-56(%ebp), %eax
	addl	$4, %edx
	movl	8(%eax,%edx,4), %eax
	movl	-52(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_getparam0
	movl	%eax, -12(%ebp)
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	cmpl	$5122, -12(%ebp)
	jne	L246
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movb	-33(%ebp), %al
	orl	$8, %eax
	movb	%al, (%edx)
	addl	$2, -28(%ebp)
	jmp	L247
L246:
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movb	-33(%ebp), %al
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$124, (%eax)
	addl	$3, -28(%ebp)
	movl	-12(%ebp), %eax
	andl	$15, %eax
	movb	%al, -33(%ebp)
	cmpb	$15, -33(%ebp)
	je	L248
	cmpb	$1, -33(%ebp)
	jne	L610
L248:
	movl	-12(%ebp), %eax
	andl	$192, %eax
	testl	%eax, %eax
	jne	L611
L249:
	movl	-12(%ebp), %eax
	andl	$48, %eax
	cmpl	$32, %eax
	jne	L612
L250:
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L613
L247:
	movb	$0, -33(%ebp)
	jmp	L41
L62:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	testb	%al, %al
	je	L614
L251:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$3, %al
	ja	L615
L252:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$1, %al
	je	L616
L253:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$241, %eax
	testl	%eax, %eax
	jne	L617
L254:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L618
L255:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$2, %al
	jne	L256
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$32, %eax
	testl	%eax, %eax
	jne	L257
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$15, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$-81, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$5, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$6, %eax
	movb	$122, (%eax)
	addl	$7, -28(%ebp)
L258:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L619
L259:
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L260
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-56(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$23, %eax
	jg	L620
L260:
	movl	-56(%ebp), %eax
	movl	64(%eax), %edx
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	andl	%edx, %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	L621
L261:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-12(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	jmp	L121
L257:
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 48(%eax)
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 44(%eax)
	movl	-56(%ebp), %eax
	movl	52(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 56(%eax)
L256:
	movl	-56(%ebp), %eax
	movl	48(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L622
L262:
	movl	_mcode.1884, %eax
	andl	$84, %eax
	movl	%eax, _mcode.1884
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L263
	movl	_mcode.1884, %eax
	orl	$92, %eax
	movl	%eax, _mcode.1884
L263:
	movl	-56(%ebp), %eax
	movl	48(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, %edx
	andl	$15, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$_mcode.1884, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode90
	testl	%eax, %eax
	jne	L623
L264:
	movl	-28(%ebp), %eax
	movb	$125, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$122, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$124, (%eax)
	addl	$5, -28(%ebp)
	jmp	L258
L63:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	andl	$48, %eax
	cmpl	$16, %eax
	jne	L265
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
L265:
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L624
L266:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L267
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-12(%ebp), %eax
	sarl	$9, %eax
	cmpl	$23, %eax
	jg	L625
L267:
	andl	$15, -12(%ebp)
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	andl	$240, %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	testl	%eax, %eax
	jne	L268
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	andl	%eax, -12(%ebp)
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	sarl	$9, %eax
	cmpl	$23, %eax
	jg	L626
L269:
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-124, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$122, (%eax)
	addl	$5, -28(%ebp)
	jmp	L270
L268:
	movl	-72(%ebp), %eax
	cmpl	$32, %eax
	jne	L627
L271:
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	andl	$3824, %eax
	testl	%eax, %eax
	jne	L272
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-88, (%eax)
	addl	$2, -28(%ebp)
	jmp	L273
L272:
	cmpl	$4, -12(%ebp)
	jg	L628
L274:
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-10, (%eax)
	movl	-56(%ebp), %eax
	movl	$0, 68(%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$122, (%eax)
	addl	$5, -28(%ebp)
L273:
	movl	-28(%ebp), %eax
	movb	$124, (%eax)
	incl	-28(%ebp)
	movl	-12(%ebp), %eax
	addl	$_table.1886, %eax
	movb	(%eax), %al
	movzbl	%al, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L629
L270:
	cmpl	$0, -12(%ebp)
	je	L630
L275:
	cmpl	$1, -12(%ebp)
	je	L276
	movl	-92(%ebp), %eax
	leal	1(%eax), %edx
	movl	-92(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	orl	$1, %eax
	movb	%al, (%edx)
L276:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-12(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	jmp	L121
L64:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$249, %eax
	testl	%eax, %eax
	jne	L631
L277:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L632
L278:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$228, %eax
	testl	%eax, %eax
	jne	L633
L279:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L280
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-56(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$23, %eax
	jg	L634
L280:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$15, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	3(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, %cl
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$1, %eax
	xorl	%ecx, %eax
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$5, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$6, %eax
	movb	$122, (%eax)
	addl	$7, -28(%ebp)
	jmp	L121
L65:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L635
L281:
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 64(%eax)
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$240, %eax
	testl	%eax, %eax
	jne	L636
L282:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L283
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L637
L283:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$15, %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	cmpl	$1, %eax
	jle	L638
L284:
	movl	-72(%ebp), %eax
	cmpl	$4, %eax
	jg	L639
L285:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-72(%ebp), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	je	L640
L286:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-72(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$15, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	3(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$5, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$6, %eax
	movb	$122, (%eax)
	movl	-56(%ebp), %eax
	movl	48(%eax), %eax
	cmpl	$8705, %eax
	jne	L287
	movl	-28(%ebp), %eax
	leal	3(%eax), %edx
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	(%eax), %al
	orl	$1, %eax
	movb	%al, (%edx)
	addl	$7, -28(%ebp)
	jmp	L121
L287:
	movl	-56(%ebp), %eax
	movl	48(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L641
L289:
	movl	-28(%ebp), %eax
	addl	$7, %eax
	movb	$124, (%eax)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L642
L290:
	addl	$8, -28(%ebp)
	jmp	L121
L66:
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	testb	%al, %al
	je	L291
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$1, %al
	jne	L643
L292:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	shrb	$3, %al
	movzbl	%al, %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	jmp	L293
L291:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$2, %al
	jne	L294
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	cmpl	$516, %eax
	je	L295
	movl	-72(%ebp), %eax
	cmpl	$4610, %eax
	jne	L91
L295:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-72(%ebp), %eax
	andl	$7, %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	jmp	L293
L294:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$1, %al
	jne	L644
L293:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$48, %eax
	cmpl	$32, %eax
	jne	L645
L296:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$-64, %eax
	movb	%al, -33(%ebp)
	cmpb	$64, -33(%ebp)
	je	L646
L297:
	cmpb	$-128, -33(%ebp)
	je	L647
L298:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$15, %eax
	movb	%al, -33(%ebp)
	cmpb	$4, -33(%ebp)
	je	L648
L299:
	cmpb	$2, -33(%ebp)
	je	L649
L300:
	movl	-56(%ebp), %eax
	movl	24(%eax), %eax
	movl	-52(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_getparam0
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, (%edx)
	movl	-52(%ebp), %eax
	leal	16(%eax), %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_rel_expr
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$124, (%eax)
	addl	$3, -28(%ebp)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$1, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L650
L301:
	movb	$0, -33(%ebp)
	jmp	L41
L67:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$48, %eax
	cmpl	$32, %eax
	jne	L651
L302:
	movl	$7, -72(%ebp)
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$-64, %eax
	movb	%al, -33(%ebp)
	cmpb	$-128, -33(%ebp)
	jne	L303
	movl	-72(%ebp), %eax
	andl	$6, %eax
	movl	%eax, -72(%ebp)
L303:
	cmpb	$-64, -33(%ebp)
	je	L652
L304:
	cmpb	$64, -33(%ebp)
	jne	L305
	movl	-72(%ebp), %eax
	andl	$1, %eax
	movl	%eax, -72(%ebp)
L305:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-72(%ebp), %eax
	andl	%edx, %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	cmpl	$5, %eax
	jle	L306
	movl	-20(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	jne	L307
	movl	-72(%ebp), %eax
	andl	$-5, %eax
	movl	%eax, -72(%ebp)
L307:
	movl	-20(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L306
	movl	-72(%ebp), %eax
	andl	$-3, %eax
	movl	%eax, -72(%ebp)
L306:
	movl	-72(%ebp), %eax
	testl	%eax, %eax
	je	L653
	movb	$2, -33(%ebp)
	movl	$84, _mcode.1891
	movl	-72(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L309
	movb	$4, -33(%ebp)
	movl	$92, _mcode.1891
L309:
	movl	-72(%ebp), %eax
	cmpl	$1, %eax
	jne	L310
	movb	$1, -33(%ebp)
L310:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movzbl	-33(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movb	$15, -33(%ebp)
	movl	-72(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-72(%ebp), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	jne	L311
	movl	-72(%ebp), %eax
	movb	%al, -33(%ebp)
L311:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	orl	$-128, %eax
	movzbl	%al, %eax
	movl	%eax, _mcode.1891+16
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	orl	$112, %eax
	movzbl	%al, %eax
	movl	%eax, _mcode.1891+24
	movl	-52(%ebp), %eax
	leal	16(%eax), %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_rel_expr
	movb	-33(%ebp), %al
	movsbl	%al, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$_mcode.1891, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode91
	movb	%al, %dl
	movl	-56(%ebp), %eax
	movb	%dl, 76(%eax)
	movl	-56(%ebp), %eax
	movb	76(%eax), %al
	testb	%al, %al
	jne	L654
L312:
	movl	-28(%ebp), %eax
	movb	$125, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$126, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$124, (%eax)
	addl	$3, -28(%ebp)
	movb	$0, -33(%ebp)
	jmp	L41
L68:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L655
L313:
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 64(%eax)
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L314
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$23, %eax
	jg	L656
L314:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$15, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$5, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$6, %eax
	movb	$122, (%eax)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$240, %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	testl	%eax, %eax
	jne	L315
	movl	-56(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$23, %eax
	jg	L657
L316:
	movl	-28(%ebp), %eax
	leal	3(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	orl	$-125, %eax
	movb	%al, (%edx)
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	%eax, -12(%ebp)
	addl	$7, -28(%ebp)
	jmp	L317
L315:
	movl	-72(%ebp), %eax
	cmpl	$32, %eax
	jne	L658
L318:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	movl	%eax, %edx
	sall	$6, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$-70, (%eax)
	movl	-28(%ebp), %eax
	addl	$7, %eax
	movb	$124, (%eax)
	addl	$8, -28(%ebp)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$0, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L659
L317:
	andl	$15, -12(%ebp)
	cmpl	$1, -12(%ebp)
	jle	L660
L319:
	cmpl	$15, -12(%ebp)
	jne	L320
	andl	$1, -12(%ebp)
L320:
	cmpl	$4, -12(%ebp)
	jg	L661
L321:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movl	-12(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	jmp	L121
L69:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L662
L322:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L663
L323:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	L664
L324:
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	L665
L325:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-56, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$124, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$125, (%eax)
	addl	$4, -28(%ebp)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$0, 12(%esp)
	movl	$5, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L666
L326:
	movl	-56(%ebp), %eax
	movl	24(%eax), %eax
	movl	-52(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_getparam0
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$2, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	je	L667
	jmp	L132
L70:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$752, %eax
	cmpl	$32, %eax
	jne	L668
L328:
	movl	-60(%ebp), %eax
	movb	$-124, 20(%eax)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%eax, -96(%ebp)
	movl	-96(%ebp), %eax
	movl	$1, (%eax)
	movl	-96(%ebp), %eax
	movl	$8, 4(%eax)
	movl	-96(%ebp), %eax
	addl	$8, %eax
	movl	$1, (%eax)
	movl	-96(%ebp), %eax
	addl	$8, %eax
	movl	$5, 4(%eax)
	movl	-96(%ebp), %eax
	addl	$16, %eax
	movl	$0, (%eax)
	movl	-96(%ebp), %eax
	leal	16(%eax), %edx
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	movl	%eax, 4(%edx)
	movl	-96(%ebp), %eax
	addl	$24, %eax
	movl	$1, (%eax)
	movl	-96(%ebp), %eax
	addl	$24, %eax
	movl	$8, 4(%eax)
	movl	-96(%ebp), %eax
	addl	$32, %eax
	movl	$1, (%eax)
	movl	-96(%ebp), %eax
	addl	$32, %eax
	movl	$5, 4(%eax)
	movl	-96(%ebp), %eax
	addl	$40, %eax
	movl	$3, (%eax)
	movl	-96(%ebp), %eax
	leal	40(%eax), %edx
	movl	-52(%ebp), %eax
	movl	36(%eax), %eax
	movl	%eax, 4(%edx)
	movl	-96(%ebp), %eax
	addl	$48, %eax
	movl	$3, (%eax)
	movl	-96(%ebp), %eax
	leal	48(%eax), %edx
	movl	-52(%ebp), %eax
	movl	44(%eax), %eax
	movl	%eax, 4(%edx)
	movl	-96(%ebp), %eax
	addl	$56, %eax
	movl	$0, (%eax)
	movl	-96(%ebp), %eax
	leal	56(%eax), %edx
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	movl	%eax, 4(%edx)
	movl	-96(%ebp), %eax
	addl	$64, %eax
	movl	$0, (%eax)
	movl	-96(%ebp), %eax
	leal	64(%eax), %edx
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	movl	%eax, 4(%edx)
	movl	-60(%ebp), %eax
	movl	104(%eax), %eax
	leal	-96(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put_expr
	movl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	104(%eax), %eax
	subl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%edx, 56(%eax)
	movl	-28(%ebp), %eax
	movb	$89, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$6, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	_put4b
	movl	-28(%ebp), %eax
	addl	$6, %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	7(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, (%edx)
	addl	$8, -28(%ebp)
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	movl	%eax, -72(%ebp)
	movb	$0, -33(%ebp)
	jmp	L329
L330:
	incb	-33(%ebp)
	movl	-72(%ebp), %eax
	sarl	%eax
	movl	%eax, -72(%ebp)
L329:
	movl	-72(%ebp), %eax
	testl	%eax, %eax
	jne	L330
	movl	-44(%ebp), %eax
	movb	43(%eax), %al
	movsbl	%al, %edx
	movzbl	-33(%ebp), %eax
	cmpl	%eax, %edx
	jge	L331
	movb	-33(%ebp), %dl
	movl	-44(%ebp), %eax
	movb	%dl, 43(%eax)
L331:
	movb	$0, -33(%ebp)
	jmp	L41
L71:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	testb	%al, %al
	je	L669
L332:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$1, %al
	jne	L333
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$224, %eax
	testl	%eax, %eax
	jne	L670
L334:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L335
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	andl	$15, %eax
	movb	_sizelist.1899(%eax), %al
	movb	%al, -33(%ebp)
	cmpb	$-1, -33(%ebp)
	je	L671
L336:
	cmpb	$-2, -33(%ebp)
	jne	L333
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L672
L337:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	andl	$3, %eax
	movb	%al, -33(%ebp)
	jmp	L333
L335:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	andl	$-8, %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	cmpl	$72, %eax
	jne	L338
	movb	$4, -33(%ebp)
	jmp	L333
L338:
	movl	-72(%ebp), %eax
	cmpl	$64, %eax
	jne	L673
	movb	$5, -33(%ebp)
L333:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$2, %al
	jne	L340
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	L674
L341:
	movl	$0, -72(%ebp)
	jmp	L342
L345:
	movl	-72(%ebp), %edx
	movl	-56(%ebp), %eax
	addl	$8, %edx
	movl	8(%eax,%edx,4), %eax
	andl	$240, %eax
	testl	%eax, %eax
	jne	L675
L343:
	movl	-72(%ebp), %edx
	movl	-56(%ebp), %eax
	addl	$12, %edx
	movl	4(%eax,%edx,4), %eax
	andl	$-8, %eax
	cmpl	$72, %eax
	jne	L676
L344:
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L342:
	movl	-72(%ebp), %eax
	cmpl	$1, %eax
	jle	L345
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$72, %eax
	jne	L346
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movb	$4, -33(%ebp)
	jmp	L340
L346:
	movl	-56(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$72, %eax
	jne	L677
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movb	$5, -33(%ebp)
L340:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$2, %al
	ja	L678
L348:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	cmpb	$3, -33(%ebp)
	jbe	L349
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
L349:
	movzbl	-33(%ebp), %eax
	leal	2(%eax), %edx
	movl	-40(%ebp), %eax
	movb	12(%eax,%edx), %al
	movb	%al, -33(%ebp)
	movb	-33(%ebp), %al
	testb	%al, %al
	jns	L679
L350:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movb	-33(%ebp), %al
	andl	$7, %eax
	orl	$-40, %eax
	movb	%al, (%edx)
	movzbl	-33(%ebp), %eax
	movl	%eax, %edx
	sall	$6, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$122, (%eax)
	addl	$5, -28(%ebp)
	jmp	L121
L72:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$2, %al
	jne	L351
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	cmpl	$36874, %eax
	jne	L351
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
L351:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$1, %al
	jne	L680
L352:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$240, %eax
	testl	%eax, %eax
	jne	L681
L353:
	movl	-56(%ebp), %eax
	movl	52(%eax), %eax
	andl	$-8, %eax
	cmpl	$72, %eax
	jne	L682
L354:
	movl	-56(%ebp), %eax
	movl	40(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	movl	%eax, %edx
	sall	$6, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	andl	$7, %eax
	orl	$-40, %eax
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$120, (%eax)
	addl	$3, -28(%ebp)
	movb	$2, -33(%ebp)
	jmp	L41
L73:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	cmpl	$4098, %eax
	jne	L683
L355:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	17(%eax), %al
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	3(%eax), %edx
	movl	-40(%ebp), %eax
	movb	18(%eax), %al
	movb	%al, (%edx)
	addl	$4, -28(%ebp)
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movzbl	%al, %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	L684
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	19(%eax), %al
	movb	%al, (%edx)
	addl	$2, -28(%ebp)
	jmp	L41
L75:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L685
L357:
	movl	-28(%ebp), %edx
	leal	-88(%ebp), %eax
	subl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-88(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_flush_bp
	movl	%eax, 16(%ebp)
	cmpl	$0, 16(%ebp)
	je	L686
L358:
	movl	16(%ebp), %eax
	addl	$2049, %eax
	cmpl	20(%ebp), %eax
	jbe	L359
	movl	$0, 16(%ebp)
L359:
	cmpl	$0, 16(%ebp)
	je	L687
L360:
	movl	16(%ebp), %eax
	movb	$88, (%eax)
	incl	16(%ebp)
	movl	-52(%ebp), %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	jne	L361
	movl	_nextlabelid, %eax
	movl	%eax, %ecx
	movl	-52(%ebp), %edx
	movl	%ecx, 40(%edx)
	incl	%eax
	movl	%eax, _nextlabelid
L361:
	movl	-52(%ebp), %eax
	movl	40(%eax), %edx
	movl	-52(%ebp), %eax
	movl	%edx, 44(%eax)
	jmp	L362
L74:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	testb	%al, %al
	jne	L363
	movl	-56(%ebp), %eax
	movl	$37386, 40(%eax)
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
L363:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$2, %al
	jne	L364
	movl	-56(%ebp), %eax
	movl	44(%eax), %eax
	cmpl	$36874, %eax
	je	L688
L365:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	cmpl	$36874, %eax
	jne	L689
L367:
	movl	-56(%ebp), %eax
	movl	44(%eax), %edx
	movl	-56(%ebp), %eax
	movl	%edx, 40(%eax)
	jmp	L366
L688:
	nop
L366:
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
L364:
	movl	-56(%ebp), %eax
	movb	77(%eax), %al
	cmpb	$1, %al
	jne	L690
L368:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andb	$241, %ah
	cmpl	$36874, %eax
	jne	L691
L369:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-39, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	3(%eax), %edx
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	sarl	$9, %eax
	andl	$7, %eax
	subl	$56, %eax
	movb	%al, (%edx)
	addl	$4, -28(%ebp)
	jmp	L41
L76:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$255, %eax
	cmpl	$47, %eax
	jne	L692
L370:
	movl	-60(%ebp), %eax
	movb	20(%eax), %al
	testb	%al, %al
	je	L371
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	cmpb	$1, %al
	jne	L693
L372:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
	addl	$2, -28(%ebp)
	jmp	L41
L371:
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	cmpl	$7, %eax
	jg	L694
L374:
	movl	-28(%ebp), %eax
	movb	$89, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$6, (%eax)
	movl	-28(%ebp), %eax
	leal	2(%eax), %edx
	movl	-72(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-28(%ebp), %eax
	leal	6(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	orl	$48, %eax
	movb	%al, (%edx)
	addl	$7, -28(%ebp)
L375:
	movl	-28(%ebp), %eax
	movb	$0, (%eax)
	incl	-28(%ebp)
	movl	-72(%ebp), %eax
	decl	%eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	testl	%eax, %eax
	jne	L375
	movl	-60(%ebp), %eax
	movb	$-124, 20(%eax)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%eax, -96(%ebp)
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$512, %eax
	testl	%eax, %eax
	jne	L376
	movl	-96(%ebp), %eax
	movl	$0, (%eax)
	movl	-96(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	52(%edx), %edx
	movl	%edx, 4(%eax)
L376:
	movl	-60(%ebp), %eax
	movl	104(%eax), %eax
	leal	-96(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put_expr
	movl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	104(%eax), %eax
	subl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%edx, 56(%eax)
	jmp	L41
L77:
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	L695
L377:
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L696
L378:
	movl	-28(%ebp), %edx
	leal	-88(%ebp), %eax
	subl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-88(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_flush_bp
	movl	%eax, 16(%ebp)
	cmpl	$0, 16(%ebp)
	je	L697
L379:
	movl	16(%ebp), %eax
	addl	$2048, %eax
	cmpl	20(%ebp), %eax
	jbe	L380
	movl	$0, 16(%ebp)
L380:
	cmpl	$0, 16(%ebp)
	je	L698
L362:
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%eax, -96(%ebp)
	movl	-56(%ebp), %eax
	movl	40(%eax), %eax
	andl	$512, %eax
	testl	%eax, %eax
	jne	L381
	movl	-96(%ebp), %eax
	movl	$0, (%eax)
	movl	-96(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	52(%edx), %edx
	movl	%edx, 4(%eax)
L381:
	leal	-96(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_put_expr
	movl	%eax, 16(%ebp)
	jmp	L382
L78:
	movl	-56(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -92(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L132
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L132
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	je	L132
	movl	-52(%ebp), %eax
	leal	16(%eax), %esi
	movl	-52(%ebp), %eax
	leal	48(%eax), %ebx
	movl	-52(%ebp), %eax
	movl	68(%eax), %ecx
	movl	-52(%ebp), %eax
	movl	64(%eax), %edx
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	movl	%esi, 24(%esp)
	movl	%ebx, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	leal	-72(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	leal	-92(%ebp), %eax
	movl	%eax, (%esp)
	call	_getparam
	movl	%eax, -12(%ebp)
	movb	$0, -33(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L383
	movl	-92(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -33(%ebp)
	incl	%eax
	movl	%eax, -92(%ebp)
L383:
	movl	-12(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	jne	L384
	cmpb	$0, -33(%ebp)
	je	L385
	cmpb	$10, -33(%ebp)
	je	L385
	cmpb	$59, -33(%ebp)
	jne	L699
L385:
	movl	-56(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 64(%eax)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	movl	%eax, %edx
	sall	$6, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-12(%ebp), %eax
	andl	$6, %eax
	movb	%al, -33(%ebp)
	cmpb	$0, -33(%ebp)
	je	L700
L386:
	cmpb	$6, -33(%ebp)
	jne	L387
	movb	$1, -33(%ebp)
L387:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movzbl	-33(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	-12(%ebp), %eax
	andl	$-64, %eax
	movb	%al, -33(%ebp)
	cmpb	$64, -33(%ebp)
	je	L701
L388:
	cmpb	$-64, -33(%ebp)
	jne	L389
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	movl	%eax, %edx
	orb	$2, %dh
	movl	-56(%ebp), %eax
	movl	%edx, 68(%eax)
L389:
	movl	-56(%ebp), %eax
	movb	$0, 77(%eax)
	movl	-12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L390
	movl	-56(%ebp), %eax
	movb	$1, 77(%eax)
	movl	-72(%ebp), %eax
	cmpl	$23, %eax
	jg	L702
L390:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-1, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$120, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$121, (%eax)
	movl	-28(%ebp), %eax
	addl	$4, %eax
	movb	$122, (%eax)
	addl	$5, -28(%ebp)
	jmp	L121
L384:
	cmpb	$58, -33(%ebp)
	je	L391
	cmpb	$44, -33(%ebp)
	je	L391
	cmpb	$0, -33(%ebp)
	je	L392
	cmpb	$10, -33(%ebp)
	je	L392
	cmpb	$59, -33(%ebp)
	jne	L703
L392:
	movl	-12(%ebp), %eax
	andl	$-64, %eax
	movb	%al, -33(%ebp)
	cmpb	$-64, -33(%ebp)
	je	L704
L393:
	cmpb	$64, -33(%ebp)
	jne	L394
	movb	$1, -33(%ebp)
	jmp	L395
L394:
	cmpb	$-128, -33(%ebp)
	jne	L396
	movb	$6, -33(%ebp)
	jmp	L395
L396:
	movb	$7, -33(%ebp)
L395:
	movl	-12(%ebp), %eax
	movb	%al, %dl
	movb	-33(%ebp), %al
	andl	%edx, %eax
	movb	%al, -33(%ebp)
	cmpb	$5, -33(%ebp)
	jbe	L397
	movl	-20(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	jne	L398
	andb	$-5, -33(%ebp)
L398:
	movl	-20(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L397
	andb	$-3, -33(%ebp)
L397:
	cmpb	$0, -33(%ebp)
	je	L705
L399:
	movzbl	-33(%ebp), %eax
	andl	$6, %eax
	testl	%eax, %eax
	je	L400
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movzbl	-33(%ebp), %eax
	andl	$6, %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
L400:
	movl	-52(%ebp), %eax
	leal	16(%eax), %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_rel_expr
	movl	-40(%ebp), %eax
	movb	16(%eax), %al
	testb	%al, %al
	je	L401
	movl	_mcode.1916, %eax
	andl	$84, %eax
	movl	%eax, _mcode.1916
	movzbl	-33(%ebp), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L402
	movl	_mcode.1916, %eax
	orl	$92, %eax
	movl	%eax, _mcode.1916
L402:
	movzbl	-33(%ebp), %eax
	movzbl	-33(%ebp), %edx
	decl	%edx
	andl	%edx, %eax
	testl	%eax, %eax
	je	L403
	movb	$15, -33(%ebp)
L403:
	movb	-33(%ebp), %al
	movsbl	%al, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$_mcode.1916, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode90
	testl	%eax, %eax
	jne	L706
L404:
	movl	-28(%ebp), %eax
	movb	$125, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$124, (%eax)
	addl	$2, -28(%ebp)
	movb	$0, -33(%ebp)
	jmp	L41
L401:
	andb	$-2, -33(%ebp)
	cmpb	$0, -33(%ebp)
	je	L707
L405:
	movb	-33(%ebp), %al
	incl	%eax
	movzbl	%al, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L708
L406:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$-24, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$124, (%eax)
	addl	$3, -28(%ebp)
	movb	$0, -33(%ebp)
	jmp	L41
L391:
	movl	-12(%ebp), %eax
	andl	$-64, %eax
	movb	%al, -33(%ebp)
	cmpb	$64, -33(%ebp)
	je	L709
L407:
	cmpb	$-128, -33(%ebp)
	je	L710
L408:
	movl	-12(%ebp), %eax
	andl	$6, %eax
	movb	%al, -33(%ebp)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	$3, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L711
L409:
	movl	-52(%ebp), %eax
	leal	16(%eax), %esi
	movl	-52(%ebp), %eax
	leal	48(%eax), %ebx
	movl	-52(%ebp), %eax
	movl	68(%eax), %ecx
	movl	-52(%ebp), %eax
	movl	64(%eax), %edx
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	movl	%esi, 24(%esp)
	movl	%ebx, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	leal	-72(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	leal	-92(%ebp), %eax
	movl	%eax, (%esp)
	call	_getparam
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$48, %eax
	cmpl	$32, %eax
	jne	L712
L410:
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L411
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L411
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	jne	L713
L411:
	movl	-12(%ebp), %eax
	movb	%al, %dl
	movb	-33(%ebp), %al
	andl	%edx, %eax
	movb	%al, -33(%ebp)
	cmpb	$5, -33(%ebp)
	jbe	L412
	movl	-20(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	jne	L413
	andb	$-5, -33(%ebp)
L413:
	movl	-20(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	jne	L412
	andb	$-3, -33(%ebp)
L412:
	cmpb	$0, -33(%ebp)
	je	L714
L414:
	movl	-56(%ebp), %eax
	movl	36(%eax), %edx
	movzbl	-33(%ebp), %eax
	decl	%eax
	sall	$2, %eax
	addl	$_tbl_o16o32.1817, %eax
	movl	(%eax), %eax
	orl	%eax, %edx
	movl	-56(%ebp), %eax
	movl	%edx, 36(%eax)
	movb	-33(%ebp), %al
	incl	%eax
	movzbl	%al, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$5, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L715
L415:
	movl	-28(%ebp), %eax
	movb	$49, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	15(%eax), %al
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movb	$125, (%eax)
	movl	-28(%ebp), %eax
	addl	$3, %eax
	movb	$124, (%eax)
	addl	$4, -28(%ebp)
	movb	$0, -33(%ebp)
	jmp	L41
L79:
	movl	-56(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -92(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L132
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L132
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	je	L132
	movl	-52(%ebp), %eax
	movb	13(%eax), %al
	movsbl	%al, %edx
	movl	-56(%ebp), %eax
	movl	36(%eax), %eax
	movl	%edx, 16(%esp)
	movl	-20(%ebp), %edx
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_putprefix
	movl	%eax, 16(%ebp)
	movl	-28(%ebp), %edx
	leal	-88(%ebp), %eax
	subl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-88(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_flush_bp
	movl	%eax, 16(%ebp)
	cmpl	$0, 16(%ebp)
	je	L716
L416:
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skipspace
	movl	%eax, -92(%ebp)
	movl	-92(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L717
L417:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$44, %al
	je	L718
L418:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	je	L719
L419:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L720
L420:
	movl	-92(%ebp), %eax
	incl	%eax
	movl	%eax, -92(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L721
L421:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$44, %al
	je	L722
L423:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	je	L723
L424:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$32, %al
	ja	L420
	jmp	L422
L721:
	nop
	jmp	L422
L722:
	nop
	jmp	L422
L723:
	nop
L422:
	movl	-92(%ebp), %eax
	movl	%eax, %edx
	movl	-28(%ebp), %eax
	movl	%edx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	movl	%eax, -72(%ebp)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	cmpb	$2, %al
	sete	%al
	movzbl	%al, %edx
	movl	-72(%ebp), %eax
	movl	%edx, 8(%esp)
	movl	-28(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_label2id
	movl	%eax, -12(%ebp)
	movl	16(%ebp), %eax
	addl	$15, %eax
	cmpl	20(%ebp), %eax
	jbe	L425
	movl	$0, 16(%ebp)
	jmp	L26
L425:
	movl	16(%ebp), %eax
	movb	$-10, (%eax)
	movl	16(%ebp), %eax
	leal	1(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	-72(%ebp), %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	3(%eax), %edx
	movl	-72(%ebp), %eax
	sarl	$8, %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	4(%eax), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	cmpb	$1, %al
	jne	L426
	movl	16(%ebp), %eax
	addl	$8, %eax
	movb	$15, (%eax)
	movl	16(%ebp), %eax
	addl	$9, %eax
	movb	$3, (%eax)
	movl	16(%ebp), %eax
	addl	$10, %eax
	movl	%eax, -28(%ebp)
	movl	16(%ebp), %eax
	leal	11(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-28(%ebp), %eax
	movb	$7, (%eax)
	addl	$11, 16(%ebp)
L427:
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	leal	1(%eax), %edx
	movl	-28(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	sarl	$8, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	L427
	jmp	L428
L426:
	movl	16(%ebp), %eax
	addl	$8, %eax
	movb	$44, (%eax)
	movl	16(%ebp), %eax
	addl	$9, %eax
	movb	$2, (%eax)
	movl	16(%ebp), %eax
	leal	10(%eax), %edx
	movl	-12(%ebp), %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	11(%eax), %edx
	movl	-12(%ebp), %eax
	sarl	$8, %eax
	movb	%al, (%edx)
	movl	_nask_L_LABEL0, %eax
	cmpl	%eax, -12(%ebp)
	jge	L428
	addl	$12, 16(%ebp)
L428:
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skipspace
	movl	%eax, -92(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L724
L429:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$44, %al
	je	L430
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	L431
	jmp	L382
L430:
	movl	-92(%ebp), %eax
	incl	%eax
	movl	%eax, -92(%ebp)
	jmp	L416
L431:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	je	L725
	jmp	L132
L80:
	movl	-60(%ebp), %eax
	movb	20(%eax), %al
	testb	%al, %al
	je	L433
	jmp	L373
L693:
	nop
L373:
	movl	-56(%ebp), %eax
	movb	$6, 76(%eax)
	jmp	L48
L433:
	movl	-56(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -92(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L132
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L132
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	je	L132
	movl	-52(%ebp), %eax
	leal	16(%eax), %esi
	movl	-52(%ebp), %eax
	leal	48(%eax), %ebx
	movl	-52(%ebp), %eax
	movl	68(%eax), %ecx
	movl	-52(%ebp), %eax
	movl	64(%eax), %edx
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	movl	%esi, 24(%esp)
	movl	%ebx, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	leal	-72(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	leal	-92(%ebp), %eax
	movl	%eax, (%esp)
	call	_getparam
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L726
L434:
	movl	-60(%ebp), %eax
	movb	$-124, 20(%eax)
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%eax, -96(%ebp)
	movl	-12(%ebp), %eax
	andl	$512, %eax
	testl	%eax, %eax
	jne	L435
	movl	-96(%ebp), %eax
	movl	$0, (%eax)
	movl	-96(%ebp), %eax
	movl	-72(%ebp), %edx
	movl	%edx, 4(%eax)
L435:
	movl	-60(%ebp), %eax
	movl	104(%eax), %eax
	leal	-96(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put_expr
	movl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	104(%eax), %eax
	subl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%edx, 56(%eax)
	movl	-28(%ebp), %eax
	movb	$89, (%eax)
	movl	-28(%ebp), %eax
	incl	%eax
	movb	$6, (%eax)
	movl	-28(%ebp), %eax
	addl	$2, %eax
	movl	%eax, 4(%esp)
	movl	$1, (%esp)
	call	_put4b
	addl	$6, -28(%ebp)
	movl	-92(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	_decoder
	movl	%eax, -32(%ebp)
	movl	-56(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	L727
	jmp	L373
L81:
	movl	-56(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -92(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L132
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L132
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	je	L132
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	testb	%al, %al
	je	L728
L437:
	movl	-52(%ebp), %eax
	movb	13(%eax), %al
	movsbl	%al, %edx
	movl	-56(%ebp), %eax
	movl	36(%eax), %eax
	movl	%edx, 16(%esp)
	movl	-20(%ebp), %edx
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_putprefix
	movl	%eax, 16(%ebp)
	movl	-28(%ebp), %edx
	leal	-88(%ebp), %eax
	subl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-88(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_flush_bp
	movl	%eax, 16(%ebp)
	cmpl	$0, 16(%ebp)
	je	L729
L438:
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skipspace
	movl	%eax, -92(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L439
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -33(%ebp)
	cmpb	$34, -33(%ebp)
	je	L440
	cmpb	$39, -33(%ebp)
	jne	L730
L440:
	movl	-92(%ebp), %eax
	movl	%eax, -28(%ebp)
L443:
	incl	-28(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	cmpl	-28(%ebp), %eax
	jbe	L731
L441:
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L732
L442:
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	cmpb	-33(%ebp), %al
	jne	L443
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	movl	-28(%ebp), %edx
	incl	%edx
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_skipspace
	movl	%eax, -28(%ebp)
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	cmpl	-28(%ebp), %eax
	jbe	L444
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	cmpb	$44, %al
	je	L444
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L444
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	jne	L733
L444:
	movl	-92(%ebp), %eax
	incl	%eax
	movl	%eax, -92(%ebp)
	movl	$0, -16(%ebp)
	jmp	L452
L735:
	nop
L452:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	cmpb	-33(%ebp), %al
	jne	L445
	cmpl	$0, -16(%ebp)
	jne	L446
	jmp	L447
L445:
	movl	16(%ebp), %eax
	addl	$5, %eax
	cmpl	20(%ebp), %eax
	jbe	L448
	movl	$0, 16(%ebp)
L448:
	cmpl	$0, 16(%ebp)
	je	L734
L449:
	cmpl	$0, -16(%ebp)
	jne	L450
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, %dl
	orl	$48, %edx
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
L450:
	incl	-16(%ebp)
	movl	-92(%ebp), %eax
	movb	(%eax), %cl
	movl	16(%ebp), %edx
	movb	%cl, (%edx)
	incl	16(%ebp)
	incl	%eax
	movl	%eax, -92(%ebp)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	cmpl	-16(%ebp), %eax
	jne	L735
	movl	$0, -16(%ebp)
	jmp	L452
L446:
	movl	16(%ebp), %eax
	movb	$0, (%eax)
	incl	16(%ebp)
	incl	-16(%ebp)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	cmpl	%eax, -16(%ebp)
	jl	L446
L447:
	movl	-28(%ebp), %eax
	movl	%eax, -92(%ebp)
	jmp	L453
L730:
	nop
	jmp	L439
L731:
	nop
	jmp	L439
L732:
	nop
	jmp	L439
L733:
	nop
L439:
	movl	-52(%ebp), %eax
	leal	16(%eax), %esi
	movl	-52(%ebp), %eax
	leal	48(%eax), %ebx
	movl	-52(%ebp), %eax
	movl	68(%eax), %ecx
	movl	-52(%ebp), %eax
	movl	64(%eax), %edx
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	movl	%esi, 24(%esp)
	movl	%ebx, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	leal	-72(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	leal	-92(%ebp), %eax
	movl	%eax, (%esp)
	call	_getparam
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	andl	$240, %eax
	cmpl	$32, %eax
	jne	L736
L454:
	movl	-40(%ebp), %eax
	movb	14(%eax), %al
	movzbl	%al, %eax
	movl	%eax, %edx
	andl	$7, %edx
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$4, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L737
L455:
	movl	-60(%ebp), %eax
	movl	40(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	-60(%ebp), %eax
	movl	88(%eax), %eax
	movl	%eax, -28(%ebp)
	movl	-60(%ebp), %eax
	movb	16(%eax), %al
	movb	%al, -33(%ebp)
	movb	-33(%ebp), %al
	testb	%al, %al
	js	L456
	movzbl	-33(%ebp), %eax
	incl	%eax
	addl	16(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L457
	movl	$0, 16(%ebp)
L457:
	cmpl	$0, 16(%ebp)
	je	L738
L458:
	andb	$31, -33(%ebp)
	movb	-33(%ebp), %al
	movb	%al, %dl
	orl	$48, %edx
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
L459:
	movl	-16(%ebp), %eax
	movb	%al, %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	sarl	$8, -16(%ebp)
	decb	-33(%ebp)
	cmpb	$0, -33(%ebp)
	jne	L459
	jmp	L453
L456:
	movl	-16(%ebp), %eax
	addl	$2, %eax
	addl	16(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L460
	movl	$0, 16(%ebp)
L460:
	cmpl	$0, 16(%ebp)
	je	L739
L461:
	movb	-33(%ebp), %al
	andl	$31, %eax
	leal	55(%eax), %edx
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	-33(%ebp), %dl
	shrb	$5, %dl
	andl	$3, %edx
	movb	%dl, (%eax)
	addl	$2, 16(%ebp)
L462:
	movl	-28(%ebp), %eax
	movb	(%eax), %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	incl	-28(%ebp)
	decl	-16(%ebp)
	cmpl	$0, -16(%ebp)
	jne	L462
L453:
	movl	-52(%ebp), %eax
	movl	(%eax), %edx
	movl	-92(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L740
L463:
	movl	-92(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -33(%ebp)
	cmpb	$10, -33(%ebp)
	je	L741
L464:
	cmpb	$59, -33(%ebp)
	je	L742
L465:
	cmpb	$44, -33(%ebp)
	jne	L743
L466:
	movl	-52(%ebp), %eax
	movl	(%eax), %eax
	movl	-92(%ebp), %edx
	incl	%edx
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_skipspace
	movl	%eax, -92(%ebp)
	jmp	L438
L82:
	movl	12(%ebp), %eax
	movl	%eax, -32(%ebp)
	jmp	L41
L667:
	nop
	jmp	L41
L684:
	nop
L41:
	movzbl	-33(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	L468
	movl	-56(%ebp), %eax
	leal	36(%eax), %edx
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	_testmem0
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	jne	L469
	jmp	L194
L581:
	nop
L194:
	movl	-56(%ebp), %eax
	movb	$5, 76(%eax)
	jmp	L48
L469:
	movl	-24(%ebp), %eax
	andl	$3, %eax
	orl	%eax, -20(%ebp)
L468:
	movl	-52(%ebp), %eax
	movb	13(%eax), %al
	movsbl	%al, %edx
	movl	-56(%ebp), %eax
	movl	36(%eax), %eax
	movl	%edx, 16(%esp)
	movl	-20(%ebp), %edx
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_putprefix
	movl	%eax, 16(%ebp)
	cmpb	$0, -33(%ebp)
	je	L467
	movl	-56(%ebp), %eax
	movl	68(%eax), %eax
	movl	%eax, %edx
	sarl	$9, %edx
	movl	-56(%ebp), %eax
	movl	64(%eax), %eax
	movl	%edx, 16(%esp)
	movl	-52(%ebp), %edx
	movl	%edx, 12(%esp)
	movl	%eax, 8(%esp)
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_putmodrm
	jmp	L467
L523:
	nop
L467:
	movl	-60(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	4(%eax), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	addl	16(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L470
	movl	$0, 16(%ebp)
L470:
	cmpl	$0, 16(%ebp)
	je	L744
L471:
	movl	$0, -12(%ebp)
	jmp	L472
L473:
	movl	-12(%ebp), %eax
	addl	16(%ebp), %eax
	movl	-60(%ebp), %edx
	movl	4(%edx), %ecx
	movl	-12(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	incl	-12(%ebp)
L472:
	movl	-72(%ebp), %eax
	cmpl	%eax, -12(%ebp)
	jl	L473
	movl	-72(%ebp), %eax
	addl	%eax, 16(%ebp)
	movl	-28(%ebp), %edx
	leal	-88(%ebp), %eax
	subl	%eax, %edx
	movl	-60(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	leal	-88(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_flush_bp
	movl	%eax, 16(%ebp)
	cmpl	$0, 16(%ebp)
	je	L745
L474:
	cmpl	$0, -40(%ebp)
	je	L382
	movl	-40(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-25, %al
	jne	L382
	movl	16(%ebp), %eax
	addl	$14, %eax
	cmpl	20(%ebp), %eax
	jbe	L475
	movl	$0, 16(%ebp)
L475:
	cmpl	$0, 16(%ebp)
	je	L746
L476:
	movl	16(%ebp), %eax
	movb	$-15, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, (%edx)
	addl	$3, 16(%ebp)
	movl	-44(%ebp), %eax
	movl	12(%eax), %edx
	movl	16(%ebp), %ecx
	movl	-44(%ebp), %eax
	movl	20(%eax), %eax
	movl	%ecx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	addl	%eax, %edx
	movl	-44(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	-52(%ebp), %eax
	movl	36(%eax), %edx
	movl	-44(%ebp), %eax
	movl	%edx, (%eax)
	movl	-52(%ebp), %eax
	movl	40(%eax), %edx
	movl	-44(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-52(%ebp), %eax
	movl	44(%eax), %edx
	movl	-44(%ebp), %eax
	movl	%edx, 8(%eax)
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, 20(%eax)
	movl	-44(%ebp), %eax
	movl	(%eax), %edx
	movl	-52(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	-44(%ebp), %eax
	movl	4(%eax), %edx
	movl	-52(%ebp), %eax
	movl	%edx, 40(%eax)
	movl	-44(%ebp), %eax
	movl	8(%eax), %edx
	movl	-52(%ebp), %eax
	movl	%edx, 44(%eax)
	movl	-44(%ebp), %eax
	movl	12(%eax), %eax
	testl	%eax, %eax
	jne	L382
	movl	16(%ebp), %eax
	movb	$-15, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	$1, (%eax)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	-40(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, (%edx)
	addl	$3, 16(%ebp)
	movl	-52(%ebp), %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	jne	L477
	movl	_nextlabelid, %eax
	movl	%eax, %ecx
	movl	-52(%ebp), %edx
	movl	%ecx, 40(%edx)
	incl	%eax
	movl	%eax, _nextlabelid
L477:
	movl	-52(%ebp), %eax
	movl	40(%eax), %edx
	movl	-52(%ebp), %eax
	movl	%edx, 44(%eax)
	movl	-52(%ebp), %eax
	movb	14(%eax), %al
	testb	%al, %al
	jne	L478
	jmp	L479
L747:
	nop
	jmp	L479
L748:
	nop
L479:
	movl	16(%ebp), %eax
	movb	$88, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	addl	$2, %eax
	movb	$0, (%eax)
	addl	$3, 16(%ebp)
	jmp	L382
L478:
	movb	$0, -33(%ebp)
	movl	-44(%ebp), %eax
	movb	24(%eax), %al
	cmpb	$46, %al
	jne	L747
L480:
	movl	-44(%ebp), %eax
	movb	25(%eax), %al
	cmpb	$116, %al
	jne	L481
	movb	$1, -33(%ebp)
L481:
	movl	-44(%ebp), %eax
	movb	25(%eax), %al
	cmpb	$100, %al
	jne	L482
	movb	$2, -33(%ebp)
L482:
	movl	-44(%ebp), %eax
	movb	25(%eax), %al
	cmpb	$98, %al
	jne	L483
	movb	$3, -33(%ebp)
L483:
	cmpb	$0, -33(%ebp)
	je	L748
L484:
	movl	16(%ebp), %eax
	movb	$44, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	$2, (%eax)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movb	-33(%ebp), %al
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	addl	$3, %eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	addl	$4, %eax
	movb	$88, (%eax)
	movl	16(%ebp), %eax
	addl	$5, %eax
	movb	$8, (%eax)
	movl	16(%ebp), %eax
	leal	6(%eax), %edx
	movb	-33(%ebp), %al
	movb	%al, (%edx)
	addl	$7, 16(%ebp)
	jmp	L382
L724:
	nop
	jmp	L382
L725:
	nop
	jmp	L382
L740:
	nop
	jmp	L382
L741:
	nop
	jmp	L382
L742:
	nop
L382:
	movl	-32(%ebp), %eax
	movl	%eax, 8(%ebp)
L27:
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L485
L486:
	movl	16(%ebp), %eax
	addl	$81, %eax
	cmpl	20(%ebp), %eax
	jbe	L487
	movl	$0, 16(%ebp)
L487:
	cmpl	$0, 16(%ebp)
	je	L749
L488:
	movl	16(%ebp), %eax
	movb	$-9, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	_put4b
	movl	16(%ebp), %eax
	addl	$5, %eax
	movl	%eax, 4(%esp)
	movl	$0, (%esp)
	call	_put4b
	addl	$9, 16(%ebp)
	movl	-52(%ebp), %eax
	movl	40(%eax), %edx
	movl	-44(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	$0, -72(%ebp)
	jmp	L489
L493:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	24(%eax), %al
	testb	%al, %al
	je	L750
L490:
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -12(%ebp)
	cmpl	$-1, -12(%ebp)
	je	L492
	movl	-12(%ebp), %eax
	addl	-68(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L492
	movl	16(%ebp), %eax
	movb	$-15, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	-72(%ebp), %eax
	movb	%al, (%edx)
	addl	$3, 16(%ebp)
	movl	-44(%ebp), %eax
	movl	12(%eax), %edx
	movl	16(%ebp), %ecx
	movl	-44(%ebp), %eax
	movl	20(%eax), %eax
	movl	%ecx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	addl	%eax, %edx
	movl	-44(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	-72(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, 20(%eax)
	movl	16(%ebp), %eax
	movb	$14, (%eax)
	movl	-12(%ebp), %eax
	addl	-68(%ebp), %eax
	movb	$1, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_putimm
	movl	%eax, 16(%ebp)
L492:
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L489:
	movl	-72(%ebp), %eax
	cmpl	$7, %eax
	jle	L493
	jmp	L491
L750:
	nop
L491:
	movl	-44(%ebp), %eax
	movl	12(%eax), %edx
	movl	16(%ebp), %ecx
	movl	-44(%ebp), %eax
	movl	20(%eax), %eax
	movl	%ecx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	addl	%eax, %edx
	movl	-44(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	16(%ebp), %edx
	movl	-48(%ebp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -72(%ebp)
	movl	-72(%ebp), %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, -32(%ebp)
	movl	$0, -12(%ebp)
	jmp	L494
L495:
	movl	-12(%ebp), %eax
	addl	-32(%ebp), %eax
	movl	-12(%ebp), %edx
	addl	-48(%ebp), %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	incl	-12(%ebp)
L494:
	movl	-72(%ebp), %eax
	cmpl	%eax, -12(%ebp)
	jl	L495
	movl	-64(%ebp), %eax
	movl	-48(%ebp), %edx
	movl	%edx, 20(%eax)
	movl	-64(%ebp), %eax
	movl	20(%eax), %edx
	movl	-64(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	$1, -12(%ebp)
	jmp	L496
L497:
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	%eax, %ebx
	addl	-64(%ebp), %ebx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	%eax, %edx
	addl	-64(%ebp), %edx
	movl	-12(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movl	16(%eax), %esi
	movl	-12(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	%ecx, %eax
	sall	$2, %eax
	addl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movl	12(%eax), %eax
	leal	(%esi,%eax), %eax
	movl	%eax, 20(%edx)
	movl	20(%edx), %eax
	movl	%eax, 16(%ebx)
	incl	-12(%ebp)
L496:
	cmpl	$7, -12(%ebp)
	jle	L497
	movl	-72(%ebp), %eax
	addl	-32(%ebp), %eax
	movl	%eax, 12(%ebp)
	movl	-64(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	20(%eax), %eax
	movl	%eax, -92(%ebp)
L501:
	movl	-32(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -33(%ebp)
	cmpb	$-15, -33(%ebp)
	jne	L498
	movl	-32(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L498
	movl	-92(%ebp), %eax
	movb	$-15, (%eax)
	movl	-92(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
	movl	-92(%ebp), %eax
	leal	2(%eax), %edx
	movl	-32(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	movl	-92(%ebp), %eax
	addl	$3, %eax
	movl	%eax, -92(%ebp)
	movl	-92(%ebp), %edx
	movl	-44(%ebp), %eax
	movl	%edx, 20(%eax)
	movl	-32(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	20(%eax), %eax
	movl	%eax, -92(%ebp)
	addl	$3, -32(%ebp)
	jmp	L499
L498:
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_skipcode
	movl	%eax, -28(%ebp)
L500:
	movl	-92(%ebp), %eax
	movl	-32(%ebp), %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	incl	%eax
	movl	%eax, -92(%ebp)
	incl	-32(%ebp)
	movl	-32(%ebp), %eax
	cmpl	-28(%ebp), %eax
	jb	L500
L499:
	movl	-32(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L501
	movl	-72(%ebp), %eax
	negl	%eax
	addl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	$0, -12(%ebp)
	jmp	L502
L511:
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	24(%eax), %al
	testb	%al, %al
	je	L751
L503:
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	42(%eax), %al
	movb	%al, -33(%ebp)
	cmpb	$-1, -33(%ebp)
	jne	L505
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	43(%eax), %al
	movb	%al, -33(%ebp)
L505:
	movl	16(%ebp), %eax
	addl	$8, %eax
	cmpl	20(%ebp), %eax
	ja	L752
L506:
	movl	16(%ebp), %eax
	movb	$-14, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	-12(%ebp), %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	3(%eax), %edx
	movb	-33(%ebp), %al
	movb	%al, (%edx)
	movb	$0, -33(%ebp)
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	24(%eax), %al
	cmpb	$46, %al
	jne	L507
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	25(%eax), %al
	cmpb	$116, %al
	jne	L508
	movb	$1, -33(%ebp)
L508:
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	25(%eax), %al
	cmpb	$100, %al
	jne	L509
	movb	$2, -33(%ebp)
L509:
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	25(%eax), %al
	cmpb	$98, %al
	jne	L510
	movb	$3, -33(%ebp)
L510:
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	addl	-64(%ebp), %eax
	movb	25(%eax), %al
	cmpb	$97, %al
	jne	L507
	movb	$112, -33(%ebp)
L507:
	movl	16(%ebp), %eax
	addl	$4, %eax
	movb	$-14, (%eax)
	movl	16(%ebp), %eax
	addl	$5, %eax
	movb	$1, (%eax)
	movl	16(%ebp), %eax
	leal	6(%eax), %edx
	movl	-12(%ebp), %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	7(%eax), %edx
	movb	-33(%ebp), %al
	movb	%al, (%edx)
	addl	$8, 16(%ebp)
	incl	-12(%ebp)
L502:
	cmpl	$7, -12(%ebp)
	jle	L511
	jmp	L504
L751:
	nop
L504:
	movl	16(%ebp), %eax
	addl	$11, %eax
	cmpl	20(%ebp), %eax
	ja	L753
L512:
	movl	-52(%ebp), %eax
	movl	8(%eax), %eax
	cmpl	$4589, %eax
	jbe	L513
	movl	-52(%ebp), %eax
	movl	$4589, 8(%eax)
L513:
	movl	16(%ebp), %eax
	movb	$-15, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	$2, (%eax)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	-52(%ebp), %eax
	movb	14(%eax), %al
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	addl	$3, %eax
	movb	$-10, (%eax)
	movl	16(%ebp), %eax
	addl	$4, %eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	leal	5(%eax), %edx
	movl	-52(%ebp), %eax
	movl	8(%eax), %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	addl	$6, %eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	leal	7(%eax), %edx
	movl	-52(%ebp), %eax
	movl	72(%eax), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	addl	$11, 16(%ebp)
	jmp	L26
L516:
	nop
	jmp	L26
L517:
	nop
	jmp	L26
L522:
	nop
	jmp	L26
L686:
	nop
	jmp	L26
L687:
	nop
	jmp	L26
L697:
	nop
	jmp	L26
L698:
	nop
	jmp	L26
L716:
	nop
	jmp	L26
L729:
	nop
	jmp	L26
L734:
	nop
	jmp	L26
L738:
	nop
	jmp	L26
L739:
	nop
	jmp	L26
L744:
	nop
	jmp	L26
L745:
	nop
	jmp	L26
L746:
	nop
	jmp	L26
L749:
	nop
	jmp	L26
L752:
	nop
	jmp	L26
L753:
	nop
L26:
	movl	-56(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	_labelbuf0, %eax
	movl	%eax, (%esp)
	call	_free
	movl	_locallabelbuf0, %eax
	movl	%eax, (%esp)
	call	_free
	movl	-52(%ebp), %eax
	movl	64(%eax), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-52(%ebp), %eax
	movl	68(%eax), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-60(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, (%esp)
	call	_free
	movl	$0, -72(%ebp)
	jmp	L514
L515:
	movl	-72(%ebp), %edx
	movl	-60(%ebp), %eax
	addl	$16, %edx
	movl	8(%eax,%edx,4), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-72(%ebp), %eax
	incl	%eax
	movl	%eax, -72(%ebp)
L514:
	movl	-72(%ebp), %eax
	cmpl	$8, %eax
	jle	L515
	movl	-60(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-68(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	16(%ebp), %eax
	subl	$-128, %esp
	popl	%ebx
	popl	%esi
	leave
	ret
.globl _flush_bp
	.def	_flush_bp;	.scl	2;	.type	32;	.endef
_flush_bp:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	8(%ebp), %eax
	addl	16(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L755
	movl	$0, 16(%ebp)
L755:
	cmpl	$0, 16(%ebp)
	je	L781
L756:
	movl	$0, -12(%ebp)
	jmp	L758
L780:
	movl	-12(%ebp), %eax
	addl	12(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -21(%ebp)
	incl	-12(%ebp)
	cmpb	$45, -21(%ebp)
	je	L759
	cmpb	$14, -21(%ebp)
	jne	L760
L759:
	movl	16(%ebp), %eax
	movb	-21(%ebp), %dl
	movb	%dl, (%eax)
	movl	16(%ebp), %eax
	leal	1(%eax), %edx
	movl	-12(%ebp), %eax
	addl	12(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -21(%ebp)
	movb	-21(%ebp), %al
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	-12(%ebp), %eax
	incl	%eax
	addl	12(%ebp), %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	addl	$2, -12(%ebp)
	addl	$3, 16(%ebp)
	jmp	L761
L762:
	subb	$2, -21(%ebp)
	movl	-12(%ebp), %eax
	addl	12(%ebp), %eax
	movb	(%eax), %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	incl	-12(%ebp)
L761:
	cmpb	$0, -21(%ebp)
	jne	L762
	jmp	L758
L760:
	cmpb	$48, -21(%ebp)
	jbe	L763
	cmpb	$55, -21(%ebp)
	ja	L763
	movl	16(%ebp), %eax
	movb	-21(%ebp), %dl
	movb	%dl, (%eax)
	incl	16(%ebp)
	subb	$48, -21(%ebp)
L764:
	movl	-12(%ebp), %eax
	addl	12(%ebp), %eax
	movb	(%eax), %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	incl	-12(%ebp)
	decb	-21(%ebp)
	cmpb	$0, -21(%ebp)
	jne	L764
	jmp	L758
L763:
	cmpb	$89, -21(%ebp)
	jne	L765
	movl	16(%ebp), %eax
	movb	$89, (%eax)
	movl	24(%ebp), %eax
	movl	104(%eax), %eax
	movl	%eax, -20(%ebp)
	movl	24(%ebp), %eax
	movl	56(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %edx
	movl	-16(%ebp), %eax
	leal	(%edx,%eax), %eax
	addl	$4, %eax
	addl	16(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L766
	movl	$0, 16(%ebp)
L766:
	cmpl	$0, 16(%ebp)
	je	L782
L767:
	movl	16(%ebp), %eax
	incl	%eax
	movl	%eax, 4(%esp)
	movl	$-1, (%esp)
	call	_put4b
	addl	$5, 16(%ebp)
	movb	$5, -21(%ebp)
L768:
	movl	-12(%ebp), %eax
	addl	12(%ebp), %eax
	movb	(%eax), %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	incl	-12(%ebp)
	decb	-21(%ebp)
	cmpb	$0, -21(%ebp)
	jne	L768
L769:
	movl	-20(%ebp), %eax
	movb	(%eax), %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	incl	-20(%ebp)
	decl	-16(%ebp)
	cmpl	$0, -16(%ebp)
	jne	L769
	jmp	L758
L765:
	cmpb	$119, -21(%ebp)
	jbe	L770
	movb	-21(%ebp), %al
	testb	%al, %al
	js	L770
	andb	$7, -21(%ebp)
	movzbl	-21(%ebp), %edx
	movl	24(%ebp), %eax
	addl	$4, %edx
	movl	8(%eax,%edx,4), %eax
	movl	%eax, -16(%ebp)
	movzbl	-21(%ebp), %edx
	movl	24(%ebp), %eax
	addl	$16, %edx
	movl	8(%eax,%edx,4), %eax
	movl	%eax, -20(%ebp)
	movzbl	-21(%ebp), %eax
	movl	24(%ebp), %edx
	movb	12(%edx,%eax), %al
	cmpb	$127, %al
	jne	L771
	movb	-21(%ebp), %al
	movb	%al, %dl
	orl	$120, %edx
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	jmp	L758
L771:
	movzbl	-21(%ebp), %eax
	movl	24(%ebp), %edx
	movb	12(%edx,%eax), %al
	movb	%al, -21(%ebp)
	movzbl	-21(%ebp), %eax
	andl	$31, %eax
	testl	%eax, %eax
	je	L783
L772:
	movb	-21(%ebp), %al
	testb	%al, %al
	js	L773
	movzbl	-21(%ebp), %eax
	movl	%eax, %edx
	andl	$31, %edx
	movl	8(%ebp), %eax
	leal	(%edx,%eax), %eax
	addl	16(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L774
	movl	$0, 16(%ebp)
L774:
	cmpl	$0, 16(%ebp)
	je	L784
L775:
	andb	$31, -21(%ebp)
	movb	-21(%ebp), %al
	movb	%al, %dl
	orl	$48, %edx
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
L776:
	movl	-16(%ebp), %eax
	movb	%al, %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	sarl	$8, -16(%ebp)
	decb	-21(%ebp)
	cmpb	$0, -21(%ebp)
	jne	L776
	jmp	L758
L773:
	movl	8(%ebp), %edx
	movl	-16(%ebp), %eax
	leal	(%edx,%eax), %eax
	addl	16(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L777
	movl	$0, 16(%ebp)
L777:
	cmpl	$0, 16(%ebp)
	je	L785
L778:
	movb	-21(%ebp), %al
	andl	$31, %eax
	leal	55(%eax), %edx
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	-21(%ebp), %dl
	shrb	$5, %dl
	andl	$3, %edx
	movb	%dl, (%eax)
	addl	$2, 16(%ebp)
L779:
	movl	-20(%ebp), %eax
	movb	(%eax), %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	incl	-20(%ebp)
	decl	-16(%ebp)
	cmpl	$0, -16(%ebp)
	jne	L779
	jmp	L758
L770:
	cmpb	$-33, -21(%ebp)
	jbe	L758
	cmpb	$-17, -21(%ebp)
	ja	L758
	movl	16(%ebp), %eax
	movb	-21(%ebp), %dl
	movb	%dl, (%eax)
	incl	16(%ebp)
	jmp	L758
L783:
	nop
L758:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	jl	L780
	jmp	L757
L781:
	nop
	jmp	L757
L782:
	nop
	jmp	L757
L784:
	nop
	jmp	L757
L785:
	nop
L757:
	movl	16(%ebp), %eax
	leave
	ret
.globl _output
	.def	_output;	.scl	2;	.type	32;	.endef
_output:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$100, %esp
	movl	$0, -16(%ebp)
	movl	$0, -40(%ebp)
	movl	$0, -44(%ebp)
	movl	$192, (%esp)
	call	_malloc
	movl	%eax, -76(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, -56(%ebp)
	movl	$1024, (%esp)
	call	_malloc
	movl	%eax, -80(%ebp)
	movl	$32, (%esp)
	call	_malloc
	movl	%eax, -84(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	$0, -32(%ebp)
	movl	$0, -24(%ebp)
	jmp	L787
L788:
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	$0, 16(%eax)
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	$0, 21(%eax)
	incl	-24(%ebp)
L787:
	cmpl	$7, -24(%ebp)
	jle	L788
L797:
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	cmpb	$-14, %al
	jne	L789
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L790
	movl	-48(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	-48(%ebp), %edx
	addl	$3, %edx
	movb	(%edx), %dl
	movb	%dl, 20(%eax)
L790:
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$1, %al
	jne	L789
	movl	-48(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	-48(%ebp), %edx
	addl	$3, %edx
	movb	(%edx), %dl
	movb	%dl, 21(%eax)
L789:
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	cmpb	$-15, %al
	jne	L791
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$1, %al
	jne	L792
	movl	-48(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	%eax, -32(%ebp)
L792:
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$2, %al
	jne	L791
	movl	-48(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movb	%al, -69(%ebp)
L791:
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	cmpb	$-10, %al
	jne	L793
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L794
	movl	-48(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	%eax, -36(%ebp)
	movl	-48(%ebp), %eax
	addl	$4, %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%eax, -52(%ebp)
	movl	-36(%ebp), %eax
	leal	18(%eax), %ecx
	movl	$954437177, %edx
	movl	%ecx, %eax
	imull	%edx
	sarl	$2, %edx
	movl	%ecx, %eax
	sarl	$31, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movb	%al, -70(%ebp)
L794:
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$1, %al
	jne	L795
	incl	-40(%ebp)
L795:
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$2, %al
	jne	L793
	incl	-44(%ebp)
L793:
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	cmpb	$45, %al
	jbe	L796
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	cmpb	$47, %al
	ja	L796
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	16(%eax), %edx
	incl	%edx
	movl	%edx, 16(%eax)
L796:
	movl	-48(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_skipcode
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L797
	cmpb	$1, -69(%ebp)
	jne	L798
	movl	-56(%ebp), %eax
	addl	$140, %eax
	cmpl	20(%ebp), %eax
	jbe	L799
	movl	$0, -56(%ebp)
	jmp	L800
L799:
	movl	$0, -24(%ebp)
	jmp	L801
L802:
	movl	-24(%ebp), %eax
	addl	-56(%ebp), %eax
	movl	-24(%ebp), %edx
	addl	$_header.2035, %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	incl	-24(%ebp)
L801:
	movl	-24(%ebp), %eax
	cmpl	$139, %eax
	jbe	L802
	addl	$140, -56(%ebp)
L798:
	movl	8(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	$0, -32(%ebp)
	movl	$0, -12(%ebp)
L817:
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -65(%ebp)
	cmpb	$48, -65(%ebp)
	jbe	L803
	cmpb	$52, -65(%ebp)
	ja	L803
	incl	-48(%ebp)
	subb	$48, -65(%ebp)
	movl	-56(%ebp), %eax
	addl	$8, %eax
	cmpl	20(%ebp), %eax
	jbe	L804
	movl	$0, -56(%ebp)
	jmp	L800
L804:
	cmpb	$0, -69(%ebp)
	je	L913
L805:
	cmpb	$1, -69(%ebp)
	jne	L807
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	testb	%al, %al
	je	L807
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	cmpb	$2, %al
	ja	L807
	jmp	L806
L913:
	nop
L806:
	movl	-48(%ebp), %eax
	movb	(%eax), %dl
	movl	-56(%ebp), %eax
	movb	%dl, (%eax)
	incl	-56(%ebp)
	incl	-48(%ebp)
	decb	-65(%ebp)
	cmpb	$0, -65(%ebp)
	jne	L806
	jmp	L808
L807:
	cmpb	$1, -69(%ebp)
	jne	L809
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	cmpb	$3, %al
	jne	L809
	movzbl	-65(%ebp), %eax
	addl	%eax, -12(%ebp)
L809:
	movzbl	-65(%ebp), %eax
	addl	%eax, -48(%ebp)
	jmp	L808
L803:
	cmpb	$-15, -65(%ebp)
	jne	L810
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$1, %al
	jne	L810
	cmpb	$1, -69(%ebp)
	jne	L811
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	testb	%al, %al
	je	L811
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	cmpb	$2, %al
	ja	L811
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	subl	$4, %eax
	movl	%eax, %edx
	addl	16(%ebp), %edx
	movl	-56(%ebp), %ebx
	movl	-32(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	4(%eax), %eax
	movl	%ebx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
L811:
	movl	-48(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	-48(%ebp), %edx
	movl	%edx, (%eax)
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	%edx, 4(%eax)
	cmpb	$0, -69(%ebp)
	jne	L812
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	20(%eax), %al
	testb	%al, %al
	je	L812
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	20(%eax), %al
	movzbl	%al, %eax
	movl	$1, %edx
	movl	%edx, %ebx
	movb	%al, %cl
	sall	%cl, %ebx
	movl	%ebx, %eax
	movl	%eax, -24(%ebp)
	jmp	L813
L815:
	movl	-56(%ebp), %eax
	cmpl	20(%ebp), %eax
	jb	L814
	movl	$0, -56(%ebp)
	jmp	L800
L814:
	movl	-56(%ebp), %eax
	movb	$0, (%eax)
	incl	-56(%ebp)
L813:
	movl	-24(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-56(%ebp), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	jne	L815
L812:
	cmpb	$1, -69(%ebp)
	jne	L810
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	testb	%al, %al
	je	L810
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	cmpb	$3, %al
	ja	L810
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	cmpb	$3, %al
	je	L816
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	movl	%eax, %edx
	addl	16(%ebp), %edx
	movl	-56(%ebp), %ecx
	movl	16(%ebp), %eax
	movl	%ecx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
L816:
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	$18, %eax
	movl	%eax, %edx
	addl	16(%ebp), %edx
	movl	-32(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	20(%eax), %al
	sall	$4, %eax
	movb	%al, (%edx)
L810:
	movl	-48(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_skipcode
	movl	%eax, -48(%ebp)
L808:
	movl	-48(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L817
	cmpb	$1, -69(%ebp)
	jne	L818
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	testb	%al, %al
	je	L819
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	cmpb	$2, %al
	ja	L819
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	subl	$4, %eax
	movl	%eax, %edx
	addl	16(%ebp), %edx
	movl	-56(%ebp), %ebx
	movl	-32(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	4(%eax), %eax
	movl	%ebx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
L819:
	movl	16(%ebp), %eax
	leal	116(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	$0, -24(%ebp)
	jmp	L820
L822:
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	testb	%al, %al
	je	L821
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	cmpb	$2, %al
	ja	L821
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	-56(%ebp), %edx
	movl	%edx, 8(%eax)
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	$4, %eax
	movl	%eax, %edx
	addl	16(%ebp), %edx
	movl	-56(%ebp), %ecx
	movl	16(%ebp), %eax
	movl	%ecx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	$12, %eax
	movl	%eax, %edx
	addl	16(%ebp), %edx
	movl	-24(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	16(%eax), %eax
	movb	%al, (%edx)
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	$13, %eax
	movl	%eax, %edx
	addl	16(%ebp), %edx
	movl	-24(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	16(%eax), %eax
	sarl	$8, %eax
	movb	%al, (%edx)
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	16(%eax), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%eax, -56(%ebp)
L821:
	incl	-24(%ebp)
L820:
	cmpl	$7, -24(%ebp)
	jle	L822
	movl	-56(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L823
	movl	$0, -56(%ebp)
	jmp	L800
L823:
	movl	16(%ebp), %eax
	leal	8(%eax), %edx
	movl	-56(%ebp), %ecx
	movl	16(%ebp), %eax
	movl	%ecx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	16(%ebp), %eax
	leal	12(%eax), %edx
	movzbl	-70(%ebp), %eax
	addl	$7, %eax
	addl	-44(%ebp), %eax
	addl	-40(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-24(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	sall	%eax
	addl	-56(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L824
	movl	$0, -56(%ebp)
	jmp	L800
L824:
	movl	$0, -24(%ebp)
	jmp	L825
L826:
	movl	-24(%ebp), %eax
	addl	-56(%ebp), %eax
	movl	-24(%ebp), %edx
	addl	$_common_symbols0.2049, %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	incl	-24(%ebp)
L825:
	movl	-24(%ebp), %eax
	cmpl	$16, %eax
	jbe	L826
	movl	-56(%ebp), %eax
	leal	17(%eax), %edx
	movb	-70(%ebp), %al
	movb	%al, (%edx)
	movl	$0, -24(%ebp)
	jmp	L827
L828:
	movzbl	-70(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	sall	%eax
	addl	-24(%ebp), %eax
	addl	-56(%ebp), %eax
	movb	$0, (%eax)
	incl	-24(%ebp)
L827:
	cmpl	$17, -24(%ebp)
	jle	L828
	movl	$0, -24(%ebp)
	jmp	L829
L830:
	movl	-24(%ebp), %eax
	addl	$18, %eax
	addl	-56(%ebp), %eax
	movl	-24(%ebp), %edx
	addl	-52(%ebp), %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	incl	-24(%ebp)
L829:
	movl	-24(%ebp), %eax
	cmpl	-36(%ebp), %eax
	jl	L830
	movzbl	-70(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%eax, -56(%ebp)
	movl	$0, -24(%ebp)
	jmp	L831
L832:
	movl	-24(%ebp), %eax
	addl	-56(%ebp), %eax
	movl	-24(%ebp), %edx
	addl	$_common_symbols1.2050, %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	incl	-24(%ebp)
L831:
	movl	-24(%ebp), %eax
	cmpl	$107, %eax
	jbe	L832
	movl	-56(%ebp), %eax
	leal	18(%eax), %ebx
	movl	16(%ebp), %eax
	addl	$36, %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-56(%ebp), %eax
	leal	22(%eax), %ebx
	movl	16(%ebp), %eax
	addl	$52, %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-56(%ebp), %eax
	leal	54(%eax), %ebx
	movl	16(%ebp), %eax
	addl	$76, %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-56(%ebp), %eax
	leal	58(%eax), %ebx
	movl	16(%ebp), %eax
	addl	$92, %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-56(%ebp), %eax
	leal	90(%eax), %ebx
	movl	16(%ebp), %eax
	addl	$116, %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-56(%ebp), %eax
	addl	$108, %eax
	movl	%eax, -52(%ebp)
	movl	-40(%ebp), %eax
	movl	-44(%ebp), %edx
	addl	%eax, %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	sall	%eax
	addl	-52(%ebp), %eax
	movl	%eax, -56(%ebp)
	movl	-56(%ebp), %eax
	movl	%eax, -88(%ebp)
	addl	$4, -56(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	$0, -32(%ebp)
	movl	$0, -28(%ebp)
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	sall	%eax
	movl	%eax, -40(%ebp)
L849:
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -65(%ebp)
	cmpb	$48, -65(%ebp)
	jbe	L833
	cmpb	$52, -65(%ebp)
	ja	L833
	incl	-48(%ebp)
	subb	$48, -65(%ebp)
	movzbl	-65(%ebp), %eax
	addl	%eax, -48(%ebp)
	movzbl	-65(%ebp), %eax
	addl	%eax, -28(%ebp)
	jmp	L834
L833:
	cmpb	$-15, -65(%ebp)
	jne	L835
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$1, %al
	jne	L835
	movl	-48(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	%eax, -32(%ebp)
	movl	$0, -28(%ebp)
L835:
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	cmpb	$-10, %al
	jne	L836
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	testb	%al, %al
	je	L836
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$2, %al
	ja	L836
	movl	-48(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	-48(%ebp), %edx
	addl	$3, %edx
	movb	(%edx), %dl
	movzbl	%dl, %edx
	sall	$8, %edx
	orl	%edx, %eax
	movl	%eax, -12(%ebp)
	movl	-48(%ebp), %eax
	addl	$4, %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%eax, -60(%ebp)
	movl	-48(%ebp), %eax
	addl	$10, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	-48(%ebp), %edx
	addl	$11, %edx
	movb	(%edx), %dl
	movzbl	%dl, %edx
	sall	$8, %edx
	orl	%eax, %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	sall	%eax
	subl	$288, %eax
	addl	-52(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$1, %al
	jne	L837
	movl	-40(%ebp), %eax
	addl	-52(%ebp), %eax
	movl	%eax, -64(%ebp)
	addl	$18, -40(%ebp)
L837:
	movl	$0, -24(%ebp)
	jmp	L838
L839:
	movl	-24(%ebp), %eax
	addl	-64(%ebp), %eax
	movb	$0, (%eax)
	incl	-24(%ebp)
L838:
	cmpl	$17, -24(%ebp)
	jle	L839
	movl	-64(%ebp), %eax
	addl	$16, %eax
	movb	$2, (%eax)
	cmpl	$8, -12(%ebp)
	jg	L840
	movl	$0, -24(%ebp)
	jmp	L841
L842:
	movl	-24(%ebp), %eax
	addl	-64(%ebp), %eax
	movl	-24(%ebp), %edx
	addl	-60(%ebp), %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	incl	-24(%ebp)
L841:
	movl	-24(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jl	L842
	jmp	L843
L840:
	movl	-64(%ebp), %eax
	leal	4(%eax), %edx
	movl	-56(%ebp), %ecx
	movl	-88(%ebp), %eax
	movl	%ecx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-12(%ebp), %eax
	incl	%eax
	addl	-56(%ebp), %eax
	cmpl	20(%ebp), %eax
	jbe	L844
	movl	$0, -56(%ebp)
	jmp	L800
L844:
	movl	-60(%ebp), %eax
	movb	(%eax), %dl
	movl	-56(%ebp), %eax
	movb	%dl, (%eax)
	incl	-56(%ebp)
	incl	-60(%ebp)
	decl	-12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	L844
	movl	-56(%ebp), %eax
	movb	$0, (%eax)
	incl	-56(%ebp)
L843:
	movl	-48(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$1, %al
	jne	L836
	movl	-64(%ebp), %eax
	leal	8(%eax), %edx
	movl	-48(%ebp), %eax
	addl	$12, %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	movl	-64(%ebp), %eax
	leal	9(%eax), %edx
	movl	-48(%ebp), %eax
	addl	$13, %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	movl	-64(%ebp), %eax
	leal	10(%eax), %edx
	movl	-48(%ebp), %eax
	addl	$14, %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	movl	-64(%ebp), %eax
	leal	11(%eax), %edx
	movl	-48(%ebp), %eax
	addl	$15, %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	movl	-64(%ebp), %eax
	leal	12(%eax), %edx
	movl	-48(%ebp), %eax
	addl	$10, %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	movl	-64(%ebp), %eax
	leal	13(%eax), %edx
	movl	-48(%ebp), %eax
	addl	$11, %eax
	movb	(%eax), %al
	movb	%al, (%edx)
L836:
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	cmpb	$45, %al
	jbe	L845
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	cmpb	$47, %al
	ja	L845
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	testb	%al, %al
	je	L845
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	cmpb	$2, %al
	ja	L845
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	8(%eax), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-48(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	-48(%ebp), %edx
	addl	$3, %edx
	movb	(%edx), %dl
	movzbl	%dl, %edx
	sall	$8, %edx
	orl	%edx, %eax
	movl	%eax, -24(%ebp)
	cmpl	$15, -24(%ebp)
	jle	L846
	subl	$9, -24(%ebp)
	jmp	L847
L846:
	movl	-24(%ebp), %eax
	sall	%eax
	decl	%eax
	movl	%eax, -24(%ebp)
L847:
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	8(%eax), %eax
	leal	4(%eax), %edx
	movzbl	-70(%ebp), %eax
	addl	-24(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	8(%eax), %eax
	addl	$8, %eax
	movb	$6, (%eax)
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	8(%eax), %eax
	addl	$9, %eax
	movb	$0, (%eax)
	movl	-48(%ebp), %eax
	movb	(%eax), %al
	cmpb	$47, %al
	jne	L848
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	8(%eax), %eax
	addl	$8, %eax
	movb	$20, (%eax)
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	-28(%ebp), %edx
	addl	%edx, %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	movl	%eax, %ebx
	addl	16(%ebp), %ebx
	movl	-24(%ebp), %eax
	addl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	-28(%ebp), %edx
	addl	%edx, %eax
	addl	$4, %eax
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
L848:
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	movl	%eax, %edx
	addl	-76(%ebp), %edx
	movl	-32(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	8(%eax), %eax
	addl	$10, %eax
	movl	%eax, 8(%edx)
L845:
	movl	-48(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_skipcode
	movl	%eax, -48(%ebp)
L834:
	movl	-48(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L849
	movl	-56(%ebp), %edx
	movl	-88(%ebp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	-88(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put4b
L818:
	movb	$0, -66(%ebp)
	movl	$0, -32(%ebp)
	movl	$0, -28(%ebp)
	movl	-84(%ebp), %eax
	movl	%eax, -64(%ebp)
	jmp	L911
L914:
	nop
	jmp	L911
L915:
	nop
L911:
	movl	-80(%ebp), %eax
	movl	%eax, -60(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -65(%ebp)
	cmpb	$-15, -65(%ebp)
	jne	L850
	movl	8(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L850
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	8(%ebp), %edx
	movl	%edx, (%eax)
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 8(%ebp)
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, -28(%ebp)
L850:
	cmpb	$-9, -65(%ebp)
	jne	L851
	cmpb	$1, -66(%ebp)
	jne	L852
	movl	$-9, -12(%ebp)
	movb	$2, -66(%ebp)
L852:
	cmpb	$2, -66(%ebp)
	jne	L853
	movl	$32, %eax
	subl	-12(%ebp), %eax
	addl	-20(%ebp), %eax
	addl	24(%ebp), %eax
	cmpl	28(%ebp), %eax
	jb	L854
	movl	24(%ebp), %eax
	movb	$0, (%eax)
	movl	$0, 24(%ebp)
L854:
	cmpl	$0, 24(%ebp)
	je	L853
L855:
	movl	24(%ebp), %eax
	movb	$32, (%eax)
	incl	24(%ebp)
	incl	-12(%ebp)
	cmpl	$31, -12(%ebp)
	jle	L855
	jmp	L856
L857:
	movl	-48(%ebp), %eax
	movb	(%eax), %dl
	movl	24(%ebp), %eax
	movb	%dl, (%eax)
	incl	24(%ebp)
	incl	-48(%ebp)
L856:
	cmpl	$0, -20(%ebp)
	setne	%al
	decl	-20(%ebp)
	testb	%al, %al
	jne	L857
L853:
	cmpb	$3, -66(%ebp)
	jne	L858
	movl	-60(%ebp), %eax
	movb	$10, (%eax)
	incl	-60(%ebp)
L858:
	movl	-64(%ebp), %edx
	movl	-84(%ebp), %eax
	movl	%edx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	L859
	movl	_nask_errors, %eax
	addl	-12(%ebp), %eax
	movl	%eax, _nask_errors
	movl	$0, -24(%ebp)
	jmp	L860
L862:
	movl	-24(%ebp), %eax
	addl	-84(%ebp), %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	subl	$225, %eax
	movl	_errmsg.2083(,%eax,4), %eax
	movl	%eax, -64(%ebp)
	nop
L861:
	movl	-64(%ebp), %eax
	movb	(%eax), %dl
	movl	-60(%ebp), %eax
	movb	%dl, (%eax)
	movl	-60(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	setne	%al
	incl	-60(%ebp)
	incl	-64(%ebp)
	testb	%al, %al
	jne	L861
	incl	-24(%ebp)
L860:
	movl	-24(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jl	L862
	movl	-84(%ebp), %eax
	movl	%eax, -64(%ebp)
L859:
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%eax, -20(%ebp)
	movl	8(%ebp), %eax
	addl	$5, %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%eax, -48(%ebp)
	cmpl	$0, -20(%ebp)
	je	L863
	incl	-16(%ebp)
	movl	-16(%ebp), %eax
	movl	-60(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	$6, 4(%esp)
	movl	%eax, (%esp)
	call	_setdec
	movl	-60(%ebp), %eax
	addl	$6, %eax
	movb	$32, (%eax)
	addl	$7, -60(%ebp)
L863:
	movl	$0, -12(%ebp)
	addl	$9, 8(%ebp)
	movb	$1, -66(%ebp)
	movb	$0, -67(%ebp)
	jmp	L864
L851:
	cmpb	$90, -65(%ebp)
	jne	L865
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%eax, -28(%ebp)
	addl	$5, 8(%ebp)
	jmp	L864
L865:
	cmpb	$104, -65(%ebp)
	jne	L866
	addl	$2, 8(%ebp)
	jmp	L864
L866:
	cmpb	$-32, -65(%ebp)
	jne	L867
	movb	$2, -66(%ebp)
	movl	-28(%ebp), %eax
	movl	-60(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	$8, 4(%esp)
	movl	%eax, (%esp)
	call	_sethex0
	movl	-60(%ebp), %eax
	addl	$8, %eax
	movb	$32, (%eax)
	addl	$9, -60(%ebp)
	incl	8(%ebp)
	movb	$1, -67(%ebp)
	jmp	L864
L867:
	cmpb	$48, -65(%ebp)
	jbe	L868
	cmpb	$52, -65(%ebp)
	ja	L868
	cmpb	$1, -66(%ebp)
	jne	L869
	movl	$0, -24(%ebp)
	jmp	L870
L871:
	movl	-60(%ebp), %eax
	movb	$32, (%eax)
	incl	-60(%ebp)
	incl	-24(%ebp)
L870:
	cmpl	$8, -24(%ebp)
	jle	L871
	movb	$2, -66(%ebp)
L869:
	movl	-12(%ebp), %eax
	leal	1(%eax), %edx
	movzbl	-65(%ebp), %eax
	subl	$48, %eax
	sall	%eax
	leal	(%edx,%eax), %eax
	cmpl	$32, %eax
	jle	L872
	cmpb	$2, -66(%ebp)
	jne	L873
	movl	$32, %eax
	subl	-12(%ebp), %eax
	addl	-20(%ebp), %eax
	addl	24(%ebp), %eax
	cmpl	28(%ebp), %eax
	jb	L874
	movl	24(%ebp), %eax
	movb	$0, (%eax)
	movl	$0, 24(%ebp)
L874:
	cmpl	$0, 24(%ebp)
	je	L875
L876:
	movl	24(%ebp), %eax
	movb	$32, (%eax)
	incl	24(%ebp)
	incl	-12(%ebp)
	cmpl	$31, -12(%ebp)
	jle	L876
	jmp	L877
L878:
	movl	-48(%ebp), %eax
	movb	(%eax), %dl
	movl	24(%ebp), %eax
	movb	%dl, (%eax)
	incl	24(%ebp)
	incl	-48(%ebp)
L877:
	cmpl	$0, -20(%ebp)
	setne	%al
	decl	-20(%ebp)
	testb	%al, %al
	jne	L878
	jmp	L875
L873:
	movl	-60(%ebp), %eax
	movb	$10, (%eax)
	incl	-60(%ebp)
L875:
	movl	$0, -24(%ebp)
	jmp	L879
L880:
	movl	-24(%ebp), %eax
	addl	-60(%ebp), %eax
	movb	$32, (%eax)
	incl	-24(%ebp)
L879:
	cmpl	$15, -24(%ebp)
	jle	L880
	cmpb	$0, -67(%ebp)
	je	L881
	movl	-60(%ebp), %eax
	leal	7(%eax), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 8(%esp)
	movl	$8, 4(%esp)
	movl	%eax, (%esp)
	call	_sethex0
L881:
	addl	$16, -60(%ebp)
	movb	$3, -66(%ebp)
	movl	$0, -12(%ebp)
L872:
	incl	8(%ebp)
	movzbl	-65(%ebp), %eax
	subl	$49, %eax
	movl	%eax, -24(%ebp)
	jmp	L882
L883:
	movl	-24(%ebp), %eax
	addl	8(%ebp), %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	-60(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	$2, 4(%esp)
	movl	%eax, (%esp)
	call	_sethex0
	addl	$2, -60(%ebp)
	addl	$2, -12(%ebp)
	incl	-28(%ebp)
	decl	-24(%ebp)
L882:
	cmpl	$0, -24(%ebp)
	jns	L883
	movzbl	-65(%ebp), %eax
	subl	$48, %eax
	addl	%eax, 8(%ebp)
	movl	-60(%ebp), %eax
	movb	$32, (%eax)
	incl	-60(%ebp)
	incl	-12(%ebp)
	jmp	L864
L868:
	cmpb	$45, -65(%ebp)
	jbe	L884
	cmpb	$47, -65(%ebp)
	ja	L884
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	testb	%al, %al
	je	L884
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	cmpb	$2, %al
	ja	L884
	cmpb	$1, -66(%ebp)
	jne	L885
	movl	$0, -24(%ebp)
	jmp	L886
L887:
	movl	-60(%ebp), %eax
	movb	$32, (%eax)
	incl	-60(%ebp)
	incl	-24(%ebp)
L886:
	cmpl	$8, -24(%ebp)
	jle	L887
	movb	$2, -66(%ebp)
L885:
	movl	-12(%ebp), %eax
	addl	$11, %eax
	cmpl	$32, %eax
	jle	L888
	cmpb	$2, -66(%ebp)
	jne	L889
	movl	$32, %eax
	subl	-12(%ebp), %eax
	addl	-20(%ebp), %eax
	addl	24(%ebp), %eax
	cmpl	28(%ebp), %eax
	jb	L890
	movl	24(%ebp), %eax
	movb	$0, (%eax)
	movl	$0, 24(%ebp)
L890:
	cmpl	$0, 24(%ebp)
	je	L891
L892:
	movl	24(%ebp), %eax
	movb	$32, (%eax)
	incl	24(%ebp)
	incl	-12(%ebp)
	cmpl	$31, -12(%ebp)
	jle	L892
	jmp	L893
L894:
	movl	-48(%ebp), %eax
	movb	(%eax), %dl
	movl	24(%ebp), %eax
	movb	%dl, (%eax)
	incl	24(%ebp)
	incl	-48(%ebp)
L893:
	cmpl	$0, -20(%ebp)
	setne	%al
	decl	-20(%ebp)
	testb	%al, %al
	jne	L894
	jmp	L891
L889:
	movl	-60(%ebp), %eax
	movb	$10, (%eax)
	incl	-60(%ebp)
L891:
	movl	$0, -24(%ebp)
	jmp	L895
L896:
	movl	-24(%ebp), %eax
	addl	-60(%ebp), %eax
	movb	$32, (%eax)
	incl	-24(%ebp)
L895:
	cmpl	$15, -24(%ebp)
	jle	L896
	cmpb	$0, -67(%ebp)
	je	L897
	movl	-60(%ebp), %eax
	leal	7(%eax), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 8(%esp)
	movl	$8, 4(%esp)
	movl	%eax, (%esp)
	call	_sethex0
L897:
	addl	$16, -60(%ebp)
	movb	$3, -66(%ebp)
	movl	$0, -12(%ebp)
L888:
	addl	$9, 8(%ebp)
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	-76(%ebp), %eax
	movb	21(%eax), %al
	movzbl	%al, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	-28(%ebp), %edx
	addl	%edx, %eax
	movl	%eax, -24(%ebp)
	movl	-60(%ebp), %eax
	movb	$91, (%eax)
	movl	-60(%ebp), %eax
	leal	1(%eax), %ebx
	movl	-24(%ebp), %eax
	addl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%ebx, 8(%esp)
	movl	$8, 4(%esp)
	movl	%eax, (%esp)
	call	_sethex0
	movl	-60(%ebp), %eax
	addl	$9, %eax
	movb	$93, (%eax)
	movl	-60(%ebp), %eax
	addl	$10, %eax
	movb	$32, (%eax)
	addl	$11, -60(%ebp)
	addl	$11, -12(%ebp)
	addl	$4, -28(%ebp)
	jmp	L864
L884:
	cmpb	$12, -65(%ebp)
	jne	L898
	movl	-60(%ebp), %eax
	movb	$32, (%eax)
	movl	-60(%ebp), %eax
	incl	%eax
	movb	$61, (%eax)
	movl	-60(%ebp), %eax
	addl	$2, %eax
	movb	$32, (%eax)
	movl	-60(%ebp), %eax
	leal	3(%eax), %ebx
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%ebx, 8(%esp)
	movl	$8, 4(%esp)
	movl	%eax, (%esp)
	call	_sethex0
	movl	-60(%ebp), %eax
	addl	$11, %eax
	movb	$32, (%eax)
	movl	$3, -12(%ebp)
	addl	$12, -60(%ebp)
	addl	$5, 8(%ebp)
	movb	$2, -66(%ebp)
	jmp	L864
L898:
	cmpb	$13, -65(%ebp)
	jne	L899
	movl	-60(%ebp), %eax
	movb	$32, (%eax)
	movl	-60(%ebp), %eax
	incl	%eax
	movb	$61, (%eax)
	movl	-60(%ebp), %eax
	addl	$2, %eax
	movb	$32, (%eax)
	movl	-60(%ebp), %eax
	addl	$3, %eax
	movb	$91, (%eax)
	movl	-60(%ebp), %eax
	leal	4(%eax), %ebx
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%ebx, 8(%esp)
	movl	$8, 4(%esp)
	movl	%eax, (%esp)
	call	_sethex0
	movl	-60(%ebp), %eax
	addl	$12, %eax
	movb	$93, (%eax)
	movl	-60(%ebp), %eax
	addl	$13, %eax
	movb	$32, (%eax)
	movl	$5, -12(%ebp)
	addl	$14, -60(%ebp)
	addl	$5, 8(%ebp)
	movb	$2, -66(%ebp)
	jmp	L864
L899:
	cmpb	$-32, -65(%ebp)
	jbe	L900
	cmpb	$-20, -65(%ebp)
	ja	L900
	movl	-64(%ebp), %eax
	movb	-65(%ebp), %dl
	movb	%dl, (%eax)
	incl	-64(%ebp)
	incl	8(%ebp)
	jmp	L864
L900:
	cmpb	$48, -65(%ebp)
	jne	L901
	incl	8(%ebp)
	jmp	L864
L901:
	cmpb	$-17, -65(%ebp)
	jbe	L902
	cmpb	$-9, -65(%ebp)
	ja	L902
	movzbl	-65(%ebp), %eax
	subl	$238, %eax
	addl	%eax, 8(%ebp)
	jmp	L864
L902:
	cmpb	$44, -65(%ebp)
	jne	L903
	addl	$4, 8(%ebp)
	jmp	L864
L903:
	incl	8(%ebp)
L864:
	movl	-60(%ebp), %edx
	movl	-80(%ebp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -24(%ebp)
	movl	-24(%ebp), %eax
	addl	24(%ebp), %eax
	cmpl	28(%ebp), %eax
	jb	L904
	movl	24(%ebp), %eax
	movb	$0, (%eax)
	movl	$0, 24(%ebp)
L904:
	cmpl	$0, 24(%ebp)
	je	L905
	movl	-80(%ebp), %eax
	movl	%eax, -60(%ebp)
	jmp	L906
L907:
	movl	-60(%ebp), %eax
	movb	(%eax), %dl
	movl	24(%ebp), %eax
	movb	%dl, (%eax)
	incl	24(%ebp)
	incl	-60(%ebp)
L906:
	cmpl	$0, -24(%ebp)
	setne	%al
	decl	-24(%ebp)
	testb	%al, %al
	jne	L907
L905:
	cmpb	$-9, -65(%ebp)
	jne	L914
	movb	$0, -68(%ebp)
	movl	$-8, -24(%ebp)
	jmp	L909
L910:
	movl	-24(%ebp), %eax
	addl	8(%ebp), %eax
	movb	(%eax), %al
	orb	%al, -68(%ebp)
	incl	-24(%ebp)
L909:
	cmpl	$0, -24(%ebp)
	js	L910
	cmpb	$0, -68(%ebp)
	jne	L915
	nop
L800:
	movl	28(%ebp), %eax
	incl	%eax
	movb	$1, (%eax)
	cmpl	$0, 24(%ebp)
	je	L912
	movl	24(%ebp), %eax
	movb	$0, (%eax)
	movl	28(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
L912:
	movl	-80(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-84(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-76(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-56(%ebp), %eax
	addl	$100, %esp
	popl	%ebx
	leave
	ret
.globl _putprefix
	.def	_putprefix;	.scl	2;	.type	32;	.endef
_putprefix:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$64, %esp
	cmpl	$0, 24(%ebp)
	jle	L917
	movl	20(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	L918
	andl	$-257, 16(%ebp)
L918:
	movl	20(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	L917
	andl	$-129, 16(%ebp)
L917:
	movl	16(%ebp), %eax
	andl	$196608, %eax
	testl	%eax, %eax
	jne	L919
	movl	16(%ebp), %eax
	andl	$50331648, %eax
	sarl	$8, %eax
	orl	%eax, 16(%ebp)
L919:
	movl	16(%ebp), %eax
	andl	$3145728, %eax
	testl	%eax, %eax
	jne	L920
	movl	16(%ebp), %eax
	andl	$805306368, %eax
	sarl	$8, %eax
	orl	%eax, 16(%ebp)
L920:
	movl	20(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L921
	andl	$-1114113, 16(%ebp)
L921:
	movl	20(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	L922
	andl	$-2228225, 16(%ebp)
L922:
	movl	16(%ebp), %eax
	andl	$196608, %eax
	testl	%eax, %eax
	je	L923
	xorl	$8, 16(%ebp)
L923:
	movl	16(%ebp), %eax
	andl	$3145728, %eax
	testl	%eax, %eax
	je	L924
	xorl	$16, 16(%ebp)
L924:
	movb	$-32, -65(%ebp)
	leal	-65(%ebp), %eax
	incl	%eax
	movl	%eax, -8(%ebp)
	movl	$0, -12(%ebp)
	jmp	L925
L927:
	movl	-12(%ebp), %eax
	movl	16(%ebp), %edx
	movl	%edx, %ebx
	movb	%al, %cl
	sarl	%cl, %ebx
	movl	%ebx, %eax
	andl	$1, %eax
	testb	%al, %al
	je	L926
	movl	-8(%ebp), %eax
	movb	$49, (%eax)
	movl	-8(%ebp), %eax
	leal	1(%eax), %edx
	movl	-12(%ebp), %eax
	addl	$_code.2132, %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	addl	$2, -8(%ebp)
L926:
	incl	-12(%ebp)
L925:
	cmpl	$10, -12(%ebp)
	jle	L927
	movl	-8(%ebp), %edx
	leal	-65(%ebp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jbe	L928
	movl	$0, 8(%ebp)
L928:
	cmpl	$0, 8(%ebp)
	je	L929
	movl	$0, -16(%ebp)
	jmp	L930
L931:
	movl	-16(%ebp), %eax
	addl	8(%ebp), %eax
	leal	-65(%ebp), %edx
	addl	-16(%ebp), %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	incl	-16(%ebp)
L930:
	movl	-16(%ebp), %eax
	cmpl	-12(%ebp), %eax
	jl	L931
	movl	-12(%ebp), %eax
	addl	%eax, 8(%ebp)
L929:
	movl	8(%ebp), %eax
	addl	$64, %esp
	popl	%ebx
	leave
	ret
	.data
	.align 32
_instruction:
	.ascii "AAA\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	55
	.space 5
	.ascii "AAD\0"
	.space 4
	.long	255
	.byte	8
	.byte	-43
	.byte	10
	.space 5
	.ascii "AAS\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	63
	.space 5
	.ascii "AAM\0"
	.space 4
	.long	255
	.byte	8
	.byte	-44
	.byte	10
	.space 5
	.ascii "ADC\0"
	.space 4
	.long	255
	.byte	12
	.byte	-121
	.byte	17
	.byte	16
	.space 4
	.ascii "ADD\0"
	.space 4
	.long	255
	.byte	12
	.byte	-121
	.byte	17
	.byte	0
	.space 4
	.ascii "AND\0"
	.space 4
	.long	255
	.byte	12
	.byte	-121
	.byte	17
	.byte	32
	.space 4
	.ascii "ALIGN\0"
	.space 2
	.long	255
	.byte	23
	.byte	-112
	.space 6
	.ascii "ALIGNB\0"
	.space 1
	.long	255
	.byte	23
	.byte	0
	.space 6
	.ascii "ARPL\0"
	.space 3
	.long	168
	.byte	3
	.byte	-94
	.byte	33
	.byte	99
	.space 4
	.ascii "BOUND\0"
	.space 2
	.long	254
	.byte	4
	.byte	-122
	.byte	1
	.byte	98
	.space 4
	.ascii "BSF\0"
	.space 4
	.long	240
	.byte	4
	.byte	-122
	.byte	2
	.byte	15
	.byte	-68
	.space 3
	.ascii "BSR\0"
	.space 4
	.long	240
	.byte	4
	.byte	-122
	.byte	2
	.byte	15
	.byte	-67
	.space 3
	.ascii "BSWAP\0"
	.space 2
	.long	192
	.byte	5
	.byte	20
	.byte	-95
	.byte	15
	.space 4
	.ascii "BT\0"
	.space 5
	.long	240
	.byte	21
	.byte	32
	.space 6
	.ascii "BTC\0"
	.space 4
	.long	240
	.byte	21
	.byte	56
	.space 6
	.ascii "BTR\0"
	.space 4
	.long	240
	.byte	21
	.byte	48
	.space 6
	.ascii "BTS\0"
	.space 4
	.long	240
	.byte	21
	.byte	40
	.space 6
	.ascii "CALL\0"
	.space 3
	.long	255
	.byte	64
	.byte	16
	.byte	-24
	.byte	-102
	.byte	0
	.space 3
	.ascii "CBW\0"
	.space 4
	.long	255
	.byte	2
	.byte	17
	.byte	-104
	.space 5
	.ascii "CDQ\0"
	.space 4
	.long	240
	.byte	2
	.byte	33
	.byte	-103
	.space 5
	.ascii "CLC\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	-8
	.space 5
	.ascii "CLD\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	-4
	.space 5
	.ascii "CLI\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	-6
	.space 5
	.ascii "CLTS\0"
	.space 3
	.long	168
	.byte	2
	.byte	2
	.byte	15
	.byte	6
	.space 4
	.ascii "CMC\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	-11
	.space 5
	.ascii "CMP\0"
	.space 4
	.long	255
	.byte	12
	.byte	-121
	.byte	17
	.byte	56
	.space 4
	.ascii "CMPSB\0"
	.space 2
	.long	255
	.byte	2
	.byte	65
	.byte	-90
	.space 5
	.ascii "CMPSD\0"
	.space 2
	.long	240
	.byte	2
	.byte	97
	.byte	-89
	.space 5
	.ascii "CMPSW\0"
	.space 2
	.long	255
	.byte	2
	.byte	81
	.byte	-89
	.space 5
	.ascii "CMPXCHG\0"
	.long	192
	.byte	3
	.byte	-121
	.byte	18
	.byte	15
	.byte	-80
	.space 3
	.ascii "CS\0"
	.space 5
	.long	255
	.byte	1
	.byte	6
	.space 6
	.ascii "CWD\0"
	.space 4
	.long	255
	.byte	2
	.byte	17
	.byte	-103
	.space 5
	.ascii "CWDE\0"
	.space 3
	.long	240
	.byte	2
	.byte	33
	.byte	-104
	.space 5
	.ascii "DAA\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	39
	.space 5
	.ascii "DAS\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	47
	.space 5
	.ascii "DB\0"
	.space 5
	.long	255
	.byte	72
	.byte	1
	.byte	-98
	.space 5
	.ascii "DD\0"
	.space 5
	.long	255
	.byte	72
	.byte	4
	.byte	-99
	.space 5
	.ascii "DEC\0"
	.space 4
	.long	255
	.byte	10
	.byte	1
	.byte	72
	.byte	-2
	.space 4
	.ascii "DIV\0"
	.space 4
	.long	255
	.byte	5
	.byte	103
	.byte	17
	.byte	-10
	.space 4
	.ascii "DQ\0"
	.space 5
	.long	255
	.byte	72
	.byte	8
	.space 6
	.ascii "DS\0"
	.space 5
	.long	255
	.byte	1
	.byte	8
	.space 6
	.ascii "DT\0"
	.space 5
	.long	255
	.byte	72
	.byte	10
	.space 6
	.ascii "DW\0"
	.space 5
	.long	255
	.byte	72
	.byte	2
	.byte	-101
	.space 5
	.ascii "END\0"
	.space 4
	.long	255
	.byte	73
	.space 7
	.ascii "ENTER\0"
	.space 2
	.long	254
	.byte	22
	.space 7
	.ascii "EQU\0"
	.space 4
	.long	255
	.byte	63
	.space 7
	.ascii "ES\0"
	.space 5
	.long	255
	.byte	1
	.byte	5
	.space 6
	.ascii "EXTERN\0"
	.space 1
	.long	255
	.byte	68
	.byte	2
	.space 6
	.ascii "F2XM1\0"
	.space 2
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-16
	.space 4
	.ascii "FABS\0"
	.space 3
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-31
	.space 4
	.ascii "FADD\0"
	.space 3
	.long	255
	.byte	48
	.byte	0
	.byte	0
	.byte	-128
	.byte	-124
	.byte	0
	.byte	-128
	.byte	-124
	.ascii "FADDP\0"
	.space 2
	.long	255
	.byte	49
	.byte	6
	.space 6
	.ascii "FBLD\0"
	.space 3
	.long	255
	.byte	48
	.byte	7
	.byte	0
	.byte	0
	.byte	0
	.byte	-89
	.space 2
	.ascii "FBSTP\0"
	.space 2
	.long	255
	.byte	48
	.byte	7
	.byte	0
	.byte	0
	.byte	0
	.byte	-73
	.space 2
	.ascii "FCHS\0"
	.space 3
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-32
	.space 4
	.ascii "FCLEX\0"
	.space 2
	.long	255
	.byte	2
	.byte	3
	.byte	-101
	.byte	-37
	.byte	-30
	.space 3
	.ascii "FCOM\0"
	.space 3
	.long	255
	.byte	48
	.byte	0
	.byte	0
	.byte	-112
	.byte	-108
	.byte	0
	.byte	-112
	.byte	0
	.ascii "FCOMP\0"
	.space 2
	.long	255
	.byte	48
	.byte	0
	.byte	0
	.byte	-104
	.byte	-100
	.byte	0
	.byte	-104
	.byte	0
	.ascii "FCOMPP\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-34
	.byte	-39
	.space 4
	.ascii "FCOS\0"
	.space 3
	.long	240
	.byte	2
	.byte	2
	.byte	-39
	.byte	-1
	.space 4
	.ascii "FDECSTP\0"
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-10
	.space 4
	.ascii "FDISI\0"
	.space 2
	.long	255
	.byte	2
	.byte	3
	.byte	-101
	.byte	-37
	.byte	-31
	.space 3
	.ascii "FDIV\0"
	.space 3
	.long	255
	.byte	48
	.byte	0
	.byte	0
	.byte	-80
	.byte	-76
	.byte	0
	.byte	-80
	.byte	-68
	.ascii "FDIVP\0"
	.space 2
	.long	255
	.byte	49
	.byte	62
	.space 6
	.ascii "FDIVR\0"
	.space 2
	.long	255
	.byte	48
	.byte	0
	.byte	0
	.byte	-72
	.byte	-68
	.byte	0
	.byte	-72
	.byte	-76
	.ascii "FDIVRP\0"
	.space 1
	.long	255
	.byte	49
	.byte	54
	.space 6
	.ascii "FENI\0"
	.space 3
	.long	255
	.byte	2
	.byte	3
	.byte	-101
	.byte	-37
	.byte	-32
	.space 3
	.ascii "FFREE\0"
	.space 2
	.long	255
	.byte	48
	.byte	8
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-123
	.space 1
	.ascii "FIADD\0"
	.space 2
	.long	255
	.byte	48
	.byte	0
	.byte	-122
	.byte	-126
	.space 4
	.ascii "FICOM\0"
	.space 2
	.long	255
	.byte	48
	.byte	0
	.byte	-106
	.byte	-110
	.space 4
	.ascii "FICOMP\0"
	.space 1
	.long	255
	.byte	48
	.byte	0
	.byte	-98
	.byte	-102
	.space 4
	.ascii "FIDIV\0"
	.space 2
	.long	255
	.byte	48
	.byte	0
	.byte	-74
	.byte	-78
	.space 4
	.ascii "FIDIVR\0"
	.space 1
	.long	255
	.byte	48
	.byte	0
	.byte	-66
	.byte	-70
	.space 4
	.ascii "FILD\0"
	.space 3
	.long	255
	.byte	48
	.byte	0
	.byte	-121
	.byte	-125
	.byte	-81
	.space 3
	.ascii "FIMUL\0"
	.space 2
	.long	255
	.byte	48
	.byte	0
	.byte	-114
	.byte	-118
	.space 4
	.ascii "FINCSTP\0"
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-9
	.space 4
	.ascii "FINIT\0"
	.space 2
	.long	255
	.byte	2
	.byte	3
	.byte	-101
	.byte	-37
	.byte	-29
	.space 3
	.ascii "FIST\0"
	.space 3
	.long	255
	.byte	48
	.byte	0
	.byte	-105
	.byte	-109
	.space 4
	.ascii "FISTP\0"
	.space 2
	.long	255
	.byte	48
	.byte	0
	.byte	-97
	.byte	-101
	.byte	-65
	.space 3
	.ascii "FISUB\0"
	.space 2
	.long	255
	.byte	48
	.byte	0
	.byte	-90
	.byte	-94
	.space 4
	.ascii "FISUBR\0"
	.space 1
	.long	255
	.byte	48
	.byte	0
	.byte	-82
	.byte	-86
	.space 4
	.ascii "FLD\0"
	.space 4
	.long	255
	.byte	48
	.byte	8
	.byte	0
	.byte	-127
	.byte	-123
	.byte	-85
	.byte	-127
	.space 1
	.ascii "FLD1\0"
	.space 3
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-24
	.space 4
	.ascii "FLDCW\0"
	.space 2
	.long	255
	.byte	48
	.byte	4
	.byte	-87
	.space 5
	.ascii "FLDENV\0"
	.space 1
	.long	255
	.byte	5
	.byte	72
	.byte	97
	.byte	-39
	.space 4
	.ascii "FLDL2E\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-22
	.space 4
	.ascii "FLDL2T\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-23
	.space 4
	.ascii "FLDLG2\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-20
	.space 4
	.ascii "FLDLN2\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-19
	.space 4
	.ascii "FLDPI\0"
	.space 2
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-21
	.space 4
	.ascii "FLDZ\0"
	.space 3
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-18
	.space 4
	.ascii "FMUL\0"
	.space 3
	.long	255
	.byte	48
	.byte	0
	.byte	0
	.byte	-120
	.byte	-116
	.byte	0
	.byte	-120
	.byte	-116
	.ascii "FMULP\0"
	.space 2
	.long	255
	.byte	49
	.byte	14
	.space 6
	.ascii "FNCLEX\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-37
	.byte	-30
	.space 4
	.ascii "FNDISI\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-37
	.byte	-31
	.space 4
	.ascii "FNENI\0"
	.space 2
	.long	255
	.byte	2
	.byte	2
	.byte	-37
	.byte	-32
	.space 4
	.ascii "FNINIT\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-37
	.byte	-29
	.space 4
	.ascii "FNOP\0"
	.space 3
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-48
	.space 4
	.ascii "FNSAVE\0"
	.space 1
	.long	255
	.byte	5
	.byte	104
	.byte	97
	.byte	-35
	.space 4
	.ascii "FNSTCW\0"
	.space 1
	.long	255
	.byte	5
	.byte	122
	.byte	97
	.byte	-39
	.space 4
	.ascii "FNSTENV\0"
	.long	255
	.byte	5
	.byte	104
	.byte	97
	.byte	-39
	.space 4
	.ascii "FNSTSW\0"
	.space 1
	.long	255
	.byte	50
	.byte	10
	.byte	97
	.byte	-35
	.byte	0
	.byte	-33
	.byte	-32
	.space 1
	.ascii "FPATAN\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-13
	.space 4
	.ascii "FPTAN\0"
	.space 2
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-14
	.space 4
	.ascii "FPREM\0"
	.space 2
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-8
	.space 4
	.ascii "FPREM1\0"
	.space 1
	.long	240
	.byte	2
	.byte	2
	.byte	-39
	.byte	-11
	.space 4
	.ascii "FRNDINT\0"
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-4
	.space 4
	.ascii "FRSTOR\0"
	.space 1
	.long	255
	.byte	5
	.byte	72
	.byte	97
	.byte	-35
	.space 4
	.ascii "FS\0"
	.space 5
	.long	240
	.byte	1
	.byte	9
	.space 6
	.ascii "FSAVE\0"
	.space 2
	.long	255
	.byte	5
	.byte	104
	.byte	98
	.byte	-101
	.byte	-35
	.space 3
	.ascii "FSCALE\0"
	.space 1
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-3
	.space 4
	.ascii "FSETPM\0"
	.space 1
	.long	168
	.byte	2
	.byte	2
	.byte	-37
	.byte	-28
	.space 4
	.ascii "FSIN\0"
	.space 3
	.long	240
	.byte	2
	.byte	2
	.byte	-39
	.byte	-2
	.space 4
	.ascii "FSINCOS\0"
	.long	240
	.byte	2
	.byte	2
	.byte	-39
	.byte	-5
	.space 4
	.ascii "FSQRT\0"
	.space 2
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-6
	.space 4
	.ascii "FST\0"
	.space 4
	.long	255
	.byte	48
	.byte	8
	.byte	0
	.byte	-111
	.byte	-107
	.byte	0
	.byte	-107
	.space 1
	.ascii "FSTCW\0"
	.space 2
	.long	255
	.byte	5
	.byte	122
	.byte	98
	.byte	-101
	.byte	-39
	.space 3
	.ascii "FSTENV\0"
	.space 1
	.long	255
	.byte	5
	.byte	104
	.byte	98
	.byte	-101
	.byte	-39
	.space 3
	.ascii "FSTP\0"
	.space 3
	.long	255
	.byte	48
	.byte	8
	.byte	0
	.byte	-103
	.byte	-99
	.byte	-69
	.byte	-99
	.space 1
	.ascii "FSTSW\0"
	.space 2
	.long	255
	.byte	50
	.byte	10
	.byte	98
	.byte	-101
	.byte	-35
	.byte	-101
	.byte	-33
	.byte	-32
	.ascii "FSUB\0"
	.space 3
	.long	255
	.byte	48
	.byte	0
	.byte	0
	.byte	-96
	.byte	-92
	.byte	0
	.byte	-96
	.byte	-84
	.ascii "FSUBP\0"
	.space 2
	.long	255
	.byte	49
	.byte	46
	.space 6
	.ascii "FSUBR\0"
	.space 2
	.long	255
	.byte	48
	.byte	0
	.byte	0
	.byte	-88
	.byte	-84
	.byte	0
	.byte	-88
	.byte	-92
	.ascii "FSUBRP\0"
	.space 1
	.long	255
	.byte	49
	.byte	38
	.space 6
	.ascii "FTST\0"
	.space 3
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-28
	.space 4
	.ascii "FUCOM\0"
	.space 2
	.long	240
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-91
	.space 1
	.ascii "FUCOMP\0"
	.space 1
	.long	240
	.byte	48
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-83
	.space 1
	.ascii "FUCOMPP\0"
	.long	240
	.byte	2
	.byte	2
	.byte	-38
	.byte	-23
	.space 4
	.ascii "FXAM\0"
	.space 3
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-27
	.space 4
	.ascii "FXCH\0"
	.space 3
	.long	255
	.byte	51
	.space 7
	.ascii "FXTRACT\0"
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-12
	.space 4
	.ascii "FYL2X\0"
	.space 2
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-15
	.space 4
	.ascii "FYL2XP1\0"
	.long	255
	.byte	2
	.byte	2
	.byte	-39
	.byte	-7
	.space 4
	.ascii "GLOBAL\0"
	.space 1
	.long	255
	.byte	68
	.byte	1
	.space 6
	.ascii "GS\0"
	.space 5
	.long	240
	.byte	1
	.byte	10
	.space 6
	.ascii "HLT\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	-12
	.space 5
	.ascii "IDIV\0"
	.space 3
	.long	255
	.byte	5
	.byte	119
	.byte	17
	.byte	-10
	.space 4
	.ascii "IMUL\0"
	.space 3
	.long	255
	.byte	15
	.byte	87
	.byte	17
	.byte	-10
	.space 4
	.ascii "IN\0"
	.space 5
	.long	255
	.byte	14
	.byte	-28
	.space 6
	.ascii "INC\0"
	.space 4
	.long	255
	.byte	10
	.byte	0
	.byte	64
	.byte	-2
	.space 4
	.ascii "INSB\0"
	.space 3
	.long	255
	.byte	2
	.byte	1
	.byte	108
	.space 5
	.ascii "INSD\0"
	.space 3
	.long	240
	.byte	2
	.byte	33
	.byte	109
	.space 5
	.ascii "INSW\0"
	.space 3
	.long	255
	.byte	2
	.byte	17
	.byte	109
	.space 5
	.ascii "INT\0"
	.space 4
	.long	255
	.byte	9
	.space 7
	.ascii "INT3\0"
	.space 3
	.long	255
	.byte	2
	.byte	1
	.byte	-52
	.space 5
	.ascii "INTO\0"
	.space 3
	.long	255
	.byte	2
	.byte	1
	.byte	-50
	.space 5
	.ascii "INVD\0"
	.space 3
	.long	192
	.byte	2
	.byte	2
	.byte	15
	.byte	8
	.space 4
	.ascii "INVLPG\0"
	.space 1
	.long	192
	.byte	5
	.byte	126
	.byte	98
	.byte	15
	.byte	1
	.space 3
	.ascii "IRET\0"
	.space 3
	.long	255
	.byte	2
	.byte	1
	.byte	-49
	.space 5
	.ascii "IRETD\0"
	.space 2
	.long	240
	.byte	2
	.byte	33
	.byte	-49
	.space 5
	.ascii "IRETW\0"
	.space 2
	.long	255
	.byte	2
	.byte	17
	.byte	-49
	.space 5
	.ascii "JA\0"
	.space 5
	.long	255
	.byte	20
	.byte	7
	.space 6
	.ascii "JAE\0"
	.space 4
	.long	255
	.byte	20
	.byte	3
	.space 6
	.ascii "JB\0"
	.space 5
	.long	255
	.byte	20
	.byte	2
	.space 6
	.ascii "JBE\0"
	.space 4
	.long	255
	.byte	20
	.byte	6
	.space 6
	.ascii "JC\0"
	.space 5
	.long	255
	.byte	20
	.byte	2
	.space 6
	.ascii "JCXZ\0"
	.space 3
	.long	255
	.byte	19
	.byte	-29
	.byte	16
	.space 5
	.ascii "JE\0"
	.space 5
	.long	255
	.byte	20
	.byte	4
	.space 6
	.ascii "JECXZ\0"
	.space 2
	.long	240
	.byte	19
	.byte	-29
	.byte	32
	.space 5
	.ascii "JG\0"
	.space 5
	.long	255
	.byte	20
	.byte	15
	.space 6
	.ascii "JGE\0"
	.space 4
	.long	255
	.byte	20
	.byte	13
	.space 6
	.ascii "JL\0"
	.space 5
	.long	255
	.byte	20
	.byte	12
	.space 6
	.ascii "JLE\0"
	.space 4
	.long	255
	.byte	20
	.byte	14
	.space 6
	.ascii "JMP\0"
	.space 4
	.long	255
	.byte	64
	.byte	32
	.byte	-23
	.byte	-22
	.byte	-21
	.space 3
	.ascii "JNA\0"
	.space 4
	.long	255
	.byte	20
	.byte	6
	.space 6
	.ascii "JNAE\0"
	.space 3
	.long	255
	.byte	20
	.byte	2
	.space 6
	.ascii "JNB\0"
	.space 4
	.long	255
	.byte	20
	.byte	3
	.space 6
	.ascii "JNBE\0"
	.space 3
	.long	255
	.byte	20
	.byte	7
	.space 6
	.ascii "JNC\0"
	.space 4
	.long	255
	.byte	20
	.byte	3
	.space 6
	.ascii "JNE\0"
	.space 4
	.long	255
	.byte	20
	.byte	5
	.space 6
	.ascii "JNG\0"
	.space 4
	.long	255
	.byte	20
	.byte	14
	.space 6
	.ascii "JNGE\0"
	.space 3
	.long	255
	.byte	20
	.byte	12
	.space 6
	.ascii "JNL\0"
	.space 4
	.long	255
	.byte	20
	.byte	13
	.space 6
	.ascii "JNLE\0"
	.space 3
	.long	255
	.byte	20
	.byte	15
	.space 6
	.ascii "JNO\0"
	.space 4
	.long	255
	.byte	20
	.byte	1
	.space 6
	.ascii "JNP\0"
	.space 4
	.long	255
	.byte	20
	.byte	11
	.space 6
	.ascii "JNS\0"
	.space 4
	.long	255
	.byte	20
	.byte	9
	.space 6
	.ascii "JNZ\0"
	.space 4
	.long	255
	.byte	20
	.byte	5
	.space 6
	.ascii "JO\0"
	.space 5
	.long	255
	.byte	20
	.byte	0
	.space 6
	.ascii "JP\0"
	.space 5
	.long	255
	.byte	20
	.byte	10
	.space 6
	.ascii "JPE\0"
	.space 4
	.long	255
	.byte	20
	.byte	10
	.space 6
	.ascii "JPO\0"
	.space 4
	.long	255
	.byte	20
	.byte	11
	.space 6
	.ascii "JS\0"
	.space 5
	.long	255
	.byte	20
	.byte	8
	.space 6
	.ascii "JZ\0"
	.space 5
	.long	255
	.byte	20
	.byte	4
	.space 6
	.ascii "LAHF\0"
	.space 3
	.long	255
	.byte	2
	.byte	1
	.byte	-97
	.space 5
	.ascii "LAR\0"
	.space 4
	.long	168
	.byte	4
	.byte	-90
	.byte	2
	.byte	15
	.byte	2
	.space 3
	.ascii "LDS\0"
	.space 4
	.long	255
	.byte	4
	.byte	-122
	.byte	65
	.byte	-59
	.space 4
	.ascii "LEA\0"
	.space 4
	.long	255
	.byte	4
	.byte	6
	.byte	65
	.byte	-115
	.space 4
	.ascii "LEAVE\0"
	.space 2
	.long	254
	.byte	2
	.byte	1
	.byte	-55
	.space 5
	.ascii "LES\0"
	.space 4
	.long	255
	.byte	4
	.byte	-122
	.byte	65
	.byte	-60
	.space 4
	.ascii "LFS\0"
	.space 4
	.long	240
	.byte	4
	.byte	-122
	.byte	66
	.byte	15
	.byte	-76
	.space 3
	.ascii "LGDT\0"
	.space 3
	.long	168
	.byte	5
	.byte	46
	.byte	98
	.byte	15
	.byte	1
	.space 3
	.ascii "LGS\0"
	.space 4
	.long	240
	.byte	4
	.byte	-122
	.byte	66
	.byte	15
	.byte	-75
	.space 3
	.ascii "LIDT\0"
	.space 3
	.long	168
	.byte	5
	.byte	62
	.byte	98
	.byte	15
	.byte	1
	.space 3
	.ascii "LLDT\0"
	.space 3
	.long	168
	.byte	5
	.byte	42
	.byte	34
	.byte	15
	.byte	0
	.space 3
	.ascii "LMSW\0"
	.space 3
	.long	168
	.byte	5
	.byte	106
	.byte	34
	.byte	15
	.byte	1
	.space 3
	.ascii "LOCK\0"
	.space 3
	.long	255
	.byte	1
	.byte	2
	.space 6
	.ascii "LODSB\0"
	.space 2
	.long	255
	.byte	2
	.byte	65
	.byte	-84
	.space 5
	.ascii "LODSD\0"
	.space 2
	.long	240
	.byte	2
	.byte	97
	.byte	-83
	.space 5
	.ascii "LODSW\0"
	.space 2
	.long	255
	.byte	2
	.byte	81
	.byte	-83
	.space 5
	.ascii "LOOP\0"
	.space 3
	.long	255
	.byte	19
	.byte	-30
	.byte	0
	.space 5
	.ascii "LOOPE\0"
	.space 2
	.long	255
	.byte	19
	.byte	-31
	.byte	0
	.space 5
	.ascii "LOOPNE\0"
	.space 1
	.long	255
	.byte	19
	.byte	-32
	.byte	0
	.space 5
	.ascii "LOOPNZ\0"
	.space 1
	.long	255
	.byte	19
	.byte	-32
	.byte	0
	.space 5
	.ascii "LOOPZ\0"
	.space 2
	.long	255
	.byte	19
	.byte	-31
	.byte	0
	.space 5
	.ascii "LSL\0"
	.space 4
	.long	168
	.byte	4
	.byte	-90
	.byte	2
	.byte	15
	.byte	3
	.space 3
	.ascii "LSS\0"
	.space 4
	.long	255
	.byte	4
	.byte	-122
	.byte	66
	.byte	15
	.byte	-78
	.space 3
	.ascii "LTR\0"
	.space 4
	.long	168
	.byte	5
	.byte	58
	.byte	34
	.byte	15
	.byte	0
	.space 3
	.ascii "MOV\0"
	.space 4
	.long	255
	.byte	11
	.space 7
	.ascii "MOVSB\0"
	.space 2
	.long	255
	.byte	2
	.byte	65
	.byte	-92
	.space 5
	.ascii "MOVSD\0"
	.space 2
	.long	240
	.byte	2
	.byte	97
	.byte	-91
	.space 5
	.ascii "MOVSW\0"
	.space 2
	.long	255
	.byte	2
	.byte	81
	.byte	-91
	.space 5
	.ascii "MOVSX\0"
	.space 2
	.long	240
	.byte	17
	.byte	-65
	.space 6
	.ascii "MOVZX\0"
	.space 2
	.long	240
	.byte	17
	.byte	-73
	.space 6
	.ascii "MUL\0"
	.space 4
	.long	255
	.byte	5
	.byte	71
	.byte	17
	.byte	-10
	.space 4
	.ascii "NEG\0"
	.space 4
	.long	255
	.byte	5
	.byte	55
	.byte	17
	.byte	-10
	.space 4
	.ascii "NOP\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	-112
	.space 5
	.ascii "NOT\0"
	.space 4
	.long	255
	.byte	5
	.byte	39
	.byte	17
	.byte	-10
	.space 4
	.ascii "OR\0"
	.space 5
	.long	255
	.byte	12
	.byte	-121
	.byte	17
	.byte	8
	.space 4
	.ascii "ORG\0"
	.space 4
	.long	255
	.byte	61
	.space 7
	.ascii "OUT\0"
	.space 4
	.long	255
	.byte	14
	.byte	-26
	.space 6
	.ascii "OUTSB\0"
	.space 2
	.long	255
	.byte	2
	.byte	65
	.byte	110
	.space 5
	.ascii "OUTSD\0"
	.space 2
	.long	240
	.byte	2
	.byte	97
	.byte	111
	.space 5
	.ascii "OUTSW\0"
	.space 2
	.long	255
	.byte	2
	.byte	81
	.byte	111
	.space 5
	.ascii "POP\0"
	.space 4
	.long	255
	.byte	10
	.byte	8
	.byte	88
	.byte	-113
	.byte	7
	.byte	-95
	.space 2
	.ascii "POPA\0"
	.space 3
	.long	254
	.byte	2
	.byte	1
	.byte	97
	.space 5
	.ascii "POPAD\0"
	.space 2
	.long	240
	.byte	2
	.byte	33
	.byte	97
	.space 5
	.ascii "POPAW\0"
	.space 2
	.long	254
	.byte	2
	.byte	17
	.byte	97
	.space 5
	.ascii "POPF\0"
	.space 3
	.long	255
	.byte	2
	.byte	1
	.byte	-99
	.space 5
	.ascii "POPFD\0"
	.space 2
	.long	240
	.byte	2
	.byte	33
	.byte	-99
	.space 5
	.ascii "POPFW\0"
	.space 2
	.long	255
	.byte	2
	.byte	17
	.byte	-99
	.space 5
	.ascii "PUSH\0"
	.space 3
	.long	255
	.byte	10
	.byte	30
	.byte	80
	.byte	-1
	.byte	6
	.byte	-96
	.space 2
	.ascii "PUSHA\0"
	.space 2
	.long	254
	.byte	2
	.byte	1
	.byte	96
	.space 5
	.ascii "PUSHAD\0"
	.space 1
	.long	240
	.byte	2
	.byte	33
	.byte	96
	.space 5
	.ascii "PUSHAW\0"
	.space 1
	.long	254
	.byte	2
	.byte	17
	.byte	96
	.space 5
	.ascii "PUSHF\0"
	.space 2
	.long	255
	.byte	2
	.byte	1
	.byte	-100
	.space 5
	.ascii "PUSHFD\0"
	.space 1
	.long	240
	.byte	2
	.byte	33
	.byte	-100
	.space 5
	.ascii "PUSHFW\0"
	.space 1
	.long	255
	.byte	2
	.byte	17
	.byte	-100
	.space 5
	.ascii "RCL\0"
	.space 4
	.long	255
	.byte	6
	.byte	2
	.space 6
	.ascii "RCR\0"
	.space 4
	.long	255
	.byte	6
	.byte	3
	.space 6
	.ascii "REP\0"
	.space 4
	.long	255
	.byte	1
	.byte	0
	.space 6
	.ascii "REPE\0"
	.space 3
	.long	255
	.byte	1
	.byte	0
	.space 6
	.ascii "REPNE\0"
	.space 2
	.long	255
	.byte	1
	.byte	1
	.space 6
	.ascii "REPNZ\0"
	.space 2
	.long	255
	.byte	1
	.byte	1
	.space 6
	.ascii "REPZ\0"
	.space 3
	.long	255
	.byte	1
	.byte	0
	.space 6
	.ascii "RESB\0"
	.space 3
	.long	255
	.byte	62
	.byte	1
	.space 6
	.ascii "RESD\0"
	.space 3
	.long	255
	.byte	62
	.byte	4
	.space 6
	.ascii "RESQ\0"
	.space 3
	.long	255
	.byte	62
	.byte	8
	.space 6
	.ascii "REST\0"
	.space 3
	.long	255
	.byte	62
	.byte	10
	.space 6
	.ascii "RESW\0"
	.space 3
	.long	255
	.byte	62
	.byte	2
	.space 6
	.ascii "RET\0"
	.space 4
	.long	255
	.byte	7
	.byte	-62
	.space 6
	.ascii "RETF\0"
	.space 3
	.long	255
	.byte	7
	.byte	-54
	.space 6
	.ascii "RETN\0"
	.space 3
	.long	255
	.byte	7
	.byte	-62
	.space 6
	.ascii "ROL\0"
	.space 4
	.long	255
	.byte	6
	.byte	0
	.space 6
	.ascii "ROR\0"
	.space 4
	.long	255
	.byte	6
	.byte	1
	.space 6
	.ascii "SAHF\0"
	.space 3
	.long	255
	.byte	2
	.byte	1
	.byte	-98
	.space 5
	.ascii "SAL\0"
	.space 4
	.long	255
	.byte	6
	.byte	4
	.space 6
	.ascii "SAR\0"
	.space 4
	.long	255
	.byte	6
	.byte	7
	.space 6
	.ascii "SBB\0"
	.space 4
	.long	255
	.byte	12
	.byte	-121
	.byte	17
	.byte	24
	.space 4
	.ascii "SCASB\0"
	.space 2
	.long	255
	.byte	2
	.byte	1
	.byte	-82
	.space 5
	.ascii "SCASD\0"
	.space 2
	.long	240
	.byte	2
	.byte	33
	.byte	-81
	.space 5
	.ascii "SCASW\0"
	.space 2
	.long	255
	.byte	2
	.byte	17
	.byte	-81
	.space 5
	.ascii "SETA\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-105
	.space 3
	.ascii "SETAE\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-109
	.space 3
	.ascii "SETB\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-110
	.space 3
	.ascii "SETBE\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-106
	.space 3
	.ascii "SETC\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-110
	.space 3
	.ascii "SETE\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-108
	.space 3
	.ascii "SETG\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-97
	.space 3
	.ascii "SETGE\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-99
	.space 3
	.ascii "SETL\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-100
	.space 3
	.ascii "SETLE\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-98
	.space 3
	.ascii "SETNA\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-106
	.space 3
	.ascii "SETNAE\0"
	.space 1
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-110
	.space 3
	.ascii "SETNB\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-109
	.space 3
	.ascii "SETNBE\0"
	.space 1
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-105
	.space 3
	.ascii "SETNC\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-109
	.space 3
	.ascii "SETNE\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-107
	.space 3
	.ascii "SETNG\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-98
	.space 3
	.ascii "SETNGE\0"
	.space 1
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-100
	.space 3
	.ascii "SETNL\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-99
	.space 3
	.ascii "SETNLE\0"
	.space 1
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-97
	.space 3
	.ascii "SETNO\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-111
	.space 3
	.ascii "SETNP\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-101
	.space 3
	.ascii "SETNS\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-103
	.space 3
	.ascii "SETNZ\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-107
	.space 3
	.ascii "SETO\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-112
	.space 3
	.ascii "SETP\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-102
	.space 3
	.ascii "SETPE\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-102
	.space 3
	.ascii "SETPO\0"
	.space 2
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-101
	.space 3
	.ascii "SETS\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-104
	.space 3
	.ascii "SETZ\0"
	.space 3
	.long	240
	.byte	5
	.byte	9
	.byte	50
	.byte	15
	.byte	-108
	.space 3
	.ascii "SGDT\0"
	.space 3
	.long	168
	.byte	5
	.byte	14
	.byte	98
	.byte	15
	.byte	1
	.space 3
	.ascii "SHL\0"
	.space 4
	.long	255
	.byte	6
	.byte	4
	.space 6
	.ascii "SHLD\0"
	.space 3
	.long	240
	.byte	18
	.byte	-92
	.space 6
	.ascii "SHR\0"
	.space 4
	.long	255
	.byte	6
	.byte	5
	.space 6
	.ascii "SHRD\0"
	.space 3
	.long	240
	.byte	18
	.byte	-84
	.space 6
	.ascii "SIDT\0"
	.space 3
	.long	168
	.byte	5
	.byte	30
	.byte	98
	.byte	15
	.byte	1
	.space 3
	.ascii "SLDT\0"
	.space 3
	.long	168
	.byte	5
	.byte	10
	.byte	34
	.byte	15
	.byte	0
	.space 3
	.ascii "SMSW\0"
	.space 3
	.long	168
	.byte	5
	.byte	74
	.byte	34
	.byte	15
	.byte	1
	.space 3
	.ascii "SS\0"
	.space 5
	.long	255
	.byte	1
	.byte	7
	.space 6
	.ascii "STC\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	-7
	.space 5
	.ascii "STD\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	-3
	.space 5
	.ascii "STI\0"
	.space 4
	.long	255
	.byte	2
	.byte	1
	.byte	-5
	.space 5
	.ascii "STOSB\0"
	.space 2
	.long	255
	.byte	2
	.byte	1
	.byte	-86
	.space 5
	.ascii "STOSD\0"
	.space 2
	.long	240
	.byte	2
	.byte	33
	.byte	-85
	.space 5
	.ascii "STOSW\0"
	.space 2
	.long	255
	.byte	2
	.byte	17
	.byte	-85
	.space 5
	.ascii "STR\0"
	.space 4
	.long	168
	.byte	5
	.byte	26
	.byte	34
	.byte	15
	.byte	0
	.space 3
	.ascii "SUB\0"
	.space 4
	.long	255
	.byte	12
	.byte	-121
	.byte	17
	.byte	40
	.space 4
	.ascii "TEST\0"
	.space 3
	.long	255
	.byte	16
	.space 7
	.ascii "TIMES\0"
	.space 2
	.long	255
	.byte	71
	.space 7
	.ascii "VERR\0"
	.space 3
	.long	168
	.byte	5
	.byte	74
	.byte	34
	.byte	15
	.byte	0
	.space 3
	.ascii "VERW\0"
	.space 3
	.long	168
	.byte	5
	.byte	90
	.byte	34
	.byte	15
	.byte	0
	.space 3
	.ascii "WAIT\0"
	.space 3
	.long	255
	.byte	2
	.byte	1
	.byte	-101
	.space 5
	.ascii "WBINVD\0"
	.space 1
	.long	192
	.byte	2
	.byte	1
	.byte	15
	.byte	9
	.space 4
	.ascii "XADD\0"
	.space 3
	.long	192
	.byte	3
	.byte	-121
	.byte	18
	.byte	15
	.byte	-64
	.space 3
	.ascii "XCHG\0"
	.space 3
	.long	255
	.byte	13
	.byte	-121
	.byte	17
	.byte	-122
	.space 4
	.ascii "XLATB\0"
	.space 2
	.long	255
	.byte	2
	.byte	65
	.byte	-41
	.space 5
	.ascii "XOR\0"
	.space 4
	.long	255
	.byte	12
	.byte	-121
	.byte	17
	.byte	48
	.space 4
	.ascii "\0"
	.space 7
	.long	0
	.byte	0
	.space 7
	.align 32
_setting_table:
	.ascii "BITS\0"
	.space 3
	.long	255
	.byte	-32
	.space 7
	.ascii "INSTRSET"
	.long	255
	.byte	-31
	.space 7
	.ascii "OPTIMIZE"
	.long	255
	.byte	-30
	.space 7
	.ascii "FORMAT\0"
	.space 1
	.long	255
	.byte	-29
	.space 7
	.ascii "PADDING\0"
	.long	255
	.byte	-28
	.space 7
	.ascii "PADSET\0"
	.space 1
	.long	255
	.byte	-27
	.space 7
	.ascii "OPTION\0"
	.space 1
	.long	255
	.byte	-26
	.space 7
	.ascii "SECTION\0"
	.long	255
	.byte	-25
	.space 7
	.ascii "ABSOLUTE"
	.long	255
	.byte	-24
	.space 7
	.ascii "FILE\0"
	.space 3
	.long	255
	.byte	-23
	.space 7
	.ascii "\0"
	.space 7
	.long	0
	.byte	0
	.space 7
	.text
.globl _setinstruct
	.def	_setinstruct;	.scl	2;	.type	32;	.endef
_setinstruct:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	16(%ebp), %eax
	addl	$8, %eax
	movl	%eax, -8(%ebp)
	jmp	L933
L939:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -1(%ebp)
	cmpb	$32, -1(%ebp)
	ja	L934
	nop
	jmp	L940
L934:
	incl	8(%ebp)
	cmpb	$96, -1(%ebp)
	jbe	L936
	cmpb	$122, -1(%ebp)
	ja	L936
	subb	$32, -1(%ebp)
L936:
	movl	16(%ebp), %eax
	cmpl	-8(%ebp), %eax
	jb	L937
	movl	$0, %eax
	jmp	L938
L937:
	movl	16(%ebp), %eax
	movb	-1(%ebp), %dl
	movb	%dl, (%eax)
	incl	16(%ebp)
L933:
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L939
	jmp	L940
L941:
	movl	16(%ebp), %eax
	movb	$0, (%eax)
	incl	16(%ebp)
L940:
	movl	16(%ebp), %eax
	cmpl	-8(%ebp), %eax
	jb	L941
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skipspace
L938:
	leave
	ret
	.section .rdata,"dr"
LC0:
	.ascii "8086\0"
LC1:
	.ascii "80186\0"
LC2:
	.ascii "80286\0"
LC3:
	.ascii "80286p\0"
LC4:
	.ascii "i386\0"
LC5:
	.ascii "i386p\0"
LC6:
	.ascii "i486\0"
LC7:
	.ascii "i486p\0"
LC8:
	.ascii "Pentium\0"
LC9:
	.ascii "PentiumPro\0"
LC10:
	.ascii "PentiumMMX\0"
LC11:
	.ascii "Pentium2\0"
LC12:
	.ascii "Pentium3\0"
LC13:
	.ascii "Pentium4\0"
	.data
	.align 32
_cpu_name:
	.long	LC0
	.long	LC1
	.long	LC2
	.long	LC3
	.long	LC4
	.long	LC5
	.long	LC6
	.long	LC7
	.long	LC8
	.long	LC9
	.long	LC10
	.long	LC11
	.long	LC12
	.long	LC13
	.long	0
	.section .rdata,"dr"
LC14:
	.ascii "BIN\0"
LC15:
	.ascii "WCOFF\0"
	.data
	.align 4
_format_type:
	.long	LC14
	.long	LC15
	.long	0
	.section .rdata,"dr"
LC16:
	.ascii "%NASK\0"
	.text
.globl _decoder
	.def	_decoder;	.scl	2;	.type	32;	.endef
_decoder:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$92, %esp
	movl	16(%ebp), %eax
	movl	$0, 8(%eax)
	movl	16(%ebp), %eax
	movb	$0, 76(%eax)
	movl	16(%ebp), %eax
	movl	$0, 36(%eax)
	movl	16(%ebp), %eax
	movl	$0, (%eax)
L943:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skipspace
	movl	%eax, 12(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1048
L944:
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$91, %al
	jne	L946
	movl	12(%ebp), %eax
	incl	%eax
	movl	%eax, 12(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %ebx
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skipspace
	leal	-60(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	%ebx, 4(%esp)
	movl	%eax, (%esp)
	call	_setinstruct
	movl	%eax, -64(%ebp)
	movl	-64(%ebp), %eax
	testl	%eax, %eax
	je	L1049
	movl	$_setting_table, -32(%ebp)
	jmp	L948
L1011:
	movb	$0, -41(%ebp)
	movl	$0, -48(%ebp)
	jmp	L949
L950:
	movl	-48(%ebp), %eax
	movl	-32(%ebp), %edx
	movb	(%edx,%eax), %dl
	movl	-48(%ebp), %eax
	movb	-60(%ebp,%eax), %al
	xorl	%edx, %eax
	orb	%al, -41(%ebp)
	movl	-48(%ebp), %eax
	incl	%eax
	movl	%eax, -48(%ebp)
L949:
	movl	-48(%ebp), %eax
	cmpl	$7, %eax
	jle	L950
	cmpb	$0, -41(%ebp)
	jne	L951
	movl	-32(%ebp), %eax
	movb	12(%eax), %al
	movzbl	%al, %eax
	subl	$224, %eax
	cmpl	$9, %eax
	ja	L951
	movl	L959(,%eax,4), %eax
	jmp	*%eax
	.section .rdata,"dr"
	.align 4
L959:
	.long	L952
	.long	L953
	.long	L954
	.long	L955
	.long	L951
	.long	L951
	.long	L956
	.long	L957
	.long	L951
	.long	L958
	.text
L952:
	leal	-48(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_getconst
	testl	%eax, %eax
	jne	L1050
L960:
	movl	-48(%ebp), %eax
	cmpl	$16, %eax
	je	L962
	movl	-48(%ebp), %eax
	cmpl	$32, %eax
	jne	L1051
L962:
	movl	-48(%ebp), %eax
	movb	%al, %dl
	movl	8(%ebp), %eax
	movb	%dl, 12(%eax)
	jmp	L963
L953:
	movl	$_cpu_name, -36(%ebp)
L964:
	movl	-64(%ebp), %eax
	leal	4(%eax), %edx
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, %edx
	jb	L965
	jmp	L961
L1050:
	nop
	jmp	L961
L1051:
	nop
	jmp	L961
L1052:
	nop
	jmp	L961
L1055:
	nop
	jmp	L961
L1056:
	nop
	jmp	L961
L1068:
	nop
	jmp	L961
L1069:
	nop
	jmp	L961
L1070:
	nop
	jmp	L961
L1071:
	nop
	jmp	L961
L1077:
	nop
	jmp	L961
L1081:
	nop
	jmp	L961
L1083:
	nop
L961:
	movl	16(%ebp), %eax
	movb	$2, 76(%eax)
	jmp	L963
L965:
	movl	-64(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -41(%ebp)
	incl	%eax
	movl	%eax, -64(%ebp)
	cmpb	$34, -41(%ebp)
	je	L966
	cmpb	$39, -41(%ebp)
	jne	L1052
L966:
	movl	-64(%ebp), %eax
	movl	%eax, 12(%ebp)
	movl	$0, -48(%ebp)
L973:
	movl	-36(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -40(%ebp)
	addl	$4, -36(%ebp)
L970:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-64(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1053
L967:
	movl	-64(%ebp), %eax
	movb	(%eax), %cl
	movl	-40(%ebp), %edx
	movb	(%edx), %dl
	cmpb	%dl, %cl
	setne	%dl
	incl	%eax
	movl	%eax, -64(%ebp)
	incl	-40(%ebp)
	testb	%dl, %dl
	jne	L1054
L969:
	movl	-40(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L970
	movl	-64(%ebp), %eax
	movb	(%eax), %al
	cmpb	-41(%ebp), %al
	jne	L968
	movl	-32(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-31, %al
	jne	L971
	movl	-48(%ebp), %eax
	movl	$1, %edx
	movl	%edx, %ebx
	movb	%al, %cl
	sall	%cl, %ebx
	movl	%ebx, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	8(%ebp), %eax
	movl	16(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L972
L971:
	movl	-48(%ebp), %eax
	movb	%al, %dl
	movl	8(%ebp), %eax
	movb	%dl, 14(%eax)
L972:
	jmp	L963
L1053:
	nop
	jmp	L968
L1054:
	nop
L968:
	movl	12(%ebp), %eax
	movl	%eax, -64(%ebp)
	movl	-48(%ebp), %eax
	incl	%eax
	movl	%eax, -48(%ebp)
	movl	-36(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	L973
	jmp	L961
L954:
	leal	-48(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_getconst
	testl	%eax, %eax
	jne	L1055
L974:
	movl	-48(%ebp), %eax
	movb	%al, %dl
	movl	8(%ebp), %eax
	movb	%dl, 13(%eax)
	jmp	L963
L955:
	movl	$_format_type, -36(%ebp)
	jmp	L964
L956:
	leal	-48(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_getconst
	testl	%eax, %eax
	jne	L1056
L975:
	movl	-48(%ebp), %eax
	movb	%al, %dl
	movl	8(%ebp), %eax
	movb	%dl, 15(%eax)
	movl	8(%ebp), %eax
	movb	15(%eax), %dl
	movl	8(%ebp), %eax
	movb	%dl, 33(%eax)
	jmp	L963
L957:
	movl	$0, -52(%ebp)
	jmp	L976
L980:
	movl	-64(%ebp), %edx
	movl	-52(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	(%eax), %al
	cmpb	$32, %al
	jbe	L1057
L977:
	movl	-64(%ebp), %edx
	movl	-52(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	(%eax), %al
	cmpb	$93, %al
	je	L1058
L979:
	movl	-52(%ebp), %eax
	incl	%eax
	movl	%eax, -52(%ebp)
L976:
	movl	-64(%ebp), %edx
	movl	-52(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, %edx
	jb	L980
	jmp	L978
L1057:
	nop
	jmp	L978
L1058:
	nop
L978:
	movl	-52(%ebp), %eax
	cmpl	$16, %eax
	jg	L1059
L981:
	movl	-64(%ebp), %edx
	movl	-52(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, %edx
	jae	L1060
L983:
	movl	$0, -48(%ebp)
	jmp	L984
L993:
	movl	16(%ebp), %eax
	movl	72(%eax), %ecx
	movl	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movb	24(%eax), %al
	testb	%al, %al
	jne	L985
	movl	16(%ebp), %eax
	movl	72(%eax), %ecx
	movl	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %edx
	movl	-52(%ebp), %eax
	movb	%al, 41(%edx)
	movl	16(%ebp), %eax
	movl	72(%eax), %ecx
	movl	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %edx
	movl	-52(%ebp), %eax
	movb	$0, 24(%edx,%eax)
	movl	-52(%ebp), %eax
	movl	%eax, -28(%ebp)
	jmp	L986
L987:
	movl	16(%ebp), %eax
	movl	72(%eax), %ecx
	movl	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %edx
	movl	-64(%ebp), %ecx
	movl	-28(%ebp), %eax
	leal	(%ecx,%eax), %eax
	movb	(%eax), %al
	addl	-28(%ebp), %edx
	addl	$16, %edx
	movb	%al, 8(%edx)
L986:
	decl	-28(%ebp)
	cmpl	$0, -28(%ebp)
	jns	L987
	jmp	L988
L985:
	movl	16(%ebp), %eax
	movl	72(%eax), %ecx
	movl	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movb	41(%eax), %al
	movzbl	%al, %edx
	movl	-52(%ebp), %eax
	cmpl	%eax, %edx
	jne	L1061
L989:
	movb	$0, -41(%ebp)
	movl	$0, -28(%ebp)
	jmp	L991
L992:
	movl	-64(%ebp), %edx
	movl	-28(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	(%eax), %cl
	movl	16(%ebp), %eax
	movl	72(%eax), %ebx
	movl	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	-28(%ebp), %eax
	addl	$16, %eax
	movb	8(%eax), %al
	xorl	%ecx, %eax
	orb	%al, -41(%ebp)
	incl	-28(%ebp)
L991:
	movl	-52(%ebp), %eax
	cmpl	%eax, -28(%ebp)
	jl	L992
	cmpb	$0, -41(%ebp)
	je	L1062
	jmp	L990
L1061:
	nop
L990:
	movl	-48(%ebp), %eax
	incl	%eax
	movl	%eax, -48(%ebp)
L984:
	movl	-48(%ebp), %eax
	cmpl	$7, %eax
	jle	L993
	jmp	L988
L1062:
	nop
L988:
	movl	-48(%ebp), %eax
	cmpl	$7, %eax
	jg	L1063
L994:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	-64(%ebp), %ecx
	movl	-52(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_skipspace
	movl	%eax, -64(%ebp)
	movb	$-1, -41(%ebp)
	movb	$0, -42(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-64(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1064
L995:
	movl	-64(%ebp), %eax
	movb	(%eax), %al
	cmpb	$97, %al
	je	L996
	movl	-64(%ebp), %eax
	movb	(%eax), %al
	cmpb	$65, %al
	jne	L997
L996:
	movl	-64(%ebp), %eax
	addl	$5, %eax
	movl	%eax, -64(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-64(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1065
L998:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-64(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skipspace
	movl	%eax, -64(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-64(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1066
L999:
	movl	-64(%ebp), %eax
	movb	(%eax), %al
	cmpb	$61, %al
	jne	L1067
L1000:
	movl	-64(%ebp), %eax
	incl	%eax
	movl	%eax, -64(%ebp)
	leal	-52(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_getconst
	movb	%al, -42(%ebp)
	cmpb	$0, -42(%ebp)
	jne	L997
	movb	$0, -41(%ebp)
	jmp	L1001
L1002:
	incb	-41(%ebp)
	movl	-52(%ebp), %eax
	sarl	%eax
	movl	%eax, -52(%ebp)
L1001:
	movl	-52(%ebp), %eax
	testl	%eax, %eax
	jne	L1002
L997:
	movl	16(%ebp), %eax
	movl	72(%eax), %ecx
	movl	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movb	42(%eax), %al
	cmpb	$-1, %al
	jne	L1003
	cmpb	$-1, -41(%ebp)
	je	L1003
	movl	16(%ebp), %eax
	movl	72(%eax), %ecx
	movl	-48(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %edx
	movb	-41(%ebp), %al
	movb	%al, 42(%edx)
L1003:
	movl	16(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	%edx, 8(%eax)
	movl	-48(%ebp), %eax
	movb	%al, %dl
	movl	-32(%ebp), %eax
	movb	%dl, 13(%eax)
	cmpb	$0, -42(%ebp)
	jne	L1068
L1004:
	jmp	L963
L958:
	movl	-64(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -41(%ebp)
	cmpb	$34, -41(%ebp)
	je	L1005
	cmpb	$39, -41(%ebp)
	jne	L1069
L1005:
	movl	-64(%ebp), %eax
	incl	%eax
	movl	%eax, -64(%ebp)
	movl	-64(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, 72(%eax)
	jmp	L1006
L1008:
	movl	-64(%ebp), %eax
	incl	%eax
	movl	%eax, -64(%ebp)
L1006:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-64(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1007
	movl	-64(%ebp), %eax
	movb	(%eax), %al
	cmpb	-41(%ebp), %al
	je	L1007
	movl	-64(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	L1008
L1007:
	movl	-64(%ebp), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	movl	%edx, %esi
	subl	%eax, %esi
	movl	%esi, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-64(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1070
L1009:
	movl	-64(%ebp), %eax
	movb	(%eax), %al
	cmpb	-41(%ebp), %al
	jne	L1071
L1010:
	jmp	L963
L951:
	addl	$20, -32(%ebp)
L948:
	movl	-32(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L1011
	jmp	L982
L946:
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	jne	L1012
	movb	$1, -41(%ebp)
	movl	12(%ebp), %eax
	incl	%eax
	movl	%eax, 12(%ebp)
	movl	12(%ebp), %eax
	leal	5(%eax), %edx
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	%eax, %edx
	jae	L1013
	movb	$0, -41(%ebp)
	movl	$0, -48(%ebp)
	jmp	L1014
L1015:
	movl	12(%ebp), %edx
	movl	-48(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	(%eax), %dl
	movl	-48(%ebp), %eax
	movb	LC16(%eax), %al
	movb	%dl, %cl
	subb	%al, %cl
	movb	%cl, %al
	movb	%al, %dl
	movb	-41(%ebp), %al
	orl	%edx, %eax
	movb	%al, -41(%ebp)
	movl	-48(%ebp), %eax
	incl	%eax
	movl	%eax, -48(%ebp)
L1014:
	movl	-48(%ebp), %eax
	cmpl	$4, %eax
	jle	L1015
L1013:
	cmpb	$0, -41(%ebp)
	jne	L1072
	movl	12(%ebp), %eax
	addl	$5, %eax
	movl	%eax, 12(%ebp)
	jmp	L943
L963:
	jmp	L1016
L1017:
	movl	12(%ebp), %eax
	incl	%eax
	movl	%eax, 12(%ebp)
	jmp	L1016
L1072:
	nop
	jmp	L1016
L1084:
	nop
	jmp	L1016
L1085:
	nop
	jmp	L1016
L1086:
	nop
L1016:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L945
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	L1017
	jmp	L945
L1048:
	nop
	jmp	L945
L1073:
	nop
L945:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1018
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	L1018
	movl	12(%ebp), %eax
	incl	%eax
	movl	%eax, 12(%ebp)
L1018:
	movl	12(%ebp), %eax
	addl	$92, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
L1012:
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L1073
L1019:
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$35, %al
	jne	L1020
	jmp	L963
L1076:
	nop
L1020:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	leal	-60(%ebp), %ecx
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_setinstruct
	movl	%eax, -64(%ebp)
	movl	-64(%ebp), %eax
	testl	%eax, %eax
	je	L1021
	movl	$_instruction, -32(%ebp)
	jmp	L1022
L1044:
	movb	$0, -41(%ebp)
	movl	$0, -48(%ebp)
	jmp	L1023
L1024:
	movl	-48(%ebp), %eax
	movl	-32(%ebp), %edx
	movb	(%edx,%eax), %dl
	movl	-48(%ebp), %eax
	movb	-60(%ebp,%eax), %al
	xorl	%edx, %eax
	orb	%al, -41(%ebp)
	movl	-48(%ebp), %eax
	incl	%eax
	movl	%eax, -48(%ebp)
L1023:
	movl	-48(%ebp), %eax
	cmpl	$7, %eax
	jle	L1024
	cmpb	$0, -41(%ebp)
	jne	L1025
	movl	-32(%ebp), %eax
	movl	8(%eax), %edx
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	je	L1025
	movl	16(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	%edx, 8(%eax)
	movl	-64(%ebp), %edx
	movl	16(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	cmpl	$-1, %eax
	jne	L1026
	movl	-32(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$23, %al
	je	L1074
L1027:
	movl	-64(%ebp), %eax
	movl	%eax, -40(%ebp)
	jmp	L1029
L1031:
	movl	-40(%ebp), %eax
	movb	(%eax), %al
	cmpb	$36, %al
	jne	L1030
	jmp	L1028
L1074:
	nop
L1028:
	movl	_nextlabelid, %eax
	movl	%eax, %ecx
	movl	8(%ebp), %edx
	movl	%ecx, 36(%edx)
	incl	%eax
	movl	%eax, _nextlabelid
	jmp	L1026
L1030:
	incl	-40(%ebp)
L1029:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	-40(%ebp), %eax
	jbe	L1026
	movl	-40(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	jne	L1031
L1026:
	movl	-32(%ebp), %eax
	movb	12(%eax), %al
	movb	%al, -41(%ebp)
	cmpb	$0, -41(%ebp)
	je	L1075
	movl	-64(%ebp), %eax
	movl	%eax, 12(%ebp)
	cmpb	$1, -41(%ebp)
	jne	L1033
	movl	16(%ebp), %eax
	movl	$0, 8(%eax)
	movl	16(%ebp), %eax
	movl	36(%eax), %edx
	movl	-32(%ebp), %eax
	movb	13(%eax), %al
	movzbl	%al, %eax
	movl	$1, %ebx
	movl	%ebx, %esi
	movb	%al, %cl
	sall	%cl, %esi
	movl	%esi, %eax
	orl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%edx, 36(%eax)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1034
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L1034
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	jne	L1076
L1034:
	jmp	L963
L1033:
	cmpb	$63, -41(%ebp)
	ja	L1035
	movl	$0, -48(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1036
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L1036
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	je	L1036
	jmp	L1043
L1082:
	nop
L1043:
	movl	-48(%ebp), %ecx
	movl	12(%ebp), %edx
	movl	16(%ebp), %eax
	addl	$4, %ecx
	movl	%edx, 8(%eax,%ecx,4)
	movl	8(%ebp), %eax
	leal	16(%eax), %edi
	movl	8(%ebp), %eax
	leal	48(%eax), %esi
	movl	8(%ebp), %eax
	movl	68(%eax), %ecx
	movl	8(%ebp), %eax
	movl	64(%eax), %edx
	movl	16(%ebp), %eax
	leal	52(%eax), %ebx
	movl	-48(%ebp), %eax
	sall	$2, %eax
	addl	%eax, %ebx
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%edi, 24(%esp)
	movl	%esi, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	movl	%ebx, 8(%esp)
	movl	%eax, 4(%esp)
	leal	12(%ebp), %eax
	movl	%eax, (%esp)
	call	_getparam
	movl	%eax, -52(%ebp)
	movl	-52(%ebp), %eax
	testl	%eax, %eax
	je	L1077
L1037:
	movl	-48(%ebp), %eax
	movl	-52(%ebp), %ebx
	movl	16(%ebp), %edx
	leal	8(%eax), %ecx
	movl	%ebx, 8(%edx,%ecx,4)
	incl	%eax
	movl	%eax, -48(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1078
L1038:
	movl	12(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -42(%ebp)
	cmpb	$10, -42(%ebp)
	je	L1079
L1039:
	cmpb	$59, -42(%ebp)
	je	L1080
L1040:
	cmpb	$44, -42(%ebp)
	jne	L1081
L1041:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	12(%ebp), %edx
	incl	%edx
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_skipspace
	movl	%eax, 12(%ebp)
	movl	-48(%ebp), %eax
	cmpl	$3, %eax
	jne	L1082
	jmp	L982
L1078:
	nop
	jmp	L1036
L1079:
	nop
	jmp	L1036
L1080:
	nop
L1036:
	movl	-48(%ebp), %eax
	movb	%al, %dl
	movl	16(%ebp), %eax
	movb	%dl, 77(%eax)
	movzbl	-41(%ebp), %eax
	movb	_table_prms(%eax), %al
	movb	%al, -42(%ebp)
	cmpb	$3, -42(%ebp)
	ja	L1035
	movl	16(%ebp), %eax
	movb	77(%eax), %al
	cmpb	-42(%ebp), %al
	jne	L1083
L1035:
	jmp	L963
L1025:
	addl	$20, -32(%ebp)
L1022:
	movl	-32(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L1044
L1021:
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	L982
	movl	12(%ebp), %edx
	movl	16(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L1045
L1047:
	movl	12(%ebp), %eax
	incl	%eax
	movl	%eax, 12(%ebp)
L1045:
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$32, %al
	jbe	L1046
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	cmpl	%eax, %edx
	ja	L1047
L1046:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skipspace
	movl	%eax, 12(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	cmpl	%eax, %edx
	jbe	L1084
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$10, %al
	je	L1085
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$59, %al
	je	L1086
	jmp	L1020
L1049:
	nop
	jmp	L982
L1059:
	nop
	jmp	L982
L1060:
	nop
	jmp	L982
L1063:
	nop
	jmp	L982
L1064:
	nop
	jmp	L982
L1065:
	nop
	jmp	L982
L1066:
	nop
	jmp	L982
L1067:
	nop
	jmp	L982
L1075:
	nop
L982:
	movl	16(%ebp), %eax
	movb	$1, 76(%eax)
	jmp	L963
.globl _put4b
	.def	_put4b;	.scl	2;	.type	32;	.endef
_put4b:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	movb	%al, %dl
	movl	12(%ebp), %eax
	movb	%dl, (%eax)
	movl	12(%ebp), %eax
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	shrl	$8, %eax
	movb	%al, (%edx)
	movl	12(%ebp), %eax
	leal	2(%eax), %edx
	movl	8(%ebp), %eax
	shrl	$16, %eax
	movb	%al, (%edx)
	movl	12(%ebp), %eax
	leal	3(%eax), %edx
	movl	8(%ebp), %eax
	shrl	$24, %eax
	movb	%al, (%edx)
	leave
	ret
.globl _get4b
	.def	_get4b;	.scl	2;	.type	32;	.endef
_get4b:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	8(%ebp), %edx
	incl	%edx
	movb	(%edx), %dl
	movzbl	%dl, %edx
	sall	$8, %edx
	orl	%eax, %edx
	movl	8(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	sall	$16, %eax
	orl	%eax, %edx
	movl	8(%ebp), %eax
	addl	$3, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	sall	$24, %eax
	orl	%edx, %eax
	leave
	ret
.globl _decode_expr
	.def	_decode_expr;	.scl	2;	.type	32;	.endef
_decode_expr:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$104, %esp
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -52(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	$0, -24(%ebp)
	movl	$_opelist0.2269, -40(%ebp)
	cmpl	$0, 20(%ebp)
	je	L1090
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)
L1090:
	movl	24(%ebp), %eax
	movb	17(%eax), %al
	movsbl	%al, %eax
	andl	$1, %eax
	testb	%al, %al
	je	L1091
	movl	$_opelist1.2270, -40(%ebp)
L1091:
	movl	-52(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skipspace
	movl	%eax, -52(%ebp)
	movb	$0, -9(%ebp)
	movl	-52(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	L1092
	movl	-52(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -9(%ebp)
	incl	%eax
	movl	%eax, -52(%ebp)
L1092:
	cmpb	$43, -9(%ebp)
	jne	L1093
	movl	16(%ebp), %eax
	movl	$0, 4(%eax)
L1094:
	movl	16(%ebp), %eax
	movl	$1, (%eax)
	addl	$8, 16(%ebp)
	jmp	L1091
L1093:
	cmpb	$45, -9(%ebp)
	jne	L1095
	movl	16(%ebp), %eax
	movl	$1, 4(%eax)
	jmp	L1094
L1095:
	cmpb	$126, -9(%ebp)
	jne	L1096
	movl	16(%ebp), %eax
	movl	$2, 4(%eax)
	jmp	L1094
L1096:
	movl	$0, -68(%ebp)
	jmp	L1097
L1100:
	movzbl	-9(%ebp), %edx
	movl	-68(%ebp), %eax
	movb	_symbols.2264(%eax), %al
	movsbl	%al, %eax
	cmpl	%eax, %edx
	je	L1190
L1098:
	movl	-68(%ebp), %eax
	incl	%eax
	movl	%eax, -68(%ebp)
L1097:
	movl	-68(%ebp), %eax
	cmpl	$21, %eax
	jbe	L1100
	cmpb	$0, -9(%ebp)
	je	L1191
L1101:
	movl	-52(%ebp), %eax
	decl	%eax
	movl	%eax, -16(%ebp)
	jmp	L1103
L1109:
	movl	-52(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -9(%ebp)
	cmpb	$32, -9(%ebp)
	jbe	L1192
L1104:
	movl	$0, -68(%ebp)
	jmp	L1106
L1108:
	movzbl	-9(%ebp), %edx
	movl	-68(%ebp), %eax
	movb	_symbols.2264(%eax), %al
	movsbl	%al, %eax
	cmpl	%eax, %edx
	je	L1193
L1107:
	movl	-68(%ebp), %eax
	incl	%eax
	movl	%eax, -68(%ebp)
L1106:
	movl	-68(%ebp), %eax
	cmpl	$21, %eax
	jbe	L1108
	movl	-52(%ebp), %eax
	incl	%eax
	movl	%eax, -52(%ebp)
L1103:
	movl	-52(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L1109
	jmp	L1105
L1192:
	nop
	jmp	L1105
L1193:
	nop
L1105:
	movl	$0, -68(%ebp)
	jmp	L1110
L1112:
	movb	$0, -10(%ebp)
	movl	-68(%ebp), %eax
	movl	%eax, %edx
	addl	-16(%ebp), %edx
	movl	-52(%ebp), %eax
	cmpl	%eax, %edx
	jae	L1111
	movl	-68(%ebp), %eax
	addl	-16(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -10(%ebp)
	cmpb	$96, -10(%ebp)
	jbe	L1111
	cmpb	$122, -10(%ebp)
	ja	L1111
	subb	$32, -10(%ebp)
L1111:
	movl	-68(%ebp), %eax
	movb	-10(%ebp), %dl
	movb	%dl, -60(%ebp,%eax)
	movl	-68(%ebp), %eax
	incl	%eax
	movl	%eax, -68(%ebp)
L1110:
	movl	-68(%ebp), %eax
	cmpl	$7, %eax
	jle	L1112
	movl	$0, -28(%ebp)
	movl	$_keywordlist.2276, -44(%ebp)
	jmp	L1113
L1122:
	movl	24(%ebp), %eax
	movl	(%eax), %edx
	movl	-44(%ebp), %eax
	movl	(%eax), %eax
	andl	%edx, %eax
	testl	%eax, %eax
	je	L1194
L1114:
	movl	$0, -68(%ebp)
	jmp	L1116
L1121:
	movb	$0, -10(%ebp)
	movl	$0, -32(%ebp)
	jmp	L1117
L1118:
	leal	-60(%ebp), %eax
	addl	-32(%ebp), %eax
	movb	(%eax), %al
	movb	%al, %dl
	movl	-68(%ebp), %eax
	movl	-44(%ebp), %ecx
	sall	$3, %eax
	addl	-32(%ebp), %eax
	leal	(%ecx,%eax), %eax
	movb	4(%eax), %al
	xorl	%eax, %edx
	movb	-10(%ebp), %al
	orl	%edx, %eax
	movb	%al, -10(%ebp)
	incl	-32(%ebp)
L1117:
	cmpl	$7, -32(%ebp)
	jle	L1118
	cmpb	$0, -10(%ebp)
	jne	L1119
	movl	-68(%ebp), %eax
	addl	-28(%ebp), %eax
	movl	%eax, -68(%ebp)
	nop
L1120:
	movl	-68(%ebp), %eax
	cmpl	$70, %eax
	jne	L1145
	jmp	L1189
L1119:
	movl	-68(%ebp), %eax
	incl	%eax
	movl	%eax, -68(%ebp)
L1116:
	movl	-68(%ebp), %eax
	cmpl	$7, %eax
	jle	L1121
	jmp	L1115
L1194:
	nop
L1115:
	addl	$68, -44(%ebp)
	addl	$8, -28(%ebp)
L1113:
	movl	-44(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	L1122
	movl	-52(%ebp), %eax
	movl	%eax, %edx
	movl	-16(%ebp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -32(%ebp)
	movl	-16(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -10(%ebp)
	cmpb	$47, -10(%ebp)
	jbe	L1123
	cmpb	$57, -10(%ebp)
	ja	L1123
	cmpl	$1, -32(%ebp)
	jle	L1124
	movl	-16(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$88, %al
	je	L1125
	movl	-16(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$120, %al
	jne	L1126
L1125:
	addl	$2, -16(%ebp)
	subl	$2, -32(%ebp)
	cmpl	$0, -32(%ebp)
	je	L1195
	jmp	L1128
L1126:
	movl	-52(%ebp), %eax
	decl	%eax
	movb	(%eax), %al
	movb	%al, -10(%ebp)
	cmpb	$96, -10(%ebp)
	jbe	L1129
	cmpb	$122, -10(%ebp)
	ja	L1129
	subb	$32, -10(%ebp)
L1129:
	decl	-32(%ebp)
	cmpb	$72, -10(%ebp)
	je	L1196
L1130:
	movl	$2, -28(%ebp)
	cmpb	$66, -10(%ebp)
	je	L1197
L1131:
	movl	$8, -28(%ebp)
	cmpb	$81, -10(%ebp)
	je	L1198
L1133:
	incl	-32(%ebp)
L1124:
	movl	$10, -28(%ebp)
	jmp	L1132
L1123:
	cmpb	$36, -10(%ebp)
	jne	L1134
	cmpl	$1, -32(%ebp)
	jle	L1134
	incl	-16(%ebp)
	decl	-32(%ebp)
	jmp	L1128
L1196:
	nop
L1128:
	movl	$16, -28(%ebp)
	jmp	L1132
L1197:
	nop
	jmp	L1132
L1198:
	nop
L1132:
	movl	$0, -68(%ebp)
L1142:
	movl	-16(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -10(%ebp)
	incl	-16(%ebp)
	cmpb	$47, -10(%ebp)
	jbe	L1135
	cmpb	$57, -10(%ebp)
	ja	L1135
	subb	$48, -10(%ebp)
	jmp	L1136
L1135:
	cmpb	$64, -10(%ebp)
	jbe	L1137
	cmpb	$90, -10(%ebp)
	ja	L1137
	subb	$55, -10(%ebp)
	jmp	L1136
L1137:
	cmpb	$96, -10(%ebp)
	jbe	L1138
	cmpb	$122, -10(%ebp)
	ja	L1138
	subb	$87, -10(%ebp)
	jmp	L1136
L1138:
	cmpb	$95, -10(%ebp)
	jne	L1199
	jmp	L1140
L1136:
	movzbl	-10(%ebp), %eax
	cmpl	-28(%ebp), %eax
	jge	L1200
L1141:
	movl	-68(%ebp), %eax
	movl	%eax, %edx
	imull	-28(%ebp), %edx
	movzbl	-10(%ebp), %eax
	leal	(%edx,%eax), %eax
	movl	%eax, -68(%ebp)
L1140:
	decl	-32(%ebp)
	cmpl	$0, -32(%ebp)
	jne	L1142
L1143:
	movl	16(%ebp), %eax
	movl	$0, (%eax)
	movl	-68(%ebp), %edx
	movl	16(%ebp), %eax
	movl	%edx, 4(%eax)
	addl	$8, 16(%ebp)
	jmp	L1144
L1134:
	movl	16(%ebp), %eax
	movl	$3, (%eax)
	movl	$0, 8(%esp)
	movl	-16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-32(%ebp), %eax
	movl	%eax, (%esp)
	call	_label2id
	movl	16(%ebp), %edx
	movl	%eax, 4(%edx)
	addl	$8, 16(%ebp)
	jmp	L1144
L1189:
	movl	16(%ebp), %eax
	movl	$3, (%eax)
	movl	24(%ebp), %eax
	movl	20(%eax), %eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%edx, 4(%eax)
	addl	$8, 16(%ebp)
	jmp	L1144
L1145:
	movl	-68(%ebp), %eax
	cmpl	$71, %eax
	jne	L1146
	movl	16(%ebp), %eax
	movl	$3, (%eax)
	movl	24(%ebp), %eax
	movl	28(%eax), %eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%edx, 4(%eax)
	addl	$8, 16(%ebp)
	jmp	L1144
L1146:
	movl	-68(%ebp), %eax
	cmpl	$77, %eax
	jne	L1147
	movl	24(%ebp), %eax
	movl	24(%eax), %eax
	cmpl	$-1, %eax
	jne	L1148
	movl	_nextlabelid, %eax
	movl	%eax, %ecx
	movl	24(%ebp), %edx
	movl	%ecx, 24(%edx)
	incl	%eax
	movl	%eax, _nextlabelid
L1148:
	movl	16(%ebp), %eax
	movl	$3, (%eax)
	movl	24(%ebp), %eax
	movl	24(%eax), %eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%edx, 4(%eax)
	addl	$8, 16(%ebp)
	jmp	L1144
L1147:
	movl	-68(%ebp), %eax
	cmpl	$31, %eax
	jle	L1149
	movl	-68(%ebp), %eax
	cmpl	$33, %eax
	jg	L1149
	movl	-68(%ebp), %eax
	subl	$4, %eax
	movl	%eax, -68(%ebp)
L1149:
	movl	-68(%ebp), %eax
	cmpl	$23, %eax
	jg	L1150
	jmp	L1151
L1201:
	nop
	jmp	L1151
L1203:
	nop
L1151:
	movl	16(%ebp), %eax
	movl	$2, (%eax)
	movl	-68(%ebp), %edx
	movl	16(%ebp), %eax
	movl	%edx, 4(%eax)
	addl	$8, 16(%ebp)
	jmp	L1144
L1150:
	movl	-68(%ebp), %eax
	cmpl	$35, %eax
	jg	L1152
	cmpb	$58, -9(%ebp)
	jne	L1201
L1153:
	movl	-52(%ebp), %eax
	incl	%eax
	movl	%eax, -52(%ebp)
	movl	24(%ebp), %eax
	movb	13(%eax), %al
	cmpb	$-1, %al
	jne	L1202
L1154:
	movl	-68(%ebp), %eax
	subl	$24, %eax
	movb	%al, %dl
	movl	24(%ebp), %eax
	movb	%dl, 13(%eax)
	jmp	L1091
L1152:
	movl	-68(%ebp), %eax
	cmpl	$63, %eax
	jle	L1203
L1155:
	movl	-68(%ebp), %eax
	cmpl	$65, %eax
	jg	L1156
L1157:
	movl	24(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	jne	L1204
L1158:
	movl	-68(%ebp), %eax
	subl	$63, %eax
	movb	%al, %dl
	movl	24(%ebp), %eax
	movb	%dl, 12(%eax)
	jmp	L1091
L1156:
	movl	-68(%ebp), %eax
	cmpl	$68, %eax
	jg	L1159
	movl	24(%ebp), %eax
	movb	14(%eax), %al
	cmpb	$-1, %al
	jne	L1205
L1160:
	movl	-68(%ebp), %eax
	subl	$66, %eax
	movb	%al, %dl
	movl	24(%ebp), %eax
	movb	%dl, 14(%eax)
	jmp	L1091
L1159:
	movl	-68(%ebp), %eax
	cmpl	$69, %eax
	jne	L1161
	movl	24(%ebp), %eax
	movb	15(%eax), %al
	testb	%al, %al
	jne	L1206
L1162:
	movl	24(%ebp), %eax
	movb	$1, 15(%eax)
	jmp	L1091
L1161:
	movl	-68(%ebp), %eax
	cmpl	$77, %eax
	jg	L1163
	movl	-68(%ebp), %eax
	subl	$5, %eax
	movl	%eax, -68(%ebp)
	jmp	L1157
L1163:
	movl	-68(%ebp), %eax
	cmpl	$79, %eax
	jne	L1164
	movl	24(%ebp), %eax
	movb	18(%eax), %al
	testb	%al, %al
	jne	L1207
L1165:
	movl	24(%ebp), %eax
	movb	18(%eax), %al
	leal	1(%eax), %edx
	movl	24(%ebp), %eax
	movb	%dl, 18(%eax)
	jmp	L1091
L1164:
	movl	-68(%ebp), %eax
	subl	$8, %eax
	movl	%eax, -68(%ebp)
	jmp	L1151
L1190:
	nop
L1188:
L1099:
	cmpb	$40, -9(%ebp)
	jne	L1166
	movl	24(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	$0, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	_decode_expr
	movl	%eax, 16(%ebp)
	movb	$0, -9(%ebp)
	movl	-52(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	L1167
	movl	-52(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -9(%ebp)
	incl	%eax
	movl	%eax, -52(%ebp)
L1167:
	cmpb	$41, -9(%ebp)
	je	L1168
	movl	$0, 16(%ebp)
L1168:
	cmpl	$0, 16(%ebp)
	jne	L1144
	movl	$0, %eax
	jmp	L1169
L1166:
	cmpb	$34, -9(%ebp)
	je	L1170
	cmpb	$39, -9(%ebp)
	jne	L1171
L1170:
	movl	$0, -68(%ebp)
	movl	$0, -32(%ebp)
L1175:
	movl	-52(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	L1208
L1172:
	movl	-52(%ebp), %eax
	movb	(%eax), %al
	cmpb	-9(%ebp), %al
	jne	L1173
	movl	-52(%ebp), %eax
	incl	%eax
	movl	%eax, -52(%ebp)
	jmp	L1143
L1173:
	cmpl	$4, -32(%ebp)
	je	L1209
L1174:
	leal	-68(%ebp), %edx
	movl	-32(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	-52(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, (%ecx)
	incl	-32(%ebp)
	incl	%eax
	movl	%eax, -52(%ebp)
	jmp	L1175
L1171:
	movl	-52(%ebp), %eax
	decl	%eax
	movl	%eax, -52(%ebp)
	jmp	L1102
L1191:
	nop
	jmp	L1102
L1195:
	nop
	jmp	L1102
L1199:
	nop
	jmp	L1102
L1200:
	nop
	jmp	L1102
L1202:
	nop
	jmp	L1102
L1204:
	nop
	jmp	L1102
L1205:
	nop
	jmp	L1102
L1206:
	nop
	jmp	L1102
L1207:
	nop
	jmp	L1102
L1208:
	nop
	jmp	L1102
L1209:
	nop
L1102:
	movl	$0, 16(%ebp)
	jmp	L1176
L1144:
	movl	-52(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skipspace
	movl	%eax, -52(%ebp)
	movb	$0, -10(%ebp)
	movb	-10(%ebp), %al
	movb	%al, -9(%ebp)
	movl	-52(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	L1177
	movl	-52(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -9(%ebp)
	incl	%eax
	movl	%eax, -52(%ebp)
L1177:
	movl	-52(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	L1178
	movl	-52(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -10(%ebp)
L1178:
	cmpb	$0, -9(%ebp)
	je	L1210
L1179:
	movl	-40(%ebp), %eax
	movl	%eax, -36(%ebp)
L1184:
	movl	-36(%ebp), %eax
	movb	(%eax), %al
	testb	%al, %al
	jne	L1180
	movl	-52(%ebp), %eax
	leal	-1(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	16(%ebp), %eax
	jmp	L1169
L1180:
	movzbl	-9(%ebp), %edx
	movl	-36(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	cmpl	%eax, %edx
	jne	L1181
	movl	-36(%ebp), %eax
	movb	1(%eax), %al
	testb	%al, %al
	je	L1211
L1182:
	movzbl	-10(%ebp), %edx
	movl	-36(%ebp), %eax
	movb	1(%eax), %al
	movsbl	%al, %eax
	cmpl	%eax, %edx
	jne	L1181
	movl	-52(%ebp), %eax
	incl	%eax
	movl	%eax, -52(%ebp)
	jmp	L1183
L1181:
	addl	$4, -36(%ebp)
	jmp	L1184
L1211:
	nop
L1183:
	movl	-36(%ebp), %eax
	movb	2(%eax), %al
	movsbl	%al, %eax
	movl	%eax, -64(%ebp)
	movl	-36(%ebp), %eax
	movb	3(%eax), %al
	movb	%al, -9(%ebp)
L1185:
	movl	-64(%ebp), %eax
	cmpl	%eax, -24(%ebp)
	jl	L1186
	movl	-64(%ebp), %eax
	movl	%eax, %edx
	negl	%edx
	movl	20(%ebp), %eax
	movl	%edx, (%eax)
	movzbl	-9(%ebp), %edx
	movl	16(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L1176
L1186:
	movl	16(%ebp), %eax
	movl	%eax, -20(%ebp)
	addl	$8, 16(%ebp)
L1187:
	movl	-20(%ebp), %eax
	leal	8(%eax), %ecx
	movl	-20(%ebp), %eax
	movl	4(%eax), %edx
	movl	(%eax), %eax
	movl	%eax, (%ecx)
	movl	%edx, 4(%ecx)
	subl	$8, -20(%ebp)
	movl	-48(%ebp), %eax
	cmpl	-20(%ebp), %eax
	jbe	L1187
	movl	-48(%ebp), %eax
	movl	$1, (%eax)
	movzbl	-9(%ebp), %edx
	movl	-48(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	24(%ebp), %eax
	movl	%eax, 16(%esp)
	leal	-64(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	_decode_expr
	movl	%eax, 16(%ebp)
	movl	-64(%ebp), %eax
	testl	%eax, %eax
	jns	L1176
	movl	-64(%ebp), %eax
	negl	%eax
	movl	%eax, -64(%ebp)
	movl	16(%ebp), %eax
	movl	4(%eax), %eax
	movb	%al, -9(%ebp)
	jmp	L1185
L1210:
	nop
L1176:
	movl	-52(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	16(%ebp), %eax
L1169:
	leave
	ret
.globl _init_ofsexpr
	.def	_init_ofsexpr;	.scl	2;	.type	32;	.endef
_init_ofsexpr:
	pushl	%ebp
	movl	%esp, %ebp
	movl	8(%ebp), %eax
	movl	$0, 8(%eax)
	movl	8(%ebp), %eax
	movl	8(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movb	$-1, 13(%eax)
	movl	8(%ebp), %eax
	movb	13(%eax), %dl
	movl	8(%ebp), %eax
	movb	%dl, 12(%eax)
	movl	8(%ebp), %eax
	movb	$0, 15(%eax)
	movl	8(%ebp), %eax
	movb	15(%eax), %dl
	movl	8(%ebp), %eax
	movb	%dl, 14(%eax)
	leave
	ret
.globl _calc_ofsexpr
	.def	_calc_ofsexpr;	.scl	2;	.type	32;	.endef
_calc_ofsexpr:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$108, %esp
	movl	16(%ebp), %eax
	movb	%al, -76(%ebp)
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -32(%ebp)
	movl	-36(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -28(%ebp)
	addl	$8, -36(%ebp)
	movl	12(%ebp), %eax
	movl	-36(%ebp), %edx
	movl	%edx, (%eax)
	movl	-32(%ebp), %eax
	cmpl	$1, %eax
	je	L1216
	cmpl	$1, %eax
	jg	L1219
	testl	%eax, %eax
	je	L1215
	jmp	L1213
L1219:
	cmpl	$2, %eax
	je	L1217
	cmpl	$3, %eax
	je	L1218
	jmp	L1213
L1215:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_init_ofsexpr
	movl	8(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, 8(%eax)
	jmp	L1213
L1216:
	movsbl	-76(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_ofsexpr
	cmpl	$3, -28(%ebp)
	jle	L1221
	movsbl	-76(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-52(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_ofsexpr
	movl	-44(%ebp), %eax
	movl	%eax, -32(%ebp)
	cmpl	$6, -28(%ebp)
	je	L1222
	cmpl	$11, -28(%ebp)
	jle	L1223
	cmpl	$14, -28(%ebp)
	jg	L1223
L1222:
	movb	-40(%ebp), %al
	cmpb	$-1, %al
	jne	L1224
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	jne	L1223
	movl	8(%ebp), %eax
	movb	14(%eax), %al
	testb	%al, %al
	jne	L1223
	movb	-38(%ebp), %al
	testb	%al, %al
	je	L1223
L1224:
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	jne	L1278
L1225:
	leal	-68(%ebp), %edx
	leal	-52(%ebp), %ebx
	movl	$4, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	8(%ebp), %eax
	leal	-52(%ebp), %edx
	movl	%eax, %ebx
	movl	$4, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	8(%ebp), %eax
	movl	%eax, %edx
	leal	-68(%ebp), %ebx
	movl	$4, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	-44(%ebp), %eax
	movl	%eax, -32(%ebp)
L1223:
	movl	8(%ebp), %eax
	movb	15(%eax), %dl
	movb	-37(%ebp), %al
	orl	%eax, %edx
	movl	8(%ebp), %eax
	movb	%dl, 15(%eax)
	movl	8(%ebp), %eax
	movb	14(%eax), %dl
	movb	-38(%ebp), %al
	orl	%eax, %edx
	movl	8(%ebp), %eax
	movb	%dl, 14(%eax)
	cmpl	$5, -28(%ebp)
	jle	L1221
	movb	-40(%ebp), %al
	cmpb	$-1, %al
	jne	L1279
L1227:
	movb	-38(%ebp), %al
	testb	%al, %al
	jne	L1221
	cmpl	$6, -28(%ebp)
	je	L1228
	cmpl	$7, -28(%ebp)
	je	L1228
	cmpl	$9, -28(%ebp)
	jne	L1229
L1228:
	cmpl	$1, -32(%ebp)
	je	L1230
L1229:
	cmpl	$12, -28(%ebp)
	jne	L1231
	cmpl	$-1, -32(%ebp)
	je	L1230
L1231:
	cmpl	$12, -28(%ebp)
	jle	L1232
	cmpl	$0, -32(%ebp)
	jne	L1232
L1230:
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	movb	%al, %dl
	orl	$-128, %edx
	movl	8(%ebp), %eax
	movb	%dl, 12(%eax)
	movl	8(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, %dl
	orl	$-128, %edx
	movl	8(%ebp), %eax
	movb	%dl, 13(%eax)
	jmp	L1213
L1232:
	cmpl	$6, -28(%ebp)
	je	L1233
	cmpl	$12, -28(%ebp)
	jne	L1234
L1233:
	cmpl	$0, -32(%ebp)
	je	L1235
L1234:
	cmpl	$13, -28(%ebp)
	jne	L1236
	cmpl	$-1, -32(%ebp)
	jne	L1236
L1235:
	movl	8(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	%edx, 8(%eax)
	movl	8(%ebp), %eax
	movl	$0, 4(%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movb	$-1, 13(%eax)
	movl	8(%ebp), %eax
	movb	13(%eax), %dl
	movl	8(%ebp), %eax
	movb	%dl, 12(%eax)
	movl	8(%ebp), %eax
	movb	$0, 14(%eax)
	jmp	L1213
L1236:
	cmpl	$6, -28(%ebp)
	jle	L1237
	cmpl	$10, -28(%ebp)
	jg	L1237
	cmpl	$0, -32(%ebp)
	je	L1280
L1237:
	cmpl	$8, -28(%ebp)
	je	L1238
	cmpl	$10, -28(%ebp)
	je	L1238
	cmpl	$12, -28(%ebp)
	je	L1238
	cmpl	$13, -28(%ebp)
	je	L1238
	cmpl	$14, -28(%ebp)
	jne	L1221
L1238:
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	jne	L1281
L1221:
	cmpl	$5, -28(%ebp)
	jle	L1239
	movb	-38(%ebp), %al
	testb	%al, %al
	je	L1239
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	je	L1282
	jmp	L1226
L1239:
	cmpl	$18, -28(%ebp)
	ja	L1283
	movl	-28(%ebp), %eax
	sall	$2, %eax
	addl	$L1258, %eax
	movl	(%eax), %eax
	jmp	*%eax
	.section .rdata,"dr"
	.align 4
L1258:
	.long	L1242
	.long	L1243
	.long	L1244
	.long	L1284
	.long	L1245
	.long	L1246
	.long	L1247
	.long	L1248
	.long	L1249
	.long	L1250
	.long	L1251
	.long	L1284
	.long	L1252
	.long	L1253
	.long	L1254
	.long	L1284
	.long	L1255
	.long	L1256
	.long	L1257
	.text
L1242:
	jmp	L1241
L1243:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	negl	%edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, %edx
	negl	%edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	negl	%edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1241
L1278:
	nop
	jmp	L1226
L1279:
	nop
	jmp	L1226
L1280:
	nop
	jmp	L1226
L1281:
	nop
	jmp	L1226
L1285:
	nop
	jmp	L1226
L1286:
	nop
	jmp	L1226
L1288:
	nop
	jmp	L1226
L1289:
	nop
	jmp	L1226
L1290:
	nop
	jmp	L1226
L1291:
	nop
L1226:
	movl	8(%ebp), %eax
	movb	15(%eax), %al
	movb	%al, %dl
	orl	$1, %edx
	movl	8(%ebp), %eax
	movb	%dl, 15(%eax)
	jmp	L1241
L1244:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	notl	%edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	movl	8(%ebp), %eax
	movb	12(%eax), %dl
	movl	8(%ebp), %eax
	movb	13(%eax), %al
	andl	%edx, %eax
	cmpb	$-1, %al
	jne	L1285
L1259:
	jmp	L1241
L1245:
	movl	$0, -28(%ebp)
	jmp	L1260
L1268:
	leal	-52(%ebp), %eax
	addl	-28(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	je	L1261
	movl	$0, -32(%ebp)
L1267:
	cmpl	$1, -32(%ebp)
	jg	L1286
L1262:
	movl	8(%ebp), %edx
	movl	-32(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	jne	L1263
	leal	-52(%ebp), %eax
	addl	-28(%ebp), %eax
	movb	12(%eax), %al
	movl	8(%ebp), %ecx
	movl	-32(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	%al, 12(%edx)
	movl	-28(%ebp), %eax
	movl	-52(%ebp,%eax,4), %ecx
	movl	8(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	%ecx, (%eax,%edx,4)
	jmp	L1261
L1263:
	cmpb	$0, -76(%ebp)
	jne	L1264
	movl	8(%ebp), %edx
	movl	-32(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	12(%eax), %al
	movzbl	%al, %edx
	leal	-52(%ebp), %eax
	addl	-28(%ebp), %eax
	movb	12(%eax), %al
	movzbl	%al, %eax
	xorl	%edx, %eax
	andl	$127, %eax
	testl	%eax, %eax
	jne	L1264
	movl	8(%ebp), %edx
	movl	-32(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	12(%eax), %al
	orl	$-128, %eax
	movl	8(%ebp), %ecx
	movl	-32(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	%al, 12(%edx)
	movl	8(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	(%eax,%edx,4), %edx
	movl	-28(%ebp), %eax
	movl	-52(%ebp,%eax,4), %eax
	leal	(%edx,%eax), %ecx
	movl	8(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	%ecx, (%eax,%edx,4)
	movl	8(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	(%eax,%edx,4), %eax
	testl	%eax, %eax
	jne	L1287
	cmpl	$0, -32(%ebp)
	jne	L1266
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movb	13(%eax), %dl
	movl	8(%ebp), %eax
	movb	%dl, 12(%eax)
L1266:
	movl	8(%ebp), %eax
	movl	$0, 4(%eax)
	movl	8(%ebp), %eax
	movb	$-1, 13(%eax)
	jmp	L1261
L1264:
	incl	-32(%ebp)
	jmp	L1267
L1287:
	nop
L1261:
	incl	-28(%ebp)
L1260:
	cmpl	$1, -28(%ebp)
	jle	L1268
	movl	8(%ebp), %eax
	movl	8(%eax), %edx
	movl	-44(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1241
L1246:
	movl	-52(%ebp), %eax
	negl	%eax
	movl	%eax, -52(%ebp)
	movl	-48(%ebp), %eax
	negl	%eax
	movl	%eax, -48(%ebp)
	movl	-44(%ebp), %eax
	negl	%eax
	movl	%eax, -44(%ebp)
	jmp	L1245
L1247:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	imull	-32(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, %edx
	imull	-32(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	imull	-32(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1269
L1292:
	nop
L1269:
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	movb	%al, %dl
	orl	$-128, %edx
	movl	8(%ebp), %eax
	movb	%dl, 12(%eax)
	movl	8(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, %dl
	orl	$-128, %edx
	movl	8(%ebp), %eax
	movb	%dl, 13(%eax)
	jmp	L1241
L1248:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	-32(%ebp), %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	L1288
L1270:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	-32(%ebp), %edx
	movl	%edx, -92(%ebp)
	movl	$0, %edx
	divl	-92(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	-32(%ebp), %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	L1289
L1271:
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	-32(%ebp), %ecx
	movl	%ecx, -92(%ebp)
	movl	$0, %edx
	divl	-92(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	-32(%ebp), %ecx
	movl	%ecx, -92(%ebp)
	movl	$0, %edx
	divl	-92(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1269
L1249:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	-32(%ebp), %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1241
L1250:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cltd
	idivl	-32(%ebp)
	movl	%edx, %eax
	testl	%eax, %eax
	jne	L1290
L1272:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cltd
	idivl	-32(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	cltd
	idivl	-32(%ebp)
	movl	%edx, %eax
	testl	%eax, %eax
	jne	L1291
L1273:
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	cltd
	idivl	-32(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	cltd
	idivl	-32(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1269
L1251:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	cltd
	idivl	-32(%ebp)
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1241
L1252:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	andl	-32(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1241
L1253:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	-32(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1241
L1254:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	xorl	-32(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1241
L1255:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-32(%ebp), %eax
	movb	%al, %cl
	sall	%cl, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	-32(%ebp), %eax
	movb	%al, %cl
	sall	%cl, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	8(%eax), %edx
	movl	-32(%ebp), %eax
	movb	%al, %cl
	sall	%cl, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L1274
L1276:
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movb	13(%eax), %dl
	movl	8(%ebp), %eax
	movb	%dl, 12(%eax)
	movl	8(%ebp), %eax
	movl	$0, 4(%eax)
	movl	8(%ebp), %eax
	movb	$-1, 13(%eax)
L1274:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	L1275
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	jne	L1276
L1275:
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	L1292
	movl	8(%ebp), %eax
	movl	$0, 4(%eax)
	movl	8(%ebp), %eax
	movb	$-1, 13(%eax)
	jmp	L1269
L1256:
	movl	-32(%ebp), %eax
	movl	$1, %edx
	movl	%edx, %ebx
	movb	%al, %cl
	sall	%cl, %ebx
	movl	%ebx, %eax
	movl	%eax, -32(%ebp)
	jmp	L1248
L1257:
	movl	-32(%ebp), %eax
	movl	$1, %edx
	movl	%edx, %ebx
	movb	%al, %cl
	sall	%cl, %ebx
	movl	%ebx, %eax
	movl	%eax, -32(%ebp)
	jmp	L1250
L1241:
	jmp	L1214
L1217:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_init_ofsexpr
	movl	-28(%ebp), %eax
	movb	%al, %dl
	movl	8(%ebp), %eax
	movb	%dl, 12(%eax)
	movl	8(%ebp), %eax
	movl	$1, (%eax)
	jmp	L1214
L1218:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_init_ofsexpr
	movl	8(%ebp), %eax
	movb	$1, 14(%eax)
	jmp	L1214
L1283:
	nop
	jmp	L1214
L1284:
	nop
L1214:
	nop
	jmp	L1213
L1282:
	nop
L1213:
	addl	$108, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
.globl _getparam
	.def	_getparam;	.scl	2;	.type	32;	.endef
_getparam:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$72, %esp
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)
	movl	32(%ebp), %eax
	movb	$-1, 12(%eax)
	movl	32(%ebp), %eax
	movb	$-1, 13(%eax)
	movl	32(%ebp), %eax
	movb	$-1, 14(%eax)
	movl	32(%ebp), %eax
	movb	$0, 15(%eax)
	movl	32(%ebp), %eax
	movb	$0, 16(%eax)
	movl	32(%ebp), %eax
	movb	$0, 18(%eax)
	movl	20(%ebp), %eax
	movl	$-1, (%eax)
	movl	32(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	$0, 12(%esp)
	movl	20(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	_decode_expr
	movl	%eax, -20(%ebp)
	movl	32(%ebp), %eax
	movb	14(%eax), %al
	movsbl	%al, %eax
	incl	%eax
	sall	$6, %eax
	movb	%al, %dl
	movl	32(%ebp), %eax
	movb	12(%eax), %al
	andl	$15, %eax
	orl	%edx, %eax
	movb	%al, -13(%ebp)
	movl	32(%ebp), %eax
	movb	16(%eax), %al
	movb	%al, -15(%ebp)
	movl	32(%ebp), %eax
	movb	15(%eax), %al
	testb	%al, %al
	jne	L1322
L1294:
	cmpl	$0, -20(%ebp)
	jne	L1296
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$-1, %eax
	jne	L1296
	movl	-28(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	L1296
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	cmpb	$91, %al
	jne	L1296
	cmpl	$0, 24(%ebp)
	je	L1323
L1297:
	movl	32(%ebp), %eax
	movb	14(%eax), %al
	movsbl	%al, %eax
	incl	%eax
	sall	$6, %eax
	movb	%al, %dl
	movl	32(%ebp), %eax
	movb	12(%eax), %al
	andl	$15, %eax
	orl	%edx, %eax
	orl	$16, %eax
	movb	%al, -13(%ebp)
	movl	-28(%ebp), %eax
	incl	%eax
	movl	%eax, -28(%ebp)
	movl	32(%ebp), %eax
	movb	$-1, 12(%eax)
	movl	32(%ebp), %eax
	movb	$-1, 14(%eax)
	movl	32(%ebp), %eax
	movl	%eax, 16(%esp)
	movl	$0, 12(%esp)
	movl	24(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	_decode_expr
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	je	L1324
L1298:
	movl	32(%ebp), %eax
	movb	14(%eax), %al
	cmpb	$-1, %al
	jne	L1325
L1299:
	movl	-28(%ebp), %eax
	cmpl	12(%ebp), %eax
	jae	L1326
L1300:
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	cmpb	$93, %al
	jne	L1327
L1301:
	movl	32(%ebp), %eax
	movb	16(%eax), %dl
	movb	-15(%ebp), %al
	orl	%edx, %eax
	movb	%al, -15(%ebp)
	movl	32(%ebp), %eax
	movb	12(%eax), %al
	movsbl	%al, %eax
	andl	$7, %eax
	sall	%eax
	movb	%al, %dl
	movl	32(%ebp), %eax
	movb	15(%eax), %al
	movsbl	%al, %eax
	sall	$7, %eax
	orl	%eax, %edx
	movl	32(%ebp), %eax
	movb	13(%eax), %al
	movsbl	%al, %eax
	andl	$7, %eax
	sall	$4, %eax
	orl	%eax, %edx
	movb	-15(%ebp), %al
	orl	%edx, %eax
	movb	%al, -15(%ebp)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_skipspace
	movl	%eax, -28(%ebp)
	jmp	L1302
L1296:
	cmpl	$0, -20(%ebp)
	je	L1328
L1303:
	movl	20(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	$0, 8(%esp)
	leal	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	28(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_ofsexpr
	movl	28(%ebp), %eax
	movb	15(%eax), %al
	testb	%al, %al
	jne	L1329
L1304:
	movl	32(%ebp), %eax
	movb	18(%eax), %al
	testb	%al, %al
	je	L1305
	movl	28(%ebp), %eax
	movb	12(%eax), %al
	movzbl	%al, %eax
	andl	$-8, %eax
	cmpl	$72, %eax
	jne	L1330
L1306:
	movl	28(%ebp), %eax
	movb	12(%eax), %al
	leal	-8(%eax), %edx
	movl	28(%ebp), %eax
	movb	%dl, 12(%eax)
	movl	32(%ebp), %eax
	movb	$0, 18(%eax)
L1305:
	movl	28(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	jne	L1307
	movl	28(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	32(%ebp), %eax
	movb	12(%eax), %al
	movb	%al, %dl
	andl	$15, %edx
	movb	-13(%ebp), %al
	orl	%edx, %eax
	movb	%al, -13(%ebp)
	orb	$32, -13(%ebp)
	movl	28(%ebp), %eax
	movb	14(%eax), %al
	testb	%al, %al
	je	L1331
	orb	$2, -15(%ebp)
	jmp	L1302
L1307:
	movl	28(%ebp), %eax
	movb	13(%eax), %al
	cmpb	$-1, %al
	jne	L1295
	movl	28(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$1, %eax
	jne	L1295
	movl	28(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	je	L1309
	jmp	L1295
L1322:
	nop
	jmp	L1295
L1323:
	nop
	jmp	L1295
L1324:
	nop
	jmp	L1295
L1325:
	nop
	jmp	L1295
L1326:
	nop
	jmp	L1295
L1327:
	nop
	jmp	L1295
L1328:
	nop
	jmp	L1295
L1329:
	nop
	jmp	L1295
L1330:
	nop
	jmp	L1295
L1332:
	nop
L1295:
	movb	$0, -13(%ebp)
	movb	$0, -15(%ebp)
	jmp	L1302
L1309:
	movl	28(%ebp), %eax
	movb	12(%eax), %al
	movzbl	%al, %eax
	andl	$127, %eax
	movl	%eax, -12(%ebp)
	cmpl	$7, -12(%ebp)
	jg	L1310
	movb	$4, -14(%ebp)
	jmp	L1311
L1310:
	cmpl	$15, -12(%ebp)
	jg	L1312
	movb	$2, -14(%ebp)
	jmp	L1311
L1312:
	cmpl	$23, -12(%ebp)
	jg	L1313
	movb	$1, -14(%ebp)
	jmp	L1311
L1313:
	cmpl	$39, -12(%ebp)
	jg	L1314
	movb	$2, -14(%ebp)
	jmp	L1311
L1314:
	cmpl	$63, -12(%ebp)
	jg	L1315
	movb	$4, -14(%ebp)
	jmp	L1311
L1315:
	cmpl	$79, -12(%ebp)
	jg	L1316
	movb	$10, -14(%ebp)
	jmp	L1311
L1316:
	movb	$8, -14(%ebp)
L1311:
	movl	32(%ebp), %eax
	movb	12(%eax), %al
	cmpb	$-1, %al
	jne	L1317
	movb	-13(%ebp), %al
	movb	%al, %dl
	andl	$-16, %edx
	movb	-14(%ebp), %al
	orl	%edx, %eax
	movb	%al, -13(%ebp)
	jmp	L1318
L1317:
	movzbl	-13(%ebp), %eax
	movl	%eax, %edx
	andl	$15, %edx
	movzbl	-14(%ebp), %eax
	cmpl	%eax, %edx
	jg	L1332
L1319:
	movzbl	-13(%ebp), %eax
	movl	%eax, %edx
	andl	$15, %edx
	movzbl	-14(%ebp), %eax
	cmpl	%eax, %edx
	jge	L1318
	cmpl	$3, -12(%ebp)
	jle	L1320
	cmpl	$7, -12(%ebp)
	jle	L1295
	cmpl	$11, -12(%ebp)
	jg	L1295
L1320:
	movl	-12(%ebp), %eax
	andl	$3, %eax
	orl	$8, %eax
	movl	%eax, -12(%ebp)
	movb	-14(%ebp), %al
	orl	$-16, %eax
	andb	%al, -13(%ebp)
	cmpb	$1, -14(%ebp)
	jne	L1318
	addl	$8, -12(%ebp)
L1318:
	movl	-12(%ebp), %eax
	sall	%eax
	movb	%al, %dl
	movb	-15(%ebp), %al
	orl	%edx, %eax
	movb	%al, -15(%ebp)
	jmp	L1302
L1331:
	nop
L1302:
	movl	32(%ebp), %eax
	movb	18(%eax), %al
	testb	%al, %al
	je	L1321
	movb	$0, -13(%ebp)
	movb	$0, -15(%ebp)
L1321:
	movl	16(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, (%eax)
	movl	-28(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movzbl	-13(%ebp), %eax
	movzbl	-15(%ebp), %edx
	sall	$8, %edx
	orl	%edx, %eax
	leave
	ret
.globl _testmem
	.def	_testmem;	.scl	2;	.type	32;	.endef
_testmem:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$68, %esp
	movl	16(%ebp), %eax
	movl	68(%eax), %eax
	movl	%eax, -32(%ebp)
	movl	$0, -16(%ebp)
	movl	12(%ebp), %eax
	sarl	$15, %eax
	andl	$1, %eax
	movb	%al, -21(%ebp)
	movl	12(%ebp), %eax
	sarl	$12, %eax
	andl	$7, %eax
	movl	$1, %edx
	movl	%edx, %ebx
	movb	%al, %cl
	sall	%cl, %ebx
	movl	%ebx, %eax
	andl	$127, %eax
	movl	%eax, -28(%ebp)
	movb	-21(%ebp), %al
	movsbl	%al, %eax
	movl	%eax, 8(%esp)
	leal	-32(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_ofsexpr
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	movb	%al, -34(%ebp)
	movl	8(%ebp), %eax
	movb	13(%eax), %al
	movb	%al, -33(%ebp)
	movb	-34(%ebp), %al
	cmpb	$-1, %al
	je	L1334
	movb	-34(%ebp), %al
	andl	$127, %eax
	movb	%al, -34(%ebp)
L1334:
	movb	-33(%ebp), %al
	cmpb	$-1, %al
	je	L1335
	movb	-33(%ebp), %al
	andl	$127, %eax
	movb	%al, -33(%ebp)
L1335:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -44(%ebp)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -40(%ebp)
	movl	12(%ebp), %eax
	sarl	$9, %eax
	andl	$7, %eax
	movl	%eax, -20(%ebp)
	movb	-34(%ebp), %al
	cmpb	$-1, %al
	jne	L1336
	orl	$9, -16(%ebp)
	cmpl	$1, -20(%ebp)
	je	L1378
L1337:
	cmpl	$7, -20(%ebp)
	jne	L1339
	movl	16(%ebp), %eax
	movb	12(%eax), %al
	movsbl	%al, %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L1379
	jmp	L1341
L1339:
	cmpl	$2, -20(%ebp)
	jne	L1343
L1341:
	orl	$16, -16(%ebp)
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	orl	$16777216, %edx
	movl	20(%ebp), %eax
	movl	%edx, (%eax)
L1343:
	cmpl	$4, -20(%ebp)
	jne	L1344
	jmp	L1342
L1379:
	nop
L1342:
	orl	$32, -16(%ebp)
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	orl	$33554432, %edx
	movl	20(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L1344
L1336:
	movb	-34(%ebp), %al
	cmpb	$7, %al
	ja	L1345
	cmpl	$2, -20(%ebp)
	je	L1380
L1346:
	orl	$32, -16(%ebp)
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	orl	$33554432, %edx
	movl	20(%ebp), %eax
	movl	%edx, (%eax)
	movb	-33(%ebp), %al
	cmpb	$-1, %al
	jne	L1347
	cmpb	$0, -21(%ebp)
	jne	L1348
	movl	-44(%ebp), %eax
	cmpl	$1, %eax
	je	L1344
	movb	-34(%ebp), %al
	cmpb	$4, %al
	je	L1381
L1349:
	movl	-44(%ebp), %eax
	movl	%eax, -40(%ebp)
	movb	-34(%ebp), %al
	movb	%al, -33(%ebp)
	movb	$-1, -34(%ebp)
	movl	-44(%ebp), %eax
	cmpl	$2, %eax
	je	L1350
	movl	-44(%ebp), %eax
	cmpl	$3, %eax
	je	L1350
	movl	-44(%ebp), %eax
	cmpl	$5, %eax
	je	L1350
	movl	-44(%ebp), %eax
	cmpl	$9, %eax
	jne	L1344
L1350:
	movb	-33(%ebp), %al
	movb	%al, -34(%ebp)
	movl	-40(%ebp), %eax
	decl	%eax
	movl	%eax, -40(%ebp)
	jmp	L1344
L1348:
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	testb	%al, %al
	jns	L1344
	movb	-34(%ebp), %al
	movb	%al, -33(%ebp)
	movl	-44(%ebp), %eax
	movl	%eax, -40(%ebp)
	movb	$-1, -34(%ebp)
	jmp	L1344
L1347:
	movb	-33(%ebp), %al
	cmpb	$7, %al
	ja	L1382
L1351:
	movl	-44(%ebp), %eax
	cmpl	$1, %eax
	jne	L1352
	movl	-40(%ebp), %eax
	cmpl	$1, %eax
	je	L1353
L1352:
	movl	-44(%ebp), %eax
	cmpl	$1, %eax
	je	L1354
	movl	-44(%ebp), %eax
	movl	%eax, -20(%ebp)
	movb	-34(%ebp), %al
	movb	%al, -9(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, -44(%ebp)
	movb	-33(%ebp), %al
	movb	%al, -34(%ebp)
	movl	-20(%ebp), %eax
	movl	%eax, -40(%ebp)
	movb	-9(%ebp), %al
	movb	%al, -33(%ebp)
L1354:
	movl	-44(%ebp), %eax
	cmpl	$1, %eax
	je	L1356
	jmp	L1338
L1353:
	movl	8(%ebp), %eax
	movb	12(%eax), %al
	testb	%al, %al
	jns	L1357
	movl	8(%ebp), %eax
	movb	13(%eax), %al
	testb	%al, %al
	js	L1357
	movb	-34(%ebp), %al
	movb	%al, -9(%ebp)
	movb	-33(%ebp), %al
	movb	%al, -34(%ebp)
	movb	-9(%ebp), %al
	movb	%al, -33(%ebp)
L1357:
	movl	16(%ebp), %eax
	movb	13(%eax), %al
	testb	%al, %al
	jle	L1358
	cmpb	$0, -21(%ebp)
	jne	L1358
	movb	-34(%ebp), %al
	cmpb	$5, %al
	jne	L1359
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	jne	L1359
	movl	8(%ebp), %eax
	movb	14(%eax), %al
	testb	%al, %al
	jne	L1359
	movb	-33(%ebp), %al
	movb	%al, -34(%ebp)
	movb	$5, -33(%ebp)
L1359:
	movl	$8, -20(%ebp)
	movb	-33(%ebp), %al
	cmpb	$4, %al
	je	L1360
	movb	-33(%ebp), %al
	cmpb	$5, %al
	jne	L1361
L1360:
	sarl	-20(%ebp)
L1361:
	movl	-28(%ebp), %eax
	cmpl	-20(%ebp), %eax
	jne	L1358
	movb	-34(%ebp), %al
	movb	%al, -9(%ebp)
	movb	-33(%ebp), %al
	movb	%al, -34(%ebp)
	movb	-9(%ebp), %al
	movb	%al, -33(%ebp)
L1358:
	movb	-33(%ebp), %al
	cmpb	$4, %al
	jne	L1356
	movb	-34(%ebp), %al
	movb	%al, -33(%ebp)
	movb	$4, -34(%ebp)
L1356:
	movb	-33(%ebp), %al
	cmpb	$4, %al
	jne	L1344
	jmp	L1338
L1345:
	movb	-34(%ebp), %al
	cmpb	$15, %al
	ja	L1338
	cmpl	$4, -20(%ebp)
	je	L1383
L1362:
	movl	-44(%ebp), %eax
	cmpl	$1, %eax
	jne	L1384
L1363:
	movb	-33(%ebp), %al
	cmpb	$-1, %al
	je	L1364
	movl	-40(%ebp), %eax
	cmpl	$1, %eax
	jne	L1385
L1364:
	movb	-34(%ebp), %al
	cmpb	$13, %al
	jbe	L1365
	movb	-34(%ebp), %al
	movb	%al, -9(%ebp)
	movb	-33(%ebp), %al
	movb	%al, -34(%ebp)
	movb	-9(%ebp), %al
	movb	%al, -33(%ebp)
L1365:
	movb	-34(%ebp), %al
	cmpb	$11, %al
	je	L1366
	movb	-34(%ebp), %al
	cmpb	$13, %al
	je	L1366
	movb	-34(%ebp), %al
	cmpb	$-1, %al
	jne	L1386
L1366:
	movb	-33(%ebp), %al
	cmpb	$14, %al
	je	L1367
	movb	-33(%ebp), %al
	cmpb	$15, %al
	je	L1367
	movb	-33(%ebp), %al
	cmpb	$-1, %al
	jne	L1387
L1367:
	orl	$16, -16(%ebp)
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	orl	$16777216, %edx
	movl	20(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L1344
L1378:
	nop
	jmp	L1338
L1380:
	nop
	jmp	L1338
L1381:
	nop
	jmp	L1338
L1382:
	nop
	jmp	L1338
L1383:
	nop
	jmp	L1338
L1384:
	nop
	jmp	L1338
L1385:
	nop
	jmp	L1338
L1386:
	nop
	jmp	L1338
L1387:
	nop
	jmp	L1338
L1388:
	nop
L1338:
	movl	$0, -16(%ebp)
	jmp	L1368
L1344:
	movb	-34(%ebp), %al
	cmpb	$-1, %al
	jne	L1369
	orl	$129, -16(%ebp)
	jmp	L1370
L1369:
	movb	-34(%ebp), %al
	andl	$7, %eax
	movb	%al, -34(%ebp)
	movb	-34(%ebp), %al
	movzbl	%al, %eax
	sall	$8, %eax
	orl	%eax, -16(%ebp)
	orl	$1, -16(%ebp)
	movb	-34(%ebp), %al
	cmpb	$4, %al
	jne	L1371
	xorl	$3, -16(%ebp)
L1371:
	movb	-34(%ebp), %al
	cmpb	$5, %al
	jne	L1370
	xorl	$3, -16(%ebp)
L1370:
	movb	-33(%ebp), %al
	cmpb	$-1, %al
	jne	L1372
	movb	$4, -33(%ebp)
	movl	$1, -40(%ebp)
L1372:
	movb	$0, -9(%ebp)
	movl	-16(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	L1373
	movb	$4, -9(%ebp)
	movl	-40(%ebp), %eax
	cmpl	$1, %eax
	jne	L1374
	movb	$0, -9(%ebp)
L1374:
	movl	-40(%ebp), %eax
	cmpl	$2, %eax
	jne	L1375
	movb	$1, -9(%ebp)
L1375:
	movl	-40(%ebp), %eax
	cmpl	$4, %eax
	jne	L1376
	movb	$2, -9(%ebp)
L1376:
	movl	-40(%ebp), %eax
	cmpl	$8, %eax
	jne	L1377
	movb	$3, -9(%ebp)
L1377:
	cmpb	$4, -9(%ebp)
	je	L1388
L1373:
	movzbl	-9(%ebp), %eax
	movl	%eax, %edx
	sall	$14, %edx
	movb	-33(%ebp), %al
	movzbl	%al, %eax
	andl	$7, %eax
	sall	$11, %eax
	orl	%edx, %eax
	orl	%eax, -16(%ebp)
L1368:
	movl	20(%ebp), %eax
	movl	(%eax), %eax
	movl	-28(%ebp), %edx
	sall	$5, %edx
	orl	%eax, %edx
	movl	20(%ebp), %eax
	movl	%edx, (%eax)
	movl	-16(%ebp), %eax
	addl	$68, %esp
	popl	%ebx
	leave
	ret
.globl _putmodrm
	.def	_putmodrm;	.scl	2;	.type	32;	.endef
_putmodrm:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movb	$-128, -10(%ebp)
	movl	12(%ebp), %eax
	sarl	$8, %eax
	movb	%al, -12(%ebp)
	movl	12(%ebp), %eax
	andl	$-128, %eax
	movb	%al, -13(%ebp)
	movl	8(%ebp), %eax
	movb	$1, 12(%eax)
	movl	8(%ebp), %eax
	movb	$0, 13(%eax)
	movl	8(%ebp), %eax
	movb	$0, 14(%eax)
	andl	$7, 24(%ebp)
	sall	$3, 24(%ebp)
	movl	16(%ebp), %eax
	andl	$48, %eax
	testl	%eax, %eax
	jne	L1390
	movl	24(%ebp), %eax
	movl	%eax, %edx
	orb	$-64, %dl
	movl	16(%ebp), %eax
	sarl	$9, %eax
	andl	$7, %eax
	orl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 24(%eax)
	jmp	L1389
L1390:
	movl	16(%ebp), %eax
	sarl	$9, %eax
	andl	$7, %eax
	movb	%al, -9(%ebp)
	movb	$-126, -11(%ebp)
	movl	12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L1392
	movl	12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L1393
	movb	$2, -9(%ebp)
	jmp	L1394
L1393:
	movzbl	-12(%ebp), %eax
	andl	$63, %eax
	cmpl	$37, %eax
	jne	L1394
	movb	$2, -11(%ebp)
	jmp	L1394
L1392:
	movb	$-118, -11(%ebp)
	movl	12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	L1395
	cmpb	$0, -13(%ebp)
	je	L1396
L1395:
	movb	$4, -9(%ebp)
	jmp	L1394
L1396:
	movzbl	-12(%ebp), %eax
	andl	$7, %eax
	cmpl	$5, %eax
	jne	L1394
	movb	$10, -11(%ebp)
L1394:
	movzbl	-11(%ebp), %eax
	movl	%eax, _mcode.2418
	movl	12(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L1397
	jmp	L1398
L1406:
	nop
L1398:
	andb	$-8, -12(%ebp)
	orb	$5, -12(%ebp)
	movb	$0, -10(%ebp)
	jmp	L1399
L1397:
	movl	12(%ebp), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	L1399
	cmpb	$0, -13(%ebp)
	jne	L1406
L1399:
	movb	$0, -11(%ebp)
	movl	12(%ebp), %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L1400
	movzbl	-12(%ebp), %eax
	andl	$56, %eax
	cmpl	$32, %eax
	je	L1401
	cmpb	$0, -13(%ebp)
	jne	L1402
	movzbl	-12(%ebp), %eax
	andl	$7, %eax
	cmpl	$5, %eax
	jne	L1403
	orb	$2, -11(%ebp)
	jmp	L1403
L1402:
	orb	$4, -11(%ebp)
L1403:
	movzbl	-12(%ebp), %eax
	andl	$56, %eax
	cmpl	$56, %eax
	jne	L1404
	orb	$1, -11(%ebp)
	jmp	L1404
L1401:
	orb	$6, -11(%ebp)
	movzbl	-12(%ebp), %eax
	andl	$7, %eax
	cmpl	$3, %eax
	jne	L1404
	orb	$1, -11(%ebp)
	jmp	L1404
L1400:
	movzbl	-12(%ebp), %eax
	andl	$56, %eax
	cmpl	$32, %eax
	jne	L1405
	movzbl	-12(%ebp), %eax
	andl	$7, %eax
	cmpl	$4, %eax
	je	L1405
	movb	-12(%ebp), %al
	movb	%al, %dl
	andl	$7, %edx
	movb	-11(%ebp), %al
	orl	%edx, %eax
	movb	%al, -11(%ebp)
	jmp	L1404
L1405:
	movl	8(%ebp), %eax
	movb	$1, 13(%eax)
	movzbl	-12(%ebp), %edx
	movl	8(%ebp), %eax
	movl	%edx, 28(%eax)
	orb	$4, -11(%ebp)
L1404:
	movl	24(%ebp), %eax
	movb	%al, %dl
	movb	-11(%ebp), %al
	orl	%edx, %eax
	movb	%al, -11(%ebp)
	movb	-10(%ebp), %al
	movb	-11(%ebp), %dl
	orl	%edx, %eax
	movzbl	%al, %eax
	movl	%eax, _mcode.2418+8
	movb	-11(%ebp), %al
	orl	$64, %eax
	movzbl	%al, %eax
	movl	%eax, _mcode.2418+16
	movzbl	-11(%ebp), %eax
	movl	%eax, _mcode.2418+24
	movb	-9(%ebp), %al
	movsbl	%al, %edx
	movl	20(%ebp), %eax
	movl	68(%eax), %eax
	movl	%edx, 12(%esp)
	movl	$_mcode.2418, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_microcode90
	testl	%eax, %eax
	je	L1389
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movb	$-27, (%eax)
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
L1391:
L1389:
	leave
	ret
	.data
_dsiz2mc98:
	.byte	1
	.byte	3
	.byte	0
	.byte	5
	.text
.globl _microcode90
	.def	_microcode90;	.scl	2;	.type	32;	.endef
_microcode90:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$88, %esp
	movl	20(%ebp), %eax
	movb	%al, -60(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movb	%al, -21(%ebp)
	movzbl	-21(%ebp), %eax
	andl	$7, %eax
	movl	%eax, -16(%ebp)
	movb	-21(%ebp), %al
	shrb	$4, %al
	movzbl	%al, %eax
	andl	$7, %eax
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
	movl	$0, 8(%esp)
	leal	12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-44(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_ofsexpr
	movb	-29(%ebp), %al
	testb	%al, %al
	je	L1408
	jmp	L1409
L1440:
	nop
L1409:
	movl	$2, %eax
	jmp	L1410
L1408:
	cmpb	$2, -60(%ebp)
	jne	L1411
	movzbl	-21(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	L1412
L1411:
	cmpb	$4, -60(%ebp)
	jne	L1413
	movzbl	-21(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L1412
L1413:
	cmpb	$0, -60(%ebp)
	jne	L1414
	movb	-21(%ebp), %al
	testb	%al, %al
	js	L1414
L1412:
	movl	$3, %eax
	jmp	L1410
L1414:
	movb	-30(%ebp), %al
	testb	%al, %al
	je	L1415
	cmpb	$4, -60(%ebp)
	jg	L1416
	movb	-60(%ebp), %al
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	%al, 12(%edx)
	cmpb	$0, -60(%ebp)
	je	L1439
	movsbl	-60(%ebp), %eax
	decl	%eax
	addl	$_dsiz2mc98, %eax
	movb	(%eax), %al
	movzbl	%al, %ecx
	movl	-16(%ebp), %eax
	movzbl	%al, %edx
	movl	-48(%ebp), %eax
	movl	%ecx, 12(%esp)
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L1440
L1418:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
	jmp	L1419
L1416:
	movl	-20(%ebp), %eax
	movb	$-112, (%eax)
	movl	-20(%ebp), %eax
	incl	%eax
	movb	$15, (%eax)
	movl	-20(%ebp), %eax
	addl	$2, %eax
	movb	$0, (%eax)
	movl	-20(%ebp), %eax
	leal	3(%eax), %edx
	movb	-21(%ebp), %al
	movb	%al, (%edx)
	movl	-20(%ebp), %eax
	leal	4(%eax), %edx
	leal	-48(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_put_expr
	movl	%eax, -20(%ebp)
	movb	$3, -9(%ebp)
	addl	$4, 16(%ebp)
	movl	8(%ebp), %edx
	movl	-16(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	$127, 12(%eax)
	movl	8(%ebp), %edx
	movl	-28(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	$127, 12(%eax)
L1424:
	cmpb	$1, -9(%ebp)
	jne	L1420
	movb	-21(%ebp), %al
	testb	%al, %al
	jns	L1441
L1420:
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movb	%al, -10(%ebp)
	movb	-10(%ebp), %al
	movb	%al, %dl
	orl	$48, %edx
	movl	-20(%ebp), %eax
	movb	%dl, (%eax)
	incl	-20(%ebp)
	movl	16(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	jmp	L1422
L1423:
	movl	-16(%ebp), %eax
	movb	%al, %dl
	movl	-20(%ebp), %eax
	movb	%dl, (%eax)
	incl	-20(%ebp)
	sarl	$8, -16(%ebp)
	decb	-10(%ebp)
	addl	$8, 16(%ebp)
L1422:
	cmpb	$0, -10(%ebp)
	jne	L1423
	jmp	L1421
L1441:
	nop
L1421:
	decb	-9(%ebp)
	cmpb	$0, -9(%ebp)
	jne	L1424
	jmp	L1425
L1415:
	movl	-36(%ebp), %edx
	movl	8(%ebp), %eax
	movl	-16(%ebp), %ecx
	addl	$4, %ecx
	movl	%edx, 8(%eax,%ecx,4)
	cmpb	$2, -60(%ebp)
	jne	L1426
	movzbl	-21(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	L1427
L1426:
	cmpb	$4, -60(%ebp)
	jne	L1428
	movzbl	-21(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L1427
L1428:
	cmpb	$0, -60(%ebp)
	jne	L1429
	movb	-21(%ebp), %al
	testb	%al, %al
	js	L1429
L1427:
	movl	$3, %eax
	jmp	L1410
L1429:
	cmpb	$0, -60(%ebp)
	jne	L1430
	movl	-36(%ebp), %eax
	testl	%eax, %eax
	jne	L1431
L1430:
	cmpb	$1, -60(%ebp)
	jne	L1432
	movl	-36(%ebp), %eax
	cmpl	$-128, %eax
	jl	L1431
	movl	-36(%ebp), %eax
	cmpl	$127, %eax
	jg	L1431
L1432:
	cmpb	$2, -60(%ebp)
	jne	L1433
	movl	-36(%ebp), %eax
	cmpl	$-65536, %eax
	jl	L1431
	movl	-36(%ebp), %eax
	cmpl	$65535, %eax
	jle	L1433
L1431:
	movl	-20(%ebp), %eax
	movb	$-24, (%eax)
	incl	-20(%ebp)
L1433:
	cmpb	$4, -60(%ebp)
	jle	L1434
	movb	$2, -60(%ebp)
	movzbl	-21(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L1435
	movb	$4, -60(%ebp)
L1435:
	movl	-36(%ebp), %eax
	cmpl	$-128, %eax
	jl	L1436
	movl	-36(%ebp), %eax
	cmpl	$127, %eax
	jg	L1436
	movb	$1, -60(%ebp)
L1436:
	movb	-21(%ebp), %al
	testb	%al, %al
	jns	L1434
	movl	-36(%ebp), %eax
	testl	%eax, %eax
	jne	L1434
	movb	$0, -60(%ebp)
L1434:
	movb	-60(%ebp), %al
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	%al, 12(%edx)
	jmp	L1419
L1439:
	nop
L1419:
	movb	$1, -9(%ebp)
	cmpb	$1, -60(%ebp)
	jne	L1437
	movb	$3, -9(%ebp)
L1437:
	cmpb	$0, -60(%ebp)
	jne	L1438
	movb	$5, -9(%ebp)
L1438:
	movzbl	-9(%ebp), %eax
	sall	$2, %eax
	addl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	8(%ebp), %ecx
	movl	-28(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	%al, 12(%edx)
	movzbl	-9(%ebp), %eax
	incl	%eax
	sall	$2, %eax
	addl	16(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	-28(%ebp), %ecx
	addl	$4, %ecx
	movl	%edx, 8(%eax,%ecx,4)
L1425:
	movl	8(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	%edx, (%eax)
	movl	$0, %eax
L1410:
	leave
	ret
.globl _microcode91
	.def	_microcode91;	.scl	2;	.type	32;	.endef
_microcode91:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$88, %esp
	movl	20(%ebp), %eax
	movb	%al, -60(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movb	%al, -21(%ebp)
	movzbl	-21(%ebp), %eax
	andl	$7, %eax
	movl	%eax, -16(%ebp)
	movb	-21(%ebp), %al
	shrb	$4, %al
	movzbl	%al, %eax
	andl	$7, %eax
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
	movl	$0, 8(%esp)
	leal	12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-44(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_ofsexpr
	movb	-29(%ebp), %al
	testb	%al, %al
	je	L1443
	jmp	L1444
L1472:
	nop
L1444:
	movl	$2, %eax
	jmp	L1445
L1443:
	cmpb	$2, -60(%ebp)
	jne	L1446
	movzbl	-21(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	jne	L1447
L1446:
	cmpb	$4, -60(%ebp)
	jne	L1448
	movzbl	-21(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L1447
L1448:
	cmpb	$0, -60(%ebp)
	jne	L1449
	movb	-21(%ebp), %al
	testb	%al, %al
	js	L1449
L1447:
	movl	$3, %eax
	jmp	L1445
L1449:
	movb	-30(%ebp), %al
	testb	%al, %al
	je	L1450
	cmpb	$4, -60(%ebp)
	jg	L1451
	movb	-60(%ebp), %al
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	%al, 12(%edx)
	cmpb	$0, -60(%ebp)
	je	L1471
	movsbl	-60(%ebp), %eax
	decl	%eax
	addl	$_dsiz2mc98, %eax
	movb	(%eax), %al
	movzbl	%al, %ecx
	movl	-16(%ebp), %eax
	movzbl	%al, %edx
	movl	-48(%ebp), %eax
	movl	%ecx, 12(%esp)
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_defnumexpr
	testl	%eax, %eax
	jne	L1472
L1453:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
	jmp	L1454
L1451:
	movl	-20(%ebp), %eax
	movb	$-111, (%eax)
	movl	-20(%ebp), %eax
	incl	%eax
	movb	$15, (%eax)
	movl	-20(%ebp), %eax
	addl	$2, %eax
	movb	$0, (%eax)
	movl	-20(%ebp), %eax
	leal	3(%eax), %edx
	movb	-21(%ebp), %al
	movb	%al, (%edx)
	movl	-20(%ebp), %eax
	leal	4(%eax), %edx
	leal	-48(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_put_expr
	movl	%eax, -20(%ebp)
	movb	$3, -9(%ebp)
	addl	$4, 16(%ebp)
	movl	8(%ebp), %edx
	movl	-16(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	$127, 12(%eax)
	movl	8(%ebp), %edx
	movl	-28(%ebp), %eax
	leal	(%edx,%eax), %eax
	movb	$127, 12(%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	movb	$127, 12(%eax,%edx)
L1460:
	cmpb	$1, -9(%ebp)
	jne	L1455
	movb	-21(%ebp), %al
	testb	%al, %al
	jns	L1473
L1455:
	movb	$2, -11(%ebp)
L1459:
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movb	%al, -10(%ebp)
	movb	-10(%ebp), %al
	movb	%al, %dl
	orl	$48, %edx
	movl	-20(%ebp), %eax
	movb	%dl, (%eax)
	incl	-20(%ebp)
	movl	16(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	jmp	L1457
L1458:
	movl	-16(%ebp), %eax
	movb	%al, %dl
	movl	-20(%ebp), %eax
	movb	%dl, (%eax)
	incl	-20(%ebp)
	sarl	$8, -16(%ebp)
	decb	-10(%ebp)
L1457:
	cmpb	$0, -10(%ebp)
	jne	L1458
	addl	$8, 16(%ebp)
	decb	-11(%ebp)
	cmpb	$0, -11(%ebp)
	jne	L1459
	jmp	L1456
L1473:
	nop
L1456:
	decb	-9(%ebp)
	cmpb	$0, -9(%ebp)
	jne	L1460
	jmp	L1461
L1450:
	movl	-36(%ebp), %edx
	movl	8(%ebp), %eax
	movl	-16(%ebp), %ecx
	addl	$4, %ecx
	movl	%edx, 8(%eax,%ecx,4)
	cmpb	$0, -60(%ebp)
	jne	L1462
	movl	-36(%ebp), %eax
	testl	%eax, %eax
	jne	L1463
L1462:
	cmpb	$1, -60(%ebp)
	jne	L1464
	movl	-36(%ebp), %eax
	cmpl	$-128, %eax
	jl	L1463
	movl	-36(%ebp), %eax
	cmpl	$127, %eax
	jg	L1463
L1464:
	cmpb	$2, -60(%ebp)
	jne	L1465
	movl	-36(%ebp), %eax
	cmpl	$-65536, %eax
	jl	L1463
	movl	-36(%ebp), %eax
	cmpl	$65535, %eax
	jle	L1465
L1463:
	movl	-20(%ebp), %eax
	movb	$-24, (%eax)
	incl	-20(%ebp)
L1465:
	cmpb	$4, -60(%ebp)
	jle	L1466
	movb	$2, -60(%ebp)
	movzbl	-21(%ebp), %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L1467
	movb	$4, -60(%ebp)
L1467:
	movl	-36(%ebp), %eax
	cmpl	$-128, %eax
	jl	L1468
	movl	-36(%ebp), %eax
	cmpl	$127, %eax
	jg	L1468
	movb	$1, -60(%ebp)
L1468:
	movb	-21(%ebp), %al
	testb	%al, %al
	jns	L1466
	movl	-36(%ebp), %eax
	testl	%eax, %eax
	jne	L1466
	movb	$0, -60(%ebp)
L1466:
	movb	-60(%ebp), %al
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	%al, 12(%edx)
	jmp	L1454
L1471:
	nop
L1454:
	movb	$1, -9(%ebp)
	cmpb	$1, -60(%ebp)
	jne	L1469
	movb	$5, -9(%ebp)
L1469:
	cmpb	$0, -60(%ebp)
	jne	L1470
	movb	$9, -9(%ebp)
L1470:
	movzbl	-9(%ebp), %eax
	sall	$2, %eax
	addl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	8(%ebp), %ecx
	movl	-28(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	%al, 12(%edx)
	movzbl	-9(%ebp), %eax
	incl	%eax
	sall	$2, %eax
	addl	16(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	-28(%ebp), %ecx
	addl	$4, %ecx
	movl	%edx, 8(%eax,%ecx,4)
	movl	-28(%ebp), %eax
	leal	1(%eax), %ecx
	movzbl	-9(%ebp), %eax
	addl	$2, %eax
	sall	$2, %eax
	addl	16(%ebp), %eax
	movl	(%eax), %eax
	movb	%al, %dl
	movl	8(%ebp), %eax
	movb	%dl, 12(%eax,%ecx)
	movl	-28(%ebp), %eax
	leal	1(%eax), %ecx
	movzbl	-9(%ebp), %eax
	addl	$3, %eax
	sall	$2, %eax
	addl	16(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	addl	$4, %ecx
	movl	%edx, 8(%eax,%ecx,4)
L1461:
	movl	8(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	%edx, (%eax)
	movl	$0, %eax
L1445:
	leave
	ret
	.data
_mc98_typ:
	.byte	1
	.byte	65
	.byte	2
	.byte	98
	.byte	4
	.byte	100
	.byte	97
	.align 4
_mc98_min:
	.long	0
	.long	-128
	.long	0
	.long	-65536
	.long	-2147483648
	.long	-2147483648
	.long	-256
	.align 4
_mc98_max:
	.long	255
	.long	127
	.long	65535
	.long	65535
	.long	2147483647
	.long	2147483647
	.long	255
	.text
.globl _microcode94
	.def	_microcode94;	.scl	2;	.type	32;	.endef
_microcode94:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$72, %esp
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	sarl	$8, %eax
	movl	%eax, -20(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, -48(%ebp)
	movl	-12(%ebp), %eax
	sarl	$4, %eax
	movl	%eax, -44(%ebp)
	movl	$0, 8(%esp)
	leal	12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_ofsexpr
	movb	-25(%ebp), %al
	testb	%al, %al
	je	L1475
	jmp	L1476
L1485:
	nop
L1476:
	movl	$1, %eax
	jmp	L1477
L1475:
	movb	-26(%ebp), %al
	testb	%al, %al
	jne	L1485
L1478:
	movb	$0, -13(%ebp)
	movl	$5, -12(%ebp)
L1480:
	movl	-12(%ebp), %eax
	sall	$2, %eax
	addl	16(%ebp), %eax
	movl	(%eax), %edx
	movl	-32(%ebp), %eax
	cmpl	%eax, %edx
	jne	L1479
	movl	-12(%ebp), %eax
	movb	%al, -13(%ebp)
L1479:
	addl	$5, -12(%ebp)
	decl	-20(%ebp)
	cmpl	$0, -20(%ebp)
	jne	L1480
	movzbl	-13(%ebp), %eax
	incl	%eax
	sall	$2, %eax
	addl	%eax, 16(%ebp)
	movl	$0, -20(%ebp)
	jmp	L1481
L1484:
	movl	-20(%ebp), %eax
	movl	-48(%ebp,%eax,4), %eax
	andl	$15, %eax
	movl	%eax, -12(%ebp)
	cmpl	$7, -12(%ebp)
	jg	L1482
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	movb	%al, %dl
	andl	$7, %edx
	movl	8(%ebp), %ecx
	movl	-12(%ebp), %eax
	leal	(%ecx,%eax), %eax
	movb	%dl, 12(%eax)
	movl	16(%ebp), %eax
	addl	$4, %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	-12(%ebp), %ecx
	addl	$4, %ecx
	movl	%edx, 8(%eax,%ecx,4)
	movl	16(%ebp), %eax
	movl	(%eax), %eax
	subl	$152, %eax
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	js	L1482
	movl	-24(%ebp), %eax
	addl	$_mc98_typ, %eax
	movb	(%eax), %al
	movl	8(%ebp), %ecx
	movl	-12(%ebp), %edx
	leal	(%ecx,%edx), %edx
	movb	%al, 12(%edx)
	movl	-32(%ebp), %edx
	movl	8(%ebp), %eax
	movl	-12(%ebp), %ecx
	addl	$4, %ecx
	movl	%edx, 8(%eax,%ecx,4)
	movl	-32(%ebp), %edx
	movl	-24(%ebp), %eax
	movl	_mc98_min(,%eax,4), %eax
	cmpl	%eax, %edx
	jl	L1483
	movl	-24(%ebp), %eax
	movl	_mc98_max(,%eax,4), %edx
	movl	-32(%ebp), %eax
	cmpl	%eax, %edx
	jge	L1482
L1483:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movb	$-24, (%eax)
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
L1482:
	addl	$8, 16(%ebp)
	incl	-20(%ebp)
L1481:
	cmpl	$1, -20(%ebp)
	jle	L1484
	movl	$0, %eax
L1477:
	leave
	ret
.globl _defnumexpr
	.def	_defnumexpr;	.scl	2;	.type	32;	.endef
_defnumexpr:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$68, %esp
	movl	16(%ebp), %edx
	movl	20(%ebp), %eax
	movb	%dl, -44(%ebp)
	movb	%al, -48(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	$0, 8(%esp)
	leal	12(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_ofsexpr
	andb	$7, -44(%ebp)
	andb	$7, -48(%ebp)
	movb	-13(%ebp), %al
	testb	%al, %al
	je	L1487
	movl	$1, %eax
	jmp	L1488
L1487:
	movzbl	-44(%ebp), %eax
	movzbl	-48(%ebp), %edx
	movb	_mc98_typ(%edx), %dl
	movb	%dl, %cl
	movl	8(%ebp), %edx
	movb	%cl, 12(%edx,%eax)
	movb	-14(%ebp), %al
	testb	%al, %al
	je	L1489
	movzbl	-44(%ebp), %eax
	movzbl	-44(%ebp), %edx
	movl	8(%ebp), %ecx
	movb	12(%ecx,%edx), %dl
	movb	%dl, %cl
	orl	$-128, %ecx
	movl	8(%ebp), %edx
	movb	%cl, 12(%edx,%eax)
	movl	-12(%ebp), %eax
	movl	%eax, 12(%ebp)
	movzbl	-44(%ebp), %ebx
	movzbl	-44(%ebp), %edx
	movl	8(%ebp), %eax
	addl	$16, %edx
	movl	8(%eax,%edx,4), %eax
	leal	12(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_put_expr
	movl	%eax, %edx
	movzbl	-44(%ebp), %ecx
	movl	8(%ebp), %eax
	addl	$16, %ecx
	movl	8(%eax,%ecx,4), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	8(%ebp), %eax
	leal	4(%ebx), %edx
	movl	%ecx, 8(%eax,%edx,4)
	movl	$0, %eax
	jmp	L1488
L1489:
	movzbl	-44(%ebp), %ecx
	movl	-20(%ebp), %edx
	movl	8(%ebp), %eax
	addl	$4, %ecx
	movl	%edx, 8(%eax,%ecx,4)
	movl	-20(%ebp), %edx
	movzbl	-48(%ebp), %eax
	movl	_mc98_min(,%eax,4), %eax
	cmpl	%eax, %edx
	jl	L1490
	movzbl	-48(%ebp), %eax
	movl	_mc98_max(,%eax,4), %edx
	movl	-20(%ebp), %eax
	cmpl	%eax, %edx
	jge	L1491
L1490:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movb	$-24, (%eax)
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
L1491:
	movl	$0, %eax
L1488:
	addl	$68, %esp
	popl	%ebx
	leave
	ret
.globl _getparam0
	.def	_getparam0;	.scl	2;	.type	32;	.endef
_getparam0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$48, %esp
	movl	12(%ebp), %eax
	leal	16(%eax), %esi
	movl	12(%ebp), %eax
	leal	48(%eax), %ebx
	movl	12(%ebp), %eax
	movl	68(%eax), %ecx
	movl	12(%ebp), %eax
	movl	64(%eax), %edx
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%esi, 24(%esp)
	movl	%ebx, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	leal	-12(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	leal	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_getparam
	addl	$48, %esp
	popl	%ebx
	popl	%esi
	leave
	ret
.globl _getconst
	.def	_getconst;	.scl	2;	.type	32;	.endef
_getconst:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$48, %esp
	movl	12(%ebp), %eax
	leal	16(%eax), %esi
	movl	12(%ebp), %eax
	leal	48(%eax), %ebx
	movl	12(%ebp), %eax
	movl	68(%eax), %ecx
	movl	12(%ebp), %eax
	movl	64(%eax), %edx
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%esi, 24(%esp)
	movl	%ebx, 20(%esp)
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	movl	16(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_getparam
	movl	%eax, -12(%ebp)
	cmpl	$47, -12(%ebp)
	setne	%al
	movzbl	%al, %eax
	addl	$48, %esp
	popl	%ebx
	popl	%esi
	leave
	ret
.globl _testmem0
	.def	_testmem0;	.scl	2;	.type	32;	.endef
_testmem0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	leal	48(%eax), %edx
	movl	16(%ebp), %eax
	movl	%eax, 12(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_testmem
	leave
	ret
.globl _label2id
	.def	_label2id;	.scl	2;	.type	32;	.endef
_label2id:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	movl	12(%ebp), %eax
	movb	(%eax), %al
	cmpb	$46, %al
	jne	L1496
	cmpl	$1, 8(%ebp)
	jle	L1497
	movl	12(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	cmpb	$46, %al
	jne	L1498
L1497:
	cmpl	$1, 8(%ebp)
	jne	L1496
L1498:
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	_locallabelbuf, %eax
	movl	%eax, %edx
	movl	_locallabelbuf0, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, 8(%ebp)
L1499:
	decl	-4(%ebp)
	movl	_locallabelbuf, %edx
	movl	-4(%ebp), %eax
	addl	%eax, %edx
	movl	-4(%ebp), %eax
	addl	12(%ebp), %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	cmpl	$0, -4(%ebp)
	jg	L1499
	movl	_locallabelbuf0, %eax
	movl	%eax, 12(%ebp)
L1496:
	movl	_labelbuf0, %eax
	movl	%eax, -8(%ebp)
	jmp	L1500
L1505:
	addl	$5, -8(%ebp)
	movl	-8(%ebp), %eax
	decl	%eax
	movb	(%eax), %al
	movzbl	%al, %eax
	cmpl	8(%ebp), %eax
	jne	L1509
L1501:
	movb	$0, -9(%ebp)
	movl	8(%ebp), %eax
	decl	%eax
	movl	%eax, -4(%ebp)
L1503:
	movl	-4(%ebp), %eax
	addl	12(%ebp), %eax
	movb	(%eax), %dl
	movl	-4(%ebp), %eax
	addl	-8(%ebp), %eax
	movb	(%eax), %al
	xorl	%edx, %eax
	orb	%al, -9(%ebp)
	decl	-4(%ebp)
	cmpl	$0, -4(%ebp)
	jns	L1503
	cmpb	$0, -9(%ebp)
	je	L1510
	jmp	L1502
L1509:
	nop
L1502:
	movl	-8(%ebp), %eax
	decl	%eax
	movb	(%eax), %al
	movzbl	%al, %eax
	addl	%eax, -8(%ebp)
L1500:
	movl	_labelbuf, %eax
	cmpl	%eax, -8(%ebp)
	jb	L1505
	cmpl	$0, 16(%ebp)
	je	L1506
	movl	_extlabelnext.2523, %eax
	movl	%eax, -4(%ebp)
	incl	%eax
	movl	%eax, _extlabelnext.2523
	jmp	L1507
L1506:
	movl	_nextlabelid, %eax
	movl	%eax, -4(%ebp)
	incl	%eax
	movl	%eax, _nextlabelid
L1507:
	movl	-4(%ebp), %eax
	movb	%al, %dl
	movl	-8(%ebp), %eax
	movb	%dl, (%eax)
	movl	-8(%ebp), %eax
	leal	1(%eax), %edx
	movl	-4(%ebp), %eax
	sarl	$8, %eax
	movb	%al, (%edx)
	movl	-8(%ebp), %eax
	leal	2(%eax), %edx
	movl	-4(%ebp), %eax
	sarl	$16, %eax
	movb	%al, (%edx)
	movl	-8(%ebp), %eax
	leal	3(%eax), %edx
	movl	-4(%ebp), %eax
	shrl	$24, %eax
	movb	%al, (%edx)
	movl	-8(%ebp), %eax
	leal	4(%eax), %edx
	movl	8(%ebp), %eax
	movb	%al, (%edx)
	addl	$5, -8(%ebp)
	movl	8(%ebp), %eax
	decl	%eax
	movl	%eax, -4(%ebp)
L1508:
	movl	-4(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	-4(%ebp), %edx
	addl	12(%ebp), %edx
	movb	(%edx), %dl
	movb	%dl, (%eax)
	decl	-4(%ebp)
	cmpl	$0, -4(%ebp)
	jns	L1508
	movl	8(%ebp), %eax
	addl	-8(%ebp), %eax
	movl	%eax, _labelbuf
	jmp	L1504
L1510:
	nop
L1504:
	movl	-8(%ebp), %eax
	subl	$5, %eax
	movl	%eax, (%esp)
	call	_get4b
	leave
	ret
.globl _id2label
	.def	_id2label;	.scl	2;	.type	32;	.endef
_id2label:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$20, %esp
	movl	_labelbuf0, %eax
	movl	%eax, -4(%ebp)
	jmp	L1512
L1515:
	movl	-4(%ebp), %eax
	movl	%eax, (%esp)
	call	_get4b
	movl	%eax, -8(%ebp)
	addl	$4, -4(%ebp)
	movl	-8(%ebp), %eax
	cmpl	8(%ebp), %eax
	je	L1516
L1513:
	movl	-4(%ebp), %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	incl	%eax
	addl	%eax, -4(%ebp)
L1512:
	movl	_labelbuf, %eax
	cmpl	%eax, -4(%ebp)
	jb	L1515
	movl	$0, -4(%ebp)
	jmp	L1514
L1516:
	nop
L1514:
	movl	-4(%ebp), %eax
	leave
	ret
.globl _put_expr
	.def	_put_expr;	.scl	2;	.type	32;	.endef
_put_expr:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -24(%ebp)
	jmp	L1518
L1532:
	nop
L1518:
	movl	-24(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
	movl	-24(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	-24(%ebp), %eax
	addl	$8, %eax
	movl	%eax, -24(%ebp)
	movl	-20(%ebp), %eax
	cmpl	$1, %eax
	je	L1521
	cmpl	$1, %eax
	jg	L1524
	testl	%eax, %eax
	je	L1520
	jmp	L1519
L1524:
	cmpl	$2, %eax
	je	L1522
	cmpl	$3, %eax
	je	L1523
	jmp	L1519
L1520:
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_putimm
	movl	%eax, 8(%ebp)
	jmp	L1519
L1521:
	cmpl	$0, -12(%ebp)
	je	L1532
L1525:
	movl	-12(%ebp), %eax
	addl	$_ll_ope_list.2548, %eax
	movb	(%eax), %al
	movb	%al, %dl
	movl	8(%ebp), %eax
	movb	%dl, (%eax)
	incl	8(%ebp)
	leal	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_put_expr
	movl	%eax, 8(%ebp)
	cmpl	$3, -12(%ebp)
	jle	L1533
	leal	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_put_expr
	movl	%eax, 8(%ebp)
	jmp	L1519
L1522:
	movl	8(%ebp), %eax
	movb	$0, (%eax)
	movl	8(%ebp), %eax
	incl	%eax
	movb	$0, (%eax)
	addl	$2, 8(%ebp)
	jmp	L1519
L1523:
	movb	$11, -13(%ebp)
	cmpl	$255, -12(%ebp)
	jg	L1527
	movb	$8, -13(%ebp)
	jmp	L1528
L1527:
	cmpl	$65535, -12(%ebp)
	jg	L1529
	movb	$9, -13(%ebp)
	jmp	L1528
L1529:
	cmpl	$16777215, -12(%ebp)
	jg	L1528
	movb	$10, -13(%ebp)
L1528:
	movl	8(%ebp), %eax
	movb	-13(%ebp), %dl
	movb	%dl, (%eax)
	movl	8(%ebp), %eax
	leal	1(%eax), %edx
	movl	-12(%ebp), %eax
	movb	%al, (%edx)
	addl	$2, 8(%ebp)
	andb	$3, -13(%ebp)
	jmp	L1530
L1531:
	sarl	$8, -12(%ebp)
	decb	-13(%ebp)
	movl	-12(%ebp), %eax
	movb	%al, %dl
	movl	8(%ebp), %eax
	movb	%dl, (%eax)
	incl	8(%ebp)
L1530:
	cmpb	$0, -13(%ebp)
	jne	L1531
	jmp	L1519
L1533:
	nop
L1519:
	movl	-24(%ebp), %edx
	movl	12(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	leave
	ret
	.def	_skip_expr;	.scl	3;	.type	32;	.endef
_skip_expr:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$1, %eax
	sete	%al
	addl	$8, 8(%ebp)
	testb	%al, %al
	je	L1535
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 8(%ebp)
	cmpl	$3, -12(%ebp)
	jle	L1535
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 8(%ebp)
L1535:
	movl	8(%ebp), %eax
	leave
	ret
.globl _rel_expr
	.def	_rel_expr;	.scl	2;	.type	32;	.endef
_rel_expr:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	%eax, -12(%ebp)
L1537:
	movl	-12(%ebp), %eax
	subl	$8, %eax
	movl	-12(%ebp), %ecx
	movl	4(%eax), %edx
	movl	(%eax), %eax
	movl	%eax, (%ecx)
	movl	%edx, 4(%ecx)
	subl	$8, -12(%ebp)
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	jne	L1537
	movl	8(%ebp), %eax
	movl	$1, (%eax)
	movl	8(%ebp), %eax
	movl	$5, 4(%eax)
	movl	12(%ebp), %eax
	movl	24(%eax), %eax
	cmpl	$-1, %eax
	jne	L1538
	movl	_nextlabelid, %eax
	movl	%eax, %ecx
	movl	12(%ebp), %edx
	movl	%ecx, 24(%edx)
	incl	%eax
	movl	%eax, _nextlabelid
L1538:
	movl	-16(%ebp), %eax
	addl	$8, %eax
	movl	$3, (%eax)
	movl	-16(%ebp), %eax
	leal	8(%eax), %edx
	movl	12(%ebp), %eax
	movl	24(%eax), %eax
	movl	%eax, 4(%edx)
	movl	-16(%ebp), %eax
	addl	$16, %eax
	leave
	ret
	.def	_setdec;	.scl	3;	.type	32;	.endef
_setdec:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4, %esp
	movl	12(%ebp), %eax
	addl	%eax, 16(%ebp)
L1542:
	decl	16(%ebp)
	movl	8(%ebp), %eax
	movl	$10, %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	leal	48(%eax), %edx
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	decl	12(%ebp)
	cmpl	$0, 12(%ebp)
	je	L1543
L1540:
	movl	8(%ebp), %eax
	movl	%eax, -4(%ebp)
	movl	$-858993459, %edx
	movl	-4(%ebp), %eax
	mull	%edx
	movl	%edx, %eax
	shrl	$3, %eax
	movl	%eax, 8(%ebp)
	cmpl	$0, 8(%ebp)
	jne	L1542
	jmp	L1541
L1543:
	nop
L1541:
	decl	16(%ebp)
	movl	16(%ebp), %eax
	movb	$32, (%eax)
	decl	12(%ebp)
	cmpl	$0, 12(%ebp)
	jne	L1541
	leave
	ret
	.section .rdata,"dr"
LC17:
	.ascii "0123456789ABCDEF\0"
	.text
	.def	_sethex0;	.scl	3;	.type	32;	.endef
_sethex0:
	pushl	%ebp
	movl	%esp, %ebp
	movl	12(%ebp), %eax
	addl	%eax, 16(%ebp)
L1545:
	decl	16(%ebp)
	movl	8(%ebp), %eax
	andl	$15, %eax
	movb	LC17(%eax), %al
	movb	%al, %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	shrl	$4, 8(%ebp)
	decl	12(%ebp)
	cmpl	$0, 12(%ebp)
	jne	L1545
	leave
	ret
	.data
_ll_ope_list.2548:
	.byte	0
	.byte	17
	.byte	18
	.byte	0
	.byte	19
	.byte	20
	.byte	21
	.byte	23
	.byte	24
	.byte	25
	.byte	26
	.byte	0
	.byte	29
	.byte	30
	.byte	31
	.byte	0
	.byte	22
	.byte	27
	.byte	28
	.byte	0
	.align 4
_extlabelnext.2523:
	.long	16
	.align 4
_mcode.2418:
	.long	130
	.long	1
	.long	128
	.long	1
	.long	64
	.long	1
	.long	0
	.align 32
_opelist0.2269:
	.ascii "|>"
	.byte	12
	.byte	18
	.ascii "&>"
	.byte	12
	.byte	17
	.ascii "<<"
	.byte	12
	.byte	16
	.ascii ">>"
	.byte	12
	.byte	17
	.ascii "//"
	.byte	14
	.byte	9
	.ascii "%%"
	.byte	14
	.byte	10
	.ascii "+\0"
	.byte	13
	.byte	4
	.ascii "-\0"
	.byte	13
	.byte	5
	.ascii "*\0"
	.byte	14
	.byte	6
	.ascii "/\0"
	.byte	14
	.byte	7
	.ascii "%\0"
	.byte	14
	.byte	8
	.ascii "^\0"
	.byte	7
	.byte	14
	.ascii "&\0"
	.byte	8
	.byte	12
	.ascii "|\0"
	.byte	6
	.byte	13
	.ascii "\0"
	.space 1
	.byte	0
	.byte	0
	.align 32
_opelist1.2270:
	.ascii "|>"
	.byte	12
	.byte	18
	.ascii "&>"
	.byte	12
	.byte	17
	.ascii "<<"
	.byte	12
	.byte	16
	.ascii ">>"
	.byte	12
	.byte	18
	.ascii "//"
	.byte	14
	.byte	7
	.ascii "%%"
	.byte	14
	.byte	8
	.ascii "+\0"
	.byte	13
	.byte	4
	.ascii "-\0"
	.byte	13
	.byte	5
	.ascii "*\0"
	.byte	14
	.byte	6
	.ascii "/\0"
	.byte	14
	.byte	9
	.ascii "%\0"
	.byte	14
	.byte	10
	.ascii "^\0"
	.byte	7
	.byte	14
	.ascii "&\0"
	.byte	8
	.byte	12
	.ascii "|\0"
	.byte	6
	.byte	13
	.ascii "\0"
	.space 1
	.byte	0
	.byte	0
_symbols.2264:
	.ascii "\"'+-*/%&|^(){}[]<>,;:\0"
	.align 32
_keywordlist.2276:
	.long	240
	.ascii "EAX\0"
	.space 4
	.ascii "ECX\0"
	.space 4
	.ascii "EDX\0"
	.space 4
	.ascii "EBX\0"
	.space 4
	.ascii "ESP\0"
	.space 4
	.ascii "EBP\0"
	.space 4
	.ascii "ESI\0"
	.space 4
	.ascii "EDI\0"
	.space 4
	.long	255
	.ascii "AX\0"
	.space 5
	.ascii "CX\0"
	.space 5
	.ascii "DX\0"
	.space 5
	.ascii "BX\0"
	.space 5
	.ascii "SP\0"
	.space 5
	.ascii "BP\0"
	.space 5
	.ascii "SI\0"
	.space 5
	.ascii "DI\0"
	.space 5
	.long	255
	.ascii "AL\0"
	.space 5
	.ascii "CL\0"
	.space 5
	.ascii "DL\0"
	.space 5
	.ascii "BL\0"
	.space 5
	.ascii "AH\0"
	.space 5
	.ascii "CH\0"
	.space 5
	.ascii "DH\0"
	.space 5
	.ascii "BH\0"
	.space 5
	.long	255
	.ascii "ES\0"
	.space 5
	.ascii "CS\0"
	.space 5
	.ascii "SS\0"
	.space 5
	.ascii "DS\0"
	.space 5
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.long	240
	.ascii "FS\0"
	.space 5
	.ascii "GS\0"
	.space 5
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.long	240
	.ascii "CR0\0"
	.space 4
	.ascii "CR1\0"
	.space 4
	.ascii "CR2\0"
	.space 4
	.ascii "CR3\0"
	.space 4
	.ascii "CR4\0"
	.space 4
	.ascii "CR5\0"
	.space 4
	.ascii "CR6\0"
	.space 4
	.ascii "CR7\0"
	.space 4
	.long	240
	.ascii "DR0\0"
	.space 4
	.ascii "DR1\0"
	.space 4
	.ascii "DR2\0"
	.space 4
	.ascii "DR3\0"
	.space 4
	.ascii "DR4\0"
	.space 4
	.ascii "DR5\0"
	.space 4
	.ascii "DR6\0"
	.space 4
	.ascii "DR7\0"
	.space 4
	.long	240
	.ascii "TR0\0"
	.space 4
	.ascii "TR1\0"
	.space 4
	.ascii "TR2\0"
	.space 4
	.ascii "TR3\0"
	.space 4
	.ascii "TR4\0"
	.space 4
	.ascii "TR5\0"
	.space 4
	.ascii "TR6\0"
	.space 4
	.ascii "DR7\0"
	.space 4
	.long	255
	.ascii "BYTE\0"
	.space 3
	.ascii "WORD\0"
	.space 3
	.ascii "SHORT\0"
	.space 2
	.ascii "NEAR\0"
	.space 3
	.ascii "FAR\0"
	.space 4
	.ascii "NOSPLIT\0"
	.ascii "$\0"
	.space 6
	.ascii "$$\0"
	.space 5
	.long	255
	.ascii "DWORD\0"
	.space 2
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "QWORD\0"
	.space 2
	.ascii "..$\0"
	.space 4
	.ascii "TWORD\0"
	.space 2
	.ascii "TO\0"
	.space 5
	.long	255
	.ascii "ST0\0"
	.space 4
	.ascii "ST1\0"
	.space 4
	.ascii "ST2\0"
	.space 4
	.ascii "ST3\0"
	.space 4
	.ascii "ST4\0"
	.space 4
	.ascii "ST5\0"
	.space 4
	.ascii "ST6\0"
	.space 4
	.ascii "ST7\0"
	.space 4
	.long	0
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
	.ascii "\0"
	.space 7
_code.2132:
	.byte	-13
	.byte	-14
	.byte	-16
	.byte	103
	.byte	102
	.byte	38
	.byte	46
	.byte	54
	.byte	62
	.byte	100
	.byte	101
	.align 32
_header.2035:
	.byte	76
	.byte	1
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	46
	.byte	116
	.byte	101
	.byte	120
	.byte	116
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	32
	.byte	0
	.byte	16
	.byte	96
	.byte	46
	.byte	100
	.byte	97
	.byte	116
	.byte	97
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.byte	0
	.byte	16
	.byte	-64
	.byte	46
	.byte	98
	.byte	115
	.byte	115
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-128
	.byte	0
	.byte	16
	.byte	-64
_common_symbols0.2049:
	.byte	46
	.byte	102
	.byte	105
	.byte	108
	.byte	101
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	-2
	.byte	-1
	.byte	0
	.byte	0
	.byte	103
	.align 32
_common_symbols1.2050:
	.byte	46
	.byte	116
	.byte	101
	.byte	120
	.byte	116
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	46
	.byte	100
	.byte	97
	.byte	116
	.byte	97
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	2
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	46
	.byte	98
	.byte	115
	.byte	115
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	0
	.byte	0
	.byte	0
	.byte	3
	.byte	1
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.section .rdata,"dr"
	.align 4
LC18:
	.ascii "      >> [ERROR #001] syntax error.\12\0"
	.align 4
LC19:
	.ascii "      >> [ERROR #002] parameter error.\12\0"
	.align 4
LC20:
	.ascii "      >> [ERROR #003] data size error.\12\0"
	.align 4
LC21:
	.ascii "      >> [ERROR #004] data type error.\12\0"
	.align 4
LC22:
	.ascii "      >> [ERROR #005] addressing error.\12\0"
	.align 4
LC23:
	.ascii "      >> [ERROR #006] TIMES error.\12\0"
	.align 4
LC24:
	.ascii "      >> [ERROR #007] label definition error.\12\0"
	.align 4
LC25:
	.ascii "      >> [ERROR #008] data range error.\12\0"
	.align 4
LC26:
	.ascii "      >> [ERROR #009] expression error.\12\0"
	.align 4
LC27:
	.ascii "      >> [ERROR #010] expression error.\12\0"
	.align 4
LC28:
	.ascii "      >> [ERROR #011] expression error.\12\0"
	.align 4
LC29:
	.ascii "      >> [ERROR #012] expression error.\12\0"
	.data
	.align 32
_errmsg.2083:
	.long	LC18
	.long	LC19
	.long	LC20
	.long	LC21
	.long	LC22
	.long	LC23
	.long	LC24
	.long	LC25
	.long	LC26
	.long	LC27
	.long	LC28
	.long	LC29
	.align 4
_tbl_o16o32.1817:
	.long	0
	.long	268435456
	.long	0
	.long	536870912
	.align 32
_mcode.1857:
	.long	340
	.long	49
	.long	192
	.long	152
	.long	0
	.long	1
	.long	49
	.long	208
	.long	48
	.long	0
	.align 32
_mcode.1861:
	.long	340
	.long	49
	.long	0
	.long	154
	.long	0
	.long	0
	.long	49
	.long	0
	.long	48
	.long	0
	.align 32
_mcode.1865:
	.long	340
	.long	49
	.long	205
	.long	152
	.long	0
	.long	3
	.long	49
	.long	204
	.long	48
	.long	0
	.align 4
_mcode.1871:
	.long	84
	.long	1
	.long	104
	.long	1
	.long	106
_typecode.1873:
	.byte	6
	.byte	3
	.byte	0
	.byte	5
	.align 32
_mcode.1877:
	.long	92
	.long	1
	.long	5
	.long	0
	.long	0
	.long	1
	.long	131
	.long	1
	.long	192
	.align 4
_mcode.1878:
	.long	84
	.long	1
	.long	129
	.long	1
	.long	131
	.align 4
_mcode.1884:
	.long	84
	.long	1
	.long	105
	.long	1
	.long	107
_table.1886:
	.byte	6
	.byte	6
	.byte	3
	.byte	3
	.byte	5
	.align 32
_mcode.1891:
	.long	0
	.long	1
	.long	15
	.long	1
	.long	0
	.long	1
	.long	0
	.long	0
	.long	0
_sizelist.1899:
	.byte	-1
	.byte	-1
	.byte	0
	.byte	-1
	.byte	1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	2
	.byte	-1
	.byte	3
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-1
	.byte	-2
	.align 4
_mcode.1916:
	.long	84
	.long	1
	.long	233
	.long	1
	.long	235
	.def	_malloc;	.scl	2;	.type	32;	.endef
	.def	_LL_skipcode;	.scl	2;	.type	32;	.endef
	.def	_free;	.scl	2;	.type	32;	.endef
