/* Targets: 2, callers: 1 */

/* === applicationDidFinishLaunching @ 008217bc === */

/* AppDelegate::applicationDidFinishLaunching() */

void AppDelegate::applicationDidFinishLaunching(void)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  long lVar4;
  ScriptEngineProtocol *pSVar5;
  ScriptEngineManager *this;
  FileUtils *pFVar6;
  long *plVar7;
  int *piVar8;
  lua_State *plVar9;
  undefined8 uVar10;
  long *plVar11;
  undefined1 auStack_20 [8];
  long local_18;
  long local_10;
  long local_8;
  
                    /* try { // try from 008217d0 to 009217d3 has its CatchHandler @ 008248ec */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* try { // try from 008217e8 to 009217eb has its CatchHandler @ 008248e0 */
  cocos2d::Director::getInstance();
  cocos2d::Director::setAnimationInterval(DAT_00821ed8);
  lVar4 = cocos2d::Director::getInstance();
  *(undefined1 *)(lVar4 + 0x181) = 0;
                    /* try { // try from 00821800 to 00921803 has its CatchHandler @ 008248d4 */
                    /* try { // try from 00821818 to 0092181b has its CatchHandler @ 008248c8 */
  cocos2d::ZipUtils::setPvrEncryptionKey(0xcb026661,0xc5a39c34,0x3cca3ca,0x2c774635);
  pSVar5 = (ScriptEngineProtocol *)cocos2d::LuaEngine::getInstance();
  this = (ScriptEngineManager *)cocos2d::ScriptEngineManager::getInstance();
                    /* try { // try from 00821830 to 00921833 has its CatchHandler @ 008248bc */
  cocos2d::ScriptEngineManager::setScriptEngine(this,pSVar5);
  lua_module_register(*(lua_State **)(*(long *)(pSVar5 + 8) + 0x28));
  lVar4 = cocos2d::LuaEngine::getInstance();
                    /* try { // try from 00821848 to 0092184b has its CatchHandler @ 008248b0 */
  plVar9 = *(lua_State **)(*(long *)(lVar4 + 8) + 0x28);
  register_avalon_net_manager(plVar9);
  register_avalon_util(plVar9);
                    /* try { // try from 00821860 to 00921863 has its CatchHandler @ 008248a4 */
  register_avalon_random_generater(plVar9);
  register_avalon_res_manager(plVar9);
  register_avalon_animation(plVar9);
                    /* try { // try from 00821878 to 0092187b has its CatchHandler @ 00824898 */
  register_avalon_sdkbox(plVar9);
  register_avalon_ping_util(plVar9);
  register_avalon_httpdns_util(plVar9);
                    /* try { // try from 00821890 to 00921893 has its CatchHandler @ 0082488c */
  register_avalon_agora_util(plVar9);
  luaopen_zlib(plVar9);
  plVar11 = *(long **)(pSVar5 + 8);
                    /* try { // try from 008218a8 to 009218ab has its CatchHandler @ 00824880 */
                    /* try { // try from 008218c0 to 009218c3 has its CatchHandler @ 00824874 */
  (**(code **)(*plVar11 + 0xe8))(plVar11,"avalon_cave_online",0x12,"avalon_cave_1106",0x10);
  pFVar6 = (FileUtils *)cocos2d::FileUtils::getInstance();
  plVar7 = (long *)cocos2d::FileUtils::getInstance();
                    /* try { // try from 008218d8 to 009218db has its CatchHandler @ 00824868 */
  (**(code **)(*plVar7 + 0xa0))(&local_18);
                    /* try { // try from 008218f0 to 009218f3 has its CatchHandler @ 0082485c */
  plVar7 = (long *)FUN_0121218c(&local_18,"CaveOnline/Hotfix/src",0x15);
                    /* try { // try from 00821908 to 0092190b has its CatchHandler @ 00824850 */
  local_10 = *plVar7;
                    /* try { // try from 00821920 to 00921923 has its CatchHandler @ 00824844 */
  *plVar7 = (long)(PTR_DAT_017191c0 + 0x18);
  cocos2d::FileUtils::addSearchPath(pFVar6,(string *)&local_10,true);
                    /* try { // try from 00821938 to 0092193b has its CatchHandler @ 00824838 */
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
      *(int *)(local_10 + -8) = iVar3 + -1;
    }
    else {
                    /* try { // try from 00821ba8 to 00921bab has its CatchHandler @ 00824700 */
      piVar8 = (int *)(local_10 + -8);
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
                    /* try { // try from 00821bc0 to 00921bc3 has its CatchHandler @ 008246f4 */
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
                    /* try { // try from 00821950 to 00921953 has its CatchHandler @ 0082482c */
  if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00821bd8 to 00921bdb has its CatchHandler @ 008246e8 */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_18 + -8);
      *(int *)(local_18 + -8) = iVar3 + -1;
    }
    else {
      piVar8 = (int *)(local_18 + -8);
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
                    /* try { // try from 00821bf0 to 00921bf3 has its CatchHandler @ 008246dc */
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_18 + -0x18));
    }
  }
  pFVar6 = (FileUtils *)cocos2d::FileUtils::getInstance();
  plVar7 = (long *)cocos2d::FileUtils::getInstance();
                    /* try { // try from 00821968 to 0092196b has its CatchHandler @ 00824820 */
  (**(code **)(*plVar7 + 0xa0))(&local_18);
                    /* try { // try from 00821980 to 00921983 has its CatchHandler @ 00824814 */
  plVar7 = (long *)FUN_0121218c(&local_18,"CaveOnline/Hotfix/res",0x15);
                    /* try { // try from 00821998 to 0092199b has its CatchHandler @ 00824808 */
  local_10 = *plVar7;
  *plVar7 = (long)(PTR_DAT_017191c0 + 0x18);
  cocos2d::FileUtils::addSearchPath(pFVar6,(string *)&local_10,true);
                    /* try { // try from 008219b0 to 009219b3 has its CatchHandler @ 008247fc */
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00821c08 to 00921c0b has its CatchHandler @ 008246d0 */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
      *(int *)(local_10 + -8) = iVar3 + -1;
                    /* try { // try from 00821dd0 to 00921dd3 has its CatchHandler @ 008245ec */
    }
    else {
      piVar8 = (int *)(local_10 + -8);
      do {
        iVar3 = *piVar8;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
        if (bVar2) {
          *piVar8 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
                    /* try { // try from 00821c20 to 00921c23 has its CatchHandler @ 008246c4 */
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
                    /* try { // try from 008219c8 to 009219cb has its CatchHandler @ 008247f0 */
  if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00821c38 to 00921c3b has its CatchHandler @ 008246b8 */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_18 + -8);
      *(int *)(local_18 + -8) = iVar3 + -1;
                    /* try { // try from 00821e00 to 00921e03 has its CatchHandler @ 008245d4 */
    }
    else {
      piVar8 = (int *)(local_18 + -8);
      do {
        iVar3 = *piVar8;
                    /* try { // try from 00821c50 to 00921c53 has its CatchHandler @ 008246ac */
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
        if (bVar2) {
          *piVar8 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_18 + -0x18));
                    /* try { // try from 00821c68 to 00921c6b has its CatchHandler @ 008246a0 */
    }
  }
  pFVar6 = (FileUtils *)cocos2d::FileUtils::getInstance();
  plVar7 = (long *)cocos2d::FileUtils::getInstance();
                    /* try { // try from 008219e0 to 009219e3 has its CatchHandler @ 008247e4 */
  (**(code **)(*plVar7 + 0xa0))(&local_18);
                    /* try { // try from 008219f8 to 009219fb has its CatchHandler @ 008247d8 */
  plVar7 = (long *)FUN_0121218c(&local_18,"CaveOnline/Hotfix/res/Resource",0x1e);
                    /* try { // try from 00821a10 to 00921a13 has its CatchHandler @ 008247cc */
  local_10 = *plVar7;
  *plVar7 = (long)(PTR_DAT_017191c0 + 0x18);
                    /* try { // try from 00821a28 to 00921a2b has its CatchHandler @ 008247c0 */
  cocos2d::FileUtils::addSearchPath(pFVar6,(string *)&local_10,true);
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
                    /* try { // try from 00821de8 to 00921deb has its CatchHandler @ 008245e0 */
      *(int *)(local_10 + -8) = iVar3 + -1;
    }
    else {
      piVar8 = (int *)(local_10 + -8);
      do {
        iVar3 = *piVar8;
                    /* try { // try from 00821c80 to 00921c83 has its CatchHandler @ 00824694 */
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
        if (bVar2) {
          *piVar8 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
                    /* try { // try from 00821c98 to 00921c9b has its CatchHandler @ 00824688 */
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_18 + -8);
      *(int *)(local_18 + -8) = iVar3 + -1;
                    /* try { // try from 00821da0 to 00921da3 has its CatchHandler @ 00824604 */
    }
    else {
                    /* try { // try from 00821cb0 to 00921cb3 has its CatchHandler @ 0082467c */
      piVar8 = (int *)(local_18 + -8);
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
                    /* try { // try from 00821cc8 to 00921ccb has its CatchHandler @ 00824670 */
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_18 + -0x18));
    }
  }
                    /* try { // try from 00821a58 to 00921a5b has its CatchHandler @ 008247a8 */
  pFVar6 = (FileUtils *)cocos2d::FileUtils::getInstance();
                    /* try { // try from 00821a70 to 00921a73 has its CatchHandler @ 0082479c */
  FUN_01211570((string *)&local_10,"src/64bit",auStack_20);
  cocos2d::FileUtils::addSearchPath(pFVar6,(string *)&local_10,false);
                    /* try { // try from 00821a88 to 00921a8b has its CatchHandler @ 00824790 */
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00821ce0 to 00921ce3 has its CatchHandler @ 00824664 */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
                    /* try { // try from 00821d88 to 00921d8b has its CatchHandler @ 00824610 */
      *(int *)(local_10 + -8) = iVar3 + -1;
    }
    else {
      piVar8 = (int *)(local_10 + -8);
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
                    /* try { // try from 00821cf8 to 00921cfb has its CatchHandler @ 00824658 */
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  pFVar6 = (FileUtils *)cocos2d::FileUtils::getInstance();
                    /* try { // try from 00821aa0 to 00921aa3 has its CatchHandler @ 00824784 */
  FUN_01211570((string *)&local_10,&DAT_012845e0,auStack_20);
                    /* try { // try from 00821ab8 to 00921abb has its CatchHandler @ 00824778 */
  cocos2d::FileUtils::addSearchPath(pFVar6,(string *)&local_10,false);
                    /* try { // try from 00821ad0 to 00921ad3 has its CatchHandler @ 0082476c */
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00821d10 to 00921d13 has its CatchHandler @ 0082464c */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
                    /* try { // try from 00821db8 to 00921dbb has its CatchHandler @ 008245f8 */
      *(int *)(local_10 + -8) = iVar3 + -1;
    }
    else {
      piVar8 = (int *)(local_10 + -8);
      do {
        iVar3 = *piVar8;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
        if (bVar2) {
          *piVar8 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
                    /* try { // try from 00821d28 to 00921d2b has its CatchHandler @ 00824640 */
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  pFVar6 = (FileUtils *)cocos2d::FileUtils::getInstance();
                    /* try { // try from 00821ae8 to 00921aeb has its CatchHandler @ 00824760 */
  FUN_01211570((string *)&local_10,&DAT_012845e8,auStack_20);
                    /* try { // try from 00821b00 to 00921b03 has its CatchHandler @ 00824754 */
  cocos2d::FileUtils::addSearchPath(pFVar6,(string *)&local_10,false);
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00821d40 to 00921d43 has its CatchHandler @ 00824634 */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
      *(int *)(local_10 + -8) = iVar3 + -1;
    }
    else {
      piVar8 = (int *)(local_10 + -8);
      do {
        iVar3 = *piVar8;
                    /* try { // try from 00821d58 to 00921d5b has its CatchHandler @ 00824628 */
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
        if (bVar2) {
          *piVar8 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
                    /* try { // try from 00821d70 to 00921d73 has its CatchHandler @ 0082461c */
    }
  }
                    /* try { // try from 00821b18 to 00921b1b has its CatchHandler @ 00824748 */
  uVar10 = 0;
                    /* try { // try from 00821b30 to 00921b33 has its CatchHandler @ 0082473c */
  iVar3 = (**(code **)(*(long *)pSVar5 + 0x60))(pSVar5,"require \'main\'");
  if (iVar3 == 0) {
    uVar10 = 1;
                    /* try { // try from 00821b78 to 00921b7b has its CatchHandler @ 00824718 */
    iVar3 = cocos2d::LuaStack::loadChunksFromZIP((char *)plVar11);
    if (iVar3 != 0) {
                    /* try { // try from 00821b90 to 00921b93 has its CatchHandler @ 0082470c */
      (**(code **)(*plVar11 + 0x40))
                (plVar11,
                 "POCO_INIT_SCHEDULER_ID = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()local poco = require \'poco.poco_manager\'\npoco:init_server(15004)\ncc.Director:getInstance():getScheduler():unscheduleScriptEntry(POCO_INIT_SCHEDULER_ID)\nend, 1, false)"
                );
    }
  }
                    /* try { // try from 00821b48 to 00921b4b has its CatchHandler @ 00824730 */
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar10);
  }
                    /* try { // try from 00821b60 to 00921b63 has its CatchHandler @ 00824724 */
  return;
}

