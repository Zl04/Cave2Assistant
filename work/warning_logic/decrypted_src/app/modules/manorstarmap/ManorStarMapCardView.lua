------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/06/27
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ManorStarMapCardView = class("ManorStarMapCardView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")
local GameInManorManager = require "app.game.GameInManorManager"

-- 资源
local COM_RES_LIST = {
    "ui_town_home_starmap.plist",
    "ui_common_information.plist",
}

local COM_WIDTH = 1006
local COM_HEIGHT = 583

local MONEY_ICON = "symbol_material_navigationgold.png"
local MATERIAL_ICON = "symbol_material_bookmark.png" --@@@@ 先用金币代替
local StarMapAttributeType = PublicDefine.StarMapAttributeType

function ManorStarMapCardView:ctor(mosaicType)
    ManorStarMapCardView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self._pageTable = {}
    self._cardViewTable = {}
    self._attrTextTable = {}
    self._selectPage = 0
    self._tableView = nil
    self._mosaicType = mosaicType
end

function ManorStarMapCardView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.manorstarmap", "ManorStarMap", false)
    ManorStarMapCardView.super.init(self, ... )

    
end

function ManorStarMapCardView:dtor()
    ManorStarMapCardView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.manorstarmap.ManorStarMapCardView")
end


function ManorStarMapCardView:onInitView()
    self:center()
    
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self._leftLayout = UI.Layout:create()
    self._leftLayout:init()
    self._leftLayout:setSize(473, 504)
    self._leftLayout:leftBottom(55,47)
    contentLayout:addChild(self._leftLayout)

    self._starMapLayouy = UI.Layout:create()
    self._starMapLayouy:init()
    self._starMapLayouy:setSize(473, 263)
    self._starMapLayouy:leftBottom(0,192)
    self._leftLayout:addChild(self._starMapLayouy,10)

    self._cardLayout = UI.Layout:create()
    self._cardLayout:init()
    self._cardLayout:setSize(473, 192)
    self._cardLayout:leftBottom(5,0)
    self._leftLayout:addChild(self._cardLayout)

    local starMapBg  = UI.Image:create()
    starMapBg:init("ui_starmap_bg.png")
    starMapBg:leftBottom(0,192)
    self._leftLayout:addChild(starMapBg)

    local btnBg = UI.Image:create()
    btnBg:init("ui_starmap_label_bg.png")
    btnBg:leftUp(5,0)
    self._leftLayout:addChild(btnBg)

    self:updatePageView(1)
    self:createPageBtn()


    self._rightLayout = UI.Layout:create()
    self._rightLayout:init()
    self._rightLayout:setSize(420, 514)
    self._rightLayout:leftBottom(55 + 472,47)
    contentLayout:addChild(self._rightLayout)

    self:createTopCurrency()

    self:createAttributesView()
    self:refreshAttributesView()

    self:createBuildStarMapView()
    self:refreshBuildStarMapView()
end

function ManorStarMapCardView:createBuildStarMapView()
    self._buildLayout = UI.Layout:create()
    self._buildLayout:init()
    self._buildLayout:setSize(420, 250)
    self._buildLayout:leftBottom(0,0)
    self._rightLayout:addChild(self._buildLayout)

    local bg = UI.Image:create()
    bg:init("ui_starmap_banner_bg_4.png")
    bg:leftBottom(0,0)
    self._buildLayout:addChild(bg)

    local leftText = UI.Text:create()
    leftText:init(UI.TEXT_222614, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    leftText:leftUp(20,12)
    bg:addChild(leftText)

    local leftText2 = UI.Text:create()
    leftText2:init(UI.TEXT_222615, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    leftText2:leftUp(20,12 + 38)
    bg:addChild(leftText2)

    self._unlockDesText = UI.Text:create()
    self._unlockDesText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    self._unlockDesText:leftUp(120,12)
    self._unlockDesText:setWidth(270)
    bg:addChild(self._unlockDesText)

    self._nextDesText = UI.Text:create()
    self._nextDesText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    self._nextDesText:leftUp(120,12 + 38)
    self._nextDesText:setWidth(270)
    bg:addChild(self._nextDesText)

    local progressTimerBg = UI.Image:create()
    progressTimerBg:init("ui_starmap_progress_bg.png")
    progressTimerBg:leftBottom(46,99.5)
    bg:addChild(progressTimerBg)

    local centerBg = cc.Sprite:createWithSpriteFrameName("ui_starmap_progress.png")
    self._ptimer = cc.ProgressTimer:create(centerBg)
    self._ptimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    self._ptimer:setMidpoint(cc.p(0, 0))
    self._ptimer:setBarChangeRate(cc.p(1, 0))
    self._ptimer:setPercentage(0)
    self._ptimer:setPosition(46,99.5)
    self._ptimer:setAnchorPoint(0,0)
    bg:addChild(self._ptimer)

    self._expMaxSp = UI.Animation:create()
    self._expMaxSp:init("effect_ui_starmap_levelup_experience.json", "effect_ui_starmap_levelup_experience.atlas", 1);
    self._expMaxSp:centerBottom(107,-25)
    self._expMaxSp:setAnimation("idle", true)
    bg:addChild(self._expMaxSp,11)
    self._expMaxSp:hide()

    self._buildLevelText = UI.Text:create()
    self._buildLevelText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r=191,g=148,b=67})
    self._buildLevelText:leftBottom(6.5,94.5)
    bg:addChild(self._buildLevelText)


-------------------------------------------经验满,或者登记达到上限后需要隐藏的layout-------------------------------------
    self._undoneLayout = UI.Layout:create()
    self._undoneLayout:init()
    self._undoneLayout:setSize(bg:getContentSize().width, bg:getContentSize().height)
    self._undoneLayout:leftBottom(0,0)
    bg:addChild(self._undoneLayout)

    -- self._buildLevelText = UI.Text:create()
    -- self._buildLevelText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, {r=191,g=148,b=67})
    -- self._buildLevelText:leftBottom(6.5,94.5)
    -- self._undoneLayout:addChild(self._buildLevelText)

    self._expText = UI.Text:create()
    self._expText:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    self._expText:centerLeft(328,9.5)
    self._expText:setWidth(95)
    self._undoneLayout:addChild(self._expText)

    --航海币培养按钮
    local moneyBtn = UI.Button:create()
    moneyBtn:init(
        "ui_starmap_btn.png",
        "ui_starmap_btn.png",
        "ui_starmap_btn.png"
    )
    moneyBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.moneyUpgrade)
    moneyBtn:centerBottom(9,-100)
    self._undoneLayout:addChild(moneyBtn)

    local moneyBtnLayout2 = UI.Layout:create()
    moneyBtnLayout2:init()
    moneyBtnLayout2:enableAutoWidth()
    moneyBtnLayout2:center()
    moneyBtn:addChild(moneyBtnLayout2,1002)

    local moneyIcon = UI.Image:create()
    moneyIcon:init(MONEY_ICON)
    moneyIcon:floatLeft(0)
    moneyBtnLayout2:addComponent(moneyIcon)

    self._moneyText = UI.Text:create()
    self._moneyText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    self._moneyText:floatLeft(5)
    moneyBtnLayout2:addComponent(self._moneyText)


    local moneyBtnLayout = UI.Layout:create()
    moneyBtnLayout:init()
    moneyBtnLayout:enableAutoWidth()
    moneyBtnLayout:centerBottom(60)
    moneyBtn:addChild(moneyBtnLayout)

    self._moneyUpgradeDesText = UI.Text:create()
    self._moneyUpgradeDesText:init(UI.TEXT_222616, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    self._moneyUpgradeDesText:floatLeft(0)
    moneyBtnLayout:addComponent(self._moneyUpgradeDesText)

    self._moneyUpgradeText = UI.Text:create()
    self._moneyUpgradeText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    self._moneyUpgradeText:floatLeft(5)
    moneyBtnLayout:addComponent(self._moneyUpgradeText)

    --航海钻石培养按钮
    local diamondBtn = UI.Button:create()
    diamondBtn:init(
        "ui_starmap_btn.png",
        "ui_starmap_btn.png",
        "ui_starmap_btn.png"
    )
    diamondBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.diamondUpgrade)
    diamondBtn:centerBottom(9,100)
    self._undoneLayout:addChild(diamondBtn)

    local diamondBtnLayout2 = UI.Layout:create()
    diamondBtnLayout2:init()
    diamondBtnLayout2:enableAutoWidth()
    diamondBtnLayout2:center()
    diamondBtn:addChild(diamondBtnLayout2,1002)

    local diamondIcon = UI.Image:create()
    diamondIcon:init(MATERIAL_ICON)
    diamondIcon:floatLeft(0)
    diamondBtnLayout2:addComponent(diamondIcon)

    local diamondBtnLayout = UI.Layout:create()
    diamondBtnLayout:init()
    diamondBtnLayout:enableAutoWidth()
    diamondBtnLayout:centerBottom(60)
    diamondBtn:addChild(diamondBtnLayout)

    local diamondUpgradeDesText = UI.Text:create()
    diamondUpgradeDesText:init(UI.TEXT_222617, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    diamondUpgradeDesText:floatLeft(0)
    diamondBtnLayout:addComponent(diamondUpgradeDesText)
-------------------------------------------经验满,或者登记达到上限后需要隐藏的layout-------------------------------------




-------------------------------------------经验满,或者登记达到上限后需要显示的layout-------------------------------------
    self._completeLayout = UI.Layout:create()
    self._completeLayout:init()
    self._completeLayout:setSize(bg:getContentSize().width, bg:getContentSize().height)
    self._completeLayout:leftBottom(0,0)
    bg:addChild(self._completeLayout)

    local maxImage = UI.Image:create()
    maxImage:init("ui_information_max_2.png")
    maxImage:centerLeft(336,9.5)
    self._completeLayout:addChild(maxImage)

    self._upBtn = UI.Button:create()
    self._upBtn:init(
        "ui_starmap_btn.png",
        "ui_starmap_btn.png",
        "ui_starmap_btn.png"
    )
    self._upBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.upStarMapLevel)
    self._upBtn:setText(UI.TEXT_1212390)
    self._upBtn:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    self._upBtn:centerBottom(9,0)
    self._completeLayout:addChild(self._upBtn)

    self._maxDesLayout = UI.Layout:create()
    self._maxDesLayout:init()
    self._maxDesLayout:enableAutoWidth()
    self._maxDesLayout:centerBottom(68)
    self._completeLayout:addChild(self._maxDesLayout)

    local max = UI.Image:create()
    max:init("ui_information_reminder.png")
    max:floatLeft(0)
    self._maxDesLayout:addComponent(max)

    local maxDesText = UI.Text:create()
    maxDesText:init(UI.TEXT_222620,UI.FONT_STANDARD,UI.FONT_SIZE_18PX,UI.FONT_COLOR_80_5_5)
    maxDesText:floatLeft(9)
    self._maxDesLayout:addComponent(maxDesText)

-------------------------------------------经验满,或者登记达到上限后需要显示的layout-------------------------------------

end

function ManorStarMapCardView:upStarMapLevel()

    local canUp = false

    local buildData = GameInManorManager:getInstance():getBuildDataByBuildId(PublicDefine.ManorBuildID.BuildID_StarMap)
    local buildLevel = buildData and buildData.level or 1
    local deskConfig = ConfigManager:getAllDeskDataByID(buildLevel)

    local preNPCID = deskConfig.preNPCID
    local preNPCLV = deskConfig.preNPCLV

    if preNPCID == "" then
        canUp = true
    else
        canUp = true
        local npcIds = string.split(preNPCID,",")
        local npcLvs = string.split(preNPCLV,",")

        for k,v in pairs(npcIds) do
            local bData = GameInManorManager:getInstance():getBuildDataByBuildId(tonumber(v))
            local bLevel = bData and bData.level or 1
            local needLevel = tonumber(npcLvs[k])

            if needLevel > bLevel then
                canUp = false
                break
            end
        end

    end

    if canUp then
        Net.NetManorSystem:reqStarAtlasUpgrade()
    else
        UI.ScrollBar:createByText(UI.TEXT_222621)
    end
end

function ManorStarMapCardView:moneyUpgrade()
    local buildData = GameInManorManager:getInstance():getBuildDataByBuildId(PublicDefine.ManorBuildID.BuildID_StarMap)
    local buildLevel = buildData and buildData.level or 1
    local deskConfig = ConfigManager:getAllDeskDataByID(buildLevel)

    if deskConfig then
        local currencyTrain = string.split(deskConfig.currencyTrain,",")
        local needNumber = tonumber(currencyTrain[2])
        local sailGold = RoleDataManager:getMaster():getSailGold()

        if sailGold < needNumber then
            UI.ScrollBar:createByText(UI.TEXT_222618)
        else
            Net.NetManorSystem:reqStarAtlasCulture(1)
        end
    end
end

function ManorStarMapCardView:diamondUpgrade()
    local sailDiamond = RoleDataManager:getMaster():getSailDiamond()
    local useNumber = sailDiamond > 999 and 999 or sailDiamond
    if sailDiamond < 1 then
        UI.ScrollBar:createByText(UI.TEXT_222619)
    else
        UI.TipsLayer:onBuyAmount(function(number)   -- 确认回调
            Net.NetManorSystem:reqStarAtlasCulture(2,number)
        end, nil, 1, PublicDefine.GOODS_COST_TYPE.SAIL_DIAMOND, useNumber, false)
    end
end

function ManorStarMapCardView:refreshBuildStarMapView(addExp)

    local buildData = GameInManorManager:getInstance():getBuildDataByBuildId(PublicDefine.ManorBuildID.BuildID_StarMap)
    local buildLevel = buildData and buildData.level or 1
    local curExp = buildData and buildData.exp or 0
    local cultureCountByGold = mvc.manorStarMapModel:getCultureCountByGold()
    local deskConfig = ConfigManager:getAllDeskDataByID(buildLevel)

    if deskConfig then
        local unlockDesStr = languageManagerInstance:getLocalString(deskConfig.unlockConditions)
        local nextDesDesStr = languageManagerInstance:getLocalString(deskConfig.unlockContent)
        
        if self._unlockDesText then
            self._unlockDesText:setText(unlockDesStr)
        end
        if self._nextDesText then
            self._nextDesText:setText(nextDesDesStr)
        end

        if self._buildLevelText then
            self._buildLevelText:setText("Lv." .. buildLevel)
        end

        local upExp = deskConfig.expToNextLevel
        local isMaxLevel = upExp <= 0
        local isMaxExp = curExp >= upExp

        local maxStr = tostring(upExp)
        local curStr = tostring(curExp)
        if upExp > 99999 then maxStr = AvalonUtil:getSimpleNumber(upExp, 5) end
        if curExp > 99999 then curStr = AvalonUtil:getSimpleNumber(curExp, 5) end
        if self._expText then
            self._expText:setText(curStr .. "/" .. maxStr)
        end


        if self._ptimer then
            local percentage = curExp / upExp * 100
            self._ptimer:setPercentage(percentage)
        end

        if self._moneyUpgradeText then
            local dailyCurrencyTime = deskConfig.dailyCurrencyTime
            self._moneyUpgradeText:setText("(" .. dailyCurrencyTime - cultureCountByGold .. "/" .. dailyCurrencyTime .. ")")

            if cultureCountByGold >= dailyCurrencyTime then
                self._moneyUpgradeText:setText("")
                self._moneyUpgradeDesText:setText(UI.TEXT_1212400)
                self._moneyUpgradeDesText:setFontColor(UI.FONT_COLOR_80_5_5)
                self._moneyUpgradeDesText:setFontSize(UI.FONT_SIZE_14PX)
            else
                self._moneyUpgradeText:setFontColor({r=26,g=77,b=67})

                self._moneyUpgradeDesText:setText(UI.TEXT_222616)
                self._moneyUpgradeDesText:setFontColor(UI.FONT_COLOR_50_50_44)
                self._moneyUpgradeDesText:setFontSize(UI.FONT_SIZE_18PX)
            end
        end

        if self._moneyText then
            local currencyTrain = string.split(deskConfig.currencyTrain,",")
            local needNumber = tonumber(currencyTrain[2])
            -- getSailDiamond()
            local sailGold = RoleDataManager:getMaster():getSailGold()
            local moneyColor = UI.FONT_COLOR_50_50_44
            if sailGold < needNumber then
                moneyColor = UI.FONT_COLOR_NOT_ENOUGH
            end

            self._moneyText:setFontColor(moneyColor)
            self._moneyText:setText(currencyTrain[2])
        end


        if isMaxLevel then
            --满级
            self._undoneLayout:hide()
            self._completeLayout:show()
            self._upBtn:hide()
            self._maxDesLayout:show()
            self._expMaxSp:show()
        else
            if isMaxExp then
                --经验满了
                self._undoneLayout:hide()
                self._completeLayout:show()
                self._upBtn:show()
                self._maxDesLayout:hide()
                print("1111112222 ")
                self._expMaxSp:show()
            else
                self._undoneLayout:show()
                self._completeLayout:hide()
                self._expMaxSp:hide()
            end
        end

    end

    if addExp ~= nil and addExp > 0 then
        self:showAddExp(addExp)
    end

end

function ManorStarMapCardView:refreshAttributesView()
    local attrData = mvc.manorStarMapModel:getAllCardAttributes()
    for k,v in pairs(self._attrTextTable) do
        if attrData[k] then 

            local nowValue = ToolsUtil:calculationAttrShowValue(attrData[k].attrType,attrData[k].value)

            if v and v.setText then
                v:setText("+" .. nowValue)
            end
        end
    end
end

function ManorStarMapCardView:createAttributesView()
    self._attributesLayout = UI.Layout:create()
    self._attributesLayout:init()
    self._attributesLayout:setSize(420, 204)
    self._attributesLayout:leftUp(0,64.5)
    self._rightLayout:addChild(self._attributesLayout)

    local attriBg = UI.Image:create()
    attriBg:init("ui_starmap_banner_bg_2.png")
    attriBg:leftBottom(0,0)
    self._attributesLayout:addChild(attriBg)

    local bannerUp = UI.Image:create()
    bannerUp:init("ui_starmap_banner_up.png")
    bannerUp:leftBottom(0,10)
    self._attributesLayout:addChild(bannerUp,100)

    local attrData = mvc.manorStarMapModel:getAllCardAttributes()
    self._attrTextTable = {}

    local tableView = UI.TableView:create({}, 420, 204 - 22)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(0,22)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        return 420,26
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

                local attrLayout = UI.Layout:create()
                attrLayout:init()
                attrLayout:setSize(420,26)
                attrLayout:leftBottom(0,0)

                local attrBg = UI.Image:create()
                attrBg:init("ui_starmap_banner_bg_3.png")
                attrBg:leftBottom(0,0)
                attrLayout:addChild(attrBg)

                if luaIdx%2 ~= 0 then
                    attrBg:setOpacity(0)
                end

                attrData = mvc.manorStarMapModel:getAllCardAttributes()

                local attrIndex = luaIdx*2 - 1
                local aData = attrData[attrIndex]
                local aData2 = attrData[attrIndex + 1]

                if aData then
                    local attrIcon = UI.Image:create()
                    attrIcon:init(aData.icon)
                    attrIcon:centerLeft(8)
                    attrLayout:addChild(attrIcon)

                    local desText = UI.Text:create()
                    desText:init(aData.attrName, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
                    desText:centerLeft(36)
                    attrLayout:addChild(desText)

                    local attrText = UI.Text:create()
                    attrText:init("+" .. aData.value, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r=26,g=77,b=67})
                    attrText:centerRight(219)
                    attrLayout:addChild(attrText)

                    self._attrTextTable[attrIndex] = attrText
                end

                if aData2 then
                    local attrIcon = UI.Image:create()
                    attrIcon:init(aData2.icon)
                    attrIcon:centerLeft(220)
                    attrLayout:addChild(attrIcon)

                    local desText = UI.Text:create()
                    desText:init(aData2.attrName, UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
                    desText:centerLeft(247)
                    attrLayout:addChild(desText)

                    local attrText = UI.Text:create()
                    attrText:init("+" .. aData2.value, UI.FONT_BOLD, UI.FONT_SIZE_16PX, {r=26,g=77,b=67})
                    attrText:centerRight(8)
                    attrLayout:addChild(attrText)

                    self._attrTextTable[attrIndex + 1] = attrText
                end


                cell:addChild(attrLayout)
            end, 
            function(e) 
                printError("------------------------refreshCardLayout-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onUpdateCellNumbers(function()
        return #attrData / 2
    end)
    attriBg:addChild(tableView)
    tableView:reloadData()


end

function ManorStarMapCardView:createTopCurrency()
    local momeyImage = UI.Image:create()
    momeyImage:init(MONEY_ICON)
    momeyImage:leftUp(34, -2)
    self._rightLayout:addChild(momeyImage)
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
    self._rightLayout:addChild(sailImage)
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
    self._rightLayout:addChild(lineImage)

    local attrTitleText = UI.Text:create()
    attrTitleText:init(UI.TEXT_222611, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_50_50_44)
    attrTitleText:leftUp(0, 34.5)
    self._rightLayout:addChild(attrTitleText)
end

function ManorStarMapCardView:updateCurrencyView()
    self._momey:setText(self._momey:numformat(string.format("%s", RoleDataManager:getMaster():getSailGold())))
    self._momey:updateView()
    self._sail:setText(self._sail:numformat(string.format("%s", RoleDataManager:getMaster():getSailDiamond())))
    self._sail:updateView()
end

function ManorStarMapCardView:showAddExp(addExp)
    if self._buildLayout then
        local text = UI.Text:create()
        text:init(string.format("+%d",addExp), UI.FONT_ARIAL, UI.FONT_SIZE_16PX, UI.FONT_COLOR_GREEN)
        text:centerLeft(328,9.5)
        text:hide()
        self._buildLayout:addChild(text)

        local delayTime = 0.1
        Avalon.Scheduler:scheduleUpdateOnce(self, function()
            if(self and not tolua.isnull(self)) then
                if not text or tolua.isnull(text) then
                    return
                end
                text:show()
                text:runAction(cc.Spawn:create(
                    cc.MoveBy:create(0.5,cc.p(0,20)),
                    cc.Sequence:create(cc.DelayTime:create(0.4),
                    cc.FadeOut:create(0.1),cc.RemoveSelf:create())))
            end
        end,delayTime)
    end
end

function ManorStarMapCardView:onCurrencyChangeHandler(data)
    if data then
        self:updateCurrencyView()


        if(self._waitingNum == nil) then
            self._waitingNum = 0
        end

        if self._waitingNum <= 20 then
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

            

            local delayTime = self._waitingNum * 0.2
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

end

function ManorStarMapCardView:createPageBtn()
    for i =1, 6 do
        local pageBtn = UI.Button:create()
        pageBtn:init('ui_starmap_label_01.png', 'ui_starmap_label_01.png', 'ui_starmap_label_01.png')
        pageBtn:leftUp((i - 1) * 70 + 5,0)
        pageBtn:closeClickScale()
        
        pageBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:updatePageView(i)

            for k,v in pairs(self._pageTable) do
                if i == k then
                    v:disable()
                    v:setOpacity(255)
                else
                    v:enable()
                    v:setOpacity(0)
                end
            end

        end)
        self._leftLayout:addChild(pageBtn)
        self._pageTable[i] = pageBtn

        if i == self._selectPage then
            pageBtn:disable()
            pageBtn:setOpacity(255)
        else
            pageBtn:enable()
            pageBtn:setOpacity(0)
        end


        local numberImg = UI.Image:create()
        numberImg:init(string.format("ui_starmap_label_number_%02d.png", i))
        numberImg:leftUp(28 + (i - 1) * 70,5)
        self._leftLayout:addChild(numberImg)

    end
end

function ManorStarMapCardView:updatePageView(selectPage)
    if selectPage == nil or selectPage == self._selectPage then
        return
    end
    self._selectPage = selectPage

    self:refreshStarMapLayout()
    self:refreshCardLayout(true)
end

function ManorStarMapCardView:refreshStarMapLayout(cardId)
    self._starMapLayouy:removeAllChildren()
    --如果传入cardId 表示需要表现镶嵌相关的动画
    local cardDatas = mvc.manorStarMapModel:getCardPageConfigModelByPageId(self._selectPage, self._mosaicType)

    local pConfig = ConfigManager:getAllStarMapData()
    for k,pokedexConfig in pairs(pConfig) do
        local cardNeedLevel = string.split(pokedexConfig.activateLevel, ",")
        local desc = string.split(pokedexConfig.desc, ",")
        local nextLevelDesc = string.split(pokedexConfig.nextLevelDesc, ",")
        local activateStarCardId = string.split(pokedexConfig.activateStarCardId, ",")
        local haveDatas = {}
        local isActivate = false --卡组是否激活

        for k,v in pairs(activateStarCardId) do

            for m,n in pairs(cardDatas) do
                if n.cardId == tonumber(v) then
                    haveDatas[tonumber(v)] = n
                end
            end
        end

        if table.nums(haveDatas) == table.nums(activateStarCardId) then
            isActivate = true
            local page = -1
            for k,v in pairs(haveDatas) do
                if page ~= -1 and page ~= v.CardPage then
                    isActivate = false
                    break
                end

                page = v.CardPage
            end
        end

        -- 星图类型不匹配
        if pokedexConfig.starMapType ~= self._mosaicType then
            isActivate = false
            --break
        end

        if isActivate then
            --播放卡组spine动画
            local spineStr = pokedexConfig.starMapSpine
            local starSp = UI.Animation:create()
            starSp:init(spineStr .. ".json", spineStr .. ".atlas", 1);
            starSp:leftBottom(0,0)
            self._starMapLayouy:addChild(starSp)
            if cardId then
                --先播放 begine  再播放 idle
                starSp:setAnimation("begin", false)
                starSp:addAnimation("idle", true)
            else
                --只播放idle
                starSp:setAnimation("idle", true)
            end
        end
    end

    for k,v in pairs(cardDatas) do
        if v.cardId ~= 0 then
            local cardConfig = ConfigManager:getAllStarCardDataByID(v.cardId)
            local spineStr = "effect_ui_starmap_point"
            local coordinate = cardConfig.coordinate
            local coordTable = string.split(coordinate, ",")
            local pointSp = UI.Animation:create()
            pointSp:init(spineStr .. ".json", spineStr .. ".atlas", 1);
            pointSp:leftBottom(tonumber(coordTable[1]),tonumber(coordTable[2]))
            if cardConfig.type == 1 then
                pointSp._spine:setSkin("star2")
            else
                pointSp._spine:setSkin("star1")
            end
            self._starMapLayouy:addChild(pointSp,11)
            

            if cardId == v.cardId then
                pointSp:setAnimation("begin", false)
                pointSp:addAnimation("idle", true)
            else
                pointSp:setAnimation("idle", true)
            end
        end
    end

end

function ManorStarMapCardView:refreshCardLayout(isPageRef)
    local tableViewPoint = nil
    if self._tableView and not isPageRef then
        tableViewPoint = self._tableView:getContentOffset()
    end

    self._cardLayout:removeAllChildren()

    local tipsBg  = UI.Image:create()
    tipsBg:init("ui_starmap_banner_bg.png")
    tipsBg:leftBottom(0,155)
    self._cardLayout:addChild(tipsBg)

    local titleStr = self._mosaicType == PublicDefine.StarMapMosaicType.MosaicFight and UI.TEXT_227402 or UI.TEXT_227403
    local text = UI.Text:create()
    text:init(titleStr, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r=155,g=155,b=155})
    text:centerLeft(27)
    tipsBg:addChild(text)

    local cardBg  = UI.Image:create()
    cardBg:init("ui_starmap_banner_bg_5.png")
    cardBg:leftBottom(0,0)
    self._cardLayout:addChild(cardBg)

    local cardSlotData = mvc.manorStarMapModel:getCardPageConfigModelByPageId(self._selectPage, self._mosaicType)

    local SCROLL_WIDTH = cardBg:getContentSize().width - 16
    local SCROLL_HEIGHT = 126 -- 145
    
    self._cardViewTable = {}

    self._tableView = UI.TableView:create({}, SCROLL_WIDTH, SCROLL_HEIGHT)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    self._tableView:leftBottom(8, 10)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:setScrollBarEnabled(false)
    self._tableView:setCircleVisible(false)
    self._tableView:onUpdateCellSize(function (tableview, idx)
        return 110,124
    end) 
    self._tableView:onUpdateCells(function (tableview, idx)
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

                local cardView = mvc.manorStarMapCardSlotCellView:create(cardSlotData[luaIdx])
                cardView:init()
                cardView:leftBottom(0,0)
                cell:addChild(cardView)

                self._cardViewTable[luaIdx] = cardView
            end, 
            function(e) 
                printError("------------------------refreshCardLayout-----------------error", e)
            end, 1)
        end

        return cell
    end)

    self._tableView:onUpdateCellNumbers(function()
        return #cardSlotData
    end)

    self._tableView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        local luaIdx = cell:getIdx() + 1

        local cardView = self._cardViewTable[luaIdx]

        if not cardView._isUnlock then
            return
        end

        -- 打开卡槽镶嵌界面
        
        mvc.openPanel("ManorStarMap", "ManorStarMapMosaic", cardView._data)

    end);
    cardBg:addChild(self._tableView)
    self._tableView:reloadData()

    if tableViewPoint then
        self._tableView:setContentOffset(tableViewPoint)
    end

end

function ManorStarMapCardView:updatePageViewByMosaicType(mosaicType)
    self._mosaicType = mosaicType

    self:refreshStarMapLayout()
    self:refreshCardLayout(true)
end

function ManorStarMapCardView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end


function ManorStarMapCardView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end





return ManorStarMapCardView












