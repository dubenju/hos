/* stack06.c */
int foo() {
    return foo();
}

int main(int argc, char * argv[]) {
    foo();
    return 0;
}
