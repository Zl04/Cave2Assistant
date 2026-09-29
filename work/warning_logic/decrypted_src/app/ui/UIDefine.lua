--[[
UI - 全局定义的常量
]]
UI = UI or {}

-- 屏幕尺寸
UI.size = cc.Director:getInstance():getWinSize()

UI.RewardType = {
    REWARD_NORMAL = 1,
    REWARD_DUNGEON = 2,
    REWARD_GUILD_BOSS = 3,
    REWARD_DEEPLINK = 4,
    REWARD_SWEEP = 5, -- 扫荡奖励
    REWARD_GHOSTABYSS= 6,  -- 幽灵深渊
    REWARD_TRIALLAND= 7,  -- 试炼之地
}

-- UI的类型
UI.Type = {
    -- touch处理层级
    TOUCH_LAYER = 1,
    -- 全屏
    FULL_SCREEN = 500,
    -- 默认的类型
    NORMAL = 501,
    -- 英雄1000开头
    -- 英雄血条
    HEROSTATUS = 1001,
    -- 队友血条
    TEAMMATESTATUS = 1002,
    --背包格子列表
    GOODS_GRID_LIST = 1003,
    -- 聊天
    CHAT = 1004,
    -- 公会查看玩家信息
    GUILD_CHOICE_HERO = 1005,
    -- 弹出框
    TIPS = 1006,
    -- 商店
    SHOP = 1007,
    -- 录屏按钮
    SCREEN_RECORD_BUTTON = 1008,
    -- 宠物血条
    PETSTATUS = 1009,
    -- 宠物未上阵
    PET_NULL = 10091,
    -- 兽栏未解锁
    PET_SITE_UNLOCK = 10092,
    --背包角色标签
    IAP_SHOP_FUNCTION_TAB_ITEM_DIAMOND = 2001,
    --背包任务标签
    IAP_SHOP_FUNCTION_TAB_ITEM_GIFT = 2002,
    --背包技能标签
    IAP_SHOP_FUNCTION_TAB_ITEM_GOLD = 2003,
    --背包满cell
    BAG_FULL_CELL = 8001,
    --背包满
    BAG_FULL_LAYER = 8002,
    --图鉴cell
    ARCHIVE_CELL = 8003,
    --图集
    ARCHIVE_LAYER = 8004,
    --图鉴进度条
    ARCHIVE_PRO_BAR = 8005,
    --背包格子列表
    BAG_GRID_LIST = 8006,
    --属性描述
    ATTRIBUTE_DES = 8007,
    --角色背包基础信息
    BAG_BASIC_INFO_AREA = 8008,
    --英雄详细属性信息
    DETAILED_INFO_AREA = 8009,
    --装备详情界面
    EQUIPMENT_INFO_AREA = 8010,
    --背包中的道具详情界面
    MATERIAL_INFO_AREA = 8011,
    --背包中的道具详情界面
    PROP_INFO_AREA = 8012,
    --趣味数据列表 cell
    FUNNY_RECORD_CELL = 8013,
    --日志界面——趣味数据（玩家自己的趣味数据）
    FUNNY_RECORD_LAYER = 8014,
    --背包中的日志
    LOG_LAYER = 8015,
    -- 背包中的日志面板
    BAG_LOG_PANEL = 8016,
    --背包中的角色功能面板
    ROLE_PANEL = 8017,
    --装备图标
    BAG_EQUIPMENT_ICON = 8018,
    --角色动画
    BAG_ROLE_ANIMATION = 8019,
    --角色展示区域
    BAG_ROLE_SHOW_AREA = 8020,
    --选择装备按钮
    SELECT_EQUIPMENT_BUTTON = 8021,
    --选择语言
    SELECT_LANGUAGE_LAYER = 8022,
    --选择服务器
    SELECT_SERVER_LAYER = 8023,
    -- 背包中设置面板
    BAG_SETTING_PANEL = 8024,
    --学习技能
    SKILL_LAYER = 8025,
    -- 成就UI
    ACHIEVEMENT_UI = 8026,
    -- 藏宝图UI
    TREASUREMAP_UI = 8027,
    --获取奖励的Tips
    LEAVE_TEAM_TIPS = 8028,
    --单个任务数据列表，由不同的TaskItemGrid组成
    TASK_AWARD_LIST = 8029,
    --任务界面的单个列表UI控件
    TASK_BAG_SINGLE_LIST = 8030,
    --背包中的任务界面
    TASK_LAYER = 8031,
    --任务界面
    TASK_LAYER_UI = 8032,
    --背包
    BAG_PANEL = 8033,
    -- 控制方向键
    CONTROLPAD = 8034,
    -- 洞内怪物信息
    MONSTER_BOX_LAYER = 8035,
    -- 战斗时怪物的血量
    MONSTER_PANEL = 8036,
    -- 复活视图
    REVIVE_VIEW = 8037,
    --技能按钮
    SKILL_BUTTON = 8038,
    -- 技能面板
    SKILL_PANEL = 8039,
    --捏脸
    BEAUTY_SALON_LAYER = 8040,
    --黑屏对话界面
    BLACKDIALOGUE = 8041,
    --黑市背包中的道具详情界面
    BLACK_SHOP_INFO_AREA = 8042,
    --黑市商人
    BLACK_SHOP_PANEL = 8043,
    -- 致盲效果
    BLIND = 8044,
    -- 猫饭UI
    CATFOOD_UI = 8045,
    -- 猫饭详情UI
    CATFOODINFO_UI = 8046,
    --战斗结算
    FIGHT_RESULT = 8047,
    --被踢出队伍，即将进入小黑屋
    KICKED_PANEL = 8048,
    -- 存档点
    CHECKPOINT = 8049,
    --创建角色
    CREATE_ROLE_LAYER = 8050,
    --大秘境入口界面
    ES_GUARD_LAYER = 8051,
    --大秘境 战斗结束 奖励界面
    DUNGEON_BATTLE_REWARD_LAYER = 8052,
    --梦境结算
    DREAM_RESULT_LAYER = 8180,
    --大秘境排行榜奖励界面
    ES_RANKREWARD_LAYER = 8053,
    --系统日志输出
    DEBUG_LOG_LAYER = 8054,
    --说明框
    EXPLAIN_LAYER = 8055,
    --附魔
    ENCHANTMENT_LAYER = 8056,
    --点金
    GOLD_POINTING_LAYER = 8057,
    -- 公会创建
    GUILD_CREATE_OR_JOIN = 8058,
    --用户选择公会图标
    CHOICE_GUILD_ICON_PANEL = 8059,
    --创建公会
    CREATE_GUILD = 8060,
    --加载效果
    LOADING_PANEL = 8061,
    --创建或加入公会
    GUILD_MANAGER_PANEL = 8062,
    --申请加入管理
    JOIN_APPLY_MANAGER_PANEL = 8063,
    --公会任务表现
    TASK_PANEL = 8064,
    --公会列表 cell
    GUILD_CELL = 8065,
    --公会列表 cell
    GUILD_MEMBER_CELL = 8066,
    --申请 cell
    JOIN_APPLY_CELL = 8067,
    --公会申请 cell
    GUILD_TASK_CELL = 8068,
    --公会图标列表 cell
    GUILD_ICON_CELL = 8069,
    --公会天赋界面
    GUILD_SKILL_LAYER = 8070,
    --公会科技界面
    GUILD_TECH_LAYER = 8071,
    --公会科技天赋界面
    GUILD_TECH_OR_SKILL_LAYER = 8072,
    --头像管理
    HERO_HAND_LAYER = 8073,
    --钻石商店
    IAP_SHOP_BOX_ITEM = 8074,
    --钻石商店
    IAP_SHOP_BOX_LAYER = 8075,
    --钻石商店
    IAP_SHOP_DIAMOND_ITEM = 8076,
    --内购商城界面内的砖石购买界面
    IAP_SHOP_DIAMOND_LAYER = 8077,
    --内购商店主界面
    Iap_Shop_Main_Layer = 8078,
    --UI指示箭头
    INDICATE_UI_LAYER = 8079,
    -- 掉落
    ITEMDROPINFO = 8080,
    -- 快捷物品栏
    ITEMPANEL = 8081,
    -- 使用辅助技能ui
    USE_SKILL_UI = 8082,
    -- 铁锹使用ui
    USE_SPADE_UI = 8083,
    --抽奖转盘UI
    LUCKDROP = 8084,
    --邮箱滑动banner
    BANNER_LAYER = 8085,
    --邮件列表 cell
    MAIL_CELL = 8086,
    --邮箱主界面
    MAIL_LAYER = 8087,
    -- 大地图
    BIG_MAP = 8088,
    -- 地图视图
    MAP_VIEW = 8089,
    -- 小地图
    MINI_MAP = 8090,
    --游戏性能信息
    PERFORMANCE_INFO_AREA = 8091,
    --排行榜cell
    RANKING_CELL = 8092,
    --排行榜
    RANKING_LAYER = 8093,
    --排行榜进度条
    RANKING_PRO_BAR = 8094,
    --排行榜种类cell
    RANKING_TYPE_CELL = 8095,
    --改造
    REMOULD_LAYER = 8096,
    --锻造UI
    FORGE_LAYER = 8097,
    --分解UI
    RESOLVE_LAYER = 8098,
    -- 屏蔽层
    SHIELDING_LAYER = 8099,
    --物品组件
    BAG_GOODS_PANEL = 8100,
    --洞穴商店
    CAVE_SHOP_PANEL = 8101,
    --对话框界面
    CHAT_DIALOG_LAYER = 8102,
    --聊天主界面
    CHAT_MAIN = 8103,
    --快捷聊天界面
    CHAT_QUICK_LAYER = 8104,
    --私聊选取玩家界面
    CHAT_SELECT_PLAYER = 8105,
    --好友列表 cell
    FRIEND_MEMBER_CELL = 8106,
    --好友界面
    FRIEND_MAIN = 8107,
    --快捷表情界面
    QUICK_EXPRESSION_LAYER = 8108,
    --强化
    STRENGTHEN_LAYER = 8109,
    --查看角色信息的底部区域信息 攻击强度、法力效果、坚韧
    BASE_INFO = 8110,
    --查看角色信息的中间区域信息 SPINE动画等
    BASE_M_INFO = 8111,
    --查看人物信息中的装备详情界面
    EQUIPMENT_INFO = 8112,
    --查看队友信息的UI
    VIEW_FRIEND_INFO = 8113,
    --队伍踢人的投票成功UI
    VOTE_SUCCEED_TIPS = 8114,
    --下拉框 实现
    DROP_DOWN_LIST = 8115,
    --测试页面
    TEST_PANEL = 8116,
    --测试工具
    TEST_UTIL_LAYER = 8117,
    --购买物品数量的TIPS
    BUY_AMOUNT_TIPS = 8118,
    -- 商店层的TIPS
    BUY_GOODS_TIPS = 8119,
    --砖石不够的TIPS
    DIAMOND_NOT_ENOUGHTIPS = 8120,
    --黄金不够的TIPS
    GOLD_NOT_ENOUGH_TIPS = 8121,
    --砖石不够的TIPS
    MA_SONRY_NOT_ENOUGH_TIPS = 8122,
    --出售装备的TIPS
    SALES_EQUIPMENT_TIPS = 8123,
    --购买公会图标
    BUY_GUILD_ICON_TIPS = 8124,
    -- 公共TIPS 表现
    COMMON_TIPS = 8125,
    --创建公会成功界面
    CREATE_GUILD_SUCCESS_TIPS = 8126,
    -- 下楼
    DOWNSTAIRS_UI = 8127,
    --兑换码
    EXCHANGE_TIPS = 8128,
    --加入公会成功界面
    JOIN_GUILD_SUCCESS_TIPS = 8129,
    --跳转 评论提示框
    JUMP_TO_COMMENT_TIPS = 8130,
    --tips界面
    TIPS_LAYER = 8131,
    --关卡选择
    LEVEL_SELECT = 8132,
    --关卡准备界面邀请成员
    LEVEL_SELECT_ADD_TEAM_ROLE = 8133,
    --关卡准备界面邀请成员 cell
    LEVEL_SELECT_ADD_TEAM_ROLE_CELL = 8134,
    --关卡难度选择
    LEVEL_SELECT_DIFFICULTY = 8135,
    --匹配中
    LEVEL_SELECT_READY = 8136,
    --关卡准备界面
    LEVEL_SELECT_TEAM = 8137,
    -- 选择英雄
    CHOICE_HERO = 8138,
    --简化版仓库组件
    WAREHOUSE_GOODS_PANEL = 8139,
    --仓库
    WAREHOUSE_LAYER = 8140,
    --内置浏览器
    WEB_VIEW_LAYER = 8141,
    --宽屏
    WIDE_SCREEN_LAYER = 8142,
    --窗口主界面
    ACTIVITY_LAYER = 8143,
    --主界面UI窗口
    MAIN_UI_LAYER = 8144,
    --顶层窗口界面
    TOP_ACTIVITY_LAYER = 8145,
    UNLOCK_LAYER = 8146,
    --登陆公告
    LOGIN_NOTICE = 8147,
    --城镇公告
    TOWN_NOTICE = 8148,
    -- 下楼表现效果
    DOWNSTAIRS = 8149,
    --关卡准备界面
    LEVEL_SELECT_MUTIPLAYER_BTN = 8150,
    --宝石合成
    EQUIP_GEM_SYNTHESIS = 8151,
    -- 宝石镶嵌
    EQUIP_GEM_INLAY = 8152,
    -- 背包中的宝石详情界面
    GEM_STONE_INFO_AREA = 8153,
    --宝石购买
    EQUIP_GEM_BUY = 8154,
    --月卡购买
    IAP_SHOP_MONTH_CARD_LAYER = 8155,
    --黑市商人
    RANDOM_SHOP_PANEL = 8156,
    -- 按钮
    SWITCH_BUTTON = 8157,
    --绑定账号
    BIND_ACCOUNT_TIPS = 8158,
    --设置返回
    SETTING_BACK_TOWN_TIPS = 8159,
    -- 金矿
    GOLDEN_MINE = 8160,
    -- 符文工房
    GEM_FACTORY = 8161,
    -- 金矿
    GOLDEN_MINE_INFO = 8162,
    -- 金矿
    GOLDEN_MINE_LVUP = 8163,
    -- 金矿
    GOLDEN_MINE_BOOST = 8164,
    -- 符文工房
    GEM_FACTORY_INFO = 8165,
    -- 符文工房
    GEM_FACTORY_LVUP = 8166,
    -- 符文工房
    GEM_FACTORY_BOOST = 8167,
    -- 环形任务界面
    CYCLE_TASK_LAYER = 8168,
    -- 人物天赋界面
    ROLE_TALENT_LAYER = 8169,
    -- 设置窗口基础设置
    SETTINGS_BASIC_PANEL = 8170,
    -- 设置窗口高级设置
    SETTINGS_ADVANCED_PANEL = 8171,
    -- 设置窗口社区设置
    SETTINGS_COMMUNITY_PANEL = 8172,
    -- 设置按钮
    SETTINGS_BUTTON = 8173,
    -- 设置界面基础设置TAB
    SETTINGS_BASIC_TAB = 8174,
    -- 设置界面基础设置TAB
    SETTINGS_ADVANCED_TAB = 8175,
    -- 设置界面基础设置TAB
    SETTINGS_COMMUNITY_TAB = 8176,
    -- 装备幻化界面
    EQUIP_ILLUSION_LAYER = 8177,
    -- 技能进阶
    TYPE_SKILL_ADVANCED = 8178,
    -- 技能进阶详情
    TYPE_SKILL_ADVANCED_DETAIL = 8179,
    -- 梦境排行榜
    DREAM_RANK_LAYER = 8180,
    DREAM_RANK_TIP_LAYER = 8181,
    -- 梦境商店
    DREAM_SHOP_LAYER = 8182,
    DREAM_SHOP_CONFIRM_LAYER = 8183,
    -- 装备转换
    EQUIPMEN_COVER = 8184,
    -- 梦境选关
    DREAM_SELECT = 8185,
    -- 装备锻造界面
    EQUIP_FORGE_LAYER = 8186,
    -- 装备锻造成功界面
    EQUIP_FORGE_SUC_LAYER = 8187,
    -- 集换确认
    EXCHANGE_CONFIRM = 8188,
    --魂器
    HORCURX_LAYER = 8189,
    --装备重铸界面
    EQUIPMENT_RECAST = 8190,
    --超值礼包界面
    EXTRA_GIFT = 8191,
    --进阶礼包界面
    ADV_GIFT = 8192,
    -- 探险队
    EXPEDITION = 8193,
    -- 公会商店
    GUILD_SHOP = 8194,
    -- 快捷物品栏
    ITEMPANEL_EXPAND_BUTTON = 8195,
    -- 扭曲空间选关界面
    LEVEL_SELECT_SPACE = 8196,
    -- 沙之眼选关界面
    LEVEL_SELECT_EYE = 8197,
    --装备重铸移除等级
    EQUIPMENT_RECAST_REMOVE_LEVEL = 8198,
    -- battle pass
    BATTLE_PASS = 8199,
    -- 设置界面图像设置TAB
    SETTINGS_HQ_TAB = 8200,
    -- 快捷emoji
    QUICK_EMOJI_LAYER = 8201,
    -- 公会拍卖行
    GUILD_AUCTION = 8202,
    --公会拍卖进货
    GUILD_AUCTION_STOCK = 8203,
    --自动战斗按钮
    MAIN_UID_AUTO_BUTTON = 8204,
    -- 自动战斗切换战斗模式
    MAIN_UID_AUTOBTN_CHANGE_TYPE = 8205,
    -- functionPanel
    MAIN_UI_FUNCTIPN_PANEL_TYPE = 8206,
    -- 神迹祈福
    MAIN_UI_MIRACLE = 8207,
    --宝石转换
    EQUIP_GEM_TRANSFORM = 8208,
    --大富翁UI
    MAIN_UI_LOSTREALM = 8209,
    --扭曲空间和后扭曲空间的选择
    MAIN_UI_DISTORTEDSPACE_TYPESELECT = 8210,
    -- 后扭曲空间 深红炼狱
    MAIN_UI_INFERNO = 8211,
    -- 佣兵列表
    MERCENARY_LIST_VIEW = 8212,
    --宠物装备详情界面
    EQUIPMENT_PET_INFO_AREA = 8213,
    --宠物装备强化
    PET_STRENGTHEN_LAYER = 8214,
    --按键设置
    SETTINGS_KEY_CONFIG_TAB = 8215,
    --好友头像
    CHOICE_FRIEND_HERO = 8216,
    --背包中的雕文详情界面
    GLYPH_INFO_AREA = 8217,
    -- 按钮
    BUTTON = 9001,
    -- 列表控件
    LIST_VIEW = 9002,
    LIST_GRID = 9003,
    -- 布局控件
    LAYOUT = 9004,
    -- tab
    TAB_LIST = 9005,
    TAB_ITEM = 9006,
    -- 文本
    TEXT = 9007,
    -- 图片
    IMAGE = 9008,
    -- 动画
    ANIMATION = 9009,
    -- 进度条
    PROGERSSTIMER = 9010,
    -- 左边文本，右边为值
    TEXTVALUE = 9011,
    IMAGETEXT = 9012,
    -- 剪切节点
    CLIPPING_NODE = 9013,
    -- 滚动视图
    SCROLL_VIEW = 9014,
    -- 滑块
    SLIDER = 9015,
    -- 输入框
    EDITBOX = 9016,
    -- 信息滚动提示条
    SCROLL_BAR = 9017,
    TEST_BAR = 9018,
    --富文本
    RICH_TEXT = 9019,
    -- loadingLayer
    LOADING = 9020,
    --登录主界面scene
    MAIN_LAYER = 9021,
    -- 物品列表
    GOODS_LIST = 9022,
    -- 公用格子列表
    GRID_LIST = 9023,
    -- 图片按钮
    IMAGE_BUTTON = 9024,
    -- 功能NPC 按钮层
    FUNCTION_NPC = 9025,
    --背包按钮
    BAG_BUTTON = 9026,
    --背包角色标签
    FUNCTION_TAB_ITEM_ROLE = 9027,
    --背包任务标签
    FUNCTION_TAB_ITEM_TASK = 9028,
    --背包技能标签
    FUNCTION_TAB_ITEM_SKILL = 9029,
    --背包日志标签
    FUNCTION_TAB_ITEM_LOG = 9030,
    --背包设置标签
    FUNCTION_TAB_ITEM_TALENT = 9031,
    -- 按钮扩展
    BUTTON_EXT = 9032,
    -- 地图的功能按钮
    FUNCTION_MAP = 9033,
    GREEDY_SELECT = 9034,
    -- 小红点
    RED_POINT = 9035,
    -- 深红炼狱select
    INFERNO_SELECT = 9036,
    --画册标签
    FUNCTION_TAB_PICTURE_ALBUM = 9037,
    --画册
    FUNCTION_TAB_PICTURE_ALBUM_LAYER = 9038,
    --适龄界面
    AGE_REMINDER = 9039,
    -- 运营活动
    ACTIVITY = 9050,
    -- 运营活动详情
    ACTIVITY_DETAIL = 9051,
    ACTIVTIY_DETAIL_EXTRA_DROP = 9052,
    ACTIVITY_DETAIL_QUEST_CONDITION = 9053,
    --告示板
    TOWN_TASK_LAYER_UI = 9054,
    --背包提示
    BAG_NOTIFICATION = 9055,
    --装备精良
    EQUIP_REFINE = 9056,
    --装备转换
    EQUIP_TRANS = 9057,
    ACTIVITY_DETAIL_GUILD_QUEST_CONDITION = 9058,
    ACTIVITY_DETAIL_CAVE = 9059,
    ACTIVITY_DETAIL_EXCHANGE = 9060,
    SEVEN_DAY = 9061,
    USER_PROTOCOL_DIALOG = 9100,
    ENTER_CAVE_LAYER = 9101,
    IMAGE_9 = 9102,
    CONFIRM_DIALOG = 9103,
    ANSWER_LAYER_UI = 9104,
    --星痕
    STAR_PRAY_SHOP_VIEW = 9105,
    STAR_PRAY_EQUIP_VIEW = 9106,
    STAR_PRAY_SWALLOW_VIEW = 9107,
    -- worldboss
    WORLD_BOSS = 9108,
    WORLD_BOSS_ROOM = 9109,
    --探险队按钮
    EXPEDITION_BUTTON = 9110,
    -- 按钮类的类型
    -- 快捷下洞
    BUTTON_QUICK_START_GAME = 9200,
    -- 魂器按钮
    BUTTON_HORCRUX = 9201,
    -- 快速下楼
    BUTTON_QUICK_DOWN = 9202,
    BUTTON_HORCURX_TRANS_SKILL = 9203,
    BUTTON_ITEM_MAZE = 9204,
    WISH_POOL_MAIN = 9205,
    WISH_POOL_TIP = 9206,
    PET_MAIN = 9207,
    PET_ATTR = 9208,
    PET_TRAIN = 9209,
    PET_COMPOSE = 9210,
    PET_REFINE = 9211,
    PET_HANDBOOK = 9212,
    PET_RESULT = 9213,
    -- 宠物传承
    PET_INHERIT = 9214,
    -- festival 节日活动
    FESTIVAL_HULU_WEAPON_CHOICE = 9300,
    FESTIVAL_EXCHANGE_SHOP = 9301,
    -- 宠物宝藏收集
    PET_TREASURE_GATHER = 9400,
    TIPSTEST = 9999,
    -- 仓库标签
    TABITEM_WAREHOUSE = 10000,
    -- 批量删除标签
    TABITEM_BATCH_DELETE = 10001,
    -- 过度动画层
    TRANSITION = 10100,
    -- 道具数量选择tips
    PROP_AMOUNT_TIPS = 10002,
    -- 宠物回收商店
    PET_RECYCLING_SHOP = 10002,
    -- 竞技场相关的UI类型
    ARENA_VIEW = 11100,
    -- 竞技场挑战
    ARENA_CHALLENGE = 11101,
    -- 竞技场备战
    ARENA_PREPARE = 11102,
    -- 竞技场排行
    ARENA_RANKING = 11103,
    -- 竞技场战斗记录
    ARENA_REPORT = 11104,
    --竞技场挑战标签
    FUNCTION_TAB_ARENA_CHALLENGE = 11111,
    --竞技场备战标签
    FUNCTION_TAB_ARENA_PREPARE = 11112,
    --竞技场排行榜标签
    FUNCTION_TAB_ARENA_RANKING = 11113,
    --竞技场战斗记录标签
    FUNCTION_TAB_ARENA_REPORT = 11114,
    -- 遗物背包主界面
    RELIC_MAIN_VIEW = 11120,
    -- 遗物装备页面
    RELIC_ROLE_LAYER = 11121,
    -- 遗物背包页面
    RELIC_BAG_LAYER = 11122,
    -- 缤纷活动主界面
    TRADE_ACTIVITY_MAIN = 11130,
    -- 特惠礼包
    TRADE_ACTIVITY_FIRST = 11131,
    -- 成长基金
    TRADE_ACTIVITY_GROW_FUND = 11132,
    -- 每日超值礼包
    TRADE_ACTIVITY_DAILY_GIFT = 11133,
    -- 每日充值奖励
    TRADE_ACTIVITY_DAILY_PAY = 11134,
    -- 达人活动
    TRADE_ACTIVITY_LIMIT_COMPETITION = 11135,
    -- 大转盘
    TRADE_ACTIVITY_LOTTERY = 11136,
    -- 月卡终身卡
    TRADE_ACTIVITY_PRIVILEGE_CARD = 11137,
    -- 团购
    TRADE_ACTIVITY_GROUP_PAY = 11138,
    -- 月卡global
    TRADE_ACTIVITY_PRIVILEGE_CARD_GLOBAL = 11139,
    --反斗商店
    FIGHT_BACK_SHOP = 11140,
    --反斗乐
    FIGHT_BACK = 11141,
    -- 幽灵深渊选关页面
    GHOSTABYSS_LEVEL_SELECT = 11142,
    -- 幽灵深渊商店页面
    GHOSTABYSS_SHOP = 11143,
    -- 幽灵深渊难度选择
    GHOSTABYSS_DIFFCULTY_SELECT = 11144,
    -- 幽灵深渊关卡选择
    GHOSTABYSS_CHOICE_LEVEL = 11145,
    -- 幽灵深渊洞窟内祈福选择
    GHOSTABYSS_SELECT = 11146,
    -- 兽栏
    PET_SITE = 11147,
    -- 宠物探险
    PET_ADVENTURE = 11148,
    -- QQ大厅特权
    GAME_HALL_PRIVILEGE = 11149,
    -- QQ大厅大咖
    QQ_GAME_MOGUL = 11149,
    -- 钓鱼准备界面
    MANOR_FISHING_LAYER = 11150,
    -- 渔具商店
    MANOR_FISHING_SHOP = 11151,
    -- 套装属性改造
    SUIT_TRANSFORMATION = 11152,
    -- 虚空秘境
    MAIN_UI_VOIDRIFT = 11153,
    -- 易物台
    BARTER_TABLE = 11154,
    -- 星图卡片
    STAR_MAP_CARD = 11155,
    --限时反斗乐
    LIMITED_FIGHT_BACK = 11156,
    -- 船坞
    DOCK_MAIN = 11157,
    -- 庄园管家
    MANOR_BUTLER = 11158,
    -- 庄园管家 外形管理
    MANOR_SHAPE_MANAGE = 11159,
    -- 船坞航行
    DOCK_SAIL = 11160,
    -- 餐桌
    DINNING_TABLE_COOK = 11161,
    -- 幻化架
    DRESS_UP_SHELF = 11162,
    -- 庄园升级
    MANOR_UPGRADE_VIEW = 11163,
    -- 船坞升级
    DOCK_UPGRADE_VIEW = 11164,
    -- 餐桌升级
    DINNING_TABLE_UPGRADE = 11165,
    
    -- 活动副本,排名奖励
    MODE_CAVE_LEADERBOARD = 11200,
    
    -- 活动副本,试炼之地
    MODE_CAVE_TRIAL_LAND = 11201,
    
    -- 维京时代
    MAIN_UI_VIKING = 11210,
    
    --宠物装备宝石镶嵌和吞噬界面
    PET_GEM_STONE = 11220,
    
    --宠物学习技能
    PET_LEARN_SKILL = 11211,
    
    --宝藏鉴定
    PET_IDENTIFY_TREASURE = 11222,
    
    --永冬裂缝
    MAIN_UI_EVER_WINTER = 11223,
    
    --泰坦之路
    LEVEL_SELECT_TITAN = 11224,
    
    --水晶夺宝
    CRYSTAL_CAPTURE = 11225,
    
    --水晶夺宝商店
    CRYSTAL_CAPTURE_SHOP = 11226,
    
    -- 模具使用
    USE_MOLD = 11227,
    
    -- 模具锻造
    MOLD_FORGING = 11228,
    
    -- 洞窟探宝
    CAVE_EXPLORING = 11229,
    
    -- 干涸之泉选关界面
    LEVEL_SELECT_DRIED_SPRING = 11230,
    
    -- 大航海船只编队界面
    BIGSAIL_SUPPLY = 11231,
    
    -- 大航海岛屿详情界面
    BIGSAIL_ISLAND_INFO = 11232,
    
    -- 大航海产出排行榜界面
    BIGSAIL_OUTPUT_RANK = 11233,
    
    -- 大航海Boss信息
    SAIL_BOSS_INFO = 11234,
    
    -- 大航海Boss信息
    SAIL_MAP_INFO = 11235,
    
    -- 经验副本
    DUNGEON_EXP_FIGHT_INFO = 11236,
    
    -- 大航海兑换商店
    BIGSAIL_MERCHANT = 11237,
    
    -- 大航海任务
    BIGSAIL_TASK = 11238,
    
    -- 混沌虫洞
    MAIN_UI_CHAOS = 11239,
    
    -- 雕纹铸造
    GLYPHS_CASTING = 11240,
    -- 雕纹继承
    GLYPHS_INHERIT = 11241,
    -- 雕纹洗练
    GLYPHS_REFINED = 11242,
    -- 雕纹镶嵌
    GLYPHS_INLAY = 11243,
    -- 雕纹批量洗练
    GLYPHS_REFINED_MANYTIMES = 11244,
    
    -- 虫洞深处
    MAIN_UI_WORMHOLE = 11245,
    
    -- 紫升红
    PURPLE_UPGRADE_EQUIP = 11246,
    
    -- 拉力赛，投注
    RALLY_BET = 12000,
    -- 拉力赛，战斗
    RALLY_GAME = 12001,
    -- 拉力赛，战斗结束
    RALLY_RESULT = 12002,
    -- 拉力赛，技能目标选择
    RALLY_SKILL_TARGET_CHOICE = 12003,
    -- 拉力赛，船只信息
    RALLY_BOAT_INFO = 12004,
    -- 装备升品
    PURPLE_UPGRADE_RESET = 12005,

    --纪念品
    SOUVENIR = 12006,
}

UIType = UI.Type

-- UI组件的事件
UI.Event = {
    -- 背包格子拖拽事件
    BAG_GRID_DRAG_BEGAN = 1,
    BAG_GRID_DRAG_MOVED = 2,
    BAG_GRID_DRAG_ENDED = 3,
    BAG_GRID_DOUBLE_CLICK = 4,
    BAG_GRID_CLICK = 5,
    -- 按钮事件
    BUTTON_PRESS = 10,
    BUTTON_CLICK = 11,
    BUTTON_RELEASE = 12,
    BUTTON_DISABLE = 13,
    BUTTON_ERROR = 14,
    BUTTON_ENABLE = 15,
    BUTTON_DISABLE_PRESS = 16,
    --disable 状态下需要相应提示
    -- 组件尺寸改变
    COMPONENT_SIZE_CHANGED = 21,
    -- tab被点击
    TAB_CLICK = 22,
    TAB_ACTIVE = 23,
    TAB_INACTIVE = 24,
    -- 组件的touch事件
    COMPONENT_TOUCH_BEGAN = 25, -- 发送参数：param1:触发点击事件开始的组件对象；param2:全局坐标；
    COMPONENT_TOUCH_MOVED = 26, -- 发送参数：param1:触发点击事件移动的组件对象；param2:全局坐标；
    COMPONENT_TOUCH_ENDED = 27, -- 发送参数：param1:出发点击事件结束的组件对象；param2:全局坐标；
    COMPONENT_CLICK = 28, -- 发送参数：param1:当前点击的组件对象；
    COMPONENT_DOUBLE_CLICK = 29, -- 发送参数：param1:当前双击的组件对象；
    COMPONENT_DRAG_BEGAN = 30, -- 发送参数：param1：当前拖拽的组件对象；param2：全局坐标；
    COMPONENT_DRAG_MOVED = 31, -- 发送参数：param1：当前拖拽的组件对象；param2：全局坐标；
    COMPONENT_DRAG_ENDED = 32, -- 发送参数：param1：当前拖拽的组件对象；param2：全局坐标；
    COMPONENT_TOUCH_OUTSIDE = 33, -- 发送参数：param1：当前点击开始的对象；param2：全局坐标；
    COMPONENT_TOUCH_OUTSIDE_ENDED = 34,
    -- 列表控件事件
    LIST_VIEW_GRID_CLICK = 40, -- 发送参数：param1：列表中的格子对象；
    LIST_VIEW_GRID_DOUBLE_CLICK = 41, -- 发送参数：param1：列表中的格子对象；
    LIST_VIEW_GRID_DRAG_BEGAN = 42, -- 发送参数：param1：列表中的格子对象；param2：全局坐标；
    LIST_VIEW_GRID_DRAG_MOVED = 43, -- 发送参数：param1：列表中的格子对象；param2：全局坐标；
    LIST_VIEW_GRID_DRAG_ENDED = 44, -- 发送参数：param1：列表中的格子对象；param2：全局坐标；
    -- 套装选择事件
    SELECT_EQUIPMENT_INDEX = 40, -- 发送参数：param1:选择套装的索引；
    -- 角色展示区域的装备格子拖拽事件
    ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_BEGIN = 50, -- 发送参数：param1：当前拖拽的组件对象；param2：全局坐标；
    ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_MOVED = 51, -- 发送参数：param1：当前拖拽的组件对象；param2：全局坐标；
    ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_ENDED = 52, -- 发送参数：param1：当前拖拽的组件对象；param2：全局坐标；
    ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK = 53, -- 发送参数：param1：当前拖拽的组件对象；
    -- 角色信息区域格子的点击
    ROLE_SHOW_EQUIPMENT_GRID_CLICK = 54, -- 发送参数：param1：当前拖拽的组件对象；
    -- 滚动视图事件
    SCROLL_VIEW_SCROLL_BEGAN = 60, -- 发送参数：滚动组件
    SCROLL_VIEW_SCROLLING = 61, -- 发送参数：param1:滚动组件；param2:滚动百分比；
    SCROLL_VIEW_SCROLL_ENDED = 62, -- 发送参数：滚动组件
    SCROLL_VIEW_AUTOSCROLL_ENDED = 63, -- 发送参数：滚动组件
    -- 对话框事件
    DIALOG_CONFIRM = 71,
    DIALOG_CANCEL = 72,
    DIALOG_TIMEOUT = 73,
    DIALOG_OUT_SIDE = 74,
    DIALOG_CENTER = 75, -- tips中间的按钮(或者第三个按钮)
    -- 点击技能
    USE_SKLL_CLICK = 80,
    -- 动画组件事件
    ANIMATION_START = 90, -- 发送参数：动画组件
    ANIMATION_END = 91, -- 发送参数：动画组件
    ANIMATION_COMPLETE = 92, -- 发送参数：动画组件
    ANIMATION_EVENT = 93, -- 发送参数：动画组件
    ANIMATION_INTERRUPT = 94, -- 发送参数：动画组件
    ANIMATION_DISPOSE = 95, -- 发送参数：动画组件
    -- 小地图事件
    MINI_MAP_ROLE_POSITION_CHANGED = 100, -- 小地图角色位置改变
    -- 登录相关事件
    EVENT_VERYFY = 150,
    EVENT_SELECT_ROLE = 151,
    EVENT_THIRD_VERYFY_SUCCESS = 152, --sdk登录成功 返回账号 ip 端口
    EVENT_THIRD_VERYFY_FAILED = 153, --sdk登录失败 返回错误码 和原因
    -- 图片按钮事件
    IMAGE_BUTTON_CLICK = 110,
    IMAGE_BUTTON_CLICK_OUTSIDE = 111,
    PRO_BAR_ARCHIVE_TOUCH = 120, --发送参数:y坐标
    PRO_BAR_RANKING_TOUCH = 122, --发送参数:y坐标
    ROLE_LOADED_SPINE_SUCCESS = 121, --加载spine成功
    CONTROL_SWITCH_TOUCH = 123, --选择
    EVENT_ONENTER = 124,
    EVENT_ONEXIT = 125,
    EVENT_CLEANUP = 126,
    CHECKBOX_CHECKED = 127,
    CHECKBOX_UNCHECKED = 128,
    CHECKBOX_STATUS_CHANGED = 129,
    EVENT_USER_CONFIG_SKILL = 130,
    -- win32的组件touch事件
    COMPONENT_CLICK_BEGAN = 140, -- 发送参数：param1:触发点击事件开始的组件对象；param2:全局坐标；
    COMPONENT_CLICK_ENDED = 141, -- 发送参数：param1:出发点击事件结束的组件对象；param2:全局坐标；
    
    -- 渔具展示区域的装备格子拖拽事件
    FISH_GEAR_EQUIPMENT_GRID_DRAG_BEGIN = 150, -- 发送参数：param1：当前拖拽的组件对象；param2：全局坐标；
    FISH_GEAR_EQUIPMENT_GRID_DRAG_MOVED = 151, -- 发送参数：param1：当前拖拽的组件对象；param2：全局坐标；
    FISH_GEAR_EQUIPMENT_GRID_DRAG_ENDED = 152, -- 发送参数：param1：当前拖拽的组件对象；param2：全局坐标；
    FISH_GEAR_EQUIPMENT_GRID_CLICK = 153, -- 发送参数：param1：当前拖拽的组件对象；
}
UIEvent = UI.Event

-- 组件的默认布局方式
UI.LayoutDefaultType = {
    DEFAULT = 0,
    CENTER = 1,
    LEFT_UP = 2,
    LEFT_BOTTOM = 3,
    RIGHT_UP = 4,
    RIGHT_BOTTOM = 5,
    CENTER_UP = 6,
    CENTER_BOTTOM = 7,
    CENTER_LEFT = 8,
    CENTER_RIGHT = 9,
    FLOAT_LEFT = 10,
    FLOAT_RIGHT = 11
}
LayoutDefaultType = UI.LayoutDefaultType

-- 组件的排列方式
UI.LayoutArrayType = {
    HORIZONTAL = 1, -- 横向布局
    VERTICAL = 2 -- 纵向布局
}
LayoutArrayType = UI.LayoutArrayType

-- 组件的浮动布局方式
UI.LayoutFloatType = {
    NONE = 0,
    FLOAT_LEFT = 1,
    FLOAT_RIGHT = 2,
    FLOAT_UP = 4,
    FLOAT_BOTTOM = 8,
    FLOAT_LEFT_UP = 5,
    FLOAT_LEFT_BOTTOM = 9,
    FLOAT_RIGHT_UP = 6,
    FLOAT_RIGHT_BOTTOM = 10
}
LayoutFloatType = UI.LayoutFloatType

-- UI字体
UI.FONT_ARIAL = "Arial"
UI.FONT_GAMING_FNT = "font-gaming.fnt"
-- UI字体大小
UI.FONT_TITLE = 25
UI.FONT_CONTENT = 12
UI.FONT_MONSTER_NAME = 21
UI.FONT_ROLE_NAME = 18

-- 常用颜色
UI.WHITE = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
UI.BLACK = {r = 0.0, g = 0.0, b = 0.0, a = 1.0}
UI.RED = {r = 1.0, g = 0.0, b = 0.0, a = 1.0}
UI.GREEN = {r = 0.0, g = 1.0, b = 0.0, a = 1.0}
UI.BLUE = {r = 0.0, g = 0.0, b = 1.0, a = 1.0}
UI.GRAY = {r = 0.5, g = 0.5, b = 0.5, a = 1.0}
UI.YELLOW = {r = 1.0, g = 1.0, b = 0.0, a = 1.0}
-- 测试颜色
UI.COLOR1 = {r = 1.0, g = 1.0, b = 0.5, a = 1.0}
UI.COLOR2 = {r = 1.0, g = 0.5, b = 1.0, a = 1.0}
UI.COLOR3 = {r = 0.5, g = 1.0, b = 1.0, a = 1.0}
UI.COLOR5 = {r = 0.5, g = 0.5, b = 0.5, a = 1.0}
UI.COLOR6 = {r = 1.0, g = 0.5, b = 0.5, a = 1.0}
UI.COLOR7 = {r = 0.5, g = 1.0, b = 1.0, a = 1.0}
UI.COLOR8 = {r = 0.5, g = 1.0, b = 0.5, a = 1.0}
UI.COLOR9 = {r = 0.1, g = 0.2, b = 0.3, a = 1.0}
UI.COLOR10 = {r = 0.3, g = 0.2, b = 0.1, a = 1.0}

-- UI字体
UI.FONT_ARIAL = "helvetica"
UI.FONT_BOLD = "bold.ttf"
UI.FONT_STANDARD = "standard.ttf"
UI.FONT_DES = "describe.ttf"
UI.FONT_TITLE = "title.ttf"
local LanguageManager = require("app.game.LanguageManager")

-- 伤害数值字体
UI.FONT_HURT_FNT = "fonts/font_description_hurt.fnt"

UI.SYS_FONT = "helvetica"
UI.SYS_FONT_CHAT = "PingFangSC-Light"

------------------------ 以下为新的字体大小以及颜色定义 -----------------
UI.FONT_SIZE_14PX = 14
UI.FONT_SIZE_15PX = 15
UI.FONT_SIZE_16PX = 16
UI.FONT_SIZE_18PX = 18
UI.FONT_SIZE_19PX = 19
UI.FONT_SIZE_20PX = 20
UI.FONT_SIZE_24PX = 24
UI.FONT_SIZE_25PX = 25
UI.FONT_SIZE_28PX = 28
UI.FONT_SIZE_35PX = 35
UI.FONT_SIZE_40PX = 40

UI.FONT_COLOR_102_0_0 = {r = 102, g = 0, b = 0}
UI.FONT_COLOR_41_41_45 = {r = 41, g = 41, b = 45}
UI.FONT_COLOR_155_155_155 = {r = 155, g = 155, b = 155}
UI.FONT_COLOR_219_35_45 = {r = 219, g = 35, b = 45}
UI.FONT_COLOR_227_214_172 = {r = 227, g = 214, b = 172}
UI.FONT_COLOR_250_211_124 = {r = 250, g = 211, b = 124}
UI.FONT_COLOR_217_187_117 = {r = 217, g = 187, b = 117}
UI.FONT_COLOR_91_47_7 = {r = 91, g = 47, b = 7}
UI.FONT_COLOR_87_61_10 = {r = 87, g = 61, b = 10}
UI.FONT_COLOR_78_30_81 = {r = 78, g = 30, b = 81}
UI.FONT_COLOR_115_51_17 = {r = 115, g = 51, b = 17}
UI.FONT_COLOR_80_5_5 = {r = 80, g = 5, b = 5}
UI.FONT_COLOR_15_85_71 = {r = 15, g = 85, b = 71}
UI.FONT_COLOR_77_80_97 = {r = 77, g = 80, b = 97}
UI.FONT_COLOR_42_103_85 = {r = 42, g = 103, b = 85}
UI.FONT_COLOR_40_62_106 = {r = 40, g = 62, b = 106}
UI.FONT_COLOR_85_49_114 = {r = 85, g = 49, b = 114}
UI.FONT_COLOR_102_102_102 = {r = 102, g = 102, b = 102}
UI.FONT_COLOR_82_82_82 = {r = 82, g = 82, b = 82}
UI.FONT_COLOR_248_157_76 = {r = 248, g = 157, b = 76}
UI.FONT_COLOR_187_181_175 = {r = 187, g = 181, b = 175}
UI.FONT_COLOR_102_51_51 = {r = 102, g = 51, b = 51}
UI.FONT_COLOR_80_168_107 = {r = 86, g = 168, b = 107}
UI.FONT_COLOR_92_144_249 = {r = 92, g = 144, b = 249}
UI.FONT_COLOR_56_49_44 = {r = 56, g = 49, b = 44}
UI.FONT_COLOR_56_20_0 = {r = 56, g = 20, b = 0}
UI.FONT_COLOR_20_105_22 = {r = 20, g = 105, b = 22}

UI.FONT_COLOR_220_211_147 = {r = 220, g = 211, b = 147}
UI.FONT_COLOR_48_50_56 = {r = 48, g = 50, b = 56}
UI.FONT_COLOR_37_40_44 = {r = 37, g = 40, b = 44}
UI.FONT_COLOR_50_50_44 = {r = 50, g = 50, b = 44}
UI.FONT_COLOR_50_45_42 = {r = 50, g = 45, b = 42}
UI.FONT_COLOR_170_170_170 = {r = 170, g = 170, b = 170}
UI.FONT_COLOR_177_81_15 = {r = 177, g = 81, b = 15}
UI.FONT_COLOR_223_192_143 = {r = 223, g = 192, b = 143}
UI.FONT_COLOR_233_212_187 = {r = 233, g = 212, b = 187}

UI.FONT_COLOR_36_181_118 = {r = 36, g = 181, b = 118}
UI.FONT_COLOR_208_50_60 = {r = 208, g = 50, b = 60}
UI.FONT_COLOR_249_220_103 = {r = 249, g = 220, b = 103}
UI.FONT_COLOR_249_226_151 = {r = 249, g = 226, b = 151}
UI.FONT_COLOR_77_77_84 = {r = 77, g = 77, b = 84}
UI.FONT_COLOR_194_194_194 = {r = 194, g = 194, b = 194}
UI.FONT_COLOR_210_210_210 = {r = 210, g = 210, b = 210}
UI.FONT_COLOR_255_187_89 = {r = 255, g = 187, b = 89}
UI.FONT_COLOR_244_219_46 = {r = 244, g = 219, b = 46}
UI.FONT_COLOR_45_233_245 = {r = 45, g = 233, b = 245}
UI.FONT_COLOR_120_115_118 = {r = 120, g = 115, b = 118}
UI.FONT_COLOR_189_167_136 = {r = 189, g = 167, b = 136}
UI.FONT_COLOR_255_247_202 = {r = 255, g = 247, b = 202}
UI.FONT_COLOR_215_185_155 = {r = 215, g = 185, b = 155}
UI.FONT_COLOR_220_182_80 = {r = 220, g = 182, b = 80}
UI.FONT_COLOR_207_182_89 = {r = 207, g = 182, b = 89}
UI.FONT_COLOR_47_50_55 = {r = 47, g = 50, b = 55}
UI.FONT_COLOR_219_184_80 = {r = 219, g = 184, b = 80}
UI.FONT_COLOR_157_221_231 = {r = 157, g = 221, b = 231}
UI.FONT_COLOR_255_164_34 = {r = 255, g = 164, b = 34}
UI.FONT_COLOR_60_26_3 = {r = 60, g = 26, b = 3}
UI.FONT_COLOR_254_216_0 = {r = 254, g = 216, b = 0}
UI.FONT_COLOR_187_167_136 = {r = 187, g = 167, b = 136}
UI.FONT_COLOR_187_36_45 = {r = 187, g = 36, b = 45}
UI.FONT_COLOR_154_21_30 = {r = 154, g = 21, b = 30}
UI.FONT_COLOR_160_130_60 = {r = 160, g = 130, b = 60}
UI.FONT_COLOR_116_173_221 = {r = 116, g = 173, b = 221}
UI.FONT_COLOR_69_153_223 = {r = 69, g = 153, b = 223}
UI.FONT_COLOR_247_172_53 = {r = 247, g = 172, b = 53}
UI.FONT_COLOR_229_151_58 = {r = 229, g = 151, b = 58}
UI.FONT_COLOR_223_117_22 = {r = 223, g = 117, b = 22}
UI.FONT_COLOR_56_56_51 = {r = 56, g = 56, b = 51}
UI.FONT_COLOR_226_183_86 = {r = 226, g = 183, b = 86}
UI.FONT_COLOR_205_205_205 = {r = 205, g = 205, b = 205}
UI.FONT_COLOR_255_204_0 = {r = 255, g = 204, b = 0}
UI.FONT_COLOR_254_255_188 = {r = 254, g = 255, b = 188}
UI.FONT_COLOR_255_153_255 = {r = 255, g = 153, b = 255}
UI.FONT_COLOR_255_204_153 = {r = 255, g = 204, b = 153}
UI.FONT_COLOR_244_172_246 = {r = 244, g = 172, b = 246}
UI.FONT_COLOR_236_213_153 = {r = 236, g = 213, b = 153}
UI.FONT_COLOR_212_96_203 = {r = 212, g = 96, b = 203}
UI.FONT_COLOR_255_204_102 = {r = 255, g = 204, b = 102}
UI.FONT_COLOR_204_51_51 = {r = 204, g = 51, b = 51}
UI.FONT_COLOR_164_164_164 = {r = 164, g = 164, b = 164}
UI.FONT_COLOR_36_25_25 = {r = 36, g = 25, b = 25}
UI.FONT_COLOR_86_21_24 = {r = 86, g = 21, b = 24}
UI.FONT_COLOR_255_201_192 = {r = 255, g = 201, b = 192}
UI.FONT_COLOR_194_174_221 = {r = 194, g = 174, b = 221}
UI.FONT_COLOR_186_219_231 = {r = 186, g = 219, b = 231}
UI.FONT_COLOR_45_44_48 = {r = 45, g = 44, b = 48}
UI.FONT_COLOR_193_193_193 = {r = 193, g = 193, b = 193}
UI.FONT_COLOR_220_185_117 = {r = 220, g = 185, b = 117}
UI.FONT_COLOR_243_212_136 = {r = 243, g = 212, b = 136}
UI.FONT_COLOR_98_96_86 = {r = 98, g = 96, b = 86}
UI.FONT_COLOR_198_193_215 = {r = 198, g = 193, b = 215}
UI.FONT_COLOR_50_44_72 = {r = 50, g = 44, b = 72}
UI.FONT_COLOR_60_58_46 = {r = 60, g = 58, b = 46}
UI.FONT_COLOR_60_57_60 = {r = 60, g = 57, b = 60}

-- 在按钮上 货币等不够的时候统一颜色
UI.FONT_COLOR_NOT_ENOUGH = {r = 208, g = 50, b = 60}
-- 锻造材料不够时名字颜色
UI.FONT_COLOR_NOT_ENOUGH_FOR_FORGE = {r = 80, g = 5, b = 5}
-- 公会名字专用
UI.FONT_COLOR_GUILD_NAME = {r = 150, g = 213, b = 245}
UI.SLIDER_COLOR_Dark = {r = 65, g = 59, b = 67}
UI.SLIDER_COLOR_Light = {r = 91, g = 79, b = 76}
UI.FONT_COLOR_IAP_DIAMOND_HOT = {r = 241, g = 213, b = 117}
UI.FONT_COLOR_IAP_BOX_HOT = {r = 189, g = 16, b = 26}
UI.FONT_COLOR_IAP_DIAMOND_DOUBLE = {r = 223, g = 191, b = 80}
UI.FONT_COLOR_IAP_DIAMOND = {r = 255, g = 255, b = 255}
UI.FONT_COLOR_MASTER_HERO_NAME = {r = 115, g = 208, b = 86}
UI.FONT_COLOR_OTHER_HERO_NAME = {r = 92, g = 144, b = 249}
UI.FONT_COLOR_OUTLINE_HERO_NAME = {r = 22, g = 22, b = 22}
UI.FONT_COLOR_LOGIN_BUTTON_TEXT = {r = 77, g = 77, b = 77}
UI.FONT_COLOR_ENTER_GAME_BUTTON_TEXT = {r = 245, g = 216, b = 98}
UI.FONT_COLOR_SHARE_EQUIP_NAME = {r = 115, g = 208, b = 86}
UI.FONT_COLOR_SHARE_EQUIP_NAME_OUTLINE = {r = 44, g = 17, b = 17}
UI.FONT_COLOR_SHARE_EQUIP_TITLE = {r = 243, g = 224, b = 183}
UI.FONT_COLOR_SHARE_EQUIP_GUILD = {r = 41, g = 41, b = 45}
UI.FONT_COLOR_LOADING_PERCENT_TEXT = {r = 210, g = 202, b = 190}
UI.FONT_COLOR_LOADING_NOTE_TEXT = {r = 210, g = 202, b = 190}
UI.FONT_COLOR_HOTFIX_PROGRESS_TEXT = {r = 210, g = 202, b = 190}
UI.FONT_COLOR_GOLDEN_MINE_TAB_TEXT_NORNAL = {r = 121, g = 110, b = 86}
UI.FONT_COLOR_GOLDEN_MINE_TAB_TEXT_ACTIVE = {r = 220, g = 182, b = 80}
UI.FONT_COLOR_204_153_51 = {r = 204, g = 153, b = 51}
UI.FONT_COLOR_255_204_51 = {r = 255, g = 204, b = 51}
UI.FONT_COLOR_255_153_51 = {r = 255, g = 153, b = 51}
UI.FONT_COLOR_230_211_196 = {r = 230, g = 211, b = 196}
UI.FONT_COLOR_241_186_100 = {r = 241, g = 186, b = 100}

UI.FONT_COLOR_223_191_80 = {r = 223, g = 191, b = 80}
UI.FONT_COLOR_201_159_95 = {r = 201, g = 159, b = 95}
UI.FONT_COLOR_21_16_11 = {r = 21, g = 16, b = 11}
UI.FONT_COLOR_215_184_75 = {r = 215, g = 184, b = 75}
UI.FONT_COLOR_137_137_137 = {r = 137, g = 137, b = 137}
UI.FONT_COLOR_130_5_5 = {r = 130, g = 5, b = 5}
UI.FONT_COLOR_41_101_25 = {r = 41, g = 101, b = 25}
UI.FONT_COLOR_219_184_121 = {r = 219, g = 184, b = 121}
UI.FONT_COLOR_181_175_169 = {r = 181, g = 175, b = 169}
UI.FONT_COLOR_22_76_6 = {r = 22, g = 76, b = 6}
UI.FONT_COLOR_130_15_15 = {r = 130, g = 15, b = 15}
UI.FONT_COLOR_192_202_203 = {r = 192, g = 202, b = 203}

UI.FONT_COLOR_178_178_178 = {r = 178, g = 178, b = 178}
UI.FONT_COLOR_43_43_43 = {r = 43, g = 43, b = 43}
UI.FONT_COLOR_255_214_102 = {r = 255, g = 214, b = 102}
------------------------ 以下为老的字体大小以及颜色定义 -----------------
-- UI字体大小
UI.FONT_SIZE_08PX = 8
UI.FONT_SIZE_09PX = 9
UI.FONT_SIZE_10PX = 10
UI.FONT_SIZE_11PX = 11
UI.FONT_SIZE_12PX = 12
UI.FONT_SIZE_13PX = 13
UI.FONT_SIZE_15PX = 15
UI.FONT_SIZE_17PX = 17
-- UI.FONT_SIZE_19PX = 19
-- UI.FONT_SIZE_21PX = 21
UI.FONT_SIZE_22PX = 22
-- UI.FONT_SIZE_23PX = 23
UI.FONT_SIZE_24PX = 24
UI.FONT_SIZE_25PX = 25
UI.FONT_SIZE_26PX = 26
UI.FONT_SIZE_28PX = 28
-- UI.FONT_SIZE_29PX = 29
UI.FONT_SIZE_30PX = 30
UI.FONT_SIZE_32PX = 32
UI.FONT_SIZE_34PX = 34
UI.FONT_SIZE_36PX = 36
UI.FONT_SIZE_38PX = 38
UI.FONT_SIZE_42PX = 42
UI.FONT_SIZE_48PX = 48
-- UI.FONT_SIZE_43PX = 43
-- UI.FONT_SIZE_50PX = 50
UI.FONT_SIZE_90PX = 90
-- UI字体颜色
UI.FONT_COLOR_42_31_1 = {r = 42, g = 31, b = 1}
UI.FONT_COLOR_42_31_0 = {r = 42, g = 31, b = 0}
UI.FONT_COLOR_247_245_232 = {r = 247, g = 245, b = 232}
UI.FONT_COLOR_205_199_189 = {r = 205, g = 199, b = 189}
UI.FONT_COLOR_205_169_90 = {r = 205, g = 169, b = 90}
UI.FONT_COLOR_106_84_46 = {r = 106, g = 84, b = 46}
UI.FONT_COLOR_102_76_41 = {r = 102, g = 76, b = 41}
UI.FONT_COLOR_127_99_62 = {r = 127, g = 99, b = 62}
UI.FONT_COLOR_246_207_195 = {r = 246, g = 207, b = 195}
UI.FONT_COLOR_184_131_102 = {r = 184, g = 131, b = 102}
UI.FONT_COLOR_57_42_0 = {r = 57, g = 42, b = 0}
UI.FONT_COLOR_97_75_53 = {r = 97, g = 75, b = 53}
UI.FONT_COLOR_195_179_131 = {r = 195, g = 179, b = 131}
UI.FONT_COLOR_174_156_102 = {r = 174, g = 156, b = 102}
UI.FONT_COLOR_122_142_53 = {r = 122, g = 142, b = 53}
UI.FONT_COLOR_156_77_12 = {r = 156, g = 77, b = 12}
UI.FONT_COLOR_134_94_41 = {r = 134, g = 94, b = 41}
UI.FONT_COLOR_184_210_94 = {r = 184, g = 210, b = 94}
UI.FONT_COLOR_255_222_82 = {r = 255, g = 222, b = 82}
UI.FONT_COLOR_255_242_210 = {r = 255, g = 242, b = 210}
UI.FONT_COLOR_233_211_142 = {r = 233, g = 211, b = 142}
UI.FONT_COLOR_206_190_145 = {r = 206, g = 190, b = 145}
UI.FONT_COLOR_140_43_27 = {r = 140, g = 43, b = 27}
UI.FONT_COLOR_185_115_42 = {r = 185, g = 115, b = 42}
UI.FONT_COLOR_87_71_38 = {r = 87, g = 71, b = 38}
UI.FONT_COLOR_136_115_66 = {r = 136, g = 115, b = 66}
UI.FONT_COLOR_43_37_25 = {r = 43, g = 37, b = 25}
UI.FONT_COLOR_68_57_33 = {r = 68, g = 57, b = 33}
UI.FONT_COLOR_53_42_33 = {r = 53, g = 42, b = 33}
UI.FONT_COLOR_100_82_63 = {r = 100, g = 82, b = 63}
UI.FONT_COLOR_215_226_175 = {r = 215, g = 226, b = 175}
UI.FONT_COLOR_27_33_5 = {r = 27, g = 33, b = 5}
UI.FONT_COLOR_80_16_42 = {r = 80, g = 61, b = 42}
UI.FONT_COLOR_181_142_72 = {r = 181, g = 142, b = 72}
UI.FONT_COLOR_45_30_18 = {r = 45, g = 30, b = 18}
UI.FONT_COLOR_39_16_3 = {r = 39, g = 16, b = 3}
UI.FONT_COLOR_75_58_41 = {r = 75, g = 58, b = 41}
UI.FONT_COLOR_56_38_27 = {r = 56, g = 38, b = 27}
UI.FONT_COLOR_220_211_203 = {r = 220, g = 211, b = 203}
UI.FONT_COLOR_109_98_59 = {r = 109, g = 98, b = 59}
UI.FONT_COLOR_107_83_59 = {r = 107, g = 83, b = 59}
UI.FONT_COLOR_155_140_104 = {r = 155, g = 140, b = 104}
UI.FONT_COLOR_233_182_182 = {r = 233, g = 182, b = 182}
UI.FONT_COLOR_255_203_103 = {r = 255, g = 203, b = 103}
UI.FONT_COLOR_177_143_81 = {r = 177, g = 143, b = 81}
UI.FONT_COLOR_255_220_220 = {r = 255, g = 220, b = 220}
UI.FONT_COLOR_222_240_254 = {r = 222, g = 240, b = 254}
UI.FONT_COLOR_255_241_210 = {r = 255, g = 241, b = 210}
UI.FONT_COLOR_59_22_22 = {r = 59, g = 22, b = 22}
UI.FONT_COLOR_34_36_56 = {r = 34, g = 36, b = 56}
UI.FONT_COLOR_53_42_19 = {r = 53, g = 42, b = 19}
UI.FONT_COLOR_141_103_65 = {r = 141, g = 103, b = 65}
UI.FONT_COLOR_144_122_16 = {r = 144, g = 122, b = 16}
UI.FONT_COLOR_190_79_35 = {r = 190, g = 79, b = 35}
UI.FONT_COLOR_106_216_94 = {r = 106, g = 216, b = 94}
UI.FONT_COLOR_107_137_237 = {r = 107, g = 137, b = 237}
UI.FONT_COLOR_197_207_218 = {r = 197, g = 207, b = 218}
UI.FONT_COLOR_73_61_42 = {r = 73, g = 61, b = 42}
UI.FONT_COLOR_234_222_190 = {r = 234, g = 222, b = 190}
UI.FONT_COLOR_255_66_66 = {r = 255, g = 66, b = 66}
UI.FONT_COLOR_50_50_54 = {r = 50, g = 50, b = 54}
UI.FONT_COLOR_190_180_160 = {r = 190, g = 180, b = 160}
UI.FONT_COLOR_31_30_27 = {r = 31, g = 30, b = 27}
UI.FONT_COLOR_118_110_101 = {r = 118, g = 110, b = 101}
UI.FONT_COLOR_218_211_154 = {r = 218, g = 211, b = 154}
UI.FONT_COLOR_197_175_175 = {r = 197, g = 175, b = 175}
UI.FONT_COLOR_245_190_0 = {r = 245, g = 190, b = 0}
UI.FONT_COLOR_222_190_98 = {r = 222, g = 190, b = 98}

UI.FONT_COLOR_255_255_0 = {r = 255, g = 255, b = 0}

UI.FONT_COLOR_243_209_53 = {r = 243, g = 209, b = 53}
UI.FONT_COLOR_72_49_31 = {r = 72, g = 49, b = 31}
UI.FONT_COLOR_115_93_62 = {r = 115, g = 93, b = 62}
UI.FONT_COLOR_182_158_121 = {r = 182, g = 158, b = 121}
UI.FONT_COLOR_67_58_50 = {r = 67, g = 58, b = 50}
UI.FONT_COLOR_130_117_103 = {r = 130, g = 117, b = 103}
UI.FONT_COLOR_228_243_169 = {r = 228, g = 243, b = 169}
UI.FONT_COLOR_44_197_160 = {r = 44, g = 197, b = 160}
UI.FONT_COLOR_255_248_0 = {r = 255, g = 248, b = 0}
UI.FONT_COLOR_234_232_145 = {r = 234, g = 232, b = 145}
UI.FONT_COLOR_137_95_29 = {r = 137, g = 95, b = 29}
UI.FONT_COLOR_198_193_163 = {r = 198, g = 193, b = 163}
UI.FONT_COLOR_209_190_140 = {r = 209, g = 190, b = 140}
UI.FONT_COLOR_209_171_68 = {r = 209, g = 171, b = 68}
UI.FONT_COLOR_69_162_227 = {r = 69, g = 162, b = 227}
UI.FONT_COLOR_209_190_140 = {r = 209, g = 190, b = 140}
UI.FONT_COLOR_69_227_154 = {r = 69, g = 227, b = 154}
UI.FONT_COLOR_51_51_51 = {r = 51, g = 51, b = 51}
UI.FONT_COLOR_151_151_151 = {r = 151, g = 151, b = 151}
UI.FONT_COLOR_171_126_86 = {r = 171, g = 126, b = 86}
UI.FONT_COLOR_146_211_205 = {r = 146, g = 211, b = 205}
UI.FONT_COLOR_222_207_168 = {r = 222, g = 207, b = 168}
UI.FONT_COLOR_218_209_197 = {r = 218, g = 209, b = 197}
UI.FONT_COLOR_98_86_67 = {r = 98, g = 86, b = 67}
UI.FONT_COLOR_243_230_213 = {r = 243, g = 230, b = 213}
UI.FONT_COLOR_40_23_6 = {r = 40, g = 23, b = 6}
UI.FONT_COLOR_26_44_3 = {r = 26, g = 44, b = 3}
UI.FONT_COLOR_22_163_105 = {r = 22, g = 163, b = 105}
UI.FONT_COLOR_137_116_97 = {r = 137, g = 116, b = 97}
UI.FONT_COLOR_116_15_13 = {r = 116, g = 15, b = 13}
UI.FONT_COLOR_231_175_29 = {r = 231, g = 175, b = 29}
UI.FONT_COLOR_145_127_63 = {r = 145, g = 127, b = 63}
UI.FONT_COLOR_248_201_95 = {r = 248, g = 201, b = 95}
UI.FONT_COLOR_255_224_115 = {r = 255, g = 224, b = 115}
UI.FONT_COLOR_150_130_60 = {r = 150, g = 130, b = 60}
UI.FONT_COLOR_231_231_231 = {r = 231, g = 231, b = 231}

UI.FONT_COLOR_233_214_185 = {r = 233, g = 214, b = 185}
UI.FONT_COLOR_209_190_141 = {r = 201, g = 190, b = 141}
UI.FONT_COLOR_68_55_42 = {r = 68, g = 55, b = 42}
UI.FONT_COLOR_83_64_45 = {r = 83, g = 64, b = 45}
UI.FONT_COLOR_67_59_50 = {r = 67, g = 59, b = 50}
UI.FONT_COLOR_153_153_153 = {r = 153, g = 153, b = 153}
UI.FONT_COLOR_204_204_204 = {r = 204, g = 204, b = 204}
UI.FONT_COLOR_204_204_102 = {r = 204, g = 204, b = 102}
UI.FONT_COLOR_0_102_51 = {r = 0, g = 102, b = 51}

UI.FONT_COLOR_RED = {r = 255, g = 0, b = 0}
UI.FONT_COLOR_GREEN = {r = 0, g = 255, b = 0}
UI.FONT_COLOR_BLACK = {r = 0, g = 0, b = 0}
UI.FONT_COLOR_WHITE = {r = 255, g = 255, b = 255}
UI.FONT_COLOR_GRAY = {r = 100, g = 100, b = 100}
UI.FONT_COLOR_BLUE = {r = 152, g = 245, b = 255}
UI.FONT_COLOR_255_211_155 = {r = 255, g = 211, b = 155}
UI.FONT_COLOR_GRAY = {r = 112, g = 112, b = 112}
UI.FONT_COLOR_255_213_19 = {r = 255, g = 213, b = 19}

UI.FONT_COLOR_81_61_27 = {r = 81, g = 61, b = 27}
UI.FONT_COLOR_81_80_100 = {r = 81, g = 81, b = 100}
UI.FONT_COLOR_81_49_89 = {r = 81, g = 49, b = 89}
UI.FONT_COLOR_221_167_76 = {r = 221, g = 167, b = 76}

UI.FONT_COLOR_0_255_255 = {r = 0, g = 255, b = 255} --时光之门普通
UI.FONT_COLOR_108_255_208 = {r = 108, g = 255, b = 208} --泰坦之路普通
UI.FONT_COLOR_253_209_154 = {r = 253, g = 209, b = 154} --泰坦之路英雄
UI.FONT_COLOR_237_220_92 = {r = 237, g = 220, b = 92} --沙之眼
UI.FONT_COLOR_212_202_198 = {r = 212, g = 202, b = 198} 

-- 装备详情
UI.FONT_COLOR_102_154_40 = {r = 102, g = 154, b = 40} -- 绿
UI.FONT_COLOR_181_32_32 = {r = 181, g = 32, b = 32} -- 红
UI.FONT_COLOR_88_65_34 = {r = 88, g = 65, b = 34} -- 浅

UI.FONT_COLOR_121_103_55 = {r = 121, g = 103, b = 55}
UI.FONT_COLOR_157_95_139 = {r = 157, g = 95, b = 139}
UI.FONT_COLOR_167_89_51 = {r = 167, g = 89, b = 51}
UI.FONT_COLOR_199_139_44 = {r = 199, g = 139, b = 44}
UI.FONT_COLOR_107_99_91 = {r = 107, g = 99, b = 91}
UI.FONT_COLOR_107_92_77 = {r = 107, g = 92, b = 77}
-- TIPS
UI.FONT_COLOR_80_61_42 = {r = 80, g = 61, b = 42}

--掉落奖励tip
UI.FONT_COLOR_205_117_89 = {r = 205, g = 177, b = 89}

UI.FONT_COLOR_46_35_29 = {r = 46, g = 35, b = 29}
UI.FONT_COLOR_123_117_107 = {r = 123, g = 117, b = 107}
UI.FONT_COLOR_123_14_14 = {r = 123, g = 14, b = 14}
UI.FONT_COLOR_107_39_19 = {r = 107, g = 39, b = 19}
UI.FONT_COLOR_44_30_18 = {r = 44, g = 30, b = 18}
UI.FONT_COLOR_75_55_39 = {r = 75, g = 55, b = 39}
UI.FONT_COLOR_114_51_29 = {r = 114, g = 51, b = 29}
UI.FONT_COLOR_255_255_255 = {r = 255, g = 255, b = 255}
UI.FONT_COLOR_0_0_255 = {r = 0, g = 0, b = 255}
UI.FONT_COLOR_0_0_0 = {r = 0, g = 0, b = 0}
UI.FONT_COLOR_244_18_12 = {r = 244, g = 18, b = 12}
UI.FONT_COLOR_182_201_201 = {r = 182, g = 201, b = 201}
UI.FONT_COLOR_229_208_170 = {r = 229, g = 208, b = 170}
UI.FONT_COLOR_232_46_39 = {r = 232, g = 46, b = 39}
UI.FONT_COLOR_31_229_68 = {r = 31, g = 228, b = 68}
UI.FONT_COLOR_233_26_26 = {r = 233, g = 26, b = 26}

UI.FONT_COLOR_64_166_105 = {r = 64, g = 166, b = 105}
UI.FONT_COLOR_221_195_150 = {r = 221, g = 195, b = 150}
UI.FONT_COLOR_255_255_125 = {r = 255, g = 255, b = 125}
UI.FONT_COLOR_34_23_12 = {r = 34, g = 23, b = 12}
UI.FONT_COLOR_59_42_12 = {r = 59, g = 42, b = 12}
UI.FONT_COLOR_126_116_85 = {r = 126, g = 116, b = 85}
UI.FONT_COLOR_130_109_62 = {r = 130, g = 109, b = 62}
UI.FONT_COLOR_160_156_47 = {r = 160, g = 156, b = 47}
UI.FONT_COLOR_241_244_244 = {r = 241, g = 244, b = 244}
UI.FONT_COLOR_250_209_122 = {r = 250, g = 209, b = 122}
UI.FONT_COLOR_172_42_25 = {r = 172, g = 42, b = 25}
UI.FONT_COLOR_109_100_77 = {r = 109, g = 100, b = 77}
UI.FONT_COLOR_109_103_105 = {r = 109, g = 103, b = 105}
UI.FONT_COLOR_227_213_156 = {r = 227, g = 213, b = 156}
UI.FONT_COLOR_15_57_93 = {r = 15, g = 57, b = 93}
UI.FONT_COLOR_255_247_255 = {r = 255, g = 247, b = 255}
UI.FONT_COLOR_255_239_201 = {r = 255, g = 239, b = 201}
UI.FONT_COLOR_244_224_114 = {r = 244, g = 224, b = 114}
UI.FONT_COLOR_244_161_88 = {r = 189, g = 161, b = 88}
UI.FONT_COLOR_242_246_200 = {r = 242, g = 246, b = 200}
UI.FONT_COLOR_242_235_213 = {r = 242, g = 235, b = 213}
UI.FONT_COLOR_114_84_25 = {r = 114, g = 84, b = 25}
UI.FONT_COLOR_174_146_49 = {r = 174, g = 146, b = 49}
UI.FONT_COLOR_244_238_231 = {r = 244, g = 238, b = 231}
UI.FONT_COLOR_118_105_82 = {r = 118, g = 105, b = 82}
UI.FONT_COLOR_114_97_63 = {r = 114, g = 97, b = 63}
UI.FONT_COLOR_247_245_232 = {r = 247, g = 245, b = 232}
UI.FONT_COLOR_231_181_85 = {r = 231, g = 181, b = 85}
UI.FONT_COLOR_238_222_175 = {r = 238, g = 222, b = 175}
UI.FONT_COLOR_226_220_181 = {r = 226, g = 220, b = 181}
UI.FONT_COLOR_85_37_24 = {r = 85, g = 37, b = 24}
UI.FONT_COLOR_100_200_87 = {r = 100, g = 200, b = 87}
UI.FONT_COLOR_210_185_110 = {r = 210, g = 185, b = 110}
UI.FONT_COLOR_192_60_47 = {r = 192, g = 60, b = 47}
UI.FONT_COLOR_192_75_75 = {r = 192, g = 75, b = 75}
UI.FONT_COLOR_213_157_70 = {r = 213, g = 157, b = 70}
UI.FONT_COLOR_81_154_167 = {r = 81, g = 154, b = 167}
UI.FONT_COLOR_142_153_155 = {r = 142, g = 153, b = 155}
UI.FONT_COLOR_226_180_69 = {r = 226, g = 180, b = 69}
UI.FONT_COLOR_255_243_93 = {r = 255, g = 243, b = 93}
UI.FONT_COLOR_125_21_19 = {r = 125, g = 21, b = 19}
UI.FONT_COLOR_165_46_40 = {r = 165, g = 46, b = 40}
UI.FONT_COLOR_26_18_3 = {r = 26, g = 18, b = 3}
UI.FONT_COLOR_219_215_185 = {r = 219, g = 215, b = 185}
UI.FONT_COLOR_192_192_192 = {r = 192, g = 192, b = 192}
UI.FONT_COLOR_255_232_178 = {r = 255, g = 232, b = 178}
UI.FONT_COLOR_40_40_45 = {r = 40, g = 40, b = 45}
UI.FONT_COLOR_150_149_146 = {r = 150, g = 149, b = 146}
UI.FONT_COLOR_251_211_27 = {r = 251, g = 211, b = 27}
UI.FONT_COLOR_50_120_150 = {r = 50, g = 120, b = 150}
UI.FONT_COLOR_143_73_185 = {r = 143, g = 73, b = 185}
UI.FONT_COLOR_168_160_147 = {r = 168, g = 160, b = 147}
UI.FONT_COLOR_114_219_70 = {r = 114, g = 219, b = 70}

-- lzm
UI.FONT_COLOR_35_127_63 = {r = 35, g = 127, b = 63}
UI.FONT_COLOR_39_72_89 = {r = 39, g = 72, b = 89}
UI.FONT_COLOR_186_54_28 = {r = 186, g = 54, b = 28}
UI.FONT_COLOR_29_167_172 = {r = 29, g = 167, b = 172}
UI.FONT_COLOR_200_122_20 = {r = 200, g = 122, b = 20}
UI.FONT_COLOR_143_73_185 = {r = 143, g = 73, b = 185}
UI.FONT_COLOR_22_123_120 = {r = 22, g = 123, b = 120}
UI.FONT_COLOR_194_187_174 = {r = 194, g = 187, b = 174}
UI.FONT_COLOR_255_196_196 = {r = 255, g = 196, b = 196}
UI.FONT_COLOR_255_145_145 = {r = 255, g = 145, b = 145}
UI.FONT_COLOR_214_251_255 = {r = 214, g = 251, b = 255}
UI.FONT_COLOR_151_212_255 = {r = 151, g = 212, b = 255}
UI.FONT_COLOR_198_48_58 = {r = 198, g = 48, b = 58}
UI.FONT_COLOR_181_171_171 = {r = 181, g = 171, b = 171}
UI.FONT_COLOR_251_235_218 = {r = 251, g = 235, b = 218}
UI.FONT_COLOR_209_171_68 = {r = 209, g = 171, b = 68}
UI.FONT_COLOR_150_150_150 = {r = 150, g = 150, b = 150}
UI.FONT_COLOR_190_190_190 = {r = 190, g = 190, b = 190}
UI.FONT_COLOR_230_210_190 = {r = 230, g = 210, b = 190}
UI.FONT_COLOR_209_209_209 = {r = 209, g = 209, b = 209}
UI.FONT_COLOR_202_168_128 = {r = 202, g = 168, b = 128}
UI.FONT_COLOR_255_186_65 = {r = 255, g = 186, b = 65}
UI.FONT_COLOR_255_164_104 = {r = 255, g = 164, b = 104}
UI.FONT_COLOR_70_179_117 = {r = 70, g = 179, b = 117}
UI.FONT_COLOR_191_115_25 = {r = 191, g = 115, b = 25}
UI.FONT_COLOR_103_29_39 = {r = 103, g = 29, b = 39}
UI.FONT_COLOR_104_95_94 = {r = 104, g = 95, b = 94}
UI.FONT_COLOR_192_167_128 = {r = 192, g = 167, b = 128}
UI.FONT_COLOR_120_34_21 = {r = 120, g = 34, b = 21}
UI.FONT_COLOR_255_222_171 = {r = 255, g = 222, b = 171}
UI.FONT_COLOR_231_176_57 = {r = 231, g = 176, b = 57}
UI.FONT_COLOR_159_10_10 = {r = 159, g = 10, b = 10}
UI.FONT_COLOR_95_10_10 = {r = 95, g = 10, b = 10}
UI.FONT_COLOR_230_190_120 = {r = 230, g = 190, b = 120}
UI.FONT_COLOR_250_80_60 = {r = 250, g = 80, b = 60}
UI.FONT_COLOR_210_185_150 = {r = 210, g = 185, b = 150}
UI.FONT_COLOR_255_183_43 = {r = 255, g = 183, b = 43}

UI.FONT_COLOR_60_171_35 = {r = 60, g = 171, b = 35}
UI.FONT_COLOR_255_243_107 = {r = 255, g = 243, b = 107}
UI.FONT_COLOR_255_247_225 = {r = 255, g = 247, b = 225}
UI.FONT_COLOR_22_12_3 = {r = 22, g = 12, b = 3}
UI.FONT_COLOR_49_39_14 = {r = 49, g = 39, b = 14}
UI.FONT_COLOR_113_54_10 = {r = 113, g = 54, b = 10}
UI.FONT_COLOR_209_211_190 = {r = 209, g = 211, b = 190}
UI.FONT_COLOR_173_153_129 = {r = 173, g = 153, b = 129}
UI.FONT_COLOR_134_114_78 = {r = 134, g = 114, b = 78}
UI.FONT_COLOR_132_124_100 = {r = 132, g = 124, b = 100}
UI.FONT_COLOR_180_160_107 = {r = 180, g = 160, b = 107}
UI.FONT_COLOR_112_84_39 = {r = 112, g = 84, b = 39}
UI.FONT_COLOR_255_235_216 = {r = 255, g = 235, b = 216}
UI.FONT_COLOR_131_128_125 = {r = 131, g = 128, b = 125}
UI.FONT_COLOR_170_170_170 = {r = 170, g = 170, b = 170}
UI.FONT_COLOR_254_229_85 = {r = 254, g = 229, b = 85}
UI.FONT_COLOR_217_54_54 = {r = 217, g = 54, b = 54}
UI.FONT_COLOR_45_45_45 = {r = 45, g = 45, b = 45}
UI.FONT_COLOR_237_236_217 = {r = 237, g = 236, b = 217}

UI.FONT_COLOR_OUTLINE_255_255_255 = {r = 0, g = 0, b = 0}
UI.FONT_COLOR_OUTLINE_56_38_27 = {r = 56, g = 38, b = 27}
UI.FONT_COLOR_OUTLINE_49_12_12 = {r = 49, g = 12, b = 12}
UI.FONT_COLOR_OUTLINE_97_75_53 = {r = 97, g = 75, b = 53}
UI.FONT_COLOR_OUTLINE_73_56_38 = {r = 73, g = 56, b = 38}
UI.FONT_COLOR_OUTLINE_39_16_3 = {r = 39, g = 16, b = 3}
UI.FONT_COLOR_OUTLINE_55_14_14 = {r = 55, g = 14, b = 14}
UI.FONT_COLOR_OUTLINE_59_22_22 = {r = 59, g = 22, b = 22}
UI.FONT_COLOR_OUTLINE_34_36_56 = {r = 34, g = 36, b = 56}
UI.FONT_COLOR_OUTLINE_53_42_19 = {r = 53, g = 42, b = 19}
UI.FONT_COLOR_OUTLINE_59_5_5 = {r = 59, g = 5, b = 5}
UI.FONT_COLOR_OUTLINE_38_47_47 = {r = 38, g = 47, b = 47}
UI.FONT_COLOR_OUTLINE_38_17_0 = {r = 38, g = 17, b = 0}
UI.FONT_COLOR_OUTLINE_67_39_15 = {r = 67, g = 39, b = 15}
UI.FONT_COLOR_OUTLINE_14_36_60 = {r = 14, g = 36, b = 60}
UI.FONT_COLOR_OUTLINE_75_20_20 = {r = 75, g = 20, b = 20}
UI.FONT_COLOR_OUTLINE_173_254_239 = {r = 173, g = 254, b = 239}
UI.FONT_COLOR_OUTLINE_45_25_8 = {r = 45, g = 25, b = 8}
UI.FONT_COLOR_OUTLINE_67_52_20 = {r = 67, g = 52, b = 20}
UI.FONT_COLOR_OUTLINE_45_47_33 = {r = 45, g = 47, b = 33}
UI.FONT_COLOR_OUTLINE_88_72_12 = {r = 88, g = 72, b = 12}
UI.FONT_COLOR_OUTLINE_97_45_6 = {r = 97, g = 45, b = 6}
UI.FONT_COLOR_OUTLINE_48_34_21 = {r = 48, g = 34, b = 21}
UI.FONT_COLOR_OUTLINE_68_58_50 = {r = 68, g = 58, b = 50}
UI.FONT_COLOR_OUTLINE_43_50_57 = {r = 43, g = 50, b = 57}
UI.FONT_COLOR_OUTLINE_20_40_60 = {r = 20, g = 40, b = 60}
UI.FONT_COLOR_OUTLINE_20_10_10 = {r = 20, g = 10, b = 10}

UI.FONT_COLOR_218_196_94 = {r = 218, g = 196, b = 94}
UI.FONT_COLOR_219_214_192 = {r = 219, g = 214, b = 192}
UI.FONT_COLOR_64_60_50 = {r = 64, g = 60, b = 50}
UI.FONT_COLOR_173_232_70 = {r = 173, g =232, b = 70}
UI.FONT_COLOR_236_184_72 = {r = 236, g =184, b = 72}

UI.FONT_COLOR_154_154_154 = {r = 154, g = 154, b = 154}
UI.FONT_COLOR_48_46_46 = {r = 48, g = 46, b = 46}
UI.FONT_COLOR_72_17_9 = {r = 72, g = 17, b = 9}
UI.FONT_COLOR_152_151_151 = {r = 152, g = 151, b = 151}

------称号颜色--------------------------------------------
UI.FONT_COLOR_TITLE_RARE_1 = {r = 255, g = 235, b = 192}
UI.FONT_COLOR_TITLE_RARE_2 = {r = 94, g = 173, b = 204}
UI.FONT_COLOR_TITLE_RARE_3 = {r = 239, g = 194, b = 85}
UI.FONT_COLOR_TITLE_RARE_4 = {r = 239, g = 132, b = 58}
UI.FONT_COLOR_TITLE_RARE_5 = {r = 178, g = 104, b = 189}
UI.FONT_COLOR_TITLE_RARE_6 = {r = 191, g = 48, b = 48}
UI.FONT_COLOR_OUTLINE_TITLE_HERO = {r = 44, g = 17, b = 17}

------怪物名字颜色----------------------------------------
UI.FONT_COLOR_185_68_49 = {r = 185, g = 68, b = 49}
UI.FONT_COLOR_179_105_32 = {r = 179, g = 105, b = 32}
UI.FONT_COLOR_161_144_63 = {r = 161, g = 144, b = 63}
UI.FONT_COLOR_53_95_31 = {r = 53, g = 95, b = 31}
UI.FONT_COLOR_105_105_105 = {r = 105, g = 105, b = 105}

------字体只有四种颜色（特殊字体除外）---------
UI.FONT_COLOR_94_64_25 = {r = 94, g = 64, b = 25}
UI.FONT_COLOR_41_41_45 = {r = 41, g = 41, b = 45}
UI.FONT_COLOR_63_51_33 = {r = 63, g = 51, b = 33}
UI.FONT_COLOR_211_195_150 = {r = 211, g = 195, b = 150}
UI.FONT_COLOR_250_229_177 = {r = 250, g = 229, b = 177}
UI.FONT_COLOR_255_0_0 = {r = 255, g = 0, b = 0}
UI.FONT_COLOR_77_77_84 = {r = 77, g = 77, b = 84}
UI.FONT_COLOR_131_129_129 = {r = 131, g = 129, b = 129}

UI.FONT_COLOR_248_242_204 = {r = 248, g = 242, b = 204}
UI.FONT_COLOR_248_248_248 = {r = 248, g = 248, b = 248}
UI.FONT_COLOR_214_214_214 = {r = 214, g = 214, b = 214}
UI.FONT_COLOR_247_227_209 = {r = 247, g = 227, b = 209}

UI.FONT_COLOR_255_216_81 = {r = 255, g = 216, b = 81}
UI.FONT_COLOR_242_200_219 = {r = 242, g = 200, b = 219}

UI.FONT_COLOR_192_185_255 = {r = 192, g = 182, b = 255}
UI.FONT_COLOR_183_189_223 = {r = 183, g = 189, b = 223}
------字体只有四种颜色（特殊字体除外）---------
---------------聊天界面 字体颜色--------------------
UI.FONT_COLOR_171_136_78 = {r = 171, g = 136, b = 78}
UI.FONT_COLOR_233_147_35 = {r = 233, g = 147, b = 35}
UI.FONT_COLOR_178_123_123 = {r = 178, g = 123, b = 123}

UI.FONT_COLOR_187_163_109 = {r = 187, g = 163, b = 109}
UI.FONT_COLOR_98_152_179 = {r = 98, g = 152, b = 179}
UI.FONT_COLOR_224_176_59 = {r = 224, g = 176, b = 59}
UI.FONT_COLOR_216_120_54 = {r = 216, g = 120, b = 54}
UI.FONT_COLOR_158_100_167 = {r = 158, g = 100, b = 167}
UI.FONT_COLOR_207_91_60 = {r = 207, g = 91, b = 60}
UI.FONT_COLOR_255_165_0 = {r = 255, g = 165, b = 0}
UI.FONT_COLOR_234_188_105 = {r = 234, g = 188, b = 105}
UI.FONT_COLOR_216_187_117 = {r = 216, g = 187, b = 117}
UI.FONT_COLOR_92_92_92 = {r = 92, g = 92, b = 92}
UI.FONT_COLOR_233_212_139 = {r = 233, g = 212, b = 139}
UI.FONT_COLOR_216_61_45 = {r = 216, g = 61, b = 45}

-- 服务器名字和延迟显示
UI.FONT_COLOR_18_191_42 = {r = 18, g = 191, b = 42}
UI.FONT_COLOR_252_185_0 = {r = 252, g = 185, b = 0}
UI.FONT_COLOR_255_24_0 = {r = 255, g = 24, b = 0}

-----------------滑块颜色----------------------
UI.SLIDER_COLOR_89_87_64 = {r = 89, g = 87, b = 64}
UI.SLIDER_COLOR_175_167_124 = {r = 175, g = 167, b = 124}
UI.SLIDER_COLOR_76_70_60 = {r = 76, g = 70, b = 60}
UI.SLIDER_COLOR_134_129_103 = {r = 134, g = 129, b = 103}
UI.SLIDER_COLOR_77_71_70 = {r = 77, g = 71, b = 70}

-----------------Boss直达----------------------
UI.FONT_COLOR_246_197_79 = {r = 246, g = 197, b = 79}
UI.FONT_COLOR_55_54_55 = {r = 55, g = 54, b = 55}

UI.FONT_COLOR_97_104_171 = {r = 97, g = 104, b = 171}
UI.FONT_COLOR_94_37_37 = {r = 94, g = 37, b = 37}
UI.FONT_COLOR_101_206_54 = {r = 101, g = 206, b = 54}

UI.FONT_COLOR_136_172_191 = {r = 136, g = 172, b = 191}
UI.FONT_COLOR_219_222_221 = {r = 219, g = 222, b = 221}

UI.FONT_COLOR_211_207_206 = {r = 211, g = 207, b = 206}
UI.FONT_COLOR_188_188_188 = {r = 188, g = 188, b = 188}

UI.FONT_COLOR_199_199_199 = {r = 199, g = 199, b = 199}

-- 绿色
UI.FONT_COLOR_128_201_36 = {r = 128, g = 201, b = 36}
UI.FONT_COLOR_38_123_7 = {r = 38, g = 123, b = 7}

-- 转生
UI.FONT_COLOR_205_202_186 = {r = 205, g = 202, b = 186}

-- 红色
UI.FONT_COLOR_231_38_38 = {r = 231, g = 38, b = 38}

-- 虫洞深处
UI.FONT_COLOR_117_213_255 = {r = 117, g = 213, b = 255}
UI.FONT_COLOR_202_171_67 = {r = 202, g = 171, b = 67}

-- 星盘
UI.FONT_COLOR_172_165_158 = {r = 172, g = 165, b = 158}
UI.FONT_COLOR_34_31_31 = {r = 34, g = 31, b = 31}
UI.FONT_COLOR_240_174_60 = {r = 240, g = 174, b = 60}   -- 生效buff名称
UI.FONT_COLOR_246_220_149 = {r = 246, g = 220, b = 149}     -- 生效等级
UI.FONT_COLOR_212_204_183 = {r = 212, g = 204, b = 183}     -- 未生效等级
UI.FONT_COLOR_26_26_26 = {r = 26, g = 26, b = 26}     -- buff描述
UI.FONT_COLOR_77_5_5 = {r = 77, g = 5, b = 5}     -- 解锁描述

-- 地图元素类型
UI.MAP_ELEMENT = {
    HERO = 1, -- 英雄
    MONSTER = 2, -- 怪物
    GOLD_BAG = 3, -- 金币
    TREASURE = 4, -- 宝箱
    RUNE = 5, -- 符文
    ENTRANCE = 6, -- 入口
    ALTER = 7, -- 祭坛
    STATUE = 8, -- 神像
    TRIGGER = 9, -- 触发器
    ROOM = 10 -- 密室
}

--key is gamedefine.lua 的 ChatMessageType
UI.CHAT_MESSAGE_TYPE_FONT_COLOR = {
    [1] = UI.FONT_COLOR_233_147_35,
    -- 系统消息
    [2] = UI.FONT_COLOR_WHITE,
    -- 队伍消息
    [3] = UI.FONT_COLOR_WHITE,
    -- 工会消息
    [4] = UI.FONT_COLOR_178_123_123,
    --  私聊消息
    [5] = UI.FONT_COLOR_WHITE,
    --附近消息
    [6] = UI.FONT_COLOR_171_136_78,
    --消息公告
    [7] = UI.FONT_COLOR_233_147_35,
    --队伍公告
    [8] = UI.FONT_COLOR_233_147_35,
    --工会公告
    [9] = UI.FONT_COLOR_233_147_35,
    --好友公告
    [10] = UI.FONT_COLOR_233_147_35,
    --工会成员公告
    [11] = UI.FONT_COLOR_233_147_35,
    --好友成员公告
    [12] = UI.FONT_COLOR_233_147_35,
    --附近公告
    [13] = UI.FONT_COLOR_233_147_35,
    --喇叭消息
    [14] = UI.FONT_COLOR_233_147_35
    --公会邀请消息
}

--key is quality
UI.ITEM_QUALITY_FONT_COLOR = {
    [1] = UI.FONT_COLOR_187_163_109,
    [2] = UI.FONT_COLOR_98_152_179,
    [3] = UI.FONT_COLOR_224_176_59,
    [4] = UI.FONT_COLOR_177_81_15, --[4] = UI.FONT_COLOR_216_120_54,
    [5] = UI.FONT_COLOR_158_100_167,
    [6] = UI.FONT_COLOR_207_91_60
}

-- 最上层的z序
UI.MAX_Z_ORDER = 10000

--按钮间隔发消息时间
UI.BUTTON_INTERVAL_TIME = 1000
