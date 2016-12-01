#include <stdio.h>
/* #include <stdint.h> */

/*
typedef unsigned long long uint64_t;
typedef unsigned int uint32_t;
*/

int main() {

  char c; /* -128 - 127 */
  unsigned char uc; /* 0 - 255 */

  printf("sizeof(char)  =%d\r\n", sizeof(char)); /* 1 */
  printf("sizeof(short) =%d\r\n", sizeof(short)); /* 2 */
  printf("sizeof(int)   =%d\r\n", sizeof(int)); /* 4 */
  printf("sizeof(long)  =%d\r\n", sizeof(long)); /* 4 */
/*  printf("sizeof(long long)  =%d\r\n", sizeof(long long)); *//* 8 */
/*  printf("sizeof(uint8_t)  =%d\r\n", sizeof(uint8_t)); *//* 1 */
/*  printf("sizeof(uint16_t)  =%d\r\n", sizeof(uint16_t)); *//* 2 */
/*  printf("sizeof(uint32_t)  =%d\r\n", sizeof(uint32_t)); *//* 4 */
/*  printf("sizeof(uint64_t)  =%d\r\n", sizeof(uint64_t)); *//* 8 */
  printf("sizeof(float) =%d\r\n", sizeof(float)); /* 4 */
  printf("sizeof(double)=%d\r\n", sizeof(double)); /* 8 */
  printf("sizeof(long double)=%d\r\n", sizeof(long double)); /* 12 */

  printf("sizeof(char*)  =%d\r\n", sizeof(char *)); /* 4 */
  printf("sizeof(short*) =%d\r\n", sizeof(short *)); /* 4 */
  printf("sizeof(int*)   =%d\r\n", sizeof(int *)); /* 4 */
  printf("sizeof(long*)  =%d\r\n", sizeof(long *)); /* 4 */
  printf("sizeof(float*) =%d\r\n", sizeof(float *)); /* 4 */
  printf("sizeof(double*)=%d\r\n", sizeof(double *)); /* 4 */
  printf("sizeof(long double*)=%d\r\n", sizeof(long double *)); /* 4 */
  
  c = 128;
  uc = 128;
  printf("%d %d %u %u\n", c, c, uc, uc);
  c = 255;
  uc = 255;
  printf("%d %d %u %u\n", c, c, uc, uc);

  c = 256;
  uc = 257;
  printf("%d %d %u %u\n", c, c, uc, uc);

  return 0;
}
