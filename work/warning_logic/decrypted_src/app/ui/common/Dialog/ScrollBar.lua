--[[
    信息提示滚动条，从下到上滚动。
]]

local LanguageManager = require("app.game.LanguageManager")
require "app.ui.Component"
require "utils.Queue"

UI = UI or {}

local ScrollBar = class("ScrollBar", UI.HWBtnComponent)
UI.ScrollBar = ScrollBar
local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()

-- private:
local DEBUG = false
local DEBUG_DRAW = true
local space_time = 300--ms

-- 上一次播放时间
local PRE_SCROLL_BAR_TIME = 0

-- 尺寸
local COM_WIDTH = 0
local COM_HEIGHT = 0
-- 资源
local COM_RES_LIST = {
}

local scheduler = cc.Director:getInstance():getScheduler()

-- 构造函数
function ScrollBar:ctor()
    ScrollBar.super.ctor(self, UIType.SCROLL_BAR, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self._text = nil
    self._showNode = nil

    self.isTraveling = false

    Avalon.MessageCenter:bind(AvalonMessage.MC_NOTICE_MESSAGE_TRAVEL, self, self.tryTravel)
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self, self.update), 0, false)
end

-- 析构函数
function ScrollBar:dtor()
    self._text = nil
    self._showNode = nil
    ScrollBar.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_NOTICE_MESSAGE_TRAVEL, self, self.tryTravel)
    if self.schedulerID then
        scheduler:unscheduleScriptEntry(self.schedulerID)
    end
end

function ScrollBar:tryTravel(pScrollBar)
    if not tolua.isnull(self) and self ~= pScrollBar then
        self:travel();
    end
end

function ScrollBar:travel()
    self.isTraveling = true
    self.currentTravelingTime = 0;
    if self.startTravelPos ~= nil then
        local pos = cc.p(self.startTravelPos.x, self.startTravelPos.y)
        pos.y = pos.y + self.moveDistances
        self:setPosition(pos.x, pos.y)
    end
    self.startTravelPos = cc.p(self:getPositionX(), self:getPositionY());
end

function ScrollBar:update(dtt)
    if self.isTraveling then
        self.currentTravelingTime = self.currentTravelingTime + dtt
        local step = self.currentTravelingTime / 0.2
        if step > 1 then
            step = 1
            self.isTraveling = false
        end
        local y = self.startTravelPos.y;
        y = y + step *self.moveDistances;
        self:setPosition(self.startTravelPos.x, y)
    end
end

-- public:
-- 初始化
function ScrollBar:init(text)
    if (text) then assert("Text Value is Null") end
    self._text = text
    ScrollBar.super.init(self)
end

function ScrollBar:initWithNode(node)
    self._showNode = node
    self._showNode:retain()
    ScrollBar.super.init(self)
end

-- 初始化视图
function ScrollBar:onInitView()
    if self._showNode then
        self:initViewWithNode()
    else
        self:initViewWithText()
    end
end

function ScrollBar:initViewWithNode()
    self:addChild(self._showNode)
    self._showNode:release()
    if (self._showNode.__isComponent__) then
        self._showNode:center(0, 0)
    else
        self._showNode:setAnchorPoint(0, 0)
        self._showNode:setPosition(0, 0)
    end
    local contentSize = self._showNode:getContentSize()
    self:setSize(contentSize.width, contentSize.height)
end

function ScrollBar:initViewWithText()
 
    local color = cc.c4b(0, 0, 0, 255)
    local fontColor = cc.c3b(248, 240, 210)
    local  goodsName  = cc.Label:createWithSystemFont(self._text, UI.SYS_FONT, 30)
    goodsName:setDimensions(winSize.width - 300, 0)
    goodsName:setTextColor(fontColor)
    goodsName:enableOutline(color, 2);
    goodsName:enableShadow(color, cc.size(0, -2))
    self:addChild(goodsName ,1)
    goodsName:setAlignment(UI.TextHAlignment.CENTER, UI.TextVAlignment.CENTER)
    goodsName:setAnchorPoint(0, 0)
    goodsName:setPosition(0, 0)
    local contentSize = goodsName:getContentSize()
    self:setSize(contentSize.width, contentSize.height)

end

-- 更新视图
function ScrollBar:onUpdateView()

end

--创建飘窗
function ScrollBar:createByText(text)
    require("app.ui.UIManager")
    local pScrollBar = self:_createByText(text)
    return pScrollBar
end

--创建飘窗
function ScrollBar:createByTextWithDelay(text, delay)
    require("app.ui.UIManager")
    local pScrollBar = self:_createByText(text, delay)
    return pScrollBar
end

--通过语言ID创建飘窗
function ScrollBar:createByTextID(id)
    require("app.ui.UIManager")
    if id == nil or id == 0 then
        return
    end
    local pScrollBar = self:_createByText(LanguageManager:getInstance():getLocalString(id))
    return pScrollBar
end

--通过错误ID创建飘窗
function ScrollBar:createByErrorID(id)
    require("app.ui.UIManager")
    local pScrollBar = self:_createByText(LanguageManager:getInstance():getLocalString(1170000 + tonumber(id)))
    return pScrollBar
end

--私有函数 TODO 处理同时弹出 多个相互遮挡bug
function ScrollBar:_createByText(text, delay)
    -- print("ScrollBar:_createByText -- 1 UI.scrollBarQueue:size()  = ", UI.scrollBarQueue:size())
    -- 这里处理切换场景带来的消息停滞
    if(PRE_SCROLL_BAR_TIME < AvalonUtil.getCurrentTime() - space_time) then 
        UI.lockScrollBarQueue = false
    end

    return self:showByText(text, delay)
end

function ScrollBar:showByText(text, delay)
    PRE_SCROLL_BAR_TIME = AvalonUtil.getCurrentTime()
    local pScrollBar = UI.ScrollBar:create()
    pScrollBar:init(text)
    ScrollBar.start(pScrollBar, delay)

    return pScrollBar
end

function ScrollBar:createWithNode(node)
    local pScrollBar = UI.ScrollBar:create()
    pScrollBar:initWithNode(node)
    pScrollBar:center()
    ScrollBar.start(pScrollBar)
    return pScrollBar
end

function ScrollBar.start(pScrollBar, delay)
    pScrollBar:center()
    UI.UIManager:getRootNode():addChild(pScrollBar, UI_ZORDER.SCROLLBAR)
    local height = pScrollBar:getContentSize().height;
    if height == 0 then
        --height = 40
    end
    pScrollBar.moveDistances = height + 5
    pScrollBar:setVisible(false)
    Avalon.MessageCenter:notice(AvalonMessage.MC_NOTICE_MESSAGE_TRAVEL, pScrollBar)
    --pScrollBar:setScale(0.7)
    local delayTime0 = cc.DelayTime:create(0.1)
    local show = cc.ScaleTo:create(0.1, 1.2)
    local show2 = cc.ScaleTo:create(0.1, 1)
    local delayTime = cc.DelayTime:create(delay or 2)
    local dispper = cc.FadeOut:create(0.5)
    pScrollBar:runAction(cc.Sequence:create(delayTime0, cc.CallFunc:create(function()
        pScrollBar:setVisible(true);
    end),
    show, show2, delayTime, dispper, cc.CallFunc:create(function()
        pScrollBar:removeFromParent();
    end)))
end

function ScrollBar:push(text)
    UI.scrollBarQueue:push(text)
end

function ScrollBar:pop()
    return UI.scrollBarQueue:front()
end