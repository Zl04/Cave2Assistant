-- WaitingLayer.lua
-- Author:ydli
-- 2017年9月23日
-- Using:加载效果

UI = UI or {}

local WaitingLayer = class("WaitingLayer", UI.Layout)
UI.WaitingLayer = WaitingLayer
local winSize = cc.Director:getInstance():getWinSize()
local WAITING_TIME = 5
local COM_RES_LIST = {
    "ui_common_information.plist",
}-- 构造函数
function WaitingLayer:ctor()
    WaitingLayer.super.ctor(
        self, 
        UIType.TIPSTEST,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0)
end
-- [[显示定制尺寸 waiting 界面。 默认不阻塞] 这里创建一个完全自由控制的对象
function WaitingLayer:createWaitingWithSize(size, parent)
    assert(parent, "parent is not nil.")
    size = size or winSize

    local loadingPanel = UI.WaitingLayer:create()
    loadingPanel:init()
    loadingPanel:setTouchEnable(false)
    loadingPanel:setInterceptTouches(false)
    loadingPanel:setSize(size.width, size.height)
    parent:addChild(loadingPanel, UI_ZORDER.WAITING)

    local rootLayer = cc.LayerColor:create(cc.c4b(0,0,0,120))
    rootLayer:setContentSize(cc.size(size.width,size.height))
    rootLayer:setPosition(cc.p(0, 0))
    loadingPanel:addChild(rootLayer)

    local loading = self:createAnimation()
    loading:center()
    rootLayer:addChild(loading)


    local text = self:playTextAction()
    text:centerUp(size.height / 2 + 40)
    rootLayer:addChild(text)

    return loadingPanel
end

-- [[显示定制尺寸 waiting 界面, 这里用于页面内部处理表现加载状态。 默认不阻塞] 这里创建一个完全自由控制的对象
function WaitingLayer:createLittleWaitingWithSize(size, parent, alpha)
    assert(parent, "parent is not nil.")
    size = size or winSize
    alpha = alpha or 0
    local loadingPanel = UI.WaitingLayer:create()
    loadingPanel:init()
    loadingPanel:setTouchEnable(false)
    loadingPanel:setInterceptTouches(false)
    loadingPanel:setSize(size.width, size.height)
    parent:addChild(loadingPanel, UI_ZORDER.WAITING)

    local rootLayer = cc.LayerColor:create(cc.c4b(0,0,0,alpha))
    rootLayer:setContentSize(cc.size(size.width,size.height))
    rootLayer:setPosition(cc.p(0, 0))
    loadingPanel:addChild(rootLayer)

    local loading = self:createAnimation()
    loading:center()
    loadingPanel:addChild(loading)

    local text = self:playTextAction()
    if size.height > 140 then
        text:centerUp(size.height / 2 + 40)
    else
        text:centerUp(size.height / 2 + 20)
    end
    loadingPanel:addChild(text)

    return loadingPanel
end

function WaitingLayer:createAnimation()
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(0, 0)

    local fireImage = UI.Image:create()
    fireImage:init("ui_information_delay4.png")
    fireImage:center()
    contentLayout:addChild(fireImage)

    local littleCricle = UI.Image:create()
    littleCricle:init("ui_information_delay3.png")
    littleCricle:center()
    contentLayout:addChild(littleCricle)

    local ralateAction = cc.RotateBy:create(1, 360)
    local endAction = cc.RepeatForever:create(ralateAction)
    littleCricle:runAction(endAction)

    return contentLayout
end


--构造函数(必备)
-- 构造函数

function WaitingLayer:initWaiting(isSwallow, size, parent)
    parent = parent or UI.UIManager:getRootNode()
    
    local loadingPanel = UI.WaitingLayer:create()
    loadingPanel:init()
    loadingPanel:setTouchEnable(isSwallow)
    loadingPanel:setInterceptTouches(isSwallow)
    loadingPanel:setSize(size.width, size.height)
    parent:addChild(loadingPanel, UI_ZORDER.WAITING)

    local rootLayer = cc.LayerColor:create(cc.c4b(0,0,0,120))
    rootLayer:setContentSize(cc.size(size.width,size.height))
    rootLayer:setPosition(cc.p(0, 0))
    loadingPanel:addChild(rootLayer)

    local loading = self:createAnimation()
    loading:center()
    rootLayer:addChild(loading)

    local text = self:playTextAction()
    text:centerUp(size.height / 2 + 40)
    rootLayer:addChild(text)
    self.loadingPanel = loadingPanel
    return loadingPanel
end

-- [[显示全屏waiting 界面。 isSwallow 是否阻塞操作 默认false； parent：waiting的父节点 默认 uilayer; delayTime:延迟显示的时间，默认不延迟]]
function WaitingLayer:showWaiting(isSwallow, parent, delayTime,delayRemoveTime)
    if self.loadingPanel then
        self:hideWaiting()
    end
    if isSwallow == nil then
        isSwallow = false
    end
    local loadingPanel = self:initWaiting(isSwallow, winSize, parent)

    if(delayTime and type(delayTime) == "number") then 
        loadingPanel:childrenHide()
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            if(loadingPanel and not tolua.isnull(loadingPanel)) then
                loadingPanel:childrenShow()
            end
        end, delayTime)
    end

    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        if self.hideWaiting then
            self:hideWaiting()
        end
    end, delayRemoveTime or WAITING_TIME)
    loadingPanel:center()
    return loadingPanel
end

-- [[显示定制尺寸 waiting 界面。 默认不阻塞]
function WaitingLayer:showWaitingWithSize(size, parent)
    if self.loadingPanel then
        self:hideWaiting()
    end
    size = size or winSize
    return self:initWaiting(false, size, parent)
end

function WaitingLayer:hideWaiting()
    if self.loadingPanel and not tolua.isnull(self.loadingPanel) then
        self.loadingPanel:removeFromParent()
        self.loadingPanel = nil
    end
end

function WaitingLayer:delayShow(delayTime)
    self:setVisible(true)
    if(delayTime and type(delayTime) == "number") then 
        self:childrenHide()
        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            if(self and not tolua.isnull(self)) then
                self:childrenShow()
            end
        end, delayTime)
    end
end

function WaitingLayer:childrenShow()
    local children = self:getChildren()
    if(children and #children > 0) then
        for k,view in pairs(children) do 
            view:setVisible(true)
        end
    end
end

function WaitingLayer:childrenHide()
    local children = self:getChildren()
    if(children and #children > 0) then
        for k,view in pairs(children) do 
            view:setVisible(false)
        end
    end
end

--文字 跳动动画
function WaitingLayer:playTextAction()
    local index = 1
    local textList = {
        [1] = "loading",
        [2] = "loading.",
        [3] = "loading..",
        [4] = "loading...",
    }
    local text = UI.Text:create()
    text:init("loading...",UI.FONT_STANDARD,UI.FONT_SIZE_18PX)
    text:setSize(80, 50)
    text:setTextLeft()
    local playCallFunc = function()
        text:setText(textList[index])
        index = index + 1
        if index > #textList then
            index = 1
        end
    end
    local sequence = cc.Sequence:create(cc.CallFunc:create(playCallFunc), cc.DelayTime:create(0.2))
    text:runAction(cc.RepeatForever:create(sequence))   
    return text
end
