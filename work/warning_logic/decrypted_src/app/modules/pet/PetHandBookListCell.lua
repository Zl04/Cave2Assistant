-- PetHandBookListCell.lua
-- Author:lzm

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
UI = UI or {}

local PetHandBookListCell = class("PetHandBookListCell", UI.ListGrid)

UI.PetHandBookListCell = PetHandBookListCell

local COM_WIDTH = 71
local COM_HEIGHT = 71

local COM_RES_LIST = {
    "ui_common_grid.plist",
    "ui_common_monsterhead.plist",
}

--构造函数(必备)
function PetHandBookListCell:ctor()
    PetHandBookListCell.super.ctor(self, RES_LIST, COM_WIDTH, COM_HEIGHT)
end

--虚构函数,destroy时调用(必备)
function PetHandBookListCell:dtor()
    PetHandBookListCell.super.dtor(self)
end

-- 初始化(必备)
function PetHandBookListCell:init()
    PetHandBookListCell.super.init(self) 
    self:setTouchEnable(true)
    self:setSwallowTouches(false)
end

-- 模版函数：初始化组建的视图(必备)
function PetHandBookListCell:onInitView()
end

function PetHandBookListCell:onUpdateView()
    if not self._data then
        return
    end

    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    local bg = UI.Image:create()
    bg:init("box_quality_box_01.png")
    bg:center()
    self.cellLayout:addChild(bg)

    local petIcon = UI.Image:create() 
    if self._data.showQuestion then
        -- 未拥有则显示问号
        petIcon:init("ui_pets_manual_unkown.png")
    else
        petIcon:init(self._data.icon..".png")
    end
    petIcon:center()
    self.cellLayout:addChild(petIcon)

    if self._data.select then
        self:cellClick()
    else
        self:clearSelect()
    end
end

function PetHandBookListCell:getData()
    return self._data
end

function PetHandBookListCell:cellClick()
    if(self.select == nil) then 
        self.select = UI.Animation:create()
        self.select:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas")
        self.select:center()
        self:addChild(self.select, 100)
    end

    self.select:show()
    self.select:setAnimation("start_square", false)
    self.select:addAnimation("loop_square", true)
end

function PetHandBookListCell:clearSelect()
    self._data.select = false
    if(self.select) then
        self.select:hide()
    end
end

function PetHandBookListCell:isClickShowInfo()
    return true
end