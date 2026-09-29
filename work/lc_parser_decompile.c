/* Ghidra decompilation: libmqm.so */

/* ============================================================ */
/* Target 0x12e544 */
/* Ghidra name: FUN_0012e544 */
/* Entry: 0012e544 */

uint FUN_0012e544(undefined4 param_1,int *param_2)

{
  int iVar1;
  uint uVar2;
  undefined1 auStack_48 [60];
  
  FUN_001387fc(auStack_48,param_2,0xffffffff);
  iVar1 = FUN_0012f60c(param_1,auStack_48);
  if (iVar1 == 0) {
    uVar2 = 0;
  }
  else {
    uVar2 = (*(uint *)((int)param_2 + *(int *)(*param_2 + -0xc) + 8) & 3) >> 1;
  }
  FUN_00138114(auStack_48);
  return uVar2;
}



/* ============================================================ */
/* Target 0x12f58c */
/* Ghidra name: FUN_0012f58c */
/* Entry: 0012f58c */

void FUN_0012f58c(int *param_1,undefined4 param_2)

{
  int iVar1;
  undefined4 uVar2;
  int *piVar3;
  undefined1 auStack_54 [4];
  undefined1 auStack_50 [24];
  undefined1 auStack_38 [36];
  int local_14;
  
  piVar3 = *(int **)(DAT_0012f604 + 0x12f59a);
  local_14 = *piVar3;
  (**(code **)(*param_1 + 0x10))();
  iVar1 = (**(code **)(*param_1 + 0x20))(param_1,param_2);
  uVar2 = 0;
  if (iVar1 != 0) {
    iVar1 = (**(code **)(*param_1 + 0x14))(param_1);
    uVar2 = 1;
    if (iVar1 == 0) {
      FUN_00139818(auStack_38,2,DAT_0012f608 + 0x12f5ca,0x7b);
      FUN_0012f34c(auStack_50,param_1);
      uVar2 = FUN_00139d64(auStack_38,auStack_50);
      FUN_00139c9c(auStack_54,uVar2);
      FUN_000334d4(auStack_50);
      FUN_00139678(auStack_38);
      uVar2 = 0;
    }
  }
  if (local_14 != *piVar3) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar2);
  }
  return;
}



/* ============================================================ */
/* Target 0x12f60c */
/* Ghidra name: FUN_0012f60c */
/* Entry: 0012f60c */

undefined1 FUN_0012f60c(undefined4 param_1)

{
  int iVar1;
  undefined1 auStack_44 [24];
  undefined1 local_2c;
  
  FUN_0012ef9c(auStack_44);
  iVar1 = FUN_0012f58c(param_1,auStack_44);
  if (iVar1 == 0) {
    local_2c = 0;
  }
  FUN_00135e70(auStack_44);
  return local_2c;
}



/* ============================================================ */
/* Target 0x12f6b0 */
/* Ghidra name: FUN_0012f678 */
/* Entry: 0012f678 */

void FUN_0012f678(int *param_1)

{
  int iVar1;
  undefined4 uVar2;
  int *piVar3;
  undefined1 auStack_54 [4];
  undefined1 auStack_50 [24];
  undefined1 auStack_38 [36];
  int local_14;
  
  piVar3 = *(int **)(DAT_0012f6e4 + 0x12f684);
  local_14 = *piVar3;
  iVar1 = (**(code **)(*param_1 + 0x20))();
  uVar2 = 0;
  if (iVar1 != 0) {
    iVar1 = (**(code **)(*param_1 + 0x14))(param_1);
    uVar2 = 1;
    if (iVar1 == 0) {
      FUN_00139818(auStack_38,2,DAT_0012f6e8 + 0x12f6aa,0x7b);
      FUN_0012f34c(auStack_50,param_1);
      uVar2 = FUN_00139d64(auStack_38,auStack_50);
      FUN_00139c9c(auStack_54,uVar2);
      FUN_000334d4(auStack_50);
      FUN_00139678(auStack_38);
      uVar2 = 0;
    }
  }
  if (local_14 != *piVar3) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar2);
  }
  return;
}



/* ============================================================ */
/* Target 0x12f700 */
/* Ghidra name: FUN_0012f6f2 */
/* Entry: 0012f6f2 */

undefined4 * FUN_0012f6f2(undefined4 *param_1)

{
  void *pvVar1;
  uint uVar2;
  
  pvVar1 = (void *)*param_1;
  if (pvVar1 != (void *)0x0) {
    uVar2 = param_1[2] - (int)pvVar1 & 0xfffffffc;
    if (uVar2 < 0x81) {
      std::__node_alloc::_M_deallocate(pvVar1,uVar2);
    }
    else {
      operator_delete(pvVar1);
    }
  }
  return param_1;
}



/* ============================================================ */
/* Target 0x12f800 */
/* No function found */

