-- PetTrainSkillBookCell.lua
-- Author:lzm

local LanguageManager = require "app.game.LanguageManager"
local GameDataManager = require("app.game.GameDataManager")
local SceneManager = require("app.game.SceneManager")
local GameMapManager = require("app.game.GameMapManager")
local MachineManager = require("app.game.MachineManager")
UI = UI or {}

local PetTrainSkillBookCell = class("PetTrainSkillBookCell", UI.ListGrid)

UI.PetTrainSkillBookCell = PetTrainSkillBookCell

local COM_WIDTH = 76
local COM_HEIGHT = 76

local COM_RES_LIST = {
    "ui_common_grid.plist",
}
--构造函数(必备)
function PetTrainSkillBookCell:ctor()
    PetTrainSkillBookCell.super.ctor(self)
end

--虚构函数,destroy时调用(必备)
function PetTrainSkillBookCell:dtor()
    PetTrainSkillBookCell.super.dtor(self)
end

-- 初始化(必备)
function PetTrainSkillBookCell:init()
    PetTrainSkillBookCell.super.init(self)
    self:setTouchEnable(true)
    self:setSwallowTouches(false)
end

-- 模版函数：初始化组建的视图(必备)
function PetTrainSkillBookCell:onInitView()
end

function PetTrainSkillBookCell:onUpdateView()
    if not self._data then
        return
    end

    local cellLayout = UI.Layout:create()
    cellLayout:init()
    cellLayout:setSize(COM_WIDTH, COM_HEIGHT)
    cellLayout:center()
    self.cellLayout = cellLayout
    self:addChild(cellLayout)

    local gridBg = UI.Image:create()
    gridBg:init("box_quality_box_01.png")
    gridBg:center()
    self.cellLayout:addChild(gridBg)

    if self._data.emptySlot then
        self.goodsData = {}
        self.goodsData.emptySlot = true
        return
    end

    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:center()
    local goodsData = GoodsDataManager:createLocalGoodsData(self._data:getId())
    goodsData:setNum(self._data:getNum())
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsGrid:init(goodsData)
    goodsGrid:setInfoArea(false, false)
    gridBg:addChild(goodsGrid)
    self.goodsData = goodsData

    local select  = UI.Animation:create()
    select:init("effect_ui_gaming_itemselect.json",  "effect_ui_gaming_itemselect.atlas")
    select:center()
    select:hide()
    gridBg:addChild(select, 10)
    self.select = select
end

function PetTrainSkillBookCell:getData()
    return self.goodsData
end

function PetTrainSkillBookCell:cellClick()
    if not self.select then
        self.select = UI.Animation:create()
        self.select:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas")
        self.select:center()
        self.cellLayout:addChild(self.select, 0)
    end

    self.select:show()
    self.select:setAnimation("start_square", false)
    self.select:addAnimation("loop_square", true)
end

function PetTrainSkillBookCell:isClickShowInfo()
    return true
end

function PetTrainSkillBookCell:clearSelect()
    if not self.select then
        return
    end

    self.select:setAnimation("end_square", false)
end
