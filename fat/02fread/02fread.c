/*
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

void print_ary(unsigned char * buf, size_t size) {
    int idx =0;
    for (idx = 0; idx < size; idx ++) {
        printf("%02X ", *(buf + idx));
        if ((idx + 1) % 16 == 0) {printf("\n");}
    }
}


int main() {
    char * filename = "C:\\Users\\DBJ\\git\\hos\\tools\\qemu\\qemu_img\\qcow2_4g.qcow2";
    FILE* pFile = NULL;
    size_t readedcnt;

    printf("%d.\n", sizeof(char));
    printf("%d.\n", sizeof(unsigned char));
    //pFile = fopen(filename, "rw+");
    pFile = fopen(filename, "rw+b");
    if (pFile == NULL) {
        fprintf(stderr, "file error(1).");
        return 1;
    }
    fseek(pFile, 1130496, SEEK_SET);   // non-portable
    printf("off=%ld, %d.\n", 1130496, ftell(pFile));
    unsigned char buf[512];
    memset(buf, 0, sizeof(buf));
    print_ary(buf, 512);
    readedcnt = fread(buf, 1, 512, pFile);
    // readedcnt = fread(buf, sizeof(buf), sizeof(char), pFile);
    // readedcnt = fread(&buf, 512, 1, pFile);
    printf("%d,%d.\n", readedcnt, sizeof(buf));
    print_ary(buf, readedcnt);
    if (readedcnt != 512) {
        fprintf(stderr, "read MBR error[%d][%X].\n", ftell(pFile), ftell(pFile));
        printf("[%d][%d][%X].\n", ferror(pFile), ftell(pFile), ftell(pFile));
        goto end_print_partition_table_64;
    }
    printf("%x, %x.\n", buf[510], buf[511]);


end_print_partition_table_64:
    fclose(pFile);
    pFile = NULL;
    printf("\n");
    return 0;
}
