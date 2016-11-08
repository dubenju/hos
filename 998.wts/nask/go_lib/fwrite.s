	.file	"fwrite.c"
	.text
.globl _GO_fwrite
	.def	_GO_fwrite;	.scl	2;	.type	32;	.endef
_GO_fwrite:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	movl	16(%ebp), %esi
	movl	20(%ebp), %edi
	imull	12(%ebp), %esi
	movl	8(%edi), %edx
	movl	4(%edi), %eax
	subl	%edx, %eax
	movl	%esi, %ebx
	cmpl	%eax, %esi
	jle	L2
	movl	%eax, %ebx
L2:
	cmpl	$0, %ebx
	jl	L5
	je	L3
	movl	%ebx, 8(%esp)
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_GO_memcpy
	addl	%ebx, 8(%edi)
	jmp	L3
L5:
	xorl	%ebx, %ebx
L3:
	cmpl	%esi, %ebx
	je	L4
	call	_GO_abort
L4:
	movl	%ebx, %eax
	addl	$28, %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
	.def	_GO_memcpy;	.scl	2;	.type	32;	.endef
	.def	_GO_abort;	.scl	2;	.type	32;	.endef
