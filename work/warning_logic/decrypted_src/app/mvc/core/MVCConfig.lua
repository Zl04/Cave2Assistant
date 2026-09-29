--[[--
模块配置文件
可以运行game_tools/module_gen/template_gen.lua 生成模块
旧的函数不会被覆盖，也无法修改。如果要修改或者删除请手动处理
命名定义mvc中的 V 为config中的panel，panel上的layer为config中的view
]]
-------------名首字母大写  User---------------------------
local _module_configs = {}

-- 用于桥接老旧系统
_module_configs["Bridge"] = {
    events = {
        "Bridge_Show_Main_Layer",
        "Bridge_Hide_Main_Layer",
        "Bridge_Close_All_Panel_Layer"
    },
    views = {},
    models = {}
    -- proxys = {"Login"},
}

_module_configs["Common"] = {
    events = {
    },
    panels = {
        "BuffTip",
    },
    views = {
        "BuffTip"
    }
}



_module_configs["Activity"] = {
    events = {
        "Activity_Show_View",
        "Activity_Refresh",
        "Activity_Reward_Result",
        "Activity_Close"
    },
    views = {"Activity"},
    models = {"Activity"}
    -- proxys = {"Login"},
}

_module_configs["StarPray"] = {
    events = {
        "StarPray_ChangeLayer",
        "StarPray_Bag_Touch_Begin",
        "StarPray_Bag_Touch_End",
        "StarPray_Equip_DoOneKey",
        "StarPray_Equip_DoEquip",
        "StarPray_Swllow_DoSwllow",
        "StarPray_Swllow_DoOneKey",
        "StarPray_Swllow_Target_Touch",
        "StarPray_Swllow_Bag_Touch",
        "StarPray_Swllow_SHOW_SETTING",
        "StarPray_Swllow_SETTING_OK",
        "StarPray_Swllow_SETTING_Cancel",
        "StarPray_ShowShopView",
        "StarPray_Swallow_Confirm",
        "StarPray_Shop_GetReward",
        "StarPray_Shop_Ten_Click",
        "StarPray_Swallow_Overflow",
        "StarPray_Change_Plate",
        "StarPray_Show_Active_Attr_View",
    
        "StarPray_ActiveRune",
        "StarPray_Upgrade",
    },
    panels = {
        "StarPray",
        "StarPraySwallowSetting",
        "StarPraySwallowConfirm",
        "StarPrayShop"
    },
    views = {
        "StarPray",
        "StarPrayEquip",
        "StarPraySwallow",
        "StarPrayIncrease",
        "StarPrayShop",
        "StarPrayShopContent",
        "StarPraySwallowSetting",
        "StarPraySwallowConfirm",
        "StarPrayPlateAttrCell",
    }
}
_module_configs["LimitTimePackage"] = {
    panels = {"LimitTimePackage"},
    events = {"LimitTime_GET_DO"},
    views = {"LimitTimePackage"}
}

_module_configs["Expedition"] = {
    events = {
        "ExpeditionShowBag",
        "ExpeditionCloseBag",
        "Expedition_Data_Update",
        "Expedition_Start_Norml",
        "Expedition_Start_Norml_Result",
        "Expedition_Stop_Norml",
        "Expedition_Stop_Norml_Result",
        "Expedition_Start_Quick",
        "Expedition_Start_Quick_Result",
        "Expedition_Decompose",
        "Expedition_Decompose_Result",
        "Expedition_Sell_Goods",
        "Expedition_Sell_Goods_Result",
        "Expedition_Drag_Goods",
        "Expedition_Drag_Goods_Result",
        "Expedition_Get_Reward",
        "Expedition_Get_Reward_Result",
        "Expedition_Bag_Attr_Change",
        "Expedition_Select_IDX",
        "Expedition_Show_Select_View",
    },
    panels = {"Expedition","ExpeditionSelect"},
    views = {
        "Expedition",
        "ExpeditionBag",
        "ExpeditionSelect",
    }
}

_module_configs["WorldBoss"] = {
    events = {
        -- "WorldBoss_Revive_Auto",
        "WorldBoss_Revive_Immediately",
        "WorldBoss_Win_Quit",
        "WorldBoss_BuyBuff_Touch",
        "WorldBoss_Battle_Confirm",
    },
    panels = {
        "WorldBoss",
        "WorldBossComfirm",
        "WorldBossRoom",
        "WorldBossDieResult",
        "WorldBossWinResult",
        "WorldBossFightCD",
    },
    views = {
        "WorldBoss",
        "WorldBossComfirm",
        "WorldBossDieResult",
        "WorldBossRoom",
        "WorldBossWinResult",
        "WorldBossHurtRank",
        "WorldBossFightCD",
    }
}

_module_configs["SevenDays"] = {
    events = {
        "SevenDaysUpdateDataAndView",
        "SevenDaysUpdateTitle"
    },
    panels = {
        "SevenDays",
    },
    views = {
        "SevenDays",
    }
}

_module_configs["FestivalSign"] = {
    events = {
        "FestivalSignUpdateDataAndView",
        "FestivalSignUpdateTitle"
    },
    panels = {
        "FestivalSign",
    },
    views = {
        "FestivalSign",
    }
}

_module_configs["Guild"] = {
    events = {
        "Guild_SelectFloor_Get_Data",
        "Guild_SelectFloor_Get_Data_Result",
        "Guild_SelectFloor_Buy_Buff",
        "Guild_SelectFloor_Buy_Buff_Result",
        "Guild_SelectFloor_Challenge",
        "Guild_SelectFloor_Challenge_Result",
        "Guild_SelectFloor_Data_Update",
        "Guild_SelectFloor_Log_Add",
        "GuildTechOrSkill_GuildTechRequest",
        "GuildTechOrSkill_GuildTechResult",
        "GuildTechOrSkill_GuildSkillRequest",
        "GuildTechOrSkill_GuildSkillResult",
        "Guild_SelectFloor_Buy_Personal_Buff",
        "Guild_SelectFloor_Buy_Personal_Buff_Result",
    },
    panels = {
        "GuildSelectFloor",
        "GuildTechOrSkill",
        "GuildWrit",
        "GuildAuctionStock",
    },
    views = {
        "GuildSelectFloor",
        "GuildTechOrSkill",
        "GuildWrit",
        "GuildAuctionStock",
    }
}

_module_configs["ActivityLottery"] = {
	events = {"ShowActivityLottery"},
	panels = {"ActivityLottery"},
	views = {"ActivityLottery"},
}

_module_configs["GuildShop"] = {
    panels = {"GuildShop"},
    events = {"GuildShop_Npc_Response_Guild_Shop_Buy", "GuildShop_Npc_Response_Guild_Random_Shop_Buy"},
    views = {"GuildShop"}
}

_module_configs["ActivityPoint"] = {
    panels = {"ActivityPoint"},
    events = {
        "ActivityPoint_Role_Daily_Action_Info",
        "ActivityPoint_Role_Daily_Action_Reward_Result_Message",
        "ActivityPoint_Update_Stage_View"
    },
    views = {"ActivityPoint"}
}

_module_configs["Recast"] = {
    panels = {
        "RecastRemoveLevel",
        "RecastRefine",
        "EquipSuitTransform",
    },
    events = {
        "RecastRemoveLevel_Remove_Request",
        "RecastRemoveLevel_Remove_Result",
        "RecastRefine_Refine_Request",
        "RecastRefine_Refine_Result",
        "RecastRefine_ShowContent",
        "Recast_Bag_Drag_Began",
        "Recast_Bag_Drag_Moved",
        "Recast_Bag_Drag_Ended",
        "Recast_Refine_Grid_Drag_Out",
        "Recast_Do_Refine",
        "Recast_Suit_Transform_Show",
        "Recast_Suit_Transform_Drag_Out",
        "Recast_Do_Suit_Transform",
        "Recast_Suit_Transform_Target_Select",
    },
    views = {
        "RecastRemoveLevel",
        "RecastRefineContent",
        "RecastBagContent",
        "RecastSuitTransformContent",
    }
}

_module_configs["Apprenticeship"] = {
    panels = {
        "ApprenticeshipMentor",
        "ApprenticeshipApprentice",
        "ApprenticeshipApprenticeGraduate",
        "ApprenticeshipApply",
        "ApprenticeshipReceive",
    },
    events = {
        "MENTOR_RESPONSE_RECOMMEND_TUTOR_LIST_MESSAGE",
        "MENTOR_RESPONSE_INVITE_TUTOR_MESSAGE",
        "MENTOR_CONFIRM_TUTOR_RESULT_MESSAGE",
        "MENTOR_LOAD_TUTOR_ARCHIVE_MESSAGE",
        "MENTOR_TUTOR_INTERACT_RESULT_MESSAGE",
        "MENTOR_TUTOR_TASK_CHANGE_MESSAGE",
        "MENTOR_GET_TUTOR_REWARD_RESULT_MESSAGE",
        "MENTOR_ROLE_TUTOR_DATA_MESSAGE",
        "MENTOR_UPDATE_ROLE_INFO_MESSAGE",
        "Mentor_Request_Invite_Tutor_Message",
        "Mentor_Tutor_Setting_Message",
        "Mentor_Tutor_Interact_Message",
        "Mentor_Back_Town",
    },
    views = {
        "ApprenticeshipMentor",
        "ApprenticeshipMentorQuest",
        "ApprenticeshipMentorQuestCell",
        "ApprenticeshipMentorResult",
        "ApprenticeshipMentorResultCell",
        "ApprenticeshipMentorResultDaily",
        "ApprenticeshipApprentice",
        "ApprenticeshipApprenticeQuest",
        "ApprenticeshipApprenticeQuestCell",
        "ApprenticeshipApprenticeResult",
        "ApprenticeshipApprenticeGraduate",
        "ApprenticeshipApply",
        "ApprenticeshipReceive",
        "ApprenticeshipReceiveCell",
        "ApprenticeshipExplain",
    }
}
-- 节日活动
_module_configs["Festival"] = {
    panels = {
        "Festival",
        "FestivalMazeTeam",
        "FestivalReward",
        "FestivalCD",
        "FestivalWeaponSelect",
        "FestivalRelicStatistic",
        "FestivalExchangeShop",
        "FestivalRelicsSelect", -- hulu 遗物选择
    },
    events = {
        "FestivalReward_Quit",
        "Festival_WeaponSelect",
        "Festival_RelicStatistic",
        "Festival_OpenCloseExchangeShopView",
        "Festival_ExchangeShopExchangeRequest",
        "Festival_ExchangeShopExchangeResult",
        "Festival_LostRealmRequest",
        "Festival_LostRealmRoleStartMove",
    },
    views = {
        "Festival",
        "FestivalMazeTeam",
        "FestivalReward",
        "FestivalCD",
        "FestivalWeaponSelect",
        "FestivalRelicStatistic",
        "FestivalExchangeShop",
        "FestivalRelicsSelect",  -- hulu 遗物选择
    }
}

_module_configs["WishPool"] = {
    panels = {
        "WishPool",
        "WishPoolList",
        "WishPoolTip",
    },
    events = {
    },
    views = {
        "WishPool",
        "WishPoolList",
        "WishPoolTip",
    }
}

_module_configs["GreedySelect"] = {
    events = {
        "GREEDY_SELECT_DO_SELECT",
    },
    panels = {
        "GreedySelect",
    },
    views = {
        "GreedySelect",
    }
}

-- 左侧侧边栏，包括任务和队伍
_module_configs["QuickSideBar"] = {
    panels = {
        "QuickSideBar",
    },
    events = {
    },
    views = {
        "QuickSideBar",
    }
}

_module_configs["BattlePass"] = {
    panels = {
        "BattlePass",
        "BattlePassCharge",
        "BattlePassGuide",
    },
    events = {
        "BattlePass_ChangeLayer",
    },
    views = {
        "BattlePass",
        "BattlePassReward",
        "BattlePassShop",
        "BattlePassCharge",
        "BattlePassGuide",
    }
}

_module_configs["HitRat"] = {
    panels = {
        "HitRatRank",
        "HitRatReward",
        "HitRatMatch",
        "HitRatHammerInfo",
        "HitRatHammer",
        "HitRatResult",
    },
    events = {
        "HTI_RAT_HAMMER_CLICK",
        "HIT_RAT_TILE_TOUCH",
    },
    views = {
        "HitRatRank",
        "HitRatReward",
        "HitRatMatch",
        "HitRatHammerInfo",
        "HitRatHammer",
        "HitRatResult",
    }
}

_module_configs["Puzzle"] = {
    panels = {
        "PuzzleResult",
    },
    events = {
        "Puzzle_Click_Item",
        "Puzzle_Create_List",
        "Puzzle_Send_Result_Message",
        "Puzzle_Handle_Result_Message",
        "Puzzle_Show_ScoreNumBanner"
    },
    views = {
        "PuzzleResult",
    }
}

_module_configs["BigCrack"] = {
    panels = {
        "BigCrackReady",
        "BigCrackResult",
        "BigCrackCave",
        -- "BigCrack"
    },
    events = {
        "COLLECT_START",
        "COLLECT_END",
        "COLLECT_RESULT",
    },
    views = {
        "BigCrackReady",
        "BigCrackResult",
        "BigCrackCave",
        "BigCrackBossCell",
    }
}

_module_configs["Pet"] = {
    panels = {
        "PetMain",
        "PetAttr",
        "PetLookMain",
        "PetLookAttr",
        "PetTrain",
        "PetCompose",
        "PetRefine",
        "PetHandbook",
        "PetAddExp",
        "PetRefineSelect",
        "PetSkillInfo",
        "PetRename",
        "PetShare",
        "PetResultShow",
        "PetInherit",
        "PetSite",
        "PetAscendingStar",
        "PetBreakLevelLimit",
    },
    events = {
    },
    views = {
        "PetMain",
        "PetAttr",
        "PetLookMain",
        "PetLookAttr",
        "PetTrain",
        "PetCompose",
        "PetRefine",
        "PetHandbook",
        "PetAddExp",
        "PetRefineSelect",
        "PetSkillInfo",
        "PetRename",
        "PetShare",
        "PetResultShow",
        "PetInherit",
        "PetSite",
        "PetAscendingStar",
        "PetAddTalentPointDesTips",
        "PetBreakLevelLimit",
        "PetSkinCell",
        "PetSkinAttrDes",
    }
}

_module_configs["PetTreasure"] = {
    panels = {
        "PetTreasureMain",
        "PetRecyclingShop",
    },
    events = {
        "PetTreasure_Open_Main_view",
        "PetTreasure_Show_Layer",
        "PetTreasure_Update_Layer",
        "PetTreasure_Click_Tab",
        "PetTreasure_Self_Embattle_Item_Touch",
        "PetTreasure_Packet_Item_Touch",
        "PetTreasure_Switch_Challenge_Records_Layer",
        "PetTreasure_Send_Gather_Data",
        "PetTreasure_Handle_Gather_Data",
        "PetTreasure_Send_Callback_Gather_Pets",
        "PetTreasure_Handle_Callback_Gather_Pets",
        "PetTreasure_Handle_Fragments_update",
        "PetTreasure_Send_Gather_Pets",
        "PetTreasure_Handle_Gather_Pets",
        "PetTreasure_Send_Battle_Info_Pets",
        "PetTreasure_Handle_Battle_Info_Pets",
        "PetTreasure_Send_Battle_Pets",
        "PetTreasure_Handle_Battle_Pets",
        "PetTreasure_Send_Fragment_Compound_Pets",
        "PetTreasure_Handle_Fragment_Compound_Pets",
        "PetTreasure_Send_Battle_Record_Pets",
        "PetTreasure_Handle_Battle_Record_Pets",
        "PetTreasure_Send_Battle_Revenge_Pets",
        "PetTreasure_Handle_Battle_Revenge_Pets",
        "PetTreasure_Handle_Open_origin_Layer",
        "PetTreasure_Open_RecyclingShop_view",
        "PetTreasure_RecyclingShop_Click_Tab",
        "PetTreasure_RecyclingShop_Send_GoodsRecycle",
        "PetTreasure_RecyclingShop_Handle_GoodsRecycle",
        "PetAdventure_Challenge",
        "PetAdventure_Handle_Challenge_Callback",
        "PetAdventure_Explore",
        "PetAdventure_Handle_Explore_Callback",
        "PetAdventure_Explore_Stop",
        "PetAdventure_Handle_Explore_Stop_Callback",
        "PetAdventure_Handle_Level_Selected",
        "PetAdventure_Handle_Level_Guard_Data_REQ_Callback",
        "PetAdventure_Handle_Updata_Embattle_Layer",
        "PetAdventure_Update_Explor_Layer",
        "PetAdventure_REQ_Sync_PetAdv_Data",
        "PetAdventure_REQ_Explore_Rewards",
        "PetAdventure_Handle_Explore_Rewards_Callback",
        "PetAdventure_Handle_Adventure_Show_Drop_List",
    },
    views = {
        "PetTreasureMain",
        "PetRecyclingShop",
    }
}


_module_configs["TradeActivity"] = {
    panels = {
        "TradeActivityMain",
        "TradeActivityFirstPay",
        "TradeActivityCrystalCapture",
    },
    views = {
        "TradeActivityMain",
        "TradeActivityFirstPay",
        "TradeActivityGrowFund",
        "TradeActivityDailyGiftBag",
        "TradeActivityDailyPay",
        "TradeActivityLimitGiftCompetition",
        "TradeActivityLottery",
        "TradeActivityPrivilegeCard",
        "TradeActivityGroupPay",
        "TradeActivityFightBack",
        "TradeActivityNewGrowFund",
        "TradeActivityNewGrowFundTwo",
        "TradeActivityGrowFundII",
        "TradeActivityEquipmentStarFund",
        "TradeActivityTimeLimitedFightBack",
        "TradeActivityCrystalCapture",
        "TradeActivityGrowFund3",
    },
    events = {
        "TradeActivity_Show_View",
        "TradeActivity_Update_Layer",
        "TradeActivity_Send_Buy_DailyGiftBag",
        "TradeActivity_Handle_Role_Level_Up",
        "TradeActivity_Update_TradeActivity_TabList",
    },
}


_module_configs["SFSign"] = {
    panels = {
        "SFSign",
    },
    events = {
    },
    views = {
        "SFSign",
    }
}

_module_configs["GuildInfo"] = {
    panels = {
        "GuildInfo"
    },
    events = {
        "GuildApplySuccessful",
        "GuildJoinSuccessful",
        "GUILD_ASW_SIMPLE_GUILD_INFO_MESSAGE",
    },
    views = {
        "GuildInfo"
    }
}

_module_configs["GuildLog"] = {
    panels = {
        "GuildLog"
    },
    events = {
        "GUILD_ASW_LOG_MESSAGE"
    },
    views = {
        "GuildLog",
        "GuildLogInfoCell"
    }
}

_module_configs["GuildAuction"] = {
    panels = {
        "GuildAuction"
    },
    events = {
    },
    views = {
        "GuildAuction"
    }
}

-- 用于设置
_module_configs["Setting"] = {
    panels = {
        "SettingAreaServerSelect"   
    },
    events = {
        "Setting_Area_Server_HandleChangeArea",
        "Setting_Area_Server_ReqAreaList",
        "Setting_Area_Server_RespAreaList"
    },
    views = {
        "SettingAreaServerSelect",
        "SettingAreaServerSelectCell",
        "SettingAreaServerSelectOne"
    }
}

-- 用于arena的界面
_module_configs["Arena"] = {
    panels = {
        "Arena"
    },
    events = {
        "Arena_ResponseArenaData",
        "Arena_ResponseEnemyData",
    },
    views = {
        "Arena",
        "ArenaChallenge",
        "ArenaChallengeCell",
        "ArenaRanking",
        "ArenaRankingCell",
        "ArenaReport",
    }
}

-- 用于神迹祈福处理
_module_configs["Miracle"] = {
    panels = {
        "Miracle"
    },
    events = {
        "Miracle_ResponsePrayer"
    },
    views = {
        "Miracle",
        "MiraclePivotCell",
    }
}

-- 用于雇佣处理
_module_configs["Mercenary"] = {
    panels = {
        "Mercenary"
    },
    events = {
        
    },
    views = {
        "Mercenary",
        "MercenaryCell",
    }
}

-- 用于洞窟相关的页面
_module_configs["Cave"] = {
    panels = {
        "InfernoLevelSelect",
        "InfernoSelect",
        "CaveStateBag",   -- 这里用于显示三选一的状态背包，这里和葫芦娃背包都可以统一使用这个
        "GhostabyssLevelSelect",
        "GhostabyssShop",
        "GhostabyssSelect", -- 幽灵深渊里面的图腾的祝福抽取界面
        "VoidRiftLevelSelect",
        "VoidRiftSelect"
    },
    events = {
        "ShowGhostabyssDiffcultyChoice",
        "CloseGhostabyssDiffcultyChoice",
        "ShowGhostabyssChoiceLevel",
        "CloseGhostabyssChoiceLevel",
        "RefeshGhostabyssShop",
        "GhostabyssShopExchangeResponse",
        "GhostabyssSelectResponse"
    },
    views = {
        "InfernoLevelSelect",
        "InfernoSelect",
        "CaveStateBag",  -- 这里用于显示三选一的状态背包，这里和葫芦娃背包都可以统一使用这个
        "GhostabyssLevelSelect",
        "GhostabyssChoiceLevel",
        "GhostabyssDiffcultyChoice",
        "GhostabyssShop",
        "GhostabyssSelect",  -- 幽灵深渊里面的图腾的祝福抽取界面
        "VoidRiftLevelSelect",
        "VoidRiftSelect",
        "VoidRiftCurseBuffCell"
    }
}


-- 用于全屏特效处理
_module_configs["FullScreeen"] = {
    panels = {
        "FullScreeenEffect"   -- 用于葫芦娃喷水特效
    },
    events = {
    },
    views = {
        "FullScreeenEffect"
    }
}

-- 用于全屏特效处理
_module_configs["MainCity"] = {
    panels = {
        "MainCityFunctionChoice"   -- 主城功能选择
    },
    events = {
    },
    views = {
        "MainCityFunctionChoice",
        "MainCityFunctionChoiceCell"
    }
}

--反斗商店
_module_configs["FightBackShop"] = {
    panels = {
        "FightBackShop"
    },
    events = {
    },
    views = {
        "FightBackShop"
    }
}

_module_configs["FishGear"] = {
    panels = {
        "FishGearShop",
    },
    events = {
        "Fishing_Shop_Buy_Result_Handler",
    },
    views = {
        "FishGearShop",
        "FishGearShopCell",
    }
}

_module_configs["Dock"] = {
    panels = {
        "DockMain",
    },
    events = {
        "Dock_Show_Layer",
        "Dock_Click_Tab",
        "Dock_Open_Main_View",
        "Dock_Packet_Item_Drag",
        "Dock_Seaman_Drag_Move",
        "Dock_Seaman_Drag_End",
        "Dock_Sync_Sail_Data",
        "Dock_Resp_Change_Boat",
        "Dock_Resp_Got_New_Boat",
        "Dock_Resp_Set_Sail",
        "Dock_Take_Sail_Goods",
        "Dock_Show_Pet_Packet",
        "Dock_Pet_Packet_Double_Click",
        "Update_Dock_Upgrade_Progress",
        "Update_Dock_Detail",
    },
    views = {
        "DockMain",
        "DockSeamanCell",
        "DockBoatCell",
        "DockLog",
    }
}

_module_configs["BarterTable"] = {
    panels = {
        "BarterTable",
    },
    events = {
        "Barter_Table_Request",
        "Barter_Table_Result",
        "Barter_Table_ShowContent",
        "Barter_Bag_Drag_Began",
        "Barter_Bag_Drag_Moved",
        "Barter_Bag_Drag_Ended",
        "Barter_Grid_Drag_Out",
    },
    views = {
        "BarterTableContent",
        "BarterTableBagContent",
    }
}

_module_configs["ComebackPackage"] = {
    panels = {"ComebackPackage"},
    events = {},
    views = {"ComebackPackage"}
}

_module_configs["SuitTransformation"] = {
    panels = {"SuitTransformation","SuitTransformationSelectRetrofit"},
    events = {},
    views = {"SuitTransformation", "SuitTransformationSelectRetrofit"}
}

_module_configs["MonthlySign"] = {
    panels = {
        "MonthlySign",
    },
    events = {
        "Sync_MonthlySign_Data",
        "MonthlySign_In_Req",
        "MonthlySign_Cliam_Req",
        "MonthlySign_In_Resp",
        "MonthlySign_Cliam_Resp",
    },
    views = {
        "MonthlySign",
        "MonthlySignCell",
    }
}

_module_configs["ManorStarMap"] = {
    panels = {
        "ManorStarMap",
        "ManorStarMapMosaic",
        "ManorStarMapGetCard",
    },
    events = {
    },
    views = {
        "ManorStarMap",
        "ManorStarMapCard",
        "ManorStarMapCardCell",
        "ManorStarMapCardSlotCell",

        "ManorStarMapPokedex",
        "ManorStarMapPokedexCell",

        "ManorStarMapShowGetCard",

        "ManorStarMapMosaic",
        "ManorStarMapMosaicCell",

        "ManorStarMapCardUpgrade",
        "ManorStarMapCardUpgradeCell",
        "ManorStarMapCardUpgradeDragCell",
        
        "ManorStarMapGetCard",
    }
}

_module_configs["ManorDressUpShelf"] = {
    panels = {
        "ManorDressUpShelf",
    },
    events = {
        "Manor_DressUp_Operation_Refresh",
    },
    views = {
        "ManorDressUpShelf",
        "ManorDressUpShelfUpgrade",


        "ManorDressUpShelfOperation",
        "ManorSuitListCell",
        "ManorEquipListCell",

        
        "ManorDressUpShelfPokedex",
    }
}

_module_configs["ManorAppearance"] = {
    panels = {
        "ManorAppearanceMain",
        "ManorAppearanceInfoCell",
    },
    events = {
        "Manor_Appearance_Show_Layer",
        "Manor_Appearance_Click_Tab",
        "Manor_Appearance_Open_Main_View",
        "Manor_Appearance_Resp_Change_Build_Facade",
        "Manor_Appearance_Resp_Change_Mannor_Facade",
        "Manor_Appearance_Resp_Refresh_Mannor_Facade",
    },
    views = {
        "ManorAppearanceMain",
        "ManorAppearanceInfoCell",
        "ManorAppearanceShowCell",
    }
}

_module_configs["ManorDiningTable"] = {
    panels = {
        "ManorDiningTableMain",
    },
    events = {
        "Table_Show_Layer",
        "Table_Click_Tab",
        "Table_Open_Main_View",
        "Table_Refresh_View",
    },
    views = {
        "ManorDiningTableMain",
        "ManorDiningTableInfoCell",
    }
}

_module_configs["AnniversaryAppointment"] = {
    panels = {
        "AnniversaryAppointmentMain",
    },
    events = {
        "AnniversaryAppointment_Show_Layer",
        "AnniversaryAppointment_Click_Tab",
        "AnniversaryAppointment_Open_Main_View",
        "AnniversaryAppointment_Refresh_Sever_Reward_Btn",
        "AnniversaryAppointment_Refresh_Coin_Number",
    },
    views = {
        "AnniversaryAppointmentMain",
        "AnniversaryAppointmentTarget",
        "AnniversaryAppointmentCoinReward",
        "AnniversaryAppointmentServerReward",
        "AnniversaryAppointmentTaskCell",
    }
}

_module_configs["ActivityModeCave"] = {
    panels = {
        "ActivityModeCaveMain",
        "ActivityModeCaveEntryReward",
    },
    events = {
        "ActivityModeCave_Open_Main_View",
        "ActivityModeCave_Open_Challenge_View",
        "ActivityModeCave_Request_Cave_Data",
        "ActivityModeCave_Refresh_EntryDes_View",
        "ActivityModeCave_Show_Entry_Reward_View",
        "ActivityModeCave_Refresh_Rank_RedPoint",
    },
    views = {
        "ActivityModeCaveMain",
        "ActivityModeCaveSelectCell",
        "ActivityModeCaveChallenge",
        "ActivityModeCaveEntryCell",
        "ActivityModeCaveEntryDesCell",
        "ActivityModeCaveEntryReward",
        "ActivityModeCaveRank",
        "ActivityModeCaveEntryRewardCell",
    }
}

_module_configs["ActivityModeCaveLeaderboard"] = {
    panels = {
        "ActivityModeCaveLeaderboard",
    },
    events = {
    },
    views = {
        "ActivityModeCaveLeaderboard",

        "ActivityModeCaveLeaderboardRanking",
        "ActivityModeCaveLeaderboardRankingCell",

        "ActivityModeCaveLeaderboardAward",
        "ActivityModeCaveLeaderboardAwardCell",

        "ActivityModeCaveLeaderboardParticipationAward",
    }
}

_module_configs["ActivityAnnivesaryLottery"] = {
    panels = {
        "ActivityAnnivesaryLotteryMain",
        "ActivityAnnivesaryLotteryPre",
        "ActivityAnnivesaryLotteryReward",
        "ActivityAnnivesaryLotteryRewardRoster",
    },
    events = {
        "ActivityAnnivesary_Show_Layer",
        "ActivityAnnivesary_Click_Tab",
        "ActivityAnnivesary_Open_Main_View",
        "ActivityAnnivesary_refresh_Lottery_View",
        "ActivityAnnivesary_Show_PreView",
        "ActivityAnnivesary_Show_Reward_View",
        "ActivityAnnivesary_Show_Reward_Roster_View",
    },
    views = {
        "ActivityAnnivesaryLotteryMain",
        "ActivityAnnivesaryLottery",
        "ActivityAnnivesaryLotteryAdvanced",
        "ActivityAnnivesaryLotteryPetDetail",
        "ActivityAnnivesaryLotteryGiftPack",
        "ActivityAnnivesaryLotteryPre",
        "ActivityAnnivesaryLotteryReward",
        "ActivityAnnivesaryLotteryRewardRoster",
    }
}

_module_configs["GmeBuyShowNextLevel"] = {
    panels = {
        "GmeBuyShowNextLevel",
    },
    events = {
    },
    views = {
        "GmeBuyShowNextLevel",
    }
}

_module_configs["ViKing"] = {
    panels = {
        "ViKingMain",
        "ViKingSelect",
        "ViKingLevelSelect",
    },
    events = {
    },
    views = {
        "ViKingMain",
        "ViKingLevelSelect",
        "ViKingSelect",
    }
}

_module_configs["ManorPedleryMaterial"] = {
    panels = {
        "ManorPedleryMaterial",
    },
    events = {
    },
    views = {
        "ManorPedleryMaterial",
    }
}

_module_configs["EverWinterRift"] = {
    panels = {
        "EverWinterRiftMain",
    },
    events = {
        "EverWinterRift_Refresh_Info",
        "EverWinterRift_Rsp_Get_Reward",
    },
    views = {
        "EverWinterRiftMain",
    }
}
_module_configs["PetGemStoneDevelopment"] = {
    panels = {
        "PetGemStoneDevelopment",
    },
    events = {
    },
    views = {
        "PetGemStoneDevelopment",
        "PetGemStoneChoiseConvert",
    }
}


_module_configs["IdentifyTreasureItem"] = {
    panels = {
        "IdentifyTreasureItem",
    },
    events = {
    },
    views = {
        "IdentifyTreasureItem",
    }
}

_module_configs["RoleReincarnation"] = {
    panels = {
        "RoleReincarnation",
    },
    events = {
        "RoleReincarnation_Req_Role_Reincarnation",
        "RoleReincarnation_Show_Detail_Layer",
        "RoleReincarnation_Update_Role_Layout",
    },
    views = {
        "RoleReincarnation",
        "RoleReincarnationDetailCell",
    }
}

_module_configs["PetReincarnation"] = {
    panels = {
        "PetReincarnation",
    },
    events = {
        "PetReincarnation_Req_Pet_Reincarnation",
        "PetReincarnation_Show_Detail_Layer",
        "PetReincarnation_Update_Pet_Layout",
    },
    views = {
        "PetReincarnation",
        "PetSkillTable",
    }
}

--水晶夺宝商店
_module_configs["CrystalTreatureShop"] = {
    panels = {
        "CrystalTreatureShop"
    },
    events = {
    },
    views = {
        "CrystalTreatureShop"
    }
}

_module_configs["RuneMold"] = {
    panels = {
        "RuneMold",
    },
    events = {
        "Rune_Mold_ShowContent",
        "Rune_Bag_Drag_Began",
        "Rune_Bag_Drag_Ended",
        "Rune_Mold_Grid_Drag_Out",
        "Rune_Mold_On_Bag_Close",
        "Rune_Mold_On_Forging",
        "Rune_Mold_On_Inlaid",
    },
    views = {
        "RuneMold",
        "RuneMoldDetialCell",
        "RuneMoldBagContent",
        "RuneMoldDetial",
        "RuneMoldCharacteristicDes"
    }
}

_module_configs["UseMold"] = {
    panels = {
        "UseMold",
    },
    events = {
        "UseMold_ShowContent",
        "UseMold_Bag_Drag_Began",
        "UseMold_Bag_Drag_Moved",
        "UseMold_Bag_Drag_Ended",
        "UseMold_Grid_Drag_Out",
        "UseMold_On_Mold_Used",
    },
    views = {
        "UseMold",
        "UseMoldBagContent",
        "UseMoldToolBoxCell",
        "UseMoldBagBoxCell",
        "UseMoldInfoArea",
        "UseMoldRuneHoleCell",
        "UseMoldAttrDetail",
    }
}

_module_configs["Relic"] = {
    panels = {
        "RelicIntensify",
    },
    events = {
    },
    views = {
        "RelicIntensify",
    }
}

_module_configs["CaveExploring"] = {
    panels = {
        "CaveExploring",
    },
    events = {
        "CaveExploring_Update_BoxMapView",
    },
    views = {
        "CaveExploring",
    }
}

_module_configs["BigSailPort"] = {
    panels = {
        "BigSailPort",
        "BigSailPortSupplyItem",
        "BigSailPortSetPetCell",
        "BigSailPortSpeedUp",
        "BigSailPortSupply"
    },
    events = {
        "BigSailPort_Supply_Layer",
        "BigSailPort_Merchant_Layer",
        "BigSailPort_Task_Layer",
        "BigSailPort_Click_Log_Tab",
        "BigSailPort_Show_Log_Layer",
    },
    views = {
        "BigSailPort",
        "BigSailPortSupply",
        "BigSailPortMerchant",
        "BigSailPortTask",
        "BigSailPortShowCell",
        "BigSailPortSupplyItem",
        "BigSailPortSpeedUp",
        "BigSailPortSetPetCell",
        "BigSailPortSeamanCell",
        "BigSailEvent",
        "BigSailEventCell",
    }
}

_module_configs["BigSailIsland"] = {
    panels = {
        "BigSailIsland",
        "BigSailIslandBoatInfo",
        "BigSailIslandExpel",
        "BigSailIslandRank",
        "BigSailIslandRankResult",
        "BigSailIslandShowMap",
        "BigSailIslandHostilityGuild",
        "BigSailIslandDispatch",
        "BigSailIslandBossInfo",
        "BigSailIslandBossDmgRank",
        "BigSailIslandGetOccupyReward",
        "BigSailIslandFightSelect",
        "BigSailIslandFreshMonster",
    },
    events = {
        "BigSailIsland_Info_Layer"
    },
    views = {
        "BigSailIsland",
        "BigSailIslandInfo",
        "BigSailIslandBoatInfo",
        "BigSailIslandExpel",
        "BigSailIslandRank",
        "BigSailIslandRankResult",
        "BigSailIslandResultTableCell",
        "BigSailIslandShowMap",
        "BigSailIslandHostilityGuild",
        "BigSailIslandDispatch",
        "BigSailIslandGuildTableCell",
        "BigSailIslandBossInfo",
        "BigSailIslandBossDmgRank",
        "BigSailIslandBossDmgRankShowCell",
        "BigSailIslandGetOccupyReward",
        "BigSailIslandFightSelect",
        "BigSailIslandFreshMonster",
    }
}

_module_configs["DungeonExpFight"] = {
    panels = {
        "DungeonExpFight",

    },
    events = {
    },
    views = {
        "DungeonExpFight",
    }
}

_module_configs["ChaosWormhole"] = {
    panels = {
        "ChaosWormholeMain",
        "ChaosWormholeSelect",
        "ChaosWormholeLevelSelect",
    },
    events = {
    },
    views = {
        "ChaosWormholeMain",
        "ChaosWormholeLevelSelect",
        "ChaosWormholeSelect",
    }
}
_module_configs["NetworkEnvironmentTesting"] = {
    panels = {
    },
    events = {
    },
    views = {
    }
}

-- _module_configs["AllGroupBuying"] = {
--     panels = {
--         "AllGroupBuying",
--     },
--     events = {
--     },
--     views = {
--         "AllGroupBuying",
--         "AllGroupEverTimeDetail",
--         "AllGroupEverTimeGift",
--     }
-- }

_module_configs["Glyphs"] = {
    panels = {
        "GlyphsMain",
    },
    events = {
        "Glyphs_Show_Layer",
        "Glyphs_Click_Tab",
        "Glyphs_Open_Main_View",
        "Glyphs_On_Casting_Succeed_Show_Get",
        "Glyphs_On_Inherit_Succeed",
        "Glyphs_Refresh_Casting_Num",
    },
    views = {
        "GlyphsMain",
        "GlyphsInlay",
        "GlyphsRefined",
        "GlyphRefinedItem",
        "GlyphRefinedShowResult",
        "GlyphRefinedShowResultList",
    }
}

_module_configs["DeepInWormhole"] = {
    panels = {
        "DeepInWormholeMain",
    },
    events = {
        "DeepInWormhole_Refresh_Info"
    },
    views = {
        "DeepInWormholeMain",
    }
}

_module_configs["PurpleUpgrade"] = {
    panels = {
        "PurpleUpgradeMain",
    },
    events = {
        "PurpleUpgrade_Show_Layer",
        "PurpleUpgrade_Click_Tab",
        "PurpleUpgrade_Open_Main_View",
        "Primogem_On_Decompose_Succeed",
        "PrimogemShop_Exchange_Success",
        "PrimogemShop_Refresh_Info",
    },
    views = {
        "PurpleUpgradeMain",
        "PurpleUpgradeEquip",
        "PurpleUpgradeExchange",
        "PurpleUpgradeReset",
        "PurpleUpgradeDebrisConvert",
    }
}

_module_configs["Bet"] = {
    panels = {
        "BetMain",
        "RallyGame",
        "RallyResult",
        "RallySkillTargetChoice",
        "RallyBoatEffect",
        "RallyBoatInfo",
    },
    events = {
        "BetItemNum_Refresh",           -- 竞猜币刷新
        "BetBaseInfo_Refresh",          -- 基础信息刷新
        "BetBoatInfo_EventUpdate",      -- 事件更新 
        "Bet_SkillUpdate",              -- 技能数据更新
        "Bet_SettleResult",             -- 结算通知
        "Bet_ShowUseEffect",            -- 通知使用效果
        "BetPersionInfo_Refresh",       -- 通知个人消息刷新
    },
    views = {
        "BetMain",
        "BetInfo",                  -- 投注信息
        "BetHistory",               -- 投注历史
        "RallyGame",                -- 拉力赛战斗 
        "RallyResult",              -- 拉力赛结果
        "RallySkillTargetChoice",   -- 拉力赛技能目标选择
        "RallyBoatEffect",          -- 拉力赛船使用技能，道具的效果
        "RallyBoatInfo",            -- 船的详情页面
    }
}

-- 符文石链接
_module_configs["GemConnect"] = {
    panels = {
        "GemConnect",
    },
    events = {
        "GemView_Refresh",  --连接符文或者取消连接后刷新界面
    },
    views = {
        "GemConnect",
    }
}

--符文石分解
_module_configs["GemDecompose"] = {
    panels = {
        "GemDecompose",
    },
    events = {
        "GemDecomposeView_Refresh",  --符文石分解后刷新界面
    },
    views = {
        "GemDecompose",
    }
}

--兽栏升级优化后的界面
_module_configs["CorralUpgrade"] = {
    panels = {
        "CorralUpgrade",
        "CorralUpgradeUseItem",
    },
    events = {
    },
    views = {
        "CorralUpgrade",
        "CorralUpgradeUseItem",
    }
}

--纪念品
_module_configs["Souvenir"] = {
    panels = {
        "Souvenir",
        "SouvenirDetails",
        "SouvenirActiveTips",
    },
    events = {
        "Souvenir_Resource_Change",
        "Souvenir_Close_Layer",
    },
    views = {
        "Souvenir",
        "SouvenirCell",
        "SouvenirDetails",
        "SouvenirActiveTips",
    }
}

-------------------------------用户检测是否正确-------------------------
if not DEBUG or DEBUG > 0 then
    function isUpper(str)
        return string.sub(str, 0, 1) == string.upper(string.sub(str, 0, 1))
    end
    function getUpperName(str)
        return string.upper(string.sub(str, 0, 1)) .. string.sub(str, 2)
    end
    local errorFormat = "name [%s] should be upper(大写),right format is [%s]"

    function check(list, type)
        if not list then
            return
        end
        type = type or ""
        for i, which in ipairs(list) do
            if not isUpper(which) then
                error(string.format(type .. errorFormat, which, getUpperName(which)))
            end
        end
    end

    function checkUpper()
        for key, config in pairs(_module_configs) do
            check({key}, "module")
            check(config.views, "views")
            check(config.proxys, "proxys")
            check(config.events, "events")
        end
    end
    checkUpper()
end

return _module_configs

-- moduleName = {skippedModel, skippedService}

--[[



Usage:

local roleModel = ns.model.role 					-- "app.modules.role.role_m"
local talentModel = ns.model.role_talent			-- "app.modules.role.talent_m"

local roleService = ns.service.role 				-- "app.modules.role.role_s"
local talentService = ns.service.role_talent		-- "app.modules.role.talent_s"

local rolePane = ns.view.role 						-- "app.modules.role.view.rolepane"
local talentPane = ns.view.role_talent 				-- "app.modules.role.view.talentpane"

local roleVo = ns.vo.role 							-- "app.modules.role.role_vo"
local talentVo = ns.vo.role_talent				 	-- "app.modules.role.talent_vo"

--]]
