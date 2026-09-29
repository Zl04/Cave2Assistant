------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/04/13
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local FishGearShopCellView = class("FishGearShopCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_gemshop.plist"
}

local COM_WIDTH = 685
local COM_HEIGHT = 155

function FishGearShopCellView:ctor()
    FishGearShopCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.data = nil
    self:bindModel()
end

function FishGearShopCellView:init(data,commonShopType, ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.fishgear", "FishGear", false)
    self.data = data
    self._commonShopType = commonShopType or PublicDefine.CommonShopType.FishGear --通用商店类型, 用于购买道具时,使用不同消息接口
    FishGearShopCellView.super.init(self, ... )
end

function FishGearShopCellView:dtor()
    FishGearShopCellView.super.dtor(self)
    self.data = nil
    self:unbindModel()
    reload_script_file_mvc("app.modules.fishgear.FishGearShopCellView")
end


function FishGearShopCellView:onInitView()
    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    -- cellLayout:enableDebugDraw()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    -- 背景图片
    local bgSpName = "ui_fishing_bg_3.png"
    if self._commonShopType == PublicDefine.CommonShopType.RunesCave then
        bgSpName = "ui_rune_bg2.png"
    end
    local bg  = UI.Image:create()
    bg:init(bgSpName)
    bg:center()
    cellLayout:addChild(bg)
    self.bg = bg
    if self._commonShopType == PublicDefine.CommonShopType.RunesCave then
        bg:center(-10)
    else
        bg:center()
    end

    -- 标题
    local titleSpName = "ui_fishing_title_1.png"
    if self._commonShopType == PublicDefine.CommonShopType.RunesCave then
        titleSpName = "ui_rune_lable.png"
    end
    local title  = UI.Image:create()
    title:init(titleSpName)
    title:leftUp(-10, -35)
    cellLayout:addChild(title)

    local titleTxt = UI.Text:create()
    titleTxt:init(languageManagerInstance:getLocalString(self.data.name), UI.FONT_BOLD, UI.FONT_SIZE_22PX, UI.FONT_COLOR_237_236_217)
    titleTxt:center(-10,-4)
    title:addChild(titleTxt)

    self:cteateGoodsView()
end

function FishGearShopCellView:cteateGoodsView()
    local rewardData = self.data
    local GameInManorManager = require "app.game.GameInManorManager"
    local manorSceneData = GameInManorManager:getInstance():getManorSceneCommonData()
    if rewardData then
        local idList = string.split(rewardData.goodsID, ";")
        local priceIdList = string.split(rewardData.costID, ";")
        local priceList = string.split(rewardData.costNum, ";")
        local numList = string.split(rewardData.goodsNum, ";")
        local buyData = MasterDataManager:getGemstoneBuyData()
        for k, v in pairs(idList) do
            local finalPrice = priceList[k]
            if self._commonShopType == PublicDefine.CommonShopType.RunesCave then
                local goodsID = tonumber(v)
                for _, bData in pairs(buyData) do
                    if bData.item_id == goodsID then
                        finalPrice = self:getFinalPriceValue(goodsID, bData,finalPrice)
                    end
                end
            end

            local panel, goodsGrid = self:createItem(v, tonumber(numList[k]), finalPrice,priceIdList[k], k)
            panel:leftBottom(20 + 130 * (k - 1), -30)
            self.bg:addChild(panel)
        end
    end
end

function FishGearShopCellView:getFinalPriceValue(goodsID, bData, price)
    if goodsID ~= bData.item_id or self._commonShopType ~= PublicDefine.CommonShopType.RunesCave then
        return 9999
    end

    local finalPrice = price
    local num = bData.num
    local numList = string.split(self.data.conNum, ";")
    local multipleList = string.split(self.data.multiple, ";")

    if num > tonumber(numList[#numList]) then
        finalPrice = finalPrice * tonumber(multipleList[#multipleList])
    else
        for k,v in ipairs(numList) do
            if num <= tonumber(v) then
                finalPrice = finalPrice * tonumber(multipleList[k])
                break
            end
        end
    end

    return finalPrice
end

function FishGearShopCellView:createItem(itemId, number, price, costId, index)
    local costData = ConfigManager:getVirtualItemConfigByID(tonumber(costId)) or ConfigManager:getMaterialConfigByID(tonumber(costId))

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
    goodsGrid:setSwallowTouches(false)

    if number > 1 then
        local numberText = UI.Text:create()
        numberText:init(string.format("%s",number), UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_227_214_172)
        numberText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
        numberText:rightBottom(4, 0)
        goodsGrid:addChild(numberText, 20)
    end

    -- local lock = UI.Image:create()
    -- lock:init("ui_btn_purple_lock.png")
    -- lock:centerBottom(18)
    -- panel:addChild(lock)
    -- lock:setName("Lock")

    local btn = UI.Button:create();
    btn:init("ui_fishing_btn_2.png","ui_fishing_btn_2.png","ui_fishing_btn_2.png");
    btn:centerBottom(38);
    btn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        -- self:onBuyClick(index)
        local GameDataManager = require("app.game.GameDataManager")
        if (GameDataManager:getFreePacketBoxNum() <= 0) then
            UI.ScrollBar:createByText(UI.TEXT_1212306) 
            return
        end
        
        if self._commonShopType == PublicDefine.CommonShopType.RunesCave then
            -- local money = tonumber(costId) == 23400001 and RoleDataManager:getMaster():getGemBoughtCredit() or 0
            -- if money < tonumber(price) then
            --     UI.ScrollBar:createByText(UI.TEXT_223906)
            --     return
            -- end
            -- mvc.fishGearModel:setBuyGoodsNum(tonumber(number))
            -- Net.NetRoleSystem:reqGemShopBuyMessage(itemId, self.data.ID)

            --弹出批量购买界面
            local purchasedNum = 0
            local buyData = MasterDataManager:getGemstoneBuyData()
            for _, bData in pairs(buyData) do
                if tonumber(bData.item_id) == tonumber(itemId) then
                    purchasedNum = bData.num
                    break
                end
            end

            UI.TipsLayer:onCommonBulkPurchaseTips(function(purchase)   -- 确认回调
                if purchase > 0 then
                    Net.NetRoleSystem:reqGemShopBuyMessage(itemId, self.data.ID,purchase)
                end
                -- UI.UIManager:setShowMainUI(true)
                -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
            end, function()
                -- UI.UIManager:setShowMainUI(true)
                -- Avalon.MessageCenter:notice(GameMessage.MC_UI_SHOW_MAINUI_LAYER, nil)
            end, self._commonShopType, purchasedNum, {profileData = self.data, itemId = itemId})


            --弹出批量购买界面

        else
            local str = UI.TEXT_221604
            if self.data.itemType == 2 then
                str = UI.TEXT_221612
            elseif self.data.itemType == 3 then
                str = UI.TEXT_221613
            end
            local des = str
            if self.data.itemType == 1 then
                des = self:checkFishGearIsExist(tonumber(itemId)) and UI.TEXT_221608 or str
            end
            local tips = UI.Tips:createTips(
                string.format(des, price,costData.name),
                UI.TipsType.CONFIRM_AND_CANCEL,
                UI.TipsUiType.NORMAL
            )
                

            tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                -- local GameDataManager = require("app.game.GameDataManager")
                -- if (GameDataManager:getFreePacketBoxNum() <= 0) then
                --     UI.ScrollBar:createByText(UI.TEXT_1212306) 
                --     return
                -- end

                -- if self._commonShopType == PublicDefine.CommonShopType.FishGear then
                    local money = tonumber(costId) == 23020001 and GameDataManager:getInstance():getCurCoin() or GameDataManager:getInstance():getDiamond()
                    if money < tonumber(price) then
                        if tonumber(costId) == 23020001 then
                            UI.TipsLayer:onGlodNotEnough()
                            return
                        elseif tonumber(costId) == 23030001 then
                            UI.TipsLayer:onDiamondNotEnough()
                            return
                        end
                    end
                    mvc.fishGearModel:setBuyGoodsNum(tonumber(number))
                    Net.NetManorSystem:reqFishingShopBuy(itemId, self.data.ID)
                -- elseif self._commonShopType == PublicDefine.CommonShopType.RunesCave then
                --     local money = tonumber(costId) == 23400001 and RoleDataManager:getMaster():getGemBoughtCredit() or 0
                --     if money < tonumber(price) then
                --         UI.ScrollBar:createByText(UI.TEXT_223906)
                --     end
                --     mvc.fishGearModel:setBuyGoodsNum(tonumber(number))
                --     Net.NetRoleSystem:reqGemShopBuyMessage(itemId, self.data.ID)
                -- end

            end)
        end
    end)
    panel:addChild(btn)
    btn:setName("BuyButton")

    if self._commonShopType == PublicDefine.CommonShopType.RunesCave then
        btn:setTextFont( UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 25, g = 23, b = 21})
        btn:setText(UI.TEXT_1212227)
    else
        local buyIcon = UI.Image:create()
        buyIcon:init(costData.miniIcon)--("symbol_dreamword.png")
        btn:addChild(buyIcon, 10)
        
        local buyNumber = UI.Text:create()
        buyNumber:init(price.."", UI.FONT_STANDARD, UI.FONT_SIZE_15PX, UI.FONT_COLOR_41_41_45)
        buyNumber:centerLeft(20)
        btn:addChild(buyNumber, 10)

        local left = (btn:getContentSize().width - buyIcon:getContentSize().width - buyNumber:getContentSize().width - 10) / 2
        buyIcon:centerLeft(left)
        buyNumber:centerLeft(left + buyIcon:getContentSize().width  + 5)
    end

    return panel, goodsGrid
end

function FishGearShopCellView:checkFishGearIsExist(id)
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

function FishGearShopCellView:bindModel()

end


function FishGearShopCellView:unbindModel()

end





return FishGearShopCellView












