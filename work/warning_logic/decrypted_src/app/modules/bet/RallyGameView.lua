------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2024/01/08
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")

local RallyGameView = class("RallyGameView", UI.HWBtnComponent)
require "app.ui.newTownBtnUI.BtnListFunction"
require "app.modules.bet.RallyGameBoatInfo"
require "app.modules.bet.RallyGameSkillInfo"
require "app.modules.bet.RallyGameItemInfo"

local scheduler = cc.Director:getInstance():getScheduler()

local Bezier = require("utils.Bezier.Bezier")

-- 资源
local COM_RES_LIST = {
    "ui_town_rally.plist",
    "ui_town_navigation.plist",
    "ui_town_greatnavigation.plist",
}

local COM_WIDTH = 1100
local COM_HEIGHT = 609

local CLIPPER_WIDTH = 1050
local CLIPPER_HEIGHT = 550

local SKILL_SP_COOLD_1 = "ui_btn_gaming_battleskill_cooldown01.png"

function RallyGameView:ctor()
    RallyGameView.super.ctor(
    self,
    UI.Type.RALLY_GAME,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)

self.schedulerID = 0;
self._preQuestTime = AvalonUtil:getCurrentTime()
self.islandNodeList = {}

self:bindModel()
end

function RallyGameView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bet", "Bet", false)
    RallyGameView.super.init(self, ... )
end

function RallyGameView:dtor()
    RallyGameView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.bet.RallyGameView")
end


function RallyGameView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    
    -- 内容面板
    local clipperInnerNode = UI.Layout:create();
    clipperInnerNode:init()
    clipperInnerNode:setSize(COM_WIDTH,COM_HEIGHT)
    clipperInnerNode:center()
    self.clipperInnerNode = clipperInnerNode
    
    local nauticalChart = UI.Image:create()
    nauticalChart:init("ui_greatnavigation_map.png")
    nauticalChart:center()
    clipperInnerNode:addChild(nauticalChart)
    nauticalChart:setScale(0.5)
    self._nauticalChart = nauticalChart
    
    local islandNodes = UI.Animation:create()
    islandNodes:init("map_islands.json", "map_islands.atlas", 1);
    islandNodes:center()
    nauticalChart:addChild(islandNodes)
    islandNodes:setAnimation("idle", true)
    -- islandNodes:enableDebugDraw()
    self.islandNodes = islandNodes
    
    local clipper = UI.ClippingNode:create()
    clipper:initWithRect(CLIPPER_WIDTH, CLIPPER_HEIGHT)
    clipper:addInnerNode(clipperInnerNode)
    clipper:center()
    contentLayout:addChild(clipper)
    clipper:setOpacityFilterTouch(false)
    self.clipper = clipper
    
    self:initIslandMapView()
    self:showRoadLine()
    -- 地图上的船
    self:initBoatInMap()
    -- 拉力赛的详情信息
    self:initBoatInfoBar()
    self:initFuntionBtn()
    
    -- 弹幕
    local crollLayout = UI.Layout:create();
    crollLayout:init()
    crollLayout:setSize(COM_WIDTH,COM_HEIGHT)
    crollLayout:center()
    contentLayout:addChild(crollLayout, 1000)
    self._crollLayout = crollLayout
    
    local bg = UI.Image:create()
    bg:init("ui_greatnavigation_map_up.png")
    bg:center()
    contentLayout:addChild(bg)
    
    local closeBtn = UI.Button:create()
    closeBtn:init("ui_greatnavigation_close.png", "ui_greatnavigation_close.png")
    closeBtn:rightUp(0, 0)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onClose)
    contentLayout:addChild(closeBtn)
    
    self:refreshBoatInfo()
end

function RallyGameView:initBoatInMap()
    self._mapBoatList = {}
    local betInfoList = mvc.betModel:getBetInfoList()
    
    for i =1, #betInfoList do 
        local boatInfo = betInfoList[i]
        local boatPos = self._roadList[1]
        
        local boatLayout = UI.Layout:create()
        boatLayout:init()
        boatLayout:setSize(0, 0)
        boatLayout:leftUp(boatPos.x, boatPos.y)
        
        local boat = UI.Image:create()
        boat:init(mvc.betModel:getBoatPictureSmall(boatInfo.boatid))
        boat:centerBottom(0)
        
        local boat = UI.Animation:create()
        boat:init("effect_ui_lalisai_mapships.json", "effect_ui_lalisai_mapships.atlas", 1)
        boat._spine:setSkin(boatInfo.boatid.."")
        boat:setAnimation("idle", true)
        boat:center()
        boatLayout:addChild(boat)
        boatLayout._boat = boat
        
        
        -- 状态表情
        local boatStatusLayout = UI.Layout:create()
        boatStatusLayout:init()
        boatStatusLayout:setSize(0, 0)
        boatStatusLayout:enableAutoWidth()
        boatStatusLayout:enableAutoHeight()
        boatStatusLayout:centerBottom(120)
        boatLayout._boatStatusLayout = boatStatusLayout
        boatLayout:addChild(boatStatusLayout)
        self._nauticalChart:addChild(boatLayout, 100)
        
        self._mapBoatList[boatInfo.boatid] = boatLayout
    end
    
    self:refreshBoatPos()
end

function RallyGameView:refreshItemBtnStatus()
    
    local useItemArr = mvc.betModel:getUseItemIDArr()
    -- print("RallyGameView:refreshItemBtnStatus", useItemArr)
    -- useItemArr = {22072610, 22072620}
    local betBoatInfo = mvc.betModel:getBetBoatInfo()
    local willUse = true
    if(betBoatInfo == nil or mvc.betModel:getInGameTime() < 0) then 
        willUse = false
    end
    
    for i=1, #self._btnNodeList do 
        local btn = self._btnNodeList[i]
        -- print("RallyGameView:refreshItemBtnStatus 1")
        if(btn._btnData ~= nil and btn._btnData.itemData ~= nil) then 
            -- print("RallyGameView:refreshItemBtnStatus 2")
            local isUse = false
            for j=1, #useItemArr do 
                if(useItemArr[j] == btn._btnData.itemData:getGoodsID()) then 
                    isUse = true
                    break
                end
            end
            if(isUse and willUse) then 
                btn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
                btn._useAnimtion:setVisible(true)
                btn._btnData.itemData.enablebtn = true
            else
                btn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
                btn._useAnimtion:setVisible(false)
                btn._btnData.itemData.enablebtn = false
            end
        end
        
        if(btn._btnData ~= nil and btn._btnData.skillData ~= nil) then 
            if(willUse) then 
                btn._btnData.skillData.enablebtn = true
                btn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
            else
                btn._btnData.skillData.enablebtn = false
                btn:onUseShader(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
            end
        end
    end
end

function RallyGameView:refreshMyBoatStatus()
    local boatInfo = mvc.betModel:getBetBoatInfo()
    
    if(boatInfo ~= nil and boatInfo.BetBoatSailInfo ~= nil) then 
        local betBoatLayout = self._mapBoatList[boatInfo.boatid]
        if(betBoatLayout ~= nil) then 
            local boatStatusLayout = betBoatLayout._boatStatusLayout
            boatStatusLayout:removeAllChildren()
            boatStatusLayout:clearComponentList()
            
            local eventinfos = boatInfo.BetBoatSailInfo.eventinfos
            if(eventinfos ~= nil) then 
                for k, v in pairs(eventinfos) do
                    local eventID = v.eventid
                    
                    local eventConfig = ConfigManager:getNavigationRacingEventDataByID(eventID)
                    if(eventConfig ~= nil and eventConfig.eventType == 1) then 
                        local reduceIconName = "ui_rally_bubble_01.png"
                        local reduceCricleName = "ui_rally_bubble_01_2.png"
                        if(eventConfig.eventEffectType == UI.EventEffectType.reduceSpeed) then 
                            reduceIconName = "ui_rally_bubble_01.png"
                            reduceCricleName = "ui_rally_bubble_01_2.png"
                        elseif (eventConfig.eventEffectType == UI.EventEffectType.stop) then
                            reduceIconName = "ui_rally_bubble_02.png"
                            reduceCricleName = "ui_rally_bubble_02_2.png"
                        elseif (eventConfig.eventEffectType == UI.EventEffectType.reverse) then
                            reduceIconName = "ui_rally_bubble_03.png"
                            reduceCricleName = "ui_rally_bubble_03_2.png"
                        end
                        
                        local cricleImg = UI.Image:create()
                        cricleImg:init(reduceCricleName)
                        
                        local cricleTimer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(reduceCricleName))
                        cricleTimer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
                        cricleTimer:setContentSize(cc.p(56, 57))
                        cricleTimer:setPercentage(100)
                        
                        local totalTime = mvc.betModel:getEventEffectTimeForEventID(v.eventid)
                        if(totalTime ~= 0) then
                            local startPer = v.expireTTL*100.0/totalTime
                            local progressFromToAction = cc.ProgressFromTo:create(v.expireTTL/1000.0, startPer, 0)
                            cricleTimer:runAction(progressFromToAction)
                        end
                        
                        local statusImg = UI.Image:create()
                        statusImg:init(reduceIconName)
                        -- statusImg:center()
                        statusImg:floatLeft(5)
                        
                        statusImg:addChild(cricleTimer)
                        statusImg._cricleTimer = cricleTimer
                        
                        boatStatusLayout:addComponent(statusImg)
                        boatStatusLayout:updateView()
                    end
                end
            end
        end
    end
end

function RallyGameView:refreshBoatPos()
    local totalMileason = mvc.betModel:getRallyTotalMileage()
    local boatInfoList = mvc.betModel:getBetInfoList()
    
    if(boatInfoList ~= nil) then 
        for k, v in pairs(boatInfoList) do
            local boatInfo = v
            local boat = self._mapBoatList[v.boatid]
            if(boat ~= nil) then 
                local boatNode = boat._boat
                
                local pos = 1
                local offsetScaleX = 1
                if(v.BetBoatSailInfo ~= nil) then 
                    -- 自己投注的船永远在最上层
                    if(boatInfo.BetBoatInfo ~= nil and boatInfo.BetBoatInfo.myBet > 0) then
                        boatNode._spine:setSkin("select"..boatInfo.boatid.."")
                        boatNode:setAnimation("idle", true)
                        boat:setZOrder(101)
                    else
                        boatNode._spine:setSkin(boatInfo.boatid.."")
                        boatNode:setAnimation("idle", true)
                        boat:setZOrder(100)
                    end
                    
                    -- print("RallyGameView:refreshBoatPos start pos=", v.boatid, v.BetBoatSailInfo.travelNum, totalMileason)
                    local totalTrNum = v.BetBoatSailInfo.travelNum
                    if(v.BetBoatSailInfo.simstarttime == nil) then 
                        v.BetBoatSailInfo.simstarttime = AvalonUtil:getCurrentTime()
                    else 
                        totalTrNum = totalTrNum + (AvalonUtil:getCurrentTime() - v.BetBoatSailInfo.simstarttime) * v.BetBoatSailInfo.speed
                        -- print("RallyGameView:refreshBoatPos start pos=", v.boatid, v.BetBoatSailInfo, totalMileason, totalTrNum)
                    end
                    
                    pos = math.floor(#self._roadList * (totalTrNum* 1.0 / totalMileason))
                    if(pos > #self._roadList) then 
                        pos = #self._roadList
                    end
                    if(pos < 1) then 
                        pos = 1
                    end
                    
                    if(v.BetBoatSailInfo.speed <0) then 
                        offsetScaleX = -1
                    end
                end
                
                local boatPos = self._roadList[pos]
                if(pos > 1) then
                    local prePos = self._roadList[pos-1]
                    if (prePos.x > boatPos.x) then 
                        boatNode:setScaleX(1 * offsetScaleX)
                    else
                        boatNode:setScaleX(-1 * offsetScaleX)
                    end
                else 
                    local nextPos = self._roadList[pos+1]
                    if(nextPos.x < boatPos.x) then 
                        boatNode:setScaleX(1 * offsetScaleX)
                    else
                        boatNode:setScaleX(-1 * offsetScaleX)
                    end
                end
                boat:leftUp(boatPos.x, boatPos.y)
            end
        end
    end
end

function RallyGameView:initBoatInfoBar()
    local rallyBar = UI.RallyGameBoatInfo:create()
    rallyBar:init()
    -- rallyBar:leftBottom(-CLIPPER_WIDTH/2 - 192 , 195)
    rallyBar:leftBottom(-rallyBar:getContentSize().width + 56 , 55)
    self.clipperInnerNode:addChild(rallyBar, 99)
    self.rallyBar = rallyBar
    rallyBar:setName("RallyGameBoatInfo")
end

function RallyGameView:showRoadLine()
    local roadList = self:getRoadList()
    self._roadList = roadList
    
    local max = 100
    local prePoint = nil
    local pointNum = 0
    
    local index = 1
    while(index + max <= #roadList) do
        local startPoint = roadList[index]
        local centerPoint = roadList[index+max/2]
        local endPoint = roadList[index+max]
        
        local pointLayout = UI.Layout:create()
        pointLayout:init()
        pointLayout:setSize(0, 0)
        pointLayout:leftUp(centerPoint.x, centerPoint.y)
        
        local pointImg = UI.Image:create()
        pointImg:init("ui_rally_route.png")
        pointImg:setAnchorPoint(0.5, 0.5)
        pointImg:center()
        local angle = self:calculateAngle(startPoint, endPoint)
        pointImg:setRotation(angle)
        
        pointLayout:addChild(pointImg)
        self._nauticalChart:addChild(pointLayout, 100)
        index = index + max
    end
end

function RallyGameView:calculateAngle(point1, point2)
    local x_diff = point2.x - point1.x
    local y_diff = point2.y - point1.y
    local angle_in_radians = math.atan2(y_diff, x_diff)
    local angle_in_degrees = math.deg(angle_in_radians)
    return angle_in_degrees
end

function RallyGameView:bindModel()
    if(self.schedulerID == 0) then 
        self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 0.01, false)
    end
end


function RallyGameView:unbindModel()
    if self.schedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = 0
    end
end

function RallyGameView:update()
    -- print("RallyGameView:update")
    -- self:refreshBoatInfo()
    self:refreshBoatPos()
    
    if(mvc.betModel:getInGameTime() >= 0) then 
        if mvc.betModel:getRallyGameFinish() then 
            if(AvalonUtil:getCurrentTime() - self._preQuestTime > 5000) then 
                self._preQuestTime = AvalonUtil:getCurrentTime()
                Net.NetBigSailSystem:reqBetBaseInfo(0)
            end
        end
    end
end

function RallyGameView:onClose()
    mvc.closePanel("Bet", "RallyGame")
end

function RallyGameView:initIslandMapView()
    local islandConfig = ConfigManager:getAllIslandsData()
    for k, v in pairs(islandConfig) do
        if v.islandSpine and v.islandSpine ~= "" then
            local islandNode = self.islandNodes:getNodeForSlot(v.islandSpine, true)
            if islandNode then
                local islandNodeSpine = UI.Animation:create()
                islandNodeSpine:init(v.islandSpine..".json", v.islandSpine..".atlas", 1);
                islandNodeSpine:center()
                islandNode:addChild(islandNodeSpine)
                --islandNodeSpine:setAnimation("idle1", true)
                islandNodeSpine:setName(v.islandSpine)
                
                -- 海浪线动画随机播放，效果更自然
                local randTime = math.random(0, 2)
                islandNodeSpine:runAction(cc.Sequence:create(cc.DelayTime:create(randTime),cc.CallFunc:create(function()    
                    islandNodeSpine:setAnimation("idle1", true)
                end)))
                
                -- local islandLayout = UI.Layout:create()
                -- islandLayout:init()
                -- islandLayout:setSize(100, 100)
                -- islandLayout:center(0, 0)
                -- islandNodeSpine:addChild(islandLayout)
                
                -- islandLayout:setTouchEnable(true)
                -- islandLayout:setSwallowTouches(false)
                -- islandLayout:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self, sender, touchPosition)
                --     self:showIslandInfo(k, touchPosition)
                -- end)
                self.islandNodeList[k] = islandNodeSpine
            end
        end
    end
    
    self:addBossIsland()
    -- self:updateIslandNodeView(true)
end


function RallyGameView:initFuntionBtn()
    self._btnNodeList = {}
    local btnConfig = self:getBtnConfig()
    
    local btnInitDatasList = self:refreshBtnListIndex(btnConfig)
    
    local btnList = UI.BtnListFunction:create()
    btnList:init(btnInitDatasList, nil, nil,nil, function(index, btnData)
        local btn = UI.Button:create()
        btn:init(btnData.IconNormal, btnData.IconClick)
        btn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            btnData.BtnCallBack()
        end)
        btn:setName(btnData.Name)
        btn._btnData = btnData
        
        -- local image = UI.Image:create()
        -- image:init("ui_greatnavigation_boat1.png")
        -- image:center()
        -- btn:addChild(image, 1)
        
        if(btnData.skillData ~= nil) then 
            local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName(SKILL_SP_COOLD_1))
            timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
            timer:setContentSize(cc.p(94, 94))
            -- timer:setRotation(180)
            timer:setPercentage(0)
            
            btn:addChild(timer, 2)
            timer:setVisible(false)
            -- timer:setVisible(true)
            btn._timer = timer
        end
        
        if(btnData.itemData ~= nil) then 
            local useAnimtion = UI.Animation:create()
            useAnimtion:init("effect_ui_lalisai_kuang.json", "effect_ui_lalisai_kuang.atlas", 1)
            useAnimtion:setAnimation("idle", true)
            useAnimtion:setVisible(false)
            useAnimtion:center()
            btn:addChild(useAnimtion, 2)
            btn._useAnimtion = useAnimtion
        end
        
        table.insert(self._btnNodeList, btn)
        return btn
    end)
    btnList:rightBottom(0, 60)
    btnList:setSkin("ui_rally_functionbtn_01.png", "ui_rally_functionbtn_02.png")
    self:addChild(btnList, 200)
    self.btnList = btnList
    self:refreshSkillCoolDown()
end

--[[
刷新技能冷却
]]
function RallyGameView:refreshSkillCoolDown()
    -- print("RallyGameView:refreshSkillCoolDown")
    for k, v in pairs(self._btnNodeList) do
        if(v._timer ~= nil and v._btnData ~= nil) then 
            local btnData = v._btnData
            local timer = v._timer
            timer:stopAllActions()
            
            local info = mvc.betModel:getSkillInfo(tonumber(btnData.skillData:getSkillID()))
            -- info = {}
            -- print("RallyGameView:refreshSkillCoolDown 2", info)
            if(info ~= nil) then
                -- info.lastUseTime = GameManager:getNormalServerTime() - 2
                -- print("RallyGameView:RallyGameView:refreshSkillCoolDown 3", info.lastUseTime, GameManager:getNormalServerTime(), btnData.skillData:getCooldown())
                if(info == nil or (GameManager:getNormalServerTime() - info.lastUseTime > btnData.skillData:getCooldown())) then 
                    timer:setVisible(false)
                else
                    local residueTime = btnData.skillData:getCooldown() + info.lastUseTime - GameManager:getNormalServerTime()
                    local startPer = residueTime*100.0/btnData.skillData:getCooldown()
                    timer:setVisible(true)
                    timer:setPercentage(startPer)
                    -- print("RallyGameView:refreshSkillCoolDown 4", startPer)
                    
                    local progressFromToAction = cc.ProgressFromTo:create(residueTime, startPer, 0)
                    timer:runAction(progressFromToAction)
                end
            end
        end
    end
end

function RallyGameView:addBossIsland()
    local bossNode = self.islandNodes:getNodeForSlot("map_boss", true)
    if bossNode then
        local bossNodeSpine = UI.Animation:create()
        bossNodeSpine:init("map_boss.json", "map_boss.atlas", 1);
        bossNodeSpine:center()
        bossNode:addChild(bossNodeSpine)
        bossNodeSpine:setAnimation("idle1", true)
        bossNodeSpine:setName("map_boss")
        self.bossNodeSpine = bossNodeSpine
    end
end

function RallyGameView:getRoadList()
    local pointList = self:getPointList()
    
    local roadList = {}
    local index = 1
    while(index <= #pointList-2) do
        local curve = Bezier:create()
        curve:init()
        -- curve:setAutoStepScale(100)
        curve:setAutoStepScale(10)
        -- curve:createCubicCurve(pointList[index], pointList[index+1], pointList[index+2], pointList[index+3])
        curve:createQuadraticCurve(pointList[index], pointList[index+1], pointList[index+2])
        curve:reduceSelf(1)
        
        local points = curve:getPoints()
        for i=1,#points do
            table.insert(roadList, points[i])
            -- print("  x" .. point.x .. " y" .. point.y)
        end
        index = index + 3
        print("RallyGameView:TestRoad="..index)
    end
    
    return roadList
end

function RallyGameView:getPointList()
    local pointList = {}
    -- table.insert(pointList, {x=50,y=650})
    -- table.insert(pointList, {x=300,y=350})
    -- table.insert(pointList, {x=800,y=250})
    
    -- table.insert(pointList, {x=800,y=250})
    -- table.insert(pointList, {x=1250,y=650})
    -- table.insert(pointList, {x=800,y=950})
    
    -- table.insert(pointList, {x=800,y=950})
    -- table.insert(pointList, {x=300,y=950})
    -- table.insert(pointList, {x=50,y=950})
    
    
    table.insert(pointList, {x=128,y=544})
    table.insert(pointList, {x=384,y=358})
    table.insert(pointList, {x=627,y=394})
    
    table.insert(pointList, {x=627,y=394})
    table.insert(pointList, {x=938,y=314})
    table.insert(pointList, {x=1071,y=382})
    
    table.insert(pointList, {x=1071,y=382})
    table.insert(pointList, {x=1358,y=401})
    table.insert(pointList, {x=1587,y=365})
    
    table.insert(pointList, {x=1587,y=365})
    table.insert(pointList, {x=1729,y=432})
    table.insert(pointList, {x=1764,y=569})
    
    table.insert(pointList, {x=1764,y=569})
    table.insert(pointList, {x=1838,y=800})
    table.insert(pointList, {x=1696,y=885})
    
    table.insert(pointList, {x=1696,y=885})
    table.insert(pointList, {x=1540,y=901})
    table.insert(pointList, {x=1318,y=1042})
    
    table.insert(pointList, {x=1318,y=1042})
    table.insert(pointList, {x=1025,y=1077})
    table.insert(pointList, {x=512,y=917})
    
    table.insert(pointList, {x=512,y=917})
    table.insert(pointList, {x=292,y=708})
    table.insert(pointList, {x=128,y=544})
    
    return pointList
end

function RallyGameView:getBtnConfig()
    -- 投注的船信息
    local betBoatInfo = mvc.betModel:getBetBoatInfo()
    local config = ConfigManager:getNavigationGeneralConfigByID(1)
    
    local itemStr = config.racingItemId
    local skillStr = config.racingSkillId
    
    local btnInitDatasList = {}
    
    local btnIndex = 1
    
    -- 添加道具按钮
    local itemStrList = string.split(itemStr, ";")
    btnIndex = 1
    for k, v in pairs(itemStrList) do
        local itemStrList2 = string.split(v, ",")
        local itemID = tonumber(itemStrList2[1])
        local eventID = tonumber(itemStrList2[2])
        local haveNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(itemID, true)
        local itemData = GoodsDataManager:createLocalGoodsData(itemID)
        itemData:setNum(haveNum)
        
        local icon = itemData:getIconName()
        local btnData = {BtnCallBack = function()
            -- 使用道具的处理
            -- print("item "..itemID.."  "..eventID.."  "..itemData:getIconName())
            if(betBoatInfo == nil) then 
                UI.ScrollBar:createByText(UI.TEXT_227631)
                return
            end
            
            if(itemData.enablebtn == false) then
                UI.ScrollBar:createByText(UI.TEXT_227644)
                return
            end
            
            local itemInfo = UI.RallyGameItemInfo:create(itemData)
            itemInfo:init()
            itemInfo:center()
            self:addChild(itemInfo, 1000)
        end, 
        RedCallBack = function(btn)
            
        end,
        Name = "itemBtn"..btnIndex,
        IconNormal = icon, 
        IconClick = icon, btnIndex = btnIndex, isHorizontal = true,
        itemData = itemData
    }
    table.insert(btnInitDatasList, btnData)
    
    btnIndex = btnIndex + 1
end

-- 添加技能按钮
btnIndex = 1
local skillStrList = string.split(skillStr, ";")
for k, v in pairs(skillStrList) do
    local skillStrList2 = string.split(v, ",")
    local skillID = tonumber(skillStrList2[1])
    local eventID = tonumber(skillStrList2[2])
    
    
    local skillData = SkillDataManager:createSkillForSkillId(skillID)
    -- local skillData = ConfigManager:getSkillConfigById(skillID)
    -- print("skillData", skillData)
    local icon = skillData.iconID
    
    local btnData = {BtnCallBack = function()
        -- 使用技能的处理
        -- print("skill "..skillID.."  "..eventID.."  "..skillData.iconID)
        if(betBoatInfo == nil) then 
            UI.ScrollBar:createByText(UI.TEXT_227631)
            return
        end

        if(skillData.enablebtn == false) then
            UI.ScrollBar:createByText(UI.TEXT_227649)
            return
        end
        
        local info = mvc.betModel:getSkillInfo(tonumber(skillID))
        -- print("wwwwwwwskill ", info, GameManager:getNormalServerTime(), info.lastUseTime,GameManager:getNormalServerTime() - info.lastUseTime , skillData:getCooldown() )
        --  判断是否冷却完成
        if(info ~= nil and (GameManager:getNormalServerTime() - info.lastUseTime < skillData:getCooldown())) then 
            -- 提示技能冷却中
            UI.ScrollBar:createByText(languageManagerInstance:getLocalString(1170089))
            return
        end
        
        local skillInfo = UI.RallyGameSkillInfo:create(skillData)
        skillInfo:init()
        skillInfo:center()
        self:addChild(skillInfo, 1000)
    end, 
    RedCallBack = function(btn)
        
    end,
    Name = "skillBtn"..btnIndex,
    IconNormal = icon, 
    IconClick = icon, btnIndex = btnIndex, isHorizontal = false,
    skillData = skillData
}
table.insert(btnInitDatasList, btnData)

btnIndex = btnIndex + 1
end

return btnInitDatasList
end

function RallyGameView:refreshBtnListIndex(btnInitDatasList)
    -- 重新排列顺序按照先横向，再纵向
    local index = 1
    local firstVertical = false
    for k,v in pairs(btnInitDatasList) do
        if v.isHorizontal then
            v.btnIndex = index
            index = index + 1
        else
            if not firstVertical then
                firstVertical = true
                index = 1
            end
            v.btnIndex = index
            index = index + 1
        end
    end
    return btnInitDatasList
end

--[[
刷新船的事件
]]
function RallyGameView:refreshBoatEvent(events)
    print("RallyGameView:refreshBoatEvent", events)
    if(events ~= nil) then 
        for k, v in pairs(events) do
            self:createScrolling(v)
        end
    end
end

function RallyGameView:refreshBoatInfo()
    if(self.rallyBar ~= nil) then
        self.rallyBar:refreshBoatInfo()
    end
    
    -- 刷新船头上的表现
    self:refreshMyBoatStatus()
    
    -- 刷新道具按钮状态
    self:refreshItemBtnStatus()
    
    -- 刷新船的位置
    self:refreshBoatPos()
end

function RallyGameView:showSettleResult()
    -- 显示结算页面
    mvc.openPanel("Bet", "RallyResult")
end

function RallyGameView:createScrolling(eventDetail)
    local eventID = eventDetail.eventid
    local eventData = nil
    if(eventDetail.eventType == 2) then 
        -- 处理技能
        eventData = mvc.betModel:getEventDataForSkillID(eventDetail.skillid)
    elseif (eventDetail.eventType == 3) then 
        -- 处理道具
        eventData = mvc.betModel:getEventDataForItemID(eventDetail.itemid)
    elseif (eventDetail.eventType == 1) then 
        eventData = ConfigManager:getNavigationRacingEventDataByID(eventDetail.eventid)
    else
        return
    end
    
    local nameStr = eventDetail.actorName
    
    local str = languageManagerInstance:getLocalString(eventData.barrageDes)
    -- print("RallyGameView:createScrolling", str, eventDetail)
    local content = "" --AvalonUtil:formartRichText({r = 217, g = 217, b = 217}, UI.FONT_SIZE_20PX, UI.FONT_STANDARD, str, textTable)
    if(eventData.eventType == 1) then
        --print("RallyGameView:createScrolling eventType==1 ", str, eventDetail) 
        content = string.format(str, mvc.betModel:getBoatName(eventDetail.boatid))    
        --content = AvalonUtil:formartRichText({r = 217, g = 217, b = 217}, UI.FONT_SIZE_20PX, UI.FONT_STANDARD, str, mvc.betModel:getBoatName(eventDetail.boatid))
    elseif (eventData.eventType == 2) then 
        local skillData = ConfigManager:getSkillConfigById(eventDetail.skillid)
        content = string.format(str, nameStr, languageManagerInstance:getLocalString(skillData.name), mvc.betModel:getBoatName(eventDetail.boatid))    
        --content = AvalonUtil:formartRichText({r = 217, g = 217, b = 217}, UI.FONT_SIZE_20PX, UI.FONT_STANDARD, str, nameStr, languageManagerInstance:getLocalString(skillData.name))
    elseif (eventData.eventType == 3) then 
        local goodData = GoodsDataManager:createLocalGoodsData(tonumber(eventDetail.itemid))
        content = string.format(str, nameStr, eventDetail.itemnum, goodData:getName(), mvc.betModel:getBoatName(eventDetail.boatid))
        --content = AvalonUtil:formartRichText({r = 217, g = 217, b = 217}, UI.FONT_SIZE_20PX, UI.FONT_STANDARD, str, nameStr, eventDetail.itemnum, goodData:getName())
    end
    
    local scrollBg = UI.Image:create()
    scrollBg:init("ui_rally_barrage_bg.png")
    
    
    local scrollText = UI.RichText:create()
    scrollText:setFontName(UI.FONT_STANDARD)
    local success = scrollText:initForNetJson(content, 1800, 0, true)
    if success then
        scrollText:center()
        scrollBg:addChild(scrollText)
        
        -- print("RallyGameView:createScrolling 2", scrollText:getContentSize().width, scrollText:getContentSize().height)
    else 
        desText = nil
    end
    
    
    -- local scrollText = UI.RichText:create()
    -- scrollText:init(content, 180, 20, true)
    -- scrollText:center()
    -- scrollBg:addChild(scrollText)
    
    -- 设置缩放
    local width,height = scrollText:getSize()
    local scrollBgwidth,scrollBgheight = scrollBg:getSize()
    width = width + 60
    scrollBg:setScaleX(width*1.0/scrollBgwidth)
    scrollText:setScaleX(scrollBgwidth*1.0/width)
    
    local startX = math.random(-(width), -(width + 100))
    local startY = math.random(30, COM_HEIGHT- 30)
    scrollBg:rightUp(startX, startY)
    
    self._crollLayout:addChild(scrollBg)
    
    local delayAction = cc.DelayTime:create(0.01)
    local runAction = cc.CallFunc:create(function() 
        local endX = math.random(COM_WIDTH/2 + width/2, COM_WIDTH + width/2 + 60)
        local endY = scrollBg:getPositionY()
        
        local moveAction = cc.MoveTo:create(14, cc.p(-endX, endY))
        local removeAction = cc.CallFunc:create(function() scrollBg:removeFromParent() end)
        local sequenceAction = cc.Sequence:create(moveAction, removeAction)
        scrollBg:runAction(sequenceAction)
    end)
    
    local runSequenceAction = cc.Sequence:create(moveAction, runAction)
    scrollBg:runAction(runSequenceAction)
end

return RallyGameView