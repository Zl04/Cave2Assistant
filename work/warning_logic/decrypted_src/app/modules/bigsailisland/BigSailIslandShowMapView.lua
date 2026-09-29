------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/07/12
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailIslandShowMapView = class("BigSailIslandShowMapView", UI.HWBtnComponent)

require "app.modules.bigsailisland.BigSailIslandInfoView"
require "app.modules.bigsailisland.BigSailIslandBoatSailingLayer"

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
}

local MONSTER_TYPE = {
    SMALL_MONSTER = 1,
    BIG_MONSTER = 2,
}

local COM_WIDTH = 1100
local COM_HEIGHT = 609

local MAP_WIDTH = 2088
local MAP_HEIGHT = 1426

local CLIPPER_WIDTH = 1050
local CLIPPER_HEIGHT = 550

local winSize = cc.Director:getInstance():getWinSize()

function BigSailIslandShowMapView:onTouchBegin(touchPosition)
    self.beginClickPostion = touchPosition
    local offsetX ,offsetY = self.bg2:getPosition()
    self.beginBgPosition = {x = offsetX, y = offsetY}
end

function BigSailIslandShowMapView:onTouchMove(touchPosition)
    local movePositon = {x = touchPosition.x - self.beginClickPostion.x , y = touchPosition.y - self.beginClickPostion.y }
    local nowPostion = {x = self.beginBgPosition.x + movePositon.x , y = self.beginBgPosition.y + movePositon.y}
    local limitX = math.abs((MAP_WIDTH - CLIPPER_WIDTH) / 2) + 3
    local limitY = math.abs((MAP_HEIGHT - CLIPPER_HEIGHT) / 2) + 3
    if math.abs(nowPostion.x) < limitX and math.abs(nowPostion.y) < limitY then
        self.bg2:setPosition(nowPostion.x , nowPostion.y)
    end
end


function BigSailIslandShowMapView:ctor()
    BigSailIslandShowMapView.super.ctor(
    	self,
    	UI.Type.SAIL_MAP_INFO,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self.beginClickPostion = nil
    self.beginBgPosition = nil
    self.islandNodeList = {}
    self.lastMarkedIslandID = nil
    -- 请求岛屿基础信息
    Net.NetBigSailSystem:reqAllIslandsBase()
end

function BigSailIslandShowMapView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailisland", "BigSailIsland", false)
    BigSailIslandShowMapView.super.init(self, ... )
end

function BigSailIslandShowMapView:dtor()
    BigSailIslandShowMapView.super.dtor(self)
    self:unbindModel()
    self.islandNodeList = {}
    reload_script_file_mvc("app.modules.bigsailisland.BigSailIslandShowMapView")
end


function BigSailIslandShowMapView:onInitView()
    --self:setBackgroundImage("bigSailMap.png")
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
    clipperInnerNode:setSize(CLIPPER_WIDTH,CLIPPER_HEIGHT)
    clipperInnerNode:center()
    self.clipperInnerNode = clipperInnerNode

    --岛屿内容
    local mapScrollView = ccui.ScrollView:create()
    mapScrollView:setBounceEnabled(false)
    mapScrollView:setDirection(ccui.ScrollViewDir.both)
    mapScrollView:setContentSize(cc.size(CLIPPER_WIDTH,CLIPPER_HEIGHT))
    mapScrollView:setPosition((CLIPPER_WIDTH-mapScrollView:getContentSize().width)/2,(CLIPPER_HEIGHT-mapScrollView:getContentSize().height)/2)
    clipperInnerNode:addChild(mapScrollView)
    mapScrollView:setInnerContainerSize(cc.size(MAP_WIDTH,MAP_HEIGHT))
    mapScrollView:setScrollBarEnabled(false)
    mapScrollView:setSwallowTouches(false)
    mapScrollView:scrollToPercentVertical(30, 0, false)

    local clipper = UI.ClippingNode:create()
    clipper:initWithRect(CLIPPER_WIDTH, CLIPPER_HEIGHT)
    clipper:addInnerNode(clipperInnerNode)
    clipper:center()
    contentLayout:addChild(clipper)
    clipper:setOpacityFilterTouch(false)
    self.clipper = clipper
    
    local nauticalChart = UI.Image:create()
    nauticalChart:init("ui_greatnavigation_map.png")
    nauticalChart:center()
    mapScrollView:addChild(nauticalChart)
    -- nauticalChart:setScale(0.5)

    local bg = UI.Image:create()
    bg:init("ui_greatnavigation_map_up.png")
    bg:center()
    contentLayout:addChild(bg)

    local eventBg = UI.Image:create()
    eventBg:init("ui_greatnavigation_notice1.png")
    eventBg:centerUp(0)
    contentLayout:addChild(eventBg)
    self.eventBg = eventBg
    eventBg:hide()

    local eventDes = UI.Text:create()
    eventDes:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_255_214_102)
    eventDes:center(0, -3)
    eventBg:addChild(eventDes)
    self.eventDes = eventDes

    local islandNodes = UI.Animation:create()
    islandNodes:init("map_islands.json", "map_islands.atlas", 1);
    islandNodes:center()
    nauticalChart:addChild(islandNodes)
    islandNodes:setAnimation("idle", true)
    -- islandNodes:enableDebugDraw()
    self.islandNodes = islandNodes

    local closeBtn = UI.Button:create()
    closeBtn:init("ui_greatnavigation_close.png", "ui_greatnavigation_close.png")
    closeBtn:rightUp(0, 0)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onClose)
    contentLayout:addChild(closeBtn)

    local bagBtn = UI.Button:create()
    bagBtn:init("ui_greatnavigation_icon_1.png", "ui_greatnavigation_icon_1.png")
    bagBtn:rightBottom(230, 30)
    bagBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onClickBag)
    contentLayout:addChild(bagBtn)

    local rankBtn = UI.Button:create()
    rankBtn:init("ui_greatnavigation_icon_2.png", "ui_greatnavigation_icon_2.png")
    rankBtn:rightBottom(130, 30)
    rankBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onClickRank)
    contentLayout:addChild(rankBtn)

    local eventBtn = UI.Button:create()
    eventBtn:init("ui_greatnavigation_icon_3.png", "ui_greatnavigation_icon_3.png")
    eventBtn:rightBottom(30, 30)
    eventBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onClickEvent)
    contentLayout:addChild(eventBtn)
    self.eventBtn = eventBtn

    -- 判断岛怪功能是否开启
    local openMonster = mvc.bigSailPortModel:getIslandMonsterIsOpen()
    if openMonster then
        local monsterBtn = UI.Button:create()
        monsterBtn:init("ui_greatnavigation_icon_4.png", "ui_greatnavigation_icon_4.png")
        monsterBtn:rightBottom(330, 30)
        monsterBtn:addEventListener(UIEvent.BUTTON_CLICK,self,self.onRefreshMonster)
        contentLayout:addChild(monsterBtn)
    end

    local redPoint = AvalonUtil.createRedPoint(eventBtn, 2, 2, 100)
    redPoint:setName("redPoint")
    redPoint:hide()

    self:initIslandMapView()

    self:addSailingBoatLayer()

    self:refreshEventRedPoint()
end

function BigSailIslandShowMapView:initIslandMapView()
    local islandConfig = ConfigManager:getAllIslandsData()
    for k, v in pairs(islandConfig) do
        if v.islandSpine and v.islandSpine ~= "" then
            local islandNode = self.islandNodes:getNodeForSlot(v.islandSpine, true)
            if islandNode then
                local islandNodeSpine = UI.Animation:create()
                islandNodeSpine:init(v.islandSpine..".json", v.islandSpine..".atlas", 1);
                islandNodeSpine:center()
                islandNode:addChild(islandNodeSpine)
                islandNodeSpine:setAnimation("idle1", true)
                islandNodeSpine:setName(v.islandSpine)

                local islandLayout = UI.Layout:create()
                islandLayout:init()
                islandLayout:setSize(100, 100)
                islandLayout:center(0, 0)
                islandNodeSpine:addChild(islandLayout)

                islandLayout:setTouchEnable(true)
                islandLayout:setSwallowTouches(false)
                islandLayout:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self, sender, touchPosition)
                    self:showIslandInfo(k, touchPosition)
                end)
                self.islandNodeList[k] = islandNodeSpine
            end
        end
    end

    self:addBossIsland()
    self:updateIslandNodeView(true)
end

function BigSailIslandShowMapView:addBossIsland()
    local bossNode = self.islandNodes:getNodeForSlot("map_boss", true)
    if bossNode then
        local bossNodeSpine = UI.Animation:create()
        bossNodeSpine:init("map_boss.json", "map_boss.atlas", 1);
        bossNodeSpine:center()
        bossNode:addChild(bossNodeSpine)
        bossNodeSpine:setAnimation("idle1", true)
        bossNodeSpine:setName("map_boss")
        self.bossNodeSpine = bossNodeSpine

        local islandLayout = UI.Layout:create()
        islandLayout:init()
        islandLayout:setSize(330, 200)
        islandLayout:center(0, -20)
        bossNode:addChild(islandLayout)

        islandLayout:setTouchEnable(true)
        islandLayout:addEventListener(UI.Event.COMPONENT_CLICK, self, function(self, sender, touchPosition)
            self:showBossInfo(touchPosition)
        end)
    end
end

function BigSailIslandShowMapView:showIslandInfo(islandID, touchPosition)
    local pos = self.clipperInnerNode:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    local size = self.clipperInnerNode:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if not cc.rectContainsPoint(rect, pos) then
        self:onClose()
        return 
    end
    local data = {}
    data.landId = islandID

    -- 请求对应岛屿的信息
    Net.NetBigSailSystem:reqIslandInfo(data)

    local data2 = {data}
    -- data里面要有选中岛屿的id
    local bigSailIslandInfoView = UI.BigSailIslandInfoView:create(data2)
    bigSailIslandInfoView:init()
    bigSailIslandInfoView:center(0, 0)
    self.contentLayout:addChild(bigSailIslandInfoView, 10)
end

function BigSailIslandShowMapView:showBossInfo(touchPosition)
    local pos = self.clipperInnerNode:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    local size = self.clipperInnerNode:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if not cc.rectContainsPoint(rect, pos) then
        self:onClose()
        return 
    end
    
    mvc.openPanel("BigSailIsland", "BigSailIslandBossInfo")
end

function BigSailIslandShowMapView:refreshBigMap()
    self:updateIslandNodeView()
end

-- 航行船只状态栏
function BigSailIslandShowMapView:addSailingBoatLayer()
    local sailingBoatBar = UI.BigSailIslandBoatSailingLayer:create(self.contentLayout)
    sailingBoatBar:init()
    sailingBoatBar:center(-CLIPPER_WIDTH/2 - 192 , 176)
    self.clipperInnerNode:addChild(sailingBoatBar, 99)
    self.sailingBoatBar = sailingBoatBar
    sailingBoatBar:setName("sailingBoatBar")
end

-- 航行船只状态栏
function BigSailIslandShowMapView:updateEventDes()
    local nowTime = GameManager:getNormalServerTime()
    local bossShowTime = mvc.bigSailIslandModel:getBossShowTime()
    local bossOpenTime = mvc.bigSailIslandModel:getBossOpenTime()

    if nowTime < bossOpenTime and nowTime >= bossShowTime then
        self.eventBg:show()
        local time = AvalonUtil:getNewFullFormatTime(bossOpenTime, Game.TIME_LEVEL.TIME_LEVEL_MINUTE)
        local showStr = string.format(UI.TEXT_226210, time)
        self.eventDes:setText(showStr)
    end

    -- 丰收时间    
    local harvestStartTime, harvestShowTime, harvestEndTime = mvc.bigSailIslandModel:getHarvestOpenTime()
    if nowTime < harvestStartTime and nowTime >= harvestShowTime and nowTime < harvestEndTime then
        self.eventBg:show()
        local time = AvalonUtil:getNewFullFormatTime(harvestStartTime, Game.TIME_LEVEL.TIME_LEVEL_MINUTE)
        local showStr = string.format(UI.TEXT_226211, time)
        self.eventDes:setText(showStr)
    end
end


-- 刷新岛屿信息
function BigSailIslandShowMapView:updateIslandNodeView(isInit)
    local islandsData = mvc.bigSailIslandModel:getMapShowData()
    if islandsData.harvestIslands then
        for k, v in pairs(islandsData.harvestIslands) do
            if self.islandNodeList[v.islandid] then
                if not self.islandNodeList[v.islandid]:getChildByName("harvestSign") then
                    local yieldBonus = ConfigManager:getYieldBonusByID(v.harvestid)
                    local signName = yieldBonus.harvestSpine
                    local harvestSign = UI.Image:create()
                    harvestSign:init(signName)
                    harvestSign:leftBottom(0, 0)
                    harvestSign:setName("harvestSign")
                    self.islandNodeList[v.islandid]:addChild(harvestSign, 99)
                end
            end
        end
    end

    local baseInfo = mvc.bigSailPortModel:getBaseData()
    for k,v in pairs(baseInfo.useBoats) do
        if self.islandNodeList[v.islandId] then
            local boatAnimeName = self.islandNodeList[v.islandId]:getName().."_boat"
            local boatAnimeNode = self.islandNodes:getNodeForSlot(boatAnimeName, true)
            local boatAnimeIns = boatAnimeNode:getChildByName("boatAnime")
            if v.status == PublicDefine.BigSailBoatStatus.BigSailBoatingCaptured then
                if not boatAnimeIns then
                   
                    if boatAnimeNode then
                        local boatConfig = ConfigManager:getAllBoatDataByID(v.boatId)
                        local boatAnime = UI.Animation:create()
                        boatAnime:init("map_boat.json", "map_boat.atlas", 1);
                        boatAnime:center()
                        boatAnime:setName("boatAnime")
                        boatAnimeNode:addChild(boatAnime, 10)
                        boatAnime:setAnimation("idle", true)
                        -- local skinName = "boat"..v.boatId-23290000
                        boatAnime._spine:setSkin(boatConfig.navigationShowSpine)
                    end
                    
                end
            else 
                if boatAnimeIns then
                    boatAnimeIns:removeFromParent(true)
                    boatAnimeIns = nil
                end
            end
    
            local sailingMarkLayoutIns = self.islandNodeList[v.islandId]:getChildByName("sailingMarkLayout")
            if v.status == PublicDefine.BigSailBoatStatus.BigSailBoating then
                if  not sailingMarkLayoutIns then
                    local sailingMarkLayout = UI.Layout:create();
                    sailingMarkLayout:init()
                    sailingMarkLayout:setSize(146, 43)
                    sailingMarkLayout:centerUp(25)
                    sailingMarkLayout:setName("sailingMarkLayout")
                    self.islandNodeList[v.islandId]:addChild(sailingMarkLayout)
                    -- sailingMarkLayout:enableDebugDraw()
    
                    local boatingImg = UI.Image:create()
                    boatingImg:init("ui_greatnavigation_time_bg.png")
                    boatingImg:center()
                    boatingImg:setName("boatingImg")
                    sailingMarkLayout:addChild(boatingImg)
    
                    local time = AvalonUtil:getNewFullFormatTime(v.leftSailSeconds + GameManager:getNormalServerTime(), Game.TIME_LEVEL.TIME_LEVEL_MINUTE)
                    local leftTime = UI.Text:create()
                    leftTime:init(time, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
                    leftTime:center(15, 0)
                    sailingMarkLayout:addChild(leftTime)
                end
            else
                if sailingMarkLayoutIns then
                    sailingMarkLayoutIns:removeFromParent(true)
                    sailingMarkLayoutIns = nil
                end
            end
        end
        
    end

    local guildTargetIsland = mvc.bigSailIslandModel:getGuildOccupyIslandId()
    if self.islandNodeList[guildTargetIsland] then
        local guildMarkIns = self.islandNodeList[guildTargetIsland]:getChildByName("guildMark")

        self.lastMarkedIslandID = self.lastMarkedIslandID and self.lastMarkedIslandID or guildTargetIsland

        if guildTargetIsland and not guildMarkIns then
            local guildMark = UI.Image:create()
            guildMark:init("ui_greatnavigation_btn_flag_2.png")
            guildMark:center()
            guildMark:setName("guildMark")
            self.islandNodeList[guildTargetIsland]:addChild(guildMark)
        end
        if self.lastMarkedIslandID and tonumber(self.lastMarkedIslandID) ~= tonumber(guildTargetIsland) then
            local guildLastMarkIns = self.islandNodeList[self.lastMarkedIslandID]:getChildByName("guildMark")
            if guildLastMarkIns then
                guildLastMarkIns:removeFromParent(true)
                guildLastMarkIns = nil
                self.lastMarkedIslandID = guildTargetIsland
            end
        end
    end

    if guildTargetIsland == 0 then
        if self.lastMarkedIslandID then
            local guildLastMarkIns = self.islandNodeList[self.lastMarkedIslandID]:getChildByName("guildMark")
            if guildLastMarkIns then
                guildLastMarkIns:removeFromParent(true)
                guildLastMarkIns = nil
            end
        end
    end
    
    if not isInit then
        local sailingBoatBarIns = self.clipperInnerNode:getChildByName("sailingBoatBar")
        if sailingBoatBarIns then
            sailingBoatBarIns:removeFromParent(true)
            sailingBoatBarIns = nil
            self:addSailingBoatLayer()
        end
    end

    -- 岛怪生成(活动)
    self:clearAllMonsterIcon()
    local monsterData = mvc.bigSailPortModel:getIslandMonsterInfos()
    local openMonster = mvc.bigSailPortModel:getIslandMonsterIsOpen()
    if openMonster then
        for k, v in pairs(monsterData) do
            if self.islandNodeList[v.islandid] and (#v.monsterids > 0) then
                if not self.islandNodeList[v.islandid]:getChildByName("islandMonster") then
                    local yieldBonus = ConfigManager:getIslandMonsterByID(v.islandid)
                    local signName = "ui_greatnavigation_moster_1.png"
                    for k1,v1 in pairs(v.monsterids) do
                        if MONSTER_TYPE.BIG_MONSTER == v1 then
                            signName = "ui_greatnavigation_moster_2.png"
                        end
                    end

                    local monsterSign = UI.Image:create()
                    monsterSign:init(signName)
                    monsterSign:leftBottom(-30, 0)
                    monsterSign:setName("islandMonster")
                    self.islandNodeList[v.islandid]:addChild(monsterSign, 99)
                else
                    self:refreshMapIslandsMonster(v.islandid)
                end
            end
        end
    end

    self:updateEventDes()
end

function BigSailIslandShowMapView:clearAllMonsterIcon()
    local islandConfig = ConfigManager:getAllIslandsData()
    for k, v in pairs(islandConfig) do
        if self.islandNodeList[v.id] then
            local showMonsterNode = self.islandNodeList[v.id]:getChildByName("islandMonster")
            self.islandNodeList[v.id]:removeChildByName("islandMonster")
        end
    end
end

function BigSailIslandShowMapView:refreshMapIslandsMonster( islandid )
    -- 岛怪生成(活动)
    local islandID = islandid
    if self.islandNodeList[islandID] then
        local showMonsterNode = self.islandNodeList[islandID]:getChildByName("islandMonster")
        if showMonsterNode then
            local monsterData = mvc.bigSailPortModel:getIslandMonsterInfos()
            local openMonster = mvc.bigSailPortModel:getIslandMonsterIsOpen()

            if not openMonster then
                self.islandNodeList[islandID]:removeChildByName("islandMonster")
                return
            end

            local haveMonster = false
            for k,v in pairs(monsterData) do
                if v.islandid == islandID and (#v.monsterids > 0) then
                    local yieldBonus = ConfigManager:getIslandMonsterByID(v.islandid)
                    local signName = "ui_greatnavigation_moster_1.png"
                    for k1,v1 in pairs(v.monsterids) do
                        if MONSTER_TYPE.BIG_MONSTER == v1 then
                            signName = "ui_greatnavigation_moster_2.png"
                        end
                    end
                    showMonsterNode:setSpriteName(signName)
                    haveMonster = true
                    break
                end
            end
            if not haveMonster then
                self.islandNodeList[islandID]:removeChildByName("islandMonster")
            end
        end
    end
end

function BigSailIslandShowMapView:refreshMapBoat(islandid)
    local islandID = islandid
    if self.islandNodeList[islandID] then
        local boatAnimeName = self.islandNodeList[islandID]:getName().."_boat"
        local boatAnimeNode = self.islandNodes:getNodeForSlot(boatAnimeName, true)
        local boatAnimeIns = boatAnimeNode:getChildByName("boatAnime")
        if boatAnimeIns then
            performWithDelay(self, function() 
                boatAnimeIns:removeFromParent(true)
                boatAnimeIns = nil
            end, 0.1)           
        end

        local sailingMarkLayoutIns = self.islandNodeList[islandID]:getChildByName("sailingMarkLayout")
        if sailingMarkLayoutIns then
            sailingMarkLayoutIns:removeFromParent(true)
            sailingMarkLayoutIns = nil
        end
    end
end


function BigSailIslandShowMapView:onClickBag()
    mvc.openPanel("BigSailIsland", "BigSailIslandGetOccupyReward")
end

function BigSailIslandShowMapView:onClickRank()
    mvc.openPanel("BigSailIsland", "BigSailIslandRank")
end

function BigSailIslandShowMapView:onClickEvent()
    local bigSailEventView = require "app.modules.bigsailport.BigSailEventView"
    local sailLogView = bigSailEventView:create()
    sailLogView:init()
    sailLogView:center()
    self.contentLayout:addChild(sailLogView, 99)
end

function BigSailIslandShowMapView:onRefreshMonster()
    mvc.openPanel("BigSailIsland", "BigSailIslandFreshMonster")
end

function BigSailIslandShowMapView:refreshEventRedPoint()
    local eventShowRedPointList = mvc.bigSailPortModel:getRedPointIsShow()
    local eventRed = self.eventBtn:getChildByName("redPoint")
    if eventRed then
        for k, v in pairs(eventShowRedPointList) do
            if v then
                eventRed:show()
                break
            else
                eventRed:hide()
            end
        end
    end
end

function BigSailIslandShowMapView:onClose()
    mvc.closePanel("BigSailIsland", "BigSailIslandShowMap")
end

function BigSailIslandShowMapView:bindModel()
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_REFRESH_BIG_MAP,self, self.refreshBigMap)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_REFRESH_MAP_BOAT,self, self.refreshMapBoat)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_PORT_REFRESH_EVENT_RED_POINT,self, self.refreshEventRedPoint)
end


function BigSailIslandShowMapView:unbindModel()
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_REFRESH_BIG_MAP,self, self.refreshBigMap)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_REFRESH_MAP_BOAT,self, self.refreshMapBoat)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_PORT_REFRESH_EVENT_RED_POINT,self, self.refreshEventRedPoint)
end





return BigSailIslandShowMapView












