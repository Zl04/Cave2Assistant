--[[--
   自动生成模块事件文件 
   在modules中定义监听的事件,
   facade 能够处理 四类事件 公共事件 (一个事件被多个模块监听,以Update_开头) 
   view视图事件,proxy底层数据代理时间,controller控制层事件
   请严格按照命名方式  proxy(view)_methodName ，第一个模块名必须保证
]]

local events = {}
events.Open_Panel = "Open_Panel"
events.Close_Panel = "Close_Panel"





----------------------------------[Activity 模块 事件]------------------------------------
events.Activity_Show_View = "Activity_Show_View"
events.Activity_Refresh = "Activity_Refresh"
events.Activity_Reward_Result = "Activity_Reward_Result"
events.Activity_Close = "Activity_Close"



----------------------------------[ActivityAnnivesaryLottery 模块 事件]------------------------------------
events.ActivityAnnivesary_Show_Layer = "ActivityAnnivesary_Show_Layer"
events.ActivityAnnivesary_Click_Tab = "ActivityAnnivesary_Click_Tab"
events.ActivityAnnivesary_Open_Main_View = "ActivityAnnivesary_Open_Main_View"
events.ActivityAnnivesary_refresh_Lottery_View = "ActivityAnnivesary_refresh_Lottery_View"
events.ActivityAnnivesary_Show_PreView = "ActivityAnnivesary_Show_PreView"
events.ActivityAnnivesary_Show_Reward_View = "ActivityAnnivesary_Show_Reward_View"
events.ActivityAnnivesary_Show_Reward_Roster_View = "ActivityAnnivesary_Show_Reward_Roster_View"



----------------------------------[ActivityLottery 模块 事件]------------------------------------
events.ShowActivityLottery = "ShowActivityLottery"



----------------------------------[ActivityModeCave 模块 事件]------------------------------------
events.ActivityModeCave_Open_Main_View = "ActivityModeCave_Open_Main_View"
events.ActivityModeCave_Open_Challenge_View = "ActivityModeCave_Open_Challenge_View"
events.ActivityModeCave_Request_Cave_Data = "ActivityModeCave_Request_Cave_Data"
events.ActivityModeCave_Refresh_EntryDes_View = "ActivityModeCave_Refresh_EntryDes_View"
events.ActivityModeCave_Show_Entry_Reward_View = "ActivityModeCave_Show_Entry_Reward_View"
events.ActivityModeCave_Refresh_Rank_RedPoint = "ActivityModeCave_Refresh_Rank_RedPoint"



----------------------------------[ActivityModeCaveLeaderboard 模块 事件]------------------------------------



----------------------------------[ActivityPoint 模块 事件]------------------------------------
events.ActivityPoint_Role_Daily_Action_Info = "ActivityPoint_Role_Daily_Action_Info"
events.ActivityPoint_Role_Daily_Action_Reward_Result_Message = "ActivityPoint_Role_Daily_Action_Reward_Result_Message"
events.ActivityPoint_Update_Stage_View = "ActivityPoint_Update_Stage_View"



----------------------------------[AnniversaryAppointment 模块 事件]------------------------------------
events.AnniversaryAppointment_Show_Layer = "AnniversaryAppointment_Show_Layer"
events.AnniversaryAppointment_Click_Tab = "AnniversaryAppointment_Click_Tab"
events.AnniversaryAppointment_Open_Main_View = "AnniversaryAppointment_Open_Main_View"
events.AnniversaryAppointment_Refresh_Sever_Reward_Btn = "AnniversaryAppointment_Refresh_Sever_Reward_Btn"
events.AnniversaryAppointment_Refresh_Coin_Number = "AnniversaryAppointment_Refresh_Coin_Number"



----------------------------------[Apprenticeship 模块 事件]------------------------------------
events.MENTOR_RESPONSE_RECOMMEND_TUTOR_LIST_MESSAGE = "MENTOR_RESPONSE_RECOMMEND_TUTOR_LIST_MESSAGE"
events.MENTOR_RESPONSE_INVITE_TUTOR_MESSAGE = "MENTOR_RESPONSE_INVITE_TUTOR_MESSAGE"
events.MENTOR_CONFIRM_TUTOR_RESULT_MESSAGE = "MENTOR_CONFIRM_TUTOR_RESULT_MESSAGE"
events.MENTOR_LOAD_TUTOR_ARCHIVE_MESSAGE = "MENTOR_LOAD_TUTOR_ARCHIVE_MESSAGE"
events.MENTOR_TUTOR_INTERACT_RESULT_MESSAGE = "MENTOR_TUTOR_INTERACT_RESULT_MESSAGE"
events.MENTOR_TUTOR_TASK_CHANGE_MESSAGE = "MENTOR_TUTOR_TASK_CHANGE_MESSAGE"
events.MENTOR_GET_TUTOR_REWARD_RESULT_MESSAGE = "MENTOR_GET_TUTOR_REWARD_RESULT_MESSAGE"
events.MENTOR_ROLE_TUTOR_DATA_MESSAGE = "MENTOR_ROLE_TUTOR_DATA_MESSAGE"
events.MENTOR_UPDATE_ROLE_INFO_MESSAGE = "MENTOR_UPDATE_ROLE_INFO_MESSAGE"
events.Mentor_Request_Invite_Tutor_Message = "Mentor_Request_Invite_Tutor_Message"
events.Mentor_Tutor_Setting_Message = "Mentor_Tutor_Setting_Message"
events.Mentor_Tutor_Interact_Message = "Mentor_Tutor_Interact_Message"
events.Mentor_Back_Town = "Mentor_Back_Town"



----------------------------------[Arena 模块 事件]------------------------------------
events.Arena_ResponseArenaData = "Arena_ResponseArenaData"
events.Arena_ResponseEnemyData = "Arena_ResponseEnemyData"



----------------------------------[BarterTable 模块 事件]------------------------------------
events.Barter_Table_Request = "Barter_Table_Request"
events.Barter_Table_Result = "Barter_Table_Result"
events.Barter_Table_ShowContent = "Barter_Table_ShowContent"
events.Barter_Bag_Drag_Began = "Barter_Bag_Drag_Began"
events.Barter_Bag_Drag_Moved = "Barter_Bag_Drag_Moved"
events.Barter_Bag_Drag_Ended = "Barter_Bag_Drag_Ended"
events.Barter_Grid_Drag_Out = "Barter_Grid_Drag_Out"



----------------------------------[BattlePass 模块 事件]------------------------------------
events.BattlePass_ChangeLayer = "BattlePass_ChangeLayer"



----------------------------------[Bet 模块 事件]------------------------------------
events.BetItemNum_Refresh = "BetItemNum_Refresh"
events.BetBaseInfo_Refresh = "BetBaseInfo_Refresh"
events.BetBoatInfo_EventUpdate = "BetBoatInfo_EventUpdate"
events.Bet_SkillUpdate = "Bet_SkillUpdate"
events.Bet_SettleResult = "Bet_SettleResult"
events.Bet_ShowUseEffect = "Bet_ShowUseEffect"
events.BetPersionInfo_Refresh = "BetPersionInfo_Refresh"



----------------------------------[BigCrack 模块 事件]------------------------------------
events.COLLECT_START = "COLLECT_START"
events.COLLECT_END = "COLLECT_END"
events.COLLECT_RESULT = "COLLECT_RESULT"



----------------------------------[BigSailIsland 模块 事件]------------------------------------
events.BigSailIsland_Info_Layer = "BigSailIsland_Info_Layer"



----------------------------------[BigSailPort 模块 事件]------------------------------------
events.BigSailPort_Supply_Layer = "BigSailPort_Supply_Layer"
events.BigSailPort_Merchant_Layer = "BigSailPort_Merchant_Layer"
events.BigSailPort_Task_Layer = "BigSailPort_Task_Layer"
events.BigSailPort_Click_Log_Tab = "BigSailPort_Click_Log_Tab"
events.BigSailPort_Show_Log_Layer = "BigSailPort_Show_Log_Layer"



----------------------------------[Bridge 模块 事件]------------------------------------
events.Bridge_Show_Main_Layer = "Bridge_Show_Main_Layer"
events.Bridge_Hide_Main_Layer = "Bridge_Hide_Main_Layer"
events.Bridge_Close_All_Panel_Layer = "Bridge_Close_All_Panel_Layer"



----------------------------------[Cave 模块 事件]------------------------------------
events.ShowGhostabyssDiffcultyChoice = "ShowGhostabyssDiffcultyChoice"
events.CloseGhostabyssDiffcultyChoice = "CloseGhostabyssDiffcultyChoice"
events.ShowGhostabyssChoiceLevel = "ShowGhostabyssChoiceLevel"
events.CloseGhostabyssChoiceLevel = "CloseGhostabyssChoiceLevel"
events.RefeshGhostabyssShop = "RefeshGhostabyssShop"
events.GhostabyssShopExchangeResponse = "GhostabyssShopExchangeResponse"
events.GhostabyssSelectResponse = "GhostabyssSelectResponse"



----------------------------------[CaveExploring 模块 事件]------------------------------------
events.CaveExploring_Update_BoxMapView = "CaveExploring_Update_BoxMapView"



----------------------------------[ChaosWormhole 模块 事件]------------------------------------



----------------------------------[ComebackPackage 模块 事件]------------------------------------



----------------------------------[Common 模块 事件]------------------------------------



----------------------------------[CorralUpgrade 模块 事件]------------------------------------



----------------------------------[CrystalTreatureShop 模块 事件]------------------------------------



----------------------------------[DeepInWormhole 模块 事件]------------------------------------
events.DeepInWormhole_Refresh_Info = "DeepInWormhole_Refresh_Info"



----------------------------------[Dock 模块 事件]------------------------------------
events.Dock_Show_Layer = "Dock_Show_Layer"
events.Dock_Click_Tab = "Dock_Click_Tab"
events.Dock_Open_Main_View = "Dock_Open_Main_View"
events.Dock_Packet_Item_Drag = "Dock_Packet_Item_Drag"
events.Dock_Seaman_Drag_Move = "Dock_Seaman_Drag_Move"
events.Dock_Seaman_Drag_End = "Dock_Seaman_Drag_End"
events.Dock_Sync_Sail_Data = "Dock_Sync_Sail_Data"
events.Dock_Resp_Change_Boat = "Dock_Resp_Change_Boat"
events.Dock_Resp_Got_New_Boat = "Dock_Resp_Got_New_Boat"
events.Dock_Resp_Set_Sail = "Dock_Resp_Set_Sail"
events.Dock_Take_Sail_Goods = "Dock_Take_Sail_Goods"
events.Dock_Show_Pet_Packet = "Dock_Show_Pet_Packet"
events.Dock_Pet_Packet_Double_Click = "Dock_Pet_Packet_Double_Click"



----------------------------------[DungeonExpFight 模块 事件]------------------------------------



----------------------------------[EverWinterRift 模块 事件]------------------------------------
events.EverWinterRift_Refresh_Info = "EverWinterRift_Refresh_Info"
events.EverWinterRift_Rsp_Get_Reward = "EverWinterRift_Rsp_Get_Reward"



----------------------------------[ExchangeShop 模块 事件]------------------------------------



----------------------------------[Expedition 模块 事件]------------------------------------
events.ExpeditionShowBag = "ExpeditionShowBag"
events.ExpeditionCloseBag = "ExpeditionCloseBag"
events.Expedition_Data_Update = "Expedition_Data_Update"
events.Expedition_Start_Norml = "Expedition_Start_Norml"
events.Expedition_Start_Norml_Result = "Expedition_Start_Norml_Result"
events.Expedition_Stop_Norml = "Expedition_Stop_Norml"
events.Expedition_Stop_Norml_Result = "Expedition_Stop_Norml_Result"
events.Expedition_Start_Quick = "Expedition_Start_Quick"
events.Expedition_Start_Quick_Result = "Expedition_Start_Quick_Result"
events.Expedition_Decompose = "Expedition_Decompose"
events.Expedition_Decompose_Result = "Expedition_Decompose_Result"
events.Expedition_Sell_Goods = "Expedition_Sell_Goods"
events.Expedition_Sell_Goods_Result = "Expedition_Sell_Goods_Result"
events.Expedition_Drag_Goods = "Expedition_Drag_Goods"
events.Expedition_Drag_Goods_Result = "Expedition_Drag_Goods_Result"
events.Expedition_Get_Reward = "Expedition_Get_Reward"
events.Expedition_Get_Reward_Result = "Expedition_Get_Reward_Result"
events.Expedition_Bag_Attr_Change = "Expedition_Bag_Attr_Change"
events.Expedition_Select_IDX = "Expedition_Select_IDX"
events.Expedition_Show_Select_View = "Expedition_Show_Select_View"



----------------------------------[Festival 模块 事件]------------------------------------
events.FestivalReward_Quit = "FestivalReward_Quit"
events.Festival_WeaponSelect = "Festival_WeaponSelect"
events.Festival_RelicStatistic = "Festival_RelicStatistic"
events.Festival_OpenCloseExchangeShopView = "Festival_OpenCloseExchangeShopView"
events.Festival_ExchangeShopExchangeRequest = "Festival_ExchangeShopExchangeRequest"
events.Festival_ExchangeShopExchangeResult = "Festival_ExchangeShopExchangeResult"
events.Festival_LostRealmRequest = "Festival_LostRealmRequest"
events.Festival_LostRealmRoleStartMove = "Festival_LostRealmRoleStartMove"



----------------------------------[FestivalSign 模块 事件]------------------------------------
events.FestivalSignUpdateDataAndView = "FestivalSignUpdateDataAndView"
events.FestivalSignUpdateTitle = "FestivalSignUpdateTitle"



----------------------------------[FightBackShop 模块 事件]------------------------------------



----------------------------------[FishGear 模块 事件]------------------------------------
events.Fishing_Shop_Buy_Result_Handler = "Fishing_Shop_Buy_Result_Handler"



----------------------------------[FullScreeen 模块 事件]------------------------------------



----------------------------------[GameHallPrivilege 模块 事件]------------------------------------
events.QQGame_Sync_GameHall_Claim_Data = "QQGame_Sync_GameHall_Claim_Data"
events.Game_Hall_Claim_Newbie_Gift = "Game_Hall_Claim_Newbie_Gift"
events.Game_Hall_Claim_Daily_Gift = "Game_Hall_Claim_Daily_Gift"
events.Game_Hall_Claim_Level_Gift = "Game_Hall_Claim_Level_Gift"
events.Game_Hall_Refresh_View = "Game_Hall_Refresh_View"



----------------------------------[GemConnect 模块 事件]------------------------------------
events.GemView_Refresh = "GemView_Refresh"



----------------------------------[GemDecompose 模块 事件]------------------------------------
events.GemDecomposeView_Refresh = "GemDecomposeView_Refresh"



----------------------------------[Glyphs 模块 事件]------------------------------------
events.Glyphs_Show_Layer = "Glyphs_Show_Layer"
events.Glyphs_Click_Tab = "Glyphs_Click_Tab"
events.Glyphs_Open_Main_View = "Glyphs_Open_Main_View"
events.Glyphs_On_Casting_Succeed_Show_Get = "Glyphs_On_Casting_Succeed_Show_Get"
events.Glyphs_On_Inherit_Succeed = "Glyphs_On_Inherit_Succeed"
events.Glyphs_Refresh_Casting_Num = "Glyphs_Refresh_Casting_Num"



----------------------------------[GmeBuyShowNextLevel 模块 事件]------------------------------------



----------------------------------[GreedySelect 模块 事件]------------------------------------
events.GREEDY_SELECT_DO_SELECT = "GREEDY_SELECT_DO_SELECT"



----------------------------------[Guild 模块 事件]------------------------------------
events.Guild_SelectFloor_Get_Data = "Guild_SelectFloor_Get_Data"
events.Guild_SelectFloor_Get_Data_Result = "Guild_SelectFloor_Get_Data_Result"
events.Guild_SelectFloor_Buy_Buff = "Guild_SelectFloor_Buy_Buff"
events.Guild_SelectFloor_Buy_Buff_Result = "Guild_SelectFloor_Buy_Buff_Result"
events.Guild_SelectFloor_Challenge = "Guild_SelectFloor_Challenge"
events.Guild_SelectFloor_Challenge_Result = "Guild_SelectFloor_Challenge_Result"
events.Guild_SelectFloor_Data_Update = "Guild_SelectFloor_Data_Update"
events.Guild_SelectFloor_Log_Add = "Guild_SelectFloor_Log_Add"
events.GuildTechOrSkill_GuildTechRequest = "GuildTechOrSkill_GuildTechRequest"
events.GuildTechOrSkill_GuildTechResult = "GuildTechOrSkill_GuildTechResult"
events.GuildTechOrSkill_GuildSkillRequest = "GuildTechOrSkill_GuildSkillRequest"
events.GuildTechOrSkill_GuildSkillResult = "GuildTechOrSkill_GuildSkillResult"
events.Guild_SelectFloor_Buy_Personal_Buff = "Guild_SelectFloor_Buy_Personal_Buff"
events.Guild_SelectFloor_Buy_Personal_Buff_Result = "Guild_SelectFloor_Buy_Personal_Buff_Result"



----------------------------------[GuildAuction 模块 事件]------------------------------------



----------------------------------[GuildInfo 模块 事件]------------------------------------
events.GuildApplySuccessful = "GuildApplySuccessful"
events.GuildJoinSuccessful = "GuildJoinSuccessful"
events.GUILD_ASW_SIMPLE_GUILD_INFO_MESSAGE = "GUILD_ASW_SIMPLE_GUILD_INFO_MESSAGE"



----------------------------------[GuildLog 模块 事件]------------------------------------
events.GUILD_ASW_LOG_MESSAGE = "GUILD_ASW_LOG_MESSAGE"



----------------------------------[GuildShop 模块 事件]------------------------------------
events.GuildShop_Npc_Response_Guild_Shop_Buy = "GuildShop_Npc_Response_Guild_Shop_Buy"
events.GuildShop_Npc_Response_Guild_Random_Shop_Buy = "GuildShop_Npc_Response_Guild_Random_Shop_Buy"



----------------------------------[HitRat 模块 事件]------------------------------------
events.HTI_RAT_HAMMER_CLICK = "HTI_RAT_HAMMER_CLICK"
events.HIT_RAT_TILE_TOUCH = "HIT_RAT_TILE_TOUCH"



----------------------------------[IdentifyTreasureItem 模块 事件]------------------------------------



----------------------------------[LimitTimePackage 模块 事件]------------------------------------
events.LimitTime_GET_DO = "LimitTime_GET_DO"



----------------------------------[MainCity 模块 事件]------------------------------------



----------------------------------[ManorAppearance 模块 事件]------------------------------------
events.Manor_Appearance_Show_Layer = "Manor_Appearance_Show_Layer"
events.Manor_Appearance_Click_Tab = "Manor_Appearance_Click_Tab"
events.Manor_Appearance_Open_Main_View = "Manor_Appearance_Open_Main_View"
events.Manor_Appearance_Resp_Change_Build_Facade = "Manor_Appearance_Resp_Change_Build_Facade"
events.Manor_Appearance_Resp_Change_Mannor_Facade = "Manor_Appearance_Resp_Change_Mannor_Facade"
events.Manor_Appearance_Resp_Refresh_Mannor_Facade = "Manor_Appearance_Resp_Refresh_Mannor_Facade"



----------------------------------[ManorDiningTable 模块 事件]------------------------------------
events.Table_Show_Layer = "Table_Show_Layer"
events.Table_Click_Tab = "Table_Click_Tab"
events.Table_Open_Main_View = "Table_Open_Main_View"
events.Table_Refresh_View = "Table_Refresh_View"



----------------------------------[ManorDressUpShelf 模块 事件]------------------------------------
events.Manor_DressUp_Operation_Refresh = "Manor_DressUp_Operation_Refresh"



----------------------------------[ManorPedleryMaterial 模块 事件]------------------------------------



----------------------------------[ManorStarMap 模块 事件]------------------------------------



----------------------------------[Mercenary 模块 事件]------------------------------------



----------------------------------[Miracle 模块 事件]------------------------------------
events.Miracle_ResponsePrayer = "Miracle_ResponsePrayer"



----------------------------------[MonthlySign 模块 事件]------------------------------------
events.Sync_MonthlySign_Data = "Sync_MonthlySign_Data"
events.MonthlySign_In_Req = "MonthlySign_In_Req"
events.MonthlySign_Cliam_Req = "MonthlySign_Cliam_Req"
events.MonthlySign_In_Resp = "MonthlySign_In_Resp"
events.MonthlySign_Cliam_Resp = "MonthlySign_Cliam_Resp"



----------------------------------[NetworkEnvironmentTesting 模块 事件]------------------------------------



----------------------------------[Pet 模块 事件]------------------------------------



----------------------------------[PetGemStoneDevelopment 模块 事件]------------------------------------



----------------------------------[PetReincarnation 模块 事件]------------------------------------
events.PetReincarnation_Req_Pet_Reincarnation = "PetReincarnation_Req_Pet_Reincarnation"
events.PetReincarnation_Show_Detail_Layer = "PetReincarnation_Show_Detail_Layer"
events.PetReincarnation_Update_Pet_Layout = "PetReincarnation_Update_Pet_Layout"



----------------------------------[PetTreasure 模块 事件]------------------------------------
events.PetTreasure_Open_Main_view = "PetTreasure_Open_Main_view"
events.PetTreasure_Show_Layer = "PetTreasure_Show_Layer"
events.PetTreasure_Update_Layer = "PetTreasure_Update_Layer"
events.PetTreasure_Click_Tab = "PetTreasure_Click_Tab"
events.PetTreasure_Self_Embattle_Item_Touch = "PetTreasure_Self_Embattle_Item_Touch"
events.PetTreasure_Packet_Item_Touch = "PetTreasure_Packet_Item_Touch"
events.PetTreasure_Switch_Challenge_Records_Layer = "PetTreasure_Switch_Challenge_Records_Layer"
events.PetTreasure_Send_Gather_Data = "PetTreasure_Send_Gather_Data"
events.PetTreasure_Handle_Gather_Data = "PetTreasure_Handle_Gather_Data"
events.PetTreasure_Send_Callback_Gather_Pets = "PetTreasure_Send_Callback_Gather_Pets"
events.PetTreasure_Handle_Callback_Gather_Pets = "PetTreasure_Handle_Callback_Gather_Pets"
events.PetTreasure_Handle_Fragments_update = "PetTreasure_Handle_Fragments_update"
events.PetTreasure_Send_Gather_Pets = "PetTreasure_Send_Gather_Pets"
events.PetTreasure_Handle_Gather_Pets = "PetTreasure_Handle_Gather_Pets"
events.PetTreasure_Send_Battle_Info_Pets = "PetTreasure_Send_Battle_Info_Pets"
events.PetTreasure_Handle_Battle_Info_Pets = "PetTreasure_Handle_Battle_Info_Pets"
events.PetTreasure_Send_Battle_Pets = "PetTreasure_Send_Battle_Pets"
events.PetTreasure_Handle_Battle_Pets = "PetTreasure_Handle_Battle_Pets"
events.PetTreasure_Send_Fragment_Compound_Pets = "PetTreasure_Send_Fragment_Compound_Pets"
events.PetTreasure_Handle_Fragment_Compound_Pets = "PetTreasure_Handle_Fragment_Compound_Pets"
events.PetTreasure_Send_Battle_Record_Pets = "PetTreasure_Send_Battle_Record_Pets"
events.PetTreasure_Handle_Battle_Record_Pets = "PetTreasure_Handle_Battle_Record_Pets"
events.PetTreasure_Send_Battle_Revenge_Pets = "PetTreasure_Send_Battle_Revenge_Pets"
events.PetTreasure_Handle_Battle_Revenge_Pets = "PetTreasure_Handle_Battle_Revenge_Pets"
events.PetTreasure_Handle_Open_origin_Layer = "PetTreasure_Handle_Open_origin_Layer"
events.PetTreasure_Open_RecyclingShop_view = "PetTreasure_Open_RecyclingShop_view"
events.PetTreasure_RecyclingShop_Click_Tab = "PetTreasure_RecyclingShop_Click_Tab"
events.PetTreasure_RecyclingShop_Send_GoodsRecycle = "PetTreasure_RecyclingShop_Send_GoodsRecycle"
events.PetTreasure_RecyclingShop_Handle_GoodsRecycle = "PetTreasure_RecyclingShop_Handle_GoodsRecycle"
events.PetAdventure_Challenge = "PetAdventure_Challenge"
events.PetAdventure_Handle_Challenge_Callback = "PetAdventure_Handle_Challenge_Callback"
events.PetAdventure_Explore = "PetAdventure_Explore"
events.PetAdventure_Handle_Explore_Callback = "PetAdventure_Handle_Explore_Callback"
events.PetAdventure_Explore_Stop = "PetAdventure_Explore_Stop"
events.PetAdventure_Handle_Explore_Stop_Callback = "PetAdventure_Handle_Explore_Stop_Callback"
events.PetAdventure_Handle_Level_Selected = "PetAdventure_Handle_Level_Selected"
events.PetAdventure_Handle_Level_Guard_Data_REQ_Callback = "PetAdventure_Handle_Level_Guard_Data_REQ_Callback"
events.PetAdventure_Handle_Updata_Embattle_Layer = "PetAdventure_Handle_Updata_Embattle_Layer"
events.PetAdventure_Update_Explor_Layer = "PetAdventure_Update_Explor_Layer"
events.PetAdventure_REQ_Sync_PetAdv_Data = "PetAdventure_REQ_Sync_PetAdv_Data"
events.PetAdventure_REQ_Explore_Rewards = "PetAdventure_REQ_Explore_Rewards"
events.PetAdventure_Handle_Explore_Rewards_Callback = "PetAdventure_Handle_Explore_Rewards_Callback"
events.PetAdventure_Handle_Adventure_Show_Drop_List = "PetAdventure_Handle_Adventure_Show_Drop_List"



----------------------------------[PurpleUpgrade 模块 事件]------------------------------------
events.PurpleUpgrade_Show_Layer = "PurpleUpgrade_Show_Layer"
events.PurpleUpgrade_Click_Tab = "PurpleUpgrade_Click_Tab"
events.PurpleUpgrade_Open_Main_View = "PurpleUpgrade_Open_Main_View"
events.Primogem_On_Decompose_Succeed = "Primogem_On_Decompose_Succeed"
events.PrimogemShop_Exchange_Success = "PrimogemShop_Exchange_Success"
events.PrimogemShop_Refresh_Info = "PrimogemShop_Refresh_Info"



----------------------------------[Puzzle 模块 事件]------------------------------------
events.Puzzle_Click_Item = "Puzzle_Click_Item"
events.Puzzle_Create_List = "Puzzle_Create_List"
events.Puzzle_Send_Result_Message = "Puzzle_Send_Result_Message"
events.Puzzle_Handle_Result_Message = "Puzzle_Handle_Result_Message"
events.Puzzle_Show_ScoreNumBanner = "Puzzle_Show_ScoreNumBanner"



----------------------------------[QQGameMogul 模块 事件]------------------------------------
events.QQGame_Open_Game_Mogul = "QQGame_Open_Game_Mogul"
events.QQGame_Click_Tab = "QQGame_Click_Tab"
events.QQGame_Sync_Mogul_Claim_Data = "QQGame_Sync_Mogul_Claim_Data"
events.QQGame_Cliam_Mogul_Gift = "QQGame_Cliam_Mogul_Gift"
events.QQGame_Cliam_Mogul_Weekly_Gift = "QQGame_Cliam_Mogul_Weekly_Gift"
events.QQGame_Sync_Mogul_Level = "QQGame_Sync_Mogul_Level"
events.QQGame_Sync_Mogul_Score = "QQGame_Sync_Mogul_Score"
events.QQGame_Sync_Mogul_Discount = "QQGame_Sync_Mogul_Discount"
events.QQGame_Refresh_View = "QQGame_Refresh_View"
events.QQGame_Go_Recharge = "QQGame_Go_Recharge"
events.QQGame_Share_Privilege = "QQGame_Share_Privilege"
events.QQGame_Give_Coupon = "QQGame_Give_Coupon"
events.QQGame_Go_CS = "QQGame_Go_CS"



----------------------------------[QuickSideBar 模块 事件]------------------------------------



----------------------------------[Recast 模块 事件]------------------------------------
events.RecastRemoveLevel_Remove_Request = "RecastRemoveLevel_Remove_Request"
events.RecastRemoveLevel_Remove_Result = "RecastRemoveLevel_Remove_Result"
events.RecastRefine_Refine_Request = "RecastRefine_Refine_Request"
events.RecastRefine_Refine_Result = "RecastRefine_Refine_Result"
events.RecastRefine_ShowContent = "RecastRefine_ShowContent"
events.Recast_Bag_Drag_Began = "Recast_Bag_Drag_Began"
events.Recast_Bag_Drag_Moved = "Recast_Bag_Drag_Moved"
events.Recast_Bag_Drag_Ended = "Recast_Bag_Drag_Ended"
events.Recast_Refine_Grid_Drag_Out = "Recast_Refine_Grid_Drag_Out"
events.Recast_Do_Refine = "Recast_Do_Refine"
events.Recast_Suit_Transform_Show = "Recast_Suit_Transform_Show"
events.Recast_Suit_Transform_Drag_Out = "Recast_Suit_Transform_Drag_Out"
events.Recast_Do_Suit_Transform = "Recast_Do_Suit_Transform"
events.Recast_Suit_Transform_Target_Select = "Recast_Suit_Transform_Target_Select"



----------------------------------[Relic 模块 事件]------------------------------------



----------------------------------[RoleReincarnation 模块 事件]------------------------------------
events.RoleReincarnation_Req_Role_Reincarnation = "RoleReincarnation_Req_Role_Reincarnation"
events.RoleReincarnation_Show_Detail_Layer = "RoleReincarnation_Show_Detail_Layer"
events.RoleReincarnation_Update_Role_Layout = "RoleReincarnation_Update_Role_Layout"



----------------------------------[RuneMold 模块 事件]------------------------------------
events.Rune_Mold_ShowContent = "Rune_Mold_ShowContent"
events.Rune_Bag_Drag_Began = "Rune_Bag_Drag_Began"
events.Rune_Bag_Drag_Ended = "Rune_Bag_Drag_Ended"
events.Rune_Mold_Grid_Drag_Out = "Rune_Mold_Grid_Drag_Out"
events.Rune_Mold_On_Bag_Close = "Rune_Mold_On_Bag_Close"
events.Rune_Mold_On_Forging = "Rune_Mold_On_Forging"
events.Rune_Mold_On_Inlaid = "Rune_Mold_On_Inlaid"



----------------------------------[SFSign 模块 事件]------------------------------------



----------------------------------[Setting 模块 事件]------------------------------------
events.Setting_Area_Server_HandleChangeArea = "Setting_Area_Server_HandleChangeArea"
events.Setting_Area_Server_ReqAreaList = "Setting_Area_Server_ReqAreaList"
events.Setting_Area_Server_RespAreaList = "Setting_Area_Server_RespAreaList"



----------------------------------[SevenDays 模块 事件]------------------------------------
events.SevenDaysUpdateDataAndView = "SevenDaysUpdateDataAndView"
events.SevenDaysUpdateTitle = "SevenDaysUpdateTitle"



----------------------------------[Souvenir 模块 事件]------------------------------------
events.Souvenir_Resource_Change = "Souvenir_Resource_Change"
events.Souvenir_Close_Layer = "Souvenir_Close_Layer"



----------------------------------[StarPray 模块 事件]------------------------------------
events.StarPray_ChangeLayer = "StarPray_ChangeLayer"
events.StarPray_Bag_Touch_Begin = "StarPray_Bag_Touch_Begin"
events.StarPray_Bag_Touch_End = "StarPray_Bag_Touch_End"
events.StarPray_Equip_DoOneKey = "StarPray_Equip_DoOneKey"
events.StarPray_Equip_DoEquip = "StarPray_Equip_DoEquip"
events.StarPray_Swllow_DoSwllow = "StarPray_Swllow_DoSwllow"
events.StarPray_Swllow_DoOneKey = "StarPray_Swllow_DoOneKey"
events.StarPray_Swllow_Target_Touch = "StarPray_Swllow_Target_Touch"
events.StarPray_Swllow_Bag_Touch = "StarPray_Swllow_Bag_Touch"
events.StarPray_Swllow_SHOW_SETTING = "StarPray_Swllow_SHOW_SETTING"
events.StarPray_Swllow_SETTING_OK = "StarPray_Swllow_SETTING_OK"
events.StarPray_Swllow_SETTING_Cancel = "StarPray_Swllow_SETTING_Cancel"
events.StarPray_ShowShopView = "StarPray_ShowShopView"
events.StarPray_Swallow_Confirm = "StarPray_Swallow_Confirm"
events.StarPray_Shop_GetReward = "StarPray_Shop_GetReward"
events.StarPray_Shop_Ten_Click = "StarPray_Shop_Ten_Click"
events.StarPray_Swallow_Overflow = "StarPray_Swallow_Overflow"
events.StarPray_Change_Plate = "StarPray_Change_Plate"
events.StarPray_Show_Active_Attr_View = "StarPray_Show_Active_Attr_View"
events.StarPray_ActiveRune = "StarPray_ActiveRune"
events.StarPray_Upgrade = "StarPray_Upgrade"



----------------------------------[SuitTransformation 模块 事件]------------------------------------



----------------------------------[TradeActivity 模块 事件]------------------------------------
events.TradeActivity_Show_View = "TradeActivity_Show_View"
events.TradeActivity_Update_Layer = "TradeActivity_Update_Layer"
events.TradeActivity_Send_Buy_DailyGiftBag = "TradeActivity_Send_Buy_DailyGiftBag"
events.TradeActivity_Handle_Role_Level_Up = "TradeActivity_Handle_Role_Level_Up"
events.TradeActivity_Update_TradeActivity_TabList = "TradeActivity_Update_TradeActivity_TabList"



----------------------------------[UseMold 模块 事件]------------------------------------
events.UseMold_ShowContent = "UseMold_ShowContent"
events.UseMold_Bag_Drag_Began = "UseMold_Bag_Drag_Began"
events.UseMold_Bag_Drag_Moved = "UseMold_Bag_Drag_Moved"
events.UseMold_Bag_Drag_Ended = "UseMold_Bag_Drag_Ended"
events.UseMold_Grid_Drag_Out = "UseMold_Grid_Drag_Out"
events.UseMold_On_Mold_Used = "UseMold_On_Mold_Used"



----------------------------------[ViKing 模块 事件]------------------------------------



----------------------------------[WishPool 模块 事件]------------------------------------



----------------------------------[WorldBoss 模块 事件]------------------------------------
events.WorldBoss_Revive_Immediately = "WorldBoss_Revive_Immediately"
events.WorldBoss_Win_Quit = "WorldBoss_Win_Quit"
events.WorldBoss_BuyBuff_Touch = "WorldBoss_BuyBuff_Touch"
events.WorldBoss_Battle_Confirm = "WorldBoss_Battle_Confirm"



----------------------------------[ 公共 事件 ]------------------------------------
events.Update_Dock_Detail = "Update_Dock_Detail"                      --被模块[Dock]监听
events.Update_Dock_Upgrade_Progress = "Update_Dock_Upgrade_Progress"  --被模块[Dock]监听


return events