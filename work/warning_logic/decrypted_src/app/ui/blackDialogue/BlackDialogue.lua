-- BlackDialogue.lua
-- Author:ydli
-- 2017年08月29日
-- Using:黑屏剧情对话界面

local BlackDialogManager = require("app.game.BlackDialogManager")

UI = UI or {}
local BlackDialogue = class("BlackDialogue", UI.HWBtnComponent)
UI.BlackDialogue = BlackDialogue

local winSize = cc.Director:getInstance():getWinSize()

-- 资源列表(必备)
local COM_RES_LIST = {
}


--构造函数(必备)
function BlackDialogue:ctor(spriteID)
    -- print("TipsLayer:ctor")
    --窗口大小
    BlackDialogue.super.ctor(
    self, UIType.BLACKDIALOGUE,
    COM_RES_LIST,
    winSize.width,    
    winSize.height
    )
    self:registerListener()
    self.rootLayer = nil         --root节点
    self.callBackHandleFunc = nil
    self:init();
    self.textBeginHeight = 0
end

--虚构函数,destroy时调用(必备)
function BlackDialogue:dtor()
    BlackDialogue.super.dtor(self)
    self:unRegisterListener();
    self.textBeginHeight = 0
end

-- 初始化(必备)
function BlackDialogue:init()
    BlackDialogue.super.init(self)
    self.textBeginHeight = 0
    --root节点
    self.rootLayer = cc.LayerColor:create(cc.c4b(0,0,0,255));
    self.rootLayer:setContentSize(cc.size(winSize.width,winSize.height))
    self.rootLayer:setPosition(cc.p(0,0))
    self:addChild(self.rootLayer)
    
    self.continue = UI.Text:create()
    self.continue:init(UI.TEXT_1170108, UI.SYS_FONT, UI.FONT_SIZE_22PX)
    self.continue:setFontColor(UI.FONT_COLOR_WHITE)
    self.continue:centerBottom(50)
    self.rootLayer:addChild(self.continue)
    self.continue:setTouchEnable(true)
    self.continue:addEventListener(UIEvent.COMPONENT_CLICK,self,self.onContinueClick)
    self.continue:hide()
    self.decorateLeft = UI.Image:create()
    self.decorateLeft:init("ui_blackdialog_animation_long.png")
    self.decorateLeft:leftBottom(winSize.width / 2 - self.decorateLeft:getContentSize().width - self.continue:getContentSize().width/2 - 10, 55)
    self.rootLayer:addChild(self.decorateLeft)
    self.decorateLeft:hide()

    self.decorateRight = UI.Image:create()
    self.decorateRight:init("ui_blackdialog_animation_long.png")
    self.decorateRight:rotate(180)
    self.decorateRight:leftBottom(winSize.width / 2 + self.continue:getContentSize().width/2 + 10, 55)
    self.rootLayer:addChild(self.decorateRight)
    self.decorateRight:hide()
end

function BlackDialogue:addTouchEvents()
    local function onTouchBegan(touch, event)
        -- print("-------BlackDialogue onTouchBegan")
        if self.continue:isVisible() then
            self:onContinueClick()
        end
        return true
    end

    local function onTouchMoved(touch, event)
    end

    local function onTouchEnded(touch, event)
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
    listener:setSwallowTouches(true)
end

function BlackDialogue:onContinueClick()
    -- print("-----BlackDialogue:onContinueClick")
    self:closeDialog()
    BlackDialogManager:getInstance():setFree(true)
    if self.callBackHandleFunc then
        self.callBackHandleFunc()
    end
end

-- 模版函数：初始化组建的视图(必备)
function BlackDialogue:onInitView()

end


-- 模版函数：更新组建的视图(必备)
function BlackDialogue:onUpdateView()

end


-- 注册监听事件(可选)
function BlackDialogue:registerListener()
    -- print("TipsLayer:registerListener")
    -- self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, self.onTouchDialogOutsizeHandler)
end

function BlackDialogue:onTouchDialogOutsizeHandler()
    -- body
end

-- 注销监听事件(可选)
function BlackDialogue:unRegisterListener()
    -- print("TipsLayer:unRegisterListener")
        -- 显示进入下一层TIPS
end


function BlackDialogue:addDialogList(dialogList, isAuto, handlerFunc, music, eventType)
    -- print("----------BlackDialogue:addDialogList")
    local parentLayer = nil
    if UI.UIManager:getRootNode() and not tolua.isnull(UI.UIManager:getRootNode()) and UI.UIManager:getRootNode():getParent() then
        parentLayer = UI.UIManager:getRootNode()
    else
        parentLayer = cc.Director:getInstance():getRunningScene()
    end

    local diaLogueLayer = parentLayer:getChildByName("BlackDiaLogueLayer")
    if diaLogueLayer == nil then
        require "app.ui.blackDialogue.BlackDialogue"
        diaLogueLayer = UI.BlackDialogue:create()
        diaLogueLayer:center()
        diaLogueLayer:setName("BlackDiaLogueLayer")
        parentLayer:addChild(diaLogueLayer,UI_ZORDER.BLACK_DIALOGUE)
    end
    diaLogueLayer:showDialog(dialogList, isAuto, music, eventType)
    diaLogueLayer:show()
    diaLogueLayer:addTouchEvents()
    self.callBackHandleFunc = handlerFunc
end

function BlackDialogue:showDialog(dialogList, isAuto, music, eventType)
    print("----------BlackDialogue:showDialog, music:", music, "eventType:", eventType)

    local size = #dialogList
    local padding = 55
    self.textBeginHeight = winSize.height / 2 + padding * (size / 2) + padding
    for k, vlaue in ipairs(dialogList) do
        
        local dialog = UI.Text:create()
        dialog:init(vlaue, UI.SYS_FONT, UI.FONT_SIZE_22PX)
        dialog:setFontColor(UI.FONT_COLOR_WHITE)
        dialog:setAnchorPoint(1, 1)
        dialog:setTextLeft()
        self.rootLayer:addChild(dialog)
        dialog:setOpacity(0)
        dialog:setWidth(winSize.width - 200)
        dialog:autoAdapt()
        if k ~= 1 then
            self.textBeginHeight = self.textBeginHeight - dialog:getContentSize().height - 15
        end
        dialog:centerBottom(self.textBeginHeight)
        local sequence = cc.Sequence:create(cc.FadeOut:create(0), cc.DelayTime:create((k - 1) * 2), cc.FadeIn:create(1), cc.CallFunc:create(function()
            -- print("--------- cc.CallFunc")
            if k ~= #dialogList then
                return
            end
            if isAuto then
                Avalon.Scheduler:scheduleUpdateOnce(self, function()
                    self:closeDialog()
                    BlackDialogManager:getInstance():setFree(true)
                    if self.callBackHandleFunc then
                        self.callBackHandleFunc()
                    end
                end, 2)
            else
                self.continue:show()
                self.decorateRight:show()
                self.decorateLeft:show()
            end
        end))
        dialog:runAction(sequence)
    end
end

function BlackDialogue:closeDialog()
    self:close()
end




