--[[
    测试工具 所有页面 2017/11/22
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
local GMUtilPanelFrequentUse = class("GMUtilPanelFrequentUse", UI.GMUtilPanelBase)
UI.GMUtilPanelFrequentUse = GMUtilPanelFrequentUse
---------------------------------------
-- eo 模块初始化 --









-- 数据结构 --
---------------------------------------
-- 每一个方法返回一个 区块布局 和一个 Z序, 
-- getRowFuncs会返回这个数据结构, GMUtilPanelBase会根据返回的z值自动向上填充区块布局
local rowFuncs = {
    -- 仿老排版简化跳楼方法 --
    contents.simpleFloorJumpSectionFunc,

    -- 金币, 钻石, 经验 --
    contents.expSectionFunc,
    contents.goldSectionFunc,
    contents.diamondSectionFunc,

    -- 物品生成 --
    contents.spaceSectionFunc,
    contents.itemsSectionFunc,
    contents.spaceSectionFunc,

    -- 仿老排版简化人物属性方法 --
    contents.simpleAttrSectionFunc,

    -- 功能解锁开关 --
    contents.systemUnlockSectionFunc,

    -- 地图显示 --
    contents.mapDisplaySectionFunc,

    -- 生成怪物 --
    contents.monsterGenSectionFunc,

    -- 服务器跳转 --
    contents.serverChangeSectionFunc,
}
---------------------------------------
-- eo 数据结构 --











-- 程序逻辑 --
---------------------------------------
-- 对行外观做微调
function GMUtilPanelFrequentUse:modifyRowLayout(idx, layout)
    -- layout:enableDebugDraw()
    layout:setPadding(0, 0, 10, 10)
end

-- 返回内容行配置
function GMUtilPanelFrequentUse:getRowsFuncs()
    return rowFuncs
end
---------------------------------------
-- eo 程序逻辑 --