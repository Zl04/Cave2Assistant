--[[
    背包中的角色功能面板
]]--

require "app.ui.baglayer.GoodsTabItem"
require "app.ui.baglayer.InfoArea.BasicInfoArea"
require "app.ui.baglayer.InfoArea.PropInfoArea"
require "app.ui.baglayer.InfoArea.PetEggInfoArea"
require "app.ui.baglayer.InfoArea.MaterialEquipScrollInfoArea"
require "app.ui.baglayer.InfoArea.SelectGoodsBagInfoArea"
require "app.ui.baglayer.RoleShow.RoleShowArea"
require "app.ui.baglayer.Grid.BagScrollView"
require "app.ui.baglayer.InfoArea.DetailedInfoArea"
require "app.ui.baglayer.InfoArea.EquipmentInfoArea"
require "app.ui.baglayer.InfoArea.EquipmentPetInfoArea"
require "app.ui.baglayer.InfoArea.GemStoneInfoArea"
require "app.ui.baglayer.InfoArea.StarPrayInfoArea"
require "app.ui.baglayer.InfoArea.PetStoneInfoArea"
require "app.ui.baglayer.InfoArea.LevelBagInfoArea"
require "app.ui.baglayer.InfoArea.RandomBagInfoArea"
require "app.ui.baglayer.InfoArea.GlyphInfoArea"
require "app.ui.baglayer.RoleShow.SelectEquipmentButton"
require "app.ui.common.GridList.GridList"
require "app.ui.common.GridText"
require "app.modules.pet.PetSkillBookInfoArea"

local SceneManager = require("app.game.SceneManager")
local GameDataManager = require("app.game.GameDataManager")
local LanguageManager = require "app.game.LanguageManager"

local ProtobufUtil = require "utils.ProtobufUtil"

UI = UI or {}
local RolePanel = class("RolePanel", UI.HWBtnComponent)
UI.RolePanel = RolePanel

-- private:
local winSize = cc.Director:getInstance():getWinSize()
local Scheduler = Avalon.Scheduler
local DEBUG = true
local DEBUG_DRAW = true
local GOODS_COST_TYPE = PublicDefine.GOODS_COST_TYPE

-- 尺寸
local COM_WIDTH = 978
local COM_HEIGHT = 555
-- 背包资源
local COM_RES_LIST = {
    "ui_general_share.plist",
    "ui_general_uishare.plist",
    "ui_common_information.plist",
    "ui_town_fisihing.plist",
}

-- 图片名字 --
---------------------------------------
-- 角色信息的背景
local SPRITE_ROLE_INFO_BG = "ui_role_banner_large_up.png"

-- 物品分类的背景图片
local SPRITE_GRID_ALL_BOX_NORMAL = "ui_goods_button_bg_down_0.png"
local SPRITE_GRID_ALL_BOX_ACTIVE = "ui_goods_button_bg_down_1.png"
-- 所有物品分类的图片
local SPRITE_GRID_ALL_GOODS_BUTTON_NORMAL = "ui_goods_button_all_0.png"
local SPRITE_GRID_ALL_GOODS_BUTTON_ACTIVE = "ui_goods_button_all_1.png"
local SPRITE_GRID_EQUIPMENT_BUTTON_NORMAL = "ui_goods_button_quipment_0.png"
local SPRITE_GRID_EQUIPMENT_BUTTON_ACTIVE = "ui_goods_button_quipment_1.png"
local SPRITE_GRID_ITEM_BUTTON_NORMAL = "ui_goods_button_prop_0.png"
local SPRITE_GRID_ITEM_BUTTON_ACTIVE = "ui_goods_button_prop_1.png"
local SPRITE_GRID_MATERIAL_BUTTON_NORMAL = "ui_goods_button_material_0.png"
local SPRITE_GRID_MATERIAL_BUTTON_ACTIVE = "ui_goods_button_material_1.png"
local SPRITE_GRID_GEM_STONE_BUTTON_NORMAL = "ui_goods_button_gem_0.png"
local SPRITE_GRID_GEM_STONE_BUTTON_ACTIVE = "ui_goods_button_gem_1.png"
local SPRITE_GRID_GEM_PET_STONE_BUTTON_NORMAL = "ui_goods_button_petsquipment_4_0.png"
local SPRITE_GRID_GEM_PET_STONE_BUTTON_ACTIVE = "ui_goods_button_petsquipment_4_1.png"
local SPRITE_GRID_GLYPH_BUTTON_NORMAL = "ui_goods_button_glyphs_1_0.png"
local SPRITE_GRID_GLYPH_BUTTON_ACTIVE = "ui_goods_button_glyphs_1_1.png"
-- 删除物品相关图片
local SPRITE_GRID_DELETE_BUTTON_BG = "ui_goods_button_bg_up_0.png"
local SPRITE_GRID_DELETE_BUTTON_ACTIVE_BG = "ui_goods_button_bg_up_1.png"

-- local SPRITE_GRID_DELETE_BUTTON_NORMAL = "ui_goods_button_dustbin_0.png"
-- local SPRITE_GRID_DELETE_BUTTON_ACTIVE = "ui_goods_button_dustbin_1.png"
local SPRITE_GRID_DELETE_BUTTON_NORMAL = "ui_goods_button_choice_0.png"
local SPRITE_GRID_DELETE_BUTTON_ACTIVE = "ui_goods_button_choice_1.png"


local SPRITE_GRID_DELETE_BUTTON_CONFIRM = "ui_goods_button_hook.png"
-- 黄金，钻石的图片
local SPRITE_GAMING_MOMEY   = "symbol_gaming_money.png"
local SPRITE_GAMING_DIAMOND = "symbol_gaming_diamond.png"
---------------------------------------

-- 动画数据 --
---------------------------------------

-- 背包整体布局 --
---------------------------------------
-- 设计尺寸
local LAYOUT_DESIGN_WIDTH = 1024
local LAYOUT_DESIGN_HEIGHT = 640
-- 模块功能tab选择控件
local LAYOUT_TAB_LIST_SPACE = 25
local LAYOUT_TAB_LIST_WIDTH = 127
local LAYOUT_TAB_LIST_HEIGHT = 72
local LAYOUT_TAB_LIST_LEFT = 122
local LAYOUT_TAB_LIST_UP = 0
-- 关闭按钮
local LAYOUT_CLOSE_BUTTON_LEFT = 30
local LAYOUT_CLOSE_BUTTON_UP = 0
-- 模块功能区域高度
local LAYOUT_FUNCTION_HEIGHT = 568
---------------------------------------

-- 背包－角色模块的布局 --
---------------------------------------
local ROLE_LAYOUT = {
    -- 角色模块左边区域宽度所占的百分比
    LEFT_LAYOUT_WIDTH_PERCENT = 0.5,
    -- 角色模块右边区域宽度所占的百分比
    RIGHT_LAYOUT_WIDTH_PERCENT = 0.5,
    -- 角色模块右边区域宽度所占的百分比
    RIGHT_LAYOUT_WIDTH_PERCENT = 0.5,
    -- 角色模块左边区域中的内容   
    LEFT_LAYOUT_CONTENT_WIDTH = 512,
    LEFT_LAYOUT_CONTENT_HEIGHT = 568,
    -- 角色模块右边区域中的内容
    RIGHT_LAYOUT_CONTENT_WIDTH = 456,
    RIGHT_LAYOUT_CONTENT_HEIGHT = 520,
    -- 角色展示区域
    ROLE_SHOW_AREA_WIDTH = 457,
    ROLE_SHOW_AREA_HEIGHT = 416,
    -- 物品列表区域－上层（黄金信息，钻石信息，删除格子按钮）
    GOODS_LIST_UP_HEIGHT = 60,
    -- 物品列表区域－中层（背包列表）
    GOODS_LIST_MIDDLE_HEIGHT = 400,
    -- 物品列表区域－下层（添加背包格子按钮，背包物品分类选择）
    GOODS_LIST_BOTTOM_HEIGHT = 60,
    -- 物品列表
    GOODS_LIST_SCROLL_VIEW_LEFT = 0,
    GOODS_LIST_SCROLL_VIEW_UP = 0,
    -- 物品列表的滑块
    GOODS_LIST_SLIDER_WIDTH = 10,
    GOODS_LIST_SLIDER_HEIGHT = 400,
    -- 黄金
    MONEY_BG_LEFT = 16,
    MONEY_ICON_LEFT = 2,
    MONEY_TEXT_LEFT = 40,
    -- 钻石
    DIAMOND_BG_LEFT = 196,
    DIAMOND_ICON_LEFT = 182,
    DIAMOND_TEXT_LEFT = 220,
    -- 黄金，钻石文本信息
    MONEY_DIAMOND_TEXT_WIDTH = 150,
    MONEY_DIAMOND_TEXT_HEIGHT = 20,
    -- 删除格子按钮
    DELETE_GRID_BUTTON_RIGHT = 20,
    -- 物品分类tab
    GOODS_LIST_TAB_BUTTON_SPACE = 3,
    GOODS_LIST_TAB_BUTTON_WIDTH = 56,
    GOODS_LIST_TAB_BUTTON_HEIGHT = 60,
    GOODS_LIST_TAB_WIDTH = 250,
    GOODS_LIST_TAB_HEIGHT = 60,
    GOODS_LIST_TAB_RIGHT = 38,
    -- 背包格子初始化信息
    GOODS_GRID_INIT_COLUMN = 5,
    GOODS_GRID_INIT_ROW = 10,
    GOODS_GRID_WIDTH = 74,
    GOODS_GRID_HEIGHT = 74,
    GOODS_GRID_HORIZONTAL_SPACE = 6,
    GOODS_GRID_VERTICAL_SPACE = 6,
    GOODS_GRID_PADDING_SPACE = 6
}
---------------------------------------

-- 组件z序 --
---------------------
-- 拖拽的格子
local BAG_DRAG_GRID_ZORDER = 4
-- 角色模块－左边布局区域
local ROLE_LEFT_LAYOUT_ZORDER = 2
-- 角色模块－右边布局区域
local ROLE_RIGHT_LAYOUT_ZORDER = 3
---------------------

local ANIMATION_DESTROY_ITEM = "animation2"
local ANIMATION_ACTIVE_BAGGRID_LST = "animation"

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
    -- 拥有物品宠物装备列表
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

    refresHandleUseData(self._data.haveItemArr, repeatData, dragRepeatData)
    refresHandleUseData(self._data.haveMaterialArr, repeatData, dragRepeatData)
    refresHandleUseData(self._data.haveGemStoneArr, repeatData, dragRepeatData)
    refresHandleUseData(self._data.haveRelicArr, repeatData, dragRepeatData)
    refresHandleUseData(self._data.haveTreasureArr, repeatData, dragRepeatData)
end

local function refreshDeleteView(self)
    self._bagGridList:refrehDeleteGrid(self._deleteItemTable, true)
end

local function refreshDeleteItemView(self)
    if (self._deleteState) then
        self._bagGridList:showChoiceStatus()
        self._bagGridList:refrehDeleteGrid(self._deleteItemTable, true)
    end
end

-- 装备详情的touch事件的处理
local function onEquipmentInfoAreaTouchHandler(self,obj,touchPosition)
     -- 更新装备对比区域数据

    if obj:getGoodsGrid() ~= nil and (not tolua.isnull(obj:getGoodsGrid()))  then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    self:updateBasicView()
    if(self._equipmentInfoArea and (not tolua.isnull(self._equipmentInfoArea))) then
        self._equipmentInfoArea:close()
    end
    self._equipmentInfoArea = nil
    if not tolua.isnull(self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
end

-- 道具详情的touch事件处理    
local function onPropInfoAreaTouchHandler(self,obj,touchPosition)


    if obj:getGoodsGrid() ~= nil and (not tolua.isnull(obj:getGoodsGrid())) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    if self._propInfoArea and (not tolua.isnull(self._propInfoArea)) then
        self._propInfoArea:close()
    end
    self._propInfoArea = nil

    if not tolua.isnull(self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil
    end
end

-- 材料详情的touch事件处理
local function onMaterialInfoAreaTouchHandler(self,obj,touchPosition)
    if obj:getGoodsGrid() ~= nil and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 
        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    if self._materialInfoArea and (not tolua.isnull(self._materialInfoArea)) then
        self._materialInfoArea:close()
    end
    self._materialInfoArea = nil

    if (self._selectedBagGrid) and (not tolua.isnull(self._selectedBagGrid)) then
        self._selectedBagGrid:hideSelect()
    end

    self._selectedBagGrid = nil
end

-- 宠物宝石详情的touch事件处理
local function onPetStoneInfoAreaTouchHandler(self,obj,touchPosition)
    if obj:getGoodsGrid() ~= nil and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 
        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    if self._petStoneInfoArea and (not tolua.isnull(self._petStoneInfoArea)) then
        self._petStoneInfoArea:close()
    end
    self._petStoneInfoArea = nil

    if (self._selectedBagGrid) and (not tolua.isnull(self._selectedBagGrid)) then
        self._selectedBagGrid:hideSelect()
    end

    self._selectedBagGrid = nil
end

-- 宝石详情的touch事件处理
local function onGemStoneInfoAreaTouchHandler(self,obj,touchPosition)
    if obj:getGoodsGrid() ~= nil and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 
        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    if self._gemStoneInfoArea and (not tolua.isnull(self._gemStoneInfoArea)) then
        self._gemStoneInfoArea:close()
    end
    self._gemStoneInfoArea = nil

    if (self._selectedBagGrid) and (not tolua.isnull(self._selectedBagGrid)) then
        self._selectedBagGrid:hideSelect()
    end

    self._selectedBagGrid = nil
end

-- 雕文详情的touch事件处理
local function onGlyphInfoAreaTouchHandler(self,obj,touchPosition)
    if obj:getGoodsGrid() ~= nil and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 
        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    if self._glyphInfoArea and (not tolua.isnull(self._glyphInfoArea)) then
        self._glyphInfoArea:close()
    end
    self._glyphInfoArea = nil

    if (self._selectedBagGrid) and (not tolua.isnull(self._selectedBagGrid)) then
        self._selectedBagGrid:hideSelect()
    end

    self._selectedBagGrid = nil
end

-- 遗物详情的touch事件处理
local function onRelicInfoAreaTouchHandler(self,obj,touchPosition)
    if obj:getGoodsGrid() ~= nil and not tolua.isnull(obj:getGoodsGrid()) then
        local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
        local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 
        if cc.rectContainsPoint(rect, touchPosition) then
            obj:setInterceptTouches(false)
        end
    end

    if self._relicInfoArea and (not tolua.isnull(self._relicInfoArea)) then
        self._relicInfoArea:close()
    end
    self._relicInfoArea = nil

    if (self._selectedBagGrid) and (not tolua.isnull(self._selectedBagGrid)) then
        self._selectedBagGrid:hideSelect()
    end

    self._selectedBagGrid = nil
end

-- 更新整个列表
local function updateGridList(self, data)
    if (data) then
        self:closeChoese()
        refreshBagData(self)

        if(self._isUnlockBagFlag) then
            self._bagGridList:setData(data, self._isUnlockBagFlag)
            self._isUnlockBagFlag = nil
            return
        end
        self._bagGridList:setData(data)
        self._bagGridList:updateView()
    
        -- if (self._tabIndex <= 0) then
        --     self._tabIndex = 1
        --     showGoodsByTabIndex(self, 1)
        -- else
        --     showGoodsByTabIndex(self, self._tabIndex)
        -- end

        -- 更新格子数据
        local availableCount = data.packetBoxBeUseNum
        local petNum = 0
        if(data.havePetEquipmentArr) then 
            petNum = #data.havePetEquipmentArr
        end
        local usedCount = #data.haveEquipmentArr + petNum + #data.haveItemArr + #data.haveMaterialArr + #data.haveGemStoneArr + #data.haveRelicArr + #data.haveTreasureArr

        if self._tabIndex == 6 then
            local master = RoleDataManager:getMaster()
            if master then 
                local stoneArr = GoodsDataManager:getGoodsArrForPK(master:getPK(),PublicDefine.PACKET_TYPE.PACKET_PET_GEMSTONE,PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
                usedCount = #stoneArr
            end
            availableCount = PublicDefine.CONST_DEFINITION.MAX_PET_GEMSTONE_PACKET_NUM

            data.packetBoxBeUseNum = availableCount
        elseif self._tabIndex == 7 then 
            local master = RoleDataManager:getMaster()
            if master then 
                local stoneArr = data.haveGlyphArr
                usedCount = #stoneArr
            end
            availableCount = MasterDataManager:getGlyphBoxCanBeUseNum()
            data.packetBoxBeUseNum = availableCount
        else
            availableCount = MasterDataManager:getAllBoxCanBeUseNum()

            data.packetBoxBeUseNum = availableCount
        end

        self._gridCountLabel:setText(tostring(usedCount), tostring(availableCount))
        self._gridCountLabel:updateView()

        if (data.heroData:getIsDead()) then
            self._bagGridList:disableDoubleClick()
        end
    end

    self:updateGridUseState()
end


-- 删除装备按钮点击处理器
local function onActiveDeleteButtonHandler(self)
    if self._deleteState == false then 
        -- 在查看装备时，点击删除按钮，选中的动画不消失
        self._bagGridList:showDestory()
        if not tolua.isnull(self._selectedBagGrid) then 
            self._selectedBagGrid:hideSelect()
            self._selectedBagGrid = nil
        end
        self._deleteState = true

        -- 更新锁定表现逻辑
        self:setUseLock(false)
        self:updateGridUseState()

        self._deleteItemTable = {}
        self._bagGridList:refrehDeleteGrid(self._deleteItemTable, false)
        self._deleteButtonBG:setSpriteName(SPRITE_GRID_DELETE_BUTTON_ACTIVE_BG)
        self._deleteButton:setSpriteName(SPRITE_GRID_DELETE_BUTTON_ACTIVE)
        self._deleteButton:updateView()
        
        -- 关闭拖动
        self._isDeleting = true

        -- 重置规则
        self._oldUseType = self._usedType
        self._oldUserLock = self._useLock
        self._checkItemUseState = false

        self._usedType = nil
        self._useLock = false

        -- 刷新显示
        -- refreshAllGridCanUseState(self)
        updateGridList(self, self._data)
        self._bagGridList:showChoiceStatus()
    else
        UI.TipsLayer:createDestoryGemStoneTips(self._deleteItemTable, function() 
            UI.TipsLayer:createLostEscapeScrollTips(self._deleteItemTable, false, function()
                self._bagGridList:hideChoiceStatus()
                self._bagGridList:hideDestory()

                self._deleteButtonBG:setSpriteName(SPRITE_GRID_DELETE_BUTTON_BG)
                self._deleteButton:setSpriteName(SPRITE_GRID_DELETE_BUTTON_NORMAL)
                self._deleteButton:updateView()
                self:updateView()
                self._deleteState = false

                self._isDeleting = false

                -- 点中后开始删除
                if #self._deleteItemTable > 0 then 
                    -- Avalon.MessageCenter:notice(AvalonMessage.MC_GOODS_BAG_LOST, self._deleteItemTable)
                    if (RoleBehaviorManager:caveShopSellItemCheck()) then 
                        GameManager:sellGoodsArrHandler(self._deleteItemTable, self._spriteID, handler(self, function()
                            for k, goodsData in pairs(self._deleteItemTable) do 
                                goodsData:setUseNum(goodsData:getNum())
                            end
                            self._deleteItemTable = {}
                            refreshDeleteView(self)
                        end), 
                        function() 
                            self._deleteItemTable = {}
                            self._bagGridList:refrehDeleteGrid(self._deleteItemTable, true)
                        end)
                        Avalon.AudioManager:playSound("1504")
                    end 
                    
                    -- if(RoleBehaviorManager:lostItemCheck()) then 
                    --     GameManager:bagLostGoodsHandler(self._deleteItemTable, handler(self, function()
                    --         for k, goodsData in pairs(self._deleteItemTable) do 
                    --             goodsData:setUseNum(goodsData:getNum())
                    --             refreshDeleteView(self)
                    --         end
                    --     end))
                    -- else
                    --     refreshDeleteView(self)
                    -- end                    
                end
                self._selectedBagGrid = nil 
                -- 打开拖动

                -- 恢复规则
                self._usedType = self._oldUseType
                self._useLock = self._oldUserLock
                self._checkItemUseState = true

                self._oldUseType = nil
                self._oldUserLock = false

                -- 更新锁定表现逻辑
                self:setUseLock(true)
                self:updateGridUseState()

                -- 刷新显示
                -- refreshAllGridCanUseState(self)
                -- updateGridList(self, self._data)
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
                self._bagGridList:refrehDeleteGrid(self._deleteItemTable, true)
            end
            refreshDeleteItemView(self)
            refreshDeleteView(self)
        end)
    end
end

-- 判断背包是否已经满
local function isBagFull(self)
    if (self._data) then
        local petNum = 0
        if(self._data.havePetEquipmentArr) then 
            petNum = #self._data.havePetEquipmentArr
        end

        local usedCount = #self._data.haveEquipmentArr +
                          petNum +
                          #self._data.haveItemArr +
                          #self._data.haveMaterialArr +
                          #self._data.haveGemStoneArr + 
                          #self._data.haveRelicArr + 
                          #self._data.haveTreasureArr
        
        return usedCount >= self._data.packetBoxBeUseNum
    else
        assert(false)
    end
end

-- 显示所有物品
local function showAllGoods(self)
    self._bagGridList:showAllGoods()
end

-- 显示所有装备
local function showAllEquipments(self)
    self._bagGridList:showEquipments()
end

-- 显示所有道具
local function showAllItems(self)
    self._bagGridList:showItems()
end

-- 显示所有材料
local function showAllMaterial(self)
    self._bagGridList:showMaterials()
end

-- 显示所有宝石
local function showAllGemStone(self)
    self._bagGridList:showGemStone()
end

-- 显示所有宠物宝石
local function showAllPetStone(self)
    self._bagGridList:showPetStone()
end

-- 显示所有准备雕文
local function showAllGlyph(self)
    self._bagGridList:showGlyph()
end

-- 背包格子拖拽开始的处理器
local function onBagGridDragBeganHandler(self, bagGrid, touchPosition, touchBeganLocalPosition)
    if (self._isDeleting) then return end
    if (not bagGrid) then return end

    local bagGridData = bagGrid:getData()
    if (bagGridData and bagGridData:getIsNew()) then
        GameManager:bagClickGoodsHandler(bagGridData)
    end

    -- 处理大秘境对于穿戴装备屏蔽
    if(SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave()) then
        return
    end
    
    -- 处于战斗中禁止更换装备
    if self:isBattle() then 
        return
    end
    -- 处于魂器变身中无法更换装备
    if RoleDataManager:getMaster():isHorcruxTransform() then 
        self.equipNotUseReson = UI.TEXT_1213507
        return
    end

    -- 拖拽关闭装备选中
    self:closeChoese()

    if self._deleteState == true then 
        return
    end
    if (bagGrid) then
        local goodsData = bagGrid:getData()
        local goodsType = goodsData:getGoodsType()
        if (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
            local area = not self._fishGearView and self._roleShowArea or self._fishGearView
            area:activeEquipment(goodsData, touchPosition)
        end

        self._isDraging = true
    else
        assert(false)
    end
end

-- 背包格子拖拽的处理器
local function onBagGridDragMovedHandler(self, bagGrid, touchPosition)
    if (bagGrid) then
        local goodsData = bagGrid:getData()
        local goodsType = goodsData:getGoodsType()
        -- 只有装备才可以激活角色展示区
        if (goodsType == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
            local area = not self._fishGearView and self._roleShowArea or self._fishGearView
            -- 拖到角色展示区
            if (area:checkTouchPosition(touchPosition)) then
                area:activeArea()
            else
                area:deactiveArea()
            end
            
            if(self._bagGridList) then 
                self._bagGridList:changeInSideStatus(self._roleShowArea:checkTouchPosition(touchPosition))
            end
        end
    end
end

-- 背包格子拖拽结束的处理器



local function onBagGridDragEndedandler(self, bagGrid, touchPosition)
    if (DEBUG) then
        if (bagGrid) then
            print(string.format("RolePanel onBagGridDragEndedandler: grid index:%d.", bagGrid:getIndex()))
        end
    end

    -- 试炼之地更换武器判断
    if SceneManager:getInstance():isInTrialLand() then
        local goodsData = bagGrid:getData()
        if(goodsData:isWeapon()) then
            local allData = mvc.activityModeCaveModel:getModeCaveData(PublicDefine.ActivityModeCaveType.TrialLand)
            local caveData --= allData[config.ID]
            for _, v in pairs(allData) do
                caveData = v
            end
            local WEAPON_TYPE_NAME = {
                [PublicDefine.WEAPON_TYPE.SWORD_SHIELD] = UI.TEXT_1324001,   --剑盾
                [PublicDefine.WEAPON_TYPE.GREAT_SWORD] = UI.TEXT_1324000,    --大剑
                [PublicDefine.WEAPON_TYPE.MAGIC_STAFF] = UI.TEXT_1324002     --法杖
            }
            local equipmentType = goodsData:getWeaponType()
            if caveData.trialLand.weaponType and caveData.trialLand.weaponType ~= equipmentType then
                local str = string.format(UI.TEXT_223418, WEAPON_TYPE_NAME[caveData.trialLand.weaponType])
                UI.ScrollBar:createByText(str)
                return
            end
        end
    end
    ----------------

    -- 被多选时不参与拖拽事件
    if bagGrid._showChoiceStatus then
        return
    end
    -- local pos = self.leftLayer:convertToWorldSpace(cc.p(0, 0))
    -- self.mRect = cc.rect(pos.x, pos.y, 328, 602)
    if bagGrid then
        local goodsData = bagGrid:getData()
        local area = not self._fishGearView and self._roleShowArea or self._fishGearView

        -- 如果没有穿戴成功，放回背包
        if (not area:addEquipment(goodsData)) then
            -- self._bagGridList:putBagGrid(goodsData)
            if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
                if area:checkTouchPosition(touchPosition) then
                    if self.equipNotUseReson then
                        UI.ScrollBar:createByText(self.equipNotUseReson)
                        self.equipNotUseReson = nil
                    elseif goodsData:getEquipmentType() == PublicDefine.EQUIPMENT_TYPE.Fish then
                        if not self._fishGearView then
                            UI.ScrollBar:createByText(UI.TEXT_221605)
                        else
                            UI.ScrollBar:createByText(UI.TEXT_221607)
                        end
                        
                    elseif self._fishGearView and goodsData:getEquipmentType() ~= PublicDefine.EQUIPMENT_TYPE.Fish then
                        UI.ScrollBar:createByText(UI.TEXT_221606)
                    else
                        UI.ScrollBar:createByText(UI.TEXT_1170416)
                    end
                end
            end
        else 
            goodsData:setUseNum(1)
            bagGrid:updateView()
        end
        area:deactiveEquipment()
        area:deactiveArea()

        self._isDraging = false

        Avalon.AudioManager:playSound("1505")
    end
    return false
end

-- 点击格子
local function onBagGridClickHandler(self, bagGrid, touchPosition)
    -- 关闭装备详情面板
    if (not tolua.isnull(self._equipmentInfoArea)) then
        self._equipmentInfoArea:close()
        self._equipmentInfoArea = nil
    end
    if (not tolua.isnull(self._propInfoArea)) then
        self._propInfoArea:close()
        self._propInfoArea = nil
    end
    if (not tolua.isnull(self._materialInfoArea)) then
        self._materialInfoArea:close()
        self._materialInfoArea = nil
    end
    if (not tolua.isnull(self._gemStoneInfoArea)) then
        self._gemStoneInfoArea:close()
        self._gemStoneInfoArea = nil
    end
    if (not tolua.isnull(self._relicInfoArea)) then
        self._relicInfoArea:close()
        self._relicInfoArea = nil
    end
    if (not tolua.isnull(self._petStoneInfoArea)) then
        self._petStoneInfoArea:close()
        self._petStoneInfoArea = nil
    end
    if (not tolua.isnull(self._glyphInfoArea)) then
        self._glyphInfoArea:close()
        self._glyphInfoArea = nil
    end
    

    if self._isDraging then return end

    if (DEBUG) then
        print(string.format("RolePanel onBagGridClickHandler: grid index:%d.", bagGrid:getIndex()))
    end

    local goodsData = nil
    if (bagGrid) then

        goodsData = bagGrid:getData()

        if  self._deleteState == true then 
            if goodsData and bagGrid:getCanUseState() and goodsData:getIsLock() == false then 

                if bagGrid:deleteItem() then 
                    self._deleteButton:setSpriteName(SPRITE_GRID_DELETE_BUTTON_CONFIRM)
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
                    self._deleteButton:setSpriteName(SPRITE_GRID_DELETE_BUTTON_ACTIVE)
                end
                self._bagGridList:refrehDeleteGrid(self._deleteItemTable, false)
            end

            -- 暂时不打开装备页面
            return 
        end
 
        if not tolua.isnull(self._selectedBagGrid) and self._selectedBagGrid == bagGrid then 
            self:closeChoese()
        else
            -- 把上次点击的关闭
            if not tolua.isnull(self._selectedBagGrid) then 
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

                -- 类型
                if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
                    local equipmentType = goodsData:getEquipmentType()
                    local unEquipArr = self._roleShowArea:getEquipmentData(equipmentType) 
                    local equipmentDataList = self._roleShowArea:tryEquipment(goodsData)
                    local heroData = RoleDataManager:getMaster()

                    local blackTable = heroData:tryEquipment(goodsData,unEquipArr,equipmentDataList)
                    -- self._basicInfoArea:updateInfoArea(blackTable)

                    local index =  bagGrid:getIndex()
                    -- 装备详情
                    local equipmentInfoArea = UI.EquipmentInfoArea:create()
                    equipmentInfoArea:init(UI.EquipImageBgType.BIG_TYPE)
                    equipmentInfoArea:setGoodsGrid(bagGrid)

                    self._contentLayout:addChild(equipmentInfoArea,9999)
                    self._equipmentInfoArea = equipmentInfoArea
                    self._equipmentInfoArea:setVisible(true)
                    self._equipmentInfoArea:updateView(goodsData)
                    self._equipmentInfoArea:updateInfo(blackTable, true)
                    -- self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, onEquipmentInfoAreaTouchHandler)
                    self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onEquipmentInfoAreaTouchHandler)

                    -- equipmentInfoArea:leftUp(233 - 15 - equipmentInfoArea:getHoleWidth(),15)
                    equipmentInfoArea:centerLeft(233 - 15 - equipmentInfoArea:getHoleWidth() + 20)
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then
                    local heroData = RoleDataManager:getMaster()

                    local index =  bagGrid:getIndex()
                    local equipmentInfoArea = UI.EquipmentPetInfoArea:create()
                    equipmentInfoArea:init(UI.EquipImageBgType.BIG_TYPE)
                    equipmentInfoArea:setGoodsGrid(bagGrid)

                    self._contentLayout:addChild(equipmentInfoArea,9999)
                    self._equipmentInfoArea = equipmentInfoArea
                    self._equipmentInfoArea:setVisible(true)
                    self._equipmentInfoArea:updateView(goodsData)
                    self._equipmentInfoArea:hideCompInfo()
                    -- self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, onEquipmentInfoAreaTouchHandler)
                    self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onEquipmentInfoAreaTouchHandler)
                    equipmentInfoArea:centerLeft(233 - 15 + 20)
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then  
                    local itemType = goodsData:getItemType()
                    if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
                        local index = bagGrid:getIndex()
                        local propInfo = UI.SelectGoodsBagInfoArea:create(true)
                        propInfo:init(UI.PROP_MATER.PROPINFO)
                        self._contentLayout:addChild(propInfo,9999)
                        self._propInfoArea = propInfo
                    elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then 
                        local index = bagGrid:getIndex()
                        local propInfo = UI.LevelBagInfoArea:create(true)
                        propInfo:init(UI.PROP_MATER.PROPINFO)
                        self._contentLayout:addChild(propInfo,9999)
                        self._propInfoArea = propInfo
                    elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then 
                        reload_script_file("app.ui.baglayer.InfoArea.RandomBagInfoArea")
                        local propInfo = UI.RandomBagInfoArea:create(true)
                        propInfo:init(UI.PROP_MATER.PROPINFO)
                        self._contentLayout:addChild(propInfo,9999)
                        self._propInfoArea = propInfo
                    elseif itemType == PublicDefine.ITEM_TYPE.PetEgg then 
                        local index = bagGrid:getIndex()
                        -- 宠物蛋详情界面
                        local propInfo = UI.PetEggInfoArea:create()
                        propInfo:init(UI.PROP_MATER.PROPINFO)

                        self._contentLayout:addChild(propInfo,9999)
                        propInfo:setGoodsGrid(bagGrid)
                        propInfo:setGoodsData(goodsData)
                        self._propInfoArea = propInfo
                    else
                        local index = bagGrid:getIndex()
                        -- 道具详情界面
                        local propInfo = UI.PropInfoArea:create(false)
                        propInfo:init(UI.PROP_MATER.PROPINFO)

                        self._contentLayout:addChild(propInfo,9999)
                        propInfo:setGoodsGrid(bagGrid)
                        self._propInfoArea = propInfo
                    end
                    
                    self._propInfoArea:updateView(goodsData)
                    self._propInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onPropInfoAreaTouchHandler)
                    self._propInfoArea:centerLeft(567- self._propInfoArea:getContentSize().width)
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL) then 
                    local index = bagGrid:getIndex()
                    local materialInfo = nil
                    if(goodsData:getMaterialType() == PublicDefine.MATERIAL_TYPE.MaterialPetSkill) then
                        -- 技能书
                        materialInfo = UI.PetSkillBookInfoArea:create()
                        materialInfo:init(true)
                        self._contentLayout:addChild(materialInfo,9999)
                        materialInfo:setGoodsGrid(bagGrid)
                        self._materialInfoArea = materialInfo
                        self._materialInfoArea:updateView(goodsData)
                        self._materialInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onMaterialInfoAreaTouchHandler)
                    
                    elseif(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then 
                        -- 材料详情界面
                        materialInfo = UI.PropInfoArea:create(true)
                        materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                        self._contentLayout:addChild(materialInfo,9999)
                        materialInfo:setGoodsGrid(bagGrid)
                        self._materialInfoArea = materialInfo
                        self._materialInfoArea:updateView(goodsData)
                        self._materialInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onMaterialInfoAreaTouchHandler)

                        if goodsData:getId() == PublicDefine.ITEM_ID.ITEM_ID_EXPEDITION_QUICK then
                            local function goToExpedition()
                                Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_ROLE_PANEL)

                                -- local battleCmd = Command.BattleCommand:create()
                                -- battleCmd:initForOpenTriggerNpc(983048, true)
                                -- local MachineManager = require("app.game.MachineManager")
                                -- MachineManager:getInstance():executeCommand(battleCmd)
                                local MachineManager = require("app.game.MachineManager")
                                if(MachineManager:getInstance():getMachine()) then
                                    MachineManager:getInstance():getMachine():openUIByFunctionType(PublicDefine.FUNCTION_TYPE.FUNCTION_TYPE_EXPEDITION)
                                end
                            end

                            materialInfo:setButtonGoShow(goToExpedition)
                        end
                    else 
                        materialInfo = UI.MaterialEquipScrollInfoArea:create()
                        materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                        self._contentLayout:addChild(materialInfo,9999)
                        materialInfo:setGoodsGrid(bagGrid)
                        self._materialInfoArea = materialInfo
                        self._materialInfoArea:updateView(goodsData)
                        self._materialInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onMaterialInfoAreaTouchHandler)
                    end

                    materialInfo:centerLeft(233 - 15 + 5 +20)
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
                    --宝藏 材料
                    local materialInfo = UI.PropInfoArea:create(true)
                    materialInfo:init(UI.PROP_MATER.MATERIALINFO)
                    self._contentLayout:addChild(materialInfo,9999)
                    materialInfo:setGoodsGrid(bagGrid)
                    self._materialInfoArea = materialInfo
                    self._materialInfoArea:updateView(goodsData)
                    self._materialInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onMaterialInfoAreaTouchHandler)
                    materialInfo:centerLeft(233 - 15 + 5 +20)
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
                    --宠物宝石
                    local petStoneInfo = UI.PetStoneInfoArea:create(true)
                    petStoneInfo:init(goodsData)
                    self._contentLayout:addChild(petStoneInfo,9999)
                    petStoneInfo:setGoodsGrid(bagGrid)
                    self._petStoneInfoArea = petStoneInfo
                    self._petStoneInfoArea:updateView(goodsData)
                    self._petStoneInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onPetStoneInfoAreaTouchHandler)
                    petStoneInfo:centerLeft(233 - 15 + 5 +20)
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
                    -- 宝石详情界面
                    if (not self._gemStoneInfoArea) then
                        local gemStoneInfoArea = UI.GemStoneInfoArea:create()
                        gemStoneInfoArea:init(goodsData)
                        self._contentLayout:addChild(gemStoneInfoArea,9999)
                        gemStoneInfoArea:setGoodsGrid(bagGrid)
                        self._gemStoneInfoArea = gemStoneInfoArea
                        self._gemStoneInfoArea:updateView(goodsData)
                        self._gemStoneInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onGemStoneInfoAreaTouchHandler)
                        gemStoneInfoArea:centerLeft(233 - 15 + 5 + 20)
                    end 
                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then 
                    -- 雕文详情界面
                    if (not self._glyphInfoArea) then
                        local glyphInfoArea = UI.GlyphInfoArea:create()
                        glyphInfoArea:init(goodsData)
                        self._contentLayout:addChild(glyphInfoArea,9999)
                        glyphInfoArea:setGoodsGrid(bagGrid)
                        self._glyphInfoArea = glyphInfoArea
                        self._glyphInfoArea:updateView(goodsData)
                        self._glyphInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onGlyphInfoAreaTouchHandler)
                        glyphInfoArea:centerLeft(233 - 15 + 5 + 20)
                    end 

                elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then 
                    -- 遗物详情界面
                    if (not self._relicInfoArea) then
                        local relicInfoArea = UI.RelicInfoArea:create()
                        relicInfoArea:init(goodsData)
                        self._contentLayout:addChild(relicInfoArea,9999)
                        relicInfoArea:setGoodsGrid(bagGrid)
                        self._relicInfoArea = relicInfoArea
                        self._relicInfoArea:updateView(goodsData)
                        self._relicInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onRelicInfoAreaTouchHandler)
                        relicInfoArea:centerLeft(233 - 15 + 5 + 20)
                    end 
                
                end 

                self._selectedBagGrid = bagGrid
            end
        end
    end
end

-- 双击背包格子
local function onBagGridDoubleClickHandler(self, bagGrid, touchPosition)
    -- 如果在删除状态，不能使用道具
    if (self._deleteState) then return end

    local goodsData = bagGrid:getData()
    local canUse = bagGrid:canUse()

    if (goodsData) then
        if (canUse and goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
            local itemType = goodsData:getItemType()
            if (itemType == PublicDefine.ITEM_TYPE.RestorePotion) then
                local heroData = RoleDataManager:getMaster()
                if(goodsData:getRemarksField() == 1) then 
                    if(heroData and heroData:getCurHp() >= heroData.hp) then 
                        UI.ScrollBar:createByText(UI.TEXT_1170919)
                        return
                    end 
                elseif (goodsData:getRemarksField() == 2) then 
                    if (heroData and heroData:getCurMp() >= heroData.mp) then 
                        UI.ScrollBar:createByText(UI.TEXT_1170919)
                        return
                    end 
                end
                self._roleShowArea:showHappyAnimation() -- 恢复药水
            -- X选Y礼包
            elseif (itemType == PublicDefine.ITEM_TYPE.ChooseBag) then
                -- 不用关闭页面
                if self._propInfoArea and (not tolua.isnull(self._propInfoArea)) then
                    self._propInfoArea:close()
                end
                self._propInfoArea = nil
                local propInfo = UI.SelectGoodsBagInfoArea:create(true)
                propInfo:init(UI.PROP_MATER.PROPINFO)
                propInfo:autoOpenSelect()
                self._contentLayout:addChild(propInfo,9999)
                self._propInfoArea = propInfo
                
                self._propInfoArea:updateView(goodsData)
                self._propInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onPropInfoAreaTouchHandler)
                self._propInfoArea:centerLeft(567- self._propInfoArea:getContentSize().width)
                self._selectedBagGrid = bagGrid
                return 
            -- 真随机礼包
            elseif (itemType == PublicDefine.ITEM_TYPE.RandomBag) then
                -- 不用关闭页面
                if self._propInfoArea and (not tolua.isnull(self._propInfoArea)) then
                    self._propInfoArea:close()
                end
                self._propInfoArea = nil
                reload_script_file("app.ui.baglayer.InfoArea.RandomBagInfoArea")
                local propInfo = UI.RandomBagInfoArea:create(true)
                propInfo:init(UI.PROP_MATER.PROPINFO)
                propInfo:autoOpenSelect()
                self._contentLayout:addChild(propInfo,9999)
                self._propInfoArea = propInfo
                
                self._propInfoArea:updateView(goodsData)
                self._propInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onPropInfoAreaTouchHandler)
                self._propInfoArea:centerLeft(567- self._propInfoArea:getContentSize().width)
                self._selectedBagGrid = bagGrid
                return 
            -- X选Y礼包
            elseif (itemType == PublicDefine.ITEM_TYPE.LevelBag) then
                -- 不用关闭页面
                if self._propInfoArea and (not tolua.isnull(self._propInfoArea)) then
                    self._propInfoArea:close()
                end
                self._propInfoArea = nil
                local propInfo = UI.LevelBagInfoArea:create(true)
                propInfo:init(UI.PROP_MATER.PROPINFO)
                self._contentLayout:addChild(propInfo,9999)
                self._propInfoArea = propInfo
                
                self._propInfoArea:updateView(goodsData)
                self._propInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onPropInfoAreaTouchHandler)
                self._propInfoArea:centerLeft(567 - self._propInfoArea:getContentSize().width)
                self._selectedBagGrid = bagGrid
                return 
            -- 解锁背包
            elseif (itemType == PublicDefine.ITEM_TYPE.ItemUnlockBag) then
                if self._propInfoArea and (not tolua.isnull(self._propInfoArea)) then
                    self._propInfoArea:close()
                end
                self._propInfoArea = nil
                if goodsData and MasterDataManager:getUnlockBagTimesItem() < tonumber(ConfigManager:getGeneralForKey("itemUnlockPacketBoxSpaceTimes")) then 
                    local buyGridsTips = UI.Tips:createTips(string.format(UI.TEXT_1213081, goodsData:getName(), Config.General:getValueForKey("itemUnlockPacketBoxSpace")),
                        UI.TipsType.CONFIRM_AND_CANCEL, UI.TipsUiType.NORMAL)
                    buyGridsTips:addEventListener(UIEvent.DIALOG_CONFIRM, self, function()
                        UI.WaitingLayer:showWaiting(true, nil, GAME_NET_DELAY_UI)
                        Net.NetGoodsSystem:requestUnlockBagSpace(PublicDefine.PACKET_TYPE.PACKET_BAG, goodsData:getGoodsID())
                    end)
                else
                    UI.ScrollBar:createByText(UI.TEXT_1213027)
                end
                return
            elseif (itemType == PublicDefine.ITEM_TYPE.PetEgg) then
                -- 宠物蛋
                -- 仅能在洞外使用
                if not (SceneManager:getInstance():isNotInFightScene()) then
                    UI.ScrollBar:createByText(UI.TEXT_1213665)
                    return
                end

                -- 判断宠物背包是否已满
                local petCount = #MasterDataManager:getBagPets()
                if petCount >= PET_MAC_BAG then
                    UI.ScrollBar:createByText(UI.TEXT_1213713)
                    return
                end

                UI.ConfirmDialog.showConfirmDialogCancelWhiteOkRed(
                    UI.TEXT_1213714,
                    function()
                        -- 为了绕过一些原有道具的无用判断，直接开
                        local master = GameDataManager:getInstance():getMaster()
                        AudioUtil:playUseItemSound(goodsData:getGoodsID())
                        Net.NetGoodsSystem:useItemRequest(
                            goodsData:getGoodsID(),
                            goodsData:getIsGolden(),
                            master:getSpriteID()
                        )

                        -- 这里先设置一下蛋的外形type，因为在获得蛋的时候，已经脱离使用物品这个环境了
                        local goodsAttr = ConfigManager:getPropConfigByID(goodsData:getGoodsID())
                        local typeIdx = string.find(goodsAttr.icon, ".png")-1
                        local eggType = string.sub(goodsAttr.icon, typeIdx, typeIdx)
                        mvc.petModel:setNewEggType(tonumber(eggType))

                        -- 销毁宠物蛋tips
                        if self._propInfoArea and (not tolua.isnull(self._propInfoArea)) then
                            self._propInfoArea:close()
                        end

                        return
                    end
                )
            -- 饼干类不需要关闭背包
            elseif (itemType == PublicDefine.ITEM_TYPE.PetHPPotion or itemType == PublicDefine.ITEM_TYPE.AddExp) then
                local master = RoleDataManager:getMaster()
                if(#MasterDataManager:getBagPets() == 0 or (master and master:getPetHpStorage() - master:getPetCurHpStorage() == 0)) then 
                    return
                end
            elseif (itemType == PublicDefine.ITEM_TYPE.BackTown or itemType == PublicDefine.ITEM_TYPE.UIShape or 
                    itemType == PublicDefine.ITEM_TYPE.StarCard or itemType == PublicDefine.ITEM_TYPE.TransCard) then
                GameManager:useItem(goodsData, isQuickBar)
                return
            else
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_REMOVE_BAG_PANEL)
            end

            UI.UIManager:useGoods(goodsData)
        elseif CONFIG_DOUBLIE_CLICK and (goodsData:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
            local area = not self._fishGearView and self._roleShowArea or self._fishGearView
            area:activeArea()
            area:activeEquipment(bagGrid:getData(),  cc.p(0, 0))
            onBagGridDragEndedandler(self, bagGrid, cc.p(0, 0))
        end
    else
        if (DEBUG) then
            print(string.format("RolePanel onBagGridDoubleClickHandler: no goods data found for index %d.", bagGrid:getIndex()))
        end
    end
end

-- 角色展示区域拖拽装备格子开始的处理器
local function onEquipmentGridDragBeganHandler(self, equipmentGrid)
    if (self._isDeleting) then 
        return false
    end
 
    -- 处理大秘境对于穿戴装备屏蔽   add by zp 这里修改为放的时候提示
    -- if(SceneManager:getInstance():isInDungeon()) then
    --     return
    -- end

    -- 处于战斗中禁止更换装备
    if self:isBattle() then 
        return false
    end

    if (equipmentGrid) then
        if not tolua.isnull(self._selectedBagGrid) then 
            self._selectedBagGrid:hideSelect()
            self._selectedBagGrid = nil
        end

        local equipmentData = equipmentGrid:getData()
        if (equipmentData) then
            if (DEBUG) then
                print(string.format("RolePanel onEquipmentGridDragBeganHandler: equipment grid type %d.", equipmentData:getEquipmentType()))
            end

            self._roleShowArea:hideEquipment(equipmentData)
        else
            assert(false)
        end
    else
        assert(false)
    end
    return true
end

-- 角色展示区域拖拽装备格子结束的处理器
local function onEquipmentGridDragEndedHandler(self, equipmentGrid, inSide, touchPosition)
    local equipmentData = equipmentGrid:getData()

    -- 试炼之地卸下武器判断
    if SceneManager:getInstance():isInTrialLand() then
        local equipmentType = equipmentData:getEquipmentType()
        if  PublicDefine.EQUIPMENT_TYPE.Weapon == equipmentType then
            UI.ScrollBar:createByText(UI.TEXT_223419)
            return
        end
    end
    ----------------

    if (not inSide) then
        local area = not self._fishGearView and self._roleShowArea or self._fishGearView
        if(SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave()) then
            -- 提示大秘境无法穿戴装备
            UI.ScrollBar:createByText(UI.TEXT_1170933)
            self._roleShowArea:showEquipment(equipmentData)
        elseif RoleDataManager:getMaster():isHorcruxTransform() then
            UI.ScrollBar:createByText(UI.TEXT_1213507)
            self._roleShowArea:showEquipment(equipmentData)
        else
            if (not isBagFull(self)) then
                area:removeEquipment(equipmentData)
                area:updateView()

                self._roleShowArea:showEquipment(equipmentData)
            else
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110793))
                self._roleShowArea:showEquipment(equipmentData)
            end
        end 
    else
        self._roleShowArea:showEquipment(equipmentData)
    end
    self._bagGridList:hideMove()
end

-- 角色展示区域装备格子被点击的处理器
local function onEquipmentGridClickHandler(self, equipmentGrid, equipmentPosition)
    -- 关闭装备详情面板
    if (self._equipmentInfoArea) then
        self._equipmentInfoArea:close()
        self._equipmentInfoArea = nil
    end

    if (equipmentGrid) then
        -- 点击同一装备两次
        if self._selectedRoleGrid == equipmentGrid then 
            self:closeChoese()
            return 
        end
        -- 点击角色身上的装备，关闭背包里装备的动画
        if not tolua.isnull(self._selectedBagGrid) then 
            self._selectedBagGrid:hideSelect()
            self._selectedBagGrid = nil
        end
        local goodsData = equipmentGrid:getData()

        -- 装备详情
        local equipmentInfoArea =  UI.EquipmentInfoArea:create()
        equipmentInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
        equipmentInfoArea:hideCompInfo()
        if goodsData:getEquipmentType() ~= PublicDefine.EQUIPMENT_TYPE.Fish then
            equipmentInfoArea:showStrength()
        end
        
        if(SceneManager:getInstance():isInHuLu()) then
            equipmentInfoArea:closeLockFlag()
            equipmentInfoArea:setHideLink(true)
        end
        self._contentLayout:addChild(equipmentInfoArea,9999)
        self._equipmentInfoArea = equipmentInfoArea
        local equipmentPosition = goodsData:getWearPosition()

        -- 左边的装备（头盔，武器，手套，肩甲）
        if  equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Helmet or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Gloves or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Weapon or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Ring or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Fish then 
            equipmentInfoArea:leftUp(115 + 20,35)
        -- 右边的装备（项链，戒指，胸甲，鞋子）
        elseif  equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Chest or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Shoulders or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Boots or 
            equipmentPosition == PublicDefine.EQUIPMENT_TYPE.Amulet then
            equipmentInfoArea:leftUp(115 + 20,35)
        end

        -- equipmentInfoArea:leftUp(523 + 20,35)
        equipmentInfoArea:centerLeft(523 + 20)

        self._equipmentInfoArea:setGoodsGrid(equipmentGrid)
        self._equipmentInfoArea:updateView(goodsData)
        -- self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, onEquipmentInfoAreaTouchHandler)
        self._equipmentInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, onEquipmentInfoAreaTouchHandler)

        self._selectedRoleGrid = equipmentGrid
    else
        -- assert(false)
        self:closeChoese()
    end
end


-- 背包滚动视图滚动开始的处理器
local function onBagScrollViewScrollBeganHandler(self, scrollView)
    -- self._isScrolling = true
end

-- 背包滚动视图滚动的处理器
local function onBagScrollViewScrollingHandler(self, scrollView, percent)
    self._isScrolling = true
    -- 将选择的装备清空
    -- self:closeChoese()
end

-- 背包滚动视图滚动结束的处理器
local function onBagScrollViewScrollEndedHandler(self, scrollView)
    self._isScrolling = false
end

-- 显示物品
local function showGoodsByTabIndex(self, tabIndex)
    if (self._data) then
        -- 过滤卖出或销毁的数据
        refreshBagData(self)
        self:refreshPacketType(tabIndex)

        if (tabIndex == 1) then
            showAllGoods(self)
        elseif (tabIndex == 2) then
            showAllEquipments(self)
        elseif (tabIndex == 3) then
            showAllItems(self)
        elseif (tabIndex == 4) then
            showAllMaterial(self)
        elseif (tabIndex == 5) then
            showAllGemStone(self)
        elseif (tabIndex == 6) then
            showAllPetStone(self)
        elseif (tabIndex == 7) then
            showAllGlyph(self)
        else
            assert(false, string.format("RolePanel showGoodsByTabIndex: tab index %d is invalid.", tabIndex))
        end

        -- 如果处于删除状态
        if (self._deleteState) then
            self._bagGridList:showChoiceStatus()
            self._bagGridList:refrehDeleteGrid(self._deleteItemTable)
        end

        self:updateGridUseState()

        updateGridList(self, self._data)
    end
end

-- 选择不同类型的goods
local function onActiveGoodsTabHandler(self, tabIndex)
    if not tolua.isnull(self._selectedBagGrid) then
        self._selectedBagGrid:hideSelect()
    end

    self._tabIndex = tabIndex
    showGoodsByTabIndex(self, tabIndex)
end

local function showCommentLayer(wearEquipmentArr)
    local isShow = true
    if #wearEquipmentArr < 8 then
        isShow = false
    else
        for k, equipmentData in ipairs(wearEquipmentArr) do
            if equipmentData:getGoodsRare() < PublicDefine.GOODS_RARE.RARE_DARKGOLDEN_4 then
            -- if equipmentData:getGoodsRare() < PublicDefine.GOODS_RARE.RARE_WHITE_1 then
                isShow = false
                break
            end
        end
    end
    dump(isShow, "---------------isShow")
    if isShow then
        local SdkManager = require"app.game.SdkManager"
        SdkManager:checkCommentEvent(COMMENT_TYPE.PERFECT_ALL_EQUIPMENT)
    end
end

-- 穿戴的装备发生变化
local function onWearEquipmentChangedHandler(self, wearEquipmentData)
     -- dump(wearEquipmentData, "------------wearEquipmentData")
    if (wearEquipmentData) then
        local spriteID = wearEquipmentData.spriteID
        local masterID = GameDataManager:getInstance():getMaster():getSpriteID()
        if (spriteID == masterID) then
            local repeatData = MasterDataManager:getRepeatHandleData(RepeatHandleType.GOODS_DRAG_PACKET_DATA..":"..PublicDefine.PACKET_TYPE.PACKET_EQUIPMENT)
            for k,goodsData in pairs(wearEquipmentData.wearEquipmentArr) do
                goodsData:setUseNum(0)
                if(repeatData and repeatData[goodsData:getEntityID()]) then
                    goodsData:setUseNum(repeatData[goodsData:getEntityID()])
                end
            end
            local area = not self._fishGearView and self._roleShowArea or self._fishGearView
            area:updateWearEquipment(wearEquipmentData.wearEquipmentArr)
            showCommentLayer(wearEquipmentData.wearEquipmentArr)
        end
    else
        assert(false)
    end
end

-- 初始化装备视图
local function initEquipmentView(self)
    local realAreaWidth = winSize.width * ROLE_LAYOUT.LEFT_LAYOUT_WIDTH_PERCENT
    local designAreaWidth = LAYOUT_DESIGN_WIDTH * ROLE_LAYOUT.LEFT_LAYOUT_WIDTH_PERCENT
    local areaScale = computeLayoutScale(realAreaWidth, designAreaWidth)

    -- 角色模块－左边布局区域
    local roleLeftLayout = UI.Layout:create()
    roleLeftLayout:init()
    roleLeftLayout:setSize(designAreaWidth, LAYOUT_FUNCTION_HEIGHT)
    roleLeftLayout:leftBottom(20 - 7, -12)
    self._contentLayout:addChild(roleLeftLayout, ROLE_LEFT_LAYOUT_ZORDER)
    self._roleLeftLayout = roleLeftLayout

    -- 角色模块－左边布局区域内容
    local roleLeftLayoutContent = UI.Layout:create()
    roleLeftLayoutContent:init()
    roleLeftLayoutContent:centerRight(0)
    roleLeftLayoutContent:setSize(ROLE_LAYOUT.LEFT_LAYOUT_CONTENT_WIDTH, ROLE_LAYOUT.LEFT_LAYOUT_CONTENT_HEIGHT)
    roleLeftLayout:addChild(roleLeftLayoutContent)
    self._roleLeftLayout = roleLeftLayoutContent

    -- 角色展示区域
    local roleShowArea = UI.RoleShowArea:create()
    roleShowArea:init()
    roleShowArea:leftUp(38, 2)
    roleShowArea:setSize(ROLE_LAYOUT.ROLE_SHOW_AREA_WIDTH, ROLE_LAYOUT.ROLE_SHOW_AREA_HEIGHT)
    roleShowArea:addEventListener(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_BEGIN, self, onEquipmentGridDragBeganHandler)
    roleShowArea:addEventListener(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_ENDED, self, onEquipmentGridDragEndedHandler)
    roleShowArea:addEventListener(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK, self, onEquipmentGridClickHandler)
    -- roleShowArea:setClickAudioEnable(true)
    roleShowArea:setOnOpenTitleSelection(function()
        if (self._selectEquipmentButton) then 
            self._selectEquipmentButton:runAction(cc.Sequence:create(cc.FadeOut:create(0.2), cc.CallFunc:create(function() self._selectEquipmentButton:hide() end)))
            self._selectEquipmentButton:disable()
            self._selectEquipmentButton:setTouchEnable(false)
        end
    end)
    roleShowArea:setOnCloseTitleSelection(function()
        if (self._selectEquipmentButton) then 
            self._selectEquipmentButton:show()
            self._selectEquipmentButton:setOpacity(0)
            self._selectEquipmentButton:runAction(cc.FadeIn:create(0.2))
            self._selectEquipmentButton:enable()
            self._selectEquipmentButton:setTouchEnable(true)
        end
    end)
    roleShowArea:setDragOutSizeJudegNode(roleShowArea);
    roleLeftLayoutContent:addChild(roleShowArea)
    self._roleShowArea = roleShowArea
    
    -- 角色信息（血条，蓝条，经验）展示区域
    local basicInfoArea = UI.BasicInfoArea:create()
    basicInfoArea:setDetailedBtnParent(self._contentLayout)
    basicInfoArea:init()
    basicInfoArea:leftBottom(45 - 15, 22)
    roleLeftLayoutContent:addChild(basicInfoArea)
    self._basicInfoArea = basicInfoArea
    local heroData = self._data.heroData

    -- 套装按钮
    local selectEquipmentButton = UI.SelectEquipmentButton:create()
    selectEquipmentButton:init(heroData:getSelectShortcutEquipPage())
    selectEquipmentButton:centerUp(374)
    roleLeftLayoutContent:addChild(selectEquipmentButton)
    self._selectEquipmentButton = selectEquipmentButton

    -- 渔具按钮
    local fishingGearBtn = UI.Button:create() 
    fishingGearBtn:init("ui_fishing_btn_bait.png", "ui_fishing_btn_bait.png", "ui_fishing_btn_bait.png")
    fishingGearBtn:rightUp(28, 10)
    roleLeftLayoutContent:addChild(fishingGearBtn)
    fishingGearBtn:addEventListener(UI.Event.BUTTON_CLICK, self,function ()
        self:showFishGearView()
    end)
    fishingGearBtn:setVisible(Game.FunctionUnlockManager:getInstance():isUnlockByNpcLockType(PublicDefine.FUNCTION_TYPE.FUNCTION_MANOR_PORTAL)) 
end

-- 渔具界面
function RolePanel:showFishGearView()
    if not self._fishGearView then
        require("app.ui.baglayer.InfoArea.FishGearView")
        local fishGearView = UI.FishGearView:create()
        -- starInfoArea:init(mvc.starPrayModel:getStarPrayEqiupData())
        -- local bgWorldPos = self._starButton:convertToWorldSpace(cc.p(0,0))
        fishGearView:init()
        fishGearView:rightUp(500, 0)
        AvalonUtil.runTipsAppearShowAnimation(fishGearView)
        -- UI.UIManager:addToRootNode(fishGearView, UI_ZORDER.VIEW_ROLE_INFO)
        self._contentLayout:addChild(fishGearView, 99)
        -- fishGearView:setDragOutSizeJudegNode(fishGearView)
        fishGearView:addEventListener(UIEvent.FISH_GEAR_EQUIPMENT_GRID_DRAG_BEGIN, self, onEquipmentGridDragBeganHandler)
        fishGearView:addEventListener(UIEvent.FISH_GEAR_EQUIPMENT_GRID_DRAG_ENDED, self, onEquipmentGridDragEndedHandler)
        fishGearView:addEventListener(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK, self, onEquipmentGridClickHandler)
        self._fishGearView = fishGearView
    end
end

-- 初始化背包视图
local function initBagGridListView(self)
    local realAreaWidth = winSize.width * ROLE_LAYOUT.RIGHT_LAYOUT_WIDTH_PERCENT
    local designAreaWidth = LAYOUT_DESIGN_WIDTH * ROLE_LAYOUT.RIGHT_LAYOUT_WIDTH_PERCENT
    local areaScale = computeLayoutScale(realAreaWidth, designAreaWidth)

    -- 角色模块－右边布局区域
    local roleRightLayout = UI.Layout:create()
    roleRightLayout:init()
    roleRightLayout:setSize(designAreaWidth, LAYOUT_FUNCTION_HEIGHT)
    roleRightLayout:rightBottom(20 - 20, 2 + 24)
    self._contentLayout:addChild(roleRightLayout, ROLE_RIGHT_LAYOUT_ZORDER)

    -- 添加底板
    local bagBG = UI.Image:create()
    bagBG:init("ui_goods_banner_large_down.png")
    bagBG:centerBottom(-30)
    roleRightLayout:addChild(bagBG)

    -- 物品分类按钮
    local goodsTabList = UI.TabList:create()
    goodsTabList:init(
        ROLE_LAYOUT.GOODS_LIST_TAB_BUTTON_SPACE, 
        ROLE_LAYOUT.GOODS_LIST_TAB_BUTTON_WIDTH, 
        ROLE_LAYOUT.GOODS_LIST_TAB_BUTTON_HEIGHT
    )
    goodsTabList:setSize(
        ROLE_LAYOUT.GOODS_LIST_TAB_WIDTH, 
        ROLE_LAYOUT.GOODS_LIST_TAB_HEIGHT
    )
    -- goodsTabList:centerRight(ROLE_LAYOUT.GOODS_LIST_TAB_RIGHT)
    goodsTabList:leftBottom(65 - 20, 1)
    goodsTabList:setItemToFloatLeft()
    goodsTabList:addEventListener(UIEvent.TAB_ACTIVE, self, onActiveGoodsTabHandler)
    bagBG:addChild(goodsTabList)
    -- 所有装备
    local allGoodsTab = UI.GoodsTabItem:create()
    allGoodsTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_ALL_GOODS_BUTTON_NORMAL, SPRITE_GRID_ALL_GOODS_BUTTON_ACTIVE)
    goodsTabList:addTab(allGoodsTab)
    -- 装备
    local equipmentTab = UI.GoodsTabItem:create()
    equipmentTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_EQUIPMENT_BUTTON_NORMAL, SPRITE_GRID_EQUIPMENT_BUTTON_ACTIVE)
    goodsTabList:addTab(equipmentTab)
    -- 道具
    local itemTab = UI.GoodsTabItem:create()
    itemTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_ITEM_BUTTON_NORMAL, SPRITE_GRID_ITEM_BUTTON_ACTIVE)
    goodsTabList:addTab(itemTab)
    -- 材料
    local materialTab = UI.GoodsTabItem:create()
    materialTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_MATERIAL_BUTTON_NORMAL, SPRITE_GRID_MATERIAL_BUTTON_ACTIVE)
    goodsTabList:addTab(materialTab)
    -- 宝石
    local gemStoneTab = UI.GoodsTabItem:create()
    gemStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_GEM_STONE_BUTTON_NORMAL, SPRITE_GRID_GEM_STONE_BUTTON_ACTIVE)
    goodsTabList:addTab(gemStoneTab)
    -- 宠物宝石
    local gemPetStoneTab = UI.GoodsTabItem:create()
    gemPetStoneTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_GEM_PET_STONE_BUTTON_NORMAL, SPRITE_GRID_GEM_PET_STONE_BUTTON_ACTIVE)
    goodsTabList:addTab(gemPetStoneTab)
    -- 装备雕文
    local glyphTab = UI.GoodsTabItem:create()
    glyphTab:init(SPRITE_GRID_ALL_BOX_NORMAL, SPRITE_GRID_ALL_BOX_ACTIVE, SPRITE_GRID_GLYPH_BUTTON_NORMAL, SPRITE_GRID_GLYPH_BUTTON_ACTIVE)
    goodsTabList:addTab(glyphTab)



    -- 删除按钮
    local deleteButtonBG = UI.Image:create(nil, nil, UIType.TABITEM_BATCH_DELETE)
    deleteButtonBG:init(SPRITE_GRID_DELETE_BUTTON_BG)
    deleteButtonBG:rightUp(76, 1)
    deleteButtonBG:setSize(60,60)
    local deleteButton = UI.Image:create()
    deleteButton:init(SPRITE_GRID_DELETE_BUTTON_NORMAL)
    deleteButton:center()
    deleteButton:setTouchEnable(true)
    deleteButton:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function (self)
        deleteButtonBG:setScale(1.1)
        deleteButton:setScale(1.1)
    end)
    deleteButton:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function (self)
        deleteButtonBG:setScale(1.0)
        deleteButton:setScale(1.0)
    end)
    deleteButton:addEventListener(UIEvent.COMPONENT_CLICK, self, onActiveDeleteButtonHandler)
    deleteButton:setClickAudioEnable(true)
    deleteButtonBG:addChild(deleteButton)
    bagBG:addChild(deleteButtonBG)
    self._deleteButtonBG = deleteButtonBG
    self._deleteButton = deleteButton

    local typeRight = 76
    if(SceneManager:getInstance():isInFightScene()) then 
        -- 一键卖垃圾
        local sellGarbage = UI.Image:create()
        sellGarbage:init("ui_goods_button_bg_up_0.png")
        sellGarbage:rightUp(typeRight,1)
        sellGarbage:setSize(60,60)

        sellGarbage:setTouchEnable(true)
        sellGarbage:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function (self)
            sellGarbage:setScale(1.1)
        end)
        sellGarbage:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function (self)
            sellGarbage:setScale(1.0)
        end)
        sellGarbage:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self)
            -- 卖掉所有的垃圾物品
            self:sellGarbageEquipments()
            Avalon.AudioManager:playSound("1503")
        end)

        local sellButton = UI.Image:create()
        sellButton:init("ui_goods_button_sell_0.png")
        sellButton:center()
        sellGarbage:addChild(sellButton)

        bagBG:addChild(sellGarbage)
        self._sellGarbage = sellGarbage
        self._sellImage = sellButton

        deleteButtonBG:rightUp(typeRight + 60,1)
    end

    if SceneManager:getInstance():isInStory() then
        self._deleteButtonBG:setVisible(false)
        deleteButton:setTouchEnable(false)
        if(self._sellGarbage) then 
            self._sellGarbage:setVisible(false)
        end
    end

    -- 背包列表
    -- print("reload_script_file(app.ui.common.GoodsList.GoodsList)")
    -- reload_script_file("app.ui.common.GoodsList.GoodsListNew")
    local bagGridList = UI.GoodsListNew:create(nil, nil, false, FLITER_TYPE.EQUIPMENT_ONLY_SHOW_HERO)
    bagGridList:init(nil)
    bagGridList:leftBottom(26, 54)
    bagGridList:enableDoubleClick()
    bagGridList:setCallbackForGridDragBegan(self, onBagGridDragBeganHandler)
    bagGridList:setCallbackForGridDragMoved(self, onBagGridDragMovedHandler)
    bagGridList:setCallbackForGridDragEnded(self, onBagGridDragEndedandler)
    bagGridList:setCallbackForGridDoubleClick(self, onBagGridDoubleClickHandler)
    bagGridList:setCallbackForGridClick(self, onBagGridClickHandler)
    bagBG:addChild(bagGridList)
    self._bagGridList = bagGridList
    bagGridList:showMask()

    local lineOffsetX = 35 + 5
    local lineOffsetY = 508 - 34
    -- 上边的分割线
    local lineUpImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineUpImage:setContentSize(387, 1)
    lineUpImage:setCapInsets(CCRectMake(1,0,1,1))
    lineUpImage:setPosition(cc.p(lineOffsetX + lineUpImage:getContentSize().width/2, lineOffsetY))
    bagBG:addChild(lineUpImage, 4)
    
    local lineDownImage = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_line_dark.png")
    lineDownImage:setContentSize(387, 1)
    lineDownImage:setCapInsets(CCRectMake(1,0,1,1))
    lineDownImage:setPosition(cc.p(lineOffsetX + lineDownImage:getContentSize().width/2, lineOffsetY-378))
    bagBG:addChild(lineDownImage, 4)

    -- 添加背包格子按钮
    local gridOffsetY = 60 + 4
    local gridOffsetX = 60
    local gridImage = UI.Image:create()
    gridImage:init("ui_goods_icon_backpack.png")
    gridImage:leftBottom(gridOffsetX,gridOffsetY)
    bagBG:addChild(gridImage, 4)
    -- 可用格子
    local gridCountLabel = UI.GridText:create()
    gridCountLabel:init(string.format("%s/%s", 0, 0), UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    gridCountLabel:leftBottom(gridOffsetX + 40, gridOffsetY + 10)
    gridCountLabel:setSize(90, 30)

    bagBG:addChild(gridCountLabel)
    self._gridCountLabel = gridCountLabel

    local curreryOffsetY = 55 + 5
    -- 黄金
    local moneyOffsetX = 80
    local momeyImage = UI.Image:create()
    momeyImage:init(SPRITE_GAMING_MOMEY)
    momeyImage:leftUp(moneyOffsetX, curreryOffsetY)
    bagBG:addChild(momeyImage)
    -- 黄金数量
    self._momey = UI.Text:create()
    self._momey:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._momey:setTextVerticalCenter()
    self._momey:setTextLeft()
    self._momey:centerLeft(momeyImage:getContentSize().width + 4)
    momeyImage:addChild(self._momey)

    local diamondOffsetX = 220 + 26
    -- 钻石
    local diamondImage = UI.Image:create()
    diamondImage:init(SPRITE_GAMING_DIAMOND)
    diamondImage:leftUp(diamondOffsetX, curreryOffsetY)
    bagBG:addChild(diamondImage)
    -- 钻石数量
    self._diamond = UI.Text:create()
    self._diamond:init("0", UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_41_41_45)
    self._diamond:setTextLeft()
    self._diamond:centerLeft(diamondImage:getContentSize().width + 4)
    diamondImage:addChild(self._diamond)

    local shopButton = UI.Button:create()
    shopButton:init("ui_shopping_button_0.png", "ui_shopping_button_1.png")
    shopButton:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        Avalon.MessageCenter:notice(AvalonMessage.MC_UI_SHOW_IAPSHOP, nil, nil, self.parentLayer,
            PublicDefine.WebLogS3Type_Source_Type.WebLogS3Type_Source_Type_Bag)
    end)
    shopButton:rightUp(43 + 3, 47 + 9)
    shopButton:setInterval(1)
    bagBG:addChild(shopButton)
    if RoleDataManager:isUnlockByFunctionType(PublicDefine.UnlockFunctionType.UnlockFunctionType_Purchase)
        and not SceneManager:getInstance():isInStory() 
     then
        shopButton:show()
    else
        shopButton:hide()
    end
end

-- 初始化英雄详情视图
local function initBasicInfoView(self)

end

-- 更新角色数据
local function updateRoleView(self, roleData, wearEquipmentData)
    if (roleData) then
        self._roleShowArea:setData(roleData, wearEquipmentData)
        local area = not self._fishGearView and self._roleShowArea or self._fishGearView
        
        area:updateView()
    end
end

-- 角色状态改变 ODEI
local function onUpdateRoleStateHandler(self, roleData)
    local spriteID = roleData:getSpriteID()
    if RoleDataManager:getMasterSpriteID() == spriteID then
        -- 判断死亡
        self:updateGridUseState()
    end
end

-- private  私有函数
function RolePanel:sellGarbageEquipments()
    -- print("RolePanel:sellGarbageEquipments")
    local data = self._data
    local sellArr = {}
    local sellPrice = 0

    local sellGoodsArr = {}
    for i = 1, #data.haveEquipmentArr do
        local equipmentData = data.haveEquipmentArr[i]
        if(equipmentData and equipmentData:getIsLock() == false) then
            local goodsRare = equipmentData:getGoodsRare()
            if(goodsRare == PublicDefine.GOODS_RARE.RARE_WHITE_1 or goodsRare == PublicDefine.GOODS_RARE.RARE_BLUE_2) then
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
                if(goodsRare == PublicDefine.GOODS_RARE.RARE_WHITE_1 or goodsRare == PublicDefine.GOODS_RARE.RARE_BLUE_2) then
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
        print("RolePanel:sellGarbageEquipments    cancel.")
    end
    print("RolePanel:sellGarbageEquipments sellPrice=", sellPrice)
    
    UI.TipsLayer:onSalesEquipment(okCallBack, cancelCallBack, sellPrice)
end

-- 跟新基础数据
function RolePanel:updateBasicInfoView(data)
    if (data) then
        self._data.heroData = data 
        self._basicInfoArea:updateView(data)
        -- self._detailedInfoArea:updateView(data) 
    end
end

-- 更新 
function RolePanel:updateBasicView()
    -- body
    self._basicInfoArea:updateView(self._data.heroData)
end

-- 更新黄金钻石
function RolePanel:updateMoneyView()
    
    local data = self._data.heroData
    -- TODO
    self._momey:setText(self._momey:numformat(string.format("%s",data:getCurCoin())))
    self._momey:updateView()
    self._diamond:setText(self._diamond:numformat(string.format("%s",data:getDiamond())))
    self._diamond:updateView()
end

-- 更新装备列表的处理器
local function onUpdateEquipmentListHandler(self, equipmentDataList)
    if (equipmentDataList) then
        self._data.haveEquipmentArr = equipmentDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        assert(false)
    end
end

-- 更新宠物装备列表的处理器
local function onUpdatePetEquipmentListHandler(self, equipmentDataList)
    -- print("onUpdatePetEquipmentListHandler", #equipmentDataList)
    if (equipmentDataList) then
        self._data.havePetEquipmentArr = equipmentDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        assert(false)
    end
end

-- 更新道具列表的处理器
local function onUpdateItemListHandler(self, itemDataList)
    if (itemDataList) then
        self._data.haveItemArr = itemDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        assert(false)
    end
end

-- 更新材料列表的处理器
local function onUpdateMaterialListHandler(self, materialDataList)
    if (materialDataList) then
        self._data.haveMaterialArr = materialDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        assert(false)
    end
end

-- 更新宝石列表的处理器
local function onUpdateGemStoneListHandler(self, gemStoneDataList)
    if (gemStoneDataList) then
        self._data.haveGemStoneArr = gemStoneDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        assert(false)
    end
end

-- 更新遗物列表的处理器
local function onUpdateRelicListHandler(self, relicDataList)
    if (relicDataList) then
        self._data.haveRelicArr = relicDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        assert(false)
    end
end

-- 更新宝物列表的处理器
local function onUpdateTreasureListHandler(self, treasurDataList)
    if (treasurDataList) then
        self._data.haveTreasureArr = treasurDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        assert(false)
    end
end

-- 更新雕纹的处理器
local function onUpdateGlyphListHandler(self, glyphDataList)
    if (glyphDataList) then
        self._data.haveGlyphArr = glyphDataList
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
        -- showGoodsByTabIndex(self, self._tabIndex)
    else
        assert(false)
    end
end

-- 货币改变
local function onCurrencyChangeHandler(self, data)
    if (data) then
        self:updateMoneyView()
        --  处理金币以及钻石表现
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
    else
        assert(false)
    end
end

-- 解锁背包格子
local function onUnlockBagGridHandler(self)
    self._data = GameDataManager:getInstance():getPacketBoxData()
    refreshBagData(self)
    self._isUnlockBagFlag = true
    self._waitingRefreshGrid = 2
    -- self._bagGridList:setData(self._data)
    local data = self._data
     -- 更新格子数据
    local petNum = 0
    if(self._data.havePetEquipmentArr) then 
        petNum = #data.havePetEquipmentArr
    end
    local availableCount = data.packetBoxBeUseNum
    local usedCount = #data.haveEquipmentArr + petNum + #data.haveItemArr + #data.haveMaterialArr + #data.haveGemStoneArr + #data.haveRelicArr + #data.haveTreasureArr
    self._gridCountLabel:setText(tostring(usedCount), tostring(availableCount))
    self._gridCountLabel:updateView()

    -- updateGridList(self, self._data)
    self._bagGridList:updateGridCount()

    showGoodsByTabIndex(self, self._tabIndex)
end

local function onLoseGoodsResult(self)
    UI.WaitingLayer:hideWaiting()
    self._waitingRefreshGrid = 2
end

local function onEquipFailed(self, data)
    if(not tolua.isnull(self)) then
        refreshBagData(self)
        self._waitingRefreshGrid = 2
        -- updateGridList(self, self._data)
    end
    GameErrorManager:showError(ProtobufUtil:enum_id("GoodsSystem.EquipResult", data.result))
end

local function onUnEquipFailed(self, data) 
    if(not tolua.isnull(self)) then
        onWearEquipmentChangedHandler(self, self._data)
    end
    GameErrorManager:showError(ProtobufUtil:enum_id("GoodsSystem.UnEquipResult", data.result))
end

local function onCloseFishGearHandler(self) 
    self._fishGearView:close()
    self._fishGearView = nil
end

-- 构造函数
function RolePanel:ctor()
    RolePanel.super.ctor(self, UIType.ROLE_PANEL, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._data = nil

    self._basicInfoArea = nil
    self._bagGridList = nil
    self._roleShowArea = nil
    self._selectEquipmentButton = nil
    -- 等待刷新背包格子
    self._waitingRefreshGrid = -1
    -- 装备评分
    self._equipmetScore = nil
 
    -- 人物详情页面，装备详情页面，物品详情页面
    self._detailedInfoArea = nil 
    self._equipmentInfoArea = nil 
    -- 呼出详情面板按钮
    self._arrow = nil
    -- 删除装备按钮
    self._deleteButton = nil 
    -- 删除装备按钮的状态
    self._deleteState =  false
    self._tabIndex = 0
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
    self._propInfoArea = nil -- 道具详情界面
    self._materialInfoArea = nil --材料详情界面
    self._petStoneInfoArea = nil -- 宠物装备宝石详情界面
    self._bagLayer = nil 

    self._checkItemUseState = true

    self._useLock = true

    self._fishGearView = nil

    -- 监听消息
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE, self, onUpdateEquipmentListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, onUpdateItemListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, onUpdateMaterialListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_TREASURE_CHANGE, self, onUpdateTreasureListHandler)
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, onUpdateGemStoneListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, onUpdateRelicListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE, self, onUpdatePetEquipmentListHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_GLYPH_CHANGE, self, onUpdateGlyphListHandler)
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, onWearEquipmentChangedHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    -- 角色状态更新 
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, onUpdateRoleStateHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_BAG_LOSE_RESULT, self, onLoseGoodsResult)

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_EQUIP_FAILED, self, onEquipFailed)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_UN_EQUIP_FAILED, self, onUnEquipFailed)
    Avalon.MessageCenter:bind(AvalonMessage.MC_CLOSE_FISHING_GEAR_VIEW, self, onCloseFishGearHandler)
    Avalon.Scheduler:scheduleUpdate(self, self.update)
end

-- 析构函数
function RolePanel:dtor()
    for k,v in pairs(self._data.wearEquipmentArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    if(self._data.wearPetEquipmentArr) then
        for k,v in pairs(self._data.wearPetEquipmentArr) do
            v._changeNum = 0
            v.canUseState = true
        end
    end

    for k,v in pairs(self._data.haveEquipmentArr) do
        v._changeNum = 0
        v.canUseState = true
    end

    if(self._data.havePetEquipmentArr) then
        for k,v in pairs(self._data.havePetEquipmentArr) do
            v._changeNum = 0
            v.canUseState = true
        end
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

    self._data = nil

    self._basicInfoArea = nil
    self._bagGridList = nil
    self._roleShowArea = nil
    self._equipmetScore = nil

    -- 英雄详情页面
    self._detailedInfoArea = nil 
    -- 装备详情页面
    self._equipmentInfoArea = nil 
    self._propInfoArea = nil -- 道具详情界面
    self._materialInfoArea = nil --材料详情界面
    self._petStoneInfoArea = nil
    -- 呼出详情面板按钮
    self._arrow = nil
    self._deleteButton = nil 
    self._selectedBagGrid = nil
    self._selectedRoleGrid = nil
    self._bagLayer = nil 

    self._useLock = true

    self._fishGearView = nil


    Avalon.MessageCenter:unbindForTarget(self)
    RolePanel.super.dtor(self)

    -- 监听消息
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_EQUIPMENT_CHANGE, self, onUpdateEquipmentListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_ITEM_CHANGE, self, onUpdateItemListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_MATERIAL_CHANGE, self, onUpdateMaterialListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_TREASURE_CHANGE, self, onUpdateMaterialListHandler)
    
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_GEM_STONE_CHANGE, self, onUpdateGemStoneListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_WEAR_EQUIPMENT_CHANGE, self, onWearEquipmentChangedHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_RELIC_CHANGE, self, onUpdateRelicListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_PET_EQUIPMENT_CHANGE, self, onUpdatePetEquipmentListHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_CURRENCY_CHANGE, self, onCurrencyChangeHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UNLOCK_BAG, self, onUnlockBagGridHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_GLYPH_CHANGE, self, onUpdateGlyphListHandler)
    -- 角色状态更新 
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, onUpdateRoleStateHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_BAG_LOSE_RESULT, self, onLoseGoodsResult)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_EQUIP_FAILED, self, onEquipFailed)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_UN_EQUIP_FAILED, self, onUnEquipFailed)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_CLOSE_FISHING_GEAR_VIEW, self, onCloseFishGearHandler)
    Avalon.Scheduler:unscheduleUpdate(self, self.update)
end

-- public:
-- 初始化
function RolePanel:init(bagLayer,bagData, parentLayer)
    self._bagLayer = bagLayer 
    self._data = bagData
    self.parentLayer = parentLayer
    refreshBagData(self)
    RolePanel.super.init(self)
end

-- 初始化视图
function RolePanel:onInitView()
    -- 计算整个面板的缩放值
    local scale = computeLayoutScale(winSize.width, LAYOUT_DESIGN_WIDTH)

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(LAYOUT_DESIGN_WIDTH, LAYOUT_FUNCTION_HEIGHT)
    contentLayout:centerBottom(0)
    -- contentLayout:setScale(scale)
    self:addChild(contentLayout)
    self._contentLayout = contentLayout

    -- 背景后藤蔓
    local vine = UI.Animation:create()
    vine:init("effect_ui_package_character_tengman_up.json", "effect_ui_package_character_tengman_up.atlas", 1);
    vine:leftBottom(515, 490)
    vine:setAnimation("idle", true)
    self._contentLayout:addChild(vine)

    local bg = cc.Scale9Sprite:createWithSpriteFrameName("ui_scale9image_banner_character.png")
    bg:setCapInsets(CCRectMake(0,0,1,1))
    bg:setContentSize(LAYOUT_DESIGN_WIDTH - 48, LAYOUT_FUNCTION_HEIGHT)
    bg:setPosition(LAYOUT_DESIGN_WIDTH/2 - 2, LAYOUT_FUNCTION_HEIGHT/2)
    self._contentLayout:addChild(bg)
    
    
    -- 创建背包列表的视图
    initBagGridListView(self)

    -- 创建角色展示区域
    initEquipmentView(self)
end

-- 更新视图
function RolePanel:onUpdateView()
    local data = self._data
    if (data) then
        updateRoleView(self, data.heroData, data.wearEquipmentArr)
        updateGridList(self, data)
        -- self:updateBasicInfoView(data.heroData)
        self:updateMoneyView()
    end
    -- 创建基础信息的视图
    initBasicInfoView(self)
end

-- 关闭选中
function RolePanel:closeChoese()

    if not tolua.isnull(self._selectedBagGrid) then 
        self._selectedBagGrid:hideSelect()
        self._selectedBagGrid = nil 
    end
    
    if  self._selectedRoleGrid then 
        self._roleShowArea:unselectEquipment()
        self._selectedRoleGrid = nil 
    end
end

-- 判断是否处于战斗中
function RolePanel:isBattle()
    local heroData = RoleDataManager:getMaster()
    local state = heroData:getState()
    if FSMState.BATTLE == state then 
        return true
    end
    return false
end

-- 禁用使用道具
function RolePanel:disableToUseGoods()
    self._bagGridList:disableDoubleClick()
end

--设置是否能用解锁的道具
function RolePanel:setUseLock(var)
    self._useLock = var
end

-- 刷新格子是否可以使用状态
function RolePanel:updateGridUseState()
    self._bagGridList:updataGridCanUseState(self._checkItemUseState, self._useLock, self._deleteState, self._usedType)
end

function RolePanel:updataGridCanUseState(grid)
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
        end
    end
end

function RolePanel:showShareBtn(parentNode)
    -- add by zp CO-13511 CN分享图还原为普通版
    -- if CAVEOL_TARGET == CAVEOL_TARGET_GLOBAL then
        parentNode:showShareBtn(handler(self, self.createShareInfo2), PublicDefine.SHARE_MODULE.SHARE_MODULE_EQUIPMENTS)
    -- else
    --     parentNode:showShareBtn(handler(self, self.createShareInfo), PublicDefine.SHARE_MODULE.SHARE_MODULE_EQUIPMENTS)
    -- end
end

function RolePanel:getRoleAreaScreenshot()
    -- 创建锚点
    local anchor = UI.Component:create()
    anchor:init()
    
    self._roleShowArea:visitForScreenshot(anchor)
    return anchor
end

function RolePanel:createShareInfo(platform)

    -- 整体宿主
    local screenhostHost = UI.Component:create()
    screenhostHost:init()
    screenhostHost:setSize(640, 1200)
    screenhostHost:leftBottom(0, 0)
    cc.Director:getInstance():getRunningScene():addChild(screenhostHost, -1)

    -- 背景整体
    local bg = UI.Image:create()
    bg:init("ui_share_banner_1.png")
    bg:leftBottom(0, 0)
    screenhostHost:addChild(bg)

    -- 装备界面
    local equipNode = self:getRoleAreaScreenshot()
    equipNode:leftBottom(100, 830)
    bg:addChild(equipNode)

    -- QR码(当前背景图有二维码)
    require "app.config.ConfigManager"
    local SdkBox = require("utils.sdkbox.SdkBox")
    local shareDatas = ConfigManager:getShareConfigByType(PublicDefine.SHARE_MODULE.SHARE_MODULE_EQUIPMENTS, platform)
    -- local qrSprite = SdkBox:getInstance():createQRSprite(shareDatas.url)
    -- qrSprite:setAnchorPoint(0.5, 0.5)
    -- local qrImage = UI.Image:create()
    -- qrImage:initWithSprite(qrSprite)
    -- qrImage:center(-240, 470)
    -- qrImage:setScale(90 /qrImage._width)
    -- bg:addChild(qrImage)
    
    -- 分享
    performWithDelay(self, function()
        SdkBox:getInstance():createImage(bg,"share.png",function(path)
            SdkBox:getInstance():share({
                channel = platform,
                link = shareDatas.url,
                content =  LanguageManager:getInstance():getLocalString(shareDatas.content[math.random(1,table.nums(shareDatas.content))]),
                type = PublicDefine.SHARE_CONTENT_TYPE.IMAGE,
                -- stype = Avalon.WXScene.WXSceneTimeline
                title = LanguageManager:getInstance():getLocalString(shareDatas.title[math.random(1,table.nums(shareDatas.title))]),
                thumb = AvalonUtil.getShareThumbPath(shareDatas),
                image = path,
            })
            if screenhostHost and not tolua.isnull(screenhostHost) then
                screenhostHost:setVisible(false)
                screenhostHost:runAction(cc.RemoveSelf:create())
            end
        end)
    end, 0.05)
end

function RolePanel:createShareInfo2(platform)
    -- 整体宿主
    local screenhostHost = UI.Component:create()
    screenhostHost:init()
    screenhostHost:setSize(640, 1200)
    screenhostHost:leftBottom(0, 0)
    cc.Director:getInstance():getRunningScene():addChild(screenhostHost, -1)

    -- 背景整体
    local bg = UI.Image:create()
    bg:init("ui_share_banner_2.png")
    bg:leftBottom(0, 0)
    screenhostHost:addChild(bg)

    -- LOGO
    local logoTop = UI.Image:create()
    logoTop:init("ui_share_logo2.png")
    logoTop:leftBottom(331, 1060)
    bg:addChild(logoTop)

    -- 标题
    local title = UI.Text:create()
    title:init(LanguageManager:getInstance():getLocalString(1111557), UI.FONT_BOLD, UI.FONT_SIZE_42PX, UI.FONT_COLOR_255_204_0)
    title:center(157, -428)
    bg:addChild(title)

    -- 装备背景
    local equipBg = UI.Image:create()
    equipBg:init("ui_share_box2.png")
    equipBg:leftBottom(20, 204)
    bg:addChild(equipBg)

    -- 装备界面
    local equipNode = self:getRoleAreaScreenshot()
    equipNode:leftBottom(100, 760)
    bg:addChild(equipNode)

    -- logo 2
    local npc = UI.Image:create()
    npc:init("ui_share_logo.png")
    npc:leftBottom(434, 19)
    bg:addChild(npc)

    -- QR码
    require "app.config.ConfigManager"
    local SdkBox = require("utils.sdkbox.SdkBox")
    local shareDatas = ConfigManager:getShareConfigByType(PublicDefine.SHARE_MODULE.SHARE_MODULE_EQUIPMENTS, platform)
    local qrSprite = SdkBox:getInstance():createQRSprite(shareDatas.url)
    qrSprite:setAnchorPoint(0.5, 0.5)
    local qrImage = UI.Image:create()
    qrImage:initWithSprite(qrSprite)
    qrImage:center(-237, 515)
    qrImage:setScale(60 /qrImage._width)
    bg:addChild(qrImage)
    
    -- 分享
    performWithDelay(self, function()
        SdkBox:getInstance():createImage(bg,"share.png",function(path)
            SdkBox:getInstance():share({
                channel = platform,
                link = shareDatas.url,
                content =  LanguageManager:getInstance():getLocalString(shareDatas.content[math.random(1,table.nums(shareDatas.content))]),
                type = PublicDefine.SHARE_CONTENT_TYPE.IMAGE,
                -- stype = Avalon.WXScene.WXSceneTimeline
                title = LanguageManager:getInstance():getLocalString(shareDatas.title[math.random(1,table.nums(shareDatas.title))]),
                thumb = AvalonUtil.getShareThumbPath(shareDatas),
                image = path,
            })
            if screenhostHost and not tolua.isnull(screenhostHost) then
                screenhostHost:setVisible(false)
                screenhostHost:runAction(cc.RemoveSelf:create())
            end
        end)
    end, 0.05)
    
end


function RolePanel:update(dt)
    if(self._waitingRefreshGrid > -1) then
        if(self._waitingRefreshGrid == 0) then 
            updateGridList(self, self._data)
            self._waitingRefreshGrid = -1
        end
        self._waitingRefreshGrid = self._waitingRefreshGrid - 1
    end
end

function RolePanel:refreshPacketType(tabIndex)
    if tabIndex == 7 then
        self._data.packetType = PublicDefine.PACKET_TYPE.PACKET_GLYPH
    else
        self._data.packetType = PublicDefine.PACKET_TYPE.PACKET_BAG
    end
end
