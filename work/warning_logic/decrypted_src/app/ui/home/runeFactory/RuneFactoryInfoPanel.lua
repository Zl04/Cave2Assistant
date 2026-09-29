--[[
    符文工房信息页面
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
local RuneFactoryInfoPanel = class("RuneFactoryInfoPanel", UI.HomeBaseInfoPanel)
UI.RuneFactoryInfoPanel = RuneFactoryInfoPanel

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
function RuneFactoryInfoPanel:ctor()
    RuneFactoryInfoPanel.super.ctor(self, UI.Type.GEM_FACTORY_INFO, resList, 0, 0)
end

-- 析构函数
function RuneFactoryInfoPanel:dtor()
    RuneFactoryInfoPanel.super.dtor(self)
end

-- 初始化
function RuneFactoryInfoPanel:init(hostLayer, width, height)
    RuneFactoryInfoPanel.super.init(self, hostLayer, width, height)
end

-- 初始化视图
function RuneFactoryInfoPanel:onInitView()
    RuneFactoryInfoPanel.super.onInitView(self)
end

-- 更新视图时
function RuneFactoryInfoPanel:onUpdateView()
    RuneFactoryInfoPanel.super.onUpdateView(self)
end
---------------------------------------
-- eo 生命周期 --






-- 通用逻辑 --
---------------------------------------
-- 重载父类函数, 获取配置表数据
function RuneFactoryInfoPanel:getConfigData()
    return HomeDataManager:getRuneFactoryData()
end

-- 重载父类函数, 获取等级标签
function RuneFactoryInfoPanel:getLvLabel()
    return LanguageManager:getInstance():getLocalString(1111506) --"工坊等级:"
end

-- 重载父类函数, 获取产出速度标签
function RuneFactoryInfoPanel:getSpeedLabel()
    return LanguageManager:getInstance():getLocalString(1111507) --"产出速度:"
end

-- 重载父类函数, 获取容量标签
function RuneFactoryInfoPanel:getSizeLabel()
    return LanguageManager:getInstance():getLocalString(1111508) --"工坊容量:"
end

-- 重载父类函数, 获取输出物品等级标签
function RuneFactoryInfoPanel:getOutputLevelLabel()
    return LanguageManager:getInstance():getLocalString(1113045) --"符文等级:"
end

-- 重载父类函数, 接收按钮回调, 传递给主窗口处理
function RuneFactoryInfoPanel:onClickRecvBtn()
    self._hostLayer:runCallback(UI.RUNE_FACTORY_CALLBACK_BTN_CLICK_RECEIVE_OUTPUT)
end

-- 重载父类函数, 获取下一次点击时间戳
function RuneFactoryInfoPanel:getNextRecvTimestamp()
    return cc.UserDefault:getInstance():getIntegerForKey("RUNE_FACTORY_RECV_NEXT_TIMESTAMP", 0)
end

-- 重载父类函数, 获取时间单位
function RuneFactoryInfoPanel:getUnitSymbol()
    return "d"
end
---------------------------------------
-- eo 通用逻辑 --





-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --