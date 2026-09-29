------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2023/04/25
--desc	: 
------------------------------------------------------------------------------
require "app.ui.common.List.ListView"
require "app.ui.common.GridList.GridList"
local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local UseMoldView = class("UseMoldView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
    "ui_town_rune_mold.plist",
    "ui_town_gem.plist",
    "ui_town_fisihing.plist",
}

local COM_WIDTH = 341
local COM_HEIGHT = 632

function UseMoldView:ctor()
    UseMoldView.super.ctor(
    	self,
    	UI.Type.USE_MOLD,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self._isDraging = false
    self:bindModel()
end

function UseMoldView:init( ... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.usemold", "UseMold", false)
    UseMoldView.super.init(self, ... )
end

function UseMoldView:dtor()
    UseMoldView.super.dtor(self)
    self:unbindModel()
    reload_script_file_mvc("app.modules.usemold.UseMoldView")
end


function UseMoldView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    -- contentLayout:enableDebugDraw()
    self.contentLayout = contentLayout

    local bg = UI.Image:create()
    bg:init("ui_gem_bg.png")
    bg:center()
    contentLayout:addChild(bg)

    local bottomPic = UI.Image:create()
    bottomPic:init("ui_mold_paper.png")
    bottomPic:center()
    bg:addChild(bottomPic)

    local titleText = UI.Text:create()
    titleText:init(UI.TEXT_224707, UI.FONT_BOLD, UI.FONT_SIZE_20PX, UI.FONT_COLOR_41_41_45)
    titleText:centerUp(80)
    contentLayout:addChild(titleText, 101)

    local bottomFrame = UI.Image:create()
    bottomFrame:init("ui_mold_btn_3.png")
    bottomFrame:centerBottom(25)
    contentLayout:addChild(bottomFrame)

    local dragDes = UI.Text:create()
    dragDes:init(UI.TEXT_224709, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    dragDes:centerBottom(30)
    contentLayout:addChild(dragDes, 101)

    self:addMoldBoxView()
end

function UseMoldView:addMoldBoxView()
    -- 内容面板
    local moldToolLayout = UI.Layout:create();
    moldToolLayout:init()
    moldToolLayout:setSize(250, 410)
    moldToolLayout:center(0, 20)
    self.contentLayout:addChild(moldToolLayout)
    self.moldToolLayout = moldToolLayout

    local moldBoxConfig = ConfigManager:getAllMoldToolboxData()
    local moldInfo = mvc.runeMoldModel:getMoldInfo()
    local usedMoldData = clone(moldBoxConfig)
    local len = 0
    usedMoldData.len = len
    for k, v in pairs(moldInfo) do
        if v.pos ~= 0 then
            usedMoldData[v.pos].moldInfo = v
            len = len + 1
            usedMoldData.len = len
        end
    end

    local row = table.nums(moldBoxConfig)/2+1
    local gridList = UI.GridList:create()
    gridList:init(mvc.useMoldToolBoxCellView, 2, row, 90, 90, 20, 0, 0)
    gridList:setData(usedMoldData)
    gridList:setSize(250, 410)
    gridList:center()
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

    moldToolLayout:addChild(gridList)

    self:initAttrDetailView(usedMoldData)
end

function UseMoldView:boxDragBeganCallback(grid, touchPosition)
    self._isDraging = true
    if(grid) then
        grid:hideSelect()
    end

end

function UseMoldView:boxDragEndedCallback(grid, touchPosition)
    self._isDraging = false
    if(self.gridList) then
        if(self.gridList:checkTouchPosition(touchPosition) == false) then
            if(grid) then
                local moldGridData = grid:getMoldGridData()
                local gridData = grid:getData()
                Net.NetRoleSystem:reqUseMold(moldGridData.config.id, 2, gridData.id)
            end
        end
    end

end

function UseMoldView:boxCellClickCallback(grid)
    local infoArea =  self.contentLayout:getChildByName("infoArea")
    if infoArea and not tolua.isnull(infoArea) then
        infoArea:close()
    end

    local data = grid:getMoldGridData()
    infoArea = mvc.useMoldInfoAreaView:create(data)
    infoArea:init()
    local width = infoArea:getContentSize().width
    infoArea:centerRight(-width)
    infoArea:setName("infoArea")
    self.contentLayout:addChild(infoArea, 999)
end

function UseMoldView:refreshBag()
    local moldBoxConfig = ConfigManager:getAllMoldToolboxData()
    local moldInfo = mvc.runeMoldModel:getMoldInfo()
    local usedMoldData = clone(moldBoxConfig)
    local len = 0
    usedMoldData.len = len
    for k, v in pairs(moldInfo) do
        if v.pos ~= 0 then
            usedMoldData[v.pos].moldInfo = v
            len = len + 1
            usedMoldData.len = len
        end
    end

    self.gridList:setData(usedMoldData)
    self.gridList:updateView()

    local attrDetailView = self.contentLayout:getChildByName("attrDetailView")
    if attrDetailView and not tolua.isnull(attrDetailView) then
        if usedMoldData.len > 0 then
            attrDetailView:setVisible(true)
            attrDetailView:initMoldAttrView()
        else
            attrDetailView:setVisible(false)
        end
    end
end

function UseMoldView:initAttrDetailView(usedMoldData)
    local attrDetailView = self.contentLayout:getChildByName("attrDetailView")
    if attrDetailView then
        attrDetailView:removeFromParent()
        attrDetailView = nil
    end
    attrDetailView = mvc.useMoldAttrDetailView:create()
    attrDetailView:init()
    attrDetailView:centerRight(-372)
    attrDetailView:setName("attrDetailView")
    self.contentLayout:addChild(attrDetailView, 1)
    attrDetailView:setVisible(usedMoldData.len > 0)
end

function UseMoldView:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_USE_MOLD_REFRSH_BAG, self, self.refreshBag)
end


function UseMoldView:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_USE_MOLD_REFRSH_BAG, self, self.refreshBag)
end





return UseMoldView












