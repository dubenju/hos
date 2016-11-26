	.file	"coff.c"
	.section .rdata,"dr"
	.align 4
LC0:
	.ascii "Target Machine           =0X%04X.\0"
LC1:
	.ascii "UNKNOWN\0"
LC2:
	.ascii "Alpha AXP\0"
LC3:
	.ascii "ARM\0"
LC4:
	.ascii "Alpha AXP 64-bit.\0"
LC5:
	.ascii "Intel 386 or later.\0"
LC6:
	.ascii "Intel IA64.\0"
LC7:
	.ascii "Motorola 68000 series.\0"
LC8:
	.ascii "MIPS16.\0"
LC9:
	.ascii "MIPS with FPU.\0"
LC10:
	.ascii "MIPS16 with FPU.\0"
LC11:
	.ascii "Power PC, little endian.\0"
LC12:
	.ascii "R3000.\0"
LC13:
	.ascii "R4000MIPS little endian.\0"
LC14:
	.ascii "R10000.\0"
LC15:
	.ascii "Hitachi SH3.\0"
LC16:
	.ascii "Hitachi SH4.\0"
LC17:
	.ascii "THUMB.\0"
	.align 4
LC18:
	.ascii "Number Of Sections       =  %04d\12\0"
	.align 4
LC19:
	.ascii "Time & Date Stamp (After 1970/1/1 0:00:00) =%d\12\0"
	.align 4
LC20:
	.ascii "PointerTo Symbol Table   =0X%04X\12\0"
	.align 4
LC21:
	.ascii "Number Of Symbols        =  %04d\12\0"
	.align 4
LC22:
	.ascii "Size   Of Optional Header=  %04d\12\0"
	.align 4
LC23:
	.ascii "Characteristics          =0X%04X\12\0"
	.align 4
LC24:
	.ascii "Section Flag             =F_RELFLG\0"
	.align 4
LC25:
	.ascii "Section Flag             =F_EXEC\0"
	.align 4
LC26:
	.ascii "Section Flag             =F_LNNO\0"
	.align 4
LC27:
	.ascii "Section Flag             =F_LSYMS\0"
	.align 4
LC28:
	.ascii "Section Flag             =F_AGGRESSIVE_WS_TRIM\0"
	.align 4
LC29:
	.ascii "Section Flag             =F_LARGE_ADDRESS_AWARE\0"
	.align 4
LC30:
	.ascii "Section Flag             =F_16BIT_MACHINE\0"
	.align 4
LC31:
	.ascii "Section Flag             =F_BYTES_REVERSED_LO\0"
	.align 4
LC32:
	.ascii "Section Flag             =F_AR32WR:F_LITTLE\0"
	.align 4
LC33:
	.ascii "Section Flag             =F_BIGDEBUG\0"
	.align 4
LC34:
	.ascii "Section Flag             =F_REMOVABLE_RUN_FROM_SWAP\0"
	.align 4
LC35:
	.ascii "Section Flag             =F_SYMMERGE:SYSTEM\0"
	.align 4
LC36:
	.ascii "Section Flag             =F_DLL\0"
	.align 4
LC37:
	.ascii "Section Flag             =F_UP_SYSTEM_ONLY\0"
	.align 4
LC38:
	.ascii "Section Flag             =F_BYTES_REVERSED_HI\0"
	.text
	.globl	_display_coff_header
	.def	_display_coff_header;	.scl	2;	.type	32;	.endef
_display_coff_header:
LFB6:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	8(%ebp), %eax
	movzwl	(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC0, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	(%eax), %eax
	movzwl	%ax, %eax
	cmpl	$448, %eax
	je	L3
	cmpl	$448, %eax
	jg	L4
	cmpl	$358, %eax
	je	L5
	cmpl	$358, %eax
	jg	L6
	cmpl	$332, %eax
	je	L7
	cmpl	$354, %eax
	je	L8
	testl	%eax, %eax
	je	L9
	jmp	L2
L6:
	cmpl	$388, %eax
	je	L10
	cmpl	$388, %eax
	jg	L11
	cmpl	$360, %eax
	je	L12
	jmp	L2
L11:
	cmpl	$418, %eax
	je	L13
	cmpl	$422, %eax
	je	L14
	jmp	L2
L4:
	cmpl	$614, %eax
	je	L15
	cmpl	$614, %eax
	jg	L16
	cmpl	$496, %eax
	je	L17
	cmpl	$512, %eax
	je	L18
	cmpl	$450, %eax
	je	L19
	jmp	L2
L16:
	cmpl	$644, %eax
	je	L20
	cmpl	$644, %eax
	jg	L21
	cmpl	$616, %eax
	je	L22
	jmp	L2
L21:
	cmpl	$870, %eax
	je	L23
	cmpl	$1126, %eax
	je	L24
	jmp	L2
L9:
	movl	$LC1, (%esp)
	call	_puts
	jmp	L25
L10:
	movl	$LC2, (%esp)
	call	_puts
	jmp	L25
L3:
	movl	$LC3, (%esp)
	call	_puts
	jmp	L25
L20:
	movl	$LC4, (%esp)
	call	_puts
	jmp	L25
L7:
	movl	$LC5, (%esp)
	call	_puts
	jmp	L25
L18:
	movl	$LC6, (%esp)
	call	_puts
	jmp	L25
L22:
	movl	$LC7, (%esp)
	call	_puts
	jmp	L25
L15:
	movl	$LC8, (%esp)
	call	_puts
	jmp	L25
L23:
	movl	$LC9, (%esp)
	call	_puts
	jmp	L25
L24:
	movl	$LC10, (%esp)
	call	_puts
	jmp	L25
L17:
	movl	$LC11, (%esp)
	call	_puts
	jmp	L25
L8:
	movl	$LC12, (%esp)
	call	_puts
	jmp	L25
L5:
	movl	$LC13, (%esp)
	call	_puts
	jmp	L25
L12:
	movl	$LC14, (%esp)
	call	_puts
	jmp	L25
L13:
	movl	$LC15, (%esp)
	call	_puts
	jmp	L25
L14:
	movl	$LC16, (%esp)
	call	_puts
	jmp	L25
L19:
	movl	$LC17, (%esp)
	call	_puts
	jmp	L25
L2:
	movl	$10, (%esp)
	call	_putchar
	nop
L25:
	movl	8(%ebp), %eax
	movzwl	2(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC18, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC19, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC20, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC21, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	16(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC22, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC23, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$1, %eax
	testl	%eax, %eax
	je	L26
	movl	$LC24, (%esp)
	call	_puts
L26:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$2, %eax
	testl	%eax, %eax
	je	L27
	movl	$LC25, (%esp)
	call	_puts
L27:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$4, %eax
	testl	%eax, %eax
	je	L28
	movl	$LC26, (%esp)
	call	_puts
L28:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$8, %eax
	testl	%eax, %eax
	je	L29
	movl	$LC27, (%esp)
	call	_puts
L29:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$16, %eax
	testl	%eax, %eax
	je	L30
	movl	$LC28, (%esp)
	call	_puts
L30:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	L31
	movl	$LC29, (%esp)
	call	_puts
L31:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	L32
	movl	$LC30, (%esp)
	call	_puts
L32:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$128, %eax
	testl	%eax, %eax
	je	L33
	movl	$LC31, (%esp)
	call	_puts
L33:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$256, %eax
	testl	%eax, %eax
	je	L34
	movl	$LC32, (%esp)
	call	_puts
L34:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$512, %eax
	testl	%eax, %eax
	je	L35
	movl	$LC33, (%esp)
	call	_puts
L35:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$1024, %eax
	testl	%eax, %eax
	je	L36
	movl	$LC34, (%esp)
	call	_puts
L36:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$4096, %eax
	testl	%eax, %eax
	je	L37
	movl	$LC35, (%esp)
	call	_puts
L37:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$8192, %eax
	testl	%eax, %eax
	je	L38
	movl	$LC36, (%esp)
	call	_puts
L38:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$16384, %eax
	testl	%eax, %eax
	je	L39
	movl	$LC37, (%esp)
	call	_puts
L39:
	movl	8(%ebp), %eax
	movzwl	18(%eax), %eax
	movzwl	%ax, %eax
	andl	$24576, %eax
	testl	%eax, %eax
	je	L41
	movl	$LC38, (%esp)
	call	_puts
L41:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE6:
	.section .rdata,"dr"
LC39:
	.ascii "Magic Number      =%04x\12\0"
LC40:
	.ascii "Version stamp =%04d\12\0"
	.align 4
LC41:
	.ascii "Text size in bytes       =%04d\12\0"
LC42:
	.ascii "Initialised data size=%04s\12\0"
	.align 4
LC43:
	.ascii "Uninitialised data size     =%04d\12\0"
LC44:
	.ascii "Entry point=%04x\12\0"
LC45:
	.ascii "Base of Text     =%04x\12\0"
LC46:
	.ascii "Base of Data     =%04x\12\0"
	.text
	.globl	_display_optional_header
	.def	_display_optional_header;	.scl	2;	.type	32;	.endef
_display_optional_header:
LFB7:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	8(%ebp), %eax
	movzwl	(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC39, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	2(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC40, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC41, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC42, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC43, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	16(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC44, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	20(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC45, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	24(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC46, (%esp)
	call	_printf
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE7:
	.section .rdata,"dr"
LC47:
	.ascii "%d Section Header ----------\12\0"
LC48:
	.ascii "Section Name           =%s\12\0"
	.align 4
LC49:
	.ascii "Virtual Size           =  %04d\12\0"
	.align 4
LC50:
	.ascii "Virtual Address        =0X%04X\12\0"
	.align 4
LC51:
	.ascii "Size    Of RawData     =  %04d\12\0"
	.align 4
LC52:
	.ascii "Pointer To RawData     =0X%04X\12\0"
	.align 4
LC53:
	.ascii "Pointer To Relocations =0X%04X\12\0"
	.align 4
LC54:
	.ascii "Pointer To Linenumbers =0X%04X\12\0"
	.align 4
LC55:
	.ascii "Number  Of Relocations =  %04d\12\0"
	.align 4
LC56:
	.ascii "Number  Of Linenumbers =  %04d\12\0"
	.align 4
LC57:
	.ascii "Section Flags          =0X%04X\12\0"
	.align 4
LC58:
	.ascii "Section Type           =STYP_TEXT\0"
	.align 4
LC59:
	.ascii "Section Type           =STYP_DATA\0"
	.align 4
LC60:
	.ascii "Section Type           =STYP_BSS\0"
	.align 4
LC61:
	.ascii "Section Type           =STYP_DRECTVE\0"
	.align 4
LC62:
	.ascii "Section Type           =STYP_Section contains extended relocations.\0"
	.align 4
LC63:
	.ascii "Section Type           =STYP_Section can be discarded as needed.\0"
	.align 4
LC64:
	.ascii "Section Type           =STYP_Section cannot be cached\0"
	.align 4
LC65:
	.ascii "Section Type           =STYP_Section is not pageable\0"
	.align 4
LC66:
	.ascii "Section Type           =STYP_Section can be shared in memory.\0"
	.align 4
LC67:
	.ascii "Section Type           =STYP_Section can be executed as code\0"
	.align 4
LC68:
	.ascii "Section Type           =STYP_Section can be read.\0"
	.align 4
LC69:
	.ascii "Section Type           =STYP_Section can be written to.\0"
	.text
	.globl	_display_section_header
	.def	_display_section_header;	.scl	2;	.type	32;	.endef
_display_section_header:
LFB8:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$56, %esp
	movl	12(%ebp), %eax
	movw	%ax, -28(%ebp)
	movl	$9, 8(%esp)
	movl	$0, 4(%esp)
	leal	-17(%ebp), %eax
	movl	%eax, (%esp)
	call	_memset
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	(%eax), %eax
	movl	%eax, -17(%ebp)
	movl	%edx, -13(%ebp)
	movzwl	-28(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC47, (%esp)
	call	_printf
	leal	-17(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC48, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC49, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC50, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	16(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC51, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	20(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC52, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	24(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC53, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	28(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC54, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	32(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC55, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	34(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC56, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC57, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$32, %eax
	testl	%eax, %eax
	je	L44
	movl	$LC58, (%esp)
	call	_puts
L44:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$64, %eax
	testl	%eax, %eax
	je	L45
	movl	$LC59, (%esp)
	call	_puts
L45:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$128, %eax
	testl	%eax, %eax
	je	L46
	movl	$LC60, (%esp)
	call	_puts
L46:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$512, %eax
	testl	%eax, %eax
	je	L47
	movl	$LC61, (%esp)
	call	_puts
L47:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$16777216, %eax
	testl	%eax, %eax
	je	L48
	movl	$LC62, (%esp)
	call	_puts
L48:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$33554432, %eax
	testl	%eax, %eax
	je	L49
	movl	$LC63, (%esp)
	call	_puts
L49:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$67108864, %eax
	testl	%eax, %eax
	je	L50
	movl	$LC64, (%esp)
	call	_puts
L50:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$134217728, %eax
	testl	%eax, %eax
	je	L51
	movl	$LC65, (%esp)
	call	_puts
L51:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$268435456, %eax
	testl	%eax, %eax
	je	L52
	movl	$LC66, (%esp)
	call	_puts
L52:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$536870912, %eax
	testl	%eax, %eax
	je	L53
	movl	$LC67, (%esp)
	call	_puts
L53:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	andl	$1073741824, %eax
	testl	%eax, %eax
	je	L54
	movl	$LC68, (%esp)
	call	_puts
L54:
	movl	8(%ebp), %eax
	movl	36(%eax), %eax
	testl	%eax, %eax
	jns	L56
	movl	$LC69, (%esp)
	call	_puts
L56:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE8:
	.section .rdata,"dr"
	.align 4
LC70:
	.ascii "%d Relocation Entry ----------\12\0"
LC71:
	.ascii "Reference Address    =%04x\12\0"
LC72:
	.ascii "Symbol    Index      =%04d\12\0"
LC73:
	.ascii "Type   Of Relocation =%04x\12\0"
	.align 4
LC74:
	.ascii "Relocation Type      =RELOC_ADDR32\0"
	.align 4
LC75:
	.ascii "Relocation Type      =RELOC_REL32\0"
	.text
	.globl	_display_relocation_entry
	.def	_display_relocation_entry;	.scl	2;	.type	32;	.endef
_display_relocation_entry:
LFB9:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC70, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC71, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC72, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	8(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC73, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	8(%eax), %eax
	cmpw	$6, %ax
	jne	L58
	movl	$LC74, (%esp)
	call	_puts
L58:
	movl	8(%ebp), %eax
	movzwl	8(%eax), %eax
	cmpw	$32, %ax
	jne	L60
	movl	$LC75, (%esp)
	call	_puts
L60:
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE9:
	.section .rdata,"dr"
LC76:
	.ascii "%d Symbol Table ----------\12\0"
LC77:
	.ascii "Symbol Name     =%s\12\0"
LC78:
	.ascii "Symbol Name    =%d\12\0"
LC79:
	.ascii "Value of Symbol =%04d\12\0"
LC80:
	.ascii "Section Number  =0X%04X\12\0"
	.align 4
LC81:
	.ascii "Section Number  =N_DEBUG?:A debug? symbol.\0"
	.align 4
LC82:
	.ascii "Section Number  =N_CONST:A const symbol.\0"
	.align 4
LC83:
	.ascii "Section Number  =N_UNDEF:An undefined external symbol.\0"
	.align 4
LC84:
	.ascii "Section Number  =N_ABS:An absolute symbol. This means that the value of the n_value field is an absolute value.\0"
	.align 4
LC85:
	.ascii "Section Number  =N_DEBUG:A debugging symbol. In the example below, information about the file has been put into a symbol like this.\0"
LC86:
	.ascii "Symbol Type     =  %04d\12\0"
LC87:
	.ascii "Storage Class   =0X%04X\12\0"
LC88:
	.ascii "Storage Class   =C_NULL\0"
LC89:
	.ascii "Storage Class   =C_EXTERNAL\0"
	.align 4
LC90:
	.ascii "Storage Class   =C_EXT:EXTERNAL\0"
	.align 4
LC91:
	.ascii "Storage Class   =C_STAT:STATIC\0"
LC92:
	.ascii "Storage Class   =C_REGISTER\0"
	.align 4
LC93:
	.ascii "Storage Class   =C_MEMBER_OF_STRUCT\0"
LC94:
	.ascii "Storage Class   =C_STRUCT_TAG\0"
	.align 4
LC95:
	.ascii "Storage Class   =C_MEMBER_OF_UNION\0"
LC96:
	.ascii "Storage Class   =C_UNION_TAG\0"
	.align 4
LC97:
	.ascii "Storage Class   =C_TYPE_DEFINITION\0"
LC98:
	.ascii "Storage Class   =C_FUNCTION\0"
LC99:
	.ascii "Storage Class   =C_FILE\0"
LC100:
	.ascii "Auxiliary Count =0X%04X\12\0"
	.text
	.globl	_display_symbol_table_entry
	.def	_display_symbol_table_entry;	.scl	2;	.type	32;	.endef
_display_symbol_table_entry:
LFB10:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC76, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	L62
	movl	$9, 8(%esp)
	movl	$0, 4(%esp)
	leal	-17(%ebp), %eax
	movl	%eax, (%esp)
	call	_memset
	movl	8(%ebp), %eax
	movl	4(%eax), %edx
	movl	(%eax), %eax
	movl	%eax, -17(%ebp)
	movl	%edx, -13(%ebp)
	leal	-17(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC77, (%esp)
	call	_printf
	jmp	L63
L62:
	movl	8(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC78, (%esp)
	call	_printf
L63:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, 4(%esp)
	movl	$LC79, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	12(%eax), %eax
	cwtl
	movl	%eax, 4(%esp)
	movl	$LC80, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzwl	12(%eax), %eax
	cmpw	$-2, %ax
	jne	L64
	movl	$LC81, (%esp)
	call	_puts
L64:
	movl	8(%ebp), %eax
	movzwl	12(%eax), %eax
	cmpw	$-1, %ax
	jne	L65
	movl	$LC82, (%esp)
	call	_puts
L65:
	movl	8(%ebp), %eax
	movzwl	12(%eax), %eax
	testw	%ax, %ax
	jne	L66
	movl	$LC83, (%esp)
	call	_puts
L66:
	movl	8(%ebp), %eax
	movzwl	12(%eax), %eax
	cmpw	$1, %ax
	jne	L67
	movl	$LC84, (%esp)
	call	_puts
L67:
	movl	8(%ebp), %eax
	movzwl	12(%eax), %eax
	cmpw	$2, %ax
	jne	L68
	movl	$LC85, (%esp)
	call	_puts
L68:
	movl	8(%ebp), %eax
	movzwl	14(%eax), %eax
	movzwl	%ax, %eax
	movl	%eax, 4(%esp)
	movl	$LC86, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	movzbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$LC87, (%esp)
	call	_printf
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	testb	%al, %al
	jne	L69
	movl	$LC88, (%esp)
	call	_puts
L69:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$1, %al
	jne	L70
	movl	$LC89, (%esp)
	call	_puts
L70:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$2, %al
	jne	L71
	movl	$LC90, (%esp)
	call	_puts
L71:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$3, %al
	jne	L72
	movl	$LC91, (%esp)
	call	_puts
L72:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$4, %al
	jne	L73
	movl	$LC92, (%esp)
	call	_puts
L73:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$8, %al
	jne	L74
	movl	$LC93, (%esp)
	call	_puts
L74:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$10, %al
	jne	L75
	movl	$LC94, (%esp)
	call	_puts
L75:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$11, %al
	jne	L76
	movl	$LC95, (%esp)
	call	_puts
L76:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$12, %al
	jne	L77
	movl	$LC96, (%esp)
	call	_puts
L77:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$13, %al
	jne	L78
	movl	$LC97, (%esp)
	call	_puts
L78:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$101, %al
	jne	L79
	movl	$LC98, (%esp)
	call	_puts
L79:
	movl	8(%ebp), %eax
	movzbl	16(%eax), %eax
	cmpb	$102, %al
	jne	L80
	movl	$LC99, (%esp)
	call	_puts
L80:
	movl	8(%ebp), %eax
	movzbl	17(%eax), %eax
	movzbl	%al, %eax
	movl	%eax, 4(%esp)
	movl	$LC100, (%esp)
	call	_printf
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE10:
	.section .rdata,"dr"
LC101:
	.ascii "%d String Table ----------\12\0"
	.text
	.globl	_display_string_table
	.def	_display_string_table;	.scl	2;	.type	32;	.endef
_display_string_table:
LFB11:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	$1, -12(%ebp)
	movl	$0, -16(%ebp)
	movl	-12(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC101, (%esp)
	call	_printf
	jmp	L82
L85:
	movl	8(%ebp), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	L83
	movl	$10, (%esp)
	call	_putchar
	addl	$1, -12(%ebp)
	jmp	L84
L83:
	movl	8(%ebp), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	movzbl	(%eax), %eax
	movsbl	%al, %eax
	movl	%eax, (%esp)
	call	_putchar
L84:
	addl	$1, -16(%ebp)
L82:
	movl	-16(%ebp), %eax
	cmpl	12(%ebp), %eax
	jb	L85
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE11:
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC102:
	.ascii "rb\0"
LC103:
	.ascii "%s open is error.\12\0"
LC104:
	.ascii "%s size is %d\12\0"
	.align 4
LC105:
	.ascii "read coff's file header error.%d,%d\12\0"
	.align 4
LC106:
	.ascii "the pos is before Optional Header:0X%06X.\12\0"
	.align 4
LC107:
	.ascii "read coff's optional header error.%d,%d\12\0"
	.align 4
LC108:
	.ascii "the pos is before Section Header:0X%06X.\12\0"
	.align 4
LC109:
	.ascii "the pos is before Raw Data:0X%06X.\12\0"
	.align 4
LC110:
	.ascii "the pos is before Relocation Entries:0X%06X.\12\0"
	.align 4
LC111:
	.ascii "the pos is before Line Number Entries:0X%06X.\12\0"
	.align 4
LC112:
	.ascii "the pos is before Symbol Table:0X%06X.\12\0"
LC113:
	.ascii "sizeof(SYMENT)=%d.\12\0"
LC114:
	.ascii "sizeof(SYMENT_offset)=%d.\12\0"
	.align 4
LC115:
	.ascii "the pos is before String Table:0X%06X.\12\0"
LC116:
	.ascii "String Table Offset is :%X\12\0"
	.align 4
LC117:
	.ascii "String Table Size is :%d(readed).\12\0"
	.align 4
LC118:
	.ascii "String Table Size is :%d(file).\12\0"
LC119:
	.ascii "String Table Size is :%d\12\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB12:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	andl	$-16, %esp
	subl	$208, %esp
	call	___main
	movl	$0, 180(%esp)
	movl	$0, 176(%esp)
	movl	$0, 172(%esp)
	movw	$0, 170(%esp)
	movw	$0, 206(%esp)
	movl	$0, 200(%esp)
	movl	$0, 196(%esp)
	movl	$0, 192(%esp)
	movl	$0, 188(%esp)
	movl	$0, 184(%esp)
	movl	$0, 164(%esp)
	movl	$0, 24(%esp)
	movl	$0, 160(%esp)
	movl	12(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, 180(%esp)
	movl	$LC102, 4(%esp)
	movl	180(%esp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, 176(%esp)
	cmpl	$0, 176(%esp)
	jne	L87
	movl	180(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC103, (%esp)
	call	_printf
L87:
	movl	$2, 8(%esp)
	movl	$0, 4(%esp)
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_fseek
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_ftell
	movl	%eax, 160(%esp)
	movl	160(%esp), %eax
	movl	%eax, 8(%esp)
	movl	180(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC104, (%esp)
	call	_printf
	movl	$0, 8(%esp)
	movl	$0, 4(%esp)
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_fseek
	movl	$20, 8(%esp)
	movl	$0, 4(%esp)
	leal	128(%esp), %eax
	movl	%eax, (%esp)
	call	_memset
	movl	176(%esp), %eax
	movl	%eax, 12(%esp)
	movl	$20, 8(%esp)
	movl	$1, 4(%esp)
	leal	128(%esp), %eax
	movl	%eax, (%esp)
	call	_fread
	movl	%eax, 172(%esp)
	cmpl	$19, 172(%esp)
	ja	L88
	movl	$20, 8(%esp)
	movl	172(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC105, (%esp)
	call	_printf
	jmp	L89
L88:
	leal	128(%esp), %eax
	movl	%eax, (%esp)
	call	_display_coff_header
L89:
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_ftell
	movl	%eax, 4(%esp)
	movl	$LC106, (%esp)
	call	_printf
	movzwl	144(%esp), %eax
	testw	%ax, %ax
	je	L90
	movl	$28, 8(%esp)
	movl	$0, 4(%esp)
	leal	100(%esp), %eax
	movl	%eax, (%esp)
	call	_memset
	movl	176(%esp), %eax
	movl	%eax, 12(%esp)
	movl	$28, 8(%esp)
	movl	$1, 4(%esp)
	leal	100(%esp), %eax
	movl	%eax, (%esp)
	call	_fread
	movl	%eax, 172(%esp)
	cmpl	$27, 172(%esp)
	ja	L91
	movl	$28, 8(%esp)
	movl	172(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC107, (%esp)
	call	_printf
	jmp	L90
L91:
	leal	100(%esp), %eax
	movl	%eax, (%esp)
	call	_display_optional_header
L90:
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_ftell
	movl	%eax, 4(%esp)
	movl	$LC108, (%esp)
	call	_printf
	jmp	L92
L96:
	movzwl	206(%esp), %eax
	addl	$1, %eax
	movw	%ax, 206(%esp)
	movl	$40, 8(%esp)
	movl	$0, 4(%esp)
	leal	60(%esp), %eax
	movl	%eax, (%esp)
	call	_memset
	movl	176(%esp), %eax
	movl	%eax, 12(%esp)
	movl	$40, 8(%esp)
	movl	$1, 4(%esp)
	leal	60(%esp), %eax
	movl	%eax, (%esp)
	call	_fread
	movl	%eax, 172(%esp)
	cmpl	$39, 172(%esp)
	ja	L93
	movl	$40, 8(%esp)
	movl	172(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC107, (%esp)
	call	_printf
	jmp	L94
L93:
	movzwl	206(%esp), %eax
	movl	%eax, 4(%esp)
	leal	60(%esp), %eax
	movl	%eax, (%esp)
	call	_display_section_header
L94:
	movl	84(%esp), %eax
	testl	%eax, %eax
	je	L92
	cmpl	$0, 200(%esp)
	jne	L95
	movl	84(%esp), %eax
	movl	%eax, 200(%esp)
L95:
	movzwl	92(%esp), %eax
	movzwl	%ax, %eax
	addl	%eax, 196(%esp)
L92:
	movzwl	130(%esp), %eax
	cmpw	206(%esp), %ax
	ja	L96
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_ftell
	movl	%eax, 4(%esp)
	movl	$LC109, (%esp)
	call	_printf
	movl	200(%esp), %eax
	movl	$0, 8(%esp)
	movl	%eax, 4(%esp)
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_fseek
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_ftell
	movl	%eax, 4(%esp)
	movl	$LC110, (%esp)
	call	_printf
	jmp	L97
L99:
	addl	$1, 192(%esp)
	movl	$12, 8(%esp)
	movl	$0, 4(%esp)
	leal	48(%esp), %eax
	movl	%eax, (%esp)
	call	_memset
	movl	176(%esp), %eax
	movl	%eax, 12(%esp)
	movl	$12, 8(%esp)
	movl	$1, 4(%esp)
	leal	48(%esp), %eax
	movl	%eax, (%esp)
	call	_fread
	movl	%eax, 172(%esp)
	cmpl	$11, 172(%esp)
	ja	L98
	movl	$12, 8(%esp)
	movl	172(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC107, (%esp)
	call	_printf
	jmp	L97
L98:
	movl	192(%esp), %eax
	movl	%eax, 4(%esp)
	leal	48(%esp), %eax
	movl	%eax, (%esp)
	call	_display_relocation_entry
L97:
	movl	192(%esp), %eax
	cmpl	196(%esp), %eax
	jb	L99
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_ftell
	movl	%eax, 4(%esp)
	movl	$LC111, (%esp)
	call	_printf
	movl	136(%esp), %eax
	movl	$0, 8(%esp)
	movl	%eax, 4(%esp)
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_fseek
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_ftell
	movl	%eax, 4(%esp)
	movl	$LC112, (%esp)
	call	_printf
	movl	$18, 4(%esp)
	movl	$LC113, (%esp)
	call	_printf
	movl	$8, 4(%esp)
	movl	$LC114, (%esp)
	call	_printf
	jmp	L100
L102:
	addl	$1, 188(%esp)
	movl	$18, 8(%esp)
	movl	$0, 4(%esp)
	leal	30(%esp), %eax
	movl	%eax, (%esp)
	call	_memset
	movl	176(%esp), %eax
	movl	%eax, 12(%esp)
	movl	$18, 8(%esp)
	movl	$1, 4(%esp)
	leal	30(%esp), %eax
	movl	%eax, (%esp)
	call	_fread
	movl	%eax, 172(%esp)
	cmpl	$17, 172(%esp)
	ja	L101
	movl	$18, 8(%esp)
	movl	172(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC107, (%esp)
	call	_printf
	jmp	L100
L101:
	movl	188(%esp), %eax
	movl	%eax, 4(%esp)
	leal	30(%esp), %eax
	movl	%eax, (%esp)
	call	_display_symbol_table_entry
L100:
	movl	140(%esp), %eax
	cmpl	188(%esp), %eax
	ja	L102
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_ftell
	movl	%eax, 4(%esp)
	movl	$LC115, (%esp)
	call	_printf
	movl	140(%esp), %eax
	testl	%eax, %eax
	jne	L103
	movl	140(%esp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, 184(%esp)
	jmp	L104
L103:
	movl	140(%esp), %edx
	movl	%edx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, 184(%esp)
L104:
	movl	136(%esp), %edx
	movl	184(%esp), %eax
	addl	%edx, %eax
	movl	%eax, 164(%esp)
	movl	164(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC116, (%esp)
	call	_printf
	movl	176(%esp), %eax
	movl	%eax, 12(%esp)
	movl	$4, 8(%esp)
	movl	$1, 4(%esp)
	leal	24(%esp), %eax
	movl	%eax, (%esp)
	call	_fread
	movl	%eax, 172(%esp)
	cmpl	$3, 172(%esp)
	ja	L105
	movl	$1, 8(%esp)
	movl	172(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC107, (%esp)
	call	_printf
	jmp	L106
L105:
	movl	24(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC117, (%esp)
	call	_printf
L106:
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_ftell
	movl	%eax, 156(%esp)
	movl	160(%esp), %eax
	subl	156(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC118, (%esp)
	call	_printf
	movl	160(%esp), %eax
	subl	164(%esp), %eax
	addl	$1, %eax
	movl	%eax, 152(%esp)
	movl	152(%esp), %eax
	subl	$1, %eax
	movl	%eax, 4(%esp)
	movl	$LC119, (%esp)
	call	_printf
	movl	160(%esp), %eax
	subl	156(%esp), %eax
	addl	$1, %eax
	movl	%eax, 152(%esp)
	cmpl	$0, 152(%esp)
	je	L107
	movl	152(%esp), %eax
	movl	%eax, (%esp)
	call	_malloc
	movl	%eax, 148(%esp)
	cmpl	$0, 148(%esp)
	je	L107
	movl	152(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$0, 4(%esp)
	movl	148(%esp), %eax
	movl	%eax, (%esp)
	call	_memset
	movl	152(%esp), %eax
	leal	-1(%eax), %edx
	movl	176(%esp), %eax
	movl	%eax, 12(%esp)
	movl	%edx, 8(%esp)
	movl	$1, 4(%esp)
	movl	148(%esp), %eax
	movl	%eax, (%esp)
	call	_fread
	movl	%eax, 172(%esp)
	movl	152(%esp), %eax
	subl	$1, %eax
	cmpl	172(%esp), %eax
	jbe	L108
	movl	152(%esp), %eax
	movl	%eax, 8(%esp)
	movl	172(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC107, (%esp)
	call	_printf
	jmp	L109
L108:
	movl	152(%esp), %eax
	movl	%eax, 4(%esp)
	movl	148(%esp), %eax
	movl	%eax, (%esp)
	call	_display_string_table
L109:
	movl	148(%esp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	$0, 148(%esp)
L107:
	movl	176(%esp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$0, 176(%esp)
	movl	$0, %eax
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE12:
	.ident	"GCC: (GNU) 5.3.0"
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_putchar;	.scl	2;	.type	32;	.endef
	.def	_memset;	.scl	2;	.type	32;	.endef
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_fseek;	.scl	2;	.type	32;	.endef
	.def	_ftell;	.scl	2;	.type	32;	.endef
	.def	_fread;	.scl	2;	.type	32;	.endef
	.def	_malloc;	.scl	2;	.type	32;	.endef
	.def	_free;	.scl	2;	.type	32;	.endef
	.def	_fclose;	.scl	2;	.type	32;	.endef
