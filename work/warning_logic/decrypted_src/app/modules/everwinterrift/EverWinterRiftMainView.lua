------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/02/16
--desc	: 
------------------------------------------------------------------------------
require "app.modules.everwinterrift.EverWinterRiftDiffSelectLayer"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local EverWinterRiftMainView = class("EverWinterRiftMainView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")

-- 资源
local COM_RES_LIST = {
    "ui_town_petschallenge.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 1040
local COM_HEIGHT = 610

function EverWinterRiftMainView:ctor()
    EverWinterRiftMainView.super.ctor(
    	self,
    	UI.Type.MAIN_UI_EVER_WINTER,
        COM_RES_LIST,
        winSize.width,
        winSize.height
    )

    self.caveMode = PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT
    self.curDiff = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
    self.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(self.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
    self._gameMode = PublicDefine.GAME_MODE.MODE_SOLO
    self._canSweep = false
    self:bindModel()
end

function EverWinterRiftMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.everwinterrift", "EverWinterRift", false)
    EverWinterRiftMainView.super.init(self, ... )
end

function EverWinterRiftMainView:dtor()
    EverWinterRiftMainView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.everwinterrift.EverWinterRiftMainView")
end


function EverWinterRiftMainView:onInitView()
    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local clipper = UI.ClippingNode:create()
    clipper:initWithRect(760, 504)
    clipper:setOpacityFilterTouch(false)
    -- clipper:addInnerNode(contentLayout)
    -- clipper:center()
    -- rightContentLayout:setSize(760, 504)
    clipper:centerRight(0, 30)
    clipper:setName("clipper")
    self.contentLayout:addChild(clipper)
    self.clipper = clipper

    self:initLeftPanel()
    self:initRightPanel()

    performWithDelay(self, function() 
        self:updateInfo(mvc.everWinterRiftModel:getTabIndex())
    end, 0.01)
    
end

-- 模版函数：更新组建的视图
function EverWinterRiftMainView:onUpdateView()
    EverWinterRiftMainView.super.onUpdateView(self)
    
    self:selectButton(PublicDefine.GAME_MODE.MODE_SOLO)
end

function EverWinterRiftMainView:initLeftPanel()
    -- 左侧内容面板
    local leftContentLayout = UI.Layout:create()
    leftContentLayout:init()
    leftContentLayout:setSize(442, 604)
    leftContentLayout:centerLeft(10)
    -- leftContentLayout:enableDebugDraw()
    self.contentLayout:addChild(leftContentLayout, 5)
    self.leftContentLayout = leftContentLayout

    -- 背景图片
    -- local leftBg  = UI.Image:create()
    -- leftBg:init("ui_petschallenge_bg_left.png")
    -- leftBg:center()
    -- leftContentLayout:addChild(leftBg)
    local modeBgAnim = UI.Animation:create()
    modeBgAnim:init("effect_ui_town_selectfloor_foreverwinter.json", "effect_ui_town_selectfloor_foreverwinter.atlas", 1)
    modeBgAnim:center()
    leftContentLayout:addChild(modeBgAnim, 1)
    -- modeBgAnim:setAnimation("begin", false)
    self.modeBgAnim = modeBgAnim

    -- boss预览图
    local bossPic = UI.Image:create()
    bossPic:init("")
    bossPic:centerUp(75)
    leftContentLayout:addChild(bossPic, 2)
    self.bossPic = bossPic

    local selectDiffcultBtn = UI.Button:create()
    selectDiffcultBtn:init("ui_petschallenge_levelbg.png", "ui_petschallenge_levelbg.png", "ui_petschallenge_levelbg.png")
    selectDiffcultBtn:centerUp(275)
    selectDiffcultBtn:closeClickScale()
    selectDiffcultBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    selectDiffcultBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:openDiffSelectLayer()
    end)
    leftContentLayout:addChild(selectDiffcultBtn, 10)
    self.selectDiffcultBtn = selectDiffcultBtn

    local btnLight = UI.Animation:create()
    btnLight:init("effect_ui_town_foreverwinter_button_light.json", "effect_ui_town_foreverwinter_button_light.atlas", 1)
    btnLight:centerUp(305)
    leftContentLayout:addChild(btnLight, 11)
    btnLight:setAnimation("idle", true)

    local redPoint = AvalonUtil.createRedPoint(selectDiffcultBtn, 27, 2, 100)
    redPoint:setName("redPoint")
    redPoint:hide()
    self.redPoint = redPoint

    local challengeBtn = UI.Button:create()
    challengeBtn:init("ui_petschallenge_btn.png", "ui_petschallenge_btn.png", "ui_petschallenge_btn.png")
    challengeBtn:setText(UI.TEXT_1212081)
    challengeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    challengeBtn:centerBottom(80)
    challengeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:onChallengeBtnClick()
    end)
    leftContentLayout:addChild(challengeBtn, 10)
    self.challengeBtn = challengeBtn

    local challengeTimes = UI.Text:create()
    challengeTimes:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_192_202_203)
    challengeTimes:centerBottom(133)
    leftContentLayout:addChild(challengeTimes, 100)
    self.challengeTimes = challengeTimes

    -- 购买猫饭快捷方式
    local catFoodBg = UI.Image:create()
    catFoodBg:init("ui_petschallenge_catfoodbg.png")
    catFoodBg:leftBottom(365,157)
    leftContentLayout:addChild(catFoodBg,100)

    local catFoodBtn = UI.Button:create()
    catFoodBtn:init("ui_btn_catfood_0.png", "ui_btn_catfood_1.png", "ui_btn_catfood_0.png")
    catFoodBtn:center(0,-4)
    local parenLayer = self
    catFoodBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        print("caveModesss",self.caveMode)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_CATFOOD, 0, parenLayer, self.caveMode)
    end)
    catFoodBg:addChild(catFoodBtn, 10)

    local gameModeNode = self:createGameMode(PublicDefine.CAVE_MODE.MODE_EVER_WINTER_RIFT, function(gameMode)
        self:selectButton(gameMode)
    end)
    gameModeNode:centerBottom(166)
    leftContentLayout:addChild(gameModeNode, 10)
end

function EverWinterRiftMainView:initRightPanel()
    -- 右侧内容面板
    local rightContentLayout = UI.Layout:create()
    rightContentLayout:init()
    rightContentLayout:setSize(760, 504)
    rightContentLayout:center()
    self.rightContentLayout = rightContentLayout
    -- rightContentLayout:hide()
    self.clipper:addInnerNode(rightContentLayout)

    -- 背景图片
    local rightBg  = UI.Image:create()
    rightBg:init("ui_petschallenge_bg.png")
    rightBg:center()
    rightContentLayout:addChild(rightBg)

    local nameTitle = UI.Text:create()
    nameTitle:init(UI.TEXT_224200, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_41_41_45)
    nameTitle:leftUp(190, 48)
    rightContentLayout:addChild(nameTitle)

    local rewardTitle = UI.Text:create()
    rewardTitle:init(UI.TEXT_224201, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_41_41_45)
    rewardTitle:leftUp(190, 177)
    rightContentLayout:addChild(rewardTitle)

    local dropTitle = UI.Text:create()
    dropTitle:init(UI.TEXT_224202, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    dropTitle:center(44, -32)
    rightContentLayout:addChild(dropTitle)

    local passTitle = UI.Text:create()
    passTitle:init(UI.TEXT_224203, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    passTitle:center(44, 86)
    rightContentLayout:addChild(passTitle)


    -- local testLO = UI.Layout:create()
    -- testLO:init()
    -- testLO:setSize(430, 75)
    -- testLO:centerUp(95, 45)
    -- rightContentLayout:addChild(testLO)
    -- testLO:enableDebugDraw()

    local desc = UI.Text:create()
    desc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    desc:setWidth(420)
    desc:autoAdapt()
    desc:centerUp(1)
    self.desc = desc

    local desLayout = UI.Layout:create()
    desLayout:init()
    desLayout:addChild(desc)
    desLayout:setSize(430, 75)
    self.desLayout = desLayout

    local scrollView = UI.ScrollView:create()
    scrollView:init()
    scrollView:setSize(430, 75)
    scrollView:centerUp(95, 45)
    scrollView:addInnerNode(desLayout)
    scrollView:useDefaultScrollBar()
    rightContentLayout:addChild(scrollView)
    self.desScrollView = scrollView

    local getImg  = UI.Image:create()
    getImg:init("ui_petschallenge_btn_received.png")
    getImg:centerBottom(50, 40)
    rightContentLayout:addChild(getImg, 30)
    self.getImg = getImg
    getImg:hide()

    local getBtn = UI.Button:create()
    getBtn:init("ui_petschallenge_btn.png", "ui_petschallenge_btn.png", "ui_petschallenge_btn.png")
    getBtn:setText(UI.TEXT_111035)
    getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    getBtn:centerBottom(20, 40)
    getBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:onGetRewards()
    end)
    rightContentLayout:addChild(getBtn, 10)
    self.getBtn = getBtn
    getBtn:setVisible(false)

    local closeBtn = UI.Button:create()
    closeBtn:init("ui_petschallenge_close.png", "ui_petschallenge_close.png", "ui_petschallenge_close.png")
    closeBtn:rightUp(5, 5)
    closeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        mvc.closePanel("EverWinterRift", "EverWinterRiftMain")
    end)
    rightContentLayout:addChild(closeBtn, 100)

    performWithDelay(self, function()
        self:showPannelAction(rightContentLayout)
    end, 0.01)
    
end

function EverWinterRiftMainView:showPannelAction(pannel)
    self.modeBgAnim:setAnimation("begin", false)
    local posX, posY = pannel:getPosition()
    -- local worldPos = pannel:convertToWorldSpace(cc.p(posX,posY))
    -- print("showPannelAction:", worldPos)
    pannel:centerLeft(-900)
    -- pannel:show()  
    -- pannel:setAnchorPoint(0, 0)
    local baseTime = 0.2

    local moveAnimation = cc.MoveTo:create(baseTime, {x = posX, y = posY})
    local action = cc.Sequence:create(moveAnimation, cc.CallFunc:create(
        function()
            -- self:setVisible(show)
            self.modeBgAnim:addAnimation("idle")
        end)
    )
    pannel:runAction(action)
end

function EverWinterRiftMainView:createGameMode(caveMode, clickCallback)
    local nodeLayout = UI.Layout:create()
    nodeLayout:init()
    nodeLayout:setSize(214, 0)

    -- local btnImageArr = self:getCaveModeImageArr(caveMode)
    self.singlePlayBtn = UI.Button:create()
    self.singlePlayBtn:init("ui_btn_single_19.png", "ui_btn_single_8.png", "ui_btn_single_19.png")
    self.singlePlayBtn:leftBottom(0, 0)
    self.singlePlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if(clickCallback) then 
            clickCallback(PublicDefine.GAME_MODE.MODE_SOLO)
        end
        self:refreshGameModeBtnCheckState(PublicDefine.GAME_MODE.MODE_SOLO)
    end)
    nodeLayout:addChild(self.singlePlayBtn, 10)

    self.teamPlayBtn = UI.Button:create()
    self.teamPlayBtn:init("ui_btn_many_19.png", "ui_btn_many_8.png", "ui_btn_many_19.png")
    self.teamPlayBtn:leftBottom(70, 0)
    self.teamPlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if(clickCallback) then 
            clickCallback(PublicDefine.GAME_MODE.MODE_TEAM)
        end
        self:refreshGameModeBtnCheckState(PublicDefine.GAME_MODE.MODE_TEAM)
        Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
    end)
    nodeLayout:addChild(self.teamPlayBtn, 10)
    self.teamPlayBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS,self, function()
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
            Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
        end
    end)

    self.mercenaryPlayBtn = UI.Button:create()
    self.mercenaryPlayBtn:init("ui_btn_mercenary_19.png", "ui_btn_mercenary_18.png", "ui_btn_mercenary_19.png")
    self.mercenaryPlayBtn:leftBottom(160, 0)
    self.mercenaryPlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if(clickCallback) then 
            clickCallback(PublicDefine.GAME_MODE.MODE_MERCENARY)
        end
        self:refreshGameModeBtnCheckState(PublicDefine.GAME_MODE.MODE_MERCENARY)
        Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary)
    end)
    nodeLayout:addChild(self.mercenaryPlayBtn, 10)
    self.mercenaryPlayBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS,self, function()
        if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary) then
            Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary)
            return
        end

        local masterData = GameDataManager:getInstance():getMaster()
        local guildBossLimit = ConfigManager:getGuildConfigForKey("guildMercenaryTimeLimit")
        if(guildBossLimit == nil) then 
            guildBossLimit = SECONDS_ONE_DAY
        end
        local waitingTime = masterData:getJoinGuildTime() + guildBossLimit - GameManager:getNormalServerTime()
        if not MasterDataManager:getGuildData() or waitingTime > 0 then 
            local LanguageManager = require("app.game.LanguageManager")
            if(not MasterDataManager:getGuildData()) then 
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110668))
                return
            end

            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170306))
            return
        end
    end)

    self:changeCaveMode(caveMode)

    return nodeLayout
end

function EverWinterRiftMainView:selectButton(gameMode)
        self:refreshTeamBtnState()
        self:refreshGameModeBtnCheckState(gameMode)
        LevelSelectUtil:getInstance():setPattern(gameMode)
        -- self:refreshNotice(gameMode)
        self:updateInfo(mvc.everWinterRiftModel:getTabIndex())
end

function EverWinterRiftMainView:changeCaveMode(caveMode)
    self.singlePlayBtn:setNormal("ui_btn_single_19.png")
    self.singlePlayBtn:setSelected("ui_btn_single_8.png")
    self.singlePlayBtn:setDisabled("ui_btn_single_19.png")
    self.teamPlayBtn:setNormal("ui_btn_many_19.png")
    self.teamPlayBtn:setSelected("ui_btn_many_8.png")
    self.teamPlayBtn:setDisabled("ui_btn_many_19.png")
    self.mercenaryPlayBtn:setNormal("ui_btn_mercenary_19.png")
    self.mercenaryPlayBtn:setSelected("ui_btn_mercenary_18.png")
    self.mercenaryPlayBtn:setDisabled("ui_btn_mercenary_19.png")
end

function EverWinterRiftMainView:refreshNotice(btnId)
    if(self._noticeImageBg) then
        if (btnId == nil or btnId ~= PublicDefine.GAME_MODE.MODE_SOLO) then 
            self._noticeImageBg:setVisible(true)
            if(btnId == PublicDefine.GAME_MODE.MODE_MERCENARY) then
                self._noticeText:setText(UI.TEXT_1325708)
            else
                self._noticeText:setText(LanguageManager:getInstance():getLocalString(1112016))
            end
            local noticeImageBg = self._noticeImageBg
            local iconImage =  self._iconImage
            local noticeText = self._noticeText
            local startX = (noticeImageBg:getContentSize().width - iconImage:getContentSize().width - noticeText:getContentSize().width)/2
            iconImage:centerLeft(startX)
            noticeText:centerLeft(startX + iconImage:getContentSize().width + 14)
        else
            self._noticeImageBg:setVisible(false)
        end
    end
end

function EverWinterRiftMainView:refreshTeamBtnState()
    self:refreshGameModeState()
end

function EverWinterRiftMainView:refreshGameModeState()
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
        self.teamPlayBtn:enable()
        if Game.FunctionUnlockManager:getInstance():isShowNewAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
            ToolsUtil:playNewAction(self.teamPlayBtn, 0.8)
        else
            ToolsUtil:removeNewAction(self.teamPlayBtn)
        end
    else
        self.teamPlayBtn:disable()
    end

    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary) then
        local masterData = GameDataManager:getInstance():getMaster()
        local guildBossLimit = ConfigManager:getGuildConfigForKey("guildMercenaryTimeLimit")
        if(guildBossLimit == nil) then 
            guildBossLimit = SECONDS_ONE_DAY
        end
        local waitingTime = masterData:getJoinGuildTime() + guildBossLimit - GameManager:getNormalServerTime()
        if MasterDataManager:getGuildData() and waitingTime <=0 then 
            self.mercenaryPlayBtn:enable()
            if Game.FunctionUnlockManager:getInstance():isShowNewAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary) then
                ToolsUtil:playNewAction(self.mercenaryPlayBtn, 0.8)
            else
                ToolsUtil:removeNewAction(self.mercenaryPlayBtn)
            end
        else
            self.mercenaryPlayBtn:disable()
        end
    else
        self.mercenaryPlayBtn:disable()
    end
end

function EverWinterRiftMainView:refreshGameModeBtnCheckState(gameMode)
    self._gameMode = gameMode
    if not self.singlePlayBtn:isDisable() then
        self.singlePlayBtn:setBtnStatus(ButtonState.NORMAL)
    else
        if(gameMode == PublicDefine.GAME_MODE.MODE_SOLO) then 
            return
        end
    end

    if not self.teamPlayBtn:isDisable() then
        self.teamPlayBtn:setBtnStatus(ButtonState.NORMAL)
    else
        if(gameMode == PublicDefine.GAME_MODE.MODE_TEAM) then 
            return
        end
    end
    if not self.mercenaryPlayBtn:isDisable() then
        self.mercenaryPlayBtn:setBtnStatus(ButtonState.NORMAL)
    else
        if(gameMode == PublicDefine.GAME_MODE.MODE_MERCENARY) then 
            return
        end
    end

    if gameMode == PublicDefine.GAME_MODE.MODE_SOLO then
        self.singlePlayBtn:setBtnStatus(ButtonState.ACTIVE)
    elseif gameMode == PublicDefine.GAME_MODE.MODE_TEAM then
        -- body
        self.teamPlayBtn:setBtnStatus(ButtonState.ACTIVE)
    elseif gameMode == PublicDefine.GAME_MODE.MODE_MERCENARY then
        self.mercenaryPlayBtn:setBtnStatus(ButtonState.ACTIVE)
    end
end

function EverWinterRiftMainView:onChallengeBtnClick()
    self.mBClick = true
    self.lockAllBtn = false
    local totalTiems = ConfigManager:getGeneralForKey("everwinterRiftDailyChallenges")
    totalTiems = tonumber(totalTiems)
    local everWinterRiftData = mvc.everWinterRiftModel:getEverWinterRiftData()
    local extraFightNum = everWinterRiftData.extraFightNum or 0
    local fightNum = everWinterRiftData.fightNum or 0
    if totalTiems<=fightNum and extraFightNum <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1328010)
        return 
    end

    local freePacketNum = GameDataManager:getInstance():getFreePetGemStoneBoxNum()
    if(freePacketNum <= 0) then
        UI.ScrollBar:createByTextID(1110793)
        return 
    end

    if self._canSweep then

        local doubleBuffID = ConfigManager:getGeneralForKey("doubleDropBuffId")
        local useBuffer = SkillDataManager:judgeMasterHaveBuff(tonumber(doubleBuffID))

        print("useBuffer ==== ",useBuffer)
        
        local needNum = 0
        local config = ConfigManager:getAllEverwinterRiftDataByID(mvc.everWinterRiftModel:getTabIndex())

        if config then
            needNum = config.dropNum or 0
        end

        if useBuffer then
            needNum = needNum * 2
        end

        if freePacketNum < needNum then
            UI.ScrollBar:createByTextID(1110793)
            return 
        end

        --扫荡逻辑
        Net.NetPlaySystem:requestEverwinterRiftSweep(mvc.everWinterRiftModel:getTabIndex())
        return
    end


    if LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_SOLO
        or LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_MERCENARY then
        
        local curLevel = mvc.everWinterRiftModel:getTabIndex()
        if (RoleBehaviorManager:enterCaveCheck()) then 
            local id = LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(mvc.everWinterRiftModel:getCurLevel())--(self.selectedIcon:getTag())
            if(LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_SOLO) then
                Net.NetRoleSystem:heroEnterCaveSceneRequest(
                    LevelSelectUtil:getInstance().mPattern,
                    self.caveMode,
                    self.curDiff,
                    id,
                    self.spriteID)
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            elseif LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_MERCENARY then
                local messageData = {}
                messageData.difficulty = self.curDiff
                messageData.level = id
                messageData.caveMode = self.caveMode
                messageData.mode = LevelSelectUtil:getInstance().mPattern
                messageData.useSchemeInHero = useSchemeInHero
                mvc.openPanel("Mercenary", "Mercenary", messageData)
            end
        end 
    else
        LevelSelectUtil:getInstance().mSelectLevel = mvc.everWinterRiftModel:getCurLevel()--(mvc.everWinterRiftModel:getTabIndex())
        LevelSelectUtil:getInstance():setCaveMode(self.caveMode)
        LevelSelectUtil:getInstance():setDifficulty(self.curDiff)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,1)
        self:clickClose()
    end
end

function EverWinterRiftMainView:openDiffSelectLayer()
    local diffSelectLayer = self.contentLayout:getChildByName("diffSelectLayer")
    if not diffSelectLayer then
        diffSelectLayer = UI.EverWinterRiftDiffSelectLayer:create()
        diffSelectLayer:init() 
        diffSelectLayer:center(0, 0)
        diffSelectLayer:setName("diffSelectLayer")
        self:addChild(diffSelectLayer, 100001);
    else
        -- diffSelectLayer:updateToShow(self.curPet:getId())
    end
end


function EverWinterRiftMainView:updateInfo(idx)
    if not idx then
        idx = mvc.everWinterRiftModel:getTabIndex()
    end
    if idx ~= mvc.everWinterRiftModel:getTabIndex() then
        return
    end

    local config = ConfigManager:getAllEverwinterRiftDataByID(idx)
    local singleDrop = config.singleDrop or {}
    local dropList = {}
    for k, v in pairs(singleDrop) do
        local data = GoodsDataManager:createLocalGoodsData(v)
        table.insert(dropList, data)
    end
    if LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_TEAM then
        local teamDrop = config.teamDrop or {}
        for k, v in pairs(teamDrop) do
            local data = GoodsDataManager:createLocalGoodsData(v)
            if data then
                data.isTeam = true
                table.insert(dropList, data)
            end
        end
    end

    local len = #dropList
    if self.dropRewardNode then
        self.dropRewardNode:removeFromParent()
        self.dropRewardNode = nil
    end
    local rewardNode = UI.RewardPreViewUtil:create()
    rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    rewardNode:init(dropList, 5, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(5, 0))
    rewardNode:center(44, 30)
    -- for k, v in pairs(singleDrop) do 
    --     rewardNode:addGoodsId(v, 0)
    -- end
    rewardNode:showGoodsView()
    self.rightContentLayout:addChild(rewardNode)
    self.dropRewardNode = rewardNode

    if self.passRewardNode then
        self.passRewardNode:removeFromParent()
        self.passRewardNode = nil
    end
    local idList = {}
    local numList = {}
    local rewardList = string.split(config.firstPassReward, ";")
    -- local rewardList = string.split(rewardRangeList[range], ";")
    for k, v in pairs(rewardList) do
        local itemData = string.split(v, ",")
        table.insert(idList, tonumber(itemData[1]))
        table.insert(numList, tonumber(itemData[2]))
    end

    local len = #idList >= 5 and 5 or #idList
    local passRewardNode = UI.RewardPreViewUtil:create()
    passRewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    passRewardNode:init(nil, len, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(5, 0))
    passRewardNode:center(44, 146)
    for k, v in pairs(idList) do 
        passRewardNode:addGoodsId(v, numList[k] or 0)
    end
    passRewardNode:showGoodsView()
    self.rightContentLayout:addChild(passRewardNode)
    self.passRewardNode = passRewardNode

    local isGet = mvc.everWinterRiftModel:checkIsGetRewardsByID(config.copyLv)
    self.getImg:setVisible(isGet)
    if isGet then
        self.getBtn:setVisible(false)
    end
    local canGet = mvc.everWinterRiftModel:checkIsCanGetRewardsByID(config.copyLv)
    if not isGet then
        self.getBtn:setVisible(canGet)
        self.getBtn:enable()
    end

    self.bossPic:setSpriteName(config.showPicture)

    self.redPoint:setVisible(mvc.everWinterRiftModel:checkIsCanGetRewards())

    self:updateDes(config)

    local nextOpenOrEnd = self.curOpenLevel >= mvc.everWinterRiftModel:getCurLevelByCopyLevel(idx + 1)
    local config2 = ConfigManager:getAllEverwinterRiftDataByID(idx + 1)
    if not config2 then
        nextOpenOrEnd = true
    end

    -- 已通关单人模式可扫荡
    if (isGet or canGet) and self._gameMode == PublicDefine.GAME_MODE.MODE_SOLO and nextOpenOrEnd then
        if self.challengeBtn then
            self.challengeBtn:setText(UI.TEXT_1324354)
        end
        self._canSweep = true
    else
        if self.challengeBtn then
            self.challengeBtn:setText(UI.TEXT_1212081)
        end
        self._canSweep = false
    end

end

function EverWinterRiftMainView:updateDes(config)
    local totalTiems = ConfigManager:getGeneralForKey("everwinterRiftDailyChallenges")
    totalTiems = tonumber(totalTiems)
    local everWinterRiftData = mvc.everWinterRiftModel:getEverWinterRiftData()
    local extraFightNum = everWinterRiftData.extraFightNum or 0
    local fightNum = everWinterRiftData.fightNum or 0
    local challengeTimes = totalTiems-fightNum+extraFightNum
    self.challengeTimes:setText(string.format(UI.TEXT_224205, challengeTimes))

    self.selectDiffcultBtn:setText(LanguageManager:getInstance():getLocalString(config.name))
    self.desc:setText(LanguageManager:getInstance():getLocalString(config.des))
    local height = self.desc:getContentSize().height
    height = height < 75 and 75 or height
    self.desLayout:setSize(420, height)
end

function EverWinterRiftMainView:onGetRewards()
    local tabIndex = mvc.everWinterRiftModel:getTabIndex()
    Net.NetRoleSystem:reqGetEverWinterRiftRewards(tabIndex)
end

function EverWinterRiftMainView:clickClose()
    mvc.closePanel("EverWinterRift", "EverWinterRiftMain")
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
end

function EverWinterRiftMainView:bindModel()

end

function EverWinterRiftMainView:unbindModel()

end





return EverWinterRiftMainView












