/*
 * 
 */

#define _FILE_OFFSET_BITS 64

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

int show_usage(void) {
    /* 变量定义 */

    /* 变量初始化 */

    /* 处理开始 */
    printf("edqcow2 <qcow2 img file> create [size]\n");
    printf("edqcow2 <qcow2 img file> fdisk <num> [size1, size2]\n");
    printf("edqcow2 <qcow2 img file> format <filesystem fat etc.>\n");
    printf("edqcow2 <qcow2 img file> init fat12 1474560.\n");
    printf("edqcow2 <qcow2 img file> write file <file> to disk H-C-S\n");
    printf("edqcow2 <qcow2 img file> write file <file> to dir <file>\n");

    /* 处理结束 */
    return -1;
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

    refcount_block = malloc(ref_clusters * cluster_size);
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

    fclose(pFile);
    pFile = NULL;

    free(refcount_table);
    free(refcount_block);
    refcount_table = NULL;
    refcount_block = NULL;
    /* 处理结束 */
    return 0;
}

int create_partition(const char * filename, int partition_type, uint64_t total_size) {
    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    printf("file=%s.\n", filename);
    printf("partition_type=%d.\n", partition_type);
    printf("total_size=%lld.\n", total_size);
    
    goto end_create_partition;
err_create_partition:
end_create_partition:
    /* 处理结束 */
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

uint32_t get_l1_index(uint32_t in) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    uint32_t a = in / 8;
    /* 处理结束 */
    return a / 512;
}

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

uint32_t get_cluster_index(uint32_t in) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    uint32_t a = in / 8;
    return (in - (a * 8)) * 512;
    /* 处理结束 */
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
    printf("\n");
    /* 处理结束 */
}

uint64_t *  print_l1_table_64(const uint64_t * table, const uint32_t size, FILE * pFile, uint32_t cluster_size) {

    /* 变量定义 */
    size_t readedcnt;

    /* 变量初始化 */
    /* 处理开始 */
    uint64_t idx    = -1;
    int      idy    = -1;
    uint64_t idz    =  0;
    uint64_t offset = -1;
    int max_cnt     = cluster_size / 8;
    uint64_t l2_item = -1LL;
    uint64_t * l2_table = NULL;

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
        idz= 0;
        if( fseek(pFile, offset, SEEK_SET) ) { goto err_print_l1_table_64; }
        /* 1个完整的簇存储，所以可以一次读取。 */
        readedcnt = fread(l2_table + idx * max_cnt, sizeof(uint64_t), max_cnt, pFile);
        if (readedcnt != max_cnt) {
            fprintf(stderr, "read level 2 table error(%d != %d).\n", readedcnt, max_cnt);
            goto err_print_l1_table_64;
        }
        for (idy = 0; idy < max_cnt; idy ++) {
            l2_item = *(l2_table + idx * max_cnt + idy);
            if (l2_item == 0LL) { continue; }
            l2_item = be64_to_cpu(l2_item);
            l2_item = l2_item & 0x3FFFFFFFFFFFFFFF;
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

void print_partition_entry(const PartitionEntry * pPE) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
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
    uint16_t bpb_BytesPerSector;
    memcpy(&bpb_BytesPerSector, v->bpb.bpb_BytesPerSector, sizeof(v->bpb.bpb_BytesPerSector));
    printf("bpb_BytesPerSector=%d.\n", bpb_BytesPerSector);
    printf("bpb_SectorsPerCluster=%d.\n", v->bpb.bpb_SectorsPerCluster[0]);
    uint16_t bpb_ReservedSectorst;
    memcpy(&bpb_ReservedSectorst, v->bpb.bpb_ReservedSectorst, sizeof(v->bpb.bpb_ReservedSectorst));
    printf("bpb_ReservedSectorst=%d.\n", bpb_ReservedSectorst);
    printf("bpb_FatCopies=%d.\n", v->bpb.bpb_FatCopies[0]);
    uint16_t bpb_RootDirEntries;
    memcpy(&bpb_RootDirEntries, v->bpb.bpb_RootDirEntries, sizeof(v->bpb.bpb_RootDirEntries));
    printf("bpb_RootDirEntries=%d.\n", bpb_RootDirEntries);
    uint16_t bpb_NumSectors;
    memcpy(&bpb_NumSectors, v->bpb.bpb_NumSectors, sizeof(v->bpb.bpb_NumSectors));
    printf("bpb_NumSectors=%d.\n", bpb_NumSectors);
    printf("bpb_MediaType=%d.\n", v->bpb.bpb_MediaType[0]);
    uint16_t bpb_SectorsPerFAT;
    memcpy(&bpb_SectorsPerFAT, v->bpb.bpb_SectorsPerFAT, sizeof(v->bpb.bpb_SectorsPerFAT));
    printf("bpb_SectorsPerFAT=%d.\n", bpb_SectorsPerFAT);
    uint16_t bpb_SectorsPerTrack;
    memcpy(&bpb_SectorsPerTrack, v->bpb.bpb_SectorsPerTrack, sizeof(v->bpb.bpb_SectorsPerTrack));
    printf("bpb_SectorsPerTrack=%d.\n", bpb_SectorsPerTrack);
    uint16_t bpb_NumberOfHeads;
    memcpy(&bpb_NumberOfHeads, v->bpb.bpb_NumberOfHeads, sizeof(v->bpb.bpb_NumberOfHeads));
    printf("bpb_NumberOfHeads=%d.\n", bpb_NumberOfHeads);
    uint32_t bpb_HiddenSectors;
    memcpy(&bpb_HiddenSectors, v->bpb.bpb_HiddenSectors, sizeof(v->bpb.bpb_HiddenSectors));
    printf("bpb_HiddenSectors=%d.\n", bpb_HiddenSectors);
    uint32_t bpb_SectorsBig;
    memcpy(&bpb_SectorsBig, v->bpb.bpb_SectorsBig, sizeof(v->bpb.bpb_SectorsBig));
    printf("bpb_SectorsBig=%d.\n", bpb_SectorsBig);
    printf("bs_DrvNum=%d.\n", v->bs_DrvNum[0]);
    printf("bs_Reaserved1=%d.\n", v->bs_Reaserved1[0]);
    printf("bs_Bootsig=%d.\n", v->bs_Bootsig[0]);
    uint16_t bs_VolID1;
    memcpy(&bs_VolID1, v->bs_VolID, sizeof(uint16_t));
    uint16_t bs_VolID2;
    memcpy(&bs_VolID2, v->bs_VolID + 2, sizeof(uint16_t));
    printf("bs_VolID=%04X-%04X.\n", bs_VolID2, bs_VolID1);
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
    uint16_t bpb_BytesPerSector;
    memcpy(&bpb_BytesPerSector, v->bpb.bpb_BytesPerSector, sizeof(v->bpb.bpb_BytesPerSector));
    printf("bpb_BytesPerSector=%d.\n", bpb_BytesPerSector);
    printf("bpb_SectorsPerCluster=%d.\n", v->bpb.bpb_SectorsPerCluster[0]);
    uint16_t bpb_ReservedSectorst;
    memcpy(&bpb_ReservedSectorst, v->bpb.bpb_ReservedSectorst, sizeof(v->bpb.bpb_ReservedSectorst));
    printf("bpb_ReservedSectorst=%d.\n", bpb_ReservedSectorst);
    printf("bpb_FatCopies=%d.\n", v->bpb.bpb_FatCopies[0]);
    uint16_t bpb_RootDirEntries;
    memcpy(&bpb_RootDirEntries, v->bpb.bpb_RootDirEntries, sizeof(v->bpb.bpb_RootDirEntries));
    printf("bpb_RootDirEntries=%d.\n", bpb_RootDirEntries);
    uint16_t bpb_NumSectors;
    memcpy(&bpb_NumSectors, v->bpb.bpb_NumSectors, sizeof(v->bpb.bpb_NumSectors));
    printf("bpb_NumSectors=%d.\n", bpb_NumSectors);
    printf("bpb_MediaType=%d %X.\n", v->bpb.bpb_MediaType[0], v->bpb.bpb_MediaType[0]);
    uint16_t bpb_SectorsPerFAT;
    memcpy(&bpb_SectorsPerFAT, v->bpb.bpb_SectorsPerFAT, sizeof(v->bpb.bpb_SectorsPerFAT));
    printf("bpb_SectorsPerFAT=%d.\n", bpb_SectorsPerFAT);
    uint16_t bpb_SectorsPerTrack;
    memcpy(&bpb_SectorsPerTrack, v->bpb.bpb_SectorsPerTrack, sizeof(v->bpb.bpb_SectorsPerTrack));
    printf("bpb_SectorsPerTrack=%d.\n", bpb_SectorsPerTrack);
    uint16_t bpb_NumberOfHeads;
    memcpy(&bpb_NumberOfHeads, v->bpb.bpb_NumberOfHeads, sizeof(v->bpb.bpb_NumberOfHeads));
    printf("bpb_NumberOfHeads=%d.\n", bpb_NumberOfHeads);
    uint32_t bpb_HiddenSectors;
    memcpy(&bpb_HiddenSectors, v->bpb.bpb_HiddenSectors, sizeof(v->bpb.bpb_HiddenSectors));
    printf("bpb_HiddenSectors=%d.\n", bpb_HiddenSectors);
    uint32_t bpb_SectorsBig;
    memcpy(&bpb_SectorsBig, v->bpb.bpb_SectorsBig, sizeof(v->bpb.bpb_SectorsBig));
    printf("bpb_SectorsBig=%d.\n", bpb_SectorsBig);

    uint32_t bpb_SectorsPerFAT32;
    memcpy(&bpb_SectorsPerFAT32, v->bpb.bpb_SectorsPerFAT32, sizeof(v->bpb.bpb_SectorsPerFAT32));
    printf("bpb_SectorsPerFAT32=%d.\n", bpb_SectorsPerFAT32);
    uint16_t bpb_Flags;
    memcpy(&bpb_Flags, v->bpb.bpb_Flags, sizeof(v->bpb.bpb_Flags));
    printf("bpb_Flags=%d.\n", bpb_Flags);
    uint16_t bpb_FSVersion;
    memcpy(&bpb_FSVersion, v->bpb.bpb_FSVersion, sizeof(v->bpb.bpb_FSVersion));
    printf("bpb_FSVersion=%d.\n", bpb_FSVersion);
    uint32_t bpb_RootClusterNo;
    memcpy(&bpb_RootClusterNo, v->bpb.bpb_RootClusterNo, sizeof(v->bpb.bpb_RootClusterNo));
    printf("bpb_RootClusterNo=%d.\n", bpb_RootClusterNo);
    uint16_t bpb_FSInfo;
    memcpy(&bpb_FSInfo, v->bpb.bpb_FSInfo, sizeof(v->bpb.bpb_FSInfo));
    printf("bpb_FSInfo=%d.\n", bpb_FSInfo);
    uint16_t bpb_BakBootSec;
    memcpy(&bpb_BakBootSec, v->bpb.bpb_BakBootSec, sizeof(v->bpb.bpb_BakBootSec));
    printf("bpb_BakBootSec=%d.\n", bpb_BakBootSec);

    printf("bs_DrvNum=%d.\n", v->bs_DrvNum[0]);
    printf("bs_Reaserved1=%d.\n", v->bs_Reaserved1[0]);
    printf("bs_Bootsig=%d.\n", v->bs_Bootsig[0]);
    uint16_t bs_VolID1;
    memcpy(&bs_VolID1, v->bs_VolID, sizeof(uint16_t));
    uint16_t bs_VolID2;
    memcpy(&bs_VolID2, v->bs_VolID + 2, sizeof(uint16_t));
    printf("bs_VolID=%04X-%04X.\n", bs_VolID2, bs_VolID1);
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

/*--------------------------------------*/
void print_list(PartitionEntryItem * pt) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    printf("========= this is a test for list.\n");
    PartitionEntryItem * p = pt;
    while(p != NULL) {
        printf("flag=%d sector_index=%d ", p->flag, p->sector_index);
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

        offset = *(table2 + get_l1_index(sector_index) * 512 + get_l2_index(sector_index));
        offset += get_cluster_index(sector_index);
        printf("%d = l1 =%d.l2=%d, cluster=%d, %lld. 0X%X.\n", sector_index, 
            get_l1_index(sector_index), get_l2_index(sector_index), get_cluster_index(sector_index), 
            offset, offset);
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

void print_vbr(PartitionEntryItem * pe_table, const uint64_t * table2, const uint32_t size2, FILE * pFile) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    size_t readedcnt;

    PartitionEntryItem * p = pe_table;
    while(p != NULL) {
        printf("flag=%d sector_index=%d start_sector_no=%d ", p->flag, p->sector_index, p->pe.start_sector_no);
        uint32_t sector_no = p->sector_index + p->pe.start_sector_no;
        uint32_t fat1 = sector_no;
        uint32_t fat2 = sector_no;
        uint32_t root = sector_no;
        uint32_t file = sector_no;

        // vbr
        printf("%d = l1 =%d.l2=%d, cluster=%d, \n", sector_no, 
            get_l1_index(sector_no), get_l2_index(sector_no), get_cluster_index(sector_no));
        uint64_t offset = -1;
        offset = *(table2 + get_l1_index(sector_no) * 512 + get_l2_index(sector_no));
        offset += get_cluster_index(sector_no);
        printf("offset=%lld %X.\n", offset, offset);
        if (fseek(pFile, offset, SEEK_SET) != 0) { printf("fseek error.%d.\n", ferror(pFile)); goto end_print_vbr;}
        unsigned char buf[512];
        memset(buf, 0, sizeof(buf));
        readedcnt = fread(&buf, 1, sizeof(buf), pFile);
        if (readedcnt != sizeof(buf)) {
            fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
            printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
            goto end_print_vbr;
        }
        printf("%X, %X %X.\n", buf[510], buf[511], p->pe.type);
        if (p->pe.type == 0x06 || p->pe.type == 0x0E) {
            /* FAT16 */
            /*
             06 DOS 3.31+: 16-bit FAT (over 32M)
             0E WIN95: DOS 16-bit FAT, LBA-mapped
             */
            if( buf[510] == 0x55 && buf[511] == 0xAA) {
                print_ary(buf, sizeof(buf));
                VBRFAT1216 vbr;
                memcpy(&vbr, buf, 512);
                print_vbr_fat_1216(&vbr);
                uint16_t bpb_ReservedSectorst;
                memcpy(&bpb_ReservedSectorst, vbr.bpb.bpb_ReservedSectorst, sizeof(uint16_t));
                fat1 += bpb_ReservedSectorst;
                fat2 += bpb_ReservedSectorst;
                root += bpb_ReservedSectorst;
                file += bpb_ReservedSectorst;
                uint16_t bpb_SectorsPerFAT;
                memcpy(&bpb_SectorsPerFAT, vbr.bpb.bpb_SectorsPerFAT, sizeof(uint16_t));
                fat2 += bpb_SectorsPerFAT;
                root += 2 * bpb_SectorsPerFAT;
                file += 2 * bpb_SectorsPerFAT;
                uint16_t bpb_RootDirEntries;
                memcpy(&bpb_RootDirEntries, vbr.bpb.bpb_RootDirEntries, sizeof(uint16_t));
                uint16_t bpb_BytesPerSector;
                memcpy(&bpb_BytesPerSector, vbr.bpb.bpb_BytesPerSector, sizeof(uint16_t));
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
                uint16_t bpb_ReservedSectorst;
                memcpy(&bpb_ReservedSectorst, vbr.bpb.bpb_ReservedSectorst, sizeof(uint16_t));
                fat1 += bpb_ReservedSectorst;
                fat2 += bpb_ReservedSectorst;
                root += bpb_ReservedSectorst;
                root += bpb_ReservedSectorst;
                uint32_t bpb_SectorsPerFAT32;
                memcpy(&bpb_SectorsPerFAT32, vbr.bpb.bpb_SectorsPerFAT32, sizeof(uint32_t));
                fat2 += bpb_SectorsPerFAT32;
                root += 2 * bpb_SectorsPerFAT32;
                file += 2 * bpb_SectorsPerFAT32;
                uint16_t bpb_RootDirEntries;
                memcpy(&bpb_RootDirEntries, vbr.bpb.bpb_RootDirEntries, sizeof(uint16_t));
                uint16_t bpb_BytesPerSector;
                memcpy(&bpb_BytesPerSector, vbr.bpb.bpb_BytesPerSector, sizeof(uint16_t));
                file += (32 * bpb_RootDirEntries) / bpb_BytesPerSector;
                printf("\n");
                
                // FAT32 FSInfo
                printf("FAT32 FSInfo.\n");
                uint16_t bpb_FSInfo;
                memcpy(&bpb_FSInfo, vbr.bpb.bpb_FSInfo, sizeof(uint16_t));
                offset = *(table2 + get_l1_index(sector_no + bpb_FSInfo) * 512 + get_l2_index(sector_no + bpb_FSInfo));
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
            printf("fat1=%d.%d %d %d \n", fat1, get_l1_index(fat1), get_l2_index(fat1), get_cluster_index(fat1));
            offset = *(table2 + get_l1_index(fat1) * 512 + get_l2_index(fat1));
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
            printf("fat2=%d.\n", fat2);
            offset = *(table2 + get_l1_index(fat2) * 512 + get_l2_index(fat2));
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
            offset = *(table2 + get_l1_index(root) * 512 + get_l2_index(root));
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
            print_ary(buf, sizeof(buf));
            printf("\n");

            /* File */
            printf("first file's 1 sector.\n");
            offset = *(table2 + get_l1_index(file) * 512 + get_l2_index(file));
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
    }

end_print_vbr:
    /* 处理结束 */
    return ;
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
    pFile = fopen(filename, "rw+b");
    if (pFile == NULL) { fprintf(stderr, "file(%s) open error(1).", filename); returnCode = 1; goto end_info; }

    printf("\n!!!WARNING!!! 现在的代码是不支持超过2GB的文件的!!!\n\n");
    printf("%s.\n", ansi_status);
    printf("sizeof(size_t) %d, sizeof(off_t) %d, sizeof(off64_t) %d\n", sizeof(size_t), sizeof(off_t), sizeof(off64_t));
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

    printf("QCOW2_MAGIC                  (4) = 0X%X,QCOW magic string.\n", be32_to_cpu(header.magic));
    printf("QCOW2_version                (4) = 0X%X,Version number (valid values are 2 and 3).\n", be32_to_cpu(header.version));
    printf("QCOW2_backing_file_offset    (8) = 0X%X,Offset into the image file at which the backing file name is stored (NB: The string is not null terminated). 0 if the image doesn't have a backing file.\n", be64_to_cpu(header.backing_file_offset));
    printf("QCOW2_backing_file_size      (4) = 0X%X,Length of the backing file name in bytes. Must not be longer than 1023 bytes. Undefined if the image doesn't have a backing file.\n", be32_to_cpu(header.backing_file_size));
    printf("QCOW2_cluster_bits           (4) = 0X%X,Number of bits that are used for addressing an offset within a cluster (1 << cluster_bits is the cluster size). Must not be less than 9 (i.e. 512 byte clusters).\n", cluster_bits);
    printf("cluster_size = %ld\n", cluster_size);
    printf("QCOW2_size                   (8) = %lld,", be64_to_cpu(header.size));
    printf("0X%010X,Virtual disk size in bytes.\n", be64_to_cpu(header.size));
    printf("                                        十六进制的值有不正确的可能。\n");
    printf("QCOW2_crypt_method           (4) = 0X%X,0 for no encryption;1 for AES encryption.\n", be32_to_cpu(header.crypt_method));
    printf("QCOW2_l1_size                (4) = 0X%X %ld,Number of entries in the active L1 table(MAX).\n", l1_size, l1_size);
    printf("*QCOW2_l1_table_offset       (8) = 0X%X,Offset into the image file at which the active L1 table starts. Must be aligned to a cluster boundary.\n", l1_table_offset);
    printf("*QCOW2_refcount_table_offset (8) = 0X%X,Offset into the image file at which the refcount table starts. Must be aligned to a cluster boundary.\n", refcount_table_offset);
    printf("QCOW2_refcount_table_clusters(4) = 0X%X,Number of clusters that the refcount table occupies.\n", be32_to_cpu(header.refcount_table_clusters));
    printf("QCOW2_nb_snapshots           (4) = 0X%X,Number of snapshots contained in the image.\n", be32_to_cpu(header.nb_snapshots));
    printf("QCOW2_snapshots_offset       (8) = 0X%X,Offset into the image file at which the snapshot table starts. Must be aligned to a cluster boundary.\n", be64_to_cpu(header.snapshots_offset));
    printf("----- Header -----<<\n");
    printf("\n");

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
    debug_print_table_64(l2_table, l2_size);
    printf("----- Level 2 Table -----<<\n");
    printf("\n");

    /* Partition */
    printf(">>----- Partition Table -----\n");
    printf("L2 Table offset=%lld, 0X%X.\n", l1_item, l1_item);
    pe_table = print_partition_table_64(l1_table, l1_size, l2_table, l2_size, pFile, cluster_size);
    print_list(pe_table);
    printf("----- Partition Table -----<<\n");
    printf("\n");

    /* VBRs */
    printf(">>----- VBR Table -----\n");
    print_vbr(pe_table, l2_table, l2_size, pFile);
    printf("----- VBR Table -----<<\n");
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

int main(int argc, char * argv[]) {
    /* 变量定义 */
    /* 变量初始化 */
    int idx = 0;
    uint64_t total_size = 0;
    size_t cluster_size = 4096;
    char * format = "";
    char * clusterSize = "";
    char * fileSize = "";
    int partition_type = 0;
    int file_system_id = 0;

    /* 处理开始 */
    for (idx = 0; idx < argc; idx ++) { printf("参数[%d]=%s.\n", idx, argv[idx]); }
    if (argc < 3) { show_usage(); goto end_main; }

    if (memcmp("create", argv[2], strlen("create")) == 0) {
        printf("create.\n");
        for (idx = 3; idx < argc; idx ++) {
            if (memcmp("-f", argv[idx], strlen("-f")) == 0) {
                if ((idx+ 1) < argc) {
                    format = argv[idx + 1];
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
        if (strlen(fileSize) <= 0) { show_usage(); goto end_main; }
        else { total_size = get_bytesize(fileSize); }
        if (total_size <= 0) { show_usage(); goto end_main; }
        if (total_size % 512 != 0) { show_usage(); goto end_main; }

        if (strlen(clusterSize) > 0) { cluster_size = get_bytesize(clusterSize); }
        if (cluster_size <= 0) { show_usage(); goto end_main; }
        if (cluster_size % 512 != 0) { show_usage(); goto end_main; }

        create(argv[1], total_size, cluster_size);
        goto end_main;
    }
    if (memcmp("info", argv[2], strlen("info")) == 0) {
        printf("info.\n");
        info(argv[1]);
        goto end_main;
    }
    if (memcmp("fdisk", argv[2], strlen("fdisk")) == 0) {
        printf("fdisk ");
        if (argc < 5) { show_usage(); goto end_main; }
        if (memcmp("create", argv[3], strlen("create")) == 0) {
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
                        format = argv[idx + 1];
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
            
            /* check */
            if (strlen(fileSize) <= 0) { show_usage(); goto end_main; }
            else { total_size = get_bytesize(fileSize); }
            if (total_size <= 0) { show_usage(); goto end_main; }
            if (total_size % 512 != 0) { show_usage(); goto end_main; }

            if (strlen(clusterSize) > 0) { cluster_size = get_bytesize(clusterSize); }
            if (cluster_size <= 0) { show_usage(); goto end_main; }
            if (cluster_size % 512 != 0) { show_usage(); goto end_main; }

            create_partition(argv[1], partition_type, total_size);
        } else if (memcmp("delete", argv[3], strlen("delete")) == 0) {
            printf("delete ");
            if (strlen(argv[4]) <= 0) { show_usage(); goto end_main; }
            delete_partition(argv[1], atoi(argv[4]));
        } else  { show_usage(); goto end_main; }
        printf("\n");
        goto end_main;
    }

    show_usage();
    goto end_main;
err_main:
end_main:
    /* 处理结束 */
    return 0;
}

void fun() {
    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */

    goto end_fun;
err_fun:
end_fun:
    /* 处理结束 */
    return ;
}
