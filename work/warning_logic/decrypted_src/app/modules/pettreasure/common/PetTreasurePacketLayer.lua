------------------------------------------------------------------------------
--author: hongyi.yan
--date	: 2020/04/26
--desc	: 
------------------------------------------------------------------------------

local LanguageManager = require "app.game.LanguageManager"
local languageManagerInstance = LanguageManager:getInstance()
local PetTreasurePacketLayer = class("PetTreasurePacketLayer", UI.HWBtnComponent)

require "app.modules.pet.PetBriefInfoView"

-- 资源
local COM_RES_LIST = {
    "ui_package_pets.plist",
    "ui_common_information.plist",
}

local COM_WIDTH = 420
local COM_HEIGHT = 510

function PetTreasurePacketLayer:ctor()
    PetTreasurePacketLayer.super.ctor(
    	self,
    	UI.Type.TIPS,
        COM_RES_LIST,
        COM_WIDTH,
        COM_HEIGHT
    )
    self:bindModel()

end

function PetTreasurePacketLayer:init(petsArr, eventName)

    self.petsArr = clone(petsArr)
    self.eventName = eventName

    self._layoutUU = UIUtil:createAutoEdit(self, "app.modules.pettreasure", "PetTreasure", false)
    PetTreasurePacketLayer.super.init(self)
end

function PetTreasurePacketLayer:dtor()
    PetTreasurePacketLayer.super.dtor(self)
    self:unbindModel()

    reload_script_file_mvc("app.modules.pettreasure.common.PetTreasurePacketLayer")
end

function PetTreasurePacketLayer:updateByData(petsArr, eventName)
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

function PetTreasurePacketLayer:onInitView()

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
    petList:setCallbackForGridClick(self, self.cellClickCallback)
    petList:setCallbackForGridDragBegan(self, self.dragBeganCallback)
    petList:setCallbackForGridDragMoved(self, self.dragMovedCallback)
    petList:setCallbackForGridDragEnded(self, self.dragEndedCallback)
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

function PetTreasurePacketLayer:cellClickCallback(cell, touchPosition)
    local cellData = cell:getData()
    if not cell:isUsed() then
        return
    end

    if not self._isDraging then
        self:showPetBriefInfo(cellData:getId())
    end
end

function PetTreasurePacketLayer:dragBeganCallback(cell, touchPosition)
    self:hidePetBriefInfo()
    self._isDraging = true
end

function PetTreasurePacketLayer:dragEndedCallback(cell, touchPosition)
    self._isDraging = false

    if not cell then
        return
    end

    self:cellClickCallback(cell)

    local data = {}
    data.cell = cell
    data.touchPosition = touchPosition
    data.eventName = self.eventName

    mvc.send("PetTreasure_Packet_Item_Touch", "GridDragEnded", data)

    self:hidePetBriefInfo()
end

function PetTreasurePacketLayer:showPetBriefInfo(petID, leftShow, tipRevert)
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

function PetTreasurePacketLayer:hidePetBriefInfo()
    local infoLayer = self:getChildByName("BriefInfo")
    if infoLayer then
        -- self.briefInfo:setVisible(false)
        self.briefInfo:removeFromParent()
    end
end

function PetTreasurePacketLayer:set()

end

function PetTreasurePacketLayer:bindModel()

end

function PetTreasurePacketLayer:unbindModel()

end

return PetTreasurePacketLayer












