--[[
    UI - 购买重生果实
]]--

UI = UI or {}

local PetBuyRebornItem = class("PetBuyRebornItem", UI.HWBtnComponent)
local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local languageManagerInstance = LanguageManager:getInstance()
UI.PetBuyRebornItem = PetBuyRebornItem

local SceneManager = require("app.game.SceneManager")

local COM_RES_LIST = {
    "ui_general_tips.plist",
    "ui_common_icon_material.plist",
    "ui_common_symbol.plist",
    "ui_common_grid.plist",
    "ui_package_pets.plist",
    "ui_common_scale9image.plist",
}

local BUY_REBORNITEM_BG1 = "ui_setup_banner_box2.png"
local TITLE_BG = "ui_pets_reborn_pay_title.png"
local SHOW_MONEY_BG = "ui_pets_reborn_pay_bg_2.png"
local GRAY_LAYOUT_BG = "ui_pets_reborn_pay_bg_1.png"
local LINE_DARK = "ui_scale9image_banner_line_dark.png"

local COM_WIDTH = 850
local COM_HEIGHT = 522
local winSize = cc.Director:getInstance():getWinSize()

function PetBuyRebornItem:ctor()
    PetBuyRebornItem.super.ctor(self, 0, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self:setInterceptTouches(false)
    self:setTouchEnable(true)
end

function PetBuyRebornItem:init(isVariant)
    self.isVariant = isVariant or false
    PetBuyRebornItem.super.init(self)
end

-- 析构函数
function PetBuyRebornItem:dtor()
    PetBuyRebornItem.super.dtor(self)
end

-- 初始化视图
function PetBuyRebornItem:onInitView()

    local ZOrder = 0
    local goodsId
    local fastBuyId

    if self.isVariant then
        fastBuyId = 2
        goodsId = 22090020
    else
        fastBuyId = 1  
        goodsId = 22090010
    end

    local bg = UI.Image:create()
    bg:init(BUY_REBORNITEM_BG1)
    bg:center()
    self:addChild(bg, 1)
    self.bg = bg

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask, 0)

    local maskLayout = UI.Layout:create();
    maskLayout:init()
    maskLayout:setSize(winSize.width * 2, winSize.height * 2)
    maskLayout:center()
    maskLayout:setTouchEnable(true)
    maskLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function() 
        self:close() 
    end)
    self:addChild(maskLayout, ZOrder)
    ZOrder = ZOrder + 1

    local titleBg = UI.Image:create()
    titleBg:init(TITLE_BG)
    titleBg:centerUp(20)
    self.bg:addChild(titleBg, ZOrder)
    ZOrder = ZOrder + 1

    local titleShadow = UI.Text:create()
    titleShadow:init(UI.TEXT_1213708, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_56_20_0)
    titleShadow:centerBottom(5)
    titleBg:addChild(titleShadow)

    local title = UI.Text:create()
    title:init(UI.TEXT_1213708, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_223_192_143)
    title:center()
    titleBg:addChild(title, 1)

    -- 货币组件
    local currencyBg = UI.Image:create()
    currencyBg:init(SHOW_MONEY_BG)
    currencyBg:centerUp(76)
    self.bg:addChild(currencyBg, ZOrder)
    ZOrder = ZOrder + 1

    self._currencyPanel = UI.CurrencyPanel:create()
    self._currencyPanel:rightUp(-51, 5 - 14.5 --[[货币组件空白高度大小]])
    self._currencyPanel:setShowShopButton(true, 52)
    currencyBg:addChild(self._currencyPanel)

    -- 分割线
    local line = UI.Image:create()
    line:init(LINE_DARK)
    line:centerUp(125)
    line:setImageScaleX(160)
    self.bg:addChild(line, 20)

    local costInfo = ConfigManager:getFastBuyByID(fastBuyId)
    local xArr = {48, 202, 354}

    -- 数量
    local numData = string.split(costInfo.item, ";")
    local num = {}
    for _,v in ipairs(numData) do
        table.insert(num, string.split(v, ",")[2])
    end

    -- 价格
    local priceData = string.split(costInfo.price, ";")
    local price = {}
    for _,v in ipairs(priceData) do
        table.insert(price, string.split(v, ",")[2])
    end

    for i = 1, 3 do 
        
        local grayBg = UI.Image:create()
        grayBg:init(GRAY_LAYOUT_BG)
        grayBg:leftUp(xArr[i], 125)
        self.bg:addChild(grayBg, ZOrder)

        local goodsData = GoodsDataManager:createLocalGoodsData(goodsId)
        goodsData:setNum(num[i])
        goodsData:setIsNew(false)
        goodsData.isHaveGet = false

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:center()
        goodsGrid:init(goodsData)
        goodsGrid:showInfoArea(true, false)
        grayBg:addChild(goodsGrid)

        local confirmBtn = UI.Button:create()
        confirmBtn:init("ui_btn_yellow9_0.png","ui_btn_yellow9_1.png","ui_btn_yellow9_2.png")
        confirmBtn:leftBottom(xArr[i] + 4, 38)
        confirmBtn:closeClickScale()
        confirmBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
            self.buyNum = tonumber(num[i])
            self.buyCost = tonumber(price[i])

            self:sendBuyRequest(fastBuyId, i - 1)
            self:close()
        end)
        self.bg:addChild(confirmBtn, ZOrder)

        local priceLayout = UI.Layout:create()
        priceLayout:init()
        priceLayout:enableAutoWidth()
        priceLayout:enableAutoHeight()
        priceLayout:center()
        confirmBtn:addChild(priceLayout, 1000)
    
        local diamond = UI.Image:create()
        diamond:init("symbol_gaming_diamond.png")
        diamond:floatLeft(0)
        priceLayout:addComponent(diamond)
    
        local diamondNum = UI.Text:create()
        diamondNum:init(tostring(price[i]), UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        diamondNum:floatLeft(4)
        priceLayout:addComponent(diamondNum)

    end
end

function PetBuyRebornItem:sendBuyRequest(id, seq)

    -- 判断背包是否够用
    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if freePacketNum > 0 then

        if Avalon.MathUtil:checkDiamonEnough(tonumber(self.buyCost), GameDataManager:getInstance():getDiamond()) then
            -- 增加物品
            UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(UI.TEXT_1212238, function(isSelect)
                Net.NetNPCSystem:reqFastBuy(id, seq)
                Avalon.AudioManager:playSound("1504")
            end, function(isSelect)
            end, nil, nil, false, self.buyCost)
        else
            -- 钻石不足
            local tips = UI.TipsLayer:onDiamondNotEnough()
            if(tips) then 
                tips:setZOrder(UI_ZORDER.MAX)
            end
            tips:removeFromParent(false)
            UI.UIManager:getRootNode():addChild(tips)
        end  
    else
        UI.ScrollBar:createByTextID(1111800)
    end
end