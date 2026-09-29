------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/11/28
--desc	: 
------------------------------------------------------------------------------
require "app.modules.deepinwormhole.DeepInWormholeDiffSelectLayer"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DeepInWormholeMainView = class("DeepInWormholeMainView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")

-- 资源
local COM_RES_LIST = {
    "ui_town_petschallenge.plist",
    "ui_town_wormhole.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local COM_WIDTH = 1040
local COM_HEIGHT = 610

function DeepInWormholeMainView:ctor()
    DeepInWormholeMainView.super.ctor(
    	self,
    	UI.Type.MAIN_UI_WORMHOLE,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.caveMode = PublicDefine.CAVE_MODE.MODE_WORMHOLE
    self.curDiff = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
    
    self:bindModel()
end

function DeepInWormholeMainView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.deepinwormhole", "DeepInWormhole", false)
    DeepInWormholeMainView.super.init(self, ... )
end

function DeepInWormholeMainView:dtor()
    DeepInWormholeMainView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.deepinwormhole.DeepInWormholeMainView")
end


function DeepInWormholeMainView:onInitView()
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
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local clipper = UI.ClippingNode:create()
    clipper:initWithRect(760, 504)
    clipper:setOpacityFilterTouch(false)
    -- clipper:addInnerNode(contentLayout)
    -- clipper:center()
    -- rightContentLayout:setSize(760, 504)
    clipper:centerRight(-50, 39)
    clipper:setName("clipper")
    self.contentLayout:addChild(clipper)
    self.clipper = clipper
    -- clipper:enableDebugDraw()

    self:initLeftPanel()
    self:initRightPanel()

    performWithDelay(self, function() 
        self:updateInfo(mvc.deepInWormholeModel:getTabIndex())
    end, 0.01)
    
end

-- 模版函数：更新组建的视图
function DeepInWormholeMainView:onUpdateView()
    DeepInWormholeMainView.super.onUpdateView(self)
    
    self:selectButton(PublicDefine.GAME_MODE.MODE_TEAM)
end

function DeepInWormholeMainView:initLeftPanel()
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
    modeBgAnim:init("effect_ui_town_selectfloor_wormhole.json", "effect_ui_town_selectfloor_wormhole.atlas", 1)
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
    selectDiffcultBtn:init("ui_wormhole_levelbg.png", "ui_wormhole_levelbg.png", "ui_wormhole_levelbg.png")
    selectDiffcultBtn:centerUp(140)
    selectDiffcultBtn:closeClickScale()
    selectDiffcultBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_117_213_255)
    selectDiffcultBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:openDiffSelectLayer()
    end)
    leftContentLayout:addChild(selectDiffcultBtn, 10)
    self.selectDiffcultBtn = selectDiffcultBtn

    -- local btnLight = UI.Animation:create()
    -- btnLight:init("effect_ui_town_foreverwinter_button_light.json", "effect_ui_town_foreverwinter_button_light.atlas", 1)
    -- btnLight:centerUp(305)
    -- leftContentLayout:addChild(btnLight, 11)
    -- btnLight:setAnimation("idle", true)

    local challengeBtn = UI.Button:create()
    challengeBtn:init("ui_wormhole_btn.png", "ui_wormhole_btn.png", "ui_wormhole_btn.png")
    challengeBtn:setText(UI.TEXT_1212081)
    challengeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_41_41_45)
    challengeBtn:centerBottom(20)
    challengeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:onChallengeBtnClick()
    end)
    leftContentLayout:addChild(challengeBtn, 10)

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

    local levelLimitText = UI.Text:create()
    levelLimitText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_202_171_67)
    levelLimitText:centerBottom(80)
    leftContentLayout:addChild(levelLimitText, 10)
    self.levelLimitText = levelLimitText

    local gameModeNode = self:createGameMode(PublicDefine.CAVE_MODE.MODE_WORMHOLE, function(gameMode)
        self:selectButton(gameMode)
    end)
    gameModeNode:centerBottom(106)
    leftContentLayout:addChild(gameModeNode, 10)
end

function DeepInWormholeMainView:initRightPanel()
    -- 右侧内容面板
    local rightContentLayout = UI.Layout:create()
    rightContentLayout:init()
    rightContentLayout:setSize(650, 475)
    rightContentLayout:centerBottom(-28)
    self.rightContentLayout = rightContentLayout
    -- rightContentLayout:hide()
    self.clipper:addInnerNode(rightContentLayout)

    -- 背景图片
    local rightBg  = UI.Image:create()
    rightBg:init("ui_wormhole_bg.png")
    rightBg:center()
    rightContentLayout:addChild(rightBg)
    -- rightBg:hide()

    local nameTitle = UI.Text:create()
    nameTitle:init("", UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_41_41_45)
    nameTitle:leftUp(120, 54)
    rightContentLayout:addChild(nameTitle)
    self.nameTitle = nameTitle

    local rewardTitle = UI.Text:create()
    rewardTitle:init(UI.TEXT_227202, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_41_41_45)
    rewardTitle:leftUp(120, 254)
    rightContentLayout:addChild(rewardTitle)

    -- local dropTitle = UI.Text:create()
    -- dropTitle:init(UI.TEXT_224202, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    -- dropTitle:center(44, -32)
    -- rightContentLayout:addChild(dropTitle)

    -- local passTitle = UI.Text:create()
    -- passTitle:init(UI.TEXT_224203, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    -- passTitle:center(44, 86)
    -- rightContentLayout:addChild(passTitle)


    -- local testLO = UI.Layout:create()
    -- testLO:init()
    -- testLO:setSize(430, 75)
    -- testLO:centerUp(95, 45)
    -- rightContentLayout:addChild(testLO)
    -- testLO:enableDebugDraw()
    local inscriptionNum = RoleDataManager:getMaster():getWromholeWeekVirtualNum()
    local inscriptionWeekLimit = tonumber(Config.General:getValueForKey("wormholeDeepInscriptionNum"))
    inscriptionNum = inscriptionNum > inscriptionWeekLimit and inscriptionWeekLimit or inscriptionNum
    
    local showText = string.format(UI.TEXT_227203, inscriptionNum, inscriptionWeekLimit)
    local inscriptionText = UI.Text:create()
    inscriptionText:init(showText, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_204_204_204)
    inscriptionText:rightUp(100, 34)
    rightContentLayout:addChild(inscriptionText)

    local desc = UI.Text:create()
    desc:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
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
    scrollView:setSize(430, 95)
    scrollView:centerUp(105, 0)
    scrollView:addInnerNode(desLayout)
    scrollView:useDefaultScrollBar()
    rightContentLayout:addChild(scrollView)
    self.desScrollView = scrollView

    local closeBtn = UI.Button:create()
    closeBtn:init("ui_wormhole_close.png", "ui_wormhole_close.png", "ui_wormhole_close.png")
    closeBtn:rightUp(25, -47)
    closeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        mvc.closePanel("DeepInWormhole", "DeepInWormholeMain")
    end)
    rightContentLayout:addChild(closeBtn, 100)

    performWithDelay(self, function()
        self:showPannelAction(rightContentLayout)
    end, 0.01)
    
end

function DeepInWormholeMainView:showPannelAction(pannel)
    self.modeBgAnim:setAnimation("begin", false)
    local posX, posY = pannel:getPosition()
    -- local worldPos = pannel:convertToWorldSpace(cc.p(posX,posY))
    -- print("showPannelAction:", worldPos)
    pannel:centerBottom(-50, -900)
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

function DeepInWormholeMainView:createGameMode(caveMode, clickCallback)
    local nodeLayout = UI.Layout:create()
    nodeLayout:init()
    nodeLayout:setSize(214, 0)

    -- local btnImageArr = self:getCaveModeImageArr(caveMode)
    -- self.singlePlayBtn = UI.Button:create()
    -- self.singlePlayBtn:init("ui_btn_single_9.png", "ui_btn_single_8.png", "ui_btn_single_9.png")
    -- self.singlePlayBtn:leftBottom(0, 0)
    -- self.singlePlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
    --     if(clickCallback) then 
    --         clickCallback(PublicDefine.GAME_MODE.MODE_SOLO)
    --     end
    --     self:refreshGameModeBtnCheckState(PublicDefine.GAME_MODE.MODE_SOLO)
    -- end)
    -- nodeLayout:addChild(self.singlePlayBtn, 10)

    self.teamPlayBtn = UI.Button:create()
    self.teamPlayBtn:init("ui_btn_many_10.png", "ui_btn_many_10.png", "ui_btn_many_10.png")
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

    -- self.mercenaryPlayBtn = UI.Button:create()
    -- self.mercenaryPlayBtn:init("ui_btn_mercenary_9.png", "ui_btn_mercenary_8.png", "ui_btn_mercenary_9.png")
    -- self.mercenaryPlayBtn:leftBottom(160, 0)
    -- self.mercenaryPlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
    --     if(clickCallback) then 
    --         clickCallback(PublicDefine.GAME_MODE.MODE_MERCENARY)
    --     end
    --     self:refreshGameModeBtnCheckState(PublicDefine.GAME_MODE.MODE_MERCENARY)
    --     Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary)
    -- end)
    -- nodeLayout:addChild(self.mercenaryPlayBtn, 10)
    -- self.mercenaryPlayBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS,self, function()
    --     if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary) then
    --         Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary)
    --         return
    --     end

    --     local masterData = GameDataManager:getInstance():getMaster()
    --     local guildBossLimit = ConfigManager:getGuildConfigForKey("guildMercenaryTimeLimit")
    --     if(guildBossLimit == nil) then 
    --         guildBossLimit = SECONDS_ONE_DAY
    --     end
    --     local waitingTime = masterData:getJoinGuildTime() + guildBossLimit - GameManager:getNormalServerTime()
    --     if not MasterDataManager:getGuildData() or waitingTime > 0 then 
    --         local LanguageManager = require("app.game.LanguageManager")
    --         if(not MasterDataManager:getGuildData()) then 
    --             UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110668))
    --             return
    --         end

    --         UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1170306))
    --         return
    --     end
    -- end)

    self:changeCaveMode(caveMode)

    return nodeLayout
end

function DeepInWormholeMainView:selectButton(gameMode)
        self:refreshTeamBtnState()
        self:refreshGameModeBtnCheckState(gameMode)
        LevelSelectUtil:getInstance():setPattern(gameMode)
        -- self:refreshNotice(gameMode)
        self:updateInfo(mvc.deepInWormholeModel:getTabIndex())
end

function DeepInWormholeMainView:changeCaveMode(caveMode)
    -- self.singlePlayBtn:setNormal("ui_btn_single_9.png")
    -- self.singlePlayBtn:setSelected("ui_btn_single_8.png")
    -- self.singlePlayBtn:setDisabled("ui_btn_single_9.png")
    self.teamPlayBtn:setNormal("ui_btn_many_10.png")
    self.teamPlayBtn:setSelected("ui_btn_many_10.png")
    self.teamPlayBtn:setDisabled("ui_btn_many_10.png")
    -- self.mercenaryPlayBtn:setNormal("ui_btn_mercenary_9.png")
    -- self.mercenaryPlayBtn:setSelected("ui_btn_mercenary_8.png")
    -- self.mercenaryPlayBtn:setDisabled("ui_btn_mercenary_9.png")
end

function DeepInWormholeMainView:refreshNotice(btnId)
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

function DeepInWormholeMainView:refreshTeamBtnState()
    self:refreshGameModeState()
end

function DeepInWormholeMainView:refreshGameModeState()
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

    -- if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary) then
    --     local masterData = GameDataManager:getInstance():getMaster()
    --     local guildBossLimit = ConfigManager:getGuildConfigForKey("guildMercenaryTimeLimit")
    --     if(guildBossLimit == nil) then 
    --         guildBossLimit = SECONDS_ONE_DAY
    --     end
    --     local waitingTime = masterData:getJoinGuildTime() + guildBossLimit - GameManager:getNormalServerTime()
    --     if MasterDataManager:getGuildData() and waitingTime <=0 then 
    --         self.mercenaryPlayBtn:enable()
    --         if Game.FunctionUnlockManager:getInstance():isShowNewAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_Mercenary) then
    --             ToolsUtil:playNewAction(self.mercenaryPlayBtn, 0.8)
    --         else
    --             ToolsUtil:removeNewAction(self.mercenaryPlayBtn)
    --         end
    --     else
    --         self.mercenaryPlayBtn:disable()
    --     end
    -- else
    --     self.mercenaryPlayBtn:disable()
    -- end
end

function DeepInWormholeMainView:refreshGameModeBtnCheckState(gameMode)
    -- if not self.singlePlayBtn:isDisable() then
    --     self.singlePlayBtn:setBtnStatus(ButtonState.NORMAL)
    -- else
    --     if(gameMode == PublicDefine.GAME_MODE.MODE_SOLO) then 
    --         return
    --     end
    -- end

    if not self.teamPlayBtn:isDisable() then
        self.teamPlayBtn:setBtnStatus(ButtonState.NORMAL)
    else
        if(gameMode == PublicDefine.GAME_MODE.MODE_TEAM) then 
            return
        end
    end
    -- if not self.mercenaryPlayBtn:isDisable() then
    --     self.mercenaryPlayBtn:setBtnStatus(ButtonState.NORMAL)
    -- else
    --     if(gameMode == PublicDefine.GAME_MODE.MODE_MERCENARY) then 
    --         return
    --     end
    -- end

    if gameMode == PublicDefine.GAME_MODE.MODE_SOLO then
        -- self.singlePlayBtn:setBtnStatus(ButtonState.ACTIVE)
    elseif gameMode == PublicDefine.GAME_MODE.MODE_TEAM then
        -- body
        self.teamPlayBtn:setBtnStatus(ButtonState.ACTIVE)
    elseif gameMode == PublicDefine.GAME_MODE.MODE_MERCENARY then
        -- self.mercenaryPlayBtn:setBtnStatus(ButtonState.ACTIVE)
    end
end

function DeepInWormholeMainView:onChallengeBtnClick()
    self.mBClick = true
    self.lockAllBtn = false
    -- local totalTiems = ConfigManager:getGeneralForKey("wormholeDeepChallengeNum")
    -- totalTiems = tonumber(totalTiems)
    -- local master = RoleDataManager:getMaster()
    -- local remainCount = totalTiems - master:getWromholefightnum()
    
    -- if remainCount <= 0 then
    --     UI.ScrollBar:createByText(UI.TEXT_1328010)
    --     return 
    -- end

    local freePacketNum = GameDataManager:getInstance():getFreePetGemStoneBoxNum()
    if(freePacketNum <= 0) then
        UI.ScrollBar:createByTextID(1110793)
        return 
    end

    if RoleDataManager:getMaster():getLevel() < self.configData.entryLevel then
        UI.ScrollBar:createByText(UI.TEXT_1212652)
        return
    end

    LevelSelectUtil:getInstance().mSelectLevel = mvc.deepInWormholeModel:getCurLevel()--(mvc.deepInWormholeModel:getTabIndex())
    LevelSelectUtil:getInstance():setCaveMode(self.caveMode)
    LevelSelectUtil:getInstance():setDifficulty(self.curDiff)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,1)
    self:clickClose()
end

function DeepInWormholeMainView:openDiffSelectLayer()
    local diffSelectLayer = self.contentLayout:getChildByName("diffSelectLayer")
    if not diffSelectLayer then
        diffSelectLayer = UI.DeepInWormholeDiffSelectLayer:create()
        diffSelectLayer:init() 
        diffSelectLayer:center(0, 0)
        diffSelectLayer:setName("diffSelectLayer")
        self:addChild(diffSelectLayer, 100001);
    else
        -- diffSelectLayer:updateToShow(self.curPet:getId())
    end
end


function DeepInWormholeMainView:updateInfo(idx)
    if not idx then
        idx = mvc.deepInWormholeModel:getTabIndex()
    end
    if idx ~= mvc.deepInWormholeModel:getTabIndex() then
        return
    end

    local config = ConfigManager:getAllWormholeDeepDataByID(idx)
    self.configData = config
    local singleDrop = config.dropShow or {}
    local dropList = {}
    for k, v in pairs(singleDrop) do
        local data = GoodsDataManager:createLocalGoodsData(v)
        table.insert(dropList, data)
    end

    local len = #dropList
    if self.dropRewardNode then
        self.dropRewardNode:removeFromParent()
        self.dropRewardNode = nil
    end
    local rewardNode = UI.RewardPreViewUtil:create()
    rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    rewardNode:init(dropList, 5, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(5, 0))
    rewardNode:center(-5, 110)
    -- for k, v in pairs(singleDrop) do 
    --     rewardNode:addGoodsId(v, 0)
    -- end
    rewardNode:showGoodsView()
    self.rightContentLayout:addChild(rewardNode)
    self.dropRewardNode = rewardNode

    self:updateDes(config)
end

function DeepInWormholeMainView:updateDes(config)
    -- local totalTiems = ConfigManager:getGeneralForKey("wormholeDeepChallengeNum")
    -- totalTiems = tonumber(totalTiems)

    -- local master = RoleDataManager:getMaster()
    -- local challengeTimes = totalTiems - master:getWromholefightnum()
    
    -- self.challengeTimes:setText(string.format(UI.TEXT_224205, challengeTimes))
    local index = mvc.deepInWormholeModel:getTabIndex()

    -- local entryLevelList = config.entryLevel--string.split(config.entryLevel, ";")
    if config.entryLevel and config.entryLevel ~= "" then
        local level, reinLv = RoleDataManager:getUIShowLvByItemData(config.entryLevel)
        local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
        self.levelLimitText:setText(string.format(UI.TEXT_224403, showLv))
    end

    self.selectDiffcultBtn:setText(LanguageManager:getInstance():getLocalString(config.name))
    self.nameTitle:setText(LanguageManager:getInstance():getLocalString(config.name))
    self.desc:setText(LanguageManager:getInstance():getLocalString(config.des))
    local height = self.desc:getContentSize().height
    height = height < 75 and 75 or height
    self.desLayout:setSize(420, height)
end

-- function DeepInWormholeMainView:onGetRewards()
--     local tabIndex = mvc.deepInWormholeModel:getTabIndex()
--     Net.NetRoleSystem:reqGetEverWinterRiftRewards(tabIndex)
-- end

function DeepInWormholeMainView:clickClose()
    mvc.closePanel("DeepInWormhole", "DeepInWormholeMain")
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
end


function DeepInWormholeMainView:bindModel()

end


function DeepInWormholeMainView:unbindModel()

end





return DeepInWormholeMainView












