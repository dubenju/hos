C:\Users\DBJ\git\hos\tools\nask asmhead.nas asmhead.bin asmhead.lst

nasm  -f coff  -o asmfunc.obj asmfunc.asm
C:\Users\DBJ\git\hos\tools\nask naskfunc.nas naskfunc.obj naskfunc.lst


REM C:\Users\DBJ\git\hos\tools\cc1.exe -Os -Wall -quiet -o dubenju.gas dubenju.c
REM C:\Users\DBJ\git\hos\tools\gas2nask.exe -a dubenju.gas dubenju.nas
REM C:\Users\DBJ\git\hos\tools\nask.exe dubenju.nas dubenju.obj dubenju.lst
REM 
REM C:\Users\DBJ\git\hos\tools\obj2bim.exe @../haribote.rul out:dubenju.bim stack:3136k map:dubenju.map dubenju.obj naskfunc.obj
REM C:\Users\DBJ\git\hos\tools\bim2hrb.exe dubenju.bim dubenju.hrb 0
REM 
REM copy asmhead.bin /b + dubenju.hrb /b dubenju.sys /b

C:\Users\DBJ\git\hos\tools\cc1.exe -I C:\Users\DBJ\git\hos\tools\haribote -Os -Wall -quiet -o bootpack.gas bootpack.c
C:\Users\DBJ\git\hos\tools\gas2nask.exe -a bootpack.gas bootpack.nas
C:\Users\DBJ\git\hos\tools\nask.exe bootpack.nas bootpack.obj bootpack.lst

C:\Users\DBJ\git\hos\tools\obj2bim.exe @../haribote.rul out:bootpack.bim stack:3136k map:bootpack.map bootpack.obj naskfunc.obj
C:\Users\DBJ\git\hos\tools\bim2hrb.exe bootpack.bim bootpack.hrb 0

copy asmhead.bin /B + bootpack.hrb /B dubenju.sys /B
