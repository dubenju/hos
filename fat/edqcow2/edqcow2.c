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

#define cpu_to_be64(x) \
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
    int fd;
    const char * filename;
    uint64_t refcount_table_offset;
    uint64_t refcount_block_offset;
    uint16_t * refcount_block;
    uint64_t * refcount_table;
    uint64_t tmp;

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






    fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0644);
    if (fd < 0) {
        return -1;
    }
    write(fd, &header, sizeof(header));

    lseek(fd, l1_table_offset, SEEK_SET);
    tmp = 0;
    for(i = 0;i < l1_size; i++) {
        write(fd, &tmp, sizeof(tmp));
    }

    lseek(fd, refcount_table_offset, SEEK_SET);
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

int main() {
    printf("test.sizeof(QCowHeader)=%d.\n", sizeof(QCowHeader));
    create();
    return 0;
}
