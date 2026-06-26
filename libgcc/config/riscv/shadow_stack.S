#ifdef __riscv_software_shadow_stack
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

#endif /* __riscv_software_shadow_stack */
