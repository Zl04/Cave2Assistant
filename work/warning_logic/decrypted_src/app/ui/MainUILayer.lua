-- MainUILayer.lua
-- Author:ODEI
-- 2017年9月28日
-- Using:主界面UI窗口

require "app.datas.RoleDataManager"
require "app.datas.TeamDataManager"
require "app.ui.bagFullLayer.BagFullLayer"
require "app.ui.common.PopupLayer"
require "app.ui.common.Dialog.ScrollBar"
require "app.ui.battlelayer.ControlPad"
require "app.ui.battlelayer.ControlPadNormal"
require "app.ui.mainUi.CaveActivityDSP"
require "app.datas.AnswerDataManager"
require "app.ui.dream.task.DreamTaskStatePanel"
require "app.modules.quicksidebar.QuickSideBarView"
local MachineManager = require("app.game.MachineManager")


local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local GameMapManager = require("app.game.GameMapManager")
local LanguageManager = require("app.game.LanguageManager")

local winSize = cc.Director:getInstance():getWinSize()

-- 背包
require "app.ui.baglayer.BagPanel"
require "app.ui.battlelayer.MonsterBoxLayer"

-- 战斗界面的
require "app.ui.battlelayer.MonsterPanel"
require "app.ui.battlelayer.SkillPanel"
require "app.ui.battlelayer.PetSkillPanel"
require "app.ui.battlelayer.GroupMonsterPanel"

UI = UI or {}

local MainUILayer = class("MainUILayer", UI.HWBtnComponent)
UI.MainUILayer = MainUILayer

local SCENE_TYPE = PublicDefine.SCENE_TYPE

-- 初始化标志
local inited = false
-- 管理所有ui组件的表
local componentMap = {}
-- 调试标志
local DEBUG = false

-- 怪物页面
local roleStatusMap = {}

-- 物品掉落框的位置
local ITEM_DROP_POSX = 5 -- 相距屏幕左侧的像素
local ITEM_DROP_POSY = 100 -- 相距屏幕上侧的像素


-- 战斗中怪物信息的面板
local MONSTER_PANEL_BOTTOM = 180

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_gaming_button.plist",
    "ui_common_btn.plist"
}

local UI_COMPONENT_HIDE_DURATION = 0.10
local UI_COMPONENT_HIDE_INTERVAL = 0

MAIN_UI_TYPE = {
    TOWN = 1,
    CAVE = 2,
}
-- 显示信息的Y轴便宜
local showInfoOffsetY = 230

--构造函数(必备)
function MainUILayer:ctor(MainUILType)
    print("MainUILayer:ctor")
    showInfoOffsetY = 230
    --窗口大小
    MainUILayer.super.ctor(
        self,UIType.MAIN_UI_LAYER,
        COM_RES_LIST,
        winSize.width,
        winSize.height
    )

    self.waitingTime = 0
    self.globalCountDownArr = nil
    self.townFireWorkTimeArr = nil
    self.UIType = MainUILType
    self.rootLayer = nil;           --root节点
    self.mainLayerVisible = true
    self._itemdropTime = 0
    self.isEmojiShow = false

    self.chatPannel = nil

    self.imitTimeLoginLoopTiming = 0 --限时登录活动循环计时
    self.imitTimeLoginLoopWaitingTime = 5 --限时登录活动循环计时休眠时间
    self:init();

    self:registerListener();

end

--虚构函数,destroy时调用(必备)
function MainUILayer:dtor()
    MainUILayer.super.dtor(self)
    self:unRegisterListener();

    self.waitingTime = 0
    self.globalCountDownArr = nil
    self.townFireWorkTimeArr = nil
    local scheduler=cc.Director:getInstance():getScheduler()
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
        self.mSchedulerID = 0
    end

    local plistStr = "ui_gaming_newyear.plist"
    if(Avalon.ResHelper:isLoadedForPlist(plistStr)) then 
        Avalon.ResHelper:unloadPlist(plistStr)
    end
end

-- 初始化(必备)
function MainUILayer:init()

    MainUILayer.super.init(self)
end

-- 挂上任务快捷栏
function MainUILayer:showQuickSideBar()
    if not mvc.quickSideBarModel:needShow() then
        return
    end

    local quickSideBar = UI.QuickSideBarView:create()
    quickSideBar:init()
    quickSideBar:leftBottom(Avalon.issUtil:getLeftMargin() + 0, 220)
    self.rootLayer:addChild(quickSideBar, UI_ZORDER.TIPS)
    self.quickSideBar = quickSideBar
    
end

-- 模版函数：初始化组建的视图(必备)
function MainUILayer:onInitView()
    --root节点
    self.rootLayer = cc.Layer:create();
    self.rootLayer:setContentSize(cc.size(winSize.width - Avalon.issUtil:getWidthOffset(),winSize.height))
    self.rootLayer:setPosition(cc.p(Avalon.issUtil:getLeftMargin(),0))
    self:addChild(self.rootLayer)

    if self.UIType == MAIN_UI_TYPE.TOWN then
        self:loadTownUI()
        self:showQuickSideBar()
    else
        if(not SceneManager:getInstance():isInLostRealm()) then 
            self:loadBattleUI()
            if not SceneManager:getInstance():isInStory() then
                self:showQuickSideBar()
            end
        else
            self:loadSpecialUI()
        end
    end

    
    -- performWithDelay(UI.UIManager:getRootNode(), function()
        self:refreshTransBuffBtn()
    --  end, 0.1)

    -- 单独渲染的UI部件(占地过大不易缓存或者是一直在动不易缓存的部件)
    local renderPlaceHolder = UI.Component:create()
    renderPlaceHolder:init()
    renderPlaceHolder:setRenderGroupTag(2)
    renderPlaceHolder:setRenderGroupPlaceholder(true)
    self:addChild(renderPlaceHolder)

    -- 添加提示框的逻辑
    local noticeLayout = UI.Layout:create()
    noticeLayout:init(0, 0, 0, 0)
    noticeLayout:setSize(0, 0)
    noticeLayout:centerBottom(self.rootLayer:getContentSize().height/2 + 180)
    self.rootLayer:addChild(noticeLayout, UI_ZORDER.NOTICE)
    self._noticeLayout = noticeLayout

    print("MainUILayer:onInitView",TeamDataManager:hasTeam() , not SceneManager:getInstance():isInFightScene())
    --断线重连
    if TeamDataManager:getTeamType() == Game.TeamType.FromActivity and (not SceneManager:getInstance():isInFightScene()) then
        if TeamDataManager:getReadyState() == true then
            require("app.ui.town.levelSelect.LevelSelectReady")
            local pLevelSelectReady = UI.LevelSelectReady:create(Game.TeamType.FromActivity)
            UI.UIManager:getRootNode():addChild(pLevelSelectReady,UI_ZORDER.LEVEL_SELECT_TEAM)
        end
    elseif TeamDataManager:hasTeam() and (not SceneManager:getInstance():isInFightScene()) then
        local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
        if LevelSelectUtil:getInstance().mSelectLevel == 0 then
            LevelSelectUtil:getInstance().mPattern = PublicDefine.GAME_MODE.MODE_TEAM
            LevelSelectUtil:getInstance():setCaveMode(PublicDefine.CAVE_MODE.MODE_NORMAL)
            LevelSelectUtil:getInstance().mDifficulty:set(PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
            LevelSelectUtil:getInstance().mSelectLevel = 1
        end


        if TeamDataManager:getReadyState() == true then
            require("app.ui.town.levelSelect.LevelSelectReady")
            local pLevelSelectReady = UI.LevelSelectReady:create(Game.TeamType.FromLevelSelect)
            UI.UIManager:getRootNode():addChild(pLevelSelectReady,UI_ZORDER.LEVEL_SELECT_TEAM)
        else
            if LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DUNGEON then
                -- if GameDataManager:judgeHaveDungeonKey(LevelSelectUtil:getInstance().mSelectLevel) then
                if GameDataManager:judgeHaveDungeonKey(1) then
                    performWithDelay(UI.UIManager:getRootNode(), function()
                        if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.READYING then
                            self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                        else
                            if TeamDataManager:getIsMatching() then
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                            else
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.MATCHING)
                            end
                        end
                     end, 0.1)
                end
            elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_HERO then
                if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then
                     performWithDelay(UI.UIManager:getRootNode(), function()
                        if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.READYING then
                            self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                        else
                            if TeamDataManager:getIsMatching() then
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                            else
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.MATCHING)
                            end
                        end
                     end, 0.1)
                end
            elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
                if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye) then
                     performWithDelay(UI.UIManager:getRootNode(), function()
                        if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.READYING then
                            self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                        else
                            if TeamDataManager:getIsMatching() then
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                            else
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.MATCHING)
                            end
                        end
                     end, 0.1)
                end
            elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
                if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad) then
                     performWithDelay(UI.UIManager:getRootNode(), function()
                        if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.READYING then
                            self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                        else
                            if TeamDataManager:getIsMatching() then
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                            else
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.MATCHING)
                            end
                        end
                     end, 0.1)
                end
            elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then
                     performWithDelay(UI.UIManager:getRootNode(), function()
                        if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.READYING then
                            self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                        else
                            if TeamDataManager:getIsMatching() then
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                            else
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.MATCHING)
                            end
                        end
                     end, 0.1)
                end
            elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
                if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring) then
                     performWithDelay(UI.UIManager:getRootNode(), function()
                        if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.READYING then
                            self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                        else
                            if TeamDataManager:getIsMatching() then
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                            else
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.MATCHING)
                            end
                        end
                     end, 0.1)
                end
            else
                local checkpointData = RoleDataManager:getCheckpointData(LevelSelectUtil:getInstance().mCaveMode,LevelSelectUtil:getInstance().mDifficulty:get())
                if checkpointData:getCheckpoint() and LevelSelectUtil:getInstance().mSelectLevel <= checkpointData:getCheckpoint() then
                     performWithDelay(UI.UIManager:getRootNode(), function()
                        -- print("------getIsMatching----getReadyState--mTeamType-", TeamDataManager:getIsMatching() , TeamDataManager:getReadyState(), LevelSelectUtil:getInstance().mTeamType)
                        if LevelSelectUtil:getInstance().mTeamType == TEAM_STATE.READYING then
                            self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                        else
                            if TeamDataManager:getIsMatching() then
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.READYING)
                            else
                                self:onShowLevelSelectTeamHandler(TEAM_STATE.MATCHING)
                            end
                        end
                     end, 0.1)
                end
            end
        end
    end

    if isFromReconnect then
        ReconnectUtil:showWaiting()
    end
end

function MainUILayer:refreshTransBuffBtn(battleIndex)
    local func = function()
        local heroData = RoleDataManager:getMaster()
        local hasEat = SkillDataManager:checkBuffIsExistBySproteID(heroData:getSpriteID())
        if self.mTransBuffBtn then
            if hasEat then
                if battleIndex == 1 then
                    self.mTransBuffBtn:hide()
                elseif battleIndex == 2 then
                    self.mTransBuffBtn:show()
                else
                    self.mTransBuffBtn:show()
                end
            else
                self.mTransBuffBtn:hide()
            end
        else
            if hasEat and self.mHeroHandLayer then
                self.mTransBuffBtn = UI.Button:create()
                self.mTransBuffBtn:init("ui_btn_fam_0.png","ui_btn_fam_1.png", "ui_btn_fam_2.png")
                self.mTransBuffBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                    local hasEat,buffData = SkillDataManager:checkBuffIsExistBySproteID(heroData:getSpriteID())
                    if hasEat then
                        local tips = UI.Tips:createTips(UI.TEXT_223301,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL) 
                        -- 确定和取消事件监听
                        tips:addEventListener(UIEvent.DIALOG_CONFIRM, tips,function()
                            if buffData then
                                Net.NetRoleSystem:requestRemoveBuff(buffData:getEntityID())
                            end
                        end)
                    else
                        self:refreshTransBuffBtn()
                    end
                end)
                self.mTransBuffBtn:leftUp(215,73)
                self.mHeroHandLayer:addChild(self.mTransBuffBtn)

                if battleIndex == 1 then
                    self.mTransBuffBtn:hide()
                elseif battleIndex == 2 then
                    self.mTransBuffBtn:show()
                end
            end
        end
    end

    performWithDelay(UI.UIManager:getRootNode(), function()
        func()
     end, 0.1)
end

function MainUILayer:loadSpecialUI()
    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isInLostRealm()) then 
        reload_script_file("app.ui.cave.LostRealmLayer")
        require("app.ui.cave.LostRealmLayer")
        local lostRealmLayer = UI.LostRealmLayer:create()
        lostRealmLayer:center()
        self.rootLayer:addChild(lostRealmLayer, 10)
        self.lostRealmLayer = lostRealmLayer

        -- if(self.testButton == nil) then
        --     local testButton = UI.Button:create()
        --     testButton:init("ui_btn_fam_0.png","ui_btn_fam_1.png", "ui_btn_fam_2.png")
        --     testButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        --         if(self.lostRealmLayer) then 
        --             self.lostRealmLayer:removeFromParent(true)
        --         end
        --         self:loadSpecialUI()
        --     end)
        --     self.testButton = testButton
        --     self.rootLayer:addChild(testButton, 100)
        -- end
    end
end

--城镇场景主界面
function MainUILayer:loadTownUI()

    if (self:_getIsHandleNewUI()) then
        require "app.ui.newTownBtnUI.NewTownBtnUILayer"
        local NewTownBtnUILayer = UI.NewTownBtnUILayer:create()
        NewTownBtnUILayer:init()
        NewTownBtnUILayer:center()
        self.rootLayer:addChild(NewTownBtnUILayer, UI_ZORDER.MINI_MAP)
        self.NewTownBtnUILayer = NewTownBtnUILayer
    else
        local mapData = GameMapManager:getInstance():getMapData()
        -- 小地图
        require "app.ui.minimap.MiniMap"
        local miniMap = UI.MiniMap:create()
        miniMap:init(mapData)

        local isInTown = SceneManager:getInstance():isNotInFightScene()
        if (isInTown) then
            miniMap:disableFog()
            -- miniMap:showTeammateCoord()
            miniMap:enableRenderMapGridTexture()
            -- miniMap:hide()
        end
        miniMap:rightUp(0,0)
        self.rootLayer:addChild(miniMap, UI_ZORDER.MINI_MAP)
        self._miniMap = miniMap

        -- 功能按钮
        local pPopupLayer = UI.PopupLayer:create(400)
        pPopupLayer:setName("PopupLayer")
        self.pPopupLayer = pPopupLayer
        self.rootLayer:addChild(pPopupLayer,UI_ZORDER.MAIN_UI);
        pPopupLayer:rightBottom(0,110)
        self.pPopupLayer.showPosition = {}
        self.pPopupLayer.showPosition.x = self.pPopupLayer:getPositionX()
        self.pPopupLayer.showPosition.y = self.pPopupLayer:getPositionY()

        if(SceneManager:getInstance():isInTown() 
            and GameDataManager:getInstance():getIsFristSuccessBackTown() == false
            and not GameManager:getIsInNewScene()) then
            -- 开始探险按钮
            local quickStartButton = UI.Button:create(UIType.BUTTON_QUICK_START_GAME)
            quickStartButton:init("ui_btn_fam_0.png","ui_btn_fam_1.png", "ui_btn_fam_2.png")
            quickStartButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                local MachineManager = require("app.game.MachineManager")
                local machine = MachineManager:getInstance():getMachine()
                if(machine) then 
                    local entterNpc = machine._model:getNpcsForFuntionType(PublicDefine.FUNCTION_TYPE.GENERAL_ENTRANCE)
                    if(entterNpc[1] and entterNpc[1]:getNpcData()) then 
                        local triggerData = entterNpc[1]:getNpcData()
                        if(triggerData) then 
                            local coord = triggerData:getCoord()
                            -- 这里把寻路范围设计的很大
                            local MapDataManager = require "app.mapkit.model.MapDataManager"
                            MapDataManager:getInstance():setPathFindRange(69)
                            machine:_onTouchMapTileEnded(coord.x, coord.y)
                            MapDataManager:getInstance():setPathFindRange(21)
                        end
                    end
                end
            end)
            self.rootLayer:addChild(quickStartButton, UI_ZORDER.MAIN_UI + 1)
            
            self.quickStartButton = quickStartButton
    
            local quickStartText = UI.Text:create()
            quickStartText:init(LanguageManager:getInstance():getLocalString(1110749), UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 247,g = 226, b = 150} )
            quickStartText:useDefaultShadowOnlyStype()
            self.rootLayer:addChild(quickStartText, UI_ZORDER.MAIN_UI + 1)
            self.quickStartText = quickStartText
    
            local bottomEnd = 180
            quickStartText:centerBottom(winSize.height/2 - bottomEnd)
            quickStartButton:centerBottom(winSize.height/2 - bottomEnd - 10 + quickStartText:getContentSize().height)
        end

        --背包
        local bagButton = UI.Button:create(UIType.BAG_BUTTON)
        bagButton:init("ui_package_icon_package_0.png","ui_package_icon_package_1.png", "ui_package_icon_package_2.png")
        bagButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
        end)
        self.rootLayer:addChild(bagButton, UI_ZORDER.MAIN_UI + 1)
        bagButton:rightBottom(20, 17)
        self._bagButton = bagButton
        self._bagButton.showPosition = {}
        self._bagButton.showPosition.x = self._bagButton:getPositionX()
        self._bagButton.showPosition.y = self._bagButton:getPositionY()
        
        -- 图标提示系统
        require "app.ui.baglayer.BagNotification"
        self._bagButtonNotification = UI.BagNotification:create()
        self._bagButtonNotification:init()
        self._bagButton:addChild(self._bagButtonNotification, UI_ZORDER.MAIN_UI + 1)
        self:refreshBagNotiStatus()

        --背包满
        require("app.ui.bagFullLayer.BagFullLayer")
        local pBagFullLayer = UI.BagFullLayer:create(400)
        pBagFullLayer:rightBottom(-910, 125)
        pBagFullLayer:setName("BagFullLayer")
        self.rootLayer:addChild(pBagFullLayer,UI_ZORDER.ITEMDROPINFO);

        
    end

    --移动面板
    self:initControlPad()

    --头像
    require("app.ui.heroHandLayer.HeroHandLayer")
    local pHeroHandLayer = UI.HeroHandLayer:create()
    pHeroHandLayer:center()
    self.rootLayer:addChild(pHeroHandLayer,UI_ZORDER.HERO)
    self.mHeroHandLayer = pHeroHandLayer
    if not self.mHeroHandLayer.mPetHand then
        Avalon.MessageCenter:notice(GameMessage.MC_COMMON_SHOW_PET)
    end
    -- 用于处理聊天框的表现处理逻辑
	local offsetX = 0
	local offsetY = 0

    
    self.chatPannel = UI.Layout:create()
    self.chatPannel:init()
    self.chatPannel:leftBottom(-20 + offsetX, 0 + offsetY)
    self.chatPannel:setSize(winSize.width, 200)

    --聊天
    require "app.ui.social.chat.ChatQuickLayer"
    local quickChatLayer = UI.ChatQuickLayer:recycle()
    if(self:_getIsHandleInTown()
        and self.NewTownBtnUILayer) then 
        local padindX = 80
        local startX = winSize.width / 2 - quickChatLayer:getContentSize().width / 2 - Avalon.issUtil:getLeftMargin() + 50
        if startX >  padindX then 
            offsetX = - (startX - (padindX))
        end

        offsetY = -65
    end

    quickChatLayer:leftBottom(winSize.width / 2 + offsetX - quickChatLayer:getContentSize().width / 2 - Avalon.issUtil:getLeftMargin() + 50, offsetY + 100 + Avalon.issUtil:getBottomMargin())
    self.chatPannel:addChild(quickChatLayer)
    self.rootLayer:addChild(self.chatPannel, UI_ZORDER.QUICKCHAT)
    self.quickChatLayer = quickChatLayer
    self.quickChatLayer:setClickDisable(false)
    self.quickChatLayer:setVisible(true)

    --聊天
    local mainChatLayer = UI.ChatMainLayer:recycle()
    mainChatLayer:forceClear()
    self.rootLayer:addChild(mainChatLayer, UI_ZORDER.QUICKCHAT)
    mainChatLayer:close()

    --快捷表情
    require "app.ui.social.QuickEmojiLayer"
    local pQuickExpressionLayer = UI.QuickEmojiLayer:create()
    self.rootLayer:addChild(pQuickExpressionLayer,UI_ZORDER.EXPRESSION)
    self.pQuickExpressionLayer = pQuickExpressionLayer
    local emojiBtn = UI.Image:create()
    emojiBtn:init("ui_expression_button_0.png")

    if self:_getIsHandleInTown() then
        emojiBtn:leftBottom(winSize.width / 2 + offsetX + quickChatLayer:getContentSize().width / 2 - Avalon.issUtil:getLeftMargin() + 35, 
        offsetY + 96 + Avalon.issUtil:getBottomMargin())
    else
        emojiBtn:leftBottom(winSize.width / 2 + offsetX - quickChatLayer:getContentSize().width / 2 - Avalon.issUtil:getLeftMargin() - emojiBtn:getContentSize().width + 35, 
        offsetY + 96 + Avalon.issUtil:getBottomMargin())
    end

    self.emojiBtn = emojiBtn
    self.emojiBtn:setVisible(true)
    self.emojiBtn:setTouchEnable(true)
    self.emojiBtn:setSwallowTouches(true)
    self.rootLayer:addChild(self.emojiBtn, UI_ZORDER.QUICKCHAT)
    self.emojiBtn:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.isEmojiShow then
            self:cancelQucikEmojiBtnClick()
        else
            self.emojiBtn:setSpriteName("ui_expression_button_1.png")

            if self:_getIsHandleInTown() then
                self.pQuickExpressionLayer:leftBottom(winSize.width / 2 + offsetX + quickChatLayer:getContentSize().width / 2 - Avalon.issUtil:getLeftMargin() + 35, 
                offsetY + 153 + Avalon.issUtil:getBottomMargin())
            else
                self.pQuickExpressionLayer:leftBottom(winSize.width / 2 + offsetX - quickChatLayer:getContentSize().width / 2 - Avalon.issUtil:getLeftMargin() - emojiBtn:getContentSize().width + 35, 
                offsetY + 153 + Avalon.issUtil:getBottomMargin())
            end

            self.isEmojiShow = true
        end
        self.pQuickExpressionLayer:isShowEmojiLayer(self.isEmojiShow)
    end)

    self:refreshTabState()
    self:refreshRedPoint()
    if ServerConfigUtil:isForbideChat() then
        self.chatPannel:hide()
        self.chatPannel:leftBottom(-winSize.width, -winSize.height)
        self.emojiBtn:setVisible(true)
    end

    if (self:_getIsHandleEmoji()) then
        self.emojiBtn:setVisible(false)
    end

    -- performWithDelay(self, function() 
    --     print("performWithDelaysss")
    --     Avalon.MessageCenter:notice(GameMessage.MC_UI_MINI_MAP_REFRESH_SPECIAL_EVENT)
    -- end, 10)

    mvc.greedySelectModel:setRewardGoodsData(nil)
    mvc.hitRatModel:clearScoreInfo()
    mvc.festivalModel:clearMazeRewardFlag()
    mvc.bigCrackModel:clear()
end

function MainUILayer:cancelQucikEmojiBtnClick()
    self.emojiBtn:setSpriteName("ui_expression_button_0.png")
    self.isEmojiShow = false
end

--洞窟场景主UI
function MainUILayer:loadBattleUI()
    -- 加载快捷栏UI
    if(not SceneManager:getInstance():isInMaze()) then
        require "app.ui.itemquickuselayer.ItemPanel"
        local pItemPanel = UI.ItemPanel:create()
        pItemPanel:init(data) 
        pItemPanel:centerBottom(5 + Avalon.issUtil:getBottomMargin())
        self._itemPanl = pItemPanel
        self.rootLayer:addChild(pItemPanel, UI_ZORDER.ITEMPANEL);
    else
        -- reload_script_file("app.ui.itemquickuselayer.ItemMazePanel")
        require "app.ui.itemquickuselayer.ItemMazePanel"
        local pItemPanel = UI.ItemMazePanel:create()
        pItemPanel:init(data) 
        pItemPanel:centerBottom(5 + Avalon.issUtil:getBottomMargin())
        self._itemPanl = pItemPanel
        self.rootLayer:addChild(pItemPanel, UI_ZORDER.ITEMPANEL);
    end

    -- 英雄面板
    require("app.ui.heroHandLayer.HeroHandLayer")
    local pHeroHandLayer = UI.HeroHandLayer:create()
    pHeroHandLayer:center()
    self.rootLayer:addChild(pHeroHandLayer, UI_ZORDER.HERO)
    self.mHeroHandLayer = pHeroHandLayer

    -- 小地图
    require "app.ui.minimap.MiniMap"
    local mapData = GameMapManager:getInstance():getMapData()
    local miniMap = UI.MiniMap:create()
    miniMap:init(mapData)
    miniMap:showTeammateCoord()
    miniMap:rightUp(0,0)
    self.rootLayer:addChild(miniMap, UI_ZORDER.MINI_MAP)
    self._miniMap = miniMap

    --移动面板
    self:initControlPad()

    --功能按钮(CO-15324洞窟内屏蔽)
    local pPopupLayer = UI.PopupLayer:create(400)
    pPopupLayer:setName("PopupLayer")
    self.pPopupLayer = pPopupLayer
    self.rootLayer:addChild(pPopupLayer,UI_ZORDER.MAIN_UI);
    pPopupLayer:rightBottom(0,110)
    self.pPopupLayer.showPosition = {}
    self.pPopupLayer.showPosition.x = self.pPopupLayer:getPositionX()
    self.pPopupLayer.showPosition.y = self.pPopupLayer:getPositionY()

    --背包
    local bagButton = UI.Button:create(UIType.BAG_BUTTON)
    bagButton:init("ui_package_icon_package_0.png","ui_package_icon_package_1.png","ui_package_icon_package_2.png")
    bagButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_BAG)
    end)
    self._bagButton = bagButton
    self.rootLayer:addChild(bagButton, UI_ZORDER.MAIN_UI + 1)
    bagButton:rightBottom(20, 17)
    self._bagButton.showPosition = {}
    self._bagButton.showPosition.x = self._bagButton:getPositionX()
    self._bagButton.showPosition.y = self._bagButton:getPositionY()

    -- 图标提示系统
    require "app.ui.baglayer.BagNotification"
    self._bagButtonNotification = UI.BagNotification:create()
    self._bagButtonNotification:init()
    self._bagButton:addChild(self._bagButtonNotification, UI_ZORDER.MAIN_UI + 1)
    self:refreshBagNotiStatus()

    -- 背包满
    require("app.ui.bagFullLayer.BagFullLayer")
    local pBagFullLayer = UI.BagFullLayer:create(400)
    pBagFullLayer:rightBottom(-910, 125)
    pBagFullLayer:setName("BagFullLayer")
    self.rootLayer:addChild(pBagFullLayer,UI_ZORDER.ITEMDROPINFO);

    self.chatPannel = UI.Layout:create()
    self.chatPannel:init()
    self.chatPannel:setSize(winSize.width, 200)
    self.chatPannel:leftBottom(-20, 0)

    --聊天
    require "app.ui.social.chat.ChatQuickLayer"
    local quickChatLayer = UI.ChatQuickLayer:recycle()
    quickChatLayer:leftBottom(winSize.width / 2 - quickChatLayer:getContentSize().width / 2 - Avalon.issUtil:getLeftMargin() + 50, 100 + Avalon.issUtil:getBottomMargin())
    self.chatPannel:addChild(quickChatLayer)
    self.rootLayer:addChild(self.chatPannel, UI_ZORDER.QUICKCHAT)
    self.quickChatLayer = quickChatLayer
    self.quickChatLayer:setClickDisable(false)
    self.quickChatLayer:setVisible(true)

    --快捷表情
    require "app.ui.social.QuickEmojiLayer"
    local pQuickExpressionLayer = UI.QuickEmojiLayer:create()
    self.rootLayer:addChild(pQuickExpressionLayer,UI_ZORDER.EXPRESSION)
    self.pQuickExpressionLayer = pQuickExpressionLayer
    local emojiBtn = UI.Image:create()
    emojiBtn:init("ui_expression_button_0.png")
    emojiBtn:leftBottom(winSize.width / 2 - quickChatLayer:getContentSize().width / 2 - Avalon.issUtil:getLeftMargin() - emojiBtn:getContentSize().width + 35, 
        96 + Avalon.issUtil:getBottomMargin())
    self.emojiBtn = emojiBtn
    self.emojiBtn:setVisible(true)
    self.emojiBtn:setTouchEnable(true)
    self.emojiBtn:setSwallowTouches(true)
    self.rootLayer:addChild(self.emojiBtn, UI_ZORDER.QUICKCHAT)
    self.emojiBtn:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if self.isEmojiShow then
            self:cancelQucikEmojiBtnClick()
        else
            self.emojiBtn:setSpriteName("ui_expression_button_1.png")
            self.pQuickExpressionLayer:leftBottom(winSize.width / 2 - quickChatLayer:getContentSize().width / 2 - Avalon.issUtil:getLeftMargin() - emojiBtn:getContentSize().width + 35, 
                153 + Avalon.issUtil:getBottomMargin())
            self.isEmojiShow = true
        end
        self.pQuickExpressionLayer:isShowEmojiLayer(self.isEmojiShow)
    end)

    if ServerConfigUtil:isForbideChat() then
        self.chatPannel:hide()
        self.chatPannel:leftBottom(-winSize.width, -winSize.height)
        self.emojiBtn:setVisible(true)
    end

    if SceneManager:getInstance():isWorldBossCave()
        and not SceneManager:getInstance():isInBlackHouse()
    then
        local WorldBossHurtRankView = require "app.modules.worldboss.WorldBossHurtRankView"
        local caveActivityDSP = WorldBossHurtRankView:create()
        self.rootLayer:addChild(caveActivityDSP)
        caveActivityDSP:leftUp(0, 168)
        self.caveActivityDsp = caveActivityDSP
        self.caveActivityDspPosY = caveActivityDSP:getPositionY()
    elseif SceneManager:getInstance():isActivityCave()then 
        if(not SceneManager:getInstance():isActCave() 
            or SceneManager:getInstance():isInEaster()) then 
            -- 处理了活动副本DSP
            local caveActivityDSP = UI.CaveActivityDSP:create()
            self.rootLayer:addChild(caveActivityDSP)
            caveActivityDSP:leftUp(0, 168)
            
            self.caveActivityDsp = caveActivityDSP
            self.caveActivityDspPosY = caveActivityDSP:getPositionY()
        end
    end

    --聊天
    local mainChatLayer = UI.ChatMainLayer:recycle()
    mainChatLayer:forceClear()
    self.rootLayer:addChild(mainChatLayer, UI_ZORDER.QUICKCHAT)
    mainChatLayer:close()

    --显示背包
    if(GameDataManager:getInstance():getMasterIsDead() == false) then
        if self._bagButton then
            self._bagButton:setVisible(true)
        end
        self:showHorcurxBtn("normal")
    else
        if self._bagButton then
            self._bagButton:setVisible(false)
        end
        self:showHorcurxBtn("hide")
    end

    if(SceneManager:getInstance():isInFightScene() 
        and not SceneManager:getInstance():isInStory()
        and not SceneManager:getInstance():isInBlackHouse()) then 
        if GameMapManager:getInstance():getCanQuickDown() then 
            self:initQuickDownBtn()
        end 
    end
    
    if not SceneManager:getInstance():isInBlackHouse() then
        --大秘境倒计时
        if SceneManager:getInstance():isInDungeon() then
            -- GameManager._dungeonCountDown = 100000
            self:initDungeonCountDown()
        end

        --worldboss 倒计时
        if SceneManager:getInstance():isWorldBossCave() then
            mvc.worldBossModel:initFightStageState()
            self:initWorldBossCountDown()
        end

        --公会副本 倒计时
        if SceneManager:getInstance():isGuildBoss() then
            self:initGuildBossCountDown()
        end

        --节日活动 倒计时
        if SceneManager:getInstance():isActCave() then
            self:initActCaveCountDown()
        end

        --活动副本:试炼之地 倒计时
        if SceneManager:getInstance():isInTrialLand() then
            self:initTrialLandTiming()
        end

        if SceneManager:getInstance():isInInferno() then
            local relicButton = UI.Button:create()
            relicButton:init("ui_package_icon_relic_0.png","ui_package_icon_relic_1.png", "ui_package_icon_relic_2.png")
            relicButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                mvc.openPanel("Cave", "CaveStateBag", PublicDefine.CAVE_MODE.MODE_INFERNO)
            end)
            -- rightBottom(160, 35)
            relicButton:rightBottom(160, 135)
            self.rootLayer:addChild(relicButton, UI_ZORDER.MAIN_UI + 10)
            self._infernoBgButton = relicButton
        end

        if SceneManager:getInstance():isInVoidRift() then
            local relicButton = UI.Button:create()
            relicButton:init("ui_package_icon_relic_0.png","ui_package_icon_relic_1.png", "ui_package_icon_relic_2.png")
            relicButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                mvc.openPanel("Cave", "CaveStateBag", PublicDefine.CAVE_MODE.MODE_VOID_RIFT)
            end)
            -- rightBottom(160, 35)
            relicButton:rightBottom(160, 135)
            self.rootLayer:addChild(relicButton, UI_ZORDER.MAIN_UI + 10)
            self._infernoBgButton = relicButton
        end

        if SceneManager:getInstance():isInViKing() then
            local relicButton = UI.Button:create()
            relicButton:init("ui_package_icon_relic_0.png","ui_package_icon_relic_1.png", "ui_package_icon_relic_2.png")
            relicButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                mvc.openPanel("Cave", "CaveStateBag", PublicDefine.CAVE_MODE.MODE_VIKING)
            end)
            -- rightBottom(160, 35)
            relicButton:rightBottom(160, 135)
            self.rootLayer:addChild(relicButton, UI_ZORDER.MAIN_UI + 10)
            self._infernoBgButton = relicButton
        end

        if SceneManager:getInstance():isInTrialLand() then
            local relicButton = UI.Button:create()
            relicButton:init("ui_package_icon_relic_0.png","ui_package_icon_relic_1.png", "ui_package_icon_relic_2.png")
            relicButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                mvc.openPanel("Cave", "CaveStateBag", PublicDefine.CAVE_MODE.MODE_TRIAL_LAND)
            end)
            -- rightBottom(160, 35)
            relicButton:rightBottom(160, 135)
            self.rootLayer:addChild(relicButton, UI_ZORDER.MAIN_UI + 10)
            self._infernoBgButton = relicButton
        end

        -- 自动战斗按钮
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_AutoFight) then
            local autoBattleBtn = UI.Button:create(UI.Type.MAIN_UID_AUTO_BUTTON)
            autoBattleBtn:init("ui_btn_auto_01.png", "ui_btn_auto_selected.png", "ui_btn_auto_01.png")
            if(showInfoOffsetY > 240) then
                autoBattleBtn:rightUp(62 + 70, showInfoOffsetY)
            else
                autoBattleBtn:rightUp(62, showInfoOffsetY)
            end
            autoBattleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onAutoBattle)
            self.rootLayer:addChild(autoBattleBtn, UI_ZORDER.MONSTER + 100)
            self._autoBattleBtn = autoBattleBtn
            showInfoOffsetY = showInfoOffsetY + autoBattleBtn:getContentSize().height + 6

            -- 添加提示语言
            self:createAutoBattleInfo()

            self:refreshAutoBattle()
        end

        self:checkAndCreateHorcurxBtn()
    end

    self:refreshTabState()
    self:refreshRedPoint()

    self:onShowAnswerQuestionHandler()

    self:refreshDreamTaskState()
    self:onSealBossUpdate()

    Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function()
        if not tolua.isnull(self) then
            if mvc.greedySelectModel:checkIsNeedGreedySelect() 
                and mvc.greedySelectModel:checkOpenGreedySelectDataIsOk() 
            then
                mvc.openPanel("GreedySelect","GreedySelect")
            end
        end
        mvc.greedySelectModel:checkShowRewardGoodsView()
    end,0.4)


    if SceneManager:getInstance():isInHitRat() then
        self:doHitRatShow()
    elseif SceneManager:getInstance():isInPuzzle() then
        self:doPuzzleShow()
    elseif SceneManager:getInstance():isInBigCrack() then
        mvc.openPanel("BigCrack", "BigCrackCave")
    end
end

-- 切换移动方式了
function MainUILayer:changeMoveType()
    if(self._oldMoveType ~= GameManager:getMoveType()) then 
        if(not tolua.isnull(self.pControlPad)) then 
            self.pControlPad:removeFromParent(true)
            self.pControlPad = nil
        end

        self:initControlPad()
    end
end

function MainUILayer:initControlPad()
    if(self:_getIsHandleControl()) then 
        return 
    end

    self._oldMoveType = GameManager:getMoveType()
    --移动面板
    local pControlPad = nil
    if(GameManager:getMoveType() ~= MoveType.NORMAL) then 
        pControlPad = UI.ControlPad:create(UIType.CONTROLPAD)
    else 
        pControlPad = UI.ControlPadNormal:create(UIType.CONTROLPAD)
    end 
    pControlPad:init()
    self.pControlPad = pControlPad
    self:openControlPad()
    self.rootLayer:addChild(pControlPad, UI_ZORDER.CONTROLPAD)
end

-- function MainUILayer:hasNewIapBox()
--     local globalUserData = Avalon.UserDataManager:readUserData(USER_DATA_TYPE.GLOBAL, AvalonUtil.getIdentifier())
--     local hasNew = globalUserData:hasNewIapBox()
--     return hasNew
-- end
-- -- 显示内购按钮上的红点
-- function MainUILayer:showIapShopRedPoint()
--     if not tolua.isnull(self._shopButton) then
--         local redPoint = self._shopButton:getChildByName("redPoint")
--         if not tolua.isnull(redPoint) then
--             redPoint:setVisible(true)
--         end
        
--     end
-- end

function MainUILayer:initCaveCountDown(tag, getCountDownFunc)
    local txtCountDown = self.rootLayer:getChildByName(tag)
    local subTitle = nil
    if(txtCountDown) then 
        subTitle = txtCountDown:getChildByName("subTitle")
    end
    local baseWidth = 153

    if(txtCountDown == nil) then 
        txtCountDown = UI.Text:create()
        txtCountDown:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        -- txtCountDown:setWidth(175)
        txtCountDown:rightUp(10,showInfoOffsetY)
        txtCountDown:setFontColor(UI.FONT_COLOR_255_239_201)
        txtCountDown:setName(tag)
        self.rootLayer:addChild(txtCountDown)

        subTitle = UI.Text:create()
        subTitle:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        subTitle:setWidth(153)
        subTitle:setTextCenter()
        -- subTitle:rightUp(10,185)
        subTitle:setFontColor(UI.FONT_COLOR_255_239_201)
        subTitle:setName("subTitle")
        txtCountDown:addChild(subTitle)
        subTitle:rightBottom(0, - (subTitle:getContentSize().height + 10))
        local sendNetRequest = true
        schedule(txtCountDown,function(dt)
            local countDown = getCountDownFunc()
            if countDown <= 0 then
                txtCountDown:setText(UI.TEXT_110064)
                subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
            elseif countDown > 0 then
                if countDown > 60 then
                    txtCountDown:setText(UI.TEXT_110066)
                    subTitle:setText(string.format("%d:%02d",math.floor(countDown/60),countDown%60))
                else
                    txtCountDown:setText(UI.TEXT_110065)
                    subTitle:setText(string.format("%02d", countDown))
                end
            end
            
            if math.floor(countDown) == 5 then
                if tag == "txtActHitRatCaveCountDown" then
                    Avalon.MessageCenter:notice(GameMessage.MC_ROLE_SHOW_KICKED, 
                        KICK_OUT_TYPE.KICK_OUT_TYPE_END_GUILD_BOSS, function(tips)
                            tips:runAction(cc.RemoveSelf:create())
                    end)
                end
            end

            if sendNetRequest and math.floor(countDown) <= 0 and tag == "txtActPuzzleCaveCountDown" then
                sendNetRequest = false
                -- 记忆翻牌请求结算
                mvc.send(mvc.events.Puzzle_Send_Result_Message)
            end
            self:refreshTextWidth(txtCountDown, baseWidth)
            self:refreshTextWidth(subTitle, baseWidth)
            subTitle:rightBottom(0, - (subTitle:getContentSize().height))
        end,1)
    end

    local countDown = getCountDownFunc()
    if countDown <= 0 then
        txtCountDown:setText(UI.TEXT_110064)
        subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
    elseif countDown > 0 then
        if countDown > 60 then
            txtCountDown:setText(UI.TEXT_110066)
            subTitle:setText(string.format("%d：%02d",math.floor(countDown/60),countDown%60))
        else
            txtCountDown:setText(UI.TEXT_110065)
            subTitle:setText(string.format("%02d", countDown))
        end
    end

    showInfoOffsetY = showInfoOffsetY + 60

    -- 如果操作约定宽度的一般就会直接修改长度
    self:refreshTextWidth(txtCountDown, baseWidth)
    self:refreshTextWidth(subTitle, baseWidth)
    subTitle:rightBottom(0, - (subTitle:getContentSize().height))
end

function MainUILayer:initActCaveCountDown()
    -- 这里做倒计时，同时会在倒计时完成前屏蔽移动操作 ShareMachineGenerationCmd.lua function Machine:_judegeToMove(master)
    if SceneManager:getInstance():isInHitRat() then
        local len = mvc.hitRatModel:getFightRemindCD()
        if len > 0 then
            mvc.openPanel("WorldBoss", "WorldBossFightCD", function() return mvc.hitRatModel:getFightRemindCD() end)
        end

        self:initCaveCountDown("txtActHitRatCaveCountDown", function() return mvc.hitRatModel:getSceneTime() end)
    elseif SceneManager:getInstance():isInPuzzle() then
        local len = mvc.puzzleModel:getFightRemindCD()
        if len > 0 then
            mvc.openPanel("WorldBoss", "WorldBossFightCD", function() return mvc.puzzleModel:getFightRemindCD() end)
        end

        self:initCaveCountDown("txtActPuzzleCaveCountDown", function() return mvc.puzzleModel:getSceneTime() end)
    elseif SceneManager:getInstance():isInBigCrack() then
        local len = mvc.bigCrackModel:getFightRemindCD()
        if len > 0 then
            mvc.openPanel("WorldBoss", "WorldBossFightCD", function() return mvc.bigCrackModel:getFightRemindCD() end)
        end

        self:initCaveCountDown("txtActBigCrackCaveCountDown", function() return mvc.bigCrackModel:getSceneTime() end)
    elseif SceneManager:getInstance():isInMaze() then
        self:initCaveCountDown("txtActCaveCountDown", function() return mvc.festivalModel:getSceneTime() end)
    elseif SceneManager:getInstance():isInHuLu() then
        local relicButton = UI.Button:create()
        relicButton:init("ui_package_icon_relic_0.png","ui_package_icon_relic_1.png", "ui_package_icon_relic_2.png")
        relicButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            mvc.openPanel("Festival", "FestivalRelicStatistic")
        end)
        relicButton:rightBottom(145, 15)
        self.rootLayer:addChild(relicButton, UI_ZORDER.MAIN_UI + 10)
        self._relicButton = relicButton
    end
end

function MainUILayer:initGuildBossCountDown()
    -- body
    local txtGuildBossCountDown = self.rootLayer:getChildByName("txtGuildBossCountDown")
    local subTitle = nil
    if(txtGuildBossCountDown) then 
        subTitle = txtGuildBossCountDown:getChildByName("subTitle")
    end
    local baseWidth = 153

    if(txtGuildBossCountDown == nil) then 
        txtGuildBossCountDown = UI.Text:create()
        txtGuildBossCountDown:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        -- txtGuildBossCountDown:setWidth(175)
        txtGuildBossCountDown:rightUp(10,showInfoOffsetY)
        txtGuildBossCountDown:setFontColor(UI.FONT_COLOR_255_239_201)
        txtGuildBossCountDown:setName("txtGuildBossCountDown")
        self.rootLayer:addChild(txtGuildBossCountDown)

        subTitle = UI.Text:create()
        subTitle:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        subTitle:setWidth(153)
        subTitle:setTextCenter()
        -- subTitle:rightUp(10,185)
        subTitle:setFontColor(UI.FONT_COLOR_255_239_201)
        subTitle:setName("subTitle")
        txtGuildBossCountDown:addChild(subTitle)
        subTitle:rightBottom(0, - (subTitle:getContentSize().height + 10))

        schedule(txtGuildBossCountDown,function(dt)
            local _WorldBossCountDown = mvc.guildModel:getFightStageCountDown()
            if _WorldBossCountDown <= 0 then
                txtGuildBossCountDown:setText(UI.TEXT_110064)
                subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
            elseif _WorldBossCountDown > 0 then
                if _WorldBossCountDown > 60 then
                    txtGuildBossCountDown:setText(UI.TEXT_110066)
                    subTitle:setText(string.format("%d：%02d",math.floor(_WorldBossCountDown/60),_WorldBossCountDown%60))
                else
                    txtGuildBossCountDown:setText(UI.TEXT_110065)
                    subTitle:setText(string.format("%02d", _WorldBossCountDown))
                end
            end
            self:refreshTextWidth(txtGuildBossCountDown, baseWidth)
            self:refreshTextWidth(subTitle, baseWidth)
            subTitle:rightBottom(0, - (subTitle:getContentSize().height))
            -- showInfoOffsetY = showInfoOffsetY + txtGuildBossCountDown:getContentSize().height + 6
        end,1)
    end

    local _WorldBossCountDown = mvc.guildModel:getFightStageCountDown()
    if _WorldBossCountDown <= 0 then
        txtGuildBossCountDown:setText(UI.TEXT_110064)
        subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
    elseif _WorldBossCountDown > 0 then
        if _WorldBossCountDown > 60 then
            txtGuildBossCountDown:setText(UI.TEXT_110066)
            subTitle:setText(string.format("%d：%02d",math.floor(_WorldBossCountDown/60),_WorldBossCountDown%60))
        else
            txtGuildBossCountDown:setText(UI.TEXT_110065)
            subTitle:setText(string.format("%02d", _WorldBossCountDown))
        end
    end
    showInfoOffsetY = showInfoOffsetY + 60
    
    -- 如果操作约定宽度的一般就会直接修改长度
    self:refreshTextWidth(txtGuildBossCountDown, baseWidth)
    self:refreshTextWidth(subTitle, baseWidth)
    subTitle:rightBottom(0, - (subTitle:getContentSize().height))
end

function MainUILayer:initWorldBossCountDown()
    -- body
    local txtWorldBossCountDown = self.rootLayer:getChildByName("txtWorldBossCountDown")
    local subTitle = nil
    if(txtWorldBossCountDown) then 
        subTitle = txtWorldBossCountDown:getChildByName("subTitle")
    end
    local baseWidth = 153

    if(txtWorldBossCountDown == nil) then 
        txtWorldBossCountDown = UI.Text:create()
        txtWorldBossCountDown:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        -- txtWorldBossCountDown:setWidth(175)
        txtWorldBossCountDown:rightUp(10,showInfoOffsetY)
        txtWorldBossCountDown:setFontColor(UI.FONT_COLOR_255_239_201)
        txtWorldBossCountDown:setName("txtWorldBossCountDown")
        self.rootLayer:addChild(txtWorldBossCountDown)

        subTitle = UI.Text:create()
        subTitle:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        subTitle:setWidth(153)
        subTitle:setTextCenter()
        -- subTitle:rightUp(10,185)
        subTitle:setFontColor(UI.FONT_COLOR_255_239_201)
        subTitle:setName("subTitle")
        txtWorldBossCountDown:addChild(subTitle)
        subTitle:rightBottom(0, - (subTitle:getContentSize().height + 10))

        schedule(txtWorldBossCountDown,function(dt)
            local _WorldBossCountDown = mvc.worldBossModel:getFightStageCountDown()
            if _WorldBossCountDown <= 0 then
                txtWorldBossCountDown:setText(UI.TEXT_110064)
                subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
            elseif _WorldBossCountDown > 0 then
                if _WorldBossCountDown > 60 then
                    txtWorldBossCountDown:setText(UI.TEXT_110066)
                    subTitle:setText(string.format("%d：%02d",math.floor(_WorldBossCountDown/60),_WorldBossCountDown%60))
                else
                    txtWorldBossCountDown:setText(UI.TEXT_110065)
                    subTitle:setText(string.format("%02d", _WorldBossCountDown))
                end
            end
            self:refreshTextWidth(txtWorldBossCountDown, baseWidth)
            self:refreshTextWidth(subTitle, baseWidth)
            subTitle:rightBottom(0, - (subTitle:getContentSize().height))
        end,1)
    end

    local _WorldBossCountDown = mvc.worldBossModel:getFightStageCountDown()
    if _WorldBossCountDown <= 0 then
        txtWorldBossCountDown:setText(UI.TEXT_110064)
        subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
    elseif _WorldBossCountDown > 0 then
        if _WorldBossCountDown > 60 then
            txtWorldBossCountDown:setText(UI.TEXT_110066)
            subTitle:setText(string.format("%d：%02d",math.floor(_WorldBossCountDown/60),_WorldBossCountDown%60))
        else
            txtWorldBossCountDown:setText(UI.TEXT_110065)
            subTitle:setText(string.format("%02d", _WorldBossCountDown))
        end
    end

    showInfoOffsetY = showInfoOffsetY + 60
    
    -- 如果操作约定宽度的一般就会直接修改长度
    self:refreshTextWidth(txtWorldBossCountDown, baseWidth)
    self:refreshTextWidth(subTitle, baseWidth)
    subTitle:rightBottom(0, - (subTitle:getContentSize().height))
end

function MainUILayer:initDungeonCountDown()
    -- body
    local txtDungeonCountDown = self.rootLayer:getChildByName("txtDungeonCountDown")
    local subTitle = nil
    if(txtDungeonCountDown) then 
        subTitle = txtDungeonCountDown:getChildByName("subTitle")
    end
    local baseWidth = 153

    if(txtDungeonCountDown == nil) then 
        txtDungeonCountDown = UI.Text:create()
        txtDungeonCountDown:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        -- txtDungeonCountDown:setWidth(175)
        txtDungeonCountDown:rightUp(10,showInfoOffsetY)
        txtDungeonCountDown:setFontColor(UI.FONT_COLOR_255_239_201)
        txtDungeonCountDown:setName("txtDungeonCountDown")
        self.rootLayer:addChild(txtDungeonCountDown)

        subTitle = UI.Text:create()
        subTitle:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        subTitle:setWidth(153)
        subTitle:setTextCenter()
        -- subTitle:rightUp(10,185)
        subTitle:setFontColor(UI.FONT_COLOR_255_239_201)
        subTitle:setName("subTitle")
        txtDungeonCountDown:addChild(subTitle)
        subTitle:rightBottom(0, - (subTitle:getContentSize().height + 10))

        schedule(txtDungeonCountDown,function(dt)
            local _DungeonCountDown = GameManager:getDungeonCountDown()
            if _DungeonCountDown <= 0 then
                txtDungeonCountDown:setText(UI.TEXT_110064)
                subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
            elseif _DungeonCountDown > 0 then
                if _DungeonCountDown > 60 then
                    txtDungeonCountDown:setText(UI.TEXT_110066)
                    subTitle:setText(string.format("%d：%02d",math.floor(_DungeonCountDown/60),_DungeonCountDown%60))
                else
                    txtDungeonCountDown:setText(UI.TEXT_110065)
                    subTitle:setText(string.format("%02d", _DungeonCountDown))
                end
            end
            self:refreshTextWidth(txtDungeonCountDown, baseWidth)
            self:refreshTextWidth(subTitle, baseWidth)
            subTitle:rightBottom(0, - (subTitle:getContentSize().height))
        end,1)
    end

    local _DungeonCountDown = GameManager:getDungeonCountDown()
    if _DungeonCountDown <= 0 then
        txtDungeonCountDown:setText(UI.TEXT_110064)
        subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
    elseif _DungeonCountDown > 0 then
        if _DungeonCountDown > 60 then
            txtDungeonCountDown:setText(UI.TEXT_110066)
            subTitle:setText(string.format("%d：%02d",math.floor(_DungeonCountDown/60),_DungeonCountDown%60))
        else
            txtDungeonCountDown:setText(UI.TEXT_110065)
            subTitle:setText(string.format("%02d", _DungeonCountDown))
        end
    end

    showInfoOffsetY = showInfoOffsetY + 60
    
    -- 如果操作约定宽度的一般就会直接修改长度
    self:refreshTextWidth(txtDungeonCountDown, baseWidth)
    self:refreshTextWidth(subTitle, baseWidth)
    subTitle:rightBottom(0, - (subTitle:getContentSize().height))
end

function MainUILayer:initTrialLandTiming()
    -- body
    local txtTrialLandTiming = self.rootLayer:getChildByName("txtTrialLandTiming")
    local subTitle = nil
    if(txtTrialLandTiming) then 
        subTitle = txtTrialLandTiming:getChildByName("subTitle")
    end
    local baseWidth = 153

    if(txtTrialLandTiming == nil) then 
        txtTrialLandTiming = UI.Text:create()
        txtTrialLandTiming:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        -- txtTrialLandTiming:setWidth(175)
        txtTrialLandTiming:rightUp(10,showInfoOffsetY)
        txtTrialLandTiming:setFontColor(UI.FONT_COLOR_255_239_201)
        txtTrialLandTiming:setName("txtTrialLandTiming")
        self.rootLayer:addChild(txtTrialLandTiming)

        subTitle = UI.Text:create()
        subTitle:init("",
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX)
        subTitle:setWidth(153)
        subTitle:setTextCenter()
        -- subTitle:rightUp(10,185)
        subTitle:setFontColor(UI.FONT_COLOR_255_239_201)
        subTitle:setName("subTitle")
        txtTrialLandTiming:addChild(subTitle)
        subTitle:rightBottom(0, - (subTitle:getContentSize().height + 10))

        schedule(txtTrialLandTiming,function(dt)
            local caveData = mvc.activityModeCaveModel:getTrialLandCaveData()
            local nowTime = GameManager:getNormalServerTime()
            local startDurationTime = caveData.startDurationTime or nowTime
            local duration = caveData.duration or 0
            local _DungeonCountDown = nowTime - startDurationTime + duration
            -- if _DungeonCountDown <= 0 then
            --     -- txtTrialLandTiming:setText(UI.TEXT_110064)
            --     -- subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
            -- elseif _DungeonCountDown > 0 then
            --     if _DungeonCountDown > 60 then
            --         txtTrialLandTiming:setText(UI.TEXT_110066)
            --         subTitle:setText(string.format("%d：%02d",math.floor(_DungeonCountDown/60),_DungeonCountDown%60))
            --     else
            --         txtTrialLandTiming:setText(UI.TEXT_110065)
            --         subTitle:setText(string.format("%02d", _DungeonCountDown))
            --     end
            -- end
            txtTrialLandTiming:setText(UI.TEXT_223409)
            subTitle:setText(string.format("%d：%02d",math.floor(_DungeonCountDown/60),_DungeonCountDown%60))

            self:refreshTextWidth(txtTrialLandTiming, baseWidth)
            self:refreshTextWidth(subTitle, baseWidth)
            subTitle:rightBottom(0, - (subTitle:getContentSize().height))
        end,1)
    end

    local _DungeonCountDown = GameManager:getDungeonCountDown()
    if _DungeonCountDown <= 0 then
        txtTrialLandTiming:setText(UI.TEXT_110064)
        subTitle:setText(LanguageManager:getInstance():getLocalString(1111298))
    elseif _DungeonCountDown > 0 then
        if _DungeonCountDown > 60 then
            txtTrialLandTiming:setText(UI.TEXT_110066)
            subTitle:setText(string.format("%d：%02d",math.floor(_DungeonCountDown/60),_DungeonCountDown%60))
        else
            txtTrialLandTiming:setText(UI.TEXT_110065)
            subTitle:setText(string.format("%02d", _DungeonCountDown))
        end
    end

    showInfoOffsetY = showInfoOffsetY + 60
    
    -- 如果操作约定宽度的一般就会直接修改长度
    self:refreshTextWidth(txtTrialLandTiming, baseWidth)
    self:refreshTextWidth(subTitle, baseWidth)
    subTitle:rightBottom(0, - (subTitle:getContentSize().height))
end

-- 数字文字表现
function MainUILayer:refreshTextWidth(txt, baseWidth)
    txt:setWidth(0)
    if(txt:getContentSize().width > baseWidth * 1.5) then
        txt:setWidth(baseWidth)
        txt:setTextLeft()
    elseif(txt:getContentSize().width > baseWidth) then
        txt:setWidth(0)
        txt:setTextRight()
    else 
        txt:setWidth(baseWidth)
        txt:setTextCenter()
    end
end

-- 刷新背包提示系统
function MainUILayer:refreshBagNotiStatus()
    -- 准备消失
    if tolua.isnull(self._bagButtonNotification) then
        return
    end
    if(SceneManager:getInstance():isInHuLu()) then 
        self._bagButtonNotification:hidePanel()
        return
    end
    require "app.utils.BagNotificationUtil"
    local isShowIcon, reason, optionalID = BagNotificationUtil:checkShowBagButtonNotiIcon()
    local timeToDisappear = BagNotificationUtil:getTimeToDisappear()
    if (isShowIcon and timeToDisappear > 0) then
        -- 切换按钮
        if (reason == BagNotificationUtil.REASON_GIFTBAG) then
            self._bagButtonNotification:setShowGiftBag(optionalID)
        elseif (reason == BagNotificationUtil.REASON_SKILLPOINT) then
            self._bagButtonNotification:showSkillIcon()
        elseif (reason == BagNotificationUtil.REASON_UPGRADABLE_EQUIP) then
            self._bagButtonNotification:setShowEquip(optionalID)
        end
        
        -- 动画表现
        local moveAmount = 200
        self._bagButtonNotification:show()
        self._bagButtonNotification:setTotalDisplayCountDownTime(BagNotificationUtil:getShowDuration())
        self._bagButtonNotification:setDisplayCountDownTime(timeToDisappear)
        self._bagButtonNotification:stopAllActions()
        self._bagButtonNotification:rightBottom(-200, 100)
        local moveLeftAction = cc.MoveBy:create(0.2, cc.p(-moveAmount, 0))
        local moveLeftBackAction = cc.EaseBackOut:create(moveLeftAction)
        self._bagButtonNotification:runAction(moveLeftBackAction)
        self._bagButtonNotification:runAction(cc.Sequence:create(cc.DelayTime:create(timeToDisappear), cc.CallFunc:create(function()
            local moveRightAction = cc.MoveBy:create(0.2, cc.p(moveAmount, 0))
            local moveBackRightAction = cc.EaseBackIn:create(moveRightAction)
            self._bagButtonNotification:runAction(cc.Sequence:create(moveBackRightAction, cc.CallFunc:create(function()
                self._bagButtonNotification:hidePanel()
            end)))
        end)))
    else
        self._bagButtonNotification:hidePanel()
    end
end


function MainUILayer:updateDungeonCountDown()
    if not (SceneManager:getInstance():isInDungeon() and not SceneManager:getInstance():isInBlackHouse()) then
        return
    end
    self:initDungeonCountDown()

    -- local txtDungeonCountDown = self.rootLayer:getChildByName("txtDungeonCountDown")
    -- local subTitle = self.rootLayer:getChildByName("subTitle")
    -- if txtDungeonCountDown == nil then
    --     local txtDungeonCountDown = UI.Text:create()
    --     txtDungeonCountDown:init("",
    --         UI.FONT_STANDARD,
    --         UI.FONT_SIZE_18PX)
    --     -- txtDungeonCountDown:setSize(300,50)
    --     txtDungeonCountDown:rightUp(0,205)
    --     txtDungeonCountDown:setFontColor(UI.FONT_COLOR_255_239_201)
    --     txtDungeonCountDown:setTextRight()
    --     txtDungeonCountDown:setName("txtDungeonCountDown")
    --     self.rootLayer:addChild(txtDungeonCountDown)
    --     schedule(txtDungeonCountDown,function(dt)
    --         local _DungeonCountDown = GameManager:getDungeonCountDown()
    --         if _DungeonCountDown == 0 then
    --             txtDungeonCountDown:setText(UI.TEXT_110064)
    --             txtDungeonCountDown:stopAllActions()
    --         elseif _DungeonCountDown > 0 then
    --             if _DungeonCountDown > 60 then
    --                 txtDungeonCountDown:setText(string.format(UI.TEXT_110066,math.floor(_DungeonCountDown/60),_DungeonCountDown%60))
    --             else
    --                 txtDungeonCountDown:setText(string.format(UI.TEXT_110065,_DungeonCountDown))
    --             end
    --         elseif _DungeonCountDown < 0 then
    --             txtDungeonCountDown:setVisible(false)
    --             txtDungeonCountDown:stopAllActions()
    --         end
    --     end,1)
    -- end

    -- local _DungeonCountDown = GameManager:getDungeonCountDown()
    -- if _DungeonCountDown == 0 then
    --     txtDungeonCountDown:setText(UI.TEXT_110064)
    --     txtDungeonCountDown:stopAllActions()
    -- elseif _DungeonCountDown > 0 then

    --     if _DungeonCountDown > 60 then
    --         txtDungeonCountDown:setText(string.format(UI.TEXT_110066,math.floor(_DungeonCountDown/60),_DungeonCountDown%60))
    --     else
    --         txtDungeonCountDown:setText(string.format(UI.TEXT_110065,_DungeonCountDown))
    --     end
    -- elseif _DungeonCountDown < 0 then
    --     txtDungeonCountDown:setVisible(false)
    --     txtDungeonCountDown:stopAllActions()
    -- end
    -- if txtDungeonCountDown:getContentSize().height < 40 then
    --     txtDungeonCountDown:setTextRightUp()
    -- else
    --     txtDungeonCountDown:setTextLeftUp()
    -- end
end




-- 模版函数：更新组建的视图(必备)
function MainUILayer:onUpdateView()
      local scheduler = cc.Director:getInstance():getScheduler()
      self.mSchedulerID = scheduler:scheduleScriptFunc( handler(self,self.schedulerTimeOut) ,0,false)
end


--添加战斗界面
function MainUILayer:showBattleUIHandler(roleData, roleSpriteId, targetList)
    print("-----战斗 进入")

    self:refreshTransBuffBtn(1)

    -- 这里处理如果在战斗界面就把所有页面给移除掉重新添加
    if(self._isBattle) then
        self:removeBattleUIHandler()
    end
    if(not tolua.isnull(self.autoBattleChangeLayout)) then 
        self.autoBattleChangeLayout:removeFromParent(true)
        self.autoBattleChangeLayout = nil
    end
    if(self.autoBattleChangeBtn) then 
        self.autoBattleChangeBtn:setVisible(false)
    end

    local lamp =  UI.UIManager:getRootNode():getChildByName("LAMP")
    if lamp then
        lamp:hide()
    end
    -- 关闭可能的页面显示
    -- self:removeBagPanel()
    self._isBattle = true  --战斗中，探险技能不可用，摇杆不能显示
    self:refreshAutoBattle()

    --移除背包界面
    Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_BAG_PANEL)
    --隐藏大地图
    Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_BIG_MAP)

    --怪物详情
    -- local pMonsterPanel = UI.MonsterPanel:create()
    -- pMonsterPanel:init(roleData) 
    -- pMonsterPanel:centerUp(0)
    -- pMonsterPanel:setName("MonsterPanel")
    -- self._pMonsterPanel = pMonsterPanel
    -- -- pMonsterPanel:centerBottom(MONSTER_PANEL_BOTTOM)
    -- self.rootLayer:addChild(pMonsterPanel,UI_ZORDER.MONSTER)
    -- Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, pMonsterPanel)

    local pMonsterPanel
    if targetList then
        pMonsterPanel = UI.GroupMonsterPanel:create()
        pMonsterPanel:init(roleData, targetList)--(targetList) 
        pMonsterPanel:centerUp(0)
        pMonsterPanel:setName("MonsterPanel")
        self._pMonsterPanel = pMonsterPanel
        -- pMonsterPanel:centerBottom(MONSTER_PANEL_BOTTOM)
        self.rootLayer:addChild(pMonsterPanel,UI_ZORDER.MONSTER)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, pMonsterPanel)
    else
        pMonsterPanel = UI.MonsterPanel:create()
        pMonsterPanel:init(roleData) 
        pMonsterPanel:centerUp(0)
        pMonsterPanel:setName("MonsterPanel")
        self._pMonsterPanel = pMonsterPanel
        -- pMonsterPanel:centerBottom(MONSTER_PANEL_BOTTOM)
        self.rootLayer:addChild(pMonsterPanel,UI_ZORDER.MONSTER)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, pMonsterPanel)
    end

    -- 技能
    local skillData  = SkillDataManager:getReplaceMasterLearnActiveSkillList()
    local pSkillPanel = UI.SkillPanel:create()
    pSkillPanel:init(skillData) 
    self._skillPanl = pSkillPanel
    pSkillPanel:setName("SkillPanel")
    pSkillPanel:rightBottom(5,5)
    self.rootLayer:addChild(pSkillPanel,UI_ZORDER.SKILL)
    
    --一定要确保所有实例化出的数据用的是同一个对象,此处用的是场景同步中的宠物对象
    local pet = RoleDataManager:getCaptain()
    -- local pet = MasterDataManager:getCaptainPet()
    if (pet) then
        local pSkillPanel = UI.PetSkillPanel:create()
        pSkillPanel:init(pet) 
        pSkillPanel:setName("PetSkillPanel")
        pSkillPanel:leftBottom(40, 48)
        self.rootLayer:addChild(pSkillPanel,UI_ZORDER.SKILL)
        self._petSkillPanl = pSkillPanel
    end
    --隐藏背包
    if self._bagButton and (not tolua.isnull(self._bagButton)) then
        self._bagButton:setVisible(false)
        self._bagButton:disable()
    end

    if(not tolua.isnull(self.rootLayer)) then
        local canQuickDownBtn = self.rootLayer:getChildByName("canQuickDownBtn")
        if canQuickDownBtn then
            canQuickDownBtn:setVisible(false)
            canQuickDownBtn:disable()
        end
    end

    self:showHorcurxBtn("battle")

    if self.pPopupLayer and (not tolua.isnull(self.pPopupLayer)) then
        self.pPopupLayer:hide()
        self.pPopupLayer:disableAllBtn()
    end

    if self._bagButtonNotification and (not tolua.isnull(self._bagButtonNotification)) then
        self._bagButtonNotification:hide()
        self._bagButtonNotification:disableAllBtn()
    end

    if self.chatPannel and (not tolua.isnull(self.chatPannel)) then
        self.chatPannel:stopAllActions()
        self.chatPannel:runAction(cc.MoveTo:create(0.15 ,cc.p(-20, -winSize.height)))
        self.quickChatLayer:setClickDisable(true)
        self.emojiBtn:setVisible(false)
        self.pQuickExpressionLayer:isShowEmojiLayer(false)
    end
    if self._relicButton and (not tolua.isnull(self._relicButton)) then
        self._relicButton:setVisible(false)
    end

    if(self._infernoBgButton and (not tolua.isnull(self._infernoBgButton))) then 
        self._infernoBgButton:setVisible(false)
    end

    self:hideAcrossTheYears()
end

function MainUILayer:changeMonsterPannel(roleData, roleSpriteId, targetList)
    if self._pMonsterPanel and (not tolua.isnull(self._pMonsterPanel)) then
        self._pMonsterPanel:removeFromParent(true)
        self._pMonsterPanel = nil
    end
    local pMonsterPanel
    if targetList then
        pMonsterPanel = UI.GroupMonsterPanel:create()
        pMonsterPanel:init(roleData, targetList)--(targetList) 
        pMonsterPanel:centerUp(0)
        pMonsterPanel:setName("MonsterPanel")
        self._pMonsterPanel = pMonsterPanel
        -- pMonsterPanel:centerBottom(MONSTER_PANEL_BOTTOM)
        self.rootLayer:addChild(pMonsterPanel,UI_ZORDER.MONSTER)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, pMonsterPanel)
    else
        pMonsterPanel = UI.MonsterPanel:create()
        pMonsterPanel:init(roleData) 
        pMonsterPanel:centerUp(0)
        pMonsterPanel:setName("MonsterPanel")
        self._pMonsterPanel = pMonsterPanel
        -- pMonsterPanel:centerBottom(MONSTER_PANEL_BOTTOM)
        self.rootLayer:addChild(pMonsterPanel,UI_ZORDER.MONSTER)
        Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, pMonsterPanel)
    end
end

function MainUILayer:doPuzzleShow()
    self.quickChatLayer:setVisible(false)
    self._bagButton:setVisible(false)
    self.emojiBtn:setVisible(false)
    self.pQuickExpressionLayer:isShowEmojiLayer(false)

    if self.pPopupLayer and (not tolua.isnull(self.pPopupLayer)) then
        self.pPopupLayer:setVisible(false)
        self.pPopupLayer:rightBottom(-900,110)
        self.pPopupLayer.showPosition = {}
        self.pPopupLayer.showPosition.x = -900
        self.pPopupLayer.showPosition.y = 110
    end
    self._itemPanl:setVisible(false)

    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)

    Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function() 
        AvalonUtil:moveCameraToCoord(6, 3, 0.1, nil, function() 
            GameManager:disableMovingHandler() 
        end)
    end, 0.5)

    if self.pControlPad then
        self.pControlPad:setVisible(false)
    end
    GameManager:disableMovingHandler()
    self:closeControlPad()

    mvc.send(mvc.events.Puzzle_Show_ScoreNumBanner, self.rootLayer)
    mvc.send(mvc.events.Puzzle_Create_List, true)
end

function MainUILayer:doHitRatShow()
    self.quickChatLayer:setVisible(false)
    self._bagButton:setVisible(false)
    
    self.emojiBtn:setVisible(false)
    self.pQuickExpressionLayer:isShowEmojiLayer(false)

    if self.pPopupLayer and (not tolua.isnull(self.pPopupLayer)) then
        self.pPopupLayer:setVisible(false)
        self.pPopupLayer:rightBottom(-900,110)
        self.pPopupLayer.showPosition = {}
        self.pPopupLayer.showPosition.x = -900
        self.pPopupLayer.showPosition.y = 110
    end
    if(self._itemPanl and (not tolua.isnull(self._itemPanl))) then 
        self._itemPanl:setVisible(false)
    end

    mvc.openPanel("HitRat", "HitRatHammerInfo")
    mvc.openPanel("HitRat", "HitRatHammer")
    mvc.openPanel("HitRat", "HitRatRank")
    Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, function() 
        AvalonUtil:moveCameraToCoord(5, 3, 0.1, nil, function() 
            GameManager:disableMovingHandler() 
            end
        )
    end, 0.5)
    if self.pControlPad then
        self.pControlPad:setVisible(false)
    end
    
    GameManager:disableMovingHandler()

    self:closeControlPad()
end
 --移除战斗界面
function MainUILayer:removeBattleUIHandler()
    print("---战斗结束移除")

    self:refreshTransBuffBtn(2)
    
    -- 怪物攻击目标置空
    self._monsterTarget = nil
    self:enableItemPanel()       -- 设置快捷栏可用
    self:enableSkillPanel()      -- 设置技能栏可用
    self._isBattle = false       --战斗中，探险技能不可用，摇杆不能显示

    if(self.autoBattleChangeBtn and GameManager:getAutoBattleStatus()
        and self:getIsShowAutoBattle()) then 
        self.autoBattleChangeBtn:setVisible(true)
    end
    self:refreshAutoBattle()
    
    local lamp =  UI.UIManager:getRootNode():getChildByName("LAMP")
    if lamp then
        lamp:show()
    end

    if self._pMonsterPanel and (not tolua.isnull(self._pMonsterPanel)) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, self._pMonsterPanel)
        self._pMonsterPanel:removeFromParent()
    end
    self._pMonsterPanel = nil 

    if self._skillPanl and (not tolua.isnull(self._skillPanl)) then
        self._skillPanl:runAction(cc.RemoveSelf:create())
    end
    self._skillPanl = nil 

    if self._petSkillPanl and (not tolua.isnull(self._petSkillPanl)) then
        self._petSkillPanl:runAction(cc.RemoveSelf:create())
    end
    self._petSkillPanl = nil 

    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)  -- 打开控制面板

    --显示背包
    local leaveBattleDisableButtonTime = 0.9
    if(GameDataManager:getInstance():getMasterIsDead() == false) then
        if self._bagButton and (not tolua.isnull(self._bagButton)) then
            self._bagButton:setVisible(true)
            self._bagButton:enable(leaveBattleDisableButtonTime)
        end

        if(not tolua.isnull(self.rootLayer)) then
            local canQuickDownBtn = self.rootLayer:getChildByName("canQuickDownBtn")
            if canQuickDownBtn then
                canQuickDownBtn:setVisible(true)
                canQuickDownBtn:enable()
            end
        end
    end
    self:showHorcurxBtn("outbattle")

    if self.pPopupLayer and (not tolua.isnull(self.pPopupLayer)) then
        self.pPopupLayer:show()
        self.pPopupLayer:enableAllBtn(leaveBattleDisableButtonTime)
    end

    if self._bagButtonNotification and (not tolua.isnull(self._bagButtonNotification)) then
        self._bagButtonNotification:show()
        self._bagButtonNotification:enableAllBtn()
    end

     -- 聊天栏显示
    if self.chatPannel and (not tolua.isnull(self.chatPannel)) and not ServerConfigUtil:isForbideChat() then
        self.chatPannel:stopAllActions()
        self.chatPannel:runAction(cc.MoveTo:create(0.15, cc.p(-20, 0)))
        self.quickChatLayer:setClickDisable(false)
        self.emojiBtn:setVisible(true)
    end

    if self._relicButton and (not tolua.isnull(self._relicButton)) then
        self._relicButton:setVisible(true)
    end

    if(self._infernoBgButton and (not tolua.isnull(self._infernoBgButton))) then 
        self._infernoBgButton:setVisible(true)
    end

    self:showAcrossTheYears()
end


function MainUILayer:updateTransformPgs()
    local heroData = RoleDataManager:getMaster()
    local config = HorcurxDataManager:getHorcurxEvolutionConfig(HorcurxDataManager:getHorcurxIllusionId())
    local skillID = config.NewSetSkill
    local skillConfig = ConfigManager:getSkillConfigById(skillID)
    local effectId= tonumber(skillConfig.preEffectID)
    local effectConfig = ConfigManager:getEffectConfigById(effectId)
    local buffId = effectConfig.value1
   
    local bufferDataList = SkillDataManager:getBufferDataListForSpriteID(heroData:getSpriteID())
    local buffData
    if bufferDataList then
        for k, v in pairs(bufferDataList) do
            if v.buffID == buffId then
                buffData = v
            end
        end
    end
    if not buffData then
        Avalon.Scheduler:scheduleUpdateOnceWithOutCheck(self, self.updateTransformPgs, 0.5)
        return
    end

    local percent =  ( buffData:getDuration() ) / buffData:getTotalDuration() * 100
    local remind = buffData:getDuration() 
    self.horcurxTimer:setPercentage(percent)

    local action = cc.ProgressTo:create(remind, 0) 
    self.horcurxTimer:runAction(action)
end
function MainUILayer:onHorcurxTransChanged()
    GameManager:setAutoBattleStatus(false)
    self:checkAndCreateHorcurxBtn()
    self:refreshAutoBattle()
end


function MainUILayer:onHorcurxIllusitionChanged(data)
    if data.isIllusion then
        if self._horcurxLayer then
            self._horcurxLayer.phase = nil
        end
        self:checkAndCreateHorcurxBtn()
    end
end
function MainUILayer:onUpdateHorcurxEngeryRefresh()
    if not self._horcurxLayer then
        return
    end
    
    if HorcurxDataManager:isHocruxEnergyFull() then
        self:checkAndCreateHorcurxBtn()
    else
        self:checkAndCreateHorcurxBtn()
        local energy = RoleDataManager:getMaster().horcruxEnergy
        local percent = energy/PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE *100 
        self.horcurxTimer:setPercentage(percent)
    end
end

function MainUILayer:checkAndCreateHorcurxBtn()
    if(SceneManager:getInstance():isActCave() 
        or SceneManager:getInstance():isWorldBossCave()
        or SceneManager:getInstance():isGuildBoss()
        or SceneManager:getInstance():isInTown()
        or SceneManager:getInstance():isInHuLu()
        or SceneManager:getInstance():isGuild()
        or SceneManager:getInstance():isHome()
        or SceneManager:getInstance():isManor()
        -- or SceneManager:getInstance():isInInferno()
    ) then 
        return 
    end

    if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Horcrux) then
        return
    end

    if HorcurxDataManager:isHocruxEnergyFull() then
        self:createHorcurxBtn("energyFull")
        return
    end

    if RoleDataManager:getMaster():isHorcruxTransform() then
        self:createHorcurxBtn("transfrom")
        self:updateTransformPgs()
        return
    end

    self:createHorcurxBtn("energyUp")
    local energy = RoleDataManager:getMaster().horcruxEnergy or 0
    local percent = energy/PublicDefine.CONST_DEFINITION.MAX_ENERGY_VALUE *100 
    self.horcurxTimer:setPercentage(percent)
end

function MainUILayer:createHorcurxBtn(phase)
    if self._horcurxLayer and self._horcurxLayer.phase == phase then
        return
    end
    if self._horcurxLayer then
        self._horcurxLayer:removeFromParent()
    end
    self._horcurxLayer = UI.Component:create()
    self._horcurxLayer:init()
    self._horcurxLayer:setSize(40,40)
    self._horcurxLayer:rightBottom(160, 35)
    self.rootLayer:addChild(self._horcurxLayer, UI_ZORDER.MAIN_UI + 10)
    local idx = HorcurxDataManager:getHorcurxIllusionId()
    local horcruxButton = UI.Button:create(UIType.BUTTON_HORCURX_TRANS_SKILL)
    if phase == "energyUp" then
        horcruxButton:init(string.format("ui_skill_horcrux_icon_%02d.png",idx), string.format("ui_skill_horcrux_icon_%02d.png",idx))
        
        local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_playerstate_me_henshin2.png"))
        timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
        timer:setPercentage(0)
        timer:setPosition(cc.p(20,20))
        self._horcurxLayer:addChild(timer) 
        self.horcurxTimer = timer 
    elseif phase == "energyFull" then
        horcruxButton:init(string.format("ui_skill_horcrux_icon_%02d.png",idx),string.format("ui_skill_horcrux_icon_%02d.png",idx))
       
        local bgAnimation = UI.Animation:create()
        bgAnimation:init(
            "effect_role_horcruxes_icon_up.json",
            "effect_role_horcruxes_icon_up.atlas",
            1
        )
        bgAnimation:addAnimation("idle", true)
        bgAnimation:center()
        self._horcurxLayer:addChild(bgAnimation)
    elseif phase == "transfrom" then
        horcruxButton:init(string.format("ui_playerstate_horcrux_%02d.png",idx),string.format("ui_playerstate_horcrux_%02d.png",idx))
        local timer = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_playerstate_me_henshin.png"))
        timer:setType(cc.PROGRESS_TIMER_TYPE_RADIAL)
        timer:setPosition(cc.p(20,20))
        timer:setPercentage(0)
        self._horcurxLayer:addChild(timer) 
        self.horcurxTimer = timer 
    end

    horcruxButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if RoleDataManager:getMaster():isHorcruxTransform() then
            return
        end
        
        if not HorcurxDataManager:isHocruxEnergyFull() then
            UI.ScrollBar:createByText(UIUtil:lang(1112798))
            return
        end

        local config = HorcurxDataManager:getHorcurxEvolutionConfig(HorcurxDataManager:getHorcurxIllusionId())
        local heroData = RoleDataManager:getMaster()
        local targetSpriteID = heroData:getSpriteID()
        local isEnable = true
        local looks = heroData:getLooks()
        
        local monsterIdRange = ConfigManager:getGeneralForKey("monsterIdRange")
	    local arr = string.split(monsterIdRange, ",")
        if looks == 0 or (looks >= tonumber(arr[1]) and looks <= tonumber(arr[2])) then
            isEnable = false
        end
        -- if heroData.looks and heroData.looks > 0  then
        if isEnable then
            UI.ScrollBar:createByText(UI.TEXT_1213202)
            return
        end
        local MachineManager = require("app.game.MachineManager")
        local machine = MachineManager:getInstance():getMachine()
        if(machine == nil) then
            return
        end
        local role = GameManager:getMasterRole()
        if(role) then
            if(role:getIsDead() == true) then
                return
            end
            local action = machine._actionTrack:getFisrtAction(GameTracksIndex.FSM, role:getId())
            if (action and (action:getFSMState() == FSMState.REVIVE 
                or action:getFSMState() == FSMState.WAITING)) then
                return
            end
        end

        Net.NetRoleSystem:heroUseSkillRequest(config.NewSetSkill, targetSpriteID)
        if self._horcurxLayer:getChildByName("henshinKey") then
            self._horcurxLayer:getChildByName("henshinKey"):setVisible(false)
        end 
        
    end)
    horcruxButton:center()
    self._horcurxLayer:addChild(horcruxButton)

    local img = UI.Image:create()
    img:init("ui_information_headframe_box2.png")
    img:center()
    self._horcurxLayer:addChild(img) 

    self._horcurxLayer.phase = phase

    self:showHorcurxBtn(self._horcurxLayerType,true)
end


function MainUILayer:showHorcurxBtn(showType, force)
    if not force then
        if self._horcurxLayerType == "goOut" 
            and showType ~= "goIn"
            and showType ~= "battle"
        then
            return
        end
        
        if self._horcurxLayerType == "battle" then
            if showType ~= "outbattle" then
                return
            end
        end
    end
      
    if self._horcurxLayerType == "battle"
        and showType == "outbattle" then
        showType = "normal"
    end

    self._horcurxLayerType = showType

    if not self._horcurxLayer then
        return
    end
    
    if showType == "hide" then
        self._horcurxLayer:setVisible(false)
        return
    end

    
    self._horcurxLayer:setVisible(true)
    if showType == "normal" then
        self._horcurxLayer:rightBottom(160, 35)
    elseif showType == "battle" then
        self._horcurxLayer:rightBottom(260, 135)
    elseif showType == "goOut" then
        self._horcurxLayer:rightBottom(-190, -100)
    elseif showType == "goIn" then
        self:showHorcurxBtn("normal")
    end
end

    
function MainUILayer:onHideHorcruxBtn()
    if self._horcurxLayer then
        self._horcurxLayer:removeFromParent()
    end
    self._horcurxLayer = nil
end

function MainUILayer:onSealBossUpdate(isFull)
    if not SceneManager:getInstance():isDistortedSpaceCave() and
    not SceneManager:getInstance():isEverWinter() then
        return
    end

    if SceneManager:getInstance():getSceneType() ~= PublicDefine.SCENE_TYPE.CAVE then
        return
    end

    local data = MasterDataManager._curCaveBossInfoCache or {}
    local curScore = data.curScore or 99
    local wakeScore = data.wakeScore or 99
    local per = curScore/wakeScore
    local percent = math.floor(per * 100)
    if percent > 100 then
        percent = 100
    end

    if not self.bossSealInfoLayer then
        if percent == 100 then
            return
        end

        self.bossSealInfoLayer = UI.Component:create()
        self.bossSealInfoLayer:init()
        self.bossSealInfoLayer:setSize(10,10)
        self.bossSealInfoLayer:centerUp(130)
        self.rootLayer:addChild(self.bossSealInfoLayer)

        local progressBg = UI.Image:create()
        progressBg:init("ui_gaming_warning_00.png")
        progressBg:center(-2,5)
        self.bossSealInfoLayer:addChild(progressBg)

        local percent = 0
        local progress = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_gaming_warning_10.png"))
        progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
        progress:setMidpoint(cc.p(0, 0))
        progress:setBarChangeRate(cc.p(1, 0))
        progress:setPercentage(percent)
        self.bossSealInfoLayer:addChild(progress)
        self.bossSealProgress = progress

        local text = UI.Text:create()
        text:init(UI.TEXT_1212836, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_209_171_68)
        text:centerRight(158,7)
        self.bossSealInfoLayer:addChild(text)


        local text = UI.Text:create()
        text:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_220_211_203)
        text:center(0,5)
        -- text:setOutline(UI.FONT_COLOR_BLACK)
        text:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))

        self.bossSealInfoLayer:addChild(text, 10)
        self.bossSealPercenterLabel = text

        local progressBg = UI.Image:create()
        progressBg:init("ui_gaming_warning_max.png")
        progressBg:center(-4,6)
        self.bossSealInfoLayer:addChild(progressBg)
        self.bossSealFullImg = progressBg
        self.bossSealFullImg:hide()
    end
    if not self.bossSealInfoLayer then
        return
    end


    self.bossSealPercenterLabel:setText(string.format(UI.TEXT_1212837, percent))
    self.bossSealProgress:setPercentage(percent)
    if percent >= 100 then
        self.bossSealFullImg:show()
        if isFull then
            Avalon.MessageCenter:notice(GameMessage.MC_PLOT_SHACK, 4)
            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, UIUtil:lang(1112497))

            performWithDelay(self, function()
                self.bossSealInfoLayer:removeFromParent()
                self.bossSealInfoLayer = nil
            end, 1)
        end
    end
end


-- 当所有申请了关闭控制面板的目标都打开了再打开控制面板, 一定要和关闭成对使用
function MainUILayer:openControlPadTracking(target)
    --print("openControlPadTracking", target)
    --print(debug.traceback())
    self.controlPadOpenTracker = self.controlPadOpenTracker or {}
    -- 如果当前目标已经申请了关闭方向键, 就把它的状态跟踪取消掉, 否则设置它的状态为申请了打开
    if (self.controlPadOpenTracker[target] == false) then self.controlPadOpenTracker[target] = nil else self.controlPadOpenTracker[target] = true end

    local allOpened = true
    for k,v in pairs(self.controlPadOpenTracker) do
        if (v == false) then allOpened = false end
    end

    if (allOpened) then self:openControlPad() end
end

-- 当所有申请了打开控制面板的目标都关闭了再关闭控制面板, 一定要和打开成对使用
function MainUILayer:closeControlPadTracking(target)
    --print("closeControlPadTracking1", target)
    self.controlPadOpenTracker = self.controlPadOpenTracker or {}
    -- 如果当前目标已经申请了打开方向键, 就把它的状态跟踪取消掉, 否则设置它的状态为申请了关闭
    if (self.controlPadOpenTracker[target] == true) then self.controlPadOpenTracker[target] = nil else self.controlPadOpenTracker[target] = false end

    local allClosed = true
    for k,v in pairs(self.controlPadOpenTracker) do
        if (v == true) then 
            allClosed = false 
            --print("closeControlPadTracking2", k)
        end
    end

    if (allClosed) then self:closeControlPad() end
end

function MainUILayer:controlPadTrackingClear()
    self.controlPadOpenTracker = {}
end

-- 打开控制面板
function MainUILayer:openControlPad(isShield)
    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isInBossScenario()) then
        -- 这里不能够直接显示，在1003层的时候会出问题
    else 
        if(self.pControlPad) then
            self.pControlPad:openFunction(isShield)
        end
    end
end

-- 关闭控制面板
function MainUILayer:closeControlPad(isShield)
    if self.pControlPad then
        self.pControlPad:closeFunction(isShield)
    end
end

function MainUILayer:closeBagButton()
    print("MainUILayer:closeBagButton")
    if self._bagButton and (not tolua.isnull(self._bagButton)) then
        self._bagButton:setVisible(false)
    end
    -- self:showHorcurxBtn("hide")
    if(not tolua.isnull(self.rootLayer)) then
        local canQuickDownBtn = self.rootLayer:getChildByName("canQuickDownBtn")
        if canQuickDownBtn then
            canQuickDownBtn:setVisible(false)
        end
    end

    if self._relicButton and (not tolua.isnull(self._relicButton)) then
        self._relicButton:setVisible(false)
    end

    if(self._infernoBgButton and (not tolua.isnull(self._infernoBgButton))) then 
        self._infernoBgButton:setVisible(false)
    end
end

function MainUILayer:openBagButton()
    print("MainUILayer:openBagButton")
    if self._bagButton and (not tolua.isnull(self._bagButton)) then
        self._bagButton:setVisible(true)
    end
    self:showHorcurxBtn("normal")

    if(not tolua.isnull(self.rootLayer)) then
        local canQuickDownBtn = self.rootLayer:getChildByName("canQuickDownBtn")
        if canQuickDownBtn then
            canQuickDownBtn:setVisible(true)
            canQuickDownBtn:enable()
        end
    end
    if self._relicButton and (not tolua.isnull(self._relicButton)) then
        self._relicButton:setVisible(true)
    end

    if(self._infernoBgButton and (not tolua.isnull(self._infernoBgButton))) then 
        self._infernoBgButton:setVisible(true)
    end
end


-- 启用快捷道具
function MainUILayer:enableItemPanel()
    if (self._itemPanl and (not tolua.isnull(self._itemPanl))) then
        self._itemPanl:enable()
    end
end

-- 禁用快捷道具
function MainUILayer:disableItemPanel()
    if (self._itemPanl and (not tolua.isnull(self._itemPanl))) then
        self._itemPanl:disable()
    end
end

-- 启用技能
function MainUILayer:enableSkillPanel()
    print("=======able")
    if (self._skillPanl and (not tolua.isnull(self._itemPanl)) and type(self._skillPanl.enable) == "function") then
        self._skillPanl:enable()
    end
    if (self._petSkillPanl and (not tolua.isnull(self._itemPanl)) and type(self._petSkillPanl.enable) == "function") then
        self._petSkillPanl:enable()
    end
end

-- 禁用技能
function MainUILayer:disableSkillPanel()
    print("=======disable")
    if (self._skillPanl and (not tolua.isnull(self._itemPanl)) and type(self._skillPanl.disable) == "function") then
        self._skillPanl:disable()
    end
    if (self._petSkillPanl and (not tolua.isnull(self._itemPanl)) and type(self._petSkillPanl.disable) == "function") then
        self._petSkillPanl:disable()
    end
end

-- 禁用宠物技能
-- function MainUILayer:disablePetSkillPanel()
--     print("=======disable petskill")
--     if (self._petSkillPanl and (not tolua.isnull(self._itemPanl)) and type(self._petSkillPanl.disable) == "function") then
--         self._petSkillPanl:disable()
--     end
-- end

--成功收到复活完成消息
function MainUILayer:onShowItemAndSkill() 
    print("-----成功收到复活完成消息") 
    self:enableItemPanel()
    self:enableSkillPanel()
end 

-- 角色状态改变
function MainUILayer:onUpdateRoleStateHandler(roleData)
    -- add by zp
    local spriteID = roleData:getSpriteID()
    if RoleDataManager:getMasterSpriteID() == spriteID then
        -- 判断死亡
        if (roleData:getIsDead()) then
            self:disableItemPanel()
            self:disableSkillPanel()
        end
    -- elseif RoleDataManager:getMasterSpriteID() == roleData.masterSpriteID then
    --     self:disablePetSkillPanel()
    end
end

-- 显示UI的主界面
-- @callBack 在主界面完全显示后，可以执行的回调函数
-- @duration 在多少秒后显示主界面
function MainUILayer:showMainLayer(callBack, duration, isBigMap)
    -- print("-------------------------------MainUILayer:showMainLayer(callBack, duration)",self.mainLayerVisible,callBack, duration)
    -- print(debug.traceback())
    local mActivityLayer = UI.UIManager.mActivityLayer
    if(not tolua.isnull(mActivityLayer)) then
        if(mActivityLayer:getChildrenNum() >= 2)then
            return 
        end
    end

    if (not self.mainLayerVisible) then
        if(self:_getIsHandleInTown()) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_CONTROL_HALF_BLACKLAYER, false)
        end
        UI.UIManager:clearTipsNode()
        duration = duration or 0.1
        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)
        -- add by zp 这里把该处理该问题移动到下面的回调中来调用，
        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, self)

        -- local bigMap = UI.UIManager:getRootNode():getChildByName("BigMap")
        local bigMap = UI.UIManager.mMainUILayer:getChildByName("BigMap")
        if(not tolua.isnull(bigMap)) then
            Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            Avalon.MessageCenter:notice(GameMessage.MC_UI_BIGMAP_SHOW)
            end, 0.3)
            if(not isBigMap) then 
                return 
            end
        end

        if(self.autoBattleLayout and GameManager:getAutoBattleStatus()
            and self:getIsShowAutoBattle()) then
            self.autoBattleLayout:setVisible(true)
        end

        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, self)

            -- print("MainUILayer:showMainLayer111",self._miniMap , (not tolua.isnull(self._miniMap)))
            -- TODO 每个主页面自己添加
            -- 新界面UI（右侧按钮UI）
            if(self.NewTownBtnUILayer and (not tolua.isnull(self.NewTownBtnUILayer))) then  
                self.NewTownBtnUILayer:showBar(duration)
            end 

            if(self._itemPanl and (not tolua.isnull(self._itemPanl))) then  
                self._itemPanl:showBar(duration)
            end 

            -- 小地图显示
            if (self._miniMap and (not tolua.isnull(self._miniMap))) then
                self._miniMap:showMiniMap(duration)
            end

            -- 背包按钮显示
            if self._bagButton and (not tolua.isnull(self._bagButton)) then
                if(self._bagButton.showPosition == nil) then
                    self._bagButton.showPosition = {}
                    self._bagButton.showPosition.x = self._bagButton:getPositionX()
                    self._bagButton.showPosition.y = self._bagButton:getPositionY()
                end
                if self._bagButton.moveAction then
                    self._bagButton:stopAction(self._bagButton.moveAction)
                    self._bagButton.moveAction = nil
                end
                self._bagButton.moveAction = self._bagButton:runAction(cc.MoveTo:create(duration,cc.p(self._bagButton.showPosition.x,self._bagButton.showPosition.y)))
            end

            

            if(not tolua.isnull(self.rootLayer)) then
                local canQuickDownBtn = self.rootLayer:getChildByName("canQuickDownBtn")
                if canQuickDownBtn then
                    if(canQuickDownBtn.showPosition == nil) then
                        canQuickDownBtn.showPosition = {}
                        canQuickDownBtn.showPosition.x = canQuickDownBtn:getPositionX()
                        canQuickDownBtn.showPosition.y = canQuickDownBtn:getPositionY()
                    end
                    if canQuickDownBtn.moveAction then
                        canQuickDownBtn:stopAction(canQuickDownBtn.moveAction)
                        canQuickDownBtn.moveAction = nil
                    end
                    print("canQuickDownBtn.showPosition.x,canQuickDownBtn.showPosition.y=", canQuickDownBtn.showPosition.x,canQuickDownBtn.showPosition.y)
                    canQuickDownBtn.moveAction = canQuickDownBtn:runAction(cc.MoveTo:create(duration,cc.p(canQuickDownBtn.showPosition.x,canQuickDownBtn.showPosition.y)))
                end
            end

            if(self._autoBattleBtn and
                self:getIsShowAutoBattle()) then 
                self._autoBattleBtn:setVisible(true)
            
                if(self._autoBattleBtn.showPosition == nil) then
                    self._autoBattleBtn.showPosition = {}
                    self._autoBattleBtn.showPosition.x = self._autoBattleBtn:getPositionX()
                    self._autoBattleBtn.showPosition.y = self._autoBattleBtn:getPositionY()
                end
                if self._autoBattleBtn.moveAction then
                    self._autoBattleBtn:stopAction(self._autoBattleBtn.moveAction)
                    self._autoBattleBtn.moveAction = nil
                end
                -- print("self._autoBattleBtn.showPosition.x,canQuickDownBtn.showPosition.y=", self._autoBattleBtn.showPosition.x,self._autoBattleBtn.showPosition.y)
                self._autoBattleBtn.moveAction = self._autoBattleBtn:runAction(cc.MoveTo:create(duration,cc.p(self._autoBattleBtn.showPosition.x,self._autoBattleBtn.showPosition.y)))
            end

            -- if (self.pControlPad and (not tolua.isnull(self.pControlPad))) then
            --     if(self.pControlPad.showPosition == nil) then
            --         self.pControlPad.showPosition = {}
            --         self.pControlPad.showPosition.x = self.pControlPad:getPositionX()
            --         self.pControlPad.showPosition.y = self.pControlPad:getPositionY()
            --     end
            --     self.pControlPad:stopAllActions()
            --     self.pControlPad:runAction(cc.MoveTo:create(duration,cc.p(self.pControlPad.showPosition.x, self.pControlPad.showPosition.y)))
            -- end


            -- if not tolua.isnull(self._shopButton) then
            --     -- self._shopButton:runAction(cc.MoveTo:create(duration,cc.p(self._shopButton:getPositionX(), winSize.height- 10)))
            --     if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase) then
            --         self._shopButton:show()
            --     end
            --     self._shopButton:rightUp(200, 10)
            -- end
            -- if self._expressBtn and (not tolua.isnull(self._expressBtn)) then
            --     self._expressBtn:runAction(cc.MoveTo:create(duration,cc.p(self._expressBtn:getPositionX(), 20)))
            -- end

            -- 功能按钮显示
            if self.pPopupLayer and (not tolua.isnull(self.pPopupLayer)) then
                if(self.pPopupLayer.showPosition == nil) then
                    self.pPopupLayer.showPosition = {}
                    self.pPopupLayer.showPosition.x = self.pPopupLayer:getPositionX()
                    self.pPopupLayer.showPosition.y = self.pPopupLayer:getPositionY()
                end
                self.pPopupLayer:stopAllActions()
                self.pPopupLayer:runAction(cc.MoveTo:create(duration,cc.p(self.pPopupLayer.showPosition.x, self.pPopupLayer.showPosition.y)))
            end

            if(not tolua.isnull(self.quickStartButton)) then 
                self.quickStartButton:stopAllActions()
                self.quickStartButton:runAction(cc.FadeIn:create(duration))
            end

            if(not tolua.isnull(self.quickStartText)) then 
                self.quickStartText:stopAllActions()
                self.quickStartText:runAction(cc.FadeIn:create(duration))
            end
           
            -- 头像显示
            if self.mHeroHandLayer and (not tolua.isnull(self.mHeroHandLayer)) then
                if(self.mHeroHandLayer.showPosition == nil) then
                    self.mHeroHandLayer.showPosition = {}
                    self.mHeroHandLayer.showPosition.x = self.mHeroHandLayer:getPositionX()
                    self.mHeroHandLayer.showPosition.y = self.mHeroHandLayer:getPositionY()
                end
                self.mHeroHandLayer:stopAllActions()
                self.mHeroHandLayer:setPosition(-800, 0)
                self.mHeroHandLayer:runAction(cc.MoveTo:create(duration,cc.p(self.mHeroHandLayer.showPosition.x, self.mHeroHandLayer.showPosition.y)))
            end

            -- 聊天栏显示
            if not RoleBehaviorManager:checkMasterIsInBattle() and self.chatPannel and (not tolua.isnull(self.chatPannel)) and not ServerConfigUtil:isForbideChat() then
                self.chatPannel:stopAllActions()
                self.chatPannel:runAction(cc.MoveTo:create(duration,cc.p(-20, 0)))
                self.quickChatLayer:setClickDisable(false)
                if not SceneManager:getInstance():isInPuzzle() and not self:_getIsHandleEmoji() then
                    self.emojiBtn:setVisible(true)
                end
            end

            -- 背包按钮显示
            if self._relicButton and (not tolua.isnull(self._relicButton)) then
                if(self._relicButton.showPosition == nil) then
                    self._relicButton.showPosition = {}
                    self._relicButton.showPosition.x = self._relicButton:getPositionX()
                    self._relicButton.showPosition.y = self._relicButton:getPositionY()
                end
                if self._relicButton.moveAction then
                    self._relicButton:stopAction(self._relicButton.moveAction)
                    self._relicButton.moveAction = nil
                end
                self._relicButton.moveAction = self._relicButton:runAction(cc.MoveTo:create(duration,cc.p(self._relicButton.showPosition.x,self._relicButton.showPosition.y)))
            end

            if self._infernoBgButton and (not tolua.isnull(self._infernoBgButton)) then
                if(self._infernoBgButton.showPosition == nil) then
                    self._infernoBgButton.showPosition = {}
                    self._infernoBgButton.showPosition.x = self._infernoBgButton:getPositionX()
                    self._infernoBgButton.showPosition.y = self._infernoBgButton:getPositionY()
                end
                if self._infernoBgButton.moveAction then
                    self._infernoBgButton:stopAction(self._infernoBgButton.moveAction)
                    self._infernoBgButton.moveAction = nil
                end
                self._infernoBgButton.moveAction = self._infernoBgButton:runAction(cc.MoveTo:create(duration,cc.p(self._infernoBgButton.showPosition.x,self._infernoBgButton.showPosition.y)))
            end

            if self.caveActivityDsp and (not tolua.isnull(self.caveActivityDsp)) then
                self.caveActivityDsp:stopAllActions()
                self.caveActivityDsp:runAction(cc.MoveTo:create(duration,cc.p(0, self.caveActivityDspPosY)))
            end


            if self.dreamTaskStatePanel then
                self.dreamTaskStatePanel:runAction(cc.MoveTo:create(duration,cc.p(winSize.width - Avalon.issUtil:getWidthOffset(), self.dreamTaskStatePanel:getPositionY())))
            end

            -- 聊天栏显示
            if self._bagButtonNotification and (not tolua.isnull(self._bagButtonNotification)) then
                self._bagButtonNotification:show()
                self._bagButtonNotification:enableAllBtn()
            end

            -- 任务快捷栏
            if self.quickSideBar and (not tolua.isnull(self.quickSideBar)) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_QUICK_SIDE_BAR_OFFSET_UPDATE, true)
            end


            -- 取消UI遮挡
            UI.ShieldingLayer:noShielding()

            -- 回调
            if (callBack) then
                callBack()
            end
        end, duration)
        self:showHorcurxBtn("goIn")

        -- 设置显示状态
        self.mainLayerVisible = true

        -- 设置UI遮挡
        UI.ShieldingLayer:shielding()
    else
        if (callBack) then
            callBack()
        end
    end

end

-- 隐藏UI的主界面
-- @callBack 在主界面隐藏后执行的回调函数
function MainUILayer:hideMainLayer(callBack, duration)
    --  print("-------------------------------MainUILayer:hideMainLayer(callBack, duration)")
    --  print(debug.traceback())
    if (self.mainLayerVisible) then
        UI.UIManager:clearTipsNode()
        if(self:_getIsHandleInTown()) then
            Avalon.MessageCenter:notice(GameMessage.MC_UI_CONTROL_HALF_BLACKLAYER, true)
        end
        Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, self)

        duration = duration or UI_COMPONENT_HIDE_DURATION

        local delay = UI_COMPONENT_HIDE_INTERVAL

        if(self.autoBattleLayout) then
            self.autoBattleLayout:setVisible(false)
        end
        if(self._autoBattleBtn) then 
            self._autoBattleBtn:setVisible(false)
        end

        -- 新界面UI（右侧按钮UI）
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if (self.NewTownBtnUILayer and not tolua.isnull(self.NewTownBtnUILayer)) then
                self.NewTownBtnUILayer:hideBar(duration)
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL

        -- 战斗物品界面
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if(self._itemPanl and (not tolua.isnull(self._itemPanl))) then 
                self._itemPanl:hideBar(duration)
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL
        

        -- 小地图隐藏
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if (self._miniMap and (not tolua.isnull(self._miniMap))) then
                self._miniMap:hideMiniMap(duration)
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL

        -- 头像隐藏
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if self.mHeroHandLayer and (not tolua.isnull(self.mHeroHandLayer)) then
                if(self.mHeroHandLayer.showPosition == nil) then
                    self.mHeroHandLayer.showPosition = {}
                    self.mHeroHandLayer.showPosition.x = self.mHeroHandLayer:getPositionX()
                    self.mHeroHandLayer.showPosition.y = self.mHeroHandLayer:getPositionY()
                end
                self.mHeroHandLayer:stopAllActions()
                self.mHeroHandLayer:runAction(cc.MoveTo:create(duration, cc.p(-800,0)))
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL

        -- 功能按钮隐藏
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if self.pPopupLayer and (not tolua.isnull(self.pPopupLayer)) then
                if(self.pPopupLayer.showPosition == nil) then
                    self.pPopupLayer.showPosition = {}
                    self.pPopupLayer.showPosition.x = self.pPopupLayer:getPositionX()
                    self.pPopupLayer.showPosition.y = self.pPopupLayer:getPositionY()
                end
                self.pPopupLayer:stopAllActions()
                self.pPopupLayer:runAction(cc.MoveTo:create(duration,cc.p(self.pPopupLayer.showPosition.x + 300, self.pPopupLayer.showPosition.y)))
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL

        if(not tolua.isnull(self.quickStartButton)) then 
            self.quickStartButton:stopAllActions()
            self.quickStartButton:runAction(cc.FadeOut:create(duration))
        end

        if(not tolua.isnull(self.quickStartText)) then 
            self.quickStartText:stopAllActions()
            self.quickStartText:runAction(cc.FadeOut:create(duration))
        end

        -- 背包按钮隐藏
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if self._bagButton and (not tolua.isnull(self._bagButton)) then
                if(self._bagButton.showPosition == nil) then
                    self._bagButton.showPosition = {}
                    self._bagButton.showPosition.x = self._bagButton:getPositionX()
                    self._bagButton.showPosition.y = self._bagButton:getPositionY()
                end
                if self._bagButton.moveAction then
                    self._bagButton:stopAction(self._bagButton.moveAction)
                    self._bagButton.moveAction = nil
                end
                self._bagButton.moveAction = self._bagButton:runAction(cc.MoveTo:create(duration,cc.p(self._bagButton.showPosition.x, self._bagButton.showPosition.y-400)))
            end
        end, delay)

        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if(not tolua.isnull(self.rootLayer)) then
                local canQuickDownBtn = self.rootLayer:getChildByName("canQuickDownBtn")
                if canQuickDownBtn then
                    if(canQuickDownBtn.showPosition == nil) then
                        canQuickDownBtn.showPosition = {}
                        canQuickDownBtn.showPosition.x = canQuickDownBtn:getPositionX()
                        canQuickDownBtn.showPosition.y = canQuickDownBtn:getPositionY()
                    end
                    if canQuickDownBtn.moveAction then
                        canQuickDownBtn:stopAction(canQuickDownBtn.moveAction)
                        canQuickDownBtn.moveAction = nil
                    end
                    print("canQuickDownBtn.showPosition.x,canQuickDownBtn.showPosition.y  HIDE=", canQuickDownBtn.showPosition.x,canQuickDownBtn.showPosition.y)
                    canQuickDownBtn.moveAction = canQuickDownBtn:runAction(cc.MoveTo:create(duration,cc.p(canQuickDownBtn.showPosition.x + 400, canQuickDownBtn.showPosition.y)))
                end
            end
        end, delay)

        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if(not tolua.isnull(self._autoBattleBtn)) then
                local canQuickDownBtn = self._autoBattleBtn
                if canQuickDownBtn then
                    if(canQuickDownBtn.showPosition == nil) then
                        canQuickDownBtn.showPosition = {}
                        canQuickDownBtn.showPosition.x = canQuickDownBtn:getPositionX()
                        canQuickDownBtn.showPosition.y = canQuickDownBtn:getPositionY()
                    end
                    if canQuickDownBtn.moveAction then
                        canQuickDownBtn:stopAction(canQuickDownBtn.moveAction)
                        canQuickDownBtn.moveAction = nil
                    end
                    -- print("canQuickDownBtn.showPosition.x,canQuickDownBtn.showPosition.y  HIDE=", canQuickDownBtn.showPosition.x,canQuickDownBtn.showPosition.y)
                    canQuickDownBtn.moveAction = canQuickDownBtn:runAction(cc.MoveTo:create(duration,cc.p(canQuickDownBtn.showPosition.x + 400, canQuickDownBtn.showPosition.y)))
                end
            end
        end, delay)

        delay = delay + UI_COMPONENT_HIDE_INTERVAL

        -- 聊天按钮隐藏
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if self.chatPannel and (not tolua.isnull(self.chatPannel)) then
                self.chatPannel:stopAllActions()
                self.chatPannel:runAction(cc.MoveTo:create(duration ,cc.p(-20, -winSize.height)))
                self.quickChatLayer:setClickDisable(true)
                self.emojiBtn:setVisible(false)
                self.pQuickExpressionLayer:isShowEmojiLayer(false)
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL

        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if self.caveActivityDsp and (not tolua.isnull(self.caveActivityDsp)) then
                self.caveActivityDsp:stopAllActions()
                self.caveActivityDsp:runAction(cc.MoveTo:create(duration ,cc.p(-winSize.width, 5)))
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL

        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if (self.dreamTaskStatePanel and (not tolua.isnull(self.dreamTaskStatePanel))) then
                self.dreamTaskStatePanel:runAction(cc.MoveTo:create(duration,cc.p(winSize.width + 300 + Avalon.issUtil:getWidthOffset(), self.dreamTaskStatePanel:getPositionY())))
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL

        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if (self._bagButtonNotification and (not tolua.isnull(self._bagButtonNotification))) then
                self._bagButtonNotification:hide()
                self._bagButtonNotification:disableAllBtn()
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL

        -- 隐藏任务快捷栏
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if self.quickSideBar and (not tolua.isnull(self.quickSideBar)) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_QUICK_SIDE_BAR_OFFSET_UPDATE, false)
            end
        end, delay)
        delay = delay + UI_COMPONENT_HIDE_INTERVAL

          -- 背包按钮隐藏
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if self._relicButton and (not tolua.isnull(self._relicButton)) then
                if(self._relicButton.showPosition == nil) then
                    self._relicButton.showPosition = {}
                    self._relicButton.showPosition.x = self._relicButton:getPositionX()
                    self._relicButton.showPosition.y = self._relicButton:getPositionY()
                end
                if self._relicButton.moveAction then
                    self._relicButton:stopAction(self._relicButton.moveAction)
                    self._relicButton.moveAction = nil
                end
                self._relicButton.moveAction = self._relicButton:runAction(cc.MoveTo:create(duration,cc.p(self._relicButton.showPosition.x, self._relicButton.showPosition.y-400)))
            end

            if self._infernoBgButton and (not tolua.isnull(self._infernoBgButton)) then
                if(self._infernoBgButton.showPosition == nil) then
                    self._infernoBgButton.showPosition = {}
                    self._infernoBgButton.showPosition.x = self._infernoBgButton:getPositionX()
                    self._infernoBgButton.showPosition.y = self._infernoBgButton:getPositionY()
                end
                if self._infernoBgButton.moveAction then
                    self._infernoBgButton:stopAction(self._infernoBgButton.moveAction)
                    self._infernoBgButton.moveAction = nil
                end
                self._infernoBgButton.moveAction = self._infernoBgButton:runAction(cc.MoveTo:create(duration,cc.p(self._infernoBgButton.showPosition.x, self._infernoBgButton.showPosition.y-400)))
            end
            
        end, delay)

        self:showHorcurxBtn("goOut")
        

        -- 添加按键屏蔽
        UI.ShieldingLayer:shielding()

        -- 延迟撤出屏蔽
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            UI.ShieldingLayer:noShielding()
        end, duration + 0.1)

        -- 延迟回调
        Avalon.Scheduler:scheduleUpdateOnce(nil, function()
            if (callBack) then
                callBack()
            end
        end, duration + delay - 0.3)

        self.mainLayerVisible = false
        -- Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINLAYER, duration)
    else
        if (callBack) then 
            callBack()
        end
    end

end

-- 显示选中英雄
function MainUILayer:onShowChoiceHeroHandler(heroData)
    print("MainUILayer:onShowChoiceHeroHandler  1")
    -- 处理选择英雄处理

    require("app.ui.town.ChoiceHeroPanel")
    local choiceHeroLayer = UI.ChoiceHeroPanel:create()
    choiceHeroLayer:init(heroData)
    choiceHeroLayer:centerUp(0)
    self.rootLayer:addChild(choiceHeroLayer, UI_ZORDER.CHOICE_HERO);
end

-- 显示物品掉落界面
function MainUILayer:showItemDropLayer(roleData)
    --物品掉落框
    require "app.ui.itemdroplayer.ItemDropLayer"
    
    local itemDropLayer = {}
    if roleData then
        -- table.insert(itemDropLayer,roleData)
        -- local comp = self:createComponent(UIType.ITEMDROPINFO,roleData,UI_ZORDER.ITEMDROPINFO)

        local itemdroplayer = UI.ItemDropLayer:create()
        itemdroplayer:init(self._itemdropTime,roleData)
        itemdroplayer:rightBottom(0, 320)
        self.rootLayer:addChild(itemdroplayer,UI_ZORDER.ITEMDROPINFO - self._itemdropTime/3 )
        self._itemdropTime = self._itemdropTime + 3
    end 
end

function MainUILayer:schedulerTimeOut(dt)
    if(self._itemdropTime<=0) then 
        self._itemdropTime = 0
    else
        self._itemdropTime = self._itemdropTime  - dt 
    end 

    -- 这里只有CN版本才有该倒计时,为了方便调试，dev 也有该功能
   if CAVEOL_TARGET == CAVEOL_TARGET_CN 
        or CAVEOL_TARGET == CAVEOL_TARGET_CN_PRE 
        or CAVEOL_TARGET == CAVEOL_TARGET_NOADS
        or CAVEOL_TARGET == CAVEOL_TARGET_DEVELOPMENT then
        if(self.globalCountDownArr == nil) then 
            local globalCountStr = ConfigManager:getGeneralForKey("globalCountDown")
            local arr = string.split(globalCountStr, ";")

            self.globalCountDownArr = {}
            for k,v in ipairs(arr) do 
                table.insert(self.globalCountDownArr, tonumber(v))
            end
        end

        if(self.globalCountDownArr and #self.globalCountDownArr == 3) then
            local nowServerTime = GameManager:getNowServerTime()
            -- print("GameManager:time=", nowServerTime, GameManager:getNowServerTimestamp(), os.time())
            if(nowServerTime < self.globalCountDownArr[3] and nowServerTime >= self.globalCountDownArr[1]) then
                if(self.waitingTime == 0) then 
                    self:initAcrossTheYears()
                end
                self.waitingTime = self.waitingTime + dt
                if(self.waitingTime > 1) then 
                    self.waitingTime = self.waitingTime - 1
                    self:refreshAcrossTheYears()
                end
            else 
                if(self._acrossLayout) then 
                    self.waitingTime = 0
                    self._acrossLayout:removeFromParent()
                    self._acrossLayout = nil
                end
            end
        end

        if(SceneManager:getInstance():isNotInFightScene()) then
            if(self.townFireWorkTimeArr == nil) then 
                local fireWorkTime = ConfigManager:getGeneralForKey("2yearfireworkstime")
                self.townFireWorkTimeArr = {}
                if(fireWorkTime) then 
                    local arr = string.split(fireWorkTime, ";")

                    for k,v in ipairs(arr) do 
                        table.insert(self.townFireWorkTimeArr, GameManager:getUnixTimeByConfigTimeStr(v))
                    end
                end
            end
            -- print("townFireWorkTimeArr", self.townFireWorkTimeArr, GameManager:getNormalServerTime())
            if(self.triggerFireWork == nil and self.townFireWorkTimeArr and #self.townFireWorkTimeArr == 2) then
                self.triggerFireWork = true
                local nowServerTime = GameManager:getNormalServerTime()
                if(nowServerTime < self.townFireWorkTimeArr[2] and nowServerTime >= self.townFireWorkTimeArr[1]) then
                    self:_showFireWork()
                end
            end
        end
    end

    -- 限时登录活动任务
    -- print("getLimitTimeLoginTaskOpenStatss:", MasterDataManager:getLimitTimeLoginTaskOpenStat())
    if MasterDataManager:getLimitTimeLoginTaskOpenStat() then
        self.imitTimeLoginLoopTiming = self.imitTimeLoginLoopTiming + dt
        if self.imitTimeLoginLoopTiming >= self.imitTimeLoginLoopWaitingTime then -- 活动开启后每5秒循环一次判断
            self.imitTimeLoginLoopTiming = 0

            -- 此时已等待至活动开启时间 重置等待时间
            if self.imitTimeLoginLoopWaitingTime ~= 5 then
                self.imitTimeLoginLoopWaitingTime = 5
            end
            local secondOfToday = GameManager:calculationGameSecondOfToday() --- 28800 -- 减去8小时
            
            local activityData = MasterDataManager:getActivityDataForType(PublicDefine.ActivityType.ActivityType_QuestCondition)
            local questConditionData = MasterDataManager:getLimitTimeLoginTaskData()
            for k, v in pairs(questConditionData) do
                if v and v.startTime then
                    local timeDifference = v.startTime - secondOfToday
                    if secondOfToday < v.startTime and (self.imitTimeLoginLoopWaitingTime == 5 or (timeDifference < self.imitTimeLoginLoopWaitingTime)) then
                        local waitTime = timeDifference + 1
                        self.imitTimeLoginLoopWaitingTime = waitTime == 5 and 6 or waitTime  -- 算出距离活动开启时间后，等待至活动开启时间再次循环
                    end

                    if v.startTime ~= 0 and secondOfToday >= v.startTime and secondOfToday <= v.endTime and not v:getIsComplete() and not v:getIsReceive() then
                        Net.NetActivitySystem:requestTimeLimitedLoginComplete(v.activityId)
                        MasterDataManager:setLimitTimeLoginTaskOpenStat(false)
                        break
                    end
                end
            end
        end
    end
end 


function MainUILayer:onShowLevelSelectTeamHandler(teamType)
     performWithDelay(self, function()
        local pLevelSelectTeam = self.rootLayer:getChildByName("LevelSelectTeam"..teamType)
        if(pLevelSelectTeam == nil) then
            -- 
            -- local bigMap = UI.UIManager:getRootNode():getChildByName("BigMap")
            local bigMap = UI.UIManager.mMainUILayer:getChildByName("BigMap")
            if(not tolua.isnull(bigMap)) then
                bigMap:removeFromParent()
            end

            Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ALL_ACTIVITY)
            require("app.ui.town.levelSelect.LevelSelectTeam")
            pLevelSelectTeam = UI.LevelSelectTeam:create(teamType)
            pLevelSelectTeam:center()
            pLevelSelectTeam:setName("LevelSelectTeam"..teamType)
            -- self.rootLayer:addChild(pLevelSelectTeam,UI_ZORDER.LEVEL_SELECT_TEAM);
            UI.UIManager:getRootNode():addChild(pLevelSelectTeam,UI_ZORDER.LEVEL_SELECT_TEAM);
            pLevelSelectTeam:openShow()
        end
     end,0.05)
end

function MainUILayer:onShowAnswerQuestionHandler()
    if not AnswerDataManager:canShowPanel() then
        return
    end

    if self.rootLayer:getChildByName("AnswerQuestionLayer") then
        return
    end
    require "app.ui.answerQuestion.AnswerQuestionLayer"
    local layer = UI.AnswerQuestionLayer:create(AnswerDataManager:getData())
    layer:center()
    layer:setName("AnswerQuestionLayer")
    self.rootLayer:addChild(layer, UI_ZORDER.HERO)
end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function MainUILayer:refreshTabState()
   local unlockFunctionArray = {
        PublicDefine.UnlockFunctionType.UnlockFunctionType_StudySkill, --学习技能
        PublicDefine.UnlockFunctionType.UnlockFunctionType_RoleTalent, --人物天赋
        PublicDefine.UnlockFunctionType.UnlockFunctionType_Horcrux, --魂器

    }
    
    local isNew = false
    for k, v in ipairs(unlockFunctionArray) do 
        if RoleDataManager:isUnlockByFunctionType(v) and Game.FunctionUnlockManager:getInstance():isShowNewAction(v) then
            isNew = true
            break
        end
    end
    if isNew then
        ToolsUtil:playNewAction(self._bagButton, 1,20,15)
    else
        ToolsUtil:removeNewAction(self._bagButton)
    end



   local unlockFunctionArray = {
        PublicDefine.UnlockFunctionType.UnlockFunctionType_Task,       --任务
        PublicDefine.UnlockFunctionType.UnlockFunctionType_Pokedex, --图鉴
        PublicDefine.UnlockFunctionType.UnlockFunctionType_TreasureMap, --藏宝图
        PublicDefine.UnlockFunctionType.UnlockFunctionType_Achievement, --成就
        PublicDefine.UnlockFunctionType.UnlockFunctionType_FightLog, --战利品日志
        PublicDefine.UnlockFunctionType.UnlockFunctionType_FunnyRecord, --趣味数据
    }

    local isNew = false
    for k, v in ipairs(unlockFunctionArray) do 
        if RoleDataManager:isUnlockByFunctionType(v) and Game.FunctionUnlockManager:getInstance():isShowNewAction(v) then
            isNew = true
            break
        end
    end
    if not self.leftNewNode or tolua.isnull(self.leftNewNode) then
        self.leftNewNode = UI.Component:create()
        self.leftNewNode:init()
        self.leftNewNode:setSize(100, 60)
        --self.leftNewNode:enableDebugDraw()
        self.mHeroHandLayer.rootLayer:addChild(self.leftNewNode,UI_ZORDER.HERO+10)
    end

    if isNew then
        ToolsUtil:playNewAction(self.leftNewNode, 1,70,20)
    else
        ToolsUtil:removeNewAction(self.leftNewNode)
    end

    -- if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase) then
    --     self._shopButton:show()
    -- else
    --     self._shopButton:hide()
    -- end
    -- self._shopButton:hide()
end

--刷新标签按钮  是否红点
function MainUILayer:refreshRedPoint()
    local showRed = false
    local SceneManager = require("app.game.SceneManager")
    if(SceneManager:getInstance():isInHuLu()) then 
        -- 这里根据是否装满五个技能来设置是否显示小红点
        if mvc.festivalModel:getHuluChoiceWeaponType() ~= PublicDefine.WEAPON_TYPE.NONE 
            and not SkillDataManager:getIsFullChoiceBattleSkill(mvc.festivalModel:getHuluChoiceWeaponType()) then 
            showRed = true
        end
    else
        if SkillDataManager:getSkillStudyNum() > 0 then
            showRed = true
        end
    end

    if self._bagButton and not tolua.isnull(self._bagButton) then
        if showRed then
            local redPoint = self._bagButton:getChildByName("REDPOINT")
            if redPoint == nil then
                redPoint = AvalonUtil.createRedPoint(self._bagButton, offsetX, offsetY, 20)
                redPoint:rightUp(3, 3)
                redPoint:setName("REDPOINT")
            end
        else
            self._bagButton:removeChildByName("REDPOINT")
        end
    end

    showRed = false
    local isHaveNewTrea = GoodsDataManager:isHavaNewTreasureFragment()
    local isCompleteAch = MasterDataManager:hasOneAchevementComplete()
    local isFinishTask = TaskDataManager:haveFinishTask(false)
    local pRed = PictureAlbumManager:isRedDot()
    if isHaveNewTrea or isCompleteAch or isFinishTask or pRed then
        showRed = true
    end

    if showRed then
        local redPoint = self.leftNewNode:getChildByName("REDPOINT")
        if redPoint == nil then
            redPoint = AvalonUtil.createRedPoint(self.leftNewNode, offsetX, offsetY, 20)
            redPoint:leftUp(10, 8)
            redPoint:setName("REDPOINT")
        end
    else
        self.leftNewNode:removeChildByName("REDPOINT")
    end

    
end

function MainUILayer:showFunctionButton(spriteID, functionDataArr, x, y, informationLocation)
    -- 移除老的按钮
    local functionPanel = self.rootLayer:getChildByName("FunctionPanel")
    if functionPanel then
        functionPanel:removeFromParent(true)
    end

    -- 处理显示功能按钮
    require "app.ui.functionLayer.FunctionPanel"
    local  functionPanel = UI.FunctionPanel:create()
    functionPanel:init(spriteID, functionDataArr, x, y, informationLocation, function()
        Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, functionPanel)
    end)
    functionPanel:center()
    functionPanel:setName("FunctionPanel")
    self.rootLayer:addChild(functionPanel, UI_ZORDER.FUNCTION_NPC);
    
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, functionPanel)
end

function MainUILayer:masterDead()
    if(not tolua.isnull(self._bagButton)) then 
        self._bagButton:disable()
    end
    self:showHorcurxBtn("hide")

    -- if(not tolua.isnull(self._shopButton)) then 
    --     self._shopButton:disable()
    -- end
end

function MainUILayer:masterRevive()
    if(not tolua.isnull(self._bagButton)) then 
        self._bagButton:enable()
    end
    self:showHorcurxBtn("normal")

    -- if(not tolua.isnull(self._shopButton)) then 
    --     self._shopButton:enable()
    -- end MC_UI_SCRENN_SYSTEM_NOTICE
end

function MainUILayer:screenSystemNotice(str)
    if(not tolua.isnull(self._noticeLayout)) then 
        self._noticeLayout:removeAllChildren(true)

        local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_general_banner_black.png")
        bg:setAnchorPoint(0.5, 0.5)
        bg:setPosition(0, 0)
        bg:setCapInsets(CCRectMake(41,27,370,5))
        bg:setContentSize(cc.size(500, 68))

        local width = 480
        local height = 68

        local text = UI.Text:create()
        text:init(str, UI.FONT_STANDARD, UI.FONT_SIZE_20PX)
        text:setWidth(width)
        text:setTextCenter()
        bg:addChild(text)

        height = text:getContentSize().height

        bg:setContentSize(width + 20, height + 20)
        text:center()
        bg:setOpacity(0)
        text:setOpacity(0)
        
        local baseAction = cc.Sequence:create(cc.FadeIn:create(0.5), cc.DelayTime:create(2), cc.FadeOut:create(0.5))
        bg:runAction(cc.Sequence:create(baseAction:clone(), cc.CallFunc:create(function()
            -- self._noticeLayout:removeAllChildren(true)
            bg:runAction(cc.RemoveSelf:create())
        end)))
        text:runAction(baseAction)

        self._noticeLayout:addChild(bg)
    end
end

function MainUILayer:isMainUIVisible()
    return self.mainLayerVisible
end

function MainUILayer:refreshDreamTaskState()
    -- body
    local SceneManager = require("app.game.SceneManager")
    if not SceneManager:getInstance():isInDream() then
        return
    end
    if(MasterDataManager:isHaveDreamData()) then 
        local dreamData = MasterDataManager:getDreamData()
        local taskData = dreamData.bossInfos[dreamData.curBossIndex]
        if self.dreamTaskStatePanel == nil then
            self.dreamTaskStatePanel = UI.Layout:create()
            self.dreamTaskStatePanel:init()
            self.dreamTaskStatePanel:rightUp(0, 190)
            self.rootLayer:addChild(self.dreamTaskStatePanel, UI_ZORDER.ITEMDROPINFO)
        end
        local child = self.dreamTaskStatePanel:getChildByName("DreamTaskStatePanel")
        if child then
            child:removeFromParent()
        end
        if taskData and taskData.stat ~= PublicDefine.DreamTaskState.State_UnRecieve then
            local panel = UI.DreamTaskStatePanel:create(taskData)
            panel:init()
            panel:setName("DreamTaskStatePanel")
            panel:rightUp(0, 0)
            self.dreamTaskStatePanel:addChild(panel, UI_ZORDER.ITEMDROPINFO)
            panel:show()
        end
    end
end

function MainUILayer:showOrHideBetTopBar(betBarType, showOrHide)
    if(showOrHide == true) then 
        if self.rootLayer:getChildByName("BetTopBar") then
            local topbar = self.rootLayer:getChildByName("BetTopBar")
            if topbar then
                topbar:updateType(betBarType)
            end
            return
        end
        
        require("app.modules.bet.BetTopBar")
        local betTopBar = UI.BetTopBar:create(betBarType)
        betTopBar:setName("BetTopBar")
        self.rootLayer:addChild(betTopBar, UI_ZORDER.TOP_ACTIVITY-1)
    else
        local topbar = self.rootLayer:getChildByName("BetTopBar")
        if topbar then
            topbar:removeFromParent()
        end
    end
end

function MainUILayer:showWorldBossTopBar()
    if self.rootLayer:getChildByName("WorldBossTopBar") then
        return
    end

    require("app.modules.worldboss.WorldBossTopBar")
    local worldbossTopBar = UI.WorldBossTopBar:create()
    worldbossTopBar:setName("WorldBossTopBar")
    self.rootLayer:addChild(worldbossTopBar, UI_ZORDER.TOP_ACTIVITY)
end

function MainUILayer:hideWorldBossTopBar()
    local topbar = self.rootLayer:getChildByName("WorldBossTopBar")
    if topbar then
        topbar:removeFromParent()
    end
end

function MainUILayer:initQuickDownBtn()
    local canQuickDownBtn = self.rootLayer:getChildByName("canQuickDownBtn")
    if(canQuickDownBtn == nil) then 
        canQuickDownBtn = UI.Button:create(UIType.BUTTON_QUICK_DOWN)
        canQuickDownBtn:init("ui_btn_caverne_1.png", "ui_btn_caverne_2.png", "ui_btn_caverne_0.png")
        canQuickDownBtn:rightUp(10,showInfoOffsetY)
        canQuickDownBtn:closeClickScale()
        canQuickDownBtn:setName("canQuickDownBtn")
        canQuickDownBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            local MachineManager = require("app.game.MachineManager")
            local machine = MachineManager:getInstance():getMachine()
            if(machine and machine._model) then
                local transDoorArr = machine._model:getAllFunctionNpcArr()
                local triggerNpcData = nil
                if(transDoorArr) then 
                    for k, npc in ipairs(transDoorArr) do 
                        if(npc and npc:getNpcData():getType() == PublicDefine.TRIGGER_NPC_TYPE.TRANS_DOOR
                            and npc:getNpcData():getTransdoorType() == PublicDefine.TRANS_DOOR_TYPE.NEXT_LEVEL) then 
                            triggerNpcData = npc:getNpcData()
                            break
                        end
                    end
                end
                print("triggerNpcData 1", triggerNpcData ~= nil)
                if(triggerNpcData) then
                    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
                        print("triggerNpcData 2", triggerNpcData ~= nil)
                        machine:_pushOpenTriggerNpcCommand(triggerNpcData, false)
                    end, 0.01)
                end
            end
        end)

        local iconImage = UI.Image:create()
        iconImage:init("ui_minimap_icon_stairs.png")
        iconImage:centerLeft(0)
        canQuickDownBtn:addChild(iconImage, 100)

        local quickStartText = UI.Text:create()
        quickStartText:init(UI.TEXT_1213200, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        -- quickStartText:useDefaultShadowOnlyStype()
        quickStartText:rightUp((183 - quickStartText:getContentSize().width)/2, 10)
        -- quickStartText:centerUp(15)
        canQuickDownBtn:addChild(quickStartText, 100)
        
        self.rootLayer:addChild(canQuickDownBtn, UI_ZORDER.MAIN_UI)
        canQuickDownBtn:rightUp(10,showInfoOffsetY)
        canQuickDownBtn.showPosition = {}
        canQuickDownBtn.showPosition.x = canQuickDownBtn:getPositionX()
        canQuickDownBtn.showPosition.y = canQuickDownBtn:getPositionY()

        -- 添加一个出场动画
        
    end
    showInfoOffsetY = showInfoOffsetY + 60
end

function MainUILayer:onQuickDownChange(canQuickDown)
    if(canQuickDown) then 
        self:initQuickDownBtn()
    else 
        if(not tolua.isnull(self.rootLayer)) then
            local canQuickDownBtn = self.rootLayer:getChildByName("canQuickDownBtn")
            if(canQuickDownBtn) then 
                canQuickDownBtn:removeFromParent()
            end
        end
    end
end

-- 显示跨年
function MainUILayer:initAcrossTheYears()
    if(self._acrossLayout == nil) then
        local layout = UI.Layout:create()
        layout:init()
        layout:center()
        self.rootLayer:addChild(layout, UI_ZORDER.FULL_SCREEN)
        self._acrossLayout = layout

        Avalon.ResHelper:loadPlistSync("ui_gaming_newyear.plist")
        -- 处理整个表现流程
        local titleText = UI.Text:create()
        titleText:init(UI.TEXT_1213900, UI.FONT_STANDARD, UI.FONT_SIZE_20PX)
        titleText:centerUp(-156)
        titleText:useDefaultOutLineShadowStyle()
        titleText:setScale(1.4)
        layout:addChild(titleText)
        self._titleText = titleText

        -- 文字数字
        local numberLayout = UI.Layout:create()
        numberLayout:init()
        numberLayout:center()
        self._numberLayout = numberLayout
        layout:addChild(numberLayout)

        -- 倒计时5秒
        self._backTimeAnimation = nil

        -- 烟花表现
        self._fireWorks = nil
    end
    
    self._acrossLayout:setVisible(true)
    -- 更新倒计时表现
    self:refreshAcrossTheYears()
end

function MainUILayer:refreshAcrossTheYears()
    if(self._acrossLayout == nil) then 
        return 
    end

    local animationTime = 5
    local nowServerTime = GameManager:getNowServerTime()
    if(nowServerTime < self.globalCountDownArr[3] and nowServerTime >= self.globalCountDownArr[1]) then
        if(nowServerTime < self.globalCountDownArr[2] and nowServerTime >= self.globalCountDownArr[1]) then 
            -- 播放倒计时
            local backTime = math.ceil(self.globalCountDownArr[2] - nowServerTime)
            if(backTime <= animationTime) then 
                if(self._fireWorks) then 
                    self._fireWorks:setVisible(true)
                end
                if(self._numberLayout) then 
                    self._numberLayout:removeFromParent()
                    self._numberLayout = nil
                end
                -- 动画字
                if(self._backTimeAnimation == nil) then
                    self._backTimeAnimation = Avalon.Animation:create("effect_ui_gaming_newyear_daojishi.json", "effect_ui_gaming_newyear_daojishi.atlas", 1);
                    self._backTimeAnimation:setAnimation(0, "idle", false)
                    self._acrossLayout:addChild(self._backTimeAnimation)
                    self._backTimeAnimation:updateTime(animationTime- backTime)
                    self._backTimeAnimation:registerSpineEventHandler(function (event)
                        if(event and event.eventData and event.eventData.name) then
                            local startPos = string.find(event.eventData.name, "sound_")
                            if(startPos ~= nil) then
                                -- 播放音效文件
                                local soundFilename = string.sub(event.eventData.name,7,-1)
                                Avalon.AudioManager:playDynamicSound(soundFilename,nil, nil)
                            end
                        end
                    end, sp.EventType.ANIMATION_EVENT)


                    self._backTimeAnimation:registerSpineEventHandler(function (event)
                        if(event and event.eventData and event.eventData.name) then
                            local startPos = string.find(event.eventData.name, "fireworks")
                            if(startPos ~= nil) then
                                if(self._fireWorks == nil) then 
                                    if(self._numberLayout) then 
                                        self._numberLayout:removeFromParent()
                                        self._numberLayout = nil
                                    end
                                    if(self._titleText) then 
                                        self._titleText:setVisible(false)
                                    end

                                    self._fireWorks = Avalon.Animation:create("effect_ui_gaming_newyear_fireworks.json", "effect_ui_gaming_newyear_fireworks.atlas", 1);
                                    self._fireWorks:setAnimation(0, "idle", true)
                                    self._acrossLayout:addChild(self._fireWorks)

                                    self._fireWorks:registerSpineEventHandler(function (event)
                                        if(event and event.eventData and event.eventData.name) then
                                            local startPos = string.find(event.eventData.name, "sound_")
                                            if(startPos ~= nil) then
                                                -- 播放音效文件
                                                local soundFilename = string.sub(event.eventData.name,7,-1)
                                                Avalon.AudioManager:playDynamicSound(soundFilename,nil, nil)
                                            end
                                        end
                                    end, sp.EventType.ANIMATION_EVENT)
                                end
                            end
                        end
                    end, sp.EventType.ANIMATION_EVENT)

                    self._backTimeAnimation:registerSpineEventHandler(function (event)
                        self._backTimeAnimation:runAction(cc.RemoveSelf:create())
                        self._backTimeAnimation = nil
                    end, sp.EventType.ANIMATION_END)
                end

                if(self._backTimeAnimation and not self._backTimeAnimation:isVisible()) then 
                    self._backTimeAnimation:setSlotsToSetupPose()
                    self._backTimeAnimation:setAnimation(0, "idle", false)
                    self._backTimeAnimation:updateTime(animationTime- backTime)
                    self._backTimeAnimation:setVisible(true)

                    self._backTimeAnimation:registerSpineEventHandler(function (event)
                        if(event and event.eventData and event.eventData.name) then
                            local startPos = string.find(event.eventData.name, "sound_")
                            if(startPos ~= nil) then
                                -- 播放音效文件
                                local soundFilename = string.sub(event.eventData.name,7,-1)
                                Avalon.AudioManager:playDynamicSound(soundFilename, nil, nil)
                            end
                        end
                    end, sp.EventType.ANIMATION_EVENT)
                end
            else
                -- 图片字
                if(self._numberLayout) then
                    self._numberLayout:removeAllChildren(true)
                    local numStr = tostring(backTime)
                    local numStrArr = {}
                    local index = 1
                    while true do
                        table.insert(numStrArr, string.sub(numStr, index, index))
                        index = index + 1
                        if(index > string.len(numStr)) then 
                            break
                        end
                    end

                    local offsetX = 120
                    local startX = - (#numStrArr/2 * offsetX)

                    for k, v in ipairs(numStrArr) do 
                        local name = self:_getAcrollYearName(tonumber(v))
                        local image = UI.Image:create()
                        image:init(name)
                        image:centerLeft(startX - image:getContentSize().width/2 + offsetX /2)
                        self._numberLayout:addChild(image)
                        startX = startX + offsetX
                    end
                end
            end
        else 
            -- 播放烟花
            if(self._fireWorks == nil) then 
                if(self._numberLayout) then 
                    self._numberLayout:removeFromParent()
                    self._numberLayout = nil
                end
                if(self._titleText) then 
                    self._titleText:setVisible(false)
                end

                self._fireWorks = Avalon.Animation:create("effect_ui_gaming_newyear_fireworks.json", "effect_ui_gaming_newyear_fireworks.atlas", 1);
                self._fireWorks:setAnimation(0, "idle", true)
                self._acrossLayout:addChild(self._fireWorks)

                self._fireWorks:registerSpineEventHandler(function (event)
                    if(event and event.eventData and event.eventData.name) then
                        local startPos = string.find(event.eventData.name, "sound_")
                        if(startPos ~= nil) then
                            -- 播放音效文件
                            local soundFilename = string.sub(event.eventData.name,7,-1)
                            Avalon.AudioManager:playDynamicSound(soundFilename,nil, nil)
                        end
                    end
                end, sp.EventType.ANIMATION_EVENT)
            else
                self._fireWorks:setVisible(true)
            end
        end
    else  
        self._acrossLayout:removeFromParent()
        self._acrossLayout = nil
    end
end

-- 显示跨年
function MainUILayer:showAcrossTheYears()
    if(self._acrossLayout) then
        self._acrossLayout:setVisible(true)
    end
end

-- 隐藏跨年
function MainUILayer:hideAcrossTheYears()
    if(self._acrossLayout) then
        self._acrossLayout:setVisible(false)
    end
end

-- 隐藏跨年
function MainUILayer:_getAcrollYearName(num)
    return string.format("ui_newyear_number_%d.png", num)
end

function MainUILayer:_showFireWork()
    if(GameManager:getIsShowFireWork()) then
        GameManager:setIsShowFireWork(false)
        local layout = UI.Layout:create()
        layout:init()
        layout:center()
        self.rootLayer:addChild(layout, UI_ZORDER.FULL_SCREEN)

        local fireWorkAnimation = Avalon.Animation:create("effect_ui_town_full_screen_fireworks.json", "effect_ui_town_full_screen_fireworks.atlas", 1);
        fireWorkAnimation:setAnimation(0, "idle1", false)
        fireWorkAnimation:addAnimation(0, "idle2", false)
        -- fireWorkAnimation:addAnimation(0, "idle1", false)
        -- fireWorkAnimation:addAnimation(0, "idle2", false)
        -- fireWorkAnimation:addAnimation(0, "idle1", false)

        layout:addChild(fireWorkAnimation)
        fireWorkAnimation:registerSpineEventHandler(function (event)
            if(event and event.eventData and event.eventData.name) then
                local startPos = string.find(event.eventData.name, "sound_")
                if(startPos ~= nil) then
                    -- 播放音效文件
                    local soundFilename = string.sub(event.eventData.name,7,-1)
                    Avalon.AudioManager:playDynamicSound(soundFilename,nil, nil)
                end
            end
        end, sp.EventType.ANIMATION_EVENT)

        fireWorkAnimation:registerSpineEventHandler(function (event)
            
        end, sp.EventType.ANIMATION_EVENT)

        fireWorkAnimation:registerSpineEventHandler(function (event)
            -- print("event.animation", event.animation)
            if(event.animation == "idle2") then
                fireWorkAnimation:runAction(cc.RemoveSelf:create())
                self.fireWorkAnimation = nil
            end
        end, sp.EventType.ANIMATION_END)

        self.fireWorkAnimation = fireWorkAnimation
    end
end

function MainUILayer:onShowConstraint(isShow)
    local constraintPanel = UI.UIManager:getRootNode():getChildByName("ConstraintPanel")
    if constraintPanel == nil and isShow then
        require("app.ui.battlelayer.ConstraintPanel")
        local pConstraintPanel = UI.ConstraintPanel:create()
        pConstraintPanel:center()
        pConstraintPanel:setName("ConstraintPanel")
        UI.UIManager:getRootNode():addChild(pConstraintPanel,UI_ZORDER.ACTIVITY)
    elseif constraintPanel ~= nil and not isShow then
        constraintPanel:removeFromParent()
    end
    if isShow then
        self.quickChatLayer:setVisible(false)
        self.emojiBtn:setVisible(false)
        self.pQuickExpressionLayer:isShowEmojiLayer(false)
        if self._itemPanl then
            self._itemPanl:setVisible(false)
        end
        if self._horcurxLayer then
            self._horcurxLayer:setVisible(false)
        end
        if self._petSkillPanl then
            self._petSkillPanl:setVisible(false)
        end
        if self._relicButton and (not tolua.isnull(self._relicButton)) then
            self._relicButton:setVisible(false)
        end
        if self._infernoBgButton and (not tolua.isnull(self._infernoBgButton)) then
            self._infernoBgButton:setVisible(false)
        end
    else
        if not self._isBattle then
            self._bagButton:setVisible(true)
            if self.pPopupLayer and (not tolua.isnull(self.pPopupLayer)) then
                self.pPopupLayer:setVisible(true)
            end
            if self._relicButton and (not tolua.isnull(self._relicButton)) then
                self._relicButton:setVisible(true)
            end
            if self._infernoBgButton and (not tolua.isnull(self._infernoBgButton)) then
                self._infernoBgButton:setVisible(true)
            end
        end
        self.quickChatLayer:setVisible(true)
        if (not self:_getIsHandleEmoji()) then
            self.emojiBtn:setVisible(true)
        end
        self.pQuickExpressionLayer:isShowEmojiLayer(true)
        if self._itemPanl then
            self._itemPanl:setVisible(true)
        end
        if self._horcurxLayer then
            self._horcurxLayer:setVisible(true)
        end
        if self._petSkillPanl then
            self._petSkillPanl:setVisible(true)
        end
    end
end

function MainUILayer:createAutoBattleInfo()
    if(self.autoBattleLayout == nil) then 
        self.autoBattleLayout = UI.Layout:create()
        self.autoBattleLayout:init()
        self.autoBattleLayout:centerUp(100)
        self.rootLayer:addChild(self.autoBattleLayout, UI_ZORDER.AUTO_BATTLE)

        local bg = UI.Image:create()
        bg:init("ui_auto_bg03.png")
        bg:centerUp(0)
        self.autoBattleLayout:addChild(bg)

        local infoText = UI.Text:create()
        infoText:init("", UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
        infoText:center()
        infoText:setFixLineWidth(234)
        bg:addChild(infoText)
        self.autoInfoText = infoText

        local changeButton = UI.Button:create(UIType.MAIN_UID_AUTOBTN_CHANGE_TYPE)
        changeButton:init("ui_btn_tool.png","ui_btn_tool_selected.png", "ui_btn_tool.png")
        changeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            self:createAutoBattleChangeInfo()
        end)
        changeButton:centerRight(-changeButton:getContentSize().width - 15)
        bg:addChild(changeButton)
        self.autoBattleChangeBtn = changeButton
        if(GameManager:getAutoBattleStatus() 
            and self:getIsShowAutoBattle()) then 
            self.autoBattleLayout:setVisible(true)
        else
            self.autoBattleLayout:setVisible(false) 
        end
    end
    self:refreshAutoBattle()
end

function MainUILayer:createAutoBattleChangeInfo()
    if(self.autoBattleLayout) then 
        if(not tolua.isnull(self.autoBattleChangeLayout)) then 
            self.autoBattleChangeLayout:removeFromParent(true)
            self.autoBattleChangeLayout = nil
        end

        self.autoBattleChangeLayout = UI.Layout:create()
        self.autoBattleChangeLayout:init()
        self.autoBattleChangeLayout:centerUp(0)
        self.autoBattleLayout:addChild(self.autoBattleChangeLayout)

        local clickLayout = UI.Layout:create()
        clickLayout:init()
        clickLayout:center()
        clickLayout:setSize(10000,50000)
        clickLayout:setTouchEnable(true)
        clickLayout:setInterceptTouches(true)
        clickLayout:setSwallowTouches(true)
        self.autoBattleChangeLayout:addChild(clickLayout)
        clickLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            if(not tolua.isnull(self.autoBattleChangeLayout)) then 
                self.autoBattleChangeLayout:removeFromParent(true)
                self.autoBattleChangeLayout = nil
            end
        end)


        local bg = UI.Image:create()
        bg:init("ui_auto_bg01.png")
        bg:centerUp(0)
        self.autoBattleChangeLayout:addChild(bg)

        -- 处理两个按钮信息
        local oneBg = UI.Image:create()
        oneBg:init("ui_auto_bg02.png")
        oneBg:centerUp(21)
        bg:addChild(oneBg)
        oneBg:setTouchEnable(true)
        oneBg:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            GameManager:setAutoBattleType(1)
            self.oneFlagImage:setSpriteName("ui_auto_point.png")
            self.twoFlagImage:setSpriteName("ui_auto_pointbg.png")
            self:refreshAutoBattle()
        end)

        local oneTitleText = UI.Text:create()
        oneTitleText:init(UI.TEXT_1325100, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        oneTitleText:autoAdapt()
        oneTitleText:setTextLeft()
        oneTitleText:setFixLineWidth(201)
        oneTitleText:leftUp(50, 25 - oneTitleText._height/2)
        oneTitleText:computePosition()
        oneBg:addChild(oneTitleText)

        local flagImage = UI.Image:create()
        flagImage:init("ui_auto_point.png")
        flagImage:leftUp(44 -flagImage:getContentSize().width, 25-flagImage:getContentSize().height/2)
        oneBg:addChild(flagImage)
        self.oneFlagImage = flagImage


        local infoText = UI.Text:create()
        infoText:init(UI.TEXT_1325101, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        oneBg:addChild(infoText)
        infoText:setWidth(230)
        infoText:autoAdapt()
        infoText:setTextLeftUp()
        infoText:leftUp(19, 46)

        local twoBg = UI.Image:create()
        twoBg:init("ui_auto_bg02.png")
        twoBg:centerUp(128)
        bg:addChild(twoBg)
        twoBg:setTouchEnable(true)
        twoBg:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
            GameManager:setAutoBattleType(2)
            self.oneFlagImage:setSpriteName("ui_auto_pointbg.png")
            self.twoFlagImage:setSpriteName("ui_auto_point.png")
            self:refreshAutoBattle()
        end)

        local oneTitleText = UI.Text:create()
        oneTitleText:init(UI.TEXT_1325102, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
        -- oneTitleText:autoAdapt()
        oneTitleText:setTextLeft()
        oneTitleText:setFixLineWidth(201)
        oneTitleText:leftUp(50, 25 - oneTitleText._height/2)
        twoBg:addChild(oneTitleText)

        local flagImage = UI.Image:create()
        flagImage:init("ui_auto_point.png")
        flagImage:leftUp(44 -flagImage:getContentSize().width, 25-flagImage:getContentSize().height/2)
        twoBg:addChild(flagImage)
        self.twoFlagImage = flagImage

        local infoText = UI.Text:create()
        infoText:init(UI.TEXT_1325103, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        -- infoText:setTextLeftUp()
        twoBg:addChild(infoText)
        infoText:setWidth(230)
        infoText:autoAdapt()
        infoText:setTextLeftUp()
        infoText:leftUp(19, 46)

        local changeButton = UI.Button:create()
        changeButton:init("ui_btn_yes1_1.png", "ui_btn_yes1_2.png", "ui_btn_yes1_1.png")
        changeButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            if(not tolua.isnull(self.autoBattleChangeLayout)) then 
                self.autoBattleChangeLayout:removeFromParent(true)
                self.autoBattleChangeLayout = nil
            end
        end)
        changeButton:centerBottom(14)
        bg:addChild(changeButton)

        if(GameManager:getAutoBattleType() == 1) then 
            self.oneFlagImage:setSpriteName("ui_auto_point.png")
            self.twoFlagImage:setSpriteName("ui_auto_pointbg.png")
        else
            self.oneFlagImage:setSpriteName("ui_auto_pointbg.png")
            self.twoFlagImage:setSpriteName("ui_auto_point.png") 
        end
    end
end

function MainUILayer:refreshAutoBattle()
    local showAutoBattle = self:getIsShowAutoBattle()


    if(self._autoBattleBtn) then
        if(showAutoBattle) then 
            self._autoBattleBtn:setVisible(true) 
        else
            self._autoBattleBtn:setVisible(false) 
        end

        local normalName = "ui_btn_auto_01.png"
        local selectName = "ui_btn_auto_selected.png"
        local disableName = "ui_btn_auto_01.png"
        if GameManager:getAutoBattleStatus() then 
            normalName = "ui_btn_auto_selected.png"
            selectName = "ui_btn_auto_01.png"
            disableName = "ui_btn_auto_01.png"
        end

        self._autoBattleBtn:setNormal(normalName)
        self._autoBattleBtn:setSelected(selectName)
        self._autoBattleBtn:setDisabled(disableName)
    end

    if(self.autoBattleChangeBtn) then 
        if(self._isBattle) then 
            self.autoBattleChangeBtn:setVisible(false)
        else
            self.autoBattleChangeBtn:setVisible(true)
        end
    end

    if(self.autoBattleLayout) then 
        if GameManager:getAutoBattleStatus() and showAutoBattle then 
            self.autoBattleLayout:setVisible(true)
        else
            self.autoBattleLayout:setVisible(false)
        end
    end

    if self.autoInfoText then 
        local name = UI.TEXT_1325100
        if(GameManager:getAutoBattleType() == 2) then 
            name = UI.TEXT_1325102
        end

        self.autoInfoText:setText(string.format(UI.TEXT_1325104, name))
    end
end

function MainUILayer:onAutoBattle()
    GameManager:setAutoBattleStatus(not GameManager:getAutoBattleStatus())
    self:refreshAutoBattle()
end 

function MainUILayer:getKeyConf()
    self.keyConf = GameManager:getWin32KeyConf()
    -- self:addKeyToTownUI()
end


-- 注册监听事件(可选)
function MainUILayer:registerListener()
    -- Avalon.MessageCenter:bind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.showIapShopRedPoint)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, self, self.openControlPadTracking)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, self, self.closeControlPadTracking)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_CONTROL_PAD_TRACKING_CLEAR, self, self.controlPadTrackingClear)

    Avalon.MessageCenter:bind(GameMessage.MC_UI_OPEN_CONTROL_PAD, self, self.openControlPad)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_CLOSE_CONTROL_PAD, self, self.closeControlPad)

    -- 进入战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_ENTER_BATTLE,self,self.showBattleUIHandler)
    -- 离开战斗战斗
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE,self,self.removeBattleUIHandler)

    Avalon.MessageCenter:bind(GameMessage.MC_UI_CLOSE_BAG_BUTTON, self, self.closeBagButton)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_OPEN_BAG_BUTTON, self, self.openBagButton)

    Avalon.MessageCenter:bind(GameMessage.MC_UI_SHOW_MAINUI_LAYER, self, self.showMainLayer)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_HIDE_MAINUI_LAYER, self, self.hideMainLayer)

    --启用快捷道具
    Avalon.MessageCenter:bind(GameMessage.MC_UI_ENABLE_ITEM_PANEL, self, self.enableItemPanel)
    --禁用快捷道具
    Avalon.MessageCenter:bind(GameMessage.MC_UI_DISABLE_ITEM_PANEL, self, self.disableItemPanel)
    --启用技能
    Avalon.MessageCenter:bind(GameMessage.MC_UI_ENABLE_SKILL_PANEL, self, self.enableSkillPanel)
    --禁用技能
    Avalon.MessageCenter:bind(GameMessage.MC_UI_DISABLE_SKILL_PANEL, self, self.disableSkillPanel)

    -- 收到复活完成的消息 启用快捷栏和技能界面
    Avalon.MessageCenter:bind(GameMessage.MC_BATTLE_REVIVE_END, self, self.onShowItemAndSkill)
    -- 角色状态更新 
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    Avalon.MessageCenter:bind(GameMessage.MC_BATTLE_UPDATE_DUNGEON_COUNT_DOWN, self, self.updateDungeonCountDown)

    -- 显示选中英雄
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_SHOW_CHOICE_HERO, self, self.onShowChoiceHeroHandler)

    -- 显示物品掉落 MC_ROLE_GET_GOODS
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_GET_GOODS,self,self.showItemDropLayer)

    --显示队伍选择界面
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM, self, self.onShowLevelSelectTeamHandler)

    --刷新按钮解锁状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
    -- 红点
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_SKILL_POINT_RED_POINT, self, self.refreshRedPoint)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshRedPoint)

    -- 主角死亡，复活完成
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_DEAD, self, self.masterDead)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_MASTER_REVIVE, self, self.masterRevive)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, self, self.screenSystemNotice)
    Avalon.MessageCenter:bind(AvalonMessage.MC_SETTING_CONTROL_CHANGE, self, self.changeMoveType)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_JUMP_LAYER_ANSWER, self, self.onShowAnswerQuestionHandler)
    -- 在战斗界面刷新梦境任务状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_DREAM_TASK_STATE,self,self.refreshDreamTaskState)
    -- worldboss topbar show
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_WORLDBOSS_SHOW_TOPBAR,self,self.showWorldBossTopBar)
    -- worldboss topbar hide
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_WORLDBOSS_HIDE_TOPBAR,self,self.hideWorldBossTopBar)
    -- 更新提示系统状态
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_BAG_NOTI_STATUS,self,self.refreshBagNotiStatus)

    Avalon.MessageCenter:bind(AvalonMessage.MC_LITTLE_BOSS_SEAL_INFO, self, self.onSealBossUpdate)

    Avalon.MessageCenter:bind(GameMessage.MC_HORCRUX_ENGERY_REFRESH, self, self.onUpdateHorcurxEngeryRefresh)
    Avalon.MessageCenter:bind(GameMessage.MC_UI_QUICK_DOWN_CHANGE, self, self.onQuickDownChange)
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_HORCURX_TRANS_CHANGED, self, self.onHorcurxTransChanged)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onHorcurxIllusitionChanged)
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_QUICK_EMOJI_CLOSE, self, self.cancelQucikEmojiBtnClick)

    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_STATUS_CONSTRAINT,self,self.onShowConstraint)
    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_CHANGE_AUTO_BATTLE_STATUS,self,self.refreshAutoBattle)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_BET_SHOW_OR_CLOSE,self, self.showOrHideBetTopBar)

    -- boss召唤怪时刷新状态UI
    Avalon.MessageCenter:bind(AvalonMessage.MC_CHANGE_MONSTER_PANNEL,self,self.changeMonsterPannel)
end

-- 注销监听事件(可选)
function MainUILayer:unRegisterListener()
    
    -- Avalon.MessageCenter:unbind(GameMessage.MC_UPDATE_IAPSHOP_BOX_NUMS, self, self.showIapShopRedPoint)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_OPEN_CONTROL_PAD_TRACKING, self, self.openControlPadTracking)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_CLOSE_CONTROL_PAD_TRACKING, self, self.closeControlPadTracking)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_CONTROL_PAD_TRACKING_CLEAR, self, self.controlPadTrackingClear)
    
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_OPEN_CONTROL_PAD, self, self.openControlPad)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_CLOSE_CONTROL_PAD, self, self.closeControlPad)

    -- 进入战斗
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_ENTER_BATTLE,self,self.showBattleUIHandler)
    -- 离开战斗战斗
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_LEAVE_BATTLE,self,self.removeBattleUIHandler)

    Avalon.MessageCenter:unbind(GameMessage.MC_UI_CLOSE_BAG_BUTTON, self, self.closeBagButton)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_OPEN_BAG_BUTTON, self, self.openBagButton)

    Avalon.MessageCenter:unbind(GameMessage.MC_UI_SHOW_MAINUI_LAYER, self, self.showMainLayer)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_HIDE_MAINUI_LAYER, self, self.hideMainLayer)


    Avalon.MessageCenter:unbind(GameMessage.MC_UI_ENABLE_ITEM_PANEL, self, self.enableItemPanel)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_DISABLE_ITEM_PANEL, self, self.disableItemPanel)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_ENABLE_SKILL_PANEL, self, self.enableSkillPanel)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_DISABLE_SKILL_PANEL, self, self.disableSkillPanel)
    
        -- 收到复活完成的消息 启用快捷栏和技能界面
    Avalon.MessageCenter:unbind(GameMessage.MC_BATTLE_REVIVE_END,self, self.onShowItemAndSkill)
    -- 角色状态更新 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)

    Avalon.MessageCenter:unbind(GameMessage.MC_BATTLE_UPDATE_DUNGEON_COUNT_DOWN, self, self.updateDungeonCountDown)
    -- 显示选中英雄
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_SHOW_CHOICE_HERO, self, self.onShowChoiceHeroHandler)

    -- 显示物品掉落 MC_ROLE_GET_GOODS
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_GET_GOODS,self,self.showItemDropLayer)

    --显示队伍选择界面
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM, self, self.onShowLevelSelectTeamHandler)

        --刷新按钮解锁状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)

    -- 红点
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_SKILL_POINT_RED_POINT, self, self.refreshRedPoint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_TASK_POINT_RED_POINT, self, self.refreshRedPoint) 

    -- 主角死亡，复活完成
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_MASTER_DEAD, self, self.masterDead)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_MASTER_REVIVE, self, self.masterRevive)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SCRENN_SYSTEM_NOTICE, self, self.screenSystemNotice)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_SETTING_CONTROL_CHANGE, self, self.changeMoveType)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_JUMP_LAYER_ANSWER, self, self.onShowAnswerQuestionHandler)
     -- 在战斗界面刷新梦境任务状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_DREAM_TASK_STATE,self,self.refreshDreamTaskState)
    -- worldboss topbar
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_WORLDBOSS_SHOW_TOPBAR,self,self.showWorldBossTopBar)
    -- worldboss topbar hide
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_WORLDBOSS_HIDE_TOPBAR,self,self.hideWorldBossTopBar)
    -- 更新提示系统状态
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_BAG_NOTI_STATUS,self,self.refreshBagNotiStatus)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LITTLE_BOSS_SEAL_INFO, self, self.onSealBossUpdate)
    Avalon.MessageCenter:unbind(GameMessage.MC_HORCRUX_ENGERY_REFRESH, self, self.onUpdateHorcurxEngeryRefresh)
    Avalon.MessageCenter:unbind(GameMessage.MC_UI_QUICK_DOWN_CHANGE, self, self.onQuickDownChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_HORCURX_TRANS_CHANGED, self, self.onHorcurxTransChanged)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_HORCURX_INFO_UPDATE, self, self.onHorcurxIllusitionChanged)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_QUICK_EMOJI_CLOSE, self, self.cancelQucikEmojiBtnClick)
        -- 战斗中被束缚
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_STATUS_CONSTRAINT,self,self.onShowConstraint)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_CHANGE_AUTO_BATTLE_STATUS,self,self.refreshAutoBattle)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_BET_SHOW_OR_CLOSE,self, self.showOrHideBetTopBar)

    -- boss召唤怪时刷新状态UI
    Avalon.MessageCenter:unbind(AvalonMessage.MC_CHANGE_MONSTER_PANNEL,self,self.changeMonsterPannel)
end

function MainUILayer:_getIsHandleNewUI()
    if (GameManager:getIsNewTownType() 
    and not SceneManager:getInstance():isGuild() 
    and not SceneManager:getInstance():isInManor()
    and not SceneManager:getInstance():isInPort()) then
    -- if(GameManager:getIsNewTownType() and
    --     SceneManager:getInstance():isInTown()) then
        return true
    end

    return false
end

function MainUILayer:_getIsHandleInTown()
    if(GameManager:getIsNewTownType() and
        SceneManager:getInstance():isInTown()) then
        return true
    end

    return false
end

function MainUILayer:_getIsHandleEmoji()
    if(GameManager:getIsNewTownType() and
        (SceneManager:getInstance():isInTown()
        or SceneManager:getInstance():isHome())) then
        return true
    end

    return false
end

function MainUILayer:_getIsHandleControl()
    if(GameManager:getIsNewTownType() and
        (SceneManager:getInstance():isInTown())) then
        return true
    end

    if(SceneManager:getInstance():isInLostRealm()) then 
        return true
    end

    return false
end

function MainUILayer:getIsShowAutoBattle()
    if (RoleDataManager:getMaster() and RoleDataManager:getMaster():isHorcruxTransform())
        or not GameManager:getIsShowAutoBattle() then
        return false
    end

    return true
end
