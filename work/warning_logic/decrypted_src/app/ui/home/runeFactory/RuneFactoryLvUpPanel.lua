--[[
    符文工房信息页面
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.home.HomeBaseLvUpPanel"
require "app.datas.HomeDataManager"

local LanguageManager = require("app.game.LanguageManager")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local RuneFactoryLvUpPanel = class("RuneFactoryLvUpPanel", UI.HomeBaseLvUpPanel)
UI.RuneFactoryLvUpPanel = RuneFactoryLvUpPanel

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
function RuneFactoryLvUpPanel:ctor()
    RuneFactoryLvUpPanel.super.ctor(self, UI.Type.GEM_FACTORY_LVUP, resList, 0, 0)
end

-- 析构函数
function RuneFactoryLvUpPanel:dtor()
    RuneFactoryLvUpPanel.super.dtor(self)
end

-- 初始化
function RuneFactoryLvUpPanel:init(hostLayer, width, height)
    RuneFactoryLvUpPanel.super.init(self, hostLayer, width, height)
end

-- 初始化视图
function RuneFactoryLvUpPanel:onInitView()
    RuneFactoryLvUpPanel.super.onInitView(self)
end

-- 更新视图时
function RuneFactoryLvUpPanel:onUpdateView()
    RuneFactoryLvUpPanel.super.onUpdateView(self)
end
---------------------------------------
-- eo 生命周期 --







-- 通用逻辑 --
---------------------------------------
-- 重载父类, 获取配置数据
function RuneFactoryLvUpPanel:getConfigData()
    return HomeDataManager:getRuneFactoryData()
end

-- 重载父类, 升级按钮点击回调
function RuneFactoryLvUpPanel:onClickLvUpBtn()
    local configData = self:getConfigData()
    local outputLevel = configData:getCurrentOutputLevel()
    local nextOutputLevel = configData:getNextLevelOutputLevel()
    local currentAmount = configData:getCurrentSize()
    if (currentAmount and currentAmount >= 1 and outputLevel and nextOutputLevel and outputLevel ~= nextOutputLevel) then
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1113048))
    end
    self._hostLayer:runCallback(UI.RUNE_FACTORY_CALLBACK_BTN_CLICK_LVUP)
end

-- 重载父类, 获取单位字符
function RuneFactoryLvUpPanel:getUnitSymbol()
    return "d"
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --