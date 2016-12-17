/* stack01.c */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int    a  = 0;                  /* 全局变量初始化区 */
char * p1;                      /* 全局变量未初始化区  */
int main(int argc, char * argv[]) {

    int    b;                   /* 栈 */
    char   s[] = "abc";         /* 栈 */
    char * p2;                  /* 栈 */
    char * p3 = "123456";       /* 123456\0在常量区，p3在栈上。 */
    static int c = 0;           /* 全局（静态）初始化区 */

    printf("int    a  = 0;                  %p.全局变量\n", &a);
    printf("char * p1;                      %p.全局变量\n", &p1);
    printf("int main(int argc, char * argv[]) {\n");
    printf("    int    b;                   %p.局部变量\n", &b);
    printf("    char   s[] = \"abc\";         %p.局部变量\n", &s);
    printf("    char   s[] = \"abc\";         %p.常量\n", &"abc");
    printf("\n");
    printf("    char   s[] = \"abc\";         %p.常量\n", s);
    printf("\n");
    printf("    char * p2;                  %p.局部变量\n", &p2);
    printf("    char * p3 = \"123456\";       %p.局部变量\n", &p3);
    printf("    char * p3 = \"123456\";       %p.常量\n", &"123456");
    printf("\n");
    printf("    char * p3 = \"123456\";       %p.常量\n", p3);
    printf("\n");
    printf("    static int c = 0;           %p.\n", &c);

    p1 = (char *) malloc(10);   
    printf("    p1 = (char *) malloc(10);   %p.\n", &p1);
    printf("    p1 = (char *) malloc(10);   %p.\n", p1);
    p2 = (char *) malloc(20);           /* 分配得来的10和20字节的区域就在堆区。 */
    printf("    p2 = (char *) malloc(20);   %p.\n", &p2);
    printf("    p2 = (char *) malloc(20);   %p.\n", p2);
    strcpy(p1, "123456");               /* 123456\0放在常量区，编译器可能会将它与p3所指向的"123456"优化成一个地方。 */
    printf("    strcpy(p1, \"123456\");       %p.\n", &p1);
    printf("    strcpy(p1, \"123456\");       %p.\n", p1);
    printf("    return 0;\n");
    printf("}\n");

    return 0;
}
