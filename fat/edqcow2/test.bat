REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2m_cr.qcorw2 create 2m
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow10m_cr.qcorw2 create 10m -cs 4096
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow20m_cr.qcorw2 create 20m -cs 4K
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow600m_cr.qcorw2 create 600m -cs 4Kb
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow4g_cr.qcorw2 create 4G -cs 4kb

REM copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2m_cr.qcorw2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow2m_cr.qcorw2
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow2m_cr.qcorw2 fdisk create PrimaryPartition 2032128 -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow2m_cr.txt

REM copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow10m_cr.qcorw2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow10m_cr.qcorw2
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow10m_cr.qcorw2 fdisk create PrimaryPartition 10289664 -cs 4096 -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow10m_cr.txt

copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow20m_cr.qcorw2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow20m_cr.qcorw2
edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow20m_cr.qcorw2 fdisk create PrimaryPartition 20611584 -cs 4K -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow20m_cr.txt

copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow600m_cr.qcorw2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow600m_cr.qcorw2
edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow600m_cr.qcorw2 fdisk create PrimaryPartition 628572672 -cs 4Kb -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow600m_cr.txt

REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow4g_cr.qcorw2 fdisk create PrimaryPartition 4G
