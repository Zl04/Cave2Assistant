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
local GMUtilPanelProgress = class("GMUtilPanelProgress", UI.GMUtilPanelBase)
UI.GMUtilPanelProgress = GMUtilPanelProgress
---------------------------------------
-- eo 模块初始化 --











-- 数据结构 --
---------------------------------------
-- 每一个方法返回一个 区块布局 和一个 Z序, 
-- getRowFuncs会返回这个数据结构, GMUtilPanelBase会根据返回的z值自动向上填充区块布局
local rowFuncs = {
    -- 解锁区块 --
    contents.systemUnlockTitleSectionFunc,
    contents.systemUnlockSectionFunc,
    contents.seperatorSectionFunc,
    -- 模式和难度区块 --
    contents.modeAndDifficultySectionFunc,
    contents.seperatorSectionFunc,
    -- 任务完成区块 --
    contents.questCompleteSectionFunc,
    contents.seperatorSectionFunc,
    -- 任务区块 --
    contents.questAchievementCollectionSectionFunc,
    -- 功能属性 --
    contents.functionAttrContent
}
---------------------------------------
-- eo 数据结构 --












-- 程序逻辑 --
---------------------------------------
-- 返回楼层设置行
function GMUtilPanelProgress:getRowsFuncs()
    return rowFuncs
end
---------------------------------------
-- eo 程序逻辑 --