-- TradeLotteryItem.lua
-- Author:ydli
-- 2019年05月27日


UI = UI or {}
local TradeLotteryItem = class("TradeLotteryItem", UI.Component)
UI.TradeLotteryItem = TradeLotteryItem
local scheduler=cc.Director:getInstance():getScheduler()
-- 背包资源
local COM_RES_LIST = {
    "ui_town_businessactivities_turntable.plist"
}

local COM_WIDTH = 68
local COM_HEIGHT = 68

function TradeLotteryItem:ctor(data)
    TradeLotteryItem.super.ctor(self, 0, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.data = data --[[itemID, itemNum, isDraw, lotteryType]]
    self:init()
    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, self.itemClick)
end

function TradeLotteryItem:dtor()
    TradeLotteryItem.super.dtor(self)
    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
end

function TradeLotteryItem:init()
    TradeLotteryItem.super.init(self)
end

function TradeLotteryItem:onInitView()
    local goodsData = GoodsDataManager:createLocalGoodsData(self.data.itemID)
    if(goodsData) then
        goodsData:setNum(self.data.itemNum)
        goodsData:setIsNew(false)

        local goodsGrid = UI.GoodsGrid:create()
        goodsGrid:init(goodsData)
        goodsGrid:center()
        self:addChild(goodsGrid, 1)
        goodsGrid:hideBG()
        goodsGrid:setInfoArea(true, false)
        local imageName = nil
        if self.data.lotteryType == 1 then
            imageName = "ui_turntable_prize_01.png"
        elseif self.data.lotteryType == 2 then
            imageName = "ui_turntable_prize_02.png"
        end
        if imageName then
            local flag = UI.Image:create()
            flag:init(imageName)
            flag:rightUp(1, 2)
            goodsGrid:addChild(flag, 100)
            self.flag = flag
        end   

        if self.data.isDraw then
            local drawText = UI.Text:create()
            drawText:init(UI.TEXT_1212443, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_194_194_194)
            drawText:center()
            self:addChild(drawText, 10)
            if self.flag then
                self.flag:useShader(UI.COMPONENT_GRAY_SHADER)
            end
            goodsGrid:setIsGray()
        end
        self.goodsGrid = goodsGrid
    end 
 
    
end

function TradeLotteryItem:setIsGray()
    if self.goodsGrid then
        self.goodsGrid:setIsGray()
    end
end

function TradeLotteryItem:onUpdateView()

end

function TradeLotteryItem:itemClick()
    if self.goodsGrid then
        local info = self.goodsGrid:onShowInfoAreaHandler(true)
        if info then
            info:centerRight(50)
        end
    end
end

function TradeLotteryItem:getGoodsData()
    return self.goodsGrid:getData()
end