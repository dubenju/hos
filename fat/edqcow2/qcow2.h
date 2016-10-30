#ifndef _QCOW2_H_
#define _QCOW2_H_

#define QCOW_MAGIC (('Q' << 24) | ('F' << 16) | ('I' << 8) | 0xfb)
#define QCOW_VERSION 2

#define QCOW_CRYPT_NONE 0
#define QCOW_CRYPT_AES  1

#define QCOW_MAX_CRYPT_CLUSTERS 32

/* indicate that the refcount of the referenced cluster is exactly one. */
#define QCOW_OFLAG_COPIED     (1LL << 63)
/* indicate that the cluster is compressed (they never have the copied flag) */
#define QCOW_OFLAG_COMPRESSED (1LL << 62)

#define REFCOUNT_SHIFT 1 /* refcount size is 2 bytes */

#define MIN_CLUSTER_BITS 9
#define MAX_CLUSTER_BITS 21

#define L2_CACHE_SIZE 16

#define BLOCK_FLAG_ENCRYPT 0

typedef struct QCowHeader {
    uint32_t magic;
    uint32_t version;
    uint64_t backing_file_offset;
    uint32_t backing_file_size;
    uint32_t cluster_bits;
    uint64_t size; /* in bytes */
    uint32_t crypt_method;
    uint32_t l1_size; /* XXX: save number of clusters instead ? */
    uint64_t l1_table_offset;
    uint64_t refcount_table_offset;
    uint32_t refcount_table_clusters;
    uint32_t nb_snapshots;
    uint64_t snapshots_offset;
} QCowHeader;

typedef struct _QCOW2_FILE {
    QCowHeader * pHeader;
    uint32_t     clustor_size;
    uint64_t *   pL1Table;
    uint32_t     l1_size;
    uint64_t *   pRefcountTable;
    uint32_t     refcount_table_cnt;
    uint16_t *   pRefcountBlock;
    uint32_t     refcount_cnt;
    uint64_t *   pL2Table;
    uint32_t     l2_size;
} QCOW2_FILE;

#endif // _QCOW2_H_
