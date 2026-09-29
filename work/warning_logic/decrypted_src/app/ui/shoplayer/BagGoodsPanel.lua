-- BagGoodsPanel.lua
-- Author:zp
-- 2017年5月19日
-- Using:物品组件
require "app.ui.common.GridText"

local GameDataManager = require("app.game.GameDataManager")
local ProtobufUtil = require "utils.ProtobufUtil"

UI = UI or {}

local BagGoodsPanel = class("BagGoodsPanel", UI.HWBtnComponent)
UI.BagGoodsPanel = BagGoodsPanel

local winSize = cc.Director:getInstance():getWinSize()
local GOODS_RARE = PublicDefine.GOODS_RARE
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

local DEBUG = true
local BAG_TYPE = 
 {
    ALL = 1,
    WEAR_EQUIP = 3,
    EQUIPMENT= 2,
    ITEM = 4,
    MATERIAL = 5,
    GEM_STONE = 6,
    GEM_STONE_EQUIP_WEAR = 7,
    GEM_STONE_EQUIP = 8, --已镶嵌到未穿戴装备上
    
    RELIC = 10,
    PET_SLOT_STONE_ONE = 11, --宠物栏1中 宠物装备中的宝石
    PET_SLOT_STONE_TWO = 12, --宠物栏2中 宠物装备中的宝石
    PET_SLOT_STONE_THREE = 13, --宠物栏3中 宠物装备中的宝石
    PET_EQUIPMENT_ONE = 14, --宠物栏1中 宠物的装备
    PET_EQUIPMENT_TWO = 15, --宠物栏2中 宠物的装备
    PET_EQUIPMENT_THREE = 16, --宠物栏3中 宠物的装备

    WAREHOUSE = 17, --仓库

    PET_STONE = 18, --宠物宝石

    GLYPH = 19,--雕纹
    GLYPH_EQUIP_WEAR = 20,
    GLYPH_EQUIP = 21, --已镶嵌到未穿戴装备上
    GLYPH_ALL   = 22, --所有的雕纹
}
UI.BagGoodsPanel.BAG_TYPE = BAG_TYPE

-- 资源文件
local COM_RES_LIST = {
    
}

-- 尺寸
local COM_WIDTH = 458
local COM_HEIGHT = 626

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

local SPRITE_BG ="ui_goods_knapsack.png"

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
local SPRITE_GRID_RELIC_BUTTON_NORMAL = "ui_goods_button_relic_0.png"
local SPRITE_GRID_RELIC_BUTTON_ACTIVE = "ui_goods_button_relic_1.png"

local SPRITE_GRID_WAREHOUSE_BUTTON_NORMAL = "ui_goods_button_warehouse_0.png"
local SPRITE_GRID_WAREHOUSE_BUTTON_ACTIVE = "ui_goods_button_warehouse_1.png"

local SPRITE_GRID_PET_STONE_BUTTON_NORMAL = "ui_goods_button_petsquipment_4_0.png"
local SPRITE_GRID_PET_STONE_BUTTON_ACTIVE = "ui_goods_button_petsquipment_4_1.png"

local SPRITE_GRID_PET_SLOT_STONE_ONE_BUTTON_NORMAL = "ui_goods_button_petsquipment_0.png"
local SPRITE_GRID_PET_SLOT_STONE_ONE_BUTTON_ACTIVE = "ui_goods_button_petsquipment_1.png"

local SPRITE_GRID_PET_SLOT_STONE_TWO_BUTTON_NORMAL = "ui_goods_button_petsquipment_2_0.png"
local SPRITE_GRID_PET_SLOT_STONE_TWO_BUTTON_ACTIVE = "ui_goods_button_petsquipment_2_1.png"

local SPRITE_GRID_PET_SLOT_STONE_THREE_BUTTON_NORMAL = "ui_goods_button_petsquipment_3_0.png"
local SPRITE_GRID_PET_SLOT_STONE_THREE_BUTTON_ACTIVE = "ui_goods_button_petsquipment_3_1.png"

local SPRITE_GRID_PET_EQUIPMENT_ONE_BUTTON_NORMAL = "ui_goods_button_petsquipment_0.png"
local SPRITE_GRID_PET_EQUIPMENT_ONE_BUTTON_ACTIVE = "ui_goods_button_petsquipment_1.png"

local SPRITE_GRID_PET_EQUIPMENT_TWO_BUTTON_NORMAL = "ui_goods_button_petsquipment_2_0.png"
local SPRITE_GRID_PET_EQUIPMENT_TWO_BUTTON_ACTIVE = "ui_goods_button_petsquipment_2_1.png"

local SPRITE_GRID_PET_EQUIPMENT_THREE_BUTTON_NORMAL = "ui_goods_button_petsquipment_3_0.png"
local SPRITE_GRID_PET_EQUIPMENT_THREE_BUTTON_ACTIVE = "ui_goods_button_petsquipment_3_1.png"

-- 雕文
local SPRITE_GRID_GLYPH_BUTTON_NORMAL = "ui_goods_button_glyphs_1_0.png"
local SPRITE_GRID_GLYPH_BUTTON_ACTIVE = "ui_goods_button_glyphs_1_1.png"

-- 黄金，钻石的背景
-- 黄金，钻石的图片
local SPRITE_GAMING_MOMEY   = "symbol_gaming_money.png"
local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"

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

-- local ANIMATION_

local function computeLayoutScale(realAreaWidth, designAreaWidth)
    local areaScale = realAreaWidth / designAreaWidth
    if (areaScale > 1.0) then areaScale = 1.0 end
    return areaScale
end

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

    -- 拥有物品装备列表
    if(self._data.havePetEquipmentArr) then
        for k,goodsData in pairs(self._data.havePetEquipmentArr) do
            goodsData:setUseNum(0)
            if(repeatData and repeatData[goodsData:getEntityID()]) then
                goodsData:setUseNum(repeatData[goodsData:getEntityID()])
            end
            if(dragRepeatData and dragRepeatData[goodsData:getEntityID()]) then
                goodsData:setUseNum(dragRepeatData[goodsData:getEntityID()])
            end
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
    -- print(debug.traceback())
    if (self._data) then
        -- 过滤卖出或销毁的数据
        refreshBagData(self)
        self:refreshPacketType(tabIndex)
        self._bagGridList:setData(self._data, self._isUnlockBagFlag)
        if(self._isUnlockBagFlag) then
            self._isUnlockBagFlag = nil
        else
            if (tabIndex == BAG_TYPE.ALL) then
                self._bagGridList:showAllGoods()
            elseif (tabIndex == BAG_TYPE.WEAR_EQUIP) then
                self._bagGridList:showEquip()
            elseif (tabIndex == BAG_TYPE.EQUIPMENT) then
                self._bagGridList:showEquipments()
            elseif (tabIndex == BAG_TYPE.ITEM) then
                self._bagGridList:showItems()
            elseif (tabIndex == BAG_TYPE.MATERIAL) then
                self._bagGridList:showMaterials()
            elseif (tabIndex == BAG_TYPE.GEM_STONE) then
                self._bagGridList:showGemStone()
            elseif (tabIndex == BAG_TYPE.GEM_STONE_EQUIP_WEAR) then
                self._bagGridList:showGemStoneWear()
            elseif (tabIndex == BAG_TYPE.WAREHOUSE) then
                self._bagGridList:showWareHouse()
            elseif (tabIndex == BAG_TYPE.RELIC) then
                self._bagGridList:showRelics()
            elseif (tabIndex == BAG_TYPE.PET_STONE) then
                self._bagGridList:showPetStone()
            elseif (tabIndex == BAG_TYPE.PET_SLOT_STONE_ONE) and not self._deleteState then
                self._bagGridList:showPetSlotStoneOne()
            elseif (tabIndex == BAG_TYPE.PET_SLOT_STONE_TWO) and not self._deleteState then
                self._bagGridList:showPetSlotStoneTwo()
            elseif (tabIndex == BAG_TYPE.PET_SLOT_STONE_THREE) and not self._deleteState then
                self._bagGridList:showPetSlotStoneThree()
            elseif (tabIndex == BAG_TYPE.PET_EQUIPMENT_ONE) and not self._deleteState then
                self._bagGridList:showPetEquipmentOne()
            elseif (tabIndex == BAG_TYPE.PET_EQUIPMENT_TWO) and not self._deleteState then
                self._bagGridList:showPetEquipmentTwo()
            elseif (tabIndex == BAG_TYPE.PET_EQUIPMENT_THREE) and not self._deleteState then
                self._bagGridList:showPetEquipmentThree()
            elseif (tabIndex == BAG_TYPE.GLYPH) then
                self._bagGridList:showGlyph()
            elseif (tabIndex == BAG_TYPE.GLYPH_EQUIP_WEAR) then
                self._bagGridList:showGlyphWear()
            elseif (tabIndex == BAG_TYPE.GLYPH_EQUIP) then
                self._bagGridList:showGlyphEquip()
            elseif (tabIndex == BAG_TYPE.GLYPH_ALL) then
                self._bagGridList:showGlyphAll()
            else
                printError(string.format("RolePanel showGoodsByTabIndex: tab index %d is invalid.", tabIndex))
            end
            self:updateGridCountLabel()

            -- 如果处于删除状态
            if (self._deleteState) then
                self._bagGridList:showChoiceStatus()
                self._bagGridList:refrehDeleteGrid(self._deleteItemTable, true)
            end

            self._bagGridList:updataGridCanUseState(self._checkItemUseState, self._useLock, self._deleteState, self._usedType)
        end
    end
end

local function refreshDeleteView(self)
    self._bagGridList:refrehDeleteGrid(self._deleteItemTable, true)
end

local function refreshAllGridCanUseState(self)
    self._bagGridList:updataGridCanUseState(self._checkItemUseState, self._useLock, self._deleteState, self._usedType)
end

function BagGoodsPanel:updataGridCanUseState(grid)
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

        if(self._deleteState and gridData and not gridData:getIsSellOrDestory()) then 
            grid:updateCanUseState(false)
            return 
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
                            elseif self._usedType[j].needRemoveLevel then 
                                if(gridData:getIsRemoveLevel() and not gridData:getLvRemove()) then 
                                    mark = true
                                end
                            elseif self._usedType[j].needRefineFunc then
                                mark = self._usedType[j].needRefineFunc(gridData)
                            elseif self._usedType[j].needPurpleFunc then
                                mark = self._usedType[j].needPurpleFunc(gridData)
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
                gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
            local mark = false
            for j = 1,#self._usedType do
                if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
                    self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
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
                                            end
                                        end
                                    end 
                                end 
                            end
                        end
                    end
                    if mark then
                        if self._usedType[j].needCheckEquiped then 
                            if( gridData.isEquiped) then 
                                mark = false
                            end
                        end
                        break
                    end
                end
            end
            if mark == false then
                grid:updateCanUseState(false)
            else
                grid:updateCanUseState(true)
            end
        elseif gridData and gridData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            -- local mark = false
            -- for j = 1,#self._usedType do
            --     if self._usedType[j].goodType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
            --         if self._usedType[j].type == 0 or gridData:getGemStoneType() == self._usedType[j].type then
            --             if self._usedType[j].rare == nil or gridData:getGoodsRare() < self._usedType[j].rare then
            --                 if(self._usedType[j].heroLevel == nil or gridData:getRequireLevel() <= self._usedType[j].heroLevel) then
            --                     -- if(self._usedType[j].stoneLV == nil or gridData:getStoneLV() <= self._usedType[j].stoneLV) then
            --                     if (self._usedType[j].stoneLockMaxLV == nil or gridData:getNextLVID() ~= 0) then
            --                         -- print("gridData:getNextLVID() ----- = "..gridData:getNextLVID())
            --                         if (self._usedType[j].stoneShowLV == nil or self._usedType[j].stoneShowLV == gridData:getStoneLV() ) then
            --                             if (self._usedType[j].transDropGroupID == nil or self._usedType[j].transDropGroupID == gridData:getTransDropGroupID()) then 
            --                                 if (self._usedType[j].gemStoneType == nil or self._usedType[j].gemStoneType == gridData:getGemStoneType()) then 
            --                                     mark = true
            --                                 end
            --                             end
            --                         end 
            --                     end 
            --                 end
            --             end
            --         end
            --         if mark then
            --             if self._usedType[j].needCheckEquiped then 
            --                 if( gridData.isEquiped) then 
            --                     mark = false
            --                 end
            --             end
            --             break
            --         end
            --     end
            -- end
            -- if mark == false then
            --     grid:updateCanUseState(false)
            -- else
            --     grid:updateCanUseState(true)
            -- end
        end
    end
end

function BagGoodsPanel:setRefreshOutSideLabelViewCallback(cb)
    self._refreshOutSideView = cb
end

function BagGoodsPanel:updateGridCountLabel()
    local data = self._data
    local petEquipNum = 0
    if(data.havePetEquipmentArr) then 
        petEquipNum = #data.havePetEquipmentArr
    end
    local maxCount = data.packetBoxBeUseNum
    local usedCount = #data.haveEquipmentArr + petEquipNum + #data.haveItemArr + #data.haveMaterialArr + #data.haveGemStoneArr + #data.haveRelicArr + #data.haveTreasureArr
      

    if self._tabIndex == BAG_TYPE.WAREHOUSE then
        local master = RoleDataManager:getMaster()
        maxCount = master:getWearhouseCanBeUseNum()
        usedCount = #self._bagGridList._nowShowGoodsData
    elseif self._tabIndex == BAG_TYPE.PET_STONE then
        local master = RoleDataManager:getMaster()
        if master then 
            local stoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_PET_GEMSTONE,PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
            usedCount = #stoneArr
        end
        maxCount = PublicDefine.CONST_DEFINITION.MAX_PET_GEMSTONE_PACKET_NUM
    elseif self._tabIndex == BAG_TYPE.GLYPH or
        self._tabIndex == BAG_TYPE.GLYPH_ALL or
        self._tabIndex == BAG_TYPE.GLYPH_EQUIP then
            
        local master = RoleDataManager:getMaster()
        if master then 
            local stoneArr = data.haveGlyphArr
            usedCount = #stoneArr
        end
        maxCount = MasterDataManager:getGlyphBoxCanBeUseNum()
    else
        usedCount = #self._bagGridList._nowShowGoodsData
    end

    self._gridCountLabel:setText(tostring(usedCount),tostring(maxCount))
    self._gridCountLabel:updateView()

    if self._refreshOutSideView then
        self._refreshOutSideView()
    end

end

-- 更新整个列表
local function updateGridList(self, data)
    -- print("BagGoodsPanel  updateGridList ", self._tabIndex, self._refreshFlag)
    if (data) then
        if self._refreshFlag then 
            if (self._tabIndex <= 0) then
                self._tabIndex = 1
                showGoodsByTabIndex(self, 1)
            else
                showGoodsByTabIndex(self, self._tabIndex)
            end

            -- self._bagGridList:updateView()

            -- -- 更新物品列表的滑块
            -- local availableCount, maxCount = self._bagGridList:getAvailableAndMaxGridCount()
            -- local percent = 0
            -- if (maxCount ~= 0) then
            --     percent = availableCount / maxCount
            -- end
            -- local sliderWidth, sliderHeight = self._goodsListSlider:getSize()
            -- sliderHeight = sliderHeight * percent
            -- self._goodsListSlider:setSliderComSize(sliderWidth, sliderHeight)
            -- self._goodsListSlider:hide()
            -- 更新格子数据
            -- local maxCount = GameDataManager:getInstance():getPacketBoxMaxNum()

        self:updateGridCountLabel()

            -- add by zp 这里的代码没有什么用处
            -- if (data.heroData:getIsDead()) then
            --     self._bagGridList:disable()
            -- end
        end
    end
end

-- 解锁背包格子
local function onUnlockBagGridHandler(self)
    self._data = GameDataManager:getInstance():getPacketBoxData()
    refreshBagData(self)
    self:updateGridCountLabel()
    if self._tabIndex == BAG_TYPE.WAREHOUSE then
       self._bagGridList:showWareHouse()
    end
    self._waitingRefreshGrid = 2
    -- updateGridList(self, self._data)
    self._isUnlockBagFlag = UNLOCK_BAG_FLAG.UNLOCK_BAG_FLAG_BAG
    self._bagGridList:updateGridCount()
end

-- 解锁背包格子
local function onUnlockWarehouseGridHandler(self)
    self._data = GameDataManager:getInstance():getPacketBoxData()
    refreshBagData(self)
    self:updateGridCountLabel()
    if self._tabIndex == BAG_TYPE.WAREHOUSE then
       self._bagGridList:showWareHouse()
    end
    self._waitingRefreshGrid = 2
    -- updateGridList(self, self._data)
    self._isUnlockBagFlag = UNLOCK_BAG_FLAG.UNLOCK_BAG_FLAG_WAREHOUSE
    self._bagGridList:updateGridCount()
end

-- 更新装备列表的处理器
local function onUpdateEquipmentListHandler(self, equipmentDataList)
    -- print(string.format("BagGoodsPanel onUpdateEquipmentListHandler: equipment data count %d.", #equipmentDataList))

    if (equipmentDataList) then
        self._data.haveEquipmentArr = equipmentDataList

        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
    else
        printError("BagGoodsPanel onUpdateEquipmentListHandler  equipmentDataList is nil.")
    end
end

-- 宠物装备改变
local function onUpdatePetEquipmentListHandler(self, petEquipmentDataList)
    if (petEquipmentDataList and self._data) then
            -- print(string.format("BagGridList onWearEquipmentChangedHandler: refresh equipments."))
        self._data.havePetEquipmentArr = petEquipmentDataList
        self._waitingRefreshGrid = 2
    else
        printError("BagGoodsPanel onWearPetEquipmentChange  wearEquipmentData is nil.")
    end
end

-- 更新道具列表的处理器
local function onUpdateItemListHandler(self, itemDataList)
    -- print(string.format("BagGoodsPanel onUpdateItemListHandler: item data count %d.", #itemDataList))

    if (itemDataList) then
        self._data.haveItemArr = itemDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
    else
        printError("BagGoodsPanel onUpdateItemListHandler  itemDataList is nil.")
    end
end

-- 更新材料列表的处理器
local function onUpdateMaterialListHandler(self, materialDataList)
    -- print(string.format("BagGoodsPanel onUpdateMaterialListHandler: material data count %d.", #materialDataList))

    if (materialDataList) then
        self._data.haveMaterialArr = materialDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
    else
        printError("BagGoodsPanel onUpdateMaterialListHandler  materialDataList is nil.")
    end
end

-- 更新宝石列表的处理器
local function onUpdateGemStoneListHandler(self, gemStoneDataList)
    -- print(string.format("BagGoodsPanel onUpdateGemStoneListHandler: gemStone data count %d.", #gemStoneDataList))
    if (gemStoneDataList) then
        self._data.haveGemStoneArr = gemStoneDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
    else
        printError("BagGoodsPanel onUpdateGemStoneListHandler  gemStoneDataList is nil.")
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
        printError("BagGoodsPanel onWearEquipmentChangedHandler  wearEquipmentData is nil.")
    end
end

-- 穿戴装备改变
local function onWearPetEquipmentChange(self, wearPetEquipmentArr)
    if (wearPetEquipmentArr and self._data) then
            -- print(string.format("BagGridList onWearEquipmentChangedHandler: refresh equipments."))
        self._data.wearPetEquipmentArr = wearPetEquipmentArr
        self._waitingRefreshGrid = 2
    else
        printError("BagGoodsPanel onWearPetEquipmentChange  wearEquipmentData is nil.")
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

-- 更新雕文列表的处理器
local function onUpdateGlyphListHandler(self, glyphDataList)
    -- print(string.format("BagGoodsPanel onUpdateGlyphListHandler: gemStone data count %d.", #gemStoneDataList))
    print("BagGoodsPanel onUpdateGlyphListHandler=======")
    if (glyphDataList) then
        self._data.haveGlyphArr = glyphDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
    else
        printError("BagGoodsPanel onUpdateGlyphListHandler  glyphDataList is nil.")
    end
end

local function onCurrencyChangeHandler(self, data)
    if (data) then
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

        if(data.costType == GOODS_COST_TYPE.GOLD) then
           
            self._momey:addChild(text)
        elseif data.costType == GOODS_COST_TYPE.GEM then
            
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
    else
        self:updateMoneyView()
    end
end

-- 选择不同类型的goods
local function onActiveGoodsTabHandler(self, tabIndex)
    print(string.format("onActiveGoodsTabHandler tabIndex=%d",tabIndex))
    if (self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
    end

    self._tabIndex = tabIndex
    showGoodsByTabIndex(self, tabIndex)
end

-- 取消所有删除选中标志
local function cancelAllDeleteChoice(self)
    self._bagGridList:refrehDeleteGrid(nil, true)
end

local function cancelDeleteState(self)
    self._deleteButtonBG:setSpriteName(SPRITE_GRID_DELETE_BUTTON_BG)
    self._deleteButton:setSpriteName(self:getDeleteNormal())
    self._deleteButton:updateView()

    self._bagGridList:updateCanDrag(true)

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
        
    if  self._selectedBagGrid then 
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
    self._deleteState = true

    self._bagGridList:updateCanDrag(false)

    -- 更新锁定表现逻辑
    -- self:setUseLock(false)
    -- self._useLock = false

    updateGridList(self,self._data)
    -- self:updateView()

    self._deleteItemTable = {}
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

-- 删除装备按钮点击处理器
local function onActiveDeleteButtonHandler(self)
    Avalon.AudioManager:playSound("1503")
    if self._deleteState == false then 
        onActiveStartDelete(self)
    else
        UI.TipsLayer:createDestoryGemStoneTips(self._deleteItemTable, function() 
            local isSell = false
            if(self._type == GameBagUIType.CAVE_SHOP) then
                isSell = true
            elseif ( self._type == GameBagUIType.BLACK_SHOP) then
                isSell = true
            end

            UI.TipsLayer:createLostEscapeScrollTips(self._deleteItemTable, isSell, function()
                cancelDeleteState(self)
                -- 点中后开始删除
                if #self._deleteItemTable > 0 then 
                    -- Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_LOST, self._deleteItemTable)
                    -- dump(self._deleteItemTable)
                    print("  --------------self-----------   ")
                    -- dump(self)

                    -- if(self._type == GameBagUIType.CAVE_SHOP) then
                        cancelAllDeleteChoice(self)
                        if (RoleBehaviorManager:caveShopSellItemCheck()) then 
                            GameManager:sellGoodsArrHandler(self._deleteItemTable, self._spriteID, handler(self, function()
                                for k, goodsData in pairs(self._deleteItemTable) do 
                                    goodsData:setUseNum(goodsData:getNum())
                                end
                                self._deleteItemTable = {}
                                refreshDeleteView(self)
                            end))
                            Avalon.AudioManager:playSound("1504")
                        end 
                    -- elseif ( self._type == GameBagUIType.BLACK_SHOP) then
                    --     cancelAllDeleteChoice(self)
                    --     if (RoleBehaviorManager:blackShopSellItemCheck()) then 
                    --         GameManager:sellGoodsArrHandler(self._deleteItemTable, self._spriteID, handler(self, function()
                    --             for k, goodsData in pairs(self._deleteItemTable) do 
                    --                 goodsData:setUseNum(goodsData:getNum())
                    --             end
                    --             refreshDeleteView(self)
                    --         end))
                    --         Avalon.AudioManager:playSound("1504")
                    --     end 
                    -- else
                    --     if (RoleBehaviorManager:lostItemCheck()) then 
                    --         GameManager:bagLostGoodsHandler(self._deleteItemTable, handler(self, function()
                    --             for k, goodsData in pairs(self._deleteItemTable) do 
                    --                 goodsData:setUseNum(goodsData:getNum())
                    --             end
                    --             refreshDeleteView(self)
                    --         end))
                    --     end 
                    -- end
                end
                -- 删除后，把纪录上次点击的格子清空
                self._selectedBagGrid = nil 
                -- 打开拖动
            end)
        end, function()
            if self._deleteItemTable then 
                local deleteItemArr = self._deleteItemTable
                self._deleteItemTable = {}
                for i=1,#deleteItemArr,1  do
                    local goodsData = deleteItemArr[i]

                    if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
                        if(not goodsData:haveGemStone() or (not goodsData:haveGlyph())) then 
                            table.insert(self._deleteItemTable, goodsData)
                        end
                    else 
                        table.insert(self._deleteItemTable, goodsData)
                    end
                end
            end

            if (self._deleteState) then
                self._bagGridList:showChoiceStatus()
                self._bagGridList:refrehDeleteGrid(self._deleteItemTable, true)
            end
            cancelAllDeleteChoice(self)
            refreshDeleteView(self)
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

function BagGoodsPanel:setMultiSelectOperation(startState, okCallBack,cancelCallBack)


    if startState then
        -- self._bagGridList:showChoiceStatus()
        -- self._bagGridList:showDestory()
            
        -- if  self._selectedBagGrid then 
        --     self._selectedBagGrid:hideSelect()
        --     self._selectedBagGrid = nil
        -- end
        -- self._deleteState = true

        -- self._bagGridList:updateCanDrag(false)


        -- self._deleteItemTable = {}
        -- -- 设置吞噬事件
        -- self:setInterceptTouches(true)

        -- -- 刷新显示
        -- updateGridList(self, self._data)
        onActiveStartDelete(self)
    else

        if #self._deleteItemTable > 0 then 
            local tip = UI.TipsLayer:onShowCommonTextHandler(UI.TEXT_224101, function()
                -- cancelDeleteState(self)
                if(okCallBack) then 
                    okCallBack(self._deleteItemTable)
                end
            end, function()
                if(cancelCallBack) then 
                    cancelCallBack()
                end
            end)
        end
        self._selectedBagGrid = nil 
    end
end

--必须在init函数之前调用，不然无效,
--hideBagTypeTab:BAG_TYPE 的table
function BagGoodsPanel:setHideBagType(hideBagTypeTable)
    if hideBagTypeTable and #hideBagTypeTable > 0 then
        for _,key in ipairs(hideBagTypeTable) do
            self.showBagType[key] = nil
        end
    end
end
function BagGoodsPanel:getAllEquipmentEquipedGemStore(haveEquipmentArr, isWear)
    local equipedGemEquip = {}
    for _, equipmentData in pairs(haveEquipmentArr) do
        local holeDataArr = equipmentData:getHoleDatas()
        for k,holeData in ipairs(holeDataArr) do 
            if holeData then
                local gemStoreData = holeData:getGemStoneData() 
                if gemStoreData then
                    gemStoreData:setIsWear(isWear, equipmentData:getEntityID(), k)
                    gemStoreData:setChangeNum(0)
                    gemStoreData:setIsNew(false)
                    table.insert(equipedGemEquip, gemStoreData)
                end
            end
        end
    end
    return equipedGemEquip
end

function BagGoodsPanel:getAllEquipmentEquipedGlyph(haveEquipmentArr, isWear)
    local equipedGemEquip = {}
    for _, equipmentData in pairs(haveEquipmentArr) do
        local glyphDataArr = equipmentData:getGlyphDatas()
        for k,glyphData in ipairs(glyphDataArr) do 
            if glyphData then
                local data = glyphData:getGlyphData() 
                if data then
                    data:setIsWear(isWear, equipmentData:getEntityID(), k, equipmentData:getBagType())
                    data:setChangeNum(0)
                    data:setIsNew(false)
                    table.insert(equipedGemEquip, data)
                end
            end
        end
    end
    return equipedGemEquip
end

function BagGoodsPanel:setShowBagTagExt(showBagTypeTable)
    if showBagTypeTable and #showBagTypeTable > 0 then
        for _, key in ipairs(showBagTypeTable) do
            self.showBagType[key] = true
        end
    end
end

function BagGoodsPanel:initBagListData() 
    local master = RoleDataManager:getMaster()
    for key,isShow in pairs(self.showBagType) do
        if isShow then
            if key == BAG_TYPE.GEM_STONE_EQUIP_WEAR then
                local haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                local equipedGemEquip = self:getAllEquipmentEquipedGemStore(haveEquipmentArr, true)
                self._bagGridList.haveGemStoneWearEquipArr = equipedGemEquip
            elseif key == BAG_TYPE.GEM_STONE_EQUIP then
                local wearEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                local equipedGemEquip = self:getAllEquipmentEquipedGemStore(wearEquipmentArr, false)
                self._bagGridList.haveGemStoneEquipArr = equipedGemEquip
            elseif key == BAG_TYPE.GLYPH_EQUIP_WEAR then
                local wearEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                local equipedGemEquip = self:getAllEquipmentEquipedGlyph(wearEquipmentArr, true)
                self._bagGridList.haveGlyphWearEquipArr = equipedGemEquip
            elseif key == BAG_TYPE.GLYPH_EQUIP then
                local haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                local equipedGemEquip = self:getAllEquipmentEquipedGlyph(haveEquipmentArr, false)
                self._bagGridList.haveGlyphEquipArr = equipedGemEquip
            elseif key == BAG_TYPE.GLYPH_ALL then
                local haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_BAG,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                local equipedGemEquip = self:getAllEquipmentEquipedGlyph(haveEquipmentArr, false)
                self._bagGridList.haveGlyphEquipArr = equipedGemEquip

                local wearEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
                local equipedGemEquip = self:getAllEquipmentEquipedGlyph(wearEquipmentArr, true)
                self._bagGridList.haveGlyphWearEquipArr = equipedGemEquip
            end
        end
    end
end

function BagGoodsPanel:ctor(usedType,showWear,checkItemUseState)
    BagGoodsPanel.super.ctor(self, UIType.BAG_GOODS_PANEL, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)
    self.showBagType = {
        [BAG_TYPE.ALL] = true,
        [BAG_TYPE.WEAR_EQUIP] = true,
        [BAG_TYPE.EQUIPMENT] = true,
        [BAG_TYPE.ITEM] = true,
        [BAG_TYPE.MATERIAL] = true,
        [BAG_TYPE.GEM_STONE] = true,
        -- [BAG_TYPE.WAREHOUSE] = true,
        [BAG_TYPE.RELIC] = true,
        [BAG_TYPE.GLYPH] = false,
        [BAG_TYPE.GLYPH_EQUIP_WEAR] = false,
        [BAG_TYPE.GLYPH_EQUIP] = false,
        [BAG_TYPE.GLYPH_ALL] = false,
    }
    self._contentLayout = nil

    -- 存放要删除的格子
    self._deleteItemTable = {}
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

    self._goodsTabList = nil
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
    self._operationList[PublicDefine.GOODS_TYPE.GOODS_GLYPH] = {}

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

--设置是否能用解锁的道具
function BagGoodsPanel:setUseLock(var)
    local change = false
    if(self._externalUseLock == self._useLock) then
        change = true
    end

    self._externalUseLock = var
    if(change) then
        self._useLock = self._externalUseLock
    end
end

function BagGoodsPanel:lockStatusChange(data)
    print("BagGoodsPanel:lockStatusChange")
    self._bagGridList:updataGridCanUseState(self._checkItemUseState, self._useLock, self._deleteState, self._usedType)
end

function BagGoodsPanel:sellGoodsResult(data)
    if(data and data.result) then
        GameErrorManager:showError(ProtobufUtil:enum_id("NPCSystem.SellGoodsResultType", data.result))
    end

    UI.WaitingLayer:hideWaiting()

    self._waitingRefreshGrid = 2
    -- updateGridList(self, self._data)
end

function BagGoodsPanel:loseGoodsResult()
    UI.WaitingLayer:hideWaiting()
    self._waitingRefreshGrid = 2
end

--根据类型获取用户道具数据
function BagGoodsPanel:getGoodsData(GoodsType,id,isGolden)
    if GoodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        for i = 1, #self._data.haveEquipmentArr do
            if self._data.haveEquipmentArr[i]:getEntityID() == id then
                return self._data.haveEquipmentArr[i]
            end
        end

        for i = 1, #self._data.wearEquipmentArr do
            if self._data.wearEquipmentArr[i]:getEntityID() == id then
                return self._data.wearEquipmentArr[i]
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        if(self._data.havePetEquipmentArr) then
            for i = 1, #self._data.havePetEquipmentArr do
                if self._data.havePetEquipmentArr[i]:getEntityID() == id then
                    return self._data.havePetEquipmentArr[i]
                end
            end
        end

        if(self._data.wearPetEquipmentArr) then
            for i = 1, #self._data.wearPetEquipmentArr do
                if self._data.wearPetEquipmentArr[i]:getEntityID() == id then
                    return self._data.wearPetEquipmentArr[i]
                end
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM then
        for i = 1, #self._data.haveItemArr do
            if self._data.haveItemArr[i]:getGoodsID() == id and self._data.haveItemArr[i]:getIsGolden() == isGolden then
                return self._data.haveItemArr[i]
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
        for i = 1, #self._data.haveMaterialArr do
            if self._data.haveMaterialArr[i]:getGoodsID() == id and self._data.haveMaterialArr[i]:getIsGolden() == isGolden then
                return self._data.haveMaterialArr[i]
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
        for i = 1, #self._data.haveTreasureArr do
            if self._data.haveTreasureArr[i]:getGoodsID() == id and self._data.haveTreasureArr[i]:getIsGolden() == isGolden then
                return self._data.haveTreasureArr[i]
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
        for i = 1, #self._data.haveGemStoneArr do
            if self._data.haveGemStoneArr[i]:getGoodsID() == id and self._data.haveGemStoneArr[i]:getIsGolden() == isGolden then
                return self._data.haveGemStoneArr[i]
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC then
        for i = 1, #self._data.haveRelicArr do
            if self._data.haveRelicArr[i]:getEntityID() == id then
                return self._data.haveRelicArr[i]
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        for i = 1, #self._data.haveGlyphArr do
            if self._data.haveGlyphArr[i]:getGoodsID() == id then
                return self._data.haveGlyphArr[i]
            end
        end
    end
end

--根据物品数据获取背包页
function BagGoodsPanel:getGemStoneBagIndex()
    return BAG_TYPE.GEM_STONE
end

-- 获取穿戴页编号
function BagGoodsPanel:getEquipBagIndex()
    return BAG_TYPE.WEAR_EQUIP
end

function BagGoodsPanel:getEquipmentsIndex()
    return BAG_TYPE.EQUIPMENT
end

--根据物品数据获取背包页
function BagGoodsPanel:getChangeBagIndexByGoodsData(goodsData)
    if goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then

        if self._showWear then
            for i = 1, #self._data.haveEquipmentArr do
                if self._data.haveEquipmentArr[i]:getEntityID() == goodsData:getEntityID() then
                    return BAG_TYPE.EQUIPMENT
                end
            end

            for i = 1, #self._data.wearEquipmentArr do
                if self._data.wearEquipmentArr[i]:getEntityID() == goodsData:getEntityID() then
                    return BAG_TYPE.WEAR_EQUIP
                end
            end
        else
            return BAG_TYPE.EQUIPMENT
        end
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        if self._showWear then
            if(self._data.havePetEquipmentArr) then
                for i = 1, #self._data.havePetEquipmentArr do
                    if self._data.havePetEquipmentArr[i]:getEntityID() == goodsData:getEntityID() then
                        return BAG_TYPE.EQUIPMENT
                    end
                end
            end

            if(self._data.wearPetEquipmentArr) then
                for i = 1, #self._data.wearPetEquipmentArr do
                    if self._data.wearPetEquipmentArr[i]:getEntityID() == goodsData:getEntityID() then
                        return BAG_TYPE.WEAR_EQUIP
                    end
                end
            end
        else
            return BAG_TYPE.EQUIPMENT
        end
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM then
        return BAG_TYPE.ITEM
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
        return BAG_TYPE.MATERIAL
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
        return BAG_TYPE.GEM_STONE
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC then
        return BAG_TYPE.RELIC
    elseif goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        return BAG_TYPE.GLYPH
    end
    return BAG_TYPE.ALL
end

--根据类型获取用户道具数据,如果有没点金的返回没点金的,否者返回点金的
function BagGoodsPanel:getGoodsDataLoseGoldenByData(data)
    if data:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        return self:getGoodsDataLoseGolden(data:getType(),data:getEntityID(), data:getBagType())
    else
        return self:getGoodsDataLoseGolden(data:getType(),data:getGoodsID(), data:getBagType())
    end
end

--根据类型获取用户道具数据,如果有没点金的返回没点金的,否者返回点金的
function BagGoodsPanel:getGoodsDataLoseGolden(GoodsType,id, packageType)

    local function _getGoodsData(itemArr)
        local goodsData = nil
        for i = #itemArr, 1, -1 do
            if itemArr[i]:getGoodsID() == id then
                if itemArr[i]:getNum() + itemArr[i]._changeNum > 0 then
                    if goodsData == nil then
                        goodsData = itemArr[i]
                    else
                        if goodsData:getIsGolden() == false and itemArr[i]:getIsGolden() == false then
                            if goodsData:getNum() + goodsData._changeNum > itemArr[i]:getNum() + itemArr[i]._changeNum then
                                goodsData = itemArr[i]
                            end
                        elseif goodsData:getIsGolden() == true and itemArr[i]:getIsGolden() == false then
                            goodsData = itemArr[i]
                        elseif goodsData:getIsGolden() == true and itemArr[i]:getIsGolden() == true then
                            if goodsData:getNum() + goodsData._changeNum > itemArr[i]:getNum() + itemArr[i]._changeNum then
                                goodsData = itemArr[i]
                            end
                        end
                    end
                end
            end
        end
        return goodsData
    end

    local haveEquipmentArr = {}
    local havePetEquipmentArr = {}
    local wearEquipmentArr = {}
    
    local haveItemArr = {}
    local haveMaterialArr = {}
    local haveGemStoneArr = {}
    local haveRelicArr = {}
    local haveTreasureArr = {}

    if packageType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE then
        local master = RoleDataManager:getMaster()
        haveEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),packageType,PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
        havePetEquipmentArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),packageType,PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
        haveItemArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),packageType,PublicDefine.GOODS_TYPE.GOODS_ITEM)
        haveMaterialArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),packageType,PublicDefine.GOODS_TYPE.GOODS_MATERIAL)
        haveGemStoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),packageType,PublicDefine.GOODS_TYPE.GOODS_GEM_STONE)
        haveRelicArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),packageType,PublicDefine.GOODS_TYPE.GOODS_RELIC)
        haveTreasureArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),packageType,PublicDefine.GOODS_TYPE.GOODS_TREASURE)
        
    else
        haveEquipmentArr = self._data.haveEquipmentArr
        havePetEquipmentArr = self._data.havePetEquipmentArr
        wearEquipmentArr = self._data.wearEquipmentArr
        haveItemArr = self._data.haveItemArr
        haveMaterialArr = self._data.haveMaterialArr
        haveGemStoneArr = self._data.haveGemStoneArr
        haveRelicArr = self._data.haveRelicArr
        haveTreasureArr = self._data.haveTreasureArr
    end

    local goodsData = nil
    if GoodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        for i = 1, #haveEquipmentArr do
            if haveEquipmentArr[i]:getEntityID() == id then
                return haveEquipmentArr[i]
            end
        end

        for i = 1, #wearEquipmentArr do
            if wearEquipmentArr[i]:getEntityID() == id then
                return wearEquipmentArr[i]
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        if(havePetEquipmentArr) then
            for i = 1, #havePetEquipmentArr do
                if havePetEquipmentArr[i]:getEntityID() == id then
                    return havePetEquipmentArr[i]
                end
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM then
        return _getGoodsData(haveItemArr)
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
        return _getGoodsData(haveMaterialArr)
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
        return _getGoodsData(haveGemStoneArr)
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC then
        for i = 1, #haveRelicArr do
            if haveRelicArr[i]:getEntityID() == id then
                return haveRelicArr[i]
            end
        end
    elseif GoodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
        return _getGoodsData(haveTreasureArr)
    end
    return goodsData
end

function BagGoodsPanel:showMove()
    -- if(self._bagGridList) then
    --     self._bagGridList:showMove()
    -- end
end

-- 隐藏移动效果
function BagGoodsPanel:hideMove()
    if(self._bagGridList) then
        self._bagGridList:hideMove()
    end
end

function BagGoodsPanel:dtor()
    BagGoodsPanel.super.dtor(self)
    self._contentLayout = nil

    self._itemdestroy = nil
    self._deleteButton = nil 
    self._selectedBagGrid = nil
    self._selectedRoleGrid = nil
    self._deleteState = false

    self._tabIndex = 1
    self._waitingRefreshGrid = -1
    self._goodsTabList = nil

    for k,v in pairs(self._data.wearEquipmentArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.wearPetEquipmentArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveEquipmentArr) do
        v._changeNum = 0
        v.canUseState = true
    end
    for k,v in pairs(self._data.havePetEquipmentArr) do
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

    for k,v in pairs(self._data.haveTreasureArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    for k,v in pairs(self._data.haveGlyphArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    --仓库数据清理
    local master = RoleDataManager:getMaster()
    local bagArr = GoodsDataManager:getPackArrForPK(master:getPK(), PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE)

    if bagArr then
        for _, typeArr in pairs(bagArr) do
            for k,v in pairs(typeArr)  do
                v._changeNum = 0
                v.canUseState = true
            end
        end
    end

    self:unRegisterListener()
end


-- public:
-- 初始化
function BagGoodsPanel:init(spriteID, type, fliterType)
    self._tabIndex = 1
    self._spriteID = spriteID
    self._type = type or GameBagUIType.NORMAL
    self._fliterType = fliterType

    -- 添加右边简洁背包数据
    local bagData = GameDataManager:getInstance():getPacketBoxData()
    --克隆背包数据
    self._data = bagData

    refreshBagData(self)

    BagGoodsPanel.super.init(self)
    -- self:setInterceptTouches(true)
end

-- 根据请求条件获取快捷背包里面符合条件的物品列表
function BagGoodsPanel:getGoodsDataArr(goodsID, isGolden, entityID)
    local goodsType = GoodsDataManager:getGoodsTypeForGoodsID(goodsID)

    local goodsArr = {}

    if goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT then
        for k, v in pairs(self._data.wearEquipmentArr) do 
            if(v:getEntityID() == entityID) then
                table.insert(goodsArr,v)
                return goodsArr
            end 
       end
       for k, v in pairs(self._data.haveEquipmentArr) do 
            if(v:getEntityID() == entityID) then
                table.insert(goodsArr,v)
                return goodsArr
            end 
       end 
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT then
        if(self._data.wearPetEquipmentArr) then
            for k, v in pairs(self._data.wearPetEquipmentArr) do 
                if(v:getEntityID() == entityID) then
                    table.insert(goodsArr,v)
                    return goodsArr
                end 
            end
        end
        if(self._data.havePetEquipmentArr) then
            for k, v in pairs(self._data.havePetEquipmentArr) do 
                if(v:getEntityID() == entityID) then
                    table.insert(goodsArr,v)
                    return goodsArr
                end 
            end 
        end
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM then
        for k, v in pairs(self._data.haveItemArr) do 
            if(v:getGoodsID() == goodsID and v:getIsGolden() == isGolden) then
                table.insert(goodsArr,v)
            end 
        end 
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_MATERIAL then
       for k, v in pairs(self._data.haveMaterialArr) do 
            if(v:getGoodsID() == goodsID and v:getIsGolden() == isGolden) then
                table.insert(goodsArr,v)
            end 
        end 
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
        for k, v in pairs(self._data.haveTreasureArr) do 
             if(v:getGoodsID() == goodsID and v:getIsGolden() == isGolden) then
                 table.insert(goodsArr,v)
             end 
         end 
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
       for k, v in pairs(self._data.haveGemStoneArr) do 
            if(v:getGoodsID() == goodsID and v:getIsGolden() == isGolden) then
                table.insert(goodsArr,v)
            end 
        end 
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_RELIC then
        for k, v in pairs(self._data.haveRelicArr) do
            if(v:getEntityID() == entityID) then
                table.insert(goodsArr,v)
                return goodsArr
            end
        end
    elseif goodsType == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
        for k, v in pairs(self._data.haveGlyphArr) do
            if(v:getEntityID() == entityID) then
                table.insert(goodsArr,v)
                return goodsArr
            end
        end
    end

    return goodsArr
end

-- 模版函数：初始化组建的视图
function BagGoodsPanel:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 添加背景
    local imageBG = UI.Image:create()
    imageBG:init(SPRITE_BG)
    imageBG:center()
    -- momeyImageBG:setPos(16,0)
    self._contentLayout:addChild(imageBG)
    self.imageBG = imageBG

    self:setTouchEnable(true)
    self:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE_ENDED, self, function(self)
        print("BagGoodsPanel:onInitView  COMPONENT_TOUCH_OUTSIDE_ENDED", self._deleteState)
        if(self._deleteState) then
            cancelDeleteState(self)
            cancelAllDeleteChoice(self)
        end
    end)
    local bagList = UI.GoodsListNew:create(5, nil, nil, self._fliterType)
    self._bagGridList = bagList
    self:initBagListData()
    bagList:init(bagData)
    bagList:setPos(14+3,75)
    bagList:setCallbackForGridClick(self, self.bagClickCallback)
    bagList:setCallbackForGridDragBegan(self, self.bagDragBeganCallback)
    bagList:setCallbackForGridDragMoved(self, self.bagDragMovedCallback)
    bagList:setCallbackForGridDragEnded(self, self.bagDragEndedCallback)
    bagList:setDoubleClickAsDragEnd(true)
    self._contentLayout:addChild(bagList, 4)
    bagList:showMask()

    -- 上边的分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(387, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(27 + lineUpImage:getContentSize().width/2, 508 - 6))
    self._contentLayout:addChild(lineUpImage, 4)
    
    local lineDownImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineDownImage:setContentSize(387, 1)
    lineDownImage:setCapInsets(CCRectMake(1,0,1,1))
    lineDownImage:setPosition(cc.p(27 + lineDownImage:getContentSize().width/2, 508 - 6 - 370))
    self._contentLayout:addChild(lineDownImage, 4)

    -- 处理背包显示
    local gridOffsetY = 89 + 6
    local gridOffsetX = 52
    local gridImage = UI.Image:create()
    gridImage:init(SPRITE_GAME_BACKPACK)
    gridImage:leftBottom(gridOffsetX,gridOffsetY)
    self._contentLayout:addChild(gridImage, 4)
    -- 可用格子
    local gridCountLabel = UI.GridText:create()
    gridCountLabel:init(string.format("%s/%s", 0, 0), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    gridCountLabel:leftBottom(gridOffsetX + 45, gridOffsetY + 10)
    gridCountLabel:setSize(90, 30)
    -- gridCountLabel:setTextCenter()
    self._contentLayout:addChild(gridCountLabel, 4)
    self._gridCountLabel = gridCountLabel


    -- 删除装备时高亮动画
    local itemdestroy = UI.Animation:create()
    itemdestroy:init(FX_ITEMDESTROY_JSON,FX_ITEMDESTROY_ATLAS)
    itemdestroy:centerLeft(218)
    -- itemdestroy:setAnimation("animation2", true)
    itemdestroy:hide()
    self._contentLayout:addChild(itemdestroy, 4)
    self._itemdestroy = itemdestroy

    -- 物品分类按钮
    local goodsTabList = UI.TabList:create()
    goodsTabList:init(
        BAG_GOODS_LAYOUT.GOODS_LIST_TAB_BUTTON_SPACE, 
        BAG_GOODS_LAYOUT.GOODS_LIST_TAB_BUTTON_WIDTH, 
        BAG_GOODS_LAYOUT.GOODS_LIST_TAB_BUTTON_HEIGHT
    )
    goodsTabList:leftBottom(35, 32)
    goodsTabList:addEventListener(UIEvent.TAB_ACTIVE, self, onActiveGoodsTabHandler)
    self._contentLayout:addChild(goodsTabList)
    self._goodsTabList = goodsTabList
    
    -- 所有物品
    if self.showBagType[BAG_TYPE.ALL] then
        local allGoodsTab = UI.GoodsTabItem:create()
        allGoodsTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_ALL_GOODS_BUTTON_NORMAL, SPRITE_GRID_ALL_GOODS_BUTTON_ACTIVE)
        goodsTabList:addToTab(allGoodsTab,BAG_TYPE.ALL)
    end

    

    -- 穿戴
    if self.showBagType[BAG_TYPE.WEAR_EQUIP] then
        if self._showWear then
            local allGoodsTab = UI.GoodsTabItem:create()
            allGoodsTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_EQUIP_BUTTON_NORMAL, SPRITE_GRID_EQUIP_BUTTON_ACTIVE)
            goodsTabList:addToTab(allGoodsTab,BAG_TYPE.WEAR_EQUIP)
        end
    end


    -- 符文穿戴
    if self.showBagType[BAG_TYPE.GEM_STONE_EQUIP_WEAR] then
        local allGoodsTab = UI.GoodsTabItem:create()
        allGoodsTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_EQUIP_BUTTON_NORMAL, SPRITE_GRID_EQUIP_BUTTON_ACTIVE)
        goodsTabList:addToTab(allGoodsTab,BAG_TYPE.GEM_STONE_EQUIP_WEAR)
    end

    -- 装备
    if self.showBagType[BAG_TYPE.EQUIPMENT] then
        local equipmentTab = UI.GoodsTabItem:create()
        equipmentTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_EQUIPMENT_BUTTON_NORMAL, SPRITE_GRID_EQUIPMENT_BUTTON_ACTIVE)
        goodsTabList:addToTab(equipmentTab,BAG_TYPE.EQUIPMENT)
    end
    -- 道具
    if self.showBagType[BAG_TYPE.ITEM] then
        local itemTab = UI.GoodsTabItem:create()
        itemTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_ITEM_BUTTON_NORMAL, SPRITE_GRID_ITEM_BUTTON_ACTIVE)
        goodsTabList:addToTab(itemTab,BAG_TYPE.ITEM)
    end
    -- 材料
    if self.showBagType[BAG_TYPE.MATERIAL] then
        local materialTab = UI.GoodsTabItem:create()
        materialTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_MATERIAL_BUTTON_NORMAL, SPRITE_GRID_MATERIAL_BUTTON_ACTIVE)
        goodsTabList:addToTab(materialTab,BAG_TYPE.MATERIAL)
    end
    -- 宝石
    if self.showBagType[BAG_TYPE.GEM_STONE] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_GEM_STONE_BUTTON_NORMAL, SPRITE_GRID_GEM_STONE_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.GEM_STONE)
    end
    -- 遗物
    if self.showBagType[BAG_TYPE.RELIC] then
        local relicTab = UI.GoodsTabItem:create()
        relicTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_RELIC_BUTTON_NORMAL, SPRITE_GRID_RELIC_BUTTON_ACTIVE)
        goodsTabList:addToTab(relicTab,BAG_TYPE.RELIC)
    end

    if self.showBagType[BAG_TYPE.PET_SLOT_STONE_ONE] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_PET_SLOT_STONE_ONE_BUTTON_NORMAL, SPRITE_GRID_PET_SLOT_STONE_ONE_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.PET_SLOT_STONE_ONE)
    end

    if self.showBagType[BAG_TYPE.PET_SLOT_STONE_TWO] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_PET_SLOT_STONE_TWO_BUTTON_NORMAL, SPRITE_GRID_PET_SLOT_STONE_TWO_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.PET_SLOT_STONE_TWO)
    end

    if self.showBagType[BAG_TYPE.PET_SLOT_STONE_THREE] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_PET_SLOT_STONE_THREE_BUTTON_NORMAL, SPRITE_GRID_PET_SLOT_STONE_THREE_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.PET_SLOT_STONE_THREE)
    end

    if self.showBagType[BAG_TYPE.PET_EQUIPMENT_ONE] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_PET_EQUIPMENT_ONE_BUTTON_NORMAL, SPRITE_GRID_PET_EQUIPMENT_ONE_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.PET_EQUIPMENT_ONE)
    end

    if self.showBagType[BAG_TYPE.PET_EQUIPMENT_TWO] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_PET_EQUIPMENT_TWO_BUTTON_NORMAL, SPRITE_GRID_PET_EQUIPMENT_TWO_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.PET_EQUIPMENT_TWO)
    end

    if self.showBagType[BAG_TYPE.PET_EQUIPMENT_THREE] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_PET_EQUIPMENT_THREE_BUTTON_NORMAL, SPRITE_GRID_PET_EQUIPMENT_THREE_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.PET_EQUIPMENT_THREE)
    end
    
    -- 仓库
    if self.showBagType[BAG_TYPE.WAREHOUSE] then
        local gemStoneTab = UI.GoodsTabItem:create(UIType.TABITEM_WAREHOUSE)
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_WAREHOUSE_BUTTON_NORMAL, SPRITE_GRID_WAREHOUSE_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.WAREHOUSE)
    end

    -- 宠物宝石
    if self.showBagType[BAG_TYPE.PET_STONE] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_PET_STONE_BUTTON_NORMAL, SPRITE_GRID_PET_STONE_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.PET_STONE)
    end

    -- 雕文
    if self.showBagType[BAG_TYPE.GLYPH] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_GLYPH_BUTTON_NORMAL, SPRITE_GRID_GLYPH_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.GLYPH)
    end

    -- 身上装备上的雕文
    if self.showBagType[BAG_TYPE.GLYPH_EQUIP_WEAR] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_GLYPH_BUTTON_NORMAL, SPRITE_GRID_GLYPH_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.GLYPH_EQUIP_WEAR)
    end

    -- 背包里装备上的雕文
    if self.showBagType[BAG_TYPE.GLYPH_EQUIP] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_GLYPH_BUTTON_NORMAL, SPRITE_GRID_GLYPH_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.GLYPH_EQUIP)
    end

    -- 背包里装备上的雕文
    if self.showBagType[BAG_TYPE.GLYPH_ALL] then
        local gemStoneTab = UI.GoodsTabItem:create()
        gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_GLYPH_BUTTON_NORMAL, SPRITE_GRID_GLYPH_BUTTON_ACTIVE)
        goodsTabList:addToTab(gemStoneTab,BAG_TYPE.GLYPH_ALL)
    end
    


    local curreyY = 89
    -- 黄金
    local momeyImage = UI.Image:create()
    momeyImage:init(SPRITE_GAMING_MOMEY)
    momeyImage:leftUp(76, curreyY)
    self._contentLayout:addChild(momeyImage, 4)
    self.momeyImage = momeyImage
    -- 黄金数量
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._momey:setTextLeft()
    -- self._momey:leftUp(76 + 28, curreyY)
    self._momey:centerLeft(momeyImage:getContentSize().width + 4)
    momeyImage:addChild(self._momey, 4)


    -- 钻石
    local diamondImage = UI.Image:create()
    diamondImage:init(SPRITE_GAMING_DIAMOND)
    diamondImage:leftUp(220, curreyY)
    self._contentLayout:addChild(diamondImage, 4)
    self.diamondImage = diamondImage
    -- 钻石数量
    self._diamond = UI.Text:create()
    self._diamond:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._diamond:setTextLeft()
    -- self._diamond:leftUp(220 + 28, curreyY)
    self._diamond:centerLeft(diamondImage:getContentSize().width + 4)
    diamondImage:addChild(self._diamond, 4)

    -- 铭文
    local configGlyph = ConfigManager:getGeneralForKey("glyphCommonRefinedConsume")
    local epigraphGoodsID = tonumber((string.split(configGlyph, ","))[1])
    local virtualData = GoodsDataManager:createVirtualData(epigraphGoodsID)
    local epigraphImage = UI.Image:create()
    epigraphImage:init(virtualData:getSmallIconName())
    epigraphImage:leftUp(76, curreyY + 3)
    self._contentLayout:addChild(epigraphImage, 4)
    self.epigraphImage = epigraphImage

    -- 铭文数量
    self._epigraph = UI.Text:create()
    self._epigraph:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._epigraph:setTextLeft()
    self._epigraph:centerLeft(epigraphImage:getContentSize().width + 4)
    self.epigraphImage:addChild(self._epigraph, 4)

    self.epigraphImage:setVisible(false)

    -- 原石碎片
    -- local configGlyph = ConfigManager:getGeneralForKey("glyphCommonRefinedConsume")
    local primogemFragGoodsID = 23530001--tonumber((string.split(configGlyph, ","))[1])
    local virtualData = GoodsDataManager:createVirtualData(primogemFragGoodsID)
    local primogemFragImage = UI.Image:create()
    primogemFragImage:init(virtualData:getSmallIconName())
    primogemFragImage:leftUp(76, curreyY + 3)
    self._contentLayout:addChild(primogemFragImage, 4)
    self.primogemFragImage = primogemFragImage

    -- 原石碎片数量
    self._primogemFrag = UI.Text:create()
    self._primogemFrag:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._primogemFrag:setTextLeft()
    self._primogemFrag:centerLeft(primogemFragImage:getContentSize().width + 4)
    self.primogemFragImage:addChild(self._primogemFrag, 4)

    self.primogemFragImage:setVisible(false)

    local shopButton = UI.Button:create()
    shopButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, false, 1, nil,
            PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_Bag)
    end)
    shopButton:rightUp(43 + 3, curreyY + diamondImage:getContentSize().height/2 - shopButton:getContentSize().height/2)
    self._contentLayout:addChild(shopButton, 4)
    local SceneManager = require("app.game.SceneManager")
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase)
        and not SceneManager:getInstance():isInStory() 
     then
        shopButton:show()
    else
        shopButton:hide()
    end
    self.shopButton = shopButton

    local typeRight = 88
    if self._type == GameBagUIType.CAVE_SHOP or SceneManager:getInstance():isInFightScene() then
        -- 一键卖垃圾
        local sellGarbage = UI.Image:create()
        sellGarbage:init(SPRITE_GRID_DELETE_BUTTON_BG)
        sellGarbage:rightUp(typeRight,40)
        sellGarbage:setSize(55,38)

        sellGarbage:setTouchEnable(true)
        sellGarbage:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function (self)
            sellGarbage:setScale(1.1)
        end)
        sellGarbage:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function (self)
            sellGarbage:setScale(1.0)
        end)
        sellGarbage:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
            print("sellGarbage:addEventListener(UIEvent.BUTTON_CLICK")
            -- 卖掉所有的垃圾物品
            self:sellGarbageEquipments()
            Avalon.AudioManager:playSound("1503")
        end)

        local sellButton = UI.Image:create()
        sellButton:init(SPRITE_FUNCTION_SELL_NORMAL)
        sellButton:center()
        sellGarbage:addChild(sellButton)

        self._contentLayout:addChild(sellGarbage)
        self._sellGarbage = sellGarbage
        self._sellImage = sellButton
    end

    -- 删除按钮
    local deleteButtonBG = UI.Image:create(nil, nil, UIType.TABITEM_BATCH_DELETE)
    deleteButtonBG:init(SPRITE_GRID_DELETE_BUTTON_BG)
    deleteButtonBG:rightUp(typeRight + 60,40)
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
    if not self._sellImage then
        deleteButtonBG:rightUp(typeRight,40)
    end

    if self._usedType then
        for k,v in pairs(self._usedType) do
            if v.goodType == PublicDefine.GOODS_TYPE.GOODS_PET_STONE or 
            v.goodType == PublicDefine.GOODS_TYPE.GOODS_TREASURE then
                deleteButtonBG:hide()
                break
            end
        end
    end
    

    if(self._type == GameBagUIType.CAVE_SHOP) then
        self._tabIndex = 1
    elseif( self._type == GameBagUIType.BLACK_SHOP) then
        self._tabIndex = 1
    else
        self._tabIndex = 2
    end

    updateGridList(self,self._data)
    self:updateMoneyView()

    self:refreshDeleteButton()
    self:refreshSellButton()
end

-- 刷新销毁按钮状态
function BagGoodsPanel:refreshDeleteButton()
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
function BagGoodsPanel:refreshSellButton()
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
function BagGoodsPanel:getDeleteNormal()
    -- 根据页面类型返回图片
    -- if self._type == GameBagUIType.CAVE_SHOP or self._type == GameBagUIType.BLACK_SHOP then
        return SPRITE_FUNCTION_CHOICE_NORMAL
    -- else
    --     return SPRITE_FUNCTION_DUSTBIN_NORMAL
    -- end
end

-- 获取删除点击
function BagGoodsPanel:getDeleteClick()
    -- 根据页面类型返回图片
    -- if self._type == GameBagUIType.CAVE_SHOP or self._type == GameBagUIType.BLACK_SHOP then
        return SPRITE_FUNCTION_CHOICE_ACTIVE
    -- else
    --     return SPRITE_FUNCTION_DUSTBIN_ACTIVE
    -- end
end

-- 获取删除确认资源
function BagGoodsPanel:getDeleteConfirm()
    return SPRITE_FUNCTION_CONFIRM
end

-- 模版函数：组件尺寸更新
function BagGoodsPanel:onSizeChanged(originalWidth, originalHeight)

end

function BagGoodsPanel:getIsShowSellPrice()
    if(self._type == GameBagUIType.CAVE_SHOP or self._type == GameBagUIType.BLACK_SHOP) then
       return true
    else 
        return false
    end
end

-- 设置刷新标志
function BagGoodsPanel:setRefreshFlag(flag)
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
function BagGoodsPanel:changeBagIndex(index)
    print("BagGoodsPanel:changeBagIndex ",index)
    self._tabIndex = index
    if(self._goodsTabList) then
        self._goodsTabList:activeTab(index)
    end

end

function BagGoodsPanel:getBagIndex()
    return self._tabIndex
end

function BagGoodsPanel:changeBagDefaultIndex(index)
    print("BagGoodsPanel:changeBagDefaultIndex ",index)
    if(self._goodsTabList) then
        self._goodsTabList:setDefaultIndex(index)
    end
end 

-- 隐藏某个tab
function BagGoodsPanel:hideTabByIndex(tabIndex)
    if(self._goodsTabList) then
        self._goodsTabList:hideTab(tabIndex)
    end
end

-- 显示某个tab
function BagGoodsPanel:showTabByIndex(tabIndex)
    if(self._goodsTabList) then
        self._goodsTabList:showTab(tabIndex)
    end
end

function BagGoodsPanel:disableTabByIndex(tabIndex)
    if(self._goodsTabList) then
        self._goodsTabList:disableTab(tabIndex)
    end
end

function BagGoodsPanel:removeDisableByIndex(tabIndex)
    if(self._goodsTabList) then
        self._goodsTabList:removeDisableTab(tabIndex)
    end
end



function BagGoodsPanel:updateMoneyView()
    print("BagGoodsPanel:updateMoneyView()  ")
    self._momey:setText(self._momey:numformat(string.format("%d",GameDataManager:getInstance():getCurCoin())))
    self._momey:updateView()
    self._diamond:setText(self._diamond:numformat(string.format("%d",GameDataManager:getInstance():getDiamond())))
    self._diamond:updateView()
    self._epigraph:setText(self._epigraph:numformat(string.format("%d",GameDataManager:getInstance():getInscription())))
    self._epigraph:updateView()
    self._primogemFrag:setText(self._primogemFrag:numformat(string.format("%d",GameDataManager:getInstance():getPrimogeDebrisNum())))
    self._primogemFrag:updateView()
end

-- private  私有函数
function BagGoodsPanel:sellGarbageEquipments()
    -- print("BagGoodsPanel:sellGarbageEquipments")
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
        print("BagGoodsPanel:sellGarbageEquipments    cancel.")
    end
    print("BagGoodsPanel:sellGarbageEquipments sellPrice=", sellPrice)
    
    UI.TipsLayer:onSalesEquipment(okCallBack, cancelCallBack, sellPrice)
end

-- 关闭选中
function BagGoodsPanel:closeChoese()
    if self._selectedBagGrid then 
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil 
    end
end

function BagGoodsPanel:updateDeleteCallback(deleteItemTable)
    --重载来实现该方法
end

function BagGoodsPanel:bagClickCallback(bagGrid)
    print("BagGoodsPanel:bagClickCallback")
    if self._isDraging then 
        return 
    end

    if (DEBUG) then
        print(string.format("BagGoodsPanel:bagClickCallback: grid index:%d.", bagGrid:getIndex()))
    end

    local goodsData = nil
    if (bagGrid) then
        goodsData = bagGrid:getData()
        if self._deleteState == true then 
            if goodsData and bagGrid:getCanUseState() then 
                if bagGrid:deleteItem() then 
                    self._deleteButton:setSpriteName(self:getDeleteConfirm())
                    table.insert(self._deleteItemTable,goodsData)
                else
                    for i=#self._deleteItemTable, 1, -1 do 
                        if self._deleteItemTable[i] == goodsData then 
                            table.remove(self._deleteItemTable,i) 
                        end 
                    end 
                end
                -- print("=====数量",#self._deleteItemTable)
                if #self._deleteItemTable == 0 then 
                    self._deleteButton:setSpriteName(self:getDeleteClick())
                end
            end

            self:updateDeleteCallback(self._deleteItemTable)

            -- 暂时不打开装备页面
            self._bagGridList:refrehDeleteGrid(self._deleteItemTable, false)
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
                local leftX = -274-20

                local worldPos = self._contentLayout:convertToWorldSpace(cc.p(0,0))
                local rightX =  winSize.width - worldPos.x - 20

                -- 类型
                if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
                    -- 装备详情
                    local equipmentInfoArea = UI.EquipmentInfoArea:create()
                    equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                    self._infoArea = equipmentInfoArea
                    -- 处理试穿对比
                    local blackTable = GameDataManager:getInstance():tryEquipment(goodsData)
                    equipmentInfoArea:updateInfo(blackTable)
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
                    -- 装备详情
                    local equipmentInfoArea = UI.EquipmentPetInfoArea:create()
                    equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
                    self._infoArea = equipmentInfoArea
                    equipmentInfoArea:updateInfo(goodsData, MasterDataManager:getFightWearEquipmentForEquipmentType(goodsData:getEquipmentType()))
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
                        if(self._bagGridList:getIsChoiceWareHouse()) then
                            propInfo:lockNextLevelBag()
                            propInfo:disableUse()
                        end
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
                    if goodsData.isWear or goodsData.isEquiped then
                        gemInfoArea:closeLockFlag()
                    end

                    self._infoArea = gemInfoArea
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then
                    local gemInfoArea = UI.StarPrayInfoArea:create()
                    gemInfoArea:init(goodsData)
                    self._infoArea = gemInfoArea
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then
                    local gemInfoArea = UI.PetStoneInfoArea:create()
                    if goodsData:getSlotIndex() ~= 0 then
                        -- 当宠物宝石在装备上时，不能进行加锁
                        gemInfoArea:closeLockFlag()
                    end
                    gemInfoArea:init(goodsData)
                    self._infoArea = gemInfoArea
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
                    local gemInfoArea = UI.RelicInfoArea:create()
                    gemInfoArea:init(goodsData)
                    self._infoArea = gemInfoArea
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then
                    local gemInfoArea = UI.GlyphInfoArea:create()
                    gemInfoArea:init(goodsData)
                    if goodsData.isWear or goodsData.isEquiped then
                        gemInfoArea:closeLockFlag()
                    end

                    self._infoArea = gemInfoArea
                end 
                if self._infoArea then
                    if(self:getIsShowSellPrice()) then
                        self._infoArea:setShowSellPrice(true)
                    end

                    local worldPos = bagGrid:convertToWorldSpace(cc.p(0,0))
                    if worldPos.x < winSize.width/2 then
                        self._infoArea:centerLeft(worldPos.x + bagGrid:getSize() + 20)
                    else
                        self._infoArea:centerLeft(worldPos.x - bagGrid:getSize() - 20)
                    end
                    self._infoArea:centerRight(rightX - 5)
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

function BagGoodsPanel:bagDragBeganCallback(goodsGrid, touchPosition)
    -- print("BagGoodsPanel:bagDragBeganCallback")
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

function BagGoodsPanel:bagDragMovedCallback(goodsGrid, touchPosition)
    -- print("BagGoodsPanel:bagDragMovedCallback")

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

function BagGoodsPanel:bagDragEndedCallback(goodsGrid, touchPosition)
    -- print("BagGoodsPanel:bagDragEndedCallback")
    if(self._deleteState) then
        return
    end
    self._isDraging = false
    if (self._targetForDragEnded and self._functionForDragEnded) then 
        Avalon.AudioManager:playSound("1505")
        self._functionForDragEnded(self._targetForDragEnded, goodsGrid, touchPosition, self:isPositionInBag(touchPosition))
    end
end

function BagGoodsPanel:isPositionInBag(touchPosition)
    local pos = self:convertToWorldSpace(cc.p(0, 0))
    local rect = cc.rect(pos.x, pos.y, self._width, self._height)
    local isInBag = cc.rectContainsPoint(rect, touchPosition)
    return isInBag;
end

-- 添加拖拽格子开始的处理回调函数
function BagGoodsPanel:setCallbackForGridDragBegan(target, func)
    self._targetForDragBegan = target
    self._functionForDragBegan = func
end

-- 添加拖拽格子的处理回调函数
function BagGoodsPanel:setCallbackForGridDragMoved(target, func)
    self._targetForDragMoved = target
    self._functionForDragMoved = func
end

-- 添加拖拽格子完成的处理回调函数
function BagGoodsPanel:setCallbackForGridDragEnded(target, func)
    self._targetForDragEnded = target
    self._functionForDragEnded = func
end

--刷新视图
function BagGoodsPanel:refreshView()
    self._waitingRefreshGrid = 2
    -- updateGridList(self,self._data)
end

--更新是否能拖拽
function BagGoodsPanel:updateCanDrag(var)
    self._bagGridList:updateCanDrag(var)
end

function BagGoodsPanel:setSpineBgVisible(visible)
    --self.dragSpineBag:setVisible(visible)
end

-- 重置操作状态
function BagGoodsPanel:resetHandleStatus()
    if(self._deleteState) then
        cancelDeleteState(self)
        cancelAllDeleteChoice(self)
    end 
end

function BagGoodsPanel:changeInSideStatus(inSide)
    if(self._bagGridList) then 
        self._bagGridList:changeInSideStatus(inSide)
    end
end

function BagGoodsPanel:setUsedType(usedType)
    usedType = usedType or {}

    local function isDiffUsedType(oldUsedType, newUsedType)
        if(oldUsedType and newUsedType) then 
            for i = 1, #oldUsedType do
                for j = 1, #newUsedType do
                    if oldUsedType[i].goodType == newUsedType[j].goodType then
                        if oldUsedType[i].type ~= newUsedType[j].type or 
                            oldUsedType[i].rare ~= newUsedType[j].rare or 
                            oldUsedType[i].heroLevel ~= newUsedType[j].heroLevel or 
                            oldUsedType[i].stoneLockMaxLV ~= newUsedType[j].stoneLockMaxLV or
                            oldUsedType[i].stoneShowLV ~= newUsedType[j].stoneShowLV or 
                            oldUsedType[i].gemStoneType ~= newUsedType[j].gemStoneType or 
                            oldUsedType[i].transDropGroupID ~= newUsedType[j].transDropGroupID or 
                            oldUsedType[i].needRefineFunc ~= newUsedType[j].needRefineFunc 
                        then
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
    usedType = usedType or {}
    if(self._usedType == nil) then 
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

function BagGoodsPanel:scrollToTop(duration, slowDown)
    self._bagGridList:scrollToTop(duration, slowDown)
end

function BagGoodsPanel:hideImageBg()
    self.imageBG:hide()
end

-- 注册监听事件(可选)
function BagGoodsPanel:registerListener()
    -- 监听消息
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE, self, onUpdateEquipmentListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, onUpdateRelicListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, onUpdateItemListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, onUpdateMaterialListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_TREASURE_CHANGE, self, onUpdateMaterialListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, onUpdateGemStoneListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, onWearEquipmentChangedHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT, self, self.sellGoodsResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_LOSE_RESULT, self, self.loseGoodsResult)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_WAREHOUSE, self, onUnlockWarehouseGridHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE, self, onUpdatePetEquipmentListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_WEAR_PET_EQUIPMENT_CHANGE, self, onWearPetEquipmentChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_GLYPH_CHANGE, self, onUpdateGlyphListHandler)

    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

-- 注销监听事件(可选)
function BagGoodsPanel:unRegisterListener()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE, self, onUpdateEquipmentListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, onUpdateRelicListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, onUpdateItemListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, onUpdateMaterialListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_TREASURE_CHANGE, self, onUpdateMaterialListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, onUpdateGemStoneListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, onWearEquipmentChangedHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_SELL_GOODS_RESULT, self, self.sellGoodsResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_LOSE_RESULT, self, self.loseGoodsResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_WAREHOUSE, self, onUnlockWarehouseGridHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE, self, onUpdatePetEquipmentListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_WEAR_PET_EQUIPMENT_CHANGE, self, onWearPetEquipmentChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_GLYPH_CHANGE, self, onUpdateGlyphListHandler)

    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

function BagGoodsPanel:update(dt)
    if(self._waitingRefreshGrid > -1) then
        if(self._waitingRefreshGrid == 0) then 
            updateGridList(self, self._data)
            self._waitingRefreshGrid = -1
        end
        self._waitingRefreshGrid = self._waitingRefreshGrid - 1
    end
end

function BagGoodsPanel:refreshPacketType(tabIndex)
    if tabIndex == BAG_TYPE.GLYPH then
        self._data.packetType = PublicDefine.PACKET_TYPE.PACKET_GLYPH
    else
        self._data.packetType = PublicDefine.PACKET_TYPE.PACKET_BAG
    end
end

function BagGoodsPanel:glyphsBagRefresh()
    if self.shopButton then
        self.shopButton:hide()
    end
    self.momeyImage:hide()
    --self.diamondImage:hide()
    self._bagGridList:hideBGImageCover()
    -- self._goodsTabList:hide()
    self.diamondImage:leftUp(220, 96)

    self.epigraphImage:setVisible(true)
end

function BagGoodsPanel:primogemBagRefresh()
    if self.shopButton then
        self.shopButton:hide()
    end
    self.momeyImage:hide()
    --self.diamondImage:hide()
    self._bagGridList:hideBGImageCover()
    -- self._goodsTabList:hide()
    self.diamondImage:leftUp(220, 96)

    self.primogemFragImage:setVisible(true)
end