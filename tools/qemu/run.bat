REM %1 file
REM %2 option
REM %3 prev

copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\%3\%1 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\%2\%1
C:\Users\DBJ\git\hos\tools\qemu\qemu.exe -L C:\Users\DBJ\git\hos\tools\qemu\ -m 32 -localtime -no-kqemu -std-vga -boot a -fda C:\Users\DBJ\git\hos\tools\qemu\qemu_img\win98(FAT12).img -hda C:\Users\DBJ\git\hos\tools\qemu\qemu_img\%2\%1 -soundhw sb16,pcspk
