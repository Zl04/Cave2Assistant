/* Targets: 4, callers: 4 */

/* === executeScriptFile @ 009aa870 === */

/* cocos2d::LuaStack::executeScriptFile(char const*) */

void __thiscall cocos2d::LuaStack::executeScriptFile(LuaStack *this,char *param_1)

{
  bool bVar1;
  char cVar2;
  int iVar3;
  undefined4 uVar4;
  long lVar5;
  undefined *puVar6;
  long *plVar7;
  char *pcVar8;
  int *piVar9;
  lua_State *plVar10;
  long local_48;
  long local_40;
  long local_38;
  long local_30;
  long local_28;
  char *local_20;
  Data aDStack_18 [16];
  long local_8;
  
                    /* catch() { ... } // from try @ 009aa810 with catch @ 009aa870 */
                    /* catch() { ... } // from try @ 009aa7ec with catch @ 009aa894 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FUN_01211570(&local_48,param_1,aDStack_18);
  lVar5 = FUN_01212914(&local_48,DAT_01738aa8,0xffffffffffffffff,
                       *(undefined8 *)(DAT_01738aa8 + -0x18));
                    /* catch() { ... } // from try @ 009aa910 with catch @ 009aa8d4
                       catch() { ... } // from try @ 009aa95c with catch @ 009aa8d4 */
  if (lVar5 == -1) {
                    /* try { // try from 009aaabc to 00aaaabf has its CatchHandler @ 009aab00 */
    lVar5 = FUN_01212914(&local_48,DAT_01738ab0,0xffffffffffffffff,
                         *(undefined8 *)(DAT_01738ab0 + -0x18));
                    /* catch() { ... } // from try @ 009aaab0 with catch @ 009aaadc */
    if (*(long *)(local_48 + -0x18) - *(long *)(DAT_01738ab0 + -0x18) == lVar5) {
      FUN_0121113c(&local_38,&local_48,0);
                    /* catch() { ... } // from try @ 009aaabc with catch @ 009aab00 */
      FUN_0121258c(&local_48,&local_38);
                    /* try { // try from 009aab10 to 00aaab13 has its CatchHandler @ 009aaa60 */
      puVar6 = (undefined *)(local_38 + -0x18);
      if (puVar6 != PTR_DAT_017191c0) {
                    /* try { // try from 009aab1c to 00aaab1f has its CatchHandler @ 009aaa60 */
        local_40 = local_38;
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) goto LAB_009aacb8;
        piVar9 = (int *)(local_38 + -8);
        do {
          iVar3 = *piVar9;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
          if (bVar1) {
            *piVar9 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
        goto LAB_009aab3c;
      }
    }
  }
  else {
    FUN_0121113c(&local_40,&local_48,0);
    FUN_0121258c(&local_48,&local_40);
    puVar6 = (undefined *)(local_40 + -0x18);
                    /* try { // try from 009aa910 to 00aaa913 has its CatchHandler @ 009aa8d4 */
    if (puVar6 != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 009aabe8 with catch @ 009aabbc
                       catch() { ... } // from try @ 009aac3c with catch @ 009aabbc */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
LAB_009aacb8:
        iVar3 = *(int *)(local_40 + -8);
        *(int *)(local_40 + -8) = iVar3 + -1;
      }
      else {
        piVar9 = (int *)(local_40 + -8);
        do {
          iVar3 = *piVar9;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
          if (bVar1) {
            *piVar9 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
LAB_009aab3c:
      if (iVar3 < 1) {
        operator_delete(puVar6);
      }
    }
  }
  plVar7 = (long *)FileUtils::getInstance();
                    /* try { // try from 009aa91c to 00aaa91f has its CatchHandler @ 009aa930 */
  FUN_01214ee0(&local_30,&local_48);
                    /* catch() { ... } // from try @ 009aa91c with catch @ 009aa930 */
  FUN_01211fcc(&local_30,&DAT_01738aa8);
  cVar2 = (**(code **)(*plVar7 + 0x128))(plVar7,&local_30);
  if (cVar2 == '\0') {
                    /* try { // try from 009aa95c to 00aaa95f has its CatchHandler @ 009aa8d4 */
    FUN_01214ee0(&local_28,&local_48);
    FUN_01211fcc(&local_28,&DAT_01738ab0);
    FUN_0121258c(&local_30,&local_28);
    if ((undefined *)(local_28 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_28 + -8);
                    /* try { // try from 009aac7c to 00aaac7f has its CatchHandler @ 009aac48 */
        *(int *)(local_28 + -8) = iVar3 + -1;
      }
      else {
                    /* try { // try from 009aabe8 to 00aaabeb has its CatchHandler @ 009aabbc */
        piVar9 = (int *)(local_28 + -8);
        do {
          iVar3 = *piVar9;
                    /* try { // try from 009aabf0 to 00aaabf3 has its CatchHandler @ 009aac00 */
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
          if (bVar1) {
            *piVar9 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
                    /* catch() { ... } // from try @ 009aabf0 with catch @ 009aac00 */
      if (iVar3 < 1) {
        operator_delete((undefined *)(local_28 + -0x18));
      }
    }
    cVar2 = (**(code **)(*plVar7 + 0x128))(plVar7,&local_30);
    if (cVar2 != '\0') goto LAB_009aaaa4;
  }
  else {
LAB_009aaaa4:
                    /* try { // try from 009aaaa8 to 00aaaaab has its CatchHandler @ 009aaa60 */
    FUN_01215060(&local_48,&local_30);
                    /* try { // try from 009aaab0 to 00aaaab3 has its CatchHandler @ 009aaadc */
  }
  (**(code **)(*plVar7 + 0x50))(&local_20,plVar7,&local_48);
  (**(code **)(*plVar7 + 0x28))(aDStack_18,plVar7,&local_20);
  cVar2 = Data::isNull(aDStack_18);
  if (cVar2 == '\0') {
    plVar10 = *(lua_State **)(this + 0x28);
    pcVar8 = (char *)Data::getBytes(aDStack_18);
    iVar3 = Data::getSize(aDStack_18);
    iVar3 = luaLoadBuffer(this,plVar10,pcVar8,iVar3,local_20);
    if (iVar3 != 0) goto LAB_009aaa28;
    uVar4 = (**(code **)(*(long *)this + 0xc0))(this,0);
    Data::~Data(aDStack_18);
    pcVar8 = local_20 + -0x18;
    if (pcVar8 == PTR_DAT_017191c0) goto LAB_009aaa48;
  }
  else {
LAB_009aaa28:
    uVar4 = 0;
    Data::~Data(aDStack_18);
    pcVar8 = local_20 + -0x18;
    if (pcVar8 == PTR_DAT_017191c0) goto LAB_009aaa48;
  }
  if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* catch() { ... } // from try @ 009aac88 with catch @ 009aac98 */
    iVar3 = *(int *)(local_20 + -8);
    *(int *)(local_20 + -8) = iVar3 + -1;
  }
  else {
    piVar9 = (int *)(local_20 + -8);
    do {
      iVar3 = *piVar9;
      cVar2 = '\x01';
      bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
      if (bVar1) {
        *piVar9 = iVar3 + -1;
        cVar2 = ExclusiveMonitorsStatus();
      }
    } while (cVar2 != '\0');
  }
  if (iVar3 < 1) {
    operator_delete(pcVar8);
  }
LAB_009aaa48:
  if ((undefined *)(local_30 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 009aac7c with catch @ 009aac48
                       catch() { ... } // from try @ 009aacd4 with catch @ 009aac48 */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 009aac88 to 00aaac8b has its CatchHandler @ 009aac98 */
      iVar3 = *(int *)(local_30 + -8);
      *(int *)(local_30 + -8) = iVar3 + -1;
    }
    else {
      piVar9 = (int *)(local_30 + -8);
      do {
        iVar3 = *piVar9;
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
        if (bVar1) {
          *piVar9 = iVar3 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_30 + -0x18));
    }
  }
                    /* catch() { ... } // from try @ 009aaaa8 with catch @ 009aaa60
                       catch() { ... } // from try @ 009aab10 with catch @ 009aaa60
                       catch() { ... } // from try @ 009aab1c with catch @ 009aaa60 */
  if ((undefined *)(local_48 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_48 + -8);
      *(int *)(local_48 + -8) = iVar3 + -1;
    }
    else {
      piVar9 = (int *)(local_48 + -8);
      do {
        iVar3 = *piVar9;
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
        if (bVar1) {
          *piVar9 = iVar3 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (iVar3 < 1) {
                    /* try { // try from 009aac3c to 00aaac3f has its CatchHandler @ 009aabbc */
      operator_delete((undefined *)(local_48 + -0x18));
    }
  }
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar4);
  }
  return;
}


/* === luaLoadChunksFromZIP @ 009aadd8 === */

/* cocos2d::LuaStack::luaLoadChunksFromZIP(lua_State*) */

void __thiscall cocos2d::LuaStack::luaLoadChunksFromZIP(LuaStack *this,lua_State *param_1)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  long *plVar5;
  undefined8 uVar6;
  undefined *puVar7;
  void *pvVar8;
  ulong uVar9;
  ZipFile *this_00;
  char *pcVar10;
  int *piVar11;
  long lVar12;
  char *pcVar13;
  long lVar14;
  code *pcVar15;
  void *local_90;
  undefined1 auStack_48 [8];
  long local_40;
  char *local_38;
  long local_30;
  long local_28;
  uint local_20;
  undefined4 uStack_1c;
  long local_18 [2];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* try { // try from 009ab34c to 00aab34f has its CatchHandler @ 009ab28c */
  if ((((*(long *)(this + 0x38) == 0) || (*(int *)(this + 0x40) == 0)) ||
      (*(long *)(this + 0x48) == 0)) || (*(int *)(this + 0x50) == 0)) {
    plVar5 = (long *)FileUtils::getInstance();
                    /* catch() { ... } // from try @ 009aad14 with catch @ 009aae2c */
                    /* try { // try from 009aae34 to 00aaae37 has its CatchHandler @ 009aacd8 */
                    /* catch() { ... } // from try @ 009aadb4 with catch @ 009aae38 */
    pcVar15 = *(code **)(*plVar5 + 0x1e0);
    FUN_01211570(&local_20,"caveOnline2018",&local_38);
    (*pcVar15)(local_18,plVar5,&local_20);
                    /* catch() { ... } // from try @ 009aada8 with catch @ 009aae6c */
    FUN_01211570(&local_30,local_18[0],&local_28);
    if ((undefined *)(local_18[0] + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 009ab564 with catch @ 009ab578 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_18[0] + -8);
        *(int *)(local_18[0] + -8) = iVar3 + -1;
      }
      else {
        piVar11 = (int *)(local_18[0] + -8);
        do {
          iVar3 = *piVar11;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar2) {
            *piVar11 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
        operator_delete((undefined *)(local_18[0] + -0x18));
      }
    }
    lVar14 = CONCAT44(uStack_1c,local_20);
    if ((undefined *)(lVar14 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(lVar14 + -8);
        *(int *)(lVar14 + -8) = iVar3 + -1;
      }
      else {
        piVar11 = (int *)(lVar14 + -8);
        do {
          iVar3 = *piVar11;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar2) {
            *piVar11 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
                    /* try { // try from 009ab5c4 to 00aab5c7 has its CatchHandler @ 009ab510 */
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
        operator_delete((undefined *)(lVar14 + -0x18));
      }
    }
    iVar3 = strlen(local_30);
    pcVar15 = *(code **)(*plVar5 + 0x1e0);
    FUN_01211570(&local_20,"avalondevs",&local_40);
    (*pcVar15)(local_18,plVar5,&local_20);
                    /* catch() { ... } // from try @ 009aad88 with catch @ 009aaeec */
    FUN_01211570(&local_28,local_18[0],&local_38);
                    /* catch() { ... } // from try @ 009aad64 with catch @ 009aaef4 */
                    /* catch() { ... } // from try @ 009ab05c with catch @ 009aaf00 */
    if ((undefined *)(local_18[0] + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_18[0] + -8);
        *(int *)(local_18[0] + -8) = iVar4 + -1;
      }
      else {
        piVar11 = (int *)(local_18[0] + -8);
        do {
          iVar4 = *piVar11;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar2) {
            *piVar11 = iVar4 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete((undefined *)(local_18[0] + -0x18));
      }
    }
    lVar14 = CONCAT44(uStack_1c,local_20);
    if ((undefined *)(lVar14 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(lVar14 + -8);
        *(int *)(lVar14 + -8) = iVar4 + -1;
      }
      else {
        piVar11 = (int *)(lVar14 + -8);
        do {
          iVar4 = *piVar11;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar2) {
            *piVar11 = iVar4 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete((undefined *)(lVar14 + -0x18));
      }
    }
    lVar12 = local_28;
    iVar4 = strlen(local_28);
    uVar6 = malloc((long)iVar3);
    lVar14 = local_30;
                    /* try { // try from 009aaf3c to 00aaaf3f has its CatchHandler @ 009ab054 */
    *(undefined8 *)(this + 0x38) = uVar6;
    memcpy(uVar6,local_30,(long)iVar3);
    *(int *)(this + 0x40) = iVar3;
    uVar6 = malloc((long)iVar4);
    *(undefined8 *)(this + 0x48) = uVar6;
    memcpy(uVar6,lVar12,(long)iVar4);
    *(int *)(this + 0x50) = iVar4;
    if ((undefined *)(lVar12 + -0x18) == PTR_DAT_017191c0) {
      puVar7 = (undefined *)(lVar14 + -0x18);
                    /* try { // try from 009aaf8c to 00aaaf8f has its CatchHandler @ 009ab11c */
      if (puVar7 != PTR_DAT_017191c0) {
LAB_009ab680:
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar3 = *(int *)(lVar14 + -8);
          *(int *)(lVar14 + -8) = iVar3 + -1;
        }
        else {
          piVar11 = (int *)(lVar14 + -8);
          do {
            iVar3 = *piVar11;
            cVar1 = '\x01';
            bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
            if (bVar2) {
              *piVar11 = iVar3 + -1;
              cVar1 = ExclusiveMonitorsStatus();
            }
          } while (cVar1 != '\0');
        }
        if (iVar3 < 1) {
          operator_delete(puVar7);
        }
      }
    }
    else {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(lVar12 + -8);
        *(int *)(lVar12 + -8) = iVar3 + -1;
      }
      else {
        piVar11 = (int *)(lVar12 + -8);
        do {
          iVar3 = *piVar11;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar2) {
            *piVar11 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
        operator_delete((undefined *)(lVar12 + -0x18));
      }
      puVar7 = (undefined *)(local_30 + -0x18);
      lVar14 = local_30;
      if (puVar7 != PTR_DAT_017191c0) goto LAB_009ab680;
    }
    iVar3 = lua_gettop(param_1);
  }
  else {
                    /* catch() { ... } // from try @ 009ab374 with catch @ 009ab358
                       catch() { ... } // from try @ 009ab3a4 with catch @ 009ab358
                       catch() { ... } // from try @ 009ab41c with catch @ 009ab358 */
    iVar3 = lua_gettop(param_1);
  }
  if (iVar3 < 1) {
    uVar6 = 0;
    goto LAB_009ab3b0;
  }
                    /* try { // try from 009aafb0 to 00aaafb3 has its CatchHandler @ 009ab114 */
  uVar6 = lua_tolstring(param_1,0xffffffff,0);
                    /* try { // try from 009aafd0 to 00aaafd3 has its CatchHandler @ 009ab094 */
  lua_settop(param_1,0);
  plVar5 = (long *)FileUtils::getInstance();
                    /* try { // try from 009aafdc to 00aaafdf has its CatchHandler @ 009ab060 */
  pcVar15 = *(code **)(*plVar5 + 0x50);
  FUN_01211570((Data *)local_18,uVar6,(string *)&local_28);
  (*pcVar15)(&local_40,plVar5,(Data *)local_18);
  if ((undefined *)(local_18[0] + -0x18) != PTR_DAT_017191c0) {
    piVar11 = (int *)(local_18[0] + -8);
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_18[0] + -8);
      *(int *)(local_18[0] + -8) = iVar3 + -1;
    }
    else {
      do {
        iVar3 = *piVar11;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
        if (bVar2) {
          *piVar11 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_18[0] + -0x18));
    }
  }
  (**(code **)(*plVar5 + 0x28))((Data *)local_18,plVar5,&local_40);
  pvVar8 = (void *)Data::getBytes((Data *)local_18);
  uVar9 = Data::getSize((Data *)local_18);
                    /* catch() { ... } // from try @ 009aaf3c with catch @ 009ab054 */
                    /* try { // try from 009ab05c to 00aab05f has its CatchHandler @ 009aaf00 */
  if (this[0x34] == (LuaStack)0x0) {
LAB_009ab328:
    if (0 < (long)uVar9) {
                    /* catch() { ... } // from try @ 009ab2e0 with catch @ 009ab330 */
      this_00 = (ZipFile *)ZipFile::createWithBuffer(pvVar8,uVar9);
                    /* try { // try from 009ab340 to 00aab343 has its CatchHandler @ 009ab28c */
      local_90 = (void *)0x0;
      goto LAB_009ab0b8;
    }
                    /* try { // try from 009ab374 to 00aab377 has its CatchHandler @ 009ab358 */
    local_90 = (void *)0x0;
LAB_009ab378:
    lua_pushboolean(param_1,0);
  }
  else {
                    /* catch() { ... } // from try @ 009aafdc with catch @ 009ab060 */
    iVar3 = *(int *)(this + 0x50);
    lVar14 = (long)iVar3;
    if (((long)uVar9 < lVar14) ||
       (iVar4 = memcmp(*(undefined8 *)(this + 0x48),pvVar8,lVar14), iVar4 != 0)) goto LAB_009ab328;
                    /* catch() { ... } // from try @ 009aafd0 with catch @ 009ab094 */
    local_20 = 0;
    local_90 = (void *)xxtea_decrypt((uchar *)((long)pvVar8 + lVar14),(int)uVar9 - iVar3,
                                     *(uchar **)(this + 0x38),*(uint *)(this + 0x40),&local_20);
    this_00 = (ZipFile *)ZipFile::createWithBuffer(local_90,(ulong)local_20);
LAB_009ab0b8:
    if (this_00 == (ZipFile *)0x0) goto LAB_009ab378;
    lua_getfield(param_1,0xffffd8ee,"package");
    lua_getfield(param_1,0xffffffff,"preload");
    ZipFile::getFirstFilename();
    if (*(long *)(local_38 + -0x18) != 0) {
                    /* catch() { ... } // from try @ 009aafb0 with catch @ 009ab114 */
                    /* catch() { ... } // from try @ 009aaf8c with catch @ 009ab11c */
      do {
        local_30 = 0;
        FUN_01211570((string *)&local_28,local_38,auStack_48);
        pcVar10 = (char *)ZipFile::getFileData(this_00,(string *)&local_28,&local_30);
        if ((undefined *)(local_28 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* catch() { ... } // from try @ 009ab530 with catch @ 009ab510
                       catch() { ... } // from try @ 009ab5c4 with catch @ 009ab510 */
            iVar3 = *(int *)(local_28 + -8);
            *(int *)(local_28 + -8) = iVar3 + -1;
          }
          else {
            piVar11 = (int *)(local_28 + -8);
            do {
              iVar3 = *piVar11;
              cVar1 = '\x01';
              bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
              if (bVar2) {
                *piVar11 = iVar3 + -1;
                cVar1 = ExclusiveMonitorsStatus();
              }
            } while (cVar1 != '\0');
          }
          if (iVar3 < 1) {
            operator_delete((undefined *)(local_28 + -0x18));
          }
        }
        if (local_30 != 0) {
          uVar9 = FUN_01212a50(&local_38,0x2e,0xffffffffffffffff);
          if (uVar9 != 0xffffffffffffffff) {
            if (*(ulong *)(local_38 + -0x18) < uVar9) {
                    /* WARNING: Subroutine does not return */
              FUN_0120f508("%s: __pos (which is %zu) > this->size() (which is %zu)",
                           "basic_string::substr",uVar9);
            }
            FUN_0121113c(&local_20,&local_38,uVar9);
            lVar14 = CONCAT44(uStack_1c,local_20);
            puVar7 = (undefined *)(lVar14 + -0x18);
            lVar12 = *(long *)(lVar14 + -0x18);
                    /* catch() { ... } // from try @ 009ab384 with catch @ 009ab40c */
            if (((lVar12 == *(long *)(DAT_01738ab0 + -0x18)) &&
                (iVar3 = memcmp(lVar14,DAT_01738ab0,lVar12), iVar3 == 0)) ||
               ((lVar12 == *(long *)(DAT_01738aa8 + -0x18) &&
                (iVar3 = memcmp(lVar14,DAT_01738aa8,lVar12), iVar3 == 0)))) {
                    /* try { // try from 009ab41c to 00aab443 has its CatchHandler @ 009ab358 */
                    /* catch() { ... } // from try @ 009ab3d0 with catch @ 009ab420 */
              if (*(ulong *)(local_38 + -0x18) < uVar9) {
                    /* try { // try from 009ab8f4 to 00aab8f7 has its CatchHandler @ 009ab854 */
                    /* WARNING: Subroutine does not return */
                FUN_0120f508("%s: __pos (which is %zu) > this->size() (which is %zu)",
                             "basic_string::erase",uVar9);
              }
              FUN_01213670(&local_38,uVar9,*(ulong *)(local_38 + -0x18) - uVar9,0);
              lVar14 = CONCAT44(uStack_1c,local_20);
              puVar7 = (undefined *)(lVar14 + -0x18);
                    /* catch() { ... } // from try @ 009ab3c0 with catch @ 009ab444 */
              if (puVar7 != PTR_DAT_017191c0) goto LAB_009ab44c;
            }
            else if (puVar7 != PTR_DAT_017191c0) {
LAB_009ab44c:
                    /* catch() { ... } // from try @ 009ab3b4 with catch @ 009ab44c */
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 009ab530 to 00aab55b has its CatchHandler @ 009ab510 */
                iVar3 = *(int *)(lVar14 + -8);
                *(int *)(lVar14 + -8) = iVar3 + -1;
              }
              else {
                piVar11 = (int *)(lVar14 + -8);
                do {
                  iVar3 = *piVar11;
                  cVar1 = '\x01';
                  bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
                  if (bVar2) {
                    *piVar11 = iVar3 + -1;
                    cVar1 = ExclusiveMonitorsStatus();
                  }
                } while (cVar1 != '\0');
              }
              if (iVar3 < 1) {
                operator_delete(puVar7);
              }
            }
          }
          pcVar13 = local_38;
          if ((-1 < *(int *)(local_38 + -8)) &&
             (FUN_01213860(&local_38), pcVar13 = local_38, -1 < *(int *)(local_38 + -8))) {
            FUN_01213860(&local_38);
          }
          lVar14 = *(long *)(local_38 + -0x18);
          for (; pcVar13 != local_38 + lVar14; pcVar13 = pcVar13 + 1) {
            while ((*pcVar13 == '\\' || (*pcVar13 == '/'))) {
              *pcVar13 = '.';
              pcVar13 = pcVar13 + 1;
              if (pcVar13 == local_38 + lVar14) goto LAB_009ab250;
            }
          }
LAB_009ab250:
          iVar3 = luaLoadBuffer(this,param_1,pcVar10,(int)local_30,local_38);
          if (iVar3 == 0) {
            lua_setfield(param_1,0xfffffffe,local_38);
          }
          free(pcVar10);
        }
        ZipFile::getNextFilename();
                    /* catch() { ... } // from try @ 009ab2cc with catch @ 009ab28c
                       catch() { ... } // from try @ 009ab340 with catch @ 009ab28c
                       catch() { ... } // from try @ 009ab34c with catch @ 009ab28c */
        FUN_0121258c(&local_38,&local_20);
        lVar14 = CONCAT44(uStack_1c,local_20);
        if ((undefined *)(lVar14 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar3 = *(int *)(lVar14 + -8);
            *(int *)(lVar14 + -8) = iVar3 + -1;
          }
          else {
            piVar11 = (int *)(lVar14 + -8);
            do {
              iVar3 = *piVar11;
              cVar1 = '\x01';
              bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
              if (bVar2) {
                *piVar11 = iVar3 + -1;
                cVar1 = ExclusiveMonitorsStatus();
              }
            } while (cVar1 != '\0');
          }
          if (iVar3 < 1) {
            operator_delete((undefined *)(lVar14 + -0x18));
          }
        }
      } while (*(long *)(local_38 + -0x18) != 0);
    }
    lua_settop(param_1,0xfffffffd);
                    /* try { // try from 009ab2cc to 00aab2cf has its CatchHandler @ 009ab28c */
    lua_pushboolean(param_1,1);
                    /* try { // try from 009ab2d4 to 00aab2d7 has its CatchHandler @ 009ab2fc */
    (**(code **)(*(long *)this_00 + 8))(this_00);
                    /* try { // try from 009ab2e0 to 00aab2e3 has its CatchHandler @ 009ab330 */
    if (local_38 + -0x18 != PTR_DAT_017191c0) {
      piVar11 = (int *)(local_38 + -8);
                    /* catch() { ... } // from try @ 009ab2d4 with catch @ 009ab2fc */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_38 + -8);
        *(int *)(local_38 + -8) = iVar3 + -1;
      }
      else {
        do {
          iVar3 = *piVar11;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar2) {
            *piVar11 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
        operator_delete(local_38 + -0x18);
      }
    }
  }
                    /* try { // try from 009ab384 to 00aab387 has its CatchHandler @ 009ab40c */
  if (local_90 != (void *)0x0) {
    free();
  }
  Data::~Data((Data *)local_18);
                    /* try { // try from 009ab3a4 to 00aab3a7 has its CatchHandler @ 009ab358 */
  if ((undefined *)(local_40 + -0x18) != PTR_DAT_017191c0) {
    piVar11 = (int *)(local_40 + -8);
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_40 + -8);
      *(int *)(local_40 + -8) = iVar3 + -1;
    }
    else {
      do {
        iVar3 = *piVar11;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar11,0x10);
        if (bVar2) {
          *piVar11 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
                    /* try { // try from 009ab564 to 00aab567 has its CatchHandler @ 009ab578 */
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_40 + -0x18));
    }
  }
  uVar6 = 1;
LAB_009ab3b0:
                    /* try { // try from 009ab3b4 to 00aab3b7 has its CatchHandler @ 009ab44c */
                    /* try { // try from 009ab3c0 to 00aab3c3 has its CatchHandler @ 009ab444 */
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar6);
  }
                    /* try { // try from 009ab3d0 to 00aab3d3 has its CatchHandler @ 009ab420 */
  return;
}


/* === cocos2dx_lua_loader @ 009ac58c === */

void cocos2dx_lua_loader(lua_State *param_1)

{
  bool bVar1;
  char cVar2;
  int iVar3;
  undefined8 uVar4;
  long lVar5;
  char *pcVar6;
  long *plVar7;
  ulong uVar8;
  long *plVar9;
  undefined *puVar10;
  int *piVar11;
  ulong uVar12;
  LuaStack *this;
  ulong uVar13;
  long local_70;
  char *local_68;
  long local_60;
  char *local_58;
  long local_50;
  long local_48;
  long local_40;
  Data aDStack_38 [16];
  long local_28 [2];
  long local_18 [2];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if ((DAT_01738ad8 & 1) == 0) {
    iVar3 = __cxa_guard_acquire(&DAT_01738ad8);
    if (iVar3 != 0) {
      FUN_01211570(&DAT_01738ae0,".luac",local_18);
                    /* try { // try from 009acf70 to 00aacf73 has its CatchHandler @ 009acec8 */
      __cxa_guard_release(&DAT_01738ad8);
                    /* catch() { ... } // from try @ 009acfa8 with catch @ 009acf74
                       catch() { ... } // from try @ 009ad084 with catch @ 009acf74 */
      __cxa_atexit(PTR_FUN_01724158,&DAT_01738ae0,&DAT_01725000);
    }
  }
  if (((DAT_01738ae8 & 1) == 0) && (iVar3 = __cxa_guard_acquire(), iVar3 != 0)) {
                    /* try { // try from 009acf24 to 00aacf3b has its CatchHandler @ 009acf48 */
    FUN_01211570(&DAT_01738af0,&DAT_012b8628,(Data *)local_18);
    __cxa_guard_release(&DAT_01738ae8);
                    /* catch() { ... } // from try @ 009acf24 with catch @ 009acf48 */
    __cxa_atexit(PTR_FUN_01724158,&DAT_01738af0,&DAT_01725000);
  }
  uVar4 = luaL_checklstring(param_1,1,0);
  FUN_01211570(&local_70,uVar4,(Data *)local_18);
  lVar5 = FUN_01212914(&local_70,DAT_01738ae0,0xffffffffffffffff,
                       *(undefined8 *)(DAT_01738ae0 + -0x18));
  if (lVar5 == -1) {
    lVar5 = FUN_01212914(&local_70,DAT_01738af0,0xffffffffffffffff,
                         *(undefined8 *)(DAT_01738af0 + -0x18));
                    /* catch() { ... } // from try @ 009ace20 with catch @ 009ace9c */
    if (*(long *)(local_70 + -0x18) - *(long *)(DAT_01738af0 + -0x18) == lVar5) {
      FUN_0121113c(&local_58,&local_70,0);
                    /* try { // try from 009acec4 to 00aacec7 has its CatchHandler @ 009acdb4 */
                    /* catch() { ... } // from try @ 009acef0 with catch @ 009acec8
                       catch() { ... } // from try @ 009acf70 with catch @ 009acec8 */
      FUN_0121258c(&local_70,&local_58);
      pcVar6 = local_58 + -0x18;
      if (pcVar6 != PTR_DAT_017191c0) {
        piVar11 = (int *)(local_58 + -8);
                    /* try { // try from 009acef0 to 00aacef3 has its CatchHandler @ 009acec8 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar3 = *(int *)(local_58 + -8);
          *(int *)(local_58 + -8) = iVar3 + -1;
        }
        else {
          do {
            iVar3 = *piVar11;
            cVar2 = '\x01';
            bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
            if (bVar1) {
              *piVar11 = iVar3 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        goto joined_r0x009acf08;
      }
    }
  }
  else {
    FUN_0121113c(&local_68,&local_70,0);
    FUN_0121258c(&local_70,&local_68);
    pcVar6 = local_68 + -0x18;
    if (pcVar6 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_68 + -8);
        *(int *)(local_68 + -8) = iVar3 + -1;
      }
      else {
        piVar11 = (int *)(local_68 + -8);
        do {
          iVar3 = *piVar11;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar1) {
            *piVar11 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
joined_r0x009acf08:
      if (iVar3 < 1) {
        operator_delete(pcVar6);
      }
    }
  }
  lVar5 = FUN_01212a98(&local_70,".",0,1);
  while (lVar5 != -1) {
    FUN_012147d4(&local_70,lVar5,1,"/",1);
                    /* catch() { ... } // from try @ 009ac704 with catch @ 009ac6d4
                       catch() { ... } // from try @ 009ac7cc with catch @ 009ac6d4 */
    lVar5 = FUN_01212a98(&local_70,".",0,1);
  }
  cocos2d::Data::Data(aDStack_38);
  local_68 = PTR_DAT_017191c0 + 0x18;
  plVar7 = (long *)cocos2d::FileUtils::getInstance();
                    /* try { // try from 009ac704 to 00aac707 has its CatchHandler @ 009ac6d4 */
  lua_getfield(param_1,0xffffd8ee,"package");
  lua_getfield(param_1,0xffffffff,&DAT_012b8498);
  uVar4 = lua_tolstring(param_1,0xffffffff,0);
                    /* try { // try from 009ac740 to 00aac743 has its CatchHandler @ 009ac7a0 */
  FUN_01211570(&local_60,uVar4,(Data *)local_18);
  lua_settop(param_1,0xfffffffe);
  uVar8 = FUN_01212a98(&local_60,";",0,1);
                    /* try { // try from 009ac778 to 00aac78f has its CatchHandler @ 009ac7d0 */
  uVar13 = 0;
                    /* catch() { ... } // from try @ 009ac740 with catch @ 009ac7a0 */
  uVar12 = *(ulong *)(local_60 + -0x18);
LAB_009ac9c4:
  do {
    if (uVar8 == 0xffffffffffffffff) {
      uVar8 = uVar12;
    }
    if (uVar12 < uVar13) {
                    /* try { // try from 009ad084 to 00aad087 has its CatchHandler @ 009acf74 */
                    /* WARNING: Subroutine does not return */
      FUN_0120f508("%s: __pos (which is %zu) > this->size() (which is %zu)","basic_string::substr",
                   uVar13);
    }
    FUN_0121113c(&local_58,&local_60,uVar13,uVar8);
    if (*(int *)(local_58 + -8) < 0) {
      if (*local_58 == '.') {
LAB_009aca00:
        cVar2 = local_58[1];
joined_r0x009acaa0:
        if (cVar2 == '/') {
          if (*(ulong *)(local_58 + -0x18) < 2) {
                    /* WARNING: Subroutine does not return */
            FUN_0120f508("%s: __pos (which is %zu) > this->size() (which is %zu)",
                         "basic_string::substr",2);
          }
          FUN_0121113c(&local_50,&local_58,2,0xffffffffffffffff);
          FUN_0121258c(&local_58,&local_50);
          if ((undefined *)(local_50 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar3 = *(int *)(local_50 + -8);
              *(int *)(local_50 + -8) = iVar3 + -1;
            }
            else {
              piVar11 = (int *)(local_50 + -8);
              do {
                iVar3 = *piVar11;
                cVar2 = '\x01';
                bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
                if (bVar1) {
                  *piVar11 = iVar3 + -1;
                  cVar2 = ExclusiveMonitorsStatus();
                }
              } while (cVar2 != '\0');
            }
            if (iVar3 < 1) {
              operator_delete((undefined *)(local_50 + -0x18));
            }
          }
        }
      }
    }
    else {
      FUN_01213860(&local_58);
      if (*local_58 == '.') {
        if (*(int *)(local_58 + -8) < 0) goto LAB_009aca00;
        FUN_01213860(&local_58);
        cVar2 = local_58[1];
        goto joined_r0x009acaa0;
      }
    }
                    /* try { // try from 009ac7cc to 00aac80b has its CatchHandler @ 009ac6d4 */
                    /* catch() { ... } // from try @ 009ac778 with catch @ 009ac7d0 */
    uVar4 = FUN_012125d4(&local_58,"?.lua",0,5);
    FUN_0121113c(&local_48,&local_58,0,uVar4);
    plVar9 = (long *)FUN_01211fcc(&local_48,&local_70);
                    /* catch() { ... } // from try @ 009ac848 with catch @ 009ac80c
                       catch() { ... } // from try @ 009ac97c with catch @ 009ac80c */
    local_28[0] = *plVar9;
    *plVar9 = (long)(PTR_DAT_017191c0 + 0x18);
    plVar9 = (long *)FUN_01211fcc((Data *)local_28,&DAT_01738ae0);
                    /* try { // try from 009ac848 to 00aac84b has its CatchHandler @ 009ac80c */
    local_18[0] = *plVar9;
    *plVar9 = (long)(PTR_DAT_017191c0 + 0x18);
    FUN_0121258c(&local_68,(Data *)local_18);
    if ((undefined *)(local_18[0] + -0x18) == PTR_DAT_017191c0) {
LAB_009ac86c:
      puVar10 = (undefined *)(local_28[0] + -0x18);
      if (puVar10 == PTR_DAT_017191c0) goto LAB_009ac880;
LAB_009acaec:
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_28[0] + -8);
        *(int *)(local_28[0] + -8) = iVar3 + -1;
      }
      else {
        piVar11 = (int *)(local_28[0] + -8);
        do {
          iVar3 = *piVar11;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar1) {
            *piVar11 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
                    /* try { // try from 009acb08 to 00aacb0b has its CatchHandler @ 009acae0 */
        } while (cVar2 != '\0');
      }
      if (0 < iVar3) goto LAB_009ac880;
      operator_delete(puVar10);
      puVar10 = (undefined *)(local_48 + -0x18);
      if (puVar10 != PTR_DAT_017191c0) goto LAB_009acb34;
    }
    else {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_18[0] + -8);
        *(int *)(local_18[0] + -8) = iVar3 + -1;
      }
      else {
        piVar11 = (int *)(local_18[0] + -8);
        do {
          iVar3 = *piVar11;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar1) {
            *piVar11 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (0 < iVar3) goto LAB_009ac86c;
      operator_delete((undefined *)(local_18[0] + -0x18));
                    /* catch() { ... } // from try @ 009acb08 with catch @ 009acae0
                       catch() { ... } // from try @ 009acb88 with catch @ 009acae0 */
      puVar10 = (undefined *)(local_28[0] + -0x18);
      if (puVar10 != PTR_DAT_017191c0) goto LAB_009acaec;
LAB_009ac880:
                    /* try { // try from 009ac884 to 00aac887 has its CatchHandler @ 009ac980 */
      puVar10 = (undefined *)(local_48 + -0x18);
      if (puVar10 != PTR_DAT_017191c0) {
LAB_009acb34:
                    /* try { // try from 009acb3c to 00aacb53 has its CatchHandler @ 009acb60 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar3 = *(int *)(local_48 + -8);
                    /* try { // try from 009acd30 to 00aacd33 has its CatchHandler @ 009acd08 */
          *(int *)(local_48 + -8) = iVar3 + -1;
        }
        else {
          piVar11 = (int *)(local_48 + -8);
          do {
            iVar3 = *piVar11;
            cVar2 = '\x01';
            bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
            if (bVar1) {
              *piVar11 = iVar3 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar3 < 1) {
                    /* catch() { ... } // from try @ 009acb3c with catch @ 009acb60 */
          operator_delete(puVar10);
        }
      }
    }
    cVar2 = (**(code **)(*plVar7 + 0x128))(plVar7,&local_68);
    if (cVar2 != '\0') {
                    /* try { // try from 009acde8 to 00aacdeb has its CatchHandler @ 009acdb4 */
      (**(code **)(*plVar7 + 0x28))((Data *)local_28,plVar7,&local_68);
      cocos2d::Data::operator=(aDStack_38,(Data *)local_28);
      cocos2d::Data::~Data((Data *)local_28);
LAB_009ace04:
      if (local_58 + -0x18 != PTR_DAT_017191c0) {
                    /* try { // try from 009ace20 to 00aace8b has its CatchHandler @ 009ace9c */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar3 = *(int *)(local_58 + -8);
          *(int *)(local_58 + -8) = iVar3 + -1;
        }
        else {
          piVar11 = (int *)(local_58 + -8);
          do {
            iVar3 = *piVar11;
            cVar2 = '\x01';
            bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
            if (bVar1) {
              *piVar11 = iVar3 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar3 < 1) {
          operator_delete(local_58 + -0x18);
        }
      }
      break;
    }
                    /* try { // try from 009ac8c0 to 00aac92f has its CatchHandler @ 009ac944 */
    FUN_0121113c(&local_40,&local_58,0,uVar4);
    plVar9 = (long *)FUN_01211fcc(&local_40,&local_70);
    local_28[0] = *plVar9;
    *plVar9 = (long)(PTR_DAT_017191c0 + 0x18);
    plVar9 = (long *)FUN_01211fcc((Data *)local_28,&DAT_01738af0);
    local_18[0] = *plVar9;
    *plVar9 = (long)(PTR_DAT_017191c0 + 0x18);
    FUN_0121258c(&local_68,(Data *)local_18);
    if ((undefined *)(local_18[0] + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_18[0] + -8);
                    /* try { // try from 009acd64 to 00aacd7b has its CatchHandler @ 009acd88 */
        *(int *)(local_18[0] + -8) = iVar3 + -1;
      }
      else {
        piVar11 = (int *)(local_18[0] + -8);
        do {
          iVar3 = *piVar11;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar1) {
            *piVar11 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar3 < 1) {
                    /* try { // try from 009acbf8 to 00aacc63 has its CatchHandler @ 009acc74 */
        operator_delete((undefined *)(local_18[0] + -0x18));
      }
    }
                    /* catch() { ... } // from try @ 009ac8c0 with catch @ 009ac944 */
    if ((undefined *)(local_28[0] + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_28[0] + -8);
        *(int *)(local_28[0] + -8) = iVar3 + -1;
      }
      else {
        piVar11 = (int *)(local_28[0] + -8);
        do {
          iVar3 = *piVar11;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar1) {
            *piVar11 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
                    /* try { // try from 009acbc0 to 00aacbc3 has its CatchHandler @ 009acb8c */
      if (iVar3 < 1) {
        operator_delete((undefined *)(local_28[0] + -0x18));
      }
    }
    if ((undefined *)(local_40 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_40 + -8);
        *(int *)(local_40 + -8) = iVar3 + -1;
      }
      else {
        piVar11 = (int *)(local_40 + -8);
        do {
          iVar3 = *piVar11;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
          if (bVar1) {
            *piVar11 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
                    /* try { // try from 009acb88 to 00aacb8b has its CatchHandler @ 009acae0 */
                    /* catch() { ... } // from try @ 009acbc0 with catch @ 009acb8c
                       catch() { ... } // from try @ 009acc9c with catch @ 009acb8c */
      if (iVar3 < 1) {
        operator_delete((undefined *)(local_40 + -0x18));
      }
    }
    cVar2 = (**(code **)(*plVar7 + 0x128))(plVar7,&local_68);
                    /* try { // try from 009ac97c to 00aac9af has its CatchHandler @ 009ac80c */
    if (cVar2 != '\0') {
      (**(code **)(*plVar7 + 0x28))((Data *)local_18,plVar7,&local_68);
      cocos2d::Data::operator=(aDStack_38,(Data *)local_18);
      cocos2d::Data::~Data((Data *)local_18);
      goto LAB_009ace04;
    }
                    /* catch() { ... } // from try @ 009ac884 with catch @ 009ac980 */
    uVar13 = uVar8 + 1;
    uVar8 = FUN_01212a98(&local_60,";",uVar13,1);
    if (local_58 + -0x18 == PTR_DAT_017191c0) {
LAB_009ac9b4:
      uVar12 = *(ulong *)(local_60 + -0x18);
      if ((ulong)(long)(int)uVar12 <= uVar13) break;
      goto LAB_009ac9c4;
    }
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_58 + -8);
      *(int *)(local_58 + -8) = iVar3 + -1;
    }
    else {
      piVar11 = (int *)(local_58 + -8);
      do {
        iVar3 = *piVar11;
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
        if (bVar1) {
          *piVar11 = iVar3 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (0 < iVar3) goto LAB_009ac9b4;
    operator_delete(local_58 + -0x18);
    uVar12 = *(ulong *)(local_60 + -0x18);
  } while (uVar13 < (ulong)(long)(int)uVar12);
  lVar5 = cocos2d::Data::getSize(aDStack_38);
  if (lVar5 < 1) {
    uVar4 = 0;
                    /* catch() { ... } // from try @ 009acd64 with catch @ 009acd88 */
    puVar10 = (undefined *)(local_60 + -0x18);
    if (puVar10 == PTR_DAT_017191c0) goto LAB_009acca4;
  }
  else {
    lVar5 = cocos2d::LuaEngine::getInstance();
    this = *(LuaStack **)(lVar5 + 8);
    pcVar6 = (char *)cocos2d::Data::getBytes(aDStack_38);
    iVar3 = cocos2d::Data::getSize(aDStack_38);
                    /* catch() { ... } // from try @ 009acbf8 with catch @ 009acc74 */
    cocos2d::LuaStack::luaLoadBuffer(this,param_1,pcVar6,iVar3,local_68);
    uVar4 = 1;
    puVar10 = (undefined *)(local_60 + -0x18);
                    /* try { // try from 009acc9c to 00aacc9f has its CatchHandler @ 009acb8c */
    if (puVar10 == PTR_DAT_017191c0) goto LAB_009acca4;
  }
  if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
    iVar3 = *(int *)(local_60 + -8);
    *(int *)(local_60 + -8) = iVar3 + -1;
  }
  else {
    piVar11 = (int *)(local_60 + -8);
    do {
      iVar3 = *piVar11;
      cVar2 = '\x01';
      bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
      if (bVar1) {
        *piVar11 = iVar3 + -1;
        cVar2 = ExclusiveMonitorsStatus();
      }
                    /* try { // try from 009acdb0 to 00aacdb3 has its CatchHandler @ 009acd08 */
    } while (cVar2 != '\0');
  }
                    /* catch() { ... } // from try @ 009acde8 with catch @ 009acdb4
                       catch() { ... } // from try @ 009acec4 with catch @ 009acdb4 */
  if (iVar3 < 1) {
    operator_delete(puVar10);
  }
LAB_009acca4:
  if (local_68 + -0x18 != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_68 + -8);
      *(int *)(local_68 + -8) = iVar3 + -1;
    }
    else {
      piVar11 = (int *)(local_68 + -8);
      do {
        iVar3 = *piVar11;
                    /* try { // try from 009acfa8 to 00aacfab has its CatchHandler @ 009acf74 */
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
        if (bVar1) {
          *piVar11 = iVar3 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete(local_68 + -0x18);
    }
  }
  cocos2d::Data::~Data(aDStack_38);
  if ((undefined *)(local_70 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_70 + -8);
                    /* catch() { ... } // from try @ 009acfe0 with catch @ 009ad05c */
      *(int *)(local_70 + -8) = iVar3 + -1;
    }
    else {
      piVar11 = (int *)(local_70 + -8);
      do {
        iVar3 = *piVar11;
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar11,0x10);
        if (bVar1) {
          *piVar11 = iVar3 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
                    /* try { // try from 009acfe0 to 00aad04b has its CatchHandler @ 009ad05c */
      } while (cVar2 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_70 + -0x18));
    }
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* catch() { ... } // from try @ 009acd30 with catch @ 009acd08
                       catch() { ... } // from try @ 009acdb0 with catch @ 009acd08 */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar4);
}


/* === loadAndExecuteScript @ 00ac69a0 === */

/* cocos2d::ComponentLua::loadAndExecuteScript() */

void __thiscall cocos2d::ComponentLua::loadAndExecuteScript(ComponentLua *this)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  long lVar4;
  long *plVar5;
  long lVar6;
  char *pcVar7;
  int *piVar8;
  undefined8 uVar9;
  LuaStack *this_00;
  lua_State *plVar10;
  char *local_20;
  Data aDStack_18 [16];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  lVar4 = LuaEngine::getInstance();
  plVar10 = *(lua_State **)(*(long *)(lVar4 + 8) + 0x28);
  plVar5 = (long *)FileUtils::getInstance();
  (**(code **)(*plVar5 + 0x50))(&local_20,plVar5,this + 0x40);
  (**(code **)(*plVar5 + 0x28))(aDStack_18,plVar5,&local_20);
  lVar6 = Data::getSize(aDStack_18);
  if (lVar6 < 1) {
LAB_00ac6adc:
    lua_settop(plVar10,0xfffffffe);
  }
  else {
    this_00 = *(LuaStack **)(lVar4 + 8);
    pcVar7 = (char *)Data::getBytes(aDStack_18);
    iVar3 = Data::getSize(aDStack_18);
    iVar3 = LuaStack::luaLoadBuffer(this_00,plVar10,pcVar7,iVar3,local_20);
    if ((iVar3 != 0) || (iVar3 = lua_pcall(plVar10,0,1,0), iVar3 != 0)) goto LAB_00ac6adc;
    iVar3 = lua_type(plVar10,0xffffffff);
    if (iVar3 == 5) {
      storeLuaTable(this);
      uVar9 = 1;
      goto LAB_00ac6a8c;
    }
  }
  uVar9 = 0;
LAB_00ac6a8c:
  Data::~Data(aDStack_18);
  if (local_20 + -0x18 != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_20 + -8);
      *(int *)(local_20 + -8) = iVar3 + -1;
    }
    else {
      piVar8 = (int *)(local_20 + -8);
      do {
        iVar3 = *piVar8;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
        if (bVar2) {
          *piVar8 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete(local_20 + -0x18);
    }
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar9);
}

