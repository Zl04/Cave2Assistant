-- ReconnectWaitingLayer.lua
-- Using:加载效果

UI = UI or {}

local ReconnectWaitingLayer = class("ReconnectWaitingLayer", UI.Layout)
UI.ReconnectWaitingLayer = ReconnectWaitingLayer
local winSize = cc.Director:getInstance():getWinSize()
local WAITING_TIME = 5
require("utils.UIUtil")
local COM_RES_LIST = {
    "ui_common_information.plist",
}
-- 生命周期 --
---------------------------------------
-- 构造函数
function ReconnectWaitingLayer:ctor()
    ReconnectWaitingLayer.super.ctor(
        self, 
        UIType.TIPSTEST,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0)
end

function ReconnectWaitingLayer:createAnimation()
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

function ReconnectWaitingLayer:initWaiting(isSwallow, size, parent, idx, max)
    -- CO-12387【断线重连】断线重连后客户端表现优化
    parent = parent or cc.Director:getInstance():getRunningScene()
    
    local loadingPanel = UI.ReconnectWaitingLayer:create()
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
    text:centerUp(size.height / 2 +60)
    rootLayer:addChild(text)


    local waitingText = UI.Text:create()
    waitingText:init(string.format(UIUtil:lang(1112832), idx, max),UI.FONT_STANDARD,UI.FONT_SIZE_18PX)
    waitingText:centerUp(size.height / 2 + 40)
    rootLayer:addChild(waitingText)

    self.loadingPanel = loadingPanel
    return loadingPanel
end

-- [[显示全屏waiting 界面。 isSwallow 是否阻塞操作 默认false； parent：waiting的父节点 默认 uilayer; delayTime:延迟显示的时间，默认不延迟]]
function ReconnectWaitingLayer:showWaiting(isSwallow, parent, delayRemoveTime, idx, max)
    if self.loadingPanel then
        self:hideWaiting()
    end
    if isSwallow == nil then
        isSwallow = false
    end
    local loadingPanel = self:initWaiting(isSwallow, winSize, parent, idx, max)

    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        if self.hideWaiting then
            self:hideWaiting()
        end
    end, delayRemoveTime or WAITING_TIME)
    loadingPanel:center()
    return loadingPanel
end


function ReconnectWaitingLayer:hideWaiting()
    if self.loadingPanel and not tolua.isnull(self.loadingPanel) then
        self.loadingPanel:removeFromParent()
        self.loadingPanel = nil
    end
end


function ReconnectWaitingLayer:childrenShow()
    local children = self:getChildren()
    if(children and #children > 0) then
        for k,view in pairs(children) do 
            view:setVisible(true)
        end
    end
end

function ReconnectWaitingLayer:childrenHide()
    local children = self:getChildren()
    if(children and #children > 0) then
        for k,view in pairs(children) do 
            view:setVisible(false)
        end
    end
end

--文字 跳动动画
function ReconnectWaitingLayer:playTextAction()
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
