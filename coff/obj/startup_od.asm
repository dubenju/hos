
startup.obj:     ファイル形式 pe-i386


セクション .text の逆アセンブル:

00000000 <_HariStartup>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	5d                   	pop    %ebp
   4:	e9 00 00 00 00       	jmp    9 <_HariStartup+0x9>
