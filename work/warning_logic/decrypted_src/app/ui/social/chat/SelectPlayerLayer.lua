-- SelectPlayerLayer.lua
-- Author:ydli
-- 2017年09月19日
-- Using:私聊选取玩家界面
UI = UI or {}
local SelectPlayerLayer = class("SelectPlayerLayer", UI.HWBtnComponent)
UI.SelectPlayerLayer = SelectPlayerLayer

local winSize = cc.Director:getInstance():getWinSize()
local layerSize = cc.size(155, 310)
local LIMITE_NUMBER = 6
local cellHeight = layerSize.height / (LIMITE_NUMBER + 1)
-- 资源列表(必备)
local COM_RES_LIST = {
}

local testData = {}


--构造函数(必备)
function SelectPlayerLayer:ctor(spriteID)
    print("------------------SelectPlayerLayer:ctor")
    --窗口大小
    SelectPlayerLayer.super.ctor(
    self,UIType.CHAT_SELECT_PLAYER,
    COM_RES_LIST,
    layerSize.width,    
    layerSize.height
    )
    self.rootLayer = nil          --root节点
    self.playerDatas = {} --pk  userID name lastTalkTime
    self.nameBtns = {}
    self.selectIndex = nil
end

--虚构函数,destroy时调用(必备)
function SelectPlayerLayer:dtor()
    SelectPlayerLayer.super.dtor(self)
    self:unRegisterListener()
    self.recoverPosX = nil
    self.recoverPosY = nil
end

-- 初始化(必备)
function SelectPlayerLayer:init(playerDatas)
    print("------------------SelectPlayerLayer:init")
    SelectPlayerLayer.super.init(self)
    self:registerListener()
end

-- 模版函数：初始化组建的视图(必备)
function SelectPlayerLayer:onInitView()
    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_chat_banner_privatechatbox.png", cc.rect(9,9,2,2))
    bg:setContentSize(layerSize.width, layerSize.height)
    bg:setAnchorPoint(0,0)
    self:addChild(bg)
    bg:setPosition(0, 0)
    self.rootLayer = bg
end


-- 模版函数：更新组建的视图(必备)
function SelectPlayerLayer:onUpdateView()
   self:showLayer()
end

function SelectPlayerLayer:showLayer()
    self.playerDatas = Game.ChatManager:getInstance():getAllChatPersonal()
    local length = #self.playerDatas
    local layout = UI.TouchLayout:create()
    layout:init(0, 0, 0, 0)
    layout:addTouchEvents(self)
    -- layout:enableDebugDraw(UI.RED)
    local layoutLeng = 1
    if length > 0 then
        layoutLeng = length
    end
    layout:setSize(layerSize.width, layoutLeng * cellHeight)
    if length <= LIMITE_NUMBER then
        self.rootLayer:setContentSize(layerSize.width, layoutLeng * cellHeight)
        layout:center()
        self.rootLayer:addChild(layout)
        layout:setSwallowTouches(true)
    else
        local scrollView = UI.ScrollView:create()
        scrollView:init(0, 0, 0, 0)
        scrollView:setSize(layerSize.width + 16, layerSize.height)
        -- scrollView:setSize(160, 300)
        scrollView:leftBottom(0, 0)
        -- scrollView:enableDebugDraw()
        self.rootLayer:addChild(scrollView, 2)
        scrollView:addInnerNode(layout)
        layout:setSwallowTouches(false)
        scrollView:setScrollBarEnabled(true)
        scrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
        scrollView:setCircleVisible(false)
        scrollView:setScrollBarWidth(3)
        self.scrollView = scrollView
    end

    local tip = UI.Text:create()
    tip:init(UI.TEXT_1170313, UI.FONT_STANDARD, UI.FONT_SIZE_14PX)
    tip:setFontColor(UI.FONT_COLOR_WHITE)
    tip:centerUp(cellHeight / 2 - 10)
    layout:addChild(tip)
    local beginPosY = tip:getPositionY()
    if #self.playerDatas > 0 then
        tip:setVisible(false)
        beginPosY = layout:getContentSize().height
    end
    local size = #self.playerDatas
    for k, v in ipairs(self.playerDatas) do
        local nameBtn = UI.TouchLayout:create()
        nameBtn:init(0, 0, 0, 0)
        nameBtn:setContentSize(layerSize.width, cellHeight)
        nameBtn:leftBottom(0 , beginPosY - k * cellHeight)
        nameBtn:setTag(k)  
        nameBtn:enableDebugDraw()  
        layout:addChild(nameBtn)
        
        local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_chat_button_online_1.png")
        bg:setContentSize(layerSize.width, cellHeight)
        bg:setAnchorPoint(0, 0)
        bg:setPosition(0,0)
        nameBtn:addChild(bg)
        bg:setName("BG")
        bg:hide()

        if k ~= size then
            local separate = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_chat.png")
            separate:setCapInsets(CCRectMake(7,7,1,1))
            separate:setContentSize(127, 1)
            separate:setAnchorPoint(0, 0)
            separate:setPosition(12,0)
            nameBtn:addChild(separate, 20)
        end
        local nickName = AvalonUtil:getSubNameStr(v.nickName, 155, UI.FONT_SIZE_16PX)
        local name = UI.Text:create()
        name:init(nickName, UI.SYS_FONT, UI.FONT_SIZE_16PX)
        name:setFontColor(UI.FONT_COLOR_170_170_170)
        name:center()
        name:setName("NICK_NAME")
        nameBtn:addChild(name)
        table.insert(self.nameBtns, nameBtn)
        -- name:enableDebugDraw()
    end
    self.layout = layout
    if self.scrollView ~= nil then
        self.scrollView:onUpdateView()
    end
end


-- 注册监听事件(可选)
function SelectPlayerLayer:registerListener()
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end


-- 注销监听事件(可选)
function SelectPlayerLayer:unRegisterListener()
end

-- 点击外部区域的处理器(关闭)(可选)
function SelectPlayerLayer:onTouchDialogOutsizeHandler()
    print("---------SelectPlayerLayer:onTouchDialogOutsizeHandler()")
    self:close()
end

function SelectPlayerLayer:onTouchBegan(touch, event)
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location
    for k, value in ipairs(self.nameBtns) do
        value:getChildByName("BG"):hide()
        if AvalonUtil:isRectContainsPoint(value, location) then
            self.selectIndex = k
            local name = value:getChildByName("NICK_NAME")
            value:getChildByName("BG"):show()
            name:setFontColor(UI.FONT_COLOR_255_255_255)
            name:setScale(1.1)
            break
        end
    end
    -- local point  = self.scrollView:convertToWorldSpace(cc.p(0,0))
    -- local size = self.scrollView:getContentSize()
    -- local rect = cc.rect(point.x , point.y , size.width, size.height) 
    -- if not cc.rectContainsPoint(rect, location) then
    --     self:onTouchDialogOutsizeHandler()
    -- end
end

function SelectPlayerLayer:onTouchEnded(touch, event)
    local nameBtn = self.nameBtns[self.selectIndex or 0]
    if nameBtn ~= nil then
        local name = nameBtn:getChildByName("NICK_NAME")
        name:setScale(1.0)
        nameBtn:getChildByName("BG"):hide()
        name:setFontColor(UI.FONT_COLOR_170_170_170)
    end
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 
    local point  = self.layout:convertToWorldSpace(self.layout:getAnchorPoint())
    local size = self.layout:getContentSize()
    local rect = cc.rect(point.x , point.y , size.width, size.height) 
    if not cc.rectContainsPoint(rect, location) then
        self:onTouchDialogOutsizeHandler()
        return
    end
    for k, value in ipairs(self.nameBtns) do
         if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k then
            self:onNameClick(value)
            break
        end
    end
end

function SelectPlayerLayer:onNameClick(sender)
    local tag = sender:getTag()
    tag = tonumber(tag)
    UI.ChatMainLayer:getInstance():setPersonalChatPlayer(self.playerDatas[tag])
    self:close()
    print("-----------tag = "..tag)
end


function SelectPlayerLayer:close()
    SelectPlayerLayer.super.close(self)
end




