--[[
    测试工具 洞窟页面 2017/11/22
    by CMonk
]]

-- 模块初始化 --
---------------------------------------
-- 引用
require "app.ui.gmUtil.panel.GMUtilPanelBase"

local contents = require("app.ui.gmUtil.panel.GMUtilPanelContents")

-- 引用UI命名空间
UI = UI or {}

-- 模块声明
local GMUtilPanelCave = class("GMUtilPanelCave", UI.GMUtilPanelBase)
UI.GMUtilPanelCave = GMUtilPanelCave
---------------------------------------
-- eo 模块初始化 --









-- 数据结构 --
---------------------------------------
-- 每一个方法返回一个 区块布局 和一个 Z序, 
-- getRowFuncs会返回这个数据结构, GMUtilPanelBase会根据返回的z值自动向上填充区块布局
local rowFuncs = {
    -- 楼层跳转区块 --
    contents.floorJumpSectionFunc,
    contents.seperatorSectionFunc,
    -- 世界Boss区块 --
    contents.worldBossSectionFunc,
    contents.seperatorSectionFunc,
    -- 怪物生成区块 --
    contents.monsterGenSectionFunc,
    contents.seperatorSectionFunc,
    -- 传送区块 --
    contents.blinkSectionFunc,
    contents.seperatorSectionFunc,
    -- 传送区块 --
    contents.dreamSectionFunc,
    contents.seperatorSectionFunc,
    -- 英雄模式词缀刷新区块 --
    contents.heroPropRefreshSectionFunc,
    contents.seperatorSectionFunc,
    -- 地图显示区块 --
    contents.mapDisplayTitleSectionFunc,
    contents.mapDisplaySectionFunc
}
---------------------------------------
-- eo 数据结构 --











-- 程序逻辑 --
---------------------------------------
-- 返回内容行配置
function GMUtilPanelCave:getRowsFuncs()
    return rowFuncs
end
---------------------------------------
-- eo 程序逻辑 --