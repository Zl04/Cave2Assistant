--[[
    游戏全局定义
]]--

Game = Game or {}

EVENT_RENDERER_RECREATED = "event_renderer_recreated"

GEM_SHOP_BUY_LUCKY_COUNT = 10
-- 比例值，用于统一比例
RATIO_NUMBER = 10000
PERCENT_NUMBER = 100
TIME_UNIT = 1000    -- 配置时间单位(毫秒)
SECONDS_ONE_DAY = 86400
SECONDS_ONE_HOUR = 3600
SECONDS_ONE_MINUTES = 60
SECONDS_ONE_WEEK = 604800
WEB_ERUPT_DELAY_TIME = 10 --为了缓解 web http 请求并发， 设置一个请求最大延时时间 单位秒

DEFALAULT_FONT_SIZE  = 18
DEFALAULT_FONT_COLOR = "#ffffff"

BTN_CLICK_TIMES_LIMITE = 3 --每秒操作上限

-- 网络阻塞的加载延迟时间
GAME_NET_DELAY_OTHER = 1      -- 非游戏操作
GAME_NET_DELAY_LIST = 0.5     -- 列表表现
GAME_NET_DELAY_UI = 0.5       -- 非战斗的UI操作 
GAME_NET_ACTIVITY_SHARE_UI = 5 --活动分享,下载图片最长等待时间

TRANSFER_SKILL_ID = 30000101  -- 传送技能ID
ROLE_TALENT_STONE_GOODSID = 22070090 --天赋之书ID
DUNGEON_ITEM_KEY = 22060010 --大秘境钥匙ID

BILLION = 1000000000
MILLION = 1000000
KILO    = 1000
ONE     = 1

DIFFICULTY_SIZE = 2

-- 等待复活倒计时(秒)
CAVE_REVIVE_WAITING_TIME = 30

-- 活动的常量
ACTIVITY_WIDTH = 655
ACTIVITY_BIG_HEIGHT = 200    -- 高的框高度
ACTIVITY_LITTLE_HEIGHT = 146 -- 低的框的高度

-- 定义游戏楼层相关的常量
BOSS_INTERVAL = 30              -- BOSS 层的间隔
BOSS_DISTORTED_SPACE_INTERVAL = 10 -- 扭曲空间BOSS层的问题
SHOP_INTERVAL = 10              -- 商店 层的间隔
COMMOND_GROUP_INTERVAL = 10     -- 公共组的间隔 
HERO_INTERVAL = 30              -- 英雄模式每个场景层的间隔

REQUEST_CD_TIME = 3 --向服务器发送请求需要cd 的时间 （现在只有  好友 和工会列表数据会用）
REQUEST_ACTIVITY_GUILD_CD_TIME = 20  -- 请求公会活动时间间隔

-- 背包宠物的最大上限值
PET_MAC_BAG = 100

-- 是否切换了语言
LANGUAGE_CHANGE = nil

-- 攻击速度最小值
ATK_SPEED_MIN = 300
-- 同步时间阀值
SKILL_SYNC_MIN_TIME = 100
-- 用于判断怪物的大小处理
MONSTER_MAX_ID = 100000000
-- 进入主界面是否重启LUA虚拟机
LUA_VIRTUAL_RESTART = false
-- 洞窟商店物品开始NO 
CAVE_SHOP_NO_START = 1000
--广告打点日志http 默认重传次数
ADS_HTTP_REPEAT_COUNT = 3

Game.SEND_MESSAGE_WIDTH_LIMIT = 500

-- 用于处理设置同屏人数设置
Game.PersonCount = {3, 10, 50}

Game.TIME_LEVEL = {
    TIME_LEVEL_SECONDS = 1,       -- 秒
    TIME_LEVEL_MINUTE = 2,       -- 分钟
    TIME_LEVEL_HOUR = 3,      -- 小时
    TIME_LEVEL_DAY = 4,      -- 天
}

-- 同屏类型
Game.TOWN_MAP_TYPE = {
    MAINCITY = 10001;  -- 城镇
    GUILD = 10002; -- 公会
    HOME = 10003;  -- 家园
}

-- 同屏类型
Game.RED_POINT_TYPE = {
    NEW_ANIMATION = 1;  -- 新动画
    RED_POINT = 2;      -- 小红点
}

-- 扭曲空间类型
Game.DISTORTED_TYPE = {
    NORMAL = 1;       -- 普通的扭曲空间
    INFERNO = 2;      -- 后扭曲空间
    VOIDRIFT = 3;      -- 虚空秘境
}

-- 同屏类型
Game.AREA_TYPE = {
    AREA_TYPE_NORMAL = 1;         -- 设置页面
    AREA_TYPE_MAINLAYER = 2;      -- 主页面
}

-- 游戏模型 --
-------------------------------
-- 游戏模型大分类
Game.Category = {
    None = 0,   
    ROLE = 1,       -- 角色
    BUFF = 2,       -- buffer
    SKILL = 3,      -- 技能
    GOODS = 4,      -- 物品
    EFFECT = 5,     -- 效果
    AIRCRAFT = 6,   -- 飞行器
    NPC = 7,        -- npc
    AFFIX = 8,      -- 词缀
    TRIGGER_NPC = 9,-- 触发NPC
    TEAM = 11,      -- 队伍
    TASK = 12,      -- 任务
    PLOT = 13,      -- 剧情
    GUILD = 14,     -- 公会
    TITLE = 15,     -- 称号
    PET = 16,       -- 宠物
}
Category = Game.Category
ModelCategory = Game.Category
-------------------------------

-- 角色 --
-------------------------------
-- 角色类型
Game.RoleType = {
	None 		= 0,
	Hero 		= 10,
	Monster		= 11,
    Pet         = 12,
} 
RoleType = Game.RoleType
-- 角色状态
Game.FSMState = {
    NONE = 0,
    IDLE = 1,       -- 待机状态
    MOVE = 2,       -- 移动状态
    BATTLE = 3,     -- 战斗状态
    DIE = 4,        -- 死亡状态
    REVIVE = 5,     -- 复活状态
    WAITING_FLOOR = 6,    -- 等待下楼状态
    WAITING = 7,    -- 等待状态
}
FSMState = Game.FSMState
-- 角色性别
Game.RoleSex = {
    NONE = 0,    -- 未设定
    MALE = 1,    -- 男
    FEMALE = 2   -- 女
}
RoleSex = Game.RoleSex

-- 等待类型
Game.WaitingType = {
    WAITING_NEXT_FLOOF = 1;              -- 下楼梯
    WAITING_BACK_TOWN = 2;               -- 回城
    WAITING_BOSS_SCENARIO_TRIGGER = 3;   -- BOSS层事件
    WAITING_TRANSDOOR = 4,               -- 等待传送门
    WAITING_NORMAL = 5,                  -- 普通的等待
    WAITING_TRANSPOINT = 6,              -- 传送点
}
WaitingType = Game.WaitingType

-- 称呼更新
Game.TitleUpdateResult = {
    SUCCESS = 1,
    NO_TITLE = 2,
    SYSTEM_ERROR = 3,
    UNKNOWN = 4
}
TitleUpdateResult = Game.TitleUpdateResult
-------------------------------

-- 物品 --
-------------------------------
-- 物品类型
-- Game.GoodsType = {
--     NONE = 0,
--     EQUIPMENT = 1,   -- 装备
--     ITEM = 2,       -- 道具
--     MATERIAL = 3,   -- 材料
--     VIRTUALITEM = 4,   -- 虚拟材料
-- }
-- GoodsType = Game.GoodsType
-- 物品状态
Game.GoodsFSMState = {
    NONE = 0,
    AVAILABLE = 1, -- 可用
    DISABLE = 2,   -- 不可用
    BE_USED = 3    -- 被使用
}
GoodsState = Game.GoodsFSMState
-- 物品使用条件
Game.GoodsUseCondition = {
    NONE = 0, -- 任何情况下都可以使用
    IN_BATTLE = 1, -- 战斗状态下使用
    OUT_BATTLE = 2 -- 非战斗状态下才能使用
}
-- 物品使用场景
Game.GoodsUseScene = {
    IN_CAVE = 1,         -- 洞穴
    IN_TOWN = 2,         -- 城镇
    IN_DUNGEON = 3,      -- 大秘境
    IN_CAVE_AND_TOWN = 4,-- 洞穴和城镇
    IN_STORY = 5,        -- 引导
    IN_HERO = 6,        -- 英雄模式
    IN_TITAN_HERO = 7,        -- 泰坦英雄模式
}
-------------------------------


-- PLOT --
-------------------------------
Plot = Plot or {}

-- 情节角色类型
Plot.RoleType = {
	None 		= 0,
	Master 		= 1,  -- 玩家自己
    SmallBoss   = 10,  -- 
    BigBoss     = 11,  -- 大boss 
}
PlotRoleType = Plot.RoleType

-- 情节的动画类型
Plot.AnimationType = {
    Birth    = 1,    -- 出生
    Idle     = 2,    -- 
}
PlotAnimationType = Plot.AnimationType


-------------------------------

Game.TriggerNPCState = {
    NONE = 0,
    IDLE = 1,       -- 待机状态 
    OPEN = 2,       -- 打开状态
    DISAPPEAR = 3   -- 消失状态
}
TriggerNPCState = Game.TriggerNPCState

-- 陷阱状态机
Game.TrapState = {
    NONE = 0,
    IDLE = 1,       -- 待机状态 
    OPEN = 2,       -- 打开状态
    DISAPPEAR = 3   -- 消失状态
}
TrapState = Game.TrapState

-------------------------------

-- 飞行器 --
-------------------------------
-- 类型
Game.AircraftType = {
    NONE = 0,      
    BULLET = 1,      -- 子弹类
    GETGOODS = 2,    -- 获取道具
}
AircraftType = Game.AircraftType
-- 飞行器状态
Game.AircraftFSMState = {
    NONE = 0, 
    IDLE = 1,        -- 待机
    FLY = 2,         -- 飞行
    BOOM = 3,        -- 爆炸
    DISAPPEAR = 4    -- 消失
}
AircraftFSM = Game.AircraftFSMState
-------------------------------

-- 技能 --
-------------------------------
-- 技能类型
Game.SkillType = {
    NONE = 0,
    NORMAL_ATTACK = 1, -- 普通攻击
    PHYSICAL = 2,      -- 物理
    MAGIC = 3,         -- 法术
    ASSIST = 4,        -- 辅助
    PASSIVE = 5,        -- 被动
    HORCURX = 6       -- 魂器变身
}
SkillType = Game.SkillType
-- 技能状态
Game.SkillState = {
    IDLE = 1,
    PREPARE = 2,   -- 蓄力或者呤唱
    RELEASE = 3,   -- 释放技能
    COOLDOWN = 4   -- 冷却
}
SkillState = Game.SkillState

Game.SkillTreeModel = {
    SKILL_TREE_MODEL_NORMAL =1,       -- 默认模式技能树
    SKILL_TREE_MODEL_ADVANCED = 2,    -- 进阶模式技能树
    SKILL_TREE_MODEL_REINCARNATION = 3,    -- 转生后技能树
}
SkillTreeModel = Game.SkillTreeModel
-------------------------------

-- buffer --
-------------------------------
-- 叠加类型
Game.BufferOverlayType = {
    NONE = 0,       -- buffer独立并存
    REFRESH = 1,    -- 叠加时候刷新
    NO_REFRESH = 2  -- 叠加时候不刷新
}
BufferOverlayType = Game.BufferOverlayType

-------------------------------

-- 效果 --
-------------------------------
-- 效果产生的结果类型
Game.EffectResultType = {
    NONE = 0,
    ADD_BUFFER = 30402      -- 添加一个buffer
}
EffectResultType = Game.EffectResultType
-- 效果类型
Game.EffectType = {
    NONE = 0,
    
}
EffectType = Game.EffectType
-------------------------------

-- 行为 --
-------------------------------
-- 行为类型
Game.ActionType = {
    FSM_IDLE = 1,                   -- 状态机-IDLE
    FSM_MOVE = 2,                   -- 状态机-移动
    FSM_DIRECTION_MOVE = 3,         -- 状态机-方向移动
    FSM_BATTLE_MOVE = 4,            -- 状态机-战斗移动
    FSM_BATTLE = 5,                 -- 状态机-战斗
    FSM_DIE = 6,                    -- 状态机-死亡
    FSM_WAITING = 7,                -- 状态机-等待（下楼，回城）
    FSM_REVIVE = 8,                 -- 状态机-复活

    NPC_BOX_OPEN = 10,              -- 打开宝箱
    NPC_GOLDBAG_OPEN = 11,          -- 打开钱袋
    NPC_RUNE_OPEN = 12,             -- 打开符文
    NPC_TRAP_OPEN = 13,          -- 触发陷阱
    NPC_TRIGGER_OPEN = 14,          -- 打开触发类NPC

    BUFFER = 100,                   -- buffer
    EFFECT = 101,                   -- 效果
    NORMAL_ATTACK = 1001,     -- 技能－普攻
    SKILL_PHYSICAL = 1002,          -- 技能－物理
    SKILL_SPELL = 1003,             -- 技能－法术
    SKILL_PASSIVE = 1004,           -- 技能－被动
    SKILL_ASSIST = 1005,            -- 技能－辅助
    SKILL = 1006,             -- 技能
    AIRCRAFT_BULLET = 2001,          -- 飞行道具－子弹
    AIRCRAFT_GETGOODS = 2002,


    FUNCTION_ADD_ROLE = 3000,          -- 添加一个角色
    FUNCTION_ROLE_ZOEDER = 3001,       -- 角色z序
    FUNCTION_ROLE_LEVEL_UP = 3002,     -- 角色升级
}
ActionType = Game.ActionType
-------------------------------

-- 游戏设置状态 --
-------------------------------

Game.MoveType = {
    ALL = 1,               -- 两者都要
    CLICK = 2,             -- 点击
    CONTROLLER = 3,        -- 控制器
    NORMAL = 4,            -- 经典方式
}
MoveType = Game.MoveType

-------------------------------

-- 英雄血量显示方式 --
-------------------------------
Game.ShowType = {
    NONE    = 1,        -- 不显示
    PERCENT = 2,        -- 百分比
    VALUE   = 3,        -- 数值
}
ShowType = Game.ShowType
-------------------------------


-- 游戏全局属性 --
-------------------------------
-- 玩家状态
Game.State = {
    NONE = 0,
    HOTFIX = 1,    -- 正在更新
    LOGIN = 2,     -- 正在登录
    IN_TOWN = 3,   -- 在城镇
    IN_CAVE = 4,   -- 在洞穴
    IN_GUILD = 5,  -- 在公会
    IN_STORY = 6,  -- 在剧情模式
    IN_DUNGEON = 7,-- 在大秘境场景
    IN_HERO = 8,   -- 在英雄模式
    IN_DREAM = 9,   -- 在梦境挑战模式
    IN_WORLDBOSS = 10,   -- 在worldBoss
    IN_GUILDBOSS = 11,   -- 在GuildBoss
    IN_DESERT_EYES = 12,   -- 在沙之眼
    IN_DISTORTED_SPACE = 13,   -- 在扭曲空间
    IN_ACT = 14,               -- 在活动副本
    PET_PVP = 15,   --在宠物战斗模式
    IN_HOME = 16,   --在家园
    IN_INFERNO = 17,   -- 在深红炼狱
    IN_GHOST_ABYSS = 18,   -- 在幽林深渊
    IN_MANOR = 19, --在庄园
    IN_VOID_RAFT = 20, -- 在虚空秘境   
    IN_TRIAL_LAND = 21, --在活动副本试炼之地
    IN_VIKING = 22,      --在双怪副本
    IN_EVER_WINTER = 23,      --在永冬裂缝
    IN_TITAN_ROAD = 24,      --在泰坦之路
    IN_TITAN_HERO = 25,      --在泰坦之路英雄模式
    IN_TREATURE_HUNT = 26,    --在洞窟探宝
    IN_PORT = 27,       --在大航海港口
    IN_DRIED_SPRING = 28,       --在干涸之泉
    IN_EXP = 29,       --在经验副本
    IN_CHAOS_WORMHOLE = 30,       --在混沌虫洞
    IN_WORMHOLE = 31,       --在虫洞深处
}
GameState = Game.State

-- 同屏类型
Game.SCREEN_TYPE = {
    MASTER = 0; --客户端自建命令
    GLOBAL = 1; --小地图
    SCREEN = 2; --屏幕
}
GameScreenType = Game.SCREEN_TYPE

-- 添加触发类型
Game.PLACEHOLER_TYPE = {
    LEFT_BOTTOM = 1;  -- 以左下角为起点
    CENTER = 2;       -- 以中心点处理
    CROSS = 3;       -- 以中心点十字处理
}
GamePlaceholerType = Game.PLACEHOLER_TYPE

-- 技能使用状态
Game.UseSkillState = {
    NONE = 0,
    IDLE = 1,       -- 技能准备就绪
    PREPARE = 2,    -- 蓄力或者呤唱
    RELEASE = 3,    -- 释放
    COOLDOWN = 4,   -- 冷却
    DONE = 5        -- 使用完成
}

-- loading 加载类型
LoadingType = {
    LoadingType_Normal = 1;
    LoadingType_Downstairs = 2;
}

-- 背包UI类型，用于区分商店页面物品栏以及点金等物品栏
Game.BagUIType = {
    NORMAL = 1;     -- 普通页面
    CAVE_SHOP = 2;  -- 洞穴商店
    BLACK_SHOP = 3; -- 黑商
}
GameBagUIType = Game.BagUIType

-- 行为轨道索引
Game.TRACKS_INDEX = {
    NONE = 0,
    FSM = 1,        -- 状态机轨道
    BUFFER = 2,     -- buffer轨道
    EFFECT = 3,     -- 效果轨道
    AIRCRAFT = 4,   -- 飞行道具
    FUNCTION = 5,   -- 功能轨道
}
GameTracksIndex = Game.TRACKS_INDEX

Game.TRIGGER_TYPE = {
    TRIGGER_ALL = 0;           -- 触发所有
    TRIGGER_NOBENODEPATH = 1;  -- 支触发不能寻路
    TRIGGER_BENODEPATH = 2;    -- 只触发可以寻路
}
GameTriggerType = Game.TRIGGER_TYPE

-- 处理触发的类型
Game.HANDLE_TRIGGER_TYPE = {
    TRIGGER_NO_REACHABLE = 0;        -- 触发不可到达
    TRIGGER_NO_BE_NODE_OF_PATH = 1;  -- 触发不能够被寻路
    TRIGGER_BE_NODE_OF_PATH = 2;     -- 触发能够被寻路
}
GameHandleTriggerType = Game.HANDLE_TRIGGER_TYPE

Game.TRIGGER_TIME_TYPE = {
    TRIGGER_TIME_NORMAL = 0;    -- 非移动模式，在初始化，拖动等情况触发
    TRIGGER_TIME_PRE = 1;       -- 开始两个之间移动
    TRIGGER_TIME_HALF = 2;      -- 两格之间
    TRIGGER_TIME_NOW  = 3;      -- 当前格子
}
GameTriggerTimeType = Game.TRIGGER_TIME_TYPE

Game.BACK_TOWN_TYPE = {
    BACK_TOWN_TYPE_SETTING = 0;    -- 设置界面
    BACK_TOWN_TYPE_BLACK_HOME = 1;       -- 小黑屋
}
BACK_TOWN_TYPE = Game.BACK_TOWN_TYPE

Game.KICK_OUT_TYPE = {
    KICK_OUT_TYPE_KICK = 0;              -- 退出东西
    KICK_OUT_TYPE_END_CAVE = 1;          -- 活动副本结束
    KICK_OUT_TYPE_END_DREAM = 2;         -- 梦境结束
    KICK_OUT_TYPE_END_GUILD_BOSS = 3;    -- 公会副本结束
}
KICK_OUT_TYPE = Game.KICK_OUT_TYPE

-- 动画缩放值
Game.HERO_ANIMATION_SCALE = 0.6
Game.MONSTER_ANIMATION_SCALE = 1.0
Game.NPC_ANIMATION_SCALE = 1.0
Game.SKILL_EFFECT_SCALE = 1.0
Game.BUFFER_EFFECT_SCALE = 1.0
Game.NORMAL_EFFECT_SCALE = 0.6
Game.AIRCRAFT_ANIMATION_SCALE = 0.6
Game.MAP_GRID_EFFECT = 0.6

Game.TREASURE_FUNCTION_TYPE = 99999     -- 藏宝图功能类型
-------------------------------


PlotEventType = {
    NONE = 0,
    VIBRATE = 1,                    --振动
    SCENE_MOVE = 2,                 --镜头移动
    SCENE_RETURN = 3,               --镜头回归
    SHIELD_OPERATION = 4,           --屏蔽操作
    SHOWUI = 5,                     --显示隐藏UI
    WIDE_SCREEN = 6,                --宽幕
    BLACK_SCREEN_INTERLUDE = 7,     --黑幕
    PLAY_SPINE = 8,                 --播放动画
}

BlackDialogEventType = {
    FIRST_PLAY_GAME = 1,           -- 第一次进入游戏
    PLAYER_DIED     = 2,           -- 彻底死亡触发，在城镇触发
    PORTAL_TO_TOWN  = 3,           -- 传送门 回城触发， 在城镇触发
    PLAYER_BACK_TOWN = 4,          -- 玩家通过设置页面返回/被踢出
    FIRST_OPEN_PANNEL = 5,         --首次打开指定界面时触发
    BIGSAIL_ACTIVITY_OPEN_FIRST = 6,         --每次大航海岛怪活动开启时，首次进入港口触发
}

-- 重复操作处理类型
RepeatHandleType = {
    NONE = 0,
    QUICK_BAG = 1,                 -- 快捷背包

    TASK_REWARD = 11,                 -- 任务 领奖
    TURN_TABLE_BUY = 13,       -- 转盘— 购买次数
    CAT_FOOD   = 14,             -- 猫饭
    FRIEDN_DELETE = 15,               --好友删除
    FRIEDN_INVITE = 16,               --好友邀请
    BEAUTYSALON = 17,                 --捏脸
    DUNGEON_GUARD = 18,               --大秘境门卫

    STRENGTHEN = 19,                  --装备强化
    REMOULD    = 20,                  --装备改造 
    RESOLVE    = 21,                  --装备分解
    FORGE      = 22,                  --装备锻造
    CONVERT      = 23,                  --装备转换
    PET_STRENGTHEN = 24,              --宠物装备强化

    GUILD_APPLY_JOIN = 30,            -- 加入公会申请
    GUILD_LEADER_TILE_TRANSFER = 31,  -- 会长职务转让
    GUILD_TICK_MEMBER = 32,           -- 踢出成员
    GUILD_EXIT = 33,                  -- 退会
    GUILD_DEAL_JOIN_REQ_OK = 34,      -- 同意入会处理 
    GUILD_TASK_REWARD = 35,           -- 处理任务奖励
    GUILD_LEARN_TECH = 36,            -- 处理学习公会科技

    CREATE_ROLE = 50,                 -- 创建角色

    NPC_GOLDEN = 51,                  -- 点金
    NPC_ENCHANT = 52,                 -- 附魔
    NPC_CAT_FOOD = 53,                -- 猫饭
    NPC_ACHIEVEMENT = 54,             -- 成就
    
    BAG_SELL_OR_DESTORY_DATA = 60,    -- 背包卖出或销毁数据列表
    BAG_SELL_OR_DESTORY = 61,         -- 背包销毁以及卖出
    BAG_CAVE_SHOP_BUY = 62,           -- 洞穴商店购买
    BAG_BLACK_SHOP_BUY = 63,          -- 黑商购买
    BAG_SKILL_RESET = 64,             -- 背包技能
    EDIT_NAME = 65,                   -- 修改名字
    BAG_RANDOM_SHOP_BUY = 66,         -- 随机商店购买

    ACTIVITY_REWARD = 68,             -- 活动奖励领取

    GOODS_DRAG_PACKET_DATA = 70,      -- 物品拖拽， key: this:frompacket
    -- TEAM_
}

--武器类型
-- 00表示通用技能
-- 01表示剑盾
-- 02表示双刀
-- 03表示大剑
-- 04表示法杖
-- Game.EQUIP_TYPE = {
    
-- }

ChatChannelType = {
    SYSTEM   = 1,           -- 系统频道
    TEAM     = 2,           -- 队伍频道
    GUILD    = 3,           -- 工会频道
    PERSONAL = 4,           --  私聊频道
    NEAR     = 5,           --附近
    QUICK    = 6,           --  快捷聊天频道
    GUILD_SELECT_FLOOR = 7, -- 用于公会副本界面
    WORLD = 8, --世界频道
}

ChatMessageType = {
    SYSTEM_MESSAGE   = 1,   -- 系统消息
    TEAM     = 2,           -- 队伍消息
    GUILD    = 3,           -- 工会消息
    PERSONAL = 4,           --  私聊消息
    NEAR     = 5,           --附近消息
    SYSTEM_NOTICE = 6,       --系统公告
    SYSTEM_TEAM = 7,       --队伍公告
    SYSTEM_GUILD = 8,       --工会公告
    SYSTEM_FRIEND = 9,       -- 好友公告
    SYSTEM_TEAM_MEMBER = 10,     --队伍成员公告
    SYSTEM_GUILD_MEMBER = 11,       --工会成员公告
    SYSTEM_NEAR = 12,    -- 附近公告
    WORLD = 13,    -- 世界频道消息
    SYSTEM_GUILD_INVITE = 14,       --工会邀请
}

local MsgType = ChatMessageType
local CnlType = ChatChannelType
--消息 映射 频道表
ChatMessageTypeMap = {
    [MsgType.SYSTEM_MESSAGE] = {CnlType.QUICK, CnlType.SYSTEM},
    [MsgType.TEAM]           = {CnlType.QUICK, CnlType.TEAM},
    [MsgType.GUILD]          = {CnlType.QUICK, CnlType.GUILD},
    [MsgType.PERSONAL]       = {CnlType.QUICK, CnlType.PERSONAL},
    [MsgType.SYSTEM_NOTICE]  = {CnlType.QUICK, CnlType.SYSTEM, CnlType.NEAR, CnlType.TEAM, CnlType.GUILD, CnlType.PERSONAL, CnlType.WORLD},
    [MsgType.NEAR]           = {CnlType.QUICK, CnlType.NEAR},
    [MsgType.SYSTEM_TEAM]    = {CnlType.QUICK, CnlType.TEAM, CnlType.SYSTEM},
    [MsgType.SYSTEM_GUILD]   = {CnlType.QUICK, CnlType.GUILD, CnlType.SYSTEM},
    [MsgType.SYSTEM_FRIEND]  = {CnlType.QUICK, CnlType.SYSTEM},
    [MsgType.SYSTEM_TEAM_MEMBER]    = {CnlType.QUICK, CnlType.TEAM},
    [MsgType.SYSTEM_GUILD_MEMBER]   = {CnlType.QUICK, CnlType.GUILD},
    [MsgType.SYSTEM_NEAR]   = {CnlType.QUICK, CnlType.NEAR},
    [MsgType.WORLD]   = {CnlType.QUICK, CnlType.WORLD},
    [MsgType.SYSTEM_GUILD_INVITE]  = {CnlType.QUICK, CnlType.GUILD},
}
--频道logo
ChatMessageTypeIcon = {
    [MsgType.SYSTEM_MESSAGE] = CnlType.SYSTEM,
    [MsgType.TEAM]           = CnlType.TEAM,
    [MsgType.GUILD]          = CnlType.GUILD,
    [MsgType.PERSONAL]       = CnlType.PERSONAL,
    [MsgType.SYSTEM_NOTICE]  = CnlType.SYSTEM,
    [MsgType.NEAR]  = CnlType.NEAR,
    [MsgType.SYSTEM_TEAM]    = CnlType.TEAM,
    [MsgType.SYSTEM_GUILD]   = CnlType.GUILD,
    [MsgType.SYSTEM_FRIEND]  = CnlType.SYSTEM,
    [MsgType.SYSTEM_TEAM_MEMBER]    = CnlType.TEAM,
    [MsgType.SYSTEM_GUILD_MEMBER]   = CnlType.GUILD,
    [MsgType.SYSTEM_NEAR]  = CnlType.NEAR,
    [MsgType.WORLD]  = CnlType.WORLD,
    [MsgType.SYSTEM_GUILD_INVITE]   = CnlType.GUILD,
}

--本地  UserDefault 存储key
UserDefaultKeyWord = {
    MonsterIsGod = "MonsterIsGod",
    HeroIsGod = "HeroIsGod",
    PetIsGod = "PetIsGod",
    HeroNewbie = "HeroNewbie",
    SystemNoticeIndex = "SystemNoticeIndex",
    UnLockAllFunc = "UnLockAllFunc",
    CommentSuccess = "CommentSuccess",
    ShowTownNoticeTime = "ShowTownNoticeTime",
    ReadUserProtocol = "ReadUserProtocol",
    UserProtocolVersion = "UserProtocolVersion",
    AllowUserProtocolStatus = "AllowUserProtocolStatus",
    alreadySendUserProtocolRecord = "alreadySendUserProtocolRecord",
    mentorLastInteraction = "mentorLastInteraction",

    musicVolume = "musicVolume",    -- 音乐音量
    soundsVolume = "soundsVolume",  -- 音效音量
    musicVolumeForDisplay = "musicVolumeForDisplay",    -- 音乐音量
    soundsVolumeForDisplay = "soundsVolumeForDisplay",  -- 音效音量
    voiceChatSpeakerVolume = "voiceChatSpeakerVolume",  -- 语音聊天播放音量
    voiceChatMicVolume = "voiceChatMicVolume",          -- 语音聊天录音音量
    voiceChatSpeakerMuted = "voiceChatSpeakerMuted",  -- 语音聊天播放静音
    voiceChatMicMuted = "voiceChatMicMuted",          -- 语音聊天录音静音
    voiceChatAndroidPermissionReuqested = "voiceChatMivoiceChatAndroidPermissionReuqestedcVolume",          -- 语音聊天录音音量
    PunishmentState = "PunishmentState",    -- 惩罚状态
    PunishmentTime = "PunishmentTime",      -- 惩罚时间
    is_activity = "is_activity",            -- 是否第一次打开游戏
    is_first_report = "is_first_report",    -- 是否第一次上报
    moveType = "moveType",                  -- 移动类型
    showType = "showType",                  -- 血量显示类型
    fpsMode = "fpsMode",                    -- 分辨率模式
    fpsToast = "fpsToast",                  -- 高分辨是否已经提示过玩家
    oldLanguage = "oldLanguage",
    language = "language",
    GMUtilShowCord = "GMUtilShowCord",
    fisrt_play_game = "fisrt_play_game",
    isFirstEnterTown = "isFirstEnterTown",
    InStoryLastKillerIsBoss = "InStoryLastKillerIsBoss",
    identify = "identify",
    GMUtilDefaultTab = "GMUtilDefaultTab",
    GMUtildefaultToNewTab = "GMUtildefaultToNewTab",
    LoginNoticeLastShowTime = "LoginNoticeLastShowTime",
    lastReportDelyDay = "lastReportDelyDay",
    IsNotificationAuthenticationRequested = "IsNotificationAuthenticationRequested",
    LastSelectTimeCaveMode = "LastSelectTimeCaveModes", --上次选择时光之门的 模式 （普通 or 英雄）--要和玩家pk 拼接存取
    LastNewShowArhMode = "LastNewShowArhMode", -- 上次图鉴界面选中的模式
    isNoticeRemould = "IsNoticeRemould", -- 改造消耗过高时 是否二次确认
    EquipIllusionNew = "EquipIllusionNew",
    isNoticeGemBuy = "IsNoticeGemBuy", -- 购买符文消耗钻石时 是否二次确认
    isNoticeSellEquip = "isNoticeSellEquip", -- 出售或删除金色以上品质物品时 是否二次确认
    isNoticeDiamondBuyItem = "isNoticeDiamondBuyItem", -- 花费钻石购买单个物品时 是否二次确认
    isNoticeDiamondLostRealm = "isNoticeDiamondLostRealm", -- 花费钻石购买lostrealm 的次数，是否二次确认
    isNoticeConfigFightSkill = "isNoticeConfigFightSkill", -- 提示配置技能出站 是否二次确认
    dreamSelectLastUnlockActionIndex = "dreamSelectLastUnlockActionIndex", -- 梦境选关节面上次播放动画的标示
    isNoticeRecast = "isNoticeRecast", -- 重铸系统 是否二次确认
    ForgeEquipNew = "ForgeEquipNew",    -- 装备锻造NEW标识
    AdvGiftNew = "AdvGiftNew",    -- 进阶礼包提示
    ShowStarPrayLockNew = "ShowStarPrayLockNew",    -- 星痕解锁动画 和 红点
    StarPrayShopCost = "StarPrayShopCost",    -- 星痕解锁占星痕消耗
    LotteryRefreshCost = "LotteryRefreshCost",    -- 星痕解锁占星痕消耗
    LastSelectTimeDistoreMode = "LastSelectTimeDistoreMode", --上次选择时扭曲空间的模式 （ Game.DISTORTED_TYPE 普通 or 后扭曲空间（深红炼狱））--要和玩家pk 拼接存取

    EquipRemoveLevel = "EquipRemoveLevel",

    ApprenticeFirstTimeShown = "ApprenticeFirstTimeShown",

    FirstOpenPannel = "fisrt_open_pannel_",
    LastSelectTimeCaveLayerType = "LastSelectTimeCaveLayerType", --上次选择时光之门的layerType--要和玩家pk 拼接存取
    LastSelectDesertCaveLayerType = "LastSelectDesertCaveLayerType", --上次选择沙之眼的layerType--要和玩家pk 拼接存取
    SailEventRedPointLastRefreshTime = "SailEventRedPointLastRefreshTime", --大航海事件红点最后更新时间--要和玩家pk 拼接存取
    BigSailActivityOpen = "BigSailActivityOpen", --大航海岛怪活动开启
}

-- 占位符类型名字
PlaceholerTypeName = {
    MONSTER = "Monster",
    TRIGGER_NPC = "trigger_npc",
    NPC_INFOMATION = "NPC_infomation",
    TRIGGER_MONSTER_TITLE = "trigger_Monster_title",
}

--日志标签
LOG_TAG = {
    ARCHIVE_UI_TAG = 1,            --战利品 标签
    MONSTER_COLLECTION_UI_TAG = 2, --怪物图鉴标签
    FUNNY_RECORD_UI_TAG = 3,       --趣味数据标签
}
--任务标签
TASK_TAG = {
    TASK_UI_TAG = 1, --任务界面
    TREASURE_UI_TAG = 2, -- 藏宝图界面
}

--背包标签
BAG_TAG = {
    ROLE_TAG = 1, -- 角色
    TASK_TAG = 2, --任务
    SKILL_TAG = 3,--技能
    LOG_TAG = 4,--日志
    SET_TAG = 5,--设置
}

-- 背包解锁类型
UNLOCK_BAG_FLAG = {
    UNLOCK_BAG_FLAG_BAG = 1, -- 背包
    UNLOCK_BAG_FLAG_WAREHOUSE = 2, -- 仓库
}

HIGH_TIP_ACTION_TYPE = {
    FUNCTION_UNLOCK = 1, -- 系统解锁
    CHECK_POINT = 2, --存档点
    ACHEVEMENT = 3, --成就
    UNLOCK_LEVEL_DIFFICULTY = 4, --难度解锁
    HERO_TITLE_UNLOCK = 5, -- 称号解锁
}

--引导评论打点
COMMENT_TYPE = {
    KILL_BOSS             = 1,--击杀boss        --first blood
    DUNGEON_SEASON_REWARD = 2,--大秘境赛季奖励   --领取成功触发
    PASS_CAVE             = 3,--关卡通关        --回城后触发
    PERFECT_ALL_EQUIPMENT = 4,--装备全部暗金     --装备后触发
    PASS_DUNGEON          = 5,--大秘境 通关     --回城后触发
    USE_ESCAPE_ITEM       = 6,--成功使用逃脱卷轴 --回城后触发
    FINISH_ALL_MAIN_TASK  = 7,--主线任务全部完成 --领奖触发
    NOVICE_GUID           = 8,--新手引导配置事件 --新手引导触发
}

--引导评论打点 弹出框类型
COMMENT_ALERT_TYPE = {
   SCORE = 1,   --评分弹出框
   MESSAGE = 2, --留言弹出框
}

--1: 表示唤醒触发， 2表示点击屏幕触发
COMMENT_END_NOTICE_TYPE = {
   GAME_ACTIVE = 1,   
   TOUCH_SCREEN = 2, 
}

--1: 登陆公告 2：游戏内公告
NOTICE_TYPE = {
   LOGIN_NOTICE = 1,   
   TOWN_NOTICE  = 2, 
}

--象限：平面直角坐标系（笛卡尔坐标系）中里的横轴和纵轴所划分的四个区域
QUADRANT_AREA = {
   AREA_1 = 1,   
   AREA_2 = 2,
   AREA_3 = 3,
   AREA_4 = 4 
}

CHAT_CELL_STATUS = { --聊天文本翻译状态--四个状态：1、不可以翻译状态 2、可翻译状态 3、翻译中 4、翻译成功
    FORBIDEN_TRAN = 1,
    ALLOW_TRAN    = 2,
    TRANLATING    = 3,
    FINISH_TRAN   = 4
}

CHAT_CELL_LAYOUT_TYPE = {
    RichText = 1,      --排版1：富文本（系统频道，维护消息）、隔离线
    LogoRichText = 2,  --排版2：频道标识、富文本（只有快捷频道有）、隔离线
    HeadRichText = 3,  --排版3：头像、职位（可选）、名字、文本底框，富文本、翻译文本底框、翻译富文本、翻译按钮
    BtnRichText = 4,   --排版4：头像、职位（可选）、名字、文本底框，富文本、按钮（同意和拒绝）
    Text = 5,
}

--队伍状态:1:准备匹配,2:准备
TEAM_STATE = {
    BEGINMATCH = 0,--开始组队按钮
    MATCHING = 1,--匹配中
    READYING = 2,--准备中（倒计时）
    FINISHING = 3,--点击准备后，继续倒计时
}  

CUSTOM_HQ_TYPE = {
    WEATHER = 1,    -- 天气
    NPC = 2,        -- NPC表现
    FRAME = 3,      -- 高帧率
    DECORATE = 4,   -- 装饰物
    FLOATS = 5,     -- 背景漂浮物
    HORCRUX = 6,    -- 城镇、队友、世界boss魂器
    PET = 7,        -- 城镇、队友、世界boss宠物
    PERSON = 8,     -- 场景显示人数
}

CUSTOM_HQ_SET_MAP = {
    {
        [CUSTOM_HQ_TYPE.WEATHER] = false,
        [CUSTOM_HQ_TYPE.NPC] = false,
        [CUSTOM_HQ_TYPE.FRAME] = false,
        [CUSTOM_HQ_TYPE.DECORATE] = false,
        [CUSTOM_HQ_TYPE.FLOATS] = false,
        [CUSTOM_HQ_TYPE.HORCRUX] = false,
        [CUSTOM_HQ_TYPE.PET] = false,
        [CUSTOM_HQ_TYPE.PERSON] = 1,
    },
    {
        [CUSTOM_HQ_TYPE.WEATHER] = true,
        [CUSTOM_HQ_TYPE.NPC] = true,
        [CUSTOM_HQ_TYPE.FRAME] = true,
        [CUSTOM_HQ_TYPE.DECORATE] = true,
        [CUSTOM_HQ_TYPE.FLOATS] = true,
        [CUSTOM_HQ_TYPE.HORCRUX] = false,
        [CUSTOM_HQ_TYPE.PET] = false,
        [CUSTOM_HQ_TYPE.PERSON] = 2,
    },
    {
        [CUSTOM_HQ_TYPE.WEATHER] = true,
        [CUSTOM_HQ_TYPE.NPC] = true,
        [CUSTOM_HQ_TYPE.FRAME] = true,
        [CUSTOM_HQ_TYPE.DECORATE] = true,
        [CUSTOM_HQ_TYPE.FLOATS] = true,
        [CUSTOM_HQ_TYPE.HORCRUX] = true,
        [CUSTOM_HQ_TYPE.PET] = true,
        [CUSTOM_HQ_TYPE.PERSON] = 3,
    },
}


--大秘境士兵位置
NPC_TYPE_GUARD_POS_X = 39
NPC_TYPE_GUARD_POS_Y = 27
-- 客户端消息 --
-------------------------------
Game.ClientMessage = {
    MC_CLICK_MAP_TILE = 1,     -- 点击地块

    MC_PING_VALUE = 2, -- 发送ping值
    MC_SEND_INTERVAL = 3, -- 发送间隔
    MC_SET_BLOCKING_TOUCHES = 1001,             -- 阻止触摸

    MC_COMMON_SHOW_MASTER = 10000,          -- 显示玩家(自己)
    MC_LOGIN_GET_HERO_LIST = 10001,  
    MC_LOGIN_LOGIN_VERIFY_FAILED = 10002,
    MC_NET_DISCONNECT = 10003,              -- 网路断开
    MC_LOGIN_ACCOUNT_VERIFY        = 10004, -- 账号验证结果   
    MC_NET_CONNECT_COMPLETE = 10005,        -- 网络连接成功
    MC_LOGIN_NO_HERO = 10006,               -- 没有角色
    MC_LOGIN_CREATE_HERO_RESULT = 10007,    -- 创建英雄结果
    MC_LOGIN_VERIFY_RESULT = 10008,         -- 验证结果
    MC_LOGIN_ENTER_GAME = 10009,      
    
    MC_GAME_ENTER_BACKGROUND = 10010,       --游戏切到后台
    MC_GAME_ENTER_PROGROUND = 10011,         --游戏切到前台
    MC_COMMON_SHOW_PET = 10012,             --显示宠物数据
    MC_LOGIN_AUTO_LOGIN = 10013,             --自动快速登陆
    MC_LOGIN_REFRESH_AREAINFO = 10014,      --登录页面刷新区服信息


    MC_UI_EQUIP_ILLUSION_SHOW = 11000,      -- 装备幻化

    MC_HTTP_BANNER_INFO_REFRESH = 15001,    -- banner信息 刷新
    MC_UI_RETFRESH_MAIL_LIST = 15002, --刷新邮件列表
    MC_UI_RETFRESH_MAIL_LIST_CELL = 15003, --刷新邮件列表单个cell移除动画
    MC_UI_REMOVE_MAIL_IN_LAYER = 15004, --删除在邮件界面的拷贝数据的单个cell
    MC_UI_RETFRESH_ONE_MAIL_INFO = 15005, --刷新单个邮件的状态
    MC_UI_CLOSE_MAIN_MAIL_LAYER = 15006, --关掉邮件主界面
    MC_UI_GOODS_USE_INFO_CHANGE = 15007, -- 使用物品数据有修改

    MC_MAP_SET_IS_CAVE_SHADOW_SHOW = 16000,          -- 设置是否显示遮罩


    MC_ROLE_INIT_HERO_DATA = 20000,       --初始化英雄  （考虑去掉）
    MC_ROLE_UPDATE_HERO_DATA = 20001,     --英雄数据更新
    MC_ROLE_UPDATE_MONSTER_DATA = 20002,  --怪物数据更新
    MC_ROLE_START_MOVE = 20003,           -- 开始移动
    -- MC_ROLE_STOP_MOVE = 20004,            -- 停止移动
    MC_ROLE_GET_GOODS = 20005,            -- 获得物品  格式：物品数据模型
    MC_ROLE_ITEM_COOLDOWN_CHANEG = 20006, -- 道具冷却状态有改动（没有参数，UI表现只需要刷新数据）
    MC_ROLE_FSMSTATE_CHAGNE = 20007,      -- 角色状态改变 格式：{spriteID {number},fsmState {number:参见 FSMState.IDLE}}
    -- MC_ROLE_ENABLE_MOVING = 20008,        -- 启用移动
    -- MC_ROLE_DISABLE_MOVING = 20009,       -- 禁止移动
    MC_ROLE_UPDATE_COORD = 20010,         -- 更新角色位置
    MC_ROLE_LEVEL_UP = 20011,             -- 角色升级
    MC_ROLE_IDLE = 20012,                 -- 角色idle
    MC_ROLE_SEND_SIGNAL = 20013,          -- 角色发送信号
    MC_ROLE_CAVE_SHOP_DATA_CHANGE = 20014,-- 洞穴商店数据改变
    MC_ROLE_CURRENCY_CHANGE = 20015,      -- 货币改变 {costType:*,value:*}
    MC_ROLE_INIT_PET_PVP_DATA = 20016,      -- 


    MC_ROLE_BLACK_SHOP_DATA_CHANGE = 20017, -- 黑市商人数据改变 {剩余商品列表 BlackShopData}
    MC_ROLE_SHOW_BLACK_SHOP = 20018,      -- 显示黑商数据
    MC_ROLE_SHOW_KICKED     = 20019,      -- 显示踢出倒计时

    MC_ROLE_TRIGGER_MONSTER = 20020,      --触发怪物
    MC_ROLE_SHOW_ROLE_INFO = 20021,       -- 显示角色详情 {spriteID}
    MC_ROLE_CHANGE_TYPE = 20022,          -- 改变类型，变身这些  GameData
    MC_ROLE_CAN_RECIVE_SEASON_REWARD = 20023,          -- 是否能领取大秘境奖励
    MC_ROLE_KILL_MONSTER = 20024,         -- 杀死怪物
    MC_ROLE_MASTER_UPDATE_COORD = 20025,  -- 更新主角位置，格式：coordX, coordY
    MC_ROLE_MASTER_DIED_IN_BATTLE = 20026,-- 主角在战斗中死亡, 格式: 杀手怪物

    MC_ROLE_SHOW_DOWNSTAIRS_LEAVE = 20027,      -- 下楼效果离开
    MC_ROLE_SHOW_DOWNSTAIRS_ENTER = 20028,      -- 下楼效果进入

    MC_ROLE_MASTER_DEAD = 20029,                -- 主角死亡
    MC_ROLE_MASTER_REVIVE = 20030,              -- 主角复活
    MC_ROLE_BLACK_SHOP_EXCHANGE_RESULT = 20031,      -- 黑商购买结果

    MC_ROLE_TITLE_CHANGE = 20032,              -- 角色(包括其他同屏角色)称号更新

    MC_ROLE_SHOW_RANDOM_SHOP = 20033,      -- 显示随机商店数据
    MC_ROLE_RANDOM_SHOP_DATA_CHANGE = 20034, -- 随机商店数据改变 {剩余商品列表 RandomShopData}
    MC_ROLE_RANDOM_SHOP_EXCHANGE_RESULT = 20035,      -- 随机商店购买结果
    MC_ROLE_SHOW_DREAM_END = 20036,         -- 显示梦境退出界面
    MC_ROLE_SHOW_GET_DREAM_TASK = 20037,         -- 显示梦境领取任务界面
    MC_UI_SHOW_EQUIP_RECAST = 20038,         --显示装备重铸界面
    MC_UI_SHOW_EXTRA_GIFT = 20039,         --显示超值礼包界面
    MC_UI_SHOW_ADV_GIFG = 20040,         --显示进阶礼包界面
    MC_UI_EXPEDITION_BAG_CHANGE = 20041,         --探险队背包变动
    MC_UI_BAG_CHANGE = 20042,         --背包变动
    MC_UI_QUICK_DOWN_CHANGE = 20043,         --快捷下洞

    MC_PET_DEAD = 20044,                -- 宠物死亡
    MC_PET_REVIVE = 20045,              -- 宠物复活
    MC_ROLE_UPDATE_DUNGEON_SWEEP_NUM = 20046,          -- 刷新大秘境扫荡次数
    MC_ROLE_SHOW_DUNGEON_SWEEP_REWARD = 20047,          -- 显示大秘境扫荡奖励
    MC_ROLE_SWEEP_DISTOREDSPACE_RESPONSE = 20048,     -- 显示扭曲扫荡结果
    MC_ROLE_SWEEP_INFERNO_RESPONSE = 20049,     -- 显示深红炼狱扫荡结果
    
    MC_BATTLE_ADD_TEAMMETA = 30000,       -- 添加一个队友(弃用)
    MC_BATTLE_REMOVE_TEAMMETA = 30001,    -- 移除一个队友(弃用)
    MC_BATTLE_MONSTER_DIE = 30002,        -- 怪物死亡
    MC_BATTLE_MONSTER_DETAIL = 30003,     -- 查看怪物详情
    MC_BATTLE_LEAVE_MONSTER_DETAIL = 30004, -- 离开查看怪物详情
    MC_BATTLE_ENTER_BATTLE = 30005,       -- 进入战斗,需要展示战斗界面等
    MC_BATTLE_LEAVE_BATTLE = 30006,       -- 退出战斗，需要移除战斗界面
    MC_BATTLE_USE_SKILL = 30007,          -- 使用技能
    MC_BATTLE_ESCAPE = 30008,             -- 准备逃跑
    MC_BATTLE_ADD_BUFFER = 30009,         -- 添加buffer，格式：{bufferData (table), bufferEntityID {number}, bufferTargetID (number)}
    MC_BATTLE_UPDATE_BUFFER = 30010,      -- 更新buffer，格式：{bufferData (table), bufferEntityID {nubmer}, bufferTargetID (number), overlay (number), leftTime (number)}
    MC_BATTLE_REMOVE_BUFFER = 30011,      -- 移除buffer，格式：{bufferData (table), bufferEntityID {number}, bufferTargetID (number)}
    -- MC_BATTLE_ADD_MONSTER = 30014,        -- 添加一个怪物
    -- MC_BATTLE_REMOVE_MONSTER = 30015,     -- 删除一个怪物
    -- MC_BATTLE_ADD_NPC = 30016,            -- 添加一个npc
    -- MC_BATTLE_REMOVE_NPC = 30017,         -- 删除一个npc
    MC_BATTLE_ADD_GAME_MODEL = 30018,     -- 添加一个模型
    MC_BATTLE_REMOVE_GAME_MODEL = 30019,  -- 删除一个模型
    MC_BATTLE_OPEN_NPC = 30020,           -- 打开npc（宝箱，符文等）
    MC_BATTLE_CANCEL_SKILL = 30021,       -- 技能取消选择对象（中断，取消，对象选择成功）
    MC_BATTLE_SKILL_COOLDOWN = 30012,     -- 技能冷却 数据格式:{skillID(技能id)}
    MC_BATTLE_SKILL_ACCUMULATE = 30022,   -- 技能呤唱 数据格式:{skillID(技能id), duration(技能呤唱时间), timeStamp(技能开始呤唱的时间戳)}
    MC_BATTLE_SKILL_RELEASE = 30023,      -- 技能释放 数据格式:{skillData(技能数据)}
    MC_BATTLE_SKILL_BREAK = 30024,        -- 技能中断 数据格式:{skillID(技能id)}
    MC_BATTLE_MONSTER_ATTACK = 30025,     -- 怪物攻击目标 数据格式:{spriteID(攻击目标的id)}
    MC_BATTLE_REWARD = 30026,             -- 战斗收获页面
    MC_BATTLE_REVIVE = 30027,             -- 战斗复活页面
    MC_BATTLE_CHECKPIONT = 30028,         -- 存档点动画 弃用
    MC_BATTLE_IN_CAVE_SHOP = 30029,       -- 显示洞穴商店
    MC_BATTLE_IN_CAVE_ENCHANTMENT = 30030,     -- 显示洞穴附魔
    MC_BATTLE_IN_CAVE_GOLDPOINTING = 30031,    -- 显示洞穴点金
    MC_BATTLE_SHOW_SKILL_TARGE = 30032,        -- 技能选择对象
    MC_BATTLE_SUCCECD_USE_SKILL = 30033,       -- 点击地面，成功使用技能后再播放动画
    MC_BATTLE_SHOW_HELP_REVIVE = 30034,        -- 显示帮助复活按钮 {PK}
    MC_BATTLE_HELP_REVIVE = 30035,                      -- 帮助复活 弃用
    MC_BATTLE_SUCCECD_USE_SKILL_NO_CLICK = 30036,       -- 成功使用技能后的消息 弃用
    MC_BATTLE_REVIVE_END = 30037,                       -- 复活完成
    MC_BATTLE_USED_TOTOWN_CONFIRM = 30038,              -- 确定使用回城卷轴后的消息
    MC_BATTLE_SUCCECD_USE_IRONPICKAXE_CLICK = 30039,    -- 成功使用铁锹道具后的消息
    MC_BATTLE_REVIVE_START = 30040,                     -- 复活开始
    MC_BATTLE_POSITION_SYNC = 30041,                    -- 同步坐标
    MC_BATTLE_BLIND_CHANGE = 30042,                     -- 致盲改变 isBlind
    MC_BATTLE_REVERSE_CHANGE = 30043,                   -- 反转改变 reverse
    MC_BATTLE_MOVE_HALF = 30044,                        -- 移动到一格中间
    MC_BATTLE_BLIND_CHANGE_DENSE_FOG = 30045,           -- 迷雾致盲，只是客户端模拟致盲改变
    MC_BATTLE_SUCCECD_USE_TWICE_SKILL = 30046,    -- 成功二次确认的技能

    MC_BATTLE_REMOVE_BAG_PANEL = 30047,                 -- 移除背包界面
    -- MC_BATTLE_SKILL_TRIGGER_CHANGE = 30048,             -- 技能触发条件改变列表 {SkillUseCondition:SkillUseCondition}
    -- MC_BATTLE_SKILL_SPEND_CHANGE = 30049,               -- 技能花费改变
    MC_BATTLE_SKILL_REFRESH_ALL_CD = 30050,             -- 刷新技能冷却
    MC_BATTLE_REFRESH_BUFFER_KIND = 30051,              -- 刷新buffer 时效 格式： spriteID
    MC_BATTLE_SHOW_CHOICE_HERO = 30052,                 -- 显示选中英雄页面 格式：heroData
    MC_BATTLE_REVIVE_CONTINUE = 30053,                  -- 复活继续
    MC_BATTLE_LOOKS_CHANGE = 30054,                     -- 变形状态改变   格式：spriteID,looks
    MC_BATTLE_UPDATE_DUNGEON_COUNT_DOWN = 30055,        -- 更新大秘境倒计时
    MC_BATTLE_DUNGEON_END_REWARD_LAYER = 30056,               -- 大秘境结算界面
    MC_BATTLE_SKILL_RELATED_FLAG_CHANGE = 30057,        -- 技能相关标机 格式:spriteID,skillRelatedFlag
    MC_BATTLE_DUNGEON_END_REWARD_SHOW = 30058,          -- 大秘境结算 开宝箱
    MC_BATTLE_UPDATE_EQUIPMENT_SCORE = 30059,           -- 处理更新装备评分
    MC_BATTLE_USE_SKILL_RESULT = 30060,                 -- 使用技能返回状态  skillID, result
    MC_BATTLE_HORCURX_TRANS_CHANGED = 30061,             -- 魂器变身

    MC_BATTLE_HERO_CONFUSE = 30062,                     -- 处理了蘑菇的迷惑效果
    MC_BATTLE_ADD_HERO = 30063,                         -- 添加玩家
    MC_BATTLE_REMOVE_HERO = 30064,                      -- 移除玩家
    MC_BATTLE_SKILL_START_COOLDOWN = 30065,             -- 技能开始冷却 数据格式:{skillID(技能id)}
    MC_BATTLE_ROLE_ANGER_CHANGED = 30066,               -- 角色anger属性变化
    MC_BATTLE_ROLE_HORN_NUMBER = 30067,                 -- 角色喇叭数量属性变化
    MC_BATTLE_REFRESH_SHADOW_LOCK = 30068,              -- 刷新阴影笼罩技能锁装套
    MC_BATTLE_REFRESH_SKILL_MARK_LOCK = 30069,          -- 刷新阴影笼罩技能锁装套
    MC_BATTLE_CHANGE_AUTO_BATTLE_TYPE = 30070,          -- 自动战斗模式切换
    MC_BATTLE_CHANGE_AUTO_BATTLE_STATUS = 30071,        -- 自动战斗状态切换

    MC_MAP_UPDATE_MAP_TILE = 30100,                     -- 更新地块
    MC_MAP_UPDATE_MAP = 30101,                          -- 更新地图
    MC_MAP_SEE_DEAD_PEOPLE = 30102,                     -- 显示战争迷雾

    MC_GOODS_BAG_GOODSDATA_REFRESH = 40001,   -- 背包某个具体物品数据变动 格式：goodsID
    MC_GOODS_BAG_EQUIPMENT_CHANGE = 40002,    -- 背包装备变动 格式：所有装备 table 
    MC_GOODS_BAG_ITEM_CHANGE = 40003,         -- 背包道具变动 格式：所有道具 table 
    MC_GOODS_BAG_MATERIAL_CHANGE = 40004,     -- 背包材料变动 格式：所有材料 table
    -- MC_GOODS_BAG_LOST = 40005,                -- 丢掉物品  格式：{GoodsData}
    MC_GOODS_BAG_ISFULL = 40006,              -- 背包满了，需要清理背包
    -- MC_GOODS_BAG_LOCK = 40007,                -- 锁定物品，格式： GoodsData
    -- MC_GOODS_BAG_UNLOCK = 40008,              -- 解除物品锁定，格式： GoodsData
    -- MC_GOODS_BAG_CLICK = 40009,               -- 背包点击，用于标志是否为新物品  格式： GoodsData
    MC_GOODS_BAG_PET_EQUIPMENT_CHANGE = 40010,    -- 背包宠物装备变动 格式：所有装备 table 
    MC_GOODS_WEAR_PET_EQUIPMENT_CHANGE = 40011,   -- 宠物穿戴装备变动
    MC_GOODS_WEAR_EQUIPMENT_CHANGE = 40101,   -- 穿戴装备发生改变  格式：{wearEquipmentArr(table)}
    MC_GOODS_NEW_TASK_UITAG = 40102,   -- 新任务的UI变化
    

    MC_GOODS_VIRTUAL_ITEM_CHANGE = 40103,     -- 虚拟物品发生改变 格式:物品,变化数量,旧数量
    MC_GOODS_UNLOCK_BAG          = 40104,     -- 解锁背包 
    MC_GOODS_UNLOCK_WAREHOUSE    = 40105,     -- 解锁仓库 
    
    MC_GOODS_LOCK_STATUS_CHANGE  = 40106,     -- 物品解锁状态改变 {packetType:PACKET_TYPE.PACKET_EQUIPMENT, entityID:1, templateID:1,isGolden:false,isLock:true}
    MC_GOODS_SELECT_SHORTCUT_EQUIP_CHANGE = 40107,-- 选中物品穿戴页码
    MC_GOODS_SELECT_SHORTCUT_BACK = 40108,        -- 请求切换穿戴页面返回
    MC_GOODS_WAREHOUSE_CHANGE    = 40109,     -- 仓库物品改变
    MC_GOODS_FULLBAG_INIT       = 40110,     -- 背包满物品初始化
    MC_GOODS_FULLBAG_INSERT     = 40111,     -- 增加背包满物品
    MC_GOODS_FULLBAG_REMOVE     = 40112,     -- 删除背包满物品
    MC_GOODS_SELL_GOODS_RESULT  = 40113,     -- 卖掉物品结果返回  格式:data  (成功:没有data, 错误:data)
    MC_GOODS_BAG_LOSE_RESULT    = 40114,     -- 丢掉物品返回 
    MC_GOODS_UNLOCK_RESPONSE    = 40115,     -- 解锁返回背包或仓库
    MC_GOODS_EQUIP_FAILED       = 40116,     -- 穿戴装备失败
    MC_GOODS_UN_EQUIP_FAILED    = 40117,     -- 脱掉装备失败
    MC_GOODS_CODE_DRAG_GOODS_TO_PACKET = 40118, -- 拖动物品到背包
    MC_GOODS_BAG_GEM_STONE_CHANGE = 40119,   -- 背包宝石变动 格式：所有宝石 table
    MC_GOODS_CLOSE_INFO_AREA = 40120,   -- 关闭宝石查看详情
    MC_GOODS_EQUIP_ILLUSION_UPDATED = 40121,  -- 装备幻化信息更新
    MC_GOODS_EQUIP_ILLUSION_WEAR_RESULT = 40122, -- 装备幻化替换结果
    MC_GOODS_EQUIP_NEW_ILLUSION = 40123,        -- 新装备幻化外观
    MC_GOODS_STAR_PRAY_CHANGE = 40124,        -- 占星仓库物品改变
    MC_GOODS_STAR_PRAY_WEAR_CHANGE = 40125,        -- 占星穿戴仓库物品改变
    MC_GOODS_BAG_RELIC_CHANGE = 40126,      -- 背包遗物变动
    MC_GOODS_BAG_TREASURE_CHANGE = 40127,   -- 背包宝藏变动
    MC_GOODS_BAG_GLYPH_CHANGE = 40128,   -- 装备雕文变动
    MC_GOODS_BAG_PET_GEM_STONE_CHANGE = 40129,   -- 魂玉变动

    MC_SHORTCUT_BAG_CHANGE = 50001,           -- 快捷栏背包数据改变（所有快捷栏能够使用的数据）   (是否去掉该消息)
    MC_SHORTCUT_BAG_REFRESH = 50002,          -- 快捷栏背包某个数据刷新     格式：指定刷新的ID
    MC_SHORTCUT_BAR_CHANGE = 50003,           -- 快捷栏改变（快捷栏上选择道具以及顺序）      格式：{}

    -- MC_SHORTCUT_BAR_ADD = 50004,              -- 快捷栏添加物品  格式：{index:1,ID:1000}
    -- MC_SHORTCUT_BAR_DELETE = 50005,           -- 快捷栏删除物品  格式：index 
    -- MC_SHORTCUT_BAR_SWITCH = 50006,           -- 快捷栏交换物品  格式：{oneIndex:1,twoIndex}

    MC_TIPS_SHOW_NEXT_FLOOR = 60001,          -- 显示进入下一层TIPS  格式：okCallBack(),cancelCallBack()
    MC_TIPS_SHOW_TRANS_DOOR = 60002,          -- 显示是否进入传送门的TIP 格式：okCallBack(),cancelCallBack()

    MC_STUDY_SKILL = 70001,                 -- 学习技能  格式：okCallBack(),cancelCallBack()
    MC_RESET_STUDY_SKILL = 70002,           -- 重置技能  格式：okCallBack(),cancelCallBack()
    MC_SKILL_ATTACK_MONSTER_HP_CHANGE = 70003,  -- 攻击怪物的血条改变  curHp,hp
    MC_CHANGE_SKILL_LV = 70004,             -- 改变学习的技能等级
    MC_SKILL_STUDY_RESULT = 70005,          -- 学习技能的结果返回
    MC_SKILL_ACTIVE_STUDY_RESULT = 70006,          -- 学习技能的结果返回
    MC_TREASURE_RECIVE_REWARD_RESULT = 70007,          --  藏宝图领取奖励
    MC_ACTIVITY_LUCKY_LOTTERY_RESULT = 70008,          --  通用幸运转盘抽奖
    MC_ACTIVITY_LUCKY_LOTTERY_REFRESH = 70009,         --  通用幸运转盘刷新
    MC_SKILL_SELECT_TYPE_CHANGED = 70010,         --  技能组选择切换
    MC_SKILL_SWITCH_GROUP = 70011,              --  切换单个技能
    MC_SKILL_SET_FIGHT_RESULT = 70012,         --  出战技能设置
    MC_ACTIVITY_FIGHT_BACK_RESULT = 70013,      --反斗大转盘抽奖

    MC_TEAM_SEARCH_MATCH = 80001,           --确认开始匹配
    MC_TEAM_NOTIFY_CANCEL_MATCH = 80002,    --取消匹配的通知
    MC_TEAM_RESPONSE_MATCH = 80003,         --匹配的响应
    MC_TEAM_COUNTDOWN_CANCEL_MATCH = 80004, --倒计时结束取消匹配
    MC_TEAM_UPDATE_ONLINE = 80005,          --改变队伍在线状态
    MC_TEAM_JOIN = 80006,                   --有人加入队伍
    MC_TEAM_LEAVE = 80007,                  --有人退出队伍
    MC_TEAM_DISMISS_TEAM = 80008,           --解散队伍
    MC_TEAM_CLINE_NOTIFY_CANCEL_MATCH = 80009,    --客户端取消匹配的通知
    MC_TEAM_ALL_CONFIRM = 80010,    --所有人都准备
    MC_TEAM_CAPTAIN_CHANGE = 80011,    --队长改变
    MC_TEAM_REFRESH_TEAM_VIEW = 80012,    --未知错误  需要重新点亮相关按钮

    MC_TASK_REFRESH_ALL_TASK = 81000,        -- 刷新整个任务页面
    MC_TASK_DELETE_TASK = 81001,            -- 删除任务  taskID
    MC_TASK_ADD_TASK = 81002,               -- 添加任务  taskData
    MC_TASK_COMPLETE_TASK = 81003,          -- 完成任务  自定义结构，详情 TaskDataManager:handleCompleteTaskResponse 函数里面
    MC_TASK_CHANGE_TASK = 81004,            -- 任务进度改变 taskData
    MC_TASK_SHOW_TASK = 81005,              -- 显示任务页面

    MC_TOWN_SHOW_LEVEL_SELECT = 81006,      -- 显示关卡选择
    MC_TASK_SHOW_MAILLAYER = 81007,        -- 邮箱
    MC_LEVEL_SELECT_ENTER_CAVE = 81008,     -- 进入洞穴
    MC_TASK_CLOSE_MAILLAYER = 81009,        -- 关闭邮箱
    MC_TASK_COLLECT_RESULT = 81010,         -- 搜集任务返回结果
    MC_TASK_REFREH_RESULT = 81011,          -- 刷新任务返回结果
    MC_LEVEL_SELECT_UNLOCK_BTN = 810012,    -- 解锁按钮
    MC_TOWN_SHOW_SPACE_LEVEL_SELECT = 810013,    -- 显示扭曲关卡选择
    MC_FEASTIVAL_SETTING_SKILL = 810014,    -- 活动设置技能
    MC_ENTER_AUTO_FIGHT_SCENE = 810015,          -- 进去有自动战斗的场景触发
    MC_TOWN_SHOW_INFERNO_LEVEL_SELECT = 810016,    -- 显示深红炼狱关卡选择

    MC_RANK_LIST = 82001,                   -- 排行榜数据
    MC_RANK_HERO_INFO = 82002,              -- 排行榜玩家数据
    MC_RANK_GUILD_RANK = 82003,             -- 公会排行榜
    MC_RANK_DUNGEON_SEASON_RANKING = 82004,             -- 大秘境赛季排行榜当前名次
    MC_RANK_DUNGEON_SEASON_TO_REWARD = 82005,             -- 获取 大秘境赛季排行榜当前名次 去判断大秘境赛季的奖励 是否导致背包满
    MC_CAVE_HREO_DATA_REFRESH = 82006,             -- 英雄模式刷新 （包括 特殊时间， 倒计时时间， 剩余次数）

    -- 遗物
    MC_RELIC_BAG_SLOTDRAG = 83001,          -- 拖拽检测背包
    MC_RELIC_EQUIP_SLOTDRAG = 83002,          -- 拖拽检测遗物装备栏
    MC_RELIC_STRENGTH_RESULT = 83003,          -- 遗物强化结果

    MC_UI_SHOW_MAINLAYER = 90001,           --显示主界面
    MC_UI_HIDE_MAINLAYER = 90002,           --隐藏主界面
    MC_DEBUG_LOG = 90005,                   --添加消息
    MC_UI_SHOW_STRENGTHEN = 90003,     -- 显示强化界面
    MC_UI_SHOW_REMOULD = 90004,    -- 显示改造界面
    MC_UI_CLOSE_ALL_ACTIVITY = 90005,    -- 关闭所有活动界面
    MC_UI_SHOW_RESOLVE = 90006,    -- 显示分解界面
    MC_UI_SHOW_FORGE = 90007,    -- 显示锻造界面
    MC_UI_SHOW_BEAUTYSALON = 90008,   -- 显示捏脸界面
    MC_UI_SHOW_CATFOOD = 90009,   -- 显示猫饭界面
    MC_UI_SHOW_WAREHOUSE = 90010,   -- 显示仓库界面
    MC_UI_SHOW_LUCKDROP = 90011, --显示抽奖界面
    MC_UI_HIDE_CHOICE_HERO = 90012,  -- 隐藏显示英雄
    MC_UI_SHOW_CHOICE_HERO = 90013,  -- 显示选择英雄
    MC_UI_SHOW_PET_STRENGTHEN = 90014, --  宠物强化界面

    MC_UI_SHOW_ENDLESS_SPACE = 90015,--显示大秘境入口界面
    MC_UI_FULL_ATOMOSPHERE = 90016,  --全屏遮罩效果
    MC_UI_SHOW_EXPRESSION = 90017,--显示快捷表情栏

    MC_UI_SHOW_RANKING = 90018,--显示排行榜
    MC_UI_SHOW_GUILD_TECH = 90019,--显示工会科技
    MC_UI_SHOW_HERO_HEAD_TIPS = 90020, -- 显示查看角色消息
    MC_UI_SHOW_GUILD_MANAGER = 90021,          -- 显示管理公会
    MC_UI_SHOW_GUILD_CREATE_OR_JOIN = 90022,   -- 显示创建加入公会
    MC_UI_SHOW_GUILD_TASK = 90023,             -- 显示公会

    MC_UI_SHOW_LUCKDROP_REFRESH = 90024, -- 刷新抽奖界面内容

    MC_UI_SHOW_LEVEL_SELECT_TEAM = 90025, -- 队伍选择界面

    MC_UI_SHOW_UNLOCK = 90026, -- 解锁动画
    MC_UI_SHOW_ACTIVITY_PANEL = 90027,   -- 显示活动列表
    MC_UI_SHOW_ACTIVITY_PANEL_BACK = 90029,     -- 恢复活动列表显示
    MC_UI_ACTIVITY_REFRESH = 90030,             -- 活动数据变动了
    MC_UI_ROLE_HP_DANGEROUS = 90031,            -- 角色血量是否处于危险状态 参数：是否处于危险阶段
    MC_UI_ROLE_DUNGEON_SURVIVOR = 90032,        -- 角色营救的人数改变 参数：当前营救人数
    MC_UI_FULL_SPECIAL_EVENT_DEFORMATION = 90033,  -- 特殊事件变型
    MC_UI_BACK_TOWN_UI = 90034,                    -- 用于返回城镇的TIPS
    MC_UI_GUILD_GUILD_LIST_ERROR = 90035,            -- 请求公会列表失败
    MC_ACTIVITY_TEAM_FIGHT_ACTIVITY_SURE_REPONSE = 90035,            -- 副本组队响应确认请求
    MC_UI_TOWN_CLICK_ICON = 90036,        -- 点击icon按钮
    MC_ACTIVITY_FESTIVAL_TEAM_MEMBER_CHANGE = 90037,        -- 节日活动组队人员变化


    MC_UI_GUILD_GUILD_LIST = 91001,            -- 公会列表  {公会列表}
    MC_UI_GUILD_JOIN_SUCCESS = 91003,          -- 加入公会成功
    MC_UI_GUILD_CREATE_SUCCESS = 91004,        -- 创建公会成功
    MC_UI_CLOSE_ALL_CREATE_OR_JOIN_GUILD = 91005,  -- 关闭所有创建，加入公会界面

    MC_UI_GUILD_MODITY_NOTICE = 91006,         -- 修改公会公告
    MC_UI_GUILD_MODIFY_JOIN_AUDIT = 91007,     -- 修改公会加入审核
    MC_UI_GUILD_MODIFY_JOIN_EQUIP_SCORE_LMT = 91008, -- 修改公会装备积分限制
    MC_UI_GUILD_MODITY_GUILD_ICON = 91009,         -- 修改公会图标
    MC_UI_GUILD_MODITY_MEMBER_TITILE = 91010,      -- 修改公会成员职位

    MC_UI_GUILD_HAVE_JOIN_REQ = 91011,             -- 有申请加入请求
    MC_UI_GUILD_NO_JOIN_REQ = 91012,               -- 没有申请加入请求
    MC_UI_GUILD_JOIN_LIST_CHANGE = 91013,          -- 加入列表改变


    MC_UI_GUILD_MEMBER_DATE_UPDATE = 91014,        -- 公会成员数据更新
    MC_UI_GUILD_MEMBER_CHANGE = 91015,             -- 公会成员变化
    MC_UI_GUILD_QUIT_GUILD = 91016,                -- 退出公会
    MC_UI_GUILD_BUY_GUILD_ICON = 91017,            -- 购买公会图标
    MC_UI_GUILD_APPLY_RESULT = 91018,             -- 申请加入返回 guildID
    MC_UI_GUILD_APPLY_RESUME = 91019,              -- 申请被拒绝

    MC_UI_GUILD_STUDY_SKILL = 91021,            -- 学习公会技能
    MC_UI_REFRESH_FRIENDLAYER = 91022,            --  刷新好友界面
    MC_UI_GUILD_CONTIB_CHANGE = 91023,          -- 公会贡献度修改
    MC_UI_GUILD_INFO_UPDATE = 91024,            -- 公会信息改变
    MC_UI_MINI_SHOW_ICON = 91025,               -- 显示小地图icon 格式： true (添加or删除), {{x,y},{x,y}}
    MC_UI_GUILD_LOAD_GUILD_END = 91026,         -- 加载公会完成

    MC_UI_GUILD_CREATE_STATUS = 91027,          -- 创建公会状态， 参数：true 成功，false 失败
    MC_UI_GUILD_EXIT_FAILS = 91028,             -- 退出公会失败
    MC_UI_GUILD_TICK_MEMBER_FAILS = 91029,      -- 踢出成员失败

    MC_UI_BEAUTY_EDITE_NEAME_RESPONSE = 91030,  -- 编辑名字返回
    MC_UI_GUILD_REFRESH_END = 91031,            -- 公会刷新完成
    MC_UI_SHOW_BAG = 91032, --显示背包界面
    MC_UI_FRIEND_MAIN = 91033,            --  好友界面
    MC_UI_SHOW_IAPSHOP = 91034, --显示商城界面
    MC_UI_ESCAPE_FAILED = 91035,                -- 逃跑失败
    MC_UI_ESCAPE_CANCEL = 91036,                -- 取消逃跑
    MC_UI_GUILD_STUDY_SKILL_FAILS = 91037,      -- 学习技能失败
    MC_UI_GUILD_REFRESH_NAME = 91038,           -- 刷新公会名称
    MC_UI_REFRESH_SKILL_ISOPEN_STATUS = 91040,  -- 刷新技能是否打开状态  参数：技能ID
    MC_UI_OPEN_TITLE_SELECTOR = 91041,          -- 打开称号选择框
    MC_UI_REFRESH_ROLE_TALENT = 91042,          -- 刷新人物天赋
    MC_UI_DREAM_SELECT = 91043,          -- 梦境选关界面
    MC_UI_REFRESH_ALL_DREAM_INFO = 91044,            -- 刷新梦境界面所有boss
    MC_UI_REFRESH_SINGLE_DREAM_BUFF = 91045,            --  刷新梦境界面单个bossBUFF
    MC_UI_DREAM_SETTLEMENT = 91046,            --  梦境结束
    MC_UI_DREAM_GET_TASK = 91047,          -- 梦境领取任务界面
    MC_UI_DREAM_TASK_STATE = 91048,          -- 刷新梦境任务状态
    MC_UI_DELETE_BATCH_FRIEND_CALLBACK = 91049,  --批量删除好友返回
    MC_UI_SHOW_FUNCTION_PANEL = 91050,  --
    MC_UI_UPDATE_DECORETION_PROGRESS = 91051,  --更新装饰物进度
    MC_UI_GUILD_BOX_UPDATE_BOXVIEW = 91052, --公会宝箱信息更新(包含大宝箱更新)
    MC_UI_GUILD_BOX_UPDATE_GIANT_BOX_VIEW = 91053, --公会大宝箱信息更新
    MC_UI_GUILD_BOX_NEW_BOX_CHANGED = 91054, --公会宝箱有新宝箱到达, 显示红点和需要重新拉去数据	
    MC_UI_GUILD_BOX_UPDATE_BOX_LIST = 91058, --公会宝箱列表更新
    MC_UI_WORLDBOSS_SHOW_TOPBAR = 91055, --worldboss topbar 显示
    MC_UI_WORLDBOSS_HIDE_TOPBAR = 91056, --worldboss topbar 显示
    MC_UI_WORLDBOSS_SHOW_MINI_ROOM = 91057, --worldboss topbar 显示房间按钮
    MC_UI_WORLDBOSS_HIDE_MINI_ROOM = 91059, --worldboss topbar 隐藏房间按钮
    MC_UI_WORLDBOSS_BOSS_DEAD = 91060, --worldboss boss被击杀
    MC_UI_BIGMAP_SHOW = 91061,          --地图功能化显示
    MC_UI_BIGMAP_HIDE = 91062,         --地图功能化隐藏
    MC_UI_REFRESH_SPACE_HERO_FIGHT_COUNT = 91063,         --刷新扭曲空间英雄挑战的次数
    MC_UI_REFRESH_SPACE_WORLD_EVENT = 91064,         --刷新扭曲空间特殊事件
    MC_UI_REFRESH_FIRST_PASS = 91065,         --刷新首充奖励
    MC_UI_REFRESH_UNLOCK_CELL = 91066,        -- 刷新解锁的CELL
    MC_UI_SIDEBAR_CELL_CANCEL_CLICK = 91067,        -- 任务快捷栏队伍列表滑动时取消cell点击
    MC_UI_SIDEBAR_SHOW_HEAD_TIPS = 91068,        -- 任务快捷栏点击弹出队伍相关内容
    MC_UI_SIDEBAR_HIDE = 91069,        -- 隐藏任务快捷栏
    MC_UI_SIDEBAR_FOCUS_ON_TEAM_TAB = 91070,        -- 任务快捷栏显示组队tab
    MC_UI_SIDEBAR_ADD_BUFF_INFO = 91071,        -- 任务快捷栏添加buffinfo
    MC_UI_GUILD_WISHPOOL_UPDATE_DATA = 91072,        -- 公会许愿池数据更新
    MC_UI_GUILD_WISHPOOL_UPDATE_COUNT = 91073,        -- 公会许愿池许愿次数更新
    MC_UI_GUILD_WISHPOOL_UPDATE_TOTAL = 91074,        -- 公会许愿池许愿总次数更新
    MC_UI_GUILD_WISHPOOL_UPDATE_LIST = 91075,        -- 公会许愿池许愿列表更新
    MC_UI_DELAY_SHOW_HERO_DETAIL = 91076,        -- 延迟读取英雄数据
    MC_UI_SHOW_PET_INFO_TIP = 91077,        -- 显示宠物信息tip
    MC_UI_HIDE_PET_INFO_TIP = 91078,        -- 隐藏宠物信息tip
    MC_UI_SHOW_PET_BRIEF_INFO = 91079,        -- 显示宠物简要信息
    MC_UI_HIDE_PET_BRIEF_INFO = 91080,        -- 隐藏宠物简要信息
    MC_UI_PET_DRAG_PET_SLOT_END = 91081,        -- 拖拽宠物背包格子完毕信息
    MC_UI_PET_SHOW_RAISE_QUALITY_RET = 91082,    -- 突破成功展示
    MC_UI_PET_SELECT_CELL_UPDATE = 91083,    -- 宠物选择update
    MC_UI_PET_LEVELUP_OK = 91084,    -- 宠物吃经验丹Ok
    MC_UI_PET_REBORN_OK = 91085,    -- 宠物吃洗炼丹Ok
    MC_UI_PET_RANK_LIST = 91086,     -- 宠物排行
    MC_UI_PET_RAISE_QUALITY_OK = 91087,     -- 宠物吃资质丹ok
    MC_UI_PET_LEARN_SKILL_OK = 91088,     -- 宠物学习技能ok
    MC_UI_PET_READY_FIGHT_OK = 91089,     -- 宠物出战ok
    MC_UI_PET_RENAME_OK = 91090,     -- 宠物改名ok
    MC_UI_PET_COMPOSE_OK = 91091,     -- 宠物合成ok
    MC_UI_PET_REFINE_OK = 91092,     -- 宠物炼化ok
    MC_UI_PET_REMOVE = 91093,     -- 宠物删除实例
    MC_UI_PET_SORT_LIST = 91094,  -- 宠物列表重排
    MC_UI_PET_MAIN_VIEW_CENTERUP = 91095,  -- 宠物面板移动
    MC_UI_PET_MAIN_VIEW_CENTER = 91096,  -- 宠物面板居中
    MC_UI_PET_REFINE_SELECT = 91097, -- 宠物炼化技能选择
    MC_UI_PET_MAIN_TAB_INFO_SHOW = 91098,  -- 宠物面板tab跳转
    MC_UI_PET_REFRESH_HEAD_INFO = 91099,  -- 宠物储存血条刷新
    MC_UI_PET_BUY_REBORNITEM_OK = 91100,  -- 宠物洗炼丹购买成功
    MC_UI_CLOSE_ROLE_PANEL = 91101,  -- 技能书点击使用后关闭背包界面
    MC_UI_STOP_ONE_KEY_REBORN = 91102,  -- 停止连续洗炼
    MC_UI_CUSTOM_FLOAT_SWITCH = 91103,  -- 悬浮物画质自定义
    MC_UI_SFSIGN_CELL_CLICK = 91104,  -- 春节签到Cell click
    MC_UI_SFSIGN_SIGN_OK = 91105,  -- 春节签到更新
    MC_UI_SFSIGN_SCROLLING = 91106,  -- 春节签到日历滑动
    MC_UI_GUILD_CHANGE_TITLE_NAME = 91107,  -- 职级名称自定义修改
    MC_UI_GUILD_WRIT_CHANGE = 91108,  -- 公会令状刷新
    MC_UI_GUILD_TREASURE_CHANGE = 91109,  -- 公会宝藏刷新
    MC_UI_GUILD_AUCTION_INFO_UPDATE = 91110,  -- 公会拍卖主界面数据刷新
    MC_UI_GUILD_AUCTION_BUY_UPDATE = 91111,  -- 公会拍卖出价数据刷新
    MC_UI_GUILD_AUCTION_BUY_SYNC = 91112,  -- 公会拍卖其他人出价数据同步
    MC_UI_GUILD_AUCTION_LOG_UPDATE = 91113,  -- 公会拍卖记录数据刷新
    MC_UI_PET_INHERIT_OK = 91114,  -- 宠物继承完成
    MC_UI_SCENE_PAUSEORRESUME = 91115,  -- 场景暂停恢复
    MC_UI_PET_DRAG_PET_SLOT_BEGAIN = 91116, -- 拖拽宠物背包格子开始信息
    MC_UI_PET_DRAG_HIDE_SLOT_BEGAIN = 91117, -- 宠物背包屏蔽指定宠物显示
    MC_UI_PET_CLEAR_REFINE_SELECT = 91118,   -- 清空单次炼化选中的宠物
    MC_UI_REFRESH_NEW_CITY_REDPOINT = 91119,   -- 刷新新主城的小红点
    MC_UI_REFRESH_INFERNO_FIGHT_COUNT = 91120, --刷新深红炼狱挑战的次数
    MC_UI_PET_WEAR_EQUIPMENT_RESULT = 91121,        -- 宠物装备穿戴结果
    MC_UI_PET_STRENGTHEN_EQUIPMENT_RESULT = 91122,  -- 宠物强化装备结果
    MC_UI_PET_DATA_REFRESH = 91123,                 -- 宠物数据刷新
    MC_UI_PET_SITE_UNLOCK_RESULT = 91124,           -- 兽栏解锁
    MC_UI_PET_SITE_UPGRADE_RESULT = 91125,          -- 兽栏升级
    MC_UI_PET_SITE_TAKE_OUT_RESULT = 91126,         -- 兽栏出战
    MC_UI_PET_REINCARNATION__OK = 91127,    -- 宠物等级上限突破Ok
    MC_UI_PET_BREAKLEVELUP_OK = 91128,    -- 宠物等级上限突破Ok
    MC_UI_BET_SHOW_OR_CLOSE = 91129,      -- 投注 topbar 显示

    MC_HAND_CLICK = 100001,  --头像点击
    MC_UI_HORCURX_ENERGE_UPDATE = 100002, --魂器能量更新

    MC_NPC_GOLD_POINTING = 110001,  --点金
    MC_NPC_ENCHANTMENT = 110002,  --附魔
    MC_NPC_STATUS_CHANGE = 110003, -- npc状态改变
    MC_NPC_REMODEL = 110004,  --改造
    MC_NPC_STRENGTHEN = 110005,  --强化
    MC_NPC_RESOLVE = 110006, -- 分解
    MC_NPC_FORGE = 110007, -- 锻造
    MC_NPC_CHANGE_FACE = 110008,        --换脸
    MC_NPC_CATFOOD = 110009,        -- 猫饭
    MC_TRIGER_TURNTABLE = 110010,        -- 转盘
    MC_NPC_BLACK_SHOP_ACTIVITY_REFRESH = 110011,     -- 黑商活动刷新
    MC_NOVICE_GUIDE_TRIGGER_TRAP = 110012,       -- 新手引导陷阱

    MC_NPC_GEM_SYNTHESIS = 110013; --宝石合成
    MC_NPC_GEM_INLAY = 110014; --宝石镶嵌
    MC_NPC_GEM_SHOP_BUY = 110015; --宝石购买
    MC_NPC_GEM_TRANSFORM = 110016; --宝石转换
    MC_NPC_RANDOM_SHOP_ACTIVITY_REFRESH = 110017,     -- 随机商店活动刷新
    MC_NPC_SKILL_ADVANCED = 110018; -- 技能进阶
    MC_NPC_REMODEL_FAIL = 110019,  --改造失败
    MC_NPC_DREAM_SHOP = 110020,  -- 梦境商店
    MC_NPC_GEM_CONVERT = 110021,  -- 装备转化
    MC_NPC_DREAM_SHOP_BUY = 110022,  -- 梦境商店购买
    MC_NPC_EQUIP_FORGE_UNLOCK = 110023,  -- 装备锻造解锁
    MC_NPC_EQUIP_FORGE = 110024,  -- 装备锻造
    MC_NPC_DREAM_VALUT_SHOP_BUY = 110025,  --梦境宝库购买
    MC_NPC_GEM_QUICK_SYNTHESIS = 110026; --宝石快速合成

    MC_PLOT_SHACK = 120001,                 --晃动
    MC_PLOT_STOP_SHACK = 120002,            --停止晃动
    MC_PLOT_WIDE_SCENE_SKIP = 120003,                  --跳过

    MC_PLOT_FULL_SCREEN_ADD = 120004,       -- 全屏效果添加
    MC_PLOT_FULL_SCREEN_REMOVE = 120005,    -- 全屏效果移除

    MC_PLOT_TOP_FULL_SCREEN_ADD = 120006,       -- 全屏顶层效果添加
    MC_PLOT_TOP_FULL_SCREEN_REMOVE = 120007,    -- 全屏顶层效果移除

    MC_CHAT_NEW_MESSAGE = 130001,       -- 聊天新消息
    MC_CHAT_REFRESH_TIPS = 130002,       -- 刷新聊天界面 提示语
    MC_CHAT_REFRESH_PM_SETTING = 130003,       -- 刷新聊天私信设置
    MC_CHAT_QUICK_CHAT_REFRESH = 130004,    -- 刷新快捷聊天显示
    MC_CHAT_OPEN_MAIN_CHAT = 130005,    -- 打开聊天主界面
    MC_CHAT_OPEN_MAIN_CHAT_WORLD_TAG = 130006,    -- 周年庆抽奖打开聊天主界面

    MC_DATA_GUILD_TECH = 140001,       -- 初始化工会科技
    MC_DATA_CHNAGE_GUILD_MEDAL = 140002,       -- 公会勋章改变
    MC_DATA_CHNAGE_GUILD_CONTRIB = 140003,       -- 公会贡献改变
    MC_DATA_GUILD_SKILL = 140004,       -- 初始化工会技能
    MC_DATA_GUILD_GUILD_TECH_RESULT = 140005,  --公会技能返回结果
    MC_COMMENT_END = 140006,     -- 游戏商店 评分结束
    MC_NPC_EQUIP_RECAST = 140007,     -- 装备重铸 网络返回

    MC_UI_SHOW_BIG_MAP = 150001,       --显示大地图
    MC_UI_HIDE_BIG_MAP = 150002,       --隐藏大地图
    MC_UI_SHOW_MINI_MAP = 150003,       --显示小地图
    MC_UI_HIDE_MINI_MAP = 150004,       --隐藏小地图
    MC_UI_OPEN_CONTROL_PAD = 150005,    --打开控制面板
    MC_UI_CLOSE_CONTROL_PAD = 150006,    --关闭控制面板
    MC_UI_CLOSE_BAG_BUTTON = 150007,                 -- 关闭背包按钮
    MC_UI_OPEN_BAG_BUTTON = 150008,                  -- 打开背包按钮
    MC_UI_SHOW_MAINUI_LAYER = 150009,           --显示主UI
    MC_UI_HIDE_MAINUI_LAYER = 150010,           --隐藏主UI
    MC_UI_REFRESH_NEW_FRIEND_FLAG = 150011,         --刷新好友红点
    MC_UI_ENABLE_ITEM_PANEL = 150012,           --启用快捷道具
    MC_UI_DISABLE_ITEM_PANEL = 150013,           --禁用快捷道具
    MC_UI_ENABLE_SKILL_PANEL = 150014,           --启用技能
    MC_UI_DISABLE_SKILL_PANEL = 150015,           --禁用技能

    MC_UI_ACHIEVEMENT_POINT_UPDATE = 150016,        -- 成就点数变更
    MC_UI_ACHIEVEMENT_RESULET = 150017,             -- 领取成就返回

    MC_UI_ACHIEVEMENT_REQ_GET_RESULET = 150018,     -- 通知界面领取成就

    MC_UI_LOGIN_BIND_FAILS_HASHERO = 150019,            -- 通知登录绑定失败
    MC_UI_FUNCTION_FLAG_CHANGE = 150020,            -- 通知功能标志改变，需要根据页面需求刷新相关表现 参数: spriteID
    MC_UI_FUNCTION_FLAG_CHANGE_FOR_SKILL = 150021,  -- 处理功能状态改变 参数:functionFlagType, value
    MC_UI_SKILL_REPLACE_SKILL = 150022,             -- 处理替换技能
    MC_UI_IS_HIDE_HELMET_UPDATE = 150023,           -- 是否隐藏头盔更新
    MC_UI_MINI_MAP_REFRESH_INFO_BTN = 150024,       --小地图 上 邮箱小提示  和 任务小提示的按钮状态刷新

    MC_UI_OPEN_CONTROL_PAD_TRACKING = 150025,    --如果检测列队都为开闭则关闭控制面板
    MC_UI_CLOSE_CONTROL_PAD_TRACKING = 150026,    --如果检测列队都为关闭则关闭控制面板
    MC_UI_CONTROL_PAD_TRACKING_CLEAR = 150027,    --清空跟踪列队

    MC_UI_ACTIVITY_REWARD_RESULT = 150028,          -- 领取奖励结果
    MC_UI_SETTING_CHANGE_TOWNCHANNEL = 150029,      -- f
    MC_UI_SETTING_SHOW_ACCOUNT_BIND = 150030,       -- 绑定账号
    MC_UI_CLEAR_DIRCTION_AND_START_MOVE_CONTROL_PAD = 150031,    --触发摇杆的上次的方向，并且尝试触发开始移动
    MC_UI_MINI_MAP_REFRESH_SPECIAL_EVENT = 150032,       -- 小地图上面的特殊事件
    MC_UI_REFRESH_DSP = 150033,                     -- 刷新DSP信息
    MC_UI_ACTIVITY_CLOSE = 150034,                   --关闭活动界面
    MC_UI_DREAM_CHIP_UPDATE = 150035,                --梦境碎片刷新
    MC_UI_REFRESH_ADVERT_STATUS = 150036,             --刷新所有广告信息
    MC_UI_REFRESH_BAG_NOTI_STATUS = 150037,           --刷新背包提示系统
    MC_UI_QUICK_SIDE_BAR_OFFSET_UPDATE = 150038,        -- 任务栏offset更新
    MC_UI_STATUS_CONSTRAINT = 150039,        -- 战斗中角色被束缚了
    MC_UI_OPEN_PETPVPEND = 150040,        -- 打开宠物PVP界面
    MC_UI_FUNCTION_FLAG_CHANGE_FOR_SKILL_PET = 150041,     -- 处理宠物功能状态改变 参数:functionFlagType, value
    MC_UI_CONTROL_HALF_BLACKLAYER = 150042,    --控制半透明UI蒙层 true：显示  fasle:隐藏

    MC_SETTING_BLOOD_SHOW_TYPE = 160001,    -- 血量显示规则
    MC_SETTING_LANGUAGE = 160002,    -- 切换多语言
    MC_UPDATE_BASIC_INFO = 160003,    -- basicinfoarea 界面数据刷新

    MC_ACHIEVEMENT_CHECK_NEW = 160003, -- 检查是否有新的成就
    MC_UI_LOGIN_BIND_SUCCESS = 160004, -- 绑定账号成功

    MC_UI_WEBVIEW_LAYER = 160005, -- 内置浏览器
   
    MC_UI_FUNCTION_UNLOCK = 160006, --系统解锁
    MC_UI_FUNCTION_REMOVE_NEW = 160007, --系统解锁 移除new动画
    MC_UI_SHOW_NPC_DIALOG = 160008, --npc 剧情对话
    MC_UI_SHOW_EXPLAIN = 160009, --新手引导说明
    MC_UI_SHOW_INDICATE_UI = 160010, --UI箭头
    MC_UI_SHOW_SKILL_POINT_RED_POINT = 160011, --红点 
    MC_UI_SHOW_FRAGMENT_DROP = 160012, --碎片掉落展示界面 
    MC_UI_SHOW_TASK_POINT_RED_POINT = 160013, --红点 
    MC_UI_SHOW_LOGIN_NOTICE = 160014, --登录公告界面
    MC_UI_REMOVE_INDICATE_UI = 160015, --UI箭头
    MC_UI_SHOW_TOEWN_NOTICE = 160016, --游戏内公告
    MC_SETTING_CONTROL_CHANGE = 1600017,    -- 控制方式更改
    MC_UI_CLOSE_FRAGMENT_DROP = 1600018,    -- 关闭得到宝藏图碎片的UI界面
    MC_UI_GEM_SYNTHESIS = 1600019,      -- 宝石合成界面
    MC_UI_GEM_INLAY = 1600020,          -- 宝石镶嵌界面
    MC_UI_GEM_BUY = 1600021,          -- 宝石购买界面
    MC_UI_GEM_TRANSFORM = 1600022,          -- 宝石转换界面
    MC_UI_SCRENN_SYSTEM_NOTICE = 1600023,   -- 屏幕系统提示，和系统提示不是同一个 参数:显示内容
    MC_UI_CONTROL_END = 1600024,            -- 结束摇杆
    MC_UI_CYCLE_TASK = 1600025,             -- 环形任务
    MC_UI_UPGRADE_SKILL = 1600026,          -- 进阶技能
    MC_UI_UPGRADE_INFO = 1600027,           -- 进阶技能详情
    MC_UI_SHOW_SETTINGS = 1600028,          -- 显示设置界面
    MC_UI_SHOW_ACTIVITY_RANK_DETAIL = 1600029,          -- 显示活动排行详情
    MC_UI_SHOW_DREAM_CHALLENGE = 1600030,          -- 显示梦境试验入口
    MC_UI_SHOW_EQUIP_CONVERT = 1600031,          -- 显示装备转换升级
    MC_UI_SHOW_DREAM_RANK = 1600032,          -- 显示梦境排行榜
    MC_UI_SHOW_DREAM_SHOP = 1600033,          -- 显示梦境商店
    MC_UI_FORCE_REMOVE_NPC_DIALOG = 1600034,  -- 强制关闭NPC对话框, 截断连续对话框
    MC_UI_DONG_KU_MI_ZHEN_READY = 1600035,  -- 洞窟迷阵准备
    MC_UI_BAG_PANEL_OPEN_SHARE = 1600036,  -- 打开背包界面上的展开分享按钮
    MC_UI_OPEN_BIG_MAP = 1600037,  -- 打开big map
    MC_UI_QUICK_EMOJI_CLOSE = 1600038, -- 快捷表情面板关闭
    MC_UI_REFRESH_GUILD_TEAM_BUF = 1600039, -- 刷新公会组队buf
    MC_UI_GEM_GEM_CONNECT = 1600040, --符文连接
    MC_UI_GEM_GEM_DECOMPOSE = 1600041, --符文分解

    MC_UI_SELECT_SERVER_SUCCESS = 170000, --选择服务器成功
    MC_UI_COMMON_REWARD = 170001,      --共用 获得物品界面 
    MC_UI_COMMON_REWARD_MAX_ZORDER = 170002, -- 获得物品界面(最高层级)

    MC_SDK_SHARE_SUCCESS = 180000, --分享成功
    MC_UI_SHOW_QUICK_CHAT_TIPS = 180001, --快捷聊天 消息
    MC_UI_LOSTREALM_ADD_COUNT = 180002,  -- 增加摇号次数
    MC_UI_LOSTREALM_OPERATE_RESULT = 180003,  -- 摇号结果
    MC_UI_LOSTREALM_ROLE_MOVE_END = 180004,  -- 角色移动完成

    -- 家园系统消息
    MC_UI_HOME_GOLDEN_MINE_SHOW_UI = 190000,            -- 打开金矿UI
    MC_UI_HOME_GOLDEN_MINE_UPDATE = 190001,             -- 更新金矿信息
    MC_UI_HOME_GOLDEN_MINE_OUTPUT_RECEIVED = 190002,    -- 获得金矿成功
    MC_UI_HOME_GOLDEN_MINE_LVUP = 190003,               -- 金矿升级成功
    MC_UI_HOME_GOLDEN_MINE_BOOST_START = 190004,        -- 金矿加速成功
    MC_UI_HOME_GEM_FACTORY_SHOW_UI = 191000,           -- 打开符文工房UI
    MC_UI_HOME_GEM_FACTORY_UPDATE = 191001,             -- 更新金矿信息
    MC_UI_HOME_GEM_FACTORY_OUTPUT_RECEIVED = 191002,    -- 获得金矿成功
    MC_UI_HOME_GEM_FACTORY_LVUP = 191003,               -- 金矿升级成功
    MC_UI_HOME_GEM_FACTORY_BOOST_START = 191004,        -- 金矿加速成功


    --可以从邮箱 跳转过去的界面 这里修改添加需要通知web同步相关信息（后面考虑直接移动到publicdefine里面来处理）
    MC_UI_JUMP_LAYER_MIN = 300000,
    MC_UI_JUMP_BAG = 300001,            -- 显示背包界面
    MC_UI_JUMP_FRIEND_MAIN = 300002,    -- 好友界面
    MC_UI_JUMP_IAPSHOP = 300003,        -- 显示商城界面
    MC_UI_JUMP_ACTIVITY_FESTIVAL = 300004, -- 节日活动
    MC_UI_JUMP_GUILD = 300005,          -- 跳转公会
    MC_UI_JUMP_ACTIVITY_POINT = 300006,          -- 跳转活跃度界面

    MC_UI_JUMP_LUCK_DROP =     300007, -- 转盘
    MC_UI_JUMP_LOTTERY =       300008, -- 幸运抽奖
    MC_UI_JUMP_MAIN_ACTIVITY = 300009, --运营活动列表
    MC_UI_JUMP_BATTLE_PASS =   300010, --通行证
    MC_UI_JUMP_STARPROY_SHOP = 300011, --占星抽奖
    MC_UI_JUMP_STARPROY_SWALLOW = 300012, --占星装备、吞噬
    MC_UI_JUMP_ENCHANTMENT =   300013, -- 装备附魔
    MC_UI_JUMP_EQUIP_STRENG =  300014, -- 铁匠装备强化
    MC_UI_JUMP_EQUIP_RESOLVE = 300015, -- 铁匠装备分解
    MC_UI_JUMP_EQUIP_REMOULD = 300016, -- 铁匠装备改造
    MC_UI_JUMP_EQUIP_FORGE =   300017, -- 铁匠装备锻造
    MC_UI_JUMP_HORCURX =       300018, -- 魂器
    MC_UI_JUMP_GUILD_INFO =    300019, -- 公会信息
    MC_UI_JUMP_SF_SIGN =       300020, -- 春节限定签到
    MC_UI_JUMP_IAP_GOLD_BOX =  300021,   -- 显示宝箱（内购页面的宝箱）
    MC_UI_JUMP_FESTIVAL_SIGN_VIEW =  300022,   -- 双节签到
    MC_UI_JUMP_FIGHT_BACK_SHOP = 300023, --反斗乐
    MC_UI_JUMP_LIMITED_FIGHT_BACK_SHOP = 300024, --限时反斗乐

    MC_UI_JUMP_LAYER_MAX = 310000,
    
    -- 过度动画相关
    MC_UI_TRANSITION_FADEIN = 320001,
    MC_UI_TRANSITION_FADEOUT = 320002,
    MC_UI_TRANSITION_CLEAR = 320003,
    MC_UI_TRANSITION_QUEUE_FUNC = 320004,
    MC_UI_TRANSITION_LOGIN_ANIMATION = 320005,
    MC_UI_TRANSITION_TWIRL_OUT = 320006,
    MC_UI_TRANSITION_RESET_LOGINBUTTON = 320007,
    MC_UI_TRANSITION_RUN_FOR_SCENARIO = 320008,

    --答题
     MC_UI_JUMP_LAYER_ANSWER = 321001,
     MC_UI_JUMP_LAYER_ANSWER_REP = 321002,
     MC_UI_ANSWER_IS_SHOWING = 321003,
     MC_UI_ANSWER_IS_CLOSED = 321004,
     MC_UI_COLSE_SKILL_TIP = 321005,
     MC_UI_HORCURX_INFO_UPDATE = 321006,
     MC_UI_HORCURX_JUMP_VIEW = 321007,
     MC_LITTLE_BOSS_SEAL_INFO = 321008,

     MC_HORCRUX_ENGERY_FULL = 321009,
     MC_HORCRUX_ENGERY_REFRESH = 321010,


    -- 内购商城相关
    MC_UI_REFRESH_PRODUCTS = 310100, -- 刷新商品信息显示
    MC_GET_ORDER_REQ = 310101,          -- 请求获取订单号
    MC_GET_ORDER_RESP      = 310102, -- 获取订单号返回
    MC_PURCHASE_SUCCESS     = 310103,-- 发货成功
    MC_REQ_PURCHASE_ERROR   = 310104, -- 请求购买失败
    MC_SDK_PURCHASE_SUCC   = 310105, -- 购买成功(appstore googleplay 第三方sdk)
    MC_SDK_PURCHASE_FAIL   = 310106, -- 购买成功(appstore googleplay 第三方sdk)
    MC_IAPSHOP_SHOW_DETAILS   = 310107,--显示商品详情
    MC_GET_ORDER_SHOWLOADING =  310108,--获取到订单号,通知界面弹出loading
    MC_GET_BOUGHT_RESP   = 310109,-- 获取已经购买的数量的返回
    MC_PRODUCT_NEED_REMOVE   = 310110,-- 开启倒计时的商品,在倒计时完毕之后需要删除
    MC_ON_TIPS_CLOSE_BUTTON = 310111,-- 购买之后获得物品弹出框确认按钮点击之后关闭商品详情界面
    MC_UI_SHOW_IAPSHOP_IN_REVIVE = 310112,-- 死亡购买钻石 显示商城
    MC_UPDATE_IAPSHOP_BOX_NUMS = 310113, -- 服务器通知有新宝箱上架
    MC_IPASHOP_CLOSE = 310114, -- 关闭商店
    MC_FIRST_RECHARGE_STATUS_CHANGED = 310115,      --首充状态更新消息
    MC_SUPPLY_STATUS_REFRESH = 310116,      --补给状态更新消息
    MC_UPDATE_IAPBOX_LAYER = 310117,      -- 刷新宝箱页面
    MC_REFRESH_IAPSHOP_NEW_FLAG = 310118,      -- 刷新宝箱是否有新的表现
    MC_ADV_GIFT_DATA_UPDATE = 310119,       -- 进阶礼包数据更新完毕，通知主界面再次刷新
    MC_IPASHOP_OPEN = 310120,             -- 内购界面打开了

    MC_SHOW_SEVEN_DAY = 330000,              -- 展示七日目标界面
    MC_REFRESH_SEVEN_DAY = 330001,           -- 更新七日目标界面
    MC_SEVEN_DAY_GET_REWARD = 330002,           -- 七日签到和七日计划领取奖励
    MC_SEVEN_DAY_TARGET_CHANGE = 330003,        -- 七日进度改变

    MC_NOVICE_GUIDE_FINISH = 400001,    --完成新手引导步骤
    MC_FINISH_PLOT = 400002,            --完成剧情事件
    MC_FINISH_NPC_DIALOG = 400003,      --完成npc对话框
    MC_FINISH_EXPLAIN = 400004,      --完成npc对话框

    MC_MAP_LOADED = 410001,

    MC_READ_USER_PROTOCOL_COMPLEATE = 410002,         -- 用户协议阅读完成

    MC_MONTH_CARD_STATUS_REFRESH = 410003,         -- 领取月卡通知

    MC_NOTICE_MESSAGE_TRAVEL = 410004,         -- 通知消息需要移动

    MC_MENTOR_MESSAGE_UPDATE_BUTTONS = 420000,         -- 通知更新师徒按钮
    MC_MENTOR_MESSAGE_UPDATE_REDPOINTS = 420001,         -- 通知更新师徒红点

    MC_REFRESH_NEW_DAY = 430003,         -- 新的一天

    MC_TRADE_ACTIVITY_UPDATE_TABLIST = 440001,         -- 缤纷活动刷新按钮

    ---------------------- 以下为一些特殊系统功能的值 -------------------------
    MC_RENDERER_PLOT_NOTICE = 800001,         -- 处理渲染的通知消息
    MC_DECORATION_HANDLE = 800002,            -- 处理对装饰物的控制处理

    

    ---------------------- 以下为不能修改值，是通过配置文件等来触发  ----------------------
    -- 剧情事件
    MC_PLOTEVENT_BOSSS1SKILL = 900001,     --第一个boss释放技能

    -- 新手引导类
    MC_STORY_REMOVE_NPC = 1000001,     --移除NPC
    MC_STORY_SHOW_HERO_REVIVE_DIALOG = 1000002,   --显示英雄复活对话

    -- 机器人相关
    MC_ROBOT_CONTROL_ENTER_SCENE = 9000001, -- 人物进入场景

    ---------------------- 以上为不能修改值，是通过配置文件等来触发  ----------------------


    MC_PICTURE_ALBUM = 2000001, --更新图册界面视图
    MC_FIGHT_BACK_SHOP = 2000002, --刷新反斗商店界面

    MC_CHANGE_KEY_CONFIG = 2000100, --按键设置修改
    MC_UI_SETTING_IS_OPEN = 2000101, --设置界面是否开启

    --虎年UI effect
    MC_UI_MINI_LAYER_TIGER_EFFECT = 2000200,

    -- Boss直达
    MC_BATTLE_BOSS_DIRECT = 2000210,
    MC_BATTLE_BOSS_DIRECT_UNLOCK = 2000211,
    MC_BATTLE_BOSS_DIRECT_CLOSEWIN = 2000212,

    --混动虫洞 选择阶段后刷新
    MC_UI_REFRESH_CHAOS_WORMHO = 2000300,

    --关闭钓鱼界面
    MC_CLOSE_FISHING_VIEW = 3000300,
    MC_CLOSE_FISHING_SUCCESS = 3000301,
    MC_CLOSE_FISHING_FAIL_FLEE = 3000302,
    MC_CLOSE_FISHING_BEGINE = 3000303,
    
    --关闭渔具界面
    MC_CLOSE_FISHING_GEAR_VIEW = 3000400,

    --打开渔具商店
    MC_OPEN_FISHING_GEAR_SHOP_VIEW = 3000410,
    MC_REFRESH_FISHING_GEAR_SHOP_MONEY = 3000411,

    -- 虚空秘境
    MC_ROLE_SWEEP_VOIDRIFT_RESPONSE = 3000501,     -- 显示虚空秘境扫荡结果
    MC_UI_REFRESH_VOIDRIFT_FIGHT_COUNT = 3000502, -- 刷新虚空秘境挑战的次数

    -- 维京时代
    MC_ROLE_SWEEP_VIKING_RESPONSE = 3000503,     -- 显示维京时代扫荡结果
    MC_UI_REFRESH_VIKING_FIGHT_COUNT = 3000504, -- 刷新维京时代挑战的次数

    -- 混沌虫洞
    MC_ROLE_SWEEP_CHAOS_RESPONSE = 3000505,     -- 显示混沌虫洞扫荡结果
    MC_UI_REFRESH_CHAOS_FIGHT_COUNT = 3000506, -- 刷新混沌虫洞挑战的次数

    -- IP归属刷新
    MC_UI_REFRESH_ROLE_IP = 3000600, -- IP归属刷新

    -- 船员上阵界面切换
    MC_UI_SEAMAN_LAYER_SWITCH = 3000601, -- IP归属刷新

    -- 建筑升级刷新
    MC_UI_REFRESH_BUILD_UPGRADE_VIEW = 3000602, -- 建筑升级刷新

    -- 改变外观刷新
    MC_UI_REFRESH_FACA_LAYER_VIEW = 3000603, -- 改变外观刷新
    -- 获得外观刷新
    MC_UI_REFRESH_GET_NEW_FACA_LAYER_VIEW = 3000604, -- 获得外观刷新

    -- 周年庆预约 全服奖励
    MC_UI_ACTIVITY_REFRESH_SERVER_REWARD_BTN = 3000605, -- 周年庆预约 全服奖励领取按钮刷新

    -- 三阶技能 技能页解锁
    MC_SKILL_BOUGHT_LABEL = 3000606,

    -- 试炼之地 首通奖励按钮刷新
    MC_TRIAL_LAND_REFRESH_GET_BTN = 3000607,

    -- 周年庆抽奖结果界面展示
    MC_UI_ACTIVITY_ANNIVERSARY_SHOW_LOTTERY_REWARD = 3000608,  
    -- 周年庆抽奖预览界面展示
    MC_UI_ACTIVITY_ANNIVERSARY_SHOW_LOTTERY_PREVIEW = 3000609,    

    MC_ROLE_UPDATE_GROUP_MONSTER_DATA = 3000700,  --群怪数据更新
    MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_DATA = 3000700,  --群怪切换目标数据更新
    MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_SWITCH_TIME = 3000701,  --群怪切换目标计时更新
    MC_ROLE_GROUP_MONSTER_SWITCH_BATTLE_UPDATE_TARGET = 3000702,  --群怪切换CELL targetID更新
    MC_UI_PET_ON_TALENT_POINT_UPDATE = 3000703,    -- 宠物资质加点界面刷新

    MC_UI_CAVE_SWITCH_CAVE_RESET_DATA = 3000704,         --切换副本刷新数据

    MC_ACTIVITY_CRYSTAL_CAPTURE_RESULT = 3000801,      --水晶夺宝

    MC_USE_MOLD_DRAGE_END = 3000802,      --请求使用模具
    MC_USE_MOLD_DRAGE_USE = 3000803,      --装备模具
    MC_USE_MOLD_REFRSH_BAG = 3000804,     --刷新模具背包
    MC_UI_SHOW_MOLD_FRAGMENT_DROP = 3000805,   --模具碎片掉落展示界面 

    -- 大航海
    MC_UI_PORT_SUPPLY = 3000900, --补充船只补给
    MC_UI_PORT_SYNC_BASE_DATA = 3000901, --同步港口个人基础数据到客户端
    MC_UI_PORT_SYNC_REFRESH_BOAT_INFO = 3000902, --刷新船只上的船员信息
    MC_UI_PORT_SYNC_REFRESH_BASE_BOAT_INFO = 3000903, --刷新model上基础信息
    MC_UI_PORT_TASK_RECEIVED = 3000904, --任务领取奖励
    MC_UI_PORT_SHOW_BOAT_INFO = 3000905, --展示船只信息
    MC_UI_PORT_REFRESH_ISLAND_BOATS_LIST = 3000906, --刷新岛屿船只列表
    MC_UI_PORT_REFRESH_ISLAND_GUILDS_LIST = 3000907, --刷新岛屿敌对公会列表
    MC_UI_PORT_REFRESH_DOCK_LIST = 3000908, --刷新船坞列表界面
    MC_UI_PORT_REFRESH_MARK_ISLAND = 3000909, --刷新公会标记的岛屿
    MC_UI_PORT_REFRESH_BIG_MAP = 3000910, --刷新大地图界面
    MC_UI_PORT_REFRESH_ENEMY_RANK = 3000911, --刷新敌对设置公会界面
    MC_UI_PORT_REFRESH_MATERAIL_DATA = 3000912, --刷新个人数据
    MC_UI_PORT_REFRESH_MAP_BOAT = 3000913, --取消占领刷新船只动画
    MC_UI_PORT_REFRESH_TASK_SHOW = 3000914, --刷新任务显示
    MC_UI_PORT_REFRESH_EVENT_RED_POINT = 3000915, --刷新事件红点
    MC_UI_PORT_SYNC_REFRESH_BAG_PETS = 3000916, --刷新船只上的船员信息
    MC_UI_PORT_SYNC_DISPATCH_SUCCESS = 3000917, --通知派遣成功消息
    MC_UI_PORT_SET_ENEMY_FAIL = 3000918, --敌对公会设置失败

    -- 改造继承
    MC_NPC_REMODEL_INHERIT = 3001000, -- 通知改造继承成功消息
    MC_NPC_REMODEL_INHERIT_REPLACE = 3001001, -- 通知改造继承替换成功消息

    -- 大航海岛怪
    MC_UI_PORT_MONSTER_FRESH_SUCCESS = 3001100, -- 刷新岛怪成功

    MC_UI_PET_CHANGE_SKIN_OK =  3001200,    --宠物换肤
    MC_UI_PET_SKIN_ATTR_DES =  3001201,    --宠物皮肤属性说明

    MC_CHANGE_MONSTER_PANNEL = 3001202,    --boss召唤怪时刷新状态UI

    -- 雕纹
    MC_NPC_GLYPH_REFINED_REFRESH = 3001300,    -- 洗练成功刷新显示
    MC_NPC_GLYPH_EQUIP_REFRESH = 3001301,    -- 雕纹镶嵌成功显示
    MC_NPC_GLYPH_REFINED_MANY_TIMES = 3001302,    -- 雕纹批量洗练通知

    MC_ROLE_GROUP_MONSTER_DEAD_AND_CLEAR_DATA = 3001303,  --分裂/召唤怪死亡后数据消失处理

    -- 紫升红
    MC_UI_PURPLE_UPGRADE_SUCCESS = 3001450,  --紫升红成功
    MC_UI_PURPLE_RESET_SUCCESS = 3001451,  --紫升红重置成功
}
GameMessage = Game.ClientMessage
AvalonMessage = Game.ClientMessage
-------------------------------
-- 常用的物品ID
Game.ConstGoods = {
    Coin = 23020001, --金币
    Diamond = 23030001, -- 钻石
    DreamIcon = 23110010, --梦境碎片
    RALLY_BET = 23510001, --竞猜币
}

Game.TableCellInitTime = 0.12
Game.TableCellAddTime = 0.014

Game.NpcDialog = {--和 ProfileClientDialogue 表 ID 字段 映射
    RemouldEquip = 100208,
}

Game.TeamType = {
    FromLevelSelect = 1,
    FromActivity = 2
}


--todo 做个多语言 富文本的缓存
Game.CELL_STATE = {
    NOMAL = 1, --正常模式
    DEL_AND_NO_SELECT = 2, --删除模式 下 未选中状态】
    DEL_AND_SELECTED = 3, --删除模式 下 选中状态
    BLOCK = 4, --删除黑名单模式
}
--特殊事件使用icon
Game.SpecialBoxImageName = {
    {normal = "ui_selectfloor_color_ordinary_01.png", open = "ui_selectfloor_color_ordinary_02.png", used = "ui_selectfloor_ash_ordinary_02.png"},
    {normal = "ui_selectfloor_color_gold_01.png", open = "ui_selectfloor_color_gold_02.png", used = "ui_selectfloor_ash_gold_02.png"},
    {normal = "ui_selectfloor_color_gemstone_01.png", open = "ui_selectfloor_color_gemstone_02.png", used = "ui_selectfloor_ash_gemstone_02.png"},
}
--公用获得界面 弹出动画
Game.RewardLayerOpenAction = {
    No_Action = 0,
    Scale_Center = 1, --屏幕中间 由小到大出现
    Move_Top2Center_Slow = 2, --从上到下缓慢出现
    Move_Top2Center_Normal = 3, --还未实现 ：从上到下正常出现
    Move_Left2Right_Slow = 4, --还未实现 ：从左到右缓出现
    Move_Left2Right_Normal = 4, --还未实现 ：从左到右正常出现
}

--[[1 左上 
2 右上 
3 左下 
4 右下]]
Game.SplashPos = {
    LeftUp = 1,
    RightUp = 2,
    LeftDown = 3,
    RightDown = 4,
}

Game.LevelSelectLayerType = {
    Normal_Plot = 1,--剧情选关
    Hero_Plot = 2,--剧情选关
    Dungeon     = 3,--大秘境
    Expedition  = 4,--探险队
    Desert_Eye  = 5,--沙之眼
    Distorted_Space     = 6,--扭曲空间   
    Inferno     = 7,    --深红炼狱
    Pet_Adventure = 8, --宠物探险
    VoidRift     = 9,    --虚空秘境
    ViKing      = 10,    --维京时代
    Titan_Road      = 11,    --泰坦之路
    Titan_Road_Hero      = 12,    --泰坦之路英雄
    Dried_Spring      = 13,    --干涸之泉
    Chaos_WormHole      = 14,    --混沌虫洞
}


Game.SkillIconState = {
    StateLock = 1, --未解锁
    StateCanLearn = 2, --解锁并且可学
    StateLearned = 3, --解锁并且已学
}

Game.SkillAdvanceType = {
    AdvanceTypeOne = 0, --一阶技能
    AdvanceTypeTwo = 2, --二阶技能
    AdvanceTypeThree = 3, --三阶技能
}


Game.AndroidPermission = {
    ACCEPT_HANDOVER = "android.permission.ACCEPT_HANDOVER",
    ACCESS_CHECKIN_PROPERTIES = "android.permission.ACCESS_CHECKIN_PROPERTIES",
    ACCESS_COARSE_LOCATION = "android.permission.ACCESS_COARSE_LOCATION",
    ACCESS_FINE_LOCATION = "android.permission.ACCESS_FINE_LOCATION",
    ACCESS_LOCATION_EXTRA_COMMANDS = "android.permission.ACCESS_LOCATION_EXTRA_COMMANDS",
    ACCESS_NETWORK_STATE = "android.permission.ACCESS_NETWORK_STATE",
    ACCESS_NOTIFICATION_POLICY = "android.permission.ACCESS_NOTIFICATION_POLICY",
    ACCESS_WIFI_STATE = "android.permission.ACCESS_WIFI_STATE",
    ACCOUNT_MANAGER = "android.permission.ACCOUNT_MANAGER",
    ADD_VOICEMAIL = "com.android.voicemail.permission.ADD_VOICEMAIL",
    ANSWER_PHONE_CALLS = "android.permission.ANSWER_PHONE_CALLS",
    BATTERY_STATS = "android.permission.BATTERY_STATS",
    BIND_ACCESSIBILITY_SERVICE = "android.permission.BIND_ACCESSIBILITY_SERVICE",
    BIND_APPWIDGET = "android.permission.BIND_APPWIDGET",
    BIND_AUTOFILL_SERVICE = "android.permission.BIND_AUTOFILL_SERVICE",
}

-------------------------------------以下为新的框架定义--------------------------------------

Game.ViewStyle = {
    ViewStyle_CenterWin = "CenterWin",
    ViewStyle_DoorWin = "DoorWin",
    ViewStyle_DownShowWin = "DownShowWin",
    ViewStyle_BaseWin = "BaseWin",
}


ViewStyle = Game.ViewStyle