--[[
    UI - 背包格子
]]--

require "app.ui.Component"

UI = UI or {}

local GoodsGrid = class("GoodsGrid", UI.ListGrid)
UI.GoodsGrid = GoodsGrid
local scheduler=cc.Director:getInstance():getScheduler()

-- 背包格子的状态
UI.GoodsGridState = {
    USED = 1,  -- 被占用
    EMPTY = 2, -- 空格子
    LOCK = 3   -- 被解锁
}
GoodsGridState = UI.GoodsGridState

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 尺寸
local COM_WIDTH = 68
local COM_HEIGHT = 68
-- 背包资源
local RES_LIST = {
    "ui_common_information.plist",
    "ui_town_navigation.plist"
}

-- 图片精灵名字
-- 格子锁定的图片
local SPRITE_GRID_BG_LOCK = "ui_goods_banner_lock.png"
-- 格子中装备的品质
local SPRITE_GRID_RARE = "box_quality_%s_%s.png"
-- 格子中物品是否被锁定
local SPRITE_ITEM_ICON_LOCK = "ui_information_lock.png"
-- 格子中船是否被锁定
local SPRITE_BOAT_ICON_LOCK = "ui_navigation_lock.png"

-- 选中装备的动画
local FX_ITEMLIST_ITEMSELECT_JSON =  "effect_ui_gaming_itemselect.json"
local FX_ITEMLIST_ITEMSELECT_ATLAS = "effect_ui_gaming_itemselect.atlas"

-- 解锁动画
local FX_EFFECT_UI_UNLOCK_JSON = "effect_ui_package_character_unlock.json"
local FX_EFFECT_UI_UNLOCK_ATLAS = "effect_ui_package_character_unlock.atlas"

-- 数量显示位置
local POSITION_X_COUNT = 50
local POSITION_Y_COUNT = -3
-- 锁的位置，新的位置
local POSITION_X_LOCK = 62
local POSITION_Y_LOCK = 62
-- 船的锁的位位置
local POSITION_X_LOCK_BOAT = 34
local POSITION_Y_LOCK_BOAT = 11
-- 精练星级图标
local POSITION_X_STAR = 10 
local POSITION_Y_STAR = 10 

-- 子节点的z序
local ZORDER_BAG_GRID_BG = 1
local ZORDER_BAG_GRID_ICON = 2
local ZORDER_BAG_GRID_RARE = 3
local ZORDER_BAG_GRID_NEW_FLAG = 4
local ZORDER_BAG_GRID_LOCK_FLAG = 5
local ZORDER_BAG_GRID_CHOICE_STATUS_FLAG = 6
local ZORDER_BAG_GRID_STAR = 6
local ZORDER_BAG_GRID_STAR_LEVEL = 7
local ZORDER_BAG_GRID_COUNT = 8
local ZORDER_BAG_GRID_ANIMATION = 9
local ZORDER_BAG_GRID_STRENGTHEN_LEVEL = 10
local ZORDER_BAG_GRID_NEW_GIFT_BOX = 11
local ZORDER_BAG_GRID_UPGRADABLE_EQUIP = 12

local winSize = cc.Director:getInstance():getWinSize()

-- 构造函数
function GoodsGrid:ctor()
    GoodsGrid.super.ctor(self, RES_LIST, COM_WIDTH, COM_HEIGHT)

    -- 格子数据
    self._data = nil
    -- 格子索引
    self._index = 0
    -- 格子状态
    self._state = GoodsGridState.LOCK
    -- 是否被选中
    self._isSelect = false
    self._isIconVisible = true

    -- 背景图片
    self._bgSprite = nil
    -- 格子中的物品
    self._iconSprite = nil
    -- 格子锁定标识
    self._lockSprite = nil 
    -- 新物品标识
    self._newSprite = nil
    -- 物品稀有度
    self._rareSprite = nil 
    -- 物品数量
    self._countLabel = nil
    -- 宝石等级表现
    self._gemLevelText = nil

    -- 选中时候的动画
    self._selectItem = nil 
    -- 等待选中的表现
    self._choiceStatus = nil
    self._deleteItem = nil 

    self._infoItem = nil
    self._showRare = true
    -- 赋值则会走强制显示逻辑
    -- self._showCountLabel = true

    self._dragAnimation = nil

    self._preZorder = 1

    -- 装备强化等级
    self._txtStrengthenLevel = nil
    self.refineContent = nil
    
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
    self.mSchedulerID = 0

end

-- 析构函数
function GoodsGrid:dtor()
    GoodsGrid.super.dtor(self)
    self._gemLevelText = nil
    self.gemStoneEquipImg = nil
    self.glyphEquipImg = nil
    self.gemStoneLinkImg = nil
    if(not tolua.isnull(self._choiceStatus)) then 
        self._choiceStatus:removeFromParent(true)
        self._choiceStatus = nil
    end

    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_LOCK_STATUS_CHANGE, self, self.lockStatusChange)
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
        self.mSchedulerID = 0
    end

    if (not tolua.isnull(self.dragCloneNode)) then
        self.dragCloneNode:removeFromParent()
        self.dragCloneNode = nil
    end
end

-- public:
-- 初始化
function GoodsGrid:init(data)
    if (data) then
        self:setData(data)
    end

    GoodsGrid.super.init(self)
end

function GoodsGrid:setIsHideUseBtn(isHideUseBtn)
    self.isHideUseBtn = isHideUseBtn
end

-- 锁定状态改变
function GoodsGrid:lockStatusChange(data)
    if(self._data and data) then
        local goodsData = self._data

        if(goodsData) then
            if(goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT
                or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT
                or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
                or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
                or goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC
        	) then
                if(goodsData:getEntityID() == data.entityID) then
                    self:refreshLock()
                end
            else
                -- 判断是否是相同的包裹,然后在判断是否为同一个物品
                local handle = true
                if(self._packetType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE or data.packetType == PublicDefine.PACKET_TYPE.PACKET_WAREHOUSE) then
                    if(self._packetType ~= data.packetType) then
                        handle = false
                    end
                end

                if(handle) then
                    if(data.templateID == goodsData:getGoodsID() ) then
                        print("GoodsList:lockStatusChange prop ", data.isLock, goodsData:getIsLock())
                        self:refreshLock()
                    end
                end
            end
        end
    end
end

-- 设置可用
function GoodsGrid:setAvailable(available)
    if (available) then self._state = GoodsGridState.EMPTY
    else self._state = GoodsGridState.LOCK
    end
end

-- 是否可用
function GoodsGrid:isAvailable()
    return self._state == GoodsGridState.EMPTY
end

-- 是否已经被使用
function GoodsGrid:isUsed()
    return self._state == GoodsGridState.USED
end

-- 是否被锁定
function GoodsGrid:isLocked()
    return self._state == GoodsGridState.LOCK
end

-- 是否可以显示信息
function GoodsGrid:isClickShowInfo()
    if(self._data) then
        if self._data:getUseNum() > 0 and self._data:getNum() - self._data:getUseNum() <= 0 then 
            return false
        end
        
        return true
    end

    return false
end

-- 设置数据
function GoodsGrid:setData(data)
    assert(data and type(data) == "table", "GoodsGrid setData: data is invalid.")

    if (data) then
        self:reset()

        self._data = data
        self._state = GoodsGridState.USED
    end
end

-- 获取数据
function GoodsGrid:getData()
    return self._data
end

-- 显示新宝箱提示
function GoodsGrid:setShowNewBoxIcon(b)
    if(b and self._newGiftBoxIcon == nil) then
        self._newGiftBoxIcon = UI.Animation:create()
        self._newGiftBoxIcon:init("effect_ui_package_return_gift.json", "effect_ui_package_return_gift.atlas", 1)
        self._newGiftBoxIcon:setAnimation("idle", true)
        self._newGiftBoxIcon:rightUp(5, 5)
        self:addChild(self._newGiftBoxIcon, ZORDER_BAG_GRID_NEW_GIFT_BOX)
    end

    self._showNewGiftBoxIcon = b
    if (self._newGiftBoxIcon) then
        self._newGiftBoxIcon:setVisible(b)
    end
end 

-- 显示10级以下装备提示
function GoodsGrid:setShowNewEquipIcon(b)
    if(b and self._equipUpgradableIcon == nil) then
        self._newGiftBoxIcon = UI.Animation:create()
        self._newGiftBoxIcon:init("effect_ui_town_selectfloor_special_event_grade.json", "effect_ui_town_selectfloor_special_event_grade.atlas", 1)
        self._newGiftBoxIcon:setAnimation("up", true)
        self._newGiftBoxIcon:rightUp(5 + 30, 5 + 27)
        self:addChild(self._newGiftBoxIcon, ZORDER_BAG_GRID_UPGRADABLE_EQUIP)
    end

    self._showEquipUpgradable = b
    if (self._equipUpgradableIcon) then
        self._equipUpgradableIcon:setVisible(b)
    end
end

-- 显示新装备
function GoodsGrid:showNewIcon(forceShowHide)
    -- 是否是新物品
    local isNew = nil
    if (self._data) then
        isNew = self._data:getIsNew()
    end

    -- 是否显示
    local isShow = forceShowHide
    if (isShow == nil) then
        isShow = isNew
    end 

    -- 分类型显示不同红点
    require "app.utils.BagNotificationUtil"
    if (BagNotificationUtil:checkShowGiftBoxIcon(self._data)) then
        -- 宝箱
        if (self._newSprite) then self._newSprite:setVisible(false) end
        self:setShowNewEquipIcon(false)
        self:setShowNewBoxIcon(isShow)
    elseif (BagNotificationUtil:checkShowEquipUpgradableIcon(self._data)) then
        -- 可更换装备 + 人物等级小于10
        if (self._newSprite) then self._newSprite:setVisible(false) end
        self:setShowNewBoxIcon(false)
        self:setShowNewEquipIcon(isShow)
    else
        -- 泛型红点
        self:setShowNewBoxIcon(false)
        self:setShowNewEquipIcon(false)

        -- 如果没有红点, 创建红点
        if (isShow and not self._newSprite) then
            self._newSprite = AvalonUtil.createRedPoint(self, -3, -3, ZORDER_BAG_GRID_NEW_FLAG)
        end

        -- 如果有红点, 设置显示
        if (self._newSprite) then self._newSprite:setVisible(isShow) end
    end
end

-- 不现实新装备
function GoodsGrid:hideNewIcon()
    if (self._newSprite) then
        self._newSprite:setVisible(false)
    end
    self:setShowNewEquipIcon(false)
    self:setShowNewBoxIcon(false)
end

-- 显示所有图标
function GoodsGrid:showIcon()
    self:showNewIcon(true)
    if (self._iconSprite) then self._iconSprite:setVisible(true) end
    if (self._lockSprite) then self._lockSprite:setVisible(true) end
    if (self._rareSprite) then self._rareSprite:setVisible(true) end
    if (self._countLabel) then self._countLabel:setVisible(true) end
    if (self._txtStrengthenLevel) then self._txtStrengthenLevel:setVisible(true) end
    if (self.refineContent) then self.refineContent:setVisible(true) end
    if (self._strengthenMaxLevel) then self._strengthenMaxLevel:setVisible(true) end
    if (self._gemLevelText) then self._gemLevelText:setVisible(true) end
    if (self._deleteItem) then self._deleteItem:setVisible(true) end
    if(self._showChoiceStatus) then 
        if (self._choiceStatus) then self._choiceStatus:setVisible(true) end
    end
    self:updateView()

    self._isIconVisible = true
end

-- 隐藏所有图标
function GoodsGrid:hideIcon()
    self:hideNewIcon()
    if (self._iconSprite) then self._iconSprite:setVisible(false) end
    if (self._lockSprite) then self._lockSprite:setVisible(false) end
    if (self._rareSprite) then self._rareSprite:setVisible(false) end
    if (self._countLabel) then self._countLabel:setVisible(false) end
    if (self._txtStrengthenLevel) then self._txtStrengthenLevel:setVisible(false) end
    if (self.refineContent) then self.refineContent:setVisible(false) end
    if (self._strengthenMaxLevel) then self._strengthenMaxLevel:setVisible(false) end
    if self._data == nil 
        or self._data:getType() ~= PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
        or not self._data:getIsExpType() then
        if (self._gemLevelText) then self._gemLevelText:setVisible(false) end
    end
    if self._data == nil 
        or self._data:getType() ~= PublicDefine.GOODS_TYPE.GOODS_PET_STONE
        or not self._data:getIsExpType() then
        if (self._gemLevelText) then self._gemLevelText:setVisible(false) end
    end
    if (self._deleteItem) then self._deleteItem:setVisible(false) end
    if (self._choiceStatus) then self._choiceStatus:setVisible(false) end
    self._isIconVisible = false
    if (self.gemStoneEquipImg) then 
        self.gemStoneEquipImg:removeFromParent() 
        self.gemStoneEquipImg = nil
    end
    if self.gemStoneLinkImg then
        self.gemStoneLinkImg:removeFromParent()
        self.gemStoneLinkImg = nil
    end
    if (self.glyphEquipImg) then
        self.glyphEquipImg:removeFromParent() 
        self.glyphEquipImg = nil
    end
end

function GoodsGrid:isIconVisible()
    return self._isIconVisible
end

function GoodsGrid:showCountLabel()
    self._showCountLabel = true
    if (self._countLabel) then self._countLabel:setVisible(true) end
end

function GoodsGrid:hideCountLabel()
    self._showCountLabel = false
    if (self._countLabel) then self._countLabel:setVisible(false) end
end

-- 隐藏所有动画
function GoodsGrid:hideAllAnimation()
    if (self._selectItem) then self._selectItem:setVisible(false) end
    if (self._deleteItem) then self._deleteItem:setVisible(false) end
end

-- 显示背景
function GoodsGrid:showBG()
    if (self._bgSprite) then self._bgSprite:setVisible(true) end
end

-- 隐藏背景
function GoodsGrid:hideBG()
    if (self._bgSprite) then self._bgSprite:setVisible(false) end
end

-- 隐藏品质表现
function GoodsGrid:hideRare()
    self._showRare = false
    if (self._rareSprite) then self._rareSprite:setVisible(false) end
end


-- 显示所有标志图标
function GoodsGrid:showFlagIcon()
    self:showNewIcon(true)
    if (self._lockSprite) then self._lockSprite:setVisible(true) end
    if (self._countLabel) then self._countLabel:setVisible(true) end
    if (self._txtStrengthenLevel) then self._txtStrengthenLevel:setVisible(true) end
    if (self._strengthenMaxLevel) then self._strengthenMaxLevel:setVisible(true) end
    if (self._gemLevelText) then self._gemLevelText:setVisible(true) end
    if (self._deleteItem) then self._deleteItem:setVisible(true) end
    if(self._showChoiceStatus) then 
        if (self._choiceStatus) then self._choiceStatus:setVisible(true) end
    end
    self:updateView()
end

-- 隐藏所有标志图标
function GoodsGrid:hideFlagIcon()
    self:hideNewIcon()
    if (self._lockSprite) then self._lockSprite:setVisible(false) end
    if (self._countLabel) then self._countLabel:setVisible(false) end
    if (self._txtStrengthenLevel) then self._txtStrengthenLevel:setVisible(false) end
    if (self._strengthenMaxLevel) then self._strengthenMaxLevel:setVisible(false) end
    if self._data == nil 
        or self._data:getType() ~= PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
        or not self._data:getIsExpType() then
        if (self._gemLevelText) then self._gemLevelText:setVisible(false) end
    end
    if self._data == nil 
        or self._data:getType() ~= PublicDefine.GOODS_TYPE.GOODS_PET_STONE
        or not self._data:getIsExpType() then
        if (self._gemLevelText) then self._gemLevelText:setVisible(false) end
    end
    if (self._deleteItem) then self._deleteItem:setVisible(false) end
    if (self._choiceStatus) then self._choiceStatus:setVisible(false) end
    if (self.gemStoneEquipImg) then 
        self.gemStoneEquipImg:removeFromParent() 
        self.gemStoneEquipImg = nil
    end
    if self.gemStoneLinkImg then
        self.gemStoneLinkImg:removeFromParent()
        self.gemStoneLinkImg = nil
    end
    if (self.glyphEquipImg) then 
        self.glyphEquipImg:removeFromParent() 
        self.glyphEquipImg = nil
    end
end

function GoodsGrid:showGemLevel()
    if self._gemLevelText then
        self._gemLevelText:show()
    end
end

function GoodsGrid:hideGemLevel()
    if self._gemLevelText then
        -- self._gemLevelText:hide()
        self._gemLevelText:setVisible(false)
    end
end

function GoodsGrid:refreshGemLevel()
    if self._data and (self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE 
        or self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
        or self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
        or self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then 
        if(self._gemLevelText == nil) then 
            self._gemLevelText = UI.Text:create()
            self._gemLevelText:init("", UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_254_255_188)
            self._gemLevelText:leftUp(0, -2)
            -- self._gemLevelText:setOutline(UI.FONT_COLOR_OUTLINE_20_10_10)
            self._gemLevelText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
            self:addChild(self._gemLevelText, ZORDER_BAG_GRID_ICON + 1)
        end
        self._gemLevelText:setVisible(true)

        if self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
            if(self._data:getNextLVID() == 0) then 
                self._gemLevelText:setText("Lvmax")
            else
                self._gemLevelText:setText(string.format("Lv%d", self._data:getStoneLV()))
            end
        elseif self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then
            if(self._data:isMaxLevel()) then 
                self._gemLevelText:setText("Lvmax")
            else
                self._gemLevelText:setText(string.format("Lv%d", self._data:getLevel()))
            end
        elseif self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
            if self._data.clientLevel and self._data.clientLevel > 0 then
                self._gemLevelText:setText(string.format("Lv%d", self._data.clientLevel))
            else
                if(self._data:isMaxLevel()) then 
                    self._gemLevelText:setText("Lvmax")
                else
                    self._gemLevelText:setText(string.format("Lv%d", self._data:getLevel()))
                end
            end
        elseif self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC then
            self._gemLevelText:setText(string.format("Lv%d", self._data:getLevel()))
        end
    end 
end

-- 克隆
function GoodsGrid:createDraggedView()
    print("--------------GoodsGrid:createDraggedView")
    local newGoodsGrid = UI.GoodsGrid:create()
    newGoodsGrid:init(self._data)
    newGoodsGrid:setSize(self._width, self._height)
    newGoodsGrid:setIndex(self._index)
    newGoodsGrid:setScale(self:getScale())
    return newGoodsGrid
end

-- 设置背景图片
function GoodsGrid:setBG(spriteName)
    assert(type(spriteName) == "string", "GoodsGrid setBG: sprite name is invalid.")

    self._bgSprite:setSpriteFrame(spriteName)
end

-- 回复
function GoodsGrid:reset()
    self._state = GoodsGridState.LOCK
    self._data = nil
    self._isSelect = false
end

-- 初始化视图
function GoodsGrid:onInitView()
    if self._bgSprite ~= nil then
        printError("---repeat onInitView in GoodsGrid:onInitView()-------------")
    end
    -- 格子背景
    self._bgSprite = cc.Sprite:create()
    self._bgSprite:setSpriteFrame(string.format("box_quality_box_0%d.png", math.random(1,2)))
    self:addChild(self._bgSprite , ZORDER_BAG_GRID_BG)
 
    -- 物品图标
    self._iconSprite = cc.Sprite:create()
    self:addChild(self._iconSprite, ZORDER_BAG_GRID_ICON)

    if(self._isGray) then 
        self._iconSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
        self._bgSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
    end

    if self._data and self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then 
        self._gemLevelText = UI.Text:create()
        self._gemLevelText:init("", UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_254_255_188)
        self._gemLevelText:leftUp(0, -2)
        -- self._gemLevelText:setOutline(UI.FONT_COLOR_OUTLINE_20_10_10)
        self._gemLevelText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
        self:addChild(self._gemLevelText, ZORDER_BAG_GRID_ICON + 1)

    end
end

function GoodsGrid:showChoiceStatus()
    -- print("GoodsGrid:showChoiceStatus=", self._state,  GoodsGridState.USED)
    self._showChoiceStatus = true
    if (self._state == GoodsGridState.USED) then
        if(self._choiceStatus == nil) then
            self._choiceStatus = UI.Image:create()
            self._choiceStatus:init("ui_information_box.png")
            self:addChild(self._choiceStatus, ZORDER_BAG_GRID_CHOICE_STATUS_FLAG)
            self._choiceStatus:rightUp(0, 0)
            self._choiceStatus:hide()
        end
        if (self._data.canUseState == nil or self._data.canUseState == true ) then
            self._choiceStatus:show()
        else 
            self._choiceStatus:hide()
        end 
    end
end

function GoodsGrid:hideChoiceStatus()
    self._showChoiceStatus = false
    if(self._choiceStatus) then 
        self._choiceStatus:hide()
    end
end

function GoodsGrid:showSelect()
    if (not self._selectItem) then
        self._selectItem  = UI.Animation:create()
        self._selectItem:init(FX_ITEMLIST_ITEMSELECT_JSON, FX_ITEMLIST_ITEMSELECT_ATLAS)
        self._selectItem:center()
        self:addChild(self._selectItem, ZORDER_BAG_GRID_ANIMATION)
    end

    self._selectItem:show()
    self._selectItem:setAnimation("start_square", false)
    self._selectItem:addAnimation("loop_square", true)

    self:refreshCanUseState()
    self._preZorder = self:getZOrder()
    self:setZOrder(99999)
end

function GoodsGrid:useItem()
    if (not self._selectItem) then
        self._selectItem  = UI.Animation:create()
        self._selectItem:init(FX_ITEMLIST_ITEMSELECT_JSON, FX_ITEMLIST_ITEMSELECT_ATLAS)
        self._selectItem:center()
        self:addChild(self._selectItem, ZORDER_BAG_GRID_ANIMATION)
    end

    if (self._selectItem) then
        self._selectItem:show()
        self._selectItem:setAnimation("start_square", false)
    end
    self:refreshCanUseState()
end

function GoodsGrid:hideSelect()
    if (self._selectItem) then
        -- self._selectItem:addAnimation("end_square", false)
        self._selectItem:setAnimation("end_square", false)
    end
    self:refreshCanUseState()
    if(self._preZorder == 99999) then 
        self._preZorder = 1
    end
    self:setZOrder(self._preZorder)
end

function GoodsGrid:deleteItem()
    if (not self._deleteItem) then
        self._deleteItem = UI.Image:create()
        self._deleteItem:init("ui_information_btn_yes.png")
        self._deleteItem:rightUp(-8, -3)
        self:addChild(self._deleteItem, ZORDER_BAG_GRID_ANIMATION)
    end

    if self._isSelect == false then
        self._isSelect = true

        self._deleteItem:show()
    else
        self._isSelect = false

        self._deleteItem:hide()
    end
    return self._isSelect
end

function GoodsGrid:getIsDelete()
    return self._isSelect
end

-- 关闭删除选中的动画
function GoodsGrid:hideDelete()
    self._isSelect = false

    if (self._deleteItem) then self._deleteItem:setVisible(false) 
    end
end

-- 能否背使用
function GoodsGrid:canUse()
    if (self._data) then
        local goodsType = self._data:getGoodsType()
        if (goodsType == PublicDefine.GOODS_TYPE.GOODS_ITEM) then
            local GameDataManager = require("app.game.GameDataManager")
            local checkInDisableSituation = GameDataManager:getInstance():checkInDisableSituation(self._data:getDisableSituation())
            return not checkInDisableSituation
        end
    end
    return false
end

function GoodsGrid:refreshLock()
    if self._data then
        -- 是否锁定
        local isLock = self._data:getIsLock()
        if (isLock and not self._lockSprite) then
            local isBoat = self._data:getIsBoat()
            self._lockSprite = cc.Sprite:create()
            local image = isBoat and SPRITE_BOAT_ICON_LOCK or SPRITE_ITEM_ICON_LOCK
            self._lockSprite:setSpriteFrame(image)
            self:addChild(self._lockSprite, ZORDER_BAG_GRID_LOCK_FLAG)
        end
        if (self._lockSprite) then
            local isBoat = self._data:getIsBoat()
            local x = isBoat and POSITION_X_LOCK_BOAT or POSITION_X_LOCK
            local y = isBoat and POSITION_Y_LOCK_BOAT or POSITION_Y_LOCK
            self._lockSprite:setPosition(x, y)
            self._lockSprite:setVisible(isLock)
        end
    end
end

-- 更新视图
function GoodsGrid:onUpdateView()
    self._bgSprite:setPosition(self._hw, self._hh)
    if (self._state == GoodsGridState.USED) then
        local data = self._data
        if (data) then
            -- 是否是装备类型
            local isEquimpmentType = (data:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT)
            local isPetEquimpmentType = (data:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT)
            local isStarType = (data:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) or (data:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE)
            local isRelicType = (data:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC)
            local isGlyphType = (data:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH)

            -- 物品图片
            local iconName = data:getIconName()
            if (iconName) then
                self._iconSprite:setSpriteFrame(iconName)
                self._iconSprite:setPosition(self._hw, self._hh)
                self._iconSprite:setVisible(true)
                
                if (DEBUG) then
                    print(string.format("GoodsGrid onUpdateView: icon name is %s.", iconName))
                end
            else
                assert(false)
            end

            if self._data and (self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE 
                or self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
                or self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE
                or self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC
                or self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then 
                if(self._gemLevelText == nil) then 
                    self._gemLevelText = UI.Text:create()
                    self._gemLevelText:init("", UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_254_255_188)
                    self._gemLevelText:leftUp(0, -2)
                    -- self._gemLevelText:setOutline(UI.FONT_COLOR_OUTLINE_20_10_10)
                    self._gemLevelText:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
                    self:addChild(self._gemLevelText, ZORDER_BAG_GRID_ICON + 1)
                end
                self._gemLevelText:setVisible(true)

                if self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE then
                    if(self._data:getNextLVID() == 0) then 
                        self._gemLevelText:setText("Lvmax")
                    else
                        self._gemLevelText:setText(string.format("Lv%d", self._data:getStoneLV()))
                    end

                    
                    if self._data.isEquiped then
                        if not self.gemStoneEquipImg then
                            if self._data.isWear then
                                self.gemStoneEquipImg = UI.Image:create()
                                self.gemStoneEquipImg:init("ui_information_equipment.png")
                                self.gemStoneEquipImg:leftBottom(3,5)
                                self:addChild(self.gemStoneEquipImg, ZORDER_BAG_GRID_STRENGTHEN_LEVEL)
                            else
                                self.gemStoneEquipImg = UI.Image:create()
                                self.gemStoneEquipImg:init("ui_information_notequipped.png")
                                self.gemStoneEquipImg:leftBottom(3,5)
                                self:addChild(self.gemStoneEquipImg, ZORDER_BAG_GRID_STRENGTHEN_LEVEL)
                            end
                        else
                            self.gemStoneEquipImg:show()
                        end
                    else
                        if self.gemStoneEquipImg then
                            self.gemStoneEquipImg:removeFromParent()
                            self.gemStoneEquipImg = nil
                        end
                    end

                    if self._data.viceGemStoneID ~= nil and self._data.viceGemStoneID ~= 0 then
                        if not self.gemStoneLinkImg then
                            self.gemStoneLinkImg = UI.Image:create()
                            self.gemStoneLinkImg:init("ui_information_runelink.png")
                            self.gemStoneLinkImg:rightUp(3,5)
                            self:addChild(self.gemStoneLinkImg, ZORDER_BAG_GRID_STRENGTHEN_LEVEL)
                        else
                            self.gemStoneLinkImg:show()
                        end
                    else
                        if self.gemStoneLinkImg then
                            self.gemStoneLinkImg:removeFromParent()
                            self.gemStoneLinkImg = nil
                        end
                    end

                elseif self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY then
                    if(self._data:isMaxLevel()) then 
                        self._gemLevelText:setText("Lvmax")
                    else
                        self._gemLevelText:setText(string.format("Lv%d", self._data:getLevel()))
                    end
                elseif self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE then
                    if self._data.clientLevel and self._data.clientLevel > 0 then
                        self._gemLevelText:setText(string.format("Lv%d", self._data.clientLevel))
                    else
                        if(self._data:isMaxLevel()) then 
                            self._gemLevelText:setText("Lvmax")
                        else
                            self._gemLevelText:setText(string.format("Lv%d", self._data:getLevel()))
                        end
                    end
                elseif self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC then
                    self._gemLevelText:setText(string.format("Lv%d", self._data:getLevel()))
                elseif self._data:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH then
                    self._gemLevelText:setVisible(false)
                    if self._data.isEquiped then
                        if not self.glyphEquipImg then
                            if self._data.isWear then
                                self.glyphEquipImg = UI.Image:create()
                                self.glyphEquipImg:init("ui_information_equipment.png")
                                self.glyphEquipImg:leftBottom(3,5)
                                self:addChild(self.glyphEquipImg, ZORDER_BAG_GRID_STRENGTHEN_LEVEL)
                            else
                                self.glyphEquipImg = UI.Image:create()
                                self.glyphEquipImg:init("ui_information_notequipped.png")
                                self.glyphEquipImg:leftBottom(3,5)
                                self:addChild(self.glyphEquipImg, ZORDER_BAG_GRID_STRENGTHEN_LEVEL)
                            end
                        else
                            self.glyphEquipImg:show()
                        end
                    else
                        if self.glyphEquipImg then
                            self.glyphEquipImg:removeFromParent()
                            self.glyphEquipImg = nil
                        end
                    end
                end
            else 
                if(not tolua.isnull(self._gemLevelText)) then 
                    self._gemLevelText:setVisible(false)
                end
                if self.gemStoneEquipImg then
                    self.gemStoneEquipImg:removeFromParent()
                    self.gemStoneEquipImg = nil
                end
                if (self.glyphEquipImg) then 
                    self.glyphEquipImg:removeFromParent() 
                    self.glyphEquipImg = nil
                end
                if self.gemStoneLinkImg then
                    self.gemStoneLinkImg:removeFromParent()
                    self.gemStoneLinkImg = nil
                end
            end
            
            -- 稀有度
            if (not self._rareSprite) then
                self._rareSprite = cc.Sprite:create()
                self:addChild(self._rareSprite, ZORDER_BAG_GRID_BG)
                if(self._isGray) then
                    self._rareSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
                end
            end
            local rare = data:getGoodsRare()
            local goodsGroupType = data:getGoodsGroupType()
            local goodsType = data:getGoodsType()

            ---- CO-19899 品质外观升级
            if isEquimpmentType then
                local requireLv = data:getWearLV()
                local maxLevel = tonumber(ConfigManager:getGeneralForKey("heroMaxLevel"))
                if requireLv > maxLevel then
                    rare = rare+6
                end
                -- 混沌虫洞装备特殊处理
                if self._data.createLevel and self._data.createLevel > 0 then
                    rare = self._data.randomGoodsRare + 6
                    -- rare = self._data.randomGoodsRare + 6
                end
            end
            ---------------

            self._rareSprite:setSpriteFrame(string.format(SPRITE_GRID_RARE,goodsGroupType, rare))
            self._rareSprite:setPosition(self._hw, self._hh)
            self._rareSprite:setVisible(self._showRare)

            -- 是否是新物品
            self:showNewIcon()

            -- 是否锁定
            local isLock = data:getIsLock()
            if (isLock and not self._lockSprite) then
                local isBoat = self._data:getIsBoat()
                self._lockSprite = cc.Sprite:create()
                local image = isBoat and SPRITE_BOAT_ICON_LOCK or SPRITE_ITEM_ICON_LOCK
                self._lockSprite:setSpriteFrame(image)
                self:addChild(self._lockSprite, ZORDER_BAG_GRID_LOCK_FLAG)
            end
            if (self._lockSprite) then
                local isBoat = self._data:getIsBoat()
                local x = isBoat and POSITION_X_LOCK_BOAT or POSITION_X_LOCK
                local y = isBoat and POSITION_Y_LOCK_BOAT or POSITION_Y_LOCK
                self._lockSprite:setPosition(x, y)
                self._lockSprite:setVisible(isLock)
            end
            
            -- 物品数量
            local count = data:getNum() + data:getChangeNum() - data:getUseNum()
            if (count > 0 and (not isEquimpmentType) and (not isPetEquimpmentType) and (not isStarType) and (not isRelicType) and (not isGlyphType)) then
                if (not self._countLabel) then
                    self._countLabel = UI.Text:create()
                    self._countLabel:init(
                        string.format("%s", 0), 
                        UI.FONT_BOLD, 
                        UI.FONT_SIZE_14PX, 
                        UI.FONT_COLOR_227_214_172
                    )
                    self._countLabel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
                    -- self._countLabel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
                    -- self._countLabel:setPosition(POSITION_X_COUNT, POSITION_Y_COUNT)
                    self:addChild(self._countLabel, ZORDER_BAG_GRID_COUNT)
                end
                -- if(isNew) then 
                --     self._countLabel:setText(string.format("+%s", count))
                -- else
                    if count >= 100000000 then
                        self._countLabel:setText(string.format("%s", AvalonUtil:getSimpleNumber(count,4)))
                    else
                        self._countLabel:setText(string.format("%s", count))
                    end
                -- end 
                
                self._countLabel:rightBottom(1, -1)

                self._countLabel:setVisible(true)
            else
                if (self._countLabel) then self._countLabel:setVisible(false) end
            end

            -- 设置self._showCountLabel的值强制覆盖上层显示逻辑
            if self._countLabel and not isEquimpmentType and not isPetEquimpmentType and not isStarType and not isRelicType and self._showCountLabel ~= nil then
                self._countLabel:setVisible(self._showCountLabel)
            end

            if(self._strengthenMaxLevel ~= nil) then 
                self._strengthenMaxLevel:setVisible(false)
            end
            -- 装备星级
            if (isEquimpmentType) then
                if not self._txtStrengthenLevel then
                    self._txtStrengthenLevel = UI.Text:create()
                    self._txtStrengthenLevel:init(
                        string.format("%s", 1), 
                        UI.FONT_BOLD, 
                        UI.FONT_SIZE_14PX, 
                        UI.FONT_COLOR_254_255_188
                    )
                    self._txtStrengthenLevel:enableShadow(cc.c4b(0, 0, 0, 255), cc.size(1, -2))
                    -- self._txtStrengthenLevel:setOutline(UI.FONT_COLOR_OUTLINE_56_38_27)
                    self:addChild(self._txtStrengthenLevel, ZORDER_BAG_GRID_STRENGTHEN_LEVEL)
                    self._txtStrengthenLevel:leftUp(0, -2)
                    self._txtStrengthenLevel:setTextLeft()
                end
                self._txtStrengthenLevel:setVisible(true)

                if data.strengthenLevel == 0 then
                    self._txtStrengthenLevel:setText(" ")
                elseif data.strengthenLevel >= data.equipStrengthenMaxLv then
                    self._txtStrengthenLevel:setText(" ")
                    -- self._txtStrengthenLevel:setText(UI.TEXT_110208)
                    -- 修改为效果图
                    if(self._strengthenMaxLevel == nil) then 
                        self._strengthenMaxLevel = UI.Image:create()
                        self._strengthenMaxLevel:init("ui_information_max.png")
                        self._strengthenMaxLevel:leftUp(-2,-5)
                        self:addChild(self._strengthenMaxLevel, ZORDER_BAG_GRID_STRENGTHEN_LEVEL)
                    end
                    self._strengthenMaxLevel:setVisible(true)
                else
                    self._txtStrengthenLevel:setText("+"..data.strengthenLevel)
                end
                self._txtStrengthenLevel:leftUp(0, -2)

                if self.refineContent and (not tolua.isnull(self.refineContent))  then
                    self.refineContent:removeFromParent()
                end
                local layout = UI.Layout:create()
                layout:init()
                layout:enableAutoWidth()
                layout:enableAutoHeight()
                layout:rightBottom(5, 2)
                self:addChild(layout, ZORDER_BAG_GRID_STRENGTHEN_LEVEL)
                self.refineContent = layout
                for i = 1, data.refineNum do
                    local img = UI.Image:create()
                    img:init("ui_information_equip.png")
                    img:floatLeft(5)
                    self.refineContent:addComponent(img)
                end

            else
                if (self._txtStrengthenLevel) then self._txtStrengthenLevel:setVisible(false) end
                if (self._strengthenMaxLevel) then self._strengthenMaxLevel:setVisible(false) end
                if (self.refineContent) then self.refineContent:setVisible(false) end
            end

            -- 是否被选为删除格子
            if (self._isSelect) then
                self._deleteItem:show()
            else
                if (self._deleteItem) then
                    self._deleteItem:hide()
                end
            end

            self:setCascadeOpacityEnabled(true)
        
            -- print("123")
            -- if self._checkItemUseState then
            -- --是否不可用
            --     local isItem = self._data:getGoodsType() == PublicDefine.GOODS_TYPE.GOODS_ITEM
            --     if (isItem and not self:canUse()) then
            --         self:updateDisplayedOpacity(85)
            --     else
            --         self:updateDisplayedOpacity(255)
            --         self:refreshCanUseState()
            --     end
            -- else
            --     self:updateDisplayedOpacity(255)
            --     self:refreshCanUseState()
            -- end
            self:refreshCanUseState()

        else
            assert(false)
        end
    else
        if (self._state == GoodsGridState.LOCK) then
            self._iconSprite:setSpriteFrame(SPRITE_GRID_BG_LOCK)
            self._iconSprite:setVisible(true)
            self._iconSprite:setPosition(self._hw, self._hh)
        else
            self._iconSprite:setVisible(false)
        end

        self:hideNewIcon()
        if (self._lockSprite) then self._lockSprite:setVisible(false) end
        if (self._rareSprite) then self._rareSprite:setVisible(false) end
        if (self._countLabel) then self._countLabel:setVisible(false) end
        if self._data == nil 
        or self._data:getType() ~= PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY
        or self._data:getType() ~= PublicDefine.GOODS_TYPE.GOODS_PET_STONE
        or self._data:getType() ~= PublicDefine.GOODS_TYPE.GOODS_RELIC
        or not self._data:getIsExpType() then
            if (self._gemLevelText) then self._gemLevelText:setVisible(false) end
        end
        if (self.gemStoneEquipImg) then 
            self.gemStoneEquipImg:removeFromParent() 
            self.gemStoneEquipImg = nil
        end
        if self.gemStoneLinkImg then
            self.gemStoneLinkImg:removeFromParent()
            self.gemStoneLinkImg = nil
        end
        if (self._deleteItem) then self._deleteItem:setVisible(false) end
        if (self._choiceStatus) then self._choiceStatus:setVisible(false) end
        if (self._selectItem) then self._selectItem:setVisible(false) end
        if (self._deleteItem) then self._deleteItem:setVisible(false) end
        if (self._txtStrengthenLevel) then self._txtStrengthenLevel:setVisible(false) end
        if (self.refineContent) then self.refineContent:setVisible(false) end
        if (self._strengthenMaxLevel) then self._strengthenMaxLevel:setVisible(false) end
        self:setCascadeOpacityEnabled(true)

        self:refreshCanUseState()
    end
end

function GoodsGrid:refreshCanUseState()
    if self._data == nil then
        local children = self:getChildren()
        if (children) then
            for i = 1, #children do
                children[i]:setOpacity(255)
            end
        end
        return;
    elseif self._data:getUseNum() > 0 and self._data:getNum() - self._data:getUseNum() <= 0 then 
        -- print("-------------GoodsGrid:refreshCanUseState dd", self._data:getUseNum(), self._data:getNum())
        local children = self:getChildren()
        if (children) then
            for i = 1, #children do
                if(self._bgSprite ~= children[i]) then
                    children[i]:setOpacity(0)
                end 
            end
        end
        return;
    end

    if (self._data.canUseState == nil or self._data.canUseState == true ) then
        -- print("GoodsGrid:refreshCanUseState555")
        local children = self:getChildren()
        if (children) then
            for i = 1, #children do
                children[i]:setOpacity(255)
            end
        end

        if(self._showChoiceStatus) then
            if(self._choiceStatus) then 
                self._choiceStatus:setVisible(true)
            end
        end
    else
        if(self._choiceStatus) then 
            self._choiceStatus:setVisible(false)
        end

        -- print("GoodsGrid:refreshCanUseState6666")
        local children = self:getChildren()
        if (children) then
            for i = 1, #children do
                children[i]:setOpacity(85)
            end
        end
    end


end

function GoodsGrid:updateCanUseStateAndDelayRefresh(canUseState, dalayTime)
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end
    self._data.canUseState = canUseState
    self.mSchedulerID = scheduler:scheduleScriptFunc(function()
        self:refreshCanUseState()
    end ,dalayTime, false)
end
--设置道具是否可用
function GoodsGrid:updateCanUseState(canUseState)
    if self.mSchedulerID ~= 0 then
        scheduler:unscheduleScriptEntry(self.mSchedulerID)
    end
    self._data.canUseState = canUseState
    self:refreshCanUseState()
end

function GoodsGrid:setCheckItemUseState(checkItemUseState)
    print("setCheckItemUseState",checkItemUseState)
    self._checkItemUseState = checkItemUseState
    self:refreshCanUseState()
end

--返回道具是否可用状态
function GoodsGrid:getCanUseState()
    return self:calculationUseState(self._data)
    -- if (self._data.canUseState == nil or self._data.canUseState == true ) then
    --     if self._data:getUseNum() > 0 and self._data:getNum() - self._data:getUseNum() <= 0 then
    --         return false
    --     end

    --     return true
    -- else

    --     return false
    -- end
end

function GoodsGrid:calculationUseState(data)
    if (data and data.canUseState == nil or data.canUseState == true ) then
        if data:getUseNum() > 0 and data:getNum() - data:getUseNum() <= 0 then
            return false
        end

        return true
    else

        return false
    end
end

-- isNoGet 是否获得,默认为false   showEquipComp:是否显示装备对比信息，默认为true
function GoodsGrid:showInfoArea(isNoGet, showEquipComp)
    -- print("GoodsGrid:showInfoArea ", isNoGet, showEquipComp)
    self:setInfoArea(isNoGet, showEquipComp)
    self:enableDrage();
    self:addEventListener(UIEvent.COMPONENT_CLICK, self, self.onShowInfoAreaHandler)
end

function GoodsGrid:enableDrage()
    self:setTouchEnable(true)
    self:setInterceptTouches(false)
    self:addEventListener(UIEvent.COMPONENT_DRAG_BEGAN, self, self.onDragBeganByGoodsGrid)
    self:addEventListener(UIEvent.COMPONENT_DRAG_MOVED, self, self.onDragMoveByGoodsGrid)
    self:addEventListener(UIEvent.COMPONENT_DRAG_ENDED, self, self.onDragEndedByGoodsGrid)
    if CONFIG_DOUBLIE_CLICK then
        self:addEventListener(UIEvent.COMPONENT_DOUBLE_CLICK, self, self.onDoubleClickByGoodsGrid)
    end
end

function GoodsGrid:setIsGray()
    self._isGray = true
    if(self._iconSprite) then 
        self._iconSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
    end

    if(self._bgSprite) then 
        self._bgSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
    end

    if(self._rareSprite) then
        self._rareSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_GRAY_SHADER))
    end
end

function GoodsGrid:setNormal()
    self._isGray = false
    if(self._iconSprite) then 
        self._iconSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
    end

    if(self._bgSprite) then 
        self._bgSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
    end

    if(self._rareSprite) then
        self._rareSprite:setGLProgramState(Avalon.WidgetUtil:getShader(UI.COMPONENT_NORMAL_SHADER))
    end
end

function GoodsGrid:setInfoArea(isNoGet, showEquipComp)
    if isNoGet == nil then
        self._isNoGet = false
    else
        self._isNoGet = isNoGet
    end
    if showEquipComp == nil then
        self._showEquipCom = true
    else
        self._showEquipCom = showEquipComp
    end
end

function GoodsGrid:onShowInfoAreaHandler(isHideLink)
    if self._data == nil then
        return
    end
    local goodsData = self._data;
    local pInfoArea = nil;

    if not tolua.isnull(self._infoItem) then 
        self._infoItem:removeFromParent(true)
        self._infoItem = nil
    end

    if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then 
        -- 装备详情
        pInfoArea = UI.EquipmentInfoArea:create()
        if(self._isNoGet == true) then
            pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
            pInfoArea:hideCompInfo()
        else 
            pInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
        end
        -- 处理试穿对比
        if( self._showEquipCom == true) then
            local GameDataManager = require("app.game.GameDataManager")
            local blackTable = GameDataManager:getInstance():tryEquipment(goodsData)
            pInfoArea:updateInfo(blackTable)
        end
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_EQUIPMENT) then 
        pInfoArea = UI.EquipmentPetInfoArea:create()
        if(self._isNoGet == true) then
            pInfoArea:init(UI.EquipImageBgType.NO_GET_TYPE)
            pInfoArea:hideCompInfo()
        else 
            pInfoArea:init(UI.EquipImageBgType.SMALL_TYPE)
        end
        if( self._showEquipCom == true) then
            pInfoArea:updateInfo(goodsData, MasterDataManager:getFightWearEquipmentForEquipmentType(goodsData:getEquipmentType()))
        end
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_ITEM) then 
        -- 道具详情界面
        local itemType = goodsData:getItemType()
        if itemType == PublicDefine.ITEM_TYPE.ChooseBag then
            pInfoArea = UI.SelectGoodsBagInfoArea:create()
        elseif itemType == PublicDefine.ITEM_TYPE.RandomBag then
            pInfoArea = UI.RandomBagInfoArea:create()
        elseif itemType == PublicDefine.ITEM_TYPE.LevelBag then
            pInfoArea = UI.LevelBagInfoArea:create()
            pInfoArea:lockNextLevelBag()
            pInfoArea:disableUse()
        else
            pInfoArea = UI.PropInfoArea:create(self.isHideUseBtn)
        end
        pInfoArea:init(UI.PROP_MATER.PROPINFO)
        
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_MATERIAL or 
    goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_TREASURE) then 
        -- 材料详情界面
        if(goodsData:getMaterialType() ~= PublicDefine.MATERIAL_TYPE.MaterialEquipmentScroll) then
            pInfoArea = UI.PropInfoArea:create(self.isHideUseBtn)
        else 
            pInfoArea = UI.MaterialEquipScrollInfoArea:create()
        end
        pInfoArea:init(UI.PROP_MATER.MATERIALINFO)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_VIRTUALITEM) then 
        -- 虚拟物品详情界面
        if(goodsData:getCanBeView()) then 
            pInfoArea = UI.PropInfoArea:create(self.isHideUseBtn)
            pInfoArea:init(UI.PROP_MATER.VIRTUALITEM_INFO)
        else
            return 
        end
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GEM_STONE) then 
        pInfoArea = UI.GemStoneInfoArea:create()
        pInfoArea:init(goodsData)
        if goodsData.isWear or goodsData.isEquiped then
            pInfoArea:closeLockFlag()
        end
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_STAR_PRAY) then 
        pInfoArea = UI.StarPrayInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_PET_STONE) then 
        pInfoArea = UI.PetStoneInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_RELIC) then
        pInfoArea = UI.RelicInfoArea:create()
        pInfoArea:init(goodsData)
    elseif (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_GLYPH) then
        pInfoArea = UI.GlyphInfoArea:create()
        pInfoArea:init(goodsData)
    else
        return
    end
    pInfoArea:setHideLink(isHideLink)
    local worldPos = self:convertToWorldSpace(cc.p(0,0))

    if worldPos.x < winSize.width/2 then
        pInfoArea:centerLeft(worldPos.x + self:getSize() + 80)
    else
        pInfoArea:centerLeft(worldPos.x - pInfoArea:getSize() - 80)
    end

    pInfoArea:setVisible(true)
    pInfoArea:closeLockFlag()

    pInfoArea:setGoodsGrid(self)
    pInfoArea:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self,obj,touchPosition)
        if not tolua.isnull(obj:getGoodsGrid()) then
            local point  = obj:getGoodsGrid():convertToWorldSpace(cc.p(0,0))
            local rect = cc.rect(point.x , point.y , obj:getGoodsGrid()._width,obj:getGoodsGrid()._height) 

            if cc.rectContainsPoint(rect, touchPosition) then
                obj:setInterceptTouches(false)
            end
        end
        obj:close();
    end)

    UI.UIManager:addToRootNode(pInfoArea,UI_ZORDER.EQUIPMENTINFO)
    pInfoArea:updateView(goodsData)
    self._infoItem = pInfoArea
    Avalon.AudioManager:playSound(self.clickAudioID)
    return pInfoArea
end

-- 显示解锁动画
function GoodsGrid:unlock(callBack)
    self._state = GoodsGridState.EMPTY
    self:updateView()

    local unlockAnimation = UI.Animation:create()
    unlockAnimation:init(FX_EFFECT_UI_UNLOCK_JSON, FX_EFFECT_UI_UNLOCK_ATLAS)
    unlockAnimation:center()
    unlockAnimation:setAnimation("unlock", false)
    unlockAnimation:addEventListener(UIEvent.ANIMATION_COMPLETE, self, function()
        if(callBack) then
            callBack()
        end
        if(not tolua.isnull(self._unlockAnimation)) then 
            self._unlockAnimation:destroy()
            self._unlockAnimation = nil
        end
    end)
    self._unlockAnimation = unlockAnimation
    self:addChild(unlockAnimation, ZORDER_BAG_GRID_ANIMATION)
end

function GoodsGrid:removeUnlockAnimation()
    if(not tolua.isnull(self._unlockAnimation)) then 
        self._unlockAnimation:removeFromParent()
        self._unlockAnimation = nil
    end
end

-- dragBeginCallback 应该有一个返回值用来判断是否可以拖动
function GoodsGrid:setDragBeginCallback(callback)
    self.dragBeginCallback = callback;
end

function GoodsGrid:setDragMoveCallback(callback)
    self.dragMoveCallback = callback
end

function GoodsGrid:setDragEndCallback(callback)
    self.dragEndCallback = callback
end

function GoodsGrid:setDragOutAreaJudgeNode(node)
    self.dragOutAreaJudgeNode = node
end

function GoodsGrid:onDragBeganByGoodsGrid(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end
    
    if self.dragBeginCallback then
        self.mCanDrag = self.dragBeginCallback(self)
        if self.mCanDrag == nil then
            self.mCanDrag = true
        end
    else 
        self.mCanDrag = false
    end
    
    if not self.mCanDrag then
        return
    end

    -- 创建一个克隆的节点，放到最上层来拖动，避免层级之间的遮挡
    if self.dragCloneNode == nil then
        self.dragCloneNode = self:createDraggedView();
        UI.UIManager:addToRootNode(self.dragCloneNode, 100000)
    end
    self.dragCloneNode:hideBG()
    self.dragCloneNode:hideFlagIcon()

    require("app.ui.common.GoodsList.DragFingerAnimation")
    local dragAnimation = UI.DragFingerAnimation:create()
    dragAnimation:init()
    dragAnimation:centerUp(-30)
    self.dragCloneNode:addChild(dragAnimation)
    self._dragAnimation = dragAnimation

    local wPos = self:convertToWorldSpace(self:getAnchorPointInPoints())
    wPos.x = wPos.x - self:getContentSize().width / 2
    self.dragCloneNode:setPosition(wPos)
    self:setVisible(false)
end

function GoodsGrid:onDragMoveByGoodsGrid(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end

    if self.mCanDrag == false then
        return
    end

    if self.dragMoveCallback then
        self.dragMoveCallback(self);
    end

    if(not tolua.isnull(self.dragCloneNode)) then
        local x, y = self.dragCloneNode:getPosition();
        local delta = touch:getDelta();
        self.dragCloneNode:setPosition(cc.p(x + delta.x, y + delta.y))
    end

    if self.dragOutAreaJudgeNode == nil then
        assert(false, "setDragOutAreaJudgeNode() not set")
        return
    end

    if(not tolua.isnull(self._dragAnimation)) then
        local pos = self.dragOutAreaJudgeNode:convertToNodeSpace(touchPosition)
        local size = self.dragOutAreaJudgeNode:getContentSize()
        local rect = cc.rect(0, 0, size.width, size.height)
        local inSide = cc.rectContainsPoint(rect, pos)

        self._dragAnimation:changeInSideStatus(not inSide)
    end
end

function GoodsGrid:onDragEndedByGoodsGrid(grid, touchPosition, touch)
    if (tolua.isnull(self)) then return end

    if (not tolua.isnull(self.dragCloneNode)) then
        self.dragCloneNode:removeFromParent()
        self.dragCloneNode = nil
    end
    self:setVisible(true)

    if(not tolua.isnull(self._dragAnimation)) then
        self._dragAnimation:removeFromParent(true)
        self._dragAnimation = nil
    end

    if self.mCanDrag == false then
        return
    end

    -- 拖动结束时， 必须要有一个父节点来判断是否在某个区域内
    if self.dragOutAreaJudgeNode == nil then
        assert(false, "setDragOutAreaJudgeNode() not set")
        return
    end

    local pos = self.dragOutAreaJudgeNode:convertToNodeSpace(touchPosition)
    local size = self.dragOutAreaJudgeNode:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    local inSide = cc.rectContainsPoint(rect, pos)

    if self.dragEndCallback then
        self.dragEndCallback(self, inSide, touchPosition);
    end
    
    Avalon.AudioManager:playSound("1505")
end

function GoodsGrid:onDoubleClickByGoodsGrid(grid, touchPosition, touch)
    self:onDragEndedByGoodsGrid(grid, cc.p(-10000, -10000))
end

function GoodsGrid:playShakeAct()
    if(self._iconSprite) then 
        AvalonUtil.playShakeAct(self._iconSprite, true)
    end
end

function GoodsGrid:onUseShader(shader)
    if(self._iconSprite) then 
        self._iconSprite:setGLProgramState(shader)
    end

    if(self._bgSprite) then 
        self._bgSprite:setGLProgramState(shader)
    end

    if(self._rareSprite) then
        self._rareSprite:setGLProgramState(shader)
    end
end
