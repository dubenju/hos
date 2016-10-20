APP=03stat

CC = C:/MinGW/bin/gcc.exe
CC1 = C:/MinGW/libexec/gcc/mingw32/4.8.1/cc1.exe -quiet -v -iprefix c:/mingw/lib/gcc/mingw32/4.8.1/ ../readfat.h -quiet -mtune=i386 -march=i386 -std=c99 
# AS  = C:/MinGW/bin/as.exe
AS  = c:/mingw/mingw32/bin/as.exe
CLL = c:/mingw/libexec/gcc/mingw32/4.8.1/collect2.exe -Bdynamic  c:/mingw/mingw32/lib/crt2.o  c:/mingw/lib/gcc/mingw32/4.8.1/crtbegin.o -Lc:/mingw/lib/gcc/mingw32/4.8.1 -Lc:/mingw/lib/gcc -Lc:/mingw/mingw32/lib -Lc:/mingw/lib 
LIBS = -lmingw32 -lgcc -lgcc_eh -lmoldname -lmingwex -lmsvcrt -ladvapi32 -lshell32 -luser32 -lkernel32 -lmingw32 -lgcc -lgcc_eh -lmoldname -lmingwex -lmsvcrt c:/mingw/lib/gcc/mingw32/4.8.1/crtend.o
DELE = rm -f 

default :
	$(CC) -B -std=c99 -v -o $(APP).exe $(APP).c
#	$(CC) -B -include ../readfat.h -std=c99 -v -o $(APP).exe $(APP).c
#	$(CC1) -H -include ./readfat.h -std=c99 -v -o readfat.exe readfat.c

asm : clean
	$(CC1) -o $(APP).gas $(APP).c
obj : asm 
	$(AS) -v -o $(APP).obj $(APP).gas
exe : obj 
	$(CLL) $(APP).obj -o $(APP).exe $(LIBS)

clean :
	$(DELE) $(APP).gas $(APP).obj $(APP).exe
