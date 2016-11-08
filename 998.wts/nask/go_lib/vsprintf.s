	.file	"vsprintf.c"
	.section .rdata,"dr"
LC0:
	.ascii "GO_vsprintf:mikan-trap!\12\0"
LC1:
	.ascii "string-field_max error!\12\0"
LC2:
	.ascii "int-field_max error!\12\0"
LC3:
	.ascii "\"%s\"\12\0"
	.text
.globl _GO_vsprintf
	.def	_GO_vsprintf;	.scl	2;	.type	32;	.endef
_GO_vsprintf:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$124, %esp
	movl	16(%ebp), %ebx
	movl	8(%ebp), %esi
	movb	$0, -33(%ebp)
	leal	-33(%ebp), %eax
	movl	%eax, -92(%ebp)
L60:
	movl	12(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -25(%ebp)
	leal	1(%eax), %ecx
	movl	%ecx, 12(%ebp)
	cmpb	$37, %dl
	je	L3
L4:
	movb	-25(%ebp), %al
	movb	%al, (%esi)
	incl	%esi
	testb	%al, %al
	jne	L60
	movl	8(%ebp), %eax
	notl	%eax
	leal	(%esi,%eax), %eax
	addl	$124, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
L3:
	movb	1(%eax), %dl
	movb	%dl, -25(%ebp)
	addl	$2, %eax
	movl	%eax, 12(%ebp)
	movb	$0, -76(%ebp)
	movb	$0, -78(%ebp)
L8:
	movb	-25(%ebp), %al
	cmpb	$45, %al
	je	L46
	cmpb	$48, %al
	jne	L7
	movb	$1, -76(%ebp)
	jmp	L6
L46:
	movb	$1, -78(%ebp)
L6:
	movl	12(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -25(%ebp)
	incl	%eax
	movl	%eax, 12(%ebp)
	jmp	L8
L7:
	leal	-49(%eax), %edx
	cmpb	$8, %dl
	ja	L9
	decl	12(%ebp)
	leal	-25(%ebp), %edx
	movl	%edx, 8(%esp)
	movl	$10, 4(%esp)
	leal	12(%ebp), %ecx
	movl	%ecx, (%esp)
	call	_GO_strtoul0
	movl	%eax, %edi
	movl	12(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -25(%ebp)
	incl	%eax
	movl	%eax, 12(%ebp)
	jmp	L10
L9:
	xorl	%edi, %edi
	cmpb	$42, %al
	jne	L10
	movl	(%ebx), %edi
	movl	12(%ebp), %eax
	movb	(%eax), %dl
	movb	%dl, -25(%ebp)
	incl	%eax
	movl	%eax, 12(%ebp)
	addl	$4, %ebx
L10:
	movl	$2147483647, %edx
	cmpb	$46, -25(%ebp)
	jne	L11
	movl	12(%ebp), %eax
	movb	(%eax), %cl
	movb	%cl, -93(%ebp)
	movb	%cl, -25(%ebp)
	leal	1(%eax), %ecx
	movl	%ecx, 12(%ebp)
	movb	-93(%ebp), %cl
	subl	$49, %ecx
	cmpb	$8, %cl
	ja	L12
	movl	%eax, 12(%ebp)
	leal	-25(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$10, 4(%esp)
	leal	12(%ebp), %ecx
	movl	%ecx, (%esp)
	movl	%edx, -84(%ebp)
	call	_GO_strtoul0
	movl	%eax, %edi
	movl	12(%ebp), %eax
	movb	(%eax), %cl
	movb	%cl, -25(%ebp)
	incl	%eax
	movl	%eax, 12(%ebp)
	movl	-84(%ebp), %edx
	jmp	L11
L12:
	cmpb	$42, -93(%ebp)
	jne	L11
	movl	(%ebx), %edx
	movb	1(%eax), %cl
	movb	%cl, -25(%ebp)
	addl	$2, %eax
	movl	%eax, 12(%ebp)
	addl	$4, %ebx
L11:
	movb	-25(%ebp), %al
	cmpb	$115, %al
	jne	L13
	cmpl	$2147483647, %edx
	je	L14
	movl	$_GO_stderr, 4(%esp)
	movl	$LC0, (%esp)
	call	_GO_fputs
	movl	$_GO_stderr, 4(%esp)
	movl	$LC1, (%esp)
	jmp	L62
L14:
	leal	4(%ebx), %ecx
	movl	(%ebx), %ebx
	movl	%ebx, (%esp)
	movl	%ecx, -84(%ebp)
	call	_GO_strlen
	movl	%eax, -32(%ebp)
	cmpb	$0, (%ebx)
	movl	-84(%ebp), %ecx
	je	L16
	movb	$32, -25(%ebp)
L17:
	cmpb	$0, -78(%ebp)
	jne	L53
	movl	-32(%ebp), %edx
	movb	-25(%ebp), %al
	jmp	L19
L20:
	movb	%al, (%esi)
	incl	%esi
	decl	%edi
L19:
	cmpl	%edi, %edx
	jl	L20
L53:
	movb	(%ebx), %al
	movb	%al, (%esi)
	incl	%esi
	incl	%ebx
	cmpb	$0, (%ebx)
	jne	L53
L16:
	movl	-32(%ebp), %eax
	jmp	L22
L23:
	movb	$32, (%esi)
	incl	%esi
	decl	%edi
L22:
	cmpl	%edi, %eax
	jl	L23
	movl	%ecx, %ebx
	jmp	L60
L13:
	cmpb	$108, %al
	jne	L24
	movl	12(%ebp), %ecx
	movb	(%ecx), %al
	movb	%al, -77(%ebp)
	movb	%al, -25(%ebp)
	leal	1(%ecx), %eax
	movl	%eax, 12(%ebp)
	cmpb	$120, -77(%ebp)
	je	L24
	cmpb	$100, -77(%ebp)
	je	L24
	cmpb	$117, -77(%ebp)
	je	L24
	movl	%ecx, 12(%ebp)
	jmp	L25
L24:
	movb	-25(%ebp), %al
	cmpb	$117, %al
	jne	L26
	leal	4(%ebx), %ecx
	movl	(%ebx), %eax
	movl	%eax, -32(%ebp)
	jmp	L27
L26:
	cmpb	$100, %al
	jne	L28
L29:
	leal	4(%ebx), %ecx
	movl	(%ebx), %eax
	movl	%eax, -32(%ebp)
	testl	%eax, %eax
	jns	L27
	movb	$45, (%esi)
	incl	%esi
	negl	%eax
	movl	%eax, -32(%ebp)
	decl	%edi
L27:
	cmpl	$2147483647, %edx
	je	L30
	movl	$_GO_stderr, 4(%esp)
	movl	$LC0, (%esp)
	call	_GO_fputs
	movl	$_GO_stderr, 4(%esp)
	movl	$LC2, (%esp)
L62:
	call	_GO_fputs
	jmp	L15
L30:
	testl	%edi, %edi
	jg	L31
	movl	$1, %edi
L31:
	movl	-32(%ebp), %eax
	leal	-33(%ebp), %ebx
	movl	%ecx, -108(%ebp)
L32:
	decl	%ebx
	movl	$10, %ecx
	xorl	%edx, %edx
	divl	%ecx
	movl	%edx, -100(%ebp)
	movb	-100(%ebp), %dl
	addl	$48, %edx
	movb	%dl, (%ebx)
	testl	%eax, %eax
	jne	L32
	movl	-108(%ebp), %ecx
L33:
	movb	$32, -25(%ebp)
	movl	-92(%ebp), %eax
	subl	%ebx, %eax
	movl	%eax, -32(%ebp)
	cmpb	$0, -76(%ebp)
	je	L17
	movb	$48, -25(%ebp)
	jmp	L17
L28:
	cmpb	$105, %al
	je	L29
	cmpb	$37, %al
	je	L4
	cmpb	$120, %al
	jne	L34
	movl	$_hextable_x.1489, %eax
L35:
	leal	4(%ebx), %ecx
	movl	(%ebx), %edx
	movl	%edx, -32(%ebp)
	leal	-33(%ebp), %ebx
L36:
	decl	%ebx
	movl	-32(%ebp), %edx
	andl	$15, %edx
	movb	(%eax,%edx), %dl
	movb	%dl, (%ebx)
	movl	-32(%ebp), %edx
	shrl	$4, %edx
	movl	%edx, -32(%ebp)
	testl	%edx, %edx
	jne	L36
	jmp	L33
L34:
	cmpb	$88, %al
	jne	L37
	movl	$_hextable_X.1488, %eax
	jmp	L35
L37:
	cmpb	$112, %al
	jne	L38
	leal	4(%ebx), %ecx
	movl	(%ebx), %ebx
	movl	%ebx, -76(%ebp)
	xorl	%eax, %eax
	leal	-33(%ebp), %ebx
	jmp	L39
L40:
	decl	%ebx
	movl	-76(%ebp), %edx
	andl	$15, %edx
	movb	_hextable_X.1488(%edx), %dl
	movb	%dl, (%ebx)
	sarl	$4, -76(%ebp)
	incl	%eax
L39:
	cmpl	$7, %eax
	jle	L40
	movl	%eax, -32(%ebp)
	jmp	L17
L38:
	cmpb	$111, %al
	jne	L41
	leal	4(%ebx), %ecx
	movl	(%ebx), %eax
	movl	%eax, -32(%ebp)
	leal	-33(%ebp), %ebx
L42:
	decl	%ebx
	movl	-32(%ebp), %eax
	andl	$7, %eax
	movb	_hextable_x.1489(%eax), %al
	movb	%al, (%ebx)
	movl	-32(%ebp), %eax
	shrl	$3, %eax
	movl	%eax, -32(%ebp)
	testl	%eax, %eax
	jne	L42
	jmp	L33
L41:
	cmpb	$102, %al
	jne	L25
	cmpl	$2147483647, %edx
	jne	L43
	movl	$6, %edx
L43:
	leal	1(%edx), %eax
	cmpl	%edi, %eax
	jl	L44
	leal	2(%edx), %edi
L44:
	xorl	%eax, %eax
L45:
	movb	$35, (%esi,%eax)
	incl	%eax
	cmpl	%edi, %eax
	jne	L45
	addl	%eax, %esi
	jmp	L60
L25:
	movl	$_GO_stderr, 4(%esp)
	movl	$LC0, (%esp)
	call	_GO_fputs
	movl	12(%ebp), %eax
	decl	%eax
	movl	%eax, 8(%esp)
	movl	$LC3, 4(%esp)
	movl	$_GO_stderr, (%esp)
	call	_GO_fprintf
L15:
	movl	$4, (%esp)
	call	_GOL_sysabort
	.data
	.align 4
_hextable_x.1489:
	.ascii "0123456789abcdef"
	.align 4
_hextable_X.1488:
	.ascii "0123456789ABCDEF"
	.def	_GO_strtoul0;	.scl	2;	.type	32;	.endef
	.def	_GO_fputs;	.scl	2;	.type	32;	.endef
	.def	_GO_strlen;	.scl	2;	.type	32;	.endef
	.def	_GO_fprintf;	.scl	2;	.type	32;	.endef
	.def	_GOL_sysabort;	.scl	2;	.type	32;	.endef
