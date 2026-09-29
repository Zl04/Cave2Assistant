-- local GoodsCostText = class("")
local GoodsCostText = class("GoodsCostText", UI.Text)
local GameDataManager = require("app.game.GameDataManager")
UI.GoodsCostText = GoodsCostText
local DEFAULT_SHOW_SIZE = 5

function GoodsCostText:ctor(str, costGoodsTemplateId, costNum, fontName, fontSize, enoughColor, unEnoughColor)
    self.costNum = costNum
    self.str = str or tostring(self.costNum)
    self.costGoodsTemplateId = costGoodsTemplateId
    self.enoughColor = enoughColor or UI.FONT_COLOR_41_41_45
    self.fontName = fontName
    self.fontSize = fontSize
    self.unEnoughColor = unEnoughColor or UI.FONT_COLOR_NOT_ENOUGH
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_BAG_CHANGE, self, self.onCurrencyChangeHandler)

    GoodsCostText.super.ctor(self,tostring(self.str), fontName, fontSize, self.enoughColor)
    self._fullText = tostring(self.str)
    self._showSize = DEFAULT_SHOW_SIZE
    self._needCareWarehouse = false
    self:init()
end

function GoodsCostText:updateCost(costNum, str, costGoodsTemplateId)
    self.costNum = costNum
    if costGoodsTemplateId then
        self.costGoodsTemplateId = costGoodsTemplateId
    end
    if str then
        self:setText(str)
    end
    self:onCurrencyChangeHandler()
end

function GoodsCostText:init()
    GoodsCostText.super.init(self,tostring(self.str), self.fontName, self.fontSize, self.enoughColor)
end


function GoodsCostText:onInitView()
    GoodsCostText.super.onInitView(self)
    self:onCurrencyChangeHandler()
end
-- 析构函数
function GoodsCostText:dtor()
    GoodsCostText.super.dtor(self)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_BAG_CHANGE, self, self.onCurrencyChangeHandler)
end

function GoodsCostText:setCareWarehouseGoods(bool)
    self._needCareWarehouse = bool
end

function GoodsCostText:onCurrencyChangeHandler()
    local color = self.unEnoughColor
    local hasNum, warehouseNum = GameDataManager:getInstance():getGoodsDataNumForGoodsID(self.costGoodsTemplateId, true, self._needCareWarehouse)
    hasNum = hasNum + warehouseNum
    if Avalon.MathUtil:checkEnough(self.costNum, hasNum) then
        color = self.enoughColor
    end
    self:setFontColor(color)
end


-- 设置字体内容
function GoodsCostText:setText(text)
    self._fullText = text
    if tonumber(text) ~= nil then
        text = tonumber(text)
        local numberSize = AvalonUtil:getNumberSize(text)
        if numberSize > self._showSize and self._showSize ~= 0 then
            text = AvalonUtil:getTargetFormatedNum(text)
        else
            text = AvalonUtil:getCommaNumber(text)
        end
    end 
    GoodsCostText.super.setText(self, text)
end


--size：小数点前后需要保留的数字
function GoodsCostText:setShowSize(showSize)
    if showSize < 0 then
        return
    end 
    if self._showSize ~= showSize then
        self._showSize = showSize
    end
    if self._fullText ~= nil and tonumber(self._fullText) ~= nil then
        self:setText(self._fullText)
    end
end