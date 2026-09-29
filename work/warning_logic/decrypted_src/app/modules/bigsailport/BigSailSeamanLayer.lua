------------------------------------------------------------------------------
--author: Nero.lin
--date	: 
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailSeamanLayer = class("BigSailSeamanLayer", UI.HWBtnComponent)

UI = UI or {}

UI.BigSailSeamanLayer = BigSailSeamanLayer

-- 资源
local COM_RES_LIST = {
    "ui_town_greatnavigation.plist",
}

local COM_WIDTH = 426
local COM_HEIGHT = 80

local CELL_WIDTH = 95
local CELL_HEIGHT = 140

function BigSailSeamanLayer:bindModel()
    Avalon.MessageCenter:bind(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH, self, self.switchClick)
end

function BigSailSeamanLayer:unbindModel()
    Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_SEAMAN_LAYER_SWITCH, self, self.switchClick)
end

function BigSailSeamanLayer:ctor(BoatId)
    BigSailSeamanLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )

    self.switchBtnState = nil
    self.cellList = {}
    self.boatId = BoatId
    self:bindModel()
end

function BigSailSeamanLayer:init( ... )
    BigSailSeamanLayer.super.init(self, ... )
    self.isEmbattling = false
end

function BigSailSeamanLayer:dtor()
    BigSailSeamanLayer.super.dtor(self)
    self:unbindModel()
    self.isEmbattling = false
    self.switchBtnState = nil
    self.cellList = {}
    reload_script_file_mvc("app.modules.bigsailport.BigSailSeamanLayer")
end

function BigSailSeamanLayer:onInitView()

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
    bg:init("ui_greatnavigation_petsbox2.png")
    bg:center()
    contentLayout:addChild(bg)

    local bgPic1 = UI.Image:create()
    bgPic1:init("ui_greatnavigation_petsbox_add.png")
    bgPic1:center(-103, -1)
    self.contentLayout:addChild(bgPic1)

    local bgPic2 = UI.Image:create()
    bgPic2:init("ui_greatnavigation_petsbox_add.png")
    bgPic2:center(1, -1)
    self.contentLayout:addChild(bgPic2)

    local bgPic3 = UI.Image:create()
    bgPic3:init("ui_greatnavigation_petsbox_add.png")
    bgPic3:center(105, -1)
    self.contentLayout:addChild(bgPic3)


    -- local switchBtnClose = UI.Button:create()
    -- switchBtnClose:init("ui_navigation_btn_configure_2.png", "ui_navigation_btn_configure_2.png")
    -- -- local w, h = switchBtnClose:getSize()
    -- switchBtnClose:centerLeft(-20)
    -- switchBtnClose:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    -- switchBtnClose:setText(UI.TEXT_221916)
    -- switchBtnClose:setTextWidth(50)
    -- switchBtnClose:setTextOffset(-2, 0)
    -- switchBtnClose:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    -- contentLayout:addChild(switchBtnClose)
    -- switchBtnClose:closeClickScale()
    -- self.switchBtnClose = switchBtnClose
    -- self.switchBtnClose:hide()

    -- local switchBtnOpen = UI.Button:create()
    -- switchBtnOpen:init("ui_navigation_btn_configure.png", "ui_navigation_btn_configure.png")
    -- -- local w, h = switchBtnOpen:getSize()
    -- switchBtnOpen:centerLeft(-20)
    -- switchBtnOpen:setTextFont(UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_204_204_204)
    -- switchBtnOpen:setText(UI.TEXT_221916)
    -- switchBtnOpen:setTextWidth(50)
    -- switchBtnOpen:setTextOffset(13, 0)
    -- switchBtnOpen:addEventListener(UIEvent.BUTTON_CLICK,self,self.switchClick)
    -- contentLayout:addChild(switchBtnOpen)
    -- switchBtnOpen:closeClickScale()
    -- self.switchBtnOpen = switchBtnOpen
    -- self.switchBtnOpen:hide()

    --self:updateSwitchBtnShow()
    self:addSeamanNode()
end

function BigSailSeamanLayer:addSeamanNode()
    self.boatData = {}
    -- self.boatData.ID = 23290001
    -- local boatConfig = ConfigManager:getAllBoatDataByID(self.boatData.ID)
    local boatConfig = mvc.bigSailPortModel:getCurBoatConfig()
    if not boatConfig then
        return
    end
    local width = CELL_WIDTH*4
    
    for index = 1, boatConfig.cabinNum do
        local cell = self:createSeamanCell(index)
        cell:centerLeft(59 + (index - 1) * 103, -0.5)
        self.cellList[index] = cell
        self.contentLayout:addChild(cell, 100)
    end


    -- local tableview = UI.TableView.new({}, width, CELL_HEIGHT)
    -- tableview:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
    -- tableview:center(34, 0)
    -- tableview:setDelegate()
    -- tableview:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    -- tableview:init()
    -- tableview:setBounceable(false)
    -- tableview:onUpdateCellSize(function (table,idx)
    --     return CELL_WIDTH+10, CELL_HEIGHT;
    -- end);
    -- -- tableview:setBounceable(false)
    -- -- tableview:enableDebugDraw()
    -- tableview:onUpdateCells(function (table, idx)
    --     local cell = table:dequeueCell()
    --     local index = idx + 1
    --     if not cell then
    --         xpcall(function()
    --             print("createSeamanCell===> ：", index)
    --             cell = self:createSeamanCell(index)
    --         end,
    --         function(e)
    --             printError("------------------------DockSailLayer:tableCellAtIndex-----------------error")
    --         end, 1)
    --     else
    --         cell:removeFromParent()
    --         cell = self:createSeamanCell(index)
    --     end

    --     self.cellList[index] = cell
    --     return cell;
    -- end);
    
    -- -- tableview:onTableCellTouched(function(table, cell)
    -- --     local index = cell:getIdx() + 1
    -- --     self:tabCellClick(cell, functionArr[index])
    -- -- end)

    -- tableview:onUpdateCellNumbers(function ()
    --     return boatConfig.cabinNum
    -- end);

    -- self.tableview = tableview
    -- self.contentLayout:addChild(tableview, 100)
    -- tableview:reloadData(true)
end

function BigSailSeamanLayer:createSeamanCell(index)
    -- local cell = UI.TableViewCell:create()

    local cell = UI.Layout:create()
    cell:init()
    cell:setSize(CELL_WIDTH, CELL_HEIGHT)

    -- cell:setContentSize(cc.size(CELL_WIDTH, CELL_HEIGHT))

    local seamanCell = mvc.bigSailPortSeamanCellView:create()
    seamanCell:init(index, self.boatId)
    seamanCell:center(5, 0)
    seamanCell:setName("seamanCell")
    cell:addChild(seamanCell)
    --cell:setScrollBarEnabled(false)

    return cell
end

function BigSailSeamanLayer:getSeamanCellList()
    return self.cellList
end

function BigSailSeamanLayer:switchClick()
    -- if self.switchBtnState == 1 then
    --     self.switchBtnState = 0

    --     self:stopAllActions()

    --     self.runActioning = true
    --     self:runAction(cc.Sequence:create(
    --         cc.MoveTo:create(0.1, cc.p(656,90)),
    --         cc.CallFunc:create(function()
    --             self.runActioning = false
    --             self:updateSwitchBtnShow()
    --         end))
    --     )

    -- else
    --     self.switchBtnState = 1

    --     self:stopAllActions()

    --     self.runActioning = true
    --     self:runAction(cc.Sequence:create(
    --         cc.MoveTo:create(0.1, cc.p(COM_WIDTH-130,90)),
    --         cc.CallFunc:create(function()
    --             self.runActioning = false
    --             self:updateSwitchBtnShow()
    --         end))
    --     )
        
    -- end
    -- mvc.send(mvc.events.Dock_Show_Pet_Packet)
end

function BigSailSeamanLayer:updateSwitchBtnShow()
    -- if self.switchBtnState == 1 then
    --     local w = self.switchBtnClose:getSize()
    --     self.switchBtnClose:centerLeft(-20)
    --     -- self.contentLayout:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)

    --     self.switchBtnClose:show()
    --     self.switchBtnOpen:hide()
    -- else
    --     local w = self.switchBtnOpen:getSize()
    --     self.switchBtnOpen:centerLeft(-20)
    --     -- self.contentLayout:setPosition(self:getContentSize().width / 2, self:getContentSize().height / 2)

    --     self.switchBtnClose:hide()
    --     self.switchBtnOpen:show()
    -- end
end

function BigSailSeamanLayer:slotDragEnd(Data)

    local petData = Data.petData
    local touchPosition = Data.touchPosition
    local isDoubleClick = Data.isDoubleClick
    -- local seatLayout = self.contentLayout:getChildByName("workersSeatLayout")
    -- local seatBg = seatLayout:getChildByName("seatBg")

    -- if isDoubleClick and not touchPosition then
    --     self:addCenterPet(petData, touchPosition)
    --     return
    -- end

    -- local pos = self.tableview:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    -- local size = self.tableview:getContentSize()
    -- local rect = cc.rect(0, 0, size.width, size.height)
    -- if cc.rectContainsPoint(rect, pos) then
    --     self:addCenterPet(petData, touchPosition)
    -- end

    self:addCenterPet(petData)
end

function BigSailSeamanLayer:doubleClickedEnd(petData)
    self:addCenterPetByDoubleClick(petData)
end

function BigSailSeamanLayer:addCenterPet(petData, touchPosition)

    if not self:isAllowPetLimit(petData) then
        local config = ConfigManager:getAllNavigationGeneralConfigData()[1]
        local richTextLayout = string.format(UI.TEXT_226904, config.petLevelLimit).."\n"..string.format(UI.TEXT_226905, config.petPowerLimit)
        local okCallBack = function ()
        end
        UI.TipsLayer:onShowCommonTextHandlerWithJustShowOK(richTextLayout, okCallBack, nil)
        return
    end
    
    local boatConfig = mvc.bigSailPortModel:getCurBoatConfig()
    local isFull = true
    for k, cell in pairs(self.cellList) do
        local ep = mvc.bigSailPortModel:getEmbattlePets()
        if cell and not ep[k] then
            isFull = false
            local seamanCell = cell:getChildByName("seamanCell")
            if seamanCell and seamanCell:slotDragEnd(petData) then
                mvc.bigSailPortModel:setEmbattlePets(k, petData)
                break
            end
        end
    end

    if isFull then
        -- 提示船员配置满了
        UI.ScrollBar:createByText(UI.TEXT_226169)
    end

end

function BigSailSeamanLayer:addCenterPetByDoubleClick(petData)
    local boatConfig = mvc.bigSailPortModel:getCurBoatConfig()
    local embattlePets = mvc.bigSailPortModel:getEmbattlePets()
    for k, cell in pairs(self.cellList) do
        local seamanCell = cell:getChildByName("seamanCell")
        if seamanCell and not embattlePets[k] then
            seamanCell:doubleClickedEnd(petData, k)
            return
        end
    end
    UI.ScrollBar:createByText(UI.TEXT_221934)
end

function BigSailSeamanLayer:isAllowPetLimit(petData)
    -- 宠物是否达到上阵的条件限制
    local config = ConfigManager:getAllNavigationGeneralConfigData()[1]
    if petData:getPower() >= config.petPowerLimit and petData:getLevel() >= config.petLevelLimit then
        return true
    end

    return false
end

return BigSailSeamanLayer












