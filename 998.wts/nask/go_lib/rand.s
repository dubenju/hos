	.file	"rand.c"
	.text
.globl _GO_rand
	.def	_GO_rand;	.scl	2;	.type	32;	.endef
_GO_rand:
	pushl	%ebp
	movl	%esp, %ebp
	imull	$1103515245, _GO_rand_seed, %eax
	addl	$12345, %eax
	movl	%eax, _GO_rand_seed
	shrl	$16, %eax
	andl	$32767, %eax
	leave
	ret
.globl _GO_rand_seed
	.data
	.align 4
_GO_rand_seed:
	.long	1
