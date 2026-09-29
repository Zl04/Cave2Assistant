--[[
    AUTHOR:ZIHANCHEN
    2017-4-26
    USING: 购买物品数量的TIPS
]]

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"

local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local BuyAmountTips = class("BuyAmountTips",UI.HWBtnComponent)
UI.BuyAmountTips = BuyAmountTips
--  ui_tips_team
local LEAVE_TEAM_TIPS_PLIST = {
    "ui_general_shop.plist"
}

local  TIPS_OK_SPRITE_01 = "ui_btn_yes1_1.png"        --  确认按钮
local  TIPS_OK_SPRITE_02 = "ui_btn_yes1_2.png"        --  确认按钮
local  TIPS_CANCEL_SPRITE_01 = "ui_btn_no1_0.png"     --  取消按钮
local  TIPS_CANCEL_SPRITE_02 = "ui_btn_no1_1.png"     --  取消按钮

local  GOLD_ICON = "symbol_gaming_money.png"                --  黄金图标
local  CRYSTAL = "symbol_gaming_diamond.png"                --  钻石图标
local  GUILD_MEDAL = "symbol_guild_tech_icon_medal.png"     --  工会勋章
local  GUILD_CONTRIB = "symbol_guild_contribution_icon_medal.png" -- 公会贡献

local SAIL_DIAMOND = "symbol_material_bookmark.png" --航海钻石


--  点击确定按钮 
local function onConfirmButton(self)

    print("---确认购买") 
    if(self._okCallFun ~= nil ) then 
        self._okCallFun(self._itemAmount) 
    end 
    self:close()  
end

--  点击取消按钮
local function onCancleButton(self)
    self:close()   
    if(self._cancelCallFun ~= nil ) then 
        
    end 
    print("---取消购买") 
end

-- 点击TIPS外区域关闭
local function onTouchOutTipsUI(self)
    -- self:close()
end

-- 点击外部区域的处理器(关闭)(可选)
local function onTouchDialogOutsizeHandler(self)
    
end

--  构造函数
function BuyAmountTips:ctor()
    print("BuyAmountTips:ctor")
    BuyAmountTips.super.ctor(self,UIType.BUY_AMOUNT_TIPS,LEAVE_TEAM_TIPS_PLIST,429,286)

    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.currencyChange)
    self._cancelCallFun = nil 
    self._okCallFun = nil 
    self._price = 0 -- 物品单价
    self._costType = nil 
    self._strFmt = 1 -- 默认购买数量
    self._maxAmount = nil 
end

--  析构函数 调用父类的方法
function BuyAmountTips:dtor()
    self._price = 0 -- 物品单价
     self._costType = nil 
    self._maxAmount = nil 
    BuyAmountTips.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.currencyChange)
end

--  初始化函数
function BuyAmountTips:init(price,costType,maxAmount,startAtMax,isSell)
    self._price = price
    self._costType = costType
    self._maxAmount = maxAmount
    self._startAtMax = startAtMax
    self._isSell = isSell
    BuyAmountTips.super.init(self)
end

--  初始化界面函数
function BuyAmountTips:onInitView()
    local bg = UI.Image:create()
    self._bg = bg
    bg:init("ui_setup_banner_box3.png")
    bg:center()
    self:addChild(bg)
    bg:showLucencyLight()

    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onTouchDialogOutsizeHandler)

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

        local a  = self:getItemDiamondAmount()
        local totalPrice = strFmt* a
        self.itemDiamondAmount:setText(totalPrice)
        pPicker:setValue(strFmt)

        self:refreshCostPosition()
        self:refreshDismondColor()

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

    
    local pSlider = cc.ControlSlider:create(sprite1,sprite2,self.sprite4,sprite5) 
    pSlider:setAnchorPoint(cc.p(0.5, 0.5))
    pSlider:hasVisibleParents()
    pSlider:setMinimumValue(1.0) 
    -- pSlider:setMaximumValue(self._maxAmount)
    pSlider:setPosition(cc.p(bg:getContentSize().width*0.5,120 + 11))
    pSlider:setTag(1)
    self.pSlider = pSlider
    bg:addChild(pSlider, 10)
    pSlider:registerControlEventHandler(valueChanged, cc.CONTROL_EVENTTYPE_VALUE_CHANGED)

    -- 滑块右边的数字
    local rightText = UI.Text:create()
    rightText:init("1",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rightText:leftBottom(352 +10,120 + 11 - rightText:getContentSize().height/2)
    self.maxRightText = rightText
    bg:addChild(rightText, 10)

    -- 滑块左边的数字1
    local leftText = UI.Text:create()
    leftText:init("1",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    leftText:rightBottom(352 + 10, 120 + 11 - leftText:getContentSize().height/2)
    bg:addChild(leftText, 10)
    
    --  钻石图标 
    local priceLayout = UI.Layout:create()
    priceLayout:init()
    priceLayout:setSize(197, 27)
    priceLayout:centerUp(30)
    bg:addChild(priceLayout)

    local bottomBlackSide = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png", cc.rect(0,0,1,1))
    bottomBlackSide:setContentSize(cc.size(197, 27))  
    bottomBlackSide:setPosition(cc.p(bottomBlackSide:getContentSize().width/2, bottomBlackSide:getContentSize().height/2))
    priceLayout:addChild(bottomBlackSide)

    local crystalIcon = UI.Image:create()
    crystalIcon:init(GOLD_ICON)
    crystalIcon:center()
    self.costTypeIcon = crystalIcon
    priceLayout:addChild(crystalIcon, 10)

    -- 购买物品的单价
    local priceText = UI.Text:create()
    priceText:init("",UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    priceText:centerLeft(crystalIcon:getContentSize().width + 4)
    self.itemDiamondAmount = priceText
    crystalIcon:addChild(priceText, 10)

    local button = UI.Button:create()
    button:init(TIPS_OK_SPRITE_01,TIPS_OK_SPRITE_02,TIPS_OK_SPRITE_01)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onConfirmButton)
    self._bg:addChild(button)
    button:openClickScale()
    self._confirmButton = button

    local button = UI.Button:create()
    button:init(TIPS_CANCEL_SPRITE_01,TIPS_CANCEL_SPRITE_02,TIPS_CANCEL_SPRITE_01)
    button:addEventListener(UIEvent.BUTTON_CLICK, self, onCancleButton)
    self._bg:addChild(button)
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

-- 传递回调函数名字
function BuyAmountTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end


-- 更新视图
function BuyAmountTips:onUpdateView()
    self.itemDiamondAmount:setText(string.format("%s",self._strFmt*(self:getItemDiamondAmount())))
    self.maxRightText:setText(string.format("%s",self._maxAmount))
    self.pSlider:setMaximumValue(self._maxAmount)
    if (self._startAtMax) then self.pSlider:setValue(self._maxAmount) end
    if(self._costType == PublicDefine.GOODS_COST_TYPE.GOLD) then
        self.costTypeIcon:setSpriteName(GOLD_ICON)
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.GEM) then
        self.costTypeIcon:setSpriteName(CRYSTAL)
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.GUILD_MEDAL) then
        self.costTypeIcon:setSpriteName(GUILD_MEDAL)
        self.itemDiamondAmount:centerLeft(self.costTypeIcon:getContentSize().width + 4)
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.GUILD_CONTRIB) then
        self.costTypeIcon:setSpriteName(GUILD_CONTRIB)
        self.itemDiamondAmount:centerLeft(self.costTypeIcon:getContentSize().width + 4)
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.TALENT) then
        local goodsData = GoodsDataManager:createLocalGoodsData(ROLE_TALENT_STONE_GOODSID)
        self.costTypeIcon:setSpriteName(goodsData:getSmallIconName())
        self.itemDiamondAmount:centerLeft(self.costTypeIcon:getContentSize().width + 4)
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.BATTLE_PASS_ICON) then
        self.costTypeIcon:setSpriteName("symbol_gaming_passcheck.png")
        self.itemDiamondAmount:centerLeft(self.costTypeIcon:getContentSize().width + 4)
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.HORCRUX_COIN) then
        self.costTypeIcon:setSpriteName("symbol_horcrux.png")
        self.itemDiamondAmount:centerLeft(self.costTypeIcon:getContentSize().width + 4)
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.SAIL_DIAMOND) then
        --航海钻石
        self.costTypeIcon:setSpriteName(SAIL_DIAMOND)
        self.itemDiamondAmount:centerLeft(self.costTypeIcon:getContentSize().width + 4)
    end

    self:refreshCostPosition()
end

-- 购买物品数量的单价
function BuyAmountTips:getItemDiamondAmount()
    return self._price
end

function BuyAmountTips:refreshCostPosition()
    self.costTypeIcon:centerLeft(197 /2 - (self.costTypeIcon:getContentSize().width + self.itemDiamondAmount:getContentSize().width + 4) /2)
end

function BuyAmountTips:refreshDismondColor()
    local costNum = tonumber(self._strFmt*(self:getItemDiamondAmount()))

    local haveEnough = false
    if(self._costType == PublicDefine.GOODS_COST_TYPE.GOLD) then
        if(costNum <= GameDataManager:getInstance():getCurCoin()) then 
            haveEnough = true
        end
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.GEM) then
        if(Avalon.MathUtil:checkDiamonEnough(costNum, GameDataManager:getInstance():getDiamond())) then 
            haveEnough = true
        end
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.GUILD_MEDAL) then
        local guildMedal = MasterDataManager:getGuildData().guildTeamMedal
        if(costNum <= guildMedal) then 
            haveEnough = true
        end
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.GUILD_CONTRIB) then
        local masterData = RoleDataManager:getMaster()
        local contribNum = masterData:getGuildContrib()
        if(costNum <= contribNum) then 
            haveEnough = true
        end
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.TALENT) then
        if(costNum <= GameDataManager:getInstance():getRoleTalentPoint()) then 
            haveEnough = true
        end
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.HORCRUX_COIN) then
        if(costNum <= RoleDataManager:getMaster():getHorcruxCoin()) then 
            haveEnough = true
        end
    elseif (self._costType == PublicDefine.GOODS_COST_TYPE.SAIL_DIAMOND) then
        if(costNum <= RoleDataManager:getMaster():getSailDiamond()) then 
            haveEnough = true
        end
    end

    local color = UI.FONT_COLOR_41_41_45
    if(haveEnough == false and self._isSell ~= true) then 
        color = UI.FONT_COLOR_NOT_ENOUGH
    end

    self.itemDiamondAmount:setFontColor(color)
end

function BuyAmountTips:currencyChange()
    self:refreshDismondColor()
end