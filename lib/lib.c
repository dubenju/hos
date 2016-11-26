#pragma pack (1)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>


int main(int argc, char * argv[]) {
    /* 变量定义 */
    FILE * pFile;
    char ar_signature[9];

    char ar_fh[61];
    char ar_fh_identifier[17];
    char ar_fh_moditimestamp[13];
    char ar_fh_ownerid[7];
    char ar_fh_groupid[7];
    char ar_fh_filemode[9];
    char ar_fh_filesizebyte[11];
    char ar_fh_endchar[3];

    int read;
    long read_sum = 0;
    
    /* 变量初始化 */
    pFile = NULL;
    
    if (argc < 2) {
        printf("file name");
        goto err_main;
    }

    pFile = fopen(argv[1], "rb");
    if (pFile == NULL) {
        printf("file [%s] open error.\n", argv[1]);
        goto err_main;
    }
    memset(ar_signature, 0, sizeof(ar_signature));
    read = fread(ar_signature, 1, sizeof(ar_signature) - 1, pFile);
    printf("ar_signature=[%s].\n", ar_signature);
    read_sum += read;

    do {
        memset(ar_fh, 0, sizeof(ar_fh));
        read = fread(ar_fh, 1, sizeof(ar_fh) - 1, pFile);
        if (read < sizeof(ar_fh) - 1) {
            printf("%d < %d.\n", read, sizeof(ar_fh) - 1);
            break;
        }
        read_sum += read;
        printf("ar_fh=[%s].\n", ar_fh);

        memset(ar_fh_filesizebyte, 0 ,sizeof(ar_fh_filesizebyte));
        memcpy(ar_fh_filesizebyte, ar_fh + 48, sizeof(ar_fh_filesizebyte) - 1);
        int filesizebyte = atoi(ar_fh_filesizebyte);
        printf("filesizebyte=%d.\n", filesizebyte);
        read_sum += filesizebyte;
        fseek(pFile, read_sum, SEEK_SET);

    } while(!feof(pFile));

    // show_usage();
    goto end_main;
err_main:
end_main:
    /* 处理结束 */
    printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ END.\n");
    if (pFile != NULL) {
        fclose(pFile);
        pFile = NULL;
    }
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
