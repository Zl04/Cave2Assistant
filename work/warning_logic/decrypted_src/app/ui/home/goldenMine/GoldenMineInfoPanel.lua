--[[
    金矿信息页面
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.home.HomeBaseInfoPanel"
require "app.datas.HomeDataManager"

local LanguageManager = require("app.game.LanguageManager")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local GoldenMineInfoPanel = class("GoldenMineInfoPanel", UI.HomeBaseInfoPanel)
UI.GoldenMineInfoPanel = GoldenMineInfoPanel

-- 私有变量
local DEBUG_DRAW = false
---------------------------------------
-- eo 模块初始化 --






-- 资源统合 --
---------------------------------------
local COM_RES_LIST = {
}
---------------------------------------
-- eo 资源统合 --






-- 生命周期 --
---------------------------------------
-- 构造函数
function GoldenMineInfoPanel:ctor()
    GoldenMineInfoPanel.super.ctor(self, UI.Type.GOLDEN_MINE_INFO, resList, 0, 0)
end

-- 析构函数
function GoldenMineInfoPanel:dtor()
    GoldenMineInfoPanel.super.dtor(self)
end

-- 初始化
function GoldenMineInfoPanel:init(hostLayer, width, height)
    GoldenMineInfoPanel.super.init(self, hostLayer, width, height)
end

-- 初始化视图
function GoldenMineInfoPanel:onInitView()
    GoldenMineInfoPanel.super.onInitView(self)
end

-- 更新视图时
function GoldenMineInfoPanel:onUpdateView()
    GoldenMineInfoPanel.super.onUpdateView(self)
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
-- 重载父类函数, 获取配置表数据
function GoldenMineInfoPanel:getConfigData()
    return HomeDataManager:getGoldenMineData()
end

-- 重载父类函数, 获取等级标签
function GoldenMineInfoPanel:getLvLabel()
    return LanguageManager:getInstance():getLocalString(1111502) --"金矿等级:"
end

-- 重载父类函数, 获取产出速度标签
function GoldenMineInfoPanel:getSpeedLabel()
    return LanguageManager:getInstance():getLocalString(1111503) --"产出速度:"
end

-- 重载父类函数, 获取输出物品等级标签
function GoldenMineInfoPanel:getOutputLevelLabel()
    return "" --金矿没有此项
end

-- 重载父类函数, 获取容量标签
function GoldenMineInfoPanel:getSizeLabel()
    return LanguageManager:getInstance():getLocalString(1111505) --"金矿容量:"
end

-- 重载父类函数, 接收按钮回调, 传递给主窗口处理
function GoldenMineInfoPanel:onClickRecvBtn()
    self._hostLayer:runCallback(UI.GOLDEN_MINE_CALLBACK_BTN_CLICK_RECEIVE_OUTPUT)
end

-- 重载父类函数, 获取下一次点击时间戳
function GoldenMineInfoPanel:getNextRecvTimestamp()
    return cc.UserDefault:getInstance():getIntegerForKey("GOLDEN_MINE_RECV_NEXT_TIMESTAMP", 0)
end

-- 重载父类函数, 获取时间单位
function GoldenMineInfoPanel:getUnitSymbol()
    return "h"
end
---------------------------------------
-- eo 通用逻辑 --





-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --