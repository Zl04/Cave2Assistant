------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2024/07/15
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local StarPrayIncreaseView = class("StarPrayIncreaseView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 914
local COM_HEIGHT = 534
local MONEY_ICON_ID = 23570001

local btnPosition = {
    cc.p(46, -126),
    cc.p(110, -80),
    cc.p(133, 0),
    cc.p(110, 80),
    cc.p(46, 126),
    cc.p(-46, 126),
    cc.p(-110, 80),
    cc.p(-133, 0),
    cc.p(-110, -80),
    cc.p(-46, -126)
}

function StarPrayIncreaseView:ctor()
    StarPrayIncreaseView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self:center(-45, 30)
    self._isUpgrading = false

    self.runeAnimationList = {}
    self.btnList = {}
end

function StarPrayIncreaseView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.starpray", "StarPray", false)
    StarPrayIncreaseView.super.init(self, ... )
end

function StarPrayIncreaseView:dtor()
    StarPrayIncreaseView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.starpray.StarPrayIncreaseView")
end


function StarPrayIncreaseView:onInitView()

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    self._rightLayout = UI.Layout:create()
    self._rightLayout:init()
    self._rightLayout:setSize(445, 514)
    self._rightLayout:leftBottom(457 + 26,-5)
    contentLayout:addChild(self._rightLayout)

    self:initLeftPanel()
    self:createTopCurrency()
    
    self:createAttributesView()
    self:refreshAttributesView()

    self:createBottomPanel()


    -- 注册点击监听事件
    local listener = cc.EventListenerTouchOneByOne:create()
    self._touchListener = listener
    listener:registerScriptHandler(function()
        self:hideRuneTipsView()
    end, cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(function() end, cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(function() end, cc.Handler.EVENT_TOUCH_ENDED)
    listener:registerScriptHandler(function() end, cc.Handler.EVENT_TOUCH_CANCELLED)
    
    listener:setSwallowTouches(false)
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithFixedPriority(listener,-10)

end

function StarPrayIncreaseView:createBottomPanel()
    local bottomLayout = UI.Layout:create()
    bottomLayout:init()
    bottomLayout:setSize(445, 210)
    bottomLayout:leftBottom(0,0)
    self._rightLayout:addChild(bottomLayout)

    local allConfig = ConfigManager:getAllStarPlateUpgradeData()
    local upgradeDataConfig = {}
    for k,v in ipairs(allConfig) do
        if v.increaseType ~= 0 then
            table.insert(upgradeDataConfig,v)
        end
    end

    local tableView = UI.TableView:create({}, 445, 120)
    self._bottomTableView = tableView
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(0,102)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        return 445,30
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

                local desLayout = UI.Layout:create()
                desLayout:init()
                desLayout:setSize(445,30)
                desLayout:leftBottom(0,0)

                local desBg = UI.Image:create()
                desBg:init("ui_starmarks_strip_02.png")
                desBg:leftBottom(0,0)
                desLayout:addChild(desBg)

                if luaIdx%2 == 0 then
                    desBg:setOpacity(0)
                end

                if upgradeDataConfig[luaIdx] then
                    local desID = upgradeDataConfig[luaIdx].increaseDes

                    local desText = UI.Text:create()
                    desText:init(LanguageManager:getInstance():getLocalString(tonumber(desID)), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
                    desText:centerLeft(8)
                    desLayout:addChild(desText)
                    
                    if mvc.starPrayModel.level >= upgradeDataConfig[luaIdx].ID then
                        desText:setFontColor({r=217,g=184,b=121})
                    else
                        desText:setFontColor(UI.FONT_COLOR_41_41_45)
                    end
                end


                cell:addChild(desLayout)
            end, 
            function(e) 
                printError("------------------------refreshCardLayout-----------------error", e)
            end, 1)
        end

        return cell
    end)

    tableView:onUpdateCellNumbers(function()
        return #upgradeDataConfig
    end)
    self._rightLayout:addChild(tableView)
    tableView:reloadData()

    local markImg = UI.Image:create()
    markImg:init("ui_starmarks_up.png")
    markImg:centerBottom(100,0)
    self._rightLayout:addChild(markImg)


    self._btnDesText = UI.Text:create()
    self._btnDesText:init(UI.TEXT_228209, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    self._btnDesText:centerBottom(58)
    self._rightLayout:addChild(self._btnDesText)

    self._upgradBtn = UI.Button:create()
    self._upgradBtn:init("ui_starmarks_btn_01.png", "ui_starmarks_btn_01.png", "ui_starmarks_btn_01.png")
    self._upgradBtn:addEventListener(UIEvent.BUTTON_CLICK, self, self.upgradStarPray)
    self._upgradBtn:centerBottom(11)
    self._rightLayout:addChild(self._upgradBtn)
    
    self:createAndUpdateBtnContent()
    

end

function StarPrayIncreaseView:createAndUpdateBtnContent()
    if self._btnLayout then
        self._btnLayout:removeFromParent()
        self._btnLayout = nil
    end

    local upgradeConfData = ConfigManager:getStarPlateUpgradeDataByID(mvc.starPrayModel.level)
    local allConfigDatas = ConfigManager:getAllStarPlateUpgradeData()
    if mvc.starPrayModel.level >= allConfigDatas[#allConfigDatas].ID and mvc.starPrayModel:isAllRuneLight() then
        if self._btnDesText then self._btnDesText:hide() end
        if self._upgradBtn then self._upgradBtn:hide() end

        self._btnLayout = UI.Layout:create()
        self._btnLayout:init()
        self._btnLayout:centerBottom(50)
        self._rightLayout:addChild(self._btnLayout)

        local maxImg = UI.Image:create()
        maxImg:init("ui_information_max_2.png")
        maxImg:center()
        self._btnLayout:addChild(maxImg)

    elseif upgradeConfData then
        if self._btnDesText then self._btnDesText:show() end
        if self._upgradBtn then self._upgradBtn:show() end

        local strs = nil
        if mvc.starPrayModel:isAllRuneLight() then
            strs = string.split(upgradeConfData.upgradeCost, ",")
        else
            strs = string.split(upgradeConfData.patternCost, ",")
        end

        local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(strs[1]))

        if goodsData then
            self._btnLayout = UI.Layout:create()
            self._btnLayout:init()
            
            local width = 8
            local iconImg = UI.Image:create()
            iconImg:init(goodsData.miniIcon)
            iconImg:floatLeft(8)
            self._btnLayout:addComponent(iconImg)
            width = width + iconImg:getContentSize().width + 8

            local numText = UI.Text:create()
            numText:init(tostring(strs[2]), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
            numText:floatLeft(8)
            self._btnLayout:addComponent(numText)
            width = width + numText:getContentSize().width + 8

            if RoleDataManager:getMaster():getStarFireNum() < tonumber(strs[2]) then
                numText:setFontColor(UI.FONT_COLOR_RED)
            end

            self._btnLayout:setSize(width, 44)
            self._btnLayout:centerBottom(12)
            self._rightLayout:addChild(self._btnLayout)
        end
    end
end

function StarPrayIncreaseView:createAttributesView()
    self._attributesLayout = UI.Layout:create()
    self._attributesLayout:init()
    self._attributesLayout:setSize(445, 168)
    self._attributesLayout:leftUp(0,89.5)
    self._rightLayout:addChild(self._attributesLayout)

    local attrData = mvc.starPrayModel:getAllStarFireAttributes()
    self._attrTextTable = {}

    local tableView = UI.TableView:create({}, 445, 168 - 2)
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:leftBottom(0,280)
    tableView:setDelegate()
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setBounceable(true) 
    tableView:init()
    tableView:setScrollBarEnabled(false)
    tableView:setCircleVisible(false)
    tableView:onUpdateCellSize(function (tableview, idx)
        return 445,28
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
                attrLayout:setSize(445,28)
                attrLayout:leftBottom(0,0)

                local attrBg = UI.Image:create()
                attrBg:init("ui_starmarks_strip_01.png")
                attrBg:leftBottom(0,0)
                attrLayout:addChild(attrBg)

                if luaIdx%2 == 0 then
                    attrBg:setOpacity(0)
                end

                local attrData = mvc.starPrayModel:getAllStarFireAttributes()

                local attrIndex = luaIdx*2 - 1
                local aData = attrData[attrIndex]
                local aData2 = attrData[attrIndex + 1]

                if aData then
                    local attrIcon = UI.Image:create()
                    attrIcon:init(aData.icon)
                    attrIcon:centerLeft(8)
                    attrLayout:addChild(attrIcon)

                    local desText = UI.Text:create()
                    desText:init(aData.attrName, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
                    desText:centerLeft(36)
                    attrLayout:addChild(desText)

                    local attrText = UI.Text:create()
                    attrText:init("+" .. aData.value, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=26,g=77,b=67})
                    attrText:centerRight(238)
                    attrLayout:addChild(attrText)

                    self._attrTextTable[attrIndex] = attrText
                end

                if aData2 then
                    local attrIcon = UI.Image:create()
                    attrIcon:init(aData2.icon)
                    attrIcon:centerLeft(220)
                    attrLayout:addChild(attrIcon)

                    local desText = UI.Text:create()
                    desText:init(aData2.attrName, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
                    desText:centerLeft(247)
                    attrLayout:addChild(desText)

                    local attrText = UI.Text:create()
                    attrText:init("+" .. aData2.value, UI.FONT_BOLD, UI.FONT_SIZE_18PX, {r=26,g=77,b=67})
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
    self._rightLayout:addChild(tableView)
    tableView:reloadData()
end

function StarPrayIncreaseView:refreshAttributesView()
    local attrData = mvc.starPrayModel:getAllStarFireAttributes()
    for k,v in pairs(self._attrTextTable) do
        if attrData[k] then 

            local nowValue = ToolsUtil:calculationAttrShowValue(attrData[k].attrType,attrData[k].value)

            if v and v.setText then
                v:setText("+" .. nowValue)
            end
        end
    end
end

function StarPrayIncreaseView:onCurrencyChangeHandler(data)
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

            if(data.costType == PublicDefine.GOODS_COST_TYPE.STAR_FIRE and self._momey) then
                self._momey:addChild(text)
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

function StarPrayIncreaseView:updateCurrencyView()
    if self._momey then
        self._momey:setText(self._momey:numformat(string.format("%s", RoleDataManager:getMaster():getStarFireNum())))
        self._momey:updateView()
    end

    self:createAndUpdateBtnContent()
end

function StarPrayIncreaseView:createTopCurrency()
    local goodData = GoodsDataManager:createLocalGoodsData(MONEY_ICON_ID)

    if goodData then
        local momeyImage = UI.Image:create()
        momeyImage:init(goodData.miniIcon)
        momeyImage:leftUp(316, -2)
        self._rightLayout:addChild(momeyImage)
        
        self._momey = UI.Text:create()
        self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
        self._momey:setTextVerticalCenter()
        self._momey:setTextLeft()
        self._momey:centerLeft(momeyImage:getContentSize().width + 4)
        momeyImage:addChild(self._momey)
    end

    local lineL = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineL:setContentSize(445, 2)
    lineL:setAnchorPoint(0, 0)
    lineL:setPosition(0, self._rightLayout:getContentSize().height - 33)
    self._rightLayout:addChild(lineL,10)

    local attrTitleText = UI.Text:create()
    attrTitleText:init(UI.TEXT_228207, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_34_31_31)
    attrTitleText:leftUp(5, 40)
    self._rightLayout:addChild(attrTitleText)

    local attrTitleText = UI.Text:create()
    attrTitleText:init(UI.TEXT_228208, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_34_31_31)
    attrTitleText:leftUp(5, 250)
    self._rightLayout:addChild(attrTitleText)

    local lineL = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineL:setContentSize(445, 2)
    lineL:setAnchorPoint(0, 0)
    lineL:setPosition(0, self._rightLayout:getContentSize().height - 287)
    self._rightLayout:addChild(lineL,10)

    self:updateCurrencyView()
end

function StarPrayIncreaseView:initLeftPanel()
    local iconAnimation = UI.Animation:create()
    iconAnimation:init("effect_ui_town_starpray_tunshi_book.json", "effect_ui_town_starpray_tunshi_book.atlas", 1)
    iconAnimation:setAnimation("idle", true)
    iconAnimation:setSize(50, 50)
    addChildAuto(self._layoutUU, self, iconAnimation, "BgAnimation2", "center",999)

    local bg = UI.Image:create()
    bg:init("ui_starmarks_bg.png")
    self.bg = bg
    addChildAuto(self._layoutUU, self, bg, "IncreaseBg","leftBottom", 99)

    local runeBg = UI.Image:create()
    runeBg:init("ui_starmarks_runebg_01.png")
    runeBg:center()
    bg:addChild(runeBg)
    runeBg:rotate(-17)

    local gearAnimation = UI.Animation:create()
    gearAnimation:init("effect_ui_town_xingpan_a_di.json", "effect_ui_town_xingpan_a_di.atlas")
    gearAnimation:center()
    gearAnimation:setAnimation("idle1", false)
    gearAnimation:addEventListener(UIEvent.ANIMATION_EVENT, self, function(sender, event)
        print("eventeventeventeventevent ===== ",event.eventData.name == "upgrade",event.eventData.name)
        dump(event,nil,10)
        if(event and event.eventData) then
            if event.eventData.name == "upgrade" then
                -- 升级事件处理
                self:showUpgradeAnimView()
            end
        end
    end)
    bg:addChild(gearAnimation,10)
    self.gearAnimation = gearAnimation
    for i=1,10 do
        local runeAnimation = UI.Animation:create()
        runeAnimation:init("effect_ui_town_xingpan_figure.json", "effect_ui_town_xingpan_figure.atlas")
        runeAnimation:center()
        bg:addChild(runeAnimation)
        runeAnimation._spine:setSkin(tostring(i))
        runeAnimation:hide()
        runeAnimation:rotate(-17)

        local starPatternID = mvc.starPrayModel:getStarPatternIDByIndex(i)
        if starPatternID then  
            local isActivated = mvc.starPrayModel:starParyIsActivated(starPatternID)
            if isActivated then
                runeAnimation:show()
                runeAnimation:setAnimation("idle", true)
            end
        end

        self.runeAnimationList[i] = runeAnimation

        local runeBtn = UI.Button:create()
        runeBtn:init("ui_starmarks_element.png", "ui_starmarks_element.png", "ui_starmarks_element.png")
        runeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
            self:showRuneTipsView(i)
        end)
        bg:addChild(runeBtn)
        runeBtn:center(btnPosition[i].x, btnPosition[i].y)
        runeBtn:setOpacity(0)

        self.btnList[i] = runeBtn
        
    end

    local plateNameBg = UI.Image:create()
    plateNameBg:init('ui_starmarks_label_01.png')
    plateNameBg:centerUp(5,-2)
    bg:addChild(plateNameBg)

    local plateName = UI.Text:create()
    local pLevel = mvc.starPrayModel.level
    plateName:init(UI.TEXT_228205 .. pLevel,UI.FONT_STANDARD,UI.FONT_SIZE_24PX,UI.FONT_COLOR_34_31_31)
    plateName:center(0, -5)
    plateNameBg:addChild(plateName)
    self.plateName = plateName
end

function StarPrayIncreaseView:initRuneTipsView()
    self.runeTipsBg = UI.Image:create()
    self.runeTipsBg:init("ui_starmarks_panel_black.png")

    self.runeTipsLayout = UI.Layout:create()
    self.runeTipsLayout:init()
    self.runeTipsLayout:setSize(self.runeTipsBg:getContentSize().width, self.runeTipsBg:getContentSize().height)
    self.bg:addChild(self.runeTipsLayout,99999)
    
    self.runeTipsBg:center()
    self.runeTipsLayout:addChild(self.runeTipsBg)
end

function StarPrayIncreaseView:showUpgradeAnimView()
    -- 播发符文消失效果+delay 1秒 时间处理数据刷新逻辑
    for k,v in pairs(self.runeAnimationList) do
        v:show()
        v:setAnimation("end", false)
    end

    self._isUpgrading = true

    Avalon.Scheduler:scheduleUpdateOnce(self, function() 
        self._isUpgrading = false
        self:refreshContentView()
    end, 1.5)
end



function StarPrayIncreaseView:showRuneTipsView(rIndex)
    print("  showRuneTipsView  ")

    local pID = mvc.starPrayModel:getStarPatternIDByIndex(rIndex)
    -- local upgradeConfData = ConfigManager:getStarPlateUpgradeDataByID(mvc.starPrayModel.level)
    -- if not upgradeConfData then return end

    -- local patternIDList = upgradeConfData.patternID
    -- local pID = patternIDList[rIndex]

    if not pID then return end

    local patternData = ConfigManager:getStarPatternDataByID(pID)
    if not patternData then return end

    self:hideRuneTipsView()

    self:initRuneTipsView()

    self.runeTipsLayout:center(btnPosition[rIndex].x + self.runeTipsBg:getContentSize().width / 2 + 20, 
                btnPosition[rIndex].y - self.runeTipsBg:getContentSize().height / 2 - 20)


    local nodeList = {}
    local patternAttr = patternData.patternAttr
    local oneData = string.split(patternAttr,";")
    for k,v in ipairs(oneData) do
        local attrData = string.split(v,",")
        local attrName = ToolsUtil:getNameByAttrType(tonumber(attrData[1]))
        local nowValue = ToolsUtil:calculationAttrShowValue(tonumber(attrData[1]),tonumber(attrData[2]))

        local nodeLayout = UI.Layout:create()
        nodeLayout:init()
        
        table.insert(nodeList,nodeLayout)
        
        local width = 8
        local attrNameText = UI.Text:create()
        attrNameText:init(attrName,UI.FONT_STANDARD,UI.FONT_SIZE_18PX,UI.FONT_COLOR_155_155_155)
        attrNameText:floatLeft(8)
        nodeLayout:addComponent(attrNameText)
        width = width + attrNameText:getContentSize().width + 8

        local nowValueText = UI.Text:create()
        nowValueText:init("+" .. nowValue,UI.FONT_STANDARD,UI.FONT_SIZE_18PX,{r = 91, g = 191, b = 25})
        nowValueText:floatLeft(8)
        nodeLayout:addComponent(nowValueText)
        width = width + nowValueText:getContentSize().width + 8

        nodeLayout:setSize(width, 18)
    end
    
    local isActivated = mvc.starPrayModel:starParyIsActivated(pID)
    if not isActivated then
        local nodeLayout = UI.Layout:create()
        nodeLayout:init()
        
        table.insert(nodeList,nodeLayout)

        local width = 8
        local desText = UI.Text:create()
        desText:init(UI.TEXT_228206,UI.FONT_STANDARD,UI.FONT_SIZE_18PX,UI.FONT_COLOR_155_155_155)
        desText:floatLeft(8)
        nodeLayout:addComponent(desText)
        width = width + desText:getContentSize().width + 8

        nodeLayout:setSize(width, 18)
    end

    local upFloat = 0
    if #nodeList >= 3 then
        upFloat = 8
    elseif #nodeList >= 2 then
        upFloat = 17
    else
        upFloat = 35
    end
    
    for k,v in ipairs(nodeList) do
        v:floatUp(upFloat)
        self.runeTipsLayout:addComponent(v)
    end
end

function StarPrayIncreaseView:hideRuneTipsView()
    if self.runeTipsBg then
        self.runeTipsBg:removeFromParent()
        self.runeTipsBg = nil
    end

    if self.runeTipsLayout then
        self.runeTipsLayout:removeFromParent()
        self.runeTipsLayout = nil
    end
end

function StarPrayIncreaseView:upgradStarPray()
    if self._isUpgrading then
        return
    end

    local upgradeConfData = ConfigManager:getStarPlateUpgradeDataByID(mvc.starPrayModel.level)
    if upgradeConfData then
        local strs = nil
        local isAll = false
        if mvc.starPrayModel:isAllRuneLight() then
            strs = string.split(upgradeConfData.upgradeCost, ",")
            isAll = true
        else
            strs = string.split(upgradeConfData.patternCost, ",")
        end
        local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(strs[1]))
        if goodsData then
            if RoleDataManager:getMaster():getStarFireNum() < tonumber(strs[2]) then
                if mvc.tradeActivityModel:getActivityIsOpeningByID(PublicDefine.TradeActivityIDList.TradeActivityStarFire) then
                    --活动开启时, 跳转
                    UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                        UI.TEXT_228211,
                        function()
                            mvc.openPanel("StarPray", "StarPrayShop")
                        end
                    )
                else
                    --没有足够的星火
                    UI.ScrollBar:createByText(UI.TEXT_228210)
                end
                return
            end

            --扣除星火 升级
            if not isAll then
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                Net.NetPlaySystem:requestStarPatternActiveMessage()
            else
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_ACTIVITY_SHARE_UI)
                Net.NetPlaySystem:requestStarPatternUpgradeMessage()
            end
        end
    end
end

function StarPrayIncreaseView:activeRune(starPatternID)
    local upgradeConfData = ConfigManager:getStarPlateUpgradeDataByID(mvc.starPrayModel.level)
    if upgradeConfData then

        local patternIDList = upgradeConfData.patternID
        for k,v in ipairs(patternIDList) do
            if v == starPatternID and self.runeAnimationList[k] then
                self.runeAnimationList[k]:show()
                self.runeAnimationList[k]:setAnimation("begin", false)
                self.runeAnimationList[k]:addAnimation("idle", true)
                break
            end
        end
    end

    self:refreshContentView()
end

function StarPrayIncreaseView:activeUpgrade()
    self.gearAnimation:setAnimation("upgrade",false)
end

function StarPrayIncreaseView:refreshContentView()

    if self.plateName then
        local pLevel = mvc.starPrayModel.level
        self.plateName:setText(UI.TEXT_228205 .. pLevel)
    end

    --刷新属性
    self:refreshAttributesView()
    --刷新描述
    self._bottomTableView:reloadData()
    --刷新按钮相关
    if mvc.starPrayModel:isAllRuneLight() then
        self._btnDesText:setText(LanguageManager:getInstance():getLocalString(1111520))
    else
        self._btnDesText:setText(UI.TEXT_228209)
    end

    self:createAndUpdateBtnContent()

    UI.WaitingLayer:hideWaiting()
end

function StarPrayIncreaseView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end


function StarPrayIncreaseView:unbindModel()
    if self._touchListener then
        local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
        eventDispatcher:removeEventListener(self._touchListener)
    end
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end





return StarPrayIncreaseView












