REM copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2_504K_create.qcow2    C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_504K_fdisk.qcow2
REM copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2_16127K_create.qcow2  C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16127K_fdisk.qcow2
REM copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2_16128K_create.qcow2  C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16128K_fdisk.qcow2
REM copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2_16631K_create.qcow2  C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16631K_fdisk.qcow2
REM copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2_16632K_create.qcow2  C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16632K_fdisk.qcow2
copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2_524663K_create.qcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524663K_fdisk.qcow2
copy C:\Users\DBJ\git\hos\tools\qemu\qemu_img\create\qcow2_524664K_create.qcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524664K_fdisk.qcow2

REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_504K_fdisk.qcow2    fdisk create PrimaryPartition 483840 -cs 4Kb -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin     > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_504K_fdisk.qcow2_rt.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16127K_fdisk.qcow2  fdisk create PrimaryPartition 15966720 -cs 4Kb -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin   > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16127K_fdisk.qcow2_rt.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16128K_fdisk.qcow2  fdisk create PrimaryPartition 16482816 -cs 4Kb -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin   > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16128K_fdisk.qcow2_rt.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16631K_fdisk.qcow2  fdisk create PrimaryPartition 16482816 -cs 4Kb -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin   > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16631K_fdisk.qcow2_rt.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16632K_fdisk.qcow2  fdisk create PrimaryPartition 16998912 -cs 4Kb -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin   > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16632K_fdisk.qcow2_rt.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524663K_fdisk.qcow2 fdisk create PrimaryPartition 536707584 -cs 4Kb -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin  > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524663K_fdisk.qcow2_rt_b.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524664K_fdisk.qcow2 fdisk create PrimaryPartition 537223680 -cs 4Kb -m C:\Users\DBJ\git\hos\fat\edqcow2\mbr.bin  > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524664K_fdisk.qcow2_rt_b.log

REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_504K_fdisk.qcow2    info > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_504K_fdisk.qcow2_info.txt
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16127K_fdisk.qcow2  info > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16127K_fdisk.qcow2_info.txt
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16128K_fdisk.qcow2  info > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16128K_fdisk.qcow2_info.txt
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16631K_fdisk.qcow2  info > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16631K_fdisk.qcow2_info.txt
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16632K_fdisk.qcow2  info > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_16632K_fdisk.qcow2_info.txt
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524663K_fdisk.qcow2 info > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524663K_fdisk.qcow2_info_b.txt
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524664K_fdisk.qcow2 info > C:\Users\DBJ\git\hos\tools\qemu\qemu_img\fdisk\qcow2_524664K_fdisk.qcow2_info_b.txt
