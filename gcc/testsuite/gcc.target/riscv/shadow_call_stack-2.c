/* { dg-do compile } */
/* { dg-options "-fsanitize=shadow-call-stack -fno-omit-frame-pointer -mno-relax -Os" } */
/* { dg-warning "hardware shadow stack is not compatible with this target" "" { target *-*-* } 0 } */

/* need to pass __attribute__((noinline)) to prevent the compiler
   from optimizing epilogue and prologue away */

__attribute__((noinline))
int f3() {
    return 1;
}

__attribute__((noinline))
int f2() {
    return f3();
}

__attribute__((noinline))
int f1() {
    return f2();
}

__attribute__((noinline))
int main() {
    int temp = f1();
    return temp;
}

/* { dg-final { scan-assembler-times {call\s+__shadow_stack_save} 4 } } */
/* { dg-final { scan-assembler-times {call\s+__shadow_stack_restore} 4 } } */
