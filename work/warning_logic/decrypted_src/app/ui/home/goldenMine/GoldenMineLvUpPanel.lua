--[[
    金矿信息页面
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
local GoldenMineLvUpPanel = class("GoldenMineLvUpPanel", UI.HomeBaseLvUpPanel)
UI.GoldenMineLvUpPanel = GoldenMineLvUpPanel

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
function GoldenMineLvUpPanel:ctor()
    GoldenMineLvUpPanel.super.ctor(self, UI.Type.GOLDEN_MINE_LVUP, resList, 0, 0)
end

-- 析构函数
function GoldenMineLvUpPanel:dtor()
    GoldenMineLvUpPanel.super.dtor(self)
end

-- 初始化
function GoldenMineLvUpPanel:init(hostLayer, width, height)
    GoldenMineLvUpPanel.super.init(self, hostLayer, width, height)
end

-- 初始化视图
function GoldenMineLvUpPanel:onInitView()
    GoldenMineLvUpPanel.super.onInitView(self)
end

-- 更新视图时
function GoldenMineLvUpPanel:onUpdateView()
    GoldenMineLvUpPanel.super.onUpdateView(self)
end
---------------------------------------
-- eo 生命周期 --







-- 通用逻辑 --
---------------------------------------
-- 重载父类, 获取配置数据
function GoldenMineLvUpPanel:getConfigData()
    return HomeDataManager:getGoldenMineData()
end

-- 重载父类, 升级按钮点击回调
function GoldenMineLvUpPanel:onClickLvUpBtn()
    self._hostLayer:runCallback(UI.GOLDEN_MINE_CALLBACK_BTN_CLICK_LVUP)
end

-- 重载父类, 获取单位字符
function GoldenMineLvUpPanel:getUnitSymbol()
    return "h"
end
---------------------------------------
-- eo 通用逻辑 --







-- 事件处理 --
---------------------------------------
---------------------------------------
-- eo 事件处理 --