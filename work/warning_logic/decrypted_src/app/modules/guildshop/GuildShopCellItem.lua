--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:CMonk
    time:2019-06-02 17:27:07
]]

local LanguageManager = require("app.game.LanguageManager")

UI = UI or {}
local GuildShopCellItem = class("GuildShopCellItem",UI.HWBtnComponent)
UI.GuildShopCellItem = GuildShopCellItem

local CURRENCY_ICON = "symbol_guild_contribution_icon_medal.png"

GuildShopCellItem.DES_WIDTH = 202
GuildShopCellItem.DES_HEIGHT = 288

function GuildShopCellItem:ctor(parentTable)
	GuildShopCellItem.super.ctor(self, nil, {}, GuildShopCellItem.DES_WIDTH, GuildShopCellItem.DES_HEIGHT)
    self._data = nil
    self._parentTable = parentTable
	self:registerListener()
end

function GuildShopCellItem:dtor()

end

function GuildShopCellItem:onInitView()
	-- 背景
	self._itemBG = UI.Image:create()
	self._itemBG:init("ui_guild_shopping_paper.png")
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

    -- 剩余数量
	self._maxNumLabel = UI.Text:create()
	self._maxNumLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
	self._maxNumLabel:setTextCenter()
	self._maxNumLabel:centerUp(194)
	self._contentLayout:addChild(self._maxNumLabel)

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
                -- 公会科技等级不足
                failStr = LanguageManager:getInstance():getLocalString(1112299) --"公会科技等级不足"
            elseif (self._data.reason == 2) then
                local goodsName = ""
                if (self._data.goodsData) then
                    goodsName = self._data.goodsData:getName()
                end
                failStr = goodsName .. LanguageManager:getInstance():getLocalString(1110909) --"已售罄"
            elseif (self._data.reason == 3) then
                -- 版本不正确
                -- failStr = "内容已更新, 不能购买过期物品"
                failStr = nil
            elseif (self._data.reason == 4) then
                failStr = LanguageManager:getInstance():getLocalString(1110698) --"贡献度不足"
            elseif (self._data.reason == 5) then
                failStr = LanguageManager:getInstance():getLocalString(1111800) --"背包空间不足, 无法购买"
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

	-- 价钱文字
	self._priceLabel = UI.Text:create()
	self._priceLabel:init("",UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
	self._priceLabel:floatLeft(8)
	self._priceLayout:addComponent(self._priceLabel)

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
    
    -- 售罄
    self._soldOutSeal = UI.Image:create()
    self._soldOutSeal:init("ui_catfood_seal.png")
    self._soldOutSeal:center()
    self._soldOutSeal:setVisible(false)
    self._itemBG:addChild(self._soldOutSeal)

    -- 售罄文字
    local sealText = UI.Text:create()
    sealText:init(LanguageManager:getInstance():getLocalString(1110909),UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_154_21_30)
    sealText:rotate(15)
	sealText:center()
    self._soldOutSeal:addChild(sealText)
end
-- {techExpRequireList = 0, goodsID = 22040210, version = 1, ID = 3, consume = 1, goodsNum = 2}
function GuildShopCellItem:onUpdateView(data)
    if (data) then
        self._data = data
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
            local masterData = RoleDataManager:getMaster()
            local contribNum = masterData:getGuildContrib()
            if (masterData and contribNum) then
                if (contribNum >= consume) then
                    self._priceLabel:setFontColor(UI.FONT_COLOR_50_50_44)
                else
                    self._priceLabel:setFontColor(UI.FONT_COLOR_154_21_30)
                end
            end
        end

        -- 更新剩余数量
        local leftNum = data.leftNum
        if (leftNum) then
            self._maxNumLabel:setText(string.format(LanguageManager:getInstance():getLocalString(1112300) --[["总存货 %d"]], leftNum))
            self._priceLabel:autoAdapt()
        end

        -- 更新售罄状态
        if (leftNum and leftNum <= 0) then
            self._contentLayout:hide()
            self._soldOutSeal:show()
            self._shopItem:setTouchEnable(false)
        else
            self._contentLayout:show()
            self._soldOutSeal:hide()
            self._shopItem:setTouchEnable(true)
        end

        -- 更新可购买状态
        local buyAble = data.buyAble
        if (buyAble) then
            self._buyButton:enable()
        else
            self._buyButton:disable()
        end
    end
end

function GuildShopCellItem:updateCoundDown()
    -- if (self._data.timeoutStamp) then
    --     local timeNow = GameManager:getNormalServerTime()
    -- end
end

function GuildShopCellItem:registerListener( ... )
end

function GuildShopCellItem:unRegisterListener( ... )
end

function GuildShopCellItem:setCallback(cb)
    self._cb = cb
end

return GuildShopCellItem