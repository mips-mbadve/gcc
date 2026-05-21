/* { dg-do compile } */
/* { dg-options "-fcf-protection=return -fno-omit-frame-pointer -mno-relax" } */
/* { dg-warning "hardware shadow stack is not compatible with this target" "" { target *-*-* } 0 } */

/* need to pass __attribute__((noinline)) to prevent the compiler
   from optimizing epilogue and prologue away */

__attribute__((noinline)) __attribute__((interrupt("machine")))
void f3() {
}

__attribute__((noinline)) __attribute__((interrupt("supervisor"))) 
void f2() {
}

__attribute__((noinline)) __attribute__((interrupt("user")))  
void f1() {
}

__attribute__((noinline))
int main() {
    f1();
    f2();
    f3();
    return 0;
}

/* { dg-final { scan-assembler {\mmret} } } */
/* { dg-final { scan-assembler {\msret} } } */
/* { dg-final { scan-assembler {\muret} } } */
