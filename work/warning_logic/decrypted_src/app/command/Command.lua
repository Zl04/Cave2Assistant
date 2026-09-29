--[[
    战斗引擎命令基类
]]--

require "app.pool.PoolObject"

Command = Command or {}

local Base = class("CommandBase", Pool.PoolObject)
Command.Base = Base

-- 命令分类
Command.Category = {
    FSM = 1,       -- 角色状态机命令
    RENDERER = 2,   -- 角色渲染命令
    CONTROL = 3,    -- 控制类命令（处理网络消息生成命令）
    BATTLE = 4,     -- 战斗类指令（客户端内部发出）
    TOWN = 5,       -- 城镇类指令（客户端内部发出）
    PLAYER = 5,     -- 音效播放器命令
    GENERATION = 6  -- 通用命令
}
CommandCategory = Command.Category
-- 视图命令的类型
Command.Type = {
    NONE = 0,

    -- 视图命令
    RENDERER_POSITION = 1001,                    -- 更新视图的屏幕坐标
    RENDERER_DIRECTION = 1002,                   -- 更新视图的方向
    RENDERER_ZORDER = 1003,                      -- 更新视图的Z坐标
    RENDERER_ANIMATION = 1004,                   -- 更新动画
    RENDERER_ATTR = 1005,                        -- 显示属性改变
    RENDERER_ADD_BUFF = 1006,                    -- 添加buff 效果
    RENDERER_ADD_EFFECT = 1007,                  -- 添加effect 效果
    RENDERER_PREPARE_SKILL = 1008,               -- 技能蓄力或者呤唱
    RENDERER_RELEASE_SKILL = 1009,               -- 技能释放
    RENDERER_FINISH_SKILL = 1010,                -- 技能使用完成
    RENDERER_REMOVE_BUFF = 1011,                 -- 移除buff 效果
    RENDERER_PREPARE_SKILL_FX = 1012,            -- 准备技能特效
    RENDERER_RELEASE_SKILL_FX = 1013,            -- 释放技能特效
    RENDERER_BREAK_SKILL_FX = 1014,              -- 取消技能特效
    RENDERER_BULLET_STATE = 1015,                -- 设置飞行道具的状态，包括起始和终点目标，飞行时间等
    RENDERER_IDLE = 1016,                        -- 显示待机动画
    RENDERER_ADD_GOODS_FX = 1017,                -- 获取物品的特效
    RENDERER_OPEN_IT_NPC = 1018,                 -- 触发宝箱，钱袋等npc 效果
    RENDERER_GET_DARKGOLDEN_EFFECT = 1019,       -- 获得物品
    RENDERER_FINISH_PREPARE_SKILL_FX = 1020,     -- 结束技能准备的特效
    RENDERER_CLEAR_SKILL_FX = 1021,              -- 清理角色身上的特效
    RENDERER_REFRESH_WEAR_EQUPMENT = 1022,       -- 刷新穿戴装备
    RENDERER_REFRESH_SKINADNFACE = 1023,         -- 刷新穿戴装备
    RENDERER_SHOW_MAP_GRID = 1024,               -- 高亮显示地图格子（通常使用在道具使用的情况下）
    RENDERER_HIDE_MAP_GRID = 1025,               -- 隐藏高亮显示的地图格子
    RENDERER_MAP_TILE_CHANGE = 1026,             -- 地图块变成地面
    RENDERER_ROLE_REVIVE = 1027,                 -- 处理复活
    RENDERER_ROLE_REMOVE_BACK_TOWN = 1028,       -- 处理移除回城效果
    RENDERER_ROLE_NAME = 1029,                   -- 处理角色名字显示与否控制
    RENDERER_ROLE_DEAD = 1030,                   -- 处理角色死亡处理
    RENDERER_ROLE_LEVEL_UP = 1031,               -- 角色升级表现
    RENDERER_ROLE_LEVEL_UP_ATTR = 1032,          -- 角色升级属性表现
    RENDERER_ENTER_CENTER_COORD = 1033,          -- 角色进入地块中心点
    RENDERER_MAP_TILE_UPDATE = 1034,             -- 地图更新（发现密室等）
    RENDERER_TRIGGER_NPC_UNLOCK = 1035,          -- 触发NPC 解锁
    RENDERER_SHOW_START_REVIVE = 1036,           -- 开始显示复活界面
    RENDERER_NPC_TRAP_EFFECT = 1037,             -- 触发陷阱效果
    -- RENDERER_FUNCITON_BUTTON = 1038,             -- 触发显示功能按钮
    RENDERER_SPINE_TIME_SCALE = 1039,            -- 角色spine动画播放速度控制
    RENDERER_FACE_CHANGE = 1040,                 -- 脸型改变
    RENDERER_TRIGGER_MONSTER = 1041,             -- 触发怪物
    RENDERER_SHOW_MONSTER_BLOOD = 1042,          -- 显示怪物血条
    RENDERER_UPDATE_MONSTER_BLOOD = 1043,        -- 更新怪物血条
    RENDERER_REMOVE_MONSTER_BLOOD = 1044,        -- 移除怪物血条
    RENDERER_BATTLE_STATUS_ANIMATION = 1045,     -- 战斗状态动画 
    RENDERER_ADD_EFFECT_VIEW = 1046,             -- 添加一个效果表现
    RENDERER_REMOVE_DECORATIONS = 1047,          -- 移除装饰物
    RENDERER_NPC_INFOMATION_SHOW = 1048,         -- NPC气泡显示
    RENDERER_NPC_INFOMATION_HIDE = 1049,         -- NPC气泡隐藏
    RENDERER_TOWN_SELECT_HERO_SHOW = 1050,            -- 显示城镇选择英雄
    RENDERER_TOWN_SELECT_HERO_HIDE = 1051,            -- 隐藏城镇选择英雄
    RENDERER_NPC_INTERACTION_START = 1052,       -- NPC交互动画开始
    RENDERER_NPC_INTERACTION_END = 1053,         -- NPC交互动画结束
    RENDERER_HERO_LOOKS = 1054,                  -- 处理hero 变形 
    RENDERER_NPC_NEW_MAIL = 1055,                --新邮件提示
    RENDERER_ITEM_DEFORMATION_REMOVE = 1056,     -- 变形效果移除
    RENDERER_HERO_EXPRESSION = 1057,             --  快捷表情 
    RENDERER_RELEASE_ACT_ANIMATION = 1058,        -- 添加act 动画
    RENDERER_RELEASE_ACT_ANIMATION_REMOVE = 1059, -- 根据spriteID 移除act动画逻辑处理
    RENDERER_BOSS_SHOW_TRANSFOR = 1060,           -- 显示变身动画
    RENDERER_BOSS_SHOW_TRANSFOR_RECOVER = 1061,   -- 显示变身恢复动画
    RENDERER_ROLE_FROZEN = 1062,                  -- 冻结
    RENDERER_ROLE_FROZEN_RECOVER = 1063,          -- 从冻结中恢复
    RENDERER_ROLE_STATUS_SHOW = 1064,             -- 状态显示
    RENDERER_ROLE_STATUS_END = 1065,              -- 状态效果完成
    RENDERER_NORMAL_SKILL = 1066,                 -- 普通攻击处理
    RENDERER_ROLE_IS_HIDE_HELMET = 1067,          -- 是否显示头盔
    RENDERER_NPC_HIDE_TRANSDOOR_TRIGGER = 1068,   -- 隐藏传送门表现
    RENDERER_NPC_ACTIVITY_CRYING = 1069,          -- 活动吆喝动作
    RENDERER_RELEASE_ASSIST_SKILL = 1070,         -- 辅助技能释放
    RENDERER_ASSIST_SKILL_TRANSFER_END = 1071,    -- 技能传送完成
    RENDERER_ASSIST_SKILL_USE_FAIL = 1072,        -- 辅助技能使用失败
    RENDERER_ROLE_HIT_SHACK = 1073,               -- 攻击特效
    RENDERER_NPC_CHANGE_COORD = 1074,             -- NPC 修改坐标
    RENDERER_END_REVIVE = 1075,                   -- NPC 复活完成
    RENDERER_ROLE_TITLE = 1076,                   -- 角色称号显示
    RENDERER_GUILD_NAME = 1077,                   -- 角色公会显示
    RENDERER_EXCLAMATORY = 1078,                  -- 显示感叹号   
    RENDERER_SKILL_ADVANCED = 1079,               -- 显示技能进阶
    RENDERER_ROLE_SCALE = 1080,                   -- 角色缩放
    RENDERER_ATTR_COMMON = 1081,                  -- 角色所有属性转换都会
    RENDERER_DREAM_WINDING = 1082,                -- 梦境缠绕效果的处理逻辑
    RENDERER_DREAM_RANK_PROJECTION = 1083,        -- 梦境模式表现效果
    RENDERER_ITEM_DEFORMATION_SHOW = 1084,        -- 变形效果显示
    RENDERER_DREAM_NPC_OPEN = 1085,               -- 梦境npc触发动画
    RENDERER_HORCRUX_EXTERIOR = 1086,             -- 魂器效果
    RENDERER_SET_GUIDE_POINTER = 1087,            -- 设置引导指针状态
    RENDERER_EXPEDITION_UPDATE = 1088,            -- 内挂刷新
    RENDERER_GUILD_BOSS_STATUS_UPDATE = 1089,     -- 公会BOSS状态改变
    RENDERER_BOSS_SEAL_INFO_UPDATE = 1090,        -- boss锁定info
    RENDERER_ROLE_RUN_ANIMATIONS = 1091,          -- 角色运行指定的动画
    RENDERER_MAZE_FUN_EXPLORE = 1092,             -- 扫描周围
    RENDERER_MAZE_POINT = 1093,                    -- 处理洞窟迷阵点
    RENDERER_MAZE_TRAP_VIEW = 1094,               -- 陷阱表现处理
    RENDERER_HIT_RAT_BUFF = 1095,                 -- 陷阱表现处理
    RENDERER_ROLE_CONSTRAINT = 1096,              -- 束缚
    RENDERER_ROLE_CONSTRAINT_RECOVER = 1097,      -- 从束缚中恢复
    RENDERER_SCENE_PAUSEORRESUME_STATUS = 1098,   -- 场景状态(场景暂停，恢复)
    RENDERER_LOSTREALM_CHANGE = 1099,             -- 大富翁走动步数变动
    RENDERER_PET_RIDE = 1100,                     -- 骑乘宠物(pet上或下的表现)
    RENDERER_HERO_RIDE = 1101,                    -- 骑乘宠物(hero上或下的表现)
    RENDERER_HERO_DOWN = 1102,                    -- 骑乘战斗处理
    RENDERER_PET_DOWN = 1103,                     -- 骑乘战斗处理
    RENDERER_PET_FOLLOW = 1104,                   -- 骑乘战斗处理
    RENDERER_FUNCTION_NPC_TRIGGER = 1105,         -- FUNCTION_NPC触发
    RENDERER_BOSS_STATUS_CHANGE = 1106,           -- BOSS的状态切换，是否切换templateID,是否激活等状态
    RENDERER_HERO_CHANGE_FISHING_WEAPON = 1107,   -- 更新鱼竿武器表现
    RENDERER_HERO_SHOW_HARVEST_EFFECT = 1108,     -- 显示丰收表现
    RENDERER_PEDDLER_INFOMATION_SHOW = 1109,      -- 行商NPC气泡显示
    RENDERER_HERO_TRANSFORM_INTO_BATTLE = 1110,   -- 特殊变身卡进入战斗后的表现
    RENDERER_HERO_TRANSFORM_LEAVE_BATTLE = 1111,  -- 特殊变身卡脱离战斗后的表现
    RENDERER_PET_CHANGE_SKIN = 1112,              -- 宠物更换皮肤


    -- 控制命令
    CONTROL_BEGIN_TRANS_SCENE = 200,            -- 开始场景切换
    CONTROL_LOADSCENCE = 201,                   -- 加载场景 
    CONTROL_ENTER_SCENE = 202,                  -- 进入场景
    CONTROL_SCREENHERO = 203,                   -- 同屏英雄
    CONTROL_GLOBALMONSTER = 204,                -- 全局怪物
    CONTROL_SCREENMONSTER = 205,                -- 同屏怪物
    CONTROL_SCREENBOX = 206,                    -- 同屏宝箱
    CONTROL_SCREENGOLDBAG = 207,                -- 同屏钱袋
    CONTROL_EXPLOREDVIEWAREA = 208,             -- 已到达的视区数据
    CONTROL_GLOBALBOX = 209,                    -- 全局宝箱
    CONTROL_SCREEN_TRANSDOOR = 210,             -- 同屏传送门
    CONTROL_GLOBAL_TRANSDOOR = 211,             -- 全局传送门
    CONTROL_GLOBALGOLDBAG = 212,                -- 全局金币袋
    CONTROL_TRANSFORMEDGROUND = 213,            -- 转变为可到达的地图块数据
    CONTROL_GLOBAL_TRIGGERNPC = 214,            -- 全局触发NPC
    CONTROL_SCREEN_TRIGGERNPC = 215,            -- 同屏触发NPC
    CONTROL_REMOVESCREENROLE = 216,             -- 移除同屏角色
    CONTROL_ROLE_ATTR_CHANGE = 217,             -- 角色属性变化
    CONTROL_ROLE_SKILL_MISS = 218,              -- 角色技能MISS
    CONTROL_NOTIFY_HERO_START_MOVE = 219,       -- 通知英雄开始移动
    CONTROL_NOTIFY_HERO_STOP_MOVE = 220,        -- 通知英雄停止移动
    CONTROL_HERO_POSITION_SYNC = 221,           -- 英雄位置同步
    CONTROL_HERO_START_BATTLE_RESULT = 222,     -- 玩家开始战斗结果
    CONTROL_NOTIFY_ROLE_SKILL_STATUS = 223,     -- 通知角色技能
    CONTROL_NOTIFY_ROLE_SKILL_BREAK = 224,      -- 通知角色技能打算
    CONTROL_NOTIFY_ROLE_SKILL_COOLDOWN = 225,   -- 通知玩家技能冷却
    CONTROL_MONSTER_DETAIL = 226,               -- 怪物详情
    CONTROL_NOTIFY_HERO_ESCAPE = 227,           -- 通知英雄逃跑
    CONTROL_ROLE_LEAVE_BATTLE = 228,            -- 角色离开战斗
    CONTROL_ROLE_DIE = 229,                     -- 角色死亡
    CONTROL_ADD_BUFFER = 230,                   -- 添加buffer
    CONTROL_REMOVE_BUFFER = 231,                -- 移除buffer
    CONTROL_ADD_EFFECT = 232,                   -- 移除effect
    CONTROL_NPC_OPEN = 233,                     -- 打开NPC
    CONTROL_ACHIEVE_GOODS = 234,                -- 获得物品
    CONTROL_WEAR_EQUIPMENT_CHANEG = 235,        -- 穿戴装备变动
    CONTROL_SKIN_AND_FACE_CHANEG = 236,         -- 皮肤和面部变动
    CONTROL_DIG_WALL = 237,                     -- 挖墙后的地图变动
    CONTROL_HERO_TRANSFER = 238,                -- 处理技能瞬移操作
    CONTROL_NOTIFY_ROLE_SKILL_ACCUMULATE = 241, -- 通知玩家技能呤唱
    CONTROL_ROLE_REVIVE = 242,                  -- 通知角色复活
    CONTROL_ROLE_BACK_TOWN = 243,               -- 通知玩家回城,服务器通知,开始播放回城动画
    CONTROL_ROLE_LEVEL_UP = 244,                -- 角色升级
    CONTROL_CHAMBER_OPEN = 245,                 -- 密室门打开
    CONTROL_TRIGGER_NPC_UNLOCK = 246,           -- 触发NPC 解锁
    CONTROL_CHAMBER_ENTRANCE_UNLOCK = 247,      -- 机关密室门解锁
    CONTROL_REMOVE_ALL_FX = 248,                -- 移除所有效果 ，包括buff 和 特效
    CONTROL_SCREEN_HERO_START_BATTLE = 249,     -- 同屏玩家开始战斗
    CONTROL_NPC_GOLD_TOUCHED_REFRESH = 250,     -- 刷新点金台处理逻辑 
    CONTROL_NPC_TASK_REFRESH = 251,             -- 刷新任务数据
    CONTROL_BOSS_BEGIN_SCENARIO = 252,          -- 处理开始BOSS剧情
    CONTROL_BOSS_END_SCENARIO = 253,            -- 处理结束BOSS剧情
    CONTROL_ROLE_BEGIN_USE_ITEM = 254,          -- 处理开始使用物品
    CONTROL_USE_ITEM_FAILED= 255,               -- 处理使用物品失败
    CONTROL_REVIVE_RESPONSE = 256,              -- 处理复活请求返回
    CONTROL_EDIT_NICK_NAME = 257,               -- 处理修改昵称
    CONTROL_NPC_TRAP_EFFECT = 258,              -- 处理陷阱伤害
    CONTROL_SCREEN_FACE_CHANGE = 259,           -- 脸型改变
    CONTROL_TRIGGER_MONSTER = 260,              -- 触发怪物
    CONTROL_REFRESH_BUFFER_BY_KIND = 261,       -- 刷新buffer
    CONTROL_REFRESH_ALL_SKILL_CD = 262,         -- 刷新技能冷却时间
    CONTROL_SHOW_MINI_MAP_ICON = 263,           -- 处理显示小地图图标 
    CONTROL_ROLE_I_SEE_DEAD_PEOPLE = 264,       -- 地图全开
    CONTROL_SKILL_USE_RESULT = 265,             -- 技能使用返回状态
    CONTROL_REVIVE_COMPLETE = 266,              -- 复活完成
    CONTROL_MASTER_IDLE = 267,                  -- 主角站立,该指令用于传送们,回城以及下楼等失败处理
    CONTROL_HERO_ESCAPE_FAILED = 268,           -- 玩家淘宝失败
    CONTORL_NOTIFY_HERO_CANCEL_ESCAPE = 269,    -- NOTIFY_HERO_CANCEL_ESCAPE
    CONTORL_TRAP_REMOVE = 270,                  -- 陷阱移除
    CONTORL_END_TRANS_SCENE = 271,              -- 完成场景切换
    CONTORL_UNLOCK_FUNCTION = 272,              -- 功能模块解锁
    CONTORL_FINISH_ACHIEVEMENT  = 273,              -- 成就达成
    CONTORL_CHECK_POINT = 274,              -- 存档点
    CONTROL_REFRESH_BUFF_FOR_INST_ID = 275,     -- 根据实例ID刷新buff 表现
    CONTROL_REMOVE_AFFIX_FOR_ALL_MONSTER = 276, -- 移除所有怪物的词缀
    CONTROL_NPC_CATFOOD = 277,                  -- 吃猫饭回来结果
    CONTROL_TRIGGER_NPC_FAILS = 278,            -- 触发NPC失败
    CONTROL_WAITING_BEGIN_SYNC = 279,           -- 等待开始同步时间
    CONTROL_DUNGEON_UNLOCK_TRANSDOOR = 280,     -- 大秘境传送门解锁功能
    CONTROL_NOTIFY_ROLE_SKILL_START_EFFECT = 281,   -- 通知玩家技能开始冷却
    CONTROL_NOTIFY_START_USE_SKILL = 282,       -- 通知开始使用技能
    CONTROL_SKILL_ADVANCED = 283,               -- 技能进阶
    CONTROL_SHOW_MATCH_TEAM = 284,               -- 显示组队匹配中
    CONTROL_SHOW_TEAM_CONFIRE = 285,             -- 显示组队确认
    CONTROL_REMAIN_BUFF = 286,                  -- 重置buff 数据
    CONTROL_OPEN_UILAYER = 287,                  -- 打开界面, 参数自定义
    CONTROL_SET_GUIDE_POINTER = 288,             -- 设置引导指针状态
    CONTROL_REFRESH_ALL_GUILD_BOSS = 289,        -- 刷新所有公会BOSS NPC
    CONTROL_REFRESH_GUILD_BOSS_STATUS = 290,        -- 刷新公会NPC单个表现
    CONTROL_MAZE_POINT = 291,                        -- 迷阵点
    CONTROL_MAZE_FUN_EXPLORE = 292,                 -- 迷阵查看
    CONTROL_REFRESH_BUFFER_BY_EFFECT = 293,       -- 刷新buffer
    CONTROL_QUICK_DOWN = 294,                    -- 快捷下楼
    CONTROL_END_PET_PVP = 295,                    -- 结束宠物pvp战斗
    CONTROL_SCENE_PAUSEORRESUME_STATUS = 296,     -- 场景状态(场景暂停，恢复)
    CONTROL_REMOVEALLOTHERSCREENROLE = 297,       -- 移除其他（非自己的）同屏角色
    CONTROL_ROLE_ANIMATIONS_BY_SPRITEID = 298,  -- 通过spriteID获取角色运行指定的动画
    CONTROL_PLAY_LOSTREALM_MOVE = 299,          -- 
    CONTROL_GHOSTABYSS_NOTIFY = 2000,          --幽灵深渊通知消息

    -- 战斗命令
    BATTLE_START_BATTLE = 300,               -- 开始战斗
    BATTLE_USE_SKILL = 301,                  -- 使用技能
    BATTLE_ESCAPE = 302,                     -- 战斗逃跑
    BATTLE_HANDLE_STATION = 305,             -- 处理战斗站位
    BATTLE_REMOVE_MODEL = 306,               -- 移除模型
    -- BATTLE_OPEN_TREASURE = 307,              -- 打开宝藏
    -- BATTLE_OPEN_GOLDBAG = 308,               -- 打开钱袋
    -- BATTLE_OPEN_RUNE = 309,                  -- 触发符文
    -- BATTLE_OPEN_TRAP = 310,                  -- 触发陷阱
    -- BATTLE_TRIGGER_TRANSDOOR = 311,          -- 触发传送门
    BATTLE_ADD_TRIGGER_DATA = 350,           -- 添加自己触发数据
    BATTLE_ADD_ROLE_VIEW = 351,              -- 添加角色视图
    BATTLE_ROLE_REVIVE_END = 353,            -- 角色复活完成
    BATTLE_ROLE_BACK_TOWN = 354,             -- 角色使用了回城或者触发了回城传送阵，开始进入等待表现
    BATTLE_ROLE_REWARD = 355,                -- 角色结算
    BATTLE_OPEN_TRIGGER_NPC = 356,           -- 打开触发NPC
    BATTLE_HANDLE_FUNCTION_TYPE = 357,       -- 处理某个功能类型
    BATTLE_TRIGGER_MONSTER = 358,            -- 触发怪物
    BATTLE_BATTLE_STATUS_CHANGE = 359,       -- 战斗中的状态改变，这里主要是处理 招架，冰冻等效果处理
    BATTLE_NPC_INFOMATION_SHOW = 360,        -- NPC气泡功能显示
    BATTLE_NPC_INFOMATION_HIDE = 361,        -- NPC气泡功能隐藏
    BATTLE_SELECT_HERO_HIDE = 362,           -- 选择查看表现隐藏
    BATTLE_NPC_INTERACTION_END = 363,        -- 交互完成
    BATTLE_HERO_LOOKS = 364,                 -- 英雄变形
    BATTLE_ITEM_DELUSION_INIT = 365,      -- 道具变形初始化
    BATTLE_ITEM_DELUSION_REMOVE = 366,    -- 道具变形移除
    BATTLE_TRANS_DOOR_OPEN = 367,            -- 传送门打开，这里指触发相关相关
    BATTLE_SEND_START_MOVE = 368,            -- 发送开始移动消息
    BATTLE_ROLE_IS_HIDE_HELMET = 369,        -- 处理逻辑
    BATTLE_TRIGGER_NPC_FOR_TEMPLATE_ID = 370,-- 根据模板ID触发NPC，目前用于新手引导
    BATTLE_NPC_ACTIVITY_CRYING = 371,        -- 活动吆喝动作开关
    BATTLE_STOP_MOVE = 372,                  -- 处理停止移动，这样可以处理时序问题
    BATTLE_USE_ASSIST_SKILL = 373,           -- 使用辅助技能
    BATTLE_NPC_OPEN = 374,                   -- 客户端自己触发NPC打开
    BATTLE_NPC_FUNC_BTN_INFORMATION_PAUSE = 375,        -- NPC 功能按钮屏蔽
    BATTLE_NPC_FUNC_BTN_INFORMATION_RESUME = 376,       -- NPC 功能按钮恢复
    BATTLE_ROLE_TITLE = 377,                 -- 通知角色称号更改
    BATTLE_ROLE_GUILD_NAME = 378,            -- 通知角色公会名字更改
    BATTLE_PRE_RANK_CHANGE = 379,            -- 上一周排行数据修改 
    BATTLE_HORCRUX_EXTERIOR = 380,           -- 触发魂器表现
    BATTLE_TRANS_POINT_OPEN = 381,           -- 传送点触发
    BATTLE_SETTING_HIDE_HORCRUX = 382,           -- 隐藏装饰物
    BATTLE_SETTING_HIDE_PET = 383,           -- 传送点触发
    BATTLE_FORCE_REFRESH_PET = 384,           --单独移除制定宠物
    BATTLE_SETTING_PERSON_COUNT = 385,       -- 处理同屏人数
    BATTLE_END = 386,       -- 战斗结束
    BATTLE_MONSTER_EVOLUTION = 387,           -- 触发BOSS进化表现

    -- 通用命令
    GENERATION_TOUCH_BEGAN = 400,               -- 点击事件开始
    GENERATION_TOUCH_MOVED = 401,               -- 点击事件移动
    GENERATION_TOUCH_ENDED = 402,               -- 点击事件结束
    GENERATION_TOUCH_LONG_TIME_BEGAN = 403,     -- 长按点击事件开始
    GENERATION_TOUCH_LONG_TIME_ENDED = 404,     -- 长按点击事件结束
    GENERATION_START_MOVE = 405,                -- 开始移动
    GENERATION_STOP_MOVE = 406,                 -- 停止移动
    GENERATION_UPDATE_MAP_CENTER = 407,         -- 更新地图中心点
    GENERATION_ROLE_ZORDER = 408,               -- 角色层级
    GENERATION_TOUCH_CLICK = 409,               -- 点击事件的点击
    GENERATION_TOUCH_CANCEL = 410,               -- 点击事件取消


    IAP_ON_PURCHASERESULT = 500,                -- 内购获得物品返回

    CONTROL_SCREENPET = 600,                    --同屏宠物

    CONTROL_GROUP_MONSTER_REVIVE = 700,         -- 通知群怪复活
    CONTROL_HERO_SWITCH_BATTLE_RESULT = 701,    -- 玩家切换战斗目标结果

    CONTROL_SUMMONED_BOSS_CHANGE_PANNEL = 702,  -- boss召唤怪时刷新状态UI

    CONTROL_SCREEN_PET_TRANSTORM = 800,         --同屏宠物变形 (小狐仙)

}
CommandType = Command.Type
-- 动画视图命令的动画类型
Command.AnimationType = {
    NONE = 0,
    SLEEP = 1,              -- 播放休眠动画
    APPEAR = 2,             -- 播放出场动画

    IDLE = 21,              -- 播放待机动画 
    MOVE = 22,              -- 播放移动动画
    ATTACK = 23,            -- 播放攻击动画
    BE_ATTACKED = 24,       -- 播放受击动画
    SKILL_PREPARE = 25,     -- 播放技能蓄力或者呤唱动画
    SKILL_RELEASE = 26,     -- 播放技能释放动画
    DIE = 27,               -- 播放死亡动画
    AIRCRAFT_FLY = 28,      -- 播放飞行动画
    AIRCRAFT_BOOM = 29,     -- 播放爆炸动画
    REVIVE = 30,            -- 播放复活动画
    BACK_TOWN = 31,         -- 播放回城动画
    ATTACK_IDLE = 32,       -- 战斗待机动画
    CUSTOM = 100            -- 播放自定义动画
}
CommandAnimationType = Command.AnimationType
AnimationType = Command.AnimationType

-- public:
-- 构造函数
function Base:ctor(category, type)
    -- print("Command constructor.")

    self.category = category
    self.type = type
end

-- 销毁
function Base:dtor()
    -- print("Command destructor.")
end

-- 初始化
function Base:init()
    
end

-- 清理
function Base:clear()
    
end

