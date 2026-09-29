------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2021/06/25
--desc	: 
------------------------------------------------------------------------------
local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local FightBackShopItem = class("FightBackShopItem",UI.HWBtnComponent)
UI.FightBackShopItem = FightBackShopItem

local CURRENCY_ICON = "symbol_gaming_antifightingkey.png"
local CURRENCY_ICON2 = "symbol_gaming_205016.png"

FightBackShopItem.DES_WIDTH = 202
FightBackShopItem.DES_HEIGHT = 288

function FightBackShopItem:ctor(parentTable)
	FightBackShopItem.super.ctor(self, nil, {}, FightBackShopItem.DES_WIDTH, FightBackShopItem.DES_HEIGHT)
    self._data = nil
    self._parentTable = parentTable
	self:registerListener()
end

function FightBackShopItem:dtor()

end

function FightBackShopItem:onInitView()
	-- 背景
	self._itemBG = UI.Image:create()
	self._itemBG:init("ui_shopping_banner_box_02.png")
	self._itemBG:centerUp(0)
	-- self._itemBG:setTouchEnable(true)
	-- self._itemBG:setInterceptTouches(false)
	-- self._itemBG:setSwallowTouches(false)
	-- self._itemBG:addEventListener(UI.Event.COMPONENT_CLICK, self, self.onShowDetails)
    self:addChild(self._itemBG)
    
    -- 内容排版
    self._contentLayout = UI.Layout:create()
    self._contentLayout:init()
    self._contentLayout:center()
    self._contentLayout:setSize(self._itemBG:getSize())
    self._itemBG:addChild(self._contentLayout)

	-- 名字
	self._nameLabel = UI.Text:create()
	self._nameLabel:init("",UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	self._nameLabel:center(0, -90)
	self._nameLabel:setLineSpacing(-8)
	self._nameLabel:setWidth(183)
	self._nameLabel:setTextCenter()
	self._contentLayout:addChild(self._nameLabel)

	-- 主图标
	-- self._iconImage = UI.Image:create()
	-- self._iconImage:init("ui_shopping_icon_giftbox_2.png")
	-- self._iconImage:centerBottom(54)
    -- self._contentLayout:addChild(self._iconImage)
    
    -- 道具图标
    self._shopItem = UI.GoodsGrid:create()
    self._shopItem:init()
    self._shopItem:center()
    self._shopItem:setTouchEnable(true)
    self._shopItem:setSwallowTouches(false)
    self._shopItem:setTouchClipNode(self._parentTable)
    self._contentLayout:addChild(self._shopItem)

    -- -- 剩余数量
	-- self._maxNumLabel = UI.Text:create()
	-- self._maxNumLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
	-- self._maxNumLabel:setTextCenter()
	-- self._maxNumLabel:centerUp(194)
	-- self._contentLayout:addChild(self._maxNumLabel)

	-- 购买按钮
	self._buyButton = UI.Button:create()
	self._buyButton:init("ui_btn_yellow5_0.png","ui_btn_yellow5_1.png","ui_btn_yellow5_2.png")
	self._buyButton:leftBottom(-1.5, 0)
    self._buyButton:closeClickScale()
    self._buyButton:setInterval(1)
    self._buyButton:setSwallowTouches(false)
    self._buyButton:setTouchClipNode(self._parentTable)
    self._buyButton:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        -- 时间间隔检测
        if (self._lastReuqestOpenBoxTime ~= nil and os.time() - self._lastReuqestOpenBoxTime < 1) then
            return
        end
        self._lastReuqestOpenBoxTime = os.time()

        -- 没有数据提示
        if (not self._data) then
            return
        end
        
        -- 不能购买提示
        if (not self._data.buyAble) then
            local failStr = LanguageManager:getInstance():getLocalString(1112298) --"不能购买物品"
            if (self._data.reason == 1) then
                failStr = UI.TEXT_1213665 -- 洞窟内不能购买
            elseif (self._data.reason == 2) then
                -- if self._data.requestedMaterial == 22050140 then
                -- if self._data.requestedMaterial == 22050150 then
                if self._data.requestedMaterial == 22050160 then
                    -- failStr = UI.TEXT_222750 --"限时反斗钥匙货币不足"
                    -- failStr = UI.TEXT_222752
                    failStr = UI.TEXT_222753
                else
                    failStr = LanguageManager:getInstance():getLocalString(1170318) --"反斗钥匙货币不足"
                end
            elseif (self._data.reason == 3) then
                failStr = LanguageManager:getInstance():getLocalString(1111800) --"背包空间不足, 无法购买"
            elseif (self._data.reason == 4) then
                failStr = UI.TEXT_1170104  --购买次数已达上限
            end
            if (failStr) then
                UI.ScrollBar:createByText(failStr)
            end
            return
        end

        -- 请求购买道具
        if (self._cb) then
            self._cb(self._data.ID)
        end
    end)
    
	self:addChild(self._buyButton)

	-- 价钱排版
	self._priceLayout = UI.Layout:create()
	self._priceLayout:init()
	self._priceLayout:center()
	self._priceLayout:enableAutoHeight()
	self._priceLayout:enableAutoWidth()
	self._buyButton:addChild(self._priceLayout, 100)

	-- 货币标签
	local currentIcon = UI.Image:create()
    currentIcon:init(CURRENCY_ICON)
    currentIcon:floatLeft(0)
	self._priceLayout:addComponent(currentIcon)
    self._currentIcon = currentIcon

	-- 价钱文字
	self._priceLabel = UI.Text:create()
	self._priceLabel:init("",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	self._priceLabel:floatLeft(8)
	self._priceLayout:addComponent(self._priceLabel)


    --限购次数
    self._limitNumLabel = UI.Text:create()
	self._limitNumLabel:init("",UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
	self._limitNumLabel:centerBottom(33)
	self._contentLayout:addChild(self._limitNumLabel)

	-- -- 倒计时图标
	-- local clockLayout = UI.Layout:create()
	-- clockLayout:init()
	-- clockLayout:enableAutoWidth()
	-- clockLayout:enableAutoHeight()
	-- clockLayout:centerBottom(-2)
	-- self._contentLayout:addChild(clockLayout)

	-- -- 倒计时标签
	-- local clockIcon = AvalonUtil.createClockAnimation()
    -- clockIcon:floatLeft(-5)
    -- clockLayout:addComponent(clockIcon)

	-- -- 倒计时
	-- self._countDownLabel = UI.Text:create()
	-- self._countDownLabel:init("00:00:00",UI.FONT_STANDARD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_41_41_45)
	-- self._countDownLabel:floatLeft(-4)
    -- clockLayout:addComponent(self._countDownLabel)
    
    -- -- 售罄
    -- self._soldOutSeal = UI.Image:create()
    -- self._soldOutSeal:init("ui_catfood_seal.png")
    -- self._soldOutSeal:center()
    -- self._soldOutSeal:setVisible(false)
    -- self._itemBG:addChild(self._soldOutSeal)

    -- -- 售罄文字
    -- local sealText = UI.Text:create()
    -- sealText:init(LanguageManager:getInstance():getLocalString(1110909),UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_154_21_30)
    -- sealText:rotate(15)
	-- sealText:center()
    -- self._soldOutSeal:addChild(sealText)
end
-- {techExpRequireList = 0, goodsID = 22040210, version = 1, ID = 3, consume = 1, goodsNum = 2}

function FightBackShopItem:onUpdateView(data)
    if (data) then
        self._data = data

        -- if self._data.requestedMaterial == 22050140 and self._currentIcon then
        -- if self._data.requestedMaterial == 22050150 and self._currentIcon then
        if self._data.requestedMaterial == 22050160 and self._currentIcon then
            self._currentIcon:setSpriteName(CURRENCY_ICON2)
        elseif self._data.requestedMaterial == 22050130 and self._currentIcon then
            self._currentIcon:setSpriteName("symbol_gaming_antifightingkey_2.png")
        else
            self._currentIcon:setSpriteName(CURRENCY_ICON)
        end

        local itemConf = ConfigManager:getMaterialConfigByID(tonumber(self._data.requestedMaterial))

        if itemConf and itemConf.miniIcon ~= "" then
            self._currentIcon:setSpriteName(itemConf.miniIcon)
        end

        local itemData = data.goodsData
        if (itemData) then
            -- 更新名字
            local itemName = itemData:getName()
            if (itemName) then
                self._nameLabel:setText(itemName)
            end

            -- 更新道具
            self._shopItem:reset()
            self._shopItem:setData(itemData)
            self._shopItem:hideNewIcon()
            self._shopItem:showInfoArea(false, false)
        end

        -- 更新消耗
        local consume = data.consume
        if (consume) then
            -- 更新数量
            self._priceLabel:setText(consume)
            self._priceLabel:autoAdapt()
            self._priceLayout:updateView()

            -- 更新颜色
            -- local masterData = RoleDataManager:getMaster()
            local contribNum = mvc.fightBackShopModel:getContribNum()--GameDataManager:getInstance():getGoodsDataNumForGoodsID(requestedMaterial)
            -- if data.requestedMaterial == 22050140 then
            -- if data.requestedMaterial == 22050150 then
            if data.requestedMaterial == 22050160 then
                contribNum = mvc.fightBackShopModel:getContribNum(PublicDefine.StoreType.StoreType_LimitedMarblesFever)
            end

            if (contribNum >= consume) then
                self._priceLabel:setFontColor(UI.FONT_COLOR_50_50_44)
            else
                self._priceLabel:setFontColor(UI.FONT_COLOR_154_21_30)
            end
        end

        if data.purchaseLimit ~= nil then
            if data.purchaseLimit == 0 then
                self._limitNumLabel:setText("")
            else
                local limitData =  GoodsDataManager:getStorePurchaseLimitData()
                local purchaseCount = 0
                if limitData[data.ID] then
                    purchaseCount = limitData[data.ID].purchaseCount
                end
                local lNum = data.purchaseLimit - purchaseCount
                self._limitNumLabel:setText(UI.TEXT_222751 .. ":" .. lNum)
            end
        end

        -- -- 更新剩余数量
        -- local leftNum = data.leftNum
        -- if (leftNum) then
        --     self._maxNumLabel:setText(string.format(LanguageManager:getInstance():getLocalString(1112300) --[["总存货 %d"]], leftNum))
        --     self._priceLabel:autoAdapt()
        -- end

        -- -- 更新售罄状态
        -- if (leftNum and leftNum <= 0) then
        --     self._contentLayout:hide()
        --     self._soldOutSeal:show()
        --     self._shopItem:setTouchEnable(false)
        -- else
        --     self._contentLayout:show()
        --     self._soldOutSeal:hide()
        --     self._shopItem:setTouchEnable(true)
        -- end

        -- -- 更新可购买状态
        -- local buyAble = data.buyAble
        -- if (buyAble) then
        --     self._buyButton:enable()
        -- else
        --     self._buyButton:disable()
        -- end
    end
end

function FightBackShopItem:updateCoundDown()
    -- if (self._data.timeoutStamp) then
    --     local timeNow = GameManager:getNormalServerTime()
    -- end
end

function FightBackShopItem:registerListener( ... )
end

function FightBackShopItem:unRegisterListener( ... )
end

function FightBackShopItem:setCallback(cb)
    self._cb = cb
end

return FightBackShopItem