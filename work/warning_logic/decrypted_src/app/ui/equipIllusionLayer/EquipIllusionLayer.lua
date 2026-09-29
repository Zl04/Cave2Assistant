-- EquipIllusionLayer.lua
-- Author:CMonk
-- 2018年1月8日


require "app.ui.common.CheckBox"
require "app.ui.UIDefine"
require "app.datas.EquipIllusionDataManager"
local LanguageManager = require("app.game.LanguageManager")
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}
local EquipIllusionLayer = class("EquipIllusionLayer", UI.DownShowWin)
UI.EquipIllusionLayer = EquipIllusionLayer

local winSize = cc.Director:getInstance():getOpenGLView():getDesignResolutionSize()
local CONTENT_ZORDER = 1

--资源列表(必备)
local COM_RES_LIST = {
    "ui_common_btn.plist",
    "ui_common_scale9image.plist",
    "ui_common_icon_equip",
    "ui_town_deformation.plist",
}

-- 标签信息
local TAB_DATA = {
    [1] = {             -- 全部装备标签
        iconFileName = "ui_deformation_all.png",
        isToDisplayFunc = function(self, thisData) return true end,
        getEqiupType = function() return 0 end,
    },    
    [2] = {             -- 武器标签
        iconFileName = "ui_deformation_weapon.png",
        isToDisplayFunc = function(self, thisData) return true end,
        getEqiupType = function() return PublicDefine.EQUIPMENT_TYPE.Weapon end,
    },       
    [3] = {             -- 头部标签
        iconFileName = "ui_deformation_helm.png",
        isToDisplayFunc = function(self, thisData) return true end,
        getEqiupType = function() return PublicDefine.EQUIPMENT_TYPE.Helmet end,
    },
    [4] = {             -- 盔甲标签
        iconFileName = "ui_deformation_armor.png",
        isToDisplayFunc = function(self, thisData) return true end,
        getEqiupType = function() return PublicDefine.EQUIPMENT_TYPE.Chest end,
    },
    [5] = {             -- 肩部标签
        iconFileName = "ui_deformation_scapula.png",
        isToDisplayFunc = function(self, thisData) return true end,
        getEqiupType = function() return PublicDefine.EQUIPMENT_TYPE.Shoulders end,
    },
    [6] = {             -- 手套标签
        iconFileName = "ui_deformation_globe.png",
        isToDisplayFunc = function(self, thisData) return true end,
        getEqiupType = function() return PublicDefine.EQUIPMENT_TYPE.Gloves end,
    },
    [7] = {             -- 鞋子标签
        iconFileName = "ui_deformation_boot.png",
        isToDisplayFunc = function(self, thisData) return true end,
        getEqiupType = function() return PublicDefine.EQUIPMENT_TYPE.Boots end,
    },
}


--构造函数(必备)
function EquipIllusionLayer:ctor(npcSpriteID)
    EquipIllusionLayer.super.ctor(
        self, 
        UIType.EQUIP_ILLUSION_LAYER,
        COM_RES_LIST,
        0, -- 这里的大小不起作用, 背景图加载过后会重新设置
        0
    )
    self._npcSpriteID = npcSpriteID
    self._cachedPanels = {}
    self._callbackList = {}
    self:setTouchEnable(true)
    self:setInterceptTouches(true)
    self:registerListener()
    self:init()
    self:open()
end


--虚构函数, destroy时调用(必备)
function EquipIllusionLayer:dtor()
    EquipIllusionLayer.super.dtor(self)
    -- reload_script_file("app.ui.equipIllusionLayer.EquipIllusionLayer")
    self:unregisterListener()
    Avalon.Scheduler:unscheduleUpdateOnce(self, self.updateRoleAnimationAndEquipListView)
end

-- 初始化(必备)
function EquipIllusionLayer:init()
    EquipIllusionLayer.super.init(self)

    -- 设置默认显示页面
    self:showContentPanelByIndex(1)

    -- 添加现有装备幻化数据
    self._trialEntryTable = self:getTrialDataTableFromWearing()
    
    -- 数据获取
    performWithDelay(self, function() 
        Net.NetGoodsSystem:requestEquipIllusionInfo(self._npcSpriteID)
    end, 0.3)
end

-- 模版函数：初始化组建的视图(必备)
function EquipIllusionLayer:onInitView()
    -- 总板块
    self._rootLayer = UI.Component:create()
    self._rootLayer:init()
    self._rootLayer:setSize(winSize.width, winSize.height)
    self._rootLayer:center()
    self:addChild(self._rootLayer)

    -- 背景
    self._bg = UI.Image:create()
    self._bg:init("ui_deformation_bg.png")
    self._bg:center()
    self._rootLayer:addChild(self._bg)

    -- 设置自己的大小
    local bgWidth, bgHeight = self._bg:getSize()
    self:setSize(bgWidth - 140, bgHeight - 30) -- 调整点击外部关闭窗口大小

    -- 背景藤蔓
    local eyes = UI.Animation:create()
    eyes:init("effect_ui_town_deformation_huanhua_yanjingbg.json", "effect_ui_town_deformation_huanhua_yanjingbg.atlas", 1);
    eyes:leftBottom(360, 310)
    eyes:setAnimation("idle", true)
    self._bg:addChild(eyes)

    -- 标题
    local title = UI.Text:create()
    title:init(LanguageManager:getInstance():getLocalString(1111663), UI.FONT_BOLD, UI.FONT_SIZE_26PX, UI.FONT_COLOR_170_170_170) --"幻化"
    title:center(35, -264)
    self._bg:addChild(title)

    -- 清除试穿
    self._clearTrialBtn = UI.Button:create() 
    self._clearTrialBtn:init("ui_btn_try_0.png", "ui_btn_try_1.png", "ui_btn_try_0.png")
    self._clearTrialBtn:leftBottom(177, 463)
    self._clearTrialBtn:openClickScale()
    self._clearTrialBtn:setInterval(1)
    self._bg:addChild(self._clearTrialBtn)
    self._clearTrialBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
        self._trialEntryTable = self:getTrialDataTableFromWearing()
        self:updateView()
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111588)) --"已清除试穿效果"
    end)
    self._clearTrialBtn:addEventListener(UI.Event.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111669)) --"未选择任何幻化外观"
    end)

    -- 还原外形
    self._resetBtn = UI.Button:create() 
    self._resetBtn:init("ui_btn_reduction_0.png", "ui_btn_reduction_1.png", "ui_btn_reduction_0.png")
    self._resetBtn:leftBottom(177, 397)
    self._resetBtn:setInterval(1)
    self._bg:addChild(self._resetBtn)
    self._resetBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
        local bindTips = UI.Tips:createTips(LanguageManager:getInstance():getLocalString(1111585), UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL) --"还原后将恢复到现有装备的外形, 你确定要这样做吗?"
        bindTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
            local wearingList = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
            for k,wearingEquipData in pairs(wearingList) do
                if (wearingEquipData:getIllusionID() ~= 0) then
                    Net.NetGoodsSystem:requestEquipIllusionWear(self._npcSpriteID, wearingEquipData:getEntityID(), 0)
                end
            end
            self._trialEntryTable = {}
            self:updateView()
            UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111589))--"外形已还原"
        end)
    end)

    -- 角色站点
    local standingGround = UI.Image:create()
    standingGround:init("ui_deformation_taiwan.png")
    standingGround:leftBottom(235, 101)
    self._bg:addChild(standingGround)

    -- 角色动画
    self._roleAnimation = UI.RoleAnimation:create(false)
    local masterData = RoleDataManager:getMaster()
    self._roleAnimation:init(masterData)
    self._roleAnimation:setScaleX(-1 * self._roleAnimation:getScaleX())
    self._roleAnimation:leftBottom(280, 205)
    self._roleAnimation:showBlink(true)
    self._roleAnimation:showHelmet(true)
    self._bg:addChild(self._roleAnimation)

    -- 角色特效
    local characterSFX = UI.Animation:create()
    characterSFX:init("effect_ui_town_deformation_huanhua_zhujue.json", "effect_ui_town_deformation_huanhua_zhujue.atlas", 1);
    characterSFX:leftBottom(340, 180)
    self._bg:addChild(characterSFX)

    -- 兔子动画
    local bunny = UI.Animation:create()
    bunny:init("effect_ui_town_deformation_huanhua_tuzi.json", "effect_ui_town_deformation_huanhua_tuzi.atlas", 1)
    bunny:setAnimation("idle1", false)
    bunny:leftBottom(75, 30)
    bunny._spine:registerSpineEventHandler(function (event)
        if (math.random(4) == 1) then
            bunny:setAnimation("idle2", false)
        else
            bunny:setAnimation("idle1", false)
        end
    end, sp.EventType.ANIMATION_COMPLETE)
    self._bg:addChild(bunny)

    -- 变换按钮
    self._btnMagicChangeCloth0_0 = UI.Button:create()
    self._btnMagicChangeCloth0_0:init("ui_btn_yellow4_0.png", "ui_btn_yellow4_1.png", "ui_btn_yellow4_2.png")
    self._btnMagicChangeCloth0_0:leftBottom(228, 99)
    self._btnMagicChangeCloth0_0:setInterval(1)
    self._bg:addChild(self._btnMagicChangeCloth0_0)
    self._btnMagicChangeCloth0_0:addEventListener(UI.Event.BUTTON_CLICK, self, function()
        if (not Avalon.MathUtil:checkDiamonEnough(self:getCostFromTrialData(), GameDataManager:getInstance():getDiamond())) then
            UI.TipsLayer:onDiamondNotEnough()
            return
        end

        characterSFX:setAnimation("trigger", false)
        self:isTrialAndWearingDifferent(function(trialItemEntry, wearingEqiupData)
            local illusionID = 0
            if (trialItemEntry) then illusionID = trialItemEntry.itemIllusionID end
            Net.NetGoodsSystem:requestEquipIllusionWear(self._npcSpriteID, wearingEqiupData:getEntityID(), illusionID)
        end)
        Avalon.AudioManager:playSound("1539", false)
    end)
    self._btnMagicChangeCloth0_0:addEventListener(UI.Event.BUTTON_DISABLE_PRESS, self, function()
        UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1111669)) --"未选择任何幻化外观"
    end)

    

    -- 按钮内容布局
    local magicChangeLayout0_0 = UI.Layout:create()
    magicChangeLayout0_0:init()
    magicChangeLayout0_0:enableAutoWidth()
    magicChangeLayout0_0:enableAutoHeight()
    magicChangeLayout0_0:center()
    self._btnMagicChangeCloth0_0:addChild(magicChangeLayout0_0, 100)

    -- 变换文字
    self._magicChangeText0_0 = UI.Text:create()
    self._magicChangeText0_0:init(LanguageManager:getInstance():getLocalString(1111579), UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44) --"更换外形"
    self._magicChangeText0_0:floatLeft(0)
    self._magicChangeText0_0:setTextCenter()
    magicChangeLayout0_0:addComponent(self._magicChangeText0_0)

    -- 钻石图标
    self._magicChangeDiamond0_0 = UI.Image:create()
    self._magicChangeDiamond0_0:init("symbol_gaming_diamond.png")
    self._magicChangeDiamond0_0:floatLeft(20)
    magicChangeLayout0_0:addComponent(self._magicChangeDiamond0_0)

    -- 花费文字
    self._magicChangePriceText0_0 = UI.Text:create()
    self._magicChangePriceText0_0:init("0",UI.FONT_BOLD,UI.FONT_SIZE_20PX)
    self._magicChangePriceText0_0:floatLeft(3)
    self._magicChangePriceText0_0:setFontColor(UI.FONT_COLOR_50_50_44)
    self._magicChangePriceText0_0:enableWrap(false)
    self._magicChangePriceText0_0:setTextCenter()
    magicChangeLayout0_0:addComponent(self._magicChangePriceText0_0)

    -- 提示文字
    local explainLabel = UI.Text:create()
    explainLabel:init(LanguageManager:getInstance():getLocalString(1111662), UI.FONT_BOLD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_155_155_155) --"提示文字提示点啥子" skin costs crystal only for the first time.
    explainLabel:center(-165, 225)
    explainLabel:setWidth(330)
    explainLabel:setTextCenter()
    explainLabel:autoAdapt()
    self._bg:addChild(explainLabel)

    -- 标签锚点
    local tabListLayout = UI.Layout:create()
    tabListLayout:init()
    tabListLayout:enableAutoHeight()
    tabListLayout:enableAutoWidth()
    tabListLayout:setTouchEnable(true)
    tabListLayout:leftUp(835, 87)
    self._bg:addChild(tabListLayout)

    -- 标签内容
    self._tabList = {}
    for i,v in ipairs(self:getTabData()) do
        if (v.isToDisplayFunc(self, v)) then
            local tab = UI.Button:create(v.tabUIType)
            tab:init("ui_btn_gray4_0.png", "ui_btn_gray4_1.png", "ui_btn_gray4_3.png")
            tab:floatUp(7)
            tab:closeClickScale()
            tab:setTag(i)
            tab:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
            tab:addEventListener(UIEvent.BUTTON_CLICK, self, function(self)
                self:showContentPanelByIndex(tab:getTag())
            end)

            -- 设置普通标签图标
            local normal = UI.Image:create()
            normal:init("ui_btn_gray4_0.png")
            normal:centerLeft(0)
            tab:setNormalNode(normal, 2)

            local normalIcon = UI.Image:create()
            normalIcon:init(v.iconFileName)
            normalIcon:center()
            normalIcon:setImageColor({ r = 47, g = 50, b = 55 })
            normal:addChild(normalIcon)

            -- 设置激活标签图标
            local active = UI.Image:create()
            active:init("ui_btn_gray4_1.png")
            active:centerLeft(5)
            tab:setSelectedNode(active, 2)

            local activeIcon = UI.Image:create()
            activeIcon:init(v.iconFileName)
            activeIcon:center()
            activeIcon:setImageColor({ r = 220, g = 211, b = 147 })
            active:addChild(activeIcon)

            -- 设置激活标签图标
            local disable = UI.Image:create()
            disable:init("ui_btn_gray4_3.png")
            disable:centerLeft(0)
            tab:setDisabledNode(disable, 2)

            local disableIcon = UI.Image:create()
            disableIcon:init(v.iconFileName)
            disableIcon:center()
            disableIcon:setImageColor({ r = 21, g = 24, b = 27 })
            disable:addChild(disableIcon)

            -- 加入列表
            tabListLayout:addComponent(tab)
            table.insert(self._tabList, tab)
        end
    end

    -- 纸片
    local bgPaper = UI.Image:create()
    bgPaper:init("ui_deformation_paper.png")
    bgPaper:leftBottom(511, 47)
    self._bg:addChild(bgPaper)

    -- 特殊外形勾选框
    local specialOutfitCheckBox = UI.CheckBox:create() 
    specialOutfitCheckBox:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_1.png", 0.65)
    specialOutfitCheckBox:leftBottom(22, 431)
    bgPaper:addChild(specialOutfitCheckBox)
    specialOutfitCheckBox:addEventListener(UI.Event.CHECKBOX_STATUS_CHANGED, self, function(self, comp, isChecked)
        self._equipListView:setDisplaySpecialItemsOnly(isChecked)
    end)

    -- 特殊外形文字锚点
    local specialOutfitLabelAnchor = UI.Component:create()
    specialOutfitLabelAnchor:init()
    specialOutfitLabelAnchor:leftBottom(61, 449)
    bgPaper:addChild(specialOutfitLabelAnchor)

    -- 特殊外形文字
    local specialOutfitLabel = UI.Text:create()
    specialOutfitLabel:init(LanguageManager:getInstance():getLocalString(1111580), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45) --"仅显示特殊外形"
    specialOutfitLabel:setWidth(115)
    specialOutfitLabel:setLineSpacing(-5)
    specialOutfitLabel:autoAdapt()
    specialOutfitLabel:centerLeft(0)
    specialOutfitLabelAnchor:addChild(specialOutfitLabel)

    -- 货币组件
    self._currencyPanel = UI.CurrencyPanel:create()
    self._currencyPanel:rightUp(135, 81 - 14.5 --[[货币组件空白高度大小]])
    self._currencyPanel:setShowShopButton(true, 52)
    self._currencyPanel:setShowGold(false)
    self._bg:addChild(self._currencyPanel, 100)

    -- 分割线
    local splitLine = UI.Image9:create()
    splitLine:init("ui_scale9image_banner_line_long.png", CCRectMake(20, 1, 1, 1), cc.size(319, 2))
    splitLine:centerBottom(428)
    bgPaper:addChild(splitLine)

    -- 装备列表版面
    require "app.ui.equipIllusionLayer.EquipIllusionListPanel"
    local width, height = self._bg:getSize()
    self._equipListView = UI.EquipIllusionListPanel:create(self)
    self._equipListView:init(nil, width, height)
    self._equipListView:center()
    self._bg:addChild(self._equipListView)
end

-- 模版函数：更新组建的视图(必备)
function EquipIllusionLayer:onUpdateView()
    -- 获取现在穿戴的装备表现, 并替换为幻化装备表现
    local displayWearList = clone(GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr)
    for j=#displayWearList, 1, -1 do
        local wearingEquipData = displayWearList[j]
        local wearingEquipIllusionID = wearingEquipData:getIllusionID()

        local foundSamePositionItemEntry = nil
        local foundSamePositionEquipData = nil
        for k,trialItemEntry in pairs(self._trialEntryTable) do
            local trialEquipType = AvalonUtil.getEquipmentTypeFromID(trialItemEntry.itemEquipID)
            if (trialEquipType == wearingEquipData:getEquipmentType()) then
                foundSamePositionItemEntry = trialItemEntry
                foundSamePositionEquipData = GoodsDataManager:createEquipmentForEquipmentID(trialItemEntry.itemEquipID)
                break
            end
        end

        if (foundSamePositionItemEntry) then
            if (foundSamePositionItemEntry.itemIllusionID ~= wearingEquipIllusionID) then
                -- 试穿表中找到同位置但是幻化不同的装备, 替换幻化
                table.remove(displayWearList, j)
                table.insert(displayWearList, foundSamePositionEquipData)
            end
        elseif (wearingEquipIllusionID ~= 0) then
            -- 试穿表中未找到同位置装备, 但是幻化ID不为0, 取消幻化表现.
            table.remove(displayWearList, j)
            local equipOriginalLook = GoodsDataManager:createEquipmentForEquipmentID(wearingEquipData:getGoodsID())
            table.insert(displayWearList, equipOriginalLook)
        end
    end

    -- 从幻化装备中找出武器来单独操作(接口需要)
    local weaponEquipmentData = nil
    for i = 1, #displayWearList do
        local equipmentData = displayWearList[i]
        local equipmentType = equipmentData:getEquipmentType()
        if (equipmentType == PublicDefine.EQUIPMENT_TYPE.Weapon) then
            weaponEquipmentData = equipmentData
        end
    end

    -- 更新角色动画
    self._roleAnimation:updateRoleEquipment(displayWearList)
    self._roleAnimation:showIDLEAnimation(weaponEquipmentData)

    -- 更新按钮价钱
    self:updateCost()

    -- 更新列表
    self:reloadEquipListView()
end

function EquipIllusionLayer:updateEquipListContentToIdx(idx)
    local equipType = self:getTabData()[idx]:getEqiupType()
    self:reloadEquipListView(equipType, true)
end

-- 换一个面板展现
function EquipIllusionLayer:showContentPanelByIndex(idx)
    -- 展现标签
    for i, w in ipairs(self._tabList) do
        if (w:getTag() ~= idx) then 
            w:release() 
        else
            w:press(false)
        end
    end

    -- 过滤相同标签点击逻辑
    if (self._showingTabIdx == idx) then return end
    self._showingTabIdx = idx

    self:updateEquipListContentToIdx(self._showingTabIdx)
end

-- 获取TAB数据的方法
function EquipIllusionLayer:getTabData()
    return TAB_DATA
end

-- 添加一个试穿装备
function EquipIllusionLayer:addTrialEquipData(itemEntryToAdd)
    printInfo("EquipIllusionLayer:addTrialEquipData 添加试穿数据", itemEntryToAdd.itemIllusionID)
    local equipTypeToAdd = AvalonUtil.getEquipmentTypeFromID(itemEntryToAdd.itemEquipID)
    for k,itemEntry in pairs(self._trialEntryTable) do
        local equipTypeToCheck = AvalonUtil.getEquipmentTypeFromID(itemEntry.itemEquipID)
        if (itemEntryToAdd.itemIllusionID ~= itemEntry.itemIllusionID and equipTypeToAdd == equipTypeToCheck) then
            self:removeTrialEquipData(itemEntry)
        end
    end

    self._trialEntryTable[itemEntryToAdd.itemIllusionID] = clone(itemEntryToAdd)
end

-- 清除一个试穿装备
function EquipIllusionLayer:removeTrialEquipData(itemEntryToRemove)
    if (not self._trialEntryTable[itemEntryToRemove.itemIllusionID]) then return end
    printInfo("EquipIllusionLayer:removeTrialEquipData 移除试穿数据", itemEntryToRemove.itemIllusionID)

    self._trialEntryTable[itemEntryToRemove.itemIllusionID] = nil
end

-- 更新总价钱
function EquipIllusionLayer:updateCost()
    local cost = self:getCostFromTrialData()
    if (cost > 0) then
        self._magicChangeDiamond0_0:show()
        self._magicChangePriceText0_0:show()
        self._magicChangePriceText0_0:setText(cost)
    else
        self._magicChangeDiamond0_0:hide()
        self._magicChangePriceText0_0:hide()
    end
    self:updateBtnState()
end

-- 获取试穿装备的总价钱
function EquipIllusionLayer:getCostFromTrialData()
    local cost = 0
    for k,v in pairs(self._trialEntryTable) do
        if (not v.itemIsBought) then
            cost = cost + v.itemPrice
        end
    end
    return cost
end

-- 更新按钮状态
function EquipIllusionLayer:updateBtnState()
    -- 变换按钮和试穿按钮
    if (self:isTrialAndWearingDifferent()) then
        self._clearTrialBtn:enable()
        self._btnMagicChangeCloth0_0:enable()
    else
        self._clearTrialBtn:disable()
        self._btnMagicChangeCloth0_0:disable()
    end

    -- 重置按钮
    local isWearingIllusion = false
    local displayWearList = GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr
    for i,v in ipairs(displayWearList) do
        if (v:getIllusionID() ~= 0 and v:getIllusionID() ~= nil) then
            isWearingIllusion = true
            break
        end
    end
    self._resetBtn:setVisible(isWearingIllusion)
    self._resetBtn:setTouchEnable(isWearingIllusion)
end

-- 返回是否试穿和身上的装备有差别
function EquipIllusionLayer:isTrialAndWearingDifferent(differentCallback)
    local displayWearList = clone(GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr)
    local isDifferent = false
    for j=#displayWearList, 1, -1 do
        local wearingEquipData = displayWearList[j]
        local wearingEquipIllusionID = wearingEquipData:getIllusionID()

        local foundSamePositionItemEntry = nil
        for k,trialItemEntry in pairs(self._trialEntryTable) do
            local trialEquipType = AvalonUtil.getEquipmentTypeFromID(trialItemEntry.itemEquipID)
            if (trialEquipType == wearingEquipData:getEquipmentType()) then
                foundSamePositionItemEntry = trialItemEntry
                break
            end
        end

        if (foundSamePositionItemEntry) then
            if (foundSamePositionItemEntry.itemIllusionID ~= wearingEquipIllusionID) then
                if (differentCallback) then differentCallback(foundSamePositionItemEntry, wearingEquipData) end
                isDifferent = true
            end
        elseif (wearingEquipIllusionID ~= 0) then
            if (differentCallback) then differentCallback(foundSamePositionItemEntry, wearingEquipData) end
            isDifferent = true
        end
    end
    return isDifferent
end

-- 从身上装备的幻化中获取一个试穿表
function EquipIllusionLayer:getTrialDataTableFromWearing()
    local trialEntryTable = {}
    local originalWearList = clone(GameDataManager:getInstance():getWearEquipmentData().wearEquipmentArr)
    for i,v in ipairs(originalWearList) do
        local illusionID = v:getIllusionID()
        if (illusionID ~= 0) then
            local entry = EquipIllusionDataManager:getItemEntryForDisplayByID(illusionID)
            trialEntryTable[illusionID] = entry
        end
    end
    return trialEntryTable
end

-- 重新加载装备选取列表, 可设置装备类型
function EquipIllusionLayer:reloadEquipListView(equipType, isReloadDisplayData)
    self._equipListView:reloadDataAndView(self._trialEntryTable, equipType, nil, isReloadDisplayData)
end

-- 轻刷新界面
function EquipIllusionLayer:updateRoleAnimationAndEquipListView()
    -- 更新界面显示
    self:updateView()

    -- 更新英雄头像
    local masterData = RoleDataManager:getMaster()
    if (masterData) then
        Avalon.MessageCenter:notice(AvalonMessage.MC_COMMON_SHOW_MASTER, masterData)
    end
end

-- 事件处理 --
---------------------------------------
function EquipIllusionLayer:onEquipIllusionInfoUpdate()
    self._trialEntryTable = self:getTrialDataTableFromWearing()
    self._equipListView:reloadDataAndView(self._trialEntryTable, nil, true)
    self:updateCost()
end

function EquipIllusionLayer:onEquipIllusionWearResult(isSucc, data)
    -- 尽量不刷多次
    if (isSucc) then
        if (data.illusionID ~= 0 and data.illusionID ~= nil) then
            self._trialEntryTable[data.illusionID].itemIsBought = true
            self._equipListView:setBoughtForIllusionID(data.illusionID, true)
        end
        Avalon.Scheduler:setDelayForUpdateOnce(self, self.updateRoleAnimationAndEquipListView, 0.5)
    end
end

function EquipIllusionLayer:registerListener()
    Avalon.MessageCenter:bind(GameMessage.MC_GOODS_EQUIP_ILLUSION_UPDATED, self,self.onEquipIllusionInfoUpdate)
    Avalon.MessageCenter:bind(GameMessage.MC_GOODS_EQUIP_ILLUSION_WEAR_RESULT, self,self.onEquipIllusionWearResult)
end

function EquipIllusionLayer:unregisterListener()
    Avalon.MessageCenter:unbind(GameMessage.MC_GOODS_EQUIP_ILLUSION_UPDATED, self,self.onEquipIllusionInfoUpdate)
    Avalon.MessageCenter:unbind(GameMessage.MC_GOODS_EQUIP_ILLUSION_WEAR_RESULT, self,self.onEquipIllusionWearResult)
end
---------------------------------------
-- eo 事件处理 --
