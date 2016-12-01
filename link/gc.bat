gcc hello.c

gcc -E hello.c -o hello.i
gcc -S hello.i -o hello.s
    gcc -S hello.c -o hello.s
gcc -c hello.s -o hello.o
    gcc -c hello.c -o hello.o

objdump -h hello.o
objdump -s -d hello.o


gcc -c a.c b.c

ld a.o b.o -e main -o ab


objdump -h a.o > a.o_info.txt
objdump -h b.o > b.o_info.txt

gcc -v a.c b.c -o ab.exe
