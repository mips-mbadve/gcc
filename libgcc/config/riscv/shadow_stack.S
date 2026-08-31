/* Shadow stack save-restore library calls for RISC-V.

   Copyright (C) 2016-2025 Free Software Foundation, Inc.

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 3, or (at your option) any later
version.

GCC is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

Under Section 7 of GPL version 3, you are granted additional
permissions described in the GCC Runtime Library Exception, version
3.1, as published by the Free Software Foundation.

You should have received a copy of the GNU General Public License and
a copy of the GCC Runtime Library Exception along with this program;
see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
<http://www.gnu.org/licenses/>.  */

#include "riscv-asm.h"

#ifdef __SANITIZE_SHADOW_CALL_STACK__
    .text
    .global __shadow_stack_save, __shadow_stack_restore
    .type __shadow_stack_save, @function
    .type __shadow_stack_restore, @function
    .attribute software_shadow_stack, 1

FUNC_BEGIN(__shadow_stack_save)
  la      t1, __shadow_stack_top
  addi    gp, gp, 4
  bgtu    gp, t1, __shadow_stack_chk_fail
  sw      t0, -4(gp)
  ret
FUNC_END(__shadow_stack_save)

FUNC_BEGIN(__shadow_stack_restore)
  lw      t0, -4(gp)
  xor     ra, t0, ra
  bne     ra, zero, __shadow_stack_chk_fail
  addi    gp, gp, -4
  jr      t0
FUNC_END(__shadow_stack_restore)

FUNC_BEGIN(__shadow_stack_chk_fail)
  call abort
FUNC_END(__shadow_stack_chk_fail)

#endif /* __SANITIZE_SHADOW_CALL_STACK__ */
