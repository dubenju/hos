c:\mingw\libexec\gcc\mingw32\4.5.2\cc1.exe ll.c  -mtune=i386 -march=i386 -o ll.s
c:\mingw\libexec\gcc\mingw32\4.5.2\cc1.exe ll_lib.c  -mtune=i386 -march=i386 -o ll_lib.s
c:\mingw\libexec\gcc\mingw32\4.5.2\cc1.exe nask.c  -mtune=i386 -march=i386 -o nask.s

REM C:\prj\hos\999.tools\cc1.exe  nask.c  -march=i386 -o nask.s

c:\mingw\mingw32\bin\as.exe -o ll.o ll.s
c:\mingw\mingw32\bin\as.exe -o ll_lib.o ll_lib.s
c:\mingw\mingw32\bin\as.exe -o nask.o nask.s

REM C:\MinGW\bin\ld.exe -s -Bdynamic --stack 0x2000000 -o nask.exe -LC:/prj/hos/998.wts/nask nask.o  ../libmingw.lib

C:\prj\hos\998.wts\golib00\golib00\golib00w.exe out:nasklib.lib ll.o ll_lib.o nask.o
