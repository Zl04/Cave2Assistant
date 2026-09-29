local temp = require("app.uiExport.caveEnterModel")
require("app.utils.RewardPreViewUtil")
require("app.ui.common.RewardLayer")

local LanguageManager = require("app.game.LanguageManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")

local TownCaveEnterLayer = class("TownCaveEnterLayer", UI.Component)
UI.TownCaveEnterLayer = TownCaveEnterLayer

local singlePlayerBtnId = PublicDefine.GAME_MODE.MODE_SOLO
local teamPlayerBtnId = PublicDefine.GAME_MODE.MODE_TEAM

local COM_RES_LIST = {
    "ui_selectlevel_checkPoint.plist", 
    "ui_town_levelselect.plist", 
}

local leftNodeWidth = 400

function TownCaveEnterLayer:ctor()
    --窗口大小
    self.showStatus = false
    self.closeFlag = false
    TownCaveEnterLayer.super.ctor(self, UIType.ENTER_CAVE_LAYER, COM_RES_LIST, 284, 602)
    self:init();
    self:centerLeft(0)
    self.levelSelectLayerIconNode = nil
end

--虚构函数,destroy时调用(必备)
function TownCaveEnterLayer:dtor()
    TownCaveEnterLayer.super.dtor(self)
end

-- 初始化(必备)
function TownCaveEnterLayer:init()
    TownCaveEnterLayer.super.init(self)
end

-- 模版函数：初始化组建的视图(必备)
function TownCaveEnterLayer:onInitView()

    self.rootData = temp.create("bg")
    self:addChild(self.rootData.root)

    local offset = 35
    self.desContentPos = self.rootData.boxDesLayer._up
    self.boxLayerPos = self.desContentPos - offset
    self.smallSize = self.rootData.boxDesLayer:getContentSize();
    self.bigSize = self.rootData.boxDesLayer:getContentSize();
    self.bigSize.height = self.bigSize.height + offset

    self:refreshUI();
    self:initEvent()

end

function TownCaveEnterLayer:gateConfigValue(key)
    local value = self.gateConfig[key]
    if value == nil then
        printError("value is nil for key:", key)
    else
        return value[self.configIndex]
    end
end

function TownCaveEnterLayer:initGateConfig()
    self.configIndex = 1
    self.gateId = LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(LevelSelectUtil:getInstance().mSelectLevel)
    local list = ConfigManager:getAllLevelSelectDataByType(LevelSelectUtil:getInstance().mCaveMode)
    for k, v in ipairs(list) do
        self.configIndex = 1
        for k2, cfgLevel in ipairs(v.includeLevel) do
            if self.gateId == cfgLevel then
                self.configIndex = k2
                self.gateConfig = v
                return
            end
        end
    end
end

function TownCaveEnterLayer:refreshUI()

    self:initGateConfig()
    self:refreshTeamBtnState()
    self:selectButton(singlePlayerBtnId)

    -- 初始化标题
    local titleStr = LanguageManager:getInstance():getLocalString(self:gateConfigValue("levelname"))
    if LevelSelectUtil:getInstance().mCaveMode ~= PublicDefine.CAVE_MODE.MODE_HERO or
    LevelSelectUtil:getInstance().mCaveMode ~= PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
       titleStr = string.format(titleStr, LevelSelectUtil:getInstance():getBeginCaveLevelForShopLevel(self.gateId))
    end
    self.rootData.title:setText(titleStr)
    -- 初始化描述
    self:createDesContent()
    -- 初始化奖励道具 新版UI移动到了地图界面上
    --self:createRewardList()
end

-- 有事件需要展示宝箱，内容页就要下移一点
-- 无事件则显示关卡描述
function TownCaveEnterLayer:createDesContent()
    local eventList = {}
    local isUsed = false
    local isHeroModel = LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_HERO
    if isHeroModel then
        eventList, isUsed = MasterDataManager:getHeroCaveSpecialEnventBySceneId(self.gateConfig.ID)
    end

    isHeroModel = LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO
    if isHeroModel then
        eventList, isUsed = MasterDataManager:getTitanHeroCaveSpecialEnventBySceneId(self.gateConfig.ID)
    end

    self.rootData.splitLine2:setVisible(isHeroModel)

    local eventSize = #eventList

    local size = self.bigSize
    local desStrId = 1111340
    if eventSize > 0 and not isUsed then
        -- 计算事件箱子的等级
        self.rootData.boxLayer:setVisible(eventSize > 0 and isUsed)
        self.boxLevel = ConfigManager:getEventBoxLevel(eventList)
        local boxIcon = self.gateConfig.eventIcon[self.boxLevel]
        self.rootData.boxIcon:setSpriteName(boxIcon)
        self.rootData.boxDesLayer:leftUp( self.rootData.boxDesLayer._left, self.desContentPos)
        size = self.smallSize
    else
        desStrId = self:gateConfigValue("levelDescription")
        self.rootData.boxDesLayer:leftUp( self.rootData.boxDesLayer._left, self.boxLayerPos)
    end

    self.rootData.boxDesLayer:removeAllChildren()
    local detailedScrollView = UI.ScrollView:create()
    detailedScrollView:setSize(size.width * 2, size.height)
    detailedScrollView:init(0, 0, 0, 0)
    detailedScrollView:leftUp(0, 0)
    self.rootData.boxDesLayer:addChild(detailedScrollView)

    local contentNode = UI.Component:create()
    contentNode:init()

    local posY = 0
    local contentText = temp.create("eventInfoTempText").root
    contentText:leftUp(0, 0)
    contentText:setTextById(desStrId)
    contentNode:addChild(contentText)
    posY = contentText:getContentSize().height + 10

    if eventSize > 0 then
        for i = 1, eventSize, 1 do
            local data = ConfigManager:getSpecialEventDataById(eventList[i])
            local eventNodeData = temp.create("eventDesTemp")
            eventNodeData.eventDesTempText:setText(data.name .. ":".. data.description)
            eventNodeData.root:setSize(eventNodeData.root:getContentSize().width, eventNodeData.eventDesTempText:getContentSize().height)
            contentNode:addChild(eventNodeData.root)
            eventNodeData.root:leftUp(0, posY)
            posY = posY + eventNodeData.root:getContentSize().height
        end
    end
    --contentNode:enableDebugDraw()
    contentNode:setSize(size.width, posY)
    detailedScrollView:addInnerNode(contentNode)
    detailedScrollView:updateView()
end

function TownCaveEnterLayer:createRewardList()
    local winSize = cc.Director:getInstance():getWinSize()
    self.rootData.rewardLayer:removeAllChildren()
    local rewardNode = UI.RewardPreViewUtil:create()
    rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.left)
    rewardNode:init(nil, 3, 2, UI.ScrollType.HORIZONTAL, cc.size(20, 0))
    rewardNode:centerUp(0, 0)

    local rewardData = self:gateConfigValue("BoxDrop")
    local idList = string.split(rewardData, ",")
    for k, v in pairs(idList) do 
        rewardNode:addGoodsId(tonumber(v), 0)
    end
    rewardNode:showGoodsView()
    rewardNode:setTipOffset(cc.p(winSize.width - self:getContentSize().width - 10, 0))

    --self.rootData.rewardLayer:enableDebugDraw()
    self.rootData.rewardLayer:addChild(rewardNode)

end

function TownCaveEnterLayer:initEvent()
    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self, comp, pos)
    end)    
    self.rootData.singlePlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.playModelBtnClick)
    self.rootData.teamPlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.playModelBtnClick)
    self.rootData.teamPlayBtn:addEventListener(UI.Event.BUTTON_DISABLE, self, self.playModelBtnClick)
    self.rootData.startBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.startGame)
    self.rootData.boxBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.boxBtnClick)

    self.rootData.boxBtn:setCustomToucRect(cc.rect(-20, 0, 200, self.rootData.boxBtn._height))
    
    self.rootData.teamPlayBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS,self, function()
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
            Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
        end
    end)
end

function TownCaveEnterLayer:playModelBtnClick(node)
    if node == self.rootData.singlePlayBtn then
        self:selectButton(singlePlayerBtnId)
    else
        if TeamDataManager:getPunishmentState() >= 2 then
            UI.ScrollBar:createByText(string.format(UI.TEXT_110072, ConfigManager:getPunishmentTime() / 60))
            return
        end
        Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
        self:selectButton(teamPlayerBtnId)
    end
end

function TownCaveEnterLayer:selectButton(btnId)
    self.rootData.singlePlayBtn:setBtnStatus(ButtonState.NORMAL)
    self.rootData.teamPlayBtn:setBtnStatus(ButtonState.NORMAL)
    if btnId == singlePlayerBtnId then
        self.rootData.singlePlayBtn:setBtnStatus(ButtonState.ACTIVE)
    else
        self.rootData.teamPlayBtn:setBtnStatus(ButtonState.ACTIVE)
    end
    LevelSelectUtil:getInstance():setPattern(btnId)
end

function TownCaveEnterLayer:hiddenLayer()
    self:playShowAction(false)
end

function TownCaveEnterLayer:showLayer(time)
    self:playShowAction(true, time)
end

function TownCaveEnterLayer:closeLayer()
    self.closeFlag = true
    self:playShowAction(false)
end

function TownCaveEnterLayer:playShowAction(show, time)
    if self.showStatus == show then
        return
    end
    self.showStatus = show
    local size = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
    local posY = (size.height - self:getContentSize().height) / 2
    local posX = 0
    if show then
        posX = 0
        self:setVisible(true)
        self:centerLeft(-leftNodeWidth)
    else
        posX = -leftNodeWidth
    end

    local baseTime = 0.2

    local moveAnimation = cc.MoveTo:create(baseTime, {x = posX, y = posY})
    local action = cc.Sequence:create(moveAnimation, cc.CallFunc:create(
        function()
            self:setVisible(show)
            if self.closeFlag then
                self:removeFromParent();
            end
        end)
    )
    self:runAction(action)
end

function TownCaveEnterLayer:refreshTeamBtnState()
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
        self.rootData.teamPlayBtn:enable()
        if Game.FunctionUnlockManager:getInstance():isShowNewAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
            ToolsUtil:playNewAction(self.rootData.teamPlayBtn, 0.8)
        else
            ToolsUtil:removeNewAction(self.rootData.teamPlayBtn)
        end
    else
        self.rootData.teamPlayBtn:disable()
    end
end

function TownCaveEnterLayer:startGame()
    if self.levelSelectLayerIconNode and self.levelSelectLayerIconNode.showStartAnimation then
        self.levelSelectLayerIconNode.showStartAnimation()
    end
end

function TownCaveEnterLayer:boxBtnClick()
    if self.boxLevel ~= nil then
        local rewardData = nil
        if self.boxLevel == 1 then
            rewardData = self.gateConfig.BoxDrop1[1]
        elseif self.boxLevel == 2 then
            rewardData = self.gateConfig.BoxDrop2[1]
        elseif self.boxLevel == 3 then
            rewardData = self.gateConfig.BoxDrop3[1]
        end
        if rewardData then
            local idList = string.split(rewardData, ",")
            print("rewardData:",  rewardData)
            local goodsDataList = {}
            for k, v in pairs(idList) do
                local data = GoodsDataManager:createLocalGoodsData(tonumber(v))
                if data ~= nil then
                    data:setNum(0)
                    table.insert(goodsDataList, data)
                end
            end

            Avalon.MessageCenter:notice(GameMessage.MC_UI_COMMON_REWARD, goodsDataList, nil, LanguageManager:getInstance():getLocalString(1111339), nil, UI.RewardLayer.Style.notShowAnyButton)     
        end
    end
end

