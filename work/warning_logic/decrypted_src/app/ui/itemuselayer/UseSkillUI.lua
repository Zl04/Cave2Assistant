--[[
    UI - 使用辅助技能
]]--

require "app.ui.Component"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local UseSkillUI = class("UseSkillUI", UI.HWBtnComponent)
UI.UseSkillUI = UseSkillUI

-- private:
local DEBUG = false
local DEBUG_DRAW = true

-- 窗口尺寸
local winSize = cc.Director:getInstance():getWinSize()

-- 尺寸
local COM_WIDTH = winSize.width
local COM_HEIGHT = winSize.height
-- 背包资源
local COM_RES_LIST = {
}

-- 图片名字
local SPRITE_ITEM_CANCEL_BG = "ui_btn_gaming_battleskill_01.png"
-- 动画名字
local ANIMATION_CANCEL_SHOW = "showup"
local ANIMATION_CANCEL_LOOP = "loop"
local ANIMATION_CANCEL_TOUCH = "start"
local ANIMATION_CANCEL_FINISH = "end"

-- 取消使用传送的按钮
local SPRITE_CANCEL_TRANSFER_BUTTON_NORMAL = "ui_close_button_mattock_0.png"
local SPRITE_CANCEL_TRANSFER_BUTTON_ACTIVE = "ui_close_button_mattock_1.png"

-- 取消按钮
local CANCEL_BUTTON_RIGHT = 10
local CANCEL_BUTTON_BOTTOM = 10
local CANCEL_BUTTON_WIDTH = 80
local CANCEL_BUTTON_HEIGHT = 80
-- 提示文本
local TIP_TEXT_UP = 100

-- 取消使用
local function onCancelHandler(self, button)
    -- GameManager:hideMapGrids()
    GameManager:enableMovingHandler(true)
    UI.UIManager:removeComponent(self)
end

-- 点击地块
local function onClickMapTileHandler(self, coordX, coordY)
    if (self._coorList) then
        for i = 1, #self._coorList do
            local coord = self._coorList[i]
            if (coord.x == coordX and coord.y == coordY) then
                print("------点击地面成功--")
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SUCCECD_USE_TWICE_SKILL)
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SUCCECD_USE_SKILL)
                GameManager:useAssistSkill(self._data, coordX, coordY)
                -- GameManager:hideMapGrids()
                UI.UIManager:removeComponent(self)

                -- Avalon.AudioManager:playSound("548")
            end
        end
    end
end

-- 显示可挖的墙
local function showMapGrids(self)
    local master = GameDataManager:getInstance():getMaster()
    if (master) then
        local useRange = self._data:getUseRange()
        local spriteID = master:getSpriteID()

        local coordList = GameDataManager:getInstance():getReachableCoordList(spriteID, useRange)
        if (coordList and #coordList >= 1) then
            self._coorList = coordList
            GameManager:showMapGrids(coordList)
        end
    else
        assert(false)
    end
end

-- 构造函数
function UseSkillUI:ctor()
    UseSkillUI.super.ctor(self, UIType.USE_SKILL_UI, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._data = nil

    Avalon.MessageCenter:bind(AvalonMessage.MC_CLICK_MAP_TILE, self, onClickMapTileHandler)
    -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_DISABLE_MOVING)
    GameManager:disableMovingHandler()

    Avalon.MessageCenter:notice(GameMessage.MC_UI_DISABLE_ITEM_PANEL)
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_BAG_BUTTON)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)
end

-- 析构函数
function UseSkillUI:dtor()
    self._data = nil

    UseSkillUI.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_CLICK_MAP_TILE, self, onClickMapTileHandler)
    -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_ENABLE_MOVING)
    GameManager:hideMapGrids()

    Avalon.MessageCenter:notice(GameMessage.MC_UI_ENABLE_ITEM_PANEL)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_BAG_BUTTON)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)
end

-- public:
-- 初始化
function UseSkillUI:init(data)
    self._data = data

    UseSkillUI.super.init(self)

    showMapGrids(self)
end

-- 初始化视图
function UseSkillUI:onInitView()
    local cancelButton = UI.Button:create()

    local category = self._data:getCategory()
    if(category == Category.SKILL) then
        cancelButton:init("ui_close_button_transfer_0.png", "ui_close_button_transfer_1.png")
    else 
        cancelButton:init(SPRITE_CANCEL_TRANSFER_BUTTON_NORMAL, SPRITE_CANCEL_TRANSFER_BUTTON_ACTIVE)
    end
    cancelButton:rightBottom(CANCEL_BUTTON_RIGHT + Avalon.issUtil:getRightMargin(), CANCEL_BUTTON_BOTTOM)
    cancelButton:setSize(CANCEL_BUTTON_WIDTH, CANCEL_BUTTON_HEIGHT)
    cancelButton:addEventListener(UIEvent.BUTTON_CLICK, self, onCancelHandler)
    self:addChild(cancelButton)

    local tipText = UI.Text:create()
    tipText:init(UI.TEXT_DES_USE_SPADE_TIP, UI.FONT_ARIAL, UI.FONT_SIZE_25PX, UI.WHITE)
    tipText:centerUp(TIP_TEXT_UP)
    self:addChild(tipText)

    self:center()
end

-- 更新视图
function UseSkillUI:onUpdateView()

end