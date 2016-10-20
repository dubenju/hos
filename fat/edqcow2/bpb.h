#ifndef _BPB_H_
#define _BPB_H_

typedef struct _BIOSParameterBlock1216 {
  unsigned char bpb_BytesPerSector[2];    /* Bytes Per Sector    每扇区字节数 */
  unsigned char bpb_SectorsPerCluster[1]; /* Sectors Per Cluster 每簇扇区数 */
  unsigned char bpb_ReservedSectorst[2];  /* Reserved Sectors    保留扇区数 */
  unsigned char bpb_FatCopies[1];         /* Number of FATs      备份数 */
  unsigned char bpb_RootDirEntries[2];    /* Root Entries        根目录项数 */
  unsigned char bpb_NumSectors[2];        /* Small Sectors       磁盘总扇区数 */
  unsigned char bpb_MediaType[1];         /* Media Descriptor    描述介质 */
  unsigned char bpb_SectorsPerFAT[2];     /* Sectors Per FAT     每FAT扇区数 */
  unsigned char bpb_SectorsPerTrack[2];   /* Sectors Per Track   每磁道扇区数 */
  unsigned char bpb_NumberOfHeads[2];     /* Number of Heads     磁头数 */
  unsigned char bpb_HiddenSectors[4];     /* Hidden Sectors      特殊隐含扇区数 */
  unsigned char bpb_SectorsBig[4];        /* Large Sectors       总扇区数 */
} BPB1216, *PBPB12126;

typedef struct _BIOSParameterBlock32 {
  unsigned char bpb_BytesPerSector[2];    /* Bytes Per Sector    每扇区字节数 */
  unsigned char bpb_SectorsPerCluster[1]; /* Sectors Per Cluster 每簇扇区数 */
  unsigned char bpb_ReservedSectorst[2];  /* Reserved Sectors    保留扇区数 */
  unsigned char bpb_FatCopies[1];         /* Number of FATs      备份数 */
  unsigned char bpb_RootDirEntries[2];    /* Root Entries        根目录项数 */
  unsigned char bpb_NumSectors[2];        /* Small Sectors       磁盘总扇区数 */
  unsigned char bpb_MediaType[1];         /* Media Descriptor    描述介质 */
  unsigned char bpb_SectorsPerFAT[2];     /* Sectors Per FAT     每FAT扇区数 */
  unsigned char bpb_SectorsPerTrack[2];   /* Sectors Per Track   每磁道扇区数 */
  unsigned char bpb_NumberOfHeads[2];     /* Number of Heads     磁头数 */
  unsigned char bpb_HiddenSectors[4];     /* Hidden Sectors      特殊隐含扇区数 */
  unsigned char bpb_SectorsBig[4];        /* Large Sectors       总扇区数 */
  unsigned char bpb_SectorsPerFAT32[4];
  unsigned char bpb_Flags[2];
  unsigned char bpb_FSVersion[2];
  unsigned char bpb_RootClusterNo[4];
  unsigned char bpb_FSInfo[2];
  unsigned char bpb_BakBootSec[2];
  unsigned char bpb_Reserved[12];
} BPB32, *PBPB32;


typedef struct _VBRFAT1216 {
  unsigned char bs_jmpBoot[3];
  unsigned char bs_OEMName[8];            // OEM号
  BPB1216 bpb;
  unsigned char bs_DrvNum[1];             // 物理驱动器数
  unsigned char bs_Reaserved1[1];
  unsigned char bs_Bootsig[1];            // 扩展引导签证
  unsigned char bs_VolID[4];              // 卷系列号
  unsigned char bs_VolLab[11];            // 卷标号
  unsigned char bs_FileSysType[8];        // 文件系统号
  unsigned char bs_Code[448];
  unsigned char bs_EndFlag[2];
} VBRFAT1216, *PVBRFAT1216;

typedef struct _VBRFAT32 {
  unsigned char bs_jmpBoot[3];
  unsigned char bs_OEMName[8];            // OEM号
  BPB32 bpb;
  unsigned char bs_DrvNum[1];             // 物理驱动器数
  unsigned char bs_Reaserved1[1];
  unsigned char bs_Bootsig[1];            // 扩展引导签证
  unsigned char bs_VolID[4];              // 卷系列号
  unsigned char bs_VolLab[11];            // 卷标号
  unsigned char bs_FileSysType[8];        // 文件系统号
  unsigned char bs_Code[420];
  unsigned char bs_EndFlag[2];
} VBRFAT32, *PVBRFAT32;

#endif // _BPB_H_
