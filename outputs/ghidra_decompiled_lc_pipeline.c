/* Ghidra decompilation: libmqm.so */

/* ============================================================ */
/* Target 0x5ecb0 */
/* Ghidra name: FUN_0005ebbe */
/* Entry: 0005ebbe */

int * FUN_0005ebbe(int *param_1,int param_2,int *param_3,undefined4 param_4)

{
  int iVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  int local_48;
  int local_44;
  int local_40 [2];
  int local_38 [2];
  int local_30 [2];
  int local_28 [2];
  
  iVar4 = *param_3;
  if (iVar4 == *(int *)(param_2 + 8)) {
    if (*(int *)(param_2 + 0x10) == 0) {
      FUN_0005eb32(local_40,param_2,param_4);
LAB_0005ed34:
      *param_1 = local_40[0];
      return param_1;
    }
    iVar1 = FUN_0005e96e(param_4,iVar4 + 0x10);
    iVar3 = iVar4;
    if (iVar1 == 0) {
      iVar1 = FUN_0005e96e(iVar4 + 0x10,param_4);
      if (iVar1 == 0) {
        *param_1 = iVar4;
        return param_1;
      }
      local_44 = iVar4;
      FUN_0005ea34(&local_44);
      iVar3 = local_44;
      if (local_44 == param_2) {
        iVar4 = local_44;
        iVar3 = *param_3;
        iVar2 = 0;
        iVar1 = *param_3;
        goto LAB_0005ed18;
      }
      iVar4 = FUN_0005e96e(param_4,local_44 + 0x10);
      if (iVar4 == 0) {
        FUN_0005eb32(local_38,param_2,param_4);
        local_40[0] = local_38[0];
        goto LAB_0005ed34;
      }
      iVar1 = *param_3;
      if (*(int *)(iVar1 + 0xc) == 0) goto LAB_0005ed06;
    }
  }
  else {
    if (iVar4 == param_2) {
      iVar3 = *(int *)(iVar4 + 0xc);
      iVar1 = FUN_0005e96e(iVar3 + 0x10,param_4);
      if (iVar1 == 0) {
        FUN_0005eb32(local_30,iVar4,param_4);
        local_40[0] = local_30[0];
        goto LAB_0005ed34;
      }
      iVar2 = 0;
      iVar1 = iVar4;
      goto LAB_0005ed18;
    }
    local_48 = iVar4;
    FUN_0005ea60(&local_48);
    iVar3 = *param_3;
    iVar4 = FUN_0005e96e(param_4,iVar3 + 0x10);
    iVar1 = local_48;
    if ((iVar4 == 0) || (iVar2 = FUN_0005e96e(local_48 + 0x10,param_4), iVar2 == 0)) {
      iVar1 = 0;
      local_44 = iVar3;
      FUN_0005ea34(&local_44);
      if (((iVar4 != 0) || (iVar1 = FUN_0005e96e(*param_3 + 0x10,param_4), iVar1 == 0)) ||
         ((local_44 != param_2 && (iVar3 = FUN_0005e96e(param_4,local_44 + 0x10), iVar3 == 0)))) {
        if (iVar4 == iVar1) {
          local_40[0] = *param_3;
        }
        else {
          FUN_0005eb32(local_28,param_2,param_4);
          local_40[0] = local_28[0];
        }
        goto LAB_0005ed34;
      }
      iVar1 = *param_3;
      if (*(int *)(iVar1 + 0xc) != 0) {
        iVar1 = 0;
        iVar4 = param_2;
        iVar3 = local_44;
        iVar2 = local_44;
        goto LAB_0005ed18;
      }
LAB_0005ed06:
      iVar4 = param_2;
      iVar3 = iVar1;
      iVar2 = 0;
      goto LAB_0005ed18;
    }
    if (*(int *)(iVar1 + 0xc) == 0) {
      iVar4 = param_2;
      iVar3 = iVar1;
      iVar2 = 0;
      goto LAB_0005ed18;
    }
  }
  iVar4 = param_2;
  iVar2 = iVar3;
  iVar1 = 0;
LAB_0005ed18:
  FUN_0005eabe(param_1,iVar4,iVar3,param_4,iVar2,iVar1);
  return param_1;
}



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
/* Target 0x4fb0c */
/* Ghidra name: FUN_0004fb0c */
/* Entry: 0004fb0c */

int * FUN_0004fb0c(int *param_1)

{
  int iVar1;
  bool bVar2;
  
  bVar2 = (char)param_1[10] != '\0';
  if ((char)param_1[0xc] == '\0') {
    if (*(char *)((int)param_1 + 0x2f) != '\0') {
      if ((void *)param_1[0x15] != (void *)0x0) {
        std::_Filebuf_base::_M_unmap
                  ((_Filebuf_base *)(param_1 + 8),(void *)param_1[0x15],param_1[0x16]);
        param_1[0x15] = 0;
        param_1[0x16] = 0;
      }
      *(undefined1 *)((int)param_1 + 0x2f) = 0;
    }
  }
  else if ((bVar2) && (iVar1 = (**(code **)(*param_1 + 0x34))(param_1,0xffffffff), iVar1 != -1)) {
    if (((char)param_1[0xc] != '\0') && ((char)param_1[0xb] == '\0')) {
      iVar1 = FUN_0004ea8c(param_1);
      bVar2 = iVar1 != 0 && bVar2;
    }
  }
  else {
    bVar2 = false;
  }
  iVar1 = std::_Filebuf_base::_M_close((_Filebuf_base *)(param_1 + 8));
  param_1[0x14] = 0;
  param_1[0x13] = 0;
  param_1[0x12] = 0;
  param_1[0x11] = 0;
  param_1[0x15] = 0;
  param_1[0x16] = 0;
  param_1[1] = 0;
  param_1[2] = 0;
  param_1[3] = 0;
  param_1[4] = 0;
  param_1[5] = 0;
  param_1[6] = 0;
  param_1[0x19] = 0;
  param_1[0x18] = 0;
  param_1[0x17] = 0;
  *(undefined1 *)((int)param_1 + 0x32) = 0;
  *(undefined1 *)((int)param_1 + 0x31) = 0;
  *(undefined1 *)(param_1 + 0xc) = 0;
  *(undefined1 *)((int)param_1 + 0x2f) = 0;
  if (iVar1 == 0) {
    bVar2 = false;
  }
  if (!bVar2) {
    param_1 = (int *)0x0;
  }
  return param_1;
}



/* ============================================================ */
/* Target 0x77530 */
/* Ghidra name: FUN_00077530 */
/* Entry: 00077530 */

void FUN_00077530(undefined4 param_1,undefined4 param_2,undefined4 param_3,undefined4 param_4,
                 undefined4 param_5)

{
  undefined4 local_10;
  undefined4 local_c;
  
  local_10 = param_2;
  local_c = param_3;
  FUN_000764cc(param_1,DAT_00077548 + 0x77542,&local_10,param_4,param_5,param_2);
  return;
}



/* ============================================================ */
/* Target 0x76428 */
/* Ghidra name: FUN_00076428 */
/* Entry: 00076428 */

undefined4
FUN_00076428(int param_1,uint param_2,int param_3,int param_4,undefined4 param_5,int param_6)

{
  int iVar1;
  undefined4 uVar2;
  int iVar3;
  int local_20;
  int local_1c;
  
  iVar1 = 0;
  local_1c = param_4;
  if (param_4 != 0) {
    local_20 = param_3;
    iVar1 = FUN_00075758(param_1,param_4,param_3,param_4,param_1,param_2);
    iVar1 = iVar1 - *(int *)(param_1 + 0x1c);
  }
  local_20 = *(int *)(param_1 + 8) + ~param_2 * 0x10;
  if ((param_6 == 0) || (*(short *)(param_1 + 0x24) != 0)) {
    local_1c = param_3;
    uVar2 = FUN_00079518(param_1,DAT_000764c8 + 0x76466,&local_20,
                         local_20 - *(int *)(param_1 + 0x1c),iVar1);
  }
  else {
    iVar3 = *(int *)(param_1 + 0x10);
    *(int *)(iVar3 + 0x1c) = param_6;
    *(undefined4 *)(iVar3 + 0x18) = param_5;
    *(int *)(iVar3 + 0x14) = local_20 - *(int *)(param_1 + 0x1c);
    *(undefined1 *)(iVar3 + 0x24) = *(undefined1 *)(param_1 + 0x29);
    *(undefined4 *)(iVar3 + 0x20) = *(undefined4 *)(param_1 + 0x48);
    *(int *)(param_1 + 0x48) = iVar1;
    *(byte *)(iVar3 + 0x12) = *(byte *)(iVar3 + 0x12) | 0x10;
    FUN_000793a4(param_1,local_20,param_3,1);
    *(byte *)(iVar3 + 0x12) = *(byte *)(iVar3 + 0x12) & 0xef;
    *(undefined4 *)(param_1 + 0x48) = *(undefined4 *)(iVar3 + 0x20);
    uVar2 = 0;
  }
  if (param_3 == -1) {
    if (*(uint *)(*(int *)(param_1 + 0x10) + 4) < *(uint *)(param_1 + 8)) {
      *(uint *)(*(int *)(param_1 + 0x10) + 4) = *(uint *)(param_1 + 8);
    }
  }
  return uVar2;
}



/* ============================================================ */
/* Target 0x52a32 */
/* Ghidra name: FUN_00052a32 */
/* Entry: 00052a32 */

undefined4
FUN_00052a32(undefined4 param_1,int *param_2,int *param_3,int *param_4,int *param_5,
            undefined4 *param_6)

{
  int *piVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  undefined1 auStack_44 [4];
  undefined4 local_40;
  undefined4 local_3c;
  int local_38;
  int local_34;
  undefined4 local_30;
  undefined4 local_2c;
  
  while( true ) {
    local_38 = *param_3;
    local_34 = *param_2;
    if ((local_34 == local_38) || (*param_4 == *param_5)) break;
    iVar3 = local_34 + 0x10;
    iVar4 = *param_4 + 0x10;
    iVar2 = FUN_00052476(iVar3,iVar4);
    if (iVar2 == 0) {
      iVar2 = FUN_00052476(iVar4,iVar3);
      piVar1 = param_4;
      if (iVar2 == 0) {
        FUN_0004fae0(param_2);
      }
    }
    else {
      local_40 = param_6[1];
      FUN_00052874(&local_3c,*param_6,&local_40,iVar3);
      param_6[1] = local_3c;
      FUN_0004fae0(param_6 + 1);
      piVar1 = param_2;
    }
    FUN_0004fae0(piVar1);
  }
  local_30 = *param_6;
  local_2c = param_6[1];
  FUN_000529ea(param_1,&local_34,&local_38,&local_30,auStack_44,0);
  return param_1;
}



