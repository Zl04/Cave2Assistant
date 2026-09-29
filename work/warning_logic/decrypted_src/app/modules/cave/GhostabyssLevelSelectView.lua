------------------------------------------------------------------------------
--author: ping.zhengping
--date	: 2021/10/18
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GhostabyssLevelSelectView = class("GhostabyssLevelSelectView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local winSize = cc.Director:getInstance():getWinSize()

require("app.utils.RewardPreViewUtil")
require("app.modules.cave.GhostabyssChoiceLevelView")
require("app.modules.cave.GhostabyssDiffcultyChoiceView")

-- 资源
local COM_RES_LIST = {
    "ui_town_levelselect.plist",
    "ui_town_ghostabyss.plist",
    "ui_town_dungeon.plist"
}

local COM_WIDTH = 852
local COM_HEIGHT = 534

local LV_SELECT_WIDTH = 700
local LV_SELECT_HEIGHT = 580

function GhostabyssLevelSelectView:ctor()
    GhostabyssLevelSelectView.super.ctor(
    	self,
    	UI.Type.GHOSTABYSS_LEVEL_SELECT,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    mvc.caveModel:setGhostabyssChoiceLevel(0)
    self:bindModel()
end

function GhostabyssLevelSelectView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.cave", "Cave", false)
    GhostabyssLevelSelectView.super.init(self, ... )
end

function GhostabyssLevelSelectView:dtor()
    GhostabyssLevelSelectView.super.dtor(self)
    self:unbindModel()
    mvc.caveModel:setGhostabyssChoiceLevel(0)
    reload_script_file_mvc("app.modules.cave.GhostabyssLevelSelectView")
end


function GhostabyssLevelSelectView:onInitView()
    self:setSize(996, 549)
    self:setTouchEnable(true)

    local halfBg = UI.Image9:create()
    halfBg:init("ui_ghostabyss_up_02.png", CCRectMake(2,2,1,1), cc.size(winSize.width*2, winSize.height*2))
    halfBg:center()
    self:addChild(halfBg)
    

    self:rightLayer();
    self:leftLayer();

    self:refreshChoiceLevel()
end

function GhostabyssLevelSelectView:leftLayer()
    local leftBg = UI.Image:create()
    leftBg:init("ui_ghostabyss_bg_01.png")
    leftBg:leftBottom(-50, 0)
    self:addChild(leftBg,200)

    -- 标题
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_110001, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText:centerBottom(347-titleText:getContentSize().height/2)
    leftBg:addChild(titleText)
    self.levelTitle = titleText

    local leftLine = UI.Image:create()
    leftLine:init("ui_ghostabyss_line_02.png")
    leftLine:centerLeft(-leftLine:getContentSize().width - 10)
    titleText:addChild(leftLine)

    local rightLine = UI.Image:create()
    rightLine:init("ui_ghostabyss_line_02.png")
    rightLine:setScale(-1)
    rightLine:centerRight(-leftLine:getContentSize().width - 10)
    titleText:addChild(rightLine)

    local desText = UI.Text:create()
    desText:init(UI.TEXT_110001, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    desText:centerUp(40)
    desText:setWidth(230)
    desText:setTextLeftUp()
    titleText:addChild(desText)
    desText:autoAdapt()
    self.levelDes = desText


    -- 按钮以及次数
    local numText = UI.Text:create()
    numText:init(UI.TEXT_1212083, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_181_171_171)
    numText:centerBottom(54)    
    leftBg:addChild(numText)
    self.numText = numText

    self.challengeBtn = UI.Button:create()
    self.challengeBtn:init("ui_ghostabyss_btn_01.png", "ui_ghostabyss_btn_02.png", "ui_ghostabyss_btn_01.png")
    self.challengeBtn:centerBottom(11)
    self.challengeBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.challengeBtnClick)
    self.challengeBtn:addEventListener(UIEvent.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(UI.TEXT_1212646)
    end)

    self.challengeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_22PX, {r = 71,g = 197,b = 124})
    self.challengeBtn:setText(UI.TEXT_1212081)

    leftBg:addChild(self.challengeBtn, 10)
end

function GhostabyssLevelSelectView:rightLayer()
    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:setSize(764,548)
    rightLayout:centerRight(0)
    self:addChild(rightLayout)
    self.rightLayout = rightLayout
    -- rightLayout:enableDebugDraw()

    local rightBg = UI.Image:create()
    rightBg:init("ui_ghostabyss_bg_02.png")
    rightBg:center()
    rightLayout:addChild(rightBg)

    -- 标题
    -- local titleBg = UI.Image:create()
    -- titleBg:init("ui_dungeon_title.png")
    -- titleBg:centerUp(13)
    -- rightLayout:addChild(titleBg, 100)
    self.changeLevelBtn = UI.Button:create()
    self.changeLevelBtn:init("ui_ghostabyss_title_01.png", "ui_ghostabyss_title_01.png", "ui_ghostabyss_title_01.png")
    self.changeLevelBtn:centerUp(10)
    self.changeLevelBtn:addEventListener(UI.Event.BUTTON_CLICK, self, self.changeLevelBtnClick)
    rightLayout:addChild(self.changeLevelBtn, 10)

    -- 上部标题文字
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_1328000, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=203,g=216,b=217})
    titleText:center()
    self.changeLevelBtn:addChild(titleText,10)
    self.titleText = titleText

    -- 中间背景
    -- local centerBg = UI.Image:create()
    -- centerBg:init("ui_ghostabyss_bg_03.png")
    -- centerBg:rightBottom(36, 118)
    local centerBg = UI.Animation:create()
    centerBg:init("effect_ui_ghostabyss_bg.json", "effect_ui_ghostabyss_bg.atlas", 1)
    centerBg:setAnimation("idle", true)
    centerBg:centerRight(370, -31)
    rightLayout:addChild(centerBg)

    -- 处理奖励物品
    local rewardTip = UI.Text:create()
    rewardTip:init(
        UI.TEXT_1328001,
        UI.FONT_BOLD,
        UI.FONT_SIZE_18PX,
        {r=195,g=195,b=195}
    )
    rewardTip:centerBottom(100- rewardTip:getContentSize().height/2)
    rightLayout:addChild(rewardTip, 10)

    local lineWidth = 51

    local lineL = UI.Image9:create()
    lineL:init("ui_scale9image_banner_line_dark.png", CCRectMake(1,0,1,1), cc.size(lineWidth, 1))
    lineL:centerLeft(- lineL:getContentSize().width - 20)
    rewardTip:addChild(lineL, 10)

    local lineR = UI.Image9:create()
    lineR:init("ui_scale9image_banner_line_dark.png", CCRectMake(1,0,1,1), cc.size(lineWidth, 1))
    lineR:centerRight(- lineR:getContentSize().width - 20)
    rewardTip:addChild(lineR, 10)
end

function GhostabyssLevelSelectView:challengeBtnClick()
    mvc.send(mvc.events.ShowGhostabyssDiffcultyChoice)
end

function GhostabyssLevelSelectView:changeLevelBtnClick()
    mvc.send(mvc.events.ShowGhostabyssChoiceLevel, function()
        print("GhostabyssLevelSelectView:changeLevelBtnClick")
        if(not tolua.isnull(self)) then
            self:refreshChoiceLevel()
        end
    end)
end

function GhostabyssLevelSelectView:refreshChoiceLevel()
    self.choiceData = mvc.caveModel:getCurrentGhostabyssData()

    self:refreshLeftView()
    self:refreshAwards()
end

function GhostabyssLevelSelectView:refreshLeftView()
    if(self.choiceData) then
        self.levelTitle:setText(string.format(UI.TEXT_110001, self.choiceData.ID))
        self.levelDes:setText(self.choiceData.description)
    end
    local exchangeNum = mvc.caveModel:getGhostAbyssExchangeNum()
    if(exchangeNum <= 0) then
        self.challengeBtn:disable()
        self.numText:setText(UI.TEXT_1212646)
    else
        self.challengeBtn:enable()
        self.numText:setText(UI.TEXT_1212083..exchangeNum)
    end
end

function GhostabyssLevelSelectView:refreshAwards()
    if(self.choiceData == nil) then
        return
    end
    if(self.titleText) then 
        self.titleText:setText(string.format(UI.TEXT_1328000, self.choiceData.ID))
    end

    local taskData = {}
    taskData.goodsRewards = self.choiceData.showReward
    taskData.goodsRewardsNum = {}

    if self.taskRewardNode then
        self.taskRewardNode:removeFromParent()
    end
    local rewardNode = UI.RewardPreViewUtil:create()
    rewardNode:setShowTipPosType(UI.RewardPreViewUtil.TipPosType.center)
    rewardNode:init(nil, 7, 1, UI.ScrollType.HORIZONTAL, cc.size(5, 0), true, cc.size(5, 0))
    rewardNode:leftBottom(135, 6)
    local idList = taskData.goodsRewards
    for k, v in pairs(idList) do 
        rewardNode:addGoodsId(tonumber(v), taskData.goodsRewardsNum[k] or 0)
    end
    rewardNode:showGoodsView()
    self.rightLayout:addChild(rewardNode)
    self.taskRewardNode = rewardNode
end

function GhostabyssLevelSelectView:bindModel()

end


function GhostabyssLevelSelectView:unbindModel()

end





return GhostabyssLevelSelectView












