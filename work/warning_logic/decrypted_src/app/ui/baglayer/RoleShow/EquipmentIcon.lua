--[[
    UI - 装备图标
]]--

require "app.ui.Component"

UI = UI or {}

local EquipmentIcon = class("EquipmentIcon", UI.HWBtnComponent)
UI.EquipmentIcon = EquipmentIcon

-- private:
local DEBUG = true
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 60
local COM_HEIGHT = 60
-- 背包资源
local COM_RES_LIST = nil
-- 图片装备背景
local SPRITE_EQUIPMENT_BG = "ui_character_box_00.png"

-- 构造函数
function EquipmentIcon:ctor()
    EquipmentIcon.super.ctor(
        self, 
        UIType.BAG_EQUIPMENT_ICON, 
        COM_RES_LIST, 
        COM_WIDTH, 
        COM_HEIGHT
    )

    -- 装备索引（即装备位置）
    self._index = 0
    -- 装备数据
    self._equipmentData = nil
    -- 背景图片名字
    self._bgSpriteName = nil
    -- 背景图片
    self._bgSprite = nil
    -- 装备图标中的装备格子视图
    self._grid = nil
end

-- 析构函数
function EquipmentIcon:dtor()
    self._equipmentData = nil
    self._bgSpriteName = nil
    self._bgSprite = nil
    self._grid = nil

    EquipmentIcon.super.dtor(self)
end

-- public:
-- 初始化
function EquipmentIcon:init(bgSpriteName, index)
    assert(type(bgSpriteName) == "string", "bg sprite name is invalid.")
    if (index) then assert(type(index) == "number" and index >= 1, "equipment icon index is invalid.") end

    self._index = index
    self._bgSpriteName = bgSpriteName

    EquipmentIcon.super.init(self)
end

-- 清理
function EquipmentIcon:clear()
    self._equipmentData = nil
    if (self._grid) then
        self._grid:removeFromParent()
        self._grid = nil
    end
end

-- 获取装备索引(装备位置)
function EquipmentIcon:getIndex()
    return self._index
end

-- 可用的装备图标
function EquipmentIcon:isEmpty()
    return self._grid == nil
end

-- 获取装备格子
function EquipmentIcon:getEquipmentGrid()
    return self._grid
end

-- 获取装备数据
function EquipmentIcon:getEquipmentData()
    return self._equipmentData 
end

-- 添加装备图标
function EquipmentIcon:setEquipmentGrid(equipmentGrid)
    if (equipmentGrid) then
        if (self._grid) then
            self._grid:removeFromParent()
            self._grid = nil
        end

        self._equipmentData = equipmentGrid:getData()
        self._grid = equipmentGrid
        self._grid:center()

        self:addChild(equipmentGrid)
    else
        assert(false)
    end
end

-- 显示装备图标
function EquipmentIcon:showEquipmentGrid()
    if (self._grid) then
        self._grid:show()
    end
end

-- 隐藏装备图标
function EquipmentIcon:hideEquipmentGrid()
    if (self._grid) then
        self._grid:hide()
    end
end

-- 初始化视图
function EquipmentIcon:onInitView()
    --背景图片
    local bgImage = UI.Image:create()
    bgImage:init(SPRITE_EQUIPMENT_BG)
    bgImage:center()
    self:addChild(bgImage)

    self._bgSprite = cc.Sprite:create()
    self._bgSprite:setSpriteFrame(self._bgSpriteName)
    self:addChild(self._bgSprite)
end

-- 更新视图
function EquipmentIcon:onUpdateView(data)
    self._bgSprite:setPosition(self._hw, self._hh)    
end
