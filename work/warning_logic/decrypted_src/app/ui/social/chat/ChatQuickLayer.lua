-- ChatQuickLayer.lua
-- Author:ydli
-- 2017年09月11日
-- Using:快捷聊天界面
UI = UI or {}
local ChatQuickLayer = class("ChatQuickLayer", UI.Component)
UI.ChatQuickLayer = ChatQuickLayer

require "app.ui.social.chat.ChatDialogLayer"
require "app.ui.common.CheckBox"
require "utils.VoiceChatManager"

local winSize = cc.Director:getInstance():getWinSize()
local size = cc.size(480, 140)
-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_chat.plist",
}

g_chatQuickLayer = nil

----表情界面
--构造函数(必备)
function ChatQuickLayer:ctor(spriteID)
    -- print("------------------ChatQuickLayer:ctor")
    --窗口大小
    ChatQuickLayer.super.ctor(
    self,UIType.CHAT_QUICK_LAYER,
    COM_RES_LIST,
    size.width,    
    size.height
    )
    self.rootLayer = nil          --root节点
    self.recoverPosX = 0
    self.recoverPosY = 0
    self.disableClick = false --是否响应点击（解决动画过程做的点击）
    self.messageList = {}
    self:init()
    self:registerListener()
    self:refreshView()
end

--虚构函数,destroy时调用(必备)
function ChatQuickLayer:dtor()
    g_chatQuickLayer = nil
end

function ChatQuickLayer:getInstance()
    if g_chatQuickLayer == nil then
        return self:recycle()
    end
    return g_chatQuickLayer
end

function ChatQuickLayer:isInit()
    return g_chatQuickLayer ~= nil
end

function ChatQuickLayer:purgeInstance()
    if g_chatQuickLayer ~= nil then
        g_chatQuickLayer = nil
    end
end

function ChatQuickLayer:recycle()
    if g_chatQuickLayer == nil then
        g_chatQuickLayer = ChatQuickLayer:create()
        g_chatQuickLayer:setName("ChatQuickLayer")
        g_chatQuickLayer:retain()
    else
        g_chatQuickLayer:removeFromParent(false)
        g_chatQuickLayer:removeChildByName("TALK_TIP")
        g_chatQuickLayer:updateView()
        -- g_chatQuickLayer:removeChildByName("INFO_AREA")
    end
    return g_chatQuickLayer
end

-- 初始化(必备)
function ChatQuickLayer:init()
    -- print("------------------ChatQuickLayer:init")
    ChatQuickLayer.super.init(self)
    self:setToCacheTexture(true)
end

-- 模版函数：初始化组建的视图(必备)
function ChatQuickLayer:onInitView()
    --root节点
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init(0,0,0,0)
    self.rootLayer:setContentSize(size.width, size.height)
    self.rootLayer:leftBottom(0,0)
    self:addChild(self.rootLayer)

    --bg 
    local centerBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_chat_mask_base.png")
    centerBg:setContentSize(460, 150)
    centerBg:setCapInsets(CCRectMake(160,16,1,1))
    centerBg:setPosition(cc.p(0, 0))
    centerBg:setAnchorPoint(0, 0)
    self.rootLayer:addChild(centerBg, 1)
    self.centerBg = centerBg

    --btn
    local expandBtn = UI.Button:create()
    expandBtn:init("ui_btn_arrow_up_0.png", "ui_btn_arrow_up_1.png", "ui_btn_arrow_up_2.png")
    expandBtn:rightUp(20, 8)
    self.rootLayer:addChild(expandBtn, 10)
    expandBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:expandClick()
    end)
    self.expandBtn = expandBtn
    self.expandBtn:setScaleY(1)

    local redPoint = AvalonUtil.createRedPoint(self.rootLayer, 5, 5, 20)
    redPoint:hide()
    redPoint:leftUp(18, -3)
    self.redPoint = redPoint
    if Game.ChatManager:getInstance():isShowRedPoint(ChatChannelType.PERSONAL) then
        redPoint:show()
    end
end


-- 模版函数：更新组建的视图(必备)
function ChatQuickLayer:onUpdateView()
end


-- 注册监听事件(可选)
function ChatQuickLayer:registerListener()
    Avalon.MessageCenter:bind(AvalonMessage.MC_CHAT_QUICK_CHAT_REFRESH, self, self.updateView)
end


-- 注销监听事件(可选)
function ChatQuickLayer:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_CHAT_QUICK_CHAT_REFRESH, self, self.updateView)
end

-- 点击外部区域的处理器(关闭)(可选)
function ChatQuickLayer:onTouchDialogOutsizeHandler()
end

function ChatQuickLayer:onOpenMainChatClick()
    if self.disableClick then
        print("----ChatQuickLayer:expandClick() onOpenMainChatClick is true")
        return
    end
    self.redPoint:hide()
    Avalon.MessageCenter:notice(GameMessage.MC_CHAT_OPEN_MAIN_CHAT)
end

function ChatQuickLayer:showMessage(data)
    self.messageList = {}
    table.insert(self.messageList, data)
    self:refreshView()
    if Game.ChatManager:getInstance():isShowRedPoint(ChatChannelType.PERSONAL) and UI.ChatMainLayer:getInstance():isHide() then
        self.redPoint:show()
    end
end

--因为最多只有三条 可以暴力刷新
--展开最多只能有三行，所有有可能是 1、2、3条
--不展开的时候跑马灯展现
function ChatQuickLayer:refreshView()
    self.centerBg:removeAllChildren()
    local data = self.messageList[#self.messageList]
    self:setSize(size.width, 40)
    self.rootLayer:setSize(size.width, 40)
    self.centerBg:setContentSize(self.rootLayer:getContentSize().width, self.rootLayer:getContentSize().height)
    if data then       
        local _, logo, content = UI.DialogTextCell:generalContent(data, true, true)
        content = string.gsub(content, "click", "font")
        local richTextLogo = UI.RichText:create()
        local success = richTextLogo:init(logo, 40, 16)
        if success == false then
            return
        end

        local runLamp = UI.RichText:create()
        local success = runLamp:init(content, nil, 10, true)
        if success == false then
            return
        end

        local width = runLamp:getContentSize().width
        local runLamp = UI.RichText:create()
        local success = runLamp:init(content, width, 10)
        if success == false then
            return
        end

        local clipper = UI.ClippingNode:create()
        clipper:initWithRect(self.centerBg:getContentSize().width - 140, self.centerBg:getContentSize().height)
        clipper:addInnerNode(runLamp)
        clipper:setOpacityFilterTouch(false)
        runLamp:computePosition()

        self.centerBg:addChild(richTextLogo)
        self.centerBg:addChild(clipper)
        richTextLogo:centerLeft(23)
        clipper:centerLeft(richTextLogo:getLeft() + richTextLogo:getContentSize().width + 5)
        if runLamp:getContentSize().width > clipper:getContentSize().width then
            runLamp:centerLeft(0)
            runLamp:computePosition()
            local posY = runLamp:getPositionY()
            local moveAction2 = cc.MoveTo:create(18, cc.p(runLamp:getContentSize().width * -1, posY))
            moveAction2 = cc.RepeatForever:create(cc.Sequence:create(moveAction2,  cc.MoveTo:create(0, cc.p(clipper:getContentSize().width, posY))))

            runLamp:runAction(moveAction2)
        else
            runLamp:centerLeft(0)
        end
    end
end

function ChatQuickLayer:expandClick()
    if self.disableClick then
        print("----ChatQuickLayer:expandClick() disableClick is true")
        return
    end
    self:onOpenMainChatClick()
end

function ChatQuickLayer:initDiaLogLayer()
end

function ChatQuickLayer:forceClear()
    
end

function ChatQuickLayer:setClickDisable(disable)
    self.disableClick = disable
end