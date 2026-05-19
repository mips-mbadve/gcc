/* { dg-do compile } */
/* { dg-options "-fcf-protection=return -fno-exceptions -ffixed-gp" } */

int i;

/* { dg-error "'-fcf-protection' software shadow call stack needs explicit '-mno-relax' and '-ffixed-gp'" "" {target "riscv*-*-*" } 0 } */
