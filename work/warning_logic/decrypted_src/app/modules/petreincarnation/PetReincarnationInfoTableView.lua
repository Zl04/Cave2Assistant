------------------------------------------------------------------------------
--author: siyu.lin
--date  : 2023/03/09
--desc  : 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetReincarnationInfoTableView = class("PetReincarnationInfoTableView", UI.HWBtnComponent)

require "app.modules.petreincarnation.PetReincarnationInfoTableCell"

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 384
local COM_HEIGHT = 360
--local COM_HEIGHT = 178

local GRID_WIDTH = 90
local GRID_HEIGHT = 90

UI = UI or {}

UI.PetReincarnationInfoTableView = PetReincarnationInfoTableView

function PetReincarnationInfoTableView:ctor()
    PetReincarnationInfoTableView.super.ctor(
        self,
        UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()
end

function PetReincarnationInfoTableView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.petreincarnation", "PetReincarnation", false)
    PetReincarnationInfoTableView.super.init(self, ... )

    self.infoData = {}

    --能否拖拽
    self._canDrag = true

    -- ...为传入的table
    local list = ...
    self.verticalNum = list.verticalNum
    self.horizontalNum = list.horizontalNum
end

function PetReincarnationInfoTableView:dtor()
    PetReincarnationInfoTableView.super.dtor(self)
    self:unbindModel()
    --reload_script_file_mvc("app.modules.petreincarnation.PetReincarnationInfoTableView")
end


function PetReincarnationInfoTableView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout, 1)
    self.contentLayout = contentLayout
    
end

function PetReincarnationInfoTableView:skillListInit()
    -- 技能书列表
    local gridListWidth = 480
    local gridListHeight = 200
    local gridList = UI.GridList:create()
    gridList:init(UI.PetReincarnationInfoTableCell, self.verticalNum, self.horizontalNum, 480, 36, 0, 0, 0)
    gridList:setSize(gridListWidth, gridListHeight)
    gridList:leftBottom(-30, -300)
    gridList:disableToDragGrid()
    gridList:setCallbackForGridClick(self, self.cellClickCallback)
    gridList:setScrollBarEnabled(true)
    gridList:setCircleVisible(false)
    self.bookList = gridList
    self.contentLayout:addChild(self.bookList)
    self.bookList:setData(self.infoData)

    if (GRID_HEIGHT - 36) * self.horizontalNum < gridListHeight then
        gridList:setBounceEnabled(false)
        gridList:setScrollBarEnabled(false)
    end
end

function PetReincarnationInfoTableView:updateSkillList(data)
    self.infoData = data
    self:skillListInit()
end

function PetReincarnationInfoTableView:expendMaterialsShow(nowConfig)
    -- 突破使用的材料
    local goodsData = GoodsDataManager:createLocalGoodsData(tonumber(nowConfig.ItemId))
    goodsData:setIsNew(false)
    goodsData.isHaveGet = false
    goodsData:setNum(nowConfig.ItemNum)
    local goodsGrid = UI.GoodsGrid:create()
    goodsGrid:center(20, 100)
    goodsGrid:init(goodsData)
    goodsGrid:showInfoArea(false, false)
    self.bookList:addChild(goodsGrid)

    local select  = UI.Animation:create()
    select:init("effect_ui_gaming_itemselect.json", "effect_ui_gaming_itemselect.atlas")
    select:center()
    select:setName("Select")
    select:setAnimation("start_square", false)
    select:addAnimation("loop_square", true)
    --select:hide()
    goodsGrid:addChild(select, 10)
end

function PetReincarnationInfoTableView:cellClickCallback(bagGrid)
end

function PetReincarnationInfoTableView:bindModel()

end


function PetReincarnationInfoTableView:unbindModel()

end





return PetReincarnationInfoTableView












