------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/07/21
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PurpleUpgradeExchangeCellView = class("PurpleUpgradeExchangeCellView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
UI.PurpleUpgradeExchangeCellView = PurpleUpgradeExchangeCellView

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 185
local COM_HEIGHT = 230

function PurpleUpgradeExchangeCellView:ctor(data, scrollView)
    PurpleUpgradeExchangeCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = data
    self.scrollView = scrollView
    self:bindModel()
end

function PurpleUpgradeExchangeCellView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self,  "app.modules.purpleupgrade", "PurpleUpgrade", false)
    PurpleUpgradeExchangeCellView.super.init(self, ... )
end

function PurpleUpgradeExchangeCellView:dtor()
    PurpleUpgradeExchangeCellView.super.dtor(self)
    self:unbindModel()
    self.data = nil
    reload_script_file_mvc("app.modules.purpleupgrade.PurpleUpgradeExchangeCellView")
end


function PurpleUpgradeExchangeCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local frame = UI.Image.create()
    frame:init("ui_rough_paper2.png")
    frame:center()
    frame:setName("frame")
    contentLayout:addChild(frame)

    local primogemFragGoodsID = self.data.materialID
    local virtualData = GoodsDataManager:createVirtualData(primogemFragGoodsID)
    local primogemData = GoodsDataManager:createLocalGoodsData(self.data.goodsID)

    local goodsName = UI.Text:create()
    goodsName:init(primogemData.name, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    goodsName:centerUp(10)
    frame:addChild(goodsName)
    self.goodsName = goodsName

    local getBtn = UI.Button:create();
    getBtn:init("ui_rough_btn2.png","ui_rough_btn2.png","ui_rough_btn2.png")
    getBtn:centerBottom(-40, 0)
    getBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    getBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.getGoods)
    contentLayout:addChild(getBtn)
    getBtn:setSwallowTouches(false)
    getBtn:setTouchClipNode(self.scrollView)
    self.getBtn = getBtn

    local primogemFragImage = UI.Image:create()
    primogemFragImage:init(virtualData:getSmallIconName())
    primogemFragImage:centerLeft(50)
    getBtn:addChild(primogemFragImage, 5)

    local needNum = UI.Text:create()
    needNum:init(tostring(self.data.materialNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    needNum:centerLeft(85)
    getBtn:addChild(needNum, 6)

    self:updateCellInfo()
end

function PurpleUpgradeExchangeCellView:updateCellInfo()
    local goodsData = GoodsDataManager:createLocalGoodsData(self.data.goodsID)
    goodsData:setNum(self.data.goodsNum)
    goodsData:setIsNew(false)

    local grid = UI.GoodsGrid:create()
    grid:init(goodsData)
    grid:center()
    grid:showInfoArea(true)
    grid:hideNewIcon()
    grid:updateView()
    grid:setSwallowTouches(false)

    grid:setTouchClipNode(self.scrollView)
    self.contentLayout:addChild(grid)

end

function PurpleUpgradeExchangeCellView:getGoods()
    
    if self.data.materialID == 23560001 and self.data.materialNum > GameDataManager:getInstance():getPrimogeDebrisNum2() then
        UI.ScrollBar:createByText(UI.TEXT_227510)
        return
    end
    
    if self.data.materialID == 23530001 and self.data.materialNum > GameDataManager:getInstance():getPrimogeDebrisNum() then
        UI.ScrollBar:createByText(UI.TEXT_227510)
        return
    end

    -- 背包空间不足
    local goodArr = {{
        goodsID = self.data.goodsID,
        num = self.data.goodsNum,
        isGolden = false
    }}
    if not GameDataManager:getInstance():judgeEnoughPacketForGoodsArr(goodArr) then
        UI.ScrollBar:createByText(UI.TEXT_1212306)
        return
    end

    local richTextLayout = self:createRichText(self.data)
    local okCallBack = function ()
        -- UI.WaitingLayer:showWaiting(true, nil, 5)
        -- mvc.send("PetTreasure_RecyclingShop_Send_GoodsRecycle", data.shopType, data.ID)
        
        -- 判断是否限购和限购次数等
        -- local canBuyNum2 = 0
        -- for k,v in pairs(storeInfo) do
        --     if v.cfgId == data.ID then
        --         ---local config = ConfigManager:getNavigationShopByID(v.cfgId)
        --         local config = nil
        --         if shopIndex == SHOP_INDEX.NORMAL_SHOP then
        --             config = ConfigManager:getNavigationShopByID(v.cfgId)
        --         else
        --             config = ConfigManager:getNavigationShopLimitTimeByID(v.cfgId)
        --         end

        --         if (config.purchaseLimitNum - v.buyNum) <= 0 then
        --             -- 限购且已售完
        --             canBuyNum2 = 0
        --             GoodNum:setText("x" .. tostring(canBuyNum2))
        --             buyBtn:setBtnStatus(ButtonState.DISABLE)
        --             return
        --         else
        --             canBuyNum2 = config.purchaseLimitNum - v.buyNum - 1
        --             if canBuyNum2 == 0 then
        --                 buyBtn:setBtnStatus(ButtonState.DISABLE)
        --             end
        --             GoodNum:setText("x" .. tostring(canBuyNum2))
        --             break
        --         end
        --     end
        -- end

        -- if canBuyNum2 == 0 then
        --     sellOutBg:setVisible(true)
        --     GoodImg:setVisible(false)
        -- end


        -- local messageData = {
        --     id = data.ID,
        --     num = data.goodsNum,
        --     storeType = shopIndex
        -- }

        Net.NetRoleSystem:sendStoreBuyGoodsMessage(PublicDefine.StoreType.StoreType_Primoge, self.data.ID)
    end

    UI.TipsLayer:onShowCommonRichTextHandler(richTextLayout, okCallBack, nil, nil, false)

    -- Net.NetRoleSystem:sendStoreBuyGoodsMessage(PublicDefine.StoreType.StoreType_Primoge, self.data.ID)
end

function PurpleUpgradeExchangeCellView:createRichText(data)
    local textLayout = UI.Layout:create()
    textLayout:init()
    textLayout:setSize(354, 120)
    -- textLayout:enableDebugDraw()
    textLayout:center()

    local limitLayout = UI.Layout:create()
    limitLayout:init()
    limitLayout:center()
    textLayout:addChild(limitLayout)

    local longText = UI.Text:create()
    longText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    longText:centerUp(8)
    longText:autoAdapt()
    longText:hide()
    limitLayout:addChild(longText)

    local limitText = UI.Text:create()
    limitText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
    limitText:centerUp(8)
    limitText:setWidth(354)
    limitText:hide()
    limitLayout:addChild(limitText)

    local limitImg = UI.Image:create()
    limitImg:init("ui_information_btn_yes.png")
    limitImg:center()
    limitImg:hide()
    limitLayout:addChild(limitImg)

    local content = AvalonUtil:serializeText(UI.TEXT_1212302, UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)

    local curPosY = 22
    local curHeight = 28
    local textWidth = 0
    longText:setText(UI.TEXT_1212302)
    textWidth = textWidth + longText:getContentSize().width

    if textWidth > 354 then
        curHeight = math.ceil((textWidth + 2)/354) * 28
        textWidth = 354
    end

    local richtext = UI.RichText:create()
    local success = richtext:init(content, textWidth, curHeight, false)
    if success then
        richtext:centerUp(curPosY)
        -- richtext:enableDebugDraw()
        textLayout:addChild(richtext)
    end
    curPosY = curPosY + curHeight + 4
    local content = AvalonUtil:serializeText(UI.TEXT_1212303, UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)
    content = content .. AvalonUtil:serializeImage("symbol_gaming_"..data.materialID..".png")
    content = content .. AvalonUtil:serializeText(longText:numformat(tostring(data.materialNum)), UI.FONT_COLOR_SHARE_EQUIP_GUILD, UI.FONT_SIZE_18PX, UI.FONT_STANDARD)

    local curHeight = 28
    local textWidth = 0
    longText:setText(UI.TEXT_1212303)
    textWidth = textWidth + longText:getContentSize().width
    --limitImg:setSpriteName("symbol_gaming_"..data.materialID..".png")
    limitImg:setSpriteName("symbol_gaming_"..data.materialID..".png")
    textWidth = textWidth + limitImg:getContentSize().width
    longText:setText(longText:numformat(tostring(data.materialNum)))
    textWidth = textWidth + longText:getContentSize().width
    if textWidth > 354 then
        curHeight = math.ceil((textWidth + 2)/354) * 28
        textWidth = 354
    end

    local richtext = UI.RichText:create()
    local success = richtext:init(content, textWidth, curHeight, false)
    if success then
        richtext:centerUp(curPosY)
        -- richtext:enableDebugDraw()
        textLayout:addChild(richtext)
    end

    limitLayout:removeFromParent(false)

    return textLayout
end

function PurpleUpgradeExchangeCellView:bindModel()

end


function PurpleUpgradeExchangeCellView:unbindModel()

end





return PurpleUpgradeExchangeCellView












