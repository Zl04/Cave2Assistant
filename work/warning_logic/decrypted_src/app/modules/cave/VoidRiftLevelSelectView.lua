------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/05/26
--desc	: 
------------------------------------------------------------------------------
require("app.ui.town.levelSelect.LevelSelectNormalBtn")
require("app.ui.town.SuperLevelSelect")
require("app.ui.UIManager")
require "app.datas.AnswerDataManager"

local ProtobufUtil = require "utils.ProtobufUtil"
local GameDataManager = require("app.game.GameDataManager")
local LevelSelectUtil = require("app.ui.town.levelSelect.LevelSelectUtil")
local LanguageManager = require("app.game.LanguageManager")
local scheduler = cc.Director:getInstance():getScheduler()
require("app.utils.RewardPreViewUtil")
require("app.ui.town.distortedSpace.SpaceTypeSelect")
local languageManagerInstance = LanguageManager:getInstance()
local VoidRiftLevelSelectView = class("VoidRiftLevelSelectView", UI.SuperLevelSelect)

-- 资源
local COM_RES_LIST = {
    "ui_town_inferno.plist",
    "ui_town_levelselect.plist",
    "ui_town_distortedSpace.plist",
}

local winSize = cc.Director:getInstance():getWinSize()
local LayerSize = cc.size(1136, 640)
local ScrollViewSize = cc.size(700, 460)

-- local COM_WIDTH = 852
-- local COM_HEIGHT = 534

local CELL_WIDTH = 60
local CELL_HEIGHT = 60

function VoidRiftLevelSelectView:ctor()
    layerType = Game.LevelSelectLayerType.VoidRift
    VoidRiftLevelSelectView.super.ctor(
    self,
    UIType.MAIN_UI_VOIDRIFT,
    COM_RES_LIST,
    LayerSize.width,
    LayerSize.height,
    layerType)
    self.rootLayer = nil;           --root节点
    print("========layerType====", layerType)
    self.layerType = layerType
    self.levelBtnList = {}          --关卡按钮
    self.stepPoint = {}             --二位数组  组成关卡连线 的点的集合
    
    self.lockAllBtn = false          --按钮锁，点击开始按钮后播放动画的过程中锁住所有按钮
    self.mBClick = true;
    self.spriteID = NPCSpriteID
    self.isFloatCloudAct = false
    self:setTouchEnable(true);
    self:setInterceptTouches(true);
    self.data = {}
    self.data.caveMode = PublicDefine.CAVE_MODE.MODE_VOID_RIFT
    self.data.curDiff = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1

    self.config = nil
    self.curLevelCurseBuffConfig = nil
    self._tableView = nil

    self.data.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
    local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
    if openCheckpointData then
        self.data.oldOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint())
    else
        self.data.oldOpenLevel = self.data.curOpenLevel
    end

    self.data.curOpenEliteLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2):getCheckpoint())
    local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2)
    if openCheckpointData then
        self.data.oldOpenEliteLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint())
    else
        self.data.oldOpenEliteLevel = self.data.curOpenEliteLevel
    end

    self.data.curOpenNightMareLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3):getCheckpoint())
    local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3)
    if openCheckpointData then
        self.data.oldOpenNightMareLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(openCheckpointData:getCheckpoint())
    else
        self.data.oldOpenNightMareLevel = self.data.curOpenNightMareLevel
    end
    print("self.data.oldOpenNightMareLevel=", self.data.curOpenNightMareLevel, self.data.oldOpenNightMareLevel, RoleDataManager:getCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3):getCheckpoint())

    --容错处理：
    self.data.curOpenLevel = self.data.curOpenLevel <= 0 and 0 or self.data.curOpenLevel
    self.data.oldOpenLevel = self.data.oldOpenLevel <= 0 and 0 or self.data.oldOpenLevel
    -- self:init();

    mvc.caveModel:setCurseBuffConfig(PublicDefine.CAVE_MODE.MODE_VOID_RIFT)
    self:bindModel()
end

function VoidRiftLevelSelectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.cave", "Cave", false)
    VoidRiftLevelSelectView.super.init(self, ... )
end

function VoidRiftLevelSelectView:dtor()
    VoidRiftLevelSelectView.super.dtor(self)
    self:unbindModel()
    print(debug.traceback())
    if(not tolua.isnull(self.sweepingLayout)) then 
        self.sweepingLayout:release()
        self.sweepingLayout = nil
    end

    self.config = nil
    self.curLevelCurseBuffConfig = nil
    self._tableView = nil

    local textureCache = cc.Director:getInstance():getTextureCache()
    textureCache:removeTextureForKey("image/levelSelect/ui_inferno_map_bg.png")
    textureCache:removeTextureForKey("image/levelSelect/ui_uncharted_map_1.png")
    reload_script_file_mvc("app.modules.cave.VoidRiftLevelSelectView")
end


-- 模版函数：初始化组建的视图
function VoidRiftLevelSelectView:onInitView()   
    self.rootLayer = UI.Layout:create()
    self.rootLayer:init()
    self.rootLayer:center()
    self.rootLayer:setSize(LayerSize.width, LayerSize.height)
    -- self.rootLayer:enableDebugDraw()
    self:addChild(self.rootLayer)

    local leftLayer = UI.Image:create()
    leftLayer:init("ui_uncharted_bg.png")
    leftLayer:centerLeft(0)
    -- leftLayer:enableDebugDraw()
    self.rootLayer:addChild(leftLayer)
    self.leftLayer = leftLayer

    -- 购买猫饭快捷方式
    local catFoodBg = UI.Image:create()
    catFoodBg:init("ui_uncharted_catfood_box.png")
    catFoodBg:leftBottom(310,167)
    leftLayer:addChild(catFoodBg,100)

    local catFoodBtn = UI.Button:create()
    catFoodBtn:init("ui_btn_catfood_0.png", "ui_btn_catfood_1.png", "ui_btn_catfood_0.png")
    catFoodBtn:center(-12,-4)
    local parenLayer = self
    catFoodBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_CATFOOD, 0, parenLayer, self.data.caveMode)
    end)
    catFoodBg:addChild(catFoodBtn, 10)

    local closeBtn = UI.Button:create()
    closeBtn:init("ui_uncharted_btn_close_0.png", "ui_uncharted_btn_close_0.png", "ui_uncharted_btn_close_0.png")
    closeBtn:rightUp(37, 35)
    closeBtn:rightUp(8, 75)
    -- closeBtn:enableDebugDraw()
    closeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.clickClose)
    self.leftLayer:addChild(closeBtn, 10)

    -- local flag = UI.Animation:create()
    -- flag:init("effect_ui_town_selectfloor_distortedspace_tengman.json", "effect_ui_town_selectfloor_distortedspace_tengman.atlas", 1)
    -- flag:leftBottom(1048, 135)
    -- self.leftLayer:addChild(flag)
    -- flag:setAnimation("idle", true)

    --右下角按钮  
    local plotBtn = UI.Button:create()
    plotBtn:init("ui_distortedSpace_btn_plot_0.png", "ui_distortedSpace_btn_plot_1.png", "ui_distortedSpace_btn_plot_2.png")
    plotBtn:leftBottom(883, 48)
    plotBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:changeDiffcult(PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, true)
    end)
    self.plotBtn = plotBtn

    self.leftLayer:addChild(plotBtn, 10)
    local plotText = UI.Text:create()
    plotText:init(UI.TEXT_110002, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_51_51_51)
    plotText:leftBottom(151 - plotText:getContentSize().width / 2, 24)
    plotBtn:addChild(plotText, 10)
    print("40 - plotText:getContentSize().height / 2", 40 - plotText:getContentSize().height / 2)

    -- 精英按钮
    local heroBtn = UI.Button:create()
    heroBtn:init("ui_distortedSpace_btn_hero_0.png", "ui_distortedSpace_btn_hero_1.png", "ui_distortedSpace_btn_hero_2.png")
    heroBtn:leftBottom(912, 133)
    heroBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:changeDiffcult(PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2, true)
    end)
    heroBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        self:heroDisableClick()
    end)
    heroBtn:disable()
    self.heroBtn = heroBtn

    self.leftLayer:addChild(heroBtn, 10)
    local heroText = UI.Text:create()
    heroText:init(UI.TEXT_1212806, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_51_51_51)
    heroText:leftBottom(126 - heroText:getContentSize().width / 2, 24)
    heroBtn:addChild(heroText, 10)

    local lockAction = UI.Animation:create()
    lockAction:init("effect_ui_dreamword_unlock.json", "effect_ui_dreamword_unlock.atlas", 1)
    lockAction:leftUp(59, 19)
    heroBtn:addChild(lockAction, 100)
    lockAction:setAnimation("idle", true)
    lockAction:setScale(0.7)
    self.heroLockAction = lockAction

    local countBg = UI.Image:create()
    countBg:init("ui_distortedSpace_btn_hero_bg.png")
    countBg:leftBottom(986, 186)
    countBg:setScaleY(1.5)
    self.leftLayer:addChild(countBg, 9)
    self.countBg = countBg
    self.countBg:hide()

    local countNum = UI.Text:create()
    countNum:init(string.format(UI.TEXT_1212817, 0), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    countNum:center(0, -7)
    countNum:setScaleY(0.67)
    countBg:addChild(countNum)
    self.countNum = countNum

    -- 噩梦难度
    local nightMareBtn = UI.Button:create()
    nightMareBtn:init("ui_distortedSpace_btn_nightmare_0.png", "ui_distortedSpace_btn_nightmare_1.png", "ui_distortedSpace_btn_nightmare_2.png")
    nightMareBtn:leftBottom(942, 218)
    nightMareBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:changeDiffcult(PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3, true)
    end)
    nightMareBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        self:nightMareDisableClick()
    end)
    nightMareBtn:disable()
    self.nightMareBtn = nightMareBtn

    self.leftLayer:addChild(nightMareBtn, 10)
    local nightMareText = UI.Text:create()
    nightMareText:init(UI.TEXT_1325502, UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_51_51_51)
    nightMareText:leftBottom(126 - heroText:getContentSize().width / 2, 24)
    nightMareBtn:addChild(nightMareText, 10)

    local nightMareLockAction = UI.Animation:create()
    nightMareLockAction:init("effect_ui_dreamword_unlock.json", "effect_ui_dreamword_unlock.atlas", 1)
    nightMareLockAction:leftUp(59, 19)
    nightMareBtn:addChild(nightMareLockAction, 100)
    nightMareLockAction:setAnimation("idle", true)
    nightMareLockAction:setScale(0.7)
    self.nightMareLockAction = nightMareLockAction

    local nightMareEffectAction = UI.Animation:create()
    nightMareEffectAction:init("effect_ui_town_selectfloor_inferno_emeng.json", "effect_ui_town_selectfloor_inferno_emeng.atlas", 1)
    -- nightMareEffectAction:leftUp(59, 19)
    nightMareEffectAction:leftUp(45, 55)
    nightMareBtn:addChild(nightMareEffectAction, 100)
    nightMareEffectAction:setAnimation("idle1", true)
    nightMareEffectAction:setScale(0.7)
    nightMareEffectAction:setVisible(false)
    self.nightMareEffectAction = nightMareEffectAction

    local nightMareCountBg = UI.Image:create()
    nightMareCountBg:init("ui_distortedSpace_btn_hero_bg.png")
    nightMareCountBg:leftBottom(942+74, 218+53)
    nightMareCountBg:setScaleY(1.5)
    self.leftLayer:addChild(nightMareCountBg, 9)
    self.nightMareCountBg = nightMareCountBg
    self.nightMareCountBg:hide()

    local nightMareCountNum = UI.Text:create()
    nightMareCountNum:init(string.format(UI.TEXT_1212817, 0), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_194_194_194)
    nightMareCountNum:center(0, -7)
    nightMareCountNum:setScaleY(0.67)
    nightMareCountBg:addChild(nightMareCountNum)
    self.nightMareCountNum = nightMareCountNum

    -- 开始按钮
    self.startBtn = UI.Button:create()
    self.startBtn:init("ui_inferno_btn_challenge.png", "ui_inferno_btn_challenge_2.png", "ui_inferno_btn_challenge_3.png")
    self.startBtn:leftBottom(60, 75)
    self.startBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.startGame)
    self.leftLayer:addChild(self.startBtn, 10)
    self.startBtn:hide()

    local startText = UI.Text:create()
    startText:init(UI.TEXT_1212081, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_220_211_147)
    startText:center()
    self.startBtn:addChild(startText, 10)
    self.startText = startText

    local modeNameBgAnim = UI.Animation:create()
    modeNameBgAnim:init("effect_ui_town_selectfloor_sky.json", "effect_ui_town_selectfloor_sky.atlas", 1)
    modeNameBgAnim:leftBottom(179, 295)
    self.leftLayer:addChild(modeNameBgAnim, 1)
    modeNameBgAnim:setAnimation("idle1", true)
    self.modeNameBgAnim = modeNameBgAnim

    -- 切换状态
    local switchMode = UI.Layout:create()
    switchMode:init()
    switchMode:setSize(193, 85)
    -- switchMode:enableDebugDraw()
    switchMode:leftUp(83, 53)
    self.leftLayer:addChild(switchMode, 10)
    self.switchMode = switchMode -- 暴露名字至self
    self.switchMode:setTouchEnable(true)
    self.switchMode:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        reload_script_file("app.ui.town.distortedSpace.SpaceTypeSelect")
        local typeSelect = UI.SpaceTypeSelect:create(function(choiceType)
            print("choiceType=", choiceType)
            if(choiceType == Game.DISTORTED_TYPE.INFERNO) then 
                Avalon.MessageCenter:notice(GameMessage.MC_UI_HIDE_MAINUI_LAYER)
                -- Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, 0, Game.LevelSelectLayerType.Inferno)
                mvc.openPanel("Cave", "InfernoLevelSelect")
                mvc.closePanel("Cave", "VoidRiftLevelSelect")
                -- mvc.openPanel("Cave", "InfernoLevelSelect")
            elseif choiceType == Game.DISTORTED_TYPE.NORMAL then
                Avalon.MessageCenter:notice(AvalonMessage.MC_TOWN_SHOW_SPACE_LEVEL_SELECT, 0, Game.LevelSelectLayerType.Distorted_Space)
                mvc.closePanel("Cave", "VoidRiftLevelSelect")
            end
        end)
        typeSelect:center()
        self:addChild(typeSelect, 10000)
    end)


    --左侧详情面板 1、关卡详情 2、个人任务详情 3、服务器任务详情
    local levelInfo = UI.Layout:create()
    levelInfo:init()
    levelInfo:setSize(270, 494)
    levelInfo:centerLeft(44)
    self.leftLayer:addChild(levelInfo, 10)
    -- levelInfo:enableDebugDraw()
    -- levelInfo:hide()
    self.levelInfo = levelInfo

    local modeName = UI.Text:create()
    modeName:init(UI.TEXT_222100, UI.FONT_BOLD, UI.FONT_SIZE_24PX, UI.FONT_COLOR_51_51_51)
    modeName:setSize(220, 50)
    modeName:setTextCenter()
    modeName:centerUp(85)
    levelInfo:addChild(modeName, 100)

    local floorName = UI.Text:create()
    floorName:init(UI.TEXT_1212814, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    floorName:centerUp(122)
    levelInfo:addChild(floorName)
    self.floorName = floorName

    --
    local lineIamge = UI.Image9:create()
    lineIamge:init("ui_inferno_line.png", CCRectMake(2,0,1,1), cc.size(211, 2))
    lineIamge:centerUp(150)
    levelInfo:addChild(lineIamge)

    local desc = UI.Text:create()
    desc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    desc:setWidth(230)
    desc:autoAdapt()
    desc:centerUp(157)
    -- desc:enableDebugDraw()
    levelInfo:addChild(desc)
    self.floorDesc = desc

    local lineIamge = UI.Image9:create()
    lineIamge:init("ui_inferno_line.png", CCRectMake(2,0,1,1), cc.size(211, 2))
    lineIamge:centerUp(324)
    levelInfo:addChild(lineIamge)

    local gameModeNode = self:createGameMode(PublicDefine.CAVE_MODE.MODE_VOID_RIFT, function(gameMode)
        self:selectButton(gameMode)
    end)
    gameModeNode:centerBottom(96)
    levelInfo:addChild(gameModeNode, 10)

    -- self.singlePlayBtn = UI.Button:create()
    -- self.singlePlayBtn:init("ui_btn_single_0.png", "ui_btn_hero_single_1.png", "ui_btn_single_2.png")
    -- self.singlePlayBtn:leftBottom(60, 96)
    -- self.singlePlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.playModelBtnClick)
    -- levelInfo:addChild(self.singlePlayBtn, 10)

    -- self.teamPlayBtn = UI.Button:create()
    -- self.teamPlayBtn:init("ui_btn_many_0.png", "ui_btn_hero_many_1.png", "ui_btn_many_2.png")
    -- self.teamPlayBtn:leftBottom(150, 96)
    -- self.teamPlayBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.playModelBtnClick)
    -- levelInfo:addChild(self.teamPlayBtn, 10)
    -- self.teamPlayBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS,self, function()
    --     if not RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team) then
    --         Game.FunctionUnlockManager:showLockTips(PublicDefine.UnlockFunctionType.UnlockFunctionType_Team)
    --     end
    -- end)
    
    --奖励道具
    local shareRewardPanel = UI.Layout:create()
    shareRewardPanel:init()
    shareRewardPanel:setSize(480, 105)
    shareRewardPanel:leftBottom(410, 58)
    -- shareRewardPanel:enableDebugDraw()
    self.leftLayer:addChild(shareRewardPanel)
    self.shareRewardPanel = shareRewardPanel

    local rewardTip = UI.Text:create()
    rewardTip:init(LanguageManager:getInstance():getLocalString(1111346), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    rewardTip:centerBottom(80)
    shareRewardPanel:addChild(rewardTip, 10)

    local lineWidth = (shareRewardPanel:getContentSize().width - rewardTip:getContentSize().width - 240) / 2
    local lineL = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineL:setContentSize(lineWidth, 2)
    lineL:setAnchorPoint(0, 0)
    lineL:setPosition(79, 92)
    shareRewardPanel:addChild(lineL,10)

    local lineR = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineR:setContentSize(lineWidth, 2)
    lineR:setAnchorPoint(0, 0)
    lineR:setPosition(shareRewardPanel:getContentSize().width - lineWidth - 79,92)
    shareRewardPanel:addChild(lineR, 10)

    -- local capLeft = UI.Image:create()
    -- capLeft:init("ui_inferno_map_gradually_left.png")
    -- capLeft:leftBottom(-4 - 35, 4)
    -- capLeft:enableDebugDraw()
    -- shareRewardPanel:addChild(capLeft, 100)

    -- local capRight = UI.Image:create()
    -- capRight:init("ui_inferno_map_gradually_right.png")
    -- capRight:leftBottom(430, 3)
    -- capRight:enableDebugDraw()
    -- shareRewardPanel:addChild(capRight, 100)

    self._scrollView, self._layout = self:createScrollView(self.layerType, 726, 400)
    local clipper = UI.ClippingNode:create()
    clipper:initWithFileName("image/levelSelect/ui_inferno_map_bg.png", 0.01)
    clipper:addInnerNode(self._scrollView)
    clipper:rightBottom(40, 170)
    self.leftLayer:addChild(clipper, 3)
    clipper:setOpacityFilterTouch(true)
    
    local mask = UI.Image:create()
    mask:init("ui_uncharted_map_mack.png")
    mask:center(4 - 1,-2)
    -- mask:enableDebugDraw()
    clipper:addChild(mask, 100)
    self.floatCloudCliper = clipper

    local starButton = UI.Button:create() 
    starButton:init()
    starButton:addEventListener(UI.Event.BUTTON_CLICK, self, self.showStarInfo)
    starButton:setSize(50,50)
    starButton:leftBottom(265, 492)
    self.leftLayer:addChild(starButton, 10)

    local detailAnimation = UI.Animation:create()
    detailAnimation:init("effect_ui_package_role_detail_hint_icon.json", "effect_ui_package_role_detail_hint_icon.atlas")
    detailAnimation:setAnimation("idle", true)
    detailAnimation:center()
    starButton:addChild(detailAnimation, 10)

    -- 生成一个扫荡的按钮
    local sweepingLayout = UI.Layout:create()
    sweepingLayout:init()
    sweepingLayout:retain()
    sweepingLayout:centerBottom(-6)
    self.sweepingLayout = sweepingLayout
    sweepingLayout:setVisible(false)
    self.rootLayer:addChild(sweepingLayout, 100)

    local sweepingBtn = UI.Button:create()
    sweepingBtn:init("ui_distortedSpace_saodang_sign_01.png", "ui_distortedSpace_saodang_sign_01.png", "ui_distortedSpace_saodang_sign_02.png")
    sweepingBtn:center(-7)
    local parenLayer = self
    sweepingBtn:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        self:clickSweeping()
    end)
    sweepingBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function(self)
        UI.ScrollBar:createByText(UI.TEXT_1324351)
    end)
    sweepingBtn:setText(UI.TEXT_1324354)
    sweepingBtn:setTextOffset(6, -1)
    sweepingBtn:setFixLineWidth(50)
    sweepingBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    sweepingLayout:addChild(sweepingBtn, 10)
    self.sweepingBtn = sweepingBtn
    -- sweepingBtn:enableDebugDraw()

    -- 扫荡右上角提示
    local sweepingBg = UI.Image:create()
    sweepingBg:init("ui_distortedSpace_saodang_bg.png")
    sweepingBg:rightUp(116, 74)
    self.rootLayer:addChild(sweepingBg, 100)
    self.sweepingBg = sweepingBg

    local helpData = ConfigManager:getClientHelpForID(700001)
    if(helpData) then 
        require "app.ui.common.GeneralHelpLayer"
        local generalHelp = UI.GeneralHelpLayer:create(helpData)
        generalHelp:init()
        generalHelp:center(-sweepingBg:getContentSize().width/2 - 20)
        generalHelp:setName("GeneralHelp")
        sweepingBg:addChild(generalHelp, 100000)
    end

    -- 提示文字
    local tipTitle = UI.Text:create()
    tipTitle:init(UI.TEXT_1324350, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_194_194_194)
    tipTitle:setTextRight()
    tipTitle:centerRight(70)
    local maxWidth = 120
    if(tipTitle:getContentSize().width > maxWidth) then 
        tipTitle:setFixLineWidth(maxWidth)
    end
    sweepingBg:addChild(tipTitle)
    -- tipTitle:enableDebugDraw()

    local sweepingIcon = UI.Image:create()
    sweepingIcon:init("symbol_distortedSpace_key.png")
    sweepingIcon:centerLeft(133)
    -- sweepingIcon:enableDebugDraw()
    sweepingBg:addChild(sweepingIcon, 100)
    self.sweepingIcon = sweepingIcon

    local numText = UI.Text:create()
    numText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_220_182_80)
    numText:centerLeft(137)
    -- numText:enableDebugDraw()
    sweepingBg:addChild(numText)
    self.sweepingNum = numText

    --正下方奖励面板
    --剧情对话
    local plotPanel = UI.Layout:create()
    plotPanel:init()
    plotPanel:setSize(480, 105)
    plotPanel:leftBottom(410, 58)
    self.leftLayer:addChild(plotPanel)
    self.plotPanel = plotPanel

    local title = UI.Text:create()
    title:init(UI.TEXT_1212810, UI.FONT_STANDARD, UI.FONT_SIZE_15PX, UI.FONT_COLOR_51_51_51)
    title:leftUp(10, 10)
    plotPanel:addChild(title)
    self.plotTitle = title
    
    local desc = UI.Text:create()
    desc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_15PX, UI.FONT_COLOR_51_51_51)
    desc:leftUp(10, 30)
    desc:setWidth(460)
    desc:autoAdapt()
    plotPanel:addChild(desc)
    self.plotDesc = desc

    self:initTaskInfo()


    -- add by zp 单人挑战更新个人进度
    local noticeImageBg = UI.Image:create()
    noticeImageBg:init("ui_selectfloor_information_02.png")
    noticeImageBg:rightUp(109, 50)
    self.rootLayer:addChild(noticeImageBg, 1000)
    -- self.rootLayer:enableDebugDraw()
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

    -- self:addCurseBuffLayer()
end

-- 模版函数：更新组建的视图
function VoidRiftLevelSelectView:onUpdateView()
    VoidRiftLevelSelectView.super.onUpdateView(self)
    self:createLevelBtns(self.data.oldOpenLevel, self.data.curOpenLevel, self._scrollView, self._layout, handler(self, self.spineIconClickCallback), handler(self, self.spineIconAnimEndCallback), handler(self, self.spineIconAnimStartCallback))
    self.selectedIcon = self.defaultNomalSelectIcon
    
    self:selectButton(PublicDefine.GAME_MODE.MODE_SOLO)
    self:openShowAction(true)
    self:refreshAllLevelBtn()
    self:refreshVoidRiftView(self.selectedIcon:getTag())
    self:changeDiffcult(PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, false) 
end

function VoidRiftLevelSelectView:initTaskInfo()
    local priTaskInfo = UI.Layout:create()
    priTaskInfo:init()
    priTaskInfo:setSize(270, 494)
    priTaskInfo:centerLeft(44)
    self.leftLayer:addChild(priTaskInfo, 10)
    self.priTaskInfo = priTaskInfo

    local modeName = UI.Text:create()
    modeName:init(UI.TEXT_1212807, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    modeName:centerUp(83)
    modeName:setSize(224, 50)
    modeName:setTextCenter()
    priTaskInfo:addChild(modeName)

    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(217, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(133, 369))
    priTaskInfo:addChild(lineUpImage, 4)

    -- 滚动视图
    local taskDescScrollView = UI.ScrollView:create()
    taskDescScrollView:init(0, 0, 0, 0)
    taskDescScrollView:leftBottom(10, 228)
    taskDescScrollView:setSize(260, 110)
    taskDescScrollView:setTouchEnable(true)
    taskDescScrollView:setScrollBarEnabled(true)
    taskDescScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    taskDescScrollView:setScrollBarWidth(5)
    taskDescScrollView:setCircleVisible(false)
    self.taskDescScrollView = taskDescScrollView
    priTaskInfo:addChild(taskDescScrollView)
    -- taskDescScrollView:enableDebugDraw()
    
    local taskDescLayout = UI.Layout:create()
    taskDescLayout:init()
    taskDescLayout:leftBottom(0, 0)
    self.taskDescLayout = taskDescLayout
    taskDescScrollView:addInnerNode(taskDescLayout)

    local taskName = UI.Text:create()
    taskName:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    taskName:centerUp(130)
    priTaskInfo:addChild(taskName)
    self.taskName = taskName

    local taskDesc = UI.Text:create()
    taskDesc:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    taskDesc:setPosition(0,0)
    taskDesc:setAnchorPoint(0,1)
    taskDesc:setWidth(240)
    taskDescLayout:addChild(taskDesc)
    self.taskDesc = taskDesc

    local taskPro = UI.Text:create()
    taskPro:init(UI.TEXT_1212808, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
    taskPro:rightUp(61, 254)
    priTaskInfo:addChild(taskPro) 

    local taskNum = UI.Text:create()
    taskNum:init("3/5", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_102_0_0)
    taskNum:rightUp(31, 254)
    priTaskInfo:addChild(taskNum) 
    self.taskNum = taskNum
     
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(217, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(133, 244))
    priTaskInfo:addChild(lineUpImage, 4)

    local rewardBg = UI.Image:create()
    rewardBg:init("ui_distortedSpace_rewardline.png")
    rewardBg:centerUp(288)
    priTaskInfo:addChild(rewardBg)

    local rewerdTitle = UI.Text:create()
    rewerdTitle:init(UI.TEXT_1212809, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    rewerdTitle:center()
    rewardBg:addChild(rewerdTitle)
end

function VoidRiftLevelSelectView:refreshWorldEventCallback()
    self.selectedIcon = self.defaultNomalSelectIcon
    if self.selectedIcon == nil then
        return
    end

    self:refreshAllLevelBtn()
    self:refreshVoidRiftView(self.selectedIcon:getTag())
    self:changeDiffcult(PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, false) 
    -- self:updateCurseBuffLayer()
end

function VoidRiftLevelSelectView:heroDisableClick()
    if self.selectedIcon == nil then
        return
    end
    local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
    local taskData = TaskDataManager:getVoidRiftTaskByLevel(level)
    -- local worldEvent = MasterDataManager:getWorldEventDataForID(level) 
    if (taskData and not taskData:getIsReceived()) then
        UI.ScrollBar:createByText(UI.TEXT_1170901)
        return
    end

    local remainCount = mvc.caveModel:getVoidRiftEliteLostNum()
    if remainCount <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212818)
    end
end

function VoidRiftLevelSelectView:nightMareDisableClick()
    if self.selectedIcon == nil then
        return
    end
    local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
    local taskData = TaskDataManager:getVoidRiftTaskByLevel(level)
    -- local worldEvent = MasterDataManager:getWorldEventDataForID(level) 
    if (taskData and not taskData:getIsReceived()) then
        UI.ScrollBar:createByText(UI.TEXT_1170901)
        return
    end

    local remainCount = mvc.caveModel:getVoidRiftNightMareLostNum()
    if remainCount <= 0 then
        UI.ScrollBar:createByText(UI.TEXT_1212818)
    end
end

function VoidRiftLevelSelectView:changeDiffcult(diff, isRefresh)

    if isRefresh and self.data.curDiff == diff then
        return
    end
    
    if self.lockAllBtn == true or self.mBClick == false or self.isFloatCloudAct then
        print("----changeDiffcult------", self.lockAllBtn, self.mBClick, self.isFloatCloudAct)
        return
    end
    self.data.curDiff = diff

    if self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1 then
        self.plotBtn:setNormal("ui_distortedSpace_btn_plot_1.png")
        self.heroBtn:setNormal("ui_distortedSpace_btn_hero_0.png")
        self.nightMareBtn:setNormal("ui_distortedSpace_btn_nightmare_0.png")
    elseif self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2 then
        self.plotBtn:setNormal("ui_distortedSpace_btn_plot_0.png")
        self.heroBtn:setNormal("ui_distortedSpace_btn_hero_1.png")
        self.nightMareBtn:setNormal("ui_distortedSpace_btn_nightmare_0.png")
    elseif self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then
        self.plotBtn:setNormal("ui_distortedSpace_btn_plot_0.png")
        self.heroBtn:setNormal("ui_distortedSpace_btn_hero_0.png")
        self.nightMareBtn:setNormal("ui_distortedSpace_btn_nightmare_1.png")
    end
    if isRefresh then
        --目前虽然只需刷新的奖励， 但是也按全部刷新处理
        self:refreshFloatCloud(function()
            self:refreshAllLevelBtn()
            self:refreshVoidRiftView(self.selectedIcon:getTag())
        end)
    end
    self:addCurseBuffLayer()
    -- self:updateCurseBuffLayer()
    
end

function VoidRiftLevelSelectView:spineIconClickCallback(sender, _, touchPosition)
    local spineIcon = sender
    if self.lockAllBtn == false and self.mBClick == true and spineIcon.state == SpineIconStatus.haveUnLocked and not self.isFloatCloudAct and self.leftLayer:checkTouch(touchPosition) then  
        if self.selectedIcon ~= nil then
            self.selectedIcon:unLocked()
        end
        if "effect_ui_town_stageselect_distortedspace_hero_icon" == spineIcon.spineName then
            self.data.curDiff = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3
        elseif "effect_ui_town_stageselect_desert_icon" == spineIcon.spineName then
            self.data.curDiff = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2
        else
            self.data.curDiff = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
        end
        spineIcon:selected()
        self.selectedIcon = spineIcon
        LevelSelectUtil:getInstance().mSelectLevel = spineIcon:getTag()
        self.modeNameBgAnim:setAnimation("selectfloor", false)
        self:refreshVoidRiftView(self.selectedIcon:getTag())
        self:changeDiffcult(self.data.curDiff, false) 
        self:addCurseBuffLayer()
    end
    Avalon.AudioManager:playSound("1503")
end

function VoidRiftLevelSelectView:spineIconAnimEndCallback(sender, event, obj)
    if event.animation == "start2" then
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
                        self.data.curDiff,
                        id,
                        self.spriteID)
                    UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                elseif LevelSelectUtil:getInstance().mPattern == PublicDefine.GAME_MODE.MODE_MERCENARY then
                    local messageData = {}
                    messageData.difficulty = self.data.curDiff
                    messageData.level = id
                    messageData.caveMode = self.data.caveMode
                    messageData.mode = LevelSelectUtil:getInstance().mPattern
                    messageData.useSchemeInHero = useSchemeInHero
                    mvc.openPanel("Mercenary", "Mercenary", messageData)
                end
            end 
        else
            LevelSelectUtil:getInstance().mSelectLevel = self.selectedIcon:getTag()
            LevelSelectUtil:getInstance():setCaveMode(self.data.caveMode)
            LevelSelectUtil:getInstance():setDifficulty(self.data.curDiff)
            Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_LEVEL_SELECT_TEAM,1)
            self:clickClose()
        end
    elseif event.animation == "showup" then
        self.data.oldOpenLevel = self.data.oldOpenLevel <= 0 and 1 or self.data.oldOpenLevel
        sender:setBtnState(SpineIconStatus.haveUnLocked)
        self.data.oldOpenLevel =  self.data.oldOpenLevel + 10
        GameDataManager:getInstance():openCheckpoint(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, LevelSelectUtil:getBeginShopLevelForCaveLevel(self.data.oldOpenLevel))
        self.rootLayer:runAction(cc.Sequence:create(cc.DelayTime:create(0.01),cc.CallFunc:create(function()    
            self.lockAllBtn = false      
            self:showOpenAnimation(self.data.oldOpenLevel, self.data.curOpenLevel)
        end)))
    end
end

function VoidRiftLevelSelectView:spineIconAnimStartCallback(sender, event, obj)
    if event.animation == "showup" then
        Avalon.AudioManager:playSoundDelay("1520", 350)
    end
end

function VoidRiftLevelSelectView:refreshAllLevelBtn()
    for k, v in ipairs(self.levelBtnList) do
        local tag = v:getTag()
        local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(tag)
        local taskData = TaskDataManager:getVoidRiftTaskByLevel(level)
        local worldEvent = MasterDataManager:getWorldEventDataForID(level) 
        v:setZOrder(12)
        if (worldEvent and worldEvent:isHide()) then
            v:lock()
        elseif (worldEvent and  worldEvent:isValid()) or (taskData and not taskData:getIsReceived())  then
            v:setZOrder(200)
            v:changeSkin("effect_ui_town_stageselect_inferno_blue_personal_icon")
            v:unLocked()
        elseif self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2 then--精英模式
            v:changeSkin("effect_ui_town_stageselect_desert_icon")
            -- 
            if tag <= self.data.curOpenEliteLevel then     
                v:unLocked()           
            else
                v:lock()
            end            
        elseif self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then--精英模式
            -- stepName = "ui_selectfloor_plotmap_yellow_round%d.png"
            v:changeSkin("effect_ui_town_stageselect_distortedspace_hero_icon")
            if tag <= self.data.curOpenNightMareLevel then     
                v:unLocked()           
            else
                v:lock()
            end            
        else
            v:changeSkin("effect_ui_town_stageselect_icon")
            if tag <= self.data.curOpenLevel then
                v:unLocked()
            else
                v:lock()
            end
        end
        if self.selectedIcon:getTag() == v:getTag() and (worldEvent and not worldEvent:isHide()) then
            v:selected()
        end
    end
    return 
end

function VoidRiftLevelSelectView:refreshSweeping(levelBtn)
    levelBtn = levelBtn or self.selectedIcon
    if(levelBtn) then
        if self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2 then
            if(self.sweepingLayout:getParent()) then 
                self.sweepingLayout:removeFromParent(false)
            end
            levelBtn:addChild(self.sweepingLayout, 100)
            -- print("refreshSweeping", levelBtn:getTag())

            local masterData = RoleDataManager:getMaster()

            local id = LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(levelBtn:getTag())
            local baseNum = 10000 * self.data.caveMode
            baseNum = baseNum + 100 * self.data.curDiff
            baseNum = baseNum + id - PublicDefine.CONST_DEFINITION.SHOP_LEVEL_MIN + 1
            -- print("refreshSweeping", baseNum, masterData:checkCaveIndex(baseNum))
            self.sweepingLayout:setVisible(false)
            if masterData then
                local normalPointData = masterData:getCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1)
                local checkPointData = masterData:getCheckpointData(self.data.caveMode, self.data.curDiff)
                if (normalPointData and normalPointData:getCheckpoint() > id  or
                    checkPointData and checkPointData:getCheckpoint() > id) 
                    or masterData:checkCaveIndex(baseNum) then
                    self.sweepingLayout:setVisible(true)
                end
            end
            -- self.sweepingLayout:setVisible(true)

            local x, y = self:getSweedNumData()
            local haveNum = x
            if(x <= 0 and y>0) then 
                haveNum = y
                self.sweepingBtn:enable()
                self.sweepingIcon:setVisible(true)
                self.sweepingNum:centerLeft(133 + self.sweepingIcon:getContentSize().width)
                self.sweepingNum:setText(tostring("X"..haveNum))
            else
                self.sweepingBtn:enable()
                self.sweepingIcon:setVisible(false) 
                self.sweepingNum:centerLeft(137)
                self.sweepingNum:setText(tostring(haveNum))
            end
            
            if(haveNum <= 0) then 
                self.sweepingBtn:disable()
            end
            self.sweepingBg:setVisible(true)
        else
            self.sweepingBg:setVisible(false)
            self.sweepingLayout:setVisible(false)
            self.sweepingBtn:disable()
        end
    end
end

function VoidRiftLevelSelectView:clickSweeping()
    -- 处理相关的弹窗提示
    local x, y = self:getSweedNumData()
    require "app.ui.common.Dialog.slidingNumDialog"
    local id = LevelSelectUtil:getInstance():getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
    -- 这里使用了扭曲空间的次数
    local limitOneTime = tonumber(ConfigManager:getGeneralForKey("sweepDistortedSpaceLimitOneTime"))
    if(x <= 0) then 
        local maxNum = y
        maxNum = math.min(maxNum, limitOneTime)
        local sweepingGoodsData = GoodsDataManager:createLocalGoodsData(PublicDefine.ITEM_ID.ITEM_ID_SWEEP_VOIDRIFT)
        -- local sweepingGoodsData = GoodsDataManager:createLocalGoodsData(Game.ConstGoods.DreamIcon)
        sweepingGoodsData:setNum(y)
        local slidingNumDialog = UI.slidingNumDialog:showItemTile(sweepingGoodsData, 1, maxNum, function (sweepNum)
            local pk = RoleDataManager:getMaster():getPK()
            local sweepGoodData = GoodsDataManager:getGoodsDataForGoodsIDAndIsGolden(
                pk,
                PublicDefine.PACKET_TYPE.PACKET_BAG, 
                GoodsDataManager:getGoodsTypeForGoodsID(PublicDefine.ITEM_ID.ITEM_ID_SWEEP_VOIDRIFT), 
                PublicDefine.ITEM_ID.ITEM_ID_SWEEP_VOIDRIFT,
                false
            )
            if(sweepGoodData and sweepGoodData:getIsLock()) then 
                UI.ScrollBar:createByText(UI.TEXT_1212614)
                return
            end

            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetRoleSystem:sendRequestSweepDistortedSpace(id, sweepNum, true, PublicDefine.CAVE_MODE.MODE_VOID_RIFT)
        end)

        UI.UIManager:getRootNode():addChild(slidingNumDialog, 10000)
    else
        local maxNum = x
        maxNum = math.min(maxNum, limitOneTime)
        local slidingNumDialog = UI.slidingNumDialog:showTextTitle(UI.TEXT_1324350, x, 1, maxNum, function (sweepNum)
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetRoleSystem:sendRequestSweepDistortedSpace(id, sweepNum, false, PublicDefine.CAVE_MODE.MODE_VOID_RIFT)
        end)

        UI.UIManager:getRootNode():addChild(slidingNumDialog, 10000)
    end
end

--[[
    result:x,y   x 标识免费测试， y标识道具数量
]]
function VoidRiftLevelSelectView:getSweedNumData()
    -- 处理相关的弹窗提示
    local limitTime = tonumber(ConfigManager:getGeneralForKey("infernoSweepDistortedSpaceDailyLimit"))
    local pk = RoleDataManager:getMaster():getPK()
    local goodsNum = GoodsDataManager:getGoodsDataNum(pk, PublicDefine.PACKET_TYPE.PACKET_BAG, PublicDefine.ITEM_ID.ITEM_ID_SWEEP_VOIDRIFT, true)

    -- print("getSweedNumData", limitTime, MasterDataManager:getSweepDistortedSpaceNum(), goodsNum)
    return limitTime - mvc.caveModel:getVoidRiftSweepNum(), goodsNum
end

function VoidRiftLevelSelectView:refreshFightCount()
    if self.selectedIcon == nil then
        return
    end
    self.countBg:hide()
    if not self.heroBtn:isDisable() then
        local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
        local remainCount = mvc.caveModel:getVoidRiftEliteLostNum(level)
        -- add by zp CO-14886【扭曲扫荡】没有精英挑战次数时，无法进入扫荡界面
        -- if remainCount <= 0 then
        --     self.heroBtn:disable()
        --     self.countBg:hide()
        -- else
            self.countBg:show()
            self.countNum:setText(string.format(UI.TEXT_1212817, remainCount))
        -- end
    end

    self.nightMareCountBg:hide()
    if not self.nightMareBtn:isDisable() then
        local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
        local remainCount = mvc.caveModel:getVoidRiftNightMareLostNum()
        -- add by zp CO-14886【扭曲扫荡】没有精英挑战次数时，无法进入扫荡界面
        -- if remainCount <= 0 then
        --     self.heroBtn:disable()
        --     self.countBg:hide()
        -- else
            self.nightMareCountBg:show()
            self.nightMareCountNum:setText(string.format(UI.TEXT_1212817, remainCount))
        -- end
    end
end

--[[核心逻辑
  1、先判断有没有关卡对应的事件，如果有且未完成就显示事件界面
  2、判断有没有个人任务，如果有且未完成就显示个人任务
  3、如果都完成了且有进度数据了，就显示关卡数据
  4、判断是否解锁了对应的精英模式》〉》只影响右下角的按钮
]]
function VoidRiftLevelSelectView:refreshVoidRiftView(levelNum)
    local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(levelNum)
    local taskData = TaskDataManager:getVoidRiftTaskByLevel(level)
    print("refreshVoidRiftView", level, taskData)
    -- taskData = Data.TaskData:create(90001)
    -- taskData:initNet(task)
    self.plotPanel:hide()
    if taskData and not taskData:getIsReceived() then
        self.priTaskInfo:show()
        self.priTaskInfo:centerLeft(44)
        self.levelInfo:hide()
        self.shareRewardPanel:hide()
        self.shareRewardPanel:leftBottom(-winSize.width, 58)
        self.startBtn:show()
        if taskData:getIsFinish() then
            self.startBtn:enable()
            self.startText:setText(UI.TEXT_111035)
        else
            self.startBtn:disable()
            self.startText:setText(UI.TEXT_111022)
        end
        self.taskName:setText(taskData:getName())
        self.taskDesc:setText(taskData:getStory())
        self.taskNum:setText(string.format("%d/%d", taskData:getReachNum(), taskData:getTargetNum()))

        -- 处理滚动大小
        local height = self.taskDesc:getContentSize().height + 7
        local desScrollHeight = self.taskDescScrollView:getContentSize().height
        if height < desScrollHeight then
            height = desScrollHeight;
        end
        
        self.taskDescLayout:setSize(260, height)

        if self.taskRewardNode then
            self.taskRewardNode:removeFromParent()
        end
        local rewardNode = UI.RewardPreViewUtil:create()
        rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
        rewardNode:init(nil, 3, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(5, 0))
        rewardNode:leftBottom(16, 80)
        local idList = taskData.goodsRewards
        for k, v in pairs(idList) do 
            rewardNode:addGoodsId(tonumber(v), taskData.goodsRewardsNum[k] or 0)
        end
        rewardNode:showGoodsView()
        self.priTaskInfo:addChild(rewardNode)
        self.taskRewardNode = rewardNode

        local gateConfig = ConfigManager:getLevelSelectDataByLevel(LevelSelectUtil:getBeginCaveLevelForShopLevel(level), self.data.caveMode)
        if(gateConfig 
            and gateConfig.TaskDescription 
            and gateConfig.TaskDescription ~= 0) then
            self.plotPanel:show()
            self.plotDesc:setText(LanguageManager:getInstance():getLocalString(gateConfig.TaskDescription))
        end

        if self.totalPanel then
            self.totalPanel:hide()
        end
    else
        self.priTaskInfo:hide()
        self.priTaskInfo:centerLeft(-winSize.width)

        self.levelInfo:show()
        self.shareRewardPanel:show()
        self.shareRewardPanel:leftBottom(410, 58)
        self.startBtn:show()
        self.startBtn:enable()
        self.startText:setText(UI.TEXT_1212081)
        
        local list = ConfigManager:getAllLevelSelectDataByType(self.data.caveMode)
        local gateConfig = nil
        for k, v in ipairs(list) do
            for k2, cfgLevel in ipairs(v.includeLevel) do
                if levelNum == cfgLevel then
                    gateConfig = v
                    break
                end
            end
        end
        -- if self.totalPanel then
        --     self.totalPanel:hide()
        -- end
        -- print("---------gateConfig---------" , gateConfig.name, gateConfig.levelDescription)
        if gateConfig then
            local diff = self.data.curDiff
            self.floorName:setText(string.format(UI.TEXT_110001, levelNum))
            if #gateConfig.levelDescription < 1 then
                self.floorDesc:setText("")
            else
                self.floorDesc:setText(LanguageManager:getInstance():getLocalString(gateConfig.levelDescription[diff] or 0))
            end
            
            if self.levelRewardNode then
                self.levelRewardNode:removeFromParent()
            end
            local rewardNode = UI.RewardPreViewUtil:create()
            rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
            rewardNode:init(nil, 5, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(16, 0))
            rewardNode:leftBottom(11, -4)
            local rewardData = gateConfig.BoxDrop[diff] or ""
            local idList = string.split(rewardData, ",")
            for k, v in pairs(idList) do 
                local goodsId = checkint(v)
                if goodsId ~= 0 then
                    rewardNode:addGoodsId(goodsId, 0)
                end
            end
            rewardNode:showGoodsView()
            self.shareRewardPanel:addChild(rewardNode)
            self.levelRewardNode = rewardNode
        end
        if self.fisrtPassPanel == nil then
            local panel = self:createFisrtPassPanel()
            if panel then
                panel:leftUp(8, 62)
                self.levelInfo:addChild(panel, 1000)
                self.fisrtPassPanel = panel
                -- self.floorDesc:centerUp(157)
                -- self.floorName:centerUp(132)
            else
                -- self.floorDesc:centerUp(107)
                -- self.floorName:centerUp(82)
            end
        end
        self:refreshFisrtPassPanel(self.fisrtPassPanel, self.data.caveMode, self.data.curDiff, levelNum)
    end
    self.plotBtn:enable()
    if levelNum <= self.data.oldOpenNightMareLevel and self.data.oldOpenNightMareLevel > 0 then
        self.nightMareBtn:enable()
        self.nightMareEffectAction:setVisible(true)
        self.nightMareLockAction:hide()
    elseif levelNum <= self.data.curOpenNightMareLevel and self.data.curOpenNightMareLevel > 0 then
        GameDataManager:getInstance():openCheckpoint(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3, LevelSelectUtil:getBeginShopLevelForCaveLevel(self.data.curOpenNightMareLevel))
        self.data.oldOpenNightMareLevel = self.data.curOpenNightMareLevel
        -- local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2)
        -- local level = openCheckpointData:getCheckpoint()
        -- print("---level---", LevelSelectUtil:getBeginShopLevelForCaveLevel(self.data.curOpenEliteLevel), level)
        self.nightMareBtn:enable()
        self.nightMareEffectAction:setVisible(true)
        self.nightMareLockAction:show()
        self.nightMareLockAction:setAnimation("unlock", false)
    else
        self.nightMareBtn:disable()
        self.nightMareEffectAction:setVisible(false)
        self.nightMareLockAction:show()
        self.nightMareLockAction:setAnimation("idle", true)
        -- self.data.curDiff = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
    end

    if levelNum <= self.data.oldOpenEliteLevel and self.data.oldOpenEliteLevel > 0 then
        self.heroBtn:enable()
        self.heroLockAction:hide()
    elseif levelNum <= self.data.curOpenEliteLevel and self.data.curOpenEliteLevel > 0 then
        GameDataManager:getInstance():openCheckpoint(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2, LevelSelectUtil:getBeginShopLevelForCaveLevel(self.data.curOpenEliteLevel))
        self.data.oldOpenEliteLevel = self.data.curOpenEliteLevel
        -- local openCheckpointData = GameDataManager:getInstance():getOpenCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2)
        -- local level = openCheckpointData:getCheckpoint()
        -- print("---level---", LevelSelectUtil:getBeginShopLevelForCaveLevel(self.data.curOpenEliteLevel), level)
        self.heroBtn:enable()
        self.heroLockAction:show()
        self.heroLockAction:setAnimation("unlock", false)
    else
        self.heroBtn:disable()
        self.heroLockAction:show()
        self.heroLockAction:setAnimation("idle", true)
        self.data.curDiff = PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1
    end
    self:refreshFightCount()
    self:refreshSweeping(self.selectedIcon)
end


function VoidRiftLevelSelectView:getMBKNumber(number, size)
    local text = tonumber(number)
    local numberSize = AvalonUtil:getNumberSize(text)
    if numberSize > size and size ~= 0 then
        text = AvalonUtil:getSimpleNumber(text, size)
    else
        text = AvalonUtil:getCommaNumber(text)
    end
    return text
end

function VoidRiftLevelSelectView:createToTalTaskCell(worldEvent )
    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(240, 80)

    local name = UI.Text:create()
    name:init(worldEvent:getEventName(), UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_51_51_51)
    name:centerUp(-4)
    panel:addChild(name) 
    name:setRotationSkewY(-6)

    local desc, percent = worldEvent:getDesc()
    local proBG = cc.Sprite:createWithSpriteFrameName("ui_distortedSpace_banner_countdown_box.png")
    proBG:setPosition(132, 50)
    panel:addChild(proBG)

    local pro = cc.ProgressTimer:create(cc.Sprite:createWithSpriteFrameName("ui_distortedSpace_banner_countdown.png"))
    pro:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    pro:setMidpoint(cc.p(0,0))
    pro:setBarChangeRate(cc.p(1,0))
    pro:setPosition(cc.p(proBG:getContentSize().width/2, proBG:getContentSize().height/2))
    proBG:addChild(pro, 20)
    pro:setPercentage(percent * 100)
    local color = UI.FONT_COLOR_102_0_0
    if percent >= 1 then
        color = UI.FONT_COLOR_0_102_51
    end
    local str = percent == 0 and "0%" or string.format("%0.2f%%", percent * 100)
    local proDes = AvalonUtil:serializeText(UI.TEXT_1212816, AvalonUtil:colorRGB2Str(UI.FONT_COLOR_51_51_51), UI.FONT_SIZE_15PX, UI.FONT_STANDARD)
    local proNum = AvalonUtil:serializeText(str, AvalonUtil:colorRGB2Str(color), UI.FONT_SIZE_15PX, UI.FONT_STANDARD)
    local richText = UI.RichText:create()
    local success = richText:init(proDes..proNum, 20, 20, true)
    richText:centerBottom(20)
    panel:addChild(richText) 
    richText:setRotationSkewY(-5)
    return panel
end


function VoidRiftLevelSelectView:openShowAction(isOpen)
    if isOpen then
        Avalon.AudioManager:playSound("1501")
        local offX = 10
        local time1 = 0.15 * 1
        local time2 = 0.1 * 1
        local leftLayerPosOffset = 0
        local xPos = 0
        local yPos = LayerSize.height / 2
        self.leftLayer._enableAutoUpdatePos = false
        self.leftLayer:setIgnoreAnchorPointForPosition(false)
        self.leftLayer:setAnchorPoint(0, 0.5)
        self.leftLayer:setVisible(false)

        Avalon.Scheduler:scheduleUpdateOnce(self, function() 
            self.leftLayer:setPosition(-self.leftLayer._width - xPos, LayerSize.height / 2)
            self.leftLayer:setVisible(true)
            local move1 = cc.EaseOut:create(cc.MoveTo:create(time1 - time1 / 10, cc.p(xPos + offX, yPos)), 1)
            local move2 = cc.EaseInOut:create(cc.MoveTo:create(time2, cc.p(xPos, yPos)), 7)
            self.leftLayer:runAction(cc.Sequence:create(move1, move2))
        end, 0.1)
    else
        Avalon.AudioManager:playSound("1502")
        self:runAction(cc.Sequence:create(cc.MoveTo:create(0.1, cc.p(-winSize.width, self:getPositionY())),cc.CallFunc:create(function()
            mvc.closePanel("Cave", "VoidRiftLevelSelect")
        end)))
    end
end

function VoidRiftLevelSelectView:refreshFloatCloud(callback)
    if self.floatCloud == nil then
        local floatCloud = UI.Animation:create()
        floatCloud:init("effect_ui_town_stageselect_cloud.json", "effect_ui_town_stageselect_cloud.atlas", 1)
        floatCloud:setSize(ScrollViewSize.width, ScrollViewSize.height)
        self._scrollView:addChild(floatCloud, 15)
        self.floatCloud = floatCloud
        self.lockAllBtn = true
        floatCloud:addEventListener(UIEvent.ANIMATION_COMPLETE,self,function(sender, event)
            if event.animation == "stageselect_open" then
                self.floatCloud:destroy()
                self.floatCloud = nil
                self.lockAllBtn = false
                self.isFloatCloudAct = false
            elseif event.animation == "stageselect_close" then
                self.floatCloud:setAnimation("stageselect_open", false)
                self.lockAllBtn = false
                self.isFloatCloudAct = false
                if callback then
                    callback()
                end
            end
        end)
    end

    self.floatCloud:setAnimation("stageselect_close", false)
    self.isFloatCloudAct = true
end

-- 进入洞穴反馈消息
function VoidRiftLevelSelectView:enterCaveResult(data)
    if(data and data.result ~= "EnterCaveSceneResult_Succeed") then 
        GameErrorManager:showError(ProtobufUtil:enum_id("RoleSystem.EnterCaveSceneResult", data.result))
    end
    UI.WaitingLayer:hideWaiting()
end

function VoidRiftLevelSelectView:clickClose()
    self:openShowAction(false)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
end

-- 点击外部区域的处理器
local function onTouchDialogOutsizeHandler(self, _, _, touchPosition)
    self:clickClose()
end

function VoidRiftLevelSelectView:unlockButtons()
    self.lockAllBtn = false
end

function VoidRiftLevelSelectView:onTaskComplete(completeData)
    if self.selectedIcon == nil then
        return
    end
    local isOpen = false
    local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
    if completeData.accepteTask == nil or (completeData.accepteTask:getExtendValue() ~= level) then
        self.data.curOpenLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getMaster():getCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1):getCheckpoint())
        self.data.curOpenEliteLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2):getCheckpoint())
        self.data.curOpenNightMareLevel = LevelSelectUtil:getBeginCaveLevelForShopLevel(RoleDataManager:getCheckpointData(self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3):getCheckpoint())
        self.data.oldOpenNightMareLevel = self.data.curOpenNightMareLevel
        self.data.oldOpenLevel = self.data.curOpenLevel
        isOpen = true
    end

    
    if completeData and completeData.completeTask and level == completeData.completeTask:getExtendValue() then
        if isOpen then 
            for k, v in ipairs(self.cloudList) do
                if not tolua.isnull(v) and v:getTag() == self.selectedIcon:getTag() then
                    v:setAnimation(v:getName(), false)
                end
            end
        end
        self:refreshAllLevelBtn()
        self:refreshVoidRiftView(self.selectedIcon:getTag())
    end
end

function VoidRiftLevelSelectView:selectButton(gameMode)
--     self.singlePlayBtn:setBtnStatus(ButtonState.NORMAL)
--     if not self.teamPlayBtn:isDisable() then
--         self.teamPlayBtn:setBtnStatus(ButtonState.NORMAL)
--     end
--     if btnId == PublicDefine.GAME_MODE.MODE_SOLO then
--         self.singlePlayBtn:setBtnStatus(ButtonState.ACTIVE)
--     else
--         if not self.teamPlayBtn:isDisable() then
--             self.teamPlayBtn:setBtnStatus(ButtonState.ACTIVE)
--         end
--     end
    self:refreshTeamBtnState()
    self:refreshGameModeBtnCheckState(gameMode)
    LevelSelectUtil:getInstance():setPattern(gameMode)
    self:refreshNotice(gameMode)
end

function VoidRiftLevelSelectView:refreshNotice(btnId)
    -- add by zp 单人挑战更新个人进度提示语言
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

function VoidRiftLevelSelectView:startGame()
    -- 非精英模式才防沉迷, 精英模式有次数限制
    require "app.utils.AntiAddictionUtil"
    if (self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1 and 
        not AntiAddictionUtil:isAbleToEnterCave()) 
    then
        require "app.ui.common.Dialog.ScrollBar"
        UI.ScrollBar:createByTextID(1170192)
        return
    end
    
    if self.lockAllBtn then
        print("--VoidRiftLevelSelectView:startGame but self.lockAllBtn is true")
        return
    end
    local taskData = nil
    if self.selectedIcon then
        local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())
        taskData = TaskDataManager:getVoidRiftTaskByLevel(level)
    end
    if taskData then
        local goodsArr = {}
        for k,goods in pairs(taskData._rewardGoodsArr) do
            local data = {}
            data.goodsID = goods.goodsID
            data.num = goods.num
            data.isGolden = true--goods.isGolden
            table.insert(goodsArr, data)
        end
            -- 判断背包是否满了
        local enough = GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodsArr)
        if not enough then   
            UI.ScrollBar:createByTextID(1110793)
            return
        end
        if taskData:checkIsLockCollectItem() then
            UI.ScrollBar:createByTextID(1170266)
            return
        end
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        GameManager:completeTastRequest(taskData)
        Avalon.AudioManager:playSound("1509")
    else
        --检查是否解锁
        if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) == false then 
            UI.ScrollBar:createByTextID(1170189)
            return
        end
        -- 检查答题限制,如果返回true 说明是属于小黑屋,不能进入战斗
        if not AnswerDataManager:canEnterCave() then
            local time = AnswerDataManager:getNextEnterCaveSecRemind()
            local h = math.floor( time / 3600 )
            local m = math.ceil((time - h * 3600) / 60)
            UI.ConfirmDialog.showConfrimOnly(string.format(LanguageManager:getInstance():getLocalString(1170210),h,m), nil, nil, nil, nil)
            return
        end

        if (self.data.caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT 
            and self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3) then
            local lostNum =  mvc.caveModel:getVoidRiftNightMareLostNum()
            if lostNum <= 0 then
                UI.ScrollBar:createByText(UI.TEXT_1212818)
                return
            end
        end

        if (self.data.caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT 
            and self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_2) then
            local level = LevelSelectUtil:getBeginShopLevelForCaveLevel(self.selectedIcon:getTag())

            local lostNum =  mvc.caveModel:getVoidRiftEliteLostNum(level)
            if lostNum <= 0 then
                UI.ScrollBar:createByText(UI.TEXT_1212818)
                return
            end
        end

        -- 如果 worldboss 已报名，提醒一次
        local function clickFunc() 
            -- 判断是否需要弹出次数提醒框
            if (self.data.caveMode == PublicDefine.CAVE_MODE.MODE_VOID_RIFT 
                and self.data.curDiff == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3) then
                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                    string.format(UI.TEXT_1325509, mvc.caveModel:getVoidRiftNightMareLostNum()),
                    function()
                        if self.selectedIcon and self.selectedIcon.showStartAnimation then
                            self.lockAllBtn = true
                            self.mBClick = false
                            self:handleStartGame()
                        end
                    end
                )
            else
                if self.selectedIcon and self.selectedIcon.showStartAnimation then
                    self.lockAllBtn = true
                    self.mBClick = false
                    self:handleStartGame()
                end
            end
        end

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
end

function VoidRiftLevelSelectView:handleStartGame()
    self.selectedIcon:showStartAnimation()
end

function VoidRiftLevelSelectView:refreshTeamBtnState()
    self:refreshGameModeState()
end

function VoidRiftLevelSelectView:showStarInfo()
    if self.infoPanel == nil or tolua.isnull(self.infoPanel) then
        local offsetY = 85
        local panel = UI.Image:create()
        panel:init("ui_information_banner_details.png")
        panel:centerLeft(390)
        self.leftLayer:addChild(panel, 100)
        
        local title = UI.Text:create()
        title:init(LanguageManager:getInstance():getLocalString(1112499), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_51_51_51)
        panel:addChild(title) 
        title:centerUp(16 + offsetY)

        local line = UI.Image9:create()
        line:init("ui_scale9image_banner_line_long.png", CCRectMake(20,1,1,1), cc.size(282, 2))
        line:centerUp(45 + offsetY)
        panel:addChild(line)

        local desc = UI.Text:create()
        desc:init(LanguageManager:getInstance():getLocalString(1114805), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_51_51_51)
        desc:setWidth(280)
        desc:autoAdapt()
        desc:centerUp(1)

        local height = desc:getContentSize().height
        height = height < 320 and 320 or height
        local layout = UI.Layout:create()
        layout:init()
        layout:setSize(280, height)
        if height > 320 then
            local scrollView = UI.ScrollView:create()
            scrollView:setSize(290, 320)
            scrollView:init()
            -- scrollView:leftUp(25, 55)
            scrollView:centerUp(55 + offsetY)
            scrollView:addInnerNode(layout)
            scrollView:useDefaultScrollBar()
            panel:addChild(scrollView)    
        else
            layout:centerUp(55 + offsetY)
            panel:addChild(layout)
        end
        layout:addChild(desc)

        panel:setTouchEnable(true)
        panel:setInterceptTouches(true)
        panel:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, panel, function()
            panel:removeFromParent()
        end)
    else
        self.infoPanel:show()
    end
end

function VoidRiftLevelSelectView:clickClose()
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

function VoidRiftLevelSelectView:firstPassCallback(data)
    if data.mode == self.data.caveMode then
        self:refreshFisrtPassPanel(self.fisrtPassPanel, self.data.caveMode, PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_1, LevelSelectUtil:getInstance().mSelectLevel)
    end
end

function VoidRiftLevelSelectView:addCurseBuffLayer()
    -- print("addCurseBuffLayer1", RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift))
    if not self.selectedIcon or RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_VoidRift) == false then
        return 
    end
    local debuffLayout1 = self.floatCloudCliper:getChildByName("debuffLayout")
    if debuffLayout1 then
        debuffLayout1:removeFromParent(true)
        debuffLayout1 = nil
    end
    local infoBg = self.floatCloudCliper:getChildByName("infoBg")
    if infoBg then
        infoBg:removeFromParent(true)
        infoBg = nil
    end

    local debuffLayout = UI.Layout:create()
    debuffLayout:init()
    debuffLayout:leftUp(30, -50)
    debuffLayout:setSize(85, 262)
    -- debuffLayout:enableDebugDraw()
    debuffLayout:setName("debuffLayout")
    self.floatCloudCliper:addChild(debuffLayout, 300)
    -- local b = self.defaultNomalSelectIcon and true or false
    -- debuffLayout:setVisible(b)

    local debuffBg = UI.Image:create()
    debuffBg:init("ui_uncharted_banner.png")
    debuffBg:center()
    debuffLayout:addChild(debuffBg)

    local debuffTile = UI.Text:create()
    debuffTile:init(UI.TEXT_222110, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_219_222_221)
    debuffTile:centerUp(5)
    debuffLayout:addChild(debuffTile)

    self.config = mvc.caveModel:getCurseBuffConfig()
    local level = self.selectedIcon and self.selectedIcon:getTag() or self.data.curOpenLevel 
    
    self.curLevelCurseBuffConfig = self:curLevelBuffFilter(self.config[self.data.curDiff], level)
    local buffCount = #self.curLevelCurseBuffConfig
    self._tableView = UI.TableView.new({}, CELL_WIDTH, 180)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    -- self._tableView:leftUp(20, 40)
    self._tableView:centerUp(58)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true)
    self._tableView:init()
    self._tableView:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH, CELL_HEIGHT
    end)

    self._tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createCurseBuffCell(index)
            end,
            function(e)
                printError("------------------------VoidRiftLevelSelectView:tableCellAtIndex-----------------error")
            end, 1)
        else
            if cell and not tolua.isnull(cell) then
                cell:removeFromParent(true)
                cell = nil
            end
            cell = self:createCurseBuffCell(index)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function ()
        return self:getCellNumber()
    end)

    self._tableView:onTableCellTouched(function(table, cell)
        local index = cell:getIdx() + 1
        local buffCell = cell:getChildByName("buffCell")
        if buffCell then
            buffCell:showInfo()
        end
    end)

    debuffLayout:addChild(self._tableView, 1000)
    self._tableView:reloadData(true)
end

function VoidRiftLevelSelectView:createCurseBuffCell(index)
    if not self.curLevelCurseBuffConfig[index] then
        return nil
    end
    local buffCount = #self.curLevelCurseBuffConfig
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))
    local buffCell = mvc.voidRiftCurseBuffCellView:create()--UI.VoidRiftCurseBuffCell:create()
    buffCell:init(self.curLevelCurseBuffConfig[index], self.floatCloudCliper)
    buffCell:center()
    buffCell:setName("buffCell")
    cell:addChild(buffCell)

    return cell
end

function VoidRiftLevelSelectView:updateCurseBuffLayer() 
    self.curLevelCurseBuffConfig = self:curLevelBuffFilter(self.config[self.data.curDiff], self.selectedIcon:getTag())
    self._tableView:reloadData(true)
end

function VoidRiftLevelSelectView:getSelectIconIdx()
    return self.selectedIcon:getTag()
end

function VoidRiftLevelSelectView:curLevelBuffFilter(data, level)
    local btnIndex = LevelSelectUtil:getBeginShopLevelForCaveLevel(level)
    local index = btnIndex%2000
    -- print("curLevelBuffFilter:",level, btnIndex, index )
    local curLevelConfig = {}
    for k, v in pairs(data) do
        if v.level == index then
            table.insert(curLevelConfig, v)
        end
    end
    return curLevelConfig
end

function VoidRiftLevelSelectView:getCellNumber()
    return #self.curLevelCurseBuffConfig
end

function VoidRiftLevelSelectView:bindModel()
    --监听窗口外关闭事件
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_LEVEL_SELECT_ENTER_CAVE, self, self.enterCaveResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.onTaskComplete)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_VOIDRIFT_FIGHT_COUNT, self, self.refreshFightCount)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_REFRESH_FIRST_PASS, self, self.firstPassCallback) 
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_SWEEP_VOIDRIFT_RESPONSE, self, self.refreshSweeping) 
end


function VoidRiftLevelSelectView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_LEVEL_SELECT_ENTER_CAVE, self, self.enterCaveResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_TASK_COMPLETE_TASK, self, self.onTaskComplete)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_VOIDRIFT_FIGHT_COUNT, self, self.refreshFightCount)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_REFRESH_FIRST_PASS, self, self.firstPassCallback)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_SWEEP_VOIDRIFT_RESPONSE, self, self.refreshSweeping) 
end





return VoidRiftLevelSelectView












