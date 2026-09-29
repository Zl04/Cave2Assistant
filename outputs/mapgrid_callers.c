/* Targets: 102, callers: 75 */

/* === parse @ 007f0554 === */

/* Avalon::MapGrid::parse(std::string const&) */

void Avalon::MapGrid::parse(string *param_1)

{
  uint uVar1;
  int iVar2;
  int iVar3;
  int iVar4;
  char cVar5;
  Image *this;
  void *pvVar6;
  int in_w4;
  int iVar7;
  MapGrid *this_00;
  float local_18;
  float local_14;
  byte local_10;
  byte local_f;
  byte local_e;
  char local_d;
  long local_8;
  
  iVar2 = DAT_0172500c;
                    /* try { // try from 007f0554 to 008f0557 has its CatchHandler @ 007f276c */
  iVar4 = DAT_01725008;
                    /* try { // try from 007f056c to 008f056f has its CatchHandler @ 007f2760 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* try { // try from 007f0584 to 008f0587 has its CatchHandler @ 007f2754 */
                    /* try { // try from 007f059c to 008f059f has its CatchHandler @ 007f2748 */
  this = operator_new(0x160);
  cocos2d::Image::Image(this);
                    /* try { // try from 007f05b4 to 008f05b7 has its CatchHandler @ 007f273c */
  cVar5 = cocos2d::Image::initWithImageFile(this,param_1);
  if (cVar5 == '\0') {
    pvVar6 = (void *)0x0;
  }
  else {
                    /* try { // try from 007f05cc to 008f05cf has its CatchHandler @ 007f2730 */
    iVar3 = DAT_0172500c * DAT_01725008;
                    /* try { // try from 007f05e4 to 008f05e7 has its CatchHandler @ 007f2724 */
    pvVar6 = operator_new__((long)(iVar3 + 1));
    memset(pvVar6,0x31,(long)iVar3);
                    /* try { // try from 007f05fc to 008f05ff has its CatchHandler @ 007f2718 */
    if (0 < DAT_01725008) {
      iVar7 = 0;
      if (iVar4 < iVar2) {
        iVar2 = iVar4;
      }
                    /* try { // try from 007f0614 to 008f0617 has its CatchHandler @ 007f270c */
      do {
                    /* try { // try from 007f062c to 008f062f has its CatchHandler @ 007f2700 */
        if (0 < DAT_0172500c) {
          this_00 = (MapGrid *)0x0;
          do {
            iVar4 = DAT_0172500c;
                    /* try { // try from 007f0644 to 008f0647 has its CatchHandler @ 007f26f4 */
            coordinateToPosition(this_00,iVar7,0x2c,0x16,in_w4);
                    /* try { // try from 007f065c to 008f065f has its CatchHandler @ 007f26e8 */
                    /* try { // try from 007f0674 to 008f0677 has its CatchHandler @ 007f26dc */
            local_14 = ((float)*(int *)(this + 0x3c) - local_14) - 11.0;
            local_18 = (float)(int)((double)(iVar2 * 0x2c) * 0.5) + local_18;
                    /* try { // try from 007f068c to 008f068f has its CatchHandler @ 007f26d0 */
            getPixelBytes(this,(int)local_18,(int)local_14,&local_10);
                    /* try { // try from 007f06a4 to 008f06a7 has its CatchHandler @ 007f26c4 */
                    /* try { // try from 007f06bc to 008f06bf has its CatchHandler @ 007f26b8 */
            if ((((0xfa < local_10) && (0xfa < local_f)) && (0xfa < local_e)) && (local_d != '\0'))
            {
              *(undefined1 *)((long)pvVar6 + (long)((int)this_00 + iVar7 * iVar4)) = 0x30;
            }
                    /* try { // try from 007f06d4 to 008f06d7 has its CatchHandler @ 007f26ac */
            uVar1 = (int)this_00 + 1;
            this_00 = (MapGrid *)(ulong)uVar1;
          } while ((int)uVar1 < DAT_0172500c);
        }
        iVar7 = iVar7 + 1;
                    /* try { // try from 007f06ec to 008f06ef has its CatchHandler @ 007f26a0 */
      } while (iVar7 < DAT_01725008);
    }
    *(undefined1 *)((long)pvVar6 + (long)iVar3) = 0;
  }
                    /* try { // try from 007f0704 to 008f0707 has its CatchHandler @ 007f2694 */
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 007f071c to 008f071f has its CatchHandler @ 007f2688 */
                    /* try { // try from 007f0734 to 008f0737 has its CatchHandler @ 007f267c */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(pvVar6);
}


/* === lua_register_cocos2dx_Properties @ 00a4a28c === */

/* lua_register_cocos2dx_Properties(lua_State*) */

void lua_register_cocos2dx_Properties(lua_State *param_1)

{
  char cVar1;
  bool bVar2;
  undefined8 uVar3;
  int *piVar4;
  int iVar5;
  undefined1 auStack_28 [16];
  long local_18;
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  tolua_usertype(param_1,&DAT_012d1f68);
  tolua_cclass(param_1,"Properties",&DAT_012d1f68,&DAT_012fc3d8,0);
                    /* catch() { ... } // from try @ 00a49e40 with catch @ 00a4a2fc */
  tolua_beginmodule(param_1,"Properties");
  tolua_function(param_1,"getVariable",PTR_lua_cocos2dx_Properties_getVariable_01723848);
                    /* catch() { ... } // from try @ 00a49e28 with catch @ 00a4a330 */
  tolua_function(param_1,"getString",PTR_lua_cocos2dx_Properties_getString_0171fb28);
                    /* catch() { ... } // from try @ 00a49eac with catch @ 00a4a338 */
                    /* catch() { ... } // from try @ 00a49ec4 with catch @ 00a4a33c */
                    /* catch() { ... } // from try @ 00a4a050 with catch @ 00a4a340 */
                    /* catch() { ... } // from try @ 00a4a038 with catch @ 00a4a344 */
                    /* catch() { ... } // from try @ 00a4a204 with catch @ 00a4a348 */
  tolua_function(param_1,"getLong",PTR_lua_cocos2dx_Properties_getLong_01717228);
                    /* catch() { ... } // from try @ 00a4a1f0 with catch @ 00a4a34c */
                    /* catch() { ... } // from try @ 00a4a268 with catch @ 00a4a350 */
                    /* catch() { ... } // from try @ 00a4a254 with catch @ 00a4a354 */
                    /* catch() { ... } // from try @ 00a49fc0 with catch @ 00a4a358 */
                    /* catch() { ... } // from try @ 00a49fac with catch @ 00a4a35c */
  tolua_function(param_1,"getNamespace",PTR_lua_cocos2dx_Properties_getNamespace_0171f630);
                    /* catch() { ... } // from try @ 00a4a3f8 with catch @ 00a4a370
                       catch() { ... } // from try @ 00a4a5b8 with catch @ 00a4a370
                       catch() { ... } // from try @ 00a4a6bc with catch @ 00a4a370
                       catch() { ... } // from try @ 00a4a8dc with catch @ 00a4a370 */
  tolua_function(param_1,&LAB_012db978,PTR_lua_cocos2dx_Properties_getPath_01719698);
  tolua_function(param_1,"getMat4",PTR_lua_cocos2dx_Properties_getMat4_01722128);
  tolua_function(param_1,"exists",PTR_lua_cocos2dx_Properties_exists_0171d7a8);
  tolua_function(param_1,"setString",PTR_lua_cocos2dx_Properties_setString_017183c0);
  tolua_function(param_1,"getId",PTR_lua_cocos2dx_Properties_getId_017192b8);
  tolua_function(param_1,"rewind",PTR_lua_cocos2dx_Properties_rewind_0171c118);
                    /* try { // try from 00a4a3f8 to 00b4a3fb has its CatchHandler @ 00a4a370 */
  tolua_function(param_1,"setVariable",PTR_lua_cocos2dx_Properties_setVariable_01713de0);
  tolua_function(param_1,"getBool",PTR_lua_cocos2dx_Properties_getBool_01714900);
  tolua_function(param_1,"getColor",PTR_lua_cocos2dx_Properties_getColor_0171e470);
  tolua_function(param_1,"getType",PTR_lua_cocos2dx_Properties_getType_0171e0d0);
  tolua_function(param_1,"getNextNamespace",PTR_lua_cocos2dx_Properties_getNextNamespace_0171baf0);
  tolua_function(param_1,"getInt",PTR_lua_cocos2dx_Properties_getInt_01713bb0);
  tolua_function(param_1,"getVec3",PTR_lua_cocos2dx_Properties_getVec3_0171aaa8);
  tolua_function(param_1,"getVec2",PTR_lua_cocos2dx_Properties_getVec2_0171aac0);
                    /* try { // try from 00a4a4b8 to 00b4a4bb has its CatchHandler @ 00a4a9b8 */
  tolua_function(param_1,"getVec4",PTR_lua_cocos2dx_Properties_getVec4_0171a5a0);
                    /* try { // try from 00a4a4cc to 00b4a4cf has its CatchHandler @ 00a4a9b4 */
  tolua_function(param_1,"getNextProperty",PTR_lua_cocos2dx_Properties_getNextProperty_0171ed60);
  tolua_function(param_1,"getFloat",PTR_lua_cocos2dx_Properties_getFloat_01718558);
  tolua_function(param_1,"getQuaternionFromAxisAngle",
                 PTR_lua_cocos2dx_Properties_getQuaternionFromAxisAngle_0171a5d8);
                    /* try { // try from 00a4a51c to 00b4a51f has its CatchHandler @ 00a4a98c */
  tolua_function(param_1,"parseColor",PTR_lua_cocos2dx_Properties_parseColor_01724f60);
                    /* try { // try from 00a4a534 to 00b4a537 has its CatchHandler @ 00a4a958 */
  tolua_function(param_1,"parseVec3",PTR_lua_cocos2dx_Properties_parseVec3_017147d0);
  tolua_function(param_1,"parseAxisAngle",PTR_lua_cocos2dx_Properties_parseAxisAngle_01723ce8);
                    /* try { // try from 00a4a570 to 00b4a573 has its CatchHandler @ 00a4a994 */
  tolua_function(param_1,"parseVec2",PTR_lua_cocos2dx_Properties_parseVec2_0171f9a8);
                    /* try { // try from 00a4a588 to 00b4a58b has its CatchHandler @ 00a4a998 */
  tolua_function(param_1,"parseVec4",PTR_lua_cocos2dx_Properties_parseVec4_01717658);
  tolua_endmodule(param_1);
  FUN_01211570((string *)&local_18,PTR_typeinfo_name_01716788,(string *)&local_10);
  uVar3 = std::__detail::
          _Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[]((_Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        *)PTR_g_luaType_0171c1d0,(string *)&local_18);
                    /* try { // try from 00a4a5b8 to 00b4a603 has its CatchHandler @ 00a4a370 */
  FUN_01213b44(uVar3,&DAT_012d1f68,0xd);
  FUN_01211570((string *)&local_10,"Properties",auStack_28);
  uVar3 = std::__detail::
          _Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[]((_Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        *)PTR_g_typeCast_01716290,(string *)&local_10);
  FUN_01213b44(uVar3,&DAT_012d1f68,0xd);
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar5 = *(int *)(local_10 + -8);
      *(int *)(local_10 + -8) = iVar5 + -1;
    }
    else {
      piVar4 = (int *)(local_10 + -8);
      do {
        iVar5 = *piVar4;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar2) {
          *piVar4 = iVar5 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar5 < 1) {
                    /* try { // try from 00a4a674 to 00b4a677 has its CatchHandler @ 00a4a9a0 */
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar5 = *(int *)(local_18 + -8);
                    /* try { // try from 00a4a6bc to 00b4a803 has its CatchHandler @ 00a4a370 */
      *(int *)(local_18 + -8) = iVar5 + -1;
    }
    else {
                    /* try { // try from 00a4a68c to 00b4a68f has its CatchHandler @ 00a4a99c */
      piVar4 = (int *)(local_18 + -8);
      do {
        iVar5 = *piVar4;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar2) {
          *piVar4 = iVar5 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar5 < 1) {
      operator_delete((undefined *)(local_18 + -0x18));
    }
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(1);
}


/* === lua_register_cocos2dx_TMXMapInfo @ 00a6e264 === */

/* lua_register_cocos2dx_TMXMapInfo(lua_State*) */

void lua_register_cocos2dx_TMXMapInfo(lua_State *param_1)

{
  char cVar1;
  bool bVar2;
  undefined8 uVar3;
  char *pcVar4;
  int *piVar5;
  int iVar6;
  undefined1 auStack_28 [16];
  long local_18;
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  tolua_usertype(param_1,"cc.TMXMapInfo");
  tolua_cclass(param_1,"TMXMapInfo","cc.TMXMapInfo",&DAT_012fc3d8,0);
  tolua_beginmodule(param_1,"TMXMapInfo");
  tolua_function(param_1,&DAT_0127fa80,PTR_lua_cocos2dx_TMXMapInfo_constructor_0171a0d0);
  tolua_function(param_1,"setCurrentString",PTR_lua_cocos2dx_TMXMapInfo_setCurrentString_01720c50);
  tolua_function(param_1,"getHexSideLength",PTR_lua_cocos2dx_TMXMapInfo_getHexSideLength_0171d4e8);
  tolua_function(param_1,"setTileSize",PTR_lua_cocos2dx_TMXMapInfo_setTileSize_017153d0);
  tolua_function(param_1,"initWithTMXFile",PTR_lua_cocos2dx_TMXMapInfo_initWithTMXFile_01722200);
  tolua_function(param_1,"getOrientation",PTR_lua_cocos2dx_TMXMapInfo_getOrientation_01721dc0);
  tolua_function(param_1,"setObjectGroups",PTR_lua_cocos2dx_TMXMapInfo_setObjectGroups_01721a10);
  tolua_function(param_1,"setLayers",PTR_lua_cocos2dx_TMXMapInfo_setLayers_0171d728);
  tolua_function(param_1,"parseXMLFile",PTR_lua_cocos2dx_TMXMapInfo_parseXMLFile_0171bd80);
  tolua_function(param_1,"getParentElement",PTR_lua_cocos2dx_TMXMapInfo_getParentElement_01722758);
  tolua_function(param_1,"setTMXFileName",PTR_lua_cocos2dx_TMXMapInfo_setTMXFileName_0171d4c0);
  tolua_function(param_1,"parseXMLString",PTR_lua_cocos2dx_TMXMapInfo_parseXMLString_017161a8);
  tolua_function(param_1,"getLayers",PTR_lua_cocos2dx_TMXMapInfo_getLayers_01713d70);
  tolua_function(param_1,"getStaggerAxis",PTR_lua_cocos2dx_TMXMapInfo_getStaggerAxis_017222b0);
  tolua_function(param_1,"setHexSideLength",PTR_lua_cocos2dx_TMXMapInfo_setHexSideLength_0171f720);
  tolua_function(param_1,"getTilesets",PTR_lua_cocos2dx_TMXMapInfo_getTilesets_01716c48);
  tolua_function(param_1,"getParentGID",PTR_lua_cocos2dx_TMXMapInfo_getParentGID_0171a5f0);
  tolua_function(param_1,"setParentElement",PTR_lua_cocos2dx_TMXMapInfo_setParentElement_0171b608);
  tolua_function(param_1,"initWithXML",PTR_lua_cocos2dx_TMXMapInfo_initWithXML_01721a78);
  tolua_function(param_1,"setParentGID",PTR_lua_cocos2dx_TMXMapInfo_setParentGID_0171df28);
  tolua_function(param_1,"getLayerAttribs",PTR_lua_cocos2dx_TMXMapInfo_getLayerAttribs_0171ffc8);
  tolua_function(param_1,"getTileSize",PTR_lua_cocos2dx_TMXMapInfo_getTileSize_0171e260);
  tolua_function(param_1,"getTileProperties",PTR_lua_cocos2dx_TMXMapInfo_getTileProperties_01722700)
  ;
  tolua_function(param_1,"isStoringCharacters",
                 PTR_lua_cocos2dx_TMXMapInfo_isStoringCharacters_017217a0);
  tolua_function(param_1,"getExternalTilesetFileName",
                 PTR_lua_cocos2dx_TMXMapInfo_getExternalTilesetFileName_01718790);
  tolua_function(param_1,"getObjectGroups",PTR_lua_cocos2dx_TMXMapInfo_getObjectGroups_01720550);
  tolua_function(param_1,"getTMXFileName",PTR_lua_cocos2dx_TMXMapInfo_getTMXFileName_0171f770);
  tolua_function(param_1,"setStaggerIndex",PTR_lua_cocos2dx_TMXMapInfo_setStaggerIndex_01720af0);
  tolua_function(param_1,"setProperties",PTR_lua_cocos2dx_TMXMapInfo_setProperties_017238c8);
  tolua_function(param_1,"setOrientation",PTR_lua_cocos2dx_TMXMapInfo_setOrientation_0171acd0);
  tolua_function(param_1,"setTileProperties",PTR_lua_cocos2dx_TMXMapInfo_setTileProperties_01722b78)
  ;
  tolua_function(param_1,"setMapSize",PTR_lua_cocos2dx_TMXMapInfo_setMapSize_01718490);
  tolua_function(param_1,"getCurrentString",PTR_lua_cocos2dx_TMXMapInfo_getCurrentString_0171f460);
  tolua_function(param_1,"setStoringCharacters",
                 PTR_lua_cocos2dx_TMXMapInfo_setStoringCharacters_017146a8);
  tolua_function(param_1,"setStaggerAxis",PTR_lua_cocos2dx_TMXMapInfo_setStaggerAxis_0171e008);
  tolua_function(param_1,"getMapSize",PTR_lua_cocos2dx_TMXMapInfo_getMapSize_01714930);
  tolua_function(param_1,"setTilesets",PTR_lua_cocos2dx_TMXMapInfo_setTilesets_0171cb38);
  tolua_function(param_1,"getProperties",PTR_lua_cocos2dx_TMXMapInfo_getProperties_01715448);
  tolua_function(param_1,"getStaggerIndex",PTR_lua_cocos2dx_TMXMapInfo_getStaggerIndex_0171c380);
  tolua_function(param_1,"setLayerAttribs",PTR_lua_cocos2dx_TMXMapInfo_setLayerAttribs_017174b0);
  tolua_function(param_1,"create",PTR_lua_cocos2dx_TMXMapInfo_create_0171d868);
  tolua_function(param_1,"createWithXML",PTR_lua_cocos2dx_TMXMapInfo_createWithXML_01722770);
  tolua_endmodule(param_1);
  pcVar4 = *(char **)(PTR_typeinfo_0171cd30 + 8);
  if (*pcVar4 == '*') {
    pcVar4 = pcVar4 + 1;
  }
  FUN_01211570((string *)&local_18,pcVar4,(string *)&local_10);
  uVar3 = std::__detail::
          _Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[]((_Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        *)PTR_g_luaType_0171c1d0,(string *)&local_18);
  FUN_01213b44(uVar3,"cc.TMXMapInfo",0xd);
  FUN_01211570((string *)&local_10,"TMXMapInfo",auStack_28);
  uVar3 = std::__detail::
          _Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[]((_Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        *)PTR_g_typeCast_01716290,(string *)&local_10);
  FUN_01213b44(uVar3,"cc.TMXMapInfo",0xd);
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar6 = *(int *)(local_10 + -8);
      *(int *)(local_10 + -8) = iVar6 + -1;
    }
    else {
      piVar5 = (int *)(local_10 + -8);
      do {
        iVar6 = *piVar5;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar2) {
          *piVar5 = iVar6 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar6 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar6 = *(int *)(local_18 + -8);
      *(int *)(local_18 + -8) = iVar6 + -1;
    }
    else {
      piVar5 = (int *)(local_18 + -8);
      do {
        iVar6 = *piVar5;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar2) {
          *piVar5 = iVar6 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar6 < 1) {
      operator_delete((undefined *)(local_18 + -0x18));
    }
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(1);
}


/* === lua_register_cocos2dx_studio_ComAttribute @ 00b15fc4 === */

/* lua_register_cocos2dx_studio_ComAttribute(lua_State*) */

void lua_register_cocos2dx_studio_ComAttribute(lua_State *param_1)

{
  char cVar1;
  bool bVar2;
  undefined8 uVar3;
  char *pcVar4;
  int *piVar5;
  int iVar6;
  undefined1 auStack_28 [16];
  long local_18;
  long local_10;
  long local_8;
  
                    /* try { // try from 00b15fd4 to 00c15fd7 has its CatchHandler @ 00b15d8c */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  tolua_usertype(param_1,&DAT_0130b610);
  tolua_cclass(param_1,"ComAttribute",&DAT_0130b610,"cc.Component",0);
  tolua_beginmodule(param_1,"ComAttribute");
  tolua_function(param_1,"getFloat",PTR_lua_cocos2dx_studio_ComAttribute_getFloat_0171f678);
  tolua_function(param_1,"getString",PTR_lua_cocos2dx_studio_ComAttribute_getString_017209c0);
  tolua_function(param_1,"setFloat",PTR_lua_cocos2dx_studio_ComAttribute_setFloat_017207a8);
  tolua_function(param_1,"setString",PTR_lua_cocos2dx_studio_ComAttribute_setString_017198d0);
  tolua_function(param_1,"getBool",PTR_lua_cocos2dx_studio_ComAttribute_getBool_01721788);
  tolua_function(param_1,"setInt",PTR_lua_cocos2dx_studio_ComAttribute_setInt_01714760);
  tolua_function(param_1,"parse",PTR_lua_cocos2dx_studio_ComAttribute_parse_01723c08);
  tolua_function(param_1,"getInt",PTR_lua_cocos2dx_studio_ComAttribute_getInt_01714e90);
  tolua_function(param_1,"setBool",PTR_lua_cocos2dx_studio_ComAttribute_setBool_017228f8);
  tolua_function(param_1,"create",PTR_lua_cocos2dx_studio_ComAttribute_create_01723cf8);
  tolua_function(param_1,"createInstance",
                 PTR_lua_cocos2dx_studio_ComAttribute_createInstance_01714c40);
  tolua_endmodule(param_1);
  pcVar4 = *(char **)(PTR_typeinfo_01717330 + 8);
  if (*pcVar4 == '*') {
    pcVar4 = pcVar4 + 1;
  }
  FUN_01211570((string *)&local_18,pcVar4,(string *)&local_10);
  uVar3 = std::__detail::
          _Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[]((_Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        *)PTR_g_luaType_0171c1d0,(string *)&local_18);
  FUN_01213b44(uVar3,&DAT_0130b610,0x10);
  FUN_01211570((string *)&local_10,"ComAttribute",auStack_28);
  uVar3 = std::__detail::
          _Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[]((_Map_base<std::string,std::pair<std::string_const,std::string>,std::allocator<std::pair<std::string_const,std::string>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        *)PTR_g_typeCast_01716290,(string *)&local_10);
  FUN_01213b44(uVar3,&DAT_0130b610,0x10);
                    /* catch() { ... } // from try @ 00b161fc with catch @ 00b161c8
                       catch() { ... } // from try @ 00b16410 with catch @ 00b161c8 */
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar6 = *(int *)(local_10 + -8);
      *(int *)(local_10 + -8) = iVar6 + -1;
    }
    else {
      piVar5 = (int *)(local_10 + -8);
      do {
        iVar6 = *piVar5;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar2) {
          *piVar5 = iVar6 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar6 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar6 = *(int *)(local_18 + -8);
                    /* try { // try from 00b16284 to 00c1632f has its CatchHandler @ 00b163d8 */
      *(int *)(local_18 + -8) = iVar6 + -1;
    }
    else {
      piVar5 = (int *)(local_18 + -8);
      do {
        iVar6 = *piVar5;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar2) {
          *piVar5 = iVar6 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar6 < 1) {
      operator_delete((undefined *)(local_18 + -0x18));
    }
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 00b161fc to 00c16237 has its CatchHandler @ 00b161c8 */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(1);
}


/* === serialize @ 00bd2a38 === */

/* cocostudio::ComAttribute::serialize(void*) */

void __thiscall cocostudio::ComAttribute::serialize(ComAttribute *this,void *param_1)

{
  bool bVar1;
  char cVar2;
  undefined1 uVar3;
  int iVar4;
  DictionaryHelper *pDVar5;
  long lVar6;
  long lVar7;
  stExpCocoNode *this_00;
  long *plVar8;
  int *piVar9;
  GenericValue *pGVar10;
  long lVar11;
  CocoLoader *pCVar12;
  code *pcVar13;
  undefined *local_30;
  long local_28;
  long local_20;
  long local_18;
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (param_1 != (void *)0x0) {
    pGVar10 = *(GenericValue **)param_1;
    lVar11 = *(long *)((long)param_1 + 8);
    pCVar12 = *(CocoLoader **)((long)param_1 + 0x10);
    local_30 = PTR_DAT_017191c0 + 0x18;
    if (pGVar10 == (GenericValue *)0x0) {
      if (lVar11 == 0) {
        lVar11 = 0;
        lVar6 = 0;
LAB_00bd2ce4:
                    /* try { // try from 00bd2cfc to 00cd2cff has its CatchHandler @ 00bd2d84 */
        pcVar13 = *(code **)(*(long *)this + 0x20);
        FUN_01211570(&local_20,lVar6,&local_18);
        (*pcVar13)(this,&local_20);
        if ((undefined *)(local_20 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00bd2dd4 with catch @ 00bd2da8
                       catch() { ... } // from try @ 00bd3140 with catch @ 00bd2da8 */
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar4 = *(int *)(local_20 + -8);
            *(int *)(local_20 + -8) = iVar4 + -1;
          }
          else {
            piVar9 = (int *)(local_20 + -8);
            do {
              iVar4 = *piVar9;
              cVar2 = '\x01';
              bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
              if (bVar1) {
                *piVar9 = iVar4 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar4 < 1) {
                    /* try { // try from 00bd2dd4 to 00cd2e0b has its CatchHandler @ 00bd2da8 */
            operator_delete((undefined *)(local_20 + -0x18));
          }
        }
        if (lVar11 != 0) {
LAB_00bd2bdc:
          plVar8 = (long *)cocos2d::FileUtils::getInstance();
          pcVar13 = *(code **)(*plVar8 + 0x50);
          FUN_01211570(&local_18,lVar11,&local_28);
          (*pcVar13)(&local_10,plVar8,&local_18);
          FUN_0121258c(&local_30,&local_10);
          if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar4 = *(int *)(local_10 + -8);
              *(int *)(local_10 + -8) = iVar4 + -1;
            }
            else {
              piVar9 = (int *)(local_10 + -8);
              do {
                iVar4 = *piVar9;
                cVar2 = '\x01';
                bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
                if (bVar1) {
                  *piVar9 = iVar4 + -1;
                  cVar2 = ExclusiveMonitorsStatus();
                }
              } while (cVar2 != '\0');
            }
            if (iVar4 < 1) {
              operator_delete((undefined *)(local_10 + -0x18));
            }
          }
          if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar4 = *(int *)(local_18 + -8);
                    /* try { // try from 00bd2e68 to 00cd2f33 has its CatchHandler @ 00bd3144 */
              *(int *)(local_18 + -8) = iVar4 + -1;
            }
            else {
              piVar9 = (int *)(local_18 + -8);
              do {
                iVar4 = *piVar9;
                cVar2 = '\x01';
                bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
                if (bVar1) {
                  *piVar9 = iVar4 + -1;
                  cVar2 = ExclusiveMonitorsStatus();
                }
              } while (cVar2 != '\0');
            }
            if (iVar4 < 1) {
              operator_delete((undefined *)(local_18 + -0x18));
            }
          }
        }
                    /* try { // try from 00bd2c48 to 00cd2c4b has its CatchHandler @ 00bd29b4 */
        uVar3 = parse(this,(string *)&local_30);
                    /* try { // try from 00bd2c58 to 00cd2cd3 has its CatchHandler @ 00bd2d5c */
        if (local_30 + -0x18 != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar4 = *(int *)(local_30 + -8);
            *(int *)(local_30 + -8) = iVar4 + -1;
          }
          else {
            piVar9 = (int *)(local_30 + -8);
            do {
              iVar4 = *piVar9;
              cVar2 = '\x01';
              bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
              if (bVar1) {
                *piVar9 = iVar4 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar4 < 1) {
            operator_delete(local_30 + -0x18);
          }
        }
        goto LAB_00bd2b08;
      }
      lVar6 = stExpCocoNode::GetValue((stExpCocoNode *)(lVar11 + 0x10),pCVar12);
      if (lVar6 != 0) {
        lVar7 = stExpCocoNode::GetValue((stExpCocoNode *)(lVar11 + 0x20),pCVar12);
        this_00 = (stExpCocoNode *)
                  stExpCocoNode::GetChildArray((stExpCocoNode *)(lVar11 + 0x30),pCVar12);
        if ((this_00 != (stExpCocoNode *)0x0) &&
           (lVar11 = stExpCocoNode::GetValue(this_00,pCVar12), lVar11 != 0)) {
                    /* try { // try from 00bd2b8c to 00cd2c0b has its CatchHandler @ 00bd2d84 */
          stExpCocoNode::GetValue(this_00 + 0x20,pCVar12);
          iVar4 = atoi();
          goto LAB_00bd2b94;
        }
      }
    }
    else {
      pDVar5 = (DictionaryHelper *)DictionaryHelper::getInstance();
                    /* try { // try from 00bd2a9c to 00cd2a9f has its CatchHandler @ 00bd2d34 */
      lVar6 = DictionaryHelper::getStringValue_json(pDVar5,pGVar10,"classname",(char *)0x0);
      if (lVar6 != 0) {
        pDVar5 = (DictionaryHelper *)DictionaryHelper::getInstance();
        lVar7 = DictionaryHelper::getStringValue_json(pDVar5,pGVar10,"name",(char *)0x0);
        pDVar5 = (DictionaryHelper *)DictionaryHelper::getInstance();
        pGVar10 = (GenericValue *)DictionaryHelper::getSubDictionary_json(pDVar5,pGVar10,"fileData")
        ;
        pDVar5 = (DictionaryHelper *)DictionaryHelper::getInstance();
        cVar2 = DictionaryHelper::checkObjectExist_json(pDVar5,pGVar10);
        if (cVar2 != '\0') {
          pDVar5 = (DictionaryHelper *)DictionaryHelper::getInstance();
          lVar11 = DictionaryHelper::getStringValue_json(pDVar5,pGVar10,"path",(char *)0x0);
          if (lVar11 != 0) {
            pDVar5 = (DictionaryHelper *)DictionaryHelper::getInstance();
            iVar4 = DictionaryHelper::getIntValue_json(pDVar5,pGVar10,"resourceType",-1);
LAB_00bd2b94:
            if (iVar4 == 0) {
              if (lVar7 == 0) goto LAB_00bd2ce4;
              pcVar13 = *(code **)(*(long *)this + 0x20);
              FUN_01211570(&local_28,lVar7,&local_18);
              (*pcVar13)(this,&local_28);
              if ((undefined *)(local_28 + -0x18) != PTR_DAT_017191c0) {
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                  iVar4 = *(int *)(local_28 + -8);
                  *(int *)(local_28 + -8) = iVar4 + -1;
                }
                else {
                  piVar9 = (int *)(local_28 + -8);
                  do {
                    /* catch() { ... } // from try @ 00bd2b8c with catch @ 00bd2d84
                       catch() { ... } // from try @ 00bd2cfc with catch @ 00bd2d84 */
                    iVar4 = *piVar9;
                    cVar2 = '\x01';
                    bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
                    if (bVar1) {
                      *piVar9 = iVar4 + -1;
                      cVar2 = ExclusiveMonitorsStatus();
                    }
                  } while (cVar2 != '\0');
                }
                if (iVar4 < 1) {
                  operator_delete((undefined *)(local_28 + -0x18));
                }
              }
              goto LAB_00bd2bdc;
            }
          }
        }
      }
    }
    if (local_30 + -0x18 != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00bd2a9c with catch @ 00bd2d34 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_30 + -8);
        *(int *)(local_30 + -8) = iVar4 + -1;
      }
      else {
        piVar9 = (int *)(local_30 + -8);
        do {
          iVar4 = *piVar9;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar9,0x10);
          if (bVar1) {
            *piVar9 = iVar4 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar4 < 1) {
                    /* try { // try from 00bd2d58 to 00cd2d83 has its CatchHandler @ 00bd29b4 */
                    /* catch() { ... } // from try @ 00bd2b18 with catch @ 00bd2d5c
                       catch() { ... } // from try @ 00bd2c58 with catch @ 00bd2d5c */
        operator_delete(local_30 + -0x18);
      }
    }
  }
  uVar3 = 0;
LAB_00bd2b08:
                    /* try { // try from 00bd2b18 to 00cd2b1b has its CatchHandler @ 00bd2d5c */
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar3);
  }
  return;
}


/* === lua_cocos2dx_studio_ComAttribute_parse @ 00b0cd10 === */

/* lua_cocos2dx_studio_ComAttribute_parse(lua_State*) */

void lua_cocos2dx_studio_ComAttribute_parse(lua_State *param_1)

{
  bool bVar1;
  char cVar2;
  undefined1 uVar3;
  int iVar4;
  ComAttribute *this;
  int *piVar5;
  bool bVar6;
  undefined *local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  this = (ComAttribute *)tolua_tousertype(param_1,1,0);
  iVar4 = lua_gettop(param_1);
  if (iVar4 + -1 == 1) {
    local_10 = PTR_DAT_017191c0 + 0x18;
    cVar2 = luaval_to_std_string(param_1,2,(string *)&local_10,"ccs.ComAttribute:parse");
    if (cVar2 == '\0') {
      tolua_error(param_1,"invalid arguments in function \'lua_cocos2dx_studio_ComAttribute_parse\'"
                  ,0);
    }
    else {
      uVar3 = cocostudio::ComAttribute::parse(this,(string *)&local_10);
      tolua_pushboolean(param_1,uVar3);
    }
    bVar6 = cVar2 != '\0';
    if (local_10 + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar4 + -1;
      }
      else {
        piVar5 = (int *)(local_10 + -8);
        do {
          iVar4 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar4 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete(local_10 + -0x18);
      }
    }
  }
  else {
    bVar6 = false;
    luaL_error(param_1,"%s has wrong number of arguments: %d, was expecting %d \n",
               "ccs.ComAttribute:parse",iVar4 + -1,1);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(bVar6);
}


/* === createNodeWithSceneFile @ 00be6980 === */

/* WARNING: Restarted to delay deadcode elimination for space: stack */
/* cocostudio::SceneReader::createNodeWithSceneFile(std::string const&,
   cocostudio::SceneReader::AttachComponentType) */

void __thiscall
cocostudio::SceneReader::createNodeWithSceneFile
          (SceneReader *this,string *param_1,undefined4 param_3)

{
  stExpCocoNode *psVar1;
  bool bVar2;
  Component *pCVar3;
  char cVar4;
  int iVar5;
  long *plVar6;
  undefined8 uVar7;
  TriggerMng *pTVar8;
  long lVar9;
  undefined *puVar10;
  char *pcVar11;
  stExpCocoNode *psVar12;
  stExpCocoNode *psVar13;
  undefined8 *puVar14;
  undefined8 *puVar15;
  long lVar16;
  int *piVar17;
  long lVar18;
  undefined1 auStack_f8 [16];
  long local_e8;
  long local_e0;
  long local_d8;
  long local_d0;
  Component *local_c8;
  long local_c0;
  Data aDStack_b8 [16];
  undefined8 *local_a8;
  undefined8 *local_a0;
  undefined8 *local_98;
  CocoLoader aCStack_90 [8];
  stExpCocoNode *local_88;
  undefined8 local_70;
  undefined8 uStack_68;
  undefined8 local_60;
  long *local_58;
  long *local_50;
  undefined8 local_48;
  void *local_40;
  undefined8 local_38;
  undefined8 local_30;
  undefined8 local_28;
  undefined8 local_20;
  undefined4 local_18;
  undefined8 local_10;
  long local_8;
  
                    /* catch() { ... } // from try @ 00be69bc with catch @ 00be69a8
                       catch() { ... } // from try @ 00be69f0 with catch @ 00be69a8 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* try { // try from 00be69bc to 00ce69bf has its CatchHandler @ 00be69a8 */
  plVar6 = (long *)cocos2d::FileUtils::getInstance();
  (**(code **)(*plVar6 + 0x138))(&local_e8,plVar6,param_1);
  iVar5 = FUN_01213398(&local_e8,".json");
  if (iVar5 == 0) {
                    /* try { // try from 00be69e8 to 00ce69eb has its CatchHandler @ 00be6a08 */
    local_60 = 0;
                    /* try { // try from 00be69f0 to 00ce6a1f has its CatchHandler @ 00be69a8 */
    *(undefined8 *)(this + 0x28) = 0;
    local_58 = (long *)0x0;
    local_70 = 0;
    uStack_68 = 0;
    local_50 = (long *)0x0;
                    /* catch() { ... } // from try @ 00be69e8 with catch @ 00be6a08 */
    local_48 = 0;
    local_40 = (void *)0x0;
    local_38 = 0;
    local_30 = 0;
    local_28 = 0;
    local_20 = 0x400;
    local_18 = 0;
    local_10 = 0;
    local_58 = operator_new(0x28);
    *local_58 = 0;
    local_58[1] = 0x10000;
    local_58[2] = 0;
    local_58[3] = 0;
    local_58[4] = 0;
    local_50 = local_58;
    cVar4 = readJson(this,param_1,(GenericDocument *)&local_70);
    if (cVar4 != '\0') {
      uVar7 = createObject(this,(GenericValue *)&local_70,0,param_3);
      *(undefined8 *)(this + 0x28) = uVar7;
      pTVar8 = (TriggerMng *)TriggerMng::getInstance();
      TriggerMng::parse(pTVar8,(GenericValue *)&local_70);
    }
    plVar6 = local_50;
    uVar7 = *(undefined8 *)(this + 0x28);
    if (local_50 != (long *)0x0) {
      lVar16 = *local_50;
      if (lVar16 == 0) {
LAB_00be6ad8:
        operator_delete((void *)plVar6[4]);
        operator_delete(plVar6);
      }
      else {
        lVar9 = local_50[2];
        if (lVar16 != lVar9) {
          do {
            lVar18 = *(long *)(lVar16 + 0x10);
            free(lVar16);
            *plVar6 = lVar18;
            if (lVar18 == 0) goto LAB_00be6ad8;
            lVar9 = plVar6[2];
            lVar16 = lVar18;
          } while (lVar18 != lVar9);
        }
        *(undefined8 *)(lVar9 + 8) = 0;
        operator_delete((void *)plVar6[4]);
        operator_delete(plVar6);
      }
    }
    free(local_38);
    operator_delete(local_40);
LAB_00be6afc:
    puVar10 = (undefined *)(local_e8 + -0x18);
    if (puVar10 == PTR_DAT_017191c0) goto LAB_00be6b10;
  }
  else {
    iVar5 = FUN_01213398(&local_e8,&DAT_01334978);
    if (iVar5 != 0) {
      cocos2d::log("read file [%s] error!\n",*(undefined8 *)param_1);
      uVar7 = 0;
      goto LAB_00be6afc;
    }
    plVar6 = (long *)cocos2d::FileUtils::getInstance();
    (**(code **)(*plVar6 + 0x50))(&local_e0,plVar6,param_1);
    plVar6 = (long *)cocos2d::FileUtils::getInstance();
    (**(code **)(*plVar6 + 0x28))(aDStack_b8,plVar6,&local_e0);
    pcVar11 = (char *)cocos2d::Data::getBytes(aDStack_b8);
    cVar4 = cocos2d::Data::isNull(aDStack_b8);
    if (cVar4 == '\0') {
      CocoLoader::CocoLoader(aCStack_90);
      cVar4 = CocoLoader::ReadCocoBinBuff(aCStack_90,pcVar11);
      if ((cVar4 != '\0') && (iVar5 = stExpCocoNode::GetType(local_88,aCStack_90), iVar5 == 3)) {
        psVar12 = (stExpCocoNode *)stExpCocoNode::GetChildArray(local_88,aCStack_90);
        iVar5 = stExpCocoNode::GetChildNum(local_88);
        if (iVar5 == 0) {
          CocoLoader::~CocoLoader(aCStack_90);
          goto LAB_00be6c80;
        }
        uVar7 = cocos2d::Node::create();
        *(undefined8 *)(this + 0x28) = uVar7;
        psVar13 = psVar12 + 0xf0;
        local_a8 = (undefined8 *)0x0;
        local_a0 = (undefined8 *)0x0;
        local_98 = (undefined8 *)0x0;
        uVar7 = stExpCocoNode::GetName(psVar13,aCStack_90);
        FUN_01211570(&local_d8,uVar7,&local_c0);
        iVar5 = FUN_01213398(&local_d8,"components");
        if (iVar5 == 0) {
          iVar5 = stExpCocoNode::GetChildNum(psVar13);
        }
        else {
          iVar5 = 0;
        }
        psVar13 = (stExpCocoNode *)stExpCocoNode::GetChildArray(psVar13,aCStack_90);
        puVar14 = operator_new(0x18,(nothrow_t *)PTR_nothrow_01717628);
        if (puVar14 != (undefined8 *)0x0) {
          *puVar14 = 0;
          puVar14[1] = 0;
          puVar14[2] = 0;
        }
        if (0 < iVar5) {
          psVar1 = psVar13 + ((ulong)(iVar5 - 1) + 1) * 0x10;
          do {
            lVar16 = stExpCocoNode::GetChildArray(psVar13,aCStack_90);
            if (lVar16 != 0) {
              uVar7 = stExpCocoNode::GetName((stExpCocoNode *)(lVar16 + 0x10),aCStack_90);
              FUN_01211570(&local_d0,uVar7,&local_c0);
              lVar9 = stExpCocoNode::GetValue((stExpCocoNode *)(lVar16 + 0x10),aCStack_90);
              local_c8 = (Component *)0x0;
              iVar5 = FUN_01213398(&local_d0,"classname");
              if ((iVar5 == 0) && (lVar9 != 0)) {
                FUN_01211570(&local_c0,lVar9,auStack_f8);
                local_c8 = (Component *)createComponent(this,&local_c0);
                if ((undefined *)(local_c0 + -0x18) != PTR_DAT_017191c0) {
                  piVar17 = (int *)(local_c0 + -8);
                  if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    iVar5 = *(int *)(local_c0 + -8);
                    *(int *)(local_c0 + -8) = iVar5 + -1;
                  }
                  else {
                    do {
                      iVar5 = *piVar17;
                      cVar4 = '\x01';
                      bVar2 = (bool)ExclusiveMonitorPass(piVar17,0x10);
                      if (bVar2) {
                        *piVar17 = iVar5 + -1;
                        cVar4 = ExclusiveMonitorsStatus();
                      }
                    } while (cVar4 != '\0');
                  }
                  if (iVar5 < 1) {
                    operator_delete((undefined *)(local_c0 + -0x18));
                  }
                }
              }
              if (local_c8 != (Component *)0x0) {
                lVar9 = *(long *)local_c8;
                *puVar14 = 0;
                puVar14[1] = lVar16;
                puVar14[2] = aCStack_90;
                cVar4 = (**(code **)(lVar9 + 0x38))(local_c8,puVar14);
                pCVar3 = local_c8;
                if (cVar4 == '\0') {
                  if (local_c8 != (Component *)0x0) {
                    cocos2d::Ref::release((Ref *)local_c8);
                    local_c8 = (Component *)0x0;
                  }
                }
                else if ((local_c8 == (Component *)0x0) ||
                        (lVar16 = __dynamic_cast(local_c8,PTR_typeinfo_017149f8,
                                                 PTR_typeinfo_0171efb8,0), lVar16 == 0)) {
                  if (local_98 == local_a0) {
                    std::vector<cocos2d::Component*,std::allocator<cocos2d::Component*>>::
                    _M_emplace_back_aux<cocos2d::Component*const&>
                              ((vector<cocos2d::Component*,std::allocator<cocos2d::Component*>> *)
                               &local_a8,&local_c8);
                  }
                  else {
                    puVar15 = (undefined8 *)0x0;
                    if (local_a0 != (undefined8 *)0x0) {
                      *local_a0 = pCVar3;
                      puVar15 = local_a0;
                    }
                    local_a0 = puVar15 + 1;
                  }
                }
              }
              if (*(long *)(this + 0x18) != 0) {
                (**(code **)(this + 0x20))(this + 8,local_c8,puVar14);
              }
              if ((undefined *)(local_d0 + -0x18) != PTR_DAT_017191c0) {
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                  iVar5 = *(int *)(local_d0 + -8);
                  *(int *)(local_d0 + -8) = iVar5 + -1;
                }
                else {
                  piVar17 = (int *)(local_d0 + -8);
                  do {
                    iVar5 = *piVar17;
                    cVar4 = '\x01';
                    bVar2 = (bool)ExclusiveMonitorPass(piVar17,0x10);
                    if (bVar2) {
                      *piVar17 = iVar5 + -1;
                      cVar4 = ExclusiveMonitorsStatus();
                    }
                  } while (cVar4 != '\0');
                }
                if (iVar5 < 1) {
                  operator_delete((undefined *)(local_d0 + -0x18));
                }
              }
            }
            psVar13 = psVar13 + 0x10;
          } while (psVar13 != psVar1);
        }
        setPropertyFromJsonDict(this,aCStack_90,local_88,*(Node **)(this + 0x28));
        puVar14 = local_a8;
        if (local_a8 != local_a0) {
          do {
            (**(code **)(**(long **)(this + 0x28) + 0x4f8))(*(long **)(this + 0x28),*puVar14);
            puVar14 = puVar14 + 1;
          } while (local_a0 != puVar14);
        }
        lVar16 = stExpCocoNode::GetChildArray(psVar12 + 0xb0,aCStack_90);
        iVar5 = stExpCocoNode::GetChildNum(psVar12 + 0xb0);
        if (0 < iVar5) {
          lVar9 = lVar16 + ((ulong)(iVar5 - 1) + 1) * 0x10;
          do {
            createObject(this,aCStack_90,lVar16,*(undefined8 *)(this + 0x28),param_3);
            lVar16 = lVar16 + 0x10;
          } while (lVar16 != lVar9);
        }
        pTVar8 = (TriggerMng *)TriggerMng::getInstance();
        TriggerMng::parse(pTVar8,aCStack_90,psVar12);
        if ((undefined *)(local_d8 + -0x18) != PTR_DAT_017191c0) {
          FUN_006c18ac((undefined *)(local_d8 + -0x18),&local_c0);
        }
        if (local_a8 != (undefined8 *)0x0) {
          operator_delete(local_a8);
        }
      }
      CocoLoader::~CocoLoader(aCStack_90);
      cocos2d::Data::~Data(aDStack_b8);
      puVar10 = (undefined *)(local_e0 + -0x18);
      if (puVar10 == PTR_DAT_017191c0) goto LAB_00be6c10;
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
LAB_00be70e8:
        iVar5 = *(int *)(local_e0 + -8);
        *(int *)(local_e0 + -8) = iVar5 + -1;
      }
      else {
        piVar17 = (int *)(local_e0 + -8);
        do {
          iVar5 = *piVar17;
          cVar4 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar17,0x10);
          if (bVar2) {
            *piVar17 = iVar5 + -1;
            cVar4 = ExclusiveMonitorsStatus();
          }
        } while (cVar4 != '\0');
      }
LAB_00be6cc0:
      if (0 < iVar5) goto LAB_00be6c10;
      operator_delete(puVar10);
      uVar7 = *(undefined8 *)(this + 0x28);
    }
    else {
LAB_00be6c80:
      cocos2d::Data::~Data(aDStack_b8);
      puVar10 = (undefined *)(local_e0 + -0x18);
      if (puVar10 != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) goto LAB_00be70e8;
        piVar17 = (int *)(local_e0 + -8);
        do {
          iVar5 = *piVar17;
          cVar4 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar17,0x10);
          if (bVar2) {
            *piVar17 = iVar5 + -1;
            cVar4 = ExclusiveMonitorsStatus();
          }
        } while (cVar4 != '\0');
        goto LAB_00be6cc0;
      }
LAB_00be6c10:
      uVar7 = *(undefined8 *)(this + 0x28);
    }
    puVar10 = (undefined *)(local_e8 + -0x18);
    if (puVar10 == PTR_DAT_017191c0) goto LAB_00be6b10;
  }
  if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
    iVar5 = *(int *)(local_e8 + -8);
    *(int *)(local_e8 + -8) = iVar5 + -1;
  }
  else {
    piVar17 = (int *)(local_e8 + -8);
    do {
      iVar5 = *piVar17;
      cVar4 = '\x01';
      bVar2 = (bool)ExclusiveMonitorPass(piVar17,0x10);
      if (bVar2) {
        *piVar17 = iVar5 + -1;
        cVar4 = ExclusiveMonitorsStatus();
      }
    } while (cVar4 != '\0');
  }
  if (iVar5 < 1) {
    operator_delete(puVar10);
  }
LAB_00be6b10:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar7);
  }
  return;
}


/* === loadMeshDatasBinary @ 00ccf58c === */

/* cocos2d::Bundle3D::loadMeshDatasBinary(cocos2d::MeshDatas&) */

void __thiscall cocos2d::Bundle3D::loadMeshDatasBinary(Bundle3D *this,MeshDatas *param_1)

{
  BundleReader *this_00;
  Bundle3D *pBVar1;
  vector *pvVar2;
  int iVar4;
  long lVar5;
  undefined8 uVar6;
  long lVar7;
  AABB *pAVar8;
  undefined *puVar9;
  void *pvVar10;
  ulong uVar11;
  ulong uVar12;
  ulong uVar13;
  vector *pvVar14;
  vector *pvVar15;
  vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>> *this_01;
  MeshData *pMVar16;
  undefined8 *puVar17;
  undefined8 *puVar18;
  long lVar19;
  uint uVar20;
  int iVar21;
  int iVar22;
  int iVar23;
  int iVar24;
  undefined4 uVar25;
  undefined4 uVar26;
  uint local_13c;
  int local_100;
  undefined1 uStack_fc;
  undefined1 uStack_fb;
  undefined1 uStack_fa;
  undefined1 uStack_f9;
  uint local_b8;
  uint local_ac;
  int local_a8;
  uint local_a4;
  uint local_a0;
  uint local_9c;
  MeshData *local_98;
  long local_90;
  Vec3 aVStack_88 [16];
  int local_78 [4];
  void *local_68;
  void *local_60;
  undefined8 local_58;
  float local_50;
  float local_4c;
  float local_48;
  float local_44;
  float local_40;
  float local_3c;
  long local_38;
  Vec3 aVStack_2c [12];
  long local_20;
  Vec3 aVStack_14 [12];
  long local_8;
  vector *pvVar3;
  
                    /* try { // try from 00ccf590 to 00dcf5ab has its CatchHandler @ 00cd0004 */
                    /* try { // try from 00ccf5b8 to 00dcf603 has its CatchHandler @ 00cd0030 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FUN_01211570((AABB *)&local_20,&DAT_012fc3d8,
               (vector<unsigned_short,std::allocator<unsigned_short>> *)&local_68);
  lVar5 = seekToFirstType(this,0x22,(string *)&local_20);
  if ((undefined *)(local_20 + -0x18) != PTR_DAT_017191c0) {
    FUN_00cc93d0((undefined *)(local_20 + -0x18),&local_38);
  }
  if (lVar5 != 0) {
    this_00 = (BundleReader *)(this + 0xa0);
                    /* try { // try from 00ccf618 to 00dcf653 has its CatchHandler @ 00cd000c */
    local_ac = 0;
    lVar5 = BundleReader::read(this_00,&local_ac,4,1);
    if (lVar5 == 1) {
      local_98 = (MeshData *)0x0;
      if (local_ac != 0) {
                    /* try { // try from 00ccf688 to 00dcf68b has its CatchHandler @ 00cd0014 */
        local_13c = 0;
        do {
          local_a8 = 0;
          lVar5 = BundleReader::read(this_00,&local_a8,4,1);
          if ((lVar5 != 1) || (local_a8 == 0)) {
LAB_00ccfccc:
            pMVar16 = local_98;
            if (local_98 != (MeshData *)0x0) {
              MeshData::~MeshData(local_98);
              operator_delete(pMVar16);
            }
            local_98 = (MeshData *)0x0;
            puVar18 = *(undefined8 **)param_1;
            puVar17 = *(undefined8 **)(param_1 + 8);
            if (puVar18 != puVar17) {
              do {
                pMVar16 = (MeshData *)*puVar18;
                if (pMVar16 != (MeshData *)0x0) {
                  MeshData::~MeshData(pMVar16);
                  operator_delete(pMVar16);
                }
                puVar18 = puVar18 + 1;
              } while (puVar17 != puVar18);
              puVar17 = *(undefined8 **)param_1;
            }
            *(undefined8 **)(param_1 + 8) = puVar17;
            goto LAB_00ccf630;
          }
          local_98 = operator_new(0x90,(nothrow_t *)PTR_nothrow_01717628);
          iVar4 = local_a8;
          if (local_98 == (MeshData *)0x0) {
            local_98 = (MeshData *)0x0;
            uVar12 = lRam0000000000000078 - lRam0000000000000070 >> 4;
            iRam0000000000000088 = local_a8;
            uVar13 = (ulong)local_a8;
            if (uVar12 < uVar13) {
                    /* try { // try from 00ccfec0 to 00dcffdb has its CatchHandler @ 00ccf40c */
              this_01 = (vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>>
                         *)0x70;
              goto LAB_00ccfec4;
            }
            if (uVar13 < uVar12) {
              lRam0000000000000078 = lRam0000000000000070 + uVar13 * 0x10;
            }
          }
          else {
            this_01 = (vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>> *
                      )(local_98 + 0x70);
            *(undefined8 *)local_98 = 0;
            *(undefined8 *)(local_98 + 8) = 0;
            *(undefined8 *)(local_98 + 0x10) = 0;
            *(undefined4 *)(local_98 + 0x18) = 0;
            *(undefined8 *)(local_98 + 0x20) = 0;
            *(undefined8 *)(local_98 + 0x28) = 0;
            *(undefined8 *)(local_98 + 0x30) = 0;
            *(undefined8 *)(local_98 + 0x38) = 0;
            *(undefined8 *)(local_98 + 0x40) = 0;
            *(undefined8 *)(local_98 + 0x48) = 0;
            *(undefined8 *)(local_98 + 0x50) = 0;
            *(undefined8 *)(local_98 + 0x58) = 0;
            *(undefined8 *)(local_98 + 0x60) = 0;
            *(undefined4 *)(local_98 + 0x68) = 0;
            *(undefined8 *)(local_98 + 0x70) = 0;
            *(undefined8 *)(local_98 + 0x78) = 0;
            *(undefined8 *)(local_98 + 0x80) = 0;
            *(int *)(local_98 + 0x88) = local_a8;
            if (local_a8 != 0) {
              uVar12 = 0;
LAB_00ccfec4:
              std::vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>>::
              _M_default_append(this_01,(long)local_a8 - uVar12);
              iVar4 = *(int *)(local_98 + 0x88);
            }
          }
          lVar5 = 0;
          if (0 < iVar4) {
            do {
              while( true ) {
                FUN_01211570((vector<unsigned_short,std::allocator<unsigned_short>> *)&local_68,
                             &DAT_012fc3d8,(AABB *)&local_20);
                lVar7 = BundleReader::read(this_00,(Vec3 *)local_78,4,1);
                if (lVar7 != 1) {
                  if ((undefined *)((long)local_68 + -0x18) != PTR_DAT_017191c0) {
                    FUN_00cc93d0((undefined *)((long)local_68 + -0x18),(AABB *)&local_20);
                  }
                  goto LAB_00ccfccc;
                }
                BundleReader::readString();
                BundleReader::readString();
                FUN_0121258c((vector<unsigned_short,std::allocator<unsigned_short>> *)&local_68,
                             (AABB *)&local_20);
                if ((undefined *)(local_20 + -0x18) != PTR_DAT_017191c0) {
                  FUN_00cc93d0((undefined *)(local_20 + -0x18),aVStack_88);
                }
                lVar19 = lVar5 * 0x10;
                lVar7 = *(long *)(local_98 + 0x70) + lVar19;
                *(int *)(*(long *)(local_98 + 0x70) + lVar19) = local_78[0];
                *(int *)(lVar7 + 0xc) = local_78[0] << 2;
                uVar25 = parseGLType(this,(string *)&local_38);
                *(undefined4 *)(lVar7 + 4) = uVar25;
                lVar7 = *(long *)(local_98 + 0x70);
                uVar25 = parseGLProgramAttribute(this,(string *)&local_68);
                *(undefined4 *)(lVar7 + lVar19 + 8) = uVar25;
                if ((undefined *)(local_38 + -0x18) != PTR_DAT_017191c0) {
                  FUN_00cc93d0((undefined *)(local_38 + -0x18),(AABB *)&local_20);
                }
                if ((undefined *)((long)local_68 + -0x18) != PTR_DAT_017191c0) break;
                lVar5 = lVar5 + 1;
                if (*(int *)(local_98 + 0x88) <= lVar5) goto LAB_00ccf870;
              }
              lVar5 = lVar5 + 1;
              FUN_00cc93d0((undefined *)((long)local_68 + -0x18),(AABB *)&local_20);
            } while (lVar5 < *(int *)(local_98 + 0x88));
          }
LAB_00ccf870:
          local_a4 = 0;
          lVar5 = BundleReader::read(this_00,&local_a4,4,1);
          if ((lVar5 != 1) || (local_a4 == 0)) goto LAB_00ccfccc;
          uVar13 = (ulong)local_a4;
          pvVar10 = *(void **)local_98;
          uVar12 = *(long *)(local_98 + 8) - (long)pvVar10 >> 2;
          if (uVar12 < uVar13) {
            std::vector<float,std::allocator<float>>::_M_default_append
                      ((vector<float,std::allocator<float>> *)local_98,uVar13 - uVar12);
            uVar13 = (ulong)local_a4;
            pvVar10 = *(void **)local_98;
          }
          else if (uVar13 < uVar12) {
            *(void **)(local_98 + 8) = (void *)((long)pvVar10 + uVar13 * 4);
          }
          uVar12 = BundleReader::read(this_00,pvVar10,4,uVar13);
          if (uVar12 != local_a4) goto LAB_00ccfccc;
          local_a0 = 1;
          BundleReader::read(this_00,&local_a0,4,1);
          if (local_a0 != 0) {
            local_b8 = 0;
            do {
              local_68 = (void *)0x0;
              local_60 = (void *)0x0;
              local_58 = 0;
              BundleReader::readString();
              pMVar16 = local_98;
                    /* try { // try from 00ccf93c to 00dcfc47 has its CatchHandler @ 00ccff58 */
              lVar5 = *(long *)(local_98 + 0x40);
              if (lVar5 == *(long *)(local_98 + 0x48)) {
                std::vector<std::string,std::allocator<std::string>>::
                _M_emplace_back_aux<std::string_const&>
                          ((vector<std::string,std::allocator<std::string>> *)(local_98 + 0x38),
                           (string *)&local_90);
              }
              else {
                lVar7 = 0;
                if (lVar5 != 0) {
                  FUN_01214ee0(lVar5,(string *)&local_90);
                  lVar7 = *(long *)(pMVar16 + 0x40);
                }
                *(long *)(pMVar16 + 0x40) = lVar7 + 8;
              }
              lVar5 = BundleReader::read(this_00,&local_9c,4,1);
              if (lVar5 != 1) {
LAB_00ccfcac:
                if ((undefined *)(local_90 + -0x18) != PTR_DAT_017191c0) {
                  FUN_00cc93d0((undefined *)(local_90 + -0x18),(AABB *)&local_20);
                }
                if (local_68 != (void *)0x0) {
                  operator_delete(local_68);
                }
                goto LAB_00ccfccc;
              }
              uVar13 = (ulong)local_9c;
              uVar12 = (long)local_60 - (long)local_68 >> 1;
              if (uVar12 < uVar13) {
                std::vector<unsigned_short,std::allocator<unsigned_short>>::_M_default_append
                          ((vector<unsigned_short,std::allocator<unsigned_short>> *)&local_68,
                           uVar13 - uVar12);
                uVar13 = (ulong)local_9c;
              }
              else if (uVar13 < uVar12) {
                local_60 = (void *)((long)local_68 + uVar13 * 2);
              }
              uVar12 = BundleReader::read(this_00,local_68,2,uVar13);
              pMVar16 = local_98;
              if (uVar12 != local_9c) goto LAB_00ccfcac;
              puVar18 = *(undefined8 **)(local_98 + 0x28);
              if (puVar18 == *(undefined8 **)(local_98 + 0x30)) {
                std::
                vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
                ::
                _M_emplace_back_aux<std::vector<unsigned_short,std::allocator<unsigned_short>>const&>
                          ((vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
                            *)(local_98 + 0x20),(vector *)&local_68);
              }
              else {
                lVar5 = 0;
                if (puVar18 != (undefined8 *)0x0) {
                  *puVar18 = 0;
                  uVar12 = (long)local_60 - (long)local_68;
                  puVar18[1] = 0;
                  puVar18[2] = 0;
                  if ((long)uVar12 >> 1 == 0) {
                    pvVar10 = (void *)0x0;
                  }
                  else {
                    if ((long)uVar12 >> 1 < 0) {
                    /* WARNING: Subroutine does not return */
                      FUN_0120f0e8();
                    }
                    pvVar10 = operator_new(uVar12);
                  }
                  *puVar18 = pvVar10;
                  puVar18[1] = pvVar10;
                  puVar18[2] = (long)pvVar10 + uVar12;
                  lVar5 = (long)local_60 - (long)local_68;
                  if (lVar5 >> 1 != 0) {
                    pvVar10 = (void *)memmove(pvVar10,local_68,lVar5);
                  }
                  puVar18[1] = (long)pvVar10 + lVar5;
                  lVar5 = *(long *)(pMVar16 + 0x28);
                }
                *(long *)(pMVar16 + 0x28) = lVar5 + 0x18;
              }
              pBVar1 = this + 0x18;
              *(int *)(local_98 + 0x68) =
                   (int)(*(long *)(local_98 + 0x28) - *(long *)(local_98 + 0x20) >> 3) * -0x55555555
              ;
              iVar4 = FUN_01213398(pBVar1,&DAT_0133a478);
              if (((iVar4 == 0) || (iVar4 = FUN_01213398(pBVar1,&DAT_0133a480), iVar4 == 0)) ||
                 (iVar4 = FUN_01213398(pBVar1,&DAT_0133a488), iVar4 == 0)) {
                pMVar16 = local_98;
                pvVar14 = *(vector **)(local_98 + 0x70);
                pvVar15 = *(vector **)(local_98 + 0x78);
                if (pvVar14 == pvVar15) {
                  pvVar3 = (vector *)0x0;
                }
                else {
                  pvVar2 = pvVar14 + 0x10;
                  uVar13 = (ulong)((long)pvVar15 - (long)pvVar2) >> 4;
                  uVar12 = (uVar13 - 4 >> 2) + 1;
                  if (uVar13 < 4) {
                    uVar20 = 0;
                  }
                  else {
                    iVar4 = 0;
                    iVar21 = 0;
                    iVar22 = 0;
                    iVar23 = 0;
                    pvVar3 = pvVar14 + 0xc;
                    uVar11 = 0;
                    do {
                      iVar24 = *(int *)pvVar3;
                      uVar25 = *(undefined4 *)(pvVar3 + 0x10);
                      pvVar2 = pvVar3 + 0x20;
                      uVar26 = *(undefined4 *)(pvVar3 + 0x30);
                      pvVar3 = pvVar3 + 0x40;
                      uVar11 = uVar11 + 1;
                      _local_100 = CONCAT17((char)((uint)uVar25 >> 0x18),
                                            CONCAT16((char)((uint)uVar25 >> 0x10),
                                                     CONCAT15((char)((uint)uVar25 >> 8),
                                                              CONCAT14((char)uVar25,iVar24))));
                      iVar4 = iVar4 + iVar24;
                      iVar21 = iVar21 + (int)((ulong)_local_100 >> 0x20);
                      iVar22 = iVar22 + *(int *)pvVar2;
                      iVar23 = iVar23 + (int)(CONCAT17((char)((uint)uVar26 >> 0x18),
                                                       CONCAT16((char)((uint)uVar26 >> 0x10),
                                                                CONCAT15((char)((uint)uVar26 >> 8),
                                                                         CONCAT14((char)uVar26,
                                                                                  *(int *)pvVar2))))
                                             >> 0x20);
                    } while (uVar11 < uVar12);
                    uVar20 = iVar4 + iVar21 + iVar22 + iVar23;
                    pvVar14 = pvVar14 + uVar12 * 0x40;
                    pvVar3 = (vector *)(ulong)uVar20;
                    if (uVar12 * 4 - (uVar13 + 1) == 0) goto LAB_00ccfb8c;
                    pvVar2 = pvVar14 + 0x10;
                  }
                  pvVar3 = (vector *)(ulong)(uVar20 + *(int *)(pvVar14 + 0xc));
                  if (pvVar15 != pvVar2) {
                    uVar20 = uVar20 + *(int *)(pvVar14 + 0xc) + *(int *)(pvVar14 + 0x1c);
                    pvVar3 = (vector *)(ulong)uVar20;
                    if (pvVar15 != pvVar14 + 0x20) {
                      uVar20 = uVar20 + *(int *)(pvVar14 + 0x2c);
                      pvVar3 = (vector *)(ulong)uVar20;
                      if (pvVar15 != pvVar14 + 0x30) {
                        uVar20 = uVar20 + *(int *)(pvVar14 + 0x3c);
                        pvVar3 = (vector *)(ulong)uVar20;
                        if (pvVar15 != pvVar14 + 0x40) {
                          uVar20 = uVar20 + *(int *)(pvVar14 + 0x4c);
                          pvVar3 = (vector *)(ulong)uVar20;
                          if (pvVar15 != pvVar14 + 0x50) {
                            uVar20 = uVar20 + *(int *)(pvVar14 + 0x5c);
                            pvVar3 = (vector *)(ulong)uVar20;
                            if (pvVar15 != pvVar14 + 0x60) {
                              pvVar3 = (vector *)(ulong)(uVar20 + *(int *)(pvVar14 + 0x6c));
                            }
                          }
                        }
                      }
                    }
                  }
                }
LAB_00ccfb8c:
                calculateAABB((Bundle3D *)local_98,pvVar3,
                              (int)(vector<unsigned_short,std::allocator<unsigned_short>> *)
                                   &local_68,pvVar14);
                pAVar8 = *(AABB **)(pMVar16 + 0x58);
                if (pAVar8 == *(AABB **)(pMVar16 + 0x60)) {
                  std::vector<cocos2d::AABB,std::allocator<cocos2d::AABB>>::
                  _M_emplace_back_aux<cocos2d::AABB>
                            ((vector<cocos2d::AABB,std::allocator<cocos2d::AABB>> *)(pMVar16 + 0x50)
                             ,(AABB *)&local_20);
                }
                else {
                  lVar5 = 0;
                  if (pAVar8 != (AABB *)0x0) {
                    AABB::AABB(pAVar8,(AABB *)&local_20);
                    lVar5 = *(long *)(pMVar16 + 0x58);
                  }
                  *(long *)(pMVar16 + 0x58) = lVar5 + 0x18;
                }
                Vec3::~Vec3(aVStack_14);
                Vec3::~Vec3((Vec3 *)&local_20);
                puVar9 = (undefined *)(local_90 + -0x18);
                if (puVar9 != PTR_DAT_017191c0) {
LAB_00ccfe44:
                  FUN_00cc93d0(puVar9,(AABB *)&local_20);
                }
              }
              else {
                lVar5 = BundleReader::read(this_00,&local_50,4,6);
                pMVar16 = local_98;
                if (lVar5 != 6) goto LAB_00ccfcac;
                Vec3::Vec3(aVStack_88,local_50,local_4c,local_48);
                Vec3::Vec3((Vec3 *)local_78,local_44,local_40,local_3c);
                AABB::AABB((AABB *)&local_38,aVStack_88,(Vec3 *)local_78);
                pAVar8 = *(AABB **)(pMVar16 + 0x58);
                if (pAVar8 == *(AABB **)(pMVar16 + 0x60)) {
                  std::vector<cocos2d::AABB,std::allocator<cocos2d::AABB>>::
                  _M_emplace_back_aux<cocos2d::AABB>
                            ((vector<cocos2d::AABB,std::allocator<cocos2d::AABB>> *)(pMVar16 + 0x50)
                             ,(AABB *)&local_38);
                }
                else {
                  lVar5 = 0;
                  if (pAVar8 != (AABB *)0x0) {
                    AABB::AABB(pAVar8,(AABB *)&local_38);
                    lVar5 = *(long *)(pMVar16 + 0x58);
                  }
                  *(long *)(pMVar16 + 0x58) = lVar5 + 0x18;
                }
                Vec3::~Vec3(aVStack_2c);
                Vec3::~Vec3((Vec3 *)&local_38);
                Vec3::~Vec3((Vec3 *)local_78);
                Vec3::~Vec3(aVStack_88);
                puVar9 = (undefined *)(local_90 + -0x18);
                if (puVar9 != PTR_DAT_017191c0) goto LAB_00ccfe44;
              }
              if (local_68 != (void *)0x0) {
                operator_delete(local_68);
              }
              local_b8 = local_b8 + 1;
            } while (local_b8 < local_a0);
          }
          puVar18 = *(undefined8 **)(param_1 + 8);
          if (puVar18 == *(undefined8 **)(param_1 + 0x10)) {
            std::vector<cocos2d::MeshData*,std::allocator<cocos2d::MeshData*>>::
            _M_emplace_back_aux<cocos2d::MeshData*const&>
                      ((vector<cocos2d::MeshData*,std::allocator<cocos2d::MeshData*>> *)param_1,
                       &local_98);
          }
          else {
            lVar5 = 0;
            if (puVar18 != (undefined8 *)0x0) {
              *puVar18 = local_98;
              lVar5 = *(long *)(param_1 + 8);
            }
            *(long *)(param_1 + 8) = lVar5 + 8;
          }
          local_13c = local_13c + 1;
        } while (local_13c < local_ac);
      }
                    /* try { // try from 00ccfc60 to 00dcfc63 has its CatchHandler @ 00cd0028 */
      uVar6 = 1;
      goto LAB_00ccf634;
    }
  }
LAB_00ccf630:
  uVar6 = 0;
LAB_00ccf634:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar6);
  }
  return;
}


/* === loadMeshDatasJson @ 00cd0d90 === */

/* cocos2d::Bundle3D::loadMeshDatasJson(cocos2d::MeshDatas&) */

void __thiscall cocos2d::Bundle3D::loadMeshDatasJson(Bundle3D *this,MeshDatas *param_1)

{
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
  *this_00;
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
  *pGVar1;
  ulong *puVar2;
  undefined2 *puVar3;
  int *piVar4;
  int iVar5;
  int iVar6;
  ushort uVar7;
  undefined2 uVar8;
  Bundle3D *pBVar9;
  vector *pvVar10;
  undefined4 uVar12;
  undefined4 uVar13;
  int iVar14;
  GenericValue *pGVar15;
  GenericValue *pGVar16;
  GenericValue *pGVar17;
  void *pvVar18;
  void *pvVar19;
  AABB *pAVar20;
  double *pdVar21;
  ulong uVar22;
  int *piVar23;
  int iVar24;
  char *pcVar25;
  ulong uVar26;
  float *pfVar27;
  ulong uVar28;
  long *plVar29;
  int *piVar30;
  vector *pvVar31;
  vector *pvVar32;
  undefined8 *puVar33;
  char *pcVar34;
  long lVar35;
  long lVar36;
  long lVar37;
  int iVar38;
  uint uVar39;
  double dVar40;
  int iVar41;
  int iVar42;
  int iVar43;
  double dVar44;
  double dVar45;
  float fVar46;
  long local_150;
  char *local_f0;
  char *local_e8;
  char *local_e0;
  undefined8 local_d0;
  Bundle3D *local_90;
  undefined *local_88;
  void *local_80;
  undefined2 *local_78;
  undefined2 *local_70;
  Vec3 aVStack_68 [12];
  Vec3 aVStack_5c [12];
  long local_50;
  Vec3 aVStack_44 [12];
  long local_38;
  Vec3 aVStack_2c [12];
  ulong local_20;
  char *local_18;
  undefined8 local_10;
  long local_8;
  vector *pvVar11;
  
  pcVar25 = "meshes";
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  do {
    pcVar25 = pcVar25 + 1;
  } while (*pcVar25 != '\0');
  local_18 = "meshes";
  local_20 = (ulong)((int)pcVar25 + 0xfecc5b10);
  local_10 = 0x405000000000000;
  pGVar15 = rapidjson::
            GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
            ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                        *)(this + 0x28),(GenericValue *)&local_20);
  iVar5 = *(int *)pGVar15;
  if (iVar5 != 0) {
    local_150 = 0;
    do {
      local_90 = operator_new(0x90,(nothrow_t *)PTR_nothrow_01717628);
      if (local_90 != (Bundle3D *)0x0) {
        *(long *)local_90 = 0;
        *(long *)(local_90 + 8) = 0;
        *(long *)(local_90 + 0x10) = 0;
        *(undefined4 *)(local_90 + 0x18) = 0;
        *(long *)(local_90 + 0x20) = 0;
        *(long *)(local_90 + 0x28) = 0;
        *(long *)(local_90 + 0x30) = 0;
        *(long *)(local_90 + 0x38) = 0;
        *(long *)(local_90 + 0x40) = 0;
        *(long *)(local_90 + 0x48) = 0;
        *(long *)(local_90 + 0x50) = 0;
        *(long *)(local_90 + 0x58) = 0;
        *(long *)(local_90 + 0x60) = 0;
        *(undefined4 *)(local_90 + 0x68) = 0;
        *(long *)(local_90 + 0x70) = 0;
        *(long *)(local_90 + 0x78) = 0;
        *(long *)(local_90 + 0x80) = 0;
        *(undefined4 *)(local_90 + 0x88) = 0;
      }
      pcVar25 = "attributes";
      this_00 = (GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                 *)(*(long *)(pGVar15 + 8) + local_150);
      do {
        pcVar25 = pcVar25 + 1;
      } while (*pcVar25 != '\0');
      local_10 = 0x405000000000000;
      local_18 = "attributes";
      local_20 = (ulong)((int)pcVar25 + 0xfecc5b08);
      pGVar16 = rapidjson::
                GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                          (this_00,(GenericValue *)&local_20);
      uVar26 = (ulong)*(int *)pGVar16;
      *(int *)(local_90 + 0x88) = *(int *)pGVar16;
      uVar22 = *(long *)(local_90 + 0x78) - *(long *)(local_90 + 0x70) >> 4;
      if (uVar22 < uVar26) {
        std::vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>>::
        _M_default_append((vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>>
                           *)(local_90 + 0x70),uVar26 - uVar22);
      }
      else if (uVar26 < uVar22) {
        *(ulong *)(local_90 + 0x78) = *(long *)(local_90 + 0x70) + uVar26 * 0x10;
      }
      iVar6 = *(int *)pGVar16;
      if (iVar6 != 0) {
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00cd0a8c with catch @ 00cd0f9c
                        */
        lVar35 = 0;
        lVar36 = 0;
        local_d0 = "size";
        local_e0 = "type";
        local_e8 = "attribute";
        do {
                    /* try { // try from 00cd0fcc to 00dd0fcf has its CatchHandler @ 00cd09fc */
          pGVar1 = (GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                    *)(*(long *)(pGVar16 + 8) + lVar36);
          pcVar25 = local_d0;
          do {
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00cd0b20 with catch @ 00cd0fd0
                       catch(type#1 @ 00000000) { ... } // from try @ 00cd0d0c with catch @ 00cd0fd0
                       catch(type#1 @ 00000000) { ... } // from try @ 00cd1060 with catch @ 00cd0fd0
                        */
            pcVar25 = pcVar25 + 1;
          } while (*pcVar25 != '\0');
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00cd0c24 with catch @ 00cd0ff4
                        */
          local_10 = 0x405000000000000;
          local_18 = "size";
          local_20 = (ulong)((int)pcVar25 + 0xfec6b5a0);
                    /* try { // try from 00cd1000 to 00dd1003 has its CatchHandler @ 00cd1064 */
          pGVar17 = rapidjson::
                    GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                    ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                              (pGVar1,(GenericValue *)&local_20);
          iVar38 = *(int *)pGVar17;
          pcVar25 = local_e0;
          do {
            pcVar25 = pcVar25 + 1;
          } while (*pcVar25 != '\0');
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00cd0ad8 with catch @ 00cd1024
                        */
          local_10 = 0x405000000000000;
          local_18 = "type";
          local_20 = (ulong)((int)pcVar25 + 0xfec96bb8);
          pGVar17 = rapidjson::
                    GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                    ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                              (pGVar1,(GenericValue *)&local_20);
          if ((*(ushort *)(pGVar17 + 0x16) >> 0xc & 1) == 0) {
            pGVar17 = *(GenericValue **)(pGVar17 + 8);
          }
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00cd0ab0 with catch @ 00cd1050
                        */
          FUN_01211570((string *)&local_50,pGVar17,(Vec3 *)&local_38);
          pcVar25 = local_e8;
          do {
            pcVar25 = pcVar25 + 1;
                    /* try { // try from 00cd1060 to 00dd1063 has its CatchHandler @ 00cd0fd0 */
          } while (*pcVar25 != '\0');
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00cd1000 with catch @ 00cd1064
                        */
          local_10 = 0x405000000000000;
          local_18 = "attribute";
          local_20 = (ulong)((int)pcVar25 + 0xfecc5af8);
          pGVar17 = rapidjson::
                    GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                    ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                              (pGVar1,(GenericValue *)&local_20);
          if ((*(ushort *)(pGVar17 + 0x16) >> 0xc & 1) == 0) {
            pGVar17 = *(GenericValue **)(pGVar17 + 8);
          }
          FUN_01211570((Vec3 *)&local_38,pGVar17,aVStack_68);
          uVar12 = parseGLType(this,(string *)&local_50);
          uVar13 = parseGLProgramAttribute(this,(string *)&local_38);
          lVar37 = *(long *)(local_90 + 0x70) + lVar35;
          *(int *)(*(long *)(local_90 + 0x70) + lVar35) = iVar38;
          *(undefined4 *)(lVar37 + 4) = uVar12;
          *(undefined4 *)(lVar37 + 8) = uVar13;
          *(int *)(lVar37 + 0xc) = iVar38 << 2;
          if ((undefined *)(local_38 + -0x18) != PTR_DAT_017191c0) {
            FUN_00cc93d0((undefined *)(local_38 + -0x18),aVStack_68);
          }
          if ((undefined *)(local_50 + -0x18) != PTR_DAT_017191c0) {
            FUN_00cc93d0((undefined *)(local_50 + -0x18),(Vec3 *)&local_38);
          }
          lVar36 = lVar36 + 0x18;
          lVar35 = lVar35 + 0x10;
        } while (lVar36 != ((ulong)(iVar6 - 1) + 1) * 0x18);
      }
      pcVar25 = "vertices";
      do {
        pcVar25 = pcVar25 + 1;
      } while (*pcVar25 != '\0');
      local_18 = "vertices";
      local_20 = (ulong)((int)pcVar25 + 0xfed47770);
      local_10 = 0x405000000000000;
      pGVar16 = rapidjson::
                GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                          (this_00,(GenericValue *)&local_20);
      iVar6 = *(int *)pGVar16;
      *(int *)(local_90 + 0x18) = iVar6;
      if (iVar6 != 0) {
        lVar36 = 0;
        do {
          pBVar9 = local_90;
          puVar2 = (ulong *)(*(long *)(pGVar16 + 8) + lVar36);
          uVar7 = *(ushort *)((long)puVar2 + 0x16);
          if ((uVar7 >> 9 & 1) == 0) {
            if ((uVar7 >> 5 & 1) == 0) {
              if ((uVar7 >> 6 & 1) == 0) {
                if ((uVar7 >> 7 & 1) == 0) {
                  fVar46 = (float)*puVar2;
                }
                else {
                  fVar46 = (float)(long)*puVar2;
                }
              }
              else {
                fVar46 = (float)(uint)*puVar2;
              }
            }
            else {
              fVar46 = (float)(int)(uint)*puVar2;
            }
            pfVar27 = *(float **)(local_90 + 8);
            if (pfVar27 != *(float **)(local_90 + 0x10)) goto LAB_00cd11b8;
LAB_00cd1200:
            pvVar18 = *(void **)local_90;
            lVar35 = (long)pfVar27 - (long)pvVar18;
            uVar22 = lVar35 >> 2;
            if (uVar22 == 0) {
              uVar26 = 4;
LAB_00cd1220:
              pvVar19 = operator_new(uVar26);
              pvVar18 = *(void **)pBVar9;
              lVar35 = *(long *)(pBVar9 + 8) - (long)pvVar18;
              uVar22 = lVar35 >> 2;
            }
            else {
              uVar28 = uVar22 * 2;
              uVar26 = 0xfffffffffffffffc;
              if ((uVar28 < uVar22) || (0x3fffffffffffffff < uVar28)) goto LAB_00cd1220;
                    /* catch() { ... } // from try @ 00cd1eec with catch @ 00cd1ed4
                       catch() { ... } // from try @ 00cd2008 with catch @ 00cd1ed4 */
              uVar26 = uVar22 << 3;
              pvVar19 = (void *)0x0;
              if (uVar28 != 0) goto LAB_00cd1220;
            }
            if ((long)pvVar19 + lVar35 != 0) {
              *(float *)((long)pvVar19 + lVar35) = fVar46;
            }
            if (uVar22 != 0) {
              memmove(pvVar19,pvVar18,lVar35);
              pvVar18 = *(void **)pBVar9;
            }
            if (pvVar18 != (void *)0x0) {
              operator_delete(pvVar18);
            }
            *(void **)pBVar9 = pvVar19;
            *(long *)(pBVar9 + 8) = (long)pvVar19 + lVar35 + 4;
            *(ulong *)(pBVar9 + 0x10) = (long)pvVar19 + uVar26;
          }
          else {
            pfVar27 = *(float **)(local_90 + 8);
            fVar46 = (float)*(double *)(*(long *)(pGVar16 + 8) + lVar36);
            if (pfVar27 == *(float **)(local_90 + 0x10)) goto LAB_00cd1200;
LAB_00cd11b8:
            if (pfVar27 != (float *)0x0) {
              *pfVar27 = fVar46;
            }
            *(float **)(local_90 + 8) = pfVar27 + 1;
          }
          if (lVar36 + 0x18 == ((ulong)(iVar6 - 1) + 1) * 0x18) break;
          lVar36 = lVar36 + 0x18;
        } while( true );
      }
      pcVar25 = "parts";
      do {
        pcVar25 = pcVar25 + 1;
      } while (*pcVar25 != '\0');
      local_18 = "parts";
      local_20 = (ulong)((int)pcVar25 + 0xfecc5b68);
      local_10 = 0x405000000000000;
      pGVar16 = rapidjson::
                GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                          (this_00,(GenericValue *)&local_20);
      iVar6 = *(int *)pGVar16;
      if (iVar6 != 0) {
        local_e0 = (char *)0x0;
        local_f0 = "indices";
        do {
          pBVar9 = local_90;
          local_78 = (undefined2 *)0x0;
          pcVar25 = "id";
          local_70 = (undefined2 *)0x0;
          local_80 = (void *)0x0;
          pGVar1 = (GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                    *)(*(long *)(pGVar16 + 8) + (long)local_e0);
          do {
            pcVar25 = pcVar25 + 1;
          } while (*pcVar25 != '\0');
          local_10 = 0x405000000000000;
          local_18 = "id";
          local_20 = (ulong)((int)pcVar25 + 0xfecc5b48);
          pGVar17 = rapidjson::
                    GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                    ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                              (pGVar1,(GenericValue *)&local_20);
          if ((*(ushort *)(pGVar17 + 0x16) >> 0xc & 1) == 0) {
            pGVar17 = *(GenericValue **)(pGVar17 + 8);
          }
          FUN_01211570((string *)&local_88,pGVar17,(string *)&local_50);
          plVar29 = *(long **)(pBVar9 + 0x40);
          if (plVar29 == *(long **)(pBVar9 + 0x48)) {
            std::vector<std::string,std::allocator<std::string>>::_M_emplace_back_aux<std::string>
                      ((vector<std::string,std::allocator<std::string>> *)(pBVar9 + 0x38),
                       (string *)&local_88);
          }
          else {
            if (plVar29 != (long *)0x0) {
              *plVar29 = (long)local_88;
              local_88 = PTR_DAT_017191c0 + 0x18;
            }
            *(long **)(pBVar9 + 0x40) = plVar29 + 1;
          }
          pcVar25 = local_f0;
          if (local_88 + -0x18 != PTR_DAT_017191c0) {
            FUN_00cc93d0(local_88 + -0x18,(Vec3 *)&local_38);
          }
          do {
            pcVar25 = pcVar25 + 1;
          } while (*pcVar25 != '\0');
          local_18 = "indices";
          local_20 = (ulong)((int)pcVar25 + 0xfecc5ae8);
          local_10 = 0x405000000000000;
          pGVar17 = rapidjson::
                    GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                    ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                              (pGVar1,(GenericValue *)&local_20);
          if (*(int *)pGVar17 != 0) {
            lVar36 = 0;
            lVar35 = ((ulong)(*(int *)pGVar17 - 1) + 1) * 0x18;
            do {
              while (uVar8 = *(undefined2 *)(*(long *)(pGVar17 + 8) + lVar36), local_78 != local_70)
              {
                if (local_78 != (undefined2 *)0x0) {
                  *local_78 = uVar8;
                }
                lVar36 = lVar36 + 0x18;
                local_78 = local_78 + 1;
                if (lVar36 == lVar35) goto LAB_00cd14e4;
              }
              lVar37 = (long)local_78 - (long)local_80;
              uVar22 = lVar37 >> 1;
              if (uVar22 == 0) {
                uVar26 = 2;
LAB_00cd148c:
                pvVar18 = operator_new(uVar26);
                lVar37 = (long)local_78 - (long)local_80;
                uVar22 = lVar37 >> 1;
              }
              else {
                uVar26 = 0xfffffffffffffffe;
                if ((uVar22 * 2 < uVar22) || ((uVar22 & 0x7fffffffffffffff) >> 0x3e != 0))
                goto LAB_00cd148c;
                uVar26 = uVar22 << 2;
                pvVar18 = (void *)0x0;
                if (uVar22 * 2 != 0) goto LAB_00cd148c;
              }
              if ((long)pvVar18 + lVar37 != 0) {
                *(undefined2 *)((long)pvVar18 + lVar37) = uVar8;
              }
              if (uVar22 != 0) {
                memmove(pvVar18,local_80,lVar37);
              }
              puVar3 = (undefined2 *)((long)pvVar18 + lVar37 + 2);
              if (local_80 != (void *)0x0) {
                operator_delete(local_80);
              }
              lVar36 = lVar36 + 0x18;
              local_70 = (undefined2 *)((long)pvVar18 + uVar26);
              local_80 = pvVar18;
              local_78 = puVar3;
            } while (lVar36 != lVar35);
          }
LAB_00cd14e4:
          pBVar9 = local_90;
          puVar33 = *(undefined8 **)(local_90 + 0x28);
          if (puVar33 == *(undefined8 **)(local_90 + 0x30)) {
            std::
            vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
            ::_M_emplace_back_aux<std::vector<unsigned_short,std::allocator<unsigned_short>>const&>
                      ((vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
                        *)(local_90 + 0x20),(vector *)&local_80);
          }
          else {
            lVar36 = 0;
            if (puVar33 != (undefined8 *)0x0) {
              puVar33[1] = 0;
              uVar22 = (long)local_78 - (long)local_80;
              *puVar33 = 0;
              puVar33[2] = 0;
              if ((long)uVar22 >> 1 == 0) {
                pvVar18 = (void *)0x0;
              }
              else {
                if ((long)uVar22 >> 1 < 0) {
                    /* WARNING: Subroutine does not return */
                  FUN_0120f0e8();
                }
                pvVar18 = operator_new(uVar22);
              }
              *puVar33 = pvVar18;
              puVar33[1] = pvVar18;
              puVar33[2] = (long)pvVar18 + uVar22;
              lVar36 = (long)local_78 - (long)local_80;
              if (lVar36 >> 1 != 0) {
                pvVar18 = (void *)memmove(pvVar18,local_80,lVar36);
              }
              puVar33[1] = (long)pvVar18 + lVar36;
              lVar36 = *(long *)(pBVar9 + 0x28);
            }
            *(long *)(pBVar9 + 0x28) = lVar36 + 0x18;
          }
          pBVar9 = local_90;
          *(int *)(local_90 + 0x68) =
               (int)(*(long *)(local_90 + 0x28) - *(long *)(local_90 + 0x20) >> 3) * -0x55555555;
          pcVar25 = "aabb";
          do {
            pcVar34 = pcVar25;
            pcVar25 = pcVar34 + 1;
          } while (*pcVar25 != '\0');
          pcVar34 = pcVar34 + -0x133a51f;
          iVar38 = (int)pcVar34;
          piVar30 = *(int **)(this_00 + 8);
          piVar4 = piVar30 + (ulong)*(uint *)this_00 * 0xc;
          iVar24 = (int)(vector *)&local_80;
          if (piVar4 == piVar30) {
LAB_00cd1ad8:
            pvVar31 = *(vector **)(pBVar9 + 0x70);
            pvVar32 = *(vector **)(pBVar9 + 0x78);
            if (pvVar31 == pvVar32) {
              pvVar11 = (vector *)0x0;
            }
            else {
              pvVar10 = pvVar31 + 0x10;
              uVar26 = (ulong)((long)pvVar32 - (long)pvVar10) >> 4;
              uVar22 = (uVar26 - 4 >> 2) + 1;
              if (uVar26 < 4) {
                uVar39 = 0;
              }
              else {
                iVar38 = 0;
                iVar14 = 0;
                iVar41 = 0;
                iVar42 = 0;
                pvVar11 = pvVar31 + 0xc;
                uVar28 = 0;
                do {
                  iVar43 = *(int *)pvVar11;
                  uVar12 = *(undefined4 *)(pvVar11 + 0x10);
                  pvVar10 = pvVar11 + 0x20;
                  uVar13 = *(undefined4 *)(pvVar11 + 0x30);
                  pvVar11 = pvVar11 + 0x40;
                  uVar28 = uVar28 + 1;
                  local_d0._0_5_ = CONCAT14((char)uVar12,iVar43);
                  local_d0._0_6_ = CONCAT15((char)((uint)uVar12 >> 8),(undefined5)local_d0);
                  local_d0._0_7_ = CONCAT16((char)((uint)uVar12 >> 0x10),(undefined6)local_d0);
                  local_d0 = (char *)CONCAT17((char)((uint)uVar12 >> 0x18),(undefined7)local_d0);
                  iVar38 = iVar38 + iVar43;
                  iVar14 = iVar14 + (int)((ulong)local_d0 >> 0x20);
                  iVar41 = iVar41 + *(int *)pvVar10;
                  iVar42 = iVar42 + (int)(CONCAT17((char)((uint)uVar13 >> 0x18),
                                                   CONCAT16((char)((uint)uVar13 >> 0x10),
                                                            CONCAT15((char)((uint)uVar13 >> 8),
                                                                     CONCAT14((char)uVar13,
                                                                              *(int *)pvVar10)))) >>
                                         0x20);
                } while (uVar28 < uVar22);
                uVar39 = iVar38 + iVar14 + iVar41 + iVar42;
                pvVar31 = pvVar31 + uVar22 * 0x40;
                pvVar11 = (vector *)(ulong)uVar39;
                if (uVar26 + 1 == uVar22 * 4) goto LAB_00cd1bd0;
                pvVar10 = pvVar31 + 0x10;
              }
              pvVar11 = (vector *)(ulong)(uVar39 + *(int *)(pvVar31 + 0xc));
              if (pvVar32 != pvVar10) {
                uVar39 = uVar39 + *(int *)(pvVar31 + 0xc) + *(int *)(pvVar31 + 0x1c);
                pvVar11 = (vector *)(ulong)uVar39;
                if (pvVar32 != pvVar31 + 0x20) {
                  uVar39 = uVar39 + *(int *)(pvVar31 + 0x2c);
                  pvVar11 = (vector *)(ulong)uVar39;
                  if (pvVar32 != pvVar31 + 0x30) {
                    uVar39 = uVar39 + *(int *)(pvVar31 + 0x3c);
                    pvVar11 = (vector *)(ulong)uVar39;
                    if (pvVar32 != pvVar31 + 0x40) {
                      uVar39 = uVar39 + *(int *)(pvVar31 + 0x4c);
                      pvVar11 = (vector *)(ulong)uVar39;
                      if (pvVar32 != pvVar31 + 0x50) {
                        uVar39 = uVar39 + *(int *)(pvVar31 + 0x5c);
                        pvVar11 = (vector *)(ulong)uVar39;
                        if (pvVar32 != pvVar31 + 0x60) {
                          pvVar11 = (vector *)(ulong)(uVar39 + *(int *)(pvVar31 + 0x6c));
                        }
                      }
                    }
                  }
                }
              }
            }
LAB_00cd1bd0:
            calculateAABB(pBVar9,pvVar11,iVar24,pvVar31);
            pAVar20 = *(AABB **)(pBVar9 + 0x58);
            if (pAVar20 == *(AABB **)(pBVar9 + 0x60)) {
              std::vector<cocos2d::AABB,std::allocator<cocos2d::AABB>>::
              _M_emplace_back_aux<cocos2d::AABB>
                        ((vector<cocos2d::AABB,std::allocator<cocos2d::AABB>> *)(pBVar9 + 0x50),
                         (AABB *)&local_38);
            }
            else {
              lVar36 = 0;
              if (pAVar20 != (AABB *)0x0) {
                AABB::AABB(pAVar20,(AABB *)&local_38);
                lVar36 = *(long *)(pBVar9 + 0x58);
              }
              *(long *)(pBVar9 + 0x58) = lVar36 + 0x18;
            }
            Vec3::~Vec3(aVStack_2c);
            Vec3::~Vec3((Vec3 *)&local_38);
          }
          else {
            while ((*(ushort *)((long)piVar30 + 0x16) >> 0xc & 1) != 0) {
              piVar23 = piVar30;
              if (iVar38 == 0x15 - *(char *)((long)piVar30 + 0x15)) goto LAB_00cd161c;
LAB_00cd15f8:
              piVar30 = piVar30 + 0xc;
              if (piVar4 == piVar30) goto LAB_00cd1ad8;
            }
            if (iVar38 != *piVar30) goto LAB_00cd15f8;
            piVar23 = *(int **)(piVar30 + 2);
LAB_00cd161c:
            if (piVar23 == (int *)&DAT_0133a520) {
              if (piVar4 == piVar30) goto LAB_00cd1ad8;
            }
            else {
              iVar14 = memcmp(&DAT_0133a520,piVar23,(ulong)pcVar34 & 0xffffffff);
              if (iVar14 != 0) goto LAB_00cd15f8;
            }
            pcVar25 = "aabb";
            do {
              pcVar25 = pcVar25 + 1;
            } while (*pcVar25 != '\0');
            local_18 = "aabb";
            local_10 = 0x405000000000000;
            local_20 = (ulong)((int)pcVar25 + 0xfecc5ae0);
            pGVar17 = rapidjson::
                      GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                                (pGVar1,(GenericValue *)&local_20);
            pcVar25 = "aabb";
            do {
              pcVar34 = pcVar25;
              pcVar25 = pcVar34 + 1;
            } while (*pcVar25 != '\0');
            pcVar34 = pcVar34 + -0x133a51f;
            piVar30 = *(int **)(pGVar1 + 8);
            iVar38 = (int)pcVar34;
            piVar4 = piVar30 + (ulong)*(uint *)pGVar1 * 0xc;
            if (piVar30 == piVar4) goto LAB_00cd1724;
            do {
              if ((*(ushort *)((long)piVar30 + 0x16) >> 0xc & 1) == 0) {
                if (iVar38 != *piVar30) goto LAB_00cd16dc;
                piVar23 = *(int **)(piVar30 + 2);
LAB_00cd1700:
                if (piVar23 != (int *)&DAT_0133a520) {
                  iVar14 = memcmp(&DAT_0133a520,piVar23,(ulong)pcVar34 & 0xffffffff);
                  if (iVar14 != 0) goto LAB_00cd16dc;
                  if (*(int *)pGVar17 == 6) goto LAB_00cd197c;
                  break;
                }
                if ((piVar30 == piVar4) || (*(int *)pGVar17 != 6)) break;
LAB_00cd197c:
                pdVar21 = *(double **)(pGVar17 + 8);
                uVar7 = *(ushort *)((long)pdVar21 + 0x16);
                if ((uVar7 >> 9 & 1) == 0) {
                  if ((uVar7 >> 5 & 1) == 0) {
                    if ((uVar7 >> 6 & 1) == 0) {
                      if ((uVar7 >> 7 & 1) == 0) {
                        dVar40 = (double)(ulong)*pdVar21;
                      }
                      else {
                        dVar40 = (double)(long)*pdVar21;
                      }
                    }
                    else {
                      dVar40 = (double)*(uint *)pdVar21;
                    }
                  }
                  else {
                    dVar40 = (double)(int)*(uint *)pdVar21;
                  }
                }
                else {
                  dVar40 = *pdVar21;
                }
                uVar7 = *(ushort *)((long)pdVar21 + 0x2e);
                if ((uVar7 >> 9 & 1) == 0) {
                  if ((uVar7 >> 5 & 1) == 0) {
                    if ((uVar7 >> 6 & 1) == 0) {
                      if ((uVar7 >> 7 & 1) == 0) {
                        dVar44 = (double)(ulong)pdVar21[3];
                      }
                      else {
                        dVar44 = (double)(long)pdVar21[3];
                      }
                    }
                    else {
                      dVar44 = (double)*(uint *)(pdVar21 + 3);
                    }
                  }
                  else {
                    dVar44 = (double)(int)*(uint *)(pdVar21 + 3);
                  }
                }
                else {
                  dVar44 = pdVar21[3];
                }
                uVar7 = *(ushort *)((long)pdVar21 + 0x46);
                if ((uVar7 >> 9 & 1) == 0) {
                  if ((uVar7 >> 5 & 1) == 0) {
                    if ((uVar7 >> 6 & 1) == 0) {
                      if ((uVar7 >> 7 & 1) == 0) {
                        dVar45 = (double)(ulong)pdVar21[6];
                      }
                      else {
                        dVar45 = (double)(long)pdVar21[6];
                      }
                    }
                    else {
                      dVar45 = (double)*(uint *)(pdVar21 + 6);
                    }
                  }
                  else {
                    dVar45 = (double)(int)*(uint *)(pdVar21 + 6);
                  }
                }
                else {
                  dVar45 = pdVar21[6];
                }
                Vec3::Vec3((Vec3 *)&local_50,(float)dVar40,(float)dVar44,(float)dVar45);
                lVar36 = *(long *)(pGVar17 + 8);
                uVar7 = *(ushort *)(lVar36 + 0x5e);
                if ((uVar7 >> 9 & 1) == 0) {
                  if ((uVar7 >> 5 & 1) == 0) {
                    if ((uVar7 >> 6 & 1) == 0) {
                      if ((uVar7 >> 7 & 1) == 0) {
                        dVar40 = (double)*(ulong *)(lVar36 + 0x48);
                      }
                      else {
                        dVar40 = (double)(long)*(ulong *)(lVar36 + 0x48);
                      }
                    }
                    else {
                      dVar40 = (double)*(uint *)(lVar36 + 0x48);
                    }
                  }
                  else {
                    dVar40 = (double)*(int *)(lVar36 + 0x48);
                  }
                }
                else {
                  dVar40 = *(double *)(lVar36 + 0x48);
                }
                uVar7 = *(ushort *)(lVar36 + 0x76);
                if ((uVar7 >> 9 & 1) == 0) {
                  if ((uVar7 >> 5 & 1) == 0) {
                    if ((uVar7 >> 6 & 1) == 0) {
                      if ((uVar7 >> 7 & 1) == 0) {
                        dVar44 = (double)*(ulong *)(lVar36 + 0x60);
                      }
                      else {
                        dVar44 = (double)*(long *)(lVar36 + 0x60);
                      }
                    }
                    else {
                      dVar44 = (double)*(uint *)(lVar36 + 0x60);
                    }
                  }
                  else {
                    dVar44 = (double)*(int *)(lVar36 + 0x60);
                  }
                }
                else {
                  dVar44 = *(double *)(lVar36 + 0x60);
                }
                uVar7 = *(ushort *)(lVar36 + 0x8e);
                if ((uVar7 >> 9 & 1) == 0) {
                  if ((uVar7 >> 5 & 1) == 0) {
                    if ((uVar7 >> 6 & 1) == 0) {
                      if ((uVar7 >> 7 & 1) == 0) {
                        dVar45 = (double)*(ulong *)(lVar36 + 0x78);
                      }
                      else {
                        dVar45 = (double)(long)*(ulong *)(lVar36 + 0x78);
                      }
                    }
                    else {
                      dVar45 = (double)*(uint *)(lVar36 + 0x78);
                    }
                  }
                  else {
                    dVar45 = (double)*(int *)(lVar36 + 0x78);
                  }
                }
                else {
                  dVar45 = *(double *)(lVar36 + 0x78);
                }
                Vec3::Vec3((Vec3 *)&local_38,(float)dVar40,(float)dVar44,(float)dVar45);
                pBVar9 = local_90;
                AABB::AABB((AABB *)aVStack_68,(Vec3 *)&local_50,(Vec3 *)&local_38);
                pAVar20 = *(AABB **)(pBVar9 + 0x58);
                if (pAVar20 == *(AABB **)(pBVar9 + 0x60)) {
                  std::vector<cocos2d::AABB,std::allocator<cocos2d::AABB>>::
                  _M_emplace_back_aux<cocos2d::AABB>
                            ((vector<cocos2d::AABB,std::allocator<cocos2d::AABB>> *)(pBVar9 + 0x50),
                             (AABB *)aVStack_68);
                }
                else {
                  lVar36 = 0;
                  if (pAVar20 != (AABB *)0x0) {
                    AABB::AABB(pAVar20,(AABB *)aVStack_68);
                    lVar36 = *(long *)(pBVar9 + 0x58);
                  }
                  *(long *)(pBVar9 + 0x58) = lVar36 + 0x18;
                }
                Vec3::~Vec3(aVStack_5c);
                Vec3::~Vec3(aVStack_68);
                Vec3::~Vec3((Vec3 *)&local_38);
                Vec3::~Vec3((Vec3 *)&local_50);
                goto LAB_00cd186c;
              }
              piVar23 = piVar30;
              if (iVar38 == 0x15 - *(char *)((long)piVar30 + 0x15)) goto LAB_00cd1700;
LAB_00cd16dc:
              piVar30 = piVar30 + 0xc;
            } while (piVar4 != piVar30);
LAB_00cd1724:
            pBVar9 = local_90;
            pvVar31 = *(vector **)(local_90 + 0x70);
            pvVar32 = *(vector **)(local_90 + 0x78);
            if (pvVar31 == pvVar32) {
              pvVar11 = (vector *)0x0;
            }
            else {
              pvVar10 = pvVar31 + 0x10;
              uVar26 = (ulong)((long)pvVar32 - (long)pvVar10) >> 4;
              uVar22 = (uVar26 - 4 >> 2) + 1;
              if (uVar26 < 4) {
                uVar39 = 0;
              }
              else {
                iVar38 = 0;
                iVar14 = 0;
                iVar41 = 0;
                iVar42 = 0;
                pvVar11 = pvVar31 + 0xc;
                uVar28 = 0;
                do {
                  iVar43 = *(int *)pvVar11;
                  uVar12 = *(undefined4 *)(pvVar11 + 0x10);
                  pvVar10 = pvVar11 + 0x20;
                  uVar13 = *(undefined4 *)(pvVar11 + 0x30);
                  pvVar11 = pvVar11 + 0x40;
                  uVar28 = uVar28 + 1;
                  local_d0._0_5_ = CONCAT14((char)uVar12,iVar43);
                  local_d0._0_6_ = CONCAT15((char)((uint)uVar12 >> 8),(undefined5)local_d0);
                  local_d0._0_7_ = CONCAT16((char)((uint)uVar12 >> 0x10),(undefined6)local_d0);
                  local_d0 = (char *)CONCAT17((char)((uint)uVar12 >> 0x18),(undefined7)local_d0);
                  iVar38 = iVar38 + iVar43;
                  iVar14 = iVar14 + (int)((ulong)local_d0 >> 0x20);
                  iVar41 = iVar41 + *(int *)pvVar10;
                  iVar42 = iVar42 + (int)(CONCAT17((char)((uint)uVar13 >> 0x18),
                                                   CONCAT16((char)((uint)uVar13 >> 0x10),
                                                            CONCAT15((char)((uint)uVar13 >> 8),
                                                                     CONCAT14((char)uVar13,
                                                                              *(int *)pvVar10)))) >>
                                         0x20);
                } while (uVar28 < uVar22);
                uVar39 = iVar38 + iVar14 + iVar41 + iVar42;
                pvVar31 = pvVar31 + uVar22 * 0x40;
                pvVar11 = (vector *)(ulong)uVar39;
                if (uVar26 + 1 == uVar22 * 4) goto LAB_00cd1820;
                pvVar10 = pvVar31 + 0x10;
              }
              pvVar11 = (vector *)(ulong)(uVar39 + *(int *)(pvVar31 + 0xc));
              if (pvVar32 != pvVar10) {
                uVar39 = uVar39 + *(int *)(pvVar31 + 0xc) + *(int *)(pvVar31 + 0x1c);
                pvVar11 = (vector *)(ulong)uVar39;
                if (pvVar32 != pvVar31 + 0x20) {
                  uVar39 = uVar39 + *(int *)(pvVar31 + 0x2c);
                  pvVar11 = (vector *)(ulong)uVar39;
                  if (pvVar32 != pvVar31 + 0x30) {
                    uVar39 = uVar39 + *(int *)(pvVar31 + 0x3c);
                    pvVar11 = (vector *)(ulong)uVar39;
                    if (pvVar32 != pvVar31 + 0x40) {
                      uVar39 = uVar39 + *(int *)(pvVar31 + 0x4c);
                      pvVar11 = (vector *)(ulong)uVar39;
                      if (pvVar32 != pvVar31 + 0x50) {
                        uVar39 = uVar39 + *(int *)(pvVar31 + 0x5c);
                        pvVar11 = (vector *)(ulong)uVar39;
                        if (pvVar32 != pvVar31 + 0x60) {
                          pvVar11 = (vector *)(ulong)(uVar39 + *(int *)(pvVar31 + 0x6c));
                        }
                      }
                    }
                  }
                }
              }
            }
LAB_00cd1820:
            calculateAABB(local_90,pvVar11,iVar24,pvVar31);
            pAVar20 = *(AABB **)(pBVar9 + 0x58);
            if (pAVar20 == *(AABB **)(pBVar9 + 0x60)) {
              std::vector<cocos2d::AABB,std::allocator<cocos2d::AABB>>::
              _M_emplace_back_aux<cocos2d::AABB>
                        ((vector<cocos2d::AABB,std::allocator<cocos2d::AABB>> *)(pBVar9 + 0x50),
                         (AABB *)&local_50);
            }
            else {
              lVar36 = 0;
              if (pAVar20 != (AABB *)0x0) {
                AABB::AABB(pAVar20,(AABB *)&local_50);
                lVar36 = *(long *)(pBVar9 + 0x58);
              }
              *(long *)(pBVar9 + 0x58) = lVar36 + 0x18;
            }
            Vec3::~Vec3(aVStack_44);
            Vec3::~Vec3((Vec3 *)&local_50);
          }
LAB_00cd186c:
          if (local_80 != (void *)0x0) {
            operator_delete(local_80);
          }
          local_e0 = (char *)((long)local_e0 + 0x18);
        } while (local_e0 != (char *)(((ulong)(iVar6 - 1) + 1) * 0x18));
      }
      puVar33 = *(undefined8 **)(param_1 + 8);
      if (puVar33 == *(undefined8 **)(param_1 + 0x10)) {
        std::vector<cocos2d::MeshData*,std::allocator<cocos2d::MeshData*>>::
        _M_emplace_back_aux<cocos2d::MeshData*const&>
                  ((vector<cocos2d::MeshData*,std::allocator<cocos2d::MeshData*>> *)param_1,
                   (MeshData **)&local_90);
      }
      else {
        lVar36 = 0;
        if (puVar33 != (undefined8 *)0x0) {
          *puVar33 = local_90;
          lVar36 = *(long *)(param_1 + 8);
        }
        *(long *)(param_1 + 8) = lVar36 + 8;
      }
      local_150 = local_150 + 0x18;
    } while (local_150 != ((ulong)(iVar5 - 1) + 1) * 0x18);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(1);
}


/* === loadMeshDataJson_0_1 @ 00cd1f30 === */

/* cocos2d::Bundle3D::loadMeshDataJson_0_1(cocos2d::MeshDatas&) */

void __thiscall cocos2d::Bundle3D::loadMeshDataJson_0_1(Bundle3D *this,MeshDatas *param_1)

{
  ushort uVar1;
  float fVar2;
  long lVar3;
  undefined *puVar4;
  vector<float,std::allocator<float>> *pvVar5;
  vector *pvVar6;
  int iVar8;
  undefined4 uVar9;
  GenericValue *pGVar10;
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
  *this_00;
  long lVar11;
  long lVar12;
  undefined4 *puVar13;
  vector<unsigned_short,std::allocator<unsigned_short>> *this_01;
  vector *pvVar14;
  AABB *this_02;
  undefined8 *puVar15;
  ulong uVar16;
  int *piVar17;
  int *piVar18;
  int *piVar19;
  char *pcVar20;
  ulong uVar21;
  long lVar22;
  double *pdVar23;
  vector *pvVar24;
  long lVar25;
  ulong uVar26;
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
  *this_03;
  int *piVar27;
  char *pcVar28;
  long lVar29;
  int iVar30;
  uint uVar31;
  double dVar32;
  int iVar33;
  int iVar34;
  int iVar35;
  undefined4 uVar36;
  uint local_ac;
  int local_a0;
  undefined1 uStack_9c;
  undefined1 uStack_9b;
  undefined1 uStack_9a;
  undefined1 uStack_99;
  undefined1 auStack_60 [8];
  vector<float,std::allocator<float>> *local_58;
  void *local_50;
  undefined8 local_48;
  undefined8 local_40;
  long local_38;
  Vec3 aVStack_2c [12];
  ulong local_20;
  char *local_18;
  undefined8 local_10;
  long local_8;
  vector *pvVar7;
  
  pcVar20 = "mesh";
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  do {
    pcVar20 = pcVar20 + 1;
  } while (*pcVar20 != '\0');
  local_18 = "mesh";
  local_20 = (ulong)((int)pcVar20 + 0xfecc5ad8);
                    /* try { // try from 00cd1f9c to 00dd1f9f has its CatchHandler @ 00cd2040 */
  local_10 = 0x405000000000000;
  pGVar10 = rapidjson::
            GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
            ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                        *)(this + 0x28),(GenericValue *)&local_20);
  local_58 = operator_new(0x90,(nothrow_t *)PTR_nothrow_01717628);
  if (local_58 != (vector<float,std::allocator<float>> *)0x0) {
    *(undefined8 *)local_58 = 0;
    *(undefined8 *)(local_58 + 8) = 0;
    *(undefined8 *)(local_58 + 0x10) = 0;
    *(undefined4 *)(local_58 + 0x18) = 0;
    *(undefined8 *)(local_58 + 0x20) = 0;
                    /* try { // try from 00cd1fd0 to 00dd1fd3 has its CatchHandler @ 00cd200c */
    *(undefined8 *)(local_58 + 0x28) = 0;
    *(undefined8 *)(local_58 + 0x30) = 0;
    *(undefined8 *)(local_58 + 0x38) = 0;
    *(undefined8 *)(local_58 + 0x40) = 0;
    *(undefined8 *)(local_58 + 0x48) = 0;
    *(undefined8 *)(local_58 + 0x50) = 0;
    *(undefined8 *)(local_58 + 0x58) = 0;
    *(undefined8 *)(local_58 + 0x60) = 0;
    *(undefined4 *)(local_58 + 0x68) = 0;
                    /* try { // try from 00cd1ff4 to 00dd1ff7 has its CatchHandler @ 00cd1ff8 */
    *(undefined8 *)(local_58 + 0x70) = 0;
                    /* catch() { ... } // from try @ 00cd1f20 with catch @ 00cd1ff8
                       catch() { ... } // from try @ 00cd1ff4 with catch @ 00cd1ff8 */
    *(undefined8 *)(local_58 + 0x78) = 0;
    *(undefined8 *)(local_58 + 0x80) = 0;
    *(undefined4 *)(local_58 + 0x88) = 0;
  }
                    /* try { // try from 00cd2008 to 00dd200b has its CatchHandler @ 00cd1ed4 */
  this_03 = *(GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
              **)(pGVar10 + 8);
                    /* catch() { ... } // from try @ 00cd1fd0 with catch @ 00cd200c */
  pcVar20 = "body";
  do {
    pcVar20 = pcVar20 + 1;
  } while (*pcVar20 != '\0');
                    /* catch() { ... } // from try @ 00cd1f9c with catch @ 00cd2040 */
  local_18 = "body";
  local_20 = (ulong)((int)pcVar20 + 0xfecc5ad0);
  local_10 = 0x405000000000000;
  pGVar10 = rapidjson::
            GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
            ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      (this_03,(GenericValue *)&local_20);
  this_00 = *(GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
              **)(pGVar10 + 8);
  pcVar20 = "attributes";
  do {
    pcVar20 = pcVar20 + 1;
  } while (*pcVar20 != '\0');
                    /* catch() { ... } // from try @ 00cd20bc with catch @ 00cd2088 */
  local_18 = "attributes";
  local_20 = (ulong)((int)pcVar20 + 0xfecc5b08);
  local_10 = 0x405000000000000;
  pGVar10 = rapidjson::
            GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
            ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      (this_03,(GenericValue *)&local_20);
  uVar21 = (ulong)*(int *)pGVar10;
                    /* try { // try from 00cd20ac to 00dd20af has its CatchHandler @ 00cd2104 */
  *(int *)(local_58 + 0x88) = *(int *)pGVar10;
  uVar16 = *(long *)(local_58 + 0x78) - *(long *)(local_58 + 0x70) >> 4;
                    /* try { // try from 00cd20bc to 00dd211b has its CatchHandler @ 00cd2088 */
  if (uVar16 < uVar21) {
    std::vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>>::
    _M_default_append((vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>> *
                      )(local_58 + 0x70),uVar21 - uVar16);
  }
  else if (uVar21 < uVar16) {
    *(ulong *)(local_58 + 0x78) = *(long *)(local_58 + 0x70) + uVar21 * 0x10;
  }
  if (*(int *)pGVar10 != 0) {
    local_ac = 0;
                    /* catch() { ... } // from try @ 00cd20ac with catch @ 00cd2104 */
    do {
      lVar29 = *(long *)(pGVar10 + 8);
      lVar11 = *(long *)(local_58 + 0x70);
                    /* catch() { ... } // from try @ 00cd218c with catch @ 00cd2120 */
      lVar3 = (ulong)local_ac * 0x18;
      lVar22 = (ulong)local_ac * 0x10;
      lVar12 = lVar11 + lVar22;
      lVar25 = lVar29 + lVar3;
      pcVar20 = "size";
      do {
        pcVar28 = pcVar20;
        pcVar20 = pcVar28 + 1;
      } while (*pcVar20 != '\0');
      pcVar28 = pcVar28 + -0x1394a5f;
      iVar30 = (int)pcVar28;
      piVar27 = *(int **)(lVar25 + 8);
      piVar19 = piVar27 + (ulong)*(uint *)(lVar29 + lVar3) * 0xc;
      if (piVar27 != piVar19) {
        piVar18 = piVar27;
                    /* try { // try from 00cd218c to 00dd218f has its CatchHandler @ 00cd2120 */
        do {
          if ((*(ushort *)((long)piVar18 + 0x16) >> 0xc & 1) == 0) {
            if (iVar30 == *piVar18) {
              piVar17 = *(int **)(piVar18 + 2);
LAB_00cd21c8:
              if (piVar17 == (int *)0x1394a60) {
                if (piVar19 == piVar18) break;
              }
              else {
                iVar8 = memcmp("size",piVar17,(ulong)pcVar28 & 0xffffffff);
                if (iVar8 != 0) goto LAB_00cd21a4;
              }
              iVar30 = piVar18[6] << 2;
              iVar8 = piVar18[6];
              goto LAB_00cd21e8;
            }
          }
          else {
                    /* catch() { ... } // from try @ 00cd2214 with catch @ 00cd2190 */
            piVar17 = piVar18;
            if (iVar30 == 0x15 - *(char *)((long)piVar18 + 0x15)) goto LAB_00cd21c8;
          }
LAB_00cd21a4:
          piVar18 = piVar18 + 0xc;
        } while (piVar19 != piVar18);
      }
      puVar4 = PTR_buffer_01719d48;
      if (PTR_buffer_01719d48 == (undefined *)0x0) {
        iVar30 = iRam0000000000000000 << 2;
        iVar8 = iRam0000000000000000;
      }
      else {
        iVar30 = 0;
        *(undefined8 *)PTR_buffer_01719d48 = 0;
        *(undefined8 *)(puVar4 + 8) = 0;
        *(undefined8 *)(puVar4 + 0x10) = 0;
        piVar27 = *(int **)(lVar25 + 8);
        iVar8 = 0;
      }
LAB_00cd21e8:
      *(int *)(lVar11 + lVar22) = iVar8;
      *(int *)(lVar12 + 0xc) = iVar30;
      pcVar20 = "type";
      do {
        pcVar28 = pcVar20;
        pcVar20 = pcVar28 + 1;
      } while (*pcVar20 != '\0');
                    /* try { // try from 00cd2214 to 00dd229b has its CatchHandler @ 00cd2190 */
      pcVar28 = pcVar28 + -0x1369447;
      iVar30 = (int)pcVar28;
      piVar19 = piVar27 + (ulong)*(uint *)(lVar29 + lVar3) * 0xc;
      if (piVar19 != piVar27) {
        do {
          if ((*(ushort *)((long)piVar27 + 0x16) >> 0xc & 1) == 0) {
            if (iVar30 == *piVar27) {
              piVar18 = *(int **)(piVar27 + 2);
LAB_00cd2280:
              if (piVar18 == (int *)0x1369448) {
                if (piVar19 == piVar27) break;
              }
              else {
                iVar8 = memcmp("type",piVar18,(ulong)pcVar28 & 0xffffffff);
                if (iVar8 != 0) goto LAB_00cd225c;
              }
                    /* catch() { ... } // from try @ 00cd22d0 with catch @ 00cd22a4
                       catch() { ... } // from try @ 00cd2334 with catch @ 00cd22a4 */
              piVar19 = piVar27 + 6;
              uVar1 = *(ushort *)((long)piVar27 + 0x2e);
              goto LAB_00cd22a8;
            }
          }
          else {
            piVar18 = piVar27;
            if (iVar30 == 0x15 - *(char *)((long)piVar27 + 0x15)) goto LAB_00cd2280;
          }
LAB_00cd225c:
          piVar27 = piVar27 + 0xc;
        } while (piVar19 != piVar27);
      }
      piVar19 = (int *)PTR_buffer_01719d48;
      uVar1 = uRam0000000000000016;
      if (PTR_buffer_01719d48 == (undefined *)0x0) {
LAB_00cd22a8:
        if ((uVar1 & 0x1000) == 0) goto LAB_00cd26c0;
      }
      else {
        *(undefined8 *)PTR_buffer_01719d48 = 0;
        *(undefined8 *)((long)piVar19 + 8) = 0;
        *(undefined8 *)((long)piVar19 + 0x10) = 0;
LAB_00cd26c0:
        piVar19 = *(int **)(piVar19 + 2);
      }
      FUN_01211570((string *)&local_38,piVar19,auStack_60);
      uVar9 = parseGLType(this,(string *)&local_38);
      *(undefined4 *)(lVar12 + 4) = uVar9;
                    /* try { // try from 00cd22d0 to 00dd22e7 has its CatchHandler @ 00cd22a4 */
      if ((undefined *)(local_38 + -0x18) != PTR_DAT_017191c0) {
        FUN_00cc93d0((undefined *)(local_38 + -0x18),&local_50);
      }
                    /* try { // try from 00cd22f0 to 00dd22f3 has its CatchHandler @ 00cd2324 */
      lVar12 = *(long *)(local_58 + 0x70);
      pcVar20 = "attribute";
      do {
        pcVar28 = pcVar20;
        pcVar20 = pcVar28 + 1;
      } while (*pcVar20 != '\0');
      pcVar28 = pcVar28 + -0x133a507;
      iVar30 = (int)pcVar28;
      piVar27 = *(int **)(lVar25 + 8);
      piVar19 = piVar27 + (ulong)*(uint *)(lVar29 + lVar3) * 0xc;
                    /* catch() { ... } // from try @ 00cd22f0 with catch @ 00cd2324 */
      if (piVar19 != piVar27) {
                    /* try { // try from 00cd2334 to 00dd2337 has its CatchHandler @ 00cd22a4 */
        do {
          if ((*(ushort *)((long)piVar27 + 0x16) >> 0xc & 1) == 0) {
                    /* try { // try from 00cd2364 to 00dd2377 has its CatchHandler @ 00cd2338 */
            if (iVar30 == *piVar27) {
              piVar18 = *(int **)(piVar27 + 2);
LAB_00cd2370:
              if (piVar18 == (int *)"attribute") {
                if (piVar19 == piVar27) break;
              }
              else {
                    /* try { // try from 00cd2380 to 00dd2383 has its CatchHandler @ 00cd23b4 */
                iVar8 = memcmp("attribute",piVar18,(ulong)pcVar28 & 0xffffffff);
                if (iVar8 != 0) goto LAB_00cd234c;
              }
              piVar19 = piVar27 + 6;
              uVar1 = *(ushort *)((long)piVar27 + 0x2e);
              goto LAB_00cd2398;
            }
          }
          else {
                    /* catch() { ... } // from try @ 00cd2364 with catch @ 00cd2338
                       catch() { ... } // from try @ 00cd23c4 with catch @ 00cd2338 */
            piVar18 = piVar27;
            if (iVar30 == 0x15 - *(char *)((long)piVar27 + 0x15)) goto LAB_00cd2370;
          }
LAB_00cd234c:
          piVar27 = piVar27 + 0xc;
        } while (piVar19 != piVar27);
      }
      piVar19 = (int *)PTR_buffer_01719d48;
                    /* catch() { ... } // from try @ 00cd26fc with catch @ 00cd2690 */
      uVar1 = uRam0000000000000016;
      if (PTR_buffer_01719d48 == (undefined *)0x0) {
LAB_00cd2398:
        if ((uVar1 & 0x1000) == 0) goto LAB_00cd269c;
      }
      else {
        *(undefined8 *)PTR_buffer_01719d48 = 0;
        *(undefined8 *)((long)piVar19 + 8) = 0;
        *(undefined8 *)((long)piVar19 + 0x10) = 0;
LAB_00cd269c:
        piVar19 = *(int **)(piVar19 + 2);
      }
      FUN_01211570((string *)&local_38,piVar19,auStack_60);
      uVar9 = parseGLProgramAttribute(this,(string *)&local_38);
                    /* catch() { ... } // from try @ 00cd2380 with catch @ 00cd23b4 */
      *(undefined4 *)(lVar12 + lVar22 + 8) = uVar9;
                    /* try { // try from 00cd23c4 to 00dd23c7 has its CatchHandler @ 00cd2338 */
                    /* catch() { ... } // from try @ 00cd23f4 with catch @ 00cd23c8
                       catch() { ... } // from try @ 00cd2454 with catch @ 00cd23c8 */
      if ((undefined *)(local_38 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00cd26fc to 00dd275f has its CatchHandler @ 00cd2690 */
        FUN_00cc93d0((undefined *)(local_38 + -0x18),&local_50);
      }
      local_ac = local_ac + 1;
    } while (local_ac < *(uint *)pGVar10);
  }
  pvVar5 = local_58;
                    /* try { // try from 00cd23f4 to 00dd2407 has its CatchHandler @ 00cd23c8 */
  pcVar20 = "vertexsize";
  do {
    pcVar20 = pcVar20 + 1;
  } while (*pcVar20 != '\0');
                    /* try { // try from 00cd2410 to 00dd2413 has its CatchHandler @ 00cd2444 */
  local_18 = "vertexsize";
  local_10 = 0x405000000000000;
  local_20 = (ulong)((int)pcVar20 + 0xfecc5ac8);
  pGVar10 = rapidjson::
            GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
            ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      (this_00,(GenericValue *)&local_20);
  *(undefined4 *)(pvVar5 + 0x18) = *(undefined4 *)pGVar10;
                    /* catch() { ... } // from try @ 00cd2410 with catch @ 00cd2444 */
  uVar21 = (ulong)*(int *)(local_58 + 0x18);
  uVar16 = *(long *)(local_58 + 8) - *(long *)local_58 >> 2;
                    /* try { // try from 00cd2454 to 00dd2457 has its CatchHandler @ 00cd23c8 */
  if (uVar16 < uVar21) {
    std::vector<float,std::allocator<float>>::_M_default_append(local_58,uVar21 - uVar16);
  }
  else {
                    /* catch() { ... } // from try @ 00cd2484 with catch @ 00cd2458
                       catch() { ... } // from try @ 00cd24e8 with catch @ 00cd2458 */
    if (uVar21 < uVar16) {
                    /* catch() { ... } // from try @ 00cd2798 with catch @ 00cd2760
                       catch() { ... } // from try @ 00cd2a34 with catch @ 00cd2760 */
      *(ulong *)(local_58 + 8) = *(long *)local_58 + uVar21 * 4;
    }
  }
  pcVar20 = "vertices";
  do {
    pcVar20 = pcVar20 + 1;
  } while (*pcVar20 != '\0');
                    /* try { // try from 00cd2484 to 00dd249b has its CatchHandler @ 00cd2458 */
  local_18 = "vertices";
  local_10 = 0x405000000000000;
  local_20 = (ulong)((int)pcVar20 + 0xfed47770);
  pGVar10 = rapidjson::
            GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
            ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      (this_00,(GenericValue *)&local_20);
  uVar31 = *(uint *)pGVar10;
  if (uVar31 != 0) {
                    /* try { // try from 00cd24a4 to 00dd24a7 has its CatchHandler @ 00cd24d8 */
    pdVar23 = *(double **)(pGVar10 + 8);
    lVar12 = 0;
    lVar25 = *(long *)local_58;
    do {
                    /* try { // try from 00cd24e8 to 00dd24eb has its CatchHandler @ 00cd2458 */
      while (uVar1 = *(ushort *)((long)pdVar23 + 0x16), (uVar1 >> 9 & 1) == 0) {
        if ((uVar1 >> 5 & 1) == 0) {
          if ((uVar1 >> 6 & 1) == 0) {
            if ((uVar1 >> 7 & 1) == 0) {
              fVar2 = (float)(ulong)*pdVar23;
            }
            else {
              fVar2 = (float)(long)*pdVar23;
            }
          }
          else {
            fVar2 = (float)*(uint *)pdVar23;
          }
        }
        else {
          fVar2 = (float)(int)*(uint *)pdVar23;
        }
        pdVar23 = pdVar23 + 3;
        *(float *)(lVar25 + lVar12 * 4) = fVar2;
                    /* catch() { ... } // from try @ 00cd24a4 with catch @ 00cd24d8 */
        lVar12 = lVar12 + 1;
        if (uVar31 <= (uint)lVar12) goto LAB_00cd2508;
      }
                    /* catch() { ... } // from try @ 00cd2558 with catch @ 00cd24ec */
      dVar32 = *pdVar23;
      pdVar23 = pdVar23 + 3;
      *(float *)(lVar25 + lVar12 * 4) = (float)dVar32;
      lVar12 = lVar12 + 1;
    } while ((uint)lVar12 < uVar31);
  }
LAB_00cd2508:
  pcVar20 = "indexnum";
  do {
    pcVar20 = pcVar20 + 1;
  } while (*pcVar20 != '\0');
  local_18 = "indexnum";
  local_10 = 0x405000000000000;
  local_20 = (ulong)((int)pcVar20 + 0xfecc5ab8);
  pGVar10 = rapidjson::
            GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
            ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      (this_00,(GenericValue *)&local_20);
  local_50 = (void *)0x0;
  local_48 = 0;
                    /* try { // try from 00cd2558 to 00dd25bf has its CatchHandler @ 00cd24ec */
  local_40 = 0;
  if ((ulong)*(uint *)pGVar10 != 0) {
    std::vector<unsigned_short,std::allocator<unsigned_short>>::_M_default_append
              ((vector<unsigned_short,std::allocator<unsigned_short>> *)&local_50,
               (ulong)*(uint *)pGVar10);
  }
  pcVar20 = "indices";
  do {
    pcVar20 = pcVar20 + 1;
  } while (*pcVar20 != '\0');
  local_18 = "indices";
  local_10 = 0x405000000000000;
  local_20 = (ulong)((int)pcVar20 + 0xfecc5ae8);
  pGVar10 = rapidjson::
            GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
            ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      (this_00,(GenericValue *)&local_20);
  pvVar5 = local_58;
  uVar31 = *(uint *)pGVar10;
  if (uVar31 != 0) {
    lVar12 = 0;
    puVar13 = *(undefined4 **)(pGVar10 + 8);
    do {
      *(short *)((long)local_50 + lVar12 * 2) = (short)*puVar13;
                    /* catch() { ... } // from try @ 00cd262c with catch @ 00cd25c0 */
      lVar12 = lVar12 + 1;
      puVar13 = puVar13 + 6;
    } while ((uint)lVar12 < uVar31);
  }
  this_01 = *(vector<unsigned_short,std::allocator<unsigned_short>> **)(local_58 + 0x28);
  if (this_01 == *(vector<unsigned_short,std::allocator<unsigned_short>> **)(local_58 + 0x30)) {
    std::
    vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
    ::_M_emplace_back_aux<std::vector<unsigned_short,std::allocator<unsigned_short>>const&>
              ((vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
                *)(local_58 + 0x20),(vector *)&local_50);
  }
  else {
    lVar12 = 0;
    if (this_01 != (vector<unsigned_short,std::allocator<unsigned_short>> *)0x0) {
      std::vector<unsigned_short,std::allocator<unsigned_short>>::vector
                (this_01,(vector *)&local_50);
      lVar12 = *(long *)(pvVar5 + 0x28);
    }
    *(long *)(pvVar5 + 0x28) = lVar12 + 0x18;
  }
  pvVar5 = local_58;
  pvVar14 = *(vector **)(local_58 + 0x70);
  pvVar24 = *(vector **)(local_58 + 0x78);
  if (pvVar14 == pvVar24) {
    pvVar7 = (vector *)0x0;
  }
  else {
    pvVar6 = pvVar14 + 0x10;
    uVar21 = (ulong)((long)pvVar24 - (long)pvVar6) >> 4;
                    /* try { // try from 00cd262c to 00dd268f has its CatchHandler @ 00cd25c0 */
    uVar16 = (uVar21 - 4 >> 2) + 1;
    if (uVar21 < 4) {
      uVar31 = 0;
    }
    else {
      iVar30 = 0;
      iVar8 = 0;
      iVar33 = 0;
      iVar34 = 0;
      pvVar7 = pvVar14 + 0xc;
      uVar26 = 0;
      do {
        iVar35 = *(int *)pvVar7;
        uVar9 = *(undefined4 *)(pvVar7 + 0x10);
        pvVar6 = pvVar7 + 0x20;
        uVar36 = *(undefined4 *)(pvVar7 + 0x30);
        pvVar7 = pvVar7 + 0x40;
        uVar26 = uVar26 + 1;
        _local_a0 = CONCAT17((char)((uint)uVar9 >> 0x18),
                             CONCAT16((char)((uint)uVar9 >> 0x10),
                                      CONCAT15((char)((uint)uVar9 >> 8),CONCAT14((char)uVar9,iVar35)
                                              )));
        iVar30 = iVar30 + iVar35;
        iVar8 = iVar8 + (int)((ulong)_local_a0 >> 0x20);
        iVar33 = iVar33 + *(int *)pvVar6;
        iVar34 = iVar34 + (int)(CONCAT17((char)((uint)uVar36 >> 0x18),
                                         CONCAT16((char)((uint)uVar36 >> 0x10),
                                                  CONCAT15((char)((uint)uVar36 >> 8),
                                                           CONCAT14((char)uVar36,*(int *)pvVar6))))
                               >> 0x20);
      } while (uVar26 < uVar16);
      uVar31 = iVar30 + iVar8 + iVar33 + iVar34;
      pvVar14 = pvVar14 + uVar16 * 0x40;
      pvVar7 = (vector *)(ulong)uVar31;
      if (uVar16 * 4 - (uVar21 + 1) == 0) goto LAB_00cd27f8;
      pvVar6 = pvVar14 + 0x10;
    }
    pvVar7 = (vector *)(ulong)(uVar31 + *(int *)(pvVar14 + 0xc));
    if (pvVar24 != pvVar6) {
                    /* try { // try from 00cd2798 to 00dd27af has its CatchHandler @ 00cd2760 */
      uVar31 = uVar31 + *(int *)(pvVar14 + 0xc) + *(int *)(pvVar14 + 0x1c);
      pvVar7 = (vector *)(ulong)uVar31;
      if (pvVar24 != pvVar14 + 0x20) {
        uVar31 = uVar31 + *(int *)(pvVar14 + 0x2c);
        pvVar7 = (vector *)(ulong)uVar31;
        if (pvVar24 != pvVar14 + 0x30) {
          uVar31 = uVar31 + *(int *)(pvVar14 + 0x3c);
          pvVar7 = (vector *)(ulong)uVar31;
          if (pvVar24 != pvVar14 + 0x40) {
            uVar31 = uVar31 + *(int *)(pvVar14 + 0x4c);
            pvVar7 = (vector *)(ulong)uVar31;
            if (pvVar24 != pvVar14 + 0x50) {
              uVar31 = uVar31 + *(int *)(pvVar14 + 0x5c);
              pvVar7 = (vector *)(ulong)uVar31;
              if (pvVar24 != pvVar14 + 0x60) {
                pvVar7 = (vector *)(ulong)(uVar31 + *(int *)(pvVar14 + 0x6c));
              }
            }
          }
        }
      }
    }
  }
LAB_00cd27f8:
  calculateAABB((Bundle3D *)local_58,pvVar7,(int)(vector *)&local_50,pvVar24);
                    /* try { // try from 00cd280c to 00dd280f has its CatchHandler @ 00cd29d8 */
  this_02 = *(AABB **)(pvVar5 + 0x58);
  if (this_02 == *(AABB **)(pvVar5 + 0x60)) {
    std::vector<cocos2d::AABB,std::allocator<cocos2d::AABB>>::_M_emplace_back_aux<cocos2d::AABB>
              ((vector<cocos2d::AABB,std::allocator<cocos2d::AABB>> *)(pvVar5 + 0x50),
               (AABB *)&local_38);
  }
  else {
    lVar12 = 0;
    if (this_02 != (AABB *)0x0) {
      AABB::AABB(this_02,(AABB *)&local_38);
      lVar12 = *(long *)(pvVar5 + 0x58);
    }
    *(long *)(pvVar5 + 0x58) = lVar12 + 0x18;
  }
  Vec3::~Vec3(aVStack_2c);
  Vec3::~Vec3((Vec3 *)&local_38);
  puVar15 = *(undefined8 **)(param_1 + 8);
  if (puVar15 == *(undefined8 **)(param_1 + 0x10)) {
    std::vector<cocos2d::MeshData*,std::allocator<cocos2d::MeshData*>>::
    _M_emplace_back_aux<cocos2d::MeshData*const&>
              ((vector<cocos2d::MeshData*,std::allocator<cocos2d::MeshData*>> *)param_1,
               (MeshData **)&local_58);
  }
  else {
    lVar12 = 0;
    if (puVar15 != (undefined8 *)0x0) {
      *puVar15 = local_58;
      lVar12 = *(long *)(param_1 + 8);
    }
    *(long *)(param_1 + 8) = lVar12 + 8;
  }
  if (local_50 != (void *)0x0) {
    operator_delete(local_50);
  }
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(1);
  }
  return;
}


/* === loadMeshDataJson_0_2 @ 00cd2ad4 === */

/* cocos2d::Bundle3D::loadMeshDataJson_0_2(cocos2d::MeshDatas&) */

void __thiscall cocos2d::Bundle3D::loadMeshDataJson_0_2(Bundle3D *this,MeshDatas *param_1)

{
  double dVar1;
  undefined *puVar2;
  vector<float,std::allocator<float>> *pvVar3;
  vector *pvVar4;
  undefined4 uVar6;
  int iVar7;
  GenericValue *pGVar8;
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
  *this_00;
  GenericValue *pGVar9;
  ulong uVar10;
  AABB *this_01;
  ulong uVar11;
  int *piVar12;
  undefined4 *puVar13;
  ulong uVar14;
  int *piVar15;
  char *pcVar16;
  ulong uVar17;
  int *piVar18;
  void *pvVar19;
  vector *pvVar20;
  vector *pvVar21;
  char *pcVar22;
  char *pcVar23;
  long lVar24;
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
  *pGVar25;
  undefined8 *puVar26;
  vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
  *this_02;
  long lVar27;
  int iVar28;
  uint uVar29;
  int iVar30;
  int iVar31;
  int iVar32;
  undefined4 uVar33;
  char *local_b8;
  char *local_b0;
  int local_a0;
  undefined1 uStack_9c;
  undefined1 uStack_9b;
  undefined1 uStack_9a;
  undefined1 uStack_99;
  undefined1 auStack_60 [8];
  vector<float,std::allocator<float>> *local_58;
  void *local_50;
  long local_48;
  undefined8 local_40;
  long local_38;
  Vec3 aVStack_2c [12];
  ulong local_20;
  char *local_18;
  undefined8 local_10;
  long local_8;
  vector *pvVar5;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  local_58 = operator_new(0x90,(nothrow_t *)PTR_nothrow_01717628);
  if (local_58 != (vector<float,std::allocator<float>> *)0x0) {
    *(undefined8 *)local_58 = 0;
    *(undefined8 *)(local_58 + 8) = 0;
    *(undefined8 *)(local_58 + 0x10) = 0;
    *(undefined4 *)(local_58 + 0x18) = 0;
    *(undefined8 *)(local_58 + 0x20) = 0;
    *(undefined8 *)(local_58 + 0x28) = 0;
    *(undefined8 *)(local_58 + 0x30) = 0;
    *(undefined8 *)(local_58 + 0x38) = 0;
    *(undefined8 *)(local_58 + 0x40) = 0;
    *(undefined8 *)(local_58 + 0x48) = 0;
    *(undefined8 *)(local_58 + 0x50) = 0;
    *(undefined8 *)(local_58 + 0x58) = 0;
    *(undefined8 *)(local_58 + 0x60) = 0;
    *(undefined4 *)(local_58 + 0x68) = 0;
    *(undefined8 *)(local_58 + 0x70) = 0;
    *(undefined8 *)(local_58 + 0x78) = 0;
    *(undefined8 *)(local_58 + 0x80) = 0;
    *(undefined4 *)(local_58 + 0x88) = 0;
  }
  pcVar16 = "mesh";
  do {
    pcVar16 = pcVar16 + 1;
  } while (*pcVar16 != '\0');
  local_18 = "mesh";
  local_20 = (ulong)((int)pcVar16 + 0xfecc5ad8);
  local_10 = 0x405000000000000;
  pGVar8 = rapidjson::
           GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
           ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                     ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                       *)(this + 0x28),(GenericValue *)&local_20);
  this_00 = *(GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
              **)(pGVar8 + 8);
  pcVar16 = "attributes";
  do {
    pcVar16 = pcVar16 + 1;
  } while (*pcVar16 != '\0');
                    /* try { // try from 00cd2bc4 to 00dd2bc7 has its CatchHandler @ 00cd2f08 */
                    /* try { // try from 00cd2bdc to 00dd2bfb has its CatchHandler @ 00cd2e98 */
  local_18 = "attributes";
  local_20 = (ulong)((int)pcVar16 + 0xfecc5b08);
  local_10 = 0x405000000000000;
  pGVar8 = rapidjson::
           GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
           ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                     (this_00,(GenericValue *)&local_20);
  uVar17 = (ulong)*(int *)pGVar8;
                    /* try { // try from 00cd2c0c to 00dd2c0f has its CatchHandler @ 00cd2f00 */
  *(int *)(local_58 + 0x88) = *(int *)pGVar8;
  uVar11 = *(long *)(local_58 + 0x78) - *(long *)(local_58 + 0x70) >> 4;
                    /* try { // try from 00cd2c1c to 00dd2c1f has its CatchHandler @ 00cd2ec0 */
  if (uVar11 < uVar17) {
    std::vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>>::
    _M_default_append((vector<cocos2d::MeshVertexAttrib,std::allocator<cocos2d::MeshVertexAttrib>> *
                      )(local_58 + 0x70),uVar17 - uVar11);
  }
  else if (uVar17 < uVar11) {
    *(ulong *)(local_58 + 0x78) = *(long *)(local_58 + 0x70) + uVar17 * 0x10;
  }
  if (*(int *)pGVar8 != 0) {
                    /* try { // try from 00cd2c50 to 00dd2d03 has its CatchHandler @ 00cd2e98 */
    uVar11 = 0;
    local_b0 = "size";
    local_b8 = "type";
    do {
      lVar27 = *(long *)(local_58 + 0x70);
      lVar24 = uVar11 * 0x10;
      pGVar25 = (GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                 *)(*(long *)(pGVar8 + 8) + uVar11 * 0x18);
      pcVar16 = local_b0;
      do {
        pcVar16 = pcVar16 + 1;
      } while (*pcVar16 != '\0');
      local_10 = 0x405000000000000;
      local_18 = "size";
      local_20 = (ulong)((int)pcVar16 + 0xfec6b5a0);
      pGVar9 = rapidjson::
               GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
               ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                         (pGVar25,(GenericValue *)&local_20);
      *(undefined4 *)(lVar27 + lVar24) = *(undefined4 *)pGVar9;
      lVar27 = *(long *)(local_58 + 0x70) + lVar24;
      *(int *)(lVar27 + 0xc) = *(int *)(*(long *)(local_58 + 0x70) + lVar24) << 2;
      pcVar16 = local_b8;
      do {
        pcVar16 = pcVar16 + 1;
      } while (*pcVar16 != '\0');
                    /* try { // try from 00cd2d0c to 00dd2d0f has its CatchHandler @ 00cd2f2c */
      local_10 = 0x405000000000000;
      local_18 = "type";
      local_20 = (ulong)((int)pcVar16 + 0xfec96bb8);
      pGVar9 = rapidjson::
               GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
               ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                         (pGVar25,(GenericValue *)&local_20);
      if ((*(ushort *)(pGVar9 + 0x16) >> 0xc & 1) == 0) {
        pGVar9 = *(GenericValue **)(pGVar9 + 8);
      }
      FUN_01211570((string *)&local_38,pGVar9,auStack_60);
      uVar6 = parseGLType(this,(string *)&local_38);
      *(undefined4 *)(lVar27 + 4) = uVar6;
      if ((undefined *)(local_38 + -0x18) != PTR_DAT_017191c0) {
        FUN_00cc93d0((undefined *)(local_38 + -0x18),&local_50);
      }
      lVar27 = *(long *)(local_58 + 0x70);
      pcVar16 = "attribute";
      do {
        pcVar16 = pcVar16 + 1;
      } while (*pcVar16 != '\0');
      local_10 = 0x405000000000000;
      local_18 = "attribute";
      local_20 = (ulong)((int)pcVar16 + 0xfecc5af8);
      pGVar9 = rapidjson::
               GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
               ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                         (pGVar25,(GenericValue *)&local_20);
      if ((*(ushort *)(pGVar9 + 0x16) >> 0xc & 1) == 0) {
        pGVar9 = *(GenericValue **)(pGVar9 + 8);
      }
      FUN_01211570((string *)&local_38,pGVar9,auStack_60);
      uVar6 = parseGLProgramAttribute(this,(string *)&local_38);
      *(undefined4 *)(lVar27 + lVar24 + 8) = uVar6;
      if ((undefined *)(local_38 + -0x18) != PTR_DAT_017191c0) {
        FUN_00cc93d0((undefined *)(local_38 + -0x18),&local_50);
      }
      uVar29 = (int)uVar11 + 1;
      uVar11 = (ulong)uVar29;
    } while (uVar29 < *(uint *)pGVar8);
  }
  pcVar16 = "vertex";
  do {
    pcVar16 = pcVar16 + 1;
  } while (*pcVar16 != '\0');
  local_18 = "vertex";
  local_20 = (ulong)((int)pcVar16 + 0xfeccb690);
  local_10 = 0x405000000000000;
  pGVar8 = rapidjson::
           GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
           ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                     (this_00,(GenericValue *)&local_20);
  pvVar3 = local_58;
  pGVar25 = *(GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
              **)(pGVar8 + 8);
  pcVar16 = "vertexsize";
  do {
    pcVar16 = pcVar16 + 1;
  } while (*pcVar16 != '\0');
  local_18 = "vertexsize";
  local_20 = (ulong)((int)pcVar16 + 0xfecc5ac8);
  local_10 = 0x405000000000000;
  pGVar8 = rapidjson::
           GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
           ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                     (pGVar25,(GenericValue *)&local_20);
  *(undefined4 *)(pvVar3 + 0x18) = *(undefined4 *)pGVar8;
  uVar17 = (ulong)*(int *)(local_58 + 0x18);
  uVar11 = *(long *)(local_58 + 8) - *(long *)local_58 >> 2;
                    /* catch() { ... } // from try @ 00cd2a88 with catch @ 00cd2e98
                       catch() { ... } // from try @ 00cd2bdc with catch @ 00cd2e98
                       catch() { ... } // from try @ 00cd2c50 with catch @ 00cd2e98 */
  if (uVar11 < uVar17) {
    std::vector<float,std::allocator<float>>::_M_default_append(local_58,uVar17 - uVar11);
  }
  else if (uVar17 < uVar11) {
    *(ulong *)(local_58 + 8) = *(long *)local_58 + uVar17 * 4;
  }
  pcVar16 = "vertices";
  do {
    pcVar16 = pcVar16 + 1;
  } while (*pcVar16 != '\0');
                    /* try { // try from 00cd2ebc to 00dd2ebf has its CatchHandler @ 00cd2a38 */
                    /* catch() { ... } // from try @ 00cd2c1c with catch @ 00cd2ec0 */
  local_18 = "vertices";
  local_20 = (ulong)((int)pcVar16 + 0xfed47770);
  local_10 = 0x405000000000000;
  pGVar8 = rapidjson::
           GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
           ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                     (pGVar25,(GenericValue *)&local_20);
  uVar29 = *(uint *)pGVar8;
  if (uVar29 != 0) {
    lVar24 = 0;
    lVar27 = *(long *)local_58;
    pGVar25 = *(GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                **)(pGVar8 + 8);
    do {
                    /* catch() { ... } // from try @ 00cd2c0c with catch @ 00cd2f00 */
      dVar1 = (double)rapidjson::
                      GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                      ::GetDouble(pGVar25);
                    /* catch() { ... } // from try @ 00cd2bc4 with catch @ 00cd2f08 */
      *(float *)(lVar27 + lVar24 * 4) = (float)dVar1;
      lVar24 = lVar24 + 1;
      pGVar25 = pGVar25 + 0x18;
    } while ((uint)lVar24 < uVar29);
  }
  pcVar16 = "submesh";
  do {
    pcVar16 = pcVar16 + 1;
  } while (*pcVar16 != '\0');
                    /* catch() { ... } // from try @ 00cd2d0c with catch @ 00cd2f2c */
  local_18 = "submesh";
  local_20 = (ulong)((int)pcVar16 + 0xfecc5aa8);
  local_10 = 0x405000000000000;
  pGVar8 = rapidjson::
           GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
           ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                     (this_00,(GenericValue *)&local_20);
  if (*(int *)pGVar8 != 0) {
    uVar11 = 0;
    pcVar16 = "indices";
    do {
      lVar27 = *(long *)(pGVar8 + 8);
      lVar24 = uVar11 * 0x18;
      pcVar22 = "indexnum";
      do {
        pcVar23 = pcVar22;
        pcVar22 = pcVar23 + 1;
      } while (*pcVar22 != '\0');
      pcVar23 = pcVar23 + -0x133a547;
      iVar28 = (int)pcVar23;
      piVar18 = *(int **)(lVar27 + lVar24 + 8);
      piVar15 = piVar18 + (ulong)*(uint *)(lVar27 + lVar24) * 0xc;
      if (piVar18 != piVar15) {
        do {
          if ((*(ushort *)((long)piVar18 + 0x16) >> 0xc & 1) == 0) {
            if (iVar28 == *piVar18) {
              piVar12 = *(int **)(piVar18 + 2);
LAB_00cd303c:
              if (piVar12 == (int *)"indexnum") {
                if (piVar15 == piVar18) break;
              }
              else {
                iVar7 = memcmp("indexnum",piVar12,(ulong)pcVar23 & 0xffffffff);
                if (iVar7 != 0) goto LAB_00cd3018;
              }
              uVar29 = piVar18[6];
              goto LAB_00cd3058;
            }
          }
          else {
            piVar12 = piVar18;
            if (iVar28 == 0x15 - *(char *)((long)piVar18 + 0x15)) goto LAB_00cd303c;
          }
LAB_00cd3018:
          piVar18 = piVar18 + 0xc;
        } while (piVar15 != piVar18);
      }
      puVar2 = PTR_buffer_01719d48;
      uVar29 = uRam0000000000000000;
      if (PTR_buffer_01719d48 == (undefined *)0x0) {
LAB_00cd3058:
        local_50 = (void *)0x0;
        local_48 = 0;
        local_40 = 0;
        pcVar22 = pcVar16;
        if ((ulong)uVar29 != 0) {
          std::vector<unsigned_short,std::allocator<unsigned_short>>::_M_default_append
                    ((vector<unsigned_short,std::allocator<unsigned_short>> *)&local_50,
                     (ulong)uVar29);
        }
      }
      else {
        *(undefined8 *)PTR_buffer_01719d48 = 0;
        *(undefined8 *)(puVar2 + 8) = 0;
        *(undefined8 *)(puVar2 + 0x10) = 0;
        local_50 = (void *)0x0;
        local_48 = 0;
        local_40 = 0;
        pcVar22 = pcVar16;
      }
      do {
        pcVar23 = pcVar22;
        pcVar22 = pcVar23 + 1;
      } while (*pcVar22 != '\0');
      pcVar23 = pcVar23 + -0x133a517;
      iVar28 = (int)pcVar23;
      piVar18 = *(int **)(lVar27 + lVar24 + 8);
                    /* catch() { ... } // from try @ 00cd30b8 with catch @ 00cd3090
                       catch() { ... } // from try @ 00cd3158 with catch @ 00cd3090 */
      piVar15 = piVar18 + (ulong)*(uint *)(lVar27 + lVar24) * 0xc;
      if (piVar15 != piVar18) {
        do {
          if ((*(ushort *)((long)piVar18 + 0x16) >> 0xc & 1) == 0) {
            if (iVar28 == *piVar18) {
              piVar12 = *(int **)(piVar18 + 2);
LAB_00cd30e4:
                    /* try { // try from 00cd30e4 to 00dd30e7 has its CatchHandler @ 00cd315c */
              if (piVar12 == (int *)"indices") {
                if (piVar15 == piVar18) break;
              }
              else {
                iVar7 = memcmp("indices",piVar12,(ulong)pcVar23 & 0xffffffff);
                if (iVar7 != 0) goto LAB_00cd30c0;
              }
                    /* try { // try from 00cd30fc to 00dd30ff has its CatchHandler @ 00cd3128 */
              piVar15 = piVar18 + 6;
              uVar29 = piVar18[6];
              goto LAB_00cd3104;
            }
          }
          else {
                    /* try { // try from 00cd30b8 to 00dd30bb has its CatchHandler @ 00cd3090 */
            piVar12 = piVar18;
            if (iVar28 == 0x15 - *(char *)((long)piVar18 + 0x15)) goto LAB_00cd30e4;
          }
LAB_00cd30c0:
          piVar18 = piVar18 + 0xc;
        } while (piVar15 != piVar18);
      }
      puVar2 = PTR_buffer_01719d48;
      if (PTR_buffer_01719d48 == (undefined *)0x0) {
        piVar15 = (int *)0x0;
        uVar29 = uRam0000000000000000;
LAB_00cd3104:
        if (uVar29 != 0) {
          lVar24 = 0;
          puVar13 = *(undefined4 **)(piVar15 + 2);
          do {
            *(short *)((long)local_50 + lVar24 * 2) = (short)*puVar13;
            lVar24 = lVar24 + 1;
            puVar13 = puVar13 + 6;
          } while ((uint)lVar24 < uVar29);
        }
                    /* catch() { ... } // from try @ 00cd30fc with catch @ 00cd3128 */
        this_02 = (vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
                   *)(local_58 + 0x20);
        puVar26 = *(undefined8 **)(local_58 + 0x28);
        if (puVar26 != *(undefined8 **)(local_58 + 0x30)) goto LAB_00cd3140;
LAB_00cd33c8:
        std::
        vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
        ::_M_emplace_back_aux<std::vector<unsigned_short,std::allocator<unsigned_short>>const&>
                  (this_02,(vector *)&local_50);
        pvVar20 = *(vector **)(local_58 + 0x70);
        pvVar21 = *(vector **)(local_58 + 0x78);
        if (pvVar20 != pvVar21) goto LAB_00cd31c4;
LAB_00cd33e8:
        pvVar5 = (vector *)0x0;
      }
      else {
        *(undefined8 *)PTR_buffer_01719d48 = 0;
        *(undefined8 *)(puVar2 + 8) = 0;
        this_02 = (vector<std::vector<unsigned_short,std::allocator<unsigned_short>>,std::allocator<std::vector<unsigned_short,std::allocator<unsigned_short>>>>
                   *)(local_58 + 0x20);
        *(undefined8 *)(puVar2 + 0x10) = 0;
        puVar26 = *(undefined8 **)(local_58 + 0x28);
        if (puVar26 == *(undefined8 **)(local_58 + 0x30)) goto LAB_00cd33c8;
LAB_00cd3140:
        lVar24 = 0;
        if (puVar26 != (undefined8 *)0x0) {
          *puVar26 = 0;
          uVar17 = local_48 - (long)local_50;
          puVar26[1] = 0;
                    /* try { // try from 00cd3158 to 00dd315b has its CatchHandler @ 00cd3090 */
                    /* catch() { ... } // from try @ 00cd30e4 with catch @ 00cd315c */
          puVar26[2] = 0;
          if ((long)uVar17 >> 1 == 0) {
                    /* catch() { ... } // from try @ 00cd3198 with catch @ 00cd3164 */
            pvVar19 = (void *)0x0;
          }
          else {
            if ((long)uVar17 >> 1 < 0) {
                    /* WARNING: Subroutine does not return */
              FUN_0120f0e8();
            }
            pvVar19 = operator_new(uVar17);
          }
          *puVar26 = pvVar19;
          puVar26[1] = pvVar19;
          puVar26[2] = (long)pvVar19 + uVar17;
          lVar24 = local_48 - (long)local_50;
                    /* try { // try from 00cd3188 to 00dd318b has its CatchHandler @ 00cd31e0 */
          if (lVar24 >> 1 != 0) {
            pvVar19 = (void *)memmove(pvVar19,local_50,lVar24);
                    /* try { // try from 00cd3198 to 00dd31f7 has its CatchHandler @ 00cd3164 */
          }
          puVar26[1] = (long)pvVar19 + lVar24;
          lVar24 = *(long *)(this_02 + 8);
        }
        *(long *)(this_02 + 8) = lVar24 + 0x18;
        pvVar20 = *(vector **)(local_58 + 0x70);
        pvVar21 = *(vector **)(local_58 + 0x78);
        if (pvVar20 == pvVar21) goto LAB_00cd33e8;
LAB_00cd31c4:
        pvVar4 = pvVar20 + 0x10;
        uVar10 = (ulong)((long)pvVar21 - (long)pvVar4) >> 4;
                    /* catch() { ... } // from try @ 00cd3188 with catch @ 00cd31e0 */
        uVar17 = (uVar10 - 4 >> 2) + 1;
        if (uVar10 < 4) {
          uVar29 = 0;
        }
        else {
          iVar28 = 0;
          iVar7 = 0;
          iVar30 = 0;
          iVar31 = 0;
          pvVar5 = pvVar20 + 0xc;
          uVar14 = 0;
          do {
            iVar32 = *(int *)pvVar5;
            uVar6 = *(undefined4 *)(pvVar5 + 0x10);
            pvVar4 = pvVar5 + 0x20;
            uVar33 = *(undefined4 *)(pvVar5 + 0x30);
            pvVar5 = pvVar5 + 0x40;
            uVar14 = uVar14 + 1;
            _local_a0 = CONCAT17((char)((uint)uVar6 >> 0x18),
                                 CONCAT16((char)((uint)uVar6 >> 0x10),
                                          CONCAT15((char)((uint)uVar6 >> 8),
                                                   CONCAT14((char)uVar6,iVar32))));
            iVar28 = iVar28 + iVar32;
            iVar7 = iVar7 + (int)((ulong)_local_a0 >> 0x20);
            iVar30 = iVar30 + *(int *)pvVar4;
            iVar31 = iVar31 + (int)(CONCAT17((char)((uint)uVar33 >> 0x18),
                                             CONCAT16((char)((uint)uVar33 >> 0x10),
                                                      CONCAT15((char)((uint)uVar33 >> 8),
                                                               CONCAT14((char)uVar33,*(int *)pvVar4)
                                                              ))) >> 0x20);
          } while (uVar14 < uVar17);
          uVar29 = iVar28 + iVar7 + iVar30 + iVar31;
          pvVar20 = pvVar20 + uVar17 * 0x40;
          pvVar5 = (vector *)(ulong)uVar29;
          if (uVar17 * 4 - (uVar10 + 1) == 0) goto LAB_00cd32ac;
          pvVar4 = pvVar20 + 0x10;
        }
        pvVar5 = (vector *)(ulong)(uVar29 + *(int *)(pvVar20 + 0xc));
        if (pvVar21 != pvVar4) {
          uVar29 = uVar29 + *(int *)(pvVar20 + 0xc) + *(int *)(pvVar20 + 0x1c);
          pvVar5 = (vector *)(ulong)uVar29;
          if (pvVar21 != pvVar20 + 0x20) {
            uVar29 = uVar29 + *(int *)(pvVar20 + 0x2c);
            pvVar5 = (vector *)(ulong)uVar29;
            if (pvVar21 != pvVar20 + 0x30) {
              uVar29 = uVar29 + *(int *)(pvVar20 + 0x3c);
              pvVar5 = (vector *)(ulong)uVar29;
              if (pvVar21 != pvVar20 + 0x40) {
                uVar29 = uVar29 + *(int *)(pvVar20 + 0x4c);
                pvVar5 = (vector *)(ulong)uVar29;
                if (pvVar21 != pvVar20 + 0x50) {
                  uVar29 = uVar29 + *(int *)(pvVar20 + 0x5c);
                  pvVar5 = (vector *)(ulong)uVar29;
                  if (pvVar21 != pvVar20 + 0x60) {
                    pvVar5 = (vector *)(ulong)(uVar29 + *(int *)(pvVar20 + 0x6c));
                  }
                }
              }
            }
          }
        }
      }
LAB_00cd32ac:
      pvVar3 = local_58;
      calculateAABB((Bundle3D *)local_58,pvVar5,
                    (int)(vector<unsigned_short,std::allocator<unsigned_short>> *)&local_50,pvVar20)
      ;
      this_01 = *(AABB **)(pvVar3 + 0x58);
      if (this_01 == *(AABB **)(pvVar3 + 0x60)) {
        std::vector<cocos2d::AABB,std::allocator<cocos2d::AABB>>::_M_emplace_back_aux<cocos2d::AABB>
                  ((vector<cocos2d::AABB,std::allocator<cocos2d::AABB>> *)(pvVar3 + 0x50),
                   (AABB *)&local_38);
      }
      else {
        lVar24 = 0;
        if (this_01 != (AABB *)0x0) {
          AABB::AABB(this_01,(AABB *)&local_38);
          lVar24 = *(long *)(pvVar3 + 0x58);
        }
        *(long *)(pvVar3 + 0x58) = lVar24 + 0x18;
      }
      Vec3::~Vec3(aVStack_2c);
      Vec3::~Vec3((Vec3 *)&local_38);
      if (local_50 != (void *)0x0) {
        operator_delete(local_50);
      }
      uVar29 = (int)uVar11 + 1;
      uVar11 = (ulong)uVar29;
    } while (uVar29 < *(uint *)pGVar8);
  }
  puVar26 = *(undefined8 **)(param_1 + 8);
  if (puVar26 == *(undefined8 **)(param_1 + 0x10)) {
    std::vector<cocos2d::MeshData*,std::allocator<cocos2d::MeshData*>>::
    _M_emplace_back_aux<cocos2d::MeshData*const&>
              ((vector<cocos2d::MeshData*,std::allocator<cocos2d::MeshData*>> *)param_1,
               (MeshData **)&local_58);
  }
  else {
    lVar24 = 0;
    if (puVar26 != (undefined8 *)0x0) {
      *puVar26 = local_58;
      lVar24 = *(long *)(param_1 + 8);
    }
    *(long *)(param_1 + 8) = lVar24 + 8;
  }
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(1);
  }
  return;
}


/* === loadMaterialsBinary @ 00cd70dc === */

/* cocos2d::Bundle3D::loadMaterialsBinary(cocos2d::MaterialDatas&) */

void __thiscall cocos2d::Bundle3D::loadMaterialsBinary(Bundle3D *this,MaterialDatas *param_1)

{
  BundleReader *this_00;
  long lVar1;
  undefined *puVar2;
  undefined8 uVar3;
  NMaterialData *this_01;
  uint local_e0;
  uint local_dc;
  uint local_c8;
  uint local_c4;
  long local_c0;
  long local_b8;
  long local_b0;
  long local_a8;
  long local_a0;
  long local_98;
  undefined1 auStack_90 [16];
  undefined8 local_80;
  long local_78;
  long local_70;
  undefined *local_68;
  undefined *local_60;
  undefined *local_58;
  undefined4 local_50;
  undefined4 local_4c;
  undefined4 local_48;
  undefined1 auStack_40 [56];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FUN_01211570((string *)&local_60,&DAT_012fc3d8,(string *)&local_98);
  lVar1 = seekToFirstType(this,0x10,(string *)&local_60);
  if (local_60 + -0x18 != PTR_DAT_017191c0) {
    FUN_00cc93d0(local_60 + -0x18,&local_80);
  }
  if (lVar1 == 0) {
    uVar3 = 0;
  }
  else {
    this_00 = (BundleReader *)(this + 0xa0);
    local_c8 = 1;
    BundleReader::read(this_00,&local_c8,4,1);
    if (local_c8 != 0) {
      local_e0 = 0;
      do {
        local_80 = 0;
        local_68 = PTR_DAT_017191c0 + 0x18;
        local_78 = 0;
        local_70 = 0;
        BundleReader::readString();
        FUN_0121258c(&local_68,(string *)&local_60);
        if (local_60 + -0x18 != PTR_DAT_017191c0) {
          FUN_00cc93d0(local_60 + -0x18,(string *)&local_98);
        }
        BundleReader::read(this_00,auStack_40,4,0xe);
        local_c4 = 1;
        BundleReader::read(this_00,&local_c4,4,1);
        if (local_c4 != 0) {
          local_dc = 0;
LAB_00cd7408:
          do {
            local_60 = PTR_DAT_017191c0 + 0x18;
            local_58 = local_60;
            BundleReader::readString();
            FUN_0121258c((string *)&local_60,&local_c0);
            if ((undefined *)(local_c0 + -0x18) == PTR_DAT_017191c0) {
              if (*(long *)(local_60 + -0x18) != 0) goto LAB_00cd7260;
LAB_00cd7458:
              if (local_58 + -0x18 != PTR_DAT_017191c0) {
                FUN_00cc93d0(local_58 + -0x18,(string *)&local_98);
              }
              if (local_60 + -0x18 != PTR_DAT_017191c0) {
                FUN_00cc93d0(local_60 + -0x18,(string *)&local_98);
              }
              NMaterialData::~NMaterialData((NMaterialData *)&local_80);
              uVar3 = 0;
              goto LAB_00cd748c;
            }
            FUN_00cc93d0((undefined *)(local_c0 + -0x18),(string *)&local_98);
            if (*(long *)(local_60 + -0x18) == 0) goto LAB_00cd7458;
LAB_00cd7260:
            BundleReader::readString();
            if (*(long *)(local_b8 + -0x18) == 0) {
              if ((undefined *)(local_b8 + -0x18) != PTR_DAT_017191c0) {
                FUN_00cc93d0((undefined *)(local_b8 + -0x18),(string *)&local_98);
              }
              goto LAB_00cd7458;
            }
            FUN_01214ee0(&local_b0,this + 8);
            FUN_01211fcc(&local_b0,&local_b8);
            FUN_0121258c(&local_58,&local_b0);
            if ((undefined *)(local_b0 + -0x18) != PTR_DAT_017191c0) {
              FUN_00cc93d0((undefined *)(local_b0 + -0x18),(string *)&local_98);
            }
            BundleReader::read(this_00,auStack_90,4,4);
            BundleReader::readString();
            local_50 = parseGLTextureType(this,(string *)&local_a8);
            if ((undefined *)(local_a8 + -0x18) != PTR_DAT_017191c0) {
              FUN_00cc93d0((undefined *)(local_a8 + -0x18),(string *)&local_98);
            }
            BundleReader::readString();
            local_4c = parseGLType(this,(string *)&local_a0);
            if ((undefined *)(local_a0 + -0x18) != PTR_DAT_017191c0) {
              FUN_00cc93d0((undefined *)(local_a0 + -0x18),(string *)&local_98);
            }
            BundleReader::readString();
            local_48 = parseGLType(this,(string *)&local_98);
            if ((undefined *)(local_98 + -0x18) == PTR_DAT_017191c0) {
              if (local_78 != local_70) goto LAB_00cd7370;
LAB_00cd74dc:
              std::vector<cocos2d::NTextureData,std::allocator<cocos2d::NTextureData>>::
              _M_emplace_back_aux<cocos2d::NTextureData_const&>
                        ((vector<cocos2d::NTextureData,std::allocator<cocos2d::NTextureData>> *)
                         &local_80,(NTextureData *)&local_60);
              puVar2 = (undefined *)(local_b8 + -0x18);
              if (puVar2 != PTR_DAT_017191c0) goto LAB_00cd74fc;
LAB_00cd73c4:
              puVar2 = local_58 + -0x18;
              if (puVar2 == PTR_DAT_017191c0) goto LAB_00cd73d8;
LAB_00cd7518:
              FUN_00cc93d0(puVar2,(string *)&local_98);
              puVar2 = local_60 + -0x18;
              if (puVar2 != PTR_DAT_017191c0) goto LAB_00cd7534;
LAB_00cd73ec:
              local_dc = local_dc + 1;
              if (local_c4 <= local_dc) break;
              goto LAB_00cd7408;
            }
            FUN_00cc93d0((undefined *)(local_98 + -0x18),(string *)&local_a0);
            if (local_78 == local_70) goto LAB_00cd74dc;
LAB_00cd7370:
            lVar1 = local_78;
            if (local_78 != 0) {
              FUN_01214ee0(local_78,(string *)&local_60);
              FUN_01214ee0(lVar1 + 8,&local_58);
              *(undefined4 *)(lVar1 + 0x14) = local_4c;
              *(undefined4 *)(lVar1 + 0x10) = local_50;
              *(undefined4 *)(lVar1 + 0x18) = local_48;
            }
            local_78 = local_78 + 0x20;
            puVar2 = (undefined *)(local_b8 + -0x18);
            if (puVar2 == PTR_DAT_017191c0) goto LAB_00cd73c4;
LAB_00cd74fc:
            FUN_00cc93d0(puVar2,(string *)&local_98);
            puVar2 = local_58 + -0x18;
            if (puVar2 != PTR_DAT_017191c0) goto LAB_00cd7518;
LAB_00cd73d8:
            puVar2 = local_60 + -0x18;
            if (puVar2 == PTR_DAT_017191c0) goto LAB_00cd73ec;
LAB_00cd7534:
            FUN_00cc93d0(puVar2,(string *)&local_98);
            local_dc = local_dc + 1;
          } while (local_dc < local_c4);
        }
        this_01 = *(NMaterialData **)(param_1 + 8);
        if (this_01 == *(NMaterialData **)(param_1 + 0x10)) {
          std::vector<cocos2d::NMaterialData,std::allocator<cocos2d::NMaterialData>>::
          _M_emplace_back_aux<cocos2d::NMaterialData_const&>
                    ((vector<cocos2d::NMaterialData,std::allocator<cocos2d::NMaterialData>> *)
                     param_1,(NMaterialData *)&local_80);
        }
        else {
          lVar1 = 0;
          if (this_01 != (NMaterialData *)0x0) {
            NMaterialData::NMaterialData(this_01,(NMaterialData *)&local_80);
            lVar1 = *(long *)(param_1 + 8);
          }
          *(long *)(param_1 + 8) = lVar1 + 0x20;
        }
        local_e0 = local_e0 + 1;
        NMaterialData::~NMaterialData((NMaterialData *)&local_80);
      } while (local_e0 < local_c8);
    }
    uVar3 = 1;
  }
LAB_00cd748c:
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar3);
}


/* === loadMaterialsJson @ 00cd77cc === */

/* WARNING: Heritage AFTER dead removal. Example location: r0x00000016 : 0x00cd8024 */
/* WARNING: Restarted to delay deadcode elimination for space: ram */
/* WARNING: Restarted to delay deadcode elimination for space: stack */
/* cocos2d::Bundle3D::loadMaterialsJson(cocos2d::MaterialDatas&) */

void __thiscall cocos2d::Bundle3D::loadMaterialsJson(Bundle3D *this,MaterialDatas *param_1)

{
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
  *this_00;
  ushort uVar1;
  int iVar2;
  int iVar3;
  GenericValue *pGVar4;
  GenericValue *pGVar5;
  undefined8 uVar6;
  long lVar7;
  NMaterialData *this_01;
  int *piVar8;
  int *piVar9;
  char *pcVar10;
  int *piVar11;
  char *pcVar12;
  long lVar13;
  long lVar14;
  char *local_110;
  uint local_b0;
  uint local_ac;
  long local_88;
  long local_80;
  long local_78;
  long local_70;
  long local_68;
  ulong local_60;
  char *local_58;
  undefined8 local_50;
  undefined8 local_48;
  long local_40;
  long local_38;
  undefined *local_30;
  undefined *local_28;
  undefined *local_20;
  undefined4 local_18;
  undefined4 local_14;
  undefined4 local_10;
  long local_8;
  
  pcVar10 = "materials";
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  rapidjson::
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>::
  FindMember((char *)(this + 0x28));
  if (local_28 == (undefined *)(*(long *)(this + 0x30) + (ulong)*(uint *)(this + 0x28) * 0x30)) {
    uVar6 = 0;
  }
  else {
    do {
      pcVar10 = pcVar10 + 1;
    } while (*pcVar10 != '\0');
    local_50 = 0x405000000000000;
    local_58 = "materials";
    local_60 = (ulong)((int)pcVar10 + 0xfecc5a78);
    pGVar4 = rapidjson::
             GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
             ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                       ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                         *)(this + 0x28),(GenericValue *)&local_60);
    if (*(int *)pGVar4 != 0) {
      local_b0 = 0;
      local_110 = "textures";
      do {
        local_40 = 0;
        local_30 = PTR_DAT_017191c0 + 0x18;
        local_38 = 0;
        local_48 = 0;
        pcVar10 = "id";
        lVar14 = *(long *)(pGVar4 + 8);
        this_00 = (GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                   *)(lVar14 + (ulong)local_b0 * 0x18);
        do {
          pcVar10 = pcVar10 + 1;
        } while (*pcVar10 != '\0');
        local_50 = 0;
        local_60 = 0;
        local_58 = "id";
                    /* WARNING: Ignoring partial resolution of indirect */
        local_60._0_4_ = (int)pcVar10 + -0x133a4b8;
        pGVar5 = rapidjson::
                 GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                 ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                           (this_00,(GenericValue *)&local_60);
        if ((*(ushort *)(pGVar5 + 0x16) >> 0xc & 1) == 0) {
          pGVar5 = *(GenericValue **)(pGVar5 + 8);
        }
        uVar6 = strlen(pGVar5);
        FUN_01213b44(&local_30,pGVar5,uVar6);
        rapidjson::
        GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
        ::FindMember((char *)this_00);
        pcVar10 = local_110;
        if (local_28 !=
            (undefined *)
            (*(long *)(this_00 + 8) + (ulong)*(uint *)(lVar14 + (ulong)local_b0 * 0x18) * 0x30)) {
          do {
            pcVar10 = pcVar10 + 1;
          } while (*pcVar10 != '\0');
          local_60 = 0;
          local_50 = 0;
          local_58 = "textures";
                    /* WARNING: Ignoring partial resolution of indirect */
          local_60._0_4_ = (int)pcVar10 + -0x1335d78;
          pGVar5 = rapidjson::
                   GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                   ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                             (this_00,(GenericValue *)&local_60);
          if (*(int *)pGVar5 != 0) {
            local_ac = 0;
            do {
              lVar13 = (ulong)local_ac * 0x18;
              local_28 = PTR_DAT_017191c0 + 0x18;
              lVar7 = *(long *)(pGVar5 + 8);
              lVar14 = lVar7 + lVar13;
              pcVar10 = "filename";
              do {
                pcVar12 = pcVar10;
                pcVar10 = pcVar12 + 1;
              } while (*pcVar10 != '\0');
              pcVar12 = pcVar12 + -0x12ebc8f;
              iVar2 = (int)pcVar12;
              piVar11 = *(int **)(lVar14 + 8);
              piVar9 = piVar11 + (ulong)*(uint *)(lVar7 + lVar13) * 0xc;
              local_20 = local_28;
              if (piVar9 != piVar11) {
                do {
                  if ((*(ushort *)((long)piVar11 + 0x16) >> 0xc & 1) == 0) {
                    if (iVar2 == *piVar11) {
                      piVar8 = *(int **)(piVar11 + 2);
LAB_00cd7ac8:
                      if (piVar8 == (int *)"filename") {
                        if (piVar9 == piVar11) break;
                      }
                      else {
                        iVar3 = memcmp("filename",piVar8,(ulong)pcVar12 & 0xffffffff);
                        if (iVar3 != 0) goto LAB_00cd7aa4;
                      }
                      piVar9 = piVar11 + 6;
                      uVar1 = *(ushort *)((long)piVar11 + 0x2e);
                      goto LAB_00cd7af0;
                    }
                  }
                  else {
                    piVar8 = piVar11;
                    if (iVar2 == 0x15 - *(char *)((long)piVar11 + 0x15)) goto LAB_00cd7ac8;
                  }
LAB_00cd7aa4:
                  piVar11 = piVar11 + 0xc;
                } while (piVar9 != piVar11);
              }
              piVar9 = (int *)PTR_buffer_01719d48;
              uVar1 = uRam0000000000000016;
              if (PTR_buffer_01719d48 == (undefined *)0x0) {
LAB_00cd7af0:
                if ((uVar1 & 0x1000) == 0) goto LAB_00cd8004;
              }
              else {
                *(undefined8 *)PTR_buffer_01719d48 = 0;
                *(undefined8 *)((long)piVar9 + 8) = 0;
                *(undefined8 *)((long)piVar9 + 0x10) = 0;
LAB_00cd8004:
                piVar9 = *(int **)(piVar9 + 2);
              }
              FUN_01211570(&local_88,piVar9,(string *)&local_68);
              if (*(long *)(local_88 + -0x18) == 0) {
                FUN_01214ee0(&local_80,&local_88);
              }
              else {
                FUN_01214ee0(&local_80,this + 8);
                FUN_01211fcc(&local_80,&local_88);
              }
              FUN_0121258c(&local_20,&local_80);
              pcVar10 = "type";
              if ((undefined *)(local_80 + -0x18) != PTR_DAT_017191c0) {
                FUN_00cc93d0((undefined *)(local_80 + -0x18),(string *)&local_68);
              }
              do {
                pcVar12 = pcVar10;
                pcVar10 = pcVar12 + 1;
              } while (*pcVar10 != '\0');
              pcVar12 = pcVar12 + -0x1369447;
              iVar2 = (int)pcVar12;
              piVar11 = *(int **)(lVar14 + 8);
              piVar9 = piVar11 + (ulong)*(uint *)(lVar7 + lVar13) * 0xc;
              if (piVar9 != piVar11) {
                do {
                  if ((*(ushort *)((long)piVar11 + 0x16) >> 0xc & 1) == 0) {
                    if (iVar2 == *piVar11) {
                      piVar8 = *(int **)(piVar11 + 2);
LAB_00cd7bc0:
                      if (piVar8 == (int *)0x1369448) {
                        if (piVar9 == piVar11) break;
                      }
                      else {
                        iVar3 = memcmp("type",piVar8,(ulong)pcVar12 & 0xffffffff);
                        if (iVar3 != 0) goto LAB_00cd7b9c;
                      }
                      piVar9 = piVar11 + 6;
                      uVar1 = *(ushort *)((long)piVar11 + 0x2e);
                      goto LAB_00cd7be8;
                    }
                  }
                  else {
                    piVar8 = piVar11;
                    if (iVar2 == 0x15 - *(char *)((long)piVar11 + 0x15)) goto LAB_00cd7bc0;
                  }
LAB_00cd7b9c:
                  piVar11 = piVar11 + 0xc;
                } while (piVar9 != piVar11);
              }
              piVar9 = (int *)PTR_buffer_01719d48;
              uVar1 = uRam0000000000000016;
              if (PTR_buffer_01719d48 == (undefined *)0x0) {
LAB_00cd7be8:
                if ((uVar1 & 0x1000) == 0) goto LAB_00cd7fbc;
              }
              else {
                *(undefined8 *)PTR_buffer_01719d48 = 0;
                *(undefined8 *)((long)piVar9 + 8) = 0;
                *(undefined8 *)((long)piVar9 + 0x10) = 0;
LAB_00cd7fbc:
                piVar9 = *(int **)(piVar9 + 2);
              }
              FUN_01211570((string *)&local_78,piVar9,(string *)&local_70);
              local_18 = parseGLTextureType(this,(string *)&local_78);
              if ((undefined *)(local_78 + -0x18) != PTR_DAT_017191c0) {
                FUN_00cc93d0((undefined *)(local_78 + -0x18),(string *)&local_68);
              }
              pcVar10 = "wrapModeU";
              do {
                pcVar12 = pcVar10;
                pcVar10 = pcVar12 + 1;
              } while (*pcVar10 != '\0');
              pcVar12 = pcVar12 + -0x133a597;
              iVar2 = (int)pcVar12;
              piVar11 = *(int **)(lVar14 + 8);
              piVar8 = piVar11 + (ulong)*(uint *)(lVar7 + lVar13) * 0xc;
              piVar9 = (int *)PTR_buffer_01719d48;
              if (piVar8 != piVar11) {
                do {
                  if ((*(ushort *)((long)piVar11 + 0x16) >> 0xc & 1) == 0) {
                    if (iVar2 == *piVar11) {
                      piVar9 = *(int **)(piVar11 + 2);
LAB_00cd7cb4:
                      if (piVar9 == (int *)"wrapModeU") {
                        piVar9 = (int *)PTR_buffer_01719d48;
                        if (piVar8 == piVar11) break;
                      }
                      else {
                        iVar3 = memcmp("wrapModeU",piVar9,(ulong)pcVar12 & 0xffffffff);
                        if (iVar3 != 0) goto LAB_00cd7c90;
                      }
                      piVar9 = piVar11 + 6;
                      uVar1 = *(ushort *)((long)piVar11 + 0x2e);
                      goto LAB_00cd7ce0;
                    }
                  }
                  else {
                    piVar9 = piVar11;
                    if (iVar2 == 0x15 - *(char *)((long)piVar11 + 0x15)) goto LAB_00cd7cb4;
                  }
LAB_00cd7c90:
                  piVar11 = piVar11 + 0xc;
                  piVar9 = (int *)PTR_buffer_01719d48;
                } while (piVar8 != piVar11);
              }
              uVar1 = uRam0000000000000016;
              PTR_buffer_01719d48 = (undefined *)piVar9;
              if (piVar9 == (int *)0x0) {
LAB_00cd7ce0:
                if ((uVar1 & 0x1000) == 0) goto LAB_00cd7f98;
              }
              else {
                piVar9[0] = 0;
                piVar9[1] = 0;
                piVar9[2] = 0;
                piVar9[3] = 0;
                piVar9[4] = 0;
                piVar9[5] = 0;
LAB_00cd7f98:
                piVar9 = *(int **)(piVar9 + 2);
              }
              FUN_01211570((string *)&local_70,piVar9,(string *)&local_78);
              local_14 = parseGLType(this,(string *)&local_70);
              if ((undefined *)(local_70 + -0x18) != PTR_DAT_017191c0) {
                FUN_00cc93d0((undefined *)(local_70 + -0x18),(string *)&local_68);
              }
              pcVar10 = "wrapModeV";
              do {
                pcVar12 = pcVar10;
                pcVar10 = pcVar12 + 1;
              } while (*pcVar10 != '\0');
              pcVar12 = pcVar12 + -0x133a5a7;
              iVar2 = (int)pcVar12;
              piVar11 = *(int **)(lVar14 + 8);
              piVar9 = piVar11 + (ulong)*(uint *)(lVar7 + lVar13) * 0xc;
              if (piVar9 != piVar11) {
                do {
                  if ((*(ushort *)((long)piVar11 + 0x16) >> 0xc & 1) == 0) {
                    if (iVar2 == *piVar11) {
                      piVar8 = *(int **)(piVar11 + 2);
LAB_00cd7da0:
                      if (piVar8 == (int *)"wrapModeV") {
                        if (piVar9 == piVar11) break;
                      }
                      else {
                        iVar3 = memcmp("wrapModeV",piVar8,(ulong)pcVar12 & 0xffffffff);
                        if (iVar3 != 0) goto LAB_00cd7d7c;
                      }
                      piVar9 = piVar11 + 6;
                      uVar1 = *(ushort *)((long)piVar11 + 0x2e);
                      goto LAB_00cd7dc8;
                    }
                  }
                  else {
                    piVar8 = piVar11;
                    if (iVar2 == 0x15 - *(char *)((long)piVar11 + 0x15)) goto LAB_00cd7da0;
                  }
LAB_00cd7d7c:
                  piVar11 = piVar11 + 0xc;
                } while (piVar9 != piVar11);
              }
              piVar9 = (int *)PTR_buffer_01719d48;
              uVar1 = uRam0000000000000016;
              if (PTR_buffer_01719d48 == (undefined *)0x0) {
LAB_00cd7dc8:
                if ((uVar1 & 0x1000) == 0) goto LAB_00cd7f78;
              }
              else {
                *(undefined8 *)PTR_buffer_01719d48 = 0;
                *(undefined8 *)((long)piVar9 + 8) = 0;
                *(undefined8 *)((long)piVar9 + 0x10) = 0;
LAB_00cd7f78:
                piVar9 = *(int **)(piVar9 + 2);
              }
              FUN_01211570((string *)&local_68,piVar9,(string *)&local_78);
              local_10 = parseGLType(this,(string *)&local_68);
              if ((undefined *)(local_68 + -0x18) == PTR_DAT_017191c0) {
                if (local_38 != local_40) goto LAB_00cd7e14;
LAB_00cd8088:
                std::vector<cocos2d::NTextureData,std::allocator<cocos2d::NTextureData>>::
                _M_emplace_back_aux<cocos2d::NTextureData_const&>
                          ((vector<cocos2d::NTextureData,std::allocator<cocos2d::NTextureData>> *)
                           &local_48,(NTextureData *)&local_28);
              }
              else {
                FUN_00cc93d0((undefined *)(local_68 + -0x18),(string *)&local_70);
                if (local_38 == local_40) goto LAB_00cd8088;
LAB_00cd7e14:
                lVar14 = local_40;
                lVar13 = 0;
                if (local_40 != 0) {
                  FUN_01214ee0(local_40,(NTextureData *)&local_28);
                  FUN_01214ee0(lVar14 + 8,&local_20);
                  *(undefined4 *)(lVar14 + 0x14) = local_14;
                  *(undefined4 *)(lVar14 + 0x10) = local_18;
                  *(undefined4 *)(lVar14 + 0x18) = local_10;
                  lVar13 = local_40;
                }
                local_40 = lVar13 + 0x20;
              }
              if ((undefined *)(local_88 + -0x18) != PTR_DAT_017191c0) {
                FUN_00cc93d0((undefined *)(local_88 + -0x18),(string *)&local_68);
              }
              if (local_20 + -0x18 != PTR_DAT_017191c0) {
                FUN_00cc93d0(local_20 + -0x18,(string *)&local_68);
              }
              if (local_28 + -0x18 != PTR_DAT_017191c0) {
                FUN_00cc93d0(local_28 + -0x18,(string *)&local_68);
              }
              local_ac = local_ac + 1;
            } while (local_ac < *(uint *)pGVar5);
          }
        }
        this_01 = *(NMaterialData **)(param_1 + 8);
        if (this_01 == *(NMaterialData **)(param_1 + 0x10)) {
          std::vector<cocos2d::NMaterialData,std::allocator<cocos2d::NMaterialData>>::
          _M_emplace_back_aux<cocos2d::NMaterialData_const&>
                    ((vector<cocos2d::NMaterialData,std::allocator<cocos2d::NMaterialData>> *)
                     param_1,(NMaterialData *)&local_48);
        }
        else {
          lVar14 = 0;
          if (this_01 != (NMaterialData *)0x0) {
            NMaterialData::NMaterialData(this_01,(NMaterialData *)&local_48);
            lVar14 = *(long *)(param_1 + 8);
          }
          *(long *)(param_1 + 8) = lVar14 + 0x20;
        }
        local_b0 = local_b0 + 1;
        NMaterialData::~NMaterialData((NMaterialData *)&local_48);
      } while (local_b0 < *(uint *)pGVar4);
    }
    uVar6 = 1;
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar6);
}


/* === parseNodesRecursivelyBinary @ 00ccc0c8 === */

/* WARNING: Restarted to delay deadcode elimination for space: stack */
/* cocos2d::Bundle3D::parseNodesRecursivelyBinary(bool&, bool) */

void __thiscall
cocos2d::Bundle3D::parseNodesRecursivelyBinary(Bundle3D *this,bool *param_1,bool param_2)

{
  BundleReader *this_00;
  Bundle3D *pBVar1;
  long lVar2;
  long lVar3;
  long lVar4;
  long lVar5;
  long lVar6;
  bool bVar7;
  char cVar8;
  int iVar9;
  long lVar10;
  undefined *puVar11;
  long *plVar12;
  long lVar13;
  Mat4 *this_01;
  undefined8 *puVar14;
  long *plVar15;
  uint uVar16;
  ModelData *pMVar17;
  uint uVar18;
  uint local_fc;
  char local_bd;
  uint local_bc;
  uint local_b8 [2];
  long local_b0;
  ModelData *local_a8;
  uint local_a0;
  undefined4 uStack_9c;
  uint local_98;
  undefined4 uStack_94;
  NodeData *local_90;
  long local_88;
  long lStack_80;
  long local_78;
  long lStack_70;
  long local_68;
  long lStack_60;
  long local_58;
  long lStack_50;
  Mat4 aMStack_48 [64];
  long local_8;
  
  this_00 = (BundleReader *)(this + 0xa0);
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  BundleReader::readString();
  lVar10 = BundleReader::read(this_00,&local_bd,1,1);
  if (lVar10 == 1) {
    if (local_bd != '\0') {
      *param_1 = true;
    }
    Mat4::Mat4((Mat4 *)&local_88);
    cVar8 = BundleReader::readMatrix(this_00,(float *)&local_88);
    if (cVar8 == '\0') {
LAB_00ccc160:
      plVar15 = (long *)0x0;
    }
    else {
      local_bc = 0;
      lVar10 = BundleReader::read(this_00,&local_bc,4,1);
      if (lVar10 != 1) goto LAB_00ccc160;
      plVar15 = operator_new(0x80,(nothrow_t *)PTR_nothrow_01717628);
      if (plVar15 != (long *)0x0) {
        *plVar15 = 0;
        plVar15[1] = 0;
        *(undefined8 *)(plVar15 + 2) = 0;
        plVar15[3] = 0;
                    /* catch() { ... } // from try @ 00ccb9d0 with catch @ 00ccc204 */
        plVar15[4] = 0;
        plVar15[5] = 0;
        plVar15[6] = 0;
        plVar15[7] = 0;
        plVar15[8] = 0;
        plVar15[9] = 0;
        plVar15[10] = 0;
        plVar15[0xb] = 0;
        plVar15[0xc] = 0;
        plVar15[0xd] = 0;
        plVar15[0xe] = 0;
        plVar15[0xf] = 0;
        *plVar15 = (long)(PTR_vtable_0171e000 + 0x10);
        plVar15[1] = (long)(PTR_DAT_017191c0 + 0x18);
        Mat4::Mat4((Mat4 *)(plVar15 + 2));
        plVar15[10] = 0;
                    /* try { // try from 00ccc23c to 00dcc23f has its CatchHandler @ 00ccc240 */
        plVar15[0xb] = 0;
                    /* catch() { ... } // from try @ 00ccbdec with catch @ 00ccc240
                       catch() { ... } // from try @ 00ccbf44 with catch @ 00ccc240
                       catch() { ... } // from try @ 00ccc07c with catch @ 00ccc240
                       catch() { ... } // from try @ 00ccc23c with catch @ 00ccc240 */
        plVar15[0xc] = 0;
        plVar15[0xd] = 0;
        plVar15[0xe] = 0;
        plVar15[0xf] = 0;
      }
      FUN_01215060(plVar15 + 1,&local_b0);
                    /* catch() { ... } // from try @ 00ccb8c8 with catch @ 00ccc268 */
      if (local_bc == 0) {
        bVar7 = false;
      }
      else {
                    /* catch() { ... } // from try @ 00ccbfd4 with catch @ 00ccc274 */
        local_fc = 0;
        bVar7 = false;
        do {
          pMVar17 = (ModelData *)&DAT_00000008;
          local_a8 = operator_new(0x48,(nothrow_t *)PTR_nothrow_01717628);
          if (local_a8 != (ModelData *)0x0) {
            *(long *)(local_a8 + 0x18) = 0;
            *(long *)(local_a8 + 0x20) = 0;
            *(long *)(local_a8 + 0x28) = 0;
            *(long *)(local_a8 + 0x30) = 0;
            *(long *)(local_a8 + 0x38) = 0;
            *(long *)(local_a8 + 0x40) = 0;
            pMVar17 = local_a8 + 8;
            *(undefined **)local_a8 = PTR_vtable_01714720 + 0x10;
            puVar11 = PTR_DAT_017191c0 + 0x18;
            *(undefined **)(local_a8 + 8) = puVar11;
            *(undefined **)(local_a8 + 0x10) = puVar11;
          }
                    /* catch() { ... } // from try @ 00ccbfc0 with catch @ 00ccc2fc */
                    /* catch() { ... } // from try @ 00ccbfb4 with catch @ 00ccc300 */
                    /* catch() { ... } // from try @ 00ccbfa8 with catch @ 00ccc308 */
          BundleReader::readString();
          FUN_0121258c(pMVar17,&local_a0);
          puVar11 = (undefined *)(CONCAT44(uStack_9c,local_a0) + -0x18);
          if (puVar11 != PTR_DAT_017191c0) {
            FUN_00cc93d0(puVar11,(string *)&local_90);
          }
                    /* catch() { ... } // from try @ 00ccbf80 with catch @ 00ccc330 */
                    /* catch() { ... } // from try @ 00ccbf7c with catch @ 00ccc338 */
          pMVar17 = local_a8 + 0x10;
          BundleReader::readString();
          FUN_0121258c(pMVar17,&local_98);
          puVar11 = (undefined *)(CONCAT44(uStack_94,local_98) + -0x18);
                    /* catch() { ... } // from try @ 00ccbf68 with catch @ 00ccc360 */
          if (puVar11 != PTR_DAT_017191c0) {
            FUN_00cc93d0(puVar11,(string *)&local_90);
          }
                    /* catch() { ... } // from try @ 00ccbf58 with catch @ 00ccc368 */
          iVar9 = FUN_01213398(local_a8 + 8,&DAT_012fc3d8);
          if ((iVar9 == 0) || (iVar9 = FUN_01213398(local_a8 + 0x10,&DAT_012fc3d8), iVar9 == 0)) {
            local_90 = (NodeData *)(PTR_DAT_017191c0 + 0x18);
                    /* catch() { ... } // from try @ 00ccd3cc with catch @ 00ccc390 */
            FUN_01211a40(&local_90,*(long *)(plVar15[1] + -0x18) + 5);
            FUN_0121218c(&local_90,"Node ",5);
            FUN_01211fcc(&local_90,plVar15 + 1);
            plVar12 = (long *)FUN_0121218c(&local_90," part is missing meshPartId or materialId",
                                           0x29);
            puVar11 = PTR_DAT_017191c0;
            lVar10 = *plVar12;
            *plVar12 = (long)(PTR_DAT_017191c0 + 0x18);
            if (local_90 + -0x18 != (NodeData *)puVar11) {
                    /* try { // try from 00ccc8d8 to 00dcc9b3 has its CatchHandler @ 00ccd0fc */
              FUN_00cc93d0(local_90 + -0x18,&local_98);
            }
            if (local_a8 != (ModelData *)0x0) {
                    /* try { // try from 00ccc400 to 00dcc403 has its CatchHandler @ 00ccd3b4 */
              (**(code **)(*(long *)local_a8 + 8))();
            }
            local_a8 = (ModelData *)0x0;
            (**(code **)(*plVar15 + 8))(plVar15);
            if ((undefined *)(lVar10 + -0x18) != PTR_DAT_017191c0) {
              FUN_00cc93d0((undefined *)(lVar10 + -0x18),&local_90);
            }
            goto LAB_00ccc160;
          }
          local_b8[0] = 0;
          lVar10 = BundleReader::read(this_00,local_b8,4,1);
          if (lVar10 != 1) {
LAB_00ccc624:
            if (local_a8 != (ModelData *)0x0) {
              (**(code **)(*(long *)local_a8 + 8))();
            }
            local_a8 = (ModelData *)0x0;
            if (plVar15 != (long *)0x0) {
              (**(code **)(*plVar15 + 8))();
            }
            goto LAB_00ccc160;
          }
          if (local_b8[0] != 0) {
            uVar18 = 0;
            do {
              BundleReader::readString();
              pMVar17 = local_a8;
              lVar10 = *(long *)(local_a8 + 0x20);
              if (lVar10 == *(long *)(local_a8 + 0x28)) {
                std::vector<std::string,std::allocator<std::string>>::
                _M_emplace_back_aux<std::string_const&>
                          ((vector<std::string,std::allocator<std::string>> *)(local_a8 + 0x18),
                           (string *)&local_90);
              }
              else {
                lVar13 = 0;
                if (lVar10 != 0) {
                  FUN_01214ee0(lVar10,(string *)&local_90);
                  lVar13 = *(long *)(pMVar17 + 0x20);
                }
                *(long *)(pMVar17 + 0x20) = lVar13 + 8;
              }
              Mat4::Mat4(aMStack_48);
              cVar8 = BundleReader::readMatrix(this_00,(float *)aMStack_48);
              pMVar17 = local_a8;
              if (cVar8 == '\0') {
                if (local_a8 != (ModelData *)0x0) {
                  (**(code **)(*(long *)local_a8 + 8))();
                }
                local_a8 = (ModelData *)0x0;
                if (plVar15 != (long *)0x0) {
                  (**(code **)(*plVar15 + 8))();
                }
                Mat4::~Mat4(aMStack_48);
                if (local_90 + -0x18 != (NodeData *)PTR_DAT_017191c0) {
                  FUN_00cc93d0(local_90 + -0x18,&local_98);
                }
                goto LAB_00ccc160;
              }
              this_01 = *(Mat4 **)(local_a8 + 0x38);
              if (this_01 == *(Mat4 **)(local_a8 + 0x40)) {
                std::vector<cocos2d::Mat4,std::allocator<cocos2d::Mat4>>::
                _M_emplace_back_aux<cocos2d::Mat4_const&>
                          ((vector<cocos2d::Mat4,std::allocator<cocos2d::Mat4>> *)(local_a8 + 0x30),
                           aMStack_48);
              }
              else {
                lVar10 = 0;
                if (this_01 != (Mat4 *)0x0) {
                  Mat4::Mat4(this_01,aMStack_48);
                  lVar10 = *(long *)(pMVar17 + 0x38);
                }
                    /* try { // try from 00ccc544 to 00dcc8c7 has its CatchHandler @ 00ccced8 */
                *(long *)(pMVar17 + 0x38) = lVar10 + 0x40;
              }
              Mat4::~Mat4(aMStack_48);
              if (local_90 + -0x18 != (NodeData *)PTR_DAT_017191c0) {
                FUN_00cc93d0(local_90 + -0x18,&local_98);
              }
              uVar18 = uVar18 + 1;
                    /* try { // try from 00ccc4bc to 00dcc4bf has its CatchHandler @ 00ccd378 */
            } while (uVar18 < local_b8[0]);
            bVar7 = true;
          }
          local_a0 = 0;
          lVar10 = BundleReader::read(this_00,&local_a0,4,1);
          if (lVar10 != 1) goto LAB_00ccc624;
          uVar18 = 0;
          if (local_a0 != 0) {
            do {
              local_98 = 0;
              lVar10 = BundleReader::read(this_00,&local_98,4,1);
              if (lVar10 != 1) goto LAB_00ccc624;
              uVar16 = 0;
              if (local_98 != 0) {
                do {
                  local_90 = (NodeData *)((ulong)local_90 & 0xffffffff00000000);
                  lVar10 = BundleReader::read(this_00,(string *)&local_90,4,1);
                  if (lVar10 != 1) goto LAB_00ccc624;
                  uVar16 = uVar16 + 1;
                } while (uVar16 < local_98);
              }
              uVar18 = uVar18 + 1;
            } while (uVar18 < local_a0);
          }
          puVar14 = (undefined8 *)plVar15[0xb];
          if (puVar14 == (undefined8 *)plVar15[0xc]) {
            std::vector<cocos2d::ModelData*,std::allocator<cocos2d::ModelData*>>::
            _M_emplace_back_aux<cocos2d::ModelData*const&>
                      ((vector<cocos2d::ModelData*,std::allocator<cocos2d::ModelData*>> *)
                       (plVar15 + 10),&local_a8);
          }
          else {
            if (puVar14 != (undefined8 *)0x0) {
              *puVar14 = local_a8;
            }
            plVar15[0xb] = plVar15[0xb] + 8;
          }
          local_fc = local_fc + 1;
        } while (local_fc < local_bc);
      }
      pBVar1 = this + 0x18;
      iVar9 = FUN_01213398(pBVar1,&DAT_0133a468);
      if ((((((iVar9 == 0) || (iVar9 = FUN_01213398(pBVar1,&DAT_0133a470), iVar9 == 0)) ||
            (iVar9 = FUN_01213398(pBVar1,&DAT_0133a478), iVar9 == 0)) ||
           ((iVar9 = FUN_01213398(pBVar1,&DAT_0133a480), iVar9 == 0 ||
            (iVar9 = FUN_01213398(pBVar1,&DAT_0133a488), iVar9 == 0)))) ||
          (iVar9 = FUN_01213398(pBVar1,&DAT_0133a490), iVar9 == 0)) && ((bVar7 || (param_2)))) {
        lVar3 = *(long *)(PTR_IDENTITY_01717ce0 + 8);
        lVar10 = *(long *)(PTR_IDENTITY_01717ce0 + 0x10);
        lVar4 = *(long *)(PTR_IDENTITY_01717ce0 + 0x18);
        lVar13 = *(long *)(PTR_IDENTITY_01717ce0 + 0x20);
        lVar5 = *(long *)(PTR_IDENTITY_01717ce0 + 0x28);
        lVar2 = *(long *)(PTR_IDENTITY_01717ce0 + 0x30);
        lVar6 = *(long *)(PTR_IDENTITY_01717ce0 + 0x38);
        plVar15[2] = *(long *)PTR_IDENTITY_01717ce0;
        plVar15[3] = lVar3;
        plVar15[4] = lVar10;
        plVar15[5] = lVar4;
        plVar15[6] = lVar13;
        plVar15[7] = lVar5;
        plVar15[8] = lVar2;
        plVar15[9] = lVar6;
      }
      else {
        plVar15[2] = local_88;
        plVar15[3] = lStack_80;
        plVar15[4] = local_78;
        plVar15[5] = lStack_70;
        plVar15[6] = local_68;
        plVar15[7] = lStack_60;
        plVar15[8] = local_58;
        plVar15[9] = lStack_50;
      }
      local_a8 = (ModelData *)((ulong)local_a8 & 0xffffffff00000000);
      lVar10 = BundleReader::read(this_00,&local_a8,4,1);
      if (lVar10 == 1) {
        if ((uint)local_a8 != 0) {
          uVar18 = 0;
          do {
            local_90 = (NodeData *)parseNodesRecursivelyBinary(this,param_1,param_2);
            puVar14 = (undefined8 *)plVar15[0xe];
            if (puVar14 == (undefined8 *)plVar15[0xf]) {
              std::vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>>::
              _M_emplace_back_aux<cocos2d::NodeData*const&>
                        ((vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>> *)
                         (plVar15 + 0xd),&local_90);
            }
            else {
              lVar10 = 0;
              if (puVar14 != (undefined8 *)0x0) {
                *puVar14 = local_90;
                lVar10 = plVar15[0xe];
              }
              plVar15[0xe] = lVar10 + 8;
            }
            uVar18 = uVar18 + 1;
          } while (uVar18 < (uint)local_a8);
        }
      }
      else {
        if (plVar15 == (long *)0x0) goto LAB_00ccc160;
        lVar10 = *plVar15;
        plVar15 = (long *)0x0;
        (**(code **)(lVar10 + 8))();
      }
    }
    Mat4::~Mat4((Mat4 *)&local_88);
    puVar11 = (undefined *)(local_b0 + -0x18);
    if (puVar11 == PTR_DAT_017191c0) goto LAB_00ccc180;
  }
  else {
    plVar15 = (long *)0x0;
    puVar11 = (undefined *)(local_b0 + -0x18);
    if (puVar11 == PTR_DAT_017191c0) goto LAB_00ccc180;
  }
  FUN_00cc93d0(puVar11,&local_90);
LAB_00ccc180:
                    /* try { // try from 00ccc190 to 00dcc197 has its CatchHandler @ 00ccbefc */
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(plVar15);
  }
  return;
}


/* === loadNodesBinary @ 00ccc9d4 === */

/* cocos2d::Bundle3D::loadNodesBinary(cocos2d::NodeDatas&) */

void __thiscall cocos2d::Bundle3D::loadNodesBinary(Bundle3D *this,NodeDatas *param_1)

{
  long lVar1;
  undefined8 uVar2;
  long *plVar3;
  uint uVar4;
  bool local_20 [8];
  uint local_18 [2];
  long local_10;
  long local_8;
  
                    /* try { // try from 00ccc9d4 to 00dcc9d7 has its CatchHandler @ 00ccd25c */
                    /* try { // try from 00ccc9e8 to 00dcc9eb has its CatchHandler @ 00ccd268 */
                    /* try { // try from 00ccc9ec to 00dcc9ef has its CatchHandler @ 00ccd3e0 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* try { // try from 00ccca14 to 00dcca17 has its CatchHandler @ 00ccd3ec */
  FUN_01211570((string *)&local_10,&DAT_012fc3d8,local_20);
                    /* try { // try from 00ccca20 to 00dcca23 has its CatchHandler @ 00ccd3f0 */
  lVar1 = seekToFirstType(this,2,(string *)&local_10);
                    /* try { // try from 00ccca30 to 00dcca33 has its CatchHandler @ 00ccd410 */
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
    FUN_00cc93d0((undefined *)(local_10 + -0x18),local_18);
  }
  if (lVar1 != 0) {
    local_18[0] = 0;
    lVar1 = BundleReader::read((BundleReader *)(this + 0xa0),local_18,4,1);
    if (lVar1 == 1) {
      uVar4 = 0;
      if (local_18[0] != 0) {
        do {
          while( true ) {
            local_20[0] = false;
            local_10 = parseNodesRecursivelyBinary(this,local_20,local_18[0] == 1);
            if (local_20[0] == false) break;
            plVar3 = *(long **)(param_1 + 0x10);
                    /* try { // try from 00cccac4 to 00dccac7 has its CatchHandler @ 00ccd0fc */
            if (*(long **)(param_1 + 0x18) == plVar3) {
                    /* try { // try from 00cccb70 to 00dccb73 has its CatchHandler @ 00ccd344 */
              std::vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>>::
              _M_emplace_back_aux<cocos2d::NodeData*const&>
                        ((vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>> *)
                         (param_1 + 8),(NodeData **)&local_10);
            }
            else {
              lVar1 = 0;
              if (plVar3 != (long *)0x0) {
                *plVar3 = local_10;
                lVar1 = *(long *)(param_1 + 0x10);
              }
              *(long *)(param_1 + 0x10) = lVar1 + 8;
            }
LAB_00cccadc:
            uVar4 = uVar4 + 1;
            if (local_18[0] <= uVar4) goto LAB_00cccb44;
          }
          plVar3 = *(long **)(param_1 + 0x28);
          if (plVar3 == *(long **)(param_1 + 0x30)) {
            std::vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>>::
            _M_emplace_back_aux<cocos2d::NodeData*const&>
                      ((vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>> *)
                       (param_1 + 0x20),(NodeData **)&local_10);
            goto LAB_00cccadc;
          }
          lVar1 = 0;
          if (plVar3 != (long *)0x0) {
            *plVar3 = local_10;
            lVar1 = *(long *)(param_1 + 0x28);
          }
          *(long *)(param_1 + 0x28) = lVar1 + 8;
          uVar4 = uVar4 + 1;
        } while (uVar4 < local_18[0]);
      }
LAB_00cccb44:
      uVar2 = 1;
                    /* try { // try from 00cccb48 to 00dccb67 has its CatchHandler @ 00ccd31c */
      goto LAB_00ccca74;
    }
  }
  uVar2 = 0;
LAB_00ccca74:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar2);
  }
  return;
}


/* === parseNodesRecursivelyJson @ 00ccdba4 === */

/* WARNING: Restarted to delay deadcode elimination for space: stack */
/* cocos2d::Bundle3D::parseNodesRecursivelyJson(rapidjson::GenericValue<rapidjson::UTF8<char>,
   rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator> > const&, bool) */

void __thiscall
cocos2d::Bundle3D::parseNodesRecursivelyJson(Bundle3D *this,GenericValue *param_1,bool param_2)

{
  undefined *puVar1;
  Bundle3D *pBVar2;
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
  *this_00;
  uint uVar3;
  ushort uVar4;
  float fVar5;
  bool bVar6;
  int iVar7;
  int iVar8;
  NodeData *this_01;
  GenericValue *pGVar9;
  undefined8 uVar10;
  GenericValue *pGVar11;
  Mat4 *this_02;
  long lVar12;
  int *piVar13;
  long *plVar14;
  int *piVar15;
  undefined8 *puVar16;
  int *piVar17;
  char *pcVar18;
  double *pdVar19;
  int *piVar20;
  uint uVar21;
  char *pcVar22;
  vector<cocos2d::Mat4,std::allocator<cocos2d::Mat4>> *this_03;
  NodeData *pNVar23;
  ModelData *pMVar24;
  long lVar25;
  char *pcVar26;
  double dVar27;
  char *local_138;
  char *local_130;
  uint local_11c;
  undefined1 auStack_a8 [8];
  undefined1 auStack_a0 [8];
  ModelData *local_98;
  undefined *local_90;
  undefined8 local_88;
  undefined8 uStack_80;
  undefined8 local_78;
  undefined8 uStack_70;
  undefined8 local_68;
  undefined8 uStack_60;
  undefined8 local_58;
  undefined8 uStack_50;
  ulong local_48;
  char *local_40;
  undefined8 local_38;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  this_01 = operator_new(0x80,(nothrow_t *)PTR_nothrow_01717628);
  if (this_01 == (NodeData *)0x0) {
    pNVar23 = (NodeData *)&DAT_00000008;
  }
  else {
    *(undefined8 *)this_01 = 0;
    *(undefined8 *)(this_01 + 8) = 0;
    *(undefined8 *)(this_01 + 0x10) = 0;
    *(undefined8 *)(this_01 + 0x18) = 0;
    *(undefined8 *)(this_01 + 0x20) = 0;
    *(undefined8 *)(this_01 + 0x28) = 0;
    *(undefined8 *)(this_01 + 0x30) = 0;
    *(undefined8 *)(this_01 + 0x38) = 0;
    *(undefined8 *)(this_01 + 0x40) = 0;
    *(undefined8 *)(this_01 + 0x48) = 0;
    *(undefined8 *)(this_01 + 0x50) = 0;
    *(undefined8 *)(this_01 + 0x58) = 0;
    *(undefined8 *)(this_01 + 0x60) = 0;
    *(undefined8 *)(this_01 + 0x68) = 0;
    *(undefined8 *)(this_01 + 0x70) = 0;
    *(undefined8 *)(this_01 + 0x78) = 0;
    NodeData::NodeData(this_01);
    pNVar23 = this_01 + 8;
  }
                    /* catch() { ... } // from try @ 00ccd9b0 with catch @ 00ccdc2c
                       catch() { ... } // from try @ 00ccdb68 with catch @ 00ccdc2c */
  pcVar18 = "id";
  do {
    pcVar18 = pcVar18 + 1;
  } while (*pcVar18 != '\0');
                    /* try { // try from 00ccdc54 to 00dcdc83 has its CatchHandler @ 00ccd420 */
                    /* catch() { ... } // from try @ 00ccd4a4 with catch @ 00ccdc58 */
  local_40 = "id";
  local_48 = (ulong)((int)pcVar18 + 0xfecc5b48);
  local_38 = 0x405000000000000;
  pGVar9 = rapidjson::
           GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
           ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                     ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                       *)param_1,(GenericValue *)&local_48);
                    /* catch() { ... } // from try @ 00ccda00 with catch @ 00ccdc70
                       catch() { ... } // from try @ 00ccdb24 with catch @ 00ccdc70 */
  if ((*(ushort *)(pGVar9 + 0x16) >> 0xc & 1) == 0) {
    pGVar9 = *(GenericValue **)(pGVar9 + 8);
  }
  uVar10 = strlen(pGVar9);
                    /* catch() { ... } // from try @ 00ccdcf4 with catch @ 00ccdc90
                       catch() { ... } // from try @ 00cce240 with catch @ 00ccdc90
                       catch() { ... } // from try @ 00cce30c with catch @ 00ccdc90 */
  FUN_01213b44(pNVar23,pGVar9,uVar10);
  Mat4::Mat4((Mat4 *)&local_88);
  pcVar18 = "transform";
  do {
    pcVar18 = pcVar18 + 1;
  } while (*pcVar18 != '\0');
                    /* try { // try from 00ccdce4 to 00dcdce7 has its CatchHandler @ 00cce2f4 */
  local_40 = "transform";
  local_38 = 0x405000000000000;
  local_48 = (ulong)((int)pcVar18 + 0xfed10708);
  pGVar9 = rapidjson::
           GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
           ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                     ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                       *)param_1,(GenericValue *)&local_48);
  if (*(int *)pGVar9 != 0) {
                    /* try { // try from 00ccdcf4 to 00dcdd43 has its CatchHandler @ 00ccdc90 */
    pdVar19 = *(double **)(pGVar9 + 8);
    lVar25 = (ulong)(*(int *)pGVar9 - 1) + 1;
    lVar12 = 0;
    do {
      while (uVar4 = *(ushort *)((long)pdVar19 + 0x16), (uVar4 >> 9 & 1) == 0) {
        if ((uVar4 >> 5 & 1) == 0) {
          if ((uVar4 >> 6 & 1) == 0) {
            if ((uVar4 >> 7 & 1) == 0) {
              fVar5 = (float)(ulong)*pdVar19;
            }
            else {
              fVar5 = (float)(long)*pdVar19;
            }
          }
          else {
            fVar5 = (float)*(uint *)pdVar19;
          }
        }
        else {
          fVar5 = (float)(int)*(uint *)pdVar19;
        }
        pdVar19 = pdVar19 + 3;
        *(float *)((Mat4 *)&local_88 + lVar12 * 4) = fVar5;
        lVar12 = lVar12 + 1;
        if (lVar12 == lVar25) goto LAB_00ccdd5c;
      }
      dVar27 = *pdVar19;
      pdVar19 = pdVar19 + 3;
      *(float *)((Mat4 *)&local_88 + lVar12 * 4) = (float)dVar27;
      lVar12 = lVar12 + 1;
    } while (lVar12 != lVar25);
  }
LAB_00ccdd5c:
                    /* try { // try from 00ccdd7c to 00dcdd7f has its CatchHandler @ 00cce310 */
  *(undefined8 *)(this_01 + 0x40) = local_58;
  *(undefined8 *)(this_01 + 0x48) = uStack_50;
  *(undefined8 *)(this_01 + 0x10) = local_88;
  *(undefined8 *)(this_01 + 0x18) = uStack_80;
  *(undefined8 *)(this_01 + 0x20) = local_78;
  *(undefined8 *)(this_01 + 0x28) = uStack_70;
  *(undefined8 *)(this_01 + 0x30) = local_68;
  *(undefined8 *)(this_01 + 0x38) = uStack_60;
  rapidjson::
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>::
  FindMember((char *)param_1);
                    /* try { // try from 00ccddb8 to 00dcddbb has its CatchHandler @ 00cce2d0 */
  if (local_90 != (undefined *)(*(long *)(param_1 + 8) + (ulong)*(uint *)param_1 * 0x30)) {
    pcVar18 = "parts";
    do {
      pcVar18 = pcVar18 + 1;
    } while (*pcVar18 != '\0');
                    /* try { // try from 00ccdddc to 00dcddfb has its CatchHandler @ 00cce22c */
    local_38 = 0x405000000000000;
    local_40 = "parts";
    local_48 = (ulong)((int)pcVar18 + 0xfecc5b68);
    pGVar9 = rapidjson::
             GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
             ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                       ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                         *)param_1,(GenericValue *)&local_48);
                    /* try { // try from 00ccde08 to 00dcdeef has its CatchHandler @ 00cce244 */
    if (*(int *)pGVar9 != 0) {
      local_11c = 0;
      bVar6 = false;
      local_130 = "materialid";
      local_138 = "bones";
      do {
        pMVar24 = (ModelData *)&DAT_00000008;
        local_98 = operator_new(0x48,(nothrow_t *)PTR_nothrow_01717628);
        if (local_98 != (ModelData *)0x0) {
          *(long *)(local_98 + 0x18) = 0;
          *(long *)(local_98 + 0x20) = 0;
          *(long *)(local_98 + 0x28) = 0;
          *(long *)(local_98 + 0x30) = 0;
          *(long *)(local_98 + 0x38) = 0;
          *(long *)(local_98 + 0x40) = 0;
          pMVar24 = local_98 + 8;
          *(undefined **)local_98 = PTR_vtable_01714720 + 0x10;
          puVar1 = PTR_DAT_017191c0 + 0x18;
          *(undefined **)(local_98 + 8) = puVar1;
          *(undefined **)(local_98 + 0x10) = puVar1;
        }
        lVar25 = *(long *)(pGVar9 + 8);
        pcVar18 = "meshpartid";
        this_00 = (GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                   *)(lVar25 + (ulong)local_11c * 0x18);
        do {
          pcVar18 = pcVar18 + 1;
        } while (*pcVar18 != '\0');
        local_38 = 0x405000000000000;
        local_40 = "meshpartid";
        local_48 = (ulong)((int)pcVar18 + 0xfecc5b60);
        pGVar11 = rapidjson::
                  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                  ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                            (this_00,(GenericValue *)&local_48);
        if ((*(ushort *)(pGVar11 + 0x16) >> 0xc & 1) == 0) {
          pGVar11 = *(GenericValue **)(pGVar11 + 8);
        }
        uVar10 = strlen(pGVar11);
        FUN_01213b44(pMVar24,pGVar11,uVar10);
        pMVar24 = local_98 + 0x10;
        pcVar18 = local_130;
        do {
          pcVar18 = pcVar18 + 1;
        } while (*pcVar18 != '\0');
                    /* try { // try from 00ccdf50 to 00dcdf53 has its CatchHandler @ 00cce2a4 */
        local_40 = "materialid";
        local_48 = (ulong)((int)pcVar18 + 0xfecc5b50);
        local_38 = 0x405000000000000;
        pGVar11 = rapidjson::
                  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                  ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                            (this_00,(GenericValue *)&local_48);
        if ((*(ushort *)(pGVar11 + 0x16) >> 0xc & 1) == 0) {
                    /* try { // try from 00cce038 to 00dce03b has its CatchHandler @ 00cce2b8 */
          pGVar11 = *(GenericValue **)(pGVar11 + 8);
        }
        uVar10 = strlen(pGVar11);
        FUN_01213b44(pMVar24,pGVar11,uVar10);
        iVar7 = FUN_01213398(local_98 + 8,&DAT_012fc3d8);
                    /* try { // try from 00cce054 to 00dce077 has its CatchHandler @ 00cce26c */
        if ((iVar7 == 0) || (iVar7 = FUN_01213398(local_98 + 0x10,&DAT_012fc3d8), iVar7 == 0)) {
LAB_00ccdfa8:
          if (local_98 != (ModelData *)0x0) {
            (**(code **)(*(long *)local_98 + 8))();
          }
          local_98 = (ModelData *)0x0;
          (**(code **)(*(long *)this_01 + 8))();
          this_01 = (NodeData *)0x0;
          goto LAB_00ccdfd4;
        }
        rapidjson::
        GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
        ::FindMember((char *)this_00);
        pcVar18 = local_138;
        if (local_90 !=
            (undefined *)
            (*(long *)(this_00 + 8) + (ulong)*(uint *)(lVar25 + (ulong)local_11c * 0x18) * 0x30)) {
          do {
            pcVar18 = pcVar18 + 1;
          } while (*pcVar18 != '\0');
          local_40 = "bones";
          local_48 = (ulong)((int)pcVar18 + 0xfecc5b40);
          local_38 = 0x405000000000000;
          pGVar11 = rapidjson::
                    GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                    ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                              (this_00,(GenericValue *)&local_48);
          if (*(int *)pGVar11 != 0) {
            uVar21 = 0;
            pcVar18 = "node";
            do {
              lVar12 = *(long *)(pGVar11 + 8);
              lVar25 = (ulong)uVar21 * 0x18;
              pcVar22 = pcVar18;
              do {
                pcVar26 = pcVar22;
                pcVar22 = pcVar26 + 1;
              } while (*pcVar22 != '\0');
              pcVar26 = pcVar26 + -0x133a4c7;
              iVar7 = (int)pcVar26;
                    /* try { // try from 00cce138 to 00dce13b has its CatchHandler @ 00cce2f0 */
              piVar20 = *(int **)(lVar12 + lVar25 + 8);
              piVar17 = piVar20 + (ulong)*(uint *)(lVar12 + lVar25) * 0xc;
              if (piVar20 == piVar17) goto LAB_00ccdfa8;
              piVar15 = piVar20;
LAB_00cce184:
              if ((*(ushort *)((long)piVar15 + 0x16) >> 0xc & 1) != 0) {
                piVar13 = piVar15;
                if (iVar7 == 0x15 - *(char *)((long)piVar15 + 0x15)) goto LAB_00cce19c;
LAB_00cce178:
                piVar15 = piVar15 + 0xc;
                if (piVar17 == piVar15) goto LAB_00ccdfa8;
                goto LAB_00cce184;
              }
              if (iVar7 != *piVar15) goto LAB_00cce178;
              piVar13 = *(int **)(piVar15 + 2);
LAB_00cce19c:
              if (piVar13 != (int *)&DAT_0133a4c8) {
                iVar8 = memcmp(&DAT_0133a4c8,piVar13,(ulong)pcVar26 & 0xffffffff);
                pcVar22 = pcVar18;
                if (iVar8 == 0) goto LAB_00cce1bc;
                goto LAB_00cce178;
              }
              pcVar22 = pcVar18;
              if (piVar17 == piVar15) goto LAB_00ccdfa8;
LAB_00cce1bc:
              do {
                pcVar26 = pcVar22;
                pMVar24 = local_98;
                pcVar22 = pcVar26 + 1;
              } while (*pcVar22 != '\0');
              pcVar26 = pcVar26 + -0x133a4c7;
              iVar7 = (int)pcVar26;
              do {
                if ((*(ushort *)((long)piVar20 + 0x16) >> 0xc & 1) == 0) {
                  if (iVar7 == *piVar20) {
                    piVar15 = *(int **)(piVar20 + 2);
LAB_00cce210:
                    if (piVar15 == (int *)&DAT_0133a4c8) {
                      if (piVar17 == piVar20) break;
                    }
                    else {
                      iVar8 = memcmp(&DAT_0133a4c8,piVar15,(ulong)pcVar26 & 0xffffffff);
                      if (iVar8 != 0) goto LAB_00cce1ec;
                    }
                    /* catch() { ... } // from try @ 00ccdddc with catch @ 00cce22c */
                    piVar17 = piVar20 + 6;
                    uVar4 = *(ushort *)((long)piVar20 + 0x2e);
                    goto LAB_00cce238;
                  }
                }
                else {
                    /* try { // try from 00cce1d8 to 00dce1db has its CatchHandler @ 00cce318 */
                  piVar15 = piVar20;
                  if (iVar7 == 0x15 - *(char *)((long)piVar20 + 0x15)) goto LAB_00cce210;
                }
LAB_00cce1ec:
                piVar20 = piVar20 + 0xc;
              } while (piVar17 != piVar20);
              piVar17 = (int *)PTR_buffer_01719d48;
              uVar4 = uRam0000000000000016;
              if (PTR_buffer_01719d48 == (undefined *)0x0) {
LAB_00cce238:
                if ((uVar4 & 0x1000) == 0) goto LAB_00cce604;
              }
              else {
                *(undefined8 *)PTR_buffer_01719d48 = 0;
                *(undefined8 *)((long)piVar17 + 8) = 0;
                    /* try { // try from 00cce600 to 00dce603 has its CatchHandler @ 00cce338 */
                *(undefined8 *)((long)piVar17 + 0x10) = 0;
LAB_00cce604:
                piVar17 = *(int **)(piVar17 + 2);
              }
                    /* try { // try from 00cce240 to 00dce243 has its CatchHandler @ 00ccdc90 */
                    /* catch() { ... } // from try @ 00ccde08 with catch @ 00cce244 */
              FUN_01211570((string *)&local_90,piVar17,auStack_a8);
              plVar14 = *(long **)(pMVar24 + 0x20);
              if (plVar14 == *(long **)(pMVar24 + 0x28)) {
                std::vector<std::string,std::allocator<std::string>>::
                _M_emplace_back_aux<std::string>
                          ((vector<std::string,std::allocator<std::string>> *)(pMVar24 + 0x18),
                           (string *)&local_90);
              }
              else {
                if (plVar14 != (long *)0x0) {
                    /* catch() { ... } // from try @ 00cce054 with catch @ 00cce26c */
                  *plVar14 = (long)local_90;
                  local_90 = PTR_DAT_017191c0 + 0x18;
                }
                *(long **)(pMVar24 + 0x20) = plVar14 + 1;
              }
              if (local_90 + -0x18 != PTR_DAT_017191c0) {
                FUN_00cc93d0(local_90 + -0x18,auStack_a0);
              }
              Mat4::Mat4((Mat4 *)&local_48);
              pcVar22 = "transform";
              do {
                pcVar26 = pcVar22;
                    /* catch() { ... } // from try @ 00ccdf50 with catch @ 00cce2a4 */
                pcVar22 = pcVar26 + 1;
              } while (*pcVar22 != '\0');
              pcVar26 = pcVar26 + -0x12ef8f7;
              iVar7 = (int)pcVar26;
                    /* catch() { ... } // from try @ 00cce038 with catch @ 00cce2b8 */
              piVar20 = *(int **)(lVar12 + lVar25 + 8);
              piVar17 = piVar20 + (ulong)*(uint *)(lVar12 + lVar25) * 0xc;
                    /* catch() { ... } // from try @ 00ccddb8 with catch @ 00cce2d0 */
              if (piVar17 != piVar20) {
                do {
                    /* try { // try from 00cce30c to 00dce30f has its CatchHandler @ 00ccdc90 */
                  if ((*(ushort *)((long)piVar20 + 0x16) >> 0xc & 1) == 0) {
                    /* catch() { ... } // from try @ 00ccdd7c with catch @ 00cce310 */
                    /* catch() { ... } // from try @ 00cce1d8 with catch @ 00cce318
                       catch() { ... } // from try @ 00cce31c with catch @ 00cce318 */
                    if (iVar7 == *piVar20) {
                    /* try { // try from 00cce31c to 00dce31f has its CatchHandler @ 00cce318 */
                      piVar15 = *(int **)(piVar20 + 2);
LAB_00cce320:
                      if (piVar15 == (int *)0x12ef8f8) {
                    /* try { // try from 00cce618 to 00dce68b has its CatchHandler @ 00cce7d0 */
                        if (piVar17 == piVar20) break;
                      }
                      else {
                        iVar8 = memcmp("transform",piVar15,(ulong)pcVar26 & 0xffffffff);
                        if (iVar8 != 0) goto LAB_00cce2fc;
                      }
                    /* catch() { ... } // from try @ 00cce39c with catch @ 00cce338
                       catch() { ... } // from try @ 00cce4d4 with catch @ 00cce338
                       catch() { ... } // from try @ 00cce54c with catch @ 00cce338
                       catch() { ... } // from try @ 00cce600 with catch @ 00cce338
                       catch() { ... } // from try @ 00cce7cc with catch @ 00cce338 */
                      piVar17 = piVar20 + 6;
                      iVar7 = piVar20[6];
                      goto LAB_00cce340;
                    }
                  }
                  else {
                    /* catch() { ... } // from try @ 00cce138 with catch @ 00cce2f0 */
                    /* catch() { ... } // from try @ 00ccdce4 with catch @ 00cce2f4 */
                    piVar15 = piVar20;
                    if (iVar7 == 0x15 - *(char *)((long)piVar20 + 0x15)) goto LAB_00cce320;
                  }
LAB_00cce2fc:
                  piVar20 = piVar20 + 0xc;
                } while (piVar17 != piVar20);
              }
              puVar1 = PTR_buffer_01719d48;
              if (PTR_buffer_01719d48 == (undefined *)0x0) {
                piVar17 = (int *)0x0;
                iVar7 = iRam0000000000000000;
LAB_00cce340:
                if (iVar7 != 0) {
                  pdVar19 = *(double **)(piVar17 + 2);
                  lVar25 = (ulong)(iVar7 - 1) + 1;
                  lVar12 = 0;
                  do {
                    /* try { // try from 00cce388 to 00dce38b has its CatchHandler @ 00cce7b8 */
                    while (uVar4 = *(ushort *)((long)pdVar19 + 0x16), (uVar4 >> 9 & 1) == 0) {
                      if ((uVar4 >> 5 & 1) == 0) {
                        if ((uVar4 >> 6 & 1) == 0) {
                          if ((uVar4 >> 7 & 1) == 0) {
                            fVar5 = (float)(ulong)*pdVar19;
                          }
                          else {
                    /* try { // try from 00cce5dc to 00dce5df has its CatchHandler @ 00cce824 */
                            fVar5 = (float)(long)*pdVar19;
                          }
                        }
                        else {
                          fVar5 = (float)*(uint *)pdVar19;
                        }
                      }
                      else {
                        fVar5 = (float)(int)*(uint *)pdVar19;
                      }
                      pdVar19 = pdVar19 + 3;
                      *(float *)((GenericValue *)&local_48 + lVar12 * 4) = fVar5;
                      lVar12 = lVar12 + 1;
                      if (lVar12 == lVar25) goto LAB_00cce3a8;
                    }
                    dVar27 = *pdVar19;
                    pdVar19 = pdVar19 + 3;
                    *(float *)((GenericValue *)&local_48 + lVar12 * 4) = (float)dVar27;
                    /* try { // try from 00cce39c to 00dce493 has its CatchHandler @ 00cce338 */
                    lVar12 = lVar12 + 1;
                  } while (lVar12 != lVar25);
                }
LAB_00cce3a8:
                this_03 = (vector<cocos2d::Mat4,std::allocator<cocos2d::Mat4>> *)(local_98 + 0x30);
                this_02 = *(Mat4 **)(local_98 + 0x38);
                if (this_02 != *(Mat4 **)(local_98 + 0x40)) goto LAB_00cce3c0;
LAB_00cce64c:
                std::vector<cocos2d::Mat4,std::allocator<cocos2d::Mat4>>::
                _M_emplace_back_aux<cocos2d::Mat4_const&>(this_03,(Mat4 *)&local_48);
              }
              else {
                *(undefined8 *)PTR_buffer_01719d48 = 0;
                *(undefined8 *)(puVar1 + 8) = 0;
                this_03 = (vector<cocos2d::Mat4,std::allocator<cocos2d::Mat4>> *)(local_98 + 0x30);
                *(undefined8 *)(puVar1 + 0x10) = 0;
                this_02 = *(Mat4 **)(local_98 + 0x38);
                if (this_02 == *(Mat4 **)(local_98 + 0x40)) goto LAB_00cce64c;
LAB_00cce3c0:
                lVar25 = 0;
                if (this_02 != (Mat4 *)0x0) {
                  Mat4::Mat4(this_02,(Mat4 *)&local_48);
                  lVar25 = *(long *)(this_03 + 8);
                }
                *(long *)(this_03 + 8) = lVar25 + 0x40;
              }
              uVar21 = uVar21 + 1;
              Mat4::~Mat4((Mat4 *)&local_48);
            } while (uVar21 < *(uint *)pGVar11);
            if (*(uint *)pGVar11 != 0) {
              bVar6 = true;
            }
          }
        }
        puVar16 = *(undefined8 **)(this_01 + 0x58);
        if (puVar16 == *(undefined8 **)(this_01 + 0x60)) {
          std::vector<cocos2d::ModelData*,std::allocator<cocos2d::ModelData*>>::
          _M_emplace_back_aux<cocos2d::ModelData*const&>
                    ((vector<cocos2d::ModelData*,std::allocator<cocos2d::ModelData*>> *)
                     (this_01 + 0x50),&local_98);
                    /* try { // try from 00cce728 to 00dce737 has its CatchHandler @ 00cce7f8 */
        }
        else {
          lVar25 = 0;
          if (puVar16 != (undefined8 *)0x0) {
            *puVar16 = local_98;
            lVar25 = *(long *)(this_01 + 0x58);
          }
          *(long *)(this_01 + 0x58) = lVar25 + 8;
        }
        local_11c = local_11c + 1;
      } while (local_11c < *(uint *)pGVar9);
      goto LAB_00cce45c;
    }
  }
  bVar6 = false;
LAB_00cce45c:
  pBVar2 = this + 0x18;
  iVar7 = FUN_01213398(pBVar2,&DAT_0133a468);
  if ((((((iVar7 == 0) || (iVar7 = FUN_01213398(pBVar2,&DAT_0133a470), iVar7 == 0)) ||
        (iVar7 = FUN_01213398(pBVar2,&DAT_0133a478), iVar7 == 0)) ||
       ((iVar7 = FUN_01213398(pBVar2,&DAT_0133a480), iVar7 == 0 ||
        (iVar7 = FUN_01213398(pBVar2,&DAT_0133a488), iVar7 == 0)))) ||
      (iVar7 = FUN_01213398(pBVar2,&DAT_0133a490), iVar7 == 0)) && ((bVar6 || (param_2)))) {
    local_88 = *(undefined8 *)PTR_IDENTITY_01717ce0;
    uStack_80 = *(undefined8 *)(PTR_IDENTITY_01717ce0 + 8);
    local_78 = *(undefined8 *)(PTR_IDENTITY_01717ce0 + 0x10);
    uStack_70 = *(undefined8 *)(PTR_IDENTITY_01717ce0 + 0x18);
    local_68 = *(undefined8 *)(PTR_IDENTITY_01717ce0 + 0x20);
    uStack_60 = *(undefined8 *)(PTR_IDENTITY_01717ce0 + 0x28);
    local_58 = *(undefined8 *)(PTR_IDENTITY_01717ce0 + 0x30);
    uStack_50 = *(undefined8 *)(PTR_IDENTITY_01717ce0 + 0x38);
  }
                    /* try { // try from 00cce4a0 to 00dce4a3 has its CatchHandler @ 00cce7f8 */
  pcVar18 = "children";
  *(undefined8 *)(this_01 + 0x10) = local_88;
  *(undefined8 *)(this_01 + 0x18) = uStack_80;
  *(undefined8 *)(this_01 + 0x40) = local_58;
  *(undefined8 *)(this_01 + 0x48) = uStack_50;
  *(undefined8 *)(this_01 + 0x30) = local_68;
  *(undefined8 *)(this_01 + 0x38) = uStack_60;
  *(undefined8 *)(this_01 + 0x20) = local_78;
  *(undefined8 *)(this_01 + 0x28) = uStack_70;
  rapidjson::
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>::
  FindMember((char *)param_1);
                    /* try { // try from 00cce4d4 to 00dce51b has its CatchHandler @ 00cce338 */
  if (local_90 != (undefined *)(*(long *)(param_1 + 8) + (ulong)*(uint *)param_1 * 0x30)) {
    do {
      pcVar18 = pcVar18 + 1;
    } while (*pcVar18 != '\0');
                    /* try { // try from 00cce524 to 00dce527 has its CatchHandler @ 00cce820 */
    local_40 = "children";
    local_38 = 0x405000000000000;
    local_48 = (ulong)((int)pcVar18 + 0xfecca838);
    pGVar9 = rapidjson::
             GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
             ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                       ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                         *)param_1,(GenericValue *)&local_48);
    if (*(int *)pGVar9 != 0) {
      uVar21 = 0;
      do {
        while( true ) {
          local_90 = (undefined *)
                     parseNodesRecursivelyJson
                               (this,(GenericValue *)(*(long *)(pGVar9 + 8) + (ulong)uVar21 * 0x18),
                                param_2);
          plVar14 = *(long **)(this_01 + 0x70);
          if (plVar14 != *(long **)(this_01 + 0x78)) break;
          std::vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>>::
          _M_emplace_back_aux<cocos2d::NodeData*const&>
                    ((vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>> *)
                     (this_01 + 0x68),(NodeData **)&local_90);
          uVar21 = uVar21 + 1;
          if (*(uint *)pGVar9 <= uVar21) goto LAB_00ccdfd4;
        }
        lVar25 = 0;
        if (plVar14 != (long *)0x0) {
                    /* try { // try from 00cce54c to 00dce5d3 has its CatchHandler @ 00cce338 */
          *plVar14 = (long)local_90;
          lVar25 = *(long *)(this_01 + 0x70);
        }
        uVar3 = *(uint *)pGVar9;
        uVar21 = uVar21 + 1;
        *(long *)(this_01 + 0x70) = lVar25 + 8;
      } while (uVar21 < uVar3);
    }
  }
LAB_00ccdfd4:
  Mat4::~Mat4((Mat4 *)&local_88);
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(this_01);
  }
  return;
}


/* === loadNodesJson @ 00cce7bc === */

/* cocos2d::Bundle3D::loadNodesJson(cocos2d::NodeDatas&) */

void __thiscall cocos2d::Bundle3D::loadNodesJson(Bundle3D *this,NodeDatas *param_1)

{
  uint uVar1;
  GenericValue *pGVar2;
  ushort uVar3;
  int iVar4;
  int iVar5;
  GenericValue *pGVar6;
  undefined8 uVar7;
  NodeData *pNVar8;
  undefined *puVar9;
  vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>> *this_00;
  int *piVar10;
  long *plVar11;
  long lVar12;
  int *piVar13;
  char *pcVar14;
  int *piVar15;
  char *pcVar16;
  ulong uVar17;
  long lVar18;
  undefined1 auStack_38 [8];
  long local_30;
  NodeData *local_28;
  ulong local_20;
  char *local_18;
  undefined8 local_10;
  long local_8;
  
                    /* try { // try from 00cce7cc to 00dce7f7 has its CatchHandler @ 00cce338 */
                    /* catch() { ... } // from try @ 00cce618 with catch @ 00cce7d0 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  pcVar14 = "nodes";
                    /* catch() { ... } // from try @ 00cce4a0 with catch @ 00cce7f8
                       catch() { ... } // from try @ 00cce728 with catch @ 00cce7f8 */
  rapidjson::
  GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>::
  FindMember((char *)(this + 0x28));
                    /* catch() { ... } // from try @ 00cce524 with catch @ 00cce820 */
                    /* catch() { ... } // from try @ 00cce5dc with catch @ 00cce824 */
                    /* catch() { ... } // from try @ 00cce860 with catch @ 00cce82c
                       catch() { ... } // from try @ 00cce880 with catch @ 00cce82c
                       catch() { ... } // from try @ 00cce8dc with catch @ 00cce82c */
  if (local_28 != (NodeData *)(*(long *)(this + 0x30) + (ulong)*(uint *)(this + 0x28) * 0x30)) {
    do {
      pcVar14 = pcVar14 + 1;
    } while (*pcVar14 != '\0');
                    /* try { // try from 00cce868 to 00dce86b has its CatchHandler @ 00cce9d8 */
                    /* try { // try from 00cce860 to 00dce863 has its CatchHandler @ 00cce82c */
    local_18 = "nodes";
    local_10 = 0x405000000000000;
    local_20 = (ulong)((int)pcVar14 + 0xfecc5b30);
    pGVar6 = rapidjson::
             GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
             ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                       ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                         *)(this + 0x28),(GenericValue *)&local_20);
    if (*(short *)(pGVar6 + 0x16) == 4) {
      if (*(int *)pGVar6 != 0) {
        uVar17 = 0;
                    /* try { // try from 00cce8dc to 00dce9eb has its CatchHandler @ 00cce82c */
        do {
          lVar18 = *(long *)(pGVar6 + 8);
          lVar12 = uVar17 * 0x18;
          pGVar2 = (GenericValue *)(lVar18 + lVar12);
          pcVar14 = "id";
          do {
            pcVar16 = pcVar14;
            pcVar14 = pcVar16 + 1;
          } while (*pcVar14 != '\0');
          pcVar16 = pcVar16 + -0x133a4b7;
          iVar4 = (int)pcVar16;
          piVar15 = *(int **)(pGVar2 + 8);
          piVar13 = piVar15 + (ulong)*(uint *)(lVar18 + lVar12) * 0xc;
          if (piVar15 != piVar13) {
            do {
              if ((*(ushort *)((long)piVar15 + 0x16) >> 0xc & 1) == 0) {
                if (iVar4 == *piVar15) {
                  piVar10 = *(int **)(piVar15 + 2);
LAB_00cce98c:
                  if (piVar10 == (int *)0x133a4b8) {
                    if (piVar13 == piVar15) break;
                  }
                  else {
                    iVar5 = memcmp("id",piVar10,(ulong)pcVar16 & 0xffffffff);
                    if (iVar5 != 0) goto LAB_00cce968;
                  }
                  piVar13 = piVar15 + 6;
                  uVar3 = *(ushort *)((long)piVar15 + 0x2e);
                    /* catch() { ... } // from try @ 00cce8a8 with catch @ 00cce9ac */
                  goto LAB_00cce9b4;
                }
              }
              else {
                piVar10 = piVar15;
                if (iVar4 == 0x15 - *(char *)((long)piVar15 + 0x15)) goto LAB_00cce98c;
              }
LAB_00cce968:
              piVar15 = piVar15 + 0xc;
            } while (piVar13 != piVar15);
          }
          piVar13 = (int *)PTR_buffer_01719d48;
          uVar3 = uRam0000000000000016;
          if (PTR_buffer_01719d48 == (undefined *)0x0) {
LAB_00cce9b4:
            if ((uVar3 & 0x1000) == 0) goto LAB_00cceb48;
          }
          else {
            *(undefined8 *)PTR_buffer_01719d48 = 0;
            *(undefined8 *)((long)piVar13 + 8) = 0;
            *(undefined8 *)((long)piVar13 + 0x10) = 0;
LAB_00cceb48:
            piVar13 = *(int **)(piVar13 + 2);
          }
          FUN_01211570(&local_30,piVar13,&local_28);
                    /* catch() { ... } // from try @ 00cce868 with catch @ 00cce9d8 */
          pNVar8 = (NodeData *)parseNodesRecursivelyJson(this,pGVar2,*(int *)pGVar6 == 1);
          pcVar14 = "skeleton";
          do {
            pcVar16 = pcVar14;
            pcVar14 = pcVar16 + 1;
          } while (*pcVar14 != '\0');
                    /* catch() { ... } // from try @ 00ccea38 with catch @ 00cce9f0
                       catch() { ... } // from try @ 00ccecf8 with catch @ 00cce9f0 */
          pcVar16 = pcVar16 + -0x133a4d7;
          iVar4 = (int)pcVar16;
          piVar15 = *(int **)(pGVar2 + 8);
          piVar13 = piVar15 + (ulong)*(uint *)(lVar18 + lVar12) * 0xc;
          local_28 = pNVar8;
          if (piVar13 != piVar15) {
            do {
                    /* try { // try from 00ccea48 to 00dcece7 has its CatchHandler @ 00ccece8 */
              if ((*(ushort *)((long)piVar15 + 0x16) >> 0xc & 1) == 0) {
                if (iVar4 == *piVar15) {
                  piVar10 = *(int **)(piVar15 + 2);
LAB_00ccea60:
                  if (piVar10 == (int *)"skeleton") {
                    if (piVar13 == piVar15) break;
                  }
                  else {
                    iVar5 = memcmp("skeleton",piVar10,(ulong)pcVar16 & 0xffffffff);
                    if (iVar5 != 0) goto LAB_00ccea3c;
                  }
                  uVar3 = *(ushort *)((long)piVar15 + 0x2e);
                  goto LAB_00ccea7c;
                }
              }
              else {
                piVar10 = piVar15;
                    /* try { // try from 00ccea38 to 00dcea3b has its CatchHandler @ 00cce9f0 */
                if (iVar4 == 0x15 - *(char *)((long)piVar15 + 0x15)) goto LAB_00ccea60;
              }
LAB_00ccea3c:
              piVar15 = piVar15 + 0xc;
            } while (piVar13 != piVar15);
          }
          puVar9 = PTR_buffer_01719d48;
          uVar3 = uRam0000000000000016;
          if (PTR_buffer_01719d48 == (undefined *)0x0) {
LAB_00ccea7c:
            if (uVar3 != 10) goto LAB_00ccea84;
            this_00 = (vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>> *)(param_1 + 8)
            ;
            plVar11 = *(long **)(param_1 + 0x10);
            if (plVar11 != *(long **)(param_1 + 0x18)) goto LAB_00ccea9c;
LAB_00cceafc:
            std::vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>>::
            _M_emplace_back_aux<cocos2d::NodeData*const&>(this_00,&local_28);
            puVar9 = (undefined *)(local_30 + -0x18);
            if (puVar9 != PTR_DAT_017191c0) {
LAB_00cceb20:
              FUN_00cc93d0(puVar9,auStack_38);
            }
          }
          else {
            *(undefined8 *)PTR_buffer_01719d48 = 0;
            *(undefined8 *)(puVar9 + 8) = 0;
            *(undefined8 *)(puVar9 + 0x10) = 0;
LAB_00ccea84:
            this_00 = (vector<cocos2d::NodeData*,std::allocator<cocos2d::NodeData*>> *)
                      (param_1 + 0x20);
            plVar11 = *(long **)(param_1 + 0x28);
            if (plVar11 == *(long **)(param_1 + 0x30)) goto LAB_00cceafc;
LAB_00ccea9c:
            lVar12 = 0;
            if (plVar11 != (long *)0x0) {
              *plVar11 = (long)pNVar8;
              lVar12 = *(long *)(this_00 + 8);
            }
            *(long *)(this_00 + 8) = lVar12 + 8;
            puVar9 = (undefined *)(local_30 + -0x18);
            if (puVar9 != PTR_DAT_017191c0) goto LAB_00cceb20;
          }
          uVar1 = (int)uVar17 + 1;
          uVar17 = (ulong)uVar1;
        } while (uVar1 < *(uint *)pGVar6);
      }
      uVar7 = 1;
      goto LAB_00cce884;
    }
  }
                    /* try { // try from 00cce880 to 00dce89f has its CatchHandler @ 00cce82c */
  uVar7 = 0;
LAB_00cce884:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar7);
  }
                    /* try { // try from 00cce8a8 to 00dce8ab has its CatchHandler @ 00cce9ac */
  return;
}


/* === loadManifest @ 00de8700 === */

/* cocos2d::extension::Manifest::loadManifest(rapidjson::GenericDocument<rapidjson::UTF8<char>,
   rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>, rapidjson::CrtAllocator> const&) */

void __thiscall cocos2d::extension::Manifest::loadManifest(Manifest *this,GenericDocument *param_1)

{
  uint uVar1;
  Manifest *pMVar2;
  ushort uVar3;
  int iVar4;
  int iVar5;
  GenericValue *pGVar6;
  undefined8 uVar7;
  long lVar8;
  _Hash_node *p_Var9;
  undefined *puVar10;
  long *plVar11;
  long *plVar12;
  long lVar13;
  int *piVar14;
  int *piVar15;
  long *plVar16;
  long *plVar17;
  uint uVar18;
  ulong uVar19;
  ulong uVar20;
  long *plVar21;
  char *pcVar22;
  char *pcVar23;
  ulong uVar24;
  uint *puVar25;
  int *piVar26;
  long *local_60;
  int *local_58;
  undefined1 auStack_50 [8];
  long local_48;
  ulong local_40;
  char *local_38;
  undefined8 local_30;
  undefined *local_28;
  long local_20;
  _Hash_node local_18;
  undefined4 local_14;
  undefined4 local_10;
  long local_8;
  
                    /* try { // try from 00de8704 to 00ee8707 has its CatchHandler @ 00de873c */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8704 with catch @ 00de873c
                        */
  loadVersion(this,param_1);
  pcVar22 = "packageUrl";
  do {
    pcVar23 = pcVar22;
    pcVar22 = pcVar23 + 1;
  } while (*pcVar22 != '\0');
                    /* try { // try from 00de8748 to 00ee874b has its CatchHandler @ 00de84e0 */
  local_60 = (long *)(ulong)*(uint *)param_1;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8794 with catch @ 00de875c
                       catch(type#1 @ 00000000) { ... } // from try @ 00de8948 with catch @ 00de875c
                        */
  pcVar23 = pcVar23 + -0x1345fef;
  local_58 = *(int **)(param_1 + 8);
  iVar4 = (int)pcVar23;
  piVar26 = local_58 + (ulong)*(uint *)param_1 * 0xc;
  if (local_58 != piVar26) {
    piVar15 = local_58;
                    /* try { // try from 00de8794 to 00ee8797 has its CatchHandler @ 00de875c */
                    /* try { // try from 00de87c0 to 00ee8913 has its CatchHandler @ 00de8914 */
    while ((*(ushort *)((long)piVar15 + 0x16) >> 0xc & 1) != 0) {
      piVar14 = piVar15;
      if (iVar4 == 0x15 - *(char *)((long)piVar15 + 0x15)) goto LAB_00de87d4;
LAB_00de87b0:
      piVar15 = piVar15 + 0xc;
      if (piVar26 == piVar15) goto LAB_00de8954;
    }
    if (iVar4 != *piVar15) goto LAB_00de87b0;
    piVar14 = *(int **)(piVar15 + 2);
LAB_00de87d4:
    if (piVar14 == (int *)"packageUrl") {
                    /* try { // try from 00de8948 to 00ee894b has its CatchHandler @ 00de875c */
      if (piVar26 == piVar15) goto LAB_00de8954;
    }
    else {
      iVar5 = memcmp("packageUrl",piVar14,(ulong)pcVar23 & 0xffffffff);
      if (iVar5 != 0) goto LAB_00de87b0;
    }
    pcVar22 = "packageUrl";
    do {
      pcVar23 = pcVar22;
      pcVar22 = pcVar23 + 1;
    } while (*pcVar22 != '\0');
    pcVar23 = pcVar23 + -0x1345fef;
    iVar4 = (int)pcVar23;
    piVar15 = local_58;
    do {
      if ((*(ushort *)((long)piVar15 + 0x16) >> 0xc & 1) == 0) {
        if (iVar4 != *piVar15) goto LAB_00de8828;
        piVar14 = *(int **)(piVar15 + 2);
LAB_00de884c:
        if (piVar14 == (int *)"packageUrl") {
          if (piVar26 != piVar15) goto LAB_00de8864;
          break;
        }
        iVar5 = memcmp("packageUrl",piVar14,(ulong)pcVar23 & 0xffffffff);
        if (iVar5 != 0) goto LAB_00de8828;
LAB_00de8864:
        if ((*(ushort *)((long)piVar15 + 0x2e) & 0x400) != 0) goto LAB_00de8874;
LAB_00de8cb0:
        piVar26 = local_58 + (long)local_60 * 0xc;
        goto LAB_00de8954;
      }
      piVar14 = piVar15;
      if (iVar4 == 0x15 - *(char *)((long)piVar15 + 0x15)) goto LAB_00de884c;
LAB_00de8828:
      piVar15 = piVar15 + 0xc;
    } while (piVar26 != piVar15);
    puVar10 = PTR_buffer_01719d48;
                    /* try { // try from 00de8c94 to 00ee8c97 has its CatchHandler @ 00de8cdc */
    if (PTR_buffer_01719d48 != (undefined *)0x0) {
      *(undefined8 *)PTR_buffer_01719d48 = 0;
      *(undefined8 *)(puVar10 + 8) = 0;
      *(undefined8 *)(puVar10 + 0x10) = 0;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8b90 with catch @ 00de8ca4
                        */
      local_58 = *(int **)(param_1 + 8);
      local_60 = (long *)(ulong)*(uint *)param_1;
      goto LAB_00de8cb0;
    }
    if ((uRam0000000000000016 & 0x400) == 0) goto LAB_00de8cb0;
LAB_00de8874:
    pMVar2 = this + 0x38;
    pcVar22 = "packageUrl";
    do {
      pcVar22 = pcVar22 + 1;
    } while (*pcVar22 != '\0');
    local_30 = 0x405000000000000;
    local_38 = "packageUrl";
    local_40 = (ulong)((int)pcVar22 + 0xfecba010);
    pGVar6 = rapidjson::
             GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
             ::operator[]<rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                       ((GenericValue<rapidjson::UTF8<char>,rapidjson::MemoryPoolAllocator<rapidjson::CrtAllocator>>
                         *)param_1,(GenericValue *)&local_40);
    if ((*(ushort *)(pGVar6 + 0x16) >> 0xc & 1) == 0) {
      pGVar6 = *(GenericValue **)(pGVar6 + 8);
    }
    uVar7 = strlen(pGVar6);
    FUN_01213b44(pMVar2,pGVar6,uVar7);
    lVar13 = *(long *)(this + 0x38);
    lVar8 = *(long *)(lVar13 + -0x18);
    if (lVar8 != 0) {
      if (-1 < *(int *)(lVar13 + -8)) {
        FUN_01213860(pMVar2);
        lVar13 = *(long *)(this + 0x38);
      }
      if (*(char *)(lVar13 + lVar8 + -1) != '/') {
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de87c0 with catch @ 00de8914
                        */
                    /* try { // try from 00de891c to 00ee891f has its CatchHandler @ 00de8920 */
        FUN_0121218c(pMVar2,"/",1);
      }
    }
                    /* catch() { ... } // from try @ 00de891c with catch @ 00de8920 */
    local_58 = *(int **)(param_1 + 8);
    local_60 = (long *)(ulong)*(uint *)param_1;
                    /* try { // try from 00de8938 to 00ee893b has its CatchHandler @ 00de893c */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8938 with catch @ 00de893c
                        */
    piVar26 = local_58 + (ulong)*(uint *)param_1 * 0xc;
  }
LAB_00de8954:
  pcVar22 = "assets";
  do {
    pcVar23 = pcVar22;
    pcVar22 = pcVar23 + 1;
  } while (*pcVar22 != '\0');
  pcVar23 = pcVar23 + -0x1345f8f;
  iVar4 = (int)pcVar23;
  if (piVar26 != local_58) {
    piVar15 = local_58;
    while ((*(ushort *)((long)piVar15 + 0x16) >> 0xc & 1) != 0) {
      piVar14 = piVar15;
      if (iVar4 == 0x15 - *(char *)((long)piVar15 + 0x15)) goto LAB_00de89cc;
LAB_00de89a8:
      piVar15 = piVar15 + 0xc;
      if (piVar26 == piVar15) goto LAB_00de8a80;
    }
    if (iVar4 != *piVar15) goto LAB_00de89a8;
    piVar14 = *(int **)(piVar15 + 2);
LAB_00de89cc:
    if (piVar14 == (int *)"assets") {
      if (piVar26 == piVar15) goto LAB_00de8a80;
    }
    else {
      iVar5 = memcmp("assets",piVar14,(ulong)pcVar23 & 0xffffffff);
      if (iVar5 != 0) goto LAB_00de89a8;
    }
    pcVar22 = "assets";
    do {
      pcVar23 = pcVar22;
      pcVar22 = pcVar23 + 1;
    } while (*pcVar22 != '\0');
    pcVar23 = pcVar23 + -0x1345f8f;
    iVar4 = (int)pcVar23;
    piVar15 = local_58;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8a38 with catch @ 00de8a08
                       catch(type#1 @ 00000000) { ... } // from try @ 00de8cd8 with catch @ 00de8a08
                        */
    while ((*(ushort *)((long)piVar15 + 0x16) >> 0xc & 1) != 0) {
      piVar14 = piVar15;
      if (iVar4 == 0x15 - *(char *)((long)piVar15 + 0x15)) goto LAB_00de8a44;
LAB_00de8a20:
      piVar15 = piVar15 + 0xc;
      if (piVar26 == piVar15) goto LAB_00de8f58;
    }
                    /* try { // try from 00de8a38 to 00ee8a4f has its CatchHandler @ 00de8a08 */
    if (iVar4 != *piVar15) goto LAB_00de8a20;
    piVar14 = *(int **)(piVar15 + 2);
LAB_00de8a44:
    if (piVar14 == (int *)"assets") {
      if (piVar26 != piVar15) goto LAB_00de8a5c;
      goto LAB_00de8f58;
    }
    iVar5 = memcmp("assets",piVar14,(ulong)pcVar23 & 0xffffffff);
    if (iVar5 != 0) goto LAB_00de8a20;
LAB_00de8a5c:
    puVar25 = (uint *)(piVar15 + 6);
    uVar3 = *(ushort *)((long)piVar15 + 0x2e);
LAB_00de8a64:
                    /* try { // try from 00de8cd8 to 00ee8cdb has its CatchHandler @ 00de8a08 */
    if ((uVar3 != 3) || (lVar8 = *(long *)(puVar25 + 2), (ulong)*puVar25 * 0x30 == 0))
    goto LAB_00de8a6c;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8aac with catch @ 00de8cdc
                       catch(type#1 @ 00000000) { ... } // from try @ 00de8bac with catch @ 00de8cdc
                       catch(type#1 @ 00000000) { ... } // from try @ 00de8c3c with catch @ 00de8cdc
                       catch(type#1 @ 00000000) { ... } // from try @ 00de8c94 with catch @ 00de8cdc
                        */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8c7c with catch @ 00de8ce4
                        */
                    /* try { // try from 00de8cf0 to 00ee8cf3 has its CatchHandler @ 00de8cf4 */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8cf0 with catch @ 00de8cf4
                        */
    do {
      while( true ) {
        lVar13 = lVar8;
        if ((*(ushort *)(lVar8 + 0x16) >> 0xc & 1) == 0) {
          lVar13 = *(long *)(lVar8 + 8);
        }
        FUN_01211570((GenericValue *)&local_48,lVar13,&local_28);
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8e50 with catch @ 00de8dc4
                       catch(type#1 @ 00000000) { ... } // from try @ 00de8ec0 with catch @ 00de8dc4
                       catch(type#1 @ 00000000) { ... } // from try @ 00de8ef0 with catch @ 00de8dc4
                       catch(type#1 @ 00000000) { ... } // from try @ 00de8f18 with catch @ 00de8dc4
                        */
        parseAsset((string *)this,(GenericValue *)&local_48);
        p_Var9 = operator_new(0x38);
        *(undefined8 *)p_Var9 = 0;
        FUN_01214ee0((string *)(p_Var9 + 8),(GenericValue *)&local_48);
        FUN_01214ee0(p_Var9 + 0x10,&local_28);
        FUN_01214ee0(p_Var9 + 0x18,&local_20);
        uVar7 = *(undefined8 *)(*(long *)(p_Var9 + 8) + -0x18);
        p_Var9[0x20] = local_18;
        *(undefined4 *)(p_Var9 + 0x28) = local_10;
        *(undefined4 *)(p_Var9 + 0x24) = local_14;
        uVar19 = FUN_011c78ec(*(long *)(p_Var9 + 8),uVar7,0xc70f6907);
        uVar20 = *(ulong *)(this + 0xc0);
                    /* try { // try from 00de8e50 to 00ee8e53 has its CatchHandler @ 00de8dc4 */
        uVar24 = 0;
        if (uVar20 != 0) {
          uVar24 = uVar19 / uVar20;
        }
        uVar24 = uVar19 - uVar24 * uVar20;
        plVar16 = (long *)std::
                          _Hashtable<std::string,std::pair<std::string_const,cocos2d::extension::ManifestAsset>,std::allocator<std::pair<std::string_const,cocos2d::extension::ManifestAsset>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                          ::_M_find_before_node
                                    ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::extension::ManifestAsset>,std::allocator<std::pair<std::string_const,cocos2d::extension::ManifestAsset>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                                      *)(this + 0xb8),uVar24,(string *)(p_Var9 + 8),uVar19);
        if ((plVar16 == (long *)0x0) || (*plVar16 == 0)) break;
        if ((undefined *)(*(long *)(p_Var9 + 0x18) + -0x18) != PTR_DAT_017191c0) {
          FUN_00ddfa84((undefined *)(*(long *)(p_Var9 + 0x18) + -0x18),auStack_50);
        }
        if ((undefined *)(*(long *)(p_Var9 + 0x10) + -0x18) != PTR_DAT_017191c0) {
          FUN_00ddfa84((undefined *)(*(long *)(p_Var9 + 0x10) + -0x18),auStack_50);
        }
        if ((undefined *)(*(long *)(p_Var9 + 8) + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00de8f18 to 00ee8f1b has its CatchHandler @ 00de8dc4 */
          FUN_00ddfa84((undefined *)(*(long *)(p_Var9 + 8) + -0x18),auStack_50);
        }
        operator_delete(p_Var9);
        puVar10 = (undefined *)(local_20 + -0x18);
        if (puVar10 == PTR_DAT_017191c0) goto LAB_00de8d60;
LAB_00de8e90:
        FUN_00ddfa84(puVar10,auStack_50);
        puVar10 = local_28 + -0x18;
        if (puVar10 != PTR_DAT_017191c0) goto LAB_00de8eac;
LAB_00de8d74:
        puVar10 = (undefined *)(local_48 + -0x18);
        if (puVar10 == PTR_DAT_017191c0) goto LAB_00de8d88;
LAB_00de8ec8:
        lVar8 = lVar8 + 0x30;
        FUN_00ddfa84(puVar10,&local_28);
                    /* try { // try from 00de8ed8 to 00ee8edb has its CatchHandler @ 00de8efc */
        if (lVar8 == *(long *)(puVar25 + 2) + (ulong)*puVar25 * 0x30) goto LAB_00de8ef0;
      }
      std::
      _Hashtable<std::string,std::pair<std::string_const,cocos2d::extension::ManifestAsset>,std::allocator<std::pair<std::string_const,cocos2d::extension::ManifestAsset>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
      ::_M_insert_unique_node
                ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::extension::ManifestAsset>,std::allocator<std::pair<std::string_const,cocos2d::extension::ManifestAsset>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                  *)(this + 0xb8),uVar24,uVar19,p_Var9);
      puVar10 = (undefined *)(local_20 + -0x18);
      if (puVar10 != PTR_DAT_017191c0) goto LAB_00de8e90;
LAB_00de8d60:
      puVar10 = local_28 + -0x18;
      if (puVar10 == PTR_DAT_017191c0) goto LAB_00de8d74;
LAB_00de8eac:
      FUN_00ddfa84(puVar10,auStack_50);
      puVar10 = (undefined *)(local_48 + -0x18);
                    /* try { // try from 00de8ec0 to 00ee8ec3 has its CatchHandler @ 00de8dc4 */
      if (puVar10 != PTR_DAT_017191c0) goto LAB_00de8ec8;
LAB_00de8d88:
      lVar8 = lVar8 + 0x30;
    } while (lVar8 != *(long *)(puVar25 + 2) + (ulong)*puVar25 * 0x30);
LAB_00de8ef0:
                    /* try { // try from 00de8ef0 to 00ee8ef3 has its CatchHandler @ 00de8dc4 */
    local_58 = *(int **)(param_1 + 8);
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8ed8 with catch @ 00de8efc
                        */
                    /* try { // try from 00de8f08 to 00ee8f0b has its CatchHandler @ 00de8f0c */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00de8f08 with catch @ 00de8f0c
                        */
    piVar26 = local_58 + (ulong)*(uint *)param_1 * 0xc;
  }
LAB_00de8a80:
  pcVar22 = "searchPaths";
  do {
    pcVar23 = pcVar22;
    pcVar22 = pcVar23 + 1;
  } while (*pcVar22 != '\0');
  pcVar23 = pcVar23 + -0x1345fff;
  iVar4 = (int)pcVar23;
  if (piVar26 == local_58) {
LAB_00de8b94:
    this[0x22] = (Manifest)0x1;
                    /* try { // try from 00de8bac to 00ee8baf has its CatchHandler @ 00de8cdc */
    if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
      return;
    }
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
                    /* try { // try from 00de8aac to 00ee8aaf has its CatchHandler @ 00de8cdc */
  piVar15 = local_58;
LAB_00de8ae0:
  if ((*(ushort *)((long)piVar15 + 0x16) >> 0xc & 1) == 0) {
    if (iVar4 == *piVar15) {
      piVar14 = *(int **)(piVar15 + 2);
LAB_00de8af8:
      if (piVar14 == (int *)"searchPaths") {
        if (piVar26 == piVar15) goto LAB_00de8b94;
      }
      else {
        iVar5 = memcmp("searchPaths",piVar14,(ulong)pcVar23 & 0xffffffff);
        if (iVar5 != 0) goto LAB_00de8ad4;
      }
      pcVar22 = "searchPaths";
      do {
        pcVar23 = pcVar22;
        pcVar22 = pcVar23 + 1;
      } while (*pcVar22 != '\0');
      pcVar23 = pcVar23 + -0x1345fff;
      iVar4 = (int)pcVar23;
      do {
        if ((*(ushort *)((long)local_58 + 0x16) >> 0xc & 1) == 0) {
          if (iVar4 != *local_58) goto LAB_00de8b48;
          piVar15 = *(int **)(local_58 + 2);
LAB_00de8b6c:
          if (piVar15 == (int *)"searchPaths") {
            if (piVar26 != local_58) goto LAB_00de8b84;
            break;
          }
          iVar5 = memcmp("searchPaths",piVar15,(ulong)pcVar23 & 0xffffffff);
          if (iVar5 != 0) goto LAB_00de8b48;
LAB_00de8b84:
          puVar25 = (uint *)(local_58 + 6);
          uVar3 = *(ushort *)((long)local_58 + 0x2e);
          goto LAB_00de8b8c;
        }
        piVar15 = local_58;
        if (iVar4 == 0x15 - *(char *)((long)local_58 + 0x15)) goto LAB_00de8b6c;
LAB_00de8b48:
        local_58 = local_58 + 0xc;
      } while (piVar26 != local_58);
      puVar10 = PTR_buffer_01719d48;
      if (PTR_buffer_01719d48 != (undefined *)0x0) {
        *(undefined8 *)PTR_buffer_01719d48 = 0;
        *(undefined8 *)(puVar10 + 8) = 0;
        *(undefined8 *)(puVar10 + 0x10) = 0;
        goto LAB_00de8b94;
      }
      puVar25 = (uint *)0x0;
      uVar3 = uRam0000000000000016;
LAB_00de8b8c:
                    /* try { // try from 00de8b90 to 00ee8b93 has its CatchHandler @ 00de8ca4 */
      if ((uVar3 != 4) || (uVar18 = *puVar25, uVar18 == 0)) goto LAB_00de8b94;
      uVar24 = 0;
      do {
        lVar8 = *(long *)(puVar25 + 2) + uVar24 * 0x18;
        if ((*(ushort *)(lVar8 + 0x16) >> 10 & 1) != 0) {
          if ((*(ushort *)(lVar8 + 0x16) >> 0xc & 1) == 0) {
            lVar8 = *(long *)(lVar8 + 8);
          }
          FUN_01211570(&local_28,lVar8,auStack_50);
          plVar16 = *(long **)(this + 0xf8);
          if (plVar16 == *(long **)(this + 0x100)) {
            plVar21 = *(long **)(this + 0xf0);
            lVar8 = (long)plVar16 - (long)plVar21;
            uVar19 = lVar8 >> 3;
            if (uVar19 == 0) {
              local_58 = (int *)0x8;
LAB_00de8fc0:
              plVar11 = operator_new((ulong)local_58);
              plVar16 = *(long **)(this + 0xf8);
              plVar21 = *(long **)(this + 0xf0);
              local_60 = plVar11 + 1;
              lVar8 = (long)plVar16 - (long)plVar21;
            }
            else {
              uVar20 = uVar19 * 2;
              local_58 = (int *)0xfffffffffffffff8;
              if (((uVar20 < uVar19) || (0x1fffffffffffffff < uVar20)) ||
                 (local_58 = (int *)(uVar19 << 4), uVar20 != 0)) goto LAB_00de8fc0;
              plVar11 = (long *)0x0;
              local_60 = (long *)&DAT_00000008;
            }
            if ((long)plVar11 + lVar8 != 0) {
              *(undefined **)((long)plVar11 + lVar8) = local_28;
              local_28 = PTR_DAT_017191c0 + 0x18;
            }
            plVar12 = plVar11;
            plVar17 = plVar21;
            if (plVar16 != plVar21) {
              do {
                if (plVar12 != (long *)0x0) {
                  *plVar12 = *plVar17;
                  *plVar17 = (long)(PTR_DAT_017191c0 + 0x18);
                }
                plVar17 = plVar17 + 1;
                plVar12 = plVar12 + 1;
              } while (plVar16 != plVar17);
              local_60 = (long *)((long)plVar11 +
                                 ((long)plVar16 - (long)(plVar21 + 1) & 0xfffffffffffffff8U) + 0x10)
              ;
              plVar17 = plVar21 + 1;
              while( true ) {
                plVar12 = plVar17;
                if ((undefined *)(*plVar21 + -0x18) != PTR_DAT_017191c0) {
                  FUN_00ddfa84((undefined *)(*plVar21 + -0x18),&local_48);
                }
                if (plVar16 == plVar12) break;
                plVar17 = plVar12 + 1;
                plVar21 = plVar12;
              }
              plVar16 = *(long **)(this + 0xf0);
            }
            if (plVar16 != (long *)0x0) {
              operator_delete(plVar16);
            }
            *(long **)(this + 0xf0) = plVar11;
            *(long **)(this + 0xf8) = local_60;
            *(long *)(this + 0x100) = (long)plVar11 + (long)local_58;
          }
          else {
            if (plVar16 != (long *)0x0) {
                    /* try { // try from 00de8c3c to 00ee8c67 has its CatchHandler @ 00de8cdc */
              *plVar16 = (long)local_28;
              local_28 = PTR_DAT_017191c0 + 0x18;
            }
            *(long **)(this + 0xf8) = plVar16 + 1;
          }
          if (local_28 + -0x18 != PTR_DAT_017191c0) {
                    /* try { // try from 00de8c7c to 00ee8c7f has its CatchHandler @ 00de8ce4 */
            FUN_00ddfa84(local_28 + -0x18,&local_48);
          }
          uVar18 = *puVar25;
        }
        uVar1 = (int)uVar24 + 1;
        uVar24 = (ulong)uVar1;
      } while (uVar1 < uVar18);
      goto LAB_00de8b94;
    }
  }
  else {
    piVar14 = piVar15;
    if (iVar4 == 0x15 - *(char *)((long)piVar15 + 0x15)) goto LAB_00de8af8;
  }
LAB_00de8ad4:
  piVar15 = piVar15 + 0xc;
  if (piVar26 == piVar15) goto LAB_00de8b94;
  goto LAB_00de8ae0;
LAB_00de8f58:
  puVar10 = PTR_buffer_01719d48;
  if (PTR_buffer_01719d48 == (undefined *)0x0) {
    puVar25 = (uint *)0x0;
    uVar3 = uRam0000000000000016;
    goto LAB_00de8a64;
  }
  *(undefined8 *)PTR_buffer_01719d48 = 0;
  *(undefined8 *)(puVar10 + 8) = 0;
  *(undefined8 *)(puVar10 + 0x10) = 0;
  local_58 = *(int **)(param_1 + 8);
  local_60 = (long *)(ulong)*(uint *)param_1;
LAB_00de8a6c:
  piVar26 = local_58 + (long)local_60 * 0xc;
  goto LAB_00de8a80;
}


/* === parseVersion @ 00deb6cc === */

/* cocos2d::extension::AssetsManagerEx::parseVersion() */

void __thiscall cocos2d::extension::AssetsManagerEx::parseVersion(AssetsManagerEx *this)

{
  bool bVar1;
  char cVar2;
  undefined *puVar3;
  int iVar4;
  int *piVar5;
  undefined1 auStack_30 [8];
  undefined1 auStack_28 [16];
  long local_18;
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (*(int *)(this + 0x40) != 3) goto LAB_00deb700;
  Manifest::parseVersion(*(Manifest **)(this + 0xa0),(string *)(this + 0x70));
  cVar2 = Manifest::isVersionLoaded(*(Manifest **)(this + 0xa0));
  if (cVar2 == '\0') {
LAB_00deb8a8:
    *(undefined4 *)(this + 0x40) = 4;
    downloadManifest(this);
  }
  else {
    cVar2 = Manifest::versionGreater
                      (*(Manifest **)(this + 0x90),*(Manifest **)(this + 0xa0),this + 0x1a0);
    if (cVar2 == '\0') {
      *(undefined4 *)(this + 0x40) = 7;
      if (this[0xa8] == (AssetsManagerEx)0x2) {
        FUN_01211570(&local_18,&DAT_012fc3d8,auStack_30);
        FUN_01211570(&local_10,&DAT_012fc3d8,auStack_28);
        dispatchUpdateEvent(this,3,&local_18,&local_10,0,0);
        if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar4 = *(int *)(local_10 + -8);
            *(int *)(local_10 + -8) = iVar4 + -1;
          }
          else {
            piVar5 = (int *)(local_10 + -8);
            do {
              iVar4 = *piVar5;
              cVar2 = '\x01';
              bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
              if (bVar1) {
                *piVar5 = iVar4 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar4 < 1) {
            operator_delete((undefined *)(local_10 + -0x18));
          }
        }
        if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar4 = *(int *)(local_18 + -8);
            *(int *)(local_18 + -8) = iVar4 + -1;
          }
          else {
            piVar5 = (int *)(local_18 + -8);
            do {
              iVar4 = *piVar5;
              cVar2 = '\x01';
              bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
              if (bVar1) {
                *piVar5 = iVar4 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar4 < 1) {
            operator_delete((undefined *)(local_18 + -0x18));
          }
        }
        goto LAB_00deb8a8;
      }
      FUN_01211570(&local_18,&DAT_012fc3d8,auStack_30);
      FUN_01211570(&local_10,&DAT_012fc3d8,auStack_28);
      dispatchUpdateEvent(this,3,&local_18,&local_10,0,0);
      if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar4 = *(int *)(local_10 + -8);
          *(int *)(local_10 + -8) = iVar4 + -1;
        }
        else {
          piVar5 = (int *)(local_10 + -8);
          do {
            iVar4 = *piVar5;
            cVar2 = '\x01';
            bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
            if (bVar1) {
              *piVar5 = iVar4 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar4 < 1) {
          operator_delete((undefined *)(local_10 + -0x18));
        }
      }
      puVar3 = (undefined *)(local_18 + -0x18);
      if (puVar3 == PTR_DAT_017191c0) goto LAB_00deb700;
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) goto LAB_00deb9e0;
      piVar5 = (int *)(local_18 + -8);
      do {
        iVar4 = *piVar5;
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar1) {
          *piVar5 = iVar4 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    else {
      *(undefined4 *)(this + 0x40) = 10;
      (**(code **)(**(long **)(this + 0x38) + 0x168))(*(long **)(this + 0x38),this + 0x68);
      FUN_01211570(&local_18,&DAT_012fc3d8,auStack_30);
      FUN_01211570(&local_10,&DAT_012fc3d8,auStack_28);
      dispatchUpdateEvent(this,4,&local_18,&local_10,0,0);
      if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar4 = *(int *)(local_10 + -8);
          *(int *)(local_10 + -8) = iVar4 + -1;
        }
        else {
          piVar5 = (int *)(local_10 + -8);
          do {
            iVar4 = *piVar5;
            cVar2 = '\x01';
            bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
            if (bVar1) {
              *piVar5 = iVar4 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar4 < 1) {
          operator_delete((undefined *)(local_10 + -0x18));
        }
      }
      puVar3 = (undefined *)(local_18 + -0x18);
      if (puVar3 == PTR_DAT_017191c0) goto LAB_00deb700;
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
LAB_00deb9e0:
        iVar4 = *(int *)(local_18 + -8);
        *(int *)(local_18 + -8) = iVar4 + -1;
      }
      else {
        piVar5 = (int *)(local_18 + -8);
        do {
          iVar4 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar4 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
    }
    if (iVar4 < 1) {
      operator_delete(puVar3);
    }
  }
LAB_00deb700:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}


/* === initManifests @ 00dee818 === */

/* cocos2d::extension::AssetsManagerEx::initManifests(std::string const&) */

void cocos2d::extension::AssetsManagerEx::initManifests(string *param_1)

{
  bool bVar1;
  char cVar2;
  Manifest *pMVar3;
  undefined *puVar4;
  Ref *this;
  int *piVar5;
  int iVar6;
  undefined1 auStack_20 [16];
  long local_10;
  long local_8;
  
                    /* try { // try from 00dee820 to 00eee823 has its CatchHandler @ 00def1f4 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  param_1[0x1e0] = (string)0x1;
  FUN_01211570((string *)&local_10,&DAT_012fc3d8,auStack_20);
  pMVar3 = operator_new(0x170,(nothrow_t *)PTR_nothrow_01717628);
  if (pMVar3 == (Manifest *)0x0) {
    *(undefined8 *)(param_1 + 0x90) = 0;
    puVar4 = (undefined *)(local_10 + -0x18);
    if (puVar4 != PTR_DAT_017191c0) goto LAB_00deea44;
LAB_00dee9e4:
    param_1[0x1e0] = (string)0x0;
  }
  else {
    Manifest::Manifest(pMVar3,(string *)&local_10);
    *(Manifest **)(param_1 + 0x90) = pMVar3;
    puVar4 = (undefined *)(local_10 + -0x18);
    if (puVar4 != PTR_DAT_017191c0) {
LAB_00deea44:
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar6 + -1;
      }
      else {
        piVar5 = (int *)(local_10 + -8);
        do {
          iVar6 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete(puVar4);
      }
      if (*(long *)(param_1 + 0x90) == 0) goto LAB_00dee9e4;
    }
    loadLocalManifest(param_1);
    FUN_01211570((string *)&local_10,&DAT_012fc3d8,auStack_20);
    pMVar3 = operator_new(0x170,(nothrow_t *)PTR_nothrow_01717628);
    if (pMVar3 == (Manifest *)0x0) {
      *(undefined8 *)(param_1 + 0x98) = 0;
      puVar4 = (undefined *)(local_10 + -0x18);
      if (puVar4 != PTR_DAT_017191c0) goto LAB_00deeaac;
      param_1[0x1e0] = (string)0x0;
    }
    else {
      Manifest::Manifest(pMVar3,(string *)&local_10);
      *(Manifest **)(param_1 + 0x98) = pMVar3;
      puVar4 = (undefined *)(local_10 + -0x18);
      if (puVar4 != PTR_DAT_017191c0) {
LAB_00deeaac:
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_10 + -8);
          *(int *)(local_10 + -8) = iVar6 + -1;
        }
        else {
          piVar5 = (int *)(local_10 + -8);
          do {
            iVar6 = *piVar5;
            cVar2 = '\x01';
            bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
            if (bVar1) {
              *piVar5 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
          operator_delete(puVar4);
        }
        pMVar3 = *(Manifest **)(param_1 + 0x98);
        if (pMVar3 == (Manifest *)0x0) {
          param_1[0x1e0] = (string)0x0;
          goto LAB_00dee92c;
        }
      }
      Manifest::parse(pMVar3,param_1 + 0x80);
      cVar2 = (**(code **)(**(long **)(param_1 + 0x38) + 0x128))
                        (*(long **)(param_1 + 0x38),param_1 + 0x80);
      if ((cVar2 != '\0') &&
         (cVar2 = Manifest::isLoaded(*(Manifest **)(param_1 + 0x98)), cVar2 == '\0')) {
        (**(code **)(**(long **)(param_1 + 0x38) + 0x168))
                  (*(long **)(param_1 + 0x38),param_1 + 0x68);
        if (*(Ref **)(param_1 + 0x98) != (Ref *)0x0) {
          cocos2d::Ref::release(*(Ref **)(param_1 + 0x98));
        }
        *(undefined8 *)(param_1 + 0x98) = 0;
      }
    }
LAB_00dee92c:
    FUN_01211570((string *)&local_10,&DAT_012fc3d8,auStack_20);
    pMVar3 = operator_new(0x170,(nothrow_t *)PTR_nothrow_01717628);
    if (pMVar3 == (Manifest *)0x0) {
      *(undefined8 *)(param_1 + 0xa0) = 0;
      puVar4 = (undefined *)(local_10 + -0x18);
      if (puVar4 != PTR_DAT_017191c0) goto LAB_00deea78;
LAB_00deea28:
      this = *(Ref **)(param_1 + 0x90);
      param_1[0x1e0] = (string)0x0;
    }
    else {
      Manifest::Manifest(pMVar3,(string *)&local_10);
      *(Manifest **)(param_1 + 0xa0) = pMVar3;
      puVar4 = (undefined *)(local_10 + -0x18);
      if (puVar4 != PTR_DAT_017191c0) {
LAB_00deea78:
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_10 + -8);
          *(int *)(local_10 + -8) = iVar6 + -1;
        }
        else {
          piVar5 = (int *)(local_10 + -8);
          do {
            iVar6 = *piVar5;
            cVar2 = '\x01';
            bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
            if (bVar1) {
              *piVar5 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
          operator_delete(puVar4);
        }
        if (*(long *)(param_1 + 0xa0) == 0) goto LAB_00deea28;
      }
                    /* try { // try from 00dee974 to 00eeea2f has its CatchHandler @ 00def41c */
      if (param_1[0x1e0] != (string)0x0) goto LAB_00dee978;
      this = *(Ref **)(param_1 + 0x90);
    }
    if (this != (Ref *)0x0) {
      cocos2d::Ref::release(this);
    }
  }
  if (*(Ref **)(param_1 + 0x98) != (Ref *)0x0) {
    cocos2d::Ref::release(*(Ref **)(param_1 + 0x98));
  }
  if (*(Ref **)(param_1 + 0xa0) != (Ref *)0x0) {
    cocos2d::Ref::release(*(Ref **)(param_1 + 0xa0));
  }
  *(undefined8 *)(param_1 + 0x90) = 0;
  *(undefined8 *)(param_1 + 0x98) = 0;
  *(undefined8 *)(param_1 + 0xa0) = 0;
LAB_00dee978:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}


/* === Manifest @ 00de9704 === */

/* cocos2d::extension::Manifest::Manifest(std::string const&) */

void __thiscall cocos2d::extension::Manifest::Manifest(Manifest *this,string *param_1)

{
  undefined *puVar1;
  long lVar2;
  Manifest *pMVar3;
  ulong uVar4;
  undefined8 *puVar5;
  undefined8 uVar6;
  undefined1 auStack_10 [8];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  cocos2d::Ref::Ref((Ref *)this);
  puVar1 = PTR_vtable_0171fad0;
  this[0x21] = (Manifest)0x0;
  this[0x22] = (Manifest)0x0;
  *(undefined **)this = puVar1 + 0x10;
  FUN_01211570(this + 0x30,&DAT_012fc3d8,auStack_10);
  *(undefined **)(this + 0x38) = PTR_DAT_017191c0 + 0x18;
  FUN_01211570(this + 0x40,&DAT_012fc3d8,auStack_10);
  FUN_01211570(this + 0x48,&DAT_012fc3d8,auStack_10);
  FUN_01211570(this + 0x50,&DAT_012fc3d8,auStack_10);
  *(undefined8 *)(this + 0x60) = 0;
  *(undefined8 *)(this + 0x68) = 0;
  *(undefined8 *)(this + 0x70) = 0;
  *(undefined8 *)(this + 0x88) = 0;
  *(undefined8 *)(this + 0x90) = 0;
  *(undefined8 *)(this + 0xa0) = 0;
  *(undefined4 *)(this + 0x98) = 0x3f800000;
  lVar2 = FUN_0120ff88(this + 0x98,10);
  *(long *)(this + 0x80) = lVar2;
  if (lVar2 == 1) {
    *(undefined8 *)(this + 0xa8) = 0;
    pMVar3 = this + 0xa8;
  }
  else {
    pMVar3 = (Manifest *)FUN_00ddfb90();
  }
  *(Manifest **)(this + 0x78) = pMVar3;
  FUN_01211570(this + 0xb0,&DAT_012fc3d8,auStack_10);
  *(undefined8 *)(this + 200) = 0;
  *(undefined8 *)(this + 0xd0) = 0;
  *(undefined8 *)(this + 0xe0) = 0;
  *(undefined4 *)(this + 0xd8) = 0x3f800000;
  uVar4 = FUN_0120ff88(this + 0xd8,10);
  *(ulong *)(this + 0xc0) = uVar4;
  if (uVar4 == 1) {
    *(undefined8 *)(this + 0xe8) = 0;
    pMVar3 = this + 0xe8;
  }
  else {
    if (0x1fffffffffffffff < uVar4) {
                    /* WARNING: Subroutine does not return */
      FUN_0120f0e8();
    }
    pMVar3 = operator_new(uVar4 << 3);
    memset(pMVar3,0,uVar4 << 3);
  }
  *(Manifest **)(this + 0xb8) = pMVar3;
  *(undefined8 *)(this + 0xf0) = 0;
  *(undefined8 *)(this + 0xf8) = 0;
  *(undefined8 *)(this + 0x100) = 0;
  *(undefined8 *)(this + 0x108) = 0;
  *(undefined8 *)(this + 0x110) = 0;
  *(undefined8 *)(this + 0x118) = 0;
  *(undefined8 *)(this + 0x120) = 0;
  *(undefined8 *)(this + 0x128) = 0;
  *(undefined8 *)(this + 0x130) = 0;
  *(undefined8 *)(this + 0x138) = 0;
  *(undefined8 *)(this + 0x140) = 0;
  *(undefined8 *)(this + 0x148) = 0;
  *(undefined8 *)(this + 0x150) = 0;
  *(undefined8 *)(this + 0x158) = 0x400;
  *(undefined4 *)(this + 0x160) = 0;
  *(undefined8 *)(this + 0x168) = 0;
  puVar5 = operator_new(0x28);
  *puVar5 = 0;
  puVar5[2] = 0;
  puVar5[1] = 0x10000;
  puVar5[3] = 0;
  puVar5[4] = 0;
  *(undefined8 **)(this + 0x120) = puVar5;
  *(undefined8 **)(this + 0x128) = puVar5;
  uVar6 = FileUtils::getInstance();
  lVar2 = *(long *)param_1;
  *(undefined8 *)(this + 0x28) = uVar6;
  if (*(long *)(lVar2 + -0x18) != 0) {
    parse(this,param_1);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === loadLocalManifest @ 00dedd04 === */

/* cocos2d::extension::AssetsManagerEx::loadLocalManifest(std::string const&) */

void cocos2d::extension::AssetsManagerEx::loadLocalManifest(string *param_1)

{
  string *psVar1;
  bool bVar2;
  long *plVar3;
  char cVar4;
  Manifest *this;
  long *plVar5;
  long *plVar6;
  int *piVar7;
  int iVar8;
  ulong uVar9;
  long lVar10;
  long lVar11;
  long *plVar12;
  long *plVar13;
  Manifest *this_00;
  undefined1 auStack_68 [8];
  long local_60;
  long local_58;
  long *local_50;
  long *local_48;
  long local_40;
  long *local_38;
  long *local_30;
  long *local_20;
  long *local_18;
  long local_10;
  long local_8;
  
  psVar1 = param_1 + 0x78;
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  cVar4 = (**(code **)(**(long **)(param_1 + 0x38) + 0x128))(*(long **)(param_1 + 0x38),psVar1);
  if (cVar4 != '\0') {
    FUN_01211570((string *)&local_20,&DAT_012fc3d8,&local_50);
    this = operator_new(0x170,(nothrow_t *)PTR_nothrow_01717628);
    if (this != (Manifest *)0x0) {
      Manifest::Manifest(this,(string *)&local_20);
    }
    if (local_20 + -3 != (long *)PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar8 = (int)local_20[-1];
        *(int *)(local_20 + -1) = iVar8 + -1;
      }
      else {
        plVar5 = local_20 + -1;
        do {
          iVar8 = (int)*plVar5;
          cVar4 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(plVar5,0x10);
          if (bVar2) {
            *(int *)plVar5 = iVar8 + -1;
            cVar4 = ExclusiveMonitorsStatus();
          }
        } while (cVar4 != '\0');
      }
      if (iVar8 < 1) {
        operator_delete(local_20 + -3);
      }
    }
    if (this != (Manifest *)0x0) {
      Manifest::parse(this,psVar1);
      cVar4 = Manifest::isLoaded(this);
      this_00 = this;
      if (cVar4 == '\0') {
        (**(code **)(**(long **)(param_1 + 0x38) + 0x178))(*(long **)(param_1 + 0x38),psVar1);
        this_00 = (Manifest *)0x0;
        cocos2d::Ref::release((Ref *)this);
      }
      goto LAB_00deddf4;
    }
  }
  this_00 = (Manifest *)0x0;
LAB_00deddf4:
  plVar5 = (long *)(**(code **)(**(long **)(param_1 + 0x38) + 0x90))(*(long **)(param_1 + 0x38));
  local_50 = (long *)0x0;
  uVar9 = plVar5[1] - *plVar5;
  local_48 = (long *)0x0;
  local_40 = 0;
  if ((long)uVar9 >> 3 == 0) {
    plVar13 = (long *)0x0;
  }
  else {
    if (0x1fffffffffffffff < (ulong)((long)uVar9 >> 3)) {
                    /* WARNING: Subroutine does not return */
      FUN_0120f0e8();
    }
    plVar13 = operator_new(uVar9);
  }
  local_40 = (long)plVar13 + uVar9;
  lVar11 = plVar5[1];
  local_50 = plVar13;
  local_48 = plVar13;
  for (lVar10 = *plVar5; lVar10 != lVar11; lVar10 = lVar10 + 8) {
    if (plVar13 != (long *)0x0) {
      FUN_01214ee0(plVar13,lVar10);
    }
    plVar13 = plVar13 + 1;
  }
  local_48 = plVar13;
  if (this_00 != (Manifest *)0x0) {
    Manifest::getSearchPaths();
                    /* try { // try from 00dede90 to 00eede93 has its CatchHandler @ 00def4ec */
    local_20 = (long *)0x0;
    uVar9 = (long)local_48 - (long)local_50;
    local_18 = (long *)0x0;
    local_10 = 0;
    if ((long)uVar9 >> 3 == 0) {
      plVar5 = (long *)0x0;
    }
    else {
      if (0x1fffffffffffffff < (ulong)((long)uVar9 >> 3)) {
                    /* WARNING: Subroutine does not return */
        FUN_0120f0e8();
      }
      plVar5 = operator_new(uVar9);
    }
    plVar6 = local_48;
    local_10 = (long)plVar5 + uVar9;
    local_20 = plVar5;
    local_18 = plVar5;
    plVar12 = local_38;
    plVar3 = local_30;
    for (plVar13 = local_50; local_38 = plVar12, local_30 = plVar3, plVar13 != plVar6;
        plVar13 = plVar13 + 1) {
      if (plVar5 != (long *)0x0) {
        FUN_01214ee0(plVar5,plVar13);
      }
      plVar5 = plVar5 + 1;
      plVar12 = local_38;
      plVar3 = local_30;
    }
                    /* try { // try from 00dedeec to 00eedeef has its CatchHandler @ 00def41c */
    local_18 = plVar5;
    if (plVar12 != plVar3) {
      do {
        FUN_01214ee0(&local_58,plVar12);
        plVar5 = (long *)std::
                         __find_if<__gnu_cxx::__normal_iterator<std::string*,std::vector<std::string,std::allocator<std::string>>>,__gnu_cxx::__ops::_Iter_equals_val<std::string_const>>
                                   (local_20,local_18,&local_58,0);
        if (local_18 != plVar5) {
          plVar13 = plVar5 + 1;
          if ((local_18 != plVar13) && (lVar10 = (long)local_18 - (long)plVar13, 7 < lVar10)) {
                    /* try { // try from 00dedf58 to 00eedf5b has its CatchHandler @ 00def3d4 */
            plVar6 = plVar5;
            for (; FUN_0121258c(plVar6,plVar13), plVar13 != (long *)((long)plVar5 + lVar10);
                plVar13 = plVar13 + 1) {
              plVar6 = plVar13;
            }
          }
          plVar5 = local_18 + -1;
          lVar10 = local_18[-1];
          local_18 = plVar5;
          if ((undefined *)(lVar10 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 00dee300 to 00eee303 has its CatchHandler @ 00def424 */
              iVar8 = *(int *)(lVar10 + -8);
              *(int *)(lVar10 + -8) = iVar8 + -1;
            }
            else {
              piVar7 = (int *)(lVar10 + -8);
              do {
                iVar8 = *piVar7;
                cVar4 = '\x01';
                bVar2 = (bool)ExclusiveMonitorPass(piVar7,0x10);
                if (bVar2) {
                  *piVar7 = iVar8 + -1;
                  cVar4 = ExclusiveMonitorsStatus();
                }
              } while (cVar4 != '\0');
            }
            if (iVar8 < 1) {
              operator_delete((undefined *)(lVar10 + -0x18));
            }
          }
        }
                    /* try { // try from 00dedfac to 00eedfaf has its CatchHandler @ 00def41c */
        if ((undefined *)(local_58 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar8 = *(int *)(local_58 + -8);
            *(int *)(local_58 + -8) = iVar8 + -1;
          }
          else {
            piVar7 = (int *)(local_58 + -8);
            do {
              iVar8 = *piVar7;
              cVar4 = '\x01';
              bVar2 = (bool)ExclusiveMonitorPass(piVar7,0x10);
              if (bVar2) {
                *piVar7 = iVar8 + -1;
                cVar4 = ExclusiveMonitorsStatus();
              }
            } while (cVar4 != '\0');
          }
          if (iVar8 < 1) {
            operator_delete((undefined *)(local_58 + -0x18));
          }
        }
        plVar12 = plVar12 + 1;
      } while (plVar3 != plVar12);
    }
    (**(code **)(**(long **)(param_1 + 0x38) + 0x88))(*(long **)(param_1 + 0x38),&local_20);
    plVar12 = local_18;
    plVar5 = local_20;
    plVar13 = local_18;
joined_r0x00dedfe8:
    if (plVar5 != plVar12) {
      do {
        lVar10 = *plVar5;
        if ((undefined *)(lVar10 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 00dee370 to 00eee373 has its CatchHandler @ 00def3cc */
            iVar8 = *(int *)(lVar10 + -8);
            *(int *)(lVar10 + -8) = iVar8 + -1;
          }
          else {
            piVar7 = (int *)(lVar10 + -8);
            do {
              iVar8 = *piVar7;
              cVar4 = '\x01';
              bVar2 = (bool)ExclusiveMonitorPass(piVar7,0x10);
              if (bVar2) {
                *piVar7 = iVar8 + -1;
                cVar4 = ExclusiveMonitorsStatus();
              }
            } while (cVar4 != '\0');
          }
          if (iVar8 < 1) goto code_r0x00dee040;
        }
        plVar5 = plVar5 + 1;
        plVar13 = local_20;
        if (plVar12 == plVar5) break;
      } while( true );
    }
    plVar5 = local_38;
    plVar12 = local_30;
    if (plVar13 != (long *)0x0) {
      operator_delete(plVar13);
      plVar5 = local_38;
      plVar12 = local_30;
    }
joined_r0x00dee070:
    if (plVar5 != local_30) {
      do {
        lVar10 = *plVar5;
        if ((undefined *)(lVar10 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar8 = *(int *)(lVar10 + -8);
            *(int *)(lVar10 + -8) = iVar8 + -1;
          }
          else {
            piVar7 = (int *)(lVar10 + -8);
            do {
              iVar8 = *piVar7;
              cVar4 = '\x01';
              bVar2 = (bool)ExclusiveMonitorPass(piVar7,0x10);
              if (bVar2) {
                *piVar7 = iVar8 + -1;
                cVar4 = ExclusiveMonitorsStatus();
              }
            } while (cVar4 != '\0');
          }
          if (iVar8 < 1) goto code_r0x00dee0c4;
        }
        plVar5 = plVar5 + 1;
        plVar12 = local_38;
        if (local_30 == plVar5) break;
      } while( true );
    }
    if (plVar12 != (long *)0x0) {
      operator_delete(plVar12);
    }
  }
  Manifest::parse(*(Manifest **)(param_1 + 0x90),param_1 + 0x88);
  if (this_00 != (Manifest *)0x0) {
    (**(code **)(**(long **)(param_1 + 0x38) + 0x88))(*(long **)(param_1 + 0x38),&local_50);
  }
  cVar4 = Manifest::isLoaded(*(Manifest **)(param_1 + 0x90));
  if (cVar4 != '\0') {
    if (this_00 != (Manifest *)0x0) {
      cVar4 = Manifest::versionGreater(*(Manifest **)(param_1 + 0x90),this_00,param_1 + 0x1a0);
      if (cVar4 != '\0') {
        (**(code **)(**(long **)(param_1 + 0x38) + 0x168))
                  (*(long **)(param_1 + 0x38),param_1 + 0x60);
        (**(code **)(**(long **)(param_1 + 0x38) + 0x158))
                  (*(long **)(param_1 + 0x38),param_1 + 0x60);
        cocos2d::Ref::release((Ref *)this_00);
        FUN_01211570(&local_60,&DAT_012fc3d8,auStack_68);
        FUN_01211570(&local_58,&DAT_012fc3d8,&local_38);
        dispatchUpdateEvent((AssetsManagerEx *)param_1,8,&local_60,&local_58,0,0);
        if ((undefined *)(local_58 + -0x18) != PTR_DAT_017191c0) {
          piVar7 = (int *)(local_58 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar8 = *(int *)(local_58 + -8);
            *(int *)(local_58 + -8) = iVar8 + -1;
          }
          else {
            do {
              iVar8 = *piVar7;
              cVar4 = '\x01';
              bVar2 = (bool)ExclusiveMonitorPass(piVar7,0x10);
              if (bVar2) {
                *piVar7 = iVar8 + -1;
                cVar4 = ExclusiveMonitorsStatus();
              }
            } while (cVar4 != '\0');
          }
          if (iVar8 < 1) {
            operator_delete((undefined *)(local_58 + -0x18));
                    /* try { // try from 00dee5e0 to 00eee5e3 has its CatchHandler @ 00def41c */
          }
        }
        plVar5 = local_50;
        plVar13 = local_48;
        plVar12 = local_48;
        if ((undefined *)(local_60 + -0x18) != PTR_DAT_017191c0) {
          piVar7 = (int *)(local_60 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar8 = *(int *)(local_60 + -8);
            *(int *)(local_60 + -8) = iVar8 + -1;
          }
          else {
            do {
                    /* try { // try from 00dee58c to 00eee58f has its CatchHandler @ 00def42c */
              iVar8 = *piVar7;
              cVar4 = '\x01';
              bVar2 = (bool)ExclusiveMonitorPass(piVar7,0x10);
              if (bVar2) {
                *piVar7 = iVar8 + -1;
                cVar4 = ExclusiveMonitorsStatus();
              }
            } while (cVar4 != '\0');
          }
          if (iVar8 < 1) {
            operator_delete((undefined *)(local_60 + -0x18));
            plVar5 = local_50;
            plVar13 = local_48;
            plVar12 = local_48;
          }
        }
        for (; plVar3 = local_48, local_48 != plVar5; plVar5 = plVar5 + 1) {
          lVar10 = *plVar5;
                    /* try { // try from 00dee464 to 00eee467 has its CatchHandler @ 00def3a0 */
          local_48 = plVar12;
          if ((undefined *)(lVar10 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar8 = *(int *)(lVar10 + -8);
              *(int *)(lVar10 + -8) = iVar8 + -1;
            }
            else {
              piVar7 = (int *)(lVar10 + -8);
              do {
                iVar8 = *piVar7;
                cVar4 = '\x01';
                bVar2 = (bool)ExclusiveMonitorPass(piVar7,0x10);
                if (bVar2) {
                  *piVar7 = iVar8 + -1;
                  cVar4 = ExclusiveMonitorsStatus();
                }
              } while (cVar4 != '\0');
            }
            if (iVar8 < 1) {
              operator_delete((undefined *)(lVar10 + -0x18));
            }
          }
          plVar13 = local_50;
          plVar12 = local_48;
          local_48 = plVar3;
        }
LAB_00dee254:
        local_48 = plVar12;
        if (plVar13 != (long *)0x0) {
                    /* try { // try from 00dee258 to 00eee25b has its CatchHandler @ 00def3a0 */
          operator_delete(plVar13);
        }
        if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
          __stack_chk_fail();
        }
        return;
      }
      if (*(Ref **)(param_1 + 0x90) != (Ref *)0x0) {
        cocos2d::Ref::release(*(Ref **)(param_1 + 0x90));
      }
      *(Manifest **)(param_1 + 0x90) = this_00;
    }
    prepareLocalManifest((AssetsManagerEx *)param_1);
  }
  cVar4 = Manifest::isLoaded(*(Manifest **)(param_1 + 0x90));
  plVar5 = local_50;
  plVar13 = local_48;
  plVar12 = local_48;
  if (cVar4 == '\0') {
    FUN_01211570(&local_38,&DAT_012fc3d8,auStack_68);
    FUN_01211570(&local_20,&DAT_012fc3d8,&local_60);
    dispatchUpdateEvent((AssetsManagerEx *)param_1,0,&local_38,&local_20,0,0);
    if (local_20 + -3 != (long *)PTR_DAT_017191c0) {
      plVar5 = local_20 + -1;
                    /* try { // try from 00dee520 to 00eee523 has its CatchHandler @ 00def41c */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar8 = (int)local_20[-1];
        *(int *)(local_20 + -1) = iVar8 + -1;
      }
      else {
        do {
          iVar8 = (int)*plVar5;
          cVar4 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(plVar5,0x10);
          if (bVar2) {
            *(int *)plVar5 = iVar8 + -1;
            cVar4 = ExclusiveMonitorsStatus();
          }
        } while (cVar4 != '\0');
      }
      if (iVar8 < 1) {
        operator_delete(local_20 + -3);
      }
    }
    plVar5 = local_50;
    plVar13 = local_48;
    plVar12 = local_48;
    if (local_38 + -3 != (long *)PTR_DAT_017191c0) {
      plVar3 = local_38 + -1;
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar8 = (int)local_38[-1];
        *(int *)(local_38 + -1) = iVar8 + -1;
      }
      else {
        do {
          iVar8 = (int)*plVar3;
          cVar4 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(plVar3,0x10);
          if (bVar2) {
            *(int *)plVar3 = iVar8 + -1;
            cVar4 = ExclusiveMonitorsStatus();
          }
        } while (cVar4 != '\0');
      }
      if (iVar8 < 1) {
        operator_delete(local_38 + -3);
        plVar5 = local_50;
        plVar13 = local_48;
        plVar12 = local_48;
      }
    }
  }
joined_r0x00dee1e4:
  plVar3 = local_48;
  if (local_48 != plVar5) {
    do {
      lVar10 = *plVar5;
      if ((undefined *)(lVar10 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00dee21c to 00eee21f has its CatchHandler @ 00def324 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar8 = *(int *)(lVar10 + -8);
          *(int *)(lVar10 + -8) = iVar8 + -1;
        }
        else {
          piVar7 = (int *)(lVar10 + -8);
          do {
            iVar8 = *piVar7;
            cVar4 = '\x01';
            bVar2 = (bool)ExclusiveMonitorPass(piVar7,0x10);
            if (bVar2) {
              *piVar7 = iVar8 + -1;
              cVar4 = ExclusiveMonitorsStatus();
            }
          } while (cVar4 != '\0');
        }
        if (iVar8 < 1) goto code_r0x00dee23c;
      }
      plVar5 = plVar5 + 1;
      plVar13 = local_50;
      if (local_48 == plVar5) break;
    } while( true );
  }
  goto LAB_00dee254;
code_r0x00dee040:
  plVar5 = plVar5 + 1;
  operator_delete((undefined *)(lVar10 + -0x18));
  plVar13 = local_20;
  goto joined_r0x00dedfe8;
code_r0x00dee0c4:
  operator_delete((undefined *)(lVar10 + -0x18));
  plVar5 = plVar5 + 1;
  plVar12 = local_38;
  goto joined_r0x00dee070;
code_r0x00dee23c:
  local_48 = plVar12;
  operator_delete((undefined *)(lVar10 + -0x18));
  plVar5 = plVar5 + 1;
  plVar13 = local_50;
  plVar12 = local_48;
  local_48 = plVar3;
  goto joined_r0x00dee1e4;
}


/* === parseManifest @ 00df1e00 === */

/* cocos2d::extension::AssetsManagerEx::parseManifest() */

void __thiscall cocos2d::extension::AssetsManagerEx::parseManifest(AssetsManagerEx *this)

{
  bool bVar1;
  char cVar2;
  undefined *puVar3;
  int iVar4;
  int *piVar5;
  float fVar6;
  undefined1 auStack_30 [8];
  undefined1 auStack_28 [16];
  long local_18;
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (*(int *)(this + 0x40) != 6) goto LAB_00df1e34;
  Manifest::parse(*(Manifest **)(this + 0xa0),(string *)(this + 0x80));
  cVar2 = Manifest::isLoaded(*(Manifest **)(this + 0xa0));
  if (cVar2 == '\0') {
    FUN_01211570(&local_18,&DAT_012fc3d8,auStack_30);
    FUN_01211570(&local_10,&DAT_012fc3d8,auStack_28);
    dispatchUpdateEvent(this,2,&local_18,&local_10,0,0);
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar4 + -1;
      }
      else {
        piVar5 = (int *)(local_10 + -8);
        do {
          iVar4 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar4 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
    if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_18 + -8);
        *(int *)(local_18 + -8) = iVar4 + -1;
      }
      else {
        piVar5 = (int *)(local_18 + -8);
        do {
          iVar4 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar4 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete((undefined *)(local_18 + -0x18));
        *(undefined4 *)(this + 0x40) = 0;
        goto LAB_00df1e34;
      }
    }
    *(undefined4 *)(this + 0x40) = 0;
    goto LAB_00df1e34;
  }
  cVar2 = Manifest::versionGreater
                    (*(Manifest **)(this + 0x90),*(Manifest **)(this + 0xa0),this + 0x1a0);
  if (cVar2 == '\0') {
    fVar6 = (float)Manifest::genDiffSize(*(Manifest **)(this + 0x90));
    StringUtils::format("%f",&local_18,(double)fVar6);
    *(undefined4 *)(this + 0x40) = 7;
    FUN_01211570(&local_10,&DAT_012fc3d8,auStack_28);
    dispatchUpdateEvent(this,3,&local_10,&local_18,0,0);
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar4 + -1;
      }
      else {
        piVar5 = (int *)(local_10 + -8);
        do {
          iVar4 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar4 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
    if (this[0xa8] == (AssetsManagerEx)0x2) {
      startUpdate(this);
    }
    puVar3 = (undefined *)(local_18 + -0x18);
    if (puVar3 == PTR_DAT_017191c0) goto LAB_00df1e34;
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
LAB_00df2178:
      iVar4 = *(int *)(local_18 + -8);
      *(int *)(local_18 + -8) = iVar4 + -1;
    }
    else {
      piVar5 = (int *)(local_18 + -8);
      do {
        iVar4 = *piVar5;
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar1) {
          *piVar5 = iVar4 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
  }
  else {
    *(undefined4 *)(this + 0x40) = 10;
    (**(code **)(**(long **)(this + 0x38) + 0x168))(*(long **)(this + 0x38),this + 0x68);
    FUN_01211570(&local_18,&DAT_012fc3d8,auStack_30);
    FUN_01211570(&local_10,&DAT_012fc3d8,auStack_28);
    dispatchUpdateEvent(this,4,&local_18,&local_10,0,0);
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar4 + -1;
      }
      else {
        piVar5 = (int *)(local_10 + -8);
        do {
          iVar4 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar4 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
    puVar3 = (undefined *)(local_18 + -0x18);
    if (puVar3 == PTR_DAT_017191c0) goto LAB_00df1e34;
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) goto LAB_00df2178;
    piVar5 = (int *)(local_18 + -8);
    do {
      iVar4 = *piVar5;
      cVar2 = '\x01';
      bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
      if (bVar1) {
        *piVar5 = iVar4 + -1;
        cVar2 = ExclusiveMonitorsStatus();
      }
    } while (cVar2 != '\0');
  }
  if (iVar4 < 1) {
    operator_delete(puVar3);
  }
LAB_00df1e34:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}


/* === onSuccess @ 00df2234 === */

/* cocos2d::extension::AssetsManagerEx::onSuccess(std::string const&, std::string const&,
   std::string const&) */

void __thiscall
cocos2d::extension::AssetsManagerEx::onSuccess
          (AssetsManagerEx *this,string *param_1,string *param_2,string *param_3)

{
  ulong uVar1;
  char cVar2;
  bool bVar3;
  undefined *puVar4;
  char cVar5;
  int iVar6;
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::extension::ManifestAsset>,std::allocator<std::pair<std::string_const,cocos2d::extension::ManifestAsset>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  *this_00;
  ulong uVar7;
  int *piVar8;
  long lVar9;
  ulong uVar10;
  long lVar11;
  long local_68;
  long local_60;
  undefined1 local_58;
  uint local_54;
  undefined4 local_50;
  undefined *local_48;
  undefined *local_40;
  undefined1 local_38;
  uint local_34;
  undefined4 local_30;
  undefined *local_28;
  undefined *local_20;
  undefined1 local_18;
  uint local_14;
  undefined4 local_10;
  long local_8;
  
  lVar11 = *(long *)param_3;
  lVar9 = *(long *)(lVar11 + -0x18);
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if ((lVar9 == *(long *)(*(long *)PTR_VERSION_ID_01715870 + -0x18)) &&
     (iVar6 = memcmp(lVar11,*(long *)PTR_VERSION_ID_01715870,lVar9), iVar6 == 0)) {
    *(undefined4 *)(this + 0x40) = 3;
    parseVersion(this);
  }
  else if ((lVar9 == *(long *)(*(long *)PTR_MANIFEST_ID_01721b50 + -0x18)) &&
          (iVar6 = memcmp(lVar11,*(long *)PTR_MANIFEST_ID_01721b50,lVar9), iVar6 == 0)) {
    *(undefined4 *)(this + 0x40) = 6;
    parseManifest(this);
  }
  else {
    this_00 = (_Hashtable<std::string,std::pair<std::string_const,cocos2d::extension::ManifestAsset>,std::allocator<std::pair<std::string_const,cocos2d::extension::ManifestAsset>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
               *)Manifest::getAssets(*(Manifest **)(this + 0xa0));
    lVar9 = std::
            _Hashtable<std::string,std::pair<std::string_const,cocos2d::extension::ManifestAsset>,std::allocator<std::pair<std::string_const,cocos2d::extension::ManifestAsset>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
            ::find(this_00,param_3);
    if (lVar9 != 0) {
      FUN_01214ee0(&local_68,lVar9 + 0x10);
      FUN_01214ee0(&local_60,lVar9 + 0x18);
      local_54 = *(uint *)(lVar9 + 0x24);
      local_58 = *(undefined1 *)(lVar9 + 0x20);
      local_50 = *(undefined4 *)(lVar9 + 0x28);
      if (*(long *)(this + 0x1d0) == 0) {
        utils::getFileMD5Hash((utils *)param_2,(string *)(ulong)local_54);
        puVar4 = local_28;
        cVar5 = false;
        uVar7 = *(ulong *)(local_68 + -0x18);
        uVar10 = *(ulong *)(local_28 + -0x18);
        uVar1 = uVar7;
        if (uVar10 < uVar7) {
          uVar1 = uVar10;
        }
        iVar6 = memcmp(local_28,local_68,uVar1);
        if (((iVar6 == 0) && (lVar11 = uVar10 - uVar7, lVar11 < 0x80000000)) &&
           (-0x80000001 < lVar11)) {
          cVar5 = (int)lVar11 == 0;
        }
        if (puVar4 + -0x18 != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(puVar4 + -8);
            *(int *)(puVar4 + -8) = iVar6 + -1;
          }
          else {
            piVar8 = (int *)(puVar4 + -8);
            do {
              iVar6 = *piVar8;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar8,0x10);
              if (bVar3) {
                *piVar8 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete(puVar4 + -0x18);
          }
        }
      }
      else {
        FUN_01214ee0(&local_48,&local_68);
        FUN_01214ee0(&local_40,&local_60);
        local_38 = local_58;
        local_30 = local_50;
        local_34 = local_54;
        if (*(long *)(this + 0x1d0) == 0) {
                    /* WARNING: Subroutine does not return */
          FUN_0120fb70();
        }
        local_28 = local_48;
        local_48 = PTR_DAT_017191c0 + 0x18;
        local_20 = local_40;
        local_18 = local_58;
        local_10 = local_50;
        local_14 = local_54;
        local_40 = local_48;
        cVar5 = (**(code **)(this + 0x1d8))(this + 0x1c0,param_2,&local_28);
        if (local_20 + -0x18 != PTR_DAT_017191c0) {
                    /* try { // try from 00df2644 to 00ef2647 has its CatchHandler @ 00df36bc */
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_20 + -8);
            *(int *)(local_20 + -8) = iVar6 + -1;
          }
          else {
            piVar8 = (int *)(local_20 + -8);
            do {
              iVar6 = *piVar8;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar8,0x10);
              if (bVar3) {
                *piVar8 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete(local_20 + -0x18);
          }
        }
        if (local_28 + -0x18 != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_28 + -8);
            *(int *)(local_28 + -8) = iVar6 + -1;
          }
          else {
            piVar8 = (int *)(local_28 + -8);
            do {
              iVar6 = *piVar8;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar8,0x10);
              if (bVar3) {
                *piVar8 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete(local_28 + -0x18);
          }
        }
        if (local_40 + -0x18 != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_40 + -8);
            *(int *)(local_40 + -8) = iVar6 + -1;
          }
          else {
            piVar8 = (int *)(local_40 + -8);
            do {
              iVar6 = *piVar8;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar8,0x10);
              if (bVar3) {
                *piVar8 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete(local_40 + -0x18);
          }
        }
        if (local_48 + -0x18 != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_48 + -8);
            *(int *)(local_48 + -8) = iVar6 + -1;
          }
          else {
            piVar8 = (int *)(local_48 + -8);
            do {
              iVar6 = *piVar8;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar8,0x10);
              if (bVar3) {
                *piVar8 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete(local_48 + -0x18);
          }
        }
      }
      if ((undefined *)(local_60 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_60 + -8);
          *(int *)(local_60 + -8) = iVar6 + -1;
        }
        else {
          piVar8 = (int *)(local_60 + -8);
          do {
            iVar6 = *piVar8;
                    /* try { // try from 00df261c to 00ef261f has its CatchHandler @ 00df37ac */
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar8,0x10);
            if (bVar3) {
              *piVar8 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
                    /* try { // try from 00df2628 to 00ef262b has its CatchHandler @ 00df37a4 */
        if (iVar6 < 1) {
                    /* try { // try from 00df2634 to 00ef2637 has its CatchHandler @ 00df375c */
          operator_delete((undefined *)(local_60 + -0x18));
        }
      }
      if ((undefined *)(local_68 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_68 + -8);
          *(int *)(local_68 + -8) = iVar6 + -1;
        }
        else {
          piVar8 = (int *)(local_68 + -8);
          do {
            iVar6 = *piVar8;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar8,0x10);
            if (bVar3) {
              *piVar8 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
          operator_delete((undefined *)(local_68 + -0x18));
        }
      }
      if (cVar5 == '\0') {
        FUN_01211570((string *)&local_28,"Asset file verification failed after downloaded",&local_68
                    );
        fileError(this,param_3,(string *)&local_28,0,0);
        if (local_28 + -0x18 != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_28 + -8);
            *(int *)(local_28 + -8) = iVar6 + -1;
          }
          else {
            piVar8 = (int *)(local_28 + -8);
            do {
              iVar6 = *piVar8;
              cVar5 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar8,0x10);
              if (bVar3) {
                *piVar8 = iVar6 + -1;
                cVar5 = ExclusiveMonitorsStatus();
              }
            } while (cVar5 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete(local_28 + -0x18);
          }
        }
        goto LAB_00df2430;
      }
      if (*(char *)(lVar9 + 0x20) != '\0') {
        decompressDownloadedZip(this,param_3,param_2);
        goto LAB_00df2430;
      }
    }
    fileSuccess((string *)this,param_3);
  }
LAB_00df2430:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
                    /* try { // try from 00df2444 to 00ef260b has its CatchHandler @ 00df39e0 */
  return;
}


/* === update @ 00df28c4 === */

/* cocos2d::extension::AssetsManagerEx::update() */

void __thiscall cocos2d::extension::AssetsManagerEx::update(AssetsManagerEx *this)

{
  bool bVar1;
  char cVar2;
  undefined *puVar3;
  int *piVar4;
  int iVar5;
  undefined1 auStack_30 [8];
  undefined1 auStack_28 [16];
  long local_18;
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (this[0xa8] != (AssetsManagerEx)0x0) goto switchD_00df29d4_caseD_2;
  if (this[0x1e0] == (AssetsManagerEx)0x0) {
    FUN_01211570(&local_18,&DAT_012fc3d8,auStack_30);
    FUN_01211570(&local_10,&DAT_012fc3d8,auStack_28);
                    /* try { // try from 00df2940 to 00ef294b has its CatchHandler @ 00df39e0 */
    dispatchUpdateEvent(this,0,&local_18,&local_10,0,0);
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar5 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar5 + -1;
      }
      else {
        piVar4 = (int *)(local_10 + -8);
        do {
          iVar5 = *piVar4;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar4,0x10);
          if (bVar1) {
            *piVar4 = iVar5 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar5 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
    puVar3 = (undefined *)(local_18 + -0x18);
    if (puVar3 == PTR_DAT_017191c0) goto switchD_00df29d4_caseD_2;
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
LAB_00df2b4c:
      iVar5 = *(int *)(local_18 + -8);
      *(int *)(local_18 + -8) = iVar5 + -1;
    }
    else {
      piVar4 = (int *)(local_18 + -8);
      do {
        iVar5 = *piVar4;
        cVar2 = '\x01';
        bVar1 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar1) {
          *piVar4 = iVar5 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
  }
  else {
    cVar2 = Manifest::isLoaded(*(Manifest **)(this + 0x90));
    if (cVar2 != '\0') {
      this[0xa8] = (AssetsManagerEx)0x2;
      switch(*(undefined4 *)(this + 0x40)) {
      case 0:
        *(undefined4 *)(this + 0x40) = 1;
      case 1:
        downloadVersion(this);
        break;
      case 3:
        parseVersion(this);
        break;
      case 4:
        downloadManifest(this);
        break;
      case 6:
        parseManifest(this);
        break;
      case 7:
      case 0xb:
        cVar2 = Manifest::isLoaded(*(Manifest **)(this + 0xa0));
        if (cVar2 == '\0') {
          *(undefined4 *)(this + 0x40) = 4;
          downloadManifest(this);
        }
        else {
          startUpdate(this);
        }
        break;
      case 8:
      case 9:
      case 10:
        this[0xa8] = (AssetsManagerEx)0x0;
                    /* try { // try from 00df2ac0 to 00ef2aff has its CatchHandler @ 00df39e0 */
      }
      goto switchD_00df29d4_caseD_2;
    }
                    /* catch() { ... } // from try @ 00df12e0 with catch @ 00df29f8
                       catch() { ... } // from try @ 00df142c with catch @ 00df29f8
                       catch() { ... } // from try @ 00df2990 with catch @ 00df29f8 */
    FUN_01211570(&local_18,&DAT_012fc3d8,auStack_30);
    FUN_01211570(&local_10,&DAT_012fc3d8,auStack_28);
    dispatchUpdateEvent(this,0,&local_18,&local_10,0,0);
                    /* try { // try from 00df2a38 to 00ef2a3b has its CatchHandler @ 00df0974 */
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar5 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar5 + -1;
      }
      else {
        piVar4 = (int *)(local_10 + -8);
        do {
          iVar5 = *piVar4;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar4,0x10);
          if (bVar1) {
            *piVar4 = iVar5 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar5 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
    puVar3 = (undefined *)(local_18 + -0x18);
    if (puVar3 == PTR_DAT_017191c0) goto switchD_00df29d4_caseD_2;
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) goto LAB_00df2b4c;
    piVar4 = (int *)(local_18 + -8);
    do {
      iVar5 = *piVar4;
      cVar2 = '\x01';
      bVar1 = (bool)ExclusiveMonitorPass(piVar4,0x10);
      if (bVar1) {
        *piVar4 = iVar5 + -1;
        cVar2 = ExclusiveMonitorsStatus();
      }
    } while (cVar2 != '\0');
  }
  if (iVar5 < 1) {
    operator_delete(puVar3);
  }
switchD_00df29d4_caseD_2:
                    /* try { // try from 00df2980 to 00ef2983 has its CatchHandler @ 00df3120 */
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 00df2990 to 00ef2993 has its CatchHandler @ 00df29f8 */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === compile @ 00e33564 === */

/* cocos2d::PUScriptCompiler::compile(std::string const&, bool&) */

void __thiscall
cocos2d::PUScriptCompiler::compile(PUScriptCompiler *this,string *param_1,bool *param_2)

{
  PUScriptCompiler *pPVar1;
  char cVar2;
  bool bVar3;
  undefined8 *puVar4;
  undefined8 *puVar5;
  char cVar6;
  long lVar7;
  long *plVar8;
  void *pvVar9;
  undefined *puVar10;
  int iVar11;
  ulong uVar12;
  ulong uVar13;
  list *plVar14;
  int *piVar15;
  PUScriptCompiler *pPVar16;
  long lVar17;
  list *plVar18;
  ulong uVar19;
  PUConcreteNode *this_00;
  PUScriptCompiler *pPVar20;
  PUScriptCompiler *pPVar21;
  undefined1 auVar22 [16];
  PUScriptCompiler *local_60;
  PUScriptLexer aPStack_50 [8];
  PUScriptParser aPStack_48 [8];
  undefined1 auStack_40 [8];
  long local_38;
  list *local_30;
  list *local_28;
  undefined8 *local_20;
  undefined8 *local_18;
  undefined8 local_10;
  long local_8;
  
  pPVar1 = this + 0x40;
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (*(PUScriptCompiler **)(this + 0x48) != (PUScriptCompiler *)0x0) {
    lVar17 = *(long *)param_1;
    uVar13 = *(ulong *)(lVar17 + -0x18);
    pPVar21 = *(PUScriptCompiler **)(this + 0x48);
    pPVar20 = pPVar1;
    do {
      while( true ) {
        pPVar16 = pPVar21;
        uVar19 = *(ulong *)(*(long *)(pPVar16 + 0x20) + -0x18);
        uVar12 = uVar19;
        if (uVar13 < uVar19) {
          uVar12 = uVar13;
        }
        lVar7 = memcmp(*(long *)(pPVar16 + 0x20),lVar17,uVar12);
        if ((int)lVar7 != 0) break;
        lVar7 = uVar19 - uVar13;
        if (lVar7 < 0x80000000) {
          if (-0x80000001 < lVar7) break;
          goto LAB_00e3367c;
        }
LAB_00e335f8:
        pPVar21 = *(PUScriptCompiler **)(pPVar16 + 0x10);
        pPVar20 = pPVar16;
        if (*(PUScriptCompiler **)(pPVar16 + 0x10) == (PUScriptCompiler *)0x0) goto LAB_00e33604;
      }
      if (-1 < (int)lVar7) goto LAB_00e335f8;
LAB_00e3367c:
      pPVar21 = *(PUScriptCompiler **)(pPVar16 + 0x18);
    } while (*(PUScriptCompiler **)(pPVar16 + 0x18) != (PUScriptCompiler *)0x0);
LAB_00e33604:
    if (pPVar1 != pPVar20) {
      uVar19 = *(ulong *)(*(long *)(pPVar20 + 0x20) + -0x18);
      uVar12 = uVar19;
      if (uVar13 < uVar19) {
        uVar12 = uVar13;
      }
      lVar17 = memcmp(lVar17,*(long *)(pPVar20 + 0x20),uVar12);
      if ((int)lVar17 == 0) {
        lVar17 = uVar13 - uVar19;
        if (lVar17 < 0x80000000) {
          if (lVar17 < -0x80000000) goto LAB_00e33694;
          goto LAB_00e3385c;
        }
      }
      else {
LAB_00e3385c:
        if ((int)lVar17 < 0) goto LAB_00e33694;
      }
      pPVar20 = pPVar20 + 0x28;
      *param_2 = false;
      goto LAB_00e33648;
    }
  }
LAB_00e33694:
  plVar8 = (long *)FileUtils::getInstance();
  (**(code **)(*plVar8 + 0x18))((string *)&local_38,plVar8,param_1);
  PUScriptLexer::PUScriptLexer(aPStack_50);
  PUScriptParser::PUScriptParser(aPStack_48);
  local_20 = (undefined8 *)0x0;
  local_18 = (undefined8 *)0x0;
  local_10 = 0;
  local_30 = (list *)&local_30;
  local_28 = (list *)&local_30;
  PUScriptLexer::openLexer(aPStack_50,(string *)&local_38,param_1,(vector *)&local_20);
  PUScriptParser::parse(aPStack_48,(list *)&local_30,(vector *)&local_20);
  cVar6 = compile(this,(list *)&local_30,param_1);
  puVar4 = local_18;
  for (plVar18 = local_30; puVar5 = local_20, local_18 = puVar4, plVar18 != (list *)&local_30;
      plVar18 = *(list **)plVar18) {
    this_00 = *(PUConcreteNode **)(plVar18 + 0x10);
    if (this_00 != (PUConcreteNode *)0x0) {
      PUConcreteNode::~PUConcreteNode(this_00);
      operator_delete(this_00);
    }
    puVar4 = local_18;
  }
  for (; puVar4 != puVar5; puVar5 = puVar5 + 1) {
    plVar8 = (long *)*puVar5;
    if (plVar8 != (long *)0x0) {
      lVar17 = plVar8[1];
      if ((undefined *)(lVar17 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar11 = *(int *)(lVar17 + -8);
          *(int *)(lVar17 + -8) = iVar11 + -1;
        }
        else {
          piVar15 = (int *)(lVar17 + -8);
          do {
            iVar11 = *piVar15;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar15,0x10);
            if (bVar3) {
              *piVar15 = iVar11 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar11 < 1) {
          operator_delete((undefined *)(lVar17 + -0x18));
        }
      }
      lVar17 = *plVar8;
      if ((undefined *)(lVar17 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar11 = *(int *)(lVar17 + -8);
          *(int *)(lVar17 + -8) = iVar11 + -1;
        }
        else {
          piVar15 = (int *)(lVar17 + -8);
          do {
            iVar11 = *piVar15;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar15,0x10);
            if (bVar3) {
              *piVar15 = iVar11 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar11 < 1) {
          operator_delete((undefined *)(lVar17 + -0x18));
        }
      }
      operator_delete(plVar8);
    }
  }
  *param_2 = true;
  if (cVar6 == '\0') {
    pPVar20 = (PUScriptCompiler *)0x0;
    plVar18 = local_30;
  }
  else {
    local_60 = pPVar1;
    if (*(PUScriptCompiler **)(this + 0x48) != (PUScriptCompiler *)0x0) {
      lVar17 = *(long *)param_1;
      uVar13 = *(ulong *)(lVar17 + -0x18);
      pPVar20 = *(PUScriptCompiler **)(this + 0x48);
      do {
        uVar19 = *(ulong *)(*(long *)(pPVar20 + 0x20) + -0x18);
        uVar12 = uVar19;
        if (uVar13 < uVar19) {
          uVar12 = uVar13;
        }
        lVar7 = memcmp(*(long *)(pPVar20 + 0x20),lVar17,uVar12);
        if ((int)lVar7 == 0) {
          lVar7 = uVar19 - uVar13;
          if (lVar7 < 0x80000000) {
            if (-0x80000001 < lVar7) goto LAB_00e33920;
            goto LAB_00e33a54;
          }
LAB_00e33924:
          pPVar21 = *(PUScriptCompiler **)(pPVar20 + 0x10);
          local_60 = pPVar20;
        }
        else {
LAB_00e33920:
          if (-1 < (int)lVar7) goto LAB_00e33924;
LAB_00e33a54:
          pPVar21 = *(PUScriptCompiler **)(pPVar20 + 0x18);
        }
        pPVar20 = pPVar21;
      } while (pPVar21 != (PUScriptCompiler *)0x0);
      if (pPVar1 != local_60) {
        uVar19 = *(ulong *)(*(long *)(local_60 + 0x20) + -0x18);
        uVar12 = uVar19;
        if (uVar13 < uVar19) {
          uVar12 = uVar13;
        }
        lVar17 = memcmp(lVar17,*(long *)(local_60 + 0x20),uVar12);
        if ((int)lVar17 == 0) {
          lVar17 = uVar13 - uVar19;
          if (lVar17 < 0x80000000) {
            if (lVar17 < -0x80000000) goto LAB_00e33978;
            goto LAB_00e33a7c;
          }
        }
        else {
LAB_00e33a7c:
          if ((int)lVar17 < 0) goto LAB_00e33978;
        }
        pPVar20 = local_60 + 0x28;
        plVar18 = local_30;
        goto joined_r0x00e337e0;
      }
    }
LAB_00e33978:
    pvVar9 = operator_new(0x38);
    FUN_01214ee0((long)pvVar9 + 0x20,param_1);
    pPVar20 = (PUScriptCompiler *)((long)pvVar9 + 0x28);
    *(PUScriptCompiler **)((long)pvVar9 + 0x28) = pPVar20;
    *(PUScriptCompiler **)((long)pvVar9 + 0x30) = pPVar20;
    auVar22 = std::
              _Rb_tree<std::string,std::pair<std::string_const,std::list<cocos2d::PUAbstractNode*,std::allocator<cocos2d::PUAbstractNode*>>>,std::_Select1st<std::pair<std::string_const,std::list<cocos2d::PUAbstractNode*,std::allocator<cocos2d::PUAbstractNode*>>>>,std::less<std::string>,std::allocator<std::pair<std::string_const,std::list<cocos2d::PUAbstractNode*,std::allocator<cocos2d::PUAbstractNode*>>>>>
              ::_M_get_insert_hint_unique_pos
                        ((_Rb_tree<std::string,std::pair<std::string_const,std::list<cocos2d::PUAbstractNode*,std::allocator<cocos2d::PUAbstractNode*>>>,std::_Select1st<std::pair<std::string_const,std::list<cocos2d::PUAbstractNode*,std::allocator<cocos2d::PUAbstractNode*>>>>,std::less<std::string>,std::allocator<std::pair<std::string_const,std::list<cocos2d::PUAbstractNode*,std::allocator<cocos2d::PUAbstractNode*>>>>>
                          *)(this + 0x38),local_60,(long)pvVar9 + 0x20);
    pPVar21 = auVar22._8_8_;
    if (pPVar21 == (PUScriptCompiler *)0x0) {
      pPVar1 = *(PUScriptCompiler **)((long)pvVar9 + 0x28);
      while (pPVar20 != pPVar1) {
        pPVar21 = *(PUScriptCompiler **)pPVar1;
        operator_delete(pPVar1);
        pPVar1 = pPVar21;
      }
      puVar10 = (undefined *)(*(long *)((long)pvVar9 + 0x20) + -0x18);
      if (puVar10 != PTR_DAT_017191c0) {
        FUN_006c2a88(puVar10,auStack_40);
      }
      pPVar20 = (PUScriptCompiler *)(auVar22._0_8_ + 0x28);
      operator_delete(pvVar9);
      plVar18 = local_30;
    }
    else {
      if ((auVar22._0_8_ == 0) && (pPVar1 != pPVar21)) {
        uVar19 = *(ulong *)(*(long *)((long)pvVar9 + 0x20) + -0x18);
        uVar12 = *(ulong *)(*(long *)(pPVar21 + 0x20) + -0x18);
        uVar13 = uVar12;
        if (uVar19 < uVar12) {
          uVar13 = uVar19;
        }
        uVar13 = memcmp(*(long *)((long)pvVar9 + 0x20),*(long *)(pPVar21 + 0x20),uVar13);
        if ((int)uVar13 == 0) {
          uVar19 = uVar19 - uVar12;
          uVar13 = 0;
          if ((0x7fffffff < (long)uVar19) || (uVar13 = 1, (long)uVar19 < -0x80000000))
          goto LAB_00e33a30;
          uVar13 = uVar19 & 0xffffffff;
        }
        uVar13 = uVar13 >> 0x1f & 1;
      }
      else {
        uVar13 = 1;
      }
LAB_00e33a30:
      FUN_011f6620(uVar13,pvVar9,pPVar21,pPVar1);
      *(long *)(this + 0x60) = *(long *)(this + 0x60) + 1;
      plVar18 = local_30;
    }
  }
joined_r0x00e337e0:
  while (plVar18 != (list *)&local_30) {
    plVar14 = *(list **)plVar18;
    operator_delete(plVar18);
    plVar18 = plVar14;
  }
  if (local_20 != (undefined8 *)0x0) {
    operator_delete(local_20);
  }
  PUScriptParser::~PUScriptParser(aPStack_48);
  PUScriptLexer::~PUScriptLexer(aPStack_50);
  if ((undefined *)(local_38 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar11 = *(int *)(local_38 + -8);
      *(int *)(local_38 + -8) = iVar11 + -1;
    }
    else {
      piVar15 = (int *)(local_38 + -8);
      do {
        iVar11 = *piVar15;
        cVar6 = '\x01';
        bVar3 = (bool)ExclusiveMonitorPass(piVar15,0x10);
        if (bVar3) {
          *piVar15 = iVar11 + -1;
          cVar6 = ExclusiveMonitorsStatus();
        }
      } while (cVar6 != '\0');
    }
    if (iVar11 < 1) {
      operator_delete((undefined *)(local_38 + -0x18));
    }
  }
LAB_00e33648:
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(pPVar20);
}


/* === addAnimationsWithDictionary @ 00ecbfe4 === */

/* cocos2d::AnimationCache::addAnimationsWithDictionary(std::unordered_map<std::string,
   cocos2d::Value, std::hash<std::string >, std::equal_to<std::string >,
   std::allocator<std::pair<std::string const, cocos2d::Value> > > const&, std::string const&) */

void __thiscall
cocos2d::AnimationCache::addAnimationsWithDictionary
          (AnimationCache *this,unordered_map *param_1,string *param_2)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  long lVar4;
  Value *this_00;
  Value *pVVar5;
  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
  *this_01;
  long *plVar6;
  SpriteFrameCache *this_02;
  unordered_map *puVar7;
  int *piVar8;
  int iVar9;
  long lVar10;
  code *pcVar11;
  undefined1 auStack_20 [8];
  long local_18;
  long local_10;
  long local_8;
  
                    /* try { // try from 00ecbfe8 to 00fcbfeb has its CatchHandler @ 00ecc164 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FUN_01211570((string *)&local_10,"animations",auStack_20);
  lVar4 = std::
          _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
          ::find((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                  *)param_1,(string *)&local_10);
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00ecc30c to 00fcc30f has its CatchHandler @ 00ecc6c0 */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
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
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  if (lVar4 != 0) {
    FUN_01211570((string *)&local_10,"animations",auStack_20);
    this_00 = (Value *)std::__detail::
                       _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                       ::at((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                             *)param_1,(string *)&local_10);
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_10 + -8);
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
      if (iVar3 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
    FUN_01211570((string *)&local_10,"properties",auStack_20);
    lVar4 = std::
            _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
            ::find((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                    *)param_1,(string *)&local_10);
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_10 + -8);
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
      if (iVar3 < 1) {
                    /* try { // try from 00ecc364 to 00fcc367 has its CatchHandler @ 00ecc7a8 */
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
    if (lVar4 != 0) {
      FUN_01211570((string *)&local_10,"properties",auStack_20);
      pVVar5 = (Value *)std::__detail::
                        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        ::at((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                              *)param_1,(string *)&local_10);
      this_01 = (_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                 *)cocos2d::Value::asValueMap(pVVar5);
      if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar3 = *(int *)(local_10 + -8);
                    /* try { // try from 00ecc440 to 00fcc47f has its CatchHandler @ 00ecc748 */
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
        if (iVar3 < 1) {
          operator_delete((undefined *)(local_10 + -0x18));
        }
      }
      FUN_01211570((string *)&local_10,"format",auStack_20);
      pVVar5 = (Value *)std::__detail::
                        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        ::at(this_01,(string *)&local_10);
      iVar3 = cocos2d::Value::asInt(pVVar5);
      if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar9 = *(int *)(local_10 + -8);
          *(int *)(local_10 + -8) = iVar9 + -1;
        }
        else {
          piVar8 = (int *)(local_10 + -8);
          do {
                    /* try { // try from 00ecc3e4 to 00fcc41f has its CatchHandler @ 00ecc724 */
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
      FUN_01211570((string *)&local_10,"spritesheets",auStack_20);
                    /* catch() { ... } // from try @ 00ecbdcc with catch @ 00ecc164
                       catch() { ... } // from try @ 00ecbfe8 with catch @ 00ecc164 */
      pVVar5 = (Value *)std::__detail::
                        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        ::at(this_01,(string *)&local_10);
      plVar6 = (long *)cocos2d::Value::asValueVector(pVVar5);
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
                    /* try { // try from 00ecc390 to 00fcc393 has its CatchHandler @ 00ecc770 */
        if (iVar9 < 1) {
          operator_delete((undefined *)(local_10 + -0x18));
        }
      }
      lVar10 = plVar6[1];
      for (lVar4 = *plVar6; lVar4 != lVar10; lVar4 = lVar4 + 0x10) {
        plVar6 = (long *)FileUtils::getInstance();
        pcVar11 = *(code **)(*plVar6 + 0x68);
        cocos2d::Value::asString();
                    /* try { // try from 00ecc1c4 to 00fcc1c7 has its CatchHandler @ 00ecbd18 */
                    /* catch() { ... } // from try @ 00ecbea4 with catch @ 00ecc1c8
                       catch() { ... } // from try @ 00ecbf84 with catch @ 00ecc1c8 */
        (*pcVar11)((string *)&local_18,plVar6,(string *)&local_10,param_2);
        if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00ecc2a0 with catch @ 00ecc254
                       catch() { ... } // from try @ 00ecc720 with catch @ 00ecc254 */
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
        this_02 = (SpriteFrameCache *)SpriteFrameCache::getInstance();
        SpriteFrameCache::addSpriteFramesWithFile(this_02,(string *)&local_18);
                    /* catch() { ... } // from try @ 00ecbefc with catch @ 00ecc1ec */
                    /* catch() { ... } // from try @ 00ecbd80 with catch @ 00ecc1fc */
        if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar9 = *(int *)(local_18 + -8);
                    /* try { // try from 00ecc2bc to 00fcc2bf has its CatchHandler @ 00ecc758 */
            *(int *)(local_18 + -8) = iVar9 + -1;
          }
          else {
            piVar8 = (int *)(local_18 + -8);
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
                    /* try { // try from 00ecc2a0 to 00fcc2a3 has its CatchHandler @ 00ecc254 */
          if (iVar9 < 1) {
            operator_delete((undefined *)(local_18 + -0x18));
          }
        }
                    /* catch() { ... } // from try @ 00ecbd94 with catch @ 00ecc208 */
      }
                    /* catch() { ... } // from try @ 00ecbe50 with catch @ 00ecc214 */
      if (iVar3 != 1) {
        if (iVar3 == 2) {
                    /* try { // try from 00ecc2d4 to 00fcc2d7 has its CatchHandler @ 00ecc764 */
          puVar7 = (unordered_map *)cocos2d::Value::asValueMap(this_00);
          parseVersion2(this,puVar7);
        }
        goto LAB_00ecc220;
      }
    }
    puVar7 = (unordered_map *)cocos2d::Value::asValueMap(this_00);
    parseVersion1(this,puVar7);
  }
LAB_00ecc220:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
                    /* catch() { ... } // from try @ 00ecbe24 with catch @ 00ecc24c */
  return;
}


/* === setupTiles @ 00edb754 === */

/* cocos2d::experimental::TMXLayer::setupTiles() */

void __thiscall cocos2d::experimental::TMXLayer::setupTiles(TMXLayer *this)

{
  Size *pSVar1;
  Director *this_00;
  long lVar2;
  float fVar3;
  float fVar4;
  float local_10;
  float local_c;
  long local_8;
  
  lVar2 = *(long *)(this + 0x350);
                    /* try { // try from 00edb778 to 00fdb79f has its CatchHandler @ 00edb96c */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  pSVar1 = (Size *)Texture2D::getContentSizeInPixels(*(Texture2D **)(this + 0x398));
  Size::operator=((Size *)(lVar2 + 0x58),pSVar1);
  Texture2D::setAliasTexParameters(*(Texture2D **)(this + 0x398));
  parseInternalProperties(this);
  this_00 = (Director *)Director::getInstance();
  pSVar1 = (Size *)Director::getWinSize(this_00);
                    /* try { // try from 00edb7b8 to 00fdb7bb has its CatchHandler @ 00edb908 */
  Size::Size((Size *)&local_10,pSVar1);
  if (*(int *)(this + 0x358) == 0) {
    fVar4 = *(float *)(*(long *)(this + 0x350) + 0x38);
    fVar3 = (float)(int)(local_10 / *(float *)(this + 0x340)) + 1.0;
    *(float *)(this + 0x3d0) = fVar3;
    fVar4 = (float)(int)(local_c / *(float *)(this + 0x344)) + 1.0 +
            fVar4 / *(float *)(this + 0x344);
    *(float *)(this + 0x3d4) = fVar4;
  }
  else if (*(int *)(this + 0x358) == 2) {
    fVar3 = (float)(int)(local_10 / *(float *)(this + 0x340)) + 2.0;
    *(float *)(this + 0x3d0) = fVar3;
    fVar4 = (float)(int)(local_c / (*(float *)(this + 0x344) * 0.5)) + 4.0;
    *(float *)(this + 0x3d4) = fVar4;
  }
  else {
    fVar3 = *(float *)(this + 0x3d0);
    fVar4 = *(float *)(this + 0x3d4);
  }
  *(int *)(this + 1000) = (int)(fVar3 * fVar4);
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === buildWithMapInfo @ 00edc7a0 === */

/* cocos2d::experimental::TMXTiledMap::buildWithMapInfo(cocos2d::TMXMapInfo*) */

void __thiscall
cocos2d::experimental::TMXTiledMap::buildWithMapInfo(TMXTiledMap *this,TMXMapInfo *param_1)

{
  long *plVar1;
  float *pfVar2;
  Size *pSVar3;
  long lVar4;
  undefined8 *puVar5;
  ulong uVar6;
  undefined8 *puVar7;
  undefined8 *puVar8;
  int iVar9;
  ulong uVar10;
  float fVar11;
  float fVar12;
  float local_10;
  float local_c;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  Size::operator=((Size *)(this + 0x330),(Size *)(param_1 + 0x40));
  Size::operator=((Size *)(this + 0x338),(Size *)(param_1 + 0x48));
  *(undefined4 *)(this + 0x340) = *(undefined4 *)(param_1 + 0x30);
  if (this + 0x348 != (TMXTiledMap *)(param_1 + 0x80)) {
    puVar7 = *(undefined8 **)(this + 0x350);
    puVar8 = *(undefined8 **)(this + 0x348);
    if (*(undefined8 **)(this + 0x348) != puVar7) {
      do {
        puVar5 = puVar8 + 1;
        cocos2d::Ref::release((Ref *)*puVar8);
        puVar8 = puVar5;
                    /* catch() { ... } // from try @ 00edc8a4 with catch @ 00edc81c
                       catch() { ... } // from try @ 00edca14 with catch @ 00edc81c */
      } while (puVar7 != puVar5);
      puVar7 = *(undefined8 **)(this + 0x348);
    }
    *(undefined8 **)(this + 0x350) = puVar7;
    lVar4 = *(long *)(param_1 + 0x80);
    uVar6 = *(long *)(param_1 + 0x88) - lVar4;
    uVar10 = (long)uVar6 >> 3;
    if ((ulong)(*(long *)(this + 0x358) - (long)puVar7 >> 3) < uVar10) {
      puVar7 = (undefined8 *)0x0;
      if (uVar10 != 0) {
        if (0x1fffffffffffffff < uVar10) {
                    /* WARNING: Subroutine does not return */
          FUN_0120f0e8();
        }
        puVar7 = operator_new(uVar6);
        if (uVar10 != 0) {
          memmove(puVar7,lVar4,uVar6);
        }
      }
                    /* catch() { ... } // from try @ 00edc8d8 with catch @ 00edc9ec */
      if (*(void **)(this + 0x348) != (void *)0x0) {
        operator_delete(*(void **)(this + 0x348));
      }
      *(undefined8 **)(this + 0x348) = puVar7;
      puVar8 = (undefined8 *)((long)puVar7 + uVar6);
      *(undefined8 **)(this + 0x358) = puVar8;
    }
    else {
      if (uVar10 != 0) {
        memmove(puVar7,lVar4,uVar6);
        puVar7 = *(undefined8 **)(this + 0x348);
      }
      puVar8 = (undefined8 *)((long)puVar7 + uVar6);
    }
    *(undefined8 **)(this + 0x350) = puVar8;
    for (; puVar7 != puVar8; puVar7 = puVar7 + 1) {
      cocos2d::Ref::retain((Ref *)*puVar7);
    }
  }
  iVar9 = 0;
  std::
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  ::operator=((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
               *)(this + 0x360),(_Hashtable *)(param_1 + 0xa8));
  std::
  _Hashtable<int,std::pair<int_const,cocos2d::Value>,std::allocator<std::pair<int_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<int>,std::hash<int>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
  ::operator=((_Hashtable<int,std::pair<int_const,cocos2d::Value>,std::allocator<std::pair<int_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<int>,std::hash<int>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
               *)(this + 0x398),(_Hashtable *)(param_1 + 0x100));
  puVar8 = *(undefined8 **)(param_1 + 0x58);
  puVar7 = *(undefined8 **)(param_1 + 0x50);
  do {
    while( true ) {
      if (puVar8 == puVar7) {
        if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
          return;
        }
                    /* WARNING: Subroutine does not return */
        __stack_chk_fail();
      }
      if (((TMXLayerInfo *)*puVar7)[0x78] != (TMXLayerInfo)0x0) break;
LAB_00edc8a0:
      puVar7 = puVar7 + 1;
                    /* try { // try from 00edc8a4 to 00fdc8c7 has its CatchHandler @ 00edc81c */
    }
    plVar1 = (long *)parseLayer(this,(TMXLayerInfo *)*puVar7,param_1);
    if (plVar1 == (long *)0x0) {
      iVar9 = iVar9 + 1;
      goto LAB_00edc8a0;
    }
                    /* try { // try from 00edc8d8 to 00fdc8db has its CatchHandler @ 00edc9ec */
    (**(code **)(*(long *)this + 0x220))(this,plVar1,iVar9,iVar9);
    pfVar2 = (float *)(**(code **)(*plVar1 + 0x170))(plVar1);
    pSVar3 = (Size *)(**(code **)(*(long *)this + 0x170))(this);
    Size::Size((Size *)&local_10,pSVar3);
    fVar12 = *pfVar2;
    if (*pfVar2 <= local_10) {
      fVar12 = local_10;
    }
    fVar11 = pfVar2[1];
    if (pfVar2[1] <= local_c) {
      fVar11 = local_c;
    }
    puVar7 = puVar7 + 1;
    iVar9 = iVar9 + 1;
    local_10 = fVar12;
    local_c = fVar11;
    (**(code **)(*(long *)this + 0x160))(this,(Size *)&local_10);
  } while( true );
}


/* === parseConfigFile @ 00ee0ba0 === */

/* WARNING: Restarted to delay deadcode elimination for space: stack */
/* cocos2d::BMFontConfiguration::parseConfigFile(std::string const&) */

void __thiscall
cocos2d::BMFontConfiguration::parseConfigFile(BMFontConfiguration *this,string *param_1)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  long *plVar4;
  _Rb_tree<unsigned_int,unsigned_int,std::_Identity<unsigned_int>,std::less<unsigned_int>,std::allocator<unsigned_int>>
  *this_00;
  uchar *puVar5;
  long lVar6;
  ulong uVar7;
  ulong uVar8;
  uchar *puVar9;
  int *piVar10;
  long lVar11;
  uint local_218 [2];
  uchar *local_210;
  char acStack_208 [512];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  plVar4 = (long *)FileUtils::getInstance();
  (**(code **)(*plVar4 + 0x18))(&local_210,plVar4,param_1);
  puVar5 = local_210;
  uVar7 = *(ulong *)(local_210 + -0x18);
  if (uVar7 == 0) {
LAB_00ee0f18:
    local_210 = puVar5;
    this_00 = (_Rb_tree<unsigned_int,unsigned_int,std::_Identity<unsigned_int>,std::less<unsigned_int>,std::allocator<unsigned_int>>
               *)0x0;
LAB_00ee0c68:
    puVar5 = local_210 + -0x18;
    if (puVar5 == PTR_DAT_017191c0) goto LAB_00ee0c7c;
  }
  else {
    if ((2 < uVar7) && (iVar3 = memcmp(&DAT_0135f4e0,local_210,3), iVar3 == 0)) {
      if (-1 < *(int *)(puVar5 + -8)) {
        FUN_01213860(&local_210);
        uVar7 = *(ulong *)(local_210 + -0x18);
        puVar5 = local_210;
      }
      this_00 = (_Rb_tree<unsigned_int,unsigned_int,std::_Identity<unsigned_int>,std::less<unsigned_int>,std::allocator<unsigned_int>>
                 *)parseBinaryConfigFile(this,puVar5,uVar7,param_1);
      goto LAB_00ee0c68;
    }
    if (-1 < *(int *)(puVar5 + -8)) {
      FUN_01213860(&local_210);
      puVar5 = local_210;
    }
    if (*puVar5 == '\0') goto LAB_00ee0f18;
    this_00 = operator_new(0x30,(nothrow_t *)PTR_nothrow_01717628);
    if (this_00 !=
        (_Rb_tree<unsigned_int,unsigned_int,std::_Identity<unsigned_int>,std::less<unsigned_int>,std::allocator<unsigned_int>>
         *)0x0) {
      *(undefined4 *)(this_00 + 8) = 0;
      *(undefined8 *)(this_00 + 0x10) = 0;
      *(undefined8 *)(this_00 + 0x28) = 0;
      *(_Rb_tree<unsigned_int,unsigned_int,std::_Identity<unsigned_int>,std::less<unsigned_int>,std::allocator<unsigned_int>>
        **)(this_00 + 0x18) = this_00 + 8;
      *(_Rb_tree<unsigned_int,unsigned_int,std::_Identity<unsigned_int>,std::less<unsigned_int>,std::allocator<unsigned_int>>
        **)(this_00 + 0x20) = this_00 + 8;
    }
    uVar7 = strlen(puVar5);
    memset(acStack_208,0,0x200);
    lVar6 = strchr(puVar5,10);
    if (lVar6 != 0) {
      uVar8 = 0;
      puVar9 = puVar5;
      do {
        while( true ) {
          lVar11 = (long)((int)lVar6 - (int)puVar9);
          memcpy(acStack_208,puVar5 + uVar8,lVar11);
          acStack_208[lVar11] = '\0';
          uVar8 = uVar8 + lVar11 + 1;
          if (uVar8 < uVar7) break;
          lVar6 = 0;
          iVar3 = memcmp(acStack_208,"info face",9);
          if (iVar3 != 0) goto LAB_00ee0dc0;
LAB_00ee0eb0:
          parseInfoArguments(this,acStack_208);
joined_r0x00ee0e90:
          if (lVar6 == 0) goto LAB_00ee0e30;
        }
        puVar9 = (uchar *)(lVar6 + 1);
        lVar6 = strchr(puVar9,10);
        iVar3 = memcmp(acStack_208,"info face",9);
        if (iVar3 == 0) goto LAB_00ee0eb0;
LAB_00ee0dc0:
        iVar3 = memcmp(acStack_208,"common lineHeight",0x11);
        if (iVar3 != 0) {
          iVar3 = memcmp(acStack_208,"page id",7);
          if (iVar3 == 0) {
            parseImageFileName(this,acStack_208,param_1);
          }
          else {
            iVar3 = memcmp(acStack_208,"chars c",7);
            if (iVar3 != 0) {
              iVar3 = memcmp(acStack_208,&DAT_0135f520,4);
              if (iVar3 == 0) {
                local_218[0] = parseCharacterDefinition(this,acStack_208);
                std::
                _Rb_tree<unsigned_int,unsigned_int,std::_Identity<unsigned_int>,std::less<unsigned_int>,std::allocator<unsigned_int>>
                ::_M_insert_unique<unsigned_int_const&>(this_00,local_218);
              }
              else {
                iVar3 = memcmp(acStack_208,"kerning first",0xd);
                if (iVar3 == 0) {
                  parseKerningEntry(this,acStack_208);
                }
              }
            }
          }
          goto joined_r0x00ee0e90;
        }
        parseCommonArguments(this,acStack_208);
      } while (lVar6 != 0);
    }
LAB_00ee0e30:
    puVar5 = local_210 + -0x18;
    if (puVar5 == PTR_DAT_017191c0) goto LAB_00ee0c7c;
  }
  if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
    iVar3 = *(int *)(local_210 + -8);
    *(int *)(local_210 + -8) = iVar3 + -1;
  }
  else {
    piVar10 = (int *)(local_210 + -8);
    do {
      iVar3 = *piVar10;
      cVar1 = '\x01';
      bVar2 = (bool)ExclusiveMonitorPass(piVar10,0x10);
      if (bVar2) {
        *piVar10 = iVar3 + -1;
        cVar1 = ExclusiveMonitorsStatus();
      }
    } while (cVar1 != '\0');
  }
  if (iVar3 < 1) {
    operator_delete(puVar5);
  }
LAB_00ee0c7c:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(this_00);
  }
  return;
}


/* === initWithFNTfile @ 00ee0f64 === */

/* cocos2d::BMFontConfiguration::initWithFNTfile(std::string const&) */

bool __thiscall
cocos2d::BMFontConfiguration::initWithFNTfile(BMFontConfiguration *this,string *param_1)

{
  long lVar1;
  
  lVar1 = parseConfigFile(this,param_1);
  *(long *)(this + 0xb8) = lVar1;
  return lVar1 != 0;
}


/* === addSpriteFramesWithDictionary @ 00f3975c === */

/* WARNING: Restarted to delay deadcode elimination for space: stack */
/* cocos2d::SpriteFrameCache::addSpriteFramesWithDictionary(std::unordered_map<std::string,
   cocos2d::Value, std::hash<std::string >, std::equal_to<std::string >,
   std::allocator<std::pair<std::string const, cocos2d::Value> > >&, cocos2d::Texture2D*) */

void __thiscall
cocos2d::SpriteFrameCache::addSpriteFramesWithDictionary
          (SpriteFrameCache *this,unordered_map *param_1,Texture2D *param_2)

{
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::SpriteFrame*>,std::allocator<std::pair<std::string_const,cocos2d::SpriteFrame*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  *this_00;
  bool bVar1;
  long lVar2;
  char cVar3;
  bool bVar4;
  uint uVar5;
  uint uVar6;
  long lVar7;
  Value *pVVar8;
  long lVar9;
  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
  *p_Var10;
  Director *this_01;
  Texture2D *pTVar11;
  _Hash_node *p_Var12;
  _Hash_node_base *p_Var13;
  undefined *puVar14;
  long *plVar15;
  long lVar16;
  string *extraout_x1;
  ulong uVar17;
  ulong uVar18;
  int *piVar19;
  string *extraout_x1_00;
  string *extraout_x1_01;
  string *extraout_x1_02;
  string *extraout_x1_03;
  string *extraout_x1_04;
  string *extraout_x1_05;
  string *extraout_x1_06;
  string *extraout_x1_07;
  int iVar20;
  int iVar21;
  _Hash_node_base *p_Var22;
  long *plVar23;
  SpriteFrame *this_02;
  float fVar24;
  float fVar25;
  float fVar26;
  float fVar27;
  undefined4 uVar28;
  undefined4 uVar29;
  NinePatchImageParser *local_218;
  Image *local_208;
  int local_1fc;
  bool local_1f0;
  vector *local_1e8;
  Size aSStack_1d8 [8];
  long local_1d0;
  long local_1c8;
  long local_1c0;
  long local_1b8;
  long local_1b0;
  long local_1a8;
  long local_1a0;
  long local_198;
  long local_190;
  long local_188;
  long local_180;
  long local_178;
  long local_170;
  long local_168;
  long local_160;
  long local_158;
  undefined8 local_150;
  long local_148;
  long local_140;
  long local_138;
  long local_130;
  long local_128;
  long local_120;
  long local_118;
  long local_110;
  long local_108;
  long local_100;
  long local_f8;
  long local_f0;
  long local_e8;
  long local_e0;
  long local_d8;
  long local_d0;
  SpriteFrame *local_c8;
  undefined8 local_c0;
  void *local_b0;
  undefined8 local_a8;
  undefined8 local_a0;
  undefined8 local_98;
  undefined8 local_90;
  undefined8 local_88;
  void *local_80;
  undefined8 local_78;
  undefined8 local_70;
  long local_68 [5];
  long local_40 [7];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FUN_01211570((Size *)local_40,"frames",(Size *)&local_80);
  lVar7 = std::__detail::
          _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        *)param_1,(string *)local_40);
  iVar20 = *(int *)(lVar7 + 8);
  if ((undefined *)(local_40[0] + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar21 = *(int *)(local_40[0] + -8);
      *(int *)(local_40[0] + -8) = iVar21 + -1;
    }
    else {
      piVar19 = (int *)(local_40[0] + -8);
      do {
        iVar21 = *piVar19;
        cVar3 = '\x01';
        bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
        if (bVar4) {
          *piVar19 = iVar21 + -1;
          cVar3 = ExclusiveMonitorsStatus();
        }
      } while (cVar3 != '\0');
    }
    if (iVar21 < 1) {
      operator_delete((undefined *)(local_40[0] + -0x18));
    }
  }
  if (iVar20 == 9) {
                    /* try { // try from 00f39840 to 01039843 has its CatchHandler @ 00f39860 */
    FUN_01211570((Size *)local_40,"frames",(Size *)&local_80);
                    /* try { // try from 00f39848 to 0103984b has its CatchHandler @ 00f39874 */
    pVVar8 = (Value *)std::__detail::
                      _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                      ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                    *)param_1,(string *)local_40);
    lVar7 = cocos2d::Value::asValueMap(pVVar8);
                    /* catch() { ... } // from try @ 00f39840 with catch @ 00f39860 */
    if ((undefined *)(local_40[0] + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar20 = *(int *)(local_40[0] + -8);
        *(int *)(local_40[0] + -8) = iVar20 + -1;
      }
      else {
        piVar19 = (int *)(local_40[0] + -8);
        do {
                    /* try { // try from 00f3aa08 to 0103aa1f has its CatchHandler @ 00f3ac84 */
          iVar20 = *piVar19;
          cVar3 = '\x01';
          bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
          if (bVar4) {
            *piVar19 = iVar20 + -1;
            cVar3 = ExclusiveMonitorsStatus();
          }
        } while (cVar3 != '\0');
      }
      if (iVar20 < 1) {
        operator_delete((undefined *)(local_40[0] + -0x18));
      }
    }
                    /* try { // try from 00f39870 to 01039873 has its CatchHandler @ 00f3980c */
                    /* catch() { ... } // from try @ 00f39848 with catch @ 00f39874 */
    Size::Size(aSStack_1d8);
    FUN_01211570((Size *)local_40,"metadata",(Size *)&local_80);
    lVar9 = std::
            _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
            ::find((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                    *)param_1,(string *)local_40);
    if ((undefined *)(local_40[0] + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar20 = *(int *)(local_40[0] + -8);
        *(int *)(local_40[0] + -8) = iVar20 + -1;
      }
      else {
        piVar19 = (int *)(local_40[0] + -8);
        do {
          iVar20 = *piVar19;
          cVar3 = '\x01';
          bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
          if (bVar4) {
            *piVar19 = iVar20 + -1;
            cVar3 = ExclusiveMonitorsStatus();
          }
        } while (cVar3 != '\0');
      }
      if (iVar20 < 1) {
        operator_delete((undefined *)(local_40[0] + -0x18));
      }
    }
    if (lVar9 == 0) {
      local_1fc = 0;
    }
    else {
      FUN_01211570((Size *)local_40,"metadata",(Size *)&local_80);
      pVVar8 = (Value *)std::__detail::
                        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                      *)param_1,(string *)local_40);
      p_Var10 = (_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                 *)cocos2d::Value::asValueMap(pVVar8);
      if ((undefined *)(local_40[0] + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar20 = *(int *)(local_40[0] + -8);
          *(int *)(local_40[0] + -8) = iVar20 + -1;
        }
        else {
          piVar19 = (int *)(local_40[0] + -8);
          do {
            iVar20 = *piVar19;
            cVar3 = '\x01';
            bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
            if (bVar4) {
              *piVar19 = iVar20 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
                    /* try { // try from 00f3aa8c to 0103aa8f has its CatchHandler @ 00f3aedc */
        if (iVar20 < 1) {
          operator_delete((undefined *)(local_40[0] + -0x18));
        }
      }
      FUN_01211570((Size *)local_40,"format",(Size *)&local_80);
      pVVar8 = (Value *)std::__detail::
                        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        ::operator[](p_Var10,(string *)local_40);
      local_1fc = cocos2d::Value::asInt(pVVar8);
      if ((undefined *)(local_40[0] + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar20 = *(int *)(local_40[0] + -8);
          *(int *)(local_40[0] + -8) = iVar20 + -1;
        }
        else {
          piVar19 = (int *)(local_40[0] + -8);
          do {
                    /* try { // try from 00f3aa48 to 0103aa6b has its CatchHandler @ 00f3ac40 */
            iVar20 = *piVar19;
            cVar3 = '\x01';
            bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
            if (bVar4) {
              *piVar19 = iVar20 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar20 < 1) {
          operator_delete((undefined *)(local_40[0] + -0x18));
        }
      }
      FUN_01211570((Size *)local_40,"size",(Size *)&local_80);
      lVar9 = std::
              _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
              ::find((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                      *)p_Var10,(string *)local_40);
      if ((undefined *)(local_40[0] + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 00f3b074 to 0103b0cf has its CatchHandler @ 00f3ac40 */
          iVar20 = *(int *)(local_40[0] + -8);
          *(int *)(local_40[0] + -8) = iVar20 + -1;
        }
        else {
          piVar19 = (int *)(local_40[0] + -8);
          do {
            iVar20 = *piVar19;
            cVar3 = '\x01';
            bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
            if (bVar4) {
              *piVar19 = iVar20 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar20 < 1) {
          operator_delete((undefined *)(local_40[0] + -0x18));
        }
      }
      if (lVar9 != 0) {
        FUN_01211570((Size *)&local_80,"size",&local_98);
        std::__detail::
        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
        ::operator[](p_Var10,(string *)&local_80);
        cocos2d::Value::asString();
        SizeFromString((cocos2d *)local_68,extraout_x1);
        Size::operator=(aSStack_1d8,(Size *)local_40);
        if ((undefined *)(local_68[0] + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar20 = *(int *)(local_68[0] + -8);
            *(int *)(local_68[0] + -8) = iVar20 + -1;
          }
          else {
            piVar19 = (int *)(local_68[0] + -8);
            do {
              iVar20 = *piVar19;
              cVar3 = '\x01';
              bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
              if (bVar4) {
                *piVar19 = iVar20 + -1;
                cVar3 = ExclusiveMonitorsStatus();
              }
            } while (cVar3 != '\0');
          }
          if (iVar20 < 1) {
            operator_delete((undefined *)(local_68[0] + -0x18));
          }
        }
        if ((undefined *)((long)local_80 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 00f3b104 to 0103b15f has its CatchHandler @ 00f3ac40 */
            iVar20 = *(int *)((long)local_80 + -8);
            *(int *)((long)local_80 + -8) = iVar20 + -1;
          }
          else {
            piVar19 = (int *)((long)local_80 + -8);
            do {
              iVar20 = *piVar19;
              cVar3 = '\x01';
              bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
              if (bVar4) {
                *piVar19 = iVar20 + -1;
                cVar3 = ExclusiveMonitorsStatus();
              }
            } while (cVar3 != '\0');
          }
          if (iVar20 < 1) {
            operator_delete((undefined *)((long)local_80 + -0x18));
          }
        }
      }
    }
    local_218 = (NinePatchImageParser *)local_68;
    this_01 = (Director *)Director::getInstance();
    pTVar11 = (Texture2D *)Director::getTextureCache(this_01);
    TextureCache::getTextureFilePath(pTVar11);
    NinePatchImageParser::NinePatchImageParser(local_218);
    plVar23 = *(long **)(lVar7 + 0x10);
    local_208 = (Image *)0x0;
    if (plVar23 != (long *)0x0) {
      do {
        while( true ) {
          p_Var10 = (_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                     *)cocos2d::Value::asValueMap((Value *)(plVar23 + 2));
          FUN_01214ee0((string *)&local_1c8,plVar23 + 1);
          this_00 = (_Hashtable<std::string,std::pair<std::string_const,cocos2d::SpriteFrame*>,std::allocator<std::pair<std::string_const,cocos2d::SpriteFrame*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                     *)(this + 0x28);
          lVar7 = std::
                  _Hashtable<std::string,std::pair<std::string_const,cocos2d::SpriteFrame*>,std::allocator<std::pair<std::string_const,cocos2d::SpriteFrame*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                  ::find(this_00,(string *)&local_1c8);
                    /* catch() { ... } // from try @ 00f3ac20 with catch @ 00f39a88 */
          if ((lVar7 == 0) || (*(long *)(lVar7 + 0x10) == 0)) break;
          puVar14 = (undefined *)(local_1c8 + -0x18);
          if (puVar14 != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) goto LAB_00f39eac;
            piVar19 = (int *)(local_1c8 + -8);
            do {
              iVar20 = *piVar19;
              cVar3 = '\x01';
              bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
              if (bVar4) {
                *piVar19 = iVar20 + -1;
                cVar3 = ExclusiveMonitorsStatus();
              }
            } while (cVar3 != '\0');
            goto LAB_00f39ba4;
          }
LAB_00f39a54:
          plVar23 = (long *)*plVar23;
          if (plVar23 == (long *)0x0) goto LAB_00f39bbc;
        }
        if (local_1fc == 0) {
          FUN_01211570((string *)&local_1c0,"x",(Size *)&local_80);
          pVVar8 = (Value *)std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[](p_Var10,(string *)&local_1c0);
          fVar24 = (float)cocos2d::Value::asFloat(pVVar8);
          if ((undefined *)(local_1c0 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_1c0 + -8);
              *(int *)(local_1c0 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_1c0 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
                    /* try { // try from 00f3a978 to 0103a98b has its CatchHandler @ 00f3ac40 */
              operator_delete((undefined *)(local_1c0 + -0x18));
            }
          }
          FUN_01211570((string *)&local_1b8,"y",(Size *)&local_80);
          pVVar8 = (Value *)std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[](p_Var10,(string *)&local_1b8);
          fVar25 = (float)cocos2d::Value::asFloat(pVVar8);
          if ((undefined *)(local_1b8 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_1b8 + -8);
                    /* catch() { ... } // from try @ 00f39b68 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f39f84 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a068 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a110 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a1a8 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a248 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a2e0 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a378 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a410 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a468 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a504 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a59c with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a5f4 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a65c with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a6b4 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a838 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a978 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3a9e0 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3aa48 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3aaa0 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3ab30 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3abc0 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3acb8 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3ad10 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3af14 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3b074 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3b104 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3b194 with catch @ 00f3ac40
                       catch() { ... } // from try @ 00f3b224 with catch @ 00f3ac40 */
              *(int *)(local_1b8 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_1b8 + -8);
              do {
                iVar20 = *piVar19;
                    /* try { // try from 00f3a930 to 0103a947 has its CatchHandler @ 00f3aee4 */
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_1b8 + -0x18));
            }
          }
          FUN_01211570((string *)&local_1b0,"width",(Size *)&local_80);
          pVVar8 = (Value *)std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[](p_Var10,(string *)&local_1b0);
          fVar26 = (float)cocos2d::Value::asFloat(pVVar8);
          if ((undefined *)(local_1b0 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_1b0 + -8);
                    /* catch() { ... } // from try @ 00f39f40 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a028 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a0d8 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a170 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a210 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a2a8 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a340 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a3d8 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a4cc with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a564 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a624 with catch @ 00f3ac30
                       catch() { ... } // from try @ 00f3a800 with catch @ 00f3ac30 */
              *(int *)(local_1b0 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_1b0 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_1b0 + -0x18));
            }
          }
          FUN_01211570((string *)&local_1a8,"height",(Size *)&local_80);
          pVVar8 = (Value *)std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[](p_Var10,(string *)&local_1a8);
          fVar27 = (float)cocos2d::Value::asFloat(pVVar8);
          if ((undefined *)(local_1a8 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_1a8 + -8);
              *(int *)(local_1a8 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_1a8 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_1a8 + -0x18));
            }
          }
          FUN_01211570((string *)&local_1a0,"offsetX",(Size *)&local_80);
          pVVar8 = (Value *)std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[](p_Var10,(string *)&local_1a0);
          uVar28 = cocos2d::Value::asFloat(pVVar8);
          if ((undefined *)(local_1a0 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_1a0 + -8);
                    /* try { // try from 00f3ac20 to 0103ac23 has its CatchHandler @ 00f39a88 */
              *(int *)(local_1a0 + -8) = iVar20 + -1;
                    /* catch() { ... } // from try @ 00f39aec with catch @ 00f3ac24 */
            }
            else {
              piVar19 = (int *)(local_1a0 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_1a0 + -0x18));
            }
          }
          FUN_01211570((string *)&local_198,"offsetY",(Size *)&local_80);
          pVVar8 = (Value *)std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[](p_Var10,(string *)&local_198);
          uVar29 = cocos2d::Value::asFloat(pVVar8);
          if ((undefined *)(local_198 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_198 + -8);
              *(int *)(local_198 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_198 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_198 + -0x18));
            }
          }
          FUN_01211570((string *)&local_190,"originalWidth",(Size *)&local_80);
          pVVar8 = (Value *)std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[](p_Var10,(string *)&local_190);
          uVar5 = cocos2d::Value::asInt(pVVar8);
          if ((undefined *)(local_190 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_190 + -8);
              *(int *)(local_190 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_190 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
                    /* try { // try from 00f3a838 to 0103a91b has its CatchHandler @ 00f3ac40 */
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_190 + -0x18));
            }
          }
          FUN_01211570((string *)&local_188,"originalHeight",(Size *)&local_80);
          pVVar8 = (Value *)std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[](p_Var10,(string *)&local_188);
          uVar6 = cocos2d::Value::asInt(pVVar8);
          if ((undefined *)(local_188 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_188 + -8);
              *(int *)(local_188 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_188 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
                    /* try { // try from 00f3a800 to 0103a80f has its CatchHandler @ 00f3ac30 */
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_188 + -0x18));
            }
          }
          Rect::Rect((Rect *)local_40,fVar24,fVar25,fVar26,fVar27);
          local_98 = (void *)CONCAT44(uVar29,uVar28);
          Size::Size((Size *)&local_80,
                     (float)(int)((uVar5 ^ (int)uVar5 >> 0x1f) - ((int)uVar5 >> 0x1f)),
                     (float)(int)((uVar6 ^ (int)uVar6 >> 0x1f) - ((int)uVar6 >> 0x1f)));
          this_02 = (SpriteFrame *)
                    SpriteFrame::createWithTexture
                              (param_2,(Size *)local_40,false,(Vec2 *)&local_98,(Size *)&local_80);
        }
        else if (local_1fc - 1U < 2) {
          FUN_01211570((string *)&local_180,"frame",(Vec2 *)&local_98);
                    /* try { // try from 00f39f40 to 01039f5b has its CatchHandler @ 00f3ac30 */
          std::__detail::
          _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[](p_Var10,(string *)&local_180);
          cocos2d::Value::asString();
          RectFromString((cocos2d *)&local_178,extraout_x1_00);
          if ((undefined *)(local_178 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f3abac to 0103abaf has its CatchHandler @ 00f3abd4 */
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_178 + -8);
              *(int *)(local_178 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_178 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
                    /* try { // try from 00f3abc0 to 0103abcf has its CatchHandler @ 00f3ac40 */
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_178 + -0x18));
                    /* catch() { ... } // from try @ 00f3abac with catch @ 00f3abd4 */
            }
          }
                    /* try { // try from 00f39f84 to 01039fb3 has its CatchHandler @ 00f3ac40 */
          if ((undefined *)(local_180 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_180 + -8);
              *(int *)(local_180 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_180 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_180 + -0x18));
            }
          }
          local_1f0 = false;
          if (local_1fc == 2) {
            FUN_01211570((string *)&local_170,"rotated",(Vec2 *)&local_98);
                    /* try { // try from 00f3a9a0 to 0103a9b7 has its CatchHandler @ 00f3aee0 */
            pVVar8 = (Value *)std::__detail::
                              _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                              ::operator[](p_Var10,(string *)&local_170);
            local_1f0 = (bool)cocos2d::Value::asBool(pVVar8);
            if ((undefined *)(local_170 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_170 + -8);
                *(int *)(local_170 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_170 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                    /* try { // try from 00f3a9e0 to 0103a9f3 has its CatchHandler @ 00f3ac40 */
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_170 + -0x18));
              }
            }
          }
          FUN_01211570((string *)&local_168,"offset",&local_b0);
          std::__detail::
          _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[](p_Var10,(string *)&local_168);
          cocos2d::Value::asString();
          PointFromString((cocos2d *)&local_160,extraout_x1_01);
          if ((undefined *)(local_160 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_160 + -8);
              *(int *)(local_160 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_160 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_160 + -0x18));
            }
          }
          if ((undefined *)(local_168 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_168 + -8);
              *(int *)(local_168 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_168 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_168 + -0x18));
            }
          }
          FUN_01211570((string *)&local_158,"sourceSize",&local_c0);
                    /* try { // try from 00f3a028 to 0103a037 has its CatchHandler @ 00f3ac30 */
          std::__detail::
          _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[](p_Var10,(string *)&local_158);
          cocos2d::Value::asString();
          SizeFromString((cocos2d *)&local_150,extraout_x1_02);
          if ((undefined *)(local_150 + -0x18) != PTR_DAT_017191c0) {
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_150 + -8);
              *(int *)(local_150 + -8) = iVar20 + -1;
                    /* try { // try from 00f3b0f0 to 0103b0f3 has its CatchHandler @ 00f3b240 */
            }
            else {
              piVar19 = (int *)(local_150 + -8);
              do {
                iVar20 = *piVar19;
                    /* try { // try from 00f3ab1c to 0103ab1f has its CatchHandler @ 00f3ac80 */
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
                    /* try { // try from 00f3ab30 to 0103ab8b has its CatchHandler @ 00f3ac40 */
              operator_delete((undefined *)(local_150 + -0x18));
            }
          }
                    /* try { // try from 00f3a068 to 0103a07b has its CatchHandler @ 00f3ac40 */
          if ((undefined *)(local_158 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f3aaa0 to 0103aafb has its CatchHandler @ 00f3ac40 */
            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
              iVar20 = *(int *)(local_158 + -8);
              *(int *)(local_158 + -8) = iVar20 + -1;
            }
            else {
              piVar19 = (int *)(local_158 + -8);
              do {
                iVar20 = *piVar19;
                cVar3 = '\x01';
                bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                if (bVar4) {
                  *piVar19 = iVar20 + -1;
                  cVar3 = ExclusiveMonitorsStatus();
                }
              } while (cVar3 != '\0');
            }
            if (iVar20 < 1) {
              operator_delete((undefined *)(local_158 + -0x18));
            }
          }
                    /* try { // try from 00f3a090 to 0103a093 has its CatchHandler @ 00f3ac5c */
          this_02 = (SpriteFrame *)
                    SpriteFrame::createWithTexture
                              (param_2,(Size *)local_40,local_1f0,(Vec2 *)&local_98,
                               (Size *)&local_80);
        }
        else {
          this_02 = (SpriteFrame *)0x0;
          if (local_1fc == 3) {
            FUN_01211570((string *)&local_148,"spriteSize",(Size *)&local_80);
            std::__detail::
            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
            ::operator[](p_Var10,(string *)&local_148);
            cocos2d::Value::asString();
                    /* try { // try from 00f3a0d8 to 0103a0e7 has its CatchHandler @ 00f3ac30 */
            SizeFromString((cocos2d *)&local_140,extraout_x1_03);
            if ((undefined *)(local_140 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f3acb8 to 0103acdb has its CatchHandler @ 00f3ac40 */
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_140 + -8);
                *(int *)(local_140 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_140 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_140 + -0x18));
              }
            }
            if ((undefined *)(local_148 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 00f3b194 to 0103b1ef has its CatchHandler @ 00f3ac40 */
                iVar20 = *(int *)(local_148 + -8);
                *(int *)(local_148 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_148 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_148 + -0x18));
              }
            }
                    /* try { // try from 00f3a110 to 0103a123 has its CatchHandler @ 00f3ac40 */
            FUN_01211570((string *)&local_138,"spriteOffset",(Size *)&local_80);
            std::__detail::
            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
            ::operator[](p_Var10,(string *)&local_138);
                    /* try { // try from 00f3a138 to 0103a14f has its CatchHandler @ 00f3ac6c */
            cocos2d::Value::asString();
            PointFromString((cocos2d *)&local_130,extraout_x1_04);
            if ((undefined *)(local_130 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00f3acfc with catch @ 00f3ad98 */
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_130 + -8);
                *(int *)(local_130 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_130 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_130 + -0x18));
              }
            }
                    /* try { // try from 00f3a170 to 0103a17f has its CatchHandler @ 00f3ac30 */
            if ((undefined *)(local_138 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_138 + -8);
                *(int *)(local_138 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_138 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
                    /* catch() { ... } // from try @ 00f3ad6c with catch @ 00f3ae1c */
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_138 + -0x18));
              }
            }
            FUN_01211570((string *)&local_128,"spriteSourceSize",(Size *)&local_80);
            std::__detail::
            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
            ::operator[](p_Var10,(string *)&local_128);
                    /* try { // try from 00f3a1a8 to 0103a1bb has its CatchHandler @ 00f3ac40 */
            cocos2d::Value::asString();
            SizeFromString((cocos2d *)&local_c0,extraout_x1_05);
                    /* try { // try from 00f3a1d0 to 0103a1e7 has its CatchHandler @ 00f3ac4c */
            if ((undefined *)(local_c0 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_c0 + -8);
                *(int *)(local_c0 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_c0 + -8);
                do {
                  iVar20 = *piVar19;
                    /* try { // try from 00f3acfc to 0103acff has its CatchHandler @ 00f3ad98 */
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                    /* try { // try from 00f3ad10 to 0103ad4b has its CatchHandler @ 00f3ac40 */
                operator_delete((undefined *)(local_c0 + -0x18));
              }
            }
            if ((undefined *)(local_128 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_128 + -8);
                *(int *)(local_128 + -8) = iVar20 + -1;
                    /* try { // try from 00f3b180 to 0103b183 has its CatchHandler @ 00f3b23c */
              }
              else {
                piVar19 = (int *)(local_128 + -8);
                do {
                    /* try { // try from 00f3ad6c to 0103ae17 has its CatchHandler @ 00f3ae1c */
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_128 + -0x18));
              }
            }
            FUN_01211570((string *)&local_120,"textureRect",(Size *)&local_80);
            std::__detail::
            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
            ::operator[](p_Var10,(string *)&local_120);
                    /* try { // try from 00f3a210 to 0103a21f has its CatchHandler @ 00f3ac30 */
            cocos2d::Value::asString();
            RectFromString((cocos2d *)&local_118,extraout_x1_06);
            if ((undefined *)(local_118 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_118 + -8);
                *(int *)(local_118 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_118 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_118 + -0x18));
              }
            }
                    /* try { // try from 00f3a248 to 0103a25b has its CatchHandler @ 00f3ac40 */
            if ((undefined *)(local_120 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_120 + -8);
                *(int *)(local_120 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_120 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_120 + -0x18));
              }
            }
            FUN_01211570((string *)&local_110,"textureRotated",(Size *)&local_80);
            pVVar8 = (Value *)std::__detail::
                              _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                              ::operator[](p_Var10,(string *)&local_110);
                    /* try { // try from 00f3a270 to 0103a287 has its CatchHandler @ 00f3aeec */
            bVar4 = (bool)cocos2d::Value::asBool(pVVar8);
            if ((undefined *)(local_110 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00f3a308 with catch @ 00f3ac7c */
                    /* catch() { ... } // from try @ 00f3ab1c with catch @ 00f3ac80 */
                    /* catch() { ... } // from try @ 00f3aa08 with catch @ 00f3ac84 */
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_110 + -8);
                *(int *)(local_110 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_110 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar1 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar1) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_110 + -0x18));
              }
            }
            FUN_01211570((string *)&local_108,"aliases",(Size *)&local_80);
                    /* try { // try from 00f3a2a8 to 0103a2b7 has its CatchHandler @ 00f3ac30 */
            pVVar8 = (Value *)std::__detail::
                              _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                              ::operator[](p_Var10,(string *)&local_108);
            plVar15 = (long *)cocos2d::Value::asValueVector(pVVar8);
            if ((undefined *)(local_108 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00f3a6a0 with catch @ 00f3ac48 */
                    /* catch() { ... } // from try @ 00f3a1d0 with catch @ 00f3ac4c */
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_108 + -8);
                *(int *)(local_108 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_108 + -8);
                do {
                  iVar20 = *piVar19;
                    /* catch() { ... } // from try @ 00f3a090 with catch @ 00f3ac5c */
                  cVar3 = '\x01';
                  bVar1 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar1) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
                    /* catch() { ... } // from try @ 00f3a138 with catch @ 00f3ac6c */
              if (iVar20 < 1) {
                    /* catch() { ... } // from try @ 00f3a52c with catch @ 00f3ac70 */
                    /* catch() { ... } // from try @ 00f3a454 with catch @ 00f3ac74 */
                operator_delete((undefined *)(local_108 + -0x18));
                    /* catch() { ... } // from try @ 00f3a3a0 with catch @ 00f3ac78 */
              }
            }
            lVar16 = plVar15[1];
            lVar9 = local_150;
            lVar2 = local_c0;
                    /* try { // try from 00f3a2e0 to 0103a2f3 has its CatchHandler @ 00f3ac40 */
            for (lVar7 = *plVar15; lVar7 != lVar16; lVar7 = lVar7 + 0x10) {
              local_150 = lVar9;
              local_c0 = lVar2;
              cocos2d::Value::asString();
                    /* try { // try from 00f3a308 to 0103a31f has its CatchHandler @ 00f3ac7c */
              std::
              _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
              ::find((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                      *)(this + 0x60),(string *)&local_80);
              pVVar8 = (Value *)std::__detail::
                                _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                              *)(this + 0x60),(string *)&local_80);
              cocos2d::Value::Value((Value *)local_40,(string *)&local_1c8);
              cocos2d::Value::operator=(pVVar8,(Value *)local_40);
                    /* try { // try from 00f3a340 to 0103a34f has its CatchHandler @ 00f3ac30 */
              cocos2d::Value::~Value((Value *)local_40);
              if ((undefined *)((long)local_80 + -0x18) != PTR_DAT_017191c0) {
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                  iVar20 = *(int *)((long)local_80 + -8);
                  *(int *)((long)local_80 + -8) = iVar20 + -1;
                }
                else {
                  piVar19 = (int *)((long)local_80 + -8);
                  do {
                    iVar20 = *piVar19;
                    cVar3 = '\x01';
                    bVar1 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                    if (bVar1) {
                      *piVar19 = iVar20 + -1;
                      cVar3 = ExclusiveMonitorsStatus();
                    }
                    /* try { // try from 00f3a378 to 0103a38b has its CatchHandler @ 00f3ac40 */
                  } while (cVar3 != '\0');
                }
                if (iVar20 < 1) {
                  operator_delete((undefined *)((long)local_80 + -0x18));
                }
              }
              lVar9 = local_150;
              lVar2 = local_c0;
            }
                    /* try { // try from 00f3a3a0 to 0103a3b7 has its CatchHandler @ 00f3ac78 */
            local_c0._0_4_ = (float)lVar2;
            local_c0._4_4_ = (float)((ulong)lVar2 >> 0x20);
            local_150._0_4_ = (float)lVar9;
            local_150._4_4_ = (float)((ulong)lVar9 >> 0x20);
            Rect::Rect((Rect *)local_40,(float)local_c0,local_c0._4_4_,(float)local_150,
                       local_150._4_4_);
            local_c0 = lVar2;
            local_150 = lVar9;
            this_02 = (SpriteFrame *)
                      SpriteFrame::createWithTexture
                                (param_2,(Size *)local_40,bVar4,(Vec2 *)&local_140,
                                 (Size *)&local_130);
                    /* try { // try from 00f3a3d8 to 0103a3e7 has its CatchHandler @ 00f3ac30 */
            FUN_01211570((string *)&local_100,"vertices",(Size *)&local_80);
            lVar7 = std::
                    _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                    ::find((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                            *)p_Var10,(string *)&local_100);
                    /* try { // try from 00f3a410 to 0103a433 has its CatchHandler @ 00f3ac40 */
            if ((undefined *)(local_100 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)(local_100 + -8);
                *(int *)(local_100 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)(local_100 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)(local_100 + -0x18));
              }
            }
            if (lVar7 != 0) {
              local_b0 = (void *)0x0;
              local_a8 = 0;
              local_a0 = 0;
              FUN_01211570((string *)&local_f8,"vertices",(Size *)&local_80);
                    /* try { // try from 00f3a454 to 0103a457 has its CatchHandler @ 00f3ac74 */
              std::__detail::
              _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
              ::operator[](p_Var10,(string *)&local_f8);
              cocos2d::Value::asString();
                    /* try { // try from 00f3a468 to 0103a477 has its CatchHandler @ 00f3ac40 */
              parseIntegerList(this,(string *)&local_f0,(vector *)&local_b0);
              if ((undefined *)(local_f0 + -0x18) != PTR_DAT_017191c0) {
                piVar19 = (int *)(local_f0 + -8);
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                  iVar20 = *(int *)(local_f0 + -8);
                  *(int *)(local_f0 + -8) = iVar20 + -1;
                }
                else {
                  do {
                    iVar20 = *piVar19;
                    cVar3 = '\x01';
                    bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                    if (bVar4) {
                      *piVar19 = iVar20 + -1;
                      cVar3 = ExclusiveMonitorsStatus();
                    }
                  } while (cVar3 != '\0');
                }
                if (iVar20 < 1) {
                  operator_delete((undefined *)(local_f0 + -0x18));
                }
              }
              local_1e8 = (vector *)&local_b0;
              if ((undefined *)(local_f8 + -0x18) != PTR_DAT_017191c0) {
                piVar19 = (int *)(local_f8 + -8);
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                  iVar20 = *(int *)(local_f8 + -8);
                  *(int *)(local_f8 + -8) = iVar20 + -1;
                    /* try { // try from 00f3b210 to 0103b213 has its CatchHandler @ 00f3b244 */
                }
                else {
                  do {
                    iVar20 = *piVar19;
                    cVar3 = '\x01';
                    bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                    if (bVar4) {
                      *piVar19 = iVar20 + -1;
                      cVar3 = ExclusiveMonitorsStatus();
                    }
                  } while (cVar3 != '\0');
                }
                if (iVar20 < 1) {
                  operator_delete((undefined *)(local_f8 + -0x18));
                }
              }
              local_98 = (void *)0x0;
              local_90 = 0;
              local_88 = 0;
              FUN_01211570((string *)&local_e8,"verticesUV",(Size *)&local_80);
                    /* try { // try from 00f3a4cc to 0103a4db has its CatchHandler @ 00f3ac30 */
              std::__detail::
              _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
              ::operator[](p_Var10,(string *)&local_e8);
              cocos2d::Value::asString();
              parseIntegerList(this,(string *)&local_e0,(vector *)&local_98);
                    /* try { // try from 00f3a504 to 0103a517 has its CatchHandler @ 00f3ac40 */
              if ((undefined *)(local_e0 + -0x18) != PTR_DAT_017191c0) {
                piVar19 = (int *)(local_e0 + -8);
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* catch() { ... } // from try @ 00f3b210 with catch @ 00f3b244 */
                  iVar20 = *(int *)(local_e0 + -8);
                  *(int *)(local_e0 + -8) = iVar20 + -1;
                }
                else {
                  do {
                    iVar20 = *piVar19;
                    cVar3 = '\x01';
                    bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                    if (bVar4) {
                      *piVar19 = iVar20 + -1;
                      cVar3 = ExclusiveMonitorsStatus();
                    }
                  } while (cVar3 != '\0');
                }
                if (iVar20 < 1) {
                  operator_delete((undefined *)(local_e0 + -0x18));
                }
              }
              if ((undefined *)(local_e8 + -0x18) != PTR_DAT_017191c0) {
                piVar19 = (int *)(local_e8 + -8);
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                  iVar20 = *(int *)(local_e8 + -8);
                  *(int *)(local_e8 + -8) = iVar20 + -1;
                }
                else {
                  do {
                    iVar20 = *piVar19;
                    /* catch() { ... } // from try @ 00f3aa8c with catch @ 00f3aedc */
                    /* catch() { ... } // from try @ 00f3a9a0 with catch @ 00f3aee0 */
                    cVar3 = '\x01';
                    bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                    if (bVar4) {
                      *piVar19 = iVar20 + -1;
                      cVar3 = ExclusiveMonitorsStatus();
                    }
                    /* catch() { ... } // from try @ 00f3a930 with catch @ 00f3aee4 */
                  } while (cVar3 != '\0');
                }
                    /* catch() { ... } // from try @ 00f3a5e0 with catch @ 00f3aee8 */
                    /* catch() { ... } // from try @ 00f3a270 with catch @ 00f3aeec */
                if (iVar20 < 1) {
                  operator_delete((undefined *)(local_e8 + -0x18));
                }
              }
                    /* try { // try from 00f3a52c to 0103a543 has its CatchHandler @ 00f3ac70 */
              local_80 = (void *)0x0;
              local_78 = 0;
              local_70 = 0;
              FUN_01211570((string *)&local_d8,"triangles",(string *)&local_e0);
              std::__detail::
              _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
              ::operator[](p_Var10,(string *)&local_d8);
              cocos2d::Value::asString();
                    /* try { // try from 00f3a564 to 0103a573 has its CatchHandler @ 00f3ac30 */
              parseIntegerList(this,(string *)&local_d0,(vector *)&local_80);
              if ((undefined *)(local_d0 + -0x18) != PTR_DAT_017191c0) {
                piVar19 = (int *)(local_d0 + -8);
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 00f3b224 to 0103b233 has its CatchHandler @ 00f3ac40 */
                  iVar20 = *(int *)(local_d0 + -8);
                  *(int *)(local_d0 + -8) = iVar20 + -1;
                }
                else {
                  do {
                    iVar20 = *piVar19;
                    cVar3 = '\x01';
                    bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                    if (bVar4) {
                      *piVar19 = iVar20 + -1;
                      cVar3 = ExclusiveMonitorsStatus();
                    }
                  } while (cVar3 != '\0');
                }
                if (iVar20 < 1) {
                  operator_delete((undefined *)(local_d0 + -0x18));
                }
              }
                    /* try { // try from 00f3a59c to 0103a5bf has its CatchHandler @ 00f3ac40 */
              if ((undefined *)(local_d8 + -0x18) != PTR_DAT_017191c0) {
                piVar19 = (int *)(local_d8 + -8);
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                  iVar20 = *(int *)(local_d8 + -8);
                    /* catch() { ... } // from try @ 00f3b060 with catch @ 00f3b238 */
                    /* catch() { ... } // from try @ 00f3b180 with catch @ 00f3b23c */
                  *(int *)(local_d8 + -8) = iVar20 + -1;
                    /* catch() { ... } // from try @ 00f3b0f0 with catch @ 00f3b240 */
                }
                else {
                  do {
                    iVar20 = *piVar19;
                    /* try { // try from 00f3af14 to 0103b03f has its CatchHandler @ 00f3ac40 */
                    cVar3 = '\x01';
                    bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                    if (bVar4) {
                      *piVar19 = iVar20 + -1;
                      cVar3 = ExclusiveMonitorsStatus();
                    }
                  } while (cVar3 != '\0');
                }
                if (iVar20 < 1) {
                  operator_delete((undefined *)(local_d8 + -0x18));
                }
              }
              PolygonInfo::PolygonInfo((PolygonInfo *)local_40);
              initializePolygonInfo
                        (this,aSStack_1d8,(Size *)&local_130,local_1e8,(vector *)&local_98,
                         (vector *)&local_80,(PolygonInfo *)local_40);
              SpriteFrame::setPolygonInfo(this_02,(PolygonInfo *)local_40);
              PolygonInfo::~PolygonInfo((PolygonInfo *)local_40);
                    /* try { // try from 00f3a5e0 to 0103a5e3 has its CatchHandler @ 00f3aee8 */
              if (local_80 != (void *)0x0) {
                operator_delete(local_80);
              }
              if (local_98 != (void *)0x0) {
                    /* try { // try from 00f3a5f4 to 0103a603 has its CatchHandler @ 00f3ac40 */
                operator_delete(local_98);
              }
              if (local_b0 != (void *)0x0) {
                operator_delete(local_b0);
              }
            }
            local_1e8 = (vector *)&local_b0;
            FUN_01211570(local_1e8,"anchor",(Size *)&local_80);
                    /* try { // try from 00f3a624 to 0103a633 has its CatchHandler @ 00f3ac30 */
            lVar7 = std::
                    _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                    ::find((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                            *)p_Var10,(string *)local_1e8);
            if ((undefined *)((long)local_b0 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar20 = *(int *)((long)local_b0 + -8);
                *(int *)((long)local_b0 + -8) = iVar20 + -1;
              }
              else {
                piVar19 = (int *)((long)local_b0 + -8);
                do {
                  iVar20 = *piVar19;
                  cVar3 = '\x01';
                  bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                  if (bVar4) {
                    *piVar19 = iVar20 + -1;
                    cVar3 = ExclusiveMonitorsStatus();
                  }
                } while (cVar3 != '\0');
              }
              if (iVar20 < 1) {
                operator_delete((undefined *)((long)local_b0 + -0x18));
              }
            }
            if (lVar7 != 0) {
                    /* try { // try from 00f3a65c to 0103a67f has its CatchHandler @ 00f3ac40 */
              FUN_01211570((string *)&local_98,"anchor",local_1e8);
              std::__detail::
              _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
              ::operator[](p_Var10,(string *)&local_98);
              cocos2d::Value::asString();
              PointFromString((cocos2d *)&local_80,extraout_x1_07);
              SpriteFrame::setAnchorPoint(this_02,(Vec2 *)local_40);
                    /* try { // try from 00f3a6a0 to 0103a6a3 has its CatchHandler @ 00f3ac48 */
              if ((undefined *)((long)local_80 + -0x18) != PTR_DAT_017191c0) {
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                  iVar20 = *(int *)((long)local_80 + -8);
                  *(int *)((long)local_80 + -8) = iVar20 + -1;
                }
                else {
                  piVar19 = (int *)((long)local_80 + -8);
                  do {
                    iVar20 = *piVar19;
                    cVar3 = '\x01';
                    bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                    if (bVar4) {
                      *piVar19 = iVar20 + -1;
                      cVar3 = ExclusiveMonitorsStatus();
                    }
                  } while (cVar3 != '\0');
                }
                if (iVar20 < 1) {
                  operator_delete((undefined *)((long)local_80 + -0x18));
                }
              }
                    /* try { // try from 00f3a6b4 to 0103a7df has its CatchHandler @ 00f3ac40 */
              if ((undefined *)((long)local_98 + -0x18) != PTR_DAT_017191c0) {
                if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                  iVar20 = *(int *)((long)local_98 + -8);
                  *(int *)((long)local_98 + -8) = iVar20 + -1;
                }
                else {
                  piVar19 = (int *)((long)local_98 + -8);
                  do {
                    iVar20 = *piVar19;
                    cVar3 = '\x01';
                    bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
                    if (bVar4) {
                      *piVar19 = iVar20 + -1;
                      cVar3 = ExclusiveMonitorsStatus();
                    }
                  } while (cVar3 != '\0');
                }
                if (iVar20 < 1) {
                  operator_delete((undefined *)((long)local_98 + -0x18));
                }
              }
            }
          }
        }
        cVar3 = NinePatchImageParser::isNinePatchImage((string *)&local_1c8);
        if (cVar3 != '\0') {
          if (local_208 == (Image *)0x0) {
            local_208 = operator_new(0x160,(nothrow_t *)PTR_nothrow_01717628);
            if (local_208 != (Image *)0x0) {
              Image::Image(local_208);
            }
            Image::initWithImageFile(local_208,(string *)&local_1d0);
          }
          NinePatchImageParser::setSpriteFrameInfo
                    (local_218,local_208,(Rect *)(this_02 + 0x48),(bool)this_02[0x58]);
          NinePatchImageParser::parseCapInset();
                    /* try { // try from 00f39aec to 01039b37 has its CatchHandler @ 00f3ac24 */
          Texture2D::addSpriteFrameCapInset(param_2,this_02,(Rect *)local_40);
        }
        local_c8 = this_02;
        cocos2d::Ref::retain((Ref *)this_02);
        p_Var12 = (_Hash_node *)
                  std::
                  _Hashtable<std::string,std::pair<std::string_const,cocos2d::SpriteFrame*>,std::allocator<std::pair<std::string_const,cocos2d::SpriteFrame*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                  ::find(this_00,(string *)&local_1c8);
        if (p_Var12 != (_Hash_node *)0x0) {
          cocos2d::Ref::release(*(Ref **)(p_Var12 + 0x10));
          uVar17 = *(ulong *)(this + 0x30);
          uVar18 = 0;
          if (uVar17 != 0) {
            uVar18 = *(ulong *)(p_Var12 + 0x18) / uVar17;
          }
          uVar18 = *(ulong *)(p_Var12 + 0x18) - uVar18 * uVar17;
          p_Var13 = *(_Hash_node_base **)(*(long *)(this + 0x28) + uVar18 * 8);
          do {
            p_Var22 = p_Var13;
            p_Var13 = *(_Hash_node_base **)p_Var22;
          } while (p_Var12 != (_Hash_node *)p_Var13);
          std::
          _Hashtable<std::string,std::pair<std::string_const,cocos2d::SpriteFrame*>,std::allocator<std::pair<std::string_const,cocos2d::SpriteFrame*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
          ::_M_erase(this_00,uVar18,p_Var22,p_Var12);
        }
                    /* try { // try from 00f39b68 to 01039e63 has its CatchHandler @ 00f3ac40 */
        std::
        _Hashtable<std::string,std::pair<std::string_const,cocos2d::SpriteFrame*>,std::allocator<std::pair<std::string_const,cocos2d::SpriteFrame*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
        ::_M_emplace<std::string_const&,cocos2d::SpriteFrame*&>
                  (this_00,0,(string *)&local_1c8,&local_c8);
        puVar14 = (undefined *)(local_1c8 + -0x18);
        if (puVar14 == PTR_DAT_017191c0) goto LAB_00f39a54;
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
LAB_00f39eac:
          iVar20 = *(int *)(local_1c8 + -8);
          *(int *)(local_1c8 + -8) = iVar20 + -1;
        }
        else {
          piVar19 = (int *)(local_1c8 + -8);
          do {
            iVar20 = *piVar19;
            cVar3 = '\x01';
            bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
            if (bVar4) {
              *piVar19 = iVar20 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
LAB_00f39ba4:
        if (0 < iVar20) goto LAB_00f39a54;
        operator_delete(puVar14);
        plVar23 = (long *)*plVar23;
      } while (plVar23 != (long *)0x0);
LAB_00f39bbc:
      if (local_208 != (Image *)0x0) {
        (**(code **)(*(long *)local_208 + 8))();
      }
    }
    NinePatchImageParser::~NinePatchImageParser(local_218);
    if ((undefined *)(local_1d0 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar20 = *(int *)(local_1d0 + -8);
        *(int *)(local_1d0 + -8) = iVar20 + -1;
                    /* try { // try from 00f3b060 to 0103b063 has its CatchHandler @ 00f3b238 */
      }
      else {
        piVar19 = (int *)(local_1d0 + -8);
        do {
          iVar20 = *piVar19;
          cVar3 = '\x01';
          bVar4 = (bool)ExclusiveMonitorPass(piVar19,0x10);
          if (bVar4) {
            *piVar19 = iVar20 + -1;
            cVar3 = ExclusiveMonitorsStatus();
          }
        } while (cVar3 != '\0');
      }
      if (iVar20 < 1) {
        operator_delete((undefined *)(local_1d0 + -0x18));
      }
    }
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* catch() { ... } // from try @ 00f3981c with catch @ 00f3980c
                       catch() { ... } // from try @ 00f39870 with catch @ 00f3980c */
                    /* try { // try from 00f3981c to 0103981f has its CatchHandler @ 00f3980c */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === setupTiles @ 00f3e5d4 === */

/* cocos2d::TMXLayer::setupTiles() */

void __thiscall cocos2d::TMXLayer::setupTiles(TMXLayer *this)

{
  uint uVar1;
  int iVar2;
  Texture2D *pTVar3;
  Size *pSVar4;
  int iVar5;
  long lVar6;
  int iVar7;
  int iVar8;
  float fVar9;
  float fVar10;
  float fVar11;
  float local_10;
  float local_c;
  long local_8;
  
  lVar6 = *(long *)(this + 0x420);
                    /* try { // try from 00f3e600 to 0103e603 has its CatchHandler @ 00f40080 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  pTVar3 = (Texture2D *)TextureAtlas::getTexture(*(TextureAtlas **)(this + 0x338));
  pSVar4 = (Size *)Texture2D::getContentSizeInPixels(pTVar3);
  Size::operator=((Size *)(lVar6 + 0x58),pSVar4);
                    /* try { // try from 00f3e624 to 0103e627 has its CatchHandler @ 00f40260 */
  pTVar3 = (Texture2D *)TextureAtlas::getTexture(*(TextureAtlas **)(this + 0x338));
  Texture2D::setAliasTexParameters(pTVar3);
  parseInternalProperties(this);
  fVar9 = *(float *)(this + 0x408);
  if (0.0 < fVar9) {
    fVar11 = 0.0;
    iVar7 = 0;
    fVar10 = *(float *)(this + 0x404);
    do {
      if (0.0 < fVar10) {
        fVar9 = 0.0;
        iVar8 = 1;
                    /* try { // try from 00f3e670 to 0103e693 has its CatchHandler @ 00f3ffec */
        iVar5 = 0;
        do {
          while( true ) {
            iVar2 = iVar5;
            if (*(long *)(this + 0x428) == 1) {
              if (*(int *)(this + 0x430) == 0) {
                iVar2 = iVar5 << 1;
                if (fVar10 * 0.5 <= fVar9) {
                  iVar2 = (int)((fVar9 - (float)(int)(fVar10 * 0.5)) * 2.0 + 1.0);
                }
              }
              else {
                iVar2 = iVar8;
                if ((int)(fVar10 * 0.5) <= iVar5) {
                  iVar2 = (iVar5 - (int)(fVar10 * 0.5)) * 2;
                }
              }
            }
                    /* try { // try from 00f3e69c to 0103e69f has its CatchHandler @ 00f3fd94 */
                    /* try { // try from 00f3e6a4 to 0103e6a7 has its CatchHandler @ 00f402dc */
            uVar1 = *(uint *)(*(long *)(this + 0x418) +
                             (long)(int)((float)iVar2 + fVar10 * fVar11) * 4);
            if (uVar1 == 0) break;
            iVar5 = iVar5 + 1;
            iVar8 = iVar8 + 2;
            local_10 = (float)iVar2;
            local_c = fVar11;
            appendTileForGID(this,uVar1,(Vec2 *)&local_10);
            fVar9 = (float)iVar5;
            fVar10 = *(float *)(this + 0x404);
            if (fVar10 <= fVar9) goto LAB_00f3e6e0;
          }
          iVar5 = iVar5 + 1;
          iVar8 = iVar8 + 2;
          fVar9 = (float)iVar5;
        } while (fVar9 < fVar10);
LAB_00f3e6e0:
        fVar9 = *(float *)(this + 0x408);
      }
      iVar7 = iVar7 + 1;
      fVar11 = (float)iVar7;
    } while (fVar11 < fVar9);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === buildWithMapInfo @ 00f3f984 === */

/* cocos2d::TMXTiledMap::buildWithMapInfo(cocos2d::TMXMapInfo*) */

void __thiscall cocos2d::TMXTiledMap::buildWithMapInfo(TMXTiledMap *this,TMXMapInfo *param_1)

{
  long *plVar1;
  float *pfVar2;
  Size *pSVar3;
  long lVar4;
  undefined8 *puVar5;
  ulong uVar6;
  undefined8 *puVar7;
  undefined8 *puVar8;
  int iVar9;
  ulong uVar10;
  float fVar11;
  float fVar12;
  float local_10;
  float local_c;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  Size::operator=((Size *)(this + 0x330),(Size *)(param_1 + 0x40));
  Size::operator=((Size *)(this + 0x338),(Size *)(param_1 + 0x48));
  *(undefined4 *)(this + 0x340) = *(undefined4 *)(param_1 + 0x30);
  if (this + 0x348 != (TMXTiledMap *)(param_1 + 0x80)) {
    puVar7 = *(undefined8 **)(this + 0x350);
    puVar8 = *(undefined8 **)(this + 0x348);
    if (*(undefined8 **)(this + 0x348) != puVar7) {
      do {
        puVar5 = puVar8 + 1;
        cocos2d::Ref::release((Ref *)*puVar8);
        puVar8 = puVar5;
      } while (puVar7 != puVar5);
      puVar7 = *(undefined8 **)(this + 0x348);
    }
    *(undefined8 **)(this + 0x350) = puVar7;
    lVar4 = *(long *)(param_1 + 0x80);
    uVar6 = *(long *)(param_1 + 0x88) - lVar4;
    uVar10 = (long)uVar6 >> 3;
    if ((ulong)(*(long *)(this + 0x358) - (long)puVar7 >> 3) < uVar10) {
      puVar7 = (undefined8 *)0x0;
      if (uVar10 != 0) {
        if (0x1fffffffffffffff < uVar10) {
                    /* WARNING: Subroutine does not return */
          FUN_0120f0e8();
        }
        puVar7 = operator_new(uVar6);
        if (uVar10 != 0) {
                    /* try { // try from 00f3fbcc to 0103fbdf has its CatchHandler @ 00f3ffec */
          memmove(puVar7,lVar4,uVar6);
        }
      }
      if (*(void **)(this + 0x348) != (void *)0x0) {
        operator_delete(*(void **)(this + 0x348));
      }
      *(undefined8 **)(this + 0x348) = puVar7;
      puVar8 = (undefined8 *)((long)puVar7 + uVar6);
      *(undefined8 **)(this + 0x358) = puVar8;
    }
    else {
      if (uVar10 != 0) {
        memmove(puVar7,lVar4,uVar6);
        puVar7 = *(undefined8 **)(this + 0x348);
      }
      puVar8 = (undefined8 *)((long)puVar7 + uVar6);
    }
    *(undefined8 **)(this + 0x350) = puVar8;
    for (; puVar7 != puVar8; puVar7 = puVar7 + 1) {
      cocos2d::Ref::retain((Ref *)*puVar7);
    }
  }
  iVar9 = 0;
  std::
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  ::operator=((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
               *)(this + 0x360),(_Hashtable *)(param_1 + 0xa8));
                    /* try { // try from 00f3fa68 to 0103fa6b has its CatchHandler @ 00f3fd3c */
  std::
  _Hashtable<int,std::pair<int_const,cocos2d::Value>,std::allocator<std::pair<int_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<int>,std::hash<int>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
  ::operator=((_Hashtable<int,std::pair<int_const,cocos2d::Value>,std::allocator<std::pair<int_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<int>,std::hash<int>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
               *)(this + 0x398),(_Hashtable *)(param_1 + 0x100));
                    /* try { // try from 00f3fa70 to 0103fa73 has its CatchHandler @ 00f40378 */
  puVar8 = *(undefined8 **)(param_1 + 0x58);
  puVar7 = *(undefined8 **)(param_1 + 0x50);
  do {
    while( true ) {
      if (puVar8 == puVar7) {
        *(int *)(this + 0x3d8) = iVar9;
        if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
          return;
        }
                    /* WARNING: Subroutine does not return */
        __stack_chk_fail();
      }
      if (((TMXLayerInfo *)*puVar7)[0x78] != (TMXLayerInfo)0x0) break;
LAB_00f3fa84:
      puVar7 = puVar7 + 1;
    }
    plVar1 = (long *)parseLayer(this,(TMXLayerInfo *)*puVar7,param_1);
    if (plVar1 == (long *)0x0) {
      iVar9 = iVar9 + 1;
      goto LAB_00f3fa84;
    }
    (**(code **)(*(long *)this + 0x220))(this,plVar1,iVar9,iVar9);
    pfVar2 = (float *)(**(code **)(*plVar1 + 0x170))(plVar1);
    pSVar3 = (Size *)(**(code **)(*(long *)this + 0x170))(this);
    Size::Size((Size *)&local_10,pSVar3);
    fVar12 = *pfVar2;
    if (*pfVar2 <= local_10) {
      fVar12 = local_10;
    }
    fVar11 = pfVar2[1];
    if (pfVar2[1] <= local_c) {
      fVar11 = local_c;
    }
    puVar7 = puVar7 + 1;
    iVar9 = iVar9 + 1;
    local_10 = fVar12;
    local_c = fVar11;
    (**(code **)(*(long *)this + 0x160))(this,(Size *)&local_10);
  } while( true );
}


/* === initWithXML @ 00f40c04 === */

/* cocos2d::TMXMapInfo::initWithXML(std::string const&, std::string const&) */

void __thiscall cocos2d::TMXMapInfo::initWithXML(TMXMapInfo *this,string *param_1,string *param_2)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  int *piVar4;
  undefined1 auStack_20 [16];
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FUN_01211570((string *)&local_10,&DAT_012fc3d8,auStack_20);
  internalInit(this,(string *)&local_10,param_2);
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
      *(int *)(local_10 + -8) = iVar3 + -1;
    }
    else {
      piVar4 = (int *)(local_10 + -8);
      do {
        iVar3 = *piVar4;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar2) {
          *piVar4 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
                    /* try { // try from 00f40cd0 to 01040cfb has its CatchHandler @ 00f40d9c */
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  parseXMLString(this,param_1);
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === lua_cocos2dx_TMXMapInfo_parseXMLString @ 00a27818 === */

/* lua_cocos2dx_TMXMapInfo_parseXMLString(lua_State*) */

void lua_cocos2dx_TMXMapInfo_parseXMLString(lua_State *param_1)

{
  bool bVar1;
  char cVar2;
  undefined1 uVar3;
  int iVar4;
  TMXMapInfo *this;
  int *piVar5;
  bool bVar6;
  undefined *local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  this = (TMXMapInfo *)tolua_tousertype(param_1,1,0);
  iVar4 = lua_gettop(param_1);
  if (iVar4 + -1 == 1) {
    local_10 = PTR_DAT_017191c0 + 0x18;
    cVar2 = luaval_to_std_string(param_1,2,(string *)&local_10,"cc.TMXMapInfo:parseXMLString");
    if (cVar2 == '\0') {
      tolua_error(param_1,&DAT_012d89e8,0);
    }
    else {
      uVar3 = cocos2d::TMXMapInfo::parseXMLString(this,(string *)&local_10);
      tolua_pushboolean(param_1,uVar3);
    }
    bVar6 = cVar2 != '\0';
    if (local_10 + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar4 + -1;
      }
      else {
        piVar5 = (int *)(local_10 + -8);
        do {
          iVar4 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar4 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete(local_10 + -0x18);
      }
    }
  }
  else {
    bVar6 = false;
    luaL_error(param_1,"%s has wrong number of arguments: %d, was expecting %d \n",&LAB_012d89c8,
               iVar4 + -1,1);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(bVar6);
}


/* === initWithTMXFile @ 00f40e74 === */

/* cocos2d::TMXMapInfo::initWithTMXFile(std::string const&) */

void __thiscall cocos2d::TMXMapInfo::initWithTMXFile(TMXMapInfo *this,string *param_1)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  int *piVar4;
  undefined1 auStack_20 [16];
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* catch() { ... } // from try @ 00f411fc with catch @ 00f40eb0
                       catch() { ... } // from try @ 00f41370 with catch @ 00f40eb0 */
  FUN_01211570((string *)&local_10,&DAT_012fc3d8,auStack_20);
  internalInit(this,param_1,(string *)&local_10);
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
      *(int *)(local_10 + -8) = iVar3 + -1;
    }
    else {
      piVar4 = (int *)(local_10 + -8);
      do {
        iVar3 = *piVar4;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar2) {
          *piVar4 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
                    /* try { // try from 00f40f34 to 01040f37 has its CatchHandler @ 00f41484 */
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  parseXMLFile(this,(string *)(this + 0xe8));
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === lua_cocos2dx_TMXMapInfo_parseXMLFile @ 00a2fc58 === */

/* lua_cocos2dx_TMXMapInfo_parseXMLFile(lua_State*) */

void lua_cocos2dx_TMXMapInfo_parseXMLFile(lua_State *param_1)

{
  bool bVar1;
  char cVar2;
  undefined1 uVar3;
  int iVar4;
  TMXMapInfo *this;
  int *piVar5;
  bool bVar6;
  undefined *local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
                    /* try { // try from 00a2fc88 to 00b2fc8b has its CatchHandler @ 00a30014 */
  this = (TMXMapInfo *)tolua_tousertype(param_1,1,0);
                    /* try { // try from 00a2fc94 to 00b2fc97 has its CatchHandler @ 00a2ffec */
  iVar4 = lua_gettop(param_1);
  if (iVar4 + -1 == 1) {
    local_10 = PTR_DAT_017191c0 + 0x18;
    cVar2 = luaval_to_std_string(param_1,2,(string *)&local_10,"cc.TMXMapInfo:parseXMLFile");
    if (cVar2 == '\0') {
      tolua_error(param_1,"invalid arguments in function \'lua_cocos2dx_TMXMapInfo_parseXMLFile\'",0
                 );
    }
    else {
      uVar3 = cocos2d::TMXMapInfo::parseXMLFile(this,(string *)&local_10);
      tolua_pushboolean(param_1,uVar3);
    }
    bVar6 = cVar2 != '\0';
    if (local_10 + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar4 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar4 + -1;
      }
      else {
        piVar5 = (int *)(local_10 + -8);
        do {
          iVar4 = *piVar5;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar5,0x10);
          if (bVar1) {
            *piVar5 = iVar4 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar4 < 1) {
        operator_delete(local_10 + -0x18);
      }
    }
  }
  else {
                    /* try { // try from 00a2fcac to 00b2fcaf has its CatchHandler @ 00a300cc */
                    /* try { // try from 00a2fcb8 to 00b2fcbb has its CatchHandler @ 00a300d0 */
    bVar6 = false;
    luaL_error(param_1,"%s has wrong number of arguments: %d, was expecting %d \n",
               "cc.TMXMapInfo:parseXMLFile",iVar4 + -1,1);
  }
                    /* try { // try from 00a2fcd0 to 00b2fcd3 has its CatchHandler @ 00a300f4 */
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 00a2fce0 to 00b2fce3 has its CatchHandler @ 00a300f8 */
                    /* try { // try from 00a2fcec to 00b2fcef has its CatchHandler @ 00a3011c */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(bVar6);
}


/* === startElement @ 00f42968 === */

/* WARNING: Type propagation algorithm not settling */
/* WARNING: Restarted to delay deadcode elimination for space: stack */
/* cocos2d::TMXMapInfo::startElement(void*, char const*, char const**) */

void __thiscall
cocos2d::TMXMapInfo::startElement(TMXMapInfo *this,void *param_1,char *param_2,char **param_3)

{
  TMXMapInfo *pTVar1;
  char cVar2;
  bool bVar3;
  Value *pVVar4;
  TMXLayerInfo TVar5;
  int iVar6;
  int iVar7;
  int iVar8;
  _Hash_node *p_Var9;
  ulong uVar10;
  long *plVar11;
  Value *pVVar12;
  TMXTilesetInfo *this_00;
  TMXLayerInfo *pTVar13;
  TMXObjectGroup *this_01;
  long lVar14;
  void *pvVar15;
  void *pvVar16;
  undefined8 uVar17;
  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
  *p_Var18;
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  *p_Var19;
  char *pcVar20;
  Value *pVVar21;
  long lVar22;
  undefined8 *puVar23;
  long lVar24;
  ulong uVar25;
  long lVar26;
  undefined8 uVar27;
  undefined8 uVar28;
  char *pcVar29;
  ulong uVar30;
  int *piVar31;
  undefined8 *puVar32;
  string *psVar33;
  undefined *puVar34;
  char **ppcVar35;
  float fVar36;
  undefined4 uVar37;
  undefined4 uVar38;
  float fVar39;
  float fVar40;
  float fVar41;
  double dVar42;
  double dVar43;
  float fVar44;
  float fVar45;
  long local_690;
  long local_688;
  long local_680;
  long local_678;
  long local_670;
  long local_668;
  long local_660;
  long local_658;
  long local_650;
  long local_648;
  long local_640;
  long local_638;
  long local_630;
  long local_628;
  long local_620;
  long local_618;
  long local_610;
  long local_608;
  long local_600;
  long local_5f8;
  long local_5f0;
  long local_5e8;
  long local_5e0;
  long local_5d8;
  long local_5d0;
  long local_5c8;
  long local_5c0;
  long local_5b8;
  long local_5b0;
  long local_5a8;
  long local_5a0;
  long local_598;
  long local_590;
  long local_588;
  long local_580;
  long local_578;
  long local_570;
  long local_568;
  long local_560;
  long local_558;
  long local_550;
  long local_548;
  long local_540;
  long local_538;
  long local_530;
  long local_528;
  long local_520;
  long local_518;
  long local_510;
  long local_508;
  long local_500;
  long local_4f8;
  long local_4f0;
  long local_4e8;
  long local_4e0;
  long local_4d8;
  long local_4d0;
  long local_4c8;
  long local_4c0;
  long local_4b8;
  long local_4b0;
  string asStack_4a8 [8];
  long local_4a0;
  string local_498 [8];
  long local_490;
  long local_488;
  long local_480;
  long local_478;
  long local_470;
  long local_468;
  long local_460;
  long local_458;
  Value aVStack_450 [16];
  Value aVStack_440 [16];
  Value aVStack_430 [16];
  Value aVStack_420 [16];
  Value aVStack_410 [16];
  Value aVStack_400 [16];
  Value aVStack_3f0 [16];
  long local_3e0 [2];
  undefined *local_3d0 [2];
  undefined *local_3c0 [2];
  long local_3b0 [2];
  undefined *local_3a0 [2];
  undefined *local_390 [2];
  undefined8 local_380;
  Value *local_370;
  Value *local_368;
  Value *local_360;
  undefined8 *local_358;
  ulong local_350;
  undefined8 local_348;
  undefined8 local_340;
  undefined4 local_338 [2];
  undefined8 local_330;
  undefined8 local_328;
  undefined8 local_320;
  long local_318;
  undefined8 local_310;
  undefined8 local_308;
  undefined4 local_300 [2];
  undefined8 local_2f8;
  undefined8 local_2f0;
  undefined1 auStack_2e8 [368];
  char *local_178 [2];
  char *local_168 [8];
  undefined1 auStack_128 [8];
  undefined4 local_120;
  long local_118;
  undefined *local_110 [27];
  undefined8 local_38;
  undefined1 local_30;
  undefined1 local_2f;
  undefined8 local_28;
  undefined8 local_20;
  undefined8 local_18;
  undefined8 local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  FUN_01211570(&local_690,param_2,(Size *)&local_320);
  local_348 = 0;
  local_340 = 0;
  local_338[0] = 0x3f800000;
  local_330 = 0;
  local_350 = FUN_0120ff88(local_338,10);
  if (local_350 == 1) {
    local_358 = &local_328;
    local_328 = 0;
  }
  else {
    local_358 = (undefined8 *)FUN_00f402b4();
  }
  if ((param_3 != (char **)0x0) && (pcVar20 = *param_3, pcVar20 != (char *)0x0)) {
    ppcVar35 = param_3 + 1;
    do {
      while( true ) {
        FUN_01211570(&local_370,pcVar20,(Size *)&local_320);
        FUN_01211570((Size *)&local_320,*ppcVar35,&local_380);
        cocos2d::Value::Value(aVStack_450,(string *)&local_320);
                    /* try { // try from 00f42ab8 to 01042abb has its CatchHandler @ 00f42cf8 */
        p_Var9 = operator_new(0x28);
                    /* try { // try from 00f42ac8 to 01042acb has its CatchHandler @ 00f42cac */
        *(undefined8 *)p_Var9 = 0;
        FUN_01214ee0((string *)(p_Var9 + 8),&local_370);
        cocos2d::Value::Value((Value *)(p_Var9 + 0x10),aVStack_450);
        uVar10 = FUN_011c78ec(*(long *)(p_Var9 + 8),*(undefined8 *)(*(long *)(p_Var9 + 8) + -0x18),
                              0xc70f6907);
        uVar30 = 0;
        if (local_350 != 0) {
          uVar30 = uVar10 / local_350;
        }
        uVar30 = uVar10 - uVar30 * local_350;
        plVar11 = (long *)std::
                          _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                          ::_M_find_before_node
                                    ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                                      *)&local_358,uVar30,(string *)(p_Var9 + 8),uVar10);
                    /* try { // try from 00f42a28 to 01042a2b has its CatchHandler @ 00f42958 */
        if ((plVar11 == (long *)0x0) || (*plVar11 == 0)) break;
        cocos2d::Value::~Value((Value *)(p_Var9 + 0x10));
        lVar24 = *(long *)(p_Var9 + 8);
        if ((undefined *)(lVar24 + -0x18) != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(lVar24 + -8);
            *(int *)(lVar24 + -8) = iVar6 + -1;
          }
          else {
            piVar31 = (int *)(lVar24 + -8);
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete((undefined *)(lVar24 + -0x18));
          }
        }
        operator_delete(p_Var9);
                    /* try { // try from 00f42a50 to 01042a53 has its CatchHandler @ 00f42c38 */
        cocos2d::Value::~Value(aVStack_450);
        puVar23 = local_320 + -3;
        if (puVar23 == (undefined8 *)PTR_DAT_017191c0) goto LAB_00f42a6c;
LAB_00f42b50:
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_320 + -1);
          *(int *)(local_320 + -1) = iVar6 + -1;
                    /* try { // try from 00f42fc8 to 0104302b has its CatchHandler @ 00f44414 */
        }
        else {
          piVar31 = (int *)(local_320 + -1);
          do {
            iVar6 = *piVar31;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (0 < iVar6) goto LAB_00f42a6c;
        operator_delete(puVar23);
        pVVar12 = local_370 + -0x18;
                    /* try { // try from 00f42b8c to 01042b8f has its CatchHandler @ 00f42bf8 */
        if (pVVar12 != (Value *)PTR_DAT_017191c0) goto LAB_00f42b94;
LAB_00f42a80:
        pcVar20 = ppcVar35[1];
        ppcVar35 = ppcVar35 + 2;
        if (pcVar20 == (char *)0x0) goto LAB_00f42bd0;
      }
      std::
      _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
      ::_M_insert_unique_node
                ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                  *)&local_358,uVar30,uVar10,p_Var9);
      cocos2d::Value::~Value(aVStack_450);
      puVar23 = local_320 + -3;
      if (puVar23 != (undefined8 *)PTR_DAT_017191c0) goto LAB_00f42b50;
LAB_00f42a6c:
                    /* try { // try from 00f42a6c to 01042a6f has its CatchHandler @ 00f42c98 */
      pVVar12 = local_370 + -0x18;
      if (pVVar12 == (Value *)PTR_DAT_017191c0) goto LAB_00f42a80;
LAB_00f42b94:
                    /* try { // try from 00f42b9c to 01042b9f has its CatchHandler @ 00f42c24 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_370 + -8);
        *(int *)(local_370 + -8) = iVar6 + -1;
      }
      else {
        pVVar21 = local_370 + -8;
        do {
          iVar6 = *(int *)pVVar21;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(pVVar21,0x10);
          if (bVar3) {
            *(int *)pVVar21 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (0 < iVar6) goto LAB_00f42a80;
      operator_delete(pVVar12);
      pcVar20 = ppcVar35[1];
      ppcVar35 = ppcVar35 + 2;
    } while (pcVar20 != (char *)0x0);
  }
LAB_00f42bd0:
  iVar6 = FUN_01213398(&local_690,"map");
  if (iVar6 == 0) {
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f42b8c with catch @ 00f42bf8
                        */
    FUN_01211570((string *)&local_688,"version",&local_370);
    std::__detail::
    _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
    ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                  *)&local_358,(string *)&local_688);
    cocos2d::Value::asString();
                    /* try { // try from 00f42c20 to 01042c23 has its CatchHandler @ 00f42c68 */
                    /* catch() { ... } // from try @ 00f42b9c with catch @ 00f42c24 */
    if ((undefined *)(local_688 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_688 + -8);
                    /* try { // try from 00f43e04 to 01043e07 has its CatchHandler @ 00f44328 */
        *(int *)(local_688 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_688 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
                    /* try { // try from 00f43894 to 01043897 has its CatchHandler @ 00f44450 */
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_688 + -0x18));
      }
    }
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f42a50 with catch @ 00f42c38
                        */
    FUN_01213398(local_3a0,&DAT_01363508);
    FUN_01211570((string *)&local_680,"orientation",&local_370);
    std::__detail::
    _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
    ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                  *)&local_358,(string *)&local_680);
                    /* try { // try from 00f42c64 to 01042c67 has its CatchHandler @ 00f42c78 */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f42c20 with catch @ 00f42c68
                        */
    cocos2d::Value::asString();
                    /* try { // try from 00f42c74 to 01042c77 has its CatchHandler @ 00f42958 */
                    /* catch() { ... } // from try @ 00f42c64 with catch @ 00f42c78 */
    if ((undefined *)(local_680 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f43844 to 01043847 has its CatchHandler @ 00f4444c */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_680 + -8);
        *(int *)(local_680 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_680 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_680 + -0x18));
      }
    }
    iVar6 = FUN_01213398(local_390,"orthogonal");
    if (iVar6 == 0) {
                    /* try { // try from 00f42c94 to 01042c97 has its CatchHandler @ 00f42cfc */
                    /* catch() { ... } // from try @ 00f42a6c with catch @ 00f42c98 */
      *(undefined4 *)(this + 0x30) = 0;
    }
    else {
      iVar6 = FUN_01213398(local_390,"isometric");
      if (iVar6 == 0) {
        *(undefined4 *)(this + 0x30) = 2;
      }
      else {
        iVar6 = FUN_01213398(local_390,"hexagonal");
        if (iVar6 == 0) {
          *(undefined4 *)(this + 0x30) = 1;
        }
        else {
                    /* catch() { ... } // from try @ 00f4336c with catch @ 00f4426c */
          iVar6 = FUN_01213398(local_390,"staggered");
          if (iVar6 == 0) {
            *(undefined4 *)(this + 0x30) = 3;
          }
        }
      }
    }
                    /* catch() { ... } // from try @ 00f42ac8 with catch @ 00f42cac */
    FUN_01211570((string *)&local_678,"staggeraxis",&local_370);
    std::__detail::
    _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
    ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                  *)&local_358,(string *)&local_678);
    cocos2d::Value::asString();
    if ((undefined *)(local_678 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f43ba8 to 01043bab has its CatchHandler @ 00f443e0 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_678 + -8);
        *(int *)(local_678 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_678 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_678 + -0x18));
      }
    }
                    /* try { // try from 00f42ce8 to 01042ceb has its CatchHandler @ 00f42d0c */
    iVar6 = FUN_01213398(&local_380,"x");
    if (iVar6 == 0) {
                    /* try { // try from 00f42cf4 to 01042cf7 has its CatchHandler @ 00f42958 */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f42ab8 with catch @ 00f42cf8
                        */
      *(undefined4 *)(this + 0x34) = 0;
    }
    else {
      iVar6 = FUN_01213398(&local_380,"y");
      if (iVar6 == 0) {
        *(undefined4 *)(this + 0x34) = 1;
      }
    }
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f42c94 with catch @ 00f42cfc
                        */
                    /* try { // try from 00f42d08 to 01042d0b has its CatchHandler @ 00f42958 */
                    /* catch() { ... } // from try @ 00f42ce8 with catch @ 00f42d0c */
    FUN_01211570((string *)&local_670,"staggerindex",local_3b0);
    std::__detail::
    _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
    ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                  *)&local_358,(string *)&local_670);
    cocos2d::Value::asString();
    if ((undefined *)(local_670 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_670 + -8);
        *(int *)(local_670 + -8) = iVar6 + -1;
      }
      else {
                    /* try { // try from 00f4390c to 0104390f has its CatchHandler @ 00f44460 */
        piVar31 = (int *)(local_670 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_670 + -0x18));
      }
    }
                    /* catch() { ... } // from try @ 00f42eb4 with catch @ 00f42d48
                       catch() { ... } // from try @ 00f43fd4 with catch @ 00f42d48
                       catch() { ... } // from try @ 00f44100 with catch @ 00f42d48 */
    iVar6 = FUN_01213398(&local_370,&DAT_01363570);
    if (iVar6 == 0) {
      *(undefined4 *)(this + 0x38) = 0;
    }
    else {
      iVar6 = FUN_01213398(&local_370,&DAT_01363578);
      if (iVar6 == 0) {
        *(undefined4 *)(this + 0x38) = 1;
                    /* try { // try from 00f438cc to 010438cf has its CatchHandler @ 00f44414 */
      }
    }
    FUN_01211570((string *)&local_668,"hexsidelength",local_3b0);
    pVVar12 = (Value *)std::__detail::
                       _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                       ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     *)&local_358,(string *)&local_668);
    fVar36 = (float)cocos2d::Value::asFloat(pVVar12);
    if ((undefined *)(local_668 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f43a68 to 01043a6b has its CatchHandler @ 00f443a8 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_668 + -8);
        *(int *)(local_668 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_668 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_668 + -0x18));
      }
    }
    *(int *)(this + 0x3c) = (int)fVar36;
    Size::Size((Size *)&local_320);
    FUN_01211570((string *)&local_660,"width",local_3c0);
    pVVar12 = (Value *)std::__detail::
                       _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                       ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     *)&local_358,(string *)&local_660);
    uVar37 = cocos2d::Value::asFloat(pVVar12);
    local_320 = (undefined8 *)CONCAT44(local_320._4_4_,uVar37);
    if ((undefined *)(local_660 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_660 + -8);
        *(int *)(local_660 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_660 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_660 + -0x18));
      }
    }
    FUN_01211570((string *)&local_658,"height",local_3c0);
    pVVar12 = (Value *)std::__detail::
                       _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                       ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     *)&local_358,(string *)&local_658);
    uVar37 = cocos2d::Value::asFloat(pVVar12);
    local_320._4_4_ = (float)uVar37;
    if ((undefined *)(local_658 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_658 + -8);
        *(int *)(local_658 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_658 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_658 + -0x18));
                    /* try { // try from 00f43b68 to 01043b6b has its CatchHandler @ 00f44414 */
      }
    }
    Size::operator=((Size *)(this + 0x40),(Size *)&local_320);
    FUN_01211570((string *)&local_650,"tilewidth",local_3c0);
    pVVar12 = (Value *)std::__detail::
                       _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                       ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     *)&local_358,(string *)&local_650);
    uVar37 = cocos2d::Value::asFloat(pVVar12);
    local_320 = (undefined8 *)CONCAT44(local_320._4_4_,uVar37);
    if ((undefined *)(local_650 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_650 + -8);
        *(int *)(local_650 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_650 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
                    /* try { // try from 00f43b24 to 01043b27 has its CatchHandler @ 00f443d0 */
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_650 + -0x18));
      }
    }
    FUN_01211570((string *)&local_648,"tileheight",local_3c0);
    pVVar12 = (Value *)std::__detail::
                       _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                       ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     *)&local_358,(string *)&local_648);
    uVar37 = cocos2d::Value::asFloat(pVVar12);
                    /* try { // try from 00f42eb4 to 01042edb has its CatchHandler @ 00f42d48 */
    local_320 = (undefined8 *)CONCAT44(uVar37,(float)local_320);
    if ((undefined *)(local_648 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_648 + -8);
        *(int *)(local_648 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_648 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_648 + -0x18));
      }
    }
    Size::operator=((Size *)(this + 0x48),(Size *)&local_320);
    *(undefined4 *)(this + 0x98) = 1;
                    /* try { // try from 00f42eec to 01042eef has its CatchHandler @ 00f4431c */
    if (local_370 + -0x18 != (Value *)PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_370 + -8);
        *(int *)(local_370 + -8) = iVar6 + -1;
      }
      else {
                    /* try { // try from 00f43aa8 to 01043aab has its CatchHandler @ 00f443ac */
        pVVar12 = local_370 + -8;
        do {
          iVar6 = *(int *)pVVar12;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(pVVar12,0x10);
          if (bVar3) {
            *(int *)pVVar12 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
                    /* try { // try from 00f43ab8 to 01043abb has its CatchHandler @ 00f443bc */
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
                    /* try { // try from 00f43ac8 to 01043acb has its CatchHandler @ 00f443cc */
        operator_delete(local_370 + -0x18);
      }
    }
    if (local_380 + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_380 + -8);
        *(int *)(local_380 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_380 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete(local_380 + -0x18);
      }
    }
                    /* try { // try from 00f42f04 to 01042f07 has its CatchHandler @ 00f4430c */
    if (local_390[0] + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_390[0] + -8);
        *(int *)(local_390[0] + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_390[0] + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete(local_390[0] + -0x18);
                    /* try { // try from 00f43a28 to 01043a2b has its CatchHandler @ 00f443a4 */
      }
    }
                    /* try { // try from 00f42f1c to 01042f1f has its CatchHandler @ 00f44314 */
                    /* try { // try from 00f42f28 to 01042f2b has its CatchHandler @ 00f442fc */
    if (local_3a0[0] + -0x18 != PTR_DAT_017191c0) {
                    /* try { // try from 00f439c4 to 010439c7 has its CatchHandler @ 00f44498 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_3a0[0] + -8);
                    /* try { // try from 00f43e14 to 01043e17 has its CatchHandler @ 00f44350 */
        *(int *)(local_3a0[0] + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_3a0[0] + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete(local_3a0[0] + -0x18);
                    /* try { // try from 00f439f4 to 010439f7 has its CatchHandler @ 00f44414 */
      }
    }
    goto LAB_00f42f2c;
  }
  iVar6 = FUN_01213398(&local_690,"tileset");
  if (iVar6 == 0) {
    FUN_01211570((string *)&local_640,"source",&local_380);
    std::__detail::
    _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
    ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                  *)&local_358,(string *)&local_640);
    cocos2d::Value::asString();
    if ((undefined *)(local_640 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_640 + -8);
        *(int *)(local_640 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_640 + -8);
        do {
          iVar6 = *piVar31;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete((undefined *)(local_640 + -0x18));
      }
    }
    iVar6 = FUN_01213398((string *)&local_370,&DAT_012fc3d8);
    if (iVar6 == 0) {
                    /* try { // try from 00f4305c to 0104305f has its CatchHandler @ 00f4441c */
      this_00 = operator_new(0x68,(nothrow_t *)PTR_nothrow_01717628);
      if (this_00 != (TMXTilesetInfo *)0x0) {
        TMXTilesetInfo::TMXTilesetInfo(this_00);
      }
      FUN_01211570((string *)&local_618,"name",&local_380);
                    /* try { // try from 00f4309c to 0104309f has its CatchHandler @ 00f44360 */
      std::__detail::
      _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
      ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                    *)&local_358,(string *)&local_618);
      cocos2d::Value::asString();
      FUN_0121258c(this_00 + 0x28,&local_610);
      if ((undefined *)(local_610 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_610 + -8);
          *(int *)(local_610 + -8) = iVar6 + -1;
        }
        else {
          piVar31 = (int *)(local_610 + -8);
          do {
            iVar6 = *piVar31;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
          operator_delete((undefined *)(local_610 + -0x18));
        }
      }
      if ((undefined *)(local_618 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00f43c00 with catch @ 00f44238 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_618 + -8);
          *(int *)(local_618 + -8) = iVar6 + -1;
        }
        else {
          piVar31 = (int *)(local_618 + -8);
          do {
            iVar6 = *piVar31;
                    /* catch() { ... } // from try @ 00f43c48 with catch @ 00f44248 */
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
                    /* catch() { ... } // from try @ 00f43ee8 with catch @ 00f4425c */
          operator_delete((undefined *)(local_618 + -0x18));
        }
      }
                    /* try { // try from 00f430e0 to 010430e3 has its CatchHandler @ 00f44368 */
      if (this[0x13c] == (TMXMapInfo)0x0) {
        *(undefined4 *)(this_00 + 0x30) = *(undefined4 *)(this + 0x138);
        *(undefined4 *)(this + 0x138) = 0;
      }
      else {
        FUN_01211570((string *)&local_608,"firstgid",&local_380);
        pVVar12 = (Value *)std::__detail::
                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                           ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                         *)&local_358,(string *)&local_608);
        iVar6 = cocos2d::Value::asInt(pVVar12);
        *(int *)(this_00 + 0x30) = iVar6;
                    /* try { // try from 00f43ee8 to 01043f07 has its CatchHandler @ 00f4425c */
        if ((undefined *)(local_608 + -0x18) != PTR_DAT_017191c0) {
          piVar31 = (int *)(local_608 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_608 + -8);
            *(int *)(local_608 + -8) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
                    /* try { // try from 00f43f1c to 01043f1f has its CatchHandler @ 00f44430 */
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
                    /* try { // try from 00f43f24 to 01043f63 has its CatchHandler @ 00f44324 */
          if (iVar6 < 1) {
                    /* try { // try from 00f45010 to 010451a3 has its CatchHandler @ 00f45224 */
            operator_delete((undefined *)(local_608 + -0x18));
            iVar6 = *(int *)(this_00 + 0x30);
          }
          else {
            iVar6 = *(int *)(this_00 + 0x30);
          }
        }
        if (iVar6 < 0) {
          *(undefined4 *)(this_00 + 0x30) = 0;
        }
      }
      FUN_01211570((string *)&local_600,"spacing",&local_380);
      pVVar12 = (Value *)std::__detail::
                         _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                         ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       *)&local_358,(string *)&local_600);
      uVar37 = cocos2d::Value::asInt(pVVar12);
      *(undefined4 *)(this_00 + 0x3c) = uVar37;
      if ((undefined *)(local_600 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_600 + -8);
          *(int *)(local_600 + -8) = iVar6 + -1;
        }
        else {
          piVar31 = (int *)(local_600 + -8);
          do {
            iVar6 = *piVar31;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
          operator_delete((undefined *)(local_600 + -0x18));
        }
      }
                    /* try { // try from 00f43148 to 0104314b has its CatchHandler @ 00f4436c */
      FUN_01211570((string *)&local_5f8,"margin",&local_380);
      pVVar12 = (Value *)std::__detail::
                         _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                         ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       *)&local_358,(string *)&local_5f8);
      uVar37 = cocos2d::Value::asInt(pVVar12);
      *(undefined4 *)(this_00 + 0x40) = uVar37;
      if ((undefined *)(local_5f8 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_5f8 + -8);
          *(int *)(local_5f8 + -8) = iVar6 + -1;
        }
        else {
          piVar31 = (int *)(local_5f8 + -8);
          do {
            iVar6 = *piVar31;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
          operator_delete((undefined *)(local_5f8 + -0x18));
        }
      }
      Size::Size((Size *)&local_320);
                    /* try { // try from 00f43198 to 0104319b has its CatchHandler @ 00f44414 */
      FUN_01211570((string *)&local_5f0,"tilewidth",local_390);
      pVVar12 = (Value *)std::__detail::
                         _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                         ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       *)&local_358,(string *)&local_5f0);
      uVar37 = cocos2d::Value::asFloat(pVVar12);
      local_320 = (undefined8 *)CONCAT44(local_320._4_4_,uVar37);
      if ((undefined *)(local_5f0 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 00f44774 to 01044777 has its CatchHandler @ 00f45204 */
          iVar6 = *(int *)(local_5f0 + -8);
          *(int *)(local_5f0 + -8) = iVar6 + -1;
        }
        else {
          piVar31 = (int *)(local_5f0 + -8);
          do {
            iVar6 = *piVar31;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
                    /* catch() { ... } // from try @ 00f43bf4 with catch @ 00f441bc */
          operator_delete((undefined *)(local_5f0 + -0x18));
        }
      }
                    /* try { // try from 00f431d8 to 010431db has its CatchHandler @ 00f44370 */
      FUN_01211570((string *)&local_5e8,"tileheight",local_390);
      pVVar12 = (Value *)std::__detail::
                         _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                         ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       *)&local_358,(string *)&local_5e8);
      uVar37 = cocos2d::Value::asFloat(pVVar12);
      local_320 = (undefined8 *)CONCAT44(uVar37,(float)local_320);
      if ((undefined *)(local_5e8 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_5e8 + -8);
                    /* try { // try from 00f4467c to 0104467f has its CatchHandler @ 00f4526c */
          *(int *)(local_5e8 + -8) = iVar6 + -1;
        }
        else {
          piVar31 = (int *)(local_5e8 + -8);
          do {
            iVar6 = *piVar31;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
          operator_delete((undefined *)(local_5e8 + -0x18));
        }
      }
      Size::operator=((Size *)(this_00 + 0x34),(Size *)&local_320);
                    /* try { // try from 00f43218 to 0104321b has its CatchHandler @ 00f44374 */
      puVar23 = *(undefined8 **)(this + 0x70);
      if (puVar23 == *(undefined8 **)(this + 0x78)) {
                    /* catch() { ... } // from try @ 00f43844 with catch @ 00f4444c */
                    /* catch() { ... } // from try @ 00f43894 with catch @ 00f44450 */
        pvVar15 = *(void **)(this + 0x68);
        lVar24 = (long)puVar23 - (long)pvVar15;
        uVar30 = lVar24 >> 3;
        if (uVar30 == 0) {
          uVar10 = 8;
LAB_00f44470:
                    /* catch() { ... } // from try @ 00f43958 with catch @ 00f44474 */
          pvVar16 = operator_new(uVar10);
          pvVar15 = *(void **)(this + 0x68);
                    /* catch() { ... } // from try @ 00f43968 with catch @ 00f44488 */
          lVar24 = *(long *)(this + 0x70) - (long)pvVar15;
        }
        else {
                    /* catch() { ... } // from try @ 00f4390c with catch @ 00f44460 */
          uVar25 = uVar30 * 2;
                    /* catch() { ... } // from try @ 00f43948 with catch @ 00f44464 */
          uVar10 = 0xfffffffffffffff8;
          if ((uVar25 < uVar30) || (0x1fffffffffffffff < uVar25)) goto LAB_00f44470;
          uVar10 = uVar30 << 4;
          pvVar16 = (void *)0x0;
          if (uVar25 != 0) goto LAB_00f44470;
        }
        if ((long)pvVar16 + lVar24 != 0) {
                    /* catch() { ... } // from try @ 00f439c4 with catch @ 00f44498 */
          *(TMXTilesetInfo **)((long)pvVar16 + lVar24) = this_00;
          pvVar15 = *(void **)(this + 0x68);
          lVar24 = *(long *)(this + 0x70) - (long)pvVar15;
        }
                    /* catch() { ... } // from try @ 00f44518 with catch @ 00f444ac
                       catch() { ... } // from try @ 00f451fc with catch @ 00f444ac */
        if (lVar24 >> 3 != 0) {
          memmove(pvVar16,pvVar15,lVar24);
          pvVar15 = *(void **)(this + 0x68);
        }
        if (pvVar15 != (void *)0x0) {
          operator_delete(pvVar15);
        }
        *(void **)(this + 0x68) = pvVar16;
        *(long *)(this + 0x70) = (long)pvVar16 + lVar24 + 8;
        *(ulong *)(this + 0x78) = (long)pvVar16 + uVar10;
      }
      else {
        lVar24 = 0;
        if (puVar23 != (undefined8 *)0x0) {
          *puVar23 = this_00;
          lVar24 = *(long *)(this + 0x70);
        }
        *(long *)(this + 0x70) = lVar24 + 8;
      }
      cocos2d::Ref::retain((Ref *)this_00);
      cocos2d::Ref::release((Ref *)this_00);
    }
    else {
      FUN_01215060(this + 0x140,(string *)&local_370);
      pTVar1 = this + 0xe8;
                    /* try { // try from 00f43460 to 01043463 has its CatchHandler @ 00f442a0 */
      lVar24 = FUN_01212c40(pTVar1,"/",0xffffffffffffffff,1);
      if (lVar24 == -1) {
        FUN_01214ee0(&local_630,this + 0xf0);
        FUN_0121218c(&local_630,"/",1);
        plVar11 = (long *)FUN_01211fcc(&local_630,(string *)&local_370);
        local_320 = (undefined8 *)*plVar11;
        *plVar11 = (long)(PTR_DAT_017191c0 + 0x18);
        FUN_0121258c((string *)&local_370,(Size *)&local_320);
                    /* try { // try from 00f43fa4 to 01043fc3 has its CatchHandler @ 00f44430 */
        if (local_320 + -3 != (undefined8 *)PTR_DAT_017191c0) {
          piVar31 = (int *)(local_320 + -1);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_320 + -1);
                    /* try { // try from 00f451fc to 010451ff has its CatchHandler @ 00f444ac */
            *(int *)(local_320 + -1) = iVar6 + -1;
                    /* catch() { ... } // from try @ 00f445d4 with catch @ 00f45204
                       catch() { ... } // from try @ 00f4466c with catch @ 00f45204
                       catch() { ... } // from try @ 00f4470c with catch @ 00f45204
                       catch() { ... } // from try @ 00f44774 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44810 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44878 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44914 with catch @ 00f45204
                       catch() { ... } // from try @ 00f4497c with catch @ 00f45204
                       catch() { ... } // from try @ 00f44a18 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44a84 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44b20 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44b88 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44c24 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44c8c with catch @ 00f45204
                       catch() { ... } // from try @ 00f44d28 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44d90 with catch @ 00f45204
                       catch() { ... } // from try @ 00f44e6c with catch @ 00f45204
                       catch() { ... } // from try @ 00f44f98 with catch @ 00f45204 */
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
                    /* try { // try from 00f4466c to 0104466f has its CatchHandler @ 00f45204 */
            operator_delete(local_320 + -3);
          }
        }
        if ((undefined *)(local_630 + -0x18) != PTR_DAT_017191c0) {
          piVar31 = (int *)(local_630 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_630 + -8);
            *(int *)(local_630 + -8) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
                    /* try { // try from 00f43fd4 to 0104405f has its CatchHandler @ 00f42d48 */
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete((undefined *)(local_630 + -0x18));
          }
        }
      }
      else {
        lVar24 = FUN_01212c40(pTVar1,"/",0xffffffffffffffff,1);
                    /* try { // try from 00f434a0 to 010434a3 has its CatchHandler @ 00f442b0 */
        FUN_0121113c((Size *)&local_320,pTVar1,0,lVar24 + 1);
        FUN_01214ee0(&local_638,(Size *)&local_320);
        FUN_01211fcc(&local_638,(string *)&local_370);
        FUN_0121258c((string *)&local_370,&local_638);
        if ((undefined *)(local_638 + -0x18) != PTR_DAT_017191c0) {
          piVar31 = (int *)(local_638 + -8);
                    /* catch() { ... } // from try @ 00f437a8 with catch @ 00f442d8 */
                    /* catch() { ... } // from try @ 00f437e8 with catch @ 00f442dc */
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_638 + -8);
            *(int *)(local_638 + -8) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
                    /* catch() { ... } // from try @ 00f43824 with catch @ 00f442ec */
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
                    /* catch() { ... } // from try @ 00f42f28 with catch @ 00f442fc */
            operator_delete((undefined *)(local_638 + -0x18));
          }
        }
        if (local_320 + -3 != (undefined8 *)PTR_DAT_017191c0) {
          piVar31 = (int *)(local_320 + -1);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_320 + -1);
            *(int *)(local_320 + -1) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete(local_320 + -3);
          }
        }
      }
      plVar11 = (long *)FileUtils::getInstance();
                    /* try { // try from 00f434f8 to 010434fb has its CatchHandler @ 00f442c4 */
      (**(code **)(*plVar11 + 0x50))(&local_628,plVar11,(string *)&local_370);
      FUN_0121258c((string *)&local_370,&local_628);
      if ((undefined *)(local_628 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f44100 to 01044237 has its CatchHandler @ 00f42d48 */
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* try { // try from 00f44784 to 01044787 has its CatchHandler @ 00f4527c */
          iVar6 = *(int *)(local_628 + -8);
          *(int *)(local_628 + -8) = iVar6 + -1;
        }
        else {
          piVar31 = (int *)(local_628 + -8);
          do {
            iVar6 = *piVar31;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
          operator_delete((undefined *)(local_628 + -0x18));
        }
      }
                    /* try { // try from 00f4353c to 0104355b has its CatchHandler @ 00f44414 */
      FUN_01211570((string *)&local_620,"firstgid",&local_380);
      pVVar12 = (Value *)std::__detail::
                         _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                         ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       *)&local_358,(string *)&local_620);
      iVar6 = cocos2d::Value::asInt(pVVar12);
      *(int *)(this + 0x138) = iVar6;
      if ((undefined *)(local_620 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar6 = *(int *)(local_620 + -8);
          *(int *)(local_620 + -8) = iVar6 + -1;
        }
        else {
          piVar31 = (int *)(local_620 + -8);
          do {
            iVar6 = *piVar31;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
                    /* try { // try from 00f43e44 to 01043ecf has its CatchHandler @ 00f44430 */
        if (iVar6 < 1) {
          operator_delete((undefined *)(local_620 + -0x18));
        }
        iVar6 = *(int *)(this + 0x138);
      }
      if (iVar6 < 0) {
        *(undefined4 *)(this + 0x138) = 0;
      }
      this[0x13c] = (TMXMapInfo)0x0;
      parseXMLFile(this,(string *)&local_370);
    }
    if (local_370 + -0x18 != (Value *)PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* catch() { ... } // from try @ 00f42f34 with catch @ 00f44304 */
        iVar6 = *(int *)(local_370 + -8);
                    /* catch() { ... } // from try @ 00f42f04 with catch @ 00f4430c */
        *(int *)(local_370 + -8) = iVar6 + -1;
      }
      else {
                    /* try { // try from 00f43270 to 01043273 has its CatchHandler @ 00f44384 */
        pVVar12 = local_370 + -8;
        do {
          iVar6 = *(int *)pVVar12;
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(pVVar12,0x10);
          if (bVar3) {
            *(int *)pVVar12 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete(local_370 + -0x18);
      }
    }
LAB_00f42f2c:
    std::
    _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
    ::~_Hashtable((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                   *)&local_358);
                    /* try { // try from 00f42f34 to 01042f37 has its CatchHandler @ 00f44304 */
    puVar34 = (undefined *)(local_690 + -0x18);
    if (puVar34 == PTR_DAT_017191c0) goto LAB_00f42f4c;
  }
  else {
    iVar6 = FUN_01213398(&local_690,&DAT_013635c8);
    if (iVar6 != 0) {
      iVar6 = FUN_01213398(&local_690,"layer");
      if (iVar6 == 0) {
        pTVar13 = operator_new(0x88,(nothrow_t *)PTR_nothrow_01717628);
        if (pTVar13 != (TMXLayerInfo *)0x0) {
          TMXLayerInfo::TMXLayerInfo(pTVar13);
        }
                    /* try { // try from 00f435d0 to 01043603 has its CatchHandler @ 00f44430 */
        FUN_01211570((string *)&local_5d0,"name",&local_370);
        std::__detail::
        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
        ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                      *)&local_358,(string *)&local_5d0);
        cocos2d::Value::asString();
        FUN_0121258c(pTVar13 + 0x60,&local_5c8);
        if ((undefined *)(local_5c8 + -0x18) != PTR_DAT_017191c0) {
          piVar31 = (int *)(local_5c8 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_5c8 + -8);
            *(int *)(local_5c8 + -8) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete((undefined *)(local_5c8 + -0x18));
          }
        }
        if ((undefined *)(local_5d0 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f4470c to 0104470f has its CatchHandler @ 00f45204 */
          piVar31 = (int *)(local_5d0 + -8);
                    /* try { // try from 00f44718 to 0104471b has its CatchHandler @ 00f45270 */
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_5d0 + -8);
            *(int *)(local_5d0 + -8) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
                    /* try { // try from 00f44728 to 0104472b has its CatchHandler @ 00f45278 */
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete((undefined *)(local_5d0 + -0x18));
          }
        }
        Size::Size((Size *)&local_320);
                    /* try { // try from 00f43638 to 0104363b has its CatchHandler @ 00f44420 */
        FUN_01211570((string *)&local_5c0,"width",&local_380);
        pVVar12 = (Value *)std::__detail::
                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                           ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                         *)&local_358,(string *)&local_5c0);
        uVar37 = cocos2d::Value::asFloat(pVVar12);
        local_320 = (undefined8 *)CONCAT44(local_320._4_4_,uVar37);
        if ((undefined *)(local_5c0 + -0x18) != PTR_DAT_017191c0) {
          piVar31 = (int *)(local_5c0 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_5c0 + -8);
            *(int *)(local_5c0 + -8) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete((undefined *)(local_5c0 + -0x18));
          }
        }
                    /* try { // try from 00f43678 to 0104367b has its CatchHandler @ 00f44428 */
        FUN_01211570((string *)&local_5b8,"height",&local_380);
        pVVar12 = (Value *)std::__detail::
                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                           ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                         *)&local_358,(string *)&local_5b8);
        uVar37 = cocos2d::Value::asFloat(pVVar12);
        local_320 = (undefined8 *)CONCAT44(uVar37,(float)local_320);
        if ((undefined *)(local_5b8 + -0x18) != PTR_DAT_017191c0) {
          piVar31 = (int *)(local_5b8 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_5b8 + -8);
            *(int *)(local_5b8 + -8) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete((undefined *)(local_5b8 + -0x18));
          }
        }
                    /* try { // try from 00f436b4 to 010436b7 has its CatchHandler @ 00f443f0 */
        Size::operator=((Size *)(pTVar13 + 0x68),(Size *)&local_320);
        FUN_01211570((string *)&local_5b0,"visible",&local_380);
        pVVar12 = (Value *)std::__detail::
                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                           ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                         *)&local_358,(string *)&local_5b0);
                    /* try { // try from 00f436e4 to 010436e7 has its CatchHandler @ 00f44400 */
        if ((undefined *)(local_5b0 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f445d4 to 010445ef has its CatchHandler @ 00f45204 */
          piVar31 = (int *)(local_5b0 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_5b0 + -8);
            *(int *)(local_5b0 + -8) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
                    /* try { // try from 00f445f8 to 010445fb has its CatchHandler @ 00f4524c */
            operator_delete((undefined *)(local_5b0 + -0x18));
          }
        }
        if (*(int *)(pVVar12 + 8) == 0) {
          TVar5 = (TMXLayerInfo)0x1;
        }
        else {
          TVar5 = (TMXLayerInfo)cocos2d::Value::asBool(pVVar12);
        }
        pTVar13[0x78] = TVar5;
        FUN_01211570((string *)&local_5a8,"opacity",&local_380);
        pVVar12 = (Value *)std::__detail::
                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                           ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                         *)&local_358,(string *)&local_5a8);
        if ((undefined *)(local_5a8 + -0x18) != PTR_DAT_017191c0) {
          piVar31 = (int *)(local_5a8 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_5a8 + -8);
                    /* try { // try from 00f46b18 to 01046b1b has its CatchHandler @ 00f46b44 */
            *(int *)(local_5a8 + -8) = iVar6 + -1;
                    /* try { // try from 00f46b20 to 01046b5b has its CatchHandler @ 00f46aec */
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
                    /* try { // try from 00f44b88 to 01044b8b has its CatchHandler @ 00f45204 */
            operator_delete((undefined *)(local_5a8 + -0x18));
          }
        }
        if (*(int *)(pVVar12 + 8) == 0) {
          TVar5 = (TMXLayerInfo)0xff;
        }
        else {
                    /* try { // try from 00f4375c to 01043777 has its CatchHandler @ 00f44414 */
          fVar36 = (float)cocos2d::Value::asFloat(pVVar12);
          TVar5 = SUB41((int)(fVar36 * DAT_00f46df4),0);
        }
        pTVar13[0x79] = TVar5;
        FUN_01211570((string *)&local_5a0,"x",&local_380);
        pVVar12 = (Value *)std::__detail::
                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                           ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                         *)&local_358,(string *)&local_5a0);
        uVar37 = cocos2d::Value::asFloat(pVVar12);
                    /* try { // try from 00f437a8 to 010437ab has its CatchHandler @ 00f442d8 */
        if ((undefined *)(local_5a0 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f44b20 to 01044b23 has its CatchHandler @ 00f45204 */
          piVar31 = (int *)(local_5a0 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_5a0 + -8);
            *(int *)(local_5a0 + -8) = iVar6 + -1;
          }
          else {
            do {
                    /* try { // try from 00f44b2c to 01044b2f has its CatchHandler @ 00f452c0 */
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
                    /* try { // try from 00f44b3c to 01044b3f has its CatchHandler @ 00f452c4 */
          if (iVar6 < 1) {
            operator_delete((undefined *)(local_5a0 + -0x18));
          }
        }
        FUN_01211570((string *)&local_598,"y",&local_380);
        pVVar12 = (Value *)std::__detail::
                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                           ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                         *)&local_358,(string *)&local_598);
        uVar38 = cocos2d::Value::asFloat(pVVar12);
                    /* try { // try from 00f437e8 to 010437eb has its CatchHandler @ 00f442dc */
        if ((undefined *)(local_598 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f44608 to 0104460b has its CatchHandler @ 00f4525c */
          piVar31 = (int *)(local_598 + -8);
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar6 = *(int *)(local_598 + -8);
            *(int *)(local_598 + -8) = iVar6 + -1;
          }
          else {
            do {
              iVar6 = *piVar31;
              cVar2 = '\x01';
              bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
              if (bVar3) {
                *piVar31 = iVar6 + -1;
                cVar2 = ExclusiveMonitorsStatus();
              }
            } while (cVar2 != '\0');
          }
          if (iVar6 < 1) {
            operator_delete((undefined *)(local_598 + -0x18));
          }
        }
        puVar32 = *(undefined8 **)(this + 0x58);
        puVar23 = *(undefined8 **)(this + 0x60);
        *(undefined4 *)(pTVar13 + 0x7c) = uVar37;
        *(undefined4 *)(pTVar13 + 0x80) = uVar38;
        if (puVar32 == puVar23) {
          pvVar15 = *(void **)(this + 0x50);
          lVar24 = (long)puVar32 - (long)pvVar15;
          uVar30 = lVar24 >> 3;
                    /* try { // try from 00f44518 to 0104453f has its CatchHandler @ 00f444ac */
          if (uVar30 == 0) {
            uVar10 = 8;
LAB_00f4452c:
            pvVar16 = operator_new(uVar10);
            pvVar15 = *(void **)(this + 0x50);
            lVar24 = *(long *)(this + 0x58) - (long)pvVar15;
          }
          else {
            uVar25 = uVar30 * 2;
            uVar10 = 0xfffffffffffffff8;
                    /* catch() { ... } // from try @ 00f44728 with catch @ 00f45278 */
                    /* catch() { ... } // from try @ 00f44784 with catch @ 00f4527c */
            if ((uVar25 < uVar30) || (0x1fffffffffffffff < uVar25)) goto LAB_00f4452c;
            uVar10 = uVar30 << 4;
            pvVar16 = (void *)0x0;
                    /* catch() { ... } // from try @ 00f4481c with catch @ 00f4528c */
            if (uVar25 != 0) goto LAB_00f4452c;
          }
          if ((long)pvVar16 + lVar24 != 0) {
                    /* try { // try from 00f44550 to 01044553 has its CatchHandler @ 00f45234 */
            *(TMXLayerInfo **)((long)pvVar16 + lVar24) = pTVar13;
            pvVar15 = *(void **)(this + 0x50);
            lVar24 = *(long *)(this + 0x58) - (long)pvVar15;
          }
                    /* try { // try from 00f44564 to 01044567 has its CatchHandler @ 00f45224 */
          if (lVar24 >> 3 != 0) {
                    /* catch() { ... } // from try @ 00f44608 with catch @ 00f4525c */
            memmove(pvVar16,pvVar15,lVar24);
                    /* catch() { ... } // from try @ 00f4467c with catch @ 00f4526c */
                    /* catch() { ... } // from try @ 00f44718 with catch @ 00f45270 */
            pvVar15 = *(void **)(this + 0x50);
          }
                    /* try { // try from 00f44570 to 01044573 has its CatchHandler @ 00f4522c */
          if (pvVar15 != (void *)0x0) {
            operator_delete(pvVar15);
          }
          *(void **)(this + 0x50) = pvVar16;
          *(long *)(this + 0x58) = (long)pvVar16 + lVar24 + 8;
          *(ulong *)(this + 0x60) = (long)pvVar16 + uVar10;
        }
        else {
          lVar24 = 0;
          if (puVar32 != (undefined8 *)0x0) {
            *puVar32 = pTVar13;
            lVar24 = *(long *)(this + 0x58);
          }
          *(long *)(this + 0x58) = lVar24 + 8;
        }
                    /* try { // try from 00f43824 to 01043827 has its CatchHandler @ 00f442ec */
        cocos2d::Ref::retain((Ref *)pTVar13);
        cocos2d::Ref::release((Ref *)pTVar13);
                    /* try { // try from 00f43834 to 01043837 has its CatchHandler @ 00f4443c */
        *(undefined4 *)(this + 0x98) = 2;
      }
      else {
        iVar6 = FUN_01213398(&local_690,"objectgroup");
                    /* try { // try from 00f43be4 to 01043be7 has its CatchHandler @ 00f443e8 */
        if (iVar6 == 0) {
                    /* try { // try from 00f43bf4 to 01043bf7 has its CatchHandler @ 00f441bc */
          this_01 = operator_new(0x88,(nothrow_t *)PTR_nothrow_01717628);
          if (this_01 != (TMXObjectGroup *)0x0) {
                    /* try { // try from 00f43c00 to 01043c03 has its CatchHandler @ 00f44238 */
            TMXObjectGroup::TMXObjectGroup(this_01);
          }
          FUN_01211570((string *)&local_590,"name",&local_370);
          std::__detail::
          _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
          ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        *)&local_358,(string *)&local_590);
          cocos2d::Value::asString();
          FUN_01215060(this_01 + 0x28,&local_588);
                    /* try { // try from 00f43c48 to 01043c4b has its CatchHandler @ 00f44248 */
          if ((undefined *)(local_588 + -0x18) != PTR_DAT_017191c0) {
            FUN_006c3514((undefined *)(local_588 + -0x18),(Size *)&local_320);
          }
          if ((undefined *)(local_590 + -0x18) != PTR_DAT_017191c0) {
            FUN_006c3514((undefined *)(local_590 + -0x18),(Size *)&local_320);
          }
          FUN_01211570((string *)&local_580,"x",&local_370);
          pVVar12 = (Value *)std::__detail::
                             _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                             ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                           *)&local_358,(string *)&local_580);
          fVar36 = (float)cocos2d::Value::asFloat(pVVar12);
          fVar45 = *(float *)(this + 0x48);
          if ((undefined *)(local_580 + -0x18) != PTR_DAT_017191c0) {
            FUN_006c3514((undefined *)(local_580 + -0x18),(Size *)&local_320);
          }
          FUN_01211570((string *)&local_578,"y",&local_370);
          pVVar12 = (Value *)std::__detail::
                             _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                             ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                           *)&local_358,(string *)&local_578);
          fVar39 = (float)cocos2d::Value::asFloat(pVVar12);
          fVar44 = *(float *)(this + 0x4c);
          if ((undefined *)(local_578 + -0x18) != PTR_DAT_017191c0) {
            FUN_006c3514((undefined *)(local_578 + -0x18),(Size *)&local_320);
          }
          puVar32 = *(undefined8 **)(this + 0x90);
          puVar23 = *(undefined8 **)(this + 0x88);
                    /* try { // try from 00f43d0c to 01043deb has its CatchHandler @ 00f44430 */
          *(float *)(this_01 + 0x30) = fVar36 * fVar45;
          *(float *)(this_01 + 0x34) = fVar39 * fVar44;
          if (puVar23 == puVar32) {
            pvVar15 = *(void **)(this + 0x80);
            lVar24 = *(long *)(this + 0x88) - (long)pvVar15;
            uVar30 = lVar24 >> 3;
            if (uVar30 == 0) {
              uVar10 = 8;
LAB_00f44c04:
              pvVar16 = operator_new(uVar10);
              pvVar15 = *(void **)(this + 0x80);
              lVar24 = *(long *)(this + 0x88) - (long)pvVar15;
            }
            else {
              uVar25 = uVar30 * 2;
              uVar10 = 0xfffffffffffffff8;
                    /* try { // try from 00f44c8c to 01044c8f has its CatchHandler @ 00f45204 */
              if ((uVar25 < uVar30) || (0x1fffffffffffffff < uVar25)) goto LAB_00f44c04;
              uVar10 = uVar30 << 4;
              pvVar16 = (void *)0x0;
              if (uVar25 != 0) goto LAB_00f44c04;
            }
                    /* try { // try from 00f44c24 to 01044c27 has its CatchHandler @ 00f45204 */
            if ((long)pvVar16 + lVar24 != 0) {
              *(TMXObjectGroup **)((long)pvVar16 + lVar24) = this_01;
                    /* try { // try from 00f44c30 to 01044c33 has its CatchHandler @ 00f452cc */
              pvVar15 = *(void **)(this + 0x80);
              lVar24 = *(long *)(this + 0x88) - (long)pvVar15;
            }
                    /* try { // try from 00f44c40 to 01044c43 has its CatchHandler @ 00f452d0 */
            if (lVar24 >> 3 != 0) {
              memmove(pvVar16,pvVar15,lVar24);
              pvVar15 = *(void **)(this + 0x80);
            }
            if (pvVar15 != (void *)0x0) {
              operator_delete(pvVar15);
            }
            *(void **)(this + 0x80) = pvVar16;
            *(long *)(this + 0x88) = (long)pvVar16 + lVar24 + 8;
            *(ulong *)(this + 0x90) = (long)pvVar16 + uVar10;
          }
          else {
            if (puVar23 != (undefined8 *)0x0) {
              *puVar23 = this_01;
            }
            *(long *)(this + 0x88) = *(long *)(this + 0x88) + 8;
          }
          cocos2d::Ref::retain((Ref *)this_01);
          cocos2d::Ref::release((Ref *)this_01);
          *(undefined4 *)(this + 0x98) = 3;
        }
        else {
          iVar6 = FUN_01213398(&local_690,"tileoffset");
          if (iVar6 == 0) {
            lVar24 = *(long *)(*(long *)(this + 0x70) + -8);
            FUN_01211570((string *)&local_570,"x",&local_370);
            pVVar12 = (Value *)std::__detail::
                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                               ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                             *)&local_358,(string *)&local_570);
            dVar42 = (double)cocos2d::Value::asDouble(pVVar12);
                    /* try { // try from 00f44080 to 010440f7 has its CatchHandler @ 00f44430 */
            if ((undefined *)(local_570 + -0x18) != PTR_DAT_017191c0) {
              FUN_006c3514((undefined *)(local_570 + -0x18),(Size *)&local_320);
            }
            FUN_01211570((string *)&local_568,"y",&local_370);
            pVVar12 = (Value *)std::__detail::
                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                               ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                             *)&local_358,(string *)&local_568);
            dVar43 = (double)cocos2d::Value::asDouble(pVVar12);
            if ((undefined *)(local_568 + -0x18) != PTR_DAT_017191c0) {
              FUN_006c3514((undefined *)(local_568 + -0x18),(Size *)&local_320);
            }
            *(float *)(lVar24 + 0x44) = (float)dVar42;
            *(float *)(lVar24 + 0x48) = (float)dVar43;
          }
          else {
                    /* catch() { ... } // from try @ 00f42f1c with catch @ 00f44314 */
                    /* catch() { ... } // from try @ 00f42eec with catch @ 00f4431c */
            iVar6 = FUN_01213398(&local_690,"image");
                    /* catch() { ... } // from try @ 00f43f24 with catch @ 00f44324 */
            if (iVar6 == 0) {
                    /* catch() { ... } // from try @ 00f43e04 with catch @ 00f44328 */
              lVar24 = *(long *)(*(long *)(this + 0x70) + -8);
              FUN_01211570((string *)&local_560,"source",&local_380);
                    /* catch() { ... } // from try @ 00f43e14 with catch @ 00f44350 */
              std::__detail::
              _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
              ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            *)&local_358,(string *)&local_560);
                    /* catch() { ... } // from try @ 00f4309c with catch @ 00f44360 */
              cocos2d::Value::asString();
                    /* catch() { ... } // from try @ 00f430e0 with catch @ 00f44368 */
                    /* catch() { ... } // from try @ 00f43148 with catch @ 00f4436c */
                    /* catch() { ... } // from try @ 00f431d8 with catch @ 00f44370 */
                    /* catch() { ... } // from try @ 00f43218 with catch @ 00f44374 */
              if ((undefined *)(local_560 + -0x18) != PTR_DAT_017191c0) {
                FUN_006c3514((undefined *)(local_560 + -0x18),(Size *)&local_320);
              }
                    /* catch() { ... } // from try @ 00f43270 with catch @ 00f44384 */
              FUN_01215060(lVar24 + 0x60,&local_370);
                    /* catch() { ... } // from try @ 00f432ec with catch @ 00f44398 */
              pTVar1 = this + 0xe8;
                    /* catch() { ... } // from try @ 00f4332c with catch @ 00f443a0 */
                    /* catch() { ... } // from try @ 00f43a28 with catch @ 00f443a4 */
              lVar14 = FUN_01212c40(pTVar1,"/",0xffffffffffffffff,1);
                    /* catch() { ... } // from try @ 00f43a68 with catch @ 00f443a8 */
                    /* catch() { ... } // from try @ 00f43aa8 with catch @ 00f443ac */
              if (lVar14 == -1) {
                pcVar20 = "/";
                if (*(long *)(*(long *)(this + 0xf0) + -0x18) == 0) {
                  pcVar20 = "";
                }
                FUN_01214ee0(&local_550);
                uVar17 = strlen(pcVar20);
                FUN_0121218c(&local_550,pcVar20,uVar17);
                    /* try { // try from 00f44810 to 01044813 has its CatchHandler @ 00f45204 */
                plVar11 = (long *)FUN_01211fcc(&local_550,&local_370);
                    /* try { // try from 00f4481c to 0104481f has its CatchHandler @ 00f4528c */
                    /* try { // try from 00f4482c to 0104482f has its CatchHandler @ 00f4520c */
                local_320 = (undefined8 *)*plVar11;
                *plVar11 = (long)(PTR_DAT_017191c0 + 0x18);
                FUN_0121258c(lVar24 + 0x50,(Size *)&local_320);
                if (local_320 + -3 != (undefined8 *)PTR_DAT_017191c0) {
                  FUN_006c3514(local_320 + -3,&local_380);
                }
                if ((undefined *)(local_550 + -0x18) != PTR_DAT_017191c0) {
                  FUN_006c3514((undefined *)(local_550 + -0x18),(Size *)&local_320);
                }
              }
              else {
                    /* catch() { ... } // from try @ 00f43ab8 with catch @ 00f443bc */
                lVar14 = FUN_01212c40(pTVar1,"/",0xffffffffffffffff,1);
                    /* catch() { ... } // from try @ 00f43ac8 with catch @ 00f443cc */
                    /* catch() { ... } // from try @ 00f43b24 with catch @ 00f443d0 */
                FUN_0121113c((Size *)&local_320,pTVar1,0,lVar14 + 1);
                    /* catch() { ... } // from try @ 00f43ba8 with catch @ 00f443e0 */
                    /* catch() { ... } // from try @ 00f43be4 with catch @ 00f443e8 */
                FUN_01214ee0(&local_558,(Size *)&local_320);
                    /* catch() { ... } // from try @ 00f436b4 with catch @ 00f443f0 */
                FUN_01211fcc(&local_558,&local_370);
                    /* catch() { ... } // from try @ 00f436e4 with catch @ 00f44400 */
                FUN_0121258c(lVar24 + 0x50,&local_558);
                    /* catch() { ... } // from try @ 00f42fc8 with catch @ 00f44414
                       catch() { ... } // from try @ 00f43198 with catch @ 00f44414
                       catch() { ... } // from try @ 00f432b8 with catch @ 00f44414
                       catch() { ... } // from try @ 00f43420 with catch @ 00f44414
                       catch() { ... } // from try @ 00f4353c with catch @ 00f44414
                       catch() { ... } // from try @ 00f4375c with catch @ 00f44414
                       catch() { ... } // from try @ 00f438cc with catch @ 00f44414
                       catch() { ... } // from try @ 00f439f4 with catch @ 00f44414
                       catch() { ... } // from try @ 00f43b68 with catch @ 00f44414 */
                if ((undefined *)(local_558 + -0x18) != PTR_DAT_017191c0) {
                  FUN_006c3514((undefined *)(local_558 + -0x18),&local_380);
                }
                    /* catch() { ... } // from try @ 00f4305c with catch @ 00f4441c */
                    /* catch() { ... } // from try @ 00f43638 with catch @ 00f44420 */
                    /* catch() { ... } // from try @ 00f43678 with catch @ 00f44428 */
                if (local_320 + -3 != (undefined8 *)PTR_DAT_017191c0) {
                  FUN_006c3514(local_320 + -3,&local_380);
                }
              }
                    /* catch() { ... } // from try @ 00f42f58 with catch @ 00f44430
                       catch() { ... } // from try @ 00f435d0 with catch @ 00f44430
                       catch() { ... } // from try @ 00f43d0c with catch @ 00f44430
                       catch() { ... } // from try @ 00f43e44 with catch @ 00f44430
                       catch() { ... } // from try @ 00f43f1c with catch @ 00f44430
                       catch() { ... } // from try @ 00f43fa4 with catch @ 00f44430
                       catch() { ... } // from try @ 00f44080 with catch @ 00f44430 */
              pVVar12 = local_370 + -0x18;
                    /* catch() { ... } // from try @ 00f43834 with catch @ 00f4443c */
              if (pVVar12 != (Value *)PTR_DAT_017191c0) {
LAB_00f44440:
                FUN_006c3514(pVVar12,(Size *)&local_320);
              }
            }
            else {
                    /* try { // try from 00f44878 to 0104487b has its CatchHandler @ 00f45204 */
              iVar6 = FUN_01213398(&local_690,"data");
              if (iVar6 == 0) {
                    /* try { // try from 00f44888 to 0104488b has its CatchHandler @ 00f45298 */
                FUN_01211570((string *)&local_548,"encoding",&local_370);
                std::__detail::
                _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                              *)&local_358,(string *)&local_548);
                cocos2d::Value::asString();
                if ((undefined *)(local_548 + -0x18) != PTR_DAT_017191c0) {
                  FUN_006c3514((undefined *)(local_548 + -0x18),(Size *)&local_320);
                }
                FUN_01211570((string *)&local_540,"compression",local_390);
                std::__detail::
                _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                              *)&local_358,(string *)&local_540);
                cocos2d::Value::asString();
                if ((undefined *)(local_540 + -0x18) != PTR_DAT_017191c0) {
                  FUN_006c3514((undefined *)(local_540 + -0x18),(Size *)&local_320);
                }
                    /* try { // try from 00f44914 to 01044917 has its CatchHandler @ 00f45204 */
                iVar6 = FUN_01213398(&local_380,&DAT_012fc3d8);
                if (iVar6 == 0) {
                    /* try { // try from 00f44920 to 01044923 has its CatchHandler @ 00f4529c */
                    /* try { // try from 00f44930 to 01044933 has its CatchHandler @ 00f452a0 */
                  lVar24 = *(long *)(*(long *)(this + 0x58) + -8);
                  *(uint *)(this + 0xa0) = *(uint *)(this + 0xa0) | 1;
                  Size::Size((Size *)&local_320,(Size *)(lVar24 + 0x68));
                  uVar30 = -(ulong)((uint)(int)((float)local_320 * local_320._4_4_) >> 0x1f) &
                           0xfffffffc00000000 |
                           (ulong)(uint)(int)((float)local_320 * local_320._4_4_) << 2;
                  uVar17 = malloc(uVar30);
                  memset(uVar17,0,uVar30);
                  *(undefined8 *)(lVar24 + 0x70) = uVar17;
                }
                else {
                  iVar6 = FUN_01213398(&local_380,"base64");
                  if (iVar6 == 0) {
                    this[0xa4] = (TMXMapInfo)0x1;
                    *(uint *)(this + 0xa0) = *(uint *)(this + 0xa0) | 2;
                    iVar6 = FUN_01213398(&local_370,&DAT_01363610);
                    if (iVar6 == 0) {
                      *(uint *)(this + 0xa0) = *(uint *)(this + 0xa0) | 4;
                    }
                    else {
                      iVar6 = FUN_01213398(&local_370,&DAT_01284450);
                      if (iVar6 == 0) {
                    /* try { // try from 00f44f98 to 01044f9b has its CatchHandler @ 00f45204 */
                        *(uint *)(this + 0xa0) = *(uint *)(this + 0xa0) | 8;
                      }
                    }
                  }
                  else {
                    iVar6 = FUN_01213398(&local_380,&DAT_01363618);
                    if (iVar6 == 0) {
                      this[0xa4] = (TMXMapInfo)0x1;
                      *(uint *)(this + 0xa0) = *(uint *)(this + 0xa0) | 0x10;
                    }
                  }
                }
                    /* try { // try from 00f4497c to 0104497f has its CatchHandler @ 00f45204 */
                if (local_370 + -0x18 != (Value *)PTR_DAT_017191c0) {
                  FUN_006c3514(local_370 + -0x18,(Size *)&local_320);
                }
                    /* try { // try from 00f4498c to 0104498f has its CatchHandler @ 00f452b0 */
                pVVar12 = (Value *)(local_380 + -0x18);
                if (pVVar12 != (Value *)PTR_DAT_017191c0) goto LAB_00f44440;
              }
              else {
                iVar6 = FUN_01213398(&local_690,"object");
                if (iVar6 == 0) {
                  lVar24 = *(long *)(*(long *)(this + 0x88) + -8);
                  local_310 = 0;
                  local_308 = 0;
                  local_300[0] = 0x3f800000;
                  local_2f8 = 0;
                  local_318 = FUN_0120ff88(local_300,10);
                  if (local_318 == 1) {
                    local_320 = &local_2f0;
                    local_2f0 = 0;
                  }
                  else {
                    local_320 = (undefined8 *)FUN_00f402b4();
                  }
                  local_178[0] = "name";
                    /* try { // try from 00f44a18 to 01044a1b has its CatchHandler @ 00f45204 */
                  ppcVar35 = local_178;
                    /* try { // try from 00f44a24 to 01044a27 has its CatchHandler @ 00f452b4 */
                  local_178[1] = "type";
                    /* try { // try from 00f44a34 to 01044a37 has its CatchHandler @ 00f452b8 */
                  local_168[2] = "gid";
                  local_168[0] = "width";
                  local_168[1] = "height";
                  local_168[3] = "id";
                  do {
                    pcVar20 = *ppcVar35;
                    FUN_01211570((string *)&local_538,pcVar20,local_390);
                    pVVar12 = (Value *)std::__detail::
                                       _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,(string *)&local_538);
                    cocos2d::Value::Value((Value *)&local_370,pVVar12);
                    if ((undefined *)(local_538 + -0x18) != PTR_DAT_017191c0) {
                      FUN_006c3514((undefined *)(local_538 + -0x18),&local_380);
                    }
                    /* try { // try from 00f44a84 to 01044a87 has its CatchHandler @ 00f45204 */
                    FUN_01211570((string *)&local_530,pcVar20,local_390);
                    /* try { // try from 00f44a94 to 01044a97 has its CatchHandler @ 00f452bc */
                    pVVar12 = (Value *)std::__detail::
                                       _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_320,(string *)&local_530);
                    cocos2d::Value::operator=(pVVar12,(Value *)&local_370);
                    if ((undefined *)(local_530 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00f45648 with catch @ 00f4583c */
                      FUN_006c3514((undefined *)(local_530 + -0x18),&local_380);
                    }
                    ppcVar35 = ppcVar35 + 1;
                    cocos2d::Value::~Value((Value *)&local_370);
                  } while (local_168 + 4 != ppcVar35);
                    /* try { // try from 00f4536c to 0104536f has its CatchHandler @ 00f4548c */
                  FUN_01211570((string *)&local_528,"x",(Size *)&local_380);
                    /* try { // try from 00f45388 to 0104538b has its CatchHandler @ 00f45468 */
                  pVVar12 = (Value *)std::__detail::
                                     _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,(string *)&local_528);
                  iVar6 = cocos2d::Value::asInt(pVVar12);
                  if ((undefined *)(local_528 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f453ac to 010453af has its CatchHandler @ 00f454f8 */
                    FUN_006c3514((undefined *)(local_528 + -0x18),(Value *)&local_370);
                  }
                  FUN_01211570((string *)&local_520,"y",(Size *)&local_380);
                    /* try { // try from 00f453c8 to 010453cb has its CatchHandler @ 00f454b8 */
                  pVVar12 = (Value *)std::__detail::
                                     _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,(string *)&local_520);
                  iVar7 = cocos2d::Value::asInt(pVVar12);
                  if ((undefined *)(local_520 + -0x18) != PTR_DAT_017191c0) {
                    FUN_006c3514((undefined *)(local_520 + -0x18),(Value *)&local_370);
                  }
                  fVar45 = *(float *)(this + 0x4c);
                  fVar44 = *(float *)(this + 0x44);
                  fVar39 = *(float *)(lVar24 + 0x30);
                  fVar36 = *(float *)(lVar24 + 0x34);
                  FUN_01211570((string *)&local_518,"height",(Size *)&local_380);
                  pVVar12 = (Value *)std::__detail::
                                     _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,(string *)&local_518);
                  iVar8 = cocos2d::Value::asInt(pVVar12);
                  if ((undefined *)(local_518 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00f45388 with catch @ 00f45468 */
                    FUN_006c3514((undefined *)(local_518 + -0x18),(Value *)&local_370);
                  }
                  lVar14 = Director::getInstance();
                  fVar40 = *(float *)(lVar14 + 0x200);
                  lVar14 = Director::getInstance();
                  fVar41 = *(float *)(lVar14 + 0x200);
                    /* try { // try from 00f45488 to 0104548b has its CatchHandler @ 00f454fc */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f4536c with catch @ 00f4548c
                        */
                  FUN_01211570((string *)&local_510,"x",(Size *)&local_380);
                  pVVar12 = (Value *)std::__detail::
                                     _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_320,(string *)&local_510);
                    /* catch() { ... } // from try @ 00f453c8 with catch @ 00f454b8 */
                  cocos2d::Value::Value(aVStack_430,((float)iVar6 + fVar39) / fVar40);
                  cocos2d::Value::operator=(pVVar12,aVStack_430);
                  cocos2d::Value::~Value(aVStack_430);
                  if ((undefined *)(local_510 + -0x18) != PTR_DAT_017191c0) {
                    FUN_006c3514((undefined *)(local_510 + -0x18),(Value *)&local_370);
                  }
                    /* try { // try from 00f454f4 to 010454f7 has its CatchHandler @ 00f4550c */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f453ac with catch @ 00f454f8
                        */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f45488 with catch @ 00f454fc
                        */
                  FUN_01211570((string *)&local_508,"y",(Size *)&local_380);
                    /* try { // try from 00f45508 to 0104550b has its CatchHandler @ 00f452e0 */
                    /* catch() { ... } // from try @ 00f454f4 with catch @ 00f4550c */
                  pVVar12 = (Value *)std::__detail::
                                     _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_320,(string *)&local_508);
                  cocos2d::Value::Value
                            (aVStack_420,
                             (((fVar44 * fVar45 - (float)iVar7) - fVar36) - (float)iVar8) / fVar41);
                  cocos2d::Value::operator=(pVVar12,aVStack_420);
                  cocos2d::Value::~Value(aVStack_420);
                    /* catch() { ... } // from try @ 00f45608 with catch @ 00f45548
                       catch() { ... } // from try @ 00f4568c with catch @ 00f45548
                       catch() { ... } // from try @ 00f4581c with catch @ 00f45548 */
                  if ((undefined *)(local_508 + -0x18) != PTR_DAT_017191c0) {
                    FUN_006c3514((undefined *)(local_508 + -0x18),(Value *)&local_370);
                  }
                  FUN_01211570((string *)&local_500,"width",(Size *)&local_380);
                  pVVar12 = (Value *)std::__detail::
                                     _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,(string *)&local_500);
                  iVar6 = cocos2d::Value::asInt(pVVar12);
                  if ((undefined *)(local_500 + -0x18) != PTR_DAT_017191c0) {
                    FUN_006c3514((undefined *)(local_500 + -0x18),(Value *)&local_370);
                  }
                  FUN_01211570((string *)&local_4f8,"height",(Size *)&local_380);
                  pVVar12 = (Value *)std::__detail::
                                     _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,(string *)&local_4f8);
                  iVar7 = cocos2d::Value::asInt(pVVar12);
                  if ((undefined *)(local_4f8 + -0x18) != PTR_DAT_017191c0) {
                    FUN_006c3514((undefined *)(local_4f8 + -0x18),(Value *)&local_370);
                  }
                  Size::Size((Size *)&local_380,(float)iVar6,(float)iVar7);
                  fVar36 = (float)local_380;
                  lVar14 = Director::getInstance();
                  fVar39 = *(float *)(lVar14 + 0x200);
                  fVar45 = local_380._4_4_;
                  lVar14 = Director::getInstance();
                    /* try { // try from 00f45608 to 01045617 has its CatchHandler @ 00f45548 */
                  Size::Size((Size *)&local_370,fVar36 / fVar39,fVar45 / *(float *)(lVar14 + 0x200))
                  ;
                  Size::operator=((Size *)&local_380,(Size *)&local_370);
                    /* try { // try from 00f4562c to 0104562f has its CatchHandler @ 00f45820 */
                  FUN_01211570((string *)&local_4f0,"width",local_390);
                    /* try { // try from 00f45648 to 0104564b has its CatchHandler @ 00f4583c */
                  pVVar12 = (Value *)std::__detail::
                                     _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_320,(string *)&local_4f0);
                  cocos2d::Value::Value(aVStack_410,(float)local_380);
                  cocos2d::Value::operator=(pVVar12,aVStack_410);
                  cocos2d::Value::~Value(aVStack_410);
                  if ((undefined *)(local_4f0 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f4568c to 0104568f has its CatchHandler @ 00f45548 */
                    FUN_006c3514((undefined *)(local_4f0 + -0x18),(Value *)&local_370);
                  }
                    /* try { // try from 00f456a0 to 010456a3 has its CatchHandler @ 00f4580c */
                  FUN_01211570((string *)&local_4e8,"height",local_390);
                  pVVar12 = (Value *)std::__detail::
                                     _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_320,(string *)&local_4e8);
                    /* try { // try from 00f456b4 to 01045793 has its CatchHandler @ 00f45820 */
                  cocos2d::Value::Value(aVStack_400,local_380._4_4_);
                  cocos2d::Value::operator=(pVVar12,aVStack_400);
                  cocos2d::Value::~Value(aVStack_400);
                  if ((undefined *)(local_4e8 + -0x18) != PTR_DAT_017191c0) {
                    FUN_006c3514((undefined *)(local_4e8 + -0x18),(Value *)&local_370);
                  }
                  cocos2d::Value::Value((Value *)&local_370,(Size *)&local_320);
                  pVVar12 = *(Value **)(lVar24 + 0x78);
                  if (pVVar12 == *(Value **)(lVar24 + 0x80)) {
                    std::vector<cocos2d::Value,std::allocator<cocos2d::Value>>::
                    _M_emplace_back_aux<cocos2d::Value>
                              ((vector<cocos2d::Value,std::allocator<cocos2d::Value>> *)
                               (lVar24 + 0x70),(Value *)&local_370);
                  }
                  else {
                    lVar14 = 0;
                    if (pVVar12 != (Value *)0x0) {
                      cocos2d::Value::Value(pVVar12,(Value *)&local_370);
                      lVar14 = *(long *)(lVar24 + 0x78);
                    }
                    *(long *)(lVar24 + 0x78) = lVar14 + 0x10;
                  }
                  cocos2d::Value::~Value((Value *)&local_370);
                  *(undefined4 *)(this + 0x98) = 4;
                  std::
                  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                  ::~_Hashtable((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                                 *)&local_320);
                }
                else {
                  iVar6 = FUN_01213398(&local_690,"property");
                  if (iVar6 == 0) {
                    iVar6 = *(int *)(this + 0x98);
                    /* try { // try from 00f458c4 to 010458ef has its CatchHandler @ 00f45860 */
                    if (iVar6 != 0) {
                      if (iVar6 == 1) {
                        FUN_01211570((string *)&local_4e0,"value",&local_380);
                        pVVar12 = (Value *)std::__detail::
                                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                           ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,(string *)&local_4e0);
                    /* try { // try from 00f45d28 to 01045dff has its CatchHandler @ 00f45ef0 */
                        cocos2d::Value::Value((Value *)&local_320,pVVar12);
                        if ((undefined *)(local_4e0 + -0x18) != PTR_DAT_017191c0) {
                          FUN_006c3514((undefined *)(local_4e0 + -0x18),&local_370);
                        }
                        FUN_01211570((string *)&local_4d8,"name",local_390);
                        std::__detail::
                        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                      *)&local_358,(string *)&local_4d8);
                        cocos2d::Value::asString();
                        if ((undefined *)(local_4d8 + -0x18) != PTR_DAT_017191c0) {
                          FUN_006c3514((undefined *)(local_4d8 + -0x18),&local_380);
                        }
                        std::
                        _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                        ::_M_emplace<std::string&,cocos2d::Value&>
                                  ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                                    *)(this + 0xa8),0,&local_370,(Size *)&local_320);
                      }
                      else if (iVar6 == 2) {
                        pTVar13 = *(TMXLayerInfo **)(*(long *)(this + 0x58) + -8);
                        FUN_01211570((string *)&local_4d0,"value",&local_380);
                    /* try { // try from 00f45c58 to 01045c5b has its CatchHandler @ 00f45f28 */
                        pVVar12 = (Value *)std::__detail::
                                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                           ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,(string *)&local_4d0);
                        cocos2d::Value::Value((Value *)&local_320,pVVar12);
                    /* try { // try from 00f45c68 to 01045c6b has its CatchHandler @ 00f45ef8 */
                        if ((undefined *)(local_4d0 + -0x18) != PTR_DAT_017191c0) {
                          FUN_006c3514((undefined *)(local_4d0 + -0x18),&local_370);
                        }
                    /* try { // try from 00f45c94 to 01045c97 has its CatchHandler @ 00f45ec8 */
                        FUN_01211570((string *)&local_4c8,"name",local_390);
                        std::__detail::
                        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                      *)&local_358,(string *)&local_4c8);
                        cocos2d::Value::asString();
                        if ((undefined *)(local_4c8 + -0x18) != PTR_DAT_017191c0) {
                          FUN_006c3514((undefined *)(local_4c8 + -0x18),&local_380);
                        }
                        p_Var19 = (_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                                   *)TMXLayerInfo::getProperties(pTVar13);
                        std::
                        _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                        ::_M_emplace<std::string&,cocos2d::Value&>
                                  (p_Var19,0,&local_370,(Size *)&local_320);
                      }
                      else {
                        if (iVar6 != 3) {
                          if (iVar6 == 4) {
                            p_Var18 = (_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       *)cocos2d::Value::asValueMap
                                                   ((Value *)(*(long *)(*(long *)(*(long *)(this + 
                                                  0x88) + -8) + 0x78) + -0x10));
                    /* try { // try from 00f45a7c to 01045a7f has its CatchHandler @ 00f45ec8 */
                            FUN_01211570((string *)&local_4b0,"name",&local_380);
                    /* try { // try from 00f45a84 to 01045a87 has its CatchHandler @ 00f45e74 */
                            std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                          *)&local_358,(string *)&local_4b0);
                    /* try { // try from 00f45a94 to 01045a97 has its CatchHandler @ 00f45f38 */
                            cocos2d::Value::asString();
                            if ((undefined *)(local_4b0 + -0x18) != PTR_DAT_017191c0) {
                              FUN_006c3514((undefined *)(local_4b0 + -0x18),&local_370);
                            }
                            pVVar12 = (Value *)std::__detail::
                                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                               ::operator[](p_Var18,(string *)&local_320);
                            psVar33 = asStack_4a8;
                            FUN_01211570(psVar33,"value",&local_380);
                    /* try { // try from 00f45adc to 01045c3f has its CatchHandler @ 00f45ec8 */
                            pVVar21 = (Value *)std::__detail::
                                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                               ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,psVar33);
                            cocos2d::Value::operator=(pVVar12,pVVar21);
                          }
                          else {
                            if (iVar6 != 5) goto LAB_00f42f2c;
                            iVar6 = *(int *)(this + 0x9c);
                    /* try { // try from 00f45900 to 01045903 has its CatchHandler @ 00f45e04 */
                            uVar10 = *(ulong *)(this + 0x108);
                            local_320 = (undefined8 *)CONCAT44(local_320._4_4_,iVar6);
                            uVar30 = 0;
                            if (uVar10 != 0) {
                              uVar30 = (ulong)(long)iVar6 / uVar10;
                            }
                            plVar11 = (long *)FUN_00f40254(this + 0x100,
                                                           (long)iVar6 - uVar30 * uVar10,
                                                           (Size *)&local_320);
                            if ((plVar11 == (long *)0x0) || (*plVar11 == 0)) {
                    /* WARNING: Subroutine does not return */
                              FUN_0120f454("_Map_base::at");
                            }
                            p_Var18 = (_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       *)cocos2d::Value::asValueMap((Value *)(*plVar11 + 0x10));
                    /* try { // try from 00f45938 to 0104593b has its CatchHandler @ 00f45ef0 */
                    /* try { // try from 00f45944 to 01045947 has its CatchHandler @ 00f45ee8 */
                            FUN_01211570((string *)&local_4a0,"name",&local_380);
                    /* try { // try from 00f45950 to 01045953 has its CatchHandler @ 00f45ee0 */
                            std::__detail::
                            _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                            ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                          *)&local_358,(string *)&local_4a0);
                    /* try { // try from 00f4595c to 0104595f has its CatchHandler @ 00f45ed8 */
                            cocos2d::Value::asString();
                    /* try { // try from 00f45968 to 0104596b has its CatchHandler @ 00f45ed0 */
                            if ((undefined *)(local_4a0 + -0x18) != PTR_DAT_017191c0) {
                              FUN_006c3514((undefined *)(local_4a0 + -0x18),&local_370);
                            }
                            pVVar12 = (Value *)std::__detail::
                                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                               ::operator[](p_Var18,(string *)&local_320);
                            psVar33 = local_498;
                            FUN_01211570(psVar33,"value",&local_380);
                            pVVar21 = (Value *)std::__detail::
                                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                               ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,psVar33);
                    /* try { // try from 00f459b8 to 010459f3 has its CatchHandler @ 00f45ec8 */
                            cocos2d::Value::operator=(pVVar12,pVVar21);
                          }
                          if ((undefined *)(*(long *)psVar33 + -0x18) != PTR_DAT_017191c0) {
                            FUN_006c3514((undefined *)(*(long *)psVar33 + -0x18),&local_370);
                          }
                          if (local_320 + -3 != (undefined8 *)PTR_DAT_017191c0) {
                            FUN_006c3514(local_320 + -3,&local_370);
                          }
                          goto LAB_00f42f2c;
                        }
                        lVar24 = *(long *)(*(long *)(this + 0x88) + -8);
                        FUN_01211570((string *)&local_4c0,"value",&local_380);
                        pVVar12 = (Value *)std::__detail::
                                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                           ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_358,(string *)&local_4c0);
                        cocos2d::Value::Value((Value *)&local_320,pVVar12);
                        if ((undefined *)(local_4c0 + -0x18) != PTR_DAT_017191c0) {
                          FUN_006c3514((undefined *)(local_4c0 + -0x18),&local_370);
                        }
                        FUN_01211570((string *)&local_4b8,"name",local_390);
                        std::__detail::
                        _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                        ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                      *)&local_358,(string *)&local_4b8);
                        cocos2d::Value::asString();
                        if ((undefined *)(local_4b8 + -0x18) != PTR_DAT_017191c0) {
                          FUN_006c3514((undefined *)(local_4b8 + -0x18),&local_380);
                        }
                        std::
                        _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                        ::_M_emplace<std::string&,cocos2d::Value&>
                                  ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                                    *)(lVar24 + 0x38),0,&local_370,(Size *)&local_320);
                      }
                      if (local_370 + -0x18 != (Value *)PTR_DAT_017191c0) {
                        FUN_006c3514(local_370 + -0x18,&local_380);
                      }
                      cocos2d::Value::~Value((Value *)&local_320);
                    }
                  }
                  else {
                    iVar6 = FUN_01213398(&local_690,"polygon");
                    if (iVar6 == 0) {
                      lVar24 = *(long *)(*(long *)(this + 0x88) + -8);
                      p_Var18 = (_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                 *)cocos2d::Value::asValueMap
                                             ((Value *)(*(long *)(lVar24 + 0x78) + -0x10));
                    /* catch() { ... } // from try @ 00f45900 with catch @ 00f45e04 */
                      FUN_01211570((string *)&local_490,"points",
                                   (vector<cocos2d::Value,std::allocator<cocos2d::Value>> *)
                                   &local_370);
                    /* try { // try from 00f45e14 to 01045e17 has its CatchHandler @ 00f45860 */
                      std::__detail::
                      _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                      ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                    *)&local_358,(string *)&local_490);
                    /* try { // try from 00f45e20 to 01045e6f has its CatchHandler @ 00f45ef0 */
                      cocos2d::Value::asString();
                      if ((undefined *)(local_490 + -0x18) != PTR_DAT_017191c0) {
                        FUN_006c3514((undefined *)(local_490 + -0x18),(Size *)&local_320);
                      }
                      if (*(long *)(local_3b0[0] + -0x18) != 0) {
                    /* catch() { ... } // from try @ 00f46118 with catch @ 00f46440 */
                        local_370 = (Value *)0x0;
                        local_368 = (Value *)0x0;
                        local_360 = (Value *)0x0;
                        std::vector<cocos2d::Value,std::allocator<cocos2d::Value>>::reserve
                                  ((vector<cocos2d::Value,std::allocator<cocos2d::Value>> *)
                                   &local_370,10);
                    /* catch() { ... } // from try @ 00f46094 with catch @ 00f4645c */
                    /* catch() { ... } // from try @ 00f461f0 with catch @ 00f46464 */
                        FUN_011f14e4(auStack_2e8,local_3b0,0x18);
                    /* catch() { ... } // from try @ 00f46234 with catch @ 00f46478 */
                        local_3a0[0] = PTR_DAT_017191c0 + 0x18;
                    /* catch() { ... } // from try @ 00f4650c with catch @ 00f46484
                       catch() { ... } // from try @ 00f465f8 with catch @ 00f46484 */
                    /* try { // try from 00f46678 to 0104667b has its CatchHandler @ 00f46608 */
                        while (plVar11 = (long *)FUN_011d3940(auStack_2e8,local_3a0,0x20),
                              (*(uint *)((long)plVar11 + *(long *)(*plVar11 + -0x18) + 0x20) & 5) ==
                              0) {
                          FUN_011cb3fc(local_110);
                          local_30 = 0;
                          pcVar20 = *(char **)(PTR_PTR_0171e188 + 0x10);
                    /* try { // try from 00f466c8 to 010466cb has its CatchHandler @ 00f468d0 */
                          local_110[0] = PTR_DAT_01723948 + 0x10;
                          uVar27 = *(undefined8 *)(PTR_PTR_0171e188 + 0x18);
                          local_38 = 0;
                          local_2f = 0;
                          local_28 = 0;
                          local_20 = 0;
                          local_18 = 0;
                          local_10 = 0;
                          local_178[0] = pcVar20;
                          *(undefined8 *)((long)local_178 + *(long *)(pcVar20 + -0x18)) = uVar27;
                          local_178[1] = (char *)0x0;
                    /* try { // try from 00f46704 to 01046707 has its CatchHandler @ 00f468e4 */
                          FUN_011ca6a8((long)local_178 + *(long *)(pcVar20 + -0x18),0);
                    /* try { // try from 00f46714 to 0104678f has its CatchHandler @ 00f468f4 */
                          pcVar29 = *(char **)(PTR_PTR_0171e188 + 0x20);
                          lVar14 = *(long *)(pcVar29 + -0x18);
                          uVar17 = *(undefined8 *)(PTR_PTR_0171e188 + 0x28);
                          local_168[0] = pcVar29;
                          *(undefined8 *)((long)local_168 + lVar14) = uVar17;
                          FUN_011ca6a8((long)local_168 + lVar14,0);
                          lVar14 = *(long *)(PTR_PTR_0171e188 + 8);
                          uVar28 = *(undefined8 *)(PTR_PTR_0171e188 + 0x30);
                          *(undefined8 *)((long)local_178 + *(long *)(lVar14 + -0x18)) = uVar28;
                          local_178[0] = PTR_DAT_01718f80 + 0x18;
                          local_110[0] = PTR_DAT_01718f80 + 0x68;
                          local_168[1] = PTR_DAT_0171c368 + 0x10;
                          local_168[0] = PTR_DAT_01718f80 + 0x40;
                          local_168[2] = (undefined *)0x0;
                          local_168[3] = (char *)0x0;
                          local_168[4] = (char *)0x0;
                          local_168[5] = (char *)0x0;
                          local_168[6] = (char *)0x0;
                    /* try { // try from 00f467a8 to 010467ab has its CatchHandler @ 00f46904 */
                          local_168[7] = (char *)0x0;
                    /* try { // try from 00f467b4 to 010467b7 has its CatchHandler @ 00f46914 */
                          FUN_011e78a8(auStack_128);
                          local_168[1] = PTR_DAT_01718978 + 0x10;
                          local_120 = 0;
                          FUN_01211434(&local_118,local_3a0[0],*(undefined8 *)(local_3a0[0] + -0x18)
                                       ,(Size *)&local_320);
                    /* try { // try from 00f467e8 to 0104682f has its CatchHandler @ 00f46924 */
                          local_120 = 0x18;
                          FUN_011ef90c(local_168 + 1,local_118,0,0);
                          FUN_011ca6a8(local_110,local_168 + 1);
                          local_310 = 0;
                          local_390[0] = PTR_DAT_017191c0 + 0x18;
                          local_308 = 0;
                          local_300[0] = 0x3f800000;
                          local_2f8 = 0;
                          local_380 = local_390[0];
                          local_318 = FUN_0120ff88(local_300,10);
                          if (local_318 == 1) {
                            local_320 = &local_2f0;
                            local_2f0 = 0;
                          }
                          else {
                            local_320 = (undefined8 *)FUN_00f402b4();
                          }
                          plVar11 = (long *)FUN_011d3940(local_178,local_390,0x2c);
                          if ((*(uint *)((long)plVar11 + *(long *)(*plVar11 + -0x18) + 0x20) & 5) ==
                              0) {
                            iVar6 = atoi(local_390[0]);
                    /* try { // try from 00f46890 to 01046893 has its CatchHandler @ 00f468d0 */
                            fVar36 = *(float *)(lVar24 + 0x30);
                            FUN_01211570((string *)&local_488,"x",local_3d0);
                            pVVar12 = (Value *)std::__detail::
                                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                               ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_320,(string *)&local_488);
                            cocos2d::Value::Value(aVStack_3f0,iVar6 + (int)fVar36);
                    /* catch() { ... } // from try @ 00f466c8 with catch @ 00f468d0
                       catch() { ... } // from try @ 00f46890 with catch @ 00f468d0 */
                            cocos2d::Value::operator=(pVVar12,aVStack_3f0);
                            cocos2d::Value::~Value(aVStack_3f0);
                    /* try { // try from 00f468e0 to 010468e3 has its CatchHandler @ 00f46608 */
                    /* catch() { ... } // from try @ 00f46704 with catch @ 00f468e4 */
                    /* catch() { ... } // from try @ 00f46714 with catch @ 00f468f4 */
                            if ((undefined *)(local_488 + -0x18) != PTR_DAT_017191c0) {
                              FUN_006c3514((undefined *)(local_488 + -0x18),local_3c0);
                            }
                          }
                          plVar11 = (long *)FUN_011d3940(local_178,&local_380,0x2c);
                          if ((*(uint *)((long)plVar11 + *(long *)(*plVar11 + -0x18) + 0x20) & 5) ==
                              0) {
                            iVar6 = atoi(local_380);
                            fVar36 = *(float *)(lVar24 + 0x34);
                            FUN_01211570((string *)&local_480,"y",local_3d0);
                    /* try { // try from 00f4650c to 0104653b has its CatchHandler @ 00f46484 */
                            pVVar12 = (Value *)std::__detail::
                                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                               ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_320,(string *)&local_480);
                            cocos2d::Value::Value((Value *)local_3e0,iVar6 + (int)fVar36);
                            cocos2d::Value::operator=(pVVar12,(Value *)local_3e0);
                            cocos2d::Value::~Value((Value *)local_3e0);
                            if ((undefined *)(local_480 + -0x18) != PTR_DAT_017191c0) {
                              FUN_006c3514((undefined *)(local_480 + -0x18),local_3c0);
                            }
                          }
                    /* try { // try from 00f46558 to 010465a3 has its CatchHandler @ 00f465d8 */
                          cocos2d::Value::Value((Value *)local_3d0,(Size *)&local_320);
                          if (local_360 == local_368) {
                    /* catch() { ... } // from try @ 00f467a8 with catch @ 00f46904 */
                            std::vector<cocos2d::Value,std::allocator<cocos2d::Value>>::
                            _M_emplace_back_aux<cocos2d::Value>
                                      ((vector<cocos2d::Value,std::allocator<cocos2d::Value>> *)
                                       &local_370,(Value *)local_3d0);
                          }
                          else {
                            if (local_368 != (Value *)0x0) {
                              cocos2d::Value::Value(local_368,(Value *)local_3d0);
                            }
                            local_368 = local_368 + 0x10;
                          }
                          cocos2d::Value::~Value((Value *)local_3d0);
                          std::
                          _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                          ::~_Hashtable((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                                         *)&local_320);
                          if (local_380 + -0x18 != PTR_DAT_017191c0) {
                            FUN_006c3514(local_380 + -0x18,(Size *)&local_320);
                          }
                          if (local_390[0] + -0x18 != PTR_DAT_017191c0) {
                            FUN_006c3514(local_390[0] + -0x18,(Size *)&local_320);
                          }
                    /* catch() { ... } // from try @ 00f46558 with catch @ 00f465d8 */
                          local_178[0] = PTR_DAT_01718f80 + 0x18;
                          local_110[0] = PTR_DAT_01718f80 + 0x68;
                          local_168[0] = PTR_DAT_01718f80 + 0x40;
                    /* try { // try from 00f465f8 to 010465fb has its CatchHandler @ 00f46484 */
                          local_168[1] = PTR_DAT_01718978 + 0x10;
                    /* catch() { ... } // from try @ 00f46678 with catch @ 00f46608
                       catch() { ... } // from try @ 00f468e0 with catch @ 00f46608 */
                          if ((undefined *)(local_118 + -0x18) != PTR_DAT_017191c0) {
                            piVar31 = (int *)(local_118 + -8);
                            if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                              iVar6 = *(int *)(local_118 + -8);
                              *(int *)(local_118 + -8) = iVar6 + -1;
                            }
                            else {
                              do {
                                iVar6 = *piVar31;
                                cVar2 = '\x01';
                                bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
                                if (bVar3) {
                                  *piVar31 = iVar6 + -1;
                                  cVar2 = ExclusiveMonitorsStatus();
                                }
                              } while (cVar2 != '\0');
                            }
                            if (iVar6 < 1) {
                              operator_delete((undefined *)(local_118 + -0x18));
                            }
                          }
                          local_168[1] = PTR_DAT_0171c368 + 0x10;
                          FUN_011e5e48(auStack_128);
                          lVar22 = *(long *)(pcVar29 + -0x18);
                          lVar26 = *(long *)(pcVar20 + -0x18);
                          *(undefined8 *)((long)local_178 + *(long *)(lVar14 + -0x18)) = uVar28;
                          local_168[0] = pcVar29;
                          *(undefined8 *)((long)local_168 + lVar22) = uVar17;
                          local_178[0] = pcVar20;
                          *(undefined8 *)((long)local_178 + lVar26) = uVar27;
                          local_110[0] = PTR_DAT_01723948 + 0x10;
                          FUN_011cb79c(local_110);
                        }
                        FUN_01211570((string *)&local_478,"points",&local_380);
                        pVVar12 = (Value *)std::__detail::
                                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                           ::operator[](p_Var18,(string *)&local_478);
                        cocos2d::Value::Value((Value *)local_3c0,(vector *)&local_370);
                        cocos2d::Value::operator=(pVVar12,(Value *)local_3c0);
                        cocos2d::Value::~Value((Value *)local_3c0);
                        if ((undefined *)(local_478 + -0x18) != PTR_DAT_017191c0) {
                          FUN_006c3514((undefined *)(local_478 + -0x18),(Size *)&local_320);
                        }
                        if (local_3a0[0] + -0x18 != PTR_DAT_017191c0) {
                          FUN_006c3514(local_3a0[0] + -0x18,(Size *)&local_320);
                        }
                        FUN_011ef314(auStack_2e8);
                        pVVar4 = local_368;
                        pVVar21 = local_368;
                        for (pVVar12 = local_370; pVVar12 != pVVar4; pVVar12 = pVVar12 + 0x10) {
                          cocos2d::Value::~Value(pVVar12);
                          pVVar21 = local_370;
                        }
                        if (pVVar21 != (Value *)0x0) {
                          operator_delete(pVVar21);
                        }
                      }
                    }
                    else {
                    /* catch() { ... } // from try @ 00f45a84 with catch @ 00f45e74 */
                      iVar6 = FUN_01213398(&local_690,"polyline");
                      if (iVar6 != 0) goto LAB_00f42f2c;
                      lVar24 = *(long *)(*(long *)(this + 0x88) + -8);
                      p_Var18 = (_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                 *)cocos2d::Value::asValueMap
                                             ((Value *)(*(long *)(lVar24 + 0x78) + -0x10));
                    /* catch() { ... } // from try @ 00f459fc with catch @ 00f45eb8 */
                      FUN_01211570((string *)&local_470,"points",
                                   (vector<cocos2d::Value,std::allocator<cocos2d::Value>> *)
                                   &local_370);
                    /* catch() { ... } // from try @ 00f459b8 with catch @ 00f45ec8
                       catch() { ... } // from try @ 00f45a7c with catch @ 00f45ec8
                       catch() { ... } // from try @ 00f45adc with catch @ 00f45ec8
                       catch() { ... } // from try @ 00f45c94 with catch @ 00f45ec8 */
                      std::__detail::
                      _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                      ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                    *)&local_358,(string *)&local_470);
                    /* catch() { ... } // from try @ 00f45968 with catch @ 00f45ed0 */
                    /* catch() { ... } // from try @ 00f4595c with catch @ 00f45ed8 */
                      cocos2d::Value::asString();
                    /* catch() { ... } // from try @ 00f45950 with catch @ 00f45ee0 */
                    /* catch() { ... } // from try @ 00f45944 with catch @ 00f45ee8 */
                      if ((undefined *)(local_470 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00f45938 with catch @ 00f45ef0
                       catch() { ... } // from try @ 00f45d28 with catch @ 00f45ef0
                       catch() { ... } // from try @ 00f45e20 with catch @ 00f45ef0 */
                        FUN_006c3514((undefined *)(local_470 + -0x18),(Size *)&local_320);
                      }
                    /* catch() { ... } // from try @ 00f45c68 with catch @ 00f45ef8 */
                      local_3b0[0] = local_3e0[0];
                      if (*(long *)(local_3e0[0] + -0x18) != 0) {
                        local_370 = (Value *)0x0;
                        local_368 = (Value *)0x0;
                        local_360 = (Value *)0x0;
                        std::vector<cocos2d::Value,std::allocator<cocos2d::Value>>::reserve
                                  ((vector<cocos2d::Value,std::allocator<cocos2d::Value>> *)
                                   &local_370,10);
                    /* catch() { ... } // from try @ 00f45c58 with catch @ 00f45f28 */
                        FUN_011f14e4(auStack_2e8,local_3e0,0x18);
                    /* catch() { ... } // from try @ 00f45a94 with catch @ 00f45f38 */
                        local_3d0[0] = PTR_DAT_017191c0 + 0x18;
                        while (plVar11 = (long *)FUN_011d3940(auStack_2e8,local_3d0,0x20),
                              (*(uint *)((long)plVar11 + *(long *)(*plVar11 + -0x18) + 0x20) & 5) ==
                              0) {
                          FUN_011f14e4(local_178,local_3d0,0x18);
                          local_310 = 0;
                          local_3c0[0] = PTR_DAT_017191c0 + 0x18;
                          local_308 = 0;
                          local_300[0] = 0x3f800000;
                          local_2f8 = 0;
                          local_380 = local_3c0[0];
                          local_318 = FUN_0120ff88(local_300,10);
                          if (local_318 == 1) {
                            local_320 = &local_2f0;
                            local_2f0 = 0;
                          }
                          else {
                    /* catch() { ... } // from try @ 00f46048 with catch @ 00f45fd8
                       catch() { ... } // from try @ 00f461e0 with catch @ 00f45fd8
                       catch() { ... } // from try @ 00f46408 with catch @ 00f45fd8 */
                            local_320 = (undefined8 *)FUN_00f402b4();
                          }
                          plVar11 = (long *)FUN_011d3940(local_178,local_3c0,0x2c);
                          if ((*(uint *)((long)plVar11 + *(long *)(*plVar11 + -0x18) + 0x20) & 5) ==
                              0) {
                            iVar6 = atoi(local_3c0[0]);
                            fVar36 = *(float *)(lVar24 + 0x30);
                            FUN_01211570((string *)&local_468,"x",(Value *)local_3a0);
                            pVVar12 = (Value *)std::__detail::
                                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                               ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_320,(string *)&local_468);
                            cocos2d::Value::Value((Value *)local_3b0,iVar6 + (int)fVar36);
                            cocos2d::Value::operator=(pVVar12,(Value *)local_3b0);
                    /* try { // try from 00f462b0 to 010462b3 has its CatchHandler @ 00f463f0 */
                            cocos2d::Value::~Value((Value *)local_3b0);
                    /* try { // try from 00f462c0 to 010462c3 has its CatchHandler @ 00f4640c */
                            if ((undefined *)(local_468 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f462d0 to 010462eb has its CatchHandler @ 00f463f0 */
                              FUN_006c3514((undefined *)(local_468 + -0x18),local_390);
                            }
                          }
                          plVar11 = (long *)FUN_011d3940(local_178,&local_380,0x2c);
                          if ((*(uint *)((long)plVar11 + *(long *)(*plVar11 + -0x18) + 0x20) & 5) ==
                              0) {
                    /* try { // try from 00f46048 to 0104604b has its CatchHandler @ 00f45fd8 */
                            iVar6 = atoi(local_380);
                            fVar36 = *(float *)(lVar24 + 0x34);
                            FUN_01211570((string *)&local_460,"y",local_3b0);
                            pVVar12 = (Value *)std::__detail::
                                               _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                               ::operator[]((
                                                  _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                                  *)&local_320,(string *)&local_460);
                            cocos2d::Value::Value((Value *)local_3a0,iVar6 + (int)fVar36);
                    /* try { // try from 00f46094 to 010460eb has its CatchHandler @ 00f4645c */
                            cocos2d::Value::operator=(pVVar12,(Value *)local_3a0);
                            cocos2d::Value::~Value((Value *)local_3a0);
                            if ((undefined *)(local_460 + -0x18) != PTR_DAT_017191c0) {
                              FUN_006c3514((undefined *)(local_460 + -0x18),local_390);
                            }
                          }
                          cocos2d::Value::Value((Value *)local_390,(Size *)&local_320);
                          if (local_360 == local_368) {
                            std::vector<cocos2d::Value,std::allocator<cocos2d::Value>>::
                            _M_emplace_back_aux<cocos2d::Value>
                                      ((vector<cocos2d::Value,std::allocator<cocos2d::Value>> *)
                                       &local_370,(Value *)local_390);
                          }
                          else {
                            if (local_368 != (Value *)0x0) {
                              cocos2d::Value::Value(local_368,(Value *)local_390);
                            }
                            local_368 = local_368 + 0x10;
                          }
                          cocos2d::Value::~Value((Value *)local_390);
                          std::
                          _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                          ::~_Hashtable((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                                         *)&local_320);
                    /* try { // try from 00f46118 to 0104611b has its CatchHandler @ 00f46440 */
                          if (local_380 + -0x18 != PTR_DAT_017191c0) {
                            FUN_006c3514(local_380 + -0x18,(Size *)&local_320);
                          }
                          if (local_3c0[0] + -0x18 != PTR_DAT_017191c0) {
                            FUN_006c3514(local_3c0[0] + -0x18,(Size *)&local_320);
                          }
                          FUN_011ef314(local_178);
                        }
                        FUN_01211570((string *)&local_458,"polylinePoints",local_390);
                        pVVar12 = (Value *)std::__detail::
                                           _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                           ::operator[](p_Var18,(string *)&local_458);
                    /* try { // try from 00f46348 to 0104634b has its CatchHandler @ 00f4641c */
                    /* try { // try from 00f46354 to 01046357 has its CatchHandler @ 00f4642c */
                        cocos2d::Value::Value((Value *)&local_380,(vector *)&local_370);
                        cocos2d::Value::operator=(pVVar12,(Value *)&local_380);
                        cocos2d::Value::~Value((Value *)&local_380);
                        if ((undefined *)(local_458 + -0x18) != PTR_DAT_017191c0) {
                          FUN_006c3514((undefined *)(local_458 + -0x18),(Size *)&local_320);
                        }
                        if (local_3d0[0] + -0x18 != PTR_DAT_017191c0) {
                          FUN_006c3514(local_3d0[0] + -0x18,(Size *)&local_320);
                        }
                        FUN_011ef314(auStack_2e8);
                        pVVar4 = local_368;
                        pVVar21 = local_368;
                        local_3b0[0] = local_3e0[0];
                        for (pVVar12 = local_370; local_3e0[0] = local_3b0[0], pVVar12 != pVVar4;
                            pVVar12 = pVVar12 + 0x10) {
                          cocos2d::Value::~Value(pVVar12);
                          pVVar21 = local_370;
                          local_3b0[0] = local_3e0[0];
                        }
                        if (pVVar21 != (Value *)0x0) {
                          operator_delete(pVVar21);
                          local_3b0[0] = local_3e0[0];
                        }
                      }
                    }
                    pVVar12 = (Value *)(local_3b0[0] + -0x18);
                    if (pVVar12 != (Value *)PTR_DAT_017191c0) goto LAB_00f44440;
                  }
                }
              }
            }
          }
        }
      }
      goto LAB_00f42f2c;
    }
                    /* try { // try from 00f432b8 to 010432bb has its CatchHandler @ 00f44414 */
    if (*(int *)(this + 0x98) == 2) {
      lVar24 = *(long *)(*(long *)(this + 0x58) + -8);
                    /* try { // try from 00f43948 to 0104394b has its CatchHandler @ 00f44464 */
      Size::Size((Size *)&local_320,(Size *)(lVar24 + 0x68));
                    /* try { // try from 00f43958 to 0104395b has its CatchHandler @ 00f44474 */
      FUN_01211570((string *)&local_5e0,&DAT_013635d0,&local_380);
                    /* try { // try from 00f43968 to 0104396b has its CatchHandler @ 00f44488 */
      pVVar12 = (Value *)std::__detail::
                         _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                         ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                       *)&local_358,(string *)&local_5e0);
      uVar37 = cocos2d::Value::asUnsignedInt(pVVar12);
      if ((undefined *)(local_5e0 + -0x18) != PTR_DAT_017191c0) {
        piVar31 = (int *)(local_5e0 + -8);
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* catch() { ... } // from try @ 00f445f8 with catch @ 00f4524c */
          iVar6 = *(int *)(local_5e0 + -8);
          *(int *)(local_5e0 + -8) = iVar6 + -1;
        }
        else {
          do {
            iVar6 = *piVar31;
            cVar2 = '\x01';
            bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
            if (bVar3) {
              *piVar31 = iVar6 + -1;
              cVar2 = ExclusiveMonitorsStatus();
            }
          } while (cVar2 != '\0');
        }
        if (iVar6 < 1) {
          operator_delete((undefined *)(local_5e0 + -0x18));
        }
      }
      iVar6 = *(int *)(this + 0xe0);
      if (iVar6 < (int)((float)local_320 * local_320._4_4_)) {
        lVar24 = *(long *)(lVar24 + 0x70);
        *(int *)(this + 0xe0) = iVar6 + 1;
        *(undefined4 *)(lVar24 + (long)iVar6 * 4) = uVar37;
      }
      goto LAB_00f42f2c;
    }
    iVar6 = *(int *)(*(long *)(*(long *)(this + 0x70) + -8) + 0x30);
    FUN_01211570((string *)&local_5d8,"id",&local_370);
                    /* try { // try from 00f432ec to 010432ef has its CatchHandler @ 00f44398 */
    pVVar12 = (Value *)std::__detail::
                       _Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                       ::operator[]((_Map_base<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>,true>
                                     *)&local_358,(string *)&local_5d8);
    iVar7 = cocos2d::Value::asInt(pVVar12);
    iVar6 = iVar6 + iVar7;
    *(int *)(this + 0x9c) = iVar6;
    if ((undefined *)(local_5d8 + -0x18) != PTR_DAT_017191c0) {
                    /* catch() { ... } // from try @ 00f433c4 with catch @ 00f4428c */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_5d8 + -8);
        *(int *)(local_5d8 + -8) = iVar6 + -1;
      }
      else {
        piVar31 = (int *)(local_5d8 + -8);
        do {
          iVar6 = *piVar31;
                    /* catch() { ... } // from try @ 00f43460 with catch @ 00f442a0 */
          cVar2 = '\x01';
          bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
          if (bVar3) {
            *piVar31 = iVar6 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar6 < 1) {
                    /* catch() { ... } // from try @ 00f434a0 with catch @ 00f442b0 */
        operator_delete((undefined *)(local_5d8 + -0x18));
      }
      iVar6 = *(int *)(this + 0x9c);
    }
    uVar25 = (ulong)iVar6;
    local_370 = (Value *)CONCAT44(local_370._4_4_,iVar6);
                    /* try { // try from 00f4332c to 0104332f has its CatchHandler @ 00f443a0 */
    uVar10 = *(ulong *)(this + 0x108);
    uVar30 = 0;
    if (uVar10 != 0) {
      uVar30 = uVar25 / uVar10;
    }
    uVar30 = uVar25 - uVar30 * uVar10;
    plVar11 = (long *)FUN_00f40254((_Hashtable<int,std::pair<int_const,cocos2d::Value>,std::allocator<std::pair<int_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<int>,std::hash<int>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                                    *)(this + 0x100),uVar30,&local_370);
    if ((plVar11 == (long *)0x0) || (lVar24 = *plVar11, lVar24 == 0)) {
                    /* try { // try from 00f44b98 to 01044b9b has its CatchHandler @ 00f452c8 */
      p_Var9 = operator_new(0x20);
      *(undefined8 *)p_Var9 = 0;
      *(int *)(p_Var9 + 8) = iVar6;
      cocos2d::Value::Value((Value *)(p_Var9 + 0x10));
      lVar24 = std::
               _Hashtable<int,std::pair<int_const,cocos2d::Value>,std::allocator<std::pair<int_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<int>,std::hash<int>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
               ::_M_insert_unique_node
                         ((_Hashtable<int,std::pair<int_const,cocos2d::Value>,std::allocator<std::pair<int_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<int>,std::hash<int>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<false,false,true>>
                           *)(this + 0x100),uVar30,uVar25,p_Var9);
    }
    local_310 = 0;
    local_308 = 0;
    local_300[0] = 0x3f800000;
                    /* try { // try from 00f4336c to 0104336f has its CatchHandler @ 00f4426c */
    local_2f8 = 0;
    local_318 = FUN_0120ff88(local_300,10);
    if (local_318 == 1) {
      local_320 = &local_2f0;
                    /* catch() { ... } // from try @ 00f434f8 with catch @ 00f442c4 */
      local_2f0 = 0;
    }
    else {
      local_320 = (undefined8 *)FUN_00f402b4();
    }
    cocos2d::Value::Value(aVStack_440,(Size *)&local_320);
    cocos2d::Value::operator=((Value *)(lVar24 + 0x10),aVStack_440);
    cocos2d::Value::~Value(aVStack_440);
    std::
    _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
    ::~_Hashtable((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                   *)&local_320);
    *(undefined4 *)(this + 0x98) = 5;
                    /* try { // try from 00f433c4 to 010433c7 has its CatchHandler @ 00f4428c */
    std::
    _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
    ::~_Hashtable((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                   *)&local_358);
    puVar34 = (undefined *)(local_690 + -0x18);
    if (puVar34 == PTR_DAT_017191c0) goto LAB_00f42f4c;
  }
  if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
    iVar6 = *(int *)(local_690 + -8);
    *(int *)(local_690 + -8) = iVar6 + -1;
  }
  else {
    piVar31 = (int *)(local_690 + -8);
    do {
      iVar6 = *piVar31;
      cVar2 = '\x01';
      bVar3 = (bool)ExclusiveMonitorPass(piVar31,0x10);
      if (bVar3) {
        *piVar31 = iVar6 + -1;
        cVar2 = ExclusiveMonitorsStatus();
      }
    } while (cVar2 != '\0');
  }
  if (iVar6 < 1) {
    operator_delete(puVar34);
  }
LAB_00f42f4c:
                    /* try { // try from 00f42f58 to 01042f5b has its CatchHandler @ 00f44430 */
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === parseIntrusive @ 00f70d38 === */

/* cocos2d::SAXParser::parseIntrusive(char*, unsigned long) */

void __thiscall cocos2d::SAXParser::parseIntrusive(SAXParser *this,char *param_1,ulong param_2)

{
  byte *pbVar1;
  undefined *puVar2;
  undefined *puVar3;
  undefined *puVar4;
  int iVar5;
  void *pvVar6;
  long *plVar7;
  byte bVar8;
  byte *pbVar9;
  byte *local_58;
  undefined **local_50;
  byte *local_48;
  undefined *local_40;
  undefined8 local_38;
  undefined8 local_30;
  void *local_28;
  void *local_20;
  long local_18;
  SAXParser *local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  local_40 = PTR_vtable_0171a4a0 + 0x10;
  local_38 = 0;
  local_30 = 0;
  local_28 = (void *)0x0;
  local_20 = (void *)0x0;
  local_18 = 0;
  pvVar6 = operator_new(0x200);
  if (local_28 != (void *)0x0) {
    operator_delete(local_28);
  }
  local_18 = (long)pvVar6 + 0x200;
  local_40 = PTR_vtable_0171acf8 + 0x10;
  local_50 = &local_40;
  local_48 = (byte *)0x0;
  if (0 < (int)param_2) {
    local_48 = (byte *)(param_1 + (int)param_2);
  }
  local_58 = (byte *)param_1;
  if (((*param_1 == -0x11) && (param_1[1] == -0x45)) && (param_1[2] == -0x41)) {
    local_58 = (byte *)(param_1 + 3);
  }
  pbVar9 = local_48;
  local_28 = pvVar6;
  local_20 = pvVar6;
  local_10 = this;
LAB_00f70e08:
  do {
    while( true ) {
      while( true ) {
        while (((local_58 < pbVar9 || (pbVar9 == (byte *)0x0)) &&
               (PTR_lookup_whitespace_0171b438[*local_58] != '\0'))) {
          local_58 = local_58 + 1;
        }
        if ((*local_58 == 0) || (pbVar9 <= local_58)) {
          local_40 = PTR_vtable_0171a4a0 + 0x10;
          if (local_28 != (void *)0x0) {
            operator_delete(local_28);
          }
          if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
            __stack_chk_fail(1);
          }
          return;
        }
        if (*local_58 != 0x3c) {
          plVar7 = (long *)__cxa_allocate_exception(0x18);
          plVar7[2] = (long)local_58;
          puVar4 = PTR_typeinfo_01720ff0;
          puVar3 = PTR__parse_error_01718788;
          puVar2 = PTR_vtable_01723628 + 0x10;
          plVar7[1] = (long)"expected <";
          *plVar7 = (long)puVar2;
                    /* WARNING: Subroutine does not return */
          __cxa_throw(plVar7,puVar4,puVar3);
        }
        if (local_58[1] == 0x21) break;
        if (local_58[1] == 0x3f) {
          pbVar1 = local_58 + 2;
          bVar8 = local_58[2];
          if ((((bVar8 & 0xdf) == 0x58) && ((local_58[3] & 0xdf) == 0x4d)) &&
             (((local_58[4] & 0xdf) == 0x4c && (PTR_lookup_whitespace_0171b438[local_58[5]] != '\0')
              ))) {
            local_58 = local_58 + 6;
            do {
              if (*local_58 == 0x3f) {
                if (local_58[1] == 0x3e) goto code_r0x00f70f0c;
              }
              else if (*local_58 == 0) {
                plVar7 = (long *)__cxa_allocate_exception(0x18);
                plVar7[2] = (long)local_58;
                puVar4 = PTR_typeinfo_01720ff0;
                puVar3 = PTR__parse_error_01718788;
                puVar2 = PTR_vtable_01723628 + 0x10;
                plVar7[1] = (long)"unexpected end of data";
                *plVar7 = (long)puVar2;
                    /* WARNING: Subroutine does not return */
                __cxa_throw(plVar7,puVar4,puVar3);
              }
              local_58 = local_58 + 1;
            } while( true );
          }
          do {
            local_58 = pbVar1;
            if (bVar8 == 0x3f) {
              if (local_58[1] == 0x3e) goto code_r0x00f70f40;
            }
            else if (bVar8 == 0) {
              plVar7 = (long *)__cxa_allocate_exception(0x18);
              plVar7[2] = (long)local_58;
              puVar4 = PTR_typeinfo_01720ff0;
              puVar3 = PTR__parse_error_01718788;
              puVar2 = PTR_vtable_01723628 + 0x10;
              plVar7[1] = (long)"unexpected end of data";
              *plVar7 = (long)puVar2;
                    /* WARNING: Subroutine does not return */
              __cxa_throw(plVar7,puVar4,puVar3);
            }
            bVar8 = local_58[1];
            pbVar1 = local_58 + 1;
          } while( true );
        }
        local_58 = local_58 + 1;
        rapidxml::xml_sax3_parser<char>::parse_element<1>
                  ((xml_sax3_parser<char> *)&local_50,(char **)&local_58);
        pbVar9 = local_48;
      }
      bVar8 = local_58[2];
      if (bVar8 != 0x44) break;
      if ((((local_58[3] == 0x4f) && (local_58[4] == 0x43)) && (local_58[5] == 0x54)) &&
         (((local_58[6] == 0x59 && (local_58[7] == 0x50)) &&
          ((local_58[8] == 0x45 && (PTR_lookup_whitespace_0171b438[local_58[9]] != '\0')))))) {
        local_58 = local_58 + 10;
        while (bVar8 = *local_58, bVar8 != 0x3e) {
          if (bVar8 == 0) {
            plVar7 = (long *)__cxa_allocate_exception(0x18);
            plVar7[2] = (long)local_58;
            puVar4 = PTR_typeinfo_01720ff0;
            puVar3 = PTR__parse_error_01718788;
            puVar2 = PTR_vtable_01723628 + 0x10;
            plVar7[1] = (long)"unexpected end of data";
            *plVar7 = (long)puVar2;
                    /* WARNING: Subroutine does not return */
            __cxa_throw(plVar7,puVar4,puVar3);
          }
          local_58 = local_58 + 1;
          if (bVar8 == 0x5b) {
            iVar5 = 1;
            do {
              bVar8 = *local_58;
              if (bVar8 == 0x5b) goto LAB_00f71158;
              while (bVar8 != 0x5d) {
                if (bVar8 == 0) {
                  plVar7 = (long *)__cxa_allocate_exception(0x18);
                  plVar7[2] = (long)local_58;
                  puVar4 = PTR_typeinfo_01720ff0;
                  puVar3 = PTR__parse_error_01718788;
                  puVar2 = PTR_vtable_01723628 + 0x10;
                  plVar7[1] = (long)"unexpected end of data";
                  *plVar7 = (long)puVar2;
                    /* WARNING: Subroutine does not return */
                  __cxa_throw(plVar7,puVar4,puVar3);
                }
                while( true ) {
                  local_58 = local_58 + 1;
                  bVar8 = *local_58;
                  if (bVar8 != 0x5b) break;
LAB_00f71158:
                  iVar5 = iVar5 + 1;
                }
              }
              local_58 = local_58 + 1;
              iVar5 = iVar5 + -1;
            } while (iVar5 != 0);
          }
        }
        local_58 = local_58 + 1;
      }
      else {
LAB_00f70f6c:
        bVar8 = local_58[2];
        local_58 = local_58 + 2;
        while (bVar8 != 0x3e) {
          if (bVar8 == 0) {
            plVar7 = (long *)__cxa_allocate_exception(0x18);
            plVar7[2] = (long)local_58;
            puVar4 = PTR_typeinfo_01720ff0;
            puVar3 = PTR__parse_error_01718788;
            puVar2 = PTR_vtable_01723628 + 0x10;
            plVar7[1] = (long)"unexpected end of data";
            *plVar7 = (long)puVar2;
                    /* WARNING: Subroutine does not return */
            __cxa_throw(plVar7,puVar4,puVar3);
          }
          local_58 = local_58 + 1;
          bVar8 = *local_58;
        }
        local_58 = local_58 + 1;
      }
    }
    if (bVar8 != 0x5b) {
      if ((bVar8 == 0x2d) && (local_58[3] == 0x2d)) {
        local_58 = local_58 + 4;
        do {
          if (*local_58 == 0x2d) {
            if ((local_58[1] == 0x2d) && (local_58[2] == 0x3e)) goto code_r0x00f71038;
          }
          else if (*local_58 == 0) {
                    /* WARNING: Subroutine does not return */
            FUN_006c445c(&local_58);
          }
          local_58 = local_58 + 1;
        } while( true );
      }
      goto LAB_00f70f6c;
    }
    if (((((local_58[3] != 0x43) || (local_58[4] != 0x44)) || (local_58[5] != 0x41)) ||
        ((local_58[6] != 0x54 || (local_58[7] != 0x41)))) || (local_58[8] != 0x5b))
    goto LAB_00f70f6c;
    local_58 = local_58 + 9;
    rapidxml::xml_sax3_parser<char>::parse_cdata<1>
              ((xml_sax3_parser<char> *)&local_50,(char **)&local_58);
    pbVar9 = local_48;
  } while( true );
code_r0x00f71038:
  local_58 = local_58 + 3;
  goto LAB_00f70e08;
code_r0x00f70f0c:
  local_58 = local_58 + 2;
  goto LAB_00f70e08;
code_r0x00f70f40:
  local_58 = local_58 + 2;
  goto LAB_00f70e08;
}


/* === parse_element<1> @ 00f6fe88 === */

/* void rapidxml::xml_sax3_parser<char>::parse_element<1>(char*&) */

void __thiscall
rapidxml::xml_sax3_parser<char>::parse_element<1>(xml_sax3_parser<char> *this,char **param_1)

{
  undefined *puVar1;
  char cVar2;
  byte bVar3;
  undefined *puVar4;
  undefined *puVar5;
  bool bVar6;
  long *plVar7;
  byte *pbVar8;
  char *pcVar9;
  byte *pbVar10;
  byte *pbVar11;
  long lVar12;
  byte *pbVar13;
  ulong uVar14;
  byte bVar15;
  byte *local_20;
  byte *local_18;
  long local_10;
  long local_8;
  
  local_18 = (byte *)*param_1;
  pbVar11 = *(byte **)(this + 8);
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (((pbVar11 <= local_18) && (pbVar11 != (byte *)0x0)) ||
     (pbVar10 = local_18, PTR_lookup_node_name_0171cc58[*local_18] == '\0')) {
    *param_1 = (char *)local_18;
    local_10 = 0;
  }
  else {
    do {
      pbVar10 = pbVar10 + 1;
      if ((pbVar11 <= pbVar10) && (pbVar11 != (byte *)0x0)) break;
    } while (PTR_lookup_node_name_0171cc58[*pbVar10] != '\0');
    local_10 = (long)pbVar10 - (long)local_18;
    *param_1 = (char *)pbVar10;
    if (local_10 != 0) {
      (**(code **)(**(long **)this + 0x10))(*(long **)this);
      pbVar10 = *(byte **)(this + 8);
      pbVar11 = (byte *)*param_1;
      if ((pbVar11 < pbVar10) || (pbVar10 == (byte *)0x0)) {
        cVar2 = PTR_lookup_whitespace_0171b438[*pbVar11];
        while ((cVar2 != '\0' &&
               ((pbVar11 = pbVar11 + 1, pbVar11 < pbVar10 || (pbVar10 == (byte *)0x0))))) {
          cVar2 = PTR_lookup_whitespace_0171b438[*pbVar11];
        }
      }
      *param_1 = (char *)pbVar11;
      cVar2 = PTR_lookup_attribute_name_0171b2e0[*pbVar11];
      do {
        if (cVar2 == '\0') {
          (**(code **)(**(long **)this + 0x20))(*(long **)this);
          pcVar9 = *param_1;
          if (*pcVar9 == '>') {
            *param_1 = pcVar9 + 1;
            parse_node_contents<1>((char **)this,(pair_conflict *)param_1);
          }
          else {
            if ((*pcVar9 != '/') || (*param_1 = pcVar9 + 1, pcVar9[1] != '>')) {
              plVar7 = (long *)__cxa_allocate_exception(0x18);
              plVar7[2] = (long)*param_1;
              puVar5 = PTR_typeinfo_01720ff0;
              puVar4 = PTR__parse_error_01718788;
              puVar1 = PTR_vtable_01723628 + 0x10;
              plVar7[1] = (long)"expected >";
              *plVar7 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
              __cxa_throw(plVar7,puVar5,puVar4);
            }
            *param_1 = pcVar9 + 2;
          }
          local_18[local_10] = 0;
          (**(code **)(**(long **)this + 0x28))(*(long **)this,local_18,local_10);
          if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
            return;
          }
LAB_00f70d34:
                    /* WARNING: Subroutine does not return */
          __stack_chk_fail();
        }
        pbVar10 = pbVar11 + 1;
        *param_1 = (char *)pbVar10;
        pbVar8 = *(byte **)(this + 8);
        bVar6 = pbVar8 == (byte *)0x0;
        uVar14 = (ulong)bVar6;
        if (((pbVar10 < pbVar8) || (bVar6)) &&
           (PTR_lookup_attribute_name_0171b2e0[pbVar11[1]] != '\0')) {
          do {
            pbVar10 = pbVar10 + 1;
            if ((pbVar8 <= pbVar10) && (!bVar6)) goto LAB_00f6ffe4;
          } while (PTR_lookup_attribute_name_0171b2e0[*pbVar10] != '\0');
          *param_1 = (char *)pbVar10;
        }
        else {
LAB_00f6ffe4:
          *param_1 = (char *)pbVar10;
        }
        if (pbVar10 == pbVar11) {
          plVar7 = (long *)__cxa_allocate_exception(0x18);
          plVar7[2] = (long)pbVar10;
          puVar5 = PTR_typeinfo_01720ff0;
          puVar4 = PTR__parse_error_01718788;
          puVar1 = PTR_vtable_01723628 + 0x10;
          plVar7[1] = (long)"expected attribute name";
          *plVar7 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
          __cxa_throw(plVar7,puVar5,puVar4);
        }
        pbVar13 = *(byte **)(this + 8);
        lVar12 = (long)pbVar10 - (long)pbVar11;
        pbVar8 = pbVar10;
        if (((pbVar13 <= pbVar10) && (pbVar13 != (byte *)0x0)) ||
           (uVar14 = (ulong)(byte)PTR_lookup_whitespace_0171b438[*pbVar10],
           PTR_lookup_whitespace_0171b438[*pbVar10] == 0)) {
LAB_00f70010:
          *param_1 = (char *)pbVar8;
          bVar3 = *pbVar8;
        }
        else {
          do {
            pbVar8 = pbVar8 + 1;
            if ((pbVar13 <= pbVar8) && (pbVar13 != (byte *)0x0)) goto LAB_00f70010;
            uVar14 = (ulong)(byte)PTR_lookup_whitespace_0171b438[*pbVar8];
          } while (PTR_lookup_whitespace_0171b438[*pbVar8] != 0);
          *param_1 = (char *)pbVar8;
          bVar3 = *pbVar8;
        }
        if (bVar3 != 0x3d) {
          plVar7 = (long *)__cxa_allocate_exception(0x18,pbVar11,lVar12);
          plVar7[2] = (long)*param_1;
          puVar5 = PTR_typeinfo_01720ff0;
          puVar4 = PTR__parse_error_01718788;
          puVar1 = PTR_vtable_01723628 + 0x10;
          plVar7[1] = (long)"expected =";
          *plVar7 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
          __cxa_throw(plVar7,puVar5,puVar4);
        }
        *param_1 = (char *)(pbVar8 + 1);
        *pbVar10 = 0;
        pbVar10 = *(byte **)(this + 8);
        pbVar8 = (byte *)*param_1;
        while (((pbVar8 < pbVar10 || (pbVar10 == (byte *)0x0)) &&
               (uVar14 = (ulong)(byte)PTR_lookup_whitespace_0171b438[*pbVar8],
               PTR_lookup_whitespace_0171b438[*pbVar8] != 0))) {
          pbVar8 = pbVar8 + 1;
        }
        *param_1 = (char *)pbVar8;
        bVar3 = *pbVar8;
        if ((bVar3 != 0x22) && (bVar3 != 0x27)) {
LAB_00f702a0:
          plVar7 = (long *)__cxa_allocate_exception(0x18,pbVar11,lVar12,pbVar10,uVar14);
          plVar7[2] = (long)*param_1;
          puVar5 = PTR_typeinfo_01720ff0;
          puVar4 = PTR__parse_error_01718788;
          puVar1 = PTR_vtable_01723628 + 0x10;
          plVar7[1] = (long)"expected \' or \"";
          *plVar7 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
          __cxa_throw(plVar7,puVar5,puVar4);
        }
        pbVar10 = pbVar8 + 1;
        *param_1 = (char *)pbVar10;
        pbVar13 = pbVar10;
        if (bVar3 == 0x27) {
          cVar2 = PTR_lookup_attribute_data_1_pure_0171f8c8[pbVar8[1]];
          while (cVar2 != '\0') {
            pbVar13 = pbVar13 + 1;
            cVar2 = PTR_lookup_attribute_data_1_pure_0171f8c8[*pbVar13];
          }
          *param_1 = (char *)pbVar13;
          local_20 = pbVar13;
LAB_00f705f0:
          bVar15 = *pbVar13;
          if (PTR_lookup_attribute_data_1_01714f18[bVar15] != '\0') {
LAB_00f70604:
            if (bVar15 == 0x26) {
              bVar15 = pbVar13[1];
              if (bVar15 == 0x67) {
                if ((pbVar13[2] == 0x74) && (pbVar13[3] == 0x3b)) {
                  pbVar13 = pbVar13 + 4;
                  *local_20 = 0x3e;
                  local_20 = local_20 + 1;
                  goto LAB_00f705f0;
                }
                goto LAB_00f705d8;
              }
              if ('g' < (char)bVar15) {
                if (bVar15 == 0x6c) {
                  if ((pbVar13[2] == 0x74) && (pbVar13[3] == 0x3b)) {
                    pbVar13 = pbVar13 + 4;
                    *local_20 = 0x3c;
                    local_20 = local_20 + 1;
                    goto LAB_00f705f0;
                  }
                }
                else if ((((bVar15 == 0x71) && (pbVar13[2] == 0x75)) && (pbVar13[3] == 0x6f)) &&
                        ((pbVar13[4] == 0x74 && (pbVar13[5] == 0x3b)))) {
                  pbVar13 = pbVar13 + 6;
                  *local_20 = 0x22;
                  local_20 = local_20 + 1;
                  goto LAB_00f705f0;
                }
                goto LAB_00f705d8;
              }
              if (bVar15 != 0x23) {
                if (bVar15 == 0x61) {
                  if (pbVar13[2] == 0x6d) {
                    if ((pbVar13[3] == 0x70) && (pbVar13[4] == 0x3b)) {
                      pbVar13 = pbVar13 + 5;
                      *local_20 = 0x26;
                      local_20 = local_20 + 1;
                      goto LAB_00f705f0;
                    }
                  }
                  else if ((((pbVar13[2] == 0x70) && (pbVar13[3] == 0x6f)) && (pbVar13[4] == 0x73))
                          && (pbVar13[5] == 0x3b)) goto code_r0x00f70664;
                }
                goto LAB_00f705d8;
              }
              if (pbVar13[2] == 0x78) {
                pbVar8 = pbVar13 + 3;
                bVar15 = PTR_lookup_digits_01720bf8[pbVar13[3]];
                if (bVar15 == 0xff) {
                  bVar15 = 0;
                }
                else {
                  uVar14 = 0;
                  do {
                    pbVar8 = pbVar8 + 1;
                    uVar14 = (ulong)bVar15 + uVar14 * 0x10;
                    bVar15 = PTR_lookup_digits_01720bf8[*pbVar8];
                  } while (bVar15 != 0xff);
                  bVar15 = (byte)uVar14;
                  if (0x7f < uVar14) {
                    if (uVar14 < 0x800) {
                      local_20[1] = bVar15 & 0x3f | 0x80;
                      *local_20 = (byte)(uVar14 >> 6) | 0xc0;
                      local_20 = local_20 + 2;
                    }
                    else if (uVar14 < 0x10000) {
                      local_20[2] = bVar15 & 0x3f | 0x80;
                      local_20[1] = (byte)(uVar14 >> 6) & 0x3f | 0x80;
                      *local_20 = (byte)(uVar14 >> 0xc) | 0xe0;
                      local_20 = local_20 + 3;
                    }
                    else {
                      if (0x10ffff < uVar14) goto LAB_00f70d2c;
                      local_20[3] = bVar15 & 0x3f | 0x80;
                      local_20[2] = (byte)(uVar14 >> 6) & 0x3f | 0x80;
                      local_20[1] = (byte)(uVar14 >> 0xc) & 0x3f | 0x80;
                      *local_20 = (byte)(uVar14 >> 0x12) | 0xf0;
                      local_20 = local_20 + 4;
                    }
                    goto LAB_00f707ec;
                  }
                }
                *local_20 = bVar15;
                local_20 = local_20 + 1;
              }
              else {
                pbVar8 = pbVar13 + 2;
                bVar15 = PTR_lookup_digits_01720bf8[pbVar13[2]];
                if (bVar15 == 0xff) {
                  bVar15 = 0;
                }
                else {
                  uVar14 = 0;
                  do {
                    pbVar8 = pbVar8 + 1;
                    uVar14 = uVar14 * 10 + (ulong)bVar15;
                    bVar15 = PTR_lookup_digits_01720bf8[*pbVar8];
                  } while (bVar15 != 0xff);
                  bVar15 = (byte)uVar14;
                  if (0x7f < uVar14) {
                    if (uVar14 < 0x800) {
                      local_20[1] = bVar15 & 0x3f | 0x80;
                      *local_20 = (byte)(uVar14 >> 6) | 0xc0;
                      local_20 = local_20 + 2;
                      goto LAB_00f707ec;
                    }
                    if (uVar14 < 0x10000) {
                      local_20[2] = bVar15 & 0x3f | 0x80;
                      local_20[1] = (byte)(uVar14 >> 6) & 0x3f | 0x80;
                      *local_20 = (byte)(uVar14 >> 0xc) | 0xe0;
                      local_20 = local_20 + 3;
                      goto LAB_00f707ec;
                    }
                    if (uVar14 < 0x110000) {
                      local_20[3] = bVar15 & 0x3f | 0x80;
                      local_20[2] = (byte)(uVar14 >> 6) & 0x3f | 0x80;
                      local_20[1] = (byte)(uVar14 >> 0xc) & 0x3f | 0x80;
                      *local_20 = (byte)(uVar14 >> 0x12) | 0xf0;
                      local_20 = local_20 + 4;
                      goto LAB_00f707ec;
                    }
                    goto LAB_00f70d2c;
                  }
                }
                *local_20 = bVar15;
                local_20 = local_20 + 1;
              }
LAB_00f707ec:
              if (*pbVar8 != 0x3b) goto LAB_00f70cf0;
              pbVar13 = pbVar8 + 1;
            }
            else {
LAB_00f705d8:
              *local_20 = *pbVar13;
              pbVar13 = pbVar13 + 1;
              local_20 = local_20 + 1;
            }
            goto LAB_00f705f0;
          }
LAB_00f70690:
          *param_1 = (char *)pbVar13;
        }
        else {
          cVar2 = PTR_lookup_attribute_data_2_pure_0171e298[pbVar8[1]];
          while (cVar2 != '\0') {
            pbVar13 = pbVar13 + 1;
            cVar2 = PTR_lookup_attribute_data_2_pure_0171e298[*pbVar13];
          }
          *param_1 = (char *)pbVar13;
          local_20 = pbVar13;
LAB_00f700c4:
          bVar15 = *pbVar13;
          if (PTR_lookup_attribute_data_2_01716ee8[bVar15] != '\0') {
            while( true ) {
              if (bVar15 != 0x26) goto LAB_00f700ac;
              bVar15 = pbVar13[1];
              if (bVar15 == 0x67) {
                if ((pbVar13[2] == 0x74) && (pbVar13[3] == 0x3b)) {
                  pbVar13 = pbVar13 + 4;
                  *local_20 = 0x3e;
                  local_20 = local_20 + 1;
                  goto LAB_00f700c4;
                }
                goto LAB_00f700ac;
              }
              if ('g' < (char)bVar15) {
                if (bVar15 == 0x6c) {
                  if ((pbVar13[2] == 0x74) && (pbVar13[3] == 0x3b)) {
                    pbVar13 = pbVar13 + 4;
                    *local_20 = 0x3c;
                    local_20 = local_20 + 1;
                    goto LAB_00f700c4;
                  }
                }
                else if ((((bVar15 == 0x71) && (pbVar13[2] == 0x75)) && (pbVar13[3] == 0x6f)) &&
                        ((pbVar13[4] == 0x74 && (pbVar13[5] == 0x3b)))) {
                  pbVar13 = pbVar13 + 6;
                  *local_20 = 0x22;
                  local_20 = local_20 + 1;
                  goto LAB_00f700c4;
                }
                goto LAB_00f700ac;
              }
              if (bVar15 == 0x23) break;
              if (bVar15 != 0x61) goto LAB_00f700ac;
              if (pbVar13[2] == 0x6d) {
                if ((pbVar13[3] == 0x70) && (pbVar13[4] == 0x3b)) {
                  pbVar13 = pbVar13 + 5;
                  *local_20 = 0x26;
                  local_20 = local_20 + 1;
                  goto LAB_00f700c4;
                }
                goto LAB_00f700ac;
              }
              if ((((pbVar13[2] != 0x70) || (pbVar13[3] != 0x6f)) || (pbVar13[4] != 0x73)) ||
                 (pbVar13[5] != 0x3b)) goto LAB_00f700ac;
              pbVar13 = pbVar13 + 6;
              *local_20 = 0x27;
              local_20 = local_20 + 1;
              bVar15 = *pbVar13;
              if (PTR_lookup_attribute_data_2_01716ee8[bVar15] == '\0') goto LAB_00f70164;
            }
            if (pbVar13[2] == 0x78) {
              pbVar8 = pbVar13 + 3;
              bVar15 = PTR_lookup_digits_01720bf8[pbVar13[3]];
              if (bVar15 == 0xff) {
                bVar15 = 0;
                goto LAB_00f70ab8;
              }
              uVar14 = 0;
              do {
                pbVar8 = pbVar8 + 1;
                uVar14 = (ulong)bVar15 + uVar14 * 0x10;
                bVar15 = PTR_lookup_digits_01720bf8[*pbVar8];
              } while (bVar15 != 0xff);
              bVar15 = (byte)uVar14;
              if (uVar14 < 0x80) {
LAB_00f70ab8:
                *local_20 = bVar15;
                local_20 = local_20 + 1;
              }
              else if (uVar14 < 0x800) {
                local_20[1] = bVar15 & 0x3f | 0x80;
                *local_20 = (byte)(uVar14 >> 6) | 0xc0;
                local_20 = local_20 + 2;
              }
              else if (uVar14 < 0x10000) {
                local_20[2] = bVar15 & 0x3f | 0x80;
                local_20[1] = (byte)(uVar14 >> 6) & 0x3f | 0x80;
                *local_20 = (byte)(uVar14 >> 0xc) | 0xe0;
                local_20 = local_20 + 3;
              }
              else {
                if (0x10ffff < uVar14) goto LAB_00f70d2c;
                local_20[3] = bVar15 & 0x3f | 0x80;
                local_20[2] = (byte)(uVar14 >> 6) & 0x3f | 0x80;
                local_20[1] = (byte)(uVar14 >> 0xc) & 0x3f | 0x80;
                *local_20 = (byte)(uVar14 >> 0x12) | 0xf0;
                local_20 = local_20 + 4;
              }
            }
            else {
              pbVar8 = pbVar13 + 2;
              bVar15 = PTR_lookup_digits_01720bf8[pbVar13[2]];
              if (bVar15 == 0xff) {
                bVar15 = 0;
                goto LAB_00f7091c;
              }
              uVar14 = 0;
              do {
                pbVar8 = pbVar8 + 1;
                uVar14 = uVar14 * 10 + (ulong)bVar15;
                bVar15 = PTR_lookup_digits_01720bf8[*pbVar8];
              } while (bVar15 != 0xff);
              bVar15 = (byte)uVar14;
              if (uVar14 < 0x80) {
LAB_00f7091c:
                *local_20 = bVar15;
                local_20 = local_20 + 1;
              }
              else if (uVar14 < 0x800) {
                local_20[1] = bVar15 & 0x3f | 0x80;
                *local_20 = (byte)(uVar14 >> 6) | 0xc0;
                local_20 = local_20 + 2;
              }
              else if (uVar14 < 0x10000) {
                local_20[2] = bVar15 & 0x3f | 0x80;
                local_20[1] = (byte)(uVar14 >> 6) & 0x3f | 0x80;
                *local_20 = (byte)(uVar14 >> 0xc) | 0xe0;
                local_20 = local_20 + 3;
              }
              else {
                if (0x10ffff < uVar14) {
LAB_00f70d2c:
                  FUN_006c44ac(&local_20);
                  goto LAB_00f70d34;
                }
                local_20[3] = bVar15 & 0x3f | 0x80;
                local_20[2] = (byte)(uVar14 >> 6) & 0x3f | 0x80;
                local_20[1] = (byte)(uVar14 >> 0xc) & 0x3f | 0x80;
                *local_20 = (byte)(uVar14 >> 0x12) | 0xf0;
                local_20 = local_20 + 4;
              }
            }
            if (*pbVar8 != 0x3b) {
LAB_00f70cf0:
              plVar7 = (long *)__cxa_allocate_exception(0x18,pbVar11,lVar12);
              plVar7[2] = (long)pbVar8;
              puVar5 = PTR_typeinfo_01720ff0;
              puVar4 = PTR__parse_error_01718788;
              puVar1 = PTR_vtable_01723628 + 0x10;
              plVar7[1] = (long)"expected ;";
              *plVar7 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
              __cxa_throw(plVar7,puVar5,puVar4);
            }
            pbVar13 = pbVar8 + 1;
            goto LAB_00f700c4;
          }
LAB_00f70164:
          *param_1 = (char *)pbVar13;
        }
        uVar14 = (long)local_20 - (long)pbVar10;
        if (*pbVar13 != bVar3) goto LAB_00f702a0;
        *param_1 = (char *)(pbVar13 + 1);
        *local_20 = 0;
        (**(code **)(**(long **)this + 0x18))(*(long **)this);
        pbVar11 = (byte *)*param_1;
        while (((pbVar11 < *(byte **)(this + 8) || (*(byte **)(this + 8) == (byte *)0x0)) &&
               (PTR_lookup_whitespace_0171b438[*pbVar11] != '\0'))) {
          pbVar11 = pbVar11 + 1;
        }
        *param_1 = (char *)pbVar11;
        cVar2 = PTR_lookup_attribute_name_0171b2e0[*pbVar11];
      } while( true );
    }
  }
  plVar7 = (long *)__cxa_allocate_exception(0x18);
  plVar7[2] = (long)*param_1;
  puVar5 = PTR_typeinfo_01720ff0;
  puVar4 = PTR__parse_error_01718788;
  puVar1 = PTR_vtable_01723628 + 0x10;
  plVar7[1] = (long)"expected element name";
  *plVar7 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
  __cxa_throw(plVar7,puVar5,puVar4);
code_r0x00f70664:
  pbVar13 = pbVar13 + 6;
  *local_20 = 0x27;
  local_20 = local_20 + 1;
  bVar15 = *pbVar13;
  if (PTR_lookup_attribute_data_1_01714f18[bVar15] == '\0') goto LAB_00f70690;
  goto LAB_00f70604;
LAB_00f700ac:
  *local_20 = *pbVar13;
  pbVar13 = pbVar13 + 1;
  local_20 = local_20 + 1;
  goto LAB_00f700c4;
}


/* === parse_cdata<1> @ 00f6f39c === */

/* void rapidxml::xml_sax3_parser<char>::parse_cdata<1>(char*&) */

void __thiscall
rapidxml::xml_sax3_parser<char>::parse_cdata<1>(xml_sax3_parser<char> *this,char **param_1)

{
  undefined *puVar1;
  undefined *puVar2;
  undefined *puVar3;
  char *pcVar4;
  long *plVar5;
  
  pcVar4 = *param_1;
  do {
    if (*pcVar4 == ']') {
      if ((pcVar4[1] == ']') && (pcVar4[2] == '>')) {
        *param_1 = pcVar4 + 3;
        return;
      }
    }
    else if (*pcVar4 == '\0') {
      plVar5 = (long *)__cxa_allocate_exception(0x18);
      plVar5[2] = (long)*param_1;
      puVar3 = PTR_typeinfo_01720ff0;
      puVar2 = PTR__parse_error_01718788;
      puVar1 = PTR_vtable_01723628 + 0x10;
      plVar5[1] = (long)"unexpected end of data";
      *plVar5 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
      __cxa_throw(plVar5,puVar3,puVar2);
    }
    pcVar4 = pcVar4 + 1;
    *param_1 = pcVar4;
  } while( true );
}


/* === parse_node_contents<1> @ 00f6f438 === */

/* void rapidxml::xml_sax3_parser<char>::parse_node_contents<1>(char*&, std::pair<char*, unsigned
   long> const&) */

void rapidxml::xml_sax3_parser<char>::parse_node_contents<1>(char **param_1,pair_conflict *param_2)

{
  undefined *puVar1;
  char cVar2;
  bool bVar3;
  undefined *puVar4;
  undefined *puVar5;
  bool bVar6;
  int iVar7;
  long *plVar8;
  ulong uVar9;
  char *pcVar10;
  byte *pbVar11;
  long lVar12;
  byte bVar13;
  byte *pbVar14;
  byte *pbVar15;
  byte *local_10;
  long local_8;
  
  pbVar15 = *(byte **)param_2;
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
LAB_00f6f480:
  pbVar11 = (byte *)param_1[1];
  bVar6 = pbVar11 == (byte *)0x0;
  pbVar14 = pbVar15;
  bVar3 = bVar6;
  if (pbVar15 < pbVar11) goto LAB_00f6f574;
LAB_00f6f494:
  pbVar14 = pbVar15;
  bVar3 = true;
  if (bVar6) goto LAB_00f6f574;
LAB_00f6f49c:
  *(byte **)param_2 = pbVar15;
  bVar13 = *pbVar15;
LAB_00f6f4a8:
  if (bVar13 == 0) goto LAB_00f6f5ac;
  if (bVar13 != 0x3c) {
    *(byte **)param_2 = pbVar14;
    cVar2 = PTR_lookup_text_pure_no_ws_01720898[*pbVar14];
    pbVar15 = pbVar14;
    while ((pbVar11 = pbVar15, cVar2 != '\0' &&
           (pbVar11 = pbVar15 + 1, PTR_lookup_text_pure_no_ws_01720898[*pbVar11] != '\0'))) {
      pbVar15 = pbVar15 + 2;
      cVar2 = PTR_lookup_text_pure_no_ws_01720898[*pbVar15];
    }
    *(byte **)param_2 = pbVar11;
    local_10 = pbVar11;
LAB_00f6f630:
    if (PTR_lookup_text_0171c068[*pbVar11] == '\0') goto LAB_00f6f744;
    if (*pbVar11 == 0x26) {
      bVar13 = pbVar11[1];
      if (bVar13 == 0x67) {
        if ((pbVar11[2] != 0x74) || (pbVar11[3] != 0x3b)) goto LAB_00f6f618;
        pbVar11 = pbVar11 + 4;
        *local_10 = 0x3e;
        local_10 = local_10 + 1;
        goto LAB_00f6f630;
      }
      if ((char)bVar13 < 'h') {
        if (bVar13 == 0x23) {
          if (pbVar11[2] == 0x78) {
            pbVar15 = pbVar11 + 3;
            bVar13 = PTR_lookup_digits_01720bf8[pbVar11[3]];
            if (bVar13 == 0xff) {
              bVar13 = 0;
            }
            else {
              uVar9 = 0;
              do {
                pbVar15 = pbVar15 + 1;
                uVar9 = (ulong)bVar13 + uVar9 * 0x10;
                bVar13 = PTR_lookup_digits_01720bf8[*pbVar15];
              } while (bVar13 != 0xff);
              bVar13 = (byte)uVar9;
              if (0x7f < uVar9) {
                if (uVar9 < 0x800) {
                  local_10[1] = bVar13 & 0x3f | 0x80;
                  *local_10 = (byte)(uVar9 >> 6) | 0xc0;
                  local_10 = local_10 + 2;
                }
                else if (uVar9 < 0x10000) {
                  local_10[2] = bVar13 & 0x3f | 0x80;
                  local_10[1] = (byte)(uVar9 >> 6) & 0x3f | 0x80;
                  *local_10 = (byte)(uVar9 >> 0xc) | 0xe0;
                  local_10 = local_10 + 3;
                }
                else {
                  if (0x10ffff < uVar9) goto LAB_00f6fe78;
                  local_10[3] = bVar13 & 0x3f | 0x80;
                  local_10[2] = (byte)(uVar9 >> 6) & 0x3f | 0x80;
                  local_10[1] = (byte)(uVar9 >> 0xc) & 0x3f | 0x80;
                  *local_10 = (byte)(uVar9 >> 0x12) | 0xf0;
                  local_10 = local_10 + 4;
                }
                goto LAB_00f6f8fc;
              }
            }
            *local_10 = bVar13;
            local_10 = local_10 + 1;
          }
          else {
            pbVar15 = pbVar11 + 2;
            bVar13 = PTR_lookup_digits_01720bf8[pbVar11[2]];
            if (bVar13 == 0xff) {
              bVar13 = 0;
            }
            else {
              uVar9 = 0;
              do {
                pbVar15 = pbVar15 + 1;
                uVar9 = uVar9 * 10 + (ulong)bVar13;
                bVar13 = PTR_lookup_digits_01720bf8[*pbVar15];
              } while (bVar13 != 0xff);
              bVar13 = (byte)uVar9;
              if (0x7f < uVar9) {
                if (uVar9 < 0x800) {
                  local_10[1] = bVar13 & 0x3f | 0x80;
                  *local_10 = (byte)(uVar9 >> 6) | 0xc0;
                  local_10 = local_10 + 2;
                }
                else {
                  if (0xffff < uVar9) {
                    if (uVar9 < 0x110000) {
                      local_10[3] = bVar13 & 0x3f | 0x80;
                      local_10[2] = (byte)(uVar9 >> 6) & 0x3f | 0x80;
                      local_10[1] = (byte)(uVar9 >> 0xc) & 0x3f | 0x80;
                      *local_10 = (byte)(uVar9 >> 0x12) | 0xf0;
                      local_10 = local_10 + 4;
                      goto LAB_00f6f8fc;
                    }
LAB_00f6fe78:
                    FUN_006c44ac(&local_10);
                    goto LAB_00f6fe80;
                  }
                  local_10[2] = bVar13 & 0x3f | 0x80;
                  local_10[1] = (byte)(uVar9 >> 6) & 0x3f | 0x80;
                  *local_10 = (byte)(uVar9 >> 0xc) | 0xe0;
                  local_10 = local_10 + 3;
                }
                goto LAB_00f6f8fc;
              }
            }
            *local_10 = bVar13;
            local_10 = local_10 + 1;
          }
LAB_00f6f8fc:
          if (*pbVar15 != 0x3b) {
            plVar8 = (long *)__cxa_allocate_exception(0x18);
            plVar8[2] = (long)pbVar15;
            puVar5 = PTR_typeinfo_01720ff0;
            puVar4 = PTR__parse_error_01718788;
            puVar1 = PTR_vtable_01723628 + 0x10;
            plVar8[1] = (long)"expected ;";
            *plVar8 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
            __cxa_throw(plVar8,puVar5,puVar4);
          }
          pbVar11 = pbVar15 + 1;
          goto LAB_00f6f630;
        }
        if (bVar13 == 0x61) {
          if (pbVar11[2] == 0x6d) {
            if ((pbVar11[3] != 0x70) || (pbVar11[4] != 0x3b)) goto LAB_00f6f618;
            pbVar11 = pbVar11 + 5;
            *local_10 = 0x26;
            local_10 = local_10 + 1;
            goto LAB_00f6f630;
          }
          if (((pbVar11[2] == 0x70) && (pbVar11[3] == 0x6f)) &&
             ((pbVar11[4] == 0x73 && (pbVar11[5] == 0x3b)))) {
            *local_10 = 0x27;
            pbVar11 = pbVar11 + 6;
            local_10 = local_10 + 1;
            goto LAB_00f6f630;
          }
        }
      }
      else if (bVar13 == 0x6c) {
        if ((pbVar11[2] == 0x74) && (pbVar11[3] == 0x3b)) {
          pbVar11 = pbVar11 + 4;
          *local_10 = 0x3c;
          local_10 = local_10 + 1;
          goto LAB_00f6f630;
        }
      }
      else if ((((bVar13 == 0x71) && (pbVar11[2] == 0x75)) && (pbVar11[3] == 0x6f)) &&
              ((pbVar11[4] == 0x74 && (pbVar11[5] == 0x3b)))) {
        pbVar11 = pbVar11 + 6;
        *local_10 = 0x22;
        local_10 = local_10 + 1;
        goto LAB_00f6f630;
      }
    }
LAB_00f6f618:
    *local_10 = *pbVar11;
    pbVar11 = pbVar11 + 1;
    local_10 = local_10 + 1;
    goto LAB_00f6f630;
  }
  lVar12 = *(long *)param_2;
  if (*(char *)(lVar12 + 1) == '/') {
    pbVar15 = (byte *)(lVar12 + 2);
    *(byte **)param_2 = pbVar15;
    pbVar14 = (byte *)param_1[1];
    if (((pbVar14 <= pbVar15) && (pbVar14 != (byte *)0x0)) ||
       (PTR_lookup_node_name_0171cc58[*(byte *)(lVar12 + 2)] == '\0')) goto LAB_00f6fcac;
    goto LAB_00f6fda4;
  }
  *(long *)param_2 = lVar12 + 1;
  if (*(char *)(lVar12 + 1) != '!') {
    if (*(char *)(lVar12 + 1) == '?') {
      pbVar15 = (byte *)(lVar12 + 2);
      *(byte **)param_2 = pbVar15;
      bVar13 = *(byte *)(lVar12 + 2);
      if (((((bVar13 & 0xdf) == 0x58) && ((*(byte *)(lVar12 + 3) & 0xdf) == 0x4d)) &&
          ((*(byte *)(lVar12 + 4) & 0xdf) == 0x4c)) &&
         (PTR_lookup_whitespace_0171b438[*(byte *)(lVar12 + 5)] != '\0')) {
        pcVar10 = (char *)(lVar12 + 6);
        *(char **)param_2 = pcVar10;
        do {
          if (*pcVar10 == '?') {
            if (pcVar10[1] == '>') goto code_r0x00f6f558;
          }
          else if (*pcVar10 == '\0') goto LAB_00f6f5ac;
          pcVar10 = pcVar10 + 1;
          *(char **)param_2 = pcVar10;
        } while( true );
      }
      goto LAB_00f6f8c4;
    }
    parse_element<1>((xml_sax3_parser<char> *)param_1,(char **)param_2);
    pbVar15 = *(byte **)param_2;
    goto LAB_00f6f480;
  }
  cVar2 = *(char *)(lVar12 + 2);
  if (cVar2 == 'D') {
    if (((*(char *)(lVar12 + 3) == 'O') && (*(char *)(lVar12 + 4) == 'C')) &&
       ((*(char *)(lVar12 + 5) == 'T' &&
        ((((*(char *)(lVar12 + 6) == 'Y' && (*(char *)(lVar12 + 7) == 'P')) &&
          (*(char *)(lVar12 + 8) == 'E')) &&
         (PTR_lookup_whitespace_0171b438[*(byte *)(lVar12 + 9)] != '\0')))))) {
      pcVar10 = (char *)(lVar12 + 10);
      *(char **)param_2 = pcVar10;
      goto LAB_00f6fba8;
    }
  }
  else if (cVar2 == '[') {
    if (((*(char *)(lVar12 + 3) == 'C') && (*(char *)(lVar12 + 4) == 'D')) &&
       (((*(char *)(lVar12 + 5) == 'A' &&
         ((*(char *)(lVar12 + 6) == 'T' && (*(char *)(lVar12 + 7) == 'A')))) &&
        (*(char *)(lVar12 + 8) == '[')))) {
      *(long *)param_2 = lVar12 + 9;
      parse_cdata<1>((xml_sax3_parser<char> *)param_1,(char **)param_2);
      pbVar15 = *(byte **)param_2;
      goto LAB_00f6f480;
    }
  }
  else if ((cVar2 == '-') && (*(char *)(lVar12 + 3) == '-')) {
    pcVar10 = (char *)(lVar12 + 4);
    *(char **)param_2 = pcVar10;
    goto LAB_00f6fc24;
  }
  pcVar10 = (char *)(lVar12 + 2);
  *(char **)param_2 = pcVar10;
  if (*(char *)(lVar12 + 2) == '>') goto LAB_00f6f968;
  if (*(char *)(lVar12 + 2) == '\0') goto LAB_00f6f5ac;
  pcVar10 = (char *)(lVar12 + 3);
  goto LAB_00f6f954;
LAB_00f6f744:
  *(byte **)param_2 = pbVar11;
  bVar13 = *pbVar11;
  *local_10 = 0;
  (**(code **)(*(long *)*param_1 + 0x30))(*param_1,pbVar14,(long)local_10 - (long)pbVar14);
  goto LAB_00f6f4a8;
code_r0x00f6f558:
  pbVar15 = (byte *)(pcVar10 + 2);
  *(byte **)param_2 = pbVar15;
  pbVar11 = (byte *)param_1[1];
  bVar6 = pbVar11 == (byte *)0x0;
  pbVar14 = pbVar15;
  bVar3 = bVar6;
  if (pbVar15 < pbVar11) {
LAB_00f6f574:
    cVar2 = PTR_lookup_whitespace_0171b438[*pbVar14];
    pbVar15 = pbVar14;
    while ((cVar2 != '\0' && ((pbVar15 = pbVar15 + 1, pbVar15 < pbVar11 || (bVar3))))) {
      cVar2 = PTR_lookup_whitespace_0171b438[*pbVar15];
    }
    goto LAB_00f6f49c;
  }
  goto LAB_00f6f494;
LAB_00f6f8c4:
  if (bVar13 == 0x3f) {
    if (pbVar15[1] == 0x3e) goto code_r0x00f6f8d8;
  }
  else if (bVar13 == 0) goto LAB_00f6f5ac;
  pbVar15 = pbVar15 + 1;
  *(byte **)param_2 = pbVar15;
  bVar13 = *pbVar15;
  goto LAB_00f6f8c4;
code_r0x00f6f8d8:
  pbVar15 = pbVar15 + 2;
  *(byte **)param_2 = pbVar15;
  goto LAB_00f6f480;
LAB_00f6fba8:
  cVar2 = *pcVar10;
  if (cVar2 != '>') {
    if (cVar2 == '\0') goto LAB_00f6f5ac;
    pcVar10 = pcVar10 + 1;
    if (cVar2 == '[') {
      iVar7 = 1;
      *(char **)param_2 = pcVar10;
      do {
        cVar2 = *pcVar10;
        if (cVar2 == '[') goto LAB_00f6fbf8;
        while (cVar2 != ']') {
          if (cVar2 == '\0') goto LAB_00f6f5ac;
          while( true ) {
            pcVar10 = pcVar10 + 1;
            *(char **)param_2 = pcVar10;
            cVar2 = *pcVar10;
            if (cVar2 != '[') break;
LAB_00f6fbf8:
            iVar7 = iVar7 + 1;
          }
        }
        pcVar10 = pcVar10 + 1;
        iVar7 = iVar7 + -1;
        *(char **)param_2 = pcVar10;
      } while (iVar7 != 0);
    }
    else {
      *(char **)param_2 = pcVar10;
    }
    goto LAB_00f6fba8;
  }
  pbVar15 = (byte *)(pcVar10 + 1);
  *(byte **)param_2 = pbVar15;
  goto LAB_00f6f480;
LAB_00f6fc24:
  if (*pcVar10 == '-') {
    if ((pcVar10[1] == '-') && (pcVar10[2] == '>')) goto code_r0x00f6fc48;
  }
  else if (*pcVar10 == '\0') {
LAB_00f6fe80:
                    /* WARNING: Subroutine does not return */
    FUN_006c445c(param_2);
  }
  pcVar10 = pcVar10 + 1;
  *(char **)param_2 = pcVar10;
  goto LAB_00f6fc24;
code_r0x00f6fc48:
  pbVar15 = (byte *)(pcVar10 + 3);
  *(byte **)param_2 = pbVar15;
  goto LAB_00f6f480;
LAB_00f6f954:
  *(char **)param_2 = pcVar10;
  cVar2 = *pcVar10;
  if (cVar2 == '>') goto LAB_00f6f968;
  pcVar10 = pcVar10 + 1;
  if (cVar2 == '\0') {
LAB_00f6f5ac:
    plVar8 = (long *)__cxa_allocate_exception(0x18);
    plVar8[2] = *(long *)param_2;
    puVar5 = PTR_typeinfo_01720ff0;
    puVar4 = PTR__parse_error_01718788;
    puVar1 = PTR_vtable_01723628 + 0x10;
    plVar8[1] = (long)"unexpected end of data";
    *plVar8 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
    __cxa_throw(plVar8,puVar5,puVar4);
  }
  goto LAB_00f6f954;
LAB_00f6f968:
  pbVar15 = (byte *)(pcVar10 + 1);
  *(byte **)param_2 = pbVar15;
  goto LAB_00f6f480;
  while (PTR_lookup_node_name_0171cc58[*pbVar15] != '\0') {
LAB_00f6fda4:
    pbVar15 = pbVar15 + 1;
    if ((pbVar14 <= pbVar15) && (pbVar14 != (byte *)0x0)) break;
  }
LAB_00f6fcac:
  *(byte **)param_2 = pbVar15;
  pbVar14 = (byte *)param_1[1];
  if ((pbVar15 < pbVar14) || (pbVar14 == (byte *)0x0)) {
    cVar2 = PTR_lookup_whitespace_0171b438[*pbVar15];
    while ((cVar2 != '\0' &&
           ((pbVar15 = pbVar15 + 1, pbVar15 < pbVar14 || (pbVar14 == (byte *)0x0))))) {
      cVar2 = PTR_lookup_whitespace_0171b438[*pbVar15];
    }
  }
  *(byte **)param_2 = pbVar15;
  if (*pbVar15 == 0x3e) {
    *(byte **)param_2 = pbVar15 + 1;
    if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
      return;
    }
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  plVar8 = (long *)__cxa_allocate_exception(0x18);
  plVar8[2] = *(long *)param_2;
  puVar5 = PTR_typeinfo_01720ff0;
  puVar4 = PTR__parse_error_01718788;
  puVar1 = PTR_vtable_01723628 + 0x10;
  plVar8[1] = (long)"expected >";
  *plVar8 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
  __cxa_throw(plVar8,puVar5,puVar4);
}


/* === FUN_006c445c @ 006c445c === */

void FUN_006c445c(long *param_1)

{
  undefined *puVar1;
  undefined *puVar2;
  undefined *puVar3;
  long *plVar4;
  
  plVar4 = (long *)__cxa_allocate_exception(0x18);
  plVar4[2] = *param_1;
  puVar3 = PTR_typeinfo_01720ff0;
  puVar2 = PTR__parse_error_01718788;
  puVar1 = PTR_vtable_01723628 + 0x10;
  plVar4[1] = (long)"unexpected end of data";
  *plVar4 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
  __cxa_throw(plVar4,puVar3,puVar2);
}


/* === FUN_006c44ac @ 006c44ac === */

void FUN_006c44ac(long *param_1)

{
  undefined *puVar1;
  undefined *puVar2;
  undefined *puVar3;
  long *plVar4;
  
  plVar4 = (long *)__cxa_allocate_exception(0x18);
  plVar4[2] = *param_1;
  puVar3 = PTR_typeinfo_01720ff0;
  puVar2 = PTR__parse_error_01718788;
  puVar1 = PTR_vtable_01723628 + 0x10;
  plVar4[1] = (long)"invalid numeric character entity";
  *plVar4 = (long)puVar1;
                    /* WARNING: Subroutine does not return */
  __cxa_throw(plVar4,puVar3,puVar2);
}


/* === parseXMLString @ 00f40b34 === */

/* cocos2d::TMXMapInfo::parseXMLString(std::string const&) */

void __thiscall cocos2d::TMXMapInfo::parseXMLString(TMXMapInfo *this,string *param_1)

{
  char cVar1;
  undefined1 uVar2;
  ulong uVar3;
  SAXParser aSStack_10 [8];
  long local_8;
  
  uVar2 = 0;
  uVar3 = *(ulong *)(*(long *)param_1 + -0x18);
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (uVar3 != 0) {
    SAXParser::SAXParser(aSStack_10);
                    /* try { // try from 00f40bac to 01040cab has its CatchHandler @ 00f405e4 */
    cVar1 = SAXParser::init((char *)aSStack_10);
    uVar2 = 0;
    if (cVar1 != '\0') {
      SAXParser::setDelegator(aSStack_10,(SAXDelegator *)(this + 0x28));
      uVar2 = SAXParser::parse(aSStack_10,*(char **)param_1,uVar3);
    }
    SAXParser::~SAXParser(aSStack_10);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar2);
}


/* === parse @ 00f71468 === */

/* cocos2d::SAXParser::parse(std::string const&) */

void __thiscall cocos2d::SAXParser::parse(SAXParser *this,string *param_1)

{
  char cVar1;
  undefined1 uVar2;
  long *plVar3;
  char *pcVar4;
  ulong uVar5;
  Data aDStack_18 [16];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  plVar3 = (long *)FileUtils::getInstance();
  (**(code **)(*plVar3 + 0x28))(aDStack_18,plVar3,param_1);
  cVar1 = Data::isNull(aDStack_18);
  if (cVar1 == '\0') {
    pcVar4 = (char *)Data::getBytes(aDStack_18);
    uVar5 = Data::getSize(aDStack_18);
    uVar2 = parse(this,pcVar4,uVar5);
  }
  else {
    uVar2 = 0;
  }
  Data::~Data(aDStack_18);
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar2);
}


/* === getValueMapFromData @ 00f5d2c8 === */

/* cocos2d::FileUtils::getValueMapFromData(char const*, int) */

void cocos2d::FileUtils::getValueMapFromData(char *param_1,int param_2)

{
  char cVar1;
  bool bVar2;
  Value *this;
  Value *pVVar3;
  int *piVar4;
  int in_w2;
  int iVar5;
  _Hashtable *in_x8;
  undefined8 *puVar6;
  SAXParser aSStack_190 [16];
  undefined *local_180;
  undefined4 local_178;
  _lambda_std____detail___Hash_node<std::pair<std::string_const,cocos2d::Value>,true>_const___1_
  a_Stack_170 [8];
  undefined8 local_168;
  undefined8 local_158;
  undefined8 local_150;
  undefined8 uStack_148;
  Value *local_138;
  Value *local_130;
  long local_120;
  long local_118;
  void *local_f8;
  undefined8 *local_d0;
  long local_b0;
  void *local_a8;
  undefined8 *local_80;
  long local_60;
  void *local_58;
  undefined8 *local_30;
  long local_10;
  long local_8;
  
                    /* try { // try from 00f5d2e4 to 0105d2e7 has its CatchHandler @ 00f5d644 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  DictMaker::DictMaker((DictMaker *)&local_180);
  local_178 = 1;
  SAXParser::SAXParser(aSStack_190);
                    /* try { // try from 00f5d318 to 0105d31b has its CatchHandler @ 00f5d5d4 */
  SAXParser::setDelegator(aSStack_190,(SAXDelegator *)&local_180);
  SAXParser::parse(aSStack_190,(char *)(ulong)(uint)param_2,(long)in_w2);
                    /* try { // try from 00f5d348 to 0105d353 has its CatchHandler @ 00f5d63c */
  *(undefined8 *)in_x8 = 0;
  *(undefined8 *)(in_x8 + 8) = local_168;
  *(undefined8 *)(in_x8 + 0x10) = 0;
  *(undefined8 *)(in_x8 + 0x18) = local_158;
  *(undefined8 *)(in_x8 + 0x20) = local_150;
  *(undefined8 *)(in_x8 + 0x28) = uStack_148;
  std::
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  ::
  _M_assign<std::_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>::_M_assign(std::_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>const&)::_lambda(std::__detail::_Hash_node<std::pair<std::string_const,cocos2d::Value>,true>const*)_1_>
            (in_x8,a_Stack_170);
  SAXParser::~SAXParser(aSStack_190);
                    /* try { // try from 00f5d378 to 0105d37b has its CatchHandler @ 00f5d668 */
  local_180 = PTR_vtable_01720c48 + 0x10;
  if (local_58 != (void *)0x0) {
    for (puVar6 = local_30; puVar6 < (undefined8 *)(local_10 + 8U); puVar6 = puVar6 + 1) {
      operator_delete((void *)*puVar6);
    }
    operator_delete(local_58);
  }
  if (local_a8 != (void *)0x0) {
    for (puVar6 = local_80; puVar6 < (undefined8 *)(local_60 + 8U); puVar6 = puVar6 + 1) {
      operator_delete((void *)*puVar6);
    }
    operator_delete(local_a8);
  }
  if (local_f8 != (void *)0x0) {
    for (puVar6 = local_d0; puVar6 < (undefined8 *)(local_b0 + 8U); puVar6 = puVar6 + 1) {
      operator_delete((void *)*puVar6);
                    /* try { // try from 00f5d410 to 0105d43b has its CatchHandler @ 00f5d63c */
    }
    operator_delete(local_f8);
  }
  if ((undefined *)(local_118 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar5 = *(int *)(local_118 + -8);
      *(int *)(local_118 + -8) = iVar5 + -1;
    }
    else {
      piVar4 = (int *)(local_118 + -8);
      do {
        iVar5 = *piVar4;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar2) {
          *piVar4 = iVar5 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar5 < 1) {
      operator_delete((undefined *)(local_118 + -0x18));
    }
  }
  this = local_138;
  pVVar3 = local_130;
  if ((undefined *)(local_120 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar5 = *(int *)(local_120 + -8);
      *(int *)(local_120 + -8) = iVar5 + -1;
    }
    else {
      piVar4 = (int *)(local_120 + -8);
      do {
        iVar5 = *piVar4;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar2) {
          *piVar4 = iVar5 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar5 < 1) {
      operator_delete((undefined *)(local_120 + -0x18));
      this = local_138;
      pVVar3 = local_130;
    }
  }
  for (; this != local_130; this = this + 0x10) {
    cocos2d::Value::~Value(this);
    pVVar3 = local_138;
  }
  if (pVVar3 != (Value *)0x0) {
    operator_delete(pVVar3);
  }
  std::
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  ::~_Hashtable((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                 *)a_Stack_170);
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}


/* === parseXMLFile @ 00f40d1c === */

/* cocos2d::TMXMapInfo::parseXMLFile(std::string const&) */

void __thiscall cocos2d::TMXMapInfo::parseXMLFile(TMXMapInfo *this,string *param_1)

{
  bool bVar1;
  char cVar2;
  undefined1 uVar3;
  long *plVar4;
  int iVar5;
  int *piVar6;
  SAXParser aSStack_18 [8];
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  SAXParser::SAXParser(aSStack_18);
                    /* try { // try from 00f40d60 to 01040dcf has its CatchHandler @ 00f405e4 */
  cVar2 = SAXParser::init((char *)aSStack_18);
  uVar3 = 0;
  if (cVar2 != '\0') {
    SAXParser::setDelegator(aSStack_18,(SAXDelegator *)(this + 0x28));
    plVar4 = (long *)FileUtils::getInstance();
    (**(code **)(*plVar4 + 0x50))((string *)&local_10,plVar4,param_1);
                    /* catch() { ... } // from try @ 00f40b20 with catch @ 00f40d9c
                       catch() { ... } // from try @ 00f40cd0 with catch @ 00f40d9c */
    uVar3 = SAXParser::parse(aSStack_18,(string *)&local_10);
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar5 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar5 + -1;
      }
      else {
        piVar6 = (int *)(local_10 + -8);
        do {
          iVar5 = *piVar6;
          cVar2 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar6,0x10);
          if (bVar1) {
            *piVar6 = iVar5 + -1;
            cVar2 = ExclusiveMonitorsStatus();
          }
        } while (cVar2 != '\0');
      }
      if (iVar5 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
  }
                    /* catch() { ... } // from try @ 00f408f8 with catch @ 00f40dbc */
  SAXParser::~SAXParser(aSStack_18);
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar3);
}


/* === getValueMapFromFile @ 00f5cf9c === */

/* cocos2d::FileUtils::getValueMapFromFile(std::string const&) */

void __thiscall cocos2d::FileUtils::getValueMapFromFile(FileUtils *this,string *param_1)

{
  char cVar1;
  bool bVar2;
  Value *this_00;
  Value *pVVar3;
  int *piVar4;
  int iVar5;
  _Hashtable *in_x8;
  undefined8 *puVar6;
  long local_198;
  SAXParser aSStack_190 [16];
  undefined *local_180;
  undefined4 local_178;
  _lambda_std____detail___Hash_node<std::pair<std::string_const,cocos2d::Value>,true>_const___1_
  a_Stack_170 [8];
  undefined8 local_168;
  undefined8 local_158;
  undefined8 local_150;
  undefined8 uStack_148;
  Value *local_138;
  Value *local_130;
  long local_120;
  long local_118;
  void *local_f8;
  undefined8 *local_d0;
  long local_b0;
  void *local_a8;
  undefined8 *local_80;
  long local_60;
  void *local_58;
  undefined8 *local_30;
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  (**(code **)(*(long *)this + 0x50))((string *)&local_198);
  DictMaker::DictMaker((DictMaker *)&local_180);
  local_178 = 1;
  SAXParser::SAXParser(aSStack_190);
                    /* catch() { ... } // from try @ 00f5d1e0 with catch @ 00f5d004 */
  SAXParser::setDelegator(aSStack_190,(SAXDelegator *)&local_180);
  SAXParser::parse(aSStack_190,(string *)&local_198);
  *(undefined8 *)in_x8 = 0;
  *(undefined8 *)(in_x8 + 8) = local_168;
  *(undefined8 *)(in_x8 + 0x10) = 0;
  *(undefined8 *)(in_x8 + 0x18) = local_158;
  *(undefined8 *)(in_x8 + 0x20) = local_150;
  *(undefined8 *)(in_x8 + 0x28) = uStack_148;
  std::
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  ::
  _M_assign<std::_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>::_M_assign(std::_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>const&)::_lambda(std::__detail::_Hash_node<std::pair<std::string_const,cocos2d::Value>,true>const*)_1_>
            (in_x8,a_Stack_170);
  SAXParser::~SAXParser(aSStack_190);
  local_180 = PTR_vtable_01720c48 + 0x10;
  if (local_58 != (void *)0x0) {
                    /* try { // try from 00f5d07c to 0105d07f has its CatchHandler @ 00f5d20c */
    for (puVar6 = local_30; puVar6 < (undefined8 *)(local_10 + 8U); puVar6 = puVar6 + 1) {
      operator_delete((void *)*puVar6);
    }
    operator_delete(local_58);
  }
  if (local_a8 != (void *)0x0) {
    for (puVar6 = local_80; puVar6 < (undefined8 *)(local_60 + 8U); puVar6 = puVar6 + 1) {
      operator_delete((void *)*puVar6);
    }
    operator_delete(local_a8);
  }
                    /* try { // try from 00f5d0cc to 0105d0cf has its CatchHandler @ 00f5d1f0 */
  if (local_f8 != (void *)0x0) {
    for (puVar6 = local_d0; puVar6 < (undefined8 *)(local_b0 + 8U); puVar6 = puVar6 + 1) {
      operator_delete((void *)*puVar6);
    }
    operator_delete(local_f8);
  }
  if ((undefined *)(local_118 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar5 = *(int *)(local_118 + -8);
      *(int *)(local_118 + -8) = iVar5 + -1;
    }
    else {
      piVar4 = (int *)(local_118 + -8);
      do {
        iVar5 = *piVar4;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar2) {
          *piVar4 = iVar5 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar5 < 1) {
      operator_delete((undefined *)(local_118 + -0x18));
    }
  }
  this_00 = local_138;
  pVVar3 = local_130;
  if ((undefined *)(local_120 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00f5d1e0 to 0105d223 has its CatchHandler @ 00f5d004 */
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar5 = *(int *)(local_120 + -8);
      *(int *)(local_120 + -8) = iVar5 + -1;
    }
    else {
      piVar4 = (int *)(local_120 + -8);
      do {
                    /* catch() { ... } // from try @ 00f5d0cc with catch @ 00f5d1f0 */
        iVar5 = *piVar4;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar2) {
          *piVar4 = iVar5 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar5 < 1) {
                    /* catch() { ... } // from try @ 00f5d07c with catch @ 00f5d20c */
      operator_delete((undefined *)(local_120 + -0x18));
      this_00 = local_138;
      pVVar3 = local_130;
    }
  }
  for (; this_00 != local_130; this_00 = this_00 + 0x10) {
    cocos2d::Value::~Value(this_00);
    pVVar3 = local_138;
  }
  if (pVVar3 != (Value *)0x0) {
    operator_delete(pVVar3);
  }
  std::
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  ::~_Hashtable((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                 *)a_Stack_170);
  if ((undefined *)(local_198 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar5 = *(int *)(local_198 + -8);
      *(int *)(local_198 + -8) = iVar5 + -1;
    }
    else {
      piVar4 = (int *)(local_198 + -8);
      do {
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f5d620 with catch @ 00f5d224
                        */
        iVar5 = *piVar4;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar4,0x10);
        if (bVar2) {
          *piVar4 = iVar5 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar5 < 1) {
      operator_delete((undefined *)(local_198 + -0x18));
    }
  }
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}


/* === getValueVectorFromFile @ 00f5d564 === */

/* cocos2d::FileUtils::getValueVectorFromFile(std::string const&) */

void __thiscall cocos2d::FileUtils::getValueVectorFromFile(FileUtils *this,string *param_1)

{
  Value *pVVar1;
  char cVar2;
  bool bVar3;
  Value *pVVar4;
  int *piVar5;
  int iVar6;
  undefined8 *in_x8;
  undefined8 *puVar7;
  ulong uVar8;
  Value *pVVar9;
  long local_190;
  SAXParser aSStack_188 [8];
  undefined *local_180;
  undefined4 local_178;
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  a_Stack_170 [56];
  Value *local_138;
  Value *local_130;
  long local_120;
  long local_118;
  void *local_f8;
  undefined8 *local_d0;
  long local_b0;
  void *local_a8;
  undefined8 *local_80;
  long local_60;
  void *local_58;
  undefined8 *local_30;
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  (**(code **)(*(long *)this + 0x50))((string *)&local_190);
  DictMaker::DictMaker((DictMaker *)&local_180);
  local_178 = 2;
  SAXParser::SAXParser(aSStack_188);
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f5d2a8 with catch @ 00f5d5d4
                       catch(type#1 @ 00000000) { ... } // from try @ 00f5d318 with catch @ 00f5d5d4
                       catch(type#1 @ 00000000) { ... } // from try @ 00f5d450 with catch @ 00f5d5d4
                       catch(type#1 @ 00000000) { ... } // from try @ 00f5d638 with catch @ 00f5d5d4
                        */
  SAXParser::setDelegator(aSStack_188,(SAXDelegator *)&local_180);
  SAXParser::parse(aSStack_188,(string *)&local_190);
  *in_x8 = 0;
  uVar8 = (long)local_130 - (long)local_138;
  in_x8[1] = 0;
  in_x8[2] = 0;
  if ((long)uVar8 >> 4 == 0) {
    pVVar9 = (Value *)0x0;
  }
  else {
    if (0xfffffffffffffff < (ulong)((long)uVar8 >> 4)) {
                    /* WARNING: Subroutine does not return */
                    /* try { // try from 00f5d8e0 to 0105d8e3 has its CatchHandler @ 00f5d68c */
      FUN_0120f0e8();
    }
    pVVar9 = operator_new(uVar8);
  }
  pVVar4 = local_130;
  *in_x8 = pVVar9;
  in_x8[2] = pVVar9 + uVar8;
  in_x8[1] = pVVar9;
                    /* try { // try from 00f5d620 to 0105d623 has its CatchHandler @ 00f5d224 */
  for (pVVar1 = local_138; pVVar1 != pVVar4; pVVar1 = pVVar1 + 0x10) {
    if (pVVar9 != (Value *)0x0) {
      cocos2d::Value::Value(pVVar9,pVVar1);
    }
                    /* try { // try from 00f5d638 to 0105d63b has its CatchHandler @ 00f5d5d4 */
    pVVar9 = pVVar9 + 0x10;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f5d348 with catch @ 00f5d63c
                       catch(type#1 @ 00000000) { ... } // from try @ 00f5d410 with catch @ 00f5d63c
                        */
  }
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f5d2e4 with catch @ 00f5d644
                        */
  in_x8[1] = pVVar9;
  SAXParser::~SAXParser(aSStack_188);
  local_180 = PTR_vtable_01720c48 + 0x10;
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f5d378 with catch @ 00f5d668
                        */
  if (local_58 != (void *)0x0) {
                    /* try { // try from 00f5d674 to 0105d677 has its CatchHandler @ 00f5d678 */
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f5d674 with catch @ 00f5d678
                        */
    for (puVar7 = local_30; puVar7 < (undefined8 *)(local_10 + 8U); puVar7 = puVar7 + 1) {
      operator_delete((void *)*puVar7);
    }
    operator_delete(local_58);
  }
  if (local_a8 != (void *)0x0) {
    for (puVar7 = local_80; puVar7 < (undefined8 *)(local_60 + 8U); puVar7 = puVar7 + 1) {
      operator_delete((void *)*puVar7);
    }
    operator_delete(local_a8);
  }
  if (local_f8 != (void *)0x0) {
    for (puVar7 = local_d0; puVar7 < (undefined8 *)(local_b0 + 8U); puVar7 = puVar7 + 1) {
      operator_delete((void *)*puVar7);
    }
    operator_delete(local_f8);
  }
  if ((undefined *)(local_118 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                    /* catch() { ... } // from try @ 00f5d88c with catch @ 00f5d890 */
      iVar6 = *(int *)(local_118 + -8);
      *(int *)(local_118 + -8) = iVar6 + -1;
    }
    else {
      piVar5 = (int *)(local_118 + -8);
      do {
        iVar6 = *piVar5;
        cVar2 = '\x01';
        bVar3 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar3) {
          *piVar5 = iVar6 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (iVar6 < 1) {
      operator_delete((undefined *)(local_118 + -0x18));
    }
  }
  pVVar9 = local_138;
  pVVar1 = local_130;
  if ((undefined *)(local_120 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar6 = *(int *)(local_120 + -8);
      *(int *)(local_120 + -8) = iVar6 + -1;
                    /* try { // try from 00f5d88c to 0105d88f has its CatchHandler @ 00f5d890 */
    }
    else {
      piVar5 = (int *)(local_120 + -8);
      do {
        iVar6 = *piVar5;
        cVar2 = '\x01';
        bVar3 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar3) {
          *piVar5 = iVar6 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
                    /* catch(type#1 @ 00000000) { ... } // from try @ 00f5d770 with catch @ 00f5d858
                        */
      } while (cVar2 != '\0');
    }
    if (iVar6 < 1) {
      operator_delete((undefined *)(local_120 + -0x18));
      pVVar9 = local_138;
      pVVar1 = local_130;
    }
  }
  for (; pVVar9 != local_130; pVVar9 = pVVar9 + 0x10) {
    cocos2d::Value::~Value(pVVar9);
    pVVar1 = local_138;
  }
  if (pVVar1 != (Value *)0x0) {
    operator_delete(pVVar1);
  }
  std::
  _Hashtable<std::string,std::pair<std::string_const,cocos2d::Value>,std::allocator<std::pair<std::string_const,cocos2d::Value>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
  ::~_Hashtable(a_Stack_170);
                    /* try { // try from 00f5d770 to 0105d773 has its CatchHandler @ 00f5d858 */
  if ((undefined *)(local_190 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar6 = *(int *)(local_190 + -8);
      *(int *)(local_190 + -8) = iVar6 + -1;
    }
    else {
      piVar5 = (int *)(local_190 + -8);
      do {
        iVar6 = *piVar5;
        cVar2 = '\x01';
        bVar3 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar3) {
          *piVar5 = iVar6 + -1;
          cVar2 = ExclusiveMonitorsStatus();
        }
      } while (cVar2 != '\0');
    }
    if (iVar6 < 1) {
      operator_delete((undefined *)(local_190 + -0x18));
    }
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === parseCapInset @ 00f77158 === */

/* cocos2d::NinePatchImageParser::parseCapInset() const */

void cocos2d::NinePatchImageParser::parseCapInset(void)

{
  long in_x0;
  long lVar1;
  Rect *in_x8;
  float fVar2;
  float fVar3;
  float fVar4;
  float fVar5;
  float fVar6;
  float fVar7;
  float fVar8;
  float local_28;
  float local_24;
  float local_20;
  float local_1c;
  Rect aRStack_18 [16];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  Rect::Rect(in_x8);
  parseHorizontalMargin();
  parseVerticalMargin();
  if (*(char *)(in_x0 + 0x20) == '\0') {
    Rect::Rect(aRStack_18,local_28,local_20,local_24 - local_28,local_1c - local_20);
    Rect::operator=(in_x8,aRStack_18);
  }
  else {
    Rect::Rect(aRStack_18,local_1c,*(float *)(in_x0 + 0x1c) - local_24,local_1c - local_20,
               local_24 - local_28);
    Rect::operator=(in_x8,aRStack_18);
  }
  fVar5 = *(float *)in_x8;
  lVar1 = Director::getInstance();
  fVar2 = *(float *)(lVar1 + 0x200);
  fVar7 = *(float *)(in_x8 + 4);
  lVar1 = Director::getInstance();
  fVar3 = *(float *)(lVar1 + 0x200);
  fVar6 = *(float *)(in_x8 + 8);
  lVar1 = Director::getInstance();
  fVar4 = *(float *)(lVar1 + 0x200);
  fVar8 = *(float *)(in_x8 + 0xc);
  lVar1 = Director::getInstance();
  Rect::Rect(aRStack_18,fVar5 / fVar2,fVar7 / fVar3,fVar6 / fVar4,fVar8 / *(float *)(lVar1 + 0x200))
  ;
  Rect::operator=(in_x8,aRStack_18);
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === parseNinePatchImage @ 00fe4710 === */

/* cocos2d::TextureCache::parseNinePatchImage(cocos2d::Image*, cocos2d::Texture2D*, std::string
   const&) */

void __thiscall
cocos2d::TextureCache::parseNinePatchImage
          (TextureCache *this,Image *param_1,Texture2D *param_2,string *param_3)

{
  char cVar1;
  Rect aRStack_50 [16];
  Rect aRStack_40 [16];
  NinePatchImageParser aNStack_30 [40];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  cVar1 = NinePatchImageParser::isNinePatchImage(param_3);
                    /* catch() { ... } // from try @ 00fe4784 with catch @ 00fe4740
                       catch() { ... } // from try @ 00fe4d04 with catch @ 00fe4740 */
  if (cVar1 != '\0') {
                    /* try { // try from 00fe4784 to 010e4b27 has its CatchHandler @ 00fe4740 */
    Rect::Rect(aRStack_50,0.0,0.0,(float)*(int *)(param_1 + 0x38),(float)*(int *)(param_1 + 0x3c));
    NinePatchImageParser::NinePatchImageParser(aNStack_30,param_1,aRStack_50,false);
    NinePatchImageParser::parseCapInset();
    Texture2D::addSpriteFrameCapInset(param_2,(SpriteFrame *)0x0,aRStack_40);
    NinePatchImageParser::~NinePatchImageParser(aNStack_30);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}


/* === loop @ 00f82c60 === */

/* cocos2d::Console::loop() */

void __thiscall cocos2d::Console::loop(Console *this)

{
  uint uVar1;
  Console CVar2;
  bool bVar3;
  uint *puVar4;
  uint *puVar5;
  uint *puVar6;
  undefined *puVar7;
  char cVar8;
  int iVar9;
  ulong uVar10;
  long lVar11;
  long *plVar12;
  long *plVar13;
  uint *puVar14;
  int *piVar15;
  undefined4 *puVar16;
  undefined4 *puVar17;
  uint *puVar18;
  long *plVar19;
  long *plVar20;
  int *piVar21;
  uint local_b4;
  undefined8 local_b0;
  undefined8 local_a8;
  uint *local_a0;
  uint *local_98;
  uint *local_90;
  ulong auStack_88 [16];
  long local_8;
  
  puVar7 = PTR___stack_chk_guard_01721c30;
  this[0xd0] = (Console)0x1;
  *(undefined8 *)(this + 0x50) = 0;
  *(undefined8 *)(this + 0x58) = 0;
  *(undefined8 *)(this + 0x60) = 0;
  *(undefined8 *)(this + 0x68) = 0;
  *(undefined8 *)(this + 0x70) = 0;
  *(undefined8 *)(this + 0x78) = 0;
  *(undefined8 *)(this + 0x80) = 0;
  *(undefined8 *)(this + 0x88) = 0;
  *(undefined8 *)(this + 0x90) = 0;
  *(undefined8 *)(this + 0x98) = 0;
  *(undefined8 *)(this + 0xa0) = 0;
  *(undefined8 *)(this + 0xa8) = 0;
  *(undefined8 *)(this + 0xb0) = 0;
  *(undefined8 *)(this + 0xb8) = 0;
  *(undefined8 *)(this + 0xc0) = 0;
  *(undefined8 *)(this + 200) = 0;
  local_8 = *(long *)puVar7;
  uVar1 = *(uint *)(this + 0x24);
  uVar10 = (long)((ulong)uVar1 << 0x20) >> 0x23 & 0x1ffffffffffffff8;
  *(ulong *)(this + uVar10 + 0x50) = *(ulong *)(this + uVar10 + 0x50) | 1L << (uVar1 & 0x3f);
  *(uint *)(this + 0x28) = uVar1;
LAB_00f82d08:
  do {
    CVar2 = this[0xd1];
    while( true ) {
      if (CVar2 != (Console)0x0) {
        puVar17 = *(undefined4 **)(this + 0x38);
        for (puVar16 = *(undefined4 **)(this + 0x30); puVar16 != puVar17; puVar16 = puVar16 + 1) {
          close(*puVar16);
        }
        close(*(undefined4 *)(this + 0x24));
        this[0xd0] = (Console)0x0;
        if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
          __stack_chk_fail();
        }
        return;
      }
      memcpy(auStack_88,this + 0x50,0x80);
      local_b0 = 0;
      local_a8 = 16000;
      iVar9 = select(*(int *)(this + 0x28) + 1,auStack_88,0,0,&local_b0);
      if (iVar9 == -1) break;
      if (iVar9 != 0) {
        if ((auStack_88[(ulong)(long)(int)*(uint *)(this + 0x24) >> 6] >>
             (*(uint *)(this + 0x24) & 0x3f) & 1) != 0) {
          iVar9 = iVar9 + -1;
          addClient(this);
          if (iVar9 < 1) goto LAB_00f82d08;
        }
        puVar14 = *(uint **)(this + 0x30);
        puVar18 = *(uint **)(this + 0x38);
        local_a0 = (uint *)0x0;
        local_98 = (uint *)0x0;
        local_90 = (uint *)0x0;
        if (puVar14 != puVar18) {
          do {
            if ((auStack_88[(ulong)(long)(int)*puVar14 >> 6] >> (*puVar14 & 0x3f) & 1) != 0) {
              local_b4 = 0;
              ioctl(*puVar14,0x541b,&local_b4);
              if (local_b4 != 0) {
                cVar8 = parseCommand(this,*puVar14);
                if (cVar8 == '\0') {
                  if (local_98 == local_90) {
                    std::vector<int,std::allocator<int>>::_M_emplace_back_aux<int_const&>
                              ((vector<int,std::allocator<int>> *)&local_a0,(int *)puVar14);
                  }
                  else {
                    if (local_98 != (uint *)0x0) {
                      *local_98 = *puVar14;
                    }
                    local_98 = local_98 + 1;
                    /* catch() { ... } // from try @ 00f82e30 with catch @ 00f82e0c
                       catch() { ... } // from try @ 00f82e68 with catch @ 00f82e0c */
                  }
                }
                iVar9 = iVar9 + -1;
                puVar4 = local_a0;
                puVar5 = local_98;
                puVar6 = local_98;
                if (iVar9 < 1) break;
              }
            }
            puVar14 = puVar14 + 1;
            puVar4 = local_a0;
            puVar5 = local_98;
            puVar6 = local_98;
          } while (puVar18 != puVar14);
          for (; puVar14 = local_98, local_98 != puVar4; puVar4 = puVar4 + 1) {
                    /* try { // try from 00f82e30 to 01082e33 has its CatchHandler @ 00f82e0c */
            local_b4 = *puVar4;
            uVar10 = (long)((ulong)local_b4 << 0x20) >> 0x23 & 0x1ffffffffffffff8;
            *(ulong *)(this + uVar10 + 0x50) =
                 *(ulong *)(this + uVar10 + 0x50) & (1L << (local_b4 & 0x3f) ^ 0xffffffffffffffffU);
            local_98 = puVar6;
            lVar11 = std::
                     __remove_if<__gnu_cxx::__normal_iterator<int*,std::vector<int,std::allocator<int>>>,__gnu_cxx::__ops::_Iter_equals_val<int_const>>
                               (*(undefined8 *)(this + 0x30),*(undefined8 *)(this + 0x38),&local_b4)
            ;
                    /* try { // try from 00f82e68 to 01082e6b has its CatchHandler @ 00f82e0c */
                    /* catch() { ... } // from try @ 00f82ea0 with catch @ 00f82e6c
                       catch() { ... } // from try @ 00f831dc with catch @ 00f82e6c */
            if (*(long *)(this + 0x38) != lVar11) {
              *(long *)(this + 0x38) = lVar11;
            }
            puVar5 = local_a0;
            puVar6 = local_98;
            local_98 = puVar14;
          }
          local_98 = puVar6;
          if (puVar5 != (uint *)0x0) {
            operator_delete(puVar5);
          }
        }
      }
      plVar13 = *(long **)(this + 0x138);
      plVar19 = *(long **)(this + 0x140);
      if (plVar13 == plVar19) goto LAB_00f82d08;
                    /* try { // try from 00f82ea0 to 01082ec7 has its CatchHandler @ 00f82e6c */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
LAB_00f82ed8:
        do {
          piVar15 = *(int **)(this + 0x38);
          for (piVar21 = *(int **)(this + 0x30); piVar15 != piVar21; piVar21 = piVar21 + 1) {
            Utility::sendToConsole(*piVar21,(void *)*plVar13,*(ulong *)(*plVar13 + -0x18),0);
          }
          plVar13 = plVar13 + 1;
        } while (plVar19 != plVar13);
        plVar12 = *(long **)(this + 0x138);
        plVar20 = *(long **)(this + 0x140);
        plVar13 = plVar12;
        plVar19 = plVar20;
joined_r0x00f82f24:
        if (plVar20 != plVar13) {
          do {
            lVar11 = *plVar13;
            plVar19 = plVar12;
            if ((undefined *)(lVar11 + -0x18) != PTR_DAT_017191c0) {
              if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
                iVar9 = *(int *)(lVar11 + -8);
                *(int *)(lVar11 + -8) = iVar9 + -1;
              }
              else {
                piVar21 = (int *)(lVar11 + -8);
                do {
                  iVar9 = *piVar21;
                  cVar8 = '\x01';
                  bVar3 = (bool)ExclusiveMonitorPass(piVar21,0x10);
                  if (bVar3) {
                    *piVar21 = iVar9 + -1;
                    cVar8 = ExclusiveMonitorsStatus();
                  }
                } while (cVar8 != '\0');
              }
              if (iVar9 < 1) goto code_r0x00f82f70;
            }
            plVar13 = plVar13 + 1;
            if (plVar20 == plVar13) break;
          } while( true );
        }
        goto LAB_00f82f98;
      }
      iVar9 = pthread_mutex_trylock(this + 0x10c);
      if (iVar9 != 0) goto LAB_00f82d08;
      plVar13 = *(long **)(this + 0x138);
      plVar19 = *(long **)(this + 0x140);
      if (plVar13 != plVar19) goto LAB_00f82ed8;
LAB_00f82f98:
                    /* try { // try from 00f82f98 to 01082f9b has its CatchHandler @ 00f831c8 */
      *(long **)(this + 0x140) = plVar19;
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) goto LAB_00f82d08;
      pthread_mutex_unlock(this + 0x10c);
      CVar2 = this[0xd1];
    }
    piVar21 = (int *)__errno();
    if (*piVar21 != 4) {
      cocos2d::log("Abnormal error in select()\n");
    }
  } while( true );
code_r0x00f82f70:
  plVar13 = plVar13 + 1;
  operator_delete((undefined *)(lVar11 + -0x18));
  goto joined_r0x00f82f24;
}


/* === lua_cocos2dx_Properties_parseVec2 @ 00a1d040 === */

/* lua_cocos2dx_Properties_parseVec2(lua_State*) */

void lua_cocos2dx_Properties_parseVec2(lua_State *param_1)

{
  bool bVar1;
  char *pcVar2;
  char cVar3;
  char cVar4;
  undefined1 uVar5;
  int iVar6;
  int *piVar7;
  undefined8 uVar8;
  Vec2 *local_18;
  char *local_10;
  long local_8;
  
                    /* try { // try from 00a1d048 to 00b1d04b has its CatchHandler @ 00a1d4c4 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  iVar6 = lua_gettop();
  if (iVar6 + -1 == 2) {
                    /* try { // try from 00a1d0c4 to 00b1d0c7 has its CatchHandler @ 00a1d47c */
    local_10 = PTR_DAT_017191c0 + 0x18;
    cVar3 = luaval_to_std_string(param_1,2,(string *)&local_10,"cc.Properties:parseVec2");
    pcVar2 = local_10;
    cVar4 = FUN_00a0e7b0(param_1,&local_18);
                    /* try { // try from 00a1d100 to 00b1d103 has its CatchHandler @ 00a1d4bc */
    if ((cVar4 == '\0') || (cVar3 == '\0')) {
      tolua_error(param_1,&DAT_012d6c58,0);
      uVar8 = 0;
    }
    else {
                    /* try { // try from 00a1d10c to 00b1d10f has its CatchHandler @ 00a1d440 */
      uVar5 = cocos2d::Properties::parseVec2(pcVar2,local_18);
      tolua_pushboolean(param_1,uVar5);
      uVar8 = 1;
    }
    if (local_10 + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar6 + -1;
      }
      else {
        piVar7 = (int *)(local_10 + -8);
        do {
                    /* try { // try from 00a1d14c to 00b1d14f has its CatchHandler @ 00a1d4bc */
          iVar6 = *piVar7;
          cVar3 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar7,0x10);
          if (bVar1) {
            *piVar7 = iVar6 + -1;
            cVar3 = ExclusiveMonitorsStatus();
          }
        } while (cVar3 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete(local_10 + -0x18);
      }
    }
  }
  else {
                    /* try { // try from 00a1d07c to 00b1d09f has its CatchHandler @ 00a1d4bc */
    uVar8 = 0;
    luaL_error(param_1,&DAT_012cb120,&DAT_012d6c40,iVar6 + -1,2);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 00a1d0b0 to 00b1d0b3 has its CatchHandler @ 00a1d4b4 */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar8);
}


/* === getVec2 @ 00f9fa38 === */

/* cocos2d::Properties::getVec2(char const*, cocos2d::Vec2*) const */

void __thiscall cocos2d::Properties::getVec2(Properties *this,char *param_1,Vec2 *param_2)

{
  char *pcVar1;
  
  pcVar1 = (char *)getString(this,param_1,(char *)0x0);
  parseVec2(pcVar1,param_2);
  return;
}


/* === lua_cocos2dx_Properties_parseVec3 @ 00a21318 === */

/* lua_cocos2dx_Properties_parseVec3(lua_State*) */

void lua_cocos2dx_Properties_parseVec3(lua_State *param_1)

{
  bool bVar1;
  char *pcVar2;
  char cVar3;
  char cVar4;
  undefined1 uVar5;
  int iVar6;
  int *piVar7;
  undefined8 uVar8;
  Vec3 *local_18;
  char *local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  iVar6 = lua_gettop();
  if (iVar6 + -1 == 2) {
    local_10 = PTR_DAT_017191c0 + 0x18;
    cVar3 = luaval_to_std_string(param_1,2,(string *)&local_10,"cc.Properties:parseVec3");
    pcVar2 = local_10;
    cVar4 = FUN_00a07524(param_1,&local_18);
    if ((cVar4 == '\0') || (cVar3 == '\0')) {
      tolua_error(param_1,"invalid arguments in function \'lua_cocos2dx_Properties_parseVec3\'",0);
      uVar8 = 0;
    }
    else {
      uVar5 = cocos2d::Properties::parseVec3(pcVar2,local_18);
      tolua_pushboolean(param_1,uVar5);
      uVar8 = 1;
    }
    if (local_10 + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar6 + -1;
      }
      else {
        piVar7 = (int *)(local_10 + -8);
        do {
          iVar6 = *piVar7;
          cVar3 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar7,0x10);
          if (bVar1) {
            *piVar7 = iVar6 + -1;
            cVar3 = ExclusiveMonitorsStatus();
          }
        } while (cVar3 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete(local_10 + -0x18);
      }
    }
  }
  else {
    uVar8 = 0;
    luaL_error(param_1,&DAT_012cb120,"cc.Properties:parseVec3",iVar6 + -1,2);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar8);
}


/* === getVec3 @ 00f9fb0c === */

/* cocos2d::Properties::getVec3(char const*, cocos2d::Vec3*) const */

void __thiscall cocos2d::Properties::getVec3(Properties *this,char *param_1,Vec3 *param_2)

{
  char *pcVar1;
  
  pcVar1 = (char *)getString(this,param_1,(char *)0x0);
  parseVec3(pcVar1,param_2);
  return;
}


/* === lua_cocos2dx_Properties_parseVec4 @ 00a1bd34 === */

/* lua_cocos2dx_Properties_parseVec4(lua_State*) */

void lua_cocos2dx_Properties_parseVec4(lua_State *param_1)

{
  bool bVar1;
  char *pcVar2;
  char cVar3;
  char cVar4;
  undefined1 uVar5;
  int iVar6;
  int *piVar7;
  undefined8 uVar8;
  Vec4 *local_18;
  char *local_10;
  long local_8;
  
                    /* try { // try from 00a1bd3c to 00b1bd3f has its CatchHandler @ 00a1c3d8 */
                    /* try { // try from 00a1bd54 to 00b1bd57 has its CatchHandler @ 00a1c42c */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  iVar6 = lua_gettop();
  if (iVar6 + -1 == 2) {
                    /* try { // try from 00a1bdc8 to 00b1bdcb has its CatchHandler @ 00a1c448 */
    local_10 = PTR_DAT_017191c0 + 0x18;
    cVar3 = luaval_to_std_string(param_1,2,(string *)&local_10,"cc.Properties:parseVec4");
    pcVar2 = local_10;
    cVar4 = FUN_00a01bdc(param_1,&local_18);
    if ((cVar4 == '\0') || (cVar3 == '\0')) {
      tolua_error(param_1,"invalid arguments in function \'lua_cocos2dx_Properties_parseVec4\'",0);
      uVar8 = 0;
    }
    else {
      uVar5 = cocos2d::Properties::parseVec4(pcVar2,local_18);
      tolua_pushboolean(param_1,uVar5);
      uVar8 = 1;
    }
    if (local_10 + -0x18 != PTR_DAT_017191c0) {
                    /* try { // try from 00a1be34 to 00b1be37 has its CatchHandler @ 00a1c3f8 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar6 + -1;
      }
      else {
        piVar7 = (int *)(local_10 + -8);
        do {
          iVar6 = *piVar7;
          cVar3 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar7,0x10);
          if (bVar1) {
            *piVar7 = iVar6 + -1;
            cVar3 = ExclusiveMonitorsStatus();
          }
        } while (cVar3 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete(local_10 + -0x18);
      }
    }
  }
  else {
    uVar8 = 0;
                    /* try { // try from 00a1bd88 to 00b1bd8b has its CatchHandler @ 00a1c440 */
    luaL_error(param_1,&DAT_012cb120,"cc.Properties:parseVec4",iVar6 + -1,2);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 00a1bdb0 to 00b1bdb3 has its CatchHandler @ 00a1c454 */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar8);
}


/* === getVec4 @ 00f9fbec === */

/* cocos2d::Properties::getVec4(char const*, cocos2d::Vec4*) const */

void __thiscall cocos2d::Properties::getVec4(Properties *this,char *param_1,Vec4 *param_2)

{
  char *pcVar1;
  
  pcVar1 = (char *)getString(this,param_1,(char *)0x0);
  parseVec4(pcVar1,param_2);
  return;
}


/* === lua_cocos2dx_Properties_parseAxisAngle @ 00a1ceb8 === */

/* lua_cocos2dx_Properties_parseAxisAngle(lua_State*) */

void lua_cocos2dx_Properties_parseAxisAngle(lua_State *param_1)

{
  bool bVar1;
  char *pcVar2;
  char cVar3;
  char cVar4;
  undefined1 uVar5;
  int iVar6;
  int *piVar7;
  undefined8 uVar8;
  Quaternion *local_18;
  char *local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  iVar6 = lua_gettop();
  if (iVar6 + -1 == 2) {
                    /* try { // try from 00a1cf4c to 00b1cf57 has its CatchHandler @ 00a1d438 */
    local_10 = PTR_DAT_017191c0 + 0x18;
                    /* try { // try from 00a1cf60 to 00b1cf9b has its CatchHandler @ 00a1d404 */
    cVar3 = luaval_to_std_string(param_1,2,(string *)&local_10,"cc.Properties:parseAxisAngle");
    pcVar2 = local_10;
    cVar4 = FUN_00a075ac(param_1,&local_18);
    if ((cVar4 == '\0') || (cVar3 == '\0')) {
      tolua_error(param_1,"invalid arguments in function \'lua_cocos2dx_Properties_parseAxisAngle\'"
                  ,0);
      uVar8 = 0;
    }
    else {
      uVar5 = cocos2d::Properties::parseAxisAngle(pcVar2,local_18);
      tolua_pushboolean(param_1,uVar5);
      uVar8 = 1;
    }
    if (local_10 + -0x18 != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar6 = *(int *)(local_10 + -8);
        *(int *)(local_10 + -8) = iVar6 + -1;
      }
      else {
        piVar7 = (int *)(local_10 + -8);
        do {
          iVar6 = *piVar7;
          cVar3 = '\x01';
          bVar1 = (bool)ExclusiveMonitorPass(piVar7,0x10);
          if (bVar1) {
            *piVar7 = iVar6 + -1;
            cVar3 = ExclusiveMonitorsStatus();
          }
        } while (cVar3 != '\0');
      }
      if (iVar6 < 1) {
        operator_delete(local_10 + -0x18);
      }
    }
  }
  else {
    uVar8 = 0;
    luaL_error(param_1,&DAT_012cb120,"cc.Properties:parseAxisAngle",iVar6 + -1,2);
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(uVar8);
}


/* === getQuaternionFromAxisAngle @ 00f9fd0c === */

/* cocos2d::Properties::getQuaternionFromAxisAngle(char const*, cocos2d::Quaternion*) const */

void __thiscall
cocos2d::Properties::getQuaternionFromAxisAngle(Properties *this,char *param_1,Quaternion *param_2)

{
  char *pcVar1;
  
  pcVar1 = (char *)getString(this,param_1,(char *)0x0);
  parseAxisAngle(pcVar1,param_2);
  return;
}


/* === lua_cocos2dx_Properties_parseColor @ 00a2103c === */

/* lua_cocos2dx_Properties_parseColor(lua_State*) */

void lua_cocos2dx_Properties_parseColor(lua_State *param_1)

{
  bool bVar1;
  char *pcVar2;
  char cVar3;
  undefined1 uVar4;
  int iVar5;
  undefined8 uVar6;
  int iVar7;
  int *piVar8;
  undefined1 auStack_20 [8];
  char *local_18;
  Vec3 *local_10;
  long local_8;
  
                    /* catch() { ... } // from try @ 00a20f64 with catch @ 00a2103c */
                    /* catch() { ... } // from try @ 00a20eec with catch @ 00a21064 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  iVar5 = lua_gettop();
  if (iVar5 + -1 == 2) {
    local_18 = PTR_DAT_017191c0 + 0x18;
    cVar3 = luaval_to_std_string(param_1,2,(string *)&local_18,"cc.Properties:parseColor");
    pcVar2 = local_18;
    if ((cVar3 == '\0') || (cVar3 = FUN_00a01bdc(param_1,&local_10), cVar3 == '\0')) {
      if (local_18 + -0x18 != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar7 = *(int *)(local_18 + -8);
          *(int *)(local_18 + -8) = iVar7 + -1;
        }
        else {
          piVar8 = (int *)(local_18 + -8);
          do {
            iVar7 = *piVar8;
            cVar3 = '\x01';
            bVar1 = (bool)ExclusiveMonitorPass(piVar8,0x10);
            if (bVar1) {
              *piVar8 = iVar7 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar7 < 1) {
          operator_delete(local_18 + -0x18);
        }
      }
      local_18 = PTR_DAT_017191c0 + 0x18;
      cVar3 = luaval_to_std_string(param_1,2,(string *)&local_18,"cc.Properties:parseColor");
      pcVar2 = local_18;
      if ((cVar3 == '\0') || (cVar3 = FUN_00a07524(param_1,&local_10), cVar3 == '\0')) {
        if (local_18 + -0x18 != PTR_DAT_017191c0) {
          if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
            iVar7 = *(int *)(local_18 + -8);
            *(int *)(local_18 + -8) = iVar7 + -1;
          }
          else {
            piVar8 = (int *)(local_18 + -8);
            do {
              iVar7 = *piVar8;
              cVar3 = '\x01';
              bVar1 = (bool)ExclusiveMonitorPass(piVar8,0x10);
              if (bVar1) {
                *piVar8 = iVar7 + -1;
                cVar3 = ExclusiveMonitorsStatus();
              }
            } while (cVar3 != '\0');
          }
          if (iVar7 < 1) {
            operator_delete(local_18 + -0x18);
          }
        }
        goto LAB_00a2107c;
      }
      uVar4 = cocos2d::Properties::parseColor(pcVar2,local_10);
      tolua_pushboolean(param_1,uVar4);
      if (local_18 + -0x18 != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar5 = *(int *)(local_18 + -8);
          *(int *)(local_18 + -8) = iVar5 + -1;
        }
        else {
          piVar8 = (int *)(local_18 + -8);
          do {
            iVar5 = *piVar8;
            cVar3 = '\x01';
            bVar1 = (bool)ExclusiveMonitorPass(piVar8,0x10);
            if (bVar1) {
              *piVar8 = iVar5 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar5 < 1) {
          operator_delete(local_18 + -0x18);
          uVar6 = 1;
          goto LAB_00a2109c;
        }
      }
    }
    else {
      uVar4 = cocos2d::Properties::parseColor(pcVar2,(Vec4 *)local_10);
      tolua_pushboolean(param_1,uVar4);
      if (local_18 + -0x18 != PTR_DAT_017191c0) {
        FUN_009f861c(local_18 + -0x18,auStack_20);
        uVar6 = 1;
        goto LAB_00a2109c;
      }
    }
    uVar6 = 1;
  }
  else {
LAB_00a2107c:
    luaL_error(param_1,"%s has wrong number of arguments: %d, was expecting %d",
               "cc.Properties:parseColor",iVar5 + -1,2);
    uVar6 = 0;
  }
LAB_00a2109c:
                    /* catch() { ... } // from try @ 00a20ec0 with catch @ 00a210a4 */
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(uVar6);
  }
  return;
}


/* === getColor @ 00f9fe18 === */

/* cocos2d::Properties::getColor(char const*, cocos2d::Vec3*) const */

void __thiscall cocos2d::Properties::getColor(Properties *this,char *param_1,Vec3 *param_2)

{
  char *pcVar1;
  
  pcVar1 = (char *)getString(this,param_1,(char *)0x0);
  parseColor(pcVar1,param_2);
  return;
}


/* === getColor @ 00f9ff34 === */

/* cocos2d::Properties::getColor(char const*, cocos2d::Vec4*) const */

void __thiscall cocos2d::Properties::getColor(Properties *this,char *param_1,Vec4 *param_2)

{
  char *pcVar1;
  
  pcVar1 = (char *)getString(this,param_1,(char *)0x0);
  parseColor(pcVar1,param_2);
  return;
}


/* === link @ 00fc5c5c === */

/* cocos2d::GLProgram::link() */

void __thiscall cocos2d::GLProgram::link(GLProgram *this)

{
  int iVar1;
  int local_c;
  long local_8;
  
  local_c = 1;
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  bindPredefinedVertexAttribs(this);
  glLinkProgram(*(undefined4 *)(this + 0x24));
  glGetProgramiv(*(undefined4 *)(this + 0x24),0x8b82,&local_c);
  if (local_c == 0) {
    GL::deleteProgram(*(uint *)(this + 0x24));
    *(undefined4 *)(this + 0x24) = 0;
  }
  else {
    parseVertexAttribs(this);
    parseUniforms(this);
    if (*(int *)(this + 0x28) == 0) {
      iVar1 = *(int *)(this + 0x2c);
    }
    else {
      glDeleteShader();
      iVar1 = *(int *)(this + 0x2c);
    }
    if (iVar1 != 0) {
      glDeleteShader();
    }
    *(undefined4 *)(this + 0x2c) = 0;
    *(undefined4 *)(this + 0x28) = 0;
  }
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(local_c == 1);
}


/* === parseShader @ 00fd123c === */

/* cocos2d::Material::parseShader(cocos2d::Pass*, cocos2d::Properties*) */

void __thiscall cocos2d::Material::parseShader(Material *this,Pass *param_1,Properties *param_2)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  long lVar4;
  long lVar5;
  undefined1 *puVar6;
  GLProgramState *pGVar7;
  char *pcVar8;
  Properties *this_00;
  undefined8 uVar9;
  int *piVar10;
  undefined1 auStack_40 [8];
  undefined1 auStack_38 [8];
  undefined1 auStack_30 [16];
  long local_20;
  long local_18;
  long local_10;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  lVar4 = Properties::getString(param_2,"vertexShader",(char *)0x0);
  lVar5 = Properties::getString(param_2,"fragmentShader",(char *)0x0);
  puVar6 = (undefined1 *)Properties::getString(param_2,"defines",(char *)0x0);
  if (puVar6 == (undefined1 *)0x0) {
    puVar6 = &DAT_012fc3d8;
  }
  if ((lVar5 != 0) && (lVar4 != 0)) {
    FUN_01211570((string *)&local_20,lVar4,auStack_40);
    FUN_01211570((string *)&local_18,lVar5,auStack_38);
    FUN_01211570((string *)&local_10,puVar6,auStack_30);
    pGVar7 = (GLProgramState *)
             GLProgramState::getOrCreateWithShaders
                       ((string *)&local_20,(string *)&local_18,(string *)&local_10);
    if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_10 + -8);
                    /* catch() { ... } // from try @ 00fd1460 with catch @ 00fd1528 */
        *(int *)(local_10 + -8) = iVar3 + -1;
                    /* catch() { ... } // from try @ 00fd15a0 with catch @ 00fd1530 */
      }
      else {
        piVar10 = (int *)(local_10 + -8);
        do {
          iVar3 = *piVar10;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar10,0x10);
          if (bVar2) {
            *piVar10 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
        operator_delete((undefined *)(local_10 + -0x18));
      }
    }
    if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_18 + -8);
        *(int *)(local_18 + -8) = iVar3 + -1;
      }
      else {
        piVar10 = (int *)(local_18 + -8);
        do {
          iVar3 = *piVar10;
                    /* catch() { ... } // from try @ 00fd1494 with catch @ 00fd14f4 */
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar10,0x10);
          if (bVar2) {
            *piVar10 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
        operator_delete((undefined *)(local_18 + -0x18));
      }
    }
    if ((undefined *)(local_20 + -0x18) != PTR_DAT_017191c0) {
                    /* try { // try from 00fd1478 to 010d148f has its CatchHandler @ 00fd1520 */
      if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
        iVar3 = *(int *)(local_20 + -8);
        *(int *)(local_20 + -8) = iVar3 + -1;
                    /* catch() { ... } // from try @ 00fd1478 with catch @ 00fd1520 */
      }
      else {
        piVar10 = (int *)(local_20 + -8);
        do {
          iVar3 = *piVar10;
          cVar1 = '\x01';
          bVar2 = (bool)ExclusiveMonitorPass(piVar10,0x10);
          if (bVar2) {
            *piVar10 = iVar3 + -1;
            cVar1 = ExclusiveMonitorsStatus();
          }
                    /* try { // try from 00fd1494 to 010d1497 has its CatchHandler @ 00fd14f4 */
        } while (cVar1 != '\0');
      }
      if (iVar3 < 1) {
                    /* try { // try from 00fd14a4 to 010d151f has its CatchHandler @ 00fd1438 */
        operator_delete((undefined *)(local_20 + -0x18));
      }
    }
    Pass::setGLProgramState(param_1,pGVar7);
    pcVar8 = (char *)Properties::getNextProperty(param_2);
    while (pcVar8 != (char *)0x0) {
      iVar3 = strcmp(pcVar8,"defines");
      if (((iVar3 != 0) && (iVar3 = strcmp(pcVar8,"vertexShader"), iVar3 != 0)) &&
         (iVar3 = strcmp(pcVar8,"fragmentShader"), iVar3 != 0)) {
        parseUniform(this,pGVar7,param_2,pcVar8);
      }
      pcVar8 = (char *)Properties::getNextProperty(param_2);
    }
    this_00 = (Properties *)Properties::getNextNamespace(param_2);
    while (this_00 != (Properties *)0x0) {
      while( true ) {
        uVar9 = Properties::getNamespace(this_00);
        iVar3 = strcmp(uVar9,"sampler");
        if (iVar3 != 0) break;
        parseSampler(this,pGVar7,this_00);
        this_00 = (Properties *)Properties::getNextNamespace(param_2);
        if (this_00 == (Properties *)0x0) goto LAB_00fd1438;
      }
      this_00 = (Properties *)Properties::getNextNamespace(param_2);
    }
  }
LAB_00fd1438:
                    /* catch() { ... } // from try @ 00fd14a4 with catch @ 00fd1438 */
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 00fd1460 to 010d1463 has its CatchHandler @ 00fd1528 */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(1);
}


/* === parsePass @ 00fd17cc === */

/* cocos2d::Material::parsePass(cocos2d::Technique*, cocos2d::Properties*) */

undefined8 __thiscall
cocos2d::Material::parsePass(Material *this,Technique *param_1,Properties *param_2)

{
  int iVar1;
  Pass *pPVar2;
  Properties *this_00;
  undefined8 uVar3;
  
                    /* catch() { ... } // from try @ 00fd1730 with catch @ 00fd17d4 */
                    /* try { // try from 00fd17f4 to 010d17f7 has its CatchHandler @ 00fd1634 */
  pPVar2 = (Pass *)Pass::create(param_1);
                    /* catch() { ... } // from try @ 00fd1688 with catch @ 00fd17f8 */
  Technique::addPass(param_1,pPVar2);
  this_00 = (Properties *)Properties::getNextNamespace(param_2);
  do {
    if (this_00 == (Properties *)0x0) {
      return 1;
    }
    while( true ) {
      uVar3 = Properties::getNamespace(this_00);
      iVar1 = strcmp(uVar3,"shader");
      if (iVar1 != 0) break;
      parseShader(this,pPVar2,this_00);
      this_00 = (Properties *)Properties::getNextNamespace(param_2);
      if (this_00 == (Properties *)0x0) {
        return 1;
      }
    }
    iVar1 = strcmp(uVar3,"renderState");
    if (iVar1 != 0) {
      return 0;
    }
    parseRenderState(this,(RenderState *)pPVar2,this_00);
    this_00 = (Properties *)Properties::getNextNamespace(param_2);
  } while( true );
}


/* === parseProperties @ 00fd2008 === */

/* cocos2d::Material::parseProperties(cocos2d::Properties*) */

void __thiscall cocos2d::Material::parseProperties(Material *this,Properties *param_1)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  undefined8 uVar4;
  Properties *this_00;
  int *piVar5;
  undefined1 auStack_20 [16];
  long local_10;
  long local_8;
  
                    /* try { // try from 00fd2014 to 010d2017 has its CatchHandler @ 00fd221c */
                    /* try { // try from 00fd2034 to 010d2037 has its CatchHandler @ 00fd223c */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  uVar4 = Properties::getId(param_1);
  FUN_01211570(&local_10,uVar4,auStack_20);
  setName((string *)this);
  if ((undefined *)(local_10 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_10 + -8);
      *(int *)(local_10 + -8) = iVar3 + -1;
    }
    else {
      piVar5 = (int *)(local_10 + -8);
      do {
        iVar3 = *piVar5;
                    /* try { // try from 00fd2148 to 010d214b has its CatchHandler @ 00fd2270 */
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar2) {
          *piVar5 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete((undefined *)(local_10 + -0x18));
    }
  }
  this_00 = (Properties *)Properties::getNextNamespace(param_1);
  while (this_00 != (Properties *)0x0) {
    while( true ) {
      uVar4 = Properties::getNamespace(this_00);
      iVar3 = strcmp(uVar4,"technique");
      if (iVar3 != 0) break;
      parseTechnique(this,this_00);
      this_00 = (Properties *)Properties::getNextNamespace(param_1);
      if (this_00 == (Properties *)0x0) goto LAB_00fd20f0;
    }
    iVar3 = strcmp(uVar4,"renderState");
    if (iVar3 == 0) {
                    /* try { // try from 00fd2128 to 010d212b has its CatchHandler @ 00fd2250 */
      parseRenderState(this,(RenderState *)this,this_00);
    }
                    /* try { // try from 00fd20ac to 010d20f7 has its CatchHandler @ 00fd1e08 */
    this_00 = (Properties *)Properties::getNextNamespace(param_1);
  }
LAB_00fd20f0:
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
                    /* try { // try from 00fd2114 to 010d2117 has its CatchHandler @ 00fd224c */
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(1);
}


/* === parseTechnique @ 00fd1dfc === */

/* cocos2d::Material::parseTechnique(cocos2d::Properties*) */

void __thiscall cocos2d::Material::parseTechnique(Material *this,Properties *param_1)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  string *psVar4;
  undefined8 uVar5;
  Properties *this_00;
  undefined8 *puVar6;
  long lVar7;
  int *piVar8;
  undefined1 auStack_28 [16];
  long local_18;
  Ref *local_10;
  long local_8;
  
                    /* catch() { ... } // from try @ 00fd1eac with catch @ 00fd1e08
                       catch() { ... } // from try @ 00fd1f98 with catch @ 00fd1e08
                       catch() { ... } // from try @ 00fd20ac with catch @ 00fd1e08
                       catch() { ... } // from try @ 00fd21c0 with catch @ 00fd1e08 */
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  psVar4 = (string *)Technique::create(this);
  puVar6 = *(undefined8 **)(this + 0x60);
  local_10 = (Ref *)psVar4;
  if (puVar6 == *(undefined8 **)(this + 0x68)) {
    std::vector<cocos2d::Technique*,std::allocator<cocos2d::Technique*>>::
    _M_emplace_back_aux<cocos2d::Technique*const&>
              ((vector<cocos2d::Technique*,std::allocator<cocos2d::Technique*>> *)(this + 0x58),
               (Technique **)&local_10);
  }
  else {
    if (puVar6 == (undefined8 *)0x0) {
      lVar7 = 0;
    }
    else {
      *puVar6 = psVar4;
      lVar7 = *(long *)(this + 0x60);
    }
    *(long *)(this + 0x60) = lVar7 + 8;
  }
  cocos2d::Ref::retain(local_10);
  if (*(long *)(this + 0x70) == 0) {
    *(string **)(this + 0x70) = psVar4;
  }
  uVar5 = Properties::getId(param_1);
  FUN_01211570(&local_18,uVar5,auStack_28);
  Technique::setName(psVar4);
                    /* try { // try from 00fd1eac to 010d1ecf has its CatchHandler @ 00fd1e08 */
  if ((undefined *)(local_18 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(local_18 + -8);
      *(int *)(local_18 + -8) = iVar3 + -1;
    }
    else {
      piVar8 = (int *)(local_18 + -8);
      do {
        iVar3 = *piVar8;
                    /* try { // try from 00fd1f98 to 010d1fe3 has its CatchHandler @ 00fd1e08 */
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
    }
  }
  this_00 = (Properties *)Properties::getNextNamespace(param_1);
  while (this_00 != (Properties *)0x0) {
    while( true ) {
      uVar5 = Properties::getNamespace(this_00);
                    /* try { // try from 00fd1f00 to 010d1f03 has its CatchHandler @ 00fd21e0 */
      iVar3 = strcmp(uVar5,&DAT_0134b3c0);
      if (iVar3 != 0) break;
      parsePass(this,(Technique *)psVar4,this_00);
                    /* try { // try from 00fd1f20 to 010d1f23 has its CatchHandler @ 00fd2208 */
      this_00 = (Properties *)Properties::getNextNamespace(param_1);
      if (this_00 == (Properties *)0x0) goto LAB_00fd1f2c;
    }
    iVar3 = strcmp(uVar5,"renderState");
    if (iVar3 == 0) {
      parseRenderState(this,(RenderState *)this,this_00);
    }
    this_00 = (Properties *)Properties::getNextNamespace(param_1);
                    /* try { // try from 00fd1eec to 010d1eef has its CatchHandler @ 00fd21cc */
  }
LAB_00fd1f2c:
  if (local_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(1);
}


/* === initWithFile @ 00fd21a8 === */

/* cocos2d::Material::initWithFile(std::string const&) */

undefined8 __thiscall cocos2d::Material::initWithFile(Material *this,string *param_1)

{
  Properties *this_00;
  char *pcVar1;
  Properties *pPVar2;
  
  this_00 = (Properties *)Properties::createNonRefCounted(param_1);
                    /* try { // try from 00fd21c0 to 010d21df has its CatchHandler @ 00fd1e08 */
  pcVar1 = (char *)Properties::getNamespace(this_00);
                    /* catch() { ... } // from try @ 00fd1eec with catch @ 00fd21cc */
  pPVar2 = this_00;
  if (*pcVar1 == '\0') {
    pPVar2 = (Properties *)Properties::getNextNamespace(this_00);
                    /* catch() { ... } // from try @ 00fd1f20 with catch @ 00fd2208 */
  }
  parseProperties(this,pPVar2);
  if (this_00 != (Properties *)0x0) {
                    /* catch() { ... } // from try @ 00fd1f00 with catch @ 00fd21e0 */
    Properties::~Properties(this_00);
    operator_delete(this_00);
  }
  return 1;
}


/* === initWithProperties @ 00fd2380 === */

/* cocos2d::Material::initWithProperties(cocos2d::Properties*) */

void __thiscall cocos2d::Material::initWithProperties(Material *this,Properties *param_1)

{
  char cVar1;
  bool bVar2;
  int iVar3;
  undefined8 uVar4;
  Properties *this_00;
  int *piVar5;
  undefined1 auStack_20 [16];
  long lStack_10;
  long lStack_8;
  
  lStack_8 = *(long *)PTR___stack_chk_guard_01721c30;
  uVar4 = Properties::getId(param_1);
  FUN_01211570(&lStack_10,uVar4,auStack_20);
  setName((string *)this);
  if ((undefined *)(lStack_10 + -0x18) != PTR_DAT_017191c0) {
    if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
      iVar3 = *(int *)(lStack_10 + -8);
      *(int *)(lStack_10 + -8) = iVar3 + -1;
    }
    else {
      piVar5 = (int *)(lStack_10 + -8);
      do {
        iVar3 = *piVar5;
        cVar1 = '\x01';
        bVar2 = (bool)ExclusiveMonitorPass(piVar5,0x10);
        if (bVar2) {
          *piVar5 = iVar3 + -1;
          cVar1 = ExclusiveMonitorsStatus();
        }
      } while (cVar1 != '\0');
    }
    if (iVar3 < 1) {
      operator_delete((undefined *)(lStack_10 + -0x18));
    }
  }
  this_00 = (Properties *)Properties::getNextNamespace(param_1);
  while (this_00 != (Properties *)0x0) {
    while( true ) {
      uVar4 = Properties::getNamespace(this_00);
      iVar3 = strcmp(uVar4,"technique");
      if (iVar3 != 0) break;
      parseTechnique(this,this_00);
      this_00 = (Properties *)Properties::getNextNamespace(param_1);
      if (this_00 == (Properties *)0x0) goto LAB_00fd20f0;
    }
    iVar3 = strcmp(uVar4,"renderState");
    if (iVar3 == 0) {
      parseRenderState(this,(RenderState *)this,this_00);
    }
    this_00 = (Properties *)Properties::getNextNamespace(param_1);
  }
LAB_00fd20f0:
  if (lStack_8 == *(long *)PTR___stack_chk_guard_01721c30) {
    return;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail(1);
}


/* === addImage @ 00fe4c1c === */

/* cocos2d::TextureCache::addImage(std::string const&) */

void __thiscall cocos2d::TextureCache::addImage(TextureCache *this,string *param_1)

{
  bool bVar1;
  ulong uVar2;
  char cVar3;
  long *plVar4;
  ulong uVar5;
  int *piVar6;
  Image *this_00;
  Texture2D *pTVar7;
  int iVar8;
  ulong uVar9;
  undefined *puVar10;
  undefined1 auStack_188 [8];
  Texture2D *local_180;
  long local_178;
  long local_170;
  Image aIStack_168 [352];
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  local_180 = (Texture2D *)0x0;
  plVar4 = (long *)FileUtils::getInstance();
  (**(code **)(*plVar4 + 0x50))((string *)&local_178,plVar4,param_1);
  if (*(long *)(local_178 + -0x18) == 0) {
                    /* catch() { ... } // from try @ 00fe4b38 with catch @ 00fe4d14 */
    puVar10 = (undefined *)(local_178 + -0x18);
                    /* catch() { ... } // from try @ 00fe4b84 with catch @ 00fe4d1c */
    pTVar7 = (Texture2D *)0x0;
                    /* catch() { ... } // from try @ 00fe4b78 with catch @ 00fe4d28 */
    if (puVar10 == PTR_DAT_017191c0) goto LAB_00fe4ce0;
  }
  else {
    uVar5 = FUN_011c78ec(local_178,*(long *)(local_178 + -0x18),0xc70f6907);
    uVar9 = *(ulong *)(this + 0x1b0);
    uVar2 = 0;
    if (uVar9 != 0) {
      uVar2 = uVar5 / uVar9;
    }
    plVar4 = (long *)std::
                     _Hashtable<std::string,std::pair<std::string_const,cocos2d::Texture2D*>,std::allocator<std::pair<std::string_const,cocos2d::Texture2D*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                     ::_M_find_before_node
                               ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Texture2D*>,std::allocator<std::pair<std::string_const,cocos2d::Texture2D*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                                 *)(this + 0x1a8),uVar5 - uVar2 * uVar9,(string *)&local_178,uVar5);
    if ((plVar4 != (long *)0x0) && (*plVar4 != 0)) {
      local_180 = *(Texture2D **)(*plVar4 + 0x10);
                    /* catch() { ... } // from try @ 00fe4b90 with catch @ 00fe4cc0 */
    }
    if ((local_180 == (Texture2D *)0x0) &&
       (this_00 = operator_new(0x160,(nothrow_t *)PTR_nothrow_01717628), this_00 != (Image *)0x0)) {
      Image::Image(this_00);
      cVar3 = Image::initWithImageFile(this_00,(string *)&local_178);
      if (cVar3 != '\0') {
        pTVar7 = operator_new(0x78,(nothrow_t *)PTR_nothrow_01717628);
        if (pTVar7 != (Texture2D *)0x0) {
          Texture2D::Texture2D(pTVar7);
          local_180 = pTVar7;
          cVar3 = Texture2D::initWithImage(pTVar7,this_00);
          if (cVar3 != '\0') {
            VolatileTextureMgr::addImageTexture(local_180,(string *)&local_178);
            std::
            _Hashtable<std::string,std::pair<std::string_const,cocos2d::Texture2D*>,std::allocator<std::pair<std::string_const,cocos2d::Texture2D*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
            ::_M_emplace<std::string&,cocos2d::Texture2D*&>
                      ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Texture2D*>,std::allocator<std::pair<std::string_const,cocos2d::Texture2D*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                        *)(this + 0x1a8),0,(string *)&local_178,&local_180);
            FUN_01214ee0((string *)&local_170,param_1);
            FUN_01211fcc((string *)&local_170,PTR_s_etc1AlphaFileSuffix_01716c88);
            if ((*(int *)(this_00 + 0x44) == 5) &&
               (*(long *)(*(long *)PTR_s_etc1AlphaFileSuffix_01716c88 + -0x18) != 0)) {
              plVar4 = (long *)FileUtils::getInstance();
              cVar3 = (**(code **)(*plVar4 + 0x128))(plVar4,(string *)&local_170);
              if (cVar3 != '\0') {
                Image::Image(aIStack_168);
                cVar3 = Image::initWithImageFile(aIStack_168,(string *)&local_170);
                if ((cVar3 != '\0') &&
                   (pTVar7 = operator_new(0x78,(nothrow_t *)PTR_nothrow_01717628),
                   pTVar7 != (Texture2D *)0x0)) {
                  Texture2D::Texture2D(pTVar7);
                  cVar3 = Texture2D::initWithImage(pTVar7,aIStack_168);
                  if (cVar3 == '\0') {
                    if (pTVar7 == (Texture2D *)0x0) goto LAB_00fe4f24;
                  }
                  else {
                    Texture2D::setAlphaTexture(local_180,pTVar7);
                  }
                  cocos2d::Ref::release((Ref *)pTVar7);
                }
LAB_00fe4f24:
                    /* catch() { ... } // from try @ 00fe4f64 with catch @ 00fe4f24
                       catch() { ... } // from try @ 00fe5008 with catch @ 00fe4f24
                       catch() { ... } // from try @ 00fe5064 with catch @ 00fe4f24 */
                Image::~Image(aIStack_168);
              }
            }
            parseNinePatchImage(this,this_00,local_180,param_1);
            if ((undefined *)(local_170 + -0x18) != PTR_DAT_017191c0) {
              FUN_006c4c00((undefined *)(local_170 + -0x18),auStack_188);
            }
            goto LAB_00fe4d98;
          }
          if (local_180 != (Texture2D *)0x0) {
            cocos2d::Ref::release((Ref *)local_180);
          }
        }
        local_180 = (Texture2D *)0x0;
      }
LAB_00fe4d98:
      cocos2d::Ref::release((Ref *)this_00);
    }
    puVar10 = (undefined *)(local_178 + -0x18);
    pTVar7 = local_180;
    if (puVar10 == PTR_DAT_017191c0) goto LAB_00fe4ce0;
  }
                    /* catch() { ... } // from try @ 00fe4b6c with catch @ 00fe4d34 */
  if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
    iVar8 = *(int *)(local_178 + -8);
    *(int *)(local_178 + -8) = iVar8 + -1;
  }
  else {
    piVar6 = (int *)(local_178 + -8);
    do {
                    /* catch() { ... } // from try @ 00fe4b60 with catch @ 00fe4d3c */
      iVar8 = *piVar6;
      cVar3 = '\x01';
      bVar1 = (bool)ExclusiveMonitorPass(piVar6,0x10);
      if (bVar1) {
        *piVar6 = iVar8 + -1;
        cVar3 = ExclusiveMonitorsStatus();
      }
    } while (cVar3 != '\0');
  }
  if (iVar8 < 1) {
    operator_delete(puVar10);
  }
LAB_00fe4ce0:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(pTVar7);
  }
                    /* try { // try from 00fe4d04 to 010e4d07 has its CatchHandler @ 00fe4740 */
                    /* catch() { ... } // from try @ 00fe4b4c with catch @ 00fe4d0c */
  return;
}


/* === addImageAsyncCallBack @ 00fe47f8 === */

/* cocos2d::TextureCache::addImageAsyncCallBack(float) */

void cocos2d::TextureCache::addImageAsyncCallBack(float param_1)

{
  string *psVar1;
  bool bVar2;
  char cVar3;
  int iVar4;
  TextureCache *in_x0;
  long *plVar5;
  long lVar6;
  Texture2D *pTVar7;
  int *piVar8;
  string *psVar9;
  Ref *local_10;
  long local_8;
  
  local_10 = (Ref *)0x0;
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (PTR_pthread_create_017196e0 == (undefined *)0x0) goto LAB_00fe49a8;
  do {
    iVar4 = pthread_mutex_lock(in_x0 + 0x148);
    if (iVar4 != 0) {
                    /* WARNING: Subroutine does not return */
      FUN_0120f9b8();
    }
    plVar5 = *(long **)(in_x0 + 0xe0);
    if (*(long **)(in_x0 + 0x100) == plVar5) {
      psVar9 = (string *)0x0;
      goto LAB_00fe48ec;
    }
    while( true ) {
      psVar9 = (string *)*plVar5;
      if (plVar5 == (long *)(*(long *)(in_x0 + 0xf0) + -8)) {
        operator_delete(*(void **)(in_x0 + 0xe8));
        lVar6 = *(long *)(in_x0 + 0xf8);
        *(long *)(in_x0 + 0xf8) = lVar6 + 8;
        lVar6 = *(long *)(lVar6 + 8);
        *(long *)(in_x0 + 0xe8) = lVar6;
        *(long *)(in_x0 + 0xf0) = lVar6 + 0x200;
        *(long *)(in_x0 + 0xe0) = lVar6;
      }
      else {
        *(long **)(in_x0 + 0xe0) = plVar5 + 1;
      }
      plVar5 = *(long **)(in_x0 + 0x40);
      if (psVar9 != (string *)*plVar5) {
        __android_log_print(6,"cocos2d-x assert","%s function:%s line:%d",
                            "/Users/avalon/Documents/workspace/CaveOnline/Client/CaveOnline_Client/branches/branch_ver_2_8_x/client/frameworks/cocos2d-x/cocos/./renderer/CCTextureCache.cpp"
                            ,"addImageAsyncCallBack",0x14a);
        plVar5 = *(long **)(in_x0 + 0x40);
      }
      if (plVar5 == (long *)(*(long *)(in_x0 + 0x50) + -8)) {
        operator_delete(*(void **)(in_x0 + 0x48));
        lVar6 = *(long *)(in_x0 + 0x58);
        *(long *)(in_x0 + 0x58) = lVar6 + 8;
        lVar6 = *(long *)(lVar6 + 8);
        *(long *)(in_x0 + 0x48) = lVar6;
        *(long *)(in_x0 + 0x50) = lVar6 + 0x200;
        *(long *)(in_x0 + 0x40) = lVar6;
      }
      else {
        *(long **)(in_x0 + 0x40) = plVar5 + 1;
      }
      if (PTR_pthread_create_017196e0 != (undefined *)0x0) {
LAB_00fe48ec:
        pthread_mutex_unlock(in_x0 + 0x148);
      }
      if (psVar9 == (string *)0x0) goto LAB_00fe49b8;
      lVar6 = std::
              _Hashtable<std::string,std::pair<std::string_const,cocos2d::Texture2D*>,std::allocator<std::pair<std::string_const,cocos2d::Texture2D*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
              ::find((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Texture2D*>,std::allocator<std::pair<std::string_const,cocos2d::Texture2D*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                      *)(in_x0 + 0x1a8),psVar9);
      if (lVar6 == 0) {
        if (psVar9[0x2f4] == (string)0x0) {
          local_10 = (Ref *)0x0;
        }
        else {
          pTVar7 = operator_new(0x78,(nothrow_t *)PTR_nothrow_01717628);
          if (pTVar7 != (Texture2D *)0x0) {
            Texture2D::Texture2D(pTVar7);
          }
          local_10 = (Ref *)pTVar7;
          Texture2D::initWithImage(pTVar7,(Image *)(psVar9 + 0x30),*(undefined4 *)(psVar9 + 0x2f0));
          parseNinePatchImage(in_x0,(Image *)(psVar9 + 0x30),(Texture2D *)local_10,psVar9);
          VolatileTextureMgr::addImageTexture((Texture2D *)local_10,psVar9);
                    /* try { // try from 00fe4b38 to 010e4b3b has its CatchHandler @ 00fe4d14 */
          std::
          _Hashtable<std::string,std::pair<std::string_const,cocos2d::Texture2D*>,std::allocator<std::pair<std::string_const,cocos2d::Texture2D*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
          ::_M_emplace<std::string&,cocos2d::Texture2D*&>
                    ((_Hashtable<std::string,std::pair<std::string_const,cocos2d::Texture2D*>,std::allocator<std::pair<std::string_const,cocos2d::Texture2D*>>,std::__detail::_Select1st,std::equal_to<std::string>,std::hash<std::string>,std::__detail::_Mod_range_hashing,std::__detail::_Default_ranged_hash,std::__detail::_Prime_rehash_policy,std::__detail::_Hashtable_traits<true,false,true>>
                      *)(in_x0 + 0x1a8),0,psVar9,&local_10);
          cocos2d::Ref::retain(local_10);
                    /* try { // try from 00fe4b4c to 010e4b4f has its CatchHandler @ 00fe4d0c */
          cocos2d::Ref::autorelease(local_10);
                    /* try { // try from 00fe4b84 to 010e4b87 has its CatchHandler @ 00fe4d1c */
                    /* try { // try from 00fe4b90 to 010e4b93 has its CatchHandler @ 00fe4cc0 */
          if ((*(int *)(psVar9 + 0x1d4) == 5) &&
             (pTVar7 = operator_new(0x78,(nothrow_t *)PTR_nothrow_01717628),
             pTVar7 != (Texture2D *)0x0)) {
            Texture2D::Texture2D(pTVar7);
            cVar3 = Texture2D::initWithImage(pTVar7,psVar9 + 400,*(undefined4 *)(psVar9 + 0x2f0));
            if (cVar3 != '\0') {
              Texture2D::setAlphaTexture((Texture2D *)local_10,pTVar7);
            }
            cocos2d::Ref::release((Ref *)pTVar7);
          }
        }
      }
      else {
        local_10 = *(Ref **)(lVar6 + 0x10);
      }
      psVar1 = psVar9 + 8;
      if (*(long *)(psVar9 + 0x18) != 0) {
        (**(code **)(psVar9 + 0x20))(psVar1,local_10);
      }
      Image::~Image((Image *)(psVar9 + 400));
      Image::~Image((Image *)(psVar9 + 0x30));
      lVar6 = *(long *)(psVar9 + 0x28);
      if ((undefined *)(lVar6 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar4 = *(int *)(lVar6 + -8);
                    /* try { // try from 00fe4b78 to 010e4b7b has its CatchHandler @ 00fe4d28 */
          *(int *)(lVar6 + -8) = iVar4 + -1;
        }
        else {
          piVar8 = (int *)(lVar6 + -8);
          do {
            iVar4 = *piVar8;
            cVar3 = '\x01';
            bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
            if (bVar2) {
              *piVar8 = iVar4 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar4 < 1) {
          operator_delete((undefined *)(lVar6 + -0x18));
        }
      }
      if (*(code **)(psVar9 + 0x18) != (code *)0x0) {
        (**(code **)(psVar9 + 0x18))(psVar1,psVar1,3);
      }
      lVar6 = *(long *)psVar9;
      if ((undefined *)(lVar6 + -0x18) != PTR_DAT_017191c0) {
        if (PTR_pthread_create_017196e0 == (undefined *)0x0) {
          iVar4 = *(int *)(lVar6 + -8);
                    /* try { // try from 00fe4b6c to 010e4b6f has its CatchHandler @ 00fe4d34 */
          *(int *)(lVar6 + -8) = iVar4 + -1;
        }
        else {
          piVar8 = (int *)(lVar6 + -8);
          do {
            iVar4 = *piVar8;
            cVar3 = '\x01';
            bVar2 = (bool)ExclusiveMonitorPass(piVar8,0x10);
            if (bVar2) {
              *piVar8 = iVar4 + -1;
              cVar3 = ExclusiveMonitorsStatus();
            }
          } while (cVar3 != '\0');
        }
        if (iVar4 < 1) {
          operator_delete((undefined *)(lVar6 + -0x18));
        }
      }
      operator_delete(psVar9);
      *(int *)(in_x0 + 0x1a4) = *(int *)(in_x0 + 0x1a4) + -1;
      if (PTR_pthread_create_017196e0 != (undefined *)0x0) break;
LAB_00fe49a8:
      plVar5 = *(long **)(in_x0 + 0xe0);
      if (*(long **)(in_x0 + 0x100) == plVar5) {
LAB_00fe49b8:
        if (*(int *)(in_x0 + 0x1a4) == 0) {
          lVar6 = Director::getInstance();
          Scheduler::unschedule
                    (*(_func_void_float **)(lVar6 + 0x100),(Ref *)PTR_addImageAsyncCallBack_0171b640
                    );
        }
        if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
          __stack_chk_fail();
        }
        return;
      }
    }
  } while( true );
}


/* === init @ 00fe6a4c === */

/* cocos2d::VertexAttribBinding::init(cocos2d::MeshIndexData*, cocos2d::GLProgramState*) */

void __thiscall
cocos2d::VertexAttribBinding::init
          (VertexAttribBinding *this,MeshIndexData *param_1,GLProgramState *param_2)

{
  long lVar1;
  string *psVar2;
  int iVar3;
  int iVar4;
  uint uVar5;
  char cVar6;
  int iVar7;
  undefined4 uVar8;
  Configuration *this_00;
  uint uVar9;
  long lVar10;
  long *plVar11;
  void *pvVar12;
  uint uVar13;
  long lVar14;
  long lVar15;
  int local_c;
  long local_8;
  
  local_8 = *(long *)PTR___stack_chk_guard_01721c30;
  if (DAT_017d3708 == 0) {
    cVar6 = '\0';
    glGetIntegerv(0x8869,&local_c);
    DAT_017d3708 = local_c;
    if (local_c == 0) goto LAB_00fe6b70;
  }
  *(MeshIndexData **)(this + 0x28) = param_1;
  cocos2d::Ref::retain((Ref *)param_1);
  *(GLProgramState **)(this + 0x30) = param_2;
  cocos2d::Ref::retain((Ref *)param_2);
  lVar15 = *(long *)(param_1 + 0x30);
  lVar14 = *(long *)(lVar15 + 0x58) - *(long *)(lVar15 + 0x50);
  parseAttributes(this);
  if (0 < lVar14 >> 4) {
    lVar10 = 0;
    pvVar12 = (void *)0x0;
    do {
      lVar1 = *(long *)(lVar15 + 0x50) + lVar10;
      iVar4 = *(int *)(*(long *)(lVar15 + 0x50) + lVar10);
      lVar10 = lVar10 + 0x10;
      uVar13 = *(uint *)(lVar1 + 4);
      iVar3 = *(int *)(lVar1 + 0xc);
      psVar2 = (string *)(PTR_s_attributeNames_017166c8 + (long)*(int *)(lVar1 + 8) * 8);
      iVar7 = VertexBuffer::getSizePerVertex(*(VertexBuffer **)(lVar15 + 0x30));
      setVertexAttribPointer(this,psVar2,iVar4,uVar13,'\0',iVar7,pvVar12);
      pvVar12 = (void *)((long)pvVar12 + (long)iVar3);
    } while (lVar10 != lVar14);
  }
  this_00 = (Configuration *)Configuration::getInstance();
  cVar6 = Configuration::supportsShareableVAO(this_00);
  if (cVar6 == '\0') {
    cVar6 = '\x01';
  }
  else {
    uVar13 = 0;
    (**(code **)PTR_glGenVertexArraysOESEXT_0171a3e0)(1,this + 0x24);
    GL::bindVAO(*(uint *)(this + 0x24));
    uVar8 = VertexBuffer::getVBO(*(VertexBuffer **)(lVar15 + 0x30));
    glBindBuffer(0x8892,uVar8);
    for (uVar9 = *(uint *)(this + 0x70); uVar9 != 0; uVar9 = uVar9 & (uVar5 ^ 0xffffffff)) {
      while (uVar5 = 1 << (ulong)(uVar13 & 0x1f), (uVar5 & uVar9) != 0) {
        glEnableVertexAttribArray(uVar13);
        uVar9 = uVar9 & (uVar5 ^ 0xffffffff);
        uVar13 = uVar13 + 1;
        if (uVar9 == 0) goto LAB_00fe6c18;
      }
      uVar13 = uVar13 + 1;
    }
LAB_00fe6c18:
    uVar8 = IndexBuffer::getVBO(*(IndexBuffer **)(param_1 + 0x28));
    glBindBuffer(0x8893,uVar8);
    for (plVar11 = *(long **)(this + 0x48); plVar11 != (long *)0x0; plVar11 = (long *)*plVar11) {
      VertexAttribValue::apply((VertexAttribValue *)(plVar11 + 2));
    }
    GL::bindVAO(0);
    glBindBuffer(0x8892,0);
    glBindBuffer(0x8893,0);
  }
LAB_00fe6b70:
  if (local_8 != *(long *)PTR___stack_chk_guard_01721c30) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail(cVar6);
  }
  return;
}

