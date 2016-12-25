/*  PEF.c
    显示 PE 文件格式信息
    四彩
    2015-11-30
*/

#include <stdio.h>
#include <stdlib.h>
#include "PE.h"


// 显示 IMAGE_DOS_HEADER 信息
void PrintDosHeader(IMAGE_DOS_HEADER DosHeader)
{
    int i;

    printf("e_magic          : %c%c\n", LByteOfW(DosHeader.e_magic),
                                                            HByteOfW(DosHeader.e_magic));
    printf("e_cblp           : 0x%04X\n", DosHeader.e_cblp);
    printf("e_cp             : 0x%04X\n", DosHeader.e_cp);
    printf("e_crlc           : 0x%04X\n", DosHeader.e_crlc);
    printf("e_cparhdr        : 0x%04X\n", DosHeader.e_cparhdr);
    printf("e_minalloc       : 0x%04X\n", DosHeader.e_minalloc);
    printf("e_maxalloc       : 0x%04X\n", DosHeader.e_maxalloc);
    printf("e_ss             : 0x%04X\n", DosHeader.e_ss);
    printf("e_sp             : 0x%04X\n", DosHeader.e_sp);
    printf("e_csum           : 0x%04X\n", DosHeader.e_csum);
    printf("e_ip             : 0x%04X\n", DosHeader.e_ip);
    printf("e_cs             : 0x%04X\n", DosHeader.e_cs);
    printf("e_lfarlc         : 0x%04X\n", DosHeader.e_lfarlc);
    printf("e_ovno           : 0x%04X\n", DosHeader.e_ovno);
    printf("e_res            : ");
    for(i = 0; i < 4; i++)
        printf("0x%X, ", DosHeader.e_res[i]);
    printf("\ne_oemid          : 0x%04X\n", DosHeader.e_oemid);
    printf("e_oeminfo        : 0x%04X\n", DosHeader.e_oeminfo);
    printf("e_res2           : ");
    for(i = 0; i < 10; i++)
        printf("0x%X, ", DosHeader.e_res2[i]);
    printf("\ne_lfanew         : 0x%04X\n", DosHeader.e_lfanew);
}

// 显示 IMAGE_FILE_HEADER 信息
void PrintFileHeader(IMAGE_FILE_HEADER FileHeader)
{
    printf("Machine              : 0x%04X\n", FileHeader.Machine);
    printf("NumberOfSections     : 0x%04X\n", FileHeader.NumberOfSections);
    printf("TimeDateStamp        : 0x%08X\n", FileHeader.TimeDateStamp);
    printf("PointerToSymbolTable : 0x%08X\n", FileHeader.PointerToSymbolTable);
    printf("NumberOfSymbols      : 0x%08X\n", FileHeader.NumberOfSymbols);
    printf("SizeOfOptionalHeader : 0x%04X\n", FileHeader.SizeOfOptionalHeader);
    printf("Characteristics      : 0x%04X\n", FileHeader.Characteristics);
}

// 显示 IMAGE_OPTIONAL_HEADER 信息
void PrintOptionalHeader(IMAGE_OPTIONAL_HEADER OptHeader)
{
    // Standard fields.
    printf("Magic                       : 0x%04X\n", OptHeader.Magic);
    printf("MajorLinkerVersion          : 0x%02X\n", OptHeader.MajorLinkerVersion);
    printf("MinorLinkerVersion          : 0x%02X\n", OptHeader.MinorLinkerVersion);
    printf("SizeOfCode                  : 0x%08X\n", OptHeader.SizeOfCode);
    printf("SizeOfInitializedData       : 0x%08X\n", OptHeader.SizeOfInitializedData);
    printf("SizeOfUninitializedData     : 0x%08X\n", OptHeader.SizeOfUninitializedData);
    printf("AddressOfEntryPoint         : 0x%08X\n", OptHeader.AddressOfEntryPoint);
    printf("BaseOfCode                  : 0x%08X\n", OptHeader.BaseOfCode);
    printf("BaseOfData                  : 0x%08X\n", OptHeader.BaseOfData);

    // NT additional fields.
    printf("ImageBase                   : 0x%08X\n", OptHeader.ImageBase);
    printf("SectionAlignment            : 0x%08X\n", OptHeader.SectionAlignment);
    printf("FileAlignmen                : 0x%08X\n", OptHeader.FileAlignment);
    printf("MajorOperatingSystemVersion : 0x%04X\n", OptHeader.MajorOperatingSystemVersion);
    printf("MinorOperatingSystemVersion : 0x%04X\n", OptHeader.MinorOperatingSystemVersion);
    printf("MajorImageVersion           : 0x%04X\n", OptHeader.MajorImageVersion);
    printf("MinorImageVersion           : 0x%04X\n", OptHeader.MinorImageVersion);
    printf("MajorSubsystemVersion       : 0x%04X\n", OptHeader.MajorSubsystemVersion);
    printf("MinorSubsystemVersion       : 0x%04X\n", OptHeader.MinorSubsystemVersion);
    printf("Win32VersionValue           : 0x%08X\n", OptHeader.Win32VersionValue);
    printf("SizeOfImage                 : 0x%08X\n", OptHeader.SizeOfImage);
    printf("SizeOfHeaders               : 0x%08X\n", OptHeader.SizeOfHeaders);
    printf("CheckSum                    : 0x%08X\n", OptHeader.CheckSum);
    printf("Subsystem                   : 0x%04X\n", OptHeader.Subsystem);
    printf("DllCharacteristics          : 0x%04X\n", OptHeader.DllCharacteristics);
    printf("SizeOfStackReserve          : 0x%08X\n", OptHeader.SizeOfStackReserve);
    printf("SizeOfStackCommit           : 0x%08X\n", OptHeader.SizeOfStackCommit);
    printf("SizeOfHeapReserve           : 0x%08X\n", OptHeader.SizeOfHeapCommit);
    printf("SizeOfHeapCommit            : 0x%08X\n", OptHeader.SizeOfHeapCommit);
    printf("LoaderFlags                 : 0x%08X\n", OptHeader.LoaderFlags);
    printf("NumberOfRvaAndSizes         : 0x%08X\n", OptHeader.NumberOfRvaAndSizes);
}

// 显示 IMAGE_DATA_DIRECTORY 信息
void PrintDataDircrory(IMAGE_DATA_DIRECTORY DataDirectory)
{
    printf("   0x%08X       0x%08X", DataDirectory.VirtualAddress, DataDirectory.Size);
}

// 显示 IMAGE_SECTION_HEADER 信息
void PrintSectionHeader(IMAGE_SECTION_HEADER SectionHeader)
{
    printf("Name                 : %s\n", SectionHeader.Name);
    printf("Misc.VirtualSize     : 0x%08X\n", SectionHeader.Misc.VirtualSize);
    printf("VirtualAddress       : 0x%08X\n", SectionHeader.VirtualAddress);
    printf("SizeOfRawData        : 0x%08X\n", SectionHeader.SizeOfRawData);
    printf("PointerToRawData     : 0x%08X\n", SectionHeader.PointerToRawData);
    printf("PointerToRelocations : 0x%08X\n", SectionHeader.PointerToRelocations);
    printf("PointerToLinenumbers : 0x%08X\n", SectionHeader.PointerToLinenumbers);
    printf("NumberOfRelocations  : 0x%04X\n", SectionHeader.NumberOfRelocations);
    printf("NumberOfLinenumbers  : 0x%04X\n", SectionHeader.NumberOfLinenumbers);
    printf("Characteristics      : 0x%08X\n", SectionHeader.Characteristics);
}


int main(int argc, char **argv)
{
    int i;
    FILE *fp;
    IMAGE_DOS_HEADER        DosHeader;
    IMAGE_NT_HEADER         NtHeader;
    IMAGE_SECTION_HEADER    SectionHeader;

    if(argc != 2)
    {
        printf("Usage : %s exeFileName\n", argv[0]);
        return 0;
    }
    fp = fopen(argv[1], "rb");
    if (fp == NULL)
    {
        printf("Error : open file\n");
        return -1;
    }

    // 显示 IMAGE_DOS_HEADER 信息
    fread(&DosHeader, sizeof(IMAGE_DOS_HEADER), 1, fp);
    if(DosHeader.e_magic != IMAGE_DOS_SIGNATURE)
    {
        printf("Error : NOT DOS file\n");
        fclose(fp);
        return -1;
    }
    printf("IMAGE_DOS_HEADER :\n");
    PrintDosHeader(DosHeader);

    // 显示 IMAGE_NT_HEADER 信息
    fseek(fp, DosHeader.e_lfanew, SEEK_SET);
    fread(&NtHeader, sizeof(IMAGE_NT_HEADER), 1, fp);
    if(NtHeader.Signature != IMAGE_NT_SIGNATURE)
    {
        printf("Error : NOT PE file\n");
        fclose(fp);
        return 0;
    }
    printf("\nIMAGE_NT_HEADER  :\n");               // Signature
    printf("Signature        : %c%c%d%d\n",         // 低低高高
        LByteOfW(LWordOfDW(NtHeader.Signature)), HByteOfW(LWordOfDW(NtHeader.Signature)),
        LByteOfW(HWordOfDW(NtHeader.Signature)), HByteOfW(HWordOfDW(NtHeader.Signature)));

    printf("\nIMAGE_FILE_HEADER    :\n");           // IMAGE_FILE_HEADER
    PrintFileHeader(NtHeader.FileHeader);

    printf("\nIMAGE_OPTIONAL_HEADER       :\n");    // IMAGE_OPTIONAL_HEADER
    PrintOptionalHeader(NtHeader.OptionalHeader);

    printf("\nIMAGE_DATA_DIRECTORY : ");            // 遍历全部 IMAGE_DATA_DIRECTORY
    printf("\n   NO.  VirtualAddress   Size");
    for(i = 0; i < IMAGE_NUMBEROF_DIRECTORY_ENTRIES; i++)
    {
        if(NtHeader.DataDirectory[i].Size != 0)
        {
            printf("\n   %2d", i);
            PrintDataDircrory(NtHeader.DataDirectory[i]);
        }
    }

    // 遍历显示全部 IMAGE_SECTION_HEADER 信息
    printf("\n\nIMAGE_SECTION_HEADER :");
    for(i = 0; i < NtHeader.FileHeader.NumberOfSections; i++)
    {
        printf("\nSECTION_HEADER       : NO.%02d\n", i);
        fread(&SectionHeader, sizeof(IMAGE_SECTION_HEADER), 1, fp);
        PrintSectionHeader(SectionHeader);
    }

    fclose(fp);
    return 0;
}
