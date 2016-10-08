TOOL_PATH = ../tools/

MAKE      = $(TOOL_PATH)gnumake.exe -r
DEL       = del

default :
	$(MAKE) boot.bin

boot.bin : 
	nasm -o boot.bin boot.asm

clean :
	$(DEL) boot.bin
