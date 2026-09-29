--[[
    网络相关的宏定义
]]--

Net = Net or {}

-- 网络连接编号
Net.MAIN_SERVER = 1
Net.CHAT_SERVER = 2

Net.MAIN_TEXT_SERVER = 3
Net.MAIN_TEXT_SERVER2 = 4

-- 消息的定向
Net.Direction = {
    NONE = 0,
    CV = 1,     -- 验证
    CG = 2,     -- gate
    CD = 3,     -- 数据服
    CS = 4,     -- 游戏服
    CO = 5,     -- 社交服
    CR = 6,     -- 排行榜
    CI = 7,     -- 内购服务器
    VC = 32,    
    GC = 33,
    AC = 34,
    SC = 35,
    S2S = 64
}
NetDirection = Net.Direction

-- 消息功能分段(模块)
Net.Section = {
    MIN = 0,
    INNER_SYSTEM = 1,
    LOGIN_SYSTEM = 2,
    ROLE_SYSTEM = 3,
    GOODS_SYSTEM = 4,
    NPC_SYSTEM = 5,
    TEAM_SYSTEM = 6,
    TASK_SYSTEM = 7,
    TREASUREMAP_SYSTEM = 8,
    GM_SYSTEM = 9,
    RANK_SYSTEM = 10,
    GUILD_SYSTEM = 11,
    CHAT_SYSTEM = 12,
    FRIEND_SYSTEM = 13,
    COMMON_SYSTEM = 14,
    MAIL_SYSTEM = 15,
    PURCHASE_SYSTEM = 16,
    ACTIVITY_SYSTEM = 17,
	LOG_SYSTEM = 18,
    MENTOR_SYSTEM = 19,
    LOGIC_SYSTEM = 20,
    PET_SYSTEM = 21,
    PLAY_SYSTEM = 22,
    MANOR_SYSTEM = 23,
    BIGSAIL_SYSTEM = 24,
    MAX = 25,
};
NetSection = Net.Section

-- 数据包中的字段名
Net.PackField = {
    CONNID = "connid",
    DIRECTION = "dir",
    SECTION = "sec",
    NO = "no",
    HEAD = "proto",
    BODY = "data"
}
NetPackField = Net.PackField

-- 消息定义
require "utils.net.NetMessage"