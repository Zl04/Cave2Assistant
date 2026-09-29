-- LevelSelect.lua
-- Author:ODEI
-- 2017年4月10日
-- Using:关卡选择  

--[[隔离数据和UI， 并统一数据在外部封装传入]]
require("utils.ObserverVariable")
require("app.ui.town.levelSelect.LevelSelectDifficulty")
require("app.ui.town.levelSelect.LevelSelectTeam")
require("app.ui.town.levelSelect.LevelSelectReady")
require("app.ui.town.levelSelect.LevelSelectNormalBtn")
require("app.ui.town.levelSelect.LevelSelectEventBtn")
require("app.ui.town.SuperLevelSelect")
require("app.ui.UIManager")
require "app.datas.AnswerDataManager"
require("app.ui.town.levelSelect.SwitchCavePannel")

local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local LanguageManager = require("app.game.LanguageManager")
local scheduler = cc.Director:getInstance():getScheduler()
require("app.utils.RewardPreViewUtil")

UI = UI or {}
local LevelSelect = class("LevelSelect", UI.SuperLevelSelect)
UI.LevelSelect = LevelSelect
local winSize = cc.Director:getInstance():getWinSize()
local LayerSize = cc.size(1022, 579)
local ScrollViewSize = cc.size(700, 460)
-- 关卡选择资源
local COM_RES_LIST = {
    "ui_town_levelselect.plist",
    "ui_town_reincarnation_role.plist",
}
function LevelSelect:ctor(NPCSpriteID, layerType, extraData, isFirst)
    local layerId = UIType.LEVEL_SELECT
    if layerType == Game.LevelSelectLayerType.Desert_Eye then
        layerId = UIType.LEVEL_SELECT_EYE
    elseif layerType == Game.LevelSelectLayerType.Titan_Road then
        layerId = UIType.LEVEL_SELECT_TITAN
    elseif layerType == Game.LevelSelectLayerType.Dried_Spring then
        layerId = UIType.LEVEL_SELECT_DRIED_SPRING
    end
    LevelSelect.super.ctor(
    self,layerId,
    COM_RES_LIST,
    LayerSize.width,
    LayerSize.height,
    layerType)
    self.rootLayer = nil;           --root节点

    self.levelBtnList = {}          --关卡按钮
    self.stepPoint = {}             --二位数组  组成关卡连线 的点的集合
    self.levelBtnRootNode = nil;    --关卡Root

    self.heroLevelBtnList = {}          --英雄模式关卡按钮

    self.specialEventIconLayout = {} --特殊事件icon
    self.lockAllBtn = false          --按钮锁，点击开始按钮后播放动画的过程中锁住所有按钮
    self.isShowEvent = false       --在英雄模式下 是否展示特殊事件模式
    self.defaultNomalSelectIcon = nil
    self.defaultHeroSelectIcon = nil
    self.mBClick = true;
    self.mLockDiffSelect = false
    self.curCaveMode = nil
    self.spriteID = NPCSpriteID
    self.isFloatCloudAct = false
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    
    self.isFirst = isFirst or false

    self.data = {}    
    self.layerType = layerType
    if self.layerType == Game.LevelSelectLayerType.Normal_Plot then
        LevelSelectUtil:getInstance():initTimeCaveData()
        MasterDataManager:checkRefreshCountAndTime()
        self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 6, false)
        self.data.caveMode = LevelSelectUtil:getInstance().mCaveMode
        self.data.oldOpenLevel = LevelSelectUtil:getInstance().mOldOpenLevel
        self.data.curOpenLevel = LevelSelectUtil:getInstance().mOpenLevel:get()
        if extraData and extraData.caveMode then
            self.data.caveMode = extraData.caveMode
        end
    elseif self.layerType == Game.LevelSelectLayerType.Dungeon  then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_DUNGEON
    elseif self.layerType == Game.LevelSelectLayerType.Desert_Eye then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_DESERT_EYES
        self.data.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(PublicDefine.CAVE_MODE.MODE_DESERT_EYES, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
        local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
        if openCheckpointData then
            self.data.oldOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint())
        else
            self.data.oldOpenLevel = 0
        end
    elseif self.layerType == Game.LevelSelectLayerType.Distorted_Space then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE
    elseif self.layerType == Game.LevelSelectLayerType.Inferno then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_INFERNO
    elseif self.layerType == Game.LevelSelectLayerType.VoidRift then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_VOID_RIFT
    elseif self.layerType == Game.LevelSelectLayerType.ViKing then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_VIKING
    elseif self.layerType == Game.LevelSelectLayerType.Titan_Road then
        LevelSelectUtil:getInstance():initTitanRoadCaveData()
        self.data.caveMode = LevelSelectUtil:getInstance().mCaveMode--PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
        MasterDataManager:checkRefreshTitanCountAndTime()
        self.data.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
        local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
        if openCheckpointData then
            self.data.oldOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint())
        else
            self.data.oldOpenLevel = 0
        end
    elseif self.layerType == Game.LevelSelectLayerType.Dried_Spring then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
        self.data.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(PublicDefine.CAVE_MODE.MODE_DRIED_SPRING, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
        local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
        if openCheckpointData then
            self.data.oldOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint())
        else
            self.data.oldOpenLevel = 0
        end
    elseif self.layerType == Game.LevelSelectLayerType.Chaos_WormHole then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_CHAOS
    end
    --容错处理：
    if self.data.oldOpenLevel <= 0 then
        GameDataManager:getInstance():openCheckpoint(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, LevelSelectUtil:getBeginShopLevelForCaveLevel(self.data.curOpenLevel))
    end
print("---self.data----", self.data)
    self:init();
    self:registerListener();
end

function LevelSelect:dtor()
    reload_script_file("app.ui.town.levelSelect.LevelSelect")
    if self.caveEnterLayer then
        self.caveEnterLayer:closeLayer();
    end
    LevelSelect.super.dtor(self)
    -- self._stepActList = {}
    self:unRegisterListener();
    if self.schedulerID then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end

    if self:checkSelfHaveHeroMode() then
        LevelSelectUtil:getInstance().mLastSelectTimeCaveMode = self.data.caveMode
        print("-------save------------", self.data.caveMode)
        cc.UserDefault:getInstance():setIntegerForKey(UserDefaultKeyWord.LastSelectTimeCaveMode..GameDataManager:getInstance():getMasterPK(), self.data.caveMode)
    end
    
    local textureCache = cc.Director:getInstance():getTextureCache()
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_2.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_3.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_heromap_1.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_heromap_2.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_heromap_3.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_selectfloor_plotmap_desert.png")
end

-- public:
-- 初始化
function LevelSelect:init()
    LevelSelect.super.init(self)
end

-- 模版函数：初始化组建的视图
function LevelSelect:onInitView(isShowAnimation)
    -- local scaleX = (winSize.width - 50 - Avalon.issUtil:getLeftMargin()) / LayerSize.width
    local xMinSpace = 30-- 是让横向 不要挤得太满
    local yMinSpace = 80-- 是让竖向 不要挤得太满
    --底线参数 点击空余
    local xMaxSpace = 100-- 让横向 有足够多的点击空间
    local yMaxSpace = 120-- 让竖向 有足够多的点击空间
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
   
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:center()
    self.rootLayer:setSize(LayerSize.width, LayerSize.height)
    self:addChild(self.rootLayer)
    -- self.rootLayer:enableDebugDraw()

    local leftLayer = UI.Component:create()
    leftLayer:init()
    leftLayer:setSize(330, 640)
    self.rootLayer:addChild(leftLayer, 2)
    self.leftLayer = leftLayer
    local leftBg = UI.Image:create()
    leftBg:init("ui_selectfloor_bg.png")
    leftBg:centerBottom(0)
    leftLayer:addChild(leftBg)

    -- 购买猫饭快捷方式
    local catFoodBtn = UI.Button:create()
    catFoodBtn:init("ui_btn_catfood_0.png", "ui_btn_catfood_1.png", "ui_btn_catfood_0.png")
    catFoodBtn:leftBottom(274, 120)
    local parenLayer = self
    catFoodBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_CATFOOD, 0, parenLayer)
    end)
    leftLayer:addChild(catFoodBtn, 10)
   
    local descriptionLayout =  UI.Layout:create()
    descriptionLayout:init()
    descriptionLayout:setSize(226, 200)
    self.descriptionLayout = descriptionLayout


    local panel = self:createFisrtPassPanel()
    if panel then
        panel:leftUp(10, 212)
        leftLayer:addChild(panel, 1000)
        self.fisrtPassPanel = panel
    end

    local detailedScrollView = UI.ScrollView:create()
    if self.fisrtPassPanel then
        detailedScrollView:setSize(250, 160)
    else
        detailedScrollView:setSize(250, 220)
    end
    detailedScrollView:init(0, 0, 0, 0)
    detailedScrollView:leftBottom(27, 195)
    detailedScrollView:addInnerNode(descriptionLayout)
    leftLayer:addChild(detailedScrollView)
    self.detailedScrollView = detailedScrollView
    detailedScrollView:setScrollBarEnabled(true)
    detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Light)
    detailedScrollView:setCircleVisible(false)
    detailedScrollView:setScrollBarWidth(5)
    -- descriptionLayout:enableDebugDraw()
    -- self.detailedScrollView:enableDebugDraw(UI.RED)

    local detailCap = UI.Image:create()
    detailCap:init("ui_selectfloor_gradually.png")
    detailCap:leftBottom(7, 193)
    leftLayer:addChild(detailCap)
    detailCap:setScale(0.99)

    local line = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    line:setContentSize(225, 1)
    line:setAnchorPoint(0, 0)
    line:setPosition(25,190)
    leftLayer:addChild(line)

    local levelLimitText = UI.Text:create()
    levelLimitText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_231_38_38)
    levelLimitText:centerBottom(75, -25)
    leftLayer:addChild(levelLimitText, 10)
    self.levelLimitText = levelLimitText

    local gameModeNode = self:createGameMode(self.data.caveMode, function(gameMode)
        self:selectButton(gameMode)
    end)
    -- gameModeNode:centerBottom(112)
    -- gameModeNode:enableDebugDraw()
    gameModeNode:leftBottom(28,120)
    self.leftLayer:addChild(gameModeNode, 10)
    
    -- self.singlePlayBtn = UI.Button:create()
    -- self.singlePlayBtn:init("ui_btn_single_0.png", "ui_btn_plot_single_1.png", "ui_btn_single_2.png")
    -- self.singlePlayBtn:leftBottom(58, 112)
    -- self.singlePlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.playModelBtnClick)
    -- self.leftLayer:addChild(self.singlePlayBtn, 10)

    -- self.teamPlayBtn = UI.Button:create()
    -- self.teamPlayBtn:init("ui_btn_many_0.png", "ui_btn_plot_many_1.png", "ui_btn_many_2.png")
    -- self.teamPlayBtn:leftBottom(152, 112)
    -- self.teamPlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.playModelBtnClick)
    -- self.leftLayer:addChild(self.teamPlayBtn, 10)
    -- self.teamPlayBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS,self, function()
    --     if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
    --         Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
    --     end
    -- end)

    self.startBtn = UI.Button:create()
    self.startBtn:init("ui_btn_stone1_0.png", "ui_btn_stone1_1.png", "ui_btn_stone1_2.png")
    self.startBtn:leftBottom(10, 30)
    self.startBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.startGame)
    self.leftLayer:addChild(self.startBtn, 10)
    AvalonUtil.addBracketsAnimationToButton(self.startBtn)
    self:refreshStartBtnTip(self.startBtn)

    -----------------------
    local rightLayerSize = cc.size(700, 580)
    local _ckipperSprite = cc.LayerColor:create(cc.c4b(0,0,0,200))
    _ckipperSprite:setContentSize(rightLayerSize.width, rightLayerSize.height+50)
    local clipper = cc.ClippingNode:create(_ckipperSprite)
    clipper:setPosition(323, 0)
    self.rootLayer:addChild(clipper, 1)

    local rightLayer = UI.Layout:create()
    rightLayer:init()
    rightLayer:leftBottom(0,0)
    rightLayer:setSize(rightLayerSize.width, rightLayerSize.height)
    -- self.rootLayer:addChild(rightLayer)
    self.rightLayer = rightLayer
    clipper:addChild(rightLayer)
    self.clipper = clipper
    -- rightLayer:enableDebugDraw()

    local rewardTip = UI.Text:create()
    rewardTip:init(LanguageManager:getInstance():getLocalString(1111346), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    rewardTip:centerBottom(80)
    rightLayer:addChild(rewardTip, 10)

    local lineWidth = (rightLayer:getContentSize().width - rewardTip:getContentSize().width - 240) / 2
    local lineL = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineL:setContentSize(lineWidth, 2)
    lineL:setAnchorPoint(0, 0)
    lineL:setPosition(70, 92)
    rightLayer:addChild(lineL,10)

    local lineR = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineR:setContentSize(lineWidth, 2)
    lineR:setAnchorPoint(0, 0)
    lineR:setPosition(rightLayer:getContentSize().width - lineWidth - 70,92)
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
    rewardCapR:rightBottom(27, 23)
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
    --普通模式  
    self._scrollView, self._layout = self:createScrollView(self.layerType)
    self.rightLayer:addChild(self._scrollView, 10)

    if self:checkSelfHaveHeroMode() then
        local isTiTan = self.layerType == Game.LevelSelectLayerType.Titan_Road and true or false
        local heroRewardLayout = UI.Layout:create()
        heroRewardLayout:init()
        heroRewardLayout:setSize(265, 50)
        leftLayer:addChild(heroRewardLayout)
        heroRewardLayout:leftUp(5, 215)
        self.heroRewardLayout = heroRewardLayout 

        self._heroScrollView, self._heroLayout = self:createScrollView(self.layerType)
        self.rightLayer:addChild(self._heroScrollView, 10)

        local width  = 0
        local colorBgList = {}
        local fileName = "image/levelSelect/ui_selectfloor_heromap_1.png"
        local colorBg = cc.Sprite:create()
        colorBg:setAnchorPoint(0, 0)
        colorBg:initWithFile(fileName)
        colorBg:setPosition(width + colorBg:getContentSize().width / 2, colorBg:getContentSize().height / 2)
        width = width + colorBg:getContentSize().width
        table.insert(colorBgList, colorBg)
        self:addBouncePic(colorBg, "image/levelSelect/ui_selectfloor_heromap_3.png", "image/levelSelect/ui_selectfloor_heromap_2.png");

        self.mBtnChangeEventMode = UI.Button:create()
        self.mBtnChangeEventMode:init("ui_btn_events_0.png", "ui_btn_events_0.png")
        self.mBtnChangeEventMode:rightUp(30, 18)
        self.mBtnChangeEventMode:addEventListener(UIEvent.BUTTON_CLICK, self, self.onChangeEventMode)
        self.rightLayer:addChild(self.mBtnChangeEventMode, 10)

        local btnBg = UI.Image:create()
        btnBg:init("ui_selectfloor_map_gradually_3.png")
        btnBg:rightUp(-15, -10)
        self.mBtnChangeEventMode:addChild(btnBg, -1)

        self.mBtnRefresh = UI.Button:create()
        self.mBtnRefresh:init("ui_btn_yellow4_0.png", "ui_btn_yellow4_1.png", "ui_btn_yellow4_2.png")
        self.mBtnRefresh:rightBottom(16, 20)
        self.mBtnRefresh:addEventListener(UIEvent.BUTTON_CLICK, self, self.onRefreshClick)
        self.mBtnRefresh:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
            UI.ScrollBar:createByText(UI.TEXT_1170947)
        end)
        self.mBtnRefresh:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        self.mBtnRefresh:setText(UI.TEXT_1170031)
        self.rightLayer:addChild(self.mBtnRefresh, 10)

        local itemId = tonumber(ConfigManager:getGeneralForKey("manualSpecialEventRefreshCostGoodsID"))
        local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
        local itemIcon = nil
        if(goodsData) then
            itemIcon = UI.Image:create()
            itemIcon:init(goodsData:getIconName())
            itemIcon:centerRight(10)
            self.mBtnRefresh:addChild(itemIcon, 10)
            itemIcon:setScale(0.6)
            itemIcon:setName("ItemIcon")

            local itemCost = UI.Text:create()
            itemCost:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_50_50_44)
            itemCost:useDefaultShadowOnlyStype()
            itemCost:rightBottom(1 + 2, 5 + 11)
            itemCost:setScale(1.66)
            itemIcon:addChild(itemCost)
            itemCost:setName("ItemCost")
            local itemUsedCount = MasterDataManager:getHeroCaveRefreshCountUsedCount() + 1
            if self.layerType == Game.LevelSelectLayerType.Titan_Road then
                itemUsedCount = MasterDataManager:getTitanHeroCaveRefreshCountUsedCount() + 1
            end
            local itemCostList = string.split(ConfigManager:getGeneralForKey("manualSpecialEventRefreshCostGoodsNum"), ";")
            local showNumber = itemCostList[itemUsedCount]
            if showNumber == nil then
                itemIcon:hide()
            else
                itemCost:setText(showNumber)
            end
        end

        self.remainTime = UI.Text:create()
        self.remainTime:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        self.remainTime:rightBottom(92, 70)
        self.rightLayer:addChild(self.remainTime, 10)

        local clockIcon = AvalonUtil.createClockAnimation()
        clockIcon:centerLeft(- clockIcon:getContentSize().width - 4)
        self.remainTime:addChild(clockIcon) 
    
        local bgAnimeName = isTiTan and "effect_ui_town_selectfloor_titans" or "effect_ui_town_selectfloor"
        local modeNameBgAnim = UI.Animation:create()
        modeNameBgAnim:init(bgAnimeName.."_down.json", bgAnimeName..".atlas", 1)
        modeNameBgAnim:setSize(343, 180)
        modeNameBgAnim:setAnimation("idle1_ordi", true)
        modeNameBgAnim:leftUp(-35, 31)
        leftLayer:addChild(modeNameBgAnim)
        self.modeNameBgAnim = modeNameBgAnim

        local modeNameAni = UI.Animation:create()
        modeNameAni:init(bgAnimeName.."_up.json", bgAnimeName..".atlas", 1)
        modeNameAni:setSize(343, 100)
        modeNameAni:setAnimation("idle1_ordi", true)
        modeNameAni:leftUp(-35, 16)
        modeNameAni:setClickAudioEnable(true)
        leftLayer:addChild(modeNameAni)
        modeNameAni:setTouchEnable(true)
        self.mBtnDifficulty = modeNameAni
        if self.isFirst then
            modeNameAni:hide()
        end

        self.mBtnDifficulty:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onSelectDifficulty)
        self.mBtnDifficulty:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function()
            if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL or 
            self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
                self.mBtnDifficulty:setAnimation("tips_selectfloor_ordi", true)
                self.modeNameBgAnim:setAnimation("tips_selectfloor_ordi", true)
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO or 
            self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO  then
                self.mBtnDifficulty:setAnimation("tips_selectfloor_hero", true)
                self.modeNameBgAnim:setAnimation("tips_selectfloor_hero", true)
            end
        end)
        self.mBtnDifficulty:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function()
            if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL or
            self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
                self.mBtnDifficulty:addAnimation("idle1_ordi", true)
                self.modeNameBgAnim:addAnimation("idle1_ordi", true)
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO or
            self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                self.mBtnDifficulty:addAnimation("idle1_hero", true)
                self.modeNameBgAnim:addAnimation("idle1_hero", true)
            end
        end)
        modeNameAni:addEventListener(UIEvent.ANIMATION_EVENT,self,self.spinePlayCallback)
    else
        local isDesert = self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES and true or false
        local bgAnimeName = isDesert and "effect_ui_town_desert_selectfloor" or "effect_ui_town_dryspring_selectfloor"
        local modeNameBgAnim = UI.Animation:create()
        modeNameBgAnim:init(bgAnimeName.."_down.json", bgAnimeName..".atlas", 1)
        modeNameBgAnim:setSize(343, 180)
        modeNameBgAnim:setAnimation("idle1_desert", true)
        modeNameBgAnim:leftUp(-35, 31)
        leftLayer:addChild(modeNameBgAnim)
        self.modeNameBgAnim = modeNameBgAnim

        local modeNameAni = UI.Animation:create()
        modeNameAni:init(bgAnimeName.."_up.json", bgAnimeName..".atlas", 1)
        modeNameAni:setSize(343, 100)
        modeNameAni:setAnimation("idle1_desert", true)
        modeNameAni:leftUp(-35, 73)
        leftLayer:addChild(modeNameAni)
        self.mBtnDifficulty = modeNameAni
        modeNameAni:addEventListener(UIEvent.ANIMATION_EVENT,self,self.spinePlayCallback)
    end
        
    local modeName = UI.Text:create()
    modeName:init(LanguageManager:getInstance():getLocalString(1110499), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_157_221_231)
    modeName:center()
    modeName:setSize(220, 50)
    modeName:setTextCenter()
    modeName:rotate(270)
    -- leftLayer:addChild(modeName)
    self.modeName = modeName
    self.modeNameBgAnim:addComponent("mut", modeName, true)

    local _ckipperSprite = cc.LayerColor:create(cc.c4b(0,0,0,200))
    _ckipperSprite:setContentSize(ScrollViewSize.width, ScrollViewSize.height)
    local clipper = cc.ClippingNode:create(_ckipperSprite)
    clipper:setPosition(0, (self.rightLayer:getContentSize().height - ScrollViewSize.height) / 2 + 50)
    clipper:setAlphaThreshold(1.0)
    self.rightLayer:addChild(clipper, 10)

    -- add by zp 单人挑战更新个人进度
    local noticeImageBg = UI.Image:create()
    noticeImageBg:init("ui_selectfloor_information_02.png")
    noticeImageBg:rightUp(9, -16)
    self.rootLayer:addChild(noticeImageBg, 1000)
    self._noticeImageBg = noticeImageBg
    noticeImageBg:setVisible(false)

    local iconImage = UI.Image:create()
    iconImage:init("ui_selectfloor_information_01.png")
    iconImage:centerUp(-13)
    noticeImageBg:addChild(iconImage)
    self._iconImage = iconImage

    local noticeText = UI.Text:create()
    noticeText:init(LanguageManager:getInstance():getLocalString(1112016), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_217_187_117)
    noticeText:centerLeft(0)
    noticeImageBg:addChild(noticeText)
    self._noticeText = noticeText

    local startX = (noticeImageBg:getContentSize().width - iconImage:getContentSize().width - noticeText:getContentSize().width)/2
    iconImage:centerLeft(startX)
    noticeText:centerLeft(startX + iconImage:getContentSize().width + 14)

    local master = RoleDataManager:getMaster()
    if master:getIsReincarntion() and not self:checkIsHeroMode() then--self:checkSelfHaveHeroMode() then
        local isDesert = self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES and true or false
        local isTiTan = self.layerType == Game.LevelSelectLayerType.Titan_Road and true or false
        local btnName 
        if self:checkSelfHaveHeroMode() then
            btnName = isTiTan and "ui_reincarnation_role_titlebg3.png" or "ui_reincarnation_role_titlebg2.png"
        else     
            btnName = isDesert and "ui_reincarnation_role_titlebg.png" or "ui_reincarnation_role_titlebg3.png"
        end
        
        local modeChangeTitleBtn = UI.Button:create()
        modeChangeTitleBtn:init(btnName, btnName, btnName)
        modeChangeTitleBtn:centerUp(-50)
        -- modeChangeTitleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.onRefreshClick)
        modeChangeTitleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:onSwitchCaveMode()
        end)
        local titleColor 
        if self:checkSelfHaveHeroMode() then
            titleColor = isTiTan and UI.FONT_COLOR_108_255_208 or UI.FONT_COLOR_0_255_255
        else
            titleColor = isDesert and UI.FONT_COLOR_237_220_92 or UI.FONT_COLOR_108_255_208
        end
        modeChangeTitleBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, titleColor)
        modeChangeTitleBtn:setText(UI.TEXT_110101)
        self.rightLayer:addChild(modeChangeTitleBtn, 900)
        self.modeChangeTitleBtn = modeChangeTitleBtn
    end

    if self.isFirst and not isShowAnimation then
        self:addFirstShowAnime()
    end
    self:createLevelBtns()
    self.floatCloudCliper = clipper
    self:refreshTabState()
    self:refreshItemButton()
end

function LevelSelect:refreshStartBtnTip(button, content, color)
    printError("refreshStartBtnTipsdsda")
    local tip = button:getChildByName("StartBtnTips")
    if tip then
        tip:removeFromParent()
    end
    local mode = LanguageManager:getInstance():getLocalString(1111361)
    local textTable = nil
    if content then
        mode = LanguageManager:getInstance():getLocalString(1111361).."(%s)"
        textTable = {}
        textTable.color = color or UI.FONT_COLOR_220_182_80
        textTable.fontSize = UI.FONT_SIZE_20PX
        textTable.text = content
        textTable.fontName = UI.FONT_BOLD
    end
   
    local content = json.encode(AvalonUtil:formartRichTextToArray(UI.FONT_COLOR_220_182_80, UI.FONT_SIZE_20PX, UI.FONT_BOLD, mode, {textTable}))
    local startBtnTips = UI.RichText:create()
    local isOk = startBtnTips:initForNetJson(content, 100, nil, true)      
    if isOk then
        startBtnTips:center()
        startBtnTips:setName("StartBtnTips")
        button:addChild(startBtnTips, 10)
    end
end
-- 模版函数：更新组建的视图
function LevelSelect:onUpdateView()
    LevelSelect.super.onUpdateView(self)
    if self.mBtnRefresh then
        self.mBtnRefresh:setTextWidth(140)
        self.mBtnRefresh._text:autoAdapt()
        self.mBtnRefresh._text:setTextCenter()
        local itemIcon = self.mBtnRefresh:getChildByName("ItemIcon")
        if itemIcon and itemIcon:isVisible() then
            self.mBtnRefresh._text:centerLeft(10)
        else
            self.mBtnRefresh._text:center()
        end
    end
    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL 
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES 
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        self.selectedIcon = self.defaultNomalSelectIcon
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        self.selectedIcon = self.defaultHeroSelectIcon
        local remainCount = MasterDataManager:getHeroCaveSchemeExploreCount()
        if remainCount > 0 then
            self.isShowEvent = true
        else
            self.isShowEvent = false
        end
        LevelSelectUtil:getInstance().mUseSpecialEvent =  self.isShowEvent
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        self.selectedIcon = self.defaultHeroSelectIcon
        local remainCount = MasterDataManager:getTitanHeroCaveSchemeExploreCount()
        if remainCount > 0 then
            self.isShowEvent = true
        else
            self.isShowEvent = false
        end
        LevelSelectUtil:getInstance().mUseSpecialEvent =  self.isShowEvent
    else
        LevelSelectUtil:getInstance():setCaveMode(PublicDefine.CAVE_MODE.MODE_NORMAL)
        self.selectedIcon = self.defaultNomalSelectIcon
    end

    if self:checkSelfHaveHeroMode() then
        local unlockFunctionType = self.layerType == Game.LevelSelectLayerType.Normal_Plot and PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave or PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoadHero
        local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(unlockFunctionType)
        local isInitHeroCaveData = MasterDataManager:isInitHeroCaveData()

        if self.layerType == Game.LevelSelectLayerType.Titan_Road then
            isInitHeroCaveData = MasterDataManager:isInitTitanHeroCaveData()
        end

        if unLockHeroMode and not isInitHeroCaveData then
            Net.NetRoleSystem:getAllHeroSpecialEventRequest()
        end
        if self.selectedIcon then
            LevelSelectUtil:getInstance().mSelectLevel = self.selectedIcon:getTag()
            self:showRewardLayer()
            self:refreshFisrtPassPanel(self.fisrtPassPanel, self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, LevelSelectUtil:getInstance().mSelectLevel)
        end
    end
    self:selectButton(PublicDefine.GAME_MODE.MODE_SOLO)
    self:refreshCaveMode(false)
    --第一次打开界面必须是抖动效果(让玩家知道是可以点击的)
    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
        self.mBtnDifficulty:setAnimation("tips_mode_ordi", true)
        self.modeNameBgAnim:setAnimation("tips_mode_ordi", true)
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        self.mBtnDifficulty:setAnimation("tips_mode_hero", true)
        self.modeNameBgAnim:setAnimation("tips_mode_hero", true)
        self:_changeEventMode()
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
        self.modeNameBgAnim:setAnimation("selectfloor_desert", false)
        self.mBtnDifficulty:addAnimation("idle1_desert", true)
        self.modeNameBgAnim:setAnimation("selectfloor_desert", false)
        self.modeNameBgAnim:addAnimation("idle1_desert", true)
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
        self.mBtnDifficulty:setAnimation("tips_mode_ordi", true)
        self.modeNameBgAnim:setAnimation("tips_mode_ordi", true)
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        self.mBtnDifficulty:setAnimation("tips_mode_hero", true)
        self.modeNameBgAnim:setAnimation("tips_mode_hero", true)
        self:_changeEventMode()
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        self.modeNameBgAnim:setAnimation("selectfloor_desert", false)
        self.mBtnDifficulty:addAnimation("idle1_desert", true)
        self.modeNameBgAnim:setAnimation("selectfloor_desert", false)
        self.modeNameBgAnim:addAnimation("idle1_desert", true)
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
    end
    if self.modeChangeTitleBtn and not tolua.isnull(self.modeChangeTitleBtn) then
        local title 
        if self:checkSelfHaveHeroMode() then
            title = self.layerType == Game.LevelSelectLayerType.Normal_Plot and UI.TEXT_110101 or UI.TEXT_224400
        else
            local isDesert = self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES and true or false
            title = isDesert and UI.TEXT_1212801 or UI.TEXT_225000
        end
        
        self.modeChangeTitleBtn:setText(title)
    end
    self:openShowAction(true)
end

function LevelSelect:openShowAction(isOpen)
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
        local move1 = cc.EaseOut:create(cc.MoveTo:create(time1, cc.p(oldPosX2 + offX * 1.1, self.clipper:getPositionY())), 1)
        local move2 = cc.EaseIn:create(cc.MoveTo:create(time2, cc.p(oldPosX2 - offX * 0.8 , self.clipper:getPositionY())), 1)
        local move3 = cc.EaseIn:create(cc.MoveTo:create(time2 * 0.8, cc.p(oldPosX2, self.clipper:getPositionY())), 1)
        self.clipper:runAction(cc.Sequence:create(delatAct, move1, move2, move3))

        local oldPosX3 = self.rightLayer:getPositionX()
        self.rightLayer:setPositionX(-self.rightLayer:getContentSize().width)
        local delatAct = cc.DelayTime:create(time1 / 10)
        local move1 = cc.EaseOut:create(cc.MoveTo:create(time1 * 0.9, cc.p(oldPosX3, self.rightLayer:getPositionY())), 1)
        -- local move2 = cc.EaseOut:create(cc.MoveTo:create(time2, cc.p(oldPosX3 + offX * 1.2, self.rightLayer:getPositionY())), 1)
        -- local move3 = cc.EaseIn:create(cc.MoveTo:create(time2, cc.p(oldPosX3, self.rightLayer:getPositionY())), 1)
        self.rightLayer:runAction(cc.Sequence:create(delatAct, move1))
    else
        Avalon.AudioManager:playSound("1502")
        self:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(-winSize.width, self:getPositionY())),cc.CallFunc:create(function()
            self:close()
        end)))
    end
end

function LevelSelect:refreshFloatCloud(isShowEnter, callback)
    if not isShowEnter then
        callback()
        return
    end
    if self.floatCloud == nil then
        local floatCloud = UI.Animation:create()
        floatCloud:init("effect_ui_town_stageselect_cloud.json", "effect_ui_town_stageselect_cloud.atlas", 1)
        floatCloud:setSize(ScrollViewSize.width, ScrollViewSize.height)
        floatCloud:leftBottom(0, 10)
        self.floatCloudCliper:addChild(floatCloud, 15)
        self.floatCloud = floatCloud
        -- floatCloud:enableDebugDraw()
        self.lockAllBtn = true
        floatCloud:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(sender, event)
            if event.animation == "stageselect_open" then
                self.floatCloud:destroy()
                self.floatCloud = nil
                self.lockAllBtn = false
            elseif event.animation == "stageselect_close" then
                self.floatCloud:setAnimation("stageselect_open", false)
                if self:checkSelfHaveHeroMode() then--self.layerType == Game.LevelSelectLayerType.Normal_Plot then
                    self.mBtnDifficulty:setTouchEnable(true)
                    self.mBtnRefresh:setTouchEnable(true)
                    self.mBtnChangeEventMode:enable()
                end
                self:refreshItemButton()
                self.isFloatCloudAct = false
                if callback then
                    callback()
                end
            end
        end)
    end
    self.floatCloud:setAnimation("stageselect_close", false)
    self.isFloatCloudAct = true
    if self:checkSelfHaveHeroMode() then--self.layerType == Game.LevelSelectLayerType.Normal_Plot then
        self.mBtnDifficulty:setTouchEnable(false)
        self.mBtnRefresh:setTouchEnable(false)
        self.mBtnRefresh:disable()
        self.mBtnChangeEventMode:disable()
    end
end

function LevelSelect:spineIconPlayCallback(sender, event, obj)
    if event.animation == "start2" then
        -- add by zp 这里在请求的过程中，会导致玩家可以重复点击
        self.mBClick = true
        self.lockAllBtn = false
        if LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_SOLO
            or LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_MERCENARY then
            if (RoleBehaviorManager:enterCaveCheck()) then 
                local id = LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
                if(LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_SOLO) then
                    Net.NetRoleSystem:heroEnterCaveSceneRequest(
                        LevelSelectUtil:getInstance().mPattern,
                        self.data.caveMode,
                        LevelSelectUtil:getInstance().mDifficulty:get(),
                        id,
                        self.spriteID, self.isShowEvent)
                    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                elseif LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_MERCENARY then
                    local messageData = {}
                    messageData.difficulty = LevelSelectUtil:getInstance().mDifficulty:get()
                    messageData.level = id
                    messageData.caveMode = self.data.caveMode
                    messageData.mode = LevelSelectUtil:getInstance().mPattern
                    messageData.useSchemeInHero = self.isShowEvent
                    mvc.openPanel("Mercenary", "Mercenary", messageData)
                end
            end 

        else
            LevelSelectUtil:getInstance():setCaveMode(self.data.caveMode)
            LevelSelectUtil:getInstance().mUseSpecialEvent = self.isShowEvent
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,1)
            self:clickClose(false)
        end
    elseif event.animation == "showup" then
        sender:setBtnState(SpineIconStatus.haveUnLocked)
        print("---self.data.oldOpenLevel----", self.data.oldOpenLevel, self.data.curOpenLevel)
        self.data.oldOpenLevel = self.data.oldOpenLevel <= 0 and 1 or self.data.oldOpenLevel
        self.data.oldOpenLevel =  self.data.oldOpenLevel + 10
        GameDataManager:getInstance():openCheckpoint(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, LevelSelectUtil:getBeginShopLevelForCaveLevel(self.data.oldOpenLevel))
        self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.01),cc.CallFunc:create(function()    
            self.lockAllBtn = false      
            self:showOpenAnimation(self.data.oldOpenLevel, self.data.curOpenLevel)
        end)))
    end
end

--创建关卡数据
function LevelSelect:createLevelBtns()
    local clickCallback = function(sender, _, touchPosition)
        local spineIcon = sender
        if self.lockAllBtn == false and self.mBClick == true and spineIcon.state == SpineIconStatus.haveUnLocked and not self.isFloatCloudAct and self.rightLayer:checkTouch(touchPosition) then  
            if self.selectedIcon ~= nil then
                self.selectedIcon:unLocked()
            end
            spineIcon:selected()
            self.selectedIcon = spineIcon
             LevelSelectUtil:getInstance().mSelectLevel = spineIcon:getTag()
            if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
                self.defaultNomalSelectIcon = spineIcon
                self.mBtnDifficulty:setAnimation("selectfloor_ordi", false)
                self.modeNameBgAnim:setAnimation("selectfloor_ordi", false)
                self.mBtnDifficulty:addAnimation("tips_mode_ordi", true)
                self.modeNameBgAnim:addAnimation("tips_mode_ordi", true)
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
                self.defaultHeroSelectIcon = spineIcon
                self.mBtnDifficulty:setAnimation("selectfloor_hero", false)
                self.modeNameBgAnim:setAnimation("selectfloor_hero", false)
                self.mBtnDifficulty:addAnimation("tips_mode_hero", true)
                self.modeNameBgAnim:addAnimation("tips_mode_hero", true)
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
                self.defaultNomalSelectIcon = spineIcon
                self.mBtnDifficulty:setAnimation("selectfloor_desert", false)
                self.mBtnDifficulty:addAnimation("idle1_desert", true)
                self.modeNameBgAnim:setAnimation("selectfloor_desert", false)
                self.modeNameBgAnim:addAnimation("idle1_desert", true)
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
                self.defaultNomalSelectIcon = spineIcon
                self.mBtnDifficulty:setAnimation("selectfloor_ordi", false)
                self.modeNameBgAnim:setAnimation("selectfloor_ordi", false)
                self.mBtnDifficulty:addAnimation("tips_mode_ordi", true)
                self.modeNameBgAnim:addAnimation("tips_mode_ordi", true)
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                self.defaultHeroSelectIcon = spineIcon
                self.mBtnDifficulty:setAnimation("selectfloor_hero", false)
                self.modeNameBgAnim:setAnimation("selectfloor_hero", false)
                self.mBtnDifficulty:addAnimation("tips_mode_hero", true)
                self.modeNameBgAnim:addAnimation("tips_mode_hero", true)
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
                self.defaultNomalSelectIcon = spineIcon
                self.mBtnDifficulty:setAnimation("selectfloor_desert", false)
                self.mBtnDifficulty:addAnimation("idle1_desert", true)
                self.modeNameBgAnim:setAnimation("selectfloor_desert", false)
                self.modeNameBgAnim:addAnimation("idle1_desert", true)
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DISTORTED_SPACE then
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_INFERNO then
            elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT then
            end
            self:refreshFisrtPassPanel(self.fisrtPassPanel, self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, LevelSelectUtil:getInstance().mSelectLevel)
        end
        Avalon.AudioManager:playSound("1503")
    end
    local animEndCallback = handler(self, self.spineIconPlayCallback)
    local animStartCallback = handler(self, function(sender, event, obj)
        if event.animation == "showup" then
            if self.curCaveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
                Avalon.AudioManager:playSoundDelay("1520", 350)
            end
        end
    end)
    LevelSelect.super.createLevelBtns(self, self.data.oldOpenLevel, self.data.curOpenLevel, self._scrollView, self._layout, clickCallback, animEndCallback, animStartCallback)


    if self:checkSelfHaveHeroMode() then--self.layerType == Game.LevelSelectLayerType.Normal_Plot then
        local curHeroMode = self.layerType == Game.LevelSelectLayerType.Normal_Plot and PublicDefine.CAVE_MODE.MODE_HERO or PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO
        local heroPlotList = ConfigManager:getAllLevelSelectDataByType(curHeroMode)
        -- dump(heroPlotList, "---heroPlotList---")
        local heginX = winSize.width
        for  k, v in pairs(heroPlotList) do
            if table.nums(v.includeLevel) > 0 then
                for k2, v2 in ipairs(v.includeLevel) do
                    local posStr = v.coordinate[k2]
                    local posArray = string.split(posStr, ",")
                    local node = self:createLevelBtn(UI.LevelSelectNormalBtn, self._heroLayout, v2, tonumber(posArray[1]), tonumber(posArray[2]), "effect_ui_town_stageselect_hero_icon",  self.data.oldOpenLevel, self.data.curOpenLevel, clickCallback, animEndCallback, animStartCallback)
                    if tonumber(posArray[1]) <= heginX then
                        self.defaultHeroSelectIcon = node
                        heginX = tonumber(posArray[1])
                    end
                    node:unLocked()
                    self.heroLevelBtnList[v.ID] = node

                    local node = self:createLevelBtn(UI.LevelSelectEventBtn, self._heroLayout, v2, tonumber(posArray[1]), tonumber(posArray[2]), "ui_selectfloor_round.png", self.data.oldOpenLevel, self.data.curOpenLevel, clickCallback, animEndCallback, animStartCallback)
                    self.specialEventIconLayout[v.ID] = node
                    node:setVisible(false)
                    node:disable()
                    self:refreshOneEventIcon(v.ID)
                end
                local posArray = string.split(v.namecoordinate[1], ",")
                local plotName = UI.Text:create()
                plotName:init(v.name, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_230_230_230)
                plotName:useDefaultOutLineShadowStyle()
                plotName:leftBottom(tonumber(posArray[1]) - plotName:getContentSize().width / 2, tonumber(posArray[2]))
                self._heroLayout:addChild(plotName, 2)     
            end
        end
        self.defaultHeroSelectIcon:selected()
    end
end


function LevelSelect:refreshCaveMode(isShowEnter)
    if self.curCaveMode ~= nil and self.curCaveMode == self.data.caveMode then
        return
    end
    self.curCaveMode = self.data.caveMode
    if self:checkSelfHaveHeroMode() then--self.layerType == Game.LevelSelectLayerType.Normal_Plot then
        local targetTime = MasterDataManager:getHeroCaveSpecialEnventRemianTime()
        if self.layerType == Game.LevelSelectLayerType.Titan_Road then
            targetTime = MasterDataManager:getTitanHeroCaveSpecialEnventRemianTime()
        end
        local refresWaitingTime = targetTime + GameManager:getEPOCHTime() - GameManager:getNowServerTime()
        -- local isRequest = false
        if refresWaitingTime <= 0 then
            local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
            if unLockHeroMode then
                Net.NetRoleSystem:refreshHeroSpecialEventRequest(true, self.curCaveMode)
            end
        end
    end
    self:refreshFloatCloud(isShowEnter, function()
        if self.curCaveMode == PublicDefine.CAVE_MODE.MODE_NORMAL 
        or self.curCaveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES 
        or self.curCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
        or self.curCaveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
            if self.mBtnChangeEventMode then
                self.mBtnChangeEventMode:hide()
            end
            if self._heroScrollView then
                self._heroScrollView:centerUp(-LayerSize.height * 2) 
            end
            self._scrollView:centerUp(10)
            self:showOpenAnimation(self.data.oldOpenLevel, self.data.curOpenLevel)
        elseif self.curCaveMode == PublicDefine.CAVE_MODE.MODE_HERO or self.curCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            if self.mBtnChangeEventMode then
                self.mBtnChangeEventMode:show()
            end
            if self._heroScrollView then
                self._heroScrollView:centerUp(10) 
            end
            self._scrollView:centerUp(-LayerSize.height * 2)
        end
    end)
    if self.selectedIcon ~= nil then
        self.selectedIcon:unLocked()
    end
    print("------refreshCaveMode--------defaultNomalSelectIcon = ", self.defaultNomalSelectIcon)
    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL 
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES 
    or self.curCaveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
    or self.curCaveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        if self.selectedIcon and self.defaultNomalSelectIcon ~= nil then
            self.selectedIcon = self.defaultNomalSelectIcon
        end
        if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
            self.mBtnDifficulty:setAnimation("selectfloor_desert", false)
            self.mBtnDifficulty:addAnimation("idle1_desert", true)
            self.modeNameBgAnim:setAnimation("selectfloor_desert", false)
            self.modeNameBgAnim:addAnimation("idle1_desert", true)
            -- self.singlePlayBtn:setSelected("ui_btn_desert_single_1.png")
            -- self.teamPlayBtn:setSelected("ui_btn_desert_many_1.png")
            self:changeCaveMode(PublicDefine.CAVE_MODE.MODE_DESERT_EYES)
            self.modeName:setFontColor(UI.FONT_COLOR_255_153_51)
        elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
            if isShowEnter then
                self.mBtnDifficulty:setAnimation("hero_ordi", false)
                self.mBtnDifficulty:addAnimation("idle1_ordi", true)
                self.modeNameBgAnim:setAnimation("hero_ordi", false)
                self.modeNameBgAnim:addAnimation("idle1_ordi", true)
        
            else
                self.mBtnDifficulty:setAnimation("idle1_ordi", true)
                self.modeNameBgAnim:setAnimation("idle1_ordi", true)
                self.modeName:setText(string.format(UI.TEXT_110001,  self.selectedIcon:getTag()))
                self.modeName:setFontColor(UI.FONT_COLOR_157_221_231)
                -- self.singlePlayBtn:setSelected("ui_btn_plot_single_1.png")
                -- self.teamPlayBtn:setSelected("ui_btn_plot_many_1.png")
                self:changeCaveMode(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD)
                if self.mBtnRefresh then
                    self.mBtnRefresh:hide()
                    self.remainTime:hide()
                end
            end
        elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
            self.mBtnDifficulty:setAnimation("selectfloor_desert", false)
            self.mBtnDifficulty:addAnimation("idle1_desert", true)
            self.modeNameBgAnim:setAnimation("selectfloor_desert", false)
            self.modeNameBgAnim:addAnimation("idle1_desert", true)
            -- self.singlePlayBtn:setSelected("ui_btn_desert_single_1.png")
            -- self.teamPlayBtn:setSelected("ui_btn_desert_many_1.png")
            self:changeCaveMode(PublicDefine.CAVE_MODE.MODE_DRIED_SPRING)
            self.modeName:setFontColor(UI.FONT_COLOR_255_153_51)
        else
            if isShowEnter then
                self.mBtnDifficulty:setAnimation("hero_ordi", false)
                self.mBtnDifficulty:addAnimation("idle1_ordi", true)
                self.modeNameBgAnim:setAnimation("hero_ordi", false)
                self.modeNameBgAnim:addAnimation("idle1_ordi", true)
        
            else
                self.mBtnDifficulty:setAnimation("idle1_ordi", true)
                self.modeNameBgAnim:setAnimation("idle1_ordi", true)
                self.modeName:setText(string.format(UI.TEXT_110001,  self.selectedIcon:getTag()))
                self.modeName:setFontColor(UI.FONT_COLOR_157_221_231)
                -- self.singlePlayBtn:setSelected("ui_btn_plot_single_1.png")
                -- self.teamPlayBtn:setSelected("ui_btn_plot_many_1.png")
                self:changeCaveMode(PublicDefine.CAVE_MODE.MODE_NORMAL)
                if self.mBtnRefresh then
                    self.mBtnRefresh:hide()
                    self.remainTime:hide()
                end
            end
        end
       
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        if self.selectedIcon and self.defaultHeroSelectIcon ~= nil then
            self.selectedIcon = self.defaultHeroSelectIcon
        end
        if isShowEnter then
            self.mBtnDifficulty:setAnimation("ordi_hero", false)
            self.mBtnDifficulty:addAnimation("idle1_hero", true)
            self.modeNameBgAnim:setAnimation("ordi_hero", false)
            self.modeNameBgAnim:addAnimation("idle1_hero", true)
        else
            self.mBtnDifficulty:setAnimation("idle1_hero", true)
            self.modeNameBgAnim:setAnimation("idle1_hero", true)
            self.modeName:setText(LanguageManager:getInstance():getLocalString(self.gateConfig.name))
            self.modeName:setFontColor(UI.FONT_COLOR_247_172_53)
            -- self.singlePlayBtn:setSelected("ui_btn_hero_single_1.png")
            -- self.teamPlayBtn:setSelected("ui_btn_hero_many_1.png")
            self:changeCaveMode(PublicDefine.CAVE_MODE.MODE_HERO)
            self.mBtnRefresh:setVisible(self.isShowEvent)
            self.remainTime:setVisible(self.isShowEvent)
        end
        local targetTime = MasterDataManager:getHeroCaveSpecialEnventRemianTime()
        local refresWaitingTime = targetTime + GameManager:getEPOCHTime() - GameManager:getNowServerTime()
        local showText = nil
        if refresWaitingTime > 0 then
            showText = AvalonUtil:getFullFormatTime(targetTime, true, false)
        end
        if showText == nil then
            self.remainTime:setText("00:00")
        else
            self.remainTime:setText(string.format("%s", showText))
        end  
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        if self.selectedIcon and self.defaultHeroSelectIcon ~= nil then
            self.selectedIcon = self.defaultHeroSelectIcon
        end
        if isShowEnter then
            self.mBtnDifficulty:setAnimation("ordi_hero", false)
            self.mBtnDifficulty:addAnimation("idle1_hero", true)
            self.modeNameBgAnim:setAnimation("ordi_hero", false)
            self.modeNameBgAnim:addAnimation("idle1_hero", true)
        else
            self.mBtnDifficulty:setAnimation("idle1_hero", true)
            self.modeNameBgAnim:setAnimation("idle1_hero", true)
            self.modeName:setText(LanguageManager:getInstance():getLocalString(self.gateConfig.name))
            self.modeName:setFontColor(UI.FONT_COLOR_247_172_53)
            -- self.singlePlayBtn:setSelected("ui_btn_hero_single_1.png")
            -- self.teamPlayBtn:setSelected("ui_btn_hero_many_1.png")
            self:changeCaveMode(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO)
            self.mBtnRefresh:setVisible(self.isShowEvent)
            self.remainTime:setVisible(self.isShowEvent)
        end
        local targetTime = MasterDataManager:getTitanHeroCaveSpecialEnventRemianTime()
        local refresWaitingTime = targetTime + GameManager:getEPOCHTime() - GameManager:getNowServerTime()
        local showText = nil
        if refresWaitingTime > 0 then
            showText = AvalonUtil:getFullFormatTime(targetTime, true, false)
        end
        if showText == nil then
            self.remainTime:setText("00:00")
        else
            self.remainTime:setText(string.format("%s", showText))
        end        
    end
    self.selectedIcon:selected(true)
    LevelSelectUtil:getInstance().mSelectLevel = self.selectedIcon:getTag()

    if self.modeChangeTitleBtn then
        self.modeChangeTitleBtn:setVisible(not self:checkIsHeroMode())
        if self.isFirst then
            self.modeChangeTitleBtn:setVisible(false)
        end
    end
end


-- 进入洞穴反馈消息
function LevelSelect:enterCaveResult(data)
    if(data and data.result ~= "EnterCaveSceneResult_Succeed") then 
        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.EnterCaveSceneResult", data.result))
    end
    UI.WaitingLayer:hideWaiting()
end

function LevelSelect:clickClose(showMainUI)
    self:openShowAction(false)
    local panel = nil
    if mvc and mvc.panelMonitor then
        panel = mvc.panelMonitor:getTopZOrderPanel(mvc.VIEW_TYPE.PANEL)
        mvc.panelMonitor:showTopPanel()
    end
    if(showMainUI ~= false and panel == nil) then
        Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
    end
end

-- 点击外部区域的处理器
local function onTouchDialogOutsizeHandler(self, _, _, touchPosition)
    if self.mBClick == true then
        if self.leftLayer and self.leftLayer:checkTouch(touchPosition) then
            return
        end
        self:clickClose(true)
    end
end

function LevelSelect:unlockButtons()
    self.lockAllBtn = false
end

-- 注册监听事件
function LevelSelect:registerListener()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LEVEL_SELECT_ENTER_CAVE, self, self.enterCaveResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
    Avalon.MessageCenter:bind(AvalonMessage.MC_CAVE_HREO_DATA_REFRESH, self, self.refreshSpecialEventIcon)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LEVEL_SELECT_UNLOCK_BTN, self, self.unlockButtons)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_FIRST_PASS, self, self.firstPassCallback)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_CAVE_SWITCH_CAVE_RESET_DATA, self, self.resetCaveDataByLayerType)
    
end


-- 注销监听事件
function LevelSelect:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LEVEL_SELECT_ENTER_CAVE, self, self.enterCaveResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_FUNCTION_UNLOCK, self, self.refreshTabState)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_CAVE_HREO_DATA_REFRESH, self, self.refreshSpecialEventIcon)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LEVEL_SELECT_UNLOCK_BTN, self, self.unlockButtons)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_FIRST_PASS, self, self.firstPassCallback)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_CAVE_SWITCH_CAVE_RESET_DATA, self, self.resetCaveDataByLayerType)
end

--刷新标签按钮  是否灰调或点亮  是否播放解锁动画 是否播放new动画
function LevelSelect:refreshTabState()
    self:refreshTeamBtnState()
    local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    local isShowNew = Game.FunctionUnlockManager:getInstance():isShowNewAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    if unLockHeroMode and isShowNew and self:checkSelfHaveHeroMode() then--self.layerType == Game.LevelSelectLayerType.Normal_Plot then
        local action = ToolsUtil:playNewAction(self.mBtnDifficulty, 0.7)
        if action ~= nil then
            action:leftUp(215, 0)
        end
    else
        ToolsUtil:removeNewAction(self.mBtnDifficulty)
    end

end

-- function LevelSelect:playModelBtnClick(node)
--     if self.lockAllBtn then
--         print("---LevelSelect:playModelBtnClick but self.lockAllBtn is true")
--         return
--     end
--     if node == self.singlePlayBtn then
--         self:selectButton(PublicDefine.GAME_MODE.MODE_SOLO)
--     else
--         if TeamDataManager:getPunishmentState() >= 2 then
--             UI.ScrollBar:createByText(string.format(UI.TEXT_110072, ConfigManager:getPunishmentTime() / 60))
--             return
--         end
--         Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
--         self:selectButton(PublicDefine.GAME_MODE.MODE_TEAM)
--     end
-- end

function LevelSelect:selectButton(gameMode)
    -- self.singlePlayBtn:setBtnStatus(ButtonState.NORMAL)
    -- if not self.teamPlayBtn:isDisable() then
    --     self.teamPlayBtn:setBtnStatus(ButtonState.NORMAL)
    -- end
    -- if btnId == PublicDefine.GAME_MODE.MODE_SOLO then
    --     self.singlePlayBtn:setBtnStatus(ButtonState.ACTIVE)
    -- else
    --     if not self.teamPlayBtn:isDisable() then
    --         self.teamPlayBtn:setBtnStatus(ButtonState.ACTIVE)
    --     end
    -- end
    -- LevelSelectUtil:getInstance():setPattern(btnId)

    self:refreshGameModeBtnCheckState(gameMode)
    LevelSelectUtil:getInstance():setPattern(gameMode)
    self:refreshNotice(gameMode)
end

function LevelSelect:refreshNotice(btnId)
    -- add by zp 单人挑战更新个人进度提示语言
    if(self._noticeImageBg) then
        if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL and (btnId == nil or btnId ~= PublicDefine.GAME_MODE.MODE_SOLO) then 
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

function LevelSelect:startGame()
    -- 英雄模式+事件有次数限制, 不进行限制; 不为英雄模式+事件, 限制进洞.
    require "app.utils.AntiAddictionUtil"
    if (not (self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO and self.isShowEvent) and 
        not AntiAddictionUtil:isAbleToEnterCave()) 
    then
        require "app.ui.common.Dialog.ScrollBar"
        UI.ScrollBar:createByTextID(1170192)
        return
    end

    if self.lockAllBtn then
        print("--LevelSelect:startGame but self.lockAllBtn is true")
        return
    end

    local entryLevelList = string.split(self.gateConfig.entryLevel, ";")
    if table.nums(entryLevelList) > 0 and entryLevelList[self.gateConfigIndex] and entryLevelList[self.gateConfigIndex] ~= "" then
        local masterData = RoleDataManager:getMaster()
        local roleLv = masterData:getLevel()
        if tonumber(entryLevelList[self.gateConfigIndex]) > roleLv then
            local level, reinLv = RoleDataManager:getUIShowLvByItemData(tonumber(entryLevelList[self.gateConfigIndex]))
            local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
            UI.ScrollBar:createByText(string.format(UI.TEXT_224405, showLv))
            return
        end
    end


    -- 检查答题限制,如果返回true 说明是属于小黑屋,不能进入战斗
    if not AnswerDataManager:canEnterCave() then
        local time = AnswerDataManager:getNextEnterCaveSecRemind()
        local h = math.floor( time / 3600 )
        local m = math.ceil((time - h * 3600) / 60)
        UI.ConfirmDialog.showConfrimOnly(string.format(LanguageManager:getInstance():getLocalString(1170210),h,m), nil, nil, nil, nil)
        return
    end

    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DesertEye) == false then 
            UI.ScrollBar:createByTextID(1170189)
            return
        end
    end

    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_TitanRoad) == false then 
            UI.ScrollBar:createByTextID(1170189)
            return
        end
    end

    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_DriedSpring) == false then 
            UI.ScrollBar:createByTextID(1170189)
            return
        end
    end

    local function clickFunc() 
        if self:checkIsHeroMode() and self.isShowEvent then 
            local schemeExploreCount = MasterDataManager:getHeroCaveSchemeExploreCount() 
            if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                schemeExploreCount = MasterDataManager:getTitanHeroCaveSchemeExploreCount() 
            end
            if schemeExploreCount <= 0 then
                UI.ScrollBar:createByText(UI.TEXT_1212058)
                return
            end
            local _, isUsed = MasterDataManager:getHeroCaveSpecialEnventBySceneId(self.gateConfig.ID)
            if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                _, isUsed = MasterDataManager:getTitanHeroCaveSpecialEnventBySceneId(self.gateConfig.ID)
            end
            if isUsed then
                UI.ConfirmDialog.show(UI.TEXT_1212057, function()
                    if self.selectedIcon and self.selectedIcon.showStartAnimation then
                        self.lockAllBtn = true
                        self.mBClick = false
                        self:handleStartGame()
                        -- self.selectedIcon:showStartAnimation()
                    end
                end)
                return
            end
        end
        if self.selectedIcon and self.selectedIcon.showStartAnimation then
            self.lockAllBtn = true
            self.mBClick = false
            self:handleStartGame()
            -- self.selectedIcon:showStartAnimation()
        end
    end

    -- 如果 worldboss 已报名，提醒一次
    if mvc.worldBossModel:checkCanEnterOther() then
        clickFunc()
    else
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
            UI.TEXT_1212663,
            function()
                Net.NetActivitySystem:requestWorldbossQuitRoom()
                clickFunc()
            end
        )
    end
end

function LevelSelect:handleStartGame()
    -- if(mvc.expeditionModel:getExpeditionStatus()) then
    --     UI.ConfirmDialog.show(UI.TEXT_1212586, function()
    --         Net.NetNPCSystem:reqStopExpedition()
    --         self.selectedIcon:showStartAnimation()
    --     end, function()
    --         self.lockAllBtn = false
    --         self.mBClick = true
    --     end)
    -- else 
        self.selectedIcon:showStartAnimation()
    -- end
end

function LevelSelect:showRewardLayer()
    self:refreshStartBtnTip(self.startBtn)
    local gateId = LevelSelectUtil:getInstance().mSelectLevel
    local list = ConfigManager:getAllLevelSelectDataByType(self.data.caveMode)
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
        return
    end
    self.gateConfig = gateConfig
    self.gateConfigIndex = index   
    local rewardNode = self.rightLayer:getChildByName("RewardNode")
    if rewardNode then
        rewardNode:removeFromParent(true)
    end
    local winSize = cc.Director:getInstance():getWinSize()
    local rewardNode = UI.RewardPreViewUtil:create()
    rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL 
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES 
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        rewardNode:init(nil, 8, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true)
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
        if self.isShowEvent then
            rewardNode:init(nil, 5, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true)
        else
            rewardNode:init(nil, 8, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true)
        end
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        if self.isShowEvent then
            rewardNode:init(nil, 5, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true)
        else
            rewardNode:init(nil, 8, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true)
        end
    end
    rewardNode:leftBottom(30, 0)
    if (self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) and self.isShowEvent then
        local idList = self:getSpecialEventReward(gateConfig, index)
        for k, v in pairs(idList) do 
            rewardNode:addGoodsId(tonumber(v), 0)
        end
    else
        local rewardData = gateConfig.BoxDrop[index]
        local idList = string.split(rewardData, ",")
        for k, v in pairs(idList) do 
            rewardNode:addGoodsId(tonumber(v), 0)
        end
    end
    rewardNode:showGoodsView()
    rewardNode:setName("RewardNode")
    self.rightLayer:addChild(rewardNode)

    local entryLevelList = string.split(gateConfig.entryLevel, ";")
    if table.nums(entryLevelList) > 0 and entryLevelList[index] and entryLevelList[index] ~= "" then
        local level, reinLv = RoleDataManager:getUIShowLvByItemData(tonumber(entryLevelList[index]))
        local showLv = reinLv > 0 and string.format(UI.TEXT_224311, reinLv, level) or level
        self.levelLimitText:setText(string.format(UI.TEXT_224403, showLv))
    end
    
    self.descriptionLayout:removeAllChildren()
    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL 
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES 
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
    or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
        self.modeName:setText(string.format(UI.TEXT_110001, self.selectedIcon:getTag()))
        local description = UI.Text:create()
        description:init(LanguageManager:getInstance():getLocalString(self.gateConfig.levelDescription[index]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        description:center()
        description:setWidth(226)
        self.descriptionLayout:addChild(description)
        self.descriptionLayout:setSize(description:getContentSize().width, description:getContentSize().height)
        if self.heroRewardLayout then
            self.heroRewardLayout:hide()
        end
        self.rewardTip:centerBottom(80)
        local lineWidth = (self.rightLayer:getContentSize().width - self.rewardTip:getContentSize().width - 240) / 2
        self.lineL:setContentSize(lineWidth, 1)
        self.lineL:setPosition(60, 92)
        self.lineR:setContentSize(lineWidth, 1)
        self.lineR:setPosition(self.rightLayer:getContentSize().width - lineWidth - 70,92)
        self.rewardCapR:rightBottom(10, 0)
        -- self.rewardCapL:leftBottom(6, 0)
    elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        self.modeName:setText(LanguageManager:getInstance():getLocalString(self.gateConfig.name))
        local eventList, isUsed = MasterDataManager:getHeroCaveSpecialEnventBySceneId(self.gateConfig.ID)
        if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            eventList, isUsed = MasterDataManager:getTitanHeroCaveSpecialEnventBySceneId(self.gateConfig.ID)
        end

        if #eventList > 0 and self.isShowEvent and not isUsed then
            local boxLevel = ConfigManager:getEventBoxLevel(eventList)
            local pointList = {}
            local desList = {}
            local layoutHeight = 5
            for i = 1, #eventList, 1 do
                local data = ConfigManager:getSpecialEventDataById(eventList[i])
                local picDes = cc.Sprite:createWithSpriteFrameName("ui_selectfloor_hero_diamond.png");
                self.descriptionLayout:addChild(picDes,7)
                picDes:setColor(cc.c3b(41, 41, 45))
                table.insert(pointList, picDes)
                local txtDes2 = UI.Text:create()
                txtDes2:init(data.name .. ":".. data.description, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
                txtDes2:setLineSpacing(-2)
                txtDes2:setWidth(214)
                self.descriptionLayout:addChild(txtDes2, 6)  
                table.insert(desList, txtDes2)      
                layoutHeight = layoutHeight + txtDes2:getContentSize().height + 5  
                -- txtDes2:enableDebugDraw()
                txtDes2:autoAdapt()
            end
            self.descriptionLayout:setSize(226, layoutHeight)
            local height = 5
            for k, v in ipairs(desList) do
                local point = pointList[k]
                point:setPosition(6, self.descriptionLayout:getContentSize().height - height - 10)
                v:leftUp(14, height)
                height = height + v:getContentSize().height + 5
            end
            if self.heroRewardLayout then
                self.heroRewardLayout:show()
            end
            self.rewardTip:leftBottom((300 - self.rewardTip:getContentSize().width) / 2 + 72, 80)
            local lineWidth = (300 - self.rewardTip:getContentSize().width - 100) / 2
            self.lineL:setContentSize(lineWidth, 1)
            self.lineL:setPosition(self.rewardTip:getPositionX() - lineWidth - 20, 92)
            self.lineR:setContentSize(lineWidth, 1)
            self.lineR:setPosition(self.rewardTip:getPositionX() + self.rewardTip:getContentSize().width + 20,92)
            self.rewardCapR:rightBottom(246, 0)
            
            local remainCount = MasterDataManager:getHeroCaveSchemeExploreCount()
            if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                remainCount = MasterDataManager:getTitanHeroCaveSchemeExploreCount()
            end
            local totalCount = tonumber(ConfigManager:getGeneralForKey("heroCaveSchemeExploreADay"))
            if remainCount > 0 then
                self:refreshStartBtnTip(self.startBtn, string.format("%d/%d", remainCount, totalCount), UI.FONT_COLOR_36_181_118)
            else
                self:refreshStartBtnTip(self.startBtn, string.format("%d/%d", remainCount, totalCount), UI.FONT_COLOR_80_5_5)
            end
        elseif #eventList > 0 and self.isShowEvent and isUsed then
            local description = UI.Text:create()
            description:init(LanguageManager:getInstance():getLocalString(self.gateConfig.levelDescription[index]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            description:center()
            description:setWidth(226)
            self.descriptionLayout:addChild(description)
            self.descriptionLayout:setSize(description:getContentSize().width, description:getContentSize().height)

            if self.heroRewardLayout then
                self.heroRewardLayout:show()
            end
            self.detailedScrollView:scrollToTop()

            self.rewardTip:leftBottom((300 - self.rewardTip:getContentSize().width) / 2 + 72, 80)
            local lineWidth = (300 - self.rewardTip:getContentSize().width - 100) / 2
            self.lineL:setContentSize(lineWidth, 1)
            self.lineL:setPosition(self.rewardTip:getPositionX() - lineWidth - 20, 92)
            self.lineR:setContentSize(lineWidth, 1)
            self.lineR:setPosition(self.rewardTip:getPositionX() + self.rewardTip:getContentSize().width + 20,92)
            self.rewardCapR:rightBottom(246, 0)
            
            local remainCount = MasterDataManager:getHeroCaveSchemeExploreCount()
            if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                remainCount = MasterDataManager:getTitanHeroCaveSchemeExploreCount() 
            end
            local totalCount = tonumber(ConfigManager:getGeneralForKey("heroCaveSchemeExploreADay"))
            if remainCount > 0 then
                self:refreshStartBtnTip(self.startBtn, string.format("%d/%d", remainCount, totalCount), UI.FONT_COLOR_36_181_118)
            else
                self:refreshStartBtnTip(self.startBtn, string.format("%d/%d", remainCount, totalCount), UI.FONT_COLOR_80_5_5)
            end
        else
            local description = UI.Text:create()
            description:init(LanguageManager:getInstance():getLocalString(self.gateConfig.levelDescription[index]), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
            description:center()
            description:setWidth(226)
            self.descriptionLayout:addChild(description)
            self.descriptionLayout:setSize(description:getContentSize().width, description:getContentSize().height)
            if self.heroRewardLayout then
                self.heroRewardLayout:hide()
            end
            self.rewardTip:centerBottom(80)
            local lineWidth = (self.rightLayer:getContentSize().width - self.rewardTip:getContentSize().width - 240) / 2
            self.lineL:setContentSize(lineWidth, 1)
            self.lineL:setPosition(60, 92)
            self.lineR:setContentSize(lineWidth, 1)
            self.lineR:setPosition(self.rightLayer:getContentSize().width - lineWidth - 70,92)
            self.rewardCapR:rightBottom(10, 0)
        end
    end
end



function LevelSelect:spinePlayCallback(event, param)
    if (event and event.eventData and event.eventData.name == "change") then
        self:changeCaveMode(self.data.caveMode)
        if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_NORMAL then
            self.modeName:setFontColor(UI.FONT_COLOR_157_221_231)
            self.singlePlayBtn:setSelected("ui_btn_plot_single_1.png")
            self.teamPlayBtn:setSelected("ui_btn_plot_many_1.png")
            if self.mBtnRefresh then
                self.mBtnRefresh:hide()
                self.remainTime:hide()
            end
        elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO then
            self.modeName:setFontColor(UI.FONT_COLOR_247_172_53)
            self.singlePlayBtn:setSelected("ui_btn_hero_single_1.png")
            self.teamPlayBtn:setSelected("ui_btn_hero_many_1.png")
            self.mBtnRefresh:setVisible(self.isShowEvent)
            self.remainTime:setVisible(self.isShowEvent)
        elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DESERT_EYES then
            self.singlePlayBtn:setSelected("ui_btn_desert_single_1.png")
            self.teamPlayBtn:setSelected("ui_btn_desert_many_1.png")
        elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD then
            self.singlePlayBtn:setSelected("ui_btn_desert_single_1.png")
            self.teamPlayBtn:setSelected("ui_btn_desert_many_1.png")
            if self.mBtnRefresh then
                self.mBtnRefresh:hide()
                self.remainTime:hide()
            end
        elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
            self.modeName:setFontColor(UI.FONT_COLOR_247_172_53)
            self.singlePlayBtn:setSelected("ui_btn_hero_single_1.png")
            self.teamPlayBtn:setSelected("ui_btn_hero_many_1.png")
            self.mBtnRefresh:setVisible(self.isShowEvent)
            self.remainTime:setVisible(self.isShowEvent)
        elseif self.data.caveMode == PublicDefine.CAVE_MODE.MODE_DRIED_SPRING then
            self.singlePlayBtn:setSelected("ui_btn_desert_single_1.png")
            self.teamPlayBtn:setSelected("ui_btn_desert_many_1.png")
        end
        self:showRewardLayer()
        self:refreshNotice(LevelSelectUtil:getInstance().mPattern)
        self:refreshFisrtPassPanel(self.fisrtPassPanel, self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, LevelSelectUtil:getInstance().mSelectLevel)
    end
end

function LevelSelect:refreshTeamBtnState()
    self:refreshGameModeState()

    -- if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
    --     self.teamPlayBtn:enable()
    --     if Game.FunctionUnlockManager:getInstance():isShowNewAction(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
    --         ToolsUtil:playNewAction(self.teamPlayBtn, 0.8)
    --     else
    --         ToolsUtil:removeNewAction(self.teamPlayBtn)
    --     end
    -- else
    --     self.teamPlayBtn:disable()
    -- end
end

function LevelSelect:firstPassCallback(data)
    if data.mode == self.data.caveMode then
        self:refreshFisrtPassPanel(self.fisrtPassPanel, self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, LevelSelectUtil:getInstance().mSelectLevel)
    end
end


--begin--普通剧情关卡的英雄模式的特殊事件相关代码-----
function LevelSelect:refreshItemButton()
    if not self:checkSelfHaveHeroMode() then--self.layerType ~= Game.LevelSelectLayerType.Normal_Plot then
        print("--refreshItemButton--self.layerType -- = ", self.layerType )
        return
    end
    local itemUsedCount = MasterDataManager:getHeroCaveRefreshCountUsedCount() + 1
    if self.layerType == Game.LevelSelectLayerType.Titan_Road then
        itemUsedCount = MasterDataManager:getTitanHeroCaveRefreshCountUsedCount() + 1
    end
    local itemCostList = string.split(ConfigManager:getGeneralForKey("manualSpecialEventRefreshCostGoodsNum"), ";")
    local showNumber = tonumber(itemCostList[itemUsedCount] or itemCostList[1])
    local itemIcon = self.mBtnRefresh:getChildByName("ItemIcon")
    local itemCost = itemIcon:getChildByName("ItemCost")
    if showNumber then
        if(itemIcon) then
            itemIcon:show()
        end
        if(itemCost) then
            itemCost:setText(string.format("%d", showNumber))
        end
        self.mBtnRefresh._text:centerLeft(10)
    end
    --道具不足显示红色
    local itemId = tonumber(ConfigManager:getGeneralForKey("manualSpecialEventRefreshCostGoodsID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(itemId, true)
    --次数不足显示灰色--且具中
    if itemUsedCount > #itemCostList then
        self.mBtnRefresh:disable()
        itemCost:hide()
        if(itemIcon) then
            itemIcon:hide()
        end
        self.mBtnRefresh._text:center()
    else
        self.mBtnRefresh:enable()
        itemCost:show()
        self.mBtnRefresh._text:centerLeft(10)
        if showNumber > goodNumber then
            if(itemCost) then
                itemCost:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            end
        else
            if(itemCost) then
                itemCost:setFontColor(UI.FONT_COLOR_50_50_44)
            end
        end
    end
end

function LevelSelect:refreshSpecialEventIcon(data)
    if not self:checkSelfHaveHeroMode() then--self.layerType ~= Game.LevelSelectLayerType.Normal_Plot then
        print("---refreshSpecialEventIcon-self.layerType -- = ", self.layerType )
        return
    end
    if self.caveEnterLayer then
        self.caveEnterLayer:hiddenLayer()
    end
    UI.WaitingLayer:hideWaiting()
    local remainCount =  data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO and MasterDataManager:getHeroCaveSchemeExploreCount() or MasterDataManager:getTitanHeroCaveSchemeExploreCount()
    local totalCount = tonumber(ConfigManager:getGeneralForKey("heroCaveSchemeExploreADay"))
    if remainCount > 0 then
        self:refreshStartBtnTip(self.startBtn, string.format("%d/%d", remainCount, totalCount), UI.FONT_COLOR_36_181_118)
    else
        self:refreshStartBtnTip(self.startBtn, string.format("%d/%d", remainCount, totalCount), UI.FONT_COLOR_80_5_5)
    end
    self:refreshItemButton()
    self:refreshFloatCloud(true, function()
        --特殊事件
        local curHeroMode = self.layerType == Game.LevelSelectLayerType.Normal_Plot and PublicDefine.CAVE_MODE.MODE_HERO or PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO
        local heroPlotList = ConfigManager:getAllLevelSelectDataByType(curHeroMode)
        for k, v in pairs(heroPlotList) do
            self:refreshOneEventIcon(v.ID)
        end
        self:showRewardLayer()
    end)  
end

function LevelSelect:refreshOneEventIcon(sceneId)
    if not self:checkSelfHaveHeroMode() then--self.layerType ~= Game.LevelSelectLayerType.Normal_Plot then
        print("---refreshOneEventIcon-self.layerType -- = ", self.layerType )
        return
    end
    local icon = self.specialEventIconLayout[sceneId]
    local eventData, isUsed = MasterDataManager:getHeroCaveSpecialEnventBySceneId(sceneId)

    if self.layerType == Game.LevelSelectLayerType.Titan_Road then
        eventData, isUsed = MasterDataManager:getTitanHeroCaveSpecialEnventBySceneId(sceneId)
    end

    local boxLevel = ConfigManager:getEventBoxLevel(eventData)
    local boxImgData = Game.SpecialBoxImageName[boxLevel]
    if isUsed then
        icon:addBoxBg(boxImgData.used, boxImgData.used, true, nil, boxLevel)
    else
        icon:addBoxBg(boxImgData.normal, boxImgData.open, false, nil, boxLevel)
    end
end


function LevelSelect:getSpecialEventReward(gateConfig, index)
    if not self:checkSelfHaveHeroMode() then--self.layerType ~= Game.LevelSelectLayerType.Normal_Plot then
        print("---getSpecialEventReward-self.layerType -- = ", self.layerType )
        return
    end
    local sceneId = gateConfig.ID
    local eventList, isUsed = MasterDataManager:getHeroCaveSpecialEnventBySceneId(sceneId)
    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        eventList, isUsed = MasterDataManager:getTitanHeroCaveSpecialEnventBySceneId(sceneId)
    end
    local eventSize = #eventList
    local goodsDataList = {}
    if eventSize > 0 and not isUsed then
        -- 计算事件箱子的等级
        local boxLevel = ConfigManager:getEventBoxLevel(eventList)
        local rewardData = nil
        if boxLevel == 1 then
            rewardData = self.gateConfig.BoxDrop1[1]
        elseif boxLevel == 2 then
            rewardData = self.gateConfig.BoxDrop2[1]
        elseif boxLevel == 3 then
            rewardData = self.gateConfig.BoxDrop3[1]
        end
        if rewardData then
            local idList = string.split(rewardData, ",")
            
            for k, v in pairs(idList) do
                table.insert(goodsDataList, tonumber(v))
            end
        end
    else
        local rewardData = gateConfig.BoxDrop[index]
        goodsDataList = string.split(rewardData, ",")
    end
    return goodsDataList
end

--刷新特殊事件
function LevelSelect:onRefreshClick()
    if not self:checkSelfHaveHeroMode() then--self.layerType ~= Game.LevelSelectLayerType.Normal_Plot then
        print("---onRefreshClick-self.layerType -- = ", self.layerType )
        return
    end
    if self.lockAllBtn then
        print("-----LevelSelect:onRefreshClick but self.lockAllBtn is true")
        return
    end
    if RoleBehaviorManager:refreshSpecialEventCheck() then 
        printWarn(" been blocked when refreshing special event !")
        return
    end
    local itemUsedCount = MasterDataManager:getHeroCaveRefreshCountUsedCount() + 1
    if self.layerType == Game.LevelSelectLayerType.Titan_Road then
        itemUsedCount = MasterDataManager:getTitanHeroCaveRefreshCountUsedCount() + 1
    end
    local itemCostList = string.split(ConfigManager:getGeneralForKey("manualSpecialEventRefreshCostGoodsNum"), ";")
    local showNumber = tonumber(itemCostList[itemUsedCount] or itemCostList[1])
   
    local itemId = tonumber(ConfigManager:getGeneralForKey("manualSpecialEventRefreshCostGoodsID"))
    local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(itemId, true)
    if showNumber > goodNumber then
        local goodsData = GoodsDataManager:createLocalGoodsData(itemId)
        local name = "..."
        if(goodsData) then
            name = goodsData:getName()
        end
        UI.ScrollBar:createByText(string.format(UI.TEXT_1170948, name))
        return
    end
    if itemUsedCount > #itemCostList then
        UI.ScrollBar:createByText(UI.TEXT_1170947)
        return
    end
    
    if MasterDataManager:isNullSpecialEnvent() then
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetRoleSystem:refreshHeroSpecialEventRequest(false, self.data.caveMode)
    else
        UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_1170950, function()
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetRoleSystem:refreshHeroSpecialEventRequest(false, self.data.caveMode)
        end)
    end
end

--选择难度
function LevelSelect:onSelectDifficulty(tag,sender)
    if not self:checkSelfHaveHeroMode() then--self.layerType ~= Game.LevelSelectLayerType.Normal_Plot then
        print("---onSelectDifficulty-self.layerType -- = ", self.layerType )
        return
    end
    if self.lockAllBtn == false and self.mBClick == true  and not self.mLockDiffSelect then
        --开启难度选择界面
        local pLevelSelectDifficulty = UI.LevelSelectDifficulty:create(function(caveMode)
            local remainCount = MasterDataManager:getHeroCaveSchemeExploreCount()
            if caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
                remainCount = MasterDataManager:getTitanHeroCaveSchemeExploreCount() 
            end

            self.data.caveMode = caveMode
            self:refreshCaveMode(true)
            self:refreshTeamBtnState()
            if (self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO or self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO) and remainCount > 0 then
                self.isShowEvent = true
                self:_changeEventMode()
            end
        end)
        pLevelSelectDifficulty:center()
        self:getParent():addChild(pLevelSelectDifficulty,UI_ZORDER.ACTIVITY)
        Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
    end
end

--在英雄模式线 选择是否显示特殊事件
function LevelSelect:onChangeEventMode()
    if not self:checkSelfHaveHeroMode() then--self.layerType ~= Game.LevelSelectLayerType.Normal_Plot then
        print("---onChangeEventMode-self.layerType -- = ", self.layerType )
        return
    end
    if self.lockAllBtn then
        print("-----LevelSelect:onChangeEventMode but self.lockAllBtn is true")
        return
    end
    if self.data.caveMode ~= PublicDefine.CAVE_MODE.MODE_HERO and self.data.caveMode ~= PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        print("not hero mode:", self.data.caveMode)
        return
    end
    self.isShowEvent = not self.isShowEvent
    self:refreshFloatCloud(true, function()
        self:_changeEventMode()
        self.mBtnRefresh:setVisible(self.isShowEvent)
        self.remainTime:setVisible(self.isShowEvent)
        LevelSelectUtil:getInstance().mUseSpecialEvent = self.isShowEvent
    end)
end

function LevelSelect:_changeEventMode()
    if not self:checkSelfHaveHeroMode() then--self.layerType ~= Game.LevelSelectLayerType.Normal_Plot then
        print("---_changeEventMode-self.layerType -- = ", self.layerType )
        return
    end
    if self.isShowEvent then
        self.mBtnChangeEventMode:setNormal("ui_btn_events_1.png")
        self.mBtnChangeEventMode:setSelected("ui_btn_events_1.png")
        local selectIndex = nil
        for k, v in pairs(self.heroLevelBtnList) do
            v:setVisible(false)
            v:disable()
            if self.selectedIcon:getTag() == v:getTag() then
                selectIndex = k
            end
        end 
        for k, v in pairs(self.specialEventIconLayout) do
            v:setVisible(true)
            v:enable()
            if selectIndex == k then
                v:selected(true)
                self.selectedIcon = v
            else
                v:unLocked()
            end
        end 
    else
        self.mBtnChangeEventMode:setNormal("ui_btn_events_0.png")
        self.mBtnChangeEventMode:setSelected("ui_btn_events_0.png")
        for k, v in pairs(self.specialEventIconLayout) do
            v:setVisible(false)
            v:disable()
            if self.selectedIcon:getTag() == v:getTag() then
                selectIndex = k
            end
        end
        for k, v in pairs(self.heroLevelBtnList) do
            v:setVisible(true)
            v:enable()
            if selectIndex == k then
                v:selected()
                self.selectedIcon = v
            else
                v:unLocked()
            end
        end 
    end
    self:showRewardLayer()
    self:refreshFisrtPassPanel(self.fisrtPassPanel, self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, LevelSelectUtil:getInstance().mSelectLevel)
end

function LevelSelect:createOneEventInfo(data)
    if not self:checkSelfHaveHeroMode() then--self.layerType ~= Game.LevelSelectLayerType.Normal_Plot then
        print("---createOneEventInfo-self.layerType -- = ", self.layerType )
        return
    end
    local text = UI.Text:create()
    text:init(data.name..":"..data.description, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_255_255_255)
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

function LevelSelect:update(dt)
    if self.layerType ~= Game.LevelSelectLayerType.Normal_Plot and 
    self.layerType ~= Game.LevelSelectLayerType.Titan_Road then
        -- print("--update--self.layerType -- = ", self.layerType )
        return
    end
    if self.remainTime then
        local targetTime = MasterDataManager:getHeroCaveSpecialEnventRemianTime()
        if self.layerType == Game.LevelSelectLayerType.Titan_Road then
            targetTime = MasterDataManager:getTitanHeroCaveSpecialEnventRemianTime()
        end

        local refresWaitingTime = targetTime + GameManager:getEPOCHTime() - GameManager:getNowServerTime()
        local showText = nil
        

        -- if self.schedulerID then
        --     scheduler:unscheduleScriptEntry(self.schedulerID)
        --     refresWaitingTime = refresWaitingTime < 6 and 6 or refresWaitingTime
        --     self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), refresWaitingTime, false)
        -- end

        if refresWaitingTime > 0 then
            showText = AvalonUtil:getFullFormatTime(targetTime, true, false)
        else
            local unLockHeroMode = RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
            if unLockHeroMode then
                Net.NetRoleSystem:refreshHeroSpecialEventRequest(true, self.data.caveMode)
            end
        end
        if showText == nil then
            self.remainTime:setText("")
            -- self.remainTime:setText(string.format(UI.TEXT_1170946, ""))
        else
            -- self.remainTime:setText(string.format(UI.TEXT_1170946, showText))
            self.remainTime:setText(string.format("%s", showText))
        end
    end
    local isSuccess = MasterDataManager:checkRefreshCountAndTime()
    if self.layerType == Game.LevelSelectLayerType.Titan_Road then
        isSuccess = MasterDataManager:checkRefreshTitanCountAndTime()
    end
    if isSuccess then
        self:refreshItemButton()
    end
end

--切换副本
function LevelSelect:onSwitchCaveMode()
    if self.lockAllBtn == false and self.mBClick == true  and not self.mLockDiffSelect then
        --开启副本选择界面
        local pLevelSelectSwichCavePannel = UI.SwitchCavePannel:create(self.layerType)
        pLevelSelectSwichCavePannel:center()
        self:getParent():addChild(pLevelSelectSwichCavePannel,UI_ZORDER.ACTIVITY)
        -- Game.FunctionUnlockManager:getInstance():removeNewFlag(PublicDefine.UnlockFunctionType.UnlockFunctionType_HeroCave)
        -- self.layerType = Game.LevelSelectLayerType.Titan_Road
    end
end

--切换副本重置副本数据
function LevelSelect:resetCaveDataByLayerType(layerType, isShowAnimation)
    if layerType == Game.LevelSelectLayerType.Normal_Plot then
        LevelSelectUtil:getInstance():initTimeCaveData()
        MasterDataManager:checkRefreshCountAndTime()
        self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 6, false)
        self.data.caveMode = LevelSelectUtil:getInstance().mCaveMode
        self.data.oldOpenLevel = LevelSelectUtil:getInstance().mOldOpenLevel
        self.data.curOpenLevel = LevelSelectUtil:getInstance().mOpenLevel:get()
    elseif layerType == Game.LevelSelectLayerType.Titan_Road then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_TITAN_ROAD
        MasterDataManager:checkRefreshTitanCountAndTime()
        self.data.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(PublicDefine.CAVE_MODE.MODE_TITAN_ROAD, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
        local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
        if openCheckpointData then
            self.data.oldOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint())
        else
            self.data.oldOpenLevel = 0
        end
    elseif layerType == Game.LevelSelectLayerType.Desert_Eye then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_DESERT_EYES
        self.data.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(PublicDefine.CAVE_MODE.MODE_DESERT_EYES, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
        local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
        if openCheckpointData then
            self.data.oldOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint())
        else
            self.data.oldOpenLevel = 0
        end
    elseif layerType == Game.LevelSelectLayerType.Dried_Spring then
        self.data.caveMode = PublicDefine.CAVE_MODE.MODE_DRIED_SPRING
        self.data.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(PublicDefine.CAVE_MODE.MODE_DRIED_SPRING, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
        local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
        if openCheckpointData then
            self.data.oldOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint())
        else
            self.data.oldOpenLevel = 0
        end
    end
    self.layerType = layerType  
    -- self._layout:removeFromParent(true)
    -- self._scrollView:removeFromParent(true)
    -- self._scrollView = nil
    -- self._layout = nil

    -- self._scrollView, self._layout = self:createScrollView(self.layerType)
    -- self.rightLayer:addChild(self._scrollView, 10)
    -- self:createLevelBtns()
    -- self:updateView()
    self.heroLevelBtnList = {}
    self.specialEventIconLayout = {}
    self:clearBtnList()
    self.rootLayer:removeFromParent(true)
    self.rootLayer = nil
    self:onInitView(isShowAnimation)
    performWithDelay(self, function() 
        self:updateView()
    end, 0.01)
    
    if isShowAnimation then
        LevelSelectUtil:getInstance():setSwitchCaveLayerType(layerType)
    end
end


function LevelSelect:addFirstShowAnime()
    local animeBG = cc.LayerColor:create(cc.c4b(0,0,0,255));
    animeBG:setIgnoreAnchorPointForPosition(false)
    animeBG:setAnchorPoint(0.5, 0.5)
    animeBG:setContentSize(winSize.width * 2, winSize.height * 2)
    animeBG:setPosition(self._width / 2, self._height / 2)
    self:addChild(animeBG, 999)

    local showAnime = UI.Animation:create()
    showAnime:init("effect_ui_town_zhuansheng_first.json", "effect_ui_town_zhuansheng_first.atlas", 1)
    -- showAnime:setSize(343, 180)
    showAnime:setAnimation("unlock", false)
    showAnime:center(0, 0)
    animeBG:addChild(showAnime)
    animeBG:setOpacity(255*0.5)

    -- showAnime:addEventListener(UIEvent.ANIMATION_END,self,function(this, event)
    --     animeBG:setVisible(false)
    -- end)

    showAnime:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "events_appearsign" then
                if self.mBtnDifficulty and not tolua.isnull(self.mBtnDifficulty) then
                    self.mBtnDifficulty:show()
                    self.isFirst = false
                    self.modeChangeTitleBtn:setVisible(true)
                    animeBG:setVisible(false)
                end
            end
        end
    end)

    showAnime:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        if(event and event.eventData) then
            if event.eventData.name == "events_blackscreen" then
                animeBG:setOpacity(255)
                self:resetCaveDataByLayerType(Game.LevelSelectLayerType.Titan_Road, true)
            end
        end
    end)
end

function LevelSelect:checkSelfHaveHeroMode()
    local have = false
    if self.layerType == Game.LevelSelectLayerType.Titan_Road or
    self.layerType == Game.LevelSelectLayerType.Normal_Plot then
        have = true
    end
    return have
end

function LevelSelect:checkIsHeroMode()
    local isHero = false
    if self.data.caveMode == PublicDefine.CAVE_MODE.MODE_HERO or
    self.data.caveMode == PublicDefine.CAVE_MODE.MODE_TITAN_ROAD_HERO then
        isHero = true
    end
    return isHero
end

--end--普通剧情关卡的英雄模式的特殊事件相关代码-----