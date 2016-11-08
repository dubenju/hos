	.file	"ll.c"
.lcomm _label0,4,4
.lcomm _subsect0,4,4
	.text
.globl _init_value
	.def	_init_value;	.scl	2;	.type	32;	.endef
_init_value:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	8(%ebp), %eax
	movl	$0, 16(%eax)
	movl	8(%ebp), %eax
	movl	16(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	$0, 8(%eax)
	movl	8(%ebp), %eax
	movl	$-1, 24(%eax)
	movl	8(%ebp), %eax
	movl	24(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 20(%eax)
	movl	$0, -4(%ebp)
	jmp	L2
L3:
	movl	8(%ebp), %ecx
	movl	-4(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	$0, (%eax)
	movl	8(%ebp), %ecx
	movl	-4(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$32, %eax
	movl	$0, (%eax)
	movl	8(%ebp), %ecx
	movl	-4(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$36, %eax
	movl	$0, (%eax)
	incl	-4(%ebp)
L2:
	cmpl	$3, -4(%ebp)
	jle	L3
	leave
	ret
.globl _get_id
	.def	_get_id;	.scl	2;	.type	32;	.endef
_get_id:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -4(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, -8(%ebp)
	movl	$0, 16(%ebp)
L5:
	movl	-4(%ebp), %eax
	movb	(%eax), %dl
	leal	-8(%ebp), %eax
	addl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	incl	-4(%ebp)
	decl	8(%ebp)
	cmpl	$0, 8(%ebp)
	jns	L5
	movl	12(%ebp), %eax
	movl	-4(%ebp), %edx
	movl	%edx, (%eax)
	movl	-8(%ebp), %eax
	leave
	ret
.globl _calc_value
	.def	_calc_value;	.scl	2;	.type	32;	.endef
_calc_value:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value0
	movl	8(%ebp), %eax
	movl	28(%eax), %eax
	testl	%eax, %eax
	je	L6
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calcsigma
L6:
	leave
	ret
.globl _enable_label
	.def	_enable_label;	.scl	2;	.type	32;	.endef
_enable_label:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$108, %esp
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	movl	%eax, -104(%ebp)
	movl	-104(%ebp), %eax
	testl	%eax, %eax
	je	L9
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	$32, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	leal	-104(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-100(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value0
	movl	-92(%ebp), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	L10
	leal	-100(%ebp), %eax
	movl	%eax, (%esp)
	call	_init_value
	movl	-92(%ebp), %eax
	orl	$2, %eax
	movl	%eax, -92(%ebp)
	jmp	L10
L9:
	leal	-100(%ebp), %eax
	movl	%eax, (%esp)
	call	_init_value
	movl	-92(%ebp), %eax
	orl	$4, %eax
	movl	%eax, -92(%ebp)
L10:
	movl	8(%ebp), %eax
	movl	%eax, %edx
	leal	-100(%ebp), %ebx
	movl	$19, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	$64, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	addl	$108, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
.globl _calc_value0
	.def	_calc_value0;	.scl	2;	.type	32;	.endef
_calc_value0:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$220, %esp
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -48(%ebp)
	movl	-48(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -37(%ebp)
	incl	%eax
	movl	%eax, -48(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_init_value
	cmpb	$6, -37(%ebp)
	ja	L12
	movl	$0, -28(%ebp)
	movzbl	-37(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	L13
	decl	-28(%ebp)
L13:
	movb	-37(%ebp), %al
	shrb	%al
	movzbl	%al, %eax
	movl	-28(%ebp), %edx
	movl	%edx, 8(%esp)
	leal	-48(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_get_id
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L14
L12:
	cmpb	$7, -37(%ebp)
	jne	L15
	movl	8(%ebp), %eax
	movl	$1, (%eax)
	jmp	L14
L15:
	cmpb	$11, -37(%ebp)
	ja	L16
	movl	_label0, %ebx
	movzbl	-37(%ebp), %eax
	leal	-8(%eax), %edx
	movl	$0, 8(%esp)
	leal	-48(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_get_id
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	leal	(%ebx,%eax), %eax
	movl	%eax, -44(%ebp)
	movl	-44(%ebp), %eax
	movl	8(%eax), %eax
	andl	$64, %eax
	testl	%eax, %eax
	jne	L17
	movl	-44(%ebp), %eax
	movl	8(%eax), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	L18
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	$2, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L14
L18:
	movl	-44(%ebp), %eax
	movl	%eax, (%esp)
	call	_enable_label
L17:
	movl	8(%ebp), %edx
	movl	-44(%ebp), %eax
	movl	%eax, %ebx
	movl	$19, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	jmp	L14
L16:
	cmpb	$31, -37(%ebp)
	ja	L14
	leal	-48(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value0
	cmpb	$16, -37(%ebp)
	je	L107
L19:
	cmpb	$17, -37(%ebp)
	jne	L20
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	leal	(%edx,%eax), %eax
	movl	%eax, %edx
	negl	%edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
L21:
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, %edx
	negl	%edx
	movl	8(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	movl	16(%eax), %eax
	movl	%eax, %edx
	negl	%edx
	movl	8(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	$0, -28(%ebp)
	jmp	L22
L23:
	movl	8(%ebp), %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %eax
	movl	%eax, %ecx
	negl	%ecx
	movl	8(%ebp), %ebx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$28, %eax
	movl	%ecx, (%eax)
	incl	-28(%ebp)
L22:
	cmpl	$3, -28(%ebp)
	jle	L23
	jmp	L14
L20:
	cmpb	$18, -37(%ebp)
	jne	L24
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	leal	(%edx,%eax), %eax
	movl	%eax, %edx
	notl	%edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L21
L24:
	leal	-48(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-124(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value0
	movl	8(%ebp), %eax
	movl	8(%eax), %edx
	movl	-116(%ebp), %eax
	orl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	cmpb	$19, -37(%ebp)
	jne	L25
L26:
	movl	$0, -28(%ebp)
	jmp	L27
L30:
	movl	8(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	testl	%eax, %eax
	je	L108
L28:
	incl	-28(%ebp)
L27:
	cmpl	$1, -28(%ebp)
	jle	L30
	jmp	L29
L108:
	nop
L29:
	movl	$0, -32(%ebp)
	jmp	L31
L41:
	movl	-32(%ebp), %eax
	movl	-112(%ebp,%eax,4), %eax
	testl	%eax, %eax
	je	L109
L32:
	movl	$0, -36(%ebp)
	jmp	L34
L39:
	movl	8(%ebp), %eax
	movl	-36(%ebp), %edx
	addl	$4, %edx
	movl	4(%eax,%edx,4), %edx
	movl	-32(%ebp), %eax
	addl	$4, %eax
	movl	-120(%ebp,%eax,4), %eax
	cmpl	%eax, %edx
	jne	L35
	movl	8(%ebp), %eax
	movl	-36(%ebp), %edx
	movl	12(%eax,%edx,4), %edx
	movl	-32(%ebp), %eax
	movl	-112(%ebp,%eax,4), %eax
	leal	(%edx,%eax), %ecx
	movl	8(%ebp), %eax
	movl	-36(%ebp), %edx
	movl	%ecx, 12(%eax,%edx,4)
	movl	8(%ebp), %eax
	movl	-36(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	testl	%eax, %eax
	jne	L110
	decl	-28(%ebp)
	movl	8(%ebp), %eax
	movl	-36(%ebp), %edx
	addl	$4, %edx
	movl	$-1, 4(%eax,%edx,4)
	cmpl	$0, -36(%ebp)
	jne	L111
L37:
	movl	8(%ebp), %eax
	movl	16(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	movl	24(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 20(%eax)
	movl	8(%ebp), %eax
	movl	$0, 16(%eax)
	movl	8(%ebp), %eax
	movl	$-1, 24(%eax)
	jmp	L38
L35:
	incl	-36(%ebp)
L34:
	movl	-36(%ebp), %eax
	cmpl	-28(%ebp), %eax
	jl	L39
	cmpl	$1, -28(%ebp)
	jle	L40
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	$1, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L14
L40:
	movl	-32(%ebp), %eax
	movl	-112(%ebp,%eax,4), %ecx
	movl	8(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%ecx, 12(%eax,%edx,4)
	movl	-32(%ebp), %eax
	addl	$4, %eax
	movl	-120(%ebp,%eax,4), %edx
	movl	8(%ebp), %eax
	movl	-28(%ebp), %ecx
	addl	$4, %ecx
	movl	%edx, 4(%eax,%ecx,4)
	incl	-28(%ebp)
	jmp	L38
L110:
	nop
	jmp	L38
L111:
	nop
L38:
	incl	-32(%ebp)
L31:
	cmpl	$1, -32(%ebp)
	jle	L41
	jmp	L33
L109:
	nop
L33:
	movl	$0, -32(%ebp)
	jmp	L42
L45:
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	-24(%ebp), %edx
	leal	(%edx,%eax), %eax
	subl	$72, %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	L112
L43:
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	-24(%ebp), %ecx
	leal	(%ecx,%eax), %eax
	subl	$84, %eax
	leal	4(%esp), %edx
	leal	12(%eax), %ebx
	movl	$3, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_addsigma
	incl	-32(%ebp)
L42:
	cmpl	$3, -32(%ebp)
	jle	L45
	jmp	L44
L112:
	nop
L44:
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-124(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	-120(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L14
L25:
	cmpb	$20, -37(%ebp)
	jne	L46
	movl	-124(%ebp), %eax
	movl	%eax, %edx
	movl	-120(%ebp), %eax
	leal	(%edx,%eax), %eax
	negl	%eax
	movl	%eax, -124(%ebp)
	movl	-112(%ebp), %eax
	negl	%eax
	movl	%eax, -112(%ebp)
	movl	-108(%ebp), %eax
	negl	%eax
	movl	%eax, -108(%ebp)
	movl	$0, -28(%ebp)
	jmp	L47
L48:
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	-24(%ebp), %edx
	leal	(%edx,%eax), %eax
	subl	$72, %eax
	movl	(%eax), %eax
	movl	%eax, %ecx
	negl	%ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	-24(%ebp), %ebx
	leal	(%ebx,%eax), %eax
	subl	$72, %eax
	movl	%ecx, (%eax)
	incl	-28(%ebp)
L47:
	cmpl	$3, -28(%ebp)
	jle	L48
	jmp	L26
L46:
	cmpb	$21, -37(%ebp)
	jne	L49
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	testl	%eax, %eax
	jne	L113
L50:
	movl	-112(%ebp), %eax
	testl	%eax, %eax
	jne	L114
L49:
	cmpb	$21, -37(%ebp)
	je	L53
	cmpb	$28, -37(%ebp)
	jbe	L51
	cmpb	$31, -37(%ebp)
	ja	L51
L53:
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	L115
L54:
	movl	-120(%ebp), %eax
	testl	%eax, %eax
	jne	L116
L55:
	movl	8(%ebp), %eax
	movl	28(%eax), %eax
	testl	%eax, %eax
	jne	L117
L56:
	movl	-96(%ebp), %eax
	testl	%eax, %eax
	je	L51
	jmp	L52
L114:
	nop
	jmp	L52
L116:
	nop
L52:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -116(%ebp)
	movl	8(%ebp), %eax
	leal	-200(%ebp), %edx
	movl	%eax, %ebx
	movl	$19, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	8(%ebp), %eax
	movl	%eax, %edx
	leal	-124(%ebp), %ebx
	movl	$19, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	leal	-124(%ebp), %edx
	leal	-200(%ebp), %ebx
	movl	$19, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	jmp	L51
L113:
	nop
	jmp	L51
L115:
	nop
	jmp	L51
L117:
	nop
L51:
	leal	-124(%ebp), %eax
	movl	%eax, (%esp)
	call	_calcsigma
	movl	-120(%ebp), %eax
	testl	%eax, %eax
	je	L57
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	$1, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L14
L57:
	cmpb	$21, -37(%ebp)
	jne	L58
	movl	-112(%ebp), %eax
	testl	%eax, %eax
	je	L59
	jmp	L60
L119:
	nop
	jmp	L60
L120:
	nop
	jmp	L60
L121:
	nop
	jmp	L60
L122:
	nop
	jmp	L60
L123:
	nop
	jmp	L60
L125:
	nop
	jmp	L60
L128:
	nop
	jmp	L60
L130:
	nop
	jmp	L60
L133:
	nop
	jmp	L60
L134:
	nop
	jmp	L60
L135:
	nop
L60:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	$1, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L14
L59:
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	jne	L61
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_init_value
	jmp	L14
L61:
	movl	8(%ebp), %eax
	movl	12(%eax), %edx
	movl	-124(%ebp), %eax
	imull	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	movl	16(%eax), %edx
	movl	-124(%ebp), %eax
	imull	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	$0, -28(%ebp)
	jmp	L62
L63:
	movl	8(%ebp), %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %edx
	movl	-124(%ebp), %eax
	imull	%eax, %edx
	movl	8(%ebp), %ebx
	movl	-28(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$28, %eax
	movl	%edx, (%eax)
	incl	-28(%ebp)
L62:
	cmpl	$3, -28(%ebp)
	jle	L63
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-124(%ebp), %eax
	imull	%edx, %eax
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	leal	(%edx,%eax), %eax
	movl	%eax, %edx
	movl	-124(%ebp), %eax
	imull	%edx, %eax
	movl	%eax, -32(%ebp)
L64:
	movl	8(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, (%eax)
	movl	-28(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-28(%ebp), %eax
	cmpl	-32(%ebp), %eax
	jle	L118
	movl	8(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	%edx, (%eax)
	movl	-32(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, %ebx
	subl	%eax, %ebx
	movl	%ebx, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L14
L58:
	cmpb	$22, -37(%ebp)
	jne	L66
	movl	-124(%ebp), %eax
	movl	$1, %edx
	movl	%edx, %ebx
	movb	%al, %cl
	sall	%cl, %ebx
	movl	%ebx, %eax
	movl	%eax, -124(%ebp)
	jmp	L59
L66:
	cmpb	$23, -37(%ebp)
	jne	L67
L68:
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	je	L119
L69:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	-124(%ebp), %edx
	movl	%edx, -204(%ebp)
	movl	$0, %edx
	divl	-204(%ebp)
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	leal	(%edx,%eax), %eax
	movl	-124(%ebp), %edx
	movl	%edx, -204(%ebp)
	movl	$0, %edx
	divl	-204(%ebp)
	movl	%eax, -32(%ebp)
	movl	$0, -36(%ebp)
	jmp	L70
L72:
	movl	8(%ebp), %ecx
	movl	-36(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %eax
	movl	-124(%ebp), %ecx
	cltd
	idivl	%ecx
	movl	%edx, %eax
	testl	%eax, %eax
	je	L71
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calcsigma
	jmp	L69
L71:
	incl	-36(%ebp)
L70:
	cmpl	$3, -36(%ebp)
	jle	L72
L73:
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	movl	-124(%ebp), %ecx
	cltd
	idivl	%ecx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	L120
L74:
	movl	8(%ebp), %eax
	movl	16(%eax), %eax
	movl	-124(%ebp), %ecx
	cltd
	idivl	%ecx
	movl	%edx, %eax
	testl	%eax, %eax
	jne	L121
L75:
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	movl	-124(%ebp), %ecx
	movl	%ecx, -204(%ebp)
	cltd
	idivl	-204(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	movl	16(%eax), %eax
	movl	-124(%ebp), %ecx
	movl	%ecx, -204(%ebp)
	cltd
	idivl	-204(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	$0, -36(%ebp)
	jmp	L76
L77:
	movl	8(%ebp), %ecx
	movl	-36(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %eax
	movl	-124(%ebp), %ecx
	movl	%ecx, -204(%ebp)
	cltd
	idivl	-204(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %ebx
	movl	-36(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$28, %eax
	movl	%edx, (%eax)
	incl	-36(%ebp)
L76:
	cmpl	$3, -36(%ebp)
	jle	L77
	jmp	L64
L67:
	cmpb	$25, -37(%ebp)
	jne	L78
L79:
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	je	L122
L80:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	-124(%ebp), %ecx
	movl	%ecx, -204(%ebp)
	cltd
	idivl	-204(%ebp)
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	leal	(%edx,%eax), %eax
	movl	-124(%ebp), %ecx
	movl	%ecx, -204(%ebp)
	cltd
	idivl	-204(%ebp)
	movl	%eax, -32(%ebp)
	movl	$0, -36(%ebp)
	jmp	L81
L83:
	movl	8(%ebp), %ecx
	movl	-36(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %eax
	movl	-124(%ebp), %ecx
	cltd
	idivl	%ecx
	movl	%edx, %eax
	testl	%eax, %eax
	je	L82
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calcsigma
	jmp	L80
L82:
	incl	-36(%ebp)
L81:
	cmpl	$3, -36(%ebp)
	jle	L83
	jmp	L73
L78:
	cmpb	$27, -37(%ebp)
	jne	L84
	movl	-124(%ebp), %eax
	movl	$1, %edx
	movl	%edx, %ebx
	movb	%al, %cl
	sall	%cl, %ebx
	movl	%ebx, %eax
	movl	%eax, -124(%ebp)
	jmp	L68
L84:
	cmpb	$28, -37(%ebp)
	jne	L85
	movl	-124(%ebp), %eax
	movl	$1, %edx
	movl	%edx, %ebx
	movb	%al, %cl
	sall	%cl, %ebx
	movl	%ebx, %eax
	movl	%eax, -124(%ebp)
	jmp	L79
L85:
	movl	8(%ebp), %eax
	movl	$0, 16(%eax)
	movl	8(%ebp), %eax
	movl	16(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calcsigma
	cmpb	$24, -37(%ebp)
	jne	L86
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	je	L123
L87:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	-124(%ebp), %edx
	movl	%edx, %ecx
	movl	$0, %edx
	divl	%ecx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	je	L124
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	movl	-124(%ebp), %eax
	decl	%eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L14
L86:
	cmpb	$26, -37(%ebp)
	jne	L89
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	je	L125
L90:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	-124(%ebp), %ecx
	cltd
	idivl	%ecx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	je	L126
	movl	-124(%ebp), %eax
	decl	%eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	js	L92
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	jmp	L14
L92:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	leal	(%edx,%eax), %eax
	testl	%eax, %eax
	jg	L93
	movl	-124(%ebp), %eax
	movl	$1, %edx
	subl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L14
L93:
	movl	-124(%ebp), %eax
	movl	$1, %edx
	subl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	leal	(%eax,%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L14
L89:
	cmpb	$29, -37(%ebp)
	jne	L94
	movl	-124(%ebp), %eax
	cmpl	$-1, %eax
	je	L127
L95:
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	L96
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-124(%ebp), %eax
	andl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L14
L96:
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	js	L128
L97:
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	movl	-124(%ebp), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L14
L94:
	cmpb	$30, -37(%ebp)
	jne	L98
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	je	L129
L99:
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	L100
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-124(%ebp), %eax
	orl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L14
L100:
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	js	L130
L101:
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	-124(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jns	L131
L102:
	movl	8(%ebp), %eax
	movl	$0, 4(%eax)
	jmp	L60
L98:
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	je	L132
L103:
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	L104
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-124(%ebp), %eax
	xorl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	jmp	L14
L104:
	movl	-124(%ebp), %eax
	testl	%eax, %eax
	js	L133
L105:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jle	L134
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-124(%ebp), %eax
	cmpl	%eax, %edx
	jl	L135
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-124(%ebp), %eax
	subl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	-124(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L14
L107:
	nop
	jmp	L14
L118:
	nop
	jmp	L14
L124:
	nop
	jmp	L14
L126:
	nop
	jmp	L14
L127:
	nop
	jmp	L14
L129:
	nop
	jmp	L14
L131:
	nop
	jmp	L14
L132:
	nop
L14:
	movl	-48(%ebp), %edx
	movl	12(%ebp), %eax
	movl	%edx, (%eax)
	addl	$220, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
	.def	_skip_expr;	.scl	3;	.type	32;	.endef
_skip_expr:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_skip_expr
	leave
	ret
	.data
_table98typlen:
	.byte	56
	.byte	56
	.byte	57
	.byte	57
	.byte	59
	.byte	59
	.byte	56
_table98range:
	.byte	0
	.byte	2
	.byte	0
	.byte	3
	.byte	0
	.byte	3
	.byte	3
	.text
.globl _LL_define_VB
	.def	_LL_define_VB;	.scl	2;	.type	32;	.endef
_LL_define_VB:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	12(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -9(%ebp)
	movl	8(%ebp), %eax
	movb	-9(%ebp), %dl
	movb	%dl, 4(%eax)
	incl	12(%ebp)
	cmpb	$55, -9(%ebp)
	ja	L138
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, (%eax)
	movzbl	-9(%ebp), %eax
	andl	$7, %eax
	addl	%eax, 12(%ebp)
	jmp	L139
L138:
	cmpb	$59, -9(%ebp)
	ja	L140
	movl	12(%ebp), %eax
	movb	(%eax), %dl
	movl	8(%ebp), %eax
	movb	%dl, 5(%eax)
	incl	12(%ebp)
	jmp	L141
L140:
	movzbl	-9(%ebp), %eax
	andl	$7, %eax
	movb	_table98typlen(%eax), %dl
	movl	8(%ebp), %eax
	movb	%dl, 4(%eax)
	movzbl	-9(%ebp), %eax
	andl	$7, %eax
	movb	_table98range(%eax), %dl
	movl	8(%ebp), %eax
	movb	%dl, 5(%eax)
L141:
	movl	8(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, (%eax)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 12(%ebp)
L139:
	movl	12(%ebp), %eax
	leave
	ret
.globl _lccbug_LL_mc90_func
	.def	_lccbug_LL_mc90_func;	.scl	2;	.type	32;	.endef
_lccbug_LL_mc90_func:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	20(%ebp), %edx
	movl	24(%ebp), %eax
	movb	%dl, -12(%ebp)
	movb	%al, -16(%ebp)
L145:
	cmpb	$0, -16(%ebp)
	je	L143
	movl	$1, 8(%esp)
	movl	$0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, 8(%ebp)
	cmpl	$0, 16(%ebp)
	je	L144
	movl	$1, 8(%esp)
	movl	$0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, 8(%ebp)
	jmp	L144
L143:
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_define_VB
	movl	%eax, 8(%ebp)
	cmpl	$0, 16(%ebp)
	je	L144
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	16(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_define_VB
	movl	%eax, 8(%ebp)
L144:
	decb	-16(%ebp)
	decb	-12(%ebp)
	cmpb	$0, -12(%ebp)
	jne	L145
	movl	8(%ebp), %eax
	leave
	ret
.globl _LL
	.def	_LL;	.scl	2;	.type	32;	.endef
_LL:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$188, %esp
	movl	_nask_maxlabels, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, _label0
	movl	_nask_maxlabels, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, _subsect0
	movl	$76, (%esp)
	call	_malloc
	movl	%eax, -64(%ebp)
	movl	$76, (%esp)
	call	_malloc
	movl	%eax, -68(%ebp)
	movl	_label0, %eax
	movl	%eax, -40(%ebp)
	movl	_nask_maxlabels, %eax
	movl	%eax, -32(%ebp)
	jmp	L147
L148:
	movl	-40(%ebp), %eax
	movl	$0, 8(%eax)
	movl	-40(%ebp), %eax
	movl	$0, 76(%eax)
	addl	$80, -40(%ebp)
	decl	-32(%ebp)
L147:
	cmpl	$0, -32(%ebp)
	jne	L148
	movl	_subsect0, %eax
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	-68(%ebp), %eax
	movl	%eax, (%esp)
	call	_init_value
	jmp	L149
L154:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -57(%ebp)
	cmpb	$45, -57(%ebp)
	jne	L150
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, 8(%ebp)
	leal	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	_label0, %ecx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, -40(%ebp)
	movl	8(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	%edx, 76(%eax)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 8(%ebp)
	jmp	L149
L150:
	cmpb	$14, -57(%ebp)
	jne	L151
	movl	$1, -164(%ebp)
	movl	-28(%ebp), %edx
	movl	_subsect0, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	sarl	$2, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	leal	0(,%eax,4), %ecx
	addl	%ecx, %eax
	sall	%eax
	addl	%edx, %eax
	movl	%eax, %ecx
	sall	$8, %ecx
	addl	%ecx, %eax
	movl	%eax, %ecx
	sall	$16, %ecx
	addl	%ecx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	movl	%eax, -160(%ebp)
	movl	$1, -156(%ebp)
	movl	8(%ebp), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 16(%eax)
	addl	$20, -28(%ebp)
	movl	8(%ebp), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, 8(%ebp)
	leal	8(%ebp), %esi
	movl	%esi, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	_label0, %ecx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, -40(%ebp)
	movl	8(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	%edx, 76(%eax)
	leal	4(%esp), %edx
	leal	-164(%ebp), %ebx
	movl	$3, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	-68(%ebp), %eax
	movl	%eax, (%esp)
	call	_addsigma
	movl	-40(%ebp), %edx
	movl	-68(%ebp), %eax
	movl	%eax, %ebx
	movl	$19, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	-40(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	$64, %edx
	movl	-40(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L149
L151:
	cmpb	$44, -57(%ebp)
	jne	L152
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, 8(%ebp)
	leal	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	_label0, %ecx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	_init_value
	movl	-40(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	$80, %edx
	movl	-40(%ebp), %eax
	movl	%edx, 8(%eax)
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	-40(%ebp), %eax
	movl	%edx, 20(%eax)
	movl	-40(%ebp), %eax
	movl	$1, 12(%eax)
	jmp	L149
L152:
	cmpb	$88, -57(%ebp)
	jne	L153
	movl	8(%ebp), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 16(%eax)
	addl	$20, -28(%ebp)
	movl	8(%ebp), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 12(%eax)
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, 8(%ebp)
	leal	8(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	-68(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	jmp	L149
L153:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_skipcode
	movl	%eax, 8(%ebp)
L149:
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L154
	movl	-28(%ebp), %eax
	movl	12(%ebp), %edx
	movl	%edx, 16(%eax)
	movl	-28(%ebp), %eax
	addl	$20, %eax
	movl	%eax, -72(%ebp)
	movl	_subsect0, %eax
	movl	%eax, -28(%ebp)
	jmp	L155
L156:
	movl	-28(%ebp), %eax
	movl	$0, (%eax)
	movl	-28(%ebp), %eax
	movl	$1073741824, 4(%eax)
	movl	-28(%ebp), %eax
	movl	$1, 8(%eax)
	addl	$20, -28(%ebp)
L155:
	movl	-28(%ebp), %eax
	cmpl	-72(%ebp), %eax
	jb	L156
	movb	$0, -58(%ebp)
	movb	$0, -57(%ebp)
	movl	$2147483647, -36(%ebp)
L165:
	movl	_subsect0, %eax
	movl	%eax, -28(%ebp)
	jmp	L157
L159:
	movl	-28(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	je	L158
	movb	-58(%ebp), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	_solve_subsection
L158:
	addl	$20, -28(%ebp)
L157:
	movl	-28(%ebp), %eax
	cmpl	-72(%ebp), %eax
	jb	L159
	movl	$0, -32(%ebp)
	movl	-72(%ebp), %eax
	subl	$20, %eax
	movl	%eax, -28(%ebp)
	jmp	L160
L162:
	movl	-28(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	je	L161
	movb	-58(%ebp), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	_solve_subsection
	addl	%eax, -32(%ebp)
L161:
	subl	$20, -28(%ebp)
L160:
	movl	_subsect0, %eax
	cmpl	%eax, -28(%ebp)
	jae	L162
	incb	-57(%ebp)
	movl	-36(%ebp), %eax
	cmpl	-32(%ebp), %eax
	jbe	L163
	movb	$0, -57(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, -36(%ebp)
L163:
	cmpb	$2, -57(%ebp)
	jbe	L164
	incb	-58(%ebp)
	movb	$0, -57(%ebp)
L164:
	cmpl	$0, -32(%ebp)
	jne	L165
	movl	_subsect0, %eax
	movl	%eax, -28(%ebp)
	jmp	L166
L231:
	movl	$0, -48(%ebp)
	movl	-28(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, 8(%ebp)
	jmp	L167
L230:
	movl	8(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -57(%ebp)
	incl	%eax
	movl	%eax, 8(%ebp)
	movl	16(%ebp), %eax
	addl	$64, %eax
	cmpl	20(%ebp), %eax
	jb	L168
	jmp	L169
L234:
	nop
L169:
	movl	$0, %eax
	jmp	L170
L168:
	cmpb	$45, -57(%ebp)
	jne	L171
	leal	8(%ebp), %ecx
	movl	%ecx, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	_label0, %ecx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	8(%eax), %eax
	andl	$64, %eax
	testl	%eax, %eax
	jne	L172
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	_enable_label
L172:
	movl	-64(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	%eax, %ebx
	movl	$19, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calcsigma
	movb	$12, -57(%ebp)
	movl	-64(%ebp), %eax
	movl	12(%eax), %eax
	testl	%eax, %eax
	je	L173
	incb	-57(%ebp)
L173:
	movl	16(%ebp), %eax
	movb	-57(%ebp), %dl
	movb	%dl, (%eax)
	incl	16(%ebp)
	movb	$4, -58(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 8(%ebp)
	jmp	L174
L171:
	cmpb	$14, -57(%ebp)
	jne	L175
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 8(%ebp)
	jmp	L167
L175:
	cmpb	$15, -57(%ebp)
	jne	L176
	movl	16(%ebp), %eax
	movb	$-10, (%eax)
	movl	16(%ebp), %eax
	leal	1(%eax), %ecx
	movl	8(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, (%ecx)
	incl	%eax
	movl	%eax, 8(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -57(%ebp)
	incl	%eax
	movl	%eax, 8(%ebp)
	movl	_label0, %ebx
	movzbl	-57(%ebp), %eax
	subl	$8, %eax
	movl	$0, 8(%esp)
	leal	8(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_get_id
	movl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$4, %eax
	leal	(%ebx,%eax), %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	8(%eax), %eax
	andl	$64, %eax
	testl	%eax, %eax
	jne	L177
	movl	-40(%ebp), %eax
	movl	%eax, (%esp)
	call	_enable_label
L177:
	movl	-64(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	%eax, %ebx
	movl	$19, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calcsigma
	movl	16(%ebp), %eax
	addl	$2, %eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	addl	$3, %eax
	movb	$0, (%eax)
	movl	16(%ebp), %eax
	leal	4(%eax), %edx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	5(%eax), %edx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	sarl	$8, %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	6(%eax), %edx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	sarl	$16, %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	7(%eax), %edx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	shrl	$24, %eax
	movb	%al, (%edx)
	addl	$8, 16(%ebp)
	movl	-64(%ebp), %eax
	movl	12(%eax), %eax
	testl	%eax, %eax
	je	L232
	movl	16(%ebp), %eax
	leal	-6(%eax), %edx
	movl	-64(%ebp), %eax
	movl	20(%eax), %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	-5(%eax), %edx
	movl	-64(%ebp), %eax
	movl	20(%eax), %eax
	shrl	$8, %eax
	movb	%al, (%edx)
	jmp	L167
L176:
	cmpb	$44, -57(%ebp)
	jne	L179
	movl	16(%ebp), %eax
	movb	$44, (%eax)
	movl	16(%ebp), %eax
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	8(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	3(%eax), %edx
	movl	8(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movb	%al, (%edx)
	movl	8(%ebp), %eax
	addl	$3, %eax
	movl	%eax, 8(%ebp)
	addl	$4, 16(%ebp)
	jmp	L167
L179:
	cmpb	$54, -57(%ebp)
	ja	L180
	movb	-57(%ebp), %al
	andl	$7, %eax
	movb	%al, -58(%ebp)
L181:
	movl	16(%ebp), %eax
	movb	-57(%ebp), %dl
	movb	%dl, (%eax)
	incl	16(%ebp)
	cmpb	$0, -58(%ebp)
	je	L233
	movzbl	-58(%ebp), %eax
	subl	%eax, -48(%ebp)
L183:
	movl	8(%ebp), %eax
	movb	(%eax), %cl
	movl	16(%ebp), %edx
	movb	%cl, (%edx)
	incl	16(%ebp)
	incl	%eax
	movl	%eax, 8(%ebp)
	decb	-58(%ebp)
	cmpb	$0, -58(%ebp)
	jne	L183
L184:
	cmpl	$0, -48(%ebp)
	jne	L185
L186:
	movl	-52(%ebp), %eax
	addl	$4, %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -152(%ebp)
	leal	-152(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movb	$0, -57(%ebp)
	movl	-52(%ebp), %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	-52(%ebp), %edx
	incl	%edx
	movb	(%edx), %dl
	movzbl	%dl, %edx
	sall	$8, %edx
	orl	%eax, %edx
	movl	-52(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	sall	$16, %eax
	orl	%eax, %edx
	movl	-52(%ebp), %eax
	addl	$3, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	sall	$24, %eax
	orl	%eax, %edx
	movl	-64(%ebp), %eax
	movl	%edx, (%eax)
	movl	-64(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	je	L187
	movb	$1, -57(%ebp)
	movl	16(%ebp), %eax
	movb	$-23, (%eax)
	incl	16(%ebp)
L187:
	movl	-64(%ebp), %eax
	movl	8(%eax), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L188
	movb	$1, -57(%ebp)
	movl	16(%ebp), %eax
	movb	$-20, (%eax)
	incl	16(%ebp)
L188:
	movl	-64(%ebp), %eax
	movl	8(%eax), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	L189
	movb	$1, -57(%ebp)
	movl	16(%ebp), %eax
	movb	$-22, (%eax)
	incl	16(%ebp)
L189:
	movl	-64(%ebp), %eax
	movl	8(%eax), %eax
	andl	$1, %eax
	testb	%al, %al
	je	L190
	movb	$1, -57(%ebp)
	movl	16(%ebp), %eax
	movb	$-21, (%eax)
	incl	16(%ebp)
L190:
	cmpb	$0, -57(%ebp)
	jne	L191
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$-17, %eax
	jbe	L192
L191:
	movl	16(%ebp), %eax
	movb	$-26, (%eax)
	incl	16(%ebp)
	movl	-56(%ebp), %eax
	movl	%eax, 16(%ebp)
	jmp	L167
L192:
	movl	16(%ebp), %edx
	movl	-56(%ebp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	movl	-64(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-64(%ebp), %eax
	movl	4(%eax), %edx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	imull	%edx, %eax
	addl	$64, %eax
	addl	16(%ebp), %eax
	cmpl	20(%ebp), %eax
	jae	L234
L193:
	movl	-56(%ebp), %eax
	movl	%eax, -52(%ebp)
	movl	-52(%ebp), %eax
	movl	%eax, 16(%ebp)
	jmp	L194
L197:
	movl	-52(%ebp), %eax
	movl	%eax, -152(%ebp)
	movl	-64(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, -48(%ebp)
	jmp	L195
L196:
	movl	-152(%ebp), %eax
	movb	(%eax), %cl
	movl	16(%ebp), %edx
	movb	%cl, (%edx)
	incl	16(%ebp)
	incl	%eax
	movl	%eax, -152(%ebp)
	decl	-48(%ebp)
L195:
	cmpl	$0, -48(%ebp)
	jg	L196
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	leal	-1(%eax), %edx
	movl	-64(%ebp), %eax
	movl	%edx, (%eax)
L194:
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jg	L197
	jmp	L185
L235:
	nop
L185:
	movl	$0, -48(%ebp)
	jmp	L167
L180:
	cmpb	$59, -57(%ebp)
	ja	L198
	movb	-57(%ebp), %al
	subl	$55, %eax
	movb	%al, -58(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -73(%ebp)
	incl	%eax
	movl	%eax, 8(%ebp)
	leal	8(%ebp), %esi
	movl	%esi, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
L199:
	movl	-64(%ebp), %eax
	movl	12(%eax), %eax
	testl	%eax, %eax
	je	L200
	cmpb	$4, -58(%ebp)
	jne	L200
	movl	-64(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	L200
	movl	-64(%ebp), %eax
	movl	8(%eax), %eax
	andl	$7, %eax
	testl	%eax, %eax
	jne	L200
	movl	-64(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	jne	L201
	movl	-64(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	je	L201
	movl	-64(%ebp), %eax
	movl	12(%eax), %eax
	cmpl	$-1, %eax
	jne	L201
	movl	-64(%ebp), %eax
	movl	24(%eax), %edx
	movl	-64(%ebp), %eax
	movl	%edx, 20(%eax)
	movl	-64(%ebp), %eax
	movl	$-1, 16(%eax)
L201:
	movl	-64(%ebp), %eax
	movl	16(%eax), %eax
	movb	$46, %dl
	subb	%al, %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	movl	16(%ebp), %eax
	incl	%eax
	movb	$9, (%eax)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	-64(%ebp), %eax
	movl	20(%eax), %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	3(%eax), %edx
	movl	-64(%ebp), %eax
	movl	20(%eax), %eax
	shrl	$8, %eax
	movb	%al, (%edx)
	addl	$4, 16(%ebp)
L200:
	movb	-58(%ebp), %al
	movb	%al, %dl
	orl	$48, %edx
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
L174:
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	movb	%al, %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	movl	16(%ebp), %eax
	leal	1(%eax), %edx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	sarl	$8, %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	2(%eax), %edx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	sarl	$16, %eax
	movb	%al, (%edx)
	movl	16(%ebp), %eax
	leal	3(%eax), %edx
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	shrl	$24, %eax
	movb	%al, (%edx)
	movzbl	-58(%ebp), %eax
	addl	%eax, 16(%ebp)
	movl	-64(%ebp), %eax
	movl	4(%eax), %eax
	testl	%eax, %eax
	je	L202
	movl	16(%ebp), %eax
	movb	$-23, (%eax)
	incl	16(%ebp)
L202:
	movl	-64(%ebp), %eax
	movl	8(%eax), %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L203
	movl	16(%ebp), %eax
	movb	$-20, (%eax)
	incl	16(%ebp)
L203:
	movl	-64(%ebp), %eax
	movl	8(%eax), %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	L204
	movl	16(%ebp), %eax
	movb	$-22, (%eax)
	incl	16(%ebp)
L204:
	movl	-64(%ebp), %eax
	movl	8(%eax), %eax
	andl	$1, %eax
	testb	%al, %al
	je	L205
	movl	16(%ebp), %eax
	movb	$-21, (%eax)
	incl	16(%ebp)
L205:
	movzbl	-58(%ebp), %eax
	subl	%eax, -48(%ebp)
	cmpl	$0, -48(%ebp)
	jne	L235
	jmp	L186
L198:
	cmpb	$88, -57(%ebp)
	jne	L207
	leal	8(%ebp), %edi
	movl	%edi, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	16(%ebp), %eax
	movb	$90, (%eax)
	incl	16(%ebp)
	movb	$4, -58(%ebp)
	jmp	L174
L207:
	cmpb	$89, -57(%ebp)
	jne	L208
	movl	16(%ebp), %eax
	movl	%eax, -56(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -52(%ebp)
	movl	8(%ebp), %eax
	addl	$4, %eax
	movl	%eax, 8(%ebp)
	leal	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -48(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 8(%ebp)
	jmp	L167
L208:
	cmpb	$104, -57(%ebp)
	jne	L209
	movl	8(%ebp), %eax
	incl	%eax
	movl	%eax, 8(%ebp)
	jmp	L167
L209:
	cmpb	$119, -57(%ebp)
	ja	L210
	movl	8(%ebp), %eax
	movzbl	-57(%ebp), %edx
	andl	$7, %edx
	leal	0(,%edx,8), %ecx
	leal	-148(%ebp), %edx
	addl	%ecx, %edx
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_LL_define_VB
	movl	%eax, 8(%ebp)
	jmp	L167
L210:
	movb	-57(%ebp), %al
	testb	%al, %al
	js	L211
	movzbl	-57(%ebp), %eax
	andl	$7, %eax
	leal	0(,%eax,8), %edx
	leal	-148(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -80(%ebp)
	movl	-80(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -152(%ebp)
	movl	-80(%ebp), %eax
	movb	4(%eax), %al
	cmpb	$55, %al
	ja	L212
	movl	-80(%ebp), %eax
	movb	4(%eax), %al
	andl	$7, %eax
	movb	%al, -58(%ebp)
	movl	-80(%ebp), %eax
	movb	4(%eax), %dl
	movl	16(%ebp), %eax
	movb	%dl, (%eax)
	incl	16(%ebp)
	cmpb	$0, -58(%ebp)
	je	L236
	movzbl	-58(%ebp), %eax
	subl	%eax, -48(%ebp)
L214:
	movl	-152(%ebp), %eax
	movb	(%eax), %cl
	movl	16(%ebp), %edx
	movb	%cl, (%edx)
	incl	16(%ebp)
	incl	%eax
	movl	%eax, -152(%ebp)
	decb	-58(%ebp)
	cmpb	$0, -58(%ebp)
	jne	L214
	jmp	L184
L212:
	movl	-80(%ebp), %eax
	movb	4(%eax), %al
	subl	$55, %eax
	movb	%al, -58(%ebp)
	movl	-80(%ebp), %eax
	movb	5(%eax), %al
	movb	%al, -73(%ebp)
	leal	-152(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	jmp	L199
L211:
	cmpb	$-111, -57(%ebp)
	ja	L215
	movl	8(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movb	%al, -58(%ebp)
	movzbl	-58(%ebp), %eax
	andl	$7, %eax
	leal	0(,%eax,8), %edx
	leal	-148(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -80(%ebp)
	movb	-58(%ebp), %al
	shrb	$4, %al
	movzbl	%al, %eax
	andl	$7, %eax
	leal	0(,%eax,8), %edx
	leal	-148(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -84(%ebp)
	movl	-84(%ebp), %eax
	addl	$8, %eax
	movl	%eax, -44(%ebp)
	cmpb	$-112, -57(%ebp)
	jne	L216
	movl	$0, -44(%ebp)
L216:
	movl	8(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	andl	$15, %eax
	leal	55(%eax), %edx
	movl	-80(%ebp), %eax
	movb	%dl, 4(%eax)
	movl	-80(%ebp), %eax
	movb	$3, 5(%eax)
	movl	-80(%ebp), %eax
	movb	4(%eax), %al
	cmpb	$1, %al
	jne	L217
	movl	-80(%ebp), %eax
	movb	$2, 5(%eax)
L217:
	movl	8(%ebp), %eax
	movb	(%eax), %al
	andl	$15, %eax
	movb	%al, -57(%ebp)
	movb	-58(%ebp), %al
	shrb	$7, %al
	addl	$2, %eax
	movb	%al, -58(%ebp)
	movl	8(%ebp), %eax
	leal	3(%eax), %edx
	movl	-80(%ebp), %eax
	movl	%edx, (%eax)
	movl	-80(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 8(%ebp)
	movb	-57(%ebp), %al
	movsbl	%al, %ecx
	movb	-58(%ebp), %al
	movsbl	%al, %edx
	movl	8(%ebp), %eax
	movl	%ecx, 16(%esp)
	movl	%edx, 12(%esp)
	movl	-44(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	-84(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_lccbug_LL_mc90_func
	movl	%eax, 8(%ebp)
	jmp	L167
L215:
	cmpb	$-107, -57(%ebp)
	ja	L218
	movl	8(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movb	%al, -58(%ebp)
	movzbl	-58(%ebp), %eax
	andl	$7, %eax
	leal	0(,%eax,8), %edx
	leal	-148(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -80(%ebp)
	movb	-58(%ebp), %al
	shrb	$4, %al
	movzbl	%al, %eax
	andl	$7, %eax
	leal	0(,%eax,8), %edx
	leal	-148(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -84(%ebp)
	movl	-84(%ebp), %eax
	addl	$8, %eax
	movl	%eax, -44(%ebp)
	cmpb	$-108, -57(%ebp)
	jne	L219
	movl	$0, -44(%ebp)
L219:
	movl	8(%ebp), %eax
	leal	3(%eax), %edx
	movl	-80(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movb	(%eax), %al
	andl	$15, %eax
	movb	%al, -57(%ebp)
	movl	-80(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 8(%ebp)
	movl	8(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -58(%ebp)
	incl	%eax
	movl	%eax, 8(%ebp)
	jmp	L220
L227:
	decb	-57(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, 8(%ebp)
L220:
	cmpb	$0, -57(%ebp)
	jne	L221
	movl	8(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -73(%ebp)
	incl	%eax
	movl	%eax, 8(%ebp)
	cmpb	$59, -73(%ebp)
	ja	L222
	movl	-80(%ebp), %eax
	movb	-73(%ebp), %dl
	movb	%dl, 4(%eax)
	movl	8(%ebp), %eax
	movb	(%eax), %cl
	movl	-80(%ebp), %edx
	movb	%cl, 5(%edx)
	incl	%eax
	movl	%eax, 8(%ebp)
	jmp	L223
L222:
	movzbl	-73(%ebp), %eax
	andl	$7, %eax
	movb	_table98typlen(%eax), %dl
	movl	-80(%ebp), %eax
	movb	%dl, 4(%eax)
	movzbl	-73(%ebp), %eax
	andl	$7, %eax
	movb	_table98range(%eax), %dl
	movl	-80(%ebp), %eax
	movb	%dl, 5(%eax)
L223:
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-84(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_define_VB
	movl	%eax, 8(%ebp)
	jmp	L224
L221:
	movl	8(%ebp), %eax
	movl	$0, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, 8(%ebp)
	movl	8(%ebp), %eax
	movl	$1, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, 8(%ebp)
L224:
	cmpl	$0, -44(%ebp)
	je	L225
	cmpb	$0, -57(%ebp)
	jne	L226
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	-44(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_define_VB
	movl	%eax, 8(%ebp)
	jmp	L225
L226:
	movl	8(%ebp), %eax
	movl	$1, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, 8(%ebp)
L225:
	decb	-58(%ebp)
	cmpb	$0, -58(%ebp)
	jne	L227
	jmp	L167
L218:
	cmpb	$-98, -57(%ebp)
	ja	L228
	movzbl	-57(%ebp), %eax
	andl	$7, %eax
	movb	_table98typlen(%eax), %al
	andl	$7, %eax
	movb	%al, -58(%ebp)
	movzbl	-57(%ebp), %eax
	andl	$7, %eax
	movb	_table98range(%eax), %al
	movb	%al, -73(%ebp)
	leal	8(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	jmp	L199
L228:
	cmpb	$-17, -57(%ebp)
	ja	L229
	movl	16(%ebp), %eax
	movb	-57(%ebp), %dl
	movb	%dl, (%eax)
	incl	16(%ebp)
	jmp	L167
L229:
	cmpb	$-9, -57(%ebp)
	ja	L167
	movb	-57(%ebp), %al
	addl	$17, %eax
	movb	%al, -58(%ebp)
	jmp	L181
L232:
	nop
	jmp	L167
L233:
	nop
	jmp	L167
L236:
	nop
L167:
	movl	-28(%ebp), %eax
	movl	16(%eax), %edx
	movl	8(%ebp), %eax
	cmpl	%eax, %edx
	ja	L230
	addl	$20, -28(%ebp)
L166:
	movl	-28(%ebp), %eax
	cmpl	-72(%ebp), %eax
	jb	L231
	movl	_label0, %eax
	movl	%eax, (%esp)
	call	_free
	movl	_subsect0, %eax
	movl	%eax, (%esp)
	call	_free
	movl	-64(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	-68(%ebp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	16(%ebp), %eax
L170:
	addl	$188, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
.globl _skip_mc30
	.def	_skip_mc30;	.scl	2;	.type	32;	.endef
_skip_mc30:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	16(%ebp), %eax
	movb	%al, -12(%ebp)
	movsbl	-12(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_LL_skip_mc30
	leave
	ret
.globl _solve_subsection
	.def	_solve_subsection;	.scl	2;	.type	32;	.endef
_solve_subsection:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$264, %esp
	movl	12(%ebp), %eax
	movb	%al, -236(%ebp)
	movl	$0, -16(%ebp)
	movl	$0, -20(%ebp)
	movl	$0, -24(%ebp)
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, -212(%ebp)
	jmp	L239
L319:
	movl	-212(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -213(%ebp)
	incl	%eax
	movl	%eax, -212(%ebp)
	movb	-213(%ebp), %al
	cmpb	$45, %al
	jne	L240
	movl	-212(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -212(%ebp)
	movl	-212(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -212(%ebp)
	jmp	L239
L240:
	movb	-213(%ebp), %al
	cmpb	$14, %al
	jne	L241
	movl	-212(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -212(%ebp)
	jmp	L239
L241:
	movb	-213(%ebp), %al
	cmpb	$15, %al
	jne	L242
	movl	-212(%ebp), %eax
	movl	-212(%ebp), %edx
	incl	%edx
	movb	(%edx), %dl
	movzbl	%dl, %edx
	subl	$5, %edx
	addl	%edx, %eax
	movl	%eax, -212(%ebp)
	jmp	L239
L242:
	movb	-213(%ebp), %al
	cmpb	$44, %al
	jne	L243
	movl	-212(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -212(%ebp)
	jmp	L239
L243:
	movb	-213(%ebp), %al
	cmpb	$59, %al
	ja	L244
	jmp	L245
L326:
	nop
L245:
	movl	-212(%ebp), %eax
	leal	-1(%eax), %edx
	movl	$1, 8(%esp)
	leal	-213(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	movb	-213(%ebp), %al
	movzbl	%al, %eax
	addl	%eax, -20(%ebp)
	jmp	L239
L244:
	movb	-213(%ebp), %al
	cmpb	$88, %al
	jne	L246
	movl	-212(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -212(%ebp)
	jmp	L239
L246:
	movb	-213(%ebp), %al
	cmpb	$89, %al
	jne	L247
	movl	-212(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-212(%ebp), %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	movl	-212(%ebp), %edx
	incl	%edx
	movb	(%edx), %dl
	movzbl	%dl, %edx
	sall	$8, %edx
	orl	%eax, %edx
	movl	-212(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	sall	$16, %eax
	orl	%eax, %edx
	movl	-212(%ebp), %eax
	addl	$3, %eax
	movb	(%eax), %al
	movzbl	%al, %eax
	sall	$24, %eax
	orl	%edx, %eax
	movl	%eax, -32(%ebp)
	movl	-212(%ebp), %eax
	addl	$4, %eax
	movl	%eax, -212(%ebp)
	leal	-212(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-132(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	-32(%ebp), %eax
	cmpl	$-17, %eax
	ja	L248
	movl	-32(%ebp), %eax
	leal	-1(%eax), %edx
	movl	-132(%ebp), %eax
	imull	%edx, %eax
	addl	%eax, -20(%ebp)
	movl	-212(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -212(%ebp)
	jmp	L239
L248:
	movl	-132(%ebp), %eax
	movl	%eax, -32(%ebp)
	leal	-212(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-132(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	-124(%ebp), %eax
	andl	$6, %eax
	testl	%eax, %eax
	jne	L321
L249:
	movl	-124(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	L251
	cmpb	$1, -236(%ebp)
	jg	L322
L252:
	movl	$1073741824, -24(%ebp)
	incl	-16(%ebp)
	jmp	L239
L251:
	movl	-132(%ebp), %eax
	decl	%eax
	imull	-32(%ebp), %eax
	addl	%eax, -20(%ebp)
	movl	-128(%ebp), %eax
	testl	%eax, %eax
	jne	L253
	movl	-132(%ebp), %eax
	movb	%al, %dl
	movl	-28(%ebp), %eax
	movb	%dl, (%eax)
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-132(%ebp), %eax
	sarl	$8, %eax
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	leal	2(%eax), %edx
	movl	-132(%ebp), %eax
	sarl	$16, %eax
	movb	%al, (%edx)
	movl	-28(%ebp), %eax
	leal	3(%eax), %edx
	movl	-132(%ebp), %eax
	shrl	$24, %eax
	movb	%al, (%edx)
	jmp	L239
L253:
	cmpb	$1, -236(%ebp)
	jg	L250
	movl	-128(%ebp), %edx
	movl	-32(%ebp), %eax
	imull	%edx, %eax
	addl	%eax, -24(%ebp)
	incl	-16(%ebp)
	jmp	L239
L321:
	nop
	jmp	L250
L322:
	nop
L250:
	movl	-28(%ebp), %eax
	movb	$-2, (%eax)
	jmp	L239
L247:
	movb	-213(%ebp), %al
	cmpb	$104, %al
	jne	L254
	movl	-212(%ebp), %eax
	incl	%eax
	movl	%eax, -212(%ebp)
	jmp	L239
L254:
	movb	-213(%ebp), %al
	cmpb	$119, %al
	ja	L255
	movb	-213(%ebp), %al
	movzbl	%al, %eax
	andl	$7, %eax
	leal	(%eax,%eax), %edx
	leal	-56(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, %edx
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	movl	-36(%ebp), %eax
	movb	(%eax), %dl
	movl	-36(%ebp), %eax
	movb	%dl, 1(%eax)
	jmp	L239
L255:
	movb	-213(%ebp), %al
	testb	%al, %al
	js	L256
	movb	-213(%ebp), %al
	movzbl	%al, %eax
	andl	$7, %eax
	leal	(%eax,%eax), %edx
	leal	-56(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	addl	%eax, -20(%ebp)
	movl	-36(%ebp), %eax
	movb	1(%eax), %al
	movsbl	%al, %edx
	movl	-36(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, -24(%ebp)
	jmp	L239
L256:
	movb	-213(%ebp), %al
	cmpb	$-111, %al
	ja	L257
	movb	-213(%ebp), %al
	movb	%al, -214(%ebp)
	movl	-212(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movb	%al, -213(%ebp)
	movb	-213(%ebp), %al
	movzbl	%al, %eax
	andl	$7, %eax
	leal	(%eax,%eax), %edx
	leal	-56(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -36(%ebp)
	movb	-213(%ebp), %al
	shrb	$4, %al
	movzbl	%al, %eax
	andl	$7, %eax
	leal	(%eax,%eax), %edx
	leal	-56(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	addl	$2, %eax
	movl	%eax, -12(%ebp)
	movb	-214(%ebp), %al
	cmpb	$-112, %al
	jne	L258
	movl	$0, -12(%ebp)
L258:
	movl	-212(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -215(%ebp)
	movb	-215(%ebp), %al
	movzbl	%al, %eax
	andl	$15, %eax
	cmpl	$15, %eax
	je	L259
	movl	-212(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	movb	%al, -214(%ebp)
	movl	-212(%ebp), %eax
	addl	$3, %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -212(%ebp)
	movb	-214(%ebp), %al
	movb	%al, %dl
	andl	$15, %edx
	movl	-36(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-36(%ebp), %eax
	movb	1(%eax), %dl
	movl	-36(%ebp), %eax
	movb	%dl, (%eax)
	movb	-214(%ebp), %al
	shrb	$4, %al
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-40(%ebp), %eax
	movb	1(%eax), %dl
	movl	-40(%ebp), %eax
	movb	%dl, (%eax)
	movb	$2, -214(%ebp)
	movb	-213(%ebp), %al
	testb	%al, %al
	jns	L260
	movb	$3, -214(%ebp)
L260:
	cmpl	$0, -12(%ebp)
	je	L261
	movb	-215(%ebp), %al
	shrb	$4, %al
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-12(%ebp), %eax
	movb	1(%eax), %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
	movb	-214(%ebp), %al
	sall	%eax
	movb	%al, -214(%ebp)
L261:
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	movb	-214(%ebp), %al
	decl	%eax
	movb	%al, -214(%ebp)
	movb	-214(%ebp), %al
	testb	%al, %al
	jne	L261
	jmp	L239
L259:
	movl	-212(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-212(%ebp), %eax
	addl	$3, %eax
	movl	%eax, -212(%ebp)
	leal	-212(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-132(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movb	$7, -214(%ebp)
	movl	-124(%ebp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	jne	L262
	movl	-132(%ebp), %eax
	movl	%eax, %edx
	movl	-128(%ebp), %eax
	leal	(%edx,%eax), %eax
	movl	%eax, -32(%ebp)
	movl	-120(%ebp), %eax
	testl	%eax, %eax
	je	L263
	movb	$1, -214(%ebp)
	jmp	L262
L263:
	movl	-132(%ebp), %eax
	testl	%eax, %eax
	jne	L264
	cmpl	$0, -32(%ebp)
	jne	L264
	movb	$4, -214(%ebp)
	jmp	L262
L264:
	movl	-132(%ebp), %eax
	cmpl	$-128, %eax
	jl	L265
	cmpl	$127, -32(%ebp)
	jg	L265
	movb	$2, -214(%ebp)
	movl	-132(%ebp), %eax
	testl	%eax, %eax
	jg	L262
	cmpl	$0, -32(%ebp)
	js	L323
	movb	$6, -214(%ebp)
	jmp	L262
L265:
	movb	$1, -214(%ebp)
	movl	-132(%ebp), %eax
	cmpl	$127, %eax
	jg	L262
	cmpl	$-128, -32(%ebp)
	jl	L262
	movb	$3, -214(%ebp)
	movl	-132(%ebp), %eax
	testl	%eax, %eax
	jg	L262
	cmpl	$0, -32(%ebp)
	js	L262
	movb	$7, -214(%ebp)
	jmp	L262
L323:
	nop
L262:
	cmpb	$0, -236(%ebp)
	je	L267
	movb	-214(%ebp), %al
	movzbl	%al, %eax
	andl	$1, %eax
	testb	%al, %al
	je	L268
	movb	$1, -214(%ebp)
	jmp	L267
L268:
	movb	$2, -214(%ebp)
L267:
	movb	-213(%ebp), %al
	testb	%al, %al
	js	L269
	movb	-214(%ebp), %al
	andl	$3, %eax
	movb	%al, -214(%ebp)
	movb	-214(%ebp), %al
	testb	%al, %al
	jne	L269
	movb	$2, -214(%ebp)
L269:
	movl	-40(%ebp), %eax
	movb	$127, (%eax)
	movl	-40(%ebp), %eax
	movb	(%eax), %dl
	movl	-36(%ebp), %eax
	movb	%dl, (%eax)
	movl	-40(%ebp), %eax
	movb	$-128, 1(%eax)
	movl	-40(%ebp), %eax
	movb	1(%eax), %dl
	movl	-36(%ebp), %eax
	movb	%dl, 1(%eax)
	cmpl	$0, -12(%ebp)
	je	L270
	movl	-12(%ebp), %eax
	movb	$127, (%eax)
	movl	-12(%ebp), %eax
	movb	$-128, 1(%eax)
L270:
	movb	$1, -215(%ebp)
	jmp	L271
L284:
	movb	-215(%ebp), %al
	cmpb	$4, %al
	jne	L272
	movb	-213(%ebp), %al
	testb	%al, %al
	jns	L324
L272:
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	leal	-216(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	cmpl	$0, -12(%ebp)
	je	L274
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	leal	-217(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
L274:
	movb	-214(%ebp), %dl
	movb	-215(%ebp), %al
	andl	%edx, %eax
	testb	%al, %al
	je	L275
	movl	-40(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %edx
	movb	-216(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jle	L276
	movb	-216(%ebp), %al
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, (%eax)
L276:
	movl	-40(%ebp), %eax
	movb	1(%eax), %al
	movsbl	%al, %edx
	movb	-216(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jge	L277
	movb	-216(%ebp), %al
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 1(%eax)
L277:
	cmpl	$0, -12(%ebp)
	je	L278
	movl	-12(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %edx
	movb	-217(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jle	L279
	movb	-217(%ebp), %al
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
L279:
	movl	-12(%ebp), %eax
	movb	1(%eax), %al
	movsbl	%al, %edx
	movb	-217(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jge	L278
	movb	-217(%ebp), %al
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, 1(%eax)
L278:
	movb	$2, -216(%ebp)
	movb	-213(%ebp), %al
	movzbl	%al, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L280
	movb	$4, -216(%ebp)
L280:
	movb	-215(%ebp), %al
	cmpb	$2, %al
	jne	L281
	movb	$1, -216(%ebp)
L281:
	movb	-215(%ebp), %al
	cmpb	$4, %al
	jne	L282
	movb	$0, -216(%ebp)
L282:
	movl	-36(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %edx
	movb	-216(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jle	L283
	movb	-216(%ebp), %al
	movb	%al, %dl
	movl	-36(%ebp), %eax
	movb	%dl, (%eax)
L283:
	movl	-36(%ebp), %eax
	movb	1(%eax), %al
	movsbl	%al, %edx
	movb	-216(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jge	L275
	movb	-216(%ebp), %al
	movb	%al, %dl
	movl	-36(%ebp), %eax
	movb	%dl, 1(%eax)
L275:
	movb	-215(%ebp), %al
	sall	%eax
	movb	%al, -215(%ebp)
L271:
	movb	-215(%ebp), %al
	cmpb	$4, %al
	jbe	L284
	jmp	L273
L324:
	nop
L273:
	movb	-214(%ebp), %al
	movzbl	%al, %eax
	movb	-214(%ebp), %dl
	movzbl	%dl, %edx
	decl	%edx
	andl	%edx, %eax
	testl	%eax, %eax
	jne	L285
	movb	$0, -213(%ebp)
	movb	-214(%ebp), %al
	cmpb	$2, %al
	jne	L286
	movb	$1, -213(%ebp)
L286:
	movb	-214(%ebp), %al
	cmpb	$4, %al
	jne	L287
	movb	$2, -213(%ebp)
L287:
	movb	-213(%ebp), %dl
	movl	-28(%ebp), %eax
	movb	%dl, (%eax)
	cmpl	$0, -12(%ebp)
	je	L288
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	sall	$4, %eax
	orl	%edx, %eax
	movb	%al, %dl
	movl	-28(%ebp), %eax
	movb	%dl, (%eax)
L288:
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-36(%ebp), %eax
	movb	(%eax), %cl
	movl	-40(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	sall	$4, %eax
	orl	%ecx, %eax
	movb	%al, (%edx)
	jmp	L239
L285:
	incl	-16(%ebp)
	jmp	L239
L257:
	movb	-213(%ebp), %al
	cmpb	$-107, %al
	ja	L290
	movb	-213(%ebp), %al
	movb	%al, -214(%ebp)
	movl	-212(%ebp), %eax
	addl	$2, %eax
	movb	(%eax), %al
	movb	%al, -213(%ebp)
	movb	-213(%ebp), %al
	movzbl	%al, %eax
	andl	$7, %eax
	leal	(%eax,%eax), %edx
	leal	-56(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -36(%ebp)
	movb	-213(%ebp), %al
	shrb	$4, %al
	movzbl	%al, %eax
	andl	$7, %eax
	leal	(%eax,%eax), %edx
	leal	-56(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	addl	$2, %eax
	movl	%eax, -12(%ebp)
	movb	-214(%ebp), %al
	cmpb	$-108, %al
	jne	L291
	movl	$0, -12(%ebp)
L291:
	movl	-212(%ebp), %eax
	movb	(%eax), %al
	movb	%al, -217(%ebp)
	movb	-217(%ebp), %al
	movzbl	%al, %eax
	andl	$15, %eax
	cmpl	$15, %eax
	je	L292
	movl	-212(%ebp), %eax
	incl	%eax
	movb	(%eax), %al
	movb	%al, -214(%ebp)
	movl	-212(%ebp), %eax
	addl	$3, %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -212(%ebp)
	movl	-212(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -215(%ebp)
	incl	%eax
	movl	%eax, -212(%ebp)
	movb	-214(%ebp), %al
	movb	%al, %dl
	andl	$15, %edx
	movl	-36(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-36(%ebp), %eax
	movb	1(%eax), %dl
	movl	-36(%ebp), %eax
	movb	%dl, (%eax)
	movb	-214(%ebp), %al
	shrb	$4, %al
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-40(%ebp), %eax
	movb	1(%eax), %dl
	movl	-40(%ebp), %eax
	movb	%dl, (%eax)
	cmpl	$0, -12(%ebp)
	je	L293
	movb	-217(%ebp), %al
	shrb	$4, %al
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-12(%ebp), %eax
	movb	1(%eax), %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
L293:
	movl	-212(%ebp), %eax
	movl	$0, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	cmpl	$0, -12(%ebp)
	je	L325
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	jmp	L295
L296:
	movl	-212(%ebp), %eax
	movl	%eax, (%esp)
	call	_skip_expr
	movl	%eax, -212(%ebp)
	movl	-212(%ebp), %eax
	movl	$0, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	cmpl	$0, -12(%ebp)
	je	L295
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	jmp	L295
L325:
	nop
L295:
	movb	-215(%ebp), %al
	decl	%eax
	movb	%al, -215(%ebp)
	movb	-215(%ebp), %al
	testb	%al, %al
	jne	L296
	jmp	L239
L292:
	movl	-212(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-212(%ebp), %eax
	addl	$3, %eax
	movl	%eax, -212(%ebp)
	leal	-212(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-132(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	-212(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -213(%ebp)
	incl	%eax
	movl	%eax, -212(%ebp)
	movl	-36(%ebp), %eax
	movl	%eax, %edx
	movl	-212(%ebp), %eax
	movl	$0, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	movl	-40(%ebp), %eax
	movl	%eax, %edx
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	movl	-36(%ebp), %eax
	movb	(%eax), %dl
	movl	-36(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-40(%ebp), %eax
	movb	(%eax), %dl
	movl	-40(%ebp), %eax
	movb	%dl, 1(%eax)
	cmpl	$0, -12(%ebp)
	je	L297
	movl	-12(%ebp), %eax
	movl	%eax, %edx
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	movl	-12(%ebp), %eax
	movb	(%eax), %dl
	movl	-12(%ebp), %eax
	movb	%dl, 1(%eax)
L297:
	movb	$0, -216(%ebp)
	cmpb	$0, -236(%ebp)
	jne	L298
	movl	-128(%ebp), %eax
	testl	%eax, %eax
	jne	L299
	movl	-124(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	L300
L299:
	movb	$-1, -216(%ebp)
L300:
	movb	$1, -217(%ebp)
	jmp	L301
L313:
	leal	-212(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-208(%ebp), %eax
	movl	%eax, (%esp)
	call	_calc_value
	movl	-204(%ebp), %eax
	testl	%eax, %eax
	jne	L302
	movl	-200(%ebp), %eax
	andl	$1, %eax
	testb	%al, %al
	je	L303
L302:
	movb	$-1, -216(%ebp)
L303:
	movl	-212(%ebp), %eax
	movl	$0, 8(%esp)
	leal	-214(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	leal	-215(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
	cmpl	$0, -12(%ebp)
	je	L304
	movl	-212(%ebp), %eax
	movl	$1, 8(%esp)
	leal	-218(%ebp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_skip_mc30
	movl	%eax, -212(%ebp)
L304:
	movb	-216(%ebp), %al
	cmpb	$-1, %al
	je	L305
	movl	-132(%ebp), %edx
	movl	-208(%ebp), %eax
	movl	%edx, %ecx
	xorl	%eax, %ecx
	movl	-120(%ebp), %edx
	movl	-196(%ebp), %eax
	xorl	%edx, %eax
	orl	%ecx, %eax
	movl	-112(%ebp), %ecx
	movl	-188(%ebp), %edx
	xorl	%ecx, %edx
	movl	%eax, %ecx
	orl	%edx, %ecx
	movl	-116(%ebp), %edx
	movl	-192(%ebp), %eax
	xorl	%edx, %eax
	orl	%eax, %ecx
	movl	-108(%ebp), %edx
	movl	-184(%ebp), %eax
	xorl	%edx, %eax
	orl	%ecx, %eax
	testl	%eax, %eax
	jne	L306
	movb	-214(%ebp), %al
	movb	%al, %dl
	movl	-36(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-36(%ebp), %eax
	movb	1(%eax), %dl
	movl	-36(%ebp), %eax
	movb	%dl, (%eax)
	movb	-215(%ebp), %al
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-40(%ebp), %eax
	movb	1(%eax), %dl
	movl	-40(%ebp), %eax
	movb	%dl, (%eax)
	cmpl	$0, -12(%ebp)
	je	L307
	movb	-218(%ebp), %al
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	%dl, 1(%eax)
	movl	-12(%ebp), %eax
	movb	1(%eax), %dl
	movl	-12(%ebp), %eax
	movb	%dl, (%eax)
L307:
	movb	-217(%ebp), %al
	movb	%al, -216(%ebp)
	jmp	L306
L305:
	movl	-36(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %edx
	movb	-214(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jle	L308
	movb	-214(%ebp), %al
	movb	%al, %dl
	movl	-36(%ebp), %eax
	movb	%dl, (%eax)
L308:
	movl	-36(%ebp), %eax
	movb	1(%eax), %al
	movsbl	%al, %edx
	movb	-214(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jge	L309
	movb	-214(%ebp), %al
	movb	%al, %dl
	movl	-36(%ebp), %eax
	movb	%dl, 1(%eax)
L309:
	movl	-40(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %edx
	movb	-215(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jle	L310
	movb	-215(%ebp), %al
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, (%eax)
L310:
	movl	-40(%ebp), %eax
	movb	1(%eax), %al
	movsbl	%al, %edx
	movb	-215(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jge	L311
	movb	-215(%ebp), %al
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 1(%eax)
L311:
	cmpl	$0, -12(%ebp)
	je	L306
	movl	-40(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %edx
	movb	-218(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jle	L312
	movb	-218(%ebp), %al
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, (%eax)
L312:
	movl	-40(%ebp), %eax
	movb	1(%eax), %al
	movsbl	%al, %edx
	movb	-218(%ebp), %al
	movzbl	%al, %eax
	cmpl	%eax, %edx
	jge	L306
	movb	-218(%ebp), %al
	movb	%al, %dl
	movl	-40(%ebp), %eax
	movb	%dl, 1(%eax)
L306:
	movb	-217(%ebp), %al
	incl	%eax
	movb	%al, -217(%ebp)
L301:
	movb	-217(%ebp), %dl
	movb	-213(%ebp), %al
	cmpb	%al, %dl
	jb	L313
L298:
	movb	-216(%ebp), %al
	cmpb	$-1, %al
	je	L314
	movb	-216(%ebp), %dl
	movl	-28(%ebp), %eax
	movb	%dl, (%eax)
	cmpl	$0, -12(%ebp)
	je	L315
	movl	-28(%ebp), %eax
	movb	(%eax), %al
	movb	%al, %dl
	movl	-12(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	sall	$4, %eax
	orl	%edx, %eax
	movb	%al, %dl
	movl	-28(%ebp), %eax
	movb	%dl, (%eax)
L315:
	movl	-28(%ebp), %eax
	leal	1(%eax), %edx
	movl	-36(%ebp), %eax
	movb	(%eax), %cl
	movl	-40(%ebp), %eax
	movb	(%eax), %al
	movsbl	%al, %eax
	sall	$4, %eax
	orl	%ecx, %eax
	movb	%al, (%edx)
	jmp	L239
L314:
	incl	-16(%ebp)
	jmp	L239
L290:
	movb	-213(%ebp), %al
	cmpb	$-98, %al
	jbe	L326
L317:
	movb	-213(%ebp), %al
	cmpb	$-17, %al
	jbe	L327
L318:
	movb	-213(%ebp), %al
	cmpb	$-9, %al
	ja	L239
	movl	-212(%ebp), %eax
	movb	-213(%ebp), %dl
	movzbl	%dl, %edx
	subl	$239, %edx
	addl	%edx, %eax
	movl	%eax, -212(%ebp)
	jmp	L239
L327:
	nop
L239:
	movl	8(%ebp), %eax
	movl	16(%eax), %edx
	movl	-212(%ebp), %eax
	cmpl	%eax, %edx
	ja	L319
	cmpl	$1073741824, -24(%ebp)
	jbe	L320
	movl	$1073741824, -24(%ebp)
L320:
	movl	8(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	-24(%ebp), %edx
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, 8(%eax)
	movl	-16(%ebp), %eax
	leave
	ret
.globl _calcsigma
	.def	_calcsigma;	.scl	2;	.type	32;	.endef
_calcsigma:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$32, %esp
	movl	$0, -8(%ebp)
	jmp	L329
L339:
	movl	8(%ebp), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)
	cmpl	$0, -28(%ebp)
	je	L340
L330:
	movl	8(%ebp), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	$0, (%eax)
	movl	8(%ebp), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	L341
L332:
	movl	8(%ebp), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$36, %eax
	movl	$0, (%eax)
	movl	_subsect0, %ecx
	movl	8(%ebp), %ebx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, -24(%ebp)
	movl	8(%ebp), %ecx
	movl	-8(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$32, %eax
	movl	$0, (%eax)
	movl	$0, -20(%ebp)
	movl	$0, -16(%ebp)
L335:
	movl	-24(%ebp), %eax
	movl	(%eax), %edx
	movl	-16(%ebp), %eax
	leal	(%edx,%eax), %eax
	movl	%eax, -16(%ebp)
	movl	-24(%ebp), %eax
	movl	4(%eax), %eax
	addl	%eax, -20(%ebp)
	cmpl	$1073741824, -20(%ebp)
	jbe	L334
	movl	$1073741824, -20(%ebp)
L334:
	addl	$20, -24(%ebp)
	decl	-12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	L335
	cmpl	$1073741823, -20(%ebp)
	jbe	L336
	movl	8(%ebp), %eax
	movl	$1073741824, 4(%eax)
L336:
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	cmpl	$1073741823, %eax
	jbe	L337
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, %edx
	orl	$1, %edx
	movl	8(%ebp), %eax
	movl	%edx, 8(%eax)
	jmp	L333
L337:
	cmpl	$0, -28(%ebp)
	jle	L338
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-28(%ebp), %eax
	imull	-16(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	-28(%ebp), %eax
	imull	-20(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L333
L338:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, %edx
	movl	-16(%ebp), %eax
	movl	%eax, %ecx
	addl	-20(%ebp), %ecx
	movl	-28(%ebp), %eax
	imull	%ecx, %eax
	leal	(%edx,%eax), %eax
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	-28(%ebp), %eax
	imull	-20(%ebp), %eax
	subl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	jmp	L333
L341:
	nop
L333:
	incl	-8(%ebp)
L329:
	cmpl	$3, -8(%ebp)
	jle	L339
	jmp	L328
L340:
	nop
L328:
	addl	$32, %esp
	popl	%ebx
	leave
	ret
.globl _addsigma
	.def	_addsigma;	.scl	2;	.type	32;	.endef
_addsigma:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$20, %esp
L343:
	movl	$0, -16(%ebp)
	jmp	L344
L362:
	movl	16(%ebp), %edx
	movl	20(%ebp), %eax
	leal	(%edx,%eax), %ebx
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %eax
	cmpl	%eax, %ebx
	jbe	L366
L345:
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %ecx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %eax
	leal	(%ecx,%eax), %edx
	movl	16(%ebp), %eax
	cmpl	%eax, %edx
	ja	L347
	incl	-16(%ebp)
	jmp	L344
L347:
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %edx
	movl	16(%ebp), %eax
	cmpl	%eax, %edx
	jne	L348
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %edx
	movl	20(%ebp), %eax
	cmpl	%eax, %edx
	ja	L348
L349:
	movl	20(%ebp), %ecx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %eax
	movl	%ecx, %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, 20(%ebp)
	movl	16(%ebp), %ecx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %eax
	leal	(%ecx,%eax), %eax
	movl	%eax, 16(%ebp)
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$28, %eax
	movl	%ecx, (%eax)
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	L350
L351:
	movl	-16(%ebp), %eax
	movl	%eax, -20(%ebp)
	jmp	L352
L353:
	movl	-20(%ebp), %eax
	leal	1(%eax), %ecx
	movl	8(%ebp), %ebx
	movl	-20(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	leal	16(%eax), %ebx
	movl	8(%ebp), %edx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%edx,%eax), %eax
	addl	$16, %eax
	leal	12(%ebx), %edx
	leal	12(%eax), %ebx
	movl	$3, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	incl	-20(%ebp)
L352:
	cmpl	$2, -20(%ebp)
	jle	L353
	movl	8(%ebp), %eax
	movl	$0, 64(%eax)
	movl	8(%ebp), %eax
	movl	$0, 68(%eax)
	movl	8(%ebp), %eax
	movl	$0, 72(%eax)
L350:
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	L354
	cmpl	$0, -16(%ebp)
	jle	L354
	movl	-16(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%edx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %ecx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %eax
	cmpl	%eax, %ecx
	jne	L354
	movl	-16(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%edx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %edx
	movl	-16(%ebp), %eax
	leal	-1(%eax), %ebx
	movl	8(%ebp), %ecx
	movl	%ebx, %eax
	sall	%eax
	addl	%ebx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %eax
	leal	(%edx,%eax), %ebx
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %eax
	cmpl	%eax, %ebx
	jne	L354
	movl	-16(%ebp), %eax
	leal	-1(%eax), %ebx
	movl	-16(%ebp), %eax
	leal	-1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%edx,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %ecx
	movl	8(%ebp), %esi
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%esi,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %eax
	leal	(%ecx,%eax), %edx
	movl	8(%ebp), %ecx
	movl	%ebx, %eax
	sall	%eax
	addl	%ebx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$36, %eax
	movl	%edx, (%eax)
	jmp	L351
L354:
	incl	-16(%ebp)
	cmpl	$3, -16(%ebp)
	jle	L350
	movl	20(%ebp), %eax
	testl	%eax, %eax
	je	L367
	jmp	L343
L348:
	movl	8(%ebp), %eax
	movl	64(%eax), %eax
	testl	%eax, %eax
	je	L356
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calcsigma
	jmp	L343
L356:
	movl	$2, -20(%ebp)
	jmp	L357
L358:
	movl	-20(%ebp), %eax
	leal	1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%edx,%eax), %eax
	leal	16(%eax), %ebx
	movl	8(%ebp), %ecx
	movl	-20(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$16, %eax
	leal	12(%ebx), %edx
	leal	12(%eax), %ebx
	movl	$3, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	decl	-20(%ebp)
L357:
	movl	-16(%ebp), %eax
	cmpl	-20(%ebp), %eax
	jle	L358
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %edx
	movl	16(%ebp), %eax
	cmpl	%eax, %edx
	jne	L359
	movl	20(%ebp), %edx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$36, %eax
	movl	%edx, (%eax)
	movl	-16(%ebp), %eax
	leal	1(%eax), %ebx
	movl	-16(%ebp), %eax
	leal	1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%edx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %edx
	movl	20(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %ecx
	movl	%ebx, %eax
	sall	%eax
	addl	%ebx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$32, %eax
	movl	%edx, (%eax)
	movl	-16(%ebp), %eax
	leal	1(%eax), %ebx
	movl	-16(%ebp), %eax
	leal	1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%edx,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %edx
	movl	20(%ebp), %eax
	subl	%eax, %edx
	movl	8(%ebp), %ecx
	movl	%ebx, %eax
	sall	%eax
	addl	%ebx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$36, %eax
	movl	%edx, (%eax)
	jmp	L349
L359:
	movl	16(%ebp), %ecx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %eax
	cmpl	%eax, %ecx
	jae	L360
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %edx
	movl	16(%ebp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %edx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$36, %eax
	movl	%edx, (%eax)
	movl	16(%ebp), %edx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$32, %eax
	movl	%edx, (%eax)
	movl	12(%ebp), %edx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$28, %eax
	movl	%edx, (%eax)
	movl	20(%ebp), %edx
	movl	-20(%ebp), %eax
	movl	%edx, %esi
	subl	%eax, %esi
	movl	%esi, %eax
	movl	%eax, 20(%ebp)
	movl	16(%ebp), %edx
	movl	-20(%ebp), %eax
	leal	(%edx,%eax), %eax
	movl	%eax, 16(%ebp)
	jmp	L361
L360:
	movl	16(%ebp), %ecx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$32, %eax
	movl	(%eax), %eax
	movl	%ecx, %edi
	subl	%eax, %edi
	movl	%edi, %eax
	movl	%eax, -20(%ebp)
	movl	-20(%ebp), %edx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$36, %eax
	movl	%edx, (%eax)
L361:
	incl	-16(%ebp)
	movl	16(%ebp), %edx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %ecx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$32, %eax
	movl	%edx, (%eax)
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$36, %eax
	movl	(%eax), %edx
	movl	-20(%ebp), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	8(%ebp), %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ebx,%eax), %eax
	addl	$36, %eax
	movl	%ecx, (%eax)
	jmp	L347
L344:
	cmpl	$3, -16(%ebp)
	jg	L346
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$28, %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	jne	L362
	jmp	L346
L366:
	nop
L346:
	movl	8(%ebp), %eax
	movl	64(%eax), %eax
	testl	%eax, %eax
	je	L363
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_calcsigma
	jmp	L343
L363:
	movl	$2, -20(%ebp)
	jmp	L364
L365:
	movl	-20(%ebp), %eax
	leal	1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, %eax
	sall	%eax
	addl	%ecx, %eax
	sall	$2, %eax
	leal	(%edx,%eax), %eax
	leal	16(%eax), %ebx
	movl	8(%ebp), %ecx
	movl	-20(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$16, %eax
	leal	12(%ebx), %edx
	leal	12(%eax), %ebx
	movl	$3, %eax
	movl	%edx, %edi
	movl	%ebx, %esi
	movl	%eax, %ecx
	rep movsl
	decl	-20(%ebp)
L364:
	movl	-16(%ebp), %eax
	cmpl	-20(%ebp), %eax
	jle	L365
	movl	8(%ebp), %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	sall	%eax
	addl	%edx, %eax
	sall	$2, %eax
	leal	(%ecx,%eax), %eax
	addl	$16, %eax
	leal	12(%eax), %ebx
	leal	12(%ebp), %edx
	movl	$3, %eax
	movl	%ebx, %edi
	movl	%edx, %esi
	movl	%eax, %ecx
	rep movsl
	movl	$0, 20(%ebp)
	jmp	L350
L367:
	nop
L342:
	addl	$20, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
	.def	_LL_skip_expr;	.scl	2;	.type	32;	.endef
	.def	_malloc;	.scl	2;	.type	32;	.endef
	.def	_LL_skipcode;	.scl	2;	.type	32;	.endef
	.def	_free;	.scl	2;	.type	32;	.endef
	.def	_LL_skip_mc30;	.scl	2;	.type	32;	.endef
