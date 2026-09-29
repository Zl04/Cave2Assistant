--[[
    城镇任务界面  只创建一个背景 
]]

UI = UI or {}
require "app.ui.CommonBgLayer"
local TownTaskLayerUI = class("TownTaskLayerUI", UI.DownShowWin)
UI.TownTaskLayerUI = TownTaskLayerUI


-- private:
local winSize = cc.Director:getInstance():getWinSize()
-- 尺寸
local COM_WIDTH = 920
local COM_HEIGHT = 640
---------------------------------------
-- -- 设计尺寸
-- local LAYOUT_DESIGN_WIDTH = 1136
-- local LAYOUT_DESIGN_HEIGHT = 640

-- 背包资源
local COM_RES_LIST_BAG = {
}

-- 构造函数
function TownTaskLayerUI:ctor(spriteID, type)
    TownTaskLayerUI.super.ctor(self, UIType.TOWN_TASK_LAYER_UI, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self._spriteID  = spriteID;
end

-- 析构函数
function TownTaskLayerUI:dtor()
    TownTaskLayerUI.super.dtor(self)
    self:unRegisterListener()
end

-- public:
-- 初始化
function TownTaskLayerUI:init()
    TownTaskLayerUI.super.init(self)
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()

    -- local scaleX = winSize.width / LAYOUT_DESIGN_WIDTH
    -- local scaleY = winSize.height / LAYOUT_DESIGN_HEIGHT
    -- local scale = scaleX > scaleY and scaleY or scaleX
    -- if (scale > 1.0) then scale = 1.0 end
    -- self:setScale(scale)
    local bg = UI.CommonBgLayer:create(false, false)
    bg:center()
    self:addChild(bg)

    local title1 = UI.Image:create()
    title1:init("ui_task_icon_head.png")
    title1:centerUp(17)
    self:addChild(title1, 100)

    -- 添加背景
    local bg2 =  cc.Scale9Sprite:createWithSpriteFrameName("ui_bg_paper2.png", CCRectMake(303,136,4,2))
    bg2:setContentSize(852, 534)
    bg2:setAnchorPoint(0, 0)
    bg2:setPosition(33, 25)
    self:addChild(bg2)
end

function TownTaskLayerUI:onInitView()
    local taskLayerUI = UI.TaskLayerUI:create(self._spriteID, UI.TaskLayerType.TASKLAYER_TOWN)
    taskLayerUI:init()
    taskLayerUI:leftBottom(20, 19)
    self:addChild(taskLayerUI, 5)
end

-- 更新视图
function TownTaskLayerUI:onUpdateView()
    
end



-- 注册监听事件(可选)
function TownTaskLayerUI:registerListener()
    --刷新按钮解锁状态
end


-- 注销监听事件(可选)
function TownTaskLayerUI:unRegisterListener()
    -- 角色信息更新，其他的英雄
end

function TownTaskLayerUI:choiceTabIndex(tabIndex)
    
end

function TownTaskLayerUI:openShow()
    self:open()
end