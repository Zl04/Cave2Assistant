------------------------------------------------------------------------------
--author: ping.zhengping.zhengping.zheng
--date	: 2019/05/14
--desc	: 
------------------------------------------------------------------------------
require "app.ui.common.GridText"

local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local ExpeditionBagView = class("ExpeditionBagView", UI.HWBtnComponent)

local winSize = cc.Director:getInstance():getWinSize()
local GOODS_RARE = PublicDefine.GOODS_RARE
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

-- 资源
local COM_RES_LIST = {
}

local BAG_GOODS_LAYOUT = {
    -- 物品分类tab
    GOODS_LIST_TAB_BUTTON_SPACE = 3,
    GOODS_LIST_TAB_BUTTON_WIDTH = 56,
    GOODS_LIST_TAB_BUTTON_HEIGHT = 60,
    GOODS_LIST_TAB_WIDTH = 250,
    GOODS_LIST_TAB_HEIGHT = 60,
    GOODS_LIST_TAB_RIGHT = 78,

    -- 黄金
    MONEY_BG_LEFT = 16,
    MONEY_ICON_LEFT = 2,
    MONEY_TEXT_LEFT = 40,
    -- 钻石
    DIAMOND_BG_LEFT = 196,
    DIAMOND_ICON_LEFT = 182,
    DIAMOND_TEXT_LEFT = 220,

    -- 黄金，钻石文本信息
    MONEY_DIAMOND_TEXT_WIDTH = 130,
    MONEY_DIAMOND_TEXT_HEIGHT = 25,
}

local COM_WIDTH = 468
local COM_HEIGHT = 507
local layoutUtil

local SPRITE_BG ="ui_explore_package_paper3.png"

-- 物品分类的背景图片
local SPRITE_GRID_ALL_BOX_NORMAL = "ui_goods_button_bg_down_0.png"
local SPRITE_GRID_ALL_BOX_ACTIVE = "ui_goods_button_bg_down_1.png"
-- 所有物品分类的图片
local SPRITE_GRID_ALL_GOODS_BUTTON_NORMAL = "ui_goods_button_all_0.png"
local SPRITE_GRID_ALL_GOODS_BUTTON_ACTIVE = "ui_goods_button_all_1.png"
local SPRITE_GRID_EQUIP_BUTTON_NORMAL = "ui_goods_button_equip_0.png"
local SPRITE_GRID_EQUIP_BUTTON_ACTIVE = "ui_goods_button_equip_1.png"
local SPRITE_GRID_EQUIPMENT_BUTTON_NORMAL = "ui_goods_button_quipment_0.png"
local SPRITE_GRID_EQUIPMENT_BUTTON_ACTIVE = "ui_goods_button_quipment_1.png"
local SPRITE_GRID_ITEM_BUTTON_NORMAL = "ui_goods_button_prop_0.png"
local SPRITE_GRID_ITEM_BUTTON_ACTIVE = "ui_goods_button_prop_1.png"
local SPRITE_GRID_MATERIAL_BUTTON_NORMAL = "ui_goods_button_material_0.png"
local SPRITE_GRID_MATERIAL_BUTTON_ACTIVE = "ui_goods_button_material_1.png"
local SPRITE_GRID_GEM_STONE_BUTTON_NORMAL = "ui_goods_button_gem_0.png"
local SPRITE_GRID_GEM_STONE_BUTTON_ACTIVE = "ui_goods_button_gem_1.png"
-- 黄金，钻石的背景
-- 黄金，钻石的图片
local SPRITE_GAMING_MOMEY   = "symbol_gaming_money.png"
local SPRITE_GAMING_EXP = "symbol_gaming_xp.png"
local SPRITE_GAMING_NAVI_GOLD = "symbol_material_navigationgold.png"

-- 功能按钮
local SPRITE_GRID_DELETE_BUTTON_BG = "ui_goods_button_bg_up_0.png"
local SPRITE_GRID_DELETE_BUTTON_ACTIVE_BG = "ui_goods_button_bg_up_1.png"
local SPRITE_GRID_DELETE_BUTTON_DISABLE_BG = "ui_goods_button_bg_up_0.png"

local SPRITE_FUNCTION_DUSTBIN_NORMAL = "ui_goods_button_dustbin_0.png"
local SPRITE_FUNCTION_DUSTBIN_ACTIVE = "ui_goods_button_dustbin_1.png"
local SPRITE_FUNCTION_SELL_NORMAL = "ui_goods_button_sell_0.png"
local SPRITE_FUNCTION_SELL_DISABLE = "ui_goods_button_sell_2.png"
local SPRITE_FUNCTION_CHOICE_NORMAL = "ui_goods_button_choice_0.png"
local SPRITE_FUNCTION_CHOICE_ACTIVE = "ui_goods_button_choice_1.png"

local SPRITE_FUNCTION_CONFIRM = "ui_goods_button_hook.png"

-- 背包格子
local SPRITE_GAME_BACKPACK = "ui_goods_icon_backpack.png"

local ANIMATION_ACTIVE_BAGGRID_LIST = "animation"

local function refresHandleUseData(dataArr, repeatData, dragRepeatData)
    local handleKey = 0
    local handleNum = 0
    for i=#dataArr,1,-1 do
        local goodsData = dataArr[i]
        local nowKey = goodsData:getGoodsID()..":"..tostring(goodsData:getIsGolden())

        goodsData:setUseNum(0)
        if(handleKey ~= nowKey) then
            if(repeatData and repeatData[nowKey]) then
                handleKey = nowKey
                handleNum = repeatData[nowKey]

                if(dragRepeatData and dragRepeatData[nowKey]) then
                    handleNum = handleNum + dragRepeatData[nowKey]
                end
            else 
                if(dragRepeatData and dragRepeatData[nowKey]) then
                    handleKey = nowKey
                    handleNum = dragRepeatData[nowKey]
                end
            end
        end
        if(goodsData:getNum() >= handleNum) then 
            goodsData:setUseNum(handleNum)
            handleNum = 0
        else 
            goodsData:setUseNum(goodsData:getNum())
            handleNum = handleNum - goodsData:getNum()
        end
    end
end

local function refreshBagData(self)
    -- 处理过滤相关操作后的数据
    local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_SELL_OR_DESTORY_DATA)
    local dragRepeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..PublicDefine.PACKET_TYPE.PACKET_BAG)

    -- 穿戴列表
    for k,goodsData in pairs(self._data.wearEquipmentArr) do
        goodsData:setUseNum(0)
        if(repeatData and repeatData[goodsData:getEntityID()]) then
            goodsData:setUseNum(repeatData[goodsData:getEntityID()])
        end

        if(dragRepeatData and dragRepeatData[goodsData:getEntityID()]) then
            goodsData:setUseNum(dragRepeatData[goodsData:getEntityID()])
        end
    end

    -- 拥有物品装备列表
    for k,goodsData in pairs(self._data.haveEquipmentArr) do
        goodsData:setUseNum(0)
        if(repeatData and repeatData[goodsData:getEntityID()]) then
            goodsData:setUseNum(repeatData[goodsData:getEntityID()])
        end
        if(dragRepeatData and dragRepeatData[goodsData:getEntityID()]) then
            goodsData:setUseNum(dragRepeatData[goodsData:getEntityID()])
        end
    end

    -- 拥有遗物列表
    for k,goodsData in pairs(self._data.haveRelicArr) do
        goodsData:setUseNum(0)
        if(repeatData and repeatData[goodsData:getEntityID()]) then
            goodsData:setUseNum(repeatData[goodsData:getEntityID()])
        end
        if(dragRepeatData and dragRepeatData[goodsData:getEntityID()]) then
            goodsData:setUseNum(dragRepeatData[goodsData:getEntityID()])
        end
    end

    refresHandleUseData(self._data.haveItemArr, repeatData, dragRepeatData)
    refresHandleUseData(self._data.haveMaterialArr, repeatData, dragRepeatData)
    refresHandleUseData(self._data.haveGemStoneArr, repeatData, dragRepeatData)
    refresHandleUseData(self._data.haveRelicArr, repeatData, dragRepeatData)

    -- 排序
    if self._usedType then
        for j = 1,#self._usedType do
            if self._usedType[j].sortFunc then
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
                    table.sort(self._data.haveEquipmentArr, self._usedType[j].sortFunc)
                end
            end
        end
    end
end

-- 显示物品
local function showGoodsByTabIndex(self, tabIndex)
    -- print("showGoodsByTabIndex",tabIndex)
    -- print(debug.traceback())
    if (self._data) then
        -- 过滤卖出或销毁的数据
        refreshBagData(self)

        self._bagGridList:setData(self._data)
        -- print("showGoodsByTabIndex tabIndex=",tabIndex)

        if self._showWear then
            if (tabIndex == 1) then
                self._bagGridList:showAllGoods()
            elseif (tabIndex == 2) then
                self._bagGridList:showEquip()
            elseif (tabIndex == 3) then
                self._bagGridList:showEquipments()
            elseif (tabIndex == 4) then
                self._bagGridList:showItems()
            elseif (tabIndex == 5) then
                self._bagGridList:showMaterials()
            elseif (tabIndex == 6) then
                self._bagGridList:showGemStone()
            else
                printError(string.format("RolePanel showGoodsByTabIndex: tab index %d is invalid.", tabIndex))
            end
        else
            if (tabIndex == 1) then
                self._bagGridList:showAllGoods()
            elseif (tabIndex == 2) then
                self._bagGridList:showEquipments()
            elseif (tabIndex == 3) then
                self._bagGridList:showItems()
            elseif (tabIndex == 4) then
                self._bagGridList:showMaterials()
            elseif (tabIndex == 5) then
                self._bagGridList:showGemStone()
            else
                printError(string.format("RolePanel showGoodsByTabIndex: tab index %d is invalid.", tabIndex))
            end
        end

        -- 如果处于删除状态
        if (self._deleteState) then
            self._bagGridList:showChoiceStatus()
            self._bagGridList:refrehDeleteGrid(self._choiceTable, true)
        end

        self._bagGridList:updataGridCanUseState(self._checkItemUseState, self._useLock, self._deleteState, self._usedType)
    end
end

local function refreshDeleteView(self)
    self._bagGridList:refrehDeleteGrid(self._choiceTable, true)
end

local function refreshAllGridCanUseState(self)
    self._bagGridList:updataGridCanUseState(self._checkItemUseState, self._useLock, self._deleteState, self._usedType)
end

function ExpeditionBagView:updataGridCanUseState(grid)
    local gridData = grid:getData()
    if gridData == nil then
        return
    end

    --大秘境锁 钥匙
    if GameDataManager:getInstance():getLockDungeonKey() == gridData:getGoodsID() then
        grid:updateCanUseState(false)
        return
    end
    if gridData and self._useLock == false and gridData:getIsLock() == true then
        grid:updateCanUseState(false)
    else
        if self._checkItemUseState then
            local isItem = gridData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_ITEM
            if (isItem and not grid:canUse()) then
                grid:updateCanUseState(false)
                return
            else
                grid:updateCanUseState(true)
            end
        end

        if(self._usedType == nil) then
            grid:updateCanUseState(true)
            return 
        end

        if gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
                    if self._usedType[j].type == 0 or gridData:getEquipmentType() == self._usedType[j].type then
                        if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                            if self._usedType[j].needConvert then
                                if Config.Manager:getEquipConvert(gridData:getId()) then
                                    mark = true 
                                end
                            elseif self._usedType[j].needRecast then
                                if gridData:getEquipRecastData() ~= nil then
                                    mark = true 
                                end
                            else
                                mark = true    
                            end
                            
                            break
                        end
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end

        elseif gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_ITEM then
                    if self._usedType[j].type == 0 or gridData:getItemType() == self._usedType[j].type then
                        if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                            mark = true
                            break
                        end
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        elseif gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE  then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                    self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_TREASURE  then
                    if self._usedType[j].type == 0 or gridData:getMaterialType() == self._usedType[j].type then
                        if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                            mark = true
                            break
                        end
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        elseif gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
                    if self._usedType[j].type == 0 or gridData:getGemStoneType() == self._usedType[j].type then
                        if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
                            if(self._usedType[j].heroLevel == nil or gridData:getRequireLevel() <= self._usedType[j].heroLevel) then
                                -- if(self._usedType[j].stoneLV == nil or gridData:getStoneLV() <= self._usedType[j].stoneLV) then
                                if (self._usedType[j].stoneLockMaxLV == nil or gridData:getNextLVID() ~= 0) then
                                    -- print("gridData:getNextLVID() ----- = "..gridData:getNextLVID())
                                    if (self._usedType[j].stoneShowLV == nil or self._usedType[j].stoneShowLV == gridData:getStoneLV() ) then
                                        if (self._usedType[j].transDropGroupID == nil or self._usedType[j].transDropGroupID == gridData:getTransDropGroupID()) then 
                                            if (self._usedType[j].gemStoneType == nil or self._usedType[j].gemStoneType == gridData:getGemStoneType()) then 
                                                mark = true
                                                break
                                            end
                                        end
                                    end 
                                end 
                            end
                        end
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        end
    end
end

-- 更新整个列表
local function updateGridList(self, data)
    -- print("ExpeditionBagView  updateGridList ", self._tabIndex, self._refreshFlag)
    if (data) then
        if self._refreshFlag then 
            if (self._tabIndex <= 0) then
                self._tabIndex = 1
                showGoodsByTabIndex(self, 1)
            else
                showGoodsByTabIndex(self, self._tabIndex)
            end

            local maxCount = data.packetBoxBeUseNum
            local usedCount = #data.haveEquipmentArr + #data.haveItemArr + #data.haveMaterialArr + #data.haveGemStoneArr + #data.haveRelicArr
        end
    end
end

-- 解锁背包格子
local function onUnlockBagGridHandler(self)
    self._data = GameDataManager:getInstance():getPacketBoxData()
    refreshBagData(self)

    local data = self._data
     -- 更新格子数据
    local availableCount = data.packetBoxBeUseNum
    local usedCount = #data.haveEquipmentArr + #data.haveItemArr + #data.haveMaterialArr + #data.haveGemStoneArr

    self._waitingRefreshGrid = 2
    -- updateGridList(self, self._data)

    self._bagGridList:updateGridCount()
end

-- 更新装备列表的处理器
local function onUpdateEquipmentListHandler(self, equipmentDataList)
    -- print(string.format("ExpeditionBagView onUpdateEquipmentListHandler: equipment data count %d.", #equipmentDataList))

    if (equipmentDataList) then
        self._data.haveEquipmentArr = equipmentDataList

        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        printError("ExpeditionBagView onUpdateEquipmentListHandler  equipmentDataList is nil.")
    end
end

-- 更新道具列表的处理器
local function onUpdateItemListHandler(self, itemDataList)
    -- print(string.format("ExpeditionBagView onUpdateItemListHandler: item data count %d.", #itemDataList))

    if (itemDataList) then
        self._data.haveItemArr = itemDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        printError("ExpeditionBagView onUpdateItemListHandler  itemDataList is nil.")
    end
end

-- 更新材料列表的处理器
local function onUpdateMaterialListHandler(self, materialDataList)
    -- print(string.format("ExpeditionBagView onUpdateMaterialListHandler: material data count %d.", #materialDataList))

    if (materialDataList) then
        self._data.haveMaterialArr = materialDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        printError("ExpeditionBagView onUpdateMaterialListHandler  materialDataList is nil.")
    end
end

-- 更新宝石列表的处理器
local function onUpdateGemStoneListHandler(self, gemStoneDataList)
    -- print(string.format("ExpeditionBagView onUpdateGemStoneListHandler: gemStone data count %d.", #gemStoneDataList))

    if (gemStoneDataList) then
        self._data.haveGemStoneArr = gemStoneDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        printError("ExpeditionBagView onUpdateGemStoneListHandler  gemStoneDataList is nil.")
    end
end

-- 穿戴的装备发生变化
local function onWearEquipmentChangedHandler(self, wearEquipmentData)
    if (wearEquipmentData and self._data) then
        if(wearEquipmentData.spriteID == self._data.spriteID) then
            -- print(string.format("BagGridList onWearEquipmentChangedHandler: refresh equipments."))
            self._data.wearEquipmentArr = wearEquipmentData.wearEquipmentArr
            self._waitingRefreshGrid = 2
            -- updateGridList(self,self._data)
        end
    else
        printError("ExpeditionBagView onWearEquipmentChangedHandler  wearEquipmentData is nil.")
    end
end

-- 更新遗物列表的处理器
local function onUpdateRelicListHandler(self, relicDataList)
    -- print(string.format("BagGoodsPanel onUpdateRelicListHandler: equipment data count %d.", #relicDataList))

    if (relicDataList) then
        self._data.haveRelicArr = relicDataList

        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
    else
        printError("BagGoodsPanel onUpdateRelicListHandler  equipmentDataList is nil.")
    end
end

local function onCurrencyChangeHandler(self, data)
    if (data) then
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

        if(data.costType == GOODS_COST_TYPE.GOLD) then
           
            self._momey:addChild(text)
        elseif data.costType == GOODS_COST_TYPE.GEM then
            
            self._diamond:addChild(text)
        elseif data.costType == GOODS_COST_TYPE.EXP then
            
            self._diamond:addChild(text)
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

-- 选择不同类型的goods
local function onActiveGoodsTabHandler(self, tabIndex)
    -- print(string.format("onActiveGoodsTabHandler tabIndex=%d",tabIndex))
    if (self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
    end

    self._tabIndex = tabIndex
    showGoodsByTabIndex(self, tabIndex)
end

-- 取消所有删除选中标志
local function cancelAllDeleteChoice(self)
    self:resetCheckBox()
    self._bagGridList:refrehDeleteGrid(nil, true)
end

local function cancelDeleteState(self)
    self._deleteButtonBG:setSpriteName(SPRITE_GRID_DELETE_BUTTON_BG)
    self._deleteButton:setSpriteName(self:getDeleteNormal())
    self._deleteButton:updateView()

    self.receiveButton:enable()
    self.resolveButton:enable()
    -- self.receiveButton:setVisible(self._bagType ~= PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE)
    -- self.resolveButton:setVisible(self._bagType ~= PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE)
    
    self.receiveButton:setVisible(self:isNewBagNeedShow())
    self.resolveButton:setVisible(self:isNewBagNeedShow())
    
    self._bagGridList:updateCanDrag(true)
    self:resetCheckBox()

    -- 更新锁定表现逻辑
    if(self._externalUseLock == false) then
        self._useLock = false
    else
        self._useLock = true
    end

    -- updateGridList(self,self._data)

    -- self:updateView()
    self._deleteState = false
    self._isDeleting = false

    self._bagGridList:hideChoiceStatus()
    self._bagGridList:hideDestory()

    if(self._sellGarbage) then
        self._sellGarbage:setTouchEnable(true)
    end

    self:setInterceptTouches(false)

    -- 恢复规则
    self._usedType = self._oldUseType
    self._useLock = self._oldUserLock

    self._oldUseType = nil
    self._oldUserLock = false

    -- 刷新显示
    -- refreshAllGridCanUseState(self)
    updateGridList(self, self._data)

    self._bagGridList:hideChoiceStatus()
    self._bagGridList:hideDestory()
end

local function onActiveStartDelete(self)
    -- 在查看装备时，点击删除按钮，选中的动画不消失
    self._bagGridList:showChoiceStatus()
    self._bagGridList:showDestory()
    self.receiveButton:disable()
    self.resolveButton:disable()
    self.receiveButton:setVisible(false)
    self.resolveButton:setVisible(false)
    self.goldCheckBox:setVisible(true)
    self.goldUpCheckBox:setVisible(true)
    self._deleteState = true
    self:refreshCheckStatus()
        
    if  self._selectedBagGrid then 
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end

    self._bagGridList:updateCanDrag(false)

    -- 更新锁定表现逻辑
    -- self:setUseLock(false)
    -- self._useLock = false

    updateGridList(self,self._data)
    -- self:updateView()

    self._choiceTable = {}
    self._bagGridList:refrehDeleteGrid(self._choiceTable, false)
    self._deleteButtonBG:setSpriteName(SPRITE_GRID_DELETE_BUTTON_ACTIVE_BG)
    self._deleteButton:setSpriteName(self:getDeleteClick())
    self._deleteButton:updateView()

    -- 设置吞噬事件
    self:setInterceptTouches(true)

    if(self._sellGarbage) then
        self._sellGarbage:setTouchEnable(false)
    end
    
    -- 关闭拖动
    self._isDeleting = true

    -- 重置规则
    self._oldUseType = self._usedType
    self._oldUserLock = self._useLock

    self._usedType = nil
    self._useLock = false

    -- 刷新显示
    -- refreshAllGridCanUseState(self)
    updateGridList(self, self._data)
end

--[[
    type: 1 金色，2 金色以上 3 全部
    isCheck: 是否选中
]] 
local function quickChoiceHandle(self, type, isCheck)
    if(not self.updateCheckStatus) then 
        return 
    end

    local gridDataList = self._bagGridList:getShowDataArr()
    if (gridDataList) then
        local choiceNum = 0

        for i = 1, #gridDataList do
            -- local bagGrid = gridList[i]
            local gridData = gridDataList[i]
            local handle = false
            if gridData 
                and UI.GoodsGrid:calculationUseState(gridData) 
            then 
                if(type == 3) then 
                    handle = true
                elseif(type == 1 and ( gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)) then  
                    if(gridData:getGoodsRare() == PublicDefine.GOODS_RARE.RARE_GOLDEN_3) then 
                        handle = true
                    end
                elseif(type == 2 and ( gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)) then  
                    if(gridData:getGoodsRare() > PublicDefine.GOODS_RARE.RARE_GOLDEN_3) then 
                        handle = true
                    end
                end
            end
            
            if(handle) then
                choiceNum = choiceNum + 1
                if isCheck then
                    local found = false
                    for i=#self._choiceTable, 1, -1 do 
                        if self._choiceTable[i] == gridData then 
                            found = true
                            break
                        end 
                    end         
                    if(not found) then
                        table.insert(self._choiceTable, gridData)
                    end           
                else 
                    for i=#self._choiceTable, 1, -1 do 
                        if self._choiceTable[i] == gridData then 
                            table.remove(self._choiceTable, i) 
                            break
                        end 
                    end 
                end
            end
        end

        if(isCheck and choiceNum == 0) then 
            UI.ScrollBar:createByText(UI.TEXT_1212599)
            self.updateCheckStatus = false
            if(type == 1) then 
                self.goldCheckBox:getChildByName("boxItself"):setValue(allGoldChoice)
            end
            if(type == 2) then 
                self.goldUpCheckBox:getChildByName("boxItself"):setValue(allGoldUpChoice)
            end
            if(type == 3) then 
                self.allCheckBox:getChildByName("boxItself"):setValue(allChoice)
            end
            self.updateCheckStatus = true
        end

        if(choiceNum >0 and self._deleteState) then 
            if #self._choiceTable == 0 then 
                self._deleteButton:setSpriteName(self:getDeleteClick())
            else 
                self._deleteButton:setSpriteName(self:getDeleteConfirm())
            end 
        end

        self:refresBtnText()
        self._bagGridList:refrehDeleteGrid(self._choiceTable, true)
    end
end

local function cancelAllMulChoice(self)
    self._bagGridList:refrehDeleteGrid(nil, true)

    self:setUsedType(nil)
end

local function cancelMulChoiceState(self)
    self._bagGridList:updateCanDrag(true)
    self._deleteButtonBG:setVisible(self:isNewBagNeedShow())
    self._deleteButtonBG:setTouchEnable(self:isNewBagNeedShow())

    -- 更新锁定表现逻辑
    if(self._externalUseLock == false) then
        self._useLock = false
    else
        self._useLock = true
    end

    -- updateGridList(self,self._data)

    -- self:updateView()
    self._isReceive = false
    self._isResolve = false
    self.resolveButton:setVisible(self:isNewBagNeedShow())
    self.receiveButton:setVisible(self:isNewBagNeedShow())
    self.resolveButton:setText(UI.TEXT_1212933)
    self.receiveButton:setText(UI.TEXT_1212582)
    self.resolveButton:enable()
    self.receiveButton:enable()
    self:resetCheckBox()
    
    self._bagGridList:hideChoiceStatus()
    self._bagGridList:hideDestory()

    if(self._sellGarbage) then
        self._sellGarbage:setTouchEnable(true)
    end

    self:setInterceptTouches(false)

    -- 恢复规则
    self._usedType = self._oldUseType
    self._useLock = self._oldUserLock

    self._oldUseType = nil
    self._oldUserLock = false

    -- 刷新显示
    -- refreshAllGridCanUseState(self)
    updateGridList(self, self._data)

    self._bagGridList:hideChoiceStatus()
    self._bagGridList:hideDestory()
end

local function onActiveStartMulChoice(self)
    -- 在查看装备时，点击删除按钮，选中的动画不消失
    self._bagGridList:showChoiceStatus()
    self._bagGridList:showDestory()
    self._deleteButtonBG:setVisible(false)
        
    if  self._selectedBagGrid then 
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
    self._bagGridList:updateCanDrag(false)
    updateGridList(self,self._data)
    self._choiceTable = {}
    -- 设置吞噬事件
    self:setInterceptTouches(true)
    
    -- 关闭拖动
    self._isDeleting = true

    -- 重置规则
    self._oldUseType = self._usedType
    self._oldUserLock = self._useLock

    self._useLock = false

    -- 刷新显示
    -- refreshAllGridCanUseState(self)
    updateGridList(self, self._data)
    self:refresBtnText()
end

-- 删除装备按钮点击处理器
local function onActiveDeleteButtonHandler(self)
    if(self._isReceive or self._isResolve) then 
        return 
    end

    if not self:checkHandleStatus() then 
        if(SceneManager:getInstance():isInFightScene())then 
            UI.ScrollBar:createByText(UI.TEXT_1213411)
        else 
            UI.ScrollBar:createByText(UI.TEXT_1212579)
        end
        return 
    end
    -- print("onActiveDeleteButtonHandler 2")
    Avalon.AudioManager:playSound("1503")
    if self._deleteState == false then 
        onActiveStartDelete(self)
    else
        UI.TipsLayer:createDestoryGemStoneTips(self._choiceTable, function() 
            local isSell = true

            UI.TipsLayer:createLostEscapeScrollTips(self._choiceTable, isSell, function()
                cancelDeleteState(self)
                -- 点中后开始删除
                if #self._choiceTable > 0 then 
                    -- if(self._type == GameBagUIType.CAVE_SHOP) then
                    --     cancelAllDeleteChoice(self)
                    --     if (RoleBehaviorManager:caveShopSellItemCheck()) then 
                    --         GameManager:sellGoodsArrHandler(self._choiceTable, self._spriteID, handler(self, function()
                    --             for k, goodsData in pairs(self._choiceTable) do 
                    --                 goodsData:setUseNum(goodsData:getNum())
                    --             end
                    --             refreshDeleteView(self)
                    --         end))
                    --         Avalon.AudioManager:playSound("1504")
                    --     end 
                    -- elseif ( self._type == GameBagUIType.BLACK_SHOP) then
                    --     cancelAllDeleteChoice(self)
                    --     if (RoleBehaviorManager:blackShopSellItemCheck()) then 
                    --         -- GameManager:sellGoodsArrHandler(self._choiceTable, self._spriteID, handler(self, function()
                    --         --     for k, goodsData in pairs(self._choiceTable) do 
                    --         --         goodsData:setUseNum(goodsData:getNum())
                    --         --     end
                    --         --     refreshDeleteView(self)
                    --         -- end))
                    --         Avalon.AudioManager:playSound("1504")
                    --     end 
                    -- else
                    --     if (RoleBehaviorManager:lostItemCheck()) then 

                            local data = {}
                            data.packetType = self._bagType
                            data.goodsArr = {}
                            for k,v in pairs(self._choiceTable) do 
                                table.insert(data.goodsArr, v)
                            end
                            data.callback = handler(self, function()
                                if(not tolua.isnull(self)) then
                                    for k, goodsData in pairs(self._choiceTable) do 
                                        goodsData:setUseNum(goodsData:getNum())
                                    end
                                    refreshDeleteView(self)
                                end
                            end)
                            data.cancelCallBack = handler(self, function()
                                if(not tolua.isnull(self)) then
                                    self._choiceTable = {}
                                    refreshDeleteView(self)
                                end
                            end)

                            mvc.send(mvc.events.Expedition_Sell_Goods, data)
                            self:resetCheckBox()

                            -- GameManager:bagLostGoodsHandler(self._choiceTable, handler(self, function()
                            --     for k, goodsData in pairs(self._choiceTable) do 
                            --         goodsData:setUseNum(goodsData:getNum())
                            --     end
                            --     refreshDeleteView(self)
                            -- end))
                        -- end 
                    -- end
                end
                -- 删除后，把纪录上次点击的格子清空
                self._selectedBagGrid = nil 
                -- 打开拖动
            end)
        end)
    end

end

-- 装备详情的touch事件的处理
local function onInfoAreaTouchHandler(self,obj,touchPosition)
    if obj and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    -- 更新装备对比区域数据
    if(not tolua.isnull(self._infoArea)) then
        self._infoArea:close()
        self._infoArea = nil
    end
    if (not tolua.isnull(self._selectedBagGrid)) then
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
end


function ExpeditionBagView:ctor()
    ExpeditionBagView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
    self.updateCheckStatus = true
    self._contentLayout = nil
    self._type = GameBagUIType.CAVE_SHOP
    self._momeyPreNum = 0;
    self._diamondPreNum = 0
    self.preExpedtionStatus = mvc.expeditionModel:getExpeditionStatus()
    -- 是否领取中
    self._isReceive = false
    -- 是否分解中
    self._isResolve = false

    -- 存放要删除的格子
    self._choiceTable = {}
    -- 上一次选中的背包格子，上一次选中人物的格子
    self._selectedBagGrid = nil
    self._selectedRoleGrid = nil
    -- 是否正在拖拽
    self._isDraging = false
    -- 是否处于删除状态
    self._isDeleting = false
    -- 是否正在滚动背包
    self._isScrolling = false

    self._deleteState = false
    self._enableDragStatus = true

    self._tabIndex = 1
    -- 一键删除
    self._sellGarbage = nil

    self._externalUseLock = true
    self._useLock = true
    self._refreshFlag = true
    -- 等待刷新背包格子
    self._waitingRefreshGrid = -1

    -- 测试冒数字
    -- for i=1,20 do
    --     Avalon.Scheduler:scheduleUpdateOnce(self, function()
    --         local data = {}
    --         data.costType = GOODS_COST_TYPE.GOLD
    --         data.value = 777
    --         Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, data)
    --     end, 3*i)
    -- end


    --玩家的操作{operationType = "add/remove",itemType = "equip/item/material",id="1",num="1/-1"}
    self._operationList = {}
    self._operationList[PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT] = {}
    self._operationList[PublicDefine.GOODS_TYPE.GOODS_ITEM] = {}
    self._operationList[PublicDefine.GOODS_TYPE.GOODS_MATERIAL] = {}
    self._operationList[PublicDefine.GOODS_TYPE.GOODS_GEM_STONE] = {}
    self._operationList[PublicDefine.GOODS_TYPE.GOODS_RELIC] = {}

    self._usedType = usedType

    --是否穿戴
    if showWear or showWear == nil then
        self._showWear = true
    else
        self._showWear = false
    end

    if checkItemUseState or checkItemUseState == nil then
        self._checkItemUseState = true
    else
        self._checkItemUseState = false
    end

    self:registerListener()
end

function ExpeditionBagView:dtor()
    ExpeditionBagView.super.dtor(self)
    self:unbindModel()
    -- reload_script_file_mvc("app.modules.expedition.ExpeditionBagView")

    self._contentLayout = nil

    self._itemdestroy = nil
    self._deleteButton = nil 
    self._selectedBagGrid = nil
    self._selectedRoleGrid = nil
    self._deleteState = false

    self._tabIndex = 1
    self._waitingRefreshGrid = -1

    for k,v in pairs(self._data.wearEquipmentArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveEquipmentArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveItemArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveMaterialArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveGemStoneArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveRelicArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    self:unRegisterListener()
end

-- public:
-- 初始化
function ExpeditionBagView:init(bagType, data)
    self._tabIndex = 1
    self._spriteID = spriteID
    self._type = GameBagUIType.BLACK_SHOP
    self._bagType = bagType

    -- 添加右边简洁背包数据
    --克隆背包数据
    self._data = data
    refreshBagData(self)

    ExpeditionBagView.super.init(self)
    -- self:setInterceptTouches(true)
end

function ExpeditionBagView:getBagType()
    return self._bagType
end

function ExpeditionBagView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 添加背景
    local imageBG = UI.Image:create()
    if(self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE) then 
        imageBG:init("ui_explore_package_paper5.png")
    else
        imageBG:init(SPRITE_BG)
    end
    imageBG:center()
    -- momeyImageBG:setPos(16,0)
    self._contentLayout:addChild(imageBG)

    self:setTouchEnable(true)
    -- self._contentLayout:setInterceptTouches(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self)
        -- print("ExpeditionBagView:onInitView  COMPONENT_TOUCH_OUTSIDE_ENDED", self._deleteState)
        if(self._deleteState) then
            cancelDeleteState(self)
            cancelAllDeleteChoice(self)
        elseif self._isReceive or self._isResolve then
            cancelMulChoiceState(self)
            cancelAllMulChoice(self)
        else
            self:close() 
            mvc.send(mvc.events.ExpeditionCloseBag)
        end
    end)

    -- 标题
    -- 
    local topName = "ui_explore_package_fast.png"
    local text = UI.TEXT_1212577
    local textColor = UI.FONT_COLOR_227_214_172
    if(self._bagType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then
        topName = "ui_explore_package_ordinary.png"
        text = UI.TEXT_1212577
    elseif(self._bagType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then 
        topName = "ui_explore_package_fast.png"
        text = UI.TEXT_1212578
    elseif(self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE) then 
        topName = "ui_explore_package_ordinary.png"
        text = UI.TEXT_221106
    elseif(self._bagType == PublicDefine.PACKET_TYPE.PACKET_SAIL) then 
        topName = "ui_explore_package_ordinary.png"
        text = UI.TEXT_221920
    end 

    local titleBg = UI.Image:create()
    titleBg:init(topName)
    if(self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE) then 
        titleBg:leftUp(23, 45)
    else
        titleBg:leftUp(23, 7)
    end
    
    
    self._contentLayout:addChild(titleBg)

    local titleText = UI.Text:create()
    titleText:init(text, UI.FONT_STANDARD, UI.FONT_SIZE_20PX, textColor)
    titleText:center()
    titleBg:addChild(titleText, 4)


    local bagList = UI.GoodsListNew:create(5)
    bagList:init(self._data, 290)
    if(self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE) then 
        bagList:setPos(14+3, 92)
    else
        bagList:setPos(14+3, 55)
    end
    
    bagList:setCallbackForGridClick(self, self.bagClickCallback)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    bagList:setDoubleClickAsDragEnd(true)
    bagList:hideBGImageCover()
    self._bagGridList = bagList
    self._contentLayout:addChild(bagList, 4)
    -- bagList:showMask()
    bagList:showAllGoods()

    local bgImageCover = UI.Image:create()
    if(self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE) then 
        bgImageCover:init("ui_explore_package_paper4.png")
    else
        bgImageCover:init("ui_explore_package_paper2.png")
    end
    -- bgImageCover:leftUp(2, -23)
    bagList:addChild(bgImageCover, -10)

    local bgUpImage = UI.Image:create()
    bgUpImage:init("ui_explore_package_paper1.png")
    bgUpImage:leftBottom(13, 117)
    bagList:addChild(bgUpImage, 100)

    -- 上边的分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(387, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    local posY = self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE and 370 or 408
    lineUpImage:setPosition(cc.p(27 + lineUpImage:getContentSize().width/2, posY))
    self._contentLayout:addChild(lineUpImage, 4)
    
    -- local lineDownImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    -- lineDownImage:setContentSize(387, 1)
    -- lineDownImage:setCapInsets(CCRectMake(1,0,1,1))
    -- lineDownImage:setPosition(cc.p(27 + lineDownImage:getContentSize().width/2, 508 - 6 - 370))
    -- self._contentLayout:addChild(lineDownImage, 4)

    -- 删除装备时高亮动画
    local itemdestroy = UI.Animation:create()
    itemdestroy:init(FX_ITEMDESTROY_JSON,FX_ITEMDESTROY_ATLAS)
    itemdestroy:centerLeft(218)
    -- itemdestroy:setAnimation("animation2", true)
    itemdestroy:hide()
    self._contentLayout:addChild(itemdestroy, 4)
    self._itemdestroy = itemdestroy


    local curreyY = self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE and 106 or 68
    -- 黄金
    local momeyImage = UI.Image:create()
    momeyImage:init(SPRITE_GAMING_MOMEY)
    momeyImage:leftUp(76, curreyY)
    self._contentLayout:addChild(momeyImage, 4)
    -- 黄金数量
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._momey:setTextLeft()
    -- self._momey:leftUp(76 + 28, curreyY)
    self._momey:centerLeft(momeyImage:getContentSize().width + 4)
    momeyImage:addChild(self._momey, 4)
    momeyImage:setVisible(self:isNewBagNeedShow())

    -- 远航金币
    local naviImage = UI.Image:create()
    naviImage:init(SPRITE_GAMING_NAVI_GOLD)
    naviImage:leftUp(76, curreyY)
    self._contentLayout:addChild(naviImage, 4)
    -- 远航金币数量
    self._naviGold = UI.Text:create()
    self._naviGold:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_250_229_177)
    self._naviGold:setTextLeft()
    -- self._naviGold:leftUp(220 + 28, curreyY)
    self._naviGold:centerLeft(naviImage:getContentSize().width + 4)
    naviImage:addChild(self._naviGold, 4)
    naviImage:setVisible(self._bagType == PublicDefine.PACKET_TYPE.PACKET_SAIL)

    -- 经验
    local diamondImage = UI.Image:create()
    diamondImage:init(SPRITE_GAMING_EXP)
    diamondImage:leftUp(220, curreyY)
    self._contentLayout:addChild(diamondImage, 4)
    -- 经验数量
    self._diamond = UI.Text:create()
    self._diamond:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._diamond:setTextLeft()
    -- self._diamond:leftUp(220 + 28, curreyY)
    self._diamond:centerLeft(diamondImage:getContentSize().width + 4)
    diamondImage:addChild(self._diamond, 4)
    diamondImage:setVisible(self:isNewBagNeedShow())

    local typeRight = 44

    -- 删除按钮
    local deleteButtonBG = UI.Image:create(nil, nil, UIType.TABITEM_BATCH_DELETE)
    deleteButtonBG:init(SPRITE_GRID_DELETE_BUTTON_BG)
    deleteButtonBG:rightUp(typeRight, 20)
    deleteButtonBG:setSize(55,38)
    local deleteButton = UI.Image:create()
    deleteButton:init(self:getDeleteNormal())
    deleteButton:center()
    deleteButtonBG:setTouchEnable(true)
    deleteButtonBG:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function (self)
        deleteButtonBG:setScale(1.1)
        deleteButton:setScale(1.1)
    end)
    deleteButtonBG:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function (self)
        deleteButtonBG:setScale(1.0)
        deleteButton:setScale(1.0)
    end)
    deleteButtonBG:addEventListener(UIEvent.COMPONENT_CLICK, self, onActiveDeleteButtonHandler)
    deleteButtonBG:addChild(deleteButton)
    self._contentLayout:addChild(deleteButtonBG)
    self._deleteButtonBG = deleteButtonBG
    self._deleteButton = deleteButton

    -- 修改坐标位置
    if self._type ~= GameBagUIType.CAVE_SHOP then
        deleteButtonBG:rightUp(typeRight,20)
    end

    self._tabIndex = 1

    local functionLayout = UI.Layout:create()
    functionLayout:init()
    functionLayout:setSize(392, 80)
    functionLayout:rightBottom(40, 24)
    self._contentLayout:addChild(functionLayout, 100)

    -- 不能操作的提示语言
    local noHandleText = UI.Text:create()
    noHandleText:init(UI.TEXT_1212579, UI.FONT_STANDARD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    noHandleText:center()
    functionLayout:addChild(noHandleText, 10)
    self.noHandleText = noHandleText
    noHandleText:setVisible(false)

    local offsetX = 0
    local offsetY = 46

    -- 所有的选择框 -- boxItself
    local centerOffset = 8
    local bianOffset = 10
    local goldCheckBox = self:createCheckBoxWithLabel(LanguageManager:getInstance():getLocalString(1111962), false, function(isCheck)
        if(self.goldCheckBox:isVisible()) then 
            quickChoiceHandle(self, 1, isCheck)
        end
    end, true)
    goldCheckBox:rightBottom(bianOffset, functionLayout:getContentSize().height/2 + centerOffset/2)
    functionLayout:addChild(goldCheckBox)
    self.goldCheckBox = goldCheckBox

    local goldUpCheckBox = self:createCheckBoxWithLabel(UI.TEXT_1212581, false, function(isCheck)
        if(self.goldUpCheckBox:isVisible()) then 
            quickChoiceHandle(self, 2, isCheck)
        end
    end, true)
    goldUpCheckBox:rightBottom(bianOffset, 2 + functionLayout:getContentSize().height/2 - goldCheckBox:getContentSize().height - centerOffset/2)
    functionLayout:addChild(goldUpCheckBox)
    self.goldUpCheckBox = goldUpCheckBox

    local allCheckBox = self:createCheckBoxWithLabel(UI.TEXT_1212580, false, function(isCheck)
        if(self.allCheckBox:isVisible()) then 
            quickChoiceHandle(self, 3, isCheck)
        end
    end, false)
    allCheckBox:centerLeft(bianOffset)
    functionLayout:addChild(allCheckBox)
    self.allCheckBox = allCheckBox

    self:resetCheckBox()

    -- 分解按钮
    local resolveButton = UI.Button:create()
    resolveButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    resolveButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if(self._deleteState) then 
            return 
        end
        
        Avalon.AudioManager:playSound("1503")
        if(self._isResolve) then 
            -- 处理分解的逻辑处理
            local needConfirm = false
            for k,v in pairs(self._choiceTable) do 
                if (v:getGoodsRare() >= PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4) then
                    needConfirm = true
                end
            end
            if(needConfirm) then
                UI.ConfirmDialog.showConfirmDialogCancelRedOkWhite(UI.TEXT_1212232, function()
                    self:handleResolve()
                end);
            else 
                self:handleResolve()
            end
            self:refreshCheckStatus()
        else
            self:resetCheckBox()
            self:refreshStatus()
            local usedTypeList = {}
            local _usedType1 = {}
            _usedType1.goodType = PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
            _usedType1.type = 0  --"all"
            table.insert(usedTypeList, _usedType1)
            self:setUsedType(usedTypeList)

            resolveButton:setText(UI.TEXT_1212933)
            self._deleteButtonBG:setTouchEnable(false)
            self.receiveButton:disable()
            self.receiveButton:setVisible(false)
            self._isResolve = true

            self.goldCheckBox:setVisible(true)
            self.goldUpCheckBox:setVisible(true)

            -- 进去选择界面
            onActiveStartMulChoice(self)
            self:refreshCheckStatus()
        end
    end)
    local languageType = LanguageManager:getInstance():getLanguage()
    if( languageType == cc.LANGUAGE_ENGLISH or languageType == cc.LANGUAGE_RUSSIAN) then 
        resolveButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    else
        resolveButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    end
    
    resolveButton:setText(UI.TEXT_1212933)
    resolveButton:centerLeft(offsetX)
    functionLayout:addChild(resolveButton, 10)
    self.resolveButton = resolveButton

    -- 领取按钮
    local receiveButton = UI.Button:create()
    receiveButton:init("ui_btn_yellow2_0.png", "ui_btn_yellow2_1.png", "ui_btn_yellow2_2.png")
    receiveButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        if(self._deleteState) then 
            return 
        end
        Avalon.AudioManager:playSound("1503")
        if(self._isReceive) then 
            local data = {}
            data.packetType = self._bagType
            data.goodsArr = {}
            for k,v in pairs(self._choiceTable) do 
                table.insert(data.goodsArr, v)
            end
            if(self._choiceTable and #data.goodsArr > 0 and GameDataManager:getInstance():getFreePacketBoxNum() == 0) then 
                UI.ScrollBar:createByText(UI.TEXT_1212011)
            end

            if(self._choiceTable and #data.goodsArr > 0 and GameDataManager:getInstance():getFreePacketBoxNum() >0) 
                or (not mvc.expeditionModel:getBagHaveGoodsForPacketType(self._bagType) 
                    and mvc.expeditionModel:getIsNotNullForPacketType(self._bagType)) then
                mvc.send(mvc.events.Expedition_Get_Reward, data)
            end

            -- 处理领取的逻辑处理
            self._deleteButtonBG:setTouchEnable(true)
            self.resolveButton:enable()
            self.resolveButton:setVisible(true)
            receiveButton:setText(UI.TEXT_1212582)
            self._isResolve = false
            self._choiceTable = {}
            self:resetCheckBox()

            cancelMulChoiceState(self)
            cancelAllMulChoice(self)
            self:refreshCheckStatus()
        else 
            -- 判断是否有物品，如果没有物品就直接领取金币
            if not mvc.expeditionModel:getBagHaveGoodsForPacketType(self._bagType) 
            and mvc.expeditionModel:getIsNotNullForPacketType(self._bagType) then 
                local data = {}
                data.packetType = self._bagType
                data.goodsArr = {}
                mvc.send(mvc.events.Expedition_Get_Reward, data)
            else 
                receiveButton:setText(UI.TEXT_1212582)
                self._deleteButtonBG:setTouchEnable(false)
                self.resolveButton:setVisible(false)
                self.resolveButton:disable()
                self._isReceive = true

                self.allCheckBox:setVisible(true)

                -- 进去选择界面
                onActiveStartMulChoice(self)
            end
            self:refreshCheckStatus()
        end
    end)
    local languageType = LanguageManager:getInstance():getLanguage()
    if( languageType == cc.LANGUAGE_ENGLISH or languageType == cc.LANGUAGE_RUSSIAN) then 
        receiveButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_50_50_44)
    else
        receiveButton:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_50_50_44)
    end
    receiveButton:setText(UI.TEXT_1212582)
    receiveButton:centerRight(offsetX)
    functionLayout:addChild(receiveButton, 10)
    self.receiveButton = receiveButton
    

    updateGridList(self,self._data)
    self:updateMoneyView()

    self:refreshDeleteButton()
    self:refreshSellButton()
    self:refreshStatus()
end

function ExpeditionBagView:handleResolve()
    self:setUsedType(nil)

    -- local data = {}
    -- data.packetType = self._bagType
    -- data.goodsArr = {}
    -- for k,v in pairs(self._choiceTable) do 
    --     table.insert(data.goodsArr, v)
    -- end
    -- if(data.goodsArr and #data.goodsArr > 0) then
    --     mvc.send(mvc.events.Expedition_Decompose, data)
    -- end
    -- cancelDeleteState(self)
    
    
    local data = {}
    data.packetType = self._bagType
    data.goodsArr = {}
    for k,v in pairs(self._choiceTable) do 
        table.insert(data.goodsArr, v)
    end
    if(data.goodsArr and #data.goodsArr > 0) then
        data.callback = handler(self, function()
            if(not tolua.isnull(self)) then
                for k, goodsData in pairs(self._choiceTable) do 
                    goodsData:setUseNum(goodsData:getNum())
                end
                self._choiceTable = {}
                refreshDeleteView(self)
            end
        end)
        data.cancelCallBack = handler(self, function()
            if(not tolua.isnull(self)) then
                self._choiceTable = {}
                refreshDeleteView(self)
            end
        end)

        mvc.send(mvc.events.Expedition_Sell_Goods, data)
    end

    self._deleteButtonBG:setTouchEnable(self:isNewBagNeedShow())
    self.receiveButton:enable()
    self.receiveButton:setVisible(self:isNewBagNeedShow())
    self.resolveButton:setText(UI.TEXT_1212933)
    self._isResolve = false
    self:resetCheckBox()

    cancelMulChoiceState(self)
    cancelAllMulChoice(self)

    self:refreshCheckStatus()
end

function ExpeditionBagView:checkHandleStatus()
    -- if(self._bagType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL 
    --     and mvc.expeditionModel:getExpeditionStatus()) then 
    --     return false
    -- end

    if(SceneManager:getInstance():isInFightScene()) then 
        return false
    end

    return true
end

function ExpeditionBagView:refreshStatus()
    if(SceneManager:getInstance():isInFightScene())then 
        self.noHandleText:setText(UI.TEXT_1213411)
    else
        self.noHandleText:setText(UI.TEXT_1212579)
    end

    if(not self:checkHandleStatus()) then 
        self.noHandleText:setVisible(true)
        self:resetCheckBox()
        self.resolveButton:setVisible(false)
        self.receiveButton:setVisible(false)
        self._deleteButtonBG:setVisible(false)
    else 
        self:resetCheckBox()
        self.noHandleText:setVisible(false)
        self.resolveButton:setVisible(self:isNewBagNeedShow())
        self.receiveButton:setVisible(self:isNewBagNeedShow())
        self._deleteButtonBG:setVisible(self:isNewBagNeedShow())
    end
    -- if(self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE) then
    --     self._deleteButtonBG:setVisible(false)
    --     self.receiveButton:setVisible(false)
    --     self.resolveButton:setVisible(false)
    -- end
    
end

function ExpeditionBagView:resetCheckBox()
    self.goldCheckBox:setVisible(false)
    self.goldUpCheckBox:setVisible(false)
    self.allCheckBox:setVisible(false)
    self.goldCheckBox:getChildByName("boxItself"):setValue(false)
    self.goldUpCheckBox:getChildByName("boxItself"):setValue(false)
    self.allCheckBox:getChildByName("boxItself"):setValue(false)
    self:refreshCheckStatus()
end

function ExpeditionBagView:bindModel()

end


function ExpeditionBagView:unbindModel()

end



function ExpeditionBagView:sellGoodsResult(data)
    if(data and data.result) then
        GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.SellGoodsResultType", data.result))
    end

    UI.WaitingLayer:hideWaiting()

    self._waitingRefreshGrid = 2
    -- updateGridList(self, self._data)
end

function ExpeditionBagView:loseGoodsResult()
    UI.WaitingLayer:hideWaiting()
    self._waitingRefreshGrid = 2
end


-- 刷新销毁按钮状态
function ExpeditionBagView:refreshDeleteButton()
    -- 恢复删除以及销毁表现
    -- local destoryRepeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_QUICK_BAG_DESTORY)
    -- if(destoryRepeatData) then
    --     self._deleteButtonBG:setSpriteName(SPRITE_GRID_DELETE_BUTTON_DISABLE_BG)
    --     self._deleteButton:setSpriteName(SPRITE_FUNCTION_CHOICE_DISABLE)
    --     self._deleteButtonBG:setTouchEnable(false)
    -- else 
    --     self._deleteButtonBG:setSpriteName(SPRITE_GRID_DELETE_BUTTON_BG)
    --     self._deleteButton:setSpriteName(SPRITE_FUNCTION_CHOICE_NORMAL)
    --     self._deleteButtonBG:setTouchEnable(true)
    -- end
end

-- 刷新卖按钮状态
function ExpeditionBagView:refreshSellButton()
    -- local destoryRepeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.BAG_QUICK_BAG_SELL_GARBAGE)
    -- if(destoryRepeatData) then
    --     self._sellGarbage:setSpriteName(SPRITE_GRID_DELETE_BUTTON_DISABLE_BG)
    --     self._sellImage:setSpriteName(SPRITE_FUNCTION_SELL_DISABLE)
    --     self._sellGarbage:setTouchEnable(false)
    -- else 
    --     self._sellGarbage:setSpriteName(SPRITE_GRID_DELETE_BUTTON_BG)
    --     self._sellImage:setSpriteName(SPRITE_FUNCTION_SELL_NORMAL)
    --     self._sellGarbage:setTouchEnable(true)
    -- end
end

-- 获取删除初始
function ExpeditionBagView:getDeleteNormal()
    -- 根据页面类型返回图片
    if self._type == GameBagUIType.CAVE_SHOP or self._type == GameBagUIType.BLACK_SHOP then
        return SPRITE_FUNCTION_CHOICE_NORMAL
    else
        return SPRITE_FUNCTION_DUSTBIN_NORMAL
    end
end

-- 获取删除点击
function ExpeditionBagView:getDeleteClick()
    -- 根据页面类型返回图片
    if self._type == GameBagUIType.CAVE_SHOP or self._type == GameBagUIType.BLACK_SHOP then
        return SPRITE_FUNCTION_CHOICE_ACTIVE
    else
        return SPRITE_FUNCTION_DUSTBIN_ACTIVE
    end
end

-- 获取删除确认资源
function ExpeditionBagView:getDeleteConfirm()
    return SPRITE_FUNCTION_CONFIRM
end

-- 模版函数：组件尺寸更新
function ExpeditionBagView:onSizeChanged(originalWidth, originalHeight)

end

function ExpeditionBagView:getIsShowSellPrice()
    if(self._type == GameBagUIType.CAVE_SHOP or self._type == GameBagUIType.BLACK_SHOP) then
       return true
    else 
        return false
    end
end

-- 设置刷新标志
function ExpeditionBagView:setRefreshFlag(flag)
    if(flag == true) then 
        self._refreshFlag = flag
    else 
        self._refreshFlag = false
    end
    if(not tolua.isnull(self._bagGridList)) then
        self._bagGridList:setRefreshFlag(self._refreshFlag)
    end
end

-- 由于在购买后，需要切换到对应的背包页面
function ExpeditionBagView:changeBagIndex(index)
    -- print("ExpeditionBagView:changeBagIndex ",index)
    self._tabIndex = index
end

function ExpeditionBagView:getBagIndex()
    return self._tabIndex
end

function ExpeditionBagView:changeBagDefaultIndex(index)
    -- print("ExpeditionBagView:changeBagDefaultIndex ",index)
end 

function ExpeditionBagView:updateMoneyView()
    -- print("ExpeditionBagView:updateMoneyView()  ")
    local coinNum = 0;
    local expNum = 0;
    local naviCoin = 0;
    if(self._bagType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then 
        coinNum = mvc.expeditionModel:getNormalCoin();
        expNum = mvc.expeditionModel:getNormalExp();
    elseif(self._bagType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then 
        coinNum = mvc.expeditionModel:getQuickCoin();
        expNum = mvc.expeditionModel:getQuickExp();
    elseif(self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE) then 
        coinNum = mvc.petTreasureModel:getPetAdvData().dropGold;
        -- expNum = mvc.expeditionModel:getNormalExp();
    elseif(self._bagType == PublicDefine.PACKET_TYPE.PACKET_SAIL) then 
        naviCoin = mvc.dockModel:getNaviGoldCoin()
        -- expNum = mvc.expeditionModel:getNormalExp();
    end

    self._momey:setText(self._momey:numformat(string.format("%d", coinNum)))
    self._momey:updateView()
    self._momeyPreNum = coinNum
    self._diamond:setText(self._diamond:numformat(string.format("%d", expNum)))
    self._diamondPreNum = expNum
    self._diamond:updateView()
    self._naviGold:setText(self._naviGold:numformat(string.format("%d", naviCoin)))
    self._naviGold:updateView()
end

-- private  私有函数
function ExpeditionBagView:sellGarbageEquipments()
    -- print("ExpeditionBagView:sellGarbageEquipments")
    local data = self._data
    local sellArr = {}
    local sellPrice = 0

    local sellGoodsArr = {}
    for i = 1, #data.haveEquipmentArr do
        local equipmentData = data.haveEquipmentArr[i]
        if(equipmentData and equipmentData:getIsLock() == false) then
            local goodsRare = equipmentData:getGoodsRare()
            if(goodsRare == GOODS_RARE.RARE_WHITE_1 or goodsRare == GOODS_RARE.RARE_BLUE_2) then
                sellPrice = sellPrice + equipmentData:getSellPrice()
            end
        end
    end

    local okCallBack = function() 
        if(tolua.isnull(self)) then 
            return
        end
        local sellGoodsArr = {}
        local sellGoodsDataArr = {}
        local data = self._data
        for i = 1, #data.haveEquipmentArr do
            local equipmentData = data.haveEquipmentArr[i]
            if(equipmentData and equipmentData:getIsLock() == false) then
                local goodsRare = equipmentData:getGoodsRare()
                if(goodsRare == GOODS_RARE.RARE_WHITE_1 or goodsRare == GOODS_RARE.RARE_BLUE_2) then
                    local buyGoods = {}
                    buyGoods.num = 1

                    buyGoods.templateID = 0
                    buyGoods.isGolden = false
                    buyGoods.entityID = equipmentData:getEntityID()

                    table.insert(sellGoodsArr,buyGoods)
                    table.insert(sellGoodsDataArr, equipmentData)
                end
            end
        end

        if(#sellGoodsArr > 0) then
            -- MasterDataManager:setRepeatHandleData(RepeatHandleType.BAG_QUICK_BAG_SELL_GARBAGE, true)
            UI.TipsLayer:createDestoryGemStoneTips(sellGoodsDataArr, function() 
                UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                GameManager:sendSellFunction(sellGoodsArr, {}, self._spriteID)
                Avalon.AudioManager:playSound("1504")
            end)
        end
    end
    local cancelCallBack = function()
        print("ExpeditionBagView:sellGarbageEquipments    cancel.")
    end
    
    UI.TipsLayer:onSalesEquipment(okCallBack, cancelCallBack, sellPrice)
end

-- 关闭选中
function ExpeditionBagView:closeChoese()
    if self._selectedBagGrid then 
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil 
    end
end

function ExpeditionBagView:refresBtnText()
    if(self._isResolve) then 
        if(#self._choiceTable > 0) then
            self.resolveButton:setText(LanguageManager:getInstance():getLocalString(1112828))
        else 
            self.resolveButton:setText(UI.TEXT_1212272)
        end
    elseif (self._isReceive) then 
        if(#self._choiceTable > 0 
            or (not mvc.expeditionModel:getBagHaveGoodsForPacketType(self._bagType) 
            and mvc.expeditionModel:getIsNotNullForPacketType(self._bagType))) then
            self.receiveButton:setText(LanguageManager:getInstance():getLocalString(1110565))
        else 
            self.receiveButton:setText(UI.TEXT_1212272)
        end
    end
end

function ExpeditionBagView:refreshCheckStatus()
    -- print("ExpeditionBagView:refreshCheckStatus")
    local gridList = self._bagGridList:getGridList()
    local gridDataList = self._bagGridList:getShowDataArr()
    if (gridDataList) then
        local allChoice = true
        local allGoldChoice = true
        local allGoldUpChoice = true
        local haveAll = false
        local haveGold = false
        local haveGoldUp = false
        -- print("ExpeditionBagView:refreshCheckStatus",allChoice, allGoldChoice, allGoldUpChoice)
        for i = 1, #gridDataList do
            -- local bagGrid = gridDataList[i]
            local gridData = gridDataList[i]
            local handle = false
            if gridData and UI.GoodsGrid:calculationUseState(gridData) then 
                local found = nil
            -- if gridData and bagGrid:getCanUseState() then 
                if(gridData:getGoodsRare() == PublicDefine.GOODS_RARE.RARE_GOLDEN_3 
                    and (self._deleteState == true or gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)) then 
                    haveGold = true
                    if(allGoldChoice) then 
                        if(found == nil) then
                            found = false
                            for i=#self._choiceTable, 1, -1 do 
                                if self._choiceTable[i] == gridData then 
                                    found = true
                                    break
                                end 
                            end
                        end
                        if(not found) then 
                            allGoldChoice = false
                        end
                    end
                end
                if(gridData:getGoodsRare() > PublicDefine.GOODS_RARE.RARE_GOLDEN_3
                    and (self._deleteState == true or gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)) then 
                    haveGoldUp = true
                    if(allGoldUpChoice) then 
                        if(found == nil) then
                            found = false
                            for i=#self._choiceTable, 1, -1 do 
                                if self._choiceTable[i] == gridData then 
                                    found = true
                                    break
                                end 
                            end
                        end
                        if(not found) then 
                            allGoldUpChoice = false
                        end
                    end
                end
                haveAll = true
                if(allChoice) then 
                    if(found == nil) then
                        found = false
                        for i=#self._choiceTable, 1, -1 do 
                            if self._choiceTable[i] == gridData then 
                                found = true
                                break
                            end 
                        end
                    end
                    if(not found) then 
                        allChoice = false
                    end
                end
            end
        end

        self.goldCheckBox:getChildByName("boxItself"):setTouchEnable(haveGold)
        self.goldUpCheckBox:getChildByName("boxItself"):setTouchEnable(haveGoldUp)
        self.allCheckBox:getChildByName("boxItself"):setTouchEnable(haveAll)

        if(not haveGold) then 
            allGoldChoice = self.goldCheckBox:getChildByName("boxItself"):isChecked()
        end
        if(not haveGoldUp) then 
            allGoldUpChoice = self.goldUpCheckBox:getChildByName("boxItself"):isChecked()
        end
        if(not haveAll) then 
            allChoice = self.allCheckBox:getChildByName("boxItself"):isChecked()
        end
        
        -- print("ExpeditionBagView:refreshCheckStatus",allChoice, allGoldChoice, allGoldUpChoice)
        self.updateCheckStatus = false
        self.goldCheckBox:getChildByName("boxItself"):setValue(allGoldChoice)
        self.goldUpCheckBox:getChildByName("boxItself"):setValue(allGoldUpChoice)
        self.allCheckBox:getChildByName("boxItself"):setValue(allChoice)
        self.updateCheckStatus = true
    end
end

function ExpeditionBagView:bagClickCallback(bagGrid)
    if self._isDraging then 
        return 
    end

    if (DEBUG) then
        print(string.format("ExpeditionBagView:bagClickCallback: grid index:%d.", bagGrid:getIndex()))
    end

    local goodsData = nil
    if (bagGrid) then
        goodsData = bagGrid:getData()
        local changeStatus = false
        if self._deleteState == true then 
            if goodsData and bagGrid:getCanUseState() then 
                if bagGrid:deleteItem() then 
                    self._deleteButton:setSpriteName(self:getDeleteConfirm())
                    table.insert(self._choiceTable,goodsData)
                    changeStatus = true
                else
                    for i=#self._choiceTable, 1, -1 do 
                        if self._choiceTable[i] == goodsData then 
                            table.remove(self._choiceTable,i) 
                            changeStatus = true
                        end 
                    end 
                end
                -- print("=====数量",#self._deleteItemTable)
                if #self._choiceTable == 0 then 
                    self._deleteButton:setSpriteName(self:getDeleteClick())
                end
            end
            if(changeStatus) then 
                -- self._bagGridList:showChoiceStatus()
                self._bagGridList:refrehDeleteGrid(self._choiceTable, false)
                self:refreshCheckStatus()
            end
            -- 暂时不打开装备页面
            return 
        elseif (self._isReceive or self._isResolve) then 
            if goodsData and bagGrid:getCanUseState() then 
                if bagGrid:deleteItem() then 
                    table.insert(self._choiceTable,goodsData)
                    changeStatus = true
                else
                    for i=#self._choiceTable, 1, -1 do 
                        if self._choiceTable[i] == goodsData then 
                            table.remove(self._choiceTable, i) 
                            changeStatus = true
                        end 
                    end 
                end
                self:refresBtnText()
            end

            if(changeStatus) then 
                -- self._bagGridList:showChoiceStatus()
                self._bagGridList:refrehDeleteGrid(self._choiceTable, false)
                self:refreshCheckStatus()
            end
            return 
        end
 
        if self._selectedBagGrid == bagGrid then 
            print("===关闭详情页面")
            self:closeChoese()
        else
            -- 把上次点击的关闭
            print("==不是上次点击的格子")
            if self._selectedBagGrid then 
                self._selectedBagGrid:hideSelect()
                self._selectedBagGrid = nil 
            end

            if  self._selectedRoleGrid then 
                self._roleShowArea:unselectEquipment()
                self._selectedRoleGrid = nil 
            end

            if goodsData then 
                if goodsData:getIsNew() then
                    -- 如果是新物品，发送消息
                    GameManager:bagClickGoodsHandler(goodsData)
                end

                if self._deleteState == false then 
                    bagGrid:showSelect()
                end
                -- local leftX = -274-20

                local worldPos = self._contentLayout:convertToWorldSpace(cc.p(0,0))
                local rightX =  winSize.width - worldPos.x - 20
                local leftX =  worldPos.x+(winSize.width/2 - worldPos.x)

                -- 类型
                if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
                    -- 装备详情
                    local equipmentInfoArea = UI.EquipmentInfoArea:create()
                    equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                    self._infoArea = equipmentInfoArea
                    -- 处理试穿对比
                    local blackTable = GameDataManager:getInstance():tryEquipment(goodsData)
                    equipmentInfoArea:updateInfo(blackTable)
                    equipmentInfoArea:closeLockFlag()
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
                    local equipmentInfoArea = UI.EquipmentPetInfoArea:create()
                    equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                    self._infoArea = equipmentInfoArea
                    equipmentInfoArea:updateInfo(goodsData, MasterDataManager:getFightWearEquipmentForEquipmentType(goodsData:getEquipmentType()))
                    equipmentInfoArea:closeLockFlag()
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
                    -- 道具详情界面
                    local itemType = goodsData:getItemType()
                    local propInfo = nil;
                    if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
                        propInfo = UI.SelectGoodsBagInfoArea:create()
                    elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then 
                        propInfo = UI.RandomBagInfoArea:create()
                    elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then 
                        propInfo = UI.LevelBagInfoArea:create()
                    else
                        propInfo = UI.PropInfoArea:create(true)
                    end
                    propInfo:init(UI.PROP_MATER.PROPINFO)
                    self._infoArea = propInfo
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then 
                    -- 材料详情界面
                    local materialInfo = nil
                    if(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then
                        materialInfo = UI.PropInfoArea:create(true)
                    else 
                        materialInfo = UI.MaterialEquipScrollInfoArea:create()
                    end
                    materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                    self._infoArea = materialInfo
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then
                    local materialInfo = UI.PropInfoArea:create(true)
                    materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                    self._infoArea = materialInfo
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then
                    local gemInfoArea = UI.GemStoneInfoArea:create()
                    gemInfoArea:init(goodsData)
                    self._infoArea = gemInfoArea
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then
                    local gemInfoArea = UI.StarPrayInfoArea:create()
                    gemInfoArea:init(goodsData)
                    self._infoArea = gemInfoArea
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
                    pInfoArea = UI.PetStoneInfoArea:create()
                    pInfoArea:init(goodsData)
                    self._infoArea = pInfoArea
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
                    local gemInfoArea = UI.RelicInfoArea:create()
                    gemInfoArea:init(goodsData)
                    self._infoArea = gemInfoArea
                end
                if self._infoArea then
                    self._infoArea:closeLockFlag()
                    if(self:getIsShowSellPrice()) then
                        self._infoArea:setShowSellPrice(true)
                    end

                    local worldPos = bagGrid:convertToWorldSpace(cc.p(0,0))
                    if worldPos.x < winSize.width/2 then
                        self._infoArea:centerLeft(leftX)--(worldPos.x + bagGrid:getSize() + 20)
                    else
                        -- self._infoArea:centerLeft(worldPos.x - bagGrid:getSize() - 20)
                        self._infoArea:centerRight(rightX - 5)
                    end
                    -- self._infoArea:centerRight(rightX - 5)
                    UI.UIManager:addToRootNode(self._infoArea,UI_ZORDER.EQUIPMENTINFO)
                    self._infoArea:setGoodsGrid(bagGrid)
                    
                    self._infoArea:setVisible(true)
                    self._infoArea:updateView(goodsData)
                    self._infoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onInfoAreaTouchHandler)
                end
            end
            self._selectedBagGrid = bagGrid
        end
    end
end

function ExpeditionBagView:bagDragBeganCallback(goodsGrid, touchPosition)
    -- print("ExpeditionBagView:bagDragBeganCallback")
    self._isDraging = true

    if (self._targetForDragBegan and self._functionForDragBegan) then
        if(goodsGrid) then
            local bagGridData = goodsGrid:getData()
            if (bagGridData and bagGridData:getIsNew()) then
                GameManager:bagClickGoodsHandler(bagGridData)
            end
        end

        self._functionForDragBegan(self._targetForDragBegan, goodsGrid, touchPosition)
    end
end

function ExpeditionBagView:bagDragMovedCallback(goodsGrid, touchPosition)
    -- print("ExpeditionBagView:bagDragMovedCallback")

    if(self._enableDragStatus) then 
        local pos = self:convertToNodeSpace(touchPosition)
        local size = self:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local inSide = cc.rectContainsPoint(rect, pos)
        self:changeInSideStatus(not inSide)
    end


    if (self._targetForDragMoved and self._functionForDragMoved) then
        self._functionForDragMoved(self._targetForDragMoved, goodsGrid, touchPosition)
    end
end

function ExpeditionBagView:bagDragEndedCallback(goodsGrid, touchPosition)
    -- print("ExpeditionBagView:bagDragEndedCallback")
    self._isDraging = false
    if (self._targetForDragEnded and self._functionForDragEnded) then 
        Avalon.AudioManager:playSound("1505")
        self._functionForDragEnded(self._targetForDragEnded, goodsGrid, touchPosition, self:isPositionInBag(touchPosition))
    end
end

function ExpeditionBagView:isPositionInBag(touchPosition)
    local pos = self:convertToWorldSpace(cc.p(0, 0))
    local rect = cc.rect(pos.x, pos.y, self._width, self._height)
    local isInBag = cc.rectContainsPoint(rect, touchPosition)
    return isInBag;
end

-- 添加拖拽格子开始的处理回调函数
function ExpeditionBagView:setCallbackForGridDragBegan(target, func)
    self._targetForDragBegan = target
    self._functionForDragBegan = func
end

-- 添加拖拽格子的处理回调函数
function ExpeditionBagView:setCallbackForGridDragMoved(target, func)
    self._targetForDragMoved = target
    self._functionForDragMoved = func
end

-- 添加拖拽格子完成的处理回调函数
function ExpeditionBagView:setCallbackForGridDragEnded(target, func)
    self._targetForDragEnded = target
    self._functionForDragEnded = func
end

--刷新视图
function ExpeditionBagView:refreshView()
    self._waitingRefreshGrid = 2
    -- updateGridList(self,self._data)
end

--更新是否能拖拽
function ExpeditionBagView:updateCanDrag(var)
    if(self._bagGridList) then
        self._bagGridList:updateCanDrag(var)
    end
end

function ExpeditionBagView:setSpineBgVisible(visible)
    --self.dragSpineBag:setVisible(visible)
end

-- 重置操作状态
function ExpeditionBagView:resetHandleStatus()
    if(self._deleteState) then
        cancelDeleteState(self)
        cancelAllDeleteChoice(self)
    end 
end

function ExpeditionBagView:changeInSideStatus(inSide)
    if(self._bagGridList) then 
        self._bagGridList:changeInSideStatus(inSide)
    end
end

function ExpeditionBagView:setUsedType(usedType)
    -- usedType = usedType or {}

    local function isDiffUsedType(oldUsedType, newUsedType)
        if(oldUsedType and newUsedType) then 
            for i = 1, #oldUsedType do
                for j = 1, #newUsedType do
                    if oldUsedType[i].goodType == newUsedType[j].goodType then
                        if oldUsedType[i].type ~= newUsedType[j].type or 
                            oldUsedType[j].rare ~= newUsedType[j].rare or 
                            oldUsedType[i].heroLevel ~= newUsedType[j].heroLevel or 
                            oldUsedType[i].stoneLockMaxLV ~= newUsedType[j].stoneLockMaxLV or
                            oldUsedType[j].stoneShowLV ~= newUsedType[j].stoneShowLV or 
                            oldUsedType[j].gemStoneType ~= newUsedType[j].gemStoneType or 
                            oldUsedType[j].transDropGroupID ~= newUsedType[j].transDropGroupID then
                            return true
                        end
                    end
                end
            end

            return false
        end

        return true
    end

    local isDifferent = false
    if(self._usedType == nil or usedType == nil) then 
        isDifferent = true
    else 
        if #self._usedType ~= #usedType then
            isDifferent = true
        else
            isDifferent = isDiffUsedType(self._usedType, usedType)
        end
    end

    if isDifferent then
        self._usedType = usedType
        self:refreshView()
    end
end

function ExpeditionBagView:scrollToTop(duration, slowDown)
    self._bagGridList:scrollToTop(duration, slowDown)
end

function ExpeditionBagView:createCheckBoxWithLabel(text, initialStateFunc, cb, textLeft)
    local boxLayout = UI.Layout:create()
    boxLayout:init()
    boxLayout:setSize(33, 33)
    boxLayout:enableAutoWidth()
    boxLayout:enableAutoHeight()


    local boxItself = UI.CheckBox:create() 
    boxItself:init("ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_0.png", "ui_btn_choice_1.png")
    boxItself:floatLeft(0)
    if(textLeft) then 
        boxItself:floatRight(0)
    end 
    boxItself:setValue(initialStateFunc and initialStateFunc(boxLayout) or false)
    boxItself:setName("boxItself")
    boxLayout:addComponent(boxItself)
    boxItself:addEventListener(UI.Event.CHECKBOX_STATUS_CHANGED, self, function(self, comp, isChecked, isByTouch)
        if (cb) then cb(isChecked, boxLayout, comp, isByTouch) end
    end)

    local boxLabel = UI.Text:create()
    boxLabel:init(text, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_41_41_45)
    boxLabel:floatLeft(9)
    if(textLeft) then 
        boxLabel:floatRight(9)
    end 
    boxLayout:addComponent(boxLabel)

    boxLayout:setTouchEnable(true)
    boxLayout:addEventListener(UIEvent.COMPONENT_CLICK, self, function()
        if(not boxItself._enableTouch) then 
            UI.ScrollBar:createByText(UI.TEXT_1212599)
        end
    end)

    return boxLayout
end

-- 注册监听事件(可选)
function ExpeditionBagView:registerListener()
    -- 监听消息
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE, self, onUpdateEquipmentListHandler)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, onUpdateItemListHandler)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, onUpdateMaterialListHandler)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, onUpdateGemStoneListHandler)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, onWearEquipmentChangedHandler)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT, self, self.sellGoodsResult)
    -- Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_LOSE_RESULT, self, self.loseGoodsResult)

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

-- 注销监听事件(可选)
function ExpeditionBagView:unRegisterListener()
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE, self, onUpdateEquipmentListHandler)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, onUpdateItemListHandler)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, onUpdateMaterialListHandler)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, onUpdateGemStoneListHandler)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, onWearEquipmentChangedHandler)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT, self, self.sellGoodsResult)
    -- Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_LOSE_RESULT, self, self.loseGoodsResult)

    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

function ExpeditionBagView:update(dt)
    if not self._waitingRefreshGrid then
        return
    end
    if(self._waitingRefreshGrid > -1) then
        if(self._waitingRefreshGrid == 0) then 
            updateGridList(self, self._data)
            self._waitingRefreshGrid = -1
        end
        self._waitingRefreshGrid = self._waitingRefreshGrid - 1
    end
end

function ExpeditionBagView:dataUpdate()
    self._data = mvc.expeditionModel:getGoodsArrForBag(self._bagType)
    -- refreshBagData(self)
    updateGridList(self, self._data)
    if self.preExpedtionStatus ~= mvc.expeditionModel:getExpeditionStatus() and 
        self._bagType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL or
        (self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE and mvc.petTreasureModel:getExploreState()) or
        (self._bagType == PublicDefine.PACKET_TYPE.PACKET_SAIL) then
        self:refreshStatus()
        self:refreshCheckStatus()
        self:refreshDeleteButton()
    end
end

function ExpeditionBagView:bagAttrChange()
    if(self._bagType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_NORMAL) then
        if(self._momeyPreNum ~= mvc.expeditionModel:getNormalCoin()) then 
            local data = {}
            data.value = mvc.expeditionModel:getNormalCoin() - self._momeyPreNum
            data.costType = GOODS_COST_TYPE.GOLD
            onCurrencyChangeHandler(self, data)
        end

        if(self._diamondPreNum ~= mvc.expeditionModel:getNormalExp()) then 
            local data = {}
            data.value = mvc.expeditionModel:getNormalExp() - self._diamondPreNum
            data.costType = GOODS_COST_TYPE.EXP
            onCurrencyChangeHandler(self, data)
        end

    elseif(self._bagType == PublicDefine.PACKET_TYPE.PACKET_EXPEDITION_QUICK) then 
        if(self._momeyPreNum ~= mvc.expeditionModel:getQuickCoin()) then 
            local data = {}
            data.value = mvc.expeditionModel:getQuickCoin() - self._momeyPreNum
            data.costType = GOODS_COST_TYPE.GOLD
            onCurrencyChangeHandler(self, data)
        end

        if(self._diamondPreNum ~= mvc.expeditionModel:getQuickExp()) then 
            local data = {}
            data.value = mvc.expeditionModel:getQuickExp() - self._diamondPreNum
            data.costType = GOODS_COST_TYPE.EXP
            onCurrencyChangeHandler(self, data)
        end
    end 
    self:updateMoneyView()
end

function ExpeditionBagView:isNewBagNeedShow()
    local isShow = true
    if self._bagType == PublicDefine.PACKET_TYPE.PACKET_PET_ADVENTURE or 
    self._bagType == PublicDefine.PACKET_TYPE.PACKET_SAIL then
        isShow = false
    end
    return isShow
end


return ExpeditionBagView












