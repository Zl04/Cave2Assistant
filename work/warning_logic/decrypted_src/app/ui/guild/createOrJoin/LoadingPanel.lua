-- LoadingPanel.lua
-- Author:zp
-- 2017年9月23日
-- Using:加载效果

UI = UI or {}

local LoadingPanel = class("LoadingPanel", UI.HWBtnComponent)
UI.LoadingPanel = LoadingPanel

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_town_guild_general.plist",
}

--构造函数(必备)
function LoadingPanel:ctor()
	--窗口大小
    LoadingPanel.super.ctor(
    self,UIType.LOADING_PANEL,
    COM_RES_LIST,
    LAYOUT_DESIGN_WIDTH,	
    LAYOUT_DESIGN_HEIGHT
    )

    -- self:setTouchEnable(true);
    -- self:setInterceptTouches(true);

    self:init()
end

--虚构函数,destroy时调用(必备)
function LoadingPanel:dtor()
    LoadingPanel.super.dtor(self)
end

-- 初始化(必备)
function LoadingPanel:init()
    LoadingPanel.super.init(self)
end


-- 模版函数：初始化组建的视图(必备)
function LoadingPanel:onInitView()
    -- 内容面板
    local littleCricle = UI.Image:create()
    littleCricle:init("ui_guild_icon_counterclockwise.png")
    littleCricle:center()
    self:addChild(littleCricle)

    local bigCricle = UI.Image:create()
    bigCricle:init("ui_guild_icon_clockwise.png")
    bigCricle:center()
    self:addChild(bigCricle)
    bigCricle:setImageRotation(180)

    local ralateAction = cc.RotateBy:create(1, 360)
    local endAction = cc.RepeatForever:create(ralateAction)
    bigCricle:runAction(endAction)

    local ralateBackAction = cc.RotateBy:create(1, -360)
    local endBackAction = cc.RepeatForever:create(ralateBackAction)
    littleCricle:runAction(endBackAction)
end

-- 模版函数：更新组建的视图(必备)
function LoadingPanel:onUpdateView()
    
end