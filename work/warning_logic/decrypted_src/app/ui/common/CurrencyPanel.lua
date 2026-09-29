    
    -- CurrencyPanel.lua
-- Author:zp
-- 2018年9月20日
-- Using: 用于公共货币组件

UI = UI or {}

local SceneManager = require("app.game.SceneManager")

local CurrencyPanel = class("CurrencyPanel", UI.HWBtnComponent)
UI.CurrencyPanel = CurrencyPanel
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

local COM_WIDTH = 353
local COM_HEIGHT = 50
-- 资源列表(必备)


local function onCurrencyChangeHandler(self, data)
    if (data) then
        if self.isInCacheMode then
            table.insert(self.cacheData, data)
            return
        end
        self:updateMoneyView()
        -- 处理金币以及钻石表现
        local text = UI.Text:create()
        text:init("", UI.FONT_ARIAL)
        text:centerBottom(10)

        if(data.value >0 ) then
            -- text:setFontColor(UI.GREEN)
            text:setFontColor(UI.FONT_COLOR_GREEN)
            text:setText(string.format("+%d",data.value))
        else
            -- text:setFontColor(UI.RED)
            text:setFontColor(UI.FONT_COLOR_RED)
            text:setText(string.format("-%d",math.abs(data.value)))
        end

        if data.costType == GOODS_COST_TYPE.GOLD and self._momey then
            self._momey:addChild(text)
        elseif data.costType == GOODS_COST_TYPE.GEM and self._diamond then
            self._diamond:addChild(text)
        elseif data.costType == GOODS_COST_TYPE.GEM_BUY and self._runesCaveCurrency then
            self._runesCaveCurrency:addChild(text)
        else 
            return
        end
        text:updateView()

        if(self._waitingNum == nil) then
            self._waitingNum = 0
        end

        local delayTime = self._waitingNum * 0.5
        if(delayTime < 0) then
            delayTime = 0
        end

        text:setVisible(false)
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            if(self and not tolua.isnull(self)) then
                text:setVisible(true)
                text:runAction(cc.Spawn:create(
                    cc.MoveBy:create(0.5,cc.p(0,20)),
                    cc.Sequence:create(cc.DelayTime:create(0.4),
                    cc.FadeOut:create(0.1),cc.RemoveSelf:create(), cc.CallFunc:create(function() 
                        self._waitingNum = self._waitingNum - 1
                    end))))
            end
        end,delayTime)
        self._waitingNum = self._waitingNum + 1
    end
end

--构造函数(必备)
--isShowBtn: 是否需要展现假的不可点击按钮图， false：表示不显示，然后按钮交由外部实现
function CurrencyPanel:ctor(fontColor, isShowCurrencyBg, shopType)
    --窗口大小
    CurrencyPanel.super.ctor(
    self,0,
    {},
    COM_WIDTH,  
    COM_HEIGHT
    )
    self.isInCacheMode = false
    self.cacheData = {}
    self._showShopBtn = true
    self._fontColor = fontColor or UI.FONT_COLOR_41_41_45
    self._isShowCurrencyBg = isShowCurrencyBg
    self._shopType = shopType or PublicDefine.CurrencyPanelType.Normal
    self.parentWin = nil
    self:registerListener()
    self:init()
end

--虚构函数,destroy时调用(必备)
function CurrencyPanel:dtor()
    CurrencyPanel.super.dtor(self)
    self:unRegisterListener()
    self.isInCacheMode = false
    self.cacheData = {}
end

-- 初始化(必备)
function CurrencyPanel:init()
    CurrencyPanel.super.init(self)
end

function CurrencyPanel:setParentWin(parentWin)
    self.parentWin = parentWin
end

-- 模版函数：初始化组建的视图(必备)
function CurrencyPanel:onInitView()
    -- 货币
    local currentLayout = UI.Layout:create()
    currentLayout:init()
    currentLayout:setSize(353, 50)
    currentLayout:center()
    self:addChild(currentLayout)
    self._currentLayout = currentLayout
    

    if self._shopType == PublicDefine.CurrencyPanelType.Normal then
        self:createNormalView()
    elseif self._shopType == PublicDefine.CurrencyPanelType.RunesCave then
        self:createRunesCaveView()
    end


    self:_refreshView()
    self:updateMoneyView()
end

function CurrencyPanel:createRunesCaveView()
    self._runesCaveImage = UI.Image:create()
    self._runesCaveImage:init("symbol_material_integralcurrency.png")
    self._runesCaveImage:centerLeft(4)
    self._currentLayout:addChild(self._runesCaveImage, 4)

    -- 黄金数量
    self._runesCaveCurrency = UI.Text:create()
    self._runesCaveCurrency:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, self._fontColor)
    self._runesCaveCurrency:setTextLeft()
    self._runesCaveCurrency:centerLeft(self._runesCaveImage:getContentSize().width + 4)
    self._runesCaveImage:addChild(self._runesCaveCurrency, 4)
end

function CurrencyPanel:createNormalView()
    -- 黄金
    self._momeyImage = UI.Image:create()
    self._momeyImage:init("symbol_gaming_money.png")
    self._momeyImage:centerLeft(4)
    self._currentLayout:addChild(self._momeyImage, 4)

    if self._isShowCurrencyBg then 
        local bg = UI.Image:create()
        bg:init("ui_information_bg_currency.png")
        bg:centerLeft(0)
        self._momeyImage:addChild(bg, -1)
    end


    -- 黄金数量
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, self._fontColor)
    self._momey:setTextLeft()
    self._momey:centerLeft(self._momeyImage:getContentSize().width + 4)
    self._momeyImage:addChild(self._momey, 4)

    -- 钻石
    local diamondImage = UI.Image:create()
    diamondImage:init("symbol_gaming_diamond.png")
    diamondImage:centerLeft(168)
    self._currentLayout:addChild(diamondImage, 4)
    self._diamondImage = diamondImage
    if self._isShowCurrencyBg then 
        local bg = UI.Image:create()
        bg:init("ui_information_bg_currency.png")
        bg:centerLeft(0)
        diamondImage:addChild(bg, -1)
    end

    -- 钻石数量
    self._diamond = UI.Text:create()
    self._diamond:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, self._fontColor)
    self._diamond:setTextLeft()
    self._diamond:centerLeft(diamondImage:getContentSize().width + 4)
    diamondImage:addChild(self._diamond, 4)

    -- 钻石按钮
    local shopButton = UI.Button:create()
    if(self._isShowCurrencyBg) then 
        shopButton:init("ui_information_currency_jia.png", "ui_information_currency_jia.png")
    else
        shopButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    end
    shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, nil, nil, self.parentWin,
            PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_CurrencyPanel)
    end)
    shopButton:centerRight(0)
    self._currentLayout:addChild(shopButton, 6)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase)
        and not SceneManager:getInstance():isInStory() 
     then
        shopButton:show()
    else
        shopButton:hide()
    end
    self._shopButton = shopButton
end

function CurrencyPanel:setShowShopButton(flag, centerRight)
    if(flag == nil) then 
        flag = false
    end

    if (centerRight) then
        self._shopButton:centerRight(centerRight)
    end

    self._showShopBtn = flag
    self:_refreshView()
end

function CurrencyPanel:setShowGold(b)
    self._momeyImage:setVisible(b)
end

function CurrencyPanel:getGoldIcon()
    return self._momeyImage
end

function CurrencyPanel:getDiamondIcon()
    return self._diamondImage
end

function CurrencyPanel:updateMoneyView()
    local GameDataManager = require("app.game.GameDataManager")
    if self._momey then
        self._momey:setText(self._momey:numformat(string.format("%d",GameDataManager:getInstance():getCurCoin())))
        self._momey:updateView()
    end
    if self._diamond then
        self._diamond:setText(self._diamond:numformat(string.format("%d",GameDataManager:getInstance():getDiamond())))
        self._diamond:updateView()
    end

    if self._runesCaveCurrency then
        self._runesCaveCurrency:setText(self._runesCaveCurrency:numformat(string.format("%d",RoleDataManager:getMaster():getGemBoughtCredit())))
        self._runesCaveCurrency:updateView()
    end
end

function CurrencyPanel:_refreshView()
    if(self._shopButton) then 
        self._shopButton:setVisible(self._showShopBtn)
    end
end
    
    -- 注册监听事件(可选)
function CurrencyPanel:registerListener()
    -- 监听消息
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
end

-- 注销监听事件(可选)
function CurrencyPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
end
    
function CurrencyPanel:beginCacheMode()
    self.isInCacheMode = true
    self.cacheData = {}
end

function CurrencyPanel:endCacheMode()
    self.isInCacheMode = false
    for k, data in ipairs(self.cacheData) do
        onCurrencyChangeHandler(self, data)
    end
    self.cacheData = {}
end   
    