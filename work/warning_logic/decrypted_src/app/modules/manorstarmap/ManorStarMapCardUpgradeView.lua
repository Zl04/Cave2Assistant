------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/07/12
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapCardUpgradeView = class("ManorStarMapCardUpgradeView", UI.HWBtnComponent)
local GameInManorManager = require "app.game.GameInManorManager"

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
}

local COM_WIDTH = 1006
local COM_HEIGHT = 583

local MONEY_ICON = "symbol_material_navigationgold.png"
local MATERIAL_ICON = "symbol_material_bookmark.png" --@@@@ 先用金币代替

function ManorStarMapCardUpgradeView:ctor(mosaicType)
    ManorStarMapCardUpgradeView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._cardTable = nil
    self._mosaicType = mosaicType
end

function ManorStarMapCardUpgradeView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapCardUpgradeView.super.init(self, ... )
end

function ManorStarMapCardUpgradeView:dtor()
    ManorStarMapCardUpgradeView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapCardUpgradeView")
end


function ManorStarMapCardUpgradeView:onInitView()
    self:center()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- self._leftLayout = UI.Layout:create()
    -- self._leftLayout:init()
    -- self._leftLayout:setSize(473, 504)
    -- self._leftLayout:leftBottom(33,47)
    -- contentLayout:addChild(self._leftLayout)

    self._rightLayout = UI.Layout:create()
    self._rightLayout:init()
    self._rightLayout:setSize(426, 514)
    self._rightLayout:leftBottom(52 + 472,52)
    contentLayout:addChild(self._rightLayout,2)

    self._currencyLayout = UI.Layout:create()
    self._currencyLayout:init()
    self._currencyLayout:setSize(420, 514)
    self._currencyLayout:leftBottom(55 + 472,47)
    contentLayout:addChild(self._currencyLayout)

    self:createAndRefreshLeftUpgradePanel()

    self:createRightCardBoxPanel()

    self:createTopCurrency()
end

function ManorStarMapCardUpgradeView:createAndRefreshLeftUpgradePanel()
    -- self._leftLayout:removeAllChildren()
    if self._leftLayout then
        self._leftLayout:removeFromParent()
        self._leftLayout = nil
    end
    self._leftLayout = UI.Layout:create()
    self._leftLayout:init()
    self._leftLayout:setSize(473, 504)
    self._leftLayout:leftBottom(33,47)
    self.contentLayout:addChild(self._leftLayout)

    local upgradeConfig = ConfigManager:getAllUpgradeSlotData()

    for k,v in ipairs(upgradeConfig) do

        local upData = clone(v)
        local starCardUpgradeData = mvc.manorStarMapModel:getCardUpgradeDataBySlotId(upData.ID)
        if starCardUpgradeData then
            upData.slotId = starCardUpgradeData.slotId
            upData.cardId = starCardUpgradeData.cardId
            upData.endTime = starCardUpgradeData.endTime
        end

        local view = mvc.manorStarMapCardUpgradeCellView:create(upData)
        view:init()
        if k == 1 then
            view:floatUp(0)
        else
            view:floatUp(12)
        end
        self._leftLayout:addComponent(view)
    end

    self._leftFrame = UI.Animation:create()
    self._leftFrame:init("effect_ui_starmap_xuanzhong.json", "effect_ui_starmap_xuanzhong.atlas", 1);
    self._leftFrame:center(0,0)
    self._leftFrame:addAnimation("idle", true)
    self._leftLayout:addChild(self._leftFrame)

    self._leftFrame:hide()

end

function ManorStarMapCardUpgradeView:createRightCardBoxPanel()
    self._rightLayout:removeAllChildren()

    local rBg = UI.Image:create()
    rBg:init("ui_starmap_banner_bg_6.png")
    rBg:leftBottom(0,10)
    self._rightLayout:addChild(rBg)

    local cardTable = mvc.manorStarMapModel:getStarMapBoxCardData()
    if #cardTable == 0 then
        return
    else
        local cardTable2 = {}
        cardTable2 = cardTable
        cardTable = self:distinguishMosaicType(cardTable2)
    end

    if #cardTable > 1 then
        table.sort(cardTable, 
            function(a, b) 
                if a.cardPage == b.cardPage then
                    if a.level == b.level then
                        return a.cardId > b.cardId 
                    else
                        return a.level > b.level 
                    end
                else
                    return a.cardPage > b.cardPage 
                end
            end
        )
    end
    self._cardTable = cardTable 

    local tableView = UI.TableView:create({}, 420, 450)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(0,15)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        return 420,201
    end) 
    tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell then
            cell:removeAllChildren()
            cell:removeFromParent()
            cell = nil
        end
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()

                local cardLayout = UI.Layout:create()
                cardLayout:init()
                cardLayout:setSize(408,192)
                cardLayout:leftBottom(0,0)

                
                for i = 1 + (luaIdx - 1)*3, luaIdx*3 do
                    if self._cardTable[i] then
                        local cardView = mvc.manorStarMapCardUpgradeDragCellView:create(self._cardTable[i])
                        cardView:init()
                        cardView:floatLeft(9)
                        cardView:enableDrage()
                        cardView:setSwallowTouches(false)
                        cardLayout:addComponent(cardView)

                        cardView:setDragOutAreaJudgeNode(self._leftLayout)

                        cardView:setDragBeginCallback(function(cview)
                        
                        end)
                        cardView:setDragMoveCallback(function(cview, inSide)
                            if self._leftFrame and inSide then
                                self._leftFrame:show()
                            elseif self._leftFrame then
                                self._leftFrame:hide()
                            end
                        end)
                        cardView:setDragEndCallback(function(cview, inSide,isDragging)

                            if self._leftFrame then
                                self._leftFrame:hide()
                            end

                            if inSide and isDragging then
                                --检测升级槽是否满了
                                if mvc.manorStarMapModel:checkUpgradeCardSlotIsFull() then
                                    UI.ScrollBar:createByText(UI.TEXT_222632)
                                else
                                    local cost = 999
                                    local cardLevel = self._cardTable[i].level
                                    local cardConfig = ConfigManager:getAllStarCardDataByID(self._cardTable[i].cardId)

                                    local buildData = GameInManorManager:getInstance():getBuildDataByBuildId(PublicDefine.ManorBuildID.BuildID_StarMap)
                                    local buildLevel = buildData and buildData.level or 1
                                    local deskConfig = ConfigManager:getAllDeskDataByID(buildLevel)

                                    

                                    if cardLevel >= cardConfig.maxLevel then
                                        --卡片等级达到上限
                                        UI.ScrollBar:createByText(UI.TEXT_222636)
                                    elseif cardLevel >= deskConfig.starCardLevelMax then
                                        --书桌等级不足,不能提升卡片等级
                                        UI.ScrollBar:createByText(UI.TEXT_222637)
                                    else
                                        
                                        local raiseNeedGoodsNuma = cardConfig.raiseNeedGoodsNuma
                                        local needNums = string.split(raiseNeedGoodsNuma, ",")
                                        if #needNums >= cardLevel then
                                            cost = tonumber(needNums[cardLevel])
                                        end

                                        local upgradeTips = UI.Tips:createTips(string.format(UI.TEXT_222633, cost),
                                            UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)

                                        upgradeTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                                            local sailGold = RoleDataManager:getMaster():getSailGold()
                                            if sailGold < cost then
                                                UI.ScrollBar:createByText(UI.TEXT_222634)
                                            else
                                                --星辰卡开始升级请求
                                                local cardId = cview._cardData.cardId
                                                local slotId = mvc.manorStarMapModel:getIdleSlotId()
                                                Net.NetManorSystem:reqStarCardUpgrade(slotId,cardId)
                                            end
                                        end)

                                    end
                                end

                            end
                        end)

                    end
                end

                cell:addChild(cardLayout)
            end, 
            function(e) 
                printError("------------------------createRightCardBoxPanel-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onUpdateCellNumbers(function()
        return math.ceil(#self._cardTable / 3)
    end)
    self._rightLayout:addChild(tableView)
    tableView:reloadData()
    self._tableView = tableView

    local bannerUp = UI.Image:create()
    bannerUp:init("ui_starmap_banner_up_3.png")
    bannerUp:leftBottom(0,10)
    self._rightLayout:addChild(bannerUp)
end

function ManorStarMapCardUpgradeView:refreshRightCardBoxPanel()
    local cardTable = mvc.manorStarMapModel:getStarMapBoxCardData()
    if #cardTable == 0 then
        return
    else
        local cardTable2 = {}
        cardTable2 = cardTable
        cardTable = self:distinguishMosaicType(cardTable2)
    end

    if #cardTable > 1 then
        table.sort(cardTable, 
            function(a, b) 
                if a.cardPage == b.cardPage then
                    if a.level == b.level then
                        return a.cardId > b.cardId 
                    else
                        return a.level > b.level 
                    end
                else
                    return a.cardPage > b.cardPage 
                end
            end
        )
    end
    self._cardTable = cardTable 

    if self._tableView then
        self._tableView:reloadData()
    end
end

function ManorStarMapCardUpgradeView:createTopCurrency()
    local momeyImage = UI.Image:create()
    momeyImage:init(MONEY_ICON)
    momeyImage:leftUp(34, -2)
    self._currencyLayout:addChild(momeyImage)
    -- 航行币
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._momey:setTextVerticalCenter()
    self._momey:setTextLeft()
    self._momey:centerLeft(momeyImage:getContentSize().width + 4)
    momeyImage:addChild(self._momey)

    local sailImage = UI.Image:create()
    sailImage:init(MATERIAL_ICON)
    sailImage:leftUp(222, -2)
    self._currencyLayout:addChild(sailImage)
    --航行钻石
    self._sail = UI.Text:create()
    self._sail:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._sail:setTextVerticalCenter()
    self._sail:setTextLeft()
    self._sail:centerLeft(momeyImage:getContentSize().width + 4)
    sailImage:addChild(self._sail)

    self:updateCurrencyView()

    local lineImage = UI.Image:create()
    lineImage:init("ui_starmap_line.png")
    lineImage:leftUp(0, 28)
    self._currencyLayout:addChild(lineImage)

end

function ManorStarMapCardUpgradeView:updateCurrencyView()
    self._momey:setText(self._momey:numformat(string.format("%s", RoleDataManager:getMaster():getSailGold())))
    self._momey:updateView()
    self._sail:setText(self._sail:numformat(string.format("%s", RoleDataManager:getMaster():getSailDiamond())))
    self._sail:updateView()
end

function ManorStarMapCardUpgradeView:onCurrencyChangeHandler(data)
    if data then
        self:updateCurrencyView()

        local text = UI.Text:create()
        text:init("", UI.FONT_ARIAL)
        text:centerBottom(10)

        if(data.value >0 ) then
            text:setFontColor(UI.FONT_COLOR_GREEN)
            text:setText(string.format("+%d",data.value))
        else
            text:setFontColor(UI.FONT_COLOR_RED)
            text:setText(string.format("-%d",math.abs(data.value)))
        end

        if(data.costType == PublicDefine.GOODS_COST_TYPE.SAIL_GOLD) then
            
            self._momey:addChild(text)
        elseif data.costType == PublicDefine.GOODS_COST_TYPE.SAIL_DIAMOND then
            
            self._sail:addChild(text)
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
                if not text or tolua.isnull(text) then
                    return
                end
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

function ManorStarMapCardUpgradeView:distinguishMosaicType(cardTable)
    local finalTable = {}
    for k,v in pairs(cardTable) do
        local cardConfig = ConfigManager:getAllStarCardDataByID(v.cardId)
        if self._mosaicType == cardConfig.mosaicType then
            table.insert(finalTable, v)
        end
    end
    return finalTable
end

function ManorStarMapCardUpgradeView:setMosaicType(MosaicType)
    -- body
    self._mosaicType = MosaicType
    self:refreshRightCardBoxPanel()
end

function ManorStarMapCardUpgradeView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end


function ManorStarMapCardUpgradeView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end





return ManorStarMapCardUpgradeView












