------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2024/01/12
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RallyGameBoatInfo = class("RallyGameBoatInfo", UI.HWBtnComponent)
require "app.modules.bigsailisland.BigSailIslandInfoView"

UI = UI or {}

UI.RallyGameBoatInfo = RallyGameBoatInfo

-- 资源
local COM_RES_LIST = {
    "ui_town_rally.plist",
}

local SKILL_SP_COOLD_1 = "ui_btn_gaming_battleskill_cooldown01.png"

local COM_WIDTH = 480
local COM_HEIGHT = 390

local CELL_WIDTH = 420
local CELL_HEIGHT = 68

-- 船只状态
local BigSailBoatStatus = PublicDefine.BigSailBoatStatus

function RallyGameBoatInfo:bindModel()
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH, self, self.switchClick)
end

function RallyGameBoatInfo:unbindModel()
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH, self, self.switchClick)
end

function RallyGameBoatInfo:ctor(parent)
    RallyGameBoatInfo.super.ctor(
    self,
    UI.Type.TIPS,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)
self.parent = parent
self.switchBtnState = nil
self.cellList = {}
self:bindModel()
end

function RallyGameBoatInfo:init( ... )
    RallyGameBoatInfo.super.init(self, ... )
    self.isEmbattling = false
end

function RallyGameBoatInfo:dtor()
    RallyGameBoatInfo.super.dtor(self)
    self:unbindModel()
    self.isEmbattling = false
    self.switchBtnState = nil
    self.cellList = {}
    reload_script_file("app.modules.bet.RallyGameBoatInfo")
end

function RallyGameBoatInfo:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    
    -- 标题
    local titleBG = UI.Image:create()
    titleBG:init("ui_rally_title_02.png")
    titleBG:centerUp(12)
    contentLayout:addChild(titleBG)
    
    local title = UI.Text:create()
    title:init(UI.TEXT_227625, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 255, g = 251, b = 184})
    title:center()
    titleBG:addChild(title)
    
    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_rally_rank_bg.png")
    bg:centerUp(71)
    contentLayout:addChild(bg)
    self._boatBg = bg
    
    
    self:initBoatInfoView()
    
    local switchBtnClose = UI.Button:create()
    switchBtnClose:init("ui_rally_rank_btn_01.png", "ui_rally_rank_btn_01.png")
    -- local w, h = switchBtnClose:getSize()
    switchBtnClose:centerRight(-34)
    switchBtnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    bg:addChild(switchBtnClose)
    switchBtnClose:closeClickScale()
    self.switchBtnClose = switchBtnClose
    self.switchBtnClose:hide()
    
    local switchBtnOpen = UI.Button:create()
    switchBtnOpen:init("ui_rally_rank_btn_02.png", "ui_rally_rank_btn_02.png")
    -- local w, h = switchBtnOpen:getSize()
    switchBtnOpen:centerRight(-34)
    switchBtnOpen:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    bg:addChild(switchBtnOpen)
    switchBtnOpen:closeClickScale()
    self.switchBtnOpen = switchBtnOpen
    self.switchBtnOpen:hide()
    
    -- self:updateSwitchBtnShow()
    
    local delayAction = cc.DelayTime:create(0.1)
    local finish = cc.CallFunc:create(function()
        self:switchClick()
    end)
    local action = cc.Sequence:create(delayAction, finish)
    self:runAction(action)
    
    self:refreshBoatInfo()
end

function RallyGameBoatInfo:initBoatInfoView()
    self._boatNodeArr = {}
    for i =1, 4 do 
        local boatInfo = mvc.betModel:getBetInfo(i)
        -- if(boatInfo == nil) then 
        --     boatInfo = {
        --         boatid = i,
        --         rank = i,
        --         BetBoatSailInfo =
        --         {
        --             boatid = i,
        --             travelNum = 1001,
        --             speed = 90,
        --             buffs = {31001001,31001001,31001001},
        --             curBetId = 1000,
        --             finishSailMs = 100000,
        --             eventEffectValue = 1000,
        --         },
        --         BetBoatInfo = {
        --             boatid = i,
        --             totalBetItemNum = 1000,
        --             winNum = 1000,
        --             myBet = 1000,
        --         }
        --     }
        -- end
        
        local infoCell = self:createBoatInfoCell(boatInfo)
        infoCell:leftUp(10, (i-1)*80 + 10)
        table.insert(self._boatNodeArr, infoCell)
    end
end

function RallyGameBoatInfo:switchClick()
    if self.switchBtnState == 1 then
        self.switchBtnState = 0
        
        self:stopAllActions()
        
        self.runActioning = true
        self:runAction(cc.Sequence:create(
        cc.MoveTo:create(0.1, cc.p(-COM_WIDTH+56, self:getPositionY())),
        cc.CallFunc:create(function()
            self.runActioning = false
            self:updateSwitchBtnShow()
        end))
    )
    
else
    self.switchBtnState = 1
    
    self:stopAllActions()
    
    self.runActioning = true
    self:runAction(cc.Sequence:create(
    cc.MoveTo:create(0.1, cc.p(15,self:getPositionY())),
    cc.CallFunc:create(function()
        self.runActioning = false
        self:updateSwitchBtnShow()
    end))
)

end

end

function RallyGameBoatInfo:updateSwitchBtnShow()
    if self.switchBtnState == 1 then
        local w = self.switchBtnClose:getSize()
        self.switchBtnClose:centerRight(-34)
        
        self.switchBtnClose:show()
        self.switchBtnOpen:hide()
    else
        local w = self.switchBtnOpen:getSize()
        self.switchBtnOpen:centerRight(-34)
        
        self.switchBtnClose:hide()
        self.switchBtnOpen:show()
    end
end

function RallyGameBoatInfo:createBoatInfoCell(boatInfo)
    -- 背景图片
    local infoBg  = UI.Image:create()
    if(boatInfo.BetBoatInfo.myBet > 0) then 
        infoBg:init("ui_rally_list_01.png")
    else
        infoBg:init("ui_rally_list_04.png")
    end
    -- infoBg:init(string.format("ui_rally_list_0%s.png", boatInfo.boatid))
    self._boatBg:addChild(infoBg, 10)
    
    -- 船只排名
    local rankIcon = UI.Image:create()
    rankIcon:init("ui_rally_rank_01.png", boatInfo.rank)
    rankIcon:setName("rankIcon")
    rankIcon:leftUp(-4, -5)
    rankIcon:setVisible(false)
    infoBg:addChild(rankIcon)
    
    -- 船图片
    local boatImg  = UI.Image:create()
    boatImg:init(mvc.betModel:getBoatIcon(boatInfo.boatid))
    boatImg:centerLeft(36, 0)
    infoBg:addChild(boatImg)

    -- 右上角状态
    local betStatusImg  = UI.Image:create()
    betStatusImg:init("ui_rally_title_05.png")
    betStatusImg:rightUp(-15, -15)
    betStatusImg:setVisible(false)
    infoBg:addChild(betStatusImg)
    infoBg.betStatusImg = betStatusImg

    -- 状态文字
    local betStatusText = UI.Text:create()
    betStatusText:init(UI.TEXT_227624, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=235, g=200, b=44})
    betStatusText:setAnchorPoint(0.5, 0.5)
    betStatusText:center(0, -2)
    betStatusText:setTextCenter()
    betStatusText:setRotation(30)
    betStatusImg:addChild(betStatusText)
    
    local startX = 128
    local startY = 10
    local textLeft = 25
    
    -- 显示基础信息
    local speedIcon = UI.Image:create()
    speedIcon:init("ui_rally_icon_01.png")
    speedIcon:leftUp(startX, startY)
    infoBg:addChild(speedIcon)
    
    local speedText = UI.RichText:create()
    speedText:init(mvc.betModel:getBoatSpeedStr(boatInfo), 300, 29, false)
    speedText:centerLeft(textLeft)
    speedText:setName("speedText")
    speedIcon:addChild(speedText, 10)
    infoBg.speedIcon = speedIcon
    infoBg.speedText = speedText
    
    local pathIcon = UI.Image:create()
    pathIcon:init("ui_rally_icon_02.png")
    pathIcon:leftUp(startX, startY + 29)
    infoBg:addChild(pathIcon)
    
    local pathText = UI.Text:create()
    pathText:init(mvc.betModel:getBoatPathStr(boatInfo), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 217, g = 217, b = 217})
    pathText:centerLeft(textLeft)
    pathText:setName("pathText")
    pathIcon:addChild(pathText, 10)
    infoBg.pathText = pathText
    
    -- buff信息
    local buffLayout = UI.Layout:create()
    buffLayout:init()
    buffLayout:enableAutoWidth()
    buffLayout:enableAutoHeight()
    buffLayout:setSize(104, 30)
    buffLayout:leftUp(315, 36)
    buffLayout:setName("buffLayout")
    infoBg:addChild(buffLayout)
    
    -- if(boatInfo.BetBoatSailInfo ~= nil) then
    --     local showNum = math.min(3, #boatInfo.BetBoatSailInfo.eventinfos)
    --     for i = 1, showNum do
    --         -- print("events id="..boatInfo.BetBoatSailInfo.eventinfos[i])
    --         local buffInfo = ConfigManager:getNavigationRacingEventDataByID(boatInfo.BetBoatSailInfo.eventinfos[i].eventid)
            
    --         local buffSpriteName = buffInfo.buffIcon
    --         local buffImage = UI.Image:create()
    --         buffImage:init(buffSpriteName)
    --         buffImage:floatLeft(8)
    --         buffLayout:addComponent(buffImage)
    --     end
    -- end
    
    
    -- -- 是否投注标签
    -- local betIcon = UI.Image:create()
    -- betIcon:init("ui_rally_mark_3.png")
    -- betIcon:centerRight(-10, 0)
    -- infoBg:addChild(betIcon)
    
    -- local touzhuText = UI.Text:create()
    -- touzhuText:init(UI.TEXT_227624, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r = 255, g = 215, b = 0})
    -- touzhuText:setAnchorPoint(0.5, 0.5)
    
    -- touzhuText:leftBottom(40 - touzhuText:getContentSize().width/2,32 - touzhuText:getContentSize().height/2)
    -- touzhuText:setTextCenter()
    -- -- touzhuText:enableDebugDraw()
    -- -- 旋转
    -- touzhuText:setRotation(-30)
    -- betIcon:addChild(touzhuText)
    
    
    infoBg:setTouchEnable(true)
    infoBg:addEventListener(UI.Event.COMPONENT_TOUCH_BEGAN, self, function(self, com, touchPosition)
        self:showBuffDetail(true, boatInfo)
    end)
    infoBg:addEventListener(UI.Event.COMPONENT_TOUCH_ENDED, self, function(self)
        self:showBuffDetail(false, boatInfo)
    end)
    return infoBg
end

--[[
刷新船只信息
]]
function RallyGameBoatInfo:refreshBoatInfo()
    for i =1, 4 do 
        local boatInfo = mvc.betModel:getBetInfo(i)
        if(boatInfo ~= nil) then
            local boatNode = self._boatNodeArr[i]

            if(boatInfo.BetBoatInfo ~= nil and boatInfo.BetBoatInfo.myBet > 0) then 
                boatNode:setSpriteName("ui_rally_list_01.png")
                boatNode.betStatusImg:setVisible(true)
            else
                boatNode:setSpriteName("ui_rally_list_04.png")
                boatNode.betStatusImg:setVisible(false)
            end
            
            boatNode.speedText:removeFromParent(false)
            -- boatNode.speedIcon:removeAllChildren()
            local speedText = UI.RichText:create()
            speedText:init(mvc.betModel:getBoatSpeedStr(boatInfo), 300, 29, false)
            speedText:centerLeft(25)
            speedText:setName("speedText")
            boatNode.speedText = speedText
            boatNode.speedIcon:addChild(speedText, 10)
            
            -- boatNode.speedText:setText(mvc.betModel:getBoatSpeedStr(boatInfo))
            boatNode.pathText:setText(mvc.betModel:getBoatPathStr(boatInfo))
            
            local rankIcon = boatNode:getChildByName("rankIcon")
            if(boatInfo.rank >3) then 
                rankIcon:setVisible(false)
            else
                rankIcon:setVisible(true)
                rankIcon:setSpriteName(string.format("ui_rally_rank_0%s.png", boatInfo.rank))
            end
            
            local buffLayout = boatNode:getChildByName("buffLayout")
            if(buffLayout ~= nil and boatInfo.BetBoatSailInfo ~= nil) then
                buffLayout:removeChildren()
                buffLayout:clearComponentList()
                local showNum = math.min(3, #boatInfo.BetBoatSailInfo.eventinfos)
                for i = 1, showNum do
                    local eventInfo = boatInfo.BetBoatSailInfo.eventinfos[i]
                    local buffInfo = ConfigManager:getNavigationRacingEventDataByID(eventInfo.eventid)
                    
                    local buffSpriteName = buffInfo.buffIcon
                    local buffImage = UI.Image:create()
                    buffImage:init(buffSpriteName)
                    buffImage:floatLeft(8)
                    buffLayout:addComponent(buffImage)

                    local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(SKILL_SP_COOLD_1))
                    timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
                    timer:setContentSize(cc.p(26, 26))
                    -- timer:setRotation(180)
                    timer:setScale(0.3)
                    timer:setPercentage(0)
                    buffImage:addChild(timer)
                    
                    local totalTime = mvc.betModel:getEventEffectTimeForEventID(eventInfo.eventid)
                    if(totalTime ~= 0) then
                        local startPer = 100 - eventInfo.expireTTL*100.0/totalTime
                        local progressFromToAction = cc.ProgressFromTo:create(eventInfo.expireTTL/1000.0, startPer, 100)
                        timer:setPercentage(startPer)
                        timer:runAction(cc.Sequence:create(progressFromToAction, cc.CallFunc:create(function()    
                            
                        end)))
                    end
                end
            end
        end
    end

    if(self._buffInfoBg ~= nil) then
        self:showBuffDetail(true, self._showBoatInfo)
    end
end

function RallyGameBoatInfo:showBuffDetail(show, boatInfo)
    -- print("RallyGameBoatInfo:showBuffDetail show=")
    self._showBoatInfo = boatInfo
    local BetBoatSailInfo = boatInfo.BetBoatSailInfo
    -- BetBoatSailInfo.eventinfos = {{eventid=1001, expireTTL = 10000},{eventid=1002, expireTTL = 10000},{eventid=1003, expireTTL = 10000}}
    if(self._buffInfoBg ~= nil) then 
        self._buffInfoBg:removeFromParent()
        self._buffInfoBg = nil
    end
    
    if(show) then 
        if(boatInfo == nil or BetBoatSailInfo == nil or #BetBoatSailInfo.eventinfos == 0) then
            return
        end
        
        local buffInfoWidth = 400
        
        self._buffInfoBg = UI.Layout:create()
        self._buffInfoBg:init()
        self._buffInfoBg:setSize(buffInfoWidth, 200)
        self._buffInfoBg:enableAutoHeight()
        
        self.contentLayout:addChild(self._buffInfoBg)
        
        local offsetUp = 5;
        local totalHeight = 5
        for i = 1, #BetBoatSailInfo.eventinfos do 
            local eventInfo = BetBoatSailInfo.eventinfos[i]

            local buffData = ConfigManager:getNavigationRacingEventDataByID(eventInfo.eventid)
            
            local oneLayout = UI.Layout:create()
            oneLayout:init()
            -- oneLayout:enableAutoHeight()
            oneLayout:setSize(buffInfoWidth, 30)
            
            local iconImage = UI.Image:create()
            iconImage:init(buffData.buffIcon)
            iconImage:centerLeft(10)
            oneLayout:addChild(iconImage)
            
            local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(SKILL_SP_COOLD_1))
            timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
            timer:setContentSize(cc.p(26, 26))
            -- timer:setRotation(180)
            timer:setScale(0.3)
            timer:setPercentage(0)
            iconImage:addChild(timer)
            
            local totalTime = mvc.betModel:getEventEffectTimeForEventID(eventInfo.eventid)
            if(totalTime ~= 0) then
                
                local startPer = 100 - eventInfo.expireTTL*100.0/totalTime
                -- print("wwwwwwwwwwwwww totalTime=", totalTime, eventInfo, startPer, eventInfo.expireTTL/1000.0)
                local progressFromToAction = cc.ProgressFromTo:create(eventInfo.expireTTL/1000.0, startPer, 100)
                timer:setPercentage(startPer)
                timer:runAction(cc.Sequence:create(progressFromToAction, cc.CallFunc:create(function()    
                    
                end)))
            end
            
            local buffName = UI.Text:create()
            buffName:init(languageManagerInstance:getLocalString(buffData.buffName), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 255, g = 255, b = 255})
            buffName:centerLeft(50)
            buffName:autoAdapt()
            buffName:setTextLeft()
            -- buffName:setWidth(100)
            oneLayout:addChild(buffName)
            -- oneLayout:centerUp((i -1) * 30 + 10)
            -- oneLayout:floatUp(5)
            
            local buffDesc = UI.Text:create()
            buffDesc:init(languageManagerInstance:getLocalString(buffData.buffDes), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 255, g = 255, b = 255})
            buffDesc:setWidth(245)
            buffDesc:autoAdapt()
            buffDesc:centerLeft(155)
            buffDesc:setTextLeft()
            oneLayout:addChild(buffDesc)
            -- oneLayout:centerUp((i -1) * 30 + 10)
            oneLayout:setSize(buffInfoWidth, math.max(30, buffDesc:getContentSize().height, buffName:getContentSize().height))
            oneLayout:centerUp(offsetUp)
            oneLayout:updateAutoSize()
            
            
            self._buffInfoBg:addChild(oneLayout, 10)
            offsetUp = offsetUp + oneLayout:getContentSize().height + 5
            totalHeight = totalHeight + oneLayout:getContentSize().height + 5
        end
        
        local buffBlackBg = UI.Image9:create()
        buffBlackBg:init("ui_information_banner_background1.png", CCRectMake(14,14,1,1), cc.size(buffInfoWidth, totalHeight))
        -- local buffBlackBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_background1.png")
        -- buffBlackBg:setContentSize(cc.size(buffInfoWidth, self._buffInfoBg:getContentSize().height))
        -- buffBlackBg:setPosition(cc.p(buffInfoWidth/2, self._buffInfoBg:getContentSize().height/2))
        buffBlackBg:centerUp(0)
        
        self._buffInfoBg:updateAutoSize()
        
        self._buffInfoBg:setSize(buffInfoWidth, totalHeight)
        -- self._buffInfoBg:centerRight(-buffInfoWidth)
        if(totalHeight > self.contentLayout:getContentSize().height) then 
            self._buffInfoBg:rightBottom(-buffInfoWidth, totalHeight)
        else
            self._buffInfoBg:rightBottom(-buffInfoWidth, totalHeight + (self.contentLayout:getContentSize().height - totalHeight)/2)
        end
        -- 
        self._buffInfoBg:addChild(buffBlackBg)
    end
    
end

return RallyGameBoatInfo












