	.file	"strncpy.c"
	.text
.globl _GO_strncpy
	.def	_GO_strncpy;	.scl	2;	.type	32;	.endef
_GO_strncpy:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$4, %esp
	movl	8(%ebp), %eax
	movl	12(%ebp), %esi
	movl	16(%ebp), %ecx
	movl	%eax, %edx
	jmp	L2
L5:
	testl	%ecx, %ecx
	je	L8
	decl	%ecx
	movb	-9(%ebp), %bl
	movb	%bl, (%edx)
	incl	%edx
	incl	%esi
L2:
	movb	(%esi), %bl
	movb	%bl, -9(%ebp)
	testb	%bl, %bl
	jne	L5
	jmp	L9
L7:
	movb	$0, (%edx)
	incl	%edx
	decl	%ecx
L9:
	testl	%ecx, %ecx
	jne	L7
L8:
	popl	%edx
	popl	%ebx
	popl	%esi
	leave
	ret
