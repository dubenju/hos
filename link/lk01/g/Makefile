CC = C:/MinGW/bin/gcc.exe
CC1 = C:/MinGW/libexec/gcc/mingw32/5.3.0/cc1.exe -quiet -mtune=i386 -march=i386 -std=c99 
AS  = C:/MinGW/bin/as.exe
default:
	$(CC) -B -std=c99 -v -o lk01.exe lk01.c

asm:
	$(CC1) -o lk01.gas lk01.c
obj:
	$(AS) -o lk01.obj lk01.gas
