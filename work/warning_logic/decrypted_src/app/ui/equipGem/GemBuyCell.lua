-- GemBuyCell.lua
-- Author:ydli
-- 2018年6月20日
-- Using:宝石购买 cell
local LanguageManager = require("app.game.LanguageManager")
UI = UI or {}
local scheduler = cc.Director:getInstance():getScheduler()
local GameDataManager = require("app.game.GameDataManager")
local model = require("app.uiExport.GemBuyModel")
local GemBuyCell = class("GemBuyCell", UI.HWBtnComponent)
UI.GemBuyCell = GemBuyCell
local winSize = cc.Director:getInstance():getWinSize()
local CELL_SIZE = cc.size(213, 390)
local AWARD_DIAMOND = "symbol_gaming_diamond.png" -- 钻石图片
-- 资源列表(必备)
local COM_RES_LIST = {
}
function GemBuyCell:ctor(spriteID, data, index)
    GemBuyCell.super.ctor(self)
    self:setSize(200, 265)
    self.iconIndex = index;
    self._spriteID  = spriteID
    self._data = data
    self._cellPanels = {}
    self.schedulerID = nil
    local PufAds = PublicDefine.AdvertFuncType
    local list = {PufAds.AdvertFuncType_GemStone_1, PufAds.AdvertFuncType_GemStone_2, PufAds.AdvertFuncType_GemStone_3}
    self.adsPlaceId = list[index] or PufAds.AdvertFuncType_GemStone_1
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshDiamondFontColor)
    self:init()
end

-- 析构函数
function GemBuyCell:dtor()
    GemBuyCell.super.dtor(self)
    self._cellPanels = {}
    if self.schedulerID ~= nil then
        scheduler:unscheduleScriptEntry(self.schedulerID)
        self.schedulerID = nil
    end
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.refreshDiamondFontColor)
end

function GemBuyCell:onInitView()
    self.gemModel = model.create("cellModel")
    self.gemModel.root:leftUp(0, 0)
    self:addChild(self.gemModel.root)


    self.gemModel.itemBuyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(param, sender, touch) 
        self:buyClick(sender, touch, false)
    end)

    self.gemModel.diamondBuyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(param, sender, touch) 
        self:buyClick(sender, touch, true)
    end)

    self.gemModel.playAdsBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(param, sender, touch) 
        if tolua.isnull(self) then
            return
        end
        local orderId = AvalonUtil.getCurrentTime()
        GameManager:sendAdsLog(PublicDefine.AdsPlaceId.GemLuckDrop, self.adsPlaceId, orderId, 5)
        local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(self.adsPlaceId)
        local maxTime = adsData == nil and 0 or adsData.maxNum
        local textList =  {UI.TEXT_1212427 , string.format(UI.TEXT_1212428, maxTime or 0)}
        UI.ConfirmDialog.showConfirmDialogCancelRedOkWhiteAndTexts(textList, function(isSelect)
            GameManager:sendAdsLog(PublicDefine.AdsPlaceId.GemLuckDrop, self.adsPlaceId, orderId, 6)
            GameManager:playAds(PublicDefine.AdsPlaceId.GemLuckDrop, self.adsPlaceId, orderId)
        end, function(isSelect)
            GameManager:sendAdsLog(PublicDefine.AdsPlaceId.GemLuckDrop, self.adsPlaceId, orderId, 7)
        end, nil, nil, false)
    end)

    self:initBtnInfo(self.gemModel.itemBuyBtn, UI.TEXT_1172011);
    self:initBtnInfo(self.gemModel.diamondBuyBtn, UI.TEXT_1172012)
    local playAdsDes = self.gemModel.playAdsBtn:getChildByName("PlayAdsDes")
    playAdsDes:setText(UI.TEXT_1212930)
    playAdsDes:centerLeft(104 - playAdsDes:getContentSize().width / 2)

    AvalonUtil.createClockAnimation(self.gemModel.timeIcon)

    self:refreshView()
    self.schedulerID = scheduler:scheduleScriptFunc(handler(self,self.update), 1,false)
end

function GemBuyCell:reload(data)
    self._data = data
    self:refreshView()
end

function GemBuyCell:initBtnInfo(btn)
    local component = UI.Component:create()
    component:init()
    component:center();

    local icon = UI.Image:create()
    icon:init(AWARD_DIAMOND)
    icon:centerLeft(0, 0)
    component:addChild(icon)

    local price = UI.Text:create();
    price:init("111", UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    price:centerRight(0, 0)
    component:addChild(price)

    btn:addChild(component, 10)
    btn.iconNode = icon
    btn.priceNode = price
    btn.componentNode = component
    self:updateBtnLayout(btn)
end

function GemBuyCell:updateBtnLayout(btn)
    local width = btn.iconNode._width + btn.priceNode._width + 7
    btn.componentNode:setSize(width, 0)
end

function GemBuyCell:update(dt)
    local cfgData = self._data
    local netData = MasterDataManager:getOneGemstoneShopRecordById(cfgData.ID)
    -- dump(cfgData, "--cfgData----")
    if cfgData == nil or netData == nil then
        printError("GemBuyCell:update cfgData or netData is nil :", cfgData.ID)
        return
    else
        local oneTimeDesc = self.gemModel.restTimeStr
        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(cfgData.costGoodsID1time), true)
        if netData.freeSec <= GameManager:getNormalServerTime() then
            if oneTimeDesc:isVisible() then
                self:refreshView()
            end
        else
            if not oneTimeDesc:isVisible() then
                self.gemModel.timeIcon:show()
                oneTimeDesc:show()
                local oneBtn = self.gemModel.itemBuyBtn
                oneBtn.iconNode:show()
                oneBtn.priceNode:show()
            end
            -- print("---netData.freeSec - GameManager:getNormalServerTime()--", (netData.freeSec - GameManager:getNormalServerTime()))
            local time = netData.freeSec - GameManager:getNormalServerTime()
            if time > 99 * SECONDS_ONE_HOUR then
                oneTimeDesc:setText("> 99h")
            else
                local h = math.floor(time / SECONDS_ONE_HOUR)
                time = time - h * SECONDS_ONE_HOUR
                local m = math.floor(time / SECONDS_ONE_MINUTES)
                time = time - m * SECONDS_ONE_MINUTES
                local seconds = time
                oneTimeDesc:setText(string.format("%.2d:%.2d:%.2d", h, m, seconds))
            end
        end
    end
end

function GemBuyCell:refreshView()
    local cfgData = self._data
    local netData = MasterDataManager:getOneGemstoneShopRecordById(cfgData.ID)
    -- dump(cfgData, "--cfgData----")
    if cfgData == nil or netData == nil then
        printError("GemBuyCell:refreshView cfgData or netData is nil :", cfgData.ID)
        return
    else
        self.gemModel.cellIcon:setSpriteName(cfgData.icon)
        self.gemModel.cellTitle:setText(cfgData.name)
        self.gemModel.cellDes:setText(cfgData.contentDesc)
        self.gemModel.cellDes2:setText(cfgData.explorationExpDesc)

        local rewardDes = ""
        if netData.count >= GEM_SHOP_BUY_LUCKY_COUNT - 1 then
            rewardDes = string.format("%s%s", UI.TEXT_1172015, cfgData.description)
        else
            rewardDes = string.format("%s%s", string.format(UI.TEXT_1172014, GEM_SHOP_BUY_LUCKY_COUNT - netData.count), cfgData.description)
        end
        self.gemModel.cellRewardDes:setText(rewardDes);

        local oneBtn = self.gemModel.itemBuyBtn
        oneBtn.priceNode:setFontColor(UI.FONT_COLOR_50_50_44)
        oneBtn:enable()
        

        local playAdsBtn = self.gemModel.playAdsBtn
        playAdsBtn:hide()
        --1是否免费 2是否道具足够 3 是否钻石足够
        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(cfgData.costGoodsID1time), true)
        if netData.freeSec <= GameManager:getNormalServerTime() then
            self.gemModel.freeDes:setVisible(true)
            oneBtn.componentNode:hide()
            self.gemModel.timeIcon:hide()
            self.gemModel.restTimeStr:hide()
            playAdsBtn:hide()
        else
            self.gemModel.freeDes:setVisible(false)
            oneBtn.componentNode:show()
            self.gemModel.timeIcon:show()
            self.gemModel.restTimeStr:show()
            local time = netData.freeSec - GameManager:getNormalServerTime()
            local h = math.floor(time / SECONDS_ONE_HOUR)
            time = time - h * SECONDS_ONE_HOUR
            local m = math.floor(time / SECONDS_ONE_MINUTES)
            time = time - m * SECONDS_ONE_MINUTES
            local seconds = time
            self.gemModel.restTimeStr:setText(string.format("%.2d:%.2d:%.2d", h, m, seconds))
            if goodNumber >= cfgData.costGoodsNum1time then
                local goodData = GoodsDataManager:createLocalGoodsData(tonumber(cfgData.costGoodsID1time))
                if goodData then
                    oneBtn.iconNode:setSpriteName(goodData:getSmallIconName())
                    oneBtn.priceNode:setText(cfgData.costGoodsNum1time)
                else
                    oneBtn.componentNode:hide()
                end
            elseif Avalon.MathUtil:checkDiamonEnough(cfgData.costCrystal1time, GameDataManager:getInstance():getDiamond()) then
                oneBtn.iconNode:setSpriteName(AWARD_DIAMOND)
                oneBtn.priceNode:setText(cfgData.costCrystal1time)
            else
                oneBtn.iconNode:setSpriteName(AWARD_DIAMOND)
                oneBtn.priceNode:setText(cfgData.costCrystal1time)
                oneBtn.priceNode:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
            end
            local adsData = GameDataManager:getInstance():getAdvertDataBySerAdid(self.adsPlaceId)
            if adsData and adsData.isOpen and adsData.gotNum < adsData.maxNum then
                playAdsBtn:show()
            else
                playAdsBtn:hide()
            end
        end

        self:updateBtnLayout(oneBtn);

        local tenBtn = self.gemModel.diamondBuyBtn
        tenBtn.priceNode:setFontColor(UI.FONT_COLOR_50_50_44)
        tenBtn:enable()
        local diamondIcon = tenBtn.iconNode
        local diamondNumber = tenBtn.priceNode

        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(cfgData.costGoodsID10times), true)
        if goodNumber >= cfgData.costGoodsNum10times then
            local goodData = GoodsDataManager:createLocalGoodsData(tonumber(cfgData.costGoodsID10times))
            if goodData then
                diamondIcon:setSpriteName(goodData:getSmallIconName())
                diamondNumber:setText(cfgData.costGoodsNum10times)
            else
                diamondIcon:hide()
                diamondNumber:hide()
            end
        elseif Avalon.MathUtil:checkDiamonEnough(cfgData.costCrystal10times, GameDataManager:getInstance():getDiamond()) then
            diamondIcon:setSpriteName(AWARD_DIAMOND)
            diamondNumber:setText(cfgData.costCrystal10times)
        else
            diamondIcon:setSpriteName(AWARD_DIAMOND)
            diamondNumber:setText(cfgData.costCrystal10times)
            diamondNumber:setFontColor(UI.FONT_COLOR_NOT_ENOUGH)
        end
        self:updateBtnLayout(tenBtn)

        --更新今日可购买次数 (CO-17181  添加,  范围: 国内版本   目的: 审核内容, 限制次数)
        local remainingTimesText = self.gemModel.remainingTimesText
        if remainingTimesText ~= nil then
            local rTextStr = UI.TEXT_221300
            local maxTime = cfgData.DailyMaxTime - netData.dailyCount
            if maxTime < 0 then
                maxTime = 0
                oneBtn:disable()
                tenBtn:disable()
                playAdsBtn:hide()
                self.gemModel.freeDes:setVisible(false)
                self.gemModel.restTimeStr:hide()
            end
            remainingTimesText:setText(rTextStr .. maxTime)
        end
    end
end


function GemBuyCell:onUpdateView()
   
end

function GemBuyCell:buyClick(sender, touch, isTen)

    local cfgData = self._data
    local netData = MasterDataManager:getOneGemstoneShopRecordById(cfgData.ID)
    if cfgData == nil or netData == nil then
        printError("GemBuyCell:buyClick cfgData or netData is nil :", cfgData.ID)
        return
    end
    
    local useType = nil
    if not isTen then
        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(cfgData.costGoodsID1time), true)
        if netData.freeSec <= GameManager:getNormalServerTime() then
            useType = PublicDefine.GemstoneBoughtCostType.GemstoneBoughtCostType_Free
        else
            if goodNumber >= cfgData.costGoodsNum1time then
                useType = PublicDefine.GemstoneBoughtCostType.GemstoneBoughtCostType_Item     
            elseif Avalon.MathUtil:checkDiamonEnough(cfgData.costCrystal1time, GameDataManager:getInstance():getDiamond()) then
                useType = PublicDefine.GemstoneBoughtCostType.GemstoneBoughtCostType_Diamond 
            else
                UI.TipsLayer:onDiamondNotEnough()
                return
            end
        end
    else
        local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(cfgData.costGoodsID10times), true)
        if goodNumber >= cfgData.costGoodsNum10times then
            useType = PublicDefine.GemstoneBoughtCostType.GemstoneBoughtCostType_Item
        elseif Avalon.MathUtil:checkDiamonEnough(cfgData.costCrystal10times, GameDataManager:getInstance():getDiamond()) then
            useType = PublicDefine.GemstoneBoughtCostType.GemstoneBoughtCostType_Diamond
        else
            UI.TipsLayer:onDiamondNotEnough()
            return
        end
    end

    local number = 1
    if isTen then
        number = 10
    end
    local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
    if freePacketNum < number then
        UI.ScrollBar:createByTextID(1170081)
        return
    end
    
    if RoleBehaviorManager:equipGemTownNpcCheck() then
        printWarn(" been blocked when using gem npc buyshop function !")
        return
    end

    if useType == nil then
        printError(" GemBuyCell buyClick but useType is nil")
        return
    end
    --send net 
    local isNotice = cc.UserDefault:getInstance():getBoolForKey(UserDefaultKeyWord.isNoticeGemBuy..GameDataManager:getInstance():getMasterPK(), true) 
    if useType == PublicDefine.GemstoneBoughtCostType.GemstoneBoughtCostType_Diamond and isNotice then
        local text = ""
        local cost = 0
        if not isTen then
            text = UI.TEXT_1212234 
            cost = cfgData.costCrystal1time
        else
            text = UI.TEXT_1212235
            cost = cfgData.costCrystal10times
        end
        UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(text, function(isSelect)
            if isSelect then
                cc.UserDefault:getInstance():setBoolForKey(UserDefaultKeyWord.isNoticeGemBuy..GameDataManager:getInstance():getMasterPK(), false)  
            end
            UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
            Net.NetNPCSystem:sendGemShopBuy(cfgData.ID, self._spriteID, useType, isTen)
        end, function(isSelect)
            
        end, nil, nil, true, cost)
    else
        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
        Net.NetNPCSystem:sendGemShopBuy(cfgData.ID, self._spriteID, useType, isTen)
    end
end



