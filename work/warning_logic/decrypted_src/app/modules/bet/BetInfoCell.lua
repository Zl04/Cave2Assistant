------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/10/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()

require "app.modules.bet.BetInfoTips"

UI = UI or {}
local BetInfoCell = class("BetInfoCell", UI.HWBtnComponent)
UI.BetInfoCell = BetInfoCell

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 200
local COM_HEIGHT = 322 -- 292

function BetInfoCell:ctor()
    BetInfoCell.super.ctor(
    self,
    UI.Type.NORMAL,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)
end

function BetInfoCell:init( ... )
    BetInfoCell.super.init(self, ... )
end

function BetInfoCell:dtor()
    BetInfoCell.super.dtor(self)
    reload_script_file("app.modules.bet.BetInfoCell")
end

function BetInfoCell:onInitView()
    local bg = UI.Image:create()
    bg:init("ui_rally_paper_1.png")
    bg:centerUp(0)
    self:addChild(bg)
    self._bg = bg 
    
    local title = UI.Text:create()
    title:init(mvc.betModel:getBoatName(1), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    title:centerUp(24 - title:getContentSize().height/2)
    bg:addChild(title)
    self._title = title
    
    -- 船图片
    local boatImage = UI.Image:create()
    boatImage:init(mvc.betModel:getBoatPictureSmall(1))
    boatImage:centerBottom(126)
    bg:addChild(boatImage, 10)
    boatImage:setTouchEnable(true)
    boatImage:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        mvc.openPanel("Bet", "RallyBoatInfo", {boatID = self._data.boatid, showWinNum = true})
    end) 
    
    self._boatImage = boatImage
    
    
    local peilvText = UI.Text:create()
    peilvText:init(mvc.betModel:getPeiLvStr(1.000, false), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    peilvText:centerBottom(79-peilvText:getContentSize().height/2)
    bg:addChild(peilvText, 10)
    self._peilvText = peilvText
    
    local touzhuButton = UI.Button:create()
    touzhuButton:init("ui_rally_btn.png", "ui_rally_btn.png", "ui_rally_btn.png")
    touzhuButton:setText(UI.TEXT_227606) --"投注"
    touzhuButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_45_44_48)
    touzhuButton:centerBottom(40-touzhuButton:getContentSize().height/2)
    touzhuButton:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        print("处理投注逻辑")
        local betItemNum = 0
        if(mvc.bigSailPortModel:getBaseData() ~= nil) then
            betItemNum = mvc.bigSailPortModel:getBaseData().betItemNum
        end
        
        if(betItemNum < mvc.betModel:getBetUnitNum()) then
            UI.ScrollBar:createByText(UI.TEXT_227614)
            return
        end
        
        if(mvc.betModel:getInGameTime() >=0) then 
            UI.ScrollBar:createByText(UI.TEXT_227616)
            return
        end

        if(mvc.betModel:getInBetTime() <= 0) then 
            UI.ScrollBar:createByText(UI.TEXT_227640)
            return
        end

        if(mvc.betModel:getBetMaxNum() <= self._data.BetBoatInfo.myBet) then 
            UI.ScrollBar:createByText(UI.TEXT_227637)
            return
        end

        local curBetBoatID = mvc.betModel:getBetBoatID()
        if((curBetBoatID > 0 and curBetBoatID ~= self._data.boatid)) then 
            UI.ScrollBar:createByText(UI.TEXT_227617)
            return
        end

        -- 弹出投注页面
        local infoTips = UI.BetInfoTips:create(self._data)
        infoTips:init()
        infoTips:center()
        UI.TipsLayer:addTips(infoTips)
    end) 
    bg:addChild(touzhuButton)
    touzhuButton:setVisible(true)
    self._touzhuButton = touzhuButton

    
    local touzhuImage = UI.Image:create()
    touzhuImage:init("ui_rally_mark_0.png")
    touzhuImage:leftUp(0, 37)
    bg:addChild(touzhuImage, 10)
    self._touzhuImage = touzhuImage
    touzhuImage:setVisible(false)
    
    local touzhuText = UI.Text:create()
    touzhuText:init(tostring(AvalonUtil:getTargetFormatedNum(500000)), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, {r=130, g=27, b=27})
    touzhuText:setAnchorPoint(0.5, 0.5)
    touzhuText:centerBottom(39 - touzhuText:getContentSize().height/2)
    touzhuText:setTextCenter()
    -- touzhuText:enableDebugDraw()
    -- 旋转
    touzhuText:setRotation(-30)
    
    touzhuImage:addChild(touzhuText, 10)
    self._touzhuText = touzhuText
end

function BetInfoCell:onUpdateView()
    
end

function BetInfoCell:updateData(data)
    if(data ~= nil) then 
        self._data = data
        if(data.BetBoatInfo == nil) then 
            printError("BetInfoCell:updateData  data.BetBoatInfo is nil")
            return
        end
        -- 刷新数据
        self._title:setText(mvc.betModel:getBoatName(data.boatid))
        self._boatImage:setSpriteName(mvc.betModel:getBoatPictureSmall(data.boatid))
        
        self._peilvText:setText(mvc.betModel:getPeiLvStr(data.BetBoatInfo.totalBetItemNum, false))
        
        -- print("BetInfoView:refreshView"..data.boatid.. "  myBet" .. data.BetBoatInfo.myBet)
        if(data.BetBoatInfo.myBet > 0) then 
            self._touzhuImage:setVisible(true)

            self._touzhuText:setText(tostring(AvalonUtil:getTargetFormatedNum(data.BetBoatInfo.myBet)))
            -- self._touzhuText:centerBottom( - self._touzhuText:getContentSize().width/2,35 - self._touzhuText:getContentSize().height/2)
            self._touzhuText:centerBottom(39 - self._touzhuText:getContentSize().height/2)
        else 
            self._touzhuImage:setVisible(false)
        end
        
        -- if(mvc.betModel:getInBetTime()) then 
        --     local curBetBoatID = mvc.betModel:getBetBoatID()
        --     if(curBetBoatID < 0 or (curBetBoatID > 0 and curBetBoatID == data.boatid)) then 
        --         self._touzhuButton:setVisible(true)
        --     else 
        --         self._touzhuButton:setVisible(false)
        --     end
        -- else 
        --     self._touzhuButton:setVisible(false)
        -- end
    end
end












