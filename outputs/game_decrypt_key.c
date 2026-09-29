
/* SYMBOL cocos2d::FileUtilsAndroid::decryptKey @ 0099d8cc type=Function */

/* cocos2d::FileUtilsAndroid::decryptKey(std::string const&) const */

void cocos2d::FileUtilsAndroid::decryptKey(string *param_1)

{
  bool bVar1;
  _jclass *p_Var2;
  _jmethodID *p_Var3;
  char cVar4;
  long *plVar5;
  undefined8 *puVar6;
  undefined8 uVar7;
  _jstring *p_Var8;
  undefined *puVar9;
  undefined8 *in_x1;
  int *piVar10;
  int iVar11;
  ulong uVar12;
  char *pcVar13;
  undefined1 auStack_98 [8];
  undefined1 auStack_90 [8];
  undefined *local_88;
  char *local_80;
  char *local_78;
  char *local_70;
  long local_68;
  long local_60;
  _jclass *local_58;
  _jmethodID *local_50;
  undefined8 local_48;
  undefined8 *local_40;
  ulong local_38;
  undefined8 local_30;
  undefined8 local_28;
  undefined4 local_20 [2];
  undefined8 local_18;
  undefined8 local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FUN_01211570();
  FUN_01211570((string *)&local_80,"org/cocos2dx/lib/Cocos2dxHelper",auStack_98);
  FUN_01211570((string *)&local_78,"decryptKey",auStack_90);
  pcVar13 = (char *)*in_x1;
  local_88 = PTR_DAT_017191c0 + 0x18;
  FUN_01211570(&local_60,"Ljava/lang/String;",
               (_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                *)&local_40);
  plVar5 = (long *)FUN_01213d48(&local_60,0,&DAT_0128acc0,1);
  local_40 = (undefined8 *)*plVar5;
  *plVar5 = (long)(PTR_DAT_017191c0 + 0x18);
  plVar5 = (long *)FUN_0121218c((_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                                 *)&local_40,")Ljava/lang/String;",0x13);
  puVar9 = PTR_DAT_017191c0;
  local_70 = (char *)*plVar5;
  *plVar5 = (long)(PTR_DAT_017191c0 + 0x18);
  if (local_40 + -3 != (undefined8 *)puVar9) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar11 = *(int *)(local_40 + -1);
      *(int *)(local_40 + -1) = iVar11 + -1;
    }
    else {
      piVar10 = (int *)(local_40 + -1);
      do {
        iVar11 = *piVar10;
        cVar4 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
        if (bVar1) {
          *piVar10 = iVar11 + -1;
          cVar4 = ExclusiveMonitorsStatus();
        }
      } while (cVar4 != '\0');
    }
    if (iVar11 < 1) {
      operator_delete(local_40 + -3);
    }
  }
  if ((undefined *)(local_60 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar11 = *(int *)(local_60 + -8);
                    /* try { // try from 0099dd94 to 00a9de1b has its CatchHandler @ 0099dd48 */
      *(int *)(local_60 + -8) = iVar11 + -1;
    }
    else {
      piVar10 = (int *)(local_60 + -8);
      do {
        iVar11 = *piVar10;
        cVar4 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
        if (bVar1) {
          *piVar10 = iVar11 + -1;
          cVar4 = ExclusiveMonitorsStatus();
        }
      } while (cVar4 != '\0');
    }
    if (iVar11 < 1) {
      operator_delete((undefined *)(local_60 + -0x18));
    }
  }
  cVar4 = JniHelper::getStaticMethodInfo((JniMethodInfo_ *)&local_58,local_80,local_78,local_70);
  if (cVar4 == '\0') {
                    /* try { // try from 0099db64 to 00a9db67 has its CatchHandler @ 0099da9c */
    JniHelper::reportError((string *)&local_80,(string *)&local_78,(string *)&local_70);
    pcVar13 = local_70 + -0x18;
    if (pcVar13 != PTR_DAT_017191c0) goto LAB_0099db24;
  }
  else {
    local_30 = 0;
    local_28 = 0;
    local_20[0] = 0x3f800000;
    local_18 = 0;
    local_38 = FUN_0120ff88(local_20,10);
    if (local_38 == 1) {
      local_10 = 0;
      puVar6 = &local_10;
    }
    else {
      if (0x1fffffffffffffff < local_38) {
                    /* WARNING: Subroutine does not return */
        FUN_0120f0e8();
      }
      uVar12 = local_38 << 3;
      puVar6 = operator_new(uVar12);
      memset(puVar6,0,uVar12);
    }
    p_Var3 = local_50;
    p_Var2 = local_58;
    local_40 = puVar6;
    uVar7 = JniHelper::convert((_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                                *)&local_40,(JniMethodInfo_ *)&local_58,pcVar13);
    p_Var8 = (_jstring *)_JNIEnv::CallStaticObjectMethod(p_Var2,p_Var3,local_48,uVar7);
                    /* catch() { ... } // from try @ 0099dac4 with catch @ 0099da9c
                       catch() { ... } // from try @ 0099db64 with catch @ 0099da9c */
    JniHelper::jstring2string(p_Var8);
    FUN_0121258c(&local_88,&local_68);
                    /* try { // try from 0099dac4 to 00a9dad3 has its CatchHandler @ 0099da9c */
    if ((undefined *)(local_68 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar11 = *(int *)(local_68 + -8);
        *(int *)(local_68 + -8) = iVar11 + -1;
      }
      else {
        piVar10 = (int *)(local_68 + -8);
        do {
          iVar11 = *piVar10;
          cVar4 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
          if (bVar1) {
            *piVar10 = iVar11 + -1;
            cVar4 = ExclusiveMonitorsStatus();
          }
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099dd94 with catch @ 0099dd48
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e27c with catch @ 0099dd48
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e378 with catch @ 0099dd48
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e390 with catch @ 0099dd48
                        */
        } while (cVar4 != '\0');
      }
      if (iVar11 < 1) {
        operator_delete((undefined *)(local_68 + -0x18));
      }
    }
                    /* try { // try from 0099dadc to 00a9dadf has its CatchHandler @ 0099db34 */
    (**(code **)(*(long *)local_58 + 0xb8))(local_58,local_50);
    (**(code **)(*(long *)local_58 + 0xb8))(local_58,p_Var8);
    JniHelper::deleteLocalRefs
              ((_JNIEnv *)local_58,
               (_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                *)&local_40);
    std::
    _Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
    ::~_Hashtable((_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                   *)&local_40);
    pcVar13 = local_70 + -0x18;
    if (pcVar13 != PTR_DAT_017191c0) {
LAB_0099db24:
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar11 = *(int *)(local_70 + -8);
        *(int *)(local_70 + -8) = iVar11 + -1;
      }
      else {
        piVar10 = (int *)(local_70 + -8);
        do {
                    /* catch() { ... } // from try @ 0099dadc with catch @ 0099db34 */
          iVar11 = *piVar10;
          cVar4 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
          if (bVar1) {
            *piVar10 = iVar11 + -1;
            cVar4 = ExclusiveMonitorsStatus();
          }
        } while (cVar4 != '\0');
      }
      if (iVar11 < 1) {
        operator_delete(pcVar13);
      }
    }
  }
  if (local_78 + -0x18 != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar11 = *(int *)(local_78 + -8);
      *(int *)(local_78 + -8) = iVar11 + -1;
    }
    else {
      piVar10 = (int *)(local_78 + -8);
      do {
        iVar11 = *piVar10;
        cVar4 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
        if (bVar1) {
          *piVar10 = iVar11 + -1;
          cVar4 = ExclusiveMonitorsStatus();
        }
      } while (cVar4 != '\0');
    }
    if (iVar11 < 1) {
      operator_delete(local_78 + -0x18);
    }
  }
  if (local_80 + -0x18 != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar11 = *(int *)(local_80 + -8);
      *(int *)(local_80 + -8) = iVar11 + -1;
    }
    else {
      piVar10 = (int *)(local_80 + -8);
      do {
        iVar11 = *piVar10;
        cVar4 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
        if (bVar1) {
          *piVar10 = iVar11 + -1;
          cVar4 = ExclusiveMonitorsStatus();
        }
      } while (cVar4 != '\0');
    }
    if (iVar11 < 1) {
      operator_delete(local_80 + -0x18);
    }
  }
  if (*(long *)(local_88 + -0x18) == 0) {
    puVar9 = local_88 + -0x18;
    if (puVar9 == PTR_DAT_017191c0) goto LAB_0099dbc4;
  }
  else {
    FUN_01211fcc();
    puVar9 = local_88 + -0x18;
    if (puVar9 == PTR_DAT_017191c0) goto LAB_0099dbc4;
  }
  if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
    iVar11 = *(int *)(local_88 + -8);
    *(int *)(local_88 + -8) = iVar11 + -1;
  }
  else {
    piVar10 = (int *)(local_88 + -8);
    do {
      iVar11 = *piVar10;
      cVar4 = '\x01';
      bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
      if (bVar1) {
        *piVar10 = iVar11 + -1;
        cVar4 = ExclusiveMonitorsStatus();
      }
    } while (cVar4 != '\0');
  }
  if (iVar11 < 1) {
    operator_delete(puVar9);
  }
LAB_0099dbc4:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}


/* SYMBOL _ZNK7cocos2d16FileUtilsAndroid10decryptKeyERKSs @ 0099d8cc type=Label */

/* cocos2d::FileUtilsAndroid::decryptKey(std::string const&) const */

void cocos2d::FileUtilsAndroid::decryptKey(string *param_1)

{
  bool bVar1;
  _jclass *p_Var2;
  _jmethodID *p_Var3;
  char cVar4;
  long *plVar5;
  undefined8 *puVar6;
  undefined8 uVar7;
  _jstring *p_Var8;
  undefined *puVar9;
  undefined8 *in_x1;
  int *piVar10;
  int iVar11;
  ulong uVar12;
  char *pcVar13;
  undefined1 auStack_98 [8];
  undefined1 auStack_90 [8];
  undefined *local_88;
  char *local_80;
  char *local_78;
  char *local_70;
  long local_68;
  long local_60;
  _jclass *local_58;
  _jmethodID *local_50;
  undefined8 local_48;
  undefined8 *local_40;
  ulong local_38;
  undefined8 local_30;
  undefined8 local_28;
  undefined4 local_20 [2];
  undefined8 local_18;
  undefined8 local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FUN_01211570();
  FUN_01211570((string *)&local_80,"org/cocos2dx/lib/Cocos2dxHelper",auStack_98);
  FUN_01211570((string *)&local_78,"decryptKey",auStack_90);
  pcVar13 = (char *)*in_x1;
  local_88 = PTR_DAT_017191c0 + 0x18;
  FUN_01211570(&local_60,"Ljava/lang/String;",
               (_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                *)&local_40);
  plVar5 = (long *)FUN_01213d48(&local_60,0,&DAT_0128acc0,1);
  local_40 = (undefined8 *)*plVar5;
  *plVar5 = (long)(PTR_DAT_017191c0 + 0x18);
  plVar5 = (long *)FUN_0121218c((_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                                 *)&local_40,")Ljava/lang/String;",0x13);
  puVar9 = PTR_DAT_017191c0;
  local_70 = (char *)*plVar5;
  *plVar5 = (long)(PTR_DAT_017191c0 + 0x18);
  if (local_40 + -3 != (undefined8 *)puVar9) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar11 = *(int *)(local_40 + -1);
      *(int *)(local_40 + -1) = iVar11 + -1;
    }
    else {
      piVar10 = (int *)(local_40 + -1);
      do {
        iVar11 = *piVar10;
        cVar4 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
        if (bVar1) {
          *piVar10 = iVar11 + -1;
          cVar4 = ExclusiveMonitorsStatus();
        }
      } while (cVar4 != '\0');
    }
    if (iVar11 < 1) {
      operator_delete(local_40 + -3);
    }
  }
  if ((undefined *)(local_60 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar11 = *(int *)(local_60 + -8);
                    /* try { // try from 0099dd94 to 00a9de1b has its CatchHandler @ 0099dd48 */
      *(int *)(local_60 + -8) = iVar11 + -1;
    }
    else {
      piVar10 = (int *)(local_60 + -8);
      do {
        iVar11 = *piVar10;
        cVar4 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
        if (bVar1) {
          *piVar10 = iVar11 + -1;
          cVar4 = ExclusiveMonitorsStatus();
        }
      } while (cVar4 != '\0');
    }
    if (iVar11 < 1) {
      operator_delete((undefined *)(local_60 + -0x18));
    }
  }
  cVar4 = JniHelper::getStaticMethodInfo((JniMethodInfo_ *)&local_58,local_80,local_78,local_70);
  if (cVar4 == '\0') {
                    /* try { // try from 0099db64 to 00a9db67 has its CatchHandler @ 0099da9c */
    JniHelper::reportError((string *)&local_80,(string *)&local_78,(string *)&local_70);
    pcVar13 = local_70 + -0x18;
    if (pcVar13 != PTR_DAT_017191c0) goto LAB_0099db24;
  }
  else {
    local_30 = 0;
    local_28 = 0;
    local_20[0] = 0x3f800000;
    local_18 = 0;
    local_38 = FUN_0120ff88(local_20,10);
    if (local_38 == 1) {
      local_10 = 0;
      puVar6 = &local_10;
    }
    else {
      if (0x1fffffffffffffff < local_38) {
                    /* WARNING: Subroutine does not return */
        FUN_0120f0e8();
      }
      uVar12 = local_38 << 3;
      puVar6 = operator_new(uVar12);
      memset(puVar6,0,uVar12);
    }
    p_Var3 = local_50;
    p_Var2 = local_58;
    local_40 = puVar6;
    uVar7 = JniHelper::convert((_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                                *)&local_40,(JniMethodInfo_ *)&local_58,pcVar13);
    p_Var8 = (_jstring *)_JNIEnv::CallStaticObjectMethod(p_Var2,p_Var3,local_48,uVar7);
                    /* catch() { ... } // from try @ 0099dac4 with catch @ 0099da9c
                       catch() { ... } // from try @ 0099db64 with catch @ 0099da9c */
    JniHelper::jstring2string(p_Var8);
    FUN_0121258c(&local_88,&local_68);
                    /* try { // try from 0099dac4 to 00a9dad3 has its CatchHandler @ 0099da9c */
    if ((undefined *)(local_68 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar11 = *(int *)(local_68 + -8);
        *(int *)(local_68 + -8) = iVar11 + -1;
      }
      else {
        piVar10 = (int *)(local_68 + -8);
        do {
          iVar11 = *piVar10;
          cVar4 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
          if (bVar1) {
            *piVar10 = iVar11 + -1;
            cVar4 = ExclusiveMonitorsStatus();
          }
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099dd94 with catch @ 0099dd48
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e27c with catch @ 0099dd48
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e378 with catch @ 0099dd48
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e390 with catch @ 0099dd48
                        */
        } while (cVar4 != '\0');
      }
      if (iVar11 < 1) {
        operator_delete((undefined *)(local_68 + -0x18));
      }
    }
                    /* try { // try from 0099dadc to 00a9dadf has its CatchHandler @ 0099db34 */
    (**(code **)(*(long *)local_58 + 0xb8))(local_58,local_50);
    (**(code **)(*(long *)local_58 + 0xb8))(local_58,p_Var8);
    JniHelper::deleteLocalRefs
              ((_JNIEnv *)local_58,
               (_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                *)&local_40);
    std::
    _Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
    ::~_Hashtable((_Hashtable<_JNIEnv*,std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>,std::allocator<std::pair<_JNIEnv*const,std::vector<_jobject*,std::allocator<_jobject*>>>>,std::__detail::_Select1st,std::equal_to<_JNIEnv*>,std::hash<_JNIEnv*>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                   *)&local_40);
    pcVar13 = local_70 + -0x18;
    if (pcVar13 != PTR_DAT_017191c0) {
LAB_0099db24:
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar11 = *(int *)(local_70 + -8);
        *(int *)(local_70 + -8) = iVar11 + -1;
      }
      else {
        piVar10 = (int *)(local_70 + -8);
        do {
                    /* catch() { ... } // from try @ 0099dadc with catch @ 0099db34 */
          iVar11 = *piVar10;
          cVar4 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
          if (bVar1) {
            *piVar10 = iVar11 + -1;
            cVar4 = ExclusiveMonitorsStatus();
          }
        } while (cVar4 != '\0');
      }
      if (iVar11 < 1) {
        operator_delete(pcVar13);
      }
    }
  }
  if (local_78 + -0x18 != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar11 = *(int *)(local_78 + -8);
      *(int *)(local_78 + -8) = iVar11 + -1;
    }
    else {
      piVar10 = (int *)(local_78 + -8);
      do {
        iVar11 = *piVar10;
        cVar4 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
        if (bVar1) {
          *piVar10 = iVar11 + -1;
          cVar4 = ExclusiveMonitorsStatus();
        }
      } while (cVar4 != '\0');
    }
    if (iVar11 < 1) {
      operator_delete(local_78 + -0x18);
    }
  }
  if (local_80 + -0x18 != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar11 = *(int *)(local_80 + -8);
      *(int *)(local_80 + -8) = iVar11 + -1;
    }
    else {
      piVar10 = (int *)(local_80 + -8);
      do {
        iVar11 = *piVar10;
        cVar4 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
        if (bVar1) {
          *piVar10 = iVar11 + -1;
          cVar4 = ExclusiveMonitorsStatus();
        }
      } while (cVar4 != '\0');
    }
    if (iVar11 < 1) {
      operator_delete(local_80 + -0x18);
    }
  }
  if (*(long *)(local_88 + -0x18) == 0) {
    puVar9 = local_88 + -0x18;
    if (puVar9 == PTR_DAT_017191c0) goto LAB_0099dbc4;
  }
  else {
    FUN_01211fcc();
    puVar9 = local_88 + -0x18;
    if (puVar9 == PTR_DAT_017191c0) goto LAB_0099dbc4;
  }
  if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
    iVar11 = *(int *)(local_88 + -8);
    *(int *)(local_88 + -8) = iVar11 + -1;
  }
  else {
    piVar10 = (int *)(local_88 + -8);
    do {
      iVar11 = *piVar10;
      cVar4 = '\x01';
      bVar1 = (bool)ExclusiveMonitorPass(piVar10,0x10);
      if (bVar1) {
        *piVar10 = iVar11 + -1;
        cVar4 = ExclusiveMonitorsStatus();
      }
    } while (cVar4 != '\0');
  }
  if (iVar11 < 1) {
    operator_delete(puVar9);
  }
LAB_0099dbc4:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}


/* SYMBOL cocos2d::FileUtilsAndroid::getNewFilename @ 0099e120 type=Function */

/* cocos2d::FileUtilsAndroid::getNewFilename(std::string const&) const */

void __thiscall cocos2d::FileUtilsAndroid::getNewFilename(FileUtilsAndroid *this,string *param_1)

{
  long *plVar1;
  undefined *puVar2;
  char cVar3;
  bool bVar4;
  bool bVar5;
  bool bVar6;
  long *plVar7;
  int iVar8;
  long lVar9;
  long *plVar10;
  long lVar11;
  int *piVar12;
  long *plVar13;
  ulong uVar14;
  long *in_x8;
  long *plVar15;
  ulong uVar16;
  undefined *local_38;
  long local_30;
  long local_28;
  long *local_20;
  long *local_18;
  long *local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FileUtils::getNewFilename((string *)this);
  lVar9 = FUN_012125d4();
  if (0xfffffffffffffffd < lVar9 - 1U) goto LAB_0099e178;
  local_20 = (long *)0x0;
  local_18 = (long *)0x0;
  local_10 = (long *)0x0;
  plVar10 = operator_new(0x18);
  plVar1 = plVar10 + 3;
  puVar2 = PTR_DAT_017191c0 + 0x18;
  *plVar10 = (long)puVar2;
  if (plVar10 == (long *)0xfffffffffffffff8) {
    plVar13 = (long *)&DAT_00000008;
                    /* try { // try from 0099e640 to 00a9e643 has its CatchHandler @ 0099e580 */
LAB_0099e1f4:
    *plVar13 = (long)(PTR_DAT_017191c0 + 0x18);
  }
  else {
    plVar10[1] = (long)puVar2;
    plVar13 = plVar10 + 2;
    if (plVar13 != (long *)0x0) goto LAB_0099e1f4;
  }
  local_20 = plVar10;
  plVar15 = plVar1;
  local_10 = plVar1;
  local_18 = plVar1;
  plVar13 = plVar10;
  if ((long)plVar1 - (long)plVar10 >> 3 != 0) {
                    /* try { // try from 0099e5bc to 00a9e5bf has its CatchHandler @ 0099e580 */
    for (; plVar15 = plVar10, plVar1 != plVar13; plVar13 = plVar13 + 1) {
      lVar9 = *plVar13;
                    /* try { // try from 0099e5e4 to 00a9e5e7 has its CatchHandler @ 0099e630 */
      if ((undefined *)(lVar9 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(lVar9 + -8);
          *(int *)(lVar9 + -8) = iVar8 + -1;
        }
        else {
                    /* catch() { ... } // from try @ 0099e5c4 with catch @ 0099e5fc */
          piVar12 = (int *)(lVar9 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar6 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar6) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar8 < 1) {
          operator_delete((undefined *)(lVar9 + -0x18));
        }
      }
    }
  }
  local_18 = plVar15;
  uVar16 = 0;
  bVar6 = false;
LAB_0099e240:
  do {
                    /* try { // try from 0099e244 to 00a9e26b has its CatchHandler @ 0099e32c */
    lVar9 = FUN_0121282c();
    local_38 = PTR_DAT_017191c0 + 0x18;
    if (lVar9 == -1) {
      uVar14 = *(ulong *)(*in_x8 + -0x18);
                    /* catch() { ... } // from try @ 0099e434 with catch @ 0099e470 */
      if (uVar14 < uVar16) {
                    /* catch() { ... } // from try @ 0099e6a4 with catch @ 0099e6dc */
                    /* WARNING: Subroutine does not return */
        FUN_0120f508("%s: __pos (which is %zu) > this->size() (which is %zu)","basic_string::substr"
                     ,uVar16,uVar14);
      }
      FUN_0121113c(&local_30);
      FUN_0121258c((string *)&local_38,&local_30);
                    /* catch() { ... } // from try @ 0099e454 with catch @ 0099e494 */
      if ((undefined *)(local_30 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 0099e4b0 to 00a9e4b3 has its CatchHandler @ 0099e3e8 */
                    /* catch() { ... } // from try @ 0099e4f8 with catch @ 0099e4b4
                       catch() { ... } // from try @ 0099e570 with catch @ 0099e4b4
                       catch() { ... } // from try @ 0099e57c with catch @ 0099e4b4 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(local_30 + -8);
          *(int *)(local_30 + -8) = iVar8 + -1;
        }
        else {
          piVar12 = (int *)(local_30 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar5 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar5) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar8 < 1) {
          bVar5 = false;
          operator_delete((undefined *)(local_30 + -0x18));
          goto LAB_0099e2b4;
        }
      }
                    /* try { // try from 0099e4a4 to 00a9e4a7 has its CatchHandler @ 0099e3e8 */
      bVar5 = false;
    }
    else {
      uVar14 = *(ulong *)(*in_x8 + -0x18);
                    /* try { // try from 0099e27c to 00a9e28b has its CatchHandler @ 0099dd48 */
      if (uVar14 < uVar16) {
                    /* try { // try from 0099e65c to 00a9e65f has its CatchHandler @ 0099e580 */
                    /* catch() { ... } // from try @ 0099e69c with catch @ 0099e660
                       catch() { ... } // from try @ 0099e720 with catch @ 0099e660
                       catch() { ... } // from try @ 0099e73c with catch @ 0099e660 */
                    /* WARNING: Subroutine does not return */
        FUN_0120f508("%s: __pos (which is %zu) > this->size() (which is %zu)","basic_string::substr"
                     ,uVar16,uVar14);
      }
      FUN_0121113c(&local_28);
      FUN_0121258c((string *)&local_38,&local_28);
                    /* try { // try from 0099e2a8 to 00a9e2b7 has its CatchHandler @ 0099e35c */
      if ((undefined *)(local_28 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(local_28 + -8);
                    /* try { // try from 0099e57c to 00a9e57f has its CatchHandler @ 0099e4b4 */
                    /* catch() { ... } // from try @ 0099e5bc with catch @ 0099e580
                       catch() { ... } // from try @ 0099e640 with catch @ 0099e580
                       catch() { ... } // from try @ 0099e65c with catch @ 0099e580 */
          *(int *)(local_28 + -8) = iVar8 + -1;
        }
        else {
          piVar12 = (int *)(local_28 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar5 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar5) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar8 < 1) {
          operator_delete((undefined *)(local_28 + -0x18));
        }
      }
      bVar5 = true;
    }
LAB_0099e2b4:
    lVar11 = (long)local_18 - (long)local_20 >> 3;
    if (lVar11 == 0) {
      if (local_10 == local_18) {
LAB_0099e450:
                    /* try { // try from 0099e454 to 00a9e457 has its CatchHandler @ 0099e494 */
        std::vector<std::string,std::allocator<std::string>>::
        _M_emplace_back_aux<std::string_const&>
                  ((vector<std::string,std::allocator<std::string>> *)&local_20,(string *)&local_38)
        ;
      }
      else {
LAB_0099e2d8:
        if (local_18 != (long *)0x0) {
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099de40 with catch @ 0099e2e0
                        */
          FUN_01214ee0(local_18,(string *)&local_38);
        }
        local_18 = local_18 + 1;
      }
    }
    else {
                    /* try { // try from 0099e42c to 00a9e42f has its CatchHandler @ 0099e3e8 */
                    /* try { // try from 0099e434 to 00a9e437 has its CatchHandler @ 0099e470 */
      iVar8 = FUN_01213398(local_20 + lVar11 + -1,&DAT_012b7230);
                    /* try { // try from 0099e570 to 00a9e573 has its CatchHandler @ 0099e4b4 */
      if ((iVar8 == 0) ||
         ((iVar8 = FUN_01213398((string *)&local_38,&DAT_012b7230), iVar8 != 0 &&
          (iVar8 = FUN_01213398((string *)&local_38,&DAT_012b7238), iVar8 != 0)))) {
        if (local_10 == local_18) goto LAB_0099e450;
        goto LAB_0099e2d8;
      }
                    /* try { // try from 0099e4f8 to 00a9e4fb has its CatchHandler @ 0099e4b4 */
                    /* try { // try from 0099e500 to 00a9e503 has its CatchHandler @ 0099e53c */
      lVar11 = local_18[-1];
      if ((undefined *)(lVar11 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 0099e520 to 00a9e523 has its CatchHandler @ 0099e560 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(lVar11 + -8);
          *(int *)(lVar11 + -8) = iVar8 + -1;
        }
        else {
          piVar12 = (int *)(lVar11 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar6 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar6) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
                    /* catch() { ... } // from try @ 0099e500 with catch @ 0099e53c */
        if (iVar8 < 1) {
          bVar6 = true;
          local_18 = local_18 + -1;
          operator_delete((undefined *)(lVar11 + -0x18));
          goto LAB_0099e2f0;
        }
      }
      bVar6 = true;
      local_18 = local_18 + -1;
    }
LAB_0099e2f0:
    uVar16 = lVar9 + 1;
    if (local_38 + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar8 = *(int *)(local_38 + -8);
        *(int *)(local_38 + -8) = iVar8 + -1;
                    /* catch() { ... } // from try @ 0099e520 with catch @ 0099e560 */
      }
      else {
        piVar12 = (int *)(local_38 + -8);
        do {
          iVar8 = *piVar12;
          cVar3 = '\x01';
          bVar4 = (bool)ExclusiveMonitorPass(piVar12,0x10);
          if (bVar4) {
            *piVar12 = iVar8 + -1;
            cVar3 = ExclusiveMonitorsStatus();
          }
        } while (cVar3 != '\0');
      }
      if (iVar8 < 1) {
                    /* catch() { ... } // from try @ 0099e42c with catch @ 0099e3e8
                       catch() { ... } // from try @ 0099e4a4 with catch @ 0099e3e8
                       catch() { ... } // from try @ 0099e4b0 with catch @ 0099e3e8 */
        operator_delete(local_38 + -0x18);
        if (!bVar5) break;
        goto LAB_0099e240;
      }
    }
  } while (bVar5);
  plVar1 = local_20;
  plVar10 = local_18;
  plVar13 = local_18;
  if (bVar6) {
                    /* try { // try from 0099e324 to 00a9e327 has its CatchHandler @ 0099e37c */
    FUN_01213670();
    plVar7 = local_18;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099e0ac with catch @ 0099e32c
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e244 with catch @ 0099e32c
                        */
    plVar15 = local_20;
    plVar10 = local_18;
    if (local_20 != local_18) {
      do {
        FUN_01211fcc();
        plVar15 = plVar15 + 1;
        plVar1 = local_20;
        plVar10 = local_18;
        plVar13 = local_18;
      } while (plVar7 != plVar15);
      goto joined_r0x0099e35c;
    }
  }
  else {
joined_r0x0099e35c:
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099de5c with catch @ 0099e35c
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e2a8 with catch @ 0099e35c
                        */
    for (; plVar15 = local_18, bVar6 = plVar1 != local_18, local_18 = plVar13, bVar6;
        plVar1 = plVar1 + 1) {
                    /* try { // try from 0099e378 to 00a9e37b has its CatchHandler @ 0099dd48 */
      lVar9 = *plVar1;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099e324 with catch @ 0099e37c
                        */
      if ((undefined *)(lVar9 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 0099e390 to 00a9e393 has its CatchHandler @ 0099dd48 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(lVar9 + -8);
                    /* catch() { ... } // from try @ 0099e5e4 with catch @ 0099e630 */
          *(int *)(lVar9 + -8) = iVar8 + -1;
        }
        else {
          piVar12 = (int *)(lVar9 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar6 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar6) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar8 < 1) {
          operator_delete((undefined *)(lVar9 + -0x18));
        }
      }
      plVar10 = local_20;
      plVar13 = local_18;
      local_18 = plVar15;
    }
  }
  if (plVar10 != (long *)0x0) {
    operator_delete(plVar10);
  }
LAB_0099e178:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}


/* SYMBOL _ZNK7cocos2d16FileUtilsAndroid14getNewFilenameERKSs @ 0099e120 type=Label */

/* cocos2d::FileUtilsAndroid::getNewFilename(std::string const&) const */

void __thiscall cocos2d::FileUtilsAndroid::getNewFilename(FileUtilsAndroid *this,string *param_1)

{
  long *plVar1;
  undefined *puVar2;
  char cVar3;
  bool bVar4;
  bool bVar5;
  bool bVar6;
  long *plVar7;
  int iVar8;
  long lVar9;
  long *plVar10;
  long lVar11;
  int *piVar12;
  long *plVar13;
  ulong uVar14;
  long *in_x8;
  long *plVar15;
  ulong uVar16;
  undefined *local_38;
  long local_30;
  long local_28;
  long *local_20;
  long *local_18;
  long *local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FileUtils::getNewFilename((string *)this);
  lVar9 = FUN_012125d4();
  if (0xfffffffffffffffd < lVar9 - 1U) goto LAB_0099e178;
  local_20 = (long *)0x0;
  local_18 = (long *)0x0;
  local_10 = (long *)0x0;
  plVar10 = operator_new(0x18);
  plVar1 = plVar10 + 3;
  puVar2 = PTR_DAT_017191c0 + 0x18;
  *plVar10 = (long)puVar2;
  if (plVar10 == (long *)0xfffffffffffffff8) {
    plVar13 = (long *)&DAT_00000008;
                    /* try { // try from 0099e640 to 00a9e643 has its CatchHandler @ 0099e580 */
LAB_0099e1f4:
    *plVar13 = (long)(PTR_DAT_017191c0 + 0x18);
  }
  else {
    plVar10[1] = (long)puVar2;
    plVar13 = plVar10 + 2;
    if (plVar13 != (long *)0x0) goto LAB_0099e1f4;
  }
  local_20 = plVar10;
  plVar15 = plVar1;
  local_10 = plVar1;
  local_18 = plVar1;
  plVar13 = plVar10;
  if ((long)plVar1 - (long)plVar10 >> 3 != 0) {
                    /* try { // try from 0099e5bc to 00a9e5bf has its CatchHandler @ 0099e580 */
    for (; plVar15 = plVar10, plVar1 != plVar13; plVar13 = plVar13 + 1) {
      lVar9 = *plVar13;
                    /* try { // try from 0099e5e4 to 00a9e5e7 has its CatchHandler @ 0099e630 */
      if ((undefined *)(lVar9 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(lVar9 + -8);
          *(int *)(lVar9 + -8) = iVar8 + -1;
        }
        else {
                    /* catch() { ... } // from try @ 0099e5c4 with catch @ 0099e5fc */
          piVar12 = (int *)(lVar9 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar6 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar6) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar8 < 1) {
          operator_delete((undefined *)(lVar9 + -0x18));
        }
      }
    }
  }
  local_18 = plVar15;
  uVar16 = 0;
  bVar6 = false;
LAB_0099e240:
  do {
                    /* try { // try from 0099e244 to 00a9e26b has its CatchHandler @ 0099e32c */
    lVar9 = FUN_0121282c();
    local_38 = PTR_DAT_017191c0 + 0x18;
    if (lVar9 == -1) {
      uVar14 = *(ulong *)(*in_x8 + -0x18);
                    /* catch() { ... } // from try @ 0099e434 with catch @ 0099e470 */
      if (uVar14 < uVar16) {
                    /* catch() { ... } // from try @ 0099e6a4 with catch @ 0099e6dc */
                    /* WARNING: Subroutine does not return */
        FUN_0120f508("%s: __pos (which is %zu) > this->size() (which is %zu)","basic_string::substr"
                     ,uVar16,uVar14);
      }
      FUN_0121113c(&local_30);
      FUN_0121258c((string *)&local_38,&local_30);
                    /* catch() { ... } // from try @ 0099e454 with catch @ 0099e494 */
      if ((undefined *)(local_30 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 0099e4b0 to 00a9e4b3 has its CatchHandler @ 0099e3e8 */
                    /* catch() { ... } // from try @ 0099e4f8 with catch @ 0099e4b4
                       catch() { ... } // from try @ 0099e570 with catch @ 0099e4b4
                       catch() { ... } // from try @ 0099e57c with catch @ 0099e4b4 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(local_30 + -8);
          *(int *)(local_30 + -8) = iVar8 + -1;
        }
        else {
          piVar12 = (int *)(local_30 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar5 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar5) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar8 < 1) {
          bVar5 = false;
          operator_delete((undefined *)(local_30 + -0x18));
          goto LAB_0099e2b4;
        }
      }
                    /* try { // try from 0099e4a4 to 00a9e4a7 has its CatchHandler @ 0099e3e8 */
      bVar5 = false;
    }
    else {
      uVar14 = *(ulong *)(*in_x8 + -0x18);
                    /* try { // try from 0099e27c to 00a9e28b has its CatchHandler @ 0099dd48 */
      if (uVar14 < uVar16) {
                    /* try { // try from 0099e65c to 00a9e65f has its CatchHandler @ 0099e580 */
                    /* catch() { ... } // from try @ 0099e69c with catch @ 0099e660
                       catch() { ... } // from try @ 0099e720 with catch @ 0099e660
                       catch() { ... } // from try @ 0099e73c with catch @ 0099e660 */
                    /* WARNING: Subroutine does not return */
        FUN_0120f508("%s: __pos (which is %zu) > this->size() (which is %zu)","basic_string::substr"
                     ,uVar16,uVar14);
      }
      FUN_0121113c(&local_28);
      FUN_0121258c((string *)&local_38,&local_28);
                    /* try { // try from 0099e2a8 to 00a9e2b7 has its CatchHandler @ 0099e35c */
      if ((undefined *)(local_28 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(local_28 + -8);
                    /* try { // try from 0099e57c to 00a9e57f has its CatchHandler @ 0099e4b4 */
                    /* catch() { ... } // from try @ 0099e5bc with catch @ 0099e580
                       catch() { ... } // from try @ 0099e640 with catch @ 0099e580
                       catch() { ... } // from try @ 0099e65c with catch @ 0099e580 */
          *(int *)(local_28 + -8) = iVar8 + -1;
        }
        else {
          piVar12 = (int *)(local_28 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar5 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar5) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar8 < 1) {
          operator_delete((undefined *)(local_28 + -0x18));
        }
      }
      bVar5 = true;
    }
LAB_0099e2b4:
    lVar11 = (long)local_18 - (long)local_20 >> 3;
    if (lVar11 == 0) {
      if (local_10 == local_18) {
LAB_0099e450:
                    /* try { // try from 0099e454 to 00a9e457 has its CatchHandler @ 0099e494 */
        std::vector<std::string,std::allocator<std::string>>::
        _M_emplace_back_aux<std::string_const&>
                  ((vector<std::string,std::allocator<std::string>> *)&local_20,(string *)&local_38)
        ;
      }
      else {
LAB_0099e2d8:
        if (local_18 != (long *)0x0) {
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099de40 with catch @ 0099e2e0
                        */
          FUN_01214ee0(local_18,(string *)&local_38);
        }
        local_18 = local_18 + 1;
      }
    }
    else {
                    /* try { // try from 0099e42c to 00a9e42f has its CatchHandler @ 0099e3e8 */
                    /* try { // try from 0099e434 to 00a9e437 has its CatchHandler @ 0099e470 */
      iVar8 = FUN_01213398(local_20 + lVar11 + -1,&DAT_012b7230);
                    /* try { // try from 0099e570 to 00a9e573 has its CatchHandler @ 0099e4b4 */
      if ((iVar8 == 0) ||
         ((iVar8 = FUN_01213398((string *)&local_38,&DAT_012b7230), iVar8 != 0 &&
          (iVar8 = FUN_01213398((string *)&local_38,&DAT_012b7238), iVar8 != 0)))) {
        if (local_10 == local_18) goto LAB_0099e450;
        goto LAB_0099e2d8;
      }
                    /* try { // try from 0099e4f8 to 00a9e4fb has its CatchHandler @ 0099e4b4 */
                    /* try { // try from 0099e500 to 00a9e503 has its CatchHandler @ 0099e53c */
      lVar11 = local_18[-1];
      if ((undefined *)(lVar11 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 0099e520 to 00a9e523 has its CatchHandler @ 0099e560 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(lVar11 + -8);
          *(int *)(lVar11 + -8) = iVar8 + -1;
        }
        else {
          piVar12 = (int *)(lVar11 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar6 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar6) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
                    /* catch() { ... } // from try @ 0099e500 with catch @ 0099e53c */
        if (iVar8 < 1) {
          bVar6 = true;
          local_18 = local_18 + -1;
          operator_delete((undefined *)(lVar11 + -0x18));
          goto LAB_0099e2f0;
        }
      }
      bVar6 = true;
      local_18 = local_18 + -1;
    }
LAB_0099e2f0:
    uVar16 = lVar9 + 1;
    if (local_38 + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar8 = *(int *)(local_38 + -8);
        *(int *)(local_38 + -8) = iVar8 + -1;
                    /* catch() { ... } // from try @ 0099e520 with catch @ 0099e560 */
      }
      else {
        piVar12 = (int *)(local_38 + -8);
        do {
          iVar8 = *piVar12;
          cVar3 = '\x01';
          bVar4 = (bool)ExclusiveMonitorPass(piVar12,0x10);
          if (bVar4) {
            *piVar12 = iVar8 + -1;
            cVar3 = ExclusiveMonitorsStatus();
          }
        } while (cVar3 != '\0');
      }
      if (iVar8 < 1) {
                    /* catch() { ... } // from try @ 0099e42c with catch @ 0099e3e8
                       catch() { ... } // from try @ 0099e4a4 with catch @ 0099e3e8
                       catch() { ... } // from try @ 0099e4b0 with catch @ 0099e3e8 */
        operator_delete(local_38 + -0x18);
        if (!bVar5) break;
        goto LAB_0099e240;
      }
    }
  } while (bVar5);
  plVar1 = local_20;
  plVar10 = local_18;
  plVar13 = local_18;
  if (bVar6) {
                    /* try { // try from 0099e324 to 00a9e327 has its CatchHandler @ 0099e37c */
    FUN_01213670();
    plVar7 = local_18;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099e0ac with catch @ 0099e32c
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e244 with catch @ 0099e32c
                        */
    plVar15 = local_20;
    plVar10 = local_18;
    if (local_20 != local_18) {
      do {
        FUN_01211fcc();
        plVar15 = plVar15 + 1;
        plVar1 = local_20;
        plVar10 = local_18;
        plVar13 = local_18;
      } while (plVar7 != plVar15);
      goto joined_r0x0099e35c;
    }
  }
  else {
joined_r0x0099e35c:
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099de5c with catch @ 0099e35c
                       catch(type#1 @ 00000000) { ... } // from try @ 0099e2a8 with catch @ 0099e35c
                        */
    for (; plVar15 = local_18, bVar6 = plVar1 != local_18, local_18 = plVar13, bVar6;
        plVar1 = plVar1 + 1) {
                    /* try { // try from 0099e378 to 00a9e37b has its CatchHandler @ 0099dd48 */
      lVar9 = *plVar1;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 0099e324 with catch @ 0099e37c
                        */
      if ((undefined *)(lVar9 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 0099e390 to 00a9e393 has its CatchHandler @ 0099dd48 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(lVar9 + -8);
                    /* catch() { ... } // from try @ 0099e5e4 with catch @ 0099e630 */
          *(int *)(lVar9 + -8) = iVar8 + -1;
        }
        else {
          piVar12 = (int *)(lVar9 + -8);
          do {
            iVar8 = *piVar12;
            cVar3 = '\x01';
            bVar6 = (bool)ExclusiveMonitorPass(piVar12,0x10);
            if (bVar6) {
              *piVar12 = iVar8 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar8 < 1) {
          operator_delete((undefined *)(lVar9 + -0x18));
        }
      }
      plVar10 = local_20;
      plVar13 = local_18;
      local_18 = plVar15;
    }
  }
  if (plVar10 != (long *)0x0) {
    operator_delete(plVar10);
  }
LAB_0099e178:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}


/* SYMBOL lua_cocos2dx_FileUtils_getNewFilename @ 00a33c58 type=Function */

/* lua_cocos2dx_FileUtils_getNewFilename(lua_State*) */

void lua_cocos2dx_FileUtils_getNewFilename(lua_State *param_1)

{
  bool bVar1;
  char cVar2;
  int iVar3;
  long *plVar4;
  int *piVar5;
  undefined8 uVar6;
  undefined *local_18;
  long local_10;
  long local_8;
  
                    /* catch() { ... } // from try @ 00a33324 with catch @ 00a33c58 */
                    /* catch() { ... } // from try @ 00a33338 with catch @ 00a33c7c */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  plVar4 = (long *)tolua_tousertype(param_1,1,0);
  iVar3 = lua_gettop(param_1);
                    /* catch() { ... } // from try @ 00a33340 with catch @ 00a33ca0 */
  if (iVar3 + -1 != 1) {
    uVar6 = 0;
                    /* catch() { ... } // from try @ 00a334b0 with catch @ 00a33cc0 */
    luaL_error(param_1,"%s has wrong number of arguments: %d, was expecting %d \n",
               "cc.FileUtils:getNewFilename",iVar3 + -1,1);
    goto LAB_00a33cc4;
  }
                    /* catch() { ... } // from try @ 00a334d8 with catch @ 00a33d00 */
  local_18 = PTR_DAT_017191c0 + 0x18;
  cVar2 = luaval_to_std_string(param_1,2,(string *)&local_18,"cc.FileUtils:getNewFilename");
                    /* catch() { ... } // from try @ 00a334ec with catch @ 00a33d20 */
  if (cVar2 == '\0') {
    tolua_error(param_1,"invalid arguments in function \'lua_cocos2dx_FileUtils_getNewFilename\'",0)
    ;
    uVar6 = 0;
  }
  else {
    (**(code **)(*plVar4 + 0x1d8))(&local_10,plVar4,(string *)&local_18);
                    /* catch() { ... } // from try @ 00a33760 with catch @ 00a33da0 */
    lua_pushlstring(param_1,local_10,*(undefined8 *)(local_10 + -0x18));
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar3 + -1;
      }
      else {
        piVar5 = (int *)(local_10 + -8);
        do {
          iVar3 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
                    /* catch() { ... } // from try @ 00a33788 with catch @ 00a33de4 */
        } while (cVar2 != '\0');
      }
      if (iVar3 < 1) {
        uVar6 = 1;
        operator_delete((undefined *)(local_10 + -0x18));
        goto LAB_00a33d3c;
      }
    }
    uVar6 = 1;
                    /* catch() { ... } // from try @ 00a33774 with catch @ 00a33dc4 */
  }
LAB_00a33d3c:
                    /* catch() { ... } // from try @ 00a334fc with catch @ 00a33d40 */
  if (local_18 + -0x18 != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_18 + -8);
                    /* catch() { ... } // from try @ 00a33794 with catch @ 00a33e04 */
      *(int *)(local_18 + -8) = iVar3 + -1;
    }
    else {
      piVar5 = (int *)(local_18 + -8);
      do {
                    /* catch() { ... } // from try @ 00a33504 with catch @ 00a33d60 */
        iVar3 = *piVar5;
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar1) {
          *piVar5 = iVar3 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete(local_18 + -0x18);
                    /* catch() { ... } // from try @ 00a3374c with catch @ 00a33d80 */
    }
  }
LAB_00a33cc4:
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* catch() { ... } // from try @ 00a334c4 with catch @ 00a33ce0 */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar6);
}


/* SYMBOL _Z37lua_cocos2dx_FileUtils_getNewFilenameP9lua_State @ 00a33c58 type=Label */

/* lua_cocos2dx_FileUtils_getNewFilename(lua_State*) */

void lua_cocos2dx_FileUtils_getNewFilename(lua_State *param_1)

{
  bool bVar1;
  char cVar2;
  int iVar3;
  long *plVar4;
  int *piVar5;
  undefined8 uVar6;
  undefined *local_18;
  long local_10;
  long local_8;
  
                    /* catch() { ... } // from try @ 00a33324 with catch @ 00a33c58 */
                    /* catch() { ... } // from try @ 00a33338 with catch @ 00a33c7c */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  plVar4 = (long *)tolua_tousertype(param_1,1,0);
  iVar3 = lua_gettop(param_1);
                    /* catch() { ... } // from try @ 00a33340 with catch @ 00a33ca0 */
  if (iVar3 + -1 != 1) {
    uVar6 = 0;
                    /* catch() { ... } // from try @ 00a334b0 with catch @ 00a33cc0 */
    luaL_error(param_1,"%s has wrong number of arguments: %d, was expecting %d \n",
               "cc.FileUtils:getNewFilename",iVar3 + -1,1);
    goto LAB_00a33cc4;
  }
                    /* catch() { ... } // from try @ 00a334d8 with catch @ 00a33d00 */
  local_18 = PTR_DAT_017191c0 + 0x18;
  cVar2 = luaval_to_std_string(param_1,2,(string *)&local_18,"cc.FileUtils:getNewFilename");
                    /* catch() { ... } // from try @ 00a334ec with catch @ 00a33d20 */
  if (cVar2 == '\0') {
    tolua_error(param_1,"invalid arguments in function \'lua_cocos2dx_FileUtils_getNewFilename\'",0)
    ;
    uVar6 = 0;
  }
  else {
    (**(code **)(*plVar4 + 0x1d8))(&local_10,plVar4,(string *)&local_18);
                    /* catch() { ... } // from try @ 00a33760 with catch @ 00a33da0 */
    lua_pushlstring(param_1,local_10,*(undefined8 *)(local_10 + -0x18));
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar3 + -1;
      }
      else {
        piVar5 = (int *)(local_10 + -8);
        do {
          iVar3 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar3 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
                    /* catch() { ... } // from try @ 00a33788 with catch @ 00a33de4 */
        } while (cVar2 != '\0');
      }
      if (iVar3 < 1) {
        uVar6 = 1;
        operator_delete((undefined *)(local_10 + -0x18));
        goto LAB_00a33d3c;
      }
    }
    uVar6 = 1;
                    /* catch() { ... } // from try @ 00a33774 with catch @ 00a33dc4 */
  }
LAB_00a33d3c:
                    /* catch() { ... } // from try @ 00a334fc with catch @ 00a33d40 */
  if (local_18 + -0x18 != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_18 + -8);
                    /* catch() { ... } // from try @ 00a33794 with catch @ 00a33e04 */
      *(int *)(local_18 + -8) = iVar3 + -1;
    }
    else {
      piVar5 = (int *)(local_18 + -8);
      do {
                    /* catch() { ... } // from try @ 00a33504 with catch @ 00a33d60 */
        iVar3 = *piVar5;
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar1) {
          *piVar5 = iVar3 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete(local_18 + -0x18);
                    /* catch() { ... } // from try @ 00a3374c with catch @ 00a33d80 */
    }
  }
LAB_00a33cc4:
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* catch() { ... } // from try @ 00a334c4 with catch @ 00a33ce0 */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar6);
}


/* SYMBOL cocos2d::FileUtils::getNewFilename @ 00f645cc type=Function */

/* cocos2d::FileUtils::getNewFilename(std::string const&) const */

void cocos2d::FileUtils::getNewFilename(string *param_1)

{
  char cVar1;
  bool bVar2;
  ulong uVar3;
  ulong uVar4;
  long *plVar5;
  string *in_x1;
  long lVar6;
  ulong uVar7;
  int *piVar8;
  int iVar9;
  long *in_x8;
  long local_10;
  
  lVar6 = *(long *)PTR___stack_chk_guard_01721c30;
  *in_x8 = (long)(PTR_DAT_017191c0 + 0x18);
  uVar4 = FUN_011c78ec(*(long *)in_x1,*(undefined8 *)(*(long *)in_x1 + -0x18),0xc70f6907);
  uVar7 = *(ulong *)(param_1 + 0x10);
  uVar3 = 0;
  if (uVar7 != 0) {
    uVar3 = uVar4 / uVar7;
  }
  plVar5 = (long *)std::
                   _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                   ::_M_find_before_node
                             ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                               *)(param_1 + 8),uVar4 - uVar3 * uVar7,in_x1,uVar4);
  if ((plVar5 == (long *)0x0) || (*plVar5 == 0)) {
    FUN_01215060();
  }
  else {
    cocos2d::Value::asString();
    FUN_0121258c();
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar9 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar9 + -1;
      }
      else {
        piVar8 = (int *)(local_10 + -8);
        do {
          iVar9 = *piVar8;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
          if (bVar2) {
            *piVar8 = iVar9 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar9 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
  }
  if (lVar6 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* SYMBOL _ZNK7cocos2d9FileUtils14getNewFilenameERKSs @ 00f645cc type=Label */

/* cocos2d::FileUtils::getNewFilename(std::string const&) const */

void cocos2d::FileUtils::getNewFilename(string *param_1)

{
  char cVar1;
  bool bVar2;
  ulong uVar3;
  ulong uVar4;
  long *plVar5;
  string *in_x1;
  long lVar6;
  ulong uVar7;
  int *piVar8;
  int iVar9;
  long *in_x8;
  long local_10;
  
  lVar6 = *(long *)PTR___stack_chk_guard_01721c30;
  *in_x8 = (long)(PTR_DAT_017191c0 + 0x18);
  uVar4 = FUN_011c78ec(*(long *)in_x1,*(undefined8 *)(*(long *)in_x1 + -0x18),0xc70f6907);
  uVar7 = *(ulong *)(param_1 + 0x10);
  uVar3 = 0;
  if (uVar7 != 0) {
    uVar3 = uVar4 / uVar7;
  }
  plVar5 = (long *)std::
                   _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                   ::_M_find_before_node
                             ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                               *)(param_1 + 8),uVar4 - uVar3 * uVar7,in_x1,uVar4);
  if ((plVar5 == (long *)0x0) || (*plVar5 == 0)) {
    FUN_01215060();
  }
  else {
    cocos2d::Value::asString();
    FUN_0121258c();
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar9 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar9 + -1;
      }
      else {
        piVar8 = (int *)(local_10 + -8);
        do {
          iVar9 = *piVar8;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
          if (bVar2) {
            *piVar8 = iVar9 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar9 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
  }
  if (lVar6 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* SYMBOL s_decryptKey_012b7218 @ 012b7218 type=Label */

/* SYMBOL s_cc.FileUtils:getNewFilename_012da688 @ 012da688 type=Label */

/* SYMBOL s_tils:getNewFilename_012da688+8 @ 012da690 type=Label */

/* SYMBOL s_ocos2dx_FileUtils_getNewFilename_012da6a8+0x24 @ 012da6cc type=Label */

/* SYMBOL s_getNewFilename_012dd180 @ 012dd180 type=Label */

/* SYMBOL PTR_lua_cocos2dx_FileUtils_getNewFilename_0171a550 @ 0171a550 type=Label */
