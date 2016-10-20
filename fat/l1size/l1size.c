/*
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

int main() {
    uint64_t total_size;
    int cluster_bits;
    int32_t l1_size;
    int l2_bits;
    int shift;

    cluster_bits = 12;

    /* l1_table_offset */
    l2_bits = cluster_bits - 3; // 2 ^ 3 = 8
    shift   = cluster_bits + l2_bits;
    printf("shift=%d.cluster_bits=%d.l2_bits=%d.\n", shift, cluster_bits, l2_bits);

    // 2MB 0X1
    total_size = 2LL * 1024 * 1024;
    l1_size = ((total_size + (1LL << shift) - 1) >> shift);
    printf("size:%lldMB=%ld,%X.\n", total_size / (1024LL * 1024LL), l1_size, l1_size);

    // 10MB 0X5
    total_size = 10LL * 1024 * 1024;
    l1_size = ((total_size + (1LL << shift) - 1) >> shift);
    printf("size:%lldMB=%ld,%X.\n", total_size / (1024LL * 1024LL), l1_size, l1_size);

    // 600MB 0X12C
    total_size = 600LL * 1024 * 1024;
    l1_size = ((total_size + (1LL << shift) - 1) >> shift);
    printf("size:%lldMB=%ld,%X.\n", total_size / (1024LL * 1024LL), l1_size, l1_size);

    // 4GB 0X800.
    total_size = 4LL * 1024 * 1024 * 1024;
    l1_size = ((total_size + (1LL << shift) - 1) >> shift);
    printf("size:%lldMB=%ld,%X.\n", total_size / (1024LL * 1024LL), l1_size, l1_size);

    // 1TB 0X80000
    total_size = 1LL * 1024 * 1024 * 1024 * 1024;
    l1_size = ((total_size + (1LL << shift) - 1) >> shift);
    printf("size:%lldMB=%ld,%X.\n", total_size / (1024LL * 1024LL), l1_size, l1_size);

    // 2TB 0X100000
    total_size = 2LL * 1024 * 1024 * 1024 * 1024;
    l1_size = ((total_size + (1LL << shift) - 1) >> shift);
    printf("size:%lldMB=%ld,%X.\n", total_size / (1024LL * 1024LL), l1_size, l1_size);

    return 0;
}
