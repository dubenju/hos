

What's New for the Windows 98 Startup Disk?

The Startup Disk has changed significantly for Windows 98.
The following items are new:

- MULTI-CONFIG START MENU
- REAL-MODE CD-ROM DRIVERS
- EBD.CAB FILE
- RAMDRIVE
- WINDOWS 98 STARTUP PROBLEMS
- USING THE TOOLS AVAILABLE ON THE STARTUP DISK 

Multi-Config Start Menu 
==========================
If you boot your computer using the new Windows 98 Startup Disk, 
a boot menu appears allowing you the option to load drivers for 
the most common CD-ROM drives or perform a normal clean boot.

After you make your selection, the Config.sys file loads the appropriate
CD-ROM driver (if selected) and then loads a 2MB RAMDrive. The RAMDrive is
used to store all the diagnostic tools necessary to troubleshoot the most
common problems.


*Note*
The RAMdrive may cause your CD-Rom to pushed back 1 drive letter. If your
CD-Rom is usually drive D:, it will now be Drive E:.


Real-Mode CD-ROM support
=================================
The Windows 98 Startup Disk includes generic ATAPI IDE & SCSI CD-ROM 
drivers that allow your CD-ROM to function at MS-DOS when the Windows 98 
GUI is not available.

*Note*, not all CD-ROM drives are supported. If your CD-ROM drive does 
not function with these drivers, you must use the drivers that came with 
your CD-ROM drive.


EBD.CAB file
=================================
The Ebd.cab file is a compressed file whose contents are extracted to the
Ramdrive during the startup process. The table below identifies the files
in the Ebd.cab file.

File		Function	
Attrib.exe	Add or remove file attributes	
Chkdsk.exe	A simpler and smaller disk status tool	
Debug.exe	Debugging utility	
Edit.com	Real-mode emergency text editor	
Ext.exe         New, simple file extract utility 
Format.com	Disk format tool	
Mscdex.exe	Microsoft CD-ROM file extension for MS-DOS	
Scandisk.exe	Disk status tool	
Scandisk.ini	Disk status tool configuration file	
Sys.com		Transfers system files and make disk bootable


Creating a RAMDrive
=================================
The RAMDrive is created during the processing of the Config.sys file and is
2MB in size. The Ramdrive is created using system RAM to emulate a physical
Hard Disk. Without creating the RAMdrive, we would not have enough space on
a single 1.44 meg floppy disk to contain all the diagnostic tools as well
as the CD-Rom drivers.

Warning
Since the RAMDrive is created during the processing of the Config.sys file
and uses System RAM, it is only temporary. It will disappear if you restart
your computer normally.


List of all components on the EBD
====================================
The following table describes the function of each file copied to the EBD.

File		Function	
Aspi2dos.sys 	Real-Mode Adaptec CD-ROM driver	
Aspi4dos.sys	Real-Mode Adaptec CD-ROM driver	
Aspi8dos.sys	Real-Mode Adaptec CD-ROM driver	
Aspi8u2.sys     Real-Mode Adaptec CD-ROM driver 
Aspicd.sys	Real-Mode Adaptec CD-ROM driver
Autoexec.bat	Startup batch file	
Btcdrom.sys	Mylex/BusLogic CD-ROM driver	
Btdosm.sys	Mylex/BusLogic CD-ROM driver	
Command.com	Command interpreter	
Config.sys	Loads the device drivers	
Drvspace.bin	Microsoft DriveSpace compression driver	
Ebd.cab		Cab file containing extract utilities	
Ebd.sys		File identifying the ESD	
Extract.exe	File to expand the Ebd.cab file	
Fdisk.exe	Disk partition tool	
Findramd.exe	Utility to find the RAMDrive during startup	
Flashpt.sys	Mylex/BusLogic CD-ROM driver	
Himem.sys	XMS Memory Manager	
Io.sys		System boot file	
Msdos.sys	Boot option information (paths, multiboot, and so on)	
Oakcdrom.sys	Generic device driver for ATAPI CD-ROM drives	
Ramdrive.sys	Creates a Ramdrive during startup	
Setramd.bat	Searches for first available drive to be a Ramdrive 


WINDOWS 98 STARTUP PROBLEMS
============================
This section includes some common troubleshooting steps that can be used
when it's necessary to use the Windows 98 Startup Disk. These steps are
designed to get the user at least into Safe-Mode where you have access
to Windows 98 Help to further troubleshoot any issues.

Starting Your Computer in Safe Mode
-----------------------------------
There are several reasons why Windows 98 may fail 
to start properly. The first step in troubleshooting 
is to try starting your computer in Safe Mode. If 
Safe Mode works, you can then use the extensive Help 
system and troubleshooters located in the Start 
menu/Help option.

>>>To start your computer in Safe Mode:

1. Remove the Startup Disk and restart your computer. 
   After the computer restarts but before Windows begins 
   to load, hold down the CTRL key until the Microsoft 
   Windows 98 Startup Menu appears. (If you are running 
   Windows 95, press the F8 key at the "Starting 
   Windows 95" prompt.)

2. From the Startup menu, select Safe Mode.

If you can start your computer in Safe Mode, use 
Windows 98 Help to resolve your original issue.

Setup Fails and the Computer Will Not Start
-------------------------------------------
There are a few common reasons why Windows 98 
Setup may fail to complete successfully. The following 
section explains what you can do to recover from these 
situations. For more information on other Setup problems, 
see the Setup.txt file in the Win98 folder of your 
Windows 98 CD or Setup Disk #1. 

If you encounter any of these error messages while 
running Setup:

*  Invalid System Disk 
*  Incorrect MS-DOS Version 
*  Missing or Corrupted Command.com 
*  Compression Driver errors

It is likely that your computer's startup drive may 
need updated system files. You can use the SYS command 
to copy the needed files to your computer.

NOTE: If you are currently loading compression software, 
you will need to know your host drive letter. This is 
typically H. If you are not loading any compression 
software, then you will need to SYS your C drive.

>>>To use the SYS command to copy system files to your 
   computer:

1. Restart your computer using the Windows 98 Startup 
   Disk, select option 2 on the Startup menu, and then 
   press ENTER.

2. At the A:\ prompt, type:  SYS X: (where X is your 
   Host or Startup drive).

3. If the procedure is successful, a "System transferred" 
   message appears. If it is not successful, check to be 
   sure you are typing the correct drive letter for your 
   Host Drive.

IMPORTANT: If you have installed software that came with 
your hard drive, be sure to read the documentation that 
describes how to start your computer using a floppy disk.

Antivirus Software
-------------------
If antivirus programs are left running during Setup, 
they may prevent Setup from properly updating the system 
files. If this occurs, disable or uninstall the antivirus 
program, and then run Setup again.

NOTE: Some computers have built-in antivirus software. 
This built-in software should also be disabled before 
running Setup. If the software is left enabled, you 
may receive a warning message informing you that the 
Master Boot Record has changed. If you see such a 
message, you MUST accept these changes or Setup may 
stop responding.

Setup Stops Responding During Hardware Detection
------------------------------------------------

If Setup stops responding while it is detecting the 
hardware in your computer, turn your computer off and 
wait a few seconds, then turn it back on. You may need 
to do this several times, because Setup could stop 
responding during several different detection modules.

NOTE: Use the power switch to turn your computer completely 
off. Do not use the reset button or press CTRL+ALT+DELETE 
to restart your computer.

If Setup still fails to complete successfully, it may be 
necessary to start your computer in Safe Mode so that 
you can view the Help topics associated with hardware 
detection.

Compressed Drives Not Mounted
-----------------------------
There are several reasons why compressed drives may 
not be accessible. If your Windows directory is on a 
compressed drive that is not mounted, you will not be 
able to start Windows. If you suspect problems with your 
compressed drives, try using Scandisk to fix them.

From the A:\ prompt, type:

	Scandisk /Mount X:

where X is the drive letter of the compressed drive. 
ScanDisk will then attempt to repair any errors and 
mount the drive.

If there is not enough memory to check your compressed 
drives, see "Installing Windows from MS-DOS," in the 
Setup.txt file on Setup Disk 1 or the Windows 98 CD.


USING THE TOOLS AVAILABLE ON THE STARTUP DISK 
==============================================
This section decribes how to use some of the utilities 
included with the Windows 98 Startup Disk. To run each 
program you should do the following:

1. Put the Windows 98 Startup Disk in the floppy disk 
   drive, and then restart your computer.

2. At the Startup menu, select option 1 or 2 
   (depending upon whether you need CD-ROM access), 
   and then press ENTER.

3. At the MS-DOS command prompt (A:\), type the name 
   of the utility you wish to run, and then press ENTER.


SCANDISK.EXE and CHKDSK.EXE
----------------------------

These two programs are useful for checking your hard 
disk for errors. If you suspect there may be file 
corruption or other problems with your hard disk(s), 
run ScanDisk to check for and repair errors. 

To check all your hard disks for errors, type:

	Scandisk /all 

To perform a full surface scan of your hard disk(s) for 
maximum protection against data loss, type:

	Scandisk /all /Surface

NOTES:
You may receive errors about Long File Names. The MS-DOS 
version of ScanDisk can only detect problems with long 
file names, it cannot fix them. To correct these types of 
errors, you must run ScanDisk from within Windows 98. 

If you have any compressed drives, you may receive an 
error message stating that there is not enough memory 
to check your compressed drives. To solve this problem, 
try starting your computer with the Windows 98 Startup 
Disk, as described in Step 1, earlier in this section. 
Select option 2. This may allow ScanDisk enough memory to 
check your compressed drives.

If ScanDisk is unable to check your drives, try using 
CHKDSK.EXE instead. CHKDSK will check for cross-linked 
files and lost allocation units. 


SYS.COM
=======
The SYS command is used to copy system files from one 
disk to another. Your computer needs these system files 
to start. 

>>>To SYS your C drive, type:  

   SYS C: 

   and then press ENTER. After a few seconds, a 
   "System Transferred" message appears.

The following files are copied to your hard disk during 
the SYS procedure:

*  IO.SYS
*  MSDOS.SYS
*  COMMAND.COM

If the SYS C: command does not work and you have a 
compressed drive, you may need to type the drive letter 
of your host drive. With the DblSpace or DrvSpace programs, 
the host drive is typically designated drive H. If you are 
not sure of the drive letter, run ScanDisk and see if it 
prompts you about your compressed drive.


FDISK.EXE and FORMAT.EXE
------------------------

FDISK and FORMAT are utilities necessary for installing 
a new hard disk in your computer or for starting over 
fresh with a clean disk. FDISK is used first to create 
a partition and then FORMAT is used to make the partition 
available for use.

WARNING: Using FDISK incorrectly can destroy all data 
on your hard disk. If you are unsure of how to use FDISK, 
consult your computer documentation.

You can use the Windows 98 version of FDISK to create 
FAT32 partitions on drives over 512 megabytes in size. 
FAT32 reduces the cluster size for large drives and allows 
you to create single partitions on drives over 2 GB.

To view your current drive status, type FDISK /STATUS 
at the MS-DOS command prompt.

After you have partitioned a drive using FDISK, you will 
need to use the FORMAT command. To format a newly 
partitioned drive, type:

	FORMAT X:

Where X represents the letter of the drive that you 
want to format. 

If you want to format drive C, you need to make this 
disk a system disk so that your computer can start. To 
do this, type /s at the end of the FORMAT command. For 
example: 

	FORMAT C: /s

System Startup files will be automatically copied after 
your drive is formatted.


CD-ROM Drivers
--------------
The Windows 98 Startup Disk includes a set of generic 
CD-ROM drivers. These drivers work with most IDE ATAPI 
and SCSI CD-ROM models.

If your particular CD-ROM drive does not work with 
these drivers, you will need to use the drivers that 
came with your CD-ROM drive.

Following are some known issues about the CD-ROM drivers:

1. CD-ROM drives connected to sound cards may not work 
   properly.

2. Early proprietary CD-ROM drives (for example, Mitsumi, 
   Panasonic, Sony) may not work with these drivers. Some 
   older IDE controllers may fail as well.

3. The SCSI drivers on the Startup Disk support most 
   Adaptec, Buslogic, and Mylex adapters. Some other 
   SCSI CD-ROM drives may not work with the drivers on 
   the Startup Disk.

4. If your SCSI controller is configured for a non-default 
   I/O range, the drivers may not detect your SCSI card. 
   Consult your SCSI driver documentation for the default 
   I/O ranges for your card. 

5. Drivers are not included for any PC Card (PCMCIA) 
   CD-ROM drives.


EXT.EXE
-------
The EXT command is used in conjunction with the Extract.exe 
utility to make it easier to extract Windows 98 files to 
your hard disk. You can use this to replace missing or 
damaged files.

This utility is extremely useful if you are receiving errors 
during startup about missing files, or execution errors such 
as General Protection Faults or invalid page faults. 

>>>To use Ext.exe to extract a file, perform the following 
   steps:

1. Use the Startup Disk to start your computer. Select 
   option 1, and then press ENTER.

2. Make sure the Windows 98 CD is inserted in the drive.

3. Type EXT at the MS-DOS command prompt, and then 
   press ENTER.

4. Follow the prompts to indicate the location of the 
   Windows 98 Setup files, the files you wish to extract, 
   and the location in which you want to place the extracted 
   files.

NOTES:
If your CD-ROM drive letter is E, then type the location 
to the Setup files as E:\WIN98. 

If you wish to extract more than one file at a time, you 
can use wild card characters.








