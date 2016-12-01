REM cl /Fatype.asm /Fotype.obj /Fetype.exe /Fmtype.map /IC:\prj\vc6\include type.c libc.lib /link /LIBPATH:"C:/prj/vc6/lib"
link type.obj /MACHINE:X86 libc.lib /LIBPATH:"C:/prj/vc6/lib" /OUT:typel.exe
