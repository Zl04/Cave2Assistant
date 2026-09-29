------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/19
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RallyBoatInfoView = class("RallyBoatInfoView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_navigation.plist",
    "ui_town_greatnavigation.plist",
    "ui_town_rally.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height

function RallyBoatInfoView:ctor(data)
    RallyBoatInfoView.super.ctor(
    self,
    UI.Type.RALLY_BOAT_INFO,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)

self._boatid = data.boatID
self._showWinNum = data.showWinNum
--print("RallyBoatInfoView", data)
self:bindModel()
end

function RallyBoatInfoView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bet", "Bet", false)
    RallyBoatInfoView.super.init(self, ... )
end

function RallyBoatInfoView:dtor()
    RallyBoatInfoView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bet.RallyBoatInfoView")
end


function RallyBoatInfoView:onInitView()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)


    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_rally_banner_box_3.png")
    bg:center()
    self:addChild(bg)
    bg:showLucencyLight()
    
    bg:setTouchEnable(true)
    bg:setInterceptTouches(true)
    bg:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function()
        mvc.closePanel("Bet", "RallyBoatInfo")
    end)
    bg:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        mvc.closePanel("Bet", "RallyBoatInfo")
    end)
    
    -- 标题
    local title = UI.Text:create()
    title:init(mvc.betModel:getBoatName(self._boatid), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    title:centerUp(21)
    bg:addChild(title)
    
    -- 船
    local boatImage = UI.Image:create()
    boatImage:init(mvc.betModel:getBoatPictureBig(self._boatid))
    boatImage:centerUp(50)
    bg:addChild(boatImage)
    
    -- 描述
    local des = UI.Text:create()
    des:init(mvc.betModel:getBoatDescription(self._boatid), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    des:centerUp(296)
    des:setWidth(300)
    bg:addChild(des)
    
    -- 航速
    local boatConfig = ConfigManager:getNavigationRacingBoatsDatayID(self._boatid)
    
    local speedStr = string.format(UI.TEXT_221905, string.format("%.2f", boatConfig.initialSpeed*60/UI.NM_DEFINE))
    print("speedStr="..speedStr.."", UI.TEXT_221905, UI.TEXT_227635)
    local speed = UI.Text:create()
    speed:init(speedStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    speed:centerBottom(29)
    bg:addChild(speed)

    -- 历史记录信息
    local historyBg = UI.Image:create()
    historyBg:init("ui_rally_banner_box_4.png")
    historyBg:leftUp(-10, 32)
    bg:addChild(historyBg)
    historyBg:setVisible(self._showWinNum)

    local historyTitle = UI.Text:create()
    historyTitle:init(UI.TEXT_227639, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r=245, g=149, b= 130})
    historyTitle:centerUp(33)
    historyBg:addChild(historyTitle)

    local betBoatInfo = mvc.betModel:getBetInfo(self._boatid)
    local winNum = 0
    if(betBoatInfo ~= nil) then 
        winNum = betBoatInfo.BetBoatInfo.winNum
    end

    local historyInfo = UI.Text:create()
    historyInfo:init(tostring(winNum), UI.FONT_BOLD, UI.FONT_SIZE_24PX, {r=243, g=193, b= 72})
    historyInfo:centerUp(53)
    historyBg:addChild(historyInfo)
end


function RallyBoatInfoView:bindModel()
    
end


function RallyBoatInfoView:unbindModel()
    
end





return RallyBoatInfoView












