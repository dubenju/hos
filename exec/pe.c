#pragma pack (1)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define IMAGE_NUMBEROF_DIRECTORY_ENTRIES    16

typedef struct _IMAGE_DOS_HEADER {      // DOS .EXE header
    uint16_t   e_magic;                     // Magic number
    uint16_t   e_cblp;                      // Bytes on last page of file
    uint16_t   e_cp;                        // Pages in file
    uint16_t   e_crlc;                      // Relocations
    uint16_t   e_cparhdr;                   // Size of header in paragraphs
    uint16_t   e_minalloc;                  // Minimum extra paragraphs needed
    uint16_t   e_maxalloc;                  // Maximum extra paragraphs needed
    uint16_t   e_ss;                        // Initial (relative) SS value
    uint16_t   e_sp;                        // Initial SP value
    uint16_t   e_csum;                      // Checksum
    uint16_t   e_ip;                        // Initial IP value
    uint16_t   e_cs;                        // Initial (relative) CS value
    uint16_t   e_lfarlc;                    // File address of relocation table
    uint16_t   e_ovno;                      // Overlay number
    uint16_t   e_res[4];                    // Reserved words
    uint16_t   e_oemid;                     // OEM identifier (for e_oeminfo)
    uint16_t   e_oeminfo;                   // OEM information; e_oemid specific
    uint16_t   e_res2[10];                  // Reserved words
    uint32_t   e_lfanew;                    // File address of new exe header
  } IMAGE_DOS_HEADER, *PIMAGE_DOS_HEADER;

typedef     struct _IMAGE_FILE_HEADER 
{
    uint16_t          Machine;                                  // 运行平台
      uint16_t          NumberOfSections;            // 文件的区块数目
    uint32_t         TimeDateStamp;            // 文件创建日期和时间
      uint32_t         PointerToSymbolTable;        // 指向符号表(主要用于调试)
     uint32_t         NumberOfSymbols;            // 符号表中符号个数(同上)
      uint16_t          SizeOfOptionalHeader;        // IMAGE_OPTIONAL_HEADER32 结构大小
      uint16_t          Characteristics;                // 文件属性
} IMAGE_FILE_HEADER,  *PIMAGE_FILE_HEADER;

typedef struct _IMAGE_DATA_DIRECTORY{
 uint32_t VirtualAddress ;//；数据的起始RVA
 uint32_t isize ;//；数据块的长度
} IMAGE_DATA_DIRECTORY;

typedef struct _IMAGE_OPTIONAL_HEADER {
//
// Standard fields.
//
 uint16_t Magic; // 标志字, ROM 映像（0107h）,普通可执行文件（010Bh）
 uint8_t MajorLinkerVersion; // 链接程序的主版本号
 uint8_t MinorLinkerVersion; // 链接程序的次版本号
 uint32_t SizeOfCode; // 所有含代码的节的总大小
 uint32_t SizeOfInitializedData; // 所有含已初始化数据的节的总大小
 uint32_t SizeOfUninitializedData; // 所有含未初始化数据的节的大小
 uint32_t AddressOfEntryPoint; // 程序执行入口RVA
 uint32_t BaseOfCode; // 代码的区块的起始RVA
 uint32_t BaseOfData; // 数据的区块的起始RVA
//
// NT additional fields. 以下是属于NT结构增加的领域。
//
 uint32_t ImageBase; // 程序的首选装载地址
 uint32_t SectionAlignment; // 内存中的区块的对齐大小
 uint32_t FileAlignment; // 文件中的区块的对齐大小
 uint16_t MajorOperatingSystemVersion; // 要求操作系统最低版本号的主版本号
 uint16_t MinorOperatingSystemVersion; // 要求操作系统最低版本号的副版本号
 uint16_t MajorImageVersion; // 可运行于操作系统的主版本号
 uint16_t MinorImageVersion; // 可运行于操作系统的次版本号
 uint16_t MajorSubsystemVersion; // 要求最低子系统版本的主版本号
 uint16_t MinorSubsystemVersion; // 要求最低子系统版本的次版本号
 uint32_t Win32VersionValue; // 莫须有字段，不被病毒利用的话一般为0
 uint32_t SizeOfImage; // 映像装入内存后的总尺寸
 uint32_t SizeOfHeaders; // 所有头 + 区块表的尺寸大小
 uint32_t CheckSum; // 映像的校检和
 uint16_t Subsystem; // 可执行文件期望的子系统
 uint16_t DllCharacteristics; // DllMain()函数何时被调用，默认为 0
 uint32_t SizeOfStackReserve; // 初始化时的栈大小
 uint32_t SizeOfStackCommit; // 初始化时实际提交的栈大小
 uint32_t SizeOfHeapReserve; // 初始化时保留的堆大小
 uint32_t SizeOfHeapCommit; // 初始化时实际提交的堆大小
 uint32_t LoaderFlags; // 与调试有关，默认为 0
 uint32_t NumberOfRvaAndSizes; // 下边数据目录的项数，这个字段自Windows NT 发布以来 // 一直是16
 IMAGE_DATA_DIRECTORY DataDirectory[IMAGE_NUMBEROF_DIRECTORY_ENTRIES];
// 数据目录表
} IMAGE_OPTIONAL_HEADER32, *PIMAGE_OPTIONAL_HEADER32;

typedef     struct _IMAGE_NT_HEADERS  { 
  uint32_t Signature;    //
  IMAGE_FILE_HEADER  FileHeader;   //
 IMAGE_OPTIONAL_HEADER32 OptionalHeader;   //
} IMAGE_NT_HEADERS;

int main(int argc, char * argv[]) {
    /* 变量定义 */
    FILE * pFile;
    char ar_signature[9];

    IMAGE_DOS_HEADER dosh;

    int read;
    long read_sum = 0;
    int i;
    
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
    memset(&dosh, 0, sizeof(IMAGE_DOS_HEADER));
    read = fread(&dosh, 1, sizeof(IMAGE_DOS_HEADER), pFile);
    read_sum += read;
    printf("%d %d\n", read, sizeof(IMAGE_DOS_HEADER));
    printf("-------------------DOS HEADER-----------------\n");
    printf("e_magic   =[%04X].\n", dosh.e_magic);
    printf("e_cblp    =[%04X].\n", dosh.e_cblp);
    printf("e_cp      =[%04X].\n", dosh.e_cp);
    printf("e_crlc    =[%04X].\n", dosh.e_crlc);
    printf("e_cparhdr =[%04X].\n", dosh.e_cparhdr);
    printf("e_minalloc=[%04X].\n", dosh.e_minalloc);
    printf("e_maxalloc=[%04X].\n", dosh.e_maxalloc);
    printf("e_ss      =[%04X].\n", dosh.e_ss);
    printf("e_sp      =[%04X].\n", dosh.e_sp);
    printf("e_csum    =[%04X].\n", dosh.e_csum);
    printf("e_ip      =[%04X].\n", dosh.e_ip);
    printf("e_cs      =[%04X].\n", dosh.e_cs);
    printf("e_lfarlc  =[%04X].\n", dosh.e_lfarlc);
    printf("e_ovno    =[%04X].\n", dosh.e_ovno);
    for (i = 0; i < 4 ; i ++) {
        printf("e_res%d    =[%04X].\n", i, dosh.e_res[i]);
    }
    printf("e_oemid   =[%04X].\n", dosh.e_oemid);
    printf("e_oeminfo =[%04X].\n", dosh.e_oeminfo);
    for (i = 0; i < 10 ; i ++) {
        printf("e_res2%d   =[%04X].\n",i , dosh.e_res2[i]);
    }
    printf("e_lfanew  =[%08X].\n", dosh.e_lfanew);
    
    printf("-------------------DOS HEADER-----------------\n");

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
