REM REATE
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_crt.qcow2 create -f qcow2 20480K -cs 4096

REM FDISK
copy C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_crt.qcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fdisk.qcow2
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fdisk.qcow2 fdisk create PrimaryPartition 20611584 -cs 4K -m C:\Users\DBJ\git\hos\000.mbr\mbr\mbr.bin
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fdisk.qcow2 fdisk create PrimaryPartition 20611584 -cs 4K -m C:\Users\DBJ\git\hos\000.mbr\mbs_dos6.22.bin
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fdisk.qcow2 fdisk create PrimaryPartition 20611584 -cs 4K -m C:\Users\DBJ\git\hos\000.mbr\mbs.bin

REM FORMAT
copy C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fdisk.qcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fmt.qcow2 > crtimg.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fmt.qcow2 format -f fat16 drv1 -m C:\Users\DBJ\git\hos\001.vbr\vbs\vbs.bin >> crtimg_rt_fmt.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fmt.qcow2 format -f fat16 drv1 -m C:\Users\DBJ\git\hos\001.vbr\dosvbsh_vbr.bin >> crtimg.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fmt.qcow2 format -f fat16 drv1 -m C:\Users\DBJ\git\hos\001.vbr\win98vbs.bin >> crtimg.log

copy C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_fmt.qcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 >> crtimg.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/dubenju.bin to /drv1/DUBENJU.SYS >> crtimg.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/a/IO.SYS       to /drv1/DUBENJU.SYS >> crtimg.log

REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/a/IO.SYS       to /drv1/IO.SYS >> crtimg.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/a/msdos.sys    to /drv1/MSDOS.SYS   >> crtimg.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/a/COMMAND.COM  to /drv1/COMMAND.COM >> crtimg.log
C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/a/DRVSPACE.BIN to /drv1/DRVSPACE.BIN  >> crtimg.log

REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/wa/IO.SYS       to /drv1/IO.SYS >> crtimg.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/wa/msdos.sys    to /drv1/MSDOS.SYS   >> crtimg.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/wa/COMMAND.COM  to /drv1/COMMAND.COM >> crtimg.log
REM C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 copy C:/Users/DBJ/git/hos/001.vbr/vbs/wa/DRVSPACE.BIN to /drv1/DRVSPACE.BIN  >> crtimg.log


C:\Users\DBJ\git\hos\fat\edqcow2\edqcow2 C:\Users\DBJ\git\hos\001.vbr\vbs\qcow2_20m_rt.qcow2 info > qcow2_20m_rt.qcow2_info.txt
