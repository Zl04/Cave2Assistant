--[[
    AUTHOR:ZIHANCHEN, CMonk
    2018-02-21
    USING: 公会随机商店购买商品确认框
]]

local LanguageManager = require("app.game.LanguageManager")

require("app.ui.common.Dialog.ConfirmDialog")
UI = UI or {}

local GuildRandomShopBuyTips = class("GuildRandomShopBuyTips", UI.ConfirmDialog)
UI.GuildRandomShopBuyTips = GuildRandomShopBuyTips

function GuildRandomShopBuyTips:ctor(costType, cost)
    GuildRandomShopBuyTips.super.ctor(self)
    self._costType = costType
    self._cost = cost or 0
end

--  析构函数 调用父类的方法
function GuildRandomShopBuyTips:dtor()
    GuildRandomShopBuyTips.super.dtor(self)
end

--  初始化函数
function GuildRandomShopBuyTips:init()
    GuildRandomShopBuyTips.super.init(self)
end

--  初始化界面函数
function GuildRandomShopBuyTips:onInitView()
    GuildRandomShopBuyTips.super.onInitView(self)

    -- 隐藏原有文字
    self.ConfirmDialogModel.contentLabel:hide()

    -- 新提示文字布局
    local textContentLayout = UI.Layout:create()
    textContentLayout:init()
    textContentLayout:center()
    textContentLayout:enableAutoHeight()
    textContentLayout:enableAutoWidth()
    self.ConfirmDialogModel.contentBg:addChild(textContentLayout, 10)

    -- 提示内容
    local titleText_1 = UI.Text:create()
    titleText_1:init(UI.TEXT_1213896, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    titleText_1:setWidth(350)
    titleText_1:setTextHorizontalCenter()
    titleText_1:autoAdapt()
    titleText_1:floatUp(0)
    textContentLayout:addComponent(titleText_1)

    -- 花费价钱排版
    local priceLayout = UI.Layout:create()
    priceLayout:init()
    priceLayout:floatUp(0)
    priceLayout:enableAutoHeight()
    priceLayout:enableAutoWidth()
    textContentLayout:addComponent(priceLayout)

    -- 花费标签
    local costsLabel = UI.Text:create()
    costsLabel:init(UI.TEXT_111013, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"花费"
    costsLabel:floatLeft(0)
    priceLayout:addComponent(costsLabel)

    local iconName = "symbol_gaming_diamond.png"
    local goodsData = GoodsDataManager:createLocalGoodsData(self._costType)
    if goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM then
        if goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemContrib then
            iconName = "symbol_guild_contribution_icon_medal.png"
        elseif goodsData:getVirtualType() == PublicDefine.VIRTUAL_ITEM_TYPE.VirtualItemDiamond then
            iconName = "symbol_gaming_diamond.png"
        end
            -- TODO:如果有其他类型的消耗，更换图标
    end

    -- 消耗图标
    local crystal_Icon = UI.Image:create()
    crystal_Icon:init(iconName)
    crystal_Icon:floatLeft(2)
    priceLayout:addComponent(crystal_Icon)

    -- 价钱
    local costsNumberText = UI.Text:create()
    costsNumberText:init(tostring(self._cost), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45) --"花费"
    costsNumberText:floatLeft(2)
    priceLayout:addComponent(costsNumberText)
end


-- 更新视图
function GuildRandomShopBuyTips:onUpdateView()

end

-- 传递回调函数名字
function GuildRandomShopBuyTips:callfunName(okCallFun,cancelCallFun)  
    self.okCallback = okCallFun
    self.cancelCallback = cancelCallFun
end


