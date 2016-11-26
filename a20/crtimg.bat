REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\000.mbr\mbr\qcow2_20m_crt.qcow2 create -f qcow2 20480K -cs 4096

copy C:\Users\DBJ\git\hos\000.mbr\mbr\qcow2_20m_crt.qcow2 C:\Users\DBJ\git\hos\a20\qcow2_20m_fdisk.qcow2
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\a20\qcow2_20m_fdisk.qcow2 fdisk create PrimaryPartition 20611584 -cs 4K -m C:\Users\DBJ\git\hos\a20\ta20.bin

REM copy C:\Users\DBJ\git\hos\000.mbr\mbr\qcow2_20m_fdisk.qcow2 C:\Users\DBJ\git\hos\000.mbr\mbr\qcow2_20m_fmt.qcow2
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\000.mbr\mbr\qcow2_20m_fmt.qcow2 format -f fat16 drv1 -m C:\Users\DBJ\git\hos\000.mbr\mbr\testvbr.bin
