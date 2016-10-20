REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2m_cr.qcorw2 create 2m
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow10m_cr.qcorw2 create 10m -cs 4096
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow20m_cr.qcorw2 create 20m -cs 4K
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow600m_cr.qcorw2 create 600m -cs 4Kb
REM edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow4g_cr.qcorw2 create 4G -cs 4kb

edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2m_cr.qcorw2 fdisk create PrimaryPartition 2m
edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow10m_cr.qcorw2 fdisk create PrimaryPartition 10m -cs 4096
edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow20m_cr.qcorw2 fdisk create PrimaryPartition 20m -cs 4K
edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow600m_cr.qcorw2 fdisk create PrimaryPartition 600m -cs 4Kb
edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk_p\qcow4g_cr.qcorw2 fdisk create PrimaryPartition 4G
