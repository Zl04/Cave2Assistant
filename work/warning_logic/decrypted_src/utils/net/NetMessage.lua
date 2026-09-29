--[[
协议：增加新的协议后，都需要更新宏定义
]]--

Net = Net or {}

-- 消息类别
Net.MessageCategory = {
    -- 内部系统
    INNER = {
        NAME      = "InnerSystem.INNERSYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.INNER_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },

    -- 内部系统 2
    INNER2 = {
        NAME      = "InnerSystem.INNERSYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.INNER_SYSTEM,
        CONNID    = Net.MAIN_TEXT_SERVER
    },

    -- 内部系统 3
    INNER3 = {
        NAME      = "InnerSystem.INNERSYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.INNER_SYSTEM,
        CONNID    = Net.MAIN_TEXT_SERVER2
    },

    -- 登陆
    LOGIN = {
        NAME      = "LoginSystem.LOGINSYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.LOGIN_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 角色
    ROLE = {
        NAME      = "RoleSystem.ROLE_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.ROLE_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 物品
    GOODS = {
        NAME      = "GoodsSystem.GOODS_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.GOODS_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- NPC
    NPC = {
        NAME      = "NPCSystem.NPC_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.NPC_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 组队
    TEAM = {
        NAME      = "TeamSystem.TEAM_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.TEAM_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 任务
    TASK = {
        NAME      = "TaskSystem.TASK_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.TASK_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 藏宝图
    TREASUREMAP = {
        NAME      = "TreasureMapSystem.TREASUREMAP_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.TREASUREMAP_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- GM
    GM = {
        NAME      = "GMSystem.GM_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.GM_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 排行榜
    RANK = {
        NAME      = "RankSystem.RANK_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.RANK_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 公会
    GUILD = {
        NAME      = "GuildSystem.GUILD_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.GUILD_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 公共
    COMMON = {
        NAME      = "CommonSystem.COMMON_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.COMMON_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 聊天
    CHAT = {
        NAME      = "ChatSystem.CHAT_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.CHAT_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 好友
    FRIEND = {
        NAME      = "FriendSystem.FRIEND_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.FRIEND_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 邮箱
    MAIL = {
        NAME      = "MailSystem.MAIL_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.MAIL_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 内购
    PURCHASE = {
        NAME      = "PurchaseSystem.PURCHASE_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.PURCHASE_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 运营活动
    ACTIVITY = {
        NAME      = "ActivitySystem.ACTIVITY_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.ACTIVITY_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 主要逻辑（后续新增roleSystem逻辑 都在这里面）
    LOGIC = {
        NAME      = "LogicSystem.LOGIC_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.LOGIC_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    -- 导师系统
    MENTOR = {
        NAME      = "TutorSystem.TUTOR_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.MENTOR_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    --宠物系统
    PET = {
        NAME      = "PetSystem.PET_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.PET_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    --宠物系统
    PLAY = {
        NAME      = "PlaySystem.PLAY_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.PLAY_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    --庄园
    MANOR = {
        NAME      = "ManorSystem.MANOR_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.MANOR_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    },
    --大航海
    BIGSAIL = {
        NAME      = "BigSailSystem.BigSail_SYSTEM_MESSAGE_TYPE",
        SECTION   = NetSection.BIGSAIL_SYSTEM,
        CONNID    = Net.MAIN_SERVER
    }
}
NetMessageCategory = Net.MessageCategory

-- 消息类型
-- CATEGORY：消息分类
-- HEAD：消息头名字
-- BODY：消息体名字
-- NO：消息编号
Net.MessageType = {
    -- 响应：连接成功
    CONNECT_COMPLETE = {
        CATEGORY  = NetMessageCategory.INNER,
        HEAD      = "",
        BODY      = "",
        NO        = 1,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：连接失败
    CONNECT_FAIL = {
        CATEGORY  = NetMessageCategory.INNER,
        HEAD      = "",
        BODY      = "",
        NO        = 2,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：连接断开
    CONNECT_DISCONNECTED = {
        CATEGORY  = NetMessageCategory.INNER,
        HEAD      = "",
        BODY      = "",
        NO        = 3,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：心跳包
    CONNECT_HEART_BEAT = {
        CATEGORY  = NetMessageCategory.INNER,
        HEAD      = "",
        BODY      = "",
        NO        = 4,
        DIRECTION = NetDirection.NONE
    },
    
    -- 发送间隔
    CONNECT_SEND_INTERVAL = {
        CATEGORY  = NetMessageCategory.INNER,
        HEAD      = "",
        BODY      = "",
        NO        = 5,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求：登陆验证
    LOGIN_VERIFY = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_VerifyMessage",
        BODY      = "LoginSystem.VerifyMessage",
        NO        = 0,
        DIRECTION = NetDirection.CD
    },
    
    -- 登录验证返回
    LOGIN_REPLY_VERIFY_RESULT = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_ReplyVerifyResultMessage",
        BODY      = "LoginSystem.ReplyVerifyResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    -- -- 请求：登陆的账号验证   TODO 删除
    -- LOGIN_ACCOUNT_VERIFY = {
    --     CATEGORY  = NetMessageCategory.LOGIN,
    --     HEAD      = "Type_ReqAccountVerifyMessage",
    --     BODY      = "LoginSystem.ReqAccountVerifyMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.CV
    -- },
    -- -- 请求：登陆的账号验证返回  TODO 删除
    -- LOGIN_ACCOUNT_VERIFY_RESP = {
    --     CATEGORY  = NetMessageCategory.LOGIN,
    --     HEAD      = "Type_ResAccountVerifyMessage",
    --     BODY      = "LoginSystem.ResAccountVerifyMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    -- -- 响应：验证失败  TODO 删除
    -- LOGIN_VERIFY_FAILED = {
    --     CATEGORY  = NetMessageCategory.LOGIN,
    --     HEAD      = "Type_VerifyFailedMessage",
    --     BODY      = "LoginSystem.VerifyFailedMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    -- -- 响应：获取角色列表和账号常规信息  TODO 删掉
    -- LOGIN_GET_HERO_LIST = {
    --     CATEGORY  = NetMessageCategory.LOGIN,
    --     HEAD      = "Type_HeroListMessage",
    --     BODY      = "LoginSystem.HeroListMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    -- -- 响应：选择角色   TODO 删掉
    -- LOGIN_SELECT_HERO = {
    --     CATEGORY  = NetMessageCategory.LOGIN,
    --     HEAD      = "Type_SelectHeroMessage",
    --     BODY      = "LoginSystem.SelectHeroMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.CD
    -- },
    
    -- 帐号无英雄消息 (DC)  无消息内容
    LOGIN_NO_HERO = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_NoHeroMessage",
        BODY      = "LoginSystem.NoHeroMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 创建英雄消息 (CD)
    LOGIN_CREATE_HERO = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_CreateHeroMessage",
        BODY      = "LoginSystem.CreateHeroMessage",
        NO        = 0,
        DIRECTION = NetDirection.CD
    },
    
    -- 回复创建英雄结果消息(DC)
    LOGIN_REPLY_CREATE_HERO_RESULT = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_ReplyCreateHeroResultMessage",
        BODY      = "LoginSystem.ReplyCreateHeroResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },  
    
    -- 退出游戏 (CG) 无消息内容
    LOGIN_LOGIN_OUT_GAME = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_LoginOutGameMessage",
        BODY      = "LoginSystem.LoginOutGameMessage",
        NO        = 0,
        DIRECTION = NetDirection.CG
    },  
    
    -- 请求账号绑定 CD
    LOGIN_REQ_BIND_ACCOUNT = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_ReqBindAccountMessage",
        BODY      = "LoginSystem.ReqBindAccountMessage",
        NO        = 0,
        DIRECTION = NetDirection.CD
    },  
    
    -- 账号绑定结果 DC
    LOGIN_REPLY_BIND_ACCOUNT_RESULT = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_ReplyBindAccountResultMessage",
        BODY      = "LoginSystem.ReplyBindAccountResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },  
    
    -- 防沉迷数据下发
    LOGIN_ADDICTION_RESULT = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_NotifyAddictionInfoMessage",
        BODY      = "LoginSystem.NotifyAddictionInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },  
    
    -- SC 来，做点事儿
    LOGIN_NOTIFY_CLIENT_DO_SOMETHING_MESSAGE = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_NotifyClientDoSomethingMessage",
        BODY      = "LoginSystem.NotifyClientDoSomethingMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },  
    
    -- 请求逻辑分区数据
    LOGIN_REQ_AREA_LIST = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_ReqAreaListMessage",
        BODY      = "LoginSystem.ReqAreaListMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },  
    
    -- 返回服务器逻辑分区数据
    LOGIN_RESP_AREA_LIST = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_RespAreaListMessage",
        BODY      = "LoginSystem.AreaListMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },  
    
    -- 响应：玩家完成初始化  AS SC
    ROLE_HERO_FINISH_INIT = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroFinishInitMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求礼物
    ROLE_REQUEST_GIFT = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestGiftMessage",
        BODY      = "RoleSystem.RequestGiftMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 请求礼物返回结果
    ROLE_RESPONSE_GIFT = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseGiftMessage",
        BODY      = "RoleSystem.ResponseGiftMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 编辑昵称
    ROLE_EDIT_NICK_NAME = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_EditNicknameMessage",
        BODY      = "RoleSystem.EditNicknameMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 处理修改昵称返回值
    ROLE_RESPONSE_EDIT_NICK_NAME = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseEditNicknameMessage",
        BODY      = "RoleSystem.ResponseEditNicknameMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：通知客户端加载场景 SC
    ROLE_LOAD_SCENE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CLoadSceneMessage",
        BODY      = "RoleSystem.CLoadSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：玩家进入场景
    ROLE_ENTER_SCENE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_EnterSceneMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求：玩家进入洞穴
    ROLE_ENTER_CAVE_SCENE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_EnterCaveSceneMessage",
        BODY      = "RoleSystem.EnterCaveSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --响应： 玩家进入洞窟返回
    ROLE_ENTER_CAVE_SCENE_RESPONSE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_EnterCaveSceneResultMessage",
        BODY      = "RoleSystem.EnterCaveSceneResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 响应：通知客户端已探索的视区 SC
    ROLE_EXPLORED_VIEWAREA = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyExploredViewAreaMessage",
        BODY      = "RoleSystem.NotifyExploredViewAreaMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：通知客户端转变为可到达的地图块 SC
    ROLE_TRANSFORMED_GROUND = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyTransformedGroundMessage",
        BODY      = "RoleSystem.NotifyTransformedGroundMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：服务端通知客户端英雄数据,然后客户端根据数据生成英雄到内存
    ROLE_INIT_HERO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_InitHeroMessage",
        BODY      = "RoleSystem.InitHeroMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    ROLE_INIT_HERO_SYNC = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncHeroAttrMessage",
        BODY      = "RoleSystem.InitHeroMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    -- 响应：属性改变
    ROLE_ATTR_CHANGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_AttrChangeMessage",
        BODY      = "RoleSystem.AttrChangeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：同屏英雄消息
    ROLE_SCREEN_HERO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ScreenHeroMessage",
        BODY      = "RoleSystem.ScreenHeroMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：详细英雄消息
    ROLE_RESPONSE_HERO_DETAIL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseHeroDetailMessage",
        BODY      = "RoleSystem.ResponseHeroDetailMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求：详细英雄消息
    ROLE_REQUEST_HERO_DETAIL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestHeroDetailMessage",
        BODY      = "RoleSystem.RequestHeroDetailMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 请求：详细英雄消息 排行榜请求
    ROLE_REQUEST_HERO_DETAIL_FROM_RANK = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestHeroDetailMessage",
        BODY      = "RoleSystem.RequestHeroDetailMessage",
        NO        = 0,
        DIRECTION = NetDirection.CR
    },
    
    -- 响应：全局怪物消息
    ROLE_GLOBAL_MONSTER = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_GlobalMonsterMessage",
        BODY      = "RoleSystem.GlobalMonsterMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：同屏怪物消息
    ROLE_SCREEN_MONSTER = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ScreenMonsterMessage",
        BODY      = "RoleSystem.ScreenMonsterMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：通知小boss 封印解封信息
    LITTLE_BOSS_SEAL_INFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfLittleBossSealInfoMessage",
        BODY      = "RoleSystem.NtfLittleBossSealInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --  -- 响应：全局宝箱消息
    -- ROLE_GLOBAL_BOX = {
    --     CATEGORY  = NetMessageCategory.ROLE,
    --     HEAD      = "Type_GlobalBoxMessage",
    --     BODY      = "RoleSystem.GlobalBoxMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    -- -- 响应：同屏宝箱消息
    -- ROLE_SCREEN_BOX = {
    --     CATEGORY  = NetMessageCategory.ROLE,
    --     HEAD      = "Type_ScreenBoxMessage",
    --     BODY      = "RoleSystem.ScreenBoxMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    -- -- 响应：同屏钱袋消息
    -- ROLE_SCREEN_GOLDBAG = {
    --     CATEGORY  = NetMessageCategory.ROLE,
    --     HEAD      = "Type_ScreenGoldBagMessage",
    --     BODY      = "RoleSystem.ScreenGoldBagMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    -- -- SC 全局钱袋消息
    -- ROLE_GLOBAL_GOLDBAG = {
    --     CATEGORY = NetMessageCategory.ROLE,
    --     HEAD     = "Type_GlobalGoldBagMessage",
    --     BODY     = "RoleSystem.GlobalGoldBagMessage",
    --     NO       = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    -- 响应：移除同屏角色消息
    ROLE_REMOVE_SCREEN_ROLE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_RemoveScreenRoleMessage",
        BODY     = "RoleSystem.RemoveScreenRoleMessage",
        NO       = 0
    },
    
    -- -- SC 同屏传送门消息
    -- ROLE_SCREEN_TRANSDOOR = {
    --     CATEGORY = NetMessageCategory.ROLE,
    --     HEAD     = "Type_ScreenTransDoorMessage",
    --     BODY     = "RoleSystem.ScreenTransDoorMessage",
    --     NO       = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    -- -- SC 全局传送门消息
    -- ROLE_GLOBAL_TRANSDOOR = {
    --     CATEGORY = NetMessageCategory.ROLE,
    --     HEAD     = "Type_GlobalTransDoorMessage",
    --     BODY     = "RoleSystem.GlobalTransDoorMessage",
    --     NO       = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    --SC 同屏触发NPC消息
    ROLE_SCREEN_TRIGGER_NPC = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ScreenTriggerNPCMessage",
        BODY     = "RoleSystem.ScreenTriggerNPCMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --SC 全局触发NPC消息
    ROLE_GLOBAL_TRIGGER_NPC = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_GlobalTriggerNPCMessage",
        BODY     = "RoleSystem.GlobalTriggerNPCMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：怪物详情消息
    ROLE_DETAIL_MONSTER = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_DetailMonsterMessage",
        BODY      = "RoleSystem.DetailMonsterMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 英雄开始移动
    ROLE_HERO_START_MOVE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroStartMoveMessage",
        BODY      = "RoleSystem.HeroStartMoveMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 英雄停止移动
    ROLE_HERO_STOP_MOVE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroStopMoveMessage",
        BODY      = "RoleSystem.HeroStopMoveMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 响应：通知英雄（队友）开始移动
    ROLE_NOTIFY_HERO_START_MOVE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyHeroStartMoveMessage",
        BODY      = "RoleSystem.NotifyHeroStartMoveMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：通知英雄（队友）停止移动
    ROLE_NOTIFY_HERO_STOP_MOVE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyHeroStopMoveMessage",
        BODY      = "RoleSystem.NotifyHeroStopMoveMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应：服务器通知客户端英雄（仅玩家）位置同步
    ROLE_HERO_POSITION_SYNC = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroPositionSyncMessage",
        BODY      = "RoleSystem.HeroPositionSyncMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 英雄进入战斗
    ROLE_HERO_START_BATTLE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroStartBattleMessage",
        BODY      = "RoleSystem.HeroStartBattleMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 英雄进入战斗结果
    ROLE_HERO_START_BATTLE_RESULT = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroStartBattleResultMessage",
        BODY      = "RoleSystem.HeroStartBattleResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 切换战斗目标
    ROLE_HERO_SWITCH_BATTLE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroSwitchBattleMessage",
        BODY      = "RoleSystem.HeroSwitchBattleMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 切换战斗目标结果
    ROLE_HERO_SWITCH_BATTLE_RESULT = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroSwitchBattleResultMessage",
        BODY      = "RoleSystem.HeroSwitchBattleResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 同屏或者队友英雄进入战斗
    ROLE_SCREEN_HERO_START_BATTLE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ScreenHeroStartBattleMessage",
        BODY      = "RoleSystem.ScreenHeroStartBattleMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 英雄使用技能（包括普通技能）,这里设计为在开始战斗使用普攻技能，技能，在次使用普攻技能，三种情况才触发。
    ROLE_HERO_USE_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroUseSkillMessage",
        BODY      = "RoleSystem.HeroUseSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 使用技能返回结果
    ROLE_HERO_USE_SKILL_RESULT = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroUseSkillResultMessage",
        BODY      = "RoleSystem.HeroUseSkillResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 通知客户端角色,对某个目标使用技能Miss
    ROLE_ROLE_SKILL_MISS = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleSkillMissMessage",
        BODY      = "RoleSystem.RoleSkillMissMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 通知角色使用技能
    ROLE_NOTIFY_ROLE_SKILL_STATUS = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyRoleSkillStatusMessage",
        BODY      = "RoleSystem.NotifyRoleSkillStatusMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 通知同屏角色技能打断
    ROLE_NOTIFY_ROLE_SKILL_BREAK = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyRoleSkillBreakMessage",
        BODY      = "RoleSystem.NotifyRoleSkillBreakMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 通知玩家技能开始效果
    ROLE_NOTIFY_ROLE_SKILL_START_EFFECT = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyRoleSkillStartEffectMessage",
        BODY      = "RoleSystem.NotifyRoleSkillStartEffectMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 通知玩家技能冷却
    ROLE_NOTIFY_ROLE_SKILL_COOLDOWN = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyRoleSkillCooldownMessage",
        BODY      = "RoleSystem.NotifyRoleSkillCooldownMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 通知玩家技能的呤唱时间
    ROLE_NOTIFY_ROLE_SKILL_ACCUMULATE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyRoleSkillAccumulateMessage",
        BODY      = "RoleSystem.NotifyRoleSkillAccumulateMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 角色当前buff列表
    ROLE_HERO_BUFF_LIST = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_HeroBuffListMessage",
        BODY     = "RoleSystem.HeroBuffListMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 角色受到的BUFF
    ROLE_ROLE_ADD_BUFF = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleAddBuffMessage",
        BODY      = "RoleSystem.RoleAddBuffMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 角色受到的效果(主要是表现)
    ROLE_ROLE_ADD_EFFECT = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleAddEffectMessage",
        BODY      = "RoleSystem.RoleAddEffectMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 角色移除的BUFF
    ROLE_ROLE_REMOVE_BUFF = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleRemoveBuffMessage",
        BODY      = "RoleSystem.RoleRemoveBuffMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 玩家逃跑
    ROLE_HERO_ESCAPE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroEscapeMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 玩家逃跑失败
    ROLE_HERO_ESCAPE_FAILED = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroEscapeFailedMessage",
        BODY      = "RoleSystem.HeroEscapeFailedMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 通知同屏英雄逃跑
    ROLE_NOTIFY_HERO_ESCAPE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyHeroEscapeMessage",
        BODY      = "RoleSystem.NotifyHeroEscapeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 通知(全屏)取消逃跑
    ROLE_NOTIFY_HERO_CANCEL_ESCAPE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyHeroCancelEscapeMessage",
        BODY      = "RoleSystem.NotifyHeroCancelEscapeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 角色离开战斗
    ROLE_LEAVE_BATTLE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleLeaveBattleMessage",
        BODY      = "RoleSystem.RoleLeaveBattleMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 角色死亡
    ROLE_DEAD = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleDeadMessage",
        BODY      = "RoleSystem.RoleDeadMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 改变地块为可到达
    ROLE_TRANSFORM_TILE_TO_REACHABLE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleTransformTileToReachableMessage",
        BODY      = "RoleSystem.RoleTransformTileToReachableMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 地图全开
    ROLE_I_SEE_DEAD_PEOPLE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ISeeDeadPeopleMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 显示小地图
    ROLE_SHOW_MINI_MAP_ICON = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ManipulateMiniMapIconMessage",
        BODY      = "RoleSystem.ManipulateMiniMapIconMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --SC 瞬间移动技能
    ROLE_HERO_TRANSFER = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroTransferMessage",
        BODY      = "RoleSystem.HeroTransferMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --SC 开始场景转换
    ROLE_BEGIN_TRANS_SCENE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_BeginTransSceneMessage",
        BODY      = "RoleSystem.BeginTransSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 结束场景转换
    ROLE_END_TRANS_SCENE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_EndTransSceneMessage",
        BODY      = "RoleSystem.EndTransSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 密室门打开
    ROLE_CHAMBER_OPEN = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ChamberOpenMessage",
        BODY      = "RoleSystem.ChamberOpenMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 放弃复活
    ROLE_DEAD_SELECTION = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_HeroDeadSelectionMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 请求复活-包括队友帮助复活
    ROLE_REQUEST_REVIVE_HERO = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_RequestReviveHeroMessage",
        BODY     = "RoleSystem.RequestReviveHeroMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 请求购买buff worldboss
    ROLE_WORLDBOSS_BUY_BUFF_REQUEST = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_CsReqWorldBossBuyBuffMessage",
        BODY     = "RoleSystem.CsReqWorldBossBuyBuffMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- 请求购买buff worldboss
    ROLE_WORLDBOSS_BUY_BUFF_RESPONSE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_CsRspWorldBossBuyBuffMessage",
        BODY     = "RoleSystem.CsRspWorldBossBuyBuffMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 世界boss 数据
    ROLE_WORLDBOSS_DATA_INIT = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_WorldBossDataMessage",
        BODY     = "RoleSystem.WorldBossData",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 复活返回状态--队友都会收到
    ROLE_RESPONSE_REVIVE_HERO = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ResponseReviveHeroMessage",
        BODY     = "RoleSystem.ResponseReviveHeroMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 复活完成
    ROLE_REVIVE_HERO_COMPLETE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ReviveHeroCompleteMessage",
        BODY     = "RoleSystem.ReviveHeroCompleteMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 移除所有怪物指定词缀
    ROLE_REMOVE_AFFIX_FOR_ALL_MONSTER = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_RemoveAffixForAllMonsterMessage",
        BODY     = "RoleSystem.RemoveAffixForAllMonsterMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 角色升级
    ROLE_ROLE_LEVEL_UP = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_HeroLevelUpMessage",
        BODY     = "RoleSystem.HeroLevelUpMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 放弃存档直接回城
    ROLE_GIVE_UP_SAVE_BACK_TOWN = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_GiveUpSaveBackTownMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 开始BOSS剧情
    ROLE_BOSS_BEGIN_SCENARIO = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_BeginBossScenarioMessage",
        BODY     = "RoleSystem.BeginBossScenarioMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 结束BOSS剧情
    ROLE_BOSS_END_SCENARIO= {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_EndBossScenarioMessage",
        BODY     = "RoleSystem.EndBossScenarioMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 跳过BOSS剧情
    ROLE_BOSS_SKIP_SCENARIO = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_SkipBossScenarioMessage",
        BODY     = "RoleSystem.SkipBossScenarioMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 登录场景结束
    ROLE_END_LOGIN_SCENE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_EndLoginSceneMessage",
        BODY     = "RoleSystem.EndLoginSceneMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 同屏脸改变
    ROLE_SCREEN_FACE_CHANGE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ScreenFaceChangedMessage",
        BODY     = "RoleSystem.ScreenFaceChangedMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 处理解锁难度  gm 工具请求返回）
    ROLE_UNLOCK_CAVE_MODE_DIFFCULTY = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_UnlockCaveModeDiffcultyMessage",
        BODY     = "RoleSystem.UnlockCaveModeDiffcultyMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 通知解锁难度
    ROLE_NOTIFY_UNLOCK_CAVE_MODE_DIFFCULTY = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_NotifyUnlockCaveModeDifficultyMessage",
        BODY     = "RoleSystem.NotifyUnlockCaveModeDifficultyMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 通知解锁存档点
    ROLE_NOTIFY_UNLOCK_CHECKPOINT = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_NotifyUnlockCheckpointMessage",
        BODY     = "RoleSystem.NotifyUnlockCheckpointMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 跳转到某层
    ROLE_TEST_GOTO_LEVEL = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_TestGoToLevel",
        BODY     = "RoleSystem.TestGoToLevel",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 客户端发起对时 （无消息内容）
    ROLE_SYNC_TIME_REQUEST = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_SyncTimeRequestMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 服务器返回对时
    ROLE_SYNC_TIME_ANSWER = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_SyncTimeAnswerMessage",
        BODY     = "RoleSystem.SyncTimeAnswerMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 结束对时（仅由服务器发起）
    ROLE_SYNC_TIME_END = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_SyncTimeEndMessage",
        BODY     = "RoleSystem.SyncTimeEndMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- SC 触发怪物
    ROLE_TRIGGER_MONSTER = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_TriggerMonsterMessage",
        BODY     = "RoleSystem.TriggerMonsterMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 英雄当前实装技能列表
    SKILL_INIT_SKILL = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_HeroSkillListMessage",
        BODY     = "RoleSystem.HeroSkillListMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- -- SC 替代英雄技能
    -- SKILL_REPLACE_SKILL = {
    --     CATEGORY = NetMessageCategory.ROLE,
    --     HEAD     = "Type_HeroReplaceSkillMessage",
    --     BODY     = "RoleSystem.HeroReplaceSkillMessage",
    --     NO       = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    -- SC 英雄新增技能
    ROLE_HERO_ADD_SKILL = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_HeroAddSkillMessage",
        BODY     = "RoleSystem.HeroAddSkillMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 英雄删除技能
    ROLE_HERO_DELETE_SKILL = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_HeroRemoveSkillMessage",
        BODY     = "RoleSystem.HeroRemoveSkillMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 技能组改变消息
    ROLE_HERO_SKILL_GROUP_CHANGE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_HeroSkillGroupChangeMessage",
        BODY     = "RoleSystem.HeroSkillGroupChangeMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --SC接收技能树信息
    ROLE_HERO_SET_STUDY_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroSetStudySkillMessage",
        BODY      = "RoleSystem.HeroSetStudySkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CS 英雄学习技能
    ROLE_HERO_STUDY_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroStudySkillMessage",
        BODY      = "RoleSystem.HeroStudySkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    --CS 英雄设置学习技能
    ROLE_HERO_RESET_STUDY_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroResetStudySkillMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 英雄重置学习技能完成
    ROLE_FINISH_HERO_RESET_STUDY_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_FinishHeroResetStudySkillMessage",
        BODY      = "RoleSystem.FinishHeroResetStudySkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 学习技能反馈
    ROLE_RESPONSE_CODE_HERO_STUDY_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseCodeHeroStudySkillMessage",
        BODY      = "RoleSystem.ResponseCodeHeroStudySkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    --SC 通知技能等级变化消息
    ROLE_NOTICE_SKILL_LV_VARIATION = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NoticeSkillLvVariationMessage",
        BODY      = "RoleSystem.NoticeSkillLvVariationMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 玩家成就点数
    ROLE_ACHIEVEMENT_DATA_UPDATE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroAchieveMentDataMessage",
        BODY      = "RoleSystem.HeroAchieveMentDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 刷新所有技能CD消息
    ROLE_REFRESH_ALL_SKILL_CD = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RefreshAllSkillCDMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    NEED_USER_CONFIG_FIGHTING_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NeedUserConfigFightSkillMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    -- SC 刷新某类buff消息
    ROLE_REFRESH_BUFF_BY_KIND = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RefreshBuffByKindMessage",
        BODY      = "RoleSystem.RefreshBuffByKindMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 刷新某类buff消息
    ROLE_REFRESH_BUFF_BY_EFFECT_TYPE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RefreshBuffByEffectTypeMessage",
        BODY      = "RoleSystem.RefreshBuffByEffectTypeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    -- 根据实例ID刷新buff
    ROLE_REFRESH_BUFF_INST_ID = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RefreshBuffByInstIDMessage",
        BODY      = "RoleSystem.RefreshBuffByInstIDMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 密室门解锁
    ROLE_CHAMBER_ENTRANCE_UNLOCK = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ChamberEntranceUnlockMessage",
        BODY     = "RoleSystem.ChamberEntranceUnlockMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 给玩家发送位置信号
    ROLE_SEND_COORD_SIGNAL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifySignalingMessage",
        BODY      = "RoleSystem.NotifySignalingMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 战斗功能标记改变消息
    ROLE_FUNCTION_FLAG_CHANGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_FunctionFlagChangeMessage",
        BODY      = "RoleSystem.FunctionFlagChangeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 技能相关标记改变消息
    ROLE_SKILL_RELATED_FLAG_CHANGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SkillRelatedFlagChangeMessage",
        BODY      = "RoleSystem.SkillRelatedFlagChangeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 通知客户端图鉴解锁
    ROLE_POKEDEX_UNLOCK = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_PokedexUnlockMessage",
        BODY      = "RoleSystem.PokedexUnlockMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 图鉴存档数据
    ROLE_POKEDEX_ARCHIVE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_PokedexArchiveMessage",
        BODY      = "RoleSystem.PokedexArchiveMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 快捷表情
    ROLE_SEND_EXPRESSION = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SendEmoticonMessage",
        BODY      = "RoleSystem.SendEmoticonMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 快捷表情
    ROLE_RECIVIVE_EXPRESSION = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ScreenEmoticonMessage",
        BODY      = "RoleSystem.ScreenEmoticonMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 技能参数修改
    ROLE_NOTICE_SKILL_VARIATION = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NoticeSkillVariationMessage",
        BODY      = "RoleSystem.NoticeSkillVariationMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --开始或继续一个秘境阶段
    ROLE_START_OR_RESUME_DUNGEON_STAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_StartOrResumeDungeonStageMessage",
        BODY      = "RoleSystem.StartOrResumeDungeonStageMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --完成一个秘境阶段
    ROLE_COMPLETE_DUNGEON_STAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CompleteDungeonStageMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --设置请求隐藏头盔
    ROLE_REQUEST_HIDE_HELMET = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestHideHelmetMessage",
        BODY      = "RoleSystem.RequestHideHelmetMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- -- 趣味数据
    -- ROLE_FUNNY_RECORD = {
    --     CATEGORY  = NetMessageCategory.ROLE,
    --     HEAD      = "Type_FunnyRecordMessage",
    --     BODY      = "RoleSystem.FunnyRecordMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    --解锁 功能
    ROLE_NOTIFY_UNLOCK_FUNCTION = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NoticeFunctionUnlockMessage",
        BODY      = "RoleSystem.NoticeFunctionUnlockMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --客户端分享消息
    ROLE_CLIENT_SHARE_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CliShareMessage",
        BODY      = "RoleSystem.CliShareMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --客户端完成任务消息
    ROLE_CLIENT_FINISH_TASK_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_FinishTaskReq",
        BODY      = "RoleSystem.FinishTaskReq",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    --答题系统
    ROLE_CLIENT_HERO_ANSWERDATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroAnswerDataMessage",
        BODY      = "RoleSystem.HeroAnswerDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    ROLE_CLIENT_REQUEST_ANSWER_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestAnswerMessage",
        BODY      = "RoleSystem.RequestAnswerMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    ROLE_CLIENT_RESPONSE_ANSWER_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseAnswerMessage",
        BODY      = "RoleSystem.ResponseAnswerMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 请求取消BUFF
    ROLE_CLIENT_REQUEST_REMOVE_BUFF_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqRemoveBuffMessage",
        BODY      = "RoleSystem.ReqRemoveBuffMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    --客户端新手引导消息
    ROLE_STORY_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_StoryDataMessage",
        BODY      = "RoleSystem.StoryDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    --请求获取 大秘境赛季奖励
    RECIVE_DUNGEON_SEASON_REWARD_REQUEST = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReceiveDungeonSeasonRewardMessage",
        BODY      = "RoleSystem.ReceiveDungeonSeasonRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    --获取 大秘境赛季奖励 响应
    RECIVE_DUNGEON_SEASON_REWARD_REPONSE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReceiveDungeonSeasonRewardResultMessage",
        BODY      = "RoleSystem.ReceiveDungeonSeasonRewardResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    --SC 通知大秘境赛季数据    
    NOTIFY_DUNGEON_SEASON_ALL_DATA = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyDungeonSeasonDataMessage",
        BODY      = "RoleSystem.NotifyDungeonSeasonDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 通知大秘境赛季开关改变
    NOTIFY_DUNGEON_SEASON_ENTRANCE_STATUS_DATA = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyDungeonEntranceStatusMessage",
        BODY      = "RoleSystem.NotifyDungeonEntranceStatusMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 玩家趣味数据
    REVICE_FUNNY_RECORD_DATA = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_FunnyRecordMessage",
        BODY      = "RoleSystem.FunnyRecordMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 角色系统错误处理
    ROLE_RESPONSE_SYSTEM_ERROR = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseSystemErrorMessage",
        BODY      = "RoleSystem.ResponseSystemErrorMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 同步天气系统
    WITHER_SYSTEM_SYNC = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncWeatherMessage",
        BODY      = "RoleSystem.SyncWeatherMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 发送系统消息
    ROLE_NOTICE_SYSTEM_MSG = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NoticeSystemMsgMessage",
        BODY      = "RoleSystem.NoticeSystemMsgMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 请求改变城镇频道消息
    ROLE_REQUEST_CHANGE_TOWNCHANNEL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestChangeTownChannelMessage",
        BODY      = "RoleSystem.RequestChangeTownChannelMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 回复改变城镇频道消息
    ROLE_RESPONSE_CHANGE_TOWNCHANNEL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseChangeTownChannelMessage",
        BODY      = "RoleSystem.ResponseChangeTownChannelMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 大秘境传送门解锁
    ROLE_DUNGEON_UNLOCK_TRANSDOOR = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_DungeonUnlockTransDoorMessage",
        BODY      = "RoleSystem.DungeonUnlockTransDoorMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 增加大秘境时间
    ROLE_DUNGEON_SUPPLEMENT_DURATION = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_DungeonSupplementDurationMessage",
        BODY      = "RoleSystem.DungeonSupplementDurationMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --特殊事件数据下发
    ROLE_RESPONSE_HERO_CAVE_DATA = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroCaveSchemeDataMessage",
        BODY      = "RoleSystem.HeroCaveSchemeDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --请求特殊事件全量数据
    ROLE_GETALL_HERO_SPECIAL_EVENT_REQUEST = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroCaveRequestSchemeDataMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --刷新特殊事件请求
    ROLE_REFRESH_HERO_SPECIAL_EVENT_REQUEST = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroCaveRequestRefreshSchemeMessage",
        BODY      = "RoleSystem.HeroCaveRequestRefreshSchemeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --刷新特殊事件响应
    ROLE_REFRESH_HERO_SPECIAL_EVENT_RESPONSE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroCaveResponseRefreshSchemeMessage",
        BODY      = "RoleSystem.HeroCaveResponseRefreshSchemeMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --获取商店抽宝石全量数据
    ROLE_GEMSTONE_SHOP_RECORD_RESPONSE = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_GemStoneShopRecordMessage",
        BODY      = "RoleSystem.GemStoneShopRecordMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --服务器推送已拥有称号ID列表
    ROLE_HERO_TITLE_LIST = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroTitleListMessage",
        BODY      = "RoleSystem.HeroTitleListMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --服务器推送已拥有称号ID列表
    ROLE_HERO_SKILL_CLOSED_MESSAGE = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SkillClosedMessage",
        BODY      = "RoleSystem.SkillClosedMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    --修改现在佩戴称号请求
    ROLE_HERO_CHANGE_TITLE_REQUEST = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestChangeHeroEquipTitleMessage",
        BODY      = "RoleSystem.RequestChangeHeroEquipTitleMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --修改现在佩戴称号回复
    ROLE_HERO_CHANGE_TITLE_RESPONSE = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseChangeHeroEquipTitleMessage",
        BODY      = "RoleSystem.ResponseChangeHeroEquipTitleMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 通知
    ROLE_NOTIFY_MASTER_START_USE_SKILL = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyMasterStartUseSkillMessage",
        BODY      = "RoleSystem.NotifyMasterStartUseSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 通知技能等级修改列表，全量更新
    ROLE_NOTIFY_SKILL_CHANGE_LV_LIST = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NoticeSkillChangeLVListMessage",
        BODY      = "RoleSystem.NoticeSkillChangeLVListMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    --通知天赋技能集合
    ROLE_NOTIFY_ROLE_TALENT_LIST = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NoticeRoleTalentListMessage",
        BODY      = "RoleSystem.NoticeRoleTalentListMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    -- 天赋技能加点请求
    ROLE_ADD_ROLE_TALENT_REQ = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestAddRoleTalentMessage",
        BODY      = "RoleSystem.RequestAddRoleTalentMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 天赋技能升级请求
    ROLE_UPGRADE_ROLE_TALENT_REQ = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestUpgradeRoleTalentMessage",
        BODY      = "RoleSystem.RequestUpgradeRoleTalentMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 处理活动战斗的信息
    ROLE_NTF_ACTIVITY_BOSS_INFO = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfActivityBossInfoMessage",
        BODY      = "RoleSystem.NtfActivityBossInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 处理活动战斗的信息
    ROLE_CS_WORLD_BOSS_INFO = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsNtfWorldBossMessage",
        BODY      = "RoleSystem.CsNtfWorldBossMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 处理buff的处理逻辑
    ROLE_BUFF_REMAIN_TIME = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_UpdateBuffRemainTimeMessage",
        BODY      = "RoleSystem.UpdateBuffRemainTimeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --获取梦境信息请求
    ROLE_REQ_GET_DREAM_INFO = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqDreamGetInfoMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --响应获取梦境信息请求
    ROLE_RSP_DREAM_INFO = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RspDreamGetInfoMessage",
        BODY      = "RoleSystem.RspDreamGetInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求刷新词缀
    ROLE_REQ_REFRESH_DREAM_BUF = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqDreamRefreshBufferMessage",
        BODY      = "RoleSystem.ReqDreamRefreshBufferMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 响应刷新词缀
    ROLE_RSP_REFRESH_DREAM_BUF = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RspDreamRefreshBufferMessage",
        BODY      = "RoleSystem.RspDreamRefreshBufferMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应刷新词缀
    ROLE_NTF_DREAM_SETTLE = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfDreamNotifyMessage",
        BODY      = "RoleSystem.NtfDreamNotifyMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_CLEAR_LEVEL_POINT = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ClearLevelPointMessage",
        BODY      = "RoleSystem.ClearLevelPointMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_HORCURX_GET_INFO_REQ = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsReqHorcruxGetInfoMessage",
        BODY      = "RoleSystem.CsReqHorcruxGetInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    ROLE_HORCURX_GET_INFO_RES = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsRspHorcruxGetInfoMessage",
        BODY      = "RoleSystem.CsRspHorcruxGetInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_HORCURX_LV_UP_REQ = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsReqHorcruxUpLvMessage",
        BODY      = "RoleSystem.CsReqHorcruxUpLvMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    ROLE_HORCURX_LV_UP_RES = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsRspHorcruxUpLvMessage",
        BODY      = "RoleSystem.CsRspHorcruxUpLvMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_HORCURX_EVOLUTION_REQ = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsReqHorcruxEvoluteMessage",
        BODY      = "RoleSystem.CsReqHorcruxEvoluteMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    ROLE_HORCURX_EVOLUTION_RES = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsRspHorcruxEvoluteMessage",
        BODY      = "RoleSystem.CsRspHorcruxEvoluteMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_HORCURX_SET_EXTERIOR_REQ = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsReqHorcruxSetExteriorMessage",
        BODY      = "RoleSystem.CsReqHorcruxSetExteriorMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    ROLE_HORCURX_SET_EXTERIOR_RES = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsRspHorcruxSetExteriorMessage",
        BODY      = "RoleSystem.CsRspHorcruxSetExteriorMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    
    
    ROLE_NOTICE_ALL_BUFF_ID = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NoticeAllBuffIDMessage",
        BODY      = "RoleSystem.NoticeAllBuffIDMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 通知洞窟挑战进度消息
    ROLE_NOTICE_CAVE_INDEX = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NoticeCaveIndexMessage",
        BODY      = "RoleSystem.NoticeCaveIndexMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    REQUEST_GET_PAY_MONEY_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqGetPayMoneyMessage",
        BODY      = "RoleSystem.ReqGetPayMoneyMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    RESPONSE_GET_PAY_MONEY_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseGetPayMoneyMessage",
        BODY      = "RoleSystem.ResponseGetPayMoneyMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    ROLE_PICKUP_DREAM_TASK = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_PickUpDreamTaskMessage",
        BODY      = "RoleSystem.PickUpDreamTaskMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    ROLE_NOTIFY_DREAM_TASK_STAT = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfDreamTaskStatMessage",
        BODY      = "RoleSystem.NtfDreamTaskStatMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --梦境回退请求
    ROLE_CHANGE_DREAM_LV_REQUEST = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqDreamChangeLvMessage",
        BODY      = "RoleSystem.ReqDreamChangeLvMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --梦境回退响应
    ROLE_CHANGE_DREAM_LV_RESPONSE = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RspDreamChangeLvMessage",
        BODY      = "RoleSystem.RspDreamChangeLvMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_NOTICE_FUNCTIONLOCK = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NoticeFunctionlockMessage",
        BODY      = "RoleSystem.NoticeFunctionlockMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_NOTICE_SCREEN_HORCURX_SET_EXTERIOR_REQ = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CsNtfScreenHorcruxSetExteriorMessage",
        BODY      = "RoleSystem.CsNtfScreenHorcruxSetExteriorMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 目标获取奖励请求
    ROLE_TARGET_GET_REWARD = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RequestTargetRewardMessage",
        BODY      = "RoleSystem.RequestTargetRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 目标获取奖励回复
    ROLE_TARGET_GET_REWARD_RESP = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseTargetRewardMessage",
        BODY      = "RoleSystem.ResponseTargetRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_PUSH_TREASURE_DATA_RESPONSE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_TimePushTreasureDataMessage",
        BODY      = "RoleSystem.TimePushTreasureDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 缤纷活动数据
    RESPONSE_ROLE_TRADE_ACTIVITY_DATA = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncTradeActivityDataMessage",
        BODY      = "RoleSystem.SyncTradeActivityDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 成长基金领取请求
    REQUIRE_ACTIVITY_GROW_FUND_GET_AWARDS = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqClaimLevelFundMessage",
        BODY      = "RoleSystem.ReqClaimLevelFundMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 成长基金领取返回
    RESPONSE_ACTIVITY_GROW_FUND_GET_AWARDS = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespClaimLevelFundMessage",
        BODY      = "RoleSystem.RespClaimLevelFundMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 活动目标推送
    RESPONSE_ACTIVITY_TARGET_DATA = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncTargetGroupDataMessage",
        BODY      = "RoleSystem.SyncTargetGroupDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 请求领取活动目标奖励
    REQUIRE_ACTIVITY_TARGET_GET_REWARD = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqClaimTargetGroupRewardMessage",
        BODY      = "RoleSystem.ReqClaimTargetGroupRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 返回领取活动目标奖励
    RESPONSE_ACTIVITY_TARGET_GET_REWARD = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespClaimTargetGroupRewardMessage",
        BODY      = "RoleSystem.RespClaimTargetGroupRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 刷新领取活动目标奖励
    RESPONSE_ACTIVITY_TARGET_UPDATE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_UpdateTargetGroupTargetDataMessage",
        BODY      = "RoleSystem.UpdateTargetGroupTargetDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    -- 目标消息推送
    ROLE_TARGET_HERO_TARGETS = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroTargetMessage",
        BODY      = "RoleSystem.HeroTargetMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 目标状态改变消息
    ROLE_TARGET_CHANGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroTargetChangeMessage",
        BODY      = "RoleSystem.HeroTargetChangeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --广告数据推送
    ROLE_ALL_ADVER_DATA = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_AdvertDataMessage",
        BODY      = "RoleSystem.AdvertDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_NOTICE_QUICK_DOWN = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfQuickDownMessage",
        BODY      = "RoleSystem.NtfQuickDownMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_SKILL_GROUNP_SELECT_REQ = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroSkillGroupSelectMessage",
        BODY      = "RoleSystem.HeroSkillGroupSelectMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    ROLE_SKILL_GROUNP_SELECT_RES = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroSkillGroupSelectResultMessage",
        BODY      = "RoleSystem.HeroSkillGroupSelectResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --日常活跃值数据
    ROLE_DAILY_ACTION_INFO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleDailyActionMessage",
        BODY      = "RoleSystem.RoleDailyActionMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --请求日常活跃奖励
    ROLE_DAILY_ACTION_REWARD_REQUEST = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleDailyActionRewardMessage",
        BODY      = "RoleSystem.RoleDailyActionRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --请求日常活跃奖励结果
    ROLE_DAILY_ACTION_REWARD_RESPONSE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RoleDailyActionRewardResultMessage",
        BODY      = "RoleSystem.RoleDailyActionRewardResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --通知扭曲空间信息
    ROLE_NOTIFY_DISTORTED_SPACE_INFO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfDistortedSpaceInfoMessage",
        BODY      = "RoleSystem.NtfDistortedSpaceInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 通知洞窟迷阵信息
    ROLE_NOTIFY_MAZE_INFO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfMazeInfoMessage",
        BODY      = "RoleSystem.NtfMazeInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --推送首通奖励 全量数据
    ROLE_NOTIFY_FIRST_PASS_ALL_DATA = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CaveFirstPassMessage",
        BODY      = "RoleSystem.CaveFirstPassMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --首通奖励领奖请求
    ROLE_REQ_GET_FIRST_PASS_REWARD = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CaveFirstPassRewardMessage",
        BODY      = "RoleSystem.CaveFirstPassRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --首通奖励领奖响应
    ROLE_RSP_GET_FIRST_PASS_REWARD = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CaveFirstPassRewardResultMessage",
        BODY      = "RoleSystem.CaveFirstPassRewardResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_SYNC_HERO_CAVE_STAGE_MAX_LEVEL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncHeroCaveStageMaxLevelMessage",
        BODY      = "RoleSystem.SyncHeroCaveStageMaxLevelMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_SYNC_SPECIAL_OFFER_PACK = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncSpecialOfferPackMessage",
        BODY      = "RoleSystem.SyncSpecialOfferPackMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ROLE_REQ_TARGET_SIGN_IN = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqHeroTargetSignInMessage",
        BODY      = "RoleSystem.ReqHeroTargetSignInMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    ROLE_RESP_TARGET_SIGN_IN = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespHeroTargetSignInMessage",
        BODY      = "RoleSystem.RespHeroTargetSignInMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --请求取消束缚状态
    ROLE_CANCLE_CONSTRAINT_REQUEST = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_CancelConstraintMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --阴影笼罩技能锁
    --请求解锁
    ROLE_REQ_UNLOCK_SHADOW_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqUnlockSkillMessage",
        BODY      = "RoleSystem.ReqUnlockSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --同步被锁状态
    ROLE_NTF_LOCK_SHADOW_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfLockSkillMessage",
        BODY      = "RoleSystem.NtfLockSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --同步被锁状态
    ROLE_VIEW_ADVERT_RESULT = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_AdvertViewResultMessage",
        BODY      = "RoleSystem.AdvertViewResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --同步大地诅咒锁定技能状态
    ROLE_NTF_MARK_LOCK_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfMarkSkillMessage",
        BODY      = "RoleSystem.NtfMarkSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --请求同屏当前场景所有角色数据（人物和宠物）
    ROLE_REQ_SYN_SCREEN_ROLE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqSynScreenRole",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 战斗冻结
    ROLE_NOTICE_FIGHT_FREEZE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfFightFreezeMessage",
        BODY      = "RoleSystem.NtfFightFreezeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 商店购买
    ROLE_NOTICE_STORE_BUY_GOODS = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_StoreReqBuyGoodsMessage",
        BODY     = "RoleSystem.StoreReqBuyGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 商店购买
    ROLE_REQ_STORE_BUY_GOODS = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_StoreRespBuyGoodsMessage",
        BODY     = "RoleSystem.StoreRespBuyGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 大秘境扫荡
    ROLE_REQ_SWEEP_DUNGEON = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ReqSweepDungeonMessage",
        BODY     = "RoleSystem.ReqSweepDungeonMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS SC deeplink 奖励
    ROLE_CLAIM_DEEPLINK_AWARD = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ClaimDeepLinkAwardMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 扭曲扫荡
    ROLE_REQ_SWEEP_DISTORTEDSPACE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ReqSweepDistortedSpaceMessage",
        BODY     = "RoleSystem.ReqSweepDistortedSpaceMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 扭曲扫荡结果
    ROLE_RSP_SWEEP_DISTORTEDSPACE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_RspSweepDistortedSpaceMessage",
        BODY     = "RoleSystem.RspSweepDistortedSpaceMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 扭曲扫荡通知
    ROLE_NTF_SWEEP_DISTORTEDSPACE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_NtfSweepDistortedSpaceMessage",
        BODY     = "RoleSystem.NtfSweepDistortedSpaceMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 请求(切换)进入家园场景(CS）
    ROLE_ENTER_HOME_SCENE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_EnterHomeSceneMessage",
        BODY      = "RoleSystem.EnterHomeSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    ROLE_ENTER_TOWN_SCENE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_EnterTownSceneMessage",
        BODY      = "RoleSystem.EnterTownSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 上报打开某个functionTypeUI页面上报
    ROLE_OPEN_FUNCTIONTYPE_UI = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_OpenFuntionTypeUIMessage",
        BODY      = "RoleSystem.OpenFuntionTypeUIMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 神迹祈祷请求
    ROLE_MIRACLE_REQ_PRAYER = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqDrawMiraclePrayerMessage",
        BODY      = "RoleSystem.ReqDrawMiraclePrayerMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 神迹祈祷返回
    ROLE_MIRACLE_RESP_PRAYER = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespDrawMiraclePrayerMessage",
        BODY      = "RoleSystem.RespDrawMiraclePrayerMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 神迹祈祷数据同步
    ROLE_SYNC_MIRACLE_PRAYER = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncMiraclePrayerMessage",
        BODY      = "RoleSystem.SyncMiraclePrayerMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 深红炼狱
    ROLE_SYNC_INFERNO_INFO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfInfernoInfoMessage",
        BODY      = "RoleSystem.NtfInfernoInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- CS 选择炼狱宝石请求
    ROLE_REQ_SELECT_INFERNO_RUNE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqSelectInfernoRuneMessage",
        BODY      = "RoleSystem.ReqSelectInfernoRuneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 选择炼狱宝石返回
    ROLE_RESP_SELECT_INFERNO_RUNE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespSelectInfernoRuneMessage",
        BODY      = "RoleSystem.RespSelectInfernoRuneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 同步炼狱宝石数据
    ROLE_SYNC_INFERNO_RUNE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncInfernoRuneMessage",
        BODY      = "RoleSystem.SyncInfernoRuneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CO 获取佣兵列表信息
    ROLE_REQ_MERCENARY_LIST = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqMercenaryListMessage",
        BODY      = "RoleSystem.ReqMercenaryListMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- OC 返回佣兵列表信息
    ROLE_RESP_MERCENARY_LIST = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespMercenaryListMessage",
        BODY      = "RoleSystem.RespMercenaryListMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 同步幽灵深渊场景数据
    ROLE_SYNC_GhostAbyssSceneInfo = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncGhostAbyssSceneInfoMessage",
        BODY      = "RoleSystem.SyncGhostAbyssSceneInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 通知幽灵深渊奖励信息
    ROLE_NOTIFY_GhostAbyssAwards = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyGhostAbyssAwardsMessage",
        BODY      = "RoleSystem.NotifyGhostAbyssAwardsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 幽灵深渊材料兑换
    ROLE_REQ_ExchangeGhostAbyssGoods = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqExchangeGhostAbyssGoodsMessage",
        BODY      = "RoleSystem.ReqExchangeGhostAbyssGoodsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 幽灵深渊材料兑换
    ROLE_RESP_ExchangeGhostAbyssGoods = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespExchangeGhostAbyssGoodsMessage",
        BODY      = "RoleSystem.RespExchangeGhostAbyssGoodsMessage",
        NO        = 0,
        DIRECTION = NetDirection.None
    },
    
    -- SC 通知客户端玩家ui效果数据
    ROLE_RESP_SyncPlayerDecorateMessage = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncPlayerDecorateMessage",
        BODY      = "RoleSystem.SyncPlayerDecorateMessage",
        NO        = 0,
        DIRECTION = NetDirection.None
    },
    
    -- CS 通知服务器玩家UI效果数据
    ROLE_REQ_ReqEquipPlayerDecorateMessage = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqEquipPlayerDecorateMessage",
        BODY      = "RoleSystem.ReqEquipPlayerDecorateMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --  SC 通知客户端玩家效果数据
    ROLE_RESP_RespEquipPlayerDecorateMessage = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespEquipPlayerDecorateMessage",
        BODY      = "RoleSystem.RespEquipPlayerDecorateMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --  SC 通知客户端玩家效果数据
    ROLE_SYNC_BossPortalDataMessage = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncBossPortalDataMessage",
        BODY      = "RoleSystem.SyncBossPortalDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 符文洞窟商店购买
    ROLE_REQ_GEM_SHOP_BUY_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqGemShopBuyMessage",
        BODY      = "RoleSystem.ReqGemShopBuyMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 符文洞窟商店购买商品回执
    ROLE_RESP_GEM_SHOP_BUY_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespGemShopBuyMessage",
        BODY      = "RoleSystem.RespGemShopBuyMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    -- -- CS SO 带佣兵下洞请求
    -- ROLE_REQ_ENTER_MERCENARY_CAVE = {
    --     CATEGORY  = NetMessageCategory.ROLE,
    --     HEAD      = "Type_ReqEnterMercenaryCaveMessage",
    --     BODY      = "RoleSystem.ReqEnterMercenaryCaveMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.CS
    -- },
    
    -- --  OS SC 带佣兵下洞返回
    -- ROLE_RESP_ENTER_MERCENARY_CAVE = {
    --     CATEGORY  = NetMessageCategory.ROLE,
    --     HEAD      = "Type_RespEnterMercenaryCaveMessage",
    --     BODY      = "RoleSystem.RespEnterMercenaryCaveMessage",
    --     NO        = 0,
    --     DIRECTION = NetDirection.NONE
    -- },
    
    -- SC 获得物品
    GOODS_ACHIEVE_GOODS = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_AchieveGoodsMessage",
        BODY     = "GoodsSystem.AchieveGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 删除物品
    GOODS_DELETE_GOODS = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_DeleteGoodsMessage",
        BODY     = "GoodsSystem.DeleteGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 删除物品
    GOODS_DELETE_GOODS_REQUEST = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_DeleteGoodsMessage",
        BODY     = "GoodsSystem.DeleteGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC包裹物品
    GOODS_PACKET_GOODS_DATA = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_PacketArchiveMessage",
        BODY     = "GoodsSystem.PacketArchiveMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 使用道具
    GOODS_USE_ITEM = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_UseItemMessage",
        BODY     = "GoodsSystem.UseItemMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 道具冷却
    GOODS_ITEM_COOLDOWN = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ItemCooldownMessage",
        BODY     = "GoodsSystem.ItemCooldownMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 道具冷却状态
    GOODS_ITEM_COOLDOWN_STATUS = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_ItemCooldownStatusMessage",
        BODY      = "GoodsSystem.ItemCooldownStatusMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 穿装
    GOODS_BAG_EQUIP = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_EquipMessage",
        BODY      = "GoodsSystem.EquipMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 卸装
    GOODS_BAG_UN_EQUIP = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_UnEquipMessage",
        BODY      = "GoodsSystem.UnEquipMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 拖动物品到包裹的消息
    GOODS_DRAG_GOODS_TO_PACKET = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_DragGoodsToPacketMessage",
        BODY      = "GoodsSystem.DragGoodsToPacketMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 处理获取虚拟物品
    GOODS_ACHIEVE_VIRTUAL_GOODS = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_AchieveVirtualGoodsMessage",
        BODY      = "GoodsSystem.AchieveVirtualGoodsMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 拖动物品到装备栏的消息
    GOODS_DRAG_EQUIPMENT_EQUIP = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_DragEquipToEquipmentPacketMessage",
        BODY      = "GoodsSystem.DragEquipToEquipmentPacketMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 快捷条改变
    GOODS_SHORTCUTS_CHANGE = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_ShortcutsMessage",
        BODY      = "GoodsSystem.ShortcutsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 刷新快捷条数据
    GOODS_SHORTCUTS = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_ShortcutsMessage",
        BODY      = "GoodsSystem.ShortcutsMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 穿装备 通知同屏消息
    GOODS_SCREEN_EQUIP = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_ScreenEquipMessage",
        BODY      = "GoodsSystem.ScreenEquipMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 卸穿装备 通知同屏消息
    GOODS_SCREEN_UN_EQUIP = {
        CATEGORY  = NetMessageCategory.GOODS,
        HEAD      = "Type_ScreenUnEquipMessage",
        BODY      = "GoodsSystem.ScreenUnEquipMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 开始使用道具
    GOODS_BEGIN_USE_ITEM = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_BeginUseItemMessage",
        BODY     = "GoodsSystem.BeginUseItemMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 使用道具失败
    GOODS_USE_ITEM_FAILED = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_UseItemFailedMessage",
        BODY     = "GoodsSystem.UseItemFailedMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 锁定物品
    GOODS_REQUEST_LOCK_GOODS = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RequestLockGoodsMessage",
        BODY     = "GoodsSystem.RequestLockGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 锁定物品返回值
    GOODS_RESPONSE_LOCK_GOODS = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ResponseLockGoodsMessage",
        BODY     = "GoodsSystem.ResponseLockGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 解锁背包响应
    GOODS_RESPONSE_UNLOCK_BAG_SPACE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ResponseUnlockBagSpaceMessage",
        BODY     = "GoodsSystem.ResponseUnlockBagSpaceMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 解锁背包请求
    GOODS_REQUEST_UNLOCK_BAG_SPACE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RequestUnlockBagSpaceMessage",
        BODY     = "GoodsSystem.RequestUnlockBagSpaceMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 切换一键换装响应
    GOODS_REP_SELECT_SHORTCUT_EQUIP = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RepSelectShortcutEquipMessage",
        BODY     = "GoodsSystem.RepSelectShortcutEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 切换一键换装请求
    GOODS_REQ_SELECT_SHORTCUT_EQUIP = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqSelectShortcutEquipMessage",
        BODY     = "GoodsSystem.ReqSelectShortcutEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    -- 删除背包满的list CS SC
    GOODS_DELETE_GOODS_FROM_FULL_BAG = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_DeleteGoodsFromFullBagMessage",
        BODY     = "GoodsSystem.DeleteGoodsFromFullBagMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 背包满的LIST存档 SC DS
    GOODS_FULL_BAG_LIST_ARCHIVE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_FullBagListArchiveMessage",
        BODY     = "GoodsSystem.FullBagListArchiveMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 背包满的LIST存档 SC DS
    GOODS_ADD_GOODS_TO_FULL_BAG = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_AddGoodsToFullBagMessage",
        BODY     = "GoodsSystem.AddGoodsToFullBagMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 获得物品消息广播给社交关系
    GOODS_BROADCAST_ACHIEVE_GOODS = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_BroadcastAchieveGoodsMessage",
        BODY     = "GoodsSystem.BroadcastAchieveGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求穿装的反馈,注意只在有错误的时候反馈.
    GOODS_RESPONSE_CODE_EQUIP = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ResponseCodeEquipMessage",
        BODY     = "GoodsSystem.ResponseCodeEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求脱装的反馈,注意只在有错误的时候反馈.
    GOODS_RESPONSE_CODE_UN_EQUIP = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ResponseCodeUnEquipMessage",
        BODY     = "GoodsSystem.ResponseCodeUnEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求拖动物品的反馈操作码,
    GOODS_RESPONSE_CODE_DRAG_GOODS_TO_PACKET = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ResponeCodeDragGoodsToPacketMessage",
        BODY     = "GoodsSystem.ResponeCodeDragGoodsToPacketMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    -- 每个PB文件只有一个这个消息定义,主要做未知错误反馈处理.
    GOODS_RESPONSE_SYSTEM_ERROR = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ResponseSystemErrorMessage",
        BODY     = "GoodsSystem.ResponseSystemErrorMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    GOODS_REQ_CHOOSE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqChooseGoodsMessage",
        BODY     = "GoodsSystem.ReqChooseGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    GOODS_RES_CHOOSE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ResponseChooseGoodsMessage",
        BODY     = "GoodsSystem.ResponseChooseGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 幻化信息请求
    GOODS_REQ_EQUIP_ILLUSION_INFO = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqEquipIllusionGetInfoMessage",
        BODY     = "GoodsSystem.ReqEquipIllusionGetInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- 幻化信息回复
    GOODS_RES_EQUIP_ILLUSION_INFO = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RspEquipIllusionGetInfoMessage",
        BODY     = "GoodsSystem.RspEquipIllusionGetInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 幻化装备请求
    GOODS_REQ_EQUIP_ILLUSION_WEAR = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqEquipIllusionWearMessage",
        BODY     = "GoodsSystem.ReqEquipIllusionWearMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- 幻化装备回复
    GOODS_RES_EQUIP_ILLUSION_WEAR = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RspEquipIllusionWearMessage",
        BODY     = "GoodsSystem.RspEquipIllusionWearMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 幻化获得新外观
    GOODS_NTF_NEW_EQUIP_ILLUSION = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_NtfAchieveEquipIllusionMessage",
        BODY     = "GoodsSystem.NtfAchieveEquipIllusionMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 推送打开宝箱的消息
    GOODS_PUSH_OPEN_BOX_GE_GOODS = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_PushOpenBoxGeGoodsMessage",
        BODY     = "GoodsSystem.PushOpenBoxGeGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS  拖动物品到包裹的消息
    GOODS_REQ_NEW_DRAG_GOODS_TO_PACKET = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqNewDragGoodsToPacketMessage",
        BODY     = "GoodsSystem.ReqNewDragGoodsToPacketMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 拖动物品到包裹的消息
    GOODS_RESPONSE_NEW_DRAG_GOODS_TO_PACKET = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RspNewDragGoodsToPacketMessage",
        BODY     = "GoodsSystem.RspNewDragGoodsToPacketMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    GOODS_RESPONSE_STARPRAY_NTF_INFO_MSG = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsNtfStarPrayInfoMessage",
        BODY     = "GoodsSystem.CsNtfStarPrayInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    GOODS_STARPRAY_LUCKY_AWARD_REQUEST = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsReqStarPrayLuckyAwardMessage",
        BODY     = "GoodsSystem.CsReqStarPrayLuckyAwardMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    GOODS_STARPRAY_LUCKY_AWARD_RESPONSE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsRspStarPrayLuckyAwardMessage",
        BODY     = "GoodsSystem.CsRspStarPrayLuckyAwardMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    ----------------------------------- 套装改造相关的消息-------------------------------
    -- SC 更新套装数据到客户端
    GOODS_STARPRAY_SYNC_HERO_GOODS_DATA_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_SyncHeroGoodsDataMessage",
        BODY     = "GoodsSystem.SyncHeroGoodsDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 改造套装属性请求
    GOODS_STARPRAY_REQ_RETROFIT_EQUIP_SET_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqRetrofitEquipSetMessage",
        BODY     = "GoodsSystem.ReqRetrofitEquipSetMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 改造套装属性结果
    GOODS_STARPRAY_RESP_RETROFIT_EQUIP_SET_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RespRetrofitEquipSetMessage",
        BODY     = "GoodsSystem.RespRetrofitEquipSetMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求套装属性选择
    GOODS_STARPRAY_REQ_SELECT_RETROFIT_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqSelectRetrofitMessage",
        BODY     = "GoodsSystem.ReqSelectRetrofitMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 选择套装属性结果
    GOODS_STARPRAY_RESP_SELECT_RETROFIT_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RespSelectRetrofitMessage",
        BODY     = "GoodsSystem.RespSelectRetrofitMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 重置套装属性请求
    GOODS_STARPRAY_REQ_RESET_RETROFIT_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqResetRetrofitMessage",
        BODY     = "GoodsSystem.ReqResetRetrofitMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 重置套装属性结果
    GOODS_STARPRAY_RESP_RESET_RETROFIT_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RespResetRetrofitMessage",
        BODY     = "GoodsSystem.RespResetRetrofitMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    ----------------------------------- 套装改造相关的消息-------------------------------
    
    
    -- //SC SD DS 多选礼包购买信息
    GOODS_CHOOSE_GOODS_BOUGTH_INFO = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ChooseGoodsBougthInfoMessage",
        BODY     = "GoodsSystem.ChooseGoodsBougthInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 多选等级礼包获取消息
    GOODS_CHOOSE_GOODS_GET = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ChooseGoodsGetMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --CS 多选等级礼包获取结果消息
    GOODS_CHOOSE_GOODS_GET_RESULT = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ChooseGoodsGetResultMessage",
        BODY     = "GoodsSystem.ChooseGoodsGetResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 打开问卷调查的返回消息
    NOTIFY_OPEN_QUESTION_NAIRE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_OpenQuestionnaireMessage",
        BODY     = "GoodsSystem.OpenQuestionnaireMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 问卷调查完成的请求消息
    REQUEST_FINISH_QUESTION_NAIRE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_DoneQuestionnaireMessage",
        BODY     = "GoodsSystem.DoneQuestionnaireMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --请求星痕抽奖
    REQUEST_STAR_PRAY_LUCKY_DRAW = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsReqStarPrayDrawMessage",
        BODY     = "GoodsSystem.CsReqStarPrayDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --请求星痕抽奖ten
    STAR_PRAY_TEN_DRAW_REQ = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsReqStarPrayTenDrawMessage",
        BODY     = "GoodsSystem.CsReqStarPrayTenDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    --响应星痕抽奖SRAR_PRAY_DRAten
    STAR_PRAY_TEN_DRAW_RES = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsRspStarPrayTenDrawMessage",
        BODY     = "GoodsSystem.CsRspStarPrayTenDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --响应星痕抽奖SRAR_PRAY_DRA
    RESPONSE_STAR_PRAY_LUCKY_DRAW = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsRspStarPrayDrawMessage",
        BODY     = "GoodsSystem.CsRspStarPrayDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    REQUEST_STAR_PRAY_WEAR = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsReqStarPrayWearMessage",
        BODY     = "GoodsSystem.CsReqStarPrayWearMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    RESPONSE_STAR_PRAY_WEAR = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsRspStarPrayWearMessage",
        BODY     = "GoodsSystem.CsRspStarPrayWearMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    REQUEST_STAR_PRAY_SWALLOW = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsReqStarPrayEatMessage",
        BODY     = "GoodsSystem.CsReqStarPrayEatMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    RESPONSE_STAR_PRAY_SWALLOW = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_CsRspStarPrayEatMessage",
        BODY     = "GoodsSystem.CsRspStarPrayEatMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 遗物分解
    REQUEST_RELIC_DECOMPOSE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqRelicDecomposeMessage",
        BODY     = "GoodsSystem.ReqRelicDecomposeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    RESPONSE_RELIC_DECOMPOSE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RspRelicDecomposeMessage",
        BODY     = "GoodsSystem.RspRelicDecomposeMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 遗物强化
    REQUEST_RELIC_STRENGTHEN = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqRelicStrengthenMessage",
        BODY     = "GoodsSystem.ReqRelicStrengthenMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    RESPONSE_RELIC_STRENGTHEN = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RspRelicStrengthenMessage",
        BODY     = "GoodsSystem.RspRelicStrengthenMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 遗物穿戴
    REQUEST_RELIC_WEAR = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqRelicWearMessage",
        BODY     = "GoodsSystem.ReqRelicWearMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    RESPONSE_RELIC_WEAR = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RspRelicWearMessage",
        BODY     = "GoodsSystem.RspRelicWearMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 需要加入背包的遗物数据
    RESPONSE_RELIC_INSTDATA = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_NtfRelicInstDataMessage",
        BODY     = "GoodsSystem.NtfRelicInstDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 宝物鉴定
    REQUEST_IDENTIFY_TREASURE_ITEM_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqIdentifyTreasureItemMessage",
        BODY     = "GoodsSystem.ReqIdentifyTreasureItemMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 宝物鉴定 (返回)
    RESPONSE_IDENTIFY_TREASURE_ITEM_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RespIdentifyTreasureItemMessage",
        BODY     = "GoodsSystem.RespIdentifyTreasureItemMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    
    -- SC 同步商店数据 (反斗乐限购商店)
    RESPONSE_HERO_STORE_DATA = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_SyncHeroStoreDataMessage",
        BODY     = "GoodsSystem.SyncHeroStoreDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    --CS 请求符文石连接
    REQUEST_GEM_CONNECT = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqGemConnectMessage",
        BODY     = "GoodsSystem.ReqGemConnectMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },

    --SC 请求符文石连接结果
    RESPONSE_GEM_CONNECT = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RespGemConnectMessage",
        BODY     = "GoodsSystem.RespGemConnectMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    --CS 请求断开连接
    REQUEST_GEM_DIS_CONNECT = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqGemDisConnectMessage",
        BODY     = "GoodsSystem.ReqGemDisConnectMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },

    --SC 请求断开连接结果
    RESPONSE_GEM_DIS_CONNECT = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RespGemDisConnectMessage",
        BODY     = "GoodsSystem.RespGemDisConnectMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    --CS 请求符文分解
    REQUEST_GEM_DECOMPOSE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqGemDecomposeMessage",
        BODY     = "GoodsSystem.ReqGemDecomposeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 请求符文分解结果
    RESPONSE_GEM_DECOMPOSE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RespGemDecomposeMessage",
        BODY     = "GoodsSystem.RespGemDecomposeMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 触发NPC
    NPC_TRIGGER_NPC = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_TriggerNPCMessage",
        BODY     = "NPCSystem.TriggerNPCMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    -- SC 触发NPC解锁
    NPC_TRIGGER_NPC_UNLOCK = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_TriggerNPCUnlockMessage",
        BODY     = "NPCSystem.TriggerNPCUnlockMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 触发NPC三选一
    NPC_TRIGGER_GREEDY_SELECT_RES= {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_NtfTriggerNpcGreedyMessage",
        BODY     = "NPCSystem.NtfTriggerNpcGreedyMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 开始采集
    NPC_COLLECT_START_REQ= {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqCollectStartMessage",
        BODY     = "NPCSystem.ReqCollectStartMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC
    NPC_COLLECT_START_RES= {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspCollectStartMessage",
        BODY     = "NPCSystem.RspCollectStartMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- CS 取消采集通知
    NPC_COLLECT_CANCEL_REQ= {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqCollectCancelMessage",
        BODY     = "NPCSystem.ReqCollectCancelMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC
    NPC_COLLECT_COLLECT_RESULT_RES= {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspCollectSuccessMessage",
        BODY     = "NPCSystem.RspCollectSuccessMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    -- 使用功能NPC消息
    NPC_USE_FUNCTION = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_UseFunctionMessage",
        BODY     = "NPCSystem.UseFunctionMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- 使用功能NPC消息
    NPC_USE_FUNCTION_RES = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_UseFunctionResponseMessage",
        BODY     = "NPCSystem.UseFunctionResponseMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 卖出物品结果
    NPC_SELL_GOODS_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_SellGoodsResultMessage",
        BODY     = "NPCSystem.SellGoodsResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 购买物品成功
    NPC_BUY_GOODS_SUCCEED = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_BuyGoodsResultMessage",
        BODY     = "NPCSystem.BuyGoodsResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 购买物品成功
    NPC_FUNCTION_ARCHIVE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_FunctionArchiveMessage",
        BODY     = "NPCSystem.FunctionArchiveMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 装备精炼
    NPC_EQUIP_REFINE_REQUEST = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqEquipRefineMessage",
        BODY     = "NPCSystem.ReqEquipRefineMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 装备精炼
    NPC_EQUIP_REFINE_RESPONSE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspEquipRefineMessage",
        BODY     = "NPCSystem.RspEquipRefineMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    -- 点金结果消息
    NPC_GOLD_TOUCH_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_GoldTouchResultMessage",
        BODY     = "NPCSystem.GoldTouchResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 附魔结果消息
    NPC_ENCHANT_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_EnchantResultMessage",
        BODY     = "NPCSystem.EnchantResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 装备改造结果消息
    NPC_REMODEL_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RemodelResultMessage",
        BODY     = "NPCSystem.RemodelResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --装备改造二次确认请求
    NPC_SURE_REQUEST_REMODEL_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsReqRemodelReplaceMessage",
        BODY     = "NPCSystem.CsReqRemodelReplaceMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    --装备改造二次确认消息
    NPC_SURE_REPONSE_REMODEL_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsRspRemodelReplaceMessage",
        BODY     = "NPCSystem.CsRspRemodelReplaceMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --装备covert
    NPC_REQUEST_CONVERT_EQUIP_RES = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsReqEquipConvertMessage",
        BODY     = "NPCSystem.CsReqEquipConvertMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --装备covert
    NPC_REQUEST_CONVERT_EQUIP_RSP = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsRspEquipConvertMessage",
        BODY     = "NPCSystem.CsRspEquipConvertMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 装备强化结果消息
    NPC_STRENGTHEN_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_StrengthenResultMessage",
        BODY     = "NPCSystem.StrengthenResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 触发陷阱效果
    NPC_TRAP_EFFECT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_TrapDoEffectMessage",
        BODY     = "NPCSystem.TrapDoEffectMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 黑市商品购买结果
    NPC_EXCHANGE_BLACK_MARKET_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ExchangeBlackMarketResultMessage",
        BODY     = "NPCSystem.ExchangeBlackMarketResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求黑市商品信息
    NPC_REQ_BLACK_MARKET = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqBlackMarketMessage",
        BODY     = "NPCSystem.ReqBlackMarketMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 黑市商人信息
    NPC_BLACK_MARKET = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_BlackMarketMessage",
        BODY     = "NPCSystem.BlackMarketMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 随机商店商品购买结果
    NPC_EXCHANGE_RANDOMSHOP_MARKET_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RamdomshopBuyResultMessage",
        BODY     = "NPCSystem.RamdomshopBuyResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求随机商店商品信息
    NPC_REQ_RANDOMSHOP_MARKET = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqRandomShopMessage",
        BODY     = "NPCSystem.ReqRandomShopMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 随机商店商人信息
    NPC_RANDOMSHOP_MARKET = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RandomShopMessage",
        BODY     = "NPCSystem.RandomShopMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 装备分解结果
    NPC_RESOLVE_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_DecomposeResultMessage",
        BODY     = "NPCSystem.DecomposeResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 装备锻造结果
    NPC_FORGE_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ForgeResultMessage",
        BODY     = "NPCSystem.ForgeResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 捏脸结果消息
    NPC_FACELIFT_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_FaceliftResultMessage",
        BODY     = "NPCSystem.FaceLiftResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 猫饭结果消息
    NPC_CATFOOD_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CatFoodResultMessage",
        BODY     = "NPCSystem.CatFoodResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 登录请求抽奖转盘信息
    LOAD_NPC_TURNTABLE_INFO = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqLuckyWheelNumMessage",
        BODY     = "NPCSystem.ReqLuckyWheelNumMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 打开界面请求抽奖转盘信息
    NPC_TURNTABLE_INFO = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_LuckyWheelArchiveMessage",
        BODY     = "NPCSystem.LuckyWheelArchiveMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 抽奖结果消息
    NPC_TURNTABL_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_LuckyWheelResultMessage",
        BODY     = "NPCSystem.LuckyWheelResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会科技结果消息
    NPC_CONTRIBUTE_GUILD_TECH_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ContributeGuildTechResultMessage",
        BODY     = "NPCSystem.ContributeGuildTechResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 
    NPC_ACHIEVEMENTAWARD_RESULT_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_AchievementAwardResultMessage",
        BODY     = "NPCSystem.AchievementAwardResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 手动刷新黑商消息
    NPC_MANUAL_REFRESH_BLACK_MARKET = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ManualRefreshBlackMarketMessage",
        BODY     = "NPCSystem.ManualRefreshBlackMarketMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 响应手动刷新黑商消息 
    NPC_RESPONSE_MANUAL_REFRESH_BLACK_MARKET = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ResponseManualRefreshBlackMarketMessage",
        BODY     = "NPCSystem.ResponseManualRefreshBlackMarketMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 手动刷新随机商人消息
    NPC_MANUAL_REFRESH_RANDOMSHOP_MARKET = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ManualRefreshRandomShopMessage",
        BODY     = "NPCSystem.ManualRefreshRandomShopMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 响应手动刷新随机商人消息 
    NPC_RESPONSE_MANUAL_REFRESH_RANDOMSHOP_MARKET = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ResponseManualRefreshRandomShopMessage",
        BODY     = "NPCSystem.ResponseManualRefreshRandomShopMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 移除陷阱
    NPC_TRAP_REMOVE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_TrapRemoveMessage",
        BODY     = "NPCSystem.TrapRemoveMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 触发NPC失败
    NPC_TRIGGER_NPC_FAILED = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_TriggerNPCFailedMessage",
        BODY     = "NPCSystem.TriggerNPCFailedMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 宝石镶嵌结果消息
    NPC_GEM_INLAID_REPONSE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_EquipGemstoneInlaidResultMessage",
        BODY     = "NPCSystem.EquipGemstoneInlaidResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 合成宝石消息
    NPC_GEM_SYNTHESIS_REPONSE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_GemstoneComposeResultMessage",
        BODY     = "NPCSystem.NewGemstoneComposeResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 宝石购买消息
    NPC_GEM_SHOP_BUY_REPONSE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_GemstoneBuyResultMessage",
        BODY     = "NPCSystem.GemstoneBuyResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 宝石转化消息
    NPC_GEM_TRANSFORM_REPONSE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_GemstoneTransformResultMessage",
        BODY     = "NPCSystem.NewGemstoneTransformResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 金矿请求消息
    NPC_REQUEST_GOLDEN_MINE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsReqGoldMineWrapMessage",
        BODY     = "NPCSystem.CsReqGoldenMineWrapMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 金矿请求消息
    NPC_RESPONSE_GOLDEN_MINE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsRspGoldMineWrapMessage",
        BODY     = "NPCSystem.CsRspGoldenMineWrapMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 工坊请求消息
    NPC_REQUEST_GEM_FACTORY = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsReqGemFactoryWrapMessage",
        BODY     = "NPCSystem.CsReqGemFactoryWrapMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 工坊请求消息
    NPC_RESPONSE_GEM_FACTORY = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsRspGemFactoryWrapMessage",
        BODY     = "NPCSystem.CsRspGemFactoryWrapMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应技能转职
    NPC_RESPONSE_SKILL_ADVANCED = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ResponseSkillAdvancedMessage",
        BODY     = "NPCSystem.ResponseSkillAdvancedMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 装备重铸请求
    NPC_REQ_RECAST_EQUIP = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsReqEquipRecastMessage",
        BODY     = "NPCSystem.CsReqEquipRecastMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 装备重铸响应
    NPC_RSP_RECAST_EQUIP = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_CsRspEquipRecastMessage",
        BODY     = "NPCSystem.CsRspEquipRecastMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    NPC_MODIFY_EXPEDITION_LV = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ModifyExpeditionLvMessage",
        BODY     = "NPCSystem.ModifyExpeditionLvMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    NPC_RSP_MODIFY_EXPEDITION_LV = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspModifyExpeditionLvMessage",
        BODY     = "NPCSystem.ModifyExpeditionLvMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 符文石快速合成
    NPC_REQ_QUICK_COMPOSE_GEM = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqQuickComposeGemMessage",
        BODY     = "NPCSystem.ReqQuickComposeGemMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 符文石快速合成
    NPC_RSP_QUICK_COMPOSE_GEM = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespQuickComposeGemMessage",
        BODY     = "NPCSystem.RespQuickComposeGemMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CS 创建队伍请求
    TEAM_REQUEST_CREATE_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_RequestCreateTeamMessage",
        BODY      = "TeamSystem.RequestCreateTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    --CS 开始搜索匹配的通知
    TEAM_REQUEST_MATCH = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_RequestMatchMessage",
        BODY      = "TeamSystem.RequestMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    --CS  请求立即组队进洞
    TEAM_REQUEST_IMMEDIATE_GO = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_EnterTeamCaveImmediatelyMessage",
        BODY      = "TeamSystem.EnterTeamCaveImmediatelyMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    --OC 开始搜索匹配的通知
    TEAM_NOTIFY_SEARCH_MATCH = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_NotifySearchMatchMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --CS 取消搜索匹配的通知
    TEAM_REQUEST_CANCEL_MATCH = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_RequestCancelMatchMessage",
        BODY      = "TeamSystem.RequestCancelMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    --OC 取消匹配的通知
    TEAM_NotifyCancelMatch = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_NotifyCancelMatchMessage",
        BODY      = "TeamSystem.NotifyCancelMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --OC 匹配的响应
    TEAM_RESPONSE_MATCH = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_ResponseMatchMessage",
        BODY      = "TeamSystem.ResponseMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --CO 确认匹配的请求
    TEAM_REQUEST_CONFIRM_MATCH = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_RequestConfirmMatchMessage",
        BODY      = "TeamSystem.RequestConfirmMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    --OC 玩家确认的广播消息
    TEAM_NOTIFY_PLAYER_CONFIRM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_NotifyPlayerConfirmMessage",
        BODY      = "TeamSystem.NotifyPlayerConfirmMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --OC 倒计时结束取消匹配
    TEAM_COUNTDOWN_CANCEL_MATCH = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_CountdownCancelMatchMessage",
        BODY      = "TeamSystem.CountdownCancelMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --OC 创建队伍消息
    TEAM_CREATE_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_CreateTeamMessage",
        BODY      = "TeamSystem.CreateTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --OC 解散队伍消息
    TEAM_DISMISS_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_DismissTeamMessage",
        BODY      = "TeamSystem.DismissTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --OC 加入队伍消息
    TEAM_JOIN_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_JoinTeamMessage",
        BODY      = "TeamSystem.JoinTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --OC 通知玩家状态改变
    TEAM_NOTIFY_TEAM_MEMBER_STATUS_CHANGE = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_NotifyTeamMemberStatusChangeMessage",
        BODY      = "TeamSystem.NotifyTeamMemberStatusChangeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --OC 离开队伍消息
    TEAM_OC_Leave_Team = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_LeaveTeamMessage",
        BODY      = "TeamSystem.LeaveTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --CO 离开队伍消息
    TEAM_CO_Leave_Team = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_LeaveTeamMessage",
        BODY      = "TeamSystem.LeaveTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    --OC 踢人消息
    TEAM_OC_KICK_HERO = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_KickHeroMessage",
        BODY      = "TeamSystem.KickHeroMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --CO  踢人确认请求消息
    TEAM_REQUEST_KICK_CONFIRM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_RequestKickConfirmMessage",
        BODY      = "TeamSystem.RequestKickConfirmMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 踢人确认反馈 
    TEAM_RESPONSE_KICK_CONFIRM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_ResponseKickConfirmMessage",
        BODY      = "TeamSystem.ResponseKickConfirmMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CO OC踢人消息
    TEAM_REQUEST_KICK_HERO = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_RequestKickHeroMessage",
        BODY      = "TeamSystem.RequestKickHeroMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    --踢人消息反馈
    TEAM_RESPONSE_KICK_HERO = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_ResponseKickHeroMessage",
        BODY      = "TeamSystem.ResponseKickHeroMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 倒计时结束,踢人失败 
    TEAM_CANCEL_KICK_HERO = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_CancelKickHeroMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 通知全队请求下楼
    TEAM_RESPONSE_ENTER_NEXT_LEVEL = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_ResponseEnterNextLevelMessage",
        BODY      = "TeamSystem.ResponseEnterNextLevelMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 请求确认下楼
    TEAM_REQUEST_CONFIRM_ENTER_NEXT_LEVEL = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_RequestConfirmEnterNextLevelMessage",
        BODY      = "TeamSystem.RequestConfirmEnterNextLevelMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- 通知确认下楼的最终结果
    TEAM_NOTIFY_CONFIRM_ENTER_NEXT_LEVEL = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_NotifyConfirmEnterNextLevelMessage",
        BODY      = "TeamSystem.NotifyConfirmEnterNextLevelMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 取消投票下楼
    TEAM_CANCEL_ENTER_NEXT_LEVEL = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_CancelEnterNextLevelMessage",
        BODY      = "TeamSystem.CancelEnterNextLevelMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS SC 请求邀请好友和工会加入队伍
    TEAM_REQUEST_INVITE_FRIEND_JOIN_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_RequestInviteFriendJoinTeamMessage",
        BODY      = "TeamSystem.RequestInviteFriendJoinTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- CS SO 客户端同意邀请好友和工会加入队伍
    TEAM_AGREE_INVITE_FRIEND_JOIN_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_AgreeInviteFriendJoinTeamMessage",
        BODY      = "TeamSystem.AgreeInviteFriendJoinTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- CS SO 客户端拒绝邀请好友和工会加入队伍
    TEAM_REJECT_INVITE_FRIEND_JOIN_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_RejectInviteFriendJoinTeamMessage",
        BODY      = "TeamSystem.RejectInviteFriendJoinTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- CS SC OC 反馈邀请好友和工会加入队伍处理结果
    TEAM_RESPONSE_INVITE_FRIEND_JOIN_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_ResponseInviteFriendJoinTeamMessage",
        BODY      = "TeamSystem.ResponseInviteFriendJoinTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- OC 队长改变通知  只会在开始匹配阶段有意义
    TEAM_NOTIFY_CAPTAIN_CHANGE = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_NotifyCaptainChangeMessage",
        BODY      = "TeamSystem.NotifyCaptainChangeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --team.pb 额外补充消息响应
    TEAM_RESPONSE_SYSTEM_ERROR = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_ResponseSystemErrorMessage",
        BODY      = "TeamSystem.ResponseSystemErrorMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CO OC 请求解散队伍
    TEAM_REQ_DISMISS_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_ReqDismissTeamMeesage",
        BODY      = "TeamSystem.ReqDismissTeamMeesage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- CO 响应队伍解散消息
    TEAM_ASW_DISMISS_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_AswDismissTeamMessage",
        BODY      = "TeamSystem.AswDismissTeamMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- CO 取消队伍结果
    TEAM_DISMISS_TEAM_RESULT = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_DismissTeamResultMessage",
        BODY      = "TeamSystem.DismissTeamResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CO 解散操作请求操作反馈消息
    TEAM_DISMISS_OP_REQ_TEAM = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_DismissOpReqResultMessage",
        BODY      = "TeamSystem.DismissOpReqResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CO 
    TEAM_NTF_GREEDY_SELECT_MESSAGE = {
        CATEGORY  = NetMessageCategory.TEAM,
        HEAD      = "Type_NtfGreedySelectMessage",
        BODY      = "TeamSystem.NtfGreedySelectMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    --SD SC DS 角色当前任务数据
    TASK_HERO_ACCEPT_TASK = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_HeroAcceptTaskMessage",
        BODY      = "TaskSystem.HeroAcceptTaskMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --SD SC DS 角色已完成任务数据
    TASK_HERO_DELIVERED_TASK = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_HeroDeliveredTaskMessage",
        BODY      = "TaskSystem.HeroDeliveredTaskMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS  SC接任务
    TASK_ACCEPT_TASK = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_AcceptTaskMessage",
        BODY      = "TaskSystem.AcceptTaskMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS  完成任务请求消息
    TASK_COMPLETE_TASK_REQUEST = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_CompleteTaskRequestMessage",
        BODY      = "TaskSystem.CompleteTaskRequestMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 完成任务返回消息
    TASK_COMPLETE_TASK_RESPONSE = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_CompleteTaskResponseMessage",
        BODY      = "TaskSystem.CompleteTaskResponseMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC  任务变化
    TASK_TASK_CHANGE = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_TaskChangeMessage",
        BODY      = "TaskSystem.TaskChangeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 删除任务
    TASK_DELETE_TASK = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_DeleteTaskMessage",
        BODY      = "TaskSystem.DeleteTaskMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 做收集任务
    TASK_DO_COLLECT_TASK = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_DoCollectTaskMessage",
        BODY      = "TaskSystem.DoCollectTaskMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 收集任务结果消息
    TASK_DO_COLLECT_TASK_RESULT = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_DoCollectTaskResultMessage",
        BODY      = "TaskSystem.DoCollectTaskResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 刷新任务消息
    TASK_REFRESH_TASK = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_RefreshTaskMessage",
        BODY      = "TaskSystem.RefreshTaskMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 刷新任务结果消息
    TASK_REFRESH_TASK_RESULT = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_RefreshTaskResultMessage",
        BODY      = "TaskSystem.RefreshTaskResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 同步玩家任务模块基础数据
    TASK_SYNC_TASK_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.TASK,
        HEAD      = "Type_SyncTaskDataMessage",
        BODY      = "TaskSystem.SyncTaskDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --英雄已领奖励的藏宝图数据
    TREASUREMAP_REWARDED_TREASURE_MAP = {
        CATEGORY  = NetMessageCategory.TREASUREMAP,
        HEAD      = "Type_RewardedTreasureMapMessage",
        BODY      = "TreasureMapSystem.RewardedTreasureMapMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --英雄已收集的碎片数据
    TREASUREMAP_COLLECTED_FRAGMENT = {
        CATEGORY  = NetMessageCategory.TREASUREMAP,
        HEAD      = "Type_CollectedFragmentMessage",
        BODY      = "TreasureMapSystem.CollectedFragmentMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CS 领取藏宝图奖励
    TREASUREMAP_RECEIVE_TREASURE_REWARD = {
        CATEGORY  = NetMessageCategory.TREASUREMAP,
        HEAD      = "Type_ReceiveTreasureRewardMessage",
        BODY      = "TreasureMapSystem.ReceiveTreasureRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 领取藏宝图奖励结果
    TREASUREMAP_RECEIVE_TREASURE_REWARD_RESULT = {
        CATEGORY  = NetMessageCategory.TREASUREMAP,
        HEAD      = "Type_ReceiveTreasureRewardResultMessage",
        BODY      = "TreasureMapSystem.ReceiveTreasureRewardResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- gm添加游戏元素
    GM_ADD_GAME_ELEMENT = {
        CATEGORY  = NetMessageCategory.GM,
        HEAD      = "Type_AddGameElementMessage",
        BODY      = "GMSystem.AddGameElementMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 创建公会
    GUILD_CREATE_GUILD = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_CreateGuildMessage",
        BODY      = "GuildSystem.CreateGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 公会改名
    GUILD_RENAME_GUILD = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RenameGuildMessage",
        BODY      = "GuildSystem.RenameGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 罢免公会会长
    GUILD_OVERTHROW_MASTER = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqOverthrowLeaderMessage",
        BODY      = "GuildSystem.ReqOverthrowLeaderMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 更新公会会长
    GUILD_OVERTHROW_MASTER_RESP = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_OverthrowLeaderMessage",
        BODY      = "GuildSystem.OverthrowLeaderMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 开始罢免通知
    GUILD_OVERTHROW_START = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_OverthrowStartMessage",
        BODY      = "GuildSystem.OverthrowStartMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },   
    
    -- 创建公会成功返回
    GUILD_GUILD_CREATION = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_GuildCreationMessage",
        BODY      = "GuildSystem.GuildCreationMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会相关的操作反馈消息
    GUILD_REPLY_OF_OPERATION = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReplyOfOperationMessage",
        BODY      = "GuildSystem.ReplyOfOperationMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求公会列表(CO)
    GUILD_REQ_GUILD_LIST = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildListMessage",
        BODY      = "GuildSystem.ReqGuildListMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 返回公会列表结果(OC)
    GUILD_ASW_GUILD_LIST = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_AswGuildListMessage",
        BODY      = "GuildSystem.AswGuildListMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --  请求加载自己的公会列表(CO)
    GUILD_REQ_GUILD = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildMessage",
        BODY      = "GuildSystem.ReqGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 加载自己公会(OC)
    GUILD_ASW_GUILD = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_AswGuildMessage",
        BODY      = "GuildSystem.AswGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求(切换)进入公会场景(CO OS）
    GUILD_ENTER_GUILD_SCENE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_EnterGuildSceneMessage",
        BODY      = "GuildSystem.EnterGuildSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    
    -- 请求公会科技(CO)
    GUILD_REQ_GUILD_TECH = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildTechMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 加载自己公会的科技数据(OC)
    GUILD_ASW_GUILD_TECH = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_AswGuildTechMessage",
        BODY      = "GuildSystem.AswGuildTechMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 增加公会科技经验
    GUILD_ADD_GUILD_TECH = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_AddGuildTechMessage",
        BODY      = "GuildSystem.AddGuildTechMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求公会天赋技能(CS)
    GUILD_REQ_GUILD_SKILL = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildSkillMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 公会天赋技能(SC SD DS)
    GUILD_GUILD_SKILL = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_GuildSkillMessage",
        BODY      = "GuildSystem.GuildSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 请求学习技能
    GUILD_REQ_STUDY_GUILD_SKILL = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_StudyGuildSkillMessage",
        BODY      = "GuildSystem.StudyGuildSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    GUILD_RES_STUDY_GUILD_SKILL = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ResStudyGuildSkillMessage",
        BODY      = "GuildSystem.GuildSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求加入公会 （CS） 
    GUILD_REQ_JOIN_GUILD = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqJoinGuildMessage",
        BODY      = "GuildSystem.ReqJoinGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 自己加入公会成功 （OC）加入公会成功，先收到Type_AswGuildMessage 再收到Type_GuildJoinMessage  空协议
    GUILD_GUILD_JOIN = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_GuildJoinMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 他人加入我所在公会成功（OC）
    GUILD_NEW_MEMBER = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_NewMemberMessage",
        BODY      = "GuildSystem.NewMemberMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 有新的申请请求到公会（OC） 空协议
    GUILD_NOTIFY_NEW_JOIN_REQ = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_NotifyNewJoinReqMessage",
        BODY      = "GuildSystem.NotifyNewJoinReqMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求入会申请请求列表(CO) 空协议
    GUILD_REQ_JOIN_REQ_LIST = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqJoinReqListMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 回复入会申请请求列表(OC)
    GUILD_ASW_JOIN_REQ_LIST = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_AswJoinReqListMessage",
        BODY      = "GuildSystem.AswJoinReqListMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 处理入会申请(CO)
    GUILD_REQ_DEAL_JOIN_REQ = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqDealJoinReqMessage",
        BODY      = "GuildSystem.ReqDealJoinReqMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 返回入会申请
    GUILD_ASW_DEAL_JOIN_REQ = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_AswDealJoinReqMessage",
        BODY      = "GuildSystem.AswDealJoinReqMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 拒绝所有申请(CO)  空协议
    GUILD_REFUSE_ALL_JOIN_REQ = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RefuseAllJoinReqMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 已无入会申请了(OC) 空协议
    GUILD_NOTIFY_NO_JOIN_REQ = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_NotifyNoJoinReqMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 踢人操作 (CO OC)
    GUILD_KICK_MEMBER = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_KickMemberMessage",
        BODY      = "GuildSystem.KickMemberMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 退出公会 (CO OC)
    GUILD_QUIT_GUILD = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_QuitGuildMessage",
        BODY      = "GuildSystem.QuitGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 修改公会公告(CO)
    GUILD_MODIFY_NOTICE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ModifyNoticeMessage",
        BODY      = "GuildSystem.ModifyNoticeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 修改公会加入审核(CO)
    GUILD_MODIFY_JOIN_AUDIT = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ModifyJoinAuditMessage",
        BODY      = "GuildSystem.ModifyJoinAuditMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 修改公会装备积分限制(CO)
    GUILD_MODIFY_JOIN_EQUIP_SCORE_LMT = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ModifyJoinEquipScoreLmtMessage",
        BODY      = "GuildSystem.ModifyJoinEquipScoreLmtMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 修改公会图标(CO)
    GUILD_MODIFY_GUILD_ICON = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ModifyGuildIconMessage",
        BODY      = "GuildSystem.ModifyGuildIconMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 更新公会成员数据(OC)
    GUILD_UPDATE_MEMBER_DATA = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_UpdateGuildMemberDataMessage",
        BODY      = "GuildSystem.UpdateGuildMemberDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    
    -- 购买公会图标
    GUILD_BUY_GUILD_ICON = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_BuyGuildIconMessage",
        BODY      = "GuildSystem.BuyGuildIconMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 修改公会成员职位(CO OC)
    GUILD_MODIFY_MEMBER_TITLE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ModifyMemberTitleMessage",
        BODY      = "GuildSystem.ModifyMemberTitleMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 加入申请被拒绝(OC)
    GUILD_JOIN_REQ_REFUSED = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_JoinReqRefusedMessage",
        BODY      = "GuildSystem.JoinReqRefusedMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 更新客户端自己公会数据版本号(OC)
    GUILD_UPDATE_GUILD_DATA = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_UpdateGuildDataMessage",
        BODY      = "GuildSystem.UpdateGuildDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 加载公会图标
    GUILD_LOAD_GUILD_ICON = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_LoadGuildIconMessage",
        BODY      = "GuildSystem.LoadGuildIconMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 更新客户端自己工会数据版本号(OC)
    GUILD_UPDATE_GUILD_DATA_VERSION = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_UpdateGuildDataVersionMessage",
        BODY      = "GuildSystem.UpdateGuildDataVersionMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 更新公会名字
    GUILD_UPDATE_GUILD_NAME = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_UpdateGuildNameMessage",
        BODY      = "GuildSystem.UpdateGuildNameMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 更新同屏玩家显示的公会名字
    GUILD_UPDATE_OTHER_HEROS_GUILD_NAME = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_UpdateOtherHerosGuildName",
        BODY      = "GuildSystem.UpdateOtherHerosGuildName",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 同屏切换公会
    GUILD_CHANGE_GUILD_ID = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ModifyGuildIDMessage",
        BODY      = "GuildSystem.ModifyGuildIDMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求公会活动数据
    GUILD_REQ_ACTIVITY_COUNT = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqActivityCountMessage",
        BODY      = "GuildSystem.ReqActivityCountMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 通知活动计数信息
    GUILD_RESPONSE_ACTIVITY_COUNT_INFO = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ActivityCountInfoMessage",
        BODY      = "GuildSystem.ActivityCountInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 通知公会宝箱显示红点
    GUILD_BOX_NEW_BOX = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_NewGuildBoxMessage",
        BODY      = "GuildSystem.NewGuildBoxMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求公会宝箱列表
    GUILD_BOX_REQUEST_BOX_LIST = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqNewGuildBoxMessage",
        BODY      = "GuildSystem.ReqNewGuildBoxMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 回复公会宝箱列表
    GUILD_BOX_RESPONSE_BOX_LIST = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_LoadGuildBoxInfoMessage",
        BODY      = "GuildSystem.LoadGuildBoxInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求打开公会宝箱
    GUILD_BOX_REQUEST_OPEN_BOX = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_OpenGuildBoxMessage",
        BODY      = "GuildSystem.OpenGuildBoxMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 回复打开公会宝箱消息
    GUILD_BOX_RESPONSE_OPEN_BOX = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_OpenGuildBoxResultMessage",
        BODY      = "GuildSystem.OpenGuildBoxResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求移除所有已经打开的箱子
    GUILD_BOX_REQUEST_CLEAR_DROPPED = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ClearDroppedBoxesMessage",
        BODY      = "GuildSystem.ClearDroppedBoxesMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 服务器主动请求移除宝箱
    GUILD_BOX_REMOVE_BOX = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RemoveBoxesMessage",
        BODY      = "GuildSystem.RemoveBoxesMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS SO 工会Boss请求战斗
    GUILD_REQ_GUILD_BOSS_FIGHT = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildBossFightMessage",
        BODY      = "GuildSystem.ReqGuildBossFightMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- OS SC 工会Boss请求战斗
    GUILD_RESPONSE_GUILD_BOSS_FIGHT = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RspGuildBossFightMessage",
        BODY      = "GuildSystem.RspGuildBossFightMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS SO 工会Boss购买buff
    GUILD_REQ_GUILD_BOSS_BUY_BUFF = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildBossBuyBuffMessage",
        BODY      = "GuildSystem.ReqGuildBossBuyBuffMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --  OS SC 工会Boss购买Buff
    GUILD_RESPONSE_GUILD_BOSS_BUY_BUFF = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RspGuildBossBuyBuffMessage",
        BODY      = "GuildSystem.RspGuildBossBuyBuffMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS SO 工会Boss获取消息
    GUILD_REQ_GUILD_BOSS_GET_DATA = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildBossGetDataMessage",
        BODY      = "GuildSystem.ReqGuildBossGetDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --  OS SC 工会Boss获取消息
    GUILD_RESPONSE_GUILD_BOSS_GET_DATA = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RspGuildBossGetDataMessage",
        BODY      = "GuildSystem.RspGuildBossGetDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --  SC OS SO 通知消息
    GUILD_NOTICE_GUILD_BOSS = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_NtfGuildBossMessage",
        BODY      = "GuildSystem.NtfGuildBossMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会许愿池许愿
    GUILD_REQ_GUILD_WISH = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildWishMessage",
        BODY      = "GuildSystem.ReqGuildWishMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 公会许愿池许愿返回
    GUILD_RESPONSE_GUILD_WISH = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RspGuildWishMessage",
        BODY      = "GuildSystem.RspGuildWishMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会许愿池许愿总次数
    GUILD_REQ_GUILD_WISH_TOTAL_TIME = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildWishTotalTimesMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 公会许愿池许愿总次数返回
    GUILD_RESPONSE_GUILD_WISH_TOTAL_TIME = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RspGuildWishTotalTimesMessage",
        BODY      = "GuildSystem.RspGuildWishTotalTimesMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会许愿池次数同步
    GUILD_RESPONSE_GUILD_WISH_COUNT = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_UpdateGuildWishDailyTimesMessage",
        BODY      = "GuildSystem.UpdateGuildWishDailyTimesMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会许愿池许愿列表
    GUILD_REQ_GUILD_WISH_LIST = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildWishContentMessage",
        BODY      = "GuildSystem.ReqGuildWishContentMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 公会许愿池许愿列表返回
    GUILD_RESPONSE_GUILD_WISH_LIST = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RspGuildWishContentMessage",
        BODY      = "GuildSystem.RspGuildWishContentMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 新公会的公会贡献请求
    GUILD_REQ_GUILD_TEAM_MEDAL = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildTeamMedalMessage",
        BODY      = "GuildSystem.ReqGuildTeamMedalMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 新公会的公会贡献返回
    GUILD_RESPONSE_GUILD_TEAM_MEDAL= {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_SyncGuildTeamMedalMessage",
        BODY      = "GuildSystem.SyncGuildTeamMedalMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会信息请求
    GUILD_REQ_SIMPLE_GUILD_INFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqSimpleGuildInfoMessage",
        BODY      = "GuildSystem.ReqSimpleGuildInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 公会信息返回
    GUILD_ASW_SIMPLE_GUILD_INFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_AswSimpleGuildInfoMessage",
        BODY      = "GuildSystem.AswSimpleGuildInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会招募发布请求
    GUILD_REQ_RECRUIT_MEMBER_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqRecruitMemberMessage",
        BODY      = "GuildSystem.ReqRecruitMemberMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 公会招募接收信息
    GUILD_RECRUIT_MEMBER_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RecruitMemberMessage",
        BODY      = "GuildSystem.RecruitMemberMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会邀请请求
    GUILD_INVITE_JOIN_GUILD_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_InviteJoinGuildMessage",
        BODY      = "GuildSystem.InviteJoinGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 公会邀请返回
    GUILD_ASW_INVITE_JOIN_GUILD_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_AswInviteJoinGuildMessage",
        BODY      = "GuildSystem.AswInviteJoinGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 公会日志请求
    GUILD_REQ_LOG_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqLogMessage",
        BODY      = "GuildSystem.ReqLogMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 公会日志返回
    GUILD_ASW_LOG_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_AswLogMessage",
        BODY      = "GuildSystem.AswLogMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会职级自定义修改请求
    GUILD_REQ_CHANGE_TITLE_NAME_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ModifyGuildTitleMessage",
        BODY      = "GuildSystem.ModifyGuildTitleMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 公会职级自定义修改返回
    GUILD_ASW_CHANGE_TITLE_NAME_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_SyncGuildTitleMessage",
        BODY      = "GuildSystem.SyncGuildTitleMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 公会邀请失败返回
    GUILD_INVITE_JOIN_GUILD_FAILED_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_InviteJoinGuildFailedMessage",
        BODY      = "GuildSystem.InviteJoinGuildFailedMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求购买公会个人buf
    GUILD_REQ_BUY_PERSONAL_BUF_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildBossBuyPersonalBuffMessage",
        BODY      = "GuildSystem.ReqGuildBossBuyPersonalBuffMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 请求购买公会个人buf响应
    GUILD_BUY_PERSONAL_BUF_RESULT_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RspGuildBossBuyPersonalBuffMessage",
        BODY      = "GuildSystem.RspGuildBossBuyPersonalBuffMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 请求购买令状 CO
    GUILD_BUY_WRIT_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_ReqGuildBuyWritMessage",
        BODY      = "GuildSystem.ReqGuildBuyWritMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 回复购买令状 OC
    GUILD_RSP_BUY_WRIT_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_RspGuildBuyWritMessage",
        BODY      = "GuildSystem.RspGuildBuyWritMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- 通知令状信息 OC
    GUILD_NTY_WRIT_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_NtfGuildWritMessage",
        BODY      = "GuildSystem.NtfGuildWritMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    --收到公会拍卖宝藏数据
    GUILD_RSP_ALL_TREASURE_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_OpenTreasureMessage",
        BODY      = "GuildSystem.OpenTreasureMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    --收到公会拍卖鉴定
    GUILD_RSP_INDENTIFY_TREASURE_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_IdentifyTreasureMessage",
        BODY      = "GuildSystem.IdentifyTreasureMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- 公会拍卖主界面数据返回
    GUILD_RSP_AUCTION_INFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_SyncAuctionDataMessage",
        BODY      = "GuildSystem.SyncAuctionDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- 公会拍卖出价后数据返回
    GUILD_RSP_AUCTION_BUY_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_BidAuctionItemMessage",
        BODY      = "GuildSystem.AuctionBidPriceMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- 公会拍卖其他人出价后数据广播
    GUILD_RSP_AUCTION_BUY_SYNC_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_SyncAuctionItemMessage",
        BODY      = "GuildSystem.SyncAuctionItemMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- 公会拍卖记录返回
    GUILD_RSP_AUCTION_LOG_MESSAGE = {
        CATEGORY  = NetMessageCategory.GUILD,
        HEAD      = "Type_CheckAuctionLogMessage",
        BODY      = "GuildSystem.AuctionLogMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- 队伍聊天消息
    CHAT_TEAM_MESSAGE = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_TeamChatMessage",
        BODY      = "ChatSystem.TeamChatMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 队伍聊天消息
    CHAT_NEAR_MESSAGE = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_NearChatMessage",
        BODY      = "ChatSystem.NearChatMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 工会聊天消息
    CHAT_GUILD_MESSAGE = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_GuildChatMessage",
        BODY      = "ChatSystem.GuildChatMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 世界频道聊天消息
    CHAT_WORLD_MESSAGE = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_WorldChatMessage",
        BODY      = "ChatSystem.WorldChatMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 私聊消息
    CHAT_PRIVATE_MESSAGE = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_PrivateChatMessage",
        BODY      = "ChatSystem.PrivateChatMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --私聊消息错误码
    CHAT_ERROR_MESSAGE= {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_PrivateChatErrorMessage",
        BODY      = "ChatSystem.PrivateChatErrorMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --通知客户端有新的系统公告(可以从web拉取公告了)  空协议
    CHAT_NEW_SYSTEM_BROADCAST= {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_NotifyNewSystemBroadcastMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    ----通知客户端有跑马灯数据
    CHAT_RUNNING_LAMP = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_NotifyNewRunningLampMessage",
        BODY      = "ChatSystem.NotifyNewRunningLampMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    CHAT_RUNNING_LAMP = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_NotifyNewRunningLampMessage",
        BODY      = "ChatSystem.NotifyNewRunningLampMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    CHAT_SYNC_CD_TIME = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_SyncChatCDMessage",
        BODY      = "ChatSystem.SyncChatCDMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    ----通知客户端所有跑马灯数据
    NOTIFY_ALL_RUNNING_LAMP_DATAS = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_NotifyAllRunningLampMessage",
        BODY      = "ChatSystem.NotifyAllRunningLampMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    REQUEST_ALL_RUNNING_LAMP_DATAS = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_GetAllRunningLampMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    ----通知客户端聊天禁言
    HERO_BAN_CHAT = {
        CATEGORY  = NetMessageCategory.CHAT,
        HEAD      = "Type_HeroBanChatMessage",
        BODY      = "ChatSystem.HeroBanChatMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --请求排行榜数据
    RANK_REQUEST_RANK_LIST = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_RequestRankListMessage",
        BODY      = "RankSystem.RequestRankListMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    --回应排行榜数据
    RANK_RESPONSE_RANK_LIST = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_ResponseRankListMessage",
        BODY      = "RankSystem.ResponseRankListMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    --请求排行榜玩家数据
    RANK_REQUEST_RANK_HERO_INFO = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_RequestRankHeroInfoMessage",
        BODY      = "RankSystem.RequestRankHeroInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CR
    },
    --回应排行榜玩家数据
    RANK_RESPONSE_RANK_HERO_INFO = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_ResponseRankHeroInfoMessage",
        BODY      = "RankSystem.ResponseRankHeroInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CR 请求指定id排行
    RANK_REQUEST_SPECIFY_RANK = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_RequestSpecifyRankingMessage",
        BODY      = "RankSystem.RequestSpecifyRankingMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --RC 返回指定id排行
    RANK_RESPONSE_SPECIFY_RANK = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_ResponseSpecifyRankingMessage",
        BODY      = "RankSystem.ResponseSpecifyRankingMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CR 请求指定宠物模板id排行
    RANK_REQUEST_PET_RANK = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_RequestPetRankMessage",
        BODY      = "RankSystem.RequestPetRankMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --RC 返回指定宠物模板id排行
    RANK_RESPONSE_PET_RANK = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_ResponsePetRankMessage",
        BODY      = "RankSystem.ResponsePetRankMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CS 请求自定排行榜数据
    RANK_REQUEST_CUSTOM_RANK_LIST = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_ReqCustomRankListMessage",
        BODY      = "RankSystem.ReqCustomRankListMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --FC 返回自定排行榜数据
    RANK_RESPONSE_CUSTOM_RANK_LIST = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_RespCustomRankListMessage",
        BODY      = "RankSystem.RespCustomRankListMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求自定排行榜英雄数据
    RANK_REQUEST_CUSTOM_RANK_HERO_DETAIL_DATA = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_ReqCustomRankHeroDetailDataMessage",
        BODY      = "RankSystem.ReqCustomRankHeroDetailDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --FC 返回自定排行榜英雄数据
    RANK_RESPONSE_CUSTOM_RANK_HERO_DETAIL_DATA = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_RespCustomRankHeroDetailDataMessage",
        BODY      = "RankSystem.RespCustomRankHeroDetailDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS SF 请求自定排行玩家所属子榜数据
    RANK_REQUEST_CUSTOM_RANK_SELF_INDEX_DATA = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_ReqCustomRankSelfIndexDataMessage",
        BODY      = "RankSystem.ReqCustomRankSelfIndexDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --FC 请求自定排行玩家所属子榜数据返回
    RANK_RESPONSE_CUSTOM_RANK_SELF_INDEX_DATA = {
        CATEGORY  = NetMessageCategory.RANK,
        HEAD      = "Type_RespCustomRankSelfIndexDataMessage",
        BODY      = "RankSystem.RespCustomRankSelfIndexDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    --CS 大秘境 战斗结束领奖
    DUNGEON_REQUEST_BATTLE_REWARD = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReceiveDungeonRewardMessage",
        BODY      = "RoleSystem.ReceiveDungeonRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    --CS
    ROLE_GREEDY_SELECT_REQ = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqGreedyChoiceMessage",
        BODY      = "RoleSystem.ReqGreedyChoiceMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --CS
    ROLE_GREEDY_SELECT_REP = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RspGreedyChoiceMessage",
        BODY      = "RoleSystem.RspGreedyChoiceMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CS 切换技能请求
    ROLE_REQ_SWITCH_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqSkillSwitchMessage",
        BODY      = "RoleSystem.ReqSkillSwitchMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 切换技能响应
    ROLE_RSP_SWITCH_SKILL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RspSkillSwitchMessage",
        BODY      = "RoleSystem.RspSkillSwitchMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    ---------------
    ------好友------
    ---------------
    
    --好又列表请求
    FRIEND_REQUEST_ALL_LIST = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_RequestFriendMessage",
        BODY      = "FriendSystem.RequestFriendMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    --好友列表响应
    FRIEND_REPONSE_ALL_LIST = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_LoadFriendArchiveMessage",
        BODY      = "FriendSystem.LoadFriendArchiveMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --删除好友
    FRIEND_DELETE_REQUEST = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_RequestDeleteFriendMessage",
        BODY      = "FriendSystem.RequestDeleteFriendMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    --删除好友响应
    FRIEND_DELETE_REPONSE = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_ResponseDeleteFriendMessage",
        BODY      = "FriendSystem.ResponseDeleteFriendMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --发送好友申请
    FRIEND_INVITE_REQUEST = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_RequestInviteFriendMessage",
        BODY      = "FriendSystem.RequestInviteFriendMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    --发送好友申请响应I
    FRIEND_INVITE_REPONSE = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_ReponseInviteFriendMessage",
        BODY      = "FriendSystem.ReponseInviteFriendMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --发送同意 or 拒绝 好友请求
    FRIEND_HANDLE_INVITE_REQUEST = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_RequestConfirmFriendInviteMessage",
        BODY      = "FriendSystem.RequestConfirmFriendInviteMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    --同意 or 拒绝 好友请求响应
    FRIEND_HANDLE_INVITE_REPONSE = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_ResponseConfirmFriendInviteMessage",
        BODY      = "FriendSystem.ResponseConfirmFriendInviteMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --notify  好友邀请通知
    FRIEND_INVITE_NOTIYF = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_NewFriendInviteMessage",
        BODY      = "FriendSystem.NewFriendInviteMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --notify  添加新好友
    FRIEND_NEW_FRIEND_NOTIYF = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_AddNewFriendMessage",
        BODY      = "FriendSystem.AddNewFriendMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --DO OC 加载好友列表信息
    FRIENT_LOAD_FRIEND_ARCHIVE = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_LoadFriendArchiveMessage",
        BODY      = "FriendSystem.LoadFriendArchiveMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求批量删除好友消息 CO
    FRIENT_REQ_BATCH_REMOVE = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_ReqBatchRemoveFriendMessage",
        BODY      = "FriendSystem.ReqBatchRemoveFriendMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- 回复批量删除好友消息 OC
    FRIENT_RSP_BATCH_REMOVE = {
        CATEGORY  = NetMessageCategory.FRIEND,
        HEAD      = "Type_AswBatchRemoveFriendMessage",
        BODY      = "FriendSystem.AswBatchRemoveFriendMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --加载邮件列表
    MAIL_LOAD_LIST_MESSAGE = {
        CATEGORY  = NetMessageCategory.MAIL,
        HEAD      = "Type_LoadMailListMessage",
        BODY      = "MailSystem.LoadMailListMessage",
        NO        = 0,
        DIRECTION = NetDirection.RC
    },
    --通知新邮件列表
    MAIL_NOTIFY_LIST_MESSAGE = {
        CATEGORY  = NetMessageCategory.MAIL,
        HEAD      = "Type_NotifyMailListMessage",
        BODY      = "MailSystem.NotifyMailListMessage",
        NO        = 0,
        DIRECTION = NetDirection.RC
    },
    --请求邮件奖励
    MAIL_REQUEST_ACCEPT_AWARD = {
        CATEGORY  = NetMessageCategory.MAIL,
        HEAD      = "Type_RequestAcceptAwardMessage",
        BODY      = "MailSystem.RequestAcceptAwardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CR
    },
    --响应邮件奖励
    MAIL_RESPONSE_ACCEPT_AWARD = {
        CATEGORY  = NetMessageCategory.MAIL,
        HEAD      = "Type_ResponseAcceptAwardMessage",
        BODY      = "MailSystem.ResponseAcceptAwardMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --删除邮件请求
    MAIL_DELETE_REQUEST = {
        CATEGORY  = NetMessageCategory.MAIL,
        HEAD      = "Type_DeleteMailMessage",
        BODY      = "MailSystem.DeleteMailMessage",
        NO        = 0,
        DIRECTION = NetDirection.CR
    },
    --删除邮件响应
    MAIL_DELETE_RESPONSE = {
        CATEGORY  = NetMessageCategory.MAIL,
        HEAD      = "Type_DeleteMailMessage",
        BODY      = "MailSystem.DeleteMailMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 获取订单号
    PURCHASE_REQ_PURCHASE = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqPurchaseMessage",
        BODY      = "PurchaseSystem.ReqPurchaseMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- 返回订单号
    PURCHASE_RESPONSE_ORDER = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ResponseOrderMessage",
        BODY      = "PurchaseSystem.ResponseOrderMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    -- 请求产品信息
    PURCHASE_REQUEST_PRODUCTS = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqProductListMessage",
        BODY      = "PurchaseSystem.ReqProductListMessage",
        NO        = 0,
        DIRECTION = NetDirection.CI
    },
    -- 返回产品信息
    PURCHASE_RESPONSE_PRODUCTS = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ResProductListMessage",
        BODY      = "PurchaseSystem.ResProductListMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    -- 请求已经购买过的商品的数量
    PURCHASE_REQ_PRODUCTBOUGHTNUM = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqHeroProductBoughtNumMessage",
        BODY      = "PurchaseSystem.ReqHeroProductBoughtNumMessage",
        NO        = 0,
        DIRECTION = NetDirection.CI
    },
    -- 返回已经购买过的商品的数量
    PURCHASE_RESPONSE_PRODUCTBOUGHTNUM = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_HeroProductBoughtNumMessage",
        BODY      = "PurchaseSystem.HeroProductBoughtNumMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    PURCHASE_VERIFY = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_PurchaseVerifyMessage",
        BODY      = "PurchaseSystem.PurchaseVerifyMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    DELIVER_PRODUCT_RESULT_MESSAGE = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_DeliverProductResultMessage",
        BODY      = "PurchaseSystem.DeliverProductResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    REQ_PURCHASE_ERROR = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqPurchaseErrorMessage",
        BODY      = "PurchaseSystem.ReqPurchaseErrorMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    UPDATE_IAPSHOP_BOX_NUMS = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_NoticeProductUpdateMessage",
        BODY      = "PurchaseSystem.NoticeProductUpdateMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    -- 添加活动信息
    ACTIVITY_ADD_ACTIVITY_TEMP = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_AddActivityTempMessage",
        BODY      = "ActivitySystem.AddActivityTempMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 删除活动
    ACTIVITY_DEL_ACTIVITY_TEMP = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_DelActivityTempMessage",
        BODY      = "ActivitySystem.DelActivityTempMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 更新活动的状态
    ACTIVITY_ACTIVITY_STATUS_UPDATE = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ActivityStatUpdateMessage",
        BODY      = "ActivitySystem.ActivityStatUpdateMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 角色活动数据
    ACTIVITY_HERO_ACTIVITY_DATA = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_HeroActivityDataMessage",
        BODY      = "ActivitySystem.HeroActivityDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 更新活动信息
    ACTIVITY_UPDATE_ACTIVITY_COUNT = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_UpdateActivityCountMessage",
        BODY      = "ActivitySystem.UpdateActivityCountMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 活动领奖
    ACTIVITY_REQUEST_ACTIVITY_REWARD = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_GetActivityRewardMessage",
        BODY      = "ActivitySystem.GetActivityRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 活动领奖结果
    ACTIVITY_REPONSE_ACTIVITY_REWARD = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_GetActivityRewardResultMessage",
        BODY      = "ActivitySystem.GetActivityRewardResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    --活动副本 begin
    --请求匹配
    ACTIVITY_REQUEST_MATCH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ReqMatchMessage",
        BODY      = "ActivitySystem.ReqMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --通知匹配结果
    ACTIVITY_REPONSE_MATCH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_AswMatchMessage",
        BODY      = "ActivitySystem.AswMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --请求取消匹配   无内容
    ACTIVITY_REQUEST_CANCLE_MATCH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ReqCancelMatchMessage",
        BODY      = "ActivitySystem.ReqCancelMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --通知取消匹配   无内容
    ACTIVITY_REPONSE_CANCLE_MATCH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_AswCancelMatchMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --匹配成功  无内容
    ACTIVITY_NOTIFY_MATCH_SUCCESS = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_MatchSucMessage",
        BODY      = "ActivitySystem.MatchSucMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --确认匹配  无内容
    ACTIVITY_REQUEST_SURE_MATCH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_SureMatchMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    --响应确认匹配
    ACTIVITY_REPONSE_SURE_MATCH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ReponseSureMatchMessage",
        BODY      = "ActivitySystem.ReponseSureMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --倒计时结束取消匹配(有玩家没有点击确认) 无内容
    ACTIVITY_NOTIFY_COUNT_DOWN_CANCLE_MATCH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_NotifyCountdownCancelMatchMessage",
        BODY      = "ActivitySystem.NotifyCountdownCancelMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --活动结束结束取消匹配 清理掉所有状态
    ACTIVITY_NOTIFY_END_CANCLE_MATCH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_CancelMatchMessage",
        BODY      = "ActivitySystem.CancelMatchMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --活动房间里面人员变动
    ACTIVITY_ROOM_MEMBER_CHANGE = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_RoomMemberChangeMessage",
        BODY      = "ActivitySystem.RoomMemberChangeMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 活动描述修改
    ACTIVITY_DES_UPDATE = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ActivityDescUpdateMessage",
        BODY      = "ActivitySystem.ActivityDescUpdateMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 通用幸运转盘活动 请求
    ACTIVITY_LOTTERY_REQUEST = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ReqLuckyLotteryMessage",
        BODY      = "ActivitySystem.ReqLuckyLotteryMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 通用幸运转盘活动 响应
    ACTIVITY_LOTTERY_RESPONSE = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_LuckyLotteryResultMessage",
        BODY      = "ActivitySystem.LuckyLotteryResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    --技能筛选
    HERO_FIGHT_SKILLS_MESSAGE = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_HeroFightSkillsMessage",
        BODY      = "RoleSystem.HeroFightSkillsMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    HERO_FIGHT_SKILLS_REQ_SET_MESSAGE = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqSetFihgtSkillsMessage",
        BODY      = "RoleSystem.ReqSetFihgtSkillsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    HERO_FIGHT_SKILLS_RES_SET_MESSAGE = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ResponseSetFightSkillsMessage",
        BODY      = "RoleSystem.ResponseSetFightSkillsMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    
    --活动副本 end
    
    -- 领取首充奖励
    RECHARGE_REQUEST_FIRST_RECHARGE = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqFirstChargeRewardMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    RECHARGE_RESPONSE_FIRST_RECHARGE = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqFirstChargeRewardResultMessage",
        BODY      = "PurchaseSystem.ReqFirstChargeRewardResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 领取补给奖励
    RECHARGE_REQUEST_SUPPLY = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqSupplyReceiveMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    RECHARGE_RESPONSE_SUPPLY = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqSupplyReceiveResultMessage",
        BODY      = "PurchaseSystem.ReqSupplyReceiveResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    RECHARGE_REQ_CLAIM_MONTH_SUBS = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqClaimMonthSubscriptionMessage",
        BODY      = "PurchaseSystem.ReqClaimMonthSubscriptionMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    RECHARGE_RESP_CLAIM_MONTH_SUBS = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_RespClaimMonthSubscriptionMessage",
        BODY      = "PurchaseSystem.RespClaimMonthSubscriptionMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 终生会员领取补给奖励
    REQ_LIFETIME_REWARD_MESSAGE = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ReqLifetimeRewardMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 回复终生会员领取补给奖励
    RES_LIFETIME_REWARD_MESSAGE = {
        CATEGORY  = NetMessageCategory.PURCHASE,
        HEAD      = "Type_ResLifetimeRewardMessage",
        BODY      = "PurchaseSystem.ResLifetimeRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 更新实名状态
    REQ_UPDATE_ADULT_TYPE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqUpdateAdultType",
        BODY      = "RoleSystem.ReqUpdateAdultType",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 请求梦境商品信息
    NPC_REQ_DREAM_SHOP = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqDreamShopMessage",
        BODY     = "NPCSystem.ReqDreamShopMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 梦境商人信息
    NPC_DREAM_SHOP = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_DreamShopMessage",
        BODY     = "NPCSystem.DreamShopMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 梦境商店购买商品结果信息
    NPC_DREAM_SHOP_BUY = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_DreamshopBuyResultMessage",
        BODY     = "NPCSystem.DreamshopBuyResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求新锻造信息
    NPC_REQ_EQUIP_FORGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqHeroForgeMessage",
        BODY     = "NPCSystem.HeroForgeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 响应新锻造信息
    NPC_RES_EQUIP_FORGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_HeroForgeResultMessage",
        BODY     = "NPCSystem.HeroForgeResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 响应已解锁的锻造信息
    NPC_RES_UNLOCK_EQUIP_FORGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_HeroForgeDataMessage",
        BODY     = "NPCSystem.HeroForgeDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 探险队消息
    NPC_EXPEDITION = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ExpeditionMessage",
        BODY     = "NPCSystem.ExpeditionMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 请求开始探险
    NPC_REQ_START_EXPEDITION = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqStartExpeditionMessage",
        BODY     = "NPCSystem.ReqStartExpeditionMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 返回开始探险
    NPC_RESPONSE_START_EXPEDITION = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspStartExpeditionMessage",
        BODY     = "NPCSystem.RspStartExpeditionMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- 请求停止探险
    NPC_REQ_STOP_EXPEDITION = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqStopExpeditionMessage",
        BODY     = "NPCSystem.ReqStopExpeditionMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- SC 返回停止探险
    NPC_RESPONSE_STOP_EXPEDITION = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspStopExpeditionMessage",
        BODY     = "NPCSystem.RspStopExpeditionMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 请求快速探险消息
    NPC_REQ_QUICK_EXPEDITION = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqQuickExpeditionMessage",
        BODY     = "NPCSystem.ReqQuickExpeditionMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 响应快速探险消息
    NPC_RESPONSE_QUICK_EXPEDITION = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspQuickExpeditionMessage",
        BODY     = "NPCSystem.RspQuickExpeditionMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 新分解接口
    NPC_REQ_NEW_DECOMPOSE_EQUIP = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqNewDecomposeEquipMessage",
        BODY     = "NPCSystem.ReqNewDecomposeEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 新分解接口
    NPC_RESPONSE_NEW_DECOMPOSE_EQUIP = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspNewDecomposeEquipMessage",
        BODY     = "NPCSystem.RspNewDecomposeEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 新出售接口
    NPC_REQ_NEW_SELL_GOODS = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqNewSellGoodsMessage",
        BODY     = "NPCSystem.ReqNewSellGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 新出售接口
    NPC_RESPONSE_NEW_SELL_GOODS = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspNewSellGoodsMessage",
        BODY     = "NPCSystem.RspNewSellGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 获取奖励
    NPC_REQ_EXPEDITION_GET_AWARD = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqExpeditionGetAwardMessage",
        BODY     = "NPCSystem.ReqExpeditionGetAwardMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 获取奖励
    NPC_RESPONSE_EXPEDITION_GET_AWARD = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspExpeditionGetAwardMessage",
        BODY     = "NPCSystem.RspExpeditionGetAwardMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 通知同屏探险状态
    NPC_NOTICE_EXPEDITION_SCREEN_INFO = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_NtfExpeditionScreenInfoMessage",
        BODY     = "NPCSystem.NtfExpeditionScreenInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 公会商店购买
    NPC_REQUEST_GUILD_SHOP_BUY = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqBuyGuildGoodsMessage",
        BODY     = "NPCSystem.ReqBuyGuildGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 公会商店购买结果
    NPC_RESPONSE_GUILD_SHOP_BUY = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_BuyGuildGoodsResultMessage",
        BODY     = "NPCSystem.BuyGuildGoodsResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- SC 新公会随机商店返回结果
    NPC_RESPONSE_GUILD_RANDOM_SHOP_BUY = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_BuyGuildRandomGoodsResultMessage",
        BODY     = "NPCSystem.BuyGuildRandomGoodsResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 公会随机商店刷新时间查询
    NPC_REQUEST_GUILD_RANDOM_SHOP_REFRESH_TIME = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGuildRandomShopsRefreshTimeMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 公会随机商店刷新时间查询返回
    NPC_RESPONSE_GUILD_RANDOM_SHOP_REFRESH_TIME = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGuildRandomShopsRefreshTimeResultMessage",
        BODY     = "NPCSystem.ReqGuildRandomShopsRefreshTimeResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 快捷购买
    NPC_REQUEST_FAST_BUY = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqFastBuyMessage",
        BODY     = "NPCSystem.ReqFastBuyMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 快捷购买结果
    NPC_RESPONSE_FAST_BUY = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspFastBuyMessage",
        BODY     = "NPCSystem.RspFastBuyMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 请求移除装备等级限制
    NPC_REQUEST_EQUIP_LEVEL_REMOVE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqEquipLevelRemoveMessage",
        BODY     = "NPCSystem.ReqEquipLevelRemoveMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 反馈移除装备等级限制
    NPC_RESPONSE_EQUIP_LEVEL_REMOVE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RspEquipLevelRemoveMessage",
        BODY     = "NPCSystem.RspEquipLevelRemoveMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 购买梦境宝库请求
    NPC_REQUEST_BUY_DREANM_VALUT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqBuyDreamVaultGoodsMessage",
        BODY     = "NPCSystem.ReqBuyDreamVaultGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --购买梦境宝库响应
    NPC_RESPONSE_BUY_DREANM_VALUT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_BuyDreamVaultGoodsResultMessage",
        BODY     = "NPCSystem.DreamshopBuyResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- worldboss 世界boss广播：状态消息 报名、开始战斗、截止入场、结束战斗
    ACTIVITY_WORLDBOSS_STATE_BROADCAST = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_WorldBossBroadcastStateMessage",
        BODY     = "ActivitySystem.WorldBossBroadcastStateMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- worldboss 加入世界boss
    ACTIVITY_REQ_JOIN_WORLDBOSS = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_WorldBossReqJoinMessage",
        BODY     = "ActivitySystem.WorldBossReqJoinMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- worldboss 报名房间的信息
    ACTIVITY_RESP_WORLDBOSS_ROOM_INFO = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_WorldBossRoomInfoMessage",
        BODY     = "ActivitySystem.WorldBossRoomInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- worldboss 房间信息更新
    ACTIVITY_RESP_WORLDBOSS_ROOM_INFO_UPDATE = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_WorldBossUpdateRoomMemberMessage",
        BODY     = "ActivitySystem.WorldBossUpdateRoomMemberMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- worldboss 退出房间
    ACTIVITY_REQ_WORLDBOSS_QUIT_ROOM = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_WorldBossQuitRoomMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- worldboss 更换房间
    ACTIVITY_REQ_WORLDBOSS_CHANGE_ROOM = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_WorldBossChangeRoomMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- worldboss 确认参战
    ACTIVITY_REQ_WORLDBOSS_PREPARE_BATTLE = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_WorldBossPrepareBattleMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- worldboss 个人数据更新
    ACTIVITY_RESP_WORLDBOSS_PERSONAL_DATA_UPDATE = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_WorldBossSyncPersonalDataMessage",
        BODY     = "ActivitySystem.WorldBossSyncPersonalDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 请求扭曲空间全局事件  无消息内容
    ACTIVITY_DISTORTED_SPACE_REQ_GLOBAL_EVENT_DATA = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_DistortedSpaceReqGlobalEventDataMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 回复扭曲空间全局事件
    ACTIVITY_DISTORTED_SPACE_RSW_GLOBAL_EVENT_DATA = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_DistortedSpaceAswGlobalEventDataMessage",
        BODY     = "ActivitySystem.DistortedSpaceAswGlobalEventDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 兑换商店请求兑换
    ACTIVITY_REQUEST_PURCHASE_EXCHANGE_SHOP = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_ReqPurchaseExchangeShopGoodsMessage",
        BODY     = "ActivitySystem.ReqPurchaseExchangeShopGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 兑换商店请求兑换返回
    ACTIVITY_RESPONSE_PURCHASE_EXCHANGE_SHOP = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_RespPurchaseExchangeShopGoodsMessage",
        BODY     = "ActivitySystem.RespPurchaseExchangeShopGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求更新分享活动分享时间
    ACTIVITY_REQUEST_SET_SHARE_TIME = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_ReqSetShareTimeMessage",
        BODY     = "ActivitySystem.ReqSetShareTimeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 返回款更新分享活动分享时间
    ACTIVITY_RESPONSE_SET_SHARE_TIME = {
        CATEGORY = NetMessageCategory.ACTIVITY,
        HEAD     = "Type_RespSetShareTimeMessage",
        BODY     = "ActivitySystem.RespSetShareTimeMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --play 
    PLAY_BIG_CRACK_INFO_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_NtfBigCrackInfoMessage",
        BODY     = "PlaySystem.NtfBigCrackInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 请求葫芦数据
    PLAY_REQUEST_HULU_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqHuluDataMessage",
        BODY     = "PlaySystem.ReqHuluDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- 返回葫芦数据
    PLAY_RESPONSE_HULU_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RspHuluDataMessage",
        BODY     = "PlaySystem.RspHuluDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 请求选择武器
    PLAY_REQUEST_HULU_SELECT_WEAPON = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqHuluSelectWeaponMessage",
        BODY     = "PlaySystem.ReqHuluSelectWeaponMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- 选择武器的返回
    PLAY_REPONSE_HULU_SELECT_WEAPON = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RspHuluSelectWeaponMessage",
        BODY     = "PlaySystem.RspHuluSelectWeaponMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    -- 请求设置技能
    PLAY_REQUEST_HULU_SET_SKILL = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqHuluSetSkillMessage",
        BODY     = "PlaySystem.ReqHuluSetSkillMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- 设置技能的返回
    PLAY_RESPONSE_HULU_SET_SKILL = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RspHuluSetSkillMessage",
        BODY     = "PlaySystem.RspHuluSetSkillMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    
    -- 发送随机出的待选 遗产数据
    PLAY_NOICE_HULU_RAND_LEGACY = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_NtfHuluRandLegacyMessage",
        BODY     = "PlaySystem.NtfHuluRandLegacyMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 选择遗产
    PLAY_REQUEST_HULU_SELECT_LEGACY = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqHuluSelectLegacyMessage",
        BODY     = "PlaySystem.ReqHuluSelectLegacyMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 选择遗产的返回
    PLAY_RESPONSE_HULU_SELECT_LEGACY = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RspHuluSelectLegacyMessage",
        BODY     = "PlaySystem.RspHuluSelectLegacyMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 记忆翻牌请求结算
    PLAY_REQUEST_PUZZLE_RESULT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqPuzzleSettleMessage",
        BODY     = "PlaySystem.ReqPuzzleSettleMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 记忆翻牌返回结算
    PLAY_RESPONSE_PUZZLE_RESULT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RspPuzzleSettleMessage",
        BODY     = "PlaySystem.RspPuzzleSettleMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    PLAY_REQ_LOSTREALM_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqLostRealmDataMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    PLAY_RESPONSE_LOSTREALM_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespLostRealmDataMessage",
        BODY     = "PlaySystem.RespLostRealmDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 扔骰子/领取圈奖励
    PLAY_REQ_LOSTREALM_OPERATE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqLostRealmOperateMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    PLAY_RESPONSE_LOSTREALM_OPERATE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespLostRealmOperateMessage",
        BODY     = "PlaySystem.RespLostRealmOperateMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CS 反斗乐 请求抽
    PLAY_REQ_MARBLES_FEVER_DRAW = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqMarblesFeverDrawMessage",
        BODY     = "PlaySystem.ReqMarblesFeverDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --CS 反斗乐 抽完返回
    PLAY_RESPONSE_MARBLES_FEVER_DRAW = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespMarblesFeverDrawMessage",
        BODY     = "PlaySystem.RespMarblesFeverDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 限时反斗乐 请求抽
    PLAY_REQ_LIMITED_MARBLES_FEVER_DRAW = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqLimitedMarblesFeverDrawMessage",
        BODY     = "PlaySystem.ReqLimitedMarblesFeverDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --CS 限时反斗乐 抽完返回
    PLAY_RESPONSE_LIMITED_MARBLES_FEVER_DRAW = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespLimitedMarblesFeverDrawMessage",
        BODY     = "PlaySystem.RespLimitedMarblesFeverDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 同步QQ大厅礼包数据
    PLAY_SYNC_QQ_GAME_HALL_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_SyncGameHallDataMessage",
        BODY     = "PlaySystem.SyncGameHallDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 请求领取游戏大厅新手礼包
    PLAY_REQ_GAME_HALL_NEWBIE_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqClaimGameHallNewbieGiftMessage",
        BODY     = "PlaySystem.ReqClaimGameHallNewbieGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 请求领取游戏大厅新手礼包
    PLAY_RESPONSE_GAME_HALL_NEWBIE_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespClaimGameHallNewbieGiftMessage",
        BODY     = "PlaySystem.RespClaimGameHallNewbieGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 请求领取游戏大厅每日礼包
    PLAY_REQ_GAME_HALL_DAILY_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqClaimGameHallDailyGiftMessage",
        BODY     = "PlaySystem.ReqClaimGameHallDailyGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 请求领取游戏大厅新手礼包
    PLAY_RESPONSE_GAME_HALL_DAILY_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespClaimGameHallDailyGiftMessage",
        BODY     = "PlaySystem.RespClaimGameHallDailyGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 请求领取游戏大厅成长礼包
    PLAY_REQ_GAME_HALL_LEVEL_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqClaimGameHallLevelGiftMessage",
        BODY     = "PlaySystem.ReqClaimGameHallLevelGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 请求领取游戏大厅成长礼包
    PLAY_RESPONSE_GAME_HALL_LEVEL_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespClaimGameHallLevelGiftMessage",
        BODY     = "PlaySystem.RespClaimGameHallLevelGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 请求领取游戏大厅大玩咖特权礼包
    PLAY_REQ_GAME_HALL_MOGUL_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqClaimBigShotGiftMessage",
        BODY     = "PlaySystem.ReqClaimBigShotGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 请求领取游戏大厅大玩咖特权礼包
    PLAY_RESPONSE_GAME_HALL_MOGUL_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespClaimBigShotGiftMessage",
        BODY     = "PlaySystem.RespClaimBigShotGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 请求领取游戏大厅大玩咖周礼包
    PLAY_REQ_GAME_HALL_MOGUL_WEEKLY_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqClaimBigShotWeeklyGiftMessage",
        BODY     = "PlaySystem.ReqClaimBigShotWeeklyGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 请求领取游戏大厅大玩咖特权礼包
    PLAY_RESPONSE_GAME_HALL_MOGUL_WEEKLY_GIFT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespClaimBigShotWeeklyGiftMessage",
        BODY     = "PlaySystem.RespClaimBigShotWeeklyGiftMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步客户端
    PLAY_SYNC_PARTICIPATE_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_SyncParticipateDataMessage",
        BODY     = "PlaySystem.SyncParticipateDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求领取全服参与奖
    PLAY_REQ_CLAIM_PARTICIPATE_AWARD = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqClaimParticipateAwardMessage",
        BODY     = "PlaySystem.ReqClaimParticipateAwardMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求领取全服参与奖结果
    PLAY_RESPONSE_CLAIM_PARTICIPATE_AWARD = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespClaimParticipateAwardMessage",
        BODY     = "PlaySystem.RespClaimParticipateAwardMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --logic 相关
    --SC 下发通行证全量数据
    LOGIC_BATTLE_PASS_ALL_DATA = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_BattlePassDataMessage",
        BODY     = "LogicSystem.BattlePassData",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CS 通行证领奖请求
    LOGIC_REQ_GET_BP_AWARD = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_ReqBattlePassGetAwardMessage",
        BODY     = "LogicSystem.ReqBattlePassGetAwardMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 通行证领奖响应
    LOGIC_RSP_GET_BP_AWARD  = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_RspBattlePassGetAwardMessage",
        BODY     = "LogicSystem.RspBattlePassGetAwardMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --SC 战斗通行证商店购买请求
    LOGIC_REQ_BUY_BP_SHOP  = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_ReqBuyBattlePassGoodsMessage",
        BODY     = "LogicSystem.ReqBuyBattlePassGoodsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    LOGIC_RSP_BUY_BP_SHOP  = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_BuyBattlePassGoodsResultMessage",
        BODY     = "LogicSystem.BuyBattlePassGoodsResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    LOGIC_RAT_USE_HAMMER_REQ  = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_ReqRatUseHammerMessage",
        BODY     = "LogicSystem.ReqRatUseHammerMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    LOGIC_RAT_INFO_NTF = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_NtfRatInfoMessage",
        BODY     = "LogicSystem.NtfRatInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    LOGIC_RAT_USE_HAMMER_RES = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_RspRatUseHammerMessage",
        BODY     = "LogicSystem.RspRatUseHammerMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --SC 春节签到
    LOGIC_FESTIVAL_SIGN_DATA  = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_FestivalSignDataMessage",
        BODY     = "LogicSystem.FestivalSignData",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    --CS 春节签到请求
    LOGIC_REQ_FESTIVAL_SIGN = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_ReqFestivalSignMessage",
        BODY     = "LogicSystem.ReqFestivalSignMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 春节签到响应
    LOGIC_RSP_FESTIVAL_SIGN  = {
        CATEGORY = NetMessageCategory.LOGIC,
        HEAD     = "Type_RspFestivalSignMessage",
        BODY     = "LogicSystem.RspFestivalSignMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CO 请求导师推荐列表   无消息内容
    MENTOR_REQUEST_RECOMMEND_TUTOR_LIST_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_RequestRecommendTutorListMessage",
        BODY     = "",
        NO       = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 回复导师推荐列表
    MENTOR_RESPONSE_RECOMMEND_TUTOR_LIST_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_ReponseRecommendTutorListMessage",
        BODY     = "TutorSystem.ReponseRecommendTutorListMessage",
        NO       = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CS 申请导师
    MENTOR_REQUEST_INVITE_TUTOR_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_RequestInviteTutorMessage",
        BODY     = "TutorSystem.RequestInviteTutorMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 回复申请导师
    MENTOR_RESPONSE_INVITE_TUTOR_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_ReponseInviteTutorResultMessage",
        BODY     = "TutorSystem.ReponseInviteTutorResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求确认关系
    MENTOR_CONFIRM_TUTOR_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_ConfirmTutorMessage",
        BODY     = "TutorSystem.ConfirmTutorMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 回复确认关系
    MENTOR_CONFIRM_TUTOR_RESULT_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_ConfirmTutorResultMessage",
        BODY     = "TutorSystem.ConfirmTutorResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 回复加载导师关系
    MENTOR_LOAD_TUTOR_ARCHIVE_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_LoadTutorArchiveMessage",
        BODY     = "TutorSystem.LoadTutorArchiveMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求导师好评差评
    MENTOR_TUTOR_INTERACT_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_TutorInteractMessage",
        BODY     = "TutorSystem.TutorInteractMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 回复导师好评差评
    MENTOR_TUTOR_INTERACT_RESULT_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_TutorInteractResultMessage",
        BODY     = "TutorSystem.TutorInteractResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS SC 导师任务改变
    MENTOR_TUTOR_TASK_CHANGE_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_TutorTaskChangeMessage",
        BODY     = "TutorSystem.TutorTaskChangeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 申请师徒领奖
    MENTOR_GET_TUTOR_REWARD_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_GetTutorRewardMessage",
        BODY     = "TutorSystem.GetTutorRewardMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 回复师徒领奖
    MENTOR_GET_TUTOR_REWARD_RESULT_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_GetTutorRewardResultMessage",
        BODY     = "TutorSystem.GetTutorRewardResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 登录推送消息
    MENTOR_ROLE_TUTOR_DATA_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_RoleTutorDataMessage",
        BODY     = "TutorSystem.RoleTutorDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 设置不当导师
    MENTOR_TUTOR_SETTING_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_TutorSettingMessage",
        BODY     = "TutorSystem.TutorSettingMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 设置不当导师
    MENTOR_CLEAR_REQUEST_LIST_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_ClearRequestListMessage",
        BODY     = "TutorSystem.ClearRequestListMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 同屏师徒称号更新
    MENTOR_NTF_TUTOR_CHANGE_MESSAGE = {
        CATEGORY = NetMessageCategory.MENTOR,
        HEAD     = "Type_NtfTutorChangeMessage",
        BODY     = "TutorSystem.NtfTutorChangeMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --宠物信息同屏同步
    PET_SCREEN_PET_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ScreenPetMessage",
        BODY     = "PetSystem.ScreenPetMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --CS 宠物详细信息
    PET_REQUEST_DETAIL_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetRemoteViewMessage",
        BODY     = "PetSystem.PetRemoteViewMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物详细信息
    PET_RESPONSE_DETAIL_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ResponsePetRemoteViewMessage",
        BODY     = "PetSystem.ResponsePetRemoteViewMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 英雄使用技能（包括普通技能）,这里设计为在开始战斗使用普攻技能，技能，在次使用普攻技能，三种情况才触发
    PET_USE_SKILL_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetUseSkillMessage",
        BODY     = "PetSystem.PetUseSkillMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 服务端返回客户端的使用技能结果消息
    PET_USE_SKILL_RESULT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetUseSkillResultMessage",
        BODY     = "PetSystem.PetUseSkillResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 通知玩家技能冷却
    PET_NTF_SKILL_COOLDOWN_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_NotifyPetSkillCooldownMessage",
        BODY     = "PetSystem.NotifyPetSkillCooldownMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 刷新所有技能CD消息
    PET_REFRESH_ALL_SKILL_CD_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RefreshAllSkillCDMessage",
        BODY     = "PetSystem.RefreshAllSkillCDMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 角色受到的BUFF
    PET_ADD_BUFF_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetAddBuffMessage",
        BODY     = "PetSystem.PetAddBuffMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 角色移除的BUFF
    PET_REMOVE_BUFF_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetRemoveBuffMessage",
        BODY     = "PetSystem.PetRemoveBuffMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 角色受到的效果(主要是表现)
    PET_ADD_EFFECT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetAddEffectMessage",
        BODY     = "PetSystem.PetAddEffectMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 英雄当前实装技能列表
    PET_GET_SKILL_LIST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSkillListMessage",
        BODY     = "PetSystem.PetSkillListMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 英雄当前实装BUFF列表
    PET_GET_BUFF_LIST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetBuffListMessage",
        BODY     = "PetSystem.PetBuffListMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 刷新某类buff消息
    PET_REFRESH_BUFF_BY_KIND_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RefreshBuffByKindMessage",
        BODY     = "PetSystem.RefreshBuffByKindMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 按buff实例ID来刷新某个buff
    PET_REFRESH_BUFF_BY_INSTID_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RefreshBuffByInstIDMessage",
        BODY     = "PetSystem.RefreshBuffByInstIDMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 宠物复活请求
    PET_REVIVE_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetReviveRequestMessage",
        BODY     = "PetSystem.PetReviveRequestMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 宠物复活响应
    PET_REVIVE_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetReviveResponseMessage",
        BODY     = "PetSystem.PetReviveResponseMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物出战请求
    PET_TOFIGHT_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetToFightRequestMessage",
        BODY     = "PetSystem.PetToFightRequestMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物出战响应
    PET_TOFIGHT_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetToFightResponseMessage",
        BODY     = "PetSystem.PetToFightRequestMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 宠物出战状态
    PET_TOFIGHT_STATUS_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetToFightStatusMessage",
        BODY     = "PetSystem.PetToFightStatusMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 兽栏出战请求
    PETSITE_TOFIGHT_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSiteReqTakePetOutMessage",
        BODY     = "PetSystem.PetSiteReqTakePetOutMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 兽栏出战响应
    PETSITE_TOFIGHT_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSiteRespTakePetOutMessage",
        BODY     = "PetSystem.PetSiteRespTakePetOutMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 初始化所有宠物信息
    PET_INIT_DATA_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetInitMessage",
        BODY     = "PetSystem.PetInitMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 宠物数据变化
    PET_CHANGE_DATA_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetDataChangeMessage",
        BODY     = "PetSystem.PetDataChangeMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 开宠物蛋返回
    PET_GET_NEW_PET_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_GetNewPetMessage",
        BODY     = "PetSystem.GetNewPetMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物吃经验丹请求
    PET_LEVELUP_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetUpLevelMessage",
        BODY     = "PetSystem.PetUpLevelMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物吃经验丹响应
    PET_LEVELUP_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ResponsePetUpLevelMessage",
        BODY     = "PetSystem.ResponsePetUpLevelMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物吃洗炼丹请求
    PET_REBORN_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetRebornMessage",
        BODY     = "PetSystem.PetRebornMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物吃洗炼丹响应
    PET_REBORN_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ResponsePetRebornMessage",
        BODY     = "PetSystem.ResponsePetRebornMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物吃资质丹请求
    PET_RAISE_TALENT_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetUpTalentMessage",
        BODY     = "PetSystem.PetUpTalentMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物吃资质丹响应
    PET_RAISE_TALENT_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ResponsePetUpTalentMessage",
        BODY     = "PetSystem.ResponsePetUpTalentMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物学习技能请求
    PET_LEARN_SKILL_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetStudySkillMessage",
        BODY     = "PetSystem.PetStudySkillMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物学习技能响应
    PET_LEARN_SKILL_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ResponsePetStudySkillMessage",
        BODY     = "PetSystem.ResponsePetStudySkillMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物改名请求
    PET_RENAME_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetChangeNameMessage",
        BODY     = "PetSystem.PetChangeNameMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物改名响应
    PET_RENAME_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ResponsePetChangeNameMessage",
        BODY     = "PetSystem.ResponsePetChangeNameMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 宠物改名同屏
    PET_RENAME_NOTIFY_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetNameChangeMessage",
        BODY     = "PetSystem.PetNameChangeMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    --CS 宠物合成请求
    PET_COMPOSE_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetMergeMessage",
        BODY     = "PetSystem.PetMergeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物合成响应
    PET_COMPOSE_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ResponsePetMergeMessage",
        BODY     = "PetSystem.ResponsePetMergeMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物炼化请求
    PET_REFINE_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetRefineMessage",
        BODY     = "PetSystem.PetRefineMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物炼化响应
    PET_REFINE_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ResponsePetRefineMessage",
        BODY     = "PetSystem.ResponsePetRefineMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物一键炼化请求
    PET_SEND_MULTIPLE_REFINE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_MultiplePetRefineMessage",
        BODY     = "PetSystem.MultiplePetRefineMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物一键炼化响应
    PET_RESPONSE_MULTIPLE_REFINE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ResponseMultiplePetRefineMessage",
        BODY     = "PetSystem.ResponseMultiplePetRefineMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物继承请求
    PET_INHERIT_REQUEST_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetInheritSkillMessage",
        BODY     = "PetSystem.ReqInheritPetSkillMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物继承响应
    PET_INHERIT_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespPetInheritSkillMessage",
        BODY     = "PetSystem.InheritPetSkillResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 宠物宝藏收集信息
    PET_TREASURE_INFO_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RsqPetTreasureCollectionMessage",
        BODY     = "PetSystem.RsqPetTreasureCollectionMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物宝藏派遣采集
    PET_TREASURE_SEND_GATHER_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqSendPetsMessage",
        BODY     = "PetSystem.ReqSendPetsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --OS 宠物宝藏派遣采集响应
    PET_TREASURE_RESPONSE_GATHER_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RsqSendPetsMessage",
        BODY     = "PetSystem.RsqSendPetsMessage",
        NO       = 0,
        DIRECTION = NetDirection.OS
    },
    
    --CO 宠物宝藏派遣召回请求
    PET_TREASURE_SEND_CALLBACK_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqRecallPetsMessage",
        BODY     = "PetSystem.ReqRecallPetsMessage",
        NO       = 0,
        DIRECTION = NetDirection.CO
    },
    
    --OS 宠物宝藏派遣召回响应
    PET_TREASURE_RESPONSE_CALLBACK_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RsqRecallPetsMessage",
        BODY     = "PetSystem.RsqRecallPetsMessage",
        NO       = 0,
        DIRECTION = NetDirection.OS
    },
    
    --OC 宠物宝藏碎片更新消息
    PET_TREASURE_RESPONSE_FRAGMENTS_UPDATE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_FragmentsUpdateMessage",
        BODY     = "PetSystem.FragmentsUpdateMessage",
        NO       = 0,
        DIRECTION = NetDirection.OC
    },
    
    --CS 宠物宝藏碎片发起挑战
    PET_TREASURE_SEND_CHALLENGE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ChallengeFightMessage",
        BODY     = "PetSystem.ReqChallengeFightMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --OC 宠物宝藏碎片发起挑战结果响应
    PET_TREASURE_RESPONSE_CHALLENGE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespChallengeFightMessage",
        BODY     = "PetSystem.RespChallengeFightMessage",
        NO       = 0,
        DIRECTION = NetDirection.OC
    },
    
    --CS 宠物宝藏碎片挑战信息请求
    PET_TREASURE_SEND_CHALLENGE_INFO_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqFragmentsCollectMessage",
        BODY     = "PetSystem.ReqChallengeInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.CO
    },
    
    --OC 宠物宝藏碎片挑战信息响应
    PET_TREASURE_RESPONSE_CHALLENGE_INFO_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RsqFragmentsCollectMessage",
        BODY     = "PetSystem.RspChallengeInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.OC
    },
    
    --CS 宠物宝藏碎片合成
    PET_TREASURE_SEND_COMBINEFRAGMENT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_CombineFragmentMessage",
        BODY     = "PetSystem.CombineFragmentMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物宝藏碎片合成响应
    PET_TREASURE_RESPONSE_COMBINEFRAGMENT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespCombineFragmentMessage",
        BODY     = "PetSystem.RespCombineFragmentMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CO 宠物宝藏碎片挑战记录信息请求
    PET_TREASURE_SEND_CHALLENGE_RECORDS_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ChallengedLogMessage",
        BODY     = "PetSystem.ReqChallengedLogMessage",
        NO       = 0,
        DIRECTION = NetDirection.CO
    },
    
    --OC 宠物宝藏碎片挑战记录信息响应
    PET_TREASURE_RESPONSE_CHALLENGE_RECORDS_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespChallengedLogMessage",
        BODY     = "PetSystem.RespChallengedLogMessage",
        NO       = 0,
        DIRECTION = NetDirection.OC
    },
    
    --CS 发起复仇
    PET_TREASURE_SEND_CHALLENGE_REVENGE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ChallengedRevengeMessage",
        BODY     = "PetSystem.ReqChallengedRevengeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --OC 复仇结果
    PET_TREASURE_RESPONSE_CHALLENGE_REVENGE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespChallengedRevengeMessage",
        BODY     = "PetSystem.RespChallengedRevengeMessage",
        NO       = 0,
        DIRECTION = NetDirection.OC
    },
    
    --SC 宠物删除实例（合成、炼化）
    PET_REMOVE_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetRemoveMessage",
        BODY     = "PetSystem.PetRemoveMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 玩家上线主动推送的宠物模板历史解锁列表
    PET_UNLOCK_LIST_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetUnlockListMessage",
        BODY     = "PetSystem.PetUnlockListMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 解锁了新的宠物模板
    PET_UNLOCK_ONE_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetUnlockOneMessage",
        BODY     = "PetSystem.PetUnlockOneMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 宠物场景数据
    PET_PVP_SCREEN_DATA_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSceneDataMessage",
        BODY     = "PetSystem.PetSceneDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 宠物对战结束
    PET_PVP_FIGHT_END_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetVersusEndMessage",
        BODY     = "PetSystem.PetVersusEndMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 宠物对战战报
    PET_PVP_FIGHT_RECORD_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_FightReportMessage",
        BODY     = "PetSystem.FightReportMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 请求画册数据
    PET_ALBUM_DETAIL_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqPetAlbumDetailMessage",
        BODY     = "PetSystem.ReqPetAlbumDetailMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 返回画册数据
    PET_ALBUM_DETAIL_RESPONSE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespPetAlbumDetailMessage",
        BODY     = "PetSystem.RespPetAlbumDetailMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步画册通知数据
    PET_ALBUM_DETAIL_SYNC_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_SyncPetAlbumNotificationMessage",
        BODY     = "PetSystem.SyncPetAlbumNotificationMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求穿戴装备
    PET_REQ_WEAR_PET_EQUIPMENT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqWearPetEquipmentMessage",
        BODY     = "PetSystem.ReqWearPetEquipmentMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    -- SC 穿戴装备返回
    PET_RESP_WEAR_PET_EQUIPMENT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespWearPetEquipmentMessage",
        BODY     = "PetSystem.RespWearPetEquipmentMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 强化宠物装备请求
    PET_REQ_STRENGTHEN_EQUIPMENT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqStrengthenEquipmentMessage",
        BODY     = "PetSystem.ReqStrengthenEquipmentMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 强化宠物装备返回
    PET_RESP_STRENGTHEN_EQUIPMENT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespStrengthenEquipmentMessage",
        BODY     = "PetSystem.RespStrengthenEquipmentMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 骑乘宠物请求
    PET_REQ_RIDE_PET_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqRidePetMessage",
        BODY     = "PetSystem.ReqRidePetMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 骑乘宠物返回
    PET_RESP_RIDE_PET_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespRidePetMessage",
        BODY     = "PetSystem.RespRidePetMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步到屏幕周围骑行状态
    PET_SYNC_RIDE_PET_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_SyncRidePetMessage",
        BODY     = "PetSystem.SyncRidePetMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 梦境神秘兑换所刷新
    NPC_REQ_DREAM_EXCHANGE_SHOP = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqRefreshDreamExchangeShopMessage",
        BODY     = "NPCSystem.ReqRefreshDreamExchangeShopMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 梦境神秘兑换所刷新
    NPC_RSP_DREAM_EXCHANGE_SHOP = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespRefreshDreamExchangeShopMessage",
        BODY     = "NPCSystem.RespRefreshDreamExchangeShopMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 请求解锁兽栏
    PETSITE_REQ_ACTIVATE_SITE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSiteReqActivateSiteMessage",
        BODY     = "PetSystem.PetSiteReqActivateSiteMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 返回解锁兽栏结果
    PETSITE_RSP_ACTIVATE_SITE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSiteRespActivateSiteMessage",
        BODY     = "PetSystem.PetSiteRespActivateSiteMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求升级兽栏
    PETSITE_REQ_UPGRADE_SITE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSiteReqUpgradeSiteMessage",
        BODY     = "PetSystem.PetSiteReqUpgradeSiteMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 返回升级兽栏结果
    PETSITE_RSP_UPGRADE_SITE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSiteRespUpgradeSiteMessage",
        BODY     = "PetSystem.PetSiteRespUpgradeSiteMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 兽栏请求出战
    PETSITE_REQ_PET_SITE_TAKE_OUT = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSiteReqTakePetOutMessage",
        BODY     = "PetSystem.PetSiteReqTakePetOutMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 返回兽栏请求出战结果
    PETSITE_RSP_PET_SITE_TAKE_OUT = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetSiteRespTakePetOutMessage",
        BODY     = "PetSystem.PetSiteRespTakePetOutMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 同步宠物探险数据
    PET_ADV_DATA_REQ_SYNC_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqSyncPetAdventureDataMessage",
        BODY     = "PetSystem.ReqSyncPetAdventureDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 同步宠物探险数据
    PET_ADV_DATA_SYNC_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_SyncPetAdventureDataMessage",
        BODY     = "PetSystem.SyncPetAdventureDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 宠物探险：请求挑战
    PET_ADV_REQ_CHALLENGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetAdventureReqChallengeMessage",
        BODY     = "PetSystem.PetAdventureReqChallengeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 宠物探险：请求挑战返回
    PET_ADV_RSP_CHALLENGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetAdventureRespChallengeMessage",
        BODY     = "PetSystem.PetAdventureRespChallengeMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 宠物探险：请求探索
    PET_ADV_REQ_EXPLORE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetAdventureReqStartAdventureMessage",
        BODY     = "PetSystem.PetAdventureReqStartAdventureMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 宠物探险：请求探索返回
    PET_ADV_RSP_EXPLORE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetAdventureRespStartAdventureMessage",
        BODY     = "PetSystem.PetAdventureRespStartAdventureMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 宠物探险：停止探索
    PET_ADV_REQ_EXPLORE_STOP = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetAdventureReqStopAdventureMessage",
        BODY     = "PetSystem.PetAdventureReqStopAdventureMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 宠物探险：停止探索返回
    PET_ADV_RSP_EXPLORE_STOP = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_PetAdventureRespStopAdventureMessage",
        BODY     = "PetSystem.PetAdventureRespStopAdventureMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 宠物探险：请求生成宠物机器人数据
    PET_ADV_REQ_GUARD_DATA = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqRobotPetDataMessage",
        BODY     = "PetSystem.ReqRobotPetDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 宠物探险：返回生成宠物机器人数据
    PET_ADV_RSP_GUARD_DATA = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespRobotPetDataMessage",
        BODY     = "PetSystem.RespRobotPetDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 请求(切换)进入庄园场景(CS SO 请求进入玩家庄园）
    MANOR_ENTER_MANOR_SCENE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqEnterManorSceneMessage",
        BODY      = "ManorSystem.ReqEnterManorSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- OS SC 进入玩家庄园结果
    MANOR_ENTER_MANOR_SCENE_RESOULT = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespEnterManorSceneMessage",
        BODY      = "ManorSystem.RespEnterManorSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 开始钓鱼请求
    MANOR_ENTER_MANOR_FISH_REQ_STARTFISH = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_Fish_Req_StartFish",
        BODY      = "ManorSystem.Fish_Req_StartFish",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 开始钓鱼回执
    MANOR_ENTER_MANOR_FISH_RES_STARTFISH = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_Fish_Res_StartFish",
        BODY      = "ManorSystem.Fish_Res_StartFish",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 钓鱼结果请求
    MANOR_ENTER_MANOR_FISH_REQ_FISHRESULT = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_Fish_Req_FishResult",
        BODY      = "ManorSystem.Fish_Req_FishResult",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 钓鱼结果回执
    MANOR_ENTER_MANOR_FISH_RES_FISHRESULT = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_Fish_Res_FishResult",
        BODY      = "ManorSystem.Fish_Res_FishResult",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步庄园个人数据到客户端 Client 
    MANOR_ENTER_MANOR_SYNC_MANOR_PERSON_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_SyncManorBaseDataMessage",
        BODY      = "ManorSystem.SyncManorBaseDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --OS SC 同步庄园通用数据到客户端 Client
    MANOR_ENTER_MANOR_SYNC_MANOR_SOCIAL_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_SyncManorSceneDataMessage",
        BODY      = "ManorSystem.SyncManorSceneDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    -- 响应：玩家进入场景
    MANOR_ENTER_SCENE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_EnterSceneMessage",
        BODY      = "",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 庄园商店购买
    MANOR_REQ_FISH_SHOP_BUY = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqManorShopBuyMessage",
        BODY      = "ManorSystem.ReqManorShopBuyMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 庄园商店购买
    MANOR_RSP_FISH_SHOP_BUY = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespManorShopBuyMessage",
        BODY      = "ManorSystem.RespManorShopBuyMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- OC 更新行商信息给客户端 
    MANOR_TYPE_PEDLERY_UPDATE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_Pedlery_Update",
        BODY      = "ManorSystem.Pedlery_UpdateMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CS 行商贩卖商品请求 
    MANOR_TYPE_PEDLERY_REQ_SALE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_Pedlery_Req_Sale",
        BODY      = "ManorSystem.Pedlery_Req_SaleMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 行商贩卖商品回执
    MANOR_TYPE_PEDLERY_RES_SALE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_Pedlery_Res_Sale",
        BODY      = "ManorSystem.Pedlery_Res_SaleMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 行商同步材料信息
    MANOR_SYNC_PEDLERY_MATERIAL_DATA = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_SyncPedleryMaterialData",
        BODY      = "ManorSystem.SyncPedleryMaterialData",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 行商选择材料
    MANOR_REQ_CHOOSE_PEDLERY_MATERIAL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqChoosePedleryMaterial",
        BODY      = "ManorSystem.ReqChoosePedleryMaterial",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 行商选择材料
    MANOR_RESP_CHOOSE_PEDLERY_MATERIAL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespChoosePedleryMaterial",
        BODY      = "ManorSystem.RespChoosePedleryMaterial",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓幻化架↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    --CS 请求激活（装备）幻化
    MANOR_TYPE_REQ_ILLUSION_ACTIVATE_EQUIP_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqIllusionActivateEquipMessage",
        BODY      = "ManorSystem.ReqIllusionActivateEquipMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 激活（装备）幻化返回
    MANOR_TYPE_RESP_ILLUSION_ACTIVATE_EQUIP_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespIllusionActivateEquipMessage",
        BODY      = "ManorSystem.RespIllusionActivateEquipMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --  CS 请求幻化展示
    MANOR_TYPE_REQ_ILLUSION_SHOW_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqIllusionShowMessage",
        BODY      = "ManorSystem.ReqIllusionShowMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 幻化展示请求返回
    MANOR_TYPE_RESP_ILLUSION_SHOW_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespIllusionShowMessage",
        BODY      = "ManorSystem.RespIllusionShowMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC  同步庄园幻化数据
    MANOR_TYPE_SYNC_ILLUSION_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_SyncIllusionDataMessage",
        BODY      = "ManorSystem.SyncIllusionDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓书桌/星图↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    
    --星图数据同步
    MANOR_TYPE_SYNC_STAR_ATLAS_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_SyncStarAtlasDataMessage",
        BODY      = "ManorSystem.SyncStarAtlasDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --星图培养请求
    MANOR_TYPE_REQ_STAR_ATLAS_CULTURE_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqStarAtlasCultureMessage",
        BODY      = "ManorSystem.ReqStarAtlasCultureMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --星图培养返回
    MANOR_TYPE_RESP_STAR_ATLAS_CULTURE_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespStarAtlasCultureMessage",
        BODY      = "ManorSystem.RespStarAtlasCultureMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --星图升级请求
    MANOR_TYPE_REQ_STAR_ATLAS_UPGRADE_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqStarAtlasUpgradeMessage",
        BODY      = "ManorSystem.ReqStarAtlasUpgradeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --星图升级返回
    MANOR_TYPE_RESP_STAR_ATLAS_UPGRADE_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespStarAtlasUpgradeMessage",
        BODY      = "ManorSystem.RespStarAtlasUpgradeMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --星辰卡镶嵌请求
    MANOR_TYPE_REQ_STAR_ATLAS_EQUIP_CARD_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqStarAtlasEquipCardMessage",
        BODY      = "ManorSystem.ReqStarAtlasEquipCardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --星辰卡镶嵌级返回
    MANOR_TYPE_RESP_STAR_ATLAS_EQUIP_CARD_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespStarAtlasEquipCardMessage",
        BODY      = "ManorSystem.RespStarAtlasEquipCardMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --星辰卡开始升级请求
    MANOR_TYPE_REQ_STAR_CARD_START_UPGRADE_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqStarCardStartUpgradeMessage",
        BODY      = "ManorSystem.ReqStarCardStartUpgradeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --星辰卡开始升级返回
    MANOR_TYPE_RESP_STAR_CARD_START_UPGRADE_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespStarCardStartUpgradeMessage",
        BODY      = "ManorSystem.RespStarCardStartUpgradeMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --星辰卡直接升级完成请求
    MANOR_TYPE_REQ_STAR_CARD_UPGRADE_DIRECTLY_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqStarCardUpgradeDirectlyMessage",
        BODY      = "ManorSystem.ReqStarCardUpgradeDirectlyMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    --星辰卡直接升级完成返回
    MANOR_TYPE_RESP_STAR_CARD_UPGRADE_DIRECTLY_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespStarCardUpgradeDirectlyMessage",
        BODY      = "ManorSystem.RespStarCardUpgradeDirectlyMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步建筑数据（增量更新，全量数据在刚上线时 Type_SyncManorPersonDataMessage） 
    MANOR_TYPE_SYNC_BUILD_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_SyncBuildDataMessage",
        BODY      = "ManorSystem.SyncBuildDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 通知星辰卡解锁
    MANOR_TYPE__NOTIFY_STAR_CARD_UNLOCKED_MESSAGE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_NotifyStarCardUnlockedMessage",
        BODY      = "ManorSystem.NotifyStarCardUnlockedMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑书桌/星图↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    
    -- 虚空秘境
    ROLE_SYNC_VOIDRIFT_INFO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfVoidRiftInfoMessage",
        BODY      = "RoleSystem.NtfVoidRiftInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 选择虚空秘境宝石请求
    ROLE_REQ_SELECT_VOIDRIFT_RUNE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqSelectVoidRiftRuneMessage",
        BODY      = "RoleSystem.ReqSelectVoidRiftRuneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 选择虚空秘境宝石返回
    ROLE_RESP_SELECT_VOIDRIFT_RUNE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespSelectVoidRiftRuneMessage",
        BODY      = "RoleSystem.RespSelectVoidRiftRuneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 同步虚空秘境宝石数据
    ROLE_SYNC_VOIDRIFT_RUNE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncVoidRiftRuneMessage",
        BODY      = "RoleSystem.SyncVoidRiftRuneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 通知维京时代信息
    ROLE_SYNC_VIKING_INFO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfVikingInfoMessage",
        BODY      = "RoleSystem.NtfVikingInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 选择维京时代宝石请求
    ROLE_REQ_SELECT_VIKING_RUNE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqSelectVikingRuneMessage",
        BODY      = "RoleSystem.ReqSelectVikingRuneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 选择维京时代宝石返回
    ROLE_RESP_SELECT_VIKING_RUNE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespSelectVikingRuneMessage",
        BODY      = "RoleSystem.RespSelectVikingRuneMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步维京时代宝石数据
    ROLE_SYNC_VIKING_RUNE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncVikingRuneMessage",
        BODY      = "RoleSystem.SyncVikingRuneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 同步月度签到数据
    PLAY_SYNC_MONTHLY_SIGN = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_SyncMonthlySignInDataMessage",
        BODY      = "PlaySystem.SyncMonthlySignInDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 月度签到请求
    PLAY_REQ_MONTHLY_SIGN_IN = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_ReqMonthlySignInSignMessage",
        BODY      = "PlaySystem.ReqMonthlySignInSignMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 月度签到响应
    PLAY_RESP_MONTHLY_SIGN_IN = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_RespMonthlySignInSignMessage",
        BODY      = "PlaySystem.RespMonthlySignInSignMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 月度签到累计奖励领取请求
    PLAY_REQ_MONTHLY_SIGN_CLAIM_REWARD = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_ReqMonthlySignInClaimRewardMessage",
        BODY      = "PlaySystem.ReqMonthlySignInClaimRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 月度签到累计奖励领取响应
    PLAY_RESP_MONTHLY_SIGN_CLAIM_REWARD = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_RespMonthlySignInClaimRewardMessage",
        BODY      = "PlaySystem.RespMonthlySignInClaimRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CO 获取玩家IP信息
    LOGIN_REQ_HERO_CONNECTON_INFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_ReqHeroConnectionInfoMessage",
        BODY      = "LoginSystem.ReqHeroConnectionInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },  
    
    -- OC 获取玩家IP信息返回
    LOGIN_RES_HERO_CONNECTON_INFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_RespHeroConnectionInfoMessage",
        BODY      = "LoginSystem.RespHeroConnectionInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },  

    -- CS 记录网络信息
    LOGIN_REQ_RECORD_NET_INFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.LOGIN,
        HEAD      = "Type_ReqRecordNetInfoMessage",
        BODY      = "LoginSystem.ReqRecordNetInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    
    -- CS 船只替换
    MANOR_REQ_CHANGE_BOAT = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqChangeBoatMessage",
        BODY      = "ManorSystem.ReqChangeBoatMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 船只替换响应
    MANOR_RESP_CHANGE_BOAT = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespChangeBoatMessage",
        BODY      = "ManorSystem.RespChangeBoatMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 新船获得
    MANOR_NOTIFY_GOT_NEW_BOAT = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_NotifyGotNewBoatMessage",
        BODY      = "ManorSystem.NotifyGotNewBoatMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 启航
    MANOR_REQ_SET_SAIL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqSetSailMessage",
        BODY      = "ManorSystem.ReqSetSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 启航响应
    MANOR_RESP_SET_SAIL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespSetSailMessage",
        BODY      = "ManorSystem.RespSetSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 领取航行背包物品请求
    MANOR_REQ_TAKE_SAIL_GOODS = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqTakeSailGoodsMessage",
        BODY      = "ManorSystem.ReqTakeSailGoodsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 领取航行背包物品返回
    MANOR_RESP_TAKE_SAIL_GOODS = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespTakeSailGoodsMessage",
        BODY      = "ManorSystem.RespTakeSailGoodsMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 航海数据同步
    MANOR_SYNC_SAIL_DATA = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_SyncSailDataMessage",
        BODY      = "ManorSystem.SyncSailDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求同步航海数据
    MANOR_REQ_SYNC_SAIL_DATA = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqRefreshSailDataMessage",
        BODY      = "ManorSystem.ReqRefreshSailDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求更改建筑NPC外形
    MANOR_REQ_CHANGE_BUILD_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqChangeBuildFacadeMessage",
        BODY      = "ManorSystem.ReqChangeBuildFacadeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 返回更改建筑NPC外形结果
    MANOR_RESP_CHANGE_BUILD_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespChangeBuildFacadeMessage",
        BODY      = "ManorSystem.RespChangeBuildFacadeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 同步庄园社交数据到客户端
    MANOR_SYNC_MANOR_SOCIAL_DATA = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_SyncManorSocialDataMessage",
        BODY      = "ManorSystem.SyncManorSocialDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步航海日志数据
    MANOR_SYNC_SAIL_LOG = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_SyncSailLogDataMessage",
        BODY      = "ManorSystem.SyncSailLogDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求航海日志数据
    MANOR_REQ_SYNC_SAIL_LOG = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqSailLogDataMessage",
        BODY      = "ManorSystem.ReqSailLogDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CS 请求消耗升级材料
    MANOR_REQ_PUT_IN_BUILD_MATERIAL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqPutInBuildMaterialMessage",
        BODY      = "ManorSystem.ReqPutInBuildMaterialMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求消耗升级材料回执
    MANOR_RSP_PUT_IN_BUILD_MATERIAL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespPutInBuildMaterialMessage",
        BODY      = "ManorSystem.RespPutInBuildMaterialMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    -- CS 请求建筑升级
    MANOR_REQ_UPGRADE_BUILD = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqUpgradeBuildMessage",
        BODY      = "ManorSystem.ReqUpgradeBuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求建筑升级回执
    MANOR_RSP_UPGRADE_BUILD = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespUpgradeBuildMessage",
        BODY      = "ManorSystem.RespUpgradeBuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 餐桌请求进食
    MANOR_REQ_USE_RECIPE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqTableUseRecipeMessage",
        BODY      = "ManorSystem.ReqTableUseRecipeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 餐桌进食返回
    MANOR_RSP_USE_RECIPE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespTableUseRecipeMessage",
        BODY      = "ManorSystem.RespTableUseRecipeMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求更改庄园NPC外形
    MANOR_REQ_CHANGE_MANNOR_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqChangeManorFacadeMessage",
        BODY      = "ManorSystem.ReqChangeManorFacadeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求更改庄园NPC外形
    MANOR_RESP_CHANGE_MANNOR_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespChangeManorFacadeMessage",
        BODY      = "ManorSystem.RespChangeManorFacadeMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求购买庄园外形
    MANOR_REQ_BUY_MANNOR_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqBuyManorFacadeMessage",
        BODY      = "ManorSystem.ReqBuyManorFacadeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求购买庄园外形
    MANOR_RESP_BUY_MANNOR_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespBuyManorFacadeMessage",
        BODY      = "ManorSystem.RespBuyManorFacadeMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 通知客户端获得新庄园外形
    MANOR_NOTIFY_GET_MANNOR_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_NotifyGotNewManorFacadeMessage",
        BODY      = "ManorSystem.NotifyGotNewManorFacadeMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求钻石购买建筑外形
    MANOR_REQ_BUY_BUILD_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqBuyBuildFacadeMessage",
        BODY      = "ManorSystem.ReqBuyBuildFacadeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 钻石购买建筑外形返回
    MANOR_RESP_BUY_BUILD_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespBuyBuildFacadeMessage",
        BODY      = "ManorSystem.RespBuyBuildFacadeMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求钻石购买船只
    MANOR_REQ_BUY_BOAT_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqBuyBoatMessage",
        BODY      = "ManorSystem.ReqBuyBoatMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求钻石购买船只返回
    MANOR_RESP_BUY_BOAT_FACADE = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespBuyBoatMessage",
        BODY      = "ManorSystem.RespBuyBoatMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 终止航行
    MANOR_REQ_STOP_SAIL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqStopSailMessage",
        BODY      = "ManorSystem.ReqStopSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 终止航行
    MANOR_RESP_STOP_SAIL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespStopSailMessage",
        BODY      = "ManorSystem.RespStopSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 提交庄园建筑每日任务升级材料
    MANOR_REQ_COMMIT_MANOR_MATERIAL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqCommitManorMaterialMessage",
        BODY      = "ManorSystem.ReqCommitManorMaterialMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 提交庄园建筑每日任务升级材料
    MANOR_RESP_COMMIT_MANOR_MATERIAL = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespCommitManorMaterialMessage",
        BODY      = "ManorSystem.RespCommitManorMaterialMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 提升庄园等级
    MANOR_REQ_UPGRADE_MANOR = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqUpgradeManorMessage",
        BODY      = "ManorSystem.ReqUpgradeManorMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 提升庄园等级
    MANOR_RESP_UPGRADE_MANOR = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespUpgradeManorMessage",
        BODY      = "ManorSystem.RespUpgradeManorMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 通过物品直接添加经验
    MANOR_REQ_ADD_MANOR_EXP = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_ReqAddManorExpMessage",
        BODY      = "ManorSystem.ReqAddManorExpMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 通过物品直接添加经验
    MANOR_RESP_ADD_MANOR_EXP = {
        CATEGORY  = NetMessageCategory.MANOR,
        HEAD      = "Type_RespAddManorExpMessage",
        BODY      = "ManorSystem.RespAddManorExpMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步周年庆领取数据
    PLAY_SYNC_ANNIVERSARY_SUBSCRIBE_DATA = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_SyncAnniversarySubscribeDataMessage",
        BODY      = "PlaySystem.SyncAnniversarySubscribeDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 周年庆预约全服进度奖励领取请求
    PLAY_REQ_ANNIVERSARY_SUBSCRIBE_CLAIM_AWARD = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_ReqAnniversarySubscribeClaimAwardMessage",
        BODY      = "PlaySystem.ReqAnniversarySubscribeClaimAwardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 周年庆预约全服进度奖励领取返回
    PLAY_RESP_ANNIVERSARY_SUBSCRIBE_CLAIM_AWARD = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_RespAnniversarySubscribeClaimAwardMessage",
        BODY      = "PlaySystem.RespAnniversarySubscribeClaimAwardMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 客户端请求活动副本数据
    PLAY_REQ_DUNGEON_ACTIVITY_DATA = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_ReqDungeonActivityDataMessage",
        BODY      = "PlaySystem.ReqDungeonActivityDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 返回客户端活动副本数据
    PLAY_RESP_DUNGEON_ACTIVITY_DATA = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_RespDungeonActivityDataMessage",
        BODY      = "PlaySystem.RespDungeonActivityDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求进入试练之地
    PLAY_REQ_ENTER_TRIAL_LAND = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_ReqEnterTrialLandMessage",
        BODY      = "PlaySystem.ReqEnterTrialLandMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 进入试练之地结果
    PLAY_RESP_ENTER_TRIAL_LAND = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_RespEnterTrialLandMessage",
        BODY      = "PlaySystem.RespEnterTrialLandMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 领取试炼之地首通奖励
    PLAY_REQ_CLAIM_TRIAL_LAND_DAILY_REWARD = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_ReqClaimTrialLandDailyRewardMessage",
        BODY      = "PlaySystem.ReqClaimTrialLandDailyRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 领取试炼之地首通奖励
    PLAY_RESP_CLAIM_TRIAL_LAND_DAILY_REWARD = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_RespClaimTrialLandDailyRewardMessage",
        BODY      = "PlaySystem.RespClaimTrialLandDailyRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 通知试炼之地副本结算数据
    PLAY_NTF_TRIAL_LAND_SETTLE_DATA = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_NtfTrialLandSettleDataMessage",
        BODY      = "PlaySystem.NtfTrialLandSettleDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 通知客户端试炼之地洞窟数据
    PLAY_SYNC_TRIAL_LAND_CAVE_DATA = {
        CATEGORY  = NetMessageCategory.PLAY,
        HEAD      = "Type_SyncTrialLandCaveDataMessage",
        BODY      = "PlaySystem.SyncTrialLandCaveDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求购买技能页
    ROLE_REQ_BUY_SKILL_LABEL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqBuySkillLabelMessage",
        BODY      = "RoleSystem.ReqBuySkillLabelMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 购买技能页返回
    ROLE_RESP_BUY_SKILL_LABEL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespBuySkillLabelMessage",
        BODY      = "RoleSystem.RespBuySkillLabelMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步已购买的技能页
    ROLE_SYNC_SKILL_LABEL = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_SyncBoughtSkillLabelsMessage",
        BODY      = "RoleSystem.SyncBoughtSkillLabelsMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 客户端请求周年庆抽奖数据
    ACTIVITY_REQ_ANNIVERSARY_LOTTERY_DATA = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ReqAnniversaryLuckyDrawDataMessage",
        BODY      = "ActivitySystem.ReqAnniversaryLuckyDrawDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 客户端请求周年庆抽奖报名
    ACTIVITY_REQ_ANNIVERSARY_LOTTERY_SIGN = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ReqAnniversaryLuckySignMessage",
        BODY      = "ActivitySystem.ReqAnniversaryLuckySignMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 客户端请求周年庆抽奖已阅读过抽奖结果
    ACTIVITY_REQ_ANNIVERSARY_LOTTERY_HAS_READ = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Typd_ReqAnniversaryLuckyReadResultMessage",
        BODY      = "ActivitySystem.ReqAnniversaryLuckyReadResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 周年庆抽奖已阅读抽奖结果
    ACTIVITY_RESP_ANNIVERSARY_LOTTERY_READ_RESULT = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ResAnniversaryLuckyReadResultMessage",
        BODY      = "ActivitySystem.ResAnniversaryLuckyReadResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 客户端请求查看抽奖结果
    ACTIVITY_REQ_ANNIVERSARY_LOTTERY_CHECK_READ_RESULT = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ReqAnniversaryLuckyClientResultMessage",
        BODY      = "ActivitySystem.ReqAnniversaryLuckyClientResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 双怪复活
    ROLE_SYNC_GROUP_MONSTER_REVIVE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReviveGroupMonsterMessage",
        BODY      = "RoleSystem.ReviveGroupMonsterMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求宠物资质加点
    PET_REQ_UP_TALENT_POINT = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqPetUpTalentPointMessage",
        BODY     = "PetSystem.ReqPetUpTalentPointMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求宠物资质加点
    PET_RSP_UP_TALENT_POINT = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespPetUpTalentPointMessage",
        BODY     = "PetSystem.RespPetUpTalentPointMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求重置宠物资质加点
    PET_REQ_RESET_TALENT_POINT = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqPetResetTalentPointMessage",
        BODY     = "PetSystem.ReqPetResetTalentPointMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求重置宠物资质加点
    PET_RSP_RESET_TALENT_POINT = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespPetResetTalentPointMessage",
        BODY     = "PetSystem.RespPetResetTalentPointMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓宠物装备宝石↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    --  CS 宠物宝石：装备打孔
    PET_REQ_DIG_EQUIPMENT_SLOT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqDigEquipmentSlotMessage",
        BODY     = "PetSystem.ReqDigEquipmentSlotMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物宝石：装备打孔（返回）
    PET_RESP_DIG_EQUIPMENT_SLOT_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespDigEquipmentSlotMessage",
        BODY     = "PetSystem.RespDigEquipmentSlotMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物宝石：镶嵌宝石
    PET_REQ_EMBED_EQUIPMENT_GEM_STONE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqEmbedEquipmentGemStoneMessage",
        BODY     = "PetSystem.ReqEmbedEquipmentGemStoneMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物宝石：镶嵌宝石（返回）
    PET_RESP_EMBED_EQUIPMENT_GEM_STONE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespEmbedEquipmentGemStoneMessage",
        BODY     = "PetSystem.RespEmbedEquipmentGemStoneMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物宝石：取下宝石（保留）
    PET_REQ_TAKE_DOWN_EQUIPMENT_GEM_STONE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqTakeDownEquipmentGemStoneMessage",
        BODY     = "PetSystem.ReqTakeDownEquipmentGemStoneMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物宝石：取下宝石（返回）（保留）
    PET_RESP_TAKE_DOWN_EQUIPMENT_GEM_STONE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespTakeDownEquipmentGemStoneMessage",
        BODY     = "PetSystem.RespTakeDownEquipmentGemStoneMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 宠物宝石：吞噬宝石（保留）
    PET_REQ_DEVOUR_EQUIPMENT_GEM_STONE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqDevourEquipmentGemStoneMessage",
        BODY     = "PetSystem.ReqDevourEquipmentGemStoneMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 宠物宝石：吞噬宝石（返回）（保留）
    PET_RESP_DEVOUR_EQUIPMENT_GEM_STONE_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespDevourEquipmentGemStoneMessage",
        BODY     = "PetSystem.RespDevourEquipmentGemStoneMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑宠物装备宝石↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    -- CS 永冬裂缝领取奖励
    ROLE_REQ_GET_EVER_WINTER_RIFT_REWARDS = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqGetEverWinterRiftRewardsMessage",
        BODY      = "RoleSystem.ReqGetEverWinterRiftRewardsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 永冬裂缝领取奖励回复
    ROLE_RSP_GET_EVER_WINTER_RIFT_REWARDS = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespGetEverWinterRiftRewardsMessage",
        BODY      = "RoleSystem.RespGetEverWinterRiftRewardsMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 永冬裂缝副本信息
    ROLE_NTF_EVER_WINTER_RIFT_INFO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtfEverWinterRiftInfoMessage",
        BODY      = "RoleSystem.NtfEverWinterRiftInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    -- CS 请求转生
    ROLE_HERO_REQ_REINCARNATION = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqReincarnationMessage",
        BODY      = "RoleSystem.ReqReincarnationMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 转生回复
    ROLE_HERO_RSP_REINCARNATION = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespReincarnationMessage",
        BODY      = "RoleSystem.RespReincarnationMessage",
        NO        = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- 通知转生信息
    ROLE_NOTIFY_ROLE_REINCARNATION_DATA = { 
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NtReincarnationMessage",
        BODY      = "RoleSystem.NtReincarnationMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓宠物转生↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    -- CS 转生请求
    PET_REQ_REINCARNATION_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqPetReincarnationMessage",
        BODY     = "PetSystem.ReqPetReincarnationMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 转生请求(返回)
    PET_RESP_REINCARNATION_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_RespPetReincarnationMessage",
        BODY      = "PetSystem.RespPetReincarnationMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑宠物转生↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓等级突破↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    -- CS 等级突破请求
    PET_REQ_LVBREAK_MESSAGE = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqLvBreakMessage",
        BODY     = "PetSystem.ReqLvBreakMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 等级突破请求(返回)
    PET_RESP_LVBREAK_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_RespLvBreakMessage",
        BODY      = "PetSystem.RespLvBreakMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑宠物转生↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓水晶夺宝↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    --CS 水晶夺宝 请求抽
    PLAY_REQ_Crystal_Capture_DRAW = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqCrystalTreasureHuntDrawMessage",
        BODY     = "PlaySystem.ReqCrystalTreasureHuntDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --CS 水晶夺宝 抽完返回
    PLAY_RESPONSE_Crystal_Capture_DRAW = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespCrystalTreasureHuntDrawMessage",
        BODY     = "PlaySystem.RespCrystalTreasureHuntDrawMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 水晶夺宝 领取阶段奖励
    PLAY_REQ_Crystal_Capture_GET_AWARDS = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqCrystalTreasureHuntGetReward",
        BODY     = "PlaySystem.ReqCrystalTreasureHuntGetReward",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --CS 水晶夺宝 领取阶段奖励返回
    PLAY_RESPONSE_Crystal_Capture_GET_AWARDS = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespCrystalTreasureHuntGetReward",
        BODY     = "PlaySystem.RespCrystalTreasureHuntGetReward",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑水晶夺宝↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    -- SC 通知模具信息
    ROLE_NTF_MOLD_INFO = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyMoldInfoMessage",
        BODY      = "RoleSystem.NotifyMoldInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求模具锻造
    ROLE_REQ_MOLD_FORGING_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqMoldForgingMessage",
        BODY      = "RoleSystem.ReqMoldForgingMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 模具锻造回复
    ROLE_RSP_MOLD_FORGING_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespMoldForgingMessage",
        BODY      = "RoleSystem.RespMoldForgingMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求模具镶嵌
    ROLE_REQ_MOLD_GEM_INLAID_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqMoldGemstoneInlaidMessage",
        BODY      = "RoleSystem.ReqMoldGemstoneInlaidMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求模具镶嵌回复
    ROLE_RSP_MOLD_GEM_INLAID_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespMoldGemstoneInlaidMessage",
        BODY      = "RoleSystem.RespMoldGemstoneInlaidMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求模具使用
    ROLE_REQ_USE_MOLD_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_ReqUseMoldMessage",
        BODY      = "RoleSystem.ReqUseMoldMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求模具使用回复
    ROLE_RSP_USE_MOLD_MESSAGE = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_RespUseMoldMessage",
        BODY      = "RoleSystem.RespUseMoldMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓水晶夺宝↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    --SC 水晶夺宝 水晶夺宝版本数据
    PLAY_REQ_Crystal_Capture_Notify_Info = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_NotifyCrystalTreasureHuntInfo",
        BODY     = "PlaySystem.NotifyCrystalTreasureHuntInfo",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 水晶夺宝 水晶夺宝请求重置
    PLAY_RESPONSE_Crystal_Capture_HuntWhenEnd = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqCrystalTreasureHuntWhenEnd",
        BODY     = "PlaySystem.ReqCrystalTreasureHuntWhenEnd",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑水晶夺宝↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    
    -----------------------------------------洞窟探宝 ----------------------------------------------------
    -- SC 宝箱消息
    PLAY_SYNC_TREASURE_HUNT_INFO = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_NotifyTreasureHuntInfoMessage",
        BODY     = "PlaySystem.NotifyTreasureHuntInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求开宝箱
    PLAY_REQ_TREASURE_HUNT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqTreasureHuntMessage",
        BODY     = "PlaySystem.ReqTreasureHuntMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求开宝箱回复
    PLAY_RSP_TREASURE_HUNT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespTreasureHuntMessage",
        BODY     = "PlaySystem.RespTreasureHuntMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求刷新宝箱
    PLAY_REQ_REFRESH_TREASURE_HUNT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqRefreshTreasureHuntMessage",
        BODY     = "PlaySystem.ReqRefreshTreasureHuntMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求刷新宝箱回复
    PLAY_RSP_REFRESH_TREASURE_HUNT = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespRefreshTreasureHuntMessage",
        BODY     = "PlaySystem.RespRefreshTreasureHuntMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    ----------------------------------- 洞窟探宝 end------------------------------------------

    -----------------------------------------永冬裂缝扫荡消息 ----------------------------------------------------
    

    -- CS 请求永冬裂缝扫荡
    PLAY_REQ_EVERWINTER_RIFT_SWEEP = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqEverwinterRiftSweepMessage",
        BODY     = "PlaySystem.ReqEverwinterRiftSweepMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求永冬裂缝扫荡
    PLAY_RSP_EVERWINTER_RIFT_SWEEP = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespEverwinterRiftSweepMessage",
        BODY     = "PlaySystem.RespEverwinterRiftSweepMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    -----------------------------------------永冬裂缝扫荡消息 end----------------------------------------------------
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓大航海↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    -- 请求进入玩家港口
    BIGSAIL_ENTER_PORT_SCENE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqEnterBigSailPortfSceneMessage",
        BODY      = "BigSailSystem.ReqEnterBigSailPortfSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- OS SC 进入玩家港口结果
    BIGSAIL_ENTER_PORT_SCENE_RESOULT = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespEnterBigSailPortSceneMessage",
        BODY      = "BigSailSystem.RespEnterBigSailPortSceneMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- OS 同步港口社交数据到客户端
    BIGSAIL_SYNC_PORT_SOCIAL_DATA = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_SyncBigSailPortSocialDataMessage",
        BODY      = "BigSailSystem.SyncBigSailPortSocialDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 同步港口个人基础数据到客户端
    BIGSAIL_SYNC_PORT_BASE_DATA = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_SyncBigSailPortBaseDataMessage",
        BODY      = "BigSailSystem.SyncBigSailPortBaseDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 船坞
    -- CS 航行起航
    BIGSAIL_PORT_REQ_SET_SAIL = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqSetBigSailMessage",
        BODY      = "BigSailSystem.ReqSetBigSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 起航
    BIGSAIL_PORT_RESP_SET_SAIL = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespSetBigSailMessage",
        BODY      = "BigSailSystem.RespSetBigSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 领取航行背包物品请求
    BIGSAIL_PORT_REQ_TAKE_SAIL_GOODS = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqTakeSailGoodsMessage",
        BODY      = "BigSailSystem.ReqTakeSailGoodsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 领取航行背包物品返回
    BIGSAIL_PORT_RESP_TAKE_SAIL_GOODS = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespTakeSailGoodsMessage",
        BODY      = "BigSailSystem.RespTakeSailGoodsMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 航海数据同步
    BIGSAIL_PORT_SYNC_SAIL_DATA = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_SyncSailDataMessage",
        BODY      = "BigSailSystem.SyncSailDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 岛屿
    -- CO 请求岛屿信息
    BIGSAIL_PORT_REQ_ISLAND_INFO = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqIslandInfoMessage",
        BODY      = "BigSailSystem.ReqIslandInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 岛屿信息回复
    BIGSAIL_PORT_RESP_ISLANG_INFO = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespIslandInfoMessage",
        BODY      = "BigSailSystem.RespIslandInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- SC 通知岛屿信息
    BIGSAIL_PORT_NOTIFY_ISLAND_INFO = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyIslandInfoMessage",
        BODY      = "BigSailSystem.NotifyIslandInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CO 请求驱逐某船只
    BIGSAIL_PORT_REQ_EXPULSION_BOAT_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqExpulsionBoatMessage",
        BODY      = "BigSailSystem.ReqExpulsionBoatMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 请求驱逐某船只结果
    BIGSAIL_PORT_RESP_EXPULSION_BOAT_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespExpulsionBoatMessage",
        BODY      = "BigSailSystem.RespExpulsionBoatMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- OC 通知驱逐结果
    BIGSAIL_PORT_NOTIFY_EXPULSION_BOAT_RESULT_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyExpulsionBoatResultMessage",
        BODY      = "BigSailSystem.NotifyExpulsionBoatResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CS 请求领取岛屿奖励
    BIGSAIL_PORT_REQ_GET_OCCUPY_REWARD_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqGetOccupyRewardMessage",
        BODY      = "BigSailSystem.ReqGetOccupyRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求领取岛屿奖励回复
    BIGSAIL_PORT_RESP_GET_OCCUPY_REWARD_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespGetOccupyRewardMessage",
        BODY      = "BigSailSystem.RespGetOccupyRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求设置船员
    BIGSAIL_PORT_REQ_SET_BOAT_PETS_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqSetBoatPetsMessage",
        BODY      = "BigSailSystem.ReqSetBoatPetsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC  请求设置船员回复
    BIGSAIL_PORT_RESP_SET_BOAT_PETS_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespSetBoatPetsMessage",
        BODY      = "BigSailSystem.RespSetBoatPetsMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求设置船员补给
    BIGSAIL_PORT_REQ_SET_BOAT_SUPPLY_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqSetBoatSupplyMessage",
        BODY      = "BigSailSystem.ReqSetBoatSupplyMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求设置船员补给回复
    BIGSAIL_PORT_RESP_SET_BOAT_SUPPLY_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespSetBoatSupplyMessage",
        BODY      = "BigSailSystem.RespSetBoatSupplyMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求购买补给
    BIGSAIL_PORT_REQ_BUY_SUPPLY_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqBuySupplyMessage",
        BODY      = "BigSailSystem.ReqBuySupplyMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求购买补给回复
    BIGSAIL_PORT_RESP_BUY_SUPPLY_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespBuySupplyMessage",
        BODY      = "BigSailSystem.RespBuySupplyMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求购买商品
    BIGSAIL_PORT_REQ_BUY_SAIL_STORE_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqBuyBigSailStoreMessage",
        BODY      = "BigSailSystem.ReqBuyBigSailStoreMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求购买商品回复
    BIGSAIL_PORT_RESP_BUY_SAIL_STORE_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespBuyBigSailStoreMessage",
        BODY      = "BigSailSystem.RespBuyBigSailStoreMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 任务领奖
    BIGSAIL_PORT_REQ_GET_TASK_REWARD_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqGetTaskRewardMessage",
        BODY      = "BigSailSystem.ReqGetTaskRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 任务领奖回复
    BIGSAIL_PORT_RESP_GET_TASK_REWARD_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespGetTaskRewardMessage",
        BODY      = "BigSailSystem.RespGetTaskRewardMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 更新任务信息
    BIGSAIL_PORT_NOTIFY_TASK_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyTaskMessage",
        BODY      = "BigSailSystem.NotifyTaskMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求航行加速
    BIGSAIL_PORT_REQ_SPEED_UP_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqBigSailSpeedUpSailMessage",
        BODY      = "BigSailSystem.ReqBigSailSpeedUpSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求航行加速回复
    BIGSAIL_PORT_RESP_SPEED_UP_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespBigSailSpeedUpSailMessage",
        BODY      = "BigSailSystem.RespBigSailSpeedUpSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 更新船只信息
    BIGSAIL_PORT_NOTIFY_BOAT_INFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyBigSailBoatInfoMessage",
        BODY      = "BigSailSystem.NotifyBigSailBoatInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求取消占领
    BIGSAIL_PORT_REQ_CANCEL_SAIL_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqCancelSailMessage",
        BODY      = "BigSailSystem.ReqCancelSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求取消占领回复
    BIGSAIL_PORT_RESP_CANCEL_SAIL_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespCancelSailMessage",
        BODY      = "BigSailSystem.RespCancelSailMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS boss战斗
    BIGSAIL_PORT_REQ_BOSS_BATTLE_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqBigSailBossBattleMessage",
        BODY      = "BigSailSystem.ReqBigSailBossBattleMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC boss战斗回复
    BIGSAIL_PORT_RESP_BOSS_BATTLE_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespBigSailBossBattleMessage",
        BODY      = "BigSailSystem.RespBigSailBossBattleMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 战斗结束消息
    BIGSAIL_PORT_RESP_BATTLE_END_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyBigSailBattleEndMessage",
        BODY      = "BigSailSystem.NotifyBigSailBattleEndMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CO 设置敌对工会
    BIGSAIL_PORT_REQ_SET_ENEMY_GUILD_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqSetEnemyGuildMessage",
        BODY      = "BigSailSystem.ReqSetEnemyGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 设置敌对工会回复
    BIGSAIL_PORT_RESP_SET_ENEMY_GUILD_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespSetEnemyGuildMessage",
        BODY      = "BigSailSystem.RespSetEnemyGuildMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CO 显示占领岛屿工会信息 [随机]
    BIGSAIL_PORT_REQ_ISLAND_ALL_GUILDS_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqIslandAllGuildsMessage",
        BODY      = "BigSailSystem.ReqIslandAllGuildsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 显示占领岛屿工会信息回复 [随机]
    BIGSAIL_PORT_RESP_ISLAND_ALL_GUILDS_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespIslandAllGuildsMessage",
        BODY      = "BigSailSystem.RespIslandAllGuildsMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    

    -- CS 请求事件数据
    BIGSAIL_PORT_REQ_EVENT_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqEventDataMessage",
        BODY      = "BigSailSystem.ReqEventDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- CO 请求公会事件数据
    BIGSAIL_PORT_REQ_GUILD_EVENT_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqEventDataMessage",
        BODY      = "BigSailSystem.ReqEventDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- SC 请求事件数据回复
    BIGSAIL_PORT_RSP_EVENT_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespEventDataMessage",
        BODY      = "BigSailSystem.RespEventDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- OC 请求事件数据回复 公会
    BIGSAIL_PORT_RSP_GUILD_EVENT_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespEventDataMessage",
        BODY      = "BigSailSystem.RespEventDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- SC 下发大航海事件数据
    BIGSAIL_PORT_NTF_EVENT_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyEventDataMessage",
        BODY      = "BigSailSystem.NotifyEventDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- OC 下发公会大航海事件数据
    BIGSAIL_PORT_NTF_GUILD_EVENT_DATA_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyEventDataMessage",
        BODY      = "BigSailSystem.NotifyEventDataMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CO 请求所有岛屿基础信息
    BIGSAIL_PORT_REQ_ALL_ISLANDS_BASE_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqAllIslandsBaseMessage",
        BODY      = "BigSailSystem.ReqAllIslandsBaseMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 请求所有岛屿基础信息回复
    BIGSAIL_PORT_RESP_ALL_ISLANDS_BASE_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespAllIslandsBaseMessage",
        BODY      = "BigSailSystem.RespAllIslandsBaseMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CO 请求标记集中占领
    BIGSAIL_PORT_REQ_MARK_OCCUPY_ISLAND_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqMarkOccupyIslandMessage",
        BODY      = "BigSailSystem.ReqMarkOccupyIslandMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 请求标记集中占领回复
    BIGSAIL_PORT_RESP_MARK_OCCUPY_ISLAND_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespMarkOccupyIslandMessage",
        BODY      = "BigSailSystem.RespMarkOccupyIslandMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- SC 通知物品更新
    BIGSAIL_PORT_NOTYFY_ITEM_UPDATE_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyItemUpdateMessage",
        BODY      = "BigSailSystem.NotifyItemUpdateMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CO 请求船只详情
    BIGSAIL_PORT_REQ_BOAT_DETAIL_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqBoatDetailMessage",
        BODY      = "BigSailSystem.ReqBoatDetailMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 请求船只详情回复
    BIGSAIL_PORT_RESP_BOAT_DETAIL_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespBoatDetailMessage",
        BODY      = "BigSailSystem.RespBoatDetailMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CO 请求更改岛屿
    BIGSAIL_PORT_REQ_CHANGE_ISLAND_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqChangeIslandMessage",
        BODY      = "BigSailSystem.ReqChangeIslandMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 请求更改岛屿回复
    BIGSAIL_PORT_RESP_CHANGE_ISLAND_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespChangeIslandMessage",
        BODY      = "BigSailSystem.RespChangeIslandMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CS 请求更改岛屿(作用于正在航行的船只更换岛屿)
    BIGSAIL_PORT_REQ_CHANGE_ISLAND_RUNNING_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqChangeIslandMessage",
        BODY      = "BigSailSystem.ReqChangeIslandMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求更改岛屿回复(作用于正在航行的船只更换岛屿)
    BIGSAIL_PORT_RESP_CHANGE_ISLAND_RUNNING_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespChangeIslandMessage",
        BODY      = "BigSailSystem.RespChangeIslandMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CO 请求拉力赛基础信息
    BIGSAIL_BET_REQ_BASEINFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqBetBaseInfoMessage",
        BODY      = "BigSailSystem.ReqBetBaseInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    -- OC 请求拉力赛基础信息
    BIGSAIL_BET_RESP_BASEINFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespBetBaseInfoMessage",
        BODY      = "BigSailSystem.RespBetBaseInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CS 请求投注
    BIGSAIL_BET_REQ_BET_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqBetMessage",
        BODY      = "BigSailSystem.ReqBetMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- SC 请求投注
    BIGSAIL_BET_RESP_BET_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespBetMessage",
        BODY      = "BigSailSystem.RespBetMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求获取竞猜币
    BIGSAIL_BET_REQ_BET_GETITEMNUM_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqGetBetItemNumMessage",
        BODY      = "BigSailSystem.ReqGetBetItemNumMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- SC 请求获取竞猜币
    BIGSAIL_BET_RESP_GETITEMNUM_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespGetBetItemNumMessage",
        BODY      = "BigSailSystem.RespGetBetItemNumMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CO 请求查看往期结果
    BIGSAIL_BET_REQ_LASETBET_RESULT_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqLastBetResultMessage",
        BODY      = "BigSailSystem.ReqLastBetResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    -- OC 请求查看往期结果
    BIGSAIL_BET_RESP_LASETBET_RESULT_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespLastBetResultMessage",
        BODY      = "BigSailSystem.RespLastBetResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- CS 请求使用技能
    BIGSAIL_BET_REQ_USEBETSKILL_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqUseBetSkillMessage",
        BODY      = "BigSailSystem.ReqUseBetSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- SC 请求使用技能
    BIGSAIL_BET_RESP_USEBETSKILL_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespUseBetSkillMessage",
        BODY      = "BigSailSystem.RespUseBetSkillMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 使用道具
    BIGSAIL_BET_REQ_USERBETITEM_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqUseBetItemMessage",
        BODY      = "BigSailSystem.ReqUseBetItemMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- SC 使用道具
    BIGSAIL_BET_RESP_USERBETITEM_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespUseBetItemMessage",
        BODY      = "BigSailSystem.RespUseBetItemMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    -- CO 请求船只事件
    BIGSAIL_BET_REQ_BET_BOATEVENTS_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqBetBoatEventsMessage",
        BODY      = "BigSailSystem.ReqBetBoatEventsMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    -- OC 请求船只事件
    BIGSAIL_BET_RESP_BET_BOATEVENTS_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespBetBoatEventsMessage",
        BODY      = "BigSailSystem.RespBetBoatEventsMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    -- OC 通知船只事件
    BIGSAIL_BET_NOTICE_BOATEVENTS_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyBetBoatEventsMessage",
        BODY      = "BigSailSystem.NotifyBetBoatEventsMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    -- OC 通知基础信息变化
    BIGSAIL_BET_NOTICE_BASEINFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyBetBaseInfoMessage",
        BODY      = "BigSailSystem.NotifyBetBaseInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    }, 
    -- SC 通知个人信息变化
    BIGSAIL_BET_NOTICE_PERSIONINFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyBetPersionInfoMessage",
        BODY      = "BigSailSystem.NotifyBetPersionInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    }, 
    -- OC 通知船只航行信息变化
    BIGSAIL_BET_NOTICE_BET_SAILINFO_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifyBetSailInfoMessage",
        BODY      = "BigSailSystem.NotifyBetSailInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    }, 
    
    -- CS 请求查看个人往期结果
    BIGSAIL_BET_REQ_MY_LASETBET_RESULT_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqMyLastBetResultMessage",
        BODY      = "BigSailSystem.ReqMyLastBetResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    -- SC 请求查看个人往期结果
    BIGSAIL_BET_RESP_MY_LASETBET_RESULT_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespMyLastBetResultMessage",
        BODY      = "BigSailSystem.RespMyLastBetResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- OC 通知结算信息
    BIGSAIL_BET_NOTICE_SETTLE_RESULT_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_NotifySettleResultMessage",
        BODY      = "BigSailSystem.NotifySettleResultMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑大航海↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    ----------------------------------- 限时登录活动 ------------------------------------------
    -- 客户端请求完成限时登录
    ACTIVITY_REQ_TIMELIMITED_LOGIN_FINISH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_ReqTimeLimitedLoginFinishMessage",
        BODY      = "ActivitySystem.ReqTimeLimitedLoginFinishMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 客户端请求完成限时登录结果
    ACTIVITY_RESP_TIMELIMITED_LOGIN_FINISH = {
        CATEGORY  = NetMessageCategory.ACTIVITY,
        HEAD      = "Type_RspTimeLimitedLoginFinishMessage",
        BODY      = "ActivitySystem.RspTimeLimitedLoginFinishMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    ----------------------------------- 限时登录活动 end------------------------------------------
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓魂玉转换↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    -- CS 请求转换魂玉
    PET_GEM_STONE_CONVERT_REQ_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_ReqPetGemConversionMessage",
        BODY      = "PetSystem.ReqPetGemConversionMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求转换魂玉返回
    PET_GEM_STONE_CONVERT_RESP_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_RespPetGemConversionMessage",
        BODY      = "PetSystem.RespPetGemConversionMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求选择魂玉
    PET_GEM_STONE_CONVERT_CHOSE_REQ_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_ReqChoicePetGemConversionMessage",
        BODY      = "PetSystem.ReqChoicePetGemConversionMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求选择魂玉返回
    PET_GEM_STONE_CONVERT_CHOSE_RESP_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_RespChoicePetGemConversionMessage",
        BODY      = "PetSystem.RespChoicePetGemConversionMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求魂玉缓存数据
    PET_GEM_STONE_CONVERT_CACHE_CHOSE_REQ_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_ReqCachePetGemConversionInfoMessage",
        BODY      = "PetSystem.ReqCachePetGemConversionInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 返回魂玉缓存数据
    PET_GEM_STONE_CONVERT_CACHE_CHOSE_RESP_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_RespCachePetGemConversionInfoMessage",
        BODY      = "PetSystem.RespCachePetGemConversionInfoMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },

    -- CS 请求魂玉升阶
    PET_GEM_STONE_CONVERT_REQ_AWAKE_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_ReqPetGemAwakeMessage",
        BODY      = "PetSystem.ReqPetGemAwakeMessage",
        NO        = 0,
        DIRECTION = NetDirection.CS
    },

    PET_GEM_STONE_CONVERT_RESP_AWAKE_MESSAGE = {
        CATEGORY  = NetMessageCategory.PET,
        HEAD      = "Type_RspPetGemAwakeMessage",
        BODY      = "PetSystem.RspPetGemAwakeMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑魂玉转换↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓改造继承↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    -- SC 装备改造继承结果消息
    NPC_REMODEL_INHERIT_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_InheritResultMessage",
        BODY     = "NPCSystem.InheritResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 装备改造继承替换消息
    NPC_REMODEL_REQ_INHERIT_REPLACE_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqInheritReplaceMessage",
        BODY     = "NPCSystem.ReqInheritReplaceMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 装备改造继承替换结果消息
    NPC_REMODEL_RESP_INHERIT_REPLACE_RESULT = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespInheritReplaceMessage",
        BODY     = "NPCSystem.RespInheritReplaceMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑改造继承↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    --CS 请求更换宠物皮肤
    PET_REQUEST_CHANGE_PET_SKIN = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_ReqChangePetSkinMessage",
        BODY     = "PetSystem.ReqChangePetSkinMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 请求更换宠物皮肤返回
    PET_RESPONSE_CHANGE_PET_SKIN = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_RespChangePetSkinMessage",
        BODY     = "PetSystem.RespChangePetSkinMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 获取宠物皮肤
    PET_RESPONSE_PET_GET_SKIN = {
        CATEGORY = NetMessageCategory.PET,
        HEAD     = "Type_NotifyGetPetSkinMessage",
        BODY     = "PetSystem.NotifyGetPetSkinMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓大航海岛怪↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    -- CS 请求刷新岛怪
    BIGSAIL_PORT_REQ_REFRESH_MONSTER_MESSAGE = {
        CATEGORY = NetMessageCategory.BIGSAIL,
        HEAD     = "Type_ReqRefreshMonsterMessage",
        BODY     = "BigSailSystem.ReqRefreshMonsterMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求刷新岛怪回复
    BIGSAIL_PORT_RESP_REFRESH_MONSTER_MESSAGE = {
        CATEGORY = NetMessageCategory.BIGSAIL,
        HEAD     = "Type_RespRefreshMonsterMessage",
        BODY     = "BigSailSystem.RespRefreshMonsterMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- SC 岛怪信息刷新
    BIGSAIL_PORT_NOTIFY_MONSTER_INFO_MESSAGE = {
        CATEGORY = NetMessageCategory.BIGSAIL,
        HEAD     = "Type_NotifyBigSailMonsterInfoMessage",
        BODY     = "BigSailSystem.NotifyBigSailMonsterInfoMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CO 请求驱逐岛怪
    BIGSAIL_PORT_REQ_MONSTER_BATTLE_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_ReqBigSailMonsterBattleMessage",
        BODY      = "BigSailSystem.ReqBigSailMonsterBattleMessage",
        NO        = 0,
        DIRECTION = NetDirection.CO
    },
    
    -- OC 请求驱逐岛怪结果
    BIGSAIL_PORT_RESP_MONSTER_BATTLE_MESSAGE = {
        CATEGORY  = NetMessageCategory.BIGSAIL,
        HEAD      = "Type_RespBigSailMonsterBattleMessage",
        BODY      = "BigSailSystem.RespBigSailMonsterBattleMessage",
        NO        = 0,
        DIRECTION = NetDirection.OC
    },
    
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑大航海岛怪↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    
    -- 召唤怪出现
    ROLE_NTF_CALL_MONSTER_APPEAR = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyCallMonsterAppearMessage",
        BODY      = "RoleSystem.NotifyCallMonsterAppearMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- 召唤怪出现
    ROLE_NTF_CALL_MONSTER_DISAPPEAR = {
        CATEGORY  = NetMessageCategory.ROLE,
        HEAD      = "Type_NotifyCallMonsterDisAppearMessage",
        BODY      = "RoleSystem.NotifyCallMonsterDisAppearMessage",
        NO        = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓雕纹↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    -- CS 请求雕纹锻造
    NPC_GLYPHS_COMPOSE_REQ= {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGlyphComposeMessage",
        BODY     = "NPCSystem.ReqGlyphComposeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求雕纹锻造结果
    NPC_GLYPHS_COMPOSE_RSP= {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespGlyphComposeResultMessage",
        BODY     = "NPCSystem.RespGlyphComposeResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    
    -- CS 请求雕纹洗练
    NPC_REQ_GLYPH_REFINE_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGlyphRefineMessage",
        BODY     = "NPCSystem.ReqGlyphRefineMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 雕纹洗练结果消息
    NPC_RESP_GLYPH_REFINE_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespGlyphRefineResultMessage",
        BODY     = "NPCSystem.RespGlyphRefineResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求洗练确认
    NPC_REQ_GLYPH_REFINE_CONFIRM_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGlyphRefineConfirmMessage",
        BODY     = "NPCSystem.ReqGlyphRefineConfirmMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求洗练确认结果
    NPC_RESP_GLYPH_REFINE_CONFIRM_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespGlyphRefineConfirmMessage",
        BODY     = "NPCSystem.RespGlyphRefineConfirmMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    -- CS 请求快速雕纹洗练
    NPC_REQ_GLYPH_QUICK_REFINE_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGlyphQuickRefineMessage",
        BODY     = "NPCSystem.ReqGlyphQuickRefineMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },

    -- SC 请求快速雕纹洗练结果
    NPC_RESP_GLYPH_QUICK_REFINE_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespGlyphQuickRefineMessage",
        BODY     = "NPCSystem.RespGlyphQuickRefineMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    
    -- CS 请求雕纹镶嵌
    NPC_REQ_GLYPH_EQUIP_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGlyphEquipMessage",
        BODY     = "NPCSystem.ReqGlyphEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求雕纹镶嵌结果
    NPC_RESP_GLYPH_EQUIP_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespGlyphEquipMessage",
        BODY     = "NPCSystem.RespGlyphEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 请求卸载雕纹
    NPC_REQ_GLYPH_UNEQUIP_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGlyphUnEquipMessage",
        BODY     = "NPCSystem.ReqGlyphUnEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求卸载雕纹结果
    NPC_RESP_GLYPH_UNEQUIP_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespGlyphUnEquipMessage",
        BODY     = "NPCSystem.RespGlyphUnEquipMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 雕纹分解消息
    NPC_REQ_GLYPH_DECOMPOSE_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGlyphDeComposeMessage",
        BODY     = "NPCSystem.ReqGlyphDeComposeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 雕纹分解结果消息
    NPC_RESP_GLYPH_DECOMPOSE_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespGlyphDeComposeMessage",
        BODY     = "NPCSystem.RespGlyphDeComposeResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 雕纹继承
    NPC_GLYPHS_INHERIT_REQ= {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqGlyphInheritMessage",
        BODY     = "NPCSystem.ReqGlyphInheritMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 雕纹继承结果
    NPC_GLYPHS_INHERIT_RSP= {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespGlyphInheritMessage",
        BODY     = "NPCSystem.RespGlyphInheritMessage",
        NO       = 0,
        DIRECTION = NetDirection.NONE
    },
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑雕纹↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--
    
    ----------------------------------  紫装升红 start  ----------------------------------
    -- 紫装升红
    REQUEST_CHANGE_PURPLE_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqChangePurpleMessage",
        BODY     = "GoodsSystem.ReqChangePurpleMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 紫装升红 (返回)
    RESPONSE_CHANGE_PURPLE_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RespChangePurpleMessage",
        BODY     = "GoodsSystem.RespChangePurpleMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    -- CS 原石分解消息
    NPC_REQ_PRIMOGEM_DECOMPOSE_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_ReqPrimogemDeComposeMessage",
        BODY     = "NPCSystem.ReqPrimogemDeComposeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 原石分解结果消息
    NPC_RESP_PRIMOGEM_DECOMPOSE_MESSAGE = {
        CATEGORY = NetMessageCategory.NPC,
        HEAD     = "Type_RespPrimogeDeComposeResultMessage",
        BODY     = "NPCSystem.RespPrimogeDeComposeResultMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    ----------------------------------  紫装升红 end  ----------------------------------

    ----------------------------------  星盘  ----------------------------------
    -- 解锁星盘
    REQUEST_UNLOCK_PLATE_MESSAGE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ReqUnlockStarPlateMessage",
        BODY     = "RoleSystem.ReqUnlockStarPlateMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 请求更换使用星盘
    REQUEST_CHANGE_PLATE_MESSAGE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_ReqChangeUseStarPlateMessage",
        BODY     = "RoleSystem.ReqChangeUseStarPlateMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 请求更换使用星盘结果回复 (返回)
    RESPONSE_CHANGE_PLATE_MESSAGE = {
        CATEGORY = NetMessageCategory.ROLE,
        HEAD     = "Type_RspChangeUseStarPlateMessage",
        BODY     = "RoleSystem.RspChangeUseStarPlateMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    -- CS 请求星盘数据
    REQUEST_STAR_PATTERN_DATA_MESSAGE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqStarPatternDataMessage",
        BODY     = "PlaySystem.ReqStarPatternDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },

    -- SC 返回星盘数据
    RESPONSE_STAR_PATTERN_DATA_MESSAGE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespStarPatternDataMessage",
        BODY     = "PlaySystem.RespStarPatternDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    -- CS 请求激活秘纹
    REQUEST_STAR_PATTERN_ACTIVE_MESSAGE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqStarPatternActiveMessage",
        BODY     = "PlaySystem.ReqStarPatternActiveMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },

    -- SC 返回星盘数据
    RESPONSE_STAR_PATTERN_ACTIVE_MESSAGE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespStarPatternActiveMessage",
        BODY     = "PlaySystem.RespStarPatternActiveMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    -- CS 请求升级星盘
    REQUEST_STAR_PATTERN_UPGRADE_MESSAGE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqStarPlateUpgradeMessage",
        BODY     = "PlaySystem.ReqStarPlateUpgradeMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- SC 请求升级星盘回复
    RESPONSE_STAR_PATTERN_UPGRADE_MESSAGE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespStarPlateUpgradeMessage",
        BODY     = "PlaySystem.RespStarPlateUpgradeMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },



    ----------------------------------  红装重置  ----------------------------------
    -- 紫装升红后重置
    REQUEST_RESET_PURPLE_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_ReqResetPurpleMessage",
        BODY     = "GoodsSystem.ReqResetPurpleMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    -- 紫装升红后重置 (返回)
    RESPONSE_RESET_PURPLE_MESSAGE = {
        CATEGORY = NetMessageCategory.GOODS,
        HEAD     = "Type_RespResetPurpleMessage",
        BODY     = "GoodsSystem.RespResetPurpleMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    --↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓纪念品↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓--
    --CS 请求纪念品数据
    PLAY_REQUEST_SOUVENIR_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqSouvenirDataMessage",
        BODY     = "PlaySystem.ReqSouvenirDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },

    -- SC 纪念品数据
    PLAY_RESPONSE_SOUVENIR_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespSouvenirDataMessage",
        BODY     = "PlaySystem.RespSouvenirDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    --SC 获取纪念品 (已经拥有的纪念品,自动分解为其它道具的通知)
    PLAY_NOTIFY_GET_SOUVENIR = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_NotifyGetSouvenirMessage",
        BODY     = "PlaySystem.NotifyGetSouvenirMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    --CS 请求纪念品升级
    PLAY_REQUEST_SOUVENIR_LEVEL_UP = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqSouvenirLevelUpMessage",
        BODY     = "PlaySystem.ReqSouvenirLevelUpMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },

    --SC 纪念品升级回复
    PLAY_RESPONSE_SOUVENIR_LEVEL_UP = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespSouvenirLevelUpMessage",
        BODY     = "PlaySystem.RespSouvenirLevelUpMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --SC 纪念品数据更新
    PLAY_UPDATE_SOUVENIR_DATA = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_UpdateSouvenirDataMessage",
        BODY     = "PlaySystem.UpdateSouvenirDataMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },

    -- CS 请求激活纪念品
    PLAY_REQUEST_SOUVENIR_ACTIVITE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqSouvenirActiviteMessage",
        BODY     = "PlaySystem.ReqSouvenirActiviteMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },
    
    --SC 激活回复
    PLAY_RESPONSE_SOUVENIR_ACTIVITE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespSouvenirActiviteMessage",
        BODY     = "PlaySystem.RespSouvenirActiviteMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --CS 请求取消激活
    PLAY_REQUEST_SOUVENIR_CANCEL_ACTIVITE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_ReqSouvenirCancelActiviteMessage",
        BODY     = "PlaySystem.ReqSouvenirCancelActiviteMessage",
        NO       = 0,
        DIRECTION = NetDirection.CS
    },

    --SC 取消激活回复
    PLAY_RESPONSE_SOUVENIR_CANCEL_ACTIVITE = {
        CATEGORY = NetMessageCategory.PLAY,
        HEAD     = "Type_RespSouvenirCancelActiviteMessage",
        BODY     = "PlaySystem.RespSouvenirCancelActiviteMessage",
        NO       = 0,
        DIRECTION = NetDirection.SC
    },
    
    --↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑纪念品↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑--

}
NetMessageType = Net.MessageType


--web server http次要目录
Net.HttpSubDirection = {
    ReviewCheck = "/cave-online-review/web-server-address", -- 注意: URL主体不一样, 是唯一客户端配置的URL
    ServerConfig = "/cave-online-login/server-config",  
    GameLogin = "/cave-online-login/login",
    BannerInfo = "/cave-online-operation/current-banners",
    WebLanguage = "/cave-online-operation/operation-text",
    SystemNotice = "/cave-online-operation/broadcasts",
    Verification = "/cave-online-redeem/verification",
    PurchaseCrystalInfo = "/cave-online-purchase/crystal-list", -- 内购水晶列表
    UIOperationLog = "/data-statistics/open-ui",-- UI操作记录
    LoginAddresses = "/cave-online-login/login-addresses", -- 获取gate服务器地址
    StoryModeStep = "/data-statistics/tutorials", -- 新手引导步骤
    LoginNotice = "/cave-online-operation/notices/login",--登录公告
    TownNotice = "/cave-online-operation/notices/town",--城镇公告
    WebLog = "/data-statistics/log",--web 日志打点,
    SendEmail = "/cave-online-operation/mail-binding/send-email",  --  发送邮件
    VerifyEmail = "/cave-online-operation/mail-binding/verify",    -- 验证邮箱
    CS = "/custom-service/custom/index.html",   --客服工具
    RunningLamp = "/cave-online-operation/marquee",  --跑马灯
    LoginStep = "/data-statistics/login-process", -- 登陆流程步骤
    FirstReportNetDelay = "/api/delaycollection", -- 初次上报网络延迟情况
    ReportNetDelay = "/api/delaycollection/continue", -- 每隔30s上报网络延迟
    GetSplashImage = "/cave-online-operation/current-start-screens", -- 请求拉取开屏图片
    LeiTingQuestionNaire = "http://activity.leiting.com/lt/201811/survey/?v=2",--雷霆问卷调查 绝对地址
    ADSDebugReward = "/cave-online-operation/advertisement/debug", --由客户端发起的 广告奖励  测试专用（和GM工具同开关）
    AreaServer = "/zone/%s/v1/client/areainfo?account=%s",   -- 有客户端发起想服务器获取area列表的地址，这里需要两个参数，第一个：zoneid, 第二个：玩家账号，eg:5_23132323
}

-- 初始化
local proto = require "utils.ProtobufUtil"

-- 内部使用的字典
Net.PackMap = {}
NetPackMap = Net.PackMap

Net.InitMessageType = {
    InitMessageType_All = 1,
    InitMessageType_Login = 2,
    InitMessageType_Game = 3,
}

Net.initMessageNo = function(type)
    -- 初始化消息编号
    -- print("")
    -- print("----------------------------")
    -- print("Message No list:")
    
    if(type == nil) then
        type = Net.InitMessageType.InitMessageType_All
    end
    
    for key, MessageType in pairs(NetMessageType) do
        if (MessageType.CATEGORY ~= NetMessageCategory.INNER) then
            local handle = true
            -- 这里根据模块处理PB消息
            if(type == Net.InitMessageType.InitMessageType_Login) then
                if MessageType.CATEGORY ~= NetMessageCategory.INNER and
                MessageType.CATEGORY ~= NetMessageCategory.LOGIN then
                    handle = false
                end
            elseif (type == Net.InitMessageType.InitMessageType_Game) then
                if MessageType.CATEGORY == NetMessageCategory.INNER or 
                MessageType.CATEGORY == NetMessageCategory.LOGIN then
                    handle = false
                end
            end
            
            if(handle) then
                MessageType.NO = proto:enum_id(MessageType.CATEGORY.NAME, MessageType.HEAD)
                local section = MessageType.CATEGORY.SECTION
                local no = MessageType.NO
                
                if (no ~= nil) then
                    if (not NetPackMap[section]) then
                        NetPackMap[section] = {}
                    end
                    NetPackMap[section][no] = MessageType.BODY
                    
                    -- print(string.format("Net.initMessageNo key:%s section:%d no:%d.", key, section, no))
                else
                    -- print(string.format("[WARNING] Net.initMessageNo key:%s no is invaild.", key))
                end
            end
        end
    end
    -- print("----------------------------")
    -- print("")
end