	TITLE	07fsize.c
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
EXTRN	__imp__CloseHandle@4:NEAR
EXTRN	_printf:NEAR
EXTRN	_ceil:NEAR
EXTRN	__tprintf_s:NEAR
EXTRN	_GetFileSizeEx:NEAR
EXTRN	_GetVolumePathName:NEAR
EXTRN	__aulldiv:NEAR
EXTRN	__ftol:NEAR
EXTRN	__fltused:NEAR
EXTRN	__imp__GetLastError@0:NEAR
EXTRN	__imp__GetDiskFreeSpaceA@20:NEAR
EXTRN	__imp__CreateFileA@28:NEAR
_DATA	SEGMENT
$SG52941 DB	'C:\', 00H
$SG52949 DB	'Usage: GetFileSpaceSize filename', 0aH, 00H
	ORG $+2
$SG52955 DB	'Failed to create file handle: %s ! error code:%d', 0aH, 00H
	ORG $+2
$SG52960 DB	'Failed to get disk cluster info! error code: %d', 0aH, 00H
	ORG $+3
$SG52961 DB	'FileName : %s', 0aH, 00H
	ORG $+1
$SG52962 DB	'FileSize : %I64u Byte', 0aH, 00H
	ORG $+1
$SG52963 DB	'FileSpacesSize : %I64u Byte', 0aH, 00H
_DATA	ENDS
_TEXT	SEGMENT
_argc$ = 8
_argv$ = 12
_szFileName$ = -4
_hFile$ = -48
_uFileSize$ = -28
_szVolumePathName$ = -36
_dwSectorsPerCluster$ = -20
_dwBytesPerSector$ = -44
_dwNumberOfFreeClusters$ = -32
_dwTotalNumberOfClusters$ = -8
_dwClusterSize$ = -40
_dwFileSpacesize$ = -16
_main	PROC NEAR

; 16   : int _tmain(int argc, _TCHAR* argv[]) {

  00000	55		 push	 ebp
  00001	8b ec		 mov	 ebp, esp
  00003	83 ec 40	 sub	 esp, 64			; 00000040H

; 17   :     LPCTSTR szFileName = NULL;

  00006	c7 45 fc 00 00
	00 00		 mov	 DWORD PTR _szFileName$[ebp], 0

; 18   :     HANDLE hFile = NULL;

  0000d	c7 45 d0 00 00
	00 00		 mov	 DWORD PTR _hFile$[ebp], 0

; 19   :     UINT64 uFileSize = 0;

  00014	c7 45 e4 00 00
	00 00		 mov	 DWORD PTR _uFileSize$[ebp], 0
  0001b	c7 45 e8 00 00
	00 00		 mov	 DWORD PTR _uFileSize$[ebp+4], 0

; 20   :     TCHAR szVolumePathName[] = _T("C:\\");

  00022	a1 00 00 00 00	 mov	 eax, DWORD PTR $SG52941
  00027	89 45 dc	 mov	 DWORD PTR _szVolumePathName$[ebp], eax

; 21   :     // 保存簇信息的变量
; 22   :     DWORD dwSectorsPerCluster = 0;

  0002a	c7 45 ec 00 00
	00 00		 mov	 DWORD PTR _dwSectorsPerCluster$[ebp], 0

; 23   :     DWORD dwBytesPerSector = 0;

  00031	c7 45 d4 00 00
	00 00		 mov	 DWORD PTR _dwBytesPerSector$[ebp], 0

; 24   :     DWORD dwNumberOfFreeClusters = 0;

  00038	c7 45 e0 00 00
	00 00		 mov	 DWORD PTR _dwNumberOfFreeClusters$[ebp], 0

; 25   :     DWORD dwTotalNumberOfClusters = 0;

  0003f	c7 45 f8 00 00
	00 00		 mov	 DWORD PTR _dwTotalNumberOfClusters$[ebp], 0

; 26   :     DWORD dwClusterSize = 0;

  00046	c7 45 d8 00 00
	00 00		 mov	 DWORD PTR _dwClusterSize$[ebp], 0

; 27   :     UINT64 dwFileSpacesize = 0;

  0004d	c7 45 f0 00 00
	00 00		 mov	 DWORD PTR _dwFileSpacesize$[ebp], 0
  00054	c7 45 f4 00 00
	00 00		 mov	 DWORD PTR _dwFileSpacesize$[ebp+4], 0

; 28   : 
; 29   :     if (argc < 2) {

  0005b	83 7d 08 02	 cmp	 DWORD PTR _argc$[ebp], 2
  0005f	7d 15		 jge	 SHORT $L52948

; 30   :         printf("Usage: GetFileSpaceSize filename\n");

  00061	68 00 00 00 00	 push	 OFFSET FLAT:$SG52949
  00066	e8 00 00 00 00	 call	 _printf
  0006b	83 c4 04	 add	 esp, 4

; 31   :         return -1;

  0006e	83 c8 ff	 or	 eax, -1
  00071	e9 43 01 00 00	 jmp	 $L52934
$L52948:

; 33   : 
; 34   :     // 文件路径
; 35   :     szFileName = argv[1];

  00076	8b 4d 0c	 mov	 ecx, DWORD PTR _argv$[ebp]
  00079	8b 51 04	 mov	 edx, DWORD PTR [ecx+4]
  0007c	89 55 fc	 mov	 DWORD PTR _szFileName$[ebp], edx

; 36   : 
; 37   :     // 打开文件句柄
; 38   :     hFile = CreateFile(szFileName, GENERIC_READ | FILE_SHARE_READ, 0, 
; 39   :         NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);

  0007f	6a 00		 push	 0
  00081	68 80 00 00 00	 push	 128			; 00000080H
  00086	6a 03		 push	 3
  00088	6a 00		 push	 0
  0008a	6a 00		 push	 0
  0008c	68 01 00 00 80	 push	 -2147483647		; 80000001H
  00091	8b 45 fc	 mov	 eax, DWORD PTR _szFileName$[ebp]
  00094	50		 push	 eax
  00095	ff 15 00 00 00
	00		 call	 DWORD PTR __imp__CreateFileA@28
  0009b	89 45 d0	 mov	 DWORD PTR _hFile$[ebp], eax

; 40   :     if (hFile == INVALID_HANDLE_VALUE)

  0009e	83 7d d0 ff	 cmp	 DWORD PTR _hFile$[ebp], -1
  000a2	75 20		 jne	 SHORT $L52953

; 42   :         _tprintf_s(_T("Failed to create file handle: %s ! error code:%d\n"), szFileName, GetLastError());

  000a4	ff 15 00 00 00
	00		 call	 DWORD PTR __imp__GetLastError@0
  000aa	50		 push	 eax
  000ab	8b 4d fc	 mov	 ecx, DWORD PTR _szFileName$[ebp]
  000ae	51		 push	 ecx
  000af	68 00 00 00 00	 push	 OFFSET FLAT:$SG52955
  000b4	e8 00 00 00 00	 call	 __tprintf_s
  000b9	83 c4 0c	 add	 esp, 12			; 0000000cH

; 43   :         return -1;

  000bc	83 c8 ff	 or	 eax, -1
  000bf	e9 f5 00 00 00	 jmp	 $L52934
$L52953:

; 45   : 
; 46   :     // 获取文件大小
; 47   :     GetFileSizeEx(hFile, (&uFileSize));

  000c4	8d 55 e4	 lea	 edx, DWORD PTR _uFileSize$[ebp]
  000c7	52		 push	 edx
  000c8	8b 45 d0	 mov	 eax, DWORD PTR _hFile$[ebp]
  000cb	50		 push	 eax
  000cc	e8 00 00 00 00	 call	 _GetFileSizeEx
  000d1	83 c4 08	 add	 esp, 8

; 48   :     CloseHandle(hFile);

  000d4	8b 4d d0	 mov	 ecx, DWORD PTR _hFile$[ebp]
  000d7	51		 push	 ecx
  000d8	ff 15 00 00 00
	00		 call	 DWORD PTR __imp__CloseHandle@4

; 49   : 
; 50   :     // 获取磁盘根路径
; 51   :     GetVolumePathName(szFileName, szVolumePathName, sizeof(szVolumePathName) / sizeof(TCHAR));

  000de	6a 04		 push	 4
  000e0	8d 55 dc	 lea	 edx, DWORD PTR _szVolumePathName$[ebp]
  000e3	52		 push	 edx
  000e4	8b 45 fc	 mov	 eax, DWORD PTR _szFileName$[ebp]
  000e7	50		 push	 eax
  000e8	e8 00 00 00 00	 call	 _GetVolumePathName
  000ed	83 c4 0c	 add	 esp, 12			; 0000000cH

; 52   : 
; 53   : 
; 54   :     // 获取簇信息
; 55   :     if (!GetDiskFreeSpace(
; 56   :                 szVolumePathName,            //磁盘根路径
; 57   :                 &dwSectorsPerCluster,        //每簇的扇区数
; 58   :                 &dwBytesPerSector,            //每扇区的字节数
; 59   :                 &dwNumberOfFreeClusters,    //空余簇的数量
; 60   :                 &dwTotalNumberOfClusters    //全部簇的数量
; 61   :                 )
; 62   :         )

  000f0	8d 4d f8	 lea	 ecx, DWORD PTR _dwTotalNumberOfClusters$[ebp]
  000f3	51		 push	 ecx
  000f4	8d 55 e0	 lea	 edx, DWORD PTR _dwNumberOfFreeClusters$[ebp]
  000f7	52		 push	 edx
  000f8	8d 45 d4	 lea	 eax, DWORD PTR _dwBytesPerSector$[ebp]
  000fb	50		 push	 eax
  000fc	8d 4d ec	 lea	 ecx, DWORD PTR _dwSectorsPerCluster$[ebp]
  000ff	51		 push	 ecx
  00100	8d 55 dc	 lea	 edx, DWORD PTR _szVolumePathName$[ebp]
  00103	52		 push	 edx
  00104	ff 15 00 00 00
	00		 call	 DWORD PTR __imp__GetDiskFreeSpaceA@20
  0010a	85 c0		 test	 eax, eax
  0010c	75 1c		 jne	 SHORT $L52959

; 64   :         _tprintf_s(_T("Failed to get disk cluster info! error code: %d\n"), GetLastError());

  0010e	ff 15 00 00 00
	00		 call	 DWORD PTR __imp__GetLastError@0
  00114	50		 push	 eax
  00115	68 00 00 00 00	 push	 OFFSET FLAT:$SG52960
  0011a	e8 00 00 00 00	 call	 __tprintf_s
  0011f	83 c4 08	 add	 esp, 8

; 65   :         return -1;

  00122	83 c8 ff	 or	 eax, -1
  00125	e9 8f 00 00 00	 jmp	 $L52934
$L52959:

; 67   :     // 簇大小 = 每簇的扇区数 * 每扇区的字节数
; 68   :     dwClusterSize = dwSectorsPerCluster * dwBytesPerSector;

  0012a	8b 45 ec	 mov	 eax, DWORD PTR _dwSectorsPerCluster$[ebp]
  0012d	0f af 45 d4	 imul	 eax, DWORD PTR _dwBytesPerSector$[ebp]
  00131	89 45 d8	 mov	 DWORD PTR _dwClusterSize$[ebp], eax

; 69   : 
; 70   :     // 计算文件占用空间
; 71   :     // 公式:(以字节为单位)
; 72   :     // 簇数 = 向上取整(文件大小 / 簇大小)
; 73   :     // 占用空间 = 簇数 * 簇大小
; 74   :     dwFileSpacesize = (ceil(uFileSize / (dwClusterSize)) * dwClusterSize);

  00134	8b 4d d8	 mov	 ecx, DWORD PTR _dwClusterSize$[ebp]
  00137	33 d2		 xor	 edx, edx
  00139	52		 push	 edx
  0013a	51		 push	 ecx
  0013b	8b 45 e8	 mov	 eax, DWORD PTR _uFileSize$[ebp+4]
  0013e	50		 push	 eax
  0013f	8b 4d e4	 mov	 ecx, DWORD PTR _uFileSize$[ebp]
  00142	51		 push	 ecx
  00143	e8 00 00 00 00	 call	 __aulldiv
  00148	89 45 c8	 mov	 DWORD PTR -56+[ebp], eax
  0014b	89 55 cc	 mov	 DWORD PTR -56+[ebp+4], edx
  0014e	df 6d c8	 fild	 QWORD PTR -56+[ebp]
  00151	83 ec 08	 sub	 esp, 8
  00154	dd 1c 24	 fstp	 QWORD PTR [esp]
  00157	e8 00 00 00 00	 call	 _ceil
  0015c	83 c4 08	 add	 esp, 8
  0015f	8b 55 d8	 mov	 edx, DWORD PTR _dwClusterSize$[ebp]
  00162	89 55 c0	 mov	 DWORD PTR -64+[ebp], edx
  00165	c7 45 c4 00 00
	00 00		 mov	 DWORD PTR -64+[ebp+4], 0
  0016c	df 6d c0	 fild	 QWORD PTR -64+[ebp]
  0016f	de c9		 fmulp	 ST(1), ST(0)
  00171	e8 00 00 00 00	 call	 __ftol
  00176	89 45 f0	 mov	 DWORD PTR _dwFileSpacesize$[ebp], eax
  00179	89 55 f4	 mov	 DWORD PTR _dwFileSpacesize$[ebp+4], edx

; 75   : 
; 76   :     _tprintf_s(_T("FileName : %s\n"), szFileName);

  0017c	8b 45 fc	 mov	 eax, DWORD PTR _szFileName$[ebp]
  0017f	50		 push	 eax
  00180	68 00 00 00 00	 push	 OFFSET FLAT:$SG52961
  00185	e8 00 00 00 00	 call	 __tprintf_s
  0018a	83 c4 08	 add	 esp, 8

; 77   :     _tprintf_s(_T("FileSize : %I64u Byte\n"), uFileSize);

  0018d	8b 4d e8	 mov	 ecx, DWORD PTR _uFileSize$[ebp+4]
  00190	51		 push	 ecx
  00191	8b 55 e4	 mov	 edx, DWORD PTR _uFileSize$[ebp]
  00194	52		 push	 edx
  00195	68 00 00 00 00	 push	 OFFSET FLAT:$SG52962
  0019a	e8 00 00 00 00	 call	 __tprintf_s
  0019f	83 c4 0c	 add	 esp, 12			; 0000000cH

; 78   :     _tprintf_s(_T("FileSpacesSize : %I64u Byte\n"), dwFileSpacesize);

  001a2	8b 45 f4	 mov	 eax, DWORD PTR _dwFileSpacesize$[ebp+4]
  001a5	50		 push	 eax
  001a6	8b 4d f0	 mov	 ecx, DWORD PTR _dwFileSpacesize$[ebp]
  001a9	51		 push	 ecx
  001aa	68 00 00 00 00	 push	 OFFSET FLAT:$SG52963
  001af	e8 00 00 00 00	 call	 __tprintf_s
  001b4	83 c4 0c	 add	 esp, 12			; 0000000cH

; 79   :     return 0;

  001b7	33 c0		 xor	 eax, eax
$L52934:

; 80   : }

  001b9	8b e5		 mov	 esp, ebp
  001bb	5d		 pop	 ebp
  001bc	c3		 ret	 0
_main	ENDP
_TEXT	ENDS
END
