	.file	"strcspn.c"
	.text
.globl _GO_strcspn
	.def	_GO_strcspn;	.scl	2;	.type	32;	.endef
_GO_strcspn:
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
L5:
	cmpb	-13(%ebp), %bl
	je	L6
L3:
	incl	%ecx
L7:
	movb	(%ecx), %dl
	movb	%dl, -13(%ebp)
	testb	%dl, %dl
	jne	L5
	incl	%eax
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
