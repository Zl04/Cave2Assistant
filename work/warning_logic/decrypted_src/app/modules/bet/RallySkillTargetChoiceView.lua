------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RallySkillTargetChoiceView = class("RallySkillTargetChoiceView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_navigation.plist",
    "ui_town_greatnavigation.plist",
    "ui_town_rally.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function RallySkillTargetChoiceView:ctor(data)
    RallySkillTargetChoiceView.super.ctor(
    self,
    UI.Type.RALLY_SKILL_TARGET_CHOICE,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)
self:bindModel()
-- 1技能 2道具
self._useType = data.useType
self._id = data.id
self._num = data.num
end

function RallySkillTargetChoiceView:init(...)
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bet", "Bet", false)
    RallySkillTargetChoiceView.super.init(self, ... )
end

function RallySkillTargetChoiceView:dtor()
    RallySkillTargetChoiceView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bet.RallySkillTargetChoiceView")
end


function RallySkillTargetChoiceView:onInitView()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)
    
    local function onTouchBegan(touch, event)  
        return true
    end
    
    local function onTouchEnded(touch, event)
        print("click mask end")
    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_CANCELLED )
    
    local eventDispatcher = self:getEventDispatcher()
    
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,mask)
    listener:setSwallowTouches(false)
    
    local bg  = UI.Image:create();
    bg:init("ui_rally_settlement_bg_02.png")
    bg:center()
    bg:setScaleX(winSize.width * 1.0/bg:getContentSize().width)
    self:addChild(bg)
    
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(1136, 640)
    contentLayout:center()
    self:addChild(contentLayout, 10)
    self._contentLayout = contentLayout
    
    local titleBG = UI.Image:create()
    titleBG:init("ui_rally_title_03.png")
    titleBG:centerUp(30)
    contentLayout:addChild(titleBG)
    
    local title = UI.Text:create()
    title:init(UI.TEXT_227622, UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r = 139, g = 255, b = 248})
    title:center()
    titleBG:addChild(title)
    
    self:initCenterView()
end


function RallySkillTargetChoiceView:bindModel()
    
end

function RallySkillTargetChoiceView:unbindModel()
    
end

function RallySkillTargetChoiceView:initCenterView()
    local boatLayout = UI.Layout:create()
    boatLayout:init()
    boatLayout:setSize(800, 336)
    boatLayout:centerUp(152)
    -- boatLayout:enableDebugDraw()
    self._contentLayout:addChild(boatLayout)
    
    local index = 1
    for i = 1, 4 do
        local boatInfo = mvc.betModel:getBetInfo(i)
        if(boatInfo.BetBoatInfo ~= nil and boatInfo.BetBoatInfo.myBet == 0) then 
            local boatNode = self:createBoatNode(boatInfo)
            boatNode:centerLeft(291 *(index - 1))
            boatLayout:addChild(boatNode)
            index = index + 1
        end
    end
    
    boatLayout:setTouchEnable(true)
    boatLayout:setInterceptTouches(true)
    boatLayout:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function()
        mvc.closePanel("Bet", "RallySkillTargetChoice")
    end)
end 


function RallySkillTargetChoiceView:createBoatNode(boatInfo)
    local bg = UI.Image:create()
    bg:init("ui_rally_panel.png")

    local titleText = UI.Text:create()
    titleText:init(mvc.betModel:getBoatName(boatInfo.boatid), UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 217, g = 217, b = 217})
    titleText:centerUp(15)
    bg:addChild(titleText)
    
    -- 船的显示
    local boatSpriteName = mvc.betModel:getBoatPictureSmall(boatInfo.boatid) -- 
    local boatImage = UI.Image:create()
    boatImage:init(boatSpriteName)
    boatImage:centerUp(60)
    bg:addChild(boatImage)
    boatImage:setTouchEnable(true)
    boatImage:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        mvc.openPanel("Bet", "RallyBoatInfo", {boatID = boatInfo.boatid, showWinNum = true})
    end) 
    
    -- buff显示
    local buffLayout = UI.Layout:create()
    buffLayout:init()
    buffLayout:setSize(144, 30)
    buffLayout:centerUp(175)
    bg:addChild(buffLayout)

    if(boatInfo.BetBoatSailInfo ~= nil) then    
        for i = 1, #boatInfo.BetBoatSailInfo.eventinfos do
            local buffInfo = ConfigManager:getNavigationRacingEventDataByID(boatInfo.BetBoatSailInfo.eventinfos[i].eventid)
            
            local buffSpriteName = buffInfo.buffIcon
            local buffImage = UI.Image:create()
            buffImage:init(buffSpriteName)
            buffImage:floatLeft(5)
            buffLayout:addComponent(buffImage)
        end
    end
    
    -- 属性处理
    local iconStartX = 25
    local iconstartY = 212
    local textLeft = 30
    
    local speedIcon = UI.Image:create()
    speedIcon:init("ui_rally_icon_01.png")
    speedIcon:leftUp(iconStartX, iconstartY)
    bg:addChild(speedIcon)
    
        
    local speedText = UI.RichText:create()
    speedText:init(mvc.betModel:getBoatSpeedStr(boatInfo), 300, 29, false)
    -- local speedText = UI.Text:create()
    -- speedText:init(mvc.betModel:getBoatSpeedStr(boatInfo), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 217, g = 217, b = 217})
    speedText:centerLeft(textLeft)
    speedIcon:addChild(speedText)
    
    local pathIcon = UI.Image:create()
    pathIcon:init("ui_rally_icon_02.png")
    pathIcon:leftUp(iconStartX, iconstartY + 31)
    bg:addChild(pathIcon)
    
    local pathText = UI.Text:create()
    pathText:init(mvc.betModel:getBoatPathStr(boatInfo), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 217, g = 217, b = 217})
    pathText:centerLeft(textLeft)
    pathIcon:addChild(pathText)
    
    local choiceBtn = UI.Button:create()
    choiceBtn:init("ui_rally_btn.png", "ui_rally_btn.png", "ui_rally_btn.png")
    choiceBtn:centerBottom(14)
    choiceBtn:setText(UI.TEXT_227623)
    choiceBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_45_45_45)
    bg:addChild(choiceBtn)
    choiceBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if((boatInfo ~= nil and boatInfo.BetBoatSailInfo ~= nil and boatInfo.BetBoatSailInfo.finishSailMs > 0) or mvc.betModel:getInGameTime() < 0) then 
            UI.ScrollBar:createByText(UI.TEXT_227647)
            return
        end

        local xunzhongAni   = UI.Animation:create()
        xunzhongAni:init("effect_ui_lalisai_xuanzhong.json", "effect_ui_lalisai_xuanzhong.atlas")
        xunzhongAni:center()
        xunzhongAni:addEventListener(UIEvent.ANIMATION_END,self,function()
            if(self._useType == 1) then 
                local data = {}
                data.boatid = boatInfo.boatid
                data.skillid = self._id
                -- 发送技能
                Net.NetBigSailSystem:reqUseSkill(data)
            elseif self._useType == 2 then
                local data = {}
                data.boatid = boatInfo.boatid
                data.itemid = self._id
                data.num = self._num
                
                Net.NetBigSailSystem:reqUseItem(data)
            end
            -- xunzhongAni:destroy()

            self:runAction(cc.Sequence:create(cc.DelayTime:create(0.01), cc.CallFunc:create(function()
                mvc.closePanel("Bet", "RallySkillTargetChoice")
            end)))
        end)
        bg:addChild(xunzhongAni, -1)
        xunzhongAni:setAnimation("trigger", false)
    end)
    
    return bg
end



return RallySkillTargetChoiceView