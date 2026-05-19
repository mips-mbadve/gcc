/* { dg-do compile } */
/* { dg-options "-fcf-protection=return -fno-exceptions" } */

int i;

/* { dg-error "'-fcf-protection' software shadow call stack needs explicit '-mno-relax' and '-ffixed-gp'" "" {target "riscv*-*-*" } 0 } */
