REM .\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\qemu_img\win98(FAT12).img -hda .\qemu_img\raw2m.raw -soundhw sb16,pcspk
REM .\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot c -fda .\qemu_img\win98(FAT12).img -hda .\qemu_img\qcow2m.qcow2 -soundhw sb16,pcspk
.\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\qemu_img\win98(FAT12).img -hda ..\..\fat\edqcow2\test -soundhw sb16,pcspk
