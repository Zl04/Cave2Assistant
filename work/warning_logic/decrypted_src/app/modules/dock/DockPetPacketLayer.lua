------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/26
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local DockPetPacketLayer = class("DockPetPacketLayer", UI.HWBtnComponent)

require "app.modules.pet.PetBriefInfoView"

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_common_information.plist",
}

local COM_WIDTH = 420
local COM_HEIGHT = 510

function DockPetPacketLayer:ctor()
    DockPetPacketLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function DockPetPacketLayer:init(petsArr, eventName)

    self.petsArr = clone(petsArr)
    self.eventName = eventName

    -- self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.dock", "Dock", false)
    DockPetPacketLayer.super.init(self)
end

function DockPetPacketLayer:dtor()
    DockPetPacketLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.dock.DockPetPacketLayer")
end

function DockPetPacketLayer:updateByData(petsArr, eventName)
    -- printError("petsArr", eventName)
    -- dump("petsArr", petsArr)
    print("petsArr", #petsArr)
    if eventName then
        self.eventName = eventName
    end

    local petData = {}
    petData.petsArr = petsArr
    petData.packetMinShowGridNum = 20
    self.petList:setData(petData)

    local scrollToCellIndex = 0
    for k, v in ipairs(petData.petsArr) do
        if v:isFight() then
            scrollToCellIndex = math.ceil(k/4)
        end
    end
    self.petList:scrollToCell(scrollToCellIndex, 3)
end

function DockPetPacketLayer:onInitView()

    -- 内容面板
    local contentLayout = UI.Layout:create();
    contentLayout:init()
    contentLayout:setSize(COM_WIDTH, COM_HEIGHT)
    contentLayout:center()
    -- contentLayout:enableDebugDraw()
    self:addChild(contentLayout)
    self.contentLayout = contentLayout

    local bg  = UI.Image:create()
    bg:init("ui_pettreasure_lineup_bg.png")
    bg:center()
    self.contentLayout:addChild(bg)

    local scrollBg  = UI.Image:create()
    scrollBg:init("ui_pets_merge_bg.png")
    scrollBg:center()
    self.contentLayout:addChild(scrollBg)

    local titleTxt = UI.Text:create()
    titleTxt:init(UI.TEXT_1213680, UI.FONT_BOLD, UI.FONT_SIZE_18PX, UI.FONT_COLOR_202_168_128)
    titleTxt:setWidth(300)
    titleTxt:setTextCenter()
    titleTxt:autoAdapt()
    titleTxt:leftUp(58, 20)
    self.contentLayout:addChild(titleTxt)

    local petData = {}
    petData.petsArr = self.petsArr
    petData.packetMinShowGridNum = 20

    local petList = UI.PetList:create(4)
    self.petList = petList
    petList:init(petData)
    petList:center(0, 20)
    -- petList:setCallbackForGridClick(self, self.cellClickCallback)
    petList:setCallbackForGridDragBegan(self, self.dragBeganCallback)
    petList:setCallbackForGridDragMoved(self, self.dragMovedCallback)
    petList:setCallbackForGridDragEnded(self, self.dragEndedCallback)
    petList:setCallbackForGridDoubleClick(self, self.cellDoubleClickCallBack)
    petList:enableDoubleClick()
    self.contentLayout:addChild(petList, 2)
    petList:showMask()

    local scrollToCellIndex = 0
    for k, v in ipairs(petData.petsArr) do
        if v:isFight() then
            scrollToCellIndex = math.ceil(k/4)
        end
    end
    self.petList:scrollToCell(scrollToCellIndex, 3)

end

function DockPetPacketLayer:cellClickCallback(cell, touchPosition)
    local cellData = cell:getData()
    if not cell:isUsed() then
        return
    end

    if not self._isDraging then
        self:showPetBriefInfo(cellData:getId())
    end
end

function DockPetPacketLayer:dragBeganCallback(cell, touchPosition)
    self:hidePetBriefInfo()
    self._isDraging = true
end

function DockPetPacketLayer:dragEndedCallback(cell, touchPosition)
    self._isDraging = false

    if not cell then
        return
    end

    local data = cell:getData()
    if mvc.dockModel:checkPetCanSail(data:getId()) then
        UI.ScrollBar:createByText(UI.TEXT_221931)
        return
    end

    self:cellClickCallback(cell)

    local data = {}
    data.cell = cell
    data.touchPosition = touchPosition
    data.eventName = self.eventName

    mvc.send("Dock_Packet_Item_Drag", "GridDragEnded", data)

    self:hidePetBriefInfo()
end

function DockPetPacketLayer:cellDoubleClickCallBack(cell)
    local cellData = cell:getData()
    if not cell:isUsed() then
        return
    end

    local data = cell:getData()
    if not self._isDraging then
        if mvc.dockModel:checkPetCanSail(data:getId()) then
            UI.ScrollBar:createByText(UI.TEXT_221931)
            return
        end
        mvc.send("Dock_Pet_Packet_Double_Click", data)
    end
end

function DockPetPacketLayer:showPetBriefInfo(petID, leftShow, tipRevert)
    if self:getChildByName("BriefInfo") then
        local briefInfo = self:getChildByName("BriefInfo")
        if leftShow then
            briefInfo:leftBottom(-400, 30)
        else
            briefInfo:rightBottom(-400, 30)
        end
        briefInfo:updateToShow(petID, tipRevert)

        briefInfo:setVisible(true)
        return
    end

    local briefInfo = UI.PetBriefInfoView:create()
    briefInfo:init(petID, tipRevert)
    if leftShow then
        briefInfo:leftBottom(-400, 30)
    else
        briefInfo:rightBottom(-400, 30)
    end
    briefInfo:setName("BriefInfo")
    self:addChild(briefInfo, 100);
    self.briefInfo = briefInfo

    briefInfo:addEventListener(UIEvent.COMPONENT_TOUCH_OUTSIDE, self, function(self, touchPosition)
        -- self.briefInfo:setVisible(false)
        self:hidePetBriefInfo()
    end)
end

function DockPetPacketLayer:hidePetBriefInfo()
    local infoLayer = self:getChildByName("BriefInfo")
    if infoLayer then
        -- self.briefInfo:setVisible(false)
        self.briefInfo:removeFromParent()
    end
end

function DockPetPacketLayer:set()

end

function DockPetPacketLayer:bindModel()

end

function DockPetPacketLayer:unbindModel()

end

return DockPetPacketLayer












