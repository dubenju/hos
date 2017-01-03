	TITLE	03stat.c
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
PUBLIC	_main
EXTRN	_perror:NEAR
EXTRN	_printf:NEAR
EXTRN	_exit:NEAR
EXTRN	_ctime:NEAR
EXTRN	_stat:NEAR
_DATA	SEGMENT
$SG785	DB	'main : ', 08eH, 0c0H, 08dH, 's', 08eH, 09eH, 088H, 0f8H, 090H
	DB	094H, 082H, 0ccH, 090H, 094H, 082H, 0aaH, 095H, 's', 093H, 096H
	DB	082H, 0c5H, 082H, 0b7H, 0aH, 00H
	ORG $+3
$SG787	DB	083H, 'f', 083H, 'o', 083H, 'C', 083H, 'XID : %d', 0aH, 00H
	ORG $+3
$SG788	DB	'inode', 094H, 0d4H, 08dH, 086H, ' : %d', 0aH, 00H
$SG789	DB	083H, 'A', 083H, 'N', 083H, 'Z', 083H, 'X', 095H, 0dbH, 08cH
	DB	0ecH, ' : %o', 0aH, 00H
	ORG $+1
$SG790	DB	083H, 'n', 081H, '[', 083H, 'h', 083H, 08aH, 083H, 093H, 083H
	DB	'N', 082H, 0ccH, 090H, 094H, ' : %d', 0aH, 00H
	ORG $+1
$SG791	DB	08fH, 08aH, 097H, 'L', 08eH, 0d2H, 082H, 0ccH, 083H, 086H
	DB	081H, '[', 083H, 'UID : %d', 0aH, 00H
	ORG $+1
$SG792	DB	08fH, 08aH, 097H, 'L', 08eH, 0d2H, 082H, 0ccH, 083H, 'O', 083H
	DB	08bH, 081H, '[', 083H, 'vID : %d', 0aH, 00H
	ORG $+3
$SG793	DB	083H, 'f', 083H, 'o', 083H, 'C', 083H, 'XID', 081H, 'i', 093H
	DB	0c1H, 08eH, 0eaH, 083H, 't', 083H, '@', 083H, 'C', 083H, 08bH, 082H
	DB	0ccH, 08fH, 0eaH, 08dH, 087H, 081H, 'j : %d', 0aH, 00H
	ORG $+1
$SG794	DB	097H, 'e', 097H, 0caH, 081H, 'i', 083H, 'o', 083H, 'C', 083H
	DB	'g', 092H, 'P', 088H, 0caH, 081H, 'j : %d', 0aH, 00H
	ORG $+3
$SG795	DB	08dH, 0c5H, 08fH, 'I', 083H, 'A', 083H, 'N', 083H, 'Z', 083H
	DB	'X', 08eH, 09eH, 08dH, 08fH, ' : %s', 00H
	ORG $+2
$SG796	DB	08dH, 0c5H, 08fH, 'I', 08fH, 'C', 090H, 0b3H, 08eH, 09eH, 08dH
	DB	08fH, ' : %s', 00H
	ORG $+2
$SG797	DB	08dH, 0c5H, 08fH, 'I', 08fH, 0f3H, 091H, 0d4H, 095H, 0cfH
	DB	08dH, 'X', 08eH, 09eH, 08dH, 08fH, ' : %s', 00H
	ORG $+2
$SG799	DB	'main ', 00H
_DATA	ENDS
_TEXT	SEGMENT
_argc$ = 8
_argv$ = 12
_stat_buf$ = -36
_main	PROC NEAR

; 41   : {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp
  00003	83 ec 24	 sub	 esp, 36			; 00000024H

; 42   :   struct stat      stat_buf;
; 43   : 
; 44   :   if (argc != 2) {

  00006	83 7d 08 02	 cmp	 DWORD PTR _argc$[ebp], 2
  0000a	74 14		 je	 SHORT $L784

; 45   :     printf("main : 実行時引数の数が不当です\n");

  0000c	68 00 00 00 00	 push	 OFFSET FLAT:$SG785
  00011	e8 00 00 00 00	 call	 _printf
  00016	83 c4 04	 add	 esp, 4

; 46   :     exit(EXIT_FAILURE);

  00019	6a 01		 push	 1
  0001b	e8 00 00 00 00	 call	 _exit
$L784:

; 48   : 
; 49   :   if (stat(*(argv + 1), &stat_buf) == 0) {

  00020	8d 45 dc	 lea	 eax, DWORD PTR _stat_buf$[ebp]
  00023	50		 push	 eax
  00024	8b 4d 0c	 mov	 ecx, DWORD PTR _argv$[ebp]
  00027	8b 51 04	 mov	 edx, DWORD PTR [ecx+4]
  0002a	52		 push	 edx
  0002b	e8 00 00 00 00	 call	 _stat
  00030	83 c4 08	 add	 esp, 8
  00033	85 c0		 test	 eax, eax
  00035	0f 85 e7 00 00
	00		 jne	 $L786

; 50   :     /* ファイル情報を表示 */
; 51   :     printf("デバイスID : %d\n",stat_buf.st_dev);

  0003b	8b 45 dc	 mov	 eax, DWORD PTR _stat_buf$[ebp]
  0003e	50		 push	 eax
  0003f	68 00 00 00 00	 push	 OFFSET FLAT:$SG787
  00044	e8 00 00 00 00	 call	 _printf
  00049	83 c4 08	 add	 esp, 8

; 52   :     printf("inode番号 : %d\n",stat_buf.st_ino);

  0004c	8b 4d e0	 mov	 ecx, DWORD PTR _stat_buf$[ebp+4]
  0004f	81 e1 ff ff 00
	00		 and	 ecx, 65535		; 0000ffffH
  00055	51		 push	 ecx
  00056	68 00 00 00 00	 push	 OFFSET FLAT:$SG788
  0005b	e8 00 00 00 00	 call	 _printf
  00060	83 c4 08	 add	 esp, 8

; 53   :     printf("アクセス保護 : %o\n",stat_buf.st_mode);

  00063	8b 55 e2	 mov	 edx, DWORD PTR _stat_buf$[ebp+6]
  00066	81 e2 ff ff 00
	00		 and	 edx, 65535		; 0000ffffH
  0006c	52		 push	 edx
  0006d	68 00 00 00 00	 push	 OFFSET FLAT:$SG789
  00072	e8 00 00 00 00	 call	 _printf
  00077	83 c4 08	 add	 esp, 8

; 54   :     printf("ハードリンクの数 : %d\n",stat_buf.st_nlink);

  0007a	0f bf 45 e4	 movsx	 eax, WORD PTR _stat_buf$[ebp+8]
  0007e	50		 push	 eax
  0007f	68 00 00 00 00	 push	 OFFSET FLAT:$SG790
  00084	e8 00 00 00 00	 call	 _printf
  00089	83 c4 08	 add	 esp, 8

; 55   :     printf("所有者のユーザID : %d\n",stat_buf.st_uid);

  0008c	0f bf 4d e6	 movsx	 ecx, WORD PTR _stat_buf$[ebp+10]
  00090	51		 push	 ecx
  00091	68 00 00 00 00	 push	 OFFSET FLAT:$SG791
  00096	e8 00 00 00 00	 call	 _printf
  0009b	83 c4 08	 add	 esp, 8

; 56   :     printf("所有者のグループID : %d\n",stat_buf.st_gid);

  0009e	0f bf 55 e8	 movsx	 edx, WORD PTR _stat_buf$[ebp+12]
  000a2	52		 push	 edx
  000a3	68 00 00 00 00	 push	 OFFSET FLAT:$SG792
  000a8	e8 00 00 00 00	 call	 _printf
  000ad	83 c4 08	 add	 esp, 8

; 57   :     printf("デバイスID（特殊ファイルの場合） : %d\n",stat_buf.st_rdev);

  000b0	8b 45 ec	 mov	 eax, DWORD PTR _stat_buf$[ebp+16]
  000b3	50		 push	 eax
  000b4	68 00 00 00 00	 push	 OFFSET FLAT:$SG793
  000b9	e8 00 00 00 00	 call	 _printf
  000be	83 c4 08	 add	 esp, 8

; 58   :     printf("容量（バイト単位） : %d\n",stat_buf.st_size);

  000c1	8b 4d f0	 mov	 ecx, DWORD PTR _stat_buf$[ebp+20]
  000c4	51		 push	 ecx
  000c5	68 00 00 00 00	 push	 OFFSET FLAT:$SG794
  000ca	e8 00 00 00 00	 call	 _printf
  000cf	83 c4 08	 add	 esp, 8

; 59   : //    printf("ファイルシステムのブロックサイズ : %d\n",stat_buf.st_blksize);
; 60   : //    printf("割り当てられたブロック数 : %d\n",stat_buf.st_blocks);
; 61   :     printf("最終アクセス時刻 : %s",ctime(&stat_buf.st_atime));

  000d2	8d 55 f4	 lea	 edx, DWORD PTR _stat_buf$[ebp+24]
  000d5	52		 push	 edx
  000d6	e8 00 00 00 00	 call	 _ctime
  000db	83 c4 04	 add	 esp, 4
  000de	50		 push	 eax
  000df	68 00 00 00 00	 push	 OFFSET FLAT:$SG795
  000e4	e8 00 00 00 00	 call	 _printf
  000e9	83 c4 08	 add	 esp, 8

; 62   :     printf("最終修正時刻 : %s",ctime(&stat_buf.st_mtime));

  000ec	8d 45 f8	 lea	 eax, DWORD PTR _stat_buf$[ebp+28]
  000ef	50		 push	 eax
  000f0	e8 00 00 00 00	 call	 _ctime
  000f5	83 c4 04	 add	 esp, 4
  000f8	50		 push	 eax
  000f9	68 00 00 00 00	 push	 OFFSET FLAT:$SG796
  000fe	e8 00 00 00 00	 call	 _printf
  00103	83 c4 08	 add	 esp, 8

; 63   :     printf("最終状態変更時刻 : %s",ctime(&stat_buf.st_ctime));

  00106	8d 4d fc	 lea	 ecx, DWORD PTR _stat_buf$[ebp+32]
  00109	51		 push	 ecx
  0010a	e8 00 00 00 00	 call	 _ctime
  0010f	83 c4 04	 add	 esp, 4
  00112	50		 push	 eax
  00113	68 00 00 00 00	 push	 OFFSET FLAT:$SG797
  00118	e8 00 00 00 00	 call	 _printf
  0011d	83 c4 08	 add	 esp, 8

; 65   :   else {

  00120	eb 0d		 jmp	 SHORT $L798
$L786:

; 66   :     perror("main ");

  00122	68 00 00 00 00	 push	 OFFSET FLAT:$SG799
  00127	e8 00 00 00 00	 call	 _perror
  0012c	83 c4 04	 add	 esp, 4
$L798:

; 68   : 
; 69   :   return EXIT_SUCCESS;

  0012f	33 c0		 xor	 eax, eax
$L782:

; 70   : }

  00131	8b e5		 mov	 esp, ebp
  00133	5d		 pop	 ebp
  00134	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
