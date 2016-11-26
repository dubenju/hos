TARGET     = makefont
MODE       = exe
OBJS       = $(TARGET).obj
STACKSIZE  = 0x1000000 # 16MB (default)

#INCPATH    = ../../905.clib/include/
INCPATH    = ../../999.tools/win32/
CC1OPT     = -Dmain=main0
include ../../998.wts/com_mak.txt

# tolset08‘Î‰žMakefile

gccv :
	$(GCC) -save-temps -v -mtune=i386 -march=i386 -o $(TARGET).$(MODE) $(TARGET).c

gcst :
	$(GCC_CC1) -m32 -masm=intel -mtune=i386 -march=i386 -o $(TARGET).asm $(TARGET).c
	$(GCC_AS) -o $(TARGET).o $(TARGET).asm
	$(GCC_LD) -Bdynamic -o $(TARGET).$(MODE) \
	c:/mingw/lib/crt2.o\
	-L c:/mingw/lib \
	$(TARGET).o \
	-lmingw32 -lmsvcrt -luser32 -lkernel32

nasv :
	$(GCC_CC1) -m32 -masm=att -mtune=i386 -march=i386 -o $(TARGET).gas 
	$(GAS2NASK) $(TARGET).gas $(TARGET).nas
	$(NASM) -o $(TARGET).$(MODE) -f win32 $(TARGET).nas

osask :
	$(CC1) -o $(TARGET).gak $(TARGET).c
	$(GAS2NASK) $(TARGET).gak $(TARGET).nak
	$(NASK) $(TARGET).nak $(TARGET).obj
	$(LINK) -o $(TARGET).exe -Map $(TARGET).map $(TARGET).obj $(LIBS)