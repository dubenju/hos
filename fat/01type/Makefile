CC = C:/MinGW/bin/gcc.exe
CC1 = C:/MinGW/libexec/gcc/mingw32/4.5.0/cc1.exe -quiet -mtune=i386 -march=i386 -std=c99 
AS  = C:/MinGW/bin/as.exe
default:
	$(CC) -B -std=c99 -v -o 01type.exe 01type.c

asm :
	$(CC1) -o 01type.gas 01type.c
obj :
	$(AS) -o 01type.obj 01type.gas
