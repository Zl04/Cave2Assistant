--[[
    测试工具 其他页面 2017/11/22
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
local GMUtilPanelOther = class("GMUtilPanelOther", UI.GMUtilPanelBase)
UI.GMUtilPanelOther = GMUtilPanelOther
---------------------------------------
-- eo 模块初始化 --










-- 数据结构 --
---------------------------------------
-- 每一个方法返回一个 区块布局 和一个 Z序, 
-- getRowFuncs会返回这个数据结构, GMUtilPanelBase会根据返回的z值自动向上填充区块布局
local rowFuncs = {
    -- 账号显示区块 --
    contents.accountSectionFunc,
    contents.seperatorSectionFunc,
    -- 服务器账号切换区块 --
    contents.serverChangeSectionFunc,
    contents.seperatorSectionFunc,
    -- 动画测试区块 --
    contents.animationTestSection,
    contents.seperatorSectionFunc,
    -- 缓存清理区块 --
    contents.cacheCleanSectionFunc,
    contents.seperatorSectionFunc,
    -- UI管理区块 --
    contents.uiManagementSectionFunction,
    contents.seperatorSectionFunc,
    -- 其他区块 -- 
    contents.miscTitleSectionFunc,
    contents.miscSectionFunc,
    --文字显示检查
    contents.seperatorSectionFunc,
    contents.checkFontTextShow,
    -- 延迟模拟区块 --
    contents.latencySimSectionFunc,
    contents.seperatorSectionFunc,
    
    contents.jumpShopSectionFunc,
}
---------------------------------------
-- eo 数据结构 --











-- 程序逻辑 --
---------------------------------------
-- 返回楼层设置行
function GMUtilPanelOther:getRowsFuncs()
    return rowFuncs
end
---------------------------------------
-- eo 程序逻辑 --