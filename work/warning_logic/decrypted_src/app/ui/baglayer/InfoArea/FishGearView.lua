------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/04/08
--desc	: 
------------------------------------------------------------------------------

UI = UI or {}

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local FishGearView = class("FishGearView", UI.HWBtnComponent)

UI.FishGearView = FishGearView

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 500
local COM_HEIGHT = 510

-- 装备图标尺寸
local BAG_GRID_WIDTH = 60
local BAG_GRID_HEIGHT = 60

local FISHING_GEAR_FISH_ROD_INDEX = 9     -- 鱼竿

-- Z序
local ZORDER_EQUIPMENT_ICON_ACTIVE_ANIMATION = 2

-- 动画资源
local ANIMATION_EQUIPMENT_SELECTED_SKELETON_FILE =  "effect_ui_gaming_itemselect.json"

local FISHING_GEAR_LIST = {
    -- 鱼竿
    [FISHING_GEAR_FISH_ROD_INDEX] = {
        EQUIPMENTD_INDEX = 9,
        name = "fishRod",
        icon = "ui_fishing_btn_fishingrod_9.png"
    },
    -- 渔具2
    [10] = {
        isLock = true,
    },
    -- 渔具3
    [11] = {
        isLock = true,
    },
    -- 渔具4
    [12] = {
        isLock = true,
    },

}

function FishGearView:ctor()
    FishGearView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    -- 装备图标激活的动画 
    self._equipmentIconActiveAnimation = nil

    self._equipmentDataList = nil

    self.dragOutSizeJudegNode = nil

    self:bindModel()
end

function FishGearView:init( ... )
    FishGearView.super.init(self, ... )
end

function FishGearView:dtor()
    FishGearView.super.dtor(self)
    -- 装备图标激活的动画 
    self._equipmentIconActiveAnimation = nil

    self._equipmentDataList = nil

    self.dragOutSizeJudegNode = nil

    self:unbindModel()
    reload_script_file("app.ui.baglayer.InfoArea.FishGearView")
end


function FishGearView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- self.contentLayout:enableDebugDraw()
    self.contentLayout:setTouchEnable(true)
    self.contentLayout:setSwallowTouches(true)
    -- self.contentLayout:addTouchEvents()


    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_fishing_bg.png")
    bg:centerUp(0)
    contentLayout:addChild(bg)
    self._bg = bg
 
    -- 标题背景图片
    --  local qr  = UI.Image:create();
    --  qr:init("ui_qq_qr.png");
    --  qr:center(0, 40);
    --  contentLayout:addChild(qr);
 
    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_221600, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleTxt:centerUp(40)
    contentLayout:addChild(titleTxt)

    -- 渔具布局
    local rowLayout = UI.Layout:create()
    rowLayout:init(0, 0, 0, 0)
    rowLayout:enableAutoWidth()
    rowLayout:enableAutoHeight()
    rowLayout:leftUp(40, 160)
    -- rowLayout:enableDebugDraw()
    contentLayout:addChild(rowLayout)
    self.rowLayout = rowLayout

    local closeBtn = UI.Button:create()
    closeBtn:init("ui_btn_yellow6_0.png", "ui_btn_yellow6_1.png", "ui_btn_yellow6_2.png")
    closeBtn:centerBottom(240, 0)
    closeBtn:setText(UI.TEXT_221601)
    closeBtn:setTextFont(UI.FONT_STANDARD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    contentLayout:addChild(closeBtn)
    closeBtn:addEventListener(UIEvent.BUTTON_CLICK, self, function()
        self:closeWin()
    end)

    -- 装备图标激活的动画
    self._equipmentIconActiveAnimation = UI.Animation:create()
    self._equipmentIconActiveAnimation:init(ANIMATION_EQUIPMENT_SELECTED_SKELETON_FILE, ANIMATION_EQUIPMENT_SELECTED_ATLAS_FILE)
    self._equipmentIconActiveAnimation:setVisible(false)
    self._equipmentIconActiveAnimation:setSize(BAG_GRID_WIDTH, BAG_GRID_HEIGHT)
    self.rowLayout:addChild(self._equipmentIconActiveAnimation, 10)

    self:createIconView()
end

function FishGearView:setDragOutSizeJudegNode(node)
    self.dragOutSizeJudegNode = node
end

-- 将装备显示在装备图标上
local function addEquipmentToIcon(self, equipmentIcon, equipmentData)
    if (equipmentIcon and equipmentData) then
        -- equipmentIcon:clear()
        if equipmentIcon:getChildByName("cell"):getChildByName("grid") then 
            equipmentIcon:getChildByName("cell"):removeChildByName("grid")
        end

        -- 创建新的装备格子
        local node = self
        local equipmentGrid = UI.GoodsGrid:create()
        equipmentGrid:init(equipmentData)
        equipmentGrid:enableDrage()
        equipmentGrid:setSwallowTouches(false)
        equipmentGrid:setDragOutAreaJudgeNode(self.contentLayout)
        equipmentGrid:setDragBeginCallback(function(equipmentGrid)
            -- 发送装备拖拽事件
            local rs = node:dispatchEvent(UIEvent.FISH_GEAR_EQUIPMENT_GRID_DRAG_BEGIN, equipmentGrid)
            return rs;
        end);

        equipmentGrid:setDragEndCallback(function(equipmentGrid, inSide, touchPosition)
            -- 发送装备拖拽事件
            print("setDragEndCallback equipmentGrid = ", equipmentGrid, inSide, touchPosition)
            self:dispatchEvent(UIEvent.FISH_GEAR_EQUIPMENT_GRID_DRAG_ENDED, equipmentGrid, inSide, touchPosition)
        end);

        equipmentGrid:setName("grid")
        equipmentGrid:center()
        local cellLayout = equipmentIcon:getChildByName("cell")

        cellLayout:addChild(equipmentGrid)

        equipmentGrid:updateView()
        equipmentGrid:hideNewIcon()

        equipmentGrid:setClickAudioEnable(true)
        equipmentGrid:addEventListener(UIEvent.COMPONENT_CLICK, self, function(self, equipmentGrid, touchPosition)
            -- local equipmentGrid = equipmentIcon:getEquipmentGrid()
            if (equipmentGrid) then
                -- 选中装备图标
                -- selectEquipmentIcon(self, equipmentIcon)
                -- 通知装备图标被点中
                local equipmentIndex = equipmentGrid:getData():getEquipmentType()--equipmentGrid:getIndex()
                self:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK, equipmentGrid, equipmentIndex)
            else
                -- 通知点中没有装备的装备图标
                self:dispatchEvent(UIEvent.ROLE_SHOW_AREA_EQUIPMENT_GRID_CLICK, nil, 0)
            end
        end)
    else
        assert(false)
    end
end

local function getEquipmentIconByType(self, equipmentType)
    return FISHING_GEAR_LIST[equipmentType] and self.rowLayout:getChildByName(FISHING_GEAR_LIST[equipmentType].name)
end

-- 更新视图
function FishGearView:onUpdateView()
    local GameDataManager = require("app.game.GameDataManager")
    local data = GameDataManager:getInstance():getPacketBoxData()
    self._equipmentDataList = data.wearEquipmentArr
    -- 更新装备信息
    local weaponEquipmentData = nil
    if (self._equipmentDataList) then
        for i = 1, #self._equipmentDataList do
            local equipmentData = self._equipmentDataList[i]
            -- local equipmentPosition = equipmentData:getWearPosition()
            local equipmentType = equipmentData:getEquipmentType()

            -- print(string.format("FishGearView onUpdateView: update equipment i:%d position:%d type:%d.", i, equipmentPosition, equipmentType))

            -- 先通过位置获取装备图标
            local equipmentIcon = getEquipmentIconByType(self, equipmentType)

            -- 在装备图标上显示装备
            if (equipmentIcon) then addEquipmentToIcon(self, equipmentIcon, equipmentData)
            else assert(false)
            end

            if (equipmentType == PublicDefine.EQUIPMENT_TYPE.Weapon) then weaponEquipmentData= equipmentData
            end
        end
    end
end

function FishGearView:createIconView()
    for k, v in pairs(FISHING_GEAR_LIST) do
        local icon  = UI.Image:create()
        local imgName = v.isLock and "ui_fishing_box_2.png" or "ui_fishing_box_1.png"
        icon:init(imgName)
        icon:centerLeft(-115+(k-8)*115)
        -- print("v.EQUIPMENTD_INDEX", v.name)
        icon:setName(v.name)
        self.rowLayout:addChild(icon)
        -- local posX, posY = icon:getPosition()
        -- icon:setTag(v.EQUIPMENTD_INDEX)
        if not v.isLock then
            local cellLayout1 = UI.Layout:create()
            cellLayout1:init()
            cellLayout1:setSize(BAG_GRID_WIDTH, BAG_GRID_HEIGHT)
            cellLayout1:center()
            -- cellLayout:enableDebugDraw()
            -- cellLayout:setName("cell")
            icon:addChild(cellLayout1)

            local typeIcon = UI.Image:create()
            typeIcon:init(v.icon)
            typeIcon:center()
            -- typeIcon:setName("cell")
            icon:addChild(typeIcon)

            local cellLayout = UI.Layout:create()
            cellLayout:init()
            cellLayout:setSize(BAG_GRID_WIDTH, BAG_GRID_HEIGHT)
            cellLayout:center()
            -- cellLayout:enableDebugDraw()
            cellLayout:setName("cell")
            icon:addChild(cellLayout)   
        end
    end
end

-- 添加装备图标
function FishGearView:addEquipment(equipmentData)
    -- 是否穿戴上装备
    local isTakeOn = false
    -- self._activeArea = true
    if (equipmentData) then
        if (self._activeIcon and self._activeArea) then
            local equipmentType = equipmentData:getEquipmentType()
            local position = equipmentType--self._activeIcon:getTag()
            if (position ~= 0) then
                if (RoleBehaviorManager:equipOrUnEquipCheck()) then 
                    -- 发送穿戴请求
                    local isAvailable = equipmentData:isAvailable(RoleDataManager:getMaster():getLevel())
                    if isAvailable then
                        -- dump(equipmentData, "equipmentData22323")
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
function FishGearView:removeEquipment(equipmentData)
    -- 是否脱下装备
    local isTakeOff = false
    if (equipmentData) then
        local equipmentIcon = getEquipmentIconByType(self, equipmentData:getEquipmentType())
        if (equipmentIcon) then
            local GameDataManager = require("app.game.GameDataManager")
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

-- 显示角色展示区被激活
function FishGearView:activeArea()
    -- 标记角色展示区被激活
    self._activeArea = true
    -- -- 显示激活动画
    -- if (not self._areaActiveAnimation:isVisible()) then
    --     self._areaActiveAnimation:play(ANIMATION_LOOP_NAME)
    --     self._areaActiveAnimation:show()
    -- end
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

-- 显示被激活的图标效果
function FishGearView:activeEquipment(goodsData, touchPosition)
    if (goodsData) then
        -- 检查是否可以穿戴
        if (goodsData:getType() == PublicDefine.GOODS_TYPE.GOODS_EQUIPMENT) then
            local equipmentType = goodsData:getEquipmentType()
            local equipmentIcon = getEquipmentIconByType(self, equipmentType)
            if (equipmentIcon) then
                 activeEquipmentIcon(self, equipmentIcon)
            else 
                assert(false)
            end
        end
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

-- 恢复被激活的图标
function FishGearView:deactiveEquipment()
    deactiveEquipmentIcon(self)
end



-- 取消角色展示区激活
function FishGearView:deactiveArea()
    -- 取消标记
    self._activeArea = false
    -- -- 隐藏激活动画
    -- self._areaActiveAnimation:restore()
    -- self._areaActiveAnimation:hide()
end

-- 更新穿戴的装备
function FishGearView:updateWearEquipment(wearEquipmentDataList)
    --print("RoleShowArea:updateWearEquipment", wearEquipmentDataList)
    if (wearEquipmentDataList) then
        -- 清理装备
        -- getEquipmentIconByPosition(self, EQUIPMENT_HELMET_INDEX):clear()
        -- getEquipmentIconByPosition(self, EQUIPMENT_CHEST_INDEX):clear()
        -- getEquipmentIconByPosition(self, EQUIPMENT_SHOULDER_INDEX):clear()
        -- getEquipmentIconByPosition(self, EQUIPMENT_GLOVE_INDEX):clear()
        -- getEquipmentIconByPosition(self, EQUIPMENT_BOOT_INDEX):clear()
        -- getEquipmentIconByPosition(self, EQUIPMENT_AMULET_INDEX):clear()
        -- getEquipmentIconByPosition(self, EQUIPMENT_RING_INDEX):clear()
        -- getEquipmentIconByPosition(self, EQUIPMENT_WEAPON_INDEX):clear()

        local weaponEquipmentData = nil
        for i = 1, #wearEquipmentDataList do
            local equipmentData = wearEquipmentDataList[i]
            local equipmentType = equipmentData:getEquipmentType()
            -- if (equipmentType == PublicDefine.EQUIPMENT_TYPE.Weapon) then
            --     weaponEquipmentData = equipmentData
            --     -- break
            -- end

            -- local type = equipmentData:getEquipmentType()
            local equipmentIcon = getEquipmentIconByType(self, equipmentType)
            addEquipmentToIcon(self, equipmentIcon, equipmentData)
        end

        -- if (self._roleAnimation) then
        --     self._roleAnimation:updateRoleEquipment(wearEquipmentDataList)
        --     self._roleAnimation:showIDLEAnimation(weaponEquipmentData)
        -- end
        -- local roleData = RoleDataManager:getMaster()
        -- print("RoleShowArea:updateWearEquipment", roleData:getCombatScore(), roleData.equipScore)
        -- self:refreshEquipScore(roleData:getCombatScore())
    end
end

function FishGearView:closeWin()
    Avalon.MessageCenter:notice(AvalonMessage.MC_CLOSE_FISHING_GEAR_VIEW)
end

function FishGearView:bindModel()
end


function FishGearView:unbindModel()
end





return FishGearView












