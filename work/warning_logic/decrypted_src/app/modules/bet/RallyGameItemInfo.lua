------------------------------------------------------------------------------
--author: ping.zheng
--date	: 2024/01/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local GameDataManager = require("app.game.GameDataManager")

local RallyGameItemInfo = class("RallyGameItemInfo", UI.HWBtnComponent)
require "app.modules.bigsailisland.BigSailIslandInfoView"

local winSize = cc.Director:getInstance():getWinSize()

UI = UI or {}

UI.RallyGameItemInfo = RallyGameItemInfo

-- 资源
local COM_RES_LIST = {
    "ui_general_shop.plist",
    "ui_town_rally.plist",
}

local COM_WIDTH = 429
local COM_HEIGHT = 377

local  TIPS_OK_SPRITE_01 = "ui_btn_yes1_1.png"        --  确认按钮
local  TIPS_OK_SPRITE_02 = "ui_btn_yes1_2.png"        --  确认按钮
local  TIPS_CANCEL_SPRITE_01 = "ui_btn_no1_0.png"     --  取消按钮
local  TIPS_CANCEL_SPRITE_02 = "ui_btn_no1_1.png"     --  取消按钮

function RallyGameItemInfo:bindModel()
    
end

function RallyGameItemInfo:unbindModel()
    
end

function RallyGameItemInfo:ctor(itemData)
    RallyGameItemInfo.super.ctor(
    self,
    UI.Type.TIPS,
    COM_RES_LIST,
    COM_WIDTH,
    COM_HEIGHT
)
self._itemData = itemData
self._maxAmount = 1
self:bindModel()
end

function RallyGameItemInfo:init( ... )
    RallyGameItemInfo.super.init(self, ... )
    self.isEmbattling = false
end

function RallyGameItemInfo:dtor()
    RallyGameItemInfo.super.dtor(self)
    self:unbindModel()
    self.isEmbattling = false
    self.switchBtnState = nil
    self.cellList = {}
    reload_script_file("app.modules.bet.RallyGameItemInfo")
end

function RallyGameItemInfo:onInitView()    
    -- 添加一个半透明背景
    local blackBg = cc.LayerColor:create(cc.c4b(0,0,0,120))
    blackBg:setContentSize(winSize.width*2, winSize.height*2)
    blackBg:setPosition(cc.p(0-winSize.width, -winSize.height))
    self:addChild(blackBg)


    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_rally_banner_box.png")
    bg:center()
    self:addChild(bg)
    bg:showLucencyLight()
    
    bg:setTouchEnable(true)
    bg:setInterceptTouches(true)
    bg:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function()
        self:close()
    end)
    bg:addEventListener(UI.Event.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        self:close()
    end)

    -- 标题
    local title = UI.Text:create()
    title:init(UI.TEXT_227629, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    title:centerUp(21)
    bg:addChild(title)
    
    -- 钻石
    local diamondImage = UI.Image:create()
    diamondImage:init("symbol_gaming_diamond.png")
    diamondImage:leftUp(325, 28)
    bg:addChild(diamondImage)
    
    -- 钻石数量
    self._diamond = UI.NumberText:create(tostring(GameDataManager:getInstance():getDiamond()), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45, 10)
    self._diamond:setTextLeft()
    self._diamond:leftUp(350, 28)
    bg:addChild(self._diamond, 4)
    
    local skillDesc = UI.Text:create()
    print("self._itemData:getDetailDescription()=", self._itemData:getDetailDescription())
    skillDesc:init(self._itemData:getDetailDescription()[1], UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_47_50_55)
    skillDesc:leftUp(23, 70)
    skillDesc:setWidth(377)
    skillDesc:autoAdapt()
    bg:addChild(skillDesc)
    
    -- 显示道具图标
    self._itemData:setIsNew(false)
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:init(self._itemData)
    goodsGrid:centerUp(126)
    bg:addChild(goodsGrid, 1)
    goodsGrid:hideBG()
    goodsGrid:setInfoArea(true, true)
    
    
    self.valueChangedMark = false

    local function valueChanged(pSender)
        if nil == pSender then
            self.crystalNum = self.itemDiamondAmount
            self._itemAmount = 1 -- 默认购买数量是1
            return
        end

        if self.valueChangedMark then
            self.valueChangedMark = false
            return
        end
        -- print("dddddddddd  valueChanged", pSender:getValue(), self.sprite3:isVisible())
        self.valueChangedMark = true
        local pPicker = pSender
        local strFmt  = math.floor(pPicker:getValue() + 0.5) -- 获取数量

        self._strFmt = strFmt
        self._itemAmount = strFmt
        self.num:setText(self._strFmt) -- 滑块里面的数量
        self.choiceNum:setText(self._strFmt) -- 选中滑块里面的数量

        -- local totalPrice = self:getItemDiamondAmount(strFmt)
        -- self.itemDiamondAmount:setText(AvalonUtil:getSimpleNumber(totalPrice,4))
        pPicker:setValue(strFmt)

        if(strFmt > self._itemData:getNum()) then 
            -- 多余自身拥有的数量时
            self._curPriceLayout:setVisible(true)
            local useDiamond = (strFmt - self._itemData:getNum()) * mvc.betModel:getRallyItemBuyPrice()
            if(useDiamond <= GameDataManager:getInstance():getDiamond()) then 
                self._diamondTxt:setColor(UI.FONT_COLOR_41_41_45)
            else
                self._diamondTxt:setColor(UI.FONT_COLOR_NOT_ENOUGH)
            end
            self._diamondTxt:setText(tostring(useDiamond))
            self._curPriceLayout:setSize(self._diamondIcon:getContentSize().width+self._diamondTxt:getContentSize().width+8, 22)
        else
            self._curPriceLayout:setVisible(false)
        end

        self.sprite3:setPosition(cc.p(self.sprite4:getContentSize().width/2 - 5,self.sprite4:getContentSize().height +22 +10))
        self.sprite3:setVisible(true)
    end
    local sprite1 = cc.Sprite:createWithSpriteFrameName("ui_shop_article_1.png") -- 黄色的滚动条
    local sprite2 = cc.Sprite:createWithSpriteFrameName("ui_shop_article_2.png") -- 黑色背景图

    self.sprite4 = cc.Sprite:createWithSpriteFrameName("ui_shop_article_3.png") -- 滑块
    self.sprite4:setTag(1)

    local sprite5 = cc.Sprite:createWithSpriteFrameName("ui_shop_article_3.png") -- 滑块

    self.sprite3 = cc.Sprite:createWithSpriteFrameName("ui_shop_article_4.png") -- 滑块上面的图标
    self.sprite3:setTag(2)
    self.sprite3:setPosition(cc.p(self.sprite4:getContentSize().width/2 - 5,self.sprite4:getContentSize().height +22 +10))
    self.sprite3:setVisible(true)
    self.sprite4:addChild(self.sprite3, 10)

    -- 滑块里面的数量
    self.num = UI.Text:create()
    self.num:init("1",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self.num:centerUp(5)
    self.sprite3:addChild(self.num)

    -- 添加到选中滑条
    local choiceSprite = cc.Sprite:createWithSpriteFrameName("ui_shop_article_4.png") -- 滑块上面的图标
    choiceSprite:setTag(2)
    choiceSprite:setPosition(cc.p(self.sprite4:getContentSize().width/2 - 5,self.sprite4:getContentSize().height +22 +10))
    choiceSprite:setVisible(true)
    -- self.sprite4:addChild(self.sprite3, 10)
    sprite5:addChild(choiceSprite, 11)

    -- 滑块里面的数量
    self.choiceNum = UI.Text:create()
    self.choiceNum:init("1",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self.choiceNum:centerUp(5)
    choiceSprite:addChild(self.choiceNum)

    local pliderY = 127
    local pSlider = cc.ControlSlider:create(sprite1,sprite2,self.sprite4,sprite5) 
    pSlider:setAnchorPoint(cc.p(0.5, 0.5))
    pSlider:hasVisibleParents()
    pSlider:setMinimumValue(1.0) 
    pSlider:setMaximumValue(self._maxAmount)
    pSlider:setPosition(cc.p(bg:getContentSize().width*0.5,pliderY))
    pSlider:setTag(1)
    self.pSlider = pSlider
    bg:addChild(pSlider, 10)
    pSlider:registerControlEventHandler(valueChanged, cc.CONTROL_EVENTTYPE_VALUE_CHANGED)

    -- 滑块右边的数字
    local rightText = UI.Text:create()
    rightText:init(tostring(self._maxAmount),UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rightText:leftBottom(352 +10, pliderY - rightText:getContentSize().height/2)
    self.maxRightText = rightText
    bg:addChild(rightText, 10)

    -- 滑块左边的数字1
    local leftText = UI.Text:create()
    leftText:init("1",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    leftText:rightBottom(352 + 10, pliderY - leftText:getContentSize().height/2)
    bg:addChild(leftText, 10)

    local curPriceLayout = UI.Layout:create();
    curPriceLayout:init()
    curPriceLayout:setSize(200, 22)
    -- curPriceLayout:rightBottom(53, 68)
    curPriceLayout:centerBottom(45)
    -- curPriceLayout:enableDebugDraw()
    -- bg:addChild(curPriceLayout, 1)
    self._curPriceLayout = curPriceLayout

    local diamondIcon1 = UI.Image:create()
    diamondIcon1:init("symbol_gaming_diamond.png")
    diamondIcon1:floatLeft(4)
    curPriceLayout:addComponent(diamondIcon1)
    self._diamondIcon = diamondIcon1

    local diamondTxt = UI.Text:create()
    diamondTxt:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	diamondTxt:floatLeft(4)
    curPriceLayout:addComponent(diamondTxt)
    self._diamondTxt = diamondTxt

    curPriceLayout:setSize(diamondIcon1:getContentSize().width+diamondTxt:getContentSize().width+8, 22)

    -- 设置默认值
    pSlider:setValue(1.0)

    local button = UI.Button:create()
    button:init(TIPS_OK_SPRITE_01,TIPS_OK_SPRITE_02,TIPS_OK_SPRITE_01)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        print("使用道具")
        local goodsID = self._itemData:getGoodsID()
        -- TODO 判断是否需要选择目标
        local racingEventData = mvc.betModel:getEventDataForItemID(goodsID)
        if(racingEventData == nil) then 
            print("racingEventData is nil  goodsID=" .. goodsID)
            return
        end

        local useDiamond = (self._itemAmount - self._itemData:getNum()) * mvc.betModel:getRallyItemBuyPrice()
        if(useDiamond > GameDataManager:getInstance():getDiamond()) then 
            UI.ScrollBar:createByText(UI.TEXT_1110371)
            return
        end

        -- 判断是否需要选择目标
        if(racingEventData.eventObject == UI.BET_EVENT_TARGET_TYPE.CHOICE_NO_BET) then 
            local data = {}
            data.useType = 2
            data.id = goodsID
            data.num = self._itemAmount

            mvc.openPanel("Bet", "RallySkillTargetChoice", data)
        else
            local boatID = 0
            if (racingEventData.eventObject == UI.BET_EVENT_TARGET_TYPE.CHOICE_BET or 
                racingEventData.eventObject == UI.BET_EVENT_TARGET_TYPE.RANDOM_BET) then 
                local boatInfo = mvc.betModel:getBetBoatInfo()
                if(boatInfo == nil) then 
                    print("没有找到投注船只信息")
                    UI.ScrollBar:createByText(UI.TEXT_227631)
                    return
                end
                boatID = boatInfo.boatid
            end

            local betBoatInfo = mvc.betModel:getBetInfo(boatID)
            if((betBoatInfo ~= nil and betBoatInfo.BetBoatSailInfo ~= nil and betBoatInfo.BetBoatSailInfo.finishSailMs > 0) or mvc.betModel:getInGameTime() < 0) then 
                UI.ScrollBar:createByText(UI.TEXT_227647)
                return
            end

            local data = {}
            data.boatid = boatID
            data.itemid = goodsID
            data.num = self._itemAmount

            Net.NetBigSailSystem:reqUseItem(data)
        end
        
        self:close()
    end)
    bg:addChild(button)
    button:openClickScale()
    self._confirmButton = button
    button:addChild(curPriceLayout)

    local button = UI.Button:create()
    button:init(TIPS_CANCEL_SPRITE_01,TIPS_CANCEL_SPRITE_02,TIPS_CANCEL_SPRITE_01)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:close()
    end)
    bg:addChild(button)
    self._cancelButton = button
    button:openClickScale()

    if (self._confirmButton) then
        self._confirmButton:rightBottom(53, 28)
        self._confirmButton:updateView()
    end
    if (self._cancelButton) then
        self._cancelButton:leftBottom(53, 28)
        self._cancelButton:updateView()
    end
end



return RallyGameItemInfo