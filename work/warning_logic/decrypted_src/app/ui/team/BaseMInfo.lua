--[[
    AUTHOR:ZIHANCHEN
    2017-5-03
    USING: 查看角色信息的中间区域信息 SPINE动画等
]]--
require "app.ui.Component"
require "app.ui.baglayer.RoleShow.RoleAnimation"
require "app.ui.baglayer.RoleShow.EquipmentIcon"
require "app.ui.baglayer.RoleShow.SelectEquipmentButton"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local BaseMInfo = class("BaseMInfo", UI.HWBtnComponent)
UI.BaseMInfo = BaseMInfo
local RES_LIST = {
    "ui_package_log.plist",
    "ui_package.plist",
    "ui_package_skill.plist",
}
-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 装备被选中的动画资源
local ANIMATION_EQUIPMENT_SELECTED_SKELETON_FILE =  "effect_ui_gaming_itemselect.json"
local ANIMATION_EQUIPMENT_SELECTED_ATLAS_FILE = "effect_ui_gaming_itemselect.atlas"

-- 动画名字
local ANIMATION_LOOP_NAME = "animation"
local ANIMATION_SELECT_NAME_1 = "showup_square"
local ANIMATION_SELECT_NAME_2 = "loop_square"
-- 图片名字
local SPRITE_EQUIPMENT_HEAD = "ui_character_slot_helm.png"
local SPRITE_EQUIPMENT_RING = "ui_character_slot_ring.png"
local SPRITE_EQUIPMENT_NECKLACE = "ui_character_slot_amulet.png"
local SPRITE_EQUIPMENT_WEAPON = "ui_character_slot_weapon.png"
local SPRITE_EQUIPMENT_SHOULDER = "ui_character_slot_scapula.png"
local SPRITE_EQUIPMENT_CHEST = "ui_character_slot_armor.png"
local SPRITE_EQUIPMENT_HAND = "ui_character_slot_globe.png"
local SPRITE_EQUIPMENT_SHOE = "ui_character_slot_boot.png"

local SPRITE_EQUIPMENT_LEVEL = "symbol_character_hero_power.png"

-- 动画位置
local ROLE_ANIMATION_UP = 181
local ROLE_ANIMATION_GROUND_LEFT = -22
local ROLE_ANIMATION_GROUND_UP = 40
local ROLE_ANIMATION_SHADOW_UP = 298
-- 装备图标的位置
local EQUIPMENT_ICON_LEFT = 0
local EQUIPMENT_ICON_RIGHT = 0
local EQUIPMENT_ICON_UP_1 = 40
local EQUIPMENT_ICON_UP_2 = 150
local EQUIPMENT_ICON_UP_3 = 258
local EQUIPMENT_ICON_UP_4 = 368

-- 装备图标尺寸
local BAG_GRID_WIDTH = 60
local BAG_GRID_HEIGHT = 60
-- z序
local ZORDER_AREA_ACTIVE_ANIMATION = 1
local ZORDER_EQUIPMENT_ICON_ACTIVE_ANIMATION = 2
local ZORDER_EQUIPMENT_ICON_SELECTED_ANIMATION = 3
local ZORDER_ROLE_GROUND_BG = 1
local ZORDER_ROLE_SHADOW_BG = 2
local ZORDER_ROLE_ANIMATION = 4
local ZORDER_EQUIPMENT_ICON = 4
local ZORDER_SELECTED_BUTTON = 100

-- 装备类型
local EQUIPMENT_TYPE = PublicDefine.EQUIPMENT_TYPE
-- 装备位置
local EQUIPMENT_HELMET_INDEX = EQUIPMENT_TYPE.Helmet      -- 头盔
local EQUIPMENT_CHEST_INDEX = EQUIPMENT_TYPE.Chest        -- 胸甲
local EQUIPMENT_SHOULDER_INDEX = EQUIPMENT_TYPE.Shoulders -- 肩甲
local EQUIPMENT_GLOVE_INDEX = EQUIPMENT_TYPE.Gloves       -- 手套
local EQUIPMENT_BOOT_INDEX = EQUIPMENT_TYPE.Boots         -- 鞋子    
local EQUIPMENT_AMULET_INDEX = EQUIPMENT_TYPE.Amulet      -- 饰品
local EQUIPMENT_RING_INDEX = EQUIPMENT_TYPE.Ring          -- 戒指
local EQUIPMENT_WEAPON_INDEX = EQUIPMENT_TYPE.Weapon      -- 武器
-- 装备图标背景
local EQUIPMENT_ICON_SPRITE_LIST = {
    [EQUIPMENT_HELMET_INDEX] = SPRITE_EQUIPMENT_HEAD,
    [EQUIPMENT_RING_INDEX] = SPRITE_EQUIPMENT_RING,
    [EQUIPMENT_WEAPON_INDEX] = SPRITE_EQUIPMENT_WEAPON,
    [EQUIPMENT_AMULET_INDEX] = SPRITE_EQUIPMENT_NECKLACE,
    [EQUIPMENT_GLOVE_INDEX] = SPRITE_EQUIPMENT_HAND,
    [EQUIPMENT_SHOULDER_INDEX] = SPRITE_EQUIPMENT_SHOULDER,
    [EQUIPMENT_CHEST_INDEX] = SPRITE_EQUIPMENT_CHEST,
    [EQUIPMENT_BOOT_INDEX] = SPRITE_EQUIPMENT_SHOE,
}
-- 装备图标坐标
local EQUIPMENT_ICON_BASE_LEFT = -195+ 3
local EQUIPMENT_ICON_BASE_UP = 64 - 4
local EQUIPMENT_ICON_HORIZONTAL_DISTANCE = 322 ---310 
local EQUIPMENT_ICON_VERTICAL_DISTANCE = 85     --100
local EQUIPMENT_ICON_POSITION_LIST = {
     -- 头盔
    [EQUIPMENT_HELMET_INDEX] = {
        LEFT = EQUIPMENT_ICON_BASE_LEFT, 
        UP = EQUIPMENT_ICON_BASE_UP,
        SCALE_X = 1,
        SCALE_Y = 1,
    },
     -- 手套
    [EQUIPMENT_GLOVE_INDEX] = {
        LEFT = EQUIPMENT_ICON_BASE_LEFT, 
        UP = EQUIPMENT_ICON_BASE_UP + EQUIPMENT_ICON_VERTICAL_DISTANCE,
        SCALE_X = 1,
        SCALE_Y = 1,
    },
    -- 武器
    [EQUIPMENT_WEAPON_INDEX] = {
        LEFT = EQUIPMENT_ICON_BASE_LEFT, 
        UP = EQUIPMENT_ICON_BASE_UP + EQUIPMENT_ICON_VERTICAL_DISTANCE * 2,
        SCALE_X = 1,
        SCALE_Y = 1,
    },
     -- 戒指
    [EQUIPMENT_RING_INDEX] = {
        LEFT = EQUIPMENT_ICON_BASE_LEFT, 
        UP = EQUIPMENT_ICON_BASE_UP + EQUIPMENT_ICON_VERTICAL_DISTANCE * 3,
        SCALE_X = 1,
        SCALE_Y = -1,
    },
    -- 肩甲
    [EQUIPMENT_SHOULDER_INDEX] = {
        LEFT = EQUIPMENT_ICON_BASE_LEFT + EQUIPMENT_ICON_HORIZONTAL_DISTANCE, 
        UP = EQUIPMENT_ICON_BASE_UP,
        SCALE_X = -1,
        SCALE_Y = 1,
    },

    -- 胸甲
    [EQUIPMENT_CHEST_INDEX] = {
        LEFT = EQUIPMENT_ICON_BASE_LEFT + EQUIPMENT_ICON_HORIZONTAL_DISTANCE, 
        UP = EQUIPMENT_ICON_BASE_UP + EQUIPMENT_ICON_VERTICAL_DISTANCE,
        SCALE_X = -1,
        SCALE_Y = 1,
    },
    -- 鞋子
    [EQUIPMENT_BOOT_INDEX] = {
        LEFT = EQUIPMENT_ICON_BASE_LEFT + EQUIPMENT_ICON_HORIZONTAL_DISTANCE, 
        UP = EQUIPMENT_ICON_BASE_UP + EQUIPMENT_ICON_VERTICAL_DISTANCE * 2,
        SCALE_X = -1,
        SCALE_Y = 1,
    },
    -- 饰品
    [EQUIPMENT_AMULET_INDEX] = {
        LEFT = EQUIPMENT_ICON_BASE_LEFT + EQUIPMENT_ICON_HORIZONTAL_DISTANCE, 
        UP = EQUIPMENT_ICON_BASE_UP + EQUIPMENT_ICON_VERTICAL_DISTANCE * 3,
        SCALE_X = -1,
        SCALE_Y = -1,
    },
}

--有序数组
local EQUIPMENT_ICON_ARRAY = {
    -- 头盔
    EQUIPMENT_HELMET_INDEX, 
    -- 肩甲
    EQUIPMENT_SHOULDER_INDEX,
     -- 手套
    EQUIPMENT_GLOVE_INDEX,
     -- 胸甲
    EQUIPMENT_CHEST_INDEX,
    -- 武器
    EQUIPMENT_WEAPON_INDEX,
     -- 鞋子
    EQUIPMENT_BOOT_INDEX,
     -- 戒指
    EQUIPMENT_RING_INDEX,
    -- 饰品
    EQUIPMENT_AMULET_INDEX,
}
-- 根据装备类型获取装备图标
local function getEquipmentIconByType(self, equipmentType)
    if (self._equipmentDataList) then
        return self._equipmentIconList[equipmentType]
    end
    return nil
end

-- 根据装备位置获取装备图标
local function getEquipmentIconByPosition(self, equipmentPosition)
    if (self._equipmentDataList) then
        return self._equipmentIconList[equipmentPosition]
    end
    return nil
end

-- 根据装备数据获取装备图标
local function getEquipmentIconByData(self, equipmentData)
    for i = EQUIPMENT_HELMET_INDEX, EQUIPMENT_WEAPON_INDEX do
        local equipmentIcon = self._equipmentIconList[i]
        if (equipmentIcon:getEquipmentData() == equipmentData) then
            return equipmentIcon
        end
    end
    return nil
end

-- 根据装备格子对象获取装备图标
local function getEquipmentIconByGrid(self, equipmentGrid)
    for i = EQUIPMENT_HELMET_INDEX, EQUIPMENT_WEAPON_INDEX do
        local equipmentIcon = self._equipmentIconList[i]
        if (equipmentIcon:getEquipmentGrid() == equipmentGrid) then
            return equipmentIcon
        end
    end
    return nil
end

-- 选中装备图标
local function selectEquipmentIcon(self, equipmentIcon)
    if (equipmentIcon) then
        -- 记录选中的装备图标
        self._selectedIcon = equipmentIcon
        -- 显示选中装备图标的动画
        local posX, posY = equipmentIcon:getPos()
        self._equipmentIconSelectedAnimation:setAnimation(ANIMATION_SELECT_NAME_1)
        self._equipmentIconSelectedAnimation:addAnimation(ANIMATION_SELECT_NAME_2)
        self._equipmentIconSelectedAnimation:setPos(posX, posY)
        self._equipmentIconSelectedAnimation:show()
    else
        assert(false)
    end
end

-- 取消选中装备图标
local function unselectEquipmentIcon(self)
    if (self._selectedIcon) then
        -- 清理选中装备图标的记录
        self._selectedIcon = nil
        -- 隐藏选中的动画
        self._equipmentIconSelectedAnimation:hide()
    -- else
    --     assert(false)
    end
end

-- 穿戴装备的时候，显示格子被激活
local function activeEquipmentIcon(self, equipmentIcon)
    if (equipmentIcon) then
        -- 继续被激活的装备图标
        self._activeIcon = equipmentIcon
        -- 显示被激活的动画
        local posX, posY = self._activeIcon:getPos()
        self._equipmentIconActiveAnimation:play(ANIMATION_LOOP_NAME)
        self._equipmentIconActiveAnimation:setVisible(true)
        self._equipmentIconActiveAnimation:setPos(posX, posY)
    else
        assert(false)
    end
end



-- 显示装备图标
local function showEquipmentIcon(self, equipmentIcon)
    if (equipmentIcon) then
        -- 隐藏装备格子
        equipmentIcon:showEquipmentGrid()
        -- 如果隐藏的图标是激活的图标，隐藏动画
        if (self._activeIcon == equipmentIcon) then
            self._equipmentIconActiveAnimation:show()
        end
        -- 如果隐藏的图标是选中的图标，隐藏动画
        if (self._selectedIcon == equipmentIcon) then
            self._equipmentIconSelectedAnimation:show()
        end
    else
        assert(false)
    end
end

-- 将装备显示在装备图标上
local function addEquipmentToIcon(self, equipmentIcon, equipmentData)
    if (equipmentIcon and equipmentData) then
        equipmentIcon:clear()

        -- 创建新的装备格子
        local equipmentGrid = UI.GoodsGrid:create()
        equipmentGrid:init(equipmentData)
        equipmentIcon:setEquipmentGrid(equipmentGrid)
        equipmentGrid:updateView()
        equipmentGrid:hideNewIcon()
    else
        assert(false)
    end
end


--果冻动画
local function playJellyAction(sprite)
    sprite:setScale(0)
    local function generate_action(params)  
        local scale_action = cc.ScaleTo:create(params.time, params.scale_x, params.scale_y, params.scale_z)  
        local fade_action  = cc.FadeIn:create(params.time)  
        return cc.Spawn:create(scale_action, fade_action)      
    end  
    local spawn_action1 = generate_action({time = 0.07, scale_x = 0.63, scale_y = 1.3, scale_z = 1})  
    local spawn_action2 = generate_action({time = 0.12, scale_x = 1.1, scale_y = 0.7, scale_z = 1})  
    local spawn_action3 = generate_action({time = 0.07, scale_x = 0.8, scale_y = 1.1, scale_z = 1})  
    local spawn_action4 = generate_action({time = 0.07, scale_x = 1.1, scale_y = 0.95, scale_z = 1})  
    local spawn_action5 = generate_action({time = 0.07, scale_x = 1, scale_y = 1, scale_z = 1})  
    local seq_actions = cc.Sequence:create(spawn_action1, spawn_action2, spawn_action3  
                                       ,spawn_action4, spawn_action5)
    sprite:runAction(cc.Spawn:create(cc.ScaleTo:create(0.4,1), seq_actions))
    -- sprite:runAction(seq_actions)
end

local function createEquipmentIconLine(pos, icon)

end

-- 创建装备图标
local function createEquipmentIcon(self, index)
    -- 获取配置的数据
    local SPRITE_NAME = EQUIPMENT_ICON_SPRITE_LIST[index]
    local POSITION = EQUIPMENT_ICON_POSITION_LIST[index]

    local equipmentIcon = UI.EquipmentIcon:create()
    equipmentIcon:init(SPRITE_NAME, index)
    equipmentIcon:setTouchEnable(true)
    equipmentIcon:leftUp(POSITION.LEFT, POSITION.UP)
    equipmentIcon:setClickAudioEnable(true)
    equipmentIcon:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, equipmentIcon, touchPosition)
        local equipmentGrid = equipmentIcon:getEquipmentGrid()
        if (equipmentGrid) then
            -- 选中装备图标
            selectEquipmentIcon(self, equipmentIcon)
            -- 通知装备图标被点中
            local equipmentIndex = equipmentIcon:getIndex()
            self:dispatchEvent(UIEvent.ROLE_SHOW_EQUIPMENT_GRID_CLICK, equipmentGrid, equipmentIndex)
        else
            -- 通知点中没有装备的装备图标
            self:dispatchEvent(UIEvent.ROLE_SHOW_EQUIPMENT_GRID_CLICK, nil, 0)
        end
    end)
    self:addChild(equipmentIcon, ZORDER_ROLE_GROUND_BG)
    createEquipmentIconLine(POSITION, equipmentIcon)
    return equipmentIcon
end

-- 构造函数
function BaseMInfo:ctor()
    BaseMInfo.super.ctor(self, UIType.BASE_M_INFO,RES_LIST)
    -- 英雄数据
    self._heroData = nil
    -- 穿戴的装备数据列表
    self._equipmentDataList = nil

    -- 装备图标列表
    self._equipmentIconList = {}
    -- 英雄动画
    self._roleAnimation = nil

    -- 当前被选中的装备图标
    self._selectedIcon = nil
    -- 当前被激活的装备图标（拖拽，穿戴）
    self._activeIcon = nil
    -- 当拖拽坐标进入角色展示区的范围，标记被激活
    self._activeArea = false

    -- 装备图标激活的动画 
    self._equipmentIconActiveAnimation = nil
    -- 装备图标被选中的动画
    self._equipmentIconSelectedAnimation = nil
    -- 整个角色展示区被激活的动画
    self._areaActiveAnimation = nil

    self._nameText = nil
    self._levelText = nil
    self._equipmetScore = nil 
end

-- 析构函数
function BaseMInfo:dtor()
    self._heroData = nil
    self._equipmentDataList = nil
    self._equipmentIconList = nil
    self._roleAnimation = nil
    self._selectedIcon = nil
    self._activeIcon = nil
    self._equipmentIconActiveAnimation = nil
    self._equipmentIconSelectedAnimation = nil
    self._areaActiveAnimation = nil
    self._nameText = nil
    self._levelText = nil
    self._equipmetScore = nil 

    BaseMInfo.super.dtor(self)
end

-- public:
-- 初始化
function BaseMInfo:init()
    BaseMInfo.super.init(self)
end

-- 初始化视图
function BaseMInfo:onInitView()
    -- 装备评价分数
    local scoreBgImage = UI.Image:create()
    scoreBgImage:init("ui_information_hero_box_up.png")
    scoreBgImage:centerUp(305 + 20)
    self:addChild(scoreBgImage, ZORDER_ROLE_ANIMATION + 1)
    --bg

    local equipmetImage = UI.Image:create()
    equipmetImage:init(SPRITE_EQUIPMENT_LEVEL)
    equipmetImage:centerLeft(50)
    scoreBgImage:addChild(equipmetImage)
    self._equipmetImage = equipmetImage

    self._equipmetScore = UI.Text:create()
    self._equipmetScore:init("0", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
    self._equipmetScore:centerLeft(equipmetImage:getContentSize().width + 4)
    equipmetImage:addChild(self._equipmetScore)

    -- 角色动画
    self._roleAnimation = UI.RoleAnimation:create()
    self._roleAnimation:init()
    self._roleAnimation:centerUp(ROLE_ANIMATION_UP)
    self:addChild(self._roleAnimation, ZORDER_ROLE_ANIMATION)
    
    -- 装备被选中的动画
    self._equipmentIconSelectedAnimation = UI.Animation:create()
    self._equipmentIconSelectedAnimation:init(ANIMATION_EQUIPMENT_SELECTED_SKELETON_FILE, ANIMATION_EQUIPMENT_SELECTED_ATLAS_FILE)
    self._equipmentIconSelectedAnimation:setVisible(false)
    self._equipmentIconSelectedAnimation:setSize(BAG_GRID_WIDTH, BAG_GRID_HEIGHT)
    self:addChild(self._equipmentIconSelectedAnimation, ZORDER_EQUIPMENT_ICON_SELECTED_ANIMATION)

    -- 创建装备图标
    for index = EQUIPMENT_HELMET_INDEX, EQUIPMENT_WEAPON_INDEX do
        local equipmentIcon = createEquipmentIcon(self, index)
        if (equipmentIcon) then 
            self._equipmentIconList[index] = equipmentIcon
        else 
            assert(false)
        end
    end
    -- self:playJellyAction(false)
end

-- 更新视图
function BaseMInfo:onUpdateView()
    -- 更新装备信息
    local weaponEquipmentData = nil
    print( "BaseMInfo:onUpdateView" )
    -- dump(self._equipmentDataList)
    if (self._equipmentDataList) then
        for i = 1, #self._equipmentDataList do
            local equipmentData = self._equipmentDataList[i]
            local equipmentPosition = equipmentData:getWearPosition()
            local equipmentType = equipmentData:getEquipmentType()
            print("BaseMInfo:onUpdateView equipmentType-----",equipmentType)
            -- print(string.format("BaseMInfo onUpdateView: update equipment i:%d position:%d type:%d.", i, equipmentPosition, equipmentType))

            -- 先通过位置获取装备图标
            local equipmentIcon = getEquipmentIconByPosition(self, equipmentPosition)
            -- 如果获取失败，再通过类型获取装备图标
            if (not equipmentIcon) then 
               local    equipmentIcon = getEquipmentIconByType(self, equipmentType)
               dump(equipmentIcon)
            end
            -- 在装备图标上显示装备
            if (equipmentIcon) then 
                addEquipmentToIcon(self, equipmentIcon, equipmentData)
                
            else 
                assert(false)
            end

            if (equipmentType == EQUIPMENT_TYPE.Weapon) then weaponEquipmentData= equipmentData
            end
        end
    end

    -- 更新角色
    if (self._heroData) then
        self._roleAnimation:setRoleData(self._heroData)
        self._roleAnimation:updateView()
        self._roleAnimation:updateRoleEquipment(self._equipmentDataList)

        self._roleAnimation:showIDLEAnimation(weaponEquipmentData)

        -- 装备分数
        self._equipmetScore:setText(self._equipmetScore:numformat(string.format("%s",self._heroData:getCombatScore())))
        self._equipmetImage:centerLeft(198/2 - (self._equipmetImage:getContentSize().width + self._equipmetScore:getContentSize().width + 4)/2) 
    end
end

-- 设置角色数据和装备数据
function BaseMInfo:setData(heroData, equipmentDataList)
    assert(type(heroData) == "table", "BaseMInfo setData: hero data is invalid.")
    assert(type(equipmentDataList) == "table" and #equipmentDataList >= 0, "BaseMInfo setData: equipment data is invalid.")

    self._heroData = heroData
    self._equipmentDataList = equipmentDataList
    -- dump(self._equipmentDataList)
end

-- 更新穿戴的装备
function BaseMInfo:updateWearEquipment(wearEquipmentDataList)
    if (wearEquipmentDataList) then
        local weaponEquipmentData = nil
        for i = 1, #wearEquipmentDataList do
            local equipmentData = wearEquipmentDataList[i]
            local equipmentType = equipmentData:getEquipmentType()
            if (equipmentType == EQUIPMENT_TYPE.Weapon) then
                weaponEquipmentData = equipmentData
                break
            end
        end

        if (self._roleAnimation) then
            self._roleAnimation:updateRoleEquipment(wearEquipmentDataList)
            self._roleAnimation:showIDLEAnimation(weaponEquipmentData)
        end
    end
end



-- -- 添加装备图标
-- function BaseMInfo:addEquipment(equipmentData)
--     -- 是否穿戴上装备
--     local isTakeOn = false
--     if (equipmentData) then
--         if (self._activeIcon and self._activeArea) then
--             local position = self._activeIcon:getIndex()
--             if (position ~= 0) then
--                 -- 发送穿戴请求
--                 -- GameManager:takeOnEquipment(equipmentData, position)
--                 -- 添加装备到图标上
--                 addEquipmentToIcon(self, self._activeIcon, equipmentData)

--                 isTakeOn = true
--             else
--                 assert(false)
--             end
--         end
--     else
--         assert(false)
--     end
--     return isTakeOn
-- end


-- 显示武器图标
function BaseMInfo:showEquipment(equipmentData)
    if (equipmentData) then
        local equipmentIcon = getEquipmentIconByData(self, equipmentData)
        if (equipmentIcon) then showEquipmentIcon(self, equipmentIcon)
        else assert(false)
        end
    else
        assert(false)
    end
end



-- 隐藏选中效果
function BaseMInfo:unselectEquipment()
    unselectEquipmentIcon(self)
end

-- 显示角色展示区被激活
function BaseMInfo:activeArea()
    -- 标记角色展示区被激活
    self._activeArea = true
    -- 显示激活动画
    if (not self._areaActiveAnimation:isVisible()) then
        self._areaActiveAnimation:play(ANIMATION_LOOP_NAME)
        self._areaActiveAnimation:show()
    end
end

-- 取消角色展示区激活
function BaseMInfo:deactiveArea()
    -- 取消标记
    self._activeArea = false
    -- 隐藏激活动画
    self._areaActiveAnimation:restore()
    self._areaActiveAnimation:hide()
end

-- 根据装备类型获取当前穿戴的装备数据列表
function BaseMInfo:getEquipmentData(equipmentType)
    assert(type(equipmentType) == "number", "BaseMInfo getEquipmentData: equipment type is invalid.")

    local equipmentDataList = {}
    local equipmentIcon = getEquipmentIconByType(self, equipmentType)
    if (equipmentIcon) then
        local equipmentData = equipmentIcon:getEquipmentData()
        if (equipmentData) then table.insert(equipmentDataList, equipmentData)
        end
    end
    return equipmentDataList
end



-- 播放开心的动画
function BaseMInfo:showHappyAnimation()
    if (self._roleAnimation) then
        self._roleAnimation:showHappyAnimation()
    end
end

function BaseMInfo:playJellyAction(isReverse)
    for k, v in ipairs(EQUIPMENT_ICON_ARRAY) do
        local equipmentIcon = self._equipmentIconList[v] 
        equipmentIcon:setScale(0)
        equipmentIcon:stopAllActions()
    end
    for k, v in ipairs(EQUIPMENT_ICON_ARRAY) do
        local equipmentIcon = self._equipmentIconList[v] 
        local action = cc.Sequence:create(cc.DelayTime:create(0.15 * (k  - 1)), cc.CallFunc:create(function() 
                                           playJellyAction(equipmentIcon)
                                       end))
        equipmentIcon:runAction(action)
    end
end
