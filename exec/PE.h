/*  PE.h
    PE 文件格式
    四彩
    2015-11-30
*/

/*  PE 文件的总体结构：（内存地址有低到高）
        IMAGE_DOS_HEADER（DOS 头）
        DOS stub
        "PE00"（PE 标志）
        IMAGE_FILE_HEADER（文件头）
        IMAGE_OPTIONAL_HEADER（可选头）
        IMAGE_DATA_DIRECTORY（数据块目录）
        IMAGE_SECTION_HEADER（节表）
        .text节区
        .data节区
        其它节区
        不能被映射的其他数据
*/
/*
    虚拟地址：Virtual Address（VA），保护模式下访问内存所使用的逻辑地址。
    装载基址：Image Base，文件装入内存的基址。
              默认情况下，EXE 文件的基址为 0x00400000，DLL 文件的基址为 0x10000000。
    相对虚拟地址：Relative Virtual Address（RVA），在内存中相对于装载基址的偏移量。
    文件偏移地址：File Offset Address（FOA），文件在磁盘上存放时相对于文件开头的偏移量。
                  文件偏移地址从文件的第一个字节开始计数，起始值为 0。

    无论是在内存中还是在磁盘文件中，节都是按基址排列的，而且都要对齐，但对齐值一般不同。
    映射到内存后，所有头和节表的偏移位置与大小均没有变化，而各节基址的偏移位置发生了变化。
    不管节是在文件中还是被加载到内存中，节中数据的位置相对该节的基址是不变的。
        在内存中：数据相对节的起始位置的偏移h = 数据的RVA - 节的RVA
        在文件中：数据相对节的起始位置的偏移h = 数据的FOA – 节的FOA

    一个节中的数据只是属性相同，并不一定是同一种用途的内容，因此仅依靠节表是无法确定和定位
    的，而要由数据目录表来定位。

*/

/*
    IMAGE_DATA_DIRECTORY 直接定义在 IMAGE_NT_HEADER 里面，而不在 IMAGE_OPTIONAL_HEADER 里，
    这导致 IMAGE_FILE_HEADER 中的 SizeOfOptionalHeader 字段数值失效。
*/


#ifndef _PE_H
#define _PE_H


#include "Typedef.h"


// ***************************************************************************************
// DOS 头结构：文件偏移基址 0
//
// e_magic 字段预定义值
#define IMAGE_DOS_SIGNATURE 0x5A4D          // 即字符 "MZ"

typedef struct tag_IMAE_DOS_HEADER
{
    //                                         偏移  说明
    WORD    e_magic;                        // 0x00  DOS 可执行文件标识符（= "MZ"）
    WORD    e_cblp;                         // 0x02  Bytes on last page of file
    WORD    e_cp;                           // 0x04  Pages in file
    WORD    e_crlc;                         // 0x06  Relocations
    WORD    e_cparhdr;                      // 0x08  Size of header in paragraphs
    WORD    e_minalloc;                     // 0x0A  Minimum extra paragraphs needed
    WORD    e_maxalloc;                     // 0x0C  Maximum extra paragraphs needed
    WORD    e_ss;                           // 0x0E  Initial (relative) SS value
    WORD    e_sp;                           // 0x10  Initial SP value
    WORD    e_csum;                         // 0x12  Checksum
    WORD    e_ip;                           // 0x14  Initial IP value
    WORD    e_cs;                           // 0x16  Initial (relative) CS value
    WORD    e_lfarlc;                       // 0x18  File address of relocation table
    WORD    e_ovno;                         // 0x1A  Overlay number
    WORD    e_res[4];                       // 0x1C  Reserved words
    WORD    e_oemid;                        // 0x24  OEM identifier (for e_oeminfo)
    WORD    e_oeminfo;                      // 0x26  OEM information; e_oemid specific
    WORD    e_res2[10];                     // 0x28  Reserved words
    DWORD   e_lfanew;                       // 0x3C  PE 签名的文件偏移地址
} IMAGE_DOS_HEADER, *PIMAGE_DOS_HEADER;
// =======================================================================================


// ***************************************************************************************
// NT 头结构：文件偏移地址 = IMAGE_DOS_HEADER.e_lfanew
//
// NT 头结构 —— File 头结构
//
// Machine 字段预定义值:                    Value      Meaning
#define IMAGE_FILE_MACHINE_UNKNOWN          0
#define IMAGE_FILE_MACHINE_I386             0x014c  // x86
#define IMAGE_FILE_MACHINE_AMD64            0x8664  // x64
#define IMAGE_FILE_MACHINE_IA64             0x0200  // Intel Itanium

/*  Characteristics 是一个标志的集合
    位   预定义值                           含义
    0   IMAGE_FILE_RELOCS_STRIPPED          文件中没有重定向信息。在可执行文件中没有使用。
                                            可执行文件用基址重定向目录表来表示重定向信息。
    1   IMAGE_FILE_EXECUTABLE_IMAGE         可执行文件。
    2   IMAGE_FILE_LINE_NUMS_STRIPPED       没有行数信息。在可执行文件中没有使用。
    3   IMAGE_FILE_LOCAL_SYMS_STRIPPED      没有局部符号信息。在可执行文件中没有使用。
    4   IMAGE_FILE_AGGRESIVE_WS_TRIM        已无效。
    5   IMAGE_FILE_LARGE_ADDRESS_AWARE      应用程序可以处理超过 2 GB 的地址。
    6   未使用
    7   IMAGE_FILE_BYTES_REVERSED_LO        已无效。
    8   IMAGE_FILE_32BIT_MACHINE            希望机器为32位机。这个值永远为 1。
    9   IMAGE_FILE_DEBUG_STRIPPED           没有调试信息。在可执行文件中没有使用。
    10  IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP  该程序不能运行于可移动介质中（如软驱或CD）。
    11  IMAGE_FILE_NET_RUN_FROM_SWAP        程序不能在网上运行。（必须拷贝到内存中执行）
    12  IMAGE_FILE_SYSTEM                   系统文件，如驱动程序。在可执行文件中没有使用。
    13  IMAGE_FILE_DLL                      动态链接库（DLL）。
    14  IMAGE_FILE_UP_SYSTEM_ONLY           不能运行于多处理器系统中。
    15  IMAGE_FILE_BYTES_REVERSED_HI        已无效。
*/
// Characteristics 字段预定义值
#define IMAGE_FILE_RELOCS_STRIPPED          0x0001
#define IMAGE_FILE_EXECUTABLE_IMAGE         0x0002
#define IMAGE_FILE_LINE_NUMS_STRIPPED       0x0004
#define IMAGE_FILE_LOCAL_SYMS_STRIPPED      0x0008
#define IMAGE_FILE_AGGRESIVE_WS_TRIM        0x0010
#define IMAGE_FILE_LARGE_ADDRESS_AWARE      0x0020
#define IMAGE_FILE_BYTES_REVERSED_LO        0x0080
#define IMAGE_FILE_32BIT_MACHINE            0x0100
#define IMAGE_FILE_DEBUG_STRIPPED           0x0200
#define IMAGE_FILE_REMOVABLE_RUN_FROM_SWAP  0x0400
#define IMAGE_FILE_NET_RUN_FROM_SWAP        0x0800
#define IMAGE_FILE_SYSTEM                   0x1000
#define IMAGE_FILE_DLL                      0x2000
#define IMAGE_FILE_UP_SYSTEM_ONLY           0x4000
#define IMAGE_FILE_BYTES_REVERSED_HI        0x8000

typedef struct tag_IMAGE_FILE_HEADER
{
    WORD    Machine;                        // 0x04  运行所要求的 CPU 类型。
    WORD    NumberOfSections;               // 0x06  节数。
    DWORD   TimeDateStamp;                  // 0x08  文件创建日期和时间
    DWORD   PointerToSymbolTable;           // 0x0C  指向符号表（用于调试）
    DWORD   NumberOfSymbols;                // 0x10  符号表中符号个数（用于调试）
    WORD    SizeOfOptionalHeader;           // 0x14  IMAGE_OPTIONAL_HEADER 结构大小（无效）
    WORD    Characteristics;                // 0x16  属性
} IMAGE_FILE_HEADER, *PIMAGE_FILE_HEADER;
// ---------------------------------------------------------------------------------------


// NT 头结构 —— NT 可选头结构
//
/*  数据目录表各项的含义
    索引          预定义值                          对应的数据块
    0       IMAGE_DIRECTORY_ENTRY_EXPORT            导出函数表，主要用于 DLL 中的导出函数
    1       IMAGE_DIRECTORY_ENTRY_IMPORT            导入函数表，使用外部函数的数据表
    2       IMAGE_DIRECTORY_ENTRY_RESOURCE          资源数据表
    3       IMAGE_DIRECTORY_ENTRY_EXCEPTION         异常处理表（具体资料不详）
    4       IMAGE_DIRECTORY_ENTRY_SECURITY          安全处理数据表（具体资料不详）
    5       IMAGE_DIRECTORY_ENTRY_BASERELOC         重定位信息表，一般和 DLL 相关
    6       IMAGE_DIRECTORY_ENTRY_DEBUG             调试信息表
    7       IMAGE_DIRECTORY_ENTRY_ARCHITECTURE      版权信息表
    8       IMAGE_DIRECTORY_ENTRY_GLOBALPTR         机器值（MIPS GP）（具体资料不详）
    9       IMAGE_DIRECTORY_ENTRY_TLS               线程信息本地存储表
    10      IMAGE_DIRECTORY_ENTRY_LOAD_CONFIG       装配信息表（具体资料不详）
    11      IMAGE_DIRECTORY_ENTRY_BOUND_IMPORT      输入函数绑定信息表（具体资料不详）
    12      IMAGE_DIRECTORY_ENTRY_IAT               导入函数地址表（与 ImportTable 对应，
                                                            由 Loader 填写的输入函数地址）
    13      IMAGE_DIRECTORY_ENTRY_DELAY_IMPORT      延迟装入的函数信息表（具体资料不详）
    14      IMAGE_DIRECTORY_ENTRY_COM_DESCRIPTOR    公用组件信息表（具体资料不详）
    15      未使用
*/

typedef struct tag_IMAGE_OPTIONAL_HEADER
{
    //                                         偏移  说明
    // Standard fields.
    WORD    Magic;                          // 0x18  标志字（Win32 下总是 0x010B）
    BYTE    MajorLinkerVersion;             // 0x1A  链接程序的主版本号
    BYTE    MinorLinkerVersion;             // 0x1B  链接程序的次版本号
    DWORD   SizeOfCode;                     // 0x1C  所有含代码的节的总大小
    DWORD   SizeOfInitializedData;          // 0x20  所有含已初始化数据的节的总大小
    DWORD   SizeOfUninitializedData;        // 0x24  所有含未初始化数据的节的大小
    DWORD   AddressOfEntryPoint;            // 0x28  程序执行入口地址（RVA）
    DWORD   BaseOfCode;                     // 0x2C  代码的区块的起始地址（RVA）
    DWORD   BaseOfData;                     // 0x30  数据的区块的起始地址（RVA）
    // NT additional fields.
    DWORD   ImageBase;                      // 0x34  首选装载基址
    DWORD   SectionAlignment;               // 0x38  内存中节的对齐单位（32 位下为 4K）
    DWORD   FileAlignment;                  // 0x3C  磁盘文件中节的对齐单位（一个扇区大小）
    WORD    MajorOperatingSystemVersion;    // 0x40  要求操作系统最低版本号的主版本号
    WORD    MinorOperatingSystemVersion;    // 0x42  要求操作系统最低版本号的副版本号
    WORD    MajorImageVersion;              // 0x44  可运行于操作系统的主版本号
    WORD    MinorImageVersion;              // 0x46  可运行于操作系统的次版本号
    WORD    MajorSubsystemVersion;          // 0x48  要求最低子系统版本的主版本号
    WORD    MinorSubsystemVersion;          // 0x4A  要求最低子系统版本的次版本号
    DWORD   Win32VersionValue;              // 0x4C  不明。一般为 0 。
    DWORD   SizeOfImage;                    // 0x50  装入内存后的总大小
    DWORD   SizeOfHeaders;                  // 0x54  所有头 + 节表的总大小
    DWORD   CheckSum;                       // 0x58  校检和
    WORD    Subsystem;                      // 0x5C  可执行文件期望的界面子系统
    WORD    DllCharacteristics;             // 0x5E  DllMain() 函数何时被调用，默认为 0
    DWORD   SizeOfStackReserve;             // 0x60  初始化时的栈大小
    DWORD   SizeOfStackCommit;              // 0x64  初始化时实际提交的栈大小
    DWORD   SizeOfHeapReserve;              // 0x68  初始化时保留的堆大小
    DWORD   SizeOfHeapCommit;               // 0x6C  初始化时实际提交的堆大小
    DWORD   LoaderFlags;                    // 0x70  与调试有关，默认为 0
    DWORD   NumberOfRvaAndSizes;            // 0x74  数据目录表的项数
} IMAGE_OPTIONAL_HEADER, *PIMAGE_OPTIONAL_HEADER;
// ---------------------------------------------------------------------------------------


// NT 头结构 —— 数据目录结构

#define IMAGE_NUMBEROF_DIRECTORY_ENTRIES 16 // 数据目录表的项数一直是 16

typedef struct tag_IMAGE_DATA_DIRECTORY
{
    DWORD VirtualAddress;                   // 数据的基址（RVA）
    DWORD Size;                             // 数据的长度
} IMAGE_DATA_DIRECTORY;
// ---------------------------------------------------------------------------------------


// NT 头结构
//
// Signature 字段预定义值
#define IMAGE_NT_SIGNATURE 0x00004550       // 即字符"PE00"

typedef struct tag_IMAGE_NT_HEADERS
{
    //                                         偏移  说明
    DWORD                   Signature;      // 0x00  PE 文件签名（= "PE00"）
    IMAGE_FILE_HEADER       FileHeader;     // 0x04  文件头结构
    IMAGE_OPTIONAL_HEADER   OptionalHeader; // 0x18  可选 NT 头结构
    IMAGE_DATA_DIRECTORY    DataDirectory[IMAGE_NUMBEROF_DIRECTORY_ENTRIES];
                                            // 0x78  数据目录表
} IMAGE_NT_HEADER, *PIMAGE_NT_HEADER;
// =======================================================================================


// ***************************************************************************************
// 节表：文件偏移地址 = IMAGE_DOS_HEADER.e_lfanew + sizeof(IMAGE_NT_HEADER)
//       项数由 IMAGE_NT_HEADER 中的 FileHeader.NumberOfSections 指定
//
// 节（区块）头结构

#define IMAGE_SIZEOF_SHORT_NAME     8       // Name 字段最长 8 字节

// Characteristics 字段预定义值
#define IMAGE_SCN_CNT_CODE                  0x20        // 包含代码
#define IMAGE_SCN_CNT_INITIALIZED_DATA      0x40        // 包含已初始化数据
#define IMAGE_SCN_CNT_UNINITIALIZED_DATA    0x80        // 包含未初始化数据
#define IMAGE_SCN_MEM_DISCARDABLE           0x2000000   // 数据在进程开始后将被丢弃
#define IMAGE_SCN_MEM_NOT_CACHED            0x4000000   // 数据不经过缓存
#define IMAGE_SCN_MEM_NOT_PAGED             0x8000000   // 数据不被交换出内存
#define IMAGE_SCN_MEM_SHARED                0x10000000  // 数据可共享
#define IMAGE_SCN_MEM_EXECUTE               0x20000000  // 可执行
#define IMAGE_SCN_MEM_READ                  0x40000000  // 可读
#define IMAGE_SCN_MEM_WRITE                 0x80000000  // 可写

typedef struct tag_IMAGE_SECTION_HEADER
{
    //                                         偏移  说明
    BYTE    Name[IMAGE_SIZEOF_SHORT_NAME];  // 0x00  节表名称（仅供编程参考）
    union                                   // 0x08  一般是取后一个，即节的真实长度
    {
        DWORD PhysicalAddress;                  // 物理地址
        DWORD VirtualSize;                      // 真实长度（没有进行对齐处理前的实际大小）
    } Misc;
    DWORD   VirtualAddress;                 // 0x0C  装载到内存的基址（内存对齐后的 RVA）
    DWORD   SizeOfRawData;                  // 0x10  在文件中的大小（在磁盘中对齐后的大小）
    DWORD   PointerToRawData;               // 0x14  在文件中的偏移量（从文件头开始算起）
    DWORD   PointerToRelocations;           // 0x18  重定位的偏移（在 OBJ 文件中供调试用）
    DWORD   PointerToLinenumbers;           // 0x1C  行号表的偏移（同上）
    WORD    NumberOfRelocations;            // 0x20  重定位项的数目（同上）
    WORD    NumberOfLinenumbers;            // 0x22  行号表中行号的数目（同上）
    DWORD   Characteristics;                // 0x24  节的属性（如可读、可写、可执行等）
} IMAGE_SECTION_HEADER, *PIMAGE_SECTION_HEADER;
// =======================================================================================

#endif
