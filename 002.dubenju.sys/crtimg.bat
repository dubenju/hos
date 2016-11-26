REM REATE
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_crt.qcow2 create -f qcow2 20480K -cs 4096

REM FDISK
REM copy C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_crt.qcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_fdisk.qcow2
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_fdisk.qcow2 fdisk create PrimaryPartition 20611584 -cs 4K -m C:\Users\DBJ\git\hos\000.mbr\mbr\mbr.bin
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fdisk.qcow2 fdisk create PrimaryPartition 20611584 -cs 4K -m C:\Users\DBJ\git\hos\000.mbr\mbs_dos6.22.bin
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fdisk.qcow2 fdisk create PrimaryPartition 20611584 -cs 4K -m C:\Users\DBJ\git\hos\000.mbr\mbs.bin

REM FORMAT
REM copy C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_fdisk.qcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_fmt.qcow2 > crtimg.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_fmt.qcow2 format -f fat16 drv1 -m C:\Users\DBJ\git\hos\001.vbr\vbs\vbs.bin >> crtimg.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fmt.qcow2 format -f fat16 drv1 -m C:\Users\DBJ\git\hos\001.vbr\dosvbsh_vbr.bin >> crtimg.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fmt.qcow2 format -f fat16 drv1 -m C:\Users\DBJ\git\hos\001.vbr\win98vbs.bin >> crtimg.log

copy C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_fmt.qcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_rt.qcow2 > crtimg_01_cp_rt.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/002.dubenju.sys/dubenju.sys to /drv1/DUBENJU.SYS > crtimg_02.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/a/msdos.sys    to /drv1/MSDOS.SYS   > crtimg_03.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/a/COMMAND.COM  to /drv1/COMMAND.COM > crtimg_04.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/a/DRVSPACE.BIN to /drv1/DRVSPACE.BIN  > crtimg_05.log

C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\002.dubenju.sys\qcow2_20m_rt.qcow2 info > qcow2_20m_rt.qcow2_info.txt
