	.file	"strspn.c"
	.text
.globl _GO_strspn
	.def	_GO_strspn;	.scl	2;	.type	32;	.endef
_GO_strspn:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$4, %esp
	movl	8(%ebp), %edi
	movl	12(%ebp), %esi
	movl	%edi, %eax
	jmp	L2
L4:
	cmpb	-13(%ebp), %bl
	jne	L3
	incl	%eax
	jmp	L2
L3:
	incl	%ecx
L7:
	movb	(%ecx), %dl
	movb	%dl, -13(%ebp)
	testb	%dl, %dl
	jne	L4
	jmp	L6
L2:
	movb	(%eax), %bl
	testb	%bl, %bl
	je	L6
	movl	%esi, %ecx
	jmp	L7
L6:
	subl	%edi, %eax
	popl	%edx
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
