#pragma pack (1)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define IMAGE_NUMBEROF_DIRECTORY_ENTRIES    16
#define IMAGE_SIZEOF_SHORT_NAME 8

typedef struct _IMAGE_DOS_HEADER {          // DOS .EXE header
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

typedef     struct _IMAGE_FILE_HEADER {
    uint16_t   Machine;                     // 运行平台
    uint16_t   NumberOfSections;            // 文件的区块数目
    uint32_t   TimeDateStamp;               // 文件创建日期和时间
    uint32_t   PointerToSymbolTable;        // 指向符号表(主要用于调试)
    uint32_t   NumberOfSymbols;             // 符号表中符号个数(同上)
    uint16_t   SizeOfOptionalHeader;        // IMAGE_OPTIONAL_HEADER32 结构大小
    uint16_t   Characteristics;             // 文件属性
} IMAGE_FILE_HEADER,  *PIMAGE_FILE_HEADER;

typedef struct _IMAGE_DATA_DIRECTORY{
    uint32_t   VirtualAddress ;             //；数据的起始RVA
    uint32_t   isize;                      //；数据块的长度
} IMAGE_DATA_DIRECTORY;

typedef struct _IMAGE_OPTIONAL_HEADER {
//
// Standard fields. 标准域
//
    uint16_t Magic;                         // 标志字, ROM 映像（0107h）,普通可执行文件（010Bh）
    uint8_t MajorLinkerVersion;             // 链接程序的主版本号
    uint8_t MinorLinkerVersion;             // 链接程序的次版本号
    uint32_t SizeOfCode;                    // 所有含代码的节的总大小
    uint32_t SizeOfInitializedData;         // 所有含已初始化数据的节的总大小
    uint32_t SizeOfUninitializedData;       // 所有含未初始化数据的节的大小
    uint32_t AddressOfEntryPoint;           // 程序执行入口RVA
    uint32_t BaseOfCode;                    // 代码的区块的起始RVA
    uint32_t BaseOfData;                    // 数据的区块的起始RVA
//
// NT additional fields. 以下是属于NT结构增加的领域。 NT附加域
//
    uint32_t ImageBase;                     // 程序的首选装载地址
    uint32_t SectionAlignment;              // 内存中的区块的对齐大小
    uint32_t FileAlignment;                 // 文件中的区块的对齐大小
    uint16_t MajorOperatingSystemVersion;   // 要求操作系统最低版本号的主版本号
    uint16_t MinorOperatingSystemVersion;   // 要求操作系统最低版本号的副版本号
    uint16_t MajorImageVersion;             // 可运行于操作系统的主版本号
    uint16_t MinorImageVersion;             // 可运行于操作系统的次版本号
    uint16_t MajorSubsystemVersion;         // 要求最低子系统版本的主版本号
    uint16_t MinorSubsystemVersion;         // 要求最低子系统版本的次版本号
    uint32_t Win32VersionValue;             // 莫须有字段，不被病毒利用的话一般为0
    uint32_t SizeOfImage;                   // 映像装入内存后的总尺寸
    uint32_t SizeOfHeaders;                 // 所有头 + 区块表的尺寸大小
    uint32_t CheckSum;                      // 映像的校检和
    uint16_t Subsystem;                     // 可执行文件期望的子系统
    uint16_t DllCharacteristics;            // DllMain()函数何时被调用，默认为 0
    uint32_t SizeOfStackReserve;            // 初始化时的栈大小
    uint32_t SizeOfStackCommit;             // 初始化时实际提交的栈大小
    uint32_t SizeOfHeapReserve;             // 初始化时保留的堆大小
    uint32_t SizeOfHeapCommit;              // 初始化时实际提交的堆大小
    uint32_t LoaderFlags;                   // 与调试有关，默认为 0
    uint32_t NumberOfRvaAndSizes;           // 下边数据目录的项数，这个字段自Windows NT 发布以来 // 一直是16
    IMAGE_DATA_DIRECTORY DataDirectory[IMAGE_NUMBEROF_DIRECTORY_ENTRIES];// 数据目录表
} IMAGE_OPTIONAL_HEADER32, *PIMAGE_OPTIONAL_HEADER32;

typedef     struct _IMAGE_NT_HEADERS  { 
    uint32_t                Signature;      //
    IMAGE_FILE_HEADER       FileHeader;     //
    IMAGE_OPTIONAL_HEADER32 OptionalHeader; //
} IMAGE_NT_HEADERS;

typedef struct _IMAGE_SECTION_HEADER {
 uint8_t Name[IMAGE_SIZEOF_SHORT_NAME];
 union {
  uint32_t PhysicalAddress;
  uint32_t VirtualSize;
 } Misc;
 uint32_t VirtualAddress;
 uint32_t SizeOfRawData;
 uint32_t PointerToRawData;
 uint32_t PointerToRelocations;
 uint32_t PointerToLinenumbers;
 uint16_t NumberOfRelocations;
 uint16_t NumberOfLinenumbers;
 uint32_t Characteristics;
} IMAGE_SECTION_HEADER,*PIMAGE_SECTION_HEADER;

void print_ary(unsigned char * buf, size_t size) {

    /* 变量定义 */
    /* 变量初始化 */
    /* 处理开始 */
    int idx =0;
    for (idx = 0; idx < size; idx ++) {
        printf("0X%02X ", *(buf + idx));
        if ((idx + 1) % 16 == 0) {printf("\n");}
    }
    printf("\n");
}

void printf_machine_name(int a) {
    if (a == 0x014c) {printf("Intel 80386 处理器或更高.\n");}
    if (a == 0x014d) {printf("Intel 80386 处理器或更高.\n");}
    if (a == 0x014e) {printf("Intel 80386 处理器或更高.\n");}
    if (a == 0x0160) {printf("R3000 (MIPS)处理器，大尾.\n");}
    if (a == 0x0162) {printf("R3000 (MIPS)处理器，小尾.\n");}
    if (a == 0x0166) {printf("R4000 (MIPS)处理器，小尾.\n");}
    if (a == 0x0168) {printf("R10000 (MIPS)处理器，小尾.\n");}
    if (a == 0x0184) {printf("DEC Alpha AXP处理器.\n");}
    if (a == 0x01F0) {printf("IBM Power PC,小尾 .\n");}
}

int main(int argc, char * argv[]) {
    /* 变量定义 */
    FILE * pFile;
    char ar_signature[9];

    IMAGE_DOS_HEADER dosh;
    char * dospgm;
    int    size_dospgm;
    char pesignature[4];
    IMAGE_FILE_HEADER peh;
    IMAGE_OPTIONAL_HEADER32 oph;

    int read;
    long read_sum = 0;
    int i;
    long cur_pos_file = 0;
    char * section_data = NULL;

    /* 变量初始化 */
    pFile = NULL;
    dospgm = NULL;
    
    if (argc < 2) {
        printf("file name");
        goto err_main;
    }

    pFile = fopen(argv[1], "rb");
    if (pFile == NULL) {
        printf("file [%s] open error.\n", argv[1]);
        goto err_main;
    }
    
    /* MS-DOS头 */
    memset(&dosh, 0, sizeof(IMAGE_DOS_HEADER));
    read = fread(&dosh, 1, sizeof(IMAGE_DOS_HEADER), pFile);
    read_sum += read;
    printf("%d %d 0X%X\n", read, sizeof(IMAGE_DOS_HEADER), sizeof(IMAGE_DOS_HEADER));
    printf("DOSstub,DOS-根,包括：DOS HEADER,实模式残余程序。主要功能是在DOS执行时显示个不能执行的信息后结束。\n");
    printf("-------------------DOS HEADER-----------------\n");         // DOS的.EXE头部 
    printf("e_magic   =[%04X]魔术数字.\n", dosh.e_magic);               // 魔术数字
    printf("e_cblp    =[%04X]文件最后页的字节数.\n", dosh.e_cblp);      // 文件最后页的字节数
    printf("e_cp      =[%04X]文件页数.\n", dosh.e_cp);                  // 文件页数
    printf("e_crlc    =[%04X]重定义元素个数.\n", dosh.e_crlc);          // 重定义元素个数
    printf("e_cparhdr =[%04X]头部尺寸，以段落为单位.\n",dosh.e_cparhdr);// 头部尺寸，以段落为单位
    printf("e_minalloc=[%04X]所需的最小附加段.\n", dosh.e_minalloc);    // 所需的最小附加段
    printf("e_maxalloc=[%04X]所需的最大附加段.\n", dosh.e_maxalloc);    // 所需的最大附加段
    printf("e_ss      =[%04X]初始的SS值（相对偏移量）.\n", dosh.e_ss);  // 初始的SS值（相对偏移量）
    printf("e_sp      =[%04X]初始的SP值.\n", dosh.e_sp);                // 初始的SP值
    printf("e_csum    =[%04X]校验和.\n", dosh.e_csum);                  // 校验和
    printf("e_ip      =[%04X]初始的IP值.\n", dosh.e_ip);                // 初始的IP值
    printf("e_cs      =[%04X]初始的CS值（相对偏移量）.\n", dosh.e_cs);  // 初始的CS值（相对偏移量）
    printf("e_lfarlc  =[%04X]重分配表文件地址.\n", dosh.e_lfarlc);      // 重分配表文件地址
    printf("e_ovno    =[%04X]覆盖号.\n", dosh.e_ovno);                  // 覆盖号
    for (i = 0; i < 4 ; i ++) {
        printf("e_res%d    =[%04X]保留字.\n", i, dosh.e_res[i]);        // 保留字 
    }
    printf("e_oemid   =[%04X]OEM标识符（相对e_oeminfo）.\n",dosh.e_oemid);// OEM标识符（相对e_oeminfo） 
    printf("e_oeminfo =[%04X]OEM信息.\n", dosh.e_oeminfo);               // OEM信息 
    for (i = 0; i < 10 ; i ++) {
        printf("e_res2_%d   =[%04X]保留字.\n",i , dosh.e_res2[i]);       // 保留字 
    }
    printf("e_lfanew  =[%08X]新exe头部的文件地址.\n", dosh.e_lfanew);                       // 新exe头部的文件地址 
    printf("对于MS-DOS操作系统来说都有用，但是\n对于Windows NT来说，这个结构中只有一个有用的域——\n最后一个域 e_lfnew ，一个4字节的文件偏移量，PE文件头部就是由它定位的。.\n");
    printf("-------------------DOS HEADER-----------------\n");

    /* 实模式残余程序 */
    size_dospgm = dosh.e_lfanew - read;
    dospgm = (char *) malloc(size_dospgm);
    if (dospgm == NULL) {
        goto err_main;
    }
    memset(dospgm, 0, size_dospgm);
    read = fread(dospgm, 1, size_dospgm, pFile);
    read_sum += read;
    printf("-------------------实模式残余程序-----------------\n");
    print_ary(dospgm, size_dospgm);
    printf("-------------------实模式残余程序-----------------\n");

    /* PE文件签名 */
    memset(pesignature, 0, sizeof(pesignature));
    read = fread(pesignature, 1, sizeof(pesignature), pFile);
    read_sum += read;
    printf("PE文件签名, 文件头");
    printf("-------------------PE文件签名-----------------\n");
    print_ary(pesignature, sizeof(pesignature));
    printf("-------------------PE文件签名-----------------\n");
    printf("PE文件在磁盘上的数据结构与在内存中的结构是一致的，装载一个可执行文件到内存中，主要就是将一个PE文件的某一部分映射到地址空间中。");
    printf("文件执行时将被映射到指定内存地址即基地址中，VC建立的EXE文件的基地址是00400000h，DLL文件及地址是100000000h。可以在创建应用程序的EXE 时改变这个地址，在链接应用时使用连接程序的/BASE选项。");

    /* PE文件头 */
    memset(&peh, 0, sizeof(IMAGE_FILE_HEADER));
    read = fread(&peh, 1, sizeof(IMAGE_FILE_HEADER), pFile);
    read_sum += read;
    printf("%d %d 0X%X\n", read, sizeof(IMAGE_FILE_HEADER), sizeof(IMAGE_FILE_HEADER));
    printf("-------------------PE文件头-----------------\n");
    printf("用来说明该二进制文件将运行在何种机器之上、分几个区段、链接的时间、是可执行文件还是DLL、等等。\n");
    printf("-------------------PE HEADER-----------------\n");           // 
    printf("Machine              =[%04X].\n", peh.Machine);              // 机器
    printf("NumberOfSections     =[%04X].\n", peh.NumberOfSections);     // 节的数目
    printf("TimeDateStamp        =[%04X].\n", peh.TimeDateStamp);        // 文件建立的时间time_t
    printf("PointerToSymbolTable =[%04X].\n", peh.PointerToSymbolTable); // 符号表指针
    printf("NumberOfSymbols      =[%04X].\n", peh.NumberOfSymbols);      // 符号数
    printf("SizeOfOptionalHeader =[%04X].\n", peh.SizeOfOptionalHeader); // 可选头大小
    printf("Characteristics      =[%04X].\n", peh.Characteristics);      // 特性
    printf_machine_name(peh.Machine);
    printf("这个时间戳是用来绑定各个输入目录的，有一些链接器往往将时间戳设为荒唐的值，而不是如前所述的time_t格式的链接时间。\n");
    printf("特性由许多标志位形成的集合组成，但大多数标志位只对目标文件和库文件有效。具体如下：\n");
    printf("位0  IMAGE_FILE_RELOCS_STRIPPED（重定位被剥离文件） 表示如果文件中没有重定位信息，该位置1，这就表明各节的重定位信息都在它们各自的节中；可执行文件不使用该位，它们的重定位信息放在下面将要描述的“base relocation”（基址重定位）目录中。\n");
    printf("位1  IMAGE_FILE_EXECUTABLE_IMAGE（可执行映象文件） 表示如果文件是一个可执行文件，也即不是目标文件或者库文件时，置1。如果链接器尝试创建一个可执行文件，却因为一些原因失败了，并保存映像以便下次例如增量链接时使用，此时此标志位也可能置1。\n");
    printf("位2  IMAGE_FILE_LINE_NUMS_STRIPPED（行数被剥离文件） 表示如果行数信息被剥除，此位置1；此位也不用于可执行文件。\n");
    printf("位3  IMAGE_FILE_LOCAL_SYMS_STRIPPED（本地符号被剥离文件） 表示如果文件中没有关于本地符号的信息时，此位置1（此位也不用于可执行文件）。\n");
    printf("位4  IMAGE_FILE_AGGRESIVE_WS_TRIM（强行工作集修剪文件） 表示如果操作系统被假定为：通过将正在运行的进程（它所使用的内存数量）强行的页清除来修剪它的工作集时，此位置1。如果一进程是大部分时间处于等待，且一天中仅被唤醒一次的演示性的应用程序之类时，此位也应该被置1。 \n");
    printf("位7  IMAGE_FILE_BYTES_REVERSED_LO（低字节变换文件）和 位15IMAGE_FILE_BYTES_REVERSED_HI（高字节变换文件） 表示如果一文件的字节序不是机器所预期的形式，因此它在读入前必须调换字节时，此位置1。这样做对可执行文件是不可靠的（操作系统期望可执行文件都已经被正确地按字节排整齐了）。\n");
    printf("位8  IMAGE_FILE_32BIT_MACHINE（32位机器文件） 表示如果使用的机器被期望为32位的机器时，此位置1。现在的应用程序总将此位置1；NT5系统可能工作不同。\n");
    printf("位9  IMAGE_FILE_DEBUG_STRIPPED（调试信息被剥离文件) 表示如果文件中没有调试信息，此位置1。此位可执行文件不用。按照其它信息([6])（这里指的是参考书目中的第[6]种----译者注），此位被称作“恒定”，并且当一个映象文件只有在被装入优先的装入地址才能运行（亦即：此文件不可重定位）时，此位置1。\n");
    printf("位10 IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP（移动介质文件从交换文件运行) 表示如果一个应用程序不可以从可移动的介质，如软盘或CD-ROM上运行时，此位置1。在这种情况下，建议操作系统将文件复制到交换文件并从那里执行。 \n");
    printf("位11 IMAGE_FILE_NET_RUN_FROM_SWAP（网络文件从交换文件运行) 表示如果一个应用程序不可以从网络上运行时，此位置1。在这种情况下，建议操作系统将文件复制到交换文件并从那里执行。\n");
    printf("位12 IMAGE_FILE_SYSTEM（系统文件) 表示如果文件是一个象驱动程序那样的系统文件，此位置1。此位可执行文件不用；我所见过的所有NT系统的驱动程序也不用。\n");
    printf("位13 IMAGE_FILE_DLL（DLL文件) 表示如果文件是一个DLL文件时，此位置1。\n");
    printf("位14 IMAGE_FILE_UP_SYSTEM_ONLY（仅但处理器系统的文件) 表示如果文件不设计运行在多处理器系统上（也就是说，因为此文件严格地依赖单一处理器的一些方式工作，所以它会发生冲突）时，此位置1。");
    printf("-------------------PE文件头-----------------\n");


    memset(&oph, 0, sizeof(IMAGE_OPTIONAL_HEADER32));
    read = fread(&oph, 1, sizeof(IMAGE_OPTIONAL_HEADER32), pFile);
    read_sum += read;
    printf("%d %d 0X%X\n", read, sizeof(IMAGE_OPTIONAL_HEADER32), sizeof(IMAGE_OPTIONAL_HEADER32));
    printf("-------------------PE可选头-----------------\n");
    printf("用来说明该二进制文件怎样被载入的更多信息：开始的地址、保留的堆栈数、数据段的大小、等等。\n");
    printf("可选头的一个有趣的部分是尾部的“数据目录”数组；这些目录包含许多指向各“节”数据的指针。例如：如果一个二进制文件拥有一个输出目录，那么你就会在数组成员“IMAGE_DIRECTORY_ENTRY_EXPORT”（输出目录项）中找到一个指向那个目录的指针，而该指针指向文件中的某节。\n");
    printf("-------------------PE OPTIONAL HEADER-----------------\n");           // 
    // Standard fields.
    printf("Magic                       : 0x[%04X]魔数.\n", oph.Magic);
    printf("MajorLinkerVersion          : 0x[%02X]链接器主版本号_不可靠.\n", oph.MajorLinkerVersion);
    printf("MinorLinkerVersion          : 0x[%02X]链接器小版本号_不可靠.\n", oph.MinorLinkerVersion);
    printf("SizeOfCode                  : 0x[%08X]可执行代码的大小_不可靠.\n", oph.SizeOfCode);
    printf("SizeOfInitializedData       : 0x[%08X]已初始化数据的大小_不可靠.\n", oph.SizeOfInitializedData);
    printf("SizeOfUninitializedData     : 0x[%08X]未初始化数据的大小_不可靠.\n", oph.SizeOfUninitializedData);
    printf("AddressOfEntryPoint         : 0x[%08X]入口点地址.\n", oph.AddressOfEntryPoint);
    printf("BaseOfCode                  : 0x[%08X]可执行代码的偏移值.\n", oph.BaseOfCode);
    printf("BaseOfData                  : 0x[%08X]已初始化数据的偏移值.\n", oph.BaseOfData);

    // NT additional fields.
    printf("ImageBase                   : 0x[%08X]映象文件基址.\n", oph.ImageBase);
    printf("SectionAlignment            : 0x[%08X]节对齐.\n", oph.SectionAlignment);
    printf("FileAlignmen                : 0x[%08X]文件对齐.\n", oph.FileAlignment);
    printf("MajorOperatingSystemVersion : 0x[%04X]操作系统主版本号.\n", oph.MajorOperatingSystemVersion);
    printf("MinorOperatingSystemVersion : 0x[%04X]操作系统小版本号.\n", oph.MinorOperatingSystemVersion);
    printf("MajorImageVersion           : 0x[%04X]映象文件主版本号.\n", oph.MajorImageVersion);
    printf("MinorImageVersion           : 0x[%04X]映象文件小版本号.\n", oph.MinorImageVersion);
    printf("MajorSubsystemVersion       : 0x[%04X]子系统主版本号.\n", oph.MajorSubsystemVersion);
    printf("MinorSubsystemVersion       : 0x[%04X]子系统小版本号.\n", oph.MinorSubsystemVersion);
    printf("Win32VersionValue           : 0x[%08X]Win32版本值.\n", oph.Win32VersionValue);
    printf("SizeOfImage                 : 0x[%08X]映象文件大小单位为字节.\n", oph.SizeOfImage);
    printf("SizeOfHeaders               : 0x[%08X]头的大小.\n", oph.SizeOfHeaders);
    printf("CheckSum                    : 0x[%08X]校验和.\n", oph.CheckSum);
    printf("Subsystem                   : 0x[%04X]子系统.\n", oph.Subsystem);
    printf("DllCharacteristics          : 0x[%04X]DLL特性.\n", oph.DllCharacteristics);
    printf("如果位0被置1，DLL文件被通知进程附加（亦即DLL载入）。\n");
    printf("如果位1被置1，DLL文件被通知线程附加（亦即线程终止）。\n");
    printf("如果位2被置1，DLL文件被通知线程附加（亦即线程创建）。\n");
    printf("如果位3被置1，DLL文件被通知进程附加（亦即DLL卸载）。\n");
    printf("SizeOfStackReserve          : 0x[%08X]保留栈的大小.\n", oph.SizeOfStackReserve);
    printf("SizeOfStackCommit           : 0x[%08X]初始时指定栈大小.\n", oph.SizeOfStackCommit);
    printf("SizeOfHeapReserve           : 0x[%08X]保留堆的大小.\n", oph.SizeOfHeapCommit);
    printf("SizeOfHeapCommit            : 0x[%08X]指定堆大小.\n", oph.SizeOfHeapCommit);
    printf("LoaderFlags                 : 0x[%08X]加载器标志.\n", oph.LoaderFlags);
    printf("NumberOfRvaAndSizes         : 0x[%08X]Rva数和大小.\n", oph.NumberOfRvaAndSizes);
    printf("\nIMAGE_DATA_DIRECTORY映象文件目录项数目: ");            // 遍历全部 IMAGE_DATA_DIRECTORY
    printf("\n   NO.  VirtualAddress   Size");
    for(i = 0; i < IMAGE_NUMBEROF_DIRECTORY_ENTRIES; i++) {
        if(oph.DataDirectory[i].isize != 0) {
            printf("\n   %2d", i);
            printf("   0x[%08X]虚拟地址       0x[%08X]大小.", oph.DataDirectory[i].VirtualAddress, oph.DataDirectory[i].isize);
            if (i == 0) { printf("IMAGE_DIRECTORY_ENTRY_EXPORT 导出目录"); }
            if (i == 1) { printf("IMAGE_DIRECTORY_ENTRY_IMPORT 导入目录"); }
            if (i == 2) { printf("IMAGE_DIRECTORY_ENTRY_RESOURCE 资源目录"); }
            if (i == 3) { printf("IMAGE_DIRECTORY_ENTRY_EXCEPTION 异常目录"); }
            if (i == 4) { printf("IMAGE_DIRECTORY_ENTRY_SECURITY 安全目录"); }
            if (i == 5) { printf("IMAGE_DIRECTORY_ENTRY_BASERELOC 重定位基本表"); }
            if (i == 6) { printf("IMAGE_DIRECTORY_ENTRY_DEBUG 调试目录"); }
            if (i == 7) { printf("IMAGE_DIRECTORY_ENTRY_COPYRIGHT 描述字串"); }
            if (i == 8) { printf("IMAGE_DIRECTORY_ENTRY_GLOBALPTR 机器值（MIPS GP）"); }
            if (i == 9) { printf("IMAGE_DIRECTORY_ENTRY_TLS TLS目录"); }
            if (i == 10) { printf("IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG 载入配置目录"); }
        }
    }
    printf("\n");
    printf("-------------------PE可选头-----------------\n");

    IMAGE_SECTION_HEADER *pmySectionHeader= (IMAGE_SECTION_HEADER *)calloc(peh.NumberOfSections,sizeof(IMAGE_SECTION_HEADER));
    fseek(pFile,(dosh.e_lfanew+sizeof(IMAGE_NT_HEADERS)),SEEK_SET);
    read = fread(pmySectionHeader, sizeof(IMAGE_SECTION_HEADER),peh.NumberOfSections, pFile);
    read_sum += (read * sizeof(IMAGE_SECTION_HEADER));
    for(int i=0;i<peh.NumberOfSections;i++,pmySectionHeader++) {
        printf("--------------section[%d]节头.\n", i);
        printf("Name                 : %s节的名称.\n", pmySectionHeader->Name); // 节的名称
        if (memcmp(".text", pmySectionHeader->Name, 5) == 0) {
            printf(".text是在编译或汇编结束时产生的一种块，内容是指令代码。\n");
        }
        if (memcmp(".rdata", pmySectionHeader->Name, 6) == 0) {
            printf(".rdata运行期只读数据。\n");
        }
        if (memcmp(".data", pmySectionHeader->Name, 5) == 0) {
            printf(".data初始化的数据块。\n");
        }
        if (memcmp(".idata", pmySectionHeader->Name, 6) == 0) {
            printf(".idata包含其他外来DLL的函数及数据信息。\n");
        }
        if (memcmp(".rsrc", pmySectionHeader->Name, 5) == 0) {
            printf(".rsrc包含模块的全部资源。\n");
        }
        printf("union_PhysicalAddress: %08x物理地址.\n", pmySectionHeader->Misc.PhysicalAddress); // 物理地址
        printf("union_VirtualSize    : %04x虚拟大小.\n", pmySectionHeader->Misc.VirtualSize); // 虚拟大小
        printf("VirtualAddress       : %08x虚拟地址.\n", pmySectionHeader->VirtualAddress); // 虚拟地址
        printf("SizeOfRawData        : %08x原始数据大小.\n", pmySectionHeader->SizeOfRawData); // 原始数据大小
        printf("PointerToRawData     : %04x原始数据指针.\n", pmySectionHeader->PointerToRawData); // 原始数据指针
        printf("PointerToRelocations : %04x重定位指针.\n", pmySectionHeader->PointerToRelocations); // 重定位指针
        printf("PointerToLinenumbers : %04x行数指针\n", pmySectionHeader->PointerToLinenumbers); // 行数指针
        printf("NumberOfRelocations  : %04x重定位数.\n", pmySectionHeader->NumberOfRelocations); // 重定位数
        printf("NumberOfLinenumbers  : %04x行数数.\n", pmySectionHeader->NumberOfLinenumbers); // 行数数
        printf("Charateristics       : %04x特性\n", pmySectionHeader->Characteristics); // 特性
        if ((pmySectionHeader->Characteristics & 0x20) == 0x20) {
            printf("代码段\n");
            printf("如果位5 IMAGE_SCN_CNT_CODE（含有代码的节)被置1，表示节中包含可执行代码。 \n");
        }
        if ((pmySectionHeader->Characteristics & 0x40) == 0x40) {
            printf("已初始化数据段\n");
            printf("如果位6 IMAGE_SCN_CNT_INITIALIZED_DATA（含有初始化数据的节)被置1，表示节中包含执行开始前即取得已定义值的数据。换言之：文件中节的数据就是有意义的。 \n");
        }
        if ((pmySectionHeader->Characteristics & 0x80) == 0x80) {
            printf("未初始化数据段\n");
            printf("如果位7 IMAGE_SCN_CNT_UNINITIALIZED_DATA（含有未初始化数据的节)被置1， 表示节中包含未初始化数据，并需于执行开始前被初始化为全0。这通常是BSS节。 \n");
        }
        // printf("如果位9 IMAGE_SCN_LNK_INFO（链接器信息节)被置1， 表示节中不包含映象数据，只有一些注释、描述或者其他的文档。这些信息是目标文件的一部分，并有可能是提供给链接器的信息，比如需要哪些库文件。 \n");
        // printf("如果位11 IMAGE_SCN_LNK_REMOVE（链接可删除节)被置1，表示数据是目标文件的、被预定于可执行文件被链接后丢弃掉的节的一部分。常和位9连用。 \n");
        // printf("如果位12 IMAGE_SCN_LNK_COMDAT（链接通用块节)被置1， 表示节中包含“common block data”（通用块数据），也即某种形式的打包函数。 \n");
        // printf("如果位15 IMAGE_SCN_MEM_FARDATA（内存远程数据节)被置1，表示我们拥有远程数据----意味着什么。此位的含义不明。 \n");
        // printf("如果位17 IMAGE_SCN_MEM_PURGEABLE（内存可清除节)被置1， 表示节中的数据可清除----但我认为它和“可丢弃”不是一回事，可丢弃拥有自己的标志位，参见后面。同样，它也明显的不是用来指示16位信息的，因为它也有一个IMAGE_SCN_MEM_16BIT定义。此位的含义不明。 \n");
        // printf("如果位18 IMAGE_SCN_MEM_LOCKED（内存被锁节)被置1， 表示节不应该被从内存中移除？抑或表明没有重定位信息？此位的含义不明。 \n");
        // printf("如果位19 IMAGE_SCN_MEM_PRELOAD（内存预载入节)被置1，表示节在执行开始前应该被页载入？此位的含义不明。 \n");
        // printf("位20至23 指定我没有找到信息的对齐。诸如#defines IMAGE_SCN_ALIGN_16BYTES之类。我曾经见过的唯一值为0，是16位的缺省对齐。 我怀疑它们是库之类文件的目标对齐。 \n");
        // printf("如果位24 IMAGE_SCN_LNK_NRELOC_OVFL（链接扩展重定位节)被置1，表示节中包含一些我不知道的扩展重定位。 \n");
        // printf("如果位25 IMAGE_SCN_MEM_DISCARDABLE（内存可丢弃节)被置1，表示节中的数据在进程启动后就不需要了。它是，举例来说，含有重定位信息的情况。我曾经见过它也用于只执行一次的驱动和服务程序的启动例程，还用于输入目录。 \n");
        if ((pmySectionHeader->Characteristics & 0x04000000) == 0x04000000) {
            printf("该段数据不能被缓存\n");
            printf("如果位26 IMAGE_SCN_MEM_NOT_CACHED（内存不缓存节)被置1，表示节中的数据不应该被缓存。不要问我为什么不。这是不是意味着关掉2级缓存？ \n");
        }
        if ((pmySectionHeader->Characteristics & 0x08000000) == 0x08000000) {
            printf("该段不能被分页\n");
            printf("如果位27 IMAGE_SCN_MEM_NOT_PAGED（内存不可页换出节)被置1，表示节中的数据不应该页换出。它对驱动程序有意义。 \n");
        }
        if ((pmySectionHeader->Characteristics & 0x10000000) == 0x10000000) {
            printf("共享段\n");
            printf("如果位28 IMAGE_SCN_MEM_SHARED（内存共享节)被置1，表示节中的数据在映象文件的所有正在运行的实例中共享。如果它是，例如DLL文件的未初始化数据，那么DLL的所有正在运行的实例程序在任何时候都将拥有相同的变量内容。 \n");
            printf("注意：只有第一个实例的节被初始化。 \n");
            printf("含有代码的节总是共享写时拷贝（copy-on-write）（亦即：如果重定位必不可少，那么共享就不工作）。（译注：“写时拷贝”的译法也许根本就是错误的，但我一时找不到更准确的翻译，也不清楚其具体含义，只能以此充数了。希望知情着指点。） \n");
        }
        if ((pmySectionHeader->Characteristics & 0x20000000) == 0x20000000) {
            printf("可执行段\n");
            printf("如果位29 IMAGE_SCN_MEM_EXECUTE（内存可执行节)被置1，表示进程对节的内存有“执行”的存取权限。 \n");
        }
        if ((pmySectionHeader->Characteristics & 0x40000000) == 0x40000000) {
            printf("可读段\n");
            printf("如果位30 IMAGE_SCN_MEM_READ（内存可读节)被置1，表示进程对节的内存有“读”的存取权限。 \n");
        }
        if ((pmySectionHeader->Characteristics & 0x80000000) == 0x80000000) {
            printf("可写段\n");
            printf("如果位31 IMAGE_SCN_MEM_WRITE（内存可写节)被置1，表示进程对节的内存有“写”的存取权限\n");
        }
        printf("\n");
        if (pmySectionHeader->SizeOfRawData != 0) {
            cur_pos_file = ftell(pFile);
            fseek(pFile, pmySectionHeader->PointerToRawData, SEEK_SET);
            section_data = (char *) malloc(pmySectionHeader->SizeOfRawData);
            if (section_data == NULL) {
                goto err_main;
            }
            memset(section_data, 0, pmySectionHeader->SizeOfRawData);
            read = fread(section_data, sizeof(char), pmySectionHeader->SizeOfRawData, pFile);
            if (read < pmySectionHeader->SizeOfRawData) {
                printf("read coff's optional header error.%d,%d\n", read, pmySectionHeader->SizeOfRawData);
                goto err_main;
            } else {
                print_ary(section_data, pmySectionHeader->SizeOfRawData);
                printf("\n");
            }
            if (section_data != NULL) {
                free(section_data);
                section_data = NULL;
            }
            fseek(pFile, cur_pos_file, SEEK_SET);
        }
    }


    // show_usage();
    printf("readsum=%d.\n", read_sum);
    goto end_main;
err_main:
end_main:
    /* 处理结束 */
    printf("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ END.\n");
    if (pFile != NULL) {
        fclose(pFile);
        pFile = NULL;
    }
    if (dospgm != NULL) {
        free(dospgm);
        dospgm = NULL;
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
