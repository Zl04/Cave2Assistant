------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/07/12
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DockSeamanLayer = class("DockSeamanLayer", UI.HWBtnComponent)

UI = UI or {}

UI.DockSeamanLayer = DockSeamanLayer

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 426
local COM_HEIGHT = 80

local CELL_WIDTH = 95
local CELL_HEIGHT = 140

function DockSeamanLayer:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH, self, self.switchClick)
end

function DockSeamanLayer:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH, self, self.switchClick)
end

function DockSeamanLayer:ctor()
    DockSeamanLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.switchBtnState = nil
    self.cellList = {}
    self:bindModel()
end

function DockSeamanLayer:init( ... )
    DockSeamanLayer.super.init(self, ... )
    self.isEmbattling = false
end

function DockSeamanLayer:dtor()
    DockSeamanLayer.super.dtor(self)
    self:unbindModel()
    self.isEmbattling = false
    self.switchBtnState = nil
    self.cellList = {}
    reload_script_file_mvc("app.modules.dock.DockSeamanLayer")
end

function DockSeamanLayer:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout
    -- contentLayout:enableDebugDraw()

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_navigation_btnbg_2.png")
    bg:center()
    contentLayout:addChild(bg)


    local switchBtnClose = UI.Button:create()
    switchBtnClose:init("ui_navigation_btn_configure_2.png", "ui_navigation_btn_configure_2.png")
    -- local w, h = switchBtnClose:getSize()
    switchBtnClose:centerLeft(-20)
    switchBtnClose:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    switchBtnClose:setText(UI.TEXT_221916)
    switchBtnClose:setTextWidth(50)
    switchBtnClose:setTextOffset(-2, 0)
    switchBtnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    contentLayout:addChild(switchBtnClose)
    switchBtnClose:closeClickScale()
    self.switchBtnClose = switchBtnClose
    self.switchBtnClose:hide()

    local switchBtnOpen = UI.Button:create()
    switchBtnOpen:init("ui_navigation_btn_configure.png", "ui_navigation_btn_configure.png")
    -- local w, h = switchBtnOpen:getSize()
    switchBtnOpen:centerLeft(-20)
    switchBtnOpen:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    switchBtnOpen:setText(UI.TEXT_221916)
    switchBtnOpen:setTextWidth(50)
    switchBtnOpen:setTextOffset(13, 0)
    switchBtnOpen:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    contentLayout:addChild(switchBtnOpen)
    switchBtnOpen:closeClickScale()
    self.switchBtnOpen = switchBtnOpen
    self.switchBtnOpen:hide()

    self:updateSwitchBtnShow()
    self:addSeamanNode()
end

function DockSeamanLayer:addSeamanNode()
    self.boatData = {}
    -- self.boatData.ID = 23290001
    -- local boatConfig = ConfigManager:getAllBoatDataByID(self.boatData.ID)
    local boatConfig = mvc.dockModel:getCurBoatConfig()
    if not boatConfig then
        return
    end
    local width = CELL_WIDTH*4
    local tableview = UI.TableView.new({}, width, CELL_HEIGHT)
    tableview:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    tableview:center(34, 0)
    tableview:setDelegate()
    tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableview:init()
    tableview:setBounceable(true);
    tableview:onUpdateCellSize(function (table,idx)
        return CELL_WIDTH+10, CELL_HEIGHT;
    end);
    -- tableview:setBounceable(false)
    -- tableview:enableDebugDraw()
    tableview:onUpdateCells(function (table, idx)
        local cell = table:dequeueCell()
        local index = idx + 1
        if not cell then
            xpcall(function()
                cell = self:createSeamanCell(index)
            end,
            function(e)
                printError("------------------------DockSailLayer:tableCellAtIndex-----------------error")
            end, 1)
        else
            cell:removeFromParent()
            cell = self:createSeamanCell(index)
        end

        self.cellList[index] = cell
        return cell;
    end);
    
    -- tableview:onTableCellTouched(function(table, cell)
    --     local index = cell:getIdx() + 1
    --     self:tabCellClick(cell, functionArr[index])
    -- end)

    tableview:onUpdateCellNumbers(function ()
        return boatConfig.cabinNum
    end);

    self.tableview = tableview
    self.contentLayout:addChild(tableview, 100)
    tableview:reloadData(true)
end

function DockSeamanLayer:createSeamanCell(index)
    local cell = UI.TableViewCell:create()
    cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))

    local seamanCell = mvc.dockSeamanCellView:create()
    seamanCell:init(index)
    seamanCell:center(5, 0)
    seamanCell:setName("seamanCell")
    cell:addChild(seamanCell)

    return cell
end

function DockSeamanLayer:switchClick()
    if self.switchBtnState == 1 then
        self.switchBtnState = 0

        self:stopAllActions()

        self.runActioning = true
        self:runAction(cc.Sequence:create(
            cc.MoveTo:create(0.1, cc.p(656,90)),
            cc.CallFunc:create(function()
                self.runActioning = false
                self:updateSwitchBtnShow()
            end))
        )

    else
        self.switchBtnState = 1

        self:stopAllActions()

        self.runActioning = true
        self:runAction(cc.Sequence:create(
            cc.MoveTo:create(0.1, cc.p(COM_WIDTH-130,90)),
            cc.CallFunc:create(function()
                self.runActioning = false
                self:updateSwitchBtnShow()
            end))
        )
        
    end
    mvc.send(mvc.events.Dock_Show_Pet_Packet)
end

function DockSeamanLayer:updateSwitchBtnShow()
    if self.switchBtnState == 1 then
        local w = self.switchBtnClose:getSize()
        self.switchBtnClose:centerLeft(-20)
        -- self.contentLayout:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)

        self.switchBtnClose:show()
        self.switchBtnOpen:hide()
    else
        local w = self.switchBtnOpen:getSize()
        self.switchBtnOpen:centerLeft(-20)
        -- self.contentLayout:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)

        self.switchBtnClose:hide()
        self.switchBtnOpen:show()
    end
end

function DockSeamanLayer:slotDragEnd(petData, touchPosition)

    -- local seatLayout = self.contentLayout:getChildByName("workersSeatLayout")
    -- local seatBg = seatLayout:getChildByName("seatBg")
    local pos = self.tableview:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    local size = self.tableview:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        -- 派遣状态下
        -- if mvc.petTreasureModel:getIsGathering() then
        --     local gatherPets = mvc.petTreasureModel:getWorkersData()
        --     for _, v in pairs(gatherPets) do
        --         if v:getId() == petData:getId() then
        --             UI.ScrollBar:createByText(UI.TEXT_221105)
        --             return
        --         end
        --     end
        -- end
        self:addCenterPet(petData, touchPosition)
    end
end

function DockSeamanLayer:doubleClickedEnd(petData)
    self:addCenterPetByDoubleClick(petData)
end

function DockSeamanLayer:addCenterPet(petData, touchPosition)
    local boatConfig = mvc.dockModel:getCurBoatConfig()
    for k, cell in pairs(self.cellList) do
        if cell then
            local seamanCell = cell:getChildByName("seamanCell")
            if seamanCell and seamanCell:slotDragEnd(petData, touchPosition) then
                mvc.dockModel:setEmbattlePets(k, petData)
                break
            end
        end
    end
end

function DockSeamanLayer:addCenterPetByDoubleClick(petData)
    local boatConfig = mvc.dockModel:getCurBoatConfig()
    local embattlePets = mvc.dockModel:getEmbattlePets()
    for k, cell in pairs(self.cellList) do
        local seamanCell = cell:getChildByName("seamanCell")
        if seamanCell and not embattlePets[k] then
            seamanCell:doubleClickedEnd(petData, k)
            return
        end
    end
    UI.ScrollBar:createByText(UI.TEXT_221934)
end



-- function DockSeamanLayer:initSailDetail()

--     self:createUpgradeLayer()

-- end


return DockSeamanLayer












