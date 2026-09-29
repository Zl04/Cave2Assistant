--[[
    AUTHOR:llf
    2023-1-13
    USING: --商店通用批量购买弹窗 (只是客户端表现通用, 对应的购买消息得单独实现)
]]

require "app.ui.Component"
require "app.ui.common.Dialog.Tips"

local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local CommonBulkPurchaseTips = class("CommonBulkPurchaseTips",UI.HWBtnComponent)
UI.CommonBulkPurchaseTips = CommonBulkPurchaseTips
--  ui_tips_team
local LEAVE_TEAM_TIPS_PLIST = {
    "ui_general_shop.plist"
}

local  TIPS_OK_SPRITE_01 = "ui_btn_yes1_1.png"        --  确认按钮
local  TIPS_OK_SPRITE_02 = "ui_btn_yes1_2.png"        --  确认按钮
local  TIPS_CANCEL_SPRITE_01 = "ui_btn_no1_0.png"     --  取消按钮
local  TIPS_CANCEL_SPRITE_02 = "ui_btn_no1_1.png"     --  取消按钮

-- local  GOLD_ICON = "symbol_gaming_money.png"                --  黄金图标
-- local  CRYSTAL = "symbol_gaming_diamond.png"                --  钻石图标
-- local  GUILD_MEDAL = "symbol_guild_tech_icon_medal.png"     --  工会勋章
-- local  GUILD_CONTRIB = "symbol_guild_contribution_icon_medal.png" -- 公会贡献

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
        self._cancelCallFun()
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
function CommonBulkPurchaseTips:ctor()
    print("CommonBulkPurchaseTips:ctor")
    CommonBulkPurchaseTips.super.ctor(self,UIType.BUY_AMOUNT_TIPS,LEAVE_TEAM_TIPS_PLIST,429,286)

    self._cancelCallFun = nil 
    self._okCallFun = nil 
    self._price = 0 -- 物品单价
    self._strFmt = 0 -- 默认购买数量
    self._maxAmount = nil 
end

--  析构函数 调用父类的方法
function CommonBulkPurchaseTips:dtor()
    self._price = 0 -- 物品单价

    self._maxAmount = nil 
    CommonBulkPurchaseTips.super.dtor(self)

end

--  初始化函数
function CommonBulkPurchaseTips:init(commonShopType,purchasedNum,expandParam)
    self._price = 999   
    self._maxAmount = 999
    self._commonShopType = commonShopType
    self._purchasedNum = purchasedNum
    self._expandParam = expandParam or {}
    self._startAtMax = false

    self:initMaxAmount()
    CommonBulkPurchaseTips.super.init(self)
end

function CommonBulkPurchaseTips:initMaxAmount()
    if self._commonShopType == PublicDefine.CommonShopType.RunesCave then
        local rewardData = self._expandParam.profileData
        local itemId = self._expandParam.itemId
        if rewardData then
            local idList = string.split(rewardData.goodsID, ";")
            local priceIdList = string.split(rewardData.costID, ";")
            local priceList = string.split(rewardData.costNum, ";")
            local numList = string.split(rewardData.goodsNum, ";")
            local conNumList = string.split(rewardData.conNum, ":")
            local multipleList = string.split(rewardData.multiple, ":")

            self._costNum = 0
            self._conNum = ""
            self._multiple = ""
            self._costID = nil
            for k, v in pairs(idList) do
                local goodsID = tonumber(v)
                
                if goodsID == tonumber(itemId) then
                    self._costNum = tonumber(priceList[k])
                    self._conNum = conNumList[k]
                    self._multiple = multipleList[k]
                    self._costID = priceIdList[k]
                end
            end

            if self._conNum ~= "" then
                self:getItemDiamondAmount(self._maxAmount, true)
            end
            
        end
    end

end

--  初始化界面函数
function CommonBulkPurchaseTips:onInitView()
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
            self._itemAmount = 0 -- 默认购买数量是0
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

        local totalPrice = self:getItemDiamondAmount(strFmt)
        self.itemDiamondAmount:setText(AvalonUtil:getSimpleNumber(totalPrice,4))
        pPicker:setValue(strFmt)

        -- self:refreshCostPosition()

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
    pSlider:setMaximumValue(self._maxAmount)
    pSlider:setPosition(cc.p(bg:getContentSize().width*0.5,120 + 11 + 18))
    pSlider:setTag(1)
    self.pSlider = pSlider
    bg:addChild(pSlider, 10)
    pSlider:registerControlEventHandler(valueChanged, cc.CONTROL_EVENTTYPE_VALUE_CHANGED)

    -- 滑块右边的数字
    local rightText = UI.Text:create()
    rightText:init("0",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    rightText:leftBottom(352 +10,120 + 11 + 18 - rightText:getContentSize().height/2)
    self.maxRightText = rightText
    bg:addChild(rightText, 10)

    -- 滑块左边的数字1
    local leftText = UI.Text:create()
    leftText:init("0",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    leftText:rightBottom(352 + 10, 120 + 11 + 18 - leftText:getContentSize().height/2)
    bg:addChild(leftText, 10)
    
    local topLayout = UI.Layout:create()
    topLayout:init()
    topLayout:setSize(197, 27)
    topLayout:centerUp(30)
    bg:addChild(topLayout)

    local topBlackSide = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png", cc.rect(0,0,1,1))
    topBlackSide:setContentSize(cc.size(197, 27))  
    topBlackSide:setPosition(cc.p(topBlackSide:getContentSize().width/2, topBlackSide:getContentSize().height/2))
    topLayout:addChild(topBlackSide)


    local desText = UI.Text:create()
    desText:init(UI.TEXT_223907,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    desText:center()
    topLayout:addChild(desText, 10)

    local priceLayout = UI.Layout:create()
    priceLayout:init()
    priceLayout:setSize(197, 27)
    priceLayout:centerUp(179)
    bg:addChild(priceLayout)

    local bottomBlackSide = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_light.png", cc.rect(0,0,1,1))
    bottomBlackSide:setContentSize(cc.size(197, 27))  
    bottomBlackSide:setPosition(cc.p(bottomBlackSide:getContentSize().width/2, bottomBlackSide:getContentSize().height/2))
    priceLayout:addChild(bottomBlackSide)

    local bDesText = UI.Text:create()
    bDesText:init(UI.TEXT_223908,UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    bDesText:centerLeft(8)
    priceLayout:addChild(bDesText, 10)

    local costData = nil
    if self._costID then
        costData = ConfigManager:getVirtualItemConfigByID(tonumber(self._costID)) or ConfigManager:getMaterialConfigByID(tonumber(self._costID))
    end

    if costData then
        local giveIcon = UI.Image:create()
        giveIcon:init(costData.miniIcon)
        giveIcon:center(-20)
        priceLayout:addChild(giveIcon, 10)

        -- local goodData = GoodsDataManager:createLocalGoodsData(self._giveID)
        -- local giveIcon = UI.Image:create()
        -- giveIcon:init(goodData:getSmallIconName())
        -- giveIcon:center(-20)
        -- priceLayout:addChild(giveIcon, 10)
        

        -- 购买物品的单价
        local priceText = UI.Text:create()
        priceText:init("",UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        priceText:centerLeft(giveIcon:getContentSize().width + 4)
        self.itemDiamondAmount = priceText
        giveIcon:addChild(priceText, 10)
    end

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
function CommonBulkPurchaseTips:callfunName(okCallFun,cancelCallFun)  
    self._okCallFun = okCallFun
    self._cancelCallFun = cancelCallFun
end


-- 更新视图
function CommonBulkPurchaseTips:onUpdateView()
    if self.itemDiamondAmount then
        self.itemDiamondAmount:setText(string.format("%s",AvalonUtil:getSimpleNumber(self:getItemDiamondAmount(self._strFmt), 4)))
    end
    if self.maxRightText then
        -- print("  maxRightText ", self._maxAmount)
        self.maxRightText:setText(string.format("%s",self._maxAmount))
    end
    self.pSlider:setMaximumValue(self._maxAmount)
    if (self._startAtMax) then self.pSlider:setValue(self._maxAmount) end

    -- self:refreshCostPosition()
end

-- 购买物品数量的价格
--[[
    strFmt      选择购买的数量
    purchased   当前商品已购买过的数量 (用于某些商店会计数购买次数  增加商品单价)
]]

function CommonBulkPurchaseTips:getItemDiamondAmount(strFmt,specialParm)
    -- self._costNum = 0
    --         self._conNum = ""
    --         self._multiple = ""
    
    
    local needPrice = 0
    local num = self._purchasedNum
    local numList = string.split(self._conNum, ";")
    local multipleList = string.split(self._multiple, ";")
    local maxAmount = 0

    -- print("self._purchasedNum ==== ",num, strFmt)

    -- print("numList ==== ", numList)

    local money = tonumber(self._costID) == 23400001 and RoleDataManager:getMaster():getGemBoughtCredit() or 0
    -- print("money ==== ", money)
    if num > tonumber(numList[#numList]) then
        -- print(" numList num ==== ", num, tonumber(numList[#numList]))
        local price = self._costNum * tonumber(multipleList[#multipleList])
        maxAmount = math.floor(money / price)

        strFmt = strFmt < maxAmount and strFmt or maxAmount
        needPrice = strFmt * price

    else
        for k,v in ipairs(numList) do
            local buyNum = 0
            local price = self._costNum * tonumber(multipleList[k])
            local localMaxAmount = math.floor(money / price)
            if num < tonumber(v) and strFmt > 0 and localMaxAmount > 0 then
                buyNum = tonumber(v) - num

                if strFmt < buyNum then
                    buyNum = strFmt
                end

                if localMaxAmount < buyNum then
                    buyNum = localMaxAmount
                end

                needPrice = needPrice + buyNum * price

                num = num + buyNum
                maxAmount = maxAmount + buyNum
                strFmt = strFmt - buyNum
                money = money - buyNum * price

                -- print(  "maxAmount ===== ", num , maxAmount, strFmt ,money , buyNum, localMaxAmount, needPrice)
            end

            if num >= tonumber(numList[#numList]) and strFmt > 0 and localMaxAmount > 0 then
                local price = self._costNum * tonumber(multipleList[#multipleList])
                localMaxAmount = math.floor(money / price)
                if localMaxAmount < strFmt then
                    strFmt = localMaxAmount
                end
                needPrice = needPrice + strFmt * price

                maxAmount = maxAmount + strFmt

                -- print("maxAmount ==2=== " , strFmt, maxAmount, localMaxAmount, needPrice)
            end
            
        end
    end

    

    if maxAmount < self._maxAmount and specialParm then
        self._maxAmount = maxAmount
    end

    -- print("maxAmount ==3=== ",maxAmount,self._maxAmount, needPrice)

    

    return needPrice
end

