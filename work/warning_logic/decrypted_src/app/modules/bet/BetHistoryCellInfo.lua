------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/10/17
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local ProtobufUtil = require "utils.ProtobufUtil"
local languageManagerInstance = LanguageManager:getInstance()
UI = UI or {}
local BetHistoryCellInfo = class("BetHistoryCellInfo", UI.HWBtnComponent)
UI.BetHistoryCellInfo = BetHistoryCellInfo

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 200
local COM_HEIGHT = 322 -- 292

function BetHistoryCellInfo:ctor()
    BetHistoryCellInfo.super.ctor(
    	self,
    	UI.Type.NORMAL,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self._historyType = UI.BET_HISTORY_TYPE.HISTORY
end

function BetHistoryCellInfo:init( ... )
    BetHistoryCellInfo.super.init(self, ... )
end

function BetHistoryCellInfo:dtor()
    BetHistoryCellInfo.super.dtor(self)
    reload_script_file("app.modules.bet.BetHistoryCellInfo")
end

function BetHistoryCellInfo:onInitView()
    -- self:enableDebugDraw()

    local timeText = UI.Text:create()
    timeText:init("23标题", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    timeText:centerUp(15 - timeText:getContentSize().height/2)
    self:addChild(timeText)
    self._timeText = timeText

    local bg = UI.Image:create()
    bg:init("ui_rally_paper_2.png")
    bg:centerBottom(0)
    self:addChild(bg)
    self._bg = bg 

    local title = UI.Text:create()
    title:init(mvc.betModel:getBoatName(1), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    bg:addChild(title)
    title:centerUp(30 - title:getContentSize().height/2)
    self._title = title

    -- 船图片
    local boatImage = UI.Image:create()
    boatImage:init(mvc.betModel:getBoatPictureSmall(1))
    boatImage:center()
    bg:addChild(boatImage, 10)
    self._boatImage = boatImage
    boatImage:setTouchEnable(true)
    boatImage:setInterceptTouches(false)
    boatImage:setSwallowTouches(false)
    -- boatImage:setTouchClipNode(self._tableView)
    boatImage:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        local showWinNum = true
        -- print("wwwww", showWinNum, self._historyType, UI.BET_HISTORY_TYPE.OUR)
        if(self._historyType == UI.BET_HISTORY_TYPE.OUR) then 
            showWinNum = false
        end
        mvc.openPanel("Bet", "RallyBoatInfo", {boatID = self._data.boatid, showWinNum = showWinNum})
    end) 


    local peilvText = UI.Text:create()
    peilvText:init(mvc.betModel:getPeiLvStr(1.000, true), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    peilvText:centerBottom(50 - peilvText:getContentSize().height/2)
    bg:addChild(peilvText, 10)
    self._peilvText = peilvText

    local touzhuText = UI.Text:create()
    touzhuText:init(UI.TEXT_227607, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    touzhuText:centerBottom(20 - touzhuText:getContentSize().height/2)
    bg:addChild(touzhuText, 10)
    self._touzhuText = touzhuText

    local betStatusImage = UI.Image:create()
    betStatusImage:init("ui_rally_mark_1.png")
    betStatusImage:rightUp(0, 10)
    bg:addChild(betStatusImage, 10)
    betStatusImage:setVisible(false)
    self._betStatusImage = betStatusImage
end

function BetHistoryCellInfo:onUpdateView()

end

function BetHistoryCellInfo:updateData(data, historyType, tableView)
    if(data ~= nil) then
        self._data = data
        self._historyType = historyType
        self._tableView = tableView
        self._timeText:setText(mvc.betModel:getHistoryDate(data.gametime))
        
        self._title:setText(mvc.betModel:getBoatName(data.boatid))
        self._boatImage:setTouchClipNode(tableView)
        self._boatImage:setSpriteName(mvc.betModel:getBoatPictureSmall(data.boatid))

        self._peilvText:setText(string.format(UI.TEXT_227605, string.format("%.2f", data.oddsnum/100.0)))

        -- 刷新数据
        if(historyType == UI.BET_HISTORY_TYPE.HISTORY) then 
            self._touzhuText:setVisible(false)
            self._betStatusImage:setVisible(false)
        else 
            self._touzhuText:setVisible(true)
            self._touzhuText:setText(string.format( UI.TEXT_227607, data.betNum))

            self._betStatusImage:setVisible(true)
            if(data.isWin) then 
                self._betStatusImage:setSpriteName("ui_rally_mark_1.png")
            else 
                self._betStatusImage:setSpriteName("ui_rally_mark_2.png")
            end
        end
    end
end

function BetHistoryCellInfo:onUpdateView()
    
end












