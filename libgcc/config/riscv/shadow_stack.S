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

#ifdef __SANITIZE_SHADOW_CALL_STACK__
    .text
    .global __shadow_stack_save, __shadow_stack_restore
    .type __shadow_stack_save, @function
    .type __shadow_stack_restore, @function
    .attribute software_shadow_stack, 1

__shadow_stack_save:
  la      t2, __shadow_stack_top
  addi    t1, gp, 4
  bgtu    t1, t2, __shadow_stack_chk_fail
  addi    gp, gp, 4
  sw      t0, -4(gp)
  ret
  .size   __shadow_stack_save, .-__shadow_stack_save

__shadow_stack_restore:
  lw      t0, -4(gp)
  xor     t1, t0, t1
  bne     t1, zero, __shadow_stack_chk_fail
  addi    gp, gp, -4
  jr      t0
  .size   __shadow_stack_restore, .-__shadow_stack_restore

__shadow_stack_chk_fail:
  call exit
  .size __shadow_stack_chk_fail, .-__shadow_stack_chk_fail

#endif /* __SANITIZE_SHADOW_CALL_STACK__ */
