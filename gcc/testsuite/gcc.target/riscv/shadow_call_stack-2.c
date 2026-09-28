/* { dg-do compile } */
/* { dg-options "-fsanitize=shadow-call-stack -fno-omit-frame-pointer" } */

/* need to pass __attribute__((noinline, noipa)) to prevent the compiler
   from optimizing epilogue and prologue away */

__attribute__((noinline, noipa))
int f3() {
    return 1;
}

__attribute__((noinline, noipa))
int f2() {
    return f3();
}

__attribute__((noinline, noipa))
int f1() {
    return f2();
}

__attribute__((noinline, noipa))
int main() {
    int temp = f1();
    return temp;
}

/* { dg-final { scan-assembler-times { addi\tgp, gp, 4 } 4 } } */
/* { dg-final { scan-assembler-times { addi\tgp, gp, -4 } 4 } } */
