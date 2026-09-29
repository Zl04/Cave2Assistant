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
local GMUtilPanelItem = class("GMUtilPanelItem", UI.GMUtilPanelBase)
UI.GMUtilPanelItem = GMUtilPanelItem
---------------------------------------
-- eo 模块初始化 --









-- 数据结构 --
---------------------------------------
-- 每一个方法返回一个 行布局 和一个 Z序, 
-- getRowFuncs会返回这个数据结构, GMUtilPanelBase会根据返回的z值自动向上填充行布局
local rowFuncs = {
	-- 货币经验钻石区块标题 --
	contents.currenciesAndExpTitleSectionFunc,
	contents.goldSectionFunc,
	contents.diamondSectionFunc,
	contents.expSectionFunc,
	contents.seperatorSectionFunc,
	-- 装备道具材料区块 --
	contents.itemsTitleSectionFunc,
	contents.itemsSectionFunc,
	contents.allItemsSectionFunc,
	contents.seperatorSectionFunc,
	-- 装备道具材料区块 --
	contents.oneTouchOperationSectionFunc,
	contents.oneTouchSectionFunc,
	contents.seperatorSectionFunc,
	-- 掉落测试区块 --
    contents.dropTestTitleSectionFunc,
    contents.dropTestSectionFunc,
    contents.seperatorSectionFunc,
}
---------------------------------------
-- eo 数据结构 --











-- 程序逻辑 --
---------------------------------------
-- 返回楼层设置行
function GMUtilPanelItem:getRowsFuncs()
    return rowFuncs
end
---------------------------------------
-- eo 程序逻辑 --