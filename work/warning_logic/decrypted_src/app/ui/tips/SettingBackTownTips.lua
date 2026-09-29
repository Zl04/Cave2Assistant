-- SettingBackTownTips.lua
-- Author:zp
-- 2018年6月29日
-- Using:返回城镇提示
local winSize = cc.Director:getInstance():getWinSize()

require "app.ui.Component"
require "utils.AvalonUtil"
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require("app.game.LanguageManager")
local SceneManager = require("app.game.SceneManager")
local model = require("app.uiExport.ConfirmDialogModel")

local CELL_NUMBER = 5

UI = UI or {}

local SettingBackTownTips = class("SettingBackTownTips",UI.HWBtnComponent)
UI.SettingBackTownTips = SettingBackTownTips

local COM_RES_LIST = {
}

local function onCancelHandler(self)

    self:close();
end

local function onOkHandler(self)
    if(self._okCallFun) then 
        self._okCallFun()
    end
    self:close();
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    -- self:close();
end

--  构造函数
function SettingBackTownTips:ctor()
    SettingBackTownTips.super.ctor(self,UIType.SETTING_BACK_TOWN_TIPS, COM_RES_LIST, 537, 372)
    self.iconData = nil
    self._cancelCallFun = nil 
    self._okCallFun = nil 

    self.allGridNode = {}
end

--  析构函数 调用父类的方法
function SettingBackTownTips:dtor()
    SettingBackTownTips.super.dtor(self)
end

--  初始化函数
function SettingBackTownTips:init(coin, goodsArr, backTownType)
    -- 初始化需要显示的数据
    self.rewardCoin = coin
    self.goodsDataList = goodsArr
    self._backTownType = backTownType

    SettingBackTownTips.super.init(self)
end

--  初始化界面函数
function SettingBackTownTips:onInitView()

    self.ConfirmDialogModel = model.create("BackTownConfirmDialog")
    self.rootLayer = self.ConfirmDialogModel.root
    self.rootLayer:center()
    self:setSize(self.rootLayer._width, self.rootLayer._height);

    local mask = AvalonUtil.createDialogMask()
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    self:addChild(self.rootLayer)

    self.rootLayer:setTouchEnable(true)
    self.rootLayer:setInterceptTouches(true)

    local coinText = self.ConfirmDialogModel.moneyCountLabel
    coinText:setText(self.rewardCoin)
    local coninContentWidth = coinText._width + coinText._posX

    local coninContent = self.ConfirmDialogModel.moneyContentNode
    coninContent:setSize(coninContentWidth, coninContent._height)
    --coninContent:enableDebugDraw();

    self:showGoodsView()

    -- 显示提示语言
    local tipsStr = nil
    if(SceneManager:getInstance():isInCave() 
        or SceneManager:getInstance():isInHero()
        or SceneManager:getInstance():isDesertEyesCave()
        or SceneManager:getInstance():isDistortedSpaceCave()
        or SceneManager:getInstance():isInInferno()
        or SceneManager:getInstance():isInVoidRift()
        or SceneManager:getInstance():isInTrialLand()
        or SceneManager:getInstance():isInViKing()
        or SceneManager:getInstance():isInEverWinter()
        or SceneManager:getInstance():isTitanRoad()
        or SceneManager:getInstance():isInTitanHero()
        or SceneManager:getInstance():isInCaveExploring()
        or SceneManager:getInstance():isDriedSpring()
        or SceneManager:getInstance():isInExp()
        or SceneManager:getInstance():isChaosWormHole()
        or SceneManager:getInstance():isInWormhole()) then
        if(self._backTownType == BACK_TOWN_TYPE.BACK_TOWN_TYPE_BLACK_HOME) then 
            tipsStr = LanguageManager:getInstance():getLocalString(1111451)
        else 
            if(self:isInInfernoNightMare()) then
                tipsStr = string.format(LanguageManager:getInstance():getLocalString(1113947), mvc.caveModel:getInfernoNightMareLostNum())
            elseif(self:isInVoidRiftNightMare()) then
                tipsStr = string.format(LanguageManager:getInstance():getLocalString(1114806), mvc.caveModel:getVoidRiftNightMareLostNum())
            elseif(self:isInViKingNightMare()) then
                tipsStr = string.format(LanguageManager:getInstance():getLocalString(1115491), mvc.viKingModel:getViKingNightMareLostNum())
            elseif(SceneManager:getInstance():isInWormhole()) then
                tipsStr = (string.format(LanguageManager:getInstance():getLocalString(1116890)))
            else
                tipsStr = UI.TEXT_111139
            end
        end
        coinText:setText("0")
    elseif (SceneManager:getInstance():isInDungeon()
        or SceneManager:getInstance():isInDream()
        or SceneManager:getInstance():isGuildBoss()
        or SceneManager:getInstance():isGhostAbyss()
        or SceneManager:getInstance():isActCave()) then
        tipsStr = UI.TEXT_111140
    end

    local tipsText = self.ConfirmDialogModel.contentLabelbackTown
    tipsText:setVisible(tipsStr ~= nil)
    if(tipsStr) then 
        tipsText:setText(tipsStr)
        tipsText:setSize(390, 70)
    end

    -- 取消按钮
    local button = self.ConfirmDialogModel.cancelBtnBackTown
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)

    -- 确认购买按钮
    local button = self.ConfirmDialogModel.okButtonBackTown
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onOkHandler)

    self.rootLayer:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)


end

function SettingBackTownTips:isInInfernoNightMare()
    local GameMapManager = require("app.game.GameMapManager")
    if SceneManager:getInstance():isInInferno() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false   
end

function SettingBackTownTips:isInVoidRiftNightMare()
    local GameMapManager = require("app.game.GameMapManager")
    if SceneManager:getInstance():isInVoidRift() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false
end

function SettingBackTownTips:isInViKingNightMare()
    local GameMapManager = require("app.game.GameMapManager")
    if SceneManager:getInstance():isInViKing() 
        and GameMapManager:getInstance():getDifficulty() == PublicDefine.CAVE_DIFFICULTY.DIFFICULTY_3 then 
            return true
        end

    return false
end

-- 传递回调函数名字
function SettingBackTownTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end

-- 更新视图
function SettingBackTownTips:onUpdateView()
    if(self.detailedScrollView) then
        self.detailedScrollView:setScrollBarWidth(6)
    end 
end

function SettingBackTownTips:showGoodsView()
    local itemPadding = 82
    local size = table.nums(self.goodsDataList)
    local noLostText = self.ConfirmDialogModel.noGoodsText
    noLostText:setVisible(size == 0);
    if(size > 0) then 
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

        local scrollViewLayer = self.ConfirmDialogModel.scrollViewLayer
        scrollViewLayer:removeAllChildren();
        -- scrollViewLayer:addTouchEvents()
        scrollViewLayer:setTouchEnable(true)
        local upLayout = scrollViewLayer
        if size > CELL_NUMBER then
            upLayout = UI.TouchLayout:create()
            upLayout:init(0, 0, 0, 0)
            upLayout:setSize(width, height)

            local detailedScrollView = UI.ScrollView:create()
            detailedScrollView:init(0,0,0,0)
            detailedScrollView:setSize(scrollViewLayer._width + 4, scrollViewLayer._height)
            detailedScrollView:leftUp(0, 0)
            detailedScrollView:setScrollType(UI.ScrollType.VERTICAL)
            detailedScrollView:addInnerNode(upLayout)
            detailedScrollView:setScrollBarEnabled(true)
            detailedScrollView:setCircleVisible(false);
            detailedScrollView:setScrollBarPositionFromCornerForVertical(cc.p(0, 0))
            detailedScrollView:setScrollBarColor(UI.SLIDER_COLOR_Dark)
            self.detailedScrollView = detailedScrollView
            scrollViewLayer:addChild(detailedScrollView)
        end
        local beginPosX = -8
        local index = 1
        for k, goodData in pairs(self.goodsDataList) do
            goodData:setIsNew(false)
            local goodGrid = UI.GoodsGrid:create()
            goodGrid:init(goodData)
            upLayout:addChild(goodGrid)
            goodGrid:hideFlagIcon()
            goodGrid:setInfoArea(false, false)
            if(not self:isInInfernoNightMare() 
            and not self:isInVoidRiftNightMare()
            and not self:isInViKingNightMare()) then
                goodGrid:setIsGray()
            end
            --goodGrid:enableDebugDraw()

            local mode = index % CELL_NUMBER
            mode = mode == 0 and CELL_NUMBER or mode
            goodGrid:leftUp((mode - 1) * itemPadding, math.floor((index - 1) / CELL_NUMBER) * itemPadding  )
            table.insert(self.allGridNode, goodGrid)
            index = index + 1
        end    
    end
end

function SettingBackTownTips:onTouchBegan(touch, event)
    print(" SettingBackTownTips:onTouchBegan")
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

function SettingBackTownTips:onTouchEnded(touch, event)
    print(" SettingBackTownTips:onTouchEnded")
    local location = touch:getLocation()
    if not AvalonUtil:isSensitiveTouch(self.beginTouchPosition, location) then
        return
    end 

    for k, value in ipairs(self.allGridNode) do
        if AvalonUtil:isRectContainsPoint(value, location) and self.selectIndex == k and value:isVisible() then
            local pInfoArea = value:onShowInfoAreaHandler(true)
            if pInfoArea then
                local leftX = winSize.width / 2 - self._bg:getContentSize().width / 2 - pInfoArea:getContentSize().width + 66
                if(leftX < Avalon.issUtil:getLeftMargin() + 2) then 
                    leftX = Avalon.issUtil:getLeftMargin() + 2
                end
                pInfoArea:centerLeft(leftX)
                pInfoArea:setZOrder(UI_ZORDER.TIPS)
            end
            break
        end
    end
end