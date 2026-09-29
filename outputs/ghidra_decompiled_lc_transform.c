/* Ghidra decompilation: libmqm.so */

/* ============================================================ */
/* Target 0x4ecb0 */
/* Ghidra name: FUN_0004ecb0 */
/* Entry: 0004ecb0 */

void FUN_0004ecb0(int param_1,uint param_2,int param_3,int param_4,uint param_5,int param_6)

{
  uint uVar1;
  int local_20;
  int iStack_1c;
  int iStack_18;
  
  local_20 = param_3;
  iStack_1c = param_4;
  iStack_18 = param_3;
  if (param_3 != 0 || param_4 != 0) {
    for (; param_5 < param_2; param_5 = param_5 + param_6) {
      uVar1 = __udivsi3(param_5,param_6);
      *(byte *)(param_1 + param_5) =
           *(byte *)(param_1 + param_5) ^ *(byte *)((int)&local_20 + (uVar1 & 7));
    }
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
/* Target 0x764cc */
/* Ghidra name: FUN_000764cc */
/* Entry: 000764cc */

int FUN_000764cc(int param_1,undefined4 param_2,undefined4 param_3,int param_4,undefined4 param_5)

{
  int iVar1;
  int *piVar2;
  int *piVar3;
  int iVar4;
  int iVar5;
  undefined1 auStack_34 [24];
  
  if (param_4 == 0) {
    param_4 = DAT_00076548 + 0x764e2;
  }
  FUN_00083222(param_1,auStack_34,param_2,param_3);
  iVar1 = FUN_0007956c(param_1,auStack_34,param_4,param_5);
  if ((iVar1 == 0) &&
     (iVar4 = *(int *)(*(int *)(param_1 + 8) + -0x10), *(char *)(iVar4 + 6) == '\x01')) {
    piVar2 = (int *)FUN_00080c0c(*(undefined4 *)(*(int *)(param_1 + 0xc) + 0x28),2);
    piVar3 = *(int **)(*(int *)(iVar4 + 0x10) + 8);
    iVar5 = piVar2[1];
    *piVar3 = *piVar2;
    piVar3[1] = iVar5;
    piVar3[2] = piVar2[2];
    if ((piVar2[2] << 0x19 < 0) && ((*(byte *)(*piVar2 + 5) & 3) != 0)) {
      if ((int)((uint)*(byte *)(*(int *)(iVar4 + 0x10) + 5) << 0x1d) < 0) {
        FUN_0007a6c2(param_1);
      }
    }
  }
  return iVar1;
}



/* ============================================================ */
/* Target 0x79518 */
/* Ghidra name: FUN_00079518 */
/* Entry: 00079518 */

int FUN_00079518(int param_1,undefined4 param_2,undefined4 param_3,int param_4,undefined4 param_5)

{
  undefined2 uVar1;
  undefined1 uVar2;
  int iVar3;
  undefined4 uVar4;
  undefined4 uVar5;
  
  uVar5 = *(undefined4 *)(param_1 + 0x48);
  uVar4 = *(undefined4 *)(param_1 + 0x10);
  *(undefined4 *)(param_1 + 0x48) = param_5;
  uVar2 = *(undefined1 *)(param_1 + 0x29);
  uVar1 = *(undefined2 *)(param_1 + 0x24);
  iVar3 = FUN_00078db6();
  if (iVar3 != 0) {
    param_4 = param_4 + *(int *)(param_1 + 0x1c);
    FUN_00079960(param_1,param_4);
    FUN_00078c2c(param_1,iVar3,param_4);
    *(undefined4 *)(param_1 + 0x10) = uVar4;
    *(undefined1 *)(param_1 + 0x29) = uVar2;
    *(undefined2 *)(param_1 + 0x24) = uVar1;
    FUN_00078ef4(param_1);
  }
  *(undefined4 *)(param_1 + 0x48) = uVar5;
  return iVar3;
}



