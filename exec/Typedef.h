/* Typedef.h
   数据类型
   四彩
   2015-11-29
*/


#ifndef _TYPEDEF_H
#define _TYPEDEF_H


#ifndef _STDBOOL_H
    typedef char            BOOL;
    #define TRUE            1
    #define FALSE           0
#endif


typedef unsigned char       BYTE;       // 无符号 1 字节
typedef unsigned short int  WORD;       // 无符号 2 字节
typedef unsigned int        DWORD;      // 无符号 4 字节


// 得到一个 DWORD 的高位 WORD 和低位 WORD
#define LWordOfDW(value)  ((WORD)((DWORD)(value) & 0xFFFF))
#define HWordOfDW(value)  ((WORD)((DWORD)(value) >> 16))

// 得到一个 WORD 的高位 BYTE 和低位 BYTE
#define LByteOfW(value)  ((BYTE)((WORD)(value) & 0xFF))
#define HByteOfW(value)  ((BYTE)((WORD)(value) >> 8))

// 把两个 WORD 转化为一个 DWORD
#define Words2DW(HighWord, LowWord) ((((DWORD)(HighWord)) << 16) + (LowWord))

// 把两个 BYTE 转化为一个 WORD
#define Bytes2W(HighByte, LowByte) ((((WORD)(HighByte)) << 8) + (LowByte))


#endif
