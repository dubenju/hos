#ifndef _PARTITION_ENTRY_H_
#define _PARTITION_ENTRY_H_

typedef struct _PartitionEntry {
    unsigned char status;
    unsigned char start_head;
    unsigned char start_sector;
    unsigned char start_cylinder;
    unsigned char type;
    unsigned char end_head;
    unsigned char end_sector;
    unsigned char end_cylinder;
    uint32_t start_sector_no;
    uint32_t sector_total;
} PartitionEntry;

typedef struct _PartitionEntryItem {
    PartitionEntry pe;
    int flag;
    uint32_t sector_index;
    struct _PartitionEntryItem * pNext;
} PartitionEntryItem;

#endif // _PARTITION_ENTRY_H_
