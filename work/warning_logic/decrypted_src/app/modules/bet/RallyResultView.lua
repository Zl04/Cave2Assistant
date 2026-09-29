------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/10
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local RallyResultView = class("RallyResultView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_rally.plist",
    "ui_town_navigation.plist",
    "ui_town_greatnavigation.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height


local spineFileName = "effect_ui_lalisai_jiesuan.json"
local spineAtlasName = "effect_ui_lalisai_jiesuan.atlas"

function RallyResultView:ctor()
    RallyResultView.super.ctor(
    self,
    UI.Type.RALLY_RESULT,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)
self:bindModel()
end

function RallyResultView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bet", "Bet", false)
    RallyResultView.super.init(self, ... )
end

function RallyResultView:dtor()
    RallyResultView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bet.RallyResultView")
end


function RallyResultView:onInitView()
    local animationOffsetX = 0
    local animationOffsetY = -80
    
    -- 添加最底层动画
    local bgAni   = UI.Animation:create()
    bgAni:init(spineFileName, spineAtlasName)
    bgAni:center(animationOffsetX, animationOffsetY)
    bgAni:setAnimation("trigger_4", false)
    bgAni:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "trigger_4") then
            sender:addAnimation("idle_4", true)
        end
    end)
    self:addChild(bgAni)
    
    
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)
    
    local bg  = UI.Image:create();
    bg:init("ui_rally_settlement_bg.png")
    bg:center()
    bg:setScaleX(winSize.width * 1.0/bg:getContentSize().width)
    self:addChild(bg)
    
    local centerBgAni   = UI.Animation:create()
    centerBgAni:init(spineFileName, spineAtlasName)
    centerBgAni:center(animationOffsetX, animationOffsetY)
    centerBgAni:setAnimation("trigger_3", false)
    self:addChild(centerBgAni)
    
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(1136, 640)
    contentLayout:center()
    self:addChild(contentLayout,10)
    self._contentLayout = contentLayout
    
    local titleBG = UI.Image:create()
    titleBG:init("ui_rally_title_04.png")
    titleBG:centerUp(30)
    contentLayout:addChild(titleBG)
    
    local title = UI.Text:create()
    title:init(UI.TEXT_227620, UI.FONT_BOLD, UI.FONT_SIZE_30PX, {r = 255, g = 228, b = 135})
    title:center()
    titleBG:addChild(title)
    
    local centerNumOneAni   = UI.Animation:create()
    centerNumOneAni:init(spineFileName, spineAtlasName)
    centerNumOneAni:center(animationOffsetX, animationOffsetY)
    centerNumOneAni:setAnimation("trigger_2", false)
    centerNumOneAni:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "trigger_2") then
            sender:addAnimation("idle_2", true)
        end
    end)
    self:addChild(centerNumOneAni)
    
    self:initCenterView()
    
    
    local topAni = UI.Animation:create()
    topAni:init(spineFileName, spineAtlasName)
    topAni:center(animationOffsetX, animationOffsetY)
    topAni:setAnimation("trigger_1", false)
    topAni:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(_, event, sender)
        if (event.animation == "trigger_1") then
            sender:addAnimation("idle_1", true)
        end
    end)
    self:addChild(topAni, 100)
    
    local leaveBtn = UI.Button:create()
    leaveBtn:init("ui_rally_btn_02.png", "ui_rally_btn_02.png", "ui_rally_btn_02.png")
    leaveBtn:centerBottom(40)
    leaveBtn:setText(UI.TEXT_223406)
    leaveBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    contentLayout:addChild(leaveBtn)
    leaveBtn:addEventListener(UIEvent.BUTTON_CLICK,self,function()
        mvc.closePanel("Bet", "RallyGame")
        mvc.closePanel("Bet", "RallyResult")
    end)
end


function RallyResultView:bindModel()
    
end


function RallyResultView:unbindModel()
    
end

function RallyResultView:initCenterView()
    local dataInfos = mvc.betModel:getSettleResult()
    if(dataInfos == nil) then 
        dataInfos = {
            {
                boatid = 1,
                travelNum = 10000000,
                finishSailMs = 100123,
            },
            {
                boatid = 2,
                travelNum = 10000000,
                finishSailMs = 10012,
            },
            {
                boatid = 3,
                travelNum = 10000000,
                finishSailMs = 100123,
            },
            {
                boatid = 4,
                travelNum = 10000000,
                finishSailMs = 100123,
            }
        }
    end
    
    table.sort(dataInfos, function(a, b)
        if(a.travelNum ~= b.travelNum) then 
            return a.travelNum > b.travelNum
        end
        
        if(a.finishSailMs ~= b.finishSailMs) then 
            return a.finishSailMs < b.finishSailMs
        end
        
        return a.boatid < b.boatid
    end)
    
    for i = 1, 4 do 
        local rankOne = self:createInfo(i, dataInfos[i])
        local nowData = mvc.betModel:getBetInfo(dataInfos[i].boatid)
        if(nowData.BetBoatInfo ~= nil and nowData.BetBoatInfo.myBet > 0) then
            -- 右上角状态
            local betStatusImg  = UI.Image:create()
            betStatusImg:init("ui_rally_title_05.png")
            betStatusImg:rightUp(-10, -10)
            rankOne:addChild(betStatusImg, 100)
            
            -- 状态文字
            local betStatusText = UI.Text:create()
            betStatusText:init(UI.TEXT_227624, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=235, g=200, b=44})
            betStatusText:setAnchorPoint(0.5, 0.5)
            betStatusText:center(0, -2)
            betStatusText:setTextCenter()
            betStatusText:setRotation(30)
            betStatusImg:addChild(betStatusText)
        end
        
        self._contentLayout:addChild(rankOne)
    end
end


function RallyResultView:createInfo(rank, boatInfo)
    local normalOffsetX = 35
    local numOneOffsetX = 107
    if (rank == 1) then 
        -- local bg = UI.Image:create()
        -- bg:init("ui_rally_list_05.png")
        -- bg:centerUp(167)
        local bg = UI.Layout:create()
        bg:init()
        bg:setSize(562, 149)
        bg:centerUp(167)
        
        local boatIcon = UI.Image:create()
        boatIcon:init(mvc.betModel:getBoatIcon(boatInfo.boatid))
        print("boatIcon="..mvc.betModel:getBoatIcon(boatInfo.boatid))
        boatIcon:centerLeft(numOneOffsetX)
        boatIcon:setScale(1.2)
        bg:addChild(boatIcon)
        
        local infoNode = self:createInfoNode(rank, boatInfo)
        infoNode:centerLeft(222)
        bg:addChild(infoNode)
        
        local rankBg = UI.Image:create()
        rankBg:init("ui_rally_settlement_win.png")
        rankBg:leftUp(0, 143)
        self._contentLayout:addChild(rankBg)
        
        local rankText = UI.Text:create()
        rankText:init(string.format(UI.TEXT_227621, mvc.betModel:getBoatName(boatInfo.boatid)), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 220, g = 180, b = 71})
        rankText:centerLeft(10)
        rankBg:addChild(rankText)
        
        return bg
    elseif (rank == 2) then
        local bg = UI.Image:create()
        bg:init("ui_rally_list_06.png")
        bg:leftUp(65, 335)
        
        local boatIcon = UI.Image:create()
        boatIcon:init(mvc.betModel:getBoatIcon(boatInfo.boatid))
        boatIcon:centerLeft(normalOffsetX)
        bg:addChild(boatIcon)
        
        local infoNode = self:createInfoNode(rank, boatInfo)
        infoNode:centerLeft(129)
        bg:addChild(infoNode)
        
        return bg
    elseif (rank == 3) then
        local bg = UI.Image:create()
        bg:init("ui_rally_list_07.png")
        bg:leftUp(400, 335)
        
        local boatIcon = UI.Image:create()
        boatIcon:init(mvc.betModel:getBoatIcon(boatInfo.boatid))
        boatIcon:centerLeft(normalOffsetX)
        bg:addChild(boatIcon)
        
        local infoNode = self:createInfoNode(rank, boatInfo)
        infoNode:centerLeft(129)
        bg:addChild(infoNode)
        
        return bg
    elseif (rank == 4) then
        local bg = UI.Image:create()
        bg:init("ui_rally_list_08.png")
        bg:leftUp(729, 335)
        
        local boatIcon = UI.Image:create()
        boatIcon:init(mvc.betModel:getBoatIcon(boatInfo.boatid))
        boatIcon:centerLeft(normalOffsetX)
        bg:addChild(boatIcon)
        
        local infoNode = self:createInfoNode(rank, boatInfo)
        infoNode:centerLeft(129)
        bg:addChild(infoNode)
        
        return bg
    end
end

function RallyResultView:createInfoNode(rank, boatInfo)
    local layout = UI.Layout:create()
    layout:init()
    layout:setSize(200, 100)
    layout:setAnchorPoint(cc.p(0.5, 0.5))
    
    local startY = 10
    local textLeft = 32
    
    local speedIcon = UI.Image:create()
    speedIcon:init("ui_rally_icon_01.png")
    speedIcon:leftUp(0, startY)
    layout:addChild(speedIcon)
    
    local speedText = UI.Text:create()
    local speedStr = string.format(UI.TEXT_227635, string.format("%.2f", (boatInfo.travelNum/(boatInfo.finishSailMs/1000))*60/UI.NM_DEFINE))
    speedText:init(speedStr, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 217, g = 217, b = 217})
    speedText:centerLeft(textLeft)
    speedIcon:addChild(speedText)
    
    local pathIcon = UI.Image:create()
    pathIcon:init("ui_rally_icon_02.png")
    pathIcon:leftUp(0, startY + 31)
    layout:addChild(pathIcon)
    
    local pathText = UI.Text:create()
    pathText:init(string.format(UI.TEXT_227636, string.format("%.2f", boatInfo.travelNum/UI.NM_DEFINE)), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 217, g = 217, b = 217})
    pathText:centerLeft(textLeft)
    pathIcon:addChild(pathText)
    
    local timeIcon = UI.Image:create()
    timeIcon:init("ui_rally_icon_03.png")
    timeIcon:leftUp(0, startY + 62)
    layout:addChild(timeIcon)
    
    local timeText = UI.Text:create()
    timeText:init(AvalonUtil:_getFullFormatTime(boatInfo.finishSailMs/1000, false, true), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 217, g = 217, b = 217})
    timeText:centerLeft(textLeft)
    timeIcon:addChild(timeText)
    
    return layout
end


return RallyResultView












