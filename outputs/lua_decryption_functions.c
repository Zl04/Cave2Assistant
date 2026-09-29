/* Named Ghidra decompilation: libcocos2dlua.so */
/* Matches: 3 */

/* ============================================================ */
/* setXXTEAKeyAndSign @ 009a88a4 */

/* cocos2d::LuaStack::setXXTEAKeyAndSign(char const*, int, char const*, int) */

void __thiscall
cocos2d::LuaStack::setXXTEAKeyAndSign
          (LuaStack *this,char *param_1,int param_2,char *param_3,int param_4)

{
  LuaStack LVar1;
  
                    /* try { // try from 009a88ac to 00aa88af has its CatchHandler @ 009a8b0c */
                    /* try { // try from 009a88b8 to 00aa88bb has its CatchHandler @ 009a8a88 */
                    /* try { // try from 009a88c0 to 00aa88c3 has its CatchHandler @ 009a8abc */
  (**(code **)(*(long *)this + 0xf0))();
                    /* try { // try from 009a88e0 to 00aa890b has its CatchHandler @ 009a8a18 */
  LVar1 = (LuaStack)(param_1 != (char *)0x0 && param_2 != 0);
  if (param_1 != (char *)0x0 && param_2 != 0) {
    LVar1 = (LuaStack)(param_3 != (char *)0x0 && param_4 != 0);
  }
  this[0x34] = LVar1;
  return;
}



/* ============================================================ */
/* cleanupXXTEAKeyAndSign @ 009a8fe4 */

/* cocos2d::LuaStack::cleanupXXTEAKeyAndSign() */

void __thiscall cocos2d::LuaStack::cleanupXXTEAKeyAndSign(LuaStack *this)

{
  if (*(long *)(this + 0x38) != 0) {
    free();
    *(undefined8 *)(this + 0x38) = 0;
    *(undefined4 *)(this + 0x40) = 0;
  }
  if (*(long *)(this + 0x48) != 0) {
    free();
    *(undefined8 *)(this + 0x48) = 0;
    *(undefined4 *)(this + 0x50) = 0;
  }
                    /* try { // try from 009a9020 to 00aa9023 has its CatchHandler @ 009a914c */
  return;
}



/* ============================================================ */
/* luaLoadBuffer @ 009aa30c */

/* cocos2d::LuaStack::luaLoadBuffer(lua_State*, char const*, int, char const*) */

void __thiscall
cocos2d::LuaStack::luaLoadBuffer
          (LuaStack *this,lua_State *param_1,char *param_2,int param_3,char *param_4)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  undefined4 uVar5;
  long *plVar6;
  undefined8 uVar7;
  char *pcVar8;
  char *pcVar9;
  uint uVar10;
  code *pcVar11;
  long lVar12;
  int *piVar13;
  int local_44;
  undefined1 auStack_38 [8];
  undefined1 auStack_30 [8];
  long local_28;
  long local_20;
  long local_18;
  uint local_10;
  undefined4 uStack_c;
  long local_8;
  
                    /* catch() { ... } // from try @ 009aa358 with catch @ 009aa31c
                       catch() { ... } // from try @ 009aa3f8 with catch @ 009aa31c */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* try { // try from 009aa358 to 00aaa35b has its CatchHandler @ 009aa31c */
  if ((((*(long *)(this + 0x38) == 0) || (*(int *)(this + 0x40) == 0)) ||
      (*(long *)(this + 0x48) == 0)) || (*(int *)(this + 0x50) == 0)) {
    plVar6 = (long *)FileUtils::getInstance();
                    /* try { // try from 009aa36c to 00aaa36f has its CatchHandler @ 009aa3d0 */
    pcVar11 = *(code **)(*plVar6 + 0x1e0);
    FUN_01211570(&local_18,"caveOnline2018",auStack_30);
    (*pcVar11)(&local_10,plVar6,&local_18);
    FUN_01211570(&local_28,CONCAT44(uStack_c,local_10),&local_20);
    lVar12 = CONCAT44(uStack_c,local_10);
    if ((undefined *)(lVar12 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 009aa5e8 to 00aaa5eb has its CatchHandler @ 009aa544 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(lVar12 + -8);
        *(int *)(lVar12 + -8) = iVar3 + -1;
      }
      else {
        piVar13 = (int *)(lVar12 + -8);
        do {
                    /* catch() { ... } // from try @ 009aa660 with catch @ 009aa5f4
                       catch() { ... } // from try @ 009aa6e0 with catch @ 009aa5f4
                       catch() { ... } // from try @ 009aa6ec with catch @ 009aa5f4 */
          iVar3 = *piVar13;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar13,0x10);
          if (bVar2) {
            *piVar13 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
        operator_delete((undefined *)(lVar12 + -0x18));
      }
    }
                    /* catch() { ... } // from try @ 009aa36c with catch @ 009aa3d0 */
    if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_18 + -8);
        *(int *)(local_18 + -8) = iVar3 + -1;
      }
      else {
        piVar13 = (int *)(local_18 + -8);
        do {
          iVar3 = *piVar13;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar13,0x10);
          if (bVar2) {
            *piVar13 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
        operator_delete((undefined *)(local_18 + -0x18));
      }
    }
    iVar3 = strlen(local_28);
                    /* try { // try from 009aa3f8 to 00aaa3fb has its CatchHandler @ 009aa31c */
    pcVar11 = *(code **)(*plVar6 + 0x1e0);
    FUN_01211570(&local_18,"avalondevs",auStack_38);
    (*pcVar11)(&local_10,plVar6,&local_18);
    FUN_01211570(&local_20,CONCAT44(uStack_c,local_10),auStack_30);
    lVar12 = CONCAT44(uStack_c,local_10);
    if ((undefined *)(lVar12 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(lVar12 + -8);
                    /* catch() { ... } // from try @ 009aa744 with catch @ 009aa754 */
        *(int *)(lVar12 + -8) = iVar4 + -1;
      }
      else {
        piVar13 = (int *)(lVar12 + -8);
        do {
          iVar4 = *piVar13;
                    /* try { // try from 009aa660 to 00aaa663 has its CatchHandler @ 009aa5f4 */
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar13,0x10);
          if (bVar2) {
            *piVar13 = iVar4 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete((undefined *)(lVar12 + -0x18));
                    /* try { // try from 009aa67c to 00aaa67f has its CatchHandler @ 009aa6a0 */
      }
    }
    if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 009aa688 to 00aaa68b has its CatchHandler @ 009aa6d0 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_18 + -8);
                    /* try { // try from 009aa780 to 00aaa783 has its CatchHandler @ 009aa70c */
        *(int *)(local_18 + -8) = iVar4 + -1;
      }
      else {
        piVar13 = (int *)(local_18 + -8);
        do {
          iVar4 = *piVar13;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar13,0x10);
          if (bVar2) {
            *piVar13 = iVar4 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
                    /* catch() { ... } // from try @ 009aa67c with catch @ 009aa6a0 */
      if (iVar4 < 1) {
        operator_delete((undefined *)(local_18 + -0x18));
      }
    }
                    /* catch() { ... } // from try @ 009aa498 with catch @ 009aa460
                       catch() { ... } // from try @ 009aa53c with catch @ 009aa460 */
    iVar4 = strlen(local_20);
    uVar7 = malloc((long)iVar3);
    lVar12 = local_28;
    *(undefined8 *)(this + 0x38) = uVar7;
    memcpy(uVar7,local_28,(long)iVar3);
    *(int *)(this + 0x40) = iVar3;
                    /* try { // try from 009aa498 to 00aaa49b has its CatchHandler @ 009aa460 */
    uVar7 = malloc((long)iVar4);
    *(undefined8 *)(this + 0x48) = uVar7;
    memcpy(uVar7,local_20,(long)iVar4);
    *(int *)(this + 0x50) = iVar4;
                    /* try { // try from 009aa4b8 to 00aaa4bb has its CatchHandler @ 009aa50c */
    if ((undefined *)(local_20 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_20 + -8);
        *(int *)(local_20 + -8) = iVar3 + -1;
      }
      else {
        piVar13 = (int *)(local_20 + -8);
        do {
          iVar3 = *piVar13;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar13,0x10);
          if (bVar2) {
            *piVar13 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
                    /* catch() { ... } // from try @ 009aa688 with catch @ 009aa6d0 */
        } while (cVar1 != '\0');
      }
      lVar12 = local_28;
      if (iVar3 < 1) {
                    /* try { // try from 009aa73c to 00aaa73f has its CatchHandler @ 009aa70c */
        operator_delete((undefined *)(local_20 + -0x18));
        lVar12 = local_28;
                    /* try { // try from 009aa744 to 00aaa747 has its CatchHandler @ 009aa754 */
      }
    }
    if ((undefined *)(lVar12 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 009aa6ec to 00aaa6ef has its CatchHandler @ 009aa5f4 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* catch() { ... } // from try @ 009aa7c8 with catch @ 009aa78c
                       catch() { ... } // from try @ 009aa848 with catch @ 009aa78c */
        iVar3 = *(int *)(lVar12 + -8);
        *(int *)(lVar12 + -8) = iVar3 + -1;
      }
      else {
        piVar13 = (int *)(lVar12 + -8);
        do {
          iVar3 = *piVar13;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar13,0x10);
          if (bVar2) {
            *piVar13 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
                    /* catch() { ... } // from try @ 009aa73c with catch @ 009aa70c
                       catch() { ... } // from try @ 009aa780 with catch @ 009aa70c */
        operator_delete((undefined *)(lVar12 + -0x18));
      }
    }
  }
  if (this[0x34] != (LuaStack)0x0) {
    iVar3 = *(int *)(this + 0x50);
    iVar4 = strncmp(param_2,*(undefined8 *)(this + 0x48),(long)iVar3);
    if (iVar4 == 0) {
                    /* try { // try from 009aa59c to 00aaa59f has its CatchHandler @ 009aa5b0 */
      local_10 = 0;
      pcVar8 = (char *)xxtea_decrypt((uchar *)(param_2 + iVar3),param_3 - iVar3,
                                     *(uchar **)(this + 0x38),*(uint *)(this + 0x40),&local_10);
                    /* catch() { ... } // from try @ 009aa59c with catch @ 009aa5b0 */
      pcVar9 = pcVar8;
      uVar10 = local_10;
      if (((*pcVar8 == -0x11) && (pcVar8[1] == -0x45)) && (pcVar8[2] == -0x41)) {
        pcVar9 = pcVar8 + 3;
        uVar10 = local_10 - 3;
      }
      uVar5 = luaL_loadbuffer(param_1,pcVar9,uVar10,param_4);
      free(pcVar8);
      goto LAB_009aa518;
    }
  }
  local_44 = param_3;
  if (((*param_2 == -0x11) && (param_2[1] == -0x45)) && (param_2[2] == -0x41)) {
    param_2 = param_2 + 3;
    local_44 = param_3 + -3;
                    /* try { // try from 009aa584 to 00aaa587 has its CatchHandler @ 009aa544 */
  }
                    /* catch() { ... } // from try @ 009aa4b8 with catch @ 009aa50c */
  uVar5 = luaL_loadbuffer(param_1,param_2,(long)local_44,param_4);
LAB_009aa518:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar5);
  }
                    /* try { // try from 009aa53c to 00aaa53f has its CatchHandler @ 009aa460 */
                    /* catch() { ... } // from try @ 009aa584 with catch @ 009aa544
                       catch() { ... } // from try @ 009aa5e8 with catch @ 009aa544 */
  return;
}



