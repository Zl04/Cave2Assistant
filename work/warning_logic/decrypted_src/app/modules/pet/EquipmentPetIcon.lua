--[[
    UI - 宠物装备图标
]]--

require "app.ui.Component"

UI = UI or {}

local EquipmentPetIcon = class("EquipmentPetIcon", UI.HWBtnComponent)
UI.EquipmentPetIcon = EquipmentPetIcon

-- private:
local DEBUG = true
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 60
local COM_HEIGHT = 60
-- 背包资源
local COM_RES_LIST = nil

-- 构造函数
function EquipmentPetIcon:ctor(baseNode)
    EquipmentPetIcon.super.ctor(
        self, 
        UIType.BAG_EQUIPMENT_ICON, 
        COM_RES_LIST, 
        COM_WIDTH, 
        COM_HEIGHT
    )

    self.baseNode = baseNode

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
function EquipmentPetIcon:dtor()
    self._equipmentData = nil
    self._bgSpriteName = nil
    self._bgSprite = nil
    self._grid = nil

    EquipmentPetIcon.super.dtor(self)
    reload_script_file("app.modules.pet.EquipmentPetIcon")
end

-- public:
-- 初始化
function EquipmentPetIcon:init(bgSpriteName, index)
    assert(type(bgSpriteName) == "string", "bg sprite name is invalid.")
    if (index) then assert(type(index) == "number" and index >= 1, "equipment icon index is invalid.") end

    self._index = index
    self._bgSpriteName = bgSpriteName

    EquipmentPetIcon.super.init(self)
end

-- 获取装备索引(装备位置)
function EquipmentPetIcon:getIndex()
    return self._index
end

-- 可用的装备图标
function EquipmentPetIcon:isEmpty()
    return self._grid == nil
end

-- 获取装备数据
function EquipmentPetIcon:getEquipmentData()
    return self._equipmentData 
end

-- 显示装备图标
function EquipmentPetIcon:showEquipmentGrid()
    -- print("EquipmentPetIcon:showEquipmentGrid")
    if (self._grid) then
        self._grid:show()
    end
end

-- 隐藏装备图标
function EquipmentPetIcon:hideEquipmentGrid()
    -- print("EquipmentPetIcon:hideEquipmentGrid")
    if (self._grid) then
        self._grid:hide()
    end
end

-- 初始化视图
function EquipmentPetIcon:onInitView()
    --背景图片
    self._bgSprite = cc.Sprite:create()
    self._bgSprite:setSpriteFrame(self._bgSpriteName)
    self:addChild(self._bgSprite)

    self._grid = UI.GoodsGrid:create()
    self._grid:init(nil)
    self._grid:showInfoArea(true, false)
    self._grid:center()

    self._grid:hideBG()
    self._grid:setSwallowTouches(false)
    self._grid:setDragOutAreaJudgeNode(self.dragOutSizeJudegNode)
    self._grid:setDragBeginCallback(function(equipmentGrid)
        if(self._equipmentData) then
            -- 发送装备拖拽事件
            local rs = self.baseNode:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_BEGIN, equipmentGrid)
            return rs;
        else
            return false
        end
    end);

    self._grid:setDragEndCallback(function(equipmentGrid, inSide, touchPosition)
        -- 发送装备拖拽事件
        if(self._equipmentData) then
            -- print("setDragEndCallback equipmentGrid = ", self._index, equipmentGrid)
            self.baseNode:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_ENDED, equipmentGrid, inSide, touchPosition)
        end
    end);
    self._grid:setScale(0.8)
    self:addChild(self._grid)
    self._grid:hide()
end

function EquipmentPetIcon:setData(data)
    -- print("EquipmentPetIcon:setData", self._index, data)
    -- print(debug.traceback())
    self._equipmentData = data
end

-- 更新视图
function EquipmentPetIcon:onUpdateView()
    self._bgSprite:setPosition(self._hw, self._hh)
    if(self._grid) then
        if(self._equipmentData) then
            self._grid:setData(self._equipmentData)
            self._grid:updateView()
            self._grid:show()
        else
            self._grid:hide()
        end
    end
end

function EquipmentPetIcon:setDragOutSizeJudegNode(node)
    self.dragOutSizeJudegNode = node
end
