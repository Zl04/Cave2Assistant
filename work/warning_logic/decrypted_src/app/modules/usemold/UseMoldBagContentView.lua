------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: 
------------------------------------------------------------------------------
require "app.ui.common.List.ListView"
require "app.ui.common.GridList.GridList"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local UseMoldBagContentView = class("UseMoldBagContentView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_rune_mold.plist",
}

local COM_WIDTH = 348
local COM_HEIGHT = 491

function UseMoldBagContentView:ctor()
    UseMoldBagContentView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.dataList = {}
    self._isDraging = false
    self:bindModel()
end

function UseMoldBagContentView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.usemold", "UseMold", false)
    UseMoldBagContentView.super.init(self, ... )
end

function UseMoldBagContentView:dtor()
    UseMoldBagContentView.super.dtor(self)
    self:unbindModel()
    self.dataList = {}
    reload_script_file_mvc("app.modules.usemold.UseMoldBagContentView")
end


function UseMoldBagContentView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    -- contentLayout:enableDebugDraw()
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_mold_paper_2.png")
    bg:center()
    contentLayout:addChild(bg)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_224708, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(10)
    contentLayout:addChild(titleText, 101)

    self:initMoldListView()
end

function UseMoldBagContentView:initMoldListView()
    local moldConfig = ConfigManager:getAllMoldForgingData()
    local row = table.nums(moldConfig)/2
    local moldInfo = mvc.runeMoldModel:getMoldInfo()
    local usedMoldData = mvc.useMoldModel:getUseMoldData()--{}

    local gridList = UI.GridList:create()
    gridList:init(mvc.useMoldBagBoxCellView, 4, row, 80, 80, 0, 0, 0)
    gridList:setData(usedMoldData)
    gridList:setSize(335, 370)
    gridList:leftUp(5, 55)
    -- gridList:enableToDragGrid()
    gridList:setCallbackForGridDragBegan(self, self.boxDragBeganCallback)
    -- gridList:setCallbackForGridDragMoved(self, self.boxDragMovedCallback)
    gridList:setCallbackForGridDragEnded(self, self.boxDragEndedCallback)
    gridList:setCallbackForGridClick(self, self.boxCellClickCallback)
    gridList:setScrollBarEnabled(true)
    gridList:setScrollBarWidth(5)
    gridList:setScrollBarColor(UI.SLIDER_COLOR_Dark)
    gridList:setCircleVisible(false)
    -- gridList:enableDebugDraw()

    self.gridList = gridList

    self.contentLayout:addChild(gridList)
end

function UseMoldBagContentView:boxDragBeganCallback(grid, touchPosition)
    self._isDraging = true
    if(grid) then
        grid:hideSelect()
    end
    -- if(self._bagGridList) then
    --     self._bagGridList:showMove()
    -- end
    -- -- self.dragSpine:setVisible(true)
    -- self._bagGridList:setSpineBgVisible(true)
end

function UseMoldBagContentView:boxDragEndedCallback(grid, touchPosition)
    self._isDraging = false
    if(self.gridList) then
        if(self.gridList:checkTouchPosition(touchPosition) == false) then
            if(grid) then
                Avalon.MessageCenter:notice(AvalonMessage.MC_USE_MOLD_DRAGE_END, grid, touchPosition)
                
            end
        end
    end
    
end

function UseMoldBagContentView:boxCellClickCallback(grid)
    local infoArea =  self.contentLayout:getChildByName("infoArea")
    if infoArea and not tolua.isnull(infoArea) then
        infoArea:close()
    end

    local data = grid:getData()
    infoArea = mvc.useMoldInfoAreaView:create(data)
    infoArea:init()
    local width = infoArea:getContentSize().width
    infoArea:centerLeft(-width)
    infoArea:setName("infoArea")
    self.contentLayout:addChild(infoArea, 999)
end

function UseMoldBagContentView:refreshBag()
    local usedMoldData = mvc.useMoldModel:getUseMoldData()
    self.gridList:setData(usedMoldData)
    self.gridList:updateView()
end

function UseMoldBagContentView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_USE_MOLD_REFRSH_BAG, self, self.refreshBag)
end


function UseMoldBagContentView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_USE_MOLD_REFRSH_BAG, self, self.refreshBag)

end





return UseMoldBagContentView












