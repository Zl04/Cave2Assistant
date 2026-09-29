--[[
    UI - 选择装备按钮
]]--

require "app.ui.Component"

local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local LanguageManager = require "app.game.LanguageManager"

UI = UI or {}

local SelectEquipmentButton = class("SelectEquipmentButton", UI.HWBtnComponent)
UI.SelectEquipmentButton = SelectEquipmentButton

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 尺寸
local COM_WIDTH = 220
local COM_HEIGHT = 65
-- 背包资源
local COM_RES_LIST = nil
-- 图片名字
local SPRITE_INDEX_1_IMAGE_NORMAL = "ui_role_button_suit1_0.png"
local SPRITE_INDEX_1_IMAGE_ACTIVE = "ui_role_button_suit1_1.png"
local SPRITE_INDEX_2_IMAGE_NORMAL = "ui_role_button_suit2_0.png"
local SPRITE_INDEX_2_IMAGE_ACTIVE = "ui_role_button_suit2_1.png"
local SPRITE_INDEX_3_IMAGE_NORMAL = "ui_role_button_suit3_0.png"
local SPRITE_INDEX_3_IMAGE_ACTIVE = "ui_role_button_suit3_1.png"

-- 发送选择事件
local function selectEquipment(self, index)
    Avalon.AudioManager:playSound("1503")
    if (self._selectedIndex ~= index) then
        if (RoleBehaviorManager:equipOrUnEquipCheck()) then 
            local str = string.format(LanguageManager:getInstance():getLocalString(1111215), index)

            local tips = UI.Tips:createTips(str ,UI.TipsType.CONFIRM_AND_CANCEL,UI.TipsUiType.NORMAL)
            tips:addEventListener(UIEvent.DIALOG_CONFIRM,tips, function()
                if not tolua.isnull(self) then
                    self:dispatchEvent(UIEvent.SELECT_EQUIPMENT_INDEX, self._selectedIndex)
                    self:disable()
                end
                -- 处理发送请求切换第几套装备
                GameManager:requestSelectShortcutEquip(index)
            end)

            -- self:dispatchEvent(UIEvent.SELECT_EQUIPMENT_INDEX, self._selectedIndex)
            -- self:disable()
            -- -- 处理发送请求切换第几套装备
            -- GameManager:requestSelectShortcutEquip(index)
        end 
    end
end

-- 构造函数
function SelectEquipmentButton:ctor()
    SelectEquipmentButton.super.ctor(self, UIType.SELECT_EQUIPMENT_BUTTON, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._selectedIndex = 0
    self._canUse = true

    self._bg = nil
    self._index1Image = nil
    self._index2Image = nil
    self._index3Image = nil

    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_SELECT_SHORTCUT_EQUIP_CHANGE, self, self.onSelectShortcutChange)
    Avalon.MessageCenter:bind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_GOODS_SELECT_SHORTCUT_BACK, self, self.onSelectShortcutBack)
end

-- 析构函数
function SelectEquipmentButton:dtor()
    SelectEquipmentButton.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_SELECT_SHORTCUT_EQUIP_CHANGE, self, self.onSelectShortcutChange)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_ROLE_FSMSTATE_CHAGNE, self, self.onUpdateRoleStateHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_GOODS_SELECT_SHORTCUT_BACK, self, self.onSelectShortcutBack)
end

-- public:
-- 初始化
function SelectEquipmentButton:init(selectedIndex)
    self._selectedIndex = selectedIndex or 0
    SelectEquipmentButton.super.init(self)
end

-- 设置选择索引
function SelectEquipmentButton:setIndex(index)
    assert(type(selectedIndex) == "number" and selectedIndex >= 1, "SelectEquipmentButton init: selected index is invalid.")
    self._selectedIndex = index
end

-- 可以用
function SelectEquipmentButton:enable()
    self._canUse = true
    self._index1Image:setTouchEnable(true)
    self._index2Image:setTouchEnable(true)
    self._index3Image:setTouchEnable(true)
end

-- 不可用
function SelectEquipmentButton:disable()
    self._canUse = false
    self._index1Image:setTouchEnable(false)
    self._index2Image:setTouchEnable(false)
    self._index3Image:setTouchEnable(false)
end

-- 初始化视图
function SelectEquipmentButton:onInitView()

    local index1Image = UI.Image:create()
    index1Image:init(SPRITE_INDEX_1_IMAGE_NORMAL)
    index1Image:setSize(68, 59)
    index1Image:centerLeft(0)
    index1Image:setTouchEnable(true)
    index1Image:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self)
        if(self:judgeClickSelect() == false) then
            return 
        end

        if (self._selectedIndex == 1) then return end
        index1Image:setScale(1.25)
        self:showHightLight(1)
    end)
    index1Image:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
        if(self:judgeClickSelect() == false) then
            return 
        end

        if (self._selectedIndex == 1) then return end
        index1Image:setScale(1.0)
        self:hideHightLight(1)

        selectEquipment(self, 1)
        self:updateView()
    end)
    self:addChild(index1Image)
    local index2Image = UI.Image:create()
    index2Image:init(SPRITE_INDEX_2_IMAGE_NORMAL)
    index2Image:setSize(68, 60)
    index2Image:center()
    index2Image:setTouchEnable(true)

    index2Image:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self)
        if(self:judgeClickSelect() == false) then
            return 
        end

        if (self._selectedIndex == 2) then return end
        index2Image:setScale(1.25)
        self:showHightLight(2)
    end)
    index2Image:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
        if(self:judgeClickSelect() == false) then
            return 
        end

        if (self._selectedIndex == 2) then return end
        index2Image:setScale(1.0)
        self:hideHightLight(2)

        selectEquipment(self, 2)
        self:updateView()
    end)
    self:addChild(index2Image)
    local index3Image = UI.Image:create()
    index3Image:init(SPRITE_INDEX_3_IMAGE_NORMAL)
    index3Image:setSize(68, 59)
    index3Image:centerRight(0)
    index3Image:setTouchEnable(true)
    index3Image:addEventListener(UIEvent.COMPONENT_TOUCH_BEGAN, self, function(self)
        if(self:judgeClickSelect() == false) then
            return 
        end

        if (self._selectedIndex == 3) then return end
        self:showHightLight(3)
        index3Image:setScale(1.25)
    end)
    index3Image:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, function(self)
        if(self:judgeClickSelect() == false) then
            return 
        end

        if (self._selectedIndex == 3) then return end
        index3Image:setScale(1.0)
        self:hideHightLight(3)

        selectEquipment(self, 3)
        self:updateView()
    end)
    self:addChild(index3Image)
    self._index1Image = index1Image
    self._index2Image = index2Image
    self._index3Image = index3Image

    if(SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave() or SceneManager:getInstance():isInTrialLand()) then 
        self:disable()
    end

    self:updateView()
end

function SelectEquipmentButton:showHightLight(index)
    if(not GameManager:getIsGooglePlay()) then return end
    if (index == 1) then
        self._index1Image:setSpriteName(SPRITE_INDEX_1_IMAGE_ACTIVE)
        self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_NORMAL)
        self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_NORMAL)
    elseif (index == 2) then
        self._index1Image:setSpriteName(SPRITE_INDEX_1_IMAGE_NORMAL)
        self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_ACTIVE)
        self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_NORMAL)
    elseif (index == 3) then
        self._index1Image:setSpriteName(SPRITE_INDEX_1_IMAGE_NORMAL)
        self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_NORMAL)
        self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_ACTIVE)
    else
        self._index1Image:setSpriteName(SPRITE_INDEX_1_IMAGE_NORMAL)
        self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_NORMAL)
        self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_NORMAL)
    end
end

function SelectEquipmentButton:hideHightLight(index)
    if(not GameManager:getIsGooglePlay()) then return end
    if (index == 1) then
        self._index1Image:setSpriteName(SPRITE_INDEX_2_IMAGE_NORMAL)
    elseif (index == 2) then
        self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_NORMAL)
    elseif (index == 3) then
        self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_NORMAL)
    else
        self._index1Image:setSpriteName(SPRITE_INDEX_1_IMAGE_NORMAL)
        self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_NORMAL)
        self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_NORMAL)
    end
end

-- 更新视图
function SelectEquipmentButton:onUpdateView()
    if (self._selectedIndex >= 0) then
        if (self._selectedIndex == 1) then
            -- self._bg:show()
            -- self._bg:leftUp(0, 0)

            self._index1Image:setSpriteName(SPRITE_INDEX_1_IMAGE_ACTIVE)
            self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_NORMAL)
            self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_NORMAL)
        elseif (self._selectedIndex == 2) then
            -- self._bg:show()
            -- self._bg:centerUp(0)

            self._index1Image:setSpriteName(SPRITE_INDEX_1_IMAGE_NORMAL)
            self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_ACTIVE)
            self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_NORMAL)
        elseif (self._selectedIndex == 3) then
            -- self._bg:show()
            -- self._bg:rightUp(0, 0)

            self._index1Image:setSpriteName(SPRITE_INDEX_1_IMAGE_NORMAL)
            self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_NORMAL)
            self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_ACTIVE)
        else
            -- self._bg:hide()

            self._index1Image:setSpriteName(SPRITE_INDEX_1_IMAGE_NORMAL)
            self._index2Image:setSpriteName(SPRITE_INDEX_2_IMAGE_NORMAL)
            self._index3Image:setSpriteName(SPRITE_INDEX_3_IMAGE_NORMAL)
        end
    else
        assert(false)
    end

    local opacity = 255
    if(self:judgeCanUse()) then
        opacity = 255

        -- self._bg:setTouchEnable(true)
        self._index1Image:setTouchEnable(true)
        self._index2Image:setTouchEnable(true)
        self._index3Image:setTouchEnable(true)
    else
        opacity = 102

        -- self._bg:setTouchEnable(false)
        self._index1Image:setTouchEnable(false)
        self._index2Image:setTouchEnable(false)
        self._index3Image:setTouchEnable(false)
    end

    -- self._bg:setOpacity(opacity)

    self._index1Image:setOpacity(opacity)
    self._index2Image:setOpacity(opacity)
    self._index3Image:setOpacity(opacity)
end

function SelectEquipmentButton:onSelectShortcutChange(index)
    self._selectedIndex = index
    -- self:updateView()
end

function SelectEquipmentButton:onSelectShortcutBack()
    self:enable()
    self:updateView()
end

function SelectEquipmentButton:onUpdateRoleStateHandler(roleData)
    local master =GameDataManager:getInstance():getMaster()
    if(roleData and roleData == master) then
        if(SceneManager:getInstance():isInDungeon() or SceneManager:getInstance():isActCave()) then 
            self:disable()
        else 
            if master and (master:getState() == FSMState.BATTLE or master:getIsDead() == true) then
                self:disable()
            else
                self:enable()
            end
        end 
        self:updateView()
    end
end

function SelectEquipmentButton:judgeCanUse()
    local master = GameDataManager:getInstance():getMaster()
    if master and (master:getState() == FSMState.BATTLE or master:getIsDead() == true or RoleDataManager:getMaster():isHorcruxTransform()) then
       return false
    else
        return self._canUse
    end
end

function SelectEquipmentButton:judgeClickSelect()
    -- TODO 根据逻辑计算是否可以点击选择框
    return self:judgeCanUse()
end