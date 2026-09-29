------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2019/05/09
--desc	:
------------------------------------------------------------------------------

require("utils.ObserverVariable")
require("app.ui.town.levelSelect.LevelSelectDifficulty")
require("app.ui.town.levelSelect.LevelSelectTeam")
require("app.ui.town.levelSelect.LevelSelectReady")
require("app.ui.town.levelSelect.LevelSelectNormalBtn")
require("app.ui.town.levelSelect.LevelSelectEventBtn")
require("app.ui.UIManager")
require "app.datas.AnswerDataManager"
require("app.ui.town.SuperLevelSelect")
require("app.modules.expedition.ExpeditionDetailCell")

local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local scheduler = cc.Director:getInstance():getScheduler()
require("app.utils.RewardPreViewUtil")

UI = UI or {}
local winSize = cc.Director:getInstance():getWinSize()
local LayerSize = cc.size(1022, 579)
local NodeSize = cc.size(63, 70)
local ScrollViewSize = cc.size(700, 460)
local rightLayerSize = cc.size(700, 580)
local maxBoundValue = 190

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ExpeditionView = class("ExpeditionView", UI.SuperLevelSelect)

-- 资源
local COM_RES_LIST = {
    "ui_town_levelselect.plist",
    "ui_town_expedition.plist",
    "ui_town_guild_writ.plist",
}

local SHOW_VIEW_TYPE = {
    SHOW_VIEW_TYPE_SELECT = 1,
    SHOW_VIEW_TYPE_DETAIL = 2,
}

local COM_WIDTH = 1022
local COM_HEIGHT = 579
local CARD_ID = 22070580

local layoutUtil

function ExpeditionView:ctor(params)
    self.layerType = Game.LevelSelectLayerType.Expedition
    ExpeditionView.super.ctor(self, UI.Type.EXPEDITION, COM_RES_LIST, COM_WIDTH, COM_HEIGHT, nil, self.layerType)

    self._nowShowType = SHOW_VIEW_TYPE.SHOW_VIEW_TYPE_SELECT
    if params and type(params) == "table" then 
        self.showMode = params.mode 
        self.showLevel = params.level
        self._nowShowType = SHOW_VIEW_TYPE.SHOW_VIEW_TYPE_DETAIL
    end

    self.preClickTime = 0
    self:bindModel()
    self._detailStr = ""
    self._maxNormalLevel = 0
    self.rootLayer = nil --root节点
    self.preExpeditionStatus = mvc.expeditionModel:getExpeditionStatus()

    self.levelBtnList = {} --关卡按钮
    self.stepPoint = {} --二位数组  组成关卡连线 的点的集合
    self.levelBtnRootNode = nil --关卡Root

    self.lockAllBtn = false --按钮锁，点击开始按钮后播放动画的过程中锁住所有按钮
    self.isShowEvent = false --在英雄模式下 是否展示特殊事件模式
    self.defaultNomalSelectIcon = nil
    self.defaultHeroSelectIcon = nil
    self.mBClick = true
    self.mLockDiffSelect = false
    self.curCaveMode = nil
    self.spriteID = NPCSpriteID
    self.isFloatCloudAct = false
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    -- __EDIT_ = false
    layoutUtil = UIUtil:createAutoUILayout("ExpeditionView", "app.modules.expedition.ExpeditionPosConfig", false)

    -- 计算当前的进度
    self.data = {}
    if (mvc.expeditionModel:getExpeditionStatus()) then
        self.data.caveMode = mvc.expeditionModel:getExpeditionMode()
    else
        local masterData = RoleDataManager:getMaster()
        local localModel = nil

        if localModel == nil and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_CHAOS) then
            if ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_CHAOS) > 0 then 
                localModel = PublicDefine.CAVE_MODE.MODE_CHAOS
            end
        end

        if localModel == nil and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring) then
            if ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_DRIED_SPRING) > 0 then 
                localModel = PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
            end
        end 

        if localModel == nil and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero) then
            -- if ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) > 0 then 
                localModel = PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO
            -- end
        end 

        if localModel == nil and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad) then
            if ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD) > 0 then 
                localModel = PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
            end
        end 

        if localModel == nil and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Inferno) then
            if ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_INFERNO) > 0 then 
                localModel = PublicDefine.CAVE_MODE.MODE_INFERNO
            end
        end

        if localModel == nil and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) then
            if ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_VOID_RIFT) > 0 then 
                localModel = PublicDefine.CAVE_MODE.MODE_VOID_RIFT
            end
        end

        if localModel == nil and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Viking) then
            if ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_VIKING) > 0 then 
                localModel = PublicDefine.CAVE_MODE.MODE_VIKING
            end
        end

        if localModel == nil and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DistortedSpace) then
            if ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE) > 0 then 
                localModel = PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE
            end
        end

        if localModel == nil and  RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye) then
            if ToolsUtil:getExpeditionLevel(PublicDefine.CAVE_MODE.MODE_DESERT_EYES) > 0 then 
                localModel = PublicDefine.CAVE_MODE.MODE_DESERT_EYES
            end
        end 

        if localModel == nil and RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then
            -- local checkPointData = masterData:getCheckpointData(PublicDefine.CAVE_MODE.MODE_HERO, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
            -- if(checkPointData and checkPointData:getCheckpoint() > 2001) then 
                localModel = PublicDefine.CAVE_MODE.MODE_HERO
            -- end
        end
        self.data.caveMode = localModel
    end

    if (self.data.caveMode == nil) then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_NORMAL
        self.data.curOpenLevel = self._maxNormalLevel
        self.data.oldOpenLevel = self._maxNormalLevel
    end
    -- 用于表现附近数据的信息
    self._nearData = {}

    self:registerListener()
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self, self.update), 1, false)
end

function ExpeditionView:init()
    -- body
    ExpeditionView.super.init(self)
end

function ExpeditionView:dtor()
    ExpeditionView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.expedition.ExpeditionView")

    if self.caveEnterLayer then
        self.caveEnterLayer:closeLayer()
    end

    self:unRegisterListener()
    if self.schedulerID then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end

    local textureCache = cc.Director:getInstance():getTextureCache()
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_2.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_3.png")

    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_heromap_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_heromap_2.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_heromap_3.png")
end

function ExpeditionView:onInitView()
    self._enableAutoUpdatePos = false
    self:setIgnoreAnchorPointForPosition(false)
    self:setAnchorPoint(0, 0.5)
    self:setPosition(0, winSize.height / 2)

    -- local scaleX = (winSize.width - 50 - Avalon.issUtil:getLeftMargin()) / LayerSize.width
    local xMinSpace = 30
     -- 是让横向 不要挤得太满
    local yMinSpace = 80
     -- 是让竖向 不要挤得太满
    --底线参数 点击空余
    local xMaxSpace = 100
     -- 让横向 有足够多的点击空间
    local yMaxSpace = 120
     -- 让竖向 有足够多的点击空间
    local scaleX = (winSize.width - xMinSpace - Avalon.issUtil:getLeftMargin()) / LayerSize.width
    local scaleY = (winSize.height - yMinSpace) / LayerSize.height
    local scaleXLowLimite = (winSize.width - xMaxSpace - Avalon.issUtil:getLeftMargin()) / LayerSize.width
    local scaleYLowLimite = (winSize.height - yMaxSpace) / LayerSize.height

    local scale = 1
    if scaleY > scaleX then
        scale = scaleX < scaleYLowLimite and scaleX or scaleYLowLimite
    else
        scale = scaleY < scaleXLowLimite and scaleY or scaleXLowLimite
    end

    scale = scale < 1 and 1 or scale
    self:setScale(scale)
    -- self:addColorBG()
    MasterDataManager:checkRefreshCountAndTime()
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:center()
    self.rootLayer:setSize(LayerSize.width, LayerSize.height)
    self:addChild(self.rootLayer)
    -- self.rootLayer:enableDebugDraw()
    self:initLeftLayout()
    self:initRightChoice()
    self:initRightDetail()

    if(SceneManager:getInstance():isInFightScene()) then
        self:showDetailView()
        self.rewardDetailBtn:setVisible(false)
    else 
        self:showLevelSelectView()
    end

    self:update(0.1)
    self:refreshBtnStatus()
    self:refreshTabState()
    self:refreshItemButton()

    self:refreshCaveBtn(self.data.caveMode)
end

function ExpeditionView:initLeftLayout()
    local leftLayer = UI.Component:create()
    leftLayer:init()
    leftLayer:setSize(400, 640)
    self.rootLayer:addChild(leftLayer, 2)
    self.leftLayer = leftLayer

    local bgAnimation = UI.Animation:create()
    bgAnimation:init("effect_ui_town_expedition_diban.json", "effect_ui_town_expedition_diban.atlas")
    bgAnimation:setInnerOffset(-2, -2)
    bgAnimation:leftBottom(184, 198)
    bgAnimation:setAnimation("begin", true)
    leftLayer:addChild(bgAnimation)
    self.bgAnimation = bgAnimation

    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:leftBottom(-20, 38)
    leftLayout:setSize(400, 640)
    leftLayer:addChild(leftLayout)

    -- 添加相关组件
    local topLayout = UI.Layout:create()
    topLayout:init()
    topLayout:centerUp(10)
    topLayout:setSize(250, 115)
    leftLayout:addChild(topLayout)

    local topBg = UI.Image:create()
    topBg:init("ui_explore_board.png")
    topBg:centerLeft(-5)
    -- topLayout:addChild(topBg)
    addChildAuto(layoutUtil, topLayout, topBg, "topBg", "center")

    -- 1110031
    local choiceLevelText = UI.Text:create()
    choiceLevelText:init(UI.TEXT_110001, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
    -- choiceLevelText:centerUp(15)
    -- topLayout:addChild(choiceLevelText, 10)
    addChildAuto(layoutUtil, topLayout, choiceLevelText, "choiceLevelText", "center")
    self.choiceLevelText = choiceLevelText

    -- 金币加成
    local cointLayout = UI.Layout:create()
    cointLayout:init()
    cointLayout:centerUp(62)
    cointLayout:setSize(0, 0)
    topLayout:addChild(cointLayout)
    -- addChildAuto(layoutUtil, topLayout, cointLayout, "cointLayout", "center")

    local coinImage = UI.Image:create()
    coinImage:init("symbol_gaming_money.png")
    coinImage:centerLeft(0)
    coinImage:setScale(0.9)
    cointLayout:addChild(coinImage, 10)
    self.coinImage = coinImage

    local coinTitleText = UI.Text:create()
    coinTitleText:init(UI.TEXT_1212572, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    coinTitleText:centerLeft(15)
    cointLayout:addChild(coinTitleText, 10)
    self.coinTitleText = coinTitleText

    local coinDesText = UI.Text:create()
    coinDesText:init(UI.TEXT_1212572, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    coinDesText:centerLeft(15)
    cointLayout:addChild(coinDesText, 10)
    self.coinDesText = coinDesText

    local coinUpImage = UI.Image:create()
    coinUpImage:init("ui_information_arrow_up.png")
    coinUpImage:centerLeft(-5)
    cointLayout:addChild(coinUpImage)
    self.coinUpImage = coinUpImage

    -- 经验加成
    local expLayout = UI.Layout:create()
    expLayout:init()
    expLayout:centerUp(82)
    expLayout:setSize(0, 0)
    topLayout:addChild(expLayout)
    -- addChildAuto(layoutUtil, topLayout, expLayout, "expLayout", "center")

    local expImage = UI.Image:create()
    expImage:init("symbol_gaming_xp.png")
    expImage:centerLeft(0)
    expImage:setScale(0.9)
    expLayout:addChild(expImage, 10)
    self.expImage = expImage

    local expTitleText = UI.Text:create()
    expTitleText:init(UI.TEXT_1212572, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    expTitleText:centerLeft(15)
    expLayout:addChild(expTitleText, 10)
    self.expTitleText = expTitleText

    local expDesText = UI.Text:create()
    expDesText:init(UI.TEXT_1212572, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    expDesText:centerLeft(15)
    expLayout:addChild(expDesText, 10)
    self.expDesText = expDesText


    local expUpImage = UI.Image:create()
    expUpImage:init("ui_information_arrow_up.png")
    expUpImage:centerLeft(-5)
    expLayout:addChild(expUpImage)
    expUpImage:setVisible(false)
    self.expUpImage = expUpImage

    -- 月卡加成
    local monthCardLayout = UI.Layout:create()
    monthCardLayout:init()
    monthCardLayout:setSize(246, 40)
    monthCardLayout:leftBottom(10, -23)
    -- monthCardLayout:enableDebugDraw()
    topLayout:addChild(monthCardLayout)
    monthCardLayout:setTouchEnable(true)
    monthCardLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onCardClick)

    local cartEffect = UI.Animation:create()
    cartEffect:init("effect_ui_town_expedition_yueka.json", "effect_ui_town_expedition_yueka.atlas")
    cartEffect:centerLeft(33)
    cartEffect:setAnimation("idle", true)
    monthCardLayout:addChild(cartEffect, 11)
    self.cardEffect = cartEffect

    local writBufIcon = UI.Image:create()
    writBufIcon:init("ui_guild_writ_metal_2_1.png")
    writBufIcon:centerLeft(-23)
    monthCardLayout:addChild(writBufIcon, 11)
    writBufIcon:setScale(0.3)
    self.writBufIcon = writBufIcon

    local cardTitle = UI.Text:create()
    cardTitle:init(UI.TEXT_1212603, UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_170_170_170)
    cardTitle:leftUp(140 - cardTitle:getContentSize().width / 2, 0)
    monthCardLayout:addChild(cardTitle)
    self.cardTitle = cardTitle

    -- 加成
    local expeditionCoinincome = ConfigManager:getGeneralForKey("ExpeditionCoinincome")
    local rewardArr = string.split(expeditionCoinincome, ";")
    local startX = 56
    local offsetY = 19
    if (rewardArr and #rewardArr) then
        local image = UI.Image:create()
        image:init("symbol_gaming_money.png")
        image:leftUp(startX, offsetY)
        monthCardLayout:addChild(image)
        image:setScale(0.7)
        startX = startX + image:getContentSize().width + 4

        local info = UI.Text:create()
        info:init(
            string.format("+%s", string.format("%.1f", (tonumber(rewardArr[1]) * 100) / RATIO_NUMBER) .. "%"),
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX,
            UI.FONT_COLOR_36_181_118
        )
        info:leftUp(startX, offsetY)
        monthCardLayout:addChild(info)
        startX = startX + info:getContentSize().width + 20
        self.cardCoinText = info

        local image = UI.Image:create()
        image:init("symbol_gaming_xp.png")
        image:leftUp(startX, offsetY)
        image:setScale(0.7)
        monthCardLayout:addChild(image)
        startX = startX + image:getContentSize().width + 4

        local info = UI.Text:create()
        info:init(
            string.format("+%s", string.format("%.1f", (tonumber(rewardArr[2]) * 100) / RATIO_NUMBER) .. "%"),
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX,
            UI.FONT_COLOR_36_181_118
        )
        info:leftUp(startX, offsetY)
        monthCardLayout:addChild(info)
        self.cardExpText = info
    end

    -- 触摸
    local touchLayout = UI.Layout:create()
    touchLayout:init()
    touchLayout:setSize(240, 50)
    touchLayout:setTouchEnable(true)
    touchLayout:rightBottom(0, 15)
    topLayout:addChild(touchLayout)
    -- touchLayout:enableDebugDraw()
    -- touchLayout:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
    --     if(self.expUpImage:isVisible() or self.coinUpImage:isVisible()) then
    --         self:showDetailInfo(touchLayout, self._detailStr)
    --     end
    -- end)
    -- touchLayout:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.hideDetailInfo)

    -- -- 查看详情
    -- local spineName = "effect_ui_package_role_detail_hint_icon"
    -- local infoBtn = UI.Component:create()
    -- infoBtn:init()
    -- local spine = UI.Animation:create()
    -- spine:init(string.format("%s.json", spineName), string.format("%s.atlas", spineName))
    -- spine:setName("spine")
    -- spine:setAnimation("idle", false)
    -- local size = spine:getBoundingBox()
    -- spine:setSize(size.width, size.height)
    -- spine:setScale(0.8)
    -- infoBtn:setSize(size.width, size.height)
    -- spine:center()
    -- infoBtn:addChild(spine, 1)
    -- infoBtn:setTouchEnable(true)
    -- infoBtn:rightUp(3, 15)
    -- infoBtn:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, self._showFunctionInfo)
    -- infoBtn:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.hideFunctionInfo)
    -- topLayout:addChild(infoBtn, 10)

    -- 角色动画
    self._heroData = RoleDataManager:getMaster()
    self._roleAnimation = UI.RoleAnimation:create()
    self._roleAnimation:init(self._heroData)
    self._roleAnimation:centerBottom(168 - 10)
    self._roleAnimation:setScaleX(-1 * self._roleAnimation:getScaleX())
    leftLayout:addChild(self._roleAnimation, 10)

    self._roleAnimation:addEventListener(
        UIEvent.ROLE_LOADED_SPINE_SUCCESS,
        self,
        function()
            Avalon.Scheduler:scheduleUpdateOnceByFrameEvent(
                self,
                function()
                    self:playRoleExpedition(true)
                end,
                0.2
            )
        end
    )

    local roleEffect = UI.Animation:create()
    roleEffect:init("effect_ui_town_expedition_zhujue.json", "effect_ui_town_expedition_zhujue.atlas")
    roleEffect:setInnerOffset(-2, -2)
    roleEffect:centerBottom(168 - 10)
    leftLayout:addChild(roleEffect, 11)
    self.roleEffect = roleEffect

    -- 探险倒计时
    local bg = UI.Image:create()
    bg:init("ui_explore_flag.png")
    bg:leftBottom(20, 380)
    -- leftLayout:addChild(bg, 200)
    bg:setZOrder(10)
    addChildAuto(layoutUtil, leftLayout, bg, "ui_explore_flag", "center")

    local countDownTitleText = UI.Text:create()
    countDownTitleText:init(UI.TEXT_1212576, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    countDownTitleText:leftUp(101 - countDownTitleText:getContentSize().width / 2, 8)
    bg:addChild(countDownTitleText, 10)
    self.countDownTitleText = countDownTitleText

    local countDownDesText = UI.Text:create()
    countDownDesText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    -- countDownDesText:centerUp(15)
    countDownDesText:leftUp(101 - countDownDesText:getContentSize().width / 2, 30)
    bg:addChild(countDownDesText, 10)
    -- addChildAuto(layoutUtil, bg, countDownDesText, "countDownDesText", "center")
    self.countDownDesText = countDownDesText

    local clockIcon = AvalonUtil.createClockAnimation()
    clockIcon:setAnchorPoint(0.5, 0.5)
    clockIcon:setScale(0.8)
    clockIcon:centerLeft(-clockIcon:getContentSize().width - 4)
    self.countDownDesText:addChild(clockIcon)

    -- -- 快速探险提示
    -- local rewardCapR = UI.Image:create()
    -- rewardCapR:init("ui_explore_platform.png")
    -- rewardCapR:rightBottom(257, 0)
    -- -- leftLayer:addChild(rewardCapR, 10)
    -- addChildAuto(layoutUtil, leftLayout, rewardCapR, "rewardCapR", "center")
    -- self.rewardCapR = rewardCapR

    -- 查看背包数据
    local offsetY = 19
    local ordinaryBagBtn = UI.Button:create()
    ordinaryBagBtn:init(
        "ui_explore_knapsack_ordinary_1.png",
        "ui_explore_knapsack_ordinary_2.png",
        "ui_explore_knapsack_ordinary_3.png"
    )
    ordinaryBagBtn:leftBottom(91, offsetY)
    ordinaryBagBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onOpenNormalBag)
    leftLayout:addChild(ordinaryBagBtn, 100)
    self.ordinaryBagBtn = ordinaryBagBtn
    ordinaryBagBtn:closeClickScale()
    self.ordinaryBagStaus = AvalonUtil.createRedPoint(self.ordinaryBagBtn, 24, 12, 101)

    local fastBagBtn = UI.Button:create()
    fastBagBtn:init(
        "ui_explore_knapsack_fast_1.png",
        "ui_explore_knapsack_fast_2.png",
        "ui_explore_knapsack_fast_3.png"
    )
    fastBagBtn:leftBottom(200, offsetY)
    fastBagBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onOpenFastBag)
    leftLayout:addChild(fastBagBtn, 100)
    self.fastBagBtn = fastBagBtn
    self.fastBagStaus = AvalonUtil.createRedPoint(self.fastBagBtn, 24, 12, 101)
    fastBagBtn:closeClickScale()

    -- 添加底部装饰物
    local bottomAnimation = UI.Animation:create()
    bottomAnimation:init("effect_ui_town_expedition_candle.json", "effect_ui_town_expedition_candle.atlas")
    bottomAnimation:setInnerOffset(-2, -2)
    bottomAnimation:leftBottom(leftLayout:getContentSize().width / 2 + 10, 20)
    bottomAnimation:setAnimation("begin", true)
    leftLayout:addChild(bottomAnimation, 100)
    self.bottomAnimation = bottomAnimation

    -- 详情按钮
    local rewardDetailBtn = UI.Button:create()
    rewardDetailBtn:init(
        "ui_btn_explore1_0.png",
        "ui_btn_explore1_1.png",
        "ui_btn_explore1_0.png"
    )
    rewardDetailBtn:rightBottom(42-rewardDetailBtn:getContentSize().width/2, 243-rewardDetailBtn:getContentSize().height/2)
    rewardDetailBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onChangeDetailOrSelect)
    leftLayout:addChild(rewardDetailBtn, 100)
    self.rewardDetailBtn = rewardDetailBtn

    -- 猫头鹰装饰物
    local maoTouYingAnimation = UI.Animation:create()
    maoTouYingAnimation:init("effect_ui_town_expedition_owl.json", "effect_ui_town_expedition_owl.atlas")
    maoTouYingAnimation:setInnerOffset(-2, -2)
    maoTouYingAnimation:leftBottom(60, 448)
    maoTouYingAnimation:setAnimation("begin", true)
    leftLayout:addChild(maoTouYingAnimation, 100)
    self.maoTouYingAnimation = maoTouYingAnimation

    self:refreshMonthCardStatus()
end

function ExpeditionView:initRightDetail()
    local rightLayer = UI.Layout:create()
    rightLayer:init()
    rightLayer:leftBottom(323, 0)
    rightLayer:setSize(rightLayerSize.width, rightLayerSize.height)
    self.rightDetailLayer = rightLayer
    self.rootLayer:addChild(rightLayer, 1)

    -- 背景
    local bg = UI.Image:create()
    bg:init("ui_explore_paper_big.png")
    bg:center()
    rightLayer:addChild(bg)

    -- model 图标
    local titleIcon = UI.Image:create()
    titleIcon:init(self:getModelTitleName(nil))
    titleIcon:leftUp(153 - titleIcon:getContentSize().width/2, 46 - titleIcon:getContentSize().height/2)
    bg:addChild(titleIcon)
    self.titleIcon = titleIcon

    -- 名字
    local nameText = UI.Text:create()
    nameText:init(UI.TEXT_1213406, UI.FONT_STANDARD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_155_155_155)
    nameText:centerUp(46 - nameText:getContentSize().height/2)
    bg:addChild(nameText)

    local splitLine = UI.Image9:create()
    splitLine:init(
        "ui_scale9image_banner_line_long.png",
        CCRectMake(20, 1, 1, 1),
        cc.size(604, 2)
    )
    splitLine:leftUp(52, 94)
    bg:addChild(splitLine)

    local splitLine = UI.Image9:create()
    splitLine:init(
        "ui_scale9image_banner_line_long.png",
        CCRectMake(20, 1, 1, 1),
        cc.size(604, 2)
    )
    splitLine:leftBottom(52, 26)
    bg:addChild(splitLine)

    -- 中间列表区域
    -- 称号列表本身
    self._titleTableView = UI.TableView:create({}, 714, 434)
    self._titleTableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._titleTableView:leftUp(52, 107)
    self._titleTableView:setDelegate()
    self._titleTableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._titleTableView:setBounceable(true)
    self._titleTableView:setOpacityModifyRGB(true)
    self._titleTableView:init()
    self._titleTableView:onUpdateCellSize(function (table,idx)
        return 585, 138
    end) 

    self._titleTableView:onUpdateCells(function (table, idx)
        -- print("self._titleTableView:onUpdateCells=", idx)
        -- 获取缓存的格子, 如果没有, 就新建
        local reusedCell = table:dequeueCell()
        if (not reusedCell) then
            reusedCell = UI.TableViewCell:create()
            xpcall(function()
                local cellView = UI.ExpeditionDetailCell:create()
                cellView:init()
                cellView:setTouchClipNode(self._titleTableView)
                cellView:leftBottom(0, 0)
                cellView:setName("cellView")
                reusedCell:addChild(cellView)
                cellView:updateData(self._nearData[idx + 1])
            end,
            function(e) 
                printError("------------------------GoodsListNew:tableCellAtIndex-----------------error", e)
            end, 1);
        else 
            local cellView = reusedCell:getChildByName("cellView")
            if (cellView) then
                cellView:updateData(self._nearData[idx + 1])
            end
        end

        return reusedCell
    end)

    self._titleTableView:onUpdateCellNumbers(function ()
        return #self._nearData
    end)

    self._titleTableView:onTableCellTouched(function(table, cell)
        
    end)
    -- 载入数据
    self._titleTableView:reloadData()
    self._titleTableView:fixContentOffset()
    bg:addChild(self._titleTableView, 0)

    -- 遮罩
    local tableMaze = UI.Image:create()
    tableMaze:init("ui_explore_checkpoint_gradually4.png")
    tableMaze:leftBottom(32, 29)
    bg:addChild(tableMaze)
end

function ExpeditionView:updateNearDataAndView()
    self._nearData = {}
    local mode = self.showMode
    local level = nil
    if(not SceneManager:getInstance():isInFightScene()) then
        mode = self.data.caveMode
        level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
    else
        level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.showLevel)
        -- print("ExpeditionView:updateNearDataAndView=", level, self.showLevel, mode)
        if(PublicDefine.CONST_DEFINITION.BOSS_LEVEL_MAX > level and level >= PublicDefine.CONST_DEFINITION.BOSS_LEVEL_MIN) then 
            level = PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN + (level - PublicDefine.CONST_DEFINITION.BOSS_LEVEL_MIN + 1)
        end 
    end

    self.titleIcon:setSpriteName(self:getModelTitleName(mode))

    self._nearData = ConfigManager:getExpeditionConfigByCP(mvc.expeditionModel:calculationExpeditionID(mode, level)) 
    table.sort(self._nearData, function(a, b)
        if(a.ID < b.ID) then 
            return true
        else 
            return false
        end
    end)
    self._titleTableView:reloadData()
    -- print("updateNearDataAndView", mode, level, #self._nearData)
end

function ExpeditionView:getModelTitleName(mode)
    local str = "ui_explore_ordinary1.png"
    if(mode) then 
        if(mode == PublicDefine.CAVE_MODE.MODE_HERO) then 
            str = "ui_explore_hero1.png"
        elseif (mode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES) then 
            str = "ui_explore_eye1.png"
        elseif (mode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE) then 
            str = "ui_explore_distortedSpace1.png"
        elseif (mode == PublicDefine.CAVE_MODE.MODE_INFERNO) then 
            str = "ui_explore_inferno1.png"
        elseif (mode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT) then 
            str = "ui_explore_uncharted1.png"
        elseif (mode == PublicDefine.CAVE_MODE.MODE_VIKING) then 
            str = "ui_explore_reincarnation1.png"
        elseif (mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD) then 
            str = "ui_explore_titan1.png"
        elseif (mode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then 
            str = "ui_explore_titan_hero1.png"
        elseif (mode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING) then 
            str = "ui_explore_dryspring1.png"
        elseif (mode == PublicDefine.CAVE_MODE.MODE_CHAOS) then 
            str = "ui_explore_chaos1.png"
        end
    end

    return str
end

function ExpeditionView:initRightChoice()
        -----------------------
    local _ckipperSprite = cc.LayerColor:create(cc.c4b(0, 0, 0, 200))
    _ckipperSprite:setContentSize(rightLayerSize.width, rightLayerSize.height)
    local clipper = cc.ClippingNode:create(_ckipperSprite)
    clipper:setPosition(323, 0)
    self.rootLayer:addChild(clipper, 1)

    local rightLayer = UI.Layout:create()
    rightLayer:init()
    rightLayer:leftBottom(0, 0)
    rightLayer:setSize(rightLayerSize.width, rightLayerSize.height)
    -- self.rootLayer:addChild(rightLayer)
    self.rightLayer = rightLayer
    clipper:addChild(rightLayer)
    self.clipper = clipper

    local rewardTip = UI.Text:create()
    rewardTip:init(
        LanguageManager:getInstance():getLocalString(1111346),
        UI.FONT_STANDARD,
        UI.FONT_SIZE_18PX,
        UI.FONT_COLOR_41_41_45
    )
    rewardTip:centerBottom(80)
    rightLayer:addChild(rewardTip, 10)

    local lineWidth = 51
    local startX = (285 - 20 - rewardTip:getContentSize().width) / 2 - 10
    rewardTip:leftBottom(startX + lineWidth + 10, 80)

    local lineL = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineL:setContentSize(lineWidth, 2)
    lineL:setAnchorPoint(0, 0)
    lineL:setPosition(startX, 92)
    rightLayer:addChild(lineL, 10)

    local lineR = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineR:setContentSize(lineWidth, 2)
    lineR:setAnchorPoint(0, 0)
    lineR:setPosition(startX + 20 + lineWidth + rewardTip:getContentSize().width, 92)
    rightLayer:addChild(lineR, 10)
    self.rewardTip = rewardTip
    self.lineL = lineL
    self.lineR = lineR

    local imageBg = cc.Scale9Sprite:createWithSpriteFrameName("ui_selectfloor_map_bigpaper.png")
    imageBg:setContentSize(rightLayer:getContentSize().width, rightLayer:getContentSize().height)
    imageBg:setAnchorPoint(0, 0)
    imageBg:setPosition(0, 0)
    self.rightLayer:addChild(imageBg)

    local rewardCapR = UI.Image:create()
    rewardCapR:init("ui_selectfloor_map_gradually_1.png")
    rewardCapR:rightBottom(347, 0)
    rightLayer:addChild(rewardCapR, 10)
    self.rewardCapR = rewardCapR

    -- 创建背景
    local picBg = UI.Image:create()
    picBg:init("ui_selectfloor_map_gradually_2.png")
    picBg:leftUp(0, 0)
    self.rightLayer:addChild(picBg, 20)

    local picBg = UI.Image:create()
    picBg:init("ui_selectfloor_map_gradually_2.png")
    picBg:rightUp(0, 0)
    picBg:setScaleX(-1)
    self.rightLayer:addChild(picBg, 20)

    local _ckipperSprite = cc.LayerColor:create(cc.c4b(0, 0, 0, 200))
    _ckipperSprite:setContentSize(ScrollViewSize.width, ScrollViewSize.height)
    local clipper = cc.ClippingNode:create(_ckipperSprite)
    clipper:setPosition(0, (self.rightLayer:getContentSize().height - ScrollViewSize.height) / 2 + 50)
    clipper:setAlphaThreshold(1.0)
    self.rightLayer:addChild(clipper, 10)
    self.floatCloudCliper = clipper

    -- self:refreshFloatCloud(true, nil)

    -- 处理探险按钮
    local quickLayout = UI.Layout:create()
    quickLayout:init()
    quickLayout:rightBottom(280, 83)
    self.rightLayer:addChild(quickLayout, 100)

    local quickBg = UI.Image:create()
    quickBg:init("ui_explore_licence_banner.png")
    quickBg:center()
    quickLayout:addChild(quickBg, 100)
    self.quickBg = quickBg

    local quickImage = UI.Image:create()
    quickImage:init("symbol_gaming_licence.png")
    quickImage:center(-24, 0)
    quickBg:add(quickImage)
    self.quickImage = quickImage

    local quickTipText = UI.Text:create()
    quickTipText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    quickTipText:centerLeft(44)
    quickBg:addChild(quickTipText)
    self.quickTipText = quickTipText

    -- 按钮
    local languageType = LanguageManager:getInstance():getLanguage()
    local btnFontSize = UI.FONT_SIZE_20PX
    if (languageType == cc.LANGUAGE_RUSSIAN) then
        btnFontSize = UI.FONT_SIZE_14PX
    elseif (languageType == cc.LANGUAGE_ENGLISH) then
        btnFontSize = UI.FONT_SIZE_18PX
    end

    local masterData = RoleDataManager:getMaster()
    local quickText = UI.TEXT_1212573
    local curTimes = mvc.expeditionModel:getQuickExpeditionNum()
    if masterData:getIsReincarntion() and curTimes > 0 then
        local reincarntionLv = masterData:getReincarntionLv()
        local config = ConfigManager:getAllRoleReincarnationDataByID(reincarntionLv)
        local maxExpeditionNum = config.maxExpeditionNum
        local showNum = (maxExpeditionNum - curTimes + 1) >= 0 and (maxExpeditionNum - curTimes + 1) or 0
        quickText = quickText..string.format(UI.TEXT_224312, showNum)
    end
    local quickBtn = UI.Button:create()
    quickBtn:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    self.rightLayer:addChild(quickBtn, 100)
    quickBtn:setTextFont(UI.FONT_STANDARD, btnFontSize, UI.FONT_COLOR_50_50_54)
    quickBtn:setText(quickText)
    quickBtn:rightBottom(200, 18)
    self.quickBtn = quickBtn
    quickBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onQuickExpedition)

    local quickBtnImage = UI.Image:create()
    quickBtnImage:init("ui_explore_hourglass_0.png")
    quickBtnImage:centerLeft(-quickBtnImage:getContentSize().width - 4)
    quickBtn._text:addChild(quickBtnImage)
    self.quickBtnImage = quickBtnImage

    local normalBtn = UI.Button:create()
    normalBtn:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    normalBtn:rightBottom(32, 18)
    self.rightLayer:addChild(normalBtn, 100)
    normalBtn:setTextFont(UI.FONT_STANDARD, btnFontSize, UI.FONT_COLOR_50_50_54)
    normalBtn:setText(UI.TEXT_1212615)
    self.normalBtn = normalBtn
    normalBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onNormalExpedition)

    -- 切换模式
    -- 背景
    local choiceBg = UI.Image:create()
    choiceBg:init("ui_explore_paper.png")
    choiceBg:rightUp(0, 0)
    self.rightLayer:addChild(choiceBg, 100)
    self.choiceBg = choiceBg
end

function ExpeditionView:refreshCaveBtn(caveMode)
    -- self.heroChoiceBtn = heroAni
    self.data.caveMode = caveMode
    if self.choiceBtn then
        self.choiceBtn:removeFromParent()
    end
    local ani = {}
    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
        ani = {"effect_ui_town_expedition_ordinary_icon.json", "effect_ui_town_expedition_ordinary_icon.atlas"}
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        ani = { "effect_ui_town_expedition_hero_icon.json", "effect_ui_town_expedition_hero_icon.atlas"}
    elseif PublicDefine.CAVE_MODE.MODE_DESERT_EYES == self.data.caveMode then
        ani = { "effect_ui_town_expedition_desert_icon.json", "effect_ui_town_expedition_desert_icon.atlas"}
    elseif PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE == self.data.caveMode then
        ani = { "effect_ui_town_expedition_distortedspace_icon.json", "effect_ui_town_expedition_distortedspace_icon.atlas"}
    elseif PublicDefine.CAVE_MODE.MODE_INFERNO == self.data.caveMode then
        ani = { "effect_ui_town_expedition_inferno_icon.json", "effect_ui_town_expedition_inferno_icon.atlas"}
    elseif PublicDefine.CAVE_MODE.MODE_VOID_RIFT == self.data.caveMode then
        ani = { "effect_ui_town_expedition_sky_icon.json", "effect_ui_town_expedition_sky_icon.atlas"}
    elseif PublicDefine.CAVE_MODE.MODE_VIKING == self.data.caveMode then
        ani = { "effect_ui_town_expedition_reincarnation_icon.json", "effect_ui_town_expedition_reincarnation_icon.atlas"}
    elseif PublicDefine.CAVE_MODE.MODE_TITAN_ROAD == self.data.caveMode then
        ani = {"effect_ui_town_expedition_titans_icon.json", "effect_ui_town_expedition_titans_icon.atlas"}
    elseif PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO == self.data.caveMode then
        ani = { "effect_ui_town_expedition_hero_icon.json", "effect_ui_town_expedition_hero_icon.atlas"}
    elseif PublicDefine.CAVE_MODE.MODE_DRIED_SPRING == self.data.caveMode then
        ani = { "effect_ui_town_expedition_dryspring_icon.json", "effect_ui_town_expedition_dryspring_icon.atlas"}
    elseif PublicDefine.CAVE_MODE.MODE_CHAOS == self.data.caveMode then
        ani = { "effect_ui_town_expedition_chaos_icon.json", "effect_ui_town_expedition_chaos_icon.atlas"}
    end
    
    local normalAni = UI.Animation:create()
    normalAni:init(ani[1],ani[2], 1)
    normalAni:setSize(100, 100)
    normalAni:setAnimation("idle1", true)
    normalAni:rightUp(8, 8)
    normalAni:setClickAudioEnable(true)
    self.choiceBg:addChild(normalAni)
    normalAni:setTouchEnable(true)
    self.choiceBtn = normalAni
    normalAni:addEventListener(
        UIEvent.COMPONENT_CLICK,
        self,
        function()
            mvc.send(mvc.events.Expedition_Show_Select_View, self.data.caveMode)
        end
    )
    self:refreshCaveMode(true)
    self.choiceBtn:setAnimation("begin", false)
    self.choiceBtn:addAnimation("idle1", true)
end

-- 模版函数：更新组建的视图
function ExpeditionView:onUpdateView()
    ExpeditionView.super.onUpdateView(self)
    if self.selectedIcon then
        self:showRewardLayer()
    end
    self:refreshCaveMode(false)
    self:refreshSelectMode()
    self:refreshBagStatus()
    self:refreshUpOrExpeditionStatus()
    self:playRoleExpedition(true)
    self:refreshMonthCardStatus()
    if (mvc.expeditionModel:getExpeditionStatus()) then
        self:playNormalExpedition()
    else
        self:playIdleExpedition()
    end

    local unLockHeroMode =
        RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    if unLockHeroMode and not MasterDataManager:isInitHeroCaveData() then
        Net.NetRoleSystem:getAllHeroSpecialEventRequest()
    end

    local unLockTitanHeroMode =
        RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero)
    if unLockTitanHeroMode and not MasterDataManager:isInitTitanHeroCaveData() then
        Net.NetRoleSystem:getAllHeroSpecialEventRequest()
    end
end

function ExpeditionView:handleBtnAnimation(quickBtn, animation, isUp)
    local pre = "up_"
    if (not isUp) then
        pre = "down_"
    end
    quickBtn:closeClickScale()
    quickBtn.animation = animation

    quickBtn:addEventListener(
        UI.Event.COMPONENT_TOUCH_BEGAN,
        quickBtn,
        function()
            -- print("btmn COMPONENT_TOUCH_BEGAN", pre)
            animation:setAnimation(pre .. "trigger_begin", false)
            animation:addAnimation(pre .. "trigger_idle", true)
        end
    )
    quickBtn:addEventListener(
        UI.Event.COMPONENT_TOUCH_ENDED,
        quickBtn,
        function()
            animation:setAnimation(pre .. "trigger_end", false)
            animation:setAnimation(pre .. "idle", true)
        end
    )
    quickBtn:addEventListener(
        UI.Event.BUTTON_ENABLE,
        quickBtn,
        function()
            animation:setAnimation(pre .. "idle", true)
            animation:setTimeScale(1)
            animation:setVisible(true)
        end
    )
    quickBtn:addEventListener(
        UI.Event.BUTTON_DISABLE,
        quickBtn,
        function()
            animation:setAnimation(pre .. "idle", true)
            animation:setTimeScale(0)
            animation:setVisible(false)
        end
    )
end

function ExpeditionView:openShowAction(isOpen)
    -- print("ExpeditionView:openShowAction", isOpen)
    if isOpen then
        Avalon.AudioManager:playSound("1501")
        local offX = 30
        local time1 = 0.15 * 1
        local time2 = 0.1 * 1
        local leftLayerPosOffset = 35
        local xPos = Avalon.issUtil:getLeftEdgeXForNode(self.leftLayer) + leftLayerPosOffset
        local yPos = LayerSize.height / 2
        self.leftLayer._enableAutoUpdatePos = false
        self.leftLayer:setIgnoreAnchorPointForPosition(false)
        self.leftLayer:setAnchorPoint(0, 0.5)
        self.leftLayer:setPosition(-self.leftLayer._width - xPos, LayerSize.height / 2)
        local move1 = cc.EaseOut:create(cc.MoveTo:create(time1 - time1 / 10, cc.p(xPos + offX, yPos)), 1)
        local move2 = cc.EaseInOut:create(cc.MoveTo:create(time2, cc.p(xPos, yPos)), 7)
        self.leftLayer:runAction(cc.Sequence:create(move1, move2))

        local oldPosX2 = self.clipper:getPositionX()
        self.clipper:setPositionX(-self.rightLayer:getContentSize().width)
        local delatAct = cc.DelayTime:create(time1 / 10)
        local move1 =
            cc.EaseOut:create(cc.MoveTo:create(time1, cc.p(oldPosX2 + offX * 1.1, self.clipper:getPositionY())), 1)
        local move2 =
            cc.EaseIn:create(cc.MoveTo:create(time2, cc.p(oldPosX2 - offX * 0.8, self.clipper:getPositionY())), 1)
        local move3 = cc.EaseIn:create(cc.MoveTo:create(time2 * 0.8, cc.p(oldPosX2, self.clipper:getPositionY())), 1)
        self.clipper:runAction(cc.Sequence:create(delatAct, move1, move2, move3))

        local oldPosX3 = self.rightLayer:getPositionX()
        self.rightLayer:setPositionX(-self.rightLayer:getContentSize().width)
        local delatAct = cc.DelayTime:create(time1 / 10)
        local move1 =
            cc.EaseOut:create(cc.MoveTo:create(time1 * 0.9, cc.p(oldPosX3, self.rightLayer:getPositionY())), 1)
        -- local move2 = cc.EaseOut:create(cc.MoveTo:create(time2, cc.p(oldPosX3 + offX * 1.2, self.rightLayer:getPositionY())), 1)
        -- local move3 = cc.EaseIn:create(cc.MoveTo:create(time2, cc.p(oldPosX3, self.rightLayer:getPositionY())), 1)
        self.rightLayer:runAction(cc.Sequence:create(delatAct, move1))
    else
        Avalon.AudioManager:playSound("1502")
        self:runAction(
            cc.Sequence:create(
                cc.MoveTo:create(0.1, cc.p(-winSize.width, self:getPositionY())),
                cc.CallFunc:create(
                    function()
                        -- self:close()
                        Avalon.Scheduler:scheduleUpdateOnce(
                            self,
                            function()
                                mvc.send("Close_Panel", mvc.expeditionPanel.moduleName, mvc.expeditionPanel.panelName)
                            end,
                            0.01
                        )
                    end
                )
            )
        )
    end
end

function ExpeditionView:update(dt)
    self:refreshBagStatus()

    if (self.bagView == nil or tolua.isnull(self.bagView)) then
        self:bagClose()
    end

    if self.countDownTitleText then
        local targetTime = mvc.expeditionModel:getExpeditionTime()
        local showText = nil

        if targetTime > 0 then
            -- print("ExpeditionView:update targetTime =", targetTime)
            showText = AvalonUtil:_getFullFormatTime(targetTime, true, true, false)
        end

        if showText == nil then
            -- self.countDownDesText:setVisible(false)
            self.countDownDesText:setText(string.format("%s", "00:00"))
            self.countDownTitleText:setText(UI.TEXT_1212585)
            self.countDownTitleText:leftUp(101 - self.countDownTitleText:getContentSize().width / 2, 8)
        else
            if (not mvc.expeditionModel:getExpeditionStatus()) then
                self.countDownTitleText:setText(UI.TEXT_1212585)
            else
                self.countDownTitleText:setText(UI.TEXT_1212576)
            end
            self.countDownTitleText:leftUp(101 - self.countDownTitleText:getContentSize().width / 2, 8)
            self.countDownTitleText:setVisible(true)
            self.countDownDesText:setVisible(true)
            self.countDownDesText:setText(string.format("%s", showText))
        end
        self.countDownDesText:leftUp(101 - self.countDownDesText:getContentSize().width / 2, 30)
    end
    local isSuccess = MasterDataManager:checkRefreshCountAndTime()
    if isSuccess then
        self:refreshItemButton()
    end
end

function ExpeditionView:refreshFloatCloud(isShowEnter, callback)
    if not isShowEnter then
        callback()
        return
    end
    -- print("ExpeditionView:refreshFloatCloud(", isShowEnter)
    if self.floatCloud == nil then
        local floatCloud = UI.Animation:create()
        floatCloud:init("effect_ui_town_stageselect_cloud.json", "effect_ui_town_stageselect_cloud.atlas", 1)
        floatCloud:setSize(ScrollViewSize.width, ScrollViewSize.height)
        floatCloud:leftBottom(0, 10)
        self.floatCloudCliper:addChild(floatCloud, 15)
        self.floatCloud = floatCloud
        -- floatCloud:enableDebugDraw()
        self.lockAllBtn = true
        floatCloud:addEventListener(
            UIEvent.ANIMATION_COMPLETE,
            self,
            function(sender, event)
                if event.animation == "stageselect_open" then
                    self.floatCloud:destroy()
                    self.floatCloud = nil
                    self.lockAllBtn = false
                elseif event.animation == "stageselect_close" then
                    self.floatCloud:setAnimation("stageselect_open", false)
                    self:refreshItemButton()
                    self.isFloatCloudAct = false
                    if callback then
                        callback()
                    end
                end
            end
        )
    end
    self.floatCloud:setAnimation("stageselect_close", false)
    self.isFloatCloudAct = true
end

function ExpeditionView:autoFixCurBtn(posX, posY)
    if posX == nil or posY == nil then
        return
    end
    local scrollView = self._scrollView
    local layout = self._layout

    if (not tolua.isnull(scrollView)) then
        local halfViewWidth = scrollView:getContentSize().width / 2
        if posX < halfViewWidth then
            return
        end
        posX = posX - halfViewWidth
        scrollView:scrollToPercentHorizontal(
            posX / (layout:getContentSize().width - scrollView:getContentSize().width) * 100
        )
    end
end

function ExpeditionView:createOneEventInfo(data)
    local text = UI.Text:create()
    text:init(data.name .. ":" .. data.description, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
    text:centerLeft(43)
    text:setWidth(305)
    text:setTextLeftUp()
    -- text:enableDebugDraw(UI.RED)
    text:autoAdapt()

    local layout = UI.Layout:create()
    layout:init()
    local height = text:getContentSize().height
    height = height < 40 and 40 or height
    layout:setSize(350, height + 6)
    layout:addChild(text)

    local icon = UI.Image:create()
    icon:init(data.icon)
    if height < 40 then
        icon:centerLeft(2)
    else
        icon:leftUp(2, 7)
    end
    layout:addChild(icon)
    -- layout:enableDebugDraw()
    return layout
end

function ExpeditionView:onScrollViewScrollingCallback()
end

function ExpeditionView:refreshItemButton()
    -- local itemUsedCount = MasterDataManager:getHeroCaveRefreshCountUsedCount() + 1
    -- local itemCostList = string.split(ConfigManager:getGeneralForKey("manualSpecialEventRefreshCostGoodsNum"), ";")
    -- local showNumber = tonumber(itemCostList[itemUsedCount] or itemCostList[1])
    -- local itemIcon = self.mBtnRefresh:getChildByName("ItemIcon")
    -- local itemCost = itemIcon:getChildByName("ItemCost")
    -- if showNumber then
    --     if(itemIcon) then
    --         itemIcon:show()
    --     end
    --     if(itemCost) then
    --         itemCost:setText(string.format("%d", showNumber))
    --     end
    --     self.mBtnRefresh._text:centerLeft(10)
    -- end
    -- --道具不足显示红色
    -- local itemId = tonumber(ConfigManager:getGeneralForKey("manualSpecialEventRefreshCostGoodsID"))
    -- local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(itemId, true)
    -- --次数不足显示灰色--且具中
    -- if itemUsedCount > #itemCostList then
    --     self.mBtnRefresh:disable()
    --     itemCost:hide()
    --     if(itemIcon) then
    --         itemIcon:hide()
    --     end
    --     self.mBtnRefresh._text:center()
    -- else
    --     self.mBtnRefresh:enable()
    --     itemCost:show()
    --     self.mBtnRefresh._text:centerLeft(10)
    --     if showNumber > goodNumber then
    --         if(itemCost) then
    --             itemCost:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    --         end
    --     else
    --         if(itemCost) then
    --             itemCost:setFontColor(UI.FONT_COLOR_50_50_44)
    --         end
    --     end
    -- end
end

function ExpeditionView:refreshSpecialEventIcon()
    if self.caveEnterLayer then
        self.caveEnterLayer:hiddenLayer()
    end
    UI.WaitingLayer:hideWaiting()

    self:refreshItemButton()
    --特殊事件
    
    local heroPlotList = ConfigManager:getAllLevelSelectDataByType(self.data.caveMode)--(PublicDefine.CAVE_MODE.MODE_HERO)
    self:showRewardLayer()
end

--创建关卡数据
function ExpeditionView:createLevelBtns()
    if not self._scrollView then
        return
    end
    local clickCallback = function(sender, _, touchPosition)
        local spineIcon = sender
        -- print("spineIcon:setClickCallback(handler(spineIcon", self.lockAllBtn, self.mBClick, spineIcon.state, self.isFloatCloudAct)
        if
            self.lockAllBtn == false and self.mBClick == true and spineIcon.state == SpineIconStatus.haveUnLocked and
                not self.isFloatCloudAct and
                self.rightLayer:checkTouch(touchPosition)
         then
            if self.selectedIcon ~= nil then
                self.selectedIcon:unLocked()
            end
            -- print("spineIcon:setClickCallback 2")
            spineIcon:selected()
            self.selectedIcon = spineIcon
            self:showRewardLayer()
            self:refreshUpOrExpeditionStatus()
            if(self.initPlayRole ~= true) then 
                self:playRoleExpedition(true)
            end
        end
    end

    local animStartCallback =
        handler(
        self,
        function(sender, event, obj)
            if event.animation == "showup" then
                if self.curCaveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
                    Avalon.AudioManager:playSoundDelay("1520", 350)
                end
            end
        end
    )

    -- print("createLevelBtns =", self.data.oldOpenLevel, self.data.curOpenLevel)
    ExpeditionView.super.createLevelBtns(
        self,
        self.data.oldOpenLevel,
        self.data.curOpenLevel,
        self._scrollView,
        self._layout,
        clickCallback,
        animEndCallback,
        animStartCallback,
        self.data.normalChoiceLevel
    )
    self:refreshUpOrExpeditionStatus()
end

function ExpeditionView:refreshUpOrExpeditionStatus()
    if (not tolua.isnull(self.warflag)) then
        self.warflag:removeFromParent()
        self.warflag = nil
    end

    if (not tolua.isnull(self.upLayout)) then
        self.upLayout:removeFromParent()
        self.upLayout = nil
    end
    
    -- 找到对应的节点
    local warNode = nil
    local speedNode = nil
    local expeditionStatus = mvc.expeditionModel:getExpeditionStatus()
    local expeditionLevel = ToolsUtil:getCaveLevelForShopLevel(mvc.expeditionModel:getExpeditionLevel())
    local speedLevel = ToolsUtil:getCaveLevelForShopLevel(mvc.expeditionModel:getSpeedLevel())
    -- print("refreshUpOrExpeditionStatus MODE_HERO  ddd", self.data.caveMode, expeditionStatus, #self.levelBtnList)
    for k, node in pairs(self.levelBtnList) do
        -- print("refreshUpOrExpeditionStatus", node:getTag(), mvc.expeditionModel:getSpeedLevel(), mvc.expeditionModel:getExpeditionLevel())
        if expeditionStatus and self.curCaveMode == mvc.expeditionModel:getExpeditionMode()
            and node:getTag() == expeditionLevel then
            warNode = node
        end
        -- if self.XXXXXXXXXXXXXXXX
        -- print("refreshUpOrExpeditionStatus MODE_HERO 2", self.data.caveMode, PublicDefine.CAVE_MODE.MODE_HERO)
        if (self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO) then
            -- print("refreshUpOrExpeditionStatus MODE_HERO", node:getTag(), speedLevel)
            if node:getTag() == speedLevel then
                speedNode = node
            end
        elseif (self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then
            if node:getTag() == speedLevel then
                speedNode = node
            end
        end
    end

    if (warNode) then
        local warflagAnimation = UI.Animation:create()
        warflagAnimation:init(
            "effect_ui_town_expedition_stageselect_hero_flag.json",
            "effect_ui_town_expedition_stageselect_hero_flag.atlas"
        )
        warflagAnimation:setInnerOffset(-2, -2)
        warflagAnimation:rightBottom(-10, 15)
        warflagAnimation:setAnimation("idle", true)
        warNode:addChild(warflagAnimation)

        self.warflag = warflagAnimation
    end

    -- 增益效果
    -- print("ExpeditionView:refreshUpOrExpeditionStatus 1")
    if (speedNode) then
        -- print("ExpeditionView:refreshUpOrExpeditionStatus 2")
        local upLayout = UI.Layout:create()
        upLayout:init()
        -- upLayout:setSize(26, 26)
        upLayout:centerBottom(-5)
        speedNode:addChild(upLayout, 100)

        -- 添加底板
        local buffBg = UI.Image:create()
        buffBg:init("ui_explore_buffbg.png")
        buffBg:centerLeft(-6 - buffBg:getContentSize().width / 2)
        upLayout:addChild(buffBg)

        local gateConfig, index =
            self:getGateConfig(mvc.expeditionModel:getSpeedMode(), ToolsUtil:getCaveLevelForShopLevel(mvc.expeditionModel:getSpeedLevel()))
        local name = ""
        if (gateConfig) then
            name = gateConfig.name
        end
        local attr = ""

        local expeditionID =
            mvc.expeditionModel:calculationExpeditionID(
            mvc.expeditionModel:getSpeedMode(),
            mvc.expeditionModel:getSpeedLevel()
        )
        local expeditionData = mvc.expeditionModel:getExpeditionConfigData(mvc.expeditionModel:getSpeedMode(), mvc.expeditionModel:getSpeedLevel())
        local upPercent = 0
        if
            (mvc.expeditionModel:getSpeedType() ==
                ProtobufUtil:enum_id("NPCSystem.ExpeditionSpeedType", "ExpeditionSpeedType_coin"))
         then
            -- symbol_gaming_money.png
            if (expeditionData) then
                upPercent = tonumber(expeditionData.goldcoinratio) / RATIO_NUMBER
            end

            attr = LanguageManager:getInstance():getLocalString(1110725)
            local moneyImage = UI.Image:create()
            moneyImage:init("symbol_gaming_money.png")
            moneyImage:setScale(0.92)
            upLayout:addChild(moneyImage)

            local upImage = UI.Image:create()
            upImage:init("ui_explore_arrow.png")
            upLayout:addChild(upImage)
            -- upImage:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.5,cc.p(0,10)),cc.MoveBy:create(0.5,cc.p(0,-10)))))

            local startX =
                upLayout:getContentSize().width / 2 -
                (moneyImage:getContentSize().width + 2 + upImage:getContentSize().width) / 2
            moneyImage:centerLeft(startX)
            upImage:centerLeft(startX + 2 + moneyImage:getContentSize().width)
        elseif
            (mvc.expeditionModel:getSpeedType() ==
                ProtobufUtil:enum_id("NPCSystem.ExpeditionSpeedType", "ExpeditionSpeedType_exp"))
         then
            if (expeditionData) then
                upPercent = tonumber(expeditionData.expcoinratio) / RATIO_NUMBER
            end

            attr = LanguageManager:getInstance():getLocalString(1111852)
            local moneyImage = UI.Image:create()
            moneyImage:init("symbol_gaming_xp.png")
            moneyImage:setScale(0.92)
            upLayout:addChild(moneyImage)

            local upImage = UI.Image:create()
            upImage:init("ui_explore_arrow.png")
            upLayout:addChild(upImage)
            -- upImage:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.MoveBy:create(0.5,cc.p(0,10)),cc.MoveBy:create(0.5,cc.p(0,-10)))))

            local startX =
                upLayout:getContentSize().width / 2 -
                (moneyImage:getContentSize().width + 2 + upImage:getContentSize().width) / 2
            moneyImage:centerLeft(startX)
            upImage:centerLeft(startX + 2 + moneyImage:getContentSize().width)
        end
        buffBg:setTouchEnable(true)
        self._detailStr = string.format(UI.TEXT_1212593, name, attr .. (upPercent * 100) .. "%")
        buffBg:addEventListener(
            UIEvent.COMPONENT_TOUCH_BEGAN,
            self,
            function()
                self:showDetailInfo(buffBg, self._detailStr)
            end
        )
        buffBg:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.hideDetailInfo)

        self.upLayout = upLayout
    end
end

function ExpeditionView:bagHaveGoods()
    local master = RoleDataManager:getMaster()
    if GoodsDataManager:getHaveGoodsForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then
        return true
    end

    if GoodsDataManager:getHaveGoodsForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then
        return true
    end

    return false
end

function ExpeditionView:onNormalExpedition()
    if(self.selectedIcon == nil) then 
        return
    end

    -- Avalon.AudioManager:playSound("1503")
    if (AvalonUtil.getCurrentTime() - self.preClickTime < 5000) then
        UI.ScrollBar:createByText(UI.TEXT_1170412)
        return
    end

    -- if TeamDataManager:getReadyState() or TeamDataManager:getIsMatching() or TeamDataManager:hasTeam() then
    --     UI.ScrollBar:createByText(UI.TEXT_1212055)
    --     return
    -- end

    -- if (mvc.expeditionModel:getExpeditionStatus()) then
    --     mvc.send(mvc.events.Expedition_Stop_Norml)
    --     self.preClickTime = AvalonUtil.getCurrentTime()
    -- else
    --     local master = RoleDataManager:getMaster()
    --     if GoodsDataManager:getHaveGoodsForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) 
    --         or mvc.expeditionModel:getNormalCoin() > 0 
    --         or mvc.expeditionModel:getNormalExp() > 0 
    --     then
    --         UI.ScrollBar:createByText(string.format(UI.TEXT_1212588, UI.TEXT_1212577))
    --         return
    --     end

    --     local data = {}
    --     data.model = self.data.caveMode
    --     data.level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())

    --     mvc.send(mvc.events.Expedition_Start_Norml, data)
    --     self.preClickTime = AvalonUtil.getCurrentTime()
    -- end

    Net.NetNPCSystem:reqUpdateExpeditionLV(self.data.caveMode, LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag()))
    self.preClickTime = AvalonUtil.getCurrentTime()
end

function ExpeditionView:onCardClick()
    if ServerConfigUtil:isInReview() then
        return
    end

    if (not mvc.expeditionModel:getHaveMonthDay()) then
        local cardTips =
            UI.ConfirmDialog.show(
            "",
            function()
                -- 触发成功回城提示
                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, false, 3, nil, 
                    PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_MiniMap)
            end,
            function()
            end
        )

        local offsetAllY = 26
        local title = UI.Text:create()
        title:init(
            string.format(UI.TEXT_1212606, UI.TEXT_1212004),
            UI.FONT_STANDARD,
            UI.FONT_SIZE_18PX,
            UI.FONT_COLOR_41_41_45
        )
        title:centerUp(offsetAllY)
        title:setWidth(350)
        title:setTextCenter()
        cardTips.ConfirmDialogModel.contentBg:addChild(title, 10)
        offsetAllY = offsetAllY + title:getContentSize().height + 4

        local monthCardLayout = UI.Layout:create()
        monthCardLayout:init()
        monthCardLayout:centerUp(offsetAllY)
        monthCardLayout:setSize(201, 0)
        cardTips.ConfirmDialogModel.contentBg:addChild(monthCardLayout)

        local expeditionCoinincome = ConfigManager:getGeneralForKey("ExpeditionCoinincome")
        local rewardArr = string.split(expeditionCoinincome, ";")

        local startX = 70
        local offsetY = 0
        if (rewardArr and #rewardArr) then
            local image = UI.Image:create()
            image:init("symbol_gaming_money.png")
            image:leftUp(startX, offsetY)
            monthCardLayout:addChild(image)
            startX = startX + image:getContentSize().width + 4

            local info = UI.Text:create()
            info:init(
                string.format("+%s", string.format("%.1f", (tonumber(rewardArr[1]) * 100) / RATIO_NUMBER) .. "%"),
                UI.FONT_STANDARD,
                UI.FONT_SIZE_18PX,
                UI.FONT_COLOR_15_85_71
            )
            info:centerLeft(-info:getContentSize().width - 4)
            image:addChild(info)
            startX = startX + info:getContentSize().width + 20

            local image = UI.Image:create()
            image:init("symbol_gaming_xp.png")
            image:leftUp(startX, offsetY)
            monthCardLayout:addChild(image)
            startX = startX + image:getContentSize().width + 4

            local info = UI.Text:create()
            info:init(
                string.format("+%s", string.format("%.1f", (tonumber(rewardArr[2]) * 100) / RATIO_NUMBER) .. "%"),
                UI.FONT_STANDARD,
                UI.FONT_SIZE_18PX,
                UI.FONT_COLOR_15_85_71
            )
            info:centerLeft(-info:getContentSize().width - 4)
            image:addChild(info)

            offsetAllY = offsetAllY + info:getContentSize().height + 4
        end

        local des = UI.Text:create()
        des:init(UI.TEXT_1212607, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        des:centerUp(offsetAllY)
        cardTips.ConfirmDialogModel.contentBg:addChild(des, 10)
    end
end

function ExpeditionView:onQuickExpedition()
    if(self.selectedIcon == nil) then 
        return
    end

    if (AvalonUtil.getCurrentTime() - self.preClickTime < 5000) then
        UI.ScrollBar:createByText(UI.TEXT_1170412)
        return
    end

    if TeamDataManager:getReadyState() or TeamDataManager:getIsMatching() or TeamDataManager:hasTeam() then
        UI.ScrollBar:createByText(UI.TEXT_1212055)
        return
    end

    local masterData = RoleDataManager:getMaster()
    if masterData:getIsReincarntion() then
        local reincarntionLv = masterData:getReincarntionLv()
        local config = ConfigManager:getAllRoleReincarnationDataByID(reincarntionLv)
        local maxExpeditionNum = config.maxExpeditionNum
        local curTimes = mvc.expeditionModel:getQuickExpeditionNum()
        if curTimes >= maxExpeditionNum+1 then
            UI.ScrollBar:createByText(UI.TEXT_224313)
            return
        end
    end

    -- self:playQuickExpedition()
    -- Avalon.AudioManager:playSound("1503")
    local master = RoleDataManager:getMaster()
    if GoodsDataManager:getHaveGoodsForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK)
        or mvc.expeditionModel:getQuickCoin() > 0 
        or mvc.expeditionModel:getQuickExp() > 0 
    then
        UI.ScrollBar:createByText(string.format(UI.TEXT_1212588, UI.TEXT_1212578))
        return
    end

    -- 第一次免费
    local curTimes = mvc.expeditionModel:getQuickExpeditionNum()
    if not curTimes or curTimes == 0 then
        self:_handleTipsQuick(1)
        return
    end

    local pk = RoleDataManager:getMaster():getPK()
    local licenceTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, CARD_ID)
    local licenceData = GoodsDataManager:getGoodsDataForGoodsIDAndIsGolden(
        pk,
        PublicDefine.PACKET_TYPE.PACKET_BAG, 
        GoodsDataManager:getGoodsTypeForGoodsID(CARD_ID), 
        CARD_ID,
        false
    )

    if licenceData and licenceData:getIsLock() then
        UI.ScrollBar:createByText(UI.TEXT_1212614)
        return
    elseif tonumber(licenceTotalNum) == 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212612)
        return
    elseif tonumber(licenceTotalNum) == 1 then
        self:_handleTipsQuick(1)
    else
        require "app.modules.expedition.ExpeditionAddCardsLayer"
        local expeditionAddCardsLayer = UI.ExpeditionAddCardsLayer:show(function (num)
            self:_handleTipsQuick(num)
        end)
        self.rootLayer:addChild(expeditionAddCardsLayer, 300)
    end
end

function ExpeditionView:_handleTipsQuick(totalNum)
    local cardTips =
        UI.ConfirmDialog.show(
        "",
        function()
            local data = {}
            data.totalNum = totalNum
            data.model = self.data.caveMode
            data.level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
            mvc.send(mvc.events.Expedition_Start_Quick, data)
            self.preClickTime = AvalonUtil.getCurrentTime()
        end,
        function()
        end
    )

    local des = LanguageManager:getInstance():getLocalString(1112334)
    local levelStr = self.choiceLevelText:getText()
    local protocolName =
        AvalonUtil:serializeText(
        levelStr,
        AvalonUtil:colorRGB2Str(UI.FONT_COLOR_15_85_71),
        UI.FONT_SIZE_18PX,
        UI.FONT_STANDARD
    )
    local content =
        AvalonUtil:formartRichText(UI.FONT_COLOR_41_41_45, UI.FONT_SIZE_18PX, UI.FONT_STANDARD, des, protocolName)
    local bottomRichText = UI.RichText:create()
    local success = bottomRichText:init(content, 350, 20, true)
    bottomRichText:center()
    cardTips.ConfirmDialogModel.contentBg:addChild(bottomRichText, 10)

    local str = LanguageManager:getInstance():getLocalString(1112333)
    local title = UI.Text:create()
    -- add by zp 这里每一次快速探险都是2个小时
    title:init(string.format(str, totalNum * 2), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    title:centerUp(0)
    title:setWidth(350)
    title:setTextCenter()
    cardTips.ConfirmDialogModel.contentBg:addChild(title, 10)

    local startY =
        (cardTips.ConfirmDialogModel.contentBg:getContentSize().height - bottomRichText:getContentSize().height -
        title:getContentSize().height) /
        2
    bottomRichText:centerUp(startY)
    title:centerUp(startY + bottomRichText:getContentSize().height + 13)

    local curTimes = mvc.expeditionModel:getQuickExpeditionNum()
    if curTimes and curTimes > 0 then
        local useItemIcon = UI.Image:create()
        useItemIcon:init("symbol_gaming_licence.png")
        useItemIcon:rightBottom(110, 80)
        cardTips.ConfirmDialogModel.ConfirmDialog:addChild(useItemIcon)

        local costLabelNum = UI.Text:create()
        costLabelNum:init(totalNum .. "", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        costLabelNum:centerLeft(26)
        useItemIcon:addChild(costLabelNum)
    end
end

function ExpeditionView:onChangeDetailOrSelect()
    if(self._nowShowType == SHOW_VIEW_TYPE.SHOW_VIEW_TYPE_DETAIL) then 
        self:showLevelSelectView()
    else 
        self:showDetailView()
    end
end

function ExpeditionView:showDetailView()
    self._nowShowType = SHOW_VIEW_TYPE.SHOW_VIEW_TYPE_DETAIL
    self.rightDetailLayer:setVisible(true)
    self.rightLayer:setVisible(false)
    self.rightLayer:leftBottom(-10000, 0)
    self.rightDetailLayer:leftBottom(323, 0)
    self:updateNearDataAndView()
end

function ExpeditionView:showLevelSelectView()
    self._nowShowType = SHOW_VIEW_TYPE.SHOW_VIEW_TYPE_SELECT
    self.rightDetailLayer:setVisible(false)
    self.rightLayer:setVisible(true)

    self.rightLayer:leftBottom(0, 0)
    self.rightDetailLayer:leftBottom(-10000, 0)
end

function ExpeditionView:onOpenNormalBag()
    -- Avalon.AudioManager:playSound("1503")
    if (not tolua.isnull(self.bagView)) then
        self.bagView:removeFromParent()
        self.bagView = nil
    end

    self.ordinaryBagBtn:setBtnStatus(ButtonState.ACTIVE)
    if (not self.fastBagBtn:isDisable()) then
        self.fastBagBtn:setBtnStatus(ButtonState.NORMAL)
    end

    local data = mvc.expeditionModel:getGoodsArrForBag(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL)
    -- reload_script_file_mvc("app.modules.expedition.ExpeditionBagView")
    local expeditionBagView = require("app.modules.expedition.ExpeditionBagView")
    self.bagView = expeditionBagView:create()
    self.bagView:init(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL, data)
    self.bagView:rightUp(20, -28)
    self:addChild(self.bagView, 1000)
end

function ExpeditionView:onOpenFastBag()
    -- Avalon.AudioManager:playSound("1503")
    if (not tolua.isnull(self.bagView)) then
        self.bagView:removeFromParent()
        self.bagView = nil
    end
    if (not self.ordinaryBagBtn:isDisable()) then
        self.ordinaryBagBtn:setBtnStatus(ButtonState.NORMAL)
    end
    self.fastBagBtn:setBtnStatus(ButtonState.ACTIVE)

    local data = mvc.expeditionModel:getGoodsArrForBag(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK)
    -- reload_script_file_mvc("app.modules.expedition.ExpeditionBagView")
    local expeditionBagView = require("app.modules.expedition.ExpeditionBagView")
    self.bagView = expeditionBagView:create()
    self.bagView:init(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK, data)
    self.bagView:rightUp(-10, -28)
    self:addChild(self.bagView, 1000)
end

function ExpeditionView:refreshSelectMode()
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave) then
        self.choiceBg:setVisible(true)
        if(self.choiceBtn) then 
            self.choiceBtn:setVisible(true)
        end
    else
        self.choiceBg:setVisible(false)
        if self.choiceBtn then 
            self.choiceBtn:setVisible(false)
        end
    end
end

function ExpeditionView:refreshBagStatus()
    local master = RoleDataManager:getMaster()
    if mvc.expeditionModel:getIsNotNullForPacketType(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then
        self.ordinaryBagBtn:enable()
        self.ordinaryBagStaus:setVisible(true)
    else
        self.ordinaryBagBtn:disable()
        self.ordinaryBagStaus:setVisible(false)
    end

    if mvc.expeditionModel:getIsNotNullForPacketType(PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then
        self.fastBagBtn:enable()
        self.fastBagStaus:setVisible(true)
    else
        self.fastBagBtn:disable()
        self.fastBagStaus:setVisible(false)
    end
end

--选择难度
function ExpeditionView:onSelectDifficulty(tag, sender)
    if self.lockAllBtn == false and self.mBClick == true and not self.mLockDiffSelect then
        --开启难度选择界面
        local pLevelSelectDifficulty =
            UI.LevelSelectDifficulty:create(
            function()
                local remainCount = self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO and MasterDataManager:getHeroCaveSchemeExploreCount() or MasterDataManager:getTitanHeroCaveSchemeExploreCount()
                self:refreshCaveMode(true)
                self:refreshTeamBtnState()
            end
        )
        pLevelSelectDifficulty:center()
        self:getParent():addChild(pLevelSelectDifficulty, UI_ZORDER.ACTIVITY)
        Game.FunctionUnlockManager:getInstance():removeNewFlag(
            PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave
        )
    end
end
function ExpeditionView:changeMap(mode)
    self.curCaveMode = mode

end


function ExpeditionView:refreshCaveMode(isShowEnter)
    if self.curCaveMode ~= nil and self.curCaveMode == self.data.caveMode then
        return
    end
    self.data.normalChoiceLevel = nil
    self.curCaveMode = self.data.caveMode
    local masterData = RoleDataManager:getMaster()
    local checkPointData = masterData:getCheckpointData(self.curCaveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    if(checkPointData and checkPointData:getCheckpoint() >= 2001) then 
        local maxNormalLevel = ToolsUtil:getExpeditionLevel(self.curCaveMode)
        -- print("cave normal=",self.curCaveMode,  maxNormalLevel)
        self.data.oldOpenLevel = ToolsUtil:getCaveLevelForShopLevel(maxNormalLevel)
        self.data.curOpenLevel = ToolsUtil:getCaveLevelForShopLevel(maxNormalLevel)

        if(mvc.expeditionModel:getExpeditionStatus() and self.curCaveMode == mvc.expeditionModel:getExpeditionMode()) then 
            self.data.normalChoiceLevel = ToolsUtil:getCaveLevelForShopLevel(mvc.expeditionModel:getExpeditionLevel())
        else 
            if self.curCaveMode == PublicDefine.CAVE_MODE.MODE_HERO
            or self.curCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                self.data.oldOpenLevel = ToolsUtil:getCaveLevelForShopLevel(2018)
                self.data.curOpenLevel = ToolsUtil:getCaveLevelForShopLevel(2018)
                self.data.normalChoiceLevel = ToolsUtil:getCaveLevelForShopLevel(mvc.expeditionModel:getSpeedLevel())
            end 
        end
    else 
        if self.curCaveMode == PublicDefine.CAVE_MODE.MODE_HERO 
        or self.curCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            self.data.oldOpenLevel = 2018
            self.data.curOpenLevel = 2018
            self.data.normalChoiceLevel = ToolsUtil:getCaveLevelForShopLevel(mvc.expeditionModel:getSpeedLevel())
        else
            self.data.oldOpenLevel = 0
            self.data.curOpenLevel = 0
        end
    end 
    --print("ExpeditionView:refreshCaveMode", self.curCaveMode, self.data.oldOpenLevel)
    -- print("ExpeditionView:refreshCaveMode", self.curCaveMode)
    self:refreshFloatCloud(
        isShowEnter,
        function()
            if self._scrollView then
                self._scrollView:removeFromParent()
            end
            self.stepPoint = {}
            self.levelBtnList = {}

            local layerMode = Game.LevelSelectLayerType.Normal_Plot
            if PublicDefine.CAVE_MODE.MODE_NORMAL == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.Normal_Plot
            elseif PublicDefine.CAVE_MODE.MODE_HERO == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.Hero_Plot
            elseif PublicDefine.CAVE_MODE.MODE_DESERT_EYES == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.Desert_Eye
            elseif PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.Distorted_Space
            elseif PublicDefine.CAVE_MODE.MODE_INFERNO == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.Inferno
            elseif PublicDefine.CAVE_MODE.MODE_VOID_RIFT == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.VoidRift
            elseif PublicDefine.CAVE_MODE.MODE_VIKING == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.ViKing
            elseif PublicDefine.CAVE_MODE.MODE_TITAN_ROAD == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.Titan_Road
            elseif PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.Titan_Road_Hero
            elseif PublicDefine.CAVE_MODE.MODE_DRIED_SPRING == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.Dried_Spring
            elseif PublicDefine.CAVE_MODE.MODE_CHAOS == self.curCaveMode then
                layerMode = Game.LevelSelectLayerType.Chaos_WormHole
            end
            self._scrollView, self._layout =
                self:createScrollView(layerMode, nil, nil, true)
            self.rightLayer:addChild(self._scrollView)
            self:createLevelBtns()
            self.selectedIcon = self.defaultNomalSelectIcon
            self:showRewardLayer()
            if(self.initPlayRole ~= true) then 
                self:playRoleExpedition(true)
            end

            local level = self.data.curOpenLevel
            if(self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO 
                or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then 
                level = self.data.normalChoiceLevel
            end
            --print("curOpenLevel = ", self.data.caveMode, level)
            local plotList = ConfigManager:getAllLevelSelectDataByType(self.data.caveMode)
            local found = false
            for k, v in pairs(plotList) do
                if (found) then
                    break
                end
                if table.nums(v.includeLevel) > 0 then
                    for k2, v2 in ipairs(v.includeLevel) do
                        if (tonumber(v2) == level) then
                            local posStr = v.coordinate[k2]
                            local posArray = string.split(posStr, ",")
                            self:autoFixCurBtn(tonumber(posArray[1]), tonumber(posArray[2]))
                            found = true
                            break
                        end
                    end
                end
            end
        end
    )
end

function ExpeditionView:hideDetailInfo(parent)
    if (tolua.isnull(parent)) then
        return
    end
    -- body
    -- print("ExpeditionView:hideFunctionInfo")
    parent:setScale(1)
    if (not tolua.isnull(self.infoPanel)) then
        self.infoPanel:removeFromParent()
        self.infoPanel = nil
    end
end

function ExpeditionView:showDetailInfo(parent, detailStr)
    if (tolua.isnull(parent)) then
        return
    end

    if self.infoPanel then
        self.infoPanel:removeFromParent()
    end
    self.infoPanel = UI.Layout:create()
    self.infoPanel:init()
    self.infoPanel:setSize(280, 50)
    self.infoPanel:center(0)
    -- self.leftLayer:addChild(self.infoPanel, 1000)
    UI.UIManager:addToRootNode(self.infoPanel, UI_ZORDER.TIPS)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_background1.png")
    bg:setCapInsets(CCRectMake(12, 12, 2, 2))
    bg:setAnchorPoint(0, 0)
    bg:setContentSize(cc.size(280, 50))
    bg:setPosition(0, 0)
    bg:setName("bg")
    self.infoPanel:addChild(bg)

    self.infoPanel:show()

    local height = 10
    local cellSpace = 5

    local textArr = {detailStr}

    for k, v in ipairs(textArr) do
        local cell = self:createOneCell(v, false)
        if cell then
            cell:leftUp(0, height)
            self.infoPanel:addChild(cell)
            height = height + cell:getContentSize().height + cellSpace
        end
    end
    -- 根据父节点处理显示位置
    local worldPos = parent:convertToWorldSpace(cc.size(0, 0))
    if height then
        local bg = self.infoPanel:getChildByName("bg")
        bg:setContentSize(280, height + 5)
        self.infoPanel:setSize(280, height + 5)
    end
    local offsetX = 20
    local offsetY = worldPos.y + parent:getContentSize().height / 2 - self.infoPanel:getContentSize().height / 2
    if worldPos.x < winSize.width / 2 then
        -- print("lefth ",worldPos.x + offsetX, offsetY)
        offsetX = 20 + parent:getContentSize().width
        self.infoPanel:leftBottom(worldPos.x + offsetX, offsetY)
    else
        -- print("right ",worldPos.x - offsetX - 280, offsetY)
        self.infoPanel:leftBottom(worldPos.x - offsetX - self.infoPanel:getContentSize().width, offsetY)
    end
end

function ExpeditionView:hideFunctionInfo(sender)
    -- body
    -- print("ExpeditionView:hideFunctionInfo")
    sender:setScale(1)
    if (not tolua.isnull(self.infoPanel)) then
        self.infoPanel:removeFromParent()
        self.infoPanel = nil
    end
end

function ExpeditionView:_showFunctionInfo(sender)
    sender:setScale(1.1)
    if self.infoPanel then
        self.infoPanel:removeFromParent()
    end
    self.infoPanel = UI.Layout:create()
    self.infoPanel:init()
    self.infoPanel:setSize(280, 50)
    self.infoPanel:center(0)
    self.leftLayer:addChild(self.infoPanel, 1000)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_information_banner_background1.png")
    bg:setCapInsets(CCRectMake(12, 12, 2, 2))
    bg:setAnchorPoint(0, 0)
    bg:setContentSize(cc.size(280, 50))
    bg:setPosition(0, 0)
    bg:setName("bg")
    self.infoPanel:addChild(bg)
    local direction = UI.Image:create()
    direction:init("ui_information_banner_background2.png")
    direction:setScaleX(-1)
    direction:leftUp(-direction:getContentSize().width + 1, 30)
    self.infoPanel:addChild(direction)

    self.infoPanel:show()

    local posUp = sender:getUp()
    local height = 10
    local cellSpace = 5

    local textArr = {1112051, 1112052, 1112053, 1112054}

    for k, v in ipairs(textArr) do
        local cell = self:createOneCell(LanguageManager:getInstance():getLocalString(v), false)
        if cell then
            cell:leftUp(0, height)
            self.infoPanel:addChild(cell)
            height = height + cell:getContentSize().height + cellSpace
        end
    end
    self.infoPanel:leftUp(315, -15)
    if height then
        local bg = self.infoPanel:getChildByName("bg")
        bg:setContentSize(280, height + 5)
        self.infoPanel:setSize(280, height + 5)
    end
end

function ExpeditionView:createOneCell(content, isRich)
    local success = false
    local _richText = nil
    local cell = nil
    if isRich then
        _richText = UI.RichText:create()
        success = _richText:init(content, 240, UI.FONT_SIZE_16PX)
    elseif content ~= "" then
        success = true
        _richText = UI.Text:create()
        _richText:init(content, UI.SYS_FONT, UI.FONT_SIZE_16PX)
        _richText:setTextLeft()
        _richText:setWidth(240)
        _richText:autoAdapt()
    end
    if success then
        cell = UI.Layout:create()
        cell:init()
        _richText:centerLeft(26)
        cell:setSize(260, _richText:getContentSize().height)
        cell:addChild(_richText)
        local picDes = UI.Image:create()
        picDes:init("ui_checkpoint_banner_diamond.png")
        picDes:leftUp(12, 4)
        cell:addChild(picDes, 10)
    end
    return cell
end

-- 进入洞穴反馈消息
function ExpeditionView:enterCaveResult(data)
    if (data and data.result ~= "EnterCaveSceneResult_Succeed") then
        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.EnterCaveSceneResult", data.result))
    end
    UI.WaitingLayer:hideWaiting()
end

function ExpeditionView:clickClose()
    self:openShowAction(false)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
end

-- 点击外部区域的处理器
local function onTouchDialogOutsizeHandler(self, _, _, touchPosition)
    if self.mBClick == true then
        if self.leftLayer:checkTouch(touchPosition) then
            return
        end
        self:clickClose()
    end
end

-- 注册监听事件
function ExpeditionView:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshBtnStatus)
    Avalon.MessageCenter:bind(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.cardStatusChange)
end

-- 注销监听事件
function ExpeditionView:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshBtnStatus)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_MONTH_CARD_STATUS_REFRESH, self, self.cardStatusChange)
end

function ExpeditionView:cardStatusChange()
    self:refreshMonthCardStatus()
    self:refreshUpOrExpeditionStatus()
    self:showRewardLayer()
end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function ExpeditionView:refreshTabState()
end

function ExpeditionView:playIdleExpedition()
    self.maoTouYingAnimation:setAnimation("begin", true)
    self.roleEffect:setAnimation("begin", true)
end

function ExpeditionView:playRoleExpedition(isSet)
    if not self.selectedIcon then
        return
    end
    self:refreshUpOrExpeditionStatus()
    self.initPlayRole = true
    local choice = false
    local gateId = ToolsUtil:getShopLevelForCaveLevel(self.selectedIcon:getTag(), mvc.expeditionModel:getExpeditionMode())
    --print("xpeditionView:playRoleExpedition", gateId, mvc.expeditionModel:getExpeditionLevel())
    if(mvc.expeditionModel:getExpeditionStatus())then
        choice = true
    end
    if (not (self._roleAnimation and self._roleAnimation:getRoleRender() and
            self._roleAnimation:getRoleRender():getHeroAnimation()))
    then
        print("ExpeditionView:playRoleExpedition  no init handle", choice)
        return
    end
    -- print("ExpeditionView:playRoleExpedition", choice)
    if (isSet) then
        if (choice) then
            self._roleAnimation:getRoleRender():getHeroAnimation():setAnimation(
                0,
                "move_town_" .. self._roleAnimation._currentWeaponType,
                true
            )
        else
            self._roleAnimation:getRoleRender():getHeroAnimation():setAnimation(
                0,
                "idle_town_" .. self._roleAnimation._currentWeaponType,
                true
            )
        end
    else
        if (choice) then
            self._roleAnimation:getRoleRender():getHeroAnimation():addAnimation(
                0,
                "move_town_" .. self._roleAnimation._currentWeaponType,
                true
            )
        else
            self._roleAnimation:getRoleRender():getHeroAnimation():addAnimation(
                0,
                "idle_town_" .. self._roleAnimation._currentWeaponType,
                true
            )
        end
    end
end

function ExpeditionView:playNormalExpedition()
    self.maoTouYingAnimation:setAnimation("ordinary_trigger", false)
    self.maoTouYingAnimation:addAnimation("ordinary_idle", true)
    self.roleEffect:setAnimation("ordinary_trigger", false)
    self.roleEffect:addAnimation("ordinary_idle", true)
    self.bgAnimation:setAnimation("ordinary_trigger", false)
    self.bgAnimation:addAnimation("ordinary_idle", true)

    if self._roleAnimation and self._roleAnimation:getRoleRender() then
        -- self._roleAnimation:getRoleRender():getHeroAnimation():setAnimation(0, "idle_fun_"..self._roleAnimation._currentWeaponType, false)

        self:playRoleExpedition(true)
    end
end

function ExpeditionView:playStopNormalExpedition()
    self.maoTouYingAnimation:setAnimation("ordinary_end", false)
    self.maoTouYingAnimation:addAnimation("begin", true)
    self.roleEffect:setAnimation("ordinary_end", false)
    self.roleEffect:addAnimation("begin", true)
    self.bgAnimation:setAnimation("ordinary_end", false)
    self.bgAnimation:addAnimation("begin", true)

    if self._roleAnimation and self._roleAnimation:getRoleRender() then
        self:playRoleExpedition(true)
    end
end

-- 播放快速
function ExpeditionView:playQuickExpedition()
    local expeditionStatus = mvc.expeditionModel:getExpeditionStatus()

    self.maoTouYingAnimation:setAnimation("speed_trigger", false)
    self.roleEffect:setAnimation("speed_trigger", false)
    self.bgAnimation:setAnimation("speed_trigger", false)
    if (expeditionStatus) then
        self.roleEffect:addAnimation("ordinary_idle", true)
        self.maoTouYingAnimation:addAnimation("ordinary_idle", true)
        self.bgAnimation:addAnimation("ordinary_idle", true)
    else
        self.roleEffect:addAnimation("begin", true)
        self.maoTouYingAnimation:addAnimation("begin", true)
        self.bgAnimation:addAnimation("begin", true)
    end    
    if self._roleAnimation and self._roleAnimation:getRoleRender() then
        local heroData = RoleDataManager:getMaster()
        if heroData:getLooks() == 0 then
            self._roleAnimation:getRoleRender():getHeroAnimation():setAnimation(
                0,
                "idle_fun_" .. self._roleAnimation._currentWeaponType,
                false
            )
        end

        self:playRoleExpedition(false)
    end
end

function ExpeditionView:getExpeditionLevel()
    local gateId = ToolsUtil:getShopLevelForCaveLevel(self.selectedIcon:getTag())
    return mvc.expeditionModel:calculationExpeditionID(self.data.caveMode, gateId)
end

-- function ExpeditionView:refresh

function ExpeditionView:refreshBtnStatus()
    -- if(self.normalBtn) then
    --     if (mvc.expeditionModel:getRemainTime() <= 0 and not mvc.expeditionModel:getExpeditionStatus()) then
    --         self.normalBtn:disable()
    --         -- self.normalBtn:setFontColor(UI.FONT_COLOR_164_164_164)
    --         self.normalBtn:setText(UI.TEXT_1212574)
    --     else
    --         self.normalBtn:enable()
    --         -- self.normalBtn:setFontColor(UI.FONT_COLOR_220_182_80)
    --         if (mvc.expeditionModel:getExpeditionStatus()) then
    --             self.normalBtn:setText(UI.TEXT_1212575)
    --         else
    --             self.normalBtn:setText(UI.TEXT_1212574)
    --         end
    --     end
    -- end

    -- local diamondArr = string.split(ConfigManager:getGeneralForKey("fastAdventurediamond"), ";")
    -- if (mvc.expeditionModel:getQuickExpeditionNum() >= #diamondArr) then
    --     self.quickBtn:disable()
    --     -- self.quickBtn:setFontColor(UI.FONT_COLOR_164_164_164)
    --     self.quickBtnImage:setSpriteName("ui_explore_hourglass_2.png")

    --     self.quickImage:setVisible(false)
    --     self.quickTipText:setVisible(false)
    -- else
    --     self.quickBtn:enable()
    --     -- self.quickBtn:setFontColor(UI.FONT_COLOR_220_182_80)
    --     self.quickBtnImage:setSpriteName("ui_explore_hourglass_0.png")

    --     -- 快速探险价格
    --     local num = tonumber(diamondArr[mvc.expeditionModel:getQuickExpeditionNum() + 1])
    --     if (num > 0) then
    --         self.quickTipText:setText("X" .. tostring(num))

    --         if tonumber(num) == 0 or tonumber(num) <= GameDataManager:getInstance():getDiamond() then
    --             self.quickTipText:setFontColor(UI.FONT_COLOR_227_214_172)
    --         else
    --             self.quickTipText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
    --         end

    --         self.quickImage:setVisible(true)
    --         self.quickTipText:setVisible(true)
    --         local startX = -(self.quickImage:getContentSize().width + self.quickTipText:getContentSize().width + 4) / 2
    --         self.quickImage:centerLeft(startX)
    --         self.quickTipText:centerLeft(startX + 4 + self.quickImage:getContentSize().width)
    --     else
    --         self.quickImage:setVisible(false)
    --         self.quickTipText:setVisible(false)
    --     end
    -- end

    self.quickBtn:enable()
    -- self.quickBtn:setFontColor(UI.FONT_COLOR_220_182_80)
    self.quickBtnImage:setSpriteName("ui_explore_hourglass_0.png")

    local curTimes = mvc.expeditionModel:getQuickExpeditionNum()

    -- 快速探险价格
    if not curTimes or curTimes == 0 then
        self.quickBg:hide()
    else
        self.quickBg:show()

        local pk = RoleDataManager:getMaster():getPK()
        local licenceTotalNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, CARD_ID)
        local cardNum = tonumber(licenceTotalNum)

        self.quickTipText:setText("X" .. tostring(cardNum))
        if cardNum == 0 then
            self.quickTipText:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        else
            self.quickTipText:setFontColor(UI.FONT_COLOR_227_214_172)
        end

    end
end

function ExpeditionView:getGateConfig(mode, level)
    local gateId = level
    local list = ConfigManager:getAllLevelSelectDataByType(mode)

    local gateConfig = nil
    local index = 1
    for k, v in ipairs(list) do
        for k2, cfgLevel in ipairs(v.includeLevel) do
            if gateId == cfgLevel then
                gateConfig = v
                index = k2
                break
            end
        end
    end
    if gateConfig == nil then
        print("---showRewardLayer- but gateConfig is nil")
        return nil, nil
    end

    return gateConfig, index
end

-- 显示奖励列表
function ExpeditionView:showRewardLayer()
    if(tolua.isnull(self.selectedIcon)) then 
        return
    end

    local level = self.selectedIcon:getTag()
    local gateConfig, index = self:getGateConfig(self.data.caveMode, level)

    if gateConfig == nil then
        print("---showRewardLayer- but gateConfig is nil")
        return
    end
    self.gateConfig = gateConfig
    self.gateConfigIndex = index
    -- print("showRewardLayer 1=", self.data.caveMode, level) 
    local expeditionData = mvc.expeditionModel:getExpeditionConfigData(self.data.caveMode, ToolsUtil:getShopLevelForCaveLevel(level))
    -- add by zp 这里+9 为一个默认处理，否者会出现异常表现
    local nowLevel = mvc.expeditionModel:getExpeditionMaxLevelForModelOrCheckpoint(self.data.caveMode, mvc.expeditionModel:maxLevelCoverToCheckpoint(self.data.caveMode, level + 9))
    -- print("showRewardLayer 2=", nowLevel,self.data.caveMode, level, ToolsUtil:getShopLevelForCaveLevel(level), mvc.expeditionModel:maxLevelCoverToCheckpoint(self.data.caveMode, level + 9))
    if mvc.expeditionModel:getExpeditionStatus() 
        and self.data.caveMode == mvc.expeditionModel:getExpeditionMode() 
        and ToolsUtil:getShopLevelForCaveLevel(level) == ToolsUtil:getShopLevelForCaveLevel(mvc.expeditionModel:getExpeditionCaveLevel())  then 
        expeditionData = mvc.expeditionModel:getExpeditionConfigData(mvc.expeditionModel:getExpeditionMode(), ToolsUtil:getShopLevelForCaveLevel(mvc.expeditionModel:getExpeditionLevel()))
        nowLevel = mvc.expeditionModel:getExpeditionCaveLevel()
        -- print("showRewardLayer 3=", nowLevel, mvc.expeditionModel:getExpeditionCaveLevel())
    end
    if (self.data.caveMode ~= PublicDefine.CAVE_MODE.MODE_HERO 
        and self.data.caveMode ~= PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) then
        self.choiceLevelText:setText(string.format(UI.TEXT_110001, nowLevel))
    else
        self.choiceLevelText:setText(LanguageManager:getInstance():getLocalString(self.gateConfig.name))
    end
    -- 这里根据选择去当前能够探险的点
    
    if (expeditionData) then
        local rewardNode = self.rightLayer:getChildByName("RewardNode")
        if rewardNode then
            rewardNode:removeFromParent(true)
        end
        local winSize = cc.Director:getInstance():getWinSize()
        local rewardNode = UI.RewardPreViewUtil:create()
        rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
        rewardNode:init(nil, 4, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true)

        rewardNode:leftBottom(30, 0)
        local rewardData = expeditionData.BoxDrop
        local idList = string.split(rewardData, ",")
        for k, v in pairs(idList) do
            rewardNode:addGoodsId(tonumber(v), 0)
        end
        rewardNode:showGoodsView()
        rewardNode:setName("RewardNode")
        self.rightLayer:addChild(rewardNode)

        -- 刷新当前的挂机产量
        local wasUp = false
        local expUp = false
        local coinUp = false

        local rewardArr = {0, 0}
        local cardFlag = false
        if (mvc.expeditionModel:getHaveMonthDay()) then
            local expeditionCoinincome = ConfigManager:getGeneralForKey("ExpeditionCoinincome")
            rewardArr = string.split(expeditionCoinincome, ";")
            cardFlag = true
        end
        if (self.data.caveMode == mvc.expeditionModel:getSpeedMode() 
            and expeditionData.checkpoint - math.floor(expeditionData.checkpoint/100000) * 100000 == mvc.expeditionModel:getSpeedLevel()) then
            self.coinUpImage:setVisible(false)
            self.expUpImage:setVisible(false)
            wasUp = true

            if
                (mvc.expeditionModel:getSpeedType() ==
                    ProtobufUtil:enum_id("NPCSystem.ExpeditionSpeedType", "ExpeditionSpeedType_exp"))
             then
                self.expUpImage:setVisible(true)
                expUp = true
            elseif
                (mvc.expeditionModel:getSpeedType() ==
                    ProtobufUtil:enum_id("NPCSystem.ExpeditionSpeedType", "ExpeditionSpeedType_coin"))
             then
                self.coinUpImage:setVisible(true)
                coinUp = true
            end
        else
            self.coinUpImage:setVisible(false)
            self.expUpImage:setVisible(false)
        end

        local goldConfig = string.split(expeditionData.goldcoinincome, ",")
        local avaNum = (tonumber(goldConfig[1]) + tonumber(goldConfig[2])) / 2
        local guildData = MasterDataManager:getGuildData()
        local isActive = false
        if guildData then
            isActive = guildData:isActiveWrit(PublicDefine.WritID.WritID_Expedtion)
        end

        if (coinUp or cardFlag or isActive) then
            self.coinDesText:setFontColor(UI.FONT_COLOR_36_181_118)
            local addNum = 0
            if (coinUp) then
                addNum = addNum + tonumber(expeditionData.goldcoinratio)
            end
            if (cardFlag) then
                addNum = addNum + tonumber(rewardArr[1])
            end
            if isActive then
                local writExpeditionUp = ConfigManager:getGeneralForKey("writExpeditionUp") 
                local rewardArr2 = string.split(writExpeditionUp, ";")
                addNum = addNum + tonumber(rewardArr2[1])
            end
            avaNum = avaNum * (1 + addNum / RATIO_NUMBER)
        else
            self.coinDesText:setFontColor(UI.FONT_COLOR_170_170_170)
        end

        self.coinDesText:setText(string.format("%d/%ds", avaNum, tonumber(goldConfig[3])))

        local expConfig = string.split(expeditionData.expcoinincome, ",")
        local avaExpNum = (tonumber(expConfig[1]) + tonumber(expConfig[2])) / 2
        if (expUp or cardFlag or isActive) then
            self.expDesText:setFontColor(UI.FONT_COLOR_36_181_118)
            local addNum = 0
            if (expUp) then
                addNum = addNum + tonumber(expeditionData.expcoinratio)
            end
            -- print("2", avaExpNum, addNum)
            if (cardFlag) then
                addNum = addNum + tonumber(rewardArr[2])
            end
            if isActive then
                local writExpeditionUp = ConfigManager:getGeneralForKey("writExpeditionUp") 
                local rewardArr2 = string.split(writExpeditionUp, ";")
                addNum = addNum + tonumber(rewardArr2[2])
            end
            -- print("2", avaExpNum, addNum)
            avaExpNum = avaExpNum * (1 + addNum / RATIO_NUMBER)
        else
            self.expDesText:setFontColor(UI.FONT_COLOR_170_170_170)
        end
        self.expDesText:setText(string.format("%d/%ds", avaExpNum, tonumber(expConfig[3])))

        --
        local totalWidth =
            self.coinImage:getContentSize().width + self.coinDesText:getContentSize().width +
            self.coinTitleText:getContentSize().width +
            4
        local startX = -(totalWidth) / 2
        self.coinImage:centerLeft(startX)
        startX = startX + self.coinImage:getContentSize().width + 4
        self.coinTitleText:centerLeft(startX)
        startX = startX + self.coinTitleText:getContentSize().width + 2
        self.coinDesText:centerLeft(startX)
        self.coinUpImage:centerLeft(totalWidth / 2 + 5)

        local totalWidth =
            self.expImage:getContentSize().width + self.expDesText:getContentSize().width +
            self.expTitleText:getContentSize().width +
            4
        local startX = -(totalWidth) / 2
        self.expImage:centerLeft(startX)
        startX = startX + self.expImage:getContentSize().width + 2
        self.expTitleText:centerLeft(startX)
        startX = startX + self.expTitleText:getContentSize().width + 2
        self.expDesText:centerLeft(startX)
        self.expUpImage:centerLeft(totalWidth / 2 + 5)
    end

    -- 处理描述信息
    if LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
    elseif LevelSelectUtil:getInstance().mCaveMode == PublicDefine.CAVE_MODE.MODE_HERO then
    end
end

-- function ExpeditionView:getSpecialEventReward(gateConfig, index)
--     local sceneId = gateConfig.ID
--     local eventList, isUsed = MasterDataManager:getHeroCaveSpecialEnventBySceneId(sceneId)
--     local eventSize = #eventList
--     local goodsDataList = {}
--     if eventSize > 0 and not isUsed then
--         -- 计算事件箱子的等级
--         local boxLevel = ConfigManager:getEventBoxLevel(eventList)
--         local rewardData = nil
--         if boxLevel == 1 then
--             rewardData = self.gateConfig.BoxDrop1[1]
--         elseif boxLevel == 2 then
--             rewardData = self.gateConfig.BoxDrop2[1]
--         elseif boxLevel == 3 then
--             rewardData = self.gateConfig.BoxDrop3[1]
--         end
--         if rewardData then
--             local idList = string.split(rewardData, ",")

--             for k, v in pairs(idList) do
--                 table.insert(goodsDataList, tonumber(v))
--             end
--         end
--     else
--         local rewardData = gateConfig.BoxDrop[index]
--         goodsDataList = string.split(rewardData, ",")
--     end
--     return goodsDataList
-- end

function ExpeditionView:spinePlayCallback(event, param)
    if (event and event.eventData and event.eventData.name == "change") then
        self:showRewardLayer()
    end
end

function ExpeditionView:refreshTeamBtnState()
end

function ExpeditionView:refreshMonthCardStatus()
    local guildData = MasterDataManager:getGuildData()
    local isActive = false
    if guildData then
        isActive = guildData:isActiveWrit(PublicDefine.WritID.WritID_Expedtion)
    end
    local expeditionCoinincome = ConfigManager:getGeneralForKey("ExpeditionCoinincome")
    local rewardArr = string.split(expeditionCoinincome, ";")
    local writExpeditionUp = ConfigManager:getGeneralForKey("writExpeditionUp") 
    local rewardArr2 = string.split(writExpeditionUp, ";")
    local expeditionStatus = mvc.expeditionModel:getExpeditionStatus()
    local haveMonthDay = mvc.expeditionModel:getHaveMonthDay()
    if not expeditionStatus then
        self.cardCoinText:setFontColor(UI.FONT_COLOR_170_170_170)
        self.cardExpText:setFontColor(UI.FONT_COLOR_170_170_170)
         if not isActive and not haveMonthDay then
            self.cardCoinText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[1]) * 100) / RATIO_NUMBER) .. "%"))
            self.cardExpText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[2]) * 100) / RATIO_NUMBER) .. "%"))
          
            self.writBufIcon:hide()
            self.cardEffect:show()
            self.cardEffect:setTimeScale(0)
            self.cardTitle:setText(UI.TEXT_1212604)
        elseif isActive and not haveMonthDay then
            self.cardCoinText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr2[1]) * 100) / RATIO_NUMBER) .. "%"))
            self.cardExpText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr2[2]) * 100) / RATIO_NUMBER) .. "%"))

            self.writBufIcon:show()
            self.cardEffect:hide()
            self.cardTitle:setText(UI.TEXT_1212605)
        elseif not isActive and haveMonthDay then   
            self.cardCoinText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[1]) * 100) / RATIO_NUMBER) .. "%"))
            self.cardExpText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[2]) * 100) / RATIO_NUMBER) .. "%"))

            self.writBufIcon:hide()
            self.cardEffect:show()
            self.cardEffect:setTimeScale(0)
            self.cardTitle:setText(UI.TEXT_1212605)
        else
            self.cardCoinText:setText(string.format("+%s", string.format("%.1f", ((tonumber(rewardArr[1]) + tonumber(rewardArr2[1])) * 100) / RATIO_NUMBER) .. "%"))
            self.cardExpText:setText(string.format("+%s", string.format("%.1f", ((tonumber(rewardArr[2]) + tonumber(rewardArr2[2])) * 100) / RATIO_NUMBER) .. "%"))

            self.writBufIcon:hide()
            self.cardEffect:show()
            self.cardEffect:setTimeScale(1)
            self.cardTitle:setText(UI.TEXT_1212605)
        end
    else
        self.cardCoinText:setFontColor(UI.FONT_COLOR_36_181_118)
        self.cardExpText:setFontColor(UI.FONT_COLOR_36_181_118)
        if not isActive and not haveMonthDay then
            self.cardCoinText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[1]) * 100) / RATIO_NUMBER) .. "%"))
            self.cardExpText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[2]) * 100) / RATIO_NUMBER) .. "%"))
            self.cardCoinText:setFontColor(UI.FONT_COLOR_170_170_170)
            self.cardExpText:setFontColor(UI.FONT_COLOR_170_170_170)
            
            self.writBufIcon:hide()
            self.cardEffect:show()
            self.cardEffect:setTimeScale(0)
            self.cardTitle:setText(UI.TEXT_1212604)
        elseif isActive and not haveMonthDay then
            self.cardCoinText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr2[1]) * 100) / RATIO_NUMBER) .. "%"))
            self.cardExpText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr2[2]) * 100) / RATIO_NUMBER) .. "%"))
           
            self.writBufIcon:show()
            self.cardEffect:hide()
            self.cardTitle:setText(UI.TEXT_1212605)
        elseif not isActive and haveMonthDay then   
            self.cardCoinText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[1]) * 100) / RATIO_NUMBER) .. "%"))
            self.cardExpText:setText(string.format("+%s", string.format("%.1f", (tonumber(rewardArr[2]) * 100) / RATIO_NUMBER) .. "%"))

            self.writBufIcon:hide()
            self.cardEffect:show()
            self.cardEffect:setTimeScale(1)
            self.cardTitle:setText(UI.TEXT_1212605)
        else
            self.cardCoinText:setText(string.format("+%s", string.format("%.1f", ((tonumber(rewardArr[1]) + tonumber(rewardArr2[1])) * 100) / RATIO_NUMBER) .. "%"))
            self.cardExpText:setText(string.format("+%s", string.format("%.1f", ((tonumber(rewardArr[2]) + tonumber(rewardArr2[2])) * 100) / RATIO_NUMBER) .. "%"))

            self.writBufIcon:hide()
            self.cardEffect:show()
            self.cardEffect:setTimeScale(1)
            self.cardTitle:setText(UI.TEXT_1212605)
        end
    end
end

function ExpeditionView:bindModel()
end

function ExpeditionView:unbindModel()
end

function ExpeditionView:quickResult(data)
    self:playQuickExpedition()
    self:onOpenFastBag()
    self:updateQuickBtn()
end

function ExpeditionView:normalResult(data)
    self:playNormalExpedition()
    self:refreshBagStatus()
    self:refreshMonthCardStatus()
end

function ExpeditionView:stopNormalResult(data)
    self:playStopNormalExpedition()
    self:refreshBagStatus()
end

function ExpeditionView:dataUpdateRefresh()
    if (self.preExpeditionStatus ~= mvc.expeditionModel:getExpeditionStatus()) then
        self:playRoleExpedition(true)
        if (mvc.expeditionModel:getExpeditionStatus()) then
            self:playNormalExpedition()
        else
            self:playIdleExpedition()
        end
    end
    self.preExpeditionStatus = mvc.expeditionModel:getExpeditionStatus()

    self:refreshBagStatus()
    self:refreshBtnStatus()
    self:refreshUpOrExpeditionStatus()
    self:refreshMonthCardStatus()
    self:showRewardLayer()
    self:update(0.01)
end

function ExpeditionView:bagDataUpdate()
    self:refreshBagStatus()

    if (not tolua.isnull(self.bagView)) then
        local bagType = self.bagView:getBagType()
        if (not mvc.expeditionModel:getIsNotNullForPacketType(bagType)) then
            self.bagView:removeFromParent()
            self.bagView = nil
        else
            self.bagView:dataUpdate()
        end
    end
end

function ExpeditionView:bagClose()
    if (not self.ordinaryBagBtn:isDisable()) then
        self.ordinaryBagBtn:enable()
        self.ordinaryBagBtn:setBtnStatus(ButtonState.NORMAL)
        self.ordinaryBagStaus:setVisible(true)
    end
    if (not self.fastBagBtn:isDisable()) then
        self.fastBagBtn:enable()
        self.fastBagBtn:setBtnStatus(ButtonState.NORMAL)
        self.fastBagStaus:setVisible(true)
    end
end

function ExpeditionView:bagAttrChange()
    if (not tolua.isnull(self.bagView)) then
        self.bagView:bagAttrChange()
    end

    if (not tolua.isnull(self.bagView)) then
        local bagType = self.bagView:getBagType()
        if (not mvc.expeditionModel:getIsNotNullForPacketType(bagType)) then
            self.bagView:removeFromParent()
            self.bagView = nil
        else
            self.bagView:dataUpdate()
        end
    end
end

function ExpeditionView:updateQuickBtn()
    local masterData = RoleDataManager:getMaster()
    local quickText = UI.TEXT_1212573
    local curTimes = mvc.expeditionModel:getQuickExpeditionNum()
    if masterData:getIsReincarntion() and curTimes > 0 then
        local reincarntionLv = masterData:getReincarntionLv()
        local config = ConfigManager:getAllRoleReincarnationDataByID(reincarntionLv)
        local maxExpeditionNum = config.maxExpeditionNum
        local showNum = (maxExpeditionNum - curTimes + 1) >= 0 and (maxExpeditionNum - curTimes + 1) or 0
        quickText = quickText..string.format(UI.TEXT_224312, showNum)
    end
    self.quickBtn:setText(quickText)
end


return ExpeditionView
