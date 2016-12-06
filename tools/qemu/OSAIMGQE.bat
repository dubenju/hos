REM .\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\qemu_img\win98(FAT12).img -hda .\qemu_img\raw2m.raw -soundhw sb16,pcspk
REM .\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\qemu_img\win98(FAT12).img -hda .\qemu_img\fdisk_p\qcow2m_cr.qcorw2 -soundhw sb16,pcspk
REM .\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\qemu_img\win98(FAT12).img -hda .\qemu_img\qcow2_4g.qcow2 -soundhw sb16,pcspk
REM .\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\qemu_img\Dosv6.22.IMg -hda .\qemu_img\qcow2_4g.qcow2 -soundhw sb16,pcspk
REM .\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\qemu_img\win98(FAT12).img -hda ..\..\fat\edqcow2\test -soundhw sb16,pcspk
REM .\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\qemu_img\win98(FAT12).img -hda .\qemu_img\copy\qcow2_16127K_.qcow2 -soundhw sb16,pcspk

REM .\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\qemu_img\win98(FAT12).img -hda .\qemu_img\copy\qcow2_16127K_copy.qcow2 -soundhw sb16,pcspk -net nic
.\qemu.exe -L . -m 32 -localtime -no-kqemu -std-vga -boot a -fda .\OSAIMGQE.BIN -hda C:\Users\DBJ\git\hos\tools\qemu\qemu_img\format\qcow2_20m_ds.qcow2 -soundhw sb16,pcspk -net nic
