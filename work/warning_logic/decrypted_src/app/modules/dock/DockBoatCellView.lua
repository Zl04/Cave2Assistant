------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/04/13
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DockBoatCellView = class("DockBoatCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 685
local COM_HEIGHT = 155

function DockBoatCellView:ctor()
    DockBoatCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = nil
    self:bindModel()
end

function DockBoatCellView:init(data, ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.dock", "Dock", false)
    self.data = data
    DockBoatCellView.super.init(self, ... )
end

function DockBoatCellView:dtor()
    DockBoatCellView.super.dtor(self)
    self.data = nil
    self:unbindModel()
    -- reload_script_file_mvc("app.modules.dock.DockBoatCellView")
end


function DockBoatCellView:onInitView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    -- cellLayout:enableDebugDraw()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_fishing_bg_3.png")
    bg:center()
    cellLayout:addChild(bg)
    self.bg = bg

    -- 标题
    local title  = UI.Image:create()
    title:init("ui_fishing_title_1.png")
    title:leftUp(-10, -35)
    cellLayout:addChild(title)

    local titleTxt = UI.Text:create()
    titleTxt:init(languageManagerInstance:getLocalString(self.data.name), UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_237_236_217)
    titleTxt:center(-10,-4)
    title:addChild(titleTxt)

    self:cteateGoodsView()
end

function DockBoatCellView:cteateGoodsView()
    local rewardData = self.data
    local GameInManorManager = require "app.game.GameInManorManager"
    local manorSceneData = GameInManorManager:getInstance():getManorSceneCommonData()
    if rewardData then
        local idList = string.split(rewardData.goodsID, ";")
        local priceIdList = string.split(rewardData.costID, ";")
        local priceList = string.split(rewardData.costNum, ";")
        for k, v in pairs(idList) do
            local panel, goodsGrid = self:createItem(v, 1, priceList[k],priceIdList[k], k)
            panel:leftBottom(20 + 130 * (k - 1), -30)
            self.bg:addChild(panel)
        end
    end
end

function DockBoatCellView:createItem(itemId, number, price, costId, index)
    local costData = ConfigManager:getVirtualItemConfigByID(tonumber(costId)) 

    local panel = UI.Layout:create()
    panel:init()
    panel:setSize(132, 132)

    local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(itemId))
    goodsData:setIsNew(false)
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:init(goodsData)
    goodsGrid:centerBottom(84)
    panel:addChild(goodsGrid, 1)
    goodsGrid:showInfoArea(false, true)
    goodsGrid:setName("GoodsGrid")
    -- goodsGrid:setTouchEnable(true)

    if number > 1 then
        local numberText = UI.Text:create()
        numberText:init(string.format("%s",number), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
        numberText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
        numberText:rightBottom(4, 0)
        goodsGrid:addChild(numberText, 20)
    end

    local btn = UI.Button:create();
    btn:init("ui_fishing_btn_2.png","ui_fishing_btn_2.png","ui_fishing_btn_2.png");
    btn:centerBottom(38);
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- self:onBuyClick(index)
        local des = self:checkFishGearIsExist(tonumber(itemId)) and UI.TEXT_221608 or UI.TEXT_221604
        local tips = UI.Tips:createTips(
                string.format(des, price,costData.name),
                UI.TipsType.CONFIRM_AND_CANCEL,
                UI.TipsUiType.NORMAL
            )
            

            tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                local GameDataManager = require("app.game.GameDataManager")
                if (GameDataManager:getFreePacketBoxNum() <= 0) then
                    UI.ScrollBar:createByText(UI.TEXT_1212306) 
                    return
                end

                local money = tonumber(costId) == 23020001 and GameDataManager:getInstance():getCurCoin() or GameDataManager:getInstance():getDiamond()
                if money < tonumber(price) then
                    if tonumber(costId) == 23020001 then
                        UI.TipsLayer:onGlodNotEnough()
                        return
                    else
                        UI.TipsLayer:onDiamondNotEnough()
                        return
                    end
                end
                
                Net.NetManorSystem:reqFishingShopBuy(itemId)
            end)
    end)
    panel:addChild(btn)
    btn:setName("BuyButton")

    local buyIcon = UI.Image:create()
    buyIcon:init(costData.miniIcon)--("symbol_dreamword.png")
    btn:addChild(buyIcon, 10)

    local buyNumber = UI.Text:create()
    buyNumber:init(price.."", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    buyNumber:centerLeft(20)
    btn:addChild(buyNumber, 10)

    local left = (btn:getContentSize().width - buyIcon:getContentSize().width - buyNumber:getContentSize().width - 10) / 2
    buyIcon:centerLeft(left)
    buyNumber:centerLeft(left + buyIcon:getContentSize().width  + 5)

    return panel, goodsGrid
end

function DockBoatCellView:checkFishGearIsExist(id)
    local GameDataManager = require("app.game.GameDataManager")
    local bagData = GameDataManager:getInstance():getPacketBoxData()
    master = RoleDataManager:getMaster()
    local bagArr = GoodsDataManager:getPackArrForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE)
    local exist = false
    for k, v in pairs(bagData.wearEquipmentArr) do
        if v.goodsID == id then
            exist = true
            return exist
        end
    end

    for k, v in pairs(bagData.haveEquipmentArr) do
        if v.goodsID == id then
            exist = true
            return exist
        end
    end

    for k, v in pairs(bagArr) do
        for i, j in pairs(v) do
            if j.goodsID and j.goodsID == id then
                exist = true
                return exist
            end
        end
    end
    return exist
end

function DockBoatCellView:bindModel()

end


function DockBoatCellView:unbindModel()

end





return DockBoatCellView












