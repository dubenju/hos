/*
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
// #include <linux/kernel.h>

#include "qcow2.h"

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

int show_usage(void) {
  printf("edqcow2 <qcow2 img file> create [size]\n");
  printf("edqcow2 <qcow2 img file> fdisk <num> [size1, size2]\n");
  printf("edqcow2 <qcow2 img file> format <filesystem fat etc.>\n");
  printf("edqcow2 <qcow2 img file> init fat12 1474560.\n");
  printf("edqcow2 <qcow2 img file> write file <file> to disk H-C-S\n");
  printf("edqcow2 <qcow2 img file> write file <file> to dir <file>\n");
  return -1;
}

int64_t align_offset(int64_t offset, int n)
{
    offset = (offset + n - 1) & ~(n - 1);
    return offset;
}


static int get_bits_from_size(size_t size)
{
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

    return res;
}

void qcow2_create_refcount_update(uint16_t * refcount_block, int64_t offset, int64_t size, size_t cluster_size, int cluster_bits) {
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
}


int create() {
    QCowHeader header;
    uint64_t total_size;
    int cluster_bits;
    int flags;
    int64_t l1_table_offset;
    int32_t l1_size;
    int64_t reftable_offset;
    int32_t reftable_clusters;
    size_t cluster_size;
    int header_size;
    int l2_bits;
    uint64_t offset;
    int shift;
    int ref_clusters;
    int old_ref_clusters;
    int i;
    FILE* fd = NULL;
    const char * filename;
    uint64_t refcount_table_offset;
    uint64_t refcount_block_offset;
    uint16_t * refcount_block;
    uint64_t * refcount_table;
    uint64_t tmp;
    size_t wrotencnt;

    total_size = (2 * 1024 * 1024) / 512; // 2M

    flags = 0;
    l1_table_offset = 0;
    l1_size = 0;
    reftable_offset = 0;
    reftable_clusters = 0;
    cluster_size = 65536;
    cluster_size = 4096;
    filename = ".\\test";

    memset(&header, 0, sizeof(header));
    /* magic */
    header.magic        = cpu_to_be32(QCOW_MAGIC);
    /* version */
    header.version      = cpu_to_be32(QCOW_VERSION);
    /* cluster_bits */
    // TODO:cluster_size
    cluster_bits = get_bits_from_size(cluster_size);
    if (cluster_bits < MIN_CLUSTER_BITS || cluster_bits > MAX_CLUSTER_BITS) {
        fprintf(stderr, "Cluster size must be a power of two between %d and %dk\n",
            1 << MIN_CLUSTER_BITS,
            1 << (MAX_CLUSTER_BITS - 10));
        return -1;
    }
    cluster_size = 1 << cluster_bits;
    header.cluster_bits = cpu_to_be32(cluster_bits);
    /* size */
    header.size         = cpu_to_be64(total_size * 512);
    /* crypt_method */
    if (flags & BLOCK_FLAG_ENCRYPT) {
        header.crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
    } else {
        header.crypt_method = cpu_to_be32(QCOW_CRYPT_NONE);
    }

    /* l1_table_offset */
    l2_bits = cluster_bits - 3;
    shift   = cluster_bits + l2_bits;
    l1_size = (((total_size * 512) + (1LL << shift) - 1) >> shift);
    header_size = sizeof(header);
    header_size = (header_size + 7) & ~7;
    offset = align_offset(header_size, cluster_size);
    printf("level1 offset %lld.\n", offset);
    l1_table_offset = offset;
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






    fd = fopen(filename, "rw+");
    if (fd == NULL) {
        fprintf(stderr, "file open error.\n");
        return -1;
    }
    wrotencnt = fwrite(&header, 1, sizeof(header), fd);

    lseek(fd, l1_table_offset, SEEK_SET);
    tmp = 0;
    for(i = 0;i < l1_size; i++) {
        fwrite(&tmp, 1, sizeof(tmp), fd);
    }

    fseek(fd, refcount_table_offset, SEEK_SET);
    write(fd, refcount_table, reftable_clusters * cluster_size);


    lseek(fd, refcount_block_offset, SEEK_SET);
    write(fd, refcount_block, ref_clusters * cluster_size);

    close(fd);


    free(refcount_table);
    free(refcount_block);
    refcount_table = NULL;
    refcount_block = NULL;
    return 0;
}

/*
 * 获取qcow2文件的信息
 * 在此基础上创建分区。
 */
int fdisk() {
    QCowHeader header;
    char * filename = ".\\test_fdisk";
    FILE* pFile = NULL;
    uint64_t offset;
    size_t readedcnt = 0;

    printf("this option will create partition on qcow2.\n");
    pFile = fopen(filename, "rw+");
    if (pFile == NULL) {
        fprintf(stderr, "file error(1).");
        return 1;
    }

    fseek(pFile, 0, SEEK_END);   // non-portable
    long file_size = ftell(pFile);
    printf("file's size=%ld.\n", file_size);
    rewind (pFile);

    memset(&header, 0, sizeof(header));
    printf("sizeof(header)=%d\n", sizeof(header));
    offset = 0;
    readedcnt = fread(&header, 1, sizeof(header), pFile);
    printf("readed count=%d\n", readedcnt);
    if (readedcnt != sizeof(header)) {
        fprintf(stderr, "qcow_handle_extension: ERROR: pread fail from offset %llu\n", (unsigned long long)offset);
        if (pFile != NULL) { fclose(pFile); pFile = NULL; }
        return 1;
    }
    printf("QCOW2_MAGIC = %X\n", be32_to_cpu(header.magic));
    printf("QCOW2_version = %X\n", be32_to_cpu(header.version));
    printf("QCOW2_backing_file_offset = %X\n", be64_to_cpu(header.backing_file_offset));
    printf("QCOW2_backing_file_size = %X\n", be64_to_cpu(header.backing_file_size));
    uint32_t cluster_bits = be32_to_cpu(header.cluster_bits);
    printf("QCOW2_cluster_bits = %X\n", cluster_bits);
    uint32_t cluster_size = 1 << cluster_bits;
    printf("cluster_size = %ld\n", cluster_size);
    printf("QCOW2_size = %X\n", be64_to_cpu(header.size));
    printf("QCOW2_crypt_method = %X\n", be32_to_cpu(header.crypt_method));
    uint32_t l1_size = be32_to_cpu(header.l1_size);
    printf("QCOW2_l1_size = %X\n", l1_size);
    uint64_t l1_table_offset = be64_to_cpu(header.l1_table_offset);
    printf("*QCOW2_l1_table_offset = %X\n", l1_table_offset);
    uint64_t refcount_table_offset = be64_to_cpu(header.refcount_table_offset);
    printf("*QCOW2_refcount_table_offset = %X\n", refcount_table_offset);
    printf("QCOW2_refcount_table_clusters = %X\n", be32_to_cpu(header.refcount_table_clusters));
    printf("QCOW2_nb_snapshots = %X\n", be32_to_cpu(header.nb_snapshots));
    printf("QCOW2_snapshots_offset = %X\n", be64_to_cpu(header.snapshots_offset));







    /* L1 */
    uint64_t idx = 0;
    uint64_t l1_item = 0;
    fseek(pFile, l1_table_offset, SEEK_SET);
    for (idx = 0; idx < l1_size; idx ++) {
        readedcnt = fread(&l1_item, 1, sizeof(uint64_t), pFile);
        if (readedcnt != sizeof(uint64_t)) {
            fprintf(stderr, "read l1 table error.\n");
            if (pFile != NULL) { fclose(pFile); pFile = NULL; }
            return 1;
        }
        printf("l1[%lld]=%ld.\n", idx, l1_item);
    }

    /* refcount table */
    uint32_t refcount_table_cnt = cluster_bits >> 3;
    printf("refcount_table_cnt=%ld.\n", refcount_table_cnt);
    uint64_t ref_table_item = 0;
    uint64_t ref_count_offset = -1;
    fseek(pFile, refcount_table_offset, SEEK_SET);
    for (idx = 0; idx < refcount_table_cnt; idx ++) {
        readedcnt = fread(&ref_table_item, 1, sizeof(uint64_t), pFile);
        if (readedcnt != sizeof(uint64_t)) {
            fprintf(stderr, "read refcount table error.\n");
            if (pFile != NULL) { fclose(pFile); pFile = NULL; }
            return 1;
        }
        ref_count_offset = be64_to_cpu(ref_table_item);
        printf("refcount[%lld]=%X.\n", idx, ref_count_offset);
    }

    /* refcount */
    uint32_t refcount_cnt = (uint32_t) ((ref_count_offset - l1_item) / 8);
    printf("refcount_cnt1=%ld.\n", (refcount_cnt));
    if (l1_item == 0) {
        refcount_cnt = ((file_size - (uint32_t) l1_item) / 8);
            printf("refcount_cnt2=%ld.\n", (refcount_cnt));
    }
    printf("refcount_cnt=%ld.\n", (refcount_cnt));
    //uint16_t ref_item = -1;
    short ref_item = -1;
    if (fseek(pFile, ref_count_offset, SEEK_SET)) {printf("fseek error(%ld).\n", ref_count_offset);}
    // fseek(pFile, 0, SEEK_CUR);
    // printf("offset=%lld, of=%ld, count=%ld.\n", ref_count_offset, ftell(pFile), refcount_cnt);
    for (idx = 0; idx < refcount_cnt; idx ++) {
        readedcnt = fread(&ref_item, 1, sizeof(short), pFile);
        if (readedcnt != sizeof(short)) {
            fprintf(stderr, "read refcount error(%d).\n", readedcnt);
            if (pFile != NULL) { fclose(pFile); pFile = NULL; }
            return 1;
        }
        printf("refcount[%ld]=%X.%X,\n", idx, be16_to_cpu(ref_item), ref_item);
        if (idx > 10) { break; }
    }

    if (pFile != NULL) { fclose(pFile); pFile = NULL; }
    return 0;
}

int main() {
    printf("test.sizeof(QCowHeader)=%d.\n", sizeof(QCowHeader));
    // create();
    fdisk();
    return 0;
}
