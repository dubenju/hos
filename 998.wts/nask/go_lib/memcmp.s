	.file	"memcmp.c"
	.text
.globl _GO_memcmp
	.def	_GO_memcmp;	.scl	2;	.type	32;	.endef
_GO_memcmp:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	movl	8(%ebp), %edi
	movl	12(%ebp), %esi
	movl	16(%ebp), %ecx
	xorl	%edx, %edx
	jmp	L2
L4:
	movb	(%edi,%edx), %al
	movb	(%esi,%edx), %bl
	incl	%edx
	decl	%ecx
	cmpb	%bl, %al
	je	L2
	movsbl	%al, %eax
	movsbl	%bl, %ebx
	subl	%ebx, %eax
	jmp	L3
L2:
	testl	%ecx, %ecx
	jne	L4
	xorl	%eax, %eax
L3:
	popl	%ebx
	popl	%esi
	popl	%edi
	leave
	ret
