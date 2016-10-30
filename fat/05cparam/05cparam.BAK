/*
 * 
 *//*
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>


int main()
{
  struct stat fi;
  stat("/", &fi);
  printf("%d\n", fi.st_size);
  return 0;
}
*/
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sys/stat.h>

int setint(int * p) {
    *p = 10;
}

int main(int argc, char **argv){
    int osize = 0x500000;
    printf("%d.\n", osize);
    setint(&osize);
    printf("%d.\n", osize);
  return 0;
}
