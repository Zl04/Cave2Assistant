------------------------------------------------------------------------------
--author: junhao.deng
--date	: 2022/07/13
--desc	: 
------------------------------------------------------------------------------
require "app.modules.pet.PetMainListCell"

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DockSeamanCellView = class("DockSeamanCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 80
local COM_HEIGHT = 80

function DockSeamanCellView:ctor()
    DockSeamanCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.petData = nil
    self.index = nil
    self:bindModel()
end

function DockSeamanCellView:init( idx, ... )
    -- self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.dock", "Dock", false)
    self.index = idx
    DockSeamanCellView.super.init(self, ... )
end

function DockSeamanCellView:dtor()
    DockSeamanCellView.super.dtor(self)
    self:unbindModel()
    self.petData = nil
    self.index = nil
    reload_script_file_mvc("app.modules.dock.DockSeamanCellView")
end


function DockSeamanCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    local bg  = UI.Image:create()
    bg:init("ui_navigation_box_1.png")
    bg:center()
    contentLayout:addChild(bg)
    self.bg = bg

    -- des图片
    local desBg  = UI.Image:create()
    desBg:init("ui_navigation_bg_3.png")
    desBg:centerUp(-27)
    contentLayout:addChild(desBg, 301)
    self.desBg = desBg

    -- des图片
    local attrImag  = UI.Image:create()
    attrImag:init("ui_navigation_btn_speed.png")
    attrImag:centerLeft()
    desBg:addChild(attrImag, 1)
    self.attrImag = attrImag

    local gainsText = UI.Text:create()
    gainsText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_128_201_36)
    gainsText:center(10)
    desBg:addChild(gainsText, 2)
    self.gainsText = gainsText
    self.desBg:hide()

    self:initPetCell()
end

-- function DockSeamanCellView:setPetData(data)
--     self.petData = data
-- end

function DockSeamanCellView:initPetCell()
    local embattlePets = mvc.dockModel:getEmbattlePets()
    if table.nums(embattlePets) <= 0 then
        return
    end
    if embattlePets[self.index] then
        self:addPetCell(embattlePets[self.index])
    end
end

function DockSeamanCellView:addPetCell(petData)
    local TargetSlot1 = self.contentLayout:getChildByName("TargetSlot")
    if TargetSlot1 then 
        TargetSlot1:removeFromParent()
    end
    local targetPet = UI.PetMainListCell:create()
    targetPet:init(nil, true, true, true, petData)
    targetPet:center()
    targetPet:setName("TargetSlot")
    self.contentLayout:addChild(targetPet, 300)
    self.targetPet = targetPet
    -- targetPet:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onPetIconTouchMove)
    targetPet:addEventListener(UIEvent.COMPONENT_DOUBLE_CLICK, self, self.onPetIconTouchEnd)
    self:updateAttrView(petData, true)
end

function DockSeamanCellView:onPetIconTouchMove(cell, touchPosition)
    -- if not self.canDragItem then
    --     return
    -- end

    if cell:isVisible() then
        cell:hide()
    end

    local data = {}
    data.cell = cell
    data.touchPosition = touchPosition
    data.eventName = self.eventName

    mvc.send("Dock_Seaman_Drag_Move", UIEvent.COMPONENT_TOUCH_MOVED, data)
end

function DockSeamanCellView:onPetIconTouchEnd(cell, touchPosition)
    -- if not self.canDragItem then
    --     return
    -- end

    local data = cell:getData()
    local index = 0
    mvc.dockModel:setEmbattlePets(self.index, nil)

    local TargetSlot = self.contentLayout:getChildByName("TargetSlot")
    TargetSlot:removeFromParent()
    TargetSlot = nil

    local data = {}
    data.cell = cell
    data.touchPosition = touchPosition
    data.eventName = self.eventName

    mvc.send("Dock_Seaman_Drag_Move", UIEvent.COMPONENT_DOUBLE_CLICK, data)
    self:updateAttrView(nil, false)
end

function DockSeamanCellView:slotDragEnd(petData, touchPosition)
    local isEnd = false
    local pos = self.contentLayout:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    local size = self.contentLayout:getContentSize()
    local rect = cc.rect(0, 0, size.width, size.height)
    if cc.rectContainsPoint(rect, pos) then
        isEnd = true
        self:addPetCell(petData)
    end
    return isEnd
end

function DockSeamanCellView:doubleClickedEnd(petData, k)
    self:addPetCell(petData)
    mvc.dockModel:setEmbattlePets(k, petData)
end

function DockSeamanCellView:updateAttrView(petData,isShow)
    self.desBg:setVisible(isShow)
    local gains = 0
    if isShow then
        gains = mvc.dockModel:calculatePetGains(petData)
        self.gainsText:setText(string.format(UI.TEXT_221935, gains))
    end
    local data = {
        index = self.index,
        gains = gains
    }
    mvc.dockModel:setAttrGains(data, 1)
    mvc.send(mvc.events.Update_Dock_Detail)
end

function DockSeamanCellView:bindModel()

end


function DockSeamanCellView:unbindModel()

end





return DockSeamanCellView












