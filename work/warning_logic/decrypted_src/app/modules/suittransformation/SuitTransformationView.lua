------------------------------------------------------------------------------
--author: linfeng.li
--date	: 2022/05/30
--desc	: 
------------------------------------------------------------------------------

require "app.ui.equipForge.EquipForgeBtnCell"
local EquipSetDescriptionCellView = require("app.modules.suittransformation.EquipSetDescriptionCellView")
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local SuitTransformationView = class("SuitTransformationView", UI.HWBtnComponent)
local GameDataManager = require("app.game.GameDataManager")

-- 资源
local COM_RES_LIST = {
    "ui_town_home.plist",
    "ui_town_deformation.plist",
    "ui_common_btn.plist",
    "ui_common_scale9image.plist",
    "ui_general_itemInfo.plist"
}

local COM_WIDTH = 1013
local COM_HEIGHT = 588
local BTN_CELL_W = 82
local BTN_CELL_H = 60
local SCROLL_WIDTH = 300
local SCROLL_HEIGHT = 400
local winSize = cc.Director:getInstance():getWinSize()

local PAGE_TYPE = {
    ALL =  0; --全部
    SWORD_SHIELD = 1;   --剑盾
    GREAT_SWORD = 2;   --大剑
    MAGIC_STAFF = 3;   --法杖
}

function SuitTransformationView:ctor()
    SuitTransformationView.super.ctor(
    	self,
    	UI.Type.SUIT_TRANSFORMATION,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

    self._selectSetSkill = nil --选择的套装技能对象
    self._pageType = PAGE_TYPE.ALL --默认选择页签
    self.lastTabIndex = 0
    self._setDescriptionArrGroup = {}
    self._showEffect = false
end

function SuitTransformationView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.suittransformation", "SuitTransformation", false)
    SuitTransformationView.super.init(self, ... )
end

function SuitTransformationView:dtor()

    -- print(debug.traceback())

    SuitTransformationView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.suittransformation.SuitTransformationView")
end


function SuitTransformationView:onInitView()
    self:center()

    local mask = cc.LayerColor:create(cc.c4b(0, 0, 0, 180))
    mask:setIgnoreAnchorPointForPosition(false)
    mask:setAnchorPoint(0.5, 0.5)
    mask:setContentSize(winSize.width * 2, winSize.height * 2)
    mask:setPosition(self._width / 2, self._height / 2)
    self:addChild(mask)

    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_deformation_bg.png")
    bg:center()
    contentLayout:addChild(bg)
    self._bg = bg

    -- 标题
    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_222202, UI.FONT_BOLD, UI.FONT_SIZE_28PX, {r = 170, g = 170, b = 170})
    titleText:centerUp(10, 35)
    bg:addChild(titleText)

    -- 套装属性背景
    local leftBg = UI.Image:create()
    leftBg:init("ui_home_retrofit_paper_bg_3.png")
    leftBg:centerUp(68, -175)
    bg:addChild(leftBg)
    self._leftBg = leftBg

    -- 能够被改造的套装背景
    local rightBg = UI.Image:create()
    rightBg:init("ui_deformation_paper.png")
    rightBg:centerUp(68, 175)
    bg:addChild(rightBg)
    self._rightBg = rightBg

    -- 黄金图标
    local glodIcon = UI.Image:create()
    glodIcon:init("symbol_gaming_money.png")
    glodIcon:leftUp(30, 14)
    rightBg:addChild(glodIcon)
    
    -- 金币数字
    local momey = UI.Text:create()
    momey:init("", UI.FONT_STANDARD, UI.FONT_SIZE_18PX, {r = 41, g = 41, b = 45})
    momey:leftUp(glodIcon:getContentSize().width + 35, 10)
    momey:setTextCenter()
    rightBg:addChild(momey)
    self._momey = momey
    self._momey:setText(self._momey:numformat(string.format("%d",GameDataManager:getInstance():getCurCoin())))

    -- 金币下面的线
    local splitLine = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_long.png")
    splitLine:setContentSize(326, 2)
    splitLine:setCapInsets(CCRectMake(20, 1, 1, 1))
    splitLine:setPosition(rightBg:getContentSize().width / 2, rightBg:getContentSize().height - 43)
    rightBg:addChild(splitLine)

    local rightLayout = UI.Layout:create()
    rightLayout:init()
    rightLayout:setSize(rightBg:getContentSize().width, rightBg:getContentSize().height)
    rightLayout:leftBottom()
    rightBg:addChild(rightLayout)
    self.rightLayout = rightLayout

    local leftLayout = UI.Layout:create()
    leftLayout:init()
    leftLayout:setSize(leftBg:getContentSize().width, leftBg:getContentSize().height)
    leftLayout:leftBottom()
    leftBg:addChild(leftLayout)
    self.leftLayout = leftLayout

    self:initPageView()
    self:updateRightLayout(true)
    self:updateLeftLayout()

    --创建铁匠spine
    self:createSmith()
end

function SuitTransformationView:createSmith()
    local spineStr = "effect_ui_town_blacksmith_new_forge_blacksmith"
    self._smithSp = UI.Animation:create()
    self._smithSp:init(spineStr .. ".json", spineStr .. ".atlas", 1);
    self._smithSp:leftBottom(77,28)
    self:smithIdle(true)    

    self._bg:addChild(self._smithSp)
end

function SuitTransformationView:smithIdle(loop)
    if self._smithSp then
        self._smithSp:setAnimation("idle1", loop)
    end
end

function SuitTransformationView:smithWork()
    if self._smithSp then
        self._smithSp:setAnimation("idle2", false)
        self._smithSp:addAnimation("idle1", true)
    end
end

function SuitTransformationView:updateLeftLayout()
    self.leftLayout:removeAllChildren()
    require "app.datas.GoodsDataManager"

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_222203, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
    titleText:centerUp(20, 0)
    self.leftLayout:addChild(titleText)

    if self._selectSetSkill and table.nums(self._selectSetSkill) > 0 then

        local point = UI.Image:create()
        point:init("ui_information_hero_diamond.png")
        point:setImageColor(UI.FONT_COLOR_41_41_45)
        point:leftUp(25, 95)
        self.leftLayout:addChild(point)

        -- 描述
        local baseText = UI.Text:create()
        baseText:init(
            string.format("%s", self._selectSetSkill[1]),
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX,
            {r = 60, g = 60, b = 65}
        )
        baseText:leftUp(40, 90)
        baseText:setTextLeftUp()
        self.leftLayout:addChild(baseText)

        if (baseText._width >  self.leftLayout:getContentSize().width - 105) then
            baseText:setWidth(self.leftLayout:getContentSize().width - 105)
            baseText:setSize(self.leftLayout:getContentSize().width - 105, 210)
        end

        -- 数值
        local baseValue = UI.Text:create()
        baseValue:init(
            string.format("[%s]", self._selectSetSkill[2]),
            UI.FONT_STANDARD,
            UI.FONT_SIZE_16PX,
            {r = 60, g = 60, b = 65}
        )
        baseValue:setSize(30, 20)
        baseValue:rightUp(22, 90)
        self.leftLayout:addChild(baseValue)

        local setSkillIsChage = self._selectSetSkill[3]
        local setId = self._selectSetSkill[4]
        local setMarkData = ConfigManager:getEquipmentSetBySetMark(setId)

        --重置
        if setSkillIsChage then
            local resetCost = setMarkData.resetCost
            if resetCost ~= "" then
                local resetData = string.split(resetCost, ",");
                local goodsId = resetData[1]
                local number = resetData[2]
                local goodData = GoodsDataManager:createLocalGoodsData(tonumber(goodsId))

                local resetButton = UI.Button:create()
                resetButton:init('ui_btn_yellow12_0.png', 'ui_btn_yellow12_1.png', 'ui_btn_yellow12_2.png')
                resetButton:centerBottom(-73)
                resetButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()

                    local goodNumber = 0
                    if tonumber(goodsId) == 23020001 then
                        goodNumber = RoleDataManager:getMaster():getCurCoin()
                    else
                        goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(goodsId), true)
                    end
                    print("goodNumber", goodNumber, tonumber(goodsId))
                    if goodNumber < tonumber(number) then
                        if tonumber(goodsId) == 23030001 then
                            UI.ScrollBar:createByText(UI.TEXT_222209)
                        elseif tonumber(goodsId) == 23020001 then
                            UI.ScrollBar:createByText(UI.TEXT_110210)
                        else
                            UI.ScrollBar:createByText(UI.TEXT_110210)
                        end
                        return
                    end


                    local tips = UI.Tips:createTips(UI.TEXT_222207,
                        UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
                    tips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                        Net.NetGoodsSystem:requesResetRetrofit(self._selectSetSkill[4], tonumber(self._selectSetSkill[2]))
                    end)
                end)
                self.leftLayout:addChild(resetButton)

                local resetButtonLabel = UI.Text:create()
                resetButtonLabel:init(UI.TEXT_222200, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
                resetButtonLabel:center(-55)
                resetButton:addChild(resetButtonLabel,10)

                local iconImage = UI.Image:create()
                if goodData.miniIcon ~= "" then
                    iconImage:init(goodData.miniIcon)
                else
                    iconImage:init(goodData.icon)
                end
                if iconImage:getContentSize().width > 20 then
                    iconImage:setScale(20 / iconImage:getContentSize().width)
                end
                iconImage:center(12)
                resetButton:addChild(iconImage, 10)

                local numberText = UI.Text:create()
                numberText:init("", UI.FONT_SxoTANDARD, UI.FONT_SIZE_18PX, {r = 41, g = 41, b = 45})
                numberText:leftBottom(151, 11)
                numberText:setTextCenter()
                resetButton:addChild(numberText,10)
                numberText:setText(numberText:numformat(string.format("%s",number)))

            end
        end

        --改造
        local suitRetrofitCost = setMarkData.suitRetrofitCost1
        if suitRetrofitCost ~= "" then
            local retrofitData = string.split(suitRetrofitCost, ",");
            local goodsId = retrofitData[1]
            local number = retrofitData[2]
            local goodData = GoodsDataManager:createLocalGoodsData(tonumber(goodsId))

            local retrofitButton = UI.Button:create()
            retrofitButton:init('ui_btn_yellow12_0.png', 'ui_btn_yellow12_1.png', 'ui_btn_yellow12_2.png')
            retrofitButton:centerBottom(-142)
            retrofitButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()

                local goodNumber = 0
                if tonumber(goodsId) == 23020001 then
                    goodNumber = RoleDataManager:getMaster():getCurCoin()
                else
                    goodNumber = GameDataManager:getInstance():getGoodsDataNumForGoodsID(tonumber(goodsId), true)
                end
                -- print("goodNumber", goodNumber, tonumber(goodsId))
                if goodNumber < tonumber(number) then
                    if tonumber(goodsId) == 23030001 then
                        UI.ScrollBar:createByText(UI.TEXT_222209)
                    elseif tonumber(goodsId) == 23020001 then
                        UI.ScrollBar:createByText(UI.TEXT_110210)
                    else
                        UI.ScrollBar:createByText(UI.TEXT_222208)
                    end
                    return
                end

                Net.NetGoodsSystem:requesEquipSetRetrofit(self._selectSetSkill[4], tonumber(self._selectSetSkill[2]), false)
            end)
            self.leftLayout:addChild(retrofitButton)

            local retrofitButtonLabel = UI.Text:create()
            retrofitButtonLabel:init(UI.TEXT_110203, UI.FONT_BOLD, UI.FONT_SIZE_20PX, {r = 41, g = 41, b = 45})
            retrofitButtonLabel:center(-55)
            retrofitButton:addChild(retrofitButtonLabel,10)

            local iconImage = UI.Image:create()
            if goodData.miniIcon ~= "" then
                iconImage:init(goodData.miniIcon)
            else
                iconImage:init(goodData.icon)
            end
            if iconImage:getContentSize().width > 20 then
                iconImage:setScale(20 / iconImage:getContentSize().width)
            end
            iconImage:center(12)
            retrofitButton:addChild(iconImage, 10)

            local numberText = UI.Text:create()
            numberText:init("", UI.FONT_SxoTANDARD, UI.FONT_SIZE_18PX, {r = 41, g = 41, b = 45})
            numberText:leftBottom(151, 11)
            numberText:setTextCenter()
            retrofitButton:addChild(numberText,10)
            numberText:setText(numberText:numformat(string.format("%s",number)))

        end

    end
end

function SuitTransformationView:updateRightLayout(isPageRef)
    local tableViewPoint = nil
    if self._tableView and not isPageRef then
        tableViewPoint = self._tableView:getContentOffset()
    end

    self.rightLayout:removeAllChildren()
    local expandedKey = {}

    if not isPageRef then
        for k,v in ipairs(self._setDescriptionArrGroup) do
            if v.isExpanded then
                expandedKey[k] = true
            end
        end
    end

    self._setDescriptionArrGroup = mvc.suitTransformationModel:getSuitGroupByEquipmentType(self._pageType)

    for k,v in ipairs(self._setDescriptionArrGroup) do
        if expandedKey[k] then
            v.isExpanded = true
        else
            v.isExpanded = false
        end
    end

    -- print("self._setDescriptionArrGroup ====== ")
    -- dump(self._setDescriptionArrGroup)

    self._tableView = UI.TableView:create({}, SCROLL_WIDTH, SCROLL_HEIGHT)
    self._tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self._tableView:leftBottom(20, 8)
    self._tableView:setDelegate()
    self._tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    self._tableView:setBounceable(true) 
    self._tableView:init()
    self._tableView:setScrollBarEnabled(true)
    self._tableView:setCircleVisible(false)
    self._tableView:onUpdateCellSize(function (tableview, idx)
        local luaIdx = idx + 1
        return self:getTableCellSizeForIdx(luaIdx)
    end) 
    self._tableView:onUpdateCells(function (tableview, idx)
        local luaIdx = idx + 1
        local cell = tableview:dequeueCell()
        if cell then
            cell:removeFromParent()
            cell = nil
        end
        if cell == nil then
            xpcall(function()
                cell = UI.TableViewCell:create()
        
                local cellView = UI.EquipSetDescriptionCellView:create(self._setDescriptionArrGroup[luaIdx],self._tableView)
                cellView:init()
                cellView:leftBottom(0, 0)
                cellView:setName("cellView")
                cell:addChild(cellView)
            end, 
            function(e) 
                printError("------------------------updateRightLayout-----------------error", e)
            end, 1)
        end

        local cellView = cell:getChildByName("cellView")
        if (cellView) then
            local cellWidth, cellHeight = self:getTableCellSizeForIdx(luaIdx)
            cell:setContentSize(cellWidth, cellHeight)
            cellView:setSize(cellWidth, cellHeight)
            cellView:updateCallback(function(callbackType, setDescriptionArr,isChecked)
                if (callbackType == 1) then
                    --显示选择套装属性的详情
                    self._selectSetSkill = setDescriptionArr
                    self:updateLeftLayout()

                    self._tableView:reloadData()
                elseif (callbackType == 2) then
                    --展开 或者 缩短的操作
                    local setDescriptionArrGroup = self._setDescriptionArrGroup[luaIdx]
                    setDescriptionArrGroup.isExpanded = isChecked

                    self._tableView:reloadData()
                end
            end)
            cellView:updateData(self._setDescriptionArrGroup[luaIdx])

            local selectIndex = 0
            for k,v in ipairs(self._setDescriptionArrGroup[luaIdx].activationArr) do
                if self._selectSetSkill and self._selectSetSkill[2] == v[2] and self._selectSetSkill[4] == v[4] then
                    selectIndex = k
                end
            end

            cellView:updateSelectBg(selectIndex,self._showEffect)

        end
        return cell
    end)

    self._tableView:onUpdateCellNumbers(function()
        return #self._setDescriptionArrGroup
    end)
    self.rightLayout:addChild(self._tableView)
    self._tableView:reloadData()

    if tableViewPoint then
        self._tableView:setContentOffset(tableViewPoint)
    end
    
    self._showEffect = false

end

function SuitTransformationView:resetRetrofitDataUpdate()
    local setDescriptionArrGroup = mvc.suitTransformationModel:getSuitGroupByEquipmentType(self._pageType)
    for k,v in ipairs(setDescriptionArrGroup) do
        for _,data in ipairs(v.activationArr) do
            if self._selectSetSkill and data[2] == self._selectSetSkill[2] and data[4] == self._selectSetSkill[4] then
                self._selectSetSkill = data
                break
            end
        end
    end
    self._showEffect = true
    self:updateRightLayout()
    self:updateLeftLayout()

    
    self:smithWork()
end

function SuitTransformationView:getTableCellSizeForIdx(idx)
    local setDescriptionArrGroup = self._setDescriptionArrGroup[idx]

    if (setDescriptionArrGroup.isExpanded) then
        return UI.EquipSetDescriptionCellView.CELL_WIDTH, UI.EquipSetDescriptionCellView.CELL_HEIGHT * (#setDescriptionArrGroup.activationArr + 1)
    else
        return UI.EquipSetDescriptionCellView.CELL_WIDTH, UI.EquipSetDescriptionCellView.CELL_HEIGHT
    end
end

function SuitTransformationView:initPageView()

    local btnData = {
        [1] = {icon = "ui_deformation_all.png", select = true},
        [2] = {icon = "ui_deformation_swordshield.png", select = false},
        [3] = {icon = "ui_deformation_weapon.png", select = false},
        [4] = {icon = "ui_deformation_staff.png", select = false},
    }

    local tablePageView = UI.TableView.new({}, BTN_CELL_W, 464);
    tablePageView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL);
    tablePageView:leftUp(334, 20)
    tablePageView:setDelegate();
    tablePageView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN);
    tablePageView:setBounceable(true);
    tablePageView:init();
    tablePageView:onUpdateCellSize(function (table,idx)
        return BTN_CELL_W, BTN_CELL_H;
    end);

    tablePageView:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell();
        xpcall(function()
            cell = UI.EquipForgeBtnCell.new();
            cell:init(btnData[idx+1]);
        end,
        function(e) 
            printError("-----------------------initPageView-----------------error")
        end, 1);

        return cell;
    end);

    tablePageView:onUpdateCellNumbers(function ()
        return table.nums(btnData);
    end);

    tablePageView:onTableCellTouched(function(table, cell)
        if not cell then
            return
        end

        if self._pageType == cell:getIdx() then
            return
        end

        self._pageType = cell:getIdx()
        btnData[self._pageType+1].select = true
        tablePageView:updateCellAtIndex(self._pageType)

        if self.lastTabIndex >= 0 then
            btnData[self.lastTabIndex+1].select = false
            tablePageView:updateCellAtIndex(self.lastTabIndex)
        end

        self.lastTabIndex = self._pageType


        self._selectSetSkill = nil
        self:updateRightLayout(true)
        self:updateLeftLayout()
    end);

    self._rightBg:addChild(tablePageView, -1);
    tablePageView:reloadData(true);
end

function SuitTransformationView:onCurrencyChangeHandler(data)

    self._momey:setText(self._momey:numformat(string.format("%d",GameDataManager:getInstance():getCurCoin())))

    if (data and data.costType == PublicDefine.GOODS_COST_TYPE.GOLD) then
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
        self._momey:addChild(text)
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

function SuitTransformationView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end


function SuitTransformationView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, self.onCurrencyChangeHandler)
end





return SuitTransformationView












