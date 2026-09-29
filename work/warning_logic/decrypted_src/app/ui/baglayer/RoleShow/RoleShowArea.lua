--[[
    UI - 角色展示区域
]]--

require "app.ui.Component"
require "app.ui.baglayer.RoleShow.RoleAnimation"
require "app.ui.baglayer.RoleShow.EquipmentIcon"
require "app.ui.baglayer.RoleShow.SelectEquipmentButton"

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")

UI = UI or {}

local RoleShowArea = class("RoleShowArea", UI.HWBtnComponent)
UI.RoleShowArea = RoleShowArea

-- private:
local DEBUG = false
local DEBUG_DRAW = false

-- 资源列表(必备)
local COM_RES_LIST = {
    "ui_general_title.plist",
}

-- 动画资源
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


-- 星标位置
local ROLE_STAR_LEFT = 120
local ROLE_STAR_UP = 341
-- 动画位置
local ROLE_ANIMATION_UP = 176
local ROLE_ANIMATION_GROUND_UP = 35
-- 装备图标尺寸
local BAG_GRID_WIDTH = 60
local BAG_GRID_HEIGHT = 60
-- z序
local ZORDER_AREA_ACTIVE_ANIMATION = 0
local ZORDER_EQUIPMENT_ICON_ACTIVE_ANIMATION = 2
local ZORDER_EQUIPMENT_ICON_SELECTED_ANIMATION = 3
local ZORDER_ROLE_GROUND_BG = 1
local ZORDER_ROLE_SHADOW_BG = 2
local ZORDER_ROLE_ANIMATION = 4
local ZORDER_EQUIPMENT_ICON = 4
local ZORDER_ROLE_NAME_AND_LEVEL = 5
local ZORDER_ROLE_STAR_LAYOUT = 6
local ZORDER_SELECTED_BUTTON = 100
local ZORDER_TITLE_SELECTOR = 500

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
    [EQUIPMENT_CHEST_INDEX] = SPRITE_EQUIPMENT_CHEST,
    [EQUIPMENT_SHOULDER_INDEX] = SPRITE_EQUIPMENT_SHOULDER,
    [EQUIPMENT_GLOVE_INDEX] = SPRITE_EQUIPMENT_HAND,
    [EQUIPMENT_BOOT_INDEX] = SPRITE_EQUIPMENT_SHOE,
    [EQUIPMENT_AMULET_INDEX] = SPRITE_EQUIPMENT_NECKLACE,
    [EQUIPMENT_RING_INDEX] = SPRITE_EQUIPMENT_RING,
    [EQUIPMENT_WEAPON_INDEX] = SPRITE_EQUIPMENT_WEAPON
}
-- 装备图标坐标
local EQUIPMENT_ICON_BASE_LEFT = 0
local EQUIPMENT_ICON_BASE_UP = 82
local EQUIPMENT_ICON_HORIZONTAL_DISTANCE = 380 ---310
local EQUIPMENT_ICON_VERTICAL_DISTANCE = 84     --100
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
    else
        assert(false)
    end
end

-- 穿戴装备的时候，显示格子被激活
local function activeEquipmentIcon(self, equipmentIcon)
    if (equipmentIcon) then
        -- 继续被激活的装备图标
        self._activeIcon = equipmentIcon
        -- 显示被激活的动画
        local posX, posY = self._activeIcon:getPos()
        
        self._equipmentIconActiveAnimation:play("wear_pos_notice")
        self._equipmentIconActiveAnimation:setVisible(true)
        self._equipmentIconActiveAnimation:setPos(posX, posY)
    else
        assert(false)
    end
end

-- 格子激活被取消
local function deactiveEquipmentIcon(self)
    if (self._activeIcon) then
        -- 清理激活装备的记录
        self._activeIcon = nil
        -- 隐藏激活的动画
        self._equipmentIconActiveAnimation:hide()
    else
        -- assert(false)
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

-- 隐藏装备图标
local function hideEquipmentIcon(self, equipmentIcon)
    if (equipmentIcon) then
        -- 隐藏装备格子
        equipmentIcon:hideEquipmentGrid()
        -- 如果隐藏的图标是激活的图标，隐藏动画
        if (self._activeIcon == equipmentIcon) then
            self._equipmentIconActiveAnimation:hide()
        end
        -- 如果隐藏的图标是选中的图标，隐藏动画
        if (self._selectedIcon == equipmentIcon) then
            self._equipmentIconSelectedAnimation:hide()
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
        local node = self
        local equipmentGrid = UI.GoodsGrid:create()
        equipmentGrid:init(equipmentData)
        equipmentGrid:enableDrage()
        equipmentGrid:setSwallowTouches(false)
        equipmentGrid:setDragOutAreaJudgeNode(self.dragOutSizeJudegNode)
        equipmentGrid:setDragBeginCallback(function(equipmentGrid)
            -- 发送装备拖拽事件
            local rs = node:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_BEGIN, equipmentGrid)
            return rs;
        end);

        equipmentGrid:setDragEndCallback(function(equipmentGrid, inSide, touchPosition)
            -- 发送装备拖拽事件
            print("setDragEndCallback equipmentGrid = ", equipmentGrid)
            self:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_DRAG_ENDED, equipmentGrid, inSide, touchPosition)
        end);

        equipmentIcon:setEquipmentGrid(equipmentGrid)

        equipmentGrid:updateView()
        equipmentGrid:hideNewIcon()
    else
        assert(false)
    end
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
            self:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK, equipmentGrid, equipmentIndex)
        else
            -- 通知点中没有装备的装备图标
            self:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK, nil, 0)
        end
    end)
    self:addChild(equipmentIcon, ZORDER_ROLE_GROUND_BG)

    createEquipmentIconLine(POSITION, equipmentIcon)
    return equipmentIcon
end

-- 构造函数
function RoleShowArea:ctor()
    RoleShowArea.super.ctor(self, UIType.BAG_ROLE_SHOW_AREA, COM_RES_LIST)

    self.dragOutSizeJudegNode = nil
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
    -- -- 整个角色展示区被激活的动画
    -- self._areaActiveAnimation = nil

    self._nameText = nil
    self._levelText = nil
    self._equipmetScore = nil

    Avalon.MessageCenter:bind(AvalonMessage.MC_BATTLE_UPDATE_EQUIPMENT_SCORE, self, self.refreshEquipScore)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_IS_HIDE_HELMET_UPDATE, self, self.showOrHideHelmet)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_TITLE_CHANGE, self, self.heroTitleChange)
end

-- 析构函数
function RoleShowArea:dtor()
    self._heroData = nil
    self._equipmentDataList = nil
    self._equipmentIconList = nil
    self._roleAnimation = nil
    self._selectedIcon = nil
    self._activeIcon = nil
    self._equipmentIconActiveAnimation = nil
    self._equipmentIconSelectedAnimation = nil
    -- self._areaActiveAnimation = nil
    self._nameText = nil
    self._levelText = nil
    self._equipmetScore = nil 

    Avalon.MessageCenter:unbind(AvalonMessage.MC_BATTLE_UPDATE_EQUIPMENT_SCORE, self, self.refreshEquipScore)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_IS_HIDE_HELMET_UPDATE, self, self.showOrHideHelmet)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_TITLE_CHANGE, self, self.heroTitleChange)
    RoleShowArea.super.dtor(self)
end

function RoleShowArea:setDragOutSizeJudegNode(node)
    self.dragOutSizeJudegNode = node
end

function RoleShowArea:refreshEquipScore(equipScore)
    if(self._equipmetScore and not tolua.isnull(self._equipmetScore))  then
        self._equipmetScore:setText(self._equipmetScore:numformat(string.format("%s", equipScore)))
        self._equipmetScore:updateView()

        if(not tolua.isnull(self._equipmentStarIcon) and not tolua.isnull(self._equipmentStarBg)) then 
            local totalWidth = self._equipmentStarBg:getContentSize().width

            local allWidth = self._equipmentStarIcon:getContentSize().width + self._equipmetScore:getContentSize().width + 5
            self._equipmentStarIcon:centerLeft(totalWidth /2 - allWidth/2)
            self._equipmetScore:centerLeft(totalWidth /2 - allWidth/2 + self._equipmentStarIcon:getContentSize().width + 5)
        end

        -- self._equipmentStarIcon:centerLeft()
    end
end

function RoleShowArea:heroTitleChange(titleID, pk, isMaster)
    if (isMaster) then
        self:updateTitle(titleID)
    end
end

-- public:
-- 初始化
function RoleShowArea:init()
    RoleShowArea.super.init(self)
end

-- 初始化视图
function RoleShowArea:onInitView()
    -- 名字等级信息的布局
    -- local nameAndLevelLayout = UI.Layout:create()
    -- nameAndLevelLayout:init()
    -- nameAndLevelLayout:centerUp(12)
    -- nameAndLevelLayout:setSize(294, 76)
    -- self:addChild(nameAndLevelLayout, ZORDER_ROLE_NAME_AND_LEVEL)

    -- 名字
    self._nameText = UI.Text:create()
    self._nameText:init("", UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_155_155_155)
    self._nameText:center(-10, -150)
    self._nameText:setSize(294, 76)
    self:addChild(self._nameText, ZORDER_ROLE_NAME_AND_LEVEL)

    -- 称号排版
    self._titleLayout = UI.Layout:create()
    self._titleLayout:init()
    self._titleLayout:enableAutoWidth()
    self._titleLayout:center(-10, -145)
    self:addChild(self._titleLayout, ZORDER_ROLE_NAME_AND_LEVEL)

    -- 称号
    self._titleText = UI.Text:create()
    self._titleText:init("", UI.SYS_FONT, UI.FONT_SIZE_18PX, UI.FONT_COLOR_155_155_155)
    self._titleText:floatLeft(26)
    self._titleLayout:addComponent(self._titleText)

    -- 称号展示按钮
    local iconLayout = UI.Layout:create()
    iconLayout:init()
    iconLayout:enableAutoHeight()
    iconLayout:enableAutoWidth()
    iconLayout:floatLeft(5)
    self._titleLayout:addComponent(iconLayout)

    local FADE_DURATION = 0.1
    self._showTitleBtn = UI.Button:create()
    self._showTitleBtn:init("ui_title_btn_magnifier_0.png", "ui_title_btn_magnifier_1.png", "ui_title_btn_magnifier_0.png")
    self._showTitleBtn:floatUp(6)
    self._showTitleBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        -- 打开称号选取后隐藏一些组件
        self._titleLayout:hide()
        self._roleAnimation:stopAllActions()
        self._vine:stopAllActions()
        self._tableImage:stopAllActions()
        self._roleStarLayout:stopAllActions()
        self._nameText:stopAllActions()
        self._roleAnimation:runAction(cc.Sequence:create(cc.FadeOut:create(FADE_DURATION), cc.CallFunc:create(function() self._roleAnimation:hide() end)))
        self._vine:runAction(cc.Sequence:create(cc.FadeOut:create(FADE_DURATION), cc.CallFunc:create(function() self._vine:hide() end)))
        self._tableImage:runAction(cc.Sequence:create(cc.FadeOut:create(FADE_DURATION), cc.CallFunc:create(function() self._tableImage:hide() end)))
        self._roleStarLayout:runAction(cc.Sequence:create(cc.FadeOut:create(FADE_DURATION), cc.CallFunc:create(function() self._roleStarLayout:hide() end)))
        self._nameText:runAction(cc.Sequence:create(cc.FadeOut:create(FADE_DURATION), cc.CallFunc:create(function() self._nameText:hide() end)))


        local worldPos = self:convertToWorldSpace(cc.p(220, 380))
        Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_TITLE_SELECTOR, worldPos.x, worldPos.y, function(titleID)
            if(tolua.isnull(self)) then 
                return
            end
            self._titleLayout:show()
            self._roleAnimation:stopAllActions()
            self._vine:stopAllActions()
            self._tableImage:stopAllActions()
            self._roleStarLayout:stopAllActions()
            self._nameText:stopAllActions()

            self._roleAnimation:show()
            self._roleAnimation:setOpacity(0)
            self._roleAnimation:runAction(cc.FadeIn:create(FADE_DURATION))
            self._vine:show()
            self._vine:setOpacity(0)
            self._vine:runAction(cc.FadeIn:create(FADE_DURATION))
            self._tableImage:show()
            self._tableImage:setOpacity(0)
            self._tableImage:runAction(cc.FadeIn:create(FADE_DURATION))
            self._roleStarLayout:show()
            self._roleStarLayout:setOpacity(0)
            self._roleStarLayout:runAction(cc.FadeIn:create(FADE_DURATION))
            self._nameText:show()
            self._nameText:setOpacity(0)
            self._nameText:runAction(cc.FadeIn:create(FADE_DURATION))
            if (self._onCloseTitleSelection) then 
                self._onCloseTitleSelection() 
            end
            
            if (titleID ~= nil and self._lastTitleID ~= titleID) then -- nil为什么都没选
                 Net.NetRoleSystem:requestChangeHeroTitle(titleID)
            end
            self._lastTitleID = titleID
        end)
        if (self._onOpenTitleSelection) then self._onOpenTitleSelection() end
    end)
    iconLayout:addComponent(self._showTitleBtn)

    -- 等级
    local levelBg = UI.Image:create()
    levelBg:init("ui_role_level_bg.png")
    levelBg:leftUp(-30, 30)
    self:addChild(levelBg)

    local levelDesc = UI.Text:create()
    levelDesc:init(UI.TEXT_110046, UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_155_155_155)
    levelDesc:leftUp(-26, 30)
    levelDesc:setTextHorizontalCenter()
    self:addChild(levelDesc)

    self._levelText = UI.Text:create()
    self._levelText:init("", UI.FONT_BOLD, UI.FONT_SIZE_14PX, UI.FONT_COLOR_220_182_80)
    self._levelText:leftUp(levelDesc:getContentSize().width + 2, 0)
    self._levelText:setTextHorizontalCenter()
    levelDesc:addChild(self._levelText)

    -- 星级分数布局
    self._roleStarLayout = UI.Layout:create()
    self._roleStarLayout:init()
    self._roleStarLayout:leftUp(ROLE_STAR_LEFT, ROLE_STAR_UP)
    -- self._roleStarLayout:setSize(100, 32)
    self._roleStarLayout:setSize(198, 29)
    self:addChild(self._roleStarLayout, ZORDER_ROLE_STAR_LAYOUT)

    -- 星级分数图标背景
    -- self._equipmentStarBg = UI.Image9:create()
    -- self._equipmentStarBg:init("ui_scale9image_white.png", CCRectMake(0,0,1,1), cc.size(198, 29))
    -- self._equipmentStarBg:setOpacity(30)
    -- -- self._equipmentStarBg:centerLeft(-75)
    -- self._equipmentStarBg:center()
    -- self._roleStarLayout:addChild(self._equipmentStarBg)

    self._equipmentStarBg = UI.Image:create()
    self._equipmentStarBg:init("ui_information_hero_box_up.png")
    self._equipmentStarBg:center()
    self._roleStarLayout:addChild(self._equipmentStarBg)

    -- 星级分数图标
    self._equipmentStarIcon = UI.Image:create()
    self._equipmentStarIcon:init(SPRITE_EQUIPMENT_LEVEL)
    self._equipmentStarIcon:centerLeft(50)
    self._equipmentStarBg:addChild(self._equipmentStarIcon)

    -- 星级分数文本
    self._equipmetScore = UI.Text:create()
    self._equipmetScore:init("1", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
    self._equipmetScore:leftUp(85, 6)
    self._equipmetScore:addEventListener(UIEvent.COMPONENT_SIZE_CHANGED, self, function(self, text, width, height)

    end)
    self._equipmentStarBg:addChild(self._equipmetScore)

    -- -- 左下骷髅
    -- local skeletonSpine = UI.Animation:create()
    -- skeletonSpine:init("effect_ui_login_createrole_down.json", "effect_ui_login_createrole_down.atlas", 1);
    -- skeletonSpine:leftBottom(34, 24)
    -- skeletonSpine:setAnimation("idle", true)
    -- self:addChild(skeletonSpine)

    -- 背景藤蔓
    self._vine = UI.Animation:create()
    self._vine:init("effect_ui_package_character_tengman_down.json", "effect_ui_package_character_tengman_down.atlas", 1);
    self._vine:leftBottom(224, 31)
    self._vine:setAnimation("idle", true)
    self:addChild(self._vine)

    -- 角色脚下的台子
    self._tableImage = UI.Image:create()
    self._tableImage:init("ui_character_hero_table.png")
    self._tableImage:centerUp(ROLE_ANIMATION_UP + 100)
    self:addChild(self._tableImage)

    -- ROLE_SHOW_AREA_WIDTH = 457,
    -- ROLE_SHOW_AREA_HEIGHT = 416,
    local clipperInnerNode = UI.Layout:create()
    clipperInnerNode:init()
    clipperInnerNode:setSize(457, 416)
    clipperInnerNode:center()

    local clipper = UI.ClippingNode:create()
    clipper:initWithRect(457, 416)
    clipper:addInnerNode(clipperInnerNode)
    clipper:center()
    self:addChild(clipper)
    
    -- 角色动画
    self._roleAnimation = UI.RoleAnimation:create()
    self._roleAnimation:init(self._heroData)
    self._roleAnimation:centerUp(ROLE_ANIMATION_UP)
    clipperInnerNode:addChild(self._roleAnimation, ZORDER_ROLE_ANIMATION)

    -- 装备图标激活的动画
    self._equipmentIconActiveAnimation = UI.Animation:create()
    self._equipmentIconActiveAnimation:init(ANIMATION_EQUIPMENT_SELECTED_SKELETON_FILE, ANIMATION_EQUIPMENT_SELECTED_ATLAS_FILE)
    self._equipmentIconActiveAnimation:setVisible(false)
    self._equipmentIconActiveAnimation:setSize(BAG_GRID_WIDTH, BAG_GRID_HEIGHT)
    self:addChild(self._equipmentIconActiveAnimation, ZORDER_EQUIPMENT_ICON_ACTIVE_ANIMATION)

    -- 装备被选中的动画
    self._equipmentIconSelectedAnimation = UI.Animation:create()
    self._equipmentIconSelectedAnimation:init(ANIMATION_EQUIPMENT_SELECTED_SKELETON_FILE, ANIMATION_EQUIPMENT_SELECTED_ATLAS_FILE)
    self._equipmentIconSelectedAnimation:setVisible(false)
    self._equipmentIconSelectedAnimation:setSize(BAG_GRID_WIDTH, BAG_GRID_HEIGHT)
    self:addChild(self._equipmentIconSelectedAnimation, ZORDER_EQUIPMENT_ICON_SELECTED_ANIMATION)

    -- 创建装备图标
    for index = EQUIPMENT_HELMET_INDEX, EQUIPMENT_WEAPON_INDEX do
        local equipmentIcon = createEquipmentIcon(self, index)
        if (equipmentIcon) then self._equipmentIconList[index] = equipmentIcon
        else assert(false)
        end
    end
end

--
function RoleShowArea:showOrHideHelmet(isHideHelmet)
    print("RoleShowArea:showOrHideHelmet",isHideHelmet)
    if self._roleAnimation then
        if isHideHelmet then
            self._roleAnimation:hideHelmet()
        else
            self._roleAnimation:showHelmet()
        end
    end
end

-- 更新视图
function RoleShowArea:onUpdateView()
    -- 更新装备信息
    local weaponEquipmentData = nil
    if (self._equipmentDataList) then
        for i = 1, #self._equipmentDataList do
            local equipmentData = self._equipmentDataList[i]
            local equipmentPosition = equipmentData:getWearPosition()
            local equipmentType = equipmentData:getEquipmentType()

            -- print(string.format("RoleShowArea onUpdateView: update equipment i:%d position:%d type:%d.", i, equipmentPosition, equipmentType))

            -- 先通过位置获取装备图标
            local equipmentIcon = getEquipmentIconByPosition(self, equipmentPosition)
            -- 如果获取失败，再通过类型获取装备图标
            if (not equipmentIcon) then equipmentIcon = getEquipmentIconByType(self, equipmentType)
            end
            -- 在装备图标上显示装备
            if (equipmentIcon) then addEquipmentToIcon(self, equipmentIcon, equipmentData)
            else assert(false)
            end

            if (equipmentType == EQUIPMENT_TYPE.Weapon) then weaponEquipmentData= equipmentData
            end
        end
    end

    -- 更新角色
    if (self._heroData) then
        self._roleAnimation:setRoleData(self._heroData)
        self._roleAnimation:updateView()

        self._roleAnimation:showIDLEAnimation(weaponEquipmentData)
        
        print("=======更新")
        -- 装备分数
        self:refreshEquipScore(self._heroData:getCombatScore())
        
        local level, reinLv = self._heroData:getUIShowLv()--self._heroData:getLevel() -- string.format(UI.TEXT_DES_LEVEL, self._heroData:getLevel())
        local levelString = self._heroData:getIsReincarntion() and string.format(UI.TEXT_224311, reinLv, level) or level

        local titleID = self._heroData:getHeroTitleID()
        self:updateTitle(titleID)

        self._nameText:setText(self._heroData:getNickName())
        self._nameText:setTextHorizontalCenter()
        self._nameText:updateView()

        self._levelText:setText(levelString)
        -- self._levelText:rightUp(34 - self._levelText:getContentSize().width /2, 40)
        self._levelText:updateView()

        -- self._levelText:hide()

    --    self.decorateLeft:leftUp(150 - self.decorateLeft:getContentSize().width - self._nameText:getContentSize().width/2 - 15, 15)
    --    self.decorateRight:leftUp(150 + self._nameText:getContentSize().width/2 + 10, 15)
        -- self._nameText:enableDebugDraw(UI.YELLOW)
        -- self._levelText:enableDebugDraw(UI.RED)
        
    end
end

-- 更新称号
function RoleShowArea:updateTitle(titleID)
    printInfo("RoleShowArea:updateTitle, 更新称号, ID为: ", titleID)

    require("app.datas.TitleDataManager")
    TitleDataManager:updateDisplayTitle()
    if (TitleDataManager:getDisplayTitleNum() <= 0) then
        self._titleLayout:hide()
        self._showTitleBtn:setTouchEnable(false)
    else
        self._titleLayout:show()
        self._showTitleBtn:setTouchEnable(true)
    end

    if (titleID == 0 or titleID == nil) then
        self._titleText:setText(UI.TEXT_1172019) -- 无称号
        self._titleText:setFontColor(UI.FONT_COLOR_155_155_155)
    else
        -- 获取相应的数据
        local titleData = TitleDataManager:getTitleDataFromID(titleID)
        if (not titleData) then
            printWarn("RoleShowArea:updateTitle, 错误: 称号ID没有对应的数据")
            return
        end

        -- 获得显示信息
        local mentor = mvc.apprenticeshipModel:getMentor()
        if (titleData:getTitleFunctionType() == 51) then
            if (mentor and mentor.nickName) then
                titleData:setParam(mentor.nickName)
                self._titleText:setText("<" .. titleData:getTitleName() .. ">")
                self._titleText:setFontColor(titleData:getTitleColor())
            else
                self._titleText:setText(UI.TEXT_1172019) -- 无称号
                self._titleText:setFontColor(UI.FONT_COLOR_155_155_155)
            end
        else
            self._titleText:setText("<" .. titleData:getTitleName() .. ">")
            self._titleText:setFontColor(titleData:getTitleColor())
        end
    end
    self._titleLayout:onUpdateView()
end

-- 称号选择框打开回调
function RoleShowArea:setOnOpenTitleSelection(callback)
    self._onOpenTitleSelection = callback
end

-- 称号选择框关闭回调
function RoleShowArea:setOnCloseTitleSelection(callback)
    self._onCloseTitleSelection = callback
end

-- 设置角色数据和装备数据
function RoleShowArea:setData(heroData, equipmentDataList)
    assert(type(heroData) == "table", "RoleShowArea setData: hero data is invalid.")
    assert(type(equipmentDataList) == "table" and #equipmentDataList >= 0, "RoleShowArea setData: equipment data is invalid.")

    self._heroData = heroData
    self._equipmentDataList = equipmentDataList
end

-- 更新穿戴的装备
function RoleShowArea:updateWearEquipment(wearEquipmentDataList)
    --print("RoleShowArea:updateWearEquipment", wearEquipmentDataList)
    if (wearEquipmentDataList) then
        -- 清理装备
        getEquipmentIconByPosition(self, EQUIPMENT_HELMET_INDEX):clear()
        getEquipmentIconByPosition(self, EQUIPMENT_CHEST_INDEX):clear()
        getEquipmentIconByPosition(self, EQUIPMENT_SHOULDER_INDEX):clear()
        getEquipmentIconByPosition(self, EQUIPMENT_GLOVE_INDEX):clear()
        getEquipmentIconByPosition(self, EQUIPMENT_BOOT_INDEX):clear()
        getEquipmentIconByPosition(self, EQUIPMENT_AMULET_INDEX):clear()
        getEquipmentIconByPosition(self, EQUIPMENT_RING_INDEX):clear()
        getEquipmentIconByPosition(self, EQUIPMENT_WEAPON_INDEX):clear()

        local weaponEquipmentData = nil
        for i = 1, #wearEquipmentDataList do
            local equipmentData = wearEquipmentDataList[i]
            local equipmentType = equipmentData:getEquipmentType()
            if (equipmentType == EQUIPMENT_TYPE.Weapon) then
                weaponEquipmentData = equipmentData
                -- break
            end

            local position = equipmentData:getWearPosition()
            local equipmentIcon = getEquipmentIconByPosition(self, position)
            addEquipmentToIcon(self, equipmentIcon, equipmentData)
        end

        if (self._roleAnimation) then
            self._roleAnimation:updateRoleEquipment(wearEquipmentDataList)
            self._roleAnimation:showIDLEAnimation(weaponEquipmentData)
        end
        local roleData = RoleDataManager:getMaster()
        -- print("RoleShowArea:updateWearEquipment", roleData:getCombatScore(), roleData.equipScore)
        self:refreshEquipScore(roleData:getCombatScore())
    end
end

-- 显示被激活的图标效果
function RoleShowArea:activeEquipment(goodsData, touchPosition)
    if (goodsData) then
        -- 检查是否可以穿戴
        if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
            local equipmentType = goodsData:getEquipmentType()
            local equipmentIcon = getEquipmentIconByType(self, equipmentType)
            if (equipmentIcon) then activeEquipmentIcon(self, equipmentIcon)
            else assert(false)
            end
        end
    else
        assert(false)
    end
end

-- 恢复被激活的图标
function RoleShowArea:deactiveEquipment()
    deactiveEquipmentIcon(self)
end

-- 添加装备图标
function RoleShowArea:addEquipment(equipmentData)
    -- 是否穿戴上装备
    local isTakeOn = false
    if (equipmentData) then
        if (self._activeIcon and self._activeArea) then
            local position = self._activeIcon:getIndex()
            if (position ~= 0) then
                if (RoleBehaviorManager:equipOrUnEquipCheck()) then 
                    -- 发送穿戴请求
                    local isAvailable = equipmentData:isAvailable(RoleDataManager:getMaster():getLevel())
                    if isAvailable then
                        GameManager:takeOnEquipment(equipmentData, position)
                        -- 添加装备到图标上
                        -- addEquipmentToIcon(self, self._activeIcon, equipmentData)
                        isTakeOn = true
                    end
                end 
            else
                assert(false)
            end
        end
    else
        assert(false)
    end
    return isTakeOn
end

-- 移除装备图标
function RoleShowArea:removeEquipment(equipmentData)
    -- 是否脱下装备
    local isTakeOff = false
    if (equipmentData) then
        local equipmentIcon = getEquipmentIconByData(self, equipmentData)
        if (equipmentIcon) then
            local freePacketNum = GameDataManager:getInstance():getFreePacketBoxNum()
            if(freePacketNum > 0) then
                if (RoleBehaviorManager:equipOrUnEquipCheck()) then 
                    -- 发送脱下装备的请求
                    GameManager:takeOffEquipment(equipmentData)
                    -- 从装备图标上移除装备视图
                    -- equipmentIcon:clear()
                    equipmentData:setUseNum(1)

                    isTakeOff = true
                end 
            else 
                UI.ScrollBar:createByText(LanguageManager:getInstance():getLocalString(1110793))
            end
        else
            assert(false)
        end
    else
        assert(false)
    end
    return isTakeOff
end

-- 显示武器图标
function RoleShowArea:showEquipment(equipmentData)
    if (equipmentData) then
        local equipmentIcon = getEquipmentIconByData(self, equipmentData)
        if (equipmentIcon) then showEquipmentIcon(self, equipmentIcon)
        else assert(false)
        end
    else
        assert(false)
    end
end

-- 隐藏武器图标
function RoleShowArea:hideEquipment(equipmentData)
    if (equipmentData) then
        local equipmentIcon = getEquipmentIconByData(self, equipmentData)
        if (equipmentIcon) then hideEquipmentIcon(self, equipmentIcon)
        else assert(false)
        end
    else
        assert(false)
    end
end

-- 隐藏选中效果
function RoleShowArea:unselectEquipment()
    unselectEquipmentIcon(self)
end

-- 显示角色展示区被激活
function RoleShowArea:activeArea()
    -- 标记角色展示区被激活
    self._activeArea = true
    -- -- 显示激活动画
    -- if (not self._areaActiveAnimation:isVisible()) then
    --     self._areaActiveAnimation:play(ANIMATION_LOOP_NAME)
    --     self._areaActiveAnimation:show()
    -- end
end

-- 取消角色展示区激活
function RoleShowArea:deactiveArea()
    -- 取消标记
    self._activeArea = false
    -- -- 隐藏激活动画
    -- self._areaActiveAnimation:restore()
    -- self._areaActiveAnimation:hide()
end

-- 根据装备类型获取当前穿戴的装备数据列表
function RoleShowArea:getEquipmentData(equipmentType)
    assert(type(equipmentType) == "number", "RoleShowArea getEquipmentData: equipment type is invalid.")

    local equipmentDataList = {}
    local equipmentIcon = getEquipmentIconByType(self, equipmentType)
    if (equipmentIcon) then
        local equipmentData = equipmentIcon:getEquipmentData()
        if (equipmentData) then table.insert(equipmentDataList, equipmentData)
        end
    end
    return equipmentDataList
end

-- 根据选中的装备，进行试穿
function RoleShowArea:tryEquipment(equipmentData)
    assert(type(equipmentData) == "table", "RoleShowArea tryEquipment: equipment data is nil.")

    local equipmentDataList = {}
    table.insert(equipmentDataList, equipmentData)

    -- add by zp 这里由于装备都是一对一的替换，所有这里不需要后续的操作了
    -- local equipmentType = equipmentData:getEquipmentType()
    -- local equipmentIcon = getEquipmentIconByType(self, equipmentType)
    -- if (equipmentIcon) then
    --     for index = EQUIPMENT_HELMET_INDEX, EQUIPMENT_WEAPON_INDEX do
    --         local _equipmentStarIcon = self._equipmentIconList[index]
    --         if (not _equipmentStarIcon:isEmpty() and _equipmentStarIcon ~= equipmentIcon) then
    --             table.insert(equipmentDataList, _equipmentStarIcon:getEquipmentData())
    --         end
    --     end
    -- end
    return equipmentDataList
end

-- 播放开心的动画
function RoleShowArea:showHappyAnimation()
    if (self._roleAnimation) then
        self._roleAnimation:showHappyAnimation()
    end
end

-- function RoleShowArea:visitForScreenshot(hostLayer)
--     local tableImageVisible = self._tableImage:isVisible()
--     local vineVisible = self._vine:isVisible()
--     local nameTextVisible = self._nameText:isVisible()
--     local levelTextVisible = self._levelText:isVisible()
--     local titleLayoutVisible = self._titleLayout:isVisible()
--     local equipmentStarBgVisible = self._equipmentStarBg:isVisible()

--     self._tableImage:hide()
--     self._vine:hide()
--     self._nameText:hide()
--     self._levelText:hide()
--     self._titleLayout:hide()
--     self._equipmentStarBg:hide()
    
--     self:visit()


--     -- 名字需要改颜色, 内存单独渲染名字
--     local pos = self._nameText:convertToWorldSpace(cc.p(0, 0))
--     local nameDummy = UI.Text:create()
--     nameDummy:init("", self._nameText._fontName, self._nameText:getFontSize(), UI.FONT_COLOR_SHARE_EQUIP_NAME)
--     nameDummy:setSize(self._nameText._width, self._nameText._height)
--     nameDummy:setPosition(pos.x, pos.y)
--     nameDummy:setTextHorizontalCenter()
--     nameDummy:setOutline(UI.FONT_COLOR_SHARE_EQUIP_NAME_OUTLINE, 2)
--     nameDummy:setText(self._nameText:getText())
--     nameDummy:retain()
--     nameDummy:visit()

--     -- 工会名称单独创建
--     local guildName = ""
--     require "app.datas.MasterDataManager"
--     local guildData = MasterDataManager:getGuildData()
--     if (guildData) then
--         guildName = guildData:getName()
--     end
--     local nameW, nameH = self._nameText._width, self._nameText._height
--     local pos = self._nameText:convertToWorldSpace(cc.p(0, 0))
--     local guildNameDummy = UI.Text:create()
--     guildNameDummy:init(guildName, UI.SYS_FONT, UI.FONT_SIZE_20PX, UI.FONT_COLOR_SHARE_EQUIP_GUILD)
--     guildNameDummy:setPosition(pos.x + (nameW - guildNameDummy._width) / 2, pos.y + nameH + 2)
--     guildNameDummy:setTextHorizontalCenter()
--     guildNameDummy:retain()
--     hostLayer:addChild(guildNameDummy)
--     guildNameDummy:visit()

--     -- 称号
--     local pos = self._titleText:convertToWorldSpace(cc.p(0, 0))
--     local titleDummy = UI.Text:create()
--     titleDummy:init(self._titleText:getText(), self._titleText._fontName, self._titleText:getFontSize(), UI.FONT_COLOR_SHARE_EQUIP_TITLE)
--     titleDummy:setPosition(pos.x, pos.y - 5)
--     titleDummy:setTextHorizontalCenter()
--     titleDummy:setVisible(titleLayoutVisible)
--     titleDummy:retain()
--     titleDummy:visit()

--     -- 等级需要改颜色, 内存单独渲染名字
--     local pos = self._levelText:convertToWorldSpace(cc.p(0, 0))
--     local lvDummy = UI.Text:create()
--     lvDummy:init("", self._levelText._fontName, self._levelText:getFontSize(), UI.FONT_COLOR_41_41_45)
--     lvDummy:setText(self._levelText:getText())
--     lvDummy:setPosition(pos.x - 16, pos.y)
--     lvDummy:setTextHorizontalCenter()
--     lvDummy:retain()
--     lvDummy:visit()


--     local starYOffset = -31
--     local pos = self._equipmentStarBg:convertToWorldSpace(cc.p(0, 0))
--     starBgDummy = UI.Image9:create()
--     starBgDummy:init("ui_scale9image_black.png", CCRectMake(0,0,1,1), cc.size(198, 29))
--     starBgDummy:setOpacity(150)
--     starBgDummy:setPosition(pos.x, pos.y + starYOffset)
--     starBgDummy:retain()
--     starBgDummy:visit()

--     -- 星级分数图标
--     local pos = self._equipmentStarIcon:convertToWorldSpace(cc.p(0, 0))
--     local starIconDummy = UI.Image:create()
--     starIconDummy:init(SPRITE_EQUIPMENT_LEVEL)
--     starIconDummy:setPosition(pos.x, pos.y + starYOffset)
--     starIconDummy:retain()
--     starIconDummy:visit()

--     -- 星级分数文本
--     local pos = self._equipmetScore:convertToWorldSpace(cc.p(0, 0))
--     scoreDummy = UI.Text:create()
--     scoreDummy:init(self._equipmetScore:getText(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
--     scoreDummy:setPosition(pos.x, pos.y + starYOffset)
--     scoreDummy:retain()
--     scoreDummy:visit()

    
--     -- 打脏一次, 更新坐标, 还原其他组件
--     self:setSize(self._width + 1, self._height + 1)
--     self:setSize(self._width - 1, self._height - 1)
--     self._tableImage:setVisible(tableImageVisible)
--     self._vine:setVisible(vineVisible)
--     self._nameText:setVisible(nameTextVisible)
--     self._levelText:setVisible(levelTextVisible)
--     self._titleLayout:setVisible(titleLayoutVisible)
--     self._equipmentStarBg:setVisible(equipmentStarBgVisible)

--     -- 释放在内存里的代替品
--     Avalon.Scheduler:scheduleUpdateOnce(self, function()
--         lvDummy:release()
--         guildNameDummy:release()
--         nameDummy:release()
--         titleDummy:release()
--         starBgDummy:release()
--         starIconDummy:release()
--         scoreDummy:release()
--     end, 0.01)
-- end



function RoleShowArea:visitForScreenshot(hostLayer)
    local componentHost = UI.Component:create()
    componentHost:init()
    componentHost:setSize(457, 361)
    hostLayer:addChild(componentHost)
    
    -- 名字自动排版
    local nameLayout = UI.Layout:create()
    nameLayout:init()
    nameLayout:enableAutoHeight()
    nameLayout:enableAutoWidth()
    nameLayout:center(220, 0)
    hostLayer:addChild(nameLayout)

    -- 名字和公会排版
    local nameAndGuildLayout = UI.Layout:create()
    nameAndGuildLayout:init(-10, 0, 0, 0)
    nameAndGuildLayout:enableAutoHeight()
    nameAndGuildLayout:enableAutoWidth()
    nameAndGuildLayout:floatUp(0)
    nameLayout:addComponent(nameAndGuildLayout)

    -- 称号
    local titleString = ""
    local heroTitleId = nil
    local masterData = GameDataManager:getMaster()
    if (masterData) then
        heroTitleId = masterData:getHeroTitleID()
    end
    if (heroTitleId and heroTitleId ~= 0) then
        local titleData = TitleDataManager:getTitleDataFromID(heroTitleId)
        if (titleData) then
            local mentor = mvc.apprenticeshipModel:getMentor()
            if (titleData:getTitleFunctionType() == 51 and mentor) then
                titleData:setParam(mentor.nickName)
            end
            titleString = titleData:getTitleName()
        end
    end
    local titleText = UI.Text:create()
    titleText:init(titleString, UI.SYS_FONT, UI.FONT_SIZE_22PX, UI.FONT_COLOR_SHARE_EQUIP_NAME)
    titleText:useDefaultOutLineShadowStyle(UI.FONT_COLOR_OUTLINE_HERO_NAME)
    titleText:floatLeft(10)
    titleText:setVisible(heroTitleId ~= 0)
    nameAndGuildLayout:addComponent(titleText)

    -- 名字
    local nickNameLabel = UI.Text:create()
    nickNameLabel:init(self._nameText:getText(), UI.SYS_FONT, UI.FONT_SIZE_22PX, UI.FONT_COLOR_SHARE_EQUIP_NAME)
    nickNameLabel:useDefaultOutLineShadowStyle(UI.FONT_COLOR_OUTLINE_HERO_NAME)
    nickNameLabel:floatLeft(10)
    nameAndGuildLayout:addComponent(nickNameLabel)

    -- 公会
    local guildNameTextString = ""
    require "app.datas.MasterDataManager"
    local guildData = MasterDataManager:getGuildData()
    if (guildData) then
        guildNameTextString = guildData:getName()
    end
    local guildNameText = UI.Text:create()
    guildNameText:init("<" .. guildNameTextString .. ">", UI.SYS_FONT, UI.FONT_SIZE_22PX, UI.FONT_COLOR_SHARE_EQUIP_NAME)
    guildNameText:useDefaultOutLineShadowStyle(UI.FONT_COLOR_OUTLINE_HERO_NAME)
    guildNameText:floatUp(5)
    nameLayout:addComponent(guildNameText)

    -- 等级
    local levelStr = string.format(UI.TEXT_224316, self._levelText:getText())
    local levelText = UI.Text:create()
    levelText:init(levelStr, UI.FONT_STANDARD, UI.FONT_SIZE_16PX, UI.FONT_COLOR_170_170_170)
    levelText:rightUp(22, 40)
    levelText:setTextHorizontalCenter()
    componentHost:addChild(levelText)

    -- 星级分数布局
    local roleStarLayout = UI.Layout:create()
    roleStarLayout:init()
    roleStarLayout:leftUp(ROLE_STAR_LEFT, 370)
    roleStarLayout:setSize(198, 29)
    componentHost:addChild(roleStarLayout, ZORDER_ROLE_STAR_LAYOUT)

    -- 星级分数背景
    local equipmentStarBg = UI.Image:create()
    equipmentStarBg:init("ui_information_hero_box_up.png")
    equipmentStarBg:center()
    roleStarLayout:addChild(equipmentStarBg)

    -- 星级分数图标
    local equipmentStarIcon = UI.Image:create()
    equipmentStarIcon:init(SPRITE_EQUIPMENT_LEVEL)
    -- equipmentStarIcon:centerLeft(50)
    equipmentStarBg:addChild(equipmentStarIcon)

    -- 星级分数文本
    local equipmetScore = UI.Text:create()
    equipmetScore:init(self._equipmetScore:getText(), UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_250_211_124)
    -- equipmetScore:leftUp(85, 2)
    equipmentStarBg:addChild(equipmetScore)

    local totalWidth = equipmentStarBg:getContentSize().width
    local allWidth = equipmentStarIcon:getContentSize().width + equipmetScore:getContentSize().width + 5
    equipmentStarIcon:centerLeft(totalWidth /2 - allWidth/2)
    equipmetScore:centerLeft(totalWidth /2 - allWidth/2 + equipmentStarIcon:getContentSize().width + 5)
    
    -- 角色动画
    local roleAnimation = UI.RoleAnimation:create()
    roleAnimation:init(self._heroData)
    roleAnimation:centerUp(ROLE_ANIMATION_UP)
    componentHost:addChild(roleAnimation, ZORDER_ROLE_ANIMATION)

    -- 创建装备图标
    local equipmentIconList = {}
    for index = EQUIPMENT_HELMET_INDEX, EQUIPMENT_WEAPON_INDEX do
        local equipmentIcon = createEquipmentIcon(componentHost, index)
        if (equipmentIcon) then equipmentIconList[index] = equipmentIcon
        else assert(false)
        end
    end

    -- 更新装备图标
    local weaponEquipmentData = nil
    if (self._equipmentDataList) then
        for i = 1, #self._equipmentDataList do
            local equipmentData = self._equipmentDataList[i]
            local equipmentPosition = equipmentData:getWearPosition()
            local equipmentType = equipmentData:getEquipmentType()

            -- 先通过位置获取装备图标
            local equipmentIcon = equipmentIconList[equipmentPosition]
            -- 如果获取失败，再通过类型获取装备图标
            if (not equipmentIcon) then equipmentIcon = equipmentIconList[equipmentType] end
            -- 在装备图标上显示装备
            if (equipmentIcon) then addEquipmentToIcon(self, equipmentIcon, equipmentData)
            else assert(false)
            end

            if (equipmentType == EQUIPMENT_TYPE.Weapon) then weaponEquipmentData = equipmentData
            end
        end
    end

    -- 更新角色
    if (weaponEquipmentData) then
        roleAnimation:showIDLEAnimation(weaponEquipmentData)
    end
end