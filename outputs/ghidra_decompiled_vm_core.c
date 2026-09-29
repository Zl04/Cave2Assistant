/* Ghidra decompilation: libmqm.so */

/* ============================================================ */
/* Target 0x33bec */
/* Ghidra name: FUN_00033bec */
/* Entry: 00033bec */

void FUN_00033bec(_JNIEnv *param_1,undefined4 param_2,_jstring *param_3,_jstring *param_4,
                 _jstring *param_5,undefined4 *param_6,undefined4 *param_7,undefined4 *param_8,
                 undefined4 *param_9)

{
  int iVar1;
  FILE *__stream;
  undefined4 uVar2;
  undefined4 uVar3;
  undefined4 uVar4;
  int *piVar5;
  CJavaToString aCStack_524 [8];
  undefined4 local_51c;
  CJavaToString aCStack_518 [8];
  undefined4 local_510;
  CJavaToString aCStack_50c [8];
  undefined4 local_504;
  CJavaToString aCStack_500 [8];
  undefined4 local_4f8;
  CJavaToString aCStack_4f4 [8];
  undefined4 local_4ec;
  undefined1 auStack_4e8 [20];
  char *local_4d4;
  undefined1 auStack_4d0 [1188];
  int local_2c;
  
  piVar5 = *(int **)(DAT_00033d60 + 0x33c00);
  local_2c = *piVar5;
  CJavaToString::CJavaToString(aCStack_524,param_1,param_3);
  CJavaToString::CJavaToString(aCStack_518,param_1,param_4);
  iVar1 = DAT_00033d64;
  CJavaToString::CJavaToString(aCStack_50c,param_1,param_5);
  FUN_000339d8(auStack_4e8,iVar1 + 0x33f6e,DAT_00033d68 + 0x33c38);
  __stream = freopen(local_4d4,(char *)(DAT_00033d70 + 0x33c48),
                     (FILE *)(*(int *)(DAT_00033d6c + 0x33c42) + 0x54));
  FUN_000334d4(auStack_4e8);
  FUN_00050f14(auStack_4d0,*(undefined4 *)(iVar1 + 0x33f82),*(undefined4 *)(iVar1 + 0x33c46));
  FUN_0004f76c(auStack_4d0,param_1);
  uVar2 = (**(code **)(*(int *)param_1 + 0x7c))(param_1,param_2);
  uVar3 = (**(code **)(*(int *)param_1 + 0x84))
                    (param_1,uVar2,DAT_00033d74 + 0x33c80,DAT_00033d78 + 0x33c82);
  FUN_000331ca(param_1,param_2,uVar3,auStack_4d0,auStack_4d0,(int)auStack_4d0 >> 0x1f);
  CJavaToString::CJavaToString(aCStack_500,(_JNIEnv *)*param_6,(_jstring *)*param_7);
  CJavaToString::CJavaToString(aCStack_4f4,(_JNIEnv *)*param_6,(_jstring *)*param_8);
  uVar4 = FUN_00053cfc(auStack_4d0,local_51c,local_510,local_504,local_4f8,local_4ec,*param_9);
  CJavaToString::~CJavaToString(aCStack_4f4);
  CJavaToString::~CJavaToString(aCStack_500);
  FUN_000331ca(param_1,param_2,uVar3,0,0,0);
  (**(code **)(*(int *)param_1 + 0x5c))(param_1,uVar2);
  if (__stream != (FILE *)0x0) {
    fclose(__stream);
  }
  FUN_000504f0(auStack_4d0);
  CJavaToString::~CJavaToString(aCStack_50c);
  CJavaToString::~CJavaToString(aCStack_518);
  CJavaToString::~CJavaToString(aCStack_524);
  if (local_2c != *piVar5) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar4);
  }
  return;
}



/* ============================================================ */
/* Target 0x33dc0 */
/* Ghidra name: FUN_00033dc0 */
/* Entry: 00033dc0 */

void FUN_00033dc0(_JNIEnv *param_1,undefined4 param_2,undefined4 param_3,_jstring *param_4,
                 _jstring *param_5,undefined4 *param_6,undefined4 *param_7)

{
  int iVar1;
  undefined4 uVar2;
  undefined4 uVar3;
  FILE *__stream;
  undefined4 uVar4;
  undefined4 uVar5;
  int *piVar6;
  CJavaToString aCStack_500 [8];
  undefined4 local_4f8;
  CJavaToString aCStack_4f4 [8];
  undefined4 local_4ec;
  undefined1 auStack_4e8 [20];
  char *local_4d4;
  undefined1 auStack_4d0 [1188];
  int local_2c;
  
  piVar6 = *(int **)(DAT_00033f18 + 0x33dd4);
  local_2c = *piVar6;
  CJavaToString::CJavaToString(aCStack_500,param_1,param_4);
  CJavaToString::CJavaToString(aCStack_4f4,param_1,param_5);
  iVar1 = DAT_00033f1c;
  uVar2 = (**(code **)(*(int *)param_1 + 0x2e0))(param_1,param_3,0);
  uVar3 = (**(code **)(*(int *)param_1 + 0x2ac))(param_1,param_3);
  FUN_000339d8(auStack_4e8,iVar1 + 0x34148,DAT_00033f20 + 0x33e1e);
  __stream = freopen(local_4d4,(char *)(DAT_00033f28 + 0x33e36),
                     (FILE *)(*(int *)(DAT_00033f24 + 0x33e30) + 0x54));
  FUN_000334d4(auStack_4e8);
  FUN_00050f14(auStack_4d0,*(undefined4 *)(iVar1 + 0x3415c),*(undefined4 *)(iVar1 + 0x33e20));
  FUN_0004f76c(auStack_4d0,param_1);
  uVar4 = (**(code **)(*(int *)param_1 + 0x7c))(param_1,param_2);
  uVar5 = (**(code **)(*(int *)param_1 + 0x84))
                    (param_1,uVar4,DAT_00033f2c + 0x33e6e,DAT_00033f30 + 0x33e70);
  FUN_000331ca(param_1,param_2,uVar5,auStack_4d0,auStack_4d0,(int)auStack_4d0 >> 0x1f);
  uVar3 = FUN_00053bb4(auStack_4d0,uVar2,uVar3,local_4f8,local_4ec,*param_6,*param_7,param_7[1]);
  FUN_000331ca(param_1,param_2,uVar5,0,0,0);
  (**(code **)(*(int *)param_1 + 0x5c))(param_1,uVar4);
  if (__stream != (FILE *)0x0) {
    fclose(__stream);
  }
  (**(code **)(*(int *)param_1 + 0x300))(param_1,param_3,uVar2,0);
  FUN_000504f0(auStack_4d0);
  CJavaToString::~CJavaToString(aCStack_4f4);
  CJavaToString::~CJavaToString(aCStack_500);
  if (local_2c != *piVar6) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar3);
  }
  return;
}



/* ============================================================ */
/* Target 0x33f94 */
/* Ghidra name: FUN_00033f94 */
/* Entry: 00033f94 */

void FUN_00033f94(_JNIEnv *param_1,undefined4 param_2,_jstring *param_3,_jstring *param_4,
                 _jstring *param_5,undefined4 *param_6,undefined4 *param_7)

{
  FILE *__stream;
  undefined4 uVar1;
  undefined4 uVar2;
  undefined4 uVar3;
  int iVar4;
  int *piVar5;
  CJavaToString aCStack_504 [8];
  undefined4 local_4fc;
  CJavaToString aCStack_4f8 [8];
  undefined4 local_4f0;
  CJavaToString aCStack_4ec [8];
  undefined4 local_4e4;
  undefined1 auStack_4e0 [20];
  char *local_4cc;
  undefined1 auStack_4c8 [1188];
  int local_24;
  
  piVar5 = *(int **)(DAT_000340c0 + 0x33faa);
  local_24 = *piVar5;
  CJavaToString::CJavaToString(aCStack_504,param_1,param_3);
  CJavaToString::CJavaToString(aCStack_4f8,param_1,param_4);
  iVar4 = DAT_000340c4;
  CJavaToString::CJavaToString(aCStack_4ec,param_1,param_5);
  FUN_000339d8(auStack_4e0,iVar4 + 0x34314,DAT_000340c8 + 0x33fde);
  __stream = freopen(local_4cc,(char *)(DAT_000340d0 + 0x33fee),
                     (FILE *)(*(int *)(DAT_000340cc + 0x33fe8) + 0x54));
  FUN_000334d4(auStack_4e0);
  FUN_00050f14(auStack_4c8,*(undefined4 *)(iVar4 + 0x34328),*(undefined4 *)(iVar4 + 0x33fec));
  FUN_0004f76c(auStack_4c8,param_1);
  uVar1 = (**(code **)(*(int *)param_1 + 0x7c))(param_1,param_2);
  uVar2 = (**(code **)(*(int *)param_1 + 0x84))
                    (param_1,uVar1,DAT_000340d4 + 0x34026,DAT_000340d8 + 0x34028);
  iVar4 = (int)auStack_4c8 >> 0x1f;
  FUN_000331ca(param_1,param_2,uVar2,auStack_4c8,auStack_4c8,iVar4);
  uVar3 = FUN_00053c18(auStack_4c8,local_4fc,local_4f0,local_4e4,*param_6,iVar4,*param_7,param_7[1])
  ;
  FUN_000331ca(param_1,param_2,uVar2,0,0,0);
  (**(code **)(*(int *)param_1 + 0x5c))(param_1,uVar1);
  if (__stream != (FILE *)0x0) {
    fclose(__stream);
  }
  FUN_000504f0(auStack_4c8);
  CJavaToString::~CJavaToString(aCStack_4ec);
  CJavaToString::~CJavaToString(aCStack_4f8);
  CJavaToString::~CJavaToString(aCStack_504);
  if (local_24 != *piVar5) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar3);
  }
  return;
}



/* ============================================================ */
/* Target 0x53548 */
/* Ghidra name: FUN_00053548 */
/* Entry: 00053548 */

void FUN_00053548(int *param_1,int param_2,undefined4 param_3,undefined4 param_4)

{
  void *pvVar1;
  int iVar2;
  undefined4 *puVar3;
  void *pvVar4;
  int *piVar5;
  int iVar6;
  uint uVar7;
  int *piVar8;
  undefined4 uVar9;
  int iVar10;
  undefined4 *puVar11;
  int iVar12;
  uint __n;
  int *piVar13;
  undefined4 *puVar14;
  void *pvVar15;
  int iVar16;
  undefined1 auStack_100 [4];
  undefined1 auStack_fc [4];
  undefined4 local_f8;
  undefined4 local_f4;
  undefined1 auStack_f0 [8];
  void *local_e8;
  void *local_e4;
  uint local_dc;
  undefined1 auStack_d8 [8];
  void *local_d0;
  void *local_cc;
  undefined4 *local_c8;
  int local_c4;
  undefined4 *local_bc;
  int local_b8;
  uint local_a8;
  undefined1 auStack_a4 [16];
  int local_94;
  int local_90;
  undefined1 auStack_8c [24];
  undefined4 *local_74;
  undefined4 *local_70;
  undefined4 *local_6c;
  undefined4 *local_68;
  undefined4 *local_64;
  undefined4 *local_60;
  undefined1 auStack_5c [24];
  undefined1 auStack_44 [24];
  int local_2c;
  
  iVar10 = DAT_000538b8;
  piVar8 = *(int **)(DAT_000538b4 + 0x5355c);
  local_2c = *piVar8;
  if (*param_1 == 0) {
    uVar9 = 0x65;
    goto LAB_0005389c;
  }
  *(uint *)(param_2 + 0x48) = *(uint *)(param_2 + 0x48) | 2;
  pvVar15 = *(void **)(iVar10 + 0x5357c);
  if (*(void **)(param_2 + 0xc) == pvVar15) {
    pvVar1 = operator_new(0x18);
    FUN_0004ff2e();
    *(void **)(param_2 + 0xc) = pvVar1;
  }
  iVar10 = *(int *)(param_2 + 0xc);
  param_1[0x2b] = (uint)*(byte *)(param_2 + 0x40);
  iVar12 = *(int *)(param_2 + 0x14);
  if (-1 < iVar12) {
    local_f8 = 0;
    FUN_0005255c(param_1 + 1,iVar12,&local_f8);
    FUN_0003a57c(*(int *)(param_2 + 0x10),*(int *)(param_2 + 0x10) + iVar12 * 4,param_1[1]);
    if ((param_1[0x2b] != 0) && (param_1[0x1c] != 0)) {
      FUN_0005dde8(param_1 + 4,param_2);
    }
    piVar13 = param_1 + 0x32;
    if (param_1[0x36] != 0) {
      FUN_000504bc(piVar13,param_1[0x33]);
      param_1[0x34] = (int)piVar13;
      param_1[0x33] = 0;
      param_1[0x35] = (int)piVar13;
      param_1[0x36] = 0;
    }
    FUN_0004ff2e(auStack_a4);
    puVar14 = *(undefined4 **)(param_2 + 0x2c);
    iVar12 = DAT_000538bc + 0x5360c;
    while (puVar14 != (undefined4 *)(*(int *)(param_2 + 0x2c) + *(int *)(param_2 + 0x30) * 4)) {
      FUN_00065168(auStack_d8,*puVar14);
      puVar14 = puVar14 + 1;
      local_a8 = local_a8 | 2;
      if (local_cc == pvVar15) {
        pvVar1 = operator_new(0x18);
        FUN_0004ff2e();
        local_cc = pvVar1;
      }
      FUN_00036a48(auStack_a4,local_cc);
      iVar2 = local_90;
      iVar16 = local_94 - local_90;
      FUN_0004ecb0(local_90,iVar16,param_3,param_4,0x12,3);
      for (iVar6 = 0; iVar6 != iVar16; iVar6 = iVar6 + 1) {
        if ((byte)(*(byte *)(iVar2 + iVar6) - 1) < 0xfe) {
          *(byte *)(iVar2 + iVar6) = ~*(byte *)(iVar2 + iVar6);
        }
      }
      iVar2 = FUN_00077530(*param_1,iVar2,iVar6,iVar12,0);
      if ((iVar2 != 0) ||
         (puVar3 = (undefined4 *)FUN_00076428(*param_1,0,0,0,0,0), puVar3 != (undefined4 *)0x0)) {
        FUN_00063048(auStack_d8);
        FUN_000334d4(auStack_a4);
        goto LAB_00053892;
      }
      FUN_0004ff2e(auStack_8c);
      local_a8 = local_a8 | 1;
      local_74 = puVar3;
      local_70 = puVar3;
      local_6c = puVar3;
      local_68 = puVar3;
      local_64 = puVar3;
      local_60 = puVar3;
      if (local_d0 == pvVar15) {
        pvVar1 = operator_new(0x18);
        FUN_0004ff2e();
        local_d0 = pvVar1;
      }
      FUN_00036a48(auStack_8c,local_d0);
      puVar3 = local_c8;
      while (puVar11 = local_bc, puVar3 != local_c8 + local_c4) {
        local_f4 = *puVar3;
        puVar3 = puVar3 + 1;
        if (local_70 == local_6c) {
          FUN_0003c774(&local_74,local_70,&local_f4,auStack_100,1,1);
        }
        else {
          *local_70 = local_f4;
          local_70 = local_70 + 1;
        }
      }
      while (puVar11 != local_bc + local_b8) {
        FUN_00064cec(auStack_f0,*puVar11);
        local_dc = local_dc | 1;
        if (local_e8 == pvVar15) {
          pvVar1 = operator_new(0x18);
          FUN_0004ff2e();
          local_e8 = pvVar1;
        }
        pvVar1 = local_e8;
        local_dc = local_dc | 2;
        if (local_e4 == pvVar15) {
          pvVar4 = operator_new(0x18);
          FUN_0004ff2e();
          local_e4 = pvVar4;
        }
        pvVar4 = local_e4;
        FUN_000354f4(auStack_5c,pvVar1);
        FUN_000354f4(auStack_44,pvVar4);
        if (local_64 == local_60) {
          FUN_000534d0(&local_68,local_64,auStack_5c,auStack_fc,1,1);
        }
        else {
          if (local_64 != (undefined4 *)0x0) {
            FUN_000516a0(local_64,auStack_5c);
          }
          local_64 = local_64 + 0xc;
        }
        FUN_000334d4(auStack_44);
        FUN_000334d4(auStack_5c);
        FUN_00061f78(auStack_f0);
        puVar11 = puVar11 + 1;
      }
      piVar5 = (int *)FUN_00050904(piVar13,auStack_8c);
      if (piVar5 == param_1 + 0x32) {
        iVar2 = FUN_00052d48(piVar5,auStack_8c);
        FUN_00036a48(iVar2,auStack_8c);
        FUN_0003bdb0(iVar2 + 0x18,&local_74);
        FUN_00051a44(iVar2 + 0x24,&local_68);
      }
      FUN_0004fa76(auStack_8c);
      FUN_00063048(auStack_d8);
    }
    FUN_000334d4(auStack_a4);
    if (iVar10 == 0) {
LAB_00053892:
      uVar9 = 0x68;
      goto LAB_0005389c;
    }
    __n = *(int *)(iVar10 + 0x10) - *(int *)(iVar10 + 0x14);
    pvVar15 = operator_new__(__n);
    if (pvVar15 != (void *)0x0) {
      memcpy(pvVar15,*(void **)(iVar10 + 0x14),__n);
      FUN_0004ecb0(pvVar15,__n,param_3,param_4,0x12,3);
      for (uVar7 = 0; uVar7 != __n; uVar7 = uVar7 + 1) {
        if ((byte)(*(byte *)((int)pvVar15 + uVar7) - 1) < 0xfe) {
          *(byte *)((int)pvVar15 + uVar7) = ~*(byte *)((int)pvVar15 + uVar7);
        }
      }
      iVar10 = FUN_00077530(*param_1,pvVar15,uVar7,DAT_000538c0 + 0x5387e,0);
      if (iVar10 == 0) {
        uVar9 = 0;
      }
      else {
        uVar9 = 0x68;
      }
      operator_delete(pvVar15);
      goto LAB_0005389c;
    }
  }
  uVar9 = 0x67;
LAB_0005389c:
  if (local_2c != *piVar8) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar9);
  }
  return;
}



/* ============================================================ */
/* Target 0x538c4 */
/* Ghidra name: FUN_000538c4 */
/* Entry: 000538c4 */

void FUN_000538c4(int *param_1,undefined4 param_2,int param_3,undefined4 param_4,int param_5,
                 undefined4 param_6,undefined4 param_7,undefined4 param_8)

{
  bool bVar1;
  int iVar2;
  time_t tVar3;
  int iVar4;
  undefined4 *puVar5;
  int *piVar6;
  undefined8 uVar7;
  undefined1 auStack_9c [4];
  pthread_t pStack_98;
  undefined1 *local_94;
  undefined4 local_90;
  undefined1 *local_8c;
  undefined1 *local_88;
  undefined1 auStack_84 [8];
  int *local_7c;
  int *local_78;
  undefined1 auStack_74 [4];
  undefined4 local_70;
  undefined4 local_6c;
  int local_64;
  undefined1 auStack_5c [4];
  undefined4 local_58;
  undefined1 *local_54;
  undefined1 *local_50;
  int local_4c;
  undefined1 auStack_44 [20];
  undefined4 local_30;
  int local_2c;
  
  piVar6 = *(int **)(DAT_00053b84 + 0x538d8);
  local_2c = *piVar6;
  FUN_0004eb80(auStack_74);
  local_64 = 0;
  FUN_0004eb80(auStack_5c);
  local_4c = 0;
  FUN_000527f0(param_1,auStack_74);
  if (*param_1 == 0) {
    iVar2 = 0x65;
  }
  else {
    *(int **)(*param_1 + 0x38) = param_1;
    iVar2 = FUN_00053548(param_1,param_2,param_7,param_8);
    if (iVar2 == 0) {
      FUN_0004ee9c();
      puVar5 = (undefined4 *)(DAT_00053b88 + 0x54648);
      do {
        ExclusiveAccess(puVar5);
        bVar1 = (bool)hasExclusiveAccess(puVar5);
      } while (!bVar1);
      *puVar5 = 0;
      iVar2 = DAT_00053b8c;
      DataMemoryBarrier(0x1f);
      param_1[0x38] = param_3;
      FUN_00102480(param_1 + 0x23,param_3,**(undefined4 **)(iVar2 + 0x53954));
      FUN_0005e7d8(param_1 + 0x3e,param_4);
      FUN_0004fc72(auStack_44,param_4);
      FUN_00042320(auStack_44,DAT_00053b90 + 0x5397a);
      FUN_0005e7d8(param_1 + 0x4c,local_30);
      FUN_0006db80();
      uVar7 = FUN_0007112e();
      *(undefined8 *)(param_1 + 0x10c) = uVar7;
      tVar3 = time((time_t *)0x0);
      param_1[0x109] = tVar3;
      iVar2 = FUN_0004f7f0(param_1);
      param_1[0x10a] = param_5;
      param_1[0x10b] = iVar2;
      if (param_5 != 0) {
        pthread_create(&pStack_98,(pthread_attr_t *)0x0,(__start_routine *)(DAT_00053b94 + 0x539be),
                       param_1);
      }
      chdir((char *)param_1[0x22]);
      iVar4 = FUN_00076428(*param_1,0,0,0,0,0);
      if (iVar4 == 0) {
        if ((param_1[0x2b] == 0) || (param_1[0x1c] == 0)) {
          FUN_00078660(*param_1,DAT_00053bb0 + 0x53b76,3,0);
        }
        else {
          FUN_0005e1e0(param_1 + 4,*param_1);
        }
        FUN_00075fc6(*param_1,DAT_00053b98 + 0x53a02);
        iVar2 = FUN_00075a50(*param_1,0xffffffff);
        FUN_00075972(*param_1,0xfffffffe);
        if (iVar2 == 5) {
          FUN_000d559c(*param_1,DAT_00053b9c + 0x53a26);
          FUN_00075972(*param_1,0xfffffffe);
          iVar2 = FUN_0007754c(*param_1,DAT_00053ba0 + 0x53a3a);
          if (iVar2 == 0) {
            FUN_00076428(*param_1,0,0xffffffff,0,0,0);
          }
        }
        FUN_000527f0(param_1,auStack_5c);
        local_7c = param_1 + 0x2c;
        local_88 = local_54;
        local_90 = local_6c;
        local_94 = auStack_74;
        local_8c = auStack_5c;
        local_78 = local_7c;
        FUN_00052a32(auStack_84,&local_88,&local_8c,&local_90,&local_94,&local_7c,auStack_9c);
        FUN_00075fc6(*param_1,DAT_00053ba4 + 0x53a8e);
        iVar4 = FUN_00076428(*param_1,0,0,0,0,0);
        FUN_0004ee9c(0);
        FUN_00051b8c(*param_1);
        if ((param_1[0x2b] != 0) && (param_1[0x1c] != 0)) {
          FUN_0005e2ec(param_1 + 4,*param_1);
        }
      }
      if (((param_5 == 0) || (iVar2 = 0x6a, -1 < param_1[0x10a])) && (iVar2 = 0, iVar4 != 0)) {
        do {
          iVar2 = FUN_00075964(*param_1);
          if (iVar2 == 0) break;
          iVar2 = FUN_00075cf8(*param_1,0xffffffff,0);
          FUN_00075972(*param_1,0xfffffffe);
        } while ((iVar2 == 0) || (iVar2 = FUN_0005176c(param_1,iVar4,iVar2), -1 < iVar2));
        iVar2 = 0x69;
      }
      if (param_1[0x2a] != 0) {
        FUN_0005e5e0(param_1 + 0x4c);
        thunk_FUN_00039bfc(*param_1);
      }
      FUN_00051478(param_1,DAT_00053ba8 + 0x53b2c,DAT_00053bac + 0x53b2e);
      FUN_000334d4(auStack_44);
    }
  }
  if (local_4c != 0) {
    FUN_00050492(auStack_5c,local_58);
    local_58 = 0;
    local_4c = 0;
    local_54 = auStack_5c;
    local_50 = auStack_5c;
  }
  if (local_64 != 0) {
    FUN_00050492(auStack_74,local_70);
  }
  if (local_2c != *piVar6) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(iVar2);
  }
  return;
}



/* ============================================================ */
/* Target 0x53c18 */
/* Ghidra name: FUN_00053c18 */
/* Entry: 00053c18 */

void FUN_00053c18(undefined4 param_1,char *param_2,undefined4 param_3,undefined4 param_4,
                 undefined4 param_5)

{
  int iVar1;
  undefined4 uVar2;
  int *piVar3;
  undefined1 auStack_13c [76];
  int local_f0 [2];
  undefined1 auStack_e8 [32];
  _Filebuf_base a_Stack_c8 [100];
  uint local_64;
  int local_1c;
  
  piVar3 = *(int **)(DAT_00053cc0 + 0x53c2a);
  local_1c = *piVar3;
  FUN_00062154(auStack_13c);
  FUN_000507b4(local_f0);
  iVar1 = std::_Filebuf_base::_M_open(a_Stack_c8,param_2,0xc);
  if (iVar1 == 0) {
    FUN_0003c0aa((int)local_f0 + *(int *)(local_f0[0] + -0xc),4);
  }
  if ((local_64 & 5) == 0) {
    FUN_0012e544(auStack_13c,local_f0);
    iVar1 = FUN_0004fb0c(auStack_e8);
    if (iVar1 == 0) {
      FUN_0003c0aa((int)local_f0 + *(int *)(local_f0[0] + -0xc),4);
    }
    uVar2 = FUN_000538c4(param_1,auStack_13c,param_3,param_4,param_5);
  }
  else {
    uVar2 = 0x66;
  }
  FUN_0004fc14(local_f0);
  FUN_000630b8(auStack_13c);
  if (local_1c != *piVar3) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar2);
  }
  return;
}



