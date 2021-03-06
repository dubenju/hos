/*
 * 
 */

#define _FILE_OFFSET_BITS 64
#pragma pack (1)
// #include <sys/stat.h>


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
// #include <linux/kernel.h>
#include <sys/types.h>  /* Linux requires this for off_t */
#include <unistd.h>

#include "qcow2.h"
#include "partent.h"
#include "bpb.h"

#define cpu_to_be16(x) \
    ( ( x & 0x00FF ) << 8 ) | \
    ( ( x & 0xFF00 ) >> 8 ) \

#define be16_to_cpu(x) \
    ( ( x & 0x00FF ) << 8 ) | \
    ( ( x & 0xFF00 ) >> 8 ) \

#define cpu_to_be32(x) \
    ( ( x & 0x000000FF ) << 24 ) | \
    ( ( x & 0x0000FF00 ) <<  8 ) | \
    ( ( x & 0x00FF0000 ) >>  8 ) | \
    ( ( x & 0xFF000000 ) >> 24 )

#define be32_to_cpu(x) \
    ( ( x & 0x000000FF ) << 24 ) | \
    ( ( x & 0x0000FF00 ) <<  8 ) | \
    ( ( x & 0x00FF0000 ) >>  8 ) | \
    ( ( x & 0xFF000000 ) >> 24 )

#define cpu_to_be64(x) \
    ( ( x & 0x00000000000000FF) << 56) | \
    ( ( x & 0x000000000000FF00) << 40) | \
    ( ( x & 0x0000000000FF0000) << 24) | \
    ( ( x & 0x00000000FF000000) <<  8) | \
    ( ( x & 0x000000FF00000000) >>  8) | \
    ( ( x & 0x0000FF0000000000) >> 24) | \
    ( ( x & 0x00FF000000000000) >> 40) | \
    ( ( x & 0xFF00000000000000) >> 56)


#define be64_to_cpu(x) \
    ( ( x & 0x00000000000000FF) << 56) | \
    ( ( x & 0x000000000000FF00) << 40) | \
    ( ( x & 0x0000000000FF0000) << 24) | \
    ( ( x & 0x00000000FF000000) <<  8) | \
    ( ( x & 0x000000FF00000000) >>  8) | \
    ( ( x & 0x0000FF0000000000) >> 24) | \
    ( ( x & 0x00FF000000000000) >> 40) | \
    ( ( x & 0xFF00000000000000) >> 56)

#define O_RDONLY	0x0000
#define O_WRONLY	0x0001
#define O_RDWR		0x0002
#define O_ACCMODE	0x0003

#define O_BINARY	0x0004	/* must fit in char, reserved by dos */
#define O_TEXT		0x0008	/* must fit in char, reserved by dos */
#define O_NOINHERIT	0x0080	/* DOS-specific */

#define O_CREAT		0x0100	/* second byte, away from DOS bits */
#define O_EXCL		0x0200
#define O_NOCTTY	0x0400
#define O_TRUNC		0x0800
#define O_APPEND	0x1000
#define O_NONBLOCK	0x2000

// typedef off64_t off_t;
#ifdef __STRICT_ANSI__
const char *  ansi_status="__STRICT_ANSI__ defined";
#else
const char *  ansi_status="__STRICT_ANSI__ undefined";
#endif

char * make_fat(uint32_t * in, size_t in_size, size_t size, int file_system_id, char * buf);
void debug_print_table_16(const uint16_t * table, const uint32_t size);
void debug_print_table_64(const uint64_t * table, const uint32_t size);
void print_partition_entry(const PartitionEntry * pPE);
uint64_t *  print_l1_table_64(const uint64_t * table, const uint32_t size, FILE * pFile, uint32_t cluster_size);
PartitionEntryItem * print_partition_table_64(const uint64_t * table1, const uint32_t size1, const uint64_t * table2, const uint32_t size2, FILE * pFile, size_t cluster_size);
void print_list(PartitionEntryItem * pt);
uint32_t get_l1_index(uint32_t in, uint32_t cluster_size, uint32_t sector_size);
uint32_t get_l2_index(uint32_t in);
void print_ary(unsigned char * buf, size_t size);
int print_fdt(char * buf, size_t size);

int show_usage(void) {
    /* 变量定义 */

    /* 变量初始化 */

    /* 处理开始 */
    printf("QCOW2 File Editor version 0.0.1 comiled on %s.\n", __DATE__);
    printf("\n");
    printf("usage:\n");
    printf("edqcow2 <qcow2 img file> create [size] -cs cluster_size\n");
    printf("edqcow2 <qcow2 img file> fdisk <num> [size1, size2]\n"); /* */
    printf("edqcow2 <qcow2 img file> fdisk create PrimaryPartition size  -cs cluster_size -m <mbs file>\n");
    printf("edqcow2 <qcow2 img file> fdisk create PrimaryPartition size  -cs cluster_size -m <mbs file>\n");
    printf("edqcow2 <qcow2 img file> fdisk create PrimaryPartition size  -cs cluster_size -m <mbs file>\n");
    printf("edqcow2 <qcow2 img file> format -f <filesystem fat etc.> drvn  -m <vbs file>\n");
    printf("edqcow2 <qcow2 img file> info\n");
    printf("edqcow2 <qcow2 img file> init fat12 1474560.\n"); /* */
    printf("edqcow2 <qcow2 img file> write file <file> to disk H-C-S\n"); /* */
    printf("edqcow2 <qcow2 img file> write file <file> to dir <file>\n"); /* */
    printf("edqcow2 <qcow2 img file> write copy <file> to <file>\n");

    /* 处理结束 */
    return -1;
}
const char * get_system_name(const char id) {
    if (id == 0x00) { return "Empty"; }
    if (id == 0x01) { return "DOS FAT12"; }
    if (id == 0x02) { return "XENIX root"; }
    if (id == 0x03) { return "XENIX /usr"; }
    if (id == 0x04) { return "DOS 3.0+ FAT16"; }
    if (id == 0x05) { return "DOS 3.3+ Extended Partition"; }
    if (id == 0x06) { return "DOS 3.31+ FAT16"; }
    if (id == 0x07) { return "OS/2 IFS NTFS Advanced Unix QNX2.x pre-1988"; }
    if (id == 0x08) { return "OS/2 (v1.0-1.3 only) AIX boot partition SplitDrive Commodore DOSDELL partition spanning multiple drives QNX 1.x and 2.x ('qny')"; }
    if (id == 0x09) { return "AIX data partition Coherent filesystem QNX 1.x and 2.x ('qnz')"; }
    if (id == 0x0A) { return "OS/2 Boot Manager Coherent swap partition OPUS"; }
    if (id == 0x0B) { return "Win95 FAT32"; }
    if (id == 0x0C) { return "Win95 FAT32 LBA"; }
    if (id == 0x0D) { return "SILICON SAFE"; }
    if (id == 0x0E) { return "WIN95 FAT16 LBA"; }
    if (id == 0x0F) { return "WIN95 Extended partition, LBA-mapped"; }

    if (id == 0x10) { return "OPUS"; }
    if (id == 0x11) { return "Hidden DOS FAT12 Leading Edge DOS 3.x logically sectored FAT"; }
    if (id == 0x12) { return "Configuration/diagnostics partition"; }
    if (id == 0x13) { return "Empty"; }
    if (id == 0x14) { return "14 Hidden DOS 16-bit FAT <32M 14 AST DOS with logically sectored FAT"; }
    if (id == 0x15) { return "Empty"; }
    if (id == 0x16) { return "16 Hidden DOS 16-bit FAT >=32M"; }
    if (id == 0x17) { return "17 Hidden IFS"; }
    if (id == 0x18) { return "18 AST SmartSleep Partition"; }
    if (id == 0x19) { return "Unused"; }
    if (id == 0x1A) { return "Empty"; }
    if (id == 0x1B) { return "Hidden WIN95 OSR2 FAT32"; }
    if (id == 0x1C) { return "Hidden WIN95 OSR2 FAT32, LBA-mapped"; }
    if (id == 0x1D) { return "Empty"; }
    if (id == 0x1E) { return "Hidden WIN95 16-bit FAT, LBA-mapped"; }
    if (id == 0x1F) { return "Empty"; }
    return "";
}


float get_partition_size(const PartitionEntry * pPE) {
    /* 变量定义 */
    float returnCode;

    /* 变量初始化 */
    returnCode = 0;

    /* 处理开始 */
    printf(">>----- get_partition_size begin -----\n");
    /* n * 512B / (1024 * 1024) */
    returnCode = (pPE->start_sector_no + pPE->sector_total - 1) / 2048.0;

    goto end_get_partition_size;
err_get_partition_size:
end_get_partition_size:
    /* 处理结束 */
    printf("----- get_partition_size end -----<<\n");
    return returnCode;
}


int get_sector_per_cluster(float partition_size, int file_system_index) {
    /* 变量定义 */
    int returnCode;

    /* 变量初始化 */
    returnCode = 0;

    /* 处理开始 */
    printf(">>----- get_sector_per_cluster begin -----\n");

    if (file_system_index == 12) {
        if (partition_size < 0.461) {
            returnCode = 1;
        } else if (partition_size < 16.0) {
            returnCode = 8;
        } else if (partition_size < 32.0) {
            returnCode = 16;
        } else if (partition_size < 63.8) {
            returnCode = 32;
        } else if (partition_size < 127.5) {
            returnCode = 64;
        } else if (partition_size < 255.0) {
            returnCode = 128;
        }
    }
    if (file_system_index == 16) {
        if (partition_size < 16.0) {
            returnCode = -1;
        } else if (partition_size < 128.0) {
            returnCode = 4;
        } else if (partition_size < 260.0) {
            returnCode = 8;
        } else if (partition_size < 512.0) {
            returnCode = 16;
        } else if (partition_size < 1023.8) {
            returnCode = 32;
        } else if (partition_size < 2047.6) {
            returnCode = 64;
        } else if (partition_size < 4095.0) {
            returnCode = 128;
        }
    }
    if (file_system_index == 32) {
        if (partition_size < 512.0) {
            returnCode = -1;
        } else if (partition_size < 16.0) {
            returnCode = 8;
        } else if (partition_size < 32.0) {
            returnCode = 16;
        } else if (partition_size < 63.8) {
            returnCode = 32;
        } else if (partition_size < 127.5) {
            returnCode = 64;
        } else if (partition_size < 255.0) {
            returnCode = 128;
        }
    }
    goto end_get_sector_per_cluster;
err_get_sector_per_cluster:
end_get_sector_per_cluster:
    /* 处理结束 */
    printf("----- get_sector_per_cluster end -----<<\n");
    return returnCode;
}


/* 扇区索引：从0开始，相当于LBA */
uint32_t get_l1_index(uint32_t in, uint32_t cluster_size, uint32_t sector_size) {
    printf(">>----- get_l1_index %d %d %d-----.\n", in, cluster_size, sector_size);
    /* 变量定义 */
    uint32_t sector_cnt = cluster_size / sector_size;
    uint32_t l1_cnt = cluster_size / sizeof(uint64_t);
    /* 变量初始化 */
    /* 处理开始 */
    uint32_t a = in / sector_cnt;
    /* 处理结束 */
    printf("----- get_l1_index %d %d %d-----<<.\n", in, cluster_size, sector_size);
    return a / l1_cnt;
}

/* 扇区索引：从0开始，相当于LBA */
uint32_t get_l2_index(uint32_t in) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    uint32_t a = in / 8;
    uint32_t b = a / 512;
    uint32_t c = a - b * 512;
    /* 处理结束 */
    return c;
}

/* 扇区索引：从0开始，相当于LBA */
uint32_t get_cluster_index(uint32_t in) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    uint32_t a = in / 8;
    return (in - (a * 8)) * 512;
    /* 处理结束 */
}


QCowHeader * read_header(FILE * pFile) {
    /* 变量定义 */
    QCowHeader * result;
    size_t       readedcnt;

    /* 变量初始化 */
    result = NULL;

    /* 处理开始 */
    result = (QCowHeader *) malloc(sizeof(QCowHeader));
    if (result == NULL) { printf("QCowHeader alloc error.\n"); goto err_read_header; }

    memset(result, 0, sizeof(QCowHeader));

    printf("sizeof(header)=%d\n", sizeof(QCowHeader));
    readedcnt = fread(result, 1, sizeof(QCowHeader), pFile);
    printf("readed count=%d\n", readedcnt);
    if (readedcnt != sizeof(QCowHeader)) {
        fprintf(stderr, "qcow_handle_extension: ERROR: pread fail from offset 0.\n");
        goto err_read_header;
    }

    result->magic                   = be32_to_cpu(result->magic);
    result->version                 = be32_to_cpu(result->version);
    result->backing_file_offset     = be64_to_cpu(result->backing_file_offset);
    result->backing_file_size       = be32_to_cpu(result->backing_file_size);
    result->cluster_bits            = be32_to_cpu(result->cluster_bits);
    result->size                    = be64_to_cpu(result->size);
    result->crypt_method            = be32_to_cpu(result->crypt_method);
    result->l1_size                 = be32_to_cpu(result->l1_size);
    result->l1_table_offset         = be64_to_cpu(result->l1_table_offset);
    result->refcount_table_offset   = be64_to_cpu(result->refcount_table_offset);
    result->refcount_table_clusters = be32_to_cpu(result->refcount_table_clusters);
    result->nb_snapshots            = be32_to_cpu(result->nb_snapshots);
    result->snapshots_offset        = be64_to_cpu(result->snapshots_offset);
    printf("\n");

    goto end_read_header;
err_read_header:
    if (result != NULL) { free(result); result = NULL; }
end_read_header:
    /* 处理结束 */
    return result;
}

/*
 * 读取镜像文件的信息到结构体中.
 */
int read_qcow2(FILE * pFile, QCOW2_FILE * qcow2File) {
    /* 变量定义 */
    int      returnCode;
    uint64_t l1_table_offset;
    uint64_t refcount_table_offset;
    uint32_t l1_size;
    size_t   readedcnt;
    uint64_t idx;
    uint64_t l1_item;
    int refcount_table_cnt;
    uint64_t ref_table_item;
    uint64_t ref_count_offset;
    uint32_t refcount_cnt;
    uint16_t ref_item;

    /* 变量初始化 */
    returnCode = 0;

    /* 处理开始 */
    printf(">>----- read_qcow2 begin -----\n");
    qcow2File->pHeader = read_header(pFile);
    qcow2File->clustor_size  = 1 << qcow2File->pHeader->cluster_bits;

    /* L1 */
    printf(">>----- Level 1 Table -----\n");
    l1_table_offset = qcow2File->pHeader->l1_table_offset;
    refcount_table_offset = qcow2File->pHeader->refcount_table_offset;
    l1_size = qcow2File->pHeader->l1_size;
    qcow2File->l1_size = l1_size;
    printf("表1在镜像文件中的位置[(%lld, 0X%04X)-", l1_table_offset, l1_table_offset);
    printf("(%lld, 0X%04X))\n", refcount_table_offset, refcount_table_offset);

    qcow2File->pL1Table = (uint64_t *) malloc(sizeof(uint64_t) * (l1_size + 1));
    if (qcow2File->pL1Table == NULL) {
        fprintf(stderr, "l1 table alloc error.\n");
        goto err_read_qcow2;
    }
    memset(qcow2File->pL1Table, 0, sizeof(uint64_t) * (l1_size + 1));
    printf("l1_table_offset=%lld,0X%X.\n", l1_table_offset, l1_table_offset);
    printf("l1_table_size=%ld,0X%X.\n", l1_size, l1_size);
    if (fseek(pFile, l1_table_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", l1_table_offset);
        goto err_read_qcow2;
    }
    /* 表1在镜像文件中是连续存储1个或多个簇的，所以可以1次性读取 */
    readedcnt = fread(qcow2File->pL1Table, sizeof(uint64_t), l1_size, pFile);
    if (readedcnt != l1_size) {
        fprintf(stderr, "read l1 table error(%d!=%d).\n", l1_size);
        goto err_read_qcow2;
    }
    for (idx = 0; idx < l1_size; idx ++) {
        l1_item = *(qcow2File->pL1Table + idx);
        l1_item = be64_to_cpu(l1_item);
        l1_item = l1_item & 0x3FFFFFFFFFFFFFFF;
        if(idx == 0) { printf("l1[%lld]=%lld. 0X%X.\n", idx, l1_item, l1_item); }
        memcpy(qcow2File->pL1Table + idx, &l1_item, sizeof(l1_item));
    }
    memcpy(&l1_item, qcow2File->pL1Table, sizeof(l1_item));
    debug_print_table_64(qcow2File->pL1Table, l1_size);
    printf("----- Level 1 Table -----<<\n");
    printf("\n");

    /* refcount table */
    printf(">>----- Refcount Table -----\n");
    refcount_table_cnt = qcow2File->pHeader->cluster_bits >> 3;
    printf("refcount_table_cnt=%ld.\n", refcount_table_cnt);
    qcow2File->refcount_table_cnt = refcount_table_cnt;
    qcow2File->pRefcountTable = (uint64_t *) malloc(sizeof(uint64_t) * (refcount_table_cnt + 1));
    if (qcow2File->pRefcountTable == NULL) {
        fprintf(stderr, "Refcount table alloc error.\n");
        goto err_read_qcow2;
    }
    memset(qcow2File->pRefcountTable, 0, sizeof(uint64_t) * (refcount_table_cnt + 1));
    if (fseek(pFile, refcount_table_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", refcount_table_offset);
        goto err_read_qcow2;
    }
    printf("refcount table offset=%lld, 0X%X.\n", refcount_table_offset, refcount_table_offset);
    /* 引用计数表在镜像文件中也应该是连续存储1个或多个簇的，所以也可以1次性读取，至少在4GB时是这样的 */
    readedcnt = fread(qcow2File->pRefcountTable, sizeof(uint64_t), refcount_table_cnt, pFile);
    if (readedcnt != refcount_table_cnt) {
        fprintf(stderr, "read refcount table error(%d != %d).\n", readedcnt, refcount_table_cnt);
        goto err_read_qcow2;
    }
    for (idx = 0; idx < refcount_table_cnt; idx ++) {
        ref_table_item = *(qcow2File->pRefcountTable + idx);
        ref_count_offset = be64_to_cpu(ref_table_item);
        printf("refcount[%d]=0X%X.\n", idx, ref_count_offset);
        memcpy(qcow2File->pRefcountTable + idx, &ref_count_offset, sizeof(ref_count_offset));
    }
    memcpy(&ref_count_offset, qcow2File->pRefcountTable, sizeof(ref_count_offset));
    printf("引用计数表在镜像文件中的位置[(%lld, 0X%04X)-", refcount_table_offset, refcount_table_offset);
    printf("(%lld, 0X%04X))\n", ref_count_offset, ref_count_offset);
    debug_print_table_64(qcow2File->pRefcountTable, refcount_table_cnt);
    printf("----- Refcount Table -----<<\n");
    printf("\n");

    /* refcount */
    printf(">>----- Refcount Block -----\n");
    printf("!!!引用计数块在镜像文件中似乎不是连续存储的，那么1个引用计数块的大小应该是1个簇。\n");

    printf("引用计数块在镜像文件中的位置[(%lld, 0X%04X)-", ref_count_offset, ref_count_offset);
    printf("(%lld, 0X%04X))\n", (ref_count_offset + qcow2File->clustor_size), (ref_count_offset + qcow2File->clustor_size));
    refcount_cnt = qcow2File->clustor_size / sizeof(uint16_t);
    printf("refcount_cnt=%ld.\n", refcount_cnt);
    qcow2File->refcount_cnt = refcount_cnt;
    qcow2File->pRefcountBlock = (uint16_t *) malloc(sizeof(uint16_t) * (refcount_cnt + 1));
    if (qcow2File->pRefcountBlock == NULL) {
        fprintf(stderr, "Refcount block alloc error.\n");
        goto err_read_qcow2;
    }
    memset(qcow2File->pRefcountBlock, 0, sizeof(uint16_t) * (refcount_cnt + 1));

    if (fseek(pFile, ref_count_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", ref_count_offset); 
        goto err_read_qcow2;
    }
    printf("refcount block offset=%lld, 0X%X, count=%ld.\n", ref_count_offset, ref_count_offset, refcount_cnt);
    readedcnt = fread(qcow2File->pRefcountBlock, sizeof(short), refcount_cnt, pFile);
    if (readedcnt != refcount_cnt) {
        fprintf(stderr, "read refcount error(%d != %d).\n", readedcnt, refcount_cnt);
        goto err_read_qcow2;
    }
    for (idx = 0; idx < refcount_cnt; idx ++) {
        ref_item = *(qcow2File->pRefcountBlock + idx);
        ref_item = be16_to_cpu(ref_item);
        /* printf("refcount[%lld]=%X.%X,\n", idx, be16_to_cpu(ref_item), ref_item); */
        memcpy(qcow2File->pRefcountBlock + idx, &ref_item, sizeof(ref_item));
        /* if (idx > 10) { break; } */
    }
    debug_print_table_16(qcow2File->pRefcountBlock, refcount_cnt);
    printf("----- Refcount Block -----<<\n");
    printf("\n");

    if (l1_item != 0) {
        /* L2 */
        printf(">>----- Level 2 Table -----\n");
        printf("L2 Table offset=%lld, 0X%X.\n", l1_item, l1_item);
        printf("\n");
        qcow2File->pL2Table = print_l1_table_64(qcow2File->pL1Table, l1_size, pFile, qcow2File->clustor_size);
        qcow2File->l2_size = l1_size * qcow2File->clustor_size / sizeof(uint64_t);
        printf("l2 table's size:%d.\n", qcow2File->l2_size);
        debug_print_table_64(qcow2File->pL2Table, qcow2File->l2_size);
        printf("----- Level 2 Table -----<<\n");
        printf("\n");
    }




    goto end_read_qcow2;
err_read_qcow2:
end_read_qcow2:
    /* 处理结束 */
    printf("----- read_qcow2 begin -----<<\n");
    return returnCode;
}


void print_header(QCowHeader * result) {
    printf("QCOW2_MAGIC                  (4) = 0X%X,QCOW magic string.\n", result->magic);
    printf("QCOW2_version                (4) = 0X%X,Version number (valid values are 2 and 3).\n", result->version);
    printf("QCOW2_backing_file_offset    (8) = 0X%X,Offset into the image file at which the backing file name is stored (NB: The string is not null terminated). 0 if the image doesn't have a backing file.\n", result->backing_file_offset);
    printf("QCOW2_backing_file_size      (4) = 0X%X,Length of the backing file name in bytes. Must not be longer than 1023 bytes. Undefined if the image doesn't have a backing file.\n", result->backing_file_size);
    printf("QCOW2_cluster_bits           (4) = 0X%X,Number of bits that are used for addressing an offset within a cluster (1 << cluster_bits is the cluster size). Must not be less than 9 (i.e. 512 byte clusters).\n", result->cluster_bits);
    printf("QCOW2_size                   (8) = %lld,", result->size);
    printf("0X%010X,Virtual disk size in bytes.\n", result->size);
    printf("                                        十六进制的值有不正确的可能。\n");
    printf("QCOW2_crypt_method           (4) = 0X%X,0 for no encryption;1 for AES encryption.\n", result->crypt_method);
    printf("QCOW2_l1_size                (4) = 0X%X %ld,Number of entries in the active L1 table(MAX).\n", result->l1_size, result->l1_size);
    printf("*QCOW2_l1_table_offset       (8) = 0X%X,Offset into the image file at which the active L1 table starts. Must be aligned to a cluster boundary.\n", result->l1_table_offset);
    printf("*QCOW2_refcount_table_offset (8) = 0X%X,Offset into the image file at which the refcount table starts. Must be aligned to a cluster boundary.\n", result->refcount_table_offset);
    printf("QCOW2_refcount_table_clusters(4) = 0X%X,Number of clusters that the refcount table occupies.\n", result->refcount_table_clusters);
    printf("QCOW2_nb_snapshots           (4) = 0X%X,Number of snapshots contained in the image.\n", result->nb_snapshots);
    printf("QCOW2_snapshots_offset       (8) = 0X%X,Offset into the image file at which the snapshot table starts. Must be aligned to a cluster boundary.\n", result->snapshots_offset);
}


void print_partition_entry(const PartitionEntry * pPE) {

    /* 变量定义 */
    float partition_size;

    /* 变量初始化 */
    partition_size = 0.0;
    if (pPE->sector_total > 0 ) {
        partition_size = (pPE->start_sector_no + pPE->sector_total - 1) / 2048.0;
    }

    /* 处理开始 */
    printf("%s.\n", get_system_name(pPE->type));
    printf("%02x ", pPE->status);
    printf("%02x ", pPE->start_head);
    printf("%02x ", pPE->start_cylinder);
    printf("%02x ", pPE->start_sector);
    printf("%02x ", pPE->type);
    printf("%02x ", pPE->end_head);
    printf("%02x ", pPE->end_cylinder);
    printf("%02x ", pPE->end_sector);
    printf("%d ",   pPE->start_sector_no);
    printf("%d ",   pPE->sector_total);
    printf("%0.2fMB ", partition_size);
    printf("\n");

    printf("   ");
    printf("%02x ", pPE->start_head);
    printf("%02x ", ( ((pPE->start_sector & 0xC0) << 2) | pPE->start_cylinder));
    printf("%02x ", pPE->start_sector & 0x3F);
    printf("%02x ", pPE->end_head);
    printf("%02x ", ( ((pPE->end_sector & 0xC0) << 2) | pPE->end_cylinder));
    printf("%02x ", pPE->end_sector & 0x3F);
    printf("\n");
    /* 处理结束 */
}

void print_vbr_fat_1216(VBRFAT1216 * v) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    char bs_OEMName[9];
    memset(bs_OEMName, 0, sizeof(bs_OEMName));
    memcpy(bs_OEMName, v->bs_OEMName, sizeof(v->bs_OEMName));
    printf("bs_OEMName=%s.\n", bs_OEMName);

    printf("bpb_BytesPerSector=%d.\n", v->bpb.bpb_BytesPerSector);
    printf("bpb_SectorsPerCluster=%d.\n", v->bpb.bpb_SectorsPerCluster);
    printf("bpb_ReservedSectorst=%d.\n", v->bpb.bpb_ReservedSectorst);
    printf("bpb_FatCopies=%d.\n", v->bpb.bpb_FatCopies);
    printf("bpb_RootDirEntries=%d.\n", v->bpb.bpb_RootDirEntries);
    printf("bpb_NumSectors=%d.\n", v->bpb.bpb_NumSectors);
    printf("bpb_MediaType=%d.\n", v->bpb.bpb_MediaType);
    printf("bpb_SectorsPerFAT=%d.\n", v->bpb.bpb_SectorsPerFAT);
    printf("bpb_SectorsPerTrack=%d.\n", v->bpb.bpb_SectorsPerTrack);
    printf("bpb_NumberOfHeads=%d.\n", v->bpb.bpb_NumberOfHeads);
    printf("bpb_HiddenSectors=%d.\n", v->bpb.bpb_HiddenSectors);
    printf("bpb_SectorsBig=%d.\n", v->bpb.bpb_SectorsBig);
    printf("bs_DrvNum=%d.\n", v->bs_DrvNum);
    printf("bs_Reaserved1=%d.\n", v->bs_Reaserved1);
    printf("bs_Bootsig=%d.\n", v->bs_Bootsig);
    printf("bs_VolID=%04X-%04X.\n", v->bs_VolID[1], v->bs_VolID[0]);
    char bs_VolLab[12];
    memset(bs_VolLab, 0, sizeof(bs_VolLab));
    memcpy(bs_VolLab, v->bs_VolLab, sizeof(v->bs_VolLab));
    printf("bs_VolLab=%s.\n", bs_VolLab);
    char bs_FileSysType[9];
    memset(bs_FileSysType, 0, sizeof(bs_FileSysType));
    memcpy(bs_FileSysType, v->bs_FileSysType, sizeof(v->bs_FileSysType));
    printf("bs_FileSysType=%s.\n", bs_FileSysType);
    uint16_t bs_EndFlag;
    memcpy(&bs_EndFlag, v->bs_EndFlag, sizeof(v->bs_EndFlag));
    printf("bs_EndFlag=%X.\n", bs_EndFlag);
    /* 处理结束 */
}


void print_vbr_fat_32(VBRFAT32 * v) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    char bs_OEMName[9];
    memset(bs_OEMName, 0, sizeof(bs_OEMName));
    memcpy(bs_OEMName, v->bs_OEMName, sizeof(v->bs_OEMName));
    printf("bs_OEMName=%s.\n", bs_OEMName);
    printf("bpb_BytesPerSector=%d.\n", v->bpb.bpb_BytesPerSector);
    printf("bpb_SectorsPerCluster=%d.\n", v->bpb.bpb_SectorsPerCluster);
    printf("bpb_ReservedSectorst=%d.\n", v->bpb.bpb_ReservedSectorst);
    printf("bpb_FatCopies=%d.\n", v->bpb.bpb_FatCopies);
    printf("bpb_RootDirEntries=%d.\n", v->bpb.bpb_RootDirEntries);
    printf("bpb_NumSectors=%d.\n", v->bpb.bpb_NumSectors);
    printf("bpb_MediaType=%d %X.\n", v->bpb.bpb_MediaType, v->bpb.bpb_MediaType);
    printf("bpb_SectorsPerFAT=%d.\n", v->bpb.bpb_SectorsPerFAT);
    printf("bpb_SectorsPerTrack=%d.\n", v->bpb.bpb_SectorsPerTrack);
    printf("bpb_NumberOfHeads=%d.\n", v->bpb.bpb_NumberOfHeads);
    printf("bpb_HiddenSectors=%d.\n", v->bpb.bpb_HiddenSectors);
    printf("bpb_SectorsBig=%d.\n", v->bpb.bpb_SectorsBig);

    printf("bpb_SectorsPerFAT32=%d.\n", v->bpb.bpb_SectorsPerFAT32);
    printf("bpb_Flags=%d.\n", v->bpb.bpb_Flags);
    printf("bpb_FSVersion=%d.\n", v->bpb.bpb_FSVersion);
    printf("bpb_RootClusterNo=%d.\n", v->bpb.bpb_RootClusterNo);
    printf("bpb_FSInfo=%d.\n", v->bpb.bpb_FSInfo);
    printf("bpb_BakBootSec=%d.\n", v->bpb.bpb_BakBootSec);

    printf("bs_DrvNum=%d.\n", v->bs_DrvNum);
    printf("bs_Reaserved1=%d.\n", v->bs_Reaserved1);
    printf("bs_Bootsig=%d.\n", v->bs_Bootsig);
    printf("bs_VolID=%04X-%04X.\n", v->bs_VolID[1], v->bs_VolID[0]);
    char bs_VolLab[12];
    memset(bs_VolLab, 0, sizeof(bs_VolLab));
    memcpy(bs_VolLab, v->bs_VolLab, sizeof(v->bs_VolLab));
    printf("bs_VolLab=%s.\n", bs_VolLab);
    char bs_FileSysType[9];
    memset(bs_FileSysType, 0, sizeof(bs_FileSysType));
    memcpy(bs_FileSysType, v->bs_FileSysType, sizeof(v->bs_FileSysType));
    printf("bs_FileSysType=%s.\n", bs_FileSysType);
    uint16_t bs_EndFlag;
    memcpy(&bs_EndFlag, v->bs_EndFlag, sizeof(v->bs_EndFlag));
    printf("bs_EndFlag=%X.\n", bs_EndFlag);
    /* 处理结束 */
}

int print_dirt(const DIRENT * dir_ent) {
    /* 变量定义 */
    int returnCode;
//     DIRENT dir_ent;
    int idx = 0;
    char file_name[9];
    char file_name_ex[4];
    uint16_t start_cluster;
    uint32_t file_size;
    uint16_t createTimeHMS;
    uint16_t createDateYMD;
    uint16_t lastAcDateYMD;
    uint16_t lastModifyDate;
    uint16_t lastModifyTime;

    /* 变量初始化 */
    returnCode = 0;

    /* 处理开始 */
    printf(">>----- print_dirt -----.\n");

        memset(file_name, 0, sizeof(file_name));
        memset(file_name_ex, 0, sizeof(file_name_ex));

        memcpy(file_name, dir_ent->fileName, sizeof(dir_ent->fileName));
        memcpy(file_name_ex, dir_ent->fileExtension, sizeof(dir_ent->fileExtension));
        memcpy(&createTimeHMS, dir_ent->createTimeHMS, sizeof(uint16_t));
        memcpy(&createDateYMD, dir_ent->createDateYMD, sizeof(uint16_t));
        memcpy(&lastAcDateYMD, dir_ent->lastAcDateYMD, sizeof(uint16_t));
        memcpy(&lastModifyDate, dir_ent->lastModifyDate, sizeof(uint16_t));
        memcpy(&lastModifyTime, dir_ent->lastModifyTime, sizeof(uint16_t));
        memcpy(&start_cluster, dir_ent->startClusters, sizeof(uint16_t));
        memcpy(&file_size, dir_ent->fileSize, sizeof(uint32_t));

        printf("%s.%s  %02X %d ",  file_name, file_name_ex, dir_ent->fileAttrube[0], dir_ent->createTime[0]);
        printf("%04d/%02d/%02d ", (((createDateYMD & 0xFE00) >>  9) > 0 ? 1980 + ((createDateYMD & 0xFE00) >>  9) : 0), ((createDateYMD & 0x1E0) >> 5), (createDateYMD & 0x1F));
        printf("%02d:%02d:%02d ", ((createTimeHMS & 0xF800) >> 11), ((createTimeHMS & 0x7E0) >> 5), (createTimeHMS & 0x1F));
        printf("%04d/%02d/%02d ", (((lastAcDateYMD & 0xFE00) >>  9) > 0 ? 1980 + ((lastAcDateYMD & 0xFE00) >>  9) : 0), ((lastAcDateYMD & 0x1E0) >> 5), (lastAcDateYMD & 0x1F));
        printf("%04d/%02d/%02d ", (((lastModifyDate & 0xFE00) >>  9) > 0 ? 1980 + ((lastModifyDate & 0xFE00) >>  9) : 0), ((lastModifyDate & 0x1E0) >> 5), (lastModifyDate & 0x1F));
        printf("%02d:%02d:%02d ", ((lastModifyTime & 0xF800) >> 11), ((lastModifyTime & 0x7E0) >> 5), (lastModifyTime & 0x1F));
        printf("%d %X %d ", start_cluster, start_cluster, file_size);
        printf("\n");


    goto end_print_dirt;
err_print_dirt:
end_print_dirt:
    /* 处理结束 */
    printf("----- print_dirt -----<<.\n");
    return returnCode;
}



int print_qcow2(QCOW2_FILE * qcow2File) {
    /* 变量定义 */
    int returnCode;

    /* 变量初始化 */
    returnCode = 0;

    /* 处理开始 */
    printf(">>----- QCOW2 HEADER -----.\n");
    printf("头信息在镜像文件中的位置[(%lld, ", 0LL);
    printf("0X%04X)-(", 0LL);
    printf("%lld, 0X", qcow2File->pHeader->l1_table_offset);
    printf("%04X))\n", qcow2File->pHeader->l1_table_offset);
    print_header(qcow2File->pHeader);
    printf("%d.\n", qcow2File->pHeader->cluster_bits);
    printf("cluster_size = %ld\n", qcow2File->clustor_size);
    printf("----- QCOW2 HEADER -----<<.\n");
    // print_header(qcow2File->pHeader);

    /* L1 */
    printf(">>----- Level 1 Table -----\n");
    printf("表1在镜像文件中的位置[(%lld, 0X%04X)-", qcow2File->pHeader->l1_table_offset, qcow2File->pHeader->l1_table_offset);
    printf("(%lld, 0X%04X))\n", qcow2File->pHeader->refcount_table_offset, qcow2File->pHeader->refcount_table_offset);
    debug_print_table_64(qcow2File->pL1Table, qcow2File->l1_size);
    printf("----- Level 1 Table -----<<\n");
    printf("\n");

    /* refcount table */
    printf(">>----- Refcount Table -----\n");
    printf("引用计数表在镜像文件中的位置[(%lld, 0X%04X)-", qcow2File->pHeader->refcount_table_offset, qcow2File->pHeader->refcount_table_offset);
    printf("(%lld, 0X%04X))\n", qcow2File->pRefcountTable[0], qcow2File->pRefcountTable[0]);
    debug_print_table_64(qcow2File->pRefcountTable, qcow2File->refcount_table_cnt);
    printf("----- Refcount Table -----<<\n");
    printf("\n");

    /* refcount */
    printf(">>----- Refcount Block -----\n");
    printf("!!!引用计数块在镜像文件中似乎不是连续存储的，那么1个引用计数块的大小应该是1个簇。\n");
    printf("引用计数块在镜像文件中的位置[(%lld, 0X%04X)-", qcow2File->pRefcountTable[0], qcow2File->pRefcountTable[0]);
    printf("(%lld, 0X%04X))\n", (qcow2File->pRefcountTable[0] + qcow2File->clustor_size), (qcow2File->pRefcountTable[0] + qcow2File->clustor_size));
    debug_print_table_16(qcow2File->pRefcountBlock, qcow2File->refcount_cnt);
    printf("----- Refcount Block -----<<\n");
    printf("\n");

    /* L2 */
    printf(">>----- Level 2 Table -----\n");
    printf("表2在镜像文件中的最初位置[(%lld, 0X%04X)-", qcow2File->pL2Table[0], qcow2File->pL2Table[0]);
    printf("(%lld, 0X%04X)).\n", qcow2File->pL2Table[0] + qcow2File->clustor_size, qcow2File->pL2Table[0] + qcow2File->clustor_size);
    debug_print_table_64(qcow2File->pL2Table, qcow2File->l2_size);
    printf("----- Level 2 Table -----<<\n");
    printf("\n");

    goto end_print_qcow2;
err_print_qcow2:
end_print_qcow2:
    /* 处理结束 */
    return returnCode;
}

int write_header(QCOW2_FILE * qcow2File, FILE * pFile) {
    /* 变量定义 */
    int returnCode;
    QCowHeader header;

    /* 变量初始化 */
    returnCode = 0;
    memset(&header, 0, sizeof(QCowHeader));

    /* 处理开始 */
    printf(">>----- write_header begin -----\n");
    header.magic = cpu_to_be32(qcow2File->pHeader->magic);
    header.version = cpu_to_be32(qcow2File->pHeader->version);
    header.backing_file_offset = cpu_to_be64(qcow2File->pHeader->backing_file_offset);
    header.backing_file_size = cpu_to_be32(qcow2File->pHeader->backing_file_size);
    header.cluster_bits = cpu_to_be32(qcow2File->pHeader->cluster_bits);
    header.size = cpu_to_be64(qcow2File->pHeader->size);
    header.crypt_method = cpu_to_be32(qcow2File->pHeader->crypt_method);
    header.l1_size = cpu_to_be32(qcow2File->pHeader->l1_size);
    header.l1_table_offset = cpu_to_be64(qcow2File->pHeader->l1_table_offset);
    header.refcount_table_offset = cpu_to_be64(qcow2File->pHeader->refcount_table_offset);
    header.refcount_table_clusters = cpu_to_be32(qcow2File->pHeader->refcount_table_clusters);
    header.nb_snapshots = cpu_to_be32(qcow2File->pHeader->nb_snapshots);
    header.snapshots_offset = cpu_to_be64(qcow2File->pHeader->snapshots_offset);

    if (fseek(pFile, 0, SEEK_SET)) {
        printf("fseek error(%lld).\n", 0);
        goto err_write_header;
    }
    // fseek(pFile, 0, SEEK_CUR);
    // printf("%d.\n", ftell(pFile));
    int writecnt = fwrite(&header, sizeof(char), sizeof(QCowHeader), pFile);
    if (writecnt != sizeof(QCowHeader)) {
        printf("file write error(%d != %d).\n", writecnt, sizeof(QCowHeader));
        goto err_write_header;
    }
    print_header(qcow2File->pHeader);
    goto end_write_header;
err_write_header:
end_write_header:
    /* 处理结束 */
    printf("----- write_header end -----<<\n");
    return returnCode;
}

int write_l1(QCOW2_FILE * qcow2File, FILE * pFile) {
    /* 变量定义 */
    int returnCode;
    uint64_t idx   = -1;
    uint64_t idz   =  0;
    uint64_t value = -1;

    /* 变量初始化 */
    returnCode = 0;

    /* 处理开始 */
    printf(">>----- write_l1 begin -----\n");
    debug_print_table_64(qcow2File->pL1Table, qcow2File->l1_size);
    for (idx = 0; idx < qcow2File->l1_size; idx ++) {
        value = *(qcow2File->pL1Table + idx);
        if (value == 0) { continue; }
        printf("table[%05lld]=%010lld, 0X%010X ", idx, value, value);
        idz ++;
        if (idz % 8 ==0) { printf("\n"); }
        value += (1LL << 63);
        *(qcow2File->pL1Table + idx) = cpu_to_be64(value);
    }
    printf("\n");
    debug_print_table_64(qcow2File->pL1Table, qcow2File->l1_size);

    if (fseek(pFile, qcow2File->pHeader->l1_table_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", qcow2File->pHeader->l1_table_offset);
        goto err_write_l1;
    }
    int writecnt = fwrite(qcow2File->pL1Table, sizeof(uint64_t), qcow2File->l1_size, pFile);
    if (writecnt != qcow2File->l1_size) {
        printf("file write error(%d != %d).\n", writecnt, qcow2File->l1_size);
        goto err_write_l1;
    }
    for (idx = 0; idx < qcow2File->l1_size; idx ++) {
        value = *(qcow2File->pL1Table + idx);
        if (value == 0) { continue; }
        value = be64_to_cpu(value);
        value = value & 0x3FFFFFFFFFFFFFFF;
        memcpy(qcow2File->pL1Table + idx, &value, sizeof(value));
    }
    printf("\n");
    debug_print_table_64(qcow2File->pL1Table, qcow2File->l1_size);

    goto end_write_l1;
err_write_l1:
end_write_l1:
    /* 处理结束 */
    printf("----- write_l1 end -----<<\n");
    return returnCode;
}

int write_l2(QCOW2_FILE * qcow2File, uint32_t l1_idx, FILE * pFile, uint64_t l2_offset) {
    /* 变量定义 */
    int returnCode;
    uint64_t idx   = -1;
    uint64_t idz   =  0;
    uint64_t value = -1;
    uint64_t * l2_buf = NULL;

    /* 变量初始化 */
    returnCode = 0;
    size_t l2_size = qcow2File->clustor_size / sizeof(uint64_t);

    /* 处理开始 */
    printf(">>----- write_l2 begin -----\n");
    l2_buf = (uint64_t *) malloc(qcow2File->clustor_size);
    if (l2_buf == NULL) {
        printf("memory alloc error.\n");
        returnCode = 1; goto err_write_l2;
    }
    memset(l2_buf, 0, qcow2File->clustor_size);
    memcpy(l2_buf, qcow2File->pL2Table + l1_idx * qcow2File->clustor_size, qcow2File->clustor_size);
    printf("变换前l1_idx=%d,l2_size=%d.\n", l1_idx, l2_size);
    debug_print_table_64(l2_buf, l2_size);
    printf("\n");

    for (idx = 0; idx < l2_size; idx ++) {
        value = *(l2_buf + idx);
        if (value == 0) { continue; }
        printf("table[%05lld]=%010lld, 0X%010X ", idx, value, value);
        idz ++;
        if (idz % 8 ==0) { printf("\n"); }
        value += (1LL << 63);
        *(l2_buf + idx) = cpu_to_be64(value);
    }
    printf("\n变换后.\n");
    debug_print_table_64(l2_buf, l2_size);
    printf("\n");

    if (fseek(pFile, l2_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", l2_offset);
        goto err_write_l2;
    }
    int writecnt = fwrite(l2_buf, sizeof(uint64_t), l2_size, pFile);
    printf("write l2 @0x%x", l2_offset);
    printf("-%d(%d).\n", writecnt, l2_size);
    if (writecnt != l2_size) {
        printf("file write error(%d != %d).\n", writecnt, l2_size);
        goto err_write_l2;
    }
    printf("\n");
    debug_print_table_64(qcow2File->pL2Table + l1_idx * qcow2File->clustor_size, l2_size);

    goto end_write_l2;
err_write_l2:
end_write_l2:
    /* 处理结束 */
    printf("----- write_l2 end -----<<\n");
    if (l2_buf != NULL) { free(l2_buf); l2_buf = NULL; }
    return returnCode;
}


int write_qcow2(QCOW2_FILE * qcow2File, FILE * pFile, uint64_t sector_no, void * buf, size_t buf_size) {
    /* 变量定义 */
    int returnCode;
    uint32_t l1_idx;
    uint32_t l2_idx;
    uint32_t cl_idx;
    uint64_t write_offset;
    uint64_t l1_offset;
    uint64_t l2_offset;
    size_t write_size;
    uint32_t sec_idx;
    size_t out_size;
    int write_cnt;
    size_t total_size;
    int l1_update_flag;
    int l2_update_flag;

    /* 变量初始化 */
    returnCode = 0;
    write_size = 0;
    write_cnt = 0;
    total_size = buf_size;
    l1_update_flag = 0;
    l2_update_flag = 0;

    /* 处理开始 */
    printf(">>----- ■■■write_qcow2 begin -----\n");
    printf("扇区索引%lld.", sector_no);
    printf("缓冲区大小%d.\n", buf_size);
    sec_idx = ((uint32_t) sector_no);
    do {
        l1_update_flag = 0;
        l2_update_flag = 0;
        printf("-----------------------------------.\n");
        printf("%d◆扇区索引%d.\n",write_cnt, sec_idx);
        l1_idx = get_l1_index(sec_idx, qcow2File->clustor_size, 512);
        l2_idx = get_l2_index(sec_idx);
        cl_idx = get_cluster_index(sec_idx);
        printf("L1:%d, L2:%d, 簇:%d.%X.\n", l1_idx, l2_idx, cl_idx, cl_idx);
        printf("%d◆簇的剩余大小%d.\n",write_cnt,  qcow2File->clustor_size - cl_idx);
        printf("%d◆待写区域大小%d.\n",write_cnt,  total_size);
        out_size = buf_size;
        if (buf_size > (qcow2File->clustor_size - cl_idx)) {
            out_size = qcow2File->clustor_size - cl_idx;
        }
        total_size -= out_size;
        sec_idx += (out_size / 512);

        printf("L1_size:%d.\n", qcow2File->l1_size);
        if (l1_idx >= qcow2File->l1_size) {
        }
        l1_offset = *(qcow2File->pL1Table + l1_idx);
        printf("表1偏移:%lld %X.\n", l1_offset, l1_offset);
        if (l1_offset == 0LL) {
            /* create L2 Table */
            printf("l1_idx=%d.\n", l1_idx);
            // l1_offset = *(qcow2File->pRefcountTable) + qcow2File->clustor_size;
            int i = 0;
            for (i = 0; i < qcow2File->refcount_cnt; i ++) {
                if (*(qcow2File->pRefcountBlock + i) == 0) {
                    break;
                }
            }
            l1_offset = 1LL * i * qcow2File->clustor_size;
            printf("l1_offset=0X%X.\n", l1_offset);
            *(qcow2File->pL1Table + l1_idx) = l1_offset;
            *(qcow2File->pRefcountBlock + i) = 1; /* 引用计数块更新 */
            l1_update_flag = 1;
            if (qcow2File->pL2Table == NULL) {
                qcow2File->pL2Table = (uint64_t *) malloc(sizeof(uint64_t) * qcow2File->l1_size * qcow2File->clustor_size / 8);
                if (qcow2File->pL2Table == NULL) {
                    goto err_write_qcow2;
                }
                memset(qcow2File->pL2Table, 0, sizeof(uint64_t) * qcow2File->l1_size * qcow2File->clustor_size / 8);
            }
        }
        l2_offset = *(qcow2File->pL2Table + l1_idx * qcow2File->clustor_size + l2_idx);
        printf("表2偏移:%lld %X.\n", l2_offset, l2_offset);
        if (l2_offset == 0LL) {
            /* 分配新簇 */
            int i = 0;
            for (i = 0; i < qcow2File->refcount_cnt; i ++) {
                if (*(qcow2File->pRefcountBlock + i) == 0) {
                    break;
                }
            }
            l2_offset = i * qcow2File->clustor_size;
            *(qcow2File->pL2Table + l1_idx * qcow2File->clustor_size + l2_idx) = l2_offset;
            *(qcow2File->pRefcountBlock + i) = 1; /* 引用计数块更新 */
            printf("新建表2偏移:%lld %X.\n", l2_offset, l2_offset);
            l2_update_flag = 1;
        } else {
            printf("更新原有的簇.:%lld %X.\n", l2_offset, l2_offset);
        }
        write_offset = l2_offset + cl_idx;
        printf("簇内偏移:%lld %X.\n", write_offset, write_offset);
        uint64_t local_cluster_index = write_offset / qcow2File->clustor_size;
        printf("镜像文件中的簇信息:%lld, %X.\n", local_cluster_index, local_cluster_index);
        printf("引用计数块的个数:%d.\n", qcow2File->refcount_cnt);
        uint16_t is_used = *(qcow2File->pRefcountBlock + local_cluster_index);
        printf("引用计数块的使用情况:%d.\n", is_used);
        if (is_used != 1) {
        }

        if (fseek(pFile, write_offset, SEEK_SET)) {
            printf("fseek error(%lld).\n", write_offset);
            goto err_write_qcow2;
        }
        int writecnt = fwrite((char *)buf + write_size, 1, out_size, pFile);
        if (writecnt != out_size) {
            printf("file write error(%d != %d).\n", writecnt, out_size);
            goto err_write_qcow2;
        }
        write_size += out_size;
        printf("%d◆成功写入区域大小%d.\n",write_cnt,  out_size);
        printf("%d◆累计成功写入区域大小%d.\n",write_cnt,  write_size);
        printf("%d◆成功写入区域大小%d.\n", write_cnt, out_size);
        write_cnt ++;
        if (l1_update_flag == 1) {
            if (write_l1(qcow2File, pFile) != 0) {
                returnCode = 1; goto err_write_qcow2; }
            l1_update_flag = 0;
        }
        if (l2_update_flag == 1) {
            printf("l1_offset=0X%X.\n", l1_offset);
            printf("l2_offset=0X%X.\n", l2_offset);
            printf("l1_idx   =%d.\n", l1_idx);
            if (write_l2(qcow2File, l1_idx, pFile, l1_offset) != 0) {
                returnCode = 1; goto err_write_qcow2; }
            l2_update_flag = 0;
        }
    } while(write_size < buf_size);


    goto end_write_qcow2;
err_write_qcow2:
end_write_qcow2:
    /* 处理结束 */
    printf("----- ■■■write_qcow2 end -----<<\n\n");
    return returnCode;
}


int64_t align_offset(int64_t offset, int n) {
    /* 变量定义 */

    /* 变量初始化 */

    /* 处理开始 */
    offset = (offset + n - 1) & ~(n - 1);

    /* 处理结束 */
    return offset;
}


static int get_bits_from_size(size_t size) {
    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    int res = 0;

    if (size == 0) {
        return -1;
    }

    while (size != 1) {
        /* Not a power of two */
        if (size & 1) {
            return -1;
        }

        size >>= 1;
        res++;
    }
    /* 处理结束 */
    return res;
}

void qcow2_create_refcount_update(uint16_t * refcount_block, int64_t offset, int64_t size, size_t cluster_size, int cluster_bits) {
    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    int refcount;
    int64_t start, last, cluster_offset;
    uint16_t * p;

    start = offset & ~(cluster_size - 1);
    last = (offset + size - 1)  & ~(cluster_size - 1);
    for(cluster_offset = start; cluster_offset <= last; cluster_offset += cluster_size) {
        p = &refcount_block[cluster_offset >> cluster_bits];
        refcount = be16_to_cpu(*p);
        refcount++;
        *p = cpu_to_be16(refcount);
    }
    /* 处理结束 */
}


int create(const char * filename, uint64_t total_size, size_t cluster_size) {
    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    QCowHeader  header;
    //uint64_t    total_size;
    int         cluster_bits;
    int         flags;
    int64_t     l1_table_offset;
    int32_t     l1_size;
    int64_t     reftable_offset;
    int32_t     reftable_clusters;
//    size_t      cluster_size;
    int         header_size;
    int         l2_bits;
    uint64_t    offset;
    int         shift;
    int         ref_clusters;
    int         old_ref_clusters;
    int         i;
    FILE *      pFile = NULL;
//    const char * filename;
    uint64_t    refcount_table_offset;
    uint64_t    refcount_block_offset;
    uint16_t *  refcount_block;
    uint64_t *  refcount_table;
    uint64_t    tmp;
    size_t      wrotencnt;

    //total_size = (2 * 1024 * 1024) / 512; // 2M

    flags           = 0;
    l1_table_offset = 0;
    l1_size         = 0;
    reftable_offset = 0;
    reftable_clusters = 0;
//    cluster_size    = 65536;
//    cluster_size    = 4096;  // TODO:修正为函数取得
//    filename        = ".\\test";

    /* 处理开始 */
    printf(">>----- create begin -----\n");
    cluster_bits = get_bits_from_size(cluster_size);
    if (cluster_bits < MIN_CLUSTER_BITS || cluster_bits > MAX_CLUSTER_BITS) {
        // 9 - 21
        fprintf(stderr, "Cluster size must be a power of two between %d and %dk\n",
            1 << MIN_CLUSTER_BITS,
            1 << (MAX_CLUSTER_BITS - 10));
        return -1;
    }
    cluster_size = 1 << cluster_bits;
    l2_bits = cluster_bits - 3;
    shift   = cluster_bits + l2_bits;
    l1_size = ((total_size + (1LL << shift) - 1) >> shift);

    header_size = sizeof(header);
    header_size = (header_size + 7) & ~7;
    offset = align_offset(header_size, cluster_size);
    printf("level1 offset %lld.\n", offset);
    l1_table_offset = offset;

    memset(&header, 0, sizeof(header));
    /* magic */
    header.magic        = cpu_to_be32(QCOW_MAGIC);
    /* version */
    header.version      = cpu_to_be32(QCOW_VERSION);
    /* cluster_bits */
    // TODO:cluster_size
    header.cluster_bits = cpu_to_be32(cluster_bits);
    /* size */
    header.size         = cpu_to_be64(total_size);
    /* crypt_method */
    if (flags & BLOCK_FLAG_ENCRYPT) {
        header.crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
    } else {
        header.crypt_method = cpu_to_be32(QCOW_CRYPT_NONE);
    }
    /* l1_table_offset */
    header.l1_table_offset = cpu_to_be64(l1_table_offset);
    /* l1_size */
    header.l1_size = cpu_to_be32(l1_size);
    printf("level1 size %d.\n", l1_size);

    offset += align_offset(l1_size * sizeof(uint64_t), cluster_size);

#define NUM_CLUSTERS(bytes) \
    (((bytes) + (cluster_size) - 1) / (cluster_size))

    ref_clusters = NUM_CLUSTERS(NUM_CLUSTERS(offset) * sizeof(uint16_t));
    do {
        uint64_t image_clusters;
        old_ref_clusters = ref_clusters;

        /* Number of clusters used for the refcount table */
        reftable_clusters = NUM_CLUSTERS(ref_clusters * sizeof(uint64_t));
        /* Number of clusters that the whole image will have */
        image_clusters = NUM_CLUSTERS(offset) + ref_clusters + reftable_clusters;
        /* Number of refcount blocks needed for the image */
        ref_clusters = NUM_CLUSTERS(image_clusters * sizeof(uint16_t));
    } while (ref_clusters != old_ref_clusters);

    printf("reftable_clusters=%d.\n", reftable_clusters);
    printf("cluster_size=%d.\n", cluster_size);
    refcount_table = (uint64_t * ) malloc(reftable_clusters * cluster_size);
    memset(refcount_table, 0, reftable_clusters * cluster_size);

    refcount_table_offset = offset;
    header.refcount_table_offset = cpu_to_be64(offset);
    printf("refcount_table offset %lld.\n", offset);
    header.refcount_table_clusters = cpu_to_be32(reftable_clusters);

    offset += (reftable_clusters * cluster_size);
    refcount_block_offset = offset;
    printf("refcount_block offset %lld.\n", offset);

    for (i = 0; i < ref_clusters; i ++) {
        refcount_table[i] = cpu_to_be64(offset);
        offset += cluster_size;
    }

    refcount_block = (uint16_t *) malloc(ref_clusters * cluster_size);
    memset(refcount_block, 0, ref_clusters * cluster_size);

    /* update refcounts */
    qcow2_create_refcount_update(refcount_block, 0, header_size, cluster_size, cluster_bits);
    qcow2_create_refcount_update(refcount_block, l1_table_offset, l1_size * sizeof(uint64_t), cluster_size, cluster_bits);
    qcow2_create_refcount_update(refcount_block, refcount_table_offset, reftable_clusters * cluster_size, cluster_size, cluster_bits);
    qcow2_create_refcount_update(refcount_block, refcount_block_offset, ref_clusters * cluster_size, cluster_size, cluster_bits);






    pFile = fopen(filename, "w+b");
    if (pFile == NULL) {
        fprintf(stderr, "file open error(%s).\n", filename);
        return -1;
    }
    wrotencnt = fwrite(&header, 1, sizeof(header), pFile);

    fseek(pFile, l1_table_offset, SEEK_SET);
    tmp = 0;
    for(i = 0;i < l1_size; i++) {
        fwrite(&tmp, 1, sizeof(tmp), pFile);
    }

    fseek(pFile, refcount_table_offset, SEEK_SET);
    fwrite(refcount_table, 1, reftable_clusters * cluster_size, pFile);


    fseek(pFile, refcount_block_offset, SEEK_SET);
    fwrite(refcount_block, 1, ref_clusters * cluster_size, pFile);

    /* 处理结束 */
    printf("----- create end -----<<\n");
    if (pFile != NULL) {
        fclose(pFile);
        pFile = NULL;
    }

    if (refcount_table != NULL) {
        free(refcount_table);
        refcount_table = NULL;
    }
    if (refcount_block != NULL) {
        free(refcount_block);
        refcount_block = NULL;
    }
    /* 处理结束 */
    return 0;
}

int get_cylinder(int sector_no, uint8_t n) {
    /* 变量定义 */
    int returnCode;
    uint8_t CS=0;
    uint8_t HS=0;
    uint8_t SS=1;
    uint8_t PS=63;
    uint8_t PH=16;

    /* 变量初始化 */
    /* printf("扇区索引：%d.", sector_no); */
    int sh = PS * ( PH * n );
    returnCode = sector_no / sh;
    /* 处理开始 */
    /* printf("柱面：%d.\n", returnCode); */

    goto end_cylinder;
err_cylinder:
end_cylinder:
    /* 处理结束 */
    return returnCode;
}

int get_n(int cylinder) {
    /* 变量定义 */
    int returnCode;


    /* 变量初始化 */
    returnCode = 1;

    /* 处理开始 */
    if (1 < cylinder && cylinder <= 1024) {
        returnCode = 1;
    } else if (1024 < cylinder && cylinder <= 2048) {
        returnCode = 2;
    } else if (2048 < cylinder && cylinder <= 4096) {
        returnCode = 4;
    } else if (4096 < cylinder && cylinder <= 8192) {
        returnCode = 8;
    } else if (8192 < cylinder && cylinder <= 16384) {
        returnCode = 16;
    }
    goto end_get_n;
err_get_n:
end_get_n:
    /* 处理结束 */
    return returnCode;
}


int get_header(int sector_no, uint8_t n) {
    /* 变量定义 */
    int returnCode;
    uint8_t CS=0;
    uint8_t HS=0;
    uint8_t SS=1;
    uint8_t PS=63;
    uint8_t PH=16;

    /* 变量初始化 */
    returnCode = ( sector_no / (PS) ) % (PH * n);
    /* 处理开始 */

    goto end_header;
err_header:
end_header:
    /* 处理结束 */
    return returnCode;
}

int get_sector(int sector_no) {
    /* 变量定义 */
    int returnCode;
    uint8_t CS=0;
    uint8_t HS=0;
    uint8_t SS=1;
    uint8_t PS=63;
    /* uint8_t PH=16; */

    /* 变量初始化 */
    returnCode = ( sector_no % (PS) ) + 1;
    /* 处理开始 */

    goto end_sector;
err_sector:
end_sector:
    /* 处理结束 */
    return returnCode;
}
void print_qcow2_file(QCOW2_FILE * qcow2) {
    printf(">>----- print_qcow2_file -----.\n");
    printf("HEADER:%08X.\n", qcow2->pHeader);
    printf("L1    :%08X.\n", qcow2->pL1Table);
    printf("RFT   :%08X.\n", qcow2->pRefcountTable);
    printf("RFB   :%08X.\n", qcow2->pRefcountBlock);
    printf("L2    :%08X.\n", qcow2->pL2Table);
    printf("\n簇大小%d\n", qcow2->clustor_size);
    printf("----- print_qcow2_file -----<<.\n");
}

// uint64_t get_l2_offset(QCOW2_FILE * qcow2File, uint32_t sector_no) {
//     printf(">>----- get_l2_offset -----.\n");
//     int idx = 0;
//     printf("簇大小：%d.\n", qcow2File->clustor_size);
//     uint32_t l1_idx = get_l1_index(sector_no, qcow2File->clustor_size, 512);
//     uint32_t l2_idx = get_l2_index(sector_no);
//     printf("sector_no=%d.l1_idx=%d.l2_idx=%d.\n", sector_no, l1_idx, l2_idx);
// 
//     uint64_t l1_offset = (qcow2File->pHeader->l1_table_offset);
//     uint32_t l1_size = (qcow2File->pHeader->l1_size);
//     printf("l1 offset:%lld. %X.\n", l1_offset, l1_offset);
//     printf("size:%d.\n", l1_size);
//     if (*(qcow2File->pL1Table + l1_idx) == 0LL) {
//         int i = 0;
//         // TODO: DEBUG
//         uint64_t a;
//         for(i = 0; i < 64; i ++) {
//             a = 1LL << i;
//             printf("%02d.a=%llu.%X.\n", i, a, a);
//         }
// 
//         uint64_t cluster_addr = 0x4000 & 0xFFFFFFFFFFFFF000LL;
//         int idx_refcount = cluster_addr / 4096;
//         *(qcow2File->pRefcountBlock + idx_refcount) = 1;
// 
//         a = a + 0x4000;
//         printf("%02d.a=%llu.%X.\n", i, a, a);
//         *(qcow2File->pL1Table + l1_idx) = cpu_to_be64(a);
//         printf("L2 TABLE=%X.\n", qcow2File->pL2Table);
// 
//         if (qcow2File->pL2Table == NULL) {
//             
//             qcow2File->pL2Table = (uint64_t *) malloc(4096);
//             if (qcow2File->pL2Table == NULL) {
//                 printf("memory alloc error.\n");
//             }
//             memset(qcow2File->pL2Table, 0, 4096);
//             qcow2File->l2_size += 512;
//         }
//         *(qcow2File->pL2Table + l2_idx) = 0x5000;
//         printf("----- get_l2_offset -----<<.\n");
//         return 0x5000;
//     }
//     printf("----- get_l2_offset -----<<.\n");
//     return 0x5000;
// }

/*
 * 磁盘分区的最小单位是柱面(Cylinder)
 * (16 heads * 63 sectors) 1008 扇区
 * partition_type:
 * 1:主分区
 * 2:扩展分区
 * 3:逻辑分区
 */
int create_partition(const char * filename, int partition_type, 
uint64_t total_size, char * mbrfile, const char * fmt) {
    /* 变量定义 */
    int returnCode;
    PartitionEntry pe;
    int sector;
    int cylinder;
    char buf[512];
    uint32_t max_sector_cnt = total_size / 512;
    uint32_t sector_no;
    int idx = 0;
    QCOW2_FILE * qcow2File;
    FILE * pFile;
    uint32_t cluster_bits;
    int cluster_size;
    size_t      readedcnt;
    uint64_t l1_item;
    uint64_t l1_table_offset;
    uint64_t refcount_table_offset;
    uint32_t l1_size;
    uint32_t refcount_table_cnt;
    uint64_t ref_table_item;
    uint64_t ref_count_offset;
    uint32_t refcount_cnt = 0;
    uint16_t ref_item = -1;
    uint32_t   l2_size = 0;
    PartitionEntryItem * pe_table = NULL;
    int writecnt;
    char file_sys[6];

    /* 变量初始化 */
    returnCode = 0;
    qcow2File = NULL;
    pFile = NULL;
    l1_item = 0LL;
    memset(buf, 0xF6, sizeof(buf));
    memset(file_sys, 0, sizeof(file_sys));

    /* 处理开始 */
    printf(">>----- create_partition begin -----\n");
    qcow2File = (QCOW2_FILE *) malloc(sizeof(QCOW2_FILE));
    if (qcow2File == NULL) {
        fprintf(stderr, "QCOW2 file alloc error.\n");
        returnCode = 1; goto end_create_partition;
    }
    memset(qcow2File, 0, sizeof(QCOW2_FILE));

    pFile = fopen(filename, "r+b");
    if (pFile == NULL) { fprintf(stderr, "file(%s) open error(1).", filename); returnCode = 1; goto end_create_partition; }

    qcow2File->pHeader = read_header(pFile);

    printf("----- QCOW2 HEADER -----.\n");
    print_header(qcow2File->pHeader);
    printf("%X.\n", qcow2File->pHeader->cluster_bits);
    cluster_bits = qcow2File->pHeader->cluster_bits;
    cluster_size = 1 << cluster_bits;
    qcow2File->clustor_size = cluster_size;
    printf("%d.\n", cluster_bits);
    printf("cluster_size = %ld\n", cluster_size);
    printf("size= %lld\n", qcow2File->pHeader->size);
    printf("----- QCOW2 HEADER -----.\n");

    if (total_size == 0) {
        total_size = qcow2File->pHeader->size / (16 * 63 * 512);
        total_size *= (16 * 63 * 512);
        total_size -= (63 * 512);
    }
    printf("total_size=%lld\n", total_size);
    max_sector_cnt = total_size / 512;



    /* L1 */
    printf(">>----- Level 1 Table -----\n");
    l1_table_offset = (qcow2File->pHeader->l1_table_offset);
    refcount_table_offset = (qcow2File->pHeader->refcount_table_offset);
    l1_size = (qcow2File->pHeader->l1_size);
    qcow2File->l1_size = l1_size;
    printf("表1在镜像文件中的位置[(%lld, 0X%04X)-", l1_table_offset, l1_table_offset);
    printf("(%lld, 0X%04X))\n", refcount_table_offset, refcount_table_offset);

    qcow2File->pL1Table = (uint64_t *) malloc(sizeof(uint64_t) * (l1_size + 1));
    if (qcow2File->pL1Table == NULL) {
        fprintf(stderr, "l1 table alloc error.\n");
        goto err_create_partition;
    }
    memset(qcow2File->pL1Table, 0, sizeof(uint64_t) * (l1_size + 1));
    printf("l1_table_offset=%lld,0X%X.\n", l1_table_offset, l1_table_offset);
    printf("l1_table_size=%ld,0X%X.\n", l1_size, l1_size);
    if (fseek(pFile, l1_table_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", l1_table_offset);
        goto err_create_partition;
    }
    /* 表1在镜像文件中是连续存储1个或多个簇的，所以可以1次性读取 */
    readedcnt = fread(qcow2File->pL1Table, sizeof(uint64_t), l1_size, pFile);
    if (readedcnt != l1_size) {
        fprintf(stderr, "read l1 table error(%d!=%d).\n", l1_size);
        goto err_create_partition;
    }
    for (idx = 0; idx < l1_size; idx ++) {
        l1_item = *(qcow2File->pL1Table + idx);
        l1_item = be64_to_cpu(l1_item);
        l1_item = l1_item & 0x3FFFFFFFFFFFFFFF;
        if(idx == 0) { printf("l1[%lld]=%lld. 0X%X.\n", idx, l1_item, l1_item); }
        memcpy(qcow2File->pL1Table + idx, &l1_item, sizeof(l1_item));
    }
    memcpy(&l1_item, qcow2File->pL1Table, sizeof(l1_item));
    debug_print_table_64(qcow2File->pL1Table, l1_size);
    printf("----- Level 1 Table -----<<\n");
    printf("\n");



    /* refcount table */
    printf(">>----- Refcount Table -----\n");
    refcount_table_cnt = (qcow2File->pHeader->cluster_bits) >> 3;
    printf("refcount_table_cnt=%ld.\n", refcount_table_cnt);
    qcow2File->refcount_table_cnt = refcount_table_cnt;
    qcow2File->pRefcountTable = (uint64_t *) malloc(sizeof(uint64_t) * (refcount_table_cnt + 1));
    if (qcow2File->pRefcountTable == NULL) {
        fprintf(stderr, "Refcount table alloc error.\n");
        goto err_create_partition;
    }
    memset(qcow2File->pRefcountTable, 0, sizeof(uint64_t) * (refcount_table_cnt + 1));
    if (fseek(pFile, refcount_table_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", refcount_table_offset);
        goto err_create_partition;
    }
    printf("refcount table offset=%lld, 0X%X.\n", refcount_table_offset, refcount_table_offset);
    /* 引用计数表在镜像文件中也应该是连续存储1个或多个簇的，所以也可以1次性读取，至少在4GB时是这样的 */
    readedcnt = fread(qcow2File->pRefcountTable, sizeof(uint64_t), refcount_table_cnt, pFile);
    if (readedcnt != refcount_table_cnt) {
        fprintf(stderr, "read refcount table error(%d != %d).\n", readedcnt, refcount_table_cnt);
        goto err_create_partition;
    }
    for (idx = 0; idx < refcount_table_cnt; idx ++) {
        ref_table_item = *(qcow2File->pRefcountTable + idx);
        ref_count_offset = be64_to_cpu(ref_table_item);
        printf("refcount[%d]=0X%X.\n", idx, ref_count_offset);
        memcpy(qcow2File->pRefcountTable + idx, &ref_count_offset, sizeof(ref_count_offset));
    }
    memcpy(&ref_count_offset, qcow2File->pRefcountTable, sizeof(ref_count_offset));
    printf("引用计数表在镜像文件中的位置[(%lld, 0X%04X)-", refcount_table_offset, refcount_table_offset);
    printf("(%lld, 0X%04X))\n", ref_count_offset, ref_count_offset);
    debug_print_table_64(qcow2File->pRefcountTable, refcount_table_cnt);
    printf("----- Refcount Table -----<<\n");
    printf("\n");

    /* refcount */
    printf(">>----- Refcount Block -----\n");
    printf("!!!引用计数块在镜像文件中似乎不是连续存储的，那么1个引用计数块的大小应该是1个簇。\n");

    printf("引用计数块在镜像文件中的位置[(%lld, 0X%04X)-", ref_count_offset, ref_count_offset);
    printf("(%lld, 0X%04X))\n", (ref_count_offset + cluster_size), (ref_count_offset + cluster_size));
    refcount_cnt = cluster_size / sizeof(uint16_t);
    printf("refcount_cnt=%ld.\n", refcount_cnt);
    qcow2File->refcount_cnt = refcount_cnt;
    qcow2File->pRefcountBlock = (uint16_t *) malloc(sizeof(uint16_t) * (refcount_cnt + 1));
    if (qcow2File->pRefcountBlock == NULL) {
        fprintf(stderr, "Refcount block alloc error.\n");
        goto err_create_partition;
    }
    memset(qcow2File->pRefcountBlock, 0, sizeof(uint16_t) * (refcount_cnt + 1));

    if (fseek(pFile, ref_count_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", ref_count_offset); 
        goto err_create_partition;
    }
    printf("refcount block offset=%lld, 0X%X, count=%ld.\n", ref_count_offset, ref_count_offset, refcount_cnt);
    readedcnt = fread(qcow2File->pRefcountBlock, sizeof(short), refcount_cnt, pFile);
    if (readedcnt != refcount_cnt) {
        fprintf(stderr, "read refcount error(%d != %d).\n", readedcnt, refcount_cnt);
        goto err_create_partition;
    }
    for (idx = 0; idx < refcount_cnt; idx ++) {
        ref_item = *(qcow2File->pRefcountBlock + idx);
        ref_item = be16_to_cpu(ref_item);
        /* printf("refcount[%lld]=%X.%X,\n", idx, be16_to_cpu(ref_item), ref_item); */
        memcpy(qcow2File->pRefcountBlock + idx, &ref_item, sizeof(ref_item));
        /* if (idx > 10) { break; } */
    }
    debug_print_table_16(qcow2File->pRefcountBlock, refcount_cnt);
    printf("----- Refcount Block -----<<\n");
    printf("\n");

    if (l1_item != 0) {
        /* L2 */
        printf(">>----- Level 2 Table -----\n");
        printf("L2 Table offset=%lld, 0X%X.\n", l1_item, l1_item);
        printf("\n");
        qcow2File->pL2Table = print_l1_table_64(qcow2File->pL1Table, l1_size, pFile, cluster_size);
        l2_size = l1_size * 512;
        qcow2File->l2_size = l2_size;
        printf("l2 table's size:%d.\n", qcow2File->l2_size);
        debug_print_table_64(qcow2File->pL2Table, l2_size);
        printf("----- Level 2 Table -----<<\n");
        printf("\n");

        /* Partition */
        printf(">>----- Partition Table -----\n");
        printf("L2 Table offset=%lld, 0X%X.\n", l1_item, l1_item);
        pe_table = print_partition_table_64(qcow2File->pL1Table, l1_size, qcow2File->pL2Table, l2_size, pFile, cluster_size);
        print_list(pe_table);
        printf("----- Partition Table -----<<\n");
        printf("\n");
    } else {
    }

    print_qcow2_file(qcow2File);

    /* 输出F6 */
    int max_write_cnt = 10;
    int cur_write_cnt = 1;
    printf("fmt=%s.\n", fmt);
    memcpy(file_sys, "fat12", 5);
    if (memcmp(fmt, "auto_", 5) != 0) {
        memset(file_sys, 0, sizeof(file_sys));
        memcpy(file_sys, fmt, sizeof(file_sys));
    }
    int s = (total_size) / 1048576;
    printf("分区大小:%d.\n", s);
    int k = (qcow2File->pHeader->size) / 1024;
    if (k > 2096128) {
        /* 2047M */
        total_size = 2146927104;
        max_sector_cnt = total_size / 512;
        max_write_cnt = 536;
        if (memcmp(fmt, "auto_", 5) == 0) {
            memcpy(file_sys, "fat32", 5);
        }
    } else if (k >= 546336) {
        max_write_cnt = 152 + 2 * ((k - 546336) / 8064);
        if (memcmp(fmt, "auto_", 5) == 0) {
            memcpy(file_sys, "fat32", 5);
        }
    } else if (k >= 537768) {
        max_write_cnt = 152;
        if (memcmp(fmt, "auto_", 5) == 0) {
            memcpy(file_sys, "fat32", 5);
        }
    } else if (k >= 530208) {
        max_write_cnt = 150;
        if (memcmp(fmt, "auto_", 5) == 0) {
            memcpy(file_sys, "fat32", 5);
        }
    } else if (k >  524663) {
        max_write_cnt = 148;
        if (memcmp(fmt, "auto_", 5) == 0) {
            memcpy(file_sys, "fat32", 5);
        }
    } else if (s >= 24) {
        max_write_cnt = 11 + (s - 24) / 16;
        if (memcmp(fmt, "auto_", 5) == 0) {
            memcpy(file_sys, "fat16", 5);
        }
    } else if (s >= 16) {
        max_write_cnt = 10 + (s - 16) / 8;
        if (memcmp(fmt, "auto_", 5) == 0) {
            memcpy(file_sys, "fat16", 5);
        }
    }

    sector_no = 0;
    printf("max_sector_cnt = %d.\n", max_sector_cnt);
    for (idx = 0, sector_no = 63; ; idx ++) {
        printf(" %03d ", idx);
        printf("sector no = %d.", sector_no);
        printf("%d > %d.\n", cur_write_cnt, max_write_cnt);
        if (cur_write_cnt > max_write_cnt) {
            break ;
        }
        if (sector_no > max_sector_cnt) {
            break;
        }

        if (write_qcow2(qcow2File, pFile, sector_no, buf, sizeof(buf)) != 0) {
            returnCode = 1;
            goto err_create_partition;
        }
        cur_write_cnt ++;
        if (max_write_cnt >= 148) {
            sector_no += 6;
            if (sector_no > max_sector_cnt) {
                break;
            }
            if (write_qcow2(qcow2File, pFile, sector_no, buf, sizeof(buf)) != 0) {
                returnCode = 1;
                goto err_create_partition;
            }
            cur_write_cnt ++;
            sector_no += 57;
        } else {
            sector_no += 63;
        }
    } /* for */
    printf("\n");

    printf("file=%s.\n", filename);
    printf("partition_type=%d.\n", partition_type);
    printf("total_size=%lld.\n", total_size);
    /* TODO:检查输入文件 */
    /* 获取输入文件信息 */
    /* 主分区存在则不能再创建 */
    /* 主分区不存在则不能再创建扩展分区和逻辑分区 */
    /* 扩展分区不存在则不能再创建逻辑分区 */
    /* 容量检查 */
    memset(&pe, 0, sizeof(PartitionEntry));
    if (partition_type == 1) {
        /* PrimaryPartition */
        pe.status = 0x80;
        pe.start_sector_no = 0x3F;
        pe.start_head = get_header(pe.start_sector_no, 1);
        sector = get_sector(pe.start_sector_no);
        cylinder = get_cylinder(pe.start_sector_no, 1);
        pe.start_sector = (( cylinder & 0x3FF ) >> 2) | sector;
        pe.start_cylinder = cylinder & 0xFF;
        pe.type   = 0x0E; /* WIN95 FAT16 */
        pe.type   = 0x04; /* DOS 3.0+ FAT16 */
        if (memcmp(file_sys, "fat32", 5) == 0) {
            pe.type   = 0x0C;
        }
        pe.sector_total = total_size / 512;
        pe.end_head = get_header(pe.start_sector_no + pe.sector_total - 1, 1);
        sector      = get_sector(pe.start_sector_no + pe.sector_total - 1);
        cylinder    = get_cylinder(pe.start_sector_no + pe.sector_total - 1, 1);
        int an = get_n(cylinder);
        printf("cylinder=%d.\n", cylinder);
        printf("pe.end_head=%d.\n", pe.end_head);
        printf("an=%d.\n", an);
        pe.end_head = get_header(pe.start_sector_no + pe.sector_total - 1, an);
        cylinder    = get_cylinder(pe.start_sector_no + pe.sector_total - 1, an);
        pe.end_sector = (( cylinder & 0x3FF ) >> 2) | sector;
        pe.end_cylinder = cylinder & 0xFF;

    } else if (partition_type == 2) {
        /* ExtendedPartition */
        pe.status = 0x00;
        pe.start_sector_no = 0x3F;
        pe.sector_total = total_size / 512;
        sector = get_sector(pe.start_sector_no);
        cylinder = get_cylinder(pe.start_sector_no, 1);
        int an = get_n(cylinder);
        pe.start_head = get_header(pe.start_sector_no, an);
        pe.start_sector = (( cylinder & 0x3FF ) >> 2) | sector;
        pe.start_cylinder = cylinder & 0xFF;
        pe.type   = 0x05;
        sector = get_sector(pe.start_sector_no + pe.sector_total - 1);
        cylinder = get_cylinder(pe.start_sector_no + pe.sector_total - 1, 1);
        an = get_n(cylinder);
        pe.end_head = get_header(pe.start_sector_no + pe.sector_total - 1, an);
        pe.end_sector = get_sector(pe.start_sector_no + pe.sector_total - 1);
        pe.end_cylinder = cylinder & 0xFF;

    } else if (partition_type == 3) {
        /* LogicalPartition */
        pe.status = 0x00;
        pe.start_sector_no = 0x3F;
        pe.sector_total = total_size / 512;
        sector = get_sector(pe.start_sector_no);
        cylinder = get_cylinder(pe.start_sector_no, 1);
        int an = get_n(cylinder);
        pe.start_head = get_header(pe.start_sector_no, an);
        pe.start_sector = (( cylinder & 0x3FF ) >> 2) | sector;
        pe.start_cylinder = cylinder & 0xFF;
        pe.type   = 0x06; /* DOS 3.31 FAT16 */
        if (memcmp(file_sys, "fat32", 5) == 0) {
            pe.type   = 0x0C;
        }
        sector = get_sector(pe.start_sector_no + pe.sector_total - 1);
        cylinder = get_cylinder(pe.start_sector_no + pe.sector_total - 1, 1);
        an = get_n(cylinder);
        pe.end_head = get_header(pe.start_sector_no + pe.sector_total - 1, an);
        pe.end_sector = get_sector(pe.start_sector_no + pe.sector_total - 1);
        pe.end_cylinder = cylinder & 0xFF;

    } else {
        goto err_create_partition;
    }
    print_partition_entry(&pe);
    printf("mbr:%s.\n", mbrfile);
    FILE * pMbrFile = fopen(mbrfile, "rb");
    if (pMbrFile == NULL) {
        printf("file oepn error.\n");
        goto err_create_partition;
    }
    readedcnt = fread(buf, sizeof(char), 446, pMbrFile);
    if (readedcnt != 446) {
        fprintf(stderr, "read mbr error(%d != %d).\n", readedcnt, 446);
        goto err_create_partition;
    }
    if (pMbrFile != NULL) {
        fclose(pMbrFile);
        pMbrFile = NULL;
    }
    memcpy(buf + 446, &pe, sizeof(pe));
    memset(buf + 462, 0, 48);
    buf[510]= 0x55;
    buf[511]= 0xAA;
    if (write_qcow2(qcow2File, pFile, 0, buf, sizeof(buf)) != 0) {
        returnCode = 1;
        goto err_create_partition;
    }

    print_qcow2_file(qcow2File);

    /* Write Header */
    write_header(qcow2File, pFile);


    /* 输出表1 */
    debug_print_table_64(qcow2File->pL1Table, l1_size);

    write_l1(qcow2File, pFile);

    /* 引用计数表 */
    if (fseek(pFile, refcount_table_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", refcount_table_offset);
        goto err_create_partition;
    }
    for(idx = 0; idx < refcount_table_cnt; idx ++) {
        *(qcow2File->pRefcountTable + idx) = cpu_to_be64(*(qcow2File->pRefcountTable + idx));
    }
    writecnt = fwrite(qcow2File->pRefcountTable, sizeof(uint64_t), refcount_table_cnt, pFile);
    if (writecnt != refcount_table_cnt) {
        printf("file write error(%d != %d).\n", writecnt, refcount_table_cnt);
        goto err_create_partition;
    }

    /* 引用计数块 */
    if (fseek(pFile, ref_count_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", ref_count_offset);
        goto err_create_partition;
    }
    for(idx = 0; idx < refcount_cnt; idx ++) {
        *(qcow2File->pRefcountBlock + idx) = cpu_to_be16(*(qcow2File->pRefcountBlock + idx));
    }
    writecnt = fwrite(qcow2File->pRefcountBlock, sizeof(uint16_t), refcount_cnt, pFile);
    if (writecnt != refcount_cnt) {
        printf("file write error(%d != %d).\n", writecnt, refcount_cnt);
        goto err_create_partition;
    }

    // /* 输出表2 */
    // memcpy(&l1_item, qcow2File->pL1Table, sizeof(l1_item));
    // printf("L2 OFFSET:%llu,%X.\n", l1_item, l1_item);
    // l1_item = be64_to_cpu(l1_item);
    // l1_item = l1_item & 0x3FFFFFFFFFFFFFFF;
    // printf("L2 OFFSET:%llu,%X.\n", l1_item, l1_item);
    // if (fseek(pFile, l1_item, SEEK_SET)) {
    //     printf("fseek error(%lld).\n", refcount_table_offset);
    //     goto err_create_partition;
    // }
    // l2_size = qcow2File->l2_size;
    // printf("L2 size:%d.\n", l2_size);
    // debug_print_table_64(qcow2File->pL2Table, l2_size);
    // for(idx = 0; idx < l2_size; idx ++) {
    //     l1_item = *(qcow2File->pL2Table + idx);
    //     if (l1_item != 0LL) {
    //         l1_item += (1LL << 63);
    //         *(qcow2File->pL2Table + idx) = cpu_to_be64(l1_item);
    //     }
    // }
    // debug_print_table_64(qcow2File->pL2Table, l2_size);
    // writecnt = fwrite(qcow2File->pL2Table, sizeof(uint64_t), l2_size, pFile);
    // if (writecnt != l2_size) {
    //     printf("file write error(%d != %d).\n", writecnt, l2_size);
    //     goto err_create_partition;
    // }
    // printf("引用计数块大小:%d.\n", refcount_cnt);

    fseek(pFile, 0, SEEK_END);
    int pos = ftell(pFile);
    printf("pos=%d.\n", pos);
    int size = pos % 4096;
    size = 4096 - size;
    printf("size=%d.\n", size);
    char dummy[4096];
    //dummy[0] = 0;
    memset(dummy, 0, sizeof(dummy));
    fwrite(dummy, sizeof(char), size, pFile);

    goto end_create_partition;
err_create_partition:
    printf("create_partition is abend!!!.\n");
end_create_partition:
    /* 处理结束 */
    printf("----- create_partition end -----<<\n");
    printf("create_partition is normal end.\n");
    if (pe_table != NULL) {
        free(pe_table);
        pe_table = NULL;
    }
    if (qcow2File != NULL) {
        if (qcow2File->pHeader != NULL) {
            free(qcow2File->pHeader); qcow2File->pHeader = NULL;
        }
        if (qcow2File->pL1Table) {
            free(qcow2File->pL1Table);
            qcow2File->pL1Table = NULL;
        }
        if (qcow2File->pRefcountTable) {
            free(qcow2File->pRefcountTable);
            qcow2File->pRefcountTable = NULL;
        }
        if (qcow2File->pRefcountBlock) {
            free(qcow2File->pRefcountBlock);
            qcow2File->pRefcountBlock = NULL;
        }
        if (qcow2File->pL2Table) {
            free(qcow2File->pL2Table);
            qcow2File->pL2Table = NULL;
        }
        free(qcow2File); qcow2File = NULL;
    }
    if (pFile != NULL) { fclose(pFile); pFile = NULL; }
    return 0;
}
int delete_partition(const char * filename, int partition_no) {
    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    printf("file=%s.\n", filename);
    goto end_delete_partition;
err_delete_partition:
end_delete_partition:
    /* 处理结束 */
    return 0;
}

int format_partition(const char * filename, int parttion_no, const char * fmt, const char * vbr_file_name) {
    /* 变量定义 */
    int returnCode;
    PartitionEntry pe;
    int sector;
    int cylinder;
    char buf[512];
    uint32_t max_sector_cnt = 0;// total_size / 512;
    uint32_t sector_no;
    int idx = 0;
    QCOW2_FILE * qcow2File;
    FILE * pFile;
    uint32_t cluster_bits;
    int cluster_size;
    size_t      readedcnt;
    uint64_t l1_item;
    uint64_t l1_table_offset;
    uint64_t refcount_table_offset;
    uint32_t l1_size;
    uint32_t refcount_table_cnt;
    uint64_t ref_table_item;
    uint64_t ref_count_offset;
    uint32_t refcount_cnt = 0;
    uint16_t ref_item = -1;
    uint32_t   l2_size = 0;
    PartitionEntryItem * pe_table = NULL;
    PartitionEntryItem cur_pe;
    float partition_size;
    int file_system_index;
    int sector_per_cluster;
    uint8_t bpb_SectorsPerCluster;
    VBRFAT1216 vbrfat1216;
    VBRFAT32 vbrfat32;
    uint32_t * pfat;
    char * fat_buf;
    char * root_dir;
    size_t root_dir_size;

    /* 变量初始化 */
    returnCode = 0;
    qcow2File = NULL;
    pFile = NULL;
    l1_item = 0LL;
    bpb_SectorsPerCluster = 0;
    pfat = NULL;
    fat_buf = NULL;
    root_dir = NULL;
    memset(buf, 0xF6, sizeof(buf));

    /* 处理开始 */
    printf(">>----- format_partition begin -----\n");
    printf("file:%s.\n", filename);
    printf("parttion_no:%d.\n", parttion_no);
    printf("filesystem:%s.\n", fmt);

    /* 从分区表中获取分区信息。 */
    pFile = fopen(filename, "r+b");
    if (pFile == NULL) {
        fprintf(stderr, "file(%s) open error(1).", filename);
        returnCode = 1; goto end_format_partition;
    }
    qcow2File = (QCOW2_FILE *) malloc(sizeof(QCOW2_FILE));
    if (qcow2File == NULL) {
        fprintf(stderr, "QCOW2 file alloc error.\n");
        returnCode = 1; goto end_format_partition;
    }
    memset(qcow2File, 0, sizeof(QCOW2_FILE));
    if (read_qcow2(pFile, qcow2File) < 0) {
        printf("format_partition:qcow2 image file read error.\n");
         returnCode = 1; goto end_format_partition;
    }
    print_qcow2_file(qcow2File);
    print_qcow2(qcow2File);

    /* Partition */
    printf(">>----- Partition Table -----\n");
    printf("L2 Table offset=%lld, 0X%X.\n", l1_item, l1_item);
    pe_table = print_partition_table_64(qcow2File->pL1Table, qcow2File->l1_size, qcow2File->pL2Table, qcow2File->l2_size, pFile, qcow2File->clustor_size);
    print_list(pe_table);
    printf("----- Partition Table -----<<\n");
    printf("\n");

    /* TODO: check partition_no in range */
    memcpy(&cur_pe, pe_table + parttion_no - 1, sizeof(cur_pe));
    print_partition_entry(&(cur_pe.pe));
    printf("分区的起始扇区LBA号%d.\n", cur_pe.sector_index);




    printf("\n\n\n***从这开始输出***.\n\n\n");


    /* 计算簇大小 */
    partition_size = get_partition_size(&(cur_pe.pe));
    if (memcmp("auto_", fmt, 5) == 0) {
        if (partition_size < 16.0 ) {
            file_system_index = 12;
        } else if (partition_size < 512.0) {
            file_system_index = 16;
        } else {
            file_system_index = 32;
        }
    }
    if (memcmp("fat12", fmt, 5) == 0) {
        file_system_index = 12;
    }
    if (memcmp("fat16", fmt, 5) == 0) {
        file_system_index = 16;
    }
    if (memcmp("fat32", fmt, 5) == 0) {
        file_system_index = 32;
    }
    sector_per_cluster = get_sector_per_cluster(partition_size, file_system_index);
    printf("计算出的簇大小：sector_per_cluster=%d.\n", sector_per_cluster);
    if (sector_per_cluster < 127 && sector_per_cluster > 0) {
        bpb_SectorsPerCluster = (uint8_t) sector_per_cluster;
    }
    if (bpb_SectorsPerCluster <= 0) {
        /* error*/
        goto err_format_partition;
    }

    /* 计算FAT的大小 */
    printf("分区大小：%d.\n", cur_pe.pe.sector_total);
    printf("  簇大小：%d扇区/簇.\n", bpb_SectorsPerCluster);
    int fat_size = cur_pe.pe.sector_total / bpb_SectorsPerCluster;
    if (cur_pe.pe.sector_total % bpb_SectorsPerCluster != 0) {
        fat_size ++;
    }
    printf("FAT 大小%d.\n", fat_size);
    uint16_t bpb_SectorsPerFAT = 0;
    if (file_system_index == 12) {
        bpb_SectorsPerFAT = (fat_size * 3) / 1024;
        if ((fat_size * 3) % 1024 != 0) {
            bpb_SectorsPerFAT ++;
        }
    }
    if (file_system_index == 16) {
        bpb_SectorsPerFAT = (fat_size * 2) / 512;
        if ((fat_size * 2) % 512 != 0) {
            bpb_SectorsPerFAT ++;
        }
    }
    if (file_system_index == 32) {
        bpb_SectorsPerFAT = (fat_size * 4) / 512;
        if ((fat_size * 4) % 512 != 0) {
            bpb_SectorsPerFAT ++;
        }
    }
    printf("每个FAT的扇区数量%d.\n", bpb_SectorsPerFAT);

    pfat = (uint32_t *) malloc(fat_size * sizeof(uint32_t));
    if (pfat == NULL) {
        printf("FAT memory alloc error.\n");
        goto err_format_partition;
    }
    memset(pfat, 0, fat_size * sizeof(uint32_t));
    *(pfat) = 0XFFFFFFF8;
    *(pfat + 1) = 0XFFFFFFFF;

    /* 创建引导扇区 */
    if (file_system_index == 12 || file_system_index == 16) {
        printf("写入引导扇区开始。\n");
        memset(&vbrfat1216, 0, sizeof(vbrfat1216));
        FILE * vbr_file = fopen(vbr_file_name, "r+b");
        if (vbr_file == NULL) {
            printf("[%s] not exist.\n", vbr_file_name);
            returnCode = 1;
            goto err_format_partition;
        }
        fread(&vbrfat1216, 1, 512, vbr_file);
        fclose(vbr_file);
        vbrfat1216.bpb.bpb_BytesPerSector = 512;
        vbrfat1216.bpb.bpb_SectorsPerCluster = bpb_SectorsPerCluster;
        vbrfat1216.bpb.bpb_ReservedSectorst = 1;
        vbrfat1216.bpb.bpb_FatCopies = 2;
        vbrfat1216.bpb.bpb_RootDirEntries = 512; // TODO:
        vbrfat1216.bpb.bpb_NumSectors = (uint16_t) cur_pe.pe.sector_total;
        vbrfat1216.bpb.bpb_MediaType = (uint8_t) *(pfat);
        vbrfat1216.bpb.bpb_SectorsPerFAT = bpb_SectorsPerFAT;
        vbrfat1216.bpb.bpb_SectorsPerTrack = 63;
        vbrfat1216.bpb.bpb_NumberOfHeads = 16; // TODO:
        vbrfat1216.bpb.bpb_HiddenSectors = 63; // TODO:
        vbrfat1216.bpb.bpb_SectorsBig = 0; // TODO:
        vbrfat1216.bs_DrvNum = 128; // TODO:
        vbrfat1216.bs_Bootsig = 41; // TODO:
        memset(vbrfat1216.bs_FileSysType, 0x20, sizeof(8));
        memcpy(vbrfat1216.bs_FileSysType, "FAT12", 5);
        if (file_system_index == 16) {
            memcpy(vbrfat1216.bs_FileSysType, "FAT16", 5);
        }
        print_vbr_fat_1216(&vbrfat1216);
        if (write_qcow2(qcow2File, pFile, cur_pe.sector_index + 63, &vbrfat1216, sizeof(vbrfat1216)) != 0) {
            printf("向镜像文件中写入引导扇区错误.\n");
            returnCode = 1; goto err_format_partition; }
        printf("写入引导扇区结束。\n");

        /* 根目录 */
        printf("写入根目录开始。\n");
        root_dir_size = sizeof(DIRENT) * vbrfat1216.bpb.bpb_RootDirEntries;
        root_dir = (char *) malloc(root_dir_size);
        if (root_dir == NULL) { printf("mempry alloc erro for root dir.\n"); returnCode = 1; goto end_format_partition;}
        memset(root_dir, 0, root_dir_size);
        if (write_qcow2(qcow2File, pFile, cur_pe.sector_index + 64 + bpb_SectorsPerFAT + bpb_SectorsPerFAT, root_dir, root_dir_size) != 0) {
            returnCode = 1; goto err_format_partition; }
        free(root_dir);
        root_dir = NULL;
        printf("写入根目录结束。\n");

        /* FAT表1 */
        printf("写入FAT1开始。\n");
        printf("pfat=%X.\n", pfat);
        printf("fat_size=%d.\n", fat_size);
        printf("bpb_SectorsPerFAT=%d.\n", bpb_SectorsPerFAT);
        printf("file_system_index=%d.\n", file_system_index);
        //fat_buf = (char *) malloc(bpb_SectorsPerFAT * 512);
        //memset(fat_buf, 0, bpb_SectorsPerFAT * 512);
        // make_fat(pfat, fat_size, bpb_SectorsPerFAT, file_system_index, fat_buf);
        fat_buf = make_fat(pfat, fat_size, bpb_SectorsPerFAT, file_system_index, fat_buf);
        if (fat_buf == NULL) { printf("make_fat error.\n"); returnCode = 1; goto end_format_partition;}
        // printf("\n\n\n-----------------------------------------\n\n\n");
        // print_ary(fat_buf, 512);
        // printf("\n\n\n-----------------------------------------\n\n\n");
        if (write_qcow2(qcow2File, pFile, cur_pe.sector_index + 64, fat_buf, bpb_SectorsPerFAT * 512) != 0) {
            returnCode = 1; goto err_format_partition; }
        printf("写入FAT1结束。\n");

        /* FAT表2 */
        printf("写入FAT2开始。\n");
        if (write_qcow2(qcow2File, pFile, cur_pe.sector_index + 64 + bpb_SectorsPerFAT, fat_buf, bpb_SectorsPerFAT * 512) != 0) {
            returnCode = 1; goto err_format_partition; }
        printf("写入FAT2结束。\n");

    }
    if (file_system_index == 32) {
        memset(&vbrfat32, 0, sizeof(vbrfat32));
        vbrfat32.bpb.bpb_SectorsPerCluster = bpb_SectorsPerCluster;
        memset(vbrfat32.bs_FileSysType, 0x20, sizeof(8));
        memcpy(vbrfat32.bs_FileSysType, "FAT32", 5);
        print_vbr_fat_32(&vbrfat32);
        /* FAT表1 */
        /* FAT表2 */
        /* 计算FAT表大小 */

        /* 根目录？ */

    }

    /* Write Header */
    printf("输出头 begin.\n");
    write_header(qcow2File, pFile);
    printf("输出头 end.\n");


    /* 输出表1 */
    printf("输出表1 begin.\n");
    write_l1(qcow2File, pFile);
    printf("输出表1 end.\n");

    /* 引用计数表 */
    printf("输出计数表 begin.\n");
    ref_count_offset = *(qcow2File->pRefcountTable);
    if (fseek(pFile, qcow2File->pHeader->refcount_table_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n",qcow2File->pHeader->refcount_table_offset);
        goto err_format_partition;
    }
    for(idx = 0; idx < qcow2File->refcount_table_cnt; idx ++) {
        *(qcow2File->pRefcountTable + idx) = cpu_to_be64(*(qcow2File->pRefcountTable + idx));
    }
    int writecnt = fwrite(qcow2File->pRefcountTable, sizeof(uint64_t), qcow2File->refcount_table_cnt, pFile);
    if (writecnt != qcow2File->refcount_table_cnt) {
        printf("file write error(%d != %d).\n", writecnt, qcow2File->refcount_table_cnt);
        goto err_format_partition;
    }
    printf("输出计数表 end.\n");

    /* 引用计数块 */
    printf("输出计数块 begin.\n");
    printf("%lld.%X.\n", ref_count_offset, ref_count_offset);
    if (fseek(pFile, ref_count_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", ref_count_offset);
        goto err_format_partition;
    }
    for(idx = 0; idx < qcow2File->refcount_cnt; idx ++) {
        *(qcow2File->pRefcountBlock + idx) = cpu_to_be16(*(qcow2File->pRefcountBlock + idx));
    }
    writecnt = fwrite(qcow2File->pRefcountBlock, sizeof(uint16_t), qcow2File->refcount_cnt, pFile);
    if (writecnt != qcow2File->refcount_cnt) {
        printf("file write error(%d != %d).\n", writecnt, qcow2File->refcount_cnt);
        goto err_format_partition;
    }
    printf("输出计数块 end.\n");

    goto end_format_partition;
err_format_partition:
    printf("format_partition is abend!!!.\n");
end_format_partition:
    /* 处理结束 */
    printf("format_partition is normal end.\n");
    printf("----- format_partition end -----<<\n");
    if (root_dir != NULL) { free(root_dir); root_dir = NULL; }
    if (fat_buf != NULL) { free(fat_buf); fat_buf = NULL; }
    if (pfat != NULL) {    free(pfat); pfat = NULL; }
    if (pe_table != NULL) {
        free(pe_table);
        pe_table = NULL;
    }
    if (qcow2File != NULL) {
        if (qcow2File->pHeader != NULL) {
            free(qcow2File->pHeader); qcow2File->pHeader = NULL;
        }
        if (qcow2File->pL1Table) {
            free(qcow2File->pL1Table);
            qcow2File->pL1Table = NULL;
        }
        if (qcow2File->pRefcountTable) {
            free(qcow2File->pRefcountTable);
            qcow2File->pRefcountTable = NULL;
        }
        if (qcow2File->pRefcountBlock) {
            free(qcow2File->pRefcountBlock);
            qcow2File->pRefcountBlock = NULL;
        }
        if (qcow2File->pL2Table) {
            free(qcow2File->pL2Table);
            qcow2File->pL2Table = NULL;
        }
        free(qcow2File); qcow2File = NULL;
    }
    if (pFile != NULL) { fclose(pFile); pFile = NULL; }

    return returnCode;
}

int copy_file_or_folder(const char * filename, char * dst, char * src) {
    /* 变量定义 */
    int returnCode;
    FILE * pFile;
    QCOW2_FILE * qcow2File;
    uint64_t l1_item;
    PartitionEntryItem * pe_table = NULL;
    PartitionEntryItem cur_pe;
    int parttion_no;
    DIRENT * pdirtable;
    FILE * pFileIn;
    char * fat_buf;

    /* 变量初始化 */
    returnCode = 0;
    pFileIn = NULL;
    fat_buf = NULL;

    /* 处理开始 */
    printf("filename=%s.\n", filename);
    printf("dst=%s.\n", dst);
    printf("src=%s.\n", src);

    /* get partition no */
    parttion_no = 1;

    /* 从分区表中获取分区信息。 */
    pFile = fopen(filename, "r+b");
    if (pFile == NULL) {
        fprintf(stderr, "file(%s) open error(1).", filename);
        returnCode = 1; goto err_copy_file_or_folder;
    }
    qcow2File = (QCOW2_FILE *) malloc(sizeof(QCOW2_FILE));
    if (qcow2File == NULL) {
        fprintf(stderr, "QCOW2 file alloc error.\n");
        returnCode = 1; goto err_copy_file_or_folder;
    }
    memset(qcow2File, 0, sizeof(QCOW2_FILE));
    if (read_qcow2(pFile, qcow2File) < 0) {
        printf("copy_file_or_folder:qcow2 image file read error.\n");
        returnCode = 1; goto err_copy_file_or_folder;
    }
    print_qcow2_file(qcow2File);
    print_qcow2(qcow2File);

    /* Partition */
    printf(">>----- Partition Table -----\n");
    printf("L2 Table offset=%lld, 0X%X.\n", l1_item, l1_item);
    pe_table = print_partition_table_64(qcow2File->pL1Table, qcow2File->l1_size, qcow2File->pL2Table, qcow2File->l2_size, pFile, qcow2File->clustor_size);
    print_list(pe_table);
    printf("----- Partition Table -----<<\n");
    printf("\n");

    /* TODO: check partition_no in range */
    memcpy(&cur_pe, pe_table + parttion_no - 1, sizeof(cur_pe));
    print_partition_entry(&(cur_pe.pe));
    printf("分区的起始扇区LBA号%d.\n", cur_pe.sector_index);


    /* 读取BPB */
    printf("flag=%d sector_index=%d start_sector_no=%d ", cur_pe.flag, cur_pe.sector_index, cur_pe.pe.start_sector_no);
    uint32_t sector_no = cur_pe.sector_index + cur_pe.pe.start_sector_no;
    uint32_t fat1 = sector_no;
    uint32_t fat2 = sector_no;
    uint32_t root = sector_no;
    uint32_t file = sector_no;

    printf("起始扇区号：%d (l1 =%d, l2=%d, cluster=%d), \n", sector_no, 
        get_l1_index(sector_no, 4096, 512), get_l2_index(sector_no), get_cluster_index(sector_no));
    uint64_t offset = -1;
    offset = *(qcow2File->pL2Table + get_l1_index(sector_no, 4096, 512) * 512 + get_l2_index(sector_no));
    offset += get_cluster_index(sector_no);
    printf("在镜像文件中的位置[(%lld 0X%X)-", offset, offset);
    printf("(%lld 0X%X)).\n", offset + 512, offset + 512);
    if (fseek(pFile, offset, SEEK_SET) != 0) {
        printf("fseek error.%d.\n", ferror(pFile)); goto err_copy_file_or_folder;}
    unsigned char buf[512];
    memset(buf, 0, sizeof(buf));
    int readedcnt = fread(&buf, 1, sizeof(buf), pFile);
    if (readedcnt != sizeof(buf)) {
        fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
        printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
        goto err_copy_file_or_folder;
    }
    int cluster_size = 512;
    int dir_cnt = -1;
    int fat_sector_cnt = -1;
    int fat_size = 512;
    int system_idx = 12;
    printf("启动扇区:%X, %X type:%X.\n", buf[510], buf[511], cur_pe.pe.type);
    if (cur_pe.pe.type == 0x01 || cur_pe.pe.type == 0x04 || cur_pe.pe.type == 0x06 || cur_pe.pe.type == 0x0E) {
        /* FAT16 */
        /*
         06 DOS 3.31+: 16-bit FAT (over 32M)
         0E WIN95: DOS 16-bit FAT, LBA-mapped
         */
        if( buf[510] == 0x55 && buf[511] == 0xAA) {
            print_ary(buf, sizeof(buf));
            VBRFAT1216 vbr;
            printf("size=%d.BPB:%d.uint8_t=%d.%d.%d.\n", sizeof(vbr), sizeof(BPB1216), sizeof(uint8_t), sizeof(uint16_t), sizeof(uint32_t));
            memcpy(&vbr, buf, 512);
            print_vbr_fat_1216(&vbr);

            uint16_t bpb_ReservedSectorst = vbr.bpb.bpb_ReservedSectorst;
            fat1 += bpb_ReservedSectorst;
            fat2 += bpb_ReservedSectorst;
            root += bpb_ReservedSectorst;
            file += bpb_ReservedSectorst;

            uint16_t bpb_SectorsPerFAT = vbr.bpb.bpb_SectorsPerFAT;
            fat2 += bpb_SectorsPerFAT;
            root += 2 * bpb_SectorsPerFAT;
            file += 2 * bpb_SectorsPerFAT;
            uint16_t bpb_RootDirEntries = vbr.bpb.bpb_RootDirEntries;
            dir_cnt = vbr.bpb.bpb_RootDirEntries;
            uint16_t bpb_BytesPerSector = vbr.bpb.bpb_BytesPerSector;
            file += (32 * bpb_RootDirEntries) / bpb_BytesPerSector;

            cluster_size *= vbr.bpb.bpb_SectorsPerCluster;
            fat_sector_cnt = vbr.bpb.bpb_SectorsPerFAT;
            fat_size *= vbr.bpb.bpb_SectorsPerFAT;
            if (memcmp(vbr.bs_FileSysType, "FAT12", 5) == 0 ) {
                system_idx = 12;
            }
            if (memcmp(vbr.bs_FileSysType, "FAT16", 5) == 0 ) {
                system_idx = 16;
            }
            if (memcmp(vbr.bs_FileSysType, "FAT32", 5) == 0 ) {
                system_idx = 32;
            }
        }
    }
    if (cur_pe.pe.type == 0x01) {
        /* FAT32 */
        printf("!!!警告!!!FAT32还没有实现.\n");
    }
    printf("\n");
    printf("该分区的根目录表项个数为%d.\n", dir_cnt);
    printf("该分区的文件系统为FAT%d\n", system_idx);
    printf("该分区的簇大小为%d字节\n", cluster_size);
    printf("该分区的FAT表大小为%d字节\n", fat_size);
    uint32_t * pfat = NULL;
    int pfat_cnt = -1;
    if (system_idx == 12) {
        pfat_cnt = fat_size / 2 * 3;
        pfat = (uint32_t *) malloc(pfat_cnt * sizeof(uint32_t));
    }
    if (system_idx == 16) {
        pfat_cnt = fat_size / 2;
        pfat = (uint32_t *) malloc(pfat_cnt * sizeof(uint32_t));
    }
    if (system_idx == 32) {
        pfat_cnt = fat_size / 4;
        pfat = (uint32_t *) malloc(pfat_cnt * sizeof(uint32_t));
    }
    if (pfat == NULL) {
        printf("FAT alloc error.\n");
        returnCode = 1;
        goto err_copy_file_or_folder;
    }
    memset(pfat, 0, pfat_cnt * sizeof(uint32_t));

    if( buf[510] == 0x55 && buf[511] == 0xAA) {
        /* 读取FAT1 */
        /* fat1 */
        printf("fat1=%d.(L1:%d L2:%d OFF:%d) \n", fat1, get_l1_index(fat1, 4096, 512), get_l2_index(fat1), get_cluster_index(fat1));
        offset = *(qcow2File->pL2Table + get_l1_index(fat1, 4096, 512) * 512 + get_l2_index(fat1));
        offset += get_cluster_index(fat1);
        printf("offset=%lld %X.\n", offset, offset);
        if (fseek(pFile, offset, SEEK_SET) != 0) {
            printf("fseek error.%d.\n", ferror(pFile)); goto err_copy_file_or_folder;
        }

        // fat_size;
        int idx = 0;
        int idx_pfat = 0;
        for (idx = 0; idx < fat_sector_cnt; idx ++) {
            memset(buf, 0, sizeof(buf));
            readedcnt = fread(&buf, 1, sizeof(buf), pFile);
            if (readedcnt != sizeof(buf)) {
                fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
                printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                goto err_copy_file_or_folder;
            }
            int idy = 0;
            if (system_idx == 12) {
                for (idy = 0; idy < 512; idy ++) {
                    if (idy % 3 == 0) {
                        *(pfat + idx_pfat) = buf[idy];
                    } else if (idy % 3 == 1) {
                        *(pfat + idx_pfat) = ((buf[idy] & 0x000F) << 8) | *(pfat + idx_pfat);
                        idx_pfat ++;
                        if (idx_pfat >= pfat_cnt) {
                            break;
                        }
                        *(pfat + idx_pfat) = ((buf[idy] & 0x00F0) >> 4);
                    } else if (idy % 3 == 2) {
                        *(pfat + idx_pfat) = ((buf[idy] & 0x00FF) << 4) | *(pfat + idx_pfat);
                        idx_pfat ++;
                        if (idx_pfat >= pfat_cnt) {
                            break;
                        }
                    }
                }
            }
            if (system_idx == 16) {
                // memcpy(pfat + idx_pfat, buf, readedcnt);
                // idx_pfat += 512 / 2;
                for (idy = 0; idy < 512; idy ++) {
                    if (idy % 2 == 0) {
                        *(pfat + idx_pfat) = buf[idy];
                    } else if (idy % 2 == 1) {
                        *(pfat + idx_pfat) = ((buf[idy] & 0x00FF) << 8) | *(pfat + idx_pfat);
                        idx_pfat ++;
                        if (idx_pfat >= pfat_cnt) {
                            break;
                        }
                    }
                }
            }
            if (system_idx == 32) {
                memcpy(pfat + idx_pfat, buf, readedcnt);
                idx_pfat += 512 / 4;
            }
        }
        // print_ary(buf, sizeof(buf));
        printf("\n");
        for (idx = 0; idx < pfat_cnt; idx ++) {
            printf("%X ", *(pfat + idx));
            if ((idx + 1) % 16 == 0) {
                printf("\n");
            }
        }
        printf("\n");




        /* fat2 */
        printf("fat2=%d.(L1:%d L2:%d OFF:%d) \n", fat2, get_l1_index(fat2, 4096, 512), get_l2_index(fat2), get_cluster_index(fat2));
        offset = *(qcow2File->pL2Table + get_l1_index(fat2, 4096, 512) * 512 + get_l2_index(fat2));
        offset += get_cluster_index(fat2);
        printf("offset=%lld %X.\n", offset, offset);
        if (fseek(pFile, offset, SEEK_SET) != 0) {
            printf("fseek error.%d.\n", ferror(pFile)); goto err_copy_file_or_folder;}
        memset(buf, 0, sizeof(buf));
        readedcnt = fread(&buf, 1, sizeof(buf), pFile);
        if (readedcnt != sizeof(buf)) {
            fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
            printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
            goto err_copy_file_or_folder;
        }
        print_ary(buf, sizeof(buf));
        printf("\n");

        /* 获取RootDir */
        /* Rootdir */
        printf("root dir's 1 setcot.\n");
        printf("root=%d.(L1:%d L2:%d OFF:%d) \n", root, get_l1_index(root, 4096, 512), get_l2_index(root), get_cluster_index(root));
        offset = *(qcow2File->pL2Table + get_l1_index(root, 4096, 512) * 512 + get_l2_index(root));
        offset += get_cluster_index(root);
        printf("offset=%lld %X.\n", offset, offset);
        if (fseek(pFile, offset, SEEK_SET) != 0) {
            printf("fseek error.%d.\n", ferror(pFile)); goto err_copy_file_or_folder;
        }

        pdirtable = NULL;
        pdirtable = (DIRENT *) malloc(sizeof(DIRENT) * dir_cnt);
        if (pdirtable == NULL) {
            printf("Rootdir alloc error.\n");
            returnCode = 1;
            goto err_copy_file_or_folder;
        }
        memset(pdirtable, 0, sizeof(DIRENT) * dir_cnt);

        int dir_idx = 0;
        while(dir_idx < dir_cnt) {
            memset(buf, 0, sizeof(buf));
            readedcnt = fread(&buf, 1, sizeof(buf), pFile);
            if (readedcnt != sizeof(buf)) {
                fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
                printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                goto err_copy_file_or_folder;
            }
            // print_ary(buf, sizeof(buf));
            print_fdt((char *) buf, sizeof(buf));
            memcpy(pdirtable + dir_idx, buf, readedcnt);
            dir_idx = dir_idx + readedcnt / sizeof(DIRENT);
        }
        printf("\n");

        /* 创建RootDir */
        printf("dir_cnt=%d.\n", dir_cnt);
        for (dir_idx = 0; dir_idx < dir_cnt; dir_idx += 1) {
            if (strlen((char *)(pdirtable + dir_idx)->fileName) == 0){
                printf("dir_idx=%d.@break\n", dir_idx);
                break;
            }
        }
        printf("dir_idx=%d.\n", dir_idx);
        DIRENT cur_file;
        memset(&cur_file, 0, sizeof(DIRENT));

        /* 向目录项中写入文件名和扩展名 */
        int ilen = strlen(dst);
        int ipos = ilen - 1;
        int iend = ilen;
        printf("dst=%s.\n", dst);
        printf("src=%s.\n", src);
        printf("len=%d.\n", ilen);
        printf("end=%d.\n", iend);
        printf("pos=%d.\n", ipos);
        while (ipos >= 0) {
            if (*(dst + ipos) == '.') {
                printf("%d.\n", ilen - ipos);
                memcpy(cur_file.fileExtension, dst + ipos + 1, 3);
                iend = ipos;
            }
            if (*(dst + ipos) == '\\' || *(dst + ipos) == '/' ) {
                printf("%d.\n", iend - ipos);
                memset(cur_file.fileName, 0x20, 8);
                memcpy(cur_file.fileName, dst + ipos + 1, iend - ipos - 1);
                break;
            }
            if (ilen - ipos > 12) {
                break;
            }
            ipos --;
        }
        /* 向目录项中写入属性字节 */
        cur_file.fileAttrube[0] = 0x20;


        /* 向目录项中写入文件的起始簇号 */
        /* search fat*/
        for (idx_pfat = 0; idx_pfat < pfat_cnt; idx_pfat ++) {
            if (*(pfat + idx_pfat) == 0x00) {
                break ;
            }
        }
        if (idx_pfat == pfat_cnt) {
            printf("没有空间了.n");
            returnCode = 1;
            goto err_copy_file_or_folder;
        }
        uint16_t startcluster = (uint16_t) idx_pfat;
        memcpy(cur_file.startClusters, &startcluster, sizeof(uint16_t));

        /* 向目录项中写入文件大小 */
        pFileIn = fopen(src, "rb");
        if (pFileIn == NULL) {
            printf("copy src open error.\n");
            returnCode = 1;
            goto err_copy_file_or_folder;
        }
        if (fseek(pFileIn, 0, SEEK_END) != 0) {
            printf("copy src seek error.\n");
            returnCode = 1;
            goto err_copy_file_or_folder;
        }
        int src_file_size = ftell(pFileIn);
        rewind(pFileIn);
        memcpy(cur_file.fileSize, &src_file_size, sizeof(uint32_t));

        print_dirt(&cur_file);
        // print_fdt(pdirtable, dir_cnt);
        printf("dir_idx=%d.\n", dir_idx);
        memcpy(pdirtable + dir_idx, &cur_file ,sizeof(DIRENT));
        // print_fdt(pdirtable, dir_cnt);

        /* 写入目录表 */
        printf("写入目录表...开始\n");
        write_qcow2(qcow2File, pFile, root, pdirtable, sizeof(DIRENT) * dir_cnt);
        printf("写入目录表...结束\n");

        /* 按照簇  扇区单位写入文件 */
        int cluster_cnt = src_file_size / cluster_size;
        if (src_file_size % cluster_size != 0) {
            cluster_cnt ++;
        }
        int cluster_idx = 1;
        for (idx_pfat = 0; idx_pfat < pfat_cnt && cluster_idx <= cluster_cnt; idx_pfat ++) {
            if (*(pfat + idx_pfat) == 0x00) {
                cluster_idx ++;
                continue ;
            }
        }
        if (cluster_idx < cluster_cnt) {
            printf("没有空间了.n");
            returnCode = 1;
            goto err_copy_file_or_folder;
        }

        sector_no = root + 32;
        printf("扇区编号为:%d,%d.\n", sector_no, file);
        int sector_cluster = cluster_size / 512;
        sector_no = file + (startcluster - 2) * sector_cluster;
        printf("文件的起始扇区编号为:%d,%d,共占用%d个簇.\n", sector_no, file, cluster_cnt);

        int write_count = 0;
        uint16_t cur_cluster_no = startcluster;
        while(!feof(pFileIn)) {
            memset(buf, 0, sizeof(buf));
            readedcnt = fread(&buf, 1, sizeof(buf), pFileIn);
            // if (readedcnt != sizeof(buf)) {
            //     fprintf(stderr, "read src file error[%d][%X].\n", ftell(pFileIn), ftell(pFileIn));
            //     printf("[%d][%d][%X].\n", ferror(pFileIn), ftell(pFileIn), ftell(pFileIn));
            //     returnCode = 1;
            //     goto err_copy_file_or_folder;
            // }
            write_qcow2(qcow2File, pFile, sector_no, buf, sizeof(buf));
            if ((write_count > 0) && (write_count % sector_cluster == 0) ) {
                for (idx_pfat = cur_cluster_no + 1; idx_pfat < pfat_cnt; idx_pfat ++) {
                    if (*(pfat + idx_pfat) == 0x00) {
                        /* 更新FAT表 */
                        *(pfat + cur_cluster_no) = idx_pfat;
                        cur_cluster_no = (uint16_t) idx_pfat;
                        break ;
                    }
                }
            }
            sector_no ++;
            write_count ++;
        }
        *(pfat + cur_cluster_no) = 0xFFFFFFFF;
        /* 写入FAT1,FAT2 */
        printf("文件系统FAT%d.扇区数量%d.\n", system_idx, fat_sector_cnt);
        fat_buf = make_fat(pfat, pfat_cnt, fat_sector_cnt, system_idx, fat_buf);
        if (fat_buf == NULL) { printf("make_fat error.\n"); returnCode = 1; goto err_copy_file_or_folder;}
        write_qcow2(qcow2File, pFile, fat1, fat_buf, fat_sector_cnt * 512);
        write_qcow2(qcow2File, pFile, fat2, fat_buf, fat_sector_cnt * 512);


        /* File */
        printf("first file's 1 sector.\n");
        printf("file=%d.(L1:%d L2:%d OFF:%d) \n", file, get_l1_index(file, 4096, 512), get_l2_index(file), get_cluster_index(file));
        offset = *(qcow2File->pL2Table + get_l1_index(file, 4096, 512) * 512 + get_l2_index(file));
        offset += get_cluster_index(file);
        printf("offset=%lld %X.\n", offset, offset);
        if (fseek(pFile, offset, SEEK_SET) != 0) {
            printf("fseek error.%d.\n", ferror(pFile)); goto err_copy_file_or_folder;}
        memset(buf, 0, sizeof(buf));
        readedcnt = fread(&buf, 1, sizeof(buf), pFile);
        if (readedcnt != sizeof(buf)) {
            fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
            printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
            goto err_copy_file_or_folder;
        }
        print_ary(buf, sizeof(buf));
        printf("\n");
    }


    /* 更新QCOW2文件 */
    /* Write Header */
    printf("输出头 begin.\n");
    write_header(qcow2File, pFile);
    printf("输出头 end.\n");

    /* 输出表1 */
    printf("输出表1 begin.\n");
    write_l1(qcow2File, pFile);
    printf("输出表1 end.\n");

    /* 引用计数表 */
    printf("输出计数表 begin.\n");
    uint64_t ref_count_offset = *(qcow2File->pRefcountTable);
    if (fseek(pFile, qcow2File->pHeader->refcount_table_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n",qcow2File->pHeader->refcount_table_offset);
        goto err_copy_file_or_folder;
    }
    int idx = 0;
    for(idx = 0; idx < qcow2File->refcount_table_cnt; idx ++) {
        *(qcow2File->pRefcountTable + idx) = cpu_to_be64(*(qcow2File->pRefcountTable + idx));
    }
    int writecnt = fwrite(qcow2File->pRefcountTable, sizeof(uint64_t), qcow2File->refcount_table_cnt, pFile);
    if (writecnt != qcow2File->refcount_table_cnt) {
        printf("file write error(%d != %d).\n", writecnt, qcow2File->refcount_table_cnt);
        goto err_copy_file_or_folder;
    }
    printf("输出计数表 end.\n");

    /* 引用计数块 */
    printf("输出计数块 begin.\n");
    printf("%lld.%X.\n", ref_count_offset, ref_count_offset);
    if (fseek(pFile, ref_count_offset, SEEK_SET)) {
        printf("fseek error(%lld).\n", ref_count_offset);
        goto err_copy_file_or_folder;
    }
    for(idx = 0; idx < qcow2File->refcount_cnt; idx ++) {
        *(qcow2File->pRefcountBlock + idx) = cpu_to_be16(*(qcow2File->pRefcountBlock + idx));
    }
    writecnt = fwrite(qcow2File->pRefcountBlock, sizeof(uint16_t), qcow2File->refcount_cnt, pFile);
    if (writecnt != qcow2File->refcount_cnt) {
        printf("file write error(%d != %d).\n", writecnt, qcow2File->refcount_cnt);
        goto err_copy_file_or_folder;
    }
    printf("输出计数块 end.\n");

    fseek(pFile, 0, SEEK_END);
    int pos = ftell(pFile);
    printf("pos=%d.\n", pos);
    int size = pos % 4096;
    size = 4096 - size;
    printf("size=%d.\n", size);
    char dummy[4096];
    //dummy[0] = 0;
    memset(dummy, 0, sizeof(dummy));
    fwrite(dummy, sizeof(char), size, pFile);

    goto end_copy_file_or_folder;
err_copy_file_or_folder:
end_copy_file_or_folder:
    /* 处理结束 */
    if (fat_buf != NULL) { free(fat_buf); fat_buf = NULL; }
    if (pFileIn != NULL) { fclose(pFileIn); pFileIn = NULL; }
    if (pdirtable != NULL) { free(pdirtable); pdirtable = NULL; }
    if (pfat != NULL) { free(pfat); pfat = NULL; }
    return returnCode;
}

int read_file_or_folder(const char * filename, char * dst, char * src) {
    /* 变量定义 */
    int returnCode;
    FILE * pFile;
    QCOW2_FILE * qcow2File;
    uint64_t l1_item;
    PartitionEntryItem * pe_table = NULL;
    PartitionEntryItem cur_pe;
    int parttion_no;
    DIRENT * pdirtable;
    FILE * pFileIn;

    /* 变量初始化 */
    returnCode = 0;
    pFileIn = NULL;

    /* 处理开始 */
    printf("read img to local.\n");
    printf("filename=%s.\n", filename);
    printf("dst=%s.\n", dst);
    printf("src=%s.\n", src);

    /* get partition no */
    parttion_no = 1;

    /* 从分区表中获取分区信息。 */
    pFile = fopen(filename, "r+b");
    if (pFile == NULL) {
        printf("file(%s) open error(1).", filename);
        returnCode = 1; goto err_read_file_or_folder;
    }
    qcow2File = (QCOW2_FILE *) malloc(sizeof(QCOW2_FILE));
    if (qcow2File == NULL) {
        printf("QCOW2 file alloc error.\n");
        returnCode = 1; goto err_read_file_or_folder;
    }
    memset(qcow2File, 0, sizeof(QCOW2_FILE));
    if (read_qcow2(pFile, qcow2File) < 0) {
        printf("read_file_or_folder:qcow2 image file read error.\n");
        returnCode = 1; goto err_read_file_or_folder;
    }
    print_qcow2_file(qcow2File);
    print_qcow2(qcow2File);

    /* Partition */
    printf(">>----- Partition Table -----\n");
    printf("L2 Table offset=%lld, 0X%X.\n", l1_item, l1_item);
    pe_table = print_partition_table_64(qcow2File->pL1Table, qcow2File->l1_size, qcow2File->pL2Table, qcow2File->l2_size, pFile, qcow2File->clustor_size);
    print_list(pe_table);
    printf("----- Partition Table -----<<\n");
    printf("\n");

    /* TODO: check partition_no in range */
    memcpy(&cur_pe, pe_table + parttion_no - 1, sizeof(cur_pe));
    print_partition_entry(&(cur_pe.pe));
    printf("分区的起始扇区LBA号%d.\n", cur_pe.sector_index);


    /* 读取BPB */
    printf("flag=%d sector_index=%d start_sector_no=%d ", cur_pe.flag, cur_pe.sector_index, cur_pe.pe.start_sector_no);
    uint32_t sector_no = cur_pe.sector_index + cur_pe.pe.start_sector_no;
    uint32_t fat1 = sector_no;
    uint32_t fat2 = sector_no;
    uint32_t root = sector_no;
    uint32_t file = sector_no;

    printf("起始扇区号：%d (l1 =%d, l2=%d, cluster=%d), \n", sector_no, 
        get_l1_index(sector_no, 4096, 512), get_l2_index(sector_no), get_cluster_index(sector_no));
    uint64_t offset = -1;
    offset = *(qcow2File->pL2Table + get_l1_index(sector_no, 4096, 512) * 512 + get_l2_index(sector_no));
    offset += get_cluster_index(sector_no);
    printf("在镜像文件中的位置[(%lld 0X%X)-", offset, offset);
    printf("(%lld 0X%X)).\n", offset + 512, offset + 512);
    if (fseek(pFile, offset, SEEK_SET) != 0) {
        printf("fseek error.%d.\n", ferror(pFile)); goto err_read_file_or_folder;}
    unsigned char buf[512];
    memset(buf, 0, sizeof(buf));
    int readedcnt = fread(&buf, 1, sizeof(buf), pFile);
    if (readedcnt != sizeof(buf)) {
        fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
        printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
        goto err_read_file_or_folder;
    }
    int cluster_size = 512;
    int dir_cnt = -1;
    int fat_sector_cnt = -1;
    int fat_size = 512;
    int system_idx = 12;
    printf("启动扇区:%X, %X type:%X.\n", buf[510], buf[511], cur_pe.pe.type);
    if (cur_pe.pe.type == 0x01 || cur_pe.pe.type == 0x06 || cur_pe.pe.type == 0x0E) {
        /* FAT16 */
        /*
         06 DOS 3.31+: 16-bit FAT (over 32M)
         0E WIN95: DOS 16-bit FAT, LBA-mapped
         */
        if( buf[510] == 0x55 && buf[511] == 0xAA) {
            print_ary(buf, sizeof(buf));
            VBRFAT1216 vbr;
            printf("size=%d.BPB:%d.uint8_t=%d.%d.%d.\n", sizeof(vbr), sizeof(BPB1216), sizeof(uint8_t), sizeof(uint16_t), sizeof(uint32_t));
            memcpy(&vbr, buf, 512);
            print_vbr_fat_1216(&vbr);

            uint16_t bpb_ReservedSectorst = vbr.bpb.bpb_ReservedSectorst;
            fat1 += bpb_ReservedSectorst;
            fat2 += bpb_ReservedSectorst;
            root += bpb_ReservedSectorst;
            file += bpb_ReservedSectorst;

            uint16_t bpb_SectorsPerFAT = vbr.bpb.bpb_SectorsPerFAT;
            fat2 += bpb_SectorsPerFAT;
            root += 2 * bpb_SectorsPerFAT;
            file += 2 * bpb_SectorsPerFAT;
            uint16_t bpb_RootDirEntries = vbr.bpb.bpb_RootDirEntries;
            dir_cnt = vbr.bpb.bpb_RootDirEntries;
            uint16_t bpb_BytesPerSector = vbr.bpb.bpb_BytesPerSector;
            file += (32 * bpb_RootDirEntries) / bpb_BytesPerSector;

            cluster_size *= vbr.bpb.bpb_SectorsPerCluster;
            fat_sector_cnt = vbr.bpb.bpb_SectorsPerFAT;
            fat_size *= vbr.bpb.bpb_SectorsPerFAT;
            if (memcmp(vbr.bs_FileSysType, "FAT12", 5) == 0 ) {
                system_idx = 12;
            }
            if (memcmp(vbr.bs_FileSysType, "FAT16", 5) == 0 ) {
                system_idx = 16;
            }
            if (memcmp(vbr.bs_FileSysType, "FAT32", 5) == 0 ) {
                system_idx = 32;
            }
        } /* if */
    } /* type */
    printf("\n");

    printf("该分区的根目录表项个数为%d.\n", dir_cnt);
    printf("该分区的文件系统为FAT%d\n", system_idx);
    printf("该分区的簇大小为%d字节\n", cluster_size);
    printf("该分区的FAT表大小为%d字节\n", fat_size);
    uint32_t * pfat = NULL;
    int pfat_cnt = -1;
    if (system_idx == 12) {
        pfat_cnt = fat_size / 2 * 3;
        pfat = (uint32_t *) malloc(pfat_cnt * sizeof(uint32_t));
    }
    if (system_idx == 16) {
        pfat_cnt = fat_size / 2;
        pfat = (uint32_t *) malloc(pfat_cnt * sizeof(uint32_t));
    }
    if (system_idx == 32) {
        pfat_cnt = fat_size / 4;
        pfat = (uint32_t *) malloc(pfat_cnt * sizeof(uint32_t));
    }
    if (pfat == NULL) {
        printf("FAT alloc error.\n");
        returnCode = 1;
        goto err_read_file_or_folder;
    }
    memset(pfat, 0, pfat_cnt * sizeof(uint32_t));

    if( buf[510] == 0x55 && buf[511] == 0xAA) {
        /* 读取FAT1 */
        /* fat1 */
        printf("fat1=%d.(L1:%d L2:%d OFF:%d) \n", fat1, get_l1_index(fat1, 4096, 512), get_l2_index(fat1), get_cluster_index(fat1));
        offset = *(qcow2File->pL2Table + get_l1_index(fat1, 4096, 512) * 512 + get_l2_index(fat1));
        offset += get_cluster_index(fat1);
        printf("offset=%lld %X.\n", offset, offset);
        if (fseek(pFile, offset, SEEK_SET) != 0) {
            printf("fseek error.%d.\n", ferror(pFile)); goto err_read_file_or_folder;
        }

        // fat_size;
        int idx = 0;
        int idx_pfat = 0;
        for (idx = 0; idx < fat_sector_cnt; idx ++) {
            memset(buf, 0, sizeof(buf));
            readedcnt = fread(&buf, 1, sizeof(buf), pFile);
            if (readedcnt != sizeof(buf)) {
                fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
                printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                goto err_read_file_or_folder;
            }
            int idy = 0;
            if (system_idx == 12) {
                for (idy = 0; idy < 512; idy ++) {
                    if (idy % 3 == 0) {
                        *(pfat + idx_pfat) = buf[idy];
                    } else if (idy % 3 == 1) {
                        *(pfat + idx_pfat) = ((buf[idy] & 0x000F) << 8) | *(pfat + idx_pfat);
                        idx_pfat ++;
                        if (idx_pfat >= pfat_cnt) {
                            break;
                        }
                        *(pfat + idx_pfat) = ((buf[idy] & 0x00F0) >> 4);
                    } else if (idy % 3 == 2) {
                        *(pfat + idx_pfat) = ((buf[idy] & 0x00FF) << 4) | *(pfat + idx_pfat);
                        idx_pfat ++;
                        if (idx_pfat >= pfat_cnt) {
                            break;
                        }
                    }
                }
            } /* fat12 */
            if (system_idx == 16) {
                // memcpy(pfat + idx_pfat, buf, readedcnt);
                // idx_pfat += 512 / 2;
                for (idy = 0; idy < 512; idy ++) {
                    if (idy % 2 == 0) {
                        *(pfat + idx_pfat) = buf[idy];
                    } else if (idy % 2 == 1) {
                        *(pfat + idx_pfat) = ((buf[idy] & 0x00FF) << 8) | *(pfat + idx_pfat);
                        idx_pfat ++;
                        if (idx_pfat >= pfat_cnt) {
                            break;
                        }
                    }
                }
            } /* FAT16 */
            if (system_idx == 32) {
                memcpy(pfat + idx_pfat, buf, readedcnt);
                idx_pfat += 512 / 4;
            } /* FAT32 */
        } /* for */
        // print_ary(buf, sizeof(buf));
        printf("\n");
        for (idx = 0; idx < pfat_cnt && idx < 512; idx ++) {
            printf("%X ", *(pfat + idx));
            if ((idx + 1) % 16 == 0) {
                printf("\n");
            }
        }
        printf("\n");

        /* fat2 */
        printf("fat2=%d.(L1:%d L2:%d OFF:%d) \n", fat2, get_l1_index(fat2, 4096, 512), get_l2_index(fat2), get_cluster_index(fat2));
        offset = *(qcow2File->pL2Table + get_l1_index(fat2, 4096, 512) * 512 + get_l2_index(fat2));
        offset += get_cluster_index(fat2);
        printf("offset=%lld %X.\n", offset, offset);
        if (fseek(pFile, offset, SEEK_SET) != 0) {
            printf("fseek error.%d.\n", ferror(pFile)); goto err_read_file_or_folder;}
        memset(buf, 0, sizeof(buf));
        readedcnt = fread(&buf, 1, sizeof(buf), pFile);
        if (readedcnt != sizeof(buf)) {
            fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
            printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
            goto err_read_file_or_folder;
        }
        // print_ary(buf, sizeof(buf));
        printf("\n");
        for (idx = 0; idx < pfat_cnt && idx < 512; idx ++) {
            printf("%X ", *(buf + idx));
            if ((idx + 1) % 16 == 0) {
                printf("\n");
            }
        }
        printf("\n");

        /* 获取RootDir */
        /* Rootdir */
        printf("root dir's 1 setcot.\n");
        printf("root=%d.(L1:%d L2:%d OFF:%d) \n", root, get_l1_index(root, 4096, 512), get_l2_index(root), get_cluster_index(root));
        offset = *(qcow2File->pL2Table + get_l1_index(root, 4096, 512) * 512 + get_l2_index(root));
        offset += get_cluster_index(root);
        printf("offset=%lld %X.\n", offset, offset);
        if (fseek(pFile, offset, SEEK_SET) != 0) {
            printf("fseek error.%d.\n", ferror(pFile)); goto err_read_file_or_folder;
        }

        pdirtable = NULL;
        pdirtable = (DIRENT *) malloc(sizeof(DIRENT) * dir_cnt);
        if (pdirtable == NULL) {
            printf("Rootdir alloc error.\n");
            returnCode = 1;
            goto err_read_file_or_folder;
        }
        memset(pdirtable, 0, sizeof(DIRENT) * dir_cnt);

        int dir_idx = 0;
        while(dir_idx < dir_cnt) {
            memset(buf, 0, sizeof(buf));
            readedcnt = fread(&buf, 1, sizeof(buf), pFile);
            if (readedcnt != sizeof(buf)) {
                printf("read root dir ent errorreadedcnt[%d] !=sizeof(buf)[%d].\n", readedcnt, sizeof(buf));
                goto err_read_file_or_folder;
            }
            // print_ary(buf, sizeof(buf));
            print_fdt((char *) buf, sizeof(buf));
            memcpy(pdirtable + dir_idx, buf, readedcnt);
            dir_idx = dir_idx + readedcnt / sizeof(DIRENT);
        } /* while */
        printf("\n");


        int ilen = strlen(src);
        int ipos = ilen - 1;
        int iend = ilen;
        printf("src=%s.\n", src);
        printf("len=%d.\n", ilen);
        printf("end=%d.\n", iend);
        printf("pos=%d.\n", ipos);
        char src_file_name[9];
        char src_file_name_ex[4];
        memset(src_file_name, 0, sizeof(src_file_name));
        memset(src_file_name_ex, 0, sizeof(src_file_name_ex));
        while (ipos >= 0) {
            if (*(src + ipos) == '.') {
                printf("%d.\n", ilen - ipos);
                memcpy(src_file_name_ex, src + ipos + 1, 3);
                iend = ipos;
            }
            if (*(src + ipos) == '\\' || *(src + ipos) == '/' ) {
                printf("%d.\n", iend - ipos);
                memcpy(src_file_name, src + ipos + 1, iend - ipos - 1);
                break;;
            }
            if (ilen - ipos > 12) {
                break;
            }
            ipos --;
        }
        printf("%s.%s.\n", src_file_name, src_file_name_ex);

        /* 查找RootDir */
        printf("dir_cnt=%d.\n", dir_cnt);
        for (dir_idx = 0; dir_idx < dir_cnt; dir_idx += 1) {
            // if (strlen((pdirtable + dir_idx)->fileName) == 0) {
            //     continue;
            // }
            // printf("%s\n", (pdirtable + dir_idx)->fileName);
            if (strlen((char *)(pdirtable + dir_idx)->fileName) != 0
            && memcmp((pdirtable + dir_idx)->fileName, src_file_name, strlen(src_file_name)) == 0
            && memcmp((pdirtable + dir_idx)->fileExtension, src_file_name_ex, strlen(src_file_name_ex)) == 0){
                printf("dir_idx=%d.@break\n", dir_idx);
                break;
            }
        }
        printf("dir_idx=%d.\n", dir_idx);
        if (dir_idx >= dir_cnt) {
            printf("%s不存在。\n", src);
            returnCode = 1;
            goto err_read_file_or_folder;
        }
        DIRENT cur_file;
        memset(&cur_file, 0, sizeof(DIRENT));
        memcpy(&cur_file, pdirtable + dir_idx, sizeof(DIRENT));
        print_dirt(&cur_file);
        uint32_t src_file_size = 0;
        memcpy(&src_file_size, cur_file.fileSize, sizeof(uint32_t));

        /* */
        pFileIn = fopen(dst, "w+b");
        if (pFileIn == NULL) {
            printf("copy dst open error.\n");
            returnCode = 1;
            goto err_read_file_or_folder;
        }


        /* 按照簇  扇区单位读取文件 */
        int cluster_cnt = src_file_size / cluster_size;
        if (src_file_size % cluster_size != 0) {
            cluster_cnt ++;
        }
        uint32_t fat_idx = 0;
        memcpy(&fat_idx, cur_file.startClusters, sizeof(uint16_t));
        printf("%d.\n", fat_idx);
        uint16_t startcluster = (uint16_t) fat_idx;

        sector_no = root + 32;
        printf("扇区编号为:%d,%d.\n", sector_no, file);
        int sector_cluster = cluster_size / 512;
        sector_no = file + (startcluster - 2) * sector_cluster;
        printf("文件的起始扇区编号为:%d,%d,共占用%d个簇.\n", sector_no, file, cluster_cnt);
        printf("文件的大小%d.\n", src_file_size);

        uint32_t cluster_idx = 0;
        idx_pfat = startcluster;
        int write_cnt = 0;
        int write_sum = 0;
        int write_size = src_file_size;
        while(cluster_idx < cluster_cnt) {
            printf("idx_pfat=%d,%X.\n", idx_pfat, idx_pfat);
            printf("cluster_idx=%d.\n", cluster_idx);
            printf("cluster_cnt=%d.\n", cluster_cnt);

            for (idx = 0; idx < sector_cluster; idx ++) {
                sector_no = file + ( idx_pfat - 2 ) * sector_cluster + idx;
                /* read file */
                printf("file=%d.(L1:%d L2:%d OFF:%d) \n", file, get_l1_index(sector_no, 4096, 512), get_l2_index(sector_no), get_cluster_index(sector_no));
                offset = *(qcow2File->pL2Table + get_l1_index(sector_no, 4096, 512) * 512 + get_l2_index(sector_no));
                offset += get_cluster_index(sector_no);
                printf("offset=%lld %X.\n", offset, offset);

                if (fseek(pFile, offset, SEEK_SET) != 0) {
                    printf("fseek error.%d.\n", ferror(pFile)); goto err_read_file_or_folder;}

                memset(buf, 0, sizeof(buf));
                readedcnt = fread(&buf, 1, sizeof(buf), pFile);
                if (readedcnt != sizeof(buf)) {
                    printf("read MBR errorreadedcnt[%d]!=sizeof(buf)[%d].\n", readedcnt, sizeof(buf));
                    // printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                    goto err_read_file_or_folder;
                }
                if (write_size >= readedcnt) {
                    write_size -= readedcnt;
                    write_cnt = fwrite(&buf, 1, readedcnt, pFileIn);
                } else {
                    write_cnt = fwrite(&buf, 1, write_size, pFileIn);
                    write_size = 0;
                }
                write_sum += write_cnt;
                printf("写入%d,累计%d.\n", write_cnt, write_sum);
            }



            /* 下一个簇 */
            idx_pfat = *(pfat + idx_pfat);
            printf("idx_pfat=%X.\n", idx_pfat);
            if ((idx_pfat & 0x0F0) == 0x0F0) {
                break;
            }
            cluster_idx ++;
        } /* while*/

        /* File */
        printf("first file's 1 sector.\n");
        printf("file=%d.(L1:%d L2:%d OFF:%d) \n", file, get_l1_index(file, 4096, 512), get_l2_index(file), get_cluster_index(file));
        offset = *(qcow2File->pL2Table + get_l1_index(file, 4096, 512) * 512 + get_l2_index(file));
        offset += get_cluster_index(file);
        printf("offset=%lld %X.\n", offset, offset);
        if (fseek(pFile, offset, SEEK_SET) != 0) {
            printf("fseek error.%d.\n", ferror(pFile)); goto err_read_file_or_folder;}
        memset(buf, 0, sizeof(buf));
        readedcnt = fread(&buf, 1, sizeof(buf), pFile);
        if (readedcnt != sizeof(buf)) {
            fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
            printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
            goto err_read_file_or_folder;
        }
        print_ary(buf, sizeof(buf));
        printf("\n");
    } /* if 55 AA */

    goto end_read_file_or_folder;
err_read_file_or_folder:
end_read_file_or_folder:
    /* 处理结束 */
    if (pFileIn != NULL) { fclose(pFileIn); pFileIn = NULL; }
    if (pdirtable != NULL) { free(pdirtable); pdirtable = NULL; }
    if (pfat != NULL) { free(pfat); pfat = NULL; }
    return returnCode;
}



int delete_file_or_folder(const char * filename) {
    /* 变量定义 */
    int returnCode;

    /* 变量初始化 */
    returnCode = 0;
    /* 处理开始 */
    printf("filename=%s.\n", filename);

    goto end_delete_file_or_folder;
err_delete_file_or_folder:
end_delete_file_or_folder:
    /* 处理结束 */
    return returnCode;
}

void debug_print_table_16(const uint16_t * table, const uint32_t size) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    uint64_t idx   = -1;
    uint64_t idz   =  0;
    uint16_t value = -1;

    for (idx = 0; idx < size; idx ++) {
        value = *(table + idx);
        if (value == 0) { continue; }
        printf("table[%05lld]=%d. ", idx, value);
        idz ++;
        if (idz % 8 ==0) { printf("\n"); }
    }
    printf("\n");
    /* 处理结束 */
}

void debug_print_table_64(const uint64_t * table, const uint32_t size) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    uint64_t idx   = -1;
    uint64_t idz   =  0;
    uint64_t value = -1;

    for (idx = 0; idx < size; idx ++) {
        value = *(table + idx);
        if (value == 0) { continue; }
        printf("table[%05lld]=%010lld, 0X%010X ", idx, value, value);
        idz ++;
        if (idz % 8 ==0) { printf("\n"); }
    }
    if (idz == 0) {
        printf("ALL ZERO.\n");
    }
    printf("\n");
    /* 处理结束 */
}

uint64_t *  print_l1_table_64(const uint64_t * table, const uint32_t size, FILE * pFile, uint32_t cluster_size) {

    /* 变量定义 */
    size_t readedcnt;
    int k;
    int mask_bits;
    char cluster_size_bin[33];
    int compress_size;

    /* 变量初始化 */
    /* 处理开始 */
    uint64_t idx    = -1;
    int      idy    = -1;
    uint64_t idz    =  0;
    uint64_t offset = -1;
    int max_cnt     = cluster_size / 8;
    uint64_t l2_item = -1LL;
    uint64_t * l2_table = NULL;
    /* for compressed clusters */
    memset(cluster_size_bin, 0, sizeof(cluster_size_bin));
    itoa(cluster_size, cluster_size_bin, 2);
    int cluster_bits = strlen(cluster_size_bin);
    mask_bits = 62 - (cluster_bits - 8);
    printf("cluster_size=%d cluster_bits=%d[%s]mask_bits=%d.\n", cluster_size, cluster_bits, cluster_size_bin, mask_bits);
    uint64_t mask = (1LL << (mask_bits + 1)) - 1LL;
    printf("mask=%lld.\n", mask);
    uint64_t mask2_size = (1LL << (62 - mask_bits - 1)) - 1LL;
    printf("mask2_size=%lld.\n", mask2_size);

    printf("表2在镜像文件中的最初位置[(%lld, 0X%04X)-", *(table), *(table));
    printf("(%lld, 0X%04X)).\n", *(table) + cluster_size, *(table) + cluster_size);
    l2_table = (uint64_t *) malloc(sizeof(uint64_t) * size * max_cnt);
    if (l2_table == NULL) { printf("memory alloc error.\n"); goto end_print_l1_table_64; }

    memset(l2_table, 0, sizeof(uint64_t) * size * max_cnt);
    for (idx = 0; idx < size; idx ++) {
        offset = *(table + idx);
        if (offset == 0) { continue; }
        printf("offset[%05lld]=%lld, 0X%X ", idx, offset, offset);
        printf("\n");
        if( fseek(pFile, offset, SEEK_SET) ) { goto err_print_l1_table_64; }
        /* 1个完整的簇存储，所以可以一次读取。 */
        readedcnt = fread(l2_table + idx * max_cnt, sizeof(uint64_t), max_cnt, pFile);
        if (readedcnt != max_cnt) {
            fprintf(stderr, "read level 2 table error(%d != %d).\n", readedcnt, max_cnt);
            goto err_print_l1_table_64;
        }
        idz = 0;
        for (idy = 0; idy < max_cnt; idy ++) {
            l2_item = *(l2_table + idx * max_cnt + idy);
            if (l2_item == 0LL) { continue; }

            printf("%03d", idy);
            l2_item = be64_to_cpu(l2_item);
            char s[8][10];
            memset(s, 0, sizeof(s));
            for (k = 7; k >= 0; k --) {
                int il2_item = (int) ((l2_item >> (k * 8)) & 0x00FF);
                printf(" %02.2x", il2_item);
                itoa(il2_item, s[k], 2);
            }

            for (k = 7; k >= 0; k --) {
                printf(" %08s", s[k]);
            }
            if (((l2_item >> 62) & 0x01) == 0x00) {
                printf(" standard clusters");
            }
            if (((l2_item >> 62) & 0x01) == 0x01) {
                printf(" compressed clusters");
                l2_item = ( l2_item & mask );
                printf(" l2_item=%lld ", l2_item);
                l2_item = ( l2_item >> (mask_bits + 1) );
                compress_size = (int) (l2_item & mask2_size);
                printf(" compress_size=%d.", compress_size);
                printf(" compress_size=%X.", compress_size);
            }
            printf(".\n");
        }
        idz = 0;
        for (idy = 0; idy < max_cnt; idy ++) {
            l2_item = *(l2_table + idx * max_cnt + idy);
            if (l2_item == 0LL) { continue; }
            l2_item = be64_to_cpu(l2_item);
            if (((l2_item >> 62) & 0x01) == 0x00) {
                /* standard clusters */
                // l2_item = l2_item & 0x3FFFFFFFFFFFFFFF;
                l2_item = l2_item & 0x00FFFFFFFFFFFFFF;
            }
            if (((l2_item >> 62) & 0x01) == 0x01) {
                /* compressed clusters */
                l2_item = l2_item & mask;
            }
            printf("l2[%03d]=%013lld. 0X%010X.", idy, l2_item, l2_item);
            idz ++;
            if (idz % 8 ==0) { printf("\n"); }
            memcpy(l2_table + idx * max_cnt + idy, &l2_item, sizeof(l2_item));
        }
        printf("\n");
    }
    printf("\n");
    goto end_print_l1_table_64;
err_print_l1_table_64:
    if(l2_table != NULL) { free(l2_table); l2_table = NULL; }
end_print_l1_table_64:
    return l2_table;
}

void print_ary(unsigned char * buf, size_t size) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    int idx =0;
    for (idx = 0; idx < size; idx ++) {
        printf("0X%02X ", *(buf + idx));
        if ((idx + 1) % 16 == 0) {printf("\n");}
    }
}

/*--------------------------------------*/
void print_list(PartitionEntryItem * pt) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    printf("========= this is a test for list.\n");
    PartitionEntryItem * p = pt;
    while(p != NULL) {
        printf("flag=%d 扇区LBA_NO=%d ", p->flag, p->sector_index);
        print_partition_entry(&(p->pe));
        p = p->pNext;
    }
    printf("========= this is a test for list.\n");
    /* 处理结束 */
}

void free_list(PartitionEntryItem * pt) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    PartitionEntryItem *pNext;            //定义一个与pHead相邻节点
 
    if(pt == NULL)     {
        printf("clearList函数执行，链表为空\n");
        return;
    }
    while(pt->pNext != NULL)     {
        pNext = pt->pNext;//保存下一结点的指针
        free(pt);
        pt = NULL;
        pt = pNext;      //表头下移
    }
    printf("clearList函数执行，链表已经清除\n");
    /* 处理结束 */
}
/*--------------------------------------*/

PartitionEntryItem * print_partition_table_64(const uint64_t * table1, const uint32_t size1, 
const uint64_t * table2, const uint32_t size2, FILE * pFile, size_t cluster_size) {

    /* 变量定义 */
    unsigned char buf[512];
    int drv_no = 1;
    int has_next_drv = 0;
    int pos = 446;
    PartitionEntryItem * pPrev = NULL;
    PartitionEntryItem * root = NULL;
    int drv_cnt = 0;
    int run_cnt = 0;

    /* 变量初始化 */
    uint64_t idx    = -1;
    int      idy    = -1;
    uint64_t idz    =  0;
    uint64_t offset = -1;
    int max_cnt     = cluster_size / 8;
    size_t readedcnt;
    uint64_t l2_item = 0LL;
    uint32_t sector_index = 0;
    uint32_t next_sector_index = 0;
    PartitionEntry pe;
    sector_index = 0;

    /* 处理开始 */

    root = (PartitionEntryItem *) malloc(sizeof(PartitionEntryItem));
    if (root == NULL) { printf("memory alloc error.\n"); goto end_print_partition_table_64; }

    memset(root, 0, sizeof(PartitionEntryItem));
    PartitionEntryItem * p = root;

    do {
        has_next_drv = 0;
        run_cnt ++;
        printf("----- drv%d mbr info -----\n", drv_no);

        offset = *(table2 + get_l1_index(sector_index, cluster_size, 512) * 512 + get_l2_index(sector_index));
        offset += get_cluster_index(sector_index);
        printf("起始扇区号：%d (l1=%d， l2=%d, cluster=%d), 在镜像文件中的位置[(1%lld. 0X%X)-.", sector_index, 
            get_l1_index(sector_index, cluster_size, 512), get_l2_index(sector_index), get_cluster_index(sector_index), 
            offset, offset);
        printf("(%lld, 0X%X)).\n", offset + 512, offset + 512);
        if (fseek(pFile, offset, SEEK_SET) != 0) { printf("%d.\n", ferror(pFile)); goto end_print_partition_table_64;};

        memset(buf, 0, sizeof(buf));
        readedcnt = fread(&buf, 1, sizeof(buf), pFile);
        if (readedcnt != sizeof(buf)) {
            fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
            printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
            goto end_print_partition_table_64;
        }
        printf("0X%X, 0X%X.\n", buf[510], buf[511]);

        drv_cnt = 0;
        for (pos = 446; pos < 446 + 64; pos += 16) {
            // printf("><%d.%d.\n", buf[pos + 4], sector_index);
            memset(&pe, 0, sizeof(PartitionEntry));
            memcpy(&pe, buf + pos, sizeof(PartitionEntry));
            print_partition_entry(&pe);
            if (buf[pos + 4] == 0) {
                /* 未使用分区 */
            } else if (buf[pos + 4] == 5) {
                /* 扩展分区 */
                drv_cnt ++;
            } else {
                /* 主分区 */
                drv_cnt ++;
                if (p->flag != 0) {
                    pPrev = p;
                    p = (PartitionEntryItem *) malloc(sizeof(PartitionEntryItem));
                    if (p == NULL) { printf("memory alloc error.\n"); goto end_print_partition_table_64; }
                    memset(p, 0, sizeof(PartitionEntryItem));
                    pPrev->pNext = p;
                    memcpy(&(p->pe), &pe, sizeof(PartitionEntry));
                    p->sector_index = sector_index;
                    p->flag = 1;
                } else {
                    memcpy(&(p->pe), &pe, sizeof(PartitionEntry));
                    p->sector_index = sector_index;
                    p->flag = 1;
                }
                sector_index = sector_index + pe.sector_total + pe.start_sector_no;
            }
        }
        printf("\n");
        if (drv_cnt > 1) {
            has_next_drv = 1;
        }
        drv_no ++;
    } while (has_next_drv && run_cnt <= 100);
    goto end_print_partition_table_64;

err_print_partition_table_64:
    if (root != NULL) { free_list(root); root = NULL; }
end_print_partition_table_64:
    /* 处理结束 */
    printf("\n");
    return root;
}

int print_fdt(char * buf, size_t size) {
    /* 变量定义 */
    int returnCode;
    DIRENT dir_ent;
    int idx = 0;
    char file_name[9];
    char file_name_ex[4];
    uint16_t start_cluster;
    uint32_t file_size;
    uint16_t createTimeHMS;
    uint16_t createDateYMD;
    uint16_t lastAcDateYMD;
    uint16_t lastModifyDate;
    uint16_t lastModifyTime;

    /* 变量初始化 */
    returnCode = 0;

    /* 处理开始 */
    printf(">>----- print_fdt -----.\n");
    printf("大小:%d.\n", size);
    for (idx = 0; idx < size; idx += 32) {
        memset(&dir_ent, 0, sizeof(DIRENT));
        memcpy(&dir_ent, buf + idx, sizeof(DIRENT));
        if (dir_ent.fileName[0] == 0x00) {
            break;
        }
        memset(file_name, 0, sizeof(file_name));
        memset(file_name_ex, 0, sizeof(file_name_ex));

        memcpy(file_name, dir_ent.fileName, sizeof(dir_ent.fileName));
        memcpy(file_name_ex, dir_ent.fileExtension, sizeof(dir_ent.fileExtension));
        memcpy(&createTimeHMS, dir_ent.createTimeHMS, sizeof(uint16_t));
        memcpy(&createDateYMD, dir_ent.createDateYMD, sizeof(uint16_t));
        memcpy(&lastAcDateYMD, dir_ent.lastAcDateYMD, sizeof(uint16_t));
        memcpy(&lastModifyDate, dir_ent.lastModifyDate, sizeof(uint16_t));
        memcpy(&lastModifyTime, dir_ent.lastModifyTime, sizeof(uint16_t));
        memcpy(&start_cluster, dir_ent.startClusters, sizeof(uint16_t));
        memcpy(&file_size, dir_ent.fileSize, sizeof(uint32_t));

        printf("%s.%s  %02X %d ",  file_name, file_name_ex, dir_ent.fileAttrube[0], dir_ent.createTime[0]);
        printf("%04d/%02d/%02d ", (((createDateYMD & 0xFE00) >>  9) > 0 ? 1980 + ((createDateYMD & 0xFE00) >>  9) : 0), ((createDateYMD & 0x1E0) >> 5), (createDateYMD & 0x1F));
        printf("%02d:%02d:%02d ", ((createTimeHMS & 0xF800) >> 11), ((createTimeHMS & 0x7E0) >> 5), (createTimeHMS & 0x1F));
        printf("%04d/%02d/%02d ", (((lastAcDateYMD & 0xFE00) >>  9) > 0 ? 1980 + ((lastAcDateYMD & 0xFE00) >>  9) : 0), ((lastAcDateYMD & 0x1E0) >> 5), (lastAcDateYMD & 0x1F));
        printf("%04d/%02d/%02d ", (((lastModifyDate & 0xFE00) >>  9) > 0 ? 1980 + ((lastModifyDate & 0xFE00) >>  9) : 0), ((lastModifyDate & 0x1E0) >> 5), (lastModifyDate & 0x1F));
        printf("%02d:%02d:%02d ", ((lastModifyTime & 0xF800) >> 11), ((lastModifyTime & 0x7E0) >> 5), (lastModifyTime & 0x1F));
        printf("%d %X %d ", start_cluster, start_cluster, file_size);
        printf("\n");
    }
    

    goto end_print_fdt;
err_print_fdt:
end_print_fdt:
    /* 处理结束 */
    printf("----- print_fdt -----<<.\n");
    return returnCode;
}

void print_vbr(PartitionEntryItem * pe_table, const uint64_t * table2, const uint32_t size2, FILE * pFile) {

    /* 变量定义 */
    int partition_no;
    /* 变量初始化 */
    partition_no = 1;
    /* 处理开始 */
    size_t readedcnt;

    PartitionEntryItem * p = pe_table;
    while(p != NULL) {
        printf("drv%d ", partition_no);
        printf("flag=%d sector_index=%d start_sector_no=%d ", p->flag, p->sector_index, p->pe.start_sector_no);
        uint32_t sector_no = p->sector_index + p->pe.start_sector_no;
        uint32_t fat1 = sector_no;
        uint32_t fat2 = sector_no;
        uint32_t root = sector_no;
        uint32_t file = sector_no;

        // vbr
        // TODO:
        printf("起始扇区号：%d (l1 =%d, l2=%d, cluster=%d), \n", sector_no, 
            get_l1_index(sector_no, 4096, 512), get_l2_index(sector_no), get_cluster_index(sector_no));
        uint64_t offset = -1;
        offset = *(table2 + get_l1_index(sector_no, 4096, 512) * 512 + get_l2_index(sector_no));
        offset += get_cluster_index(sector_no);
        printf("在镜像文件中的位置[(%lld 0X%X)-", offset, offset);
        printf("(%lld 0X%X)).\n", offset + 512, offset + 512);
        if (fseek(pFile, offset, SEEK_SET) != 0) { printf("fseek error.%d.\n", ferror(pFile)); goto end_print_vbr;}
        unsigned char buf[512];
        memset(buf, 0, sizeof(buf));
        readedcnt = fread(&buf, 1, sizeof(buf), pFile);
        if (readedcnt != sizeof(buf)) {
            fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
            printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
            goto end_print_vbr;
        }
        printf("启动扇区:%X, %X type:%X.\n", buf[510], buf[511], p->pe.type);
        if (p->pe.type == 0x01 || p->pe.type == 0x04 || p->pe.type == 0x06 || p->pe.type == 0x0E) {
            /* FAT16 */
            /*
             01 DOS        12-bit FAT
             04 DOS 3.0+   16-bit FAT (up to 32M)
             06 DOS 3.31+: 16-bit FAT (over 32M)
             0E WIN95: DOS 16-bit FAT, LBA-mapped
             */
            if( buf[510] == 0x55 && buf[511] == 0xAA) {
                print_ary(buf, sizeof(buf));
                VBRFAT1216 vbr;
                printf("size=%d.BPB:%d.uint8_t=%d.%d.%d.\n", sizeof(vbr), sizeof(BPB1216), sizeof(uint8_t), sizeof(uint16_t), sizeof(uint32_t));
                memcpy(&vbr, buf, 512);
                print_vbr_fat_1216(&vbr);

                uint16_t bpb_ReservedSectorst = vbr.bpb.bpb_ReservedSectorst;
                fat1 += bpb_ReservedSectorst;
                fat2 += bpb_ReservedSectorst;
                root += bpb_ReservedSectorst;
                file += bpb_ReservedSectorst;
                uint16_t bpb_SectorsPerFAT = vbr.bpb.bpb_SectorsPerFAT;
                fat2 += bpb_SectorsPerFAT;
                root += 2 * bpb_SectorsPerFAT;
                file += 2 * bpb_SectorsPerFAT;
                uint16_t bpb_RootDirEntries = vbr.bpb.bpb_RootDirEntries;
                uint16_t bpb_BytesPerSector = vbr.bpb.bpb_BytesPerSector;
                file += (32 * bpb_RootDirEntries) / bpb_BytesPerSector;
            }
            if( buf[510] == 0xF6 && buf[511] == 0xF6) {
                printf("bpb_BytesPerSector=512.\n");
                fat1 += 1;
                fat2 += 1;
                root += 1;
                file += 1;
                int SectorsPerCluster=8;
                printf("bpb_SectorsPerCluster=%d.\n", SectorsPerCluster);
                printf("bpb_ReservedSectorst=1.\n");
                printf("bpb_FatCopies=2.\n");
                printf("bpb_NumSectors=%d.\n", p->pe.sector_total);
                int dbj_a = p->pe.sector_total / SectorsPerCluster;
                if (p->pe.sector_total % SectorsPerCluster != 0) {
                    dbj_a ++;
                }
                int bpb_SectorsPerFAT = dbj_a / 256;
                if (dbj_a % 256 != 0) {
                    bpb_SectorsPerFAT ++;
                }
                printf("bpb_SectorsPerFAT=%d.\n", bpb_SectorsPerFAT);
                fat2 += bpb_SectorsPerFAT;
                root += 2 * bpb_SectorsPerFAT;
                file += 2 * bpb_SectorsPerFAT;
//                fat2 += bpb_SectorsPerFAT;
            }
        }
        if (p->pe.type == 0x0C) {
            /* FAT32 */
            if (buf[510] == 0x55 && buf[511] == 0xAA) {
                print_ary(buf, sizeof(buf));
                VBRFAT32 vbr;
                memcpy(&vbr, buf, 512);
                print_vbr_fat_32(&vbr);
                uint16_t bpb_ReservedSectorst = vbr.bpb.bpb_ReservedSectorst;
                fat1 += bpb_ReservedSectorst;
                fat2 += bpb_ReservedSectorst;
                root += bpb_ReservedSectorst;
                root += bpb_ReservedSectorst;
                uint32_t bpb_SectorsPerFAT32 = vbr.bpb.bpb_SectorsPerFAT32;
                fat2 += bpb_SectorsPerFAT32;
                root += 2 * bpb_SectorsPerFAT32;
                file += 2 * bpb_SectorsPerFAT32;
                uint16_t bpb_RootDirEntries = vbr.bpb.bpb_RootDirEntries;
                uint16_t bpb_BytesPerSector = vbr.bpb.bpb_BytesPerSector;
                file += (32 * bpb_RootDirEntries) / bpb_BytesPerSector;
                printf("\n");
                
                // FAT32 FSInfo
                printf("FAT32 FSInfo.\n");
                uint16_t bpb_FSInfo = vbr.bpb.bpb_FSInfo;
                offset = *(table2 + get_l1_index(sector_no + bpb_FSInfo, 4096, 512) * 512 + get_l2_index(sector_no + bpb_FSInfo));
                offset += get_cluster_index(sector_no + bpb_FSInfo);
                printf("offset=%lld %X.\n", offset, offset);
                if (fseek(pFile, offset, SEEK_SET) != 0) { printf("fseek error.%d.\n", ferror(pFile)); goto end_print_vbr;}
                memset(buf, 0, sizeof(buf));
                readedcnt = fread(&buf, 1, sizeof(buf), pFile);
                if (readedcnt != sizeof(buf)) {
                    fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
                    printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                    goto end_print_vbr;
                }
                print_ary(buf, sizeof(buf));
                /*fat1 += bpb_FSInfo;
                fat2 += bpb_FSInfo;
                root += bpb_FSInfo;
                file += bpb_FSInfo;*/
            }
        }
        printf("\n");

        if( buf[510] == 0x55 && buf[511] == 0xAA) {
            /* fat1 */
            printf("fat1=%d.(L1:%d L2:%d OFF:%d) \n", fat1, get_l1_index(fat1, 4096, 512), get_l2_index(fat1), get_cluster_index(fat1));
            offset = *(table2 + get_l1_index(fat1, 4096, 512) * 512 + get_l2_index(fat1));
            offset += get_cluster_index(fat1);
            printf("offset=%lld %X.\n", offset, offset);
            if (fseek(pFile, offset, SEEK_SET) != 0) { printf("fseek error.%d.\n", ferror(pFile)); goto end_print_vbr;}
            memset(buf, 0, sizeof(buf));
            readedcnt = fread(&buf, 1, sizeof(buf), pFile);
            if (readedcnt != sizeof(buf)) {
                fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
                printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                goto end_print_vbr;
            }
            print_ary(buf, sizeof(buf));
            printf("\n");

            /* fat2 */
            printf("fat2=%d.(L1:%d L2:%d OFF:%d) \n", fat2, get_l1_index(fat2, 4096, 512), get_l2_index(fat2), get_cluster_index(fat2));
            offset = *(table2 + get_l1_index(fat2, 4096, 512) * 512 + get_l2_index(fat2));
            offset += get_cluster_index(fat2);
            printf("offset=%lld %X.\n", offset, offset);
            if (fseek(pFile, offset, SEEK_SET) != 0) { printf("fseek error.%d.\n", ferror(pFile)); goto end_print_vbr;}
            memset(buf, 0, sizeof(buf));
            readedcnt = fread(&buf, 1, sizeof(buf), pFile);
            if (readedcnt != sizeof(buf)) {
                fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
                printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                goto end_print_vbr;
            }
            print_ary(buf, sizeof(buf));
            printf("\n");

            /* Rootdir */
            printf("root dir's 1 setcot.\n");
            printf("root=%d.(L1:%d L2:%d OFF:%d) \n", root, get_l1_index(root, 4096, 512), get_l2_index(root), get_cluster_index(root));
            offset = *(table2 + get_l1_index(root, 4096, 512) * 512 + get_l2_index(root));
            offset += get_cluster_index(root);
            printf("offset=%lld %X.\n", offset, offset);
            if (fseek(pFile, offset, SEEK_SET) != 0) { printf("fseek error.%d.\n", ferror(pFile)); goto end_print_vbr;}
            memset(buf, 0, sizeof(buf));
            readedcnt = fread(&buf, 1, sizeof(buf), pFile);
            if (readedcnt != sizeof(buf)) {
                fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
                printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                goto end_print_vbr;
            }
            // print_ary(buf, sizeof(buf));
            print_fdt((char *) buf, sizeof(buf));
            printf("\n");

            /* File */
            printf("first file's 1 sector.\n");
            printf("file=%d.(L1:%d L2:%d OFF:%d) \n", file, get_l1_index(file, 4096, 512), get_l2_index(file), get_cluster_index(file));
            offset = *(table2 + get_l1_index(file, 4096, 512) * 512 + get_l2_index(file));
            offset += get_cluster_index(file);
            printf("offset=%lld %X.\n", offset, offset);
            if (fseek(pFile, offset, SEEK_SET) != 0) { printf("fseek error.%d.\n", ferror(pFile)); goto end_print_vbr;}
            memset(buf, 0, sizeof(buf));
            readedcnt = fread(&buf, 1, sizeof(buf), pFile);
            if (readedcnt != sizeof(buf)) {
                fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
                printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                goto end_print_vbr;
            }
            print_ary(buf, sizeof(buf));
            printf("\n");
        }


        print_partition_entry(&(p->pe));
        p = p->pNext;
        partition_no ++;
    } /* while */

end_print_vbr:
    /* 处理结束 */
    return ;
}


int print_f6_sector(PartitionEntryItem * pe_table, const uint64_t * table2, const uint32_t size2, FILE * pFile) {
    /* 变量定义 */
    int returnCode;
    uint32_t idx;
    uint64_t offset;
    int sector_no;
    char buf[512];
    int readedcnt;

    /* 变量初始化 */
    returnCode = 0;
    idx = 0;
    sector_no = 0;
    PartitionEntryItem * p = pe_table;

    /* 处理开始 */
    printf("L2 Size:%ld.\n", size2);
    for(idx = 0; idx < size2  && idx < 100000; idx ++) {
        offset = *(table2 + idx);
        if (offset == 0LL) {
            continue;
        }
        printf("%05d.offset:%08llu.=", idx, offset);
        printf("%08X ", offset);
        printf("sector_no=%06d.(CHS)=(%04d %03d %02d)", sector_no, get_cylinder(sector_no, 1), get_header(sector_no, 1), get_sector(sector_no));
        // 4096
        offset += 0x200 * ( sector_no % 8 );
        printf(" sector offset:%04X ", 0x200 * ( sector_no % 8 ));
        if (fseek(pFile, offset, SEEK_SET) != 0) { printf("fseek error.%d.\n", ferror(pFile)); goto end_print_f6_sector;}

        memset(buf, 0, sizeof(buf));
        readedcnt = fread(&buf, 1, sizeof(buf), pFile);
        if (readedcnt != sizeof(buf)) {
            fprintf(stderr, "read file error[%d][%X].\n", ftell(pFile), ftell(pFile));
            printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
            goto end_print_f6_sector;
        }
        printf("%02X\n", buf[511] & 0x000000FF);

        if (p->pe.type == 0x0C) {
            while(sector_no > 0) {
                // FAT32
                idx ++;
                if (idx >= size2) {
                    break;
                }
                offset = *(table2 + idx);
                if (offset != 0LL) {
                    printf("%05d.offset:%08llu.=", idx, offset);
                    printf("%08X ", offset);
                    sector_no += 6;
                    printf("sector_no=%06d.(CHS)=(%04d %03d %02d)", sector_no, get_cylinder(sector_no, 1), get_header(sector_no, 1), get_sector(sector_no));
                    // 4096
                    offset += 0x200 * ( sector_no % 8 );
                    printf(" sector offset:%04X ", 0x200 * ( sector_no % 8 ));
                    if (fseek(pFile, offset, SEEK_SET) != 0) { printf("fseek error.%d.\n", ferror(pFile)); goto end_print_f6_sector;}

                    memset(buf, 0, sizeof(buf));
                    readedcnt = fread(&buf, 1, sizeof(buf), pFile);
                    if (readedcnt != sizeof(buf)) {
                        fprintf(stderr, "read file error[%d][%X].\n", ftell(pFile), ftell(pFile));
                        printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
                        goto end_print_f6_sector;
                    }
                    printf("%02X\n", buf[511] & 0x000000FF);
                    break ;
                }
            }
            if (sector_no == 0) {
                sector_no = sector_no + 63;
            } else {
                sector_no = sector_no + 57;
            }
        } else {
            sector_no = sector_no + 63;
        }
    } /* for */
    printf("idx=%d.\n", idx);

    goto end_print_f6_sector;
err_print_f6_sector:
end_print_f6_sector:
    /* 处理结束 */
    return returnCode;
}

/*
 * bpb_SectorsPerFAT
 */
char * make_fat(uint32_t * in, size_t in_size, size_t size, int file_system_id, char * buf) {
    /* 变量定义 */
    char * returnCode;
    int idx;
    int idy;
    int size_byte;

    /* 变量初始化 */
    returnCode = NULL;
    idx = 0;
    idy = 0;
    size_byte = size * 512;

    /* 处理开始 */
    printf(">>----- make_fat begin -----\n");
    printf("in=%X.\n", in);
    printf("in_size=%d.\n", in_size);
    printf("size=%d.\n", size);
    printf("size_byte=%d.\n", size_byte);
    printf("file_system_id=%d.\n", file_system_id);

    returnCode = (char *) malloc(size_byte);
    if (returnCode == NULL) {
        printf("memory alloc error.\n");
        goto err_make_fat;
    }
    memset(returnCode, 0, size_byte);
    //returnCode = buf;
    // TODO:这里的代码有问题
    for(idx = 0; idx < in_size; idx ++) {
        printf("%X ", *(in + idx));
        printf("idx=%d,idy=%d.\n", idx, idy);
        if (file_system_id == 12) {
            if (idx % 2 == 0) {
                returnCode[idy] = 0x00FF & in[idx];
                idy ++;
                if (idy >= size_byte) {
                    break;
                }
                returnCode[idy] = (0x0F00 & in[idx]) >> 8;
            } else {
                returnCode[idy] = ((0x000F & in[idx]) << 4) | (0x0F & returnCode[idy]);
                idy ++;
                if (idy >= size_byte) {
                    break;
                }
                returnCode[idy] = (0x0FF0 & in[idx]) >> 4;
                idy ++;
                if (idy >= size_byte) {
                    break;
                }
            }
        } /* FAT12 */
        if (file_system_id == 16) {
            // memcpy(returnCode + idy, in + idx, sizeof(uint16_t));
            //idy += 2;
            returnCode[idy] = 0x00FF & in[idx];
            idy ++;
            if (idy >= size_byte) {
                break;
            }
            returnCode[idy] = 0x00FF & (in[idx] >> 8);
            idy ++;
            if (idy >= size_byte) {
                break;
            }
        } /* FAT16 */
        if (file_system_id == 32) {
            memcpy(returnCode + idy, in + idx, sizeof(uint32_t));
            idy += 4;
            if (idy >= size_byte) {
                break;
            }
        } /* FAT32 */
    } /* for */

    goto end_make_fat;
err_make_fat:
end_make_fat:
    /* 处理结束 */
    printf("----- make_fat end -----<<\n");
    return returnCode;
}

/*
 * 获取qcow2文件的信息
 * 在此基础上创建分区。
 * Header
 * L1 Table
 * refcount Table
 * refcount block
 * L2 Table
 * Data
 */
int info(const char * filename) {
    /* 变量定义 */
    int         returnCode;
    QCowHeader  header;
    FILE*       pFile;
    uint64_t    offset;
    size_t      readedcnt;
    long        file_size;

    /* 变量初始化 */
    returnCode  = 0;
    pFile       = NULL;
    offset      = 0;
    readedcnt   = 0;
    uint64_t idx     = 0LL;
    uint32_t cluster_bits = 0;
    uint32_t cluster_size = 0;
    uint32_t l1_size = 0;
    uint64_t l1_table_offset = 0LL;
    uint64_t refcount_table_offset = 0LL;
    uint64_t l1_item = 0LL;
    uint64_t ref_table_item = 0LL;
    uint64_t ref_count_offset = -1LL;
    uint64_t * l1_table = NULL;
    uint32_t refcount_table_cnt = 0;
    uint64_t * refcount_table = NULL;
    uint32_t refcount_cnt = 0;
    uint16_t * refcount_block = NULL;
    uint64_t * l2_table = NULL;
    uint32_t   l2_size = 0;
    PartitionEntryItem * pe_table = NULL;
    uint16_t ref_item = -1;

    /* 处理开始 */
    printf("this option will display the information of the partition on qcow2(%s).\n", filename);
    pFile = fopen(filename, "r+b");
    if (pFile == NULL) { fprintf(stderr, "file(%s) open error(1).", filename); returnCode = 1; goto end_info; }

    printf("\n!!!WARNING!!! 现在的代码是不支持超过2GB的文件的!!!\n\n");
    printf("%s.\n", ansi_status);
    // printf("sizeof(size_t) %d, sizeof(off_t) %d, sizeof(off64_t) %d\n", sizeof(size_t), sizeof(off_t), sizeof(off64_t));
    if (fseek(pFile, 0L, SEEK_END)) { printf("fseek error(SEEK_END).\n"); returnCode = 1; goto end_info; }
    file_size = ftell(pFile);
    printf("file's size=%ld.\n", file_size);
    rewind (pFile);

    memset(&header, 0, sizeof(header));
    printf("sizeof(header)=%d\n", sizeof(header));
    offset = 0;
    readedcnt = fread(&header, 1, sizeof(header), pFile);
    printf("readed count=%d\n", readedcnt);
    if (readedcnt != sizeof(header)) {
        fprintf(stderr, "qcow_handle_extension: ERROR: pread fail from offset %llu\n", (unsigned long long)offset);
        returnCode = 1; goto end_info;
    }

    cluster_bits = be32_to_cpu(header.cluster_bits);
    cluster_size = 1 << cluster_bits;
    l1_size = be32_to_cpu(header.l1_size);
    l1_table_offset = be64_to_cpu(header.l1_table_offset);
    refcount_table_offset = be64_to_cpu(header.refcount_table_offset);
    printf("\n");

    printf(">>----- Header -----\n");
    /* This is a bug. */
    /* printf("头信息在镜像文件中的位置[(%lld, 0X%X)-(%lld, 0X%X))\n", offset, offset, l1_table_offset, l1_table_offset); */
    printf("头信息在镜像文件中的位置[(%lld, ", offset);
    printf("0X%04X)-(", offset);
    printf("%lld, 0X", l1_table_offset);
    printf("%04X))\n", l1_table_offset);
    print_header(&header);
    printf("cluster_size = %ld\n", cluster_size);
    printf("----- Header -----<<\n");
    printf("\n");
    /* TODO:检查输入文件 */

    /* L1 */
    printf(">>----- Level 1 Table -----\n");
    printf("表1在镜像文件中的位置[(%lld, 0X%04X)-", l1_table_offset, l1_table_offset);
    printf("(%lld, 0X%04X))\n", refcount_table_offset, refcount_table_offset);

    l1_table = (uint64_t *) malloc(sizeof(uint64_t) * (l1_size + 1));
    if (l1_table == NULL) {
        fprintf(stderr, "l1 table alloc error.\n");
        returnCode = 1; goto end_info;
    }
    memset(l1_table, 0, sizeof(uint64_t) * (l1_size + 1));
    printf("l1_table_offset=%lld,0X%X.\n", l1_table_offset, l1_table_offset);
    printf("l1_table_size=%ld,0X%X.\n", l1_size, l1_size);
    if (fseek(pFile, l1_table_offset, SEEK_SET)) { printf("fseek error(%lld).\n", l1_table_offset); returnCode = 1; goto end_info; }
    /* 表1在镜像文件中是连续存储1个或多个簇的，所以可以1次性读取 */
    readedcnt = fread(l1_table, sizeof(uint64_t), l1_size, pFile);
    if (readedcnt != l1_size) {
        fprintf(stderr, "read l1 table error(%d!=%d).\n", readedcnt, l1_size);
        returnCode = 1; goto end_info;
    }
    for (idx = 0; idx < l1_size; idx ++) {
        l1_item = *(l1_table + idx);
        l1_item = be64_to_cpu(l1_item);
        l1_item = l1_item & 0x3FFFFFFFFFFFFFFF;
        if(idx == 0) { printf("l1[%lld]=%lld. 0X%X.\n", idx, l1_item, l1_item); }
        memcpy(l1_table + idx, &l1_item, sizeof(l1_item));
    }
    memcpy(&l1_item, l1_table, sizeof(l1_item));
    debug_print_table_64(l1_table, l1_size);
    printf("----- Level 1 Table -----<<\n");
    printf("\n");

    /* refcount table */
    printf(">>----- Refcount Table -----\n");
    refcount_table_cnt = cluster_bits >> 3;
    printf("refcount_table_cnt=%ld.\n", refcount_table_cnt);
    refcount_table = (uint64_t *) malloc(sizeof(uint64_t) * (refcount_table_cnt + 1));
    if (refcount_table == NULL) {
        fprintf(stderr, "Refcount table alloc error.\n");
        returnCode = 1; goto end_info;
    }
    memset(refcount_table, 0, sizeof(uint64_t) * (refcount_table_cnt + 1));
    if (fseek(pFile, refcount_table_offset, SEEK_SET)) { printf("fseek error(%lld).\n", refcount_table_offset); returnCode = 1; goto end_info; }
    printf("refcount table offset=%lld, 0X%X.\n", refcount_table_offset, refcount_table_offset);
    /* 引用计数表在镜像文件中也应该是连续存储1个或多个簇的，所以也可以1次性读取，至少在4GB时是这样的 */
    readedcnt = fread(refcount_table, sizeof(uint64_t), refcount_table_cnt, pFile);
    if (readedcnt != refcount_table_cnt) {
        fprintf(stderr, "read refcount table error(%d != %d).\n", readedcnt, refcount_table_cnt);
        returnCode = 1; goto end_info;
    }
    for (idx = 0; idx < refcount_table_cnt; idx ++) {
        ref_table_item = *(refcount_table + idx);
        ref_count_offset = be64_to_cpu(ref_table_item);
        printf("refcount[%lld]=0X%X.\n", idx, ref_count_offset);
        memcpy(refcount_table + idx, &ref_count_offset, sizeof(ref_count_offset));
    }
    memcpy(&ref_count_offset, refcount_table, sizeof(ref_count_offset));
    printf("引用计数表在镜像文件中的位置[(%lld, 0X%04X)-", refcount_table_offset, refcount_table_offset);
    printf("(%lld, 0X%04X))\n", ref_count_offset, ref_count_offset);
    debug_print_table_64(refcount_table, refcount_table_cnt);
    printf("----- Refcount Table -----<<\n");
    printf("\n");

    /* refcount */
    printf(">>----- Refcount Block -----\n");
    printf("!!!引用计数块在镜像文件中似乎不是连续存储的，那么1个引用计数块的大小应该是1个簇。\n");
    /*
    refcount_cnt = (uint32_t) ((l1_item - ref_count_offset) / sizeof(uint16_t));
    printf("refcount_cnt1=%ld.l1_item=%lld.\n", (refcount_cnt), l1_item);
    if (l1_item == 0) {
        printf("引用计数块在镜像文件中的位置[(%lld, 0X%04X)-", ref_count_offset, ref_count_offset);
        printf("(%lld, 0X%04X))\n", (file_size + 0LL), (file_size + 0LL));
        refcount_cnt = ((file_size - (uint32_t) ref_count_offset) / sizeof(uint16_t));
        printf("refcount_cnt2=%ld.\n", (refcount_cnt));
    } else {
        printf("引用计数块在镜像文件中的位置[(%lld, 0X%04X)-", ref_count_offset, ref_count_offset);
        printf("(%lld, 0X%04X))\n", l1_item, l1_item);
    }
    */
    printf("引用计数块在镜像文件中的位置[(%lld, 0X%04X)-", ref_count_offset, ref_count_offset);
    printf("(%lld, 0X%04X))\n", (ref_count_offset + cluster_size), (ref_count_offset + cluster_size));
    refcount_cnt = cluster_size / sizeof(uint16_t);
    printf("refcount_cnt=%ld.\n", refcount_cnt);
    refcount_block = (uint16_t *) malloc(sizeof(uint16_t) * (refcount_cnt + 1));
    if (refcount_block == NULL) {
        fprintf(stderr, "Refcount block alloc error.\n");
        returnCode = 1; goto end_info;
    }
    memset(refcount_block, 0, sizeof(uint16_t) * (refcount_cnt + 1));

    if (fseek(pFile, ref_count_offset, SEEK_SET)) {printf("fseek error(%lld).\n", ref_count_offset); returnCode = 1; goto end_info;}
    printf("refcount block offset=%lld, 0X%X, count=%ld.\n", ref_count_offset, ref_count_offset, refcount_cnt);
    readedcnt = fread(refcount_block, sizeof(short), refcount_cnt, pFile);
    if (readedcnt != refcount_cnt) {
        fprintf(stderr, "read refcount error(%d != %d).\n", readedcnt, refcount_cnt);
        returnCode = 1; goto end_info;
    }
    for (idx = 0; idx < refcount_cnt; idx ++) {
        ref_item = *(refcount_block + idx);
        ref_item = be16_to_cpu(ref_item);
        /* printf("refcount[%lld]=%X.%X,\n", idx, be16_to_cpu(ref_item), ref_item); */
        memcpy(refcount_block + idx, &ref_item, sizeof(ref_item));
        /* if (idx > 10) { break; } */
    }
    debug_print_table_16(refcount_block, refcount_cnt);
    printf("----- Refcount Block -----<<\n");
    printf("\n");
    if (l1_item == 0) { goto end_info; }

    /* L2 */
    printf(">>----- Level 2 Table -----\n");
    printf("L2 Table offset=%lld, 0X%X.\n", l1_item, l1_item);
    printf("\n");
    l2_table = print_l1_table_64(l1_table, l1_size, pFile, cluster_size);
    l2_size = l1_size * 512;
    printf("L2 size:%ld.\n", l2_size);
    debug_print_table_64(l2_table, l2_size);
    printf("----- Level 2 Table -----<<\n");
    printf("\n");

    /* Partition */
    printf(">>----- Partition Table -----\n");
    pe_table = print_partition_table_64(l1_table, l1_size, l2_table, l2_size, pFile, cluster_size);
    print_list(pe_table);
    printf("----- Partition Table -----<<\n");
    printf("\n");

    /* VBRs */
    printf(">>----- VBR Table -----\n");
    print_vbr(pe_table, l2_table, l2_size, pFile);
    printf("----- VBR Table -----<<\n");
    printf("\n");


    /* F6 Sector */
    printf(">>----- F6 Sector -----\n");
    print_f6_sector(pe_table, l2_table, l2_size, pFile);
    printf("----- F6 Sector -----<<\n");
    printf("\n");


    goto end_info;
err_info:
end_info:
    /* 处理结束 */
    free_list(pe_table);
    if (refcount_block != NULL) { free(refcount_block); refcount_block = NULL; }
    if (refcount_table != NULL) { free(refcount_table); refcount_table = NULL; }
    if (l2_table != NULL) {free(l2_table); l2_table = NULL; }
    if (l1_table != NULL) {free(l1_table); l1_table = NULL; }
    if (pFile != NULL) { fclose(pFile); pFile = NULL; }
    return returnCode;
}
uint64_t get_bytesize(const char * size) {
    int len = strlen(size);
    printf("%d:%s.\n", len, size);
    char b = 'b';
    uint64_t a = 1LL;
    int pos = len - 1;
    if (size[pos] == 'B' || size[pos] == 'b') {
        pos --;
    }
    if (size[pos] == 'K' || size[pos] == 'k') {
        a = 1024LL;
        pos --;
    }
    if (size[pos] == 'M' || size[pos] == 'm') {
        a = 1024LL * 1024LL;
        pos --;
    }
    if (size[pos] == 'G' || size[pos] == 'g') {
        a = 1024LL * 1024LL * 1024LL;
        pos --;
    }
    if (size[pos] == 'T' || size[pos] == 't') {
        a = 1024LL * 1024LL * 1024LL * 1024LL;
        pos --;
    }
    printf("a=%lld.\n", a);
    printf("pos=%d.\n", pos);
    char * tmp = (char *) malloc(pos + 2);
    memset(tmp, 0, pos + 2);
    memcpy(tmp, size, pos + 1);
    printf("[%s].\n", tmp);
    uint64_t result = atoll(tmp);
    free(tmp);
    tmp = NULL;
    result *= a;
    printf("size=%lld.\n", result);
    return result;
}


int get_partition_no(const char * dev) {
    /* 变量定义 */
    int returnCode;
    int len;
    char * p;
    char * buf;
    int pos;

    /* 变量初始化 */
    returnCode = -1;
    len = strlen(dev);
    p = dev;
    buf = NULL;
    pos = -1;

    /* 处理开始 */
    if (len <= 0) { goto end_get_partition_no; }
    printf("param=%s.\n", dev);
    buf = (char *) malloc(len + 1);
    if (buf== NULL) { goto end_get_partition_no; }
    memset(buf, 0, len + 1);
    while(*p != 0x00) {
        if ('0' <= *p && *p <= '9') {
            pos ++;
            *(buf + pos) = *p;
        } else {
            if (pos >= 0) { break; }
        }
        p ++;
    }
    returnCode = atoi(buf);
    goto end_get_partition_no;
err_get_partition_no:
end_get_partition_no:
    /* 处理结束 */
    if (buf != NULL) { free(buf); buf = NULL; }
    printf("partition no=%d.\n", returnCode);
    return returnCode;
}

int main(int argc, char * argv[]) {
    /* 变量定义 */
    /* 变量初始化 */
    int idx = 0;
    uint64_t total_size = 0;
    size_t cluster_size = 4096;
    char format[6];
    char * clusterSize = "";
    char * fileSize = "";
    int partition_type = 0;
    int file_system_id = 0;
    char * mbrfile = "";
    int partition_no = -1;
    char * src_file = "";
    char * dst_file = "";
    char * cp_option = "to";

    /* 处理开始 */
    if (sizeof(VBRFAT1216) != 512) {
        printf("please confirm #pragma pack(1) in your program.\n");
        return -1;
    }
    memset(format, 0, sizeof(format));
    memcpy(format, "auto_", 5);

    for (idx = 0; idx < argc; idx ++) { printf("参数[%d]=%s.\n", idx, argv[idx]); }
    if (argc < 3) { show_usage(); goto end_main; }

    if (strlen("create") == strlen(argv[2]) && memcmp("create", argv[2], strlen("create")) == 0) {
        printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~create.\n");
        for (idx = 3; idx < argc; idx ++) {
            if (memcmp("-f", argv[idx], strlen("-f")) == 0) {
                if ((idx+ 1) < argc) {
                    memset(format, 0, sizeof(format));
                    memcpy(format, argv[idx + 1], (strlen(argv[idx + 1]) <= 5, strlen(argv[idx + 1]), 5));
                    idx ++;
                } else {
                    show_usage();
                    goto end_main;
                }
            } else if (memcmp("-cs", argv[idx], strlen("-cs")) == 0) {
                if ((idx+ 1) < argc) {
                    clusterSize = argv[idx + 1];
                    idx ++;
                } else {
                    show_usage();
                    goto end_main;
                }
            } else {
                fileSize = argv[idx];
            }
        }
        printf("fileSize=[%s]\n", fileSize);
        if (strlen(fileSize) <= 0) { show_usage(); goto end_main; }
        else { total_size = get_bytesize(fileSize); }

        if (total_size < 0) { show_usage(); goto end_main; }
        /* KB */
        if (total_size % 1024 != 0) { show_usage(); goto end_main; }

        printf("fileSize=[%s]\n", clusterSize);
        if (strlen(clusterSize) > 0) { cluster_size = get_bytesize(clusterSize); }
        if (cluster_size <= 0) { show_usage(); goto end_main; }
        if (cluster_size % 512 != 0) { show_usage(); goto end_main; }
        printf("format=[%s]\n", format);
        if (strlen(format) < 5) { show_usage(); goto end_main; }
        if (memcmp(format, "auto_", 5) == 0) { memcpy(format, "qcow2", 5); }
        if (memcmp(format, "qcow2", 5) != 0) { show_usage(); goto end_main; }

        create(argv[1], total_size, cluster_size);
        goto end_main;
    }
    if (strlen("info") == strlen(argv[2]) && memcmp("info", argv[2], strlen("info")) == 0) {
        printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~info.\n");
        info(argv[1]);
        goto end_main;
    }
    if (strlen("fdisk") == strlen(argv[2]) && memcmp("fdisk", argv[2], strlen("fdisk")) == 0) {
        printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~fdisk ");
        if (argc < 5) { show_usage(); goto end_main; }
        if (strlen("create") == strlen(argv[3]) && memcmp("create", argv[3], strlen("create")) == 0) {
            printf("create ");
            if (memcmp("PrimaryPartition", argv[4], strlen("PrimaryPartition")) == 0) {
                printf("PrimaryPartition ");
                partition_type = 1;
            } else if (memcmp("ExtendedPartition", argv[4], strlen("ExtendedPartition")) == 0) {
                printf("ExtendedPartition ");
                partition_type = 2;
            } else if (memcmp("LogicalPartition", argv[4], strlen("LogicalPartition")) == 0) {
                printf("LogicalPartition ");
                partition_type = 3;
            } else  { show_usage(); goto end_main; }

            for (idx = 5; idx < argc; idx ++) {
                if (memcmp("-f", argv[idx], strlen("-f")) == 0) {
                    if ((idx+ 1) < argc) {
                        memset(format, 0, sizeof(format));
                        memcpy(format, argv[idx + 1], (strlen(argv[idx + 1]) <= 5, strlen(argv[idx + 1]), 5));
                        idx ++;
                    } else {
                        show_usage();
                        goto end_main;
                    }
                } else if (memcmp("-cs", argv[idx], strlen("-cs")) == 0) {
                    if ((idx+ 1) < argc) {
                        clusterSize = argv[idx + 1];
                        idx ++;
                    } else {
                        show_usage();
                        goto end_main;
                    }
                } else if (memcmp("-m", argv[idx], strlen("-m")) == 0) {
                    if ((idx+ 1) < argc) {
                        mbrfile = argv[idx + 1];
                        idx ++;
                    } else {
                        show_usage();
                        goto end_main;
                    }
                } else {
                    fileSize = argv[idx];
                }
            }
            
            /* check */
            printf("fileSize=[%s]\n", fileSize);
            /* if (strlen(fileSize) <= 0) { show_usage(); goto end_main; }
            else { total_size = get_bytesize(fileSize); }
            if (total_size <= 0) { show_usage(); goto end_main; } */
            if (strlen(fileSize) > 0) {
                total_size = get_bytesize(fileSize);
            }
            if (total_size % 512 != 0) { show_usage(); goto end_main; }

            printf("clusterSize=[%s]\n", clusterSize);
            if (strlen(clusterSize) > 0) { cluster_size = get_bytesize(clusterSize); }
            if (cluster_size <= 0) { show_usage(); goto end_main; }
            if (cluster_size % 512 != 0) { show_usage(); goto end_main; }

            printf("mbrfile=[%s]\n", mbrfile);
            if (strlen(mbrfile) <= 0) { show_usage(); goto end_main; }

            printf("format=[%s]\n", format);
            if (strlen(format) < 5) { show_usage(); goto end_main; }
            if (memcmp(format, "auto_", 5) != 0
            &&  memcmp(format, "fat12", 5) != 0
            &&  memcmp(format, "fat16", 5) != 0
            &&  memcmp(format, "fat32", 5) != 0) { show_usage(); goto end_main; }

            create_partition(argv[1], partition_type, total_size, mbrfile, format);
        } else if (strlen("delete") == strlen(argv[3]) && memcmp("delete", argv[3], strlen("delete")) == 0) {
            printf("delete ");
            if (strlen(argv[4]) <= 0) { show_usage(); goto end_main; }
            delete_partition(argv[1], atoi(argv[4]));
        } else  { show_usage(); goto end_main; }
        printf("\n");
        goto end_main;
    }
    if (strlen("format") == strlen(argv[2]) && memcmp("format", argv[2], strlen("format")) == 0) {
        printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~format.\n");
        if (argc < 4) { show_usage(); goto end_main; }
        for (idx = 3; idx < argc; idx ++) {
            if (memcmp("-f", argv[idx], strlen("-f")) == 0) {
                if ((idx+ 1) < argc) {
                    memset(format, 0, sizeof(format));
                    memcpy(format, argv[idx + 1], (strlen(argv[idx + 1]) <= 5, strlen(argv[idx + 1]), 5));
                    idx ++;
                } else {
                    show_usage();
                    goto end_main;
                }
            } else if (memcmp("-m", argv[idx], strlen("-m")) == 0) {
                if ((idx+ 1) < argc) {
                    mbrfile = argv[idx + 1];
                    idx ++;
                } else {
                    show_usage();
                    goto end_main;
                }
            } else {
                partition_no = get_partition_no(argv[idx]);
            }
        } /* for */
        printf("partition_no=[%d]\n", partition_no);
        if (partition_no <= 0) { show_usage(); goto end_main; }

        printf("format=[%s]\n", format);
        if (strlen(format) < 5) { show_usage(); goto end_main; }
        if (memcmp(format, "auto_", 5) != 0
        &&  memcmp(format, "fat12", 5) != 0
        &&  memcmp(format, "fat16", 5) != 0
        &&  memcmp(format, "fat32", 5) != 0) { show_usage(); goto end_main; }

        printf("mbrfile=[%s]\n", mbrfile);
        if (strlen(mbrfile) <= 0) { show_usage(); goto end_main; }

        format_partition(argv[1], partition_no, format, mbrfile);
        goto end_main;
    }
    if (strlen("copy") == strlen(argv[2]) && memcmp("copy", argv[2], strlen("copy")) == 0) {
        printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~copy.\n");
        if (argc < 6) { show_usage(); goto end_main; }
        if (memcmp(argv[4], "from", 2) == 0 && memcmp(argv[4], "from", 4) == 0) {
            /* src to dst*/
            cp_option = argv[4];
            src_file = argv[5];
            dst_file = argv[3];
        } else {
            /* src to dst*/
            src_file = argv[3];
            dst_file = argv[5];
        }
        int copy_direction = 1; /* 从外部到镜像文件 */
        if (memcmp(dst_file, "/drv", 4) != 0) {
            copy_direction = 2; /* 从镜像文件到外部 */
        }
        printf("复制方向%d.\n", copy_direction);
        if (copy_direction == 1) {
            copy_file_or_folder(argv[1], dst_file, src_file);
        } else {
            read_file_or_folder(argv[1], dst_file, src_file);
        }
        goto end_main;
    }
    if (strlen("delete") == strlen(argv[2]) && memcmp("delete", argv[2], strlen("delete")) == 0) {
        printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~delete.\n");
        delete_file_or_folder(argv[1]);
        goto end_main;
    }

    show_usage();
    goto end_main;
err_main:
end_main:
    /* 处理结束 */
    printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ END.\n");
    return 0;
}

int fun() {
    /* 变量定义 */
    int returnCode;

    /* 变量初始化 */
    returnCode = 0;

    /* 处理开始 */
    printf(">>----- fun begin -----\n");

    goto end_fun;
err_fun:
end_fun:
    /* 处理结束 */
    printf("----- fun end -----<<\n");
    return returnCode;
}

int main1(int argc, char * argv[]) {
    uint32_t test[5];
    test[0] = 0x0FFFFFF8;
    test[1] = 0x0FFFFFFF;
    test[2] = 3;
    test[3] = 4;
    test[4] = 5;
    // char * buf = make_fat(test, 5, 1, 32);
    // char * buf = make_fat(test, 5, 1, 16);
    char * buf = (char *) malloc(512);
    buf = make_fat(test, 5, 1, 12, buf);
    int idx = 0;
    for (; idx < 512; idx ++) {
        printf("%02X ", *(buf + idx));
        if ((idx + 1) % 16 == 0) {
            printf("\n");
        }
    }
    return 0;
}
