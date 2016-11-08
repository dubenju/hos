.MODEL TINY
.CODE
ORG 100H
START:
    PUSH CS
    POP  DS;为数据段寄存器赋值
    ;在这里尽情写代码吧
    ;如果程序在DOS下运行，根据需要可加上退出程序回到DOS的代码
END START
