OBJS_BOOTPACK = bootpack.obj naskfunc.obj 

#TOOL_PATH = ../tools/
TOOL_PATH = C:/Users/DBJ/git/hos/tools/
INC_PATH  = ../tools/haribote/

# MAKE      = $(TOOL_PATH)make.exe -d -r 
MAKE      = $(TOOL_PATH)make.exe -r 
NASK      = $(TOOL_PATH)nask.exe 
BIN2OBJ   = $(TOOL_PATH)bin2obj.exe 
OBJ2BIM   = $(TOOL_PATH)obj2bim.exe 
BIM2HRB   = $(TOOL_PATH)bim2hrb.exe
CC1       = $(TOOL_PATH)cc1.exe -I$(INC_PATH) -Os -Wall -quiet
GAS2NASK  = $(TOOL_PATH)gas2nask.exe -a 
MAKEFONT  = $(TOOL_PATH)makefont.exe 
#CPY       = copy
CPY       = $(TOOL_PATH)copy
REMOVE    = del
RULEFILE  = ../haribote.rul

#	$(MAKE) boot.bin
#	$(MAKE) boot16.bin

default :
	$(MAKE) haribote.sys

boot.bin : boot.nas Makefile
	$(NASK) boot.nas boot.bin boot.lst

boot16.bin : boot16.nas Makefile
	$(NASK) boot16.nas boot16.bin boot16.lst

asmhead.bin : asmhead.nas Makefile
	$(NASK) asmhead.nas asmhead.bin asmhead.lst

hankaku.bin : hankaku.txt Makefile
	$(MAKEFONT) hankaku.txt hankaku.bin

hankaku.obj : hankaku.bin Makefile
	$(BIN2OBJ) hankaku.bin hankaku.obj _hankaku

bootpack.bim : $(OBJS_BOOTPACK) Makefile
	$(OBJ2BIM) @$(RULEFILE) out:bootpack.bim stack:3136k map:bootpack.map $(OBJS_BOOTPACK) 

# 3MB+64KB=3136KB

bootpack.hrb : bootpack.bim Makefile
	$(BIM2HRB) bootpack.bim bootpack.hrb 0

haribote.sys : asmhead.bin bootpack.hrb Makefile
	$(CPY) /B asmhead.bin+bootpack.hrb dubenju.sys

%.gas : %.c bootpack.h Makefile
	$(CC1) -o $*.gas $*.c 
	$(CPY) $*.gas $*.gasp

%.nas : %.gas Makefile
	$(GAS2NASK) $*.gas $*.nas
	$(CPY) $*.nas $*.nasp

%.obj : %.nas Makefile
	$(NASK) $*.nas $*.obj $*.lst

clean :
	-$(REMOVE) asmhead.bin
	-$(REMOVE) hankaku.bin
	-$(REMOVE) *.lst
	-$(REMOVE) *.obj
	-$(REMOVE) *.map
	-$(REMOVE) *.bim
	-$(REMOVE) *.hrb
	-$(REMOVE) *.nasp
	-$(REMOVE) *gasp

src_only :
	$(MAKE) clean
	-$(REMOVE) boot.bin
	-$(REMOVE) haribote.sys
