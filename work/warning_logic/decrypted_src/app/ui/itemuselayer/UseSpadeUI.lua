--[[
    UI - 铁锹使用ui
]]--

require "app.ui.Component"
local GameDataManager = require("app.game.GameDataManager")
UI = UI or {}

local UseSpadeUI = class("UseSpadeUI", UI.HWBtnComponent)
UI.UseSpadeUI = UseSpadeUI

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

-- 取消使用铁锹的按钮
local SPRITE_CANCEL_BUTTON_NORMAL = "ui_close_button_mattock_0.png"
local SPRITE_CANCEL_BUTTON_ACTIVE = "ui_close_button_mattock_1.png"

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
    UI.UIManager:removeComponent(self)
    if(self._callBackFunc) then 
        self:_callBackFunc(false)
        self._callBackFunc = nil
    end 
end

-- 点击地块
local function onClickMapTileHandler(self, coordX, coordY)
    if (self._coorList) then
        for i = 1, #self._coorList do
            local coord = self._coorList[i]
            if (coord.x == coordX and coord.y == coordY) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_BATTLE_SUCCECD_USE_IRONPICKAXE_CLICK)
                GameManager:useItem(self._data, self._isQuickBar, coordX, coordY)
                -- GameManager:hideMapGrids()
                UI.UIManager:removeComponent(self)

                Avalon.AudioManager:playSound("556")
                if(self._callBackFunc) then 
                    self:_callBackFunc(true)
                    self._callBackFunc = nil
                end 
            end
        end
    end
end

-- 显示可挖的墙
local function showDiggableWall(self)
    local master = GameDataManager:getInstance():getMaster()
    if (master) then
        local useRange = self._data:getUseRange()
        local spriteID = master:getSpriteID()
        local coordList = {}
        if(self._data:hasTargetType(PublicDefine.ESkillTargetType.ESkillTargetType_Ground)) then
            coordList = GameDataManager:getInstance():getDiggleWallCoordList(spriteID, useRange, PublicDefine.ESkillTargetType.ESkillTargetType_Ground)

            local SceneManager = require("app.game.SceneManager")
            if(self:isActItem() and SceneManager:getInstance():isActCave()) then 
                local MachineManager = require("app.game.MachineManager")
                local battleModel = nil
                if (MachineManager:getInstance():getMachine()) then
                    battleModel = MachineManager:getInstance():getMachine():getModel()
                end
                local removeCoord = {}
                if(battleModel) then 
                    local GameMapManager = require("app.game.GameMapManager")
                    if(GameMapManager:getInstance():getMapData()) then 
                        local enterCoord = GameMapManager:getInstance():getMapData():getEnterCoord()
                        if(enterCoord) then 
                            table.insert(removeCoord, enterCoord)
                        end
                    end
                    
                    local trapArr = battleModel:getTrapPointArr()
                    if(trapArr) then
                        for k, trap in pairs(trapArr) do 
                            if trap:getData() and trap:getData():getTransPointType() == PublicDefine.TRANS_POINT_TYPE.TRANS_POINT_ROLE_END then 
                                local coord = trap:getCoord()
                                table.insert(removeCoord, {x = coord.x, y = coord.y})
                            end
                        end
                    end
                end
                if(removeCoord and #removeCoord > 0) then 
                    for k,removeC in ipairs(removeCoord) do 
                        for _,nowCoord in ipairs(coordList) do 
                            if(removeC.x == nowCoord.x and removeC.y == nowCoord.y) then 
                                table.remove(coordList, _)
                                break
                            end
                        end
                    end
                end
            end
        elseif(self._data:hasTargetType(PublicDefine.ESkillTargetType.ESkillTargetType_Wall)) then
            coordList = GameDataManager:getInstance():getDiggleWallCoordList(spriteID, useRange, PublicDefine.ESkillTargetType.ESkillTargetType_Wall)
        end
        -- dump(coordList)
        print("showDiggableWall", useRange, spriteID, #coordList)
        if (coordList and #coordList >= 1) then
            self._coorList = coordList
            GameManager:showMapGrids(coordList)
        end
    else
        assert(false)
    end
end

-- 构造函数
function UseSpadeUI:ctor()
    UseSpadeUI.super.ctor(self, UIType.USE_SPADE_UI, COM_RES_LIST, COM_WIDTH, COM_HEIGHT)

    self._data = nil
    self._coorList = nil

    Avalon.MessageCenter:bind(AvalonMessage.MC_CLICK_MAP_TILE, self, onClickMapTileHandler)
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SHOW_BAG, self, onCancelHandler)
    
    -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_DISABLE_MOVING)
    GameManager:disableMovingHandler()

    Avalon.MessageCenter:notice(GameMessage.MC_UI_DISABLE_ITEM_PANEL)
    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_CLOSE_BAG_BUTTON)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_CLOSE_CONTROL_PAD)
    
end

-- 析构函数
function UseSpadeUI:dtor()
    self._data = nil
    self._coorList = nil

    UseSpadeUI.super.dtor(self)

    Avalon.MessageCenter:unbind(AvalonMessage.MC_CLICK_MAP_TILE, self, onClickMapTileHandler)
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SHOW_BAG, self, onCancelHandler)
    -- Avalon.MessageCenter:notice(AvalonMessage.MC_ROLE_ENABLE_MOVING)
    GameManager:enableMovingHandler(true)
    GameManager:hideMapGrids()

    Avalon.MessageCenter:notice(GameMessage.MC_UI_ENABLE_ITEM_PANEL)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_BAG_BUTTON)
    Avalon.MessageCenter:notice(GameMessage.MC_UI_OPEN_CONTROL_PAD)
end


-- public:
-- 初始化
function UseSpadeUI:init(data, isQuickBar, callBackFunc)
    self._data = data
    self._isQuickBar = isQuickBar
    self._callBackFunc = callBackFunc

    UseSpadeUI.super.init(self)

    showDiggableWall(self)
end

-- 初始化视图
function UseSpadeUI:onInitView()
    local cancelButton = UI.Button:create()
    if(self._data) then 
        if(self._data:getItemType() == PublicDefine.ITEM_TYPE.ItemFunTrap) then 
            cancelButton:init("ui_close_button_trap_0.png", "ui_close_button_trap_1.png")
        elseif self._data:getItemType() == PublicDefine.ITEM_TYPE.ItemFunMark then 
            cancelButton:init("ui_close_button_flag_0.png", "ui_close_button_flag_1.png")
        else 
            cancelButton:init(SPRITE_CANCEL_BUTTON_NORMAL, SPRITE_CANCEL_BUTTON_ACTIVE)
        end
    else
        cancelButton:init(SPRITE_CANCEL_BUTTON_NORMAL, SPRITE_CANCEL_BUTTON_ACTIVE)
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
function UseSpadeUI:onUpdateView()

end


function UseSpadeUI:isActItem()
    if self._data and (self._data:getItemType() == PublicDefine.ITEM_TYPE.ItemFunTrap 
        or self._data:getItemType() == PublicDefine.ITEM_TYPE.ItemFunMark)  then 
        return true
    end

    return false
end