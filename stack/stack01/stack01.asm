    TITLE    stack01.c
    .386P
include listing.inc
if @Version gt 510
.model FLAT
else
_TEXT   SEGMENT PARA USE32 PUBLIC 'CODE'
_TEXT   ENDS
_DATA   SEGMENT DWORD USE32 PUBLIC 'DATA'
_DATA   ENDS
CONST   SEGMENT DWORD USE32 PUBLIC 'CONST'
CONST   ENDS
_BSS    SEGMENT DWORD USE32 PUBLIC 'BSS'
_BSS    ENDS
_TLS    SEGMENT DWORD USE32 PUBLIC 'TLS'
_TLS    ENDS
FLAT    GROUP _DATA, CONST, _BSS
    ASSUME    CS: FLAT, DS: FLAT, SS: FLAT
endif


PUBLIC    _a
_BSS    SEGMENT
_a    DD    01H DUP (?)
_BSS    ENDS

_DATA    SEGMENT
COMM    _p1:DWORD
_DATA    ENDS

_BSS    SEGMENT
_?c@?1??main@@9@9 DD 01H DUP (?)
_BSS    ENDS



PUBLIC    _main
EXTRN    _printf:NEAR
EXTRN    _malloc:NEAR
EXTRN    _strcpy:NEAR

_DATA    SEGMENT
$SG915    DB    'abc', 00H
$SG918    DB    '123456', 00H
    ORG $+1
$SG921    DB    'int    a  = 0;                  %p.', 0e5H, 085H, 0a8H, 0e5H
    DB    0b1H, 080H, 0e5H, 08fH, 098H, 0e9H, 087H, 08fH, 0aH, 00H
    ORG $+3
$SG922    DB    'char * p1;                      %p.', 0e5H, 085H, 0a8H, 0e5H
    DB    0b1H, 080H, 0e5H, 08fH, 098H, 0e9H, 087H, 08fH, 0aH, 00H
    ORG $+3
$SG923    DB    'int main(int argc, char * argv[]) {', 0aH, 00H
    ORG $+3
$SG924    DB    '    int    b;                   %p.', 0e5H, 0b1H, 080H, 0e9H
    DB    083H, 0a8H, 0e5H, 08fH, 098H, 0e9H, 087H, 08fH, 0aH, 00H
    ORG $+3
$SG925    DB    '    char   s[] = "abc";         %p.', 0e5H, 0b1H, 080H, 0e9H
    DB    083H, 0a8H, 0e5H, 08fH, 098H, 0e9H, 087H, 08fH, 0aH, 00H
    ORG $+3
$SG926    DB    'abc', 00H
$SG927    DB    '    char   s[] = "abc";         %p.', 0e5H, 0b8H, 0b8H, 0e9H
    DB    087H, 08fH, '\n', 00H
$SG928    DB    0aH, 00H
    ORG $+2
$SG929    DB    '    char   s[] = "abc";         %p.', 0e5H, 0b8H, 0b8H, 0e9H
    DB    087H, 08fH, '\n', 00H
$SG930    DB    0aH, 00H
    ORG $+2
$SG931    DB    '    char * p2;                  %p.', 0e5H, 0b1H, 080H, 0e9H
    DB    083H, 0a8H, 0e5H, 08fH, 098H, 0e9H, 087H, 08fH, 0aH, 00H
    ORG $+3
$SG932    DB    '    char * p3 = "123456";       %p.', 0e5H, 0b1H, 080H, 0e9H
    DB    083H, 0a8H, 0e5H, 08fH, 098H, 0e9H, 087H, 08fH, 0aH, 00H
    ORG $+3
$SG933    DB    '123456', 00H
    ORG $+1
$SG934    DB    '    char * p3 = "123456";       %p.', 0e5H, 0b8H, 0b8H, 0e9H
    DB    087H, 08fH, '\n', 00H
$SG935    DB    0aH, 00H
    ORG $+2
$SG936    DB    '    char * p3 = "123456";       %p.', 0e5H, 0b8H, 0b8H, 0e9H
    DB    087H, 08fH, '\n', 00H
$SG937    DB    0aH, 00H
    ORG $+2
$SG938    DB    '    static int c = 0;           %p.', 0aH, 00H
    ORG $+3
$SG940    DB    '    p1 = (char *) malloc(10);   %p.', 0aH, 00H
    ORG $+3
$SG941    DB    '    p1 = (char *) malloc(10);   %p.', 0aH, 00H
    ORG $+3
$SG943    DB    '    p2 = (char *) malloc(20);   %p.', 0aH, 00H
    ORG $+3
$SG944    DB    '    p2 = (char *) malloc(20);   %p.', 0aH, 00H
    ORG $+3
$SG945    DB    '123456', 00H
    ORG $+1
$SG946    DB    '    strcpy(p1, "123456");       %p.', 0aH, 00H
    ORG $+3
$SG947    DB    '    strcpy(p1, "123456");       %p.', 0aH, 00H
    ORG $+3
$SG948    DB    '    return 0;', 0aH, 00H
    ORG $+1
$SG949    DB    '}', 0aH, 00H
_DATA    ENDS

_TEXT    SEGMENT
_b$ = -4
_s$ = -8
_p2$ = -12
_p3$ = -16

_main    PROC NEAR
; File stack01.c
; Line 7
    push    ebp
    mov    ebp, esp
    sub    esp, 16                    ; 00000010H
; Line 10
    mov    eax, DWORD PTR $SG915
    mov    DWORD PTR _s$[ebp], eax
; Line 12
    mov    DWORD PTR _p3$[ebp], OFFSET FLAT:$SG918
; Line 15
    push    OFFSET FLAT:_a
    push    OFFSET FLAT:$SG921
    call    _printf
    add    esp, 8
; Line 16
    push    OFFSET FLAT:_p1
    push    OFFSET FLAT:$SG922
    call    _printf
    add    esp, 8
; Line 17
    push    OFFSET FLAT:$SG923
    call    _printf
    add    esp, 4
; Line 18
    lea    ecx, DWORD PTR _b$[ebp]
    push    ecx
    push    OFFSET FLAT:$SG924
    call    _printf
    add    esp, 8
; Line 19
    lea    edx, DWORD PTR _s$[ebp]
    push    edx
    push    OFFSET FLAT:$SG925
    call    _printf
    add    esp, 8
; Line 20
    push    OFFSET FLAT:$SG926
    push    OFFSET FLAT:$SG927
    call    _printf
    add    esp, 8
; Line 21
    push    OFFSET FLAT:$SG928
    call    _printf
    add    esp, 4
; Line 22
    movsx    eax, BYTE PTR _s$[ebp]
    push    eax
    push    OFFSET FLAT:$SG929
    call    _printf
    add    esp, 8
; Line 23
    push    OFFSET FLAT:$SG930
    call    _printf
    add    esp, 4
; Line 24
    lea    ecx, DWORD PTR _p2$[ebp]
    push    ecx
    push    OFFSET FLAT:$SG931
    call    _printf
    add    esp, 8
; Line 25
    lea    edx, DWORD PTR _p3$[ebp]
    push    edx
    push    OFFSET FLAT:$SG932
    call    _printf
    add    esp, 8
; Line 26
    push    OFFSET FLAT:$SG933
    push    OFFSET FLAT:$SG934
    call    _printf
    add    esp, 8
; Line 27
    push    OFFSET FLAT:$SG935
    call    _printf
    add    esp, 4
; Line 28
    mov    eax, DWORD PTR _p3$[ebp]
    push    eax
    push    OFFSET FLAT:$SG936
    call    _printf
    add    esp, 8
; Line 29
    push    OFFSET FLAT:$SG937
    call    _printf
    add    esp, 4
; Line 30
    push    OFFSET FLAT:_?c@?1??main@@9@9
    push    OFFSET FLAT:$SG938
    call    _printf
    add    esp, 8
; Line 32
    push    10                    ; 0000000aH
    call    _malloc
    add    esp, 4
    mov    DWORD PTR _p1, eax
; Line 33
    push    OFFSET FLAT:_p1
    push    OFFSET FLAT:$SG940
    call    _printf
    add    esp, 8
; Line 34
    mov    ecx, DWORD PTR _p1
    push    ecx
    push    OFFSET FLAT:$SG941
    call    _printf
    add    esp, 8
; Line 35
    push    20                    ; 00000014H
    call    _malloc
    add    esp, 4
    mov    DWORD PTR _p2$[ebp], eax
; Line 36
    lea    edx, DWORD PTR _p2$[ebp]
    push    edx
    push    OFFSET FLAT:$SG943
    call    _printf
    add    esp, 8
; Line 37
    mov    eax, DWORD PTR _p2$[ebp]
    push    eax
    push    OFFSET FLAT:$SG944
    call    _printf
    add    esp, 8
; Line 38
    push    OFFSET FLAT:$SG945
    mov    ecx, DWORD PTR _p1
    push    ecx
    call    _strcpy
    add    esp, 8
; Line 39
    push    OFFSET FLAT:_p1
    push    OFFSET FLAT:$SG946
    call    _printf
    add    esp, 8
; Line 40
    mov    edx, DWORD PTR _p1
    push    edx
    push    OFFSET FLAT:$SG947
    call    _printf
    add    esp, 8
; Line 41
    push    OFFSET FLAT:$SG948
    call    _printf
    add    esp, 4
; Line 42
    push    OFFSET FLAT:$SG949
    call    _printf
    add    esp, 4
; Line 44
    xor    eax, eax
; Line 45
    mov    esp, ebp
    pop    ebp
    ret    0
_main    ENDP

_TEXT    ENDS
END
