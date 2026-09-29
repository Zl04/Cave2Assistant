--[[
    luaide  模板位置位于 Template/FunTemplate/NewFileTemplate.lua 其中 Template 为配置路径 与luaide.luaTemplatesDir
    luaide.luaTemplatesDir 配置 https://www.showdoc.cc/web/#/luaide?page_id=713062580213505
    author:{author}
    time:2019-09-11 18:11:02
]]

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local EquipIllusionCellView = class("EquipIllusionCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local SCROLL_WIDTH = 300
local ENTRY_HEIGHT = 67
EquipIllusionCellView.CELL_WIDTH = SCROLL_WIDTH
EquipIllusionCellView.CELL_HEIGHT = ENTRY_HEIGHT

function EquipIllusionCellView:ctor()
    EquipIllusionCellView.super.ctor(
    	self,
    	nil,
        COM_RES_LIST,
        EquipIllusionCellView.WIDTH,
        EquipIllusionCellView.HEIGHT
    )
end

function EquipIllusionCellView:init( ... )
    EquipIllusionCellView.super.init(self, ... )
end

function EquipIllusionCellView:dtor()
    EquipIllusionCellView.super.dtor(self)
end


function EquipIllusionCellView:onInitView()
    -- 添加整组标题和勾选
    self._groupLayout = self:getItemLayout(0, true, function(comp, isChecked)
        if (self._callback and #self._groupEntry.itemList == 1) then 
            self._callback(1, 1, isChecked)
        else
            self._callback(1, nil, isChecked)
        end
    end, function(comp, isChecked)
        self._callback(2, nil, isChecked)
    end)
    self._groupLayout:centerUp(0)
    self:addChild(self._groupLayout)
end

-- 更新列表
function EquipIllusionCellView:onUpdateView()
    if (self._groupEntry and #self._groupEntry.itemList > 1) then
        -- 获取组状态
        self._groupEntry.itemIsUnlocked = false
        self._groupEntry.groupIsNew = false
        self._groupEntry.itemIsChecked = false
        for i,itemEntry in ipairs(self._groupEntry.itemList) do
            -- 组内是否有已解锁的道具
            if (itemEntry.itemIsUnlocked and AvalonUtil.equipTypesAndDuplicationFilter(itemEntry.itemEquipID)) then
                self._groupEntry.itemIsUnlocked = true
            end

            -- 组内是否有已勾选的道具
            if (itemEntry.itemIsChecked) then
                self._groupEntry.itemIsChecked = true
            end

            -- 组内是否有新道具
            local isItemNew = EquipIllusionDataManager:getIllusionIsNew(itemEntry.itemIllusionID)
            if (isItemNew) then
                self._groupEntry.groupIsNew = true
            end
        end
        self:updateItemLayout(self._groupLayout, self._groupEntry)
    elseif (self._groupEntry) then
        self:updateItemLayout(self._groupLayout, self._groupEntry.itemList[1])
    else
        self._groupLayout:hide()
    end
end

-- 隐藏装备布局, 并且隐藏点击勾勾, 避免遮挡其他按钮
function EquipIllusionCellView:setLayoutVisible(itemLayoutOrExpandedLayout, isVisible)
    if (itemLayoutOrExpandedLayout.itemLayoutList) then
        itemLayoutOrExpandedLayout:setVisible(isVisible)
        for i,itemLayoutToHide in ipairs(itemLayoutOrExpandedLayout.itemLayoutList) do
            itemLayoutToHide:setVisible(isVisible)
            itemLayoutToHide.__wearCheckBox:setVisible(isVisible)
        end
    else
        itemLayoutOrExpandedLayout:setVisible(isVisible) 
        itemLayoutOrExpandedLayout.__wearCheckBox:setVisible(isVisible)
    end
end

-- 更新扩展布局
function EquipIllusionCellView:updateItemList(itemLayout, groupEntry)
    local itemList = groupEntry and groupEntry.itemList or nil
    if (itemLayout.__expandedLayout and not itemList) then
        self:setLayoutVisible(itemLayout.__expandedLayout, false)
    elseif (itemList) then
        -- 获取或创建扩展后布局
        local expandedLayout = itemLayout.__expandedLayout
        if (not expandedLayout) then
            expandedLayout = UI.Layout:create()
            expandedLayout:init()
            expandedLayout:setSize(SCROLL_WIDTH, ENTRY_HEIGHT * #itemList)
            expandedLayout:centerUp(ENTRY_HEIGHT)
            expandedLayout:setAnchorPoint(0.5, 1)
            expandedLayout.itemLayoutList = {}
            itemLayout:addChild(expandedLayout)
            itemLayout.__expandedLayout = expandedLayout
        end
        expandedLayout:show()

        -- 播放扩展动画
        if (groupEntry.isExpanded ~= groupEntry.isExpandedLastTime) then
            groupEntry.isExpandedLastTime = groupEntry.isExpanded
            expandedLayout:setScale(1, 0)
            expandedLayout:runAction(cc.EaseSineOut:create(cc.ScaleTo:create(0.15, 1, 1)))
        end

        -- 更新扩展信息
        for j,itemEntry in ipairs(itemList) do
            -- 获取或创建道具模板
            local itemLayout = expandedLayout.itemLayoutList[j]
            if (not itemLayout) then
                itemLayout = self:getItemLayout(-16, false, function(comp, isChecked)
                    self._callback(1, j, isChecked)
                end)
                itemLayout:centerUp((j - 1) * ENTRY_HEIGHT)
                expandedLayout:addChild(itemLayout)
                table.insert(expandedLayout.itemLayoutList, itemLayout)
            end
            self:setLayoutVisible(itemLayout, true)

            -- 更新信息
            self:updateItemLayout(itemLayout, itemEntry)
        end

        -- 隐藏多余的
        for i=#itemList + 1,#expandedLayout.itemLayoutList do
            local itemLayoutToHide = expandedLayout.itemLayoutList[i]
            if (itemLayoutToHide) then 
                self:setLayoutVisible(itemLayoutToHide, false)
            end
        end
    end
end

-- 更新一个单位布局
function EquipIllusionCellView:updateItemLayout(itemLayout, itemEntry)
    if (not itemEntry) then 
        itemLayout:hide()
        return
    end
    itemLayout:show()

    -- 更新扩展显示
    if (itemEntry.itemList and #itemEntry.itemList > 1) then
        -- 更新按钮显示
        itemLayout.__expandBtn:show()

        -- 更新扩展列表
        local isExpanded = itemEntry.isExpanded
        if (isExpanded ~= nil) then
            -- 设置按钮状态
            itemLayout.__expandBtn:setValue(isExpanded, false)

            -- 设置扩展布局状态
            if (isExpanded) then
                self:updateItemList(itemLayout, self._groupEntry)
            else
                self:updateItemList(itemLayout)
            end
        else
            self:updateItemList(itemLayout)
            itemLayout.__expandBtn:setValue(false, false)
        end
    else
        self:updateItemList(itemLayout)
        itemLayout.__expandBtn:hide()
    end

    -- 更新组名
    local itemName = itemEntry.groupName == nil and itemEntry.itemName or itemEntry.groupName
    if (itemName) then
        itemLayout.__itemNameLabel:setText(itemName)
    end

    -- 更新价钱
    local itemPrice = itemEntry.itemPrice
    if (itemPrice and itemPrice > 0) then
        itemLayout.__itemPriceLabel:setText(itemPrice)
    end

    -- 更新物品ID相关内容
    local itemID = itemEntry.itemEquipID
    local itemData = nil
    if (itemID) then 
        itemData = GoodsDataManager:createEquipmentForEquipmentID(itemID)
    end

    -- 更新道具外观
    if (itemData) then
        itemData:setIsNew(false)
        itemLayout.__itemGrid:show()
        itemLayout.__itemGrid:setData(itemData)
        itemLayout.__itemGrid:updateView()
    else
        itemLayout.__itemGrid:hide()
    end

    -- 更新小图标
    local equipType = 1
    local weaponType = nil
    if (itemData) then
        equipType = itemData:getEquipmentType()
        if (equipType == 8) then
            weaponType = itemData:getWeaponType()
        end
    end
    local iconFileName = "icon-equip_large_210" .. equipType .. "0010" .. (weaponType and "_" .. weaponType or "") .. ".png"
    itemLayout.__tinyIcon:setSpriteName(iconFileName)

    -- 更新可用状态
    local equipTypesAndDuplicationFilter, isWearingSameType, isWearingSameEquip = AvalonUtil.equipTypesAndDuplicationFilter(itemID)
    if (not itemEntry.itemIsUnlocked or not equipTypesAndDuplicationFilter) then
        -- 设置排版外观
        itemLayout:setOpacity(102)
        itemLayout.__priceLayout:hide()
        itemLayout.__descLabel:show()

        -- 注释文字
        local labelString = LanguageManager:getInstance():getLocalString(1111592) --"尚未拥有"
        local labelColor = UI.FONT_COLOR_80_5_5
        if (itemEntry.itemList) then
            labelString = LanguageManager:getInstance():getLocalString(1111672) --"无可用外观"
        elseif (isWearingSameEquip) then -- 已经穿戴了相同的装备, 显示穿戴中
            labelString = LanguageManager:getInstance():getLocalString(1111671) --"穿戴中"
            labelColor = UI.FONT_COLOR_42_103_85
        elseif (itemEntry.itemIsUnlocked and not isWearingSameType) then -- 已解锁, 但是没有穿戴相同的部件
            labelString = LanguageManager:getInstance():getLocalString(1111664) --"未穿戴此类型装备"
        end
        
        -- 注释
        itemLayout.__descLabel:setText(labelString)
        itemLayout.__descLabel:setFontColor(labelColor)

        -- 设置不能点
        itemLayout.__wearCheckBox:disable()
    else
        -- 设置排版外观
        itemLayout:setOpacity(255)
        if (not itemEntry.itemIsBought and itemEntry.itemPrice and itemEntry.itemPrice > 0) then
            itemLayout.__priceLayout:show()
        else
            itemLayout.__priceLayout:hide()
        end
        itemLayout.__descLabel:hide()

        -- 设置能点勾勾
        itemLayout.__wearCheckBox:enable()
    end

    -- 更新new标签
    local isItemNew = itemEntry.groupIsNew == nil and EquipIllusionDataManager:getIllusionIsNew(itemEntry.itemIllusionID) or itemEntry.groupIsNew
    itemLayout.__newIcon:setVisible(isItemNew)

    -- 设置道具勾选状态
    local itemIsChecked = itemEntry.itemIsChecked
    if (itemIsChecked ~= nil) then
        itemLayout.__wearCheckBox:setValue(itemIsChecked, false)
    end
end

-- 创建一个单位布局, initScrollContent使用
function EquipIllusionCellView:getItemLayout(widthOffset, isShowBg, checkBoxCb, expandCb)
    -- 内容布局
    local contentLayout = UI.Layout:create()
    contentLayout:init()

    -- new标签
    local newIcon = UI.Image:create()
    newIcon:init("ui_information_banner_new2.png")
    newIcon:rightUp(-10, -10)
    newIcon:setVisible(false)
    contentLayout:addChild(newIcon, 2)
    contentLayout.__newIcon = newIcon

    -- 组背景
    local groupBg = UI.Image:create()
    groupBg:init("ui_deformation_information.png")
    groupBg:center(0)
    groupBg:setVisible(isShowBg)
    contentLayout:addChild(groupBg)
    contentLayout.__groupBg = groupBg

    -- 根据背景图片设置布局大小
    local bgWidth, bgHeight = groupBg:getSize()
    local actualBgWidth = bgWidth + widthOffset
    contentLayout:setSize(actualBgWidth, bgHeight)

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_dark.png", CCRectMake(0,0,1,1), cc.size(269, 1))
    splitLine:centerBottom(0)
    splitLine:setVisible(not isShowBg)
    contentLayout:addChild(splitLine)

    -- 扩展按键
    local expandBtn = UI.CheckBox:create()
    expandBtn:init("ui_btn_spread_0.png", "ui_btn_spread_1.png", "ui_btn_spread_2.png")
    expandBtn:leftBottom(15, 16)
    expandBtn:setTouchClipNode(self._scrollView)
    contentLayout:addChild(expandBtn)
    contentLayout.__expandBtn = expandBtn
    expandBtn:addEventListener(UI.Event.CHECKBOX_STATUS_CHANGED, self, function(self, comp, isChecked)
        if (expandCb) then expandCb(comp, isChecked) end
    end)

    -- 物品Icon
    local itemGrid = UI.GoodsGrid:create()
    itemGrid:init()
    itemGrid:setScale(0.86)
    itemGrid:center(-actualBgWidth / 2 + 32, -1)
    itemGrid:hideCountLabel()
    itemGrid:hideNewIcon()
    itemGrid:hideBG()
    itemGrid:hide()
    contentLayout:addChild(itemGrid)
    contentLayout.__itemGrid = itemGrid

    -- 类型小图标背景
    local cornerShadow = UI.Image:create()
    cornerShadow:init("ui_deformation_angle.png")
    cornerShadow:rightBottom(1, 2)
    itemGrid:addChild(cornerShadow, 100)

    -- 装备类型小图标
    local tinyIcon = UI.Image:create()
    tinyIcon:init("icon-equip_large_21010010.png")
    tinyIcon:rightBottom(-2, -2)
    itemGrid:addChild(tinyIcon, 101)
    contentLayout.__tinyIcon = tinyIcon

    -- 中央标题栏和价格布局
    local centerLayout = UI.Layout:create()
    centerLayout:init()
    centerLayout:enableAutoWidth()
    centerLayout:enableAutoHeight()
    centerLayout:center(12, 0)
    contentLayout:addChild(centerLayout)
    contentLayout.__centerLayout = centerLayout

    -- 标题名
    local itemNameLabel = UI.Text:create()
    itemNameLabel:init("", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    itemNameLabel:setMaxLineWidth(150)
    itemNameLabel:setTextHorizontalCenter()
    itemNameLabel:setLineSpacing(-7)
    itemNameLabel:autoAdapt()
    itemNameLabel:floatUp(0)
    centerLayout:addComponent(itemNameLabel)
    contentLayout.__itemNameLabel = itemNameLabel

    -- 价格布局
    contentLayout.__priceLayout = UI.Layout:create()
    contentLayout.__priceLayout:init()
    contentLayout.__priceLayout:floatUp(-1)
    contentLayout.__priceLayout:enableAutoWidth()
    contentLayout.__priceLayout:enableAutoHeight()
    centerLayout:addComponent(contentLayout.__priceLayout)

    -- 钻石图标
    local diamondIcon = UI.Image:create()
    diamondIcon:init("symbol_gaming_diamond.png")
    diamondIcon:floatLeft(0)
    contentLayout.__priceLayout:addComponent(diamondIcon)

    -- 价格文字
    contentLayout.__itemPriceLabel = UI.Text:create()
    contentLayout.__itemPriceLabel:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    contentLayout.__itemPriceLabel:floatLeft(3)
    contentLayout.__priceLayout:addComponent(contentLayout.__itemPriceLabel)
    contentLayout.__priceLayout:updateView()

    -- 未拥有标签
    contentLayout.__descLabel = UI.Text:create()
    contentLayout.__descLabel:init("", UI.FONT_BOLD, UI.FONT_SIZE_16PX)
    contentLayout.__descLabel:floatUp(0)
    centerLayout:addComponent(contentLayout.__descLabel)

    -- 单个穿戴勾选框
    local wearCheckBox = UI.CheckBox:create() 
    wearCheckBox:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_1.png", 0.65)
    wearCheckBox:rightBottom(5, 15)
    -- wearCheckBox:setTouchClipNode(self._tableView)
    contentLayout:addChild(wearCheckBox)
    contentLayout.__wearCheckBox = wearCheckBox
    wearCheckBox:addEventListener(UI.Event.CHECKBOX_STATUS_CHANGED, self, function(self, comp, isChecked)
        if (checkBoxCb) then checkBoxCb(comp, isChecked) end
    end)

    return contentLayout
end

function EquipIllusionCellView:updateData(data)
    self._groupEntry = data
    self:updateView()
end

function EquipIllusionCellView:updateCallback(cb)
    self._callback = cb
end

return EquipIllusionCellView
