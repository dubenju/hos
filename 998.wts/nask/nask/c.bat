REM c:\mingw\libexec\gcc\mingw32\4.5.2\cc1.exe gas2nask.c  -mtune=i386 -march=i386 -o gas2nask.s
C:\prj\hos\999.tools\cc1.exe  nask.c  -march=i386 -o nask.s
c:\mingw\mingw32\bin\as.exe -o nask.o nask.s
C:\MinGW\bin\ld.exe -s -Bdynamic --stack 0x2200000 -o nask.exe -LC:/prj/hos/998.wts/nask nask.o  ../libmingw.lib ../nasklib/nasklib.lib ../go_lib/go_lib.lib
