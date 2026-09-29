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
local GMUtilPanelEffect = class("GMUtilPanelEffect", UI.GMUtilPanelBase)
UI.GMUtilPanelEffect = GMUtilPanelEffect
---------------------------------------
-- eo 模块初始化 --









-- 数据结构 --
---------------------------------------
-- 每一个方法返回一个 区块布局 和一个 Z序, 
-- getRowFuncs会返回这个数据结构, GMUtilPanelBase会根据返回的z值自动向上填充区块布局
local rowFuncs = {
    -- 属性变化区块 --
    contents.attrSectionFunc,
    -- 人物数据区块
    contents.printMasterPropsSectionFunc,
    contents.seperatorSectionFunc,
    -- 无敌, CD区块 --
    contents.heroAndSkillStatusSectionFunc,
    contents.seperatorSectionFunc,
    -- 成就区块 --
    contents.achievementSectionFunc,
}
---------------------------------------
-- eo 数据结构 --











-- 程序逻辑 --
---------------------------------------
-- 返回楼层设置行
function GMUtilPanelEffect:getRowsFuncs()
    return rowFuncs
end
---------------------------------------
-- eo 程序逻辑 --
