------------------------------------------------------------------------------
--author: siyu.lin
--date	: 2023/06/19
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local BigSailPortSeamanCellView = class("BigSailPortSeamanCellView", UI.HWBtnComponent)

-- 资源
local COM_RES_LIST = {
}

local COM_WIDTH = 80
local COM_HEIGHT = 80

function BigSailPortSeamanCellView:ctor()
    BigSailPortSeamanCellView.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self.petData = nil
    self.index = nil
    self.newestPets = nil -- 最新的船员宠物信息
    self:bindModel()
end

function BigSailPortSeamanCellView:init( idx, boatId,... )
    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.bigsailport", "BigSailPort", false)
    self.index = idx
    self.boatId = boatId
    self.baseData = mvc.bigSailPortModel:getBaseData()
    BigSailPortSeamanCellView.super.init(self, ... )
end

function BigSailPortSeamanCellView:dtor()
    BigSailPortSeamanCellView.super.dtor(self)
    self:unbindModel()
    self.petData = nil
    self.index = nil
    reload_script_file_mvc("app.modules.bigsailport.BigSailPortSeamanCellView")
end


function BigSailPortSeamanCellView:onInitView()
    -- 内容面板
    local contentLayout = UI.Layout:create()
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    -- 背景图片
    -- local bg  = UI.Image:create()
    -- bg:init("ui_navigation_box_1.png")
    -- bg:center()
    -- contentLayout:addChild(bg)
    -- self.bg = bg

    -- -- des图片
    -- local desBg  = UI.Image:create()
    -- desBg:init("ui_navigation_bg_3.png")
    -- desBg:centerUp(-27)
    -- contentLayout:addChild(desBg, 301)
    -- self.desBg = desBg

    -- -- des图片
    -- local attrImag  = UI.Image:create()
    -- attrImag:init("ui_navigation_btn_speed.png")
    -- attrImag:centerLeft(10)
    -- desBg:addChild(attrImag, 1)
    -- self.attrImag = attrImag

    -- local gainsText = UI.Text:create()
    -- gainsText:init("", UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_128_201_36)
    -- gainsText:center(10)
    -- desBg:addChild(gainsText, 2)
    -- self.gainsText = gainsText
    -- self.desBg:hide()

    self:initPetCell()
end

function BigSailPortSeamanCellView:initPetCell()
    local embattlePets = mvc.bigSailPortModel:getPetsOfBoatId(self.boatId)
    if not embattlePets or table.nums(embattlePets) <= 0 then
        return
    end
    if embattlePets[self.index] then
        self:addPetCell(embattlePets[self.index])
    end
end

function BigSailPortSeamanCellView:addPetCell(petData)
    local TargetSlot1 = self.contentLayout:getChildByName("TargetSlot")
    if TargetSlot1 then 
        TargetSlot1:removeFromParent()
    end
    local targetPet = UI.PetMainListCell:create()
    targetPet:init(nil, true, true, true, petData)
    targetPet:center(-1,-1)
    targetPet:setName("TargetSlot")
    self.contentLayout:addChild(targetPet, 300)
    self.targetPet = targetPet
    --targetPet:addEventListener(UIEvent.COMPONENT_TOUCH_MOVED, self, self.onPetIconTouchMove)
    targetPet:addEventListener(UIEvent.COMPONENT_TOUCH_ENDED, self, self.onPetIconTouchEnd)
    self:updateAttrView(petData, true)
end

function BigSailPortSeamanCellView:onPetIconTouchMove(cell, touchPosition)
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

    --mvc.send("Dock_Seaman_Drag_Move", UIEvent.COMPONENT_TOUCH_MOVED, data)
end

function BigSailPortSeamanCellView:onPetIconTouchEnd(cell, touchPosition)
    -- if not self.canDragItem then
    --     return
    -- end


    mvc.bigSailPortModel:setEmbattlePets(self.index, nil)

    local TargetSlot = self.contentLayout:getChildByName("TargetSlot")
    TargetSlot:removeFromParent()
    TargetSlot = nil


    --mvc.send("Dock_Seaman_Drag_Move", UIEvent.COMPONENT_DOUBLE_CLICK, data)
    self:updateAttrView(nil, false)

    Avalon.MessageCenter:notice(AvalonMessage.MC_UI_PORT_SYNC_REFRESH_BAG_PETS, {})

end

function BigSailPortSeamanCellView:slotDragEnd(petData, touchPosition)
    local isEnd = true
    -- local pos = self.contentLayout:convertToNodeSpace(cc.p(touchPosition.x, touchPosition.y))
    -- local size = self.contentLayout:getContentSize()
    -- local rect = cc.rect(0, 0, size.width, size.height)
    -- if cc.rectContainsPoint(rect, pos) then
    --     isEnd = true
    --     print(debug.traceback("slotDragEnd311"))
    --     self:addPetCell(petData)
    -- end
    self:addPetCell(petData)

    return isEnd
end

function BigSailPortSeamanCellView:doubleClickedEnd(petData, k)
    self:addPetCell(petData)
    mvc.bigSailPortModel:setEmbattlePets(k, petData)
end

function BigSailPortSeamanCellView:updateAttrView(petData,isShow)
    --self.desBg:setVisible(isShow)
    local gains = 0


    self.petData = petData


    -- local data = {}
    -- local pets = {}
    -- for k,v in pairs(self.baseData.useBoats) do
    --     if v.boatId == self.boatId then
    --         pets = v.pets
    --         pets[self.index] = petData.spriteID
    --     end
    -- end
    -- data.boatId = self.boatId
    -- data.petId = pets
    -- Net.NetBigSailSystem:reqSetBoatPets(data)

    -- self.newestPets = pets

    -- if isShow then
    --     gains = mvc.bigSailPortModel:calculatePetGains(petData)
    --     self.gainsText:setText(string.format(UI.TEXT_221935, gains))
    -- end
    -- local data = {
    --     index = self.index,
    --     gains = gains
    -- }
    -- mvc.bigSailPortModel:setAttrGains(data, 1)
    -- mvc.send(mvc.events.Update_Dock_Detail)
end

function BigSailPortSeamanCellView:successSyncBaseInfo()
    -- for k,v in pairs(self.baseData.useBoats) do
    --     if v.boatId == self.boatId then
    --         -- 设置船员成功后刷新基础信息。
    --         self.baseData.useBoats[k].pets = self.newestPets
    --         mvc.bigSailPortModel:saveBaseData(self.baseData)
    --         -- 提示设置成功
    --         UI.ScrollBar:createByText(UI.TEXT_1213795)
    --     end
    -- end
end

function BigSailPortSeamanCellView:getPetData()
    return self.petData
end

function BigSailPortSeamanCellView:bindModel()
    --Avalon.MessageCenter:bind(AvalonMessage.MC_UI_PORT_SYNC_REFRESH_BASE_BOAT_INFO, self, self.successSyncBaseInfo)
end

function BigSailPortSeamanCellView:unbindModel()
    --Avalon.MessageCenter:unbind(AvalonMessage.MC_UI_PORT_SYNC_REFRESH_BASE_BOAT_INFO, self, self.successSyncBaseInfo)
end

return BigSailPortSeamanCellView
