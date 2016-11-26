#pragma pack (1)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

typedef struct _hrb_info {
    uint32_t stack_data_heap_size;
    uint32_t signature;
    uint32_t mem_size;
    uint32_t stack_data;
    uint32_t data_size;
    uint32_t data_data;
    uint32_t data_e9;
    uint32_t entry_point;
    uint32_t heap_offset;
} HRB_INFO;

int main(int argc, char * argv[]) {
    /* 变量定义 */
    int returnCode;
    FILE * pFile;
    HRB_INFO info;
    size_t read;

    /* 变量初始化 */
    returnCode = 0;
    pFile = NULL;

    /* 处理开始 */
    printf(">>----- main begin -----\n");
    if (argc < 2) {
        printf("file name");
        goto err_main;
    }

    pFile = fopen(argv[1], "rb");
    if (pFile == NULL) {
        printf("file [%s] open error.\n", argv[1]);
        goto err_main;
    }
    memset(&info, 0, sizeof(HRB_INFO));
    read = fread(&info, 1, sizeof(HRB_INFO), pFile);

    printf("stack_data_heap_size=%d.\n", info.stack_data_heap_size);
    printf("signature=%X.\n", info.signature);
    printf("mem_size=%d.\n", info.mem_size);
    printf("stack_data=%d.\n", info.stack_data);
    printf("data_size=%d.\n", info.data_size);
    printf("data_data=%d.\n", info.data_data);
    printf("data_e9=%X.\n", info.data_e9);
    printf("entry_point=%d.\n", info.entry_point);
    printf("heap_offset=%d.\n", info.heap_offset);

    goto end_main;
err_main:
end_main:
    /* 处理结束 */
    printf("----- main end -----<<\n");
    if (pFile != NULL) {
        fclose(pFile);
        pFile = NULL;
    }
 
    return returnCode;
}
