#include <stdio.h>
#include <stdint.h>

/*
typedef unsigned long long uint64_t;
typedef unsigned int uint32_t;
*/

int main() {
  printf("sizeof(char)  =%d\r\n", sizeof(char));
  printf("sizeof(short) =%d\r\n", sizeof(short));
  printf("sizeof(int)   =%d\r\n", sizeof(int));
  printf("sizeof(long)  =%d\r\n", sizeof(long));
  printf("sizeof(long long)  =%d\r\n", sizeof(long long));
  printf("sizeof(uint32_t)  =%d\r\n", sizeof(uint32_t));
  printf("sizeof(uint64_t)  =%d\r\n", sizeof(uint64_t));
  printf("sizeof(float) =%d\r\n", sizeof(float));
  printf("sizeof(double)=%d\r\n", sizeof(double));
  printf("sizeof(long double)=%d\r\n", sizeof(long double));

  printf("sizeof(char*)  =%d\r\n", sizeof(char *));
  printf("sizeof(short*) =%d\r\n", sizeof(short *));
  printf("sizeof(int*)   =%d\r\n", sizeof(int *));
  printf("sizeof(long*)  =%d\r\n", sizeof(long *));
  printf("sizeof(float*) =%d\r\n", sizeof(float *));
  printf("sizeof(double*)=%d\r\n", sizeof(double *));
  printf("sizeof(long double*)=%d\r\n", sizeof(long double *));

  return 0;
}
