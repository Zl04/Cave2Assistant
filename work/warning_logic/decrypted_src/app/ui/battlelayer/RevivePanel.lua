-- RevivePanel.lua
-- Author:zp
-- 2017年5月18日
-- Using:复活界面

require "app.ui.Component"
require "app.ui.common.Button"
require "utils.MathUtil"

local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")

local winSize = cc.Director:getInstance():getWinSize()
local CELL_NUMBER = 8

UI = UI or {}

local RevivePanel = class("RevivePanel", UI.HWBtnComponent)
UI.RevivePanel = RevivePanel

-- private:
local DEBUG = true
local director = cc.Director:getInstance()
local winSize = director:getWinSize()

-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
-- 资源
local COM_RES_LIST = {
    "ui_town_dungeon.plist",
}

local REVIVE_BTN_NOMRL = "ui_btn_yellow4_0.png"
local REVIVE_BTN_CLICK = "ui_btn_yellow4_1.png"
local REVIVE_BTN_DISABLE = "ui_btn_yellow4_2.png"

local DIAMON_ICON_SPRITE = "symbol_gaming_diamond.png"

-- 构造函数
function RevivePanel:ctor()
    RevivePanel.super.ctor(self, UIType.REVIVE_VIEW, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self._waitingTime = 0
    -- 获取该数值
    self._countDown = CAVE_REVIVE_WAITING_TIME
    self._pause = false
    self._reviveAnimation = nil
    self._freeRevive = false

    self._okLabel = nil
    self._diamondLabel = nil

    self.allGridNode = {}

    if (SceneManager:getInstance():isInStory()) then
        -- 直接复活
        GameManager:battleReviveHelp(self._target:getSpriteID(), self:getReviveEndDiamond())
        self:close()
    else 
        self.lostData = GameDataManager:getInstance():getLostData()
        self.rewardCoin = self.lostData.rewardCoin

        if SceneManager:getInstance():isInHuLu() then 
            self._freeRevive = false
        else
            local master = GameDataManager:getInstance():getMaster()
            if(master) then 
                self._freeRevive = master:getIsReviveFree()
                self._isFristFreeRevive = master:getIsFirstFree()
                -- 这里把第一次免费复活和免费复活给做了逻辑处理
                if(self._isFristFreeRevive) then
                    self._freeRevive = false
                end
            end
        end

        Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.reviveEnd)
        Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_REVIVE_CONTINUE, self, self.continue)
        Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshDiamondFontColor)
        Avalon.MessageCenter:bind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshDiscountRefresh)
        Avalon.MessageCenter:bind(AvalonMessage.MC_IPASHOP_CLOSE, self, self.resumeCountDown)
    end
end

function RevivePanel:resumeCountDown()
    if(self and not tolua.isnull(self)) then
        self._countDown = CAVE_REVIVE_WAITING_TIME
        -- 恢复倒计时
        self:resureAnimation()
    end
end
function RevivePanel:reviveEnd(heroData)
    if(heroData and heroData:isMasterHero()) then
        self:runAction(cc.RemoveSelf:create())
    end
end

function RevivePanel:continue()
    self:hideLoading()
    self:resureAnimation()
end

-- 踢出暂停
function RevivePanel:kickPause()
    self:pauseAnimation()

    -- 隐藏某些表现
    if(self._slotAnimation) then 
        self._slotAnimation:setVisible(false)
    end
    if(self._reviveButton) then
        self._reviveButton:setVisible(false)
    end
    if(self._cancelButton) then
        self._cancelButton:setVisible(false)
    end
end

-- 析构函数
function RevivePanel:dtor()
    self._pause = false
    self._reviveButton = nil
    self._cancelButton = nil

    self._okLabel = nil
    self._diamondLabel = nil

    RevivePanel.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_START, self, self.reviveEnd)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_REVIVE_CONTINUE, self, self.continue)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshDiamondFontColor)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_ACTIVITY_REFRESH, self, self.refreshDiscountRefresh)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_IPASHOP_CLOSE, self, self.resumeCountDown)
    
end

-- public:
-- 初始化
function RevivePanel:init()
    RevivePanel.super.init(self)
    self:setTouchEnable(true)
    self._pause = false
end

-- 初始化视图
function RevivePanel:onInitView()
    -- 添加一个半透明背景
    local blackBg = cc.LayerColor:create(cc.c4b(0,0,0,120))
    blackBg:setContentSize(winSize.width, winSize.height)
    -- blackBg:setPosition(winSize.width/2, winSize.height/2)
    self:addChild(blackBg)

    -- 添加结算页面
    local reviveAnimation = Avalon.Animation:create("effect_ui_gaming_count_dead.json", "effect_ui_gaming_count_dead.atlas", 1);
    reviveAnimation:setAnimation(0, "start",false)
    reviveAnimation:addAnimation(0, "idle1", true)
    reviveAnimation:setPosition(cc.p(winSize.width/2, winSize.height /2))

    reviveAnimation:setScale(ToolsUtil:getAdaptationMaxScale())

    self:addChild(reviveAnimation)
    self._reviveAnimation = reviveAnimation

    local slotLayout = UI.Layout:create()
    slotLayout:init(0, 0)
    self:addChild(slotLayout)
    slotLayout:centerBottom(winSize.height/2 + 750/2 - 65)

    local slotAnimation = Avalon.Animation:create("effect_ui_gaming_count_dead.json", "effect_ui_gaming_count_dead.atlas", 1);
    slotAnimation:setAnimation(0, "idle2", true)
    slotLayout:addChild(slotAnimation)
    -- slotAnimation:setPosition(cc.p(winSize.width/2, winSize.height /2))
    slotAnimation:setPosition(cc.p(0, 0))
    
    self._slotAnimation = slotAnimation

    -- 添加挂载点
    print("RevivePanel  create label")
    local countTimeLabel = cc.LabelAtlas:create(string.format("%d",self._countDown), "ui_dead_number.png", 80, 120, 48)
    countTimeLabel:setAnchorPoint(cc.p(0.5, 0.5))
    slotAnimation:addComponent("count-dead-number1", countTimeLabel)
    countTimeLabel:setScale(0.8)
    Avalon.AudioManager:playSound("506")
    
    local this = self
    slotAnimation:registerSpineEventHandler(function (event)
        if(self._countDown > 0) then                            
            self._countDown = self._countDown - 1
            Avalon.AudioManager:playSound("506")
        end
        -- 更新倒计时显示
        countTimeLabel:setString(string.format("%d",self._countDown))

        -- 判断切换倒计时完成
        if self._countDown == 1 then
            -- 播放最后的动画
            self._reviveAnimation:setAnimation(0, "end", false)
        end

        if(self._countDown == 0) then
            self:showLoading()
            Net.NetRoleSystem:heroDeadSelectionRequest()
            this:pauseAnimation()
        end
    end, sp.EventType.ANIMATION_COMPLETE)

    self.centerLayout = UI.Layout:create()
    self.centerLayout:init()
    self.centerLayout:setSize(709,305)
    self.centerLayout:center()
    self:addChild(self.centerLayout)

    -- 提示语言
    local tipsText = UI.Text:create()
    tipsText:init(LanguageManager:getInstance():getLocalString(1111285),UI.FONT_STANDARD,UI.FONT_SIZE_18PX, UI.FONT_COLOR_255_247_202)
    tipsText:setSize(600, 70)
    tipsText:setTextHorizontalCenter()
    tipsText:centerUp(23)
    self.centerLayout:addChild(tipsText)
    self._tipsText = tipsText
    if(self:isInInfernoNightMare())then
        tipsText:setText(string.format(LanguageManager:getInstance():getLocalString(1113947), mvc.caveModel:getInfernoNightMareLostNum()))
        -- tipsText:setText(string.format("剩余%d次", mvc.caveModel:getInfernoNightMareLostNum()))
    elseif(self:isInVoidRiftNightMare()) then
        tipsText:setText(string.format(LanguageManager:getInstance():getLocalString(1114806), mvc.caveModel:getVoidRiftNightMareLostNum()))
    elseif(self:isInViKingNightMare()) then
        tipsText:setText(string.format(LanguageManager:getInstance():getLocalString(1115491), mvc.viKingModel:getViKingNightMareLostNum()))
    elseif(SceneManager:getInstance():isInWormhole()) then
        tipsText:setText(string.format(LanguageManager:getInstance():getLocalString(1116890)))
    end

    -- 没有需要丢失的物品的提示
    local noLostText = UI.Text:create()
    noLostText:init(LanguageManager:getInstance():getLocalString(1111286),UI.FONT_STANDARD,UI.FONT_SIZE_20PX,UI.FONT_COLOR_255_247_202)
    noLostText:setSize(600, 70)
    noLostText:setTextHorizontalCenter()
    noLostText:center()
    self.centerLayout:addChild(noLostText)
    self._noLostText = noLostText

    -- 丢失的物品列表
    self:showGoodsView()

    -- 统计金币数据
    -- 背景
    local goldBg = UI.Image:create()
    goldBg:init("ui_information_hero_box_up.png")
    goldBg:centerBottom(26)
    self.centerLayout:addChild(goldBg)

    local glodIcon = UI.Image:create()
    glodIcon:init("symbol_gaming_money.png")
    glodIcon:centerUp(38)
    goldBg:addChild(glodIcon)
    glodIcon:setScale(0.8)

    local coinText = UI.Text:create()
    coinText:init(tostring(self.rewardCoin), UI.FONT_STANDARD,UI.FONT_SIZE_18PX, UI.FONT_COLOR_209_190_141)
    coinText:centerUp(38)
    goldBg:addChild(coinText)

    local bgWidth = goldBg:getContentSize().width
    local goldWidth = glodIcon:getContentSize().width
    local textWidth = coinText:getContentSize().width

    local space = 5
    local goldLeft = bgWidth / 2 - (goldWidth + textWidth + space) /2
    local coinLeft = goldLeft + goldWidth + space
    glodIcon:centerLeft(goldLeft)
    coinText:centerLeft(coinLeft)

    -- 上下边界
    local upLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    upLine:setContentSize(683, 1)
    upLine:setCapInsets(CCRectMake(1,0,1,1))
    upLine:setPosition(cc.p(683/2, self.centerLayout:getContentSize().height))
    self.centerLayout:addChild(upLine)

    local bottomLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png")
    bottomLine:setContentSize(683, 1)
    bottomLine:setCapInsets(CCRectMake(1,0,1,1))
    bottomLine:setPosition(cc.p(683/2, 0))
    self.centerLayout:addChild(bottomLine)

    -- 复活按钮
    self:initButton(diamond)

    -- 临时处理大秘境效果
    if(SceneManager:getInstance():isInDungeon() 
        or SceneManager:getInstance():isInDream() 
        or (SceneManager:getInstance():isActCave() and not SceneManager:getInstance():isInHuLu())) then
        self._reviveButton:setVisible(false)
        self._cancelButton:setVisible(false)
    end
end

function RevivePanel:getReviveEndDiamond()
    if SceneManager:getInstance():isInHuLu() then 
        local costDiamond = 0
        local huluReviveCost = ConfigManager:getGeneralForKey("huluReviveCost")
        if(huluReviveCost) then 
            costDiamond = tonumber(huluReviveCost)
        end
        return costDiamond
    elseif self:isInInfernoNightMare() then 
        local costDiamond = 0
        local cost = mvc.caveModel:getInfernoNightMareCostNum()
        if(cost ~= nil) then 
            costDiamond = tonumber(cost)
        end
        return costDiamond
    elseif self:isInVoidRiftNightMare() then 
        local costDiamond = 0
        local cost = mvc.caveModel:getVoidRiftNightMareCostNum()
        if(cost ~= nil) then 
            costDiamond = tonumber(cost)
        end
        return costDiamond
    elseif self:isInViKingNightMare() then 
        local costDiamond = 0
        local cost = mvc.viKingModel:getViKingNightMareCostNum()
        if(cost ~= nil) then 
            costDiamond = tonumber(cost)
        end
        return costDiamond
    else
        if(self._freeRevive) then
            return 0
        else 
            local diamond = 300
            local masterData = GameDataManager:getInstance():getMaster()
            if(masterData) then
                diamond = masterData:getReviveEndDiamond()
            end

            return diamond
        end
    end
end

function RevivePanel:getReviveDiamond()
    if self:isInInfernoNightMare() then 
        local costDiamond = 0
        local cost = mvc.caveModel:getInfernoNightMareCostNum()
        if(cost ~= nil) then 
            costDiamond = tonumber(cost)
        end
        return costDiamond
    end

    if self:isInVoidRiftNightMare() then 
        local costDiamond = 0
        local cost = mvc.caveModel:getVoidRiftNightMareCostNum()
        if(cost ~= nil) then 
            costDiamond = tonumber(cost)
        end
        return costDiamond
    end

    if self:isInViKingNightMare() then 
        local costDiamond = 0
        local cost = mvc.viKingModel:getViKingNightMareCostNum()
        if(cost ~= nil) then 
            costDiamond = tonumber(cost)
        end
        return costDiamond
    end

    if SceneManager:getInstance():isInHuLu() then 
        local costDiamond = 0
        local huluReviveCost = ConfigManager:getGeneralForKey("huluReviveCost")
        if(huluReviveCost) then 
            costDiamond = tonumber(huluReviveCost)
        end
        return costDiamond
    else
        if(self._freeRevive) then
            return 0
        else 
            local masterData = GameDataManager:getInstance():getMaster()
            if(masterData) then
                return masterData:getReviveUseDiamond()
            end

            return 300
        end
    end
end

function RevivePanel:refreshDiscountRefresh()
    self:initButton()
end

function RevivePanel:initButton()
    -- 清理所有子节点
    if(self._reviveButton) then
        self._reviveButton:removeAllChildren()
        self._reviveButton:removeFromParent()
        self._reviveButton = nil
    end

    if(self._cancelButton) then 
        self._cancelButton:removeAllChildren()
        self._cancelButton:removeFromParent()
        self._cancelButton = nil
    end

    if self:isInInfernoNightMare() then 
        local cost = mvc.caveModel:getInfernoNightMareCostNum()
        if(cost == nil) then 
            -- 这里复活测试已经用完，要直接回到主城
            return 
        end
    end

    if self:isInVoidRiftNightMare() then 
        local cost = mvc.caveModel:getVoidRiftNightMareCostNum()
        if(cost == nil) then 
            -- 这里复活测试已经用完，要直接回到主城
            return 
        end
    end

    if self:isInViKingNightMare() then 
        local cost = mvc.viKingModel:getViKingNightMareCostNum()
        if(cost == nil) then 
            -- 这里复活测试已经用完，要直接回到主城
            return 
        end
    end

    self:refreshDiscountData()

    local reviveButton = UI.Button:create()
    reviveButton:init(REVIVE_BTN_NOMRL, REVIVE_BTN_CLICK, REVIVE_BTN_DISABLE)
    local masterData = GameDataManager:getInstance():getMaster()
    local diamond = self:getReviveDiamond()

    reviveButton:leftBottom(winSize.width/2 - 290 ,winSize.height/2-258)
    
    reviveButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        Avalon.AudioManager:playSound("1503")

        if (DEBUG) then
            print("RevivePanel click the button of revive.")
        end

        if(Avalon.MathUtil:checkDiamonEnough(self:getReviveEndDiamond(), GameDataManager:getInstance():getDiamond()) or self._freeRevive) then
            self:pauseAnimation()

            -- 处理相关逻辑
            self:showLoading()
            GameManager:battleReviveHelp(masterData:getSpriteID(), self:getReviveEndDiamond())
        else 
            -- 显示钻石不够
            self:pauseAnimation()

            local cancelCallback = function()
                if(self and not tolua.isnull(self)) then
                    self:resureAnimation()
                end
            end
            
            -- 处理这里的层级
            local tips = UI.TipsLayer:onDiamondNotEnough(nil, cancelCallback,true)
            if(tips) then 
                tips:setZOrder(UI_ZORDER.MAX)
            end
            tips:removeFromParent(false)
            UI.UIManager:getRootNode():addChild(tips)
        end
    end)

    self:addChild(reviveButton,1)
    self._reviveButton = reviveButton

    if(self._freeRevive) then 
        local okLabel = UI.Text:create()
        okLabel:init(LanguageManager:getInstance():getLocalString(1110677), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        okLabel:center()
        self._reviveButton:addChild(okLabel, 10)
    else 
        local okLabel = UI.Text:create()
        okLabel:init(LanguageManager:getInstance():getLocalString(1110367), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        okLabel:centerLeft(20)
        self._reviveButton:addChild(okLabel, 10)

        local iconSprite = UI.Image:create()
        iconSprite:init(DIAMON_ICON_SPRITE)
        self._reviveButton:addChild(iconSprite, 10)

        local diamondLabel = UI.Text:create()
        diamondLabel:init(string.format("%d", diamond), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
        self._reviveButton:addChild(diamondLabel, 10)

        if(self._isDiscount) then
            diamondLabel:setText(string.format("%d", self:getReviveEndDiamond()))
    
            local discountDiamondLabel = UI.Text:create()
            discountDiamondLabel:init(string.format("%d", diamond), UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_160_130_60)
            self._reviveButton:addChild(discountDiamondLabel, 10)

            local bannelLine =  cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_red.png", CCRectMake(0,0,1,1))
            bannelLine:setPosition(discountDiamondLabel:getContentSize().width/2, discountDiamondLabel:getContentSize().height/2)
            bannelLine:setContentSize(discountDiamondLabel:getContentSize().width + 8, 2)
            discountDiamondLabel:addChild(bannelLine)

            local diamondLabelWidth = math.max(discountDiamondLabel:getContentSize().width , diamondLabel:getContentSize().width)
            local totalWidth = okLabel:getContentSize().width + iconSprite:getContentSize().width + 
                diamondLabelWidth + 30
                
            local allWidth = self._reviveButton:getContentSize().width
            local startX = allWidth /2 - totalWidth/2

            okLabel:centerLeft(startX)

            startX = startX + okLabel:getContentSize().width + 10
            iconSprite:centerLeft(startX)

            local heightBottom = 3
            local heightUp = 33
            startX = startX + iconSprite:getContentSize().width + 6
            discountDiamondLabel:leftUp(startX, 13 - discountDiamondLabel:getContentSize().height/2)
            diamondLabel:leftBottom(startX, 14 - discountDiamondLabel:getContentSize().height/2)
        else 
            -- 计算三个组件的坐标
            local totalWidth = okLabel:getContentSize().width + iconSprite:getContentSize().width + diamondLabel:getContentSize().width + 20
            local allWidth = self._reviveButton:getContentSize().width
            okLabel:centerLeft(allWidth /2 - totalWidth/2, 0)
            iconSprite:centerLeft(allWidth/2 - totalWidth/2 + okLabel:getContentSize().width + 10, 0)
            diamondLabel:centerLeft(allWidth/2 - totalWidth/2 + okLabel:getContentSize().width + iconSprite:getContentSize().width +10 + 4, 0)
        end

        self._okLabel = okLabel
        self._diamondLabel = diamondLabel

        self:refreshDiamondFontColor()
    end

    local cancelButton = UI.Button:create()
    cancelButton:init(REVIVE_BTN_NOMRL, REVIVE_BTN_CLICK, REVIVE_BTN_DISABLE)
    cancelButton:leftBottom(winSize.width/2 + 60, winSize.height/2-258)

    local cancelLabel = UI.Text:create()
    cancelLabel:init(LanguageManager:getInstance():getLocalString(1110368), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    cancelLabel:center()
    cancelButton:addChild(cancelLabel,10)

    cancelButton:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        Avalon.AudioManager:playSound("1503")
        if (DEBUG) then
            print("RevivePanel click the button of cancel revive.")
        end
        -- 选择了死亡
        self:showLoading()
        Net.NetRoleSystem:heroDeadSelectionRequest()
        -- Avalon.AudioManager:playSound("136")
        self:pauseAnimation()
    end)

    self:addChild(cancelButton,1)
    self._cancelButton = cancelButton

    -- 临时处理大秘境效果
    if(SceneManager:getInstance():isInDungeon()
        or SceneManager:getInstance():isInDream()
        or SceneManager:getInstance():isGuildBoss()
        or (SceneManager:getInstance():isActCave() and not SceneManager:getInstance():isInHuLu())) then
        self._reviveButton:setVisible(false)
    end
end

function RevivePanel:refreshDiscountData()
    local isDiscount = false
    local discount = RATIO_NUMBER
    if not SceneManager:getInstance():isInHuLu() then 
        local discountDataArr = MasterDataManager:getDiscountData(PublicDefine.DiscountType.DiscountType_Revive)

        if(discountDataArr and #discountDataArr > 0) then
            local discountData = discountDataArr[1]
            if(discountData and discountData:judgeToEffect()) then 
                isDiscount = true
                discount = discountData:getDiscount()
            end
        end
    end
    -- local testDiscount = false
    -- if(testDiscount) then 
    --     isDiscount = true
    --     discount = 8000
    -- end

    self._isDiscount = isDiscount
    if not SceneManager:getInstance():isInHuLu() then 
        if(self._isFristFreeRevive) then
            self._isDiscount = true
        end
    end
    if(self:isInInfernoNightMare() or
     self:isInVoidRiftNightMare() or
     self:isInViKingNightMare()) then 
        self._isDiscount = false
    end
    self._discount = discount
end

function RevivePanel:refreshDiamondFontColor()
    if Avalon.MathUtil:checkDiamonEnough(tonumber(self:getReviveEndDiamond()), GameDataManager:getInstance():getDiamond()) then
        if(self._diamondLabel) then
            self._diamondLabel:setFontColor(UI.FONT_COLOR_50_50_44)
        end
    else
        if(self._diamondLabel) then
            print("2")
            self._diamondLabel:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end
    end
end

function RevivePanel:showLoading()
    UI.WaitingLayer:showWaiting(true, self, GAME_NET_DELAY_UI)
end

function RevivePanel:hideLoading()
    UI.WaitingLayer:hideWaiting()
end 

function RevivePanel:pauseAnimation()
    self._slotAnimation:setTimeScale(0)
    self._reviveAnimation:setTimeScale(0)
end

function RevivePanel:resureAnimation()
    self._slotAnimation:setTimeScale(1)
    self._reviveAnimation:setTimeScale(1)
end

-- 更新视图
function RevivePanel:onUpdateView()
    -- 创建地图
    if(self.detailedScrollView) then
        self.detailedScrollView:setScrollBarWidth(6)
    end
end

-- 是否深红炼狱梦魇难度
function RevivePanel:isInInfernoNightMare()
    if SceneManager:getInstance():isInInferno() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false
end

-- 是否虚空秘境梦魇难度
function RevivePanel:isInVoidRiftNightMare()
    if SceneManager:getInstance():isInVoidRift() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false
end

-- 是否维京时代梦魇难度
function RevivePanel:isInViKingNightMare()
    if SceneManager:getInstance():isInViKing() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false
end

function RevivePanel:showGoodsView()
    local itemPadding = 80
    local size = table.nums(self.lostData.goodsArr)
    if(size == 0) then 
        self._tipsText:setVisible(false)
        self._noLostText:setVisible(true)
    else 
        self._tipsText:setVisible(true)
        self._noLostText:setVisible(false)

        local height = math.ceil(size / CELL_NUMBER)
        local width = 0
        if height > 1 then
            width = CELL_NUMBER * itemPadding
        else
            width = size % CELL_NUMBER
            width = (width == 0) and CELL_NUMBER or width
            width = width* itemPadding
        end 
        height = height * itemPadding

        local upLayout = UI.TouchLayout:create()
        upLayout:init(0, 0, 0, 0)
        upLayout:setSize(width, height)
        upLayout:addTouchEvents(self)
        -- upLayout:addTouchEvents(self)
        if size > CELL_NUMBER * 2 then
            upLayout:centerUp(68)
            local detailedScrollView = UI.ScrollView:create()
            detailedScrollView:init(0,0,0,0)
            detailedScrollView:setSize(665, 140)
            detailedScrollView:centerUp(75)
            detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
            detailedScrollView:addInnerNode(upLayout)
            detailedScrollView:setScrollBarEnabled(true)
            detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
            detailedScrollView:setScrollBarWidth(2)
            self.detailedScrollView = detailedScrollView
            self.centerLayout:addChild(detailedScrollView)
        else
            upLayout:centerUp(75 + (204-height) /2 - 30)
            self.centerLayout:addChild(upLayout)
        end
        local beginPosX = -8
        local index = 1
        for k, goodData in pairs(self.lostData.goodsArr) do
            goodData:setIsNew(false)
            local goodGrid = UI.GoodsGrid:create()
            goodGrid:init(goodData)
            upLayout:addChild(goodGrid)
            goodGrid:hideFlagIcon()
            goodGrid:setInfoArea(false, false)

            -- local glProgram = cc.GLProgram:createWithFilenames("shaders/PositionTextureRedColor.vert", "shaders/PositionTextureRedColor.frag")
            -- local glProgramState = cc.GLProgramState:getOrCreateWithGLProgram(glProgram)
            -- goodGrid:setGLProgramState(glProgramState)
            if(not self:isInInfernoNightMare() 
            and not self:isInVoidRiftNightMare()
            and not self:isInViKingNightMare())then
                goodGrid:setIsGray()
            end


            local mode = index % CELL_NUMBER
            mode = mode == 0 and CELL_NUMBER or mode
            goodGrid:leftUp((mode - 1) * itemPadding, math.floor((index - 1) / CELL_NUMBER) * itemPadding  )
            table.insert(self.allGridNode, goodGrid)
            index = index + 1
        end    
    end

    if(self:isInInfernoNightMare() 
    or self:isInVoidRiftNightMare()
    or self:isInViKingNightMare()) then 
        self._tipsText:setVisible(true)
        self._noLostText:setVisible(false)
    end
end

function RevivePanel:onTouchBegan(touch, event)
    print("RevivePanel:onTouchBegan")
    self.selectIndex = 0
    local location = touch:getLocation()
    self.beginTouchPosition = location

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and value:isVisible() then
            self.selectIndex = k
            break
        end
    end
end

function RevivePanel:onTouchEnded(touch, event)
    print(" RevivePanel:onTouchEnded")
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
            local goodsData = value:getData();
            local pInfoArea = nil;

            if not tolua.isnull(self._infoItem) then 
                self._infoItem:removeFromParent(true)
                self._infoItem = nil
            end

            if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
                -- 装备详情
                pInfoArea = UI.EquipmentInfoArea:create()
                print("GoodsGrid:onShowInfoAreaHandler ", self._isNoGet, self._showEquipCom)
                -- -- if(self._isNoGet == true) then
                --     pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
                --     pInfoArea:hideCompInfo()
                -- -- else 
                    pInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                -- end
                -- 处理试穿对比
                if( self._showEquipCom == true) then
                    local GameDataManager = require("app.game.GameDataManager")
                    local blackTable = GameDataManager:getInstance():tryEquipment(goodsData)
                    pInfoArea:updateInfo(blackTable)
                end
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
                pInfoArea = UI.EquipmentPetInfoArea:create()
                pInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                if(self._showEquipCom == true) then 
                    pInfoArea:updateInfo(goodsData, MasterDataManager:getFightWearEquipmentForEquipmentType(goodsData:getEquipmentType()))
                end
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
                -- 道具详情界面
                local itemType = goodsData:getItemType()
                if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
                    pInfoArea = UI.SelectGoodsBagInfoArea:create()
                elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then
                    pInfoArea = UI.RandomBagInfoArea:create()
                elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then
                    pInfoArea = UI.LevelBagInfoArea:create()
                    pInfoArea:lockNextLevelBag()
                    pInfoArea:disableUse()
                else
                    pInfoArea = UI.PropInfoArea:create(true)
                end
                pInfoArea:init(UI.PROP_MATER.PROPINFO)
                
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then 
                -- 材料详情界面
                if(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then
                    pInfoArea = UI.PropInfoArea:create(true)
                else 
                    pInfoArea = UI.MaterialEquipScrollInfoArea:create()
                end
                pInfoArea:init(UI.PROP_MATER.MATERIALINFO)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
                -- 宝藏材料详情界面
                pInfoArea = UI.PropInfoArea:create(true)
                pInfoArea:init(UI.PROP_MATER.MATERIALINFO)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then 
                -- 虚拟物品详情界面
                if(goodsData:getCanBeView()) then 
                    pInfoArea = UI.PropInfoArea:create(true)
                    pInfoArea:init(UI.PROP_MATER.VIRTUALITEM_INFO)
                else
                    return 
                end
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
                pInfoArea = UI.GemStoneInfoArea:create()
                pInfoArea:init(goodsData)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then 
                pInfoArea = UI.StarPrayInfoArea:create()
                pInfoArea:init(goodsData)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
                pInfoArea = UI.PetStoneInfoArea:create()
                pInfoArea:init(goodsData)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then 
                pInfoArea = UI.RelicInfoArea:create()
                pInfoArea:init(goodsData)
            elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then 
                pInfoArea = UI.GlyphInfoArea:create()
                pInfoArea:init(goodsData)
            else
                return
            end
            pInfoArea:setHideLink(isHideLink)
            local worldPos = value:convertToWorldSpace(cc.p(0,0))

            if worldPos.x < winSize.width/2 then
                pInfoArea:centerLeft(worldPos.x + value:getSize() + 20)
            else
                pInfoArea:centerLeft(worldPos.x - pInfoArea:getSize() - 20)
            end

            pInfoArea:setVisible(true)
            pInfoArea:updateView(goodsData)
            pInfoArea:closeLockFlag()
            pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self,obj,touchPosition)
                self._infoItem = nil
                if not tolua.isnull(obj:getGoodsGrid()) then
                    local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
                    local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

                    if cc.rectContainsPoint(rect, touchPosition) then
                        obj:setInterceptTouches(false)
                    end
                end
                
                pInfoArea:close();
            end)

            self:addChild(pInfoArea,100000)
            break
        end
    end
end