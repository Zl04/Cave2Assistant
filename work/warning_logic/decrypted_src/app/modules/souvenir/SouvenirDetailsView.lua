------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/10/11
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SouvenirDetailsView = class("SouvenirDetailsView", UI.HWBtnComponent)

local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 528
local COM_HEIGHT = 540

local winSize = cc.Director:getInstance():getWinSize()

function SouvenirDetailsView:ctor(data)
    SouvenirDetailsView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._data = data
end

function SouvenirDetailsView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.souvenir", "Souvenir", false)
    SouvenirDetailsView.super.init(self, ... )
end

function SouvenirDetailsView:dtor()
    SouvenirDetailsView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.souvenir.SouvenirDetailsView")
end


function SouvenirDetailsView:onInitView()
    if not self._data then return end

    self:center()
    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 120))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_souvenir_bg.png")
    bg:center()
    contentLayout:addChild(bg)
    self._bg = bg

    self:initTopView()
    self:initCenterView()
    self:initBottomView()

    self:updateContent()

end


function SouvenirDetailsView:initTopView()
    if not self._data then return end

    local icon = UI.Image:create()
    icon:init(self._data.resName)
    icon:leftUp(40,57)
    self._bg:addChild(icon)

    local nameText = UI.Text:create()
    nameText:init(LanguageManager:getInstance():getLocalString(self._data.name), UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=181,g=175,b=169})
    nameText:leftUp(184,64)
    self._bg:addChild(nameText)

    local levelText = UI.Text:create()
    levelText:init(UI.TEXT_228404 .. mvc.souvenirModel:getLevelStrBySouvenirID(self._data.ID), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
    levelText:leftUp(168,112)
    self._bg:addChild(levelText)
    self._levelText = levelText

    local todayDate = os.date("!*t", self._data.getTime)

    local getTimeText = UI.Text:create()
    getTimeText:init(UI.TEXT_228405 .. todayDate.year .. "." .. todayDate.month .. "." .. todayDate.day, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
    getTimeText:leftUp(168,141)
    self._bg:addChild(getTimeText)


    local rightUpLayout = UI.Layout:create()
    rightUpLayout:init()
    rightUpLayout:rightUp(22,10)
    self._bg:addChild(rightUpLayout,999)
    self._rightUpLayout = rightUpLayout

    local upgradeCostStr = self._data.upgradeCost
    if upgradeCostStr and upgradeCostStr ~= "" then
        local upgradeCost = string.split(upgradeCostStr, ",")
        if #upgradeCost > 0 then
            local goodsID = tonumber(upgradeCost[1])
            local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsID, true)

            local haveGoodsNumberText = UI.Text:create()
            haveGoodsNumberText:init(tostring(goodNumber), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
            haveGoodsNumberText:floatRight(3)
            rightUpLayout:addComponent(haveGoodsNumberText)
            self._haveGoodsNumberText = haveGoodsNumberText

            local goodsData = GoodsDataManager:createLocalGoodsData(goodsID)
            local haveGoodsNumberIcon = UI.Image:create()
            haveGoodsNumberIcon:init(goodsData.miniIcon)
            haveGoodsNumberIcon:floatRight(3)
            rightUpLayout:addComponent(haveGoodsNumberIcon)
            self._haveGoodsNumberIcon = haveGoodsNumberIcon
        end
    end

    local effectCost = self._data.effectCost
    if effectCost and effectCost ~= "" then
        local effectCostStr = string.split(effectCost, ";")
        if #effectCostStr > 0 then
            local effectCostStr2 = string.split(effectCostStr[1], ",")
            if #effectCostStr2 > 0 then
                local goodsID = tonumber(effectCostStr2[1])
                local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsID, true)

                local haveGoodsNumberText2 = UI.Text:create()
                haveGoodsNumberText2:init(tostring(goodNumber), UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
                if self._haveGoodsNumberIcon then
                    haveGoodsNumberText2:floatRight(20)
                else
                    haveGoodsNumberText2:floatRight(3)
                end
                rightUpLayout:addComponent(haveGoodsNumberText2)
                self._haveGoodsNumberText2 = haveGoodsNumberText2

                local goodsData = GoodsDataManager:createLocalGoodsData(goodsID)
                local haveGoodsNumberIcon2 = UI.Image:create()
                haveGoodsNumberIcon2:init(goodsData.miniIcon)
                haveGoodsNumberIcon2:floatRight(3)
                rightUpLayout:addComponent(haveGoodsNumberIcon2)
                self._haveGoodsNumberIcon2 = haveGoodsNumberIcon2
            end
        end

    end

    -- local souvenirEffect1Time = tostring(ConfigManager:getGeneralForKey("souvenirEffect1Time"))

end

function SouvenirDetailsView:initCenterView()
    if not self._data then return end

    local activeTitleBg = UI.Image:create()
    activeTitleBg:init("ui_souvenir_title.png")
    activeTitleBg:leftBottom(20,315)
    self._bg:addChild(activeTitleBg)

    local activeTitleText = UI.Text:create()
    activeTitleText:init(UI.TEXT_228406, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=154,g=154,b=154})
    activeTitleText:centerLeft(8)
    activeTitleBg:addChild(activeTitleText)

    local passiveTitleBg = UI.Image:create()
    passiveTitleBg:init("ui_souvenir_title.png")
    passiveTitleBg:leftBottom(20,185)
    self._bg:addChild(passiveTitleBg)
    self._passiveTitleBg = passiveTitleBg

    local passiveTitleText = UI.Text:create()
    passiveTitleText:init(UI.TEXT_228407, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=154,g=154,b=154})
    passiveTitleText:centerLeft(8)
    passiveTitleBg:addChild(passiveTitleText)

    local passiveContentBg = UI.Image:create()
    passiveContentBg:init("ui_souvenir_list.png")
    passiveContentBg:leftBottom(20,96)
    self._bg:addChild(passiveContentBg)
    self._passiveContentBg = passiveContentBg

    local localPassiveAttrDes = UI.Text:create()
    localPassiveAttrDes:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
    localPassiveAttrDes:leftBottom(10,48)
    passiveContentBg:addChild(localPassiveAttrDes)
    self._localPassiveAttrDes = localPassiveAttrDes

    local localPassiveNextLevelAttrDes = UI.Text:create()
    localPassiveNextLevelAttrDes:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
    localPassiveNextLevelAttrDes:leftBottom(10,6)
    passiveContentBg:addChild(localPassiveNextLevelAttrDes)
    self._localPassiveNextLevelAttrDes = localPassiveNextLevelAttrDes

    local localPassiveNextDes = UI.Text:create()
    localPassiveNextDes:init(UI.TEXT_228408, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
    localPassiveNextDes:rightBottom(10,6)
    passiveContentBg:addChild(localPassiveNextDes)
    self._localPassiveNextDes = localPassiveNextDes

    local activeAttrBg = UI.Image:create()
    activeAttrBg:init("ui_souvenir_list.png")
    activeAttrBg:leftBottom(20,227)
    self._bg:addChild(activeAttrBg)

    local tableView = UI.TableView.new({}, 488, 80);
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    tableView:leftBottom(0, 0)
    tableView:setDelegate();
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    tableView:setBounceable(true);
    tableView:init();
    self._tableView = tableView

    tableView:onUpdateCellSize(function (table,idx)
        local index = idx + 1
        local desStr = ""
        if index == 1 then
            desStr = LanguageManager:getInstance():getLocalString(self._data.effectDes)
        else
            local souvenirAttrId = self._data.ID * 1000 + self._data.level + 1
            local profileSouvenirAttrData = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId)
            if profileSouvenirAttrData then
                desStr = LanguageManager:getInstance():getLocalString(profileSouvenirAttrData.effectDes)
            end
        end

        
        if desStr ~= "" then
            local desText = UI.Text:create()
            desText:init(desStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
            desText:setDimensions(380,0)

            return 488, desText:getContentSize().height + 10
        end

        return 488, 40;
    end);

    tableView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createCell(index)
            end,
            function(e)
                printError("------------------------SouvenirView:tableCellAtIndex-----------------error")
            end, 1)
        else
            if cell and not tolua.isnull(cell) then
                local desCell = cell:getChildByName("desCell")
                if desCell and tolua.isnull(desCell) and desCell.dtor then
                    desCell:dtor()
                end

                cell:removeFromParent(true)
                cell = nil
            end
            cell = self:createCell(index)
        end

        return cell
    end);

    tableView:onUpdateCellNumbers(function ()
        local souvenirAttrId = self._data.ID * 1000 + self._data.level + 1
        local profileSouvenirAttrData = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId)
        if profileSouvenirAttrData then
            return 2
        end
        return 1
    end);

    activeAttrBg:addChild(tableView);

end

function SouvenirDetailsView:createCell(index)
    local cell = cc.TableViewCell:new()

    local layout = UI.Layout:create();
    layout:init()
    layout:center()
    layout:setName("desCell")
    cell:addChild(layout)
    
    local desStr = ""
    if index == 1 then
        desStr = LanguageManager:getInstance():getLocalString(self._data.effectDes)
    else
        local souvenirAttrId = self._data.ID * 1000 + self._data.level + 1
        local profileSouvenirAttrData = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId)
        if profileSouvenirAttrData then
            desStr = LanguageManager:getInstance():getLocalString(profileSouvenirAttrData.effectDes)
        end
    end

    
    if desStr ~= "" then
        local desText = UI.Text:create()
        desText:init(desStr, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
        desText:setDimensions(380,0)
        desText:leftUp(10,6)
        desText:setTextVerticalCenterAndHLeft()

        cell:setContentSize(cc.size(488, desText:getContentSize().height + 10))
        layout:setSize(488, desText:getContentSize().height + 10)
        layout:addChild(desText)

        if index == 2 then
            local nextDes = UI.Text:create()
            nextDes:init(UI.TEXT_228408, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=41,g=41,b=45})
            nextDes:rightUp(10,6)
            layout:addChild(nextDes)
        end
    end    

    return cell
end

function SouvenirDetailsView:initBottomView()
    local activeBtn = UI.Button:create()
    activeBtn:init("ui_btn_yellow2_0.png","ui_btn_yellow2_0.png","ui_btn_yellow2_0.png");
    activeBtn:centerBottom(16,-110)
    activeBtn:setText(UI.TEXT_228409)
    activeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    activeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        if self._data.isActivity then
            --取消激活
            local tip = UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_228414, function()
                Net.NetPlaySystem:requestSouvenirCancelActiviteMessage(self._data.ID)
            end, function()
            end)
        else
            mvc.openPanel("Souvenir", "SouvenirActiveTips", self._data)
        end
    end)
    self._bg:addChild(activeBtn)
    self._activeBtn = activeBtn

    local upgradeBtn = UI.Button:create()
    upgradeBtn:init("ui_btn_yellow2_0.png","ui_btn_yellow2_0.png","ui_btn_yellow2_0.png");
    upgradeBtn:centerBottom(16,110)
    upgradeBtn:setText(UI.TEXT_228410)
    upgradeBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    upgradeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
        --升级
        local souvenirAttrId = self._data.ID * 1000 + self._data.level
        local profileSouvenirAttrData = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId)
        if profileSouvenirAttrData then
            local upgradeCostStr = profileSouvenirAttrData.upgradeCost
            local upgradeCost = string.split(upgradeCostStr, ",")
            if #upgradeCost > 1 then
                local needNum = tonumber(upgradeCost[2])
                local goodsID = tonumber(upgradeCost[1])

                local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsID, true)
                if goodNumber < needNum then
                    local goodsName = ""
                    local goodsData = GoodsDataManager:createLocalGoodsData(goodsID)
                    if goodsData then
                        goodsName = goodsData:getName()
                    end
                    
                    UI.ScrollBar:createByText(string.format(UI.TEXT_228418,goodsName))
                else
                    --发升级消息
                    Net.NetPlaySystem:requestSouvenirLevelUpMessage(self._data.ID)
                end
            end
        end
    end)
    self._bg:addChild(upgradeBtn)
    self._upgradeBtn = upgradeBtn

    local souvenirAttrId = self._data.ID * 1000 + self._data.level + 1
    local profileSouvenirAttrData = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId)
    local upgradeCostStr = self._data.upgradeCost
    if profileSouvenirAttrData and upgradeCostStr and upgradeCostStr ~= "" then
        local upgradeCost = string.split(upgradeCostStr, ",")
        local goodsID = tonumber(upgradeCost[1])
        local needNum = tonumber(upgradeCost[2])
        -- local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsID, true)

        local upgradeLayout = UI.Layout:create()
        upgradeLayout:init()
        upgradeLayout:center(0,-38)
        upgradeBtn:addChild(upgradeLayout,999)
        self._upgradeLayout = upgradeLayout

        local hfDesText = UI.Text:create()
        hfDesText:init(UI.TEXT_228411, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        hfDesText:floatLeft(3)
        upgradeLayout:addComponent(hfDesText)
        self._hfDesText = hfDesText

        local goodsData = GoodsDataManager:createLocalGoodsData(goodsID)
        local upgradeIcon = UI.Image:create()
        upgradeIcon:init(goodsData.miniIcon)
        upgradeIcon:floatLeft(3)
        upgradeLayout:addComponent(upgradeIcon)
        self._upgradeIcon = upgradeIcon

        local needNumText = UI.Text:create()
        needNumText:init(tostring(needNum), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
        needNumText:floatLeft(3)
        upgradeLayout:addComponent(needNumText)
        self._needNumText = needNumText
        
    end

    


end

function SouvenirDetailsView:updateContent(data)
    if data ~= nil then
        self._data = data
    end
    if not self._data then return end

    if self._levelText then
        self._levelText:setText(UI.TEXT_228404 .. mvc.souvenirModel:getLevelStrBySouvenirID(self._data.ID))
    end

    if self._data.attrDes == 0 then
        if self._passiveTitleBg then
            self._passiveTitleBg:hide()
        end
        if self._passiveContentBg then
            self._passiveContentBg:hide()
        end
    else
        if self._passiveTitleBg then
            self._passiveTitleBg:show()
        end
        if self._passiveContentBg then
            self._passiveContentBg:show()
        end
        if self._localPassiveAttrDes then
            self._localPassiveAttrDes:setText(LanguageManager:getInstance():getLocalString(self._data.attrDes))
        end
    end

    local souvenirAttrId = self._data.ID * 1000 + self._data.level + 1
    local profileSouvenirAttrData = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId)
    if profileSouvenirAttrData then
        if self._localPassiveNextLevelAttrDes then
            self._localPassiveNextLevelAttrDes:show()
            self._localPassiveNextLevelAttrDes:setText(LanguageManager:getInstance():getLocalString(profileSouvenirAttrData.attrDes))
        end
        if self._localPassiveNextDes then
            self._localPassiveNextDes:show()
        end

        if self._upgradeBtn then
            self._upgradeBtn:show()
            self._upgradeBtn:centerBottom(16,110)
        end

        if self._activeBtn then
            self._activeBtn:centerBottom(16,-110)
        end
    else
        if self._localPassiveNextLevelAttrDes then
            self._localPassiveNextLevelAttrDes:hide()
        end
        if self._localPassiveNextDes then
            self._localPassiveNextDes:hide()
        end

        if self._upgradeBtn then
            self._upgradeBtn:hide()
        end

        if self._activeBtn then
            self._activeBtn:centerBottom(16,0)
        end
    end

    if self._data.isActivity then
        if self._activeBtn then
            self._activeBtn:setText(UI.TEXT_228412)
        end
    else
        if self._activeBtn then
            self._activeBtn:setText(UI.TEXT_228409)
        end
    end

    if self._tableView then
        self._tableView:reloadData()
    end

    if self._rightUpLayout then
        local layoutWidth = 0
        local upgradeCostStr = self._data.upgradeCost
        local upgradeCost = string.split(upgradeCostStr, ",")
        if #upgradeCost > 1 then
            local goodsID = tonumber(upgradeCost[1])
            local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsID, true)

            if self._haveGoodsNumberText then
                self._haveGoodsNumberText:setText(tostring(goodNumber))

                layoutWidth = layoutWidth + self._haveGoodsNumberText:getContentSize().width + 3 + self._haveGoodsNumberIcon:getContentSize().width + 3

            end
        end

        local effectCost = self._data.effectCost
        local effectCostStr = string.split(effectCost, ";")
        if #effectCostStr > 0 then
            local effectCostStr2 = string.split(effectCostStr[1], ",")
            if #effectCostStr2 > 1 then
                local goodsID = tonumber(effectCostStr2[1])
                local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsID, true)
                
                if self._haveGoodsNumberText2 then
                    self._haveGoodsNumberText2:setText(tostring(goodNumber))
    
                    layoutWidth = layoutWidth + self._haveGoodsNumberText2:getContentSize().width + 3 + self._haveGoodsNumberIcon2:getContentSize().width + 3
                    
                end
                if self._haveGoodsNumberText then
                    layoutWidth = layoutWidth + 27
                end
            end
        end

        self._rightUpLayout:setSize(layoutWidth, 25)
    end

    local souvenirAttrId = self._data.ID * 1000 + self._data.level
    local profileSouvenirAttrData = ConfigManager:getSouvenirAttrDataByID(souvenirAttrId)

    if self._upgradeLayout and profileSouvenirAttrData then
        local upgradeCostStr = profileSouvenirAttrData.upgradeCost
        local upgradeCost = string.split(upgradeCostStr, ",")
        if #upgradeCost > 1 then
            local needNum = tonumber(upgradeCost[2])
            local goodsID = tonumber(upgradeCost[1])

            self._needNumText:setText(tostring(needNum))

            local goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(goodsID, true)
            if goodNumber < needNum then
                self._needNumText:setFontColor(UI.FONT_COLOR_RED)
            else
                self._needNumText:setFontColor(UI.FONT_COLOR_41_41_45)
            end

            local layoutWidth = self._needNumText:getContentSize().width + 3 + self._upgradeIcon:getContentSize().width + 3 + self._hfDesText:getContentSize().width + 3
            self._upgradeLayout:setSize(layoutWidth, 25)
        end
    end

end

function SouvenirDetailsView:bindModel()

end


function SouvenirDetailsView:unbindModel()

end





return SouvenirDetailsView












