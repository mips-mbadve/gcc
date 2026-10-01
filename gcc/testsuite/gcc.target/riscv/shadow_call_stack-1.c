/* Shadow call stack should be enabled for RISC-V targets */
/* { dg-do compile { target { riscv*-*-* } } } */
/* { dg-options "-fsanitize=shadow-call-stack -fno-exceptions" } */

int i;
