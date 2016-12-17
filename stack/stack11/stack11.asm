	TITLE	stack11.c
	.386P
include listing.inc
if @Version gt 510
.model FLAT
else
_TEXT	SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT	ENDS
_DATA	SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA	ENDS
CONST	SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST	ENDS
_BSS	SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS	ENDS
_TLS	SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS	ENDS
FLAT	GROUP _DATA, CONST, _BSS
	ASSUME	CS: FLAT, DS: FLAT, SS: FLAT
endif
PUBLIC	_foo
EXTRN	_printf:NEAR
EXTRN	_strcpy:NEAR
_DATA	SEGMENT
$SG603	DB	'My stack looks like:', 0aH, '%p', 0aH, '%p', 0aH, '%p', 0aH
	DB	'%p', 0aH, '%p', 0aH, '%p', 0aH, '%p', 0aH, 0aH, 00H
$SG604	DB	'buf = %s', 0aH, 00H
	ORG $+2
$SG605	DB	'Now the stack looks like:', 0aH, '%p', 0aH, '%p', 0aH, '%'
	DB	'p', 0aH, '%p', 0aH, '%p', 0aH, '%p', 0aH, '%p', 0aH, 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_input$ = 8
_buf$ = -12
_foo	PROC NEAR

; 4    : void foo(const char* input) {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp
  00003	83 ec 0c	 sub	 esp, 12			; 0000000cH

; 5    :         char buf[10];
; 6    :         printf("My stack looks like:\n%p\n%p\n%p\n%p\n%p\n%p\n%p\n\n");

  00006	68 00 00 00 00	 push	 OFFSET FLAT:$SG603
  0000b	e8 00 00 00 00	 call	 _printf
  00010	83 c4 04	 add	 esp, 4

; 7    :         strcpy(buf, input);

  00013	8b 45 08	 mov	 eax, DWORD PTR _input$[ebp]
  00016	50		 push	 eax
  00017	8d 4d f4	 lea	 ecx, DWORD PTR _buf$[ebp]
  0001a	51		 push	 ecx
  0001b	e8 00 00 00 00	 call	 _strcpy
  00020	83 c4 08	 add	 esp, 8

; 8    :         printf("buf = %s\n", buf);

  00023	8d 55 f4	 lea	 edx, DWORD PTR _buf$[ebp]
  00026	52		 push	 edx
  00027	68 00 00 00 00	 push	 OFFSET FLAT:$SG604
  0002c	e8 00 00 00 00	 call	 _printf
  00031	83 c4 08	 add	 esp, 8

; 9    :         printf("Now the stack looks like:\n%p\n%p\n%p\n%p\n%p\n%p\n%p\n\n");

  00034	68 00 00 00 00	 push	 OFFSET FLAT:$SG605
  00039	e8 00 00 00 00	 call	 _printf
  0003e	83 c4 04	 add	 esp, 4

; 10   : }

  00041	8b e5		 mov	 esp, ebp
  00043	5d		 pop	 ebp
  00044	c3		 ret	 0
_foo	ENDP
_TEXT	ENDS
PUBLIC	_bar
_DATA	SEGMENT
	ORG $+3
$SG609	DB	'Augh! I''ve been hacked!', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_bar	PROC NEAR

; 11   : void bar(void) {

  00045	55		 push	 ebp
  00046	8b ec		 mov	 ebp, esp

; 12   :         printf("Augh! I've been hacked!\n");

  00048	68 00 00 00 00	 push	 OFFSET FLAT:$SG609
  0004d	e8 00 00 00 00	 call	 _printf
  00052	83 c4 04	 add	 esp, 4

; 13   : }

  00055	5d		 pop	 ebp
  00056	c3		 ret	 0
_bar	ENDP
_TEXT	ENDS
PUBLIC	_main
_DATA	SEGMENT
	ORG $+3
$SG616	DB	'Address of foo = %p', 0aH, 00H
	ORG $+3
$SG617	DB	'Address of bar = %p', 0aH, 00H
	ORG $+3
$SG619	DB	'Please supply a string as an argument!', 0aH, 00H
$SG620	DB	'Exit!', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_argc$ = 8
_argv$ = 12
_main	PROC NEAR

; 15   : int main(int argc, char* argv[]) {

  00057	55		 push	 ebp
  00058	8b ec		 mov	 ebp, esp

; 16   :         printf("Address of foo = %p\n", foo);

  0005a	68 00 00 00 00	 push	 OFFSET FLAT:_foo
  0005f	68 00 00 00 00	 push	 OFFSET FLAT:$SG616
  00064	e8 00 00 00 00	 call	 _printf
  00069	83 c4 08	 add	 esp, 8

; 17   :         printf("Address of bar = %p\n", bar);

  0006c	68 00 00 00 00	 push	 OFFSET FLAT:_bar
  00071	68 00 00 00 00	 push	 OFFSET FLAT:$SG617
  00076	e8 00 00 00 00	 call	 _printf
  0007b	83 c4 08	 add	 esp, 8

; 18   :         if (argc != 2) {

  0007e	83 7d 08 02	 cmp	 DWORD PTR _argc$[ebp], 2
  00082	74 12		 je	 SHORT $L618

; 19   :                 printf("Please supply a string as an argument!\n");

  00084	68 00 00 00 00	 push	 OFFSET FLAT:$SG619
  00089	e8 00 00 00 00	 call	 _printf
  0008e	83 c4 04	 add	 esp, 4

; 20   :                 return -1;

  00091	83 c8 ff	 or	 eax, -1
  00094	eb 1e		 jmp	 SHORT $L615
$L618:

; 22   :         foo(argv[1]);

  00096	8b 45 0c	 mov	 eax, DWORD PTR _argv$[ebp]
  00099	8b 48 04	 mov	 ecx, DWORD PTR [eax+4]
  0009c	51		 push	 ecx
  0009d	e8 00 00 00 00	 call	 _foo
  000a2	83 c4 04	 add	 esp, 4

; 23   :         printf("Exit!\n");

  000a5	68 00 00 00 00	 push	 OFFSET FLAT:$SG620
  000aa	e8 00 00 00 00	 call	 _printf
  000af	83 c4 04	 add	 esp, 4

; 24   :         return 0;

  000b2	33 c0		 xor	 eax, eax
$L615:

; 25   : }

  000b4	5d		 pop	 ebp
  000b5	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
