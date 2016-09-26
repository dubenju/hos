	.file	"cp2img.c"
	.section .rdata,"dr"
LC0:
	.ascii "argc=%d\15\12\0"
LC1:
	.ascii "cp2img\0"
	.align 4
LC2:
	.ascii "program's name must be to cp2img\15\0"
LC3:
	.ascii "paramter error(%d)\15\12\0"
LC4:
	.ascii "-f\0"
LC5:
	.ascii "file system option:-f\15\0"
LC6:
	.ascii "fat12\0"
LC7:
	.ascii "FAT12\0"
LC8:
	.ascii "fat16\0"
LC9:
	.ascii "FAT16\0"
LC10:
	.ascii "fat32\0"
LC11:
	.ascii "FAT32\0"
	.align 4
LC12:
	.ascii "file system :\15\12\11fat12\15\12\11fat16\15\12\11fat32\15\12\11ntfs\15\0"
LC13:
	.ascii "-i\0"
LC14:
	.ascii "input file option:-i\15\0"
LC15:
	.ascii "-o\0"
LC16:
	.ascii "output file option:-o\15\0"
LC17:
	.ascii "-chs\0"
LC18:
	.ascii "-path\0"
LC19:
	.ascii "output mode option:-chs\15\0"
	.text
.globl _chk_param
	.def	_chk_param;	.scl	2;	.type	32;	.endef
_chk_param:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movb	$0, -9(%ebp)
	cmpl	$8, 8(%ebp)
	jg	L2
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC0, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L3
L2:
	movb	$0, -10(%ebp)
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$6, 8(%esp)
	movl	$LC1, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	je	L4
	movl	$LC2, (%esp)
	call	_puts
	movl	$-1, %eax
	jmp	L3
L4:
	incb	-10(%ebp)
	movsbl	-10(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	L5
	movsbl	-10(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L3
L5:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$2, 8(%esp)
	movl	$LC4, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	je	L6
	movl	$LC5, (%esp)
	call	_puts
	movl	$-1, %eax
	jmp	L3
L6:
	movb	$1, -9(%ebp)
	incb	-10(%ebp)
	movsbl	-10(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	L7
	movsbl	-10(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L3
L7:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$5, 8(%esp)
	movl	$LC6, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	je	L8
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$5, 8(%esp)
	movl	$LC7, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	jne	L9
L8:
	movl	16(%ebp), %eax
	movb	$1, (%eax)
	jmp	L10
L9:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$5, 8(%esp)
	movl	$LC8, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	je	L11
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$5, 8(%esp)
	movl	$LC9, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	jne	L12
L11:
	movl	16(%ebp), %eax
	movb	$2, (%eax)
	jmp	L10
L12:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$5, 8(%esp)
	movl	$LC10, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	je	L13
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$5, 8(%esp)
	movl	$LC11, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	jne	L14
L13:
	movl	16(%ebp), %eax
	movb	$3, (%eax)
	jmp	L10
L14:
	movl	$LC12, (%esp)
	call	_puts
	movl	$-1, %eax
	jmp	L3
L10:
	incb	-10(%ebp)
	movsbl	-10(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	L15
	movsbl	-10(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L3
L15:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$2, 8(%esp)
	movl	$LC13, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	je	L16
	movl	$LC14, (%esp)
	call	_puts
	movl	$-1, %eax
	jmp	L3
L16:
	incb	-10(%ebp)
	movsbl	-10(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	L17
	movsbl	-10(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L3
L17:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	incl	%eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	-16(%ebp), %eax
	incl	%eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	4(%eax), %eax
	movl	%edx, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_memset
	movl	-16(%ebp), %ecx
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	16(%ebp), %eax
	movl	4(%eax), %eax
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_memcpy
	incb	-10(%ebp)
	movsbl	-10(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	L18
	movsbl	-10(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L3
L18:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$2, 8(%esp)
	movl	$LC15, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	je	L19
	movl	$LC16, (%esp)
	call	_puts
	movl	$-1, %eax
	jmp	L3
L19:
	incb	-10(%ebp)
	movsbl	-10(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	L20
	movsbl	-10(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L3
L20:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	incl	%eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%edx, 8(%eax)
	movl	-16(%ebp), %eax
	incl	%eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	8(%eax), %eax
	movl	%edx, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_memset
	movl	-16(%ebp), %ecx
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	16(%ebp), %eax
	movl	8(%eax), %eax
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_memcpy
	incb	-10(%ebp)
	movsbl	-10(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	L21
	movsbl	-10(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L3
L21:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$2, 8(%esp)
	movl	$LC17, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	jne	L22
	movl	16(%ebp), %eax
	movb	$1, 12(%eax)
	jmp	L23
L22:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	$2, 8(%esp)
	movl	$LC18, 4(%esp)
	movl	%eax, (%esp)
	call	_memcmp
	testl	%eax, %eax
	jne	L24
	movl	16(%ebp), %eax
	movb	$2, 12(%eax)
	jmp	L23
L24:
	movl	$LC19, (%esp)
	call	_puts
	movl	$-1, %eax
	jmp	L3
L23:
	incb	-10(%ebp)
	movsbl	-10(%ebp), %eax
	cmpl	8(%ebp), %eax
	jle	L25
	movsbl	-10(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC3, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L3
L25:
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, (%esp)
	call	_strlen
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	incl	%eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%edx, 16(%eax)
	movl	-16(%ebp), %eax
	incl	%eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	16(%eax), %eax
	movl	%edx, 8(%esp)
	movl	$0, 4(%esp)
	movl	%eax, (%esp)
	call	_memset
	movl	-16(%ebp), %ecx
	movsbl	-10(%ebp), %eax
	sall	$2, %eax
	addl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	16(%ebp), %eax
	movl	16(%eax), %eax
	movl	%ecx, 8(%esp)
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	_memcpy
	movl	$0, %eax
L3:
	leave
	ret
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC20:
	.ascii "%s usage:\15\12\0"
	.align 4
LC21:
	.ascii "%s -f fat12 -i inputfile -o outputfile -chs 0,0,0or\15\12\0"
	.align 4
LC22:
	.ascii "%s -f fat12 -i inputfile -o outputfile -path /path or\15\12\0"
LC23:
	.ascii "paramter check error\15\12.\0"
LC24:
	.ascii "%d\15\12\0"
LC25:
	.ascii "%s\15\12\0"
	.text
.globl _main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$48, %esp
	call	___main
	movb	$-1, 28(%esp)
	movl	$0, 32(%esp)
	movl	$0, 36(%esp)
	movb	$-1, 40(%esp)
	movl	$0, 44(%esp)
	leal	28(%esp), %eax
	movl	%eax, 8(%esp)
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_chk_param
	testl	%eax, %eax
	je	L27
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC20, (%esp)
	call	_printf
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC21, (%esp)
	call	_printf
	movl	12(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC22, (%esp)
	call	_printf
	movl	$LC23, (%esp)
	call	_printf
	movl	$-1, %eax
	jmp	L28
L27:
	movb	28(%esp), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$LC24, (%esp)
	call	_printf
	movl	32(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC25, (%esp)
	call	_printf
	movl	36(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC25, (%esp)
	call	_printf
	movb	40(%esp), %al
	movsbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$LC24, (%esp)
	call	_printf
	movl	44(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC25, (%esp)
	call	_printf
	movb	28(%esp), %al
	cmpb	$1, %al
	je	L29
	movb	28(%esp), %al
	cmpb	$2, %al
	je	L29
	movb	28(%esp), %al
	cmpb	$3, %al
	jne	L30
L29:
	movb	40(%esp), %al
	cmpb	$1, %al
	jne	L31
	call	_get_chs
	call	_write_chs
L31:
	movb	40(%esp), %al
	cmpb	$2, %al
	jne	L30
	call	_write_path
L30:
	movl	32(%esp), %eax
	testl	%eax, %eax
	je	L32
	movl	32(%esp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	$0, 32(%esp)
L32:
	movl	36(%esp), %eax
	testl	%eax, %eax
	je	L33
	movl	36(%esp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	$0, 36(%esp)
L33:
	movl	44(%esp), %eax
	testl	%eax, %eax
	je	L34
	movl	44(%esp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	$0, 44(%esp)
L34:
	movl	$0, %eax
L28:
	leave
	ret
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_memcmp;	.scl	2;	.type	32;	.endef
	.def	_strlen;	.scl	2;	.type	32;	.endef
	.def	_malloc;	.scl	2;	.type	32;	.endef
	.def	_memset;	.scl	2;	.type	32;	.endef
	.def	_memcpy;	.scl	2;	.type	32;	.endef
	.def	_get_chs;	.scl	2;	.type	32;	.endef
	.def	_write_chs;	.scl	2;	.type	32;	.endef
	.def	_write_path;	.scl	2;	.type	32;	.endef
	.def	_free;	.scl	2;	.type	32;	.endef
